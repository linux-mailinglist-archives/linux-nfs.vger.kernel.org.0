Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89AB413A71
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Sep 2021 21:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbhIUTBu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Sep 2021 15:01:50 -0400
Received: from mail-bn8nam11on2117.outbound.protection.outlook.com ([40.107.236.117]:37857
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232481AbhIUTBu (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 21 Sep 2021 15:01:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pw0s7XKIVf0OjXqBfg74kWbBPz/7Y1RkLVCESUThMVhESqhnpu/o5j+SuNKsqRw8xdnYwpRzgIOsMgN+OGB6pIL/4hYpW2G4XUmn+Xm/Tq77ViVOd0lI5UjBAnicBklZ/VkP9tyzgQYTLEKoHvfHstNaCzmYEyZpRzjk5gNxONg1or+TY9GXUGbxR04jwGPQ12IjF4YcjzPn9K/2LJdVSkuBePWMD/+3U84sBK0oGUIdaUCmRODgFJRC8oeBxmoW3fjqUF0S1ElkqaTSWr1pmASO9kLAH6wyGFGrriLM0NpfjxsK1VX6bxi7VAkMHJtcUmwjsEyAi4qR/s15nn9uhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=GOwTDg5DgWMDFQDoWKCH1nm7a0STCqWaX67gGgkOt18=;
 b=OB1W6DFb3tJoXZlDofJJrnZyGB7BgPJvWD360j85Ajy4b8xLnSktIzzNKchQRYkmeIzd90OW7Sf95IdkZBuPmU8Hxpi9GWHZIs3T4/Be2s07pQJNgmOxz16hPhi0zN+pW7KM7uvi3jQ+06AOKXWieQ1LQb2NCF8ROXz1e1gjCBdVa02PHNv0rYLwfFEWG/QNUzK8/GsMWqWZ4GX9bgVHATysgm2kvP30Q8x9FSsNKcYhWrzrXJu3rM2YhfNV5qqEvrZRfUMNe6Mk8mSbxefyP3BN09Rgs8spJIH+xmeA7uSYrMyEPDwVw7tP5cnzO+wYMBBoVSPLo9cuC8VnuCar6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOwTDg5DgWMDFQDoWKCH1nm7a0STCqWaX67gGgkOt18=;
 b=Mp/VBI/JJrPfgGEA1Wn6rWh2uVx3a12ix4Qz1beEuXLOYncm6lU+YKR++KwHohHCmrwAaCFexBRiRMroTGtwWGVX2eXv23qPiaWonkKgCpoWHIqSg5kFcpXQRE5/0zrwkgOd0+uYShCOeZTh0WQW5MatG9FVWBSZXHIUUX0sJXE=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB4649.namprd13.prod.outlook.com (2603:10b6:610:cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.5; Tue, 21 Sep
 2021 19:00:19 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2%8]) with mapi id 15.20.4544.013; Tue, 21 Sep 2021
 19:00:19 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: recent intermittent fsx-related failures
Thread-Topic: recent intermittent fsx-related failures
Thread-Index: AQHXf/8fcA3+DfY3OUmOk0QnMZuIQ6tRAXuAgFtTrwCAAuCsgA==
Date:   Tue, 21 Sep 2021 19:00:19 +0000
Message-ID: <da6ef7efef96f126f89a70446eaf643ab0bcbe26.camel@hammerspace.com>
References: <67E1CF9F-61C5-4BB9-97FE-61B598EFC382@oracle.com>
         <2e8bce7bc15b02bbd1dcf740f2d993d6e3d58367.camel@hammerspace.com>
         <680A4FB2-B90D-47E1-A390-36B3081B1464@oracle.com>
In-Reply-To: <680A4FB2-B90D-47E1-A390-36B3081B1464@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 91784976-d4b1-48cd-f0c7-08d97d320e87
x-ms-traffictypediagnostic: CH0PR13MB4649:
x-microsoft-antispam-prvs: <CH0PR13MB4649DD304F95C2D6B9B0D3D2B8A19@CH0PR13MB4649.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lh5dQMUGxJIi/SpadVHznUUppEGpaIxXZjtSPn8/uHZrMHwMSc2SkesFmvjb6Vdkv8b4yJRzS8woWZxWmyORSiImo0Lkitw2W5eSNc6CV+u9TqV/8OMJ0ktGeIAc63XeqRxHvcI9ktxvld5HHqy5xqvacroogKKFViVyAUipYeWvxpRj3jvFIPTOKwGsjE7Emxdnwv6atsrAD1ucZ3CRCFONimb1zu/mCUKTN1hJNxGFlygQdkDNgPXhRXUrYlWwBiuYzhrlwEXkU+3IVe15FFXT0lYrelXEyX7BKS8kgHxBKxQz+wjCfTYcX47sbeF7PGs4vm8Ju1/bvBBnFgVBDAy8DZY/68M5YYuaShisSqiWqumQ1Mtq2yuVN59BmiZFZaGXzZ2TdvXOmIuaidkADJM/UrtGufU+/hMWv+laimK/HMfnBQSouslECMLAl46AVooeULDqFbky+LYMlGM9sgA3VZ+J5PqNuV32HaDE3OuvK82cEizlou4iLQoU5qDwtfn6jl6F0N335OhjzwRAN1LbR49/ngBPVtP7O7RW89AdflzoBsWAyVhrPmhgQ2dq9HzE2WeHY+eiiq11BlC3ptkFBznoctGlBsSZ4qF+6hIQSnpkxkrR/KnbklHANvitqBGvvd5H4Ld3BrkYd50ysldEKYa9dge7UTvZ8bOQ9d2VomTGr85jgfJnqa9EJrc6qfzxlBDkOGax43jq4vkrHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(3480700007)(66946007)(2616005)(316002)(76116006)(508600001)(38070700005)(6506007)(186003)(8936002)(71200400001)(66446008)(83380400001)(53546011)(86362001)(2906002)(64756008)(8676002)(38100700002)(6486002)(4326008)(26005)(6916009)(36756003)(6512007)(122000001)(66556008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTJxVTNDQ25CMUoxRGJ5VzZPQWRhRXdSU2ZhTkNCOG16S1Z4TkIxUWk0ZmRa?=
 =?utf-8?B?VVVhRkRKVEhIa0NFNzV3bFFaTm8zOXNDUjczTklYYll1UWpjdCtMazZ1S3h5?=
 =?utf-8?B?a21Ra1d6b25hWThxelJEc3JjNHBldFJBcEw3WSs4QXo3bEpPeTZWNEllRHRW?=
 =?utf-8?B?eWlXM2E4R1hmOWFOUFhLVjRhSDR6VlkyVGpQaWNrNDdhdU1IWGtlSVV2K2pF?=
 =?utf-8?B?T0ZuTG5iSGVTais4dXFDUi9jUWROQ3pmczdVa1NrbVI3QjJoZ2dVT3g0VExW?=
 =?utf-8?B?bndGV1l3eC9xRHEybmtvY241OUZOQkVZU1E0RGtNQ1U3Sm1PVFluaSt6bmI5?=
 =?utf-8?B?M0R4RVRYdHNYeDJwbDcrSHJPU0dDREVuVWRkTE9vbGFuN2lVSFBvRlllczU0?=
 =?utf-8?B?RWVtNUl2ZFUzNG1JdXQ5SnpNa2Q3UDBrdWhIeVk5QW82ZGoxN1ZDYlIrVjI3?=
 =?utf-8?B?N05CbGJNY0praHF4dXMvSmxubzJvYWppcVpCQlhBZVJDbWM5NjhDUHRhazcv?=
 =?utf-8?B?d0FuVDh4Wk43T2dQRXZwaVQzZjBBREdkSUxJd2I4VWI3azN0L3MxTzdEMEhu?=
 =?utf-8?B?SnZKQVRBbWxRMWJhOXlCZ09IRWk2WkVoZjZKai9mVXVIQ2JlMnRmS1dSaFBW?=
 =?utf-8?B?UDRkN3hKcWcxbVRmWUEvdmRDK09VNDBnN3FKM2x1VjZjMjJvK0x5UUtyWWJI?=
 =?utf-8?B?VXpCL2Jid0N0d0JEVlJpODBPcis1NWluTXpheFFPZVREcFA4OFpkdUpXWWk4?=
 =?utf-8?B?b29IZ3NiUVVDUjNHN2pGaFJORlFFTTQwd0xsamd1MEpta09UNUV4Q1ZTV3V2?=
 =?utf-8?B?QWlURFJCVU9JMG9OWG5kREZsekptZmZ4aGJ1OTFiQjUwUy9CaXRHZy92U09B?=
 =?utf-8?B?OW10dFVrYmhDNXN5Q0ozak1SVWl0bi9jNnFqZ2dUMk5pZ3BVN09kVU8zOUN4?=
 =?utf-8?B?TWx4OXIxd2FIL2hWa1NWaS9UcEZpREhKVXBQWFdSUzVMcmFoUHBqYUZiM3NY?=
 =?utf-8?B?MUpFZkNwU3M5UllHcHFXdk1FelVHdTZ0SnJJNVVqUXlUeFJ5ZDlwN3k2UCtk?=
 =?utf-8?B?ZVJkV0EwMXJ6SWpQc2s4cjRSaVJ1U2E0SVlPWS9IRDNWVlQzdmhYWEsvR0pn?=
 =?utf-8?B?WHdPbTdlRHZUcXNGL3NtNUp1WWRYZVZaVHRkS3J3djFuK1RYRlo5YVljVmpS?=
 =?utf-8?B?cUxGc3JiTnFCZG1HNXFXRS80WGpHNDU4NzBXZHllNWRjWDNGRjE1SUVxL25l?=
 =?utf-8?B?c0lEZ21XOUFWenVqUE5EQ1pIMUFwTUJROVVlTlJabTgxZnZ3bXo1RXhNeEY3?=
 =?utf-8?B?WGRtQ1N6SHNKc0JJMzJHWHBHdUlUdytFOXgrS0kzdmxmaXlRbUZYSjQ4K3c1?=
 =?utf-8?B?MzZSa3VoSEd1VjFEYUhaRjM1Q2lFVHg1QzM3ZEQ3eGgzUEl3NnRXS0hFWjdw?=
 =?utf-8?B?R1ROeU1BcUYwQjZYQWdqNU5mTEVRcUU2d2NLR2ZwQWZjQ1FZQWpJVDB6MFY0?=
 =?utf-8?B?SVlvVzZIaEQwUEVDKzhVRmlua0VOL3JETG1LWWlxWjR6TjBKaHlUZG5idGZO?=
 =?utf-8?B?K1o0S0loTThnaHUxZlF1THBpZ2RHQmhTQXFwWlM1RHNaVDVKZzh4SkpBNDFq?=
 =?utf-8?B?WjU3U3krWnQ4eElHL3crVWVFUmxFVmgxcWhUQzAybHVoVVhkMHBORkxYZDZi?=
 =?utf-8?B?eGdVeTY4ZVd3ZXZEVWF2S2FGNSs2MVNsQW96LzdYb3ZjU2d5TktUYkVTZjg1?=
 =?utf-8?Q?CWlA9yBbFmyO+h9cOCUo6TeEHcLI5XYbTr0zpTF?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A16CE73980653441A9D2FF81DD464372@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91784976-d4b1-48cd-f0c7-08d97d320e87
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2021 19:00:19.4565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EJZ2QI8haQ/4vQxKTcEJ4suXJBG5GtHFB5WWjmObfzAF5asdJP1iaske7yNNx4h+nz8ets19VogJA2q0uQhMwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4649
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU3VuLCAyMDIxLTA5LTE5IGF0IDIzOjAzICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBKdWwgMjMsIDIwMjEsIGF0IDQ6MjQgUE0sIFRyb25kIE15a2xlYnVz
dA0KPiA+IDx0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gRnJp
LCAyMDIxLTA3LTIzIGF0IDIwOjEyICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+ID4g
PiBIaS0NCj4gPiA+IA0KPiA+ID4gSSBub3RpY2VkIHJlY2VudGx5IHRoYXQgZ2VuZXJpYy8wNzUs
IGdlbmVyaWMvMTEyLCBhbmQgZ2VuZXJpYy8xMjcNCj4gPiA+IHdlcmUNCj4gPiA+IGZhaWxpbmcg
aW50ZXJtaXR0ZW50bHkgb24gTkZTdjMgbW91bnRzLiBBbGwgdGhyZWUgb2YgdGhlc2UgdGVzdHMN
Cj4gPiA+IGFyZQ0KPiA+ID4gYmFzZWQgb24gZnN4Lg0KPiA+ID4gDQo+ID4gPiAiZ2l0IGJpc2Vj
dCIgbGFuZGVkIG9uIHRoaXMgY29tbWl0Og0KPiA+ID4gDQo+ID4gPiA3YjI0ZGFjZjA4NDAgKCJO
RlM6IEFub3RoZXIgaW5vZGUgcmV2YWxpZGF0aW9uIGltcHJvdmVtZW50IikNCj4gPiA+IA0KPiA+
ID4gQWZ0ZXIgcmV2ZXJ0aW5nIDdiMjRkYWNmMDg0MCBvbiB2NS4xNC1yYzEsIEkgY2FuIG5vIGxv
bmdlcg0KPiA+ID4gcmVwcm9kdWNlDQo+ID4gPiB0aGUgdGVzdCBmYWlsdXJlcy4NCj4gPiA+IA0K
PiA+ID4gDQo+ID4gDQo+ID4gU28geW91IGFyZSBzZWVpbmcgZmlsZSBtZXRhZGF0YSB1cGRhdGVz
IHRoYXQgZW5kIHVwIG5vdCBjaGFuZ2luZw0KPiA+IHRoZQ0KPiA+IGN0aW1lPw0KPiANCj4gQXMg
ZmFyIGFzIEkgY2FuIHRlbGwsIGEgV1JJVEUgYW5kIHR3byBTRVRBVFRScyBhcmUgaGFwcGVuaW5n
IGluDQo+IHNlcXVlbmNlIHRvIHRoZSBzYW1lIGZpbGUgZHVyaW5nIHRoZSBzYW1lIGppZmZ5LiBU
aGUgV1JJVEUgZG9lcw0KPiBub3QgcmVwb3J0IHByZS9wb3N0IGF0dHJpYnV0ZXMsIGJ1dCB0aGUg
U0VUQVRUUnMgZG8uIFRoZSByZXBvcnRlZA0KPiBwcmUtIGFuZCBwb3N0LSBtdGltZSBhbmQgY3Rp
bWUgYXJlIGFsbCB0aGUgc2FtZSB2YWx1ZSBmb3IgYm90aA0KPiBTRVRBVFRScywgSSBiZWxpZXZl
IGR1ZSB0byB0aW1lc3RhbXBfdHJ1bmNhdGUoKS4NCj4gDQo+IE15IHRoZW9yeSBpcyB0aGF0IHBl
cnNpc3RlbnQtc3RvcmFnZS1iYWNrZWQgZmlsZXN5c3RlbXMgc2VlbSB0bw0KPiBnbyBzbG93IGVu
b3VnaCB0aGF0IGl0IGRvZXNuJ3QgYmVjb21lIGEgc2lnbmlmaWNhbnQgcHJvYmxlbS4gQnV0DQo+
IHdpdGggdG1wZnMsIHRoaXMgY2FuIGhhcHBlbiBvZnRlbiBlbm91Z2ggdGhhdCB0aGUgY2xpZW50
IGdldHMNCj4gY29uZnVzZWQuIEFuZCBJIGNhbiBtYWtlIHRoZSBwcm9ibGVtIHVucmVwcm9kdWNh
YmxlIGlmIEkgZW5hYmxlDQo+IGVub3VnaCBkZWJ1Z2dpbmcgcGFyYXBoZXJuYWxpYSBvbiB0aGUg
c2VydmVyIHRvIHNsb3cgaXQgZG93bi4NCj4gDQo+IEknbSBub3QgZXhhY3RseSBzdXJlIGhvdyB0
aGUgY2xpZW50IGJlY29tZXMgY29uZnVzZWQgYnkgdGhpcw0KPiBiZWhhdmlvciwgYnV0IGZzeCBy
ZXBvcnRzIGEgc3RhbGUgc2l6ZSB2YWx1ZSwgb3IgaXQgY2FuIGhpdCBhDQo+IGJ1cyBlcnJvci4g
SSdtIHNlZWluZyBhdCBsZWFzdCBmb3VyIG9mIHRoZSBmc3gtYmFzZWQgeGZzIHRlc3RzDQo+IGZh
aWwgaW50ZXJtaXR0ZW50bHkuDQo+IA0KDQpUaGUgY2xpZW50IG5vIGxvbmdlciByZWxpZXMgb24g
cG9zdC1vcCBhdHRyaWJ1dGVzIGluIG9yZGVyIHRvIHVwZGF0ZQ0KdGhlIG1ldGFkYXRhIGFmdGVy
IGEgc3VjY2Vzc2Z1bCBTRVRBVFRSLiBJZiB5b3UgbG9vayBhdA0KbmZzX3NldGF0dHJfdXBkYXRl
X2lub2RlKCkgeW91J2xsIHNlZSB0aGF0IGl0IHBpY2tzIHRoZSB2YWx1ZXMgdGhhdA0Kd2VyZSBz
ZXQgZGlyZWN0bHkgZnJvbSB0aGUgaWF0dHIgYXJndW1lbnQuDQoNClRoZSBwb3N0LW9wIGF0dHJp
YnV0ZXMgYXJlIG9ubHkgdXNlZCB0byBkZXRlcm1pbmUgdGhlIGltcGxpY2l0DQp0aW1lc3RhbXAg
dXBkYXRlcywgYW5kIHRvIGRldGVjdCBhbnkgb3RoZXIgdXBkYXRlcyB0aGF0IG1heSBoYXZlDQpo
YXBwZW5lZC4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRh
aW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
