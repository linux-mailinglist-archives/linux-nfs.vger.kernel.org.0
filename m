Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B606D151F89
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Feb 2020 18:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbgBDRgl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Feb 2020 12:36:41 -0500
Received: from mail-eopbgr700112.outbound.protection.outlook.com ([40.107.70.112]:30433
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727310AbgBDRgl (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 4 Feb 2020 12:36:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ezk28dHLx4eh4BlJulzOnf55eKwpSqbQdKzDCumRfeBv4qZU38aWYMKq7YcfI0tB6vFa0ZMn8VHK7PgIozbZJzcL+1YchQNfJ7ykQ8xeYPWsqvtL6MkVI+U4LoBfkk25oUR3dHjTQV2mRCjnYHp8Njdo3L06rq9oCoTzaikUmNoyYgwQPVsYNN5T8cfHz3KpvsSLDVvqSkm5ISkcnEM4IVaqu5ZpX4pz3BAdREvuLFS42y7wNfOV8Dp+sx6OBIDacteriKMYKCRR3DEaj2H9pSaOVhPcBBbHrNspHPWE5KT9MQNuXcpU0agga+yAJ5d8bFWaDgQF3YPu8MX73aG+0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dn7ILmYQCCfBiKhiFaAVGRVUqSxzBXDO3wPBpAYVwq0=;
 b=IFqhBrCM8DA3fDCn9AgvXKEZdd9/BJMf2K68uh/HPgHjH+pyfXyRWz9twfFLBDnDdmYJzN6eD5ZFzFsail0nbajpXtUYWxicPb0qGkajoACgauj5JSJkw/IMrLus8t5rZX7aPclneo4nTUWtPh3URovoeGuF0jm88Wv+7dj1j2/3yqxGeBs1xCb62qHSDFHP8vkUqsPtbm0D/Ce/v3k5Vxfn5bq/JQvpjGSpiZBwLJMVaZmWaWaFuwW+sAD+ufj/8XA8CfbnxQ/nK2BTK9BRUEkG+lUKdbOxhtJ+5l9B3Bk7nOT3laRWuAm3Oll8N9wTfj5iHCfXDVxK2N2T/FCsFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dn7ILmYQCCfBiKhiFaAVGRVUqSxzBXDO3wPBpAYVwq0=;
 b=axBw6sF0W3wnbKE5n1Lm9GI8E6/IiSW1WzbWUu4jroDob62VQd59vM7SeoGNLjQjxvh1EfAcNrHOW+vR5LsADjPYJxdO6HOg1D5QkT0fuWLLK7yR6PIlxS/k07DfpEEaMAAMHTzhNYX72S8iHMaxG5+RLbEE4XWriBbzdx/tCio=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB1915.namprd13.prod.outlook.com (10.174.187.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.12; Tue, 4 Feb 2020 17:36:37 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344%3]) with mapi id 15.20.2707.018; Tue, 4 Feb 2020
 17:36:37 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "aglo@umich.edu" <aglo@umich.edu>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "SteveD@redhat.com" <SteveD@redhat.com>
Subject: Re: [PATCH 1/2] manpage: Add a description of the 'nconnect' mount
 option
Thread-Topic: [PATCH 1/2] manpage: Add a description of the 'nconnect' mount
 option
Thread-Index: AQHV1rtiY+PbLnmEZUOEKWD862nBgqgJm/2AgAGr2wCAAAeTgIAAAn2AgAAD7IA=
Date:   Tue, 4 Feb 2020 17:36:37 +0000
Message-ID: <f4833c297ff2253c932543be231462fce8971dce.camel@hammerspace.com>
References: <20200129154703.6204-1-steved@redhat.com>
         <CAN-5tyF1NUt2emuPGYF+-3s9cJPwox1uoh0uVzxArRJtzPXMTA@mail.gmail.com>
         <4c48901d-3e37-31fc-a032-0326bda51b25@RedHat.com>
         <e96d7688a52b4f7d54e492b5f2dc9e4070cf240d.camel@hammerspace.com>
         <CAN-5tyFmfDxUjvf2dnUGsVVW7DFt3vvKVYcCzwCjBVY5qxbV6w@mail.gmail.com>
In-Reply-To: <CAN-5tyFmfDxUjvf2dnUGsVVW7DFt3vvKVYcCzwCjBVY5qxbV6w@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4023f2ea-c993-4e65-cc16-08d7a998c947
x-ms-traffictypediagnostic: DM5PR1301MB1915:
x-microsoft-antispam-prvs: <DM5PR1301MB191510929A3E31C3AC3149C1B8030@DM5PR1301MB1915.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03030B9493
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(346002)(396003)(376002)(39850400004)(189003)(199004)(66556008)(66446008)(64756008)(76116006)(4326008)(66946007)(66476007)(6916009)(2616005)(6506007)(316002)(2906002)(86362001)(53546011)(26005)(186003)(36756003)(8936002)(81166006)(81156014)(6486002)(8676002)(478600001)(6512007)(5660300002)(54906003)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB1915;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FBMCjEOdEtdzCfwmDeglLEmEKMj4C74eZa3sl+gm3QIp1c9rfxv9MaPA2f1KRETEwVP5nHV00qxv5jDGMuGK8Ee24WzuJqK3rmZlv8L0OFUHY76G6i2mAFQkiF6C9vJ7acd+aaZbcfmKIGumIGSL5kw3adL6mATfR2KEqMVjWdxEzpX+OwKy9988yd/oKRJixXp74QG6jn60sDl+TKvYqEOo9FlQbShfxr5adwo/5TkrF5SYv4K+8LUkVQZN40air5PMNl8Q1MX3r9H6eyHgPOj+Er1W7cflcgqqBZgj7VdaLxJqi+6fSQm65+hAcc37mEPF4/+4AaveSKx0puUiLZPSs7gIQLgTZheeI4fbS5kI+83ftqopEZvQD4IaTq/k9cd9C6Z8dQZX7/yab6KxINEYtYEvmfeEgIlPk8uUkJlQTekL89o8S1kd0hk7spxG
x-ms-exchange-antispam-messagedata: P8jzGWvphA/UAq9h439eHzlT5zM1/UcQidjhL5D53DbmN6kGqV+3tY3OLtmNzuHbNYaupi8xA/Pj5xv2cXqLLBeg/K7ugyI32qhr53IT1MTDV9F+V0O5xQmcf4IBhOF2VbObt+u+lf3/Ac+myXY2Ig==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B11D8665E08CA428C87ACB13A87C373@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4023f2ea-c993-4e65-cc16-08d7a998c947
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2020 17:36:37.1834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bi/l2eEF947mSImCmEDbiUcS2MsjAutG9zV8kwzfGnjYeXwXDSctku0vlcJETLjBn5o0JzJEfJO//XZeAXGFiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB1915
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIwLTAyLTA0IGF0IDEyOjIyIC0wNTAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gT24gVHVlLCBGZWIgNCwgMjAyMCBhdCAxMjoxMyBQTSBUcm9uZCBNeWtsZWJ1c3QgPA0K
PiB0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gT24gVHVlLCAyMDIwLTAyLTA0
IGF0IDExOjQ2IC0wNTAwLCBTdGV2ZSBEaWNrc29uIHdyb3RlOg0KPiA+ID4gVHJvbmQsDQo+ID4g
PiANCj4gPiA+IE9uIDIvMy8yMCAxMDoxNSBBTSwgT2xnYSBLb3JuaWV2c2thaWEgd3JvdGU6DQo+
ID4gPiA+IExvb2tzIGdvb2QgYnV0IGNhbiB3ZSBhZGQgY2xhcmlmaWNhdGlvbiB0aGF0IG5jb25u
ZWN0IGlzDQo+ID4gPiA+IHN1cHBvcnRlZA0KPiA+ID4gPiBmb3INCj4gPiA+ID4gMy4wIGFuZCA0
LjErPw0KPiA+ID4gRG8geW91IGhhdmUgYW4gb3BpbmlvbiBvbiB0aGlzPyBTaG91bGQgd2UgZG9j
dW1lbnQgdGhlIHByb3RvY29scw0KPiA+ID4gdGhhdA0KPiA+ID4gYXJlIHN1cHBvcnRlZD8NCj4g
PiANCj4gPiBVbmxlc3MgdGhlcmUgaXMgYW4gYWN0dWFsIHByb3RvY29sIHJlYXNvbiBmb3IgZG9p
bmcgc28sIEknZCByYXRoZXINCj4gPiBub3QNCj4gPiB0aGF0IHdlIGJlIG9uIHRoZSByZWNvcmQg
YXMgc2F5aW5nIHRoYXQgTkZTdjQuMCB3aWxsIHJlbWFpbg0KPiA+IHVuc3VwcG9ydGVkLg0KPiA+
IEluIG90aGVyIHdvcmRzLCBJJ2QgbGlrZSB1cyB0byBrZWVwIG9wZW4gdGhlIHBvc3NpYmlsaXR5
IHRoYXQgd2UNCj4gPiBtaWdodA0KPiA+IGFkZCBORlN2NC4wIHN1cHBvcnQgaW4gdGhlIGZ1dHVy
ZSwgc2hvdWxkIHNvbWVvbmUgbmVlZCBpdC4NCj4gDQo+IEkgc2VlIHlvdXIgcG9pbnQgYW5kIEkg
bGlrZSB0aGUgdmFndWVuZXNzIG9mIHRoZSBuY29ubmVjdCBkZXNjcmlwdGlvbg0KPiBidXQgaXMg
dGhlIG1hbiBwYWdlIHdyaXR0ZW4gaW4gc3RvbmUsIGNhbid0IHdlIHNheSB0aGF0IG5vdyBzdXBw
b3J0DQo+IGlzDQo+IGZvciB2MyBhbmQgdjQuMSsgYnV0IGluIHRoZSBmdXR1cmUgaXQgbWlnaHQg
Y2hhbmdlPyBJdCBtaWdodCBiZQ0KPiBjb25mdXNpbmcgZm9yIHRoZSB1c2VycyB0byBkbyBhIDQu
MCBtb3VudCwgc3BlY2lmeSBuY29ubmVjdCBhbmQNCj4gd29uZGVyDQo+IHdoeSBpdCdzIG5vdCB3
b3JraW5nPw0KDQpXZWxsLi4uIEdpdmVuIHRoYXQgaXQgaXMgcmVhbGx5IGEgYnVnIChpLmUuIG5v
dCBpbnRlbnRpb25hbCkgdGhhdA0KTkZTdjQuMCBkb2VzIG5vdCB3b3JrLCBJJ2QgYXJndWUgdGhv
c2UgdXNlcnMgc2hvdWxkIGJlIGFsbG93ZWQgdGhlDQpvcHRpb24gdG8gY29tcGxhaW4uDQoNCj4g
DQo+ID4gQ2hlZXJzDQo+ID4gICBUcm9uZA0KPiA+IA0KPiA+IA0KPiA+ID4gc3RldmVkLg0KPiA+
ID4gDQo+ID4gPiA+IE9uIFdlZCwgSmFuIDI5LCAyMDIwIGF0IDEwOjQ3IEFNIFN0ZXZlIERpY2tz
b24gPA0KPiA+ID4gPiBzdGV2ZWRAcmVkaGF0LmNvbT4NCj4gPiA+ID4gd3JvdGU6DQo+ID4gPiA+
ID4gRnJvbTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29t
Pg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEFkZCBhIGRlc2NyaXB0aW9uIG9mIHRoZSAnbmNvbm5l
Y3QnIG1vdW50IG9wdGlvbiBvbiB0aGUgJ25mcycNCj4gPiA+ID4gPiBnZW5lcmljDQo+ID4gPiA+
ID4gbWFucGFnZS4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBUcm9uZCBN
eWtsZWJ1c3QgPA0KPiA+ID4gPiA+IHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+DQo+
ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogU3RldmUgRGlja3NvbiA8c3RldmVkQHJlZGhhdC5jb20+
DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gIHV0aWxzL21vdW50L25mcy5tYW4gfCAxNyArKysr
KysrKysrKysrKysrKw0KPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygr
KQ0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS91dGlscy9tb3VudC9uZnMubWFu
IGIvdXRpbHMvbW91bnQvbmZzLm1hbg0KPiA+ID4gPiA+IGluZGV4IDZiYTljZWYuLjg0NDYyY2Qg
MTAwNjQ0DQo+ID4gPiA+ID4gLS0tIGEvdXRpbHMvbW91bnQvbmZzLm1hbg0KPiA+ID4gPiA+ICsr
KyBiL3V0aWxzL21vdW50L25mcy5tYW4NCj4gPiA+ID4gPiBAQCAtMzY5LDYgKzM2OSwyMyBAQCB1
c2luZyBhbiBhdXRvbW91bnRlciAocmVmZXIgdG8NCj4gPiA+ID4gPiAgLkJSIGF1dG9tb3VudCAo
OCkNCj4gPiA+ID4gPiAgZm9yIGRldGFpbHMpLg0KPiA+ID4gPiA+ICAuVFAgMS41aQ0KPiA+ID4g
PiA+ICsuQlIgbmNvbm5lY3Q9IG4NCj4gPiA+ID4gPiArV2hlbiB1c2luZyBhIGNvbm5lY3Rpb24g
b3JpZW50ZWQgcHJvdG9jb2wgc3VjaCBhcyBUQ1AsIGl0DQo+ID4gPiA+ID4gbWF5DQo+ID4gPiA+
ID4gK3NvbWV0aW1lcyBiZSBhZHZhbnRhZ2VvdXMgdG8gc2V0IHVwIG11bHRpcGxlIGNvbm5lY3Rp
b25zDQo+ID4gPiA+ID4gYmV0d2Vlbg0KPiA+ID4gPiA+ICt0aGUgY2xpZW50IGFuZCBzZXJ2ZXIu
IEZvciBpbnN0YW5jZSwgaWYgeW91ciBjbGllbnRzIGFuZC9vcg0KPiA+ID4gPiA+IHNlcnZlcnMN
Cj4gPiA+ID4gPiArYXJlIGVxdWlwcGVkIHdpdGggbXVsdGlwbGUgbmV0d29yayBpbnRlcmZhY2Ug
Y2FyZHMgKE5JQ3MpLA0KPiA+ID4gPiA+IHVzaW5nDQo+ID4gPiA+ID4gbXVsdGlwbGUNCj4gPiA+
ID4gPiArY29ubmVjdGlvbnMgdG8gc3ByZWFkIHRoZSBsb2FkIG1heSBpbXByb3ZlIG92ZXJhbGwN
Cj4gPiA+ID4gPiBwZXJmb3JtYW5jZS4NCj4gPiA+ID4gPiArSW4gc3VjaCBjYXNlcywgdGhlDQo+
ID4gPiA+ID4gKy5CUiBuY29ubmVjdA0KPiA+ID4gPiA+ICtvcHRpb24gYWxsb3dzIHRoZSB1c2Vy
IHRvIHNwZWNpZnkgdGhlIG51bWJlciBvZiBjb25uZWN0aW9ucw0KPiA+ID4gPiA+ICt0aGF0IHNo
b3VsZCBiZSBlc3RhYmxpc2hlZCBiZXR3ZWVuIHRoZSBjbGllbnQgYW5kIHNlcnZlciB1cA0KPiA+
ID4gPiA+IHRvDQo+ID4gPiA+ID4gK2EgbGltaXQgb2YgMTYuDQo+ID4gPiA+ID4gKy5JUA0KPiA+
ID4gPiA+ICtOb3RlIHRoYXQgdGhlDQo+ID4gPiA+ID4gKy5CUiBuY29ubmVjdA0KPiA+ID4gPiA+
ICtvcHRpb24gbWF5IGFsc28gYmUgdXNlZCBieSBzb21lIHBORlMgZHJpdmVycyB0byBkZWNpZGUg
aG93DQo+ID4gPiA+ID4gbWFueQ0KPiA+ID4gPiA+ICtjb25uZWN0aW9ucyB0byBzZXQgdXAgdG8g
dGhlIGRhdGEgc2VydmVycy4NCj4gPiA+ID4gPiArLlRQIDEuNWkNCj4gPiA+ID4gPiAgLkJSIHJk
aXJwbHVzICIgLyAiIG5vcmRpcnBsdXMNCj4gPiA+ID4gPiAgU2VsZWN0cyB3aGV0aGVyIHRvIHVz
ZSBORlMgdjMgb3IgdjQgUkVBRERJUlBMVVMgcmVxdWVzdHMuDQo+ID4gPiA+ID4gIElmIHRoaXMg
b3B0aW9uIGlzIG5vdCBzcGVjaWZpZWQsIHRoZSBORlMgY2xpZW50IHVzZXMNCj4gPiA+ID4gPiBS
RUFERElSUExVUw0KPiA+ID4gPiA+IHJlcXVlc3RzDQo+ID4gPiA+ID4gLS0NCj4gPiA+ID4gPiAy
LjIxLjENCj4gPiA+ID4gPiANCj4gPiANCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMg
Y2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3Bh
Y2UuY29tDQoNCg0K
