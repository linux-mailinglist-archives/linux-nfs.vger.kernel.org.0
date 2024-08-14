Return-Path: <linux-nfs+bounces-5358-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01901951AA3
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Aug 2024 14:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD70E284309
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Aug 2024 12:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6062C1AE849;
	Wed, 14 Aug 2024 12:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DM7LX0j+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Jsqreu76"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11AA1448FD;
	Wed, 14 Aug 2024 12:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723637716; cv=fail; b=eUL8/ejJbrJnFSHLBdnSMk6Fxpm4a8U/0rYY95IdiVrjsSOQn1+pBNjC7sArDxSxCO2M8jdKfgA6QfI8nJVD9lm3KtpOWal64DcqzftCZ4RwSgFeeqXE6O2GH8u9YCB12g9/Z/jX0GFBf7sfyGscEME4v9RzzAcYlLtEOULsyjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723637716; c=relaxed/simple;
	bh=ucN/GFRGrOZuUa8eOm4MAdxznYEeVv3MLOrkVcSuB88=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AuW79BGBsfI8EMJWFpTfMfW1Kv1hehTTiVaG+8IgECpf2BkvoYORhJIj29/p30A6JIkIptsReUjJula0RBdb4SK6wSGXIYJDfz+7K966IGPSm8acd/XhxDcEc3qD5TrHdLXazddi1sfoxavu3Z/+wMgC6lJYcyl4E6FA0NDJBOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DM7LX0j+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Jsqreu76; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EBtWjP023325;
	Wed, 14 Aug 2024 12:15:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:from:subject:to:cc:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=VTUrdncGMCiwcVUmbPtFHsEIIStPvzRMAIp2l1rieRk=; b=
	DM7LX0j+V9Ax5rrmVz4NO+7w9PzkE2rKal0nzt+hO6Mi8c7v5XGTikhiKAdkprDa
	RnfHGXPH111SdaSfmIBu8ZYasl0eQmEOkt32kiqSn7k0b3YWzY1NqecVpHJGI27A
	/A0b3Y/NemLkGPeWcXzHGY+Lxeeu/08VRb2tTPS1X2GIVP0iKyNIx4fQlSx9oRor
	US4JtmNH26bcDpZmDnH8J6FD5M0fAoPhlWNMina02GpbcCBsDMECiFAnHJPnrbMV
	UhA1NHLmeRadJ4QcnRfL1iRLx2MtseCdqCw626XfuuZjmpAyY43M56tLZ3dfLbvf
	0i+BCAniChMhtRCcxkC6kQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4104gajt0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 12:15:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47EAGRPm000661;
	Wed, 14 Aug 2024 12:15:04 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40wxn9s7v4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 12:15:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K0l2GSHPx6tuUhjYKnTa0So36I7PSzkDJ0JJQw4bim48Tj8OWQJw/5Wb4NWaFaN8OaUeaJFFgxx4ZQAOPM7OM+5nnuycnWu74/InvmIWYdKyD7ckHNd+hYzQBkijf8IqUIABO9SSlN16FWUIjQhK1lMdfy+qUwQ+VHZ1J6K16Mp8a19FKXg/ZlVcMG2V9WAcSNtSKLnLIhQntR14oyOoPx8wGj9GvXSK6urBAZx9iLtKi+qWzGs2xl5q4Hi2CS4z57yACZXaXu2iFOL1kT6oMk6o+gP56PPVyP5iQIVzsVF7TQbdKc19WHEvlbyBq75GGy8yOUJQczCxyXaUFofdHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTUrdncGMCiwcVUmbPtFHsEIIStPvzRMAIp2l1rieRk=;
 b=WF7PYj2VA8slbH+Ibp/PxRQoVAytvzeEgvFrPElrA0c8euSG064hD+mRXs3vW4cr45DQLCaVZTg5iDjm6kEvF7Rj0ez4eCNxYhWct0iVqdRcV1iHUD709uPri2fUFOS/YbhFghEBX7yEgAJ98w5BraY4GuRzA7HfU4CkbAJmN9vDEJCzt095Hdi/2q6wzw+Q808nH5Wip1ox+JfqsBUHZCrgm5I2EdwP2ypmeafGo+k8fLjgqJvMZRxxwjuo6eC8hpULx2REcc9Z3YCxwu7W4tqmhCXt+CWH9+r/hUpQd+3OyytoM1LUxZbmCTV9qaC3W+LR9lXyEb6BWTkM1gaQyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTUrdncGMCiwcVUmbPtFHsEIIStPvzRMAIp2l1rieRk=;
 b=Jsqreu76jkKJeC2Gv0pXCwBnvWtxcQw9746J8yWAVTiph4eVJV8fRrzabdbOW0R/1nweEeWjiXWtHm/0mGueAveffmzmMRpOAK1davTvW9aQI+33hLmNINuOff2S28sy4BzPMdM0Wk3fu3nj3UHuOu1Pv8lY2NXw0F36CMhew0c=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by DM4PR10MB5943.namprd10.prod.outlook.com (2603:10b6:8:a1::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.15; Wed, 14 Aug 2024 12:15:01 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7%4]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 12:15:01 +0000
