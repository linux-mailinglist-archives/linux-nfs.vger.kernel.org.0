Return-Path: <linux-nfs+bounces-3358-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 152218CDB5E
	for <lists+linux-nfs@lfdr.de>; Thu, 23 May 2024 22:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73675B20DEE
	for <lists+linux-nfs@lfdr.de>; Thu, 23 May 2024 20:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0E481AD0;
	Thu, 23 May 2024 20:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="XeXT+Whr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2131.outbound.protection.outlook.com [40.107.93.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6398D17BAA;
	Thu, 23 May 2024 20:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716496243; cv=fail; b=ez3qtuy46AjqJHG+oe4DWqFkElgZxLAnqqbHgqRBdvgdSKfkecA9vsXa9bArzLFwqYMvxlKG7IRGDrQ7umvWzAS72pv3eTO84yhbR3EDVq19dj07gBoQp4RPA0SgisCOdMsuzCsG2kDlL9OnCXTHdgojKa7BVXEQPnrpV/ENupA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716496243; c=relaxed/simple;
	bh=MttgJQMYi7XpuumLPJCq+t3AbqJu7CPRZJmyo2EeY4Y=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eLfaTTGxGlweE68dpkcIcQtukOO/79ZK6Ca3P8ICl8f5k/1qX2xFcDq8NG+vCPeyF1hgIZU7b2F9GXoBJs9OvWgmRqcKeBfUSbx0W1qt99s6r1qsgHTfYMBigoNODQhRPGAbNyjb66VXRt8kzAXvjZ57WY9vL9a7jBdBlhMU6uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=XeXT+Whr; arc=fail smtp.client-ip=40.107.93.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/m37+52XoHGsygEP41SuJMrFIcsqhbguKU3IwAEwp/yiNl/pI8YIVEJwmqCXcgys6xyg6PVpXUOxyYhf5Q9owxlJRq1602iBpi2Ze82lOgvGV9e9t/v6/ituY1boTaDz2ueGvXGLw3O5g7lEX7Kwtyk9lb78UicZtJzL4ciO40VLUixP5mOQpWkKG1bLBFlghP/NvBE8cW8GdDpTq1jwtyLL67a8060duiV30xozdalFZAkDVOqa7PoEw9IvRuenMc6ZvR8d4qUWT8r3vl1O41IeenwWvjkhfBltpZSkkj0JDtwK3EI6UdR7vRsBhTJHek5sp/n8uzi7qqoVnxImA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MttgJQMYi7XpuumLPJCq+t3AbqJu7CPRZJmyo2EeY4Y=;
 b=F8Y6zPWafSBlT+XziJdAxnIDO9v8RLWghDZZr+zQtsgxhUvVC4rk+tTUVV2+PWnN+Oti0H3F4TeUcMzhlJGig/+7vLNvipfChXUG3iddmgndE9ZOyT4jL23OB6B++sUHp8az+FoJls7Gn1lVfVqyCbsyDazPZlHaOjWHkjdMo52MVy/lu5Ijdk03q8Zn/DNh4zfYr6WMdqJSdAOjfKGA3gf/zpcRmf7fPtp1/ExsppW+458eLG6uXwUfCjZNlCLvjnDHnM6/TfqenNglW4OBQutRo9QbQxHPndhMTw9i6RIv++GllJWJfxee18cJ8k1s8Mf+bPmOPl8Eymzc8go57g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MttgJQMYi7XpuumLPJCq+t3AbqJu7CPRZJmyo2EeY4Y=;
 b=XeXT+Whr2AJNw69X4qYPP53zlg+wnUXCWffLUDkAfQoaSJ8tw9vin92j+4iPQ9FZrUZUnIFRQZGBf1jpwysW21HaLn8Az4U6y9qEJviyt7Vg/UrKNM0CE6tsfyGEG21h9nvOvuJi3WSI4C2tyqUr2zD3xUXNZYzsTV5o8esShB0=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SJ2PR13MB6404.namprd13.prod.outlook.com (2603:10b6:a03:555::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.7; Thu, 23 May
 2024 20:30:36 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%6]) with mapi id 15.20.7633.001; Thu, 23 May 2024
 20:30:36 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull NFS client updates for 6.10
