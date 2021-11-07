Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969B244710F
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Nov 2021 01:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbhKGATV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 6 Nov 2021 20:19:21 -0400
Received: from mail-mw2nam12on2124.outbound.protection.outlook.com ([40.107.244.124]:11777
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231869AbhKGATU (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 6 Nov 2021 20:19:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Elj73KoQr96LkTHx1UH9mf0U8pxxG0rZsrRhefoOVQXtX1q/gp9ZDfJ32306f/hvx9XcGYYzHP4IN+LyzIHQW7Y1JtDqA8SeykOViDuO19ZarH/4zvnVLf/bI7aFSsu8q8AkAuQjMi6VIFkIfWQSV3LN4sAOe98r81CymfxHka0Znfgkw7FClYnPZdhVXS/hBcuuOLGhb2OlnCCmbAFRrL0vbTB9g70Crd4tcUf2iCm9n2EcSA1NbLs26Tjif862ESkPcL1bc0Kk7+iP9Zq+CFP16WjX5FZW+M8fxdG2pmUyLJHqbmfeq4kj4NyuHbmKl+0NPHilzEk4oEYwZNu3ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6XYNlKhydw+izup6beJx7JgO1pToBsjZZ7m7pmQOrYI=;
 b=Eug1LMkC+XHIXgQwQGqbsawTdH8VTW7DJERiyTgKE+gin3uL9Cfd87Flot4UCUqO7X8EiMeV4gkUsgC2vGM5G/Hs4WlX8wjJaaaowBD/pIYm3kJiW0LxLDLXIThHvpBK3CXFSQbvQ+w/EwBIxm6ikdKIO331rRUmI1f6sasqecVXPxxRT6KoG6jVRolGbgtRfYvDFE0JRAu79Qb4r506NgFszWKfvaKwIidQ4iSiMQfI2Pb01jvHcJsugtMpuFAiPSqTyU/s03bax0E5p/5yFl7htrN16gF+t/ZtGRu5zyt89Ue1L2qDKqb0NXZJup+qqTv2gZBoExQH+drAVLP8Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XYNlKhydw+izup6beJx7JgO1pToBsjZZ7m7pmQOrYI=;
 b=DebFZsQVit2aTPuaJ8MZznV/2S6N3r4V4Dn4PaGMoB9rdbkjt4T6OqlY/GAXBhGKuH4lBpD5oZSbxFprLOhFPPldoZW50NqMTvTbUsHnHWMzpZhQgYv0FDvEfMjS1/9IGdHz00CJs34EMAEAjbfhHNRmWJghT58ifTKSaxGPTeo=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB4713.namprd13.prod.outlook.com (2603:10b6:610:c6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.6; Sun, 7 Nov
 2021 00:16:34 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::a921:472b:221c:11b8]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::a921:472b:221c:11b8%4]) with mapi id 15.20.4690.012; Sun, 7 Nov 2021
 00:16:34 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "rmacklem@uoguelph.ca" <rmacklem@uoguelph.ca>
