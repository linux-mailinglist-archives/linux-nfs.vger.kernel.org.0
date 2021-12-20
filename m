Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F4247B3FF
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Dec 2021 20:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbhLTTwx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Dec 2021 14:52:53 -0500
Received: from mail-mw2nam10lp2104.outbound.protection.outlook.com ([104.47.55.104]:9251
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233136AbhLTTws (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 20 Dec 2021 14:52:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjARf+4GiVouqLWxPiTGLD5vXwKAvMRiRxhxeGEPw0+yvlQ0h/QqTuqBjkI6WE312N6OEfD2tnUHyMynnXThGHLvsNW6cAxshDqykvGyNlbLk9k1a8hbJZ5oL3jJflrtdRVnhpWQVC88QtShUoH9MZZka7g3UaSlpHOmdkUV+3Dgi1JgPlN+0hmJ4AVlGusD//LTpzMFrbiHZxyz/QfvTOENyekzOZFC4quJJ9ggm75FjiTnsc9gT+Mymwl1j4CTNekveO3LTDODA0vkSADbuNK6wzBL++6M3vZrkWe06IhUjZVF74haHH7Hk0BoeSagabTNN82VhsiRI2jSklRrpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtIoK+DPHlFPcGSxeSxwuHIUEhVy3DRfjeoxNT0NbM4=;
 b=lWtjEAduZNu+E0OCjDi+R9ohexcbwY/Cq2vSt9BcoXl0yXOEkLDHY+Pu064yjH2e2p9PO6t6t8WYjaSQd430D9LRNQHimsCPJXy98KD4D1rF+HF9EIpwGeGRwPsYMMt5Z/EE8Hgohd0jkTzjtFYpWkfWJ9ULt/Ngtw8Fw0yLpoeIZRJNv9D4jcEHGVsmFZ7Bx627DKv+YwKdidQfTSIRwF+7JibmhMkpi1nvPPK7MYsNBYyDhfsQXaMg2BbQJymnW+6YddAc0lgQ0gMXVQREpGBFToh98KQU70qY2X+J7aEgJGnaC0GVDV4RTCG+9v5IPsEBWho0NBNTHGFK4Ko+tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtIoK+DPHlFPcGSxeSxwuHIUEhVy3DRfjeoxNT0NbM4=;
 b=AlTTXVvAB7mq8u08RWcQVRi4iUbXfsHJ5iwJ+ufSsteXEKm9Lzm5U58kqfX10jCdJnS2oiaH3htCn0XrslIRfjfQ1g4RYdj+4+hN275NyreZkxoNWwN8hywQPmqc7B5mj1/z6Euz+iET02+bPCVQCYPgxYOKK27opcLXl0bzdB4=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB5139.namprd13.prod.outlook.com (2603:10b6:610:f1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.9; Mon, 20 Dec
 2021 19:52:46 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08%3]) with mapi id 15.20.4823.014; Mon, 20 Dec 2021
 19:52:46 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>
Subject: Re: [PATCH v2 10/10] nfsd: Ignore rpcbind errors on nfsd startup
Thread-Topic: [PATCH v2 10/10] nfsd: Ignore rpcbind errors on nfsd startup
Thread-Index: AQHX9HoJzJa8MHrJokmLlev6qmlSfqw6H8CAgAArNwCAAT7kgIAALcMAgAAHnYCAAA4ZgA==
Date:   Mon, 20 Dec 2021 19:52:46 +0000
Message-ID: <e61524640024e31f41126e106c599428ed00a49c.camel@hammerspace.com>
References: <20211219013803.324724-1-trondmy@kernel.org>
         <20211219013803.324724-2-trondmy@kernel.org>
         <20211219013803.324724-3-trondmy@kernel.org>
         <20211219013803.324724-4-trondmy@kernel.org>
         <20211219013803.324724-5-trondmy@kernel.org>
         <20211219013803.324724-6-trondmy@kernel.org>
         <20211219013803.324724-7-trondmy@kernel.org>
         <20211219013803.324724-8-trondmy@kernel.org>
         <20211219013803.324724-9-trondmy@kernel.org>
         <20211219013803.324724-10-trondmy@kernel.org>
         <20211219013803.324724-11-trondmy@kernel.org>
         <831659F6-3005-459B-92ED-933BBCEE6FE9@oracle.com>
         <3167a9a815ac9c82700bd58d8c421de31eee8b91.camel@hammerspace.com>
         <316378A4-BCB1-4C8F-A16D-43F8F9DA8FBC@oracle.com>
         <9679c6f76f751c6c379bcfb889fd1dcba1671eac.camel@hammerspace.com>
         <753AE969-5C7E-4BA7-8CA4-003671710DAC@oracle.com>
In-Reply-To: <753AE969-5C7E-4BA7-8CA4-003671710DAC@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3e93448-1ead-4473-ef7e-08d9c3f24b76
x-ms-traffictypediagnostic: CH0PR13MB5139:EE_
x-microsoft-antispam-prvs: <CH0PR13MB51397EA9305EB540E14F7588B87B9@CH0PR13MB5139.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RKW14k3yloZ5UjJnR0Z9yBsODnDXI0JWTSgBLbDCEaIRrQc3YtNCS5a0adHyEvjO/kHE5eOGropQn0P8aGZQpEDHleNgS0GbeAANqvbNqE6vltzf6GA3Ubvy1IUrC5sbHyM+IVXkzgV9jjz5OiYtUtACum02Coj3HS3F3Skk8a1IDbeMHih/71Iv8gVFa5ewsv70LvH1WbG/Du+MkSeciDn70sUW/x5J5tgbnbPjU+UeiqUOwX84oGFUJU3xUKSwTwS0HIJuMpmRboOiBIDYwKwUAEFzvZWSgisRKhhbO/YWCAIyZtjVwpPoHWavNMqfl99LVvFznhnGIYpdT6QB5sVKhGVIzPG6KU5XjpR+YzvO3OyJ8UVDeG4lraeDKbNJwNV+FVHMQSVvB8mN29MC/PwH4pnUqP1+5Rl9bMCNHyIaLwRSMDMQ/GIahngCMRf6hHDyRtrWvszjSxHRRGWgsOZJ+08luhQd0v9hRivZY7qwo2FSbnRYVi9vWnodNT6vzDRB5cJF4tUhHS9TJeT2SEQxXjwpmAmjncnF3iR8+4VjrZ9NSuG09pKO9rVCC9oQbHSpoOcHJ4sTSm8LMUjrnwwcFaDVuqBfRdUo9yW8D85m9nOLok6chlX07Vk4J0wf/etklKGTaYvXjNHx6CHY0LVVhJ/i5ttJdrFMnAxv7cksRpXnjvpuh/DXDQaIu57K3uWjBkNPe5kkph7uB2DMvYsa7zEYC7NCgN+mPPyYcyLk28Ait84HLwbHtEVBlend
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(39830400003)(376002)(396003)(136003)(366004)(346002)(54906003)(76116006)(4001150100001)(6916009)(66946007)(38070700005)(5660300002)(86362001)(186003)(122000001)(38100700002)(53546011)(6506007)(2906002)(26005)(8936002)(316002)(6486002)(4326008)(64756008)(66556008)(66476007)(8676002)(6512007)(36756003)(508600001)(83380400001)(66446008)(2616005)(71200400001)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVpFbjJUSi9OTEZiYmVlRFBFcmRkNFg3ZHdFbkRCWEtHMGJRZzF4cG0zbzls?=
 =?utf-8?B?NnRPS2tEMWlIdXUwbUlEUnVKelFsR05EcW5aSW9aUEo5S2F4RjNwUEMrZTZW?=
 =?utf-8?B?QmMvVmdOVmU0SEJYeU80U0JIaHhNRVM1akhMTnVLcG01Z0phWWE0TGlJOVpZ?=
 =?utf-8?B?bnlReGxRbXVSNFZEem0weGV5dDBiL09iTXlyanI3UHl2bTBoWU5QNlJhYkpF?=
 =?utf-8?B?dldkdExJTWlySnpHRkVsY2dQc1JuaXRqSFdpYTFNa29WY0J4SVhaR2o4Ujgx?=
 =?utf-8?B?eEVsYWpBcEFlQzIzck9MTU9YQVBQMEFKLzByMnYzNm0rRC94ODFHemNLN1or?=
 =?utf-8?B?UDVXdzZqSWpLb1F1WldtU1ZHMktzQmZZdTQrampJQWtNNE5BOVU0UUliMDhN?=
 =?utf-8?B?N1cvMlA4eXE5NEdZZmNLME5hZy9STzlSOGxDZ1NiOFIrU3FNTzNqWllLOWlq?=
 =?utf-8?B?NVR6Mlo2Tm9GN0RDQWlwUGZUQ0tXd01zYXJKT3pvN3JLV3gyVEc5c3pjc1Rm?=
 =?utf-8?B?a0cxSEJYSVlBMXplSUQ5Yy9oRUtEdm1jcWhOT29WdWdUaE5lNlIzc0I0cnRw?=
 =?utf-8?B?RFNBOUo1L3p4N2wva2V2aCtzTVRBTWN4MHdyUlZ0bmd2LzhTRUZmbnlWdW81?=
 =?utf-8?B?MVp4UStvNWNjY3duZENEQU9qRUNYcjJZRFZoT3lhbmhiOUJJdlRJdm5IZDFq?=
 =?utf-8?B?RVJQN1pXTFhmVCtTNXRTS2RaazhnZWV2eldmWjZBbTdGT2dDZCtDQ1FHNkFT?=
 =?utf-8?B?cERFT1I1ZzhMd1dISXg3OVZHaFE4ZG04NXJVK0NVcnh5d0ZRNVN1TmlCdzFN?=
 =?utf-8?B?QVQ3bVNxdFlCUWJ5eXdXRmV1VExIUGRnL3A3YTYyemMzWkRKK0l2REVSSEdF?=
 =?utf-8?B?UUNiQ3E4YTJYZU85aXliMklNZXExaDJZQ0w0a0Q0QWRIRGdqSGVFSm9YbVhN?=
 =?utf-8?B?WHh5MStwbFRyMnRaV2JBYW9CamZpWkpVdlAxbVRId0xWZ2ZzQkxXMlpXbnQv?=
 =?utf-8?B?bFJTazhuWmtGSGdIT0J6bGlZbVFORXBpakFIekpjNUhUbnV0KzMvVHdpa2Na?=
 =?utf-8?B?K09OalZPWXJZV3hPTnR2bHo3d1M1MnUxVU9md0kveGJUaGcrU3JXM0JIYTFF?=
 =?utf-8?B?MjBpcVFMR1V5OHMwdzBIZ1E4WEVhL0F0N3B4VC94L3lvWVRqRkxWM2Qvdlg4?=
 =?utf-8?B?SkdmR1lUTGtRVHduZlM5bnpoQStWbmx6MUdoV3AzLzJvVFlQSEZkcVRqMWcv?=
 =?utf-8?B?ajRMRS84SlpaM25KT1pTaTVCZlZRaGs4OU9Edmh4dnJVMUtJZ1daWjJUWWsr?=
 =?utf-8?B?Y0x5Z3RiV1NnNlEydlJMN0gza2FCczVTb294OC93ODJOTzNEcllmTlMxaHYv?=
 =?utf-8?B?RlRBaTBoaVR4ZmNGZ011NlZjamdoR1hhS0grV2NGdTAwVCs4blZ2OXJ1VlRZ?=
 =?utf-8?B?dTJQcElVMnRpTjN2aFNQUkpLQ25Ub0gzNUI0V2lENzNheUdOcFUyeXB5Umd4?=
 =?utf-8?B?NFAwbEVuVzY0WG9aQTRVdmZHN2ZBakVuV2FlaHlIQW51YklxVlgxYk5GcjNQ?=
 =?utf-8?B?MmVrYXc1OEpoU0FXWGVTS2lyN1pkOXFqazhBVEtUZVJjWFBmUlIrV0UwRnN3?=
 =?utf-8?B?VU1kTUVVeVRUSzdiY3ovcjFWMEd1ZWxBMjZjblAyU2JYcDlxYkx0ZkZUWWFN?=
 =?utf-8?B?bFZ2WG1XWmFnYWgwdk5ISUhObGFUK3YwaXpnd0xQRWE3a3VrWmxuN3RvY1dG?=
 =?utf-8?B?blpZd0xzZXRLRERnSVBDeWdiZnBGZzYvQlBSNXM2WWo5b2l3OExOVjZaWk9w?=
 =?utf-8?B?MnVyeThmUVZWR3o0aDgyU0JLUkhEVTRCd3JVSDJJUXJJdWp5SDFoVFBLaisw?=
 =?utf-8?B?SnZwekJLZzZnVlhMTS84d3ZFcXNadlFreFZNcXQ1Tmh0K014U1hlU1ZqeFFv?=
 =?utf-8?B?WXd4RlJiQXVzRTBPdldFSG9PVUVDQ21qbGdmNVY1WXcxNGZRdGtNK3lDY0pJ?=
 =?utf-8?B?WG4xaEFiR0Y2c2Vma3hHQzViTDNsWWMvQk5WbEIra1VjZ2ZmdmVDQVhoc2Z0?=
 =?utf-8?B?YkdNSkNRa0tJTjlZM3pkejY1UGZoVkF2SzJ3akd6SzJ3cFpOYlQ3R2JhT2tL?=
 =?utf-8?B?N2thYk5Tam1nNEdzM29wc0pJUk90ejBKR0lkU0kxQ202UGhRWHhINFVzMUJ3?=
 =?utf-8?Q?i/Lj7ARNdKVoEO/8H79dvNQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <15A7045A4DAE4B498994E9ABA187C45F@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e93448-1ead-4473-ef7e-08d9c3f24b76
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2021 19:52:46.4257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8JE7iZFRp5v9m9VrQ493B7lKIE6VuGXiC2ZFuNtf455g9OL0C6xNMW5JrDcglctcQe47rO0xFsfWMsTb/xXitQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB5139
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIxLTEyLTIwIGF0IDE5OjAyICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBEZWMgMjAsIDIwMjEsIGF0IDE6MzUgUE0sIFRyb25kIE15a2xlYnVz
dA0KPiA+IDx0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gTW9u
LCAyMDIxLTEyLTIwIGF0IDE1OjUxICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+ID4g
PiANCj4gPiA+IA0KPiA+ID4gPiBPbiBEZWMgMTksIDIwMjEsIGF0IDM6NDkgUE0sIFRyb25kIE15
a2xlYnVzdA0KPiA+ID4gPiA8dHJvbmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiA+ID4g
PiANCj4gPiA+ID4gT24gU3VuLCAyMDIxLTEyLTE5IGF0IDE4OjE1ICswMDAwLCBDaHVjayBMZXZl
ciBJSUkgd3JvdGU6DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBPbiBEZWMgMTgsIDIwMjEsIGF0
IDg6MzggUE0sIHRyb25kbXlAa2VybmVsLm9yZ8Kgd3JvdGU6DQo+ID4gPiA+ID4gPiANCj4gPiA+
ID4gPiA+IEZyb206IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNl
LmNvbT4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gTkZTdjQgZG9lc24ndCBuZWVkIHJwY2Jp
bmQsIHNvIGxldCdzIG5vdCByZWZ1c2UgdG8gc3RhcnQgdXANCj4gPiA+ID4gPiA+IGp1c3QNCj4g
PiA+ID4gPiA+IGJlY2F1c2UNCj4gPiA+ID4gPiA+IHRoZSBycGNiaW5kIHJlZ2lzdHJhdGlvbiBm
YWlsZWQuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gQ29tbWl0IDdlNTViNTliMmYzMiAoIlNVTlJQ
Qy9ORlNEOiBTdXBwb3J0IGEgbmV3IG9wdGlvbiBmb3INCj4gPiA+ID4gPiBpZ25vcmluZw0KPiA+
ID4gPiA+IHRoZSByZXN1bHQgb2Ygc3ZjX3JlZ2lzdGVyIikgYWRkZWQgdnNfcnBjYl9vcHRubCwg
d2hpY2ggaXMNCj4gPiA+ID4gPiBhbHJlYWR5DQo+ID4gPiA+ID4gc2V0IGZvciBuZnNkNF92ZXJz
aW9uNC4gSXMgdGhhdCBub3QgYWRlcXVhdGU/DQo+ID4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4g
PiBUaGUgb3RoZXIgaXNzdWUgaXMgdGhhdCB1bmRlciBjZXJ0YWluIGNpcmN1bXN0YW5jZXMsIHlv
dSBtYXkNCj4gPiA+ID4gYWxzbw0KPiA+ID4gPiB3YW50DQo+ID4gPiA+IHRvIHJ1biBORlN2MyB3
aXRob3V0IHJwY2JpbmQgc3VwcG9ydC4gRm9yIGluc3RhbmNlLCB3aGVuIHlvdQ0KPiA+ID4gPiBo
YXZlIGENCj4gPiA+ID4ga25mc2Qgc2VydmVyIGluc3RhbmNlIHJ1bm5pbmcgYXMgYSBkYXRhIHNl
cnZlciwgdGhlcmUgaXMNCj4gPiA+ID4gdHlwaWNhbGx5DQo+ID4gPiA+IG5vDQo+ID4gPiA+IG5l
ZWQgdG8gcnVuIHJwY2JpbmQuDQo+ID4gPiANCj4gPiA+IFNvIHdoYXQgeW91IGFyZSBzYXlpbmcg
aXMgdGhhdCB5b3UnZCBsaWtlIHRoaXMgdG8gYmUgYSBydW4tdGltZQ0KPiA+ID4gc2V0dGluZw0K
PiA+ID4gaW5zdGVhZCBvZiBhIGNvbXBpbGUtdGltZSBzZXR0aW5nLiBHb3QgaXQuDQo+ID4gPiAN
Cj4gPiA+IE5vdGUgdGhhdCB0aGlzIHBhdGNoIGFkZHMgYSBub24tY29udGFpbmVyLWF3YXJlIGFk
bWluaXN0cmF0aXZlDQo+ID4gPiBBUEkuDQo+ID4gPiBGb3INCj4gPiA+IHRoZSBzYW1lIHJlYXNv
bnMgSSBOQUsnZCA5LzEwLCBJJ20gZ29pbmcgdG8gTkFLIHRoaXMgb25lIGFuZCBhc2sNCj4gPiA+
IHRoYXQNCj4gPiA+IHlvdSBwcm92aWRlIGEgdmVyc2lvbiB0aGF0IGlzIGNvbnRhaW5lci1hd2Fy
ZSAoaWRlYWxseTogbm90IGENCj4gPiA+IG1vZHVsZQ0KPiA+ID4gcGFyYW1ldGVyKS4NCj4gPiA+
IA0KPiA+ID4gVGhlIG5ldyBpbXBsZW1lbnRhdGlvbiBzaG91bGQgcmVtb3ZlIHZzX3JwY2Jfb3B0
bmwsIGFzIGEgY2xlYW4NCj4gPiA+IHVwLg0KPiA+ID4gDQo+ID4gPiANCj4gPiANCj4gPiBUaGlz
IGlzIG5vdCBzb21ldGhpbmcgdGhhdCB0dXJucyBvZmYgdGhlIHJlZ2lzdHJhdGlvbiB3aXRoIHJw
Y2JpbmQuDQo+ID4gSXQNCj4gPiBpcyBzb21ldGhpbmcgdGhhdCB0dXJucyBvZmYgdGhlIGRlY2lz
aW9uIHRvIGFib3J0IGtuZnNkIGlmIHRoYXQNCj4gPiByZWdpc3RyYXRpb24gZmFpbHMuDQo+IA0K
PiBTZWUgYmVsb3csIHRoYXQncyBqdXN0IHdoYXQgdnNfcnBjYl9vcHRubCBkb2VzLiBJdCBpdCdz
IHRydWUsDQo+IHRoZW4gdGhlIHJlc3VsdCBvZiB0aGUgcnBjYmluZCByZWdpc3RyYXRpb24gZm9y
IHRoYXQgc2VydmljZQ0KPiBpcyBpZ25vcmVkLg0KPiANCj4gMTAzOSBpbnQgc3ZjX2dlbmVyaWNf
cnBjYmluZF9zZXQoc3RydWN0IG5ldCAqbmV0LA0KPiAxMDQwwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29uc3Qgc3RydWN0IHN2Y19wcm9n
cmFtICpwcm9ncCwNCj4gMTA0McKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHUzMiB2ZXJzaW9uLCBpbnQgZmFtaWx5LA0KPiAxMDQywqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWdu
ZWQgc2hvcnQgcHJvdG8sDQo+IDEwNDPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBzaG9ydCBwb3J0KQ0KPiAxMDQ0IHsNCj4g
MTA0NcKgwqDCoMKgwqDCoMKgwqAgY29uc3Qgc3RydWN0IHN2Y192ZXJzaW9uICp2ZXJzID0gcHJv
Z3AtDQo+ID5wZ192ZXJzW3ZlcnNpb25dOw0KPiAxMDQ2wqDCoMKgwqDCoMKgwqDCoCBpbnQgZXJy
b3I7DQo+IDEwNDcgDQo+IDEwNDjCoMKgwqDCoMKgwqDCoMKgIGlmICh2ZXJzID09IE5VTEwpDQo+
IDEwNDnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsNCj4gMTA1MCAN
Cj4gMTA1McKgwqDCoMKgwqDCoMKgwqAgaWYgKHZlcnMtPnZzX2hpZGRlbikgew0KPiAxMDUywqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdHJhY2Vfc3ZjX25vcmVnaXN0ZXIocHJvZ3At
PnBnX25hbWUsIHZlcnNpb24sDQo+IHByb3RvLA0KPiAxMDUzwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcG9y
dCwgZmFtaWx5LCAwKTsNCj4gMTA1NMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJl
dHVybiAwOw0KPiAxMDU1wqDCoMKgwqDCoMKgwqDCoCB9DQo+IDEwNTYgDQo+IDEwNTfCoMKgwqDC
oMKgwqDCoMKgIC8qDQo+IDEwNTjCoMKgwqDCoMKgwqDCoMKgwqAgKiBEb24ndCByZWdpc3RlciBh
IFVEUCBwb3J0IGlmIHdlIG5lZWQgY29uZ2VzdGlvbg0KPiAxMDU5wqDCoMKgwqDCoMKgwqDCoMKg
ICogY29udHJvbC4NCj4gMTA2MMKgwqDCoMKgwqDCoMKgwqDCoCAqLw0KPiAxMDYxwqDCoMKgwqDC
oMKgwqDCoCBpZiAodmVycy0+dnNfbmVlZF9jb25nX2N0cmwgJiYgcHJvdG8gPT0gSVBQUk9UT19V
RFApDQo+IDEwNjLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsNCj4g
MTA2MyANCj4gMTA2NMKgwqDCoMKgwqDCoMKgwqAgZXJyb3IgPSBzdmNfcnBjYmluZF9zZXRfdmVy
c2lvbihuZXQsIHByb2dwLCB2ZXJzaW9uLA0KPiAxMDY1wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
ZmFtaWx5LCBwcm90bywgcG9ydCk7DQo+IDEwNjYgDQo+IDEwNjfCoMKgwqDCoMKgwqDCoMKgIHJl
dHVybiAodmVycy0+dnNfcnBjYl9vcHRubCkgPyAwIDogZXJyb3I7DQo+IDEwNjggfQ0KPiAxMDY5
IEVYUE9SVF9TWU1CT0xfR1BMKHN2Y19nZW5lcmljX3JwY2JpbmRfc2V0KTsNCj4gDQo+IEFuZCwg
aXQncyBhbHJlYWR5IHRoZSBjYXNlIHRoYXQgdnNfcnBjYl9vcHRubCBpcyB0cnVlIGZvciBvdXIN
Cj4gTkZTdjQgc2VydmVyLiBTbyB0aGUgaXNzdWUgaXMgZm9yIE5GU3YzIG9ubHkuIEl0IHN0aWxs
IGxvb2tzDQo+IHRvIG1lIGxpa2UgdGhlIHBhdGNoIGRlc2NyaXB0aW9uIGZvciB0aGlzIHBhdGNo
LCBhdCB0aGUgdmVyeQ0KPiBsZWFzdCwgaXMgbm90IGNvcnJlY3QuDQo+IA0KPiANCj4gPiBUaGF0
J3Mgbm90IHNvbWV0aGluZyB0aGF0IG5lZWRzIHRvIGJlDQo+ID4gY29udGFpbmVyaXNlZDogaXQn
cyBqdXN0IGNvbW1vbiBzZW5zZSBhbmQgcmVhbGx5IHdhbnRzIHRvIGJlIHRoZQ0KPiA+IGRlZmF1
bHQgYmVoYXZpb3VyIGV2ZXJ5d2hlcmUuDQo+IA0KPiBJJ20gbm90IGZvbGxvd2luZyB0aGlzLiBJ
IGNhbiBpbWFnaW5lIGRlcGxveW1lbnQgY2FzZXMgd2hlcmUgb25lDQo+IGNvbnRhaW5lciBtaWdo
dCB3YW50IHRvIGVuc3VyZSBycGNiaW5kIGlzIHJ1bm5pbmcgZm9yIE5GU3YzIHdoaWxlDQo+IGFu
b3RoZXIgZG9lcyBub3QgY2FyZS4gV2hhdCBhbSBJIG1pc3Npbmc/DQo+IA0KDQpNb25pdG9yaW5n
IHRoYXQgcnBjYmluZCBpcyB3b3JraW5nIGlzIG5vdCBhIGtlcm5lbCB0YXNrLiBJdCdzIHNvbWV0
aGluZw0KdGhhdCBjYW4gYW5kIHNob3VsZCBiZSBkb25lIGluIHVzZXJzcGFjZS4gVGhlIGtlcm5l
bCB0YXNrIHNob3VsZCBvbmx5DQpiZSB0byB0cnkgdG8gcmVnaXN0ZXIgdGhlIHBvcnRzIHRoYXQg
aXQgaXMgdXNpbmcgdG8gdGhhdCBycGNiaW5kIHNlcnZlcg0KaWYgaXQgaXMgdXAgYW5kIHJ1bm5p
bmcuDQoNCkluIGEgY29udGFpbmVyaXNlZCBlbnZpcm9ubWVudCwgdGhlbiBldmVuIHRoZSBqb2Ig
b2YgcmVnaXN0ZXJpbmcgdGhlDQpwb3J0cyBpcyBub3QgbmVjZXNzYXJpbHkgZGVzaXJhYmxlIGJl
aGF2aW91ciwgc2luY2UgdGhlcmUgd2lsbCBhbG1vc3QNCmFsd2F5cyBiZSBzb21lIGFkZGl0aW9u
YWwgZm9ybSBvZiBOQVQgb3IgYWRkcmVzcyArIHBvcnQgbWFwcGluZyBnb2luZw0Kb24gdGhhdCBr
bmZzZCBoYXMgbm8gdmlzaWJpbGl0eSBpbnRvLg0KDQo+IA0KPiA+IFRoZSBvbmx5IHJlYXNvbiBm
b3IgdGhlIG1vZHVsZSBwYXJhbWV0ZXIgaXMgdG8gZW5hYmxlIGxlZ2FjeQ0KPiA+IGJlaGF2aW91
ci4NCj4gDQo+IA0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWlu
dGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoN
Cg==
