Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAB6147172
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2020 20:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgAWTIZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Jan 2020 14:08:25 -0500
Received: from mail-dm6nam11on2137.outbound.protection.outlook.com ([40.107.223.137]:17153
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728655AbgAWTIZ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 23 Jan 2020 14:08:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RaRIJ+Ej1dSYnfTGkIaRMks030PA/A/XE5f5MMj0yvLtaylSKhSJeBFRDXMG0Ylq3T2K042RoiYw5HmHhQnR+MHfc/td8klZ1WjDwxRXORS0zSVBm/ScSdr4dgLNg3pDgZDWqHiLgJ2u43UYs+ga2gzRzlI7+OJvRnyJ04egJ9Tv3sQxuRLkDkYg5MGW0qOEbbso+iF6H82MNkD/qDRXuvl9mfX6ZEdz2BbmLfrVxPoE2uzQ6HApTGSiHtiejV0hLaXatTaAR832hk8KFySSMEww1mK2/fehEyYDqhWhV3dZRSEiXRKUa2FWzVgX92Jab8yBN6Paq1WyxxHNsGNAhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKCGyV/ofvIy5vGb3dPEn4Gh5KeFjyfa1cFxNEqyo+o=;
 b=nUictxW+m/JnRcpBYul0hTUijBjvOCYCq7I5gyScmB4dRcBACQ1Ym14B+UnnxWP+oLz2Nf/YBGrhGyGqn2q4SpCvl/u8zxfcHrhyXbEcV/e8lCqCC84h1q7/JCvr69CnroNm/JVHEwRhY47manuxVNdsw47RYuVeELcBlE1L1uOcSPbgD2FiDk82zIYx+0kX9qo7AdGEILsiAKq1BZYQlXFrHrmHCsdCIM/rbsVISIGNdRapccCSmLFi5VbJcDrzXJ9+AqloPLKB/Amgvzk1AUp4p1JvarWYEFKt4uN18EUoFV1NicoaB4c68Ae1aDHvnCWuLndjnZkLD9PF61pYlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKCGyV/ofvIy5vGb3dPEn4Gh5KeFjyfa1cFxNEqyo+o=;
 b=AAL0zJBTKEYTWAyz7b7gHXKWVnefh2U5TgEkNFFYKvYuNUThGHTB5C0dXgj+4c7hG5argwmT5mMRmwp8dskxXKEiFQvnWtcce9LrgxuiKdrNZSX85FDCMHmx0YzAAWj4w4/D84GJkznIuCmUFxAfNbaykjhQUWlsXDw2bLoVFVU=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB2073.namprd13.prod.outlook.com (10.174.186.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.17; Thu, 23 Jan 2020 19:08:21 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344%3]) with mapi id 15.20.2665.017; Thu, 23 Jan 2020
 19:08:21 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "rmilkowski@gmail.com" <rmilkowski@gmail.com>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] NFSv4.0: nfs4_do_fsinfo() should not do implicit lease
 renewals
Thread-Topic: [PATCH v3] NFSv4.0: nfs4_do_fsinfo() should not do implicit
 lease renewals
Thread-Index: AdW/I2auAYB5hyQWQDmn+e9BiY7hDAAA4KMABCT0qAAAZzrDgAAyNGcA
Date:   Thu, 23 Jan 2020 19:08:20 +0000
Message-ID: <a62e45ba968fe845fa757174efc0cab93c490d54.camel@hammerspace.com>
References: <025801d5bf24$aa242100$fe6c6300$@gmail.com>
         <D82A1590-FAA3-47C5-B198-937ED88EF71C@oracle.com>
         <084f01d5cfba$bc5c4d10$3514e730$@gmail.com>
         <49e7b99bd1451a0dbb301915f655c73b3d9354df.camel@netapp.com>
