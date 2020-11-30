Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16DE32C9243
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Dec 2020 00:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgK3XMN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 18:12:13 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:56550 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730540AbgK3XMN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Nov 2020 18:12:13 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AUN5fKn088360;
        Mon, 30 Nov 2020 23:11:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=2K5pRaGNrboOQftc61ZJZCeljKX98FeXgkmLw3kH2p0=;
 b=0P1nGXl4Ng0rUDR+bIVpM9fiPMFj+L1jAq7Y0ftcWwoFmr1jtjYZrdf0H2nsMfyUTUL2
 MNcbxSLrarP7fF269Uc/c/3QSz7Paod+WCKZ4OeXN0S4DPpRL5pMvscJI0vrFIqwIF2r
 iUtzKDDcNb0JN0vmlUsiPkOStXRhTQ6qSyvx7xSozJEB7Nrye1TEJKgosEz9L3Qb3uRY
 3yZ7lwjN3s/S+2oNL3p1Ikf6AuUlDh56tqc4JxBjspcXTMkpb784k3O206bPCXjNiWZw
 yvUU7Kq4DdbqDwszhQWu+dwgX5JjJGFCxu9vTPTjSNubc4izmMKz++OoYPDJYSq5ZOms SQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 353dyqftn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Nov 2020 23:11:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AUN6Ejk171938;
        Mon, 30 Nov 2020 23:11:26 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 3540ar9d0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Nov 2020 23:11:26 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AUNBO9j022351;
        Mon, 30 Nov 2020 23:11:25 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Nov 2020 23:11:24 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 1/6] nfsd: add a new EXPORT_OP_NOWCC flag to struct
 export_operations
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201130212455.254469-2-trondmy@kernel.org>
Date:   Mon, 30 Nov 2020 18:11:23 -0500
Cc:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3E4E4CA0-B7AB-4E87-9CD0-64618F1D4CFF@oracle.com>
References: <20201130212455.254469-1-trondmy@kernel.org>
 <20201130212455.254469-2-trondmy@kernel.org>
To:     trondmy@kernel.org
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9821 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=1
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011300143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9821 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 clxscore=1015 mlxscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=1 lowpriorityscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011300143
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 30, 2020, at 4:24 PM, trondmy@kernel.org wrote:
>=20
> From: Jeff Layton <jeff.layton@primarydata.com>
>=20
> With NFSv3 nfsd will always attempt to send along WCC data to the
> client. This generally involves saving off the in-core inode =
information
> prior to doing the operation on the given filehandle, and then issuing =
a
> vfs_getattr to it after the op.
>=20
> Some filesystems (particularly clustered or networked ones) have an
> expensive ->getattr inode operation. Atomicitiy is also often =
difficult
> or impossible to guarantee on such filesystems. For those, we're best
> off not trying to provide WCC information to the client at all, and to
> simply allow it to poll for that information as needed with a GETATTR
> RPC.
>=20
> This patch adds a new flags field to struct export_operations, and
> defines a new EXPORT_OP_NOWCC flag that filesystems can use to =
indicate
> that nfsd should not attempt to provide WCC info in NFSv3 replies. It
> also adds a blurb about the new flags field and flag to the exporting
> documentation.
>=20
> The server will also now skip collecting this information for NFSv2 as
> well, since that info is never used there anyway.
>=20
> Note that this patch does not add this flag to any filesystem
> export_operations structures. This was originally developed to allow
> reexporting nfs via nfsd. That code is not (and may never be) suitable
> for merging into mainline.
>=20
> Other filesystems may want to consider enabling this flag too. It's =
hard
> to tell however which ones have export operations to enable export via
> knfsd and which ones mostly rely on them for open-by-filehandle =
support,
> so I'm leaving that up to the individual maintainers to decide. I am
> cc'ing the relevant lists for those filesystems that I think may want =
to
> consider adding this though.
>=20
> Cc: HPDD-discuss@lists.01.org
> Cc: ceph-devel@vger.kernel.org
> Cc: cluster-devel@redhat.com
> Cc: fuse-devel@lists.sourceforge.net
> Cc: ocfs2-devel@oss.oracle.com
> Signed-off-by: Jeff Layton <jeff.layton@primarydata.com>
> Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

