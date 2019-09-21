Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 046A2B9C19
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Sep 2019 06:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbfIUEL4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 21 Sep 2019 00:11:56 -0400
Received: from mail-eopbgr740113.outbound.protection.outlook.com ([40.107.74.113]:33056
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725440AbfIUELz (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 21 Sep 2019 00:11:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQRKalG0t0CtLSkO7p2OVAzQgUpWswQKcX7vl+bcrCpeu5SwQjEvkvaJa7JKs+LxXRLzYGaHo7RnGa0A35S6rGzMWPyji9NeyvysgOXBROihsBTUAPxyFrCKL2C5bmRnw1UdV4A+QI+LcptDBR3yXYrcTUa3pkCfp+HhdLerPkDQdXIM6RVXfRh+fgUIpX18tE+wwC/6bdWbgEAp3IvEY/Ma4grfMEOVEzxewa36QZDITcnvTaxek8UuYGrBinTAtE2k3SrcwdtmXSZYog/YdE/t0P+WbuDg1w8sWRNOHaIiWidfxuONiYnauP5azcNWS1efiNVB1MsagokTScWiXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqlWxMMf/eGbsn3I7WjKVgq1R9dBHpKrPS4vw+alhkE=;
 b=Ih+ZThxXZfDKe5fvbAmP83jcQjVQVJ+A02k9RtZ6dBcxLO5aeXp+OGE87R7YTcTfCbn4stXr25XZBKreNLbkKbIcsTHXaXgpWPNmD9gN0la4ghPi/2fo410ZsuHosZicYH3RyJ0BxPMplE+DiyVab42OjDnioR5k1Wv23ZZXcnETDcjkssd689zzTmBPaAntIrETtRRw6IdgnyuS6EM3kcqPW3/MS7bGCQAEPWVVENvAKdSWZC9LJsk7X4DO3sJ9T0ydFTWH2o7Cq44PdxVxcOPiGeyWhLu2gfQRX9vFRIhoE87f+T7PRPzKNj+YZ8PCZ/TkoKb+33TWBdz+kqSJyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqlWxMMf/eGbsn3I7WjKVgq1R9dBHpKrPS4vw+alhkE=;
 b=UIrpAe6J4FhQAO2XKwzmStAttmRDnBcaZalvvOjjNQUTPxfwaVQwujlZO6b6asZ0HftqqK2Jah31ZfUyiGRVQD6jH3N5PxuzXW5+qOOb9zJiUQCiuxzkyTlJPfSltQCghkuVhpSB/Y9qwsRLtKD6s+kfQk0FOnszdiS8TD/tujA=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1708.namprd13.prod.outlook.com (10.171.161.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.11; Sat, 21 Sep 2019 04:11:10 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::70fd:85c2:8ea9:a0b6]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::70fd:85c2:8ea9:a0b6%9]) with mapi id 15.20.2284.009; Sat, 21 Sep 2019
 04:11:10 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "aglo@umich.edu" <aglo@umich.edu>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>
Subject: Re: [PATCH v3 0/9] Various NFSv4 state error handling fixes
Thread-Topic: [PATCH v3 0/9] Various NFSv4 state error handling fixes
Thread-Index: AQHVb6YvpqT+ZgMdj0WRh1yuUsKhk6c1DbmAgAB4LIA=
Date:   Sat, 21 Sep 2019 04:11:10 +0000
Message-ID: <a2395c752a9c711ecfc54aebbbf6cade790a53e3.camel@hammerspace.com>
References: <20190920112348.69496-1-trond.myklebust@hammerspace.com>
         <CAN-5tyGGtASKYC2a+Y01Qr-qBBOT+ybAEokxQdZAyASpEYO+4A@mail.gmail.com>
