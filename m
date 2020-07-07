Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E01216EA1
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jul 2020 16:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgGGOWC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Jul 2020 10:22:02 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54338 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728306AbgGGOVw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Jul 2020 10:21:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 067ECVFs188273;
        Tue, 7 Jul 2020 14:21:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=KOd6V7gVRixxcq1iq9dtJPW1eVIplQDNn+1mM8f7F/8=;
 b=hFHwOXwiGqJzYlQei/D6Fo1/I4HnC8uWpqqKLF2R4HoGt1hotsv6cPR2goLXVxRw5NUu
 h9MMTSc3GuniK4N3eQXBLwMk7e7Pc5o3iW+FD4o5oFUGYqN5xbt0pdInymlbS4peezQQ
 R5Zg7L1KDhsrnTBghzzAZUQ0eRgc/bHMKqzavVlLp5Vr/XdpVej08TYUVsR0k33m8At2
 nGSoQ8qsU4fmjKBOcnpw8z1y7xYyhJneN4bPf5uxvtdOY9IOl0lhunwSLVWiBekbGz3f
 NDvFwSMYsJzdHikVczgDc8rm1U02j+GBX6YhK2SOQ4ihR0k2KiDIrmupwFfs/TVE5IF2 VA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 323sxxs2m7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 07 Jul 2020 14:21:49 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 067EEErE130283;
        Tue, 7 Jul 2020 14:19:49 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 3233px7vxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jul 2020 14:19:49 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 067EJmrs000410;
        Tue, 7 Jul 2020 14:19:48 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Jul 2020 07:19:48 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: [PATCH] nfsd4: a client's own opens needn't prevent delegations
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200707132805.GA25846@fieldses.org>
Date:   Tue, 7 Jul 2020 10:19:47 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <706D120D-490E-4C59-B2C7-7F5092D2A70E@oracle.com>
References: <20200707132805.GA25846@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3445.104.14)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9674 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 adultscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007070106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9674 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 adultscore=0 cotscore=-2147483648 phishscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 suspectscore=2 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007070106
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 7, 2020, at 9:28 AM, bfields@fieldses.org wrote:
>=20
> From: "J. Bruce Fields" <bfields@redhat.com>
>=20
> We recently fixed lease breaking so that a client's actions won't =
break
> its own delegations.
>=20
> But we still have an unnecessary self-conflict when granting
> delegations: a client's own write opens will prevent us from handing =
out
> a read delegation even when no other client has the file open for =
write.
>=20
> Fix that by turning off the checks for conflicting opens under
> vfs_setlease, and instead performing those checks in the nfsd code.
>=20
> We don't depend much on locks here: instead we acquire the delegation,
> then check for conflicts, and drop the delegation again if we find =
any.
>=20
> The check beforehand is an optimization of sorts, just to avoid
> acquiring the delegation unnecessarily.  There's a race where the =
first
> check could cause us to deny the delegation when we could have granted
> it.  But, that's OK, delegation grants are optional (and probably not
> even a good idea in that case).
>=20
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>

Applied to my private tree for testing. Thanks!


