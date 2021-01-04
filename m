Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F1E2E9556
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Jan 2021 13:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbhADMzA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Jan 2021 07:55:00 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:41988 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbhADMzA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Jan 2021 07:55:00 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 104CnMp9181731;
        Mon, 4 Jan 2021 12:54:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=U02Aj5k3nzH1nICKf2gRL29S7+g0nkotAyFn8zpZxD0=;
 b=p2hlaVZj8+Q/MlS5cuEVS4/u7brBwXGaQR0ED7Iyyg94iuJGOs2g7T99FR8galfjkSNY
 FeO/Rgpdbuj6Yo0TDoUaCzW8zOknBOhjcFT2SDYDSCLcJcFT+nHEPOoaqLnIrTsbX/Pd
 4bTpYC5Q+c4opUvBjcyzj4KJqhD17Wqasem2Yre638RONzkw5FZ5ei0mz66f385gOTYB
 tMINABvSIoC9ly1Ut12K7ad/axK8pnH/66/Pnm0qIOXUGbA4vREIkNEGngoq1CvZgEFm
 7jbmyAPb0F0nl14oeHvEI5x5il6+5F/0yzhI/wjjNn4g/m2+ChH8xltYd3w04PQz+z7i kQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 35tebam6gs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 04 Jan 2021 12:54:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 104Cofxp088675;
        Mon, 4 Jan 2021 12:54:17 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 35v1f7bnhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Jan 2021 12:54:17 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 104CsHTq000847;
        Mon, 4 Jan 2021 12:54:17 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Jan 2021 04:54:17 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: Boot time improvement with systemd and nfs-utils
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAL5u83FRJQ_ys32S1KWjx72kamNw_3a2eFEAwH=MNMhruU9X=g@mail.gmail.com>
Date:   Mon, 4 Jan 2021 07:54:16 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6F313888-0355-4286-8692-E4685BCB2536@oracle.com>
References: <CAL5u83HS=nurJ=r0tJU8ZqAXXkvu9-vWZpbVWoKALNh22WdKnw@mail.gmail.com>
 <87F51982-465A-46D4-BFB9-4B5E5A7EB82C@oracle.com>
 <CAL5u83FRJQ_ys32S1KWjx72kamNw_3a2eFEAwH=MNMhruU9X=g@mail.gmail.com>
To:     Hackintosh Five <hackintoshfive@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9853 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101040084
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9853 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101040084
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi-

> On Jan 4, 2021, at 7:51 AM, Hackintosh Five <hackintoshfive@gmail.com> =
wrote:
>=20
> Hi, thanks for the fast reply
>=20
> I have never even used nfs and I'm not a systemd expert, so I'm not at
> all sure this interpretation is correct, but here goes. I only removed
> the dependency from rpc.statd.notify, not rpc.statd.

Same problem exists for sm-notify.


> I didn't remove
> the `After=3Dnfs-server` line, and for nfs-server to be up,
> network-online must be up first (there's an After requirement in the
> nfs-server unit). So if the nfs-server is enabled, the
> rpc-statd-notify will order itself after the server is up, which
> depends on the network.

IIRC sm-notify runs on clients too. That's why the dependency is
on the network and not on nfs-server.


> That means that, if there is a server, the
> server must be up before it sends notifications, so it will have the
> right hostname. This only improves boot speed on nfs clients, where
> nfs-client.target pulls in rpc-statd-notify.service.
>=20
>=20
> On Mon, Jan 4, 2021 at 12:27 PM Chuck Lever <chuck.lever@oracle.com> =
wrote:
>>=20
>> Hello, thanks for your report.
>>=20
>> The dependency you are removing addresses a bug -- if the network is =
not configured when rpc.statd is started, the rpc.statd process =
continues to use incorrect local address information even after the =
network is up.
>>=20
>>=20
>>> On Jan 4, 2021, at 6:32 AM, Hackintosh Five =
<hackintoshfive@gmail.com> wrote:
>>>=20
>>> rpc-statd-notify is causing a 10 second hang on my system during =
boot
>>> due to an unwanted dependency on network-online.target. This
>>> dependency isn't needed anyway, because rpc-statd-notify (sm-notify)
>>> will wait for the network to come online if it isn't already (up to =
15
>>> minutes, so no risk of timeout that would be avoided by systemd)
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> =46rom c90bd7e701c2558606907f08bf27ae9be3f8e0bf Mon Sep 17 00:00:00 =
2001
>>> From: Hackintosh 5 <git@hack5.dev>
>>> Date: Sat, 2 Jan 2021 14:28:30 +0000
>>> Subject: [PATCH] systemd: network-online.target is not needed for
>>> rpc-statd-notify.service
>>>=20
>>> Commit 09e5c6c2 changed the After line for rpc-statd-notify to =
change
>>> network.target to network-online.target, which is incorrect, because
>>> sm-notify has a default timeout of 15 minutes, which is longer than
>>> the timeout for network-online.target. In other words, the =
dependency
>>> on network-online.target is useless and delays system boot by ~10
>>> seconds.
>>> ---
>>> systemd/rpc-statd-notify.service | 4 ++--
>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>=20
>>> diff --git a/systemd/rpc-statd-notify.service
>>> b/systemd/rpc-statd-notify.service
>>> index aad4c0d2..8a40e862 100644
>>> --- a/systemd/rpc-statd-notify.service
>>> +++ b/systemd/rpc-statd-notify.service
>>> @@ -1,8 +1,8 @@
>>> [Unit]
>>> Description=3DNotify NFS peers of a restart
>>> DefaultDependencies=3Dno
>>> -Wants=3Dnetwork-online.target
>>> -After=3Dlocal-fs.target network-online.target nss-lookup.target
>>> +Wants=3Dnetwork.target
>>> +After=3Dlocal-fs.target network.target nss-lookup.target
>>>=20
>>> # if we run an nfs server, it needs to be running before we
>>> # tell clients that it has restarted.
>>> --
>>> 2.29.2
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>>=20

--
Chuck Lever



