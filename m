Return-Path: <linux-nfs+bounces-14007-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E03B423E0
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Sep 2025 16:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C44911BC30BA
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Sep 2025 14:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7014320010C;
	Wed,  3 Sep 2025 14:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QwCo3djy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jV4uDkJA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846C220296E
	for <linux-nfs@vger.kernel.org>; Wed,  3 Sep 2025 14:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756910338; cv=fail; b=aC64/Krkw9ieL9hdashBQmocAXB0yqJnyysOux4YwxFOke8Rxz2W+RsXW8SWlhwSCPwbw9wRUy58b1FVP1HwWdQDZS5/I53t3mmhcPkj55MI7dmOSX66TqGdTEK9hgduLL9elpP3qNe3IlKZ4tJtnl9dPABkY/4yY0+mAi+ozsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756910338; c=relaxed/simple;
	bh=DCSWGJyNt2Ziftl2olqeC6sWJSUwAyEoMrEw+FjY320=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NZAx9hsu3eFzNdUW8fsNSSiMLzTCUZnEoUsXyRBB7LqLlhxu9LeCBSU82GAbOH1KDpJz3+B2gtgGdDPY52YIi8iL0NB7xpBCxwIwomfMdzm24gaLhHhXGSjfP87kqCmrcpn1xglMpUt4xg0KwT38Ujs/L8M/3Hjfa+Mu19w4u3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QwCo3djy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jV4uDkJA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5839NDYw009103;
	Wed, 3 Sep 2025 14:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=NWGYtKwlLZo/UTCs3GZGBYHG8CYWnhPrErMnP/+1iTw=; b=
	QwCo3djyWuXPONINd+Efkw01XnuRCJbPT5264+D3U2FVU2jtcBHdI1ZX2bb4vv/X
	xOQHs/VJ8d03ndse619ADvTtpGguM+I0KQW2DdUSK9VeTELay11o4eRbZxhS8K9a
	ZHamZo5lkf7AyG8tGeLboeemKGDQwYBHMCFWHIq9sBWIklUnO1FTlW9GZLH0n9N8
	t1XUTjNqUOdK17euTBbGbdN0dZWCOWQsKpaZzw8e9R+x4AT6EfM6Ct0AqpkYNVy3
	/ifLybqCSY0zk5tUKOo7Yhl10psFqj2GJ+ujmb9JEHjsZ2kH6GxskOOUemWPC9U+
	DyzJjh6fGNOZ0F27LIUTKw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usmnefm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 14:38:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 583Dj6lw036224;
	Wed, 3 Sep 2025 14:38:52 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqradpmb-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 14:38:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FkLhV4B0iPhoxaXZLINEfS1cKY2Y1FHCKMOo10jBiZi3cmS0iUWWth3VZeqhDAHO4V1Dcdm7NlZGbXSJZ5qYdyirGeBwrcvFTNV9rAnYtQNAiLUz35XBM6q6AQihJno1LGyWYo5IoPKDtCJbIsfl0ZvCoWrcBH9WCcTdmTljxflWQYnHKvcRFRN7yADlGNdC6ku8xBOhDtj76qeVIzBObxymhg4dN8ASrWHlZEBca2zNzVpCNm/F56u557GH48+ndnPUElcgNEwsWZgaPFG5vb2sKan9pgx0PEUL6JkbtdUujXO+LvViD1h42TDtvkbxKE6aE21SFoC2kOZ11w6ltA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWGYtKwlLZo/UTCs3GZGBYHG8CYWnhPrErMnP/+1iTw=;
 b=OJJ4BYFD98fR74MvlsfO7J7kzb8bOPWkdzJzoRr3zV9yLWw71J31lkPpf8Cfzsxr+iNmM8MOwRhS7CbFqsgH6EWoxz+I3k8I/vu9d8a/6CiExWixDa9X5TZWKFCKVMSNTN1Q/kqxNIqnCR53t6d61KONLpVHpOAKLT7M78mRb5pd6VUkCGB0djllb+WmkeLjk1phwpcdXAvxZfzDiPQBocchghRX85rZPInfq1+ZRkjjnkB9gwrUNYE696AF7dBxnC84an5ToUpMpwDDBCz5KXXdixuAtrRtYX0WIWPT9DTc77KkruH1p9rD55/5DR8At/aZ9XAEUKZ0Dgx7JtxmXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWGYtKwlLZo/UTCs3GZGBYHG8CYWnhPrErMnP/+1iTw=;
 b=jV4uDkJArJUTmh7JGCWCp2XKXb5uCs1A2aUeJtlP6VAcYkV7SJYtHg8sGBWM/kOH9e3qepAIvMn61KnEdXPRmgnCBICq7ejbND9I9eSa9oHdsvTtfIf4H0Xjjx4l1+Szgu7ZvxMlw6iZRpcCHq096G0d8Xtkihdga6lGtEEb6qY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5021.namprd10.prod.outlook.com (2603:10b6:5:38f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 14:38:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 14:38:48 +0000
Message-ID: <1c69b5dd-ec65-438f-9b9c-af8013619afa@oracle.com>
Date: Wed, 3 Sep 2025 10:38:45 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/7] NFSD: add io_cache_read controls to debugfs
 interface
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
References: <20250826185718.5593-1-snitzer@kernel.org>
 <20250826185718.5593-4-snitzer@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250826185718.5593-4-snitzer@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR20CA0028.namprd20.prod.outlook.com
 (2603:10b6:610:58::38) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB5021:EE_
