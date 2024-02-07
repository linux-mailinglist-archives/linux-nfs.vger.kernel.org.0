Return-Path: <linux-nfs+bounces-1818-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9343684CD75
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Feb 2024 15:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 904001C24D45
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Feb 2024 14:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A552A7FBAB;
	Wed,  7 Feb 2024 14:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Z4OCVP/2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2112.outbound.protection.outlook.com [40.107.223.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF5F7F465
	for <linux-nfs@vger.kernel.org>; Wed,  7 Feb 2024 14:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707317822; cv=fail; b=Bj9zUp3cSbb7s3xebT60UTtEEeWGzUMD2DVfLKSyJnwirg7+/AjEiABcUNTMBmcM2mGOIj7W7/Vr+0nAUCHpblWkc3zdXAPHgSZ+d8d1T09+99sF8/NLua+nYyQY7ZIIz8n4OTOOSWg92DWPuflyH0l8yxxSPb2u1nmVeTgYrcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707317822; c=relaxed/simple;
	bh=JL06tRbc00vfVWHLOrRmGzaV+63VAuzBlvc83ptZqgk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MnZQ40D39fvNOUkAZJHDf/br8gsXH9GUsmMypeRoXXNoS7IJWxbS1g+rlf4aohYkw4UNnCDklhY/vdmtlydooLI+9TMUEDg9Ip+RmeM7pxDjwcb011ez82zvD2y9/tGI7lR3c/+Q+25G0kWfVLYci2ZCbX0HxGzN8DK1mRShYko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Z4OCVP/2; arc=fail smtp.client-ip=40.107.223.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kuLDRtOcfYwlpcNeMuaXyMUzCAkV0TMc/35lAaG2Fm0icKN3UVFXHaQCOklHhPbuPPPpqOdwSWHG9Vksg2jiZyAeNGwGtxLPN3ODrZbJ8OACxYTarMZBhDQ5RnGTeJm7MKbMK7FzZ1CuQZoC0n2hFln9CgPsMvsqQ0NbfkRRtskWTC3zZRSTZAWInHxGK+XA2GjOixzwbMMbwKUk6pIU/YZo0CgA8E/fzV2wzlax6XbPRN2ob08u2qGo9AKK470ZlNyLiBXGqj5HIPjI6GO9c/szvEC6Qtw4S2oZVKfWbopATkOV+jwTGRPdYRp+4Fm46l18xL9swiZDaFDtrYO6jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JL06tRbc00vfVWHLOrRmGzaV+63VAuzBlvc83ptZqgk=;
 b=VRCMyXMdmmv0LJHmi+ULuP3e2q3q8eIMcwYb0j7OABaV1587I34QkL99mCL3zIbDDPMLhkrJZEAgLkiMOUfCwJiKTvabarT8UFXhc7I5h1LZVK4KxnmSMPCI1NfwMiAoTnarCcqYcSRPEeyXEoGOk59mQn8rXgjNP/0F7f6Tll+DzwoFb+6lpDcJPcZ5Ps1uOVdLwa3A1bv/NH7HqnbPS8ZIRgVmCA1EDMgUpDLzykDDLv5k6nBOU7X9a8lH5yErcFJY5zG6kHWeB/ZUcvQ5xZJeK50ZLtM3sTjAaBOg67o4836xmwjvxcAQO7vSMuYIi+53NH+kL+PYyjLCRW9qqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JL06tRbc00vfVWHLOrRmGzaV+63VAuzBlvc83ptZqgk=;
 b=Z4OCVP/2zt2gxKAr1kTZq/diV2K+tWRuECInknW73upcRQIMEYekZI1T95MrKywsLjCeUwOHjR50TXQ8uYwQPTiR21S2fng68KeE2XJwL0AzwuqAltq3ndRB7R4SGUojLgOmXLooqya15zVdyPiK6P//4vptdXqwJFqHaR0ROO4=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SA1PR13MB6148.namprd13.prod.outlook.com (2603:10b6:806:337::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 14:56:57 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5003:a508:6b4:4e8a]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5003:a508:6b4:4e8a%5]) with mapi id 15.20.7249.037; Wed, 7 Feb 2024
 14:56:56 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"jlayton@kernel.org" <jlayton@kernel.org>
CC: "rick.macklem@gmail.com" <rick.macklem@gmail.com>
Subject: Re: when should the client request a directory delegation?
Thread-Topic: when should the client request a directory delegation?
Thread-Index: AQHaWcppe3dWAatSzkyuu9kjNEc7UrD+7lAAgAAJ44A=
Date: Wed, 7 Feb 2024 14:56:56 +0000
Message-ID: <1fac8e86eae132499cc1bffe139ba397293bea9f.camel@hammerspace.com>
References: <57b9f5e0c3ec7bc09044b016a3822d0700760c55.camel@kernel.org>
	 <71e5d519411330ee608415fa629322fc84de8139.camel@hammerspace.com>
In-Reply-To: <71e5d519411330ee608415fa629322fc84de8139.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SA1PR13MB6148:EE_
x-ms-office365-filtering-correlation-id: 81be463e-bc1e-4017-3fa2-08dc27ed0790
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6beJM6SI5fGMjcEK2tkDqmL9xGUY54m3+JWCpyCvysZ3vrMu8XkfGD+IfIeUeEe+OEDfDWFKWaf5JKwNvtu4+YVy5zaT2Xytn2H0PO4QKHVFooMzGTHsUtMqnr+xwGfwHPBTUOgAyXrhjXpdmHLFcGjNDqLzpUr4YIVGzSfCZ/26titx95+EqtBxV8jrXeqPD+JQvcOjCkIpyRfWlFyZdAAZ4qx2Nd0cDImD2MJ6VEMLa9VReRM31UQfaG+VocT9XIqLyZKnYdzC4oWJ1tzM/+lntsoc4o/eJwmQAnhmkLtmk9P6wAFTXBdJRzOJZ88Z64tgWlgc0NwVRtNL279P7/Ui2CcOmarCsQGVzIycY9Fn6JXkprEy+P3OPy+7I4dSFJK1eLos50pZNoHqYZEIdUbnvNtA5tY25FMCl7Pq4ilpXBafqSlMncCSjzMM3XLstTPByNOgjkbfRxx8VqoNdif6wSetCjvOkNUAQW8GghifE57xJX15j9s2fI298OBU7JmYMKlUbsERORC/dxDzo/sztjrN5qH8nsAx12Dj8uxBY76FB//xPiW/bT/uVqbSb2TOaPvMUhPGBfM3s72S/XvpEuHr5Q+/jta0wf1vF6k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(366004)(396003)(376002)(346002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(41300700001)(66946007)(966005)(36756003)(6486002)(66556008)(66476007)(66446008)(64756008)(110136005)(76116006)(6512007)(478600001)(316002)(71200400001)(8936002)(4326008)(38070700009)(8676002)(6506007)(122000001)(38100700002)(2616005)(83380400001)(5660300002)(2906002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bW1sMHZXMFRMUkdFaTZ2VzBrVmdpRHFZNHlzMUU5YmlwUStuajFlVHJrc2Ns?=
 =?utf-8?B?SGFrRzBzU1dNNDFmdkhGUmxMNHBhR3k2bS9VK0lQdTdGWUdOdzhvbVQ3TitS?=
 =?utf-8?B?Q3dheDVqRi8xUUxoWEVaOVRWR29aRHhyL3VhY1FZaE03V00zaXAzWVh1b2pJ?=
 =?utf-8?B?NWV2S0lsK3VtenkzaGg3WHVEaFJuKzNGaHJuaFNyZ3RURXBBNXlZRmFta1FN?=
 =?utf-8?B?eW9HRDF4bzQrZVdWTXcyTEh4eFFSQmFpWkExLytsV3E3Q1Jrb2RiVDBDVzho?=
 =?utf-8?B?RVV4N3RzZGFSZC94cU90ZXRhc1NIWDNZdFk4b2Z1em13YkdmaWpHaG9lQ3VM?=
 =?utf-8?B?NHh0M0xrUVpGVU44Y0ZJaEh2NVlKREVkUDZSYXcxNkV5eWdzWlhzMzMxQktU?=
 =?utf-8?B?NERjd1RzQ2JSZWFzM1ZoRExoRjJKL280SUJLY3JHR01HTkVweE9HdjNiejZ6?=
 =?utf-8?B?NnBmV1NiYmJoc1l1WmE4N2NTRkJMbng2dXg0SmhuOENBNkRzOWJzWUtkMVF2?=
 =?utf-8?B?NVJnT0grYkc5Ylk3eFZBYWxsODRYSEZDUTNvMHUxN3RhbjVNdnl5YWI4LzZJ?=
 =?utf-8?B?TVI2T2xaeEVTTm9MeFlaQW4vTm0rUVZYSXRJY2hld09Ia3RmRkpCM0VWa3Ru?=
 =?utf-8?B?VTRqN05mRVR6SWk5Z2p6SU4vejlVUkJpMW9uMXJEVjBpRkgwMkd2YUgrK21E?=
 =?utf-8?B?Uk5MZDNoZzlkMDhYVkY3eCtkWEZiNHFjMXplTGVoL2pSYy9KZGE4bUtzd0l6?=
 =?utf-8?B?YUt4L09rY2I5MUdDWTRMTFhRallQUkdrZGQvbzlSY1cvbjNnZWhIaVNhQm9j?=
 =?utf-8?B?d0I1aDhxb2RwRFJ3cDZwK0tGdi94bGd3R3YvZ3ZLRXcwQXFYRi9jd3MzcGNj?=
 =?utf-8?B?V0h4TUtLa2RBWm1SOVpZR29mZmdJZmV4Y0xtc2Z2OFd5WTZJbGZLK2RXV1Zl?=
 =?utf-8?B?NTZIUTdzcm5obEIrMmNsNkVYdjlJcGZhM0lFVDJkSTVjZzZnR05ZQ0VCblJ4?=
 =?utf-8?B?Um50c0J1N2xTdjdjaWZsYmxsc05TWmMyWGlqQ2lWVStiTHZENSsxenNySzF3?=
 =?utf-8?B?VngzbDg5VStoeHdQa0VKOGNiTXlXK2J1ZkhQSTArMlUrOFgzRnRKRUx5RDZU?=
 =?utf-8?B?azR2UzVVZ0hwOXMrSVBDNjNrdG5qa0wxY2I1TUlnRm8xL1FJWlJMZ0crVXR4?=
 =?utf-8?B?NmgweHRYVVVITldSdjEzdDlaaEdTTnpVQnorOWRxNUpHeXRocmZEK2tOS2tF?=
 =?utf-8?B?eGw5R0FSajNpSTlQZjNCTnNRSk9QN1RtakU2VitEUklLM1dwUmI1aFJGRnBZ?=
 =?utf-8?B?ODZ5VzkvM05MRUVHOUhraFEyc3AxT08wNUllZmxpSnNtT1FOdDA5K0Yza3dj?=
 =?utf-8?B?ZW5oSk8wVnRtNEpROUdsRjVlTDJDV3BtNC93T3ozMVZ2cU1SYXRGU3hWVW9J?=
 =?utf-8?B?SHI3c1ZuUnR1eFpIaDVJakhvOFhCWFBhcDM5WlBUTGpvRGRaZmU3amZDSDQv?=
 =?utf-8?B?QkFIc25BOFYwWUhLRjdya1UxeHk2TmRWL00vVW5RTk9FbUZUUFUyNCtHV2Zl?=
 =?utf-8?B?M0pjdGNSbVh5OFRPWm03WVplU0JkeEF0bGd6VlZFSDZpYlpNbGdZYlZTdjdi?=
 =?utf-8?B?OU9QOGJ6VFJPL25NWmdtZWtSS1ZLM2lTVGxELzRLT0xPVnNmRUJsM2tYcVpJ?=
 =?utf-8?B?YnhVRVVaQ1A5S080R2JYTWhEcXZtWkVib0p4OVBEaWpVTlRta01oa0VLcUYr?=
 =?utf-8?B?Mm1RaklwWW9WdU1SaUtQMHhEdGc4d1ZXMDdxUTJsS09OWDUrSEdoQzVNQ2gy?=
 =?utf-8?B?WTRRcUNCQUpvWW0wZlpBeVFEb2YvUmtxZnBUTUxIRzBPOW5hQWxEOTVaS3Fo?=
 =?utf-8?B?Z3lJdEhudmpneGRuckpnOXE5TW5Fcm0zUGdMR0o1M1h5akNzcEh1S1dHVmNM?=
 =?utf-8?B?YmJUMXFPTW9RQ29TcjZpcXhtTzQwdWUvd0JkcU1Sakl3V1RSN0NrQVQ4VVFk?=
 =?utf-8?B?dm5YTi82M1JOQ1hQQktOSlNQYmo1Z0NVY3FrQ2xSNVZIUE9weXpVbTRVRFRx?=
 =?utf-8?B?eHRkY0VPSWV3VFVZVDhONTBaRytuQ0pPK2g3N2U5RFY5bzllVE53QWVXSm4y?=
 =?utf-8?B?Ylg1SzA4WHB1WnpVS3cvdm8ra2F1azFkYTJNM1ZkZmErUGtNaGRmenpZRjh6?=
 =?utf-8?B?MWVVZThuVGJsRWJ5WTE2ejNlUm5JaHJkR3V4aU1KWDY2N0s4dVZVbzAzaWhS?=
 =?utf-8?B?VEJRSXl1YjZhQXZsVCtEbjFJTWtRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <446A9DD19A36CE4C970877DA4004092C@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 81be463e-bc1e-4017-3fa2-08dc27ed0790
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 14:56:56.6880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dJK3vjqSl3im4FCvWBUz7MKVVf5CjgQMRMLWAm8yqUzasvJZiQxiMOWlCMEOBiRsfWbkuMuiUC+AMcGW95xmjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB6148

T24gV2VkLCAyMDI0LTAyLTA3IGF0IDE0OjIxICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+IE9uIFdlZCwgMjAyNC0wMi0wNyBhdCAwODozNCAtMDUwMCwgSmVmZiBMYXl0b24gd3JvdGU6
DQo+ID4gSSd2ZSBzdGFydGVkIHdvcmsgb24gYSBwYXRjaHNldCB0byBhZGQgc3VwcG9ydCBmb3Ig
ZGlyZWN0b3J5DQo+ID4gZGVsZWdhdGlvbnMNCj4gPiB0byB0aGUgTGludXgga2VybmVsIGNsaWVu
dCBhbmQgc2VydmVyLiBJdCdzIHN0aWxsIHRvbyByb3VnaCB0byBwb3N0DQo+ID4gYXQNCj4gPiB0
aGlzIHBvaW50LCBhbmQgZm9yIG5vdywgSSdtIGp1c3QgY29iYmxpbmcgaW4gYSBpb2N0bCB0byBk
cml2ZSBpdC4NCj4gPiANCj4gPiBBcyBJIHN0YXJ0ZWQgd29ya2luZyBvbiBzb21lIG9mIHRoZSBj
bGllbnQgYml0cywgaG93ZXZlciwgSQ0KPiA+IHJlYWxpemVkDQo+ID4gdGhhdCBJIGRvbid0IHJl
YWxseSBoYXZlIGEgY2xlYXIgcGljdHVyZSBhcyB0byB3aGVuIHRoZSBjbGllbnQNCj4gPiBzaG91
bGQNCj4gPiByZXF1ZXN0IGEgZGVsZWdhdGlvbiBvbiBhIGRpcmVjdG9yeS4gSXQgc2VlbXMgbGlr
ZSB0aGVyZSBhcmUgYSBsb3QNCj4gPiBvZg0KPiA+IHRoaW5ncyB3ZSBjb3VsZCBkbzoNCj4gPiAN
Cj4gPiBPbmUgaWRlYTogcmVxdWVzdCBvbmUgb24gYW4gaW5pdGlhbCBkaXJlY3RvcnkgcmVhZGRp
ci4gU28gbWF5YmUNCj4gPiB3aGVuDQo+ID4gdGhlDQo+ID4gb2Zmc2V0IGlzIDAgYW5kIHdlIGRv
bid0IGhhdmUgYSBkaXIgZGVsZWdhdGlvbiBhbHJlYWR5LCBkbzoNCj4gPiANCj4gPiAJUFVURkg6
R0VUX0RJUl9ERUxFR0FUSU9OOlJFQURESVINCj4gPiANCj4gPiBPciwgbWF5YmUganVzdCBkbyBp
dCBvbiBhbnkgcmVhZGRpciB3aGVuIHdlIGhhdmVuJ3QgcmVxdWVzdGVkIG9uZQ0KPiA+IGluDQo+
ID4gYQ0KPiA+IGxpdHRsZSB3aGlsZT8NCj4gPiANCj4gPiBXZSBjb3VsZCBhbHNvIGRvIG9uZSBv
biBldmVyeSBsb29rdXAsIHdoZW4gd2UgZXhwZWN0IHRoYXQgdGhlDQo+ID4gcmVzdWx0DQo+ID4g
d2lsbCBiZSBhIGRpcmVjdG9yeS4gSSdtIG5vdCBzdXJlIGlmIExPT0tVUF9ESVJFQ1RPUlkgd291
bGQgYmUgYQ0KPiA+IHN1ZmZpY2llbnQgaW5kaWNhdG9yIG9yIGlmIHdlJ2QgbmVlZCB0aGUgdmZz
IHRvIGluZGljYXRlIHRoYXQgd2l0aA0KPiA+IGENCj4gPiBuZXcNCj4gPiBmbGFnLg0KPiA+IA0K
PiA+IFdvdWxkIHdlIGFsc28gd2FudCB0byByZXF1ZXN0IG9uZSBhZnRlciBhIG1rZGlyPw0KPiA+
IA0KPiA+IAlQVVRGSDpDUkVBVEU6R0VUX0RJUl9ERUxFR0FUSU9OOkdFVEZIOkdFVF9ESVJfREVM
RUdBVElPTjouDQo+ID4gLi4NCj4gPiANCj4gPiBBc3N1bWluZyB3ZSBjYW4gZ2V0IHRoaXMgYWxs
IHdvcmtpbmcsIHdoYXQgc2hvdWxkIGRyaXZlIHRoZSBjbGllbnQNCj4gPiB0bw0KPiA+IGlzc3Vl
cyBHRVRfRElSX0RFTEVHQVRJT04gb3BzPw0KPiANCj4gQXMgZmFyIGFzIEknbSBjb25jZXJuZWQs
IHRoZSBtYWluIGNhc2UgdG8gYmUgbWFkZSBmb3IgZGlyZWN0b3J5DQo+IGRlbGVnYXRpb25zIGlu
IHRoZSBjbGllbnQgaXMgZm9yIHJlZHVjaW5nIHRoZSBudW1iZXIgb2YgcmV2YWxpZGF0aW9ucw0K
PiBvbiBzYWlkIGRpcmVjdG9yeSwgcGFydGljdWxhcmx5IGR1cmluZyBwYXRoIGxvb2t1cHMuDQo+
IGkuZS4gdGhlIGdvYWwgaXMgdG8gZWxpbWluYXRlIHRoZSBuZWVkIHRvIGNvbnN0YW50bHkgcG9s
bCB0aGUNCj4gZGlyZWN0b3J5DQo+IGNoYW5nZSBhdHRyaWJ1dGUsIGFuZCB0byBlbGltaW5hdGUg
dGhlIG5lZWQgdG8gY29uc3RhbnRseSByZXZhbGlkYXRlDQo+IHRoZSBkZW50cmllcyAoYW5kIG5l
Z2F0aXZlIGRlbnRyaWVzISkgY29udGFpbmVkIGluIHRoZSBkaXJlY3RvcnkNCj4gYWZ0ZXINCj4g
YSBjaGFuZ2UuDQo+IA0KPiBQZXJoYXBzIHRoYXQgbWVhbnMgd2Ugc2hvdWxkIGZvY3VzIG9uIGFk
ZGluZyBhIHJlcXVlc3QgZm9yIGENCj4gZGlyZWN0b3J5DQo+IGRlbGVnYXRpb24gdG8gdGhlIGZ1
bmN0aW9uIG5mc19sb29rdXBfcmV2YWxpZGF0ZSgpIHNpbmNlIHRoYXQgd291bGQNCj4gc2VlbSB0
byBpbmRpY2F0ZSB0aGF0IHdlJ3JlIGdvaW5nIHRocm91Z2ggdGhlIHNhbWUgZGlyZWN0b3J5IG11
bHRpcGxlDQo+IHRpbWVzPyBUaGUgb3RoZXIgY2FsbCBzaXRlIHRvIGNvbnNpZGVyIHdvdWxkIGJl
IG5mc19jaGVja192ZXJpZmllcigpLg0KDQpOb3RlOiBpZiB5b3UgZGlzYWdyZWUgd2l0aCB0aGUg
YWJvdmUgYXJndW1lbnQsIGFuZCB0aGluayB0aGF0IGltcHJvdmluZw0KdGhhdCBjYWNoaW5nIFJF
QURESVIgb2YgcmVzdWx0cyBpcyBtb3JlIGltcG9ydGFudCwgdGhlbiBjb25zaWRlciB0aGUNCndo
b2xlIGRpc2N1c3Npb24gd2UgaGFkIGluIHRoZSB0aHJlYWQgc3RhcnRlZCBieSBUaWdyYW4gaGVy
ZToNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9DQUd1ZTEzcGVfWkhfRXRvLWpMM21MalRO
R0ZLMjZpelRhcm5aZGpzM2VMODJBMlozN3dAbWFpbC5nbWFpbC5jb20vDQoNCi0tIA0KVHJvbmQg
TXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9u
ZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K

