Return-Path: <linux-nfs+bounces-4002-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C6390DC6E
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 21:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7668BB2133C
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 19:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CEA17997;
	Tue, 18 Jun 2024 19:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="KPf2LKLW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2116.outbound.protection.outlook.com [40.107.236.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A96158DB9
	for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 19:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718739001; cv=fail; b=BQ86ZJhIyLdQrvWB9kZoOZEBEYIl5kEY0okgbDjTBdNCGq+oFM/Th49w70gOtU9oyM2hvROGbPrxoBPe9Xn2FviHyybWAswlf2l2JIUMEhUnInJDf7U/iAsF58xocPozFjOO0v7NI0FfFjU0AFG9SPEecjPOKECw1Vh4TGj/zTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718739001; c=relaxed/simple;
	bh=oQp3GxLeFO/dtK6uGCXURzuow8TJelMg5MhRKrX++OI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=asQl+fe8f5cJ+ncpEbOzZF24NLL4scsrgR3BfFzURs1oqkP0NrKINv2Vr8kraGCBcHYsIOomAEYaorLHyXue68NZk83bMOOfxp3AAVjDlPZASBu4cg5QPOt2eypjv8azlYIGVOd+AF9+v3W5bHDvBipgZdJSgeKflx75itZFskA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=KPf2LKLW; arc=fail smtp.client-ip=40.107.236.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gdve7xnQZb+3tHlo2U/khGXwxm5QqVrrgxlzpgX/q4lWLO0dM20xr7QZ88OAJfBBt/OE9h6WOHDc6bxPv96SimJvYsYOLqbDfr/0C4lUhVGWTIBJn72l88/4vJP8O1ardTEiTJYWeYTA2z8q9DT5hHJX/5SHjvckhvJRqTt0yXtIFrjJMVYwpc5odAnzeiEXLZ9rNaj/gBDGHEg/1aP1BMlq4d/cGgEJqv9ILl/OlYg2moj4ijnYOa126Z/uhmUZEa4gLm+XoeCv8kTmunYqBjsTvN2b/JnQj56GGU/BcR8cQaMO9WIzz6WNf6qBh7NAAceq7rG2M/YJ0Xlm+h3UxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQp3GxLeFO/dtK6uGCXURzuow8TJelMg5MhRKrX++OI=;
 b=h2TLhXPc5pJYdR90tTjo95McJh1T7W+AX9odnb1S9wd1+m0yrwyarYUYikTLIxiUOPioWMSq1jQDfJ/pxU1TVKdygoIz/zu/kyptraSjSo8ZI+xLwZIzzGsv+AGzdOidPmayZgqzj3ch2elW9VN2kYjhuwyQpVti6WY3wZdaW3Y50KoZwm6HSGgdlci8GklBUNyp9h436iog6V6XBYjrpOiNe1b+FMK5OwSvmTMeAIm33+DYX0HRz2eyZNjUGmDTe2lpfyz57N0GRu5Yd/vhXQImEUGqWx0qariGwDMJnlKUCrJ6Pb36kllKnA9Qsb2p8tx/LfcCUrSrK4uOrvtrPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQp3GxLeFO/dtK6uGCXURzuow8TJelMg5MhRKrX++OI=;
 b=KPf2LKLW1wB3OtNU8DxXq314RSQBkR8JlkJrivlYGfLVYQF4ZIDU5lVdjXSwQoT9IHG7bt36JqXscJxFduxvyO4IfUJ835dUpAfDE2iCt/AlUNzp18APvZdT37NEYaTVc5HWEQYzYByWOY240sjzN2avMwmcLzvPUnBg5ATzBbU=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BL3PR13MB5090.namprd13.prod.outlook.com (2603:10b6:208:33d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Tue, 18 Jun
 2024 19:29:55 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%6]) with mapi id 15.20.7698.017; Tue, 18 Jun 2024
 19:29:55 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"jlayton@kernel.org" <jlayton@kernel.org>, "neilb@suse.com" <neilb@suse.com>
