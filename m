Return-Path: <linux-nfs+bounces-5024-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF2893A8B2
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jul 2024 23:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B375F1F22C57
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jul 2024 21:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C93614430C;
	Tue, 23 Jul 2024 21:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cleahDKa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xakD8kd0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CEF13DDDB
	for <linux-nfs@vger.kernel.org>; Tue, 23 Jul 2024 21:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721770129; cv=fail; b=UqbUvl3/S8Y5sMHM1BDXy0bcX9wuyQTCugkDPu2Jr1O1SinjwldLBHSNFO/AlIXq2YxZorbTp73/gKqT2qKap/tM0eyUifgXUTebgt9yGz1Od4ziQIVsXAqVzkNFESsNDCoFnDAWFP2FyCbmd1JL20X5WOc5B/ziqzjnlIBMMkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721770129; c=relaxed/simple;
	bh=ib0QuQma2U0MWJfZafic4FuvF9dKxCijSZrYGqx5oSY=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nj+tZGTIndNzLarHplTp4r7kcAq/dUvWB8InqdTAiaJ1rhFoKASaIKrmpEhEqg5BG4v6AFuXW0DDd9c2abBlFAEGyBpgeBpAHhx9gIrQYKslp20fY6XEzIYhwb9SGnzkk+0W/5EOEKKrpBX+S6ZYWMstXqDrR5i2xAzlZpcrzSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cleahDKa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xakD8kd0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NGQUI2025315;
	Tue, 23 Jul 2024 21:28:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:cc:subject:to:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=MjANx1Hayt35l2xZy8vV5EVmo+v6eCJAwWMgx/Iy1jg=; b=
	cleahDKaNJ42d+WLONVF5odGksU3zzdfAoguDbmOpnJxWmO9S/crqpYGZp+aJRoF
	pZR63pc2AzGMskEzTxvds08wQJjIrqf4O5xlOt+i3OMGjNHlPlLM2Uq6+S0RYhQ/
	eqXMtBvOAQYaE7oLBvSpPNs1tYAqtda/nPwtU2nLQU4H9BgC4ccWAkVBI1ZxxjUT
	3hq8mp3qbyv5iJWzRFdDVafGnoRD1abNlqBSZg1fkWtUeoYCCuzLGjaqzDi83xnW
	Y17bvWdmboKQL4SL8J3mHgtONuRXqIkfIh+3HtYKI2tFsjiJy3eMqYJnMuXFnQNn
	4A6yixCuQy4oS5RXVI16zA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hg10yfe6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 21:28:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46NJqg18024641;
	Tue, 23 Jul 2024 21:28:39 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40h2a210gj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 21:28:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mEe3gfAZx8DaAKdFF5nkJ0Is6SQC0vwRvekkF2mhiP19ntlsPJjwskP9ZbTymFepnRCo3wWyKsdLgEtomwh6bzmv7EQ4nw1RLEX8HJGreAP+i2j6O1G5XSuXK8+LyK0vli6DJ3Nzhulv3/X8j3zHiQ4lLqzmMdoUQxavsKWME95z0wjxdxM3TyQr6Q6dH9APeoyaxQ86CsK46z6B04bV6hyzUphDSmDLMKq8ca4s3IiG3teQxTOM5yoQqJgzMYZ4upwA5VWt507S65a7SndoQKUfgfqd5bcAQdygVyUMMjuHbMhQ6PNIVol27KBF8TpD8TZ9Ynxvi4Vm0azuEZNWfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MjANx1Hayt35l2xZy8vV5EVmo+v6eCJAwWMgx/Iy1jg=;
 b=pjT9reZHZn2S43LoMKI+ySpRx49aWUvtcqhjcttHp1Qa+j6gqeIMRCIFtn0KfS5CJClZTDISSbb8lCSOmRJKwEfCF95niSME68ogNz80Shpk9cRLd10HNIowXP3NdeCjauTdE3mYyd1hy0HewrnjuGAHZUs0F5PCAUbqiq2DqIDUWPuNdd6ViL45qydOn2mFa/49M+uVaSUZzy6aM+Oac4a05z0WJWG9pMLwDGGxt6x+9EjUuC2/7ih6x11nzDOZryjbw3KlzfpZTFkKD7Q0E+U9Ht/UvLo/BuxjpuXCsu2SVQqt1fjCIBBonJ+7ra4GGONGmTC+brJ5DH24JBPH/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjANx1Hayt35l2xZy8vV5EVmo+v6eCJAwWMgx/Iy1jg=;
 b=xakD8kd0gGnTKelx6w37/0L+qlKhRfWE0/LVTFgO0G+FZ4yMQaZdFoIjqSiKgowy+wSZn6edb0Afn32HLUbtI148vHap28OL+NIMfFPXlRp893+DxVqP0mDTChG9ZwVjtMY4cn38ZRcQxWvbmzatgJsARJg+9bh/j3WlIeQfrv0=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by BL3PR10MB6017.namprd10.prod.outlook.com (2603:10b6:208:3b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Tue, 23 Jul
 2024 21:28:24 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7%4]) with mapi id 15.20.7784.017; Tue, 23 Jul 2024
 21:28:24 +0000
