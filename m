Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3593195723
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2020 13:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgC0MeK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Mar 2020 08:34:10 -0400
Received: from mail-dm6nam12on2136.outbound.protection.outlook.com ([40.107.243.136]:15745
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726165AbgC0MeK (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 27 Mar 2020 08:34:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E04NfqC94pM7bRfFZIKy43i31oqk9V8IXW1hOSZnPAezzQR8qQj924rwPLK70MleZXlTc+hmm3MH7D2GfsCF06vxhamlmmC2Lylr33tUR9tSwpZi8IUXQF488F7qJJuQLIRxAwb80PRcdIJOS6yKXGKPVhAItO+NyRG0m2Ij2Eg1mzvt8/f6WQViQBodt0jKhzesr3o4a0C89DP7CH+Uj9qxJeB4sofgvPOpJ4Lw9MX2GL0Pk9gTcptuiC6l+VTUe82vW3HYHKOi6LZcVZ2klhPjYwc+wkxzyGfqaezTOYrH9jF+zsakTaTFaRaroe2U/+a2AcVf0Hnbb2762wBb/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzdEBuaNknONVGFUd1/PPFAx7tLPrXnK93rwU735Z4o=;
 b=UTdz+BJ439BucRC7ga/0nYma9JWLxzQr0UNiO9MDNQUcWM58FMPBCSJopNCT9k4InQXJINIj4OZe/7es2J3/5Z1HstbTVkIu9DWvLNXN9xfkALO+Q7ezxgWGpqqhjbeUEugEkEPa+fizm4RqTthSKQxeSCgVvBDnwx5UILzf1Ow3Egj6kqg1fwXqDbdQ5dL4Q0kj22ZJA0xEiFC7nioMXeTCJJ9GTH/QHnmMZBSYKrirIbQ9ZKqkBgepOccjxnBgCyRlC6wSNbJUZXoelm9Ud7AL1bSgAoAxNFM7ZegNhM3sIdqfoJ4wkrqeGrPMdpSEGKaxMKOdctpA/BY92DKVJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzdEBuaNknONVGFUd1/PPFAx7tLPrXnK93rwU735Z4o=;
 b=aakrcwVTaT7uiK7XzbRqWAIOPbGyu6JfqbUVZN26TLnOiCKnPCyegOd/j8KADydYF90W+5ACnrdnKZ+NmtFSMhtkH833pHHhQ/ZBcoEykyTRLTTHHmHl6Xvv8jnQsIXc9fkLtHDUzrYW2pDTt42xMBjnPVlc+WKACfbjF2MgBf8=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3461.namprd13.prod.outlook.com (2603:10b6:610:2c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.15; Fri, 27 Mar
 2020 12:33:31 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::9570:c1b8:9eb3:1c36]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::9570:c1b8:9eb3:1c36%7]) with mapi id 15.20.2878.012; Fri, 27 Mar 2020
 12:33:31 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@redhat.com" <bfields@redhat.com>
CC:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "kinglongmee@gmail.com" <kinglongmee@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC/cache: Allow garbage collection of invalid cache
 entries
Thread-Topic: [PATCH] SUNRPC/cache: Allow garbage collection of invalid cache
 entries
Thread-Index: AQHVyvwJPYRIWp4ZtEelpB+N9lu4ZqgOgFIAgAFulwCAAEEOgIBLl4KAgAARZgCAAEVEAIAAs7uA
Date:   Fri, 27 Mar 2020 12:33:30 +0000
Message-ID: <80c83f5543d7d758a165be167d3bf0b2175e57f8.camel@hammerspace.com>
References: <20200114165738.922961-1-trond.myklebust@hammerspace.com>
         <20200206163322.GB2244@fieldses.org>
         <8dc1ed17de98e4b59fb9e408692c152456863a20.camel@hammerspace.com>
         <20200207181817.GC17036@fieldses.org> <20200326204001.GA25053@fieldses.org>
         <1a0ce8bb1150835f7a25126df2524e8a8fb0e112.camel@hammerspace.com>
         <20200327015012.GA107036@pick.fieldses.org>
