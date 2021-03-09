Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA1D331C98
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Mar 2021 02:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhCIBwb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Mar 2021 20:52:31 -0500
Received: from mail-dm6nam10on2107.outbound.protection.outlook.com ([40.107.93.107]:48416
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230408AbhCIBwX (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 8 Mar 2021 20:52:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxJWW7AasTtPeDl9YPyL1XmYhr4jDxiAfG9MFX/BAtBPJbxLe7Td8gqqjHMs2a1H0AnZ5e7KDZGUcxw2m5M0ZAdLUHI6drbOeB6P/8IICu0zMM/9rCgMtUn3xcsIaW370Mb2ENfkU3SQt+U/jik/RYaDVnhfH01HiY8K5RRpyTEW2Z4kYu4NrVWzWEGiHAszptF2JKFFOl2nDBP+BIndxlDdjEgkajF8Qn9u7G2TYkQsD7LHKacj3PJNgOzxwG78IrCXSOGrMNsY3T8HHWJ2dor/eXl9VnpsaK+cX7l7U+/fPl7mm8hPww/PxmebEIHeVrihrBTOQUnzrknvNfGeXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrEcy4nz3zDiZ7Mv127xWLKppeuSAZMMgp34dcIuRZc=;
 b=ezj0y0QeM0axW4wGi3bkgI08owQeZnOHAb1gJuB0ovsEkBrsl5XJBRv2rkmwWIClSSuQB0p7/5JbEYeMFWeXdZVAcPbqS9IoJtZ8uBdVwtA8IIoYhZJ8LZrQkaeTlxmUetW4nWSaPeguMABgR9VuADNTNEEdyX/JzBCg8kQWXQNP9suz5yn6SUFdtZS3QWDAGF+tOo0p8P6jwm0qQ+gbHXjXlT++o+jIJ/hegsr0Wb0xbeOOVh4azEh+7x6B1+fV7mlNgfT27iO1gBoZv7NX1QRgL0qDNKbGhGV3cZkBlFnVYNdnwomVceiwv4muQNiU030F4c3SyT8iRO8qqQv0hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrEcy4nz3zDiZ7Mv127xWLKppeuSAZMMgp34dcIuRZc=;
 b=NsmR5p80LhnI3GO63Jjc9i0/GJOLC/VKK92Usy62c//A9ekW6Y5pH5IK9MezCUt+4AxXzP9bH8OkBlyONSm9E82T/gQ0wgDHNJEZI9WZRUVbrCeLABS6AF7/55ggVjN0BSsBOxfHzObwdBas6mNE2+jZg1GpA7Op060QeAv1d4c=
Received: from CH2PR13MB3525.namprd13.prod.outlook.com (2603:10b6:610:21::29)
 by CH2PR13MB3862.namprd13.prod.outlook.com (2603:10b6:610:a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.9; Tue, 9 Mar
 2021 01:52:19 +0000
Received: from CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063]) by CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063%3]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 01:52:19 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "jbreitman@tildenparkcapital.com" <jbreitman@tildenparkcapital.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: NFS Mount Hangs
Thread-Topic: NFS Mount Hangs
Thread-Index: AQHXFEdAEEEnx0TTDkaf/2qq9DT53qp6qIoAgAAB3QCAADq1gA==
Date:   Tue, 9 Mar 2021 01:52:18 +0000
Message-ID: <4ec6d34eb753bd2ba11886cdffbad1f25f4b6e78.camel@hammerspace.com>
References: <C643BB9C-6B61-4DAC-8CF9-CE04EA7292D0@tildenparkcapital.com>
         <5E3B228F-5CFC-4EDF-B52E-1CDB947ADC00@tildenparkcapital.com>
         <2b13577bb30faf3b475d2d602be57aa135023a53.camel@hammerspace.com>
         <15CD7763-6DE5-4DBA-8FAE-859964AA90AC@tildenparkcapital.com>
