Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAF3123814
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Dec 2019 21:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfLQUvX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 Dec 2019 15:51:23 -0500
Received: from mail-bn8nam11on2116.outbound.protection.outlook.com ([40.107.236.116]:59713
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726252AbfLQUvX (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 17 Dec 2019 15:51:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCgxjHcAA6k7lyECZoaNNz117o1Dum1QwueQDhy62H6K4hCa4Wv3l0MHXoCLlIMxTUF6Dn67J06uiSLoOjJw8sFKvRVBheyFdL+OXC/Nm7Qc856pJ3fkyzAkLqMJfqkds4aiyJMDxSeKkOpf1RMFpVhZjdNaHenmjhvgKMuejMpgKAysTMnTNh75BTdaTe0dUtHQsatVYN+pvEtjPN+KTyQVZjBz/+U3NG8duAkSFpoYsVntOjS8/3W4/L/OLtyj9vxyWA/Ue2wGUupiLHgSHaRWTsQK6X7g1V/peGgc0CBUv8bqwsYbMZA711qBWFH0CSE0MzX9nL7G+zvqIqDCnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lp5fbshnvxnm91zTLKyieL+lt65DxTRw4pr2YQsOhKM=;
 b=kEXFegDS2s8sFi+QVkehAApumcUPmBDeywLyL499duXR9DfNpYdVoPLwKFbrL+E2YMb/b/2uWLaixdHb+2F+3gQH37G8h503N2ljiGdsN7mOOpLFZuVTXUtGFo48UwhwUJ4foi4F10bGQ/W/TACIuAvgaQ4r8xSpm9TC6sihZMgx8UVZ4dDbMCPCUxsPdmjbyiuLhYTb5OW6KoHPsbNngNJOYkpLYzTLQ8rdtlB47ZcC1ibi62cuh1Jk7toqIpb6BIphs3U4Z831F1qjgHl3eIUr/9eFaEHJbn1AFhUD2YWUpGWE2e3VTuHwGJclFI/eorVUXkDeEEQyRrN3wgWjlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lp5fbshnvxnm91zTLKyieL+lt65DxTRw4pr2YQsOhKM=;
 b=EICaY9HVSKiAPyEjbec0F22aB/GghogxuthCszEFwAek9GduTRh7RnoT+oS2oUUxmbrWWpnSeJCuOn/OhLgQCoyWNl9YPHkIgcz0ufelfWDGV1WujFDASpXeIOerdlbtKH7RXgccKgVUYrVolQE4qSnYuFUnOgALYs3vctABQLY=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB2028.namprd13.prod.outlook.com (10.174.182.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.9; Tue, 17 Dec 2019 20:51:20 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d23:b456:d67:f230]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d23:b456:d67:f230%6]) with mapi id 15.20.2559.012; Tue, 17 Dec 2019
 20:51:20 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@redhat.com" <bfields@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: Return the correct number of bytes written to the
 file
Thread-Topic: [PATCH] nfsd: Return the correct number of bytes written to the
 file
Thread-Index: AQHVtQCYoZZ0pUm0fkGoKdsByYbV3qe+tsCAgAAWtAA=
Date:   Tue, 17 Dec 2019 20:51:20 +0000
Message-ID: <558a7031d413ffe2b16ef38c374a2bbc8bccec79.camel@hammerspace.com>
References: <20191217173333.105547-1-trond.myklebust@hammerspace.com>
         <20191217193003.GA13504@pick.fieldses.org>
