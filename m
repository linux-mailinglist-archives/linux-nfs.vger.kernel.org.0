Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27ED035D243
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Apr 2021 22:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbhDLU5f (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Apr 2021 16:57:35 -0400
Received: from mail-eopbgr670049.outbound.protection.outlook.com ([40.107.67.49]:3613
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237497AbhDLU5f (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 12 Apr 2021 16:57:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DlKbvDTNaioQ+ijNjSS/NDWG/2sTIs4DZwIe38IXoLcTyLGmwEhhp2MwkeDc57XIQRS9/0cpP6SFNTIuBJnGYPHIN0a/uKn3MKaxzgieDUGAI2pMOcM4GmZXIGN9JvZsOofG9Be5kWSBpi2Zc6pKy62F5oB5mbdmcCPyU7ZHYXKgCHjX4Dfi6K7RdmbpbmglzoXXhOMFIym0Jnqn0anm/NOM8eH5emcpYeNy64DZYtUOZKAmwbVowz2XK1ptiBFGcf0B4QwSTj276Fed3RdsIxMQmH57xBiwog4FtApVyAFS16ztXLTPTDI38Pr2BWMSWFFCd1TtVdEypso+Aap2ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNsqf3E8B1QhYlKa4k+rJ4Oifhv/q0ZAGC8/rztKCA0=;
 b=C+cN6xZlqwzpyLha9ma3zfN7Iv8VcXBS0z2rc+4DL7a5ghHKX0dCgCCX06z1CzUG+uL7H5ayPpufgBgzbWCK4Dne9kRfFba7pImFWKMsXJXHACQgH3Esy6Z8U0WLNfv/lJHNxXACDqeDrrTkhTMJRp6al2HUP3R5JpEW91HWz4NdsraVKQMdgoG5A+YrRA3N8jKr9eqPmGH5EFkpUxpm190mlJPPMREqZ+o4Z3ZxB4HogE5e6zHhxdamGMdRkLsJaG3PzTb0arjzikVlZ1KOxPm0YIkAUBwcqtZFF9pU38aptFgXCRvWAyzS73ZQ7nIbx57pZ3OGgYLhM4t6m4wcmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uoguelph.ca; dmarc=pass action=none header.from=uoguelph.ca;
 dkim=pass header.d=uoguelph.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uoguelph.ca;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNsqf3E8B1QhYlKa4k+rJ4Oifhv/q0ZAGC8/rztKCA0=;
 b=d9OWJiMsq9jChkkoLO9vDvio03sh0QFy2/Pn064J2ur4rnmJz3VT/DOeKE9aQ2iIt2616SnFsV6w5DOKDCTTtEQrh69MZRd+m3IAhpzCINenmJkM5igBxMHXhIVVly/XdOJlsE4jnIQQh9G5UaWgFvCQOXbzSBXs3SJtbvs3vg6GHHGCkw3TTVPHIs3cVwrAzwgjOUuavA4V3+h10C83JYai6KSuNXwtFIwb7qQxuDf0k9JJdEI+7P0WTLltvlj/6OxHPRTB8cD4TCOqFJ9JR1BD+8nbAraLdyRG7GFWj+TX/P4FiYYoMMlp2Kk8SCJXkglsd3UP+tE5nAFkHuGCIw==
Received: from YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:19::29) by YQXPR01MB3557.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:51::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Mon, 12 Apr
 2021 20:57:15 +0000
Received: from YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::1c05:585a:132a:f08e]) by YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::1c05:585a:132a:f08e%4]) with mapi id 15.20.3999.037; Mon, 12 Apr 2021
 20:57:15 +0000
