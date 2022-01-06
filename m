Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241B3486778
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Jan 2022 17:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241041AbiAFQNc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Jan 2022 11:13:32 -0500
Received: from mail-tycjpn01on2134.outbound.protection.outlook.com ([40.107.114.134]:2628
        "EHLO JPN01-TYC-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240952AbiAFQNc (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 6 Jan 2022 11:13:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQJuF+jn4EuibwpXUuCct/JUF+/GBiDPdACA5jSfssA=;
 b=AkUmJ9yF3lwIrTbWHC3Ms+bKiFZFs4Xp4IjLKq3heJ5TpsWwFHl0Az3APT56t0tlYglY1l9BV82Dl3cBjqH7z0cbmNypCbgJDrzDRjnuhMiNCnQukzQ47wV6UPPmYnRu4RRkUOayvym+aPz60ndS3HDtxdDknOwVzoL/QyeYhaU=
Received: from OS0PR01CA0118.jpnprd01.prod.outlook.com (2603:1096:604:9b::17)
 by TYCPR01MB7387.jpnprd01.prod.outlook.com (2603:1096:400:f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Thu, 6 Jan
 2022 16:13:30 +0000
Received: from OS0JPN01FT030.eop-JPN01.prod.protection.outlook.com
 (2603:1096:604:9b:cafe::a) by OS0PR01CA0118.outlook.office365.com
 (2603:1096:604:9b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Thu, 6 Jan 2022 16:13:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.101.26.97)
 smtp.mailfrom=renesas.com; dkim=fail (signature did not verify)
 header.d=dialogsemiconductor.onmicrosoft.com;dmarc=pass action=none
 header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 20.101.26.97 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.101.26.97; helo=mailrelay4.diasemi.com;
Received: from mailrelay4.diasemi.com (20.101.26.97) by
 OS0JPN01FT030.mail.protection.outlook.com (10.13.140.113) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.9 via Frontend Transport; Thu, 6 Jan 2022 16:13:29 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (104.47.13.56) by
 AZSRVEX-EDGE2V.diasemi.com (10.6.15.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2044.4; Thu, 6 Jan 2022 16:13:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTEud8oOb1EFrYZxPr4ZawVTIEZ3fE3qRYT6L+9+sJTbUUquUnRx4UXfwKfn4sogA4liHWEbCpoGSQU/K53/r8o20tQbPIb0BKkd+83k0dsY9DNISjRZAAFtQLst454RhNBLyB+e7RWnlGrPfvpLD9NgKN6W4tyIeaIMmTwb2nAzFQju2kNTNemLIjiONlUXiIP7XoZCG/GaL0dCyIwiiMC6f3PJSj4qz9FPxYbO8ooERts/z6oLqM+dxoUAsJjiPcS2WK6v51qH5oWA+HrRvnqwa4nwFtlTVTHoaTdgi1Jisb+gxcSTGRr3V8tpM2Uy2DbJYhT7tXseY2/vPgs3Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQJuF+jn4EuibwpXUuCct/JUF+/GBiDPdACA5jSfssA=;
 b=ALqDJXyNktNXnop25TFIsf10QLZkIxlEsaUwwr7cw1TF0TUNivQSLw396J5usz3bJznP82W3C7UlNAWjJyXll+bwjQ0JSMpJI2KIfF/5F6RdnvbSFxSaxrDxfPViQ5Ctkdy7zNRdv9rBpkPV7f4gp92KY9m2CtpoezxNPYBIvSOjAWkT9HRt3vWU5jpiuy7f3hi0rby7uatxrZAAtBLc4OEjS2D1nvIbZBNwg5TpoiKJMXaeBwKFdCuGTfsrhLH4eL7cPfg4JoQrgPO1w+1gb5j2Dv84sSqmKYfdW19k9OywuTA1PstSLaD9G5sX43qbQasst8tjiUJuhnymXPzh8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQJuF+jn4EuibwpXUuCct/JUF+/GBiDPdACA5jSfssA=;
 b=P0uHz5EOZXPwGYSi6DHRU/WWVbAs7D+2nkAhv3xLEdZJlP4jDcxGvNxRFf4mSA81T0ukvGBXhdVXKJYMnXbvWlOCr0smxAuPd28tbuaZUAv2Oyr3BukCobGF6gqLTjt8gDS8uddq88wHBUxCgNs+2K8xN9fqdBHuiMOlNCjLHJ4=
Received: from DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2d9::19)
 by DU0PR10MB5412.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:32b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Thu, 6 Jan
 2022 16:13:26 +0000
Received: from DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d67:573c:339:722]) by DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d67:573c:339:722%3]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 16:13:26 +0000
From:   Ondrej Valousek <ondrej.valousek.xm@renesas.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        Ondrej Valousek <ondrej.valousek.xm@renesas.com>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "trondmy@kernel.org" <trondmy@kernel.org>
Subject: RE: [PATCH 0/8] Support btime and other NFSv4 specific attributes
Thread-Topic: [PATCH 0/8] Support btime and other NFSv4 specific attributes
Thread-Index: AQHYAOOnWznuBWlA7k+POKyqIasZNKxRxaOAgALAoRCAAASbAIAABaVAgAAG2oCAASYa0IAAUGUAgAAAUPCAAANQAIAAAjSAgAAC6CCAAAKYAIAAFO8g
Date:   Thu, 6 Jan 2022 16:13:26 +0000
Message-ID: <DU2PR10MB5096140C8DC5493271E8A8ADE14C9@DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM>
References: <DU2PR10MB5096010E9570E2718198EDD5E14B9@DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM>
 <20220105151008.GB24685@fieldses.org>
 <DU2PR10MB5096501FB8A162D18CF1F1F2E14B9@DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM>
 <20220105155451.GA25384@fieldses.org>
 <DU2PR10MB5096923D24D76EC264A51EBFE14C9@DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM>
 <a12cfed3e997507ec837aefbd63aa4ff7b34fd4d.camel@hammerspace.com>
 <DU2PR10MB50969D4D096DB99EEC6D1C45E14C9@DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM>
 <20220106142812.GC7105@fieldses.org> <20220106143605.GD7105@fieldses.org>
 <DU2PR10MB509689410AAC9E0B9D629558E14C9@DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM>
 <20220106145546.GE7105@fieldses.org>
