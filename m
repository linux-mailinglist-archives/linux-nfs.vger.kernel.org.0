Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9011B1E71C9
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2020 02:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438100AbgE2AxY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 May 2020 20:53:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:43576 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438160AbgE2AxX (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 28 May 2020 20:53:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 56F64AC24;
        Fri, 29 May 2020 00:53:21 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>
Date:   Fri, 29 May 2020 10:53:15 +1000
Subject: nfs4_show_superblock considered harmful :-)
CC:     linux-nfs@vger.kernel.org
Message-ID: <871rn38suc.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain


Hi,
 I've received a report of a 5.3 kernel crashing in
 nfs4_show_superblock().
 I was part way through preparing a patch when I concluded that
 the problem wasn't as straight forward as I thought.

 In the crash, the 'struct file *' passed to nfs4_show_superblock()
 was NULL.
 This file was acquired from find_any_file(), and every other caller
 of find_any_file() checks that the returned value is not NULL (though
 one BUGs if it is NULL - another WARNs).
 But nfs4_show_open() and nfs4_show_lock() don't.
 Maybe they should.  I didn't double check, but I suspect they don't
 hold enough locks to ensure that the files don't get removed.

 Then I noticed that nfs4_show_deleg() accesses fi_deleg_file without
 checking if it is NULL - Should it take fi_lock and make sure it is
 not NULL - and get a counted reference?
 And maybe nfs4_show_layout() has the same problem?

 I could probably have worked my way through fixing all of these, but
 then I discovered that these things are now 'struct nfsd_file *' rather
 than 'struct file *' and that the helpful documentation says:

 *    Note that this object doesn't
 * hold a reference to the inode by itself, so the nf_inode pointer should
 * never be dereferenced, only used for comparison.

 and yet nfs4_show_superblock() contains:

	struct inode *inode = f->nf_inode;

	seq_printf(s, "superblock: \"%02x:%02x:%ld\"",
					MAJOR(inode->i_sb->s_dev),
					 MINOR(inode->i_sb->s_dev),
					 inode->i_ino);

 do you see my problem?

 Is this really safe and the doco wrong? (I note that the use of nf_inode
 in nfsd_file_mark_find_or_create() looks wrong, but is actually safe).
 Or should we check if nf_file is non-NULL and use that?

 In short:
 - We should check find_any_file() return value - correct?
 - Do we need extra locking to stabilize fi_deleg_file?
 - ditto for ->ls_file
 - how can nfs4_show_superblock safely get s_dev and i_ino from a
   nfsd_file?

Thanks,

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl7QXPsACgkQOeye3VZi
gbmR5w/8DkKBxRpmNZeoZy0wwvbUplfyhiQjs3/WbvnLFw/NEDA+mFoyTz6aDNLb
0J6NVqTWv+GMIxhgiE1rDG6/FeWq51oBTj3gOInAlQGg3iB9oYeSYRpSU5Tm+ZHa
ps+z/2d3VN4bh7bWHtH0vS47fKZ0AjUs6MVLU4zgz3C79PiK9qN51b+gPR0byRpx
Z4WuoIt/QVZIuesQ4Xu+hQBmOUh+CfwrmXTIe61CltmdLmroE1ALofvq+pDwaORO
iHOoxjIB4UX6ZCNnt10qLDDYFpseFOTJ72m/UoCLXm0vrqZKqcv3ElxMAzUusaVb
qG1DYAKeZW8CRvxUwS3AeHLxgzr5iFnLqdgNFsIluYAOsCT16/KAo3FIL7BPSmav
nR1L0fIjIusj8fNVAU+gjlH4BMkF7MiLrg7wSDh90bqSoJXSho0yRm4NaWYakYJB
w3u5BvzjPgW2lkfPFkgskxGH693ffguSKBA7TjY59wKgeDNUkR+iYdsxOCKWlD2F
9zyT1PlsIod2H46T+AKdbPWJeEqayEFS0kHUazVA7zZ+poA53Q5q39nkiHa80esY
xPkZASCsZeft5e1uKxF264GItT2r5vm9FqDtZWrw4Ta/fUADKIUVY03Z7PHt+8Vx
jigFrJyIVWHGN2mhiB+k1EzRGtDeXC5qo3WmmixJndV5URgpQj8=
=Cb1K
-----END PGP SIGNATURE-----
--=-=-=--
