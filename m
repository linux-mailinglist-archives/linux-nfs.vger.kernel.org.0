Return-Path: <linux-nfs+bounces-11780-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 683EEAB9FED
	for <lists+linux-nfs@lfdr.de>; Fri, 16 May 2025 17:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A22FC7A134F
	for <lists+linux-nfs@lfdr.de>; Fri, 16 May 2025 15:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C041A5BAE;
	Fri, 16 May 2025 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L80OEkCp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KUGK7jXQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3CB7D07D
	for <linux-nfs@vger.kernel.org>; Fri, 16 May 2025 15:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747409612; cv=fail; b=iEanCYYnESN7kyzz34tm/sqF/v09xWR9VcCJOa5TMIWv3rfdulC5WTSL4DZ6m4DxoxSN1dO7t3RZMh/M64KYOQQIYS3tGpNPqVxRa+T7Gp+SUZsxFbjoRfAbng9yARs+NMv7QYDx539kqLKuqbzghC32irIyNpiFZXVMcZLNyTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747409612; c=relaxed/simple;
	bh=875v7a0h3uhnFAvyROjjF6IuzIHxTtAp7XJllA63LeE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JcR6+vYAejGN6D5YD1hJqUmMBgQztwNM+nQQ2qnE5etMDdrPAIp+jdFm/1gdHB8UeW+rjgLYizPUalvDcW+m3amndJzjyPspb0wCssA4wzud0vm+dCwlPgEuf0wqgdHcJ3O41L8APTnHv+2cWR1TwgkgDMyRQykMkefWqPTvFn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L80OEkCp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KUGK7jXQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GF0iNN029692;
	Fri, 16 May 2025 15:33:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/q0L8Cz+tsLYKmefVauuvfVAQPgrhUesesclT7rv/Po=; b=
	L80OEkCpVxprLW7XQBbU8IiyVTMk5YN6B3XPbH9iAvGWTxv8pdSTDH3w2v7+eWU9
	hwnfvuPKh4QOHVZXpI+19TLFIsI2mixDSEw9M2SJDW89UZSJkk7yghHlq2s1UBT9
	nHNwxb31QfWum1HD0Ef2GcLfwohFU3H/35ZL6lEUWT8SmIZ8rGo9HzOk78j8KLtF
	UbfnCbfaiUNVXQ2gdcH+jgucgBjyrvCvnzEr1D9ko37p91aU0PF+DPqRxSNC1E9u
	3kThCCyxC1ekD1CXOFh9Mq4GtfBeWKOY8yIVhi4PYVkQjUjkRdM0IqxeNkX+7Uvj
	z4rg1X7BYW84nAF4RPQVWQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46nrbjsnb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 15:33:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54GEnuCn004721;
	Fri, 16 May 2025 15:33:25 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46mqmetvm7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 15:33:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rGkNq9jN5BbUoW6n8FOaYf5mxbKPLJw1RrXHScX6woUkgsDykrOSwGR75e4pcDaMtFNTLE6iedQig3vax9OCdZurC8sk83e63DSX8SwRgmi+8AgHy3Ty7eR/1Aw0KnG1eC96VUy4yXHH7yPVt+D4e1Tm6oMtpfLWzL+WkywNuR0QHVuklh3heVAy+6e6mBJSaJsMYNeiSDp7v8rDt1YWLl0ytY3smhzdbZjU9d0x8NE+tJlpthDdiOj8Q3BkWOPKUeGUpHzvD0gbfkWKMIJJo9jkgtXHtxPOR+VydqXqTRXTq4ltmC/jrZbzq3HDRBAqLp+vOzGDHkkkulsbFFQpUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/q0L8Cz+tsLYKmefVauuvfVAQPgrhUesesclT7rv/Po=;
 b=XsP3Zr47Ccckmp5pjRKl47ds6Fe+wwQVqBhZmuILua/AS7lTXNNGqUnmVWw871Xj2g7ivH1ii0kRg9TTAVrCUTQUM2uNhMY6kvqMmfzNoJ76AtLgG7euXIGvUaeN87EDNeyv5eH5BZPZ5L6Ncr/ZsDt0aSa2xajAw4lF4J6+kZs1KMJzXU8lOdvPUFDyCKhVVBZ//6QWm31OBLRymFc3+JkLThO1F3lhYPdSptkRsArsVpdVuHcdyy4d9PsiYo5VDtw0A+/mntx9IG64j/TI8AJKTPGH/8MbQ6kucOxuWkt+mO/ztaQ9lLTkutvdeUfRW6aeO+CgXDKdrqBLeZQZow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/q0L8Cz+tsLYKmefVauuvfVAQPgrhUesesclT7rv/Po=;
 b=KUGK7jXQynxIbaoLYSQx1CrbjzPYoBvkQCP9YvXx1jDhwAnZFa1gHRtc2jp8S8eaE5epZrpWG0zOomMikjBEWaWatlLmUnKgz7Sg1zjOEO8h8syRtL1fixVUPW6TzoZOWqrlVDMlLc3EE4a2k/RhEPNBJohv5q+QDM2ubT/rFAw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB7048.namprd10.prod.outlook.com (2603:10b6:806:347::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Fri, 16 May
 2025 15:33:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8699.022; Fri, 16 May 2025
 15:33:22 +0000
Message-ID: <d5d6927d-aaa2-4160-989f-53e8b84bdac8@oracle.com>
Date: Fri, 16 May 2025 11:33:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6 v2] nfs_localio: fixes for races and errors from older
 compilers
