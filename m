Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB3679EBC1
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2019 17:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbfH0PBJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 27 Aug 2019 11:01:09 -0400
Received: from mail-eopbgr800120.outbound.protection.outlook.com ([40.107.80.120]:29511
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725811AbfH0PBJ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 27 Aug 2019 11:01:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmxu7zmc6yiA2nQv8M8MvLQaSLOsBnDlFrTnmRN9iJEuOfHoxZpAZBRWovXIrzTlGGWyZ99w2CWIoam2FtLn1XLWbYx70qQ4i5DuqHesY4+xUCBA978AGEFzXA+Ny693eDNouQa5D8+YWfM4K9sPCtx3qJ5mtN1ZfiMG3ebsxdu3DacZSKWCzX6vkzY1n+IW0qXHOg6FsZ0n53VXGXohCgeMmbEA/ZL5jiEr53ix7urAuu02i96Uw+oDssfae/eb91Oaqsumks3fbpG2EvLdoSiurAIu2S5c/Rp85Z5DEtc+T/hHnCDSdbOf8SQ2nIP7J2f6U4gFYGJskSA2td9hbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Cs/tE3PIEIh4etZlTa+fAmJ45XFXVRKmXap0VyGVBM=;
 b=UbpfPJPZ9wsdr94QsDRDzneSac9xH+B3zpIHHMWF/Jv564YAMQ+bkS1qeAaE3xvnbzOrYMOCcmV9a6V3DqnPj2pVox5xMKriZzC0Pw8qpFEkLrEIUGp0yHj1na4Jk8Lzmah+cCft9c0DPllOdA5eHxZRj+rWtFJhQDmWnQ3zIxeDQO/e3aIf7kQtkpjcWLUqdIwOZhXB9Dy6Mj/pLee+EKbQ/8AxW4TBgiYclbyqnJMqfg/4S4jP2EC4g3iaOgXrVpwM9AV9AXDzHA8FEbkpG4KUcGikUHZNeMPBhVSeaI4YxSHHG16jDVE5H3HP9xAtAo72NlviNwZhb6Zc3KyYtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Cs/tE3PIEIh4etZlTa+fAmJ45XFXVRKmXap0VyGVBM=;
 b=AaKrJdw7NCzgNv/TOcPfAuCs0XEzmFvyBiyqSPp4VaMGQvgUx/NJReCqKCwzIa5I0Ty2jc/o+RNrfzrioyuHDuyPXm9yMTdxMzLiZm9QVT3aJedIahxmw9py7fXvlXA0Cp6/Nrx6HuX7CklGZ4i8fdbZ9bdg/yN5MUoUhjamLAg=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB0924.namprd13.prod.outlook.com (10.168.237.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.12; Tue, 27 Aug 2019 14:59:34 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::5d60:e645:84a2:be75]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::5d60:e645:84a2:be75%7]) with mapi id 15.20.2220.013; Tue, 27 Aug 2019
 14:59:34 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "jlayton@redhat.com" <jlayton@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>,
        "jlayton@poochiereds.net" <jlayton@poochiereds.net>
Subject: Re: [PATCH 0/3] Handling NFSv3 I/O errors in knfsd
Thread-Topic: [PATCH 0/3] Handling NFSv3 I/O errors in knfsd
Thread-Index: AQHVXC7WXUD5cV8FEUS4EYbsSk6I0qcN59MAgAAC84CAARwhgIAAD4MAgAABSoA=
Date:   Tue, 27 Aug 2019 14:59:34 +0000
Message-ID: <5e9d8bceb67d20f6e89f81cb7f2a4eca5e842bcf.camel@hammerspace.com>
References: <20190826165021.81075-1-trond.myklebust@hammerspace.com>
         <20190826205156.GA27834@fieldses.org>
         <ef9f2791ef395d7c968a386ce0a32ea503d6478f.camel@hammerspace.com>
         <61F77AD6-BD02-4322-B944-0DC263EB9BD8@oracle.com>
         <20190827145456.GA9804@fieldses.org>
