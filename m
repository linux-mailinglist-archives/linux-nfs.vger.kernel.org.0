Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89508242EA2
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Aug 2020 20:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgHLSqi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Aug 2020 14:46:38 -0400
Received: from mail-mw2nam10on2111.outbound.protection.outlook.com ([40.107.94.111]:12544
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726512AbgHLSqh (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 12 Aug 2020 14:46:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Om/TSRQX5vd8O5wmLW6Cl2KfnJA1qFefxRlvU2EVz00gHCNtRztQmzPHkjRk1q0VHJBxaMZ4O/FTbZucnhKjGl057yfK+089eoXYBnIqJq85hadASfRqaP7YPK7UbywuSMVlSEYav7ypPPnuUvA/pIqxhQCDAvi7thUVtUSNLmP0T5Zi8HZt/KlaXPfgYAj0YaW7dQOdpv03ZkRo0S8gtMgeBkbuHC6f0WcNFo4RzuafJfjMvRzRyvJp03l1TE/4n1IUzfWCqAuVBFCP0cdBaXrT43XmaSzsMYI68tX0qexnD1PNgeSHZCNtZr7Jzfjx4hbEStEsgOUa8BgGsaJ5Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2x44UuaHv0zUrRtc++g3dKaovYQfc06vcIQgXl2PaiY=;
 b=WJom2gXanVCBUCfQ6wNXlcOdcOJQ/kbqprbl76GkxaKeABBs5PT+4tj3l6MQIagyb5k6T8Aq81jeiJDOJ4B/y5OaVd2ISu3HgO3pudvxyeUXuq8QKh6OaPVu+ivtlcB4gjl82ueMBauZLsn2fz3jxjxUrpBijWWAMsyNktUZC+Q+QskvmfuUnDYio10iEnMedg95/1/bCEgV5sRHPGx66ZKt6NgAFonhR2TZB3fXMiwNDhNeRWHS9sX/kkhUc5pTfDD5LjLeB47qWdshBGDgvwXx33lgPStskxrpSxfh7m/G1/5W9u2esqnpUNZ2sGpoyUDwJfKG6WLNDaS3TZhaYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2x44UuaHv0zUrRtc++g3dKaovYQfc06vcIQgXl2PaiY=;
 b=CvEZV8crMdEKaw3L/BK8Cq2ST4wJBtVDgJHFmxq4Mxc5DJh73OCEEgbiTE7Tess4r6XbrpbBgJfr3DIr2Y22HxZv2E1BFhG//3xJ3z3G4JJDDNtmXGr54mqzX6kEPBHXsASH8Og9PC1qXq9HwGRmXhEq6g1yje43ym9h9wvdnd8=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3784.namprd13.prod.outlook.com (2603:10b6:610:91::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.11; Wed, 12 Aug
 2020 18:46:34 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::403c:2a29:ba13:7756]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::403c:2a29:ba13:7756%3]) with mapi id 15.20.3283.015; Wed, 12 Aug 2020
 18:46:34 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "aglo@umich.edu" <aglo@umich.edu>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Questions about GETATTRs
Thread-Topic: Questions about GETATTRs
Thread-Index: AQHWcASwzrfxxPHlS0+rqYue6zIHpKk00cEA
Date:   Wed, 12 Aug 2020 18:46:34 +0000
Message-ID: <b1a32723434e3f5c3ea993552eb9f32b3ee857c8.camel@hammerspace.com>
References: <CAN-5tyGR0gzAW22pPhzRPtUTnBDEorydgAAE-m_UbjeWfOe-xQ@mail.gmail.com>
In-Reply-To: <CAN-5tyGR0gzAW22pPhzRPtUTnBDEorydgAAE-m_UbjeWfOe-xQ@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: umich.edu; dkim=none (message not signed)
 header.d=none;umich.edu; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 507c2cba-8281-4f08-fc9c-08d83ef00980
