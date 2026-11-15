# Vote to Save

A Bigg Boss style voting app with folders, photos and a live leaderboard. Plain HTML, no build step.

## Features
- Folders (e.g. Week 1, Finale), each with its own options, votes and leaderboard
- Add options with a name and photo, or paste many names at once
- Everything you add in the UI is saved straight to the backend database; photos go to Supabase Storage
- Leaderboard refreshes automatically

## Database tables
- `folders`: id, name, vote_limit, round
- `options`: id, folder_id, name, photo_url, total
- Storage bucket `photos`: the image files, referenced by `options.photo_url`
- `add_votes()` function: adds votes atomically so simultaneous voters never overwrite each other

## Setup
1. Create a free project at https://supabase.com.
2. Open **SQL Editor**, paste `supabase.sql`, run it.
3. Open **Project Settings > API**, copy the **Project URL** and the **anon public** key.
4. Paste them into `config.js`.
5. Open `index.html` locally or push to GitHub. The label next to the folder chips shows **Live** when connected.

If `config.js` is left empty, the app runs local-only and saves in the browser.

## Deploy with GitHub Pages
Settings > Pages > Deploy from a branch > `main` and `/ (root)`. Live at `https://<user>.github.io/<repo>/`.

## Security note
The policies in `supabase.sql` let anyone who opens the site add, edit and delete data, including the Manage tab. That is fine for a casual poll. For anything important, add an admin PIN or Supabase Auth. Each visitor's remaining votes are tracked in their own browser.
