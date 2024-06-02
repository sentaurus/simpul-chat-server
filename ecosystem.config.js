module.exports = {
	apps: [
		{
			name: 'rails-app',
			script: 'bundle',
			args: 'exec puma -C config/puma.rb',
			interpreter: '/bin/bash',
			cwd: '/home/viapulsa/certbot/simpul-chat-server',
			env: {
				RAILS_ENV: 'production',
				PORT: 8006,
			},
		},
	],
};
