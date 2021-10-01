Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39BB941EF7F
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Oct 2021 16:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354533AbhJAObP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Oct 2021 10:31:15 -0400
Received: from mail-mw2nam12on2102.outbound.protection.outlook.com ([40.107.244.102]:55808
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1354525AbhJAObN (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 1 Oct 2021 10:31:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9FM4t5lYPGH+oKszvamugCe2+5Sep5I28/yV6VUuQcprYPWkbzw6AVYiFrMyAvDzSsvj1YIh6GmraRhQXf6uTp9/GI5yQKzqC3Nk0ITnYA2AnV7Fjih6gtJ9HcHjbhMZSENjfuVFrBjgduxm3EENSbbDVG2YkC58MVLZTO/V0fy6a1iqm+Jf9gbgm1bWMF8OxJfqvRWEb1RgpFQawTTpR/O/9Jc8NgRNsUMOpPsXSygMYPAIXRoGzJfd5xT1EXrgNSQFCD3UT1Ma0nFyVOMH1mGfI7tJikxi8ypW9qZecDeeI93DoB/NSc/WUKKGO+KzScnSqqNBh6Jy9Fmz34irQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11yrtB4jwyKKAK0Lv5oHppK8H8cAqQ5/kvCnE1NuekI=;
 b=OCVUHVeX/NL7vUSGIcO/fBJThQnNL/aiMNFRY3/UFAHfoVuII0JbDFZoMLWH/zfrwy0wKU1E/JDdCNrTzn3VvLSoFENIJ791o6JYy1on411OANewHT2h40SQyqmLmhozFHD1OLqRspcEWQJRGp9Clx6uq3x7aRDremqnPagBpwiQeLVm3NJ6OblQKgmL1GmRi4SClyBiw1D0pLWS29Tfm8P3q4agFE/6pk9IOdddtBDOChxr9oleLgYhzSuusQWy4GJ9uS409ZwyZoRaWHsi3f7EYLj5M8xb6EgV6W261LIC/4HxMdfb41KMnnWyjBURwEe+pF8+UYSSIHHEbY7y5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11yrtB4jwyKKAK0Lv5oHppK8H8cAqQ5/kvCnE1NuekI=;
 b=ZLTFfIrEYt8ctOqj8FF5gLsHg5Rlb6Vft38gFcqv6ENFOYDX1j8hARkeweq7tubRB9TwqN11tsb7Kt6Dbzt4xSr5DcGq8B7fCw7QOh/WPZmj1Yjcn7wPRwVnoIXkZkV4voOteawZoqgpY9dDxMJwBNgWQE9TBp7yWZ0zZCj25pc=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB4700.namprd13.prod.outlook.com (2603:10b6:610:c2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.9; Fri, 1 Oct
 2021 14:29:26 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1533:4550:d876:1486]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1533:4550:d876:1486%6]) with mapi id 15.20.4587.011; Fri, 1 Oct 2021
 14:29:26 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dwysocha@redhat.com" <dwysocha@redhat.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>
CC:     "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH v2 3/8] nfs: Move to using the alternate fallback fscache
 I/O API
Thread-Topic: [PATCH v2 3/8] nfs: Move to using the alternate fallback fscache
 I/O API
Thread-Index: AQHXq9VkcJvbs0xlPEq7aMXkSiWnq6u+EpgAgAA3MwA=
Date:   Fri, 1 Oct 2021 14:29:26 +0000
Message-ID: <97eb17f51c8fd9a89f10d9dd0bf35f1075f6b236.camel@hammerspace.com>
References: <163189104510.2509237.10805032055807259087.stgit@warthog.procyon.org.uk>
         <163189108292.2509237.12615909591150927232.stgit@warthog.procyon.org.uk>
         <CALF+zO=165sRYRaxPpDS7DaQCpTe-YOa4FamSoMy5FV2uuG5Yg@mail.gmail.com>