In-Reply-To: <49e7b99bd1451a0dbb301915f655c73b3d9354df.camel@netapp.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [63.235.104.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 391db58c-3952-4093-f57d-08d7a0379cd3
x-ms-traffictypediagnostic: DM5PR1301MB2073:
x-microsoft-antispam-prvs: <DM5PR1301MB2073E9AE5226081313173D74B80F0@DM5PR1301MB2073.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39830400003)(346002)(376002)(366004)(199004)(189003)(316002)(186003)(53546011)(8936002)(6486002)(71200400001)(6506007)(6512007)(478600001)(8676002)(81156014)(81166006)(26005)(66556008)(66476007)(64756008)(5660300002)(66446008)(66946007)(86362001)(4326008)(110136005)(36756003)(2616005)(76116006)(91956017)(2906002)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB2073;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xmPgeVC5sxihdgvDS78wmiBc039ouE60YVZcyCfsfTAHsstX7AUOn107QnghZY1GTrOR5G+5iWF7kD0Ks0yXKiIqid+5AParPMZblEJEa/F2OmJuvwoPr8gyHbdyFpREFeZreDhGzEKhuQ8hKL6xEXsH1vsednKOydMZ4d+BYSOdoqoawJThUA6eNHR0Y3XChd8AmmbtPogSQaE3MYCI4nDs24zUABXHVF6Th+pD/by76GoZvsigXZuwdqYMRk7BnDq8bcbF9DZsh2jXGCo8g1JLsK9Lr+RoA3FN25FNOMnY+r78MxtrvjBAYj4yxAi4ED/P5c2MPqKB2JPZgKxqsep67JcF5Aw8eFcN2Suvhcg1e1iIMv/DEeQ2dFC58Z1ZV1Pjcl5u/rauytHZX8ML0pyNkSMHw5GuSeu912t6Gq/Bnxzh4jUCjtIEPRD+QATG
x-ms-exchange-antispam-messagedata: q0FK2l6sMBZeY6yRaDt0a+VyGrHQ1yz7q/lsWyfIaFKomhc2vkIp3IrQbGTDRhK0adocaC5vyzop1y3NCPaQezxsMnkDpkNvCXtiag/qpuSih4ziKHo/Ms+1ZfRaRDRKJUWxj9N3369m5E0o0Z4s9A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F91F7412D11D9D498D91E4ECE709469C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 391db58c-3952-4093-f57d-08d7a0379cd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 19:08:20.9327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2o/MKt9L1QFCu4OKEZtZpMa0Cx3c/++k+bQGoCwg/Y3J08UAbGtwwOaqT8LHFwdmehoaBGpUokiXhm1pMbjpsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2073
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIwLTAxLTIyIGF0IDE5OjEwICswMDAwLCBTY2h1bWFrZXIsIEFubmEgd3JvdGU6
DQo+IEhpIFJvYmVydCwNCj4gDQo+IE9uIE1vbiwgMjAyMC0wMS0yMCBhdCAxNzo1NSArMDAwMCwg
Um9iZXJ0IE1pbGtvd3NraSB3cm90ZToNCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+ID4gPiBGcm9tOiBDaHVjayBMZXZlciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4NCj4gPiA+
IFNlbnQ6IDMwIERlY2VtYmVyIDIwMTkgMTU6MzcNCj4gPiA+IFRvOiBSb2JlcnQgTWlsa293c2tp
IDxybWlsa293c2tpQGdtYWlsLmNvbT4NCj4gPiA+IENjOiBMaW51eCBORlMgTWFpbGluZyBMaXN0
IDxsaW51eC1uZnNAdmdlci5rZXJuZWwub3JnPjsgVHJvbmQNCj4gPiA+IE15a2xlYnVzdA0KPiA+
ID4gPHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+OyBBbm5hIFNjaHVtYWtlcg0KPiA+
ID4gPGFubmEuc2NodW1ha2VyQG5ldGFwcC5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnDQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzXSBORlN2NC4wOiBuZnM0X2RvX2ZzaW5m
bygpIHNob3VsZCBub3QgZG8NCj4gPiA+IGltcGxpY2l0DQo+ID4gPiBsZWFzZSByZW5ld2Fscw0K
PiA+ID4gDQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gPiBPbiBEZWMgMzAsIDIwMTksIGF0IDEwOjIw
IEFNLCBSb2JlcnQgTWlsa293c2tpIDwNCj4gPiA+ID4gcm1pbGtvd3NraUBnbWFpbC5jb20+DQo+
ID4gPiB3cm90ZToNCj4gPiA+ID4gRnJvbTogUm9iZXJ0IE1pbGtvd3NraSA8cm1pbGtvd3NraUBn
bWFpbC5jb20+DQo+ID4gPiA+IA0KPiA+ID4gPiBDdXJyZW50bHksIGVhY2ggdGltZSBuZnM0X2Rv
X2ZzaW5mbygpIGlzIGNhbGxlZCBpdCB3aWxsIGRvIGFuDQo+ID4gPiA+IGltcGxpY2l0DQo+ID4g
PiA+IE5GUzQgbGVhc2UgcmVuZXdhbCwgd2hpY2ggaXMgbm90IGNvbXBsaWFudCB3aXRoIHRoZSBO
RlM0DQo+ID4gPiBzcGVjaWZpY2F0aW9uLg0KPiA+ID4gPiBUaGlzIGNhbiByZXN1bHQgaW4gYSBs
ZWFzZSBiZWluZyBleHBpcmVkIGJ5IGFuIE5GUyBzZXJ2ZXIuDQo+ID4gPiA+IA0KPiA+ID4gPiBD
b21taXQgODNjYTdmNWFiMzFmICgiTkZTOiBBdm9pZCBQVVRST09URkggd2hlbiBtYW5hZ2luZw0K
PiA+ID4gPiBsZWFzZXMiKQ0KPiA+ID4gPiBpbnRyb2R1Y2VkIGltcGxpY2l0IGNsaWVudCBsZWFz
ZSByZW5ld2FsIGluIG5mczRfZG9fZnNpbmZvKCksDQo+ID4gPiA+IHdoaWNoDQo+ID4gPiA+IGNh
biByZXN1bHQgaW4gdGhlIE5GU3Y0LjAgbGVhc2UgdG8gZXhwaXJlIG9uIGEgc2VydmVyIHNpZGUs
IGFuZA0KPiA+ID4gPiBzZXJ2ZXJzIHJldHVybmluZyBORlM0RVJSX0VYUElSRUQgb3IgTkZTNEVS
Ul9TVEFMRV9DTElFTlRJRC4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoaXMgY2FuIGVhc2lseSBiZSBy
ZXByb2R1Y2VkIGJ5IGZyZXF1ZW50bHkgdW5tb3VudGluZyBhIHN1Yi0NCj4gPiA+ID4gbW91bnQs
DQo+ID4gPiA+IHRoZW4gc3RhdCdpbmcgaXQgdG8gZ2V0IGl0IG1vdW50ZWQgYWdhaW4sIHdoaWNo
IHdpbGwgZGVsYXkgb3INCj4gPiA+ID4gZXZlbg0KPiA+ID4gPiBjb21wbGV0ZWx5IHByZXZlbnQg
Y2xpZW50IGZyb20gc2VuZGluZyBSRU5FVyBvcGVyYXRpb25zIGlmIG5vDQo+ID4gPiA+IG90aGVy
DQo+ID4gPiA+IE5GUyBvcGVyYXRpb25zIGFyZSBpc3N1ZWQuIEV2ZW50dWFsbHkgbmZzIHNlcnZl
ciB3aWxsIGV4cGlyZQ0KPiA+ID4gPiBjbGllbnQncw0KPiA+ID4gPiBsZWFzZSBhbmQgcmV0dXJu
IGFuIGVycm9yIG9uIGZpbGUgYWNjZXNzIG9yIG5leHQgUkVORVcuDQo+ID4gPiA+IA0KPiA+ID4g
PiBUaGlzIGNhbiBhbHNvIGhhcHBlbiB3aGVuIGEgc3ViLW1vdW50IGlzIGF1dG9tYXRpY2FsbHkN
Cj4gPiA+ID4gdW5tb3VudGVkIGR1ZQ0KPiA+ID4gPiB0byBpbmFjdGl2aXR5IChhZnRlciBuZnNf
bW91bnRwb2ludF9leHBpcnlfdGltZW91dCksIHRoZW4gaXQgaXMNCj4gPiA+ID4gbW91bnRlZCBh
Z2FpbiB2aWEgc3RhdCgpLiBUaGlzIGNhbiByZXN1bHQgaW4gYSBzaG9ydCB3aW5kb3cNCj4gPiA+
ID4gZHVyaW5nDQo+ID4gPiA+IHdoaWNoIGNsaWVudCdzIGxlYXNlIHdpbGwgZXhwaXJlIG9uIGEg
c2VydmVyIGJ1dCBub3Qgb24gYQ0KPiA+ID4gPiBjbGllbnQuDQo+ID4gPiA+IFRoaXMgc3BlY2lm
aWMgY2FzZSB3YXMgb2JzZXJ2ZWQgb24gcHJvZHVjdGlvbiBzeXN0ZW1zLg0KPiA+ID4gPiANCj4g
PiA+ID4gVGhpcyBwYXRjaCBtYWtlcyBhbiBleHBsaWNpdCBsZWFzZSByZW5ld2FsIGluc3RlYWQg
b2YgYW4NCj4gPiA+ID4gaW1wbGljaXQgb25lLA0KPiA+ID4gPiBieSBhZGRpbmcgUkVORVcgdG8g
YSBjb21wb3VuZCBvcGVyYXRpb24gaXNzdWVkIGJ5DQo+ID4gPiA+IG5mczRfZG9fZnNpbmZvKCks
DQo+ID4gPiA+IHNpbWlsYXJseSB0byBORlN2NC4xIHdoaWNoIGFkZHMgU0VRVUVOQ0Ugb3BlcmF0
aW9uLg0KPiA+ID4gPiANCj4gPiA+ID4gRml4ZXM6IDgzY2E3ZjVhYjMxZiAoIk5GUzogQXZvaWQg
UFVUUk9PVEZIIHdoZW4gbWFuYWdpbmcNCj4gPiA+ID4gbGVhc2VzIikNCj4gPiA+ID4gU2lnbmVk
LW9mZi1ieTogUm9iZXJ0IE1pbGtvd3NraSA8cm1pbGtvd3NraUBnbWFpbC5jb20+DQo+ID4gPiAN
Cj4gPiA+IFJldmlld2VkLWJ5OiBDaHVjayBMZXZlciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4N
Cj4gPiA+IA0KPiA+ID4gDQo+ID4gDQo+ID4gSG93IGRvIHdlIHByb2dyZXNzIGl0IGZ1cnRoZXI/
DQo+IA0KPiBUaGFua3MgZm9yIGZvbGxvd2luZyB1cCEgSSBoYXZlIHRoZSBwYXRjaCBpbmNsdWRl
ZCBpbiBteSBsaW51eC1uZXh0DQo+IGJyYW5jaCBmb3INCj4gdGhlIG5leHQgbWVyZ2Ugd2luZG93
Lg0KDQpOQUNLLiBUaGlzIGlzIHRoZSB3cm9uZyB3YXkgdG8gc29sdmUgdGhlIHByb2JsZW0uIExl
YXNlIHJlbmV3YWwgaW4NCk5GU3Y0IGRvZXMgbm90IG5lZWQgdG8gYmUgdGllZCB0byBmc2luZm8u
IEl0IGNyZWF0ZXMgYW4gdW5uZWNlc3NhcnkNCmV4dHJhIGVycm9yIGNvbmRpdGlvbiB0aGF0IGhh
cyBhYnNvbHV0ZWx5IG5vdGhpbmcgdG8gZG8gd2l0aCB0aGUNCmZ1bmN0aW9uYWxpdHkgb2YgcmV0
cmlldmluZyBwZXItZmlsZXN5c3RlbSBhdHRyaWJ1dGVzLg0KDQpBbGwgdGhhdCBuZWVkcyB0byBi
ZSBkb25lIGhlcmUgaXMgdG8gbW92ZSB0aGUgc2V0dGluZyBvZiBjbHAtDQo+Y2xfbGFzdF9yZW5l
d2FsIF9vdXRfIG9mIG5mczRfc2V0X2xlYXNlX3BlcmlvZCgpLCBhbmQganVzdCBoYXZlDQpuZnM0
X3Byb2Nfc2V0Y2xpZW50aWRfY29uZmlybSgpIGFuZCBuZnM0X3VwZGF0ZV9zZXNzaW9uKCkgY2Fs
bA0KZG9fcmVuZXdfbGVhc2UoKS4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBj
bGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFj
ZS5jb20NCg0KDQo=
