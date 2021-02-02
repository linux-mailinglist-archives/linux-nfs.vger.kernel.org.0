Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E2830CE57
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Feb 2021 23:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhBBWAb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Feb 2021 17:00:31 -0500
Received: from mail-mw2nam10on2102.outbound.protection.outlook.com ([40.107.94.102]:16262
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229542AbhBBWAa (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 2 Feb 2021 17:00:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbwiTV8XtrKIHZ5DYs5y5EBB1WCQ2EfXMIXMOQSR0AErH6JHco8nAG/sEpk303Pxyx4+EBB4epYbb87iEhdAvVKKTuNL5k8aiHZ/fay5KdBYmnTfM98rJsgZCAsx3Q9MU/zaDzfLdrtO1oVWAkOv1OI68DqTb5rrYKTtLMbWSYckthAD35kRFjZkwzfQqH+VFshdkgMUdB7dbBV6w4yiKywsL8osAGEFAOc1lFjmjTFNcHtZbt/lUJMM39q53vJ3XVBOEyRmt2kIfjvN3o6XoihHjUmcK7YbYgJSOkec11nEhjjtabkgxG/7XTfipDx3a94YoCwyZQH0EWD4sdayFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1K+P0XAPpql+lWgbZV0q12f/WqnH2IAC2G+ZLh/SEb8=;
 b=JR8EgK6yGPAtT58ITkyJmqSm1wBQq/jdVMlqFtfgDp3770RAXRqj498BoNOBkDUgMomEDSdr2DgX5MZXoNfW+SdAfJ+2vRxBmswOPHfX1sS4XHIqYp6gQtfEZNFf3WlmCd/mwm7hW5LFQIejZq6fMLBB4uGmyg8Yc5n3MtnHr6Uu3X6wiZOoVjN9lbeFdy+ivRY8bGRyiIR54qVugyOl+SrUq+QKM9RHU/juiVs9K2CpZFjRaFMsu698mCeOhlvRO4508gR1mRq83XaoTOLndVIYSLFP6bzLTRfQGpy7m1Uo71z1Z+nzGkjfigp0HB9AvUWonGEQe51SRbzCxc9ThA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1K+P0XAPpql+lWgbZV0q12f/WqnH2IAC2G+ZLh/SEb8=;
 b=boUaXo7XEykuabKMUXNXVye/QNVM/DVn+E7AMN2OPkfGLRY8DRK3DtBiiW/sbcJtz1wiOhJlTLnsFU3lIGDX2Wu6wteNAh2WFHk/Ges8JHkEbLJrQPny9zuNdTPH40sUUL7SmLU3Cz1nOfR+zZesd81+KFUkv/a8EgP7Nalbudk=
Received: from (2603:10b6:610:21::29) by
 CH2PR13MB3621.namprd13.prod.outlook.com (2603:10b6:610:99::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.8; Tue, 2 Feb 2021 21:59:36 +0000
Received: from CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063]) by CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063%3]) with mapi id 15.20.3825.019; Tue, 2 Feb 2021
 21:59:36 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "schumaker.anna@gmail.com" <schumaker.anna@gmail.com>
CC:     "Anna.Schumaker@Netapp.com" <Anna.Schumaker@Netapp.com>
Subject: Re: [PATCH v2 4/5] sunrpc: Prepare xs_connect() for taking NULL tasks
Thread-Topic: [PATCH v2 4/5] sunrpc: Prepare xs_connect() for taking NULL
 tasks
Thread-Index: AQHW+ZOhlmr2IFKn00WnCLsTmFyjBKpFZ12AgAAC3QA=
Date:   Tue, 2 Feb 2021 21:59:36 +0000
Message-ID: <67497ea4a7d22726112e0083893e85a17f1ca681.camel@hammerspace.com>
References: <20210202184244.288898-1-Anna.Schumaker@Netapp.com>
         <20210202184244.288898-5-Anna.Schumaker@Netapp.com>
         <4eaf0c288d97a2d03c5cd2a7ed728a73085b2719.camel@hammerspace.com>
