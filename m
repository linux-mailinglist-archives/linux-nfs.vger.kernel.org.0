Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 937961764B5
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Mar 2020 21:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgCBUM6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Mar 2020 15:12:58 -0500
Received: from mail-bn7nam10on2123.outbound.protection.outlook.com ([40.107.92.123]:4961
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725446AbgCBUM5 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 2 Mar 2020 15:12:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afCrxgNbEUrxUNR1S+e972Js6B6oT585xH7DvGzM0WoL8ExsOJvXwO2aiALAAtyf9jg5DGhBtutcfL46OzhfOLTjnDjfmGGfz3X9Q0gWFdZFBhCJkaGM5FguesfPsNHr3Ybww8q8SouoteIq7fYT/t6UMd6c5mSDL2+flr+8cuwfGAXEYh+4z0wGdWhdCELtN8ElV6YioLPVqx+cgEytFt1asxJ0A0qzenp/vU44UPiEmemwzBQEEEEWQ7+nCmgq4Cs2w3EJyWKryniWXsjxTXUKPV5NVq4kTWeNJJ1zQ4zjwX+MFob48aqegu28Sx90EvlQa/o63CFdYelj7QQMmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qigH3wcLAVIu+FYKtSGBidhPRpXUiY0SLUyOJbctnXY=;
 b=XXi3iBL86CTTawZNtmg1ReToXNC0jsPuUbDcMlebbqYIOxpxThRnIsnE2/mCdCq2h0R06sVBymVdOBdngKv8vDhOyMzI0roq3Oyj294r5+PvevVEEceJPLETnih0bsGM8lB7by2m8iZKuJ8oaZ8E9fFYo67efbzab8QWzEkbAM3DztiuHjHHz7RQ3mcdoRIw7YUB2h34tX3esIF/Trj1GMn6olWmfLrVt6ClryW+YnSlz0lpAH+K7WF+a+vDVERwoQzjn+esSc0+O5muJ9MX6/6ibMFWOGs8ht7RhLMV5fZa7l0fffeJKL6B2HHhWqd42KLPA5EXGlvILVh6llCLNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qigH3wcLAVIu+FYKtSGBidhPRpXUiY0SLUyOJbctnXY=;
 b=R7SuW2DuFg92gwtyA7l48IxJ+MLAxdEwpL+KduY53xiRXui4anAvtO8Hwb1XCkbYwj9OCPQGPjGVu/4zPgGgkiDolday95/lK5sFFNMl6QtdJ9GWYubFqufxI5RHR3V6cqZ6DcNkHurBlrTTw8lUXUHkjVbGcn52yM0r0xChNYg=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (2603:10b6:4:34::34)
 by DM5PR1301MB2010.namprd13.prod.outlook.com (2603:10b6:4:32::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.15; Mon, 2 Mar
 2020 20:12:52 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344%3]) with mapi id 15.20.2793.011; Mon, 2 Mar 2020
 20:12:52 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dwysocha@redhat.com" <dwysocha@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>
Subject: Re: [PATCH 8/8] sunrpc: Drop the connection when the server drops a
 request
Thread-Topic: [PATCH 8/8] sunrpc: Drop the connection when the server drops a
 request
Thread-Index: AQHV8CCww/IlmEuypkm7SA6Gv+qpPKg1fpWAgAA/DgA=
Date:   Mon, 2 Mar 2020 20:12:51 +0000
Message-ID: <32be2fbebcd4e30567f54c830e23a0ef35a4844e.camel@hammerspace.com>
References: <20200301232145.1465430-1-trond.myklebust@hammerspace.com>
         <20200301232145.1465430-2-trond.myklebust@hammerspace.com>
         <20200301232145.1465430-3-trond.myklebust@hammerspace.com>
         <20200301232145.1465430-4-trond.myklebust@hammerspace.com>
         <20200301232145.1465430-5-trond.myklebust@hammerspace.com>
         <20200301232145.1465430-6-trond.myklebust@hammerspace.com>
         <20200301232145.1465430-7-trond.myklebust@hammerspace.com>
         <20200301232145.1465430-8-trond.myklebust@hammerspace.com>
         <20200301232145.1465430-9-trond.myklebust@hammerspace.com>
         <CALF+zOkJPkYaXjCn-tj0dPCQUAjA05zyzxm5fzwoB-XP0SGYvw@mail.gmail.com>