> ---
> fs/locks.c          |  3 +++
> fs/nfsd/nfs4state.c | 54 +++++++++++++++++++++++++++++++++------------
> 2 files changed, 43 insertions(+), 14 deletions(-)
>=20
> diff --git a/fs/locks.c b/fs/locks.c
> index 7df0f9fa66f4..d5de9039dbd7 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -1807,6 +1807,9 @@ check_conflicting_open(struct file *filp, const =
long arg, int flags)
>=20
> 	if (flags & FL_LAYOUT)
> 		return 0;
> +	if (flags & FL_DELEG)
> +		/* We leave these checks to the caller. */
> +		return 0;
>=20
> 	if (arg =3D=3D F_RDLCK)
> 		return inode_is_open_for_write(inode) ? -EAGAIN : 0;
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index bb3d2c32664a..ab5c8857ae5a 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4922,6 +4922,32 @@ static struct file_lock =
*nfs4_alloc_init_lease(struct nfs4_delegation *dp,
> 	return fl;
> }
>=20
> +static int nfsd4_check_conflicting_opens(struct nfs4_client *clp,
> +						struct nfs4_file *fp)
> +{
> +	struct nfs4_clnt_odstate *co;
> +	struct file *f =3D fp->fi_deleg_file->nf_file;
> +	struct inode *ino =3D locks_inode(f);
> +	int writes =3D atomic_read(&ino->i_writecount);
> +
> +	if (fp->fi_fds[O_WRONLY])
> +		writes--;
> +	if (fp->fi_fds[O_RDWR])
> +		writes--;
> +	WARN_ON_ONCE(writes < 0);
> +	if (writes > 0)
> +		return -EAGAIN;
> +	spin_lock(&fp->fi_lock);
> +	list_for_each_entry(co, &fp->fi_clnt_odstate, co_perfile) {
> +		if (co->co_client !=3D clp) {
> +			spin_unlock(&fp->fi_lock);
> +			return -EAGAIN;
> +		}
> +	}
> +	spin_unlock(&fp->fi_lock);
> +	return 0;
> +}
> +
> static struct nfs4_delegation *
> nfs4_set_delegation(struct nfs4_client *clp, struct svc_fh *fh,
> 		    struct nfs4_file *fp, struct nfs4_clnt_odstate =
*odstate)
> @@ -4941,9 +4967,12 @@ nfs4_set_delegation(struct nfs4_client *clp, =
struct svc_fh *fh,
>=20
> 	nf =3D find_readable_file(fp);
> 	if (!nf) {
> -		/* We should always have a readable file here */
> -		WARN_ON_ONCE(1);
> -		return ERR_PTR(-EBADF);
> +		/*
> +		 * We probably could attempt another open and get a read
> +		 * delegation, but for now, don't bother until the
> +		 * client actually sends us one.
> +		 */
> +		return ERR_PTR(-EAGAIN);
> 	}
> 	spin_lock(&state_lock);
> 	spin_lock(&fp->fi_lock);
> @@ -4973,11 +5002,19 @@ nfs4_set_delegation(struct nfs4_client *clp, =
struct svc_fh *fh,
> 	if (!fl)
> 		goto out_clnt_odstate;
>=20
> +	status =3D nfsd4_check_conflicting_opens(clp, fp);
> +	if (status) {
> +		locks_free_lock(fl);
> +		goto out_clnt_odstate;
> +	}
> 	status =3D vfs_setlease(fp->fi_deleg_file->nf_file, fl->fl_type, =
&fl, NULL);
> 	if (fl)
> 		locks_free_lock(fl);
> 	if (status)
> 		goto out_clnt_odstate;
> +	status =3D nfsd4_check_conflicting_opens(clp, fp);
> +	if (status)
> +		goto out_clnt_odstate;
>=20
> 	spin_lock(&state_lock);
> 	spin_lock(&fp->fi_lock);
> @@ -5059,17 +5096,6 @@ nfs4_open_delegation(struct svc_fh *fh, struct =
nfsd4_open *open,
> 				goto out_no_deleg;
> 			if (!cb_up || !(oo->oo_flags & =
NFS4_OO_CONFIRMED))
> 				goto out_no_deleg;
> -			/*
> -			 * Also, if the file was opened for write or
> -			 * create, there's a good chance the client's
> -			 * about to write to it, resulting in an
> -			 * immediate recall (since we don't support
> -			 * write delegations):
> -			 */
> -			if (open->op_share_access & =
NFS4_SHARE_ACCESS_WRITE)
> -				goto out_no_deleg;
> -			if (open->op_create =3D=3D NFS4_OPEN_CREATE)
> -				goto out_no_deleg;
> 			break;
> 		default:
> 			goto out_no_deleg;
> --=20
> 2.26.2
>=20

--
Chuck Lever