Subject: Re: knfsd performance
Thread-Topic: knfsd performance
Thread-Index: AQHawa3dybcUo3ed40e1woBUDQls6LHN2rIAgAANu4A=
Date: Tue, 18 Jun 2024 19:29:55 +0000
Message-ID: <754f3e0f6f962cbd46b2b22e87d9de9f8b285ab4.camel@hammerspace.com>
References: <313d317dc0ca136de106979add5695ef5e2101e7.camel@hammerspace.com>
	 <58A84B36-C121-46F8-ABCB-BE4F212E9C81@oracle.com>
In-Reply-To: <58A84B36-C121-46F8-ABCB-BE4F212E9C81@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BL3PR13MB5090:EE_
x-ms-office365-filtering-correlation-id: c225dfe7-acb5-4f24-bea2-08dc8fcd086a
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?aWZjandSaHlRN0FhZDRSLzBjSks2VVIyMW1WN1p4UzdtaDdmTkZqQVRtSUxW?=
 =?utf-8?B?Sm9uZk5aNHhVVUNJZXpCQXRqVzZzNDVuUFg1UUNHUDZRc0FRWE81Sk9UWGFM?=
 =?utf-8?B?YkxMZFBucnloRmJhVmJRc0NUc08wZFBLeDlhUUlnWERkNkNJTS9pUWoyQW9S?=
 =?utf-8?B?UHVLYnZSL01jNjRUc0NXOE04Uk01djBJSW4wcHFuWTdPMGMwOXp5L0M0bkVv?=
 =?utf-8?B?eDdKZU11RFFBRnFnYW14cGFiUDJlNWx2cE4xaVNqL3dLUG5TcjFRYmdsTm9Z?=
 =?utf-8?B?NE5VdVBTVnNQRVpLdU0vYXRoZVlMbGRLKzdQWXZRTGVqTW5BV2Q5UGRTNjIy?=
 =?utf-8?B?TnlSakFvNEFNTGViSyt2MTYwZFZWbGkxNXVMdjY4QXlZczhQaUFmdit2TjJj?=
 =?utf-8?B?SG9ROG5qQ21SOUI2STBRZC85ck5JUjZKRkFkZ002OVJYbFRmZGlVeFAwNmxZ?=
 =?utf-8?B?cTZRajBoS0V3emR4SEJkWmE3TWpWY2h1eDNqZmRQRTd3V1BJYWphN0VoRWN2?=
 =?utf-8?B?YzF1VGsydU5jK2lVVlgybjBqYkN5czFZOTFtb0ZEWDhSRG5YdmVKbUZjKzBq?=
 =?utf-8?B?K1dDY1FSN2o3M0NMQlpnNDlnMmNYWlhUc3VScEJoRUl2SEpLaDZrWmVEenN6?=
 =?utf-8?B?YWMrR3VOeG5oQVRIZzZBOENtemZySlhrb3dnbytxME8ycEhFTkNpc3VySjE2?=
 =?utf-8?B?UXlLSXVwU3RWSXpoNnNKM1duN29wMnVzdktNMGdWMHZoTkxBcjAxb1RwMUFN?=
 =?utf-8?B?ZHVScWM3N20zbTV4WnZCb1N5R2oyNnVuRmVhMWVNVHpWOEJ4OGI4UkZVWHNM?=
 =?utf-8?B?b3c4S0hHYWRHdUZCeXZvN0FpNkRmSmh6alZydFRZWUhxRHBWUW82MitiNlh2?=
 =?utf-8?B?NlFlRlBLQms0a0lHRlMrVlZVVk92cWpUY0JqdGN5SE1MNGNIa1V6c1J6bHJ6?=
 =?utf-8?B?dFBFMUdDb0tBQ0o2dmgrdXhoOUJiMWlhKzJEY1ZveWpQTExQaTZHWlF5VVdl?=
 =?utf-8?B?OUZOYW1BK2doOFc4RUY1SUNERXVET08yTHdZWEZLRVhMYjZFQUZFU2JOZDF5?=
 =?utf-8?B?Z2tMMnVhdy9zNFZzSGpVT1k5bWFFTmI1SEJFN0FHNHZobStiZEVyTWZhUWF1?=
 =?utf-8?B?dzBpWVVTbDhwbG54eWFnTHNqTmdhQ0Q0ZFJFeitwSXEwd3pDMVowLzBBaU43?=
 =?utf-8?B?aStxS0hJQzRPaThYYldQNk5Db29IRlJqbUFVOG4xY1llaEdmbHh2VytxajND?=
 =?utf-8?B?VHlrMXA1UnJldmZmNWJHdlVWQVRmNTN6YnRWVm80N2VPb3RFc2JEQlRpS3Zx?=
 =?utf-8?B?Ym1lajF1d3k0a1MzVXA2cG1KSnpJVEpkcWRvM20ydEozSkdxOEVaallPUHhy?=
 =?utf-8?B?NnVFRE8vKzQ0Ny9vNGpsY3pSamhoWGdzaElNOGUvK3NnWnVHZjhCZEkxQ0lN?=
 =?utf-8?B?VFlacFZJREQ4cEZOVFFiekpmNkd5N1hnMWttNmlSMGtqQ1F1dURJeUJyT1Zi?=
 =?utf-8?B?NkFURHRtdjgrbFFycmttaHRGNFZVbkVBTlkvSWtyM3RrWTdWRGd1dTZTQW1O?=
 =?utf-8?B?dWNFNFJPNVNWQWtGWHRCTEhuZjZTT0ZoN3pIbCtpL3RjbVhWOEJMSTI3Zjlw?=
 =?utf-8?B?dzY2ZWJmSnJhck5KNWs5bkdVbzNGck1xUXhPRnJMdTNzcnVBdzRNdGx0Wm9D?=
 =?utf-8?B?ZFdyYmMxaXFuWTlRZ3ZTemQzOTRMaElSQTdFb2JoaFZDaGw4ZUkzNDFWYjdN?=
 =?utf-8?B?czU5U1ZlMkZoOUtBbDZBdE1hNGZEdUpyRHJ2bm5qcHFXU24vNTVKOXhNc01Y?=
 =?utf-8?Q?IY+gltNhH9wlWAgyz3ErjifHueaqArttij2Lw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VG1LWjF0Wno5NEJGbXpHNzB1UFdCTW1jMnZkY1ZQVE5WMDZzeStuWnhyQlNG?=
 =?utf-8?B?NmRuSmdPYVZJbFZQYnpmZnVMYy9kMnZKTDlIaWkrYTVUK0ROcHZrckd6U1Jh?=
 =?utf-8?B?S09qVGliQVBpTEs0bWJDSGJLMDc0MFc3QkQ3RThHNVlPMjI4eDY3ZlNSWW52?=
 =?utf-8?B?VzB2NVhnMlhUSDNoem1OMWQ3M2pKeUVsYUZPY3g5MGVFaEhBQUpGZkpjc1VF?=
 =?utf-8?B?dCtyZW1RUzMxbjFTamZNcGU0ZGkrRldYc0JjV0lsTFZXcHYvMlV4KzlmL1NN?=
 =?utf-8?B?SUR6eWl0RHNnNFByc1k2eENHajE5SWFHTXVqcUJILzlYa0FOdm9hVW5ReTdR?=
 =?utf-8?B?YXIvUEEvdW93WnFicVBKaWtxWnkxQUtRTk01MDBFcnZzeS90S2t6aE9QOEdh?=
 =?utf-8?B?STdhMk1IektEQ0plQUp3dTExQm1FRzRoZFZzUlVmeGhoNVJrUHdDa05pL1Zj?=
 =?utf-8?B?NkZKN2piMWdub3hrNXNQSzhwOThlYlhlbFN1dEIyY2pxWHIvY2Z1UlBPa0NL?=
 =?utf-8?B?eXNSRFRZVHNqd3pqaDBSY2dZZFpoSDBKZ2Vocmh5SS9DVFp6bmpiR0x6U1pS?=
 =?utf-8?B?K2poWm5HMzJodGNNOElTVWV1YU9ZNmtmWUdaalcvQXJoa08wK2lzdnpyV2xx?=
 =?utf-8?B?bGI3YmtDTzAyeWRnNFlzZ2JFcE56MkFVdmxsZEtZWXhwd2lackpjY3N2WE9h?=
 =?utf-8?B?cHd6eEtDd2Zjb3JxSExmRXVtNG1ZL1Uyc2VhZHlIWW05cWUzeUpFdWtUQm5J?=
 =?utf-8?B?Smt5ellzZ05zYlZTdW8xamIyZHNNRGZIZ2p1R0VHMDdMZ1UxRkMvS1hGYmJy?=
 =?utf-8?B?VUxGN0RpeFcwZkdCVGloTlNHNS80NFVSdHUydlRISUFWZ0ZQYjNFdkZnVG81?=
 =?utf-8?B?TmRsM3R2bzlhL0xjbG84R01nZkxDV3FJWjVkcUNIZDhzNVk0UWpYa0RsZHZP?=
 =?utf-8?B?Z00vUUFQTFdMT3k0emQ3Rlp3eFplVDNJaWhRb01RWjBjRmFHa2g3VFAzRzZN?=
 =?utf-8?B?aFRXWWFCcFkzOXpWQ3kzV0M3bWhiYXdnZlpmcC9scHVpblViTWZ5Tm1JVk5H?=
 =?utf-8?B?ajBvSXp2YTBSbkU1bVl3NGVoWDQvY2ZIblR0V29abUhiMmxsV1pwWXZLNUlk?=
 =?utf-8?B?ZS9CK0xGYm1lNEVSS3Q2QVhDVjRkZmlMS0QrdlY1Z2dBUVAxUlFDK2d5YnJl?=
 =?utf-8?B?MEpVRTJGTkFFMDI3d2xyYmRPQWtQRnBNQW5jZnFNcTVScWF6MHllSTRpSmVE?=
 =?utf-8?B?L0FXK2RSYndqZ1RrMngrWkhiNFhRYnNGcWRqbXljSWt6OUxBVld0amF4eGl0?=
 =?utf-8?B?alJJZGpOOTlMdExoK0JvcEduSlB0dVBSYlNLWDQyMG5JZVJCaGF0bXk3YXk0?=
 =?utf-8?B?U3FvdWFidlc5VXhpUGprNTBSMnc0c0dTVlRaV1JaZ0dhSU0vbk9PRytWYzNU?=
 =?utf-8?B?Q1I0YmRrK0RkajhNOEQyc3J6VWZiQzMxcFpHaTg3d2VHZEdFVGRBcVkvU0tD?=
 =?utf-8?B?NGhFaEFSdDBrcjBNRHRJY1VSbEFWSW96QTR4bzYzcXUxRGpmVTFlcE90SVBs?=
 =?utf-8?B?RStHcFR5VGRVemovVWp4THBNcklwbXVOWGhLQmxLbWdOeGViNnFHVmFUTHZS?=
 =?utf-8?B?dWhjOUIyOWtSbktVMzdMSVFHaHJNdlUrcTEzYm5aaDd4eUhjakhCS0hra2p6?=
 =?utf-8?B?Snl5dVVWYXhWSW1wRGNPQnZLVHBFNWVSRkRDNVFtSXU5NFk5R2hxWHNzT1Fv?=
 =?utf-8?B?TFJXZ0NBNzB2T1BxYVJIMDMrcWZETElxU2ZvVmlZN042VjducEl1NWNITHll?=
 =?utf-8?B?L3N6MVozQ2w2ZlZSY0xRUTVTdmRoendlc1FEdFluZkQ4QUpRSVpJTUxxUjZZ?=
 =?utf-8?B?M1lzdjJBVmxFeGYyajQrdlhOMmtqemxkbGtNTGpacVU3Y2RFYTFRMHVCYS9B?=
 =?utf-8?B?MExEcEUrajZiemJwYWtNSVFOSXlPdVA5ZmdQa2pjUUxtSURId3FDY2RHRnlu?=
 =?utf-8?B?emx4L3RBaURLRWwxcEJGR21Ca29XZG5JL05tcGRlN2E2T3czTjVBYktNNENk?=
 =?utf-8?B?TFZZRTNqZGcvcTRXVkxYRUlGNlJxa01NTVBxZmVlRW12T1UzSkF5OExCbGFW?=
 =?utf-8?B?ZWhKd2hMVHR4TXQ3M1NPOVhFMzZpOVYyd0V2ZkUxT2JzbEo4cjI1R0kvc2tm?=
 =?utf-8?B?Mmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1061806129467148B8326A0A31DD79ED@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c225dfe7-acb5-4f24-bea2-08dc8fcd086a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 19:29:55.1784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pkySHoWDJ0rnTNpTIjII2eqPBdDiQX3Yl2klb2JVjWKM1VIyaJ2vjwMTQoZiDgfkRmjeKlg39sK3LwscWBhtNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR13MB5090

