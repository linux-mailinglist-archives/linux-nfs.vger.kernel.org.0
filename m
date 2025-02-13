Return-Path: <linux-nfs+bounces-10102-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2884CA34E3B
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 20:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E17EA7A302A
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 19:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAB3245B06;
	Thu, 13 Feb 2025 19:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="I1yFnSHy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2119.outbound.protection.outlook.com [40.107.236.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25978245011
	for <linux-nfs@vger.kernel.org>; Thu, 13 Feb 2025 19:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739473932; cv=fail; b=XoM5G+kd/eLhb0dQ/7C5D4T95kBp+fwYrNpWxYQB64eB/SbXtdONx1bTPXLUaHj5G7UaT9iOXVVoVhQSAJWK8M5EjBFGZDj2Ybui5VB2Sej0GgFzXLioh8WjVd02wAMDAaZ40H/iwnjUQEqGGv/qv89tic5NdL/V2TVCKNNAFYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739473932; c=relaxed/simple;
	bh=JuosyrpWZv4tkv4e97OYR1hhk6JzAVtWgqmrVhIorH0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cdtd4Het4B4qdfQs4tAcfHeroXmc+XSSkz8FvXTwc7pf7qs7q8IUt7KlwwGgSfAsovWIjEx9RgZ6nsjlYA3xQSTuyrVjOE+q7ikGLVkRpmKxIZGgiUGIz2dRUobVTrSnoO35Kn/A9SV+nkJWG64M1X7U8K1Z02kDR8JsjuOFvmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=I1yFnSHy; arc=fail smtp.client-ip=40.107.236.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WO/CE3FJypN/qYfkMOvgVaE89x/EoZoI3IRCbcHf0LKlZwYEeuUrGgdlPgIjO519UqBQN/0p580DLSG0YvcS4key7MnrN8QGg7oYhthEcwEmtT3aXZXSLJYcVyTN95wnsJ0C/onerxk/8uR0XfB6S8EV4bKS1MtzU/wcG9FYbaYuvHyx54LSgWe2G1Y5mzaDoufDTddILo1qe87k1yCBQTsmbtpuah4tQcsR4uiM54xgNBFbOUzhIUM6A3GjB18x+ADvF68x/qVAnk1V1RDS75Yiv7rw3+HThkOa3ZXUdQVn9IXxAKK1DRzXqRhvo5/SVPp0Jrc93WM2V1vlQaByPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JuosyrpWZv4tkv4e97OYR1hhk6JzAVtWgqmrVhIorH0=;
 b=fEIN9drZzdd3bZUMDSqhiQ9ulZGY5H0Ai7cNv29+XuYnb+yTu2rpySZTdH0+g5mIAbH0iwg9vtvwBt7cJgaPLe35gqWsVoPXq7he/f9Ge686qlcTQbEmITAkFjvqky09Vnl907DZwF10qX6kY7gvOACCeYlLaLv/r2krynu3S7Vzz/+E739CKnolmGM+sKh3DKV6sLIWuYfQG0zpeUyAtHxs13RPc3GBIBE76i4rdF7NYCNwOhiT57yv9Q8DHinGktixtMlv6Nhn2qT0c3VHB9tQ3+XI7UBBkosprsUKVcDxpHhhY1UseVBN1YwfDsKpZ49jlI0+EfksEPcqBwqQ5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuosyrpWZv4tkv4e97OYR1hhk6JzAVtWgqmrVhIorH0=;
 b=I1yFnSHy9CHOvZ3YfH/6HUkuS3v30IE7H0Kr/IyRdkFhjTp9rasceG7F4BAIsjMUe0RHNUpfibWkuNqBx3D7D7SuPq5FZ/laQ9ToFbv67UilmBRGrVz6irI+6n6PNykEV0Fi9vHKAcA70M/2yES/dF+Q2F6/Ku217VJLmokvnJ8=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by PH0PR13MB4908.namprd13.prod.outlook.com (2603:10b6:510:7b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 13 Feb
 2025 19:12:05 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%3]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 19:12:05 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "aglo@umich.edu" <aglo@umich.edu>, "chuck.lever@oracle.com"
	<chuck.lever@oracle.com>
