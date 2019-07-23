Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C11DD722A7
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jul 2019 00:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730719AbfGWWye (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Jul 2019 18:54:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:42182 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726713AbfGWWye (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 23 Jul 2019 18:54:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 58319AC6C;
        Tue, 23 Jul 2019 22:54:31 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     "Schumaker\, Anna" <Anna.Schumaker@netapp.com>,
        "trondmy\@hammerspace.com" <trondmy@hammerspace.com>,
        "chuck.lever\@oracle.com" <chuck.lever@oracle.com>,
        "aglo\@umich.edu" <aglo@umich.edu>
Date:   Wed, 24 Jul 2019 08:54:22 +1000
Cc:     "linux-nfs\@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 3/9] NFS: send state management on a single connection.
In-Reply-To: <29913e2feb35dedd640224a6e9984a8b2c758c5e.camel@netapp.com>
References: <155917564898.3988.6096672032831115016.stgit@noble.brown> <155917688863.3988.8318604225894720148.stgit@noble.brown> <29913e2feb35dedd640224a6e9984a8b2c758c5e.camel@netapp.com>
Message-ID: <87r26gjra9.fsf@notabene.neil.brown.name>
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

On Tue, Jul 23 2019,  Schumaker, Anna  wrote:

> Hi Neil,
>
> On Thu, 2019-05-30 at 10:41 +1000, NeilBrown wrote:
>> With NFSv4.1, different network connections need to be explicitly
>> bound to a session.  During session startup, this is not possible
>> so only a single connection must be used for session startup.
>>=20
>> So add a task flag to disable the default round-robin choice of
>> connections (when nconnect > 1) and force the use of a single
>> connection.
>> Then use that flag on all requests for session management - for
>> consistence, include NFSv4.0 management (SETCLIENTID) and session
>> destruction
>>=20
>> Reported-by: Chuck Lever <chuck.lever@oracle.com>
>> Signed-off-by: NeilBrown <neilb@suse.com>
>> ---
>>  fs/nfs/nfs4proc.c            |   22 +++++++++++++---------
>>  include/linux/sunrpc/sched.h |    1 +
>>  net/sunrpc/clnt.c            |   24 +++++++++++++++++++++++-
>>  3 files changed, 37 insertions(+), 10 deletions(-)
>>=20
>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>> index c29cbef6b53f..22b3dbfc4fa1 100644
>> --- a/fs/nfs/nfs4proc.c
>> +++ b/fs/nfs/nfs4proc.c
>> @@ -5978,7 +5978,7 @@ int nfs4_proc_setclientid(struct nfs_client
>> *clp, u32 program,
>>  		.rpc_message =3D &msg,
>>  		.callback_ops =3D &nfs4_setclientid_ops,
>>  		.callback_data =3D &setclientid,
>> -		.flags =3D RPC_TASK_TIMEOUT,
>> +		.flags =3D RPC_TASK_TIMEOUT | RPC_TASK_NO_ROUND_ROBIN,
>>  	};
>>  	int status;
>>=20=20
>> @@ -6044,7 +6044,8 @@ int nfs4_proc_setclientid_confirm(struct
>> nfs_client *clp,
>>  	dprintk("NFS call  setclientid_confirm auth=3D%s, (client ID
>> %llx)\n",
>>  		clp->cl_rpcclient->cl_auth->au_ops->au_name,
>>  		clp->cl_clientid);
>> -	status =3D rpc_call_sync(clp->cl_rpcclient, &msg,
>> RPC_TASK_TIMEOUT);
>> +	status =3D rpc_call_sync(clp->cl_rpcclient, &msg,
>> +			       RPC_TASK_TIMEOUT |
>> RPC_TASK_NO_ROUND_ROBIN);
>>  	trace_nfs4_setclientid_confirm(clp, status);
>>  	dprintk("NFS reply setclientid_confirm: %d\n", status);
>>  	return status;
>> @@ -7633,7 +7634,7 @@ static int _nfs4_proc_secinfo(struct inode
>> *dir, const struct qstr *name, struct
>>  		NFS_SP4_MACH_CRED_SECINFO, &clnt, &msg);
>>=20=20
>>  	status =3D nfs4_call_sync(clnt, NFS_SERVER(dir), &msg,
>> &args.seq_args,
>> -				&res.seq_res, 0);
>> +				&res.seq_res, RPC_TASK_NO_ROUND_ROBIN);
>
> I'm confused about what setting RPC_TASK_NO_ROUND_ROBIN as the
> "cache_reply" argument to nfs4_call_sync() actually does. As far as I
> can tell, it's passed to nfs4_init_sequence() which sets it to the
> nfs4_sequence_args "sa_cache_this" field, which is a one bit boolean
> (defined in include/linux/nfs_xdr.h). So why pass the flag?

Thanks for reviewing my patch!  Yes, that is an error.
I think I had confused nfs4_call_sync() with rpc_call_sync().
Similar names, different args.

For those calls, I want to get RPC_TASK_NO_ROUND_ROBIN set in the .flags
field of 'task_setup' in nfs4_call_sync_sequence().

Maybe we could add a 'flags' arg to nfs4_call_sync_sequence() and
add a new nfs4_call_sync_state() which sets RPC_TASK_NO_ROUND_ROBIN.

If you are happy with this approach, let me know and I send a proper
patch.

Thanks,
NeilBrown

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

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl03kB4ACgkQOeye3VZi
gbkuvQ/+NDurveRaTn7TJxbKqZaOG3QtsCHFE1doaOvlxE7RXCY8UbsnMzCPdy04
mCTb5lj5pKL0wbNW97NNjd2VYITJ4Hr3qw7LYQD2kHNuTYyjlUMjXM1a+EZy0T61
W5qU2r3L4BoJ8LIWBzsSw+1jqjW7GWtsIgaK2t5JUmrzBpMIXHfZMOXle5pmnJzc
C1FdUPhJIVo9/dYg0p6YmpQh4mCtrl/yyXkazTCJchmkNRVe6srL3vZQLd2jk9gZ
pWwHQvQNF9/I7n602ODtHWWg9HrlWB7Z5fk0TafW4V2Y6UBbZbonemaMLmPoogo7
CmjFIgXcFi2GJd4xH9xsxxPHy3z9YbWDGNrj43mIKSnOxRp+6bVjpAouu3BrjEfO
BccHS594vSubqRIOiZNnkf6uNcSXYbtOGTh9DcMemJW+7e9w1O3CA6aIem8/9Ss0
BOQWCNh1AwOsWrIy93RSdbSWD7AbtfX977bOQYysJPupyvI+iEzAbGa8DPx4OTSN
0mvy3ZDgbpvBmp8GXcwxL+FJ16qR2TXGZ6kegoSWj3R2MnOYfzjp8+RbM+kMN+JK
f1QDufFM9jLVxNpcgcdJEE+2c8X1BWvpYgdrpVLlEyDLznZRBoeEytMZ3RNmsRmz
TeEzolQ8NEKj1pAAiz1U4UDg+3EJOkOKORtdkjqlRTh7XHB84M4=
=1Psu
-----END PGP SIGNATURE-----
--=-=-=--
