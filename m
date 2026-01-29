Return-Path: <linux-nfs+bounces-18601-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFFCBNYfe2lPBgIAu9opvQ
	(envelope-from <linux-nfs+bounces-18601-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jan 2026 09:52:38 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84945ADC4D
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jan 2026 09:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68F02301A70C
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jan 2026 08:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FD037D128;
	Thu, 29 Jan 2026 08:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Sl3UqRq4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010060.outbound.protection.outlook.com [52.101.229.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC68637D10E
	for <linux-nfs@vger.kernel.org>; Thu, 29 Jan 2026 08:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769676697; cv=fail; b=n5bzr09OXup3KmtRlFiRxX1QE4vUZ4xCcc13Iln+BCD2VdGLbZ26s3Lh5xHJt/VgZjEJZiqc0a5fOerm4VOdkBW3Vvxwbje5vdhUFdQune1+E0Oz1OOxHHdhr4hCZUFx5SISDc2V19g30r/L8b46D6ON5J47fqk9LblGfusiXys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769676697; c=relaxed/simple;
	bh=oYNeiPmhcvpKSSACK0ktxzGpgeUoS5/m6NiKw1BJBDY=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gg4p0o5JVYQr31TXHH7XzlkeyLE8wZxenl4kRgzTIZWHlysysnAdyihsb035er+aA6e25Pvxh8r+CMZJx7zh7fY63taE/ukAFBZQZW6D5xYFjSUYuuz8N8uP64FrYrCoWKSOvQibxOWPWREWIRXqzbGlMnDKs8hKQnKcmDv3SSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Sl3UqRq4; arc=fail smtp.client-ip=52.101.229.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o6cEUcrV7sYoff5SvvO5sUXr2eDP6tkVdK9b3c0oHcpFr2uDulxtqQdUVrTu9Fg9+fFYrOkkqY5LOSMOb8XinVRD7v9wgpQPEBGb8Iqed/L3MSR/hiJEGYga2S39JTLNyl1pUnwXZfAfBcjY0m2VRE17umgpQr14w6uWnwG+SDEqxUsFn+6x5dnK/dgXkWXTlPNrKMLAc7Smcb6pAe/fqTFeolaXuAMoAmaNGXs21h9YIifWX3zBgwKwUOs7hZ5MhncbxQmDtqYk8IMSV3tRWxs21Q+0W+rnVdvqi/yxwk+UCwYtaaYQn6AcmzMDZwvHfddVu7ej5+o9d7pifi81Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4T1jujDNzg2yLZunxiUHO2kgCBn4vAEk+G9kvLQ2P8=;
 b=csOE0Oo4GUyhaDDaiZeFbV2ujJA1FBFMEU9kSGwrONA6lm9UeBiMMrPEPLpfrwL4G4f39BR7H1ADJIRXPNbAQsrQS6uWUz+mfxU9EV5Wu1xattqNZXhnBT86E3BMDBtdBGo3j+SccbUCnE5SLZ6sFSnYwAbCQMlY87hBn7k/Hq4D+pkI3AMAZXCbLM24MAHQRBpi/ijfR5wmyp5v662YbRV0B/JqznLCROwPQ24yGaBcxLKVmy+EwZG2V67AUqNZbILbmpTQaXVXd1wqzgZUSU0YwSlRV4hV51f+L3FkQr14+x+9z5R6jEXB1d0XTXlU5AjA+v4Klod6KAcNGhwjqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4T1jujDNzg2yLZunxiUHO2kgCBn4vAEk+G9kvLQ2P8=;
 b=Sl3UqRq4IpK2ht0w8UuUZpgHDSC8KAS5NxTXNPJw3d6OzkVZnJCTDYr5qMNWaVDNy7V+p1zlkbDS+Cll19SVO3Sy8t0dB9DlQ5DQKz3d7gyZI9D5aGCM3X3k48irB1HCjOP5RE0Gw2Xd1aWpFwhP/voTzMwsXo/ZaSvM322p90szKm22GoxehRkYrR7vJBaU8U05S6lzbHWHXx199NQDFmYoI5IugL0fewGZZJfTVM0QWAME/Ob0EvXnmJFXE92JyjZ0Kwv0GO7efiyjFa5+jAxPQbAjqWseyzz0CWks73eCylqV5ZnO8t3kKcjloOa2usvi+Dw9W7vOwxIC0IBCpQ==
Received: from OSZPR01MB7772.jpnprd01.prod.outlook.com (2603:1096:604:1b4::7)
 by TYYPR01MB15165.jpnprd01.prod.outlook.com (2603:1096:405:1a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 08:51:22 +0000
Received: from OSZPR01MB7772.jpnprd01.prod.outlook.com
 ([fe80::5956:959c:6018:183a]) by OSZPR01MB7772.jpnprd01.prod.outlook.com
 ([fe80::5956:959c:6018:183a%6]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 08:51:22 +0000
From: "Seiichi Ikarashi (Fujitsu)" <s.ikarashi@fujitsu.com>
To: "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>
Subject: [nfs-utils PATCH 10/10] statd: fix a typo in a debug message
Thread-Topic: [nfs-utils PATCH 10/10] statd: fix a typo in a debug message
Thread-Index: AdyQ+u9A2BfSrznITDuHhNFXpOw98w==
Date: Thu, 29 Jan 2026 08:51:22 +0000
Message-ID:
 <OSZPR01MB77721C055507EC2251B6FD47889EA@OSZPR01MB7772.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=3e2bb699-311d-4692-9b99-493a8067d6ff;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2026-01-29T08:31:37Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7772:EE_|TYYPR01MB15165:EE_
x-ms-office365-filtering-correlation-id: 7993d00c-7738-4e20-3a53-08de5f13942f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|1580799027|38070700021;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?Ym9xbk0zc0FoM0hyOTFpaURzYWFhZnJjMW10S3NnVWtHdlhPYnNBdGt3?=
 =?iso-2022-jp?B?ZWV3cW9wMTkyNzRIUExvZ1hNUmROeUQxaVFjQnA0Q0xlRFlnVVY4T0Fl?=
 =?iso-2022-jp?B?enFJRk1WSlJhQU90UUNsUzRnN0ord2I4bU5BYUl5dUJGVnd3QndVN0VB?=
 =?iso-2022-jp?B?SFp0dWVCY0ZCdUVmVXNybW5DQ01zT1NGYUY4T2NQZEdoVHFhdFlrbHcw?=
 =?iso-2022-jp?B?RlRQU0dDZ3QyVStEQTFCU1BiU1U0byszaXJNZDkvV1lacXNuMWR1a3la?=
 =?iso-2022-jp?B?N0ExSzR1a09MSkFsbWd1TEtlT0N4Y0NJWnhaMmVpZmh6OURHYnUyQjNi?=
 =?iso-2022-jp?B?ckpaL2JtQlVhc0pzcG1ZdnNSUklVTEI0NW1jbGFUUmdkaGZ3bENPV0dm?=
 =?iso-2022-jp?B?Nm1paWhZQWtMcXdNVUF5TURWNlVPTmYvT3RFTjdQMlpiSWE5ZGJ5TjdP?=
 =?iso-2022-jp?B?ZWNYem1OZWlaMlR1ZDl6eDN0Y2FDZ3IvQ0FoaEVPeWFrenpLenBUL3NG?=
 =?iso-2022-jp?B?N20xVm55dlNaZUVXbmZoTzR4d3NYNGJGZHg3d2VucmZPRWoyZEQwZjdW?=
 =?iso-2022-jp?B?ejhad1BXdWRXNUt6YldSUWhkUEFOQXlZS0lCY05kOEdCY002MXZsakF1?=
 =?iso-2022-jp?B?RVoyV2kwOHJVOEdjT05hTlJSYUJxVm5iVlVNNGMwcmFLVWFhbzJ0dXR5?=
 =?iso-2022-jp?B?aVJPUUp2elBPZWJmT2hMTVRkY040R1ByWmp1VjVxcTZ1ZExHZ3NPRHM5?=
 =?iso-2022-jp?B?Tmo4aWJvYzE1UzQ1NXp2bURCYXk4YmcyQlBqUDFKbkkyY29UcE90SGtT?=
 =?iso-2022-jp?B?aWxsbTZMN295ZFF3dFFFZi8yTHQyRGNQN1pLYTBpR28yTEo2L0xTbzZQ?=
 =?iso-2022-jp?B?WmRYSitUM2hpRDh1Z1cyQ1lrNklETkx2UUQ2ZHZ4SUxlayt2bno2RHpx?=
 =?iso-2022-jp?B?bTA5V0dtZHdSZmN0VC81a3BzbE1zSlZFR2kxYkpXei9hNzcxSGtLT1Nq?=
 =?iso-2022-jp?B?b3Iva2YxZTh4c1pNYmxST1lldWdQUHVQb1h5V1Vwem1ObSs2RWlWZjJE?=
 =?iso-2022-jp?B?L3FrL294MnM4bXZ1V3JPTEtzWXNZK1R2dWswOHFYcktKbjMvTEp4OGd5?=
 =?iso-2022-jp?B?Y3U4M1QzN3UwUk04NURZcmhlZThxZUZyVDhSZ2hvN0E1ZzdBZkNIWnU1?=
 =?iso-2022-jp?B?V3JxQ1ltUmJVQnphZnc0aDhqNGNoeXVxOG85UEw1SUxabmoyYWQxeEJQ?=
 =?iso-2022-jp?B?eUFWS2NzYWxpaXErYUxXSEw2ZTFVRXVEWmhhZks0WWh2K3QwL0JTK3ZQ?=
 =?iso-2022-jp?B?UkVLQzlQMDRpeTB6MnA4R0RMWDY5ZkZBMUlKdkFzc1pqelAwclZ6OURF?=
 =?iso-2022-jp?B?alZudHY1NmJsUmN1QmY4T1lDUXRSbjYyc1pteWp4UUQvdmtqSSswTjda?=
 =?iso-2022-jp?B?V2FtN1gxanVWcjFKcHZ5K2I5RHJ5QzlOcVJEUWRDK0tHRjJuUG9oL1Vv?=
 =?iso-2022-jp?B?UDQxakR4eS9yK25MZHQ2UmgxTk1MRUZMbzN1WTBUWW4rMXM4eTNZOUJY?=
 =?iso-2022-jp?B?ak1YYWtqU2hIUlYxR3ZpUGpwZTZsY3VCQ1pIQ3Vmc3dPZWFZNTJjNEpL?=
 =?iso-2022-jp?B?czN2aFlwMm9RSmZiYVhKaUN1Q0luK1NGRUQzVnZDNHRmZkhJK1FPRkJH?=
 =?iso-2022-jp?B?ZjZRRUhMYWtuZ2YwMm5LRGF3Vm84U2lMUkZ5czJDUE84a2l5UFhJTTdn?=
 =?iso-2022-jp?B?dStzMXh2bXJJVUp3STZzeWoraTFwdXZEVnRLc0VFOUQzR1h3T1Rxdk9R?=
 =?iso-2022-jp?B?SEltMFcvM2lLTUdaeUhoSjVWaituWm1iMkFoVkdxNUlSdU80ZHEvUkNs?=
 =?iso-2022-jp?B?cTJ6WFVIVHdaS3RuRFRRMlhhazBiUDFIdlhwb0tiVWhNTFlIYlhxR2gw?=
 =?iso-2022-jp?B?RFJYWXFzaVFVUFNPWDZ0Z1lteEp1V1NqQW55dXQzL1FreGRNQUJxSUxK?=
 =?iso-2022-jp?B?K2FNMlpwenY5ZGZvK0tueFVwbDNlNEhuemhyRzFqdzZUM3RCSEFUTUNI?=
 =?iso-2022-jp?B?alBhU3pUTE5VNnE5ZzNiWVpTRlVuaFNHVm9zMGJvajk5eHlONmpIbnho?=
 =?iso-2022-jp?B?MlVuR3UyKzdhQXFYQ3NCTThQMmtkRkRHbkRoSFBzSk9Tek1XeFFEekJk?=
 =?iso-2022-jp?B?MCt0Ulo5Ull0RFhqSHYvK0pYbWMxbkpOYXl6ZWxYV216VVZtUlN6c0Jm?=
 =?iso-2022-jp?B?QXhaOEhKUGloK0hTaGtLUUVFN2tPUm80SEVYcWNINzFpNjFlLzVEQWdt?=
 =?iso-2022-jp?B?VlRmbktiakNXQUdzdTliUkk4QktOZzR3d1cwbmVob2RhM2M0dmVSbEI3?=
 =?iso-2022-jp?B?OEdESVlYdTVIOE9RUGV3ZjVXRGZ0TkpwUmI=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7772.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(1580799027)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?UkZjSUM4QThBY0lOcnNPS2QyOE5aajVCNVVxSGlqUnU5cjhPcnROd1RM?=
 =?iso-2022-jp?B?UWVBbE9DS2JUNm9wekRyeG9LR1RwZGxQNmZJSE5tSExzUWtRcERNZkZj?=
 =?iso-2022-jp?B?dHhXVEE5YUNOSjM1SzAzVXVKenJlSFEzWll1S0ZjUklnTm5jZEQ4ckhM?=
 =?iso-2022-jp?B?R0VsZ05xMFJ0ckloZFNKRXpRT2V5c3FOMk5OK0JVdUVSTm5hT3RaVzBa?=
 =?iso-2022-jp?B?ZE5Gd3kveDZjNGxyVitaYWIzWEN0aVp0WnZZNExlRXp0bFNGcU5IQUtG?=
 =?iso-2022-jp?B?c3Y0RkEra0pLcnpUNkF4RzkrcG45ZS9pSGEzbWU2cVFFZFRpSUxVSGpG?=
 =?iso-2022-jp?B?NVFzcGxyTXhwaXJUYlIrUng4b3pGdm4yVjA5N0pweW0vMVp5YjNhc1BE?=
 =?iso-2022-jp?B?T2xJbWJ1NmxWSWozOHRVeGozVTkyeGtuSU9SQWIxdHhlTFowb3duYXNo?=
 =?iso-2022-jp?B?V0NQWGdSd1ZYUEUxcjNUdVlUM25TQnZaREl0OW45Zk1RUEM0dXM5dzYx?=
 =?iso-2022-jp?B?aC96UEc2UXA1V25RdVdWdkVLUXl5bHhGNlgycG9aRlMvR2cxamxYY2xT?=
 =?iso-2022-jp?B?eDVOTUQxSkxuVTNGelBEb2NBLzU4YTdzeDhndHZZajhHN3BETzhSMmFU?=
 =?iso-2022-jp?B?NHhzUitCMWNOOWh2RW1VZ25qUDk0Y2VtQW45TjJOVitxbEwvYjd2NDFh?=
 =?iso-2022-jp?B?L0hlQzJqdSt6NG9aNkZRL2FKSVREYUlma1I5cEJnbFk3d2hRdEhYS0dB?=
 =?iso-2022-jp?B?V1EvZjNHYW1LZUo5UkxvbWdxL3Jka2pncUNudzJ6UW50YngvbEFXRjQ0?=
 =?iso-2022-jp?B?bmhnVTNxbDVDQWRqaUdENkpUOWcweXdqMVBwaFh6VWVvMUdpQWFmZHR4?=
 =?iso-2022-jp?B?eXdpeVB5eGFMVEY4ZSs4Tkt0cVRpdmJWTy9yVHVUTGRia0RzWHk5Znpz?=
 =?iso-2022-jp?B?bVVNTjdjZEJhZllucGh2RnhibVh2WHpDdjhyaUxGT3JQbUJyZHpnKzVn?=
 =?iso-2022-jp?B?MjZ2dmFmOSt4cjNUTVByYS8veWFBdzNhYU9LMVhJNlJJQWdPQjIwV1dq?=
 =?iso-2022-jp?B?Qm0yWi9Mbm9SVUZueGFHSUUvamZ1bis1QXl2QzB0THRHbFkyYlJRMHl2?=
 =?iso-2022-jp?B?azNRL2VVT3BtVU1OWUxjbTVsRko1Y2NuOGVlUEcxU2dUVHZjY013L2xp?=
 =?iso-2022-jp?B?aDBsT2dBeDFPbGt4dkcyZmJ6ejJRNHZWVFFqc0l1bWRHckhvTWZTQ2Fi?=
 =?iso-2022-jp?B?ODdyQ2t5VWdUc05meEVNNHRvNVFlUVB6QUtwaG1mbUFpZTdPUHVQMlRQ?=
 =?iso-2022-jp?B?ajc5OVRCUEUyL0FML0I4ZGlQWkJFYk10OVErd09SSS81RVk5TXh0dUt4?=
 =?iso-2022-jp?B?bkdwRmtmcXRXMHVlQisvZEZBcDBXMUtNNkxNcGg0aVdzM3BJR0Vqa2lx?=
 =?iso-2022-jp?B?N1FWTlQrZEVWMUY4dGlOYW1iVVdBL1dMYlcvM2NHWGVvV204UENNaTJt?=
 =?iso-2022-jp?B?VURXdXZ2WnlZTWR6OXQrTmFuRW1yMm9QUHpnZSttR0lSeTdDT0hEUjNX?=
 =?iso-2022-jp?B?TE53UjRrTklFOWlOd3VSc2RkRXk3SFZuKzRsWGcrdFVVVTVyR0tobjVh?=
 =?iso-2022-jp?B?UVNUSURWRm1HS1RBR2ZDVW5PRzM2aHhuWkpQaFVpYmxPQTZCa0hScTJ6?=
 =?iso-2022-jp?B?VWk0TkF5ZnhZK2pyY0k4eTEvN1R4VXVGU0t0cHhmRUdWMnNrTTFtaDZP?=
 =?iso-2022-jp?B?MUduTUxMQ1NmSWFKaWRaSGg3c0Z3QXdRdWlrY0FPYmhQckhra2I5Y1p2?=
 =?iso-2022-jp?B?M1VFTjI4VGFsbktsRHkzUElBQ0JJNHNET1lvV25iNjJ5VStCTmNNNjA0?=
 =?iso-2022-jp?B?dFpxdVFGb0RKYjNCUUc3NXRCSjRHbnpMVitJQTh0RTVvdVF3Q3N2YitE?=
 =?iso-2022-jp?B?czY2NWFKc3FtMnNoSm5pSzlaNE5aWU5la1BueDVwbjdHNDZsZW16R2p6?=
 =?iso-2022-jp?B?R3BMb2RpTXgwdG1ZVEd6MTIzdnJ2QXBMNVZhejM4dEFDTjNpcVFISU9N?=
 =?iso-2022-jp?B?M3VWa1dDVC9GMmRJNVFydVJFS1RiK0FpR1VIM090WmlyejhxdEFaREc1?=
 =?iso-2022-jp?B?TStObjArTmdTSE10bm9JRGtZWWlCTGhiaEVtWGIrelhNYVJXNWE1eEU5?=
 =?iso-2022-jp?B?cEFaenhSSGhoY0FMSWE4UUdPV2Z2elBmTTh1TlM5ZVlsNEJHRDF1Z1N4?=
 =?iso-2022-jp?B?N21rWnB1MWdUWDBiQmR3SzBsNHJHSkRhZUNHR0J1aGlVMXg5bHFQSGwz?=
 =?iso-2022-jp?B?YVROQkZBS1FRaitidU0rMTF6b1pSWmM4dEdjZEI3YXI5clI4Nzd2YkZt?=
 =?iso-2022-jp?B?blY5V0xKM3B1WDV1d3dvZmxmMEYrWHdrbmJmeXRYNEwySFd6R25ZTXVO?=
 =?iso-2022-jp?B?cW1BVkJFY3RSUW8wMTRobnhOYXh2TnNCa2NzUnZUbFRmelhFdFByQzAv?=
 =?iso-2022-jp?B?KzVkaHAzNHNHTXRmOWhVcFNNZjI0ZWdseGwrdz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7993d00c-7738-4e20-3a53-08de5f13942f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 08:51:22.7812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nw335HAVIkY0G2kJVcDNsYIh3hyr1s/2JJ7upkKPTutNGklZUw1My86e1AGHg3mOW0SqluOlNSw7Nw0eFxi/c+pnkB+nIfNLGFKCzA4z4Io=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB15165
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[fujitsu.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[fujitsu.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18601-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fujitsu.com:email,fujitsu.com:dkim]
X-Rspamd-Queue-Id: 84945ADC4D
X-Rspamd-Action: no action

Signed-off-by: Seiichi Ikarashi <s.ikarashi@fujitsu.com>
---
 utils/statd/simulate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/statd/simulate.c b/utils/statd/simulate.c
index 4ed1468e..4ff21698 100644
--- a/utils/statd/simulate.c
+++ b/utils/statd/simulate.c
@@ -219,7 +219,7 @@ sim_sm_mon_1_svc (struct status *argp, struct svc_req *=
rqstp)
 {
   static char *result;
=20
-  xlog (D_GENERAL, "Recieved state %d for mon_name %s (opaque \"%s\")",
+  xlog (D_GENERAL, "Received state %d for mon_name %s (opaque \"%s\")",
 	   argp->state, argp->mon_name, argp->priv);
   svc_exit ();
   return ((void *)&result);
--=20
2.47.3


