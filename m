Return-Path: <linux-nfs+bounces-2384-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0D387F632
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Mar 2024 04:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DC1E1C21740
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Mar 2024 03:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30007BB07;
	Tue, 19 Mar 2024 03:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="cdK0citU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2111.outbound.protection.outlook.com [40.107.212.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767797BAF7
	for <linux-nfs@vger.kernel.org>; Tue, 19 Mar 2024 03:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710820457; cv=fail; b=LWpGXMYcP/klo5t+Y5IxgmGSgE2wfSnZFKNqr/W/LGU/fVnzrZ5cmUEESeNPIFQ2JvrcxZRx+8yjExER2bQC4fUMQYRb1Cn2FFJdtopqkBSOiyJhfHseeG5G+2AGBysSdlDuFNSZDUe2lw8CEVpJAGntqFcOzDIpapgVpOyGVIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710820457; c=relaxed/simple;
	bh=cGRF0udg2pyk4TMWs815bo8vwmctkBxeO4Kz6Cnsvb8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TgG+gWHKy+0PGu9kQuVSA2w7WL6bO2tdqeNStWfsNsBIjVuYK6hG35uNufvBjOMgDURhoUB9Ypt5rzMWFmgKpbc+JYLnBXCVOL6u3oj6/PpOi7n46CDnd9ays5P1iJxLo4NXOJzFwSfTffZin1zz/zGG1eYsgDkCeSx935F8haA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=cdK0citU; arc=fail smtp.client-ip=40.107.212.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUf8NgrgVTGc/aKjbJqKxzMTBfJxlzVTGYgpQO74SlVwuRBPDSKgrDGcoj0medUE3O8JAIEo4bRz1CMal0pcYKU97mCCjEGqbIkVFX0WCUdKI+MOhAiRWVrzdwvFhklEi0pNXczKCjOvsTWSc6I5FS/o75LZ6XeAdfQAgX7WoL8lM7tUpKlQM5KAh/3xPf4u8mTpv+rKLCpdXZ/ZgDuawJhu76xmRidfZ2BWebGQZPi/087sH/VFOaU1FC+BYoSmAGfLl/XnCkUsoeU8Wba6lpl1HPyEBTYtyhwSaRGBmlODnlejlLEVPMp7qKW4BBP/RCzZAiRSsAsLtqJ8nHVrBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGRF0udg2pyk4TMWs815bo8vwmctkBxeO4Kz6Cnsvb8=;
 b=cQBpxMB+SZuOKxNQkXgO94xsUKjqeoGSzjQgkUafvOFCiLb6HxuMmcqmqhq8+xqcWthywAhnliuopvre8QkwVUASPcxRjD1s9NnqE3Ln/e8IFKStQRlQS74WYIKZccNxIadHUZfRqCFArB/GEnxnDIYlJAjYPlFaxZNpjD/uc4/Yih/ZTSbLEJrbv1oU7/WG/tnstTLXW7F0y4+ces2cxCdhZ5hL7r61Mf51irZskIVQYOlPi68vq2Q+Z+kioprWu1N0aQjHXZYMDvPrv0fz47G6t11nP9Lu3mQcz/ZueiznF8lgvhM/c/4/TT8ExdHIisfNW74gsSyoRIrCixohfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGRF0udg2pyk4TMWs815bo8vwmctkBxeO4Kz6Cnsvb8=;
 b=cdK0citUghoiD8+H+B+eTHQOnoVsfV1EKAYK0P8PNKa9bBm0+8gX0sYGL8yUJYEezyWvRPAekaCo0t3bmYFuxvecNcVnaaTN1wre5qjSOEshBgwhWcQsjN1NPOpja5naywSQdfUFtWmE6wPbd/ltMJtlTpnmnMd5+zaIhf6t/LM=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MW5PR13MB5416.namprd13.prod.outlook.com (2603:10b6:303:191::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25; Tue, 19 Mar
 2024 03:54:10 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5bb5:501a:fb40:5057]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5bb5:501a:fb40:5057%6]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 03:54:10 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "anna@kernel.org" <anna@kernel.org>, "neilb@suse.de" <neilb@suse.de>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Question about possible use-after-free in
 nfs_direct_write_reschedule()
Thread-Topic: Question about possible use-after-free in
 nfs_direct_write_reschedule()
