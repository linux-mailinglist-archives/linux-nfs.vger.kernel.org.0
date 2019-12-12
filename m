Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C148011CEAD
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Dec 2019 14:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbfLLNpd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Dec 2019 08:45:33 -0500
Received: from mail-mw2nam12on2107.outbound.protection.outlook.com ([40.107.244.107]:40513
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729392AbfLLNpd (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 12 Dec 2019 08:45:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOViPhT4CjhjNGmB/FR+PJ7oWwU5ER+2E0dWmiy04Ebg24rE44BQqeWgJdNsP7yBI+BVqQh3/V5lgtfRK8ilAarvci10mxAq2WxG0yoVN4hVRUrSVooOSf9jdY4LYP9s1OYmACk9Iw+l6FNpCfCG0EGo+DxMS9ug6Yzupem3Zp1zRFjqeHXQ51+QDTgG6RGdQn/4tr5OMKwAgKqt9BzmDPLZrnUcdvI4jP9r9+BE0xciuS3OaDvbJyhO7cYFyedrbLCIlhPAgVgk+dXjMjPZS30uzz9ZR2A4A7mVAAOEN+Oj7MwR2N+GLjkU6Sri9Xr3elmIDFhO62atJahLvdCZbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXDFNXOMtyfqRJoqpL6MDqc7Wczvuf8vznYe0n4ZY+I=;
 b=J0NKy4NBS48x/HaGD0uqfRxF/kaDGwVyDfOYbYuEBL1bRK/QijTAC+8voUEZeLTzTi2OlIXRP/wOQxN4kTRgxJcYNkvJOWuP920beB7nCuu5u+rk4FVER5UU3NT38Z6Y2ygFu+FQDd1NwkVARQnhgRs+X02SZkDVycSfrgOmXijHxLrtQ+4l3kD6E8/iBJI/ae5cg+wLiPS3uOMl4SOp6ZmzIUwDLRBD9D5DdhKSElddER8g4QeOi6HNt1dPfJOO7NTtBFCf97zFmPG7C1H99f3IE/7azscASZp8Z01/JudzTivFtELf02FNt1hRy3isy/rxDod3v74hQfqfkLhqJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXDFNXOMtyfqRJoqpL6MDqc7Wczvuf8vznYe0n4ZY+I=;
 b=RjG14Yi+YgeXTtGtBZWms36bB7AWuGX52AA26xjk/CBCIV9ttTyCZmaXWQaCodQfgFRvOdnud6muElqJctdKelmcjKIZJvI4StjhXznZls2dxi4Po1h5XErE0/IpA5FAllf13Ci5vunk7iBTtwoz7Hs3ONVzeMkh6Ees7zj6WLw=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB2025.namprd13.prod.outlook.com (10.174.186.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.11; Thu, 12 Dec 2019 13:45:29 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d23:b456:d67:f230]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d23:b456:d67:f230%6]) with mapi id 15.20.2538.012; Thu, 12 Dec 2019
 13:45:29 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "madhuparnabhowmik04@gmail.com" <madhuparnabhowmik04@gmail.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs: nfs: dir.c: Fix sparse error
Thread-Topic: [PATCH] fs: nfs: dir.c: Fix sparse error
Thread-Index: AQHVrx1GhpnK5B8ObEWj1ayFx8ZCxae0HusAgABxqwCAAVZfAIAAn6KA
Date:   Thu, 12 Dec 2019 13:45:29 +0000
Message-ID: <5614739335088d3e9baff43b752df04b84a8ad14.camel@hammerspace.com>
References: <201912110621.WJ6oENgf%lkp@intel.com>
         <20191211074842.21400-1-madhuparnabhowmik04@gmail.com>
         <20191212041406.GT2889@paulmck-ThinkPad-P72>