x-ms-traffictypediagnostic: CH2PR13MB3784:
x-microsoft-antispam-prvs: <CH2PR13MB37842A1BB67F47D074659986B8420@CH2PR13MB3784.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nCPEO6Rji2/7E9VcUurYKJrOkZ3Oi/ui/fciXYgFlRvnrmFi4XVDyWtwdclV9Nfk7mqkPSLrrTzysvBH1HExbLeckxc2W+tLxP9zwyyNnJsRVPFd4AoGl9f9eGm3oPjXRbPObMUcuQrSWdX/UPq96dZsDTjm48etFzokJDjOtec4ug3U4B3yz06PsG5iz+rXkWNlTu2dNppQfruy/xRqCt30Eh3X+jmENp1S045S5yHBQMFk3ryAFq8F29CIVdgf1bm3VFasrI20H/1kkiAlwBX/8reT9hM2A3yeJPmINQs94ID86fhv06h/Wf30WXFEr6O68viZ3mdORnQ7/7CLWw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(39840400004)(396003)(136003)(6512007)(83380400001)(26005)(6486002)(186003)(71200400001)(7116003)(316002)(2906002)(2616005)(478600001)(8936002)(8676002)(6916009)(3480700007)(64756008)(6506007)(66446008)(86362001)(5660300002)(36756003)(66476007)(66946007)(76116006)(4326008)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: fdWj4/CbUfpxUYy5lm22B8bOPyeQa3+wV6FaAK85E6GEyvM1eyD2Y7dV+qC0RE/N2ytJAhCAtDI3dzVDobvT+AS40epr3x/sYvnSU7xaxDp3mNFyACBFpBnNU6FJmddKFMVIXpDqXlEghfnPIL0L0RwyKv4FRh7N6kSaRVkGOzKsXs01RdDm/NAHcVUru8D/+OWJOqYHhTZI8cCk9ar5CM0FQxXWQajEWUxV700P7sozlrJcS7g5As4hpX/+9IOStpJS8KKgOYX91ng9z0YsdK3mqAYZIhNeG+5gPMGa13kGEE4WfA/Ce/jAGDeXRDVV6QiSkCFAPhAdLnQ73cbXBv7wiOWlxwkqVQDjVNOxvK5fs4ExWxwa/BrEyidTst5Qjw+W7rIIQ9xBSNIGmoMKuB+N1GsMTzm5lkNb58wjNprfsY2S8F9rmCroHH8DTJAFNHEek5p5mHF7ifYr9jQwXqBweqUg0UREz0UR0XjxtjHtpb6mUk8Xbz1mLlvroy0jcmZfQ54FEEGR5i3YrS1pBwU/ydBDpuVTA9CbKVlZ4V2sSX/PRmnBaB/iOg22S2ao3vi5XxX2TgP7YX0CtfNe5SeWN8V+9F9mYXtL40FobC+JI4w89a50eFwqPhDi7hcfSpvQKRqZ5pf/ZVesNQ2VIg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC61CDF21763434EA059BB1AAD2917B1@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3398.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 507c2cba-8281-4f08-fc9c-08d83ef00980
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2020 18:46:34.2688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: skurGxciGKoXp8LDYFw2AO6munhQLoy2JSw63jNHAQNCrl17o+niyb2PeQ1e9ch5X8RzCBz/JWgs5m4B5MdhnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3784
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgT2xnYSwNCg0KT24gVHVlLCAyMDIwLTA4LTExIGF0IDEzOjI3IC0wNDAwLCBPbGdhIEtvcm5p
ZXZza2FpYSB3cm90ZToNCj4gSGkgVHJvbmQsDQo+IA0KPiBJJ2QgbGlrZSB0byBkaXNjdXNzIGEg
Y291cGxlIG9mIGNvbW1pdHMgdGhhdCBhcmUgZGVhbGluZyB3aXRoDQo+IEdFVEFUVFJzLg0KPiAN
Cj4gRmlyc3QgaXMgdGhlIHJlY2VudCBmaXggaW46IGNvbW1pdA0KPiAzYTM5ZTc3ODY5MDUwMDA2
NmIzMWZlOTgyZDE4ZTJlMzk0ZDNiY2UyICJuZnM6IHNldCBpbnZhbGlkIGJsb2Nrcw0KPiBhZnRl
ciBORlN2NCB3cml0ZXMiLiBUaGUgZmFjdCB0aGF0IENMT1NFJ3MgR0VUQVRUUiBkb2Vzbid0IHF1
ZXJ5IGZvcg0KPiBhdmFpbGFibGUgc3BhY2UgbGVhZHMgdG8gc3RhbGUgYXR0cmlidXRlIGRhdGEg
YnV0IG1hcmtpbmcgYXR0cmlidXRlcw0KPiBpbnZhbGlkIGluc3RlYWQgbGVhZHMgdG8gYW4gYWRk
aXRpb25hbCBzdGFuZGFsb25lIEdFVEFUVFIgaWYNCj4gYXR0cmlidXRlcyBhcmUgYWZ0ZXIgd3Jp
dGluZyB0byB0aGUgZmlsZS4gUXVlc3Rpb246IHdoeSBub3QgY2hhbmdlDQo+IENMT1NFJ3MgR0VU
QVRUUiB0byBxdWVyeSBmb3IgYWRkaXRpb25hbCBhdHRyaWJ1dGVzIGluc3RlYWQ/DQo+IA0KDQpT
bywgdGhlIHBvaW50IG9mIHRoZSBDTE9TRSBnZXRhdHRyIGlzIHRvIGVuc3VyZSB0aGF0IHdlIG1h
bmFnZSBjYWNoZQ0KY29uc2lzdGVuY3kuIFdoaWxlIHdlIGNvdWxkIGFzayBmb3IgZnVydGhlciBh
dHRyaWJ1dGVzLCB0aGVyZSBhcmUNCnNlcnZlcnMgb3V0IHRoZXJlIGZvciB3aGljaCB0aGlzIG1p
Z2h0IGNhdXNlIHNsb3dkb3ducyAoaW4gcGFydGljdWxhcg0Kc29tZSBzZXJ2ZXJzIHRoYXQgb3Bl
cmF0ZSBpbiBhIGNsdXN0ZXJlZCBtb2RlIGFuZCB0aGF0IGhhdmUgYSBzdWJsaXN0DQpvZiBhdHRy
aWJ1dGVzIHRoYXQgdGhleSBwcmVmZXRjaCkuIEknbSB0aGVyZWZvcmUgb3BlbiB0byBkaXNjdXNz
aW9ucw0KYXJvdW5kIHRoaXMsIGJ1dCBJIHdhbnQgdG8gbWFrZSBzdXJlIHRoYXQgd2UgZ2l2ZSBm
b2xrcyBhIGNoYW5jZSB0bw0KdGVzdCBhZ2FpbnN0IHRoZWlyIGZhdm91cml0ZSBzZXJ2ZXJzIGZp
cnN0Lg0KDQo+IEFub3RoZXIgY29tbWl0IEkgd291bGQgbGlrZSB0byBpbnF1aXJlIGFib3V0IGlz
OiBjb21taXQNCj4gM2VjZWZjOTI5NTk5MWVhYWFkNGM2NzkxNWM2Mzg0ZTVkMThjYzYzMiAiTkZT
djQ6IERvbid0IHJlcXVlc3QNCj4gY2xvc2UtdG8tb3BlbiBhdHRyaWJ1dGUgd2hlbiBob2xkaW5n
IGEgZGVsZWdhdGlvbiIuIEFmdGVyIHRoaXMgY29tbWl0DQo+IGlmIHRoZSBjbGllbnQgYXBwbGlj
YXRpb24gcXVlcmllcyBmb3IgYXR0cmlidXRlcyBhZnRlciB3cml0aW5nIGl0DQo+IHRyaWdnZXJz
IGEgZ2V0dGF0dHIgKGJlY2F1c2Ugd2UgZGlkbid0IGdldCB0aGVtIGluIHRoZSBjbG9zZQ0KPiBj
b21wb3VuZCkuIEkgdW5kZXJzdGFuZCB0aGF0IGl0IHdhcyBhbiBvcHRpbWl6YXRpb24gYnV0IGl0
IGxlYWRzIHRvDQo+IGFuDQo+IGV4dHJhIFJQQyBpbiBzb21lIHdvcmtsb2FkcyBzbyBob3cgY2Fu
IHdlIGNsYWltIHRoYXQgb25lIHNhdmluZyBpcw0KPiBiZXR0ZXIgdGhhbiBhbm90aGVyPw0KPiAN
Cj4gVGhhbmsgeW91IGZvciB0aGUgZmVlZGJhY2suDQoNCldoZW4gd2UgaG9sZCBhIGRlbGVnYXRp
b24sIHRoZSBjYWxsIHRvIENMT1NFIGlzIHVzdWFsbHkgbm90IGNvbnNpZGVyZWQNCmEgZGF0YS9t
ZXRhZGF0YSBzeW5jaHJvbmlzYXRpb24gcG9pbnQuIFRoYXQgbWVhbnMgd2UncmUgbm90IGd1YXJh
bnRlZWQNCnRvIHN5bmNocm9ub3VzbHkgZmx1c2ggd3JpdGVzIChzZWUgbmZzNF9kZWxlZ2F0aW9u
X2ZsdXNoX29uX2Nsb3NlKCkgaW4NCm5mczRfZmlsZV9mbHVzaCgpKSwgYW5kIHdlIHVzdWFsbHkg
ZG9uJ3QgcmV0dXJuIHBORlMgbGF5b3V0cy4NCg0KV2hlbiB3ZSdyZSBub3QgZmx1c2hpbmcgd3Jp
dGVzLCB0aGVuIHRoZSBvYnZpb3VzIGNvbnNlcXVlbmNlIGlzIHRoYXQNCnRoZSBHRVRBVFRSIG1p
Z2h0IGp1c3QgZW5kIHVwIGdldHRpbmcgZGlzY2FyZGVkIGJ5IHRoZSBjbGllbnQsIHdoaWxlDQpo
b2xkaW5nIG9udG8gdGhlIGxheW91dCBjYW4gY2F1c2UgdGhlIEdFVEFUVFIgdG8gYmUgaW5lZmZp
Y2llbnQgb24gc29tZQ0Kc2VydmVycy4gVGhvc2UgYXJlIHRoZSByZWFsIHJlYXNvbnMgZm9yIHRo
ZSBvcHRpbWlzYXRpb24uDQoNCkNoZWVycw0KICBUcm9uZA0KDQotLSANClRyb25kIE15a2xlYnVz
dA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVi
dXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