X-MS-Office365-Filtering-Correlation-Id: c0a07342-950a-499d-0eb1-08ddeaf797b1
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bmRSSDNiK3FzQ0hBWWNlQXZSWkdrU3BrYTZNeWYrd29kM0pES3l5cmlYZnM5?=
 =?utf-8?B?WkFJK3NFb1lLbXNrOG5zWHA0ZWo1eDkyU1ozRzRlTmdEUTJDbkRzNVNjYXNG?=
 =?utf-8?B?UW4yV00wOFMwQXVOYlo3THBWdEhNcVFJenZtTjNJWXYzc3I5aXdFd3hJbUta?=
 =?utf-8?B?Q1Jmbm1VME1kSFBobThTcWhoWG9yN2JUVzM3cTZVUGFkVEt1U2ViKzhCZzEy?=
 =?utf-8?B?U0k2akFlWGhJVXRHTDB0Z2ZubHNXUWdTRTl4d29vSzRLdzgrV3FEYy9TbVZj?=
 =?utf-8?B?SFppZldzWSt5VWFMMWJSTEkvSTNlMklCNEZsM1JkT0VyZzZvd29xWGI0K3pE?=
 =?utf-8?B?UFEvZjdJT2RYcU1KVEFRVmJPMjhGMnhzRUJiRzdNMkRqSFU1WWVad2ppWW9L?=
 =?utf-8?B?QXNSaTJFSGwwSWpkWGRaL0Z0THF0VlhzaXc0dlB4VW05NWtTT2VNS084YTFO?=
 =?utf-8?B?cWhmMmZkei9iTW0zbGJEQjk0bTd5TWpTRmVGcForTnlrN1dSMXJxSC8veUQ1?=
 =?utf-8?B?eHQva013OWo5Mmd0T3B6L0ZsWnhNaUsvcTlrbFpORGpLaGJDMVlFTU1Bck9W?=
 =?utf-8?B?Qi8yVTB2ZmN2K0VDaTVNTFF1eHo3Wkx4VHRzUG9sSHR1bUQzV2ZKajVXNXNh?=
 =?utf-8?B?KzZld29YbUlaUDBFT3MxbWkwVmVFZXIwc0tpM0U3ZitVMVhnRDdCTWUvOGZR?=
 =?utf-8?B?RHpLZXkzVmdxajM4M1lsS0lEdVVaRThwd3AvTCt1NXo0QVd1QWZrU1NkSDVo?=
 =?utf-8?B?b0JyY1pKWnFXS2xJMzlFSjlNek1KZnZzWE5NQlBGakJZVHhEVUxJdUtPWUJl?=
 =?utf-8?B?aGp6aTRCd3FpcE9ZdGx0amZIN0JyR25sc3BsNlRQVWJtejByT3RZbWdKdVFa?=
 =?utf-8?B?TmRmd1cwS0NBZHB6ZlJXZS9EYzdrUVhWTWZ6QlR1R3pRbzNTa3k2dkhmWkFR?=
 =?utf-8?B?MUl5Y0xRQnVFUnV2R1Q2bjhjT1B3ZXlDZ2xoNy9vOVBvTWphWXFTWjAwZUNq?=
 =?utf-8?B?bnEwbSthVnkrM1FqWWRXaGMyVS9yZjI2SCtjQ3dyVTlEcGRHRHVaQzJHbGFQ?=
 =?utf-8?B?OGtpK29KMTVnLzFzQ1RrYzgvaEFEZHFzK2NvVFVtQytuRDFTdmtxQlJ3MFBP?=
 =?utf-8?B?NFlSdjlNdi9mZDdlRTNtVDdmb1dMRDMvSnBXa2EwbUFmSGNOa2wyUzlraHRZ?=
 =?utf-8?B?WjMxMjlwcHpoT3ZsMVNhWU4yMmZnaWF6cEtMYVFGRXFxMDZqS1ZpMHdCTVVS?=
 =?utf-8?B?T0drZmptdUtmRlgyalNqbitLQklyL2l5Q3d2dFo2aWtnMEhneU1FdCs0V0h5?=
 =?utf-8?B?QmRoZGhxSm1RK3JHMUZCOVZmTWRiRzNlanpSU3Z4alc2UFhKdlk0elQzUVU0?=
 =?utf-8?B?M1h4SGJVZHM0Q2JDY1plQ0hDR3dOVHQvSm02c0d6M1dWV2RjTm5rUVdzWUps?=
 =?utf-8?B?Z1cyZGdMYytpVDgrWm51aUUvaFV2Zk5hMkJYNE10c3pVYjRkeFpXaHMzcitN?=
 =?utf-8?B?SzQxcE52bUhTYnhtL2IwcWhEZ0ZmRWVyamI1WjhLcEgzeXpFSzFBSEpaV0Vy?=
 =?utf-8?B?TXNOeWJVSEF5L1E2TlNMd0JsZUVoKzJaZzVubTd1QU4xNlA0YnlXdXY3NGZD?=
 =?utf-8?B?UUtsdUcrdXM1Yjh1RlVTeDZRWW90MjdqVWNkbVpmYzQ0WUlDdGk0ZEdJbnlx?=
 =?utf-8?B?YmRhRGdFTFJWYWtWMWF6cThlWWo5TXhFdmN2MlZ5cy9aRUNlK09mcGpyK2M0?=
 =?utf-8?B?SWZuQ0R1L1F5LzdEbG1wYlpYSC9leStRRHJXaDFKbDBMYVRxZDcwb1ZRV1hL?=
 =?utf-8?B?M1JFVVQxcXNDUWdWeGptbFNDVmRWMEw4M0liSlpCMituN0NEaVlremkwU1JE?=
 =?utf-8?B?TTh5UFIxdkUvMzQvWS9hTisxaTVHVFNoNXN0VG5nUHkrOEE9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?TzBQL3J2K2tidG9NWGxEM3BubFBnSW9ubDRqbkZOK2hOUVF3eFR1ejlDck5E?=
 =?utf-8?B?Qm5ibGxKOXBIdFkyU1BId0x4NGljL0R0c0hudG1rdklEUUVWY05wMTRwMDJV?=
 =?utf-8?B?eEo4SmNIa0Q0QVdKMjZBUXhMTXY5WEVXeXNMa0M1OStqWks0Mms3UzV4bnFH?=
 =?utf-8?B?RjhrVThBUDk4dGJnU0ZoeXBNcFJSRHAxQlRnczFCNS9xRkppbFFMbXVUUnU5?=
 =?utf-8?B?RGFPV3UvKzB1NlJXOUptTjZmTVNOc2lWTE9HZy9Uclg2ZjA3OGF1T1lMd3g1?=
 =?utf-8?B?a1pwNjNpZDM4aDY4N2VkZEp4dHBnTkFRTkpmMzdGVVVUVmNZREZCem5NNGpn?=
 =?utf-8?B?MHZtdFhJOEdTMVM1UUQ2SGFGaEtWV3Y0M0I2bG5nUk03dUloY2orQ2sveks0?=
 =?utf-8?B?RGMwZ1BEZk0zUUtVYWJDTUxHeXpWR3BmKzFCb1F6T050ckZycGl1Z0FvM2Z0?=
 =?utf-8?B?NFAwRUY5QUlXS0RwZzNFTE1NN25ybmFNZlhmNTI5U003R052bjU5Y0xBNWhB?=
 =?utf-8?B?aUF2dEkxWnhZVGZDLzVBTFppQXM5NGJFb01iOGxHd3VVelRLTStoQ3p1Mzk0?=
 =?utf-8?B?MUhpSmh6SmFCVWhlaFZnRS9RL2RhRkFlYkp1TVd4SHErb2w2S0sxSjVSdWlH?=
 =?utf-8?B?V3Iwc3hoTHhpTWRQK1NwenVvVmw0NGg2bExNMXAwTzJIYVdGQ0d6NHQvdUxV?=
 =?utf-8?B?VzcrUWFYSzFiREV5OGc0TDQ2elZaMzg4engveUJaaHF6cXhrV25vaVBjZ0lq?=
 =?utf-8?B?aWFOVUVSU2tQTzM0OVFjSWUvcXdoY1N5UUJKWERUYnVUNitFdVEzWm5SRTIz?=
 =?utf-8?B?M0FWa0t5WUw1UUpITUVJQ1dRSVBROVhHczQyWnhhRTZ1SFg3QTNuQk1yWDYv?=
 =?utf-8?B?UXNrOTFGUkRwbW9ZYjJOMm8rSWJXMytXNDBuZFpiU1RMYWdCTUM4TVE1QkpX?=
 =?utf-8?B?clFrMmhlaVd5WUEvWS85dFhjWENGS0t6VFRqYTE0citkMS9pSERjUWM5Smwx?=
 =?utf-8?B?ZHlLbFNnV3hmVkVsZlFzWHdrbU1OZ05QelAxRnhaR0MxNjNkQi9JZm53ZXFa?=
 =?utf-8?B?R2p4RWlZL1g3dWlWd3AwWjNUZG1BU1ZpdlluLzU3bXdWMEJWZHFkUTJwaGtI?=
 =?utf-8?B?TzF3c1h5NnQydm9ubjFpVXlmWCtWUU5pcUFxeTBpTkU2aGNZT3ZrUHNBZTFI?=
 =?utf-8?B?eXZQZERaNGRMcGlySlkyemFVc0I0TWxIc2RIZURtbVIweWNxbHdVNGhjRHhZ?=
 =?utf-8?B?NmdnVld3YjA0YkhhMFBIVXVCeWN2MXU0ak92N3BLWFlSM0VqOVZ2b1Y3Tk5v?=
 =?utf-8?B?YytOUDJiV0VNclh5RHZSNTBpY3lyeEtuNUdXNVpwRk5XY0RPdFU4S1A0YzdE?=
 =?utf-8?B?Wng2dzFYRktwOE1HTlBTaTdNTzlNSEtzZ1ZLQ2w4c1ptbDE2OVV3Y3hJRUZJ?=
 =?utf-8?B?UnlBL1RvNzZZTUFBU3hQaFRHcGJ2MDNoRzNXdC9vL2lFWkhJWFdobE5LVEtZ?=
 =?utf-8?B?a1kyY0toZHJKU3A3UllxbnBaaEFmM2VXc3F3ZEFWVGVnWm1HR0ZyWXZlVWZV?=
 =?utf-8?B?QUJEdllHZkI2RVZpR0xVN0VFUHZVbTR5b210ZjFXcGdGTit0RnE3OTF2STl4?=
 =?utf-8?B?ZytJcTRZSXFqNm52Rk9LL096NU9VY0I0RjYzdURnaFF3WnF6RlhhU3RGWkV4?=
 =?utf-8?B?cWpCQndIc2hydG9tS1dseStiM1M3RFdpMjZ0emhKcTU2ZzJMeEpBN1F2bStN?=
 =?utf-8?B?NjlmbHFNb2tabllBVzBhZGxyL2FFOXlrcytvUGhTcFIxaGdjZFlnZnRvTFFh?=
 =?utf-8?B?WTVlTFdFWHBHY3VFdGxOemExZ0h5a1JpSXM3cTlObDlGb1ZSQVFvc1Y4bUNp?=
 =?utf-8?B?c0k1Zm9jdWlUOGhqM1lidVNHRGpjaE5KOFdhRnIxbzNyOHJ5VC9LQ050TVlX?=
 =?utf-8?B?SklDeVg1dGtiQi9ibk5yOEhIL2ZLZ2ZQMThPdHYrVWdIQm1icGdlVGd6TWJT?=
 =?utf-8?B?c2tqaFdBVEtLbHNaSllENVVQTm5iQjdQTzd5K0p4OUtYT0V2b05DTVgzajRC?=
 =?utf-8?B?RnF1WGZpZC9tYi85c2xEQjVQWGo4S2J3UUl6bEw5bUFTMlExOEN2dkJDMG5N?=
 =?utf-8?Q?Q5N+SE347W0Gydvo+1vuhhbRw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3da0ISKe16lfyPAXX2Vtea/2a8+xkSOJJMxWCrhVXF6a7qzmqOGAVImkJ3NSSaUQRnOgxW0nXOkBwKgoSh4k/dEcl+EqSTOLiO0mGtn8BpGFM1muQhtcnUdoJqlqwkQHceCJM2bLwUnuE9Lr3iC3yeLbEdYpgLU/bhbKdB6FUdWCPQzNMUCXZengzJvynjbnP8hZJsSt5eUvarkrAswEQCwpbgD1iiaqnPpRbca04WpI9302mDIS6psVtX6+/ycvUALlJ64Rx32YTwWKEZ4iEUmDTOnFVUo5Bbxvoc3n+0PsBJFFXdWj+Diu+KY4ueT3fNNLzqiXWumPIWOdo2icRptvrz/vryN0a6hQ/rxJYCKA4Vj0fR7zY4CE8/pJiMj8GHGuj8s772pQ9ojqneDCj5bqAimCR+NhAWpyHX6llc6gthwaZ1UzQIfio45sMxJQyAHbQx7SCOiISiPwOiVTjyk2n2T6HxgX4jQv44Mc4OkFmr7Jn1fx4KC9s1zOSQBkGiReSILB3JMQgRhC7Mg4kGOZTiUmDKoBlsLVnk4K5Yz7+SCFUjCqyf67Fpl027KPT4v7QFWx6UtUgEsVqdn1M6/9cVJdSyjC353mMwwn0vs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a07342-950a-499d-0eb1-08ddeaf797b1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 14:38:48.0360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X2JzsIv6V3FVyYgOzkRGljAMHTEJ4ll15vOaKUyALFKxjVFiPMh0EordpKN1aRoLG3rn13cc519hPPmes4V9+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5021
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509030147
X-Proofpoint-GUID: uAZsMiqh1VmTyWMBtzGIyFv3h7m-P8GY
X-Proofpoint-ORIG-GUID: uAZsMiqh1VmTyWMBtzGIyFv3h7m-P8GY
X-Authority-Analysis: v=2.4 cv=Of2YDgTY c=1 sm=1 tr=0 ts=68b852fd b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=QDtFxmwZSgi6VDxugLkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX0dZKWD39A5lk
 nLa2wMFrKE1UKsdS5JpIauJZlp8UZrOpjAM3PM4rIenzzz9mP0zK6OHzJL23T6H9WLSWEXir6pI
 6SmcsrrO4zDqvdP6mjaNQtGVGvKai/CGiqWoo68o4NtFxJeeUh+P6+TRMtHGTtpgS0pkN7EcTcy
 NAWutcI6lCkRHMhJ0EW7ESFKLkIg8O0UYvcYL8NXwWKSL2AKKLMERoP3ByuzBI1CbMFZaitS+S2
 Jvs7vxX5RUOAY0Za/uicVOTjRf9EQ3BF2R/lKmso0/T1U7rTqPdUiOMMhpgpnOKiESFSNqMcd3W
 KGyUUuBMwKyjtKK1kYsMC0BxofG0GGI+w5MyTkEwyt9S5LejfdcKB1yD8jOIhhQzQ8Klwn+W7Sf
 ScjdiUdG

