Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7FB01259B6
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Dec 2019 03:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfLSC4Z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Dec 2019 21:56:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:40296 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbfLSC4Z (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 18 Dec 2019 21:56:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 78360ABBD;
        Thu, 19 Dec 2019 02:56:23 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "anna.schumaker\@netapp.com" <anna.schumaker@netapp.com>
Date:   Thu, 19 Dec 2019 13:56:14 +1100
Cc:     "linux-nfs\@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH/RFC] NFS: handle NFSv4.1 server that doesn't support NFS4_OPEN_CLAIM_DELEG_CUR_FH
In-Reply-To: <3afd2d5c631d8e3429e025e204a7b1c95b3c1415.camel@hammerspace.com>
References: <87y2v9fdz8.fsf@notabene.neil.brown.name> <3afd2d5c631d8e3429e025e204a7b1c95b3c1415.camel@hammerspace.com>
Message-ID: <87v9qdf2gh.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Wed, Dec 18 2019, Trond Myklebust wrote:

> On Thu, 2019-12-19 at 09:47 +1100, NeilBrown wrote:
>> If an NFSv4.1 server doesn't support NFS4_OPEN_CLAIM_DELEG_CUR_FH
>> (e.g. Linux 3.0), and a newer NFS client tries to use it to claim
>> an open before returning a delegation, the server might return
>> NFS4ERR_BADXDR.
>> That is what Linux 3.0 does, though the RFC doesn't seem to be
>> explicit
>> on which flags must be supported, and what error can be returned for
>> unsupported flags.
>
> NFS4ERR_BADXDR is defined in RFC5661, section 15.1.1.1 as meaning
>
> "The arguments for this operation do not match those specified in the
> XDR definition."
>
> That's clearly not the case here, so I'd chalk this down to a fairly
> blatant server bug, at which point it makes no sense to fix it in the
> client.

Ok, but the RFC seems to suggest it is OK to not support this flag, so
suppose I fixed the server to return NFS4ERR_NOTSUPP instead.
The client still wouldn't handle this response gracefully.

Thanks,
NeilBrown


diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index caacf5e7f5e1..14f958d16648 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2174,6 +2174,13 @@ static int nfs4_open_reclaim(struct nfs4_state_owner *sp, struct nfs4_state *sta
 static int nfs4_handle_delegation_recall_error(struct nfs_server *server, struct nfs4_state *state, const
nfs4_stateid *stateid, struct file_lock *fl, int err)
 {
	switch (err) {
+		case -NFS4ERR_NOTSUPP: {
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

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl365s8ACgkQOeye3VZi
gbmWog/7BYmepJP9OfxrAOtplvtd9BKFOxTL7359gtNod3geUVlgwEydeUjyCB1q
bSeuEuy2567hWim4agaNKtSeA8zIrjPWJSIzeTKqM4OJdO6AFa+pJVEHKLdDN4xs
cH2GIuw8k3QvqzZS1n9+LmlV1+GOgyyJWefkm9cBeEmPwzHyhk+RG5muSNEhahe+
1pM9FavwQa+Sba4w/psw1edatmnOOgaMg729gdCWksMy0/FuUQ4eNESB2rYqkoJH
gHlUU5koRZ1b6ftHlsZyMQI8md5DQTUOdWmG/tazjiJ0FssHHo5wVs9YqWaFcuF0
aGSY1G9hVTxBE6aweVtQGBY+dNgvVAOWfQtSbUTyziXlCJ+fpX9QzuWqpvnQpoOz
FIfqevUd7quM6ckOPbTthHgjuazg1RNMyTvAZSnbrG1WwYT2/ZsWvrhd5IubS6et
thbQbobXI02xDunP8KPVxryBIMB7yL+WZIxGk1L6qnES5gfjf6WYRbqYPiiYA341
2eOsLpLQXdtju0kjoU9j15qEP+6m0vCy2j3gNV5PwJP50RZtOyQTly2D9hxuzTLc
9cJlEGtSRSGFxpfamvCB+r0rhNcy2DRnsEK/THsotPlub+vxVFpzcrfxe0fFH80Y
++hG4KmRR165KbwBUtSK8YRjG2gJoWtkUbhErD140CKEXVtrgDI=
=BXIL
-----END PGP SIGNATURE-----
--=-=-=--
