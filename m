Return-Path: <linux-nfs+bounces-3487-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCF98D4A1C
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2024 13:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50D7BB23AEA
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2024 11:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D8016F82E;
	Thu, 30 May 2024 11:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="AMqf3pWl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2100.outbound.protection.outlook.com [40.107.101.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A383B16F830
	for <linux-nfs@vger.kernel.org>; Thu, 30 May 2024 11:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717067630; cv=fail; b=UEjGyD1N8FB6lylyXegc2PjDf1OpqaJzAvhcg+nohdPHVXSIaHJwrD6eyw3vdzcTHzzqW3ILypR4hIjs4+xbgaioRVBDS37zR3O6IDVFEsT9jRgw0vWJ4UWsMWbFMylBI4uxfw7y+npuxGyfnu7ZJB518Dw5HY5WAK5kST+MRmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717067630; c=relaxed/simple;
	bh=YygSFqakeoFaxwD6cBsbRkSSjVXd1DOn1lxaKF5Ig5M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IhcF4gRuOiXjYZzNFBpvYlxrCCLx2EFz3Ov+YU6bLPrgNwfz2bMbcSEBH7AIFnm5T6O6twayEczHdqH42TcDi9j5AfO9ibWVDd0hkrW9muj3Fe+fJd3NohsF5L94Pub6eIfnF9xeJKOwVJ0wMNTONhnGkr5RFGW3QCDUXuX+RpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=AMqf3pWl; arc=fail smtp.client-ip=40.107.101.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkzE0xMY1S/VHFTpXQgn7laJ/5T7gIKaEPQviDRus0z+egDwiK07Wg+giE7hbK0cwOExklrOC1DSUDhvlZkGcLVTBKd1mKY5CayNIfUvCbEpPOOgWYNqxur+gHrEhhpwxHtQ7lwak3V8ppG0XBCWMX4QDkXVpH0k2i51GKpjwhif78O7Zt4b0n5qwLXMk0EKzU74dsHnsF80XCgxa6Wd5OusrtDQVTSIPW9AkEddyed26+Scc6Z5PT2IJCweCm7zDp+Srw1Io8pVICbQ//DhVfJ3K4MerFvG/NSKeAVHSeCQ9laA/iEdSL+SoBptciA6LjE4J5cTeCO/nAFpD7BZvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YygSFqakeoFaxwD6cBsbRkSSjVXd1DOn1lxaKF5Ig5M=;
 b=hM9M+bgflfZg8fhhqhqpnUCqeFTKTg6tJu2v0oBcDV0qJ/4ZQB3Gv9xI9bPY5+HTbWu/fhws6eOF5+LWtBHxz0BOXDJnINOhS3jRC5kRULTti/8DZN4FiX7d2PwuO+ho7Kzyc3g0BhQI/YgYkByWISBHNeGQ4bspwnX+RCDQSOS16AmWbo3rBs7YnZUrlyVky7SXuW+NBu0GKTH0pBudBktCxa7k4uRnSOjbkhRTKYGI1epMr+2JBIhupy07TOvOsvaus/iGZYiao7YUladryFzHNsLAyrNhy+my3xaBM/mm5Gt0VrmRF3BpOggBSz6SFp9jEa2WBNduuCFgFTCYfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YygSFqakeoFaxwD6cBsbRkSSjVXd1DOn1lxaKF5Ig5M=;
 b=AMqf3pWleUhgbAc47au1HUeGUhS7mb8I/too84y62Y7kcxGjj9yIHzxzjmZEqBllKNkkyLzLpRrOcjoX7vVzDKSuOkZZXukdxa0+Cg9P8ZX7DDfY7MGdHs2h96F3k5RCzvHgZ9KtZI8DUihOuA6P0PESDukXe0hxckU2FUYp444=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 SA6PR13MB7009.namprd13.prod.outlook.com (2603:10b6:806:40b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.7; Thu, 30 May
 2024 11:13:45 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::3312:9d7:60a8:e871]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::3312:9d7:60a8:e871%6]) with mapi id 15.20.7633.001; Thu, 30 May 2024
 11:13:44 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "jack@suse.cz" <jack@suse.cz>, "sagi@grimberg.me" <sagi@grimberg.me>
CC: "anna@kernel.org" <anna@kernel.org>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "nfbrown@suse.com" <nfbrown@suse.com>
Subject: Re: NFS write congestion size
Thread-Topic: NFS write congestion size
Thread-Index: AQHaseLWUtYvGxwZV0aUK4XVeNkc4rGucQaAgAD1eoCAAA1dgIAAGS4AgAAUDIA=
Date: Thu, 30 May 2024 11:13:44 +0000
Message-ID: <dfec543c411bf054d20f0e32971a98e174ed4c12.camel@hammerspace.com>
References: <20240529161102.5x3hhnbz32lwjcej@quack3>
	 <4a4368fbc260b22ff96593cedc53954b2cbe47fd.camel@hammerspace.com>
	 <440dcc5a-fdea-4677-9bad-b782e9801747@grimberg.me>
	 <20240530083151.vwxw3sqzrfhglaed@quack3>
	 <a86fdd86-7c3a-44e9-9d49-4b3edfab66e6@grimberg.me>
