Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6138F254740
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Aug 2020 16:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgH0Opw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Aug 2020 10:45:52 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46440 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgH0Ops (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Aug 2020 10:45:48 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07REjKnM115375;
        Thu, 27 Aug 2020 14:45:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=W5ZmE74RclFIcG6I9i444GCasBnjCBdyOLRikn0zGOU=;
 b=WibY8JO+fU3eAW0KYtx3FIiDN8A8R1oEgWVJYaKChqygeyDZpUYrGBlAH7NAoegSKk6r
 3a9L99CBbjTNGB3pPEa6VJCvHAep2ZY1f4wC1N0w0nIc0EvSXO/gQRRZXy/j5ZXVUUyO
 1981WPcInO+DtVwo7B5YSkjxR7tnmBYg9LE+r8Haztg0EUfBvU1d6CL94pLZXHxum8er
 pIJySfxjH9rR/AHVpdl+iNySLpcLlDIC/OF2bEuCZRYqgbWfiHbcJmAx/xOouXf43dvc
 Ui/Q5glZakKipPO4TuY6MidgF6obokDRpcTFaa/8tyZCQnmihmytKdhn53z2ZGakwtEY WA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 333w6u5bac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Aug 2020 14:45:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07REYtom164949;
        Thu, 27 Aug 2020 14:43:29 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 333r9ngday-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Aug 2020 14:43:29 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07REhLDW004007;
        Thu, 27 Aug 2020 14:43:23 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Aug 2020 07:43:21 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] nfsd: don't call trace_nfsd_deleg_none() if read
 delegation is given
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200827070237.19942-1-houtao1@huawei.com>
Date:   Thu, 27 Aug 2020 10:43:20 -0400
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6F61F417-95DA-4CD7-A81A-FA8C6299CF40@oracle.com>
References: <20200827070237.19942-1-houtao1@huawei.com>
To:     Hou Tao <houtao1@huawei.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9725 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008270112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9725 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008270113
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello!

> On Aug 27, 2020, at 3:02 AM, Hou Tao <houtao1@huawei.com> wrote:
>=20
> Don't call trace_nfsd_deleg_none() if read delegation is given,
> else two exclusive traces will be printed:
>=20
>    nfsd_deleg_open: client 5f45b854:e6058001 stateid 00000030:00000001
>    nfsd_deleg_none: client 5f45b854:e6058001 stateid 0000002f:00000001

These are reporting two different state IDs: the first is a delegation
state ID, and the second is an open state ID.

So in the "no delegation" case, we want to see just the open state ID.
In the "delegation" case, we do want to see both.

You could argue (successfully) that the names of the tracepoints are
pretty lousy. Maybe better to rename:

  nfsd_deleg_open -> nfsd_deleg_read
  nfsd_deleg_none -> nfsd_open

What do you think?


> Fix it by calling trace_nfsd_deleg_none() directly in appropriate
> places instead of calling it by checking the value of =
op_delegate_type.
>=20
> Also remove the unnecessary assignment "status =3D nfs_ok", because
> we can ensure status will be nfs_ok after the call of
> nfs4_inc_and_copy_stateid().
>=20
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
> fs/nfsd/nfs4state.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index c09a2a4281ec9..2e6376af701ff 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5131,6 +5131,8 @@ nfs4_open_delegation(struct svc_fh *fh, struct =
nfsd4_open *open,
> 	nfs4_put_stid(&dp->dl_stid);
> 	return;
> out_no_deleg:
> +	trace_nfsd_deleg_none(&stp->st_stid.sc_stateid);
> +
> 	open->op_delegate_type =3D NFS4_OPEN_DELEGATE_NONE;
> 	if (open->op_claim_type =3D=3D NFS4_OPEN_CLAIM_PREVIOUS &&
> 	    open->op_delegate_type !=3D NFS4_OPEN_DELEGATE_NONE) {
> @@ -5232,7 +5234,8 @@ nfsd4_process_open2(struct svc_rqst *rqstp, =
struct svc_fh *current_fh, struct nf
> 		if (open->op_deleg_want & NFS4_SHARE_WANT_NO_DELEG) {
> 			open->op_delegate_type =3D =
NFS4_OPEN_DELEGATE_NONE_EXT;
> 			open->op_why_no_deleg =3D WND4_NOT_WANTED;
> -			goto nodeleg;
> +			trace_nfsd_deleg_none(&stp->st_stid.sc_stateid);
> +			goto out;
> 		}
> 	}
>=20
> @@ -5241,9 +5244,6 @@ nfsd4_process_open2(struct svc_rqst *rqstp, =
struct svc_fh *current_fh, struct nf
> 	* OPEN succeeds even if we fail.
> 	*/
> 	nfs4_open_delegation(current_fh, open, stp);
> -nodeleg:
> -	status =3D nfs_ok;
> -	trace_nfsd_deleg_none(&stp->st_stid.sc_stateid);
> out:
> 	/* 4.1 client trying to upgrade/downgrade delegation? */
> 	if (open->op_delegate_type =3D=3D NFS4_OPEN_DELEGATE_NONE && dp =
&&
> --=20
> 2.25.0.4.g0ad7144999
>=20

--
Chuck Lever



