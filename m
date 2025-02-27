Return-Path: <linux-nfs+bounces-10382-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C998FA4824A
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Feb 2025 16:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76F1D1635DF
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Feb 2025 14:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FB625D91D;
	Thu, 27 Feb 2025 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="djc+QQmc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I+wwE7Fu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB2925DAEA
	for <linux-nfs@vger.kernel.org>; Thu, 27 Feb 2025 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740667954; cv=fail; b=TtvQNfgREd6JMndk75cPpfQvbWYnqK1wpBWpd6QrGJdIF5IrGSHqodgDvIi3PzifJ0uhwq1FkZrAEIePIKpS37P6OcMuU5KIEz/ba2Nkb34S1Sn+tpppz/awVzj1PPGoo9MCqAjF97mddgnkprR+KeLEy7CerP7G8vitVmHzxGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740667954; c=relaxed/simple;
	bh=ratNusKZOTbQDb3Kd2vgE22FdlPLLyGwQrGdJcqxNPU=;
	h=Message-ID:Date:Subject:References:To:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FGQXDt0RA9xORywPoJWo7vLSW7v82CSPr6LsztNjnmM0pGg16GMT8cAYX4GfcujE+eXKbi1ywd49rfsM0+dN1+Mozc2yZPEhhMJLgO6pP3l0uR+zwOX2X6N5z4bnwSG9pe0n5HkCsee4d7dvZYl2JfV/WptmuRBNdnwXh3Zc810=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=djc+QQmc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I+wwE7Fu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RBQXcJ029180;
	Thu, 27 Feb 2025 14:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=i9p5dw9EP91+qNuVHUDbz2gVcWxATMrsvOluvzcUTNE=; b=
	djc+QQmc84BmkuwGn3AOrvAK2p0pe0nsn/JrshMSIu0MwFlAKa9WUJh+WcZtZy0T
	k3KOZZdWDLHi/uOn0HnbKwX4//mqqEuvEomEqxaGzpIKTz/uG/4UTLbuZbGXj8Ah
	1yeJUl98ljy31rxB9O9Ed4zoRGG/zv6gzUo/PaeiHTpC/uY9BJJdTAHRqif4k7yC
	Z/caZoAMeBiAK/WpVEUqGfgVlcc2Hf6ozVhKy8gRCM7igd8s9xgdfrSfo5ayf86M
	ljpkmGTpach/j5D5ffz+p1AW19oGgoTCMsla2O/0SLlx2uyBeDFlO/l1l3wpUssu
	O8WtDS4kjA9RCQkTIBopNA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451pse3hj0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 14:52:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51REWwV5010207;
	Thu, 27 Feb 2025 14:52:28 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51bxfqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 14:52:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SxD9LWI/1J+l9MtgsOLSNZflleDF7gjwjyQHYalwscByiHmn/gGOEgcqS+hRK1uB89CcqapNPB8cVMBfLFHqUFn7UsDjT4B4fIP6p720evBb5Td85v3IB4lpe46VNE6G+RBYiabQs6EJsJ1ymSDFP025ZHI/ELi0QQsiONMmG/MVXNOKIx8gKjJmsyTfVJ3IDi+/pgWI3CnSsg5nSX8iA6YVFSjeWwR4U/Rz/Y3zxFtBx06Bp/mJ3dFML/YF7xlt/NeSpOe4yGQdH8No7dQT5Zj1h6cm7Kku1a/KeyInz9CUDWygVYJchOqVUWyEiwHCOKTj8TPCHfouiIhtETom6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9p5dw9EP91+qNuVHUDbz2gVcWxATMrsvOluvzcUTNE=;
 b=aY2ZROnJ4iM/AIxw9fqbrb6Ee1aYclJTtpAlIVg9QYHV76589nX6riOLZ4u6A+g6lyVGiZoz/9jc2lJVwkmesMF3rQQw4UGXEhgkxVfoD8Rw307odQMyYoGiKaKZQQ6EE4ibXXhv9/SL2xHcqw4TzRRSuZok9+lpC29Q72RMDj70gYeVaDOkgFSaoyTFyxhfRigzcKliS0ncUJLuvFgPuqLJ4R6dLzQ7RrSYmP8xxPJLsexTJI0Fe11JnwPrgxP0mNYWtWd/IN6TgyH9RZmE4agx0AbONskDcJQ4/xHPt7b1iMULLI83a3R6VNsXlU3IK5m8MmbnRW/A07VBd786MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9p5dw9EP91+qNuVHUDbz2gVcWxATMrsvOluvzcUTNE=;
 b=I+wwE7Fu8b/fNVA+EzK7BoN1ej5rzY0Jz4xSzAnA1Ve4BZWOn5r1dqJ5/zXe1TQu9MTr63hMRY143lZiJC6ALLTE0Dbs0EQXLJh1aZJx5ezN/lQSx8DoKS1WxBtejfC87rk15pAqWxFwBG4VK4iAH4SYs26VXcPFbrutUlz0+WA=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by CYYPR10MB7566.namprd10.prod.outlook.com (2603:10b6:930:c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Thu, 27 Feb
 2025 14:52:24 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%5]) with mapi id 15.20.8489.019; Thu, 27 Feb 2025
 14:52:23 +0000
