Return-Path: <linux-nfs+bounces-2024-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D89F5859A8C
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Feb 2024 02:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 518F21F20ECA
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Feb 2024 01:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC6E394;
	Mon, 19 Feb 2024 01:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="azaXGNMO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2112.outbound.protection.outlook.com [40.107.92.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388EEEBF
	for <linux-nfs@vger.kernel.org>; Mon, 19 Feb 2024 01:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708306440; cv=fail; b=JQwHSaKWNxTdl0vz5VYvuotsbusDGqlmRI9gfBKZLZ33fdUdapMWtFg2ikSR/ONU2mDHA9YrSdDz1u/52MSSIy5zvp9oI6cpNzP/ebAgy6SdDLC5EI93lQk2lxI8i/Er3UuotCd2aeM4gOv8qz+VhNzoRhStZZxNSq+B/o/nmmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708306440; c=relaxed/simple;
	bh=GbOvbOTwCF4pHykW8jVw4AFv9fx6xv9/CNKK8Bk5RqY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TA1JaSyBfBoV6fj7DOwTVkNgNVfAcZm1JKZpR8LuHM85TOTOIZCdATytkJ//DEyHSNhzfOVWkG5Fcq9MymdXSdNE/tQD7knRjml8MA9A/3DA7OZEuMqHLJUS9M8PIAzbv0J/3nlJv0nPVc4mFszqQIKU9/0a6JRqUnhsp/nJ1jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=azaXGNMO; arc=fail smtp.client-ip=40.107.92.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YKfywlneYBOWLwc1gqeICeoT627JpiyFPlyzise70g2Of74C44K2rKd3V32qWgj4UpuMso9xMDari7tx/MDOqfXhxeQry6rBUahU2dEcHoyBzQHq9/G5QWxi1A+mx87oIZWxVU9pU/WhbS7qdK0/rKrxco+hnLIbakXhSrq1+BStMwoSUdqo6hdOO2TRbK4Q4L/4O5LXtHwarQTu3vosdSTSC1HnqGN97Z1izgFSFRFLRuhAI46FY+nOgbbBtNqfDVbGoVAX4HyUQ1d2WzqHzJnShkCt6JAU8gXsnFD+5Cp2LcIhdzND5Yx0f6qMCEqjg3ByDtfIreanU0LVvNlVTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbOvbOTwCF4pHykW8jVw4AFv9fx6xv9/CNKK8Bk5RqY=;
 b=n1d5sj19DutZzftgOXlAzuF7JooVsdVRzrTvaeogeehk7mzwGE0K50rjUyBq8g4MUsM0fx+WlysFj09BaXBlgqMTCy+GOpnR2EPazdhwnXrfmhmDTlO5P/hP5WLFP541qZKH1Ky/I08NfT+10QoGvsEsuD3JPV5q94iQq1bZ3gzVpeUrSjf/gJlS9bP1MB5MUulMRP8W48gC4p6n2TgM0mnVyaPLrbd3x9nfLPoRsOtMr8DJwJZ67LxC9+Vc0BLQfZTHDweD6JKrmfKBjhM2rGXjXv0AS5VEcwx19WbWJgTScP/qA8wqvUwXTcXIQSdC5coQF6ZIGyO68Fvsa4H2oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbOvbOTwCF4pHykW8jVw4AFv9fx6xv9/CNKK8Bk5RqY=;
 b=azaXGNMOMjFql4a32EKZQnQy1W/X4uE00qB1ZtyoKqo8L1GHykbwF8XAzN9WFLXTsF7ReG8OGrKon79Q0i9HQgMLoKJCb7JAQ2GvSdaFnPEyP145n94Wts71LvWzK2jlkTYBNkua42MdvFU9g47Y+9Ve6eQ+2cL/ViYeo0UiQCo=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SJ2PR13MB6356.namprd13.prod.outlook.com (2603:10b6:a03:55f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Mon, 19 Feb
 2024 01:33:53 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::b349:9f81:ad39:865c]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::b349:9f81:ad39:865c%4]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 01:33:52 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "neilb@suse.de" <neilb@suse.de>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 1/2] nfsd: Fix a regression in nfsd_setattr()
