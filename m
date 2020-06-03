Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3BE1ECB49
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jun 2020 10:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725275AbgFCITX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Jun 2020 04:19:23 -0400
Received: from esa4.fujitsucc.c3s2.iphmx.com ([68.232.151.214]:7644 "EHLO
        esa4.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725876AbgFCITX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Jun 2020 04:19:23 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jun 2020 04:19:22 EDT
IronPort-SDR: Rwm8T64k0zHQGTYrUtv97/O+6IUhMDQUS7PptmnX+GhmHNC9Lfeca21OfWmmQxIthLXp87Z/J2
 E5RINahqT/fwjGgjxpTqCA7OW8AIrmOTJiz38lgljWm9Q8rYxDlrKnKVIHfbmIO7RUn7KtXwqZ
 tpeana72a9CIAv8o6M7dPyHKBwrSEwoz7lLvBucVMxrFK8Ru4y49Z4J83DDmiXQSt2GjkHddig
 441U9ccvz0h9Gt1pwxaBys2ucSUOCLewChvjugVf1kspJdoxiwKo1s5wUDDetbeCg/jV+yQef1
 XfY=
X-IronPort-AV: E=McAfee;i="6000,8403,9639"; a="22000327"
X-IronPort-AV: E=Sophos;i="5.73,467,1583161200"; 
   d="scan'208";a="22000327"
Received: from mail-ty1jpn01lp2059.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.59])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 17:12:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UiRggyAXeVfX399Yu1KC6PLUHKPL4Rh3GKjcm+EWZIqdYxcJDMMaJV7KSfCeF+As5e3+rewM+HKzV5awd0gXcZ4RkiAU4QBmIqX2tLALbguuiKDvZzxqd0rviR0yqr5jvQo0IX1rhx1CmOTjKjTqJAsPh/U425/2V0hT1Q5VMchUy57xT4HdT1wW2CP8aijhvTbQivpr14TKFLL5hfoklbqnv8TF2SBhDyESAvRLmmWI+Tx+leFvTZ5mkCTMG7FVzJWm5EATmOFlYlywjAF6cfT/wSwN9dy0JC6S0lz2lAWOSy6C4CSInPQPUZUkjQAR1Swj05nrW11Q3BEm78KsBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNWmYYIpCQJ09CF/8o1Yx56OKTqaPgzJRtN435YI1KQ=;
 b=S+t11weE9CItRWUvp8uoMJWe5b/6TtOLt+BnTSFIP/aLlk+hzLwWvUDJ/0VJsHpjXYDBo4+R0WxHCi24EvgsYQIYeYPer8ADGiYvRaDigeHzTUBwJKS5tCfzCCrm1fr8hWtq1FS+x2ZQOBAC++86wUp76aPYthNvPlVltM7TsEo39gzUMGcBsqImh+yI9WdoOFFvBqT8nn9DMBDoQMeWNpO5xS7b3dLxHSI5URbSIWz08NTYIg7GHLCYMD6L4et8snZBHzpFC97gld8QHMQq5dgG2DxvjGyM2Vvwn/w6YLcvYPPq3JJ8cULB0edRGjTtCIYEz5AiTXAO7rcR0AJt9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNWmYYIpCQJ09CF/8o1Yx56OKTqaPgzJRtN435YI1KQ=;
 b=LRBMr/oKr5Qq0zEx+r0+D+3mgLf6JD5Rx+US9w+DD1tTp54vaY8dPmwo0vmaiKQBwu9VvkLhs6Q2CrFKVvT8Izz6b+oMKC7eVA8hHrA0NPnReRgKfxW5vcbMffTQz2xTrXndrTOjZFL+VNx6TeFPBQqPQpjodWrYmom3gt+oVIs=