Message-ID: <2c0bb168-4580-4cfe-a03e-997c6541d389@oracle.com>
Date: Thu, 27 Feb 2025 09:52:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Fwd: [nfsv4] RFC 9737 on Reporting Errors in NFSv4.2 via LAYOUTRETURN
References: <20250226234627.319371E013C@rfcpa.rfc-editor.org>
Content-Language: en-US
To: loghyr@gmail.com, Trond Myklebust <trondmy@hammerspace.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250226234627.319371E013C@rfcpa.rfc-editor.org>
X-Forwarded-Message-Id: <20250226234627.319371E013C@rfcpa.rfc-editor.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR19CA0022.namprd19.prod.outlook.com
 (2603:10b6:610:4d::32) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|CYYPR10MB7566:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f66b55e-183f-41bc-0045-08dd573e57eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|4022899009|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Yy91WmtBMHNrSEQwNEhCcllWZFRBYjlZckUvSjVWMFJSV2ZxVkRqczZId3Jq?=
 =?utf-8?B?Z1p6R00xejd5MTFEblJBRzQvTlM1a2xNWndKVEpDQlh5WnVjWEZkV1BGbVlS?=
 =?utf-8?B?WHdMT3o3enlrRG1jK0JpRW90b1V5Mzl2OEVtTUtYZ1YyOXFJdkF3cnFVcWFs?=
 =?utf-8?B?bExVNm9wejlJbGpWa0lTMyswZ0IxTTF5WXArSGprUlZuYVl0Mjlub1RzbUQy?=
 =?utf-8?B?UnplREJRTmhUS2dCR2tPSkY4Ty9OKzZXbkFqaHk3VGxxbFpveW9zWVhvWlFG?=
 =?utf-8?B?NnNHYUpJWklBSG5TSEt0OEU5WG1wRmFOK2cyclhZSDE4WmJ5NSswMmdNQVFI?=
 =?utf-8?B?ZjlaRWs0ZTNwOGhDWEVnL3BzbTJaanZSK0dmRkFNZWFDT3hVUmVzQWZPbWdZ?=
 =?utf-8?B?ZzRIWUhIcVNFTWxUb3U4RjZ6WFBPK2JxZ24zN1lOMTVGdktxbFBJb1RaNDM5?=
 =?utf-8?B?R3hMWTZ5em05N3Q2MHRqRmR6UjBXMUQ0SWk1eVBsN2ZHeE1kMUVsTW9xTzEw?=
 =?utf-8?B?dWxQQmhoaXFSRWE2QXVnQXBzalQvUEtCSEt4ekpOZllCMnoreHMreUh2Z24v?=
 =?utf-8?B?SFMveGVHVjJ1TjdDQ0VQVjU5SnpPeHg5WnQ0alVwTi9OYXVPMjF1U3oyQS96?=
 =?utf-8?B?RUNIdXhsZmdheTJTTEhkaEpPTzZGR05aSENFam1YeFNBbHk2cmVvUWVqeFc1?=
 =?utf-8?B?WjNUMm5USGdBTzQ0YktncWhRWTljWHNsVnBXTEljSE9Ob2l4dXdlNFpuQW8w?=
 =?utf-8?B?aFhMTnY5VTFoUlhWWFRFTGcyMzhKZ1pvK0JqZldYc3EyaHVSMWloaDRySnpo?=
 =?utf-8?B?Uno5aURhcU1JM29uTUlvUHdhakpyb1NLVGhYSC9lOXh0NzZZNlFFN0dCelFn?=
 =?utf-8?B?Z1N3dmlMK3Q2RVMrQjJIbzlHMmZpTEU3SlVEN09uL0I2ZVhjTVpYY01VREpU?=
 =?utf-8?B?YnF5cGJsNHlSVitFWGkxZmpjWFY1ZTl6TkpUUDJvLzRWZytTSlBMVlFXYjI5?=
 =?utf-8?B?WGw2K010VE9PbTRsek1IRk5HQmYwQjR6NldDM2ErUnh6REVnb3BHQUNlQjVi?=
 =?utf-8?B?cXAxM3RnRk5DNXF1QmNBUE0rYVVUR2dtNUJwdjhDb0RtQXMzYVhkV3Y0U1JD?=
 =?utf-8?B?d25XM3pySjlIOG03bkxRelFKSkdzaitMdmxVaHVnVHRvVGlmK2lZWVM0WmpO?=
 =?utf-8?B?aGhQVklheDl1N1JsZlRpaUV6OVo1L1BVbVQzNFRSRVlrMnA5b2pIMFlKWXVp?=
 =?utf-8?B?WlRaVzBjUjlUdlpHNnhCbUd2ZER0VzFtcUd1NWJPejY0S2xQUlJCZTREa0pO?=
 =?utf-8?B?WkxKclNxdTlkc0x2NWpwbzNvQnBFc1d0L0FuUjg4T3pJQXFpTTRVK004MTBv?=
 =?utf-8?B?Y0V4S29SWGlNZDlRV3E3Yk96Y1Mra0gwMnN4d2dWM3hBMndsR2s4ZGtLOXUv?=
 =?utf-8?B?K2NBek90cm56MmYwL2d3Rzh6Rlc3dTh1WFBBNWZzbzlLQ3IwMFB5Sk0rRGlz?=
 =?utf-8?B?NkhoeW1wOEd2TXVaeDlOUDArekhEOVdvN2R3UVdpdWE5L1VMT3ZBZHFVTkRH?=
 =?utf-8?B?YUdQOXZqQU5PZ2xpS3MxWUpNMlNmcGNIcm1keTVhSHE4RVVlcmhLZzZJK1Vr?=
 =?utf-8?B?R1poc0dhbjNyclBRdFlORkJ2NGNVZ2M4QnhqRkpuWGU2RzdWd3JaVnQxdStS?=
 =?utf-8?B?MEhhdnh5WDVESTBQbFpJblFsd3B4MHR4b21wV0kzVURseWNWSERIbC9scjMx?=
 =?utf-8?B?a1JFQjZDUDNJaVpBUGg5eEl2Mi9qUmdhVDJ1a0ZBbXYrNE91ekNoQ2FsVmhC?=
 =?utf-8?B?Q2p1QVBuSHlBUno0aHBlQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(4022899009)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2xKZ0pPcVFmZmxSQ1lGRjl2US94ZlQ1c01LLzJSVVBZUUY4MVdOYjY2NVFH?=
 =?utf-8?B?M3BSZThwZGFjZk5wMzdVU09zUENKZEduYkYrbWp4enBSTTRJUjBVd1Q2a3Vk?=
 =?utf-8?B?eWRrQm9lR1FhTDBaT1Y1aXRtY24rZlNQQ3ptWmcvVGFkbzBoa0c3M3NyUUxT?=
 =?utf-8?B?cVJSUHo0cnN2enNLa3dqOU5jaUp3bGlEYzVOK1RDR3NlMXF4SWFTcWxiU3U5?=
 =?utf-8?B?OE5LalFoUmN1MVlnQkNhdXRFMHNqbFBqTDVmMkxsNlhycjFEZDJWMjVjN1Ex?=
 =?utf-8?B?YWJQaUxYYjA3OE10cmtYVjN0bVEwTWpQTU0vTFNObHFwNE9CTHcvZnBKKytH?=
 =?utf-8?B?ZFJkK2J0YmZzZnJOYW5mS3pGOWpoUnJBMUY0YWgwU3ZHMkJ3RE5aRFlvV3NG?=
 =?utf-8?B?VmN2VzFtS3NIYTRWajJOd3B4TXdFQVRFWFAyMEJGTFRCSDRPWGpTdkladnhD?=
 =?utf-8?B?RGpsSDdWVjIxVzNIQlZDVmhjU0NmUWtLWnB4WmZNWXpBMDhySXp5alB4VE9D?=
 =?utf-8?B?aDU2T0h3bGVFa1VoZ1BFYTRIQXpScjdNdFFMWGZDMlNGV2FmTU1PbUo4YjRN?=
 =?utf-8?B?WkkxT2toQVBlbys2ejdmSUJhdmlFS0ZTMTlLeWRUcEtVcGFGNVFLZUVNK3ZX?=
 =?utf-8?B?enUrZzhQcXJGdnVSYmVvc012RHpWTU40ZVZTbENvWG1CSXRUMWwxaktZMVdI?=
 =?utf-8?B?K3pjRlIvbzd5eGt0eWt2Z2oxQlArMEZDamlicFd4VDR0c2ZOS3ZBSUUrZ0hC?=
 =?utf-8?B?VlM0emdlUzZGM3Fva0w2TTVzRDZUM254NGZ1bzRzckRZVDF1dEJIbWl2L2M0?=
 =?utf-8?B?ZlhvWk0wZnhnT2F3MWRLd09SZWZwK2xwYWpLaEc5aDA0NDl1dWw5bzdGOFQy?=
 =?utf-8?B?Z3plMHNtRmFUNzdudVlYc0hOM1lJaVhKWTlTLzQ3SW1pZWhFKzlXZ1pvamhH?=
 =?utf-8?B?WkJzR0RnZkFpQkxXVERSSHdFNU1kd2RNUVlmN3NLVVo0NGZhTWxBWEVBUHA3?=
 =?utf-8?B?NFBobFlWNG1NLyt3ZWZVTWd0K3p6RkVQUGsrSkNPRzVjb2hqNThBaDc3cG80?=
 =?utf-8?B?N1pNZHZjZjZoL013eEptR3RUamZaaGxBbDNlaE1DWS9rMThQb2VvTVdKaExT?=
 =?utf-8?B?bVRDL0hLR2hRVUxDRXpOZ1R0aENZR1dEVHYvK21PcGFmZVZyRGFuTGMvSEtk?=
 =?utf-8?B?VDNlc2RRZGhFY1NDbzdHTmhRVUhMZnRvMmxCS0lGbGxFdytEZ2IvUGZMVXhR?=
 =?utf-8?B?ZlZYTEF3NWJMMDN4dHVrcHpkSmxLdUluNDBWNnBFbTFFdjh0dE4wOE9OLzQ3?=
 =?utf-8?B?WmdDZ215YTIzYS9UOGpiZWVaZ2gxdXlCekRjNy9xNzVBazVqam9HZDBNUWRX?=
 =?utf-8?B?S3FxWXAzS1FDc0xuM09KeVlTWjFINEJvTGhGSWZpOGNDUll4U1I1NWYvWXRx?=
 =?utf-8?B?K2RMU3RlMXBCRlRCUWNxTi9tbk8yZUpIYmhTNTJ1Vlg4ajFlRmZFMmZFbGtM?=
 =?utf-8?B?QUV3NVNBcVlkS3pCZzQ5WWtMTmhNQ2VXRFFNb2VuOU1aaUJIN25FUXYvYUZo?=
 =?utf-8?B?L1pYLzJHc0tBWi9JOGlTYS8vL1dPVFc5VlBta1grRU1VYU44dzRLamtiUHRv?=
 =?utf-8?B?YnRsQ1MyL3VmUTcvV2hOdmVyM3RIV29QNDdKQnRsMWswQ2xiY3ZPN05IcU9W?=
 =?utf-8?B?azBRYXNMbEVPTUo1d1NoTkIwSXhxNWpTVnVHbWh1NThXdWJFVDdxMVEwSkhx?=
 =?utf-8?B?QnFvUUptenBQNmRGSUlOWXZJNzdXa29FTWdkMTFGaG9JZHlCSW5oMjVjRGVw?=
 =?utf-8?B?L0RIZDQwOUVyMlJQNEk4V0dVSXVtUmVvNWZmMmZmVVM5VHY2dEVhSGVpUzly?=
 =?utf-8?B?WEwxbEpnZUxUU1VUeFVTckJWelBwVDVKWE5lWGZvWVZhdE5TTXZ0cmE2bWk5?=
 =?utf-8?B?QjFPckFCUUV2NnV3WkZiODg0SjFvOVFLK0c1cE93aUVPQ2FBMnd6bi9Qbk82?=
 =?utf-8?B?enpiNVV6bEI0R1VpL3hKa1pMa0ROL0hya3FCQ1plblNueFZ2SkFYS1NlNTI4?=
 =?utf-8?B?a3dqekl0aFRacE5tQU9RMC85V0tES3ZCYWw0OFVEUnh3YVhqcTBlYnJuWnhD?=
 =?utf-8?B?WkxXV3Y1TjA0bW9QalFTTnVvRjRXV2xLSlEwb0N1OE9yT3hna2cySXpRSHdR?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	s67wi1RtcZlYXTNSfALWhY6tjpPTHCGvlIMk6MJOmoHxegifX6xyXPXsncE0taFXUUL4v++Qn37D5hO1qpUmr7C4hgbWzEpohDmhji8/Fmfh+0qKFvsje92MOKZ2xePlsZXL5RtU4Z/YEWBHFbrIAkVkL9ROCw31+DGk0YXRKJJLLoyhMbURSgB2fhIUkJptFNRNgnvC2IuMrgTwjS3lYmakHEeUw9EP0fSATov2SzEgsafZtPK8VLzH5NwcppaklyoCLWHBlUvIkbFcp8wyUAhBMf5/NGDL61jgiDo6lRa8MwGf2/hmrRZAON6oCirg/BXIxXFse2NQZOm0dfFn7SYGLsTgNPpzRKvG2SNElD5HlDa5P1v5LkvSOGjBNKscLHWZXFyeg54MAax1gJ1npzc9AdFPHas/T5Bhj5mmhDt3/Xzu1QAiHuXT8pQ7XBkro+GUpSqSubAw4z6O5XviPB/YQ7B6VEWX/1GC5j2MPwrILl+1KSxh4P6UR7Q2NWnZiFcUeB4z/IMj8KQz4apKfYZQ9SzLcL0v0vJinfZC8AmUDyUybqSNery2eY07avR/pxeHpmvO9YI8fY2o8sCK16jh6Z9UzxqrlmeIieYZzCA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f66b55e-183f-41bc-0045-08dd573e57eb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 14:52:23.5191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bm0drayE4PbCLx9zAzznpn3TFPoJZG1lk1M9z7o7K3JTchCNTkyMohPfAE954YSlv5DxkfV/32N9ViZQEZGN2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7566
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_06,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502270112
X-Proofpoint-ORIG-GUID: TrkpLlSPsIUk0xRAAX8-gqi4gMNG3jdD
X-Proofpoint-GUID: TrkpLlSPsIUk0xRAAX8-gqi4gMNG3jdD