Thread-Index: AQHaeZagYa9vtPaNeU2e6SuElFyU1bE+bwIA
Date: Tue, 19 Mar 2024 03:54:10 +0000
Message-ID: <02300d56202423fc7277b0ee923b40f00d4903db.camel@hammerspace.com>
References: <171080858885.13576.7878757943353384571@noble.neil.brown.name>
In-Reply-To: <171080858885.13576.7878757943353384571@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|MW5PR13MB5416:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 JS5dGOD5s/WHVa2yKSk0VU4M8Y/V9r7To05WHqZtqZ2xv+LQ3TKB2R5Chyhvt4mXfrCH8N7Kj7Gvk/eqM4YZYP5LkDgO/9etT9XzncD12Im2517YMGnAuGCJcYiXagxmp/ai7qdMFGSzdsu646KCiE5iCERIHQ4gs0NrAj2iRgQgtSzYEDvbch0iCYTEifwqO+kp82tU7GggCouotkm7qXhYY/OHfYK64ZYalupg+xtjBuTYNmm0at1D34pBjnVTrXQ4RbetxeMAyEceH0rx25moI/siraCAO/eEMVK4Zt0RPJt7sZXbDKSjYTHWEGTYOA96RkUZr+MWVle6PViKnNeUXStU2v6bRy1jOWZS+XcRlMgVron7QqX81uNkZzoTQwXl8n3ZzKSM0bzjpct28qSlvjLSax63rPLNe56IC40wYkY2pQWsJKr7wbbLcblHkM8bBMJVN91Yn7dk31XnvR3cMnYzpTzIqkJV+FPLGV/aDjpFDvBhhh+X8H+unWa29/ogO7f16vOmq+5qPY65vbeTeMEWoZiuJUo4isbm/w+tV5KiY3jrZq7uiG1RQRw9r2FG06R678cPC37NN7R/nVSjJ4f2JjLbXewVifB17SV0x4h6JcbjDHShjZtSEraaZTy41UhacQvKVnoOTUwOPLWaco5cuEMnb+kaOz8Hr0g=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RGszODhMSEtrY1NEVjhyekN0NmNNMGk2WEVIMkt6N2lwckdqbUM3ZS9MNXdT?=
 =?utf-8?B?TGxVSW9ETS9IUWV5aDVCaUVtbnFsRC9CMG44NXBBNFhnSmhuWFB2OFZXZWxz?=
 =?utf-8?B?YnN5KzdKc3RGTGNuQnNxbnhmaVJ2ajgreDFZSVhRR011aFJNQlpOOGNTUnZJ?=
 =?utf-8?B?WGZ1bmh2Slg5R0V6TDkrWFZQaG9OTXlwbWlYRm1wR3dKVUdJY3dSUm9JY21r?=
 =?utf-8?B?ZlZ0V2RJWGhjWkZMM3NBOHAwaUQ0QXVOdi94TDI5UzZGYmRCMVFGdjJyUzlD?=
 =?utf-8?B?bzBjNm1RRDlyK0J3M2tVd0QrSXI0V1Z4ZFJSK2o1T0ZPT2szUGxpQWJaaWhO?=
 =?utf-8?B?UDdwYzlmcWZvYm5OZWtCWjEydEZTOGIwbzJvZk1GMXdtdGxyb2NHNzJDemxB?=
 =?utf-8?B?ZUh0aHNXbDkwVXhjV3d2VGVTYkYvS1p2aDVPTWtZTHRDUysxSmdwc04zS0Ft?=
 =?utf-8?B?T0pMU21ZZTV1cDVEWGhtSUhSODl4bkNHYmRZL3d5Uk1WeVk2dkQreVZqVW5U?=
 =?utf-8?B?OVU5ckpSUThqdDNpYlFFZ1RNeGczVkQ2Q1M0TFFQMCtvMDVyTk9uT2JDRWg4?=
 =?utf-8?B?TWhtL09wSjNlTUlFMDBUN3hsWFBPbGhQUlpNa0FqQm5BUUUxKzlHQVd2MEFP?=
 =?utf-8?B?WDloVEhFN0JOZWJER29lNXFsWjZQZ09CQUF1Q3FoQkhWUmlaN3Rsa3hHT1dG?=
 =?utf-8?B?V0pBTlRMNDBSTHd0Lzk4cEludGh6bmswd1NaeENmazZJOWd1WFQvR3QyV3Ux?=
 =?utf-8?B?cGw0S1FKOGZhNTdqaEZHd3ZPSGsyT1ZoYXZ5eTJONWtWOGlLNjU3Z3ZQRytH?=
 =?utf-8?B?ZlI5WWVJNHB3QSs1bXhIQjZna2JCbzhha0w1K1ZoR3Ewd0VBQXFaVU5qc1ZP?=
 =?utf-8?B?T09hZ2VHREtUUHEzM2djUFpRWmFFQXM4MHo5WnRCekZZM1ljR3F6ZU1nMk1T?=
 =?utf-8?B?VHQ4cWQ3OXdweUJOemhlS3JVZW1JcVpBaE96L1hOaGlOVGhNVVNmZXNQbGlV?=
 =?utf-8?B?SHN0WmEvbkJlYmR4MnNvOHgvdkh1dDRqWXE2cXZkbHZYMnhUT0dWNmtPTGtw?=
 =?utf-8?B?em5wMTdvakNCZWJwRENjSDFEVUhTYzBDV25xMHNocnRHZ0FTUDI3dXBFZDNt?=
 =?utf-8?B?OVZUOWExMVFnNk9majRxTU5SWm9LVE1rdm1kZ2VWT0FNQnI5eHhTTit1b29K?=
 =?utf-8?B?cHZienN6ZUZta3JNZjk0TjRDM3grMUtOZUliRFlhTGRMWjBCcFdKeDJoUjBw?=
 =?utf-8?B?d3VOWDB5cDR3MVQvYk9oVVB1dVhrRVhyRFFKa2hjeHZweVk0dm5uM0FTaSs3?=
 =?utf-8?B?WUppZEFjNWpSQkcyamlkVWgrU0lLcXhrVmUvbkxwc3NoU0Jac085SVhrUDgw?=
 =?utf-8?B?MU5oYi9jWVlZd056cnZqRSttckxzNVFJK2gzQ1UyWFR4ck56OFN1NDRkYTdL?=
 =?utf-8?B?elhhazBMVGp3T3dKSVBUOXVFUlZ2WXA3anZhdjlJV2dLOC96R0JEMmxxVDhC?=
 =?utf-8?B?MWdaZzNQOTFuMlZpcXdVQ1JWcEN2N3Q2bGFZSFk5YUMwVkFweTBhcFcveHR2?=
 =?utf-8?B?Tk9saDUzR0haNlFTbGhUVi8zcyttZzFTUmorMyt4b0FIRXg3Z21OTnA3R1FE?=
 =?utf-8?B?YVZZMnJwdkJpZ1lpT0VLa2JnZlVUamJsWVRma3h3UTdxNU9kNGtvdUxKTnVi?=
 =?utf-8?B?MzFtSGRybkJTWjVwSFdCSXYzZzZkRUlaUmJSZ0tWdnFhZGNOSHhtb2NpamtG?=
 =?utf-8?B?V2dwTWsrYzBaYjVlQkY3V0xnaXJTU0lUVzRNZmtIQVR4MGpiSlc0LzJjQ1Zh?=
 =?utf-8?B?T3dVcEVNdE5tSmtZeGtzcFg2bDdXMmI2Y2JNQkVaM0JyV0RMcnRGOFlYR1pt?=
 =?utf-8?B?Y3FCbVo2eVlHV2dveFNyR2p3ck56dENGR2phNDVkMHhaYjQ3bUR4SlpwZUN1?=
 =?utf-8?B?VXU0c2puczlTeUJGeFdUeEx3YmhHQXNCbm0xb1NqMVFwSy90VkloTkVhOXp1?=
 =?utf-8?B?UWgvZzVmM1cxR0FReUFWYjVhcTJIVWY5c2Y3R2NyTTJ4TTh1THNuNmN2N29R?=
 =?utf-8?B?ZWd4ei9OZUZJSllSOUFwd3V4c1hscHVBUTcrM2JyVmFlOVZUWDl3MCtpTHYy?=
 =?utf-8?B?eHFQaFFGb1JGd0laOFZMWG50V001dEY1bDJ6REtyUDhlR2V6bGNjWjlwR2xn?=
 =?utf-8?B?Z3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DEAFCD0D105E04BB00C60E0C6AE2D71@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d79a38d-4a18-4d56-ea87-08dc47c83c0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 03:54:10.5740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3i4j5a+zTRji6XNpjJBrZwJ8Eay8Zw0Fbz/b4nlnhqcW28Vs1jruK2kHXIMQA1oqXoUCljUUN+hm7Rr2iuYZ3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR13MB5416

