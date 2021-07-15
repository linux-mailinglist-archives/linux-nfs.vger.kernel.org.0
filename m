Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7343CA0E6
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jul 2021 16:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237397AbhGOOqk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Jul 2021 10:46:40 -0400
Received: from mail-eopbgr670081.outbound.protection.outlook.com ([40.107.67.81]:58472
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235229AbhGOOqj (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 15 Jul 2021 10:46:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGyw5KhbkdUmUgpPX+mqjmEjMugS8RK5F8mBElftpKQRf/eORqD5Ks4b1KKvSQZe74MmP/pbySnUQjrGmQ3b7ABxUsmz83JHkloaLuHhXeiJ/SwNj3ZlgBF5P9rMZ6wMQQviypsr9hykYG5pe5M/+bxgVXRsKxF0l5NDAAssluZWSQAtCUKoMhCvU5dTE24TeqfZVZ05lfLwxx/sd8oclcLqNwN/swA4C/PCLsWe3OqrJwuxmEP1ByxqhAAki0UMFT/+dOvUw4TFySFXvXYc0JZfrRNWDA94/ZMtnR4v+YRGTDjyqu9c17Ie2FTMCzN4ltCPE6M1O9dpgzsSazWIKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2a6C6o0m7ErjDVhdfqCfaWgTSUKddTmyZfo2qiDICmA=;
 b=eIqNCxoXZpjwb2DHY3KkJZ6S2Mm0CrukfA/M2Rx+HV1gZCXVRGksOiiEykW2tGpvtOn7elGNQ+P69qy/8S3hnIzqVTNcFLDSn0UpbFuvYTnIGuGtQ0rq7BS3JXL54UKMvyi+mUeNjoNI6A1M83bucX2sOAVyOEoYwUtI9AguyGVIb0U7czsltPghVnWKt3+/EpcjDHMbGwRt2CIZ2z5OSLpqX36HmuhiCC9IL2aNO+N/48C3JjTQwGkzj5o4XnSEiQDxB+b56RZK0yJ1n1la6+eNO1KylKojqtzycRk7N0ujFLNe2F/MMCvDEVwl+LpggND+HVJZctzxNuEeRZqHYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uoguelph.ca; dmarc=pass action=none header.from=uoguelph.ca;
 dkim=pass header.d=uoguelph.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uoguelph.ca;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2a6C6o0m7ErjDVhdfqCfaWgTSUKddTmyZfo2qiDICmA=;
 b=YutEJzv3Qr0ZzPCAFNV0Or6qqBYNxeNl/nq4GJ2Y4U8UBzDKyEp+POemg43yi2wPf2wj1mZY/XJczCGExmk/RtDPbb8ZBmUk9lFIt6+0C7WeKVlez2g8BGqi2E320/+rv9I+lMqnrBSTyskq4ewvT/HW1J0fvBS27g9oHbRh45jWJTc5+LrrzlxAqamgEFWCwzGW4NVf6tI/oLVsfos7PDnjdWmQTsculBXB+MuSCOUn3fTCujQ2djpf0LsETNH3oY2F6xCUcAd2NOFP6NORPJJQsy64Y2okWkU7+s/OWvMB6LiQ84RjEM7WZEmitQakMGt01gXzM71TEwsclxCmPw==
Received: from YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:19::29) by QB1PR01MB3122.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:33::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 14:43:45 +0000
Received: from YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::583:528b:dbac:37bf]) by YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::583:528b:dbac:37bf%4]) with mapi id 15.20.4308.027; Thu, 15 Jul 2021
 14:43:45 +0000
From:   Rick Macklem <rmacklem@uoguelph.ca>
To:     guy keren <guy@vastdata.com>, linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: nfs4.1 and nconnect - is this supported?
Thread-Topic: nfs4.1 and nconnect - is this supported?
Thread-Index: AQHXeXufkrmYpSiYM0awZfEk2w5O0atEG6+l
Date:   Thu, 15 Jul 2021 14:43:45 +0000
Message-ID: <YQXPR0101MB09687CF25C779E1E6ECEFF5ADD129@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
References: <9d726e22-8c47-41ac-727b-3a27a9919fc6@vastdata.com>
In-Reply-To: <9d726e22-8c47-41ac-727b-3a27a9919fc6@vastdata.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vastdata.com; dkim=none (message not signed)
 header.d=none;vastdata.com; dmarc=none action=none header.from=uoguelph.ca;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7149d44d-497d-41f1-ca47-08d9479ef2b3
