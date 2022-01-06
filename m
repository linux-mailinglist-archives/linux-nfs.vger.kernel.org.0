Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF714865ED
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Jan 2022 15:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239854AbiAFOTc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Jan 2022 09:19:32 -0500
Received: from mail-os0jpn01on2117.outbound.protection.outlook.com ([40.107.113.117]:64135
        "EHLO JPN01-OS0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240043AbiAFOTb (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 6 Jan 2022 09:19:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xq2M7D8ldt0W1tqr1S32qIwqqo0lmp57JIhxKTPclCE=;
 b=XqPpeMCHPt5HRAvWg2w72YOpov59YB7z2f5y+r/nEyWzhR0fYG2nDKlXOVeZ3d/vWQgyCKDlznk7pHX9BZS2xWAcqA1XrNszCxdVqij/igcwUrZ/fXL3GKzL31xmR/ow/ULxDGYEdAX45x3/17Mr9MLIWUn+KBA/YutKxmaMB9U=
Received: from OS0P286CA0095.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:b1::10)
 by OSZPR01MB8498.jpnprd01.prod.outlook.com (2603:1096:604:183::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Thu, 6 Jan
 2022 14:19:28 +0000
Received: from OS0JPN01FT026.eop-JPN01.prod.protection.outlook.com
 (2603:1096:604:b1:cafe::9d) by OS0P286CA0095.outlook.office365.com
 (2603:1096:604:b1::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Thu, 6 Jan 2022 14:19:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.101.26.97)
 smtp.mailfrom=renesas.com; dkim=fail (signature did not verify)
 header.d=dialogsemiconductor.onmicrosoft.com;dmarc=pass action=none
 header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 20.101.26.97 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.101.26.97; helo=mailrelay4.diasemi.com;
Received: from mailrelay4.diasemi.com (20.101.26.97) by
 OS0JPN01FT026.mail.protection.outlook.com (10.13.140.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.10 via Frontend Transport; Thu, 6 Jan 2022 14:19:27 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (104.47.17.108)
 by AZSRVEX-EDGE2V.diasemi.com (10.6.15.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2044.4; Thu, 6 Jan 2022 14:19:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxYXQ7b/KUAUY9sife9yz3SMKdlj5RRRHeJ2fIGcoY8fjXZBboHyzUfwyZq88UhRXOelNemu2fO4piUfzNiOp5Lp+JFb52W20hsS/Rk5+ejucsZJmhu605t0rMSLINPFgF3TCSgXEZums64DMYsRKKUgWj76ylQQNoxbiIQugpvr1fZ130YxSVUwcB0y/8lkTz0Yukum9atO06LoG244yr0pRu6Q/4X9Cj1e15YbpYmcbcg7/KUOXxCJ9CiHDUykUx7rZdCx/F3KxMVwWge2TyjlaJ8F9/SkEBj0juhO5/QKayOh/XUwmtYwVj6Mw8RZky49rJjWFkUmRp6seiSyTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xq2M7D8ldt0W1tqr1S32qIwqqo0lmp57JIhxKTPclCE=;
 b=VsmG0tg2Qunt4smFKu9DzDT2xjJncXPWpDKaTr6zf0DasHd+JpwyO+SPhlBypcAYVhl0arBuFOiuYVDLHvMryJxmqqImgo5c8XERusUm9RmP+vcDmk5NCHbJ1bvsD8DAaDvfjXIc8c+++6RQuUQL7LfUW8On6m/xq5hmAm8AWQAC9G70p7EA8ADehAUuQFXVVcOueQ/cpyqZGlYHyDl91wQu63QF4fh9XJuxUOXFT6PYKYTduGkP9593zsPfXZ6favYV+Iy8rwrel/aDdLlzPJ9x7uF8nPwPVx5csJgUgKw0n4mkDJo+oS+Tp2E0xj7QnU6XXzHlIeInnLtPD5aBRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xq2M7D8ldt0W1tqr1S32qIwqqo0lmp57JIhxKTPclCE=;
 b=it0EeDF2yRNnNzdWtB+SOhmUHjfjlmFFmFZJQbIChHWuZZkVVSh2JEDxsE+JG2Hn0fGWHtGUyAEPUT34Xzt1ZSMH2bOSdPvClNt1fWDrUsi3DCJIRaIIAYCp5VweXGm2IUB1WkmkUh+w9isOloXKIbQcJHWpsyYz3I7IMVW74Wc=
Received: from DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2d9::19)
 by DU0PR10MB5267.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Thu, 6 Jan
 2022 14:19:23 +0000
Received: from DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d67:573c:339:722]) by DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d67:573c:339:722%3]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 14:19:22 +0000
From:   Ondrej Valousek <ondrej.valousek.xm@renesas.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "ondrej.valousek.xm@renesas.com" <ondrej.valousek.xm@renesas.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "trondmy@kernel.org" <trondmy@kernel.org>
Subject: RE: [PATCH 0/8] Support btime and other NFSv4 specific attributes
Thread-Topic: [PATCH 0/8] Support btime and other NFSv4 specific attributes
Thread-Index: AQHYAOOnWznuBWlA7k+POKyqIasZNKxRxaOAgALAoRCAAASbAIAABaVAgAAG2oCAASYa0IAAUGUAgAAAUPA=
Date:   Thu, 6 Jan 2022 14:19:22 +0000
Message-ID: <DU2PR10MB50969D4D096DB99EEC6D1C45E14C9@DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM>
References: <20211217204854.439578-1-trondmy@kernel.org>
         <20220103205103.GI21514@fieldses.org>
         <2b27da48604aaa34acce22188bfd429037540a89.camel@hammerspace.com>
         <DU2PR10MB5096010E9570E2718198EDD5E14B9@DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM>
         <20220105151008.GB24685@fieldses.org>
         <DU2PR10MB5096501FB8A162D18CF1F1F2E14B9@DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM>
         <20220105155451.GA25384@fieldses.org>
         <DU2PR10MB5096923D24D76EC264A51EBFE14C9@DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM>
 <a12cfed3e997507ec837aefbd63aa4ff7b34fd4d.camel@hammerspace.com>
