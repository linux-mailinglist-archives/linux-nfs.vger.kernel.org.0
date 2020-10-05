Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12DE283738
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Oct 2020 16:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgJEOCU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 5 Oct 2020 10:02:20 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37052 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgJEOCO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 5 Oct 2020 10:02:14 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 095DtLGI188073;
        Mon, 5 Oct 2020 14:02:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=ChOxR78PkiG/M8IZzyjxU6sUJGI5ymtnq+loh8Eelnw=;
 b=bMLSVi1/CODZMbKrs7lly7J17K9yaXlzYgvlfb5vh0WfdMRKK3ZmtqzhGqdLik0E83L2
 34kp8wjPvEoy7G8kwV1ZRPrCE3Q6nX/tJ0f11oPyr68dpNZRDpe1KmN139KZqlNFnf+E
 jmvVNU46FSjGXp/MhvGTMJ1sqtuPxAxsRTa3T2bgjSm0JOFj0258t+MiDK7l5eESQfbh
 WvUDZPRzhkEgGpV+zkpyYqgL135/SNjNN4zsnOY1Rp0NoeQHwPPMBCGPQFwC4v86EpYb
 Ls7D1gXAqZhrCnBLRJeN/Msw2HGlXnwasjUUhi0CrIyoVwxRWFtUSG9QlhGpjtAulfyw xQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 33xhxmnk1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 05 Oct 2020 14:02:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 095E05Gs001076;
        Mon, 5 Oct 2020 14:00:06 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 33y37vax7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Oct 2020 14:00:05 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 095E02rh025287;
        Mon, 5 Oct 2020 14:00:03 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 05 Oct 2020 07:00:01 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] NFSD: Hoist status code encoding into XDR encoder
 functions
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201005133944.GC31739@fieldses.org>
Date:   Mon, 5 Oct 2020 10:00:00 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <21061EA8-183F-44F1-9E49-29F334374B00@oracle.com>
References: <160166823673.1131.2814932313329192119.stgit@klimt.1015granger.net>
 <20201005133944.GC31739@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9764 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010050106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9764 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010050105
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 5, 2020, at 9:39 AM, J. Bruce Fields <bfields@fieldses.org> =
wrote:
>=20
> On Fri, Oct 02, 2020 at 03:52:44PM -0400, Chuck Lever wrote:
>> The original intent was presumably to reduce code duplication. The
>> trade-off was:
>>=20
>> - No support for an NFSD proc function returning a non-success
>>  RPC accept_stat value.
>> - No support for void NFS replies to non-NULL procedures.
>> - Everyone pays for the deduplication with a few extra conditional
>>  branches in a hot path.
>>=20
>> In addition, nfsd_dispatch() leaves *statp uninitialized in the
>> success path, unlike svc_generic_dispatch().
>>=20
>> Address all of these problems by moving the logic for encoding
>> the NFS status code into the NFS XDR encoders themselves. Then
>> update the NFS .pc_func methods to return an RPC accept_stat
>> value.
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> Hi Bruce-
>>=20
>> This patch seems to enable GATT9, COMP4, and COMP6 to PASS. It
>> replaces "[PATCH v3 15/15] NFSD: Hoist status code encoding into XDR
>> encoder functions".
>=20
> Thanks!
>=20
> So they were failing to set nfserr_resource in the args->opcnt >
> NFSD_MAX_OPS_PER_COMPOUND case?

Previously, the code set "status" to nfserr_resource, and then
branched to "out:", which returned "status".

The new code is supposed to plant status in cstate->status before
returning, but these early checks branch over that assignment.


