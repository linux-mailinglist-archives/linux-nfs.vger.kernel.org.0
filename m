Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6746542EAEE
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Oct 2021 10:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236527AbhJOIFs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Oct 2021 04:05:48 -0400
Received: from mail-mw2nam10on2129.outbound.protection.outlook.com ([40.107.94.129]:38753
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236475AbhJOIFo (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 15 Oct 2021 04:05:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJyN+/eMYseH1VtVDzOmiZom0ZBX9hxvrnuNv1AQo9pC56lJkoKeleV9xhniWqKzPmTGV464wmEZLVedAEdMZ2C4WgURcL6J5zR0n1kI425HMnRqOOuhW0V2wjEkJbviAJW8XdaLfU/YDgtc8LTqB+Yfyy+hArkG39FUu9m87HaRn0X98G2K1OfUcBqmRGpdMUaY2REqovJ680KKved+ntrRnt1j4yuGH4LGAUCxVJslpqarabpgZS3MqIpYE11EjLOSKBmaxb61BPTLlQlQPUIGBZWzSLmFXGFfKy9B2M348oM7MZYsY+c+EdvCR+Ogp/DbzwqpkYQ0UAkwPullnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7iw6IU4d254WzSTIknRlTxtued0SycR5ORYFiQDXlM=;
 b=WZK1WoAlyMvAp5l1JUDJG4EY7MZ4tIqdPlZT4t29zvF+QqVSRCzAyyCy4JvzEZj4S6TII/DlyFLhsBVHKHTiAwhJ31/IEp2BHBmxLK+ylZ61479CQISeDtfIJMGAU+mrCHN3zDuBWIV1oa7Mfcif/gEB52tbfCaMVg91Xmwy3sRNwzextnI6OIijUo7KKiptXCRBf9+94ikD0WxMnx1q5esua1koug2SUcn2G0toFXrwrBCGOyMZN/N/6MmbzTXg4yVi+/m6YxxUS7VGRV+Lflra7b/LlbtNQqyRzyoBCNWxosTUFj3K4WSyoTviWzl/eHRWFPn8IOrOH6Um1hmMkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7iw6IU4d254WzSTIknRlTxtued0SycR5ORYFiQDXlM=;
 b=UJW7mcNyp9G1yEGV/iwUA4lJeVFFPAS90mXtQqvgEzOAYIYUurWTWEcUYvU9AqxHSaHv2xhoKHafPSofVtzlvUsn3oFh8SYoVckVVoVFoI0vYPUMRMfe9YgDTec3W471cC5vDHQsB1n8PaIgkMHEJz0PLH6cFsp/74Y/UANZcss=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3750.namprd13.prod.outlook.com (2603:10b6:610:93::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.8; Fri, 15 Oct
 2021 08:03:24 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1533:4550:d876:1486]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1533:4550:d876:1486%7]) with mapi id 15.20.4608.016; Fri, 15 Oct 2021
 08:03:24 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "neilb@suse.de" <neilb@suse.de>
CC:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "smayhew@redhat.com" <smayhew@redhat.com>,
        "tpearson@raptorengineering.com" <tpearson@raptorengineering.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy load
Thread-Topic: CPU stall, eventual host hang with BTRFS + NFS under heavy load
Thread-Index: xSdTgH983VDBQkCAmg52fDts9flGRuB0AHyAgAQPnwCAAHMZgIBZgYoAgAFhwQCAAvGUAIAAI06AgABZrYCABMHGAIAABCUAgACaRYA=
Date:   Fri, 15 Oct 2021 08:03:23 +0000
Message-ID: <f2ebce6afe1d01b529a9373ecfba1dc8b3009b4c.camel@hammerspace.com>
References: <281642234.3818.1625478269194.JavaMail.zimbra@raptorengineeringinc.com>     ,
 <162855621114.22632.14151019687856585770@noble.neil.brown.name>        ,
 <20210812144428.GA9536@fieldses.org>   ,
 <162880418532.15074.7140645794203395299@noble.neil.brown.name> ,
 <YWCpnsdVqssFaLrf@aion.usersys.redhat.com>     ,
 <589AFA4F-DF8E-45A3-8299-54E820E33169@oracle.com>      ,
 <20211011143028.GB22387@fieldses.org>  ,
 <34A4C7EB-2798-4482-A786-90161F5F9E34@oracle.com>      ,
 <163398946770.17149.14605560717849885454@noble.neil.brown.name>        ,
 <d795d4d7caaeebbf2f2260b7e739e9dc2f8a1de0.camel@hammerspace.com>
         <163425187213.17149.4082212844733494965@noble.neil.brown.name>
