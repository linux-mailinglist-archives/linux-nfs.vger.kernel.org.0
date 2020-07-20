Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6E02260F0
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jul 2020 15:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgGTNcM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Jul 2020 09:32:12 -0400
Received: from mail-bn7nam10on2137.outbound.protection.outlook.com ([40.107.92.137]:47841
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726675AbgGTNcM (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 20 Jul 2020 09:32:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrKmdv0qjVEjtdQGDJ6amG8f1+VmWY7TtjKlGiqgwDXyVVorZjMYWba6PfdS9JsyKBbCRgeLTNL5ky75y1NytmDFHMLK5OWwAnmEJVwdN3bVBfKKYWY6pF2xBKc3fRgpznI0TRD7wJbj6jTtcYEnGyZqx6KMEy7IdC3MDlAmKSe3HSoZVKAKrBpfAwbGm/sV++W6VF5YRydZ5I+dlziNq2XFL9+yvqlxa8OB3kkk64i5gRkFatCiRpVnpUYbhCq21+rVWP7tRVZ3zt0sJYDfi2sFue0Ye/HuVyOcGEh0uX0X0ciTYk1tMT8QVV6RXNigclUCa2jYHvGYj/m0N9PFIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cGsjijFHBXvG8mh+ChIyHo48KtRgruIyPUqU8HS5GQ=;
 b=UVp5qZhiVLcPOESFNRwKzmMfLks0f9OpMrSbWgG0XRuQyvLSQwgL2vD0ZJ/AxekLAbTQNHuQ/LyPZMrMkUBga3NdDzTpAxzvq7GdLTjYWyuBFkaimWWe8K0DvNhe9KfiIlQ/4PflC9/JK3+Kc00dh1zo1coJab0QEQyN8hglw7dUFni6RxjhIlim+6ajMZpaja5El8F5yiXCXIB12MZ5Vgwb+7tYTGijLEQYFLy1TE2R7m4QLDHqeLSN6og/uxgjJixrJfCTJKOvJRCFXwY4ac4IjDB8foG4TLy+MMUEsKgqmuhut9cRL/1C2LGFtchUajluJvoLOrVb1eS7IIkNDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cGsjijFHBXvG8mh+ChIyHo48KtRgruIyPUqU8HS5GQ=;
 b=QPDzQJPE9u8+s55IuKpQXkPbSt4IsKPFwakPxvHoYUzrgwP7uh51hjYF2FIKn78e5Hd20wE3GZcV/vl666RoyFyQOqdALv06Agd+yrmRWjyHa00+qzdjixtahRNKXJC1pKJgLVNWzlSWthaix7v2hb6qfncgkSXHNqar57pHb5c=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3624.namprd13.prod.outlook.com (2603:10b6:610:90::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.11; Mon, 20 Jul
 2020 13:32:09 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::352c:f318:f4a7:6a0f]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::352c:f318:f4a7:6a0f%3]) with mapi id 15.20.3216.018; Mon, 20 Jul 2020
 13:32:09 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "ltp@lists.linux.it" <ltp@lists.linux.it>,
        "pvorel@suse.cz" <pvorel@suse.cz>
CC:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "alexey.kodanev@oracle.com" <alexey.kodanev@oracle.com>,
        "yangx.jy@cn.fujitsu.com" <yangx.jy@cn.fujitsu.com>
Subject: Re: [RFC PATCH 1/1] Remove nfsv4
Thread-Topic: [RFC PATCH 1/1] Remove nfsv4
Thread-Index: AQHWXnZDItwkYSGdSU+l+U0/hYrlx6kQd2aA
Date:   Mon, 20 Jul 2020 13:32:09 +0000
Message-ID: <ffb5cd64d5d65b762bdc85b6044b7fdc526d27cb.camel@hammerspace.com>
References: <20200720091449.19813-1-pvorel@suse.cz>
In-Reply-To: <20200720091449.19813-1-pvorel@suse.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.linux.it; dkim=none (message not signed)
 header.d=none;lists.linux.it; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4dde1669-7ece-4487-b983-08d82cb14d78
