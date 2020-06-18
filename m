Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA2C1FEF29
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jun 2020 12:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgFRKDF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Jun 2020 06:03:05 -0400
Received: from esa15.fujitsucc.c3s2.iphmx.com ([68.232.156.107]:38740 "EHLO
        esa15.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728406AbgFRKDE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 Jun 2020 06:03:04 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Jun 2020 06:03:01 EDT
IronPort-SDR: Lk7i97gXTbgmd1DftLjPwxN/wU421n/YimuND6VXZ4U9JyYZ5cQiIIxLjUt1hce4PSY8V2dynj
 ubj1L18hB6iZOf4X4kjGZCp99gJa1GrBo8QstoFkI8p0H8FNukoZM6vMEM9E9ODKRt/kUtXUVk
 sy8A5J6ybIlH4JaMkxtdpRXqweBQStTPHHwhJy/XlZb/AqfZPJZi+yZENkBKks9QfLa5HGIZ6B
 yB31V4YGCfK4+lMOkOKH6qlaMUifFR7E9RoGLPgrbNtb8JtjcX/uKPJ0akpEHGz3y4/a7gqnD0
 LYI=
X-IronPort-AV: E=McAfee;i="6000,8403,9655"; a="14483169"
X-IronPort-AV: E=Sophos;i="5.73,526,1583161200"; 
   d="scan'208";a="14483169"
Received: from mail-os2jpn01lp2059.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.59])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 18:55:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncRPI9am4q1mWvLUyA0Yn6unIIJAPgbjcNqwUn1h/0adMqNghJzU9nuYs9ut8gfZp3xyBGCd21jczPyxYL0Bdw/6iiLObH35L+ZEhYIOYxfLsGYTqxh91qnAWLkNEECbKELBJ7YdroyAIHXsv50u4OEtwoV0rATprPEmGV5UjciwefDZrEzpMkzuIJnOtupj12PXnEmo0I2Yf+LuhRFNnVzbBrVDwQfpqA90q0Zr2kL9Dl1oBmOZXTxZnSNjmw4KI5j3P/Drtkkmg6i+oJDXRW2p/3LFEvSfcEoRER18WWdAzJnu3yJmKDCJURDH63iHRG7rZIfcnXf7Ev7njqEN/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5jsKTdIvUiMVvaUCfzMaxNA4fSEG2CDlv4vpd6G9bE=;
 b=Tfx2noaikB4eQs9dfPxNnPu9XIeyOi25FqUxpTVCpIjtpTGxnhPE88jbfEV2+yxp9VUN7U45EXbGMHPHiPjqnFVV7cYwsNOb4FKe4LLQJ4dau0oUFW93XvSWjpOwepblf4LKrkXgyaMYlDqc0k9tiitK6MFxPkpMOlfDL8tSG/YLlPlsbvRMrj4rDhlRxAtgUnK+TboZT9eqToX8kqz0IZflX5q+gMcG8dwTL7HI0tRPkiyJM1M7Qgehkr/g6JryrvuhsmzaXSjTFlnhCU6r2Ayo11KqEyruGtG7L0Y05aB3tIw+hMJXcrkD6UUXpXoOPs34uvh2CsQzhDn3Kb38/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5jsKTdIvUiMVvaUCfzMaxNA4fSEG2CDlv4vpd6G9bE=;
 b=LohRV8MBiFhhieUZFZcrIimeOjQp9Wbl10t5eeXWW6xKUdze9M7GfpnHJBLYO/XEgfFtcUw9mAQ5oT4iJrnAfizyVDFL0Am3J40wsE/tdbAGQwUjvRewdrRRe+pV41wXONkw5SeGruuWQefH3O+9hxW0hol4q/INhf1Rk3Cqz88=
