Return-Path: <linux-nfs+bounces-11387-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1141AA7634
	for <lists+linux-nfs@lfdr.de>; Fri,  2 May 2025 17:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 411B4189731C
	for <lists+linux-nfs@lfdr.de>; Fri,  2 May 2025 15:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E191B1991B8;
	Fri,  2 May 2025 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="hASVs7Ls"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2128.outbound.protection.outlook.com [40.107.93.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA7F23B0
	for <linux-nfs@vger.kernel.org>; Fri,  2 May 2025 15:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746200353; cv=fail; b=MeHn+QMjXoYu4oScaQAYtiO+ZMcXgUoHbwcr2/iaN53Q+7jpY7VJCELl9yWHRRIeFN1YPPXRHvY5SUKXQcadY8x3lF2GZ3raqQ2Qw0kRyRbank8RZ6cSCHwBk/EhUkMcTC1lp8C4/m+RUWjJURUTFZALHrOcL7/5fG9KWu9xAJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746200353; c=relaxed/simple;
	bh=SkstU8AOr0/9lkNH65ZhdBmXw0SPYf75E4Vdd4Tume8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tUOKZdJQxlCavZqDobUaNwHYpmilPhEXnonmrAEH8grgpE1by6eqf1CQJO1ieim6+AuaS9lienudu0DCp132DxVwqeb95zVWyURCqlQZD5MhFmkAq7LBRf3LHuCmqVxx7hAy6313d3N7fvLV/9nrU9FDZw1gA7jp815JAyPpIcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=hASVs7Ls; arc=fail smtp.client-ip=40.107.93.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBJpllwN46bh7Vt2s2ThCl7FdkdZZ+WEhHxwO3csuLQ84w3oeyFL5EHKSWIvUN4UAPbqfBTRi3avurvYnTbuw17jdKkk3gmFK4PgZTxsbK2VlCv7uR+X5BPRwuTQ9h+Ke84elRpSDsH2n3+5xu32zPeSChyaGci8Z9e1aRP6JVUMvGI2+mKFMnkXHkiovuzC8zYbjThz692EGm/xqb7g1+UnqZEF2MNYE8kwmo5CGgAhp7HVey/gL+pngj4Gtd2VHq06S0e2KAyReBzXme6ll3a4DlSSB5RLvF9hlwtesFdFh1AxJ9f0ZysQlHS+PUVQsWVCjDegcH2nCBggJCCaAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkstU8AOr0/9lkNH65ZhdBmXw0SPYf75E4Vdd4Tume8=;
 b=mysQitV3TR5w4r04Liz6dUv1h+6VjXXiKQzUFLgZqvMtinYk7CFqEiR0DsDok5yh0Ou+M7ttYoUyjj8fA7iOUTQPAjwgYoe42v+0bP9HbiIr1r8F+HDmELxBC7hbhuNv7Ii1bzIKsBhTFVMDPh9/k5FC3UD70wKBTtHqltgwikht3jfbs685SQpMu0KJ+gDRApBLRMugsj2i7mwHmqIpf5dqEP5FTcne+SsCRYezqxH1pzScm6ScaQrtYNA15PviZ8kzBm10vKlXpT2Z/DtglbQqlENcWCpLOaIzJsyBayfzpOoomo9O6AcDdBdl7ebaJmLWFh3zps8pT+irEi2wxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkstU8AOr0/9lkNH65ZhdBmXw0SPYf75E4Vdd4Tume8=;
 b=hASVs7LspBK/1mpfpBVL7Gma7F21S55D+tDACvd4+L2qD2fkigwEZTiZ5FTLTeo+csWc98BjiZKPKf03IBOk0pO2dss+J9do6+D5Si45RbUY8LL4LiitF0WUNhcJX8W8kRFffgPyCa9KSBjaxKVNsOZ4plMqSvzJx3O8TMYk/uo=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DS7PR13MB4624.namprd13.prod.outlook.com (2603:10b6:5:3ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Fri, 2 May
 2025 15:39:08 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%4]) with mapi id 15.20.8699.022; Fri, 2 May 2025
 15:39:07 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "hanyang.tony@bytedance.com" <hanyang.tony@bytedance.com>,
	"anna@kernel.org" <anna@kernel.org>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFSv4: Always set NLINK even if the server doesn't
 support it
Thread-Topic: [PATCH] NFSv4: Always set NLINK even if the server doesn't
 support it
