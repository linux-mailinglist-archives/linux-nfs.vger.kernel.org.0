Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9C756D1C1
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Jul 2022 00:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiGJWLN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 10 Jul 2022 18:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiGJWLJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 10 Jul 2022 18:11:09 -0400
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2085.outbound.protection.outlook.com [40.107.115.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BD615827
        for <linux-nfs@vger.kernel.org>; Sun, 10 Jul 2022 15:10:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9NtCFzLL52SqK8p3s1NQ/y+VlohlE0ydEp/BWVk6frl+EpMsi+P83mBkia18XGXOYE1Cc/XrV8lzLLsCJcPo2XVIckKmy1efgKpyxIqbhP0OC2xuQx3B2RHYZ7+J1ig0h5l9Ows+2zgt2CT+Tl59lbuXlF8mq9PHnpSPZu0bEnb82n8qzEr5ynu249rhL00iBdevISxSgQ4EECSp+OkDpIpKfDzBf7GbPoA1OOwJSzBPBAcSWY3J7ypDZeHJckaO8OCfKJoFqCL3qYvzCuQF4dJfVLWezl0/aDpO21fzz4T+A3dF5o4XkFXhdHs/ElSpGhUwWWpW1zLEJDy8mHpsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7jrjJOPfmSyEXvFysTC1OS9TwekL63GDGxVSUaUC80=;
 b=a75wMD/0RnZYT2S7wOs2jrAYTTB2JFHs/1+wx62erxtpvBELSF0hHy5GN1mZLuG0R0yyf1Pc9LD7t3O0f0Ss70KLXUWDSBcW+4Ti7NWnaB4kQn3ENAXgoYkuFQPkZJiLLWhRhRq9z3TEf2X7/lKgrJ3Rth4sWzRpOu38rJPf3LBQqz+vcSj3hhhU0bWRAD3CopoCKlcGe0V7+saBnH6y6LQXjHP1E678xHJi/L2nW7HGQDWOogbaJ7uiAepHgm6UKhQGgDLS7131jdFEKf09h3GMCDBQ+Db6mp/U8jdy2ofSFwu3mryI7m24ZWQoegVH1i77G+0+AxJB+W2fC8Hkzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uoguelph.ca; dmarc=pass action=none header.from=uoguelph.ca;
 dkim=pass header.d=uoguelph.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uoguelph.ca;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7jrjJOPfmSyEXvFysTC1OS9TwekL63GDGxVSUaUC80=;
 b=PCbTaaG4HmufEh7E/jGAH2lqvRFiZ7DQ55BJN1+C2KFlGqkF8MzuqJ50VIwBY41IE77fLwIpTPl2YlIF2bfCECtI8aDvg06Ic0qjjQd7rTRWHB/mpsuRqRclMp9icMuMy0XZPu4msCSZ4dLUnbfpZt2hJufwVnNU4dxCM6wMlfTnpW4Ou/gKp4QrR0jrCwsPkx3BFTH2/sHDE3bxk+5m45zeaEuutI09wO0lEI5iuyz9FAyuCiCQ7+HWgwGusnP9Lwtb1M77MB6bkjOIZG7PVxKQ3m+cTHX8PZSAAct/2lV36jt/c5w2v4MfW61/qOztX00vZ7wN/+FUsLc/cYTJRQ==
Received: from YQBPR0101MB9742.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:81::14) by YQXPR01MB2374.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:43::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Sun, 10 Jul
 2022 22:10:55 +0000
Received: from YQBPR0101MB9742.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c494:e35e:76d4:7d75]) by YQBPR0101MB9742.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c494:e35e:76d4:7d75%9]) with mapi id 15.20.5417.026; Sun, 10 Jul 2022
 22:10:54 +0000
From:   Rick Macklem <rmacklem@uoguelph.ca>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: NFSv4.1/4.2 server returns same sessionid after
 DestroySession/CreateSession
Thread-Topic: NFSv4.1/4.2 server returns same sessionid after
 DestroySession/CreateSession
