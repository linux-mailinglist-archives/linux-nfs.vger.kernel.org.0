Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 796CB14BD6B
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jan 2020 17:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgA1QCQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Jan 2020 11:02:16 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57768 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgA1QCP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 Jan 2020 11:02:15 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00SFrCr9178260;
        Tue, 28 Jan 2020 16:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=6oL2FWs+cZqFFPLSowaKPi65xXvujr8BHs+SMq4JyD8=;
 b=KWX/GTBEuBuwSVkCgS5O9Mmyh7mgXl+nrl6rnsIM3E7LQA/Kh/mozinmgpijEolU4Iqd
 1QNzC3SDN6UMX+RekccqVESD1VJKvjrkWYRQDVTNjG3orcIKNKUvt7HRjZFh5/nQ9qCi
 5bNJiwMNAN+AZzq0IBGlq2xijEiBKOkiq/Ekjf60fszMPtxNZy6hqihOslFBytlv0YYL
 /3200LVwg8H76+jJM1BMrFl2YoPZK+DjsZSloKYf8ihc6b7KLcC8qabXg9QtmoX7EMsb
 Ok6NcBt2lR1aaTZrKzgszuawIDSc9fzheYMlxVOQyJHibIeAXPfadcjT29LVakB8ni9M Qw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2xrdmqf9yr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jan 2020 16:02:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00SFsfhq007998;
        Tue, 28 Jan 2020 16:02:07 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2xtmr2rc40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jan 2020 16:02:07 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00SG24jf026111;
        Tue, 28 Jan 2020 16:02:05 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Jan 2020 08:02:04 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v4] NFSv4.0: nfs4_do_fsinfo() should not do implicit lease
 renewals
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <004e01d5d5ed$5e7ca490$1b75edb0$@gmail.com>
Date:   Tue, 28 Jan 2020 11:02:02 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-kernel@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F4BC4DA3-B120-436B-B473-4F1A0CFEE639@oracle.com>
References: <004e01d5d5ed$5e7ca490$1b75edb0$@gmail.com>
To:     Robert Milkowski <rmilkowski@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9514 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001280124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9514 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001280124
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 28, 2020, at 10:12 AM, Robert Milkowski <rmilkowski@gmail.com> =
wrote:
>=20
> From: Robert Milkowski <rmilkowski@gmail.com>
>=20
> Currently, each time nfs4_do_fsinfo() is called it will do an implicit
> NFS4 lease renewal, which is not compliant with the NFS4 =
specification.
> This can result in a lease being expired by an NFS server.
>=20
> Commit 83ca7f5ab31f ("NFS: Avoid PUTROOTFH when managing leases")
> introduced implicit client lease renewal in nfs4_do_fsinfo(),
> which can result in the NFSv4.0 lease to expire on a server side,
> and servers returning NFS4ERR_EXPIRED or NFS4ERR_STALE_CLIENTID.
>=20
> This can easily be reproduced by frequently unmounting a sub-mount,
> then stat'ing it to get it mounted again, which will delay or even
> completely prevent client from sending RENEW operations if no other
> NFS operations are issued. Eventually nfs server will expire client's
> lease and return an error on file access or next RENEW.
>=20
> This can also happen when a sub-mount is automatically unmounted
> due to inactivity (after nfs_mountpoint_expiry_timeout), then it is
> mounted again via stat(). This can result in a short window during
> which client's lease will expire on a server but not on a client.
> This specific case was observed on production systems.
>=20
> This patch removes the implicit lease renewal from nfs4_do_fsinfo().

I'm OK with this approach.

And, we've seen sporadic lease expirations in the field and in
test environments as well. I'm optimistic that this patch will
address those situations.

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