T24gVHVlLCAyMDI0LTA2LTE4IGF0IDE4OjQwICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBKdW4gMTgsIDIwMjQsIGF0IDI6MzLigK9QTSwgVHJvbmQgTXlrbGVi
dXN0DQo+ID4gPHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiANCj4gPiBJIHJl
Y2VudGx5IGJhY2sgcG9ydGVkIE5laWwncyBsd3EgY29kZSBhbmQgc3VucnBjIHNlcnZlciBjaGFu
Z2VzIHRvDQo+ID4gb3VyDQo+ID4gNS4xNS4xMzAgYmFzZWQga2VybmVsIGluIHRoZSBob3BlIG9m
IGltcHJvdmluZyB0aGUgcGVyZm9ybWFuY2UgZm9yDQo+ID4gb3VyDQo+ID4gZGF0YSBzZXJ2ZXJz
Lg0KPiA+IA0KPiA+IE91ciBwZXJmb3JtYW5jZSB0ZWFtIHJlY2VudGx5IHJhbiBhIGZpbyB3b3Jr
bG9hZCBvbiBhIGNsaWVudCB0aGF0DQo+ID4gd2FzDQo+ID4gZG9pbmcgMTAwJSBORlN2MyByZWFk
cyBpbiBPX0RJUkVDVCBtb2RlIG92ZXIgYW4gUkRNQSBjb25uZWN0aW9uDQo+ID4gKGluZmluaWJh
bmQpIGFnYWluc3QgdGhhdCByZXN1bHRpbmcgc2VydmVyLiBJJ3ZlIGF0dGFjaGVkIHRoZQ0KPiA+
IHJlc3VsdGluZw0KPiA+IGZsYW1lIGdyYXBoIGZyb20gYSBwZXJmIHByb2ZpbGUgcnVuIG9uIHRo
ZSBzZXJ2ZXIgc2lkZS4NCj4gPiANCj4gPiBJcyBhbnlvbmUgZWxzZSBzZWVpbmcgdGhpcyBtYXNz
aXZlIGNvbnRlbnRpb24gZm9yIHRoZSBzcGluIGxvY2sgaW4NCj4gPiBfX2x3cV9kZXF1ZXVlPyBB
cyB5b3UgY2FuIHNlZSwgaXQgYXBwZWFycyB0byBiZSBkd2FyZmluZyBhbGwgdGhlDQo+ID4gb3Ro
ZXINCj4gPiBuZnNkIGFjdGl2aXR5IG9uIHRoZSBzeXN0ZW0gaW4gcXVlc3Rpb24gaGVyZSwgYmVp
bmcgcmVzcG9uc2libGUgZm9yDQo+ID4gNDUlDQo+ID4gb2YgYWxsIHRoZSBwZXJmIGhpdHMuDQo+
IA0KPiBJIGhhdmVuJ3Qgc2VlbiB0aGF0LCBidXQgSSd2ZSBiZWVuIHdvcmtpbmcgb24gb3RoZXIg
aXNzdWVzLg0KPiANCj4gV2hhdCdzIHRoZSBuZnNkIHRocmVhZCBjb3VudCBvbiB5b3VyIHRlc3Qg
c2VydmVyPyBIYXZlIHlvdQ0KPiBzZWVuIGEgc2ltaWxhciBpbXBhY3Qgb24gNi4xMCBrZXJuZWxz
ID8NCj4gDQoNCjY0MCBrbmZzZCB0aHJlYWRzLiBUaGUgbWFjaGluZSB3YXMgYSBzdXBlcm1pY3Jv
IDIwMjlCVC1ITlIgd2l0aCAyeEludGVsDQo2MTUwLCAzODRHQiBvZiBtZW1vcnkgYW5kIDZ4V0RD
IFNOODQwLg0KDQpVbmZvcnR1bmF0ZWx5LCB0aGUgbWFjaGluZSB3YXMgYSBsb2FuZXIsIHNvIGNh
bm5vdCBjb21wYXJlIHRvIDYuMTAuDQpUaGF0J3Mgd2h5IEkgd2FzIGFza2luZyBpZiBhbnlvbmUg
aGFzIHNlZW4gYW55dGhpbmcgc2ltaWxhci4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4
IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1t
ZXJzcGFjZS5jb20NCg0KDQo=

