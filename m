Return-Path: <linux-nfs+bounces-16907-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 127E3CA4DF0
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Dec 2025 19:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7E0383008BC5
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Dec 2025 18:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D662737FC;
	Thu,  4 Dec 2025 18:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RJ64JPgK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="v/3ulJWz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96422F39DE
	for <linux-nfs@vger.kernel.org>; Thu,  4 Dec 2025 18:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764871861; cv=fail; b=W2r5OCyd9bmh3OEsOxyfi2hdo6XLScLZ33w1SuxMdj4CSsW2bzsTzVSHhMUQgSnzd5rXBzNAc1pmY1zlXbe5Y03zpJLM6UrTjUzjAV85jwmg5aNyHgfSjP4JXRcc+bJh+lcdX/Ru37JD44nvcI4mxmy98Ttna8KkIV4uTTakh84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764871861; c=relaxed/simple;
	bh=LIvmTmJeaUF5P5EokvXpi6EJZrsaOot8c6KtuGwzJtI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ir6rZ9+FMJ7LGC+GXnP0jjk1sMBbU/OnGPFXM05nhyrZmxckv+/EoqjeREGX6KeIYsklsC5MSe84Tn1K9IqcJkPJlihcIF9nxN5Rp1p0PejdzqBQkVEcjAaBUHo+vWQBxiE2A+hK7nmYLR7OJKKN8pLTfnHXxiAd/91Nc4k03vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RJ64JPgK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=v/3ulJWz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B4HuMin1202875;
	Thu, 4 Dec 2025 18:10:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=LIvmTmJeaUF5P5EokvXpi6EJZrsaOot8c6KtuGwzJtI=; b=
	RJ64JPgKyx6kI3JAUfqXFvq3yUIM1lhJJC5gaKU4/5zg1PXDFUbriDQLdyMWm27c
	JjohRKpnr0xh/IkjnIaKINzFiauzpmBEAdewq8ZGom7wdRd6DHwrdVmTbFlf0O+R
	MA3gKDiBrywu9ADWOfj23vu5+w7ZkZbvQmMkvRNwmQwT4yoYfO3VPCB3IwG5OGAX
	fRLLS6vkb6EqEwcZjnExvWtWARvexpidMPI5z4dCusOL8mZ2bCTEIJl/HhvL1GHU
	RDRUBgCkYc1Re8IvQyMG8xhrbNy2qTfIiVcO6z/sEsLKYvZFSlsVteyOpR6YGnDh
	giMEnS5QpHEeXpYDi/OfcA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4as8460es6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Dec 2025 18:10:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5B4HLUMS017000;
	Thu, 4 Dec 2025 18:10:43 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010009.outbound.protection.outlook.com [52.101.201.9])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aqq9c7xjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Dec 2025 18:10:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jp9Sh4/0fSEGyiu+oe+MKzDHer0eYlSnvRmLRUZET/5U/Dhx6/HcvRx0KBJPUlwo2QKBMG/Gbxyo7aoNt/zU6jAC986M4ztSr/zyKpXbLPf8k+3qF9GkL7/yLek24zoq5a/yPyqUh9mckeceSLZ+8g6x1yRxoUyKAFQf5sX6v9+JJHbIgd5gU3jXbtPD/fUIfDnM1veOQhi+L9XD2YlVHZxZvq/ykLxGQZRaSkBfHGk85sAyYkzh7XOB5Ds7+NqDlSFjgutVGRp1VkBBWsWTaa/+OXzpc323l1FlGaXJGEyQmZVemqppvACYW0jduqghyTzG2dt3R1ANMhi+4uHIuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LIvmTmJeaUF5P5EokvXpi6EJZrsaOot8c6KtuGwzJtI=;
 b=alZ3+OscNHk2VY5c5oiDQyRggt9TC9G45ylVOyGUxwvTfiSj0+VgWjyDK3QFs0LSgeVCCB39SYzov/v8R7oJ2n98fhpVTKnyXFxPZMkBFHbneRb4CltMqbOESGtiQfI9/lpTrbenrXwU1QNwe23geR+DcRgJ6Ut5FGB0EuAXUwp5bOr+tYxhwfza1LK/luWQPEJZj9JxbdbHuuoC39lNy72kEncsfvVx1yTHgOXsxfZdqt0t3dObHu8rK1x74c+kcX0qgBv93Gcx0I1cQ+23G/GmAmbY1dLh1Ih59UR63qGSRr3Of7Pj38JuUyw/2iH3vZ6ymZVTBXJGci7Svodg/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LIvmTmJeaUF5P5EokvXpi6EJZrsaOot8c6KtuGwzJtI=;
 b=v/3ulJWzVQpmIjUKiGlifMp8vT3lcJ8eec/x1gYXzltuzXEXSKG357qqwxU+Bv66K1KaSmVkk2Wg/pz/cTPkFRuHm4Gdmct0Ggp1thpzx8/dF0aJbRCKunpgGDTGK3EoY8dMq13dmO1cdVWN2UX/xTIlWCz407XyWm/Bldswjoo=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 18:10:40 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 18:10:40 +0000
