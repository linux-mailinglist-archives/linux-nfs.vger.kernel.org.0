Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF28827D32C
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Sep 2020 17:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgI2PyD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Sep 2020 11:54:03 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59792 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgI2PyD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Sep 2020 11:54:03 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08TFn36s001488;
        Tue, 29 Sep 2020 15:53:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=FxSDF/v7JS9Pmj4k7zcbEMGZN8tzahdirwRIZaMsWwo=;
 b=asnAeeaoAVAQoXG3sWKNHYyzgz42MzUb8raA3inW/pE2UblyLmQcC8ZQndO375ufXOMj
 3LrK9LKloUSrVKL5I8LgdoJ8fiZ4ANsd44o00CEnZ15dgJN4H9s9pG084DDiiUnDOwRm
 M11ujX/YOJw1aLyOItiuRh04+b9jy1ZFR3fJ5hI6qRwRHedNVhPVCFPnV9LUoBqBwn7w
 SiTmEUrgYtipyb8Za0ulVb+iKa/iHyFd+V9gvaOLy6yG2ARAXu+AfZfP5z3jjHq54XgG
 SjbKtj1Z9vI9KeZ/RbcbzzuZbgf46X+xwz65oN26y6zHmCs5kK1kueOMU1+IRBF8PsWC sA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 33sx9n3pdb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Sep 2020 15:53:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08TFoju8184519;
        Tue, 29 Sep 2020 15:53:56 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 33tfdsb4ne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Sep 2020 15:53:56 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08TFrtVo000312;
        Tue, 29 Sep 2020 15:53:55 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Sep 2020 08:53:54 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v2 11/11] NFSD: Call NFSv2 encoders on error returns
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <160138827523.2558.10662502652461223634.stgit@klimt.1015granger.net>
Date:   Tue, 29 Sep 2020 11:53:54 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <13B75E3F-58AB-4B92-BF31-1A5612104A19@oracle.com>
References: <160138785101.2558.11821923574884893011.stgit@klimt.1015granger.net>
 <160138827523.2558.10662502652461223634.stgit@klimt.1015granger.net>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009290136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009290136
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 29, 2020, at 10:04 AM, Chuck Lever <chuck.lever@oracle.com> =
wrote:
>=20
> Eventually we want to deprecate NFSv2 entirely.
>=20
> Remove special dispatcher logic for NFSv2 error responses. These are
> rare to the point of becoming extinct, but all NFS responses have to
> pay the cost of the extra conditional branches.
>=20
> This also means the NFSv2 error cases now get proper
> xdr_ressize_check() calls.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
> fs/nfsd/nfs2acl.c |    9 +++
> fs/nfsd/nfsproc.c |  159 =
+++++++++++++++++++++++++++--------------------------
> fs/nfsd/nfssvc.c  |    8 +--
> fs/nfsd/nfsxdr.c  |   18 ++++++
> fs/nfsd/xdr.h     |    7 ++
> 5 files changed, 118 insertions(+), 83 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
> index 3c8b9250dc4a..70b3a90cfe92 100644
> --- a/fs/nfsd/nfs2acl.c
> +++ b/fs/nfsd/nfs2acl.c
> @@ -273,6 +273,9 @@ static int nfsaclsvc_encode_getaclres(struct =
svc_rqst *rqstp, __be32 *p)
> 	int n;
> 	int w;
>=20
> +	if (resp->status !=3D nfs_ok)
> +		return xdr_ressize_check(rqstp, p);
> +
> 	/*
> 	 * Since this is version 2, the check for nfserr in
> 	 * nfsd_dispatch actually ensures the following cannot happen.
> @@ -312,6 +315,9 @@ static int nfsaclsvc_encode_attrstatres(struct =
svc_rqst *rqstp, __be32 *p)
> {
> 	struct nfsd_attrstat *resp =3D rqstp->rq_resp;
>=20
> +	if (resp->status !=3D nfs_ok)
> +		return xdr_ressize_check(rqstp, p);

Looks like proc_setacl doesn't set resp->status. Will be fixed
in the next version of this series.


> +
> 	p =3D nfs2svc_encode_fattr(rqstp, p, &resp->fh, &resp->stat);
> 	return xdr_ressize_check(rqstp, p);
> }
> @@ -321,6 +327,9 @@ static int nfsaclsvc_encode_accessres(struct =
svc_rqst *rqstp, __be32 *p)
> {
> 	struct nfsd3_accessres *resp =3D rqstp->rq_resp;
>=20
> +	if (resp->status !=3D nfs_ok)
> +		return xdr_ressize_check(rqstp, p);
> +
> 	p =3D nfs2svc_encode_fattr(rqstp, p, &resp->fh, &resp->stat);
> 	*p++ =3D htonl(resp->access);
> 	return xdr_ressize_check(rqstp, p);
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index 33204d83709c..9727f2fdf5e4 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -16,6 +16,7 @@ typedef struct svc_buf	svc_buf;
>=20
> #define NFSDDBG_FACILITY		NFSDDBG_PROC
>=20
> +#define RETURN_STATUS(st)	{ resp->status =3D (st); return (st); }
>=20
> static __be32
> nfsd_proc_null(struct svc_rqst *rqstp)
> @@ -23,18 +24,6 @@ nfsd_proc_null(struct svc_rqst *rqstp)
> 	return nfs_ok;
> }
>=20
> -static __be32
> -nfsd_return_attrs(__be32 err, struct nfsd_attrstat *resp)
> -{
> -	if (err) return err;
> -	return fh_getattr(&resp->fh, &resp->stat);
> -}
> -static __be32
> -nfsd_return_dirop(__be32 err, struct nfsd_diropres *resp)
> -{
> -	if (err) return err;
> -	return fh_getattr(&resp->fh, &resp->stat);
> -}
> /*
>  * Get a file's attributes
>  * N.B. After this call resp->fh needs an fh_put
> @@ -44,13 +33,17 @@ nfsd_proc_getattr(struct svc_rqst *rqstp)
> {
> 	struct nfsd_fhandle *argp =3D rqstp->rq_argp;
> 	struct nfsd_attrstat *resp =3D rqstp->rq_resp;
> -	__be32 nfserr;
> +
> 	dprintk("nfsd: GETATTR  %s\n", SVCFH_fmt(&argp->fh));
>=20
> 	fh_copy(&resp->fh, &argp->fh);
> -	nfserr =3D fh_verify(rqstp, &resp->fh, 0,
> -			NFSD_MAY_NOP | NFSD_MAY_BYPASS_GSS_ON_ROOT);
> -	return nfsd_return_attrs(nfserr, resp);
> +	resp->status =3D fh_verify(rqstp, &resp->fh, 0,
> +				 NFSD_MAY_NOP | =
NFSD_MAY_BYPASS_GSS_ON_ROOT);
> +	if (resp->status !=3D nfs_ok)
> +		return resp->status;
> +
> +	resp->status =3D fh_getattr(&resp->fh, &resp->stat);
> +	return resp->status;
> }
>=20
> /*
> @@ -64,7 +57,6 @@ nfsd_proc_setattr(struct svc_rqst *rqstp)
> 	struct nfsd_attrstat *resp =3D rqstp->rq_resp;
> 	struct iattr *iap =3D &argp->attrs;
> 	struct svc_fh *fhp;
> -	__be32 nfserr;
>=20
> 	dprintk("nfsd: SETATTR  %s, valid=3D%x, size=3D%ld\n",
> 		SVCFH_fmt(&argp->fh),
> @@ -96,9 +88,9 @@ nfsd_proc_setattr(struct svc_rqst *rqstp)
> 		 */
> 		time64_t delta =3D iap->ia_atime.tv_sec - =
ktime_get_real_seconds();
>=20
> -		nfserr =3D fh_verify(rqstp, fhp, 0, NFSD_MAY_NOP);
> -		if (nfserr)
> -			goto done;
> +		resp->status =3D fh_verify(rqstp, fhp, 0, NFSD_MAY_NOP);
> +		if (resp->status !=3D nfs_ok)
> +			return resp->status;
>=20
> 		if (delta < 0)
> 			delta =3D -delta;
> @@ -113,9 +105,12 @@ nfsd_proc_setattr(struct svc_rqst *rqstp)
> 		}
> 	}
>=20
> -	nfserr =3D nfsd_setattr(rqstp, fhp, iap, 0, (time64_t)0);
> -done:
> -	return nfsd_return_attrs(nfserr, resp);
> +	resp->status =3D nfsd_setattr(rqstp, fhp, iap, 0, (time64_t)0);
> +	if (resp->status !=3D nfs_ok)
> +		return resp->status;
> +
> +	resp->status =3D fh_getattr(&resp->fh, &resp->stat);
> +	return resp->status;
> }
>=20
> /*
> @@ -129,17 +124,19 @@ nfsd_proc_lookup(struct svc_rqst *rqstp)
> {
> 	struct nfsd_diropargs *argp =3D rqstp->rq_argp;
> 	struct nfsd_diropres *resp =3D rqstp->rq_resp;
> -	__be32	nfserr;
>=20
> 	dprintk("nfsd: LOOKUP   %s %.*s\n",
> 		SVCFH_fmt(&argp->fh), argp->len, argp->name);
>=20
> 	fh_init(&resp->fh, NFS_FHSIZE);
> -	nfserr =3D nfsd_lookup(rqstp, &argp->fh, argp->name, argp->len,
> -				 &resp->fh);
> -
> +	resp->status =3D nfsd_lookup(rqstp, &argp->fh, argp->name, =
argp->len,
> +				   &resp->fh);
> 	fh_put(&argp->fh);
> -	return nfsd_return_dirop(nfserr, resp);
> +	if (resp->status !=3D nfs_ok)
> +		return resp->status;
> +
> +	resp->status =3D fh_getattr(&resp->fh, &resp->stat);
> +	return resp->status;
> }
>=20
> /*
> @@ -150,16 +147,15 @@ nfsd_proc_readlink(struct svc_rqst *rqstp)
> {
> 	struct nfsd_readlinkargs *argp =3D rqstp->rq_argp;
> 	struct nfsd_readlinkres *resp =3D rqstp->rq_resp;
> -	__be32	nfserr;
>=20
> 	dprintk("nfsd: READLINK %s\n", SVCFH_fmt(&argp->fh));
>=20
> 	/* Read the symlink. */
> 	resp->len =3D NFS_MAXPATHLEN;
> -	nfserr =3D nfsd_readlink(rqstp, &argp->fh, argp->buffer, =
&resp->len);
> +	resp->status =3D nfsd_readlink(rqstp, &argp->fh, argp->buffer, =
&resp->len);
>=20
> 	fh_put(&argp->fh);
> -	return nfserr;
> +	return resp->status;
> }
>=20
> /*
> @@ -171,7 +167,6 @@ nfsd_proc_read(struct svc_rqst *rqstp)
> {
> 	struct nfsd_readargs *argp =3D rqstp->rq_argp;
> 	struct nfsd_readres *resp =3D rqstp->rq_resp;
> -	__be32	nfserr;
> 	u32 eof;
>=20
> 	dprintk("nfsd: READ    %s %d bytes at %d\n",
> @@ -193,14 +188,16 @@ nfsd_proc_read(struct svc_rqst *rqstp)
> 	svc_reserve_auth(rqstp, (19<<2) + argp->count + 4);
>=20
> 	resp->count =3D argp->count;
> -	nfserr =3D nfsd_read(rqstp, fh_copy(&resp->fh, &argp->fh),
> -				  argp->offset,
> -			   	  rqstp->rq_vec, argp->vlen,
> -				  &resp->count,
> -				  &eof);
> -
> -	if (nfserr) return nfserr;
> -	return fh_getattr(&resp->fh, &resp->stat);
> +	resp->status =3D nfsd_read(rqstp, fh_copy(&resp->fh, &argp->fh),
> +				 argp->offset,
> +				 rqstp->rq_vec, argp->vlen,
> +				 &resp->count,
> +				 &eof);
> +	if (resp->status !=3D nfs_ok)
> +		return resp->status;
> +
> +	resp->status =3D fh_getattr(&resp->fh, &resp->stat);
> +	return resp->status;
> }
>=20
> /*
> @@ -212,7 +209,6 @@ nfsd_proc_write(struct svc_rqst *rqstp)
> {
> 	struct nfsd_writeargs *argp =3D rqstp->rq_argp;
> 	struct nfsd_attrstat *resp =3D rqstp->rq_resp;
> -	__be32	nfserr;
> 	unsigned long cnt =3D argp->len;
> 	unsigned int nvecs;
>=20
> @@ -224,10 +220,14 @@ nfsd_proc_write(struct svc_rqst *rqstp)
> 				      &argp->first, cnt);
> 	if (!nvecs)
> 		return nfserr_io;
> -	nfserr =3D nfsd_write(rqstp, fh_copy(&resp->fh, &argp->fh),
> -			    argp->offset, rqstp->rq_vec, nvecs,
> -			    &cnt, NFS_DATA_SYNC, NULL);
> -	return nfsd_return_attrs(nfserr, resp);
> +	resp->status =3D nfsd_write(rqstp, fh_copy(&resp->fh, =
&argp->fh),
> +				  argp->offset, rqstp->rq_vec, nvecs,
> +				  &cnt, NFS_DATA_SYNC, NULL);
> +	if (resp->status !=3D nfs_ok)
> +		return resp->status;
> +
> +	resp->status =3D fh_getattr(&resp->fh, &resp->stat);
> +	return resp->status;
> }
>=20
> /*
> @@ -247,7 +247,6 @@ nfsd_proc_create(struct svc_rqst *rqstp)
> 	struct inode	*inode;
> 	struct dentry	*dchild;
> 	int		type, mode;
> -	__be32		nfserr;
> 	int		hosterr;
> 	dev_t		rdev =3D 0, wanted =3D =
new_decode_dev(attr->ia_size);
>=20
> @@ -255,40 +254,40 @@ nfsd_proc_create(struct svc_rqst *rqstp)
> 		SVCFH_fmt(dirfhp), argp->len, argp->name);
>=20
> 	/* First verify the parent file handle */
> -	nfserr =3D fh_verify(rqstp, dirfhp, S_IFDIR, NFSD_MAY_EXEC);
> -	if (nfserr)
> +	resp->status =3D fh_verify(rqstp, dirfhp, S_IFDIR, =
NFSD_MAY_EXEC);
> +	if (resp->status !=3D nfs_ok)
> 		goto done; /* must fh_put dirfhp even on error */
>=20
> 	/* Check for NFSD_MAY_WRITE in nfsd_create if necessary */
>=20
> -	nfserr =3D nfserr_exist;
> +	resp->status =3D nfserr_exist;
> 	if (isdotent(argp->name, argp->len))
> 		goto done;
> 	hosterr =3D fh_want_write(dirfhp);
> 	if (hosterr) {
> -		nfserr =3D nfserrno(hosterr);
> +		resp->status =3D nfserrno(hosterr);
> 		goto done;
> 	}
>=20
> 	fh_lock_nested(dirfhp, I_MUTEX_PARENT);
> 	dchild =3D lookup_one_len(argp->name, dirfhp->fh_dentry, =
argp->len);
> 	if (IS_ERR(dchild)) {
> -		nfserr =3D nfserrno(PTR_ERR(dchild));
> +		resp->status =3D nfserrno(PTR_ERR(dchild));
> 		goto out_unlock;
> 	}
> 	fh_init(newfhp, NFS_FHSIZE);
> -	nfserr =3D fh_compose(newfhp, dirfhp->fh_export, dchild, =
dirfhp);
> -	if (!nfserr && d_really_is_negative(dchild))
> -		nfserr =3D nfserr_noent;
> +	resp->status =3D fh_compose(newfhp, dirfhp->fh_export, dchild, =
dirfhp);
> +	if (!resp->status && d_really_is_negative(dchild))
> +		resp->status =3D nfserr_noent;
> 	dput(dchild);
> -	if (nfserr) {
> -		if (nfserr !=3D nfserr_noent)
> +	if (resp->status) {
> +		if (resp->status !=3D nfserr_noent)
> 			goto out_unlock;
> 		/*
> 		 * If the new file handle wasn't verified, we can't tell
> 		 * whether the file exists or not. Time to bail ...
> 		 */
> -		nfserr =3D nfserr_acces;
> +		resp->status =3D nfserr_acces;
> 		if (!newfhp->fh_dentry) {
> 			printk(KERN_WARNING=20
> 				"nfsd_proc_create: file handle not =
verified\n");
> @@ -321,11 +320,11 @@ nfsd_proc_create(struct svc_rqst *rqstp)
> 					 *   echo thing > =
device-special-file-or-pipe
> 					 * by doing a CREATE with =
type=3D=3D0
> 					 */
> -					nfserr =3D =
nfsd_permission(rqstp,
> +					resp->status =3D =
nfsd_permission(rqstp,
> 								 =
newfhp->fh_export,
> 								 =
newfhp->fh_dentry,
> 								 =
NFSD_MAY_WRITE|NFSD_MAY_LOCAL_ACCESS);
> -					if (nfserr && nfserr !=3D =
nfserr_rofs)
> +					if (resp->status && resp->status =
!=3D nfserr_rofs)
> 						goto out_unlock;
> 				}
> 			} else
> @@ -361,16 +360,17 @@ nfsd_proc_create(struct svc_rqst *rqstp)
> 		attr->ia_valid &=3D ~ATTR_SIZE;
>=20
> 		/* Make sure the type and device matches */
> -		nfserr =3D nfserr_exist;
> +		resp->status =3D nfserr_exist;
> 		if (inode && type !=3D (inode->i_mode & S_IFMT))
> 			goto out_unlock;
> 	}
>=20
> -	nfserr =3D 0;
> +	resp->status =3D nfs_ok;
> 	if (!inode) {
> 		/* File doesn't exist. Create it and set attrs */
> -		nfserr =3D nfsd_create_locked(rqstp, dirfhp, argp->name,
> -					argp->len, attr, type, rdev, =
newfhp);
> +		resp->status =3D nfsd_create_locked(rqstp, dirfhp, =
argp->name,
> +						  argp->len, attr, type, =
rdev,
> +						  newfhp);
> 	} else if (type =3D=3D S_IFREG) {
> 		dprintk("nfsd:   existing %s, valid=3D%x, size=3D%ld\n",
> 			argp->name, attr->ia_valid, (long) =
attr->ia_size);
> @@ -380,7 +380,8 @@ nfsd_proc_create(struct svc_rqst *rqstp)
> 		 */
> 		attr->ia_valid &=3D ATTR_SIZE;
> 		if (attr->ia_valid)
> -			nfserr =3D nfsd_setattr(rqstp, newfhp, attr, 0, =
(time64_t)0);
> +			resp->status =3D nfsd_setattr(rqstp, newfhp, =
attr, 0,
> +						    (time64_t)0);
> 	}
>=20
> out_unlock:
> @@ -389,7 +390,10 @@ nfsd_proc_create(struct svc_rqst *rqstp)
> 	fh_drop_write(dirfhp);
> done:
> 	fh_put(dirfhp);
> -	return nfsd_return_dirop(nfserr, resp);
> +	if (resp->status !=3D nfs_ok)
> +		return resp->status;
> +	resp->status =3D fh_getattr(&resp->fh, &resp->stat);
> +	return resp->status;
> }
>=20
> static __be32
> @@ -484,7 +488,6 @@ nfsd_proc_mkdir(struct svc_rqst *rqstp)
> {
> 	struct nfsd_createargs *argp =3D rqstp->rq_argp;
> 	struct nfsd_diropres *resp =3D rqstp->rq_resp;
> -	__be32	nfserr;
>=20
> 	dprintk("nfsd: MKDIR    %s %.*s\n", SVCFH_fmt(&argp->fh), =
argp->len, argp->name);
>=20
> @@ -495,10 +498,14 @@ nfsd_proc_mkdir(struct svc_rqst *rqstp)
>=20
> 	argp->attrs.ia_valid &=3D ~ATTR_SIZE;
> 	fh_init(&resp->fh, NFS_FHSIZE);
> -	nfserr =3D nfsd_create(rqstp, &argp->fh, argp->name, argp->len,
> -				    &argp->attrs, S_IFDIR, 0, =
&resp->fh);
> +	resp->status =3D nfsd_create(rqstp, &argp->fh, argp->name, =
argp->len,
> +				   &argp->attrs, S_IFDIR, 0, &resp->fh);
> 	fh_put(&argp->fh);
> -	return nfsd_return_dirop(nfserr, resp);
> +	if (resp->status !=3D nfs_ok)
> +		return resp->status;
> +
> +	resp->status =3D fh_getattr(&resp->fh, &resp->stat);
> +	return resp->status;
> }
>=20
> /*
> @@ -526,7 +533,6 @@ nfsd_proc_readdir(struct svc_rqst *rqstp)
> 	struct nfsd_readdirargs *argp =3D rqstp->rq_argp;
> 	struct nfsd_readdirres *resp =3D rqstp->rq_resp;
> 	int		count;
> -	__be32		nfserr;
> 	loff_t		offset;
>=20
> 	dprintk("nfsd: READDIR  %s %d bytes at %d\n",
> @@ -547,15 +553,15 @@ nfsd_proc_readdir(struct svc_rqst *rqstp)
> 	resp->common.err =3D nfs_ok;
> 	/* Read directory and encode entries on the fly */
> 	offset =3D argp->cookie;
> -	nfserr =3D nfsd_readdir(rqstp, &argp->fh, &offset,=20
> -			      &resp->common, nfssvc_encode_entry);
> +	resp->status =3D nfsd_readdir(rqstp, &argp->fh, &offset,
> +				    &resp->common, nfssvc_encode_entry);
>=20
> 	resp->count =3D resp->buffer - argp->buffer;
> 	if (resp->offset)
> 		*resp->offset =3D htonl(offset);
>=20
> 	fh_put(&argp->fh);
> -	return nfserr;
> +	return resp->status;
> }
>=20
> /*
> @@ -566,14 +572,13 @@ nfsd_proc_statfs(struct svc_rqst *rqstp)
> {
> 	struct nfsd_fhandle *argp =3D rqstp->rq_argp;
> 	struct nfsd_statfsres *resp =3D rqstp->rq_resp;
> -	__be32	nfserr;
>=20
> 	dprintk("nfsd: STATFS   %s\n", SVCFH_fmt(&argp->fh));
>=20
> -	nfserr =3D nfsd_statfs(rqstp, &argp->fh, &resp->stats,
> -			NFSD_MAY_BYPASS_GSS_ON_ROOT);
> +	resp->status =3D nfsd_statfs(rqstp, &argp->fh, &resp->stats,
> +				   NFSD_MAY_BYPASS_GSS_ON_ROOT);
> 	fh_put(&argp->fh);
> -	return nfserr;
> +	return resp->status;
> }
>=20
> /*
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 08776b44cde6..9faf9224ef62 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -1056,12 +1056,8 @@ int nfsd_dispatch(struct svc_rqst *rqstp, =
__be32 *statp)
> 	if (rqstp->rq_proc !=3D 0)
> 		*p++ =3D nfserr;
>=20
> -	/*
> -	 * For NFSv2, additional info is never returned in case of an =
error.
> -	 */
> -	if (!(nfserr && rqstp->rq_vers =3D=3D 2))
> -		if (!proc->pc_encode(rqstp, p))
> -			goto out_encode_err;
> +	if (!proc->pc_encode(rqstp, p))
> +		goto out_encode_err;
>=20
> 	nfsd_cache_update(rqstp, rqstp->rq_cachetype, statp + 1);
> out_cached_reply:
> diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
> index 39c004ec7d85..952e71c95d4e 100644
> --- a/fs/nfsd/nfsxdr.c
> +++ b/fs/nfsd/nfsxdr.c
> @@ -434,6 +434,9 @@ nfssvc_encode_attrstat(struct svc_rqst *rqstp, =
__be32 *p)
> {
> 	struct nfsd_attrstat *resp =3D rqstp->rq_resp;
>=20
> +	if (resp->status !=3D nfs_ok)
> +		return xdr_ressize_check(rqstp, p);
> +
> 	p =3D encode_fattr(rqstp, p, &resp->fh, &resp->stat);
> 	return xdr_ressize_check(rqstp, p);
> }
> @@ -443,6 +446,9 @@ nfssvc_encode_diropres(struct svc_rqst *rqstp, =
__be32 *p)
> {
> 	struct nfsd_diropres *resp =3D rqstp->rq_resp;
>=20
> +	if (resp->status !=3D nfs_ok)
> +		return xdr_ressize_check(rqstp, p);
> +
> 	p =3D encode_fh(p, &resp->fh);
> 	p =3D encode_fattr(rqstp, p, &resp->fh, &resp->stat);
> 	return xdr_ressize_check(rqstp, p);
> @@ -453,6 +459,9 @@ nfssvc_encode_readlinkres(struct svc_rqst *rqstp, =
__be32 *p)
> {
> 	struct nfsd_readlinkres *resp =3D rqstp->rq_resp;
>=20
> +	if (resp->status !=3D nfs_ok)
> +		return xdr_ressize_check(rqstp, p);
> +
> 	*p++ =3D htonl(resp->len);
> 	xdr_ressize_check(rqstp, p);
> 	rqstp->rq_res.page_len =3D resp->len;
> @@ -470,6 +479,9 @@ nfssvc_encode_readres(struct svc_rqst *rqstp, =
__be32 *p)
> {
> 	struct nfsd_readres *resp =3D rqstp->rq_resp;
>=20
> +	if (resp->status !=3D nfs_ok)
> +		return xdr_ressize_check(rqstp, p);
> +
> 	p =3D encode_fattr(rqstp, p, &resp->fh, &resp->stat);
> 	*p++ =3D htonl(resp->count);
> 	xdr_ressize_check(rqstp, p);
> @@ -490,6 +502,9 @@ nfssvc_encode_readdirres(struct svc_rqst *rqstp, =
__be32 *p)
> {
> 	struct nfsd_readdirres *resp =3D rqstp->rq_resp;
>=20
> +	if (resp->status !=3D nfs_ok)
> +		return xdr_ressize_check(rqstp, p);
> +
> 	xdr_ressize_check(rqstp, p);
> 	p =3D resp->buffer;
> 	*p++ =3D 0;			/* no more entries */
> @@ -505,6 +520,9 @@ nfssvc_encode_statfsres(struct svc_rqst *rqstp, =
__be32 *p)
> 	struct nfsd_statfsres *resp =3D rqstp->rq_resp;
> 	struct kstatfs	*stat =3D &resp->stats;
>=20
> +	if (resp->status !=3D nfs_ok)
> +		return xdr_ressize_check(rqstp, p);
> +
> 	*p++ =3D htonl(NFSSVC_MAXBLKSIZE_V2);	/* max transfer size */
> 	*p++ =3D htonl(stat->f_bsize);
> 	*p++ =3D htonl(stat->f_blocks);
> diff --git a/fs/nfsd/xdr.h b/fs/nfsd/xdr.h
> index 3d3e16d48268..17221931815f 100644
> --- a/fs/nfsd/xdr.h
> +++ b/fs/nfsd/xdr.h
> @@ -83,26 +83,32 @@ struct nfsd_readdirargs {
> };
>=20
> struct nfsd_attrstat {
> +	__be32			status;
> 	struct svc_fh		fh;
> 	struct kstat		stat;
> };
>=20
> struct nfsd_diropres  {
> +	__be32			status;
> 	struct svc_fh		fh;
> 	struct kstat		stat;
> };
>=20
> struct nfsd_readlinkres {
> +	__be32			status;
> 	int			len;
> };
>=20
> struct nfsd_readres {
> +	__be32			status;
> 	struct svc_fh		fh;
> 	unsigned long		count;
> 	struct kstat		stat;
> };
>=20
> struct nfsd_readdirres {
> +	__be32			status;
> +
> 	int			count;
>=20
> 	struct readdir_cd	common;
> @@ -112,6 +118,7 @@ struct nfsd_readdirres {
> };
>=20
> struct nfsd_statfsres {
> +	__be32			status;
> 	struct kstatfs		stats;
> };
>=20
>=20
>=20

--
Chuck Lever