Thread-Topic: [PATCH v2 1/2] nfsd: Fix a regression in nfsd_setattr()
Thread-Index: AQHaYHfUW0xTMio2ik6dSCtFnyTgcbEQqe6AgAA8gwA=
Date: Mon, 19 Feb 2024 01:33:52 +0000
Message-ID: <740318c3e5a063db6555455a434c4a86c0e9db48.camel@hammerspace.com>
References: <20240216012451.22725-1-trondmy@kernel.org>	,
 <20240216012451.22725-2-trondmy@kernel.org>
	 <170829343514.1530.1077342787397990579@noble.neil.brown.name>
In-Reply-To: <170829343514.1530.1077342787397990579@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SJ2PR13MB6356:EE_
x-ms-office365-filtering-correlation-id: 78183b19-c63d-4dc1-0d50-08dc30ead448
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 PuhgucrJNp2dZTk6/8Lob8ETTEB8R1QStxmhzKlwlWyKfaU1D7jibh8dXEo8q75X6ZG4S5m5G+zerLbKPEtMD6oRIyJiyHHqmT7WvgPxtrBY52ZuVN4Cy9dtJT3AooApzsENq288aRwUDbAaBwEbuqApIK2lIxCWCHInb/NIJJP7WFamVLEBncWuIgV4tcbUZ05/pVVG7fsLirjEvG+SdEr3uM1HrPG4AtdZdpryIHm6Tx44mN1pISD8vJIBQnWinlaXviq7/Qe2I7dq8lCbWK55AUEl3OIumTW0gglk7qNuw62B4XBLAYEgsOjutRaspeS7XsvE09q91A7B1fGJ+s6lGKkS68n2vvw1DaOABKTR6DCvhrTBrdFpkWdQSHrUph8nOS3SWYrgJoZnB1T6OJPYCvNDDprzeoWxdGsBe9fq3ZwkZRifRqhD2jxnu+a9sPO/X8Z7PTTAeU3KYhDGwKY4k81kL4ODKn7HJyCb4L9AOj4UHGu2am74FFdaykKw3AN3LHsCncW8UgLxhwzD4Szhdt0/ilxcat8r+Ofw5dHk3NUxuwYRq1YGKt32GfVLqMcgnvFp+vm++BsvQFnxkKKz2sby/Yp4L7cK3R3deBFG9Ic2ag7RFpowe5rOt6qb
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(136003)(39830400003)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(2906002)(66899024)(5660300002)(8936002)(76116006)(316002)(66446008)(66476007)(64756008)(6916009)(4326008)(66946007)(66556008)(2616005)(41300700001)(83380400001)(38070700009)(8676002)(86362001)(38100700002)(71200400001)(478600001)(54906003)(6486002)(6506007)(6512007)(122000001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bEVBUXpsWG5EMHpELzQ2cWduekk3cmFaRkZHcDZRNy9iZGRlaWttZWUvaWFV?=
 =?utf-8?B?WGpNV2NSbVZVVitCVW5OQS9BTm9rR0dzbHNMQklYK1A1T05uandPNnZWS3Yr?=
 =?utf-8?B?STc1T1F5cWJlL2FuMy9ZQk5EcDcrbk5xTlJHZlF1R2hnMGNrazlZVFA3VHJG?=
 =?utf-8?B?NHd1L2hod0xpQ1hJdWc5Wm5yN2NsS2ZGZmx2UnVlNkFTYW11U0N0aGRGUHZW?=
 =?utf-8?B?YlpTbjFlbC9EL0pqM3MySllJQmJobWlNcWFTK3FCSjF0dVNtNm5rV3pnYWg5?=
 =?utf-8?B?V2UyY3hHb2ZLWmFIdGFiYjZ2RXhHRGczUUt2OUVwM05qbXlpQUFaSEpKOVpK?=
 =?utf-8?B?T25iYUw0eEtFT21ZZVI0Y1FuR1NxeDE3dEZqM2VGTzNOWWdyNlFtTUhWdlc0?=
 =?utf-8?B?VVI3am5QS2dzRWowYTFxazR1bFdPbm1GbGFpSnpmRVNISktZUmk0bTRUUlFs?=
 =?utf-8?B?ODRoV01wYlBuT004TjNJbkErZDB5SEliUlRBZzhOMUNsSzQ5ZGw1U2M5ZWlS?=
 =?utf-8?B?amV1TDRwMEVkbk9vY3V5QmNEM0w4d0RhLy9zbnFpT2F3c2VXdXhab3JyRHU2?=
 =?utf-8?B?ZEpnbEorUHFHSys4NkpsUnN2K1NiZDdHbUxKa0xoRG8rZEN0U1dsWWxmaFZJ?=
 =?utf-8?B?RHRjcU5xQUxzQ0VZNlBFRGhpbmxiMjRoUjZ4NWFianp1MjVJK0FUajRqK2J3?=
 =?utf-8?B?dTdVcTFTWjE0TUpRMzRrL2l3aWJvZnpoZmJ3LzIyZ0tyKzNnakdzeEgwYUxJ?=
 =?utf-8?B?VnJKQlRleVR1amN2V2VkNWFHY0ppQ1FwNFR3ZGRXN25DUjdrMVhhbEdaR0Zj?=
 =?utf-8?B?UTNlMzR1S3JCY1krZStwOTZhdXVoeWxWL1NPNjEva2U4UlBZYUhIS0NlVXg2?=
 =?utf-8?B?QUhCOWFrcFFiODRCdGZvaDdWSjlDNDZIMHFyaEorYmVDWkkxUlRkNFkyYkIz?=
 =?utf-8?B?RWJCYTlma21kNDdxL3ZOQjRNNU94RUJvZHpUSHVWWmQ4Y0hkcnd0YjI4YWdC?=
 =?utf-8?B?TlNQYlNldWNyUVNVa240cXg3MEVKRmpLSkU0YWVocDRvU25HV3IwRXlJRU9n?=
 =?utf-8?B?aVV0dmI3aDV3TU1jLzg5M0F3T1EzbU1aenByTWFWbWZkeElqQnU1ckZtc21F?=
 =?utf-8?B?M2FvN3JiVit1TndBeXBWZVNvRENnSG0xaW1aQW1rck9iVkZtQXJ1NG4zc1pY?=
 =?utf-8?B?V3BWWGJoMmNscEsvdUo5S2ZEaFR1T3B2Q2N4bTVvUWphM0Q4OFVraGpkUWtr?=
 =?utf-8?B?WkxuNDFKMXF0UHpmVFlyN2NMUG82OWM4dWdMazZNSWtmZmlBTi9ob3UzT3Iy?=
 =?utf-8?B?YXJScDJSOHVtVmNnekxlTWVwREhoWUFjRnRGWDFJVVZWd29hU2grM25Nd0Vh?=
 =?utf-8?B?aFhlQWxFZWF1L29nWEhhdmRaTld1WXpoNnMxTmx5d09tVjhjNlRNWXk1c1d0?=
 =?utf-8?B?ZFJ5dEtCM3lLMnVjcnpsUDBXSk5hUmtETEdTNjc0eEptaTR0Qmh6eGhkMlJp?=
 =?utf-8?B?eENLeUhsbElrejl1RmxIQ1pnUE1OVnhsaDVHWS9JMkl6RjBQNC9XUVBuVWVW?=
 =?utf-8?B?NTF4T2MvelRPbTVaV1IrN01qQk5aS3pLYklIUVBwRkEyWmI1TjlZNEs5NVJB?=
 =?utf-8?B?QU5meVdra0g0bFEvaHhrbWdHWFN6VER0cUF5Y1Z1Vk5jWkRwWlUyNmFwS1lJ?=
 =?utf-8?B?bURXYVVyMzJ3TjQ1cXRMS3dUNDFnZE9sL1NGY2tBcG85R2NqN1pVRkcrWDBo?=
 =?utf-8?B?cnEwMHUzd3luTVFLQVhTYU1sdk83VEhZWDRUUFREMzV3ZEVIK0M5YmZYUFY2?=
 =?utf-8?B?K3NHSnBaNTF2VmJNdjVhektFK01YM2wzUXhVRm1Nci81TERzOHlUdzY5dzl6?=
 =?utf-8?B?ZStRYmpRdjgrNW4rNEtpLytQWWp3anpJRGxQMC9ZOCtwWlpnaFlRNUxFRWYw?=
 =?utf-8?B?R0VOQ1FBZnFOK1lZd1hkZG9DSWNGSmNYWmdoM2ZablBDUlBIeVJCM3FtNEpU?=
 =?utf-8?B?VmZFYlRBTXJyUmsxa0lWQ2Q4SjVJUDNIcWFSUnVOcllzSjBNV2lHRkFNSVlu?=
 =?utf-8?B?d0Jtd1JwYVVFK01tUEgzNlFvcHpVL3kxYWhsSzl1SWxUU2hNVGhXNEhtQzBp?=
 =?utf-8?B?akFXejgxZVlDVTlCOExwQUhjZ2NaS0tJWGFWODg1UDV4U0FSY2xRVjN4S1cx?=
 =?utf-8?B?dExnenMvMG5GY3dGeUl5V3M4bWhBZlJLSkNYMlpER2thRkliTGxOcndIQWFM?=
 =?utf-8?B?RkI3UCs5YXg0b29qUTdPSmFNallRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A74D0870497244F89FA3D40A5E1D784@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 78183b19-c63d-4dc1-0d50-08dc30ead448
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 01:33:52.1205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SQjxQ8qNF7u9vLPlJ2EU1nCBUY5ygD5uROfwcptFrCyMbYLzB1Y/aTFxjI0XzItKvI8TvT5RXhlP3BmL8R03pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR13MB6356

T24gTW9uLCAyMDI0LTAyLTE5IGF0IDA4OjU3ICsxMTAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IEZyaSwgMTYgRmViIDIwMjQsIHRyb25kbXlAa2VybmVsLm9yZ8Kgd3JvdGU6DQo+ID4gRnJvbTog
VHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tPg0KPiA+IA0K
PiA+IENvbW1pdCBiYjRkNTNkNjZlNGIgYnJva2UgdGhlIE5GU3YzIHByZS9wb3N0IG9wIGF0dHJp
YnV0ZXMNCj4gPiBiZWhhdmlvdXINCj4gPiB3aGVuIGRvaW5nIGEgU0VUQVRUUiBycGMgY2FsbCBi
eSBzdHJpcHBpbmcgb3V0IHRoZSBjYWxscyB0bw0KPiA+IGZoX2ZpbGxfcHJlX2F0dHJzKCkgYW5k
IGZoX2ZpbGxfcG9zdF9hdHRycygpLg0KPiA+IA0KPiA+IEZpeGVzOiBiYjRkNTNkNjZlNGIgKCJO
RlNEOiB1c2UgKHVuKWxvY2tfaW5vZGUgaW5zdGVhZCBvZg0KPiA+IGZoXyh1bilsb2NrIGZvciBm
aWxlIG9wZXJhdGlvbnMiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFRyb25kIE15a2xlYnVzdCA8dHJv
bmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4NCj4gPiAtLS0NCj4gPiDCoGZzL25mc2QvbmZz
NHByb2MuYyB8IDQgKysrKw0KPiA+IMKgZnMvbmZzZC92ZnMuY8KgwqDCoMKgwqAgfCA5ICsrKysr
KystLQ0KPiA+IMKgMiBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9mcy9uZnNkL25mczRwcm9jLmMgYi9mcy9uZnNk
L25mczRwcm9jLmMNCj4gPiBpbmRleCAxNDcxMmZhMDhmNzYuLmU2ZDg2MjRlZmM4MyAxMDA2NDQN
Cj4gPiAtLS0gYS9mcy9uZnNkL25mczRwcm9jLmMNCj4gPiArKysgYi9mcy9uZnNkL25mczRwcm9j
LmMNCj4gPiBAQCAtMTE0Myw2ICsxMTQzLDcgQEAgbmZzZDRfc2V0YXR0cihzdHJ1Y3Qgc3ZjX3Jx
c3QgKnJxc3RwLCBzdHJ1Y3QNCj4gPiBuZnNkNF9jb21wb3VuZF9zdGF0ZSAqY3N0YXRlLA0KPiA+
IMKgCX07DQo+ID4gwqAJc3RydWN0IGlub2RlICppbm9kZTsNCj4gPiDCoAlfX2JlMzIgc3RhdHVz
ID0gbmZzX29rOw0KPiA+ICsJYm9vbCBzYXZlX25vX3djYzsNCj4gPiDCoAlpbnQgZXJyOw0KPiA+
IMKgDQo+ID4gwqAJaWYgKHNldGF0dHItPnNhX2lhdHRyLmlhX3ZhbGlkICYgQVRUUl9TSVpFKSB7
DQo+ID4gQEAgLTExNjgsOCArMTE2OSwxMSBAQCBuZnNkNF9zZXRhdHRyKHN0cnVjdCBzdmNfcnFz
dCAqcnFzdHAsIHN0cnVjdA0KPiA+IG5mc2Q0X2NvbXBvdW5kX3N0YXRlICpjc3RhdGUsDQo+ID4g
wqANCj4gPiDCoAlpZiAoc3RhdHVzKQ0KPiA+IMKgCQlnb3RvIG91dDsNCj4gPiArCXNhdmVfbm9f
d2NjID0gY3N0YXRlLT5jdXJyZW50X2ZoLmZoX25vX3djYzsNCj4gPiArCWNzdGF0ZS0+Y3VycmVu
dF9maC5maF9ub193Y2MgPSB0cnVlOw0KPiA+IMKgCXN0YXR1cyA9IG5mc2Rfc2V0YXR0cihycXN0
cCwgJmNzdGF0ZS0+Y3VycmVudF9maCwgJmF0dHJzLA0KPiA+IMKgCQkJCTAsICh0aW1lNjRfdCkw
KTsNCj4gPiArCWNzdGF0ZS0+Y3VycmVudF9maC5maF9ub193Y2MgPSBzYXZlX25vX3djYzsNCj4g
DQo+IFRoaXMgbG9va3MgY2x1bXN5Lg0KPiBJIHRoaW5rIHRoZSBiYWNrZ3JvdW5kIGlzIHRoYXQg
TkZTdjMgbmVlZHMgYXRvbWljIHdjYyBhdHRyaWJ1dGVzIGZvcg0KPiBmaWxlIG9wZXJhdGlvbnMs
IGJ1dCBORlN2NCBkb2Vzbid0IC0gaXQgb25seSBoYXMgdGhlbSBmb3IgZGlyZWN0b3J5DQo+IG9w
cy4NCj4gU28gTkZTdjQsIGxpa2UgTkZTdjIsIGRvZXNuJ3Qgd2FudCBmaF9maWxsX3ByZV9hdHRy
cygpIHRvIGJlIGNhbGxlZA0KPiBieQ0KPiBuZnNkX3NldGF0dHIoKS4NCj4gDQo+IE5GU3YyIGF2
b2lkcyBpdCBieSBhbHdheXMgc2V0dGluZyAtPmZoX25vX3djYy7CoCBIZXJlIHlvdSB0ZW1wb3Jh
cmlseQ0KPiBzZXQNCj4gZmhfbm9fd2NjIHRvIHRydWUgZm9yIHRoZSBzYW1lIGVmZmVjdC7CoCBT
byB0aGUgY29kZSBpcyBjb3JyZWN0Lg0KPiBCdXQgaXQgaXMgbm90IG9idmlvdXMgdG8gdGhlIGNh
c3VhbCByZWFkZXIgd2h5IHRoaXMgaXMgaGFwcGVuaW5nLg0KPiANCj4gSSB3b3VsZCByYXRoZXIg
YSAid2NjX3dhbnRlZCIgZmxhZyBvciBzaW1pbGFyLCBidXQgdGhhdCBjYW4gYmUgZG9uZQ0KPiBp
biBhDQo+IHNlcGFyYXRlIGNsZWFuLXVwIHBhdGNoIGxhdGVyLg0KDQpUaGF0IGlzIGluIHRoZW9y
eSB3aGF0IHRoZSBmaF9ub193Y2MgZmxhZyBpcyBmb3IsIGhvd2V2ZXIgdGhlIGlzc3VlIGlzDQp0
aGF0IGl0IGdvdCBvdmVybG9hZGVkIHRvIGFsc28gbWVhbiAnY2hhbmdlX2luZm80IHdhbnRlZCcg
d2hlbiB3ZSBhZGRlZA0Kc3VwcG9ydCBmb3IgTkZTdjQgdG8ga25mc2QuDQpORlN2NCBkb2VzIG5v
dCBoYXZlIGEgY29uY2VwdCBvZiB3ZWFrIGNhY2hlIGNvbnNpc3RlbmN5LCBidXQgaXQgZG9lcw0K
dHJ5IHRvIHRyYWNrIHVwZGF0ZXMgdG8gdGhlIGNoYW5nZSBhdHRyaWJ1dGUgYXRvbWljYWxseSAo
aWRlYWxseSkgZm9yDQptb3N0IG9wZXJhdGlvbnMgdGhhdCBjaGFuZ2UgdGhlIGRpcmVjdG9yeSBj
b250ZW50cy4NCg0KSU9XOiBJIHRoaW5rIGEgYmV0dGVyIGNsZWFuIHVwIHdvdWxkIGJlIHRvIHNl
cGFyYXRlIG91dCAnd2NjJyBhbmQNCidjaGFuZ2VfaW5mbzQnIGFzIHJlcHJlc2VudGluZyBkaWZm
ZXJlbnQgZnVuY3Rpb25hbGl0eS4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBj
bGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFj
ZS5jb20NCg0KDQo=