Thread-Topic: [GIT PULL] Please pull NFS client updates for 6.10
Thread-Index: AQHarVARqm682hcS4USFMxev/tj2Eg==
Date: Thu, 23 May 2024 20:30:36 +0000
Message-ID: <c1293d87d1e91d9986cb03c923f714560a0cc4d0.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SJ2PR13MB6404:EE_
x-ms-office365-filtering-correlation-id: 50d912b9-de48-4444-eb65-08dc7b6733ec
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?TXM0RmF1THV4dmZrY2dEdU9sNHFGcXNVWUoybkhOTHpEZDR0c3RQeDZVZnZ4?=
 =?utf-8?B?YUVQQlNveUNvcHJ1RU0xMjBIdlgzdDEyZndhZHdySU0rU2JNYjB2bnMwOW9u?=
 =?utf-8?B?Y2JOM3lPd0lNdzhkNXZtc1Mva0FLS0N0OXVDM0g2ZTdvRUlOVllBdFA4bzJQ?=
 =?utf-8?B?amxWU0JVTGdoT1hyMDk3VWJBanhTSG1ocm82RUlsZjlBd2JIS0JMdDkwcVQv?=
 =?utf-8?B?bmNvdm9KZkk5aWkyQnZZNFNORm5OU1pLS3Z4dmNtbTA0OGhZcC9Jd1BqRFdy?=
 =?utf-8?B?SGt5dWc5Ny82MjlHS2xreVFhYW1IS0k0aEpleXdlS2dXL3pSaGg4SEcrNnI2?=
 =?utf-8?B?OTZkOGE0M2VFTTJVS1pGWHNuSldsREdmOERpTFcvcVlicTkxS2dVWjg4eDZT?=
 =?utf-8?B?UjR4blU4ZUFMYUIzZkF2b0ptUkNueUgyZkNrSnA2ZTg1NjdrRmxXa1I4dnRS?=
 =?utf-8?B?cFdhbVVoRDYvcWRqQ1RLenB2ais4U1ZXMzcvckwwK21LOUx0REtKVmdEN2dO?=
 =?utf-8?B?cnl0ZG9MMTFEL1NnU0x1SitpQVdzQmxORVhYdHdUVWE1cmUzYmw0cVpTOXN4?=
 =?utf-8?B?SkJyN3dpN0pPeVhLb2FEVDR0eGcwbktrTy9aMnQyMDJ6ZERRSDhxcEpZMk94?=
 =?utf-8?B?NkhIU1phVG9LZk1UN0pvTWpPbW9qS0ZaUXkzMlVkUXhXN1hNbzBESXIxUE9W?=
 =?utf-8?B?YVZ0TTNQU3NVR0trUFlSdkhoL0lPTDA0d2hTM2VkaERxamcvYnAvNVphUDFI?=
 =?utf-8?B?ZU9kbzFRZnN1aCtXMWNMY1VIemRza0dlQWlLQTREYWwxMHBLdlhqSmFOcWMw?=
 =?utf-8?B?elkzMFJJOXpwMUlYcE5KaE00djhIZzBZZE5ERzlmeWNMTmRSNWxyV21uZko5?=
 =?utf-8?B?Zy9XL0RaYmVCOU5YVitNR1B6VjdBd3ZZNzFOOWhISjYwVHVMUnh0UEhjRm1x?=
 =?utf-8?B?aGJ3angzaExEWDNFTmVXM2lIbFkvc2l1aVhZcERUeU9UUUM2aWZXc00xajFT?=
 =?utf-8?B?MnIxM2F1ZW1lY0NwVlFVSGdwOFBOUGxibjAwQXU3enRnWk1TcThvSWhONS9H?=
 =?utf-8?B?Tk5iYzh3SXExWlo5V09heDhsaTJXSEJDVVhVcHR5RFNKR0lwQ0o2cHdLSTlv?=
 =?utf-8?B?T2JDUW4ycEd3TWdxZUdwSlllankvR2dVbE1pTzlwNm4raUFmcExJSERqcUNC?=
 =?utf-8?B?aVJWVGx4M2ViQzNsdFFnYzIyREhtU2FTbDFJNzlkSkNadnZSeFNPU3o0MjZY?=
 =?utf-8?B?dlJhVkRQMlhVeVQ4RjVwYUVmTVcycm9vVHJNTUZXVUFyQlgxTG1HNFhNOHBY?=
 =?utf-8?B?Vkd5OElxNnhzcVRqZ3NjTXZTcHZlelBxb0x3S2w0bmVvaDhEV0lRSnNWWWxS?=
 =?utf-8?B?Z0V0Q3phSFFDbHF4d0lJWTZ3MXhhN1hwV2VjdFBzTE44a3FVZThseDFadVFH?=
 =?utf-8?B?cU1qU0NqTXJ1cXRnZzRyb2l0eXdhSkRYL2ttRmx5bE9yZFBubzJKbzZhVWdF?=
 =?utf-8?B?UEpzVmd6dG92d01jdDZvcVRreTE5Nlk2U1pzMkFaditndlJxNVAxZ3pJUEdj?=
 =?utf-8?B?ak9LZlU5UDRLcmxvalJ4UTQ3MWtPL21BdUozMzZ2a1dnMkpsZHp3aG9hL3dQ?=
 =?utf-8?B?aWw5KzcxUjYwVmd5Q3N2d2txWGlkMXlMM3NFdjVlemxZUmpQd2FCdCt3TVNw?=
 =?utf-8?B?NXZ3a0QxajY1VGE5S2pjSDVFbzRaOCtCRXY2RWIza0RzR0N4SnViSm1xbmpJ?=
 =?utf-8?B?RHIrRTV0cWZlNjFpMnh2bEQ1T3k0QnlUWkZGQy9XM3BEMytlckowU0FWL0JE?=
 =?utf-8?B?UDNGSW4zckRTR3Z4OFJ0dz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T0VSbUIydW9BZ1ErWndsa0xvUDhLcFBWejNnZTBJV1VNVzV2WXZlZlNvMEtT?=
 =?utf-8?B?dDZXalF1WlR2dVJheTlMa3NBTTR1bTNJVjU2OWNrZ3RYSGNFRGMwRUVhZ3FB?=
 =?utf-8?B?WTZ4TmtvRXQxUFJmbzllYUFyZUVDRkp3SjEzT0gzcVpnRjZMOWxCYmRyczlr?=
 =?utf-8?B?Qmhqb2JYSVo4aGFObTVNdzgrb09kQktIK1p6bUNmTTZlS2hCeTVPdVFiQ0xo?=
 =?utf-8?B?WndNdzdpNXc4ZllRRnBBNHlGR24xNnFGRWxreW5nb083aVQ4RHRpNEJlZGlm?=
 =?utf-8?B?dEZZSmdJT2hmVnp2Rm16S0djdWp0WUt4WVdUTzE0VHhnK3BGays2VVFrdDdB?=
 =?utf-8?B?ZFhuZnFxTlZHVW4wUUpNT0VIM3BxWk5pNlVYV0tneW90YloxZUZIQ0g2WkNK?=
 =?utf-8?B?NVZTdzQ0VUF0c0VKdTdEMmh5Q1RDZE9PZXFXUzZaZGgwZW5Dclg5aGJHdkF2?=
 =?utf-8?B?Rjd6eStQVXJjMUZIQmh2S21xZ1JqWnhXVFhDeUdOMU1YcUpmbERLVkZoc25i?=
 =?utf-8?B?c0pOVWh6UFBPSkpDNUI2Q2hadkJ6ZnI0b0NVb3dKQmNmZWdjRzh5NXMyaVF4?=
 =?utf-8?B?OWhQc2Q1dS9Xb1Q5Rit4ZytKZnFvTzNzQlNwcGFpMHU5ZjY5dDdhakJDVy9p?=
 =?utf-8?B?U2pOL0RicVVDdmJlTGtFWWl3aTQ2cXNuMVpGRVZPaG9QdVlVSEp4Y3NhMStv?=
 =?utf-8?B?ZW9Qcmw5TDZpdncwZEpMUldTNGd2YzJlenQrUWIzRCtKeHNmUXQzY0dHQitG?=
 =?utf-8?B?MFNrdzd0QXBEZ3NwMDJqSFBFU0p2bThsUGJMdG4zbS9seXZCMk9HS041ZGdE?=
 =?utf-8?B?TjZRQUxsRWpqaXdrQXdxeCtFNU5NN2NGays5Z3dybGp5T1JHQXUzbTV4K2F6?=
 =?utf-8?B?ckxLMnlWa3RLVW5aZVZKOFlKUkFVeU1HQU9hWWVLMlhFQTdCd1pFTFJvTDJs?=
 =?utf-8?B?SlJIMXVOeXlac2hzTWU1M2lBSTRDbGRMOVFxWERkVFJQekJ6UjhCUWtoSFA1?=
 =?utf-8?B?MXQ1N29yeTQ2MThQWngvMmc2NllsMWRTdmFvcDNuRnhJVTFNWjBPQUV0N1hE?=
 =?utf-8?B?cXJjV0pOTE9JWnVWcmVBR2xWdGthRktPNzFKdW5FVVdkN1o4VjlCaDVjakl6?=
 =?utf-8?B?NU1BUXJ4TUc3NTdwUXJ3Y3YydlpIT0RGcEs1OVJyOFYvSEJqbmRuWHhQejVV?=
 =?utf-8?B?ODkyeUE4dVNoYjduRXovcUlscFZrOHIvQ2hSRmkvVEdrV1lGRjdqWHJWS3hP?=
 =?utf-8?B?akx3TWx5NU9NY1FQeHAzSlkyS1N1elpLSUF3UWFxMmRrQVpQS0tqcGk2QVBM?=
 =?utf-8?B?aTRvU0lxejJoT3hVb2ZXWEorc1IzWGRBMDU1U3h1Wno1dmErOHhxV0hwTmNp?=
 =?utf-8?B?V1NRbldWS20xQmVRZDZZZ1ZVVkwyVlBONE1iQVlBdG9yL2lQcmQwamliSk13?=
 =?utf-8?B?Z1pEV21ZcTZzZCtzeUliaUpwU1duYXV5ajMwQXpWQWxrNGZ1YU1RbG81aHB1?=
 =?utf-8?B?eTUweXNGRGVYWEljQlhsZjVPNzI5ZXhBTHgraTZLNUM4bXRXTlk3QWVMMnk4?=
 =?utf-8?B?T2RxR3ZsQlZCK0twVHpZS2tzeFRCTG9LQ2dBR1NKRXdORGl4ZWhhblNjRHd6?=
 =?utf-8?B?Sk82WXV3UnVNMGhXdDA2bWlWblF1M240QWNXVUhhRDk3RGtYdWtzaERZOEhC?=
 =?utf-8?B?WStINnI3T3BDWkpjbGc1YnA1NDFWNUJRWWpoUEVrdTNmL29RaW9GaVV4RjVl?=
 =?utf-8?B?N2cwQnBJZEVFQ3BtTzZ1WCtlQWMvMFJRMlVEMDJoUTNMWUpyK2Nmazl2VnVs?=
 =?utf-8?B?dkc1TVU3OGo1bzN4Uk5pSHUzWGRzeGRZUlpuVkd4MXN4bHRpMm5COWsrcFNv?=
 =?utf-8?B?d3hsS05kc0l6WWM2TjhFd2NVVHBMTlQ5VHB4NFpKbFNMNTcyM2lYVys4bGhi?=
 =?utf-8?B?RSsyTThUc0c5TVFPZFRtSEloZmc5Rm9UekQyUHRKSVJIYVdBd1RxRkZKMnpB?=
 =?utf-8?B?dmJqTXE1QThyZDc1UVdyR3UreENiT25NSmtIL3ppUWMxazFpdytDdkNBOWJm?=
 =?utf-8?B?dnBlZWZHa2F4V0RUUnk5ZlZ1Qit4Y3FMa25oMWZWbmt3R0tHVkVjeStEb2g1?=
 =?utf-8?B?UDk3ZUNyL0wzYlEzdWJETDhBVVJRa2tuOVBBcVo5enBzK21aUUVOeVFQZDlZ?=
 =?utf-8?B?YzBFVGxxeDRKSjJoc014M2JFcHIwZjJBOWVWeUFpTW5qZ0tYQTJ3b091QjNo?=
 =?utf-8?B?dEQ0T092WHpscCs0dWxvamlabW5BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F962BD2EE52244EA5C6B3418BEA3E95@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d912b9-de48-4444-eb65-08dc7b6733ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 20:30:36.2262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QGZGHwYwfzN4cQDN5VVzNLatmec5Vs07eV8MlHggNFtn2cYP3ihQoCezGmto1EqLuVKMpsFA5iqE6tkj7O7r0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR13MB6404

SGkgTGludXMsDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgYTM4Mjk3ZTNm
YjAxMmRkZmE3Y2UwMzIxYTdlNWE4ZGFlYjE4NzJiNjoNCg0KICBMaW51eCA2LjkgKDIwMjQtMDUt
MTIgMTQ6MTI6MjkgLTA3MDApDQoNCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5
IGF0Og0KDQogIGdpdDovL2dpdC5saW51eC1uZnMub3JnL3Byb2plY3RzL3Ryb25kbXkvbGludXgt
bmZzLmdpdCB0YWdzL25mcy1mb3ItNi4xMC0xDQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1
cCB0byAzYzBhMmUwYjBhZTY2MTQ1N2M4NTA1ZmVjYzdiZTU1MDFhYTdhNzE1Og0KDQogIG5mczog
Zml4IHVuZGVmaW5lZCBiZWhhdmlvciBpbiBuZnNfYmxvY2tfYml0cygpICgyMDI0LTA1LTIxIDA4
OjM0OjE1IC0wNDAwKQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpORlMgY2xpZW50IHVwZGF0ZXMgZm9yIExpbnV4IDYu
MTANCg0KSGlnaGxpZ2h0cyBpbmNsdWRlOg0KDQpTdGFibGUgZml4ZXM6DQotIG5mczogZml4IHVu
ZGVmaW5lZCBiZWhhdmlvciBpbiBuZnNfYmxvY2tfYml0cygpDQotIE5GU3Y0LjI6IEZpeCBSRUFE
X1BMVVMgd2hlbiBzZXJ2ZXIgZG9lc24ndCBzdXBwb3J0IE9QX1JFQURfUExVUw0KDQpCdWdmaXhl
czoNCi0gRml4IG1peGluZyBvZiB0aGUgbG9jay9ub2xvY2sgYW5kIGxvY2FsX2xvY2sgbW91bnQg
b3B0aW9ucw0KLSBORlN2NDogRml4dXAgc21hdGNoIHdhcm5pbmcgZm9yIGFtYmlndW91cyByZXR1
cm4NCi0gTkZTdjM6IEZpeCByZW1vdW50IHdoZW4gdXNpbmcgdGhlIGxlZ2FjeSBiaW5hcnkgbW91
bnQgYXBpDQotIFNVTlJQQzogRml4IHRoZSBoYW5kbGluZyBvZiBleHBpcmVkIFJQQ1NFQ19HU1Mg
Y29udGV4dHMNCi0gU1VOUlBDOiBmaXggdGhlIE5GU0FDTCBSUEMgcmV0cmllcyB3aGVuIHNvZnQg
bW91bnRzIGFyZSBlbmFibGVkDQotIHJwY3JkbWE6IGZpeCBoYW5kbGluZyBmb3IgUkRNQV9DTV9F
VkVOVF9ERVZJQ0VfUkVNT1ZBTA0KDQpGZWF0dXJlcyBhbmQgY2xlYW51cHM6DQotIE5GU3YzOiBV
c2UgdGhlIGF0b21pY19vcGVuIEFQSSB0byBmaXggb3BlbihPX0NSRUFUfE9fVFJVTkMpDQotIHBO
RlMvZmlsZWxheW91dDogUyBsYXlvdXQgc2VnbWVudCByYW5nZSBpbiBMQVlPVVRHRVQNCi0gcE5G
UzogcmV3b3JrIHBuZnNfZ2VuZXJpY19wZ19jaGVja19sYXlvdXQgdG8gY2hlY2sgSU8gcmFuZ2UN
Ci0gTkZTdjI6IFR1cm4gb2ZmIGVuYWJsaW5nIG9mIE5GUyB2MiBieSBkZWZhdWx0DQoNCi0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCkFubmEgU2NodW1ha2VyICg0KToNCiAgICAgIHBORlMvZmlsZWxheW91dDogUmVtb3ZlIHRo
ZSB3aG9sZSBmaWxlIGxheW91dCByZXF1aXJlbWVudA0KICAgICAgcE5GUy9maWxlbGF5b3V0OiBT
cGVjaWZ5IHRoZSBsYXlvdXQgc2VnbWVudCByYW5nZSBpbiBMQVlPVVRHRVQNCiAgICAgIE5GUzog
Rml4IFJFQURfUExVUyB3aGVuIHNlcnZlciBkb2Vzbid0IHN1cHBvcnQgT1BfUkVBRF9QTFVTDQog
ICAgICBORlM6IERvbid0IGVuYWJsZSBORlMgdjIgYnkgZGVmYXVsdA0KDQpCZW5qYW1pbiBDb2Rk
aW5ndG9uICgxKToNCiAgICAgIE5GU3Y0OiBGaXh1cCBzbWF0Y2ggd2FybmluZyBmb3IgYW1iaWd1
b3VzIHJldHVybg0KDQpDaGVuIEhhbnhpYW8gKDEpOg0KICAgICAgTkZTOiBtYWtlIHN1cmUgbG9j
ay9ub2xvY2sgb3ZlcnJpZGluZyBsb2NhbF9sb2NrIG1vdW50IG9wdGlvbg0KDQpEYW4gQWxvbmkg
KDIpOg0KICAgICAgc3VucnBjOiBmaXggTkZTQUNMIFJQQyByZXRyeSBvbiBzb2Z0IG1vdW50DQog
ICAgICBycGNyZG1hOiBmaXggaGFuZGxpbmcgZm9yIFJETUFfQ01fRVZFTlRfREVWSUNFX1JFTU9W
QUwNCg0KTWFydGluIEthaXNlciAoMSk6DQogICAgICBuZnM6IGtlZXAgc2VydmVyIGluZm8gZm9y
IHJlbW91bnRzDQoNCk5laWxCcm93biAoMSk6DQogICAgICBORlM6IGFkZCBhdG9taWNfb3BlbiBm
b3IgTkZTdjMgdG8gaGFuZGxlIE9fVFJVTkMgY29ycmVjdGx5Lg0KDQpPbGdhIEtvcm5pZXZza2Fp
YSAoNCk6DQogICAgICBTVU5SUEM6IGZpeCBoYW5kbGluZyBleHBpcmVkIEdTUyBjb250ZXh0DQog
ICAgICBwTkZTL2ZpbGVsYXlvdXQ6IGZpeHVwIHBOZnMgYWxsb2NhdGlvbiBtb2Rlcw0KICAgICAg
cE5GUy9maWxlbGF5b3V0OiBjaGVjayBsYXlvdXQgc2VnbWVudCByYW5nZQ0KICAgICAgcE5GUzog
cmV3b3JrIHBuZnNfZ2VuZXJpY19wZ19jaGVja19sYXlvdXQgdG8gY2hlY2sgSU8gcmFuZ2UNCg0K
U2VyZ2V5IFNodHlseW92ICgxKToNCiAgICAgIG5mczogZml4IHVuZGVmaW5lZCBiZWhhdmlvciBp
biBuZnNfYmxvY2tfYml0cygpDQoNCiBmcy9uZnMvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICA0ICstLQ0KIGZzL25mcy9kaXIuYyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
NTQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQ0KIGZzL25mcy9maWxlbGF5b3V0
L2ZpbGVsYXlvdXQuYyAgICAgICAgIHwgMjQgKysrKystLS0tLS0tLS0tDQogZnMvbmZzL2ZsZXhm
aWxlbGF5b3V0L2ZsZXhmaWxlbGF5b3V0LmMgfCAxMiArKy0tLS0tLQ0KIGZzL25mcy9mc19jb250
ZXh0LmMgICAgICAgICAgICAgICAgICAgIHwgMTEgKysrKystLQ0KIGZzL25mcy9pbnRlcm5hbC5o
ICAgICAgICAgICAgICAgICAgICAgIHwgMTEgKysrKystLQ0KIGZzL25mcy9uZnMzcHJvYy5jICAg
ICAgICAgICAgICAgICAgICAgIHwgIDEgKw0KIGZzL25mcy9uZnM0cHJvYy5jICAgICAgICAgICAg
ICAgICAgICAgIHwgIDIgKy0NCiBmcy9uZnMvbmZzNHN0YXRlLmMgICAgICAgICAgICAgICAgICAg
ICB8IDEyICsrKystLS0tDQogZnMvbmZzL3BuZnMuYyAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAyOSArKysrKystLS0tLS0tLS0tLS0NCiBmcy9uZnMvcG5mcy5oICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAzICstDQogZnMvbmZzL3Byb2MuYyAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAgMSArDQogZnMvbmZzL3N1cGVyLmMgICAgICAgICAgICAgICAgICAgICAgICAgfCAxMCArKysr
KysrDQogaW5jbHVkZS9saW51eC9uZnNfZnMuaCAgICAgICAgICAgICAgICAgfCAgMyArKw0KIG5l
dC9zdW5ycGMvY2xudC5jICAgICAgICAgICAgICAgICAgICAgIHwgMTQgKysrKysrKystDQogbmV0
L3N1bnJwYy94cHJ0cmRtYS92ZXJicy5jICAgICAgICAgICAgfCAgNiArKystDQogMTYgZmlsZXMg
Y2hhbmdlZCwgMTI5IGluc2VydGlvbnMoKyksIDY4IGRlbGV0aW9ucygtKQ0KDQotLSANClRyb25k
IE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJv
bmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

