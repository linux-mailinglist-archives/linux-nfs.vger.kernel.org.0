Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F94D3508CA
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Mar 2021 23:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhCaVIQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Mar 2021 17:08:16 -0400
Received: from mail-eopbgr690105.outbound.protection.outlook.com ([40.107.69.105]:64078
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229662AbhCaVHu (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 31 Mar 2021 17:07:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7dPe5jqoROpmcRi7O46DgTkBxbkqZVLLzFxjuoZR2FIOpHI8dWFYnRQ6eQzMpVfSqMYOolDnZuuzOHjUOBj0DAgRrmbFRTX0x9a+ORUMsMKuu92KplNPDTywMiCuCf8gsXkYM+ARgt3WxXsFMx8+zfOn4NvCVCgW5MMCIbRSC7UVfnFSJVyJySvQlgpzVIXhTrdqWW1QlOGk/Fhq2izgS9433KmMwlLHTueNQ+j+eG8gI2+R/KgvXCwGOXw8wbIh0xak5G8KlVvGE8wkg0tm9g8rKGED8R6Aek5g1RzEphizRBA4uGJOcwtFZQ9KHHZWVWVAWbAYOiTfK2X8q/VKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLKp3JX+XlJtYF7W2n4xCp1peesSlxpPooQ7hwwriKI=;
 b=A6/+l2iuUTnLOx/44WYCLY1KmXS+BR2JoqUlPXNG2WZKhJEH3yZPsCS2AJ99rntnEYZnlLGY77CAGw96GYoQ8u8MGVgZN0Lwk/xeobyQ8ZyW8dKXuTcg926XPzeT+l+SjNGxMRNZbHCVtNQjakWXm0NhJsFAN9AFF/WmptpaYP97Z/TWKVPoON2xLvVlTlRcTEu2qBH4cS5ANGnYE5DNNDUh7qLOe6g9hF5g+whxjgT5EseNVM22puh4UySyJsHuS972hjw0XEFDQFp7bSoV+HRuSUr/FaODiJ5ZvDNK4NGrW3YXSidjy2U4s2Fp3SipqN+uFwLFj1mBy6xePS/FLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLKp3JX+XlJtYF7W2n4xCp1peesSlxpPooQ7hwwriKI=;
 b=Uw0L8asLi64TwwTmOL6r8oNX0fjTF7hq/kDBBa+iTWFV/erfiRluV2Jmjr+6qwU3/h/bhua0mJG6mYb7Ipvsk4kv3hCdPme9jcV3QUaHO+HMJkmOYMoRSwXybDra58vdowgEEb+oNPbXidTGSd/fSKoSxkfAQ0PiKY6ViCmlALk=
Received: from CH2PR13MB3525.namprd13.prod.outlook.com (2603:10b6:610:21::29)
 by CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.15; Wed, 31 Mar
 2021 21:07:46 +0000
Received: from CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::69bf:b8e4:7fa0:ae74]) by CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::69bf:b8e4:7fa0:ae74%7]) with mapi id 15.20.3999.027; Wed, 31 Mar 2021
 21:07:46 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH 1/1] NFSv4.2 fix handling of sr_eof in SEEK's reply
Thread-Topic: [PATCH 1/1] NFSv4.2 fix handling of sr_eof in SEEK's reply
Thread-Index: AQHXJmRPskF9kJm73U6OPU3MAvy7UaqefzwAgAAOmYCAAAksgA==
Date:   Wed, 31 Mar 2021 21:07:46 +0000
Message-ID: <93c81355cfe7df2d0f42fae52a84c869a4298cef.camel@hammerspace.com>
References: <20210331193025.25724-1-olga.kornievskaia@gmail.com>
         <0ca40f087491acec8f26816b43b6d64bb624c35e.camel@hammerspace.com>
         <CAN-5tyHQyHO8K7UjwhKhN9Xoz1nSXMB2cv8De=w9Rx-qphaHgg@mail.gmail.com>