Received: from OSBPR01MB2949.jpnprd01.prod.outlook.com (2603:1096:604:1a::22)
 by OSBPR01MB4789.jpnprd01.prod.outlook.com (2603:1096:604:75::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.21; Wed, 3 Jun
 2020 08:12:09 +0000
Received: from OSBPR01MB2949.jpnprd01.prod.outlook.com
 ([fe80::8972:39a6:4929:bc25]) by OSBPR01MB2949.jpnprd01.prod.outlook.com
 ([fe80::8972:39a6:4929:bc25%5]) with mapi id 15.20.3066.018; Wed, 3 Jun 2020
 08:12:09 +0000
From:   "inoguchi.yuki@fujitsu.com" <inoguchi.yuki@fujitsu.com>
To:     "'dros@monkey.org'" <dros@monkey.org>
CC:     "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>
Subject: [nfsometer PATCH]: config.py: Add v4.2 in NFS_VERSIONS
Thread-Topic: [nfsometer PATCH]: config.py: Add v4.2 in NFS_VERSIONS
Thread-Index: AdY5Y01m+6kUgTh/RbmpQFAQFx5QAw==
Date:   Wed, 3 Jun 2020 08:10:59 +0000
Deferred-Delivery: Wed, 3 Jun 2020 08:11:26 +0000
Message-ID: <OSBPR01MB294973D46ADE4ED7A7D3E19AEF880@OSBPR01MB2949.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.6.3
x-shieldmailcheckermailid: a3f2d3da91304999be207ea0aeb54aa1
authentication-results: monkey.org; dkim=none (message not signed)
 header.d=none;monkey.org; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [210.170.118.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca876107-8c4b-4f1e-66f0-08d80795d047
x-ms-traffictypediagnostic: OSBPR01MB4789:
x-microsoft-antispam-prvs: <OSBPR01MB47897572A0EAE48B209A1003EF880@OSBPR01MB4789.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-forefront-prvs: 04238CD941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tUuC0ON4mcs9L8SqH4bBPiS5jFn5d2dIYQ1DTp/PFHMeQbQIuEUDAUW+d1EiFhNJVyiGPowCJc7mOq5ciCtj3Bk/zxgADLHCfORj5fi/LNdBwsR7Bv42BbF4A+Ijf5xmHZo9i7yEA+W4C52Uf4XfHgsKNaqto9vxTy4tA+HaFOjJYC4PI4au54JTYrMeonGXISalgeaALng+gcYvW9zyrbtuEUMJCVtomz7QJO9ZNpKAsq+ghELpjS1rXR/XNvlH81TO66yjP6oPFm+cFP0+U2aEk39Q9flvWoVf2Tg8YWbhwWHQsgS4CNR3Yiv81ZNtpPxUO4fTAbYZuhhm1jd5WzYimPQ56sJgl80/t4a/gQA6dxPA7UnBoE5qVJtQgzp5uVBDaT9p3zNuAsJ9qfQ6Qg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2949.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(9686003)(8676002)(71200400001)(4326008)(8936002)(5660300002)(6916009)(6666004)(55016002)(316002)(2906002)(26005)(7696005)(86362001)(66946007)(4744005)(64756008)(66476007)(66556008)(33656002)(6506007)(186003)(85182001)(83380400001)(478600001)(76116006)(66446008)(52536014)(777600001)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: IivP50a1tAitXSFxQemTOsSksiBNqt5WHwbGUr+LNbkUWIMZZ1GaG3e2YKKGAEmoI/YIr/51qYudadSIhkSYAvwAfowhoUPgV2kH8lKF0mWctLZ9W3sVOpwkKm5KG68rZTzhz7KP+ugpcFVwbh5bUf/8loW7wqTQ8sfJdoq4Orpts+RLceMZC9POTxVAzp+KdA8JlZSJ6Od/EajbTwfrY693S5piXuoZE3JDHxLqq7kdTrYA108dmKZvEtA5mE/+QIThRuKzZKSZKh/a77DHMgi9a47I0FXHnZPFx+UC3Li7kzsW6Pf8Y98ZCPi+KoKVsUak3NtWilK7897dZnNrd4Jgw8f4wwE1Evi9PrECHgEt0kwS4rj2iNczKPRmlt6EDDCsw2rICOBaFZhYgAPLKMv9uoMO4lkoex0WtSDKq5V0Nb0hBUnoxTqXHlN8hWB5SqpVomY3BfK52g284Lqu+pYBDYiRHy6dPSSnYByrisSiZs3vdEfSlK63WKy6klRF
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca876107-8c4b-4f1e-66f0-08d80795d047
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2020 08:12:09.7614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mXmfnUHrJjrHPwMNrAOzrKd5HS/qKRgbdUTpTNKxdAdPiJZ8EOgEbEdSPxo2HwOQWPz4sG75N8TGMvMZKsuljiGK5rieqdGVOhfi6OXktHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4789
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

To make a graph of NFSv4.2 in a report, I'd like to add v4.2 in NFS_VERSION=
S.

Signed-off-by: Yuki Inoguchi <inoguchi.yuki@fujitsu.com>
---
 nfsometerlib/config.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/nfsometerlib/config.py b/nfsometerlib/config.py
index 76d74d9..0873052 100644
--- a/nfsometerlib/config.py
+++ b/nfsometerlib/config.py
@@ -162,7 +162,7 @@ DETECT_DELEG=3D'deleg'
 DETECT_PNFS=3D'pnfs'

 # valid nfs versions in normalized form
-NFS_VERSIONS =3D [ 'v2', 'v3', 'v4.0', 'v4.1' ]
+NFS_VERSIONS =3D [ 'v2', 'v3', 'v4.0', 'v4.1', 'v4.2' ]

 # older clients need vers=3D (minorversion=3D) syntax
 NFS_VERSIONS_OLD_SYNTAX =3D {
--
1.7.1
