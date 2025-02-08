Return-Path: <linux-nfs+bounces-9971-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 671B0A2D8C7
	for <lists+linux-nfs@lfdr.de>; Sat,  8 Feb 2025 22:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6824D1885332
	for <lists+linux-nfs@lfdr.de>; Sat,  8 Feb 2025 21:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117ED1925AF;
	Sat,  8 Feb 2025 21:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nzdSMXH4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WiDmB1nV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB3F243959;
	Sat,  8 Feb 2025 21:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739048917; cv=fail; b=QATqLRiPAhu1BQV9TCVr6lPizHrjO7UQzmW1+MoSikXXiBWI9a/CvbI5JF5htFQlLsd+b6XJmTxiiKQgvao3xcElCakZQQJtNqIJM3gY0nRaOi8bbx18ASvdXkj1a6Lpo8smjNfI9nAxRC8LYZm7DIJonNn4iYQfVRHYOEPJ/bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739048917; c=relaxed/simple;
	bh=CMVo+8e5DS73Jn9czADEktCmaT+yuAUGNDW7df/Tvpg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i+Yj9301tr4oOk+RZ7eJIwyBmxKqQoIrzAAenmWn+ylvk2XXCfKVyPmNUhoQxAPC+eu9knUhnMC9kIV0qbnp+TSXlK2mWJfnEHuu5jkIr9kVHuVdot3GVeHH1NTifDgStyo6MKF/rNQtOgSeOPlZppXLzXxiL75yinhVEDec54c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nzdSMXH4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WiDmB1nV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 518JwtAl010291;
	Sat, 8 Feb 2025 21:08:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=kmx59/Pv3RHYE7fNKYf7G3tCZmbYFlV3kmhlwIQxSic=; b=
	nzdSMXH4rzVvTT5vCo9PKUBbKu7cIHG1yDnnTtPJwgN+nLkKrk6KUv25VukrOf19
	cIYaK9A5nSFNNhii6b0uFZIBZWRQWzWnfQ4fkEMV/319sFVzfI/OREUmFev2tUCd
	KdEJgUcfDQUlqby7fSBVr3WGzh+dj+JpP8q8xUUaFGUncmSlGVOVUIQLYImmWDIO
	ecX3DFkTKrotzfs3Q9N/vvurdObbvqxArmdZwQ+XveQdZHoISdAa9WK4UjZDi+/F
	Lo4FgGapgp34mmEHzMAtikf3xLdHtoF1c7Cs+Bij6ZcvQmoWnthiaRW5p194HLnR
	wr89DD+Nno1Hpw3vvhmlOA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tg0gr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Feb 2025 21:08:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 518JpV8w003949;
	Sat, 8 Feb 2025 21:08:22 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwq61s2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Feb 2025 21:08:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tzLP6XSNx+zrZSb2K+hGeX7laXsN2O6AEl0ntteJzEQfv7e5sQtk8ZCyOzcrGeAaQrc2wlLxzm+p9I/tibA7AZuzTNkV1nDKUq8rIFlw8Cas7Z1JqG8ZrlhgdGe9Os34K29n4SCeqy+vmMql1AQqW4QrIOOuZw7DtVKxJshVgPZ/X8vA/rzmH2LMp9aAUZ/dqTRQXYZMjbz2KPiIX2KEdN/Z6+VXjNsKIGSrdq1acFtnWQjuI9REPayW55KFKvYft6+r9PafJXnT3XLEipWX8Xc7FOpfe/xQtIaUKWra/GKaVkc5O/CqtnuFj9yr4bzvk3hSIXedvuwkCuh2j4hf2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmx59/Pv3RHYE7fNKYf7G3tCZmbYFlV3kmhlwIQxSic=;
 b=QnSTEU04OE6jQxARbWRbW4JCFSA5KGGLsg3Qm1EXHZIKGmJXghpM8hQhgOI+mdvTJizZ6nMxlaGXRzGRIdT1Bti5nQQUEe0Z0/MwmTPs/owDjtoFVt1JGc8FVFRp26CK1w5LZLG5PkTWDIpsFNaXs7CHun7xR/9t/mJiITuWW5DOiQLhVSLzq/Z8FhRyWvA7ki8vbiTQDhAD1leVe5zfMre9JS61m4d67R/WOp06TuXF/ecWkRNAGuezQQ4x7YP6MBGWsAscCSS4fwa5BnlEW+BvyuPSJ7UecFns42f9aSytHrWij+EzsciUEWtSgO33ygvlm8geYrR25fDMz0U78A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmx59/Pv3RHYE7fNKYf7G3tCZmbYFlV3kmhlwIQxSic=;
 b=WiDmB1nVYsWEIDqV4htv6MK2Jr0wDIJoxy0j0lyUBBDNzIRa40qDiBVHcVVpc3nyeAThICs2KgsE9x3BulyHCihi4Ph+CjPOe80SnjNS8+/LM32ts9TdCM0Bzkt1oacVo4xWQQG0eFjjLXZo86nCt0RuozB6yVQSmLMlYNolrog=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7356.namprd10.prod.outlook.com (2603:10b6:610:130::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Sat, 8 Feb
 2025 21:07:55 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8422.012; Sat, 8 Feb 2025
 21:07:55 +0000
Message-ID: <2f9fe86f-b49c-460c-bf2e-fed97970952d@oracle.com>
Date: Sat, 8 Feb 2025 16:07:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] nfsd: handle CB_SEQUENCE NFS4ERR_SEQ_MISORDERED
 error better
