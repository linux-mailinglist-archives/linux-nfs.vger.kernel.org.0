Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C76C5255B28
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Aug 2020 15:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgH1NWR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Aug 2020 09:22:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43840 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbgH1NWO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Aug 2020 09:22:14 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07SDJPRU144761;
        Fri, 28 Aug 2020 13:22:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=Zl3HP07jA/p+6gksEW9buOgGr4lxuDl2t7UcjcJFzWA=;
 b=XflvyS0Hv6VmDMoFnaVoOr4pZnQ1F9DcGY4rqNdHvzS4mk0SVuCbSSPAYPYIob02Gda9
 l8LZALE4rIwNIhebUD90xTamJqeZxXBYDlPa5DEMXI1iv7l+fnKZm+ocxS6adMfE5iz/
 eAbL8O0b4p98+kj2mjQlt8noNJ4iJWc5N1RxVzURLR+mLMessdOXoZPSOjir8+sY6pcD
 8vqAfuRtJq+X3VSJ4CYIv57IVnuIgO5mv0ctrqTVUcfatWPKinJU2sfwUeY2i34z9e77
 FRx5u8Bwrij6kZ+yH3UzZBzQXn6MYZzDmbbjkbt34CaLsfDYPvNjNxsGazvR+l5jDaph pg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 333w6uafen-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Aug 2020 13:22:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07SDF1v9155128;
        Fri, 28 Aug 2020 13:21:59 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 333r9pp12s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Aug 2020 13:21:59 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07SDLu49031719;
        Fri, 28 Aug 2020 13:21:56 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Aug 2020 06:21:56 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH v2] nfsd: rename delegation related tracepoints to make
 them less confusing
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200828070255.141460-1-houtao1@huawei.com>
Date:   Fri, 28 Aug 2020 09:21:55 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D32F1F35-2725-4809-9D10-2ED6EE2A2613@oracle.com>
References: <6F61F417-95DA-4CD7-A81A-FA8C6299CF40@oracle.com>
 <20200828070255.141460-1-houtao1@huawei.com>
To:     Hou Tao <houtao1@huawei.com>, Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9726 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008280102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9726 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008280102
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 28, 2020, at 3:02 AM, Hou Tao <houtao1@huawei.com> wrote:
>=20
> Now when a read delegation is given, two delegation related traces
> will be printed:
>=20
>    nfsd_deleg_open: client 5f45b854:e6058001 stateid 00000030:00000001
>    nfsd_deleg_none: client 5f45b854:e6058001 stateid 0000002f:00000001
>=20
> Although the intention is to let developers know two stateid are
> returned, the traces are confusing about whether or not a read =
delegation
> is handled out. So renaming trace_nfsd_deleg_none() to =
trace_nfsd_open()
> and trace_nfsd_deleg_open() to trace_nfsd_deleg_read() to make
> the intension clearer.
>=20
> The patched traces will be:
>=20
>    nfsd_deleg_read: client 5f48a967:b55b21cd stateid 00000003:00000001
>    nfsd_open: client 5f48a967:b55b21cd stateid 00000002:00000001
>=20
> Suggested-by: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: Hou Tao <houtao1@huawei.com>

LGTM. I assume Bruce is taking this for v5.10.


> ---
> v1: https://marc.info/?l=3Dlinux-nfs&m=3D159851134513236&w=3D2
>=20
> fs/nfsd/nfs4state.c | 4 ++--
> fs/nfsd/trace.h     | 4 ++--
> 2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index c09a2a4281ec9..0525acfe31314 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5126,7 +5126,7 @@ nfs4_open_delegation(struct svc_fh *fh, struct =
nfsd4_open *open,
>=20
> 	memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, =
sizeof(dp->dl_stid.sc_stateid));
>=20
> -	trace_nfsd_deleg_open(&dp->dl_stid.sc_stateid);
> +	trace_nfsd_deleg_read(&dp->dl_stid.sc_stateid);
> 	open->op_delegate_type =3D NFS4_OPEN_DELEGATE_READ;
> 	nfs4_put_stid(&dp->dl_stid);
> 	return;
> @@ -5243,7 +5243,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, =
struct svc_fh *current_fh, struct nf
> 	nfs4_open_delegation(current_fh, open, stp);
> nodeleg:
> 	status =3D nfs_ok;
> -	trace_nfsd_deleg_none(&stp->st_stid.sc_stateid);
> +	trace_nfsd_open(&stp->st_stid.sc_stateid);
> out:
> 	/* 4.1 client trying to upgrade/downgrade delegation? */
> 	if (open->op_delegate_type =3D=3D NFS4_OPEN_DELEGATE_NONE && dp =
&&
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 1861db1bdc670..99bf07800cd09 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -289,8 +289,8 @@ DEFINE_STATEID_EVENT(layout_recall_done);
> DEFINE_STATEID_EVENT(layout_recall_fail);
> DEFINE_STATEID_EVENT(layout_recall_release);
>=20
> -DEFINE_STATEID_EVENT(deleg_open);
> -DEFINE_STATEID_EVENT(deleg_none);
> +DEFINE_STATEID_EVENT(open);
> +DEFINE_STATEID_EVENT(deleg_read);
> DEFINE_STATEID_EVENT(deleg_break);
> DEFINE_STATEID_EVENT(deleg_recall);
>=20
> --=20
> 2.25.0.4.g0ad7144999
>=20

--
Chuck Lever