x-ms-traffictypediagnostic: CH2PR13MB3624:
x-microsoft-antispam-prvs: <CH2PR13MB3624D34A6B98DEFA16D42C7EB87B0@CH2PR13MB3624.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6fDamnWX6I4CbR+ZV9oU0xpcOvLtqajy6LkKwqT18LpDlkW8uRVFrATU9Gd/lSNQcWDdn1XIZ5ZgQX/TVs/BQKZjZSF4FBkCoLnCsm3JFjI1dzHEW99VV6RhkOyl7nIHh2PQBqJ244rP5GJdn2Kd6dQ5//N94fBiRPh+7aTdFVdIcIWxguwDs6Pp+/7NWMJKIkUopVdg3rTIepyVd6mh+5zwVQT/5F/KS6m4pNSZrCZy2u7tocZdKWrA7TmQBi5MdaFPuzmoHj1Ub5wKO7hmJW2JSRMlRYuval1XAgeeddSzvEDn9PFBEWXnX+S4Jx9dlBJefHZfl3RUgmH7Q9FiH6nErsdgxgD3uJj00ceNvc472eOrPdXr0KvzPGbmQzD6Lh2jvQaM981b4NRMlJ/xNg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39830400003)(136003)(366004)(396003)(346002)(376002)(8936002)(66946007)(2616005)(6486002)(76116006)(66476007)(186003)(6506007)(66446008)(64756008)(2906002)(66556008)(26005)(71200400001)(54906003)(36756003)(478600001)(4744005)(966005)(6512007)(4326008)(86362001)(8676002)(5660300002)(110136005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 6XsnTyw/96Sh9KRW/eQ7oDHavVgwQuyep8LHk5XnG77SZt3jWQJwWnB/b21wAO3CE/5QxOAA22pOKf7LRuGh/OL7wwVDLsJmjSxBAHppo5Op05jky5RaV7TY2iwtG4HJQ00xB+ru2/SgsNEhTtQjsue6bbS8V3qjK/wbqoa2tkkIsp6SrahK1yd4no7tvIm4su6qgLVoVNjLQxO5PmeAZvUfdM/nWX+Cz3TWbnDzMEST1Aks+jmBF/IMVXdnhPAH9wDCdjUQBUmr22akZe88uNsITk6Sac50rNIkSXWo7XBexuYcg3VpIJ/bNmasn07e3qyfPg3HnABtPpiuLApSCdyLcfpG3+CKieWQBbzWrzSMg3q6u/5ykTdLnC4XJ6CVMgPiTw8Nw1Ydg6M28zTqcRR5KVFOETpIcwpCyD6axfWa8dR8lZGMtAmPqg6pt9pCFzIFEGfFLp9uyvANrMZSRyCjlZGtYSsFvYZnoOvkNk8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4914D0F17BD78449BA64D2F8A50F163@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3398.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dde1669-7ece-4487-b983-08d82cb14d78
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 13:32:09.1747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JFjZ8QQ+7n+XPhP7krZdd38XshGVYi0roZuJvc99E0zv+pOLSTgxD618cvoLL72x8k0pB3p5NHow33JpD54HmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3624
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIwLTA3LTIwIGF0IDExOjE0ICswMjAwLCBQZXRyIFZvcmVsIHdyb3RlOg0KPiBS
ZWFzb25zIHRvIGRyb3A6DQo+ICogb3V0ZGF0ZWQgdGVzdHMgKGZyb20gMjAwNSkNCj4gKiBub3Qg
dXNlZCAoTkZTIGtlcm5lbCBtYWludGFpbmVycyB1c2UgcHluZnMgWzFdKQ0KPiAqIHdyaXR0ZW4g
aW4gUHl0aG9uICh3ZSBzdXBwb3J0IEMgYW5kIHNoZWxsLCBzZWUgWzJdKQ0KPiANCj4gWzFdIGh0
dHA6Ly9naXQubGludXgtbmZzLm9yZy8/cD1iZmllbGRzL3B5bmZzLmdpdDthPXN1bW1hcnkNCj4g
WzJdIGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwL2lzc3Vlcy81NDcN
Cj4gDQoNClVubGlrZSBweW5mcywgdGhlc2UgdGVzdHMgcnVuIG9uIGEgcmVhbCBORlMgY2xpZW50
LCBhbmQgd2VyZSBkZXNpZ25lZA0KdG8gdGVzdCBjbGllbnQgaW1wbGVtZW50YXRpb25zLCBhcyB3
ZWxsIGFzIHRoZSBzZXJ2ZXJzLg0KDQpTbyBpZiB0aGV5IGdldCBkcm9wcGVkIGZyb20gbHRwLCB0
aGVuIHdlIHdpbGwgaGF2ZSB0byBmaWd1cmUgb3V0IHNvbWUNCm90aGVyIHdheSBvZiBjb250aW51
aW5nIHRvIG1haW50YWluIHRoZW0uDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMg
Y2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3Bh
Y2UuY29tDQoNCg0K
