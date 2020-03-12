Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53A0F18361D
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2020 17:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgCLQ0c (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Mar 2020 12:26:32 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50560 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbgCLQ0c (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Mar 2020 12:26:32 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CGMbf2011929;
        Thu, 12 Mar 2020 16:26:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=NBjMBvQQVCJKAtToxENg/CbpgktAbVudPHABYsWl8Is=;
 b=dRyXcTA8e3HeITH6llrgBbzIP4GxZai21yn11gPX948hd8d2vLyJPZwbW7913YaCsbl4
 Alf48ZQHvH3bgwijR57L52iSzpEOv78uc1dxUBrKXa2+dfcZkb5ACNeAt4wuyPJGHgFi
 bVmGGss8z66M/yijkfSG0/TnuevhvqzPesMl+raOmp381pMvDVoJWuETm9omPyo+xUdu
 ESsKuZMtCFTuHavnuB+qiSH7Ow5xMKn6viyR3FhwvX6CW5d7FkCKUSOr4nXHkbJgDWuc
 yWcJRsOvE0I4cJFpZmKz4wkrvShd52ABG26JWQm51cMvk81P5KsRItsT7nB0jqGY9VYd 6w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2yp9v6drpm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 16:26:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CGNged068618;
        Thu, 12 Mar 2020 16:24:28 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2yqkvmy0n5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 16:24:28 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02CGNk5u015164;
        Thu, 12 Mar 2020 16:23:46 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Mar 2020 09:23:46 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 02/14] xattr: modify vfs_{set,remove}xattr for NFS server
 use
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200311195954.27117-3-fllinden@amazon.com>
Date:   Thu, 12 Mar 2020 12:23:44 -0400
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C75E3B87-6A91-4258-949C-DDE323A77882@oracle.com>
References: <20200311195954.27117-1-fllinden@amazon.com>
 <20200311195954.27117-3-fllinden@amazon.com>
To:     Frank van der Linden <fllinden@amazon.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003120084
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120084
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 11, 2020, at 3:59 PM, Frank van der Linden =
<fllinden@amazon.com> wrote:
>=20
> To be called from the upcoming NFS server xattr code, the =
vfs_removexattr
> and vfs_setxattr need some modifications.
>=20
> First, they need to grow a _locked variant, since the NFS server code
> will call this with i_rwsem held. It needs to do that in fh_lock to be
> able to atomically provide the before and after change attributes.
>=20
> Second, RFC 8276 (NFSv4 extended attribute support) specifies that
> delegations should be recalled (8.4.2.4, 8.4.4.4) when a SETXATTR
> or REMOVEXATTR operation is performed. So, like with other fs
> operations, try to break the delegation. The _locked version of
> these operations will not wait for the delegation to be successfully
> broken, instead returning an error if it wasn't, so that the NFS
> server code can return NFS4ERR_DELAY to the client (similar to
> what e.g. vfs_link does).
>=20
> Signed-off-by: Frank van der Linden <fllinden@amazon.com>

Frank, I appreciate the verbosity of the patch descriptions, and
thanks very much for splitting the client and server work into
separate series.

[cel@klimt linux]$ scripts/get_maintainer.pl fs/xattr.c
Alexander Viro <viro@zeniv.linux.org.uk> (maintainer:FILESYSTEMS (VFS =
and infrastructure))
linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and =
infrastructure))
linux-kernel@vger.kernel.org (open list)
[cel@klimt linux]$=20

So patches like this one and 13/14 (or perhaps the whole series)
needs to be cc: linux-fsdevel@vger.kernel.org. At least those
two patches in particular will need an Acked-by: from viro.


> ---
> fs/xattr.c            | 63 =
+++++++++++++++++++++++++++++++++++++++++++++------
> include/linux/xattr.h |  2 ++
> 2 files changed, 58 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 90dd78f0eb27..58013bcbc333 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -204,10 +204,10 @@ int __vfs_setxattr_noperm(struct dentry *dentry, =
const char *name,
> 	return error;
> }
>=20
> -
> int
> -vfs_setxattr(struct dentry *dentry, const char *name, const void =
*value,
> -		size_t size, int flags)
> +__vfs_setxattr_locked(struct dentry *dentry, const char *name,
> +		const void *value, size_t size, int flags,
> +		struct inode **delegated_inode)

Since you will need to repost, please consider adding a Doxygen
comment in front of newly introduced global APIs. Such a comment
would be an appropriate place to add non-NFS-related explanatory
text you have provided in the patch description.

Goes for global APIs introduced in other patches too.


