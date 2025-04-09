Return-Path: <linux-nfs+bounces-11072-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C72FAA82C63
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 18:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7866F17585E
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 16:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6848026A1C9;
	Wed,  9 Apr 2025 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FBSW7T70";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jd9jZo7z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA881DC07D;
	Wed,  9 Apr 2025 16:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744216039; cv=fail; b=o0ohGa8RqL4Y+35FTiedPNHM8ByB5/WLCar2YNk0BVubdA/ViAUXotH87q1ttnQ2NVHRPwRRlesr22RIFelazbl/L5svngj3hMGl4TAk6myY0IvTiwFDouu1hc5zc5mEqmRKnUQrLP2PDVo008F7z/ug1cXc8bQwbE+wGBH+LEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744216039; c=relaxed/simple;
	bh=VZSsA1T/hfo7NRHeU5oUGkD6Kn+EVETCjoKDyBRgSYY=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p1tATvEHV2eOlbIrHilA/TS7KyWK0Boqc9nVQYgVh9sq6/j63mLhDdZvAuVUqF32reAtF8WAuMOYkhszzWbpBcw6qiAEQ1GRvuhvPGsFWttg5KWP1dYH/czgLb6ApQT4F8rrzmvivkPo8/BGcDSudZV2WFapInQ06yjesJj4Czw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FBSW7T70; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jd9jZo7z; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539GN0Zc009441;
	Wed, 9 Apr 2025 16:26:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=o5kFV63ZVjZkvHN7KpqHymwb1vvo6DYxTH4nuKj2Cqo=; b=
	FBSW7T70G72Ozke0QmxKt9D1OvAlViiJ3GHxrUTvOR+OVb+xxcKyY4bppx8aRuAx
	A/yACNKq3yaxO1Fq8k+xDXRypuUdYNyrLzgwHWlPOatJIT8AWFJguxbYsOBJv0gV
	p8lr1w8WfkwVS2j3rJLR38TfjAIs7GAIDiINQnH1FjJ/ASAZcMGpNsoQ+XSb2ZhS
	6fNFTKYhTiobn+P7NjsCTF738et0dlgKEzODQfYujdhv2eXXDWVs2zkxVuRTcXkN
	Em67pXTEIEIDyumZqD74ZeWVNoPQsTApdyTWdATdys6txvd/FEe+swkSIDGfwt6U
	i5gvbeDWZrqIHDyt4efpig==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tvd9ygq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 16:26:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 539Fgdr5023959;
	Wed, 9 Apr 2025 16:26:46 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazlp17010007.outbound.protection.outlook.com [40.93.11.7])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyhbfep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 16:26:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tXjq9xyJW8Qn7NZMmg/ir7ooX1RLt+T/ddtt7g+ThtvVdwgml9+ZUokUf2JScvnTZuFrPzpzT/PLxcgH9uiuNoAI8zNeUdtd7PgscUCZ7PaX1VT+P+CwuO4GvTzlyOTAKo6G/zXL+eLeFa+KPPPMA77rwj1x1Ykyfo56Yn1LyUb/hTPRt0mi5UoHnzWUlsUIK9xEbbgh9PaUbqBkgqtjDGsdqrBjXy27qvz42C9PHpa/yI7bPLaLaQcmbF6kfI0UUW7XhPsoBpQlC+EO0KbvWBgpYrfBh8IBDpIytelxPDNUyV9V4oBsRtX+J3SYiwqlEgGIA5GjkmaLhpRg9v2gKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5kFV63ZVjZkvHN7KpqHymwb1vvo6DYxTH4nuKj2Cqo=;
 b=aPNlM1cTJAWAxUb1zFuOyQBBjk5P47fOnLofoWD1JamjNa2diSzmeiH76HfBRLfxbM3v9PGQYG0fMYiOTtqyQ15PGgxANn6eP1lZBp4SJRrnG6hKGG1bQ3PyQhIJapcBtu8mZe9dQx9ABXcdVFfQtAzkkIPpMicyiWyof/xorOxwkLegUE5Zxs14qM7MF54GzsKsiJET3IWlJ1cvZOYAhGYqH98C6oz8ZZcbD6mivTmZCWfRIUHmzK2doT3MCvum/Jju1zpwPw/01o1XRg5XrwHoI5mG4O1HKKnOJS8VQwekCEg98xxpenb+uCUhvUuA6vC5D8sOkRjoHVxmgk8lOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5kFV63ZVjZkvHN7KpqHymwb1vvo6DYxTH4nuKj2Cqo=;
 b=jd9jZo7zBCaqYspehf0fLR2V4fj8ADg2g84gEDSIghY88+QSMZVRE6C0yXKHkPCJQKTsoGzVvMir/7mGcmK3gC7zHcr31Zl6GmJ/WFGAn/lSEB7xcT2wMuErQNz8EPvKBKo9koLdXWGaVvsoSxDGIRsopd0Ly17OavhfAdNYEdU=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by CH4PR10MB8193.namprd10.prod.outlook.com (2603:10b6:610:23c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Wed, 9 Apr
 2025 16:26:44 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%6]) with mapi id 15.20.8632.017; Wed, 9 Apr 2025
 16:26:43 +0000