In-Reply-To: <CAN-5tyHQyHO8K7UjwhKhN9Xoz1nSXMB2cv8De=w9Rx-qphaHgg@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 664fab44-11a8-4b3b-42d8-08d8f4890891
x-ms-traffictypediagnostic: CH2PR13MB3398:
x-microsoft-antispam-prvs: <CH2PR13MB3398727C16919343D49A00DCB87C9@CH2PR13MB3398.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gHWN9TS3X28LipOaBM8rL/hOIaoWgRK0nc9U9PI6AIAWryl1szDe6SmsKRFBHA4UCnqau5PfWB2iat6C74dNlLb/feMjPDtw5KmpoAr6FvkzcSy6LXAn6gKRYlygnFP9zVl7szXVIYlKXv/8JPdE1Im9YDG9+wPkvAIafE7aq5oem+orV9lVPCG6xUKHtheNEg103nbvL/mVNcs9u0w4RJxP6ZJK2knXS2J1CHnhcy12slz2P2fCRqUvrTIaMoveKkO30N3608Y7MHwwQG7038X65MxWK33+EyCupi2qy5ch6DXyhzsjmUzwj1FCzkMQ54f0IUQR+fBGKOsRJOF0qk20qfCNetKVJ+kETUIF6DkeGVehEfNP0Y3qYaFVcijZv+sAS6gg57V07E5dOt5oj8VtR2wWmHL1kJ7JvpBVmY6CRUGVeLR7MJYssQ7WBldUpTV9/PTOaMZ2KT3/+hsthU6ojb4GZzXHwHCKL2lu6VW5wCseqXmFMUD7dp2micS53upl4tnjFO5+LbCqXWcSejZGZam0sFiyvs+/KYm/CFYG2Vg7vqNVku5BXxME4R8mBtcb6xf1ToNBxS1rYAMBWfWf8L4/K3U9HjdXp3n89K6pPj+0zKjtht3SEL9oyjw1oSsbylFQxuvjP0ifF+yyR/quGSAaJS2xQ/4PwPWtG2Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3525.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(366004)(396003)(346002)(376002)(136003)(478600001)(6486002)(8676002)(5660300002)(8936002)(316002)(2906002)(66556008)(66476007)(6512007)(64756008)(66446008)(66946007)(86362001)(76116006)(83380400001)(4326008)(186003)(2616005)(6506007)(6916009)(53546011)(36756003)(38100700001)(26005)(54906003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?eDBDZDBjcWx4aWdkVWhZem1mTzZ5dkUvMEQ3TUdyRG53bCt3d0NjaEYvaUd2?=
 =?utf-8?B?TzJIbEpsbGFwSkRyTSsvZ2RMZWs4cHMyTmwvbEloaVQydnZLa0dBZUJNOWFE?=
 =?utf-8?B?bzVaWVFvR2dZQnpETjJmeWwwb21OODBBOVdyUTE3cXFxT1NpL2NiV3BRdWtQ?=
 =?utf-8?B?anFXMWZSdCtpcTBYblUrUEdIZ0g1TENoVEtCcG5zNDdhRHpDZnBtMmhuOCtj?=
 =?utf-8?B?VU9UVjN4RkhGK3NYN2tlcitkWVFMSTlNNG1mMklFQ3B6NXFZd2o1bm5SYjlL?=
 =?utf-8?B?Mm1uVWZLeGdMeXlsZ1V5Y29CRm9pZmVHdjBIRUZmRjBERFVCR2dtNWpIdkZv?=
 =?utf-8?B?S2x0S2lpOUpDSkU2VlpPM21YUWlmcXJpT1ZhMTBUK2dsTUQva01XUG9sVysr?=
 =?utf-8?B?N1E3VHlodTViS2htbzBUYmNob3FFSm05TVhUb2dDTXg3dldWTSsrQjNPZmkv?=
 =?utf-8?B?UTVGVjhrSCtnWGhLNmY5MEJkMEZmUS9vSEVGY2E1SEt1MXR6eDlPYUZjYUpC?=
 =?utf-8?B?RTlqS0xtUkk4b0V3TG5jNTlLQ3g3Z0FucU9WMXlVS0hqVlZsaHFNYmN1b3JO?=
 =?utf-8?B?UzRPU2lJbisxekwyM0JTOGRXcnlrYUZoMlNEby9WUGVZeHpsbVhKZXVCQUJw?=
 =?utf-8?B?TUhudU94VHhEU0ZnRkFXVDdjL0Nra1FhODRJU3U3blEyYXNKMWdhYWduZmhp?=
 =?utf-8?B?VnUzUnNEQnAxdDR5a3F0R21hTUlMWkN3N08xQW1IWGVvYUd2MzRHK2YrYTd6?=
 =?utf-8?B?Nk5GOHd4MEJIc1FQL0pzSDZ5VXJlN05paGZkbFhsTjZtZExYTzVVdDZKd1VH?=
 =?utf-8?B?dnFyTEZ6WjhmM1BILzBLTm9DbVFwcnZWU25iS0JHN0VPV2k1V2lhMnZCWGox?=
 =?utf-8?B?dzZDMjI4TDVoOVkzRGVGOTdMc0d1K3FFdWJ4NnNKZm9ZWVNtTWZSbEpQbTN6?=
 =?utf-8?B?UTlaMy9jbjFjNXJ1YnZBbFNPTjZEQnJWTS81OXRXcWlQZ1dacXQ1Y1JTcDV1?=
 =?utf-8?B?QU96elpRUEw4TlQ1dytHYjlmNVF0UjJZYjFsV0RmeGJHQ0FGNXlCMmFoZmpV?=
 =?utf-8?B?eCtWdVdGY3Eyc2tYVEllVUYrMytnelRoUVlXZEVnSE1TT1p3NUxZNkJGZkV0?=
 =?utf-8?B?dUppS2x5aWUvYmwrYWpFR0ZWZHNkZ01TeVgvTDFYamtTN1AxNWN1YVMvbUd0?=
 =?utf-8?B?VnlSeDhuODJvWXgxcU1aRzB4ZVBSN3N3aUpDOEN0U3liL0FHQmE5cElVY1dw?=
 =?utf-8?B?V3NjRWhkRENDTWQ1UXNSVFdLTTFUbGwycTRObkp5b1VFSCtLNU5MU01tbnkx?=
 =?utf-8?B?aUQvK1hQdVRyQTlUZy9FNU0yRURUOWVUTUljb0hLdWNscTlRS2dsdjRjQ0hk?=
 =?utf-8?B?dkE3cFRVZmhWYmlqMW1zYUdSS3N4dGFaUVAvSkx4Sk9WbTZnU2lGN2drL2dX?=
 =?utf-8?B?TElBNVYwTWRmb1dzYWMyRkR5ZzA5SXpzK0RmT3N1cnRmQUNuY29jeSthWTFQ?=
 =?utf-8?B?Zy9kQ0FCU0VyUTRldGh0TFgrTUtPM29hTUd6R2MrV1pQQTZ6eDc1YldVNkVP?=
 =?utf-8?B?RDhodXRtRGIwcFZRUlloZzEvaUdoeE9Xb1BzbVRWUjhYT3E4a0FwZG5YMEtT?=
 =?utf-8?B?T3pPK1dqVlRCS1l2NzdkQ3g2NW83OGZpb29yOFpIVnFrbTdkNFNKeDM3RTIr?=
 =?utf-8?B?QXVQR2x6dUtvVXJnQUhpZStFYmpOTU5BdHdDWTVXQmlac0dZN3Y1YmUvTTBU?=
 =?utf-8?Q?lkMIG6OmlYILzeJbpHlqFOUJf8CIyB4jtXFnquf?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <89AD63C32B399D4E84D0E9F35B94E41F@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3525.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 664fab44-11a8-4b3b-42d8-08d8f4890891
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 21:07:46.2790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xRxV6hZq58GpaOpzjYHrs5s/oLKP0i3//PY5ES3ts1ZZ2U1oGoP4hGrwTx/H7yxWgUGJ8LtsSen0eR64Jbx13w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3398
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIxLTAzLTMxIGF0IDE2OjM0IC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gT24gV2VkLCBNYXIgMzEsIDIwMjEgYXQgMzo0MiBQTSBUcm9uZCBNeWtsZWJ1c3QNCj4g
PHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBXZWQsIDIwMjEt
MDMtMzEgYXQgMTU6MzAgLTA0MDAsIE9sZ2EgS29ybmlldnNrYWlhIHdyb3RlOg0KPiA+ID4gRnJv
bTogT2xnYSBLb3JuaWV2c2thaWEgPGtvbGdhQG5ldGFwcC5jb20+DQo+ID4gPiANCj4gPiA+IEN1
cnJlbnRseSB0aGUgY2xpZW50IGlnbm9yZXMgdGhlIHZhbHVlIG9mIHRoZSBzcl9lb2Ygb2YgdGhl
IFNFRUsNCj4gPiA+IG9wZXJhdGlvbi4gQWNjb3JkaW5nIHRvIHRoZSBzcGVjLCBpZiB0aGUgc2Vy
dmVyIGRpZG4ndCBmaW5kIHRoZQ0KPiA+ID4gcmVxdWVzdGVkIGV4dGVudCBhbmQgcmVhY2hlZCB0
aGUgZW5kIG9mIHRoZSBmaWxlLCB0aGUgc2VydmVyDQo+ID4gPiB3b3VsZCByZXR1cm4gc3JfZW9m
PXRydWUuIEluIGNhc2UgdGhlIHJlcXVlc3QgZm9yIERBVEEgYW5kIG5vDQo+ID4gPiBkYXRhIHdh
cyBmb3VuZCAoaWUgaW4gdGhlIG1pZGRsZSBvZiB0aGUgaG9sZSksIHRoZW4gdGhlIGxzZWVrDQo+
ID4gPiBleHBlY3RzIHRoYXQgRU5YSU8gd291bGQgYmUgcmV0dXJuZWQuDQo+ID4gPiANCj4gPiA+
IEZpeGVzOiAxYzZkY2JlNWNlZmY4ICgiTkZTOiBJbXBsZW1lbnQgU0VFSyIpDQo+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBPbGdhIEtvcm5pZXZza2FpYSA8a29sZ2FAbmV0YXBwLmNvbT4NCj4gPiA+IC0t
LQ0KPiA+ID4gwqBmcy9uZnMvbmZzNDJwcm9jLmMgfCA1ICsrKystDQo+ID4gPiDCoDEgZmlsZSBj
aGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+IA0KPiA+ID4gZGlm
ZiAtLWdpdCBhL2ZzL25mcy9uZnM0MnByb2MuYyBiL2ZzL25mcy9uZnM0MnByb2MuYw0KPiA+ID4g
aW5kZXggMDk0MDI0YjBhY2ExLi5kMzU5ZTcxMmMxMWQgMTAwNjQ0DQo+ID4gPiAtLS0gYS9mcy9u
ZnMvbmZzNDJwcm9jLmMNCj4gPiA+ICsrKyBiL2ZzL25mcy9uZnM0MnByb2MuYw0KPiA+ID4gQEAg
LTY1OSw3ICs2NTksMTAgQEAgc3RhdGljIGxvZmZfdCBfbmZzNDJfcHJvY19sbHNlZWsoc3RydWN0
IGZpbGUNCj4gPiA+ICpmaWxlcCwNCj4gPiA+IMKgwqDCoMKgwqDCoMKgIGlmIChzdGF0dXMpDQo+
ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHN0YXR1czsNCj4gPiA+
IA0KPiA+ID4gLcKgwqDCoMKgwqDCoCByZXR1cm4gdmZzX3NldHBvcyhmaWxlcCwgcmVzLnNyX29m
ZnNldCwgaW5vZGUtPmlfc2ItDQo+ID4gPiA+IHNfbWF4Ynl0ZXMpOw0KPiA+ID4gK8KgwqDCoMKg
wqDCoCBpZiAod2hlbmNlID09IFNFRUtfREFUQSAmJiByZXMuc3JfZW9mKQ0KPiA+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1ORlM0RVJSX05YSU87DQo+ID4gPiArwqDC
oMKgwqDCoMKgIGVsc2UNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVy
biB2ZnNfc2V0cG9zKGZpbGVwLCByZXMuc3Jfb2Zmc2V0LCBpbm9kZS0NCj4gPiA+ID5pX3NiLQ0K
PiA+ID4gPiBzX21heGJ5dGVzKTsNCj4gPiA+IMKgfQ0KPiA+ID4gDQo+ID4gPiDCoGxvZmZfdCBu
ZnM0Ml9wcm9jX2xsc2VlayhzdHJ1Y3QgZmlsZSAqZmlsZXAsIGxvZmZfdCBvZmZzZXQsIGludA0K
PiA+ID4gd2hlbmNlKQ0KPiA+IA0KPiA+IERvbid0IHdlIGFsc28gbmVlZCB0byBkZWFsIHdpdGgg
U0VFS19IT0xFIHdpdGggdGhlIG9mZnNldCBiZWluZw0KPiA+IGdyZWF0ZXINCj4gPiB0aGFuIHRo
ZSBlbmQtb2YtZmlsZSBpbiB0aGUgc2FtZSB3YXk/DQo+IA0KPiBXZSBkbyBub3QgYmVjYXVzZSBp
ZiB0aGVyZSBpcyBubyBob2xlIGV4dGVudCBhZnRlciB0aGUgcmVxdWVzdGVkDQo+IG9mZnNldCwg
dGhlbiB0aGVyZSBpcyBhbiBpbXBsaWVkIGhvbGUgd2hpY2ggaXMgYXQgdGhlIGVuZCBvZiB0aGUg
ZmlsZS4NCj4gU28gaWYgc3JfZW9mIGlzIHRydWUgd2Ugc3RpbGwgbmVlZCB0byBwYXkgYXR0ZW50
aW9uIHRvIHRoZSByZXR1cm5lZA0KPiBvZmZzZXQgKGllIGl0IHNob3VsZCBiZSBlbmQgb2YgdGhl
IGZpbGUpIGFuZCBpdCdzIG5vdCBhbiBlcnJvcg0KPiBjb25kaXRpb24uDQoNCkknbSBhc2tpbmcg
YmVjYXVzZSBhY2NvcmRpbmcgdG8gdGhlIG1hbnBhZ2UgZm9yIGxzZWVrKCk6DQoNCiAgICAgICBF
TlhJTyAgd2hlbmNlIGlzIFNFRUtfREFUQSBvciBTRUVLX0hPTEUsIGFuZCBvZmZzZXQgaXMgYmV5
b25kICB0aGUgIGVuZA0KICAgICAgICAgICAgICBvZiAgdGhlIGZpbGUsIG9yIHdoZW5jZSBpcyBT
RUVLX0RBVEEgYW5kIG9mZnNldCBpcyB3aXRoaW4gYSBob2xlDQogICAgICAgICAgICAgIGF0IHRo
ZSBlbmQgb2YgdGhlIGZpbGUuDQoNCmkuZS4gdGhlIG1hbnBhZ2UgaW1wbGllcyB0aGF0IHdlIHNo
b3VsZCBhbHNvIGJlIHJldHVybmluZyBhbiBlcnJvciBmb3INClNFRUtfSE9MRSBpZiB0aGUgc3Vw
cGxpZWQgb2Zmc2V0IGlzIGJleW9uZCBlb2YuIEFyZSB5b3Ugc2F5aW5nIHRoYXQgd2UNCmN1cnJl
bnRseSBkbyBzbz8NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFp
bnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0K
DQo=
