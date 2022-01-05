Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7922248557C
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jan 2022 16:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbiAEPKL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Jan 2022 10:10:11 -0500
Received: from mail-dm6nam11on2132.outbound.protection.outlook.com ([40.107.223.132]:42721
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236671AbiAEPKL (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 5 Jan 2022 10:10:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BAzaEc6gmU7f6rBhcdvRhQkHeqwcXmUC85iFuLlJq7NKL7SBMg3lD3WrktaXZxaUCvj2BAHLgxL+ZpVFFTaAMw2gyUsCyHRKSfCXjTQ+PXKYAPVT8n2ZQ2r9sQbIvL/ZU55s/WMPbOSkva/zQ3fDdNQysxZvB0u1uM0s5XpDDPxIaXENKX2bKY76YcK1zRuY9SM3SvrUkdQ7xHw9hasKCinXGaH/3ZXugqnU7vqgwAzXqjYSUo7mhN0OxmrTAxmY75uWr67qn5AcGxuHMFdjo/p3geRj3kf6jthZjlXXYrp/WtMUPXr55gu1QNKewKC9SvYt8qcHi7vIY8YL5QGuDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+jJ+4cLtJUUoiJFiWLJASFqN3+lsJIOY+ySFKrdq6k=;
 b=YmNPe9eqzTDqlPHNP0lccd6LyAJ9zwkV5cRJy08elGBZs6CmcKPmqLTaSw12G9jrwxuRldcIc6OZfZMWrrrL55+5/K70tSPyILdaVt4gs95eLiTqeIp5K6Tfp0djLBw/F4R1CcKDDV+ifp5/u9jPx1aJ/Ue/nNOW4cBR2s+6G9d2lIoBIg+jos+/wCpUGYVQB54vnEmWmp1t2oUJtdTuDreVx0UhmdcixmWvLQN/jRU4XAmD9Yg4llZLTUP6F2rWhcdI47hCRX+rpl4RpXZxhivd9K/d8ZciJY9e+5lIq/3fN2+QNMo0L9ZgozLrAhKRhDRCN9C/pS51Fdg5wdwcyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+jJ+4cLtJUUoiJFiWLJASFqN3+lsJIOY+ySFKrdq6k=;
 b=TNJtiGD3oPFvYJAV6AuIOJiUG8saBg0p1t7X8EGTX6rF1119nQ2dyOUJhCocNL/qQbEmL/qNbisbxEj+MRJJrHspwOLmFoUXB3GsbsuZ80K6kMIrEzhX4LWSUYmImvEYx+3tZRNcIfPEhHapd0MSN0UwmuZoJCjhdBTXUG5miAE=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BYAPR13MB2423.namprd13.prod.outlook.com (2603:10b6:a02:c6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.4; Wed, 5 Jan
 2022 15:10:07 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08%4]) with mapi id 15.20.4867.007; Wed, 5 Jan 2022
 15:10:07 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "ondrej.valousek.xm@renesas.com" <ondrej.valousek.xm@renesas.com>,
        "trondmy@kernel.org" <trondmy@kernel.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH 0/8] Support btime and other NFSv4 specific attributes
Thread-Topic: [PATCH 0/8] Support btime and other NFSv4 specific attributes
Thread-Index: AQHX84heTqWsdlviIkSCjyYpUqzp8qxR4CyAgAAAK4CAAsPkgIAAAVeA
Date:   Wed, 5 Jan 2022 15:10:07 +0000
Message-ID: <1cb17c4229c9821d763284eda0e11c06af3d1a84.camel@hammerspace.com>
References: <20211217204854.439578-1-trondmy@kernel.org>
         <20220103205103.GI21514@fieldses.org>
         <2b27da48604aaa34acce22188bfd429037540a89.camel@hammerspace.com>
         <DU2PR10MB5096010E9570E2718198EDD5E14B9@DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <DU2PR10MB5096010E9570E2718198EDD5E14B9@DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d052ef36-fe9f-41e9-3bf5-08d9d05d75a6