In-Reply-To: <a86fdd86-7c3a-44e9-9d49-4b3edfab66e6@grimberg.me>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR13MB5079:EE_|SA6PR13MB7009:EE_
x-ms-office365-filtering-correlation-id: b39f1522-81e4-4640-48e0-08dc80999216
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?MUNrb0Q1bHRnaFZsWDM3Z2NFeHBLOHdFRW1sUGlKWVlFWGZoSnJkZU8vd3Yy?=
 =?utf-8?B?THJOSzVvbGI3ZjJiMVphclJRMlVDL2RLeXpMM3QwZWNtL3J1RHpnbUJEa2E1?=
 =?utf-8?B?eEhKQ2VjbGlrZVBUK2dCV3pyTDZrZzlUcmw3a2o1UlBhNGJ3YzN1YVRWeDRj?=
 =?utf-8?B?ZFM3aC9SMXBjNmQyMkU3QjQ0aUY0VWtoN3hlSzJ0cmtvSUVIV0tFR3BrU0R0?=
 =?utf-8?B?dE03YjhrckpOK0huZ3ZyaWxjdUpZWWdJV3Zlek5adm9EazYrdTRkRkFhWE9p?=
 =?utf-8?B?U3UvbWl6c0tXTm5tdnEySUhVWU9VVEVQcFJRb3I2YmhmdlYyaVUrMkI4WXhw?=
 =?utf-8?B?dzVlSkRvSFBxeWtmY3N1djh1WFNiWmZaM00zU1R3RC9FNTFQL3dpc29hRjIv?=
 =?utf-8?B?V2ExYmNtL0s2TzZ0Rm10clRibU1HdTJSQWMwbEtTVkZXVUpENzZkSzN6QlRX?=
 =?utf-8?B?WTYvU2ZCZ1FBK3JMZzVSWkhWc0Fqc0wzTG44Z1FleEM0OWx0OVAwU3RMbXpx?=
 =?utf-8?B?d2x0bzZsSnR1U0dXdGZzakZnOVhqeHphWjVkYkoxN2VRS0QwWEV2eTZIWENT?=
 =?utf-8?B?eFlmZmF3dUs5enlKSDJ3U1Rudk50SGZLbng4dWtHaXA4NWNQY0N5SXVuK3dT?=
 =?utf-8?B?aVl1bHYxTFVadFBWNUFqNGI5RHFaYWE5UUZKNUVhd1Y1bkpFRUlTaTBhLzJq?=
 =?utf-8?B?RzZ1VGNRL29qRStid01LVXVIdGtVbFZYRTBsZ1VDMzJHSGlQU3FRZlJFNXZK?=
 =?utf-8?B?SEN1Mk1SZ1hMM1I3Sm1xSTNTaktXVVo2VnpQTER2RHhWb1dQa0pFR1Y3TEdC?=
 =?utf-8?B?Q2I1dXVBMWg0TnBpanBYZHpITjFVUDZWTGswYVZvcWZxeStJWForS0cveWty?=
 =?utf-8?B?eHkybGE1VGEvQUF0eVZkRTRrYmUrN25qcHptd0h2ZDhrMExKZnc3ZUdQTXpt?=
 =?utf-8?B?ZHd1eUYzNU1pMHBHOExzdnduVFBxbXdGaWdHLythdDB6eDhYSFI0OWIyOXR2?=
 =?utf-8?B?WkhDMzg3cVRpMThLRW1VYndIeGZwVXZOelI3UnJ5ZnRvUVYrcFY1WGlieFNY?=
 =?utf-8?B?Y1dDWElldWlXSEtlTThXVmt5K1RVMUgvNGlUUHBLS1hLbHoyUm9ja2VpcjZU?=
 =?utf-8?B?c2pZRjIrV1NEN0tOa2VTSE1WMnFYWE9XQUVoakxsQ1VZbm05dGtNaDZVUjg5?=
 =?utf-8?B?WEdjNkUvYzB3cG5TUWZZcGpFTktFT3Aydk56bEliTjRPaFMwSHdYL1Q2Sk5i?=
 =?utf-8?B?cVI5QmpCWnpxQUFvUHkzZjhVS2Zuc1VPdlZEYjlVYjQvUjAyQTdka1lqR0Jw?=
 =?utf-8?B?QlRKYW4yaTBqa3VxQy9mQmpxeVdHUzNZU2tQTms2SEtiMnloOE9VSjRrRzdV?=
 =?utf-8?B?SGlORS9XT2c0R0ZDYW5EK3Z1U3V5ZDB5UzQrMm03enczMG95Vk40eGlpOGlx?=
 =?utf-8?B?QlMrYW5yUmhTS0VjWjcrV0FhNE9VK3B3cGFhMW1lN1AycXFuOGpIYkllclJT?=
 =?utf-8?B?ZDZtb3VsUGJQdDFrckd0a2VBcFJ3RVNqeE9FTWZlSUNkQUxYTEVFQUM2WDJS?=
 =?utf-8?B?cktoN0NLajc3MFNwdmZoamV6emp2WDcyTWx5UU9EUythaklDOHJSQWtYM0R2?=
 =?utf-8?B?WkVXMlptbXR6S0hVZXNjWFpjL3djN1I0bnNwbWdJSFIvVkF0emxLOXg5b0xX?=
 =?utf-8?B?QzhMdkcvZEJiSXFtZmUzUzRzaHUxa1VFUDIvanl4M1JPY3pFSHFVaWpCRkFC?=
 =?utf-8?B?QitYeGNCQ3BaRmJBV0NJbkxvc05zNElFaHcvNSs2UjNmVUMxRURCTWJ5TStL?=
 =?utf-8?B?cWZBaEoyVERnbnIzSVFhZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V2lMRmNpdUY3MUd0MVZ4ZHROa2hkRUhKNTZ4MXJHSFpURms3NHpoOTZ5UE9W?=
 =?utf-8?B?MmR1VzlydmRScVFsWmFLRGhTT0JxMCtzekZGNWJMbkI4TS9IY05hN1ljNDVk?=
 =?utf-8?B?bW5qcGU1RE1FTkp3TWs5RDFsWi9sTTdvN0NqOTlwWE4vRzZKaWpoSlFUamsy?=
 =?utf-8?B?S05XSUVIRnJpMTh0aUVSQzNuMktsbm82d0IwMkM2UXJucFE4aXZEWmcwWS9G?=
 =?utf-8?B?d09NVWg0elFYeldmUjN6NG5RZCtKcUFya3BPSVgvZjlGdWk5ekR5SkhNWTF1?=
 =?utf-8?B?Y3U1U2VnOFMwTDFuL3BxVmhNaXhSZElMbjRnTFJJalZWUi9RSGUyQm5JMlU5?=
 =?utf-8?B?dzJYNXQ0b0kvYWJLWG5oemRnWjBwdVBWbjNEVVFya2w5eEdlR3VNNzd3b0F4?=
 =?utf-8?B?TWFwYUhSZzJiVXdjaHZjeU1FT3lOcHNzTmovTkdwZmV1VGdDY04rb0pCU2ow?=
 =?utf-8?B?aFM0Uk5LeDVraXM0RkZXQXZDb1dUbll3d3hzcUpTZWlGT3JLRG05T28wZVBW?=
 =?utf-8?B?NTBGVkRkdGhweHQ1VFVnblZtanRvakorcElFWCs1V1Radm5TMkhkSTJGbzJn?=
 =?utf-8?B?cXRKTVRING82bXd3bVZlUjFmL2hRSTVidVNnYmtITWJzeFNhMVVLVnl3NFhJ?=
 =?utf-8?B?TTlDcWJOdkFaYm5lN2JTNTNyVWdHLzZKUkNNZlUrcFMwTHRaNVhCSVZWY1M0?=
 =?utf-8?B?dmJqY3JkRlFpN281RExYMGg3MlkrTW1RY005OGF4UmhiNGVBVC9XZnU4Uk9F?=
 =?utf-8?B?YVBCZUMxcCtoL1YzUlc1L0xpc0M1a2RhaEFOZ2U2VUo0dVFDQmIvd1NSSGVi?=
 =?utf-8?B?bms5Q0hzM1hRN0lWZXBVbktxSksza28wb2hEL05GdHovQ2YxODdsZkttZVNI?=
 =?utf-8?B?ZTlIa0xIUHdOeVJabWI1SkYreDhSNy9TK1M3LzI0d0E1KzNkMmFmNElaVzJX?=
 =?utf-8?B?NE9MNHoybUxCTFdxUldFRjBlZGdIMURiNGZUUXYrTWNxVEJyRm5nUDVUcEJj?=
 =?utf-8?B?SVZhR3Zqc1VsZDZJSEo1dkgrRG5lZ1BobWdmVFpaWVErZ0FLNjhJeU9kVWNY?=
 =?utf-8?B?Q2RaYTJ1ZmQ2WmlMZUNySE8rVlNkVUprWkpnMmdCcWh5Q2hZbDcyd2lDTlR2?=
 =?utf-8?B?eHc3TVYxWE11NjdzZG83NEpWNC84NG4vd3JkcjdqRlVzUUxkTDNpRTdXTlZ0?=
 =?utf-8?B?enIxY2R3T3c5VDVVbEhvSjBBcTVjN0ZBaEJnblNpOEt2dWdkV20zTWNzRk5t?=
 =?utf-8?B?SHd5cnMyUjFxTURyUzBsQkh0ZlkxNzE3em1MdG9Zd2tVdk11cmpYWFF2Y0JZ?=
 =?utf-8?B?cUxwTjlUMWFidTRNY2ZEWWx3NzVKYmV3dnhnVHJFVnJWd2ZKbFRiYjd0WHhm?=
 =?utf-8?B?bDAxellSNU5FQ0ZDWlNlYy9hVEtWYUVkOGZWS2dzYWFhU3hoZXpyU3NnR0F5?=
 =?utf-8?B?K05sNGhHQXpBSUpaMDNuOGcwQk4vWjl6cHZ4dFhlZDNaVVNiWDhPbTNkMWJp?=
 =?utf-8?B?bXFxSzlQVlNFSFpROVVCUC9RempmZFVVQWtHWmRUWk1BenloRExJNGtiMWNM?=
 =?utf-8?B?SVovMXZCNmkvQkgwdzhWd0w2dE5LZ2Uza0ZsT2tuQUYvU2dod3IwTGVIazZG?=
 =?utf-8?B?YjJBSnJyTHlvbUVhUDh6ZlZRZEprbzZCKy9tTUVxTVM5VlE3VUFDVEM0Z3A5?=
 =?utf-8?B?VDJOdmY2QTZPQ3FYeDJJVGpRRlZDdUszTFAwY1FjQjdUVkVsOHE3KzlYdGlN?=
 =?utf-8?B?RzhoMVhXbGRhOE9nK2RGdzZTelA4MkNvQkVFUkJOV1JpeUVINjBya3RTVlNv?=
 =?utf-8?B?LzdmL1lWNHNyUjRqOVI2ZXd4MVdPOE1BTUg2Q3JOQXZGVGxXWE5CZzFxdUF0?=
 =?utf-8?B?dXFoZzc2enZjaHdCK09nY0owVEplUzdJSGlBUWtLMHRranZiWm5oQjZtVWF0?=
 =?utf-8?B?SHJKTGxuaEQwZzlzR0JWamhTLzVVUWpIZ0tsaDdLc3F1OFI2V2sxVkg2NUJO?=
 =?utf-8?B?YnJ5UDhXUEcwTTF2c1JUQkZtN0doaFRDYjFTK0szM203SzhvL2trclo3azVZ?=
 =?utf-8?B?N3JRbk9mTzZ3V2ZhZ3E2ZEJlbVEyYTRaOTgvSEFUOWVyR0NSeXpkMHdRbDY2?=
 =?utf-8?B?dXd0MmlFWXU3c3dadENIUkJodGZkZHJQSVRKcDhCZlIzc3YzQUpnTDhOYUkx?=
 =?utf-8?B?c0x2RUNkcUNDNWlaZkJ0VllyU3UrRUZaQU9jME51RlhrVDZ3YkpTcE9IZEgy?=
 =?utf-8?B?dlIzdDkvUzFKYmRwdXR5dExMZ0pRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C636D02350ED2B43AD23BBB1094201F1@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5079.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b39f1522-81e4-4640-48e0-08dc80999216
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 11:13:44.8621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nj8khgIGINd8RKmHTvMd/rDajoRPgw4xMmFAhgUfsxxpX9kyAMZ7JtJ8WOh8OzJSG1Ap3hh7QQVWbKuNMalrLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR13MB7009