To: Mike Snitzer <snitzer@kernel.org>
Cc: NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        paulmck@kernel.org
References: <20250509004852.3272120-1-neil@brown.name>
 <f540ef6a-705a-4987-87b5-fd6753174289@oracle.com>
 <174684611546.78981.17530209113609371873@noble.neil.brown.name>
 <8c8ded94-ea5e-4b12-af2b-72004a988ad5@oracle.com>
 <aB-vxtKNKxpPnkz2@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aB-vxtKNKxpPnkz2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN7PR10MB7048:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a001ab8-911c-46cc-284e-08dd948efdcb
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?ODNtL1YveldXK1dMWXRNSTcxTEJXWmNDUUsrOHM4L2pmaTJKRGRXeUtXN0Yw?=
 =?utf-8?B?N21kMFB2OHRkYTQwd01oa0hLUGpTSDcxMWZGN2lyRkhjTTRNS0xsZys1NFFa?=
 =?utf-8?B?enhSNW1ZbDVMVHFuYlFEOGVxY2NHbzdMYkNUaXFlTkpNY04zMERJbE0vVUNF?=
 =?utf-8?B?V0REK3RURkRwNU5zaERjUGhTK3NaMmdBZVVHREk4QnFkc1VidkRLMGdyRnZW?=
 =?utf-8?B?L0p0Q0pySUNmbGtTT0Fmb2E1a0g1K3BtSWE4bGhnNmkrQ2ZEbjVYVEJsMUtK?=
 =?utf-8?B?RUd3cnYwNU1DczRPRW5QNFZLZHRUUXljckIyVkNWWHF6LzZIVDA4MjdOMCti?=
 =?utf-8?B?Y2VJL1ovOHBLbkxwTlVhbEs4b0lYOFpPRjFHSzZhM1pVUTdWTXBrKzZpUXJF?=
 =?utf-8?B?aUpnR2dEcmpzVmVpSU5zL2RMZEc5ZVJlMmlkVjllQXcyeU8yc0JaQ2IzT3Nw?=
 =?utf-8?B?eURPbjZXRUt6b3lrbXN2cU9ld3JiWVQvZlZua2ovcVk0eVBNdkZUVnY4YU9Z?=
 =?utf-8?B?bmh4ZVRPbkVHM3Nud21KcHY2V1ROMTNJa3IvbzVuaU9EUWxMcEh6aUxLZHI1?=
 =?utf-8?B?b3R6My8vNEtReEVFM1kveGJCbmtsNjdnWWZBZVA2RVVpS0J1QWt0bTFPdmYw?=
 =?utf-8?B?bjdlL3h5SHNNb1QrVHBPdVAyd3NCL2x3OVFGZlVrbXhrdndSU1loUkFxVkZT?=
 =?utf-8?B?RExZSGg3MDg3SFZhQlBaZm8ySS8zM2RzK05sc3NxSnoyL0h4NW43c1V2c29K?=
 =?utf-8?B?VmVSZ1VYUFBLOHhnRGxxWnM4ZVZBSStCak1SV3JsMUxmdkl3TkVUVGNOZHBT?=
 =?utf-8?B?ZXRaV0FFSWdGZVo2N05HWm5wS25QamN5a0c3djE0SGRZQ1RoWHRsMTVqaE8y?=
 =?utf-8?B?YURud1JUaVRIT2xKK2lJUGRMdUlEUVZ3NHVRTVBKL2JqVXhqNGM3b2pyT3Iz?=
 =?utf-8?B?bS9yaEhLdVJIY0pXbFU1QjBPQ1NuclFDb3ZpLzdEVVhDWmtnb08xaDVYa2cv?=
 =?utf-8?B?VDBNcUo5WWkvSEdoY3NWMDhyZWJrWDVzNXpURGQwOEFYYnIzUkNUL3pCdnJX?=
 =?utf-8?B?VUtiWW5GdkE2NCtncU1mNFJ6YWoxQXJtWW5ubzR6VVJBaEtvanI3SDRPMGc2?=
 =?utf-8?B?aDBKWHlyS05qcURRTTV5RUtqMCtyczZJVkxWNENWSFRYYmROWmRkNnNIZjNG?=
 =?utf-8?B?SDF5eFRiLzh4RnpaZ2lTMlB2RFFOMWcrYWRteGdMRHlKNkdoQUVHMGk4djZY?=
 =?utf-8?B?T0VuTWh4U2VDRS9pMGU5bjgrU1Q0bjYyS05PeHhhTjFaREcwTjdFdSt6Rit0?=
 =?utf-8?B?bVo0SG5ZR2JHYUNyRzQyRDAzOEIvVTJTK0g1MytFeEtXYWJHMCs5a0NVeUwr?=
 =?utf-8?B?R25jcEdNTUJKWFlTNGJqVHJrOCs4em00NDZkRG9hRXM1MzNpcFdzSFA4UGpz?=
 =?utf-8?B?NFdPYWY0aFlxSUY3MTA4bHhzU1hTeEhIVTVXVFAwTVlsaElVaUU2SG9KQkw4?=
 =?utf-8?B?WklhUFFtYnJlTkNBcE1qNnA0TXdYeTk0RWw4NVNnVTFtajdEVXoyUjRsa3U3?=
 =?utf-8?B?b3JjUWR4THdTZjh3alhqRHp1OEJOZ1YyZXFsTlNtbzZUR2RrbzJUd1Q5Z0gr?=
 =?utf-8?B?cHQ2Z0FNOEcwSWNlbTV0L1o5dCt5MkVrUHlmVVgyMFJvQklCSUpmSWRZMVl6?=
 =?utf-8?B?dndoWFkwN3VWb0JsKzRpTUpqVUxIdDR0WHpXc2t5UGY0aUR0UnZsekhQMzJF?=
 =?utf-8?B?MENQYzJwSDlZTDNmZ2N6cnVza3U1MmM4YjFKRk9kb1k5WmlObmRyeFVSUkZL?=
 =?utf-8?B?K01zQXJtQURQcE02TVpBcWJ0aGdWaVE4VkswQ0ExY2gxZ0xKcnNlWkpBdnBv?=
 =?utf-8?B?REl6dEo4S25jUnMxUjR5UzRHSGNkcHBBNEYvdWxQVEJ6Uy9LVFNhenhqK3pE?=
 =?utf-8?Q?+JOFyHGKgGM=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?M2dEZlNmYnJjR0pqVnRlSDBZRVVBd2RocnNuU1RUdThEaTI4S3lVcmdWVTNN?=
 =?utf-8?B?SDM3Qk9oM2l4Z1ZIS2NsTzFha2hUY2ZvVmRuRjhqd0ZjS2lRUzgxY2FBTjho?=
 =?utf-8?B?clBINGRwWUJWTms2S2N4ZktZckc1RnQvRWZJTEROaUhna2h6UHVGMS9kczBm?=
 =?utf-8?B?dTJSZ3RxY3lXVGlXejJzdEhHeTZVOFpJWURJNlpKeW1GKzJ1RlQ3Yk9qVVNR?=
 =?utf-8?B?Y3haei8zMmVQL2ZNSXZyVTF2Z01YV0pzNlAyUklUY0RUZmhNZ3lLN1FZdUE0?=
 =?utf-8?B?WjlGVEUyYWIwR05oWFFyNFEwOFNGSFJtZ2xJbno0VytFOS9COGJTbWNpV24r?=
 =?utf-8?B?STVidWtibEt1WldGcmZHaDVVQjJDWFAxU0YrN05Dc1ZQZVF3Z043QkdyL09u?=
 =?utf-8?B?Y1hwczl5d3BCZEswSFVleFh3bk1Tc2hBMlFyTTNVYklkdU1SN2hKc2NBb3Nm?=
 =?utf-8?B?WFJrRjN6L25ETy85VWNlNFpqcWhCdW9TcjNHWXZPbXlkRkxtT29YSXBXdnVw?=
 =?utf-8?B?c0p6Vldjdk5SWnZhVHVZaUc3d0dwYncrQUhHZy9reVl0QnpjWFllaWpyVmhL?=
 =?utf-8?B?aTFvNjNXU2xVL1JGMU4xTm5lcFZ5cmcvR1lMZWRzVjBjaUFnbE1rajJtRkE5?=
 =?utf-8?B?TWFIRy90SzVHaXFLQVN3QWlFTlBZWnltbWd0bjlpSmczYUxXK1hLTk9rSWdZ?=
 =?utf-8?B?TGtzQmFBb3QzUnphVkhGLytXR1J0cHRGamgrVVJZTlNIY3lZT1FJZHdpRGRq?=
 =?utf-8?B?bmN0a08vcnBTdUFtblREVzF5dVFLMmsvdkl2Y3lWYUVFSUVQVTE0ZFp1UmNv?=
 =?utf-8?B?bjBib25lVWJZeEdxSXNpbzZ6aXZGYmt3VG0vN3o5bm10NFZ6djgvSnc1bEVm?=
 =?utf-8?B?YzFuWkFPd2lpZzJCekxsWEovU2E1K2lZUW1HVmtsMUxwUEl2cHhVMVYvZTFr?=
 =?utf-8?B?c1g4aVNXTVA0clpsZ0FKWFJ5K1ZGU3BLSStQOXBVUnJ2UnpQNVBPZm9nekVV?=
 =?utf-8?B?bHhUbzlxUFVtQ0hlUTcwYjRNcHBCL3VnOVo2Q0pvVk9HaTZoK254bThVaGF1?=
 =?utf-8?B?MDdPNC9pU28wdHdicUhYRkJGbWpDcTZVNGEzc0ZObEVaNWlFaG1ROWtNWjE0?=
 =?utf-8?B?SXlqd1lKT0ZVZHFSTU9KeGpSVnhCNTZqeDJxTWpXcCtzWXV4Tk5NTFhjM0hT?=
 =?utf-8?B?QnFFTm04TW9HNlBtNlR0QVBEUE5yQ1hBMmVEUDFYWlBFeDdBb2pNb0xQalQ5?=
 =?utf-8?B?TTFuQUdJVXBacWdhQnhJVUhGdDNkWmVSSkZMVVZqK1Zack50aHRuNlVlRjdv?=
 =?utf-8?B?ZzQwN0d4bG1Sb1JwaVQwSU4xdjZ0MUxUdi9yNFRiellEeU1xUGtRRW5PdTF3?=
 =?utf-8?B?QjN4eFVkVDZiNEtMdXA2U1JyZjRwb2J4alFTUUhzT3dWMlVrRHZxTDJnUnZL?=
 =?utf-8?B?RmJHU2V6YWxrZnRIeXQ2eUlSaEpYOU9kRkQ0U1F0NTg3VFBnNzdMMDVpYVVx?=
 =?utf-8?B?T1lwUWRadDVoV3JHYlUwV0xWbk5WaFdrNEMzaS9PRkFhSTlLYm1LekVNSm9Z?=
 =?utf-8?B?dXgvQzd6d1ZwVkRLcWVORnJydEM1T1FHd2llY3I2SnYwSnB3YnREZFVvRTRl?=
 =?utf-8?B?OVozTEZCcmNXYjRmb0F0MFZJN0xwc3R0UXRMeXhIVzVWenZ0ajZXcmJFdTBG?=
 =?utf-8?B?eEZSZzlzTWd2djN3aWpWWEtNMUYveXNLNmR5c0s5WEtkN3B1Ly94aHUwM0tr?=
 =?utf-8?B?YzJUVkd4bk9XWENuUEQwd2pqUmRwTi9NZ3dRS1BWSEsvV1lvVlppajF5Q0th?=
 =?utf-8?B?NGNWNVNuc0NzZ2tnOGhZaWFCZEg5TWhtRkZHTENiWnpYdm5PWVdjK0xESnBj?=
 =?utf-8?B?Y3BvS3Ywd2hyYTBGUktES1I4QXVKMjY1S1BqNU9SMjZqNTF2bk9ES040MHNE?=
 =?utf-8?B?d2JxaCtEOEtZdE5tRWpBbldJenBjUnE2VFhHWEc5cW13dkg3dWtRZUxhSVdu?=
 =?utf-8?B?aXFic0RURDdNaDNRM1RFd0VXYlZITExQWnZqOGpZKytEZkZLM1RKMnFXZGZl?=
 =?utf-8?B?NnArV3htaFJWNTRZckRBaEN1Ty9sTWtmYWN0ZFkrS2hEZVoxN0FGcVZhYTdq?=
 =?utf-8?B?Z0hVelIvVlM1L2lQL1lhRU1CT05VRDV3cDkzMGwvV2w0Zlgvc3RXUVRpcm5r?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xj5EP86l7QMjopNGc1vMU3MPzGepM0a4UM9uYM4JLuqDDAcEf3icf0nVZpZeDhvOGWJ9IL12Db6/8KY1BQPD5kwROCi6VRDlJBu4JTy8eJluViI/SkrXs41RBULGp/5G+inC/MKxeIAu1lM4LoVS4Lx5+9/9EAH5IXXybr1WSeaPiJMCsateFErVQI9eRCc4nxT80ErrHpxiipfk9A4o/1WEIUdjtkR4CxK3PO3UXNou6QcLJkPWrn/+Bl0Hmn8n77Cqw1nU45tGbb5iONtKpip+sd1m3ep3SrYZUn5J0Lvh0yNFCL/6Ji6KB1whiKGIyROxB7i7VrmVMd6H4/vBa/bGhtSVxmcoP9XCVALHJr/PlhTjo+10XdyRRVpXrNeAJxgGUp8f70JRxbpNTrolKQSJzSG0KJZyfLfyAQYbc/VtVXfX5R2K5QH+y3c4EKipv6v5NbEVFVT68qd5oIntJxkRayGYWCDkvn/kaOX7RYJKTHihBFM+Soc1hLKkzC0FFTvFV/y9OS3oOtrLlmgApgql1MOyvPZgFH29JTRbd7f2bkDwfTPgdMhxlMW8oQRQ5UmveGncCsNAUEWsszpOa9iN+yht03W/WT3cB0+8pMs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a001ab8-911c-46cc-284e-08dd948efdcb
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 15:33:22.1827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lS0xQPlOfNZO4WpydaY1UZOKV/94vjy18Q3l1S0FWivXAKdXZ8V4IajVM/nTbKLox95k6bVkH2lYvm3uWp05zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7048
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_05,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505160152
X-Proofpoint-ORIG-GUID: T46GiXLXm7ibiw9gishXMuX3P3GDYzju
X-Proofpoint-GUID: T46GiXLXm7ibiw9gishXMuX3P3GDYzju
X-Authority-Analysis: v=2.4 cv=aYxhnQot c=1 sm=1 tr=0 ts=68275ac6 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=8-vJTp5NpDIrKrogLCgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDE1MiBTYWx0ZWRfXxeO79lQKPlsZ fJ7zaE3mQ2XhYEvTCrYxW38K50GEPltJJAFuErAldyBf2mASvHMfM4PfTfYtb7+X4AETIaKNsQS RuXVl5OEKfdSbosRtJo607+qlcsxhgiVZNy4wkoB4zQxoOXUWVb3rFr+eUnZVW/oaQTFrOq+8BC
 L/v9jVHQ6ZeW0PoOXIi9EO1Y7hCU+PbmINF6Xwt0O4Jx5W8h7B7y3pZaQ0BUoAnyx6lAAGGX3n5 7FTyJCfocYhnSRlwO4Vd8nxH17UX3YSn2Em/ou5QIV/lQOR4RtALCmYjVeMzzR9pk4hONuGmOs2 cw9m4NLaMXOE4+xl943FyIRGVlwZNRjEt6kt1YRstHTjczd87Sf7SB4Iq8S/XgbWlyqp/sOvkyN
 kR3IbelnArL0vFVV0V/xkRO7ceqo49M9Ap4sFp/xOt3hKq+AEjL6iwlhxjXlzWl6RKYUIDLt

