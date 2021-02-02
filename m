Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A8730CE30
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Feb 2021 22:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbhBBVuU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Feb 2021 16:50:20 -0500
Received: from mail-mw2nam12on2121.outbound.protection.outlook.com ([40.107.244.121]:65249
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232330AbhBBVuS (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 2 Feb 2021 16:50:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byXSoXYAXZfBGZI1L3YXmzY6fze9FDmmZqZjTdeF7+iLr3zhSGkohJcDU/nq+g8FsZYrk0iHuTGtqHQ8hcHcSOsZtms79Dv/o7/c96gPJ9pn/6aqVGfT2fgk57QcMCe0DWQg5xhTk4cu+jex1RJv0K9FhQx1aSi7ME6fhZxRQjocpUudnVshuBl9HlIfDrHYcmiDkhE1tqn6mJXvYp6lbe7B/Vpvfrl17NESjMjp4mbrHA2eqBKHO2HFLEgwMl4T5RQfyssaLxlaqN4OUvY7JeXWFfGIC0w2cbHhTcIYwEGsj109J993q5jXVFPwAeiEK3vMyWqRSeXbfL4pi57v5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jky2qzY+I7n0TxOqTiGOqZk7rgxhGfr71xotRclh1sM=;
 b=UKm2yLbindRVlfF81ZEhP6z71pEBHJr+WO3OjA9J0jB7G9DzXLtl/7xTPTZRH6fjGLNI+Dvo/USCaZYaoeJ6S4wseTzErPHlIInIm9cmWTWeQiA+8PDhFEC1J7SJePZMVSqQ2jx18dEQQstYrbt/Xs1Wa1zAysMV25G4Nx+VC0AnIFlh7985lvmDTjR7rsr3ZUAPpA5LVQ3RevfAbqs7Imeq3RArRTwjRIkTrAVNRu0eqvGHozvPJIJNPA35FIPjcPmqoDIMNQnkfSFLff4YIMNRi2ITp9J6cWBODfAvV/YQ2TWEw2T/2vmuzx2jtQ494Bd16lHJsG3QAMgcgltVlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jky2qzY+I7n0TxOqTiGOqZk7rgxhGfr71xotRclh1sM=;
 b=cHtFyKPRIYGfRymU/5cKGFAt+ZLHqa95auz6SOV7NIcxufPUgAPDmH0nbLNMGH98tKqsJnS1uLXA2hHGoG7WHPDfzli0ySfrJSwVD9efRFxYJTUpenV/I+9na56bc+C6KI91VWXYajGulHc0QQzghNGDaoVYU3ADhIq1uuGgp5w=
Received: from (2603:10b6:610:21::29) by
 CH0PR13MB4569.namprd13.prod.outlook.com (2603:10b6:610:dc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.8; Tue, 2 Feb 2021 21:49:24 +0000
Received: from CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063]) by CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063%3]) with mapi id 15.20.3825.019; Tue, 2 Feb 2021
 21:49:24 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "schumaker.anna@gmail.com" <schumaker.anna@gmail.com>
CC:     "Anna.Schumaker@Netapp.com" <Anna.Schumaker@Netapp.com>
Subject: Re: [PATCH v2 4/5] sunrpc: Prepare xs_connect() for taking NULL tasks
Thread-Topic: [PATCH v2 4/5] sunrpc: Prepare xs_connect() for taking NULL
 tasks
Thread-Index: AQHW+ZOhlmr2IFKn00WnCLsTmFyjBKpFZ12A
Date:   Tue, 2 Feb 2021 21:49:23 +0000
Message-ID: <4eaf0c288d97a2d03c5cd2a7ed728a73085b2719.camel@hammerspace.com>
References: <20210202184244.288898-1-Anna.Schumaker@Netapp.com>
         <20210202184244.288898-5-Anna.Schumaker@Netapp.com>
