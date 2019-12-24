Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA13C12A3EC
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Dec 2019 19:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfLXScf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Dec 2019 13:32:35 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:56524 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfLXScf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Dec 2019 13:32:35 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBOITvqs187200;
        Tue, 24 Dec 2019 18:32:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=JdI0uI88phbMZHH2kftmQWodYcYeYmFyzh71F7Y6YvI=;
 b=jUFDzH+kM7iCU46WFphzQtJaKFy9a6cmnn88lI1qRyE92Ek9oOR9nmnQcDcLPSI/GFyl
 j7OqO8zVFEOLo5GxndvcKUl6klfoXmofmB9rVJ1qvPEIHqXWYm8Idbu9EYxLO4lKdz0y
 +lnOGQ7Jz9Aez2k5kRHceV4lKVEWB9L1uRgBn4HtGLQYFsKcgtFWVIJLxmzr6CRr1fDV
 5ze6JNWFvkAmHkP7OsluoQtfBhdO8zSOFD0jy0bTpN0t7DE9bVhwSnmsghPkbgxKA6dw
 +Pfc1FA7LwbtOerPhvj0pqCqOJzB1QGt/4l2JgxKsIGQdm8eiyHaiSAl4rfcaIwchu+Y eg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2x1attmq16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Dec 2019 18:32:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBOIONB6160062;
        Tue, 24 Dec 2019 18:32:29 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2x3brdv1v7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Dec 2019 18:32:29 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBOIWPWC012926;
        Tue, 24 Dec 2019 18:32:27 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 24 Dec 2019 10:32:25 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2] NFSv4.0: nfs4_do_fsinfo() should not do implicit lease
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <001901d5ba67$8954ede0$9bfec9a0$@gmail.com>
Date:   Tue, 24 Dec 2019 13:32:24 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <594E0E04-1253-4C0D-8A58-EB4AF883B7EC@oracle.com>
References: <001901d5ba67$8954ede0$9bfec9a0$@gmail.com>
To:     Robert Milkowski <rmilkowski@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9481 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912240160
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9481 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912240161
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Robert-

> On Dec 24, 2019, at 9:36 AM, Robert Milkowski <rmilkowski@gmail.com> =
wrote:
>=20
> From: Robert Milkowski <rmilkowski@gmail.com>
>=20
> Currently, each time nfs4_do_fsinfo() is called it will do an implicit
> NFS4 lease renewal, which is not compliant with the NFS4 =
specification.
> This can result in a lease being expired by an NFS server.

In addition to stating the bug symptoms, IMO you need

Fixes: 83ca7f5ab31f ("NFS: Avoid PUTROOTFH when managing leases")

And this description needs to explain how 83ca7f5ab31f broke things.


> Signed-off-by: Robert Milkowski <rmilkowski@gmail.com>
> ---
> fs/nfs/nfs4proc.c | 10 +++++++---
> 1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 76d3716..b6cad9a 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -5016,19 +5016,23 @@ static int _nfs4_do_fsinfo(struct nfs_server =
*server, struct nfs_fh *fhandle,
>=20
> static int nfs4_do_fsinfo(struct nfs_server *server, struct nfs_fh =
*fhandle, struct nfs_fsinfo *fsinfo)
> {
> +	struct nfs_client *clp =3D server->nfs_client;
> 	struct nfs4_exception exception =3D {
> 		.interruptible =3D true,
> 	};
> -	unsigned long now =3D jiffies;
> +	unsigned long last_renewal =3D jiffies;
> 	int err;
>=20
> 	do {
> 		err =3D _nfs4_do_fsinfo(server, fhandle, fsinfo);
> 		trace_nfs4_fsinfo(server, fhandle, fsinfo->fattr, err);

There are two usual practices to introduce behavior that diverges
amongst NFSv4 minor versions. Neither practice is followed here.

- The difference is added to the XDR encoder and decoder. You could
do that by adding a RENEW to the COMPOUND in the NFSv4.0 case.

- The function is converted to a virtual function which is added to
struct nfs4_minor_version_ops.

Prior to 83ca7f5ab31f, IIRC this function was part of a code path
that did actually renew the lease. It seems to me that the proper
fix here is to make NFSv4.0 renew the lease, not the other way
around. Is there a reason not to add a RENEW to the NFSv4.0 version
of the fsinfo COMPOUND?


> 		if (err =3D=3D 0) {
> -			nfs4_set_lease_period(server->nfs_client,
> +			/* no implicit lease renewal allowed here for =
v4.0 */
> +			if (clp->cl_minorversion =3D=3D 0 && =
clp->cl_last_renewal !=3D 0)
> +				last_renewal =3D clp->cl_last_renewal;
> +			nfs4_set_lease_period(clp,
> 					fsinfo->lease_time * HZ,
> -					now);
> +					last_renewal);
> 			break;
> 		}
> 		err =3D nfs4_handle_exception(server, err, &exception);
> --=20
> 1.8.3.1

--
Chuck Lever