In-Reply-To: <20190827145456.GA9804@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5dab0e8a-0488-4ec6-957f-08d72aff2c78
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB0924;
x-ms-traffictypediagnostic: DM5PR13MB0924:
x-microsoft-antispam-prvs: <DM5PR13MB092422E4694D9E51761D740AB8A00@DM5PR13MB0924.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1091;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39840400004)(366004)(136003)(376002)(396003)(189003)(199004)(229853002)(6486002)(446003)(8676002)(14454004)(6246003)(2616005)(25786009)(118296001)(478600001)(186003)(71190400001)(71200400001)(66946007)(86362001)(11346002)(76116006)(91956017)(53936002)(66556008)(66066001)(64756008)(66446008)(66476007)(2906002)(81166006)(486006)(5660300002)(476003)(81156014)(26005)(8936002)(102836004)(3846002)(6116002)(6506007)(36756003)(4326008)(7736002)(54906003)(76176011)(2501003)(99286004)(110136005)(6512007)(316002)(256004)(6436002)(305945005)(17423001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB0924;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: c8in34tj8iuWAwdYMnU+M6R8OeEKyvRbZ5Tgpa+ejDaJWYVKNe4ckkUEAxPAjvztTR6B9KNgh1XDFwFfX6kAFNL8XW1b0NAaZYdXgkD2MABG0j1kq7xWzN4lJZfhvFNNB3Xb19CQMuwBFrZ5AOrVNXCh7dO6B/Sa7mnJ6uzyCbbClxwudnq62szq9iweqKprP97hiQNmRDwlMhZoKVaIYHWRk/QoS6/3gZlT5NJx0ZK51veJEUY6iQAIQ+wJSWssAmkEaYY/5F2XReiW0WyK+vvFdf39//Be//26P6E88ySKqBBTF6dFqq5sBTTtWg0IvSVArT7Lk9GmBN22oOsGL9EgfPIukZr1/JaPlRUol4Uzj+qaT5qY0X+N9YutHfCWijWhT0Q5vTrqkQv2DlSnQ54j3hwCwD5EgKkUC1Ue0x4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <86289DAC2E5FE24AB9D03119D4CD90E3@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dab0e8a-0488-4ec6-957f-08d72aff2c78
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 14:59:34.6662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YqdOJwSndxmb1Sjbl9lKYQue5uRqWkDsPO1/1gutsme6i/wBcHCJMce4UYcVUSriB9EoZ5Mno1C4JQhF9Bx80g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB0924
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDE5LTA4LTI3IGF0IDEwOjU0IC0wNDAwLCBCcnVjZSBGaWVsZHMgd3JvdGU6DQo+
IE9uIFR1ZSwgQXVnIDI3LCAyMDE5IGF0IDA5OjU5OjI1QU0gLTA0MDAsIENodWNrIExldmVyIHdy
b3RlOg0KPiA+IFRoZSBzdHJhdGVneSBvZiBoYW5kbGluZyB0aGVzZSBlcnJvcnMgbW9yZSBjYXJl
ZnVsbHkgc2VlbXMgZ29vZC4NCj4gPiBCdW1waW5nIHRoZSB3cml0ZS9jb21taXQgdmVyaWZpZXIg
c28gdGhlIGNsaWVudCB3cml0ZXMgYWdhaW4gdG8NCj4gPiByZXRyaWV2ZSB0aGUgbGF0ZW50IGVy
cm9yIGlzIGNsZXZlciENCj4gPiANCj4gPiBJdCdzIG5vdCBjbGVhciB0byBtZSB0aG91Z2ggdGhh
dCB0aGUgTkZTdjMgcHJvdG9jb2wgY2FuIGRlYWwgd2l0aA0KPiA+IHRoZSBtdWx0aS1jbGllbnQg
d3JpdGUgc2NlbmFyaW8sIHNpbmNlIGl0IGlzIHN0YXRlbGVzcy4gV2UgYXJlIG5vdw0KPiA+IG1h
a2luZyBpdCBzdGF0ZWZ1bCBpbiBzb21lIHNlbnNlIGJ5IHByZXNlcnZpbmcgZXJyb3Igc3RhdGUg
b24gdGhlDQo+ID4gc2VydmVyIGFjcm9zcyBORlMgcmVxdWVzdHMsIHdpdGhvdXQgaGF2aW5nIGFu
eSBzZW5zZSBvZiBhbiBvcGVuDQo+ID4gZmlsZSBpbiB0aGUgcHJvdG9jb2wgaXRzZWxmLg0KPiA+
IA0KPiA+IFdvdWxkIGFuICJhcHByb3hpbWF0aW9uIiB3aXRob3V0IG9wZW4gc3RhdGUgYmUgZ29v
ZCBlbm91Z2g/DQo+IA0KPiBJIGZpZ3VyZSB0aGVyZSdzIGEgY29ycmVjdC1idXQtc2xvdyBhcHBy
b2FjaCB3aGljaCBpcyB0byBpbmNyZW1lbnQNCj4gdGhlDQo+IHdyaXRlIHZlcmlmaWVyIGV2ZXJ5
IHRpbWUgdGhlcmUncyBhIHdyaXRlIGVycm9yLiAgRG9lcyB0aGF0IHdvcms/ICBJZg0KPiB3cml0
ZSBlcnJvcnMgYXJlIHJhcmUgZW5vdWdoLCBtYXliZSBpdCBkb2Vzbid0IG1hdHRlciB0aGF0IHRo
YXQncw0KPiBzbG93Pw0KDQpIb3cgaXMgdGhhdCBkaWZmZXJlbnQgZnJvbSBjaGFuZ2luZyB0aGUg
Ym9vdCB2ZXJpZmllcj8gQXJlIHlvdQ0KcHJvcG9zaW5nIHRvIHRyYWNrIHdyaXRlIHZlcmlmaWVy
cyBvbiBhIHBlci1jbGllbnQgYmFzaXM/IFRoYXQgc2VlbXMNCm9uZXJvdXMgdG9vLg0KDQo+IFRo
ZW4gdGhlcmUncyB2YXJpb3VzIGFwcHJveGltYXRpb25zIHlvdSBjb3VsZCB1c2UgKElQIGFkZHJl
c3M/KSB0bw0KPiBndWVzcw0KPiB3aGVuIG9ubHkgb25lIGNsaWVudCdzIGFjY2Vzc2luZyB0aGUg
ZmlsZS4gIFlvdSBzYXZlIGZvcmNpbmcgYWxsIHRoZQ0KPiBjbGllbnRzIHRvIHJlc2VuZCB3cml0
ZXMgYXQgdGhlIGV4cGVuc2Ugb2Ygc29tZSBjb21wbGV4aXR5IGFuZA0KPiBjb3JyZWN0bmVzcy0t
ZS5nLiwgbXVsdGlwbGUgY2xpZW50cyBiZWhpbmQgTkFUIG1pZ2h0IG5vdCBhbGwgZ2V0DQo+IHdy
aXRlDQo+IGVycm9ycy4NCj4gDQo+IEFtIEkgdGhpbmtpbmcgYW9idXQgdGhpcyByaWdodD8NCg0K
SSBhZ3JlZSB0aGF0IHRoZXJlIGFyZSBtdWx0aXBsZSBwcm9ibGVtcyB3aXRoIHRyYWNraW5nIG9u
IGEgcGVyLWNsaWVudA0KYmFzaXMuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMg
Y2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3Bh
Y2UuY29tDQoNCg0K
