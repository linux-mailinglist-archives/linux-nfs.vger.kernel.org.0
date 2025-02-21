Return-Path: <linux-nfs+bounces-10277-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3AAA3FF94
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 20:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ED5719C7A34
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 19:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C687A1F12EC;
	Fri, 21 Feb 2025 19:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Ce3ncT5I"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2105.outbound.protection.outlook.com [40.107.94.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49FC5223
	for <linux-nfs@vger.kernel.org>; Fri, 21 Feb 2025 19:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740165511; cv=fail; b=VtUjX5J8EKGVxNDX4H3IiO3vGisH23JdzDISIb42K2qMtuTUb3JpyU1ZXKoNmGQ0rFO68+cD7fA6yOkmDZeg7clPBb5cgGaBcKtW/SZL5HRITCvmvD3Dw5RwMcRFexpd2u+upOZT6MoAXxod00vaAakOWoMi4gAJISpPrnreE3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740165511; c=relaxed/simple;
	bh=SAeF/JE8w4rRTADVC1RMLB/ZHDvI8y/YBEPkqCCeuDg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AhxrAEM+x587FMJQNOxRQwWIIW34MgqGOMmxNHUQetF1Hes9KBLWX7UyO2hPGnVFNIj2kIBKDfTlmnK1B4OFGpkhCoBypcD8cBKcwcG8MXArGze/KXOkGxoonCchG1e+RrdqUAj+oBvTRgS4qdKAkxVKU0jVQRzB/7SPydK2/+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Ce3ncT5I; arc=fail smtp.client-ip=40.107.94.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DAoyW0izf9rH6K9AJ1lUz0WEN2qGv9xb5XgGQ76GmzYxaGh4OCYvaGtauW7CfdXeDjtYPjF0UcykcV0OU8Ug7GCcucsHX/uxS1Xuy93MYKHlp+XdBMfcJu+y5u4gSqRR2EzesM0YPWwl836mwSNsDN0lKSIJXG594ujKSYJx/96EBF1nb47ILmh2dP+Iy37crIFhQtjU9Hs6dN341LGGc/0L2VZy9bSmJ8BjGPHnSXl4C7DJlTGjGlez4ifm4YiRePMH+ho5hHAFoEU6Sp7OIHTwq04IHd52zX7LLskvB14tF7g3yu5dLYAXpYeu4Jwp41wxCWzLpNgsRf/7xU6saw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAeF/JE8w4rRTADVC1RMLB/ZHDvI8y/YBEPkqCCeuDg=;
 b=NAdf0aOeKPy77Ylhqvr3xFFtxChGWXxRJSBarOCjeLk8xCGNuYcD/bUDLUr6xc2fYw7KWRvNX4zsT3CwjBaYDb/QpUddepbwBKkWdNQtd9Sb8JOFmE0DGgvmXT5ybBxPIMCDefY9Fd8xMgxz5MmA4KxbrSt4FRzixsolxTNsWV4t3swzf4FVUtlG8YdVJszo3ID+Ezpkm7IThB5Rq0EXVlDL898Qbw1kKSVo13r36YBXf4+MYDUWSBaYsrHbQ3P2noKg1eXUO277lyIA6NZexybufMSFF1y7EfUij1CV0ZSzkBvHaCUgkpH8RFoLuEmz4KJm+QWG1s2ZewsRm1ftcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAeF/JE8w4rRTADVC1RMLB/ZHDvI8y/YBEPkqCCeuDg=;
 b=Ce3ncT5IJIAYcgD5WKdLj+fL+owy24JlzgTz66n3V33GdCfzF7032R/bVO66Esn0SVQs4ofyjQzdtxx9MGkDbJ3ljnuvJ8d/EGdzDsgQDVvWfJLXSkpMHA/0RnyrD+yBT2xP7dRDZ7vNESPpiQYIQJYw6cOxJ+6ga+FthMkWlkY=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MN0PR13MB6695.namprd13.prod.outlook.com (2603:10b6:208:4c6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 19:18:21 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%3]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 19:18:21 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "snitzer@kernel.org" <snitzer@kernel.org>, "jlayton@kernel.org"
	<jlayton@kernel.org>, "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC: "okorniev@redhat.com" <okorniev@redhat.com>, "tom@talpey.com"
	<tom@talpey.com>, "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>, "neilb@suse.de" <neilb@suse.de>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: nfsd: add the ability to enable use of RWF_DONTCACHE for all nfsd
 IO