T24gVHVlLCAyMDI0LTAzLTE5IGF0IDExOjM2ICsxMTAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IA0K
PiBJJ3ZlIGJlZW4gcmV2aWV3aW5nIHNvbWUgbmZzL2RpcmVjdC5jIHBhdGNoZXMgZm9yIHBvc3Np
YmxlIGJhY2twb3J0DQo+IHRvDQo+IG9uZSBvZiBvdXIgb2xkZXIgZW50ZXJwcmlzZSBrZXJuZWxz
IGFuZCBJJ3ZlIGZvdW5kIHNvbWV0aGluZyB0aGF0DQo+IGxvb2tzDQo+IHdyb25nLg0KPiANCj4g
SXQgaXNuJ3QgY2xlYXIgdG8gbWUgaG93IHRvIGV4ZXJjaXNlIHRoZSBjb2RlIHNvIEkgaGF2ZW4n
dCBiZSBhYmxlIHRvDQo+IHRyaWdnZXIgYSBwcm9ibGVtLsKgIEknbSBob3BpbmcgdGhhdCBzb21l
b25lIGNvdWxkIGVpdGhlciBleHBsYWluIHdoZW4NCj4gdGhpcyBjb2RlIHJ1bnMsIG9yIGNvbmZp
cm0gaWYgdGhlIGNvZGUgaXMgY29ycmVjdCBvciBub3QuDQo+IA0KPiBDb21taXQgOTU0OTk4YjYw
Y2FhICgiTkZTOiBGaXggZXJyb3IgaGFuZGxpbmcgZm9yIE9fRElSRUNUIHdyaXRlDQo+IHNjaGVk
dWxpbmciKQ0KPiANCj4gYWRkcyBhbiBleHRyYSBjYWxsIHRvIG5mc19yZWxlYXNlX3JlcXVlc3Qo
KSBidXQgSSBjYW5ub3QgZmluZCBhbnkNCj4gcGxhY2UNCj4gdGhhdCBhbiBleHRyYSByZWZlcmVu
Y2UgaXMgdGFrZW4uDQo+IA0KPiBUaGUgY29kZSBjdXJyZW50bHkgcmVhZHM6DQo+IA0KPiAJd2hp
bGUgKCFsaXN0X2VtcHR5KCZyZXFzKSkgew0KPiAJCXJlcSA9IG5mc19saXN0X2VudHJ5KHJlcXMu
bmV4dCk7DQo+IAkJbmZzX2xpc3RfcmVtb3ZlX3JlcXVlc3QocmVxKTsNCj4gCQluZnNfdW5sb2Nr
X2FuZF9yZWxlYXNlX3JlcXVlc3QocmVxKTsNCj4gCQlpZiAoZGVzYy5wZ19lcnJvciA9PSAtRUFH
QUlOKSB7DQo+IAkJCW5mc19tYXJrX3JlcXVlc3RfY29tbWl0KHJlcSwgTlVMTCwgJmNpbmZvLA0K
PiAwKTsNCj4gCQl9IGVsc2Ugew0KPiAJCQlzcGluX2xvY2soJmRyZXEtPmxvY2spOw0KPiAJCQlu
ZnNfZGlyZWN0X3RydW5jYXRlX3JlcXVlc3QoZHJlcSwgcmVxKTsNCj4gCQkJc3Bpbl91bmxvY2so
JmRyZXEtPmxvY2spOw0KPiAJCQluZnNfcmVsZWFzZV9yZXF1ZXN0KHJlcSk7DQo+IAkJfQ0KPiAJ
fQ0KPiANCj4gYWZ0ZXIgdGhlIG5mc191bmxvY2tfYW5kX3JlbGVhc2VfcmVxdWVzdCgpIGNhbGwg
SSB3b3VsZCBleHBlY3QgdGhhdA0KPiB0aGUNCj4gcmVxdWVzdCBjb3VsZCBiZSBmcmVlZCwgc28g
dGhhdCBuZnNfbWFya19yZXF1ZXN0X2NvbW1pdCgpIG9yIHRoZQ0KPiBuZnNfcmVsZWFzZV9yZXF1
ZXN0KCkgY291bGQgY2F1c2UgYSBwcm9ibGVtLg0KPiANCj4gU3VwZXJmaWNpYWxseSBpdCBsb29r
cyBsaWtlIHRoZSBjYWxsIHNob3VsZCBiZSBzaW1wbHkNCj4gbmZzX3VubG9ja19yZXF1ZXN0KCku
wqAgVGhpcyB3b3VsZCBmb2xsb3cgdGhlDQo+IGxpc3RfcmVtb3ZlO3VubG9jazttYXJrX2NvbW1p
dCBwYXR0ZXJuIGFsc28gZm91bmQgaW4NCj4gbmZzX2RpcmVjdF93cml0ZV9yZXNjaGVkdWxlX2lv
KCkuDQo+IA0KPiBEbyB3ZSBuZWVkOg0KPiAtLS0gYS9mcy9uZnMvZGlyZWN0LmMNCj4gKysrIGIv
ZnMvbmZzL2RpcmVjdC5jDQo+IEBAIC01ODEsNyArNTgxLDcgQEAgc3RhdGljIHZvaWQgbmZzX2Rp
cmVjdF93cml0ZV9yZXNjaGVkdWxlKHN0cnVjdA0KPiBuZnNfZGlyZWN0X3JlcSAqZHJlcSkNCj4g
wqAJd2hpbGUgKCFsaXN0X2VtcHR5KCZyZXFzKSkgew0KPiDCoAkJcmVxID0gbmZzX2xpc3RfZW50
cnkocmVxcy5uZXh0KTsNCj4gwqAJCW5mc19saXN0X3JlbW92ZV9yZXF1ZXN0KHJlcSk7DQo+IC0J
CW5mc191bmxvY2tfYW5kX3JlbGVhc2VfcmVxdWVzdChyZXEpOw0KPiArCQluZnNfdW5sb2NrX3Jl
cXVlc3QocmVxKTsNCj4gwqAJCWlmIChkZXNjLnBnX2Vycm9yID09IC1FQUdBSU4pIHsNCj4gwqAJ
CQluZnNfbWFya19yZXF1ZXN0X2NvbW1pdChyZXEsIE5VTEwsICZjaW5mbywNCj4gMCk7DQo+IMKg
CQl9IGVsc2Ugew0KDQpTZWUgdGhlIGZ1bGwgY29kZSB0aGF0IHdhcyBjaGFuZ2VkOg0KIA0KLSAg
ICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUocmVxLCB0bXAsICZyZXFzLCB3Yl9saXN0KSB7
DQorICAgICAgIHdoaWxlICghbGlzdF9lbXB0eSgmcmVxcykpIHsNCisgICAgICAgICAgICAgICBy
ZXEgPSBuZnNfbGlzdF9lbnRyeShyZXFzLm5leHQpOw0KICAgICAgICAgICAgICAgIC8qIEJ1bXAg
dGhlIHRyYW5zbWlzc2lvbiBjb3VudCAqLw0KICAgICAgICAgICAgICAgIHJlcS0+d2JfbmlvKys7
DQogICAgICAgICAgICAgICAgaWYgKCFuZnNfcGFnZWlvX2FkZF9yZXF1ZXN0KCZkZXNjLCByZXEp
KSB7DQotICAgICAgICAgICAgICAgICAgICAgICBuZnNfbGlzdF9tb3ZlX3JlcXVlc3QocmVxLCAm
ZmFpbGVkKTsNCiAgICAgICAgICAgICAgICAgICAgICAgIHNwaW5fbG9jaygmY2luZm8uaW5vZGUt
PmlfbG9jayk7DQotICAgICAgICAgICAgICAgICAgICAgICBkcmVxLT5mbGFncyA9IDA7DQotICAg
ICAgICAgICAgICAgICAgICAgICBpZiAoZGVzYy5wZ19lcnJvciA8IDApDQorICAgICAgICAgICAg
ICAgICAgICAgICBpZiAoZHJlcS0+ZXJyb3IgPCAwKSB7DQorICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGRlc2MucGdfZXJyb3IgPSBkcmVxLT5lcnJvcjsNCisgICAgICAgICAgICAgICAg
ICAgICAgIH0gZWxzZSBpZiAoZGVzYy5wZ19lcnJvciAhPSAtRUFHQUlOKSB7DQorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGRyZXEtPmZsYWdzID0gMDsNCisgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgaWYgKCFkZXNjLnBnX2Vycm9yKQ0KKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGRlc2MucGdfZXJyb3IgPSAtRUlPOw0KICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBkcmVxLT5lcnJvciA9IGRlc2MucGdfZXJyb3I7DQotICAgICAgICAg
ICAgICAgICAgICAgICBlbHNlDQotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRyZXEt
PmVycm9yID0gLUVJTzsNCisgICAgICAgICAgICAgICAgICAgICAgIH0gZWxzZQ0KKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBkcmVxLT5mbGFncyA9DQpORlNfT0RJUkVDVF9SRVNDSEVE
X1dSSVRFUzsNCiAgICAgICAgICAgICAgICAgICAgICAgIHNwaW5fdW5sb2NrKCZjaW5mby5pbm9k
ZS0+aV9sb2NrKTsNCisgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KXl5eXl5eXl5eXl5e
Xl5eXl5eXl5eXl5eXl5eXl5eDQpQcmlvciB0byB0aGlzIHBhdGNoLCB3ZSBkaWQgbm90IGJyZWFr
IG91dCBvZiB0aGUgbG9vcCB1bnRpbCB0aGUgZW50aXJlDQoicmVxcyIgbGlzdCBoYW5kIGJlZW4g
aGFuZGxlZC4NCg0KICAgICAgICAgICAgICAgIH0NCiAgICAgICAgICAgICAgICBuZnNfcmVsZWFz
ZV9yZXF1ZXN0KHJlcSk7DQpeXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5e
Xl4NClByaW9yIHRvIHRoaXMgcGF0Y2gsIGV2ZXJ5IHJlcXVlc3Qgb24gdGhlICJyZXFzIiBsaXN0
IHdhcyByZWxlYXNlZCwNCndoZXRoZXIgb3Igbm90IHRoZXkgd2VyZSBiZWluZyBtb3ZlZCB0byB0
aGUgImZhaWxlZCIgbGlzdC4NCiAgICAgICAgfQ0KICAgICAgICBuZnNfcGFnZWlvX2NvbXBsZXRl
KCZkZXNjKTsNCiANCi0gICAgICAgd2hpbGUgKCFsaXN0X2VtcHR5KCZmYWlsZWQpKSB7DQotICAg
ICAgICAgICAgICAgcmVxID0gbmZzX2xpc3RfZW50cnkoZmFpbGVkLm5leHQpOw0KKyAgICAgICB3
aGlsZSAoIWxpc3RfZW1wdHkoJnJlcXMpKSB7DQpeXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5e
Xl5eXl5eXl5eDQpQcmlvciB0byB0aGlzIHBhdGNoLCBldmVyeSByZXF1ZXN0IHRoYXQgd2FzIGJl
aW5nIGhhbmRsZWQgaGVyZSBoYWQNCmFscmVhZHkgc2VlbiBhIGNhbGwgdG8gbmZzX3JlbGVhc2Vf
cmVxdWVzdCgpIGJlY2F1c2Ugd2UgaGFkIGFscmVhZHkNCmdvbmUgdGhyb3VnaCB0aGUgZW50aXJl
IGxpc3Qgb2YgInJlcXMiLg0KV2l0aCB0aGlzIHBhdGNoIGFwcGxpZWQsIHdlJ3JlIG5vdyBoYW5k
bGluZyBhbGwgdGhlIHJlcXVlc3RzIHRoYXQgYXJlDQpsZWZ0IG9uICJyZXFzIiwgYW5kIHRoYXQg
aGF2ZSBub3QgYmVlbiByZWxlYXNlZC4NCg0KKyAgICAgICAgICAgICAgIHJlcSA9IG5mc19saXN0
X2VudHJ5KHJlcXMubmV4dCk7DQogICAgICAgICAgICAgICAgbmZzX2xpc3RfcmVtb3ZlX3JlcXVl
c3QocmVxKTsNCiAgICAgICAgICAgICAgICBuZnNfdW5sb2NrX2FuZF9yZWxlYXNlX3JlcXVlc3Qo
cmVxKTsNCisgICAgICAgICAgICAgICBpZiAoZGVzYy5wZ19lcnJvciA9PSAtRUFHQUlOKQ0KKyAg
ICAgICAgICAgICAgICAgICAgICAgbmZzX21hcmtfcmVxdWVzdF9jb21taXQocmVxLCBOVUxMLCAm
Y2luZm8sIDApOw0KKyAgICAgICAgICAgICAgIGVsc2UNCisgICAgICAgICAgICAgICAgICAgICAg
IG5mc19yZWxlYXNlX3JlcXVlc3QocmVxKTsNCiAgICAgICAgfQ0KIA0KDQo+IA0KPiA/Pw0KPiAN
Cj4gVGhhbmtzLA0KPiBOZWlsQnJvd24NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5G
UyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJz
cGFjZS5jb20NCg0KDQo=