Message-ID: <0fb7ccca-3645-402a-b023-d73de61d9737@oracle.com>
Date: Wed, 9 Apr 2025 09:26:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug report] NULL pointer dereference in frwr_unmap_sync()
From: Dai Ngo <dai.ngo@oracle.com>
To: Li Nan <linan666@huaweicloud.com>, Chuck Lever <chuck.lever@oracle.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-nfs@vger.kernel.org, trondmy@hammerspace.com, sagi@grimberg.me,
        cel@kernel.org, "wanghai (M)" <wanghai38@huawei.com>,
        yanhaitao2@huawei.com, chengjike.cheng@huawei.com,
        dingming09@huawei.com
References: <e7c72dfc-ecbc-bd99-16f6-977afa642f18@huaweicloud.com>
 <314f60a8-4b0d-45f9-87f4-5a4757d34aea@oracle.com>
 <355c8355-a6bc-181f-73e7-1baf7749f984@huaweicloud.com>
 <89b0c30b-9b7b-4507-ba1f-0493e88c6791@oracle.com>
Content-Language: en-US
In-Reply-To: <89b0c30b-9b7b-4507-ba1f-0493e88c6791@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0060.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::35) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|CH4PR10MB8193:EE_
X-MS-Office365-Filtering-Correlation-Id: 88c6b88d-38fa-458d-e5ef-08dd778350c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bDNaS2VIVU9jaHZNVitQNjVBd05tcUdCUHo3WHVGRE5vVlBxWFNFRjFWSUts?=
 =?utf-8?B?Yi93cG5JWDNzSytQTkhqVFptNUhMT1dNWEtWekpSS1VZc3pkMVU5YkhveFRM?=
 =?utf-8?B?L1ZmZW5uQzc0YUxUUE02YkVWdmdXQXd4REdvMzlJT2VHbGNiMEc1eUNLNitV?=
 =?utf-8?B?Snp5cDh4SmVpRG92aFJoZDBNMkFMSXZ2azZpSnNPaklUckVRdXF4Z3gzZ3Nn?=
 =?utf-8?B?TStwTEdmSWFveGhKUXl3N3NVeUFEQnZsaUVGdUhwNkNYUGhvby9LOFppdmhD?=
 =?utf-8?B?NmJUL3BHNGNOdnE1R2kvSnNnRVN2TGpNa3dTYUdQOHFYUEs3UmVqajB3Z3Qz?=
 =?utf-8?B?Q0FCYVNSRmpkT1pJWmJqVlFhK0ROazhxUVBsL0QwMVJWY256UzZMNG1hL25i?=
 =?utf-8?B?ZG5aaWlZY1I0bktwVFB0SE11a0p6NW10QlpJa0JXa3ZrVlM0MElWeTF3M21H?=
 =?utf-8?B?MWI4a2NTcWk4ZDM3ZUc3RTd4NXBtbEM0Qml4dlc1QmNIRU5LMWhJL0RGTjZS?=
 =?utf-8?B?akxPVFRKb3VUb0ZxZm9lczlQRlB6alV1Qm9JTU1oTTNWb1RQRDNWTVJkaHJy?=
 =?utf-8?B?bDFOWlRqTi8vVGdmZFlVRUsyQmUvRUhaLzNDZGtBV1NqdDdoSzY4R1Z5aVZj?=
 =?utf-8?B?cVJybXFvTkg0WnFuQVhzdy9tVThlT2plOWVoSUY0ZkFldkVzcEhycXlrdldp?=
 =?utf-8?B?Z2pEZ0w0cGdsMWoxR1hDUnJ2dTQ1MkFZanZiUUdrL0E3UFphOXQxZ0lBS3RM?=
 =?utf-8?B?NWNKUHhNUnA4MGxTWXFQRUREUWlPUU9EMmhkeGRZSVFtSTJjODFNeXo5Zmxs?=
 =?utf-8?B?Uk10ZlA3NDgxVEl6b1ZnbFYvZWxZMVp2NFlaVEZkUnB1YnBETzYxRUpmR0NZ?=
 =?utf-8?B?SklSeU1OenAzN3pBVW53ZHJrSmx2WGtybTVVNStab0doSHF4RlQxL0JNekND?=
 =?utf-8?B?QjlDNklBbFM1bzJtL3o5NUtjSW5vOWtQOFhMd0RGaE1tdUd3dUFZb3pvMjBl?=
 =?utf-8?B?SEVrTS9xaEkxY1QyWThRRWtmcmt6RFBCQ24yZGlHdURoVHQvQlQ5UEVEMGZt?=
 =?utf-8?B?YisvTEROUHJyQkJaSXlzVXRxUWt2eDRveElhcDlZYWNlVGJ4QzNtWHNZNGk4?=
 =?utf-8?B?K3NLM0hER3pNVDhLT2hDTnlHUVlwN01QK254Y2ZsYXR4TmJUYlhlRUpNdzMr?=
 =?utf-8?B?NHltcDJreGNLSWNxVWFLTE9CdEYrU2FTWDY1Y0ZMUFpEZzhtMjBBcS9zSm9o?=
 =?utf-8?B?QWtLUDhBZFVySk55OWYwMTV4R3dQOC95YzRSRHY2OGpIdSt3bVlGblI0eEkz?=
 =?utf-8?B?ek5ScUtKVTdmSUpqb1NTQ0lYK1F0dGdZOWRTdWRUWk1kQnF0b0Z3NlJ0ZDky?=
 =?utf-8?B?VlNSMzBRZlBqa210L2pvcXR1TTZrdVBmZE12dDl0WlFpVUMxamF5UW1xblE3?=
 =?utf-8?B?NW5UQ0Q3Q1lJM0ZESGVXRUV2WUtSeHg5TzdqNFVMbXBPd0daMHg3YTZqZlZ6?=
 =?utf-8?B?d2dBNklWN2dxRVp4V2hWVU5sSTRJTjNOTFRaMTUrL3hjQWN0ODdCM2svWDlQ?=
 =?utf-8?B?UGY2RU1pSkRxNHhiUmVBU2pwZnVQWUx4ajl0UWVialFuOE9uZ0JUQWlESU9j?=
 =?utf-8?B?VFhTTEhtZVFqWDdnRktpK05UNUw1N0g1OVFTajZucURtOUZnSzZGYWFCVzVq?=
 =?utf-8?B?akJ6NXRaUis2SnBGYVpVaWJuNC90YlpRcGxuMzJYalpFa3VvV0JCcEprWnhv?=
 =?utf-8?B?bGpwWEJ4WDNCVUJtV1VyenVtTjZpeTVjckxMek50TkdSaU1xc0o0aklxaVBv?=
 =?utf-8?B?emk1NjNTZFVrL1NkTCs4aXk3Y2loaVVOM3lRbU43ZE9LM3l3WUNac3hKVFht?=
 =?utf-8?Q?ib/FKuLStcxxj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?di93cGx3aHo2ZnRIZlhNd2dBZEdSK2M0RXJwdWJFT0xxUlhLRDVwK1RNWU12?=
 =?utf-8?B?MFBDTDhwNUtxTDFaMVNpTkprUGdnTkZjTjNPNzRIekJudThiVy9DUnZLdGo3?=
 =?utf-8?B?SWt6Y1dxMlpzc3lxenJNMDlrNk1GalZheEdCcDBRcGRvVHNXWHhRWFdFMkNZ?=
 =?utf-8?B?eFpZbkd5dnFkREJ0ZUVzaXREanltVktJTmU4T1pkeHdrbTk5bW9DQ2kvRkFL?=
 =?utf-8?B?MUFyMjRiRXBqQlJvbHBYUmRhWG1YYk5nNjc1OXNaaFpybjVvYWNvdjlnTk41?=
 =?utf-8?B?TVZnZmlIUmFVZ0xlQWVpVmc3QmZOTjVVY013MW01WTJDUExpOHRQRHpuWC9l?=
 =?utf-8?B?TjNLaktHWFlqcHlVUDd4K29NaDM1aGorZ2J3U1RNbll3ckcxT2hySHpsOFdY?=
 =?utf-8?B?S1BkZmtIRjZKTVNCb2t0L1ZldDhGclAyczV5S0Y2NWhoQ052cWVIUmE4RGJy?=
 =?utf-8?B?VEZESlEwZlU2NjlOdjJzY1BLTzhWTG1EdVFmY1Bac1dYSGtQOStuNkZsdEx1?=
 =?utf-8?B?S0VYc3l6L1M5U1V4YldJbkFWSmJxcHhVNzNNSHVML1FRQ08wdGpjNEQ2WXRM?=
 =?utf-8?B?Mko1bkw4QlhWL0hocGYxY1IySGMxbC81YXlKbDlBV2o2WllSNGQ3c3VCUkE5?=
 =?utf-8?B?azUwcytVd3lNOTVqc0thVkNjWjZaRnRDbWQzUjVWMGpQZmpzOW85UEk0S2lH?=
 =?utf-8?B?MlJ5TmNXZ2NmWEcxQkIyNXJFd1NQYkNmd1hyelNrc3RpYUNxMW56Vkw3Q1JB?=
 =?utf-8?B?TlJrTGJqV0xYQndkc0V2RmRsbGwzU09qcE9oNFVaaDFwc215aGh2ek4vdXFF?=
 =?utf-8?B?K0pkeXRlQ3Jwc2h4TW5JcW4xd25MdVRsSThTZ3E0MFJWYS9WYUpKUUFTb21V?=
 =?utf-8?B?UFNHMGVyc2lkZHlEOXN1Y29QbWU4TnpibGFoNGhJV0FOSjJkRHA0alFYZWZO?=
 =?utf-8?B?VFB2MGRPQ1pCN3loaTllazE5dWtqUHBvc2tkNStxeVN3dCtjZEFrU0U2cHJR?=
 =?utf-8?B?dUtRTlI2cDhUVEY1OEd1M1cvelB1QzFTU0xNN2pVOUo5VXRnK1JYS2Y3WE9r?=
 =?utf-8?B?TzFiOXg4RkpUUjVSdUxzN1Q4WTFoRTFIZEc5YktQNjR0cHNmQmx2VlJhTzVl?=
 =?utf-8?B?djU5bFVvODVvc3YrYzF3c0ZtcGk2UnE1cUNiTFVjM2NQZWlTc2h6b25LVE9m?=
 =?utf-8?B?TUM1RkZKNEJWNXNlKzlLQTcxMXlBOEhFdjFHRWVzcDI5SU1vTVd3TVRLR0Zo?=
 =?utf-8?B?NjVCZGhzeHZvTXl6MkNON0o2aXRUZU8veXc5MEtkSXUvbzZ1UzFVRVZwNVpv?=
 =?utf-8?B?bkZJWFZhY3VaZU1XVXFVcTQ4Y3B5ZzFtNXR6dTlJNW8rZEFRMG1tRDkvcW12?=
 =?utf-8?B?Y0NJNGs1MGNRUllEWEwvSkVOdkx4OFFwaWNoNGlMU0xuTy9SYi80OTB4bHRN?=
 =?utf-8?B?Q29Wek4xTjNtYno4L1p1M3JRNGljK2dtaHBRUU5CenE3SllmSFhMMGV3RmF5?=
 =?utf-8?B?VlVBc25ha001cDVwalRTZHVQNldFN2d1ZTh1WldCekgvZEpnMkx6bzJOamU2?=
 =?utf-8?B?UXR0bWZ3akNZMmdmOTVLRXgrT0Y1bDZnN2RteDk1NzJES3Z1aFFmOWtIVGQw?=
 =?utf-8?B?S3BSUUFlR3dPRmJKaUtPMWY5TUlpL24xUStCNXk4aFYya2NIMHBNdkU4Q2h6?=
 =?utf-8?B?d1RjaGNMOUl1L2k5ekdrbHhoR20zU1dKcmJaMGgvc3BRRlpkdnRGVnkreUE2?=
 =?utf-8?B?d1ZkdUJEOUxJWXpiZnFIR2JBTm44OUFjT2Fqc0dEcFN6bWxmUEN4OUpkV0NS?=
 =?utf-8?B?dlpFditRcVJqUE1keGdGdWtuWGViRWFUaGwvMlpaQ1F0SlZUV2pHLzF5VUFC?=
 =?utf-8?B?SnZIa1BjbkhPOXJRZTNMdEFTU3NpZDBNcE1jcGNmaWxvaUE3WkE1ZFhrTGRz?=
 =?utf-8?B?MW1DV0ZaKy9xRysyM0FOMnZTQjhRckZxeXEra2R2RDVseXdYZ2JOcUcrRmwv?=
 =?utf-8?B?aXV3aUF6Qm1kTlhkU1RiMWgwcEFSTnFUa2tJdFlNM2o0aE4wTFlxVFNmbDJY?=
 =?utf-8?B?eTYzK0IvYmpUQkc1d1ZqR3RQZGtNemIzelZVak9YaE9lOUwzL3A2WTVlK1Ba?=
 =?utf-8?Q?SFQB7o4BHKsk4zycU/p0EEsLN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	R2NSnGlEyli3HHQodnXDjnRgUd2yxq65O3+cxH8zsPsBBetxElXNgm+uVUrLmqlle17egYeE/pijwHFNx7BCttECMeg5dMC4wqtBMD4cRZRVq9mkcyOnAAQj1LpmiIhzvsvcfSAe5O5TVcHjNtuLFG2Gc5vIm8oAz4P2kFvJMxVLXx71iUJrNBw0knZ9juuOsTpTVmLyd59clshnJTSJACxWGTi3oet9c/NTuXzPciss++2irRzQ9glWbL0Ran1UexfSfhL5j1JeXpf5z8nxl4e3Xi7twoZSeJ27lezkIQYJrkia59iDTYBeFtlv6ooVz+odxtYaML5vCEGps1NJdM71ncpvNvqh+7QmIBklgzHMUCRqg1oBEU5n0/LLu4iCxNyiKOYD4Ru93PIuKU+bBkPMpUcI+DqUaYXMDld0VjA6rA4iyIWyDnGU21r5kzMl6+JcfbjYSex4H5+9GTTqdLheXtjibm4/Io6HMqBjRaM9jWrDgMxEthYbIzjVqWav7Kn9pYUnN3FFN0He2Qf6srHy4eqBTZecOerbeGOKGSq7Zxnj64YJJaGXEVZd3NoNXLkz2RE6uWmdkf0nsdm0lMtWeZ4sTTFyxmNTlA6pz0I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c6b88d-38fa-458d-e5ef-08dd778350c8
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 16:26:43.8543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NPF2GaUmNowThnnKCP09Um1ihr2LbAbf05GUQ6gLjtfgU2Tqwy6JU9xRIwjnSV1apAmiwLtanScEJ0ohlFDH7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8193
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504090105
X-Proofpoint-ORIG-GUID: j_NfNcuEN1TurtmREpHnG0J324Hn_Ce-
X-Proofpoint-GUID: j_NfNcuEN1TurtmREpHnG0J324Hn_Ce-