> {
> 	struct inode *inode =3D dentry->d_inode;
> 	int error;
> @@ -216,15 +216,40 @@ vfs_setxattr(struct dentry *dentry, const char =
*name, const void *value,
> 	if (error)
> 		return error;
>=20
> -	inode_lock(inode);
> 	error =3D security_inode_setxattr(dentry, name, value, size, =
flags);
> 	if (error)
> 		goto out;
>=20
> +	error =3D try_break_deleg(inode, delegated_inode);
> +	if (error)
> +		goto out;
> +
> 	error =3D __vfs_setxattr_noperm(dentry, name, value, size, =
flags);
>=20
> out:
> +	return error;
> +}
> +EXPORT_SYMBOL_GPL(__vfs_setxattr_locked);
> +
> +int
> +vfs_setxattr(struct dentry *dentry, const char *name, const void =
*value,
> +		size_t size, int flags)
> +{
> +	struct inode *inode =3D dentry->d_inode;
> +	struct inode *delegated_inode =3D NULL;
> +	int error;
> +
> +retry_deleg:
> +	inode_lock(inode);
> +	error =3D __vfs_setxattr_locked(dentry, name, value, size, =
flags,
> +	    &delegated_inode);
> 	inode_unlock(inode);
> +
> +	if (delegated_inode) {
> +		error =3D break_deleg_wait(&delegated_inode);
> +		if (!error)
> +			goto retry_deleg;
> +	}
> 	return error;
> }
> EXPORT_SYMBOL_GPL(vfs_setxattr);
> @@ -379,7 +404,8 @@ __vfs_removexattr(struct dentry *dentry, const =
char *name)
> EXPORT_SYMBOL(__vfs_removexattr);
>=20
> int
> -vfs_removexattr(struct dentry *dentry, const char *name)
> +__vfs_removexattr_locked(struct dentry *dentry, const char *name,
> +		struct inode **delegated_inode)
> {
> 	struct inode *inode =3D dentry->d_inode;
> 	int error;
> @@ -388,11 +414,14 @@ vfs_removexattr(struct dentry *dentry, const =
char *name)
> 	if (error)
> 		return error;
>=20
> -	inode_lock(inode);
> 	error =3D security_inode_removexattr(dentry, name);
> 	if (error)
> 		goto out;
>=20
> +	error =3D try_break_deleg(inode, delegated_inode);
> +	if (error)
> +		goto out;
> +
> 	error =3D __vfs_removexattr(dentry, name);
>=20
> 	if (!error) {
> @@ -401,12 +430,32 @@ vfs_removexattr(struct dentry *dentry, const =
char *name)
> 	}
>=20
> out:
> +	return error;
> +}
> +EXPORT_SYMBOL_GPL(__vfs_removexattr_locked);
> +
> +int
> +vfs_removexattr(struct dentry *dentry, const char *name)
> +{
> +	struct inode *inode =3D dentry->d_inode;
> +	struct inode *delegated_inode =3D NULL;
> +	int error;
> +
> +retry_deleg:
> +	inode_lock(inode);
> +	error =3D __vfs_removexattr_locked(dentry, name, =
&delegated_inode);
> 	inode_unlock(inode);
> +
> +	if (delegated_inode) {
> +		error =3D break_deleg_wait(&delegated_inode);
> +		if (!error)
> +			goto retry_deleg;
> +	}
> +
> 	return error;
> }
> EXPORT_SYMBOL_GPL(vfs_removexattr);
>=20
> -
> /*
>  * Extended attribute SET operations
>  */
> diff --git a/include/linux/xattr.h b/include/linux/xattr.h
> index 6dad031be3c2..3a71ad716da5 100644
> --- a/include/linux/xattr.h
> +++ b/include/linux/xattr.h
> @@ -51,8 +51,10 @@ ssize_t vfs_getxattr(struct dentry *, const char *, =
void *, size_t);
> ssize_t vfs_listxattr(struct dentry *d, char *list, size_t size);
> int __vfs_setxattr(struct dentry *, struct inode *, const char *, =
const void *, size_t, int);
> int __vfs_setxattr_noperm(struct dentry *, const char *, const void *, =
size_t, int);
> +int __vfs_setxattr_locked(struct dentry *, const char *, const void =
*, size_t, int, struct inode **);
> int vfs_setxattr(struct dentry *, const char *, const void *, size_t, =
int);
> int __vfs_removexattr(struct dentry *, const char *);
> +int __vfs_removexattr_locked(struct dentry *, const char *, struct =
inode **);
> int vfs_removexattr(struct dentry *, const char *);
>=20
> ssize_t generic_listxattr(struct dentry *dentry, char *buffer, size_t =
buffer_size);
> --=20
> 2.16.6
>=20

--
Chuck Lever