In-Reply-To: <163425187213.17149.4082212844733494965@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27644486-48a1-4d90-1165-08d98fb2430e
x-ms-traffictypediagnostic: CH2PR13MB3750:
x-microsoft-antispam-prvs: <CH2PR13MB3750996925B048377B86C67EB8B99@CH2PR13MB3750.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RkHlRuu3nzbHjvxYjqBIBSaDNxR5Z8EDLEBH62XkDPwUTYsisehN9+51ga7wJy0NT6/xoY/YfcAlG9TZJDOiKqecstE2dvCiYj2x9plqalkmoqBiY1OUznqFMvF44ZsibsUdudsKAWftfnkwgvyMlPCQNh/fhyLhVYRvFw7MRxUbMdyW2FsJ5IpsplCRoVVRRDn0Ar2nYpTIJfgc6UFmSbFAg4IbWr5a9m+Dsee+BGgkAoz8aotZsWYLBjYTEFyIBDyl2+zDd5Gy8KedC5G+9DkyWBy4QeGCcx6ew8DVc50I/uUVoy8EhymtW4HfPLzbiSyrE9ECvYmdHyvYzmCb4lLG5e57Sr9e4GKFH0DUzZ7hwVQzXjso8g7jhrNiSbxKYt1h2o1f+Ko4XCqVtiJa9+KezNzLNYrMPMhTUYjpJfGbzxLVugDPNvBZTWPc4jCRJTmRp+nlsRXe/FMEZOTHBmgzkEqNm7RIAzLrvgTrcShcKjJFk2XjplZmk/vc8ySD5eGr9p6AvObIPuYFGwz++UZSx/xsUO9HQnhmvxF92+lpjzMPjFWHUoXvSbkVPU+ycPFweWYpYDEIYEXBFZgrfcMUG9BzoIYmTwen2QZEwt8/rnnr3tAqBhEaCrvqL2VtWn9KRZGQhrviXDMbTiFDxX7PIiHhZPNpK5z2fkBVole3wX0X72EUeRzbQf/4Vb6AO1WJeZIHS/zjNmBIxQhs/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(4001150100001)(8676002)(36756003)(38070700005)(2616005)(66476007)(91956017)(316002)(71200400001)(66446008)(66556008)(64756008)(26005)(8936002)(54906003)(186003)(6916009)(76116006)(66946007)(6486002)(6506007)(5660300002)(122000001)(38100700002)(2906002)(508600001)(83380400001)(86362001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnJSTnJFdXVvQ3VNMWxMVVhDUm9nNiswK1pmT25ObnVBYkw5YXFDRVNkQkRV?=
 =?utf-8?B?aitPYjlwQ1JIMk1wZkFoV1RWb241c1JLUm9jbXNINUVmUU4ybHQxdkI1dTRq?=
 =?utf-8?B?SnRqa0JFUDdxY0tSbG5Nd2xEciswSXI4eWdUSTl2QmlxY05KdzVXYXNoTlhT?=
 =?utf-8?B?SVFnZzI1SEE4S0VVVUk5OU44VWtwc1FtNktMVmZGdmdkY3BDZCt1NHkrYXFC?=
 =?utf-8?B?QmgrZ1d1TGlFZGllTzcyWnN2bHhNS2tZL2tId1JKQktNK1QvcHU1WGZzYWJj?=
 =?utf-8?B?bDJDODlDY3BOUmNlU1d2YUQzVm1MRnNrVkl5YmxYSmhWR3NiQSswT0l0Z3c1?=
 =?utf-8?B?YlIzaHg1WnFEK3VjUG9jSlFudlNRWk5qamowWVZIY05oVzhTdmljVEJHNkd4?=
 =?utf-8?B?bGZwY04zdUZWS29ac1EyaDNzREdyTWU1Ym5sUDB4eG12djg4ZDZwVDRDSXFP?=
 =?utf-8?B?OUZpMzJMR2kyMThhTWJBb21mVEZzb0xyZWNySUdBd2ROSHZCMjBXSU1US2tE?=
 =?utf-8?B?VzZOcldHK0dsOXdhMVB3YUtMQ1pzY0VwaWI4R3g2Si8xR1E0bWtTaDlMdkZP?=
 =?utf-8?B?WWVpcGkvdmJBNkVTU3JaREZsU3hyem9PZjNwY1RiNkVjQjlBWXNmbk1HTTNj?=
 =?utf-8?B?RXpreFI0eVJQaDdIdW1GakxsTWIvcVl1SDJ0SXNFQTR1TEx4emxrTEJnRklX?=
 =?utf-8?B?c3Rwd3ZnU2dIYVlXWityUlZHWFdkYkhjbXQvcUVaYmNMa0FwQ2w1VmRWS0Q0?=
 =?utf-8?B?aDZuVTlPZGhTOWR6VmNXYzVpcEZvQ0EwaktsYUV3ZUN1WFVXVFpTcjRENWlv?=
 =?utf-8?B?NDNSRHBQdVU4bkxETU9ja3NVa1dHNFZDOWlONGplZ0ZiZnZMUTY4SFBGN2l6?=
 =?utf-8?B?R3hsN2xQQXp2Z1cvNjZLSEtqOExKYWJ3YndHTHVZSkk4MHZEZGFWd2pCa1Q4?=
 =?utf-8?B?M3NsOHNZWEs5Njg1ZS9XUXE5MGJrc2V2cnh6Zks3bkk0SVJoUStYTGVWdG9X?=
 =?utf-8?B?WDdBUmtrRXFFVStJc0FFVzRZNFBjUHhHT2dDcm9sQlZZTnM3NXhjS0w3d3FC?=
 =?utf-8?B?dHhERlBQdkFQSWkvb1k0YnJDbEw0TzlqeDF6aFVVaklNSEtsRzVwSWVCWkhj?=
 =?utf-8?B?SHJ0VzJBSWFmcEJtK1psdUxldE5SR1JadUZETld6MjFBTTBKWStXSWY4MFA0?=
 =?utf-8?B?bXNjamp5SmY4ZkFMcjNGM0szbGY2MlVrWWJReHNOL2FTdFRwbVY2eEhSemU0?=
 =?utf-8?B?RzQwM1JjQVpsdktqOHAyUkxJcGNqWTRrcVEyaFlBQ3J5aXZrWUlzMXU4YWdS?=
 =?utf-8?B?YkdZbTNSQm4xRUpoaHFCVURsOVdwZTdRL3F6eHZUbENKUDQvK01UbXc0Yjdx?=
 =?utf-8?B?bDhwRHdRYnNIRUdXZlJBL3JWdVZyZy9MMDJJUEc5SDFrOHZ0ckJmK2hFQlRE?=
 =?utf-8?B?RDhxcS9qaVpnNEZ3ZFJDMWIxN1FRUkJVL1pnRW41dTB6TzM1UTl5NlN4NWd3?=
 =?utf-8?B?NUFpRDlGUUlmMk0vUENFc3EzVTF6dVBEam9GUytvT3ZKUkhYZ3lWTDhTZzk3?=
 =?utf-8?B?ellybU1TUDlCMFlaby9GU1poV21jQlVEUWVTdDhwVUIvei90SCtEQUJsZ2hn?=
 =?utf-8?B?TkN4V0VLL1pxWVo0a3U1REJieGRtcXNzOUxzeWdMQXJwVGJCNHdnMmdrWHNU?=
 =?utf-8?B?UE8wQzBxZmhPM1RISVh1RExXek11Yjc5N2FqdUFlSkpvUitNUGIyVWlycmo5?=
 =?utf-8?B?QTRRMmd2YkdibS9vaFZqMXQyUDlJWFd6YUY2YjRmanZtd1UvblVTQzArNnR0?=
 =?utf-8?B?amtvQ0Vab09ZM0hkRlBMMkdnc0FSRFFON1pQZ1NrMFVWalNXcFZkd251L3p2?=
 =?utf-8?B?anhVcS9YQUpkUlQ4M0M1WGZKZ2ZJNUU3NFF0Nmt4YnVLWEdkMWJGWDdDZkFF?=
 =?utf-8?B?dFNDNGU1cDdQVTh0cE9iaWxXZ2NkbzhoUDRTUDVUQm5RYWVLaFZzdTB5Q1ph?=
 =?utf-8?B?OG5kSlVSR1VpS29yRnI0aEp6NnBjQTkvMmtVZ2RMRHZMTW5pdFdaOHEwWUwr?=
 =?utf-8?B?NUZpcDB1RGh3ZzFQUnhZSW9NaGY0RzN5YnRQQW5Hblg1ZWJ0WkgwY1FHdlhW?=
 =?utf-8?B?c0tRaUhaT09WTXJqendSRy9JTWovRXlOMGNsS3hjWnhYVVhvOWxZcDFucktI?=
 =?utf-8?Q?Oht7kg3pl2QaG3RdgqJJzWc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA5A1D206E6E344F9C5E2A5BD7EA87A6@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27644486-48a1-4d90-1165-08d98fb2430e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2021 08:03:23.9814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +8t+zugtPQaPjMpnaRkkIsbZDYrF4uj2CDfov96w7m7TDHLuqI+xqIWtTgl8CuAqrY9LKyUCqTQi76xF/lK6wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3750
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIxLTEwLTE1IGF0IDA5OjUxICsxMTAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IEZyaSwgMTUgT2N0IDIwMjEsIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiBPbiBUdWUsIDIw
MjEtMTAtMTIgYXQgMDg6NTcgKzExMDAsIE5laWxCcm93biB3cm90ZToNCj4gPiA+IE9uIFR1ZSwg
MTIgT2N0IDIwMjEsIENodWNrIExldmVyIElJSSB3cm90ZToNCj4gPiA+ID4gDQo+ID4gPiA+IFNj
b3R0IHNlZW1zIHdlbGwgcG9zaXRpb25lZCB0byBpZGVudGlmeSBhIHJlcHJvZHVjZXIuIE1heWJl
IHdlDQo+ID4gPiA+IGNhbiBnaXZlIGhpbSBzb21lIGxpa2VseSBjYW5kaWRhdGVzIGZvciBwb3Nz
aWJsZSBidWdzIHRvDQo+ID4gPiA+IGV4cGxvcmUNCj4gPiA+ID4gZmlyc3QuDQo+ID4gPiANCj4g
PiA+IEhhcyB0aGlzIHBhdGNoIGJlZW4gdHJpZWQ/DQo+ID4gPiANCj4gPiA+IE5laWxCcm93bg0K
PiA+ID4gDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9uZXQvc3VucnBjL3NjaGVkLmMgYi9u
ZXQvc3VucnBjL3NjaGVkLmMNCj4gPiA+IGluZGV4IGMwNDVmNjNkMTFmYS4uMzA4ZjU5NjFjYjc4
IDEwMDY0NA0KPiA+ID4gLS0tIGEvbmV0L3N1bnJwYy9zY2hlZC5jDQo+ID4gPiArKysgYi9uZXQv
c3VucnBjL3NjaGVkLmMNCj4gPiA+IEBAIC04MTQsNiArODE0LDcgQEAgcnBjX3Jlc2V0X3Rhc2tf
c3RhdGlzdGljcyhzdHJ1Y3QgcnBjX3Rhc2sNCj4gPiA+ICp0YXNrKQ0KPiA+ID4gwqB7DQo+ID4g
PiDCoMKgwqDCoMKgwqDCoMKgdGFzay0+dGtfdGltZW91dHMgPSAwOw0KPiA+ID4gwqDCoMKgwqDC
oMKgwqDCoHRhc2stPnRrX2ZsYWdzICY9IH4oUlBDX0NBTExfTUFKT1JTRUVOfFJQQ19UQVNLX1NF
TlQpOw0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgY2xlYXJfYml0KFJQQ19UQVNLX1NJR05BTExFRCwg
JnRhc2stPnRrX3J1bnN0YXRlKTsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqBycGNfaW5pdF90YXNr
X3N0DQo+ID4gDQo+ID4gV2Ugc2hvdWxkbid0IGF1dG9tYXRpY2FsbHkgInVuc2lnbmFsIiBhIHRh
c2sgb25jZSBpdCBoYXMgYmVlbiB0b2xkDQo+ID4gdG8NCj4gPiBkaWUuIFRoZSBjb3JyZWN0IHRo
aW5nIHRvIGRvIGhlcmUgc2hvdWxkIHJhdGhlciBiZSB0byBjaGFuZ2UNCj4gPiBycGNfcmVzdGFy
dF9jYWxsKCkgdG8gZXhpdCBlYXJseSBpZiB0aGUgdGFzayB3YXMgc2lnbmFsbGVkLg0KPiA+IA0K
PiANCj4gTWF5YmUuwqAgSXQgZGVwZW5kcyBvbiBleGFjdGx5IHdoYXQgdGhlIHNpZ25hbCBtZWFu
dA0KPiAocnBjX2tpbGxhbGxfdGFza3MoKQ0KPiBpcyBhIGJpdCBkaWZmZXJlbnQgZnJvbSBnZXR0
aW5nIGEgU0lHS0lMTCksIGFuZCBleGFjdGx5IHdoYXQgdGhlIHRhc2sNCj4gaXMNCj4gdHJ5aW5n
IHRvIGFjaGlldmUuDQo+IA0KPiBCZWZvcmUgQ29tbWl0IGFlNjdiZDM4MjFiYiAoIlNVTlJQQzog
Rml4IHVwIHRhc2sgc2lnbmFsbGluZyIpDQo+IHRoYXQgaXMgZXhhY3RseSB3aGF0IHdlIGRpZC4N
Cj4gSWYgd2Ugd2FudCB0byBjaGFuZ2UgdGhlIGJlaGF2aW91ciBvZiBhIHRhc2sgcmVzcG9uZGlu
ZyB0bw0KPiBycGNfa2lsbGFsbF90YXNrcygpLCB3ZSBzaG91bGQgY2xlYXJseSBqdXN0aWZ5IGl0
IGluIGEgcGF0Y2ggZG9pbmcNCj4gZXhhY3RseSB0aGF0Lg0KPiANCg0KVGhlIGludGVudGlvbiBi
ZWhpbmQgcnBjX2tpbGxhbGxfdGFza3MoKSBuZXZlciBjaGFuZ2VkLCB3aGljaCBpcyB3aHkgaXQN
CmlzIGxpc3RlZCBpbiBuZnNfZXJyb3JfaXNfZmF0YWwoKS4gSSdtIG5vdCBhd2FyZSBvZiBhbnkg
Y2FzZSB3aGVyZSB3ZQ0KZGVsaWJlcmF0ZWx5IG92ZXJyaWRlIGluIG9yZGVyIHRvIHJlc3RhcnQg
dGhlIFJQQyBjYWxsIG9uIGFuDQpFUkVTVEFSVFNZUyBlcnJvci4NCg0KLS0gDQpUcm9uZCBNeWts
ZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15
a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
