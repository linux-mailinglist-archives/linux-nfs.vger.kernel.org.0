Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2ABE44377E
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Nov 2021 21:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhKBUxm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Nov 2021 16:53:42 -0400
Received: from mail-co1nam11on2094.outbound.protection.outlook.com ([40.107.220.94]:40801
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230061AbhKBUxl (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 2 Nov 2021 16:53:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVgAqkMgTriYyrJs1s75bXVR4A8P/Lknq1mamIpAyXHmBcAVkypcv40L3xOsHzJkrFoEH5pFTJKaOXe3PT/Ouk7NOSt/XPMZ0dqYgo8oxftHDO6HX4wquREaFVJfHKPz8b8NXTY6kXJVgQ7n3ygSkysbPDLniHevNtMUSF0vbCRHvy+tF/hloWKSa/rvJ5KpQogsSkIEcQXmVANdPMdhc8Fn1724o72NCvoSQH36sBx7Xsnx937KEJMt3T6FU8v8u605roNRYPzRjSDMfJ62g2UyDVeUmN4qBOUArsYyh5oUahmnK/U6QEt2ReqdhBkbarS7F6KoM3BH6efEiqN0Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFDrclzwzyjaiYtF9qMy7IK4vHVlrlhuYEPOYfQdoGg=;
 b=UVk5SjhnXixD3cmF30OZe2hk1qfl0w3OxITC7/98/DJIkq9/lKDa8PINRhgt8ndfgDIBmcj4J2p11irYJQe67NbLUEK/arL8uPzJCf4Ft2Xh36VmHv++6q19Mb+mkIpivmL/BEtD0v9To7i7P0bFBbODZhbfzzGmgnOfoYAYOLNEU8Dv63NBcIflNchQ5RzbrShzk0AiI7cBrsm6AOkzAkxvDRp0MdL1w1xdJATZXK0Cg8A7fTotrcJgi+7B3fBhekt3t9xqQjhuYpSQH+7jJCoUtC0l4/yK+1SEsKLuBtu3jRlhpMg828T1yUdIAzvzWC9UhsDb5hoSx4i8YcVuIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFDrclzwzyjaiYtF9qMy7IK4vHVlrlhuYEPOYfQdoGg=;
 b=g8P9i5porgu+fdblfT+b0jnvR0vVH/nexUl+c9nTtThAT4WlkL99Esmkfbimh3DXQk/p9PaPdJVdf7jItH6EDzoFyA3wvTWvyFtuBiNUbJ3gzgpNRMcNhhRcfZ27VbapuLY1iEmfNVYBC6JuV3lyNMNpNpc2EfoJPgPOtk4vFf8=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3304.namprd13.prod.outlook.com (2603:10b6:610:22::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.8; Tue, 2 Nov
 2021 20:51:04 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1533:4550:d876:1486]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1533:4550:d876:1486%8]) with mapi id 15.20.4669.010; Tue, 2 Nov 2021
 20:51:04 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "smayhew@redhat.com" <smayhew@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH 1/1] nfs4: take a reference on the nfs_client when running
 FREE_STATEID
Thread-Topic: [PATCH 1/1] nfs4: take a reference on the nfs_client when
 running FREE_STATEID
Thread-Index: AQHXz1v4o2sZThDS3Em5oh6bn8aATKvwbq0AgAA+NACAAArfAA==
Date:   Tue, 2 Nov 2021 20:51:04 +0000
Message-ID: <517ed553804f9a250bf9b06bdcce71a3cc7805d9.camel@hammerspace.com>
References: <20211101200623.2635785-1-smayhew@redhat.com>
         <20211101200623.2635785-2-smayhew@redhat.com>
         <9c677842d46b95e1ac7011afd44e29229d9efaa9.camel@hammerspace.com>
         <YYGbaPX3DbQf7FXi@aion.usersys.redhat.com>
