Return-Path: <linux-nfs+bounces-4409-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFD891CE91
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Jun 2024 20:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFCAD1F21192
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Jun 2024 18:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E0212D758;
	Sat, 29 Jun 2024 18:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="HGSNJGxH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2130.outbound.protection.outlook.com [40.107.102.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDC15660;
	Sat, 29 Jun 2024 18:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719686065; cv=fail; b=ZcNLNrE8kM+Xz4ctLuLe8jdVxMvT9NSbh2FR2yhpnqbQ2T1GUKyfZeRDduN2S/0oA+B1+i402M/qDrSmMM6FX6nbnaiVctUMo6UD1N/Vk/2bF7ZO8ZTVTXlxymmdFzUeJHpziy9v2kZ/PvCZRSURNfv0/GoZEdahfPQEQx099cI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719686065; c=relaxed/simple;
	bh=ovk1dP00SonXuEvYq4jsLKbix8djhmWBnRj6NV/6/L0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kKPmWhCNFauq4S+81qtWpemqcir5Os84XLs7TgKjWzONZDE3K8DNIuBpRHlThgsDyLm/2/AKPVvtWTMbL6kbgFTK6IB3VtBznLVyxXgN9+yD2BsYJu8EErGm7MemYLbggzc/q1NTcYiwRBfvRk4yNghwYAlpLrKJuLlnJNtRcpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=HGSNJGxH; arc=fail smtp.client-ip=40.107.102.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mF5A6bE5Kli4lsfMJZCDTMTk9EaLF6oiEh3mbYruihNQWK+q4Gxj1SNyNqArRXldDsAx/7wU96mC/8+20uINLZikzdhtLlLY4w4pDjciEOzaVSQp8KRRy2HjLtdKUZwoH4zrR5iLmzH3x+QZehidQ+WbPAwfqQ8t9AScrBqH3t//zwbEtORURohWNS542n+lUOJkXfjzCOMZWcMBEbNJDdlsJ6bc2u2CkuQr90BmDbS6p8l+o4ptHjka167AjD3OpY4erWGDrFmm8R7qcuuZSADi3jJShR24200L7kOxJjoJxnPbnIswlw3/kXTw7raCR6vxQIjkJmqYY3pjgfRQiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovk1dP00SonXuEvYq4jsLKbix8djhmWBnRj6NV/6/L0=;
 b=bTJlpkDoG0YiiyGPxcliWj1DZQ6uSsE0SO2uc6Q2XRYTsJ6pWG+9NOG6tRvkH7hXkCpmSOyCe12j/tvf2EMPIzPaqjSWRg16cTXBsRbekbnXUsKELZMeMimFO0M9D/fjLOs6OVlllk+rOeCUNAslVY73noMf5uYagkWxVOESIR+zSW8iYF/JjnJL+NnAISg712yJ60vIDgD1+10qYmIcvQ9AGQ5+S48SZgwCbKPlRhNFxWI7t/U8BIxwvjCYFEmw3inU4FN+A5Odnyo3kCU66HuGYvc17ylFrq66Own91JOocRypbwlLmqLkS6s/xegPVxiOI0Nir5jBWTmNkO1shQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovk1dP00SonXuEvYq4jsLKbix8djhmWBnRj6NV/6/L0=;
 b=HGSNJGxHMeH0QSBC1xRVTrK0o9Efr5DRtuje+1TLHHhf9Qmb01aAlTc6x/iHwPe2DflZkc59maw+wr2zJbGnx/ePstz0ffZBPPW+VRdTHvemzCL6SEbf6b+Q5EsTpQvEAlxanfLpmyawRKCh0pQveiPCbU3SDBUAC2gi+fMOiA0=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by LV8PR13MB6584.namprd13.prod.outlook.com (2603:10b6:408:22c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Sat, 29 Jun
 2024 18:34:19 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%6]) with mapi id 15.20.7719.028; Sat, 29 Jun 2024
 18:34:18 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull NFS client bugfix for Linux-6.10
