Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F53F7B7E7
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jul 2019 04:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbfGaCFf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Jul 2019 22:05:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:53776 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728030AbfGaCFf (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 30 Jul 2019 22:05:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5E1E1ACB7;
        Wed, 31 Jul 2019 02:05:33 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     "Schumaker\, Anna" <Anna.Schumaker@netapp.com>,
        "trondmy\@hammerspace.com" <trondmy@hammerspace.com>,
        "chuck.lever\@oracle.com" <chuck.lever@oracle.com>,
        "aglo\@umich.edu" <aglo@umich.edu>
Date:   Wed, 31 Jul 2019 12:05:23 +1000
Cc:     "linux-nfs\@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: [PATCH] NFS: add flags arg to nfs4_call_sync_sequence()
In-Reply-To: <29913e2feb35dedd640224a6e9984a8b2c758c5e.camel@netapp.com>
References: <155917564898.3988.6096672032831115016.stgit@noble.brown> <155917688863.3988.8318604225894720148.stgit@noble.brown> <29913e2feb35dedd640224a6e9984a8b2c758c5e.camel@netapp.com>
Message-ID: <87d0hrklgc.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Adding a flags argument allows flags such as RPC_TASK_NO_ROUND_ROBIN
to be passed to rpc_run_task().
This is needed when calling nfs4_call_sync() for state-management
commands.
Rather than adding a flags argument to nfs4_call_sync(), add a new
nfs4_call_sync_state(), which passes RPC_TASK_NO_ROUND_ROBIN to
nfs4_call_sync_sequence().

A previous commit incorrectly passed RPC_TASK_NO_ROUND_ROBIN
in the last arg to nfs4_call_sync(), where that arg is not a general
flags argument.  This patch fixes that by changing those call-sites
to call the new nfs4_call_sync_state()

Repored-by: Anna Schumaker <Anna.Schumaker@netapp.com>
Fixes: 5a0c257f8e0f ("NFS: send state management on a single connection.")
Signed-off-by: NeilBrown <neilb@suse.com>
=2D--
 fs/nfs/nfs4proc.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 39896afc6edf..dd2725fe7a74 100644
=2D-- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1077,7 +1077,8 @@ static int nfs4_call_sync_sequence(struct rpc_clnt *c=
lnt,
 				   struct nfs_server *server,
 				   struct rpc_message *msg,
 				   struct nfs4_sequence_args *args,
=2D				   struct nfs4_sequence_res *res)
+				   struct nfs4_sequence_res *res,
+				   int flags)
 {
 	int ret;
 	struct rpc_task *task;
@@ -1091,7 +1092,8 @@ static int nfs4_call_sync_sequence(struct rpc_clnt *c=
lnt,
 		.rpc_client =3D clnt,
 		.rpc_message =3D msg,
 		.callback_ops =3D clp->cl_mvops->call_sync_ops,
=2D		.callback_data =3D &data
+		.callback_data =3D &data,
+		.flags =3D flags,
 	};
=20
 	task =3D rpc_run_task(&task_setup);
@@ -1112,7 +1114,20 @@ int nfs4_call_sync(struct rpc_clnt *clnt,
 		   int cache_reply)
 {
 	nfs4_init_sequence(args, res, cache_reply, 0);
=2D	return nfs4_call_sync_sequence(clnt, server, msg, args, res);
+	return nfs4_call_sync_sequence(clnt, server, msg, args, res, 0);
+}
+
+int nfs4_call_sync_state(struct rpc_clnt *clnt,
+			 struct nfs_server *server,
+			 struct rpc_message *msg,
+			 struct nfs4_sequence_args *args,
+			 struct nfs4_sequence_res *res,
+			 int cache_reply)
+{
+	/* State management commands are never round-robined */
+	nfs4_init_sequence(args, res, cache_reply, 0);
+	return nfs4_call_sync_sequence(clnt, server, msg, args, res,
+				       RPC_TASK_NO_ROUND_ROBIN);
 }
=20
 static void
@@ -7387,7 +7402,7 @@ static int _nfs40_proc_get_locations(struct inode *in=
ode,
=20
 	nfs4_init_sequence(&args.seq_args, &res.seq_res, 0, 1);
 	status =3D nfs4_call_sync_sequence(clnt, server, &msg,
=2D					&args.seq_args, &res.seq_res);
+					 &args.seq_args, &res.seq_res, 0);
 	if (status)
 		return status;
=20
@@ -7440,7 +7455,7 @@ static int _nfs41_proc_get_locations(struct inode *in=
ode,
=20
 	nfs4_init_sequence(&args.seq_args, &res.seq_res, 0, 1);
 	status =3D nfs4_call_sync_sequence(clnt, server, &msg,
=2D					&args.seq_args, &res.seq_res);
+					 &args.seq_args, &res.seq_res, 0);
 	if (status =3D=3D NFS4_OK &&
 	    res.seq_res.sr_status_flags & SEQ4_STATUS_LEASE_MOVED)
 		status =3D -NFS4ERR_LEASE_MOVED;
@@ -7529,7 +7544,7 @@ static int _nfs40_proc_fsid_present(struct inode *ino=
de, const struct cred *cred
=20
 	nfs4_init_sequence(&args.seq_args, &res.seq_res, 0, 1);
 	status =3D nfs4_call_sync_sequence(clnt, server, &msg,
=2D						&args.seq_args, &res.seq_res);
+					 &args.seq_args, &res.seq_res, 0);
 	nfs_free_fhandle(res.fh);
 	if (status)
 		return status;
@@ -7570,7 +7585,7 @@ static int _nfs41_proc_fsid_present(struct inode *ino=
de, const struct cred *cred
=20
 	nfs4_init_sequence(&args.seq_args, &res.seq_res, 0, 1);
 	status =3D nfs4_call_sync_sequence(clnt, server, &msg,
=2D						&args.seq_args, &res.seq_res);
+					 &args.seq_args, &res.seq_res, 0);
 	nfs_free_fhandle(res.fh);
 	if (status =3D=3D NFS4_OK &&
 	    res.seq_res.sr_status_flags & SEQ4_STATUS_LEASE_MOVED)
@@ -7656,8 +7671,8 @@ static int _nfs4_proc_secinfo(struct inode *dir, cons=
t struct qstr *name, struct
 	nfs4_state_protect(NFS_SERVER(dir)->nfs_client,
 		NFS_SP4_MACH_CRED_SECINFO, &clnt, &msg);
=20
=2D	status =3D nfs4_call_sync(clnt, NFS_SERVER(dir), &msg, &args.seq_args,
=2D				&res.seq_res, RPC_TASK_NO_ROUND_ROBIN);
+	status =3D nfs4_call_sync_state(clnt, NFS_SERVER(dir), &msg, &args.seq_ar=
gs,
+				      &res.seq_res, 0);
 	dprintk("NFS reply  secinfo: %d\n", status);
=20
 	put_cred(cred);
@@ -9357,8 +9372,8 @@ _nfs41_proc_secinfo_no_name(struct nfs_server *server=
, struct nfs_fh *fhandle,
 	}
=20
 	dprintk("--> %s\n", __func__);
=2D	status =3D nfs4_call_sync(clnt, server, &msg, &args.seq_args,
=2D				&res.seq_res, RPC_TASK_NO_ROUND_ROBIN);
+	status =3D nfs4_call_sync_state(clnt, server, &msg, &args.seq_args,
+				      &res.seq_res, 0);
 	dprintk("<-- %s status=3D%d\n", __func__, status);
=20
 	put_cred(cred);
@@ -9497,7 +9512,7 @@ static int _nfs41_test_stateid(struct nfs_server *ser=
ver,
 	dprintk("NFS call  test_stateid %p\n", stateid);
 	nfs4_init_sequence(&args.seq_args, &res.seq_res, 0, 1);
 	status =3D nfs4_call_sync_sequence(rpc_client, server, &msg,
=2D			&args.seq_args, &res.seq_res);
+					 &args.seq_args, &res.seq_res, 0);
 	if (status !=3D NFS_OK) {
 		dprintk("NFS reply test_stateid: failed, %d\n", status);
 		return status;
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl1A92QACgkQOeye3VZi
gbm9nA/+ICp4UIF94vrHb1UQL6XeQCBLCcgEw2nUVY1kVD3O0uyXweU1vGf8Eh8V
GTq8uca+OCYxAu4uc0Vg1/CTNZBDL1Jm5//suxhTqBq9paWnBTcUJy0JCph0gTtf
Q7TFKEvHEnh1l4rv4wdWRAeujMp17+fsyrbjfNGzgdUyPpmO+fQbKbzrJhfGO0FQ
y67at0yse4tK9AEqDlcgMdIF2ji3khgVjHitgDMzzFHYVygLWu4ohP2LmiEC89mU
SC/mABbfRE2mi94gMPKD/p9m1ab05Bi9uQZHhZDhJooe4dA/4aDKEkN+3HJPTaP5
849CgDCmhgrqMqMjczBnzeeJKtKg9Jt3F13dCXjSOkODhokbMAY8HRdQbVwBYCz6
hIDdsNvfcXdDr32d+qWue01yHS2irW2PLlEp5fITFLuj91/acp6fIuSG+MVAbwoC
dqejpynWADeZ5PV6ScPjj4C1O6PLEEp0PYkpWd1UtKhFL0vvs0mKg+1GqjrHCAWZ
AiqpolPsqRsTe+9Ra61jrsWdIDcm9qWwHay7qmi11GAHu8Vp4Oj5eRiqahEETaYw
OHmbpmdLWDCbmuoJdmjs/jUNVarm4AU/JJQXouNY/4vZnbEqaRjykOg40CcxXuhh
U/AMQJulGQ9zDINZ0/PVYgKggK+08Xl7X5nUdLFUXwHzqWJyzU8=
=8nW5
-----END PGP SIGNATURE-----
--=-=-=--
