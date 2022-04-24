Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD2850D51E
	for <lists+linux-nfs@lfdr.de>; Sun, 24 Apr 2022 22:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239531AbiDXUmu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 24 Apr 2022 16:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239558AbiDXUme (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 24 Apr 2022 16:42:34 -0400
Received: from CAN01-QB1-obe.outbound.protection.outlook.com (mail-qb1can01on2063.outbound.protection.outlook.com [40.107.66.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE410156E2B
        for <linux-nfs@vger.kernel.org>; Sun, 24 Apr 2022 13:39:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9tGn0DPjiC8tBj36f+ISoLHsuFuMf6pFGeyojQOi8ksEn5UwhEUAPc1nqBZJUGnOM0bEjtkkAPGasXsb7omTRmdyQG/6vycihIuFLFdh0hKc/yAvU891HbtiL/I/sc7EV8FAkBhHOeLXaF3yTukYXUxa0BwTnoFBLGROoiZOBuN7dUgGPuVcWlxTB6qOc/mZTB42RLS9TIMhmGFREUszB9mnfHAuSabUiuKOjNTBR/U78X3uZLgNWn5+CHTFJNOb5xGAR2cPyn+Dat3/ZZMwDfo/BiAnjJ8jHOHyP7U9iL36NuXYGXPAVjUb76AvnJt8rFXP3O57y0W8tyILxANwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mncq5d1L1QwDAeH4/Sr0bzIH2bCeY2ZoU2BFpW8TPs=;
 b=XAt5UxBXusRZxj9dIsmMK64BabUNNSdp459eB7O9yuXoajsBqu+nIbFqIjZ80Sn/VgG51sAdvQ+YWirkIEqYHgDP8lfrPmx6imjo1gltuNxGilPDqOQsQRVYy0dviMf1aQTozW59/lT4OjvLHqS0DfuEqKyYwdFpGhDWbemDCYzR0dPN+fCRD3RJrkH+V8KbQMUMmNGEfkW6bjiYSJJkEz8khfiQgeNNcdmgc0VOIdYXVVdXv+YHxHFdSVSO97O92sDWmBA+eNeKuartuuknkNHFaRNSLJryAWfn1af+gxDYrjG9JDOsNZ+I/vxXGVnqYPjXXHYOc6rgBIUNoaHjug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uoguelph.ca; dmarc=pass action=none header.from=uoguelph.ca;
 dkim=pass header.d=uoguelph.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uoguelph.ca;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mncq5d1L1QwDAeH4/Sr0bzIH2bCeY2ZoU2BFpW8TPs=;
 b=OrNDg4fbithZ79zkrFqktFQJgELGH8FU4+zSwK1q/xJ6EKAshcrNPI3fXazmxou80U1WbzVsBf6QSP+1eQYQlVjYbiwcYyyJx8zKT1NcVReWQcvBlZ4MNyvpESKHXvSGLXNysWYxg1hCsQlf3CJ/S+dX4wXGJ8k5xWcSFssDBaF38Y58Haa7xUiCDbw3+N3OdqSlEdQFbYWYX2ycS0c+rUFbar7Oqb2u+tjF5gki3rrQ8cQ3LEywaQrt1BFCeI7VSZmzZ395L+T11a3H3DVQRB0ppTKtaWRXjt+2CZx5p7lYXZ4amJ2FSPz7AYUmsf76p/3cHVee8HHien4RUle58g==
Received: from YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:de::14)
 by YQBPR0101MB9888.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:7c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Sun, 24 Apr
 2022 20:39:25 +0000
Received: from YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fdb1:ada8:7af0:3003]) by YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fdb1:ada8:7af0:3003%6]) with mapi id 15.20.5186.021; Sun, 24 Apr 2022
 20:39:24 +0000
