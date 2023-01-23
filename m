Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77ED167820C
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jan 2023 17:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbjAWQoE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Jan 2023 11:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbjAWQnw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Jan 2023 11:43:52 -0500
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2111.outbound.protection.outlook.com [40.107.115.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7454F2D150
        for <linux-nfs@vger.kernel.org>; Mon, 23 Jan 2023 08:43:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+dsaCpk9fQRbVsIfFGi4oshcz7aKjd+8ZZxn/lonkfmNLT5aQMt9axYer1RUnPXfZ53TRzspJtY4t5w1Y+6Pey0oUqUKOK5aiasc1GVaQjQm1KMaP626nyuSCcehGXvxuFSwvMWPp7NhUgo2RknO+PlO4coZ16XNXWMlJuIdXLumTXYczV/wLRrazlX1ReQLGbBIgeCRh2cYLss8cXsnrCs28xswP5nkyzQpztknCx3AfOEr3nPoZSoOirfKBRxEeka/wpEvRY3o1sfpLHDBxKfZHPMA9WV/POzArawEDsdEXobDjqXRyKj80vTA1bfIA0oL6vtjN7QdOiWgxZQ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KeyR/XkzfyJpCSpqfnPJqt/AQmFbCzyGPLNsMWdlmA=;
 b=CtFk/FJtNatnK0BchEVpXIRxYof+llVzUiXKxM0u67Ku9q08c5QhJg2QGhqqqZjCLAEwL0QN2Y6rVIGlT603xwu/XMHqjPn/xLaqOF6b4OdD8XYBnK8yoVRNKxylsAN9I204IFseW84YCJHvoT0tZDjGU2m+ohRibdX82s7PvOEmvq4ZiRLQOT8JP2ARMx38qGBrFDOXSpNVOAi/4wp9eqfit2rWdAKjP6ZrXVa1HLUc8Daw/3upNs6sv2VVpgOG2y8E1WtxXfCF86p+d/G0arY6M/n0CZ2j41l84UI9WUKRWqmbt5nkos/Dju48781HNDPR2y9Utril74zio43FrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=boatrocker.com; dmarc=pass action=none
 header.from=boatrocker.com; dkim=pass header.d=boatrocker.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=boatrocker.onmicrosoft.com; s=selector2-boatrocker-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KeyR/XkzfyJpCSpqfnPJqt/AQmFbCzyGPLNsMWdlmA=;
 b=BzFOKk8HoB9rgd7vEskCGVKUbTjYNOjytXBQPLyAitrQqk14/n/XkBb4vKX3WXpzDH4dx3Riv9Zp/XVB7nYnFTc3ZLfUmDBcjPwgJv43RJFEjZlJm7P8zPFHorQzpeOolyc36zj9vR6A+O//+9gBNBZ8Idr600wtWu5mD9lE3Ts=
Received: from YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:69::7)
 by YT3PR01MB8995.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 16:41:59 +0000
Received: from YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::7303:f215:657e:1643]) by YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::7303:f215:657e:1643%4]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 16:41:59 +0000
From:   Andrew Klaassen <andrew.klaassen@boatrocker.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: RE: Trying to reduce NFSv4 timeouts to a few seconds on an
 established connection
Thread-Topic: Trying to reduce NFSv4 timeouts to a few seconds on an
 established connection
