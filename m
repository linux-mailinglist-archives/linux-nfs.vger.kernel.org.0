Return-Path: <linux-nfs+bounces-1917-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 596A1853C92
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Feb 2024 21:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DE691C226C9
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Feb 2024 20:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B721612FE;
	Tue, 13 Feb 2024 20:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Eurrh30g"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2098.outbound.protection.outlook.com [40.107.102.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C07B612FD
	for <linux-nfs@vger.kernel.org>; Tue, 13 Feb 2024 20:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707857945; cv=fail; b=Spat2/JGxf5VIk6/D5m4EEplwJmUAL6wJZgpy2D7TNMGiFPmvCVbAl/R0XAOkJdxmF0chXXikdZ1dWepFGQ2jI4mlV3U19M5AEmjnl4WC6xyscczKSFQ1m8O3jAM4XICUntgtyaYljdmbpuP5wqt5inONgU22sbjiWzli+Ex7tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707857945; c=relaxed/simple;
	bh=t+hY1ZfjaPFnrZUQ83WXLa5UsicAVLN/r1uPA+aWCIE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Cz5zQTBW10XQ9tfTuxN9xBTHYsmshvVKBfzks6JJoTUb/4OhIqgXv/vJV+cmQ3+dzRt+EjB5qZVXE9exdrl61LIyTXmoOh71t4+dA7UtFm79e2xcNcI5VeBQnJYh9IQJWV/Pwn2o1gq4hQiDfCfG2ezZeHN7c1aBbjqlj5MU0WU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Eurrh30g; arc=fail smtp.client-ip=40.107.102.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OapRZVUE0+Iv8FGIFCD/ih9sVdlEan/EJL39SWc7g/yNkKir3nvdY25zvHrzZo85wOsHqSFlUu6f5HtuWwzrtHqJIb3rxxTSz6l2qWTkoL/qogD683oLQr4TMZq1sY4FQsrc4pUSNNDxTM0L30GymEZV00Gunq+W5HRIm82LNwyRkZlf2OzwxtDmUP8QQQeAR8VLp8N0GcLykn+E2FvVX37ny8xW+HNKV3508wcrHWJydc9bEc9S3oEF8rOZA1v1TweHUY0cCsFwM3HL1LVk5oKKCHy7q9lhiukiUHXxCKs7cH3TW4/oXuN+0x/FBiXLqWQW0D8stlK7GBFNLacYpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+hY1ZfjaPFnrZUQ83WXLa5UsicAVLN/r1uPA+aWCIE=;
 b=J75GjNwPquGxRFUzShtulWnWmT1yYKvh/vthsKgvJjb5ocTWfNPWhwwxYO51TZZbrYzrW414Vxxaq0n6vX/Lz8u3H0ZzmTmrGoMoiCq53+s6PVWPh5uuSpd7AbkCv5lNg/NrHFi1WKDPa8EJQMdVhvHmFwssHRTDkJfgo0Pqb2cFvde9DA+klfyIWVgqjFB2gtofRw99Jp8Fnbyl6GnHb/r+FgCrxyiAytiSZt+u0k1JezwvWLXqPnUMbYrlG2G/rIHZaZpSSRem5JVyMKgPQUHosDtmk5lE4QNjcT4E5uB4jk3Ndm1u6IwRUUN63bbf1pSikC6rUpw0RfXtKeFcjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+hY1ZfjaPFnrZUQ83WXLa5UsicAVLN/r1uPA+aWCIE=;
 b=Eurrh30gn3weNeZSarNW4AB6EYfylB3MYx9LuBMYN+MmAoV+NuIPY7Farpd0K43Gm8nC6izcQ1769m7UreWz3A3titgDbGeyH/g1JomozSNBVMbwr1u1C6OZNFSggzitwYb/3M+Za/taWIRSYXQKcI/9MJ7ihf7lvjpBVKht4eM=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by PH7PR13MB6342.namprd13.prod.outlook.com (2603:10b6:510:2f0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.33; Tue, 13 Feb
 2024 20:58:59 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::b349:9f81:ad39:865c]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::b349:9f81:ad39:865c%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 20:58:59 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "jlayton@kernel.org" <jlayton@kernel.org>, "dan.f.shelton@gmail.com"
	<dan.f.shelton@gmail.com>