In-Reply-To: <YYGbaPX3DbQf7FXi@aion.usersys.redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6384c718-27e8-4f88-4bf7-08d99e427c7c
x-ms-traffictypediagnostic: CH2PR13MB3304:
x-microsoft-antispam-prvs: <CH2PR13MB3304BFEF7840560BD37AA2BBB88B9@CH2PR13MB3304.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iD8Yhojt22QPbr7SUJvVFYylCmj8ffIC5WyYmRp04Gl1TQAv6CZ4SMmTy8q2EBqZVUh4PmxfslGYcjDP+vg6usJyxTXyiLRnmIRGnGFAJzGpzvWDJpG1JvJVJF4eQqMqkq1fTI/Lc0oqkGjW5A53G3W0jlUczhNlpPmFATAPtiOXGWWO4uomEMaGPPbC4JXUVccnfOQGSHVqfmfWGNYYo8Pzl9TB0McWZR7kiAyvuMn1YHrjycr2WjoRDv6SUh6cHbji0s8/LTuhnHlMGZJ2bu4U1Lko8sY4Hpqf4/mNNYiwClxJBCAMBKDpQj57OZmPukBEOfJyeUj7JEn2DwKlCdBGT5jxeToREJQCMSTZSoiYhvx3cxaswPKawfQnb29MG9seC/UigitZiG8x4AA71hdU1KPxQZe0wIifSb1kLDAsjfVGogSF9ibaKoy341E3popMBZ7Rn7zwgPFLzX3blPiQZniLWqyPzGfnHp+cpl2gBy8fLXjT0W/s8+Ol67tGqUUEp6mT0HoIV4Cv2EjYybduT+n4MjD6L9DJ/z8nQ+noxgIhpzhLyMwihp0Rmy2QwbtaxoYSsNe80BLx6IEpOPzeS5vCMfWAebBiTbF1Kgt4jFPA2ZZ7XqwnO9nj8n7STUCjXCQp4QbmUDRAbGK1e1V09YCefxewPI6j686XJnNloqOMuLQRhlFHYABPppM1CB4oi27VikV6BNew4kQ5sw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(38070700005)(26005)(38100700002)(83380400001)(186003)(66556008)(76116006)(66476007)(64756008)(66446008)(66946007)(2906002)(6486002)(2616005)(71200400001)(6506007)(6916009)(5660300002)(36756003)(86362001)(54906003)(316002)(122000001)(4326008)(8676002)(8936002)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RzVjeHBKWnVyWDBLVEJqUmZQMEtYcmZ6NlJVajVXclVia3U3ek9EZXZ6bjhk?=
 =?utf-8?B?WHYva0FYWUVMS2M3Y2xIbEFlMTNWSkxCbUZnOXh1NDRBTU01Rzc3MEhxajR0?=
 =?utf-8?B?S1NFZmU0cEhoMmh4Z3RXblZBSnlzWHBjendBVGxzeGFsTEIrYU1KNENjSG10?=
 =?utf-8?B?REhYcWRoQllLVjRhZXlFTTljbFZ1RHRBRjBIaGhKN08wQW55YkMzeHJneHBo?=
 =?utf-8?B?ZHVjTjJsTzVxaFhIUU9xa0FUU1JDdHJKRzFjV25wZm9KNVZTcUp0anJnUEJw?=
 =?utf-8?B?SnE4cmVVZmhrdEtEM0lnaUhPZHhtNWpEN0dMNDdUQUQveDBQUVg3ZHM1ZHFr?=
 =?utf-8?B?c1o0ZEZ3anpvdjRPU3IyOVBiQTZDcHJRYm9tdjRwMGlNZnpXbytKOThwOExa?=
 =?utf-8?B?Wmo3VDRqalIzeW9mNlJ6ZDE4am5IQ0VMbU04R2ppNGRtU0UvYWF6ZWxTci90?=
 =?utf-8?B?cmg5eHdkWUkzUEZXMmwvblliM3lBTEw4RGVmL1lXa3IxZ1B4OENkbG5MRzNU?=
 =?utf-8?B?SzUvRWlMeUV6RDNucUM3UHYxblZZWWVGRlRsRzZuU29uS051bUY1Nm0xYTZj?=
 =?utf-8?B?Q3huU003Rno1M0dnUmJGMTg4NThtcnQrYjByZ014dlhJMnFiaE1SNGZEeHlv?=
 =?utf-8?B?ZGVkQ2FhOWp5SmFmdmd3YXJmRWZ1eWpITnUxRE1HK2xpeW1kQW54VFBoK2V5?=
 =?utf-8?B?dG81TytQUTVUUzZyY1VERVFvZDQvNVRrWk9ick9zRVI2NWJZUW1uVGx5THBy?=
 =?utf-8?B?SWREVHd3UzRqbmVhd2xRaG53UnRjUHZmc2cwRDBrd1Iwei9IcExkcXBuaUxU?=
 =?utf-8?B?OHNDZzNSSW8zV0FwWEYzMGJUS2FuTXVnUDVURG96VGxUeXIzYytCc2NGVHZ6?=
 =?utf-8?B?bTNxK1kvVVJwVGJFRkhGYzNZY01QRlp5NXprcWV5S0EzZUdDUEc0djJ1UVBa?=
 =?utf-8?B?N2lrbGhiVVpLbGNVV0R2aFc2Q0F6bGM4dDNFMXgrTEN0RTNFVHUvaTRlZ040?=
 =?utf-8?B?RTJmUzdZTVVqOU95VGpQRnRMOExsVzc3NUhVREdRcDg3V0tFZTgwU2hMVWJs?=
 =?utf-8?B?Q2FzS0J6bFByT2hvd1FwNXJ5U3hZNmU5dzBFcWMyalRjdEIyb0Zqakk2R0hE?=
 =?utf-8?B?UkNDa2JLRHl5bU5qTllzeC9ZQ29vSFA1RXZXVHlya0VFQWZra2VQaHZjK0xD?=
 =?utf-8?B?MkRYNnZGQ1FyWUY1MVAyK0dFV0ZEREJTeXlxM3ZqVXI2aXAyN25IMjhDd3Ja?=
 =?utf-8?B?RFZvN25KUmh2em11UzA2VzQ0VzZ6LzBua1l0Q05teXduMVhEcEMzRjB6SUNo?=
 =?utf-8?B?L3hLa3I4akNSY3Vyak5zT2lZL09TN3lPQTVMS0huUVR0cFNqUGwzbWUxbWQw?=
 =?utf-8?B?WDRtTU1WRXpOQUgwcjEySWJWQ3FvZjBJcU1oNCtpbkRlUTJVYS9CT3o3ZnEy?=
 =?utf-8?B?MXh4NzFlVVZ2Qjl0eGQyd1gvNk1lL1lveityUnhac1pRM2ZkY0kzVDZZTlg1?=
 =?utf-8?B?ckZvc1VNRHFmaVEwYThwKzZ3QnhBZ3pWNWxkNklENjdOU0hBVWZRYlgyUHhF?=
 =?utf-8?B?RjBybWNxWU1mYkhTVWdqQUNnWGxRU1hrak9NN2FiMWZGa0JzRmx0bTJWT1ox?=
 =?utf-8?B?NWNHLzY5ZFk3TmsyRUEzZmtmQmZuczNSSjArNHQyZjBrMUlUM2Jmc3BJMVQ5?=
 =?utf-8?B?TVREd293S203ZUg2K1diSCtsWnc4anJ3L2w5MElIT0F4N29lU2FSdWg1TERX?=
 =?utf-8?B?aysyQ0FyeWF5Nnd1VEgwMFpRU3BWNVdDZTZmNkJWQVY3akh6cEhUckxvQktI?=
 =?utf-8?B?N24xTVdaUUVPMzI0REhyWmdKRitEZ2M3NnJ5MkdwZHZqTGM4RnJqQm9JMy94?=
 =?utf-8?B?YXFXWUdia2Q3VmRabk1mYTJXM0NudTl1ZDcwckM1R1RPQndiejE2a1BBM1Qv?=
 =?utf-8?B?eFB2Z0ZTQTMzVENlY284dDZyMUNrT2ovdWZXelVjL21XM2VCNVcyZXcvUFBC?=
 =?utf-8?B?aDZGK1V6YXZ3TEFEbFlXWk5sVjVPM1B1djA3MjlsM3dRZ2RxM0pKclMyeXE0?=
 =?utf-8?B?bjZUQUZxUjJCazJ6MTVvSUVvWGZJOGx5bVpGWUM1MUkwd2x3MjRONDdySHZj?=
 =?utf-8?B?cVFsUFgyTXhiNXhncS83Q3RwMHVwSFQ4Vk56VGlNZUZlalVZMHZoY3o5WnlZ?=
 =?utf-8?Q?PmOpO70P6ZZl9bE2yL7ip/g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <19FEAB566F27214593455BB31F911DA7@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6384c718-27e8-4f88-4bf7-08d99e427c7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2021 20:51:04.1115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h4ZAit1YbESc4t3Jbg+WIC3jhrS76jsHpqDUgG320tmiJFKqE/kF5Bi8p/1NkIaGtzxki7PKSPvtpLZS8zYEEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3304
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIxLTExLTAyIGF0IDE2OjExIC0wNDAwLCBTY290dCBNYXloZXcgd3JvdGU6DQo+
IE9uIFR1ZSwgMDIgTm92IDIwMjEsIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gDQo+ID4gSGkg
U2NvdHQsDQo+ID4gDQo+ID4gVGhhbmtzLiBUaGlzIG1vc3RseSBsb29rcyBnb29kLCBidXQgSSBk
byBoYXZlIDEgY29tbWVudCBiZWxvdy4NCj4gPiANCj4gPiBPbiBNb24sIDIwMjEtMTEtMDEgYXQg
MTY6MDYgLTA0MDAsIFNjb3R0IE1heWhldyB3cm90ZToNCj4gPiA+IER1cmluZyB1bW91bnQsIHRo
ZSBzZXNzaW9uIHNsb3QgdGFibGVzIGFyZSBmcmVlZC7CoCBJZiB0aGVyZSBhcmUNCj4gPiA+IG91
dHN0YW5kaW5nIEZSRUVfU1RBVEVJRCB0YXNrcywgYSB1c2UtYWZ0ZXItZnJlZSBhbmQgc2xhYg0K
PiA+ID4gY29ycnVwdGlvbg0KPiA+ID4gY2FuDQo+ID4gPiBvY2N1ciB3aGVuIHJwY19leGl0X3Rh
c2sgY2FsbHMgcnBjX2NhbGxfZG9uZSAtPg0KPiA+ID4gbmZzNDFfc2VxdWVuY2VfZG9uZSAtDQo+
ID4gPiA+IA0KPiA+ID4gbmZzNF9zZXF1ZW5jZV9wcm9jZXNzL25mczQxX3NlcXVlbmNlX2ZyZWVf
c2xvdC4NCj4gPiA+IA0KPiA+ID4gUHJldmVudCB0aGF0IGZyb20gaGFwcGVuaW5nIGJ5IHRha2lu
ZyBhIHJlZmVyZW5jZSBvbiB0aGUNCj4gPiA+IG5mc19jbGllbnQNCj4gPiA+IGluDQo+ID4gPiBu
ZnM0MV9mcmVlX3N0YXRlaWQgYW5kIHB1dHRpbmcgaXQgaW4gbmZzNDFfZnJlZV9zdGF0ZWlkX3Jl
bGVhc2UuDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFNjb3R0IE1heWhldyA8c21heWhl
d0ByZWRoYXQuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiDCoGZzL25mcy9uZnM0cHJvYy5jIHwgMTIg
KysrKysrKysrKystDQo+ID4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9mcy9uZnMvbmZzNHByb2Mu
YyBiL2ZzL25mcy9uZnM0cHJvYy5jDQo+ID4gPiBpbmRleCBlMTIxNGJiNmI3ZWUuLjc2ZTY3ODZi
Nzk3ZSAxMDA2NDQNCj4gPiA+IC0tLSBhL2ZzL25mcy9uZnM0cHJvYy5jDQo+ID4gPiArKysgYi9m
cy9uZnMvbmZzNHByb2MuYw0KPiA+ID4gQEAgLTEwMTQ1LDE4ICsxMDE0NSwyNCBAQCBzdGF0aWMg
dm9pZA0KPiA+ID4gbmZzNDFfZnJlZV9zdGF0ZWlkX3ByZXBhcmUoc3RydWN0IHJwY190YXNrICp0
YXNrLCB2b2lkICpjYWxsZGF0YSkNCj4gPiA+IMKgc3RhdGljIHZvaWQgbmZzNDFfZnJlZV9zdGF0
ZWlkX2RvbmUoc3RydWN0IHJwY190YXNrICp0YXNrLCB2b2lkDQo+ID4gPiAqY2FsbGRhdGEpDQo+
ID4gPiDCoHsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgbmZzX2ZyZWVfc3RhdGVpZF9k
YXRhICpkYXRhID0gY2FsbGRhdGE7DQo+ID4gPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgbmZzX2Ns
aWVudCAqY2xwID0gZGF0YS0+c2VydmVyLT5uZnNfY2xpZW50Ow0KPiA+ID4gwqANCj4gPiA+IMKg
wqDCoMKgwqDCoMKgwqBuZnM0MV9zZXF1ZW5jZV9kb25lKHRhc2ssICZkYXRhLT5yZXMuc2VxX3Jl
cyk7DQo+ID4gPiDCoA0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoHN3aXRjaCAodGFzay0+dGtfc3Rh
dHVzKSB7DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgY2FzZSAtTkZTNEVSUl9ERUxBWToNCj4gPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKG5mczRfYXN5bmNfaGFuZGxlX2Vy
cm9yKHRhc2ssIGRhdGEtPnNlcnZlciwNCj4gPiA+IE5VTEwsDQo+ID4gPiBOVUxMKSA9PSAtRUFH
QUlOKQ0KPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBycGNfcmVzdGFydF9jYWxsX3ByZXBhcmUodGFzayk7DQo+ID4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChyZWZjb3VudF9yZWFkKCZjbHAtPmNs
X2NvdW50KSA+IDEpDQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBycGNfcmVzdGFydF9jYWxsX3ByZXBhcmUodGFzayk7
DQo+ID4gDQo+ID4gRG8gd2UgcmVhbGx5IG5lZWQgdG8gbWFrZSB0aGUgcnBjIHJlc3RhcnQgY2Fs
bCBjb25kaXRpb25hbCBoZXJlPw0KPiA+IE1vc3QNCj4gPiBzZXJ2ZXJzIHByZWZlciB0aGF0IHlv
dSBmaW5pc2ggZnJlZWluZyBzdGF0ZSBiZWZvcmUgY2FsbGluZw0KPiA+IERFU1RST1lfQ0xJRU5U
SUQuDQo+IA0KPiBHb29kIHBvaW50LsKgIE5vLCBpdCdzIG5vdCBuZWNlc3NhcnkuwqAgRG8geW91
IHdhbnQgbWUgdG8gc2VuZCBhIHYyLCBvcg0KPiBjYW4geW91IGFwcGx5IHRoZSBwYXRjaCB3aXRo
b3V0IHRoaXMgaHVuaz8NCj4gDQoNCkNhbiB5b3UgcGxlYXNlIHNlbmQgYSB2Mj8gVGhhbmtzIQ0K
DQo+IC1TY290dA0KPiA+IA0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoH0NCj4gPiA+IMKgfQ0KPiA+
ID4gwqANCj4gPiA+IMKgc3RhdGljIHZvaWQgbmZzNDFfZnJlZV9zdGF0ZWlkX3JlbGVhc2Uodm9p
ZCAqY2FsbGRhdGEpDQo+ID4gPiDCoHsNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBuZnNf
ZnJlZV9zdGF0ZWlkX2RhdGEgKmRhdGEgPSBjYWxsZGF0YTsNCj4gPiA+ICvCoMKgwqDCoMKgwqDC
oHN0cnVjdCBuZnNfY2xpZW50ICpjbHAgPSBkYXRhLT5zZXJ2ZXItPm5mc19jbGllbnQ7DQo+ID4g
PiArDQo+ID4gPiArwqDCoMKgwqDCoMKgwqBuZnNfcHV0X2NsaWVudChjbHApOw0KPiA+ID4gwqDC
oMKgwqDCoMKgwqDCoGtmcmVlKGNhbGxkYXRhKTsNCj4gPiA+IMKgfQ0KPiA+ID4gwqANCj4gPiA+
IEBAIC0xMDE5Myw2ICsxMDE5OSwxMCBAQCBzdGF0aWMgaW50IG5mczQxX2ZyZWVfc3RhdGVpZChz
dHJ1Y3QNCj4gPiA+IG5mc19zZXJ2ZXIgKnNlcnZlciwNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqB9
Ow0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBuZnNfZnJlZV9zdGF0ZWlkX2RhdGEgKmRh
dGE7DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IHJwY190YXNrICp0YXNrOw0KPiA+ID4g
K8KgwqDCoMKgwqDCoMKgc3RydWN0IG5mc19jbGllbnQgKmNscCA9IHNlcnZlci0+bmZzX2NsaWVu
dDsNCj4gPiA+ICsNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoGlmICghcmVmY291bnRfaW5jX25vdF96
ZXJvKCZjbHAtPmNsX2NvdW50KSkNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqByZXR1cm4gLUVJTzsNCj4gPiA+IMKgDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgbmZzNF9zdGF0
ZV9wcm90ZWN0KHNlcnZlci0+bmZzX2NsaWVudCwNCj4gPiA+IE5GU19TUDRfTUFDSF9DUkVEX1NU
QVRFSUQsDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCZ0YXNrX3NldHVw
LnJwY19jbGllbnQsICZtc2cpOw0KPiA+IA0KPiA+IC0tIA0KPiA+IFRyb25kIE15a2xlYnVzdA0K
PiA+IExpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCj4gPiB0cm9uZC5t
eWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQo+ID4gDQo+ID4gDQo+IA0KDQotLSANClRyb25kIE15
a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQu
bXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
