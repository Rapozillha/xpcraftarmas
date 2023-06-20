/* Rapozillha */

CREATE TABLE IF NOT EXISTS `user_levels`(
  `id` int(11) NOT NULL,
  `identifier` varchar(255) NOT NULL,
  `crafting` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE `user_levels`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `user_levels`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;