CC: "tom@talpey.com" <tom@talpey.com>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>
Subject: Re: Public NFSv4 handle?
Thread-Topic: Public NFSv4 handle?
Thread-Index: AQHaTzC1eEBD5tPAvkCLlODffkTZnbEBPMYAgAAmx4CAANhZgIAGm/4AgAAIpwA=
Date: Tue, 13 Feb 2024 20:58:59 +0000
Message-ID: <3fa863dc2c1ec75416704a9cdaa17bf1a2e447e4.camel@hammerspace.com>
References:
 <CAAvCNcBvWjt13mBGoNZf-BGwn18_R6KAeMmA7NZOTifORLEANg@mail.gmail.com>
	 <CAAvCNcAkZFkLU-XtmJy30AT7ad_MvSzZTMEk86PiZXLdcMg4fA@mail.gmail.com>
	 <b14648b0-a2f7-451a-a56b-6bb626c4ffa8@talpey.com>
	 <14e1e8c8613c74d07cb0cefbcebbf79a3a57311e.camel@kernel.org>
	 <CAAvCNcAsow-QTPYLm0fUNX3K5X4Aci=aFi+hi4a0S8k19oa-KA@mail.gmail.com>
In-Reply-To:
 <CAAvCNcAsow-QTPYLm0fUNX3K5X4Aci=aFi+hi4a0S8k19oa-KA@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|PH7PR13MB6342:EE_
