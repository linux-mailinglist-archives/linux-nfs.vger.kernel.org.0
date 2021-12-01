Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39FC746568A
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Dec 2021 20:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245251AbhLATjO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Dec 2021 14:39:14 -0500
Received: from mail-dm6nam11on2103.outbound.protection.outlook.com ([40.107.223.103]:63872
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234430AbhLATjN (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 1 Dec 2021 14:39:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcbjEtpsH2VJbBmWeLItTRr3gE5HDKp8XXJItTHb1vpGskDRvlZ7K6S0oj3a9Etvfm6NT+sLdJXpcwCbT2BQufk4NU45rutQnUA4BwUP5t5VVgtBkP7y2iTqZz7nOpn+KYu0fZimv2ehpvjGswZzfsBupFc2zYe1wK5/I09R8No9V+sVhFyhEPdwonmV+tVPkq7c1/4cqQcNWN61WyvmkeYrPuSG9lgrd9lYkiiPSgrToIKFMl5xQ6Da98K6xvL6NEm40R7XFDwIhCRAD4zBW3ed4Og/tnFdx5fjdAkMadu+QZRbtF7rK+l4lPxD5s6xmrcRcoU+9yrXwrGbn2f3DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MyBzKL1/bXemdCghfLJ9t5mK6B/kMrId8GWIjMZmgZg=;
 b=f7CY7gZK2j3ZjfMVXvG2qWRuj0aOw/C40XXM851KtXu1Ee3/3OdYqOdVB+r2wZlHxPaDY0atvMeHgHG+7vzze4dPHEgXaAUB4EHE8xEcpQtnOjFSBIsO5CbEOQheCx7vIBF+j+0Xj3wJCCrLWZaQy0pburNOJnc2IK88Gz1D07XuqvpdUcDow2gt6KS5zesl/gWT91zzQ/JgRV05iucKIVHI4sH/bYjifiC31ZTrpzJc09eYC4Sqh0C/yuoxwORA5FdhizJVfUDDUhtvYk357kNtgfLlTAqGkZvalXqMvD3E8vFd+n1ztekC5/OpA2yNp3izmRGGOd6Zh4yEIGhItQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyBzKL1/bXemdCghfLJ9t5mK6B/kMrId8GWIjMZmgZg=;
 b=fq96L4HFwMQ3DtHeea9RbwzWS2nbMViU990KDgedp37n5fICDQIxkdYhJkMugOklpoSb2zPlh1ji8a8C6REdFF6Ni/Az5FLPmv/eoCYwYaSHSuz/FW73KCjG9njvn4FLqkW6EBX4UaZzQFFF/4mNmtWl5bCgYWr4UWFjoZ+U0ck=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB4503.namprd13.prod.outlook.com (2603:10b6:610:c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.10; Wed, 1 Dec
 2021 19:35:50 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08%3]) with mapi id 15.20.4755.012; Wed, 1 Dec 2021
 19:35:50 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "smayhew@redhat.com" <smayhew@redhat.com>
CC:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "tpearson@raptorengineering.com" <tpearson@raptorengineering.com>,
        "neilb@suse.de" <neilb@suse.de>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy load
Thread-Topic: CPU stall, eventual host hang with BTRFS + NFS under heavy load
Thread-Index: xSdTgH983VDBQkCAmg52fDts9flGRuB0AHyAgAQPnwCAAHMZgIBZgYoAgAFhwQCAAvGUAIAAI06AgABZrYCABMHGAIAABCUAgACaRYCAAACpgIBKjfCAgAAQcgA=
Date:   Wed, 1 Dec 2021 19:35:50 +0000
Message-ID: <f9b305425209e99aa73417823e82cf7ce56b0141.camel@hammerspace.com>
References: <162880418532.15074.7140645794203395299@noble.neil.brown.name>
         <YWCpnsdVqssFaLrf@aion.usersys.redhat.com>
         <589AFA4F-DF8E-45A3-8299-54E820E33169@oracle.com>
         <20211011143028.GB22387@fieldses.org>
         <34A4C7EB-2798-4482-A786-90161F5F9E34@oracle.com>
         <163398946770.17149.14605560717849885454@noble.neil.brown.name>
         <d795d4d7caaeebbf2f2260b7e739e9dc2f8a1de0.camel@hammerspace.com>
         <163425187213.17149.4082212844733494965@noble.neil.brown.name>
         <f2ebce6afe1d01b529a9373ecfba1dc8b3009b4c.camel@hammerspace.com>
         <8bc8cad158234aca0448ab1c8410880daff3c278.camel@hammerspace.com>
         <YafAyS/0AQS1QBKy@aion.usersys.redhat.com>
In-Reply-To: <YafAyS/0AQS1QBKy@aion.usersys.redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 546498f3-a6e5-423e-be3b-08d9b501c825
x-ms-traffictypediagnostic: CH2PR13MB4503:
x-microsoft-antispam-prvs: <CH2PR13MB450303DA15195895167CD3FAB8689@CH2PR13MB4503.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NpJwGXKwKQZI3o7Int+TDVP2HAenoPiWMCgYmCS+s2Zgb8iPBY+o2jTyrfPbCi3nHF2YPoEBpzCq21PBMPUU0ivAApgpQq5pkMjih4BwoyTa10KlaYr3iW/6ZQ1l4+O+kmI1ARtTHAu+zqDD0zVD8ZsvlFwKiQrlDyqNQ2xTReG10zwR+2f/QNiSQK020jGmkXKfzMrbvUgIi5zofbae/pTorNlfvGYoQpF2SS8dKnBPTgSq0AX8sGEd55mX159gVyAV0fQTSXgfYvW+/sQGevK6Xtbomm263v3Z5iuzYVm1HhXNbFVUePuqwco3l1DszRDZNZefiBrWy63IJoYz4yff28NxWrZIQZAy+vLCneN05c1S6LlHYtwJYB10zq/dNOFyjjQGjeyLHY2dPbanEM57csXxhcPKHwyrczhXM9mAFNhiqJFI4jkRYEPPDBdH4NmTKxgiBeMt7fD1XAaEu7jEK2CCV0feqBPe3pskLMuImBLFqSCWadBQQ3diM5zsc6jLZumsxsMTEfw0ijnlgN1SQ+Q4rRmvQRR9FcQ2iKuuaqF8SgkGDWmAFV+l8Twl10AojzvcRE7Bms3cw3PLNuIGxPRs5sLgJ8jPrc1Ii6LeFS3SX2U8bb59HYBMbbvpvhF57VhLorZ9JYd2wrXDXgb36W+8qohje7ZbOyexkg4WnvMQSA/TcTE0/ID8clG2AIQxV+AX+9Bg0vGwnmowqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(39830400003)(396003)(346002)(136003)(6916009)(122000001)(2616005)(316002)(5660300002)(508600001)(83380400001)(86362001)(4001150100001)(54906003)(66446008)(64756008)(66476007)(66556008)(6506007)(6512007)(38100700002)(76116006)(71200400001)(36756003)(66946007)(26005)(186003)(38070700005)(2906002)(4326008)(6486002)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZnBOcnNKWjBlWGtXUHpxM0QvYis4Z1JHdlQ0Nk5WNWlKY3dtK3FISzJKSUFm?=
 =?utf-8?B?OC96d0RwMGlqb01WZm11RDBPUXFCcVc5QzVKb2JNa1dxamxRN3ZibE9RZVor?=
 =?utf-8?B?UGkxNFFnSEVPNjRTWkRrRjlzc2tmb09Qd1hJTlNDcDBuMmtIbVlKNDZJNUs2?=
 =?utf-8?B?NGRjRHF2YVMxeEVwbUtmbUpETGN3dXdXWjhGSHRJb2p1eTF1TWFveG1xblFq?=
 =?utf-8?B?NjVnY1V6bi9lUEtZZFNOQWRSQS9hTHBoNGtPdXlsYkZlWWVpc0FNamlxNGFw?=
 =?utf-8?B?cHc0U0hjT0JGQ0FjbWJrSk5wak92Tm5RNnVCT1NHQ2FVVjZOMkVod2wvQVRr?=
 =?utf-8?B?UFRkNG1VTHU1OWRwTnUwZ3ZVMU9iRm5vOFh4ckU2S1hLNFNSeUpTMHVqVW81?=
 =?utf-8?B?a2dIYVJFVWVYTjF5blFTSmh1RUs1QkRPY0F0cmRncnp6UktvRVprdDZteTV2?=
 =?utf-8?B?STVRK1FHaFBhcElSL093QUlGY0NoQkcycVhJYndUSldGUUhQOVZWaFR6K3cz?=
 =?utf-8?B?UlYxbHU1RkI3ZXdGUnlOK05NOFpPOEpMSTAyK3Z0Y1NKU3VOaTRDNXdqa2Vk?=
 =?utf-8?B?dkxBWHRzcGQrelRRckdHNnpnNzNpczFyUmhLcFdhOWNtbXhTY2JLVm9EUU11?=
 =?utf-8?B?Z0FwUnYwMVVrTFRjUmh3Q0JsbWh2NS80eExHbzVCQU5zRHg0elJOdHkxK1Fu?=
 =?utf-8?B?Y1RjKzlNUlV0MjBYSERpU0REVVdiK0dlK0h6Nk1YcXdPenZNTmZ6NHVmZHNF?=
 =?utf-8?B?bWI4T3B1bTYrNEhRRk45bEppaVNoMUNydUxuNy9pbkl2eS9OTzc1OXh6R0tr?=
 =?utf-8?B?d3ozWHpFckxBSC9rdStHamRpdG9vbDZqQVlTbHpHU0NUdjhyOGZ2VXZpdlVO?=
 =?utf-8?B?dERERFlGc20xZ1FCa0ZOcXh3UFBETllqZ2gwamdPVWVMSndFTllxQmdnS1Nm?=
 =?utf-8?B?emQwRHdGeEFUVCtMWjd1RzBlQk5QSXFyQzJ0SVppZjA0SkMwcE45b1BCd0Ro?=
 =?utf-8?B?ZSs2NVVSaDNyNnNLWmlKeGZQQ05sS1dCVndJak1iNE5JUGVmdjVreWNGTnBm?=
 =?utf-8?B?cDVBOHdSUE1PdC9aK09US2l1b0lvUkFhcHJBcUpTL1hWYXFMaUhNUEY5dzVv?=
 =?utf-8?B?OVNjakVnY2xPeUF0cE1Mak83YVNUZDVHVzgrQmI2ZzJIZlFVSlQxQ3JYRlhw?=
 =?utf-8?B?NGUwWTlhV1d3S09TeHdKRVgzdkRwMkR0RXdpVHdTUTFEQXJWQUpkRlF2eDBU?=
 =?utf-8?B?QnFDalAyNHBrQlhuNjEzNU1CbitaZFVKSkFtRFpkTXhzbnVicklQclVBVHpt?=
 =?utf-8?B?c0hnalVkd1BnRVJuTnhaVXRKc2FnQ1VqQ293b243RWsvU2xjSHBrSGpYcndx?=
 =?utf-8?B?VnRCUDk0bEp2bkNKMVpZYzhxTkppMmhidGhQVzJPN0xmMDRLc01SQkF3a01s?=
 =?utf-8?B?ejFwSVZEd3FQQytlU1cxTVE5ZmMwL2svNFJ2Ni9DelhXck1nRVpMbTJSb2xw?=
 =?utf-8?B?NFZySmVLRmNSSEVqOERWejhvL0hNMEtRL05zWlF1TmpxMjRjcHFQVEZoWlhG?=
 =?utf-8?B?WkpCMWxWb1pkYmVUYkZpbmdwNnhkOW1yaXRSR3AzNTJZMDNpd0JYbDlZOHhF?=
 =?utf-8?B?RlJTY3F3K3VKV0hPdEQ2Wk9XYjZib3o1SzFSOXJNL0dFZi9RRGdxNHJHdXE1?=
 =?utf-8?B?YTlveWRoNTFXMm91T1ppTTFhNmFkK29yRjFXS1dkdGFPQVFsb2hHb05oRlQ0?=
 =?utf-8?B?Y2U5U2hkUFlSMG1CdHRLVjdlZDZvNE1UQ3ZIM1dSeCt0Q2dxQlVKTVNoa2ha?=
 =?utf-8?B?VVg3WlE5QkZ1Tm1qVkVvWlZlVVBVYk8yOHNWaVBEQjJqZEk3am5vQ0JxY29h?=
 =?utf-8?B?VE93Yk9GZk1PcUhweitUNVNmSVpCd2IxenpUZUR4UkNyMlpRYnNtWUx4T1Vh?=
 =?utf-8?B?YWg1ZmhreEFHZDZsT0k0VllFMVRONkhyQStuTFpZYjByMytsZmw1VnRtc0I0?=
 =?utf-8?B?TEZuRWxlWjdDeG84a3dQSXZrc3g5bVZiT3V4cjByd0U0eCsrc3Y1Q00vQUd1?=
 =?utf-8?B?TWo2UEhXUXRqbWtadWpiQmdoQnZNeGJEQWJNZkNpYUk5cGJJUHc3OTRwMTNE?=
 =?utf-8?B?MSt6Z3kxekI3QjRnM2ZsR1ViTEpPWGF2Q2JKRDNqM0lBRmxCVEw0aDg2ckVL?=
 =?utf-8?Q?bW4ZKQDhvuQriTZLI4gXF6o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A6DA1E1D5F6DCD4CAD6FB94EE52C859D@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 546498f3-a6e5-423e-be3b-08d9b501c825
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 19:35:50.5464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BF89r83rEL63g01qQmgA6K5EQZ6K8gT58AQtnOCkKFYA7HYTk1Zj9o0/1JTtRJdJGX9Q+HILRd1mkDUpCRygrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB4503
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIxLTEyLTAxIGF0IDEzOjM2IC0wNTAwLCBTY290dCBNYXloZXcgd3JvdGU6DQo+
IE9uIEZyaSwgMTUgT2N0IDIwMjEsIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gDQo+ID4gT24g
RnJpLCAyMDIxLTEwLTE1IGF0IDA4OjAzICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6DQo+
ID4gPiBPbiBGcmksIDIwMjEtMTAtMTUgYXQgMDk6NTEgKzExMDAsIE5laWxCcm93biB3cm90ZToN
Cj4gPiA+ID4gT24gRnJpLCAxNSBPY3QgMjAyMSwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOg0KPiA+
ID4gPiA+IE9uIFR1ZSwgMjAyMS0xMC0xMiBhdCAwODo1NyArMTEwMCwgTmVpbEJyb3duIHdyb3Rl
Og0KPiA+ID4gPiA+ID4gT24gVHVlLCAxMiBPY3QgMjAyMSwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3Rl
Og0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gU2NvdHQgc2VlbXMgd2VsbCBwb3NpdGlv
bmVkIHRvIGlkZW50aWZ5IGEgcmVwcm9kdWNlci4NCj4gPiA+ID4gPiA+ID4gTWF5YmUNCj4gPiA+
ID4gPiA+ID4gd2UNCj4gPiA+ID4gPiA+ID4gY2FuIGdpdmUgaGltIHNvbWUgbGlrZWx5IGNhbmRp
ZGF0ZXMgZm9yIHBvc3NpYmxlIGJ1Z3MgdG8NCj4gPiA+ID4gPiA+ID4gZXhwbG9yZQ0KPiA+ID4g
PiA+ID4gPiBmaXJzdC4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gSGFzIHRoaXMgcGF0Y2gg
YmVlbiB0cmllZD8NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gTmVpbEJyb3duDQo+ID4gPiA+
ID4gPiANCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL25ldC9zdW5ycGMv
c2NoZWQuYyBiL25ldC9zdW5ycGMvc2NoZWQuYw0KPiA+ID4gPiA+ID4gaW5kZXggYzA0NWY2M2Qx
MWZhLi4zMDhmNTk2MWNiNzggMTAwNjQ0DQo+ID4gPiA+ID4gPiAtLS0gYS9uZXQvc3VucnBjL3Nj
aGVkLmMNCj4gPiA+ID4gPiA+ICsrKyBiL25ldC9zdW5ycGMvc2NoZWQuYw0KPiA+ID4gPiA+ID4g
QEAgLTgxNCw2ICs4MTQsNyBAQCBycGNfcmVzZXRfdGFza19zdGF0aXN0aWNzKHN0cnVjdA0KPiA+
ID4gPiA+ID4gcnBjX3Rhc2sNCj4gPiA+ID4gPiA+ICp0YXNrKQ0KPiA+ID4gPiA+ID4gwqB7DQo+
ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgdGFzay0+dGtfdGltZW91dHMgPSAwOw0KPiA+ID4g
PiA+ID4gwqDCoMKgwqDCoMKgwqDCoHRhc2stPnRrX2ZsYWdzICY9DQo+ID4gPiA+ID4gPiB+KFJQ
Q19DQUxMX01BSk9SU0VFTnxSUENfVEFTS19TRU5UKTsNCj4gPiA+ID4gPiA+ICvCoMKgwqDCoMKg
wqDCoGNsZWFyX2JpdChSUENfVEFTS19TSUdOQUxMRUQsICZ0YXNrLT50a19ydW5zdGF0ZSk7DQo+
ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgcnBjX2luaXRfdGFza19zdA0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+IFdlIHNob3VsZG4ndCBhdXRvbWF0aWNhbGx5ICJ1bnNpZ25hbCIgYSB0YXNrIG9u
Y2UgaXQgaGFzIGJlZW4NCj4gPiA+ID4gPiB0b2xkDQo+ID4gPiA+ID4gdG8NCj4gPiA+ID4gPiBk
aWUuIFRoZSBjb3JyZWN0IHRoaW5nIHRvIGRvIGhlcmUgc2hvdWxkIHJhdGhlciBiZSB0byBjaGFu
Z2UNCj4gPiA+ID4gPiBycGNfcmVzdGFydF9jYWxsKCkgdG8gZXhpdCBlYXJseSBpZiB0aGUgdGFz
ayB3YXMgc2lnbmFsbGVkLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gTWF5YmUuwqAg
SXQgZGVwZW5kcyBvbiBleGFjdGx5IHdoYXQgdGhlIHNpZ25hbCBtZWFudA0KPiA+ID4gPiAocnBj
X2tpbGxhbGxfdGFza3MoKQ0KPiA+ID4gPiBpcyBhIGJpdCBkaWZmZXJlbnQgZnJvbSBnZXR0aW5n
IGEgU0lHS0lMTCksIGFuZCBleGFjdGx5IHdoYXQNCj4gPiA+ID4gdGhlDQo+ID4gPiA+IHRhc2sN
Cj4gPiA+ID4gaXMNCj4gPiA+ID4gdHJ5aW5nIHRvIGFjaGlldmUuDQo+ID4gPiA+IA0KPiA+ID4g
PiBCZWZvcmUgQ29tbWl0IGFlNjdiZDM4MjFiYiAoIlNVTlJQQzogRml4IHVwIHRhc2sgc2lnbmFs
bGluZyIpDQo+ID4gPiA+IHRoYXQgaXMgZXhhY3RseSB3aGF0IHdlIGRpZC4NCj4gPiA+ID4gSWYg
d2Ugd2FudCB0byBjaGFuZ2UgdGhlIGJlaGF2aW91ciBvZiBhIHRhc2sgcmVzcG9uZGluZyB0bw0K
PiA+ID4gPiBycGNfa2lsbGFsbF90YXNrcygpLCB3ZSBzaG91bGQgY2xlYXJseSBqdXN0aWZ5IGl0
IGluIGEgcGF0Y2gNCj4gPiA+ID4gZG9pbmcNCj4gPiA+ID4gZXhhY3RseSB0aGF0Lg0KPiA+ID4g
PiANCj4gPiA+IA0KPiA+ID4gVGhlIGludGVudGlvbiBiZWhpbmQgcnBjX2tpbGxhbGxfdGFza3Mo
KSBuZXZlciBjaGFuZ2VkLCB3aGljaCBpcw0KPiA+ID4gd2h5DQo+ID4gPiBpdA0KPiA+IA0KPiA+
ICgiaXQiIGJlaW5nIHRoZSBlcnJvciBFUkVTVEFSVFNZUykNCj4gPiANCj4gPiA+IGlzIGxpc3Rl
ZCBpbiBuZnNfZXJyb3JfaXNfZmF0YWwoKS4gSSdtIG5vdCBhd2FyZSBvZiBhbnkgY2FzZQ0KPiA+
ID4gd2hlcmUgd2UNCj4gPiA+IGRlbGliZXJhdGVseSBvdmVycmlkZSBpbiBvcmRlciB0byByZXN0
YXJ0IHRoZSBSUEMgY2FsbCBvbiBhbg0KPiA+ID4gRVJFU1RBUlRTWVMgZXJyb3IuDQo+ID4gPiAN
Cj4gVXBkYXRlOiBJJ20gbm90IGFibGUgdG8gcmVwcm9kdWNlIHRoaXMgd2l0aCBhbiB1cHN0cmVh
bSBrZXJuZWwuwqAgSQ0KPiBiaXNlY3RlZCBpdCBkb3duIHRvIGNvbW1pdCAyYmE1YWNmYjM0OTUg
IlNVTlJQQzogZml4IHNpZ24gZXJyb3INCj4gY2F1c2luZw0KPiBycGNzZWNfZ3NzIGRyb3BzIiBh
cyB0aGUgY29tbWl0IHRoYXQgImZpeGVkIiB0aGUgaXNzdWUgKGJ1dCByZWFsbHkNCj4ganVzdA0K
PiBtYWtlcyB0aGUgaXNzdWUgbGVzcyBsaWtlbHkgdG8gb2NjdXIsIEkgdGhpbmspLg0KPiANCj4g
SSBhbHNvIHRlc3RlZCBjb21taXQgMTBiOWQ5OWEzZGJiICJTVU5SUEM6IEF1Z21lbnQgc2VydmVy
LXNpZGUgcnBjZ3NzDQo+IHRyYWNlcG9pbnRzIiAodGhlIGNvbW1pdCBpbiB0aGUgRml4ZXM6IHRh
ZyBvZiAyYmE1YWNmYjM0OTUpIGFzIHdlbGwNCj4gYXMNCj4gY29tbWl0IDBlODg1ZTg0NmQ5NiAi
bmZzZDogYWRkIGZhdHRyIHN1cHBvcnQgZm9yIHVzZXIgZXh0ZW5kZWQNCj4gYXR0cmlidXRlcyIN
Cj4gKHRoZSBwYXJlbnQgb2YgY29tbWl0IDEwYjlkOTlhM2RiYikgYW5kIHZlcmlmaWVkIHRoYXQg
Y29tbWl0DQo+IDEwYjlkOTlhM2RiYiBpcyB3aGVyZSB0aGUgaXNzdWUgc3RhcnRlZCBvY2N1cnJp
bmcuDQo+IA0KPiBJIHRoaW5rIHdoYXQgaXMgaGFwcGVuaW5nIGlzIHRoYXQgdGhlIE5GUyBzZXJ2
ZXIgZ2V0cyBhIHJlcXVlc3QgdGhhdA0KPiBpdA0KPiB0aGlua3MgaXMgb3V0c2lkZSBvZiB0aGUg
R1NTIHNlcXVlbmNlIHdpbmRvdyBhbmQgZHJvcHMgdGhlIHJlcXVlc3QsDQo+IGNsb3NlcyB0aGUg
Y29ubmVjdGlvbiBhbmQgY2FsbHMgbmZzZDRfY29ubl9sb3N0KCksIHdoaWNoIGNhbGxzDQo+IG5m
c2Q0X3Byb2JlX2NhbGxiYWNrKCkgd2hpY2ggc2V0cyBORlNENF9DTElFTlRfQ0JfVVBEQVRFIGlu
DQo+IGNscC0+Y2xfZmxhZ3MuwqAgVGhlbiB0aGUgY2xpZW50IHJlZXN0YWJsaXNoZXMgdGhlIGNv
bm5lY3Rpb24gb24gdGhhdA0KPiBwb3J0LCBzZW5kcyBhbm90aGVyIHJlcXVlc3Qgd2hpY2ggcmVj
ZWl2ZXMNCj4gTkZTNEVSUl9DT05OX05PVF9CT1VORF9UT19TRVNTSU9OLsKgIFRoZSBjbGllbnQg
cnVucyB0aGUgc3RhdGUgbWFuYWdlcg0KPiB3aGljaCBjYWxscyBuZnM0X2JpbmRfY29ubl90b19z
ZXNzaW9uKCksIHdoaWNoIGNhbGxzDQo+IG5mczRfYmVnaW5fZHJhaW5fc2Vzc2lvbigpLCB3aGlj
aCBzZXRzIE5GUzRfU0xPVF9UQkxfRFJBSU5JTkcgaW4NCj4gdGJsLT5zbG90X3RibF9zdGF0ZS7C
oCBNZWFud2hpbGUgYSBjb25mbGljdGluZyByZXF1ZXN0IGNvbWVzIGluIHRoYXQNCj4gY2F1c2Vz
IHRoZSBzZXJ2ZXIgdG8gcmVjYWxsIHRoZSBkZWxlZ2F0aW9uLsKgIFNpbmNlDQo+IE5GUzRfU0xP
VF9UQkxfRFJBSU5JTkcgaXMgc2V0LCB0aGUgY2xpZW50IHJlc3BvbmRzIHRvIHRoZSBDQl9TRVFV
RU5DRQ0KPiB3aXRoIE5GUzRFUlJfREVMQVkuwqAgQXQgdGhlIHNhbWUgdGltZSwgdGhlIEJJTkRf
Q09OTl9UT19TRVNTSU9ODQo+IHJlcXVlc3RzDQo+IGZyb20gdGhlIGNsaWVudCBhcmUgY2F1c2lu
ZyB0aGUgc2VydmVyIHRvIGNhbGwNCj4gbmZzZDRfcHJvY2Vzc19jYl91cGRhdGUoKSwgc2luY2Ug
TkZTRDRfQ0xJRU5UX0NCX1VQREFURSBmbGFnIGlzIHNldC4NCj4gbmZzZDRfcHJvY2Vzc19jYl91
cGRhdGUoKSBjYWxscyBycGNfc2h1dGRvd25fY2xpZW50KCkgd2hpY2ggc2lnbmFscw0KPiB0aGUN
Cj4gQ0JfUkVDQUxMIHRhc2ssIHdoaWNoIHRoZSBzZXJ2ZXIgaXMgdHJ5aW5nIHJlLXNlbmQgZHVl
IHRvIHRoZQ0KPiBORlM0RVJSX0RFTEFZLCBhbmQgd2UgZ2V0IGludG8gdGhlIHNvZnQtbG9ja3Vw
Lg0KPiANCg0KSSdtIGEgbGl0dGxlIGxvc3Qgd2l0aCB0aGUgYWJvdmUgZXhwbGFudGlvbi4gSG93
IGNhbiB0aGUgc2VydmVyIHNlbmQgYQ0KY2FsbGJhY2sgb24gYSBjb25uZWN0aW9uIHRoYXQgaXNu
J3QgYm91bmQ/IElmIGl0IGlzbid0IGJvdW5kLCB0aGVuIGl0DQpjYW4ndCBiZSB1c2VkIGFzIGEg
YmFjayBjaGFubmVsLg0KDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50
IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29t
DQoNCg0K