In-Reply-To: <20200327015012.GA107036@pick.fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b347fb62-1a29-4ee0-9c33-08d7d24b0f2d
x-ms-traffictypediagnostic: CH2PR13MB3461:
x-microsoft-antispam-prvs: <CH2PR13MB34619AB3358B03F4EB7DEA79B8CC0@CH2PR13MB3461.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0355F3A3AE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39830400003)(366004)(136003)(376002)(396003)(2616005)(316002)(66556008)(54906003)(64756008)(66476007)(81156014)(71200400001)(66946007)(66446008)(86362001)(4326008)(8936002)(2906002)(81166006)(478600001)(6916009)(76116006)(26005)(36756003)(6512007)(966005)(91956017)(5660300002)(186003)(8676002)(6506007)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR13MB3461;H:CH2PR13MB3398.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5KWrDytT977GyyXiTCHNSTiF5kkkCM9pyfk/NTeKldIglksNCC6hvAlLTo2APgUdjg9Z/LkBnz+XwzZumq5dffg186ocO6zgscKJVPo2eYgusHrUEb//AfqRTcFkUWFCY7R1X+9MO5R3RjO8w5gkIxfLgg6SpiBL3CgZtI22yoR8WmUQXWWgr+7qco9rVWkjQmH0zvZ+kzcp0ojXG0AIIfoOUEQoG4dCTB3wvCoVSCXlMe18IFkvIOK97gQ0mTRI24wGakgXFq6xA61d1YUs7oNlp3mnA5e4Vsh9tUIUCRm/sm8TVnjTnJtEfiFLx8JQnW8r95h8/WB+nj5k7p8Y8Q1OTwSIEp6Lc2toQ+lxWDAP7Uood54dsjGYlla/Oc/0IGpaxQL4L/3MfYupbK8iSMDBMV+OVlM0/V2hPVkTEV4sRthO3t4++EjaE5e6oQFykzgdUIYt6acuR9Z1U8TXx+uflv2dSuKDfyXQKDkwKTEUAT0BX9PIu2K7g7D1x6hoE7g2kJiKieYnWIwVgJXvug==
x-ms-exchange-antispam-messagedata: 3nM3yDvy4r9tOtN7fW4G6/kN2YJXUBYDax+GLf+TfLhGgCXDybA90jZPJR+WPGZlVzKyfOBFdpX/nH8afx7D/Au0P3rcjl4cYvd3gNK7hIHri7dTPSuLciig0g/T1axILpBcDDVQGRwawqKTl4YQ7w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9AF037C245A8AB4D9B4945569393A9DE@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b347fb62-1a29-4ee0-9c33-08d7d24b0f2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2020 12:33:31.2773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Mf6yX9ydLCsceqeMYnsNbsVwOp4kNDNqGe4IeT3yIG9woHQgL3lUCgwIr6bj15jgGYNj++rjeaiioSZinHfwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3461
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIwLTAzLTI2IGF0IDIxOjUwIC0wNDAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6
DQo+IE9uIFRodSwgTWFyIDI2LCAyMDIwIGF0IDA5OjQyOjE5UE0gKzAwMDAsIFRyb25kIE15a2xl
YnVzdCB3cm90ZToNCj4gPiBPbiBUaHUsIDIwMjAtMDMtMjYgYXQgMTY6NDAgLTA0MDAsIGJmaWVs
ZHNAZmllbGRzZXMub3JnIHdyb3RlOg0KPiA+ID4gTWF5YmUgdGhlIGNhY2hlX2lzX2V4cGlyZWQo
KSBsb2dpYyBzaG91bGQgYmUgc29tZXRoaW5nIG1vcmUgbGlrZToNCj4gPiA+IA0KPiA+ID4gCWlm
IChoLT5leHBpcnlfdGltZSA8IHNlY29uZHNfc2luY2VfYm9vdCgpKQ0KPiA+ID4gCQlyZXR1cm4g
dHJ1ZTsNCj4gPiA+IAlpZiAoIXRlc3RfYml0KENBQ0hFX1ZBTElELCAmaC0+ZmxhZ3MpKQ0KPiA+
ID4gCQlyZXR1cm4gZmFsc2U7DQo+ID4gPiAJcmV0dXJuIGgtPmV4cGlyeV90aW1lIDwgc2Vjb25k
c19zaW5jZV9ib290KCk7DQoNCkRpZCB5b3UgbWVhbg0KDQpyZXR1cm4gZGV0YWlsLT5mbHVzaF90
aW1lID49IGgtPmxhc3RfcmVmcmVzaDsNCg0KaW5zdGVhZCBvZiByZXBlYXRpbmcgdGhlIGgtPmV4
cGlyeV90aW1lIGNoZWNrPw0KDQo+ID4gPiANCj4gPiA+IFNvIGludmFsaWQgY2FjaGUgZW50cmll
cyAod2hpY2ggYXJlIHdhaXRpbmcgZm9yIGEgcmVwbHkgZnJvbQ0KPiA+ID4gbW91bnRkKQ0KPiA+
ID4gY2FuDQo+ID4gPiBleHBpcmUsIGJ1dCB0aGV5IGNhbid0IGJlIGZsdXNoZWQuICBJZiB0aGF0
IG1ha2VzIHNlbnNlLg0KPiA+ID4gDQo+ID4gPiBBcyBhIHN0b3BnYXAgd2UgbWF5IHdhbnQgdG8g
cmV2ZXJ0IG9yIGRyb3AgdGhlICJBbGxvdyBnYXJiYWdlDQo+ID4gPiBjb2xsZWN0aW9uIiBwYXRj
aCwgYXMgdGhlIChwcmVleGlzdGluZykgbWVtb3J5IGxlYWsgc2VlbXMgbG93ZXINCj4gPiA+IGlt
cGFjdA0KPiA+ID4gdGhhbiB0aGUgc2VydmVyIGhhbmcuDQo+ID4gDQo+ID4gSSBiZWxpZXZlIHlv
dSB3ZXJlIHByb2JhYmx5IHNlZWluZyB0aGUgZWZmZWN0IG9mIHRoZQ0KPiA+IGNhY2hlX2xpc3Rl
bmVyc19leGlzdCgpIHRlc3QsIHdoaWNoIGlzIGp1c3Qgd3JvbmcgZm9yIGFsbCBjYWNoZQ0KPiA+
IHVwY2FsbA0KPiA+IHVzZXJzIGV4Y2VwdCBpZG1hcHBlciBhbmQgc3ZjYXV0aF9nc3MuIFdlIHNo
b3VsZCBub3QgYmUgY3JlYXRpbmcNCj4gPiBuZWdhdGl2ZSBjYWNoZSBlbnRyaWVzIGp1c3QgYmVj
YXVzZSB0aGUgcnBjLm1vdW50ZCBkYWVtb24gaGFwcGVucw0KPiA+IHRvIGJlDQo+ID4gc2xvdyB0
byBjb25uZWN0IHRvIHRoZSB1cGNhbGwgcGlwZXMgd2hlbiBzdGFydGluZyB1cCwgb3IgYmVjYXVz
ZSBpdA0KPiA+IGNyYXNoZXMgYW5kIGZhaWxzIHRvIHJlc3RhcnQgY29ycmVjdGx5Lg0KPiA+IA0K
PiA+IFRoYXQncyB3aHksIHdoZW4gSSByZXN1Ym1pdHRlZCB0aGlzIHBhdGNoLCBJIGluY2x1ZGVk
IA0KPiA+IGh0dHBzOi8vZ2l0LmxpbnV4LW5mcy5vcmcvP3A9Y2VsL2NlbC0yLjYuZ2l0O2E9Y29t
bWl0ZGlmZjtoPWI4NDAyMjhjZDYwOTZiZWJlMTZiM2U0ZWI1ZDkzNTk3ZDBlMDJjNmQNCj4gPiAN
Cj4gPiB3aGljaCB0dXJucyBvZmYgdGhhdCBwYXJ0aWN1bGFyIHRlc3QgZm9yIGFsbCB0aGUgdXBj
YWxscyB0bw0KPiA+IHJwYy5tb3VudGQuDQo+IA0KPiBUaGUgaGFuZ3MgcGVyc2lzdCB3aXRoIHRo
YXQgcGF0Y2gsIGJ1dCBnbyBhd2F5IHdpdGggdGhlIGNoYW5nZSB0byB0aGUNCj4gY2FjaGVfaXNf
ZXhwaXJlZCgpIGxvZ2ljIGFib3ZlLg0KDQpGYWlyIGVub3VnaC4gRG8geW91IHdhbnQgdG8gc2Vu
ZCBDaHVjayBhIGZpeD8NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQg
bWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20N
Cg0KDQo=