On 5/10/25 3:57 PM, Mike Snitzer wrote:
> On Sat, May 10, 2025 at 12:02:27PM -0400, Chuck Lever wrote:
>> On 5/9/25 11:01 PM, NeilBrown wrote:
>>> On Sat, 10 May 2025, Chuck Lever wrote:
>>>> [ adding Paul McK ]
>>>>
>>>> On 5/8/25 8:46 PM, NeilBrown wrote:
>>>>> This is a revised version a the earlier series.  I've actually tested
>>>>> this time and fixed a few issues including the one that Mike found.
>>>>
>>>> As Mike mentioned in a previous thread, at this point, any fix for this
>>>> issue will need to be applied to recent stable kernels as well. This
>>>> series looks a bit too complicated for that.
>>>>
>>>> I expect that other subsystems will encounter this issue eventually,
>>>> so it would be beneficial to address the root cause. For that purpose, I
>>>> think I like Vincent's proposal the best:
>>>>
>>>> https://lore.kernel.org/linux-nfs/8c67a295-8caa-4e53-a764-f691657bbe62@wanadoo.fr/raw
>>>>
>>>> None of this is to say that Neil's patches shouldn't be applied. But
>>>> perhaps these are not a broad solution to the RCU compilation issue.
>>>
>>> Do we need a "broad solution to the RCU compilation issue"?
>>
>> Fair question. If the current localio code is simply incorrect as it
>> stands, then I suppose the answer is no. Because gcc is happy to compile
>> it in most cases, I thought the problem was with older versions of gcc,
>> not with localio (even though, I agree, the use of an incomplete
>> structure definition is somewhat brittle when used with RCU).
>>
>>
>>> Does it ever make sense to "dereference" a pointer to a structure that is
>>> not fully specified?  What does that even mean?
>>>
>>> I find it harder to argue against use of rcu_access_pointer() in that
>>> context, at least for test-against-NULL, but sparse doesn't complain
>>> about a bare test of an __rcu pointer against NULL, so maybe there is no
>>> need for rcu_access_pointer() for simple tests - in which case the
>>> documentation should be updated.
>>
>> For backporting purposes, inventing our own local RCU helper to handle
>> the situation might be best. Then going forward, apply your patches to
>> rectify the use of the incomplete structure definition, and the local
>> helper can eventually be removed.
>>
>> My interest is getting to a narrow set of changes that can be applied
>> now and backported as needed. The broader clean-ups can then be applied
>> to future kernels (or as subsequent patches in the same merge window).
>>
>> My 2 cents, worth every penny.
> 
> I really would prefer we just use this patch as the stop-gap for 6.14
> and 6.15 (which I have been carrying for nearly a year now because I
> need to support an EL8 platform that uses gcc 8.5):
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/commit/?h=kernel-6.12.24/nfs-testing&id=f9add5e4c9b4629b102876dce9484e1da3e35d1f
> 
> Then we work through getting Neil's patchset to land for 6.16 and
> revert the stop-gap (dummy nfsd_file) patch.
> 
>>> (of course rcu_dereference() doesn't actually dereference the pointer,
>>>  despite its name.  It just declared that there is an imminent intention
>>>  to dereference the pointer.....)
>>>
>>> NeilBrown
> 
> Rather than do a way more crazy stop-gap like this (which actually works):

