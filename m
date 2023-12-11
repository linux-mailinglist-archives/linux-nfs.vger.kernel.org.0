Return-Path: <linux-nfs+bounces-480-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C7480CBD0
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Dec 2023 14:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E78B01C2091C
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Dec 2023 13:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789CE47795;
	Mon, 11 Dec 2023 13:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="IC8FZEaJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2099.outbound.protection.outlook.com [40.107.223.99])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23FB2105
	for <linux-nfs@vger.kernel.org>; Mon, 11 Dec 2023 05:54:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/zGsDZH/REOEj1JBGUQpMiXE6JsTI6zgVu6T7+oxaf+6cssTRegPB3ejDSjy6Y0D74wNqUa5AGkjUuwpFddUlqSAY5zGVL6kCn4cPs+1lsnA3/kUFt+ap7NyTOas+k+2A9/GGTIlSWZ3joZF72NzWz/G/wQhMbGD6vXzLWonyTbxECBOTD8hK2ldN20UBnP/dQtKJvxE7kLgjuL3UjHKa/hds987LbPsjQn8mUg1g/AIAGmo2HDwc4yuuIBoXwB3XNYZry01rvp0QBmQ02drtdgmQWKLn0rssAtleiSHFhI7fGrEmshGwoyhJf5a2eco8+QJsQXleKfCtnXR7qVzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2FI1+j/p9Txefp7J6wnSXgvTdHPkwSwdWroA/937yuM=;
 b=YR8sYqk7Oolg8p4QLa9M59j12jjWzw9mZQ/8LXn4Tc7M9LPtlLNMFAv906oOhwKp97EdVqg3ht3VphXzNZglSyK+Ef6nMU7IbEMSs2pDwgO5rVQIIuZXGUIU1ruGg6HqtzAkG+K/JN61AgnVsHGM9qjZlbnN7s1qpF5Sooi3ql+CmIt7kYKKH42bGuwyC7JeR1jRkWzJj9nHsVPlRPYDcTwm78NAlW1GaxHcRoktBhqjqTy8ybWqxjPn+SbJ4J1QdbLi1Yk9d8ymvmxsVVWUFhazWOfFmoxD+44j0VnK4Mmyk+Y9/gUfoikhddmDfOr/MwbnKuF3a6c0QJAl3pNicQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FI1+j/p9Txefp7J6wnSXgvTdHPkwSwdWroA/937yuM=;
 b=IC8FZEaJNoGbtyivmkWFYOWxh3LyKQg79RSXvW97t/hpQaN4wqsVjq3KdPTCPWDaWTAuB8PKk5XDUErDaNXvJmn9bn+tMQntdxwRKqeWF/ZU1ZDhUqEx97eac6kvx35tLtCEb8FFKq+2mpiFZI0y+Ysbu+TPUMk8AJva4iudUm8=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by PH0PR13MB5730.namprd13.prod.outlook.com (2603:10b6:510:121::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 13:54:32 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::390:1b7:55fc:a776]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::390:1b7:55fc:a776%2]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 13:54:32 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "bcodding@redhat.com" <bcodding@redhat.com>
CC: "anna@kernel.org" <anna@kernel.org>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] SUNRPC: Fixup v4.1 backchannel request timeouts
Thread-Topic: [PATCH v2] SUNRPC: Fixup v4.1 backchannel request timeouts
Thread-Index: AQHaKgtr26jzfBT/OEGuctUIQ6rf6rCgt3qAgANFrQCAACHhAA==
Date: Mon, 11 Dec 2023 13:54:32 +0000
Message-ID: <bb86cfde12ee334bfe53ca44f4a11abae525d051.camel@hammerspace.com>
References:
 <1bcb93ab5feefca853b95a1759da5b008c204092.1702063105.git.bcodding@redhat.com>
	 <089148135f43daaa77e4f83b199883c8b22c7b0f.camel@hammerspace.com>
	 <35D8B8C5-C025-43CA-B06E-60CD44634AD7@redhat.com>
