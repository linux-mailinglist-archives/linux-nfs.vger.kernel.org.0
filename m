Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE10018F69B
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2020 15:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgCWONi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Mar 2020 10:13:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50258 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbgCWONi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Mar 2020 10:13:38 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02NEAJSf035252;
        Mon, 23 Mar 2020 14:13:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=1tSpkmAZfePHMVMgYd4LsZC51B3NeWy/D/cHmpTH46s=;
 b=lC8O94dZIwNPHQvtVAGKrAn+NaxiieihXjFp50xj40TLCSjhBwujaCFXnOR4ZXvGSSwX
 eU5vvfd1CWCmfDcZJ9OQFzNisZTvVIsZhZ0OiUcVICL4WLRfO8zTXoEgeQxHuLWfxRSe
 yClduAn7uOEGQpBop1RIoby3VfgH6EEK+Ey6YgIXUa9DPdPWe6uADndjk0VgEOn1D1xj
 GhPZkR76bI2t1qP52GfLC3/ZW9iOXL4Hpc2/+eGvJid5d7FhDbxGRQOfrEK/rpJposte
 Y7plbNjNo2s3nrPvc8qHdfSDYvoiuAudiPLoFgUOv4EidARMDFUeQzg9sH9gmC3z2dKb vQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2yx8abus2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Mar 2020 14:13:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02NE3J1A188177;
        Mon, 23 Mar 2020 14:13:32 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2yxw6jn52k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Mar 2020 14:13:32 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02NEDTxQ025639;
        Mon, 23 Mar 2020 14:13:30 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 23 Mar 2020 07:13:29 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: refcount underflow in nfsd41_destroy_cb
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200322044352.2ff1fbd8.jasiu@belsznica.pl>
Date:   Mon, 23 Mar 2020 10:13:28 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0C8A86EA-6015-4E9E-9A0E-DAEB4E988269@oracle.com>
References: <CAHmME9ro8BPBTMfu8dEbGmkH7qHLdQ=CXGEOW2C7MR4bmT6T+w@mail.gmail.com>
 <44C9D860-4F51-46B1-88A3-D10DDEF4BD8E@oracle.com>
 <20200322044352.2ff1fbd8.jasiu@belsznica.pl>
To:     Jan Psota <jasiu@belsznica.pl>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9568 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=965 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003230081
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9568 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 mlxscore=0 adultscore=0 phishscore=0 impostorscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003230081
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 21, 2020, at 11:43 PM, Jan Psota <jasiu@belsznica.pl> wrote:
>=20
> Chuck Lever <chuck.lever@oracle.com> napisa=C5=82(a):
>> Jan, how are you reproducing this?
>=20
> It looks like it's taking place on server on high NFS load and about
> a day after boot! (as I noticed looking into last -x results, below)
> Then system runs all right for a month (to be rebooted on new kernel
> [not always] or something like this).
>=20
> We have some NFS-rooted machines:
> /systemd on / type nfs4 =
(rw,relatime,vers=3D4.2,rsize=3D4096,wsize=3D4096,namlen=3D255,hard,proto=3D=
tcp,
> 	=
timeo=3D10,retrans=3D2,sec=3Dsys,clientaddr=3D192.168.1.18,local_lock=3Dno=
ne,addr=3D192.168.1.1)
>=20
> Server has 10Gb Aquantia AQC107 card connected to Mikrotik CSS326
> switch. Clients running distcc (aside from acting as workstations)
> are connected on 1Gb ethernet. Server runs Gentoo Linux on OpenRC
> (stations have Systemd) with recent gcc-9.3, binutils-2.34 and
> glibc-2.30, has 32 GB RAM and AMD Phenom II X6 1090T CPU.
>=20
> /var/tmp/portage, where compilation takes place, normally is on client
> tmpfs, but when there is not enough space to compile huge program, I
> switch it to server exported NFS
> (/etc/exports opts: -rw,async,no_root_squash,no_subtree_check)
>=20
> # "grep nfs.*destroy /var/log/messages" mixed with "last -x"

I thought I read in the initial report that you were seeing this
problem only on v5.6-rc6. What is the earliest kernel release
where you saw refcount UaF warnings from nfsd4_destroy_cb?


> reboot   system boot  5.5.1-gentoo     Mon Feb  3 00:20 - 15:22 =
(25+15:01)
> Feb  4 17:44:39 agro kernel:  nfsd41_destroy_cb+0x2c/0x40 [nfsd]
> 	rust compilation, kernel 5.5.1-gentoo
>=20
> reboot   system boot  5.5.6-gentoo     Fri Feb 28 15:23 - 16:25 =
(14+01:02)
> Feb 29 13:51:49 agro kernel:  nfsd41_destroy_cb+0x2c/0x40 [nfsd]
> 	rust compilation, kernel 5.5.6-gentoo
>=20
> reboot   system boot  5.5.9-gentoo     Fri Mar 13 16:27 - 00:04 =
(4+07:36)
> Mar 14 18:03:49 agro kernel:  nfsd41_destroy_cb+0x2c/0x40 [nfsd]
> 	libpciaccess compilation, kernel=20
>=20
> reboot   system boot  5.6.0-rc6        Wed Mar 18 00:06 - 20:39 =
(2+20:32)
> Mar 19 11:08:07 agro kernel:  nfsd41_destroy_cb+0x36/0x50 [nfsd]
> 	linux-firmware merge
> *
> reboot   system boot  5.6.0-rc6        Fri Mar 20 20:40 - 02:40  =
(05:59)
> Mar 20 21:43:34 agro kernel:  nfsd41_destroy_cb+0x36/0x50 [nfsd]
> 	zstd compilation
> *
> reboot   system boot  5.6.0-rc6        Sat Mar 21 02:42   still =
running
> Mar 21 17:34:43 agro kernel:  nfsd41_destroy_cb+0x36/0x50 [nfsd]
> 	nodejs compilation
>=20
> * - I noticed kernel fault looking for a reason, why WireGuard refused
> to connect with _some_ remote peers so I rebooted the server and it =
helped.

--
Chuck Lever