In-Reply-To: <20191212041406.GT2889@paulmck-ThinkPad-P72>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6730210-7e93-49c9-9ed5-08d77f098d10
x-ms-traffictypediagnostic: DM5PR1301MB2025:
x-microsoft-antispam-prvs: <DM5PR1301MB202520B52BADE4C55838DA93B8550@DM5PR1301MB2025.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(376002)(366004)(396003)(136003)(346002)(189003)(199004)(110136005)(26005)(186003)(4744005)(36756003)(6512007)(2616005)(86362001)(5660300002)(71200400001)(508600001)(81166006)(64756008)(66556008)(66446008)(6506007)(6486002)(4001150100001)(966005)(54906003)(316002)(81156014)(76116006)(8676002)(2906002)(4326008)(66946007)(66476007)(91956017)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB2025;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r3VN4tx5S580MpVCryx2gLWDwjCSz/N8JvtVFzcxoh7rq07GGy4oPZPJCL8yc+p8n8iBZeY9A7kaicK1i48gJvTgRyWcTFwMFcbAA21fXlkjueqALU0fvDSAIJGGH4nz+CnKAndPfOYGDQuBEuspVZVxh/3Lpd+1fDjkRtBzgeTzagyI91rDCxbym9bV6LavqosW/c4ZoRLw1LPSs1LCWRzGm213SWhFk8jaqBgMnqHmc0125fSQrCQEcOwiecSnLDbOfGL9PPOPIITk0H+M+qgh1q+U7M5VZdKy5wLm36xHvmMOO66MoDEGVWBcOuhVygK36Ks9WryAFpua/7IwIS5iiwB6YPvruh+8BHnYaAVQY2ptek6SGjgSfsOQIXDacCWH58CN9c3Yr5GDbAP7hFMh8b6r+h6Vx5GO5+jOZgSilmKFsYs4HUPfXCyUdNLK
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E58661FD5D40E2428E504984389359BB@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6730210-7e93-49c9-9ed5-08d77f098d10
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 13:45:29.1725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X0vRXfpDnDQAJSpbB9qU38mIG+WGUXYUibI6BOit3hiz0hS4k6FsV0xFpe2YGOypuICz3zIVuVini8D2HLzQfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2025
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDE5LTEyLTExIGF0IDIwOjE0IC0wODAwLCBQYXVsIEUuIE1jS2VubmV5IHdyb3Rl
Og0KPiBPbiBXZWQsIERlYyAxMSwgMjAxOSBhdCAwMToxODo0MlBNICswNTMwLCANCj4gbWFkaHVw
YXJuYWJob3dtaWswNEBnbWFpbC5jb20gd3JvdGU6DQo+ID4gVGhpcyBidWlsZCBlcnJvciBpcyBi
ZWNhdXNlIHRoZSBtYWNybyBsaXN0X3RhaWxfcmN1KCkgaXMNCj4gPiBub3QgeWV0IHByZXNlbnQg
aW4gdGhlIG1haW5saW5lIGtlcm5lbC4NCj4gPiANCj4gPiBUaGlzIHBhdGNoIGlzIGRlcGVuZGVu
dCBvbiB0aGUgcGF0Y2ggOiANCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1rZXJu
ZWwtbWVudGVlcy9DQUY2NUhQMlNDODlrOUhKWmZjTGdlT01SUEJLUnlhc0NNaUxvMmdaZ0JLeWNq
SHVVNkFAbWFpbC5nbWFpbC5jb20vVC8jdA0KPiANCj4gSWYgdGhlIE5GUyBmb2xrcyBhcmUgT0sg
d2l0aCBpdCwgSSB3b3VsZCBiZSBoYXBweSB0byB0YWtlIGl0IGluIC1yY3UsDQo+IHdoZXJlIHRo
ZSBsaXN0X3RhaWxfcmN1KCkgcGF0Y2ggaXMgY3VycmVudGx5IGxvY2F0ZWQuDQo+IA0KPiAJCQkJ
CQkJVGhhbngsIFBhdWwNCg0KVGhhdCB3b3VsZCBiZSBmaW5lIHdpdGggbWUuDQoNCkNoZWVycw0K
ICBUcm9uZA0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFp
bmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
