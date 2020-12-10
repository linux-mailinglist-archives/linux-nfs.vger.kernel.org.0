Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE922D5E30
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Dec 2020 15:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403788AbgLJOnk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Dec 2020 09:43:40 -0500
Received: from mail-bn8nam12on2105.outbound.protection.outlook.com ([40.107.237.105]:8057
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403781AbgLJOnc (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 10 Dec 2020 09:43:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzVOc+ziE9v1AEB2yIV+73FJM33EqwLLlVmKkEc2BCmZm26/J/lqQM4yK4xWQqDDJz6tINKkyLkGXGlQf1VgG6prLiH5AgsbkP+BWJOgCuyhC9ZYjXTnZS3l+o8OOf+X6ZhARi1G5frrQfqv3cVAz9j4itZYm7IwZNSIkv/VcunMa4cJgQpm9Oqt/e/8ZFpSi/Uv2SUP1/0oTxjkan72Fy9+c9Ton2nwL/CXjNRXTZiZplmjNLucY4q0NUDu8lGZmltpd97Cu7C53zUljcadKspLS2W5KNHGphtRoWikS0GthcduHYokztI4RkZRzqMns74dmPdKA8nBDMxzIPOG8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJjt9oLCITT35NJmN9b8lBP4T/1sohrHN+apvndhpcY=;
 b=CvXXh7MDtZ8eBzbFKCnRy5PsvtNxxZWZlX9+YgApKw1MgNk6Hd0jB35LAl35ZdPUmubL4IUO880e/ILMZHWzeHVoSio6flTuyxuocUX6SHI86IhoUrZTkrwPA0TQ3VYsaw2qrw9qIeVKPD8x/2KYJVc3T0bUWSuL1boq6wnfucZJ4xVH8UxlVEiSAfph9HRwYAZW+5adgcJyFF7bfN++cShuDZjYUZk4TzCxmxi4w2CTIkwfGkeTOYcZOkT0C0qen6i60J33Qaxyt4AlkzoWqj1Tlc3SR5Cg4fYqIF1FrtZ7JhlHb/4mTnSDY28YAUwGggB1GRnD0N4RLwiB0qr5PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJjt9oLCITT35NJmN9b8lBP4T/1sohrHN+apvndhpcY=;
 b=djTUavaVjIPaN+04Skkpg33o7l6et7Ecn+e4uEtk3jtiuy+4i+/y90NlexamXAXrnMVYtFgpRs4Qbwbb5vnbgXA0ti+WGH16La+AXOf6ctmvScmQ9SzLVKo16dh5UPbg2qjvU5wmo3HY2QlA+y9sy0vhHO0H5zAGJm1WCnrGALw=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB2927.namprd13.prod.outlook.com (2603:10b6:208:151::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.8; Thu, 10 Dec
 2020 14:42:38 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3654.016; Thu, 10 Dec 2020
 14:42:38 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "tigran.mkrtchyan@desy.de" <tigran.mkrtchyan@desy.de>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
CC:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH] nfs41: update ff_layout_io_track_ds_error to accept rpc
 task
Thread-Topic: [PATCH] nfs41: update ff_layout_io_track_ds_error to accept rpc
 task
Thread-Index: AQHWzuMGU+9gXPTj5k+OuFz3grt7VanwZ6AA
Date:   Thu, 10 Dec 2020 14:42:38 +0000
Message-ID: <e7c1fb7d7b658782a73616670f4c072db029ac53.camel@hammerspace.com>
References: <20201210105543.22489-1-tigran.mkrtchyan@desy.de>
In-Reply-To: <20201210105543.22489-1-tigran.mkrtchyan@desy.de>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: desy.de; dkim=none (message not signed)
 header.d=none;desy.de; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67c25c68-3ac8-49f1-7c31-08d89d19d752
x-ms-traffictypediagnostic: MN2PR13MB2927:
x-microsoft-antispam-prvs: <MN2PR13MB292758800F0DE1B23D8B36EDB8CB0@MN2PR13MB2927.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iB4O1nU4NnS6vvLTVtTSuRG/9P9lkVdMnqvCyU7/PdUvASQEsgjTizQz5yQMYU9A4KxfGm8ncBGVznDM7w7/sBjNaL9lkq5swixjKOb7zFaBisqoH0BV6YnERcyYWpAulCmzYcUCE6mRzX/XpQ2TVztPDMajqLQJB3o5Wa79IzqrzkXYt4sf6lBCLuXLtnkDvFVy7GWm2hWHCiJW6rTkEpgZ2SLfc+RsMmpmk/o+6mN/hKMXKx92rLhrBmZof8Gp3atiOMTbxPqDaBqSZlg7Sb87ONcxfkgBrb1+sPVwk+zWJHiDaAb/5AHBkpxqyNNASgSrMRdcHfqHaOKAbEjKHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(366004)(66556008)(76116006)(36756003)(66946007)(110136005)(91956017)(66446008)(66476007)(64756008)(4001150100001)(26005)(6506007)(2906002)(15650500001)(508600001)(2616005)(4744005)(83380400001)(186003)(4326008)(8936002)(8676002)(86362001)(6512007)(5660300002)(71200400001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZFVLb0tnSUZ6TnYxaDBPMmlQSURZZHU0K3NpUnBEa3NpNlZDNVE4aFBBdkZh?=
 =?utf-8?B?MGx2SG5zZDU0emhzdGs1STBtTHEwQkZicGtRNkRNaGxmZ29LeFRlYkJHY09J?=
 =?utf-8?B?eStGL2VmcWFvY2JzVnVwSDZWSDArOGRqNlJKM1hZd01SOUZtbnBoZ0psb0Jt?=
 =?utf-8?B?bWpGb2NOSVN4TDJlQ1h1RHRrU2RlNEdGVVltVWx6YTBpV1RtaXZoUWZCazFa?=
 =?utf-8?B?bHNZVWFVOVllNWVud3B2TUQ0SEdNaFp2TkJkZEw2cGF5L0VYZGFLL21mNFYr?=
 =?utf-8?B?RGNwdDlIRUZuY2ZTVmxtUnFKM3ZJak5remhmMU04WUZONTFwZVFQYjFsSnF4?=
 =?utf-8?B?a1lHOEs5RkVwMytiMDVnWDQxK1J6K0J4MzBpKzZOeVhEazlBUlEvRS92UkIw?=
 =?utf-8?B?aUVtMnFJYU4yVHJDeklvTFduODBwQzVoN3VFZmdJTUhMbUIvWDJxcEZXdFoz?=
 =?utf-8?B?cVRkM1RabCs0WXpXTnk4aEpLYXZ4bm41d0JlUU1JbUk5MUhYMXk1T1RrZFFk?=
 =?utf-8?B?bnJ2eWtSV09qWGdnNWsxRG94SnAyVGxTYWU1YkpLaWRqRG5JdmNSbXJZb1ha?=
 =?utf-8?B?UE5XYThENHpPRmdFSjdkNFlEb1JBZGdCeVJxZXQ2dkRLSUFtb1haNmRwNUJy?=
 =?utf-8?B?b29zODRoengxTm1tUmdMVldDekNHNTFmZnVuNGZDU1ZOR1poYWJLR2IwTnB4?=
 =?utf-8?B?R1kvZFhDVllORHNjWEdXaDRwMG8xZzZtc3RHTGJydGJ1YkVwWXpLL0tmMXp4?=
 =?utf-8?B?ckVNVjl5algxUlNxWmdyQWRydERvZDIrUHlkWmE0RUFlcURzbWZpQUlNdGpi?=
 =?utf-8?B?SjNmUEVibTRjaUc3YjZMRzN5clhJMHhCWXVxbmlFc1ArWDFlR3J0LzRMRXlh?=
 =?utf-8?B?SFdxZGxwZlU1Q0tpTTdpYi9ybStrZlJIQXdXVlY1RitZZllBbm1yUWpWVHVM?=
 =?utf-8?B?SytaL1NwcVRDU040bDlxWU1XeFZ2NVJhYnY3WFVNa0w1bzc1S0pGUVRyaEht?=
 =?utf-8?B?Qm5TTCtCeGlRZ0N4THpzS0tIb1Y1TUsxKzFXYnI0QmE4aXB0QS9JY0ROZmtZ?=
 =?utf-8?B?dmNWNWUrRXpqWDkvUFdUUUljZldDVldCMm1tVk85d1RNeUl1R0VneVFtclQ0?=
 =?utf-8?B?QzBnZXVhZ3kxd0ZBcS9xYmpIYXVJZU1GcG5lUm53RXNOZ0J5ZW8vNC9uNXpn?=
 =?utf-8?B?N2ptZEV5RlRZRXF3dlFDblpqZ3RVUmxHaGRuUGtDT3QyU01qNmZyaUhhemth?=
 =?utf-8?B?MDRqZHB5bFpmWmpxamZpQUpXQkk4Z29oUkJSYmtFVStobzkzNHV6SEo0WUJY?=
 =?utf-8?Q?7GYrJidPs0PK+weaM+u9lx4oY+TTYQP1v/?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED274FA9C8BFD444B82CAA9AE7488676@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c25c68-3ac8-49f1-7c31-08d89d19d752
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2020 14:42:38.3263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Cagjr9PXuRFbyJNGaG0zIz/JRFUGawCiUBxJNWDx517z0ZS9EzCHE55PB+NPzyr186uwoIaxB9nAptsOb+oZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB2927
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgVGlncmFuLA0KDQpPbiBUaHUsIDIwMjAtMTItMTAgYXQgMTA6NTUgKzAwMDAsIFRpZ3JhbiBN
a3J0Y2h5YW4gd3JvdGU6DQo+IFdoZW4gZGVidWdnaW5nIFJFQURfUExVUyBpc3N1ZXMgc2VudCB0
byBEUyBJIG5vdGljZWQgdGhhdCBsYXlvdXRzdGF0cw0KPiB3YXMgcmVwb3J0aW5nIFJFQUQsIHRo
b3VnaCBSRUFEX1BMVVMgd2FzIHVzZWQuDQo+IA0KPiBUaGUgZmZfbGF5b3V0X2lvX3RyYWNrX2Rz
X2Vycm9yIGZ1bmN0aW9uIHRha2VzIHRoZSAnbWFqb3InIG9wbnVtIGFzDQo+IGFuDQo+IGFyZ3Vt
ZW50YXMgd2VsbCBhcyB0aGUgY29ycmVzcG9uZGluZyByZXN1bHRpbmcgZXJyb3IgY29kZS4NCj4g
DQo+IEJ5IHBhc3NpbmcgcnBjIHRhc2sgYXMgYW4gYXJndW1lbnQsIHRoZSBib2doIHZhbHVlcyBj
YW4gYmUgZXh0cmFjdGVkDQo+IGluc2lkZWZmX2xheW91dF9pb190cmFja19kc19lcnJvciBhbmQg
cmVkdWNlIGEgcG9zc2liaWxpdHkgb2YgY2FsbGluZw0KPiB3aXRoIGluY29ycmVjdCBvcG51bS4N
Cg0KSSB0aGluayB3ZSBqdXN0IHdhbnQgdG8gZGlzYWJsZSBSRUFEX1BMVVMgc3VwcG9ydCBpbiBw
TkZTIGZvciB0aGUNCm1vbWVudC4gV2UgaGF2ZSBubyB3YXkgb2YgZGlzY292ZXJpbmcgYW5kIHRy
YWNraW5nIHdoZXRoZXIgb3Igbm90IHRoZQ0KRFMgYWN0dWFsbHkgc3VwcG9ydHMgaXQsIHNvIGxl
dCdzIGxlYXZlIGl0IG91dCBmb3Igbm93Lg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXgg
TkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1l
cnNwYWNlLmNvbQ0KDQoNCg==