CC: "okorniev@redhat.com" <okorniev@redhat.com>, "cel@kernel.org"
	<cel@kernel.org>, "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [RFC PATCH] NFS: CB_OFFLOAD should return DELAY when no copy
 state ID matches
Thread-Topic: [RFC PATCH] NFS: CB_OFFLOAD should return DELAY when no copy
 state ID matches
Thread-Index:
 AQHbfjOM2qaXtGaATkKgNd/ysX5erbNFc3UAgAAQcYCAAA5GAIAAAMoAgAAAh4CAAAZxAA==
Date: Thu, 13 Feb 2025 19:12:05 +0000
Message-ID: <97b5cedd798448c57e21ac499f0d9be551341002.camel@hammerspace.com>
References: <20250213161555.4914-1-cel@kernel.org>
		 <df999d533683548ba91b69b017bf2b4acc0add52.camel@hammerspace.com>
		 <CAN-5tyGt4OhqZbzzADe9OumbaThrefZ1nTw=_wrrxy7FWfWK9A@mail.gmail.com>
		 <18421def0a2aa132a6817b56f97eb9d6f3928727.camel@hammerspace.com>
		 <12784b78-d053-46f6-b0e3-e81ca2e90269@oracle.com>
	 <db7103ddc9ab031dccf0807456c09e5297179fc9.camel@hammerspace.com>
