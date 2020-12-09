Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B552D479C
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Dec 2020 18:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgLIRNl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Dec 2020 12:13:41 -0500
Received: from mail-mw2nam12on2110.outbound.protection.outlook.com ([40.107.244.110]:59040
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732409AbgLIRNl (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 9 Dec 2020 12:13:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WFH9l5FpPPbYezUwpSDitxflTV92QeEafuIoIAk92jCE7+0v2FSAKN45dsxkqfEDa0lDiUD0OUocXNvBRE0voH5dn01YcwYL6yTQ7p7NBTcybQioXkHd7ERY9l2R+DZXnUMP1603jMbZUyP2Fe2lu8L2tx4CPRTEnqD+HJEX+KRcOXTxIwKI7cIMC65UJcGYG9vu7XoG+FYIFc9bLDPWtMeyQfqcRcbkHdh7/FiMs9zlohrLyAe0kFU1CFTSwdWHbqPzKR0YHqjqjQgKC2qCvyleUB9gZONNqlGol8O5dprOz09ueeJKdNq9DiWmu+UTI0gzptFTPtEO9O6O0v+tSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NU80zeJOur1mWHBrP+0ta+k9iyMHX/Es426DJuRd3PA=;
 b=G+CD5zNWD36+ok9e2LTkRQ0pU+G8evT5Z5Ef/Z83cPx68qP2cEOEtYuOIlH2BqZFFCWwhIy/mzmNjKtj8t0Ly2jgWpNIZLfHQEMTRZfDOyLyXIXerh7pJ+7Mf3BZZ6EAOGpTZpXki9Z12Iy9Nm0cTJCNSVD8JTv/x3SaXeoANcVtdx+3PcaSQWPogJVw/qcPIiIyALVGiNXDprIp6TdM/VijYhwpF0YwIIAa/e1QLlhwl8r3t4OoQ3UiC9TsIiVYdtyH3sQCa2rWtLrZS820pI9IFU20DH2EY4Ktd9dM8wu9UrXp1/5AEhYcMJiO0A2UwmsFHkfde6xnkDx9hosVaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NU80zeJOur1mWHBrP+0ta+k9iyMHX/Es426DJuRd3PA=;
 b=OUfOkQRLq3ScttxmdovkA+HgRcmpCQzDPRHlLEKj8B289K6fF+RAg5enITn8I+sXSDlR4BKAsNOqoHSp5YCULIsllQKOPKjZ4gK0U3pqQZdiaecWsnYgpIHziOZB1z9V4exm3KmRVnxCtWK3ugfSTXQusbZlSf+beNTpd746lSg=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3407.namprd13.prod.outlook.com (2603:10b6:208:163::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.5; Wed, 9 Dec
 2020 17:12:46 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3654.009; Wed, 9 Dec 2020
 17:12:46 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "aglo@umich.edu" <aglo@umich.edu>
CC:     "tigran.mkrtchyan@desy.de" <tigran.mkrtchyan@desy.de>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>,
        "schumaker.anna@gmail.com" <schumaker.anna@gmail.com>
Subject: Re: [PATCH 0/3] NFS: Disable READ_PLUS by default
Thread-Topic: [PATCH 0/3] NFS: Disable READ_PLUS by default
Thread-Index: AQHWybGmaIjlThqGT0GKib773fRGxannFjQAgABGpgCAB6kDAIAAAlcAgAABagA=
Date:   Wed, 9 Dec 2020 17:12:46 +0000
Message-ID: <a70034b9506c650aa10480727f9f5e00cc71e25a.camel@hammerspace.com>
References: <20201203201841.103294-1-Anna.Schumaker@Netapp.com>
         <852166252.2305208.1607096860375.JavaMail.zimbra@desy.de>
         <CAN-5tyFJeLRyDUdtGkheGkmDE=i-FJprLFiav_mEPA35QeKLQA@mail.gmail.com>
         <14eac8ec352c76206c811f75b130957bb75ff590.camel@hammerspace.com>
         <CAN-5tyFwgWTBsCOBJ=7ELS4md4SBgiMQ4EPAS7LCxzCK74X13g@mail.gmail.com>
In-Reply-To: <CAN-5tyFwgWTBsCOBJ=7ELS4md4SBgiMQ4EPAS7LCxzCK74X13g@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: umich.edu; dkim=none (message not signed)
 header.d=none;umich.edu; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 725935df-2c8e-479d-9459-08d89c65a648
x-ms-traffictypediagnostic: MN2PR13MB3407:
x-microsoft-antispam-prvs: <MN2PR13MB3407859D4AEFDE4D7532B647B8CC0@MN2PR13MB3407.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /a1ytmyYqXk15mpDuXpRC9AtfTU0JsqABPVwT20GyKTUeMfJFZjpm4dc4y/2NOq0I9YRwvLiduekY+XC0sAsvsU3t4ChNmKAgq4t1Pym7kPKiqnwpE2IkMEuoYDwljageg0prDm2mtSLyJ4iPE1dIYcMb6Bvfj4sZpyPetUPP/GRNgR4QRY0w2Rm0Oqg6FKqj/X3q8G9yanfzu1/pW2anHLGuJytJfp4AwHFIH9gBMItv4Lbz2Ub58UJPlqnSwCGkDrjkRFVVeYN8xJYGrvlxvptm8BlgKCptSo81pqJoFGsM3XuM20iPH08P0G133mG5Yoqliqg8tY4jNYjQ59dsQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(376002)(5660300002)(76116006)(53546011)(6512007)(8936002)(2906002)(91956017)(6916009)(2616005)(8676002)(4326008)(71200400001)(26005)(36756003)(6506007)(186003)(83380400001)(66446008)(66556008)(508600001)(86362001)(6486002)(66476007)(54906003)(64756008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?QWR0R1RMaUFtUmJMUEN2ME96MkhwS3FqNGM5VnZJUXVKaWlyTGFRRC9WVFZ0?=
 =?utf-8?B?Z2dac25LOXdpbXpEK1ZWUytHa1hsRU5QWVY4T1JGWmEvRFUzczkrRjI3ZzhI?=
 =?utf-8?B?QWxlRkZQUDJWV0Q4MlBhNGpVdFgvYnBnbXVOVVhqMjVWRm51UUJPY083L2lV?=
 =?utf-8?B?MWtmT1QzOFVOOVBwNVFNYThnYmdRVzZLclRHYmxGY1hibHNUVnhKMUNUWUdC?=
 =?utf-8?B?eWtqeXQyT1VSVndvdndSTTBXd2JNSGhxcTV6NW9SK2tDdWt6aUw3bERhSVdq?=
 =?utf-8?B?WWNEZFErOThqdDA2QTdKOGRwTEpqSzZhSlRxdllCdm5ZOS9BdEZvanJlTkQ1?=
 =?utf-8?B?eXU5NE5pKzB2SUVpOForYWNUZExtZ1ZWTXMrdkc3YURkZ0drQ3Q1VkF1bk42?=
 =?utf-8?B?K0w4VTcyZWdRRGJOQUJXZ25MSkZOV0pmTDVOb0FJeDNXMk5JeHZPTTBJRnVU?=
 =?utf-8?B?V2sxVll0anUzL2p1Rm14U0RPM3NXbDhxNlZZc2dQRGNjdzhHQk9tWkxBK0Qw?=
 =?utf-8?B?OXBRR2pla3dUbDhZenpYQkk0aS8xb1V6SWEzQTRjSXhFYjVUKy96dU03VUIv?=
 =?utf-8?B?RWNNL1YyRmpyL0N0N1pDZkpBd0VWdnhqelFWL0h0RnZVOXFjaUtneGdLYlc3?=
 =?utf-8?B?VTVoSjB6a3ZXYVI3eVBNMU92eWZqdkdzR2MybFY0Y204aXJLR2J1T3lRUnkz?=
 =?utf-8?B?bTI4Uk4vOTkzRTlEaWtBREZtYlR1UGM1WmoycjJjTGZtVE1ZMXhXekhLQi9o?=
 =?utf-8?B?MDFMcGNudVJ2VzZIWjNLQko0Uyt6cjhLRzd0T3djdFJJOXNwaWJBZ3hGd1VO?=
 =?utf-8?B?bEtrSzZsMjhCMXA0Qi9QandvVW92YUJxeWNhMWVsMHJsbWZGRmpQS2dRQkFZ?=
 =?utf-8?B?M0FoNE5YTXl6bW1ZM0loQ0pBVTZ6N1VJbEkyaExOWkNzK3gwSTNkdTNEaUYv?=
 =?utf-8?B?OVZqdXQyZWdBN1ZSLzU5Um5yMGVnenlWTDF3MXg5bzRQWWdoRTJIRzNWNGNU?=
 =?utf-8?B?WWEyOE1vYlgwV3Z1b0UrUnhvNGJiSk5LQXBqYWsxS01HWjZVd2RLenplQkdH?=
 =?utf-8?B?cEpGSXlaZVBON0VMV2FIMUpSK1JTZ0VyblFTQjViWVZPdjRHaWh2N1VjSG5z?=
 =?utf-8?B?U2xsUFlWSlJMT21uQVhiYTJnRXVYNGQvVGcvWktiUHNGMlByZ3hHbHphZ2Vz?=
 =?utf-8?B?M0x3T3dlWmZWRjhJRFBmOWpuejVNYXY5Q0d2dm5qMjQzSW9FMFFrbGxub21n?=
 =?utf-8?B?MExGZEhMc0NucVM5M2Q0MjRwbmNFeEtWMjFCRStaWnhkbG9GejdGWGdWWko5?=
 =?utf-8?Q?KlrGfRkBbVVhcpbFKipGHoRTe3UqprM1xv?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2235298B2F9354388D52377F188EA32@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 725935df-2c8e-479d-9459-08d89c65a648
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2020 17:12:46.7323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oCnKVLi2jiuXgaThYHEtvsms5nBq4iHpTDG49Ngmxj2z/BVj7K7FYoLH9VyYB55TSbmaAgSemmx/kn+v3whtxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3407
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIwLTEyLTA5IGF0IDEyOjA3IC0wNTAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gT24gV2VkLCBEZWMgOSwgMjAyMCBhdCAxMTo1OSBBTSBUcm9uZCBNeWtsZWJ1c3QNCj4g
PHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBGcmksIDIwMjAt
MTItMDQgYXQgMTU6MDAgLTA1MDAsIE9sZ2EgS29ybmlldnNrYWlhIHdyb3RlOg0KPiA+ID4gSSBv
YmplY3QgdG8gcHV0dGluZyB0aGUgZGlzYWJsZSBwYXRjaCBpbiwgSSB0aGluayB3ZSBuZWVkIHRv
IGZpeA0KPiA+ID4gdGhlDQo+ID4gPiBwcm9ibGVtLg0KPiA+IA0KPiA+IEkgY2FuJ3Qgc2VlIHRo
ZSBwcm9ibGVtIGlzIGZpeGFibGUgaW4gNS4xMC4gVGhlcmUgYXJlIHdheSB0b28gbWFueQ0KPiA+
IGNoYW5nZXMgcmVxdWlyZWQsIGFuZCB3ZSdyZSBpbiB0aGUgbWlkZGxlIG9mIHRoZSB3ZWVrIG9m
IHRoZSBsYXN0IC0NCj4gPiByYw0KPiA+IGZvciA1LjEwLiBGdXJ0aGVybW9yZSwgdGhlcmUgYXJl
IG5vIHJlZ3Jlc3Npb25zIGludHJvZHVjZWQgYnkganVzdA0KPiA+IGRpc2FibGluZyB0aGUgZnVu
Y3Rpb25hbGl0eSwgYmVjYXVzZSBSRUFEX1BMVVMgaGFzIG9ubHkganVzdCBiZWVuDQo+ID4gbWVy
Z2VkIGluIHRoaXMgcmVsZWFzZSBjeWNsZS4NCj4gPiANCj4gPiBJIHRoZXJlZm9yZSBzdHJvbmds
eSBzdWdnZXN0IHdlIGp1c3Qgc2VuZCBbUEFUQ0ggMS8zXSBORlM6IERpc2FibGUNCj4gPiBSRUFE
X1BMVVMgYnkgZGVmYXVsdCBhbmQgdGhlbiBmaXggdGhlIHJlc3QgaW4gNS4xMS4NCj4gDQo+IFN1
cmUsIGJ1dCBzaG91bGRuJ3QgdGhlcmUgYmUgbW9yZSBpZmRlZnMgaW5zaWRlIG9mIHRoZSB4ZHIg
Y29kZSB0bw0KPiB0dXJuIGl0IG9mZiBjb21wbGV0ZWx5Pw0KDQpBRkFJQ1QsIHRob3NlIGZ1bmN0
aW9ucyBhcmUgbm90IGNhbGxlZCBieSBhbnl0aGluZyBlbHNlLCBzbyBhcyBsb25nIGFzDQp0aGUg
UkVBRF9QTFVTIGNsaWVudCBmdW5jdGlvbmFsaXR5IGlzIGRpc2FibGVkLCB0aGV5IHNob3VsZCBi
ZQ0KaGFybWxlc3MuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1h
aW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoN
Cg0K