Hi -

Congratulations on getting this published!

I'm wondering if you have plans to implement the protocol elements
described in this RFC in the Linux NFS client and the server?


-------- Forwarded Message --------
Subject: [nfsv4] RFC 9737 on Reporting Errors in NFSv4.2 via LAYOUTRETURN
Date: Wed, 26 Feb 2025 15:46:27 -0800 (PST)
From: rfc-editor@rfc-editor.org
To: ietf-announce@ietf.org, rfc-dist@rfc-editor.org
CC: rfc-editor@rfc-editor.org, drafts-update-ref@iana.org, nfsv4@ietf.org

A new Request for Comments is now available in online RFC libraries.

                RFC 9737

        Title:      Reporting Errors in NFSv4.2 via
LAYOUTRETURN         Author:     T. Haynes,
                    T. Myklebust
        Status:     Standards Track
        Stream:     IETF
        Date:       February 2025
        Mailbox:    loghyr@gmail.com,
                    trondmy@hammerspace.com
        Pages:      6
        Updates/Obsoletes/SeeAlso:   None

        I-D Tag:    draft-ietf-nfsv4-layrec-04.txt

        URL:        https://www.rfc-editor.org/info/rfc9737

        DOI:        10.17487/RFC9737

The Parallel Network File System (pNFS) allows for a file's metadata
and data to be on different servers (i.e., the metadata server (MDS)
and the data server (DS)). When the MDS is restarted, the client can
still modify the data file component. During the recovery phase of
startup, the MDS and the DSs work together to recover state. If the
client has not encountered errors with the data files, then the state
can be recovered and the resilvering of the data files can be
avoided. With any errors, there is no means by which the client can
report errors to the MDS. As such, the MDS has to assume that a file
needs resilvering. This document presents an extension to RFC 8435 to
allow the client to update the metadata via LAYOUTRETURN and avoid
the resilvering.

This document is a product of the Network File System Version 4 Working
Group of the IETF.

This is now a Proposed Standard.

STANDARDS TRACK: This document specifies an Internet Standards Track
protocol for the Internet community, and requests discussion and suggestions
for improvements.  Please refer to the current edition of the Official
Internet Protocol Standards (https://www.rfc-editor.org/standards) for
the standardization state and status of this protocol.  Distribution of
this memo is unlimited.

This announcement is sent to the IETF-Announce and rfc-dist lists.
To subscribe or unsubscribe, see
  https://www.ietf.org/mailman/listinfo/ietf-announce
  https://mailman.rfc-editor.org/mailman/listinfo/rfc-dist

For searching the RFC series, see https://www.rfc-editor.org/search
For downloading RFCs, see https://www.rfc-editor.org/retrieve/bulk

Requests for special distribution should be addressed to either the
author of the RFC in question, or to rfc-editor@rfc-editor.org.  Unless
specifically noted otherwise on the RFC itself, all RFCs are for
unlimited distribution.


The RFC Editor Team


_______________________________________________
nfsv4 mailing list -- nfsv4@ietf.org
To unsubscribe send an email to nfsv4-leave@ietf.org

