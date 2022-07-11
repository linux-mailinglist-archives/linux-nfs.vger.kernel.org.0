Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCE1570D0D
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Jul 2022 23:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiGKVzy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Jul 2022 17:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiGKVzx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Jul 2022 17:55:53 -0400
Received: from CAN01-QB1-obe.outbound.protection.outlook.com (mail-qb1can01on2047.outbound.protection.outlook.com [40.107.66.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1383A2AE03
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jul 2022 14:55:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYbyZbHo/4IbClOjRcYfSWiN8PPALMNAl5xvel3K2TOVlSVTCGvxg2DBckrWtbrMq1faV0I3Pu8SGvDBgg39Kslx9Stnv4CX5HuuSyWpC6w2KnxJLJL246h7bX6ms3Yn37wE3RyhgoQmx56/7Cce/K7JIwYAF9ZLs7a0fWf+vHaAwbIsiAH5iDnkPUuY6TBMWHqioA1I1nJAUly8H9EjMbmlpeE2emAN3tp57wHZX4gm4Sq0V6ILXs7ZRcV0nWpPkJPil79jcANk7yk5d+dTa9Pl3Mwn2SlFlYEtF0ToO1EwSeuhXbUIXlfMF3YJXsieDsIObfC5sIwmfNlLQKt/8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1X8r0LutTLh8/RGvO1exaLkbRrB6cJwQ1yz9C8mO9D0=;
 b=c9C/Gpm/Oowj+1xtk7jT5vNF7LHN4nsEhP1eBujAUA/lGGdhuqyzZqWsKhjQsgT5hOqqVWMDrjKGefPDfC4H51j8nRhn+ASoRm2034GA+429oZbWNxEKn9/1yBKuxD1a7lPUT/+u+Y9GBwHkJlLeJ4sNrqsf++2t537Rh3IzEWgflPU2yfNGjN5kimLGkBGb6tv7KrQJ2o1JMqk22MW7m7SeFucssmAV7VVGpNa3YE89bC7uP/w5sHtjBL+Joyf3/+LolIXvKN+8BRttkeEMoP80uSBI5IjUyawlgXuFcSC26805lH1RvLOklhluhL7E9i1l76oOpKAKxkeXSmQKYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uoguelph.ca; dmarc=pass action=none header.from=uoguelph.ca;
 dkim=pass header.d=uoguelph.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uoguelph.ca;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1X8r0LutTLh8/RGvO1exaLkbRrB6cJwQ1yz9C8mO9D0=;
 b=V8ouYGly/CX9uqufP+0xt4FkAjSyHWO8CkTi+7528txM98LTPzxvjFP78cL7005cCibFFHt+/X9USljl7deQtc4OWofbbgzZBp1tvNEiSx9ylN9pPrA3seHD3K+KGm3myxbq3EwoNLFS92t6NSjd9MnSn93kgqaf9/hwiN+6e925DVUFXePXc3Paf92zIRXCdJFADHB77XoBaxty0y7KldQANul0ZVX8b4wOT3f83eYhI2T83O4WlLV8/Cxzzbqwb2X8aVxtDO92FIShcD+4zhGxI7e8ZTomtwwjy7d4wc5yMpGanohPrk7xAdL1BArbVneyAgLr3h1TBkjCmFsXuQ==
Received: from YQBPR0101MB9742.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:81::14) by YT1PR01MB4155.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Mon, 11 Jul
 2022 21:55:44 +0000
Received: from YQBPR0101MB9742.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c494:e35e:76d4:7d75]) by YQBPR0101MB9742.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c494:e35e:76d4:7d75%9]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 21:55:44 +0000
From:   Rick Macklem <rmacklem@uoguelph.ca>
To:     Tom Talpey <tom@talpey.com>,
        Chuck Lever III <chuck.lever@oracle.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFSv4.1/4.2 server returns same sessionid after
 DestroySession/CreateSession
Thread-Topic: NFSv4.1/4.2 server returns same sessionid after
 DestroySession/CreateSession
Thread-Index: AQHYlKIG8hnDNDQzXUuZ/p7iJwgH2615RPsAgAAqTQCAAAlZgIAAKIvmgAAL34CAAAlvaQ==
Date:   Mon, 11 Jul 2022 21:55:44 +0000
Message-ID: <YQBPR0101MB9742511B0AC1BC1CFD9A0E84DD879@YQBPR0101MB9742.CANPRD01.PROD.OUTLOOK.COM>
References: <YQBPR0101MB97421B80206B30FC32170C25DD849@YQBPR0101MB9742.CANPRD01.PROD.OUTLOOK.COM>
 <DCE64EDD-FCE4-4C21-8B00-7833D5EB4EB2@oracle.com>
 <89044942-DAFE-4E9B-BC70-A8D2C847A422@oracle.com>
 <24C858F4-5334-4417-BFA5-4D580274F47E@oracle.com>
 <YQBPR0101MB9742865EA5C7945107B76A8DDD879@YQBPR0101MB9742.CANPRD01.PROD.OUTLOOK.COM>
 <76588a2d-9f53-6347-48b3-5fd45a69cf99@talpey.com>
