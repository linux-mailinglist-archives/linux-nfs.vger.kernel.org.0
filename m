Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43E9C12572D
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Dec 2019 23:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfLRWrd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Dec 2019 17:47:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:53908 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbfLRWrd (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 18 Dec 2019 17:47:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2041CAC45;
        Wed, 18 Dec 2019 22:47:30 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Date:   Thu, 19 Dec 2019 09:47:23 +1100
Subject: [PATCH/RFC] NFS: handle NFSv4.1 server that doesn't support NFS4_OPEN_CLAIM_DELEG_CUR_FH
cc:     linux-nfs@vger.kernel.org
Message-ID: <87y2v9fdz8.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain


If an NFSv4.1 server doesn't support NFS4_OPEN_CLAIM_DELEG_CUR_FH
(e.g. Linux 3.0), and a newer NFS client tries to use it to claim
an open before returning a delegation, the server might return
NFS4ERR_BADXDR.
That is what Linux 3.0 does, though the RFC doesn't seem to be explicit
on which flags must be supported, and what error can be returned for
unsupported flags.

When NFS_CAP_ATOMIC_OPEN_V1 support was added in Commit 49f9a0fafd84
("NFSv4.1: Enable open-by-filehandle"), fall-back for non-supporting
servers was added for various open types, but not for delegation recall.

The code pattern for delegation recall is a little different to the
other open types, so I cannot simply copy the same approach.

I think the below patch should do the right thing, but I haven't tested
yet.

Does this look reasonable?  Is there a cleaner way to do it?  Should
we check other errors?

Thanks,
NeilBrown

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index caacf5e7f5e1..14f958d16648 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2174,6 +2174,13 @@ static int nfs4_open_reclaim(struct nfs4_state_owner *sp, struct nfs4_state *sta
 static int nfs4_handle_delegation_recall_error(struct nfs_server *server, struct nfs4_state *state, const nfs4_stateid *stateid, struct file_lock *fl, int err)
 {
 	switch (err) {
+		case -NFS4ERR_BADXDR: {
+			struct nfs4_exception exception;
+			if (nfs4_clear_cap_atomic_open_v1(server, -EINVAL,
+							  &exception))
+				return -EAGAIN;
+		}
+			/* fallthrough */
 		default:
 			printk(KERN_ERR "NFS: %s: unhandled error "
 					"%d.\n", __func__, err);

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl36rHsACgkQOeye3VZi
gblFgxAAhZuE6cimSKhoB2nrCMUjdAKa8E//LcZI8pWh5rzw1M4CNhwxPIlRz3P5
9kS7DcHWck3puQQwSr4C0kIXQ3rGLHQvCBPfMLAm1h1LYsi5bmegD2xViE6KNG8/
fBazsE9+R+F9UP7SSPSyA+Rl8vnJmzW0ibFUMqVsaxqKJ0RI5N76/EIWB4HV45lr
Y+e0VSFncC/h45Uxr4cuVyaQgv9SoepmfC4sbwOCycAnNCVdhqKrJc95C9Gci6An
BnCe/NQOIbNnhflOSodDKGU5SXp7PMY4t0ZFSLh8QXg58VOpreMwePCJiLIdD47z
fG7g/LNoNTtjHBdL1mefD8znuzXeOO2osG1C1PyYoPPtDp8Bpy/BS8VrSQGHpzXV
9yW4DWpqeoAsx/nDrGTHiIeH293L293/zvhlNiKes5Vv0PYfj+CFG3JXe8B81Nr9
SKd/IOgzYf0V50Gv9+YGXMSjTAuDsgwq2yeMWlWOMprYmsawZriQpOK7MjQZ/ZHi
siFPWWe+InhH47VfXGS7aqVX+dfEgCWVoD7pB8spp7800+iuWJpVY/Uqf877FQUp
OspBRNbIKf/4iVj+o/Z9C4QtD73q71DnVgwunkJ9e3u1GM3p+kTslqCxWz7xPzEV
jDZOQql/JUmfwgx/pmFkYvRbZ1wyAg9oXJTHJCDzY1KtAGS4+fA=
=aFhz
-----END PGP SIGNATURE-----
--=-=-=--