Received: from OSBPR01MB2949.jpnprd01.prod.outlook.com (2603:1096:604:1a::22)
 by OSBPR01MB2520.jpnprd01.prod.outlook.com (2603:1096:604:1f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.24; Thu, 18 Jun
 2020 09:55:48 +0000
Received: from OSBPR01MB2949.jpnprd01.prod.outlook.com
 ([fe80::7435:6330:cf3f:9450]) by OSBPR01MB2949.jpnprd01.prod.outlook.com
 ([fe80::7435:6330:cf3f:9450%7]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 09:55:48 +0000
From:   "inoguchi.yuki@fujitsu.com" <inoguchi.yuki@fujitsu.com>
To:     "'J. Bruce Fields'" <bfields@fieldses.org>,
        "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>
Subject: RE: client caching and locks
Thread-Topic: client caching and locks
Thread-Index: AQHWPdqMcAycEC0/pke1JkGmPD8pPKjeL0Ew
Date:   Thu, 18 Jun 2020 09:54:32 +0000
Deferred-Delivery: Thu, 18 Jun 2020 09:55:30 +0000
Message-ID: <OSBPR01MB2949040AA49BC9B5F104DA1FEF9B0@OSBPR01MB2949.jpnprd01.prod.outlook.com>
References: <20200608211945.GB30639@fieldses.org>
In-Reply-To: <20200608211945.GB30639@fieldses.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.6.3
x-shieldmailcheckermailid: 1e9966059c234091bad5572a526c15f3
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [210.170.118.169]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01f8c8fc-4be8-4adf-e6ca-08d8136dc71b
x-ms-traffictypediagnostic: OSBPR01MB2520:
x-microsoft-antispam-prvs: <OSBPR01MB25206D4CB286043171FF728FEF9B0@OSBPR01MB2520.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QrTlvRMGhNvjIMimS2DGEMPiJKaDg1i8JNRA1IU5KK9iSSNxdlefGKBKM6hegs73gR73COyZa1POpFNfcjkE8C4Ba2xibyMGVvcJ1c7Vz2/OoHzsO6sGkAAe38ET/0aFpdFACaYBBwdD/sOIGy0G363YJN6BwMb9zWsRWK4E8Fo6MKvGXE/S5QqwWS8EDttawvBdVPIkyJJV5QaT37uKYLt6Dg4Qb8u91ax8uAjvBhnbdvr3M0oaoSIBUueDZXf/FpSaN9T8avpsA9/yuP6WaFrUA/2pWepIPpI+7okhAS75KmWn4OsiIx8J79Wx12YSmuzfGSyJGYxa3YKloX2NnJMPGy34vcWmhX7j7Ikft0XPdUhxmAJTbek4yqhWD1Sxe00B14m4y9m8M/S5JBpWE8uAs7BGzhzCyNwnqosJ26WtIJv7jcC0mbw7KC0hhD7FOfvCpO2CSEoBruCOxoOmAR8w6kWzOyzsllklBkH+D9s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2949.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(71200400001)(3480700007)(966005)(478600001)(110136005)(316002)(76116006)(83380400001)(55016002)(66946007)(85182001)(66476007)(66556008)(64756008)(66446008)(6506007)(7696005)(52536014)(5660300002)(2906002)(186003)(8676002)(8936002)(33656002)(86362001)(26005)(6666004)(9686003)(777600001)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: unpEVjP7s1p9tFe5hmOhgTrBKWPs1vIrlq5qlCWcmtdMKGA7sd8h2XOLhUDSyu8Qs2qrAsVTEBSEVyw/4jAO1OICoLr324iew35gjDbZoVK+Xj9AObvjluWRXWknUjHTbNQtENHxzVd0eeKWOhlhvxncdPGlYlCuZLTwaPzfgYfRuCnsKyK2bzOpRPfN1cOxlaWQGPpraNI3wKDNPS5WH6E8v3VNh/wdbvUExMlOO0RUqzVl/+EJi25zACyB/R4fsSjBzgfIptT9BbZhdY+wj2YhZfrvKZVpt7RLiH4OCL+DrqLDaIjniMPAAVMJM/GgiRbiCKAEHKx3IaEpeykDHtuF8wu4DSc2awJu3soiT2zbGXwLXOHYMxNAUAff4KHBPoWvmQFUr4g/3VuTt7/SoLc7vhSd9n9qHMJkJbA/94hr9YygDC8nPciO0M0qxpTYHssqNQOLFBfm0Ah1+b/TxgnEqDVI1ugI0IBJGSCxneg/BpL1qWK3awY+BAakF5BA
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f8c8fc-4be8-4adf-e6ca-08d8136dc71b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 09:55:48.4833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: torP+nptotpDn0ch+JUxnz8J3y0ZlnMqIncFBPQusr//pfwgKcbtv3uXs3NHHDxA6yFmUWioF895704cksZNtnt6/a3iw7+T+AUF7aS/ELU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2520
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> What does the client do to its cache when it writes to a locked range?
>=20
> The RFC:
>=20
> 	https://tools.ietf.org/html/rfc7530#section-10.3.2
>=20
> seems to apply that you should get something like local-filesystem
> semantics if you write-lock any range that you write to and read-lock
> any range that you read from.
>=20
> But I see a report that when applications write to non-overlapping
> ranges (while taking locks over those ranges), they don't see each
> other's updates.
>=20
> I think for simultaneous non-overlapping writes to work that way, the
> client would need to invalidate its cache on unlock (except for the
> locked range).  But i can't tell what the client's designed to do.

Simultaneous non-overlapping WRITEs is not taken into consideration in RFC7=
530.
I personally think it is not necessary to deal with this case by modifying =
the kernel because
the application on the client can be implemented to avoid it.

Serialization of the simultaneous operations may be one of the ways.
Just before the write operation, each client locks and reads the overlapped=
 range of data
instead of obtaining a lock in their own non-overlapping range.
They can reflect updates from other clients in this case.

Yuki Inoguchi

>=20
> --b.
