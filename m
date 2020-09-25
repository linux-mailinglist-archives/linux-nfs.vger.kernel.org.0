Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 896162792A4
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Sep 2020 22:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgIYUuB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Sep 2020 16:50:01 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:35108 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgIYUuB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Sep 2020 16:50:01 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08PKnbsT107848;
        Fri, 25 Sep 2020 20:50:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=pCD51oZBIkc+VDyKCh3TewKLBv9SVKSImTi5oIL5Gdc=;
 b=KJ2ergvObwiuTUBg6kEMfbivTFDQsDfIYPIJtsw+Bsu6BavpHQ+Z6F2TB5LgPLd1b3AN
 Ir4AJhT1GmCzYE4su7d5dDxyPr8vyA3tD6eqwg8MYfXYIGHc8kDheTBdDLUu1ut7DNaz
 hrQ7dU2vQoOzadygAlwW+AauCR2aXHOSz6tHdzsGAij0eTyC5DgpouOc4GrLWPOzOUst
 0cAXf5V/pKiikMqz6G3WPVZk001j5heY7QlMIvngeREtWYfKPn0APWnbHvCeeUKowopD
 Im0s4fR9l4Sev2Ve9QUgNtOxEj9ncLGRZjifV9PXI7nbYYWqrZXJX9SJ4U2jblli/l1G 4g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 33qcpucnx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Sep 2020 20:50:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08PKnXK0139318;
        Fri, 25 Sep 2020 20:49:59 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 33nux4ywy9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Sep 2020 20:49:59 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08PKnwkm014304;
        Fri, 25 Sep 2020 20:49:59 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Sep 2020 13:49:58 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] nfsd: rq_lease_breaker cleanup
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200925204809.GI1096@fieldses.org>
Date:   Fri, 25 Sep 2020 16:49:57 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5B93AC63-B81B-443B-BE28-D4F718978817@oracle.com>
References: <160106058240.10141.2317053300018495103.stgit@klimt.1015granger.net>
 <20200925204809.GI1096@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9755 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009250150
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9755 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009250150
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 25, 2020, at 4:48 PM, J. Bruce Fields <bfields@fieldses.org> =
wrote:
>=20
> On Fri, Sep 25, 2020 at 03:03:42PM -0400, Chuck Lever wrote:
>> From: J. Bruce Fields <bfields@redhat.com>
>>=20
>> Since only the v4 code cares about it, maybe it's better to leave
>> rq_lease_breaker out of the common dispatch code?
>>=20
>> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> fs/nfsd/nfs4state.c |    3 +++
>> fs/nfsd/nfs4xdr.c   |    1 +
>> fs/nfsd/nfssvc.c    |    2 --
>> 3 files changed, 4 insertions(+), 2 deletions(-)
>>=20
>> Hey Bruce-
>>=20
>> This seems to work a little better than the patch you sent me
>> this morning.
>=20
> Oops, right, I should have warned that was untested!  I don't know how
> it got past me that I was trying to read rqst before it was set....
>=20
> The other two lines aren't needed, though.
>=20
> (The only place we read rq_lease_breaker is in =
nfsd_breaker_owns_lease(),
> and only after we've checked that we're running as an nfsd thread
> processing an NFSv4 rpc.
>=20
> Such a thread shouldn't touch the filesystem and trigger this callback
> until it's in nfsd4_proc_compound.  Which sets rq_lease_breaker at the
> start.)
>=20
> --b.
>=20
> commit 4abef2c530f7
> Author: J. Bruce Fields <bfields@redhat.com>
> Date:   Fri Sep 25 10:12:39 2020 -0400
>=20
>    nfsd: rq_lease_breaker cleanup
>=20
>    Since only the v4 code cares about it, maybe it's better to leave
>    rq_lease_breaker out of the common dispatch code?
>=20
>    Signed-off-by: J. Bruce Fields <bfields@redhat.com>
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 62afcae18e17..c13b04718a3f 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4598,6 +4598,9 @@ static bool nfsd_breaker_owns_lease(struct =
file_lock *fl)
> 	if (!i_am_nfsd())
> 		return NULL;
> 	rqst =3D kthread_data(current);
> +	/* Note rq_prog =3D=3D NFS_ACL_PROGRAM is also possible: */
> +	if (rqst->rq_prog !=3D NFS_PROGRAM || rqst->rq_vers < 4)
> +		return NULL;

Am I missing a patch that removes

	if (!rqst->rq_lease_breaker)
		return NULL;

> 	clp =3D *(rqst->rq_lease_breaker);
> 	return dl->dl_stid.sc_client =3D=3D clp;
> }
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index b603dfcdd361..8d6f6f4c8b28 100644
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

--
Chuck Lever