To: Jeff Layton <jlayton@kernel.org>, Tom Talpey <tom@talpey.com>,
        Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250207-nfsd-6-14-v5-0-f3b54fb60dc0@kernel.org>
 <20250207-nfsd-6-14-v5-6-f3b54fb60dc0@kernel.org>
 <28174296-129d-4459-aa23-a94bbf00d257@oracle.com>
 <3e4d14075482489cd010e4ea621c0bd368700e27.camel@kernel.org>
 <40970e33-4689-4623-a423-b346e739ba80@talpey.com>
 <66532654ca25280ffa30168a977601ba4a37aaab.camel@kernel.org>
 <29e739f1-2d85-40c2-a549-5ab9d71686b0@talpey.com>
 <35cae0eb73781bb36c49aed2c2bc49a808698635.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <35cae0eb73781bb36c49aed2c2bc49a808698635.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0010.namprd05.prod.outlook.com (2603:10b6:610::23)
 To BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: 46e06e7b-6b68-4f55-7350-08dd4884a822
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RktQSkF6dU5pRnJMdEhDV3ZYN3YvKzNGRzRmYUcrOHl1MC85dS9uM1lVQzFi?=
 =?utf-8?B?NzdrSlNkaDkvMUFUeXgrUzBLa1krblBTaStQU3pmTnlQRzJzOENpK0JxZW5p?=
 =?utf-8?B?NFdzdlc0NVBkeEY1VUwxOFQxR2dXeDk4WFYraWZ5WkhXSklKVlJIQVd6ZXZX?=
 =?utf-8?B?NytLRVdCb01RWnpNaHJlYitQcVJuUk9EMWVYdDI3L3JnaUVxaFk2ZkR6MEpV?=
 =?utf-8?B?L3BOSjJ1eDVxM05lTGE1bnp2blhEbGJrL01DVzEvdUZvZWVhZmdHd2twb05p?=
 =?utf-8?B?dkU5UlpUWlQyZFBkRW9nb0hMSk1YS0VUQXQ5UlZZZW9QN3RlT1crMERMYXZV?=
 =?utf-8?B?UW1UT0xETk5paENleUtVM2FYbnI2RVdOaXlMK3NNdklGZW14cEp1T2NmY2kr?=
 =?utf-8?B?OWwvRVhkSXVDZE94aGxTc0FJWFRnMkpBb0Y0Y3NhUlo0N3p2Mkk1R05rdXRx?=
 =?utf-8?B?RWpuRWJxeFcwRG8welhYUHl0K1gzZmg1SmFZS0hvWDY2aFVIN1NFQUZOV3dP?=
 =?utf-8?B?RStMSVZhdkEwa0N3eVhSaDc4d2hLU3hkNno1QmZEVVg1MDVhV3VlVGdmTlhB?=
 =?utf-8?B?TlBPVWR0NmpzTjd6ekYzaDlYTUp6SkpyS1k1aFpHQlFtVkpjZzhJam5EM0Z4?=
 =?utf-8?B?TG9sdW5lM05seWp1WEQ5d0d1ekVnbmRYM3AxUHl3ZmU0KzlQUGJEYkwyOWhz?=
 =?utf-8?B?NUZJb3Y0bVBFamwvb1lOYjZNK3BMbk9DK0JOd2NFU0M2clc3OE16dmVJb0ND?=
 =?utf-8?B?a2JuenlxNjJiRkdvSlJsWUMzQzQrT3hxNzM2VWNSZmI0YmhUR1lSdmo2TVgw?=
 =?utf-8?B?cHc4bHk2OHhQSEpMMHI3bDVjdG0wK3JGQ1NNRTJsL3VXenJFR2hOZ1JQRzI1?=
 =?utf-8?B?RGRnM3ZPTmUrUzZZUm1QdU9yc2JQOWgzdEVJeGlLWGgwTXhHUDlLVFFBa0FJ?=
 =?utf-8?B?NGRYbklpZy9QNnpkOENya0dsS1Y4bFJVOWJQaWkxUEl5NkI4dU42Q1hTZFFy?=
 =?utf-8?B?ZEFGbFlzVTl3WmVoUlJ3eHZPWGRMakdGeFJrUVIyR3BRc2xiRnZUdXAyZHo4?=
 =?utf-8?B?aHFRVG0zTTFDMitmcEM2SExuOU1qdVFsdVhJbkY2cHpwZXFyZC9Jc0xvWmV6?=
 =?utf-8?B?dkNrVDJEa0hZWnd0UFdnVGkwYVEyTE42VjJlNXpySnI1TFY5U0VDRGZobWJ4?=
 =?utf-8?B?c1VnUlBpbnhtTjA0eWl0QVN2YnF2bzg1VDNIQlI4eENQOGU0ZnhTL0E4VzZT?=
 =?utf-8?B?d3luQUdlOXJyOWdzVE9YdVlmcFRVNGQ2N2R4QVhVaHUwUlFYT0NoRkZNVm1C?=
 =?utf-8?B?RkZDWkpWSEtXWEh0Um9rejltMTZKMXFjazlUV2hsS3FUdklGUmtWaVJvQkFN?=
 =?utf-8?B?NEt3bzB1Rks4eWlYKzJzTFZtSmpwNkE5RDVyMUhWVVluM0FhVVRiU3RHb2xW?=
 =?utf-8?B?cmRGM1VMbDZ0MmV1UGNtMFhHMXByNUc0VDRkVThFQXhYcEhNSGM0aFhPY3Fh?=
 =?utf-8?B?ZHBjWjluRUdNcFJiQWY2WGh1UWRrUmJJSTBqZDlTSmh0QmxaZjJKOFRHR0hT?=
 =?utf-8?B?VVg5LzlPYU45VUFKZnF1TmZWRkIzbDZMK1BOVkxTL3JmTHBkNDNkQUQ3SjBF?=
 =?utf-8?B?SE05NlU5RXJ1Vk9tM2NVTnpJbjBGRklOQmhKaFFIaVF1eHBmeWVEOWZQb2l0?=
 =?utf-8?B?MDBDYnNlUzdUbWl0VTdMRGIzVGFFNmdVWVlQTXV3UDNSVHBSL0hUUE5HUUNa?=
 =?utf-8?B?YkxOcTlxTVl2RS9xRFJ3My9nT1pRaHpHb3ZTN3FMTG80OE82dkU4Y0Q1QWNE?=
 =?utf-8?B?eERTeEpTVEQ1SlJ4YXpTc2MyWXhLaERXdklUL3pLdHc3ZGhtK21yQk92MXE3?=
 =?utf-8?Q?86f5Qiazap6c3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGN1T0h5SG1KRll3bVJ5b0dudmJJZnpTVmtKNzBhazlGZ0dWdUhNR2FpYXln?=
 =?utf-8?B?ZXI1NmVWOWEwdFRBKzFHcEV0b2Z2a2RRd0dMZ0ZBRk00L1hGWnNVTzFObWRt?=
 =?utf-8?B?dTVaNzQ0bDlDdWlyckZITGc2V2puQjd1MG11ZFdaeDFxYlc4K2pKUUlMYzZM?=
 =?utf-8?B?MWNsL3RsU3owTmoybFJsNFNkUEpLbVJIeWlnK1p4K0V1UEZsb1prNXA1R3Ru?=
 =?utf-8?B?OXEzbXpKRmFhaGlPa3BRaDlOSW15aFlENUpXQ0NON0R2Ym5TYXFZUE1oWXdD?=
 =?utf-8?B?by9xSGhBdktOei9xUXh2aTRvd1VoTUlSVHdzVWJpWHBacW02QnVpRThrYUNF?=
 =?utf-8?B?RE5RZ1VYdk5DTytrRUpzd2hvbjdyejFPaHhqclQvMFBBWGs4aEtXaFl2U0hq?=
 =?utf-8?B?S0drQ3dQMWQxZWp6R0VOVzVwQUwxYnIvTkhKY3QzZUVycHdGZ2g2bVd3K05p?=
 =?utf-8?B?dGttKzltZ1BDdGdKc1c1OHJXVkFpVVU2MjUxbVErRnBTQTFqUUp1czF6UVp0?=
 =?utf-8?B?K2ZMWUM4dWlaTUxQV0tETStmZlM1alNZS2hQT2FVSmNhSXpMZlYrVTF0a1BO?=
 =?utf-8?B?T1dQcERxWFpzTjA3R1h2TUo0UkFabWxsUWlPcUE2UWoxSGIxTlREY2UvcUlO?=
 =?utf-8?B?TTlkaXd3TnVXeWZQYzVKT2hObENjMWtaV0FHc0hJSHZnUzl3UkJBY2pjREx3?=
 =?utf-8?B?by9EbFAvYXh5dmRwQTBPVVByVFpWakxyQVdwV0RzOHQ0Ukk0eEFpdmpQV3gx?=
 =?utf-8?B?Umxhdm1BcWxZK296RDVDRDhkYldEUmVhcDVrdXBwWEwvZGdhcG1tS0kzdEEz?=
 =?utf-8?B?NC95ZUcyRjRYM3pzdzZqdm5GYndtRU40SnNYQi9PMFljOUExVmgwV2t3UXgy?=
 =?utf-8?B?elFBa0czdzlzUVpQN1daNnQvUXJRQ1lDd2dNV0x5WUFGRnhRWHZ2V3BINmIy?=
 =?utf-8?B?N29QdW9WZEJIVjcyY1FCYW1IcS8wRHpMd1o5TG9Jc3psekpBSFhiZmxLUEpk?=
 =?utf-8?B?eUVYNzhaaGExQVdsZTUzdzJDYm15V1pqWjlNaGRjRFo1YVpRTTF2OThOUi9r?=
 =?utf-8?B?L0RNVStwemw1blZTMXNMcDgvaUJwUDV1NnlYZDc0QkhvMEM3aUVidW41V0Q1?=
 =?utf-8?B?ZHpCd1dxOW41NytHQWdyLzZEN1RzTkk1b3Z1MzZUVWlBL25BTG1HY2pmc2xm?=
 =?utf-8?B?ZElHakFKZDFyeXJ4bXo5aEVVZ2hQZWd4M0UybG5DTFhpZkI2WXE4clNRL0ZE?=
 =?utf-8?B?ZmxDazdTY0plcTNQM2UwejVLVXZjQkZOY1hSN05uSjE0WU0rNHlocHZLK3F5?=
 =?utf-8?B?M1A4NGhSU1o1Q292Q0s1RjJhZ0NmSVZMU3hkaDRFZ1JBaU4rUi9VVUswNm5T?=
 =?utf-8?B?aXc3SVF2QnllNGVqSDlvZmZjSDNXNFdXQkl5R3ZRdzR1RTVNeCtienRtWm5u?=
 =?utf-8?B?dnRSOFRuOURlbVh4bzhiK2luS2FGTVdKdjdxNzlNS2dwbGFwVnFwMVNXTkk4?=
 =?utf-8?B?bUZVVCsrMmJZZFRHbVpHZXdMa09QQVNMTmpoR3QwVGQ5QlE4Ykc5bUlhaTVw?=
 =?utf-8?B?c25MM3pHWGE1UVI3MWZLOE1UOVJ2dThVVXY3N09id1pvUXg0dVB6NE9qampI?=
 =?utf-8?B?Uk9qSzVIeGJpaXNEaFRTZXVoa0FaRzVSVzd3M2lBQ3NwazkrTXc5ZXU4TDF0?=
 =?utf-8?B?N3IwN3pzUDBFcjhoWS92c05HWllETkZsLzU1dE9hSldTVThNRkg5MXFsaFFo?=
 =?utf-8?B?REJoT2duMVpxN3h6c2M5RGg3SWtpQ3cxcllrL2t6emRQc0pDc2o2ZDhPTVI5?=
 =?utf-8?B?M3FJMVhXQmlpeVNHeWhzaUFCeHVGanIvNUQvcmN4bG1sRmVIc2Z2SVlEekxx?=
 =?utf-8?B?UmR4MWxBRmI1OHN3NTR1bU5HQTBYUSt4dEFCQ09zdlJMMmNrdHFOT1VKUS9K?=
 =?utf-8?B?UEEwTEQyVjZLZmtrRDhBWWtseXlJNmlMMitRVDZEaUdGR3g0QVJMZ01BUjdJ?=
 =?utf-8?B?YmtzdjVLVnFyc2xQcnNoZWtScFRGRHU0QW1RVE1TczRHWE5BakhTQ3JBcEhV?=
 =?utf-8?B?OEFubVhEaDYyUitrdFNtSEtHWjNWUjZrQ3pHdVJrUTFuUGFvZkxHTkNmSzV4?=
 =?utf-8?B?L2RBTnJnd1BpU0MvT2lJRStXMTI0bExTOFpsQXhZeUYwU0M3VnVmcmVOTXRL?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ei593G4jbLnp5SfB7fCb+3nfpi2J765h834ld2+DFOyKfgaIbVYxZkxV4HFpTn3oNtSo1GP7vR6tzFYz/MdZ3ZHICPyZ7hurXmadniQ39eJG4gEKj62NkB5XN934py3qF7EMmMbNtN6DAnayuCEJaee/BRg4l+ddDmX4YddiCk1IlH9UWre+S7UuClnbus2VcsxRIIEChKZWEQ1QkPWPYTgLVFftqfbM4EIfx74Y+9h8P5PnUB0AxPvnEOLSbFy1ggUGn4hqu5HCYczGbwMbyLpC/1dbCZKyULdR3pMU0wYjpwk0VC1abOia1Zbyb5jhKvj7U1gEKyNTLOfZMiBSxr/QMVjZy8EJEfzb3ipqsZ6Z413TrcYIkkqM3V0Hi4OZYddTqxAmWI1aIbF3jA/bhFTYgPo2yqbrAznoybkz5OYXLOsWPFIFO+nieOUBJPYCYSXqXz36xyJPOsOeE16hK8xMvDV9/KdOHHCgpVxqS/UABy6xk2NFz4DM0CAU8zpNhmWJPugFmU2queSQFpEh+ja31e+3rMI6k1VTeHtMjBmyo041z/o5r6YfF+w9iuZJgd380v6JWPpjyB0p8D8YMYZnaQaKOT0v+CvCGzhLW7E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e06e7b-6b68-4f55-7350-08dd4884a822
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 21:07:55.1321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vkfzddVM3F5+bNxbk3Aj/R1HIXU5pAJFwvGW9PMntXP9NxRWG46xEsbngZex3H0dSLOddBjVoi/NtjaEhsv/TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7356
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-08_09,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502080181
X-Proofpoint-GUID: 9x5LFwzIpFFeiW7zPn1b1Ma3fGJrLMeh
X-Proofpoint-ORIG-GUID: 9x5LFwzIpFFeiW7zPn1b1Ma3fGJrLMeh