In-Reply-To: <76588a2d-9f53-6347-48b3-5fd45a69cf99@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 9f18abaf-45b9-57e5-f44e-778bbeeff027
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uoguelph.ca;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ebd5b39-ad87-424c-1252-08da63881abe
x-ms-traffictypediagnostic: YT1PR01MB4155:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wi2+6Q8Chq1Oz1pXFphKlg4TNMCIhUi3o6hdq7O8A5OT0UnxGxA1/jbCQGEfOXyQsyysxu5KdH92hiqvGlxuFNHzDpZTaHuVKqlwVR7J5Xo+0oPZ1l8Yxu9+A2zqxCxM0EZm2xW3yZArKnysviHgO6PhL7PdDiC25M3bH/6CrrouHsUeZ8I5EEjkSe96RV9SAiLoefzLdrI8EVKPs5AWuYCq0IT0fA3y6JCYhDT22fPqMD7rviNpm4fX1GVIabwv1Sg2iR7CDwoKe7Zcy+ttXxhFWWqrvuqsPfvLD8P7vj3IjjMSxojC+gQunMsnrb+5F2mg62OryuKnKa+ThUIFCr08gCZNiXxdknIczDS0Kmx9mcYKAWzCtP/sLQ+aEZlY+3Ggt3O5XOVQmvhZFqYzk3xA596GdNO3Fdm03BIf3wgFrB2q1tcI5Kew+qRI4/zCoXBT5Y/0uHIdLcL80+D+85TdNRLpEoiB2s3fkHXvk38QqyZSRSpKY39DGyYhr//+EZlkWAZLO2jDRYuFHHXgVqwYm4n7Pj+qvcvKauZT09GwdYc38mIWFf2KXhj1MMclYN1tkKujL8UQUJnhx619OBeh3lCJ80EJsKtX5QYcZTW5LcqKu02t1UGZj8lyWg6eGXhD0lUjnQu12YjCwFYkIbyz0pTTkH4eJBEeplUXolMyRB8EnZpfepRfxyMEON7mDGFsOXgSaoeXu+Z/qQGK7zMvAcM8NX9Gew4PovlvO+maTfVnG96X4YvsN7C7sAd1r0NojfxdQ+ejmK3slcb8+OlwZ13jwcKW8+hN/cF+TBgTqiANqaRUiZEkxvAJdYOS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB9742.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(86362001)(186003)(38100700002)(66946007)(66556008)(38070700005)(83380400001)(91956017)(64756008)(66476007)(110136005)(8676002)(66446008)(786003)(316002)(55016003)(76116006)(71200400001)(4326008)(122000001)(7696005)(5660300002)(53546011)(52536014)(478600001)(9686003)(8936002)(2906002)(6506007)(41300700001)(41320700001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dan8ZB/L84eVJKxqMgjg79ZtstpzkhjfVth0gnDil9f/CtUWKTmvtCmFqX?=
 =?iso-8859-1?Q?C7EdnHR1cbjcn9hP7WYQ7ezlkQQautmK0IBD+OVxlNyt9KduejWdYIP9Uw?=
 =?iso-8859-1?Q?OUR496VPUa+qrbISbMsM0Mtxa+QQNXeonckfMwLpCGdoc2xhHQlT+ZZ0C4?=
 =?iso-8859-1?Q?H9aEz60+tb3mDxWPwEHNtubtSW+NfVXKv5iwwZrqkgmbAk836cEwSccsMu?=
 =?iso-8859-1?Q?gcUXHNE+D1g72Cv3zP5zQiyIULZnNoBI5AqIDgaiSpQjF2G7LmB+RdICTf?=
 =?iso-8859-1?Q?sG+WBYKWphLUcevJ63lio26FZaBkqcUYqH+Sy6AOZGQ2Bjv1qO/oucWclZ?=
 =?iso-8859-1?Q?63MyDPSV4e52ToeSZyT125aQOWL5iovXXNoduNKPyDIfP/57BZsRdHQzfA?=
 =?iso-8859-1?Q?kaENkjH1VkCtmqIb+PlWewYNx2she861kuMiR8E1D7kPhUIx8NFveTN2p1?=
 =?iso-8859-1?Q?HAbaopfVaAU7zzkoqjrilYZRez5T1XBlDaea28ytan1XOHBwPBqIoSNk6N?=
 =?iso-8859-1?Q?ZEjZfZzfvngFHoptufzOMggRhS3LjWGFa0r6msyS+bdgCARrCZf2Qy5fVA?=
 =?iso-8859-1?Q?I2osBUHEKtNh2Hqz90ZProdFlDKnckMr27kI+1yrB11H0qb69dFzlYeoNL?=
 =?iso-8859-1?Q?7PeW49jC9zfC6vl+J9s/cxCOGSCxMAEuZUnU+FOOVn4wrrHR+ELawIuvCq?=
 =?iso-8859-1?Q?PbvsFKe8UPulv7F3Mqpp+/L5Ahy+Vb31tZtdkFVbMojJwDCN6qgk25HPai?=
 =?iso-8859-1?Q?WTvlY3K+GE1XV0Cl8LUuHKvE7UhQbfAZbiwJml3CzvqUjbZywTUrpBlN5G?=
 =?iso-8859-1?Q?Kj04yqvrfaHoQJDt8Ot4Cef3LEUWyZn6xUW3aGFJVmFOHVo4aEYMLJCdU8?=
 =?iso-8859-1?Q?VvZt710qMdRp2Mtv0bZ+H6ER+kCLxS7grBRiDUlW74fU1IDuCxq451JBhj?=
 =?iso-8859-1?Q?OVz/MmcS5bAfa9+Tdk3b/mCjNhcVLk7hZHciTVHfjYZvUk5ks93CVhln6M?=
 =?iso-8859-1?Q?AKpn4S5/xlFJk8BkEIUbFmzahk+/b1vDItg+8YJZizYLRvpQgwCMp789nf?=
 =?iso-8859-1?Q?a2yHodh4vQCG/4CpFY6mvYHSPdK3v2K9yrd01WZYLmmLSQdjkmURR/8PBp?=
 =?iso-8859-1?Q?qFydmArI2Pvdf3KROYFHxNaAOL6yNjR8GoN4nbfVsx26jSzrALc0VJ6nfd?=
 =?iso-8859-1?Q?P3dn5CwWF/bxirptYx2vWn0uuP03lHaYHBez6e0fJHPyDeD0hnuamzcnzm?=
 =?iso-8859-1?Q?mOnwGPgme3EYwtB8HcR6M/UM+YozQ9adxFVk1BULiRCnPtVSoxJhoUZ3Cs?=
 =?iso-8859-1?Q?fNZlDEA0htqn/+JUBIV4WhiUL1S+ZdAqILx8LPFfq4YUlpUYKmIo1fcf1e?=
 =?iso-8859-1?Q?mMRkeWGs6iPZJeRfCOvRrVebJbBbCVDO2QsccPaCUjVx5c2wWfkhdRen6B?=
 =?iso-8859-1?Q?O5bD1WknyAe5rSkwLurbytixz6OV9kahjMxkapKo2GbBRxBwMfYqQfoAi5?=
 =?iso-8859-1?Q?ISuz8HTLZc2yOrt7Pr4kABvViLxV6IMh4vT1nWjTw2/ac/OCZLnlK1rCk2?=
 =?iso-8859-1?Q?PnWvyeeni82JfI+kftTgir/dfY+1PPuugmjAjlg7MCz3JTfuazy9dQTlYC?=
 =?iso-8859-1?Q?PfPxEXBuayPxKSH+O3qt5pskYUTjQ1qbQYdt/UhJTxS3VDdnqqeiQgj/lL?=
 =?iso-8859-1?Q?9X0Rg6ufl3TiDq9CnmrbAiTrH4hxwocSdrF4BS7B?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: uoguelph.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB9742.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ebd5b39-ad87-424c-1252-08da63881abe
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 21:55:44.1244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be62a12b-2cad-49a1-a5fa-85f4f3156a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6limRlKuYOTM5rQNS9qGuejPWTpmHpbFFGXVLzvs1jkbV6IL6g8NXh7YN2HMJ+vCU7nmwHMX1WbHFsyOtrKUcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB4155
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Tom Talpey <tom@talpey.com> wrote:=0A=
> On 7/11/2022 4:43 PM, Rick Macklem wrote:=0A=
> >>>> CREATE_SESSION has a built-in reply cache to thwart replay attacks.=
=0A=
> >>>> It can legitimately return the same sessionid as a previous request.=
=0A=
> >>>> Granted, DESTROY_SESSION is supposed to wipe that reply cache...=0A=
> > Well, I just re-read the RFC and I don't see anything that says Destroy=
Session=0A=
> > affects the CreateSession reply cache.=0A=
> =0A=
> It actually does, but I think it's problematic:=0A=
> =0A=
> =0A=
> 18.37.3.  DESCRIPTION=0A=
> =0A=
>     The DESTROY_SESSION operation closes the session and discards the=0A=
>     session's reply cache, if any.  Any remaining connections associated=
=0A=
>     with the session are immediately disassociated.  If the connection=0A=
>     has no remaining associated sessions, the connection MAY be closed by=
=0A=
>     the server.  Locks, delegations, layouts, wants, and the lease, which=
=0A=
>     are all tied to the client ID, are not affected by DESTROY_SESSION.=
=0A=
When I read "discards the session's reply cache" I think I somehow read it=
=0A=
as "discards the create_session reply cache", but it pretty obviously is re=
ferring=0A=
to what is cached for the session's slots.=0A=
=0A=
> What about the reply to DESTROY_SESSION itself? I guess the idea is=0A=
> that if the client misses the reply and reconnects/retransmits, it=0A=
> gets NFSERR_BAD_SESSION and figures it out. Maybe not worth taking=0A=
> to IETF, since you found the root cause!=0A=
Yep, the reply to DestroySession doesn't get cached but, as you note, the=
=0A=
client usually can just ignore a NFS4ERR_BAD_SESSION reply and assume it=0A=
is a retry, since it wanted to get rid of the session anyhow.=0A=
=0A=
rick=0A=
=0A=
Tom.=0A=
