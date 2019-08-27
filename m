Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C01A9DAD8
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2019 02:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbfH0A4K (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Aug 2019 20:56:10 -0400
Received: from mail-eopbgr780098.outbound.protection.outlook.com ([40.107.78.98]:33968
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726543AbfH0A4K (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 26 Aug 2019 20:56:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8Mk3fdU5CUJ0DNAezaPGjhmFFvS0iuK7y4C9/wlWrAXPtPbjrlLHQWxoaWKSv7NF2QB3TA1dok1A0hrksXKo+UzUYH2DaMglE3KYEOE37916o3imJb9PTMiBnjaLsT+Rpduh1x3NUzXN34MU5k9UPPzzj8lVydtSHTR3Y2Rmu7wXlj2ahNzY5f8m78XH8kRyEq09h3RtyCDW4Nr5wQWLFbPyWJT6FZ7hFgHb5w7b8caDp0Jp9mQv5lYvV5exqXArAwGAICZrkVgfTYtdLPn79Fem+U52zODr8TpsZp0qLT6SAAKhLRSgavudWMYk/nQyX0Q2EdcGAviZ05YbLdfog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLcOFMK+Z3QUEr4AUEkASCZPQCv+uKhR5tqMSTrLq+I=;
 b=hIgSpXBNoQQVKT61RvUE4pg3PBXkqxOwBsZRGpg62ZlHOiMbJ4IKHaJQX+rjkQvgclm557EpS2DMDqf59NeQ0jHWC2jY65SQYx2SJfvYGYLdORiCqoKLRE9qQq5sfCbeCtWIb8RQZNbYquAx+ubsS4S5fldMAg/r854KTboKPD76DYQYoK/BbfRt0rCnvOuBSJXilF5pwYCnppMC+/LN0Wu8stpVy23I+DQTNOqO7MN333z3dyS4vghe5a/6Ba4xCnui/7wEMGVeGC889Qi1L3kxqYJ3InZ1D4D3/Gju3EtBp0K7oDvHxneY+cmSYb//IczSG899JoPb/qmkSXPM9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLcOFMK+Z3QUEr4AUEkASCZPQCv+uKhR5tqMSTrLq+I=;
 b=PRDHYF/TnSsfbQ/6H8cFjtQH1jzNg0LFJ4p5DaUW0rXCNMI55vLORWKbY4tmjxJ6+mzXLJOsyRFVrrLyDhq7xkar+RB12YKJoAY9l8aus4HJsVBUHm7vZynxdXOLO0wt8uWCgZOnrJEH6A6LE3gO3SIiXQNcjfyXR23wopgPsuM=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1833.namprd13.prod.outlook.com (10.171.156.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.12; Tue, 27 Aug 2019 00:56:08 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::5d60:e645:84a2:be75]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::5d60:e645:84a2:be75%7]) with mapi id 15.20.2220.013; Tue, 27 Aug 2019
 00:56:08 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>
Subject: Re: [PATCH 0/3] Handling NFSv3 I/O errors in knfsd
Thread-Topic: [PATCH 0/3] Handling NFSv3 I/O errors in knfsd
Thread-Index: AQHVXC7WXUD5cV8FEUS4EYbsSk6I0qcN59MAgAAC84CAAD8PgIAAAjcA
Date:   Tue, 27 Aug 2019 00:56:07 +0000
Message-ID: <a2045dcd33d7f53fadd50212160c531c2e0c236f.camel@hammerspace.com>
References: <20190826165021.81075-1-trond.myklebust@hammerspace.com>
         <20190826205156.GA27834@fieldses.org>
         <ef9f2791ef395d7c968a386ce0a32ea503d6478f.camel@hammerspace.com>
         <20190827004811.GA30827@fieldses.org>
In-Reply-To: <20190827004811.GA30827@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4204ba6-0af6-401c-b4d8-08d72a89589c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1833;
x-ms-traffictypediagnostic: DM5PR13MB1833:
x-microsoft-antispam-prvs: <DM5PR13MB1833671FC14EAF79BEDDCC7EB8A00@DM5PR13MB1833.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(39840400004)(136003)(366004)(52314003)(199004)(189003)(6116002)(2501003)(6436002)(305945005)(6916009)(14454004)(476003)(11346002)(53936002)(6512007)(14444005)(256004)(91956017)(2351001)(76116006)(6486002)(36756003)(2616005)(66946007)(71200400001)(71190400001)(99286004)(486006)(446003)(6246003)(5640700003)(3846002)(54906003)(8676002)(316002)(25786009)(66556008)(64756008)(66446008)(5660300002)(66476007)(86362001)(118296001)(2906002)(229853002)(186003)(102836004)(4326008)(8936002)(26005)(81166006)(81156014)(1730700003)(7736002)(76176011)(66066001)(6506007)(478600001)(17423001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1833;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jJu+hoDHNp3o87CxDGa9xv3PgpAFtYlCTc8Al/wfjoWg6lj/nnSA/tiNl4QFDSHttvoJG80sx/6H66Xubsv6UsUKzV/jf80TpCwkeUdTZolGZ5XkWoS91wozWN82PsE3gUUhjs3Hlw9LK6LDAC49WPN7fGTmFWfk7u7gapSMhgtCCnaKCcTiS6+bL07lDaAdd/qHmnu48JS73lArN+JAQ43fFSmXDmnvtbxZ6CLHewitK5Oow6uAa1eMhcgDIXCAuliMrrGxhcInlp+b1gKn96CboFptdbo2keEEypoDW9u4/7RaJQHukdyK80eDi4vdWbCEGXRcMA600P2XdSGSXQkXrfULqnoyfRJMEziP3NPpyJ465OVlIvKPof13F/GzNTvzMljdw/yK8b7a7tvDoBVEj2tb/82ZOQCnNV0VE+M=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <54C8AE408B50C548815F9893BCB0A40B@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4204ba6-0af6-401c-b4d8-08d72a89589c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 00:56:07.9896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pq3nxprxWnDCGTznFURN3E9BatswhtEZsW1nsmVM855TrnYbEKcx1VPbFtLNOji+mjPU5LPyScPLgviHazYo0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1833
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDE5LTA4LTI2IGF0IDIwOjQ4IC0wNDAwLCBiZmllbGRzQGZpZWxkc2VzLm9yZyB3
cm90ZToNCj4gT24gTW9uLCBBdWcgMjYsIDIwMTkgYXQgMDk6MDI6MzFQTSArMDAwMCwgVHJvbmQg
TXlrbGVidXN0IHdyb3RlOg0KPiA+IE9uIE1vbiwgMjAxOS0wOC0yNiBhdCAxNjo1MSAtMDQwMCwg
Si4gQnJ1Y2UgRmllbGRzIHdyb3RlOg0KPiA+ID4gT24gTW9uLCBBdWcgMjYsIDIwMTkgYXQgMTI6
NTA6MThQTSAtMDQwMCwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOg0KPiA+ID4gPiBSZWNlbnRseSwg
YSBudW1iZXIgb2YgY2hhbmdlcyB3ZW50IGludG8gdGhlIGtlcm5lbCB0byB0cnkgdG8NCj4gPiA+
ID4gZW5zdXJlIHRoYXQgSS9PIGVycm9ycyAoc3BlY2lmaWNhbGx5IHdyaXRlIGVycm9ycykgYXJl
IHJlcG9ydGVkDQo+ID4gPiA+IHRvDQo+ID4gPiA+IHRoZSBhcHBsaWNhdGlvbiBvbmNlIGFuZCBv
bmx5IG9uY2UuIFRoZSB2ZWhpY2xlIGZvciBlbnN1cmluZw0KPiA+ID4gPiB0aGUNCj4gPiA+ID4g
ZXJyb3JzIGFyZSByZXBvcnRlZCBpcyB0aGUgc3RydWN0IGZpbGUsIHdoaWNoIHVzZXMgdGhlDQo+
ID4gPiA+ICdmX3diX2VycicNCj4gPiA+ID4gZmllbGQgdG8gdHJhY2sgd2hpY2ggZXJyb3JzIGhh
dmUgYmVlbiByZXBvcnRlZC4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoZSBwcm9ibGVtIGlzIHRoYXQg
ZXJyb3JzIGFyZSBtYWlubHkgaW50ZW5kZWQgdG8gYmUgcmVwb3J0ZWQNCj4gPiA+ID4gdGhyb3Vn
aCBmc3luYygpLiBJZiB0aGUgY2xpZW50IGlzIGRvaW5nIHN5bmNocm9ub3VzIHdyaXRlcywNCj4g
PiA+ID4gdGhlbg0KPiA+ID4gPiBhbGwgaXMgd2VsbCwgYnV0IGlmIGl0IGlzIGRvaW5nIHVuc3Rh
YmxlIHdyaXRlcywgdGhlbiB0aGUNCj4gPiA+ID4gZXJyb3JzDQo+ID4gPiA+IG1heSBub3QgYmUg
cmVwb3J0ZWQgdW50aWwgdGhlIGNsaWVudCBjYWxscyBDT01NSVQuIElmIHRoZSBmaWxlDQo+ID4g
PiA+IGNhY2hlIGhhcyB0aHJvd24gb3V0IHRoZSBzdHJ1Y3QgZmlsZSwgZHVlIHRvIG1lbW9yeSBw
cmVzc3VyZSwNCj4gPiA+ID4gb3INCj4gPiA+ID4ganVzdCBiZWNhdXNlIHRoZSBjbGllbnQgdG9v
ayBhIGxvbmcgd2hpbGUgYmV0d2VlbiB0aGUgbGFzdA0KPiA+ID4gPiBXUklURQ0KPiA+ID4gPiBh
bmQgdGhlIENPTU1JVCwgdGhlbiB0aGUgZXJyb3IgcmVwb3J0IG1heSBiZSBsb3N0LCBhbmQgdGhl
DQo+ID4gPiA+IGNsaWVudA0KPiA+ID4gPiBtYXkganVzdCB0aGluayBpdHMgZGF0YSBpcyBzYWZl
bHkgc3RvcmVkLg0KPiA+ID4gDQo+ID4gPiBUaGVzZSB3ZXJlIGxvc3QgYmVmb3JlIHRoZSBmaWxl
IGNhY2hpbmcgcGF0Y2hlcyBhcyB3ZWxsLA0KPiA+ID4gcmlnaHQ/ICBPcg0KPiA+ID4gaXMgdGhl
cmUgc29tZSByZWdyZXNzaW9uPyANCj4gPiANCj4gPiBDb3JyZWN0LiBUaGlzIGlzIG5vdCBhIHJl
Z3Jlc3Npb24sIGJ1dCBhbiBhdHRlbXB0IHRvIGZpeCBhIHByb2JsZW0NCj4gPiB0aGF0IGhhcyBl
eGlzdGVkIGZvciBzb21lIHRpbWUgbm93Lg0KPiA+IA0KPiA+ID4gPiBOb3RlIHRoYXQgdGhlIHBy
b2JsZW0gaXMgY29tcG91bmRlZCBieSB0aGUgZmFjdCB0aGF0IE5GU3YzIGlzDQo+ID4gPiA+IHN0
YXRlbGVzcywgc28gdGhlIHNlcnZlciBuZXZlciBrbm93cyB0aGF0IHRoZSBjbGllbnQgbWF5IGhh
dmUNCj4gPiA+ID4gcmVib290ZWQsIHNvIHRoZXJlIGNhbiBiZSBubyBndWFyYW50ZWUgdGhhdCBh
IENPTU1JVCB3aWxsIGV2ZXINCj4gPiA+ID4gYmUNCj4gPiA+ID4gc2VudC4NCj4gPiA+ID4gDQo+
ID4gPiA+IFRoZSBmb2xsb3dpbmcgcGF0Y2ggc2V0IGF0dGVtcHRzIHRvIHJlbWVkeSB0aGUgc2l0
dWF0aW9uIHVzaW5nDQo+ID4gPiA+IDINCj4gPiA+ID4gc3RyYXRlZ2llczoNCj4gPiA+ID4gDQo+
ID4gPiA+IDEpIElmIHRoZSBpbm9kZSBpcyBkaXJ0eSwgdGhlbiBhdm9pZCBnYXJiYWdlIGNvbGxl
Y3RpbmcgdGhlDQo+ID4gPiA+IGZpbGUNCj4gPiA+ID4gZnJvbSB0aGUgZmlsZSBjYWNoZS4gIDIp
IElmIHRoZSBmaWxlIGlzIGNsb3NlZCwgYW5kIHdlIHNlZSB0aGF0DQo+ID4gPiA+IGl0DQo+ID4g
PiA+IHdvdWxkIGhhdmUgcmVwb3J0ZWQgYW4gZXJyb3IgdG8gQ09NTUlULCB0aGVuIHdlIGJ1bXAg
dGhlIGJvb3QNCj4gPiA+ID4gdmVyaWZpZXIgaW4gb3JkZXIgdG8gZW5zdXJlIHRoZSBjbGllbnQg
cmV0cmFuc21pdHMgYWxsIGl0cw0KPiA+ID4gPiB3cml0ZXMuDQo+ID4gPiANCj4gPiA+IFNvdW5k
cyBzZW5zaWJsZSB0byBtZS4NCj4gPiA+IA0KPiA+ID4gPiBOb3RlIHRoYXQgaWYgbXVsdGlwbGUg
Y2xpZW50cyB3ZXJlIHdyaXRpbmcgdG8gdGhlIHNhbWUgZmlsZSwNCj4gPiA+ID4gdGhlbg0KPiA+
ID4gPiB3ZSBwcm9iYWJseSB3YW50IHRvIGJ1bXAgdGhlIGJvb3QgdmVyaWZpZXIgYW55d2F5LCBz
aW5jZSBvbmx5DQo+ID4gPiA+IG9uZQ0KPiA+ID4gPiBDT01NSVQgd2lsbCBzZWUgdGhlIGVycm9y
IHJlcG9ydCAoYmVjYXVzZSB0aGUgY2FjaGVkIGZpbGUgaXMNCj4gPiA+ID4gYWxzbw0KPiA+ID4g
PiBzaGFyZWQpLg0KPiA+ID4gDQo+ID4gPiBJJ20gY29uZnVzZWQgYnkgdGhlICJwcm9iYWJseSBz
aG91bGQiLiAgU28gdGhhdCdzIGZ1dHVyZSB3b3JrPyAgSQ0KPiA+ID4gZ3Vlc3MgaXQnZCBtZWFu
IHNvbWUgYWRkaXRpb25hbCB3b3JrIHRvIGlkZW50aWZ5IHRoYXQgY2FzZS4gIFlvdQ0KPiA+ID4g
Y2FuJ3QgcmVhbGx5IGV2ZW4gZGlzdGluZ3Vpc2ggY2xpZW50cyBpbiB0aGUgTkZTdjMgY2FzZSwg
YnV0IEkNCj4gPiA+IHN1cHBvc2UgeW91IGNvdWxkIHVzZSBJUCBhZGRyZXNzIG9yIFRDUCBjb25u
ZWN0aW9uIGFzIGFuDQo+ID4gPiBhcHByb3hpbWF0aW9uLg0KPiA+IA0KPiA+IEknbSBzdWdnZXN0
aW5nIHdlIHNob3VsZCBkbyB0aGlzIHRvbywgYnV0IEkgaGF2ZW4ndCBkb25lIHNvIHlldCBpbg0K
PiA+IHRoZXNlIHBhdGNoZXMuIEknZCBsaWtlIHRvIGhlYXIgb3RoZXIgb3BpbmlvbnMgKHBhcnRp
Y3VsYXJseSBmcm9tDQo+ID4geW91LA0KPiA+IENodWNrIGFuZCBKZWZmKS4NCj4gDQo+IERvZXMg
dGhpcyBwcm9jZXNzIGFjdHVhbGx5IGNvbnZlcmdlLCBvciBkbyB3ZSBlbmQgdXAgd2l0aCBhbGwg
dGhlDQo+IGNsaWVudHMgcmV0cnlpbmcgdGhlIHdyaXRlcyBhbmQsIGFnYWluLCBvbmx5IG9uZSBv
ZiB0aGVtIGdldHRpbmcgdGhlDQo+IGVycm9yPw0KDQpUaGUgY2xpZW50IHRoYXQgZ2V0cyB0aGUg
ZXJyb3Igc2hvdWxkIHN0b3AgcmV0cnlpbmcgaWYgdGhlIGVycm9yIGlzDQpmYXRhbC4NCg0KPiBJ
IHdvbmRlciB3aGF0IHRoZSB0eXBpY2FsIGVycm9ycyBhcmUsIGFueXdheS4NCg0KSSB3b3VsZCBl
eHBlY3QgRU5PU1BDLCBhbmQgRUlPIHRvIGJlIHRoZSBtb3N0IGNvbW1vbi4gVGhlIGZvcm1lciBp
Zg0KZGVsYXllZCBhbGxvY2F0aW9uIGFuZC9vciBzbmFwc2hvdHMgcmVzdWx0IGluIHdyaXRlcyBm
YWlsaW5nIGFmdGVyDQp3cml0aW5nIHRvIHRoZSBwYWdlIGNhY2hlLiBUaGUgbGF0dGVyIGlmIHdl
IGhpdCBhIGRpc2sgb3V0YWdlIG9yIG90aGVyDQpzdWNoIHByb2JsZW0uDQoNCi0tIA0KVHJvbmQg
TXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9u
ZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