From:   Rick Macklem <rmacklem@uoguelph.ca>
To:     Linux-NFS <linux-nfs@vger.kernel.org>
Subject: Linux NFSv4.1 client session seqid sometimes advances by 2
Thread-Topic: Linux NFSv4.1 client session seqid sometimes advances by 2
Thread-Index: AQHXL9rIYn3uMMvy90evx7HGhIWLsA==
Date:   Mon, 12 Apr 2021 20:57:15 +0000
Message-ID: <YQXPR0101MB0968E44CE6FB05F22DE27716DD709@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=uoguelph.ca;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a79401fa-f313-4d87-517a-08d8fdf58d49
x-ms-traffictypediagnostic: YQXPR01MB3557:
x-microsoft-antispam-prvs: <YQXPR01MB35576EC851DA444D1FD05C44DD709@YQXPR01MB3557.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hXsp7i3eWt3Q3BggyYpQYsysS1ogSWZp7Mzys94wC3t+x9bK6GKAWMYw+NMohAnNITc0pkl76Za4GwnM0M1CvX1/j7cUGKd2tTnsGOo47V/zfp0875QG8yeWtId445IhcwTfWmSeWSJgMd39eeDz/VzHcyNNf39zTgQoZpj9OSftIKaTjA2LP3Kix0XjjgRJojHgcRIy/3wFZ3O06d9Es3qKvQ/QuDa02cCK3re2DNThpGctZ+e1qxJNgTpp30HHw1Cv0BviMaspN/CdfLkqG9aDDY8y4KG84NDkWd4DhpiiAUDanp2qJ7Qmme7b5jGg+ZxYib1T2KyDiivbq2oUUkJaa/ZROUKdu3DDICuEVX+79asizSRHRt7Mm5G2kcU0+nf7L9Cp+JDUwiVKR9fGLFv0Y+YT1V2AQaDS7G08zx6y5nXGfBihcAAPAq2Is+5+RIfIt20UGr5e6+eP8nO9kgno8iZaQmHnKV70VPPkTB4lT59MrE9xrzx3VhGJpsYx2AptaeU7DSQ9JRDmdJqLxKGFbQG6guxnFYvasS71LNP8lgDGHCb13izpogiPalqB5VHQoEcECvX5RPjw8eJLw8tsTjJ8g4z1oRDgb4dImhasPBOEOTE62uIe7YdstazAXZCHnaghdLtcBLmSLIeNYjxg4Ytw7FVFi6k3siG6kdzFL3QNU+bgDEAntEvaMKU3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(366004)(39860400002)(346002)(86362001)(5660300002)(55016002)(71200400001)(478600001)(33656002)(6916009)(83380400001)(38100700002)(966005)(6506007)(8676002)(76116006)(91956017)(7696005)(316002)(52536014)(786003)(2906002)(9686003)(186003)(66446008)(66476007)(66946007)(64756008)(8936002)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?XFtaqI1tBQC+KQG2+nSjdonMtHGLifl2MwfPOVgomFCEOOn7tyfcNLU2XC?=
 =?iso-8859-1?Q?JneBEUI09nIPDvk+0fXnX+AoAndjt/XvGgAYFIlx7A3EP66p0w1sadlJ1G?=
 =?iso-8859-1?Q?6+sfDVOAHuo7APxGROdN2OOezVLu9r/T2tvCn+27MLD8rSfScNH/2ymDM/?=
 =?iso-8859-1?Q?3jUyfVF8M+f3Q033pWH67nIs82cVhXh/qLtKLtwdXmESMgZvnJRISztNpy?=
 =?iso-8859-1?Q?/LpphCMOVsx2sqY3u6V3EwTALANx6VDxO0DqGvUj1c/eaTc4ajYKtGgvCW?=
 =?iso-8859-1?Q?mGAXPgFhp16VVbd8p2l8yC1WH9Am1QCxd9dLYNafDEGCajqMBketMkaqBw?=
 =?iso-8859-1?Q?96DroBgTeB7B2XsltbPOdsA4QLHos2GqSowwpVpIDAVpRDwwraqh+lz4JE?=
 =?iso-8859-1?Q?Oqzk+pbnN4QD3mTo/L5lSdYLnDfEMOSRWgQLEXTiNPpnGf2/nYJQaOwt+c?=
 =?iso-8859-1?Q?0FH/2ymsiHPvmzBXZVroHJtWmQrMOmHQaC7X6hZGz5VzhsLcTHX2rN6CQp?=
 =?iso-8859-1?Q?YeO/rxABNajspukkplCLCfdV02rYF6IqRcfTadot1xS9gMzv/n8cMbedcT?=
 =?iso-8859-1?Q?63naNUrnfnHVJ5oMYU/h5YjkreMJEU1oBFSzyZ2FgWYGWxmZ9GCOuFXRRS?=
 =?iso-8859-1?Q?1H4+0Q3v82YCFCKtBxCvpwZEFNNfrSFsA9l5YE/n0HV1NLiZEj3b6G6J1w?=
 =?iso-8859-1?Q?sC36aPM4kFCa6sAc7KEU9e5Xfl0ZHuuAFwhpg0t69QvegJ3WXP1TnKLfRa?=
 =?iso-8859-1?Q?wPo8zHhee1DMBTSnHKig+cxP9BkazHZAXFiXa1rxY1LVuMG1xzd2EFf3+q?=
 =?iso-8859-1?Q?stWqfVqYs0s1vjyQI9ug615rQg5HWBFwBS9qEy3r80q4qjKx7qjhWq7+NL?=
 =?iso-8859-1?Q?bo7Hdjf0EpwrEBIPlEHxbE7xiI0LXSqoDarptqPZ97sG3csJVsJKcm5kfS?=
 =?iso-8859-1?Q?0ecKra41m6SdvhdAL+Aq0jJx3JX/b+RatBccOQd2JMaPDvXUNNRQhdPFc8?=
 =?iso-8859-1?Q?CwOsXny+xWLoxxWqg1w7r0ede9R81cNFd9yaG/d57LdTE4hAR8TO43EDBa?=
 =?iso-8859-1?Q?rFWUjq3vIefooM4R4ZLk5cCpy7PWyic7a77arKsF03jBo+qz3FA54FhCbe?=
 =?iso-8859-1?Q?8byFkCNCmmXEwloTVaFrImixMCD318YZ7L9Pw7Bx00fW5OLuFTb24mGSro?=
 =?iso-8859-1?Q?bAotAgGnSb1g1Lkjp6OvgOLqExuR+FMaV7L/tbiGvsVc6/MwEqu+qQqkks?=
 =?iso-8859-1?Q?DhHGtluTqwaLZBqqZnymhC+5A2FFMdExDG9MbIPboPtFyCTfbbzp9802+x?=
 =?iso-8859-1?Q?GE1nKLa2YJyNYiZGdp68Yq0dpHKliX46Ymulbu+QloHa6BszqrYlFafccN?=
 =?iso-8859-1?Q?g4ZcKOoUdCN9snkhi19SyaJVMcZxIinFC9h1Z+OF8voooTuBFOktg=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: uoguelph.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a79401fa-f313-4d87-517a-08d8fdf58d49
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2021 20:57:15.1422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be62a12b-2cad-49a1-a5fa-85f4f3156a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t5QEVBBVOpOCE1zoPpWgPRJnaSzmRE6kybw9DC2hYUWJZCYsT7BS3xz3sIdjH3S5iY/Ylu/ZIrQt24NCN03ytA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB3557
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,=0A=
=0A=
During testing of a Fedora Core 30 (5.2.10 kernel) against a FreeBSD=0A=
server (4.1 mount), I have been simulating a network partitioning=0A=
for a few minutes (until the TCP connection goes to SYN_SENT on=0A=
the Linux client).=0A=
=0A=
Sometimes, after the network partition heals, the FreeBSD server=0A=
replies NFS4ERR_SEQ_MISORDERED.=0A=
Looking at the packet trace, the seqid for the slot has advanced by=0A=
2 instead of 1. An RPC request for old-seqid + 1 never seems to get=0A=
sent.=0A=
--> Since sending an RPC with "seqid + 2" but never sending one=0A=
       that is "seqid + 1" for a slot seems harmless, I have added an optio=
