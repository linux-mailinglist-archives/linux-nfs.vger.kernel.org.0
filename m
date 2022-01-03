Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B4C4838C9
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jan 2022 23:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiACW2J (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jan 2022 17:28:09 -0500
Received: from mail-mw2nam12on2093.outbound.protection.outlook.com ([40.107.244.93]:17057
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229876AbiACW2I (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 3 Jan 2022 17:28:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPRoigYzQSBhx43iHv2DK+aD5smegc60SGA0J3lvk5Vs/P74ck29qixum346uNfaFiN3qEb7Q7cmyQkEbYRqLApWJqBIZN1x9ybOkG2H2tFnwBIjeaQUNu84ZAwI8iLB1Kw/euWDL3LxQwUmBKRo4nj44ohLokouM2CdlaR33/AvZ0a+plW/IzM5RbvVDTKOBx43J8PMQbLDykpSjyGKNGFQeCMEg4ubpOvvfxqet60Ok4/la5coTKfhuTwIHR/4Yirs2wTeq5NZ3qlLEXsAW1TEi4fXU89HoQ7YHxz6HWjry9TrlvL8tQGSuOJFG0z78YiykHt1/pKBMSg7CVFDqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPmvV4k3nTOs7MLsKXRT21brxaRv0klKjjSWWCfoEDA=;
 b=A/YkyOF++i/UX0pWjwhgVD/+Wmc2UMAIyiJkxmyLDoXtERQK8g65xguoy2Rho5QJlL00QW+bRRQo6WVg2cN1poy7Lx6djA/WZ/SChkI1ePhEbaLEVZkUWqysI+lwUoyhwiRK9QaRC6yZy12STc6TSbpRGqaVLXBOheKmmYzdInawHb0RZn/N6wWQenYeZ9sFaUHekWXdRWGd+YqZXffmgDjbGdigKv8eNeZKwWyy6/SpEOCMXffbuLxuN/1PEbwz8dJtKD2kE3KHhCzr9vQe4txFRqIZtEGl5mo1DaB9mU0CdIOEOco5uZ4b4W8jLeagJ8140BTbcfM5Knka7DPuYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPmvV4k3nTOs7MLsKXRT21brxaRv0klKjjSWWCfoEDA=;
 b=GMyl7Qwoi76M5nVFB0wdnhlaYOo9Im/RLMK2NtQpkjMG2YJOCIDH6pq54cL2nLJnd/XHaMmQZfK7Ha2KGDZauj9fs7hdCSg/ECISHuxQn3KD0TpA28RJSCCY+wX12d5G8+znKntA63h9XQpckDJCvc20BblqKHw7pnvy2p3f59A=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CO3PR13MB5797.namprd13.prod.outlook.com (2603:10b6:303:174::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.4; Mon, 3 Jan
 2022 22:28:06 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08%4]) with mapi id 15.20.4867.006; Mon, 3 Jan 2022
 22:28:06 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "lists@doriantaylor.com" <lists@doriantaylor.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: GSSAPI as it relates to NFS
Thread-Topic: GSSAPI as it relates to NFS
Thread-Index: AQHX+ExsM09K69j28kCAisa0ppoQ0KxB5tIAgAAdtgCAAc9bgIAODlWAgAADsoCAAAOugIAACCgA
Date:   Mon, 3 Jan 2022 22:28:06 +0000
Message-ID: <3ee50563b755cd5c1ecfa5be0c6127f5a52e9d16.camel@hammerspace.com>
References: <234CDB6C-C565-4BB4-AE38-92F4B05AB4BD@doriantaylor.com>
         <48DBBF53-7CE3-4DDA-B697-B14F8C382E78@oracle.com>
         <AF7243DE-250E-4CCB-86C0-40C69BB71C88@doriantaylor.com>
         <9DA49FE9-F4AF-44CC-8BCF-86F4D2D984AA@oracle.com>
         <20220103213229.GL21514@fieldses.org>
         <1a7193c740c8cb7ba94ecfb5d5eedd32af37088c.camel@hammerspace.com>
         <20220103215853.GP21514@fieldses.org>
In-Reply-To: <20220103215853.GP21514@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92d33e4e-3eed-41af-63a4-08d9cf085080
x-ms-traffictypediagnostic: CO3PR13MB5797:EE_
x-microsoft-antispam-prvs: <CO3PR13MB57974DE5446DDEB61BD83A42B8499@CO3PR13MB5797.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1g1GjwFmH58T5i8S27sOvrf0XDWToqIKsmDZ7esI92R6ifptVsg706w8Wq6jNiMFTUZhUGNfZdoFssgSid6xA/1nDYhJonJ59mMvXxkB8TEM6msxjWredCluVi5G54S00g4RkEy/OopqdwmTl2xjFMHCKk/A1w/4bWO/XMCB8mTlzcSt4NzY2NuOZZGopA66wVg7xL2IDrtJhcahhoeHwJkm7GCW5SlBFEcojnC862DWf5734zToxyuv7hajVIIcjw6OAmuR2TMd5vD2uZk+r14KjFShJw+Jvfg89Vq8vqGzuAX6itBK+4WcX3OgX8lsce9U/6IiDsTMJWSLvnfrwZfJoaR2Ze77xacFU5nGoTmLnRDk3ZMK7eVtlzZ0UHfkocUBeQW9o5bllX31Ls9eJ+sOvlTP+g/8KzGCfXqOdvzJfEYFcPhJkHoxhD497XpioPTnhjwictQQl+/nlWdvgH0WHANfyheg+m0VitDzzPyxmIlcG1W7Q40ztOT3iAV7ExYXF+fo+SuQRpG7R+iQzTXhAZp1QC91dAlRlmca42jkKt7DMAvrWu3jU0Sk2Ie4D+h/z9kH7icUIAaPtylHi/WKvS41npTJsfl3IoqXX4qGjaZgPXuEBltwhON1MHP229mBeQAggL7/Mo52ooxzDy+4mc/CuE/CIfD8tHtMb8gHGeUOcFpw1o4lN/STb4jXALLBaanIMeHFqGBKiy6Mc8rBiYbMkx8vFglHPhwG/CJXefzGDltjDdjzT9vwQ1L3Kposp8FYbZuNOI/6UZtxpCX47CiimAv9Z7HR4G5s5fCkxPFKUODuMPb8Ti733YwJkUZ2W3U8YQe8+D9Cil4UeQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(136003)(39830400003)(366004)(376002)(346002)(396003)(86362001)(38070700005)(36756003)(38100700002)(966005)(122000001)(71200400001)(508600001)(6486002)(26005)(6512007)(186003)(2616005)(6506007)(66476007)(8936002)(64756008)(4326008)(66946007)(8676002)(66446008)(6916009)(54906003)(66556008)(2906002)(5660300002)(316002)(76116006)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjNpSWFmUkNnc1lBZy9BcXRURjJEWUVDeG1ta0FhQkREUG51MUdwZkJZVEtF?=
 =?utf-8?B?TTIyU0cvNVRycDQ1NjUrWlVVNFJ5Z3AremNUSEUxMk1XQW1uQ2thV0dMVjFR?=
 =?utf-8?B?K0oyMk53RzBxeUUxYzRsSnVIVmhnck5EdkhNSndTaklDc1F2dEVYNStrMnJz?=
 =?utf-8?B?Zzh0UFQ5SVVBcWtqd1Q5WXl6cXFkbXh3ckFJbzQ5UHhGOFV3SkFpY1l1QTdl?=
 =?utf-8?B?RGR3UGFoQ2RsZ1ZTdy9aSnlhdkdLdGNGR2hVL1RPNHVTcDVEb2FCUmJvaE82?=
 =?utf-8?B?NUtDU1dLUlFLYy9heWxJNCtyRVR1TE5zOSt1RjVEa0FGNzFBdnJocm5NTzdI?=
 =?utf-8?B?dmJvVVA4aHJFM3h2dkdEclZLL1pTMGRqcGE0UE13K0ZsTDRKMllRZ29BV3Nu?=
 =?utf-8?B?Q2JtaEEzNW5QK0ltUWsxV1VRT21wMEhuNlJPNCtJVGEwdkNFT01lMHZDMm11?=
 =?utf-8?B?RE4rRTdkWlFyUnNlRG5LaVRnWVBQaHRpOXF0QlpRcERJT3gyNGNTT0NRZTZM?=
 =?utf-8?B?bTE5aFk2dzhwSXZ5Z2M0RkNkSEUydFBDa250NWZ4VjlNL0RGc0ZJL3hVUWY0?=
 =?utf-8?B?RU9yMC9rb1U1cEhFT3EzaG81Ym93TEhLTnkzNjc1M28yWDl1Z29EYWNMZ3NQ?=
 =?utf-8?B?WGdYdEZXYUMvak82dklTTmh5cU5DbVdtRDRVYjAyYlQ0KzVhWVBqelpCay9C?=
 =?utf-8?B?d3ZuSFAxQUJOSHdmcGEwNjRHVjE4YXUwNkQ2aGVUeXB1MmJ6UFlEc0EvL3Nx?=
 =?utf-8?B?SnVGc1E5R3NZb3M1Z1VZZ0U0VmpLR3l3SmhlZkpmQ0NJSGtwdHdaTVJQTkly?=
 =?utf-8?B?VVpwSzY5dWZoUFNHWDE2ZUZmOXdWQ3JIQmpJL2FxZ0lSR201TzZsdE93Q2VO?=
 =?utf-8?B?TjhwSkl1VlljdTMvZzBhWVkwSXl3R3N4Z3Z3bUlZZ3h2bDlYK1ZxdnVXVWFm?=
 =?utf-8?B?Qmp0U1poZm01dWNsSk5hV2dyTUcrdThHRU1tTW5HOWl4aXdra3FnQ1N1blRO?=
 =?utf-8?B?RkZua1Z2WmVwRE0rbm1GeFVTZGZFYWFwaFRBQlNoR3RBd0FFU2tYdUlVQUx6?=
 =?utf-8?B?THJzRnhIQlpUNzBFRXFNOGRaSUt1QlljYUIwQSsyTnVhK0ZyelgveGx6bjJ3?=
 =?utf-8?B?NEFTMWNRdWxZSnEyd1VaQ3BhVEhCNUsxUW1scUVlZFJNMEo5N3g1U2hHUGdj?=
 =?utf-8?B?bTFaUlRacTRGNUprU01KM1VNKytjNW9OLzlzajFxVXF6c3plNDRuQ2dyQXNw?=
 =?utf-8?B?ZXp5eDlCcjQxdGZRWU1aR2ZMMHVMRW9Wb0hqRGtOa1NVQ3ErZzFxK2dVelJI?=
 =?utf-8?B?Vlp0WHE2dkJ1TU51UXZ6TitjM0RUeW9aV0ltSjA0Y2ZIWHEwWmhPRlhxclRR?=
 =?utf-8?B?OU9XZm9ucGVweUFnanBYT1UwYVI5VTlLK3FJVE85U21wc0NIakNrMGFaaW8r?=
 =?utf-8?B?OElLUFVQbG13VlI1S2V3Q2czOGYrQWJhK2toN3ZGdzF5WGQ5UE9XZlFtYjBv?=
 =?utf-8?B?aTJyRWc1R3Y0QUl5YVFzV1UrRU55SDBkTGxFbkF4aDJnNytXbmd1ZlRXd1BN?=
 =?utf-8?B?SkZEL3lZaWtNemtsUXFsM3dzMFNtdUllOGZlNGp3OVFnSUxuZlBCc2ttUm5x?=
 =?utf-8?B?aVJCSkZHYnRWMy9kWXNRdVdJOFlGclU2NnVhUXhEMmV3bm5QVGJzMi9Ybkpl?=
 =?utf-8?B?TS95ck1ad1lYVTVybGgrbXZITExTTlVLWHVaRmtSVjBKV3VEdjJjOWd3OXpG?=
 =?utf-8?B?a01PNjdOZ3JNRXJHV0c1WnlmTnZMT3Q1T25IS2IrQWNpU1VKM3JhRGJtMDYz?=
 =?utf-8?B?QzNIS3RTS0d2dTcyT01lSC9EVyt4MVh2eXNLcjY4dFovSXJIano2eW1xMVRj?=
 =?utf-8?B?bHFRMGZMS2NMSGtaemRvYThEN2g2WngwYTRPaFhqQW5vZWV5K1pDL1VrNS9Z?=
 =?utf-8?B?bUtwTUZOckVsRG9UVHRFaVA1TDZHb2pPaU1Dd2NYZ204L2lXcEpkaHBOUnF2?=
 =?utf-8?B?RUxVR0hERk0zeXNsZTQ0OTNrVE1seU9HN0hBQWhnRUlpRzlqMUEreDhySVl4?=
 =?utf-8?B?ZmJxTGtkMmk5b3BOSlpJZDh6OFBhazlhd3pteElOa0thbWpHQVZ5UCt6NVpW?=
 =?utf-8?B?MHEyaFNteTIzTGo5aHhEMXJIY2JPMERyYkV1WEdFWVlpd3pKd1ZhQy9DSkxR?=
 =?utf-8?Q?FzcjElOS4la4yhN7YoEgN8Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <07A6A25A8CE81E468D481D9F3D60ABDB@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d33e4e-3eed-41af-63a4-08d9cf085080
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2022 22:28:06.5262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w+SxNzNyD0wXB/gcnOVloh3y6n7yP4y2V2SaOB+gC3DiCpMo2UjvgvOneNxR1W+4ZzUPQcqXkT7Q4Lv1wjA5lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO3PR13MB5797
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIyLTAxLTAzIGF0IDE2OjU4IC0wNTAwLCBiZmllbGRzQGZpZWxkc2VzLm9yZyB3
cm90ZToNCj4gT24gTW9uLCBKYW4gMDMsIDIwMjIgYXQgMDk6NDU6NDVQTSArMDAwMCwgVHJvbmQg
TXlrbGVidXN0IHdyb3RlOg0KPiA+IE9uIE1vbiwgMjAyMi0wMS0wMyBhdCAxNjozMiAtMDUwMCwg
Si4gQnJ1Y2UgRmllbGRzIHdyb3RlOg0KPiA+ID4gT24gU2F0LCBEZWMgMjUsIDIwMjEgYXQgMTA6
NTM6MzNQTSArMDAwMCwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOg0KPiA+ID4gPiBJSVJDIExpbnV4
IHJlcXVpcmVzIHRoYXQgYSBtb3VudCBvcGVyYXRpb24gYmUgZG9uZSBieSByb290LiBJZg0KPiA+
ID4gPiB5b3UNCj4gPiA+ID4gcnVuDQo+ID4gPiA+IGdzc2Qgd2l0aCAiLW4iLCBiZWNvbWUgcm9v
dCwgdGhlbiBraW5pdCBhcyB5b3Vyc2VsZiwgSSB0aGluayBpdA0KPiA+ID4gPiBzaG91bGQNCj4g
PiA+ID4gd29yay4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoZXJlIGhhcyBiZWVuIHNvbWUgZGlzY3Vz
c2lvbiBhYm91dCBlbmFibGluZyBhIG5vbi1wcml2aWxlZ2VkDQo+ID4gPiA+IHVzZXINCj4gPiA+
ID4gdG8NCj4gPiA+ID4gcGVyZm9ybSBhIG1vdW50Li4uIGl0J3MgYSBiaXQgdHJpY2t5IGJlY2F1
c2UgdGhlIGZ1bmN0aW9uIG9mDQo+ID4gPiA+IG1vdW50DQo+ID4gPiA+IGlzDQo+ID4gPiA+IHRv
IGFsdGVyIHRoZSBmaWxlIG5hbWVzcGFjZSwgd2hpY2ggdHJhZGl0aW9uYWxseSByZXF1aXJlcyBl
eHRyYQ0KPiA+ID4gPiBwcml2aWxlZ2UgdG8gZG8uDQo+ID4gPiANCj4gPiA+IFRoZSBjb3JlIFZG
UyBjb2RlIGlzIHF1aXRlIGhhcHB5IHRvIGFsbG93IHlvdSB0byBtYWtlDQo+ID4gPiB1bnByaXZp
bGVnZWQNCj4gPiA+IG1vdW50cyBpbiB5b3VyIG93biBuYW1lc3BhY2UsIGJ1dCB0aGUgcGFydGlj
dWxhciBmaWxlc3lzdGVtIGJlaW5nDQo+ID4gPiBtb3VudGVkIGFsc28gZ2V0cyBhIHZldG8uDQo+
ID4gPiANCj4gPiA+IEkgdGhpbmsgd2UncmUgZXhwZWN0aW5nIE5GUyB3aWxsIGJlIHBhdGNoZWQg
dG8gYWxsb3cgdW5wcml2aWxlZ2VkDQo+ID4gPiBtb3VudHMNCj4gPiA+IHNvbWUgdGltZS7CoCBT
ZWUgZS5nLg0KPiA+ID4gDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgDQo+ID4gPiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9saW51eC1uZnMvYWVjMjE5MzM5ZDgyOTZiN2U5YjExNGQ5ZDI0N2E3MWZk
NDc0MjNjNS5jYW1lbEBoYW1tZXJzcGFjZS5jb20NCj4gPiA+IC8NCj4gPiA+IA0KPiA+ID4gLS1i
Lg0KPiA+IA0KPiA+IEFzIG5vdGVkLCB0aGUgbWFpbiBpc3N1ZSBpcyB0aGUgYmluZCgpIHByaXZp
bGVnZXMgbmVlZGVkIGZvcg0KPiA+IEFVVEhfU1lTLsKgDQo+ID4gDQo+ID4gV2hlbiB1c2luZyBB
VVRIX0dTUywgdGhlIGtuZnNkIHNlcnZlciBkb2Vzbid0IGNhcmUgYWJvdXQgdGhlDQo+ID4gb3Jp
Z2luYXRpbmcgcG9ydCwgd2hpY2ggd291bGQgYWxsb3cgdW5wcml2aWxlZ2VkIG1vdW50cyB0byBn
byBhaGVhZA0KPiA+IHByb3ZpZGVkIHRoYXQgdGhlIHVzZXIgc3BlY2lmaWVzIHRoZSAnbm9yZXN2
cG9ydCcgbW91bnQgb3B0aW9uIG9uDQo+ID4gdGhlDQo+ID4gY2xpZW50LiBJc24ndCB0aGF0IHdv
cmtpbmc/DQo+IA0KPiBPaCwgSSByZW1lbWJlcmVkIHlvdSdkIHNhaWQgdGhhdCB3YXMgb25lIG9m
IHRoZSBpc3N1ZXMsIGJ1dCBkaWRuJ3QNCj4gdW5kZXJzdGFuZCB0aGF0IHRoYXQgd2FzIGxpdGVy
YWxseSB0aGUgb25seSBjaGVjayByZW1haW5pbmcgaW4gdGhlDQo+IGNvZGUuLi4uwqAgSW4gd2hp
Y2ggY2FzZSwgeW91IGNvdWxkIGFsc28gdGVzdCB0aGlzIGJ5IHVzaW5nIHNldGNhcCBvbg0KPiAv
dXNyL2Jpbi9tb3VudCBvciBjYXBzaCB0byBnaXZlIHRoZSBtb3VudCBwcm9jZXNzDQo+IENBUF9O
RVRfQklORF9TRVJWSUNFPw0KPiAoSWYgeW91IGFsc28gc2V0IHVwIHRoZSByaWdodCBuYW1lc3Bh
Y2VzIGZpcnN0LikNCj4gDQoNCllvdSdkIGhhdmUgdG8gZ2l2ZSB0aGUgY29udGFpbmVyIGEgQ0FQ
X05FVF9CSU5EX1NFUlZJQ0UgcHJpdmlsZWdlLiBXaXRoDQpkb2NrZXIsIHlvdSBjYW4gZG8gdGhh
dCB1c2luZyB0aGUgJy0tY2FwLWFkZD1ORVRfQklORF9TRVJWSUNFJyBvcHRpb24uDQoNCi0tIA0K
VHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNl
DQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