Thread-Index: AQHbu3Us8LDV0rNBRkmI82KyupNm9rO/ecIA
Date: Fri, 2 May 2025 15:39:07 +0000
Message-ID: <ed524dd7e4e20acef750c63e671407c3dc386c12.camel@hammerspace.com>
References: <20250502151544.76653-1-hanyang.tony@bytedance.com>
In-Reply-To: <20250502151544.76653-1-hanyang.tony@bytedance.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|DS7PR13MB4624:EE_
x-ms-office365-filtering-correlation-id: 0595768c-8ac4-4cad-6130-08dd898f79f8
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?US9lRnpaTUV5dWM1SVlqS0hnaCtNak1KNDJBanpDYmtTUkZFckgwcG13dEhk?=
 =?utf-8?B?Tk1STHpxcnBLWlFOZXIyQlI5SytEbFBIdGxCRzFJdHZLKytnUHFaL2pVN2Nv?=
 =?utf-8?B?a2k5WW5rNElSY1VjZ3ZOSlYvT3k3VEsxcmRVVmpnZXZBMndEeWEyd3dGSmVa?=
 =?utf-8?B?bmtkWjdjVmluWThVWWhOdGFRK3RtalN5MUlrcnVoYjJUYjFXQjdUd0hCcVJh?=
 =?utf-8?B?OXE4eWFvUWFmSlVHT3Mrd1JZaTN2MWlDL2QyQVdmYVo2M3Zuckt4dm94Snl2?=
 =?utf-8?B?ZExXeWlDeVVZMTVQeW00d2NGSXRUUm05dFVXVy9IMEt2WVpObWI1TGZibGJj?=
 =?utf-8?B?SGw4a0l1SG5tZSsxTFBSTGxMdmhZemc4RHZiUkZPakt3Sml3dWlVemxNakx0?=
 =?utf-8?B?L0d0eE1LR1ZENjc5dUdjOG5Rc0hoamt3cnQxdDN0ZHpmRmxMOEFrWnV4RVZy?=
 =?utf-8?B?aExQR21nTkZQM1lwY2Y4Qk9VeS9NVEF1RGNKY01rVkFyTGs0SE95UUh5cXZN?=
 =?utf-8?B?eTBZQXRVMUErNXVSblVkWnBISTA0WCtWZE80WXZmV2ZFUzE1QkZsN2UzbjF5?=
 =?utf-8?B?Ym1tUktaT2xTai93WlhLUCswVHdmK25SVkZ4QllPYjBmUG91b1RNbHNjZlhy?=
 =?utf-8?B?S01wTUtuS1NxYWJXRkxySlhRNzI3TG1DS1NIQm1ZWXgydVJ2T1JwcVBxRXBX?=
 =?utf-8?B?cUhsT3E3a2FieXYvK0RiVmVCNlZiOU1nSEZ5T3VGQUhmRk5weFRtVXpKaUhT?=
 =?utf-8?B?L0FVdXRibTdVb1JFdCtvREY3SzdjcEhZRzhmWUR0TzNSZ0wrVGNtNmxQQTc1?=
 =?utf-8?B?S2VRcG54K3p2bXJZRS8xNVNwQVNTaUdySXhvYTdJZ253cDQvcm5ZSHpMd1BB?=
 =?utf-8?B?cjdndXNhS0RiV0RyTHh6blJScUJSYXJBUEJHWm1FRXZHMXRmNFN4SHBmdEw0?=
 =?utf-8?B?Sk94WVZSeGFVUjFJVVk0eEtyU3hFSHRxdERqZWNyeWwrb2dySDMxNXVMR3kv?=
 =?utf-8?B?QnNsMDZ1UTI4cXFBY0JNWTl4L3NCSTZWUW5qRStrTnB0UGNoc25laWpzRGYx?=
 =?utf-8?B?cHYwOG1MS0VjNTFkMU84OWpjSnF1ZU1ENHBxWmxDeGhGVFpUOFk4dnZIQ0hF?=
 =?utf-8?B?MWZuOUxQUFZuTzhMRldjT2VzbTZiWU1XOUdTMXFvL2FvWTZwRVJ1dUo3RWlQ?=
 =?utf-8?B?ZkFXZWF5RHJMVGhtMjVMem5GTCtMb1BVeWJMWmEvL1NqK2RnWjVFWmZRWjRy?=
 =?utf-8?B?MU5yYnZraW9GQjk4Wm9TN2NiR1ZPZ2dHak1PQzB3a25pZ0U5Vnp4azcvbXBu?=
 =?utf-8?B?cnd4VlRoOXBOL3o5U1ozSnplcDJ0cHNsR1VYZGlYT0l2REd2ZUVmUmdzTzhN?=
 =?utf-8?B?R0NaNEovL3E2cHNWVEI3Qk15STVnTEVuaFU1cENSWHdublM1aWhzVDFBVisr?=
 =?utf-8?B?YUFqWGp0c0krZkR4bkN1VGNySXJ0b3JxVTFYd2h1TFJyZXhPemVJWXN2Q3VX?=
 =?utf-8?B?ZFBYeVRkS2o3dEFWV0NnQkNlVlNXNWhoY0lhZVFWcklkR3FRdGZseXdMUW41?=
 =?utf-8?B?V1RxSWVRVkhjVGl1dGV3U28zcCtheXNYcjNRRmVBZkpYV2kwYlhVTzl6clR4?=
 =?utf-8?B?SlNJaktub1ZHb2ZnYzkvVVlscVFQaXZQd0pybEJXU3g1Zlo2RVdxTWNhNC9r?=
 =?utf-8?B?azdQQjY1UE1tVkd0UUdXN1lybjZ4Uk4rTVkxeStkWGJRdkVkZU9SUC81Ujl6?=
 =?utf-8?B?YlYxUXQyUEEvQlRUNXZKbnpHRFVSL1lOUnJyUlA2N2g1MVdOSGY3ejhqby9N?=
 =?utf-8?B?aCtsSWV6REx0Q0tmWk8zTjdBRndRK1pJREhtOGJOeTh2QUZOYXZKOXJGRkN1?=
 =?utf-8?B?dHNzNDFGY0lCSUZmbTM5ck1td3VKU1ZZRmFaQlRyWm9OUnlpakNUUmZVU3pZ?=
 =?utf-8?B?WWFBdDVSUDdEMysvOEpRaTgxRGdMVm5FQ0JhWFRmMlRxWTJxbUtsUWQrdGFW?=
 =?utf-8?B?SFJ0UWljbUVRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VFJxaTFmeVpYVWNWMFByek5kYmxWY1U0czloSWJibnczbzdWT3VjWldsd2pH?=
 =?utf-8?B?UjlOZ0NOOTFlSFdxdkt2UGdJL0VYWGsrWE5mMm9qeS9KM3NsZUMyM2tOWU95?=
 =?utf-8?B?ZEFvdHRkU3N6WFRRK002OEtWbFlxeFNUNHF2eHpLcG42WS9VblR1ZjhzSVBk?=
 =?utf-8?B?ZDNCRDcyanpSSGhaTEVBaGhuUW9PK2YrZ1dXRjZuL1drUEVnd2RTSmhBOTJZ?=
 =?utf-8?B?MHEyNE9FcUtQMnYvZUZZWHJWZ1lnWDQyYVZXTnRXREY5Z3RiSHJrOXUvdy9H?=
 =?utf-8?B?N1R3RSt6T1BRS3pOdEJPOXhZcHdnR1FWSHkzMnNieHg4WDY5SGEycG9yVXRx?=
 =?utf-8?B?dm5zZWtpaXlnM3dxVENuTkplaStkWjhCUng1N1lzNlgvOVB4K1QvK2pkZFFF?=
 =?utf-8?B?NDVDU1V6WFJCWFoyQklHNUJZUG9tZ2N0cXVib0d2L1BVRTdLemhMSm03QitW?=
 =?utf-8?B?UmNxK0dwYWxadGJlaXJVMFUwMUlqVHZxL1RYdWVrYlFvcXZSNjQ5R1Eybi9j?=
 =?utf-8?B?MEV5dmdTQmQ0ZWxZd0hOb2YwSnBFOWUwU1lCRnJocStLMnhEUHNxNURLVEpC?=
 =?utf-8?B?cTFpVlR4Z2wzZFFHOFpkb0dCSSszMlBPNTJKVk9jczNaQ0lBYTlPRm1LQWlj?=
 =?utf-8?B?TmdzdjUzOFNROGw1V3RHSHkvcWsybjlObjM3NFVnREF4UlhDeStSNldQUmI0?=
 =?utf-8?B?MFdNL1V0QnBYRjQrUE1SS0ZWcncyMzEvMi9hZSs1ZVJqTExmdDhmZVZOVXg3?=
 =?utf-8?B?UkVNRlpodWhoa0xidFN4dUxGQjdERVl1WXF4dlpHaWowM0lPSExBZ3dsWmt5?=
 =?utf-8?B?Ty9IampDeHdMcEhuN2wzSUpaZldXanJiUDNCT0lzL2MzRmRVeGVKTEUvM2dR?=
 =?utf-8?B?WTYvZDRldnFwbTdjYWtPM3gvTzdBbmZ4aElsYnZRNGhnTVNVZnYyNmF6djIy?=
 =?utf-8?B?dm5JNWh2NVV2am1Sb1VKOEZoSGI1bHpveDNMUjJRRXo3eTE0NkRiYXVEN3Yz?=
 =?utf-8?B?L2xPTStHSHR5dmVwWVMxaXRWZHR2Wnl4anIvR1RzRE5iNHZwSU9PRFhNQmZJ?=
 =?utf-8?B?eGkxbUZCaWtRamFjOU9RSDExaHpGclI4bGU1QU5pOGxvU1FrOExvcWU3K24w?=
 =?utf-8?B?WXFJdWRGV2VaMWdDYUdtRDBQR21sK1gzZkhSdHJUY1QwWnhpMmVZTDBrUUQv?=
 =?utf-8?B?azdYa3R3SFFFMTFUZ1pYRi9uc0RzaFA2OTFrNmFMY2lIWkFMRWc2SDZXM2Ji?=
 =?utf-8?B?b3Zsa1g3c25Na2M1WVR5ZUtMWTV4TTF1UWdsQUk5b0dIYmsrN0N0YkhJU3pX?=
 =?utf-8?B?RTA5UytPczZqNDdueGt2RWVPUEd6UG9pd2x1TVo1Y2RuV2JaUy9HVGpOT3k3?=
 =?utf-8?B?V2tyc1V2WFJacnlhR0pNMDk2RTRnajZqbTRFcjlLMWZGMUowbnNHNEh3OE5r?=
 =?utf-8?B?dVRwTnJZdHhjQXAzejlLbkIvQmFlMHlPKzBjN25ud1YrbDRDV1F6UEQxMEEz?=
 =?utf-8?B?M0doR0RVMWlnNWg5RGdrb2I0NGYwNWp0eC8zMTdTOFFXTDQyYzhYQ0ZrNzBo?=
 =?utf-8?B?TUpYZmFLcHAyYUtVaTFCcFBtZUNZQW92WTl4N0RMUWR6VWIwVUJRb3hGSi8z?=
 =?utf-8?B?MHBNQ1ZwZVNRL3NDb21Ba3RmMktiRHhtb0oxTTE4K1ZZbExMeGt6Q05XWVky?=
 =?utf-8?B?NUJsd013OXBWN3hrbTJEd3oyMmdFNEpaWEtxSm9qcnB6QThxV3FzNUpyVDda?=
 =?utf-8?B?ckF3TEMxSXA5ZWg5U2lhSnZCSGNDNFFOR2lBVzFheG52NFU0QjhPWTVEVlRL?=
 =?utf-8?B?VmZ3T3A5SUVzZnJiN1RhUDVCY0lwZDhzaGRVVEZDRTlGeTVuamFzZDFuczRo?=
 =?utf-8?B?cFJYbThhcDR2QXF3cTlrRHFUbVhubHhvYyt2bEJCWjNZWHVFK1BNRUJFT1JW?=
 =?utf-8?B?VlY1dkFjRi83bE5SSm1FeDV1QlBLMXF6elpobXhvcWJMWkxsV0puTHVxTHQz?=
 =?utf-8?B?czd6S2FjNTRBdExjRTUvOE1aYkR5VlhLRHE5MzNrN1N4cWVEaUptMmNiM1gy?=
 =?utf-8?B?VDBLamlUWkRtdnpReUhoNC9tSFY4M0taL3d0L3cyNFU5WFRQWWdnYWNlcWJ2?=
 =?utf-8?B?RHE5WWZDemprMGg5UW4wckZyRVpGV3EzODJONktETmFtRWt4TXNicWFPOVZn?=
 =?utf-8?B?OVlHakd2OFlDQmhmOHRSSzVhWUFtNE5qVFJxeGY4bjd6ZU1tVXB6b0JtN2g0?=
 =?utf-8?B?ZUhzdFVHYkhuUHh2LzBwWlJhUk5nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D08BC997EEA2048BD61BC79104898E1@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0595768c-8ac4-4cad-6130-08dd898f79f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2025 15:39:07.6096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ufPkF0BObeNcUXiGgmHS5vd2Sae4PBkTU8wuFh4OS2K1wV3Fg9VQu7rOQIVAzwO/I/+S4KWHcOgH6R9COAtrUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR13MB4624