In-Reply-To: <CALF+zOkJPkYaXjCn-tj0dPCQUAjA05zyzxm5fzwoB-XP0SGYvw@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07309c14-2429-45b7-66e8-08d7bee61638
x-ms-traffictypediagnostic: DM5PR1301MB2010:
x-microsoft-antispam-prvs: <DM5PR1301MB2010A3D1ACC40755E376FDE6B8E70@DM5PR1301MB2010.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(396003)(376002)(346002)(39830400003)(189003)(199004)(86362001)(76116006)(81156014)(6512007)(81166006)(8676002)(478600001)(71200400001)(26005)(2906002)(2616005)(8936002)(186003)(6506007)(53546011)(5660300002)(966005)(36756003)(6486002)(54906003)(66476007)(6916009)(4326008)(91956017)(66556008)(66446008)(316002)(64756008)(66946007)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB2010;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l+MxdXd3Q8HsO546+8V43GS8NQDlVRQxPj8pncUJV3EbX8nu51pLDqJ10ZQ6ltaC7Xbe/PYYQWlnUwE+Wsmn0K4bsMMJc+219LtE1DmCsRPAxjhZ+WIJuOxCxr5/5yxo3ZPI2PMj0JmMSZDBwp3VTGduk/VUgbKsHlIOUlKSI0zcIH35cJpaRpv90GhkiohgD5EJIlnk2eC9v6HIqjK47Yg3pT4t3OrDyFdrUCSDfq9YLhHWdCLZMAeUspuW6DkMs3IecnAsXUcwuNpTYJ/hzzULezqCFkhLgOf/0JuoAcIVBTzQ4eh49V6Jlv0TUPJcOSUmclwGmWI11g0aat0I4cxC0+Y8hM+YkF+r/ybiGu83BtifQDbwT4/tKSxTl0PdAmH51901TZpUAFxQvQdMKvn711fiDbxaojw71LBSZsbque9aaS9sPlmpw7P6ahEvAnyaob9r1389+ZTY6MQbK13w+Y2Xyj0LNSVX2MgpIOjc9DmNuicC8JAymQm44TVbYJ5eBaQy6tdcQGRe/Q4BvuY9v5xHr/wM9avWrFMDHawPPc52C8DryE8bznQty3iz
x-ms-exchange-antispam-messagedata: YqfsoZ8B2JonqfwmBjuq6qOkf8eh00OFn/KKgO5m/qLLVkBX/lrN7R3iDjVfgVXhoHpLnBdqowlgI886ZaDK/8BafCvu1ewfetqaJe+69fVLHyjvnK3c5XuqfXG7GQY9lJtmj/C+g4GTbrY1CqNjYA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5EACCB494737645B5B3CBE73CD4C576@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07309c14-2429-45b7-66e8-08d7bee61638
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 20:12:51.9365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dF+sRXkYhmMd7ebZxgoQUMbcNq8Vm8eUVM0/DBFfXFtP9l6+tuugH6yEUc2+QkVs7YN4RnrgAj0ctA1MeW8iKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2010
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIwLTAzLTAyIGF0IDExOjI3IC0wNTAwLCBEYXZpZCBXeXNvY2hhbnNraSB3cm90
ZToNCj4gT24gU3VuLCBNYXIgMSwgMjAyMCBhdCA2OjI1IFBNIFRyb25kIE15a2xlYnVzdCA8dHJv
bmRteUBnbWFpbC5jb20+DQo+IHdyb3RlOg0KPiA+IElmIGEgc2VydmVyIHdhbnRzIHRvIGRyb3Ag
YSByZXF1ZXN0LCB0aGVuIGl0IHNob3VsZCBhbHNvIGRyb3AgdGhlDQo+ID4gY29ubmVjdGlvbiwg
aW4gb3JkZXIgdG8gbGV0IHRoZSBjbGllbnQga25vdy4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5
OiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+DQo+ID4g
LS0tDQo+ID4gIG5ldC9zdW5ycGMvc3ZjX3hwcnQuYyB8IDEwICsrKysrKysrKysNCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvbmV0
L3N1bnJwYy9zdmNfeHBydC5jIGIvbmV0L3N1bnJwYy9zdmNfeHBydC5jDQo+ID4gaW5kZXggZGUz
YzA3NzczM2E3Li44M2E1MjdlNTZjODcgMTAwNjQ0DQo+ID4gLS0tIGEvbmV0L3N1bnJwYy9zdmNf
eHBydC5jDQo+ID4gKysrIGIvbmV0L3N1bnJwYy9zdmNfeHBydC5jDQo+ID4gQEAgLTg3Myw2ICs4
NzMsMTMgQEAgaW50IHN2Y19yZWN2KHN0cnVjdCBzdmNfcnFzdCAqcnFzdHAsIGxvbmcNCj4gPiB0
aW1lb3V0KQ0KPiA+ICB9DQo+ID4gIEVYUE9SVF9TWU1CT0xfR1BMKHN2Y19yZWN2KTsNCj4gPiAN
Cj4gPiArc3RhdGljIHZvaWQgc3ZjX2Ryb3BfY29ubmVjdGlvbihzdHJ1Y3Qgc3ZjX3hwcnQgKnhw
cnQpDQo+ID4gK3sNCj4gPiArICAgICAgIGlmICh0ZXN0X2JpdChYUFRfVEVNUCwgJnhwcnQtPnhw
dF9mbGFncykgJiYNCj4gPiArICAgICAgICAgICAhdGVzdF9hbmRfc2V0X2JpdChYUFRfQ0xPU0Us
ICZ4cHJ0LT54cHRfZmxhZ3MpKQ0KPiA+ICsgICAgICAgICAgICAgICBzdmNfeHBydF9lbnF1ZXVl
KHhwcnQpOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICAvKg0KPiA+ICAgKiBEcm9wIHJlcXVlc3QNCj4g
PiAgICovDQo+ID4gQEAgLTg4MCw2ICs4ODcsOCBAQCB2b2lkIHN2Y19kcm9wKHN0cnVjdCBzdmNf
cnFzdCAqcnFzdHApDQo+ID4gIHsNCj4gPiAgICAgICAgIHRyYWNlX3N2Y19kcm9wKHJxc3RwKTsN
Cj4gPiAgICAgICAgIGRwcmludGsoInN2YzogeHBydCAlcCBkcm9wcGVkIHJlcXVlc3RcbiIsIHJx
c3RwLT5ycV94cHJ0KTsNCj4gPiArICAgICAgIC8qIENsb3NlIHRoZSBjb25uZWN0aW9uIHdoZW4g
ZHJvcHBpbmcgYSByZXF1ZXN0ICovDQo+ID4gKyAgICAgICBzdmNfZHJvcF9jb25uZWN0aW9uKHJx
c3RwLT5ycV94cHJ0KTsNCj4gPiAgICAgICAgIHN2Y194cHJ0X3JlbGVhc2UocnFzdHApOw0KPiA+
ICB9DQo+ID4gIEVYUE9SVF9TWU1CT0xfR1BMKHN2Y19kcm9wKTsNCj4gPiBAQCAtMTE0OCw2ICsx
MTU3LDcgQEAgc3RhdGljIHZvaWQgc3ZjX3JldmlzaXQoc3RydWN0DQo+ID4gY2FjaGVfZGVmZXJy
ZWRfcmVxICpkcmVxLCBpbnQgdG9vX21hbnkpDQo+ID4gICAgICAgICBpZiAodG9vX21hbnkgfHwg
dGVzdF9iaXQoWFBUX0RFQUQsICZ4cHJ0LT54cHRfZmxhZ3MpKSB7DQo+ID4gICAgICAgICAgICAg
ICAgIHNwaW5fdW5sb2NrKCZ4cHJ0LT54cHRfbG9jayk7DQo+ID4gICAgICAgICAgICAgICAgIGRw
cmludGsoInJldmlzaXQgY2FuY2VsZWRcbiIpOw0KPiA+ICsgICAgICAgICAgICAgICBzdmNfZHJv
cF9jb25uZWN0aW9uKHhwcnQpOw0KPiA+ICAgICAgICAgICAgICAgICBzdmNfeHBydF9wdXQoeHBy
dCk7DQo+ID4gICAgICAgICAgICAgICAgIHRyYWNlX3N2Y19kcm9wX2RlZmVycmVkKGRyKTsNCj4g
PiAgICAgICAgICAgICAgICAga2ZyZWUoZHIpOw0KPiA+IC0tDQo+ID4gMi4yNC4xDQo+ID4gDQo+
IA0KPiBUcm9uZCwgYmFjayBpbiAyMDE0IHlvdSBoYWQgdGhpcyBORlN2NCBvbmx5IHBhdGNoIHRo
YXQgdG9vayBhIG1vcmUNCj4gc3VyZ2ljYWwgYXBwcm9hY2g6DQo+IGh0dHBzOi8vbWFyYy5pbmZv
Lz9sPWxpbnV4LW5mcyZtPTE0MTQxNDUzMTgzMjc2OCZ3PTINCj4gDQo+IEl0IGxvb2tzIGxpa2Ug
ZGlzY3Vzc2lvbiBkaWVkIG91dCBvbiBpdCBhZnRlciBpdCB3YXMgaW5lZmZlY3RpdmUgdG8NCj4g
c29sdmUgYSBkaWZmZXJlbnQgcHJvYmxlbS4NCj4gSXMgdGhlcmUgYSByZWFzb24gd2h5IHlvdSBk
b24ndCB3YW50IHRvIGRvIHRoYXQgYXBwcm9hY2ggbm93Pw0KPiANCg0KTGV0IG1lIHJlc2VuZCB0
aGlzIHBhdGNoIHdpdGggYSBiZXR0ZXIgcHJvcG9zYWwuIEkgdGhpbmsgdGhlIG1haW4gMg0KcHJv
YmxlbXMgaGVyZSBhcmUgcmVhbGx5DQoNCiAgIDEuIHRoZSBzdmNfcmV2aXNpdCgpIGNhc2UsIHdo
ZXJlIHdlIGNhbmNlbCB0aGUgcmV2aXNpdC4gVGhhdCBjYXNlDQogICAgICBhZmZlY3RzIGFsbCB2
ZXJzaW9ucyBvZiBORlMsIGFuZCBjYW4gbGVhZCB0byBwZXJmb3JtYW5jZSBpc3N1ZXMuDQogICAy
LiB0aGUgTkZTdjIsdjMsdjQuMCByZXBsYXkgY2FjaGUsIHdoZXJlIGRyb3BwaW5nIHRoZSByZXBs
YXkgKGUuZy4NCiAgICAgIGFmdGVyIGEgY29ubmVjdGlvbiBicmVha2FnZSkgY2FuIGNhdXNlIGEg
cGVyZm9ybWFuY2UgaGl0LCBhbmQgZm9yDQogICAgICBzb21ldGhpbmcgbGlrZSBUQ1AsIHdoaWNo
IGhhcyBsb25nICh1c3VhbGx5IDYwIHNlY29uZCkgdGltZW91dHMgaXQNCiAgICAgIGNvdWxkIGNh
dXNlIHRoZSByZXBsYXkgdG8gYmUgZGVsYXllZCB1bnRpbCBhZnRlciB0aGUgcmVwbHkgZ2V0cw0K
ICAgICAga2lja2VkIG91dCBvZiB0aGUgY2FjaGUuIFRoaXMgaXMgdGhlIGNhc2Ugd2hlcmUgTkZT
djQuMCBjYW4gcHJvYmFibHkNCiAgICAgIGVuZCB1cCBoYW5naW5nLCBzaW5jZSB0aGUgcmVwbGF5
IHdvbid0IGJlIGZvcnRoY29taW5nIHVudGlsIGEgbmV3DQogICAgICBjb25uZWN0aW9uIGJyZWFr
YWdlIG9jY3Vycy4NCg0KSSB0aGluayAoMSkgaXMgYmVzdCBzZXJ2ZWQgYnkgYSBwYXRjaCBsaWtl
IHRoaXMgb25lLg0KUGVyaGFwcyAoMikgaXMgYmV0dGVyIHNlcnZlZCBieSBhZG9wdGluZyB0aGUg
c3ZjX2RlZmVyKCkgbWVjaGFuaXNtPw0KDQpIbW0uLi4gUGVyaGFwcyAyIHBhdGNoZXMgYXJlIGlu
IG9yZGVyLi4uDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50
YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