In-Reply-To: <15CD7763-6DE5-4DBA-8FAE-859964AA90AC@tildenparkcapital.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: tildenparkcapital.com; dkim=none (message not signed)
 header.d=none;tildenparkcapital.com; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [50.124.244.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c67cbc22-b915-460f-d710-08d8e29df920
x-ms-traffictypediagnostic: CH2PR13MB3862:
x-microsoft-antispam-prvs: <CH2PR13MB38622285EFB572ABCC4BDE88B8929@CH2PR13MB3862.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J2XEImyyRMbh/ibOXF3KrULXqUls8YHbtgviv23e5L61D8l9MEhoKp7jkG+eqUknZHldOeZUNHqQrxM/ccZ1ED6DbA6+hjanWppE18eIJTa9rGYF6w3JMnZ2ysHmRezY86Bk1T+sMAjPhijJs29vs1SvLv4idasG3Y+HL7612TibsKWr4dnnGAqJksiRDiH4U5PDrvIqjwitw+x5WJ3F3ORrCoPSbqYgEYZ6CWLGfIBnDl0e1ATFZWA0kDYB/qjQcJve9ET7Ubgf1IZ/wE/U/PSHF/A6l6Ub50WuafGZoP7V45YGlKkVzkj3LyrRndoka/KlZymsj58kvHrXmgD1E/ThBqTttHLeQUikg4BEOfMUzdePE1BruGko4MMkXSzfLB9ZPkttI+/QokdRLlaH0ziQR19W4TaO1C0cR6j55wOmZt59fjSQPY3MJqZXGw2ohlXUGMn7IgNHirGsdSbpLYjzQFFQf80WjCgvoJlcf8qcwfiqQOUzDKhwURKL7Rgg6iAmDu3sG5d/hbNLHz7djv4E4euNhhplBBS/euazNalOgj/4pE3DRYQhYDihxc0slU32eWHBPg4RSCSXMPhEBkJLgVtgLHAN1kTWItI6kN8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3525.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(396003)(366004)(39840400004)(346002)(53546011)(7116003)(8936002)(8676002)(36756003)(6486002)(3480700007)(66446008)(66946007)(66556008)(966005)(83380400001)(4326008)(6512007)(478600001)(64756008)(6506007)(186003)(71200400001)(15974865002)(86362001)(2616005)(26005)(2906002)(316002)(5660300002)(76116006)(66476007)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?eGx3Sld3Z29relJZWHVDblFqL0dvOUR0K3pjLzlhZThGVHo3V2hVY3lCMnhP?=
 =?utf-8?B?VzkrRDgvM1dEUTdNTkltbk81dUZPNk55Q0hvZzlkR2ZqWkJOQkpDaUR0M1BO?=
 =?utf-8?B?MGdWR3NtQ1kybmcvcysxbXp5VTg3N0tWLzNLcWJIL0wyKzR0cDlNQzR2T1k3?=
 =?utf-8?B?bTc3M0NNZml2S0ZaU25aK1k1QkUwdWZsemtqSENjVFI3SnRZcHkydlBIYW80?=
 =?utf-8?B?T3hYNjlLOURYNklVUnJGOG5POExpYXQvanB4V2tzU2doN0dpME9RaHgzaFpu?=
 =?utf-8?B?Ulg0eVB1MVJpSW1IYUZ2WWZtbzRLNjFDa2wvT0ZSYUZvVWJhcXhIZ3RuN0Ft?=
 =?utf-8?B?VjFyRFQ4ZXQ2ZU1TUWRzQkJnNEV1TjhFdSs4c0t4Rlp4TFN4SUZKUlhJK0RZ?=
 =?utf-8?B?N29kQXBDNmRpTWo2clJVcWdNWFNkdjgzTFB4WFVCMDA3NHduLzlLZWlMWU9a?=
 =?utf-8?B?VjlTcFM4bWxFWHRUT2htdHBINjIrRDlzZ3laT0ZNeFpkd3JUcElYWmVrWHk2?=
 =?utf-8?B?a3lFRDZmVWlIOEMwSlowSFpvVmtNTjczK1FDRzNmbzVhcHlWKzZRdU5Rb0Zj?=
 =?utf-8?B?b3k2SzdvWjNVVVMvWUUwREFjRzZvdlNMOUs1TWhnSjljT3BOWFZIUmNpZUxQ?=
 =?utf-8?B?VG5wUVlWMG9kOWJveVUycHM2K2dHWmlGZ20waFNaVXBIMllTYVBacDA4Ty9y?=
 =?utf-8?B?MmwvODNOZUdTVHdORVRCclRXRmlGcVoxQThVTWkzcVA5VHppam13bWdGVHQ5?=
 =?utf-8?B?cVdmU2xaRExBd0QwajdId1ZhMUdmTUYwK1BFMDBqbVFnU3FtSWNVZlhzeXk0?=
 =?utf-8?B?Y21rNUJBWVo3TWFmVzRJQ2ZyN1UzTHA0L3YwbW9hZUhBbThrb0c0bi9ZMWI3?=
 =?utf-8?B?b3FvUmhFNXpNSXFQOExmK1drMEtYc2tOZWVWV3N5N3FKN2ZVV09UTnpvcEl6?=
 =?utf-8?B?K0UvOEdYQnVHTTU1TmEzWm5CS1BXeVZaN3ZtRGFLeC9XVkxoVkYvbldDcjNm?=
 =?utf-8?B?bFpkbHBySXo3VEZwQ0hwdk5DckE5WjNLalFTeTE5cmJZVGJ1czVaY002TmtL?=
 =?utf-8?B?Q2I3Q2l3WTFUZitsbjRNQ1NiMFJyYTEvN0RsTzVoRDgzcjU2T2I2UDlXOVEw?=
 =?utf-8?B?clUwQUgzTDFaMzd1WFpxcnZJNzEzNkdWUDNTVGthK0tXeEt1K01QYVdjS3ZH?=
 =?utf-8?B?SkhWbkt1ZDgzVExVSy9PZHJaaVRmTm1lMjBBNHNJdHdzc0lNUGhxSno3R3ow?=
 =?utf-8?B?YVphV0pCbUV5VER0dCs0MDZYdGhhQWZJdW1NTUwxdW1nMDlLdUlEYWdjT3pk?=
 =?utf-8?B?cEthKy9OaEtrSjExUHdsekxxVXdBMVRwN01ua0VldFMzWVNWTWVXVXA0M2Zw?=
 =?utf-8?B?cTFLZ0tYU3FoU0VoUDRCNkVBek1EeEh5ZTNDRFpETWpxSkIyQU1sdE11VnJV?=
 =?utf-8?B?Z1QzQmIyV1VXOTNmY0ZOVzdOSGh3Z3VUSE9ZVkFsMy9uYzh0QXk1cVVPU1Er?=
 =?utf-8?B?SmFKYW9SMi9vaWNuY1NzUFJySUpYcUVGc0JzOElXWVUrUmllbVF4MlRQM0c5?=
 =?utf-8?B?Y3hyYTROUFQyWEcyU3RJNVY2M2JQY2MxMnNCQllWRWF4U1RXaVNGWUNvSDlC?=
 =?utf-8?B?dHVRU04rZXg3d0hBZUphcHhZK29zM2VTdkNZRy9CcVgxM3FEeVhKdzQ1MkVS?=
 =?utf-8?B?V3Qwc3hoUlJpc0pyamVYbGpVMHN0dEduTVN5alZYT1BtRHZGYnl5TnJlV0VJ?=
 =?utf-8?B?Qm5IckJLTDFGbXE4NU9XaTFlNDZ0VjJXemtVTEF5cmNyVjg3OGZoQmNzK3VT?=
 =?utf-8?B?QzRIOE5LOFhwWnJ0WDdEUT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F60D55479792E469642827DC1515F21@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3525.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c67cbc22-b915-460f-d710-08d8e29df920
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2021 01:52:18.8877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XX+2tbnbmrBCL+DVvoKT+RIRt9cUO1vfdk15P2tD/LuWWeaVR1AUV+1aWf2FKOSbri8W/+igYcxOl7t3E2GaIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3862
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIxLTAzLTA4IGF0IDE3OjIyIC0wNTAwLCBKYXNvbiBCcmVpdG1hbiB3cm90ZToN
Cj4gVGhhbmsgeW91Lg0KPiBEbyB5b3Uga25vdyB3aGljaCBrZXJuZWwgdmVyc2lvbiBpcyBmaXhl
ZD8NCj4gSWYgbm90LCBpcyB0aGVyZSBzb21ldGhpbmcgSSBjYW4gbG9vayBmb3IgaW4gdGhlIHNv
dXJjZSBjb2RlIHRoYXQNCj4gd2lsbCBpbmRpY2F0ZSB0aGF0IHRoZSBrZXJuZWwgaXMgZml4ZWQu
DQo+IA0KDQpBcyBJIHNhaWQsIHRoZSBwcm9ibGVtIGhlcmUgaXMgdGhhdCB0aGUgc2VydmVyIGRv
ZXNuJ3Qgc2VlbSB0byBiZQ0KY2xvc2luZyB0aGUgc29ja2V0IHdoZW4gdGhlIGNsaWVudCBkb2Vz
LiBZb3UgZGlkbid0IGFjdHVhbGx5IHRlbGwgdXMNCndoaWNoIHNlcnZlciB5b3UgYXJlIHVzaW5n
LCBzbyBJIGRvbid0IGtub3cgaG93IHRvIGFuc3dlciB0aGF0DQpxdWVzdGlvbi4NCg0KDQo+IEph
c29uIEJyZWl0bWFuDQo+IA0KPiANCj4gT24gTWFyIDgsIDIwMjEsIGF0IDU6MTUgUE0sIFRyb25k
IE15a2xlYnVzdCA8dHJvbmRteUBoYW1tZXJzcGFjZS5jb20+DQo+IHdyb3RlOg0KPiANCj4gT24g
TW9uLCAyMDIxLTAzLTA4IGF0IDEzOjE2IC0wNTAwLCBKYXNvbiBCcmVpdG1hbiB3cm90ZToNCj4g
PiBJc3N1ZQ0KPiA+IE5GU3Y0IG1vdW50cyBwZXJpb2RpY2FsbHkgaGFuZyBvbiB0aGUgTkZTIENs
aWVudC4NCj4gPiANCj4gPiBEdXJpbmcgdGhpcyB0aW1lLCBpdCBpcyBwb3NzaWJsZSB0byBtYW51
YWxseSBtb3VudCBmcm9tIGFub3RoZXIgTkZTDQo+ID4gU2VydmVyIG9uIHRoZSBORlMgQ2xpZW50
IGhhdmluZyBpc3N1ZXMuDQo+ID4gQWxzbywgb3RoZXIgTkZTIENsaWVudHMgYXJlIHN1Y2Nlc3Nm
dWxseSBtb3VudGluZyBmcm9tIHRoZSBORlMNCj4gPiBTZXJ2ZXINCj4gPiBpbiBxdWVzdGlvbi4N
Cj4gPiBSZWJvb3RpbmcgdGhlIE5GUyBDbGllbnQgYXBwZWFycyB0byBiZSB0aGUgb25seSBzb2x1
dGlvbi4NCj4gPiANCj4gPiBJIGJlbGlldmUgdGhpcyBpc3N1ZSBoYXMgYmVlbiBkaXNjdXNzZWQg
aW4gdGhlIHBhc3Qgc28gSSBpbmNsdWRlZA0KPiA+IGFuDQo+ID4gYXJ0aWNsZSB0aGF0IG1hdGNo
ZWQgbXkgc3ltcHRvbXMuDQo+ID4gSSBkbyBub3Qgc2VlIGEgY2FzZSBzdGF0ZW1lbnQgZm9yIEZJ
Tl9XQUlUMiBhdA0KPiA+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y0LjE5LjE3
MS9zb3VyY2UvbmV0L3N1bnJwYy94cHJ0c29jay5jDQo+ID4gLg0KPiA+IA0KPiA+IE5GUyBDbGll
bnQNCj4gPiBPUzrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgRGViaWFuIEJ1c3RlciAxMC44DQo+
ID4gS2VybmVsOiA0LjE5LjE3MS0yDQo+ID4gUHJvdG9jb2w6wqDCoMKgwqDCoMKgIE5GU3Y0IHdp
dGggS2VyYmVyb3MgU2VjdXJpdHkNCj4gPiBNb3VudCBPcHRpb25zOsKgIG5mcy0NCj4gPiBzZXJ2
ZXIuZG9tYWluLmNvbTovZGF0YcKgwqDCoMKgIC9tbnQvZGF0YcKgwqDCoMKgwqDCoCBuZnM0wqDC
oMKgDQo+ID4gbG9va3VwY2FjaGU9cG9zLG4NCj4gPiBvcmVzdnBvcnQsc2VjPWtyYjUsaGFyZCxy
c2l6ZT0xMDQ4NTc2LHdzaXplPTEwNDg1NzbCoMKgwqAgMDANCj4gPiANCj4gPiBPdXRwdXQgZnJv
bSB0aGUgTkZTIENsaWVudCB3aGVuIHRoZSBpc3N1ZSBvY2N1cnMNCj4gPiAjIG5ldHN0YXQgLWFu
IHwgZ3JlcCBORlMuU2VydmVyLklQLlgNCj4gPiB0Y3DCoMKgwqDCoMKgwqDCoCAwwqDCoMKgwqDC
oCAwIE5GUy5DbGllbnQuSVAuWDo0Njg5NsKgwqDCoMKgIA0KPiA+IE5GUy5TZXJ2ZXIuSVAuWDoy
MDQ5wqDCoMKgwqDCoMKgIEZJTl9XQUlUMg0KPiA+IA0KPiANCj4gWW91ciBjbGllbnQgaGFzIGNs
b3NlZCB0aGUgY29ubmVjdGlvbiwgYW5kIGlzIHdhaXRpbmcgZm9yIHRoZSBzZXJ2ZXINCj4gdG8N
Cj4gY2xvc2UgdGhlIGNvbm5lY3Rpb24gb24gaXRzIHNpZGUuDQo+IA0KPiBJJ2Qgc3VnZ2VzdCB1
c2luZyBhIG5ld2VyIGtlcm5lbCwgb3IgZWxzZSBnZXR0aW5nIHNvbWVvbmUgaW4gdGhlDQo+IERl
Ymlhbg0KPiBwcm9qZWN0IHRvIGZpeCB0aGVpcnMuDQo+IA0KDQotLSANClRyb25kIE15a2xlYnVz
dA0KQ1RPLCBIYW1tZXJzcGFjZSBJbmMNCjQ5ODQgRWwgQ2FtaW5vIFJlYWwsIFN1aXRlIDIwOA0K
TG9zIEFsdG9zLCBDQSA5NDAyMg0K4oCLDQp3d3cuaGFtbWVyLnNwYWNlDQoNCg==