In-Reply-To: <CALF+zO=165sRYRaxPpDS7DaQCpTe-YOa4FamSoMy5FV2uuG5Yg@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6fd22a37-05c6-42dc-7818-08d984e7def5
x-ms-traffictypediagnostic: CH0PR13MB4700:
x-microsoft-antispam-prvs: <CH0PR13MB4700E3C235F5F2E2D458E10BB8AB9@CH0PR13MB4700.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QcquSlWybqMbzmIA4rIE/OBe65nzWehyCp0jj6yVclJ4rC5scvuuy6BcoRNaIC6S2fFxY9/1ejKMhwTfxjHT8J2qZJtuF/f4pR3dNyeyv09hFGJg4BfYAgzyqD0ZDvHhyJuzEyLll+VnAv2lJAheIzhrWuW0+82rP8aVuW9gCr4ozb/e91STCUpnyl/vebx3hQz/yIXrxGDrp5hrjvrOHWG2fOh1lF9Lq+BejFOOIUgP3BR5u66SRihRPhJKQWRvZ9lqL/gcex5mFJHuaZN5/a2e8hXQmy4tD95vCHtNRRmJyykjJNXrBkT2he9K2hw9xfWDh0doGzmEflFxCUTcwuZPeuro1bnYyjtUDB6oDlXNIPbx3ssh+s9uv1KYY59IkZQ02HnkdJvs8FKaw1GWS0yR3VKNQr1bTztyP2RuN9FjRc8jQ1Nmqp+3oAuSGjm9Lqkq6ETlLehxXdMH5hoEiS8GMoailqAVMdrOYzx25B3aTk5YX/5i0YkxJQjdKxWcU/ARdocFMMQt7C0XMocQRVej55qy9KQF2ur5/SF+WY5+QFvea9TyUbFT5qi/Wdc1apaL7ySVd6RR/6PE3qHDeCYQH/fMzWnP8T9CQS05mnGOtq1kt2o3XfQAAYP1KzbDdX5N2bWNZQiTEtasFaYUHrDB4Za7sjKLtM8w+1sAQAB6hPQD0qM08Ltv53RVaijGZJHhrFxewt4wY2r+ZZWVKrr2fnrJX8iyzgCmsomueeVEpzNevTi47l+EiwvCj8Q08RL9FRsYoZZmVcSYnsOt3OxU9DG4GugNmpfwUyLhlHU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(71200400001)(83380400001)(8936002)(6512007)(66946007)(316002)(64756008)(66476007)(38100700002)(5660300002)(86362001)(8676002)(110136005)(2616005)(26005)(6486002)(38070700005)(2906002)(54906003)(4326008)(966005)(53546011)(76116006)(6506007)(36756003)(508600001)(66446008)(122000001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVMzTTNrNEh0VTVXMGFHdVlzU0N1LzdMTEErRFVCb3FrZ05DekoyNUFJUEFL?=
 =?utf-8?B?SVk5OU8zR0hwaXJHTGU0VGMyLzFZdGJuUlhsU0l0aWxJdVJVQTlBdEJRQ05L?=
 =?utf-8?B?TmtIaWJHc1JWME5RUmFPVGxaaVBqUlVZQ2pVYUJLUFE1dFByOVpPREhrYVYw?=
 =?utf-8?B?ZFpFSWg1STVYWGVWN0hYbzlKSDZ2aTYvMDhEMzBlNTVZVkFjelI2dkZwVys2?=
 =?utf-8?B?aGE3K2lHTlg3OTk5ZWJOYThXc3IxWWxBelNab1BXSHhOaTRHQ3J0a3JRWW84?=
 =?utf-8?B?MHhDY3VBSXl6SDdIb3ovOVBQaGwvRkVhMjNkS2VSZkZKV1Rwa1Ryd3NSVmti?=
 =?utf-8?B?NW1NT3lYVnNkUy8xQ1Awa292Y2hQbXZSUysyVVNQZnYwNU9iTmtmaHNFS1dp?=
 =?utf-8?B?QmRmQnE5cVFMb05XSnNTTnpUcy9pa2NZbjVXNEVtRElsdzNwbnMva3QxWDBL?=
 =?utf-8?B?ODZSSGJzUW5lYWhHVjlDMjdqd3Avc1dhSC92UzdTNVpTNVpSVkcyTlpkVnY5?=
 =?utf-8?B?TStJeGFhQjh6TlVIdmtqaDVjN0FIUGVOMzUvRVdEcEhUTlA3NjJNSnVIZEZZ?=
 =?utf-8?B?bThXbUxTK1RrYlV6UUJxS3F3UkdCb1J0d3dlR3V5cW05dVc3UEdXaXlGZFBS?=
 =?utf-8?B?RG90alkwQWtzRGtKRnI1MVBxM1h6UVFIR0hMSkxIWGR3Uk9EdGtwWmFsbW9u?=
 =?utf-8?B?cThBWHJCUk5pZnE0SW13SUZNa3JKRGhqc0dZRWd6MWZRZ0FTMUxsVDZUQnpN?=
 =?utf-8?B?eGVwb2swTFJPckpldlZqUUFBY0piRFdnZW9weUdUQUFMc01VK2JzSFcwS0ZU?=
 =?utf-8?B?bEl1OUlQeUFhc2FudTlLZW55dlFxREIwdllzNEtKcEtHN1NVZGZyTG45YzBK?=
 =?utf-8?B?c0NLM1YwWHZ1cnlZbGxBMjllcmxGbjhZeWNrYVI1WTg4ZmVRcGxTMlZ5N2hj?=
 =?utf-8?B?WlhTQjM1ZG1JaXhPWU1VSVFkdTRCeWNTNVZqS1NXWU9DdFA3U29MSWJPT3pp?=
 =?utf-8?B?YWUyNjBES3BvUktmUzlkL1RaSjdrUTUySm9QSmNGcHpCWWs5TnJCaDNYYmgr?=
 =?utf-8?B?VVpidmo5TTFRM2pObitlZUNjK3pwUHFtSmhoZ0JiaFNUc0hoeVlwbDdCckNT?=
 =?utf-8?B?ZDNldERiMWREOXBSeTRPWmNOYTA2YWJEdTRFT3hXeTZ0d2F0dTZ6bXE1d1hV?=
 =?utf-8?B?UytRK0I2U29udGZabGgxY0k1V0kvUSswS3Z0WDQyeTdUbUhWZkhhZEUwZzUw?=
 =?utf-8?B?eWw5ZndnMzlBQWlnckR1NzZ5aW1TMUo4dzkyWkpteFV1R0kzM01kU1N1UVln?=
 =?utf-8?B?cWFyaFZ2T2lmSCtzTnJSRXZDbTZ4SmVMUGJtMVlzTmlVVnZMdEdWbkp2dE9i?=
 =?utf-8?B?QzhML2NJL21KNGtDTkhzSmNwTG1XeWN3ZnpQMHIrV3FJYklMUGlid1N2dUpG?=
 =?utf-8?B?RUFSYlVaVlhQKzVSZHN6Lyt6UUpwUWtDOHhreHpvWG1ERmw1L2JOL0V0aGpa?=
 =?utf-8?B?dTRHTGFmcUZHUEJjREZjWFBFdmNXUTRmWHdPSUh1QnhmZGlyRnZTVEEwbjNE?=
 =?utf-8?B?d01XOGJHTFRTSm5vd1NoNmR3bk5SZjFjU2NKV0xsWmN6aU5wdUpkUUIvbnM5?=
 =?utf-8?B?WXZzZjdUMTZwazJ6WjA2aHVuT2ovc3kwNGNRS2owY2x5ekhwZ2dJRGM5OGh1?=
 =?utf-8?B?ZVFLcHdWYjNOcnVxMVRMQmJrZmJTTlg5c0N3Y09vR2R1OUtnN3lqdS9kYUVy?=
 =?utf-8?Q?VQiK6QXwGpo91FBa3koRyGTQiSBQeCV8NHGDiKK?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0D21244B42DAE458BCEEA9CB26D6D79@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd22a37-05c6-42dc-7818-08d984e7def5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2021 14:29:26.0465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Utshr5soYEbaUparm036MdIq1KI1PDC5l+YT0dKUVCx2NsYpC336xzovVI8JKNdQOEuTtK6XIpITx6HhXCbYOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4700
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIxLTEwLTAxIGF0IDA3OjExIC0wNDAwLCBEYXZpZCBXeXNvY2hhbnNraSB3cm90
ZToNCj4gDQo+IA0KPiBPbiBGcmksIFNlcCAxNywgMjAyMSBhdCAxMTowNSBBTSBEYXZpZCBIb3dl
bGxzIDxkaG93ZWxsc0ByZWRoYXQuY29tPg0KPiB3cm90ZToNCj4gPiANCj4gPiBNb3ZlIE5GUyB0
byB1c2luZyB0aGUgYWx0ZXJuYXRlIGZhbGxiYWNrIGZzY2FjaGUgSS9PIEFQSSBpbnN0ZWFkIG9m
DQo+ID4gdGhlIG9sZA0KPiA+IHVwc3RyZWFtIEkvTyBBUEkgYXMgdGhhdCBpcyBhYm91dCB0byBi
ZSBkZWxldGVkLsKgIFRoZSBhbHRlcm5hdGUgQVBJDQo+ID4gd2lsbA0KPiA+IGFsc28gYmUgZGVs
ZXRlZCBhdCBzb21lIHBvaW50IGluIHRoZSBmdXR1cmUgYXMgaXQncyBkYW5nZXJvdXMgKGFzDQo+
ID4gaXMgdGhlDQo+ID4gb2xkIEFQSSkgYW5kIGNhbiBsZWFkIHRvIGRhdGEgY29ycnVwdGlvbiBp
ZiB0aGUgYmFja2luZyBmaWxlc3lzdGVtDQo+ID4gY2FuDQo+ID4gaW5zZXJ0L3JlbW92ZSBicmlk
Z2luZyBibG9ja3Mgb2YgemVyb3MgaW50byBpdHMgZXh0ZW50IGxpc3RbMV0uDQo+ID4gDQo+ID4g
VGhlIGFsdGVybmF0ZSBBUEkgcmVhZHMgYW5kIHdyaXRlcyBwYWdlcyBzeW5jaHJvbm91c2x5LCB3
aXRoIHRoZQ0KPiA+IGludGVudGlvbg0KPiA+IG9mIGFsbG93aW5nIHJlbW92YWwgb2YgdGhlIG9w
ZXJhdGlvbiBtYW5hZ2VtZW50IGZyYW1ld29yayBhbmQNCj4gPiB0aGVuY2UgdGhlDQo+ID4gb2Jq
ZWN0IG1hbmFnZW1lbnQgZnJhbWV3b3JrIGZyb20gZnNjYWNoZS4NCj4gPiANCj4gPiBUaGUgcHJl
ZmVycmVkIGNoYW5nZSB3b3VsZCBiZSB0byB1c2UgdGhlIG5ldGZzIGxpYiwgYnV0IHRoZSBuZXcg
SS9PDQo+ID4gQVBJIGNhbg0KPiA+IGJlIHVzZWQgZGlyZWN0bHkuwqAgSXQncyBqdXN0IHRoYXQg
YXMgdGhlIGNhY2hlIG5vdyBuZWVkcyB0byB0cmFjaw0KPiA+IGRhdGEgZm9yDQo+ID4gaXRzZWxm
LCBjYWNoaW5nIGJsb2NrcyBtYXkgZXhjZWVkIHBhZ2Ugc2l6ZS4uLg0KPiA+IA0KPiA+IENoYW5n
ZXMNCj4gPiA9PT09PT09DQo+ID4gdmVyICMyOg0KPiA+IMKgIC0gQ2hhbmdlZCAiZGVwcmVjYXRl
ZCIgdG8gImZhbGxiYWNrIiBpbiB0aGUgbmV3IGZ1bmN0aW9uDQo+ID4gbmFtZXNbMl0uDQo+ID4g
DQo+ID4gU2lnbmVkLW9mZi1ieTogRGF2aWQgSG93ZWxscyA8ZGhvd2VsbHNAcmVkaGF0LmNvbT4N
Cj4gPiBjYzogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29t
Pg0KPiA+IGNjOiBBbm5hIFNjaHVtYWtlciA8YW5uYS5zY2h1bWFrZXJAbmV0YXBwLmNvbT4NCj4g
PiBjYzogbGludXgtbmZzQHZnZXIua2VybmVsLm9yZw0KPiA+IGNjOiBsaW51eC1jYWNoZWZzQHJl
ZGhhdC5jb20NCj4gPiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yL1lPMTdaTk9jcSs5
UGFqZlFAbWl0LmVkdSBbMV0NCj4gPiBMaW5rOg0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L3IvQ0FIay09d2lWSysxQ3lFalc4dTcxelZQSzhtc2VhPXFQcHpuWDM1Z25YK3M4c1huSlRnQG1h
aWwuZ21haWwuY29tLw0KPiA+IFsyXQ0KPiA+IExpbms6DQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvci8xNjMxNjI3NzE0MjEuNDM4MzMyLjExNTYzMjk3NjE4MTc0OTQ4ODE4LnN0Z2l0QHdh
cnRob2cucHJvY3lvbi5vcmcudWsvDQo+ID4gIyByZmMNCj4gPiAtLS0NCj4gPiANCj4gPiDCoGZz
L25mcy9maWxlLmMgwqAgwqB8IMKgIDE0ICsrKy0tDQo+ID4gwqBmcy9uZnMvZnNjYWNoZS5jIHwg
wqAxNjEgKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gLS0t
LS0tLS0tLS0tDQo+ID4gwqBmcy9uZnMvZnNjYWNoZS5oIHwgwqAgODUgKysrKy0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0NCj4gPiDCoGZzL25mcy9yZWFkLmMgwqAgwqB8IMKgIDI1ICsrKy0tLS0t
DQo+ID4gwqBmcy9uZnMvd3JpdGUuYyDCoCB8IMKgIMKgNyArKw0KPiA+IMKgNSBmaWxlcyBjaGFu
Z2VkLCA1NSBpbnNlcnRpb25zKCspLCAyMzcgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAt
LWdpdCBhL2ZzL25mcy9maWxlLmMgYi9mcy9uZnMvZmlsZS5jDQo+ID4gaW5kZXggYWEzNTNmZDU4
MjQwLi4yMDlkYWMyMDg0NzcgMTAwNjQ0DQo+ID4gLS0tIGEvZnMvbmZzL2ZpbGUuYw0KPiA+ICsr
KyBiL2ZzL25mcy9maWxlLmMNCj4gPiBAQCAtNDE2LDcgKzQxNiw3IEBAIHN0YXRpYyB2b2lkIG5m
c19pbnZhbGlkYXRlX3BhZ2Uoc3RydWN0IHBhZ2UNCj4gPiAqcGFnZSwgdW5zaWduZWQgaW50IG9m
ZnNldCwNCj4gPiDCoCDCoCDCoCDCoCAvKiBDYW5jZWwgYW55IHVuc3RhcnRlZCB3cml0ZXMgb24g
dGhpcyBwYWdlICovDQo+ID4gwqAgwqAgwqAgwqAgbmZzX3diX3BhZ2VfY2FuY2VsKHBhZ2VfZmls
ZV9tYXBwaW5nKHBhZ2UpLT5ob3N0LCBwYWdlKTsNCj4gPiANCj4gPiAtIMKgIMKgIMKgIG5mc19m
c2NhY2hlX2ludmFsaWRhdGVfcGFnZShwYWdlLCBwYWdlLT5tYXBwaW5nLT5ob3N0KTsNCj4gPiAr
IMKgIMKgIMKgIHdhaXRfb25fcGFnZV9mc2NhY2hlKHBhZ2UpOw0KPiA+IMKgfQ0KPiA+IA0KPiA+
IMKgLyoNCj4gPiBAQCAtNDMyLDcgKzQzMiwxMiBAQCBzdGF0aWMgaW50IG5mc19yZWxlYXNlX3Bh
Z2Uoc3RydWN0IHBhZ2UgKnBhZ2UsDQo+ID4gZ2ZwX3QgZ2ZwKQ0KPiA+IMKgIMKgIMKgIMKgIC8q
IElmIFBhZ2VQcml2YXRlKCkgaXMgc2V0LCB0aGVuIHRoZSBwYWdlIGlzIG5vdCBmcmVlYWJsZQ0K
PiA+ICovDQo+ID4gwqAgwqAgwqAgwqAgaWYgKFBhZ2VQcml2YXRlKHBhZ2UpKQ0KPiA+IMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybiAwOw0KPiA+IC0gwqAgwqAgwqAgcmV0dXJuIG5mc19m
c2NhY2hlX3JlbGVhc2VfcGFnZShwYWdlLCBnZnApOw0KPiA+ICsgwqAgwqAgwqAgaWYgKFBhZ2VG
c0NhY2hlKHBhZ2UpKSB7DQo+ID4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAoIShnZnAgJiBf
X0dGUF9ESVJFQ1RfUkVDTEFJTSkgfHwgIShnZnAgJg0KPiA+IF9fR0ZQX0ZTKSkNCj4gPiArIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybiBmYWxzZTsNCj4gPiArIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIHdhaXRfb25fcGFnZV9mc2NhY2hlKHBhZ2UpOw0KPiA+ICsgwqAgwqAg
wqAgfQ0KDQpJJ3ZlIGZvdW5kIHRoaXMgZ2VuZXJhbGx5IG5vdCB0byBiZSBzYWZlLiBUaGUgVk0g
Y2FsbHMgLT5yZWxlYXNlX3BhZ2UoKQ0KZnJvbSBhIHZhcmlldHkgb2YgY29udGV4dHMsIGFuZCBv
ZnRlbiBmYWlscyB0byByZXBvcnQgaXQgY29ycmVjdGx5IGluDQp0aGUgZ2ZwIGZsYWdzLiBUaGF0
J3MgcGFydGljdWxhcmx5IHRydWUgb2YgdGhlIHN0dWZmIGluIG1tL3Ztc2Nhbi5jLg0KVGhpcyBp
cyB3aHkgd2UgaGF2ZSB0aGUgY2hlY2sgYWJvdmUgdGhhdCB2ZXRvcyBwYWdlIHJlbW92YWwgdXBv
bg0KUGFnZVByaXZhdGUoKSBiZWluZyBzZXQuDQo+IA0KDQotLSANClRyb25kIE15a2xlYnVzdA0K
TGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0
QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