Thread-Topic: nfsd: add the ability to enable use of RWF_DONTCACHE for all
 nfsd IO
Thread-Index:
 AQHbhHG829RmuJMFp0e5I1R2FeBUXbNR4KqAgAADEACAAAMGAIAAB26AgAApvwCAAAnrAA==
Date: Fri, 21 Feb 2025 19:18:21 +0000
Message-ID: <4351756085f94489329c6065d7eeff22f5079d0d.camel@hammerspace.com>
References: <20250220171205.12092-1-snitzer@kernel.org>
			 <ce92e5f6-d7cb-47ef-ad96-d334212a51f1@oracle.com>
			 <Z7iVdHcnGveg-gbg@kernel.org>
			 <b101b927807cc30ce284d6be9aca5cbb92da8f94.camel@kernel.org>
			 <Z7idYDSHD_hcLL9b@kernel.org>
			 <6bd2aa18-e52b-47e6-9151-4ff80d1a39b8@oracle.com>
		 <7b1574e2499da99986c432f815abccb2e5a6c7f5.camel@hammerspace.com>
	 <42400116f9098ec7f5acc70c2450dd52a2bf8f21.camel@kernel.org>
In-Reply-To: <42400116f9098ec7f5acc70c2450dd52a2bf8f21.camel@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|MN0PR13MB6695:EE_
x-ms-office365-filtering-correlation-id: 4adbffca-4008-407e-bd21-08dd52ac8176
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ejAzL2o2RWsyMUV0a3N6S1pJWlJXMzAwZjRhY2hseDluSjFEWEZLQ2I4dHIx?=
 =?utf-8?B?UlFuSHJVNHpBeUVDS1Qyc1k4KzJ2cDVhYWNkNkZPQmtlc1VjUjZtLzNRU2Qw?=
 =?utf-8?B?SjczRnVNK0ZSUldOQjlmYXBoQWhNcDNRMDJ5QzVDczFvcGlvdVRGSEttVXhI?=
 =?utf-8?B?WUdPM000Ukhud0dZMS9YRGRyU3BrenhNVSs2TXdhOEZEU0x1S0JsZ1Z6T09t?=
 =?utf-8?B?TkdSbUJFdlNMRU1YMTlqcDJyYmV4Z0pNYUlKRUF4ODU3SkFpYW9YaDhmT0th?=
 =?utf-8?B?Tk9KZnZUWjRtSW5yM3dJYUJGbmRKOFcxRkRLNVI1ZmR3K1ZVWWlZajZLQ01E?=
 =?utf-8?B?VHVCaHA4YzQ2K1lVcjFLVmVrN1RqeTlXeU1iTkl3V1hib0MwUTc0azljb2ZM?=
 =?utf-8?B?cytqVHNIeElHRXRVcjZ2UmpvY2VSVEg4WG1vODBFRmE5ZjZxLzFDTGh5UzJU?=
 =?utf-8?B?THJwdnloZW5zY2JhT2ZpMlVPSEFPdk1GazVDRGE1RXA0dmVTbWZzeWZmVU1L?=
 =?utf-8?B?UzYvczFnUjl0V1lVditDMEpnbGJ5cnhCWHN3WDM1ekxKSHl0NHJJcUgxNEFN?=
 =?utf-8?B?SE9pUXYwS3hCWnVuaE9EMkJtVDFBTUI4M0dJWE4wY25xZkdqV0ZGM1JDbHBI?=
 =?utf-8?B?MGt0QXUxR1hSUkNXSURSL25XY0duRjlOeUZQWDMrc3BjeFBhVUdjeWw5SU1x?=
 =?utf-8?B?ZVJZRVQwWkJJS3VNNXpxdjFXUDRmZitWcmwwL1dLM1l6NDEyMVpUcDg5cDFR?=
 =?utf-8?B?SXdNM2xxc3N5TlUzZU53OVlLZHd3ZVNxRW5RMlEyRlV3VU5xZ2cwa2o2U2g3?=
 =?utf-8?B?ZklqY2x5MFZSRnVvZVpYUmIwdmlobnNlenFnQUxXZnMweXFyRHZuazY2WHB1?=
 =?utf-8?B?dEZRRzJXUnd1NGZaTzBkaUJaTXZLMm9MSGZPR20zYjZLd0NaWVovTTQ2aGpU?=
 =?utf-8?B?azRSU1ROdlVpYUdlZkVhRm16TFN0OUUyeW02enlYZW1aazZ6MHNVU1ZYMUhG?=
 =?utf-8?B?MlZSaHlGckgyTHJvM2QrZXZRbU96bXpJZGFhUXFNZzQyMStKQXZTaDZsRmg0?=
 =?utf-8?B?bEkyUWJUVklScE8yeXdJb0VNOTllcUl0andidnh1M3FRRTh5VnVoRDljc05M?=
 =?utf-8?B?RW51aUR0UHJNZGdCRjE4NGY0UnBZd0JqbnBOT2NqTnp2dUFsRGQ0UklPT1Mv?=
 =?utf-8?B?WWtQSWQzRXhvWStxbEtvYmY3U1VuY2pBRkxDOW8zV21sOEs2QklaSm9GL0Zi?=
 =?utf-8?B?ZGlYeGV4RFlVV0JNb0hoaVY3WXNPZXUwem43ZGdJTS9LVHNrR0RJRTZCcE5l?=
 =?utf-8?B?c1htaDVvZ2EyeEVTNXlpT2g3dGxGZ2wxQ3lQWkhkcDgxb0hWL0xJb1lTNHhL?=
 =?utf-8?B?NGJoMnBiRVlqVm5XdTBEWTlrZjZHNGxWbldXcGpZbnJ1V05xbnprRllZSGhL?=
 =?utf-8?B?QWxPTGNWU3RpTE1FZW1YcG0xdlJPUGJiWHlSZGY5YzliOVFwczdJYW9aVXlH?=
 =?utf-8?B?QXg4UDNONHB0VDVJbWtpZjZCMzIyUGhYblZWNWFEdFVZWDl6bURXMDBNWi83?=
 =?utf-8?B?UVBhV0k1bnBlYk9yb2hkOS8ydGkxdmpuTjJiUVhOQWNnMmZ0dG1FSENpMmdR?=
 =?utf-8?B?bFJYV0ZXQzI5dlEvRDZCZXdLaFNtRkd4em53cTBhek1EbStZa2V2VlJmdGtM?=
 =?utf-8?B?TDdlM212RVVkV2VPdDVTYnV2ekl0Y1plMUpNSC80UTVYRGFEdzhyakVoL1Br?=
 =?utf-8?B?a2pmREpYOUVReFp0dlJhUW5wUU1oRExlMHc0V2lGV285czhVcGw5VERURnhs?=
 =?utf-8?B?VlQyRlFnSTI4K0Q4TUVOenF1UVA2RkxUakF0VXFkSC9FMG1FZ0pmUXU2a0cw?=
 =?utf-8?B?VTNrMGhPMGVZYnl2aWRSWkczWEptaEZIUUM4dXBmNnB0RDRIa0RKY2hwQ2dW?=
 =?utf-8?Q?lxaeJw9OzongDFGGK35PiI34Mo4gUX4U?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q1F5RXJ1SWRON2FnWWc5V25zNFpFa2dUWjFnMlBTWHNiRWh5ajBmNEhUUkdp?=
 =?utf-8?B?bHovK1p3S01adnVremtoNUtZT3JXM3pPQVJZZkhYbUJqTW9jYjRRQjNSbE1n?=
 =?utf-8?B?Qm1rYkN0UDRPWXYxdkZQSDV3WXZRdWs4bTlCN0FGZDZhZEpMdTY5YWJWQUtp?=
 =?utf-8?B?SlFWc1E4NEo5TWZOTStiaG9wMHpMVi8vZnlFWGtISUhQRTM4YlV4clVXbEdl?=
 =?utf-8?B?Z0w2UkozdjhJejhJRmV2Y08xWElNd3JFSEkvN3grK0R6dUFCclZDNUhZVHhh?=
 =?utf-8?B?Y2UwNHpaRDNoNEhqaU1MSXVhZk40N3BwQjJxNmpqdGxOVXpUWDBBM2h1dktl?=
 =?utf-8?B?SEFEZnpsdTlvU0V4Mkc4VnV0elRhYlNRRVdjUEVDTm9ZM045dElJb3RkZFZU?=
 =?utf-8?B?TkxMdzc0WVRPaHFnOGtxQXYxMkJ6a0dhdEt0SWU0Vk1INlplZHVBeGN6Lzl1?=
 =?utf-8?B?NHpUWHJkQjMvMldPbFQzcnRpTjRsMTc4eW5iL2dRMGtSQ0NqRVBYaFJWYkVn?=
 =?utf-8?B?ZFBXOTgrR3ZSeDBjR0RKRkxWOVFpVHhTbmlCRHlJZy8xa1MvU2JZSTZaUG9C?=
 =?utf-8?B?SmU0SlIwUk5wZnZMeGJMTm9lZEttcGk1SUlObmVrMTZhQ0tvdVd2ekR0RzFY?=
 =?utf-8?B?c0R4aGhHK1E0TkR4eTllSnVwNmp0cXV6RmtnWkwwd3grS29wSVVYMXR5YWNa?=
 =?utf-8?B?dnhXelV2VUVKcTF6YmluYkxBcFpKRDkzU216SE10QWhsOW9VR3hoMzRLSFBv?=
 =?utf-8?B?c3lma2cxYmFINSsyK1pmais4Z0hYdS9tdkROTzhpY0VuRlJUVi9ZdFIzejVi?=
 =?utf-8?B?eVVmejBSM29oTEhibDNjUG5ncUZiQXVyUG9ibWd2bFBxWHFpbzZlcHk4Nklj?=
 =?utf-8?B?VlZwUHNXcVBZanpkZkpkNlcxclZiR2xqNHgzSHJSbDdaLytoZTVKUlg0bXY1?=
 =?utf-8?B?THRwK1lxSVNDNWM1a3p2TnZjMGRwUEFoM0JMUUFaOC8yT0FDdHc0S3pIdDZv?=
 =?utf-8?B?OTlSS3Z5RlVoQlhCVUJJTTFTcHhDN3QwQng4Rm5kUjFiaU04d0xoeUZVbmxq?=
 =?utf-8?B?UGJpUEhrWmdmVjRIUXg4VTBORWVaOSs5alEvakg1bk0xVzZWUExyT0Jja243?=
 =?utf-8?B?Zi9vQzRQTXY4VkpDcVpuUmVGWVJQV1F6YW1ZaXA3RWJ2NWdHQnZXTERNWStW?=
 =?utf-8?B?SzFsZy9KQ2l6cTZmNVhsaEJUazJzdlRSMUJ1dFgyS2lFVnZnZkhrRk9tNWpD?=
 =?utf-8?B?T3J5R3MxL21BaENZRVNETmRRZmpsaFVvREFqQUp4aUFoN0lrNkp0b2dWeWN2?=
 =?utf-8?B?Q2pyQlZLVjgvTE45bHRZWDlUY0trVCtHTFBOUGFrdk5ZMDNMblRMZzRvOXpa?=
 =?utf-8?B?TFB0aWJXY1p0U0lUcVNhaE02amphU1ZQUDU4QmN6c2JDUVpQTXBVaGZwRlRl?=
 =?utf-8?B?ZlNWWS9xYWZFQ2QrRU1uMzliZy9kZnV3RnFuRnJIRDF2bnQ1S3hGM2FDdE9D?=
 =?utf-8?B?Q3lOdmlwcDdUUk9UZVNwSmdjdHFnQ3I0SVE3cTVMM2loREJjVlJKaGFEZUg5?=
 =?utf-8?B?RzRKQ0ZHbWpPRWNHRGEzcGI0ZVhiNzNrL3FYYnlnK3gxTUhGTE1OWHlid0xX?=
 =?utf-8?B?M1BtSUhEWE1NZTJPWnBwOXlwS084eW8vbmxYUFJwTkR3MmpjcVZDbWJ5T3p0?=
 =?utf-8?B?R1JoUnprTFFXbGFMTGFFd2p5SFQzMU5Bcmp1NnhVYmhBK1kxaWs3d1BYaUFY?=
 =?utf-8?B?cWFIRTB0S3ppSjdjbXJ5K3NYOU1Zalgxa2F4eWhXUk5obkIraTVYK25qcHdD?=
 =?utf-8?B?eUEyemFUUlRRR2pUVHFVT2pENVJ0NEEwdGVEVG16eWovME5XSEFnKzZSZXBs?=
 =?utf-8?B?WldPd1JoME9hTkpUZnVjSmpFN0JxMmhvWGUwY3ZZUzNpQzZrL3RiQk5xenZi?=
 =?utf-8?B?N2ovZHYydkV4dEpZOXVWSjBFSmx3Z0FjYmYwZDZaSkxBYnNrdWdQa1hySUta?=
 =?utf-8?B?YU85b0xhZ3hrVHU1TVE3Yk5teWNsYVk3WVRwbGJrNkRPNlFSWk1PVU1haFlx?=
 =?utf-8?B?ZmRMNFo1N3RJeVBvV3ZGS2VJVVQ5Wm5zYVVzWSt4c2hGY2dOdFByRTRDWEpE?=
 =?utf-8?B?dkFSa1haclFpenluaGE4cXBmTC9mUnhpdVB5RjNVTWhWQzBuZGMyOUlKTS9o?=
 =?utf-8?B?UEZaZlBrYlFPdVY0ZjNLTFROU0JUVmdXc2pvRE5taHh5bU90TTlUcmc3WXVn?=
 =?utf-8?B?RmZGWGhoejY0anZOTDJwNnBaWTl3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47B9EFB7F246F645BF4E7DA5DB93440D@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4adbffca-4008-407e-bd21-08dd52ac8176
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 19:18:21.6201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HjXGZZFupQvRj1vDgys5Pf3O1FsLq5ATLiLX3DG6AmzOcOH8tPa+6263EujJjJW19kMs0cHjsq11WnXC1TSDRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR13MB6695