From:   Rick Macklem <rmacklem@uoguelph.ca>
To:     "J. Bruce Fields" <bfields@fieldses.org>
CC:     "crispyduck@outlook.at" <crispyduck@outlook.at>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Problems with NFS4.1 on ESXi
Thread-Topic: Problems with NFS4.1 on ESXi
Thread-Index: AQHYVOLTJWvLLebuJE+8fGO0gJ9faaz5zdx5gACo0QCAAAJi6IAAGkiAgAAlUYCAAE6KrIABBqgAgACBbBKAAqD3gIAAWlqFgAABfw8=
Date:   Sun, 24 Apr 2022 20:39:24 +0000
Message-ID: <YT2PR01MB97305156E841831C4093CEF4DDF99@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
References: <AM9P191MB1665484E1EFD2088D22C2E2F8EF59@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <AM9P191MB16655E3D5F3611D1B40457F08EF49@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <4D814D23-58D6-4EF0-A689-D6DD44CB2D56@oracle.com>
 <AM9P191MB16651F3A158CAED8F358602A8EF49@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <20220421164049.GB18620@fieldses.org> <20220421185423.GD18620@fieldses.org>
 <YT2PR01MB973028EFA90F153C446798C1DDF49@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
 <20220422151534.GA29913@fieldses.org>
 <YT2PR01MB9730B98D68585B3B1036F6EEDDF79@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
 <20220424150725.GA31051@fieldses.org>
 <YT2PR01MB9730508253381560F79E96C1DDF99@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <YT2PR01MB9730508253381560F79E96C1DDF99@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 09ace6e1-735d-61fc-4a6b-82f2c8bb423d
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uoguelph.ca;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96b00c4d-5593-4eef-c1a1-08da26328512
x-ms-traffictypediagnostic: YQBPR0101MB9888:EE_
x-microsoft-antispam-prvs: <YQBPR0101MB98884BFA865DB5C1AF6B015ADDF99@YQBPR0101MB9888.CANPRD01.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: otNJE3fIAKen1LARtj3Dhhax9+tSJ0fMjJyK16+WczQ5G4kaSONE7qm/RCx4HlT8MVwfT0Yzr7iLFuzyFWPEna6hmqIkQEYy8x/uTmUQm1GI7UT8PnhoY9C2mP2GoKZyuxU8gygtWDP5ZxwZrJ9XCyr+UhpfuzZkmM5WG0v4scXPsUve07HLiVYgCVDRBILYPc60SZtgfOjGu11i2tO8Ra4QBvXaOlB6rknHw2uiMYef1mELVFE1QP73s7psQIMihUc4AJCM/wAfCLRGBsZexYEXZU7qW7kNuz444/HWttDnEXKpV1pK4WyLGVX0Ar4YJGZKfwkfNJAOKX2ZZcK18z5reqfw3+uQwgCGYjF69fRTdXz5FNgqiKorDS/HbAKSGfPqnzc4RwFkcs1hQu/1V9FLrC8Pl5WobRAG/8A1Ec+iqlIHx8knDi4yp0p2TuanO6G3cx5ipY2lJaTP3lwmh3Bfioh8LGlLKfYJBs+H+W+7I/2eB2QvL7EDRKUr7bSzrxyXg0764X+ooABddpTHBb7f0iPDzERq0QXVltjH8tGCYJrYCal3KgqIF1xzbF0aFw+4FtRyOgrGID/i08OH0rihcVRwHteNwKTEZRxbxm7OeBV23UHdhBVCiofQt74ZUnpyAxLXooNDriTTg7M3Y3+Q7UJhIdkKNhPBnseBhmC4yAnqJZdyCxkHB8SQ6CAhEu4HJo2JIe3FIgewf4B9jQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(2940100002)(9686003)(38070700005)(6916009)(38100700002)(7696005)(33656002)(786003)(316002)(6506007)(71200400001)(4744005)(55016003)(86362001)(5660300002)(186003)(122000001)(91956017)(508600001)(8936002)(54906003)(66946007)(52536014)(8676002)(64756008)(66446008)(4326008)(76116006)(66556008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?emUxIeWlY6TZvGfACaS2dyIuQOOYxD397UER1mX7ortXTtG5fBM9vaMioN?=
 =?iso-8859-1?Q?/DQm13P49cWaAikNc9x1ha941Km8FddFil8EH+25BAAn7wVxxZulMALp5Q?=
 =?iso-8859-1?Q?APMZnxyxsUPAQIUSi2lUBNbjpC31+iLB7BQhdiPDwfUSgXTzwMxEDch+zy?=
 =?iso-8859-1?Q?z8Vueqgsua2QUCxeQC1m+eCbw9X9yq1qVSuQg7Pfj1uwOzeHobaBOyBXpn?=
 =?iso-8859-1?Q?5Mh7ql/Q277O8/ByipUV4M7Q9LIfiVqd8rnEj6vvIopXCrlxDCqngx3Dhs?=
 =?iso-8859-1?Q?buViSaoRXOiPs6xHJ+gb2nguQZj+Th8WUiTMn2QHDdXWSMWM+WoiOrTpds?=
 =?iso-8859-1?Q?TVd2Y3v1hcyQpC+Yd7HexEvsu62KcD0KljQR35Q5yyQ2Djs9GazEilUdYS?=
 =?iso-8859-1?Q?LJEiCr3JMRvEDa0aNmiMcKRSZGZ18EkJlwTTLeIAA3pHf3orYH85EKjOSL?=
 =?iso-8859-1?Q?eWcEkj4nxGGm6zIrXF7XqKphyQX92udfpLkkyLbZVfXTSz3/4kZ2KKwVMS?=
 =?iso-8859-1?Q?Tp8tivboehiqVlS8BbyN2hFN135IoBzhteQNplClyqahPzBfh9Bow7STMN?=
 =?iso-8859-1?Q?rxLifRP9oNUBBJIzTzLay5TrhynuOCMvMrp7qfg/LStW/KFH6Y3+X135F/?=
 =?iso-8859-1?Q?xY+6hmLMmypl/OUiHpunkYWAeSMwq69V+JYWFiVokYhP4bliApPS12Hjbp?=
 =?iso-8859-1?Q?MX1PzGHxtHprjqF1oa9c4/4PMKtKXyLgtYAxF+vUlv2fgwfh+9A35v50hF?=
 =?iso-8859-1?Q?QonbiSj8LxmT35PbJ9g0+TjQWwEkNr62115m8z5S5GcJmdf/ZJ4xPd0thg?=
 =?iso-8859-1?Q?XbI1twzerReVpKeNkWJzicQ/tLMbKQKp0uJETyH30n7TEqq1l92tGLmu3G?=
 =?iso-8859-1?Q?dYFagBLauH2OVsQSY+PHNITiiWiMlWQJAGN5eMsDzoO2Yb8TquQ4Hd6k7w?=
 =?iso-8859-1?Q?RLcNDSDvSzFhGxxXzO0b0CRRoXT7pC6qGf4/+oB3Lf18tlK6K+Puc9Abff?=
 =?iso-8859-1?Q?nopbznJi+CikoWXR816ekEw3ZHAoIJd1DYHC0rGIKR071g2cmJGl5Hfkdp?=
 =?iso-8859-1?Q?A/x16aQjbWbYz7LPkpCb4/zfolanGOgClmf39iPMgAvTXYtGgNDYQvVVqM?=
 =?iso-8859-1?Q?om5VSRFuTk9/weNC2Ux3pSmXE7PvwVce2uuN/+UZ/rkMnCkhzJe9lUi9kl?=
 =?iso-8859-1?Q?ky1wEQhlfdsMwM7KG+WebRZIUQq/3FFYb1R1jcKdtZusw65FsqmVocM685?=
 =?iso-8859-1?Q?M/x8kZPapOkfPrVQSwhB94QEz7JWLVRS8+kG+d1sm7rsjYqAfN8ToOhzRa?=
 =?iso-8859-1?Q?frtqf4YJgUbYals/K7RI5v3cn6iSWyQcNuljbHspwtMv/JrMplOV+d8T5s?=
 =?iso-8859-1?Q?tFM8yAhSB+GFqGQmBG7LK5s2N7V1xhzN9z+vfmUTUgu3wmSdegs6Ka0J4g?=
 =?iso-8859-1?Q?KCN20djQKmUV7ofwU0VvFWG0WWgbnNn6yrMHdR/tmXmJcc/h3nLdza1t/h?=
 =?iso-8859-1?Q?SoHFEyz7VZrDtgdiL8IZI27fHlT6RuYwPb4RNFg4vzibZQP0jxq6bZzS1S?=
 =?iso-8859-1?Q?0xhug6PLkjp1vS3FoR8obAy9nIUYRoEqk8AKeNdX3zqgYALnpElAHw6PtQ?=
 =?iso-8859-1?Q?X25bfPfG5H4EE+OETEJ29C+gsghYw/6H3negdJ7L6+x+Xc5HcAgf9wMo5V?=
 =?iso-8859-1?Q?jSCDShcWm7/jFSIAkf4xe4gCrTQAydsddPduzKnAaoOgQQOcurrlCQdPAT?=
 =?iso-8859-1?Q?tm2I8hIV78JYe1fByGnPKa9ABwAydl5ZwLLcLdDdg9gvga76o5i2fcNC+K?=
 =?iso-8859-1?Q?sK2J8t8NJBGaLgifAb7rOtS2rXwBnt6WaD8wwM9eR8NCjuEuVFgbrvt4S4?=
 =?iso-8859-1?Q?1Q?=
x-ms-exchange-antispam-messagedata-1: eNUXL/Z7HENWyQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: uoguelph.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b00c4d-5593-4eef-c1a1-08da26328512
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2022 20:39:24.8697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be62a12b-2cad-49a1-a5fa-85f4f3156a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D0jXj0DKBxjVlRv5xkGt11aGS4X3ogKLuPoVmICaacnZ/FgMLX/jlaALukwmLN155cwUv4O/RllApSPyXw8Iow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB9888
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Rick Macklem <rmacklem@uoguelph.ca> wrote:=0A=
[stuff snipped]=0A=
> In FreeBSD, it actually hangs onto the parent's FH (verbatim), but mostly=
=0A=
> so it can do Open/Claim_NULLs for it. There is nothing in FreeBSD that=0A=
> tries to subvert FH guessing.=0A=
Oops, this is client side, not server side. (I forgot which hat I was weari=
ng;-)=0A=
The FreeBSD server does not keep track of parents.=0A=
=0A=
rick=0A=
=0A=
--b.=0A=
=0A=