x-ms-traffictypediagnostic: QB1PR01MB3122:
x-microsoft-antispam-prvs: <QB1PR01MB31222B6B015D4D3A39E8A86FDD129@QB1PR01MB3122.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aoP35NEY89lbl0+yvJ3/tzeR1i6To2I9/M4S4EEtJejDISn9G8arm9mlxYxpcmSgwNRgmErSTs7jQwzpyw2MCEKmDyJujpsGrxkJYGGOZJVjCYqh2g6BeVGg9DyIbtcWGt9l/Snkqp4ekykyUieRqZZQKqfS12KrMKCNZq9jyLRvZ2EaHL6tK9ZpNDs2jxJ6yjg4JgI/pk92XYOBxqhI1RHQFGvEW8pJjJsOpwCuhIaPACcPbQwEjrH9NgG6QpKghW76EedCYwl+2lEooxfX0Bk2dO7HTbBRme6Tur6ybrUocdVDo2y6Ck+djV+nCYR/k8f6irIq1VvtZQt3dL2NrAyzS3wEWvyxOX68VWvhbp5UGaFFm24FlPbQEBla5J627Q2OQ4l6+Ss/0XrSvhhnbHsGeAqVMiaX093KT36fvZHihoMB8A0EhQP6JrGyGvp4F0dSQ37cvFi64h3RnrhJnH25Vc8D4RHqRh/2pRK5fXI0Rw+LyqL98tZEnHowob+Qz5KFmozdZ5+7hBau3NKdQS5NM4ef2ZgmQOT7gHHCWp9+OQGU5GngWbcm9RYWv6vRhaPuD2GO4UIaKitDEPkfnp6dg1kPUeWeOpLRTPu8nm6C78YWtBEn69ULx5YYCiMfKhXynbEPiJXsBdrSS0YXdFjrgCCzUG057bps9Xa4vu/tuyNEHP8+3CuF3gXNPfq2elkNI5oPhnVUcYQ1CFVAsw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(39860400002)(136003)(366004)(376002)(396003)(52536014)(55016002)(786003)(66946007)(66446008)(7696005)(316002)(71200400001)(6506007)(8676002)(64756008)(66556008)(66476007)(9686003)(76116006)(8936002)(122000001)(5660300002)(83380400001)(38100700002)(33656002)(186003)(110136005)(478600001)(2906002)(86362001)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NQaaiJ5bMW2lQCAFn+NVXvjyrRz+1pfHlUIWXRiL2iGBJBJlTwl8PQkxJh?=
 =?iso-8859-1?Q?Hk6EGb1DtyrSKL43Igt3vRB4mS+tRG0CW/3Vx2EpRwQXAMyC0sVTfzD+UB?=
 =?iso-8859-1?Q?xYkKKOkJTv2gLsjzBd0/ZxFL0+F/bRheTZRBg9EGRauYC1J25KohQNpDuo?=
 =?iso-8859-1?Q?lUhA1c6kn0DjxbvXOOg/Fc8sLfmG3j+AGBzRfSREtGPa7x+O3iYtCpFXJ1?=
 =?iso-8859-1?Q?r42I+Pg7on3m/DYvPdzz2ru/YkewXKbTVQFQq8VnwI2bBDNwm15uwqbouH?=
 =?iso-8859-1?Q?JiIQW612zR3Kz3VIwnEuLtYHp7P9ycyCfvAynBHT6EQjm5mk06Sg13OMHX?=
 =?iso-8859-1?Q?Q+pCNFuRogt3KBhY7Am8RtfjlsuSGZ+pa5eU6Fr4m614Pza6FrIy93ezef?=
 =?iso-8859-1?Q?1/jYRCJpBqckU3Gm+68gOjXDs6EwlJSqjPSVz1LeRk/X/NW1VQkoNvWjWX?=
 =?iso-8859-1?Q?8138AhDjVu8Qj6PpKSQWnfkCKetC/SPzcbmSSyOHsOJ1oODOGLVba8W/RD?=
 =?iso-8859-1?Q?VSo7FmCJfrpkekzilLghmmWz0RZQhnW9Hpl5MpUQKgidOUS0Wfcyt+DqBm?=
 =?iso-8859-1?Q?XVlW4lAKdspyOyNv6cUe0Q+NHwmGVMuG0zV3Ytsrj6xGProiZRbeZS7Fi4?=
 =?iso-8859-1?Q?Yf3JzvsY7ZKJk2GIMdfEhUsvUo0un07w5SDTdvkoym0aD4pJISKCkuh6B/?=
 =?iso-8859-1?Q?roI9josDDO6FVwhZWsUAtH880UA2bktOb4p+L3AuxFx9M+1O2CVcJAMIFO?=
 =?iso-8859-1?Q?ZZAcUD/CZ8MZr63LeIHkxAiHhisITfpyqyrrGMgMoJ75i0+xV7cayDvCYq?=
 =?iso-8859-1?Q?emWBmmO2gIgj6QopJ7pQz3HroLiaLkjVnWDvrp8PBWmUEi2gRHP1ROkCAo?=
 =?iso-8859-1?Q?I2zikBccGYtCu2fcwuKHGyYopjugvYpaXwa6/pKGmwtC2qpBbS3+gWBLqN?=
 =?iso-8859-1?Q?rjYQYM+ovZXgmkIHKFyIaf+lJK9RVZ4zqUuDBWyT/YNXnHyGNS0Tlmh18b?=
 =?iso-8859-1?Q?kG4YoGzuzsH3sNGy6DmlKoZrAuUV9i8KPgJ98rBDdOtO6n3zpvLne/pAis?=
 =?iso-8859-1?Q?iklmZXlHp6XaoyLmfteYIc3gwXnkSywFYEYeGoH1eME+zZJb27dXCk3cdg?=
 =?iso-8859-1?Q?3EKSe9HmFT86WYurOcuwMiFklxSJMKCCYpMf27HXQb0obx35efbyfEcn7q?=
 =?iso-8859-1?Q?WOVt28VrRFOv/1Wr/9vWLZRMY3P1FAJNj0PwirsQgyEz9m1oAmsGqudqrl?=
 =?iso-8859-1?Q?2kAg1udwZ4fqhm2omE+pHJWN4KK62pgY5EsvB9Gf4N7CV+9I4tZoKJedbr?=
 =?iso-8859-1?Q?1oH7cROL5Y6TQjdeQNtLwMXTfGorBqge0ofkCTKL/5wKm2I2SDhSEAJ+2U?=
 =?iso-8859-1?Q?jlWrH2LmJJfDwjLkF/VrLlvSE1XAiXhgcdYWEzcradKeSfpFAQOrU=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: uoguelph.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7149d44d-497d-41f1-ca47-08d9479ef2b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2021 14:43:45.0950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be62a12b-2cad-49a1-a5fa-85f4f3156a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KQTYALEscI6Nr5E24+/KTjziOn6OAOBLoCnOfDzCg6s5YmESXSyCd5ZfeMelx/QSYFNFpFPzJHtzB17x4xPM0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: QB1PR01MB3122
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