In-Reply-To: <db7103ddc9ab031dccf0807456c09e5297179fc9.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|PH0PR13MB4908:EE_
x-ms-office365-filtering-correlation-id: 927643c1-11bb-4766-9d3b-08dd4c624db2
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZzVlYzFuYWEvL0EwUjhqSXN1Mkl0UjdhS3RaU2NXa051VmxhVFVTVktKejNV?=
 =?utf-8?B?RXpEU2xOSFV1TEJWNHI0bFJqU1FYeWx1eEJ5bEh1bDh1VllEWHRXVThVZW5y?=
 =?utf-8?B?TzcxdFZoNDBEUVRXNWo5UkM3ekVZa2MzU1FSZkQ0emJBMzA3azJkcTMwRTZk?=
 =?utf-8?B?UFNaNUg3RzdFUzViK0JaVlpJUzl0NUorRkZidDVMNFhrSkV4NFdkRVpsOE1X?=
 =?utf-8?B?ZTArSzROUkdSNVZEUWl4RWx6NkpvbVMwVDBobUhUZVppTzAzdWxTQmVEQS9s?=
 =?utf-8?B?S1d0emRpNERza2FCTVN2NEk0aVdOaTJNUktjZlRLaVB6WHRhU1BTMlZ1LzNz?=
 =?utf-8?B?cWpSTEw5OU03Y3BkTC9XWFJOWGtOdXA4K3lrYVFNM2UrcTlzV2o1ZDBzSkpj?=
 =?utf-8?B?R2hUTEVEWDF2cUtzU2M0OWtSeUxFNGFBTnVBczYxZlpCODl2U0FXVE1WWXNK?=
 =?utf-8?B?K2txeitBKzN4MHBFUFBvbmUvZmNWbVBYRnN0bGJJR2JibExZTnQ4Sm1KbHlO?=
 =?utf-8?B?VGIzTGF3Wjg3OGNxYzUvS2NJQWduWWpkMWFoa044YkJaMjlaS3hESng2cnF4?=
 =?utf-8?B?SStsSnVuWXZSWCs1YUpZZ1hoWEF1MWdTK29XaDNRNnVIcTJ0SCtFRi9BK1o3?=
 =?utf-8?B?dnBMcFNiMCtySmp6Snh6MStCNm1GbnJlTUJJSklHS1NHaFI0VVVGSjdZYnV1?=
 =?utf-8?B?WGxIQk9FRStEL2lHd3VURWwyUmczNDdFR0FtbHJSQ3FIVEtEbkhEaTZZaFFZ?=
 =?utf-8?B?RjJVcWQ2YVNyQWl6bTRBMTRDY3FmWGhLTG8rRXdibXQ5NkduU2VVM3dDeWVU?=
 =?utf-8?B?WEJDOEZWZ2FOcC9TUkhSa0J6c1BQeVBMcG1tbWRwNytKaUx3U0hhMUpHQTZv?=
 =?utf-8?B?c0t1QU94TGFkV3ZvUGdNcm9uZFU0M1Zkb0ZQTU9nSE9pOFhHSitUdEtUZ1pn?=
 =?utf-8?B?TVJSTlJ0ckk3ZjlTT2hOWFFvK2l3V0xaNC9NdjF0blhCMlZ5ZWVIc0cwSDZD?=
 =?utf-8?B?S25sNHNHYVpEcWdBWFY0Q2ZMMjRyb3lxSmF4MVZuNndsUXZpSDJEU3l4NURH?=
 =?utf-8?B?WEJiaHZmZm5XN2FlYU9NN1ZLZGZiUEc1RW9lWC8rbmZaaG9acjlxckpnL09D?=
 =?utf-8?B?U2VldFdjMmNtSzVnWW5jK3lCalQ4dzR0VWZlSWMzeG5HVVZYeG1QTVduQnU0?=
 =?utf-8?B?Qm5jWHplZDRxZzhqUWlDdllweHhVc3h6MFF3ckpTWFpwQlpYYzZQbEJTSG9W?=
 =?utf-8?B?M0NETFVrL293a1lCQXBPTVByZDBuRXladTJXSzFxTXpPNm5zemI1VStqTDZU?=
 =?utf-8?B?WjF4dENlTjA5ZHlWYTEzRjNqQVZnTHBQZ05KVlZQa1ZuczRBQW9wL1dXaXdr?=
 =?utf-8?B?Z24wYTJ3WDE1ZGR4djdSVVc3RTBQcE5ubU10ekxVaytucU9PSFNwMnZxMk4y?=
 =?utf-8?B?TWR0YmxFN2VUTU9LcWdvdE04Q1dick4zVUxXK2oxWHl4Q1lzUmM3MWtMeTVX?=
 =?utf-8?B?aGRIbXdHQUcxQ1Z2dVBoZzQ1cHZLME5sS1B1NjZRVXdCV09kdG9qdmdYL0dp?=
 =?utf-8?B?ZllPTEQzZzFiTnZXbVNBVEEySVpjalNBSkdRZmNxOGZJUkoxZHIxUlVtSUR0?=
 =?utf-8?B?eXVQem40Nm5sbSswYzNDaFpDTkZzNjhTUDFiTkF3bmdQZzJXWFgwendxYmRi?=
 =?utf-8?B?NDlpUk1wWlVOL1FVeFgzeWhMNkRjRU00ODlHeWFUejU4VmdCSUQ5cVlLbkN6?=
 =?utf-8?B?NkZ6dmF1VWY0dURKdjhNVlpQTDEzSU1JYm1maEZtam41NmlQN2NLMis5QTBQ?=
 =?utf-8?B?TXRWa1JVQS9ycVd5bFJMSjYwZVBrNVdhVURIODVUM2pkMDM2ak9mOXZqdkNX?=
 =?utf-8?B?R1NyZFZqV2VDTE11S1VHTFg2bkROWUVxU2oyTFZTYWxNRGlGUEJqaUJNc3NU?=
 =?utf-8?Q?xVQRhT0KLNggdtZT8S3i3/pZsaYMW/ah?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VlFNR044Wm1jQnRMM2djekppaXFyYmtFTE1uMHdGek10bmhBdElGQkcrYXA2?=
 =?utf-8?B?dWYvaVZqUkN5cG9EOTZVMzdOT2RaV0dGZUVLcVNrSG4xQzVVNlNwcnhWdjFV?=
 =?utf-8?B?bnZWQjVPTWpuejBmV1Ntdlo0MUhMRStZeU12RUtZcUFnSmVBWXliWitnUXg5?=
 =?utf-8?B?a2N6Q2Y0eXg2L0Y1NmZMM04rZ3BOQk5UbllOaHY1SERmdVd5a096d1ZJajU2?=
 =?utf-8?B?VG9Wc3NkNEZPVXZUQ0VkWWRPellwTnlSYVdEODZjUktCSW83NnkxMHE1elNo?=
 =?utf-8?B?SGVhazFxL1hVT01TcTRuSlVHNHA4aWRrUWJ2YXBIYWd4dkRJcjhaTUxiWit5?=
 =?utf-8?B?a1lwVEUyQUFHVkFSOUlFdnU3NUVJTDZ0TnU0dTBiRGZuTXJUQkdodmFDUUY0?=
 =?utf-8?B?NU5LNVFIb1BIbjlvSWZuQ2loL3FQY1BVQkhhRjJ5aTJPNVJkaGRueDdvVXM3?=
 =?utf-8?B?MFJPaGh6S1M5WVhxOHhsVTc5SlBNcyttcnFGd0lKMVZnTFBudkMrYU9vTzJh?=
 =?utf-8?B?b0xoRXU0L09Pb29hQXVFdnJPR0wzM1NnQ1ZFb0M1S2d2UDFUR0hYMWhUandu?=
 =?utf-8?B?aFM4eE5CZHpjSmdGemR0Y1IwZmhZbHh6YWdmcjVkZkNHUVJrT3lMMGlhRk1n?=
 =?utf-8?B?RzlpU1BlTzRpMkxSRU9vKzJ4YkxCelBSN0d5QWJCbXFwclpYTlkxM3ZuQkk5?=
 =?utf-8?B?L1pkV0FPTkhoQytXTWtRNUo5SXpPRGZNcHhHK0M0THZoa3hzVjZxZ3VvVWZ1?=
 =?utf-8?B?UHMycGVsY0F5eHJiRStBdmtYRXJ3STJKYXRPSmc1dDBOb3JPYWF2a1lER0hV?=
 =?utf-8?B?MktpcWhLS2VrZ3FPWVRsMXFGaTZ3S3ZTSmptejkrWDdZK1VmaWd4amdFemcy?=
 =?utf-8?B?ME85VlFZUzFXbzR6RWNXcnJ5RlJCQVRmUUU3WmVLT3QrSTZyN1gvMXAxS0l4?=
 =?utf-8?B?R2dlWlJ1SzBRczRTbU1iQklxLzRWZ3ZPOVJuRUl2dmp0MXNNdGY1WFlEeHd0?=
 =?utf-8?B?bElhY0w4cnovSCtFN3pYQjNSSjZQZnZOQkk3TXhRR0JJTlRiZlY4UkpzY2RV?=
 =?utf-8?B?S3M2cWVJUmNTcHo0TTkyWEdQZnNoanhoN3VUalJZZldvRW1PbEdZaXcxMVpv?=
 =?utf-8?B?UzRCRDlSLzU2S0ZFTWJia1lvM2llVXlpK21wQ21DZ3ordTRDMGFSZjQ0SXlQ?=
 =?utf-8?B?SVhuZWkzdzZPTzFTNytpbWw3MVRRZ2VVN011LzJ6MjZWQlpZTjIvSjk1MlBH?=
 =?utf-8?B?WEJFbzlFak5YUjBaM0VKL1M1eXFUdnZsUzRybFRsQVdtRXUwUkE1QTg4UHEy?=
 =?utf-8?B?djYwL1h4a1VQQzY4MGlnMExLMjdKZ0RRcUh6V2xxZ1JHNGVMd1Z2ZFVJVDc0?=
 =?utf-8?B?TnVBMjFraWVqVnpPMit1Q0hFT0FYZG00Z080Rkl6ZFQyWnRBTGluTDRPQll0?=
 =?utf-8?B?SENnMEsxdXNUMGVIa0N2R3VIc3FMYUhzeTdrbmx4MXp6dTVURXlIR3FPOUtl?=
 =?utf-8?B?d21vZkk1eC9mZFc1K3p3T2tEdDFaanlYekdiMjhiZzVXUXFIaHFhWnpVODUw?=
 =?utf-8?B?UW10MXBwdC83R2RoY0RLYkRSR2sxRDlOWm5JNVR3TDNWY2FPaS93ajlWeG11?=
 =?utf-8?B?cDZkL2wwR1ZHU0xudzFYVHFPYjk0RVRFWHVIekxxV1IrVzNpNWswc0xPQ2pj?=
 =?utf-8?B?NC9uRGlhbm5DV09udTZ2cDZGR3RaMVdkNFBnbE96bFplTjRTeWtkUUZCcTBG?=
 =?utf-8?B?Nzc0eDBaMU1jb1VmTU9hVG10Z3hCQVdEclR3VjEvVlRvWGp5cUlIL2VxaURu?=
 =?utf-8?B?NWxhTkVhUGM2UWVFOW1uOFdENkNwOFZhemFNZ2ZJaEZrUVJnYmZEdG5UTHFZ?=
 =?utf-8?B?blVCQy9ka3FTYXpweDlxSGE5TFN2SWlhVE1xSi9nc1NnZjJ3OHhnbEJXN21Q?=
 =?utf-8?B?ZXgxOHp6ZjBvWlhUOGErdzZiS1RPSTl6WlpwOWs2UkhSQjVCRmsyek1XVFkz?=
 =?utf-8?B?SU9BOXJSR2ZJcFFMYmVQdzdLbHZNWlQyQjV6TEZMK1VhcmYveWtnU3VBS1VI?=
 =?utf-8?B?VnJ1WHB5d1JhSGxDQjZ0MlU5SjVYU1RSNUNFSEd0Z2VXVVMzNHNkaDFUeVdN?=
 =?utf-8?B?YjF4dGQ0Uk1mUlNPSUgwbysvK2RXTkJrU1I3ZGhtRUV5c0tFbFI5LzViU2s4?=
 =?utf-8?B?bXdvbVVraDdJYmJRZm11SittSG5DWm1tVk5ycmJqdDBBN2duc2ZNekQyQnJD?=
 =?utf-8?B?Vk5EVi9zVkpOeHg4TDZ5Y3RLbjF3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F54AD0B7FEB18149B34E28077651D475@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 927643c1-11bb-4766-9d3b-08dd4c624db2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 19:12:05.0192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NRFKhvtaxxWXWzgtebLJxo1xNfkgJ8Y5UCzsDcQea1QYLpNgSF8ZAmohAT6M1EvLNJAB8ayKo48rExbwByXZNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB4908

