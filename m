Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54AE1A733C
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Sep 2019 21:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbfICTMP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Sep 2019 15:12:15 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47162 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfICTMP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Sep 2019 15:12:15 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83J9MVT177797;
        Tue, 3 Sep 2019 19:09:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=2mnaEi4L6RKyN2rqDPfcG1hrO0FOASLbWMPnmPGtg2k=;
 b=c1TFU48Cf0EWzEvaGESz7u27kDH+yXPTHUB2YfG+Q8pGkt3HI7D1lfjjgeC1UL/nvPGx
 +muoXQerj4apyXXK3bIcFmE6ErGW9gXzY9glmUbosfxEbUFtw8mqNYHi7zjIr90Xhfw+
 lbmGplCZ67qLwwctTonIu3/Ig9om8sDAepk+yEbQhe/3ZRyKgP2Pa3CsLSJonJg4IHlV
 Ej3DcE7viPLfHyLf7/pNh3haTrLz/gBOeZIS/AK7ar+0V6s8zl+GWPEG/0x07y6nSOUE
 Zi4e38vIZw/KIuT7XR0OyHStl0lwWdcvH2fN+Ir+bTRKCmJUTXxhkxPSeQiWLPDpxWyv bw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2usx2pg047-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Sep 2019 19:09:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83J88mv133260;
        Tue, 3 Sep 2019 19:09:18 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2usu50xefm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Sep 2019 19:09:18 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x83J8NJs024856;
        Tue, 3 Sep 2019 19:08:27 GMT
Received: from [192.168.1.184] (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Sep 2019 12:08:23 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: Regression in 5.1.20: Reading long directory fails
From:   Chuck Lever <chuck.lever@oracle.com>
X-Mailer: iPad Mail (16G77)
In-Reply-To: <ufapnkhqjwm.fsf@epithumia.math.uh.edu>
Date:   Tue, 3 Sep 2019 15:08:22 -0400
Cc:     Wolfgang Walter <linux@stwm.de>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-nfs@vger.kernel.org, km@cm4all.com,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <70F51337-A68B-473B-88B9-0CAC3D6F2AB9@oracle.com>
References: <ufak1bhyuew.fsf@epithumia.math.uh.edu> <ufay2zduosz.fsf@epithumia.math.uh.edu> <ufa5zm9s7kz.fsf@epithumia.math.uh.edu> <4418877.15LTP4gqqJ@stwm.de> <ufapnkhqjwm.fsf@epithumia.math.uh.edu>
To:     Jason L Tibbitts III <tibbs@math.uh.edu>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=928
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909030189
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=976 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909030189
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On Sep 3, 2019, at 3:06 PM, Jason L Tibbitts III <tibbs@math.uh.edu> wrote:

>>>>>> "WW" =3D=3D Wolfgang Walter <linux@stwm.de> writes:
>=20
> WW> What filesystem do you use on the server? xfs?
>=20
> Yeah, it's XFS.
>=20
> WW> If yes, does it use 64bit inodes (or started to use them)?
>=20
> These filesystems aren't super old, and were all created with the
> default RHEL7 options.

I think that means no 64-bit inodes.


> I'm not sure how to check that 64 bit inodes are
> being used, though.  xfs_info says:
>=20
> meta-data=3D/dev/mapper/nas-faculty--08 isize=3D256    agcount=3D4, agsize=
=3D3276800 blks
>         =3D                       sectsz=3D512   attr=3D2, projid32bit=3D1=

>         =3D                       crc=3D0        finobt=3D0 spinodes=3D0
> data     =3D                       bsize=3D4096   blocks=3D13107200, imaxp=
ct=3D25
>         =3D                       sunit=3D0      swidth=3D0 blks
> naming   =3Dversion 2              bsize=3D4096   ascii-ci=3D0 ftype=3D0
> log      =3Dinternal               bsize=3D4096   blocks=3D6400, version=3D=
2
>         =3D                       sectsz=3D512   sunit=3D0 blks, lazy-coun=
t=3D1
> realtime =3Dnone                   extsz=3D4096   blocks=3D0, rtextents=3D=
0
>=20
> WW> Do you set a fsid when you export the filesystem?
>=20
> I have never done so on any server.
>=20
> And note that the servers are basically unchanged for quite some time,
> while the problem I'm having is new.  I want to find some server-related
> cause for this but so far I haven't been able to do so.  It seems my
> best option now seems to be to migrate all data off of this server and
> then wipe, reinstall and see if the problem reoccurs.
>=20
> - J<

