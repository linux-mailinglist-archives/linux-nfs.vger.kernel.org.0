Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E090C42EB01
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Oct 2021 10:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbhJOIH4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Oct 2021 04:07:56 -0400
Received: from mail-mw2nam10on2122.outbound.protection.outlook.com ([40.107.94.122]:19552
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236549AbhJOIHw (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 15 Oct 2021 04:07:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwtW0xxMiAwutUEsFVceDZiEUE1hvLxfi5kUUDsWLL2ziAnhyuJZGQMmxz3srLSaEtssjDfcoen/uwv/cc1mkPJA5yDHqkyOrWLWnv97XKSR/lj42H5CHnGkuV/EPR5txbG9S/4rPYwgADUd7xKSZ7eN3wR5q1/klAG+XWGDB6OBYnJvt5uZyTkZMdHfl0ms74q3fLqm/btK+bZZq4AlSAbBuiSWq8yIJgM1nuspjVQGQ/IEHLaSmvC5g1yrcBorDc39ScvL0ifHlX+xVOAEkGV83flmDFWXE7k8zUVW0DmC9awCs7GU6lMER9NPGcMX5QO4A02BZzDEvaIemi2LHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyTxuLc7BNyGXN/qCpxYNGJvnRPPikezFOYafeoOYjw=;
 b=WMXFf8y3DxAMa2qoijAXkpNaPZz3iv/Levjp5wIuqG+Rgr/Td34aVvF669qHtLVa1cDt1RBtnwHvZk2WAixhb0hfAiWF9jp+H5ovRMN/ftbX657oXzjayRbp9RNFQHdWqeOiqv+95weepDEhEpaxHGGWnolP4su9AyhIk5+7bgeupjJHfzGFTIlEYK6xuMrzlR384SKUtSup8Uyl+2UFVllaul0U1yVpGIgmA/1h22aqqUopsn0Cq20AEt6iRjPmHPTYHwFdjALDOcbEqeXQ45hkswxJhyAhFYQNpP+Nt5w7mbEvIMwcQO83LSOUNkrNmeI79MKuEaNNMELX8mxQZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyTxuLc7BNyGXN/qCpxYNGJvnRPPikezFOYafeoOYjw=;
 b=I8tRvL/55sigZ4YPlwT3YsFSFxAwnn8itA/hsHKXQDL0kK5Za9hzTyxHhKSMCQMLFmw7h25gyp0YTLh3nASKRcY0JigSL3qxBOEfFLsFkd3IdLQCDTdrHjoOKbIX6PQzGR3DYFkB8vWgUJrEbW4e0gznktm3NCUpM8oVA4vhnHA=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3750.namprd13.prod.outlook.com (2603:10b6:610:93::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.8; Fri, 15 Oct
 2021 08:05:45 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1533:4550:d876:1486]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1533:4550:d876:1486%7]) with mapi id 15.20.4608.016; Fri, 15 Oct 2021
 08:05:45 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "neilb@suse.de" <neilb@suse.de>
CC:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "smayhew@redhat.com" <smayhew@redhat.com>,
        "tpearson@raptorengineering.com" <tpearson@raptorengineering.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy load
Thread-Topic: CPU stall, eventual host hang with BTRFS + NFS under heavy load
Thread-Index: xSdTgH983VDBQkCAmg52fDts9flGRuB0AHyAgAQPnwCAAHMZgIBZgYoAgAFhwQCAAvGUAIAAI06AgABZrYCABMHGAIAABCUAgACaRYCAAACpgA==
Date:   Fri, 15 Oct 2021 08:05:45 +0000
Message-ID: <8bc8cad158234aca0448ab1c8410880daff3c278.camel@hammerspace.com>
References: <281642234.3818.1625478269194.JavaMail.zimbra@raptorengineeringinc.com>
             , <162855621114.22632.14151019687856585770@noble.neil.brown.name>
                , <20210812144428.GA9536@fieldses.org>     ,
 <162880418532.15074.7140645794203395299@noble.neil.brown.name>  ,
 <YWCpnsdVqssFaLrf@aion.usersys.redhat.com>          ,
 <589AFA4F-DF8E-45A3-8299-54E820E33169@oracle.com>            ,
 <20211011143028.GB22387@fieldses.org>    ,
 <34A4C7EB-2798-4482-A786-90161F5F9E34@oracle.com>            ,
 <163398946770.17149.14605560717849885454@noble.neil.brown.name>                ,
 <d795d4d7caaeebbf2f2260b7e739e9dc2f8a1de0.camel@hammerspace.com>
         <163425187213.17149.4082212844733494965@noble.neil.brown.name>
         <f2ebce6afe1d01b529a9373ecfba1dc8b3009b4c.camel@hammerspace.com>