> --b.
>=20
>>=20
>> fs/nfsd/nfs2acl.c  |   19 ++++++---
>> fs/nfsd/nfs3acl.c  |    9 ++--
>> fs/nfsd/nfs3proc.c |   44 ++++++++++-----------
>> fs/nfsd/nfs3xdr.c  |   19 +++++++--
>> fs/nfsd/nfs4proc.c |    7 +--
>> fs/nfsd/nfs4xdr.c  |    5 +-
>> fs/nfsd/nfsproc.c  |  111 =
++++++++++++++++++++++++++--------------------------
>> fs/nfsd/nfssvc.c   |   21 ++--------
>> fs/nfsd/nfsxdr.c   |   23 +++++++++--
>> fs/nfsd/xdr.h      |    5 ++
>> 10 files changed, 144 insertions(+), 119 deletions(-)
>>=20
>> diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
>> index 6f46afdb0616..6a900f770dd2 100644
>> --- a/fs/nfsd/nfs2acl.c
>> +++ b/fs/nfsd/nfs2acl.c
>> @@ -21,7 +21,7 @@
>> static __be32
>> nfsacld_proc_null(struct svc_rqst *rqstp)
>> {
>> -	return nfs_ok;
>> +	return rpc_success;
>> }
>>=20
>> /*
>> @@ -79,7 +79,7 @@ static __be32 nfsacld_proc_getacl(struct svc_rqst =
*rqstp)
>>=20
>> 	/* resp->acl_{access,default} are released in =
nfssvc_release_getacl. */
>> out:
>> -	return resp->status;
>> +	return rpc_success;
>>=20
>> fail:
>> 	posix_acl_release(resp->acl_access);
>> @@ -131,7 +131,7 @@ static __be32 nfsacld_proc_setacl(struct svc_rqst =
*rqstp)
>> 	   nfssvc_decode_setaclargs. */
>> 	posix_acl_release(argp->acl_access);
>> 	posix_acl_release(argp->acl_default);
>> -	return resp->status;
>> +	return rpc_success;
>>=20
>> out_drop_lock:
>> 	fh_unlock(fh);
>> @@ -157,7 +157,7 @@ static __be32 nfsacld_proc_getattr(struct =
svc_rqst *rqstp)
>> 		goto out;
>> 	resp->status =3D fh_getattr(&resp->fh, &resp->stat);
>> out:
>> -	return resp->status;
>> +	return rpc_success;
>> }
>>=20
>> /*
>> @@ -179,7 +179,7 @@ static __be32 nfsacld_proc_access(struct svc_rqst =
*rqstp)
>> 		goto out;
>> 	resp->status =3D fh_getattr(&resp->fh, &resp->stat);
>> out:
>> -	return resp->status;
>> +	return rpc_success;
>> }
>>=20
>> /*
>> @@ -275,6 +275,7 @@ static int nfsaclsvc_encode_getaclres(struct =
svc_rqst *rqstp, __be32 *p)
>> 	int n;
>> 	int w;
>>=20
>> +	*p++ =3D resp->status;
>> 	if (resp->status !=3D nfs_ok)
>> 		return xdr_ressize_check(rqstp, p);
>>=20
>> @@ -317,10 +318,12 @@ static int nfsaclsvc_encode_attrstatres(struct =
svc_rqst *rqstp, __be32 *p)
>> {
>> 	struct nfsd_attrstat *resp =3D rqstp->rq_resp;
>>=20
>> +	*p++ =3D resp->status;
>> 	if (resp->status !=3D nfs_ok)
>> -		return xdr_ressize_check(rqstp, p);
>> +		goto out;
>>=20
>> 	p =3D nfs2svc_encode_fattr(rqstp, p, &resp->fh, &resp->stat);
>> +out:
>> 	return xdr_ressize_check(rqstp, p);
>> }
>>=20
>> @@ -329,11 +332,13 @@ static int nfsaclsvc_encode_accessres(struct =
svc_rqst *rqstp, __be32 *p)
>> {
>> 	struct nfsd3_accessres *resp =3D rqstp->rq_resp;
>>=20
>> +	*p++ =3D resp->status;
>> 	if (resp->status !=3D nfs_ok)
>> -		return xdr_ressize_check(rqstp, p);
>> +		goto out;
>>=20
>> 	p =3D nfs2svc_encode_fattr(rqstp, p, &resp->fh, &resp->stat);
>> 	*p++ =3D htonl(resp->access);
>> +out:
>> 	return xdr_ressize_check(rqstp, p);
>> }
>>=20
>> diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
>> index 3fee24dee98c..34a394e50e1d 100644
>> --- a/fs/nfsd/nfs3acl.c
>> +++ b/fs/nfsd/nfs3acl.c
>> @@ -19,7 +19,7 @@
>> static __be32
>> nfsd3_proc_null(struct svc_rqst *rqstp)
>> {
>> -	return nfs_ok;
>> +	return rpc_success;
>> }
>>=20
>> /*
>> @@ -71,7 +71,7 @@ static __be32 nfsd3_proc_getacl(struct svc_rqst =
*rqstp)
>>=20
>> 	/* resp->acl_{access,default} are released in =
nfs3svc_release_getacl. */
>> out:
>> -	return resp->status;
>> +	return rpc_success;
>>=20
>> fail:
>> 	posix_acl_release(resp->acl_access);
>> @@ -118,7 +118,7 @@ static __be32 nfsd3_proc_setacl(struct svc_rqst =
*rqstp)
>> 	   nfs3svc_decode_setaclargs. */
>> 	posix_acl_release(argp->acl_access);
>> 	posix_acl_release(argp->acl_default);
>> -	return resp->status;
>> +	return rpc_success;
>> }
>>=20
>> /*
>> @@ -173,6 +173,7 @@ static int nfs3svc_encode_getaclres(struct =
svc_rqst *rqstp, __be32 *p)
>> 	struct nfsd3_getaclres *resp =3D rqstp->rq_resp;
>> 	struct dentry *dentry =3D resp->fh.fh_dentry;
>>=20
>> +	*p++ =3D resp->status;
>> 	p =3D nfs3svc_encode_post_op_attr(rqstp, p, &resp->fh);
>> 	if (resp->status =3D=3D 0 && dentry && =
d_really_is_positive(dentry)) {
>> 		struct inode *inode =3D d_inode(dentry);
>> @@ -217,8 +218,8 @@ static int nfs3svc_encode_setaclres(struct =
svc_rqst *rqstp, __be32 *p)
>> {
>> 	struct nfsd3_attrstat *resp =3D rqstp->rq_resp;
>>=20
>> +	*p++ =3D resp->status;
>> 	p =3D nfs3svc_encode_post_op_attr(rqstp, p, &resp->fh);
>> -
>> 	return xdr_ressize_check(rqstp, p);
>> }
>>=20
>> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
>> index 1d2c149e5ff4..14468613d150 100644
>> --- a/fs/nfsd/nfs3proc.c
>> +++ b/fs/nfsd/nfs3proc.c
>> @@ -32,7 +32,7 @@ static int	nfs3_ftypes[] =3D {
>> static __be32
>> nfsd3_proc_null(struct svc_rqst *rqstp)
>> {
>> -	return nfs_ok;
>> +	return rpc_success;
>> }
>>=20
>> /*
>> @@ -55,7 +55,7 @@ nfsd3_proc_getattr(struct svc_rqst *rqstp)
>>=20
>> 	resp->status =3D fh_getattr(&resp->fh, &resp->stat);
>> out:
>> -	return resp->status;
>> +	return rpc_success;
>> }
>>=20
>> /*
>> @@ -73,7 +73,7 @@ nfsd3_proc_setattr(struct svc_rqst *rqstp)
>> 	fh_copy(&resp->fh, &argp->fh);
>> 	resp->status =3D nfsd_setattr(rqstp, &resp->fh, &argp->attrs,
>> 				    argp->check_guard, argp->guardtime);
>> -	return resp->status;
>> +	return rpc_success;
>> }
>>=20
>> /*
>> @@ -96,7 +96,7 @@ nfsd3_proc_lookup(struct svc_rqst *rqstp)
>> 	resp->status =3D nfsd_lookup(rqstp, &resp->dirfh,
>> 				   argp->name, argp->len,
>> 				   &resp->fh);
>> -	return resp->status;
>> +	return rpc_success;
>> }
>>=20
>> /*
>> @@ -115,7 +115,7 @@ nfsd3_proc_access(struct svc_rqst *rqstp)
>> 	fh_copy(&resp->fh, &argp->fh);
>> 	resp->access =3D argp->access;
>> 	resp->status =3D nfsd_access(rqstp, &resp->fh, &resp->access, =
NULL);
>> -	return resp->status;
>> +	return rpc_success;
>> }
>>=20
>> /*
>> @@ -133,7 +133,7 @@ nfsd3_proc_readlink(struct svc_rqst *rqstp)
>> 	fh_copy(&resp->fh, &argp->fh);
>> 	resp->len =3D NFS3_MAXPATHLEN;
>> 	resp->status =3D nfsd_readlink(rqstp, &resp->fh, argp->buffer, =
&resp->len);
>> -	return resp->status;
>> +	return rpc_success;
>> }
>>=20
>> /*
>> @@ -163,7 +163,7 @@ nfsd3_proc_read(struct svc_rqst *rqstp)
>> 	resp->status =3D nfsd_read(rqstp, &resp->fh, argp->offset,
>> 				 rqstp->rq_vec, argp->vlen, =
&resp->count,
>> 				 &resp->eof);
>> -	return resp->status;
>> +	return rpc_success;
>> }
>>=20
>> /*
>> @@ -196,7 +196,7 @@ nfsd3_proc_write(struct svc_rqst *rqstp)
>> 				  resp->committed, resp->verf);
>> 	resp->count =3D cnt;
>> out:
>> -	return resp->status;
>> +	return rpc_success;
>> }
>>=20
>> /*
>> @@ -234,7 +234,7 @@ nfsd3_proc_create(struct svc_rqst *rqstp)
>> 	resp->status =3D do_nfsd_create(rqstp, dirfhp, argp->name, =
argp->len,
>> 				      attr, newfhp, argp->createmode,
>> 				      (u32 *)argp->verf, NULL, NULL);
>> -	return resp->status;
>> +	return rpc_success;
>> }
>>=20
>> /*
>> @@ -257,7 +257,7 @@ nfsd3_proc_mkdir(struct svc_rqst *rqstp)
>> 	resp->status =3D nfsd_create(rqstp, &resp->dirfh, argp->name, =
argp->len,
>> 				   &argp->attrs, S_IFDIR, 0, &resp->fh);
>> 	fh_unlock(&resp->dirfh);
>> -	return resp->status;
>> +	return rpc_success;
>> }
>>=20
>> static __be32
>> @@ -294,7 +294,7 @@ nfsd3_proc_symlink(struct svc_rqst *rqstp)
>> 				    argp->flen, argp->tname, &resp->fh);
>> 	kfree(argp->tname);
>> out:
>> -	return resp->status;
>> +	return rpc_success;
>> }
>>=20
>> /*
>> @@ -337,7 +337,7 @@ nfsd3_proc_mknod(struct svc_rqst *rqstp)
>> 				   &argp->attrs, type, rdev, &resp->fh);
>> 	fh_unlock(&resp->dirfh);
>> out:
>> -	return resp->status;
>> +	return rpc_success;
>> }
>>=20
>> /*
>> @@ -359,7 +359,7 @@ nfsd3_proc_remove(struct svc_rqst *rqstp)
>> 	resp->status =3D nfsd_unlink(rqstp, &resp->fh, -S_IFDIR,
>> 				   argp->name, argp->len);
>> 	fh_unlock(&resp->fh);
>> -	return resp->status;
>> +	return rpc_success;
>> }
>>=20
>> /*
>> @@ -380,7 +380,7 @@ nfsd3_proc_rmdir(struct svc_rqst *rqstp)
>> 	resp->status =3D nfsd_unlink(rqstp, &resp->fh, S_IFDIR,
>> 				   argp->name, argp->len);
>> 	fh_unlock(&resp->fh);
>> -	return resp->status;
>> +	return rpc_success;
>> }
>>=20
>> static __be32
>> @@ -402,7 +402,7 @@ nfsd3_proc_rename(struct svc_rqst *rqstp)
>> 	fh_copy(&resp->tfh, &argp->tfh);
>> 	resp->status =3D nfsd_rename(rqstp, &resp->ffh, argp->fname, =
argp->flen,
>> 				   &resp->tfh, argp->tname, argp->tlen);
>> -	return resp->status;
>> +	return rpc_success;
>> }
>>=20
>> static __be32
>> @@ -422,7 +422,7 @@ nfsd3_proc_link(struct svc_rqst *rqstp)
>> 	fh_copy(&resp->tfh, &argp->tfh);
>> 	resp->status =3D nfsd_link(rqstp, &resp->tfh, argp->tname, =
argp->tlen,
>> 				 &resp->fh);
>> -	return resp->status;
>> +	return rpc_success;
>> }
>>=20
>> /*
>> @@ -481,7 +481,7 @@ nfsd3_proc_readdir(struct svc_rqst *rqstp)
>> 		resp->offset =3D NULL;
>> 	}
>>=20
>> -	return resp->status;
>> +	return rpc_success;
>> }
>>=20
>> /*
>> @@ -551,7 +551,7 @@ nfsd3_proc_readdirplus(struct svc_rqst *rqstp)
>> 	}
>>=20
>> out:
>> -	return resp->status;
>> +	return rpc_success;
>> }
>>=20
>> /*
>> @@ -568,7 +568,7 @@ nfsd3_proc_fsstat(struct svc_rqst *rqstp)
>>=20
>> 	resp->status =3D nfsd_statfs(rqstp, &argp->fh, &resp->stats, 0);
>> 	fh_put(&argp->fh);
>> -	return resp->status;
>> +	return rpc_success;
>> }
>>=20
>> /*
>> @@ -611,7 +611,7 @@ nfsd3_proc_fsinfo(struct svc_rqst *rqstp)
>> 	}
>>=20
>> 	fh_put(&argp->fh);
>> -	return resp->status;
>> +	return rpc_success;
>> }
>>=20
>> /*
>> @@ -653,7 +653,7 @@ nfsd3_proc_pathconf(struct svc_rqst *rqstp)
>> 	}
>>=20
>> 	fh_put(&argp->fh);
>> -	return resp->status;
>> +	return rpc_success;
>> }
>>=20
>> /*
>> @@ -679,7 +679,7 @@ nfsd3_proc_commit(struct svc_rqst *rqstp)
>> 	resp->status =3D nfsd_commit(rqstp, &resp->fh, argp->offset,
>> 				   argp->count, resp->verf);
>> out:
>> -	return resp->status;
>> +	return rpc_success;
>> }
>>=20
>>=20
>> diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
>> index e540fd1a29d8..9c23b6acf234 100644
>> --- a/fs/nfsd/nfs3xdr.c
>> +++ b/fs/nfsd/nfs3xdr.c
>> @@ -641,10 +641,7 @@ nfs3svc_decode_commitargs(struct svc_rqst =
*rqstp, __be32 *p)
>> /*
>>  * XDR encode functions
>>  */
>> -/*
>> - * There must be an encoding function for void results so =
svc_process
>> - * will work properly.
>> - */
>> +
>> int
>> nfs3svc_encode_voidres(struct svc_rqst *rqstp, __be32 *p)
>> {
>> @@ -657,6 +654,7 @@ nfs3svc_encode_attrstat(struct svc_rqst *rqstp, =
__be32 *p)
>> {
>> 	struct nfsd3_attrstat *resp =3D rqstp->rq_resp;
>>=20
>> +	*p++ =3D resp->status;
>> 	if (resp->status =3D=3D 0) {
>> 		lease_get_mtime(d_inode(resp->fh.fh_dentry),
>> 				&resp->stat.mtime);
>> @@ -671,6 +669,7 @@ nfs3svc_encode_wccstat(struct svc_rqst *rqstp, =
__be32 *p)
>> {
>> 	struct nfsd3_attrstat *resp =3D rqstp->rq_resp;
>>=20
>> +	*p++ =3D resp->status;
>> 	p =3D encode_wcc_data(rqstp, p, &resp->fh);
>> 	return xdr_ressize_check(rqstp, p);
>> }
>> @@ -681,6 +680,7 @@ nfs3svc_encode_diropres(struct svc_rqst *rqstp, =
__be32 *p)
>> {
>> 	struct nfsd3_diropres *resp =3D rqstp->rq_resp;
>>=20
>> +	*p++ =3D resp->status;
>> 	if (resp->status =3D=3D 0) {
>> 		p =3D encode_fh(p, &resp->fh);
>> 		p =3D encode_post_op_attr(rqstp, p, &resp->fh);
>> @@ -695,6 +695,7 @@ nfs3svc_encode_accessres(struct svc_rqst *rqstp, =
__be32 *p)
>> {
>> 	struct nfsd3_accessres *resp =3D rqstp->rq_resp;
>>=20
>> +	*p++ =3D resp->status;
>> 	p =3D encode_post_op_attr(rqstp, p, &resp->fh);
>> 	if (resp->status =3D=3D 0)
>> 		*p++ =3D htonl(resp->access);
>> @@ -707,6 +708,7 @@ nfs3svc_encode_readlinkres(struct svc_rqst =
*rqstp, __be32 *p)
>> {
>> 	struct nfsd3_readlinkres *resp =3D rqstp->rq_resp;
>>=20
>> +	*p++ =3D resp->status;
>> 	p =3D encode_post_op_attr(rqstp, p, &resp->fh);
>> 	if (resp->status =3D=3D 0) {
>> 		*p++ =3D htonl(resp->len);
>> @@ -729,6 +731,7 @@ nfs3svc_encode_readres(struct svc_rqst *rqstp, =
__be32 *p)
>> {
>> 	struct nfsd3_readres *resp =3D rqstp->rq_resp;
>>=20
>> +	*p++ =3D resp->status;
>> 	p =3D encode_post_op_attr(rqstp, p, &resp->fh);
>> 	if (resp->status =3D=3D 0) {
>> 		*p++ =3D htonl(resp->count);
>> @@ -754,6 +757,7 @@ nfs3svc_encode_writeres(struct svc_rqst *rqstp, =
__be32 *p)
>> {
>> 	struct nfsd3_writeres *resp =3D rqstp->rq_resp;
>>=20
>> +	*p++ =3D resp->status;
>> 	p =3D encode_wcc_data(rqstp, p, &resp->fh);
>> 	if (resp->status =3D=3D 0) {
>> 		*p++ =3D htonl(resp->count);
>> @@ -770,6 +774,7 @@ nfs3svc_encode_createres(struct svc_rqst *rqstp, =
__be32 *p)
>> {
>> 	struct nfsd3_diropres *resp =3D rqstp->rq_resp;
>>=20
>> +	*p++ =3D resp->status;
>> 	if (resp->status =3D=3D 0) {
>> 		*p++ =3D xdr_one;
>> 		p =3D encode_fh(p, &resp->fh);
>> @@ -785,6 +790,7 @@ nfs3svc_encode_renameres(struct svc_rqst *rqstp, =
__be32 *p)
>> {
>> 	struct nfsd3_renameres *resp =3D rqstp->rq_resp;
>>=20
>> +	*p++ =3D resp->status;
>> 	p =3D encode_wcc_data(rqstp, p, &resp->ffh);
>> 	p =3D encode_wcc_data(rqstp, p, &resp->tfh);
>> 	return xdr_ressize_check(rqstp, p);
>> @@ -796,6 +802,7 @@ nfs3svc_encode_linkres(struct svc_rqst *rqstp, =
__be32 *p)
>> {
>> 	struct nfsd3_linkres *resp =3D rqstp->rq_resp;
>>=20
>> +	*p++ =3D resp->status;
>> 	p =3D encode_post_op_attr(rqstp, p, &resp->fh);
>> 	p =3D encode_wcc_data(rqstp, p, &resp->tfh);
>> 	return xdr_ressize_check(rqstp, p);
>> @@ -807,6 +814,7 @@ nfs3svc_encode_readdirres(struct svc_rqst *rqstp, =
__be32 *p)
>> {
>> 	struct nfsd3_readdirres *resp =3D rqstp->rq_resp;
>>=20
>> +	*p++ =3D resp->status;
>> 	p =3D encode_post_op_attr(rqstp, p, &resp->fh);
>>=20
>> 	if (resp->status =3D=3D 0) {
>> @@ -1059,6 +1067,7 @@ nfs3svc_encode_fsstatres(struct svc_rqst =
*rqstp, __be32 *p)
>> 	struct kstatfs	*s =3D &resp->stats;
>> 	u64		bs =3D s->f_bsize;
>>=20
>> +	*p++ =3D resp->status;
>> 	*p++ =3D xdr_zero;	/* no post_op_attr */
>>=20
>> 	if (resp->status =3D=3D 0) {
>> @@ -1079,6 +1088,7 @@ nfs3svc_encode_fsinfores(struct svc_rqst =
*rqstp, __be32 *p)
>> {
>> 	struct nfsd3_fsinfores *resp =3D rqstp->rq_resp;
>>=20
>> +	*p++ =3D resp->status;
>> 	*p++ =3D xdr_zero;	/* no post_op_attr */
>>=20
>> 	if (resp->status =3D=3D 0) {
>> @@ -1124,6 +1134,7 @@ nfs3svc_encode_commitres(struct svc_rqst =
*rqstp, __be32 *p)
>> {
>> 	struct nfsd3_commitres *resp =3D rqstp->rq_resp;
>>=20
>> +	*p++ =3D resp->status;
>> 	p =3D encode_wcc_data(rqstp, p, &resp->fh);
>> 	/* Write verifier */
>> 	if (resp->status =3D=3D 0) {
>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>> index b99c050797db..025768a216b5 100644
>> --- a/fs/nfsd/nfs4proc.c
>> +++ b/fs/nfsd/nfs4proc.c
>> @@ -2165,7 +2165,7 @@ nfsd4_removexattr(struct svc_rqst *rqstp, =
struct nfsd4_compound_state *cstate,
>> static __be32
>> nfsd4_proc_null(struct svc_rqst *rqstp)
>> {
>> -	return nfs_ok;
>> +	return rpc_success;
>> }
>>=20
>> static inline void nfsd4_increment_op_stats(u32 opnum)
>> @@ -2457,15 +2457,14 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
>> 		nfsd4_increment_op_stats(op->opnum);
>> 	}
>>=20
>> -	cstate->status =3D status;
>> 	fh_put(current_fh);
>> 	fh_put(save_fh);
>> 	BUG_ON(cstate->replay_owner);
>> out:
>> +	cstate->status =3D status;
>> 	/* Reset deferral mechanism for RPC deferrals */
>> 	set_bit(RQ_USEDEFERRAL, &rqstp->rq_flags);
>> -	dprintk("nfsv4 compound returned %d\n", ntohl(status));
>> -	return status;
>> +	return rpc_success;
>> }
>>=20
>> #define op_encode_hdr_size		(2)
>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>> index 758d8154a5b3..073f8be7555c 100644
>> --- a/fs/nfsd/nfs4xdr.c
>> +++ b/fs/nfsd/nfs4xdr.c
>> @@ -5189,15 +5189,14 @@ nfs4svc_decode_compoundargs(struct svc_rqst =
*rqstp, __be32 *p)
>> int
>> nfs4svc_encode_compoundres(struct svc_rqst *rqstp, __be32 *p)
>> {
>> -	/*
>> -	 * All that remains is to write the tag and operation count...
>> -	 */
>> 	struct nfsd4_compoundres *resp =3D rqstp->rq_resp;
>> 	struct xdr_buf *buf =3D resp->xdr.buf;
>>=20
>> 	WARN_ON_ONCE(buf->len !=3D buf->head[0].iov_len + buf->page_len =
+
>> 				 buf->tail[0].iov_len);
>>=20
>> +	*p =3D resp->cstate.status;
>> +
>> 	rqstp->rq_next_page =3D resp->xdr.page_ptr + 1;
>>=20
>> 	p =3D resp->tagp;
>> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
>> index 526170319ecf..f2450c719032 100644
>> --- a/fs/nfsd/nfsproc.c
>> +++ b/fs/nfsd/nfsproc.c
>> @@ -16,7 +16,7 @@
>> static __be32
>> nfsd_proc_null(struct svc_rqst *rqstp)
>> {
>> -	return nfs_ok;
>> +	return rpc_success;
>> }
>>=20
>> /*
>> @@ -38,7 +38,7 @@ nfsd_proc_getattr(struct svc_rqst *rqstp)
>> 		goto out;
>> 	resp->status =3D fh_getattr(&resp->fh, &resp->stat);
>> out:
>> -	return resp->status;
>> +	return rpc_success;
>> }
>>=20
>> /*
>> @@ -106,14 +106,14 @@ nfsd_proc_setattr(struct svc_rqst *rqstp)
>>=20
>> 	resp->status =3D fh_getattr(&resp->fh, &resp->stat);
>> out:
>> -	return resp->status;
>> +	return rpc_success;
>> }
>>=20
>> /* Obsolete, replaced by MNTPROC_MNT. */
>> static __be32
>> nfsd_proc_root(struct svc_rqst *rqstp)
>> {
>> -	return nfs_ok;
>> +	return rpc_success;
>> }
>>=20
>> /*
>> @@ -140,7 +140,7 @@ nfsd_proc_lookup(struct svc_rqst *rqstp)
>>=20
>> 	resp->status =3D fh_getattr(&resp->fh, &resp->stat);
>> out:
>> -	return resp->status;
>> +	return rpc_success;
>> }
>>=20
>> /*
>> @@ -159,7 +159,7 @@ nfsd_proc_readlink(struct svc_rqst *rqstp)
>> 	resp->status =3D nfsd_readlink(rqstp, &argp->fh, argp->buffer, =
&resp->len);
>>=20
>> 	fh_put(&argp->fh);
>> -	return resp->status;
>> +	return rpc_success;
>> }
>>=20
>> /*
>> @@ -197,19 +197,18 @@ nfsd_proc_read(struct svc_rqst *rqstp)
>> 				 rqstp->rq_vec, argp->vlen,
>> 				 &resp->count,
>> 				 &eof);
>> -	if (resp->status !=3D nfs_ok)
>> -		goto out;
>> -
>> -	resp->status =3D fh_getattr(&resp->fh, &resp->stat);
>> -out:
>> -	return resp->status;
>> +	if (resp->status =3D=3D nfs_ok)
>> +		resp->status =3D fh_getattr(&resp->fh, &resp->stat);
>> +	else if (resp->status =3D=3D nfserr_jukebox)
>> +		return rpc_drop_reply;
>> +	return rpc_success;
>> }
>>=20
>> /* Reserved */
>> static __be32
>> nfsd_proc_writecache(struct svc_rqst *rqstp)
>> {
>> -	return nfs_ok;
>> +	return rpc_success;
>> }
>>=20
>> /*
>> @@ -238,12 +237,12 @@ nfsd_proc_write(struct svc_rqst *rqstp)
>> 	resp->status =3D nfsd_write(rqstp, fh_copy(&resp->fh, =
&argp->fh),
>> 				  argp->offset, rqstp->rq_vec, nvecs,
>> 				  &cnt, NFS_DATA_SYNC, NULL);
>> -	if (resp->status !=3D nfs_ok)
>> -		goto out;
>> -
>> -	resp->status =3D fh_getattr(&resp->fh, &resp->stat);
>> +	if (resp->status =3D=3D nfs_ok)
>> +		resp->status =3D fh_getattr(&resp->fh, &resp->stat);
>> +	else if (resp->status =3D=3D nfserr_jukebox)
>> +		return rpc_drop_reply;
>> out:
>> -	return resp->status;
>> +	return rpc_success;
>> }
>>=20
>> /*
>> @@ -410,47 +409,48 @@ nfsd_proc_create(struct svc_rqst *rqstp)
>> 		goto out;
>> 	resp->status =3D fh_getattr(&resp->fh, &resp->stat);
>> out:
>> -	return resp->status;
>> +	return rpc_success;
>> }
>>=20
>> static __be32
>> nfsd_proc_remove(struct svc_rqst *rqstp)
>> {
>> 	struct nfsd_diropargs *argp =3D rqstp->rq_argp;
>> -	__be32	nfserr;
>> +	struct nfsd_stat *resp =3D rqstp->rq_resp;
>>=20
>> 	dprintk("nfsd: REMOVE   %s %.*s\n", SVCFH_fmt(&argp->fh),
>> 		argp->len, argp->name);
>>=20
>> 	/* Unlink. -SIFDIR means file must not be a directory */
>> -	nfserr =3D nfsd_unlink(rqstp, &argp->fh, -S_IFDIR, argp->name, =
argp->len);
>> +	resp->status =3D nfsd_unlink(rqstp, &argp->fh, -S_IFDIR,
>> +				   argp->name, argp->len);
>> 	fh_put(&argp->fh);
>> -	return nfserr;
>> +	return rpc_success;
>> }
>>=20
>> static __be32
>> nfsd_proc_rename(struct svc_rqst *rqstp)
>> {
>> 	struct nfsd_renameargs *argp =3D rqstp->rq_argp;
>> -	__be32	nfserr;
>> +	struct nfsd_stat *resp =3D rqstp->rq_resp;
>>=20
>> 	dprintk("nfsd: RENAME   %s %.*s -> \n",
>> 		SVCFH_fmt(&argp->ffh), argp->flen, argp->fname);
>> 	dprintk("nfsd:        ->  %s %.*s\n",
>> 		SVCFH_fmt(&argp->tfh), argp->tlen, argp->tname);
>>=20
>> -	nfserr =3D nfsd_rename(rqstp, &argp->ffh, argp->fname, =
argp->flen,
>> -				    &argp->tfh, argp->tname, =
argp->tlen);
>> +	resp->status =3D nfsd_rename(rqstp, &argp->ffh, argp->fname, =
argp->flen,
>> +				   &argp->tfh, argp->tname, argp->tlen);
>> 	fh_put(&argp->ffh);
>> 	fh_put(&argp->tfh);
>> -	return nfserr;
>> +	return rpc_success;
>> }
>>=20
>> static __be32
>> nfsd_proc_link(struct svc_rqst *rqstp)
>> {
>> 	struct nfsd_linkargs *argp =3D rqstp->rq_argp;
>> -	__be32	nfserr;
>> +	struct nfsd_stat *resp =3D rqstp->rq_resp;
>>=20
>> 	dprintk("nfsd: LINK     %s ->\n",
>> 		SVCFH_fmt(&argp->ffh));
>> @@ -459,22 +459,22 @@ nfsd_proc_link(struct svc_rqst *rqstp)
>> 		argp->tlen,
>> 		argp->tname);
>>=20
>> -	nfserr =3D nfsd_link(rqstp, &argp->tfh, argp->tname, argp->tlen,
>> -				  &argp->ffh);
>> +	resp->status =3D nfsd_link(rqstp, &argp->tfh, argp->tname, =
argp->tlen,
>> +				 &argp->ffh);
>> 	fh_put(&argp->ffh);
>> 	fh_put(&argp->tfh);
>> -	return nfserr;
>> +	return rpc_success;
>> }
>>=20
>> static __be32
>> nfsd_proc_symlink(struct svc_rqst *rqstp)
>> {
>> 	struct nfsd_symlinkargs *argp =3D rqstp->rq_argp;
>> +	struct nfsd_stat *resp =3D rqstp->rq_resp;
>> 	struct svc_fh	newfh;
>> -	__be32		nfserr;
>>=20
>> 	if (argp->tlen > NFS_MAXPATHLEN) {
>> -		nfserr =3D nfserr_nametoolong;
>> +		resp->status =3D nfserr_nametoolong;
>> 		goto out;
>> 	}
>>=20
>> @@ -482,7 +482,7 @@ nfsd_proc_symlink(struct svc_rqst *rqstp)
>> 						=
page_address(rqstp->rq_arg.pages[0]),
>> 						argp->tlen);
>> 	if (IS_ERR(argp->tname)) {
>> -		nfserr =3D nfserrno(PTR_ERR(argp->tname));
>> +		resp->status =3D nfserrno(PTR_ERR(argp->tname));
>> 		goto out;
>> 	}
>>=20
>> @@ -491,14 +491,14 @@ nfsd_proc_symlink(struct svc_rqst *rqstp)
>> 		argp->tlen, argp->tname);
>>=20
>> 	fh_init(&newfh, NFS_FHSIZE);
>> -	nfserr =3D nfsd_symlink(rqstp, &argp->ffh, argp->fname, =
argp->flen,
>> -						 argp->tname, &newfh);
>> +	resp->status =3D nfsd_symlink(rqstp, &argp->ffh, argp->fname, =
argp->flen,
>> +				    argp->tname, &newfh);
>>=20
>> 	kfree(argp->tname);
>> 	fh_put(&argp->ffh);
>> 	fh_put(&newfh);
>> out:
>> -	return nfserr;
>> +	return rpc_success;
>> }
>>=20
>> /*
>> @@ -528,7 +528,7 @@ nfsd_proc_mkdir(struct svc_rqst *rqstp)
>>=20
>> 	resp->status =3D fh_getattr(&resp->fh, &resp->stat);
>> out:
>> -	return resp->status;
>> +	return rpc_success;
>> }
>>=20
>> /*
>> @@ -538,13 +538,14 @@ static __be32
>> nfsd_proc_rmdir(struct svc_rqst *rqstp)
>> {
>> 	struct nfsd_diropargs *argp =3D rqstp->rq_argp;
>> -	__be32	nfserr;
>> +	struct nfsd_stat *resp =3D rqstp->rq_resp;
>>=20
>> 	dprintk("nfsd: RMDIR    %s %.*s\n", SVCFH_fmt(&argp->fh), =
argp->len, argp->name);
>>=20
>> -	nfserr =3D nfsd_unlink(rqstp, &argp->fh, S_IFDIR, argp->name, =
argp->len);
>> +	resp->status =3D nfsd_unlink(rqstp, &argp->fh, S_IFDIR,
>> +				   argp->name, argp->len);
>> 	fh_put(&argp->fh);
>> -	return nfserr;
>> +	return rpc_success;
>> }
>>=20
>> /*
>> @@ -584,7 +585,7 @@ nfsd_proc_readdir(struct svc_rqst *rqstp)
>> 		*resp->offset =3D htonl(offset);
>>=20
>> 	fh_put(&argp->fh);
>> -	return resp->status;
>> +	return rpc_success;
>> }
>>=20
>> /*
>> @@ -601,7 +602,7 @@ nfsd_proc_statfs(struct svc_rqst *rqstp)
>> 	resp->status =3D nfsd_statfs(rqstp, &argp->fh, &resp->stats,
>> 				   NFSD_MAY_BYPASS_GSS_ON_ROOT);
>> 	fh_put(&argp->fh);
>> -	return resp->status;
>> +	return rpc_success;
>> }
>>=20
>> /*
>> @@ -622,7 +623,7 @@ static const struct svc_procedure =
nfsd_procedures2[18] =3D {
>> 		.pc_argsize =3D sizeof(struct nfsd_void),
>> 		.pc_ressize =3D sizeof(struct nfsd_void),
>> 		.pc_cachetype =3D RC_NOCACHE,
>> -		.pc_xdrressize =3D ST,
>> +		.pc_xdrressize =3D 0,
>> 	},
>> 	[NFSPROC_GETATTR] =3D {
>> 		.pc_func =3D nfsd_proc_getattr,
>> @@ -651,7 +652,7 @@ static const struct svc_procedure =
nfsd_procedures2[18] =3D {
>> 		.pc_argsize =3D sizeof(struct nfsd_void),
>> 		.pc_ressize =3D sizeof(struct nfsd_void),
>> 		.pc_cachetype =3D RC_NOCACHE,
>> -		.pc_xdrressize =3D ST,
>> +		.pc_xdrressize =3D 0,
>> 	},
>> 	[NFSPROC_LOOKUP] =3D {
>> 		.pc_func =3D nfsd_proc_lookup,
>> @@ -689,7 +690,7 @@ static const struct svc_procedure =
nfsd_procedures2[18] =3D {
>> 		.pc_argsize =3D sizeof(struct nfsd_void),
>> 		.pc_ressize =3D sizeof(struct nfsd_void),
>> 		.pc_cachetype =3D RC_NOCACHE,
>> -		.pc_xdrressize =3D ST,
>> +		.pc_xdrressize =3D 0,
>> 	},
>> 	[NFSPROC_WRITE] =3D {
>> 		.pc_func =3D nfsd_proc_write,
>> @@ -714,36 +715,36 @@ static const struct svc_procedure =
nfsd_procedures2[18] =3D {
>> 	[NFSPROC_REMOVE] =3D {
>> 		.pc_func =3D nfsd_proc_remove,
>> 		.pc_decode =3D nfssvc_decode_diropargs,
>> -		.pc_encode =3D nfssvc_encode_void,
>> +		.pc_encode =3D nfssvc_encode_stat,
>> 		.pc_argsize =3D sizeof(struct nfsd_diropargs),
>> -		.pc_ressize =3D sizeof(struct nfsd_void),
>> +		.pc_ressize =3D sizeof(struct nfsd_stat),
>> 		.pc_cachetype =3D RC_REPLSTAT,
>> 		.pc_xdrressize =3D ST,
>> 	},
>> 	[NFSPROC_RENAME] =3D {
>> 		.pc_func =3D nfsd_proc_rename,
>> 		.pc_decode =3D nfssvc_decode_renameargs,
>> -		.pc_encode =3D nfssvc_encode_void,
>> +		.pc_encode =3D nfssvc_encode_stat,
>> 		.pc_argsize =3D sizeof(struct nfsd_renameargs),
>> -		.pc_ressize =3D sizeof(struct nfsd_void),
>> +		.pc_ressize =3D sizeof(struct nfsd_stat),
>> 		.pc_cachetype =3D RC_REPLSTAT,
>> 		.pc_xdrressize =3D ST,
>> 	},
>> 	[NFSPROC_LINK] =3D {
>> 		.pc_func =3D nfsd_proc_link,
>> 		.pc_decode =3D nfssvc_decode_linkargs,
>> -		.pc_encode =3D nfssvc_encode_void,
>> +		.pc_encode =3D nfssvc_encode_stat,
>> 		.pc_argsize =3D sizeof(struct nfsd_linkargs),
>> -		.pc_ressize =3D sizeof(struct nfsd_void),
>> +		.pc_ressize =3D sizeof(struct nfsd_stat),
>> 		.pc_cachetype =3D RC_REPLSTAT,
>> 		.pc_xdrressize =3D ST,
>> 	},
>> 	[NFSPROC_SYMLINK] =3D {
>> 		.pc_func =3D nfsd_proc_symlink,
>> 		.pc_decode =3D nfssvc_decode_symlinkargs,
>> -		.pc_encode =3D nfssvc_encode_void,
>> +		.pc_encode =3D nfssvc_encode_stat,
>> 		.pc_argsize =3D sizeof(struct nfsd_symlinkargs),
>> -		.pc_ressize =3D sizeof(struct nfsd_void),
>> +		.pc_ressize =3D sizeof(struct nfsd_stat),
>> 		.pc_cachetype =3D RC_REPLSTAT,
>> 		.pc_xdrressize =3D ST,
>> 	},
>> @@ -760,9 +761,9 @@ static const struct svc_procedure =
nfsd_procedures2[18] =3D {
>> 	[NFSPROC_RMDIR] =3D {
>> 		.pc_func =3D nfsd_proc_rmdir,
>> 		.pc_decode =3D nfssvc_decode_diropargs,
>> -		.pc_encode =3D nfssvc_encode_void,
>> +		.pc_encode =3D nfssvc_encode_stat,
>> 		.pc_argsize =3D sizeof(struct nfsd_diropargs),
>> -		.pc_ressize =3D sizeof(struct nfsd_void),
>> +		.pc_ressize =3D sizeof(struct nfsd_stat),
>> 		.pc_cachetype =3D RC_REPLSTAT,
>> 		.pc_xdrressize =3D ST,
>> 	},
>> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
>> index beb3875241cb..27b1ad136150 100644
>> --- a/fs/nfsd/nfssvc.c
>> +++ b/fs/nfsd/nfssvc.c
>> @@ -960,13 +960,6 @@ nfsd(void *vrqstp)
>> 	return 0;
>> }
>>=20
>> -static __be32 map_new_errors(u32 vers, __be32 nfserr)
>> -{
>> -	if (nfserr =3D=3D nfserr_jukebox && vers =3D=3D 2)
>> -		return nfserr_dropit;
>> -	return nfserr;
>> -}
>> -
>> /*
>>  * A write procedure can have a large argument, and a read procedure =
can
>>  * have a large reply, but no NFSv2 or NFSv3 procedure has argument =
and
>> @@ -1014,7 +1007,7 @@ int nfsd_dispatch(struct svc_rqst *rqstp, =
__be32 *statp)
>> 	const struct svc_procedure *proc =3D rqstp->rq_procinfo;
>> 	struct kvec *argv =3D &rqstp->rq_arg.head[0];
>> 	struct kvec *resv =3D &rqstp->rq_res.head[0];
>> -	__be32 nfserr, *nfserrp;
>> +	__be32 *p;
>>=20
>> 	dprintk("nfsd_dispatch: vers %d proc %d\n",
>> 				rqstp->rq_vers, rqstp->rq_proc);
>> @@ -1043,18 +1036,14 @@ int nfsd_dispatch(struct svc_rqst *rqstp, =
__be32 *statp)
>> 	 * Need to grab the location to store the status, as
>> 	 * NFSv4 does some encoding while processing
>> 	 */
>> -	nfserrp =3D resv->iov_base + resv->iov_len;
>> +	p =3D resv->iov_base + resv->iov_len;
>> 	resv->iov_len +=3D sizeof(__be32);
>>=20
>> -	nfserr =3D proc->pc_func(rqstp);
>> -	nfserr =3D map_new_errors(rqstp->rq_vers, nfserr);
>> -	if (nfserr =3D=3D nfserr_dropit || test_bit(RQ_DROPME, =
&rqstp->rq_flags))
>> +	*statp =3D proc->pc_func(rqstp);
>> +	if (*statp =3D=3D rpc_drop_reply || test_bit(RQ_DROPME, =
&rqstp->rq_flags))
>> 		goto out_update_drop;
>>=20
>> -	if (rqstp->rq_proc !=3D 0)
>> -		*nfserrp++ =3D nfserr;
>> -
>> -	if (!proc->pc_encode(rqstp, nfserrp))
>> +	if (!proc->pc_encode(rqstp, p))
>> 		goto out_encode_err;
>>=20
>> 	nfsd_cache_update(rqstp, rqstp->rq_cachetype, statp + 1);
>> diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
>> index 952e71c95d4e..8a288c8fcd57 100644
>> --- a/fs/nfsd/nfsxdr.c
>> +++ b/fs/nfsd/nfsxdr.c
>> @@ -429,15 +429,25 @@ nfssvc_encode_void(struct svc_rqst *rqstp, =
__be32 *p)
>> 	return xdr_ressize_check(rqstp, p);
>> }
>>=20
>> +int
>> +nfssvc_encode_stat(struct svc_rqst *rqstp, __be32 *p)
>> +{
>> +	struct nfsd_stat *resp =3D rqstp->rq_resp;
>> +
>> +	*p++ =3D resp->status;
>> +	return xdr_ressize_check(rqstp, p);
>> +}
>> +
>> int
>> nfssvc_encode_attrstat(struct svc_rqst *rqstp, __be32 *p)
>> {
>> 	struct nfsd_attrstat *resp =3D rqstp->rq_resp;
>>=20
>> +	*p++ =3D resp->status;
>> 	if (resp->status !=3D nfs_ok)
>> -		return xdr_ressize_check(rqstp, p);
>> -
>> +		goto out;
>> 	p =3D encode_fattr(rqstp, p, &resp->fh, &resp->stat);
>> +out:
>> 	return xdr_ressize_check(rqstp, p);
>> }
>>=20
>> @@ -446,11 +456,12 @@ nfssvc_encode_diropres(struct svc_rqst *rqstp, =
__be32 *p)
>> {
>> 	struct nfsd_diropres *resp =3D rqstp->rq_resp;
>>=20
>> +	*p++ =3D resp->status;
>> 	if (resp->status !=3D nfs_ok)
>> -		return xdr_ressize_check(rqstp, p);
>> -
>> +		goto out;
>> 	p =3D encode_fh(p, &resp->fh);
>> 	p =3D encode_fattr(rqstp, p, &resp->fh, &resp->stat);
>> +out:
>> 	return xdr_ressize_check(rqstp, p);
>> }
>>=20
>> @@ -459,6 +470,7 @@ nfssvc_encode_readlinkres(struct svc_rqst *rqstp, =
__be32 *p)
>> {
>> 	struct nfsd_readlinkres *resp =3D rqstp->rq_resp;
>>=20
>> +	*p++ =3D resp->status;
>> 	if (resp->status !=3D nfs_ok)
>> 		return xdr_ressize_check(rqstp, p);
>>=20
>> @@ -479,6 +491,7 @@ nfssvc_encode_readres(struct svc_rqst *rqstp, =
__be32 *p)
>> {
>> 	struct nfsd_readres *resp =3D rqstp->rq_resp;
>>=20
>> +	*p++ =3D resp->status;
>> 	if (resp->status !=3D nfs_ok)
>> 		return xdr_ressize_check(rqstp, p);
>>=20
>> @@ -502,6 +515,7 @@ nfssvc_encode_readdirres(struct svc_rqst *rqstp, =
__be32 *p)
>> {
>> 	struct nfsd_readdirres *resp =3D rqstp->rq_resp;
>>=20
>> +	*p++ =3D resp->status;
>> 	if (resp->status !=3D nfs_ok)
>> 		return xdr_ressize_check(rqstp, p);
>>=20
>> @@ -520,6 +534,7 @@ nfssvc_encode_statfsres(struct svc_rqst *rqstp, =
__be32 *p)
>> 	struct nfsd_statfsres *resp =3D rqstp->rq_resp;
>> 	struct kstatfs	*stat =3D &resp->stats;
>>=20
>> +	*p++ =3D resp->status;
>> 	if (resp->status !=3D nfs_ok)
>> 		return xdr_ressize_check(rqstp, p);
>>=20
>> diff --git a/fs/nfsd/xdr.h b/fs/nfsd/xdr.h
>> index 17221931815f..0ff336b0b25f 100644
>> --- a/fs/nfsd/xdr.h
>> +++ b/fs/nfsd/xdr.h
>> @@ -82,6 +82,10 @@ struct nfsd_readdirargs {
>> 	__be32 *		buffer;
>> };
>>=20
>> +struct nfsd_stat {
>> +	__be32			status;
>> +};
>> +
>> struct nfsd_attrstat {
>> 	__be32			status;
>> 	struct svc_fh		fh;
>> @@ -153,6 +157,7 @@ int nfssvc_decode_linkargs(struct svc_rqst *, =
__be32 *);
>> int nfssvc_decode_symlinkargs(struct svc_rqst *, __be32 *);
>> int nfssvc_decode_readdirargs(struct svc_rqst *, __be32 *);
>> int nfssvc_encode_void(struct svc_rqst *, __be32 *);
>> +int nfssvc_encode_stat(struct svc_rqst *, __be32 *);
>> int nfssvc_encode_attrstat(struct svc_rqst *, __be32 *);
>> int nfssvc_encode_diropres(struct svc_rqst *, __be32 *);
>> int nfssvc_encode_readlinkres(struct svc_rqst *, __be32 *);

--
Chuck Lever