Message-ID: <ef443b13-d633-4af1-985c-86054211ffc0@oracle.com>
Date: Wed, 14 Aug 2024 13:14:56 +0100
User-Agent: Thunderbird Daily
From: Calum Mackay <calum.mackay@oracle.com>
Subject: Re: [PATCH 6.6.y 00/12] Backport "make svc_stat per-net instead of
 global"
To: Petr Vorel <pvorel@suse.cz>, cel@kernel.org
Cc: Calum Mackay <calum.mackay@oracle.com>, stable@vger.kernel.org,
        linux-nfs@vger.kernel.org, sherry.yang@oracle.com, kernel-team@fb.com,
        Chuck Lever <chuck.lever@oracle.com>, Cyril Hrubis <chrubis@suse.cz>,
        ltp@lists.linux.it
References: <20240812223604.32592-1-cel@kernel.org>
 <20240814074559.GA209695@pevik>
Content-Language: en-GB
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 smRifw1wGg==
Organization: Oracle
In-Reply-To: <20240814074559.GA209695@pevik>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0692.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::15) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|DM4PR10MB5943:EE_
X-MS-Office365-Filtering-Correlation-Id: edfaf6be-96fe-4490-afa5-08dcbc5ab8e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U214TVNXdzFPTDJkQ3U4S3ZzL0I0Q21tYVlOZ2NiK2ZBTFpxL2hHRm4vNWRM?=
 =?utf-8?B?QmJsb09aRUdHUXI2YzJ2NVRHUmd3WmY0OElNajVvWkFXNjJta09NSjVBdC82?=
 =?utf-8?B?MzNiaDlady9EdktZWUNBcWIvK3JZbWFiNVJ4eVZyMWQvZloxNWNkSGtWWnVm?=
 =?utf-8?B?U0w1WXNjd1lldnZrQVM0MTB6Q0k5YlpVd2NGOTJOekhndEsrcTlGc3djZUF5?=
 =?utf-8?B?R0c4cTF3UW56YTNuSGwyZ25YRW9ZUVZzRENXalJGRG1XVjdaQ3YyNCtwYTQz?=
 =?utf-8?B?YkZLWTdJMlNRNGFKTzkxdWNWZDFLbjVTY2RKU2U5VlBGeitQTXpzM2hNOUVF?=
 =?utf-8?B?UDNvMVV5Um1LcmU0ZXovK3RaOVNCRzFEUUdoNEpWV2tXYzdZVVFTK1RsQ1E2?=
 =?utf-8?B?WEZSRlB2dGl2Y21Cdm1LWW5UUW91STBUTE10dkY1QzN6OVZBWEYxbmFVN2xo?=
 =?utf-8?B?NUFmd29wRlRSNEtweUVSemhTOGNvUWpmQS9maGtGVVNaWmtrdFhKK1pBQmJC?=
 =?utf-8?B?YW5IUUp5KzQrdXBaUFVGdEpqTi9YR0NBSkszVHYrTkdHL0RMQXhnRUthY1hr?=
 =?utf-8?B?ZkZha2dGOVVxQ0pGQW53M0pnRjFUVERYNVlUWUVNRmtpRzJDL3l5Z3BqRlN0?=
 =?utf-8?B?NHpIY0JUb0hBZWxXemp3cXRqVWhjVGVnbERZRm5JSkdXcE1zZXhiTHZmaUdv?=
 =?utf-8?B?N3EyblkvM1M3TFZUNnRuMnJBNW5DamVDY3hKT21URTRULzJ6TzZhMW8rSExV?=
 =?utf-8?B?VHM4RGRwLzlIMS9SY2xRTkVEVm5WdU8rcGtDSDd1TGhJQ2ozaWl3QmxzVHAw?=
 =?utf-8?B?ZzZ5RHlWS1FqNXpPMzI5ZE41ZDI4ZnZJalJ2REhOTW4vUWd2Q28wZm5yc0tH?=
 =?utf-8?B?MGV0c0VXbkxtaHdrOTZlbWNaNmhiaVJaMHc2T1hYK0dpOVNJWGM0TmJ6SUZP?=
 =?utf-8?B?TmpTcmNRUjFZMG4wZUtkV0F6WFExYkVRallWT2xzQTdaOWNhcHRZTHBPWXZy?=
 =?utf-8?B?Vzh2OEJ4REFoR3N4U2V3Tlc0b00rOWl5TVQ1U1JMZXc1SFZSbHkxdUR4b1FS?=
 =?utf-8?B?eVg1Y0E5SGJySUhFNlVuR3lyRjM2QjR6ZzBZNGE2Y0I3VkE3OVZTUEtsSVlD?=
 =?utf-8?B?ZWxCckNBQmtENE5uVkQrVEV6UFpHSjJ0Z0lIWHkxcVFCMmlheVBqc0p1RmZs?=
 =?utf-8?B?RlVOc0sxdm05YnJPZUJFZWo4cFU0bDh1QlE5a1ZYRGdYck82VUpxYWtYYWd4?=
 =?utf-8?B?aU5CamQ3MFBQVzJhZk41S0VnNmIvOXJrZS9FL0NuUGhDeTIwRk1vS3VkeCt0?=
 =?utf-8?B?YXhKL0REK01LWVNlY1BjM2w3ZkpsVW8vbmJIaG80NG9oVXZuOFRQYlRPMVZw?=
 =?utf-8?B?SmdEQkM2QVpuUUY2dE9kZDNnT01IY2RCTkJCdTBuWFFackhkazkyRTUyVmRM?=
 =?utf-8?B?Tm1lS1prbHJBR1ZzMWRTck43YlUvTzB1R2M1cnk4M01SNGpsWXR2SXg2WTJT?=
 =?utf-8?B?UDZzWjRmcmtQbTV2N0gzbjBTdzhMQnJLNEx4TndwQ1Bhd2VMRk0wRVJ4OUx2?=
 =?utf-8?B?dkFNb0lkbGsvcGthcDhrbFY2UmZtZ2xoVGc4b1RwQTAwOUFhWnFmb2x2Z3ZE?=
 =?utf-8?B?YXd5Rmp2WUlxYmN6TWRDbFVORlp1eFEwTUc3ODJwbFZVQ1pRQ1VnZ0FNL00r?=
 =?utf-8?B?YnY4RmNiYlR6VXI0VEZuazBqdmZpWkNFUUg3YndUVzMybUdqVjc1cW45U2lC?=
 =?utf-8?Q?18UncvQNlXyShS6AIU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFlrZWZFK0k0QlhWN0ppdStxQWZZbHNlait2ajNtVS9jbWpJcHArZGZVN2JQ?=
 =?utf-8?B?dlUybEZjak5QNXQ5M1VsYWhLTjJ3Q1RGZVJRQnh4WGcyclBOSVAraW1qNGIx?=
 =?utf-8?B?V2pxeDdlS1FjZWlMVFVnR0RxQWU3c2Q2V0VHNlVBckp5d3N5SG54V1VEVVp2?=
 =?utf-8?B?QmRFZ1lxUjhUa3dQOVNjbkNXQTcvVVBSNFVtWXA3Q2hGVmRvL0ZFNXg4QldX?=
 =?utf-8?B?OWZTMVlGOWZ6QWNhYlRPbklBWVM1bDBFWXFHSUQvNjVEak1yTVJXQ2xJUHBs?=
 =?utf-8?B?eTFYWGd2MTgxd0tKM2FrMXVpVHF2UUNZWkdQWk1JeFRyQWtDSTcyOExEeHI4?=
 =?utf-8?B?bzJBOU96YUFWY2V3V1ZKUEpCNmZGeTdkUUVEWFBVaERhL0pRemdhcm8rY2tt?=
 =?utf-8?B?YUpyb2dGbG1zL09KajlaYXpqcVlLdHRIT283aGkyV3BINFovR0FPTTk2Rjc5?=
 =?utf-8?B?bjBsMk03R3M1cC9iUVYrcmdReHJDYUxVbW42UVNNai9mL3g1WUd3KzVBNTRn?=
 =?utf-8?B?YzFyQ2xmeXh4RlZjVjd2RzFPSVRVbWF1RzJxallJMklYdW9GOWgyNFBqeFdZ?=
 =?utf-8?B?RTVYdjlyek1MYmgrSnBBc3k1bEdZZnYvdlZUa1czejZXZDU3SjNWcWhmdUIv?=
 =?utf-8?B?TFlKUnlmNEFUSUtTbVlwZjZ2cHJCZ3lQUDYzTEMrYkp3dVVzYzlGblpUdW1M?=
 =?utf-8?B?bkRRTGwyZTVWSDU0YzY4bktUYjRuZDBXNXNwaEQ5RkdEU0RmeUdyd050SnRy?=
 =?utf-8?B?bUVoOHNhMy9yU1BuTmN4R3E2NDBBL1Z4Ry85QWExbWRzbFVTQ2lUMHBvU2Iw?=
 =?utf-8?B?OHBxQW83T2RrN25UNSs1UTZ6MGhMNGg2VGlBOXJLbTVDQzlnUUNjWkpzYUh2?=
 =?utf-8?B?SnVpdzh3T3NZUCt1ZHJlbXZUelZaQW1Wck10amt5NzE1ekk5UzhhYy9KSFov?=
 =?utf-8?B?ZlJCU0M5cE91Mm5OQ0Nna3VzaGgyK2hMSmU4R0F4citlQW9TNjVmNVBka1RG?=
 =?utf-8?B?UUR6cDI5R3JiNE5YaWVVdnU2R0lleUxGZGxlWmVUeDNIc0ZIU0ZuZDZ5NTZK?=
 =?utf-8?B?eXR0cVJLWGFNazJqSGZ5VzJnNGxIMStlWmozcm5Rcjk4bmFVVFlpN3gwUi9I?=
 =?utf-8?B?TDJrVlVJdUpxMFFVUkE1MmozN05CcTJCVHNINVA5eThaUDFKenRUbTJVN3hq?=
 =?utf-8?B?NTlURzJEQjFNZ09SVXg2RW42VU5DT2c4N095dWFXb09Rcnhjb1VqaU1pd0xq?=
 =?utf-8?B?U0YxZGZFK2pLM1NLTUlseXRVdEpoZ2x1a01ZektoQmRvQm4rVUp2TXJTcG40?=
 =?utf-8?B?a3BGeEhpWi9CWklpWjR0Y0dvUi82OXQzdzZ0ZWxLY3diSFk0d0tYRkwxZDFT?=
 =?utf-8?B?YXQxMDJ0WGk4UHhwZzJ5YTlpRUtsUm9NMkVCZ1VhYnVBbTBzS0Y0R0hoOENH?=
 =?utf-8?B?aUJUeDFuR251TnRld2ZwWnB5RzlGTWxVa1NyN2QzYkFvbFZMcGhkOFJEQyts?=
 =?utf-8?B?VVZuUnd1RXdXMjZnMVJtU04xQUVMakRKbmM0TW9YMW5tdlR1RVBMTFZZSVNZ?=
 =?utf-8?B?TWFVNlMxcCtCRkdMY2VEZzVhcWQ3MlFKRzNmcW0vWHFxR1ZhMW1yMnpwaGVk?=
 =?utf-8?B?TFZEeGZhNkJaMVQxeVBaT2ZkelFMWUY1aHlaVWp3bVJqbGVvd1FHQXRIMXp0?=
 =?utf-8?B?bUNVYktpUnVTNGlkVFJHZVg2NWY4cWs3anpRUnQ0TDFpdWNveVpSKytYNG8x?=
 =?utf-8?B?cVRqT0gxUXFpellpSEN0endoeTZ1Qk1ZZ21qV0lzZnFwcmg0MExsV1NVOU1O?=
 =?utf-8?B?TXZha1RiSCtrTk1JaHY5ZjRaTUg2NzFqbElWSkFPNzRsR1F0cXRmNWNIOVV6?=
 =?utf-8?B?aFBpUWd6aXB3SmFkSjhJWXIybTNRWXZxa3ZuTWdieTRqeVl0ZHlZdGdCUU1k?=
 =?utf-8?B?MGJlTWNhcjdySjd3ck0xMlVrUjBhc25rRkZ1UXNqUjNrMXJDeWR5ZnVUZ0V3?=
 =?utf-8?B?YktDL0lXQmg2R1FvR0lZN3dITmZjd01jQmpSVlRUY0cxY3JjY1JvY0huOUVz?=
 =?utf-8?B?VHIrcDJuZUdtTDZncGlhbFBKNEJXNElxc0pOSEFYa1ZnR2ZhRTlaellsS2lQ?=
 =?utf-8?B?ZU81OFhhNmU1STd5aThmdkpHVEs0V0pkS3U1aElHTE5SbUY1UUFaQnlYMFNm?=
 =?utf-8?B?aWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LU2SbcBk10wlcCUOdLI5T0yDrHMdb49iyy/7y7E8Ks/hcG87rXjMRGXvbCvZvXf9ONhSZtnEV3Rhp/tH2MlMDsKCaq5mS3U0u8kL6ATRuSiRE3q6wBzpPj347GA/i7UYezwQOuAzhotm8QxLSQPLBMZwZGglSRpNaUEp3CKcUQtrhIvSajj+F5jM5PUEZLhlfX9VYmN2ISa+9xcHBsnmiHSzW0EyHKVK1qoRQNowsUICLS6w3BE71JJ32MQCNZ82EEMO2UF7o1DAyKRN5rhBxiZfmAviaP0gQSmbJCWyefoOKy++9IBvVVEOPIysJqpSAG784+wNlYt+/QE7EWp1Z/GPTn0i7kgEoYi3HfyC1mnaB9Vuh9fb8KUIRS6vvSM7MtKAPU0dfFtwfjm8IKBmBuG4CNxfEgwXn6t4naXzMbLfWYuYSRw+Ivw+a12uDZWAoHvYS/UYoTRTn7NNalT8Xb/NmO2LqqhVeWteHV/35jEMxvpuCl+BP90uvedMt93Et920uqHRfjJ66iC1Cxly/K5YtLnLL/8ZP+J1Rqq3ifzrpftnX/cM+8TE2Kq2IyUtDlju6OXy0LWupUcXc0UhUDV8QPiMhXm7Sth5DveXJiI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edfaf6be-96fe-4490-afa5-08dcbc5ab8e2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 12:15:01.6135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3hDOs5v6L53Oevc07Cjs6u8XJ+Bs8zegxYE6VPQG1hat1kd/tjMYkI2jK/gR65JCR/mH0kMbLm00mKoKiKBvuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5943
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_08,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408140086
X-Proofpoint-GUID: wNUAzg3IAX3hFka8OImtX2-pY1scn9P4
X-Proofpoint-ORIG-GUID: wNUAzg3IAX3hFka8OImtX2-pY1scn9P4