In-Reply-To: <f2ebce6afe1d01b529a9373ecfba1dc8b3009b4c.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0694be3c-1f72-4664-a620-08d98fb29762
x-ms-traffictypediagnostic: CH2PR13MB3750:
x-microsoft-antispam-prvs: <CH2PR13MB375045E6E60E2C734FBB1689B8B99@CH2PR13MB3750.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HQxFXV8JOPyegJI6ureaIika4eXip3N8lfGr8aKd1YoxPd9rsS9zrthyF2hCerE265TP+4gQJ51sf7WB01KQYlFZ+YrP7jgeJKgzS4S0BXotKqSpd0g5cDWaMqFeeQH2sCjjOMGP1na+wCyyTD5BRDe79tzeiT7uAQ7rMhmx3ua4MkaMMr7W6HTRmTCbDyAgUN3XMPLyhsHzqYGS1w/mweo3Qsy3Ggy4B/VR7DYlewJ2RjFsGv8R8r/w5G68WaXY6GHZf+1n4w5TU3AiAxXdw3hJyzn6uKUaMKLWITrZ5ImHek227KBgilC6vVqXLsj0+Xky2wzm+/g3FNyhcjbfSZAC2LVrCdPZHRDu8wVc1+hs7x7Lq/oyHek4pEZuD52WA06d3Ew01uZeWMYoRPofBlIe7BbDMYRsc5cFpu3MqrU52wC4LdyuCQL6scE5s1qEwc7X3PQGl54KazPrxxq+h8Shopn2dzvpi+TjGcFSfBQBTi9zYtarT32zTzKutAanmkPVzA3EYZ+cJ0vbIqZb21Tn37O/sHAmWwLDR8lWzKysZeJh8X0aiNGIsisHfTgxFJPjQYaIytV96O3je36wdCSap0dvkSiVNPaeP+tjrJanyl/q3fsiuui2p+jqcDiBUOVpLRG77yG3rWCw1o9Dfv87KeZpo+FWWrWCN6UfsEw6/uiYq3kMK/XuJ5monnLXmx26bGvLVvyMHBkn5t3EKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(4001150100001)(8676002)(36756003)(38070700005)(2616005)(66476007)(91956017)(316002)(71200400001)(66446008)(66556008)(64756008)(26005)(8936002)(54906003)(186003)(6916009)(76116006)(66946007)(6486002)(6506007)(5660300002)(122000001)(38100700002)(2906002)(508600001)(83380400001)(86362001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjZEMlRLK0pnd3d5emR3MUNpNmNSTkFTYUs1MkJNeUdHMWQ0YUl3dFF6WUcy?=
 =?utf-8?B?YUE1L1hjMHhiT0F5QWQxR2wvbDhoTTVzc3U4ZU45dzhSSEtRQzY1YnFLVHVn?=
 =?utf-8?B?SDI3aEx4ZHdQMWZmMnd0QktaeHZlTkdRclZFR3RDcG1aWDgvRm11T3E2MjFP?=
 =?utf-8?B?RDdFRDNwRHRHazhVcXNEcUxpbCtXNHlHYTlQempZTUZZekh4MkxhK2FKbkR5?=
 =?utf-8?B?U0N6VWpLemVnUHkwK25IOFlBNHBPckw1QnlUU2c3WTJXNUFvQzZkYVEzUWN0?=
 =?utf-8?B?VmJiQXZJU3hUaXNWUnB3YmNiUElXZXdOd1VxUFBKUFZ1SGcwNlcwTWxONSsw?=
 =?utf-8?B?UkFCVzFweE5aN1BLd21uVnFETk9wZWVzV1VGYWg4bXV0bkk1ZEJWSDl5dVZI?=
 =?utf-8?B?dUhMd0k3U2t5VWwyMXFBZFlZTnQ5WmJSOVlmdSs5NTRCR0x2dlNzSUkyQ2FT?=
 =?utf-8?B?dmdDZnpJSDJzY29BLytjc0RlZHlGMUNoMkFLY2g4YWNqNVdjeWNKb2JFejdn?=
 =?utf-8?B?UGM0UDZabHhvRlgrcGovajAyOGZNSUxJNW9TbzNnVkZIMmhkTjljdTdkSTJ4?=
 =?utf-8?B?VTlzenQ4UDREVXZRdGI4TUkvMzRnaUlUQ0hENW9uYURBczVNeGMwRGt2RDYz?=
 =?utf-8?B?WmpHOEdKay9qRysxa2NWU2NkYkN2ZTdncnZNTzljUTdPUDBOWlFwc2JFRm5H?=
 =?utf-8?B?ajF5eXIxK3hESFdtdEVMY29NZU5pYkVqYUVEdFBMSlJsSTRCbGZJMkVOeUc3?=
 =?utf-8?B?ODN1U1MrMXRuVEN1djFPc0NuT3JHMmpsYi81ZzRKRzZFWDY0a0p4NkFvZWVK?=
 =?utf-8?B?TzFZU3JweUtxdUVDTTVaNyt3dk1iMndwa3F3dW1XTVlBZjE2WWduYlNXZS83?=
 =?utf-8?B?YjQ0TkxsSmRMeUw5enUwUDNSRk43MC9rUE13V2NEQlkxSUFLZkMzVkN0NS9H?=
 =?utf-8?B?ZzgwdXZpd2MwT25NTTgvd3luWDZnRVZUYlIvNUNkNVdsT0prRElDWEFlU1Fu?=
 =?utf-8?B?UDJzQlRQNnV0ZUY3K3JPWTlBMnZoUnIycFVmSTRUSllTQTA2R0wvVUtMWEpU?=
 =?utf-8?B?ZzZmZXhJTFI5OWd6TmRMUHd4Z1N6Nm54SUc3WEVKemUyY0VWQzFNd0FrdVcz?=
 =?utf-8?B?QVBYWWY5R3JUazZJYXJpcHFIRHB5RUZSUEtQdGRLclZhTmJQbktiVDBwdEU1?=
 =?utf-8?B?NmJHakVJenRrTW40OGliUGJRTVNzZWtZQ0VaUnFmc05TQm1nTlRuUk5OeUJn?=
 =?utf-8?B?eXdjNXl0VHlibHFhZTdwTWdWZC9YeDVCb3RNWlFVSmtqSzJNN0h2L0w1Ymph?=
 =?utf-8?B?WnkvSzdlb1U4K28wNjZFNlNmM0JJU0NsbWRsNHVzTTAxVi9lUUdWSU5DaGNh?=
 =?utf-8?B?aXBsUklwWHl2MnFndnJBRG5QbkxidHFKKzFJWDNQUGFQMFlYM0hRLzhVYVRZ?=
 =?utf-8?B?ak1SUFhaSkQ5b2g0QTdyVzV0U0U2Wkd5TysycmtYaE9VSG5TbldJWDNkL21n?=
 =?utf-8?B?VHVMQ25Ca0tZZ1pmT2huQnBMMHZnZnFWajN3REZwa2txeE0yaS94bVpsRGpl?=
 =?utf-8?B?bk5iUWovR1NXT3V4U3dMU2poakh1aFJTNk90WFg0cy9LN1N0Zlo4c1Q2ODZz?=
 =?utf-8?B?Q1pCSGNiMlNhUHNRZGxHU0svSllYa1V1eEduejY3NnQ4cjZqV0xVZlhvOVJh?=
 =?utf-8?B?M0RzMWFuUWRkV043Yk5pYlpoZ0xUSC8rUy9FdnRGN29iQnBsVWtDRDIzTVQr?=
 =?utf-8?B?SVVMTWlwR2VYaFU4czcwbm5Rck03V1VUUTNBTWhrOERqSVBNNUdseE9tcDZp?=
 =?utf-8?B?anliZThjTXZuSmRENDFENXhVdENJMUJ6djI0MGdSZzdIc3BoaWVSS2l3bm14?=
 =?utf-8?B?M0lzUy9VNEkwRXNncDZOdi9hWWthTU41VFExQ21mRzY2eUN0WFUvQnRoNWpV?=
 =?utf-8?B?M0tWSzljZmc4VEJHZE5Ra2ZvYU5lNEZFOXJZU21jZ0N2cXg2R3VoQ1l2aTJG?=
 =?utf-8?B?RzFMQzZhbnJrUjgwY0xkakI3aU05NmlaS1FyeWxNSVg2ZVdXY1NMUG85U2dt?=
 =?utf-8?B?cTNySE5TZTgxM3g4cnZiMlZ2NFNrNlNxbDJFWUhNM2pDMkdBc0ZYZGx4NHFp?=
 =?utf-8?B?KzV0b2RBRjMvdExsS0ZBMGJMcFZJc1g4REpBUzNKSDdmaGxjcE1Sa01VL3Jv?=
 =?utf-8?Q?1UCriL3f+xqmbzHRWVFjNMc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4EA8074FE96214BB7DDB620CC65737A@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0694be3c-1f72-4664-a620-08d98fb29762
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2021 08:05:45.5156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f2BhbOQsDilFb8iVbIiGoLvDFk0LBxya9tk5uh6LtZl4Jk4oeou89072INmcEkZ7scW2S2vES/l8RsLTQLDYTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3750
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIxLTEwLTE1IGF0IDA4OjAzICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+IE9uIEZyaSwgMjAyMS0xMC0xNSBhdCAwOTo1MSArMTEwMCwgTmVpbEJyb3duIHdyb3RlOg0K
PiA+IE9uIEZyaSwgMTUgT2N0IDIwMjEsIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiA+IE9u
IFR1ZSwgMjAyMS0xMC0xMiBhdCAwODo1NyArMTEwMCwgTmVpbEJyb3duIHdyb3RlOg0KPiA+ID4g
PiBPbiBUdWUsIDEyIE9jdCAyMDIxLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gU2NvdHQgc2VlbXMgd2VsbCBwb3NpdGlvbmVkIHRvIGlkZW50aWZ5IGEgcmVw
cm9kdWNlci4gTWF5YmUNCj4gPiA+ID4gPiB3ZQ0KPiA+ID4gPiA+IGNhbiBnaXZlIGhpbSBzb21l
IGxpa2VseSBjYW5kaWRhdGVzIGZvciBwb3NzaWJsZSBidWdzIHRvDQo+ID4gPiA+ID4gZXhwbG9y
ZQ0KPiA+ID4gPiA+IGZpcnN0Lg0KPiA+ID4gPiANCj4gPiA+ID4gSGFzIHRoaXMgcGF0Y2ggYmVl
biB0cmllZD8NCj4gPiA+ID4gDQo+ID4gPiA+IE5laWxCcm93bg0KPiA+ID4gPiANCj4gPiA+ID4g
DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9uZXQvc3VucnBjL3NjaGVkLmMgYi9uZXQvc3VucnBjL3Nj
aGVkLmMNCj4gPiA+ID4gaW5kZXggYzA0NWY2M2QxMWZhLi4zMDhmNTk2MWNiNzggMTAwNjQ0DQo+
ID4gPiA+IC0tLSBhL25ldC9zdW5ycGMvc2NoZWQuYw0KPiA+ID4gPiArKysgYi9uZXQvc3VucnBj
L3NjaGVkLmMNCj4gPiA+ID4gQEAgLTgxNCw2ICs4MTQsNyBAQCBycGNfcmVzZXRfdGFza19zdGF0
aXN0aWNzKHN0cnVjdCBycGNfdGFzaw0KPiA+ID4gPiAqdGFzaykNCj4gPiA+ID4gwqB7DQo+ID4g
PiA+IMKgwqDCoMKgwqDCoMKgwqB0YXNrLT50a190aW1lb3V0cyA9IDA7DQo+ID4gPiA+IMKgwqDC
oMKgwqDCoMKgwqB0YXNrLT50a19mbGFncyAmPSB+KFJQQ19DQUxMX01BSk9SU0VFTnxSUENfVEFT
S19TRU5UKTsNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgY2xlYXJfYml0KFJQQ19UQVNLX1NJR05B
TExFRCwgJnRhc2stPnRrX3J1bnN0YXRlKTsNCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoHJwY19p
bml0X3Rhc2tfc3QNCj4gPiA+IA0KPiA+ID4gV2Ugc2hvdWxkbid0IGF1dG9tYXRpY2FsbHkgInVu
c2lnbmFsIiBhIHRhc2sgb25jZSBpdCBoYXMgYmVlbg0KPiA+ID4gdG9sZA0KPiA+ID4gdG8NCj4g
PiA+IGRpZS4gVGhlIGNvcnJlY3QgdGhpbmcgdG8gZG8gaGVyZSBzaG91bGQgcmF0aGVyIGJlIHRv
IGNoYW5nZQ0KPiA+ID4gcnBjX3Jlc3RhcnRfY2FsbCgpIHRvIGV4aXQgZWFybHkgaWYgdGhlIHRh
c2sgd2FzIHNpZ25hbGxlZC4NCj4gPiA+IA0KPiA+IA0KPiA+IE1heWJlLsKgIEl0IGRlcGVuZHMg
b24gZXhhY3RseSB3aGF0IHRoZSBzaWduYWwgbWVhbnQNCj4gPiAocnBjX2tpbGxhbGxfdGFza3Mo
KQ0KPiA+IGlzIGEgYml0IGRpZmZlcmVudCBmcm9tIGdldHRpbmcgYSBTSUdLSUxMKSwgYW5kIGV4
YWN0bHkgd2hhdCB0aGUNCj4gPiB0YXNrDQo+ID4gaXMNCj4gPiB0cnlpbmcgdG8gYWNoaWV2ZS4N
Cj4gPiANCj4gPiBCZWZvcmUgQ29tbWl0IGFlNjdiZDM4MjFiYiAoIlNVTlJQQzogRml4IHVwIHRh
c2sgc2lnbmFsbGluZyIpDQo+ID4gdGhhdCBpcyBleGFjdGx5IHdoYXQgd2UgZGlkLg0KPiA+IElm
IHdlIHdhbnQgdG8gY2hhbmdlIHRoZSBiZWhhdmlvdXIgb2YgYSB0YXNrIHJlc3BvbmRpbmcgdG8N
Cj4gPiBycGNfa2lsbGFsbF90YXNrcygpLCB3ZSBzaG91bGQgY2xlYXJseSBqdXN0aWZ5IGl0IGlu
IGEgcGF0Y2ggZG9pbmcNCj4gPiBleGFjdGx5IHRoYXQuDQo+ID4gDQo+IA0KPiBUaGUgaW50ZW50
aW9uIGJlaGluZCBycGNfa2lsbGFsbF90YXNrcygpIG5ldmVyIGNoYW5nZWQsIHdoaWNoIGlzIHdo
eQ0KPiBpdA0KDQooIml0IiBiZWluZyB0aGUgZXJyb3IgRVJFU1RBUlRTWVMpDQoNCj4gaXMgbGlz
dGVkIGluIG5mc19lcnJvcl9pc19mYXRhbCgpLiBJJ20gbm90IGF3YXJlIG9mIGFueSBjYXNlIHdo
ZXJlIHdlDQo+IGRlbGliZXJhdGVseSBvdmVycmlkZSBpbiBvcmRlciB0byByZXN0YXJ0IHRoZSBS
UEMgY2FsbCBvbiBhbg0KPiBFUkVTVEFSVFNZUyBlcnJvci4NCj4gDQo+IA0KDQotLSANClRyb25k
IE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJv
bmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