T24gRnJpLCAyMDI1LTA1LTAyIGF0IDIzOjE1ICswODAwLCBIYW4gWW91bmcgd3JvdGU6DQo+IGZh
dHRyNF9udW1saW5rcyBpcyBhIHJlY29tbWVuZGVkIGF0dHJpYnV0ZSwgc28gdGhlIGNsaWVudCBz
aG91bGQNCj4gZW11bGF0ZQ0KPiBpdCBldmVuIGlmIHRoZSBzZXJ2ZXIgZG9lc24ndCBzdXBwb3J0
IGl0LiBJbiBkZWNvZGVfYXR0cl9ubGluaw0KPiBmdW5jdGlvbg0KPiBpbiBuZnM0eGRyLmMsIG5s
aW5rIGlzIGluaXRpYWxpemVkIHRvIDEuIEhvd2V2ZXIsIHRoaXMgZGVmYXVsdCB2YWx1ZQ0KPiBp
c24ndCBzZXQgdG8gdGhlIGlub2RlIGR1ZSB0byB0aGUgY2hlY2sgaW4gbmZzX2ZoZ2V0Lg0KPiAN
Cj4gU28gaWYgdGhlIHNlcnZlciBkb2Vzbid0IHN1cHBvcnQgbnVtbGlua3MsIGlub2RlJ3Mgbmxp
bmsgd2lsbCBiZQ0KPiB6ZXJvLA0KPiB0aGUgbW91bnQgd2lsbCBmYWlsIHdpdGggZXJyb3IgIlN0
YWxlIGZpbGUgaGFuZGxlIi4gQ2hhbmdlIHRoZSBjaGVjaw0KPiBpbg0KPiBuZnNfZmhnZXQgc28g
dGhhdCB0aGUgbmxpbmsgdmFsdWUgaXMgYWx3YXlzIHNldC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEhhbiBZb3VuZyA8aGFueWFuZy50b255QGJ5dGVkYW5jZS5jb20+DQo+IC0tLQ0KPiDCoGZzL25m
cy9pbm9kZS5jIHwgNyArKysrLS0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9uZnMvaW5vZGUuYyBiL2Zz
L25mcy9pbm9kZS5jDQo+IGluZGV4IDExOWU0NDc3NThiOS4uYzE5ZjEzNWI1MDQxIDEwMDY0NA0K
PiAtLS0gYS9mcy9uZnMvaW5vZGUuYw0KPiArKysgYi9mcy9uZnMvaW5vZGUuYw0KPiBAQCAtNTUz
LDEwICs1NTMsMTEgQEAgbmZzX2ZoZ2V0KHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIHN0cnVjdCBu
ZnNfZmgNCj4gKmZoLCBzdHJ1Y3QgbmZzX2ZhdHRyICpmYXR0cikNCj4gwqAJCQlpbm9kZS0+aV9z
aXplID0gbmZzX3NpemVfdG9fbG9mZl90KGZhdHRyLQ0KPiA+c2l6ZSk7DQo+IMKgCQllbHNlDQo+
IMKgCQkJbmZzX3NldF9jYWNoZV9pbnZhbGlkKGlub2RlLA0KPiBORlNfSU5PX0lOVkFMSURfU0la
RSk7DQo+IC0JCWlmIChmYXR0ci0+dmFsaWQgJiBORlNfQVRUUl9GQVRUUl9OTElOSykNCj4gLQkJ
CXNldF9ubGluayhpbm9kZSwgZmF0dHItPm5saW5rKTsNCj4gLQkJZWxzZSBpZiAoZmF0dHJfc3Vw
cG9ydGVkICYgTkZTX0FUVFJfRkFUVFJfTkxJTkspDQo+ICsJCWlmICghKGZhdHRyLT52YWxpZCAm
IE5GU19BVFRSX0ZBVFRSX05MSU5LKSAmJg0KPiArCQkJwqDCoCBmYXR0cl9zdXBwb3J0ZWQgJiBO
RlNfQVRUUl9GQVRUUl9OTElOSykNCj4gwqAJCQluZnNfc2V0X2NhY2hlX2ludmFsaWQoaW5vZGUs
DQo+IE5GU19JTk9fSU5WQUxJRF9OTElOSyk7DQo+ICsJCWVsc2UNCj4gKwkJCXNldF9ubGluayhp
bm9kZSwgZmF0dHItPm5saW5rKTsNCg0KTm8uIFlvdSBjYW4ndCB1c2UgdGhlIHZhbHVlIG9mIGZh
dHRyLT5ubGluayB3aGVuIHRoYXQgdmFsdWUgaXMNCnVuZGVmaW5lZC4NCg0KPiDCoAkJaWYgKGZh
dHRyLT52YWxpZCAmIE5GU19BVFRSX0ZBVFRSX09XTkVSKQ0KPiDCoAkJCWlub2RlLT5pX3VpZCA9
IGZhdHRyLT51aWQ7DQo+IMKgCQllbHNlIGlmIChmYXR0cl9zdXBwb3J0ZWQgJiBORlNfQVRUUl9G
QVRUUl9PV05FUikNCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFp
bnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg==