On 8/26/25 2:57 PM, Mike Snitzer wrote:
> Add 'io_cache_read' to NFSD's debugfs interface so that: Any data
> read by NFSD will either be:
> - cached using page cache (NFSD_IO_BUFFERED=1)
> - cached but removed from the page cache upon completion
>   (NFSD_IO_DONTCACHE=2).
> - not cached (NFSD_IO_DIRECT=3)
> 
> io_cache_read may be set by writing to:
>   /sys/kernel/debug/nfsd/io_cache_read
> 
> If NFSD_IO_DONTCACHE is specified using 2, FOP_DONTCACHE must be
> advertised as supported by the underlying filesystem (e.g. XFS),
> otherwise all IO flagged with RWF_DONTCACHE will fail with
> -EOPNOTSUPP.
> 
> If NFSD_IO_DIRECT is specified using 3, the IO must be aligned
> relative to the underlying block device's logical_block_size. Also the
> memory buffer used to store the read must be aligned relative to the
> underlying block device's dma_alignment.
> 
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/debugfs.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++
>  fs/nfsd/nfsd.h    |  9 ++++++++
>  fs/nfsd/vfs.c     | 18 +++++++++++++++
>  3 files changed, 84 insertions(+)
> 
> diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
> index 84b0c8b559dc9..3cadd45868b48 100644
> --- a/fs/nfsd/debugfs.c
> +++ b/fs/nfsd/debugfs.c
> @@ -27,11 +27,65 @@ static int nfsd_dsr_get(void *data, u64 *val)
>  static int nfsd_dsr_set(void *data, u64 val)
>  {
>  	nfsd_disable_splice_read = (val > 0) ? true : false;
> +	if (!nfsd_disable_splice_read) {
> +		/*
> +		 * Cannot use NFSD_IO_DONTCACHE or NFSD_IO_DIRECT
> +		 * if splice_read is enabled.
> +		 */
> +		nfsd_io_cache_read = NFSD_IO_BUFFERED;
> +	}
>  	return 0;
>  }
>  
>  DEFINE_DEBUGFS_ATTRIBUTE(nfsd_dsr_fops, nfsd_dsr_get, nfsd_dsr_set, "%llu\n");
>  
> +/*
> + * /sys/kernel/debug/nfsd/io_cache_read
> + *
> + * Contents:
> + *   %1: NFS READ will use buffered IO
> + *   %2: NFS READ will use dontcache (buffered IO w/ dropbehind)
> + *   %3: NFS READ will use direct IO
> + *
> + * The default value of this setting is zero (UNSPECIFIED).

Hi Mike -

I can't remember why we have the UNSPECIFIED setting? IME a debug
file reflects the current setting, so if our default behavior is
"buffered" then the first "cat io_cache_read" should reflect that
rather than "I haven't been changed yet". This doesn't seem like the
usual semantics of a /sys/kernel/debug file, IME.

For example, a user space application may want to read io_cache_read
to find out what the current behavior is. If it gets 0 (UNSPECIFIED)
then it has found out nothing.

However, if there is a good reason to keep UNSPECIFIED, then you
need to add a "  %0: NFS READ uses the default behavior" to the
documenting comment for nfsd_io_cache_{read,write}.

My preference is to remove NFSD_IO_UNSPECIFIED from this patch
and her sister (4/7).


> + * This setting takes immediate effect for all NFS versions,
> + * all exports, and in all NFSD net namespaces.
> + */
> +
> +static int nfsd_io_cache_read_get(void *data, u64 *val)
> +{
> +	*val = nfsd_io_cache_read;
> +	return 0;
> +}
> +
> +static int nfsd_io_cache_read_set(void *data, u64 val)
> +{
> +	int ret = 0;
> +
> +	switch (val) {
> +	case NFSD_IO_BUFFERED:
> +		nfsd_io_cache_read = NFSD_IO_BUFFERED;
> +		break;
> +	case NFSD_IO_DONTCACHE:
> +	case NFSD_IO_DIRECT:
> +		/*
> +		 * Must disable splice_read when enabling
> +		 * NFSD_IO_DONTCACHE or NFSD_IO_DIRECT.
> +		 */
> +		nfsd_disable_splice_read = true;
> +		nfsd_io_cache_read = val;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(nfsd_io_cache_read_fops, nfsd_io_cache_read_get,
> +			 nfsd_io_cache_read_set, "%llu\n");
> +
>  void nfsd_debugfs_exit(void)
>  {
>  	debugfs_remove_recursive(nfsd_top_dir);
> @@ -44,4 +98,7 @@ void nfsd_debugfs_init(void)
>  
>  	debugfs_create_file("disable-splice-read", S_IWUSR | S_IRUGO,
>  			    nfsd_top_dir, NULL, &nfsd_dsr_fops);
> +
> +	debugfs_create_file("io_cache_read", S_IWUSR | S_IRUGO,
> +			    nfsd_top_dir, NULL, &nfsd_io_cache_read_fops);
>  }
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 1cd0bed57bc2f..6ef799405145f 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -153,6 +153,15 @@ static inline void nfsd_debugfs_exit(void) {}
>  
>  extern bool nfsd_disable_splice_read __read_mostly;
>  
> +enum {
> +	NFSD_IO_UNSPECIFIED = 0,
> +	NFSD_IO_BUFFERED,
> +	NFSD_IO_DONTCACHE,
> +	NFSD_IO_DIRECT,
> +};
> +
> +extern u64 nfsd_io_cache_read __read_mostly;

And then here, initialize nfsd_io_cache_read to reflect the default
behavior. That would be NFSD_IO_BUFFERED for now... then later we might
want to change it to NFSD_IO_DIRECT, for instance.

Same suggestion for 4/7.


> +
>  extern int nfsd_max_blksize;
>  
>  static inline int nfsd_v4client(struct svc_rqst *rq)
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 79439ad93880a..8ea8b80097195 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -49,6 +49,7 @@
>  #define NFSDDBG_FACILITY		NFSDDBG_FILEOP
>  
>  bool nfsd_disable_splice_read __read_mostly;
> +u64 nfsd_io_cache_read __read_mostly;
>  
>  /**
>   * nfserrno - Map Linux errnos to NFS errnos
> @@ -1099,6 +1100,23 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	size_t len;
>  
>  	init_sync_kiocb(&kiocb, file);
> +
> +	switch (nfsd_io_cache_read) {
> +	case NFSD_IO_DIRECT:
> +		/* Verify ondisk and memory DIO alignment */
> +		if (nf->nf_dio_mem_align && nf->nf_dio_read_offset_align &&
> +		    (((offset | *count) & (nf->nf_dio_read_offset_align - 1)) == 0) &&
> +		    (base & (nf->nf_dio_mem_align - 1)) == 0)
> +			kiocb.ki_flags = IOCB_DIRECT;
> +		break;
> +	case NFSD_IO_DONTCACHE:
> +		kiocb.ki_flags = IOCB_DONTCACHE;
> +		fallthrough;

Nit: Make this "break;". This is brittle: if someone adds something to
the NFSD_IO_BUFFERED arm but happens to miss that the DONTCACHE arm
above it is "fallthrough" then we have a latent bug.

Same suggestion for 4/7.


> +	case NFSD_IO_UNSPECIFIED:
> +	case NFSD_IO_BUFFERED:
> +		break;
> +	}
> +
>  	kiocb.ki_pos = offset;
>  
>  	v = 0;


-- 
Chuck Lever

