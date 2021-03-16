function update-hosts
         if not test -d ~/src/hosts
            echo "No repo found, cloning ... 🚚"
            git clone https://github.com/StevenBlack/hosts.git ~/src/hosts
            echo "Done ✅"
         end

         cd ~/src/hosts
         echo "Updating hosts ... 🛸"
         git pull
         pip3 install --user -r requirements.txt
         python3 updateHostsFile.py --auto -e fakenews
         rg -v '0.0.0.0|#|^$' hosts
         # cmp --silent hosts /etc/hosts && echo 'Everything is up to date, exiting ✨'; return 1
         # echo "Adding "(diff -I '#*' --suppress-common-lines --speed-large-files -y hosts /etc/hosts | wc -l | tr -d ' \t\n\r')" new lines to /etc/hosts"
         read -l -P 'Do you want to continue? [y/N] ' confirm
         switch $confirm
         case Y y
           sudo cp hosts /etc/hosts
           echo "Success 🌈🦄✨"
           cd
         case '' N n
           echo "Aborting"
         end
end