Thread-Index: AQHYlKIG8hnDNDQzXUuZ/p7iJwgH2w==
Date:   Sun, 10 Jul 2022 22:10:54 +0000
Message-ID: <YQBPR0101MB97421B80206B30FC32170C25DD849@YQBPR0101MB9742.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 80f5c12b-6da5-37ec-29b9-e0ab7ce1f5a3
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uoguelph.ca;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe07ce5f-1d5f-4c0e-f6a4-08da62c10f35
x-ms-traffictypediagnostic: YQXPR01MB2374:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: seMy4eefDyX9PsvmLm363969nlgjYd2n/18sBRGtp9eIErbxbAEl5SFEMRxMTcF7qJ74fRV2DqdPzgERdz0mZEvPEzO6eRf+mpT1LLAwbf/yMg1NIe0WwYtaYoHC1GREC8X1u1zDhYH4Uti6sGabjvmSN4NMrFtvjhorPbJfeUexpVs3SPbAc/vbXxa5IqfZ8SjO3mXbD1BtRaYFWjmE2UJy7DWUmftLJVfGtvQPBAGKY8YEi8FqbliDX04mbPnTDQO1vHznLJ2XBzzAapku6El83Kn3mLhA5rHCyx/x5OS4D14qwebEhiPKfa/+sHQVjNt86lIiqzN80OGo3cfGQtRqWZQPtfuBIVgDrGIg1A/fois/Ns8hFcVAXDYHg9fVF5Ulv0qBCYOPEZN1ud9yLxtrZfVh8w18XpNcseBPsI7f3qeoWuUHclbP00jzeA1/IYpHZ4WpNbyG0GdQfCuZUZcUWC0N4s6bt+wVWPmaQMggyHog9qdm/zJSjH75IGbEABPG0P3n6UE2NbX/cuweBv7lEQsvyAHZDZcNutqcZLM7l1AeONsfTrWcQ+zJFJCzcsYexeX1bCbHobxl1C3fi42LMtk1c6HO0zsbIYHcKYMxArVyUuUQgyJbTA8ncCRI78viMkm+jh1TbQ+TQDLAqhTtJmHPFaCJhLXycoMM97ZYaBYeXzrJ0J9dzS03jr1RtqR3CtZHdJFUh/qL1ov/yrWnr7bgRu+F5lQe4D4KmhWr9T2dgQWQN1Iq69w8uU+OAKvlHyIg0o2EU4k9HOhidDFOrO7DMAsExsr/pxHEEAa6kaz9nlPp+SsW0G3hn5lbJFjgBWAoR+CRIwaxYImGVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB9742.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(478600001)(7696005)(6506007)(186003)(41300700001)(76116006)(966005)(122000001)(9686003)(38070700005)(83380400001)(38100700002)(55016003)(5660300002)(8936002)(41320700001)(33656002)(52536014)(2906002)(316002)(786003)(66476007)(66446008)(66946007)(6916009)(86362001)(71200400001)(91956017)(66556008)(8676002)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ttQCIuxU47B18l0aGRuP2WOjVdoo5pn3HdYziAFmKHYyQAmHE9PSpltCn8?=
 =?iso-8859-1?Q?NzvZ7rmQ/yNKnYnCarEyU5jomsrAIJ7THPTGdv2Y/AmJIS9mE2hjzA53sK?=
 =?iso-8859-1?Q?K0qMneJfOrL9siKtGnMrLqJQb4OjMtEXXIlYhvHlI7czCUkc5xiy8cXv3V?=
 =?iso-8859-1?Q?rldNpdObXSG1WAFTXAqHIbnpz57b2GLdjKFY0eBuIVipil1SjpV4NuKvuz?=
 =?iso-8859-1?Q?rF4IdUCvbB9CF9L9HS6y8qCLIirqf0Mv0ot7M8mq92DUaginAD0YddPdGi?=
 =?iso-8859-1?Q?TAuNXTgAnalMeJ2qftmdZb/R8uAMYlQbM4N9DqJNtanNFelLcT5twGy7YF?=
 =?iso-8859-1?Q?XvsgLsQmgOGRntk6p2FZkC7LNyZB+zYqmRMKcLvsKeKYUx/YYb/zE7eQG+?=
 =?iso-8859-1?Q?3wOIWPjcMGb4NxeyG3zGDmXz1mAZbiGUc/uMveWwkftweA5yE3fwHqY+YE?=
 =?iso-8859-1?Q?bzdJANScWqeTJebdLy5GsGWS3qtpRjI95K5kfzSHduxIXVXX7NFRcC1VBG?=
 =?iso-8859-1?Q?nQGZeCzlAE3NKRQpIrLccv/t/ditXpl6VmXZWZGOXYIMjDEoOcSEMJOZ2y?=
 =?iso-8859-1?Q?mUItXRL44YeC7AxpYW4tPGeTRK5gCValt7NKXNA2PJDYrlSWg3UmKnM/WC?=
 =?iso-8859-1?Q?lpnTFEuT5+fUcsbQXFqTkWTV1GtRJSVqhvhMlI85jaFNzL8a+eqULj0FLi?=
 =?iso-8859-1?Q?8RysomQmyS+gQPD4HuLRmot0ghGrIOSpB+m3vs1SAhigXdHVAA0wrIitH9?=
 =?iso-8859-1?Q?52uipyodXySRymElBzfZJ26vkM8lNXjt2m/QworLC/okc/e3n+Jea5zMxS?=
 =?iso-8859-1?Q?ZFuAxVZLI4CeqrKtpuoPNnGx7hpNHkeTZW6qdsts59VgEw0X6YmdyMEQr3?=
 =?iso-8859-1?Q?kXKgC5VEHhlTDAxXsKiLtfTX1QIx78WDuywyb47VVzFEEEWR88+Y+m2wXW?=
 =?iso-8859-1?Q?xdJf7vWdp52P7OB2dy7zahxtuEPgk7U/9u0Rg4Ewe7uD8o1x4OyJJsjwwR?=
 =?iso-8859-1?Q?96VTX3Dv6bL3OT8B15pgN0BpviAZOmlaTySp1we7DgEj9BKHCDa3QDZgkL?=
 =?iso-8859-1?Q?uvRdBsz+oRGEmeeQ/9IkPsOv0ZZ3e2QwsMaSQ2VfiuQd/2++QeBsVGyACu?=
 =?iso-8859-1?Q?Yoi265X1pBy3XpjwsKwHIJH/sL6rvPWDXNeu5qtS0kD9aRg9WR/VhXLvn9?=
 =?iso-8859-1?Q?dtlrfy+Q1IaMASJgc1pBijbxzZ3m3iBTJMTR/HIDFArEeDVPYegfXtXGKs?=
 =?iso-8859-1?Q?JyLNPOUMYDoJMJNlCEz+QyhiObZlCkfh/bCQXx6xetvKvEyljnxOW2AkQA?=
 =?iso-8859-1?Q?F6mhkUsRuXXw4GWZMDHwhjWu3mnWrKR8XouOAmBBZro0mCLnIVjXAjiSpe?=
 =?iso-8859-1?Q?RD/Ra6NQHvadCmxG6l3OvBlKZkSccOhFCnRn+RGdoBuryfoMvNi/RCnKGK?=
 =?iso-8859-1?Q?nBaf+ci+lO3KjdYcVp/eQrqPRV2XVfGzwiRh/ARK7oJsYRSnt1SGzKpvqf?=
 =?iso-8859-1?Q?GL6YSN79dciDql7oZ/1c0/Cruont3NN6TvSy7EoWOpr3kAwIC9zle8stJi?=
 =?iso-8859-1?Q?Y/pZP7o4dH5fOPhwp2MxUqn3QgKt4xAv14RvtzRVowJVjGQYjPWhfkOYEI?=
 =?iso-8859-1?Q?c0SFSWBlVycNpR1dCw5sAXCzhDskUjl7woUwS1/8SyiunNgBRMqBp5LnTJ?=
 =?iso-8859-1?Q?kJ/WXoWoJWGmf1ufdog=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: uoguelph.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB9742.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fe07ce5f-1d5f-4c0e-f6a4-08da62c10f35
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2022 22:10:54.9126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be62a12b-2cad-49a1-a5fa-85f4f3156a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 22xpF9DqEy5pc228D2RLG3NxDQJn/I3CNpljHmh45BRPisrEI8H5jwLsDe/KKnis4fwMg49w7+0UqyTupbm7Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB2374
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,=0A=
=0A=
I have been trying to improve the behaviour of the FreeBSD=0A=
NFSv4.1/4.2 client when using the "intr" mount option.=0A=
=0A=
I have come up with the following scheme:=0A=
- When RPCs are interrupted, mark the session slot as potentially bad.=0A=
- When all session slots are marked potentially bad, do a=0A=
  DestroySession (only op in RPC) to destroy the session.=0A=