Message-ID: <9a8043e5-9f97-45c0-a26f-a882acd1e320@oracle.com>
Date: Tue, 23 Jul 2024 22:28:21 +0100
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>
Subject: Re: recipe/example for nftables supporting Internet nfs4?
To: linux-nfs@trodman.com, linux-nfs@vger.kernel.org
References: <202407231953.46NJrpWr3811115@epjdn.zq3q.org>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 smRifw1wGg==
Organization: Oracle
In-Reply-To: <202407231953.46NJrpWr3811115@epjdn.zq3q.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0697.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::12) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|BL3PR10MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: 70bf3633-3b05-4db2-fbef-08dcab5e6275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWZlVlhtaEYycHNNYnNTU3R1d2RjMEdCRkRmOVNGRUw3a1ozWVpqWlBtanU2?=
 =?utf-8?B?QnQ2eTBuVFpPQW85bW1rNUVGd1czcG5QNmJGNkhYUTE4c3VZN0VGK3RRMmJZ?=
 =?utf-8?B?QnQyM1dZa3FZWUNwNE16NFVyV3R3SmIzK0JnUTU3Y0VRdHozZnNtLzZXOHhO?=
 =?utf-8?B?YXBmUUFYcWgyaHNrRDEvUnBRSzVyUHR0Y3BTdDYySTBSbUpxNWNzTFhWUitk?=
 =?utf-8?B?MHdsMGZFVXlYd1MwN2JzM2NFYnd4VEhTVDk0eSs4ZGlLOVR6QTJZYUtVQTR0?=
 =?utf-8?B?WDVsV3luK1o2amtuQVE4MWczSmU2cmNEK01WUWlTREVZblYzZmtqak9rcFVK?=
 =?utf-8?B?SjBObmlBZnFXc0JYWnc1bUNnRVJNT09WWGtLeWd3WFJLS2REMGhCS1VuTWxG?=
 =?utf-8?B?MXp0a3JzVFNydytreVN4dnBVSjJWRGVzVUxIbS82YkF2YlZOQlNjR1JnVE9q?=
 =?utf-8?B?elRJbEZha3U0MThiaDBSa1BXVUVkcUF0dW5qYWxQenZ3aHlGRmpaZmRpNkNm?=
 =?utf-8?B?LzdEVTJIU2JHRkdXYlV0Um1ncStncFRBaXNtVUtBUkY3TXNhb1hoMlZYNDNy?=
 =?utf-8?B?bFVYbVF3VGpzYXZON3VnT0c3cFB6MUhzVHAySUVGN2N0ZllIdWhKUEtlNHJQ?=
 =?utf-8?B?WmxCSGtzVC82ZHVEVnpFYlR2RjFTRW1IeGkxUVN6QmpHMW52SmdlVXpNSi9K?=
 =?utf-8?B?NEpreWNWbWs0VDREc1hjd1dWRnJHSEZsQkZUR1FSbWdvSEVLUlZTYlhUWlp0?=
 =?utf-8?B?bGYwbFkrZFZ4aU4yaU5PbWt3UC9EL2d2Y3lmMmcxQWYwaFV4MWhlY1I0RGY2?=
 =?utf-8?B?OXdlVkZycUJrMXc0NVFvajVIelpaNklWOXpSYmZISzhNQ1Z6VzFVcVkvWVJm?=
 =?utf-8?B?OWEzQ1NyalQ2T3Uya2NJc3Ewajcxc1V3ZnpqUFBGUi9BeUgxSVh4ejV1eGhp?=
 =?utf-8?B?dlkvVEZqK2JYcUR0bW0zcHJrL1E0cnhiNGF5RDhzY2JJTUU1NjZ4bmg2WElJ?=
 =?utf-8?B?Q2xEVzJLNWcyMklOV1BIb2ZNcTlRZWhGcDFqcjVBNWtTMkMxemc0WHpCL00y?=
 =?utf-8?B?YWRUUWlVNGxtY1BRMEREcFF4L283aEZwMGFoUWl5TG9JOUF6bDhYc0NYN0xD?=
 =?utf-8?B?WXJrTURzV3BHdE40cW1UMlNjRmI4Q0E0TGN2V3Nucnp5SW1zaDhpU2RYR2hB?=
 =?utf-8?B?VEk0Ry9lNzB1ZFhBekYzTmNPdDhBY1NNMEI3ZkZ1bVFGNUNPVHlQMjhWNzBN?=
 =?utf-8?B?ZklzcVMrT1BhTk5BcUtxTm9MZVlwOGlhRm1GOEQ3eTlzVmFQSjM2SThNemow?=
 =?utf-8?B?dDUvbm9TMDl0NlRCY3lZL2xXc3AwcytmZWUwbTJ3aUtZUzhhOXRUWUZ2S1Zt?=
 =?utf-8?B?TGxqMzVkdnNxcndBRnJVZ1UrY3pYTlNvZ2w5NnhtQ1FTc0NxYTZQWFdLWmgw?=
 =?utf-8?B?cC9JWTJ5SXptd3JKYXc5NFpSei9LVUNRZGxKek9Ub2NSL0x2Z21XQlY2Q0Fw?=
 =?utf-8?B?MmJGMTV3Sk1ZNnFDYklsQmM2S0JFTFhaaTQ3NHExRS9OaDBjeFB4aTRReG52?=
 =?utf-8?B?STZYTzZtYUVtcjRuN1JxVy9VckowdThpcXpNRHNhSzZ1VGhZZVE3aDR3eFFY?=
 =?utf-8?B?T2VjWGtZMkNuQnZ0cVZNKzN1YzNTTFFxWVhrNmliUHJmZ2F6Ull3ek5hdndW?=
 =?utf-8?B?VDNRUEwzSmpXTlZOUDRUeEU0VERqanhHZi93SWkwSHNKQll4NUlGU3hVTVFM?=
 =?utf-8?B?RDRGb082Qlc0MGc0YWoxR2dmcGdrd3hsR1U2VFEwTUdScTZwK2NLNzFKMDRx?=
 =?utf-8?B?alV3OUFYbnlWUVJudTFBdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1hkbHhPSVR5V1pVWVA1eTRmbXRieVhoT1IyZnFkL3pyK0t0MGw5M2RaR1lB?=
 =?utf-8?B?c2Fnb3h1TnZzMkNDNVFIdlY1RmNBcFJ2QnAxNFJDOU9jV0hkR2FuWXYwcHNq?=
 =?utf-8?B?eUVmY3B1dTVtU3M2Ri9ZMjdUekRBcjhwYU9VL0t4YkVsaVdrenFVNXdGbm5F?=
 =?utf-8?B?VHVIQUtzWE0yVUhlVWcvVGhSbkN4Z0szamVEa3prYzZwdWpLMzkwcGNpSXJz?=
 =?utf-8?B?S09kbGUxZ04zdmRHREt2NWtWWFlWcGNxTFgwbnJ1d3Z0bGtKTG4wdldmN3gr?=
 =?utf-8?B?dUY5aFJCMEw3dmJTMUtDYnF1eTJlWlVUVmJWNlNvR0sxcHdhT1h6QWZ6YnZy?=
 =?utf-8?B?ZnZOdDNXK25yYmJ3aEJBam5WaGVIVkp4TUpxUFVyN3dPYldXMlpwNzV1QkVF?=
 =?utf-8?B?Q3VRbVRhcXE1MkRKdTZXcWFnWVgvaUFqc1Q4SUYwVEtwenhYbWZsZGx2WmE2?=
 =?utf-8?B?VWkxZGhPS0R4bkdaS3RIMElkRnRvekdmblF3Z0F4aDZZTkVEMm5IZEgvMlpj?=
 =?utf-8?B?bFBXN05kQmdOazZaN3JhOFZyNmtyQ2JIbWNZOFRHOFFla0pkQUNvOHRKTko1?=
 =?utf-8?B?R0d6TVY1S2dMUlFnLzBTQW5qODc3c3FBWTZmOUk2YUk2QkhpVHFZYWg2YnRN?=
 =?utf-8?B?cFFaZ0xGaXE1UjJFK1hJOE1RRWY5TzVvc0lEYUtHK1dqeWhyMEVuYUFYajZa?=
 =?utf-8?B?bGJMSnVoSXI1b0V3NEZrYlRGYm5GZ2prSUllZE9GbFN6bkovUkVMcE1TbUhL?=
 =?utf-8?B?SFN3V3BhSGpESmcwOE1raUZndkEyUmFQOGlzKzh2MTNGWkdBUTIwZW4xNy9p?=
 =?utf-8?B?QjVSS29UcFozSmI2eDhGZTZpUjViQkpvT3QwTDY3aXpuZkVYUG5oU0ZVVjBQ?=
 =?utf-8?B?cUtWVGtXa2xIekFUNW9JSys4Slk3cUZOZ1RDRWhnaWcyN2UvSmErTk85UVZv?=
 =?utf-8?B?WnhOVVRFei85cERYSkhoOXhubGxEcnFUSnlYTVE3dHdNd0JITlg4STQwTjNl?=
 =?utf-8?B?eG9WVnNrSGNXRUpnbDZrcUd4VHN0NElTUVBJeFBrTXNGNUxCOWYxZ3dzOHo5?=
 =?utf-8?B?ZkUvK0J3d3NWbGwxODBMRlZxL0pYczBrdktNYkhialN4WkdnMmxJdlNwbG1R?=
 =?utf-8?B?S3ptQTV3SlBheWxZQ2xmVjNOSTNkaGI3RDFKeUMwVUVHWWVRcUNVbTJjemsw?=
 =?utf-8?B?S1BpUmdEb080c3g1S3o4bDJWa0pvYnhmVy9icVVFdkFDR3VFckR6dm1Sb28y?=
 =?utf-8?B?THk2RlE3ZlZRWU9iZlBwNTY5NU5Zd005R3hQcjhnemE5R3BZdWt3bGNGVGNQ?=
 =?utf-8?B?cXNDZFk3N2lCSzU3RVpRNmEyVGJxZlZDWmtLUGlRQXZoTjQ2WGx6TDdHekor?=
 =?utf-8?B?OFZobzUwdXNKclRUZmJxN053TUs5cTNraDJOSmRtdWMzNnFTSlVtSVlEcTV5?=
 =?utf-8?B?S2tuUnlaSzFvZmJJQjFYSUlYT2pnVkI1OVpUNmUxNWhORURJZ2N4T2RnRjZ5?=
 =?utf-8?B?azkreWNIb1B2N1IxOTl5UklGeHhEamEwbUd3T1p0ajJtWlVnc0sxL3lBQzNr?=
 =?utf-8?B?MXMzdjFlOVR6K3R1ajU5WFBHVnhIRlcrR2xDUUhEWStnSnZKNDBURUJaR3h6?=
 =?utf-8?B?Z054WU82c3dzc2gxQWRpNWpjVUJWcUQzNCtWdUxhN3pDMHEzUlcxVGdwNzNV?=
 =?utf-8?B?WW4xN3k0M2JQdVRjNit2SUdBWFl5cDRrSkJta2k1K2VPczlUOGJDdkJkY2Rr?=
 =?utf-8?B?dTlMck9yOFVGS3V5eXc0VkdrSVlLVS9HMHI4RTA4blVERkdyd0k3d0lJME12?=
 =?utf-8?B?TkdMUm5RNVU0bThoNXdrcWJ2YmpXVG8xc2RCaFdFYWhsbTAxQVE3RUNxZ2I0?=
 =?utf-8?B?b3hGOStiWVVGUm9BTFZoTnRFVy91WXlNdVQ1Z01YR0Vmcm8yZU5XLzdVMW1X?=
 =?utf-8?B?RGJvMlRuaTA3eFVQZ2RZZklod3ZuUU9ad2VqWURzTVNESzYvKytYZmtzemE1?=
 =?utf-8?B?OERNenZ0c1JRVFBkcWdZSHhLTUk5M24rLzJmMEkwUDdZenIzNVBkZzZvVWlp?=
 =?utf-8?B?YjNxR3lFYSthVzdKZFNFUEtEV1ZxMmQwYkl3dlRsWmNsVGh6WW9sNkJSNnJx?=
 =?utf-8?Q?4zPkS0WVPOLnDy6EoMKZS2dxI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	B0I16Jtl0NvRyXi5UTQQc43omjTvGbzos0WPT7k2Kou6QhnfyyJhmdbjFVJ3KKsBGNGuQAJY1UcWF095+pGjT/Q7i1w99f7Fgd5HHIkoa/Tp421dtTF+vV681YfolmY/2EFjFUcn+uZa/d3/vH1Vys3ACtgTA3ofLFK3UxAJe7iGoam50fwdgtEd0XzlkcYTVWoX1OsyRfzH3d4r3zWRU6Bte9zzAmkeZn5rn4cf7iZVVGiAla2ss0r//AGxwLhKvp6l7Y9zc4pcRM2SXdmtGEAkCO1K8Y1FZ7+Q3ODp4s78DaATkgNvJT4vEImy6waic7gW8+j8QdUHk6CbfHdA58yBgVNgg0eR7zqWQTOz/feRMGkAaiGjKCWN0psUergbX7edRl35kf5lmmfJZ95eXF9055M7AknahYVIQGxKVFMI8gVCDV7DxsIfUf/ENn5SAAskF0FdoXfjRPpJn2xqO1Skkdnf8gWBURsne3Y8eq6/6+LF5IfNNnhvygloO6xJZ/a4IloY2xEUXvIJ3R0soOeKKiom1tWN9Fxq9zFBpzt7N8S3uuDAq+mxZJby16QbrRPU1Jfw6Wyz/54rWjaUC+NMf7acd3TNQ2vL/yBKV38=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70bf3633-3b05-4db2-fbef-08dcab5e6275
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 21:28:24.8667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wx8v9j1DWIhgr6+QZzWEWQsE2HhUGX7UEdAyUUrkVoYRb1+Z8WYaolsP/DT/cPK0tTNTFJQOZpuv72ax1/1Iag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6017
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_13,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407230150
X-Proofpoint-ORIG-GUID: ZX8n45Ua7cycb33k8ZXHNrBLbQKwJG-G
X-Proofpoint-GUID: ZX8n45Ua7cycb33k8ZXHNrBLbQKwJG-G

On 23/07/2024 8:53 pm, linux-nfs@trodman.com wrote:
> I have a fedora server on Internet sharing out NFS; working ok for 3+years w/firewalld.  I'm going w/pure nftables on a new server. Does anyone have a recipe/example for setting up an NFS server using nftables?

I'm still stuck on iptables, but I imagine it ought to be something 
simple like adding this to your NFSv4 server's inbound chain:

	tcp dport 2049 accept

assuming you have a default accept policy on your outbound chain.

That's just for NFSv4 over TCP, of course. And you might want to add ct 
connection tracking state, etc.

best wishes,
calum.

