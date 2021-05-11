Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161C537AA67
	for <lists+linux-nfs@lfdr.de>; Tue, 11 May 2021 17:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbhEKPQH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 May 2021 11:16:07 -0400
Received: from mail-bn7nam10on2100.outbound.protection.outlook.com ([40.107.92.100]:45536
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231461AbhEKPQG (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 11 May 2021 11:16:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTI256kWNPH4gFFowuJBq/FINwMLbqi5wlvC29nDj3h+rFSZR+os9FCqvSddSy70X4gL2UpRCB9TG7DnGITfMwOG4wo/Uke0ZEAH3lXxQH9oQsso6ZlgnlRMb/o7MinFh7dsL+2zDJGKqibOfMksU60o6y9zGFbhmYjoj8BiRRfR5lNJTEBpSxRa0E+PjhCmy5DT1vxk1xsZs59YLFQMaZvVBndJQ2X94q97vyy2qaoK27c3YqiSXtNIlOk1VEOI0nDEXCnXAKetTGTphzuPch9pyZUpfo085VMmLby4cXu01TqIuL0d5UEMa1qK4TQOnOkz47IfOXvLZBZfKzbD7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yl5vKn81GVsW4IjwPsZiLNwyjm4RVEXL0FV1O50bTII=;
 b=kARba2lwMy/gfYJIYNignbIGjpCxdrJL80/Nkb31a28BU7MuNWuRsDJyR4CL51OOOk/eQg1OTAf8L17xKY1qukZRXBwruPTy6ly+0QohmHcIPHpfcMw5n495KtGekrKor3rEVO/ah5OV7B8QThfMK7iA8mRqPprOlZ11NzrlH9dfTSIssHbsbQp5AXXcrUfVq++9+t/tYZo6GUGz+wzQ1RNmuySPZyau7OrJ/RiSzTMpbg39OjV2qVXsowneW0hG92udb6tkWl+zGinwiMWRpaQGNkZtOArrZX7Dr8k4TpncDshi6uxTacsZAOYgcihQuoppMOPonPgGOXt1/AQyEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yl5vKn81GVsW4IjwPsZiLNwyjm4RVEXL0FV1O50bTII=;
 b=XgvAtfSYjuow8qjzOtEZ7xgQ3r6PQLrf1/9Sc7RFfcbtJx5h3IHnRpCfaKpSRc9xJhHyWkEE3swOVFEZyaUZ6ozELKoz2BXssdaxPD/EdL0tNeYRZ1AtNzDeeKTRUEGeQvj1xKDOMZEiieExLcI3bgKA25OKFObxRJP1VAs0Yzg=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DM6PR13MB2540.namprd13.prod.outlook.com (2603:10b6:5:ca::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.9; Tue, 11 May
 2021 15:14:57 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18%7]) with mapi id 15.20.4129.024; Tue, 11 May 2021
 15:14:57 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dhowells@redhat.com" <dhowells@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Subject: Re: Extracting out the gss/krb5 support in sunrpc
Thread-Topic: Extracting out the gss/krb5 support in sunrpc
Thread-Index: AQHXRnR+g6lparLg30KMdaSuvml7F6reY+MA
Date:   Tue, 11 May 2021 15:14:57 +0000
Message-ID: <e7050fe7c8952be103cc65e27f63fdb148155672.camel@hammerspace.com>
References: <2581831.1620744410@warthog.procyon.org.uk>
In-Reply-To: <2581831.1620744410@warthog.procyon.org.uk>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5d9d839-5c04-4a11-cbce-08d9148f89f3
x-ms-traffictypediagnostic: DM6PR13MB2540:
x-microsoft-antispam-prvs: <DM6PR13MB254066473BD83199DADC956BB8539@DM6PR13MB2540.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hbepw2qUAWAE0Gf+82gTWuqIhlVYMoYLaI5KrDkIVN2FdNMVdwOtEEPAlhNgguQJeEgb3jmaslT/JhWmEQlDHMwegRMgYkYXiTB8CT1WVjVb3rA2HfuNhstgzuwEntq12/s0wxkuXJxnI1EGUO5AcKNaaSUDNi6s4y/aCrb61OWzTXJBHFYxSkUmY0qgnowHoYbX/uLk4+uEJeqVptWce6bz52pNomjAq+Ket+kFNx0rvsAaYf392YmXKfmHI3Iem38AwYZLKdq+I0nv8Z83tXEQt9buwB5vUfm0qF7crWsqprXyMGLNXdgR1IO8WOPgM0BWA9UuTskbmK5Jd02bcl0R8IkkRj65nUakq7iOEecMQiYp/MfYfIHHIq9ZCFoqE4IugTspzELohZywQDoKNH1HPe9lAvtrPOd85lUxgAMwtPfb+ZZy/gEJiE4ml1+sRAjyaSXyCAejquFzg4h06SI2uJc1BdzRlrf8RJvi+rC4U2vKbyJmFkmPlL2A4SLxwCyNyvbbi9nyDLwwK0ob6dXzgPPAWUaqNL93PVMRY32LutgJKC5R3u0CQN73EZOQQVAr6PhYD5C5o2DO7jhGZlcdfMFefa99xSK8ofHDrtg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(346002)(71200400001)(4326008)(91956017)(8936002)(66476007)(66946007)(54906003)(6916009)(66556008)(64756008)(86362001)(26005)(186003)(4744005)(2906002)(66446008)(76116006)(38100700002)(6506007)(36756003)(83380400001)(2616005)(6512007)(508600001)(5660300002)(8676002)(6486002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZDJDSnNIcWR3WkRPcTZLdHRDejgwMndhamRDcWxOemsxNGJrVC84eEJJTlM4?=
 =?utf-8?B?dkZoSEl4TUZRQzF5UVVFN0dSbWpmSmJwTXBDOElEK3R3ZTZBckZXV1hLS1NO?=
 =?utf-8?B?c1hXb3B1ZTl0MFNDalU5SUxFWDc1VVJCQkl3V1pQQ0lDVzg2dFUxZk1KY1pH?=
 =?utf-8?B?b285bkdDNFU3dHFJMS9zR0xNanRzdE14WGlleEhVbGMwb0oyRGU0WGZVQnhU?=
 =?utf-8?B?bitlUTNXRlZDNXlwOWwzbXY3SGVEQzFUR1JkbnFQUStsNnphS21aTDVrL0hY?=
 =?utf-8?B?L21tZVVFZXFiQTZSTXNPeElHMkxVTktBR2VOTHJmOEVyK01KWXNWRUpNeDVB?=
 =?utf-8?B?R1dXbFJidlRKV21VRHpPdnllaDhWZC84YVFSd0ZvQk0yZGwwdU11M2J4SjZo?=
 =?utf-8?B?UEdhSVFXa1VML0xrSWpGZ0wybnRqMXFCSi9rZmpMMDlzZWNJc0NQQTZJRHN0?=
 =?utf-8?B?OTVZT2l5QnMySXl1aWNMbUR4b1ZjUFp4d0RyNmQxOUU4TUx1OUZYMExwZVBs?=
 =?utf-8?B?UWRmNjBWc1hYeG53Vm9LRzBQc0JRellrd0ttdHJHZW5tcG5obWN1NGFXaDNX?=
 =?utf-8?B?ZDFvelRpRTlXV2pndG5jalVGamF3emRqZmNVYXIvVGdkV3RIVzFDUExnVHdP?=
 =?utf-8?B?dituSTcydndNeEcwR3NEM2xkVGdiaDExb2VVY1J0RGUvUzhiNnFqZVAyK1FK?=
 =?utf-8?B?cmxldTdwL1FsT0NoMnhZZ21rUitTaHltM2NueERZejlyMzdFVWE5cEQwTE91?=
 =?utf-8?B?U1g2R2FvbWlNdGhJZDJ2ZGxCL3kwd1lEVm05SkpwdVNHcis1NGs0T3AyZFlV?=
 =?utf-8?B?M0o5WkRxQklHT2JKOWo4cXhTUHYydUlTV0FSbHljL2NFdGZUaEtScUI4UmlF?=
 =?utf-8?B?OS9WTzZYeG9TN3l1ZDlkM2U3KzdhMFB1Wjl6OGdRUnpuNEVlSVZ0Ri9VWEdu?=
 =?utf-8?B?NmNheHFsQXVuck5oUTh0UHRtVXN3UGdoakRGWGVYMVdJdy96cHBGOStCaUNk?=
 =?utf-8?B?SU9DeUJGT2dKNUhvS1VrN3ZET3U2Y3kvZiswM0FqazZvUUp0R2NWWitwT3RR?=
 =?utf-8?B?YnpDNGN3L0NQRTRrTW5IR0ZocmRCbnpkZWN3YXFDRFNTV3lPSUtuZnpPK0ZM?=
 =?utf-8?B?Q3ZwWVhmNkRKUjlCeXB0UkgxektaT2tDL1dZUVp5M2FKVmYyUWY5VnR1S0t4?=
 =?utf-8?B?eTVmanNMZHdjTWo3VjZNdUpKNmgxZHE2bzZzTERQbGxsTzh5U2FOcWtYV2ZE?=
 =?utf-8?B?eHdKT0FkNExEaDZVS1dleEVPVmdiN05KNWRQd1pFWldJZVpMOEJYaTJ1cFBo?=
 =?utf-8?B?UzZWa0d2S0lNVW1CZXpncnA1R3lROEl5R1VhUG5sT2FINzA2WHB1d1BCL1FF?=
 =?utf-8?B?MXdpWTdjdHhDQ1FQMUFuajlsaHBCZFBKandGWFc2QUJQRlQ0dDFTOHExbkxN?=
 =?utf-8?B?TkY1YXYvZ3RzMFp2R3NtWEJ3NnQzUjRrOFdGU1lOcDJ0eGpuaWJvMFIveDJ3?=
 =?utf-8?B?YkdUTmZhb0xlcmFQT1lpdlIyU2N4amE4cDRPc3Jxa1VxMTdBTVVlTEo2MzVY?=
 =?utf-8?B?L0NycjZ2TEQ1aWNsNC85MGRIeUNGZHE5RlMvdzVBNFpCdGFCTUt1WlZkVVcv?=
 =?utf-8?B?SzRuZWN0YVhuTFd2aVlrV0JabytJMTJNRU55c1loYTRVZmo5eGVaVE1uUlB4?=
 =?utf-8?B?R1QrbHVkQXZUejJNbytLOGRlc3R3RFRhY3JjVzBaR3laT1Npbk5vSmhvdXFt?=
 =?utf-8?Q?lW/W6CzSkHhQAkuMRPEPevKdvT4RFHISARV9vSg?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C243763A7DCF5B4FA2A1790888DF81EC@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d9d839-5c04-4a11-cbce-08d9148f89f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 15:14:57.5910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 64rqGahS7gKuukcLYRpFNwy9Ivl+4WoXYDdWnMyg7F69qx0kxbQMHhfUpUEXG4N+HEY0nNPH5IVPFai/fpkwtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB2540
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIxLTA1LTExIGF0IDE1OjQ2ICswMTAwLCBEYXZpZCBIb3dlbGxzIHdyb3RlOg0K
PiBIaSBUcm9uZCwNCj4gDQo+IEknbSBsb29raW5nIGF0IGV4dHJhY3Rpbmcgb3V0IHRoZSBnc3Nh
cGkva3JiNSBzdXBwb3J0IGZyb20gdGhlIHN1bnJwYw0KPiBwYWNrYWdlDQo+IGluIHRoZSBrZXJu
ZWwgaW50byBhIGNvbW1vbiBsaWJyYXJ5IHVuZGVyIGNyeXB0by8gc28gdGhhdCBhZnMgKGFuZA0K
PiBhbnlvbmUgZWxzZQ0KPiAtIGNpZnMsIG1heWJlKSBjYW4gdXNlIGl0IHRvby7CoCBBcmUgeW91
IHdpbGxpbmcgdG8gZW50ZXJ0YWluIHRoYXQNCj4gaWRlYSAtIG9yIGlzDQo+IHRoYXQgYSBkZWZp
bml0ZSBubyBmb3IgeW91Pw0KPiANCj4gRGF2aWQNCj4gDQoNCk1vdmluZyB0aGUgY29kZSBvdXQg
b2YgbmV0L3N1bnJwYyBpbnRvIGEgc2hhcmVkIGRpcmVjdG9yeSB3b3VsZCBiZSBmaW5lDQp3aXRo
IG1lLg0KTm90ZSwgdGhvdWdoLCB0aGF0IHdoYXQncyB0aGVyZSBpcyBhIHJhdGhlciBvbGQgcG9y
dCBvZiB0aGUgTUlUDQprZXJiZXJvcyBsaWJyYXJ5IHRoYXQgd2FzIGRvbmUgYnkgQ0lUSSBhcm91
bmQgMjAwMS8yMDAyIChJSVJDKSwgc28gaXQNCm1pZ2h0IGJlIGR1ZSBmb3IgYW4gdXBkYXRlIGF0
IHNvbWUgcG9pbnQuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1h
aW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoN
Cg0K