T24gVGh1LCAyMDI0LTA1LTMwIGF0IDEzOjAxICswMzAwLCBTYWdpIEdyaW1iZXJnIHdyb3RlOg0K
PiANCj4gDQo+IE9uIDMwLzA1LzIwMjQgMTE6MzEsIEphbiBLYXJhIHdyb3RlOg0KPiA+IE9uIFRo
dSAzMC0wNS0yNCAxMDo0NDowMSwgU2FnaSBHcmltYmVyZyB3cm90ZToNCj4gPiA+IE9uIDI5LzA1
LzIwMjQgMjA6MDUsIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiA+ID4gT24gV2VkLCAyMDI0
LTA1LTI5IGF0IDE4OjExICswMjAwLCBKYW4gS2FyYSB3cm90ZToNCj4gPiA+ID4gPiBIZWxsbywN
Cj4gPiA+ID4gPiANCj4gPiA+ID4gPiBzbyBJIHdhcyBpbnZlc3RpZ2F0aW5nIHdoeSByYW5kb20g
d3JpdGVzIHRvIGEgbGFyZ2UgZmlsZSBvdmVyDQo+ID4gPiA+ID4gTkZTIGdvdA0KPiA+ID4gPiA+
IG5vdGljZWFibHkgc2xvd2VyLiBUaGUgd29ya2xvYWQgd2UgdXNlIHRvIHRlc3QgdGhpcyBpcyB0
aGlzDQo+ID4gPiA+ID4gZmlvDQo+ID4gPiA+ID4gY29tbWFuZDoNCj4gPiA+ID4gPiANCj4gPiA+
ID4gPiBmaW8gLS1kaXJlY3Q9MCAtLWlvZW5naW5lPXN5bmMgLS10aHJlYWQgLS1kaXJlY3Rvcnk9
L21udCAtLQ0KPiA+ID4gPiA+IGludmFsaWRhdGU9MSBcDQo+ID4gPiA+ID4gwqAgwqDCoMKgIC0t
Z3JvdXBfcmVwb3J0aW5nPTEgLS1ydW50aW1lPTMwMCAtLWZhbGxvY2F0ZT1wb3NpeCAtLQ0KPiA+
ID4gPiA+IHJhbXBfdGltZT0xMCBcDQo+ID4gPiA+ID4gwqAgwqDCoMKgIC0tbmFtZT1SYW5kb21X
cml0ZXMtYXN5bmMtMjU3MDI0LTRrLTQgLS1uZXdfZ3JvdXAgLS0NCj4gPiA+ID4gPiBydz1yYW5k
d3JpdGUNCj4gPiA+ID4gPiBcDQo+ID4gPiA+ID4gwqAgwqDCoMKgIC0tc2l6ZT0zMjAwMG0gLS1u
dW1qb2JzPTQgLS1icz00ayAtLWZzeW5jX29uX2Nsb3NlPTEgLS0NCj4gPiA+ID4gPiBlbmRfZnN5
bmM9MSBcDQo+ID4gPiA+ID4gwqAgwqDCoMKgIC0tZmlsZW5hbWVfZm9ybWF0PSdGaW9Xb3JrbG9h
ZHMuJGpvYm51bScNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBFdmVudHVhbGx5IEkndmUgdHJhY2tl
ZCBkb3duIHRoZSByZWdyZXNzaW9uIHRvIGJlIGNhdXNlZCBieQ0KPiA+ID4gPiA+IDZkZjI1ZTU4
NTMyYg0KPiA+ID4gPiA+ICgibmZzOiByZW1vdmUgcmVsaWFuY2Ugb24gYmRpIGNvbmdlc3Rpb24i
KSB3aGljaCBjaGFuZ2VkIHRoZQ0KPiA+ID4gPiA+IGNvbmdlc3Rpb24NCj4gPiA+ID4gPiBtZWNo
YW5pc20gZnJvbSBhIGdlbmVyaWMgYmRpIGNvbmdlc3Rpb24gaGFuZGxpbmcgdG8gTkZTDQo+ID4g
PiA+ID4gcHJpdmF0ZSBvbmUuDQo+ID4gPiA+ID4gQmVmb3JlDQo+ID4gPiA+ID4gdGhpcyBjb21t
aXQgdGhlIGZpbyBhY2hpZXZlZCB0aHJvdWdocHV0IG9mIDE4MCBNQi9zLCBhZnRlcg0KPiA+ID4g
PiA+IHRoaXMNCj4gPiA+ID4gPiBjb21taXQgb25seQ0KPiA+ID4gPiA+IDEyMCBNQi9zLiBOb3cg
cGFydCBvZiB0aGUgcmVncmVzc2lvbiB3YXMgYWN0dWFsbHkgY2F1c2VkIGJ5DQo+ID4gPiA+ID4g
aW5lZmZpY2llbnQNCj4gPiA+ID4gPiBmc3luYygyKSBhbmQgdGhlIGZhY3QgdGhhdCBtb3JlIGRp
cnR5IGRhdGEgd2FzIGNhY2hlZCBhdCB0aGUNCj4gPiA+ID4gPiB0aW1lIG9mDQo+ID4gPiA+ID4g
dGhlDQo+ID4gPiA+ID4gbGFzdCBmc3luYyBhZnRlciBjb21taXQgNmRmMjVlNTg1MzJiLiBBZnRl
ciBmaXhpbmcgZnN5bmMgWzFdLA0KPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+IHRocm91Z2hwdXQg
Z290IHRvIDE1MCBNQi9zIHNvIGJldHRlciBidXQgc3RpbGwgbm90IHF1aXRlIHRoZQ0KPiA+ID4g
PiA+IHRocm91Z2hwdXQNCj4gPiA+ID4gPiBiZWZvcmUgNmRmMjVlNTg1MzJiLg0KPiA+ID4gPiA+
IA0KPiA+ID4gPiA+IFRoZSByZWFzb24gZm9yIHJlbWFpbmluZyByZWdyZXNzaW9uIGlzIHRoYXQg
YmRpIGNvbmdlc3Rpb24NCj4gPiA+ID4gPiBoYW5kbGluZw0KPiA+ID4gPiA+IHdhcw0KPiA+ID4g
PiA+IGJyb2tlbiBhbmQgdGhlIGNsaWVudCBoYWQgaGFwcGlseSB+OEdCIG9mIG91dHN0YW5kaW5n
IElPDQo+ID4gPiA+ID4gYWdhaW5zdCB0aGUNCj4gPiA+ID4gPiBzZXJ2ZXINCj4gPiA+ID4gPiBk
ZXNwaXRlIHRoZSBjb25nZXN0aW9uIGxpbWl0IHdhcyAyNTYgTUIuIFRoZSBuZXcgY29uZ2VzdGlv
bg0KPiA+ID4gPiA+IGhhbmRsaW5nDQo+ID4gPiA+ID4gYWN0dWFsbHkgd29ya3MgYnV0IGFzIGEg
cmVzdWx0IHRoZSBzZXJ2ZXIgZG9lcyBub3QgaGF2ZQ0KPiA+ID4gPiA+IGVub3VnaCBkaXJ0eQ0K
PiA+ID4gPiA+IGRhdGENCj4gPiA+ID4gPiB0byBlZmZpY2llbnRseSBvcGVyYXRlIG9uIGFuZCB0
aGUgc2VydmVyIGRpc2sgb2Z0ZW4gZ2V0cyBpZGxlDQo+ID4gPiA+ID4gYmVmb3JlDQo+ID4gPiA+
ID4gdGhlDQo+ID4gPiA+ID4gY2xpZW50IGNhbiBzZW5kIG1vcmUuDQo+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gSSB3YW50ZWQgdG8gZGlzY3VzcyBwb3NzaWJsZSBzb2x1dGlvbnMgaGVyZS4NCj4gPiA+
ID4gPiANCj4gPiA+ID4gPiBHZW5lcmFsbHkgMjU2TUIgaXMgbm90IGVub3VnaCBldmVuIGZvciBj
b25zdW1lciBncmFkZQ0KPiA+ID4gPiA+IGNvbnRlbXBvcmFyeQ0KPiA+ID4gPiA+IGRpc2tzIHRv
DQo+ID4gPiA+ID4gbWF4IG91dCB0aHJvdWdocHV0LiBUaGVyZSBpcyB0dW5hYmxlDQo+ID4gPiA+
ID4gL3Byb2Mvc3lzL2ZzL25mcy9uZnNfY29uZ2VzdGlvbl9rYi4NCj4gPiA+ID4gPiBJZiBJIHR3
ZWFrIGl0IHRvIHNheSAxR0IsIHRoYXQgaXMgZW5vdWdoIHRvIGdpdmUgdGhlIHNlcnZlcg0KPiA+
ID4gPiA+IGVub3VnaA0KPiA+ID4gPiA+IGRhdGEgdG8NCj4gPiA+ID4gPiBzYXR1cmF0ZSB0aGUg
ZGlzayAobW9zdCBvZiB0aGUgdGltZSkgYW5kIGZpbyByZWFjaGVzIDE4ME1CL3MNCj4gPiA+ID4g
PiBhcw0KPiA+ID4gPiA+IGJlZm9yZQ0KPiA+ID4gPiA+IGNvbW1pdCA2ZGYyNWU1ODUzMmIuIFNv
IG9uZSBzb2x1dGlvbiB0byB0aGUgcHJvYmxlbSB3b3VsZCBiZQ0KPiA+ID4gPiA+IHRvDQo+ID4g
PiA+ID4gY2hhbmdlIHRoZQ0KPiA+ID4gPiA+IGRlZmF1bHQgb2YgbmZzX2Nvbmdlc3Rpb25fa2Ig
dG8gMUdCLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEdlbmVyYWxseSB0aGUgcHJvYmxlbSB3aXRo
IHRoaXMgdHVuaW5nIGlzIHRoYXQgZmFzdGVyIGRpc2tzDQo+ID4gPiA+ID4gbWF5IG5lZWQNCj4g
PiA+ID4gPiBldmVuDQo+ID4gPiA+ID4gbGFyZ2VyIG5mc19jb25nZXN0aW9uX2tiLCB0aGUgTkZT
IGNsaWVudCBoYXMgbm8gd2F5IG9mDQo+ID4gPiA+ID4ga25vd2luZyB3aGF0DQo+ID4gPiA+ID4g
dGhlDQo+ID4gPiA+ID4gcmlnaHQgdmFsdWUgb2YgbmZzX2Nvbmdlc3Rpb25fa2IgaXMuIEkgcGVy
c29uYWxseSBmaW5kIHRoZQ0KPiA+ID4gPiA+IGNvbmNlcHQgb2YNCj4gPiA+ID4gPiBjbGllbnQg
dGhyb3R0bGluZyB3cml0ZXMgdG8gdGhlIHNlcnZlciBmbGF3ZWQuIFRoZSAqc2VydmVyKg0KPiA+
ID4gPiA+IHNob3VsZA0KPiA+ID4gPiA+IHB1c2gNCj4gPiA+ID4gPiBiYWNrIChvciB0aHJvdHRs
ZSkgaWYgdGhlIGNsaWVudCBpcyB0b28gYWdncmVzc2l2ZWx5IHB1c2hpbmcNCj4gPiA+ID4gPiBv
dXQgdGhlDQo+ID4gPiA+ID4gZGF0YQ0KPiA+ID4gPiA+IGFuZCB0aGVuIHRoZSBjbGllbnQgY2Fu
IHJlYWN0IHRvIHRoaXMgYmFja3ByZXNzdXJlLiBCZWNhdXNlDQo+ID4gPiA+ID4gb25seSB0aGUN
Cj4gPiA+ID4gPiBzZXJ2ZXINCj4gPiA+ID4gPiBrbm93cyBob3cgbXVjaCBpdCBjYW4gaGFuZGxl
IChhbHNvIGdpdmVuIHRoZSBsb2FkIGZyb20gb3RoZXINCj4gPiA+ID4gPiBjbGllbnRzKS4gQW5k
DQo+ID4gPiA+ID4gSSBiZWxpZXZlIHRoaXMgaXMgYWN0dWFsbHkgd2hhdCBpcyBoYXBwZW5pbmcg
aW4gcHJhY3RpY2UNCj4gPiA+ID4gPiAoZS5nLiB3aGVuIEkNCj4gPiA+ID4gPiB0dW5lDQo+ID4g
PiA+ID4gbmZzX2Nvbmdlc3Rpb25fa2IgdG8gcmVhbGx5IGhpZ2ggbnVtYmVyKS4gU28gSSB0aGlu
ayBldmVuDQo+ID4gPiA+ID4gYmV0dGVyDQo+ID4gPiA+ID4gc29sdXRpb24NCj4gPiA+ID4gPiBt
YXkgYmUgdG8ganVzdCByZW1vdmUgdGhlIHdyaXRlIGNvbmdlc3Rpb24gaGFuZGxpbmcgZnJvbSB0
aGUNCj4gPiA+ID4gPiBjbGllbnQNCj4gPiA+ID4gPiBjb21wbGV0ZWx5LiBUaGUgaGlzdG9yeSBi
ZWZvcmUgY29tbWl0IDZkZjI1ZTU4NTMyYiwgd2hlbg0KPiA+ID4gPiA+IGNvbmdlc3Rpb24NCj4g
PiA+ID4gPiB3YXMNCj4gPiA+ID4gPiBlZmZlY3RpdmVseSBpZ25vcmVkLCBzaG93cyB0aGF0IHRo
aXMgaXMgdW5saWtlbHkgdG8gY2F1c2UgYW55DQo+ID4gPiA+ID4gcHJhY3RpY2FsDQo+ID4gPiA+
ID4gcHJvYmxlbXMuIFdoYXQgZG8gcGVvcGxlIHRoaW5rPw0KPiA+ID4gPiBJIHRoaW5rIHdlIGRv
IHN0aWxsIG5lZWQgYSBtZWNoYW5pc20gdG8gcHJldmVudCB0aGUgY2xpZW50IGZyb20NCj4gPiA+
ID4gcHVzaGluZw0KPiA+ID4gPiBtb3JlIHdyaXRlYmFja3MgaW50byB0aGUgUlBDIGxheWVyIHdo
ZW4gdGhlIHNlcnZlciB0aHJvdHRsaW5nDQo+ID4gPiA+IGlzDQo+ID4gPiA+IGNhdXNpbmcgUlBD
IHRyYW5zbWlzc2lvbiBxdWV1ZXMgdG8gYnVpbGQgdXAuIE90aGVyd2lzZSB3ZSBlbmQNCj4gPiA+
ID4gdXANCj4gPiA+ID4gaW5jcmVhc2luZyB0aGUgbGF0ZW5jeSB3aGVuIHRoZSBhcHBsaWNhdGlv
biBpcyB0cnlpbmcgdG8gZG8NCj4gPiA+ID4gbW9yZSBJL08gdG8NCj4gPiA+ID4gcGFnZXMgdGhh
dCBhcmUgcXVldWVkIHVwIGZvciB3cml0ZWJhY2sgaW4gdGhlIFJQQyBsYXllciAoc2luY2UNCj4g
PiA+ID4gdGhlDQo+ID4gPiA+IGxhdHRlciB3aWxsIGJlIHdyaXRlIGxvY2tlZCkuDQo+ID4gPiBQ
bHVzIHRoZSBzZXJ2ZXIgaXMgbGlrZWx5IHNlcnZpbmcgbXVsdGlwbGUgY2xpZW50cywgc28gcmVt
b3ZpbmcNCj4gPiA+IGFueSB0eXBlDQo+ID4gPiBvZiBjb25nZXN0aW9uIGhhbmRsaW5nIGZyb20g
dGhlIGNsaWVudCBtYXkgb3ZlcndoZWxtIHRoZSBzZXJ2ZXIuDQo+ID4gSSB1bmRlcnN0YW5kIHRo
aXMgY29uY2VybiBidXQgYmVmb3JlIGNvbW1pdCA2ZGYyNWU1ODUzMmIgd2UNCj4gPiBlZmZlY3Rp
dmVseQ0KPiA+IGRpZG4ndCBkbyBhbnkgdGhyb3R0bGluZyBmb3IgeWVhcnMgYW5kIG5vYm9keSBj
b21wbGFpbmVkLg0KDQoNCkNvbW1pdCA2ZGYyNWU1ODUzMmIgZG9lc24ndCBhZGQgdGhyb3R0bGlu
Zy4gSXQganVzdCBjb252ZXJ0cyBmcm9tIHVzaW5nDQp0aGUgYmRpIGJhc2VkIG1lY2hhbmlzbSB0
byB1c2luZyBhIE5GUy1zcGVjaWZpYyBvbmUuDQpUaGF0IGJkaSBiYXNlZCB0aHJvdHRsaW5nIG1l
Y2hhbmlzbSBkYXRlcyBhdCBsZWFzdCBiYWNrIHRvIDIwMDcsDQphbHRob3VnaCB0aGVyZSB3YXMg
Y29kZSBiZWZvcmUgdGhhdCBkYXRpbmcgYmFjayB0byBwcmUtZ2l0IGhpc3RvcnkuDQoNCj4gDQo+
IGRvbid0IGtub3cgYWJvdXQgdGhlIGhpc3Rvcnkgbm9yIHdoYXQgcGVvcGxlIGNvdWxkIGhhdmUg
YXR0cmlidXRlZA0KPiBwcm9ibGVtcy4NCj4gDQo+ID4gwqAgU28gc2VydmVycw0KPiA+IGFwcGFy
ZW50bHkga25vdyBob3cgdG8gY29wZSB3aXRoIGNsaWVudHMgc2VuZGluZyB0b28gbXVjaCBJTyB0
bw0KPiA+IHRoZW0uDQo+IA0KPiBub3Qgc3VyZSBob3cgYW4gbmZzIHNlcnZlciB3b3VsZCBjb3Bl
IHdpdGggdGhpcy4gbmZzdjQgY2FuIHJlZHVjZQ0KPiBzbG90cywgDQo+IGJ1dCBub3QNCj4gc3Vy
ZSB3aGF0IG5mc3YzIHNlcnZlciB3b3VsZCBkby4uLg0KPiANCj4gYnR3LCBJIHRoaW5rIHlvdSBt
ZWFudCB0aGF0ICpzbG93ZXIqIGRldmljZXMgbWF5IG5lZWQgYSBsYXJnZXIgcXVldWUNCj4gdG8g
DQo+IHNhdHVyYXRlLA0KPiBiZWNhdXNlIGlmIHRoZSBkZXZpY2UgaXMgZmFzdCwgMjU2TUIgaW5m
bGlnaHQgaXMgcHJvYmFibHkgZW5vdWdoLi4uDQo+IFNvIA0KPiB5b3UgYXJlIHNvbHZpbmcNCj4g
Zm9yIHRoZSAiY29uc3VtZXIgZ3JhZGUgY29udGVtcG9yYXJ5IGRpc2tzIi4NCj4gDQoNCkl0IGlz
IGhhcmQgdG8gZG8gc2VydmVyIHNpZGUgY29uZ2VzdGlvbiBjb250cm9sIHdpdGggVURQLCBzaW5j
ZSBpdCBkb2VzDQpub3QgaGF2ZSBhIG5hdGl2ZSBjb25nZXN0aW9uIG1lY2hhbmlzbSB0byBsZXZl
cmFnZS4NCg0KSG93ZXZlciBjb25uZWN0aW9uIGJhc2VkIHRyYW5zcG9ydHMgYXJlIGVzc2VudGlh
bGx5IGEgcXVldWluZyBtZWNoYW5pc20NCmFzIGZhciBhcyB0aGUgc2VydmVyIGlzIGNvbmNlcm5l
ZC4gSXQgY2FuIHRyaXZpYWxseSBwdXNoIGJhY2sgb24gdGhlDQpjbGllbnQgYnkgc2xvd2luZyBk
b3duIHRoZSByYXRlIGF0IHdoaWNoIGl0IHB1bGxzIFJQQyBjYWxscyBmcm9tIHRoZQ0KdHJhbnNw
b3J0IChvciBzdG9wcGluZyB0aGVtIGFsdG9nZXRoZXIpLiBUaGF0J3MgYSBtZWNoYW5pc20gdGhh
dCB3b3Jrcw0KanVzdCBmaW5lIGZvciBib3RoIFRDUCBhbmQgUkRNQS4NCg0KQWRkaXRpb25hbGx5
LCBORlN2NCBoYXMgdGhlIHNlc3Npb24gc2xvdCBtZWNoYW5pc20sIGFuZCB3aGlsZSB0aGF0IGNh
bg0KYmUgdXNlZCBhcyBhIHRocm90dGxpbmcgbWVjaGFuaXNtLCBpdCBpcyBtb3JlIGFib3V0IHBy
b3ZpZGluZyBzYWZlDQpvbmx5LW9uY2UgcmVwbGF5IHNlbWFudGljcy4gQSBwcnVkZW50IHNlcnZl
ciBpbXBsZW1lbnRhdGlvbiB3b3VsZCBub3QNCnJlbHkgb24gaXQgdG8gcmVwbGFjZSB0cmFuc3Bv
cnQgbGV2ZWwgdGhyb3R0bGluZy4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBj
bGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFj
ZS5jb20NCg0KDQo=