T24gVGh1LCAyMDI1LTAyLTEzIGF0IDE4OjQ5ICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+IE9uIFRodSwgMjAyNS0wMi0xMyBhdCAxMzo0NyAtMDUwMCwgQ2h1Y2sgTGV2ZXIgd3JvdGU6
DQo+ID4gT24gMi8xMy8yNSAxOjQ0IFBNLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6DQo+ID4gPiBP
biBUaHUsIDIwMjUtMDItMTMgYXQgMTI6NTMgLTA1MDAsIE9sZ2EgS29ybmlldnNrYWlhIHdyb3Rl
Og0KPiA+ID4gPiBPbiBUaHUsIEZlYiAxMywgMjAyNSBhdCAxMTo1OeKAr0FNIFRyb25kIE15a2xl
YnVzdA0KPiA+ID4gPiA8dHJvbmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiA+ID4gPiA+
IA0KPiA+ID4gPiA+IE9uIFRodSwgMjAyNS0wMi0xMyBhdCAxMToxNSAtMDUwMCwgY2VsQGtlcm5l
bC5vcmfCoHdyb3RlOg0KPiA+ID4gPiA+ID4gRnJvbTogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVy
QG9yYWNsZS5jb20+DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFRoZSBORlN2NC4yIHByb3Rv
Y29sIHJlcXVpcmVzIHRoYXQgYSBjbGllbnQgbWF0Y2ggYQ0KPiA+ID4gPiA+ID4gQ0JfT0ZGTE9B
RA0KPiA+ID4gPiA+ID4gY2FsbGJhY2sgdG8gYSBDT1BZIHJlcGx5IGNvbnRhaW5pbmcgdGhlIHNh
bWUgY29weSBzdGF0ZSBJRC4NCj4gPiA+ID4gPiA+IEhvd2V2ZXIsDQo+ID4gPiA+ID4gPiBpdCdz
IHBvc3NpYmxlIHRoYXQgdGhlIG9yZGVyIG9mIHRoZSBjYWxsYmFjayBhbmQgcmVwbHkNCj4gPiA+
ID4gPiA+IHByb2Nlc3NpbmcNCj4gPiA+ID4gPiA+IG9uDQo+ID4gPiA+ID4gPiB0aGUgY2xpZW50
IGNhbiBjYXVzZSB0aGUgQ0JfT0ZGTE9BRCB0byBiZSByZWNlaXZlZCBhbmQNCj4gPiA+ID4gPiA+
IHByb2Nlc3NlZA0KPiA+ID4gPiA+ID4gL2JlZm9yZS8gdGhlIGNsaWVudCBoYXMgZGVhbHQgd2l0
aCB0aGUgQ09QWSByZXBseS4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gQ3VycmVudGx5LCBp
biB0aGlzIGNhc2UsIHRoZSBMaW51eCBORlMgY2xpZW50IHdpbGwgcXVldWUgYQ0KPiA+ID4gPiA+
ID4gZnJlc2gNCj4gPiA+ID4gPiA+IHN0cnVjdCBuZnM0X2NvcHlfc3RhdGUgaW4gdGhlIENCX09G
RkxPQUQgaGFuZGxlci4NCj4gPiA+ID4gPiA+IGhhbmRsZV9hc3luY19jb3B5KCkgdGhlbiBjaGVj
a3MgZm9yIGEgbWF0Y2hpbmcNCj4gPiA+ID4gPiA+IG5mczRfY29weV9zdGF0ZQ0KPiA+ID4gPiA+
ID4gYmVmb3JlIHNldHRsaW5nIGRvd24gdG8gd2FpdCBmb3IgYSBDQl9PRkZMT0FEIHJlcGx5Lg0K
PiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBCdXQgaXQgd291bGQgYmUgc2ltcGxlciBmb3IgdGhl
IGNsaWVudCdzIGNhbGxiYWNrIHNlcnZpY2UNCj4gPiA+ID4gPiA+IHRvDQo+ID4gPiA+ID4gPiBy
ZXNwb25kDQo+ID4gPiA+ID4gPiB0byBzdWNoIGEgQ0JfT0ZGTE9BRCB3aXRoICJJJ20gbm90IHJl
YWR5IHlldCIgYW5kIGhhdmUgdGhlDQo+ID4gPiA+ID4gPiBzZXJ2ZXINCj4gPiA+ID4gPiA+IHNl
bmQgdGhlIENCX09GRkxPQUQgYWdhaW4gbGF0ZXIuIFRoaXMgYXZvaWRzIHRoZSBuZWVkIGZvcg0K
PiA+ID4gPiA+ID4gdGhlDQo+ID4gPiA+ID4gPiBjbGllbnQncyBDQl9PRkZMT0FEIHByb2Nlc3Np
bmcgdG8gYWxsb2NhdGUgYW4gZXh0cmEgc3RydWN0DQo+ID4gPiA+ID4gPiBuZnM0X2NvcHlfc3Rh
dGUgLS0gaW4gbW9zdCBjYXNlcyB0aGF0IGFsbG9jYXRpb24gd2lsbCBiZQ0KPiA+ID4gPiA+ID4g
dG9zc2VkDQo+ID4gPiA+ID4gPiBpbW1lZGlhdGVseSwgYW5kIGl0J3Mgb25lIGxlc3MgbWVtb3J5
IGFsbG9jYXRpb24gdGhhdCB3ZQ0KPiA+ID4gPiA+ID4gaGF2ZQ0KPiA+ID4gPiA+ID4gdG8NCj4g
PiA+ID4gPiA+IHdvcnJ5IGFib3V0IGFjY2lkZW50YWxseSBsZWFraW5nIG9yIGFjY3VtdWxhdGlu
ZyBvdmVyIHRpbWUuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gV2h5IGNhbid0IHRoZSBzZXJ2ZXIg
anVzdCBmaWxsIGFuIGFwcHJvcHJpYXRlIGVudHJ5IGZvcg0KPiA+ID4gPiA+IGNzYV9yZWZlcnJp
bmdfY2FsbF9saXN0czw+IGluIHRoZSBDQl9TRVFVRU5DRSBvcGVyYXRpb24gZm9yDQo+ID4gPiA+
ID4gdGhlDQo+ID4gPiA+ID4gQ0JfT0ZGTE9BRCBjYWxsYmFjaz8gVGhhdCdzIHRoZSBtZWNoYW5p
c20gdGhhdCBpcyBpbnRlbmRlZCB0bw0KPiA+ID4gPiA+IGJlDQo+ID4gPiA+ID4gdXNlZA0KPiA+
ID4gPiA+IHRvIGF2b2lkIHRoZSBhYm92ZSBraW5kIG9mIHJhY2UuDQo+ID4gPiA+IA0KPiA+ID4g
PiBMZXQncyBzYXkgdGhlIGxpbnV4IHNlcnZlciBkb2VzIGltcGxlbWVudCB0aGUgbGlzdCBidXQg
d2hhdA0KPiA+ID4gPiBhYm91dA0KPiA+ID4gPiBvdGhlciBpbXBsZW1lbnRhdGlvbnMgdGhhdCB3
aWxsIG5vdC4gVGhlIGNsaWVudCBzdGlsbCBuZWVkcyBhbg0KPiA+ID4gPiBhcHByb2FjaCB0byBo
YW5kbGUgQ0JfT0ZGTE9BRC9DT1BZIHJlcGx5Lg0KPiA+ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiBU
aGVyZSBhcmUgc2V2ZXJhbCBjYXNlcyB0aGF0IG5lZWQgdG8gYmUgaGFuZGxlZC4gT2ZmIHRoZSB0
b3Agb2YNCj4gPiA+IG15DQo+ID4gPiBoZWFkOg0KPiA+ID4gwqDCoCAxLiBUaGUgcmVwbHkgdG8g
Q09QWSBoYXNuJ3QgeWV0IGJlZW4gcHJvY2Vzc2VkLg0KPiA+ID4gwqDCoCAyLiBUaGUgQ09QWSBp
cyBjb21wbGV0ZSwgYW5kIHRoZSBzdGF0ZSBoYXMgYmVlbiBmb3Jnb3R0ZW4uDQo+ID4gPiDCoMKg
IDMuIFRoZSBzdGF0ZWlkIHByZXNlbnRlZCBieSBDQl9PRkZMT0FEIGlzIG9uZSB0aGF0IHdhcyBy
ZXVzZWQNCj4gPiA+IGZvciBhDQo+ID4gPiDCoMKgwqDCoMKgIHNlY29uZCBDT1BZIHJlcXVlc3Qg
YWZ0ZXIgYSBwcmV2aW91cyBvbmUgY29tcGxldGVkLg0KPiA+ID4gDQo+ID4gPiBUaGUgY2xpZW50
IHdpbGwgd2FudCB0byBzZW5kIGRpZmZlcmVudCBlcnJvcnMgZm9yIGVpdGhlciBjYXNlDQo+ID4g
PiAoTkZTNEVSUl9ERUxBWSBpbiB0aGUgZmlyc3QgYW5kIHRoaXJkIGNhc2UsIE5GUzRFUlJfQkFE
X1NUQVRFSUQNCj4gPiA+IGluDQo+ID4gPiB0aGUNCj4gPiA+IHNlY29uZCkuDQo+ID4gPiBXaXRo
IGNzYV9yZWZlcnJpbmdfY2FsbF9saXN0czw+LCB0aGUgY2xpZW50IGNhbiBlYXNpbHkNCj4gPiA+
IGRpc3Rpbmd1aXNoDQo+ID4gPiBiZXR3ZWVuIHRoZSBjYXNlcyBhbmQgcmV0dXJuIHRoZSByaWdo
dCByZXNwb25zZS4gV2l0aG91dCBpdCwgdGhlDQo+ID4gPiBjbGllbnQNCj4gPiA+IG1pZ2h0IGVu
ZCB1cCByZXR1cm5pbmcgTkZTNEVSUl9CQURfU1RBVEVJRCBpbiBjYXNlIDMsIG9yDQo+ID4gPiBO
RlM0RVJSX0RFTEFZDQo+ID4gPiBpbiBjYXNlIDIsIGV0Yy4uLg0KPiA+ID4gDQo+ID4gPiBTbyBp
biBwcmFjdGljZSwgd2Ugd2FudCBhbGwgc2VydmVycyB0byBkbyB0aGUgcmlnaHQgdGhpbmcgaWYg
dGhleQ0KPiA+ID4gd2FudA0KPiA+ID4gdG8gYXZvaWQgY29uZnVzaW9uIG92ZXIgc3RhdGUuIFRo
ZSBjbGllbnQgY2FuJ3QgZml4IHRoZXNlIHJhY2VzDQo+ID4gPiBvbg0KPiA+ID4gaXRzDQo+ID4g
PiBvd24uDQo+ID4gPiANCj4gPiANCj4gPiBXZSBhcmUgY3VycmVudGx5IGxpdmluZyBpbiBhIHdv
cmxkIHdoZXJlIGFsbCBORlNELWJhc2VkIHNlcnZlcnMgZG8NCj4gPiBub3QNCj4gPiByZXR1cm4g
cmVmZXJyaW5nIGNhbGxzLiBJIHRoaW5rIHdlIG5lZWQgdG8gdW5kZXJzdGFuZCB3aGF0IHRoZQ0K
PiA+IGNsaWVudA0KPiA+IHNob3VsZCBkbyBpbiB0aG9zZSBjYXNlcy4NCj4gDQo+IA0KPiBNeSBh
bnN3ZXIgaXM6IG5vdCB0cnkgdG8gZml4IHRoYXQgd2hpY2ggY2Fubm90IGJlIGZpeGVkLg0KPiA+
IA0KDQpQdXQgZGlmZmVyZW50bHk6IGl0IGlzIGEgbG90IGVhc2llciB0byBqdXN0IGltcGxlbWVu
dCB0aGlzIHByb3Blcmx5IG9uDQp0aGUgc2VydmVyIGluc3RlYWQgb2YgZG9pbmcgYSBsb2FkIG9m
IGNvbnRvcnRpb25zIG9uIHRoZSBjbGllbnQuDQoNCkFsbCB0aGF0IG5lZWRzIHRvIGJlIGRvbmUg
aXMgdG8gc3RvcmUgMyBleHRyYSBwaWVjZXMgb2YgaW5mb3JtYXRpb24NCndoZW4geW91IGNyZWF0
ZSB0aGUgc3RhdGVpZCAodGhlIHNlc3Npb24gaWQsIHNsb3QgaWQgYW5kIHNlcXVlbmNlIGlkDQpm
b3IgdGhlIG9wZXJhdGlvbiB0aGF0IGNyZWF0ZWQgdGhlIHN0YXRlaWQsIGkuZS4gMjQgYnl0ZXMg
b2YNCmluZm9ybWF0aW9uKS4gV2hlbiB5b3UgdXBkYXRlIHRoZSBzdGF0ZWlkLCB5b3UgYWxzbyBy
ZXBsYWNlIHRoZSBzdG9yZWQNCmV4dHJhIGluZm9ybWF0aW9uIHdpdGggdGhlIG5ldyBzZXNzaW9u
IGlkLCBzbG90IGlkIGFuZCBzZXF1ZW5jZSBpZCBmb3INCnRoZSBvcGVyYXRpb24gdGhhdCBjYXVz
ZWQgdGhlIHN0YXRlaWQncyBzZXF1ZW5jZSBudW1iZXIgdG8gYmUgYnVtcGVkLg0KDQpUaGVuIGlu
IHRoZSBDQl9PRkZMT0FEIGNhbGxiYWNrLCB3aGVuIHlvdSBsb29rIHVwIHRoZSBzdGF0ZWlkLCB5
b3UgYWxzbw0KbG9vayB1cCB0aGUgMyBzdG9yZWQgdmFsdWVzIGFuZCBwdXQgdGhlbSBpbiB0aGUg
Q0JfU0VRVUVOQ0Ugb3AuIFRoYXQncw0KbGl0ZXJhbGx5IGFsbCB0aGF0IGlzIG5lZWRlZCBmb3Ig
dGhlIGNsaWVudCB0byBiZSBhYmxlIHRvIGZpZ3VyZSBvdXQNCnRoZSBvcmRlciBpbiB3aGljaCBp
dCBuZWVkcyB0byBwcm9jZXNzIHRoZSBvcGVyYXRpb25zLg0KDQotLSANClRyb25kIE15a2xlYnVz
dA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVi
dXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