x-ms-office365-filtering-correlation-id: 2fb53366-f0f3-44a1-948b-08dc2cd699bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 qv06avaurIeLo67WNVUOzLuGuL6VaQNxcM2NtI2uK+2m+fuV7otp6vr2Hh0d6bgQV5wLhjJzA579pE1ZUAlN+YUdKSUjcYFtB9zdC2gT+4lDSdNZHIEvmyfi714HvtTgLI3Mb82Dc1Pkwzps7HaGqE+dD/dzBVor5XSOiib7xgN/YU/41gl8YIUspeGrivHIA4wgs8948qenIMO6a3f+WpL5TY6yUq5pRmwxvYVDIw/pMA5kpmTLsBmSjoqZjRZDWCpHaMEkbkjyWmIClbR6q8GrNivNuDoWhtdNNKdUcwlSZALsaqeTDFV7Su3kQmtGXJgMANxr6+lwSLLRndxgwsa3oNSMP88+2JSO/vwGSRKDAcJxWkpFtMLYhebcp9FHHBxKjxdx+edlNp/ImWepPS4sSdq+1ZafrVk4de/yVpy0v96gJIbslNwqnnYVXeLMwvPcD3OeIXj4AsIxJXle6fuCUDIuoETcvWfO3vOSD7lGFQGJl+RKyhwiMlNMLVMWCDBhtOWCBtkUo+dChGcQkruTTaTTxZHJfQjVIpmL1Gcp9mfJAIPHmXx3uNX7bCiWOC51NPVEULHKzuO0DQAFDjmLdSTEj0KMYJ/xm74KCoQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(39850400004)(396003)(136003)(230922051799003)(230473577357003)(230273577357003)(64100799003)(451199024)(1800799012)(186009)(8676002)(8936002)(5660300002)(2906002)(4326008)(66899024)(7116003)(83380400001)(36756003)(2616005)(38100700002)(122000001)(38070700009)(86362001)(110136005)(316002)(66476007)(66946007)(76116006)(54906003)(64756008)(71200400001)(66446008)(6506007)(66556008)(53546011)(6512007)(966005)(6486002)(478600001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SDVSVlVMMU5vV2FhYnU2Y1R4Sk13eHZrMTd0MGwvR09aaUNyMkZySktsa3Q1?=
 =?utf-8?B?NE9KamlzU3ZpRks0eTBJeFdvZElud0FOeFVSUEV6MTJYd1lVUkpueVYxNmph?=
 =?utf-8?B?ZDRuWjIwbmxPNkJFdGNHM2hHb2lrZitJUUxObzhQS3NXU0N2RS8rOTJ6SDlw?=
 =?utf-8?B?b1dYeEx5c2Z2bGtNRW16aDdNdVo0YkphZCs4aUZ4cVdMcGxtYmdDaEtkTDJT?=
 =?utf-8?B?L0ZnREwzSGhabytTWVJrSXk2Q2NtbVpLMnE2L3h2aDBoUzEwWCt2MjRkOWpt?=
 =?utf-8?B?L3VQc3FBS1hsd3lsZEhPREV4cERUMnhhVTltS1hVZ0xWMXhQdC9Wc2RPSmVH?=
 =?utf-8?B?ZzVBNnhWeVh2SFZ0eXVnWDR2TVlEKzQ2QkpnYkZSbWhaMGhGaDdRdUZyUWYz?=
 =?utf-8?B?NG9WTmk1MnM1WGJFY3Fna1hSbjZoK29ySVppb1JVSDhHdW9aMHVHblE2YzJK?=
 =?utf-8?B?YzlINkZldXZ0RDl2ZzZDaGh5NGtLNW5YTnNTQ0tTbWZVTGQrTUJCUi9UWG4r?=
 =?utf-8?B?R0FYTkwwYmxlb0hwcUxNdEE2QmxLWkMvT1lTdnVVcFRvUUJLWVdmTHJyZ09a?=
 =?utf-8?B?NVNtakNCQkxPaG92cXNPM25SVzRQSkZjdnhZRzAwQnB6ejExTXl0VXJkR1hZ?=
 =?utf-8?B?NnpBN2w2Y3N4WVFlUzBRVkljQW1PUk5zZ2hYc0pIaWUwN0s4bzJsZzYzcFYz?=
 =?utf-8?B?bzNaZG12NGRLdXNjTUptaFA0Yi9PSE9JNk81cEEyaGRIaHlqRHBETlJNcDda?=
 =?utf-8?B?ZmhNS016elpZZTZheUoyNkEvMTRrZml5aytXeldiT0xjYUN0Wnh4NWV1VWVQ?=
 =?utf-8?B?N1hXU0IzQ1dNYitCYnc0NmdGcVRLWFNvY1lkdDJMcTlKNTFZaFErWUtiZDkx?=
 =?utf-8?B?VzFkc3NudmdBdzdmWmFCUDJyUG5xZnVZT2V1RjEwYnErcVcyU3ZmTlI4SFQ0?=
 =?utf-8?B?cXJ2alBCeWwwZU9oNE5qYUF6cUdPQVpWL3FJNTVReHRXRm5IOTZDZmhCTVgv?=
 =?utf-8?B?Y2hDelBiQUZKeFQ3bVZ4LzZZZzNOeGNOcGVsR2FmSjhTYy83N3ZLS09DQ20z?=
 =?utf-8?B?NDl4SWdZcjNXWUgveEUrSmlHa0xuZWs2a0xSNkM3QnVyenJrNW0yR2dPcVZO?=
 =?utf-8?B?bFRjRmd1S3FyNEl6YjN6UkgvSVI2UnJnbFc1VExMOHhPYmlOT25rWlVHVXky?=
 =?utf-8?B?dGhrVndIV1UwcFg3TVlTWURkckRmL0VXeEpQaDFnNzdtNWxoMzhmd1E5SFg2?=
 =?utf-8?B?WFQ4MlhELy91aDVFR08yUmljdDU0c2diZWowU29NL2RhK1dQMGMvVlFkZjRw?=
 =?utf-8?B?aDVtVWhlUnpneEdpWFJVUXROWXVuMTFaVldZbXR4d3lVN2xHUFByci84cStF?=
 =?utf-8?B?OER5RHdaTU5RZUN0YmxUazdwcHYyVkJyTnVvVWdRQUpwbnlRYktsd3FoOGk3?=
 =?utf-8?B?MExiTTZOd3JFTFNvVTNMVHJhcEZGRGFaUU1PcXpYNkw0dUdwdmRxS0w4SUxm?=
 =?utf-8?B?bVU3cWR3eUtSSHlDSy9OWnRta0N6aTAzSEN4Y0I2ZGpGay9DY3FSOFZoN2x4?=
 =?utf-8?B?Q2JEdTB5ZVluWDdWVWk5VldrNVFqTDdxaFp2UG1ObmdCQzBUaHVicDVnL285?=
 =?utf-8?B?S1o5b3pwWS9vVUVEazFnL2MxQ25sRlUwVU55ZWdLckxVcDB2Q2RUNE1SN3hz?=
 =?utf-8?B?a2dXM2tNRml4UHpaSU51SEs4Q2xrUmJCSDc0RGdaZnJncllOb2tRMDlUWWhJ?=
 =?utf-8?B?dmZ1cHZMMmtUOG1Ea0tMd0RyditxZUdQTjl4R2VNSXFHRCt1eWZvTFd3ZFIw?=
 =?utf-8?B?citveFljTXlYQmhZdXFlQXlqQVdSMUlwY2ZMSzVBTGZmRjcxMmFydkVscnJm?=
 =?utf-8?B?N2xkWGp1MnZvN2ZuZ2xiRmdXZTZPeWFjK0V5L3VqNDFCN2ZUejZpVjVIdXhK?=
 =?utf-8?B?czVHNm93OE5MNTVrOThXVVJvSTJIYU5iWnV6Y25mVGZKYitTNXdSc0xreWdp?=
 =?utf-8?B?UTRXTnNJTWlraGUxMCtFREh0cENzWGdNWnV0VnFvaWFpcFVwaHV3RVR6dG9H?=
 =?utf-8?B?SFhGa05ORndQYlRjanFENWcwbUZ4VUdKN1JhNVVSc1EvT3d4U1NoQWV4L0RQ?=
 =?utf-8?B?M3lZQzMrY1hlZXZuRVphU3RTQ2J3SnRoZS9QVnlmMEhYNWtHck16d2w0RVVW?=
 =?utf-8?B?dHBSQzRxYlFtelRzNEVwejAxZFFwa2hTNnpaUDJWRGRqTitLODludUljTDdu?=
 =?utf-8?B?Z05MOGhGNFF5UXhiMmdCZnJTb0pnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D24E5BDFB32554CAB2552E8C92F86D8@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb53366-f0f3-44a1-948b-08dc2cd699bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2024 20:58:59.3432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hlNNRmoVu8zdbFSfjy1BdiTpoUSfwAfnnp/rV3M/0dg46oc+Z+TjkiIotZUGdNTDbZwXKJsCzo2t8NDivSj4UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB6342

T24gVHVlLCAyMDI0LTAyLTEzIGF0IDIxOjI4ICswMTAwLCBEYW4gU2hlbHRvbiB3cm90ZToNCj4g
W1lvdSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSBkYW4uZi5zaGVsdG9uQGdtYWlsLmNvbS4g
TGVhcm4gd2h5DQo+IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJv
dXRTZW5kZXJJZGVudGlmaWNhdGlvbsKgXQ0KPiANCj4gT24gRnJpLCA5IEZlYiAyMDI0IGF0IDE2
OjMyLCBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPiB3cm90ZToNCj4gPiANCj4gPiBP
biBUaHUsIDIwMjQtMDItMDggYXQgMjE6MzcgLTA1MDAsIFRvbSBUYWxwZXkgd3JvdGU6DQo+ID4g
PiBPbiAyLzgvMjAyNCA3OjE5IFBNLCBEYW4gU2hlbHRvbiB3cm90ZToNCj4gPiA+ID4gPw0KPiA+
ID4gPiANCj4gPiA+ID4gT24gVGh1LCAyNSBKYW4gMjAyNCBhdCAwMjo0OCwgRGFuIFNoZWx0b24N
Cj4gPiA+ID4gPGRhbi5mLnNoZWx0b25AZ21haWwuY29tPiB3cm90ZToNCj4gPiA+ID4gPiANCj4g
PiA+ID4gPiBIZWxsbyENCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBEbyB0aGUgTGludXggTkZTdjQg
c2VydmVyIGFuZCBjbGllbnQgc3VwcG9ydCB0aGUgTkZTIHB1YmxpYw0KPiA+ID4gPiA+IGhhbmRs
ZT8NCj4gPiA+IA0KPiA+ID4gQXJlIHlvdSByZWZlcnJpbmcgdGhlIHRoZSBvbGQgV2ViTkZTIHN0
dWZmPyBUaGF0IHdhcyBhIHYyL3YzDQo+ID4gPiB0aGluZywNCj4gPiA+IGFuZCwgSSBiZWxpZXZl
LCBvbmx5IGV2ZXIgc3VwcG9ydGVkIGJ5IFNvbGFyaXMuDQo+ID4gPiANCj4gPiANCj4gPiBPbmUg
bW9yZSB0cnkhIEkgdGhpbmsgbXkgTVVBIHdhcyBoYXZpbmcgaXNzdWVzIHRoaXMgbW9ybmluZy4N
Cj4gPiANCj4gPiBORlN2NC4xIHN1cHBvcnRzIHRoZSBQVVRQVUJGSCBvcDoNCj4gPiANCj4gPiBo
dHRwczovL3d3dy5yZmMtZWRpdG9yLm9yZy9yZmMvcmZjODg4MS5odG1sI25hbWUtb3BlcmF0aW9u
LTIzLXB1dHB1YmZoLXNldC1wDQo+ID4gDQo+ID4gLi4uYnV0IHRoaXMgb3AgaXMgb25seSBmb3Ig
YmFja3dhcmQgY29tcGF0aWJpbGl0eS4gVGhlIExpbnV4IHNlcnZlcg0KPiA+IHJldHVybnMgdGhl
IHJvb3RmaCAoYXMgaXQgU0hPVUxEKS4NCj4gDQo+IE5vLCBJIGRvIG5vdCBjb25zaWRlciB0aGlz
ICJiYWNrd2FyZCBjb21wYXRpYmlsaXR5Ii4gVGhlICJwdWJsaWMiDQo+IG9wdGlvbiBpcyBhbHNv
IGludGVuZGVkIGZvciBwdWJsaWMgc2VydmVycywgbGlrZSBwYWNrYWdlIG1pcnJvcnMNCj4gKGUu
Zy4NCj4gRGViaWFuKSwgdG8gaGF2ZSBhIGJldHRlciBzb2x1dGlvbiB0aGFuIGh0dHAgb3IgZnRw
Lg0KPiANCg0KUFVUUFVCRkggb2ZmZXJzIG5vIGV4dHJhIHNlY3VyaXR5IGZlYXR1cmVzIG92ZXIg
UFVUUk9PVEZILiBJdCBpcw0KbGl0ZXJhbGx5IGp1c3QgYSB3YXkgdG8gb2ZmZXIgYSBzZWNvbmQg
cG9pbnQgb2YgZW50cnkgaW50byB0aGUgc2FtZQ0KZXhwb3J0ZWQgZmlsZXN5c3RlbS4NCg0KQSBt
b3JlIG1vZGVybiBhcHByb2FjaCB3b3VsZCBiZSB0byBjcmVhdGUgMiBjb250YWluZXJzIG9uIHRo
ZSBzYW1lDQpob3N0OiBvbmUgdGhhdCBzaGFyZXMgdGhlIGZ1bGwgbmFtZXNwYWNlIHRvIGJlIGV4
cG9ydGVkLCBhbmQgb25lIHRoYXQNCnNoYXJlcyBvbmx5IHRoZSBiaXRzIG9mIHRoZSBuYW1lc3Bh
Y2UgdGhhdCBhcmUgY29uc2lkZXJlZCAicHVibGljIi4NClRoYXQgYXBwcm9hY2ggcmVxdWlyZXMg
bm8gZXh0cmEgcGF0Y2hlcyBvciBjdXN0b21pc2F0aW9uIHRvIGV4aXN0aW5nDQprZXJuZWxzLg0K
DQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1t
ZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