In-Reply-To: <CAN-5tyGGtASKYC2a+Y01Qr-qBBOT+ybAEokxQdZAyASpEYO+4A@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f42f350-b813-442e-3f35-08d73e49bc48
x-ms-traffictypediagnostic: DM5PR13MB1708:
x-microsoft-antispam-prvs: <DM5PR13MB1708EDCE42C37B6539754632B88B0@DM5PR13MB1708.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0167DB5752
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(39830400003)(396003)(136003)(51914003)(199004)(189003)(76176011)(4326008)(2501003)(229853002)(25786009)(102836004)(256004)(99286004)(54906003)(6246003)(2171002)(26005)(6916009)(2351001)(71200400001)(71190400001)(14454004)(5660300002)(14444005)(6506007)(53546011)(6116002)(3846002)(6486002)(478600001)(76116006)(7736002)(305945005)(66066001)(118296001)(66946007)(86362001)(186003)(6512007)(91956017)(316002)(6436002)(2906002)(2616005)(66446008)(5640700003)(446003)(66556008)(8936002)(11346002)(66476007)(36756003)(1730700003)(81166006)(476003)(8676002)(486006)(81156014)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1708;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w4l47NkGZN8eIjzwYlSufxk4SrBgzDOhJFsXkN2CFTzAIh7KFW0n+cvHJJaBDU6jTZdm02HS1t4DviGLPes8lPS9YodNE9GQJFQ3up+rgQt6E4A/yxWLBGtsew7bMfBDlFrb5mvQDgkN5lkAi/qvxyh/pBiazE67gVwZkxCvJR8dG4YZLYQbFsbpBnUBU0N03C5BLFRO8X9cGuTEqO9A5A/RqPGUk+EeEc71LWAXK1Olt13XEiSnYQbN8xbk0Q3TS5CWnHP+byD8n9rCWVWBKolmFhb97CQ0HuNLQVfJpHmFD3hB1xFvf/iaOZRaIce8/J3lEmowz4ca1sgg3TKbzncnic/DiM7DHEoAYXptgG+MsASxM1/nMXkg0vYgr4abQhKDQKQEwjqeZWIdizMHp7PROt5MzRXw87sqCt5lw40=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D004FB5CABA714EBA6CF0D813FC148B@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f42f350-b813-442e-3f35-08d73e49bc48
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2019 04:11:10.8060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OMlJ8FCuLXmp6OVTh71zf60syHoE3Gi+KjiNjCvoKssp3K8vYDcf4tSmAYYz+yqUm2x58HKSPdstpZXEv+SNqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1708
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgT2xnYQ0KDQpPbiBGcmksIDIwMTktMDktMjAgYXQgMTc6MDEgLTA0MDAsIE9sZ2EgS29ybmll
dnNrYWlhIHdyb3RlOg0KPiBIaSBUcm9uZCwNCj4gDQo+IFRoaXMgdmVyc2lvbiB3b3JrcyBmb3Ig
bWUuIEkgd2VudCBiYWNrIHRvIHYyIGFuZCB2ZXJpZmllZCB0aGF0IGl0DQo+IGRpZG4ndCB3b3Jr
IHNvIHdoYXRldmVyIHlvdSBkaWQgaGVyZSBmaXhlZCBpdCBmb3IgbWUuDQo+IA0KDQpUaGF0IGhh
cyBtZSBhIGxpdHRsZSBjb25mdXNlZCBiZWNhdXNlIEkgY2FuJ3QgcmVhbGx5IHNlZSBob3cgdGhl
IGxhY2sNCm9mIHNwaW5sb2NrcyBjb3VsZCBjYXVzZSBpbmNvcnJlY3QgYmVoYXZpb3VyIHRoYXQg
Y29uc2lzdGVudGx5LCBob3dldmVyDQpJJ20gZmluZSB3aXRoIHRoZSByZXN1bHQuIOKYug0KDQpU
aGFua3MgZm9yIHRoZSBoZWxwIHdpdGggdGVzdGluZyENCg0KVHJvbmQNCg0KPiBPbiBGcmksIFNl
cCAyMCwgMjAxOSBhdCA3OjI2IEFNIFRyb25kIE15a2xlYnVzdCA8dHJvbmRteUBnbWFpbC5jb20+
DQo+IHdyb3RlOg0KPiA+IFZhcmlvdXMgTkZTdjQgZml4ZXMgdG8gZW5zdXJlIHdlIGhhbmRsZSBz
dGF0ZSBlcnJvcnMgY29ycmVjdGx5LiBJbg0KPiA+IHBhcnRpY3VsYXIsIHdlIG5lZWQgdG8gZW5z
dXJlIHRoYXQgZm9yIENPTVBPVU5EcyBsaWtlIENMT1NFIGFuZA0KPiA+IERFTEVHUkVUVVJOLCB0
aGF0IG1heSBoYXZlIGFuIGVtYmVkZGVkIExBWU9VVFJFVFVSTiwgd2UgaGFuZGxlIHRoZQ0KPiA+
IGxheW91dCBzdGF0ZSBlcnJvcnMgc28gdGhhdCBhIHJldHJ5IG9mIGVpdGhlciB0aGUgTEFZT1VU
UkVUVVJOLCBvcg0KPiA+IHRoZSBsYXRlciBDTE9TRS9ERUxFR1JFVFVSTiBkb2VzIG5vdCBjb3Jy
dXB0IHRoZSBMQVlPVVRSRVRVUk4NCj4gPiByZXBseS4NCj4gPiANCj4gPiBBbHNvIGVuc3VyZSB0
aGF0IGlmIHdlIGdldCBhIE5GUzRFUlJfT0xEX1NUQVRFSUQsIHRoZW4gd2UgZG8gb3VyDQo+ID4g
YmVzdCB0byBzdGlsbCB0cnkgdG8gZGVzdHJveSB0aGUgc3RhdGUgb24gdGhlIHNlcnZlciwgaW4g
b3JkZXIgdG8NCj4gPiBhdm9pZCBjYXVzaW5nIHN0YXRlIGxlYWthZ2UuDQo+ID4gDQo+ID4gdjI6
IEZpeCBidWcgcmVwb3J0cyBmcm9tIE9sZ2ENCj4gPiAgLSBUcnkgdG8gYXZvaWQgc2VuZGluZyBv
bGQgc3RhdGVpZHMgb24gQ0xPU0UvT1BFTl9ET1dOR1JBREUgd2hlbg0KPiA+ICAgIGRvaW5nIGZ1
bGx5IHNlcmlhbGlzZWQgTkZTdjQuMC4NCj4gPiAgLSBFbnN1cmUgTE9DS1UgaW5pdGlhbGlzZXMg
dGhlIHN0YXRlaWQgY29ycmVjdGx5Lg0KPiA+IHYzOiBGaXggbG9ja2luZw0KPiA+ICAtIEVuc3Vy
ZSB0aGUgcGF0Y2ggIkhhbmRsZSBORlM0RVJSX09MRF9TVEFURUlEIGluIExPQ0tVIiBsb2NrcyB0
aGUNCj4gPiAgICBzdGF0ZWlkIHdoZW4gY29weWluZyBpdCBpbiBuZnM0X2FsbG9jX3VubG9ja2Rh
dGEoKS4NCj4gPiANCj4gPiBUcm9uZCBNeWtsZWJ1c3QgKDkpOg0KPiA+ICAgcE5GUzogRW5zdXJl
IHdlIGRvIGNsZWFyIHRoZSByZXR1cm4tb24tY2xvc2UgbGF5b3V0IHN0YXRlaWQgb24NCj4gPiBm
YXRhbA0KPiA+ICAgICBlcnJvcnMNCj4gPiAgIE5GU3Y0OiBDbGVhbiB1cCBwTkZTIHJldHVybi1v
bi1jbG9zZSBlcnJvciBoYW5kbGluZw0KPiA+ICAgTkZTdjQ6IEhhbmRsZSBORlM0RVJSX0RFTEFZ
IGNvcnJlY3RseSBpbiByZXR1cm4tb24tY2xvc2UNCj4gPiAgIE5GU3Y0OiBIYW5kbGUgUlBDIGxl
dmVsIGVycm9ycyBpbiBMQVlPVVRSRVRVUk4NCj4gPiAgIE5GU3Y0OiBBZGQgYSBoZWxwZXIgdG8g
aW5jcmVtZW50IHN0YXRlaWQgc2VxaWRzDQo+ID4gICBwTkZTOiBIYW5kbGUgTkZTNEVSUl9PTERf
U1RBVEVJRCBvbiBsYXlvdXRyZXR1cm4gYnkgYnVtcGluZyB0aGUNCj4gPiBzdGF0ZQ0KPiA+ICAg
ICBzZXFpZA0KPiA+ICAgTkZTdjQ6IEZpeCBPUEVOX0RPV05HUkFERSBlcnJvciBoYW5kbGluZw0K
PiA+ICAgTkZTdjQ6IEhhbmRsZSBORlM0RVJSX09MRF9TVEFURUlEIGluIENMT1NFL09QRU5fRE9X
TkdSQURFDQo+ID4gICBORlN2NDogSGFuZGxlIE5GUzRFUlJfT0xEX1NUQVRFSUQgaW4gTE9DS1UN
Cj4gPiANCj4gPiAgZnMvbmZzL25mczRfZnMuaCAgIHwgIDExICsrLQ0KPiA+ICBmcy9uZnMvbmZz
NHByb2MuYyAgfCAyMDkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tDQo+
ID4gLS0tLS0tDQo+ID4gIGZzL25mcy9uZnM0c3RhdGUuYyB8ICAxNiAtLS0tDQo+ID4gIGZzL25m
cy9wbmZzLmMgICAgICB8ICA3MSArKysrKysrKysrKysrLS0NCj4gPiAgZnMvbmZzL3BuZnMuaCAg
ICAgIHwgIDE3ICsrKy0NCj4gPiAgNSBmaWxlcyBjaGFuZ2VkLCAyMzMgaW5zZXJ0aW9ucygrKSwg
OTEgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gLS0NCj4gPiAyLjIxLjANCj4gPiANCi0tIA0KVHJv
bmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0
cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