These seem to apply fine, thanks for resending.

If you post a v3 to address Bruce's comment, can you also
address this checkpatch nit?


WARNING: Prefer 'fallthrough;' over fallthrough comment
#154: FILE: fs/nfsd/nfsfh.c:299:
+		/* Fallthrough */

total: 0 errors, 1 warnings, 120 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or =
--fix-inplace.


> ---
> Documentation/filesystems/nfs/exporting.rst | 27 +++++++++++++++++++++
> fs/nfs/export.c                             |  1 +
> fs/nfsd/nfs3xdr.c                           |  7 ++++--
> fs/nfsd/nfsfh.c                             | 14 +++++++++++
> fs/nfsd/nfsfh.h                             |  2 +-
> include/linux/exportfs.h                    |  2 ++
> 6 files changed, 50 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/filesystems/nfs/exporting.rst =
b/Documentation/filesystems/nfs/exporting.rst
> index 33d588a01ace..a3e3805833d1 100644
> --- a/Documentation/filesystems/nfs/exporting.rst
> +++ b/Documentation/filesystems/nfs/exporting.rst
> @@ -154,6 +154,11 @@ struct which has the following members:
>     to find potential names, and matches inode numbers to find the =
correct
>     match.
>=20
> +  flags
> +    Some filesystems may need to be handled differently than others. =
The
> +    export_operations struct also includes a flags field that allows =
the
> +    filesystem to communicate such information to nfsd. See the =
Export
> +    Operations Flags section below for more explanation.
>=20
> A filehandle fragment consists of an array of 1 or more 4byte words,
> together with a one byte "type".
> @@ -163,3 +168,25 @@ generated by encode_fh, in which case it will =
have been padded with
> nuls.  Rather, the encode_fh routine should choose a "type" which
> indicates the decode_fh how much of the filehandle is valid, and how
> it should be interpreted.
> +
> +Export Operations Flags
> +-----------------------
> +In addition to the operation vector pointers, struct =
export_operations also
> +contains a "flags" field that allows the filesystem to communicate to =
nfsd
> +that it may want to do things differently when dealing with it. The
> +following flags are defined:
> +
> +  EXPORT_OP_NOWCC
> +    RFC 1813 recommends that servers always send weak cache =
consistency
> +    (WCC) data to the client after each operation. The server should
> +    atomically collect attributes about the inode, do an operation on =
it,
> +    and then collect the attributes afterward. This allows the client =
to
> +    skip issuing GETATTRs in some situations but means that the =
server
> +    is calling vfs_getattr for almost all RPCs. On some filesystems
> +    (particularly those that are clustered or networked) this is =
expensive
> +    and atomicity is difficult to guarantee. This flag indicates to =
nfsd
> +    that it should skip providing WCC attributes to the client in =
NFSv3
> +    replies when doing operations on this filesystem. Consider =
enabling
> +    this on filesystems that have an expensive ->getattr inode =
operation,
> +    or when atomicity between pre and post operation attribute =
collection
> +    is impossible to guarantee.
> diff --git a/fs/nfs/export.c b/fs/nfs/export.c
> index 3430d6891e89..8f4c528865c5 100644
> --- a/fs/nfs/export.c
> +++ b/fs/nfs/export.c
> @@ -171,4 +171,5 @@ const struct export_operations nfs_export_ops =3D =
{
> 	.encode_fh =3D nfs_encode_fh,
> 	.fh_to_dentry =3D nfs_fh_to_dentry,
> 	.get_parent =3D nfs_get_parent,
> +	.flags =3D EXPORT_OP_NOWCC,
> };
> diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
> index 2277f83da250..480342675292 100644
> --- a/fs/nfsd/nfs3xdr.c
> +++ b/fs/nfsd/nfs3xdr.c
> @@ -206,7 +206,7 @@ static __be32 *
> encode_post_op_attr(struct svc_rqst *rqstp, __be32 *p, struct svc_fh =
*fhp)
> {
> 	struct dentry *dentry =3D fhp->fh_dentry;
> -	if (dentry && d_really_is_positive(dentry)) {
> +	if (!fhp->fh_no_wcc && dentry && d_really_is_positive(dentry)) {
> 	        __be32 err;
> 		struct kstat stat;
>=20
> @@ -261,7 +261,7 @@ void fill_pre_wcc(struct svc_fh *fhp)
> 	struct kstat	stat;
> 	__be32 err;
>=20
> -	if (fhp->fh_pre_saved)
> +	if (fhp->fh_no_wcc || fhp->fh_pre_saved)
> 		return;
>=20
> 	inode =3D d_inode(fhp->fh_dentry);
> @@ -287,6 +287,9 @@ void fill_post_wcc(struct svc_fh *fhp)
> {
> 	__be32 err;
>=20
> +	if (fhp->fh_no_wcc)
> +		return;
> +
> 	if (fhp->fh_post_saved)
> 		printk("nfsd: inode locked twice during operation.\n");
>=20
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index c81dbbad8792..0c2ee65e46f3 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -291,6 +291,16 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst =
*rqstp, struct svc_fh *fhp)
>=20
> 	fhp->fh_dentry =3D dentry;
> 	fhp->fh_export =3D exp;
> +
> +	switch (rqstp->rq_vers) {
> +	case 3:
> +		if (!(dentry->d_sb->s_export_op->flags & =
EXPORT_OP_NOWCC))
> +			break;
> +		/* Fallthrough */
> +	case 2:
> +		fhp->fh_no_wcc =3D true;
> +	}
> +
> 	return 0;
> out:
> 	exp_put(exp);
> @@ -559,6 +569,9 @@ fh_compose(struct svc_fh *fhp, struct svc_export =
*exp, struct dentry *dentry,
> 	 */
> 	set_version_and_fsid_type(fhp, exp, ref_fh);
>=20
> +	/* If we have a ref_fh, then copy the fh_no_wcc setting from it. =
*/
> +	fhp->fh_no_wcc =3D ref_fh ? ref_fh->fh_no_wcc : false;
> +
> 	if (ref_fh =3D=3D fhp)
> 		fh_put(ref_fh);
>=20
> @@ -662,6 +675,7 @@ fh_put(struct svc_fh *fhp)
> 		exp_put(exp);
> 		fhp->fh_export =3D NULL;
> 	}
> +	fhp->fh_no_wcc =3D false;
> 	return;
> }
>=20
> diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> index 56cfbc361561..fb2b60a76b32 100644
> --- a/fs/nfsd/nfsfh.h
> +++ b/fs/nfsd/nfsfh.h
> @@ -35,6 +35,7 @@ typedef struct svc_fh {
>=20
> 	bool			fh_locked;	/* inode locked by us */
> 	bool			fh_want_write;	/* remount protection =
taken */
> +	bool			fh_no_wcc;	/* no wcc data needed */
> 	int			fh_flags;	/* FH flags */
> #ifdef CONFIG_NFSD_V3
> 	bool			fh_post_saved;	/* post-op attrs saved =
*/
> @@ -54,7 +55,6 @@ typedef struct svc_fh {
> 	struct kstat		fh_post_attr;	/* full attrs after =
operation */
> 	u64			fh_post_change; /* nfsv4 change; see =
above */
> #endif /* CONFIG_NFSD_V3 */
> -
> } svc_fh;
> #define NFSD4_FH_FOREIGN (1<<0)
> #define SET_FH_FLAG(c, f) ((c)->fh_flags |=3D (f))
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index 3ceb72b67a7a..e7de0103a32e 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -213,6 +213,8 @@ struct export_operations {
> 			  bool write, u32 *device_generation);
> 	int (*commit_blocks)(struct inode *inode, struct iomap *iomaps,
> 			     int nr_iomaps, struct iattr *iattr);
> +#define	EXPORT_OP_NOWCC		(0x1)	/* Don't collect wcc =
data for NFSv3 replies */
> +	unsigned long	flags;
> };
>=20
> extern int exportfs_encode_inode_fh(struct inode *inode, struct fid =
*fid,
> --=20
> 2.28.0
>=20

--
Chuck Lever



