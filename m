Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13EAA183613
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2020 17:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbgCLQYh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Mar 2020 12:24:37 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43234 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgCLQYh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Mar 2020 12:24:37 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CGNO9f095894;
        Thu, 12 Mar 2020 16:24:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=D4uxPpFD7lWcaQ2mlVZLAyRpi+D+/w1OT3dDJhyKZ1o=;
 b=W/EN82NN+GBoX5P75QfOAE2A69217R3xwoGea0v4A5senZfBm9gCKYMqAieBl3kh/QVe
 6xlNaZ2y75NKZk/HQxgo62PsJaXPw+1uzPLp9JoxTE5IN99A23rT83Sr9hiXFfUgdRX7
 tdZJny3ttC5JgseZTeey85ITWavOtu4/eSnXxCMbPzZXKoTwYM7KrWoXRNK9l2YlWn78
 5Fl+AIOsSvZJ8jjbGzJ5415/7BhnhqI3mm2hxcUEcQGGCGJNWYJnBXsgMtD3K3fTtDpQ
 sCCL0utIsIqfkflWvowCml350H9to0QLqKCDN+dcra4ytOA415QpwRGhtGCKASFReKOh gw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2yqkg89u79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 16:24:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CGNkHp071228;
        Thu, 12 Mar 2020 16:24:33 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2yqkvmy12r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 16:24:31 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02CGODYg015300;
        Thu, 12 Mar 2020 16:24:13 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Mar 2020 09:24:12 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 13/14] xattr: add a function to check if a namespace is
 supported
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200311195954.27117-14-fllinden@amazon.com>
Date:   Thu, 12 Mar 2020 12:24:12 -0400
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3AB855EE-977D-4936-AB51-5C9D8E2CD04F@oracle.com>
References: <20200311195954.27117-1-fllinden@amazon.com>
 <20200311195954.27117-14-fllinden@amazon.com>
To:     Frank van der Linden <fllinden@amazon.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003120084
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120084
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 11, 2020, at 3:59 PM, Frank van der Linden =
<fllinden@amazon.com> wrote:
>=20
> Add a function that checks is an extended attribute namespace is
> supported for an inode.
>=20
> To be used by the nfs server code when being queried for extended
> attributes support.

Here's a patch that needs to be cc: linux-fsdevel.

Also, perhaps 13/14 and 14/14 could be squashed together.


> Signed-off-by: Frank van der Linden <fllinden@amazon.com>
> ---
> fs/xattr.c            | 27 +++++++++++++++++++++++++++
> include/linux/xattr.h |  2 ++
> 2 files changed, 29 insertions(+)
>=20
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 58013bcbc333..7d0ebab1df30 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -134,6 +134,33 @@ xattr_permission(struct inode *inode, const char =
*name, int mask)
> 	return inode_permission(inode, mask);
> }
>=20
> +/*
> + * Look for any handler that deals with the specified namespace.
> + */
> +int
> +xattr_supported_namespace(struct inode *inode, const char *prefix)
> +{
> +	const struct xattr_handler **handlers =3D inode->i_sb->s_xattr;
> +	const struct xattr_handler *handler;
> +	size_t preflen;
> +
> +	if (!(inode->i_opflags & IOP_XATTR)) {
> +		if (unlikely(is_bad_inode(inode)))
> +			return -EIO;
> +		return -EOPNOTSUPP;
> +	}
> +
> +	preflen =3D strlen(prefix);
> +
> +	for_each_xattr_handler(handlers, handler) {
> +		if (!strncmp(xattr_prefix(handler), prefix, preflen))
> +			return 0;
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +EXPORT_SYMBOL(xattr_supported_namespace);
> +
> int
> __vfs_setxattr(struct dentry *dentry, struct inode *inode, const char =
*name,
> 	       const void *value, size_t size, int flags)
> diff --git a/include/linux/xattr.h b/include/linux/xattr.h
> index 3a71ad716da5..32e377602068 100644
> --- a/include/linux/xattr.h
> +++ b/include/linux/xattr.h
> @@ -61,6 +61,8 @@ ssize_t generic_listxattr(struct dentry *dentry, =
char *buffer, size_t buffer_siz
> ssize_t vfs_getxattr_alloc(struct dentry *dentry, const char *name,
> 			   char **xattr_value, size_t size, gfp_t =
flags);
>=20
> +int xattr_supported_namespace(struct inode *inode, const char =
*prefix);
> +
> static inline const char *xattr_prefix(const struct xattr_handler =
*handler)
> {
> 	return handler->prefix ?: handler->name;
> --=20
> 2.16.6
>=20

--
Chuck Lever