nal=0A=
       hack (can be turned off), to allow this case instead of replying=0A=
       NFS4ERR_SEQ_MISORDERED for it. The code will still reply=0A=
       NFS4ERR_SEQ_MISORDERED if an RPC for the slot with=0A=
       "old seqid + 1" in it.=0A=
       --> Yes, doing this hack is a violation of RFC5661, but I've=0A=
             done it anyhow.=0A=
=0A=
If you are interested in a packet capture with this in it:=0A=
fetch https://people.freebsd.org/~rmacklem/linuxtofreenfs.pcap=0A=
- then look at packet #1945 and #2072=0A=
  --> You'll see that slot #1 seqid goes from 4 to 6. There is no=0A=
         slot#1 seqid 5 RPC sent on the wire.=0A=
         (This packet capture was taken on the Linux client using=0A=
          tcpdump.)=0A=
--> Btw, the "RST battle" you'll see in the above trace between=0A=
       #2005 and #2068 that goes on until the FreeBSD=0A=
       krpc/NFS times out the connection after 6min. seems to be a recent=
=0A=
       FreeBSD TCP bug.=0A=
       I have reproduced this seqid advances by 2 on an older system=0A=
       that does not "RST battle" and allows the reconnect right away,=0A=
       once the network partition is healed, so it does seem to be=0A=
       relevant to this bug.=0A=
=0A=
Someday, I will get around to upgrading to a more recent Linux=0A=
kernel and will test to see if I can still reproduce this bug.=0A=
On 5.2.10, it is intermittent and does not occur every time I=0A=
do the network partitioning test.=0A=
=0A=
Mostly just fyi, rick=0A=
