Return-Path: <linux-nfs+bounces-10995-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E7EA79835
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Apr 2025 00:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42DB13B28D0
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Apr 2025 22:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2026E1F4E3B;
	Wed,  2 Apr 2025 22:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="UzgXTf4Y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2123.outbound.protection.outlook.com [40.107.92.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71561F4168;
	Wed,  2 Apr 2025 22:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743632746; cv=fail; b=QlE+qaxmhk63fe4UqD/1qRfWOVu+orbLU0C+ucSa+eKopZGIUfnjjYr4C+89BM86tzlYlbN2NK+2yGuQDtAaKSICqjOeFaQTVScqxw2WOp2NGUxZMhbzowDd493IcaQIxP4XRF/SIn/NOCMqiDp/4+cXGQpYEqpN33NMUoCy1+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743632746; c=relaxed/simple;
	bh=ziwEu1YeFhFVqO0HOeyQbnoKWbeBqJ9Sf6TnQlh87jk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oJJ5hcVrSQFhrZ1BIDxpu31Yljz6pLIOlj88Z2YjS7EU20mRbN3/seeaqFfBaekQh2/5igWW7rwBJ4pLe8ihLGifpGqFR0n1+8doU3I0e4jYVlZ/Ed9eTwISjKAJ2a6Qc6Rn362i+CSsBitoohpFSO7MmZ6wh+3LmgpGYMZou6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=UzgXTf4Y; arc=fail smtp.client-ip=40.107.92.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=siY92P7z5lM6OiD66fsiHEeJ5Ut8D54YsLInU+2fuvznUUYiTbzbpfISGxRTUmYPUkFE1aENnbaDPjoyTynVPuIdg2L9lqNRyUu0nGFP1pIGV2v5HwFVngKAX6c5xTAeLOF3iNOI0Onp8PdWdPfI08ZmcdMkb4xE3h1JFJ1wj+QIhn/uJFROYVCF7wnJFHIlWt97M8YD028RLEd4Oq0NomZyM5zcL9OlYy4v1/sLyHs9flW4yxfLb81A8kq2JdzQJsOUoVfXtqHDrUkRJM1yKOyF0x78wYurs6M3YHqSosMnRRy6JqgBykRdTdT76sP6x7kzYYsggnjFQmc9fjhrRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ziwEu1YeFhFVqO0HOeyQbnoKWbeBqJ9Sf6TnQlh87jk=;
 b=IpCFF+hTGUtnOJIRl4Oktbm2KW6OYMWLk2BbJ/mjsaFP0pDSdB64zyMNKv/GVwbs0qtHDuExMPjQAr5J6z5/IPOCwCMe1BMOjZPY46dLJ3ilx3p8LqbDLqEKjb6UmP0rwg0zHu/yCCKBorxJHgDh31TW+sdPvYcG1EVD8EDXOQ127LgtvKzk2SaQsovUF4kI+tHkeNMtfJwFU3xxzUCQDYxV6hCWegV9mZiNr9pBMTtNuqThwaob2zThniVnVqTNO5Mah1DGFbGM4KBjiNvfFGka22qxH0kUedEFJB5EZh8krB9JodSruY/WA1H0HxLEKBpK+yR6j2sOPriIeNFnaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ziwEu1YeFhFVqO0HOeyQbnoKWbeBqJ9Sf6TnQlh87jk=;
 b=UzgXTf4Y1+Qx9S+REBsdzNNMc3MtW5PTTrhDMAEO/rmQ5QK45MBJNQ2aA+TuERj9RnqpqJAAtEZkJkSwuJFelJUf4R+M0BXRcLFHMTqljKzp6FFuKN2R3Z0l9yXwbRVb3EVFyX371y1DAfuWSc5Dujz1xniScBUgyoIyxq2O3Ck=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MN2PR13MB3646.namprd13.prod.outlook.com (2603:10b6:208:1e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.41; Wed, 2 Apr
 2025 22:25:40 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%3]) with mapi id 15.20.8583.038; Wed, 2 Apr 2025
 22:25:39 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull NFS client changes for Linux 6.15
