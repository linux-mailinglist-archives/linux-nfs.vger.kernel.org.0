Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D05F018360C
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2020 17:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgCLQX7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Mar 2020 12:23:59 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42618 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbgCLQX7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Mar 2020 12:23:59 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CGNlQC116626;
        Thu, 12 Mar 2020 16:23:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=rAgn1U2CCy00wghQSTmXaLbxJqzit9lDTXSghMc0/i4=;
 b=ULG6hOTMcywNkO55edk4uiOSfVMEZLZqa9IVIietNLGirr5Nkru3ezxCZsMvGpKqGC5k
 dR8KBPgS0D8DyBb6FjIpT9DLKqZlOIbPJHhmgbEGNIHnrGB0LqQiyqg5vHziFJh+9WP6
 NcBcv5oFd0PYoPR2D8HnYbQoGFcVrmXXWzFvsbHHcKAQQPdNtuEqTxhFpR3zGqzguzRy
 ldIoo4UEQGw7zf8sE8R1tJ5zsYrjZwsKVr5PwPXxGnEbaeBtHP048YheOoa3KOMu2m6c
 MlgwFstNrNc0CWApe9GycFEiLumg64Nf9UdnxHozCjnjKibH1dTUJIx5yLMmVI8UNGwc tg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2yqkg89u2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 16:23:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CGM8BN085313;
        Thu, 12 Mar 2020 16:23:53 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2yqgvd91x4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 16:23:53 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02CGNqaK014362;
        Thu, 12 Mar 2020 16:23:52 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Mar 2020 09:23:52 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 05/14] nfsd: add defines for NFSv4.2 extended attribute
 support
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200311195954.27117-6-fllinden@amazon.com>
Date:   Thu, 12 Mar 2020 12:23:51 -0400
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <581E8839-3BFE-4B14-B2D2-910500785502@oracle.com>
References: <20200311195954.27117-1-fllinden@amazon.com>
 <20200311195954.27117-6-fllinden@amazon.com>
To:     Frank van der Linden <fllinden@amazon.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120084
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 lowpriorityscore=0
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
> Add defines for server-side extended attribute support. Most have
> already been added as part of client support, but these are
> the network order error codes for the noxattr and xattr2big errors,
> and the addition of the xattr support to the supported file
> attributes (if configured).
>=20
> Signed-off-by: Frank van der Linden <fllinden@amazon.com>
> ---
> fs/nfsd/nfsd.h | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 2ab5569126b8..362d481b28c9 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -281,6 +281,8 @@ void		nfsd_lockd_shutdown(void);
> #define nfserr_wrong_lfs		cpu_to_be32(NFS4ERR_WRONG_LFS)
> #define nfserr_badlabel			=
cpu_to_be32(NFS4ERR_BADLABEL)
> #define nfserr_file_open		cpu_to_be32(NFS4ERR_FILE_OPEN)
> +#define nfserr_xattr2big		cpu_to_be32(NFS4ERR_XATTR2BIG)
> +#define nfserr_noxattr			=
cpu_to_be32(NFS4ERR_NOXATTR)

Not clear to me why these shouldn't go into 01/14


> /* error codes for internal use */
> /* if a request fails due to kmalloc failure, it gets dropped.
> @@ -382,7 +384,8 @@ void		nfsd_lockd_shutdown(void);
> 	(NFSD4_1_SUPPORTED_ATTRS_WORD2 | \
> 	FATTR4_WORD2_CHANGE_ATTR_TYPE | \
> 	FATTR4_WORD2_MODE_UMASK | \
> -	NFSD4_2_SECURITY_ATTRS)
> +	NFSD4_2_SECURITY_ATTRS | \
> +	FATTR4_WORD2_XATTR_SUPPORT)

Should this instead be added, say, in 14/14 ?


> extern const u32 nfsd_suppattrs[3][3];
>=20
> --=20
> 2.16.6
>=20

--
Chuck Lever