Message-ID: <6b29d6fb-04e8-43da-bc1d-0e78572b5402@oracle.com>
Date: Thu, 4 Dec 2025 10:10:39 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: Can the PNFS blocklayout of the Linux nfsd server be used in a
 production environment?
To: Christoph Hellwig <hch@infradead.org>, Chuck Lever <cel@kernel.org>
Cc: Zhou Jifeng <zhoujifeng@kylinsec.com.cn>,
        linux-nfs <linux-nfs@vger.kernel.org>
References: <tencent_780E66F24A209F467917744D@qq.com>
 <5e1b3d07-fd80-47d0-bbf8-726d1f01ba54@app.fastmail.com>
 <aS6ChyDRx-hALj5V@infradead.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <aS6ChyDRx-hALj5V@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0017.namprd21.prod.outlook.com
 (2603:10b6:a03:114::27) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|IA1PR10MB7447:EE_
X-MS-Office365-Filtering-Correlation-Id: 10689479-d60f-48aa-2d55-08de33606eec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWhqYlg3cGpnck9PVG5FY0QrT1M0ZXc3dFFuazJMeXpJZ3VFaVN1YWQvaTZY?=
 =?utf-8?B?RWZFc2ZzcVJpSWZDU0tTTTcycFNXaEtGaTBnSHRZRHNDZkQ4T3NZVExINmdL?=
 =?utf-8?B?RUNnNTJxSjlhS29JVldMY05yZ05MaFd6TGV3YllpdERnQmRFU24rUnBiTzg0?=
 =?utf-8?B?cjR0bDJNS1FZTXowK2xFUjlxQ2VIK25UNkRUaEd2dFhwRHhZeGdaYTJFSW5C?=
 =?utf-8?B?SkYzY1Y5N1dpbUlWTnpFai82UHZRcDFJZTBEUE0xSUR6SXUzOFAxMzRhYXMr?=
 =?utf-8?B?OGpwZldYcUNHNWlTRnpleTZhYkNnRWttN2JNbUNHQ3NTRDZFK0diNnl4eVpT?=
 =?utf-8?B?TmY2d3A2SEJRTzNYM21iY082eExSd3FDREdZNE1MYlJjdldjRHBCOVpUSVly?=
 =?utf-8?B?YW5URmdmend4TmNCTTQ2bDY5MG5Lam9VS1JYRFIwRGZVSU9YUTRFUHdSSjBy?=
 =?utf-8?B?T2RiUVUwWG9BZ0p6eXVuNkZ4TVA3YVkxam5DbElrdEZkaEowSHVXSHJ1VUFZ?=
 =?utf-8?B?QUJVZ0EzRFRxd2p4SXBrUGlZcHE1VmFCSDdFN09NRnhBanoxcklRQ2NoaDU2?=
 =?utf-8?B?MjRVek9jZTVkcjBnaCtjTmtabG10aXRybXowakkyeTBzaUJSQzJsUTAzb2pw?=
 =?utf-8?B?cHlUSWFWN1ZQL25aUXpBK1BTWlRyc09SRVZ6QmN3UXhSNnkzTFI2WUdqdWRu?=
 =?utf-8?B?QnJ3WUpWd0V0eEhCc0tocllCM3R3OGo0ckpKWTREZWxiSkpBVEdOMCtvRGVw?=
 =?utf-8?B?N1FKRTY2VXZMM3hPbUlWOUNMUnBpUjB3NEZyeTNsRzd4Y2M3VW1ZZXMyYm9t?=
 =?utf-8?B?b1Q3QnE5TUE5SHNtbHJTU2VCSDE1WVZOdHNZWEk4MmR0Y09rb0pEaEZuTjJK?=
 =?utf-8?B?dmp3RkRneWtNQWxIZ1VRV1hoY0ZvaTl0V3lldWdEVEJjUkdGLzdnR3dnQ0Jo?=
 =?utf-8?B?T0twS3BhN2NxT0t6Wk0wNkpVc1cxdi84a3dJOXZkQXBpQ1pIZUxUUjBTc01k?=
 =?utf-8?B?ZDNKQnBOVEVvTTJXUWRUYWt0YzQ1bFFNNE5peld6TmhQc2RibWJyV1A4cm9n?=
 =?utf-8?B?UDVQdGlCTkZ1c01pOVJKZHovTFN3T3lFMzAwWTc0ZDN0bGtMK0ozcEVQa2Jo?=
 =?utf-8?B?K1hPNDczZTZNQWFtbWVVUzBCemlaeHlwVjE3MVA3dDZVeUlpa3p2eHZ6VHNY?=
 =?utf-8?B?Z1JNdS9oU3ZTZ014N3Z2MkpLc20wMGh6TVhyNjF6T284b3JicElRWWpFc1Z0?=
 =?utf-8?B?VWV1Qi96UWpQbVcxME5KdmFNTWV6cFZ0UlBiYmwyVUUvNjlVdEJIR2RXTGxE?=
 =?utf-8?B?NFAzQi9ZUUJxUnk2eUM0SmJpdU1ncGZkYkRNenZac2hDNElIVUZhWFd4UXND?=
 =?utf-8?B?ODYrWHIyZEF1TE0zQXpML2l0VElMRzJYTThGL1ZlTEpMMkN5L2x2bER3Qnk0?=
 =?utf-8?B?Y1Uwemp2NW80WUlOS2h4ZTl2WWFuQWpHMTdYdk9jZTd1ZFc5U3RXZ3ZPaU5j?=
 =?utf-8?B?V0NRZGNpK003UTVvL09KczU1T1RrYUh1T3dmdnZ0VEQwTGtnMzVqVWUybDdm?=
 =?utf-8?B?QVBuVFhxMGxRUGZXb0RrYjZsWnQ5Y0s1UFBJWWdpNjVxQkJwOVplZmNOVDNP?=
 =?utf-8?B?L3llNGxNM0taUkQ4SzJNUSsxYTBFc1Ric3B5YzFaamk4SzJWUWRKN1pYR2ZM?=
 =?utf-8?B?a3ROdnVPVTI1S2V3N01oUVJsVFgvZUFPQkk4Sk1KSTBHWTFYUXdsSTFkdkYx?=
 =?utf-8?B?QmJGaU0yanRWTmptcVFtakczNEtzejd1ZktUUDZ6RlRoTVJseXFYRDhrbnRm?=
 =?utf-8?B?VkQ3WDZvQ3VPN2E5ejhPc3plT0w3NXdsSFJKL0RRaWlFWFhDeW9WL3d3WHVE?=
 =?utf-8?B?dTFNcUxXRkx4VlJtMzQ4TlphbTFRejhzVS9VV3Z3c2Q2bys2SkF6bmRKYXUr?=
 =?utf-8?Q?qE92P+7gIAt2XV+1EZhHu11+HQrQS2/Q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlJzZm9VZHJzSW5Kck1obXYxUDZveTQ4eHBRMmdNRDcwQWExZEVRUitzZFVi?=
 =?utf-8?B?cEYwR2ZlVVVmZG80WDlDaDIwaEZXWFQ2NHdPaWFEWFYveHloVGtLMEdUbzZ5?=
 =?utf-8?B?ZndPU0xjMTcyc3BxMWVUcmYzN1lLZU45RnJhTmNQUVh2dzRBdEh1Rm51YnN5?=
 =?utf-8?B?Z29RUWJGZGhZbE9kQ3RocUdmNitjQ2pTUG1NNHhYNmNkTGVuQk1jVlAwY3RQ?=
 =?utf-8?B?TkVLMVE1eVlHYnRwejdvUkQrZm9INjlDSElzUjJhUTIzdHM4d0ZBSXVsZk9C?=
 =?utf-8?B?amVMWmN2alMrVlk0bTlnNkpYVHVkSjViVHVpKzR1Y2RaN1JqWFpvTnJETzY2?=
 =?utf-8?B?NTQ2OWF5SjRBUzQ2azZaTmxyclRnZXNTa0RzZ1BRTTVVelJVdFJoSnlkT1pk?=
 =?utf-8?B?anBrMFliOW9jSTgrLzFtaVZkRlpRZnJucTRTVXNFWXU0bytYRFhRZHdxRkN6?=
 =?utf-8?B?a0psUkRpUjdlb0wrWmc5dG41YmRmZGozTW5kMnZoNERNanlxYmF1d25OY2lK?=
 =?utf-8?B?MGEwb05kTjNsNzFDbHN0M05tYk1POXhpbHNWUHBjajB3OGQ3dk9Wd0NvazlK?=
 =?utf-8?B?dk5IUjk5dzRsMDhNR2FKUXMvNWtDT2JzbkRIc0c0MHRZMjJOeHVlTHhEbS8w?=
 =?utf-8?B?ak9wM001VmxubDYraWY1M0JrV3lJdWdlRGtpM3RRNDF6YjZJOWhncWlSdmNQ?=
 =?utf-8?B?ZXJaazRNUFRuS0xQZlhQK1VMQ1dBVkdWQXdKN1UybGJRa01iV1NXNDVBMWh2?=
 =?utf-8?B?aDVNQ3RCNkR6ZytzZmdxZkdtKzNnOFFvenVxc2Ird3VwQ09XbnM0eDIzOFZh?=
 =?utf-8?B?WmduNlFzT2xvd3VnWnRWUHlFeHVaQXVQcVZFOStkaUUrZHNEcU5BWkpsMU5R?=
 =?utf-8?B?RFdtQitHV3NDMGtIQTBmZ1FidDR6VXRpbDJJNlBzdmlvVG13WnFBbzFsUi8v?=
 =?utf-8?B?VnhOV1lyUXF2SVIzc0YzZmY5TUdiSW50dFZESmhzemdBRzdGWFhIWFBXUlhW?=
 =?utf-8?B?N1RSY0VzOWREQWNrZ0d6aUZXVXo5QU9zQzlVaHpLeUFEZmhiTXVXTmJsNjVJ?=
 =?utf-8?B?UDU4d1VkUjlNT2hWTG1OQ3UzZEwzMFY0VHdieWp4SDNRNWJ5U2c1ejdaeHBY?=
 =?utf-8?B?WGh3VXY1bjFSQTFkNUNQYXY4WHJCWENPY3VORzFiN25WZ1I5OEZ5RFNNUzBs?=
 =?utf-8?B?L1dJcTJnNmZtMWJZeDdwMW53SmNnekhaSWRsTEgxL1VFdHlVaVN0Y3V2VlE3?=
 =?utf-8?B?SG5zeHJWUW1jVXZxUGFMNUxxZUREaWlNMGhYL1FLbi92VmdGckxaTzdaZXVE?=
 =?utf-8?B?RUE4SmNySW93WENuK3ROZ2I3d1ZCWXJpZitWVFErOU96cWhzbkZodERZRWRp?=
 =?utf-8?B?TW5ZcXFiSk9iVHpPMi9ENE5nOVpPSjhDd3lweDhROFY4SWpBMmJWa3hjYjEz?=
 =?utf-8?B?OFVrb2NzcGdORE8veFh2czMzdGtDV3pnM0lSUjM2Vms3U1NnbzhDYU5DTXhp?=
 =?utf-8?B?ck1YTE1EMkZ1bi93dHNFRUZNcE5lUmRoS25qcGJUOFdJaDdKTXJkckd1YVZE?=
 =?utf-8?B?NmJhSytXNTBOZ3lJSVlma3g4bGs4NHdCdmNHQUZUeGxhamtSbDRUc0hoR1Z1?=
 =?utf-8?B?RHRkaGRuOVEzSzJic1BPc0YxSFlWUFMvMDBuMHNjRmlXdTcvOWlOWUN2WXZH?=
 =?utf-8?B?ZjFJcUtvY3RlWU03dGtHWWU2b3ZJWFdkVGlhZGNJYmErd0xTU3VNQktZdzZX?=
 =?utf-8?B?QTl4Z2hla29QS0RTTXE4N01IZWVFRmpUb3gxd3ZlN0xYblRpYWZiYXVOdS9Z?=
 =?utf-8?B?QklvWUJBc0NGdlVseVJHNnFydCtyY09TU3NaUFBvV3kyaUJlSmV3cWowRStz?=
 =?utf-8?B?dTBxUy9RRkw4UURwcG1XRnZxNEFVRFlUdFZ3M29sZkxmOVdac0tOazFhRU9T?=
 =?utf-8?B?V0Y1akQxMGdFT2gvdE5PMkNkTDZzOFduRmt2RnZ1c0J3Y0dmN0ZCVWF2VSsz?=
 =?utf-8?B?Ri9XeTlYUUIzQXR2UzNuQ29Yc0lZZ0FTSkh6MisvS2dKdWZmOVdTODhJYlA5?=
 =?utf-8?B?VUM4emlCYkZDYWx5cHJFeW1CMGNzamxKNkV0bm5ObGhra0JEMWpGcVdxTzJ4?=
 =?utf-8?Q?4Y5nnpH1cped0IbFoYzsuoS2w?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	p0SNQO1Nb0mEwKhciuU0CcaHSr+y8FAmbRB6WG3BkymGIREbz4jlNf7UyrV4nj7CUMivB21P83+djjFJUOFz/LSlCl8u6heFIHMMwgaZTSK0GjTm5MDfmWg7zqhQEMm9zZYoArJz7kWMj/VHSfjQaHrB6t+PHF5i0I7tr5BkXgzPzQITmkA6VKQQ8XtKMobMOU5OfZ06tdC1+6NphkKXiKh4LOOBIieHlJ7xfEDt5koO8flIC9gqKQTo6WOe8vZZ2WlsuM06V44eacgrFuJABvyoRYSZ+HYp+81sa6wGQryaIoFumYUMOBdrxZHniBS8474TeOinazEyoyS68iFyh2gHEP7fRUgvDLlC/tdpJ+fAq8xPcKHVeus0k6lsxc0C1+73Vsw1vQoB4BZdAThYKrym+EJ0+r2nFqXu73nE4CDrIBfHsI2hNVoOAFCXOpAuh7Mm4GhufbZFl0knn87hQBPs3Stk06D//vqTMLox/xYQiKKqbL+TCaEyVuXj51y/o+dUi3sNF+wFSMxLsk9UwgnLUxm0KhLFEPwA8dGDCCUi++xpQdTNdDzUfJcSvRVWF0pXEYtqOOvcd12vGkifvqOn0kGYguFD76M3mNvdidM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10689479-d60f-48aa-2d55-08de33606eec
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 18:10:40.6025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tgm9xPaNq0l5ip/vbFQ6bsbleM+bn5dN34tYf4mAZxVR3ugVUgnrzgxZ4Lh343K+SfCUEYtcouQbLo074QivZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7447
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_04,2025-12-04_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=899
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512040147
X-Proofpoint-ORIG-GUID: CVEZaoiQbmaBwKgwOUy-IQczjkXHJQGk
X-Proofpoint-GUID: CVEZaoiQbmaBwKgwOUy-IQczjkXHJQGk
X-Authority-Analysis: v=2.4 cv=W8w1lBWk c=1 sm=1 tr=0 ts=6931cea4 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=1VY8xy4-P1P2kjXU:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w-qf_exSS2nfYWw1HlsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA0MDE0NyBTYWx0ZWRfX7YJzoynwPwIG
 aP5OwIW2bO2rmmkR9iiHf7k6RaE+6rEO8EC7M/Pi5UQM4e7D3Mnx5+kv+pQSV304RPQaTOQTXsr
 K43RHPXddSUrrsAlVfNxnHCnBk42ULhsYXcbZ5jO3YTagUjbcVyGwkyNKbyuO14PWz01e132bHi
 yLQ9qz3jPf4gfumvehUyH8dkOaM+CpR5xwpiihgUt8sOqEjDl6g6CfMjhL2BtaxEm1K2MJSYxM6
 ToAIiek2kD072VU2I0TI/97n2YNeN/+IjvCQA01dRIZuYqZs6FuHi3DeyUuw7xppTiHv+ivOP1w
 yuiVS423R7x+066c5V7Mz+NhYZAFHOOxpza3R45dHCOWDls+3X/YFJp4wTyPBg6MRxEVjdp8kUe
 tbRQJ09Wy0CEcPAM2XAhFnHJ8WYd/w==


On 12/1/25 10:09 PM, Christoph Hellwig wrote:
> As the author of much of the block* layout code I agree with Chuck, just
> want to throw in a little extra note:
>
> On Thu, Nov 27, 2025 at 11:40:50AM -0500, Chuck Lever wrote:
>> NFSD's pNFS block layout with NVMe implementation is fresh from the
>> factory (I think the implementation went into v6.12?). As with
>> iSCSI/SCSI, try it and see if it works well enough for you.
> So while the NVMe layout support is indeed very new, it's also very
> little code, on the server side the support is entirely contained in
> the nvme driver by implementing the get_unique_id method (~60 lines of
> code) and on the client side it is looking for the nvme persistent
> devices names (2 Lines of code after a small preparatory refactoring).
>
> So in general I think it should be taken as the same maturity as the
> SCSI layout at this point.

How does server fence a client using NVMe layout?

-Dai