x-ms-traffictypediagnostic: BYAPR13MB2423:EE_
x-microsoft-antispam-prvs: <BYAPR13MB242387B1FA8699DD9CC85F83B84B9@BYAPR13MB2423.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vomk06J47cu8VLvX1GoiULA9NHS3gA9AGqXHH99nKBSYeaKK4usFo0qBD2QCT70sVd6lP7fyP5Yuij3OrNHd+XSDtpCIkJnpSPMT2X2FwV7IghYHmh/Kqazb/2b/GeWx9ar3HTBzLAHq1rsb1SZSfmeGG5Zjhb96jor3h0/SiDffSIF3Cbq0gdA5yiWowxLOkq1cJHcVXAIeeADpUnpAHpbIF5wJ71Pru7rflgad4gV1hu2m3El3Jp3NKOPQMMmFJbjyLkof/l6j34valULQ0pIKnCcb3Q515/+kDGtXHMDyitn8UDbbj7o69HsIPb5cRKt1U/IiCZomkC9eDgNsrclSjyY00FHhaehSjN20vZPo+NToCoPaUZVgnZ2WYkFu/Q8EA8zDkfvjiawE2blDCHbR/EIhCzuICbQ84sMtphLYw9PTH2I61RAROw/ccosnEc1BtyoGxfjdorVnEcy4Fmej6ItAJ79Ib5EtmEeD3mhjy/2wGv2fQCOnboecNGV/v03oeVUM+mhdQEbjfZ+pusBLkkBeIV2aVzxDTdoRZIL/RoOe7N32DGjdlep+jB0rhk6TLxziqnIO9ialfrKOC/Dx9DmiHeTNWSEp5JK/pfCURLS8I2tE5mE+HICw+0oiT5/5QG/VSPC385GTZPGOsM6rXmM6Ff7WTUawUWBUbNarE5E67X1l0ZhNgABV7551Apo+xkb6G2qbR9RjKYAr9lu5VlO4OareXxJsTeQiUbUkJvcrjKsinKDPEcEPS2s1B0X/T7ukKqCTWGhnQ5OtxNm5jYR8LomRrhUlb6jy7SI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(136003)(376002)(346002)(396003)(366004)(39830400003)(316002)(2906002)(36756003)(110136005)(38100700002)(76116006)(53546011)(54906003)(38070700005)(186003)(2616005)(6486002)(26005)(6506007)(122000001)(71200400001)(6512007)(4326008)(66946007)(66574015)(5660300002)(83380400001)(15974865002)(508600001)(64756008)(66446008)(66476007)(66556008)(86362001)(8676002)(8936002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDRoc2ZJOWJqc0tDbXY3V09ua0N5bkJremZkdGN1QkpkbEplYU5BbFpZanlq?=
 =?utf-8?B?SmwrZ2t2Q0k2VWNreGhXSlRoNHdJbHhjTFU0aUg1MC8zRUs2TWR5ZTNUMTY1?=
 =?utf-8?B?REJBM3d4VmlrZnFWZmpaV0crdGFOdkl1ZGVPcUhRRGRIN1BnTmNDd2dYMDVw?=
 =?utf-8?B?Q3FEWExZVFlJRnE0ZWZKenI0dVJPeXhldERjZW9tK0FCdGtWQWF1YzBVYndE?=
 =?utf-8?B?RDVXYnZsY0V2d2Q1cEo3RXI1WHBTSGlFcHpFMnVNN1FMNXlGckIzMzF6WlZ1?=
 =?utf-8?B?T0hjSmE4eUx5M3hka01ZL29UTmd0TkdvdHhYLy85b2VrRmtOd0tRZlFHVS9O?=
 =?utf-8?B?SnJuTFRxN292V1pHTFFybTAza050dUU0S1lwUXEvcGhocFVwQnF4MkVZbndD?=
 =?utf-8?B?TGxhU0pBOXZSZkNvM3hYVzN1RVkwZWhyYzVCekZJdDc0eXIxMW9vUXZZTEky?=
 =?utf-8?B?bHpiYVIramtmZ2FNZlNQZzdqVmRDUUxMSHBBK2dtYVpFaVNEd3hWRSsxR1FC?=
 =?utf-8?B?NitKNVJMLzZHamw5SVZBT3I0dlJyQlJYZzNFakE2OUFTM1VDNFk2NCtWeWxT?=
 =?utf-8?B?OHRqa3NjOWh3Q1VMWnNRaUNscmhrNDVXRkRreWlrc0s0eG1xam1CZ1J1NndN?=
 =?utf-8?B?R0JYaVRvUXh3aUtFaFhxU0h0ZVJXRC9FYWk5QTFwYXpPS2M3NnBVZno5Y0Vm?=
 =?utf-8?B?b1htOWgrazBZbEhrZENvQjluQ051Unk5ZDFpeEtuYjV6TXhtZHAxYUdCVHdY?=
 =?utf-8?B?TVY3dllGdUE0Z3FpSmVBaWVhamJGY01NbWxBK29BdmlBc2wxWFNzZ05lRGxY?=
 =?utf-8?B?czNoY3BQM2ZDcjdhU0NUbTUxV3NuT0dPLzc4ZE12T2RwMEVLR3VQU3hwZzgx?=
 =?utf-8?B?bzR0MVdnbGY1b1JvUnoxY3lsdFR6ZGw0dnJYVXZ1SmtLMVRCbmVGbzRkVzdz?=
 =?utf-8?B?QUNVQUJFSVJyaFMxQWdKMGFvdGVKdGZFQkNXTHdhRC9hNU12U0oyU2pLenAr?=
 =?utf-8?B?L0tUZS9kUy9LYXY1YTlabFVDUTYyTElpVVMzcFRsZmd3Z3BFYUh1OVdBdEZT?=
 =?utf-8?B?WWJNN1VtN2dUS213SUxRS09PNk84emM3d0hCdEtKeTdiaUdJTXpSZ1Y3cXV3?=
 =?utf-8?B?REFqR3dvOXBnL2x0bW43cnJSak9WUkxIQVEvakN4Zi91VG5md1o5V3FkcFk5?=
 =?utf-8?B?aWE5NkhMQkVOdE45ZkxKbTl4YTU4YzFvUnFMNTZVTk45M21XN05ydThyRWNN?=
 =?utf-8?B?SFBNZEpaeWNzVys5dGJMZ3lVYjgwRzdWc1l1TFA3cVE5bkIvZkpsR3doa0pm?=
 =?utf-8?B?S25nVVhtOThPR2Uwd2NuMFVEVysva2gxVVBEaUtVY05jQkNTdXpZcDhrZStL?=
 =?utf-8?B?b3gwenNCUjJQNXBCTTYrcENGNnMvNS9rbURreXZmZnF5NFZEKzNLdnVieWFr?=
 =?utf-8?B?S0ZwR1ovMXphRnNKMUNKOUJvY3FBVXFnbG9oOGU4WStpUEh1T3lEelZBSWVw?=
 =?utf-8?B?b1R0VG9nVE16RS90OUM4bXI1aWc4WHZLYkRIc3NaN1NRQmxYb2lpVm9TMnRJ?=
 =?utf-8?B?d1BmM2FPYnpJSXJSdEVtV2k3L3VFZGE0c1owMWdETWs2MlRjRWZnQUtYaDBi?=
 =?utf-8?B?SnRJbzVPZWg0K0dzUmJ6RHdmaEM1SlNFTGFPWUs5TDBSdmorYjd4TU1UaDMz?=
 =?utf-8?B?OEp4WmVtQXdMSnZ5Ny9EZnQxOTZsMzZ1ZjJyZ2ZvQldtQWE2MUdDSjlCRllt?=
 =?utf-8?B?RnFZYnBNQWRXczlIWUVId203RS9TWG1Ta1VZVkV1TFhxRWpISWxRY1ZYcTJ2?=
 =?utf-8?B?UytDSlY4WDltMWFKbzEwRUthTXVacEVyb1FIK2x0NmhRRWF5K3MrN1d4Yk9L?=
 =?utf-8?B?aUdSSzZsclVIaXVNb096MmZvVy9BSzQvanIyN2toTUJqUSsrL2w5TXF6UmhR?=
 =?utf-8?B?SWVPTmYwb2s2RnhCWXNHd3FETG0zOU9UeXdMUm03eCtzZXg2L2FuR2s0WEpD?=
 =?utf-8?B?YnBVTTB1R09qZWlXek1ZZkJZTHlOT2Q5TEV3Tm5wTjIzK3pzdE1PTmxtWWdw?=
 =?utf-8?B?ZHpkVkRDZFpTODFOZkRVZlpWWW4xVzl5T3pYcTlhcjBjaWk0RG96bldobURq?=
 =?utf-8?B?K2VleE52dHlvTXV4bVM3allBblNQUzg2TDRtMVRRSmVBM3RkSExaK3ZkMWhw?=
 =?utf-8?Q?3T3W4XvliAR8thjeh4BPXG4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <07C4D2CB38759644BE3A91C0C5DBBB17@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d052ef36-fe9f-41e9-3bf5-08d9d05d75a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2022 15:10:07.2895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nB2luoqNnfzUHT2sOvlWv8Y2mU7Jr5/BS4lTCo5+K142FsrFbTahMez8J8UpW4fkEWjPLWSfyziOd8G2oTX3sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR13MB2423
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIyLTAxLTA1IGF0IDE1OjA1ICswMDAwLCBPbmRyZWogVmFsb3VzZWsgd3JvdGU6
DQo+IEhpIGFsbCwNCj4gU29ycnkgZm9yIGNvbmZ1c2lvbiBhbmQgbWF5YmUgZHVtYiBxdWVzdGlv
bnM6DQo+IC0gVGhlIGFpbSBpcyB0byB0cmFuc2ZlciB0aGVzZSBhdHRyaWJ1dGVzIHZpYSBSRkM4
Mjc2IChGaWxlIFN5c3RlbQ0KPiBFeHRlbmRlZCBhdHRyaWJ1dGVzIGluIE5GU3Y0KT8NCg0KTm8u
DQoNCj4gLSBBRkFJSyBzdXBwb3J0IGZvciBSRkM4Mjc2IGluIE5GUyAob25seSB2ZXJzaW9uIDQu
Mikgc2VydmVyIGlzIHNpbmNlDQo+IGtlcm5lbCA1LjksIHJpZ2h0PyBORlMgY2xpZW50IHN1cHBv
cnRzIHRoZXNlIGFzIHdlbGw/DQo+IC0gVGhlIHBhdGNoZXMgYmVsb3cgaW1wbGVtZW50cyB0aGUg
ZmVhdHVyZSBpbiBib3RoLCBuZnMgY2xpZW50IEFORA0KPiBzZXJ2ZXIsIHJpZ2h0Pw0KPiANCj4g
SSBhbSBiaXQgY29uZnVzZWQgYXMgImJ0aW1lIiBkb2VzIG5vdCBzZWVtIHRvIGJlIHN0b3JlZCBh
cyBleHRlbmRlZA0KPiBhdHRyaWJ1dGUgaW4gbW9zdCBsb2NhbCBmaWxlc3lzdGVtcyAoY2hlY2tl
ZCBleHQ0KSBidXQgaXMgaW4gc3RhbmRhcmQNCj4gaW5vZGUgc3RydWN0dXJlLg0KDQpBbGwgdGhl
c2UgYXR0cmlidXRlcyBhcmUgZGVmaW5lZCBhcyByZWd1bGFyIGF0dHJpYnV0ZXMgaW4gcmZjNzUz
MC4gQWxsDQp0aGlzIGNvZGUgZG9lcyBpcyBhZGQgdGhlIHN0YW5kYXJkIE5GU3Y0IGVuY29kZXJz
L2RlY29kZXJzIGZvciB0aGVzZQ0KYXR0cmlidXRlcyBhbmQgYWRkcyB0aGUgaW9jdGwoKSB0byBz
ZXQvcmV0cmlldmUgdGhlbSBhbGwuDQoNClRoZXJlIGlzIG5vIG5lZWQgdG8gaGFjayB0aGUgTkZT
IHByb3RvY29sIHRvIHJldHJpZXZlIG9yIHNldCB0aGVtIHVzaW5nDQp0aGUgeGF0dHIgc3R1ZmYu
DQoNCj4gVGhhbmtzLA0KPiBPbmRyZWoNCj4gDQo+IA0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiBGcm9tOiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPg0K
PiBTZW50OiBwb25kxJtsw60gMy4gbGVkbmEgMjAyMiAyMTo1Mg0KPiBUbzogYmZpZWxkc0BmaWVs
ZHNlcy5vcmc7IHRyb25kbXlAa2VybmVsLm9yZw0KPiBDYzogbGludXgtbmZzQHZnZXIua2VybmVs
Lm9yZzsgYW5uYS5zY2h1bWFrZXJAbmV0YXBwLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDAv
OF0gU3VwcG9ydCBidGltZSBhbmQgb3RoZXIgTkZTdjQgc3BlY2lmaWMNCj4gYXR0cmlidXRlcw0K
PiANCj4gT24gTW9uLCAyMDIyLTAxLTAzIGF0IDE1OjUxIC0wNTAwLCBKLiBCcnVjZSBGaWVsZHMg
d3JvdGU6DQo+ID4gT24gRnJpLCBEZWMgMTcsIDIwMjEgYXQgMDM6NDg6NDZQTSAtMDUwMCwgdHJv
bmRteUBrZXJuZWwub3JnwqB3cm90ZToNCj4gPiA+IEZyb206IFRyb25kIE15a2xlYnVzdCA8dHJv
bmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4NCj4gPiA+IA0KPiA+ID4gTkZTdjQgaGFzIHN1
cHBvcnQgZm9yIGEgbnVtYmVyIG9mIGV4dHJhIGF0dHJpYnV0ZXMgdGhhdCBhcmUgb2YNCj4gPiA+
IGludGVyZXN0IHRvIFNhbWJhIHdoZW4gaXQgaXMgdXNlZCB0byByZS1leHBvcnQgYSBmaWxlc3lz
dGVtIHRvDQo+ID4gPiBXaW5kb3dzIGNsaWVudHMuDQo+ID4gPiBBc2lkZSBmcm9tIHRoZSBidGlt
ZSwgd2hpY2ggaXMgb2YgaW50ZXJlc3QgaW4gc3RhdHgoKSwgV2luZG93cw0KPiA+ID4gY2xpZW50
cyBoYXZlIGFuIGludGVyZXN0IGluIGRldGVybWluaW5nIHRoZSBzdGF0dXMgb2YgdGhlDQo+ID4g
PiAnaGlkZGVuJywNCj4gPiA+IGFuZCAnc3lzdGVtJw0KPiA+ID4gZmxhZ3MuDQo+ID4gPiBCYWNr
dXAgcHJvZ3JhbXMgd2FudCB0byByZWFkIHRoZSAnYXJjaGl2ZScgZmxhZ3MgYW5kIHRoZSAndGlt
ZQ0KPiA+ID4gYmFja3VwJw0KPiA+ID4gYXR0cmlidXRlLg0KPiA+ID4gRmluYWxseSwgdGhlICdv
ZmZsaW5lJyBmbGFnIGNhbiB0ZWxsIHdoZXRoZXIgb3Igbm90IGEgZmlsZSBuZWVkcw0KPiA+ID4g
dG8NCj4gPiA+IGJlIHN0YWdlZCBieSBhbiBIU00gc3lzdGVtIGJlZm9yZSBpdCBjYW4gYmUgcmVh
ZCBvciB3cml0dGVuIHRvLg0KPiA+ID4gDQo+ID4gPiBUaGUgcGF0Y2ggc2VyaWVzIGFsc28gYWRk
cyBhbiBpb2N0bCgpIHRvIGFsbG93IHVzZXJzcGFjZQ0KPiA+ID4gcmV0cmlldmFsDQo+ID4gPiBh
bmQgc2V0dGluZyBvZiB0aGVzZSBhdHRyaWJ1dGVzIHdoZXJlIGFwcHJvcHJpYXRlLiBJdCBhbHNv
IGFkZHMNCj4gPiA+IGFuDQo+ID4gPiBpb2N0bCgpDQo+ID4gPiB0byBhbGxvdyByZXRyaWV2YWwg
b2YgdGhlIHJhdyBORlN2NCBBQ0NFU1MgaW5mb3JtYXRpb24sIHRvIGFsbG93DQo+ID4gPiBtb3Jl
IGZpbmUgZ3JhaW5lZCBkZXRlcm1pbmF0aW9uIG9mIHRoZSB1c2VyJ3MgYWNjZXNzIHJpZ2h0cyB0
byBhDQo+ID4gPiBmaWxlIG9yIGRpcmVjdG9yeS4gQWxsIG9mIHRoaXMgaW5mb3JtYXRpb24gaXMg
b2YgdXNlIGZvciBTYW1iYS4NCj4gPiANCj4gPiBTYW1lIHF1ZXN0aW9uLCB3aGF0IGZpbGVzeXN0
ZW0gYW5kIHNlcnZlciBhcmUgeW91IHRlc3RpbmcgYWdhaW5zdD8NCj4gPiANCj4gDQo+IFNhbWUg
YW5zd2VyLg0KPiANCj4gPiAtLWIuDQo+ID4gDQo+ID4gPiANCj4gPiA+IEFubmUgTWFyaWUgTWVy
cml0dCAoMyk6DQo+ID4gPiDCoCBuZnM6IEFkZCB0aW1lY3JlYXRlIHRvIG5mcyBpbm9kZQ0KPiA+
ID4gwqAgbmZzOiBBZGQgJ2FyY2hpdmUnLCAnaGlkZGVuJyBhbmQgJ3N5c3RlbScgZmllbGRzIHRv
IG5mcyBpbm9kZQ0KPiA+ID4gwqAgbmZzOiBBZGQgJ3RpbWUgYmFja3VwJyB0byBuZnMgaW5vZGUN
Cj4gPiA+IA0KPiA+ID4gUmljaGFyZCBTaGFycGUgKDEpOg0KPiA+ID4gwqAgTkZTOiBTdXBwb3J0
IHN0YXR4X2dldCBhbmQgc3RhdHhfc2V0IGlvY3Rscw0KPiA+ID4gDQo+ID4gPiBUcm9uZCBNeWts
ZWJ1c3QgKDQpOg0KPiA+ID4gwqAgTkZTOiBFeHBhbmQgdGhlIHR5cGUgb2YgbmZzX2ZhdHRyLT52
YWxpZA0KPiA+ID4gwqAgTkZTOiBSZXR1cm4gdGhlIGZpbGUgYnRpbWUgaW4gdGhlIHN0YXR4IHJl
c3VsdHMgd2hlbg0KPiA+ID4gYXBwcm9wcmlhdGUNCj4gPiA+IMKgIE5GU3Y0OiBTdXBwb3J0IHRo
ZSBvZmZsaW5lIGJpdA0KPiA+ID4gwqAgTkZTdjQ6IEFkZCBhbiBpb2N0bCB0byBhbGxvdyByZXRy
aWV2YWwgb2YgdGhlIE5GUyByYXcgQUNDRVNTDQo+ID4gPiBtYXNrDQo+ID4gPiANCj4gPiA+IMKg
ZnMvbmZzL2Rpci5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDcxICsrLS0tDQo+ID4g
PiDCoGZzL25mcy9nZXRyb290LmPCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMyArLQ0KPiA+ID4g
wqBmcy9uZnMvaW5vZGUuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxNDcgKysrKysrKysrLQ0K
PiA+ID4gwqBmcy9uZnMvaW50ZXJuYWwuaMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEwICsNCj4gPiA+
IMKgZnMvbmZzL25mczNwcm9jLmPCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDEgKw0KPiA+ID4gwqBm
cy9uZnMvbmZzNF9mcy5owqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAzMSArKysNCj4gPiA+IMKgZnMv
bmZzL25mczRmaWxlLmPCoMKgwqDCoMKgwqDCoMKgIHwgNTUwDQo+ID4gPiArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ID4gwqBmcy9uZnMvbmZzNHByb2MuY8KgwqDC
oMKgwqDCoMKgwqAgfCAxNzUgKysrKysrKysrKystDQo+ID4gPiDCoGZzL25mcy9uZnM0dHJhY2Uu
aMKgwqDCoMKgwqDCoMKgIHzCoMKgIDggKy0NCj4gPiA+IMKgZnMvbmZzL25mczR4ZHIuY8KgwqDC
oMKgwqDCoMKgwqDCoCB8IDI0MCArKysrKysrKysrKysrKystLQ0KPiA+ID4gwqBmcy9uZnMvbmZz
dHJhY2UuY8KgwqDCoMKgwqDCoMKgwqAgfMKgwqAgNSArDQo+ID4gPiDCoGZzL25mcy9uZnN0cmFj
ZS5owqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA5ICstDQo+ID4gPiDCoGZzL25mcy9wcm9jLmPCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMSArDQo+ID4gPiDCoGluY2x1ZGUvbGludXgvbmZz
NC5owqDCoMKgwqDCoCB8wqDCoCAxICsNCj4gPiA+IMKgaW5jbHVkZS9saW51eC9uZnNfZnMuaMKg
wqDCoCB8wqAgMTUgKysNCj4gPiA+IMKgaW5jbHVkZS9saW51eC9uZnNfZnNfc2IuaCB8wqDCoCAy
ICstDQo+ID4gPiDCoGluY2x1ZGUvbGludXgvbmZzX3hkci5owqDCoCB8wqAgODAgKysrKy0tDQo+
ID4gPiDCoGluY2x1ZGUvdWFwaS9saW51eC9uZnMuaMKgIHwgMTAxICsrKysrKysNCj4gPiA+IMKg
MTggZmlsZXMgY2hhbmdlZCwgMTM1NiBpbnNlcnRpb25zKCspLCA5NCBkZWxldGlvbnMoLSkNCj4g
PiA+IA0KPiA+ID4gLS0NCj4gPiA+IDIuMzMuMQ0KPiANCj4gLS0NCj4gVHJvbmQgTXlrbGVidXN0
DQo+IExpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCj4gdHJvbmQubXlr
bGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KPiANCj4gDQo+IExlZ2FsIERpc2NsYWltZXI6IFRoaXMg
ZS1tYWlsIGNvbW11bmljYXRpb24gKGFuZCBhbnkgYXR0YWNobWVudC9zKSBpcw0KPiBjb25maWRl
bnRpYWwgYW5kIGNvbnRhaW5zIHByb3ByaWV0YXJ5IGluZm9ybWF0aW9uLCBzb21lIG9yIGFsbCBv
Zg0KPiB3aGljaCBtYXkgYmUgbGVnYWxseSBwcml2aWxlZ2VkLiBJdCBpcyBpbnRlbmRlZCBzb2xl
bHkgZm9yIHRoZSB1c2Ugb2YNCj4gdGhlIGluZGl2aWR1YWwgb3IgZW50aXR5IHRvIHdoaWNoIGl0
IGlzIGFkZHJlc3NlZC4gQWNjZXNzIHRvIHRoaXMNCj4gZW1haWwgYnkgYW55b25lIGVsc2UgaXMg
dW5hdXRob3JpemVkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQNCj4gcmVjaXBpZW50LCBh
bnkgZGlzY2xvc3VyZSwgY29weWluZywgZGlzdHJpYnV0aW9uIG9yIGFueSBhY3Rpb24gdGFrZW4N
Cj4gb3Igb21pdHRlZCB0byBiZSB0YWtlbiBpbiByZWxpYW5jZSBvbiBpdCwgaXMgcHJvaGliaXRl
ZCBhbmQgbWF5IGJlDQo+IHVubGF3ZnVsLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KQ1RPLCBI
YW1tZXJzcGFjZSBJbmMNCjQ5ODQgRWwgQ2FtaW5vIFJlYWwsIFN1aXRlIDIwOA0KTG9zIEFsdG9z
LCBDQSA5NDAyMg0K4oCLDQp3d3cuaGFtbWVyLnNwYWNlDQoNCg==