> Fixes: 83ca7f5ab31f ("NFS: Avoid PUTROOTFH when managing leases")
> Signed-off-by: Robert Milkowski <rmilkowski@gmail.com>
> ---
> fs/nfs/nfs4_fs.h    |  4 +---
> fs/nfs/nfs4proc.c   | 12 ++++++++----
> fs/nfs/nfs4renewd.c |  5 +----
> fs/nfs/nfs4state.c  |  4 +---
> 4 files changed, 11 insertions(+), 14 deletions(-)
>=20
> diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
> index a7a73b1..a5db055 100644
> --- a/fs/nfs/nfs4_fs.h
> +++ b/fs/nfs/nfs4_fs.h
> @@ -446,9 +446,7 @@ extern int nfs4_detect_session_trunking(struct =
nfs_client *clp,
> extern void nfs4_renewd_prepare_shutdown(struct nfs_server *);
> extern void nfs4_kill_renewd(struct nfs_client *);
> extern void nfs4_renew_state(struct work_struct *);
> -extern void nfs4_set_lease_period(struct nfs_client *clp,
> -		unsigned long lease,
> -		unsigned long lastrenewed);
> +extern void nfs4_set_lease_period(struct nfs_client *clp, unsigned =
long lease);
>=20
>=20
> /* nfs4state.c */
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 76d3716..7b2d88b 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -5019,16 +5019,13 @@ static int nfs4_do_fsinfo(struct nfs_server =
*server, struct nfs_fh *fhandle, str
> 	struct nfs4_exception exception =3D {
> 		.interruptible =3D true,
> 	};
> -	unsigned long now =3D jiffies;
> 	int err;
>=20
> 	do {
> 		err =3D _nfs4_do_fsinfo(server, fhandle, fsinfo);
> 		trace_nfs4_fsinfo(server, fhandle, fsinfo->fattr, err);
> 		if (err =3D=3D 0) {
> -			nfs4_set_lease_period(server->nfs_client,
> -					fsinfo->lease_time * HZ,
> -					now);
> +			nfs4_set_lease_period(server->nfs_client, =
fsinfo->lease_time * HZ);
> 			break;
> 		}
> 		err =3D nfs4_handle_exception(server, err, &exception);
> @@ -6084,6 +6081,7 @@ int nfs4_proc_setclientid(struct nfs_client =
*clp, u32 program,
> 		.callback_data =3D &setclientid,
> 		.flags =3D RPC_TASK_TIMEOUT | RPC_TASK_NO_ROUND_ROBIN,
> 	};
> +	unsigned long now =3D jiffies;
> 	int status;
>=20
> 	/* nfs_client_id4 */
> @@ -6116,6 +6114,9 @@ int nfs4_proc_setclientid(struct nfs_client =
*clp, u32 program,
> 		clp->cl_acceptor =3D =
rpcauth_stringify_acceptor(setclientid.sc_cred);
> 		put_rpccred(setclientid.sc_cred);
> 	}
> +
> +	if(status =3D=3D 0)
> +		do_renew_lease(clp, now);
> out:
> 	trace_nfs4_setclientid(clp, status);
> 	dprintk("NFS reply setclientid: %d\n", status);
> @@ -8203,6 +8204,7 @@ static int _nfs4_proc_exchange_id(struct =
nfs_client *clp, const struct cred *cre
> 	struct rpc_task *task;
> 	struct nfs41_exchange_id_args *argp;
> 	struct nfs41_exchange_id_res *resp;
> +	unsigned long now =3D jiffies;
> 	int status;
>=20
> 	task =3D nfs4_run_exchange_id(clp, cred, sp4_how, NULL);
> @@ -8223,6 +8225,8 @@ static int _nfs4_proc_exchange_id(struct =
nfs_client *clp, const struct cred *cre
> 	if (status !=3D 0)
> 		goto out;
>=20
> +	do_renew_lease(clp, now);
> +
> 	clp->cl_clientid =3D resp->clientid;
> 	clp->cl_exchange_flags =3D resp->flags;
> 	clp->cl_seqid =3D resp->seqid;
> diff --git a/fs/nfs/nfs4renewd.c b/fs/nfs/nfs4renewd.c
> index 6ea431b..ff876dd 100644
> --- a/fs/nfs/nfs4renewd.c
> +++ b/fs/nfs/nfs4renewd.c
> @@ -138,15 +138,12 @@
>  *
>  * @clp: pointer to nfs_client
>  * @lease: new value for lease period
> - * @lastrenewed: time at which lease was last renewed
>  */
> void nfs4_set_lease_period(struct nfs_client *clp,
> -		unsigned long lease,
> -		unsigned long lastrenewed)
> +		unsigned long lease)
> {
> 	spin_lock(&clp->cl_lock);
> 	clp->cl_lease_time =3D lease;
> -	clp->cl_last_renewal =3D lastrenewed;
> 	spin_unlock(&clp->cl_lock);
>=20
> 	/* Cap maximum reconnect timeout at 1/2 lease period */
> diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
> index 3455232..f0b0027 100644
> --- a/fs/nfs/nfs4state.c
> +++ b/fs/nfs/nfs4state.c
> @@ -92,17 +92,15 @@ static int nfs4_setup_state_renewal(struct =
nfs_client *clp)
> {
> 	int status;
> 	struct nfs_fsinfo fsinfo;
> -	unsigned long now;
>=20
> 	if (!test_bit(NFS_CS_CHECK_LEASE_TIME, &clp->cl_res_state)) {
> 		nfs4_schedule_state_renewal(clp);
> 		return 0;
> 	}
>=20
> -	now =3D jiffies;
> 	status =3D nfs4_proc_get_lease_time(clp, &fsinfo);
> 	if (status =3D=3D 0) {
> -		nfs4_set_lease_period(clp, fsinfo.lease_time * HZ, now);
> +		nfs4_set_lease_period(clp, fsinfo.lease_time * HZ);
> 		nfs4_schedule_state_renewal(clp);
> 	}
>=20
> --=20
> 1.8.3.1
>=20
>=20

--
Chuck Lever



