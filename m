Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF6B2E94D6
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Jan 2021 13:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbhADM20 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Jan 2021 07:28:26 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:45798 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbhADM2Z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Jan 2021 07:28:25 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 104CF4No181557;
        Mon, 4 Jan 2021 12:27:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=nVH/5DIVLnB5sEX1a6Ax3ASOPoAUtVc8wzpKJO0J+OE=;
 b=TN+5RLueD1jqsFL2yO2vssDXe2ltECtTQL+19XYDIcXG4lWqLm0egEnVbJH2rTssNyRr
 SW6pjJgWO/Y1AT6sFYuTAQBJDC+5HZkHTGP0J2q2ZVnIAaq0iTTZMk8ujmLtj4c4CLuk
 wXLLR1pTOpBRa9KVyNB6CRecqBOreARPHQipOo+L0wS4Jif42eyNR6OZnk3XHqgm1hoy
 JRQwNGeSi5TRUnCvgaW3OkEE5d2xlGvFdxw8udA4+UCT8v8M/0oDhM2+POqJui/7JG3o
 q6MIeQFcczSIM+3/16oi438EQlBWngKhGKEmVA8EYbmLXq8W86v5PaeAGHNg2EnlPukQ SA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 35tgskm1d2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 04 Jan 2021 12:27:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 104CHIMQ129436;
        Mon, 4 Jan 2021 12:27:43 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 35v2ax2seq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Jan 2021 12:27:42 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 104CRgYk025712;
        Mon, 4 Jan 2021 12:27:42 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Jan 2021 12:27:42 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: Boot time improvement with systemd and nfs-utils
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAL5u83HS=nurJ=r0tJU8ZqAXXkvu9-vWZpbVWoKALNh22WdKnw@mail.gmail.com>
Date:   Mon, 4 Jan 2021 07:27:41 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <87F51982-465A-46D4-BFB9-4B5E5A7EB82C@oracle.com>
References: <CAL5u83HS=nurJ=r0tJU8ZqAXXkvu9-vWZpbVWoKALNh22WdKnw@mail.gmail.com>
To:     Hackintosh Five <hackintoshfive@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9853 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101040082
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9853 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101040082
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello, thanks for your report.

The dependency you are removing addresses a bug -- if the network is not =
configured when rpc.statd is started, the rpc.statd process continues to =
use incorrect local address information even after the network is up.


> On Jan 4, 2021, at 6:32 AM, Hackintosh Five <hackintoshfive@gmail.com> =
wrote:
>=20
> rpc-statd-notify is causing a 10 second hang on my system during boot
> due to an unwanted dependency on network-online.target. This
> dependency isn't needed anyway, because rpc-statd-notify (sm-notify)
> will wait for the network to come online if it isn't already (up to 15
> minutes, so no risk of timeout that would be avoided by systemd)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =46rom c90bd7e701c2558606907f08bf27ae9be3f8e0bf Mon Sep 17 00:00:00 =
2001
> From: Hackintosh 5 <git@hack5.dev>
> Date: Sat, 2 Jan 2021 14:28:30 +0000
> Subject: [PATCH] systemd: network-online.target is not needed for
> rpc-statd-notify.service
>=20
> Commit 09e5c6c2 changed the After line for rpc-statd-notify to change
> network.target to network-online.target, which is incorrect, because
> sm-notify has a default timeout of 15 minutes, which is longer than
> the timeout for network-online.target. In other words, the dependency
> on network-online.target is useless and delays system boot by ~10
> seconds.
> ---
> systemd/rpc-statd-notify.service | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/systemd/rpc-statd-notify.service
> b/systemd/rpc-statd-notify.service
> index aad4c0d2..8a40e862 100644
> --- a/systemd/rpc-statd-notify.service
> +++ b/systemd/rpc-statd-notify.service
> @@ -1,8 +1,8 @@
> [Unit]
> Description=3DNotify NFS peers of a restart
> DefaultDependencies=3Dno
> -Wants=3Dnetwork-online.target
> -After=3Dlocal-fs.target network-online.target nss-lookup.target
> +Wants=3Dnetwork.target
> +After=3Dlocal-fs.target network.target nss-lookup.target
>=20
> # if we run an nfs server, it needs to be running before we
> # tell clients that it has restarted.
> --=20
> 2.29.2

--
Chuck Lever



