Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3E61AFD4A
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2020 21:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgDSTMX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Apr 2020 15:12:23 -0400
Received: from mail-eopbgr690130.outbound.protection.outlook.com ([40.107.69.130]:65014
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725848AbgDSTMW (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 19 Apr 2020 15:12:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTgBcAic6bsmKxwok1a8fRvD+HsTIznUZDOa+D3jGdtUZ84U8SmhP9AlIRiYPKo/MAnbOFbogX+t8KMntW70BZ/urLBoWz7t1XLShIB/lBbWi2/MIYj5qd7coYd7a/B/jvJUssiY1iaZ03RSAkp6VlVn6tut71It4HqU39RZdHlVw1RxB190CphdEIryuiLl+PlwABOjJdSWi86BB9PNyrRMk0TkFhh+o/kOqZnMPX7PtwU0UGLG9YxN2J08QOM3VfKFiW5wQ8WzLob8jzzy43y16KDjcipH4az+BEBP2bgd45Gcwi7AghSVwQsC4lGU+pXfvED247CsZ5BNtVaxXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+z1XfpoeUZni1cDOl2rdzL6D7cxp6QM2eDeHTIjOsc=;
 b=Ltrp8YmbnRBSwnqJi+OWznEpHXqwkaZbi1ooyJZgAMlOmBvDM1Q1Ow7J6TM62pHqJLt7FzsCul35u5jBrpGXgm4BefE+RzUfqZCaD3rGE3GpcAzE/zmfiI2xffHrxRFIJVpdY9ef9B2/fvCBaFIOwC02veD0lZdzM8VvEtg4ZFvBEceX0eGKKIb9lhg4qa3F83P7oLduRI5wd8tFqyH3FQgUsuMDfKR3NCigDVPh5OeUJ4/O/iM4bKxxbkMpJGTDwQMvoYGJhUmPn5QNj678rmS2YobJL6SzqHKsX8/QFrmViS2rovqJb8FzZto59KysiD6dpW9eKkPgEecGBjh+5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+z1XfpoeUZni1cDOl2rdzL6D7cxp6QM2eDeHTIjOsc=;
 b=IYHDsemIxqBzYGWr3BXQF6aY+Q2T8THcCqwHMZtkJJduw9bYTJex5qUnl6/blCOeoB1JDvVnkx8rtIUx/bgiQiBPUYr1fVOmzVUK7rPKx0FNztO1krZ2pkuyu1nt9dshVAAcIdUMGmW5JHhXq7OO/FzsyiBM+jlbLde2Ms6L0tM=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3462.namprd13.prod.outlook.com (2603:10b6:610:28::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.10; Sun, 19 Apr
 2020 19:12:18 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493%6]) with mapi id 15.20.2937.011; Sun, 19 Apr 2020
 19:12:18 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "agaikwad@redhat.com" <agaikwad@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
CC:     "bfields@fieldses.org" <bfields@fieldses.org>
Subject: Re: [PATCH] nfsd4: add filename to states output
Thread-Topic: [PATCH] nfsd4: add filename to states output
Thread-Index: AQHWFnETww7Sh1IoQkKX3zwesPAg8KiAz/4A
Date:   Sun, 19 Apr 2020 19:12:18 +0000
Message-ID: <4374ca0a713db31a6fc17d653cd5fe54f2f95ec7.camel@hammerspace.com>
References: <20200419173620.GA98107@nevermore.foobar.lan>
In-Reply-To: <20200419173620.GA98107@nevermore.foobar.lan>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef509875-cb13-4ce4-8940-08d7e4959471
x-ms-traffictypediagnostic: CH2PR13MB3462:
x-microsoft-antispam-prvs: <CH2PR13MB3462D0E4A2A06B3D392BCFD7B8D70@CH2PR13MB3462.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-forefront-prvs: 0378F1E47A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(366004)(136003)(346002)(5660300002)(26005)(36756003)(6512007)(110136005)(4326008)(81156014)(8936002)(86362001)(508600001)(6486002)(66946007)(2906002)(71200400001)(6506007)(186003)(2616005)(8676002)(66556008)(66476007)(91956017)(66446008)(64756008)(76116006)(21314003);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8e7Gz3K9+70o2GjIw+4RVZbfSDXV2fTtJfshRbtoAYE5f3dPEC08VALFiO3U7bnP28bowCu5yZm2cWuPZIwrfz1ZFiUSG/MY/PvTS7F6Y/F/KXWExFI1Fl+6z+bbaGZfCET9sJQDcArZyePOr5BlFo0HIkOWKs5OahDZ+ufvenBcSJ5IrxAvOC4a7CZj56xDMX4N2q0/aZFMKJo/vv7WwsdYOwUck/pObZm7uCaozb5gQoWnoGUEWc+NW+Gh2M5IrPZcvTGHtmkxd5yNHnyBPwbvK6lijOxNveFwFhttzQI7OpX69AO5Jq4ivZT3r8iOy7GYLBQY9+OBlLgb8fEbGdSk/GKehD+2CbrAh0MT6yHLboewLlYAbcSHdRmBygESvEl8QSKx2qwRv+edOezIwTgclVSFyPUfY6raMht96fTpbKsS3N7I2hGpITwkPL1JsdHNHM9LPKs4VQxF6Dmg0TWh0bSHjw8iHOm/p+VLh7A7sBq5TAiz9hHoh3z/a82i
x-ms-exchange-antispam-messagedata: +y4sd8B1Wrj0GyNkscjTF0JQCd/65lPg8X5ueWEzEBScFxXYP+fANBWsF091VSUMfTUhuA4aWi5HRJ1iPpt3eHGSdRPMCTCy+qR6e1SGVi54iX+NQ1j5+qthIP4oQxWm++AEkxULluFU41a04UhP7GaL125Ym57zmKWd0awO/387F7zdpN99hNX/ujyjg8NCcDrsJoCwo6xKdDIMbLRzU8t7K+h4LBGhTs4Vj9gihdJwgs9MvAI+5aqWOFILAZTur6bTYzMJWhhUIj0Zh8MOmyhKQSP7v8bCMw5yhSRMuyIMMVNV19CSr6SCf9QTmdz8LERWLIWSjnZaMIBdHtafEu6NwdzaqjYYy05FFoMN1cnxTem72ZTMbyNdGIiVaGU+knTofVMoTd033iqouXvySHNoAsFUx8SkXtJiaikvEEsVEmXnvpYKxf4Wl3Rn0czoTF6AfnoLpo+VWhIpCsHOo0y0YjHIKuW/FasEzteTNeArBVArUYniZlLYF51Tlfwbbeah7lJykcplx+DqSEYK04Zer7nphuOOPqK9uOcbwfEfxof8+iwskh3JQ2q4TncopnLfYLMoBMtHEIH2tpsGNKV6P8kyDaftbvdopcuQLSdNGI57rRA/39jvTtryLDGLpUdYHMdfqt8+dEqxIUsfmyWTlcoq4mk8epLGKofaZOi38CAOSKHaByofF1BMzdkqbd+ZIoOSAqHvPW045lXsIlE9EdBcxMzke841FDjGBjxXuB8xELcrqaSaqPeqTDn0y/89rMxC6o+zqXcJ1htqvsdiJOgaDqDUqc/4Vh88DIE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E28105F0660BFF48A0C72440A6B8C4DA@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef509875-cb13-4ce4-8940-08d7e4959471
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2020 19:12:18.6753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vmgvf+AvTPEsicQkqvKQOEpUpAZY3ZCLSifJ61vhq4zQw3/Ii+4g4E4H6pfVRCdbRLddCBwXFySOYCraW+wHQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3462
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU3VuLCAyMDIwLTA0LTE5IGF0IDIzOjA2ICswNTMwLCBBY2hpbGxlcyBHYWlrd2FkIHdyb3Rl
Og0KPiBBZGQgZmlsZW5hbWUgdG8gc3RhdGVzIG91dHB1dCBmb3IgZWFzZSBvZiBkZWJ1Z2dpbmcu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBY2hpbGxlcyBHYWlrd2FkIDxhZ2Fpa3dhZEByZWRoYXQu
Y29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBLZW5uZXRoIERzb3V6YSA8a2Rzb3V6YUByZWRoYXQuY29t
Pg0KPiAtLS0NCj4gIGZzL25mc2QvbmZzNHN0YXRlLmMgfCAxMSArKysrKysrKysrKw0KPiAgMSBm
aWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9uZnNk
L25mczRzdGF0ZS5jIGIvZnMvbmZzZC9uZnM0c3RhdGUuYw0KPiBpbmRleCBlMzJlY2VkZWNlMGYu
LjBmNGVkNWUzZmJlNCAxMDA2NDQNCj4gLS0tIGEvZnMvbmZzZC9uZnM0c3RhdGUuYw0KPiArKysg
Yi9mcy9uZnNkL25mczRzdGF0ZS5jDQo+IEBAIC0yNDE0LDYgKzI0MTQsMTEgQEAgc3RhdGljIHZv
aWQgbmZzNF9zaG93X3N1cGVyYmxvY2soc3RydWN0DQo+IHNlcV9maWxlICpzLCBzdHJ1Y3QgbmZz
ZF9maWxlICpmKQ0KPiAgCQkJCQkgaW5vZGUtPmlfaW5vKTsNCj4gIH0NCj4gIA0KPiArc3RhdGlj
IHZvaWQgbmZzNF9zaG93X2ZuYW1lKHN0cnVjdCBzZXFfZmlsZSAqcywgc3RydWN0IG5mc2RfZmls
ZSAqZikNCj4gK3sNCj4gKwlzZXFfcHJpbnRmKHMsICJmaWxlbmFtZTogXCIlc1wiIiwgZi0+bmZf
ZmlsZS0+Zl9wYXRoLmRlbnRyeS0NCj4gPmRfbmFtZS5uYW1lKTsNCg0KUGxlYXNlIGNvbnNpZGVy
IHVzaW5nIHRoZSAnJXBEJyBmb3JtYXQgc3BlY2lmaWVyLCBhcyBkZXNjcmliZWQgaW4NCkRvY3Vt
ZW50YXRpb24vY29yZS1hcGkvcHJpbnRrLWZvcm1hdHMucnN0LCB3aGljaCBpcyBkZXNpZ25lZCB0
byBhdm9pZA0KcmFjZXMgd2l0aCByZW5hbWUgaW4gY2FzZXMgbGlrZSB0aGUgYWJvdmUuDQoNCk5v
dGUgdGhhdCBtb3N0IGRlYnVnZ2luZyBwcmludGtzIHVzZSBzb21ldGhpbmcgbGlrZSAlcEQyIGlu
IG9yZGVyIHRvDQpkaXNwbGF5IHRoZSBuYW1lIG9mIHRoZSBwYXJlbnQgZGlyZWN0b3J5IGFzIHdl
bGwsIGluIHdoaWNoIGNhc2UgeW91DQp3YW50DQoNCglzZXFfcHJpbnRmIChzLCAiZmlsZW5hbWU6
IFwiJXBEMlwiIiwgZi0+bmZfZmlsZSk7DQoNCj4gK30NCj4gKw0KPiAgc3RhdGljIHZvaWQgbmZz
NF9zaG93X293bmVyKHN0cnVjdCBzZXFfZmlsZSAqcywgc3RydWN0DQo+IG5mczRfc3RhdGVvd25l
ciAqb28pDQo+ICB7DQo+ICAJc2VxX3ByaW50ZihzLCAib3duZXI6ICIpOw0KPiBAQCAtMjQ0OSw2
ICsyNDU0LDggQEAgc3RhdGljIGludCBuZnM0X3Nob3dfb3BlbihzdHJ1Y3Qgc2VxX2ZpbGUgKnMs
DQo+IHN0cnVjdCBuZnM0X3N0aWQgKnN0KQ0KPiAgDQo+ICAJbmZzNF9zaG93X3N1cGVyYmxvY2so
cywgZmlsZSk7DQo+ICAJc2VxX3ByaW50ZihzLCAiLCAiKTsNCj4gKwluZnM0X3Nob3dfZm5hbWUo
cywgZmlsZSk7DQo+ICsJc2VxX3ByaW50ZihzLCAiLCAiKTsNCj4gIAluZnM0X3Nob3dfb3duZXIo
cywgb28pOw0KPiAgCXNlcV9wcmludGYocywgIiB9XG4iKTsNCj4gIAluZnNkX2ZpbGVfcHV0KGZp
bGUpOw0KPiBAQCAtMjQ4MCw2ICsyNDg3LDggQEAgc3RhdGljIGludCBuZnM0X3Nob3dfbG9jayhz
dHJ1Y3Qgc2VxX2ZpbGUgKnMsDQo+IHN0cnVjdCBuZnM0X3N0aWQgKnN0KQ0KPiAgCW5mczRfc2hv
d19zdXBlcmJsb2NrKHMsIGZpbGUpOw0KPiAgCS8qIFhYWDogb3BlbiBzdGF0ZWlkPyAqLw0KPiAg
CXNlcV9wcmludGYocywgIiwgIik7DQo+ICsJbmZzNF9zaG93X2ZuYW1lKHMsIGZpbGUpOw0KPiAr
CXNlcV9wcmludGYocywgIiwgIik7DQo+ICAJbmZzNF9zaG93X293bmVyKHMsIG9vKTsNCj4gIAlz
ZXFfcHJpbnRmKHMsICIgfVxuIik7DQo+ICAJbmZzZF9maWxlX3B1dChmaWxlKTsNCj4gQEAgLTI1
MDYsNiArMjUxNSw3IEBAIHN0YXRpYyBpbnQgbmZzNF9zaG93X2RlbGVnKHN0cnVjdCBzZXFfZmls
ZSAqcywNCj4gc3RydWN0IG5mczRfc3RpZCAqc3QpDQo+ICAJLyogWFhYOiBsZWFzZSB0aW1lLCB3
aGV0aGVyIGl0J3MgYmVpbmcgcmVjYWxsZWQuICovDQo+ICANCj4gIAluZnM0X3Nob3dfc3VwZXJi
bG9jayhzLCBmaWxlKTsNCj4gKwluZnM0X3Nob3dfZm5hbWUocywgZmlsZSk7DQo+ICAJc2VxX3By
aW50ZihzLCAiIH1cbiIpOw0KPiAgDQo+ICAJcmV0dXJuIDA7DQo+IEBAIC0yNTI0LDYgKzI1MzQs
NyBAQCBzdGF0aWMgaW50IG5mczRfc2hvd19sYXlvdXQoc3RydWN0IHNlcV9maWxlICpzLA0KPiBz
dHJ1Y3QgbmZzNF9zdGlkICpzdCkNCj4gIAkvKiBYWFg6IFdoYXQgZWxzZSB3b3VsZCBiZSB1c2Vm
dWw/ICovDQo+ICANCj4gIAluZnM0X3Nob3dfc3VwZXJibG9jayhzLCBmaWxlKTsNCj4gKwluZnM0
X3Nob3dfZm5hbWUocywgZmlsZSk7DQo+ICAJc2VxX3ByaW50ZihzLCAiIH1cbiIpOw0KPiAgDQo+
ICAJcmV0dXJuIDA7DQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1h
aW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoN
Cg0K