Thread-Topic: [GIT PULL] Please pull NFS client changes for Linux 6.15
Thread-Index: AQHbpB4pm6lJFWtd2EihCQNvan77Pw==
Date: Wed, 2 Apr 2025 22:25:39 +0000
Message-ID: <b58d64f4a25d80b38743c29ad40d6af0ba7419f6.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|MN2PR13MB3646:EE_
x-ms-office365-filtering-correlation-id: 372168b7-4131-4618-0859-08dd72354c68
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZXoyS1BYeU0rdVVCd0dReGZZbDZvdUM0b2NKMEsrQjkrS1M0SWNralNRMEky?=
 =?utf-8?B?ck8yejYwck1KSi9ZQzhKZ1dKVlk1Y2dyQjR3QVV6ZjBpeUVsd3BOS1FIZTdM?=
 =?utf-8?B?WGZDaGVHMkZPMzAwUmpVaXZZOUFwWk1wK29OL3lIV1BwKysyTCtnTXpaSjc0?=
 =?utf-8?B?VCsvbEN3bG9ub2Ryb2g1VWw0Zi9XT1hma09CZ3ZxTU01VWRSOFZJbnZGK3Ir?=
 =?utf-8?B?ZjhrVzEvTG5WbHI0TC9MNDZya2RZeWpyay9saWFJakFnSEF2R2lISUhjZ0gx?=
 =?utf-8?B?RFhXTVQrczhJZ2hyT0lGQUJJY1FCWjIzY1FacFpPbkFSYXNCdis4a0duTFZV?=
 =?utf-8?B?ZkFkUUltMWlDWE5qdzVyK2NERTV0TTM3WU9sSXJsR0FwODZwdVBFUjkrRTBP?=
 =?utf-8?B?L0FiSXU2Ris3TGlWRDBsSzIrazVRMjFUeElLNlp2OFJzS3VjdWRDK3d5dHVD?=
 =?utf-8?B?bmZqemJONjl0UDZLVXNIOXVGY1M1ZEFvM1FhUzhhK2I4MXVqSmVmdEFHVHhY?=
 =?utf-8?B?bDViWi8rc1BCTXFaSmM4M1dmOXRua1RVZFBPcHNWRFA1OXRWTDY1ajhRektu?=
 =?utf-8?B?MGFxNndVaFlwQWJCNTVvRUtidDAvcFJHL2wwNnZlc3NCM29wdUpZVUwvelQv?=
 =?utf-8?B?c3dXbG9RWTA1a1J5Zmd6cWp2Vk5Fb2ZUcDNZMG9EQXFLSVZSc0NMQ2sxTUox?=
 =?utf-8?B?cFR2eUtXZW1naDVlNXFNdWZhWjlISHJEZWw1VG1abEVvUVJYMVMrRnVoUGZU?=
 =?utf-8?B?VmZ6YTUzYTZ0ZUdjcE1vZ3hPMCt2ZGV6M3NxWFMwZVlxeHJQN3ZRL094bHE3?=
 =?utf-8?B?SitpNTJ1MDY0eStMSnRKUDZjOU5hUlNyMGN2WkhCdi9rSnJ1NWlnM3N6RE9x?=
 =?utf-8?B?TjBPbWdhSklxK0YzR2tkeWNuRWNscTg4OWFzZU5LU0IzTFRHU05UUUpucHh4?=
 =?utf-8?B?RW9XYTZaWDJlUjV2Znh1a2VnQU9JVDM1K0RIZFBFaWtCbHRVWk1BNW0rMXZq?=
 =?utf-8?B?WWVGdWU5a3dRT1B4LzR4UW1vUnpRV29DQUpsTzEwQkU1WVBUZTBVZ1NPYnR1?=
 =?utf-8?B?UFBiakpnYUg0R2NTSWVYNHFlWUpUU0tkUHBqN1Y5TzNXWll2ZW8vZ2x0SG95?=
 =?utf-8?B?dXhHdzVvbWR1cy91SmxjU2NLWlljSTgyYXJRUlJXN2daeUlXYnl5b2s0N1c4?=
 =?utf-8?B?WDUvRGx0VmZvQ0F2ZzYyRWQyWWJnOU1GRHY0M2hxYm9tZVVnc2loQnFFVDJC?=
 =?utf-8?B?Q1RaVEcxQWhNQUhLb3QwdkQyc3pEV2dBN2lYWU85REFwV0J2L3FQZGoveUli?=
 =?utf-8?B?VEVudGtRY1FUeE9PQ2FkRG90QndMYll0VGhaMVZxUC9qNFFFbnczdWM5QXNx?=
 =?utf-8?B?a3ZVMzBkM0dPRG5kNDl0RXRTMXZjY2NnVUxKNUV4UzFlSVhrOFNvNStuZXk0?=
 =?utf-8?B?UzdUb1JadnhDWVl3dWFmS0JUcm8xM29CbVBob2RROENFdmxNMHNXTGRjVU0r?=
 =?utf-8?B?bXY0b295SUxxTjl1elo2Q2lzVTF2QitRS3B6UDVnN3d2WGpiUFpNZTZYZGdN?=
 =?utf-8?B?aEJXaExxakxYNVNsa0hUY0tGa3ZaKzRjbkllWDVNT3hmVDlWWlJyejZZTnFx?=
 =?utf-8?B?QXJQQ2R3c3RtTGpNTW1nRzB1emV4RmVMYmhpTFpEZGZaUk1OeGZHRmF3OWlM?=
 =?utf-8?B?dUNQODdOVDZzNGNTcDZRK1dCeUQvbVYrbkxrSDZuOWZzbEdjenJiTmxhRVg0?=
 =?utf-8?B?bW8zdlhNMElKM3ZEbjIrNy91U1QzVWQ4NlJ4Ri9BOENDK2FVT2tFUEZZU0ZC?=
 =?utf-8?B?dURiL3RMQmRvUDUwYy9wK1l6WkoxLyt4Wk1WNkhiUEJUMEtjMWtQb3V4Ulpk?=
 =?utf-8?B?R1dwTkdTQmFpYXhFa24xaFNFWThoZDlQRVdQS1Mwd1NGVWZOdTBNUCtMR3hY?=
 =?utf-8?B?S0JPWndaaHFYNk9uMTZ3UGN3cUFDNFZPbE45ZVpjVnoyOTRWRTlBN3AwWlBp?=
 =?utf-8?B?aHR4ZmVOMkp3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NXdsbW5BVElCK3d0a1BUSVhEV3BwMkNnb1JaOUZCZ29IdWJLNFgvY0lRSUs3?=
 =?utf-8?B?L29FM2wva0hVcytIeEpvZ0xYYzJwdy9EYkRPeEQ0SmZPdkxMWTRGOHVhOXFk?=
 =?utf-8?B?aUxoc1RJbWIyeVlXaUhoTnpnVjhWMWtaNitHclZFSDBheUpFYWZLMGlIUjJP?=
 =?utf-8?B?S0M5MWs3WlpPYXRoN2c1eEJ4R0dqRGE0WkJpaGIxOFNVdXlOdzFveTcxTENF?=
 =?utf-8?B?RThmZjBNVjdSUVJ3QXRPK0E0aUdGSjl6WVgwTUpDRkl6NDIrTGZIZmI0cytE?=
 =?utf-8?B?Z0V1V2M1bGlpaW0rVjRUbTB1dXEvbENLZXgvcndicTVlMENHdzhBTjdaeXdL?=
 =?utf-8?B?bmRZLzE4WXNVR0Jhem1pYUVvV1RLaGhXenlNQmlEaitjbkxFMEEwTWdOSkZF?=
 =?utf-8?B?UnZxUmlCSmw3bjM2RVo0NkZ3K3pLVm40UkNITFhmUlNVYVhRQ3BKUXI2a2tp?=
 =?utf-8?B?dkcvOW96TGdyVUpobG1vTCtwV1Y0emIwWnFwLzBIMTZxM202UTdrRGwwZTFQ?=
 =?utf-8?B?cTZBYVBSN203M3ZBanVyblRueHlKaHdGeG11ZVZDNnhxaHpObTBKL2lGRml2?=
 =?utf-8?B?ZEw1MDdwMUlTVTRMT0NpWXl2dTV6Yk1XWGl1N0kzMlBDK0hUR0JRTXl3RjVm?=
 =?utf-8?B?MzN2NVl6Z0FTY3V1WEo0VW1kZ2swdHNEeE0vUGVhb1B2L1oreVREekVCQy9n?=
 =?utf-8?B?Z24wMlQ5WXFmNW9zNzBYZk1MNVA3ZFN1c2RSSFNINGs0U0Q3YmtCRmFaZVBI?=
 =?utf-8?B?N3A3RHBKL25Obno0d3FDakRTNS9XVVlrOHFTV3o3eloxdVZFMkE1ZVFCWkZy?=
 =?utf-8?B?d002OW5ta3lhdFpkZ1NhRnVwOGVXcHoyZ3laV3FaVGdvSnVCRGN3RHlyUDJn?=
 =?utf-8?B?NzlPMnQyeWN4M3NkV1lucnZOa3RTZWFIYXpaQzhQUHJZN1JLenkrOWxMMFQw?=
 =?utf-8?B?UlBUMzJqbDlZbEFjM0hEaU51a1h1a3pHZlRBU0l0ckVqZGI0UnpFUU9OVW5N?=
 =?utf-8?B?QVBSVWJ3MWk4bFVYN1A1RWh0aDZ1Y3NYOGpmWHVDMEZGN2twNXFoWVRvQXpa?=
 =?utf-8?B?TTAyUlBQeXlSNHBSU2VUb01ZdEJleTFxa3JLQXRkTFQ4U01VcmFMMXZhY3pK?=
 =?utf-8?B?NkRTTGEwWmVWTFFIOU55dkdnbWlpanBaWDlyVG1YSURLYUJSbDErUEdXQjRt?=
 =?utf-8?B?bWxBOVdJNkl1YWM2RDJ0QzNMeTBqUXl2OHUzNng3UXROeStMVFlWODVYNU5K?=
 =?utf-8?B?OWpvRG42YkxEWmlRZUJKZFpWMUhlL3lJMjFBaURWOGpnUzlGc3h6eWFPTjRB?=
 =?utf-8?B?VjY3dmJ1SzZnNmxyTmpmbFlTTDNnSkJlQkkzTmdDa0hpN1ErMVVaTzZ6NSt0?=
 =?utf-8?B?bzY5a1BhbjhnMjVPWDlqaGc2c3c4NEFHeVl3UWxBbWZneDI2eTNrUzNiWVVE?=
 =?utf-8?B?OTliVG5jdkgvREZIcnpoMkZMdGxxbGhHVGFQb3F1R2xyeENTcUhtT2RxMURW?=
 =?utf-8?B?cnkxRHpKMUVWdVpsVGNWaVk0Um15L2JnQjU1R2tDZFJ2aGxnQmNBMlhZd1Jx?=
 =?utf-8?B?eEl4ZlZlZ2VZOTNkT25xVUtTblBUZWpnOGd5cGdoRGhycGI1L1QxS2U2a0lv?=
 =?utf-8?B?ajM3OUxzQmxwRUNvb0c5QkY3YUJYL3Z0am5tOFJlV1l4WlMyV1RJZXBZNzIy?=
 =?utf-8?B?REFRUHY5TmxYQTlrellCVHVlU2U2a2N0NGdvZWRGemE5MzhaVEcxblJCMUFB?=
 =?utf-8?B?Wnk5MDdzTGlVeXNvN1BLaHNIb1FaNWJjMUFpM0xpSDVWT0RVSUYrM0N0bEgr?=
 =?utf-8?B?L0NGWjlnbXU3dkZVWUl5Q2RKTXREdHVUSVM0cUJvOWRvWmx1YWlXWTFSQ0RL?=
 =?utf-8?B?SWVhS1VacmxWNHE1OVR6N3ZMeDArZlRvWGp1UGtmR015UkxuSkpyZ29SVjRU?=
 =?utf-8?B?VEI5WG5jS283cTVRMUx6eVFBN281UkM1SEY2bFBHTFgrSnpZT25QSC9NTXVR?=
 =?utf-8?B?NE11TGhNTzEva1drNmZJR3ZNR1l0dnBTYkozaDA3bjZNN1JQaGZPOWRBb1M1?=
 =?utf-8?B?b3FyYWI1cC9hVlZSTDVYcFJtVEUyZDA5VVdyS0dXUjBnWXVCeFcrS0Y3eThH?=
 =?utf-8?B?NWl5WVVUYzJOUmNka3hXYWRUYWpmN1lKR1ZvS0hiallkL0k0bE52WUZiOFE3?=
 =?utf-8?B?N3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <96478E4A909A4849B8E7446E433A2388@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 372168b7-4131-4618-0859-08dd72354c68
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2025 22:25:39.6921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GAwJ+mGw/CWVXGjEvsYQzEDbsq4ekeO6WnPp7I7umPMS1ue+72f7bdzDvkaNuMgAVLf4r5GKUfuJUZhR8mQeng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3646

SGkgTGludXMsDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgNDcwMWYzM2Ex
MDcwMmQ1ZmM1NzdjMzI0MzRlYjYyYWRkZTBhMWFlMToNCg0KICBMaW51eCA2LjE0LXJjNyAoMjAy
NS0wMy0xNiAxMjo1NToxNyAtMTAwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9z
aXRvcnkgYXQ6DQoNCiAgZ2l0Oi8vZ2l0LmxpbnV4LW5mcy5vcmcvcHJvamVjdHMvdHJvbmRteS9s
aW51eC1uZnMuZ2l0IHRhZ3MvbmZzLWZvci02LjE1LTENCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFu
Z2VzIHVwIHRvIDhlNTQxOWQ2NTQyZmRmMmRjYTlhMGFjZGVmMmI4MjU1ZjBlNGJhNjk6DQoNCiAg
bmZzOiBBZGQgbWlzc2luZyByZWxlYXNlIG9uIGVycm9yIGluIG5mc19sb2NrX2FuZF9qb2luX3Jl
cXVlc3RzKCkgKDIwMjUtMDQtMDIgMDk6NTM6MTYgLTA0MDApDQoNCi0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCk5GUyBjbGll
bnQgdXBkYXRlcyBmb3IgTGludXggNi4xNQ0KDQpIaWdobGlnaHRzIGluY2x1ZGU6DQoNCkJ1Z2Zp
eGVzOg0KLSAzIEZpeGVzIGZvciBsb29waW5nIGluIHRoZSBORlN2NCBzdGF0ZSBtYW5hZ2VyIGRl
bGVnYXRpb24gY29kZS4NCi0gRml4IGZvciB0aGUgTkZTdjQgc3RhdGUgWERSIGNvZGUgZnJvbSBO
ZWlsIEJyb3duLg0KLSBGaXggYSBsZWFrZWQgcmVmZXJlbmNlIGluIG5mc19sb2NrX2FuZF9qb2lu
X3JlcXVlc3RzKCkuDQotIEZpeCBhIHVzZS1hZnRlci1mcmVlIGluIHRoZSBkZWxlZ2F0aW9uIHJl
dHVybiBjb2RlLg0KDQpGZWF0dXJlczoNCi0gSW1wbGVtZW5hdGlvbiBvZiB0aGUgTkZTdjQuMiBj
b3B5IG9mZmxvYWQgT0ZGTE9BRF9TVEFUVVMgb3BlcmF0aW9uIHRvDQogIGFsbG93IG1vbml0b3Jp
bmcgb2YgYW4gaW4tcHJvZ3Jlc3MgY29weS4NCi0gQWRkIGEgbW91bnQgb3B0aW9uIHRvIGZvcmNl
IE5GU3YzL05GU3Y0IHRvIHVzZSBSRUFERElSUExVUyBpbiBhDQogIGdldGRlbnRzKCkgY2FsbC4N
Ci0gU1VOUlBDIG5vdyBhbGxvd3Mgc29tZSBiYXNpYyBtYW5hZ2VtZW50IG9mIGFuIGV4aXN0aW5n
IFJQQyBjbGllbnQncw0KICBjb25uZWN0aW9ucyB1c2luZyBzeXNmcy4NCi0gSW1wcm92ZW1lbnRz
IHRvIHRoZSBhdXRvbWF0ZWQgdGVhcmRvd24gb2YgYSBORlMgY2xpZW50IHdoZW4gdGhlDQogIGNv
bnRhaW5lciBpdCB3YXMgaW5pdGlhdGVkIGZyb20gZ2V0cyBraWxsZWQuDQotIEltcHJvdmVtZW50
cyB0byBwcmV2ZW50IHRhc2tzIGZyb20gZ2V0dGluZyBzdHVjayBpbiBhIGtpbGxhYmxlIHdhaXQN
CiAgc3RhdGUgYWZ0ZXIgY2FsbGluZyBleGl0X3NpZ25hbHMoKS4NCg0KLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KQW5uYSBT
Y2h1bWFrZXIgKDUpOg0KICAgICAgTkZTOiBBZGQgaW1wbGlkIHRvIHN5c2ZzDQogICAgICBzdW5y
cGM6IEFkZCBhIHN5c2ZzIGF0dHIgZm9yIHhwcnRzZWMNCiAgICAgIHN1bnJwYzogQWRkIGEgc3lz
ZnMgZmlsZXMgZm9yIHJwY19jbG50IGluZm9ybWF0aW9uDQogICAgICBzdW5ycGM6IEFkZCBhIHN5
c2ZzIGZpbGUgZm9yIGFkZGluZyBhIG5ldyB4cHJ0DQogICAgICBzdW5ycGM6IEFkZCBhIHN5c2Zz
IGZpbGUgZm9yIG9uZS1zdGVwIHhwcnQgZGVsZXRpb24NCg0KQmVuamFtaW4gQ29kZGluZ3RvbiAo
MSk6DQogICAgICBORlM6IEV4dGVuZCByZGlycGx1cyBtb3VudCBvcHRpb24gd2l0aCAiZm9yY2V8
bm9uZSINCg0KQ2h1Y2sgTGV2ZXIgKDQpOg0KICAgICAgTkZTOiBJbXBsZW1lbnQgTkZTdjQuMidz
IE9GRkxPQURfU1RBVFVTIFhEUg0KICAgICAgTkZTOiBJbXBsZW1lbnQgTkZTdjQuMidzIE9GRkxP
QURfU1RBVFVTIG9wZXJhdGlvbg0KICAgICAgTkZTOiBVc2UgTkZTdjQuMidzIE9GRkxPQURfU1RB
VFVTIG9wZXJhdGlvbg0KICAgICAgTkZTOiBSZWZhY3RvciB0cmFjZV9uZnM0X29mZmxvYWRfY2Fu
Y2VsDQoNCkRhbiBDYXJwZW50ZXIgKDEpOg0KICAgICAgbmZzOiBBZGQgbWlzc2luZyByZWxlYXNl
IG9uIGVycm9yIGluIG5mc19sb2NrX2FuZF9qb2luX3JlcXVlc3RzKCkNCg0KTmVpbEJyb3duICgx
KToNCiAgICAgIE5GUzogZml4IG9wZW5fb3duZXJfaWRfbWF4c3ogYW5kIHJlbGF0ZWQgZmllbGRz
Lg0KDQpUcm9uZCBNeWtsZWJ1c3QgKDE3KToNCiAgICAgIE5GU3Y0OiBEb24ndCB0cmlnZ2VyIHVu
ZWNjZXNzYXJ5IHNjYW5zIGZvciByZXR1cm4tb24tY2xvc2UgZGVsZWdhdGlvbnMNCiAgICAgIE5G
U3Y0OiBBdm9pZCB1bm5lY2Vzc2FyeSBzY2FucyBvZiBmaWxlc3lzdGVtcyBmb3IgcmV0dXJuaW5n
IGRlbGVnYXRpb25zDQogICAgICBORlN2NDogQXZvaWQgdW5uZWNlc3Nhcnkgc2NhbnMgb2YgZmls
ZXN5c3RlbXMgZm9yIGV4cGlyZWQgZGVsZWdhdGlvbnMNCiAgICAgIE5GU3Y0OiBBdm9pZCB1bm5l
Y2Vzc2FyeSBzY2FucyBvZiBmaWxlc3lzdGVtcyBmb3IgZGVsYXllZCBkZWxlZ2F0aW9ucw0KICAg
ICAgTkZTOiBBZGQgYSBtb3VudCBvcHRpb24gdG8gbWFrZSBFTkVUVU5SRUFDSCBlcnJvcnMgZmF0
YWwNCiAgICAgIE5GUzogVHJlYXQgRU5FVFVOUkVBQ0ggZXJyb3JzIGFzIGZhdGFsIGluIGNvbnRh
aW5lcnMNCiAgICAgIHBORlMvZmxleGZpbGVzOiBUcmVhdCBFTkVUVU5SRUFDSCBlcnJvcnMgYXMg
ZmF0YWwgaW4gY29udGFpbmVycw0KICAgICAgcE5GUy9mbGV4ZmlsZXM6IFJlcG9ydCBFTkVURE9X
TiBhcyBhIGNvbm5lY3Rpb24gZXJyb3INCiAgICAgIFNVTlJQQzogcnBjYmluZCBzaG91bGQgbmV2
ZXIgcmVzZXQgdGhlIHBvcnQgdG8gdGhlIHZhbHVlICcwJw0KICAgICAgU1VOUlBDOiBycGNfY2xu
dF9zZXRfdHJhbnNwb3J0KCkgbXVzdCBub3QgY2hhbmdlIHRoZSBhdXRvYmluZCBzZXR0aW5nDQog
ICAgICBORlM6IFNodXQgZG93biB0aGUgbmZzX2NsaWVudCBvbmx5IGFmdGVyIGFsbCB0aGUgc3Vw
ZXJibG9ja3MNCiAgICAgIE5GU3Y0OiBGdXJ0aGVyIGNsZWFudXBzIHRvIHNodXRkb3duIGxvb3Bz
DQogICAgICBORlN2NDogY2xwLT5jbF9jb25zX3N0YXRlIDwgMCBzaWduaWZpZXMgYW4gaW52YWxp
ZCBuZnNfY2xpZW50DQogICAgICBORlN2NDogVHJlYXQgRU5FVFVOUkVBQ0ggZXJyb3JzIGFzIGZh
dGFsIGZvciBzdGF0ZSByZWNvdmVyeQ0KICAgICAgU1VOUlBDOiBEb24ndCBhbGxvdyB3YWl0aW5n
IGZvciBleGl0aW5nIHRhc2tzDQogICAgICBORlM6IERvbid0IGFsbG93IHdhaXRpbmcgZm9yIGV4
aXRpbmcgdGFza3MNCiAgICAgIE5GU3Y0OiBDaGVjayBmb3IgZGVsZWdhdGlvbiB2YWxpZGl0eSBp
biBuZnNfc3RhcnRfZGVsZWdhdGlvbl9yZXR1cm5fbG9ja2VkKCkNCg0KIGZzL25mcy9jbGllbnQu
YyAgICAgICAgICAgICAgICAgICAgICAgIHwgICA1ICsNCiBmcy9uZnMvZGVsZWdhdGlvbi5jICAg
ICAgICAgICAgICAgICAgICB8ICA2NiArKysrKysrLS0tLQ0KIGZzL25mcy9kaXIuYyAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgICAyICsNCiBmcy9uZnMvZmxleGZpbGVsYXlvdXQvZmxleGZp
bGVsYXlvdXQuYyB8ICAyNCArKystDQogZnMvbmZzL2ZzX2NvbnRleHQuYyAgICAgICAgICAgICAg
ICAgICAgfCAgNzEgKysrKysrKysrKystDQogZnMvbmZzL2lub2RlLmMgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgIDIgKw0KIGZzL25mcy9pbnRlcm5hbC5oICAgICAgICAgICAgICAgICAgICAg
IHwgICA1ICsNCiBmcy9uZnMvbmZzM2NsaWVudC5jICAgICAgICAgICAgICAgICAgICB8ICAgMiAr
DQogZnMvbmZzL25mczNwcm9jLmMgICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKy0NCiBmcy9u
ZnMvbmZzNDJwcm9jLmMgICAgICAgICAgICAgICAgICAgICB8IDE3MiArKysrKysrKysrKysrKysr
KysrKysrKysrKy0tDQogZnMvbmZzL25mczQyeGRyLmMgICAgICAgICAgICAgICAgICAgICAgfCAg
ODYgKysrKysrKysrKysrKysNCiBmcy9uZnMvbmZzNGNsaWVudC5jICAgICAgICAgICAgICAgICAg
ICB8ICAgNyArKw0KIGZzL25mcy9uZnM0cHJvYy5jICAgICAgICAgICAgICAgICAgICAgIHwgIDE3
ICsrLQ0KIGZzL25mcy9uZnM0c3RhdGUuYyAgICAgICAgICAgICAgICAgICAgIHwgIDE0ICsrLQ0K
IGZzL25mcy9uZnM0dHJhY2UuaCAgICAgICAgICAgICAgICAgICAgIHwgIDExICstDQogZnMvbmZz
L25mczR4ZHIuYyAgICAgICAgICAgICAgICAgICAgICAgfCAgMTkgKystLQ0KIGZzL25mcy9zdXBl
ci5jICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA0ICsNCiBmcy9uZnMvc3lzZnMuYyAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICA4MiArKysrKysrKysrKystDQogZnMvbmZzL3dyaXRlLmMg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDQgKy0NCiBpbmNsdWRlL2xpbnV4L25mczQuaCAg
ICAgICAgICAgICAgICAgICB8ICAgMiArDQogaW5jbHVkZS9saW51eC9uZnNfZnNfc2IuaCAgICAg
ICAgICAgICAgfCAgIDggKysNCiBpbmNsdWRlL2xpbnV4L25mc194ZHIuaCAgICAgICAgICAgICAg
ICB8ICAgNSArLQ0KIGluY2x1ZGUvbGludXgvc3VucnBjL2NsbnQuaCAgICAgICAgICAgIHwgICA1
ICstDQogaW5jbHVkZS9saW51eC9zdW5ycGMvc2NoZWQuaCAgICAgICAgICAgfCAgIDEgKw0KIGlu
Y2x1ZGUvbGludXgvc3VucnBjL3hwcnRtdWx0aXBhdGguaCAgIHwgICAxICsNCiBpbmNsdWRlL3Ry
YWNlL2V2ZW50cy9zdW5ycGMuaCAgICAgICAgICB8ICAgMSArDQogbmV0L3N1bnJwYy9jbG50LmMg
ICAgICAgICAgICAgICAgICAgICAgfCAgMzMgKysrKy0tDQogbmV0L3N1bnJwYy9ycGNiX2NsbnQu
YyAgICAgICAgICAgICAgICAgfCAgIDUgKy0NCiBuZXQvc3VucnBjL3NjaGVkLmMgICAgICAgICAg
ICAgICAgICAgICB8ICAgMiArDQogbmV0L3N1bnJwYy9zeXNmcy5jICAgICAgICAgICAgICAgICAg
ICAgfCAyMDIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogbmV0L3N1bnJwYy94
cHJ0bXVsdGlwYXRoLmMgICAgICAgICAgICAgfCAgMjEgKysrKw0KIDMxIGZpbGVzIGNoYW5nZWQs
IDgwNyBpbnNlcnRpb25zKCspLCA3NCBkZWxldGlvbnMoLSkNCg0KLS0gDQpUcm9uZCBNeWtsZWJ1
c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xl
YnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