On 2/8/25 3:45 PM, Jeff Layton wrote:
> On Sat, 2025-02-08 at 14:18 -0500, Tom Talpey wrote:
>> On 2/8/2025 11:08 AM, Jeff Layton wrote:
>>> On Sat, 2025-02-08 at 13:40 -0500, Tom Talpey wrote:
>>>> On 2/8/2025 10:02 AM, Jeff Layton wrote:
>>>>> On Sat, 2025-02-08 at 12:01 -0500, Chuck Lever wrote:
>>>>>> On 2/7/25 4:53 PM, Jeff Layton wrote:
>>>>>>> For NFS4ERR_SEQ_MISORDERED, do one attempt with a seqid of 1, and then
>>>>>>> fall back to treating it like a BADSLOT if that fails.
>>>>>>>
>>>>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>>>>> ---
>>>>>>>    fs/nfsd/nfs4callback.c | 16 ++++++++++------
>>>>>>>    1 file changed, 10 insertions(+), 6 deletions(-)
>>>>>>>
>>>>>>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>>>>>>> index 10067a34db3afff8d4e4383854ab9abd9767c2d6..d6e3e8bb2efabadda9f922318880e12e1cb2c23f 100644
>>>>>>> --- a/fs/nfsd/nfs4callback.c
>>>>>>> +++ b/fs/nfsd/nfs4callback.c
>>>>>>> @@ -1393,6 +1393,16 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>>>>>>>    			goto requeue;
>>>>>>>    		rpc_delay(task, 2 * HZ);
>>>>>>>    		return false;
>>>>>>> +	case -NFS4ERR_SEQ_MISORDERED:
>>>>>>> +		/*
>>>>>>> +		 * Reattempt once with seq_nr 1. If that fails, treat this
>>>>>>> +		 * like BADSLOT.
>>>>>>> +		 */
>>>>>>
>>>>>> Nit: this comment says exactly what the code says. If it were me, I'd
>>>>>> remove it. Is there a "why" statement that could be made here? Like,
>>>>>> why retry with a seq_nr of 1 instead of just failing immediately?
>>>>>>
>>>>>
>>>>> There isn't one that I know of. It looks like Kinglong Mee added it in
>>>>> 7ba6cad6c88f, but there is no real mention of that in the changelog.
>>>>>
>>>>> TBH, I'm not enamored with this remedy either. What if the seq_nr was 2
>>>>> when we got this error, and we then retry with a seq_nr of 1? Does the
>>>>> server then treat that as a retransmission?
>>>>
>>>> So I assume you mean the requester sent seq_nr 1, saw a reply and sent a
>>>> subsequent seq_nr 2, to which it gets SEQ_MISORDERED.
>>>>
>>>> If so, yes definitely backing up the seq_nr to 1 will result in the
>>>> peer considering it to be a retransmission, which will be bad.
>>>>
>>>
>>> Yes, that's what I meant.
>>>
>>>>> We might be best off
>>>>> dropping this and just always treating it like BADSLOT.
>>>>
>>>> But, why would this happen? Usually I'd think the peer sent seq_nr X
>>>> before it received a reply to seq_nr X-1, which would be a peer bug.
>>>>
>>>> OTOH, SEQ_MISORDERED is a valid response to an in-progress retry. So,
>>>> how does the requester know the difference?
>>>>
>>>> If treating it as BADSLOT completely resets the sequence, then sure,
>>>> but either a) the request is still in-progress, or b) if a bug is
>>>> causing the situation, well it's not going to converge on a functional
>>>> session.
>>>>
>>>
>>> With this patchset, on BADSLOT, we'll set SEQ4_STATUS_BACKCHANNEL_FAULT
>>> in the next forechannel SEQUENCE on the session. That should cause the
>>> client to (eventually) send a DESTROY_SESSION and create a new one.
>>>
>>> Unfortunately, in the meantime, because of the way the callback channel
>>> update works, the server can end up trying to send the callback again
>>> on the same session (and maybe more than once). I'm not sure that
>>> that's a real problem per-se, but it's less than ideal.
>>>
>>>> Not sure I have a solid suggestion right now. Whatever the fix, it
>>>> should capture any subtlety in a comment.
>>>>
>>>
>>> At this point, I'm leaning toward just treating it like BADSLOT.
>>> Basically, mark the backchannel faulty, and leak the slot so that
>>> nothing else uses it. That allows us to send backchannel requests on
>>> the other slots until the session gets recreated.
>>
>> Hmm, leaking the slot is a workable approach, as long as it doesn't
>> cascade more than a time or two. Some sort of trigger should be armed
>> to prevent runaway retries.
>>
>> It's maybe worth considering what state the peer might be in when this
>> happens. It too may effectively leak a slot, and if is retaining some
>> bogus state either as a result of or because of the previous exchange(s)
>> then this may lead to future hangs/failures. Not pretty, and maybe not
>> worth trying to guess.
>>
>> Tom.
>>
> 
> 
> The idea here is that eventually the client should figure out that
> something is wrong and reestablish the session. Currently we don't
> limit the number of retries on a callback.
> 
> Maybe they should time out after a while? If we've retried a callback
> for more than two lease periods, give up and log something?
> 
> Either way, I'd consider that to be follow-on work to this set.