Thread-Index: AdkvR33g3mzLGSb7R/abGwkCKolj9QAASdUAAAAt2kA=
Date:   Mon, 23 Jan 2023 16:41:59 +0000
Message-ID: <YQBPR01MB107243E2377AA2B52379225D486C89@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
References: <YQBPR01MB10724B629B69F7969AC6BDF9586C89@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <A00E49F5-9BD7-498F-95A9-FA2D5572694F@oracle.com>
In-Reply-To: <A00E49F5-9BD7-498F-95A9-FA2D5572694F@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=boatrocker.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YQBPR01MB10724:EE_|YT3PR01MB8995:EE_
x-ms-office365-filtering-correlation-id: dac1f456-d3d9-41f2-cd8e-08dafd60bf42
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(39850400004)(136003)(376002)(396003)(451199015)(86362001)(38070700005)(2906002)(38100700002)(52536014)(4326008)(41300700001)(44832011)(5660300002)(8936002)(83380400001)(122000001)(33656002)(478600001)(71200400001)(7696005)(8676002)(9686003)(6916009)(53546011)(6506007)(55236004)(26005)(55016003)(186003)(66946007)(76116006)(66556008)(66476007)(64756008)(66446008)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5FKbCBb+UWBVXjHqpNmsbE6ztX3uQwmpph7X+CSURtJg6qMAFOrSmPaVV3vpeYr6OpTIUlLrdYfrNNulNYv/3BIV021XF31DzD7neGE/BXv48DOhbT8tbncSts8djfWQV1Q0d9b5uB1FrEeDJRVAre5JHihEXe6tyOCLmBsaGYaaGyBIhBhpqUrPuJ7kVEUf7BuGtgw9UGyEHa1uMP8Hvpi2al6J6rCtKhf7IeJ1rgi4PNYnSn5G8/MfQaQbFP2PUcQ6EM7d40fZE0hUHoSUlC/7Aya4CqzEfIipPI/pSonuuJQDJFCCF7Rh1EJqSsRNqC4IHx1cJTH/8umtUkdAlbXZzpryJVeNil9kkODQkHelVVPA8htEWt4zMvLHxY/z56wPJevvlanJV/VXmDcJuvoVaIgv2ERIahKu7B4ac5KG1OqBDGWqU4gTpCzEoGhJyXOfbBYBhXEt7U2kQGEnMzulNV+3V2HyviqjxGZ8ORb01MgNay6BYbzYSDKrc1FTRWBnScWOfMfS8A14VWzzsMYK4O9QUXGzvYLpbwqLtFcXSDSYCl1W4gNxxW69MfhNderg65gXK84cK4+7EQ8P+ZzDOapMhcpgBKMDsr5TMBeJrvcrsjd6p31sqhcvExDKjw+b2lZP3NrUgg7SPXdY+bcShrrs+Jeu7pkS9X/8LrOZhPLMyS38sDOSJISRhObStBKGQU2pjxXHnTrF7dcmLQ==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qyP+r90URptXtxiH7SYIrFfKlSv8SQPa+XqiQ5gYtZcuVCowqQXeQshH8+dX?=
 =?us-ascii?Q?K/0EF0f9WvtiYGkmFiB953uH3XIkd132ishSMPXhPCsk10EOxAGvMk0YrNCN?=
 =?us-ascii?Q?mG17Zw0I85aY0py2Xld20sXgDxesT7V1kypuQDOYmJYNKcjA0N9olziByD0T?=
 =?us-ascii?Q?vCee1Jhh4P61swVjt7YR7mN4zpEUiMZc+rrRHDjK6ZRncJ8n2wvaaAW7G6dx?=
 =?us-ascii?Q?pV4q4pce/C7sN4BSbuwvrGZV20bngsCZUKQKaMIK9eFwY2Vdw7+ygS83T3ti?=
 =?us-ascii?Q?cK1/jHmH1HT3fDcp3dmXeZN+6EfBd50lgPhtlwXG6wbtp+dLilCuHUKkVH+V?=
 =?us-ascii?Q?N+KVNTLepV623jgyoDCnO+xt5kKV8ZvSui9LOkqkUT98mX/8DKI1lis+S1u+?=
 =?us-ascii?Q?IA8wqKc4n1tSfRKEgx/X87WoU+yHmmHa3IukXUsI5vrIuAdUfyGObcTXObYg?=
 =?us-ascii?Q?LnEy3Y/PGBIWE8U609rabF3knF8/T9tXJenfQRZt05oSk/8Lsuks519w9vtF?=
 =?us-ascii?Q?Anz2GQhtxPGzA2UdGgWgl09cvjqfidn+jViNGHZj+ndkuek/HvY2a5tI1PC3?=
 =?us-ascii?Q?JUryf/GrtPkUqO4VXNbHSAtTnhC0tBS0XvmjJb0VfWGLrrUjkWM57zxUi+14?=
 =?us-ascii?Q?hgf0+pqjZZ5qJOzYGEOIv5JlHda9KOFfeLgG+hMM54QHDKkkwxka2agPPtIv?=
 =?us-ascii?Q?kMUwFpMQbPU6DECWLMkAGtbqiAX+qclgAwvXieLgTFX/t73VOlQQD6nkzI64?=
 =?us-ascii?Q?WN6JKExa3rx5qsy2CE7Q5jbxMBz+KS0VRKimzg1once+73rDtV6McuNegJTR?=
 =?us-ascii?Q?AZTpJy94MGWHFICa7P4hwP2douKQRI8oiT4nGMVHlZ5N+husgTz4neWQ4EIS?=
 =?us-ascii?Q?JFCF5hRKbAgFGfU8EZljOYQQMuqrxZWG7cFFOSdFhLQFAF0HjHPfxcNYs5Iw?=
 =?us-ascii?Q?DrsDFjStsxuVYOFn8noLtZzZVJn5LGu7uGGaRjz8Kna/BeTJ08esbjUlJKlR?=
 =?us-ascii?Q?JXwAFqYzZtofQE26U64T5fKDlL323tL+ELk8avhkYSsZPWdIoR4dZOcHF5CG?=
 =?us-ascii?Q?VuwshQrAyfEReXpU0xeyZl1t9jmKsw2thafFjUf4g3sNYg/ZCjHCxAErM1XP?=
 =?us-ascii?Q?/44K0Wl8M/rg6Egbq5RP800EnXnLUFC8C7TYY/ww+8MtDMydAf6c1r4vEBft?=
 =?us-ascii?Q?TUYXivrsx0Hkjl3KgSm3+YNJLTT6yqq6+nEBQFZkHNCKS3n+dmj6yNED2krb?=
 =?us-ascii?Q?I9Hhh2FwgaQgXgtNjl6hRok/VH8DvmhNBbUQAyWRzcdl5QUCSgD5MKLM0mVE?=
 =?us-ascii?Q?u5d4NZcL9eoTTrZYzLESG+YR3bt3xxR/kXG5jm0FJUMTF5MDHbd+rIe+NJ4S?=
 =?us-ascii?Q?r22ynjk5aHIpJmVrpvy/ZSLg5snVK8AZSwYdM35mKSkAnSXloA/8610OfQP1?=
 =?us-ascii?Q?joeKppfP/MFdnaykOfeOaYybU+qNG0EbWriGjzQWDyGVbiEVBStzEWyrBWZ3?=
 =?us-ascii?Q?MRPjrQltYy6Cy7VMUpKiPmI6jyOxKEwruA7tWTWJHxZaayy3LcX8uLYQh3j/?=
 =?us-ascii?Q?vCEo65UJY/GlbqEi8beMcR7ArT1rQf3BGE5YmIfYOyoqAzPf+3ggwqjbwvfn?=
 =?us-ascii?Q?yA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: boatrocker.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: dac1f456-d3d9-41f2-cd8e-08dafd60bf42
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2023 16:41:59.3235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fd92a966-cd05-4664-965e-b69e7529781a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mLN/wYKL7kYCa3+x5Gmfn609/CHftEkIyWms5IPmla4dOfh2KpBeUkFv8c34qemRaU4G7japEg4NieukJuXrDl4AHFl5du3OO2PQh/Y9xIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB8995
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> From: Chuck Lever III <chuck.lever@oracle.com>
> Sent: Monday, January 23, 2023 11:35 AM
>=20
> > On Jan 23, 2023, at 11:31 AM, Andrew Klaassen
> <andrew.klaassen@boatrocker.com> wrote:
> >
> > Hello,
> >
> > There's a specific NFSv4 mount on a specific machine which we'd like to
> timeout and return an error after a few seconds if the server goes away.
> >
> > I've confirmed the following on two different kernels, 4.18.0-
> 348.12.2.el8_5.x86_64 and 6.1.7-200.fc37.x86_64.
> >
> > I've been able to get both autofs and the mount command to cooperate,
> so that the mount attempt fails after an arbitrary number of seconds.  Th=
is
> mount command, for example, will fail after 6 seconds, as expected based =
on
> the timeo=3D20,retrans=3D2,retry=3D0 options:
> >
> > $ time sudo mount -t nfs4 -o
> > rw,relatime,sync,vers=3D4.2,rsize=3D131072,wsize=3D131072,namlen=3D255,=
acregmi
> >
> n=3D0,acregmax=3D0,acdirmin=3D0,acdirmax=3D0,soft,noac,proto=3Dtcp,timeo=
=3D20,retr
> > ans=3D2,retry=3D0,sec=3Dsys thor04:/mnt/thorfs04  /mnt/thor04
> > mount.nfs4: Connection timed out
> >
> > real    0m6.084s
> > user    0m0.007s
> > sys     0m0.015s
> >
> > However, if the share is already mounted and the server goes away, the
> timeout is always 2 minutes plus the time I expect based on timeo and
> retrans.  In this case, 2 minutes and 6 seconds:
> >
> > $ time ls /mnt/thor04
> > ls: cannot access '/mnt/thor04': Connection timed out
> >
> > real    2m6.025s
> > user    0m0.003s
> > sys     0m0.000s
> >
> > Watching the outgoing packets in the second case, the pattern is always
> the same:
> > - 0.2 seconds between the first two, then doubling each time until the =
two
> minute mark is exceeded (so the last NFS packet, which is always the 11th
> packet, is sent around 1:45 after the first).
> > - Then some generic packets that start exactly-ish on the two minute
> > mark, 1 second between the first two, then doubling each time.  (By
> > this time the NFS command has given up.)
> >
> > 11:10:21.898305 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq
> > 14452:14652, ack 18561, win 501, options [nop,nop,TS val 834889483 ecr
> > 1589769203], length 200: NFS request xid 3614904256 196 getattr fh
> > 0,2/53
> > 11:10:22.105189 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq
> > 14452:14652, ack 18561, win 501, options [nop,nop,TS val 834889690 ecr
> > 1589769203], length 200: NFS request xid 3614904256 196 getattr fh
> > 0,2/53
> > 11:10:22.313290 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq
> > 14452:14652, ack 18561, win 501, options [nop,nop,TS val 834889898 ecr
> > 1589769203], length 200: NFS request xid 3614904256 196 getattr fh
> > 0,2/53
> > 11:10:22.721269 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq
> > 14452:14652, ack 18561, win 501, options [nop,nop,TS val 834890306 ecr
> > 1589769203], length 200: NFS request xid 3614904256 196 getattr fh
> > 0,2/53
> > 11:10:23.569192 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq
> > 14452:14652, ack 18561, win 501, options [nop,nop,TS val 834891154 ecr
> > 1589769203], length 200: NFS request xid 3614904256 196 getattr fh
> > 0,2/53
> > 11:10:25.233212 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq
> > 14452:14652, ack 18561, win 501, options [nop,nop,TS val 834892818 ecr
> > 1589769203], length 200: NFS request xid 3614904256 196 getattr fh
> > 0,2/53
> > 11:10:28.497282 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq
> > 14452:14652, ack 18561, win 501, options [nop,nop,TS val 834896082 ecr
> > 1589769203], length 200: NFS request xid 3614904256 196 getattr fh
> > 0,2/53
> > 11:10:35.025219 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq
> > 14452:14652, ack 18561, win 501, options [nop,nop,TS val 834902610 ecr
> > 1589769203], length 200: NFS request xid 3614904256 196 getattr fh
> > 0,2/53
> > 11:10:48.337201 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq
> > 14452:14652, ack 18561, win 501, options [nop,nop,TS val 834915922 ecr
> > 1589769203], length 200: NFS request xid 3614904256 196 getattr fh
> > 0,2/53
> > 11:11:14.449303 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq
> > 14452:14652, ack 18561, win 501, options [nop,nop,TS val 834942034 ecr
> > 1589769203], length 200: NFS request xid 3614904256 196 getattr fh
> > 0,2/53
> > 11:12:08.721251 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.], seq
> > 14452:14652, ack 18561, win 501, options [nop,nop,TS val 834996306 ecr
> > 1589769203], length 200: NFS request xid 3614904256 196 getattr fh
> > 0,2/53
> > 11:12:22.545394 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags [S], seq
> > 1375256951, win 64240, options [mss 1460,sackOK,TS val 835010130 ecr
> > 0,nop,wscale 7], length 0
> > 11:12:23.570199 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags [S], seq
> > 1375256951, win 64240, options [mss 1460,sackOK,TS val 835011155 ecr
> > 0,nop,wscale 7], length 0
> > 11:12:25.617284 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags [S], seq
> > 1375256951, win 64240, options [mss 1460,sackOK,TS val 835013202 ecr
> > 0,nop,wscale 7], length 0
> > 11:12:29.649219 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags [S], seq
> > 1375256951, win 64240, options [mss 1460,sackOK,TS val 835017234 ecr
> > 0,nop,wscale 7], length 0
> > 11:12:37.905274 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags [S], seq
> > 1375256951, win 64240, options [mss 1460,sackOK,TS val 835025490 ecr
> > 0,nop,wscale 7], length 0
> > 11:12:54.289212 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags [S], seq
> > 1375256951, win 64240, options [mss 1460,sackOK,TS val 835041874 ecr
> > 0,nop,wscale 7], length 0
> > 11:13:26.545304 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags [S], seq
> > 1375256951, win 64240, options [mss 1460,sackOK,TS val 835074130 ecr
> > 0,nop,wscale 7], length 0
> >
> > I tried changing tcp_retries2 as suggested in another thread from this =
list:
> >
> > # echo 3 > /proc/sys/net/ipv4/tcp_retries2
> >
> > ...but it made no difference on either kernel.  The 2 minute timeout al=
so
> doesn't seem to match with what I'd calculate from the initial value of
> tcp_retries2, which should give a much higher timeout.
> >
> > The only clue I've been able to find is in the retry=3Dn entry in the N=
FS
> manpage:
> >
> > " For TCP the default is 3 minutes, but system TCP connection timeouts =
will
> sometimes limit the timeout of each retransmission to around 2 minutes."
> >
> > What I'm not able to make sense of:
> > - The retry option says that it applies to mount operations, not read/w=
rite
> operations.  However, in this case I'm seeing the 2 minute delay on
> read/write operations but *not* mount operations.
> > - A couple of hours of searching didn't lead me to any kernel settings =
that
> would result in a 2 minute timeout.
> >
> > Does anyone have any clues about a) what's happening and b) how to get
> our desired behaviour of being able to control both mount and read/write
> timeouts down to a few seconds?
>=20
> If the server is already mounted on that client at another mount point, t=
hen
> the client will share the transport amongst mounts of the same server.
>=20
> The first mount's options take precedent, and subsequent mounts re-use
> that mount's transport and the mount options that control it.

That's good to know, Chuck, thanks.

In this case, though, I'm seeing the behaviour with only this single NFS mo=
unt on my test client.

Andrew


