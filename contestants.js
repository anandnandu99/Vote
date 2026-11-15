// Hardcoded contestants. Edit names here, then put each photo in the images/ folder
// using the file name shown below (square-ish photos work best, JPG or PNG).
// If a photo file is missing, the app shows the person's initial instead.
//
// "id" must be unique, lowercase, no spaces. It is the permanent key in the database,
// so do not change an id after people have started voting.
window.CONTESTANTS = {
  id: "bigg-boss",        // folder id
  folder: "Bigg Boss",    // folder name shown in the app
  votes: 100,             // votes each visitor gets per round
  people: [
    { id: "prajakta", name: "Prajakta", photo: "images/prajakta.jpg" },
    { id: "tanvi",    name: "Tanvi",    photo: "images/tanvi.jpg" },
    { id: "sanket",   name: "Sanket",   photo: "images/sanket.jpg" },
    { id: "deepali",  name: "Deepali",  photo: "images/deepali.jpg" },
    { id: "anushri",  name: "Anushri",  photo: "images/anushri.jpg" },
    { id: "reva",     name: "Reva",     photo: "images/reva.jpg" }
  ]
};