As a general comment, I think making a heroic effort to recover in any
of these cases is probably not worth the additional complexity. Where it
is required or where we believe it is worth the trouble, that's where we
want a detailed comment.

What we want to do is ensure forward progress. I'm guessing that error
conditions are going to be rare, so leaking the slot until a certain
portion of them are gone, and then indicating a session fault to force
the client to start over from scratch, is probably the most
straightforward approach.

So, is there a good reason to retry? There doesn't appear to be any
reasoning mentioned in the commit log or in nearby comments.


>>>>> Thoughts?
>>>>>
>>>>>>
>>>>>>> +		if (session->se_cb_seq_nr[cb->cb_held_slot] != 1) {
>>>>>>> +			session->se_cb_seq_nr[cb->cb_held_slot] = 1;
>>>>>>> +			goto retry_nowait;
>>>>>>> +		}
>>>>>>> +		fallthrough;
>>>>>>>    	case -NFS4ERR_BADSLOT:
>>>>>>>    		/*
>>>>>>>    		 * BADSLOT means that the client and server are out of sync
>>>>>>> @@ -1403,12 +1413,6 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>>>>>>>    		nfsd4_mark_cb_fault(cb->cb_clp);
>>>>>>>    		cb->cb_held_slot = -1;
>>>>>>>    		goto retry_nowait;
>>>>>>> -	case -NFS4ERR_SEQ_MISORDERED:
>>>>>>> -		if (session->se_cb_seq_nr[cb->cb_held_slot] != 1) {
>>>>>>> -			session->se_cb_seq_nr[cb->cb_held_slot] = 1;
>>>>>>> -			goto retry_nowait;
>>>>>>> -		}
>>>>>>> -		break;
>>>>>>>    	default:
>>>>>>>    		nfsd4_mark_cb_fault(cb->cb_clp);
>>>>>>>    	}
>>>>>>>
>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>
> 


-- 
Chuck Lever

