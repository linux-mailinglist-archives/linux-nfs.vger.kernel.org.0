Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F0C67D03F
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Jan 2023 16:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbjAZPbj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Jan 2023 10:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbjAZPbi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Jan 2023 10:31:38 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2119.outbound.protection.outlook.com [40.107.101.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E006B45F44
        for <linux-nfs@vger.kernel.org>; Thu, 26 Jan 2023 07:31:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bG9KB4jZCzqxq5TRCWbTQMMwlZl8rRYc8ulFKAASc3mY6AmNRAiVthct17r+3HS1eUfgc8UU/jv4DbQ1fdgNs2/Ik+HFo6cad0cPFY12gzXy1ApaL3uTjEiXPBVx6Ze/aPo8HsXa6zlhaX5azpkZnBnAngyQarRmHIpahuZZ2BNNvmse1lFR9PTGf1QQgKMEfTqWVzo/iuHUOU5iMPgd0Zquuo8I2b7an6wGpje6UqewnB/l9WPiARPP4QKLfxOPb1dhQJPFuXkVudpOTpAkpyD+WJoL6+xjNHUPVxGfbJwaTptJe6BGvjmm/JVHneYy9WLW0N6+/weYgnoDe8Nf9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9PTGC/PKX/7RuNyzC2JbDgwysR0f21IyGiuXQprW+c=;
 b=i7TatPwxejKa2LmtHZweTdpFsdhoYkIW/n5PnNS5KqhilWT19fVE7YtqV3M3243jVpM9C6hcXM+n5lvqCvNjglHPEfNqD7ugfEVFIhsxIXRV8KF6NC5lgsnS/nsf4rfav/CbMqbjsKMZdId3wlFnW+nq4CfpOdpvegBUYIEo5jPdZ/Ej52yKH+9bgePUlAu4/AofC6IK2HlSfCJK9Z7U7qgmKB15/aPU87WRdN0VeW18dzTy/t67sWW+alp9zVxC/IP7rtAq/mkEaGKpZiWAEQPMNzKqUNQBooKDFfRF9INb8W1hxA53cN3/+JjLHiOxY8ig3h+46vCNKDERT1bWaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=boatrocker.com; dmarc=pass action=none
 header.from=boatrocker.com; dkim=pass header.d=boatrocker.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=boatrocker.onmicrosoft.com; s=selector2-boatrocker-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9PTGC/PKX/7RuNyzC2JbDgwysR0f21IyGiuXQprW+c=;
 b=1eCWffIPNX9mjDb9YSHCvanZUO2jfcHh1ojmxr099Y6imttN0DohXI8oipMpOY31hwtfNJhqUpBBqehaAPlHa1YOUFdjybjwFQ75qfTilSWsOr2JvG2Ej5cZIcrdTYPikD3V2wOETPZwPLPA08GADsr00R/qMOcp0BuxFy2OahY=
Received: from YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:69::7)
 by YQXPR01MB6495.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:43::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Thu, 26 Jan
 2023 15:31:35 +0000
Received: from YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::7303:f215:657e:1643]) by YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::7303:f215:657e:1643%5]) with mapi id 15.20.6043.022; Thu, 26 Jan 2023
 15:31:35 +0000
From:   Andrew Klaassen <andrew.klaassen@boatrocker.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: RE: Trying to reduce NFSv4 timeouts to a few seconds on an
 established connection
Thread-Topic: Trying to reduce NFSv4 timeouts to a few seconds on an
 established connection
