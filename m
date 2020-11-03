Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23702A4AE7
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Nov 2020 17:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgKCQOL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Nov 2020 11:14:11 -0500
Received: from mail-dm6nam11on2109.outbound.protection.outlook.com ([40.107.223.109]:31328
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727109AbgKCQOL (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 3 Nov 2020 11:14:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOTzyr9GkwPhA6FXzt2dJJuBpxC322z5lmI1qJyoFbMn45PhPX8/dZtw2S9sR6S1SzFBLuEgQiq3M88DEn4+wY3/xHY/L4z6s7LRt3d7cb1cNWLBMI3/GGm+nH0skMn4UbHmAIhbynPT9iFe0p5l2SJ/5h1cgWU43J4dj5B+yaOu30pqx3LeoJT3OT1LwDUI8mWi5z1VKTDAjutXjCdvUzv62l4rC7J0/gXr0Ruxm+jWnKRMUWR0l6ygV8hYnkV2HuTDwfLP72WEccij65uguROa40aP7eHvWyj81NLbzCcfcGEAsgbQ7OtH6b1SSgBIl24wtGhrbJno0RJnt77gpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ui5Y08qQawPXOLGomrlgdf77ynGd5eSkxAn8LAqwfpE=;
 b=nsJ0pfJzYg3mecOPc7dhPF5gKYP6S2zqbCRgZ5GUtCLuQYztbyYh8aIyd46lFLXZjKUeizhYyn4jroKWoHQ9YS1Vi4OuERbFJG9WngthNW3JCayFPyEZ3lnt+bMe3ePNILEsfLpp+XfG0TmqzUVa7ee0wLbYnbblX+xlLWttapmoV4aPHjPw1uunggkuyLnLtek+c5aPM3yBB0nWqN49iTMTfN2dv4QK6r+6K4+NhjtAtISlf8CCrDQqFPMcXJ8qRcag9MJ6GSH3obYx8KiO7l8U00n/aNjOJiZQO2k3v/d0MKpbP8OhyqrLg5oo/gAK9N8UdlPa5zOaM2F69s6Wtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ui5Y08qQawPXOLGomrlgdf77ynGd5eSkxAn8LAqwfpE=;
 b=CBiHYcLaDT56NUczJLCyv5bQNFHpLU33OuuPLA0qxtXlb+O4Gs2XPRwNlK7DzLLjPl4vdFr13vz0qXRn+C+U9fxIEsOD/XN/FAcM9BRlEnI0Qvci9p703us6yydnP6daCRZBzmpsT89/4N2/1vFNn1cUx9UWK+QCqqNiqARUEPc=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3742.namprd13.prod.outlook.com (2603:10b6:208:1e7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.6; Tue, 3 Nov
 2020 16:14:06 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3541.010; Tue, 3 Nov 2020
 16:14:06 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>,
        "trondmy@kernel.org" <trondmy@kernel.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 05/16] NFS: Don't discard readdir results
Thread-Topic: [PATCH v2 05/16] NFS: Don't discard readdir results
Thread-Index: AQHWsfgf180MPtNOhEWQVVxhUiLNYKm2j4eAgAAFOwA=
Date:   Tue, 3 Nov 2020 16:14:05 +0000
Message-ID: <46be3eda2816ea6ec950483e9b6e17d5a6fcaf7a.camel@hammerspace.com>
References: <20201103153329.531942-1-trondmy@kernel.org>
         <20201103153329.531942-2-trondmy@kernel.org>
         <20201103153329.531942-3-trondmy@kernel.org>
         <20201103153329.531942-4-trondmy@kernel.org>
         <20201103153329.531942-5-trondmy@kernel.org>
         <20201103153329.531942-6-trondmy@kernel.org>
         <DEB8710B-8D01-4FC9-9DA6-78A701C46E19@redhat.com>
In-Reply-To: <DEB8710B-8D01-4FC9-9DA6-78A701C46E19@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f93a71a-28f5-423c-3c74-08d880137ceb
x-ms-traffictypediagnostic: MN2PR13MB3742:
x-microsoft-antispam-prvs: <MN2PR13MB3742FE3B0DFD423972142A31B8110@MN2PR13MB3742.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bXa9sSI0ZgDixGhfs6xf/O0WVZZaMCI+AX4B3UB9ZztNsGG7JwiFmNCjn6IF3GoQIB4MsvvAwwRTDDGTmQtel2el0Nkbl5PoiNL7wBpFxsPPsYzWJuqYkb+DvyuDN6xnU+FmYBNhOTBnF61986blRLjwvTjIyKGZL08N8CPW1TRgc8x3nE5+BAg/WKMoH7QUo9G4uroor0uQuiaURFWO5zdCaM8x2G1mpjmtXy1svT6qE0kE1Ga7GG4iac8lD+WEAMS1LtJHhNe960lF5wgoi2ZlKRqJDbIAc0hy1xMVzjrSLb2BaJOWbVmDh1cYX8QQ6FUYh7zQsDmupCVc7Xzggw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(39830400003)(346002)(376002)(66556008)(64756008)(36756003)(8676002)(478600001)(76116006)(66476007)(66946007)(66446008)(110136005)(8936002)(91956017)(2906002)(316002)(83380400001)(86362001)(6512007)(4326008)(6486002)(186003)(26005)(53546011)(6506007)(2616005)(5660300002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: nIeaKe6xK9C2hK5mcM9mJUwtJ2a/Dl0ifdSWr54fA8B+mG+Ces12RHG6ytYyOBCHHCVBKRGyoiQ9hPsaTQRLLmE+5KOyoO1DMz8X2UKTsxTf93EXei8ktwfu3Bnn6+YganDDOgugRS0+goHgeVWKvrF2ZrfaFN8zVVzj3XdxJTgzVtViBxvOmXxMSSLiSxfKRYP1XMNtAcmz4BGPgUADsgbC+15AEfSg3qIDtZgIZsRMiVnkUF5MwacKfR8khYkA8V5rXvmNI1Mx3Pxv4l0bO3a9nnZ0etU/qhPclnMSmOV8dUOPmdnFJImPXXQahJfOG0rRKnvFO7uJLx0OETzKjwZON2AlrLH26e0SC87RVgxn8yLn2eGSI81R6QGU8270PJK8d0SCCV8eHyTGc/oCK+mmGPBVd5rvDhio1yq0EZDUrzXQ/kGBZ1xtffyiTknBQZsUb6ca1sL4qdNX63VN3ZU2/HvE9+u7e0Uy9osNYmm3biEUGude1dsKDQ49A3KLTkoElmGZY9ua8prpnmvyLbzUkECuGUeWsOOvbwdrtYHfdnyWASpyPMLQvSAAiATciwEQhP+Q6aIVFpaQbAjDNtmD9pVSWeKx7WrkqQVWZi6a6ey94ptRzwxSLDLeiRKIjugfWUU0pQV21wtRaoVJ9Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <983C66BC21E8954E8469A87C3873854A@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f93a71a-28f5-423c-3c74-08d880137ceb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2020 16:14:05.8174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aulLdG8f/G/fcCwE17s2/nH6xsxelH1fgf5o5Kc9llKeoCW7B8H+b91/sn6gsKFG7wEbtS7ugx7+TdzRLbiLDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3742
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIwLTExLTAzIGF0IDEwOjU1IC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiAzIE5vdiAyMDIwLCBhdCAxMDozMywgdHJvbmRteUBrZXJuZWwub3JnwqB3cm90
ZToNCj4gDQo+ID4gRnJvbTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVy
c3BhY2UuY29tPg0KPiA+IA0KPiA+IElmIGEgcmVhZGRpciBjYWxsIHJldHVybnMgbW9yZSBkYXRh
IHRoYW4gd2UgY2FuIGZpdCBpbnRvIG9uZSBwYWdlDQo+ID4gY2FjaGUgcGFnZSwgdGhlbiBhbGxv
Y2F0ZSBhIG5ldyBvbmUgZm9yIHRoYXQgZGF0YSByYXRoZXIgdGhhbg0KPiA+IGRpc2NhcmRpbmcg
dGhlIGRhdGEuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogVHJvbmQgTXlrbGVidXN0IDx0cm9u
ZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tPg0KPiA+IC0tLQ0KPiA+IMKgZnMvbmZzL2Rpci5j
IHwgNDYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQ0KPiA+
IMKgMSBmaWxlIGNoYW5nZWQsIDQyIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4g
DQo+ID4gZGlmZiAtLWdpdCBhL2ZzL25mcy9kaXIuYyBiL2ZzL25mcy9kaXIuYw0KPiA+IGluZGV4
IGI0ODYxYTMzYWQ2MC4uNzg4YzJhMmVlYWEzIDEwMDY0NA0KPiA+IC0tLSBhL2ZzL25mcy9kaXIu
Yw0KPiA+ICsrKyBiL2ZzL25mcy9kaXIuYw0KPiA+IEBAIC0zMjEsNiArMzIxLDI2IEBAIHN0YXRp
YyB2b2lkIG5mc19yZWFkZGlyX3BhZ2Vfc2V0X2VvZihzdHJ1Y3QNCj4gPiBwYWdlIA0KPiA+ICpw
YWdlKQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqBrdW5tYXBfYXRvbWljKGFycmF5KTsNCj4gPiDCoH0N
Cj4gPiANCj4gPiArc3RhdGljIHZvaWQgbmZzX3JlYWRkaXJfcGFnZV91bmxvY2tfYW5kX3B1dChz
dHJ1Y3QgcGFnZSAqcGFnZSkNCj4gPiArew0KPiA+ICvCoMKgwqDCoMKgwqDCoHVubG9ja19wYWdl
KHBhZ2UpOw0KPiA+ICvCoMKgwqDCoMKgwqDCoHB1dF9wYWdlKHBhZ2UpOw0KPiA+ICt9DQo+ID4g
Kw0KPiA+ICtzdGF0aWMgc3RydWN0IHBhZ2UgKm5mc19yZWFkZGlyX3BhZ2VfZ2V0X25leHQoc3Ry
dWN0IGFkZHJlc3Nfc3BhY2UNCj4gPiAqbWFwcGluZywNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBwZ29mZl90IGluZGV4LCB1NjQNCj4gPiBjb29raWUpDQo+ID4gK3sNCj4g
PiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgcGFnZSAqcGFnZTsNCj4gPiArDQo+ID4gK8KgwqDCoMKg
wqDCoMKgcGFnZSA9IG5mc19yZWFkZGlyX3BhZ2VfZ2V0X2xvY2tlZChtYXBwaW5nLCBpbmRleCwg
Y29va2llKTsNCj4gPiArwqDCoMKgwqDCoMKgwqBpZiAocGFnZSkgew0KPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAobmZzX3JlYWRkaXJfcGFnZV9sYXN0X2Nvb2tpZShwYWdl
KSA9PSBjb29raWUpDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqByZXR1cm4gcGFnZTsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
bmZzX3JlYWRkaXJfcGFnZV91bmxvY2tfYW5kX3B1dChwYWdlKTsNCj4gPiArwqDCoMKgwqDCoMKg
wqB9DQo+ID4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIE5VTEw7DQo+ID4gK30NCj4gPiArDQo+ID4g
wqBzdGF0aWMgaW5saW5lDQo+ID4gwqBpbnQgaXNfMzJiaXRfYXBpKHZvaWQpDQo+ID4gwqB7DQo+
ID4gQEAgLTYzOCwxMyArNjU4LDE1IEBAIHZvaWQgbmZzX3ByaW1lX2RjYWNoZShzdHJ1Y3QgZGVu
dHJ5ICpwYXJlbnQsIA0KPiA+IHN0cnVjdCBuZnNfZW50cnkgKmVudHJ5LA0KPiA+IMKgfQ0KPiA+
IA0KPiA+IMKgLyogUGVyZm9ybSBjb252ZXJzaW9uIGZyb20geGRyIHRvIGNhY2hlIGFycmF5ICov
DQo+ID4gLXN0YXRpYw0KPiA+IC1pbnQgbmZzX3JlYWRkaXJfcGFnZV9maWxsZXIobmZzX3JlYWRk
aXJfZGVzY3JpcHRvcl90ICpkZXNjLCBzdHJ1Y3QNCj4gPiBuZnNfZW50cnkgKmVudHJ5LA0KPiA+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHN0cnVjdCBwYWdlICoqeGRyX3BhZ2VzLCBzdHJ1Y3QNCj4gPiBwYWdlICpwYWdlLCB1
bnNpZ25lZCBpbnQgYnVmbGVuKQ0KPiA+ICtzdGF0aWMgaW50IG5mc19yZWFkZGlyX3BhZ2VfZmls
bGVyKHN0cnVjdCBuZnNfcmVhZGRpcl9kZXNjcmlwdG9yIA0KPiA+ICpkZXNjLA0KPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgc3RydWN0IG5mc19lbnRyeSAqZW50cnksDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgcGFn
ZSAqKnhkcl9wYWdlcywNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBwYWdlICpmaWxsbWUsIHVuc2ln
bmVkDQo+ID4gaW50IGJ1ZmxlbikNCj4gPiDCoHsNCj4gPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3Qg
YWRkcmVzc19zcGFjZSAqbWFwcGluZyA9IGRlc2MtPmZpbGUtPmZfbWFwcGluZzsNCj4gPiDCoMKg
wqDCoMKgwqDCoMKgc3RydWN0IHhkcl9zdHJlYW0gc3RyZWFtOw0KPiA+IMKgwqDCoMKgwqDCoMKg
wqBzdHJ1Y3QgeGRyX2J1ZiBidWY7DQo+ID4gLcKgwqDCoMKgwqDCoMKgc3RydWN0IHBhZ2UgKnNj
cmF0Y2g7DQo+ID4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IHBhZ2UgKnNjcmF0Y2gsICpuZXcsICpw
YWdlID0gZmlsbG1lOw0KPiA+IMKgwqDCoMKgwqDCoMKgwqBpbnQgc3RhdHVzOw0KPiA+IA0KPiA+
IMKgwqDCoMKgwqDCoMKgwqBzY3JhdGNoID0gYWxsb2NfcGFnZShHRlBfS0VSTkVMKTsNCj4gPiBA
QCAtNjY3LDYgKzY4OSwxOSBAQCBpbnQgDQo+ID4gbmZzX3JlYWRkaXJfcGFnZV9maWxsZXIobmZz
X3JlYWRkaXJfZGVzY3JpcHRvcl90ICpkZXNjLCBzdHJ1Y3QgDQo+ID4gbmZzX2VudHJ5ICplbg0K
PiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGVzYy0+ZGlyX3ZlcmlmaWVyKTsNCj4gPiANCj4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0YXR1cyA9IG5mc19yZWFkZGlyX2Fk
ZF90b19hcnJheShlbnRyeSwgcGFnZSk7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGlmIChzdGF0dXMgIT0gLUVOT1NQQykNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbnRpbnVlOw0KPiA+ICsNCj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgaWYgKHBhZ2UtPm1hcHBpbmcgIT0gbWFwcGluZykNCj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJyZWFrOw0KPiANCj4g
Xl4gSG93IGNhbiB0aGlzIGhhcHBlbj8NCj4gDQoNCldlIGNhbGwgdGhlIHNhbWUgcm91dGluZXMg
ZnJvbSB1bmNhY2hlZF9yZWFkZGlyKCksIHNvIHRoZSBhYm92ZSBpcw0KcmVhbGx5IHRoZXJlIGlu
IG9yZGVyIHRvIGV4aXQgd2hlbiB3ZSBzZWUgdGhvc2UgYW5vbnltb3VzIHBhZ2VzLg0KDQotLSAN
ClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFj
ZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