In-Reply-To: <20220106145546.GE7105@fieldses.org>
Accept-Language: cs-CZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
X-MS-Office365-Filtering-Correlation-Id: d6b42b15-9c17-4f9b-4448-08d9d12f7a58
x-ms-traffictypediagnostic: DU0PR10MB5412:EE_|OS0JPN01FT030:EE_|TYCPR01MB7387:EE_
X-Microsoft-Antispam-PRVS: <TYCPR01MB7387A13F1CF88E0DDDCB93E9D94C9@TYCPR01MB7387.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 3bo+pM33SFGIeiS9jQLpLTFRcoJid2Nu093e4hCFecEcJhL3aN38460qPod3v2Jb1jP1Z9nc/oARLP2Orumr8SnHQwadNhfQ1NE9XAOPgF9QwwvMcWaHGpzAmKiaCgJdeLqyNE1oJfholg4CBlTKkVUapIJqfynFezhdnFn9XhAu96HZosxGg46v3UPziclmEuWow+wQIZmpbqNMsjIJOpIkALn8qGzb2R+GKwoNyyqyQQl91nWOBoWoE5YnVQKXMoXBs92NoBnUcaZMDwGUf1FKMVk+CDYvu1aKnH69drqxxJ9ipZFaYconb7qJ041wAkaBOwhevSX9dRukrkNECuFpA9hoIwryE5fhpV7Fb2eB6Qfs3wf9FipREzDL29uXHttpx23tD1h+3vGPmQlhFKYRtXtnQa/VSu75bf4du1cpXQ9t1lohN/AWpo8n6VNnwl4gWPAvf2V7B2+3qQHI5AYYPyLIaIQxxo+3qiZ2PdPn1KRZqwZwqZEwaXC+NTt+QNSzME2f0jDxzuJqOjBjHZTuAbep+4y0pT2xhBr8936GBT3tVl2J18srWNQRvQfm9DIKABRAOLgT6GkJRTjKk36zMNmQe9h2UBB8vrZSZjc+epsQr48UBvVGJlaD99tIQ2YWgp44jaB9lpQKQNKMcniOh+4IqP3tH/66GZGOdKddEfNcVaAskQv5lWfKgaJxrQF2PlZKtQ/BTa4Evtm6ew==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(33656002)(9686003)(83380400001)(2906002)(6506007)(5660300002)(71200400001)(55236004)(508600001)(7696005)(55016003)(38070700005)(38100700002)(66476007)(316002)(4326008)(66446008)(64756008)(76116006)(66556008)(52536014)(66946007)(86362001)(186003)(122000001)(8676002)(26005)(54906003)(110136005);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5412
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: OS0JPN01FT030.eop-JPN01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: c9043004-8cc1-4b72-b75d-08d9d12f785b
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr,ExtFwd
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9k3O4Xj8Hznk2vDcasKv+osQPNa8PHtulpyxo7GQ60crCButrCabQkYcKYqjgovwk4OhmgKSNAHPTbGVYXm7FCvh02et9dZqll88N/sFQ5FRFUHdsTaJxwfAZOeP6oypyAGBtY2EukFnp3lifNPB2WPDnAskB6fthFa33fBuWOEmfS5Dav/Y6YzA33SgIL4smmD9z9wZVLsz8Fm1uceuqjxmEbKT9kljOfRnB2CsCZos7wQFD8os4LiWbRo8o/zGql3ymmLWd8uVwpTEXZuRW6XfOIeUl3+iT1QeRZ8Qyu5+uVVBnjHP31/ktBEGe5gPNdX6wNhEnIFK8L3KIxBI57Ok90RJNlikRRQ5jgkg8qyI0Kd1wpWY5+78yzrYF917f3Xg5qaQbJ3MO4G/7zgdf9mDo3EQSz+OEx8VBOMHNXdtuWnAVhGhSmzIjsmxmv6oPnv368pB51zt8MmN442hTONGG9fKWXPGd71z2HrCGlaZ0WOK9BUL0GT7jOqp6HzbLOFIK9yuisLP2EyDpBJ8ebDKtN6G58AsqEThFCMiT1e8lO8zjz04d2or7lEnE1VwDWW0XYWKco42sEhzkcWp5AIDU0dUssxg9ojgFCEJBN0yV0Pwds07mXphpzHytmRLmVjKcMAx2asJ4z8jDdHQm3Q2ueP0gxeZOlfCqy2HAhM37WgqVN/qpMXabH2xUq2PIwpos7dbZX7xmSoPEgPKefOA9nycYZzXUoFHnvLtHrbOO+FwwufSBaq2BvX96fHPOoQfzXGtDLS51c5JYAzOlAucr79S4iTTWCfQrVthdHM=
X-Forefront-Antispam-Report: CIP:20.101.26.97;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay4.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(40470700002)(36840700001)(46966006)(82310400004)(356005)(40460700001)(86362001)(54906003)(26005)(36906005)(6506007)(316002)(336012)(508600001)(70586007)(70206006)(8676002)(52536014)(2906002)(33656002)(83380400001)(4326008)(9686003)(47076005)(55016003)(81166007)(186003)(8936002)(5660300002)(110136005)(7696005)(36860700001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 16:13:29.0752
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b42b15-9c17-4f9b-4448-08d9d12f7a58
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[20.101.26.97];Helo=[mailrelay4.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: OS0JPN01FT030.eop-JPN01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7387
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

U28gSSB0aGluayB0aGlzIGlzIHdoYXQgd2UgZXZlbnR1YWxseSBuZWVkICh0aGFua3MgZm9yIHRo
ZSBwb2ludGVycyB5b3UgZ2F2ZSBtZSEpOg0KDQpkaWZmIC0tZ2l0IGEvZnMvbmZzZC9uZnM0eGRy
LmMgYi9mcy9uZnNkL25mczR4ZHIuYw0KaW5kZXggNWE5M2E1ZGI0ZmIwLi5lODhhZTRjZTUyNjMg
MTAwNjQ0DQotLS0gYS9mcy9uZnNkL25mczR4ZHIuYw0KKysrIGIvZnMvbmZzZC9uZnM0eGRyLmMN
CkBAIC0yODY1LDYgKzI4NjUsOSBAQCBuZnNkNF9lbmNvZGVfZmF0dHIoc3RydWN0IHhkcl9zdHJl
YW0gKnhkciwgc3RydWN0IHN2Y19maCAqZmhwLA0KICAgICAgICBlcnIgPSB2ZnNfZ2V0YXR0cigm
cGF0aCwgJnN0YXQsIFNUQVRYX0JBU0lDX1NUQVRTLCBBVF9TVEFUWF9TWU5DX0FTX1NUQVQpOw0K
ICAgICAgICBpZiAoZXJyKQ0KICAgICAgICAgICAgICAgIGdvdG8gb3V0X25mc2VycjsNCisgICAg
ICAgaWYgKCEgc3RhdC5yZXN1bHRfbWFzayAmIFNUQVRYX0JUSU1FKQ0KKyAgICAgICAgICAgICAg
IC8qIHVuZGVybHlpbmcgRlMgZG9lcyBub3Qgb2ZmZXIgYnRpbWUgc28gd2UgY2FuJ3Qgc2hhcmUg
aXQgKi8NCisgICAgICAgICAgICAgICBibXZhbDEgJj0gfkZBVFRSNF9XT1JEMV9USU1FX0NSRUFU
RTsNCiAgICAgICAgaWYgKChibXZhbDAgJiAoRkFUVFI0X1dPUkQwX0ZJTEVTX0FWQUlMIHwgRkFU
VFI0X1dPUkQwX0ZJTEVTX0ZSRUUgfA0KICAgICAgICAgICAgICAgICAgICAgICAgRkFUVFI0X1dP
UkQwX0ZJTEVTX1RPVEFMIHwgRkFUVFI0X1dPUkQwX01BWE5BTUUpKSB8fA0KICAgICAgICAgICAg
KGJtdmFsMSAmIChGQVRUUjRfV09SRDFfU1BBQ0VfQVZBSUwgfCBGQVRUUjRfV09SRDFfU1BBQ0Vf
RlJFRSB8DQpAQCAtMzI2NSw2ICszMjY4LDE0IEBAIG5mc2Q0X2VuY29kZV9mYXR0cihzdHJ1Y3Qg
eGRyX3N0cmVhbSAqeGRyLCBzdHJ1Y3Qgc3ZjX2ZoICpmaHAsDQogICAgICAgICAgICAgICAgcCA9
IHhkcl9lbmNvZGVfaHlwZXIocCwgKHM2NClzdGF0Lm10aW1lLnR2X3NlYyk7DQogICAgICAgICAg
ICAgICAgKnArKyA9IGNwdV90b19iZTMyKHN0YXQubXRpbWUudHZfbnNlYyk7DQogICAgICAgIH0N
CisgICAgICAgLyogc3VwcG9ydCBmb3IgYnRpbWUgaGVyZSAqLw0KKyAgICAgICAgaWYgKGJtdmFs
MSAmIEZBVFRSNF9XT1JEMV9USU1FX0NSRUFURSkgew0KKyAgICAgICAgICAgICAgICBwID0geGRy
X3Jlc2VydmVfc3BhY2UoeGRyLCAxMik7DQorICAgICAgICAgICAgICAgIGlmICghcCkNCisgICAg
ICAgICAgICAgICAgICAgICAgICBnb3RvIG91dF9yZXNvdXJjZTsNCisgICAgICAgICAgICAgICAg
cCA9IHhkcl9lbmNvZGVfaHlwZXIocCwgKHM2NClzdGF0LmJ0aW1lLnR2X3NlYyk7DQorICAgICAg
ICAgICAgICAgICpwKysgPSBjcHVfdG9fYmUzMihzdGF0LmJ0aW1lLnR2X25zZWMpOw0KKyAgICAg
ICAgfQ0KICAgICAgICBpZiAoYm12YWwxICYgRkFUVFI0X1dPUkQxX01PVU5URURfT05fRklMRUlE
KSB7DQogICAgICAgICAgICAgICAgc3RydWN0IGtzdGF0IHBhcmVudF9zdGF0Ow0KICAgICAgICAg
ICAgICAgIHU2NCBpbm8gPSBzdGF0LmlubzsNCg0KZGlmZiAtLWdpdCBhL2ZzL25mc2QvbmZzZC5o
IGIvZnMvbmZzZC9uZnNkLmgNCmluZGV4IDQ5OGU1YTQ4OTgyNi4uNWVmMDU2Y2U3NTkxIDEwMDY0
NA0KLS0tIGEvZnMvbmZzZC9uZnNkLmgNCisrKyBiL2ZzL25mc2QvbmZzZC5oDQpAQCAtMzY0LDcg
KzM2NCw3IEBAIHZvaWQgICAgICAgICAgICAgICAgbmZzZF9sb2NrZF9zaHV0ZG93bih2b2lkKTsN
CiAgfCBGQVRUUjRfV09SRDFfT1dORVIgICAgICAgICAgfCBGQVRUUjRfV09SRDFfT1dORVJfR1JP
VVAgIHwgRkFUVFI0X1dPUkQxX1JBV0RFViAgICAgICAgICAgXA0KICB8IEZBVFRSNF9XT1JEMV9T
UEFDRV9BVkFJTCAgICAgfCBGQVRUUjRfV09SRDFfU1BBQ0VfRlJFRSAgIHwgRkFUVFI0X1dPUkQx
X1NQQUNFX1RPVEFMICAgICAgXA0KICB8IEZBVFRSNF9XT1JEMV9TUEFDRV9VU0VEICAgICAgfCBG
QVRUUjRfV09SRDFfVElNRV9BQ0NFU1MgIHwgRkFUVFI0X1dPUkQxX1RJTUVfQUNDRVNTX1NFVCAg
XA0KLSB8IEZBVFRSNF9XT1JEMV9USU1FX0RFTFRBICAgfCBGQVRUUjRfV09SRDFfVElNRV9NRVRB
REFUQSAgICBcDQorIHwgRkFUVFI0X1dPUkQxX1RJTUVfREVMVEEgICB8IEZBVFRSNF9XT1JEMV9U
SU1FX01FVEFEQVRBICAgfCBGQVRUUjRfV09SRDFfVElNRV9DUkVBVEUgICAgICBcDQogIHwgRkFU
VFI0X1dPUkQxX1RJTUVfTU9ESUZZICAgICB8IEZBVFRSNF9XT1JEMV9USU1FX01PRElGWV9TRVQg
fCBGQVRUUjRfV09SRDFfTU9VTlRFRF9PTl9GSUxFSUQpDQoNCiAjZGVmaW5lIE5GU0Q0X1NVUFBP
UlRFRF9BVFRSU19XT1JEMiAwDQoNCkxlZ2FsIERpc2NsYWltZXI6IFRoaXMgZS1tYWlsIGNvbW11
bmljYXRpb24gKGFuZCBhbnkgYXR0YWNobWVudC9zKSBpcyBjb25maWRlbnRpYWwgYW5kIGNvbnRh
aW5zIHByb3ByaWV0YXJ5IGluZm9ybWF0aW9uLCBzb21lIG9yIGFsbCBvZiB3aGljaCBtYXkgYmUg
bGVnYWxseSBwcml2aWxlZ2VkLiBJdCBpcyBpbnRlbmRlZCBzb2xlbHkgZm9yIHRoZSB1c2Ugb2Yg
dGhlIGluZGl2aWR1YWwgb3IgZW50aXR5IHRvIHdoaWNoIGl0IGlzIGFkZHJlc3NlZC4gQWNjZXNz
IHRvIHRoaXMgZW1haWwgYnkgYW55b25lIGVsc2UgaXMgdW5hdXRob3JpemVkLiBJZiB5b3UgYXJl
IG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBhbnkgZGlzY2xvc3VyZSwgY29weWluZywgZGlz
dHJpYnV0aW9uIG9yIGFueSBhY3Rpb24gdGFrZW4gb3Igb21pdHRlZCB0byBiZSB0YWtlbiBpbiBy
ZWxpYW5jZSBvbiBpdCwgaXMgcHJvaGliaXRlZCBhbmQgbWF5IGJlIHVubGF3ZnVsLg0K