T24gRnJpLCAyMDI1LTAyLTIxIGF0IDEzOjQyIC0wNTAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
DQo+IEFsbCB0aGF0IHNhaWQsIEkgZG9uJ3Qgb2JqZWN0IHRvIHNvbWUgc29ydCBvZiBtZWNoYW5p
c20gdG8gdHVybiB0aGlzDQo+IG9uDQo+IG1vcmUgZ2xvYmFsbHksIHBhcnRpY3VsYXJseSBzaW5j
ZSB0aGF0IHdvdWxkIGFsbG93IHVzIHRvIHVzZSB0aGlzDQo+IHdpdGgNCj4gdjMgSS9PIGFzIHdl
bGwuDQoNClBlcnNvbmFsbHksIEkgdGhpbmsgYW4gZXhwb3J0IG9wdGlvbiB3b3VsZCBnaXZlIHRo
ZSBtb3N0IGZsZXhpYmlsaXR5Lg0KDQpUaGF0IHdvdWxkIGFsbG93IHRoZSBzeXNhZG1pbiB0bywg
Zm9yIGluc3RhbmNlLCBwdXQgYSBzZXQgb2YgbGlicmFyaWVzDQorIGV4ZWN1dGFibGVzIHRoYXQg
YXJlIHNoYXJlZCBieSBhbGwgY2xpZW50cyBvbiBvbmUgdm9sdW1lIHdoaWNoIGlzDQpleHBvcnRl
ZCBpbiB0aGUgbm9ybWFsIGZhc2hpb24uIFRoZW4gcHV0dGluZyBmaWxlcyB0aGF0IGFyZSB0eXBp
Y2FsbHkNCmp1c3QgYWNjZXNzZWQgYnkgYSBzaW5nbGUgY2xpZW50LCBvciB0aGF0IGFyZSB0b28g
aHVnZSB0byBmaXQgaW4gY2FjaGUNCm1lbW9yeSBvbiBhIHNlcGFyYXRlIHZvbHVtZSB0aGF0IGNv
dWxkIGJlIGV4cG9ydGVkIHdpdGggdGhlIG5ldyBvcHRpb24NCnNldC4NCg0KLS0gDQpUcm9uZCBN
eWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25k
Lm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

