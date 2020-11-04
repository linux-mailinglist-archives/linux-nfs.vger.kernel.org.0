Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5B62A6B89
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Nov 2020 18:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbgKDRVI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Nov 2020 12:21:08 -0500
Received: from mail-mw2nam12on2112.outbound.protection.outlook.com ([40.107.244.112]:8800
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726604AbgKDRVH (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 4 Nov 2020 12:21:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHUvyUUKVT4L4DZAtNTm9EilRaAxN8AfupM3hEijDL9RF6H5RuBTChNLqqT+M4UtZ+ga1NrXGw7pQslvvkXCSrU/Y16IVg2Hfulmv7yzvHwb9DUUpPmFOQstPtmRbp6DhqVkBVhl7GKCFkKiEYAR3fQWg1BsOnMjgTQ+vZH0IL7LrXfq4P+pyiW5GgORe+aVbvps3k7VIFcf1hSbxkIv9D9SNHzTTC05qdyKiwfGkmnBEB7gHF9s9owKLtbLu5buHe054O5B1sH+TqGMa3EHtsXW2uiAdxke8kjr9bR80JZUiGL/JQHNews+O7Psm6b9OVbCO+e2kceNjsxrKhvLCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tw3qJKMMIZRj/pG7cgqMGiyITjPS9sFXi1xuvTaju9Q=;
 b=cNXdoaXVv5v/1+RTPXoPA0KWigcDGz4D54kurts2DtOE311aOYgARhvQdyKvL/sZk3btkgdDZdzSmRNxeIA/sPV+eRUqjTWnRUjtWuyJAjJi9PzIX2gg+st2kmEBXt+94dL2fjXQufjrbYkg7qVJa307V+1Fqqh+3Sh9YE+vkimdm1BsoUpM2MGOerl5hUa7/EbHMvCKOuxyPB+CRx4dIZD8CZvnUHbBmHfc+XznmF9zFN6L1F/QzAJomjKfsyzisHi9NczWj+paUDMyxAe6PRZ5Z3Z3p2+DXr74lh377QRHdeZyk8KyyUQ84VoOa7gV7UD9gsAbYTWyw/x9txFHyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tw3qJKMMIZRj/pG7cgqMGiyITjPS9sFXi1xuvTaju9Q=;
 b=D+ukB82SeqScL3OLDfGSEYrsqjR/feasjRhsIzK4RvHjK/QYNCmckoFOWwm6vY/El8oiRXD8cZ4a0adr3tpaiu5FcJ7GxIkjxP4USCswFQ6O0wloTPUDW7n/EaB/zm113/3Z06E0kLZaXS7J0WcLavA94qoaVjnsyL3froQDFBI=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3007.namprd13.prod.outlook.com (2603:10b6:208:153::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10; Wed, 4 Nov
 2020 17:21:05 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3541.018; Wed, 4 Nov 2020
 17:21:05 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "tigran.mkrtchyan@desy.de" <tigran.mkrtchyan@desy.de>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 16/16] NFS: Improve handling of directory verifiers
Thread-Topic: [PATCH v2 16/16] NFS: Improve handling of directory verifiers
Thread-Index: AQHWsfghAtnAZ/q0ekqAigRdEV1d66m3wiiAgAB3pAA=
Date:   Wed, 4 Nov 2020 17:21:05 +0000
Message-ID: <fc3b4ff48d315674f9b076187dc2a1c056cf5744.camel@hammerspace.com>
References: <20201103153329.531942-1-trondmy@kernel.org>
         <20201103153329.531942-11-trondmy@kernel.org>
         <20201103153329.531942-12-trondmy@kernel.org>
         <20201103153329.531942-13-trondmy@kernel.org>
         <20201103153329.531942-14-trondmy@kernel.org>
         <20201103153329.531942-15-trondmy@kernel.org>
         <20201103153329.531942-16-trondmy@kernel.org>
         <20201103153329.531942-17-trondmy@kernel.org>
         <1868756897.5941283.1604484769947.JavaMail.zimbra@desy.de>
In-Reply-To: <1868756897.5941283.1604484769947.JavaMail.zimbra@desy.de>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: desy.de; dkim=none (message not signed)
 header.d=none;desy.de; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de3874ef-5fe7-49b1-12a0-08d880e602f2
x-ms-traffictypediagnostic: MN2PR13MB3007:
x-microsoft-antispam-prvs: <MN2PR13MB3007B9083AAEFE3F08B7AB41B8EF0@MN2PR13MB3007.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /hPH7zHezgS3jUIHr7cfaSMt9ylZ1uOdeXSZRDBRtjVp83g7sDPw3AHk9yHztJQp+p2yBostSbUVDrGBuliYXU9klmNmHUj5IbjO5fyMbhCUSoZ4u3L9XKjczhLIrZBakHeHfh7FG5iO/t9xxZJSdnXPzJ21uKQP4Pbberkm/zJfAB8pFAsVp9dQ7nHC3l3PkHj3Fe/DSj55HDMkx7CTuJmAqt/u4cHJBnPRhoSvjkYIuW2o4S2nolItku2h1NIY58N3gE8//5ETf4QDQ71vLOP4+FkOg2KFrKJ/ig48IgcUfRGwcgkeoK1J/QTSFaqzT1WKGICvYTDkyza0UNYb9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39830400003)(136003)(366004)(396003)(346002)(316002)(83380400001)(478600001)(6512007)(5660300002)(4326008)(6486002)(86362001)(66446008)(53546011)(6506007)(186003)(2616005)(6916009)(66476007)(71200400001)(8936002)(66946007)(2906002)(36756003)(64756008)(66556008)(26005)(91956017)(8676002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: oM7wl++fK8rl61L/PBeSUgmROKd5yda0Ct5BW1jGo77QACXjQVb01sworq4UJWFprL+P809IpjJ5dE/BWNZmcwzjSsuORPnpn8YliQKpzrN/Ykry5/VXUyKmZ/CVtXEONgyHS6IKIWR3rcioHJyE50yjOo7dpwspw6+d5W2ndd0iSXhVTimiIpsf9/X+wL64k07s4OuecKAqb+rLNag2uGy2EPtS38wEiQ2PBiUXz/ZzCRKskGRC2rPW+4YI9cW//8ZY75apVPLSZDlgN4j5Wt7a1AJfpR2WYFlGrzCExhGZ9hE1mxD30iHZbYUuiMNEoXuGxn0uQuW4GGrdxhOz/oV3vAeagr96F2QHl3jabmnmaHw/KzdRI6wQjBZcxqxrCC9QJCsEHDGfa+hN+0uzKXy61Ce1CnwcwnipHXWpNARUClmqx9kKyIFTmQvG8ZctdjEqvaqCopShNCEf+MIOPHBIpjy+DPYhdF0NgmnMjbO2dSFuNrhWXOyt5w8gwxCrmhJF3OrmDhR6q/tjlqHch4oE3uzfNfSGgLPGscWUN9MCVtJggeRDy4uSmyqGprZa+31Ad0kGYiFv3EwxF+T8AqRm2JKqg6J2+hNjIhGlETzCZJVTb07pvQUeGo4Z+boUDUMThscmybQgA1gkmxSOLA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7367E4847DEB964E8A3A5AE081DE341F@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de3874ef-5fe7-49b1-12a0-08d880e602f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2020 17:21:05.1913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xQda/G+MY51aLdPV8beJdU4YSzoRvmqkMTtKEtBuJJ2Ub+6vkr6IlWy7DbG803/gFKAX1S2Lx7oDeo2izRP0VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3007
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgVGlncmFuLA0KDQpPbiBXZWQsIDIwMjAtMTEtMDQgYXQgMTE6MTIgKzAxMDAsIE1rcnRjaHlh
biwgVGlncmFuIHdyb3RlOg0KPiANCj4gDQo+IC0tLS0tIE9yaWdpbmFsIE1lc3NhZ2UgLS0tLS0N
Cj4gPiBGcm9tOiB0cm9uZG15QGtlcm5lbC5vcmcNCj4gPiBUbzogImxpbnV4LW5mcyIgPGxpbnV4
LW5mc0B2Z2VyLmtlcm5lbC5vcmc+DQo+ID4gU2VudDogVHVlc2RheSwgMyBOb3ZlbWJlciwgMjAy
MCAxNjozMzoyOQ0KPiA+IFN1YmplY3Q6IFtQQVRDSCB2MiAxNi8xNl0gTkZTOiBJbXByb3ZlIGhh
bmRsaW5nIG9mIGRpcmVjdG9yeQ0KPiA+IHZlcmlmaWVycw0KPiANCj4gPiBGcm9tOiBUcm9uZCBN
eWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+DQo8c25pcD4NCj4gPiBA
QCAtODksNiArOTQsNyBAQCBzdHJ1Y3QgbmZzX29wZW5fY29udGV4dCB7DQo+ID4gc3RydWN0IG5m
c19vcGVuX2Rpcl9jb250ZXh0IHsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IGxpc3RfaGVh
ZCBsaXN0Ow0KPiA+IMKgwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBsb25nIGF0dHJfZ2VuY291bnQ7
DQo+ID4gK8KgwqDCoMKgwqDCoMKgX19iZTMywqDCoHZlcmZbTkZTX0RJUl9WRVJJRklFUl9TSVpF
XTsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgX191NjQgZGlyX2Nvb2tpZTsNCj4gPiDCoMKgwqDCoMKg
wqDCoMKgX191NjQgZHVwX2Nvb2tpZTsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgc2lnbmVkIGNoYXIg
ZHVwZWQ7DQo+ID4gQEAgLTE1Niw3ICsxNjIsNyBAQCBzdHJ1Y3QgbmZzX2lub2RlIHsNCj4gPiDC
oMKgwqDCoMKgwqDCoMKgICogVGhpcyBpcyB0aGUgY29va2llIHZlcmlmaWVyIHVzZWQgZm9yIE5G
U3YzIHJlYWRkaXINCj4gPiDCoMKgwqDCoMKgwqDCoMKgICogb3BlcmF0aW9ucw0KPiA+IMKgwqDC
oMKgwqDCoMKgwqAgKi8NCj4gPiAtwqDCoMKgwqDCoMKgwqBfX2JlMzLCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBjb29raWV2ZXJmWzJdOw0KPiA+ICvCoMKgwqDCoMKgwqDCoF9f
YmUzMsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvb2tpZXZlcmZbTkZTX0RJ
Ul9WRVJJRklFUl9TSVpFXTsNCj4gDQo+IEp1c3QgZm9yIG15IGVkdWNhdGlvbi4gV2h5IHdlIHVz
ZSAyeDMyIGJpdCBCRSBlbmNvZGVkIGludHMgaW5zdGVhZCBvZg0KPiByYXcgOCBieXRlcz8NCj4g
QW5kIGlmIGl0J3MgdHJlYWRlZCBhcyBhIG51bWJlciwgYXMgc3BlYyBzb21ldGltZXMgZG9lcyAo
IlRoZQ0KPiByZXF1ZXN0J3MgY29va2lldmVyZg0KPiBmaWVsZCBzaG91bGQgYmUgc2V0IHRvIDAi
KSwgdGhlbiB3aHkgaXQncyBub3QgdGhlbiBfX2JlNjQ/DQoNClRoZSBtYWluIHJlYXNvbiBmb3Ig
b2Z0ZW4gdXNpbmcgX19iZTMyIG9uIHRoZXNlIGlkZW50aWZpZXJzIGlzIHRvIHRhZw0KdGhlbSBh
cyBiZWluZyBvcGFxdWUgUlBDIG9iamVjdHMgKHNpbmNlIFJQQyBvYmplY3RzIGFyZSBhbHdheXMg
aW4gdW5pdHMNCm9mIDMyLWJpdHMgYW5kIGFyZSBiaWcgZW5kaWFuIGVuY29kZWQpLg0KDQotLSAN
ClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFj
ZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
