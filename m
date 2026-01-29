Return-Path: <linux-nfs+bounces-18598-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8O8PFaUge2lPBgIAu9opvQ
	(envelope-from <linux-nfs+bounces-18598-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jan 2026 09:56:05 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B22ADD4C
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jan 2026 09:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 804683006820
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jan 2026 08:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF80A37D10E;
	Thu, 29 Jan 2026 08:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="SqB5cxg4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010060.outbound.protection.outlook.com [52.101.229.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C4837C0ED
	for <linux-nfs@vger.kernel.org>; Thu, 29 Jan 2026 08:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769676678; cv=fail; b=lAMlbWRxPbInJhSeeUlRP2h6nH5S5x8yWTylIEOPtQQoyXJQDb17z3jnRFGdEbe1IMIhGzeQrdmJB/tEKxPoPTNW+/pTjozBhGnFZcdU6R76dYOEi0DxZv280nTLftidwIQZCgGdEuzwMq1sAb+uWx7fK2sTozhI2Jg0FkLeCvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769676678; c=relaxed/simple;
	bh=mVtocTPAiHJHn7r2ZT5Ch8aD0VdyOpGmavBZf+XqBTw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OWExjx3jKfWkdrS6Dnv8kADA51HJBeAVfVzuAJIN1LzW+qNek71jjcEFxiFr33abBEBUaKDhstTqCnL2icNwdQrsfMBJnyxx1dz5mttEzvXGPW3fYdrdeMpdzzgszp7Fs/Jeq3Iu73QdH8ntQRIbgUHB3jEunCfzaCN3gazHWMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=SqB5cxg4; arc=fail smtp.client-ip=52.101.229.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oabgcT+4aViq6E/VEuUUcTa3lyqodFzTs1u9qZA++hKPVBg9iQS0dUxGWugrVV+Y7PceMCEoN6qjfMAP+WMAyQoL69SSdrHawkypEIF6Pjh2Wm0zbQWRIjsNNAoYfmeR0tEwQqYkB3o9K9RqmbAace5/QFeDnY/13hrGK1cNK2Ph6qrcjRmmkW+GYvxu+NXEWTLQu88XSe36o4DKlNWXPNj9nXS0fjMEBa/9GvCcd3hN4Eljb9Z+evOlqz7cskJuB7fNBulLGIqVMamfYe/ADb83/eV92SF2ZxlGVZfR9v5C+fer7ukOv3z3Xz4594NwiTk+N9K002vwwYGMIxuhqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVtocTPAiHJHn7r2ZT5Ch8aD0VdyOpGmavBZf+XqBTw=;
 b=Dn99ew/RxwzFIv4sYPHSRZEdzuEFKBEuYGMB7nXoP38x6QIXZg3EgM4bAtNoBC6Ora5emx70iYJ6xRbaMXaO9SFH4XFLU81sn6uwi1p/nNPwlfRNqxpO01O15v7u1zn+Z8iXd07fTmuz8augXGWoNFVDhMUwZEWF+gEJPVK414g6aREEVZ2YhV/DUifTvk3m34n77Dax1YA5uH6RRyR/zPSZ5dKIr2zcjY7I7Imjwy4GNgzDXvnUMyoSOTUvLwUGxcDToSLYIMLRQPc3cp9wdA40KwgeSgiYuk4z0hKbiJI4ZLUApXW8fOcF6WJ3GOE5SST+zcCH1sb0BNzOmPlvQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVtocTPAiHJHn7r2ZT5Ch8aD0VdyOpGmavBZf+XqBTw=;
 b=SqB5cxg4cWC7H9YllnE1inkuSfzW+oHROcV6k4mwqb/xKtuYXHbSjvqge4bdre9zXmCppnUHhcrwsZSi44WQiqdN4kttPzW5WUXuXjk/UDZXy8c2ut88CjKS2/C8iHXcSoWe+dzmbPagNeDWKnR87DDvIVQFBZFTy9HIzc0o6EQcWT6CETD6jfqN3C/l/OxJBUtkyeHR5qS2gtLqJQJS0+ZK5vzBfbEHLYL1yDNBMfVznzZOInW1lc7Vyo74k6cV+Q5JnOeRYgNxuUgy8gVplZTWz1j9VhBO6llf3IV5A+EQI/foJy2gfrmv22oinp5Nc5LZ/7zUQuclBMA6QZc1fw==
Received: from OSZPR01MB7772.jpnprd01.prod.outlook.com (2603:1096:604:1b4::7)
 by TYYPR01MB15165.jpnprd01.prod.outlook.com (2603:1096:405:1a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 08:51:07 +0000
Received: from OSZPR01MB7772.jpnprd01.prod.outlook.com
 ([fe80::5956:959c:6018:183a]) by OSZPR01MB7772.jpnprd01.prod.outlook.com
 ([fe80::5956:959c:6018:183a%6]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 08:51:07 +0000
From: "Seiichi Ikarashi (Fujitsu)" <s.ikarashi@fujitsu.com>
To: "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>
Subject: [nfs-utils PATCH 07/10] nfs.man: fix a typo in man page
Thread-Topic: [nfs-utils PATCH 07/10] nfs.man: fix a typo in man page
Thread-Index: AdyQ+rSwjp0oZiXRT96OkqmBW6lw8w==
Date: Thu, 29 Jan 2026 08:51:07 +0000
Message-ID:
 <OSZPR01MB777218E8A381E36AFFA041AF889EA@OSZPR01MB7772.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=d95277c0-dddb-46e4-b578-e48c9ab0d406;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2026-01-29T08:34:06Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7772:EE_|TYYPR01MB15165:EE_
x-ms-office365-filtering-correlation-id: dad20208-1465-484d-5ed4-08de5f138b30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|1580799027|38070700021;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?bG1XL2tNektkWEx0U3RCQ1NBZDY0QTVFMkJvNHBBd3htNDk5UnlYdThQ?=
 =?iso-2022-jp?B?Z3V4cTZFSUs4UzFZQUlMdW1LUTdIWktsektFZXFVeTBpaVN5SUNuNlp5?=
 =?iso-2022-jp?B?bmZXU1g1K2w2MVVOZVBvMVRWdkpXTFRYdDhCWGxQZTQvODhDNXBHU0ZM?=
 =?iso-2022-jp?B?OGdRcDZyVUtaUTFsdlgwc2Zram9tc1dJTE1vS04zb0c4ejBSd0Z2OG1t?=
 =?iso-2022-jp?B?YTRtVkJSaVFKLy9PUjJlUzQvL25lcExST1hKUWx5N0xpY2FUcTN5Zk95?=
 =?iso-2022-jp?B?aGdjeUdTYUg2aTdxZjFKSE9vZEd4cXNrZTBWM04rNzJFM0pDMXF4THdG?=
 =?iso-2022-jp?B?aSsyS1A0dEdhQXZzU25oVkM3TkFmV3dnSnpzTFBCZHU0UGt0OW5KQW1N?=
 =?iso-2022-jp?B?VThnV0FDblVUTDV6TFRlcWJlMG14YU94d2NwRmtSODlSdHZaOS83V0lK?=
 =?iso-2022-jp?B?c2M1OUpVeVhFYW1xS2tZSGEzRVdZMnBCajZ4N2Q5Qml1bGIxOWo0QUxU?=
 =?iso-2022-jp?B?SmVKRitGM25mSHBhN1V5RjByemlaOHNTTEZyMXpNT0I4VnNSbEFObElO?=
 =?iso-2022-jp?B?bzJqR1VsMEtyTWN4TWVvYWtjbnI5VmFaeU9ISGhTZE1UVjM2Ung2RUFY?=
 =?iso-2022-jp?B?SjdCZzkyV0pSZW1leVlWd093OHVqTlBwais0ZzNES3lOaXhiSERWNmFU?=
 =?iso-2022-jp?B?VVc2dnlVSUJHZUlucDV3U05zN1FRZ3YwVDZYQm4vcmprTTdqeVkrOUpJ?=
 =?iso-2022-jp?B?NllVbjdDR3ZDTlNIamdoeEx6ZFNWWXVENzJmKzBPbDh1cUs4bUpUUmtQ?=
 =?iso-2022-jp?B?enQyejgrUkZNc293WTE3SGgxbFgvRmREd2wwUW9KQ2VmOUNJMStZbS9O?=
 =?iso-2022-jp?B?V1hzTXFOZHBjQ0xiVzlkRkVMeFpaNFNuYjNaazRrRHRIZ1hNK2h1eHZw?=
 =?iso-2022-jp?B?UXhrNHpYUjlEcm8yQ1JsejlxVGJVZjZQdXRTOFNSRjV5Rm9paFRpYllQ?=
 =?iso-2022-jp?B?Q1hNbXc3RkFzTzhMYXdzbzdNMWp3U0FEeUF2cEpaRHFGNVlKdzhhY2Uz?=
 =?iso-2022-jp?B?RkI5WVI1RzVTMFdOTUZXQzI2aXIrYTFRTm9oeDlmMDZSSEE0c0Y5S3lN?=
 =?iso-2022-jp?B?SVZqV2ZqWno0LzExYmNCSFpnVzBIOFk0Z2VrSEJkZHNkU3REVUUvL2xo?=
 =?iso-2022-jp?B?bG1jajR0S1JsU203SHAvOGIwMXozdHdhTkx1V2xoTEpBTTZCQW9YS1RX?=
 =?iso-2022-jp?B?aU01K0tMNTJESXVFRXB2am5ad2tLUHZFNzJBVEYwMHNFa3VocTJOS0lr?=
 =?iso-2022-jp?B?YnJqeTVSNWVUZ1dIaEtxOFhkNmQ4UGdmbHJBWHUxaHVMSCtpSEd2bHk4?=
 =?iso-2022-jp?B?WGNNSDMvZFZxU3IwK3BNN2RIRXo2d2MvT25aakJlWGJyUG53ZVB5SWRS?=
 =?iso-2022-jp?B?dGpTdmFrem15a2RnTEZXMkJnVmxGYlR5RG16aDMyS1g0SkkwYXlscExq?=
 =?iso-2022-jp?B?T1ZIN1FoazZ5a1c2NUlYTjhtOGhWMEtGVE1vU3lod0lrN0hrMURyMG13?=
 =?iso-2022-jp?B?d3Z3Z3BFTVYyRlo5SnVWYXV6ZDlJb05RdGx5VFQxSmw2b0FPREJ2VHFK?=
 =?iso-2022-jp?B?UVM4eit2NjJaWkRzTm9NTCtTR2pSQnRrdW5qOG5hZG5Fdkh2QlJJNnFp?=
 =?iso-2022-jp?B?cEIvQStQUGVMRVdqbUI1MWFsZlZCaGVOcUhKaVlyYUY0eEpKcjVJeEND?=
 =?iso-2022-jp?B?SDR0OUVBOHVpdS9uWUtiZVdaUm44ZHlQaGIzQ0lYbWQvTWJ6MGc2N3pi?=
 =?iso-2022-jp?B?N0M0SndvbWFENHdQVm9qeWUrMko1aTBHanhxR3cwME10WGcvdkx1Ly96?=
 =?iso-2022-jp?B?ZWtnN25MOWE0NWtoMjVINVBHeE1RRjBsMHBlem9IMUpYbGVJMWZqaml4?=
 =?iso-2022-jp?B?KzRzbFVNMmF3SHlNWUFlMGVVUWRuU21xa3RjKzU1TWFxZ25FU1Zha2dP?=
 =?iso-2022-jp?B?VlZjM0hBZk5Jd3Z2R0V5VVJlakNRbmtEcldkODhuQzM4L1NQcWtlRklR?=
 =?iso-2022-jp?B?K1lyK1I2bkoxTUt1WmZ3aWhkSHpLOVpQQlVkazNLRjNVWVlIUENYeS9z?=
 =?iso-2022-jp?B?RG51bkRqRFdTWm1HR25DL1orc2hyK1hnN1Iyb2xNTUtvaVNZckhrNWky?=
 =?iso-2022-jp?B?Q1hHL3FEaUJrSmRDUkNMak52VlFpdXYycXJKVkNhZDBqS0s0emYvSno3?=
 =?iso-2022-jp?B?bXpLMmdPRnVyL3h0OTBnbHhhd1NteW5UeTdtWWc5dFhiclMxMDd6Zmtu?=
 =?iso-2022-jp?B?b1JHR1ozSjhScWxROFNESmg2Mjh5M0M0T3diaCsvaVFjQW5MdG10U0V6?=
 =?iso-2022-jp?B?ZjJlbXhoeUZuYnUyRnQ3ZHdaM0EyOE9pbXo=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7772.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(1580799027)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?SzlSSFNqN1c4eHUvUjQ0SWNRQmlRZW1SR0phSFJCb3QzZitZUHRNbnV4?=
 =?iso-2022-jp?B?QTVVckZOL1lIWi9pd2lzMlBacGNJNnVFTEcya2pZdGg3VVRjbDVUWHVv?=
 =?iso-2022-jp?B?aWhEcXoyZXFXa2ZzTnYrVkVCdXZkVk5QOFFIVklzdG04NDVOTXgrUGNj?=
 =?iso-2022-jp?B?YVBOTHhyVnlsYnpQSDZhT0xBaGh3ckNIN2kvdUc2Y2tCMnlCaW1VSC9m?=
 =?iso-2022-jp?B?OGxUbHJ6dFNURTlRZm1VdWpyUnNONzY1UzJDbURLMStEMlRualVoNG5y?=
 =?iso-2022-jp?B?WUhuamVzR1I1L3Jma3F2VklMdzZiT3Q2WmNkZWR3aUw2UFhKWDlidXdD?=
 =?iso-2022-jp?B?eldtRENrOG1BcFpaelN6VXZmZGhwWE5DMHUxUXhabURkU2VlUVJxYWtr?=
 =?iso-2022-jp?B?Y2g5dFVPTVU0WWJBb2VCS1dOZmoxcFlwTDNXeDI2bUFWVnpKNjZ0R1ZZ?=
 =?iso-2022-jp?B?NVp6TlZwS1c5M0ZlQm9HYTFzU0VGOEFkSG8xZmxVNWE4aFBxVENFRW52?=
 =?iso-2022-jp?B?emY2VTdZbUtERU5ndG5HR2RFU290bFk2USt2Mi9RMG91RW8rdFo3L2cz?=
 =?iso-2022-jp?B?cUJ3amNVVDdoMElkMS9ydlR0WUNBYjE2SG8zcXdwM295aC9CTlM3eFp4?=
 =?iso-2022-jp?B?NVdRcG9zN0RNYmJ0bjA3VkFwZlhWSitwRUJMaGZ3NFZsc2Q2L3FORWdi?=
 =?iso-2022-jp?B?Z1V3VkNZS0hWOW5JMTUrYkprRTFzUEZHS3ZsMUpBZ0lYaWdNWW1wV0tv?=
 =?iso-2022-jp?B?RGlseThwV1pxcXJzOE8rays1cnduN1BSK0svVjVpNndodHhkdmp6T3FK?=
 =?iso-2022-jp?B?OTdPZDVrUVZNY21OZW9ONFJqRUVnRC8yc1ZpSkcwU2tnUG1JMFFOb3JC?=
 =?iso-2022-jp?B?QTZzRlB5d3AvNC9xVlRucWVNajlNUGRUb2hLSEpzdjRoazZ4Zi92K2FP?=
 =?iso-2022-jp?B?R0xIUzMySC91elNYNFJoRGVrMFh6eDQweWJaR3dZWHM0elhqVmtlKzZw?=
 =?iso-2022-jp?B?MTBBdjlLb0tGNmJJSjFXV1d2Qk5ZQnNjTXFaOVBXZDRnTWk3KzJHMXJU?=
 =?iso-2022-jp?B?V016MGt2UUpITjBMWjBmOVdNZU5GMnRUTjRMeTNjV0VTSC9DMXJNOTN2?=
 =?iso-2022-jp?B?aG5CeE1vM1ZEaGtzWXczbUwydW9QdERLSFIyMWs1R3JMTSthNHZZMDQ5?=
 =?iso-2022-jp?B?bW5xSTJoNWZEVjdLMlMwRnNRTkpYa3J4VEw0bTZKanV4NElaQjVWaUtU?=
 =?iso-2022-jp?B?Z2luMWtXWERaMlI3OU9FbmVqczBqODE3V3R6blJScnRKVTlFaHpyRUc2?=
 =?iso-2022-jp?B?S1h1UXExbmhVNlBaM3lTV0JVUFQ3TGFmRW5yZnlyQkhlOVZoOGc4ZXhi?=
 =?iso-2022-jp?B?RFVFdlhIaHY2YzIvUkFPU1FWTzdQZzQvUmh1amtrMDNLbHh5SFhaeU1u?=
 =?iso-2022-jp?B?QTc3eXZRQ2M0SXUrTDBnZDQyOWhkOG5yMy9YdVlVdHQwQWZ5YnkwZE9w?=
 =?iso-2022-jp?B?R2t2WHRWRVhudTRQU0ZHU3BLdmNKUmRJRjhrZHNwd0FVTGtFd1p4bW9l?=
 =?iso-2022-jp?B?enZka2NHTklER0dlR0tnRU9oTm5wa0pueWdiYmNOeE9WWEw0NDA0b0JJ?=
 =?iso-2022-jp?B?ZTRySDBURUhTYmx6R1FOY3VkY0E3S05VakdHYmZBSDA5cEFoWmN1NU1Q?=
 =?iso-2022-jp?B?NVozTzQ4NkowWXc1NzgxUjNjRk5PNEhSTWRsYnAwcDFLNkVDcFRrOXA1?=
 =?iso-2022-jp?B?S1lzZC9QcTFwYzFiRFNtNXkrMDNtbUJtQ29XdDk1VFhyVGNuWUZpZXAr?=
 =?iso-2022-jp?B?d2pFQndYclp6SDRFdFFmYkpnRjhKQ2pZeW9YNE5oczJHb3RCaWkxdWVP?=
 =?iso-2022-jp?B?Qi9jZ0pVMjZNMWJadjVOVTZINGxxTmJvUEMzd2oyTWxDZDd1Y3NNaHI4?=
 =?iso-2022-jp?B?VG42U3Bwc1BHYUJkMGFkRWdac3prekhzYTE5aHJhdnBZZ3pudFJzMWFQ?=
 =?iso-2022-jp?B?eDBDVFFib3M0L1dlK1cvSFg5ZHZ1R2d2OFRaUE12SjFyNHFPSUNvMzNN?=
 =?iso-2022-jp?B?LzdyL1RjWjRDZTQrSVJvMURuYThXbVpwV3V0cU5RUkpZNE1HN3JndVI5?=
 =?iso-2022-jp?B?b1EzaVdkWm5PaTJOL093ekNMemhJTGZoeFU4WVFndnh5MW1jQzh2dzFa?=
 =?iso-2022-jp?B?bnczVGlzbUFQUzNwbHdWS2tBcUE1N0x6dTNodmt0MkJyblJHTnFmV09o?=
 =?iso-2022-jp?B?Q29vK0czZ0FWdzdFZkFrKzNCRW1Ccms1WEhndVhtRHR1OUx4QU9yK295?=
 =?iso-2022-jp?B?NnNPSUlraEpvUmhsSnFKTXc0Zzh5aU1tN2xJU2xTcEhnSlFIKzl3a1JZ?=
 =?iso-2022-jp?B?U3VPbmk5bUZHbVdsN1JFOENzY0NQcENCNHFRTm41NzRRbXE2azRuT1Jo?=
 =?iso-2022-jp?B?bERVLzMvZnkrNWJpQ2YzRitWVExiZUxmZzFCR2swNDFrMDROV2p2eTZJ?=
 =?iso-2022-jp?B?OHdMVGdUNjlzaHM2blcwLy81c3QzWEoyYTJ0dz09?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7772.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dad20208-1465-484d-5ed4-08de5f138b30
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 08:51:07.7312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4hzlHOD3h+a4lJp4PoncGWzxNIVpS3yd7PPUX4e0Qapa4KwebBE5V2B0/dlUX70vf942rlvWoebIorPWYSCUu7zHLmcP1OduiFXyWamZUPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB15165
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[fujitsu.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[fujitsu.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18598-lists,linux-nfs=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[fujitsu.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s.ikarashi@fujitsu.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,fujitsu.com:email,fujitsu.com:dkim]
X-Rspamd-Queue-Id: 81B22ADD4C
X-Rspamd-Action: no action

Signed-off-by: Seiichi Ikarashi <s.ikarashi@fujitsu.com>
---
 utils/mount/nfs.man | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
index 94dc29d4..9a461579 100644
--- a/utils/mount/nfs.man
+++ b/utils/mount/nfs.man
@@ -557,7 +557,7 @@ If
 .BR pos " or " positive
 is specified, the client assumes positive entries are valid
 until their parent directory's cached attributes expire, but
-always revalidates negative entires before an application
+always revalidates negative entries before an application
 can use them.
 .IP
 If
--=20
2.47.3