In-Reply-To: <20191217193003.GA13504@pick.fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0bfeeb3b-ddee-43aa-a9fe-08d78332de9f
x-ms-traffictypediagnostic: DM5PR1301MB2028:
x-microsoft-antispam-prvs: <DM5PR1301MB202807A9A0420442BA6404B0B8500@DM5PR1301MB2028.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39840400004)(346002)(396003)(136003)(189003)(199004)(51444003)(6506007)(5660300002)(316002)(36756003)(6486002)(66446008)(91956017)(86362001)(71200400001)(76116006)(66556008)(66476007)(64756008)(186003)(6512007)(26005)(8936002)(2906002)(81166006)(81156014)(8676002)(2616005)(4001150100001)(66946007)(508600001)(4326008)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB2028;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P07MXjRjlolpeATDGgfpFmsc8vzE1YInoCLsSIdqWymmPpolb0Xcig/SyHEo/vdTkBz8Yw83obsTamzl0Q62K5MRcVPsPdugLs3Rl8aAahoEF+xOGQdB5if8Bwp/b0VZT/6U1M+Po9Mpp1QLH8HPGBcc+nqBAVMPR3U34yeOyPZr68Br4aCl8J+emTAIJyHkSlPIN6JK/hjYmATm/03urLRCP15CUfXgVkX+9Tdbf7QDKpwwq3zXTx0ueHJPhYYOWchs6mY+CtiJIIhJfe8uhrwEuwcHbcEoYlEOf9cvny7Tcb1XX0tY5haK1jz+8F/4fh0S5sFOX9r+wQYwXx30w9rTJNfllCmRXCNTe5+9jGboP84cnjWTnbAWDQcK+NKbx7eg/PwJDrBgL7JJGlbh6kxWaIV2h3axSJdb7Rd4POUGW6WD40dwwByXKWiKX2aQXQ3SzR7z14ySZntrpkAoMFHEC9PTp5WyDaOm94WFxpqed9NYb8NzmJUq6xbqSqz3
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DFCB73E4EF64904A8ED448A4A8C5A379@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bfeeb3b-ddee-43aa-a9fe-08d78332de9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 20:51:20.1864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lOg2Ytf6T67zt/tSAmrPT4WWHWcGokGD9Ffwysm6sRRj5wv7GDz1tlCRme9OIrs8GrfVz9AN1v1INFIH3wg/qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2028
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDE5LTEyLTE3IGF0IDE0OjMwIC0wNTAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6
DQo+IE9uIFR1ZSwgRGVjIDE3LCAyMDE5IGF0IDEyOjMzOjMzUE0gLTA1MDAsIFRyb25kIE15a2xl
YnVzdCB3cm90ZToNCj4gPiBXZSBtdXN0IGFsbG93IGZvciB0aGUgZmFjdCB0aGF0IGlvdl9pdGVy
X3dyaXRlKCkgY291bGQgaGF2ZQ0KPiA+IHJldHVybmVkDQo+ID4gYSBzaG9ydCB3cml0ZSAoZS5n
LiBpZiB0aGVyZSB3YXMgYW4gRU5PU1BDIGlzc3VlKS4NCj4gDQo+IFRoYW5rcyEgIEp1c3QgYSBu
aXQ6DQo+IA0KPiA+IEZpeGVzOiA3M2RhODUyZTM4MzEgKCJuZnNkOiB1c2UgdmZzX2l0ZXJfcmVh
ZC93cml0ZSIpDQo+IA0KPiBJIHRoaW5rIHRoYXQgc2hvdWxkIGJlIGQ4OTBiZTE1OWE3MSAibmZz
ZDogQWRkIEkvTyB0cmFjZSBwb2ludHMgaW4NCj4gdGhlDQo+IE5GU3Y0IHdyaXRlIHBhdGgiLg0K
DQpGYWlyIGVub3VnaC4gRG8geW91IHdhbnQgdG8gZml4IHRoYXQgdXA/DQoNCj4gDQo+IC0tYi4N
Cj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RA
aGFtbWVyc3BhY2UuY29tPg0KPiA+IC0tLQ0KPiA+ICBmcy9uZnNkL3Zmcy5jIHwgMSArDQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9m
cy9uZnNkL3Zmcy5jIGIvZnMvbmZzZC92ZnMuYw0KPiA+IGluZGV4IGMwZGM0OTE1MzdhNi4uZjBi
Y2EwZTg3ZDBjIDEwMDY0NA0KPiA+IC0tLSBhL2ZzL25mc2QvdmZzLmMNCj4gPiArKysgYi9mcy9u
ZnNkL3Zmcy5jDQo+ID4gQEAgLTk3NSw2ICs5NzUsNyBAQCBuZnNkX3Zmc193cml0ZShzdHJ1Y3Qg
c3ZjX3Jxc3QgKnJxc3RwLCBzdHJ1Y3QNCj4gPiBzdmNfZmggKmZocCwgc3RydWN0IGZpbGUgKmZp
bGUsDQo+ID4gIAlob3N0X2VyciA9IHZmc19pdGVyX3dyaXRlKGZpbGUsICZpdGVyLCAmcG9zLCBm
bGFncyk7DQo+ID4gIAlpZiAoaG9zdF9lcnIgPCAwKQ0KPiA+ICAJCWdvdG8gb3V0X25mc2VycjsN
Cj4gPiArCSpjbnQgPSBob3N0X2VycjsNCj4gPiAgCW5mc2RzdGF0cy5pb193cml0ZSArPSAqY250
Ow0KPiA+ICAJZnNub3RpZnlfbW9kaWZ5KGZpbGUpOw0KPiA+ICANCj4gPiAtLSANCj4gPiAyLjIz
LjANCj4gPiANCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWlu
ZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
