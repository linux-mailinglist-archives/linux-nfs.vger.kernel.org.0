Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED8E2183611
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2020 17:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbgCLQYL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Mar 2020 12:24:11 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48724 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727372AbgCLQYK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Mar 2020 12:24:10 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CGMbqd059360;
        Thu, 12 Mar 2020 16:24:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=ClrGfTghG1BKIvFVwHlJke68S6GSdBvG7QHCASNeGfA=;
 b=Krq094bufUf26zWSP6fxx+TenkXrRxHgMJGu+uH+che7Oi6IgE0ay/uGzVv1sX0j0bDi
 oOkrYGobmH4RLjA2jERXdLb7yXHklVU7NicUjGS24KD9DkvCK8fqWeair+Jptou8e5Su
 n0FZTU1YHC8RY8JRNBdY54RYzYSgElkCxc/b5krWHl6qYscJnHsmGPsC0zS1d/8tAMjE
 LkWjZ6qwnsL3J4DlRUVvIk161liA4s/48k6w8pDtGK6V1JujqytveDRv6lG3YWisxM4o
 x5cFJ5pjWbC/FmWNfgorKiw4S52uEYZa/JzPp3RnJk5/fBBUbFPxe8SECnkHqF2jUfLL Yg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2ym31utn3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 16:24:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CGMAWa144444;
        Thu, 12 Mar 2020 16:24:06 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2yp8r0qsw9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 16:24:06 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02CGO5Ht014457;
        Thu, 12 Mar 2020 16:24:05 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Mar 2020 09:24:04 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 10/14] nfsd: implement the xattr procedure functions.
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200311195954.27117-11-fllinden@amazon.com>
Date:   Thu, 12 Mar 2020 12:24:04 -0400
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9255BBE4-57F5-4B62-AED4-7BE803929574@oracle.com>
References: <20200311195954.27117-1-fllinden@amazon.com>
 <20200311195954.27117-11-fllinden@amazon.com>
To:     Frank van der Linden <fllinden@amazon.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120084
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120084
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 11, 2020, at 3:59 PM, Frank van der Linden =
<fllinden@amazon.com> wrote:
>=20
> Implement the main entry points for the *XATTR operations.

This patch triggers "defined but not used" compiler warnings.
These new functions need to be introduced in the same patch
that adds their callsites.

You might consider squashing together all the patches that
only add new NFSD code, for instance.


> Signed-off-by: Frank van der Linden <fllinden@amazon.com>
> ---
> fs/nfsd/nfs4proc.c | 73 =
++++++++++++++++++++++++++++++++++++++++++++++++++++++
> fs/nfsd/nfs4xdr.c  |  2 ++
> 2 files changed, 75 insertions(+)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index b573ae1121af..a76b9025a357 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2098,6 +2098,79 @@ nfsd4_layoutreturn(struct svc_rqst *rqstp,
> }
> #endif /* CONFIG_NFSD_PNFS */
>=20
> +static __be32
> +nfsd4_getxattr(struct svc_rqst *rqstp, struct nfsd4_compound_state =
*cstate,
> +	       union nfsd4_op_u *u)
> +{
> +	struct nfsd4_getxattr *getxattr =3D &u->getxattr;
> +
> +	return nfsd_getxattr(rqstp, &cstate->current_fh,
> +			     getxattr->getxa_name, getxattr->getxa_buf,
> +			     &getxattr->getxa_len);
> +}
> +
> +static __be32
> +nfsd4_setxattr(struct svc_rqst *rqstp, struct nfsd4_compound_state =
*cstate,
> +	   union nfsd4_op_u *u)
> +{
> +	struct nfsd4_setxattr *setxattr =3D &u->setxattr;
> +	int ret;
> +
> +	if (opens_in_grace(SVC_NET(rqstp)))
> +		return nfserr_grace;
> +
> +	ret =3D nfsd_setxattr(rqstp, &cstate->current_fh, =
setxattr->setxa_name,
> +			    setxattr->setxa_buf, setxattr->setxa_len,
> +			    setxattr->setxa_flags);
> +
> +	if (!ret)
> +		set_change_info(&setxattr->setxa_cinfo, =
&cstate->current_fh);
> +
> +	return ret;
> +}
> +
> +static __be32
> +nfsd4_listxattrs(struct svc_rqst *rqstp, struct nfsd4_compound_state =
*cstate,
> +	   union nfsd4_op_u *u)
> +{
> +	int ret, len;
> +
> +	/*
> +	 * Get the entire list, then copy out only the user attributes
> +	 * in the encode function. lsxa_buf was previously allocated as
> +	 * tmp svc space, and will be automatically freed later.
> +	 */
> +	len =3D XATTR_LIST_MAX;
> +
> +	ret =3D nfsd_listxattr(rqstp, &cstate->current_fh, =
u->listxattrs.lsxa_buf,
> +			     &len);
> +	if (ret)
> +		return ret;
> +
> +	u->listxattrs.lsxa_len =3D len;
> +
> +	return nfs_ok;
> +}
> +
> +static __be32
> +nfsd4_removexattr(struct svc_rqst *rqstp, struct nfsd4_compound_state =
*cstate,
> +	   union nfsd4_op_u *u)
> +{
> +	struct nfsd4_removexattr *removexattr =3D &u->removexattr;
> +	int ret;
> +
> +	if (opens_in_grace(SVC_NET(rqstp)))
> +		return nfserr_grace;
> +
> +	ret =3D nfsd_removexattr(rqstp, &cstate->current_fh,
> +	    removexattr->rmxa_name);
> +
> +	if (!ret)
> +		set_change_info(&removexattr->rmxa_cinfo, =
&cstate->current_fh);
> +
> +	return ret;
> +}
> +
> /*
>  * NULL call.
>  */
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index f6322add2992..b12d7ac6f52c 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -41,6 +41,8 @@
> #include <linux/pagemap.h>
> #include <linux/sunrpc/svcauth_gss.h>
> #include <linux/sunrpc/addr.h>
> +#include <linux/xattr.h>
> +#include <uapi/linux/xattr.h>
>=20
> #include "idmap.h"
> #include "acl.h"
> --=20
> 2.16.6
>=20

--
Chuck Lever