On 3/9/25 12:40 PM, Dai Ngo wrote:
> Hi Nan,
>
> Can you try the attached patch with 6.14-rc4?
>
> This patch adds a spinlock to protect the rl_free_mrs and 
> rl_registered list.
> I have seen list corruption in our RDMA testing but the problem is 
> hard to
> reproduce so I have not submitted this patch to upstream.

Any update on testing of this patch?

Thanks,
-Dai

>
> Thanks,
> -Dai
>
> On 3/5/25 6:40 PM, Li Nan wrote:
>>
>>
>> 在 2025/3/5 22:02, Chuck Lever 写道:
>>> On 3/4/25 9:43 PM, Li Nan wrote:
>>>> We found a following problem in kernel 5.10, and the same problem 
>>>> should
>>>> exist in mainline:
>>>>
>>>> During NFS mount using 'soft' option over RoCE network, we observed 
>>>> kernel
>>>> crash with below trace when network issues occur 
>>>> (congestion/disconnect):
>>>>    nfs: server 10.10.253.211 not responding, timed out
>>>>    BUG: kernel NULL pointer dereference, address: 00000000000000a0
>>>>    RIP: 0010:frwr_unmap_sync+0x77/0x200 [rpcrdma]
>>>>    Call Trace:
>>>>     ? __die_body.cold+0x8/0xd
>>>>     ? no_context+0x155/0x230
>>>>     ? __bad_area_nosemaphore+0x52/0x1a0
>>>>     ? exc_page_fault+0x2dc/0x550
>>>>     ? asm_exc_page_fault+0x1e/0x30
>>>>     ? frwr_unmap_sync+0x77/0x200 [rpcrdma]
>>>>     xprt_release+0x9e/0x1a0 [sunrpc]
>>>>     rpc_release_resources_task+0xe/0x50 [sunrpc]
>>>>     rpc_release_task+0x19/0xa0 [sunrpc]
>>>>     rpc_async_schedule+0x29/0x40 [sunrpc]
>>>>     process_one_work+0x1b2/0x350
>>>>     worker_thread+0x49/0x310
>>>>     ? rescuer_thread+0x380/0x380
>>>>     kthread+0xfb/0x140
>>>>
>>>> Problem analysis:
>>>> The crash happens in frwr_unmap_sync() when accessing 
>>>> req->rl_registered
>>>> list, caused by either NULL pointer or accessing freed MR resources.
>>>> There's a race condition between:
>>>> T1
>>>> __ib_process_cq
>>>>   wc->wr_cqe->done (frwr_wc_localinv)
>>>>    rpcrdma_flush_disconnect
>>>>     rpcrdma_force_disconnect
>>>>      xprt_force_disconnect
>>>>       xprt_autoclose
>>>>        xprt_rdma_close
>>>>         rpcrdma_xprt_disconnect
>>>>          rpcrdma_reqs_reset
>>>>           frwr_reset
>>>>            rpcrdma_mr_pop(&req->rl_registered)
>>>> T2
>>>> rpc_async_schedule
>>>>   rpc_release_task
>>>>    rpc_release_resources_task
>>>>     xprt_release
>>>>      xprt_rdma_free
>>>>       frwr_unmap_sync
>>>>        rpcrdma_mr_pop(&req->rl_registered)
>>>>                     This problem also exists in function 
>>>> rpcrdma_mrs_destroy().
>>>>
>>>
>>> Dai, is this the same as the system test problem you've been looking 
>>> at?
>>>
>>
>> Thank you for looking into it. Is there a patch that needs to be 
>> tested? We
>> are happy to help with the testing.
>>

