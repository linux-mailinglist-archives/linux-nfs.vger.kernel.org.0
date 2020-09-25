Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDD9278FA2
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Sep 2020 19:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbgIYRav (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Sep 2020 13:30:51 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33076 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729477AbgIYRav (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Sep 2020 13:30:51 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08PHOxAN193036;
        Fri, 25 Sep 2020 17:30:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=0goo4OHmRzZIaCRulucpY/K0d9Eyltoceyg66Olw1cs=;
 b=Po5ZPWGG6Eu3K+PCcTfTV0rC0WfG21IppoWDSddztwJ1MyUT1m+QBSFaQy8QwKi+hI6v
 QTKmp1RPHVx9uTePlQ2eZc70z9zD6xTul/BSaGZhWRxurR4qLJ+5x6w1rQUgNY52Kf2v
 PzzzU+X29Y6LJJi7Fsn4angqoANEd94lmVX8aH08AKzxmjl/vLCa8vj1iX0jLYMpIlOi
 VONj/zWJZtUxL7qrH7die3+093En7f61zZ4eO4lKOZE95hq0p85jCtPFZ1pSqilnUpia
 NBg4DaydaNDDvvnCYBz/CWkP09pb3BIYbCGr/uanl5/JOq9/RRRZXd2It+zRqVhDfKNB pg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 33ndnuxy46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Sep 2020 17:30:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08PHUa1o088200;
        Fri, 25 Sep 2020 17:30:48 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 33s75k4384-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Sep 2020 17:30:48 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08PHUk1w030071;
        Fri, 25 Sep 2020 17:30:47 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Sep 2020 10:30:46 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH 1/9] nfsd: rq_lease_breaker cleanup
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <160105319858.19706.8351588171501305958.stgit@klimt.1015granger.net>
Date:   Fri, 25 Sep 2020 13:30:45 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <67B5B38F-AFB1-484A-AC20-3D54430B0B5A@oracle.com>
References: <160105295313.19706.13224584458290743895.stgit@klimt.1015granger.net>
 <160105319858.19706.8351588171501305958.stgit@klimt.1015granger.net>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9755 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009250122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9755 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009250121
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 25, 2020, at 12:59 PM, Chuck Lever <chuck.lever@oracle.com> =
wrote:
>=20
> From: J. Bruce Fields <bfields@redhat.com>
>=20
> Since only the v4 code cares about it, maybe it's better to leave
> rq_lease_breaker out of the common dispatch code?
>=20
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
> fs/nfsd/nfs4state.c |    3 +++
> fs/nfsd/nfssvc.c    |    1 -
> 2 files changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index c09a2a4281ec..d9325dea0b74 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4596,6 +4596,9 @@ static bool nfsd_breaker_owns_lease(struct =
file_lock *fl)
>=20
> 	if (!i_am_nfsd())
> 		return NULL;
> +	/* Note rq_prog =3D=3D NFS_ACL_PROGRAM is also possible: */
> +	if (rqst->rq_prog !=3D NFS_PROGRAM || rqst->rq_vers < 4)
> +		return NULL;
> 	rqst =3D kthread_data(current);

I had to apply this one by hand, and as usual, got it wrong.


> 	if (!rqst->rq_lease_breaker)
> 		return NULL;
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index f7f6473578af..f6bc94cab9da 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -1016,7 +1016,6 @@ nfsd_dispatch(struct svc_rqst *rqstp, __be32 =
*statp)
> 		*statp =3D rpc_garbage_args;
> 		return 1;
> 	}
> -	rqstp->rq_lease_breaker =3D NULL;
> 	/*
> 	 * Give the xdr decoder a chance to change this if it wants
> 	 * (necessary in the NFSv4.0 compound case)
>=20
>=20

--
Chuck Lever