Thread-Index: AdkvR33g3mzLGSb7R/abGwkCKolj9QCUyz5A
Date:   Thu, 26 Jan 2023 15:31:35 +0000
Message-ID: <YQBPR01MB10724AEE306F99C844101EED086CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
References: <YQBPR01MB10724B629B69F7969AC6BDF9586C89@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <YQBPR01MB10724B629B69F7969AC6BDF9586C89@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=boatrocker.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YQBPR01MB10724:EE_|YQXPR01MB6495:EE_
x-ms-office365-filtering-correlation-id: dc050d30-e1df-416c-f914-08daffb268d0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(346002)(366004)(39850400004)(376002)(451199018)(33656002)(7696005)(71200400001)(8676002)(316002)(478600001)(6506007)(55236004)(5660300002)(44832011)(66946007)(2906002)(6916009)(76116006)(66556008)(64756008)(66476007)(52536014)(8936002)(41300700001)(66446008)(38070700005)(55016003)(122000001)(38100700002)(26005)(83380400001)(86362001)(9686003)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rPeYbOtBk1+5GSqOp1ONrIpVPWAXcIj4+29HHcOeRJQl+pe8FQMka/vI97IEbIyD7KNHvwkaLm5y6C9APwhgpwfl0yWpvo9YzJ7FqTEak+Cq3Mgo+Rhhw6SLE3IbTzAbkV9A6TCvNCfw+/lh1Sz/uI0u0sCXqKhO8XfKnnIIlNVfF1CUhjWW0lhxy0zD+YVjQMG6GDbM2gLvhvmT1PDq3UugpReBLuJ2ZFe/wQyKwwHr72YHt/jbyNiLALd+i4GnVlT3T4bWB+vjP8szQotJFI2mha05H+25ZGOYN8YKYrMCJ+uzTMjn5kCFkaKBeC3MvTxxt6mEAyJXviAE1OGxyEX5R8e5caKwS1MwI52mf4pruEqM7qkC3PcmCIciZDpR465vMobuMk0lxRgjRMIJAFI9qlrWQRB9rn/AuyG1JF+NHVmgcYyk40yTQG4QaCCWuSt/qKnaALKN2XC2G5ldK06Tym5xcTR6PL87VGcVlz34+fs9SNH0q5UCu1OLNbpOWv96r2g5UrnazrhrJjpS3lU6ve6UIwFWpsEfuh+vXqyorrEmZqXPDPCOKF27sECAUR3G7PyrbV4Lzfl4SA8PbS48l3q8bp/GHQS9IONW1/ozHFykP+C95X597WkoV3PuStbkgcPX+PFfmzHdkq50vlNzx6WX8bi0jQEgXNZPTxVAh/eHM/B4un3IjEWqtWCa
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LxgLJJ3bGXT9s+GP06p1cxPZEiSjQZqVAsWqzhmpU/TN7C41i3ATgRBGQzvw?=
 =?us-ascii?Q?lXb4sL8AIWAiATow+VsieO6+wy8tkixdPdecpt0xuejo1n8e3xjUwSLqB+hA?=
 =?us-ascii?Q?GSu/T5x654HYV2Cjxig/wkvuWOdcZbMiAKe6auURqah8w8DUo/Qbj9ObmETB?=
 =?us-ascii?Q?DieOETTSmiIxLNNuREYlH+CzAUBKkxPt4axNnl8OIffu997y+0FPl2gq+ryI?=
 =?us-ascii?Q?GkV5UXgmyyx+GvcVPK93yw4aJUCXqXf9MTsCuW4K52NYoh3iZbsSJqF3hdmM?=
 =?us-ascii?Q?qOMg9G+QR1v/80Pv1SedbTOAMeKaZ9T8AKwWA2ifC3YkdI8aLQ8VZBL9X++g?=
 =?us-ascii?Q?R2g6xDDpyJDnPrYvZAHC1VXI21NuSUV0nPUnQpSy+sakcNoebojZjJ2Mf/kA?=
 =?us-ascii?Q?68DLo9wOcviIkWBV61l9xwg3dXsCQ2h55xmsnjENbUmXgRL8HTcAWmLDfo9P?=
 =?us-ascii?Q?eH4uRMtnvHbPsJX0ukAsczVtf9KPIn7frvWct8HX6s/r2WY0CPYVQ5ixGBsq?=
 =?us-ascii?Q?wiZOS2l32u2iJjBwngsur3oThAUzgZHL8a6cnMgHr/XQVmOsnPXIH5zS/02j?=
 =?us-ascii?Q?Pwh5+9nr3BcOQwF7lHwuEGKz7/pwolo7lcG8FtROjUeZG08xeCaLx/FVu3Nf?=
 =?us-ascii?Q?de5flYZkA2mMygLPguLZhI0js2XS2VxJAeRtzosTqcTKJJllSw7lDfNnOFOm?=
 =?us-ascii?Q?OXYEySzKo1BZjja9ETMny/M45vU6XCQvRa2QIsUjBmnMkoe0ENaLeNSySotF?=
 =?us-ascii?Q?5uIsdS5gI/BYNSV4npIWku+5LNfycA/VFHLg6pnpoSCTInX8KCu4zt+FuFwt?=
 =?us-ascii?Q?746kdsjKnvVv+MsTgat1Injg3rTVV8jL/bTWeszZntjL7h+ynoXNgZHfVz/q?=
 =?us-ascii?Q?LR6GOheJhtlgJcAMTjZ68M6bYtkEiMX9s5RTAINQg/Gcj7I1H2pESCtVu1Wj?=
 =?us-ascii?Q?O8/MUmwohnz1g2QK267EvtTQl7zVFQxzq8tFKXUvxCT6FRr6BuolQjef0SM5?=
 =?us-ascii?Q?LzTpvjFtX4r4pHxbS4KJy4NWSvmyBhahC0wcMToy13ITeoe+Vg5R1vXZVfN3?=
 =?us-ascii?Q?aEtwPWErAhSsxTagxIfIUMgQUdLep2O8vRa6M3FWM/2N4PP0dbsXZvsVnS18?=
 =?us-ascii?Q?VcMxbCs8Noo54EH9d7O9EdPRKdeGvT74M6OiREjwqpA+ZedRw/yRsf/2zeN5?=
 =?us-ascii?Q?U02ew7jkGtcwJDWRXCwVCnmGe6e7rzdaFkINsrFmtjPlhureX21w6XhNgVTh?=
 =?us-ascii?Q?VTYPiInWdFNKIeh7gvz5NWKIFbjc9Q37r92ImE12fJwI6mIYZNC/bMgv1tvt?=
 =?us-ascii?Q?sEr8dF4EfgA6ll+qL2RZKf9loKR9Q34rMrjOvGF0PqA3YhfWN+az/nT72ND2?=
 =?us-ascii?Q?DB8oW3AG/+WTfCd2N7LqMk2ku8t/BgsB8zxfb/StQMox+AWzUdnl/o0L1vs7?=
 =?us-ascii?Q?D8Omda7Lv5DZ//lgQYpCvK5bH/MG4qIqqGrnMS+Wa0VFl1ifoj9jNM5si+Xy?=
 =?us-ascii?Q?//Z+bu+MigEY7n+VBrSMvtKQz9GagA2oa8NkSX1LzqsEc0r7argsU+ZsqVqI?=
 =?us-ascii?Q?HfXvx8hTN1p6iy62IPAfRjguo/okOWWBFUpbfnn5b5SRGU+ig8FftLg/UpJW?=
 =?us-ascii?Q?HQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: boatrocker.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: dc050d30-e1df-416c-f914-08daffb268d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2023 15:31:35.3821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fd92a966-cd05-4664-965e-b69e7529781a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JO3MNtoX7s+hUPRKyUYnalCUG/NdgZv+mVpa/2bkitwXA/X4eZ9Nyxfh18smCcXFCOStTSCWwlH2+h6nUfKkS6i7efjQQFyBJLKo0LbAuSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB6495
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> From: Andrew Klaassen <andrew.klaassen@boatrocker.com>
> Sent: Monday, January 23, 2023 11:31 AM
>=20
> Hello,
>=20
> There's a specific NFSv4 mount on a specific machine which we'd like to
> timeout and return an error after a few seconds if the server goes away.
>=20
> I've confirmed the following on two different kernels, 4.18.0-
> 348.12.2.el8_5.x86_64 and 6.1.7-200.fc37.x86_64.
>=20
> I've been able to get both autofs and the mount command to cooperate, so
> that the mount attempt fails after an arbitrary number of seconds.  This
> mount command, for example, will fail after 6 seconds, as expected based =
on
> the timeo=3D20,retrans=3D2,retry=3D0 options:
>=20
> $ time sudo mount -t nfs4 -o
> rw,relatime,sync,vers=3D4.2,rsize=3D131072,wsize=3D131072,namlen=3D255,ac=
regmin
> =3D0,acregmax=3D0,acdirmin=3D0,acdirmax=3D0,soft,noac,proto=3Dtcp,timeo=
=3D20,retran
> s=3D2,retry=3D0,sec=3Dsys thor04:/mnt/thorfs04  /mnt/thor04
> mount.nfs4: Connection timed out
>=20
> real    0m6.084s
> user    0m0.007s
> sys     0m0.015s
>=20
> However, if the share is already mounted and the server goes away, the
> timeout is always 2 minutes plus the time I expect based on timeo and
> retrans.  In this case, 2 minutes and 6 seconds:
>=20
> $ time ls /mnt/thor04
> ls: cannot access '/mnt/thor04': Connection timed out
>=20
> real    2m6.025s
> user    0m0.003s
> sys     0m0.000s
>=20
> Watching the outgoing packets in the second case, the pattern is always t=
he
> same:
>  - 0.2 seconds between the first two, then doubling each time until the t=
wo
> minute mark is exceeded (so the last NFS packet, which is always the 11th
> packet, is sent around 1:45 after the first).
>  - Then some generic packets that start exactly-ish on the two minute mar=
k, 1
> second between the first two, then doubling each time.  (By this time the
> NFS command has given up.)
>=20
> 11:10:21.898305 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq
> 14452:14652, ack 18561, win 501, options [nop,nop,TS val 834889483 ecr
> 1589769203], length 200: NFS request xid 3614904256 196 getattr fh 0,2/53
> 11:10:22.105189 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq
> 14452:14652, ack 18561, win 501, options [nop,nop,TS val 834889690 ecr
> 1589769203], length 200: NFS request xid 3614904256 196 getattr fh 0,2/53
> 11:10:22.313290 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq
> 14452:14652, ack 18561, win 501, options [nop,nop,TS val 834889898 ecr
> 1589769203], length 200: NFS request xid 3614904256 196 getattr fh 0,2/53
> 11:10:22.721269 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq
> 14452:14652, ack 18561, win 501, options [nop,nop,TS val 834890306 ecr
> 1589769203], length 200: NFS request xid 3614904256 196 getattr fh 0,2/53
> 11:10:23.569192 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq
> 14452:14652, ack 18561, win 501, options [nop,nop,TS val 834891154 ecr
> 1589769203], length 200: NFS request xid 3614904256 196 getattr fh 0,2/53
> 11:10:25.233212 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq
> 14452:14652, ack 18561, win 501, options [nop,nop,TS val 834892818 ecr
> 1589769203], length 200: NFS request xid 3614904256 196 getattr fh 0,2/53
> 11:10:28.497282 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq
> 14452:14652, ack 18561, win 501, options [nop,nop,TS val 834896082 ecr
> 1589769203], length 200: NFS request xid 3614904256 196 getattr fh 0,2/53
> 11:10:35.025219 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq
> 14452:14652, ack 18561, win 501, options [nop,nop,TS val 834902610 ecr
> 1589769203], length 200: NFS request xid 3614904256 196 getattr fh 0,2/53
> 11:10:48.337201 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq
> 14452:14652, ack 18561, win 501, options [nop,nop,TS val 834915922 ecr
> 1589769203], length 200: NFS request xid 3614904256 196 getattr fh 0,2/53
> 11:11:14.449303 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq
> 14452:14652, ack 18561, win 501, options [nop,nop,TS val 834942034 ecr
> 1589769203], length 200: NFS request xid 3614904256 196 getattr fh 0,2/53
> 11:12:08.721251 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq
> 14452:14652, ack 18561, win 501, options [nop,nop,TS val 834996306 ecr
> 1589769203], length 200: NFS request xid 3614904256 196 getattr fh 0,2/53
> 11:12:22.545394 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags [S], seq 13752=
56951,
> win 64240, options [mss 1460,sackOK,TS val 835010130 ecr 0,nop,wscale 7],
> length 0
> 11:12:23.570199 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags [S], seq 13752=
56951,
> win 64240, options [mss 1460,sackOK,TS val 835011155 ecr 0,nop,wscale 7],
> length 0
> 11:12:25.617284 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags [S], seq 13752=
56951,
> win 64240, options [mss 1460,sackOK,TS val 835013202 ecr 0,nop,wscale 7],
> length 0
> 11:12:29.649219 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags [S], seq 13752=
56951,
> win 64240, options [mss 1460,sackOK,TS val 835017234 ecr 0,nop,wscale 7],
> length 0
> 11:12:37.905274 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags [S], seq 13752=
56951,
> win 64240, options [mss 1460,sackOK,TS val 835025490 ecr 0,nop,wscale 7],
> length 0
> 11:12:54.289212 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags [S], seq 13752=
56951,
> win 64240, options [mss 1460,sackOK,TS val 835041874 ecr 0,nop,wscale 7],
> length 0
> 11:13:26.545304 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags [S], seq 13752=
56951,
> win 64240, options [mss 1460,sackOK,TS val 835074130 ecr 0,nop,wscale 7],
> length 0
>=20
> I tried changing tcp_retries2 as suggested in another thread from this li=
st:
>=20
> # echo 3 > /proc/sys/net/ipv4/tcp_retries2
>=20
> ...but it made no difference on either kernel.  The 2 minute timeout also
> doesn't seem to match with what I'd calculate from the initial value of
> tcp_retries2, which should give a much higher timeout.
>=20
> The only clue I've been able to find is in the retry=3Dn entry in the NFS
> manpage:
>=20
> " For TCP the default is 3 minutes, but system TCP connection timeouts wi=
ll
> sometimes limit the timeout of each retransmission to around 2 minutes."
>=20
> What I'm not able to make sense of:
>  - The retry option says that it applies to mount operations, not read/wr=
ite
> operations.  However, in this case I'm seeing the 2 minute delay on
> read/write operations but *not* mount operations.
>  - A couple of hours of searching didn't lead me to any kernel settings t=
hat
> would result in a 2 minute timeout.
>=20
> Does anyone have any clues about a) what's happening and b) how to get
> our desired behaviour of being able to control both mount and read/write
> timeouts down to a few seconds?
>=20
> Thanks.

I thought that changing TCP_RTO_MAX in include/net/tcp.h from 120 to someth=
ing smaller and recompiling the kernel would change the 2 minute timeout, b=
ut it had no effect.  I'm going to keep poking through the kernel code to s=
ee if there's a knob I can turn to change the 2 minute timeout, so that I c=
an at least understand where it's coming from.

Any hints as to where I should be looking?

Andrew