guy keren <guy@vastdata.com> wrote:=0A=
>hi,=0A=
>=0A=
>i wonder if the linux client's nfs nconnect feature was designed to=0A=
>support NFS4.1 (or higher) versions? according to our experimentation,=0A=
>the linux client seems to just alternate messages between the multiple=0A=
>RPC/TCP connections, and does not seem to adhere to the NFS 4.1 protocol=
=0A=
>requirement, that when using multiple connections, the client needs to=0A=
>use BIND_CONN_TO_SESSION when trying to user a 2nd connection with the=0A=
>same NFS4.1 session.=0A=
>=0A=
>was this done on purpose? or is this configuration not supported by=0A=
>linux client's 'nconnect'? or am i missing something?=0A=
Yep, you're missing something.=0A=
=0A=
Snippet from RFC 5661 pg. 43:=0A=
   If the client specifies no state=0A=
   protection (Section 18.35) when the session is created, then when=0A=
   SEQUENCE is transmitted on a different connection, the connection is=0A=
   automatically associated with the fore channel of the session=0A=
   specified in the SEQUENCE operation.=0A=
=0A=
As such, BIND_CONN_TO_SESSION is only required to associate the=0A=
backchannel to the connection.=0A=
=0A=
rick=0A=
=0A=
thanks,=0A=
--guy=0A=