Thread-Topic: [GIT PULL] Please pull NFS client bugfix for Linux-6.10
Thread-Index: AQHaylLzsS9M0LBMQUSMQpD3N2G/hg==
Date: Sat, 29 Jun 2024 18:34:18 +0000
Message-ID: <dc1c267b7628de99b6f134f411a9c3ca86bc56c4.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|LV8PR13MB6584:EE_
x-ms-office365-filtering-correlation-id: 330af728-e553-4443-1e2b-08dc986a165e
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TEFTdGtLTnY4YVBKeXl6MTl6cXNkS0VqVXprOEdlRG1rWStaSDVKN0Q0eFVW?=
 =?utf-8?B?NEFrTnJ1aldLOTVEc3ZiSDM1a1ZpbTBtVWNLNFRRU3d2SUZ6alZQTUxXRi9v?=
 =?utf-8?B?ZnhWMHM3RFlDaG5nWVVPb1dHelpyZUJELzZWS3loNVBZUDNsenNoNDh5dzZR?=
 =?utf-8?B?ejg4UW1QQTRENHZ5R1pIbmtUZmpLTUpDYmdyL2Y4bjQ4MzhRYXlTaUIwT3Bt?=
 =?utf-8?B?MDFhSzRLSENBR1l3VmFlUFNmTllCL1RGSXdhWWNHZXREZm92cFlRVTJSWEt1?=
 =?utf-8?B?eEhNL3BobEVqUWVIMzFLZHN6djg4cVRZNU9SVmhtSmU5Z3lCNElzd29uSkoz?=
 =?utf-8?B?OE1OUTVqM1VBQzIvcjJCV0pwVlgyOFBqTTJMNjI4TWJWbnU4bVEvSVZtVVo2?=
 =?utf-8?B?c3Z0SmVKdkNhbFR4MU52NUJBUkZDWGFSTy8rZWJFSmNhOGI0dWlPYytJSExE?=
 =?utf-8?B?MHJVNXBPREh4S0daZXdJL2dWVzlOU3MrZ3BoSnF5VTBNd3ZMcGRGdCtkaDA5?=
 =?utf-8?B?UDBpb2h6eGIvNjc5RHp6KzlYOThpcVg4UnA1emYzMmsyUHk4dWdyTWo5V3Nk?=
 =?utf-8?B?L1hpTkR2K1pnNUhWczZBN0VRQ3VoMDVBYUtXZXNPY1FsN2c4ampNd0NVajBP?=
 =?utf-8?B?RXhmZW4xWkc1RW53MEkxSGc2RzdnLzY1STBkRU0wdUdZcEJlQ2tPekRpV3Mx?=
 =?utf-8?B?aEJyQTJROTB5ajZKZENTR1J6T29JQ1ZtcXNITlMyYnZJL2MyT3MzM1k2eGcv?=
 =?utf-8?B?V3gweWVraFhDTFlIcG13M0g0a29GR1N6K2N4ZmlUZkpoV1RxM0R2Uk9zd3Br?=
 =?utf-8?B?SGhqcHJsck5UKy9HRjhUUzd6cmN3TnpndUtUSUw2WjR2NmhLOVR3K0F4eTNM?=
 =?utf-8?B?ZWhqZ2ZhZUszcVRiRmV6OXlrYnN3RTVUNWo4czJRK0p1Y3NkcmNxZU5kenVJ?=
 =?utf-8?B?dUVIVG00dW9ESVNzYm1KSDY1ajBnalNCZGkwWkxWMXFVeTJiamRQU21qU0ts?=
 =?utf-8?B?alU1V3pacXhxU0d5bzJUUWtGTUEyOWNlYm43R1U4Unh6R29lZG1QVTRSSXE5?=
 =?utf-8?B?YU1IZDZQeXhPUTArWGs2NGlZNjlhbm4yUWhmUzBEVmxEMERvRXlqV0NJK2ps?=
 =?utf-8?B?R2FhZ0pBVWZjQXAweVlsL2NKUTdpc1BzaEUvVHl0S0l4endlWFh6M3BxbHpV?=
 =?utf-8?B?YXlRSTk2OVl1RTEwd1VYN1NFMWR5dTUyTmc2L3QzUkFmVmRZcDk3YUlVeGsw?=
 =?utf-8?B?UTNoTXk4TERiMWVVYnJPTnQ2UjRVajU3Qkx0dE9HWURDR2dTYmV1dVYvWjZu?=
 =?utf-8?B?dTlQYXdRRkJ1YitvMUpkS1ZySVZvcUQ3VzRPeVNqZmZ2bWg1akNCVWE4N3F6?=
 =?utf-8?B?NC9vaXJZOHBvVWE2M0toM3JaQTdMc0Z5UnRydkVYQStMUHpvZkExL2ZuMCtF?=
 =?utf-8?B?bGRyTEpNd0NzUXNoeEFucDUrY0hZa0FpUXgvMVYrQWsrY05odG5ueHFCRHZU?=
 =?utf-8?B?Q0ZiRDhQQUl4cTQ0eG56RTVJRC9YNm1sWkYwdTFmc3JVY0p5aFpUZXJvd3Mw?=
 =?utf-8?B?Ky9HMkFwdjB6cFBSa3RRVllPK1QyUzVkS0tBWmZxeU9rNnJOZm1EcVNmTFJX?=
 =?utf-8?B?MGVTNkRCb2dtMTR3UGJhWW41UlVWL3Z3WUE3Rjhmdk96ajlhVXV1MU1MTzR1?=
 =?utf-8?B?bXMrcDVpZ0djL3ZIZFFXampZWERhZEZvT0pnTG1DVSs4NEtlRXYxVEhYQTBh?=
 =?utf-8?B?R1pPcGptZHlBTDNDZThNVC83TFlzR3l6SnpnaEtRREhwV1lSb0JiNmJDSksw?=
 =?utf-8?B?M1RkeWJLYVVMSWdaUFpTN09MNmcyNG94aEdCR3R6cWhWTyt3QWsySGUzV3ZX?=
 =?utf-8?B?UXJNVE5oSGhWK1dIc2xEeGp6QklFcFFhbzBZNE9WL2V0b1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U0VHQW5rRUpUK0xrZExlSHZMMnZTRUFhZm5pQVhaSlJJSi8vdXNLU21VU0FF?=
 =?utf-8?B?N29LVzhpSEl0OXhkU3dMZkZJRzJHaHVkakQrVlphblFnWjB4QjNycEdYU0sv?=
 =?utf-8?B?L1A3QVNlRHpIeHBBaUhvdDJiNFNpdkkwUXhkN2FtTmtvRnlDdWlWdGkrdXhp?=
 =?utf-8?B?ZlRmMDhnY3Z4Ly8zMFkwUWo0NzJPSXFlK3BDczJJK0h3ZGJJc21mYjltMytu?=
 =?utf-8?B?WjE3aGZocFhPMW5SOW5XZmZhaE5MVEZzQ2d2akhUOTQ4UG1PU3EvWjFWTlA4?=
 =?utf-8?B?VDlzN2hqVDROZUlWekpCSVkxYUdCZzYvVkJkM3RNVWNPOVppSFlnTHNjc01U?=
 =?utf-8?B?c3NqNkd1d2JsNkRXMDkySjFoVGJTYW5wdGdlVFhRVWNxbVluakttYkp5bFZV?=
 =?utf-8?B?M3ZWZzFPVThHSUdnVWlydjFQTDNIZWVLZmNEOTY3TEx6Zjcya1IwTFhyZ3ZR?=
 =?utf-8?B?eUNHK29GSy95eEhPT3NVQU9NbkJpWXpIZUtBMy9DeFJPRTZnTXJ1dytXc2t1?=
 =?utf-8?B?d2xRaGdtbFh5UGhGSFdDM3ZESnNJVlFhSW4xM0Nlb2NUOTlIT0hSL3hrY0NY?=
 =?utf-8?B?OGJZYkhudyt5cERyNGNKb2JRL0ErUksxSnFDQlVad2ZlR00rVUdWRGpCT3Zn?=
 =?utf-8?B?RmZzQXRiY3ZjeGRIaG90WGZGRTdMc3dTVThJUUxwajFTU3NDdFF2dDRMUysz?=
 =?utf-8?B?bDNtSXh6ZWlBcnJsMlVKVXZTU3ZtV2J1WmdjRzY2dFJiMW4zcWIvdmtsVFdz?=
 =?utf-8?B?MFovVjhtQW1jSGNFQ2tZMCtCQ1ROZGhMK1c4azhoUGJuYTRlRlorWC9sWGJu?=
 =?utf-8?B?a1VqUUJWUUU0YkhWUlNYRTVjN1lZTXhyNklkWEpRZEwvVVNwcTNXTEdjZ25u?=
 =?utf-8?B?M2thRnZPSzRnNE5jaERQQnJQTlFKSUdSVTZmOGczcU5QbkhWcUx1Nmh0Vy9x?=
 =?utf-8?B?aWtLNXJtQlBCSWd1eDlqSzFLS2g4Nk5rUUQ5OVd5M3hMZnhmamhmVFFRSEt3?=
 =?utf-8?B?bEVDcWxQRU5kblpuSXB6UWh2TzMvMXJ3bVNpZ2Y2WGNyUlBBd3BaM2lLT0VC?=
 =?utf-8?B?dHVkV0VEUGRxNXNHcjZqMVhiTG5xM0N5NFlZMEdBbks2ZFJXWDNHQm9RMUZJ?=
 =?utf-8?B?a1hhWUd0aE92WkhDNjRYblMvMkVOSlVzSWNkRTNKNGR2b3JhTkpaK1duWVRC?=
 =?utf-8?B?M0ZHcGhSbVNvZ3lGY0FEWU5GMDFGM250aTloMlg0OGtIcVk0MTBiMmtUaGxX?=
 =?utf-8?B?TEhPdHZXSG14UFFxTkFjV2l1ZDlsQ0JYaVJYclJZZzQvZ01aSW5USVY2UUJI?=
 =?utf-8?B?RHArMDZ0MjNlV2ZaU2pmSjJ2cjBRNlVHSFFiR0J1Z2N3R2h4czR6UjltV1o1?=
 =?utf-8?B?K3d4VC9CMjJQd2lMU1JLYWhSdjFaTzFDR25HakpGYkxyUFVyTWNLVCt2YWQz?=
 =?utf-8?B?eEVaTGwwQUF6Ni9KMHhObkJwakx0ck1JdjRSVGJpMGNGaWZ0N3c0QVEzTXli?=
 =?utf-8?B?VzlXMGJHWjcrU09sc2F6eDZqdnJiOW43YW5KZjNseUFTcGV2d0hDWFdDNmdl?=
 =?utf-8?B?TDZzbHh1aVNsWTlYeDBpdkgyTDFZV0lMTjhaZSt6SkxXTGphT0tJQk1HR3JH?=
 =?utf-8?B?Q0VKOWlnR1RSaUxmdm9IQzVBUFlnTG93M0x4VjRsV2VVekpUcDlsV3BOWmNN?=
 =?utf-8?B?aFFyVFNhNzJkL2VpMmE4Y1pNZFFBQlNKU3IxVjJRaHVpNG5rKzl5YjZVQ01i?=
 =?utf-8?B?WHJDVFBrK2xrSzRxTnczMDlnVjdxV2VDbzhkUGFkeW1HTFJ1UVp1dTRYY1Na?=
 =?utf-8?B?elF6YkRTYk1TQVFFOE0xbVJFNXZLS1RkTGxsbWFzQTM3cHJIcFU4d1hxbHkw?=
 =?utf-8?B?azB5SnVTdmpUeitwWnM3M2dzQWZpcEpYZk51RWorUFNNcHM4SW03OVhVazVw?=
 =?utf-8?B?SnlzT0hyREJNWWdKU1NVZXI4L0lKaWNsTERGc2NPS2QvQW9id1JWdlJkR0pp?=
 =?utf-8?B?ZUJHOExqVit0ZkV3VDZYMnFUOGFSdVRMbmVxRVlmRWdkVFNtWnBMUFAvVWhE?=
 =?utf-8?B?S0lDQW1jWUpESTRid1o2dFI0TGVkdVJCSmorOXBWTHJKMHAwSDVvZXdYclha?=
 =?utf-8?B?T0JEdGRuNkZWRDVmWWI0bXFtQWZpNll1UkdVenhjT0V6b0tFdWh3Z3NoQ2dE?=
 =?utf-8?B?bnhVVExROHpWdksyaGJtOVdvM3pobVl2NHNDcU81dmdIK0VQNE53cjJ5em9L?=
 =?utf-8?B?VllFT2dvN3YycytxZ2hDOHg2WnZRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D45452CBA2DEF745ACFC9B81AAFE2530@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 330af728-e553-4443-1e2b-08dc986a165e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2024 18:34:18.8597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GJ3S4+V5RgMCuFejsCwyQ9OHIp0F/InqVD+5ofXZKJ0llfTI1ls7q4iX0eRciRapaW7Ah3j0DK/mA46lb4OeQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR13MB6584

SGkgTGludXMsDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgNmJhNTlmZjQy
Mjc5MjdkM2E4NTMwZmMyOTczYjgwZTk0YjU0ZDU4ZjoNCg0KICBMaW51eCA2LjEwLXJjNCAoMjAy
NC0wNi0xNiAxMzo0MDoxNiAtMDcwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9z
aXRvcnkgYXQ6DQoNCiAgZ2l0Oi8vZ2l0LmxpbnV4LW5mcy5vcmcvcHJvamVjdHMvdHJvbmRteS9s
aW51eC1uZnMuZ2l0IHRhZ3MvbmZzLWZvci02LjEwLTMNCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFu
Z2VzIHVwIHRvIDZkZGM5ZGVhY2MxMzEyNzYyYzJlZGQ5ZGUwMGNlNzZiMDBmNjlmN2M6DQoNCiAg
U1VOUlBDOiBGaXggYmFja2NoYW5uZWwgcmVwbHksIGFnYWluICgyMDI0LTA2LTIxIDE3OjI2OjAy
IC0wNDAwKQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tDQpORlMgY2xpZW50IGJ1Z2ZpeGVzIGZvciBMaW51eCA2LjEwDQoN
CkJ1Z2ZpeGVzOg0KLSBTVU5SUEMgb25lIG1vcmUgZml4IGZvciB0aGUgTkZTdjQueCBiYWNrY2hh
bm5lbCB0aW1lb3V0cw0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpDaHVjayBMZXZlciAoMSk6DQogICAgICBTVU5SUEM6
IEZpeCBiYWNrY2hhbm5lbCByZXBseSwgYWdhaW4NCg0KIG5ldC9zdW5ycGMvc3ZjLmMgfCA1ICsr
KystDQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQot
LSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJz
cGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