Subject: Re: NFS client pNFS handling of NFS4ERR_NOSPC
Thread-Topic: NFS client pNFS handling of NFS4ERR_NOSPC
Thread-Index: AQHX02npTtMx6BHF6UKeTijQBaPp7Kv3MpsA
Date:   Sun, 7 Nov 2021 00:16:33 +0000
Message-ID: <02a742e36c985769c95244c1340f5fc0601fd415.camel@hammerspace.com>
References: <YQXPR0101MB09684E992DCE638E82493DA9DD8F9@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <YQXPR0101MB09684E992DCE638E82493DA9DD8F9@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ecfa119-511d-45d6-21e1-08d9a183db66
x-ms-traffictypediagnostic: CH0PR13MB4713:
x-microsoft-antispam-prvs: <CH0PR13MB4713687D928B0F7A7E551D84B8909@CH0PR13MB4713.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HSmB3vCwGKhNpnJx9oTPzvN3utUsmLq3+DoFrunhenFcyH99hLBYDMnVVS/AnrgOjM8M5YecCtLruFLXF+S50zmYoaLZmYPTdLkPl8D/mXcJOeMPUZus7/CQjFYDOxgsQ1oXP6Izou8kTStxhzFBiyIBZe7fRy+3gECit12CWttGMobXgyueQwN0feFi9j5wQ2Di0GGmYKGVv39/2PBP73Gxk3/75m5DsL2CC7L+m8Hz4akk1mMdCVoIGDp4LudJjl3qOjfUfS62/sVLj4Jq5pHDVyr9uQYTm9+vIoqgYoSgbr1cuaerSeif/c3aAIWbc7yiUmDb6kWu00BoWqIvAyzD9itb0W6p5RE8+H4dnoMqH59jolugvJ0mhRh8dcumJlhtOdxxBT6TNH7H1iPomqpRHz9w0MHylzxX3StrvJ3LvQHXqY4camhq7v8RX99YMcHGwZ96RXCw2gbAvFvRWggWtGRS94wo3WV4TBVZlEnDjikZK8+aJjN9r5t0dlprIgnCIZQJlAvPgUd94kRvILF0KUAdWL9gTrQTpIdRepYMeWixVsZvsdI0wRRzn2rtdn9ZNpN5hJvMEywxuiHLwkoCWUaCgNV1qdNkRStyIV69HiViYgO2BNq/aRrSkZMJcxjkQwpYbMCzuJp4N4ODu3Guyp8zghiD501uwtX0L1jWSXCM5xNa2MyTWkRjSWLHTXCnUrFkOPfj/yJ/FcmkQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39830400003)(396003)(346002)(376002)(38100700002)(508600001)(2906002)(122000001)(6506007)(2616005)(8936002)(71200400001)(86362001)(6486002)(66476007)(8676002)(64756008)(36756003)(26005)(66446008)(66556008)(6512007)(186003)(38070700005)(66946007)(110136005)(5660300002)(76116006)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFpzdHRGUWh6VlZIVCtFOHVNeVBOa0dhSFBFa0VONVU0WG5vYXVCU1Brc0F0?=
 =?utf-8?B?emFvQzdMUHV6UjJVbTRoYkl3WldjY3ZxZlNGblQrWmIrSUVGV0hpRHlPRjB6?=
 =?utf-8?B?TnQ0RlpOYmU5TlJXNmlyU0lmU3h0Rm9KTGpSSTBteVN5K243RFZsdHBFUVd0?=
 =?utf-8?B?NGNsTngyY2g5T3VZVXhMdk5kVkkwOXhCTWxFR3JuaU5BWGtyQ0ppdlRGbmht?=
 =?utf-8?B?UzFITU9XTjdUclltdGNhWnFXeDMxSU9vM0pELzlIc0JiOGsxcjFlZUw0djdG?=
 =?utf-8?B?MlBnZStnbTJqZERudURrVmQ3RzcvcWg3b05hdTYybitMdWFIQW5XUldWUUtG?=
 =?utf-8?B?YzlLeHBRUmRZVy84TFVYdStxVU9PSCtVUkZrMjFISGtISktEMTJYdjZFWmhj?=
 =?utf-8?B?UlV1SElYQlhFTG5XeTVCZEwzWm8rQzJEOUJ5VHdsc3RkSVRjOUd0cjN2SGE2?=
 =?utf-8?B?S0JOQ3k0czArNmpTbTNpNVpOVFZ4eXVwcnI4Z3I4YWVxS2txVDV3RktxRFhn?=
 =?utf-8?B?YkF0QWNydlFhSmxvTXRKSW1iTDNSdW1WN2FVVnh1YjdHOWxXUGIxMFJRUHY3?=
 =?utf-8?B?OEh1NjZnTFdmdWFxMS9lRmkydXBrQUZOMkZTYThTNmcyUCtVejF5ckk2ak4z?=
 =?utf-8?B?b0xDaVlwUmxlbVV2WFMrWUlXR1Q2KzVRLzM2Ump0ejVyVXZZdENZejNXQ1dJ?=
 =?utf-8?B?OFdka1laS05yTXJUYlByRHN0S09tTU5ubkNKRXRnVTFFTG5wTUQrQklLWHd0?=
 =?utf-8?B?OURINFVEZmRYclJaVTBiazdkRnlvZXhVZU9FMWZKUU5qOEpSOGpFV2krTlda?=
 =?utf-8?B?dW9NOWM1Y2VRd0hSelhncXJWQ2tRVXFyaU5uT3Z6WTZTUFQ3UUFmQkFYNGZ3?=
 =?utf-8?B?VllPVVlqYlVxcCtodHlIOW9EalJsNDhMSGFnbUpuVkFrS0VtYUpkdzBzd2xi?=
 =?utf-8?B?SWw2T2NyN3JUbjdpTTN5a3lLM00wczhjbm1EUFc4bEg4a21BdGQ3aE5sL2tE?=
 =?utf-8?B?M08relF5TEJ3cWhPdzgvZC9EZ1lrZkVaZU1pMGRsckJUQzFZQWU5bzFmbUJ4?=
 =?utf-8?B?cXYvdDYyMkVzekJZd1oxdmNQVDhtVnJKUDBOaFBYUnAwTVoyWEsrUkpMR2RX?=
 =?utf-8?B?bExRMWNDbXZJejh4S2NvQk9QV2tIcjJQOTFaSTNVL2hRTCtnbmlqTGkwdkkx?=
 =?utf-8?B?ZVBIeUFzOVlPTUFpUHNtclNkTXEyQ2F2ODdPUlkwWStNSUpJMXUrdWIxNmFr?=
 =?utf-8?B?cDVXLzB5VWhDWFpueFlCVzNxT3FYNWtkUTZZOGV1anRLbWZSR3ZqMWVKcFNF?=
 =?utf-8?B?d1NiNERkakFrNDF6UTJUYnhBZCtvWi9XMTJGTWdzS3RoZ3NyWW40SEkzTUZM?=
 =?utf-8?B?eXdhNU84T3ZHdm56SitwSENWUWpDS1l6SFNpVlBXNFJ3WDQvT2pzeGQ4NHBX?=
 =?utf-8?B?TnVaSHltTE9pUjZmRm56ampqRGRkNlkyZ09xKzRldHpjczNERVQyWkNIK1Rm?=
 =?utf-8?B?QklYU05FT1FDZ283cHhFTzc3ZFd2OWdKQ2tPdENOMkpFanVKeFJ4UjFSTGQv?=
 =?utf-8?B?S3h0MHltNmdncEJhLzJTb3h5ZDRnWUZIeWxvTkJQNS9uS0tEcTV0NzdGSnRX?=
 =?utf-8?B?TENrcWhDWHdCc0FwYmZNR0dUNWJVYjA1OUVVcEI4YUFSc0hUVkN3elZuWUdk?=
 =?utf-8?B?UE9jbVNZMVc4eEsvVE8vQWQyNTZPenRTM0dKZGU4ZzZiQmIxczZrWEhJYlNF?=
 =?utf-8?B?Q2s1VDVZQ2xWa0JzVTZJa2VBZEtFQUdSajNtNXU3eFRqcDkzeVFEa1NaZHF2?=
 =?utf-8?B?OEYxL2s2TjQraWxsVnZHZkRFNGYzRzd4andpcGpoZGU3MmlSdmJzb1pwNmRJ?=
 =?utf-8?B?K0hESlQ4WnFkeUFzWFljTDcvY0Q3SDVLN1kwTG1jdTdqT05TalRLdDdCOEI5?=
 =?utf-8?B?dFJQRVRSVi8wVVh1ZEoycnA3QVZXRXc2ZnI5bWxwaWpLVkQ1dXRDNC82SlFN?=
 =?utf-8?B?Zm43ZFJVdnNjcFNJcTN0ZzR1cVVibFMzbWtzKytyTURVamZWQ25UaXBiWEMx?=
 =?utf-8?B?T00xZVBFVDNzajcxOTh5MjlQVTUwTld5bGpXUGZEdFpaWGdYZGFjNktNN0Fo?=
 =?utf-8?B?NjhabW9hZ2ZxSURXRCtqYzlrWHVxUTE2UmZGSU9QMUpFYUgydmkxWExtcEhV?=
 =?utf-8?Q?vBBtzuFyb0b/1/UBnsM+vLw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A642C71A7C07E847A5A854A43E540299@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ecfa119-511d-45d6-21e1-08d9a183db66
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2021 00:16:33.8329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: taF2WALk2PSj2Gq7cpJmH+2xGsAitGVU4lEgk4HPIcEBWQxMfZh6y1XfbAcU7SWhkyhxBlxJXr97/afJAGdhaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4713
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU3VuLCAyMDIxLTExLTA3IGF0IDAwOjAzICswMDAwLCBSaWNrIE1hY2tsZW0gd3JvdGU6DQo+
IEhpLA0KPiANCj4gSSByYW4gYSBzaW1wbGUgdGVzdCB1c2luZyBhIExpbnV4IDUuMTIgY2xpZW50
IE5GU3Y0LjIgbW91bnQNCj4gYWdhaW5zdCBhIEZyZWVCU0QgcE5GUyBzZXJ2ZXIsIHdoZXJlIHRo
ZSBEUyBpcyBvdXQgb2Ygc3BhY2UNCj4gKGludGVudGlvbmFsbHksIGJ5IGNyZWF0aW5nIGEgbGFy
Z2UgZmlsZSBvbiBpdCkuDQo+IA0KPiBJIHRyaWVkIHRvIHdyaXRlIGEgZmlsZSBvbiB0aGUgTGlu
dXggTkZTIGNsaWVudCBtb3VudCBhbmQgdGhlDQo+IG1vdW50IHBvaW50IGdldHMgInN0dWNrIiAo
d2lsbCBub3QgPGN0cmw+QyBub3IgInVtb3VudCAtZiIpLg0KPiAtLT4gVGhlIGNsaWVudCBpcyBh
dHRlbXB0aW5nIHdyaXRlcyBhZ2FpbnN0IHRoZSBEUyByZXBlYXRlZGx5LA0KPiDCoMKgwqDCoMKg
wqAgd2l0aCB0aGUgRFMgcmVwbHlpbmcgTkZTNEVSUl9OT1NQQy4gKFNhbWUgYnl0ZSBvZmZzZXRz
LA0KPiDCoMKgwqDCoMKgwqAgb3ZlciBhbmQgb3ZlciBhbmQgb3ZlciBhZ2Fpbi4pDQo+IC0tPiBU
aGUgY2xpZW50IGlzIHJlcGVhdGVkbHkgc2VuZGluZyBSUENzIHdpdGggTGF5b3V0RXJyb3IgaW4N
Cj4gwqDCoMKgwqDCoMKgIHRoZW0gdG8gdGhlIE1EUywgcmVwb3J0aW5nIHRoZSBORlM0RVJSX05P
U1BDLg0KPiANCj4gSSdsbCBsZWF2ZSBpdCB1cCB0byBvdGhlcnMsIGJ1dCBmYWlsaW5nIHRoZSBw
cm9ncmFtIHRyeWluZyB0bw0KPiB3cml0ZSB0aGUgZmlsZSB3aXRoIEVOT1NQQyB3b3VsZCBzZWVt
IHByZWZlcmFibGUgdG8gdGhlDQo+ICJzdHVjayIgbW91bnQ/DQo+IC0tPiBSZW1vdmluZyB0aGUg
bGFyZ2UgZmlsZSBmcm9tIHRoZSBEUyBzbyB0aGF0IHRoZSBXcml0ZXMNCj4gwqDCoMKgwqDCoCBj
YW4gc3VjY2VlZCBkb2VzIGNhdXNlIHRoZSBjbGllbnQgdG8gcmVjb3Zlci4NCj4gDQoNClRoZSBj
bGllbnQgZXhwZWN0YXRpb24gaXMgdGhhdCB0aGUgTURTIHdpbGwgZWl0aGVyIHJlbWVkeSB0aGUN
CnNpdHVhdGlvbiwgb3IgaXQgd2lsbCByZXR1cm4gYW4gYXBwcm9wcmlhdGUgYXBwbGljYXRpb24t
bGV2ZWwgZXJyb3IgdG8NCnRoZSBMQVlPVVRHRVQuDQoNCldoYXQgd2UgZG8gbm90IGV4cGVjdCBp
cyBmb3IgdGhlIGNsaWVudCB0byBoYXZlIHRvIGhhbmRsZSBEUyBsZXZlbA0KZXJyb3JzLg0KDQot
LSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJz
cGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