Hi Petr,

[resending for the lists, owing to blockage, sorry]

There are two sets of changes here, for NFS client, and NFS server.

The NFS client changes have already been backported from v6.9 all the 
way to v5.4.

Here, Chuck is discussing the NFS server changes (and others), which 
were not backported from v6.9 (actually, a few were, but only to v6.8).

Thanks,
Calum.

On 14/08/2024 8:45 am, Petr Vorel wrote:
> Hi Chuck,
> 
>> Following up on:
> 
>> https://lore.kernel.org/linux-nfs/d4b235df-4ee5-4824-9d48-e3b3c1f1f4d1@oracle.com/
> 
>> Here is a backport series targeting origin/linux-6.6.y that closes
>> the information leak described in the above thread. It passes basic
>> NFSD regression testing.
> 
> 
> Thank you for handling this! The link above mentions that it was already
> backported to 5.4 and indeed I see at least d47151b79e322 ("nfs: expose
> /proc/net/sunrpc/nfs in net namespaces") is backported in 5.4, 5.10, 5.15, 6.1.
> And you're now preparing 6.6. Thus we can expect the behavior changed from
> 5.4 kernels.
> 
> I wonder if we consider this as a fix, thus expect any kernel newer than 5.4
> should backport all these 12 patches.
> 
> Or, whether we should relax and just check if version is higher than the one
> which got it in stable/LTS (e.g. >= 5.4.276 || >= 5.10.217 ...). The question is
> also if enterprise distros will take this patchset.
> 
> BTW We have in LTP functionality which points as a hint to kernel fixes. But
> it's usually a single commit. I might need to list all.
> 
> Kind regards,
> Petr
> 
>> Review comments welcome.
> 
>> Chuck Lever (2):
>>    NFSD: Rewrite synopsis of nfsd_percpu_counters_init()
>>    NFSD: Fix frame size warning in svc_export_parse()
> 
>> Josef Bacik (10):
>>    sunrpc: don't change ->sv_stats if it doesn't exist
>>    nfsd: stop setting ->pg_stats for unused stats
>>    sunrpc: pass in the sv_stats struct through svc_create_pooled
>>    sunrpc: remove ->pg_stats from svc_program
>>    sunrpc: use the struct net as the svc proc private
>>    nfsd: rename NFSD_NET_* to NFSD_STATS_*
>>    nfsd: expose /proc/net/sunrpc/nfsd in net namespaces
>>    nfsd: make all of the nfsd stats per-network namespace
>>    nfsd: remove nfsd_stats, make th_cnt a global counter
>>    nfsd: make svc_stat per-network namespace instead of global
> 
>>   fs/lockd/svc.c             |  3 --
>>   fs/nfs/callback.c          |  3 --
>>   fs/nfsd/cache.h            |  2 -
>>   fs/nfsd/export.c           | 32 ++++++++++----
>>   fs/nfsd/export.h           |  4 +-
>>   fs/nfsd/netns.h            | 25 +++++++++--
>>   fs/nfsd/nfs4proc.c         |  6 +--
>>   fs/nfsd/nfs4state.c        |  3 +-
>>   fs/nfsd/nfscache.c         | 40 ++++-------------
>>   fs/nfsd/nfsctl.c           | 16 +++----
>>   fs/nfsd/nfsd.h             |  1 +
>>   fs/nfsd/nfsfh.c            |  3 +-
>>   fs/nfsd/nfssvc.c           | 14 +++---
>>   fs/nfsd/stats.c            | 54 ++++++++++-------------
>>   fs/nfsd/stats.h            | 88 ++++++++++++++------------------------
>>   fs/nfsd/vfs.c              |  6 ++-
>>   include/linux/sunrpc/svc.h |  5 ++-
>>   net/sunrpc/stats.c         |  2 +-
>>   net/sunrpc/svc.c           | 39 +++++++++++------
>>   19 files changed, 163 insertions(+), 183 deletions(-)
> 

-- 
Calum Mackay
Linux Kernel Engineering
Oracle Linux and Virtualisation