The below looks about like I expected it to. Thanks for coding it up and
trying it!

Agreed that it is more verbose than the original patch, but this seems
more self-documenting to me and looks narrow enough to backport to LTS
kernels or even move these helpers to common headers if they are found
to be more broadly useful. I have only a mild preference for this
solution over the initial one.

One more comment below.


>  fs/nfs/localio.c           |  6 +++---
>  fs/nfs_common/nfslocalio.c |  8 +++----
>  include/linux/nfslocalio.h | 52 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 59 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> index 73dd07495440..fedc07254c00 100644
> --- a/fs/nfs/localio.c
> +++ b/fs/nfs/localio.c
> @@ -272,7 +272,7 @@ nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
>  
>  	new = NULL;
>  	rcu_read_lock();
> -	nf = rcu_dereference(*pnf);
> +	nf = rcu_dereference_opaque(*pnf);
>  	if (!nf) {
>  		rcu_read_unlock();
>  		new = __nfs_local_open_fh(clp, cred, fh, nfl, mode);
> @@ -281,11 +281,11 @@ nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
>  		rcu_read_lock();
>  		/* try to swap in the pointer */
>  		spin_lock(&clp->cl_uuid.lock);
> -		nf = rcu_dereference_protected(*pnf, 1);
> +		nf = rcu_dereference_opaque_protected(*pnf, 1);
>  		if (!nf) {
>  			nf = new;
>  			new = NULL;
> -			rcu_assign_pointer(*pnf, nf);
> +			rcu_assign_opaque_pointer(*pnf, nf);
>  		}
>  		spin_unlock(&clp->cl_uuid.lock);
>  	}
> diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
> index 6a0bdea6d644..213862ceb8bb 100644
> --- a/fs/nfs_common/nfslocalio.c
> +++ b/fs/nfs_common/nfslocalio.c
> @@ -285,14 +285,14 @@ void nfs_close_local_fh(struct nfs_file_localio *nfl)
>  		return;
>  	}
>  
> -	ro_nf = rcu_access_pointer(nfl->ro_file);
> -	rw_nf = rcu_access_pointer(nfl->rw_file);
> +	ro_nf = rcu_access_opaque(nfl->ro_file);
> +	rw_nf = rcu_access_opaque(nfl->rw_file);
>  	if (ro_nf || rw_nf) {
>  		spin_lock(&nfs_uuid->lock);
>  		if (ro_nf)
> -			ro_nf = rcu_dereference_protected(xchg(&nfl->ro_file, NULL), 1);
> +			ro_nf = rcu_dereference_opaque_protected(xchg(&nfl->ro_file, NULL), 1);
>  		if (rw_nf)
> -			rw_nf = rcu_dereference_protected(xchg(&nfl->rw_file, NULL), 1);
> +			rw_nf = rcu_dereference_opaque_protected(xchg(&nfl->rw_file, NULL), 1);

I might combine rcu_dereference_opaque_protected and xchg into another
helper, since this rather verbose idiom appears twice.


>  		/* Remove nfl from nfs_uuid->files list */
>  		RCU_INIT_POINTER(nfl->nfs_uuid, NULL);
> diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
> index 9aa8a43843d7..c6e86891d4b5 100644
> --- a/include/linux/nfslocalio.h
> +++ b/include/linux/nfslocalio.h
> @@ -15,6 +15,58 @@
>  #include <linux/sunrpc/svcauth.h>
>  #include <linux/nfs.h>
>  #include <net/net_namespace.h>
> +#include <linux/rcupdate.h>
> +
> +/*
> + * RCU methods to allow fs/nfs_common and fs/nfs LOCALIO code to avoid
> + * dereferencing pointer to 'struct nfs_file' which is opaque outside fs/nfsd
> +*/
> +#define __rcu_access_opaque_pointer(p, local, space) \
> +({ \
> +	typeof(p) local = (__force typeof(p))READ_ONCE(p); \
> +	rcu_check_sparse(p, space); \
> +	(__force __kernel typeof(p))(local); \
> +})
> +
> +#define rcu_access_opaque(p) __rcu_access_opaque_pointer((p), __UNIQUE_ID(rcu), __rcu)
> +
> +#define __rcu_dereference_opaque_protected(p, local, c, space) \
> +({ \
> +	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_opaque_protected() usage"); \
> +	rcu_check_sparse(p, space); \
> +	(__force __kernel typeof(p))(p); \
> +})
> +
> +#define rcu_dereference_opaque_protected(p, c) \
> +	__rcu_dereference_opaque_protected((p), __UNIQUE_ID(rcu), (c), __rcu)
> +
> +#define __rcu_dereference_opaque_check(p, local, c, space) \
> +({ \
> +	/* Dependency order vs. p above. */ \
> +	typeof(p) local = (__force typeof(p))READ_ONCE(p); \
> +	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_opaque_check() usage"); \
> +	rcu_check_sparse(p, space); \
> +	(__force __kernel typeof(p))(local); \
> +})
> +
> +#define rcu_dereference_opaque_check(p, c) \
> +	__rcu_dereference_opaque_check((p), __UNIQUE_ID(rcu), \
> +				       (c) || rcu_read_lock_held(), __rcu)
> +
> +#define rcu_dereference_opaque(p) rcu_dereference_opaque_check(p, 0)
> +
> +#define RCU_INITIALIZER_OPAQUE(v) (typeof((v)) __force __rcu)(v)
> +
> +#define rcu_assign_opaque_pointer(p, v)					      \
> +do {									      \
> +	uintptr_t _r_a_p__v = (uintptr_t)(v);				      \
> +	rcu_check_sparse(p, __rcu);					      \
> +									      \
> +	if (__builtin_constant_p(v) && (_r_a_p__v) == (uintptr_t)NULL)	      \
> +		WRITE_ONCE((p), (typeof(p))(_r_a_p__v));		      \
> +	else								      \
> +		smp_store_release(&p, RCU_INITIALIZER_OPAQUE((typeof(p))_r_a_p__v)); \
> +} while (0)
>  
>  struct nfs_client;
>  struct nfs_file_localio;


-- 
Chuck Lever