- When the server replies NFS4ERR_BAD_SESSION,=0A=
   do a CreateSession (only op in RPC) to acquire a new session and=0A=
   continue on.=0A=
=0A=
When testing against a Linux 5.15 server, the CreateSession=0A=
succeeds, but returns the same sessionid as the old session.=0A=
Then all subsequent RPCs get the NFS4ERR_BAD_SESSION reply.=0A=
(The client repeatedly does CreateSession RPCs that reply NFS_OK,=0A=
 but always with the same sessionid as the destroyed one.)=0A=
=0A=
Here's what I see in the packet trace:=0A=
(everything works normally until all session slots are marked=0A=
 potentially bad at packet# 14216)=0A=
packet#    RPC=0A=
14216       DestroySession request for sessionid 2725cb62002ed418040...0=0A=
14302       DestroySession reply NFS_OK=0A=
14304       Getattr request (using above sessionid)=0A=
14305       Getattr reply NFS4ERR_BAD_SESSION=0A=
14306       CreateSession request=0A=
*** Now here is where I see a problem...=0A=
14307       CreateSession reply NFS_OK with sessionid =0A=
                 2725cb62002ed418040...0 (same as above)=0A=
14308       Getattr request (using above sessionid)=0A=
14309       Getattr reply NFS4ERR_BAD_SESSION=0A=
- and then this just repeats...=0A=
The whole packet trace can be found here, in case you are interested:=0A=
https://people.freebsd.org/~rmacklem/linux.pcap=0A=
=0A=
It seems to me that a successful CreateSession should always return=0A=
a new unique sessionid?=0A=
=0A=
rick=0A=
=0A=