In-Reply-To: <35D8B8C5-C025-43CA-B06E-60CD44634AD7@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|PH0PR13MB5730:EE_
x-ms-office365-filtering-correlation-id: 86d91112-3d6d-484d-fa3e-08dbfa50b3ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xI/hnoaUWqBrQx44U6GjaVVpxwNO3pBWF8f0rVDX4MiLdJiE35SlptVOcmzARuQ2P8gUxWpN6e9G37Xqvhc7N/6M9g1IX0OWvZEYX236pjI4qKGczTJanB7eNi7fJp+6rUsZHEciNGtGxb0zIevLFIXMsmOGUen+aPDtCtqPPbVslg8LM5VWLiGIFfEEAq+BFRlQsYTsbj1h/t9Lx3fnHhAvRGvfiMyDyoF+amvDGtcL6ejTWgOAIUTGk6R70gtjHq1DzozLhPHmtY0np/xtc4Tx/oLx46UwcxuVXxJspKu+WUqyn8enoAdhMysc4LdWufFy7d34gYo4UH6LU5vOSpo/w/rMzU6myILk2ici6vFDXlocqfJD1l1AT2/vU323A3I+/fP0eq2NIjx7lOW2oMxMYDpn7AEzyCU1p3C6Al4pJxreLDrs9SNknqOzrpLpsfzWMO5vdmF0jFJE5oOyHaHw0Xtn8kBmGKmMDrdTdYnbo8ILaeQ7zycWHOiXJJHxpMK96nODPrscybiklyOjJNk/uqE0FlI6vlSgiU428gy6yUG0V4EKVK194d2n/7aLX0gvdcsR+KzSKOYwvkP0L4wPVQbUCq4co5hlepJ1kiOKK7i0bv89pbTdLPbQw0SNEKgXHLIVUCNOCboZxZc0GSMINdsvOW/1ujVDvwZ546k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(346002)(39830400003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(4001150100001)(6512007)(6506007)(2906002)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(6916009)(71200400001)(53546011)(38100700002)(122000001)(86362001)(36756003)(4326008)(8676002)(8936002)(316002)(5660300002)(76116006)(91956017)(6486002)(478600001)(41300700001)(38070700009)(2616005)(26005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QXg3NmpFM0xQd2JBWlpOeTZHZHhlMGpqM3h2VGkyRjYxSEZ4YzF4Nm1xVGtG?=
 =?utf-8?B?SDdQU29GMHR4aURRODJjL1IyOWQrVDlKU0VLOTc0azJkdVR6aURobzd4RjRL?=
 =?utf-8?B?TzlrMS9zcE55Sk5Nem9ha2tFU3Jvdks3SWNib2NsRTJvVDQzSEowc05lSG9t?=
 =?utf-8?B?MXVTZCt6YzEvOVFLd2F1S09HYUgraVlKbmMwTGJ4Unh2aVBwRytHR0czeHZL?=
 =?utf-8?B?V1h2b0NBdFZkRGZ0S1Q0QnRPTVE0blZGb0xFbXpFdTRFVHBUWU1PUVAvbHFQ?=
 =?utf-8?B?bGhFcjRibzVER2N5MVcrOURicXFFek1waTZpVExZV2pWTm8zRnFpRGhTQUl5?=
 =?utf-8?B?MUZvUzc4bm1zaTlmZTFzU0tsenlwNGVaMXRXaW1GY3VhcllsTGI3UmQvaEZo?=
 =?utf-8?B?cnZUczh5MVJvVTV4YStXRVV2Sy9QbWN5WTNaYUNnWkxreVc3alFKcWgwVVY5?=
 =?utf-8?B?dWNGZXdxaWdNSVc5ZWxTMmlGZUIrc3ZycWhvQklCOE5Xa2N0Y2doekQ2Z3ow?=
 =?utf-8?B?YWFZR3B1eXNiTGU5TEc5Y0V0ME9kampHRzJiVmdFYTlSVEpmZUREdEozMnRM?=
 =?utf-8?B?NWtIZ3BsYmVMbys1TVI1MWtUcDRNMGJMYjR2STVtbDVQbTNHQ2xrQW5uRCtS?=
 =?utf-8?B?QjZSaVFDdkZrc1dzQm1MSEZ5V21WaGpSNG9nbGd1UHY5bFRtZXhzamlYTHlX?=
 =?utf-8?B?TGRDcGRwT2YyTlQ3WXVxK2FnS2FSYTg4U2IxU3piRWlWZXdSbXB6c21YVkZh?=
 =?utf-8?B?Qk5jZ0RCZGI1VVZFMS9Ddkx4dHM1bTBsVWhjWk5jR3NOVEZkajJjUEVNU3V0?=
 =?utf-8?B?bXFKQk1PMFBFTFU4YWNWdmY4UHQ3cjRKempkV2E5Z0pEN3dTWEpTQXYrU2Jx?=
 =?utf-8?B?S21jQ2RzNzdibmMzNkRyYmZYN3ZYZDRucmo0aHlkTWZOTmpTSE8yMUpwSmkr?=
 =?utf-8?B?M01Ecm51di8yS0VxcktiNllTdW5rdHpkbUlpMXllT2ROclZJd0VTZzF0dWM3?=
 =?utf-8?B?cUozYVMxZGhRRFEwRXIvQUhEMENsTHZLMXA0cEU2UUhKQTZTWWV3VzFxbkpE?=
 =?utf-8?B?VzBqSFUyQU5sdFB1YnhSTklkdVBrS2Z3TytSZXhySVBvTFdoTVpKaVBCeVhF?=
 =?utf-8?B?ZERydVpSZE1Kb1R6NlJpcmszbEU5UW8vbHZmdWZ3eXVkTHNhR1hlNVBsVFRw?=
 =?utf-8?B?enpYY3p2VjI0NFhGS05yRWFPd3BaOG4rTHhNb2JKS2JOWGdKaWU1aUR1TkFJ?=
 =?utf-8?B?TVNvTGZUTGpXV2lmcXJTTmIwTCs5N1FqSmY3Nm94Myt6Sk8xRFNUWUpQeHNR?=
 =?utf-8?B?czUvZTAwckVpejRKLzVMQi9xR1FsMHNpWlFWR0dmRXlKbzFsdFJxRVloVGZk?=
 =?utf-8?B?Ykc0QVRhUS9DbnVUZ3hrOEk2eW1RZndmNERCbGFwQzFwc2RoblNTNDZheE5Z?=
 =?utf-8?B?aDQ1Q3JFQXF6REMweXlmbXo5TDNtMzBvcG5iNzgyenE5UHhnRHlMRk1WbHhW?=
 =?utf-8?B?UEQ5WWVZS0hMTHliODJOOW5kVC9lRlRPNktKdGVFU1ZseE9wMmlBNG5ac3Uw?=
 =?utf-8?B?L1JsSnYzSHhvQlpzZ0RCeGRCSjhHRnNId29jcGpyUzNubkx0V3huKzJwMlhF?=
 =?utf-8?B?emVraU5jVzhJZjFpWGkyMGlESDNQZFZ3RmN4WFg0clE0Z0Q5amhtaWMzMlBp?=
 =?utf-8?B?aW9pdkxoZlJFSFcvQUsrWmFyY1hBbHpPKzRxS0NqYnlTY1NCejhTS08vODBm?=
 =?utf-8?B?d01KcUh2ekFoRmpDeWVSenhyWVI3bmtyOEp1M0YyY2R0ajVqRnFQQVd4REZN?=
 =?utf-8?B?d1FJWm5jV1BuZjZZTzgraGJQREZ4bllSNVhWRFB0WWFaQmpwalVsdm9FQ0tS?=
 =?utf-8?B?ZkpQdDBreVJXMmZpMWlqUGttUFZ5UlJsRGIzMUd1ZThKTlZQek9JbjIwNDVD?=
 =?utf-8?B?TkpmdGlLKzF2VkovMDdQbVlhdzg0Wm44SnNEYk1RTnVmTDFrUWtKd0ZMVjlt?=
 =?utf-8?B?RExNUi9HUlNGVDNsMEVaVU90MGFCamZPWGJ4blNzWjd0ODJPN3ZJalFFYXJV?=
 =?utf-8?B?TXpqZVBIdEYzc2ltd2xzSG9SRGxkaWpwbTBaMlJQL2oxM0JrT0YwZG9vZ3BW?=
 =?utf-8?B?VWFTSHZLMjVRU2dtM1dybXNLWGNvQ3hpbld4VjY3U3ZvYloydmR5c1AzUzNC?=
 =?utf-8?B?L3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ADF9C68B743C5C49AE993AF2D6D12B07@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d91112-3d6d-484d-fa3e-08dbfa50b3ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2023 13:54:32.3752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qsTSmzpJzIXyCtZdyryyTDF6rYGCn0lyHfZ+mF6X/QiwLR7BQ97u/E5wXis2DW96+fMT7/CbgBPafgLVli/MBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5730

T24gTW9uLCAyMDIzLTEyLTExIGF0IDA2OjUzIC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiA5IERlYyAyMDIzLCBhdCA0OjU1LCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6DQo+
IA0KPiA+IE9uIEZyaSwgMjAyMy0xMi0wOCBhdCAxNDoxOSAtMDUwMCwgQmVuamFtaW4gQ29kZGlu
Z3RvbiB3cm90ZToNCj4gPiA+IEFmdGVyIGNvbW1pdCA1OTQ2NGIyNjJmZjUgKCJTVU5SUEM6IFNP
RlRDT05OIHRhc2tzIHNob3VsZCB0aW1lDQo+ID4gPiBvdXQNCj4gPiA+IHdoZW4gb24NCj4gPiA+
IHRoZSBzZW5kaW5nIGxpc3QiKSwgYW55IDQuMSBiYWNrY2hhbm5lbCB0YXNrcyBwbGFjZWQgb24g
dGhlDQo+ID4gPiBzZW5kaW5nDQo+ID4gPiBxdWV1ZQ0KPiA+ID4gd291bGQgaW1tZWRpYXRlbHkg
cmV0dXJuIHdpdGggLUVUSU1FRE9VVCBzaW5jZSB0aGVpciByZXEgdGltZXJzDQo+ID4gPiBhcmUN
Cj4gPiA+IHplcm8uDQo+ID4gPiBXZSBjYW4gZml4IHRoaXMgYnkga2VlcGluZyBhIGNvcHkgb2Yg
dGhlIHJwY19jbG50J3MgdGltZW91dA0KPiA+ID4gcGFyYW1zIG9uDQo+ID4gPiB0aGUNCj4gPiA+
IHRyYW5zcG9ydCBhbmQgdXNpbmcgdGhlbSB0byBwcm9wZXJseSBzZXR1cCB0aGUgdGltZW91dHMg
b24gdGhlDQo+ID4gPiB2NC4xDQo+ID4gPiBiYWNrY2hhbm5lbCB0YXNrcycgcmVxLg0KPiA+ID4g
DQo+ID4gPiBGaXhlczogNTk0NjRiMjYyZmY1ICgiU1VOUlBDOiBTT0ZUQ09OTiB0YXNrcyBzaG91
bGQgdGltZSBvdXQgd2hlbg0KPiA+ID4gb24NCj4gPiA+IHRoZSBzZW5kaW5nIGxpc3QiKQ0KPiA+
ID4gU2lnbmVkLW9mZi1ieTogQmVuamFtaW4gQ29kZGluZ3RvbiA8YmNvZGRpbmdAcmVkaGF0LmNv
bT4NCj4gPiA+IC0tLQ0KPiA+ID4gwqBpbmNsdWRlL2xpbnV4L3N1bnJwYy94cHJ0LmggfMKgIDEg
Kw0KPiA+ID4gwqBuZXQvc3VucnBjL2NsbnQuY8KgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAzICsr
Kw0KPiA+ID4gwqBuZXQvc3VucnBjL3hwcnQuY8KgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMjMgKysr
KysrKysrKysrKystLS0tLS0tLS0NCj4gPiA+IMKgMyBmaWxlcyBjaGFuZ2VkLCAxOCBpbnNlcnRp
b25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9saW51eC9zdW5ycGMveHBydC5oDQo+ID4gPiBiL2luY2x1ZGUvbGludXgvc3VucnBjL3hwcnQu
aA0KPiA+ID4gaW5kZXggZjg1ZDNhMGRhY2EyLi43NTY1OTAyMDUzZjMgMTAwNjQ0DQo+ID4gPiAt
LS0gYS9pbmNsdWRlL2xpbnV4L3N1bnJwYy94cHJ0LmgNCj4gPiA+ICsrKyBiL2luY2x1ZGUvbGlu
dXgvc3VucnBjL3hwcnQuaA0KPiA+ID4gQEAgLTI4NSw2ICsyODUsNyBAQCBzdHJ1Y3QgcnBjX3hw
cnQgew0KPiA+ID4gwqAJCQkJCQkgKiBpdGVtcyAqLw0KPiA+ID4gwqAJc3RydWN0IGxpc3RfaGVh
ZAliY19wYV9saXN0OwkvKiBMaXN0IG9mDQo+ID4gPiBwcmVhbGxvY2F0ZWQNCj4gPiA+IMKgCQkJ
CQkJICogYmFja2NoYW5uZWwNCj4gPiA+IHJwY19ycXN0J3MgKi8NCj4gPiA+ICsJc3RydWN0IHJw
Y190aW1lb3V0CWJjX3RpbWVvdXQ7CS8qIGJhY2tjaGFubmVsDQo+ID4gPiB0aW1lb3V0IHBhcmFt
cyAqLw0KPiA+ID4gwqAjZW5kaWYgLyogQ09ORklHX1NVTlJQQ19CQUNLQ0hBTk5FTCAqLw0KPiA+
ID4gwqANCj4gPiA+IMKgCXN0cnVjdCByYl9yb290CQlyZWN2X3F1ZXVlOwkvKiBSZWNlaXZlIHF1
ZXVlDQo+ID4gPiAqLw0KPiA+ID4gZGlmZiAtLWdpdCBhL25ldC9zdW5ycGMvY2xudC5jIGIvbmV0
L3N1bnJwYy9jbG50LmMNCj4gPiA+IGluZGV4IGQ2ODA1YzEyNjhhNy4uNTg5MTc1N2M4OGIxIDEw
MDY0NA0KPiA+ID4gLS0tIGEvbmV0L3N1bnJwYy9jbG50LmMNCj4gPiA+ICsrKyBiL25ldC9zdW5y
cGMvY2xudC5jDQo+ID4gPiBAQCAtMjc5LDYgKzI3OSw5IEBAIHN0YXRpYyBzdHJ1Y3QgcnBjX3hw
cnQNCj4gPiA+ICpycGNfY2xudF9zZXRfdHJhbnNwb3J0KHN0cnVjdCBycGNfY2xudCAqY2xudCwN
Cj4gPiA+IMKgCQljbG50LT5jbF9hdXRvYmluZCA9IDE7DQo+ID4gPiDCoA0KPiA+ID4gwqAJY2xu
dC0+Y2xfdGltZW91dCA9IHRpbWVvdXQ7DQo+ID4gPiArI2lmIGRlZmluZWQoQ09ORklHX1NVTlJQ
Q19CQUNLQ0hBTk5FTCkNCj4gPiA+ICsJbWVtY3B5KCZ4cHJ0LT5iY190aW1lb3V0LCB0aW1lb3V0
LCBzaXplb2Yoc3RydWN0DQo+ID4gPiBycGNfdGltZW91dCkpOw0KPiA+ID4gKyNlbmRpZg0KPiA+
IA0KPiA+IEhtbS4uLiBUaGUgeHBydCBjYW4gYW5kIHdpbGwgYmUgc2hhcmVkIGFtb25nIGEgbnVt
YmVyIG9mIHJwY19jbG50DQo+ID4gaW5zdGFuY2VzLiBJIHRoZXJlZm9yZSB0aGluayB3ZSdyZSBi
ZXR0ZXIgb2ZmIGRvaW5nIHRoaXMgd2hlbiB3ZSdyZQ0KPiA+IHNldHRpbmcgdXAgdGhlIGJhY2sg
Y2hhbm5lbC4NCj4gDQo+IC4uIGFuZCBpdCBzZWVtcyB0aGUgdGltZW91dHMgY291bGQgYmUgZGlm
ZmVyZW50IGZvciBlYWNoLCBzbyBub3cgSQ0KPiB0aGluaw0KPiBrZWVwaW5nIGEgY29weSBvZiB0
aGUgbGFzdCBycGNfY2xudCdzIHRpbWVvdXRzIG9uIHRoZSB4cHJ0IGlzIHdyb25nLg0KPiANCj4g
V2UgY291bGQgdXNlIHRoZSBjdXJyZW50IHRpbWVvdXRzIGZyb20gdGhlIG5mc19jbGllbnQgc2lk
ZSBhZnRlciB3ZQ0KPiBmaWd1cmUgb3V0IHdoaWNoIG5mc19jbGllbnQgdGhhdCB3b3VsZCBiZSBp
bg0KPiBuZnM0X2NhbGxiYWNrX2NvbXBvdW5kKCkuDQo+IFRyb3VibGUgaXMgaWYgd2UgaGF2ZSB0
byBtYWtlIGEgcmVwbHkgYmVmb3JlIGdldHRpbmcgdGhhdCBmYXIgdGhlcmUncw0KPiBzdGlsbCBu
byB0aW1lb3V0IHNldCwgYnV0IHRoYXQncyBwcm9iYWJseSBhIHJhcmUgY2FzZSBhbmQgY291bGQg
dXNlDQo+IHRoZSB4cHJ0DQo+IHR5cGUgZGVmYXVsdHMuDQoNClRoZSBzdWdnZXN0aW9uIGlzIHRo
YXQgd2UgY29uc2lkZXIgdGhlIGNhbGxiYWNrIGNoYW5uZWwgdG8gYmUNCmFzc29jaWF0ZWQgd2l0
aCB0aGUgJ3NlcnZpY2UgcnBjX2NsaWVudCcsIGkuZS4gdGhlIG9uZSB0aGF0IGlzIGFzc2lnbmVk
DQp0byB0aGUgbmZzX2NsaWVudCBhbmQgdGhhdCBpcyB1c2VkIGZvciBsZWFzZSByZWNvdmVyeSwg
ZXRjLg0KDQpJZiB5b3Ugc2V0IGl0IHVwIGFmdGVyIHRoZSBuZWdvdGlhdGlvbiBvZiB0aGUgc2Vz
c2lvbiwgYW5kIGFmdGVyDQpwaWNraW5nIHVwIHRoZSBsZWFzZSB0aW1lLCB0aGVuIHlvdSBzaG91
bGQgaGF2ZSBhIHVzZWZ1bCB2YWx1ZS4gVGhlcmUNCndpbGwgYmUgbm8gb3RoZXIgY2xpZW50IGFj
dGl2aXR5IGFueXdheSB1bnRpbCB0aGUgY2xpZW50IGlzIG1hcmtlZCBhcw0KYmVpbmcgcmVhZHks
IHNvIHlvdSBjYW4gc2hvZWhvcm4gaXQgaW4gdGhlcmUgKGluIG5mczQxX2luaXRfY2xpZW50aWQo
KQ0KYXMgc3VnZ2VzdGVkIGJlbG93KSB0byBhZGRyZXNzIHRoZSBjb21tb24gY2FzZS4NCg0KVGhl
biB0aGVyZSBpcyB0aGUgaXNzdWUgb2YgYmluZF9jb25uX3RvX3Nlc3Npb24gKHdoZW4gd2UncmUg
c2V0dGluZyB1cA0KdGhlIGNhbGxiYWNrIGNoYW5uZWwgYW5ldyBiZWNhdXNlIHRoZSBzZXJ2ZXIg
bG9zdCBpdCkgYW5kIHRoZSBjYXNlcw0Kd2hlcmUgd2UncmUgYWRkaW5nIG5ldyB4cHJ0cy4NCg0K
PiANCj4gPiBpLmUuIHByb2JhYmx5IGRvaW5nIGl0IGluIG5mczQxX2luaXRfY2xpZW50aWQoKSBh
ZnRlciB3ZSBwaWNrZWQgdXANCj4gPiB0aGUNCj4gPiBsZWFzZSB0aW1lIChidXQgYmVmb3JlIHdl
IG1hcmsgdGhlIGNsaWVudCBhcyByZWFkeSksIGFuZCB0aGVuIGRvaW5nDQo+ID4gaXQNCj4gPiBp
biBuZnM0X3Byb2NfYmluZF9jb25uX3RvX3Nlc3Npb24oKSBpZiBldmVyIHRoYXQgZ2V0cyBjYWxs
ZWQuDQo+ID4gDQo+ID4gTm90ZSB0aGF0IHdlIGhhdmUgdG8gc2V0IHRoZSBiY190aW1lb3V0IG9u
IGFsbCB4cHJ0cyB0aGF0IGNvdWxkIGFjdA0KPiA+IGFzDQo+ID4gYmFjayBjaGFubmVscywgc28g
eW91IG1pZ2h0IHdhbnQgdG8gdXNlDQo+ID4gcnBjX2NsbnRfaXRlcmF0ZV9mb3JfZWFjaF94cHJ0
KCkuDQo+ID4gSXQgbWlnaHQgYWxzbyBiZSB3b3J0aCB0byBsb29rIGF0IE9sZ2EncyB0cnVua2lu
ZyBjb2RlLCBzaW5jZSBJDQo+ID4gc3VzcGVjdA0KPiA+IHdlIG1pZ2h0IG5lZWQgdG8gZG8gc29t
ZXRoaW5nIHRoZXJlIHdoZW4gYWRkaW5nIGEgbmV3IHhwcnQgdG8gdGhlDQo+ID4gZXhpc3Rpbmcg
c2V0Lg0KPiANCj4gQmVuDQo+IA0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNs
aWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNl
LmNvbQ0KDQoNCg==