In-Reply-To: <20210202184244.288898-5-Anna.Schumaker@Netapp.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a88de6e5-aaa5-4c93-628f-08d8c7c467b9
x-ms-traffictypediagnostic: CH0PR13MB4569:
x-microsoft-antispam-prvs: <CH0PR13MB45696EB348DCB6031E14E059B8B59@CH0PR13MB4569.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MBVRIqliDBGIh5xAKEvkQpvWrtiOUfIGBiIsI9mXrFQS85xbv/76LeocZH+13uoIhpwGEMI2DmpfqTh55rYhIWwJDEKeECnt8s8xE9LFxGJUUK1T4h+Fi8NdeXYYc9J9tm9McCc9s6vgbq28CwdCLiNBnZCWSPFAPhuxGcPtIdS+r9bimD+w+n9+KFnu5E6f4FPbU4JgtUkOO3oZZ2FBaZec8zI4vyEFMdxdAk9oOhBzIjzzZvb7BbWba/wfjgRxzVS3r3tLPrmgnZdp0eeSJ+xZ/BJpIe6EGK7nsEkZiRwFrlMK5VvCL2iErhbOSVA9LZ2c5kS+Ak7NKkmVknkeWYFm1Hb3vfoa3MNinqcLlwuHDwocQT1nNcarf2kqcsW/Kfunr+pL1COB2qQlde2eEzzAj6EvefftOREwL1CAnoCIpez8BA1U+fshCFKpoH9b0Q+ZgZVrxvJt7Hi7+oGbYpY6NEfTSsCB+67EXxlAXlz6cNIsn6xqpDdSQmUcrdNje5WfN5rPTRRuhmUsf9ovzw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3525.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39840400004)(136003)(376002)(346002)(366004)(2906002)(316002)(6486002)(8676002)(26005)(6512007)(186003)(4326008)(2616005)(5660300002)(83380400001)(478600001)(6506007)(8936002)(86362001)(64756008)(66476007)(71200400001)(110136005)(66556008)(76116006)(66446008)(66946007)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?eHE3Ym1TNGtrSWlHdFB4UFJRbWs2WlFZUnJudmlTYXJlMGowTnByNFl3ZnE1?=
 =?utf-8?B?K0VTTGV6blRabC94MFVmSmhLOFNlYS81dlFkK0xMdEtCclFRYXlNeHV4VEQ4?=
 =?utf-8?B?MS82ZnV2bCtGUUNzRDVFclRqUXNta0wzSkNOcm5oL2RIVlh6L2lZZlFmT2ZZ?=
 =?utf-8?B?TFYzeXFibmlwbmlKYWtlRm1SemtEclRDRXluMU9RRktEOXlWc2xvVS9PMUhI?=
 =?utf-8?B?SHRDZWZQajBDc00wQU9mcVhJUTgxbG13SWxWTmFhYVhJeGtGaGxLeEc2TTBh?=
 =?utf-8?B?a3RzVlhoalN2bGNyc2ptZDRvcWJtbjM1LzZXSXhLYm5TQTNpTHpNSksxdjV0?=
 =?utf-8?B?VG5VRkdETmlzUHE1cVRyRGwwZFpHWTJIOTZHdTBvSWZycFd2cjJZckt3bW56?=
 =?utf-8?B?anlOL2dZRTh4V296a3hGTVBtUGdVQUZQNU5zWitzUzFob1dWdTBTR2drN1pv?=
 =?utf-8?B?K01VUUxKd2tZc0QyRGl1ZEtzeUZPazhUMllVZUZaVVJKQUpSN28zM2htc3h5?=
 =?utf-8?B?UnVMK0FNYWRQOUp0K2FUbE1ORlpSQzM5SDBGWXFuOVVqMHJ5RHJONkp3OTZ4?=
 =?utf-8?B?YysrZ21qUE04bGdFY2VaZ3hHZThqOExPQlIzNW5vU0ltY3ZDVnRXVElJajFl?=
 =?utf-8?B?dEJyUmNURjNzZ3RIUGZ1SUhXcU9nOVFlWk9DWTkwVHVjdDFYTEhEUUxnOFB1?=
 =?utf-8?B?WDhGZWNERFVOaTBteWN2NnErQ2JyTXk5ayt6MlRNQmVXN2U4THRVaVlvOVQ1?=
 =?utf-8?B?RitXWkNTMEh2OEZ4VlpKZk0yaC9ldldzM1p6a045V2RJNDdsQzNOeTZtbkxq?=
 =?utf-8?B?TjhKNmlGMHFmOC9MRkhVMGpHdjdmRzZPejB4Q1V4T0c2NkVGUExlUVFvcVdS?=
 =?utf-8?B?YXU2b09QeXR6T1p4b0pVOURWTkdnOG5XS2VrVzZMU2lDRWFacDBvTU9vWm0y?=
 =?utf-8?B?YWN1LzNoTkkxRjVhekhHKysrTStJbmZMZ2VWN2ljTXVqVmdWSDVUSzBBV2F1?=
 =?utf-8?B?YmF6N1UzdXE1dlliK3R6MUpDcWl6dm5TNThGK2VpcjdjNXVLQU04Y1I3Mm9j?=
 =?utf-8?B?RFVWWGFKZWZoOVkvY1VTVFh1RnVJcW40UHQ1UkIyWjR1ZGNsUHNrUUZBd2pk?=
 =?utf-8?B?NGlQSU5SalhXZ3pqdkZ1WUdqaDFMSm5UZmtGMmtWbFhvbDJ4WXByWXNhOE5i?=
 =?utf-8?B?SFdrQWFQNmU0d1hRSXhsUjdhKzl2K2U5Z1lBUUdUUHlOSEFZN0ZaQ0NxMURM?=
 =?utf-8?B?US91SVduSENCTW9tcGduYTg2ZnFvSDhVVEtPSjBJVDV4UjZZcjdjZ2dCQlFa?=
 =?utf-8?B?U0txVWJlWHdOVmtNK3JPWk52ZzJGNDQ3dmVUdkdDejJxeTk2dWRTdmtYWStT?=
 =?utf-8?B?V0VSRDRMZjFvbWNXeTZaS1hQY2tuNmxmNXhNTEY5VFVWUUdMRkNCT041aHRH?=
 =?utf-8?B?dk1kUFF5YjRCdGNwZ1RqR3BPUWkwSEJ6Z0xqMW1nPT0=?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <08ADC2B1C3FDCC458CAEA358ACCFFE2B@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3525.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a88de6e5-aaa5-4c93-628f-08d8c7c467b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 21:49:23.8626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ONPN4U0GdzuK1npbjbl2H9FlYIm1un47SUc+JHNVPGzlYjXUtB4yMoxQ60HRGHkqvXHLiyGHl4dISMPqEsNOJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4569
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIxLTAyLTAyIGF0IDEzOjQyIC0wNTAwLCBzY2h1bWFrZXIuYW5uYUBnbWFpbC5j
b20gd3JvdGU6DQo+IEZyb206IEFubmEgU2NodW1ha2VyIDxBbm5hLlNjaHVtYWtlckBOZXRhcHAu
Y29tPg0KPiANCj4gV2Ugd29uJ3QgaGF2ZSBhIHRhc2sgc3RydWN0dXJlIHdoZW4gd2UgZ28gdG8g
Y2hhbmdlIElQIGFkZHJlc3Nlcywgc28NCj4gY2hlY2sgZm9yIG9uZSBiZWZvcmUgY2FsbGluZyB0
aGUgV0FSTl9PTigpIHRvIGF2b2lkIGNyYXNoaW5nLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5u
YSBTY2h1bWFrZXIgPEFubmEuU2NodW1ha2VyQE5ldGFwcC5jb20+DQo+IC0tLQ0KPiDCoG5ldC9z
dW5ycGMveHBydHNvY2suYyB8IDMgKystDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL25ldC9zdW5ycGMveHBydHNv
Y2suYyBiL25ldC9zdW5ycGMveHBydHNvY2suYw0KPiBpbmRleCBjNTZhNjZjZGY0YWMuLjI1MGFi
ZjFhYTAxOCAxMDA2NDQNCj4gLS0tIGEvbmV0L3N1bnJwYy94cHJ0c29jay5jDQo+ICsrKyBiL25l
dC9zdW5ycGMveHBydHNvY2suYw0KPiBAQCAtMjMxMSw3ICsyMzExLDggQEAgc3RhdGljIHZvaWQg
eHNfY29ubmVjdChzdHJ1Y3QgcnBjX3hwcnQgKnhwcnQsDQo+IHN0cnVjdCBycGNfdGFzayAqdGFz
aykNCj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBzb2NrX3hwcnQgKnRyYW5zcG9ydCA9IGNvbnRh
aW5lcl9vZih4cHJ0LCBzdHJ1Y3QNCj4gc29ja194cHJ0LCB4cHJ0KTsNCj4gwqDCoMKgwqDCoMKg
wqDCoHVuc2lnbmVkIGxvbmcgZGVsYXkgPSAwOw0KPiDCoA0KPiAtwqDCoMKgwqDCoMKgwqBXQVJO
X09OX09OQ0UoIXhwcnRfbG9ja19jb25uZWN0KHhwcnQsIHRhc2ssIHRyYW5zcG9ydCkpOw0KPiAr
wqDCoMKgwqDCoMKgwqBpZiAodGFzaykNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oFdBUk5fT05fT05DRSgheHBydF9sb2NrX2Nvbm5lY3QoeHBydCwgdGFzaywNCj4gdHJhbnNwb3J0
KSk7DQoNCk5pdDogVGhhdCdzIHRoZSBzYW1lIGFzDQogICBXQVJOX09OX09OQ0UodGFzayAmJiAh
eHBydF9sb2NrX2Nvbm5lY3QoeHBydCwgdGFzaywgdHJhbnNwb3J0KSk7DQoNCj4gwqANCj4gwqDC
oMKgwqDCoMKgwqDCoGlmICh0cmFuc3BvcnQtPnNvY2sgIT0gTlVMTCkgew0KPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRwcmludGsoIlJQQzrCoMKgwqDCoMKgwqAgeHNfY29ubmVj
dCBkZWxheWVkIHhwcnQgJXAgZm9yDQo+ICVsdSAiDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpM
aW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RA
aGFtbWVyc3BhY2UuY29tDQoNCg0K