In-Reply-To: <a12cfed3e997507ec837aefbd63aa4ff7b34fd4d.camel@hammerspace.com>
Accept-Language: cs-CZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
X-MS-Office365-Filtering-Correlation-Id: 87161555-1ea8-46a4-1d32-08d9d11f8c43
x-ms-traffictypediagnostic: DU0PR10MB5267:EE_|OS0JPN01FT026:EE_|OSZPR01MB8498:EE_
X-Microsoft-Antispam-PRVS: <OSZPR01MB84982191700D2017B385A6F9D94C9@OSZPR01MB8498.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: gsAohhlsdfZzwXRxSS3XJBQ0h1B+QxDA3ewWGlz+4x6g7n+DJJ2a2FYzoa6IhsFw7uRPflFS8UXnWUDGiuJOB30ZZAa9c4RJAeawt9dq5aSsiT/bT4ZQA4CPFFvXEmX5U7T8UVgR31c47yGZYT8FlpdT3aqR/EzI4Lsfb8aQY70RqH9M561fwx+EzqF9l3JaWkIABWSXw6GkgYVjRvUsX+4E0UlRLU0hgsdLII1ARmjROUfiMtMoAYNnlJaRn0kwIaB9XGt7myuj42+D4zL0ApErOj3ZWVyS5s3/TbLyg8b8uSe+uKffgasWBn3bCEk/owlZ9ocCfIty6hefoNRyPC9AXpTDUvkHG2sRcRRTVpKJwk5TS1RXeSR1P+rf0/764WCvRWJT+qrxkoyjOoIy2TjpvzKj84yFKImqanWtxLJYFT0jcxRB/qyuXICmqJ5TByY5Cmy8+2OIWe/Y7oKK0HAKbLOOQUNb//BG6i8gK/BZagnns3u/ODhi58xQLJrY9SgI9ot8J4Oij7owgZIcUmalg5vM4G3QVDPzhEA+qTet5rS6DKj0YTh/gUo4OJRguATCwSUkF76bNIg/4f7KRMnIn+gwuSVh16NEiE4Y9pzlnbi0VpeiB0npdSHk5T4cV/8WPkwdLvUdqxJKFosvQ1z/zXx6b0O/yhSNjfQ1jBuiATtnOoOqyE9KKYKZLEkfYEvfzUVdHc1vpCrxOEXNAQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(76116006)(71200400001)(186003)(66446008)(38070700005)(66556008)(122000001)(9686003)(110136005)(26005)(33656002)(52536014)(64756008)(55016003)(54906003)(55236004)(316002)(8676002)(38100700002)(508600001)(8936002)(2906002)(6506007)(86362001)(66476007)(7696005)(66946007)(4326008)(83380400001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5267
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: OS0JPN01FT026.eop-JPN01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4792d437-f3b7-41cb-b420-08d9d11f8977
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr,ExtFwd
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NVEc+zJv9H164N3BGJHQPk9WUCNoaqixBNVL6d75zkFWiAdWzJJVg0e7bIF6GLt9t1QQ9Ux25Cz4Cd+NuTeywRGR+dgDH0kXrSTCHqB1TMFXmlnulwvzY0K5iMkON5/M41CFaMUO54cjKtSbeJBYqSSrs9wWPqOu/ZgbNPAZWJ9x9FUZiwLPtmEGKA+DqTFfkw0HyHbIgu873r/HO6ES4WRF538CasJLlCrHuPT9bh5C0/YvdGaVPsrCx7HE4idSns1AhRuCnkwCHb6df10xXE67bFvA2aUbQ28c6lbGB6TxeXJyFjxUXaVWo4T6bs6sLIIu8hMTiCb4hArGS02KwpnDSud0eRMer0xrojvqXRu+7O8VOkmvccl1CNV3kRSlJPEY3jwRWXoPWi1AhrNslXvHguV+LQSu6xIQozekDDf9ZiumSw0JD50AkFhDSHgUgsZEOn0ArQsYjhhKgcfWOYTtynfPlsxtQ+i5qdmTLPYRiBhQSx0WvWKejjhPCeJEVY/xjk0zyqqOqI8etbHuONds2BGP1YfKjtUmyE4t14/M1T0ACBs8OSYn+FFvWTa6GYOwPHCntR291KGxjCRMKBI9kWxA0OQ1KZfGfnyOX+jlhivbQOhKEvm/KAv5ifL8pgxQpLAg36mHaVktnCGii31Az6PvBQfPeTJ8ukHwm8LxivVMR4s4Dhb3dc4leLmveSQFQOssNtZBmOggjA7vX2cZYIuflhnMqLCdheVg7K4zY9u+JZ5pBaFTBEhcz0t8EMeMx2zhHf4SBmebDvBhB7M/bCx6cg/czKocrCUzRRY=
X-Forefront-Antispam-Report: CIP:20.101.26.97;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay4.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(40470700002)(46966006)(36860700001)(52536014)(36906005)(316002)(186003)(26005)(5660300002)(70206006)(336012)(508600001)(86362001)(47076005)(81166007)(33656002)(70586007)(2906002)(7696005)(83380400001)(6506007)(8676002)(82310400004)(55016003)(110136005)(40460700001)(8936002)(54906003)(356005)(9686003)(4326008)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 14:19:27.1723
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87161555-1ea8-46a4-1d32-08d9d11f8c43
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[20.101.26.97];Helo=[mailrelay4.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: OS0JPN01FT026.eop-JPN01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8498
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

PiBZb3UgYWxzbyBuZWVkIHRvIHVwZGF0ZSB0aGUgdmFsdWUgb2YgTkZTRDRfU1VQUE9SVEVEX0FU
VFJTX1dPUkQxIHRvIHJlZmxlY3QgdGhlIG5ldyBzdXBwb3J0IGZvciBGQVRUUjRfV09SRDFfVElN
RV9DUkVBVEUuDQoNClllcywgSSByZWFsaXplZCB0aGF0IG9uZSBzaG9ydGx5IGFmdGVyIEkgc2Vu
dCB0aGUgbWFpbC4NCkp1c3QgZ29pbmcgdG8gdHJ5IHRoaXMgcGF0Y2g6DQoNCltvbmRyZWp2QHNr
eW5ldDE5IC9vcHQva2VybmVsL2xpbnV4LWdpdC9mcy9uZnNkXSQgZ2l0IGRpZmYNCmRpZmYgLS1n
aXQgYS9mcy9uZnNkL25mczR4ZHIuYyBiL2ZzL25mc2QvbmZzNHhkci5jDQppbmRleCA1YTkzYTVk
YjRmYjAuLmJlNDdlMWRkNmRhNSAxMDA2NDQNCi0tLSBhL2ZzL25mc2QvbmZzNHhkci5jDQorKysg
Yi9mcy9uZnNkL25mczR4ZHIuYw0KQEAgLTMyNjUsNiArMzI2NSwxNCBAQCBuZnNkNF9lbmNvZGVf
ZmF0dHIoc3RydWN0IHhkcl9zdHJlYW0gKnhkciwgc3RydWN0IHN2Y19maCAqZmhwLA0KICAgICAg
ICAgICAgICAgIHAgPSB4ZHJfZW5jb2RlX2h5cGVyKHAsIChzNjQpc3RhdC5tdGltZS50dl9zZWMp
Ow0KICAgICAgICAgICAgICAgICpwKysgPSBjcHVfdG9fYmUzMihzdGF0Lm10aW1lLnR2X25zZWMp
Ow0KICAgICAgICB9DQorICAgICAgIC8qIHN1cHBvcnQgZm9yIGJ0aW1lIGhlcmUgKi8NCisgICAg
ICAgIGlmIChibXZhbDEgJiBGQVRUUjRfV09SRDFfVElNRV9DUkVBVEUpIHsNCisgICAgICAgICAg
ICAgICAgcCA9IHhkcl9yZXNlcnZlX3NwYWNlKHhkciwgMTIpOw0KKyAgICAgICAgICAgICAgICBp
ZiAoIXApDQorICAgICAgICAgICAgICAgICAgICAgICAgZ290byBvdXRfcmVzb3VyY2U7DQorICAg
ICAgICAgICAgICAgIHAgPSB4ZHJfZW5jb2RlX2h5cGVyKHAsIChzNjQpc3RhdC5idGltZS50dl9z
ZWMpOw0KKyAgICAgICAgICAgICAgICAqcCsrID0gY3B1X3RvX2JlMzIoc3RhdC5idGltZS50dl9u
c2VjKTsNCisgICAgICAgIH0NCiAgICAgICAgaWYgKGJtdmFsMSAmIEZBVFRSNF9XT1JEMV9NT1VO
VEVEX09OX0ZJTEVJRCkgew0KICAgICAgICAgICAgICAgIHN0cnVjdCBrc3RhdCBwYXJlbnRfc3Rh
dDsNCiAgICAgICAgICAgICAgICB1NjQgaW5vID0gc3RhdC5pbm87DQpkaWZmIC0tZ2l0IGEvZnMv
bmZzZC9uZnNkLmggYi9mcy9uZnNkL25mc2QuaA0KaW5kZXggNDk4ZTVhNDg5ODI2Li41ZWYwNTZj
ZTc1OTEgMTAwNjQ0DQotLS0gYS9mcy9uZnNkL25mc2QuaA0KKysrIGIvZnMvbmZzZC9uZnNkLmgN
CkBAIC0zNjQsNyArMzY0LDcgQEAgdm9pZCAgICAgICAgICAgICAgICBuZnNkX2xvY2tkX3NodXRk
b3duKHZvaWQpOw0KICB8IEZBVFRSNF9XT1JEMV9PV05FUiAgICAgICAgICB8IEZBVFRSNF9XT1JE
MV9PV05FUl9HUk9VUCAgfCBGQVRUUjRfV09SRDFfUkFXREVWICAgICAgICAgICBcDQogIHwgRkFU
VFI0X1dPUkQxX1NQQUNFX0FWQUlMICAgICB8IEZBVFRSNF9XT1JEMV9TUEFDRV9GUkVFICAgfCBG
QVRUUjRfV09SRDFfU1BBQ0VfVE9UQUwgICAgICBcDQogIHwgRkFUVFI0X1dPUkQxX1NQQUNFX1VT
RUQgICAgICB8IEZBVFRSNF9XT1JEMV9USU1FX0FDQ0VTUyAgfCBGQVRUUjRfV09SRDFfVElNRV9B
Q0NFU1NfU0VUICBcDQotIHwgRkFUVFI0X1dPUkQxX1RJTUVfREVMVEEgICB8IEZBVFRSNF9XT1JE
MV9USU1FX01FVEFEQVRBICAgIFwNCisgfCBGQVRUUjRfV09SRDFfVElNRV9ERUxUQSAgIHwgRkFU
VFI0X1dPUkQxX1RJTUVfTUVUQURBVEEgICB8IEZBVFRSNF9XT1JEMV9USU1FX0NSRUFURSAgICAg
IFwNCiAgfCBGQVRUUjRfV09SRDFfVElNRV9NT0RJRlkgICAgIHwgRkFUVFI0X1dPUkQxX1RJTUVf
TU9ESUZZX1NFVCB8IEZBVFRSNF9XT1JEMV9NT1VOVEVEX09OX0ZJTEVJRCkNCg0KICNkZWZpbmUg
TkZTRDRfU1VQUE9SVEVEX0FUVFJTX1dPUkQyIDANCg0KDQouLi4gd2lsbCBzZWUNCg0KTGVnYWwg
RGlzY2xhaW1lcjogVGhpcyBlLW1haWwgY29tbXVuaWNhdGlvbiAoYW5kIGFueSBhdHRhY2htZW50
L3MpIGlzIGNvbmZpZGVudGlhbCBhbmQgY29udGFpbnMgcHJvcHJpZXRhcnkgaW5mb3JtYXRpb24s
IHNvbWUgb3IgYWxsIG9mIHdoaWNoIG1heSBiZSBsZWdhbGx5IHByaXZpbGVnZWQuIEl0IGlzIGlu
dGVuZGVkIHNvbGVseSBmb3IgdGhlIHVzZSBvZiB0aGUgaW5kaXZpZHVhbCBvciBlbnRpdHkgdG8g
d2hpY2ggaXQgaXMgYWRkcmVzc2VkLiBBY2Nlc3MgdG8gdGhpcyBlbWFpbCBieSBhbnlvbmUgZWxz
ZSBpcyB1bmF1dGhvcml6ZWQuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQs
IGFueSBkaXNjbG9zdXJlLCBjb3B5aW5nLCBkaXN0cmlidXRpb24gb3IgYW55IGFjdGlvbiB0YWtl
biBvciBvbWl0dGVkIHRvIGJlIHRha2VuIGluIHJlbGlhbmNlIG9uIGl0LCBpcyBwcm9oaWJpdGVk
IGFuZCBtYXkgYmUgdW5sYXdmdWwuDQo=