In-Reply-To: <4eaf0c288d97a2d03c5cd2a7ed728a73085b2719.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77580bcb-a7cd-431c-72b6-08d8c7c5d48f
x-ms-traffictypediagnostic: CH2PR13MB3621:
x-microsoft-antispam-prvs: <CH2PR13MB36214314DDF7307E2A542D49B8B59@CH2PR13MB3621.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GWJ2XnNWn0DOXC/YjyaAi4ZSGYe9Y52SfaUMBYUPtI1oURw3UZu9AcFr75B5zirYJTPBZ0HjChPGKd+QsKq6oA8i2TstotziUHXCrwXeBR4GFsyDxs9VgKBD5qbyaJjWYR6NEkAFoDNi40J6Nvpg2pfU1U5G3k5yDASPNYPDuIzrYCT6NOlxN56537gm3w6otB++k/7rfaAEZNHF8PoESoNVDQHEL7wRZCDhyWigEI0W7oaFq8ibbZpLkissQv2GWMWaZtUb54GyrHqxfLrxD+M3RjXBu9lCWKVRXrbJ1nlASpDcjY8fr76lgIZe5Cby7zJraEFX5mai3v+yjJwoSmDwueswmidaml+a24NH8SH0NAVZ6T4q1ehHwN4dj2BBmyLHytmtDOwhm+6TpEwnEl7xKtXJZJjUgU1c/PhVfaeKqNmcpzoyrX57LMmpfX8y3WkmbHZgbNBvEHax6TnZS0j8FDjcIwaoOSe2jl2hKf7GKw+5umdODY7TrO0gSA6OeBcPmyaA2Ocm6+5XhOwmhw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3525.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(136003)(39840400004)(366004)(186003)(4326008)(71200400001)(6506007)(76116006)(6486002)(2906002)(2616005)(8676002)(36756003)(8936002)(26005)(66946007)(5660300002)(83380400001)(110136005)(86362001)(64756008)(66476007)(316002)(66556008)(66446008)(478600001)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Y3Nic2RMOTdCT1dab0VvQXRKejZMZGdseXVFY0dUTFdyRDJoQStnTWQwbEVT?=
 =?utf-8?B?T2xLSHFQdzRXMDlkUTllOUFwMGhseHRiQ1Zpak15ZFhJeENhUUtOcEpjVHhI?=
 =?utf-8?B?SktQSGRKWkY1cE9qbmgzblNtT25aNkxuNDE4QW9lNkpxOTJtbUFpMmY5OWdN?=
 =?utf-8?B?VHVIOVRQUnNJRXllT21uTWo5V1NpMWV2NktnQklFaGVqTmJaQUVWd2FUNW5u?=
 =?utf-8?B?QjFSZTBHQ1FFODl3YmdGVU40b2syWUc0WHFrc1JsTUVGUTdDS1MrSEtCV1Mw?=
 =?utf-8?B?USs2QzlXWDk2M3QyL25oYm9MME8zN1gybDdKbm14MVlSd0N1ZVZseVN4eG5G?=
 =?utf-8?B?dW5WVi94T2M0Ynd2Yk5jc1BpTUlTRDNLYlBReXkxeTZLYnQ1NGxhaVdmbUpQ?=
 =?utf-8?B?dURIVWFOdjBQYWprb2EvYXBEenFFZjdtcXFoY2RvWEFjbTZNMHdmZFd2ZTRW?=
 =?utf-8?B?S25oMUlWc0ZPVWl1akJwSWNRSno4ZC91YTc0cWRtY2h3SmN3STlwWHpmcEI1?=
 =?utf-8?B?WTg3aTNUNFE5QVpORmdIYTg5V3IxalIvMUF5cjdaZDhGUlBieEYyTUQ0NHE2?=
 =?utf-8?B?bS95akthMEkyM2hFMUJXUmZ4Mm8vY1BvSXRBQ3czWXRGeGJUaXQ2Z0M5Rzh4?=
 =?utf-8?B?dzhlOVN1eXlPQWxBUERXWmladnhwdmtRcTBRVktzSWszRFlOR21OTFNxMWhu?=
 =?utf-8?B?a3FINDRDQWxEWFNzUVVWMzNEcjRDMnJNYS9jYTZ2Z0JwSUcrNUhVNVBVUkM0?=
 =?utf-8?B?WlIzbE5QK3p4NVJZTEhLRGhBdFBudkViajdYc2ZSdmJ6ZkxlMHpRelV2b3JI?=
 =?utf-8?B?ekJVMHMyRUtQcnljVXNKb0NiL3daeU4yVmdNT0JQVDV2L2xGS2dJcnBpdHpW?=
 =?utf-8?B?S0ZSVFBvNEZyYkUzNnA4VnMwa2x2WEhESDJLcVdFd2ZmOVFkRjhIdUZEMXR6?=
 =?utf-8?B?dzl1NnArVWJmdkQwcnMrNlJERk9ENE91VndFcGpPQWJLUExzUVZkUVFGa0VC?=
 =?utf-8?B?ZkpiU2Q3eERONnlPUzdNYUs0dTFST1J0N1RUYzdwMWVld0swb1lQRGR6ZjNs?=
 =?utf-8?B?ZWtpdmNHWis1ZzJwWlREVytxSnlUU2JwajdTUENQMC94MkVhZkJCcHhyOXJp?=
 =?utf-8?B?ZERrUnREeHVMc29mNjhFQzRPYzFEK2VLTXhKL2NNT0dqZ2g5aUZnTFdUVmFB?=
 =?utf-8?B?SFVVV3pLa3oxeXVTeHpXalNEdTFHd3ViQUdjQXdPK1A0SkJFTDdQOW5JMTBy?=
 =?utf-8?B?RVoxWnNxOUduUWtZZVYxSXd0WUFsYS9DSmJTeTRveWIxY3ZhRU1RNkVRZ2l1?=
 =?utf-8?B?ZGZZMWl5RE5ZbFFBeXd0UWU0TGhqNFV3VktRYk1YTnBSKzIyamp0NEdhWTdF?=
 =?utf-8?B?YUFTT0svVzBIRnNpUWUySGpoaVgrRlA0RXdQTkN1aWppK1I5U1pkUEpUSnpT?=
 =?utf-8?B?cVJPRTFIcUlxUkluZUl6RXhXeUhWKzc4aUZaMnh3PT0=?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <00FFAF9957E786469112AA26D7676240@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3525.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77580bcb-a7cd-431c-72b6-08d8c7c5d48f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 21:59:36.0701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OahF/vI0IL6DIsx1ioTsF2TOXdiJnckeDecgkeq/pouMfFna5uAwp9LF60yQxU0pr0mETibR7SwiT0pQ/3JDgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3621
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIxLTAyLTAyIGF0IDE2OjQ5IC0wNTAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+IE9uIFR1ZSwgMjAyMS0wMi0wMiBhdCAxMzo0MiAtMDUwMCwgc2NodW1ha2VyLmFubmFAZ21h
aWwuY29twqB3cm90ZToNCj4gPiBGcm9tOiBBbm5hIFNjaHVtYWtlciA8QW5uYS5TY2h1bWFrZXJA
TmV0YXBwLmNvbT4NCj4gPiANCj4gPiBXZSB3b24ndCBoYXZlIGEgdGFzayBzdHJ1Y3R1cmUgd2hl
biB3ZSBnbyB0byBjaGFuZ2UgSVAgYWRkcmVzc2VzLA0KPiA+IHNvDQo+ID4gY2hlY2sgZm9yIG9u
ZSBiZWZvcmUgY2FsbGluZyB0aGUgV0FSTl9PTigpIHRvIGF2b2lkIGNyYXNoaW5nLg0KPiA+IA0K
PiA+IFNpZ25lZC1vZmYtYnk6IEFubmEgU2NodW1ha2VyIDxBbm5hLlNjaHVtYWtlckBOZXRhcHAu
Y29tPg0KPiA+IC0tLQ0KPiA+IMKgbmV0L3N1bnJwYy94cHJ0c29jay5jIHwgMyArKy0NCj4gPiDC
oDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4g
PiBkaWZmIC0tZ2l0IGEvbmV0L3N1bnJwYy94cHJ0c29jay5jIGIvbmV0L3N1bnJwYy94cHJ0c29j
ay5jDQo+ID4gaW5kZXggYzU2YTY2Y2RmNGFjLi4yNTBhYmYxYWEwMTggMTAwNjQ0DQo+ID4gLS0t
IGEvbmV0L3N1bnJwYy94cHJ0c29jay5jDQo+ID4gKysrIGIvbmV0L3N1bnJwYy94cHJ0c29jay5j
DQo+ID4gQEAgLTIzMTEsNyArMjMxMSw4IEBAIHN0YXRpYyB2b2lkIHhzX2Nvbm5lY3Qoc3RydWN0
IHJwY194cHJ0ICp4cHJ0LA0KPiA+IHN0cnVjdCBycGNfdGFzayAqdGFzaykNCj4gPiDCoMKgwqDC
oMKgwqDCoMKgc3RydWN0IHNvY2tfeHBydCAqdHJhbnNwb3J0ID0gY29udGFpbmVyX29mKHhwcnQs
IHN0cnVjdA0KPiA+IHNvY2tfeHBydCwgeHBydCk7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoHVuc2ln
bmVkIGxvbmcgZGVsYXkgPSAwOw0KPiA+IMKgDQo+ID4gLcKgwqDCoMKgwqDCoMKgV0FSTl9PTl9P
TkNFKCF4cHJ0X2xvY2tfY29ubmVjdCh4cHJ0LCB0YXNrLCB0cmFuc3BvcnQpKTsNCj4gPiArwqDC
oMKgwqDCoMKgwqBpZiAodGFzaykNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
V0FSTl9PTl9PTkNFKCF4cHJ0X2xvY2tfY29ubmVjdCh4cHJ0LCB0YXNrLA0KPiA+IHRyYW5zcG9y
dCkpOw0KPiANCj4gTml0OiBUaGF0J3MgdGhlIHNhbWUgYXMNCj4gwqDCoCBXQVJOX09OX09OQ0Uo
dGFzayAmJiAheHBydF9sb2NrX2Nvbm5lY3QoeHBydCwgdGFzaywgdHJhbnNwb3J0KSk7DQo+IA0K
PiA+IMKgDQo+ID4gwqDCoMKgwqDCoMKgwqDCoGlmICh0cmFuc3BvcnQtPnNvY2sgIT0gTlVMTCkg
ew0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZHByaW50aygiUlBDOsKgwqDC
oMKgwqDCoCB4c19jb25uZWN0IGRlbGF5ZWQgeHBydCAlcCBmb3INCj4gPiAlbHUgIg0KPiANCg0K
U28sIHRoZSBwcm9ibGVtIHdpdGggdGhpcyBwYXRjaCBpcyB0aGF0IHlvdSdyZSBkZWxpYmVyYXRl
bHkNCmNpcmN1bXZlbnRpbmcgdGhlIHByb2Nlc3Mgb2YgbG9ja2luZyB0aGUgc29ja2V0LiBUaGF0
J3Mgbm90IGdvaW5nIHRvDQp3b3JrLg0KV2hhdCB5b3UgY291bGQgZG8gaXMgZm9sbG93IHRoZSBl
eGFtcGxlIHNldCBieSB4cHJ0X2Rlc3Ryb3koKSBhbmQNCnhzX2VuYWJsZV9zd2FwKCksIHRvIGNh
bGwgd2FpdF9vbl9iaXRfbG9jaygpIHdoZW4gdGhlcmUgaXMgbm8gdGFzay4NClRoYXQgc2hvdWxk
IHdvcmssIGJ1dCB5b3UnZCBiZXR0ZXIgbWFrZSBzdXJlIHRoYXQgeW91ciBwcm9jZXNzIGhvbGRz
IGENCnJlZmVyZW5jZSB0byB0aGUgeHBydC0+a3JlZiBiZWZvcmUgZG9pbmcgdGhhdCwgb3IgZWxz
ZSB5b3UgY291bGQgZWFzaWx5DQplbmQgdXAgZGVhZGxvY2tpbmcgd2l0aCB4cHJ0X2Rlc3Ryb3ko
KS4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwg
SGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
