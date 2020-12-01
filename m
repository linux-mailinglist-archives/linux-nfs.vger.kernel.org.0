Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7179F2CA713
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Dec 2020 16:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391653AbgLAP1k (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Dec 2020 10:27:40 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:52216 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390243AbgLAP1k (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Dec 2020 10:27:40 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B1FJAla101958;
        Tue, 1 Dec 2020 15:26:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=bVu56DoJBPrj7Uuvt/lrh50jQn9TYx7KYQrU0jEE1xk=;
 b=yty9hnzGqszCCPWhYLqZhWDZg/ITuDj7jINmLRbKjuwhoqcAdPAcdReppGA8kiPReJHi
 fvLHJLr2KERp8VNpizs+6MSrpFS55Tlyl2KyYIM0c6AoKLYRpsXDZwzBuYsYoMTPChY5
 EsBn8VS2ePjW46KMP4GMlJGWW7lfTAeEYvSW+W7kKzCbqAugEvim8sNa17wOt/s0a/Yh
 LWPQGeQrTOnwjmVj0g1xzc0o0U0e9QXJpCoymfH+X8PmnRIuxAJ1tjt/DV9cDzuaf6xp
 Q30SnrOe8o+z8mRu1BEoor/o/pXoPWTlHVuol635eAS/Q/QINtzxm8MBL1g/estHCHjO vw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 353egkk2rp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 01 Dec 2020 15:26:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B1FFKtL145152;
        Tue, 1 Dec 2020 15:24:55 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 3540fx3yrb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Dec 2020 15:24:55 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0B1FOsiX025888;
        Tue, 1 Dec 2020 15:24:54 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Dec 2020 07:24:54 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 1/2] nfsd: Avoid /* Fallthrough */
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201201041427.756749-1-trondmy@kernel.org>
Date:   Tue, 1 Dec 2020 10:24:53 -0500
Cc:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <61BB1C52-3B7A-4A0B-A9C7-F25AB6D5BE34@oracle.com>
References: <20201201041427.756749-1-trondmy@kernel.org>
To:     trondmy@kernel.org
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9822 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=1
 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012010098
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9822 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=1
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012010098
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi -

> On Nov 30, 2020, at 11:14 PM, trondmy@kernel.org wrote:
>=20
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> The '/* Fallthrough */' comment is already deprecated. Avoid it.
>=20
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

I've squashed this into "nfsd: add a new EXPORT_OP_NOWCC flag to
struct export_operations", in addition to addressing Jeff's
comment about line in the patch description that states support
for re-exporting NFS filesystems may never be supported.

These changes will appear next time I push into the cel-next
branch.


> ---
> fs/nfsd/nfsfh.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index 46c86f7bc429..e80a7525561d 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -302,9 +302,9 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst =
*rqstp, struct svc_fh *fhp)
>=20
> 	switch (rqstp->rq_vers) {
> 	case 3:
> -		if (!(dentry->d_sb->s_export_op->flags & =
EXPORT_OP_NOWCC))
> -			break;
> -		/* Fallthrough */
> +		if (dentry->d_sb->s_export_op->flags & EXPORT_OP_NOWCC)
> +			fhp->fh_no_wcc =3D true;
> +		break;
> 	case 2:
> 		fhp->fh_no_wcc =3D true;
> 	}
> --=20
> 2.28.0
>=20

--
Chuck Lever



