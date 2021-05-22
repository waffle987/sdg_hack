/// Logic to calculate the number of likes from the Likes Map that is retrieved from the firestore database

int getLikeCount(likes) {
  /// If no likes, return 0

  if (likes == null) {
    return 0;
  }
  int count = 0;

  /// If the key is explicitly set to true, add a like

  likes.values.forEach((val) {
    if (val == true) {
      count += 1;
    }
  });
  return count;
}
