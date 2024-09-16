Return-Path: <linux-nfs+bounces-6523-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DD797A857
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 22:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66D091F29070
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 20:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F8B13D52C;
	Mon, 16 Sep 2024 20:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Yt4KBwyL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZaoX4G1L"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5215213A86A
	for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2024 20:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726518832; cv=fail; b=SJ7qLJJIcZ4Q2TD20YJcWrBHYJ55hIFVb/qkPF2RidalJbQuPOEXqy4OdmI6xOma1loIDBGWWP9wK17qgWMyUvE2jEWg+xoSzW0CuDW1zfay162YSJXg3z7tKAbQtCtZgVm2nnjwOmJky8Ym444v937pBPqrO6hMnaBsMROQ8DQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726518832; c=relaxed/simple;
	bh=3spr3wI4uDQT1F0OlS1cEquYU5prsYGRrXLBejT7qY8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y89OZ6b8Sfufvirv5u6BqcuMVjyq8oeZX9R1CaNJNhz/k7fbQnJkitudcm7Sf8E9K5Y1gsmKPTlHangZqHVTdZKFpKyzquCmsymbSEVLAcD96Jwy2+fW9vl9oZAKDcqafQRywkgNOnleHAPcTlMIiMOyFVPw1jyuaDAWNDIFXgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Yt4KBwyL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZaoX4G1L; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48GJtiBn001448;
	Mon, 16 Sep 2024 20:33:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=CvwJ7BKduGA26tCz92rjlJNhU32XvRB/IzZIJjhTlYU=; b=
	Yt4KBwyLo6PmrjH3RMTP/k8BDHfDskCBxjh2r3Yc7st3BlvjU6yUktcvHKgjegeg
	9rQ+PFZH4LXu/YqH9Hef/QGZ3dh0UwiWi/UG7B2ffuGyTfAWhGhSMQ8ub2T2WeV+
	x5XjobL71K8ZG5f/OAf63X6hiPDrU4Ke8oRwSX0opBnLjx6EKV2tKIWPpEVXE7a2
	I9GC3odeGqveZxHAeOkjkOx5Kl2RDhNcVQMgkwYVQ/0DYoA5bIVtpNvsFuhU7rIf
	cbhqmDqrFaUFT+K3j1vlq6IZSdNgnYORVwv07OR+hovOfnnI+LjlygE8R5xqaKBb
	j2KYqjhcSh7HG9puki73BA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3scvevc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 20:33:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48GIb18c011112;
	Mon, 16 Sep 2024 20:33:43 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41nyb633kf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 20:33:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qDlxCg0uqDlFtjQakv+x4LtKDMTEw3D8GRI19xm6SF+EkF6LArZZJCjntYPgWu9E5slidZVzTtk+dR8AcR1EWGMfHIlLL47xN+eNqiFix5fZsYKYrikHv7+1Yyd7MyAJONlDsMsJ1wN5zvM68UgwNyHX+cr97pR6cFxEewX51bCxRl/NcVLetxsjM2vHX9MJu+CNhei9w+cykAZMi0rCJyxiuzKZRoL/tRdY0FGAnArAoRiS2UP8WX2VNwajvzkeIuwy+9lKvkZT0D/ABncXXJ4WPGbMva4OMqyar+vNVdT9pOEiLnC8QaSX47rxcl2oKbRdYwXurQU8OO/+Pl1yRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvwJ7BKduGA26tCz92rjlJNhU32XvRB/IzZIJjhTlYU=;
 b=yILPqTqG5f1QrADaXscc+x/shb5zfhXnGiXv2pRu6ipvaWaA/67zgmm372rCVLZ3MgCnSrDYvgypZglf9lWuUFgrs+IT2H4TcpJhX9Y17+EBvuq1E8Gp5G9H19Oo8lr7n/QeU6Djvrf3G3OB5TkESa+4PWKUiYwhQnAyxnrLeZx+k1kp6tsVa1N1BdZz6fa/UVPD96hERY917WrpcV8EQm3GuGBvlZXs0Pv4PlF984xlftT6JpFpT5uh05Q6hEFb7P0I+AyhzCfdiZ8IAGJhlGD+iFXyxjmZMpr+fbLYVj2oJTd8QezzA+R54ySJSa/Q3KWrHq2d5APN44PZSVks2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvwJ7BKduGA26tCz92rjlJNhU32XvRB/IzZIJjhTlYU=;
 b=ZaoX4G1LV5KlKq/vaZMcvvOerJbuESkce+uoXo21+1G3ncjMGF6w4yTd+g1gGkPzKA02qM2jlDYkiv37yTouvQUV3hALUpxVYcon5SjcA7ehe/9xZj+ui6EsCqKo1IVh8YrCtFl/Ug24McF3ubmf5Bd9598YiAEV1UbNj97NphU=
Received: from SN6PR10MB2958.namprd10.prod.outlook.com (2603:10b6:805:db::31)
 by CH2PR10MB4230.namprd10.prod.outlook.com (2603:10b6:610:a5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.15; Mon, 16 Sep
 2024 20:33:40 +0000
Received: from SN6PR10MB2958.namprd10.prod.outlook.com
 ([fe80::1aa6:4097:e5c6:932]) by SN6PR10MB2958.namprd10.prod.outlook.com
 ([fe80::1aa6:4097:e5c6:932%4]) with mapi id 15.20.7982.011; Mon, 16 Sep 2024
 20:33:40 +0000
Message-ID: <6880c031-3936-4ea1-86f2-5dc6050c9051@oracle.com>
Date: Mon, 16 Sep 2024 16:33:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: issues with Linux client pNFS
To: marc eshel <eshel.marc@gmail.com>, Olga Kornievskaia <aglo@umich.edu>,
        schumaker anna <schumaker.anna@gmail.com>
Cc: linux-nfs <linux-nfs@vger.kernel.org>
References: <41ee5118-027b-4630-8f02-b3a67c61b328@gmail.com>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <41ee5118-027b-4630-8f02-b3a67c61b328@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P223CA0007.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::18) To SN6PR10MB2958.namprd10.prod.outlook.com
 (2603:10b6:805:db::31)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB2958:EE_|CH2PR10MB4230:EE_
X-MS-Office365-Filtering-Correlation-Id: a9ed2b4e-4abc-42db-0921-08dcd68ed989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHY2OFlmSG9HRDl0dDZGQkF0SHVzNHUvcmhyOE4reXZCTXNsQ1JPcm1JZE9C?=
 =?utf-8?B?ZEsrYzBIUnVBUXpXbk9QYzI4OWR4VkNWM1hFaTRyL2t5U0ZKWHRTSjlpejB1?=
 =?utf-8?B?L0VLTit1V0s1RmFsLzRlaGFHcExyTVUzMlk5QlNYUk5aL0FOaklSMnJobmdi?=
 =?utf-8?B?UENJdWt1YURBMlgrRll4N1V1OEg1cUxJNEhQYS9PNWVKdm0wL3VDcUdPdWlT?=
 =?utf-8?B?akR3TWJ5WnJSdFU4OWc4eWlxQ083bnFJOHh3WGVVUjI0M0kzQi9RM2JKZkd5?=
 =?utf-8?B?RjNGUkYvYlFVak80eEZkcjdJd2Z5Qm1oNmJSSzlZVVZoTkpwNHpOZHd5WDRh?=
 =?utf-8?B?eWtkb0ZzZUU5MzZmT2Y4bU5uU0dxVkp2Yk1CRk9ldmFHRVJWRDNSVW5SUUdV?=
 =?utf-8?B?TDJVUThPYmRhQ0FCSVk2WnhJdVB0QTluTXZVVnFFYll2QWkxTHBVYVJscjRR?=
 =?utf-8?B?aUZWL0d0NDlSQkc5M2d2aHdOZHYyS2pGN0hQd01PNHZOYkp6VEJraWtIcWIx?=
 =?utf-8?B?aUVzMUNyRGMwSkpCSlh3ai9aVmtpSXpGcTA3Zk1LZ0VjenhaeldkcDF4RTZE?=
 =?utf-8?B?VW5MMVNnY0VsZG9Rb054T0hKZXkrbDQ4aSsxV0d1TWwvbUI0NkJyV0JPVjVS?=
 =?utf-8?B?TFZLVGdUUjhXWmtrcFNPdXhGdDMraGlzQkZnaFM4RFdYZXgxYmZLUFJDWUY3?=
 =?utf-8?B?S2VsV2U3ODRwOFVFTk1TRFBrbFJSTGlRRzVRZjRiZU9TSzNqUTFKdWF6cHFE?=
 =?utf-8?B?YmxwY3E0dHF3aUtJZ1JHZERUZks2N2VJc096RTlMRDE3WFhCM2hRbFZWY0xs?=
 =?utf-8?B?TnhWYmpVdy9aUHVlbmdEdzhkbjY1dUFKcVJ6UWtsZU5vZmVLaXdLQW9kdnY2?=
 =?utf-8?B?M3B0cDNkc3o3VmRvVTZZWDhHa29ZNzZZU3p5UmRyRGtqR014RENtUGxFYXI0?=
 =?utf-8?B?Y0IyOXBjSDFLQ0xEQzVNK3lTeUdKZDk5K1AvMmRYYldPYnlZRjcxd295Z01T?=
 =?utf-8?B?MWlWbm5kaGJGWWZQRkxCdDVoc2w1RGdiUW1oVVNqSUFLU01lU3hiQkZyQ3FU?=
 =?utf-8?B?T3FkcnJqR0pIcVZGdzZwOENzMHhmanAwSy9jSTZ2aWUvbzh3c1U3OGVPaDRq?=
 =?utf-8?B?ZTZRVjg3bGRnR253VWZKTFQwelhrdXRlQkRCbE14aEFhZ3hoazBIV2RmNXBi?=
 =?utf-8?B?TkdwekI0TnYzQmx1c3FKZVpEdjArS2VHMTc1YjMzdGRnNTdQZkNjdk9TcVN3?=
 =?utf-8?B?eGU3bi82NVFrMGhFS3d3Sml1bGZOWFo0dDZpVGo2YVdoL0ZWbkxyeEZZc00v?=
 =?utf-8?B?b2pyUFQrSFQwK0pMNytCbWxyNm9palhUNWxzNFpoK2lmenpRRFNDS0lvU2xL?=
 =?utf-8?B?WXI2ZjNlck5QOUtzRXNhTTdlTkJabkxJQnJUbWl2NnFMNHpCN3lUWUtlV25Y?=
 =?utf-8?B?TTRqZm5KdVdIYngrQmhsNmJZMFkvck91WklyQWhxSS9NN2xkUEpJcTNRd1hz?=
 =?utf-8?B?YlB6dS9QVUg0OTgyemVKM0V3MHE5dm1NcFB4V0xHODZ0OTVDc0dqcWlqeHdM?=
 =?utf-8?B?TlpHWTRYdVFXT2N2NWoxSEViRU9QYzJPWHQxdzhvei96djAzYzI3d2tiUEpl?=
 =?utf-8?B?eFpKY0NOSWZnRTExRE9XNEdrdkxFTnBaU1VHYVlsdnQ5dlppRHQxYXhab2lO?=
 =?utf-8?B?cWIwWHdFQkJDR1Q3UnRZVEx1dXowdnBZRnNqcHNGVktVbGlsZVpBdnAySW1a?=
 =?utf-8?B?cEc0cUJFQ3pFSVduVnhvS0huSVBxWWs2am5LRzkrcGhMRUFDTGprblZLNksx?=
 =?utf-8?B?TU9CbVEzM1VZUnRYVWdvdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2958.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUVkUHk5K2JMeEh4MFFiVGZIcDlndG1lT05lTnBCaXRWK3dTelVmQjBIOUdF?=
 =?utf-8?B?cHBEYlZZTDdJU3U3ZGxhQ0JRWVNvYi9YMW1pWFZCbUphU1lLZHdXeFFqMFI1?=
 =?utf-8?B?aFdjbE1VbkloVzBYSW96dHlmRHFiK2oyWDUrVzUxYXVBTm91bDdZSnBMaGhz?=
 =?utf-8?B?SitaUlhadnZLRG1XK0w0bmU1MDM2Y0E5ZHRNWWtRanh4Z2p2bC9EOEFnQ0ph?=
 =?utf-8?B?dXRHc1grZmZid3dUR0MxYjR6WWRtaGVBTkZ1MDlzN2o4T1F0eG4reVNqVmpN?=
 =?utf-8?B?QzdCdk1paTFDM24rYzRldDFvb0Y1QzNoWHE5RE9jZzBRQm9yV1ZXOVNsbnBS?=
 =?utf-8?B?LzQvWmFQQkFxOFJtQVhTRnNzb1dkaTR3RzNqV3lFYStHcFZodTh4QVJKVlJt?=
 =?utf-8?B?emMyRklyYlNFUkdaNzVJNEJMTHFKaFBPc05ZMjZWTStZbzB6RGZ0N0NFeHJM?=
 =?utf-8?B?N1B2N0ZGVnVXSjBzeVNlc0FWdUFKeXk5bWdoNUptRk9vaHRsc3NNSlFkdFdT?=
 =?utf-8?B?R1FFaEZtclVtR0kxc2ZWay9TTkZtK0hNMDE3WE1SWHorTlFOZ2w4Z3RwQ2FT?=
 =?utf-8?B?aFdTZzlMSXhLZENtWjJYbHZOZ2VVMVp4TDAvL2cvL0ttUjEzcHppL0F5bndS?=
 =?utf-8?B?cFhsMWlLL3p5cmtvbUFOVkQ0OE1zaFh5MDdZRUxrZ1pRc21xeHZCbEo4RHN5?=
 =?utf-8?B?YVBuY3phMDBRQWNuSWlrQVFPVEZnZG8yTHA2Mkp0MFAybnFDMmZtQit6Q0k0?=
 =?utf-8?B?ZmlVM1k2VnZYY0pwUEJ3eU1iZG5maUl5V1RIV1FaaTlBdmtUSnpHYjNoRTZh?=
 =?utf-8?B?T0JrTzErNkVubVVZNXo3QlJTL0ptdnVtK3d1dHBUUVRqYTJ6UlU1Z1RPODRS?=
 =?utf-8?B?YzlMcGJWZDhRZWlWUnNtOXhBRVhwN05NR2I1ZEhDaUJzVnZVNnB1OGV2MjRH?=
 =?utf-8?B?S0dQK2JiWC95ZEthUktOWFRJOE1hNkNsUFRBa2w5UTB2UWFzZ0FQSUV6aW1S?=
 =?utf-8?B?YUhhRTdxWmxYeW1FOE0vZCtqS1ZSVEREL21seW0rdnBicXBYT0RpeXJML3A3?=
 =?utf-8?B?YjlTUG0rcVMwVjY2Mlh5UUpxUEJ6NUczZ25Zdm11YnZGcjk0dnFDeWNWVzZC?=
 =?utf-8?B?TkZNK3hXcjJnMlBwaEhRWUhzVWZCRGs0dWtFdkFWbUZLMlJLV1paVlFhVzRi?=
 =?utf-8?B?Ni9JQXQzL0daUEszMXFQcnNCZmNPWDlBT2hEcjE2VUFkd0F6QWRDVDdic3M0?=
 =?utf-8?B?dkpWbVAxVEpUZWNUdGZ4S0I1bDZCaHlicktnc3AxTkI5UlppV3UzamRlNkYx?=
 =?utf-8?B?NlNZckFHUkVQU0t1YVBING42aE5acWh0Qll3SjJsRURrZzZhOTIwK0xEUDM1?=
 =?utf-8?B?S1RjQUlJR3pnWTdJcmtCeVhycDErNFRKY3g2WUJRdXlvMUdCVlZlOEJ5SHF2?=
 =?utf-8?B?R1FFWWVtVmZsNjBHemlTZTVEU2p1NWcwVlZGVjB5OGZHTTIxYk80TkQxQVBM?=
 =?utf-8?B?Z3hBTW13c2lLQmNGcTRVZ0h1cUpYS3pHSHpFdGRqTUMxcWhkeEJCWUhHSkMy?=
 =?utf-8?B?MHA3TkpsQk9DazhqTWlLVVF1NEhxcnpxcFpvVTRiRUJkakFWUkpyWnJsUFNx?=
 =?utf-8?B?T01ZekFWc1VORENBMWp5bW5QaFVjR1lncisxQmo5QjBORWxNUVpaL3VVQU0v?=
 =?utf-8?B?K0hrUStSTW5YeXVmM3RLNHIvaHhPY1laSGhLTXJaNHA0Y2FsWHJLVUZjOFBh?=
 =?utf-8?B?a1Vvek5TZldrMWRsMGE1ZjJ4OFdzNzB0RUFrZjU4NnNIanJLNjlQcHR3bnFC?=
 =?utf-8?B?Q08weVltZ1dKRS8vZlJIdjl3YzNHZlJXT1F1K2w4blZyT2tRaE5ITVVLdzRw?=
 =?utf-8?B?Qm5MS0pWN3FvRm8zYmRCd01YOEV0Z1ZOZ0d1ekRPT3NpSDUwY21lYU5oNHp6?=
 =?utf-8?B?Yys4czVReURLdDhYNEdZZ2VINjhvWXh3eFd3LzM5bFJXbnNGQzZtM25CR21B?=
 =?utf-8?B?UTArL2NkNUlTeUZtQmdIU2h6amhBcWVxVHJOUnNxcGV2dW1sZlNBN2ZXcmYw?=
 =?utf-8?B?eXgxNlUyRHJSUXJPWmFsZE9UMGQ3U09GcjRLMEJMSkUwNTNCTm52bUo2UGFX?=
 =?utf-8?B?SjhLN1QxRVFJQjhFYmIwZnFWek1VL3hVTHZxNVYya2U4QnU5MTBKKzlwYWw4?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	D7JmZGoYJfhhaY15l9d7v9DJxbzp13aXvxX6LpWUkhryfhWYcrlsahA85zESXDf0W/dV51sgyj9jzhRLbDZ2xzCtXTxPHMs4kFcP8k7JvUw/x9oqAOmBiuBhqIGGstvd1YfhCyJvuSXgMkW1cWTmhmF/5ppj1jBjApZRwPbI3FQM029WqWDWWmtolI1VNXCfylxORvPUjP0Neaa85WLZoCVanSBU7EqXwXDQxoTNR7ZjxAzqIo3XNf8Cdp/Nr2sQ3br9llbsOmLViCyCrHZidIiRWlbIP+mKCYpeTfgujxZJFMxRBcdnGTphPS7i3GmpJ/SoF73kigIAVFGlt+murzjB2wt5xRlONaKX18bzfS3jPkCCnFUBd1Ysc53nsLzkY8l6iqR5p6Q1mqcUrFAAvZDPkKpmjIb125msp3riLxAO3c34bZpdie16I0fOqWUX0TjrIOcS9d0dYWt0MNF9wxrh9Kvo65subdO/RXWGY8rZi3p4s0Xhb7quRYqwTSKyd7oRWzUqkipXO8WXcWzwL1dBXjCmN1FmHIE4i+Dz3oKefSl17XiAfkCccpctiULITn1pN9Kk5AUQPpxUGl2d6yn83x+unvCtED8OuPo5Y64=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ed2b4e-4abc-42db-0921-08dcd68ed989
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2958.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 20:33:40.5022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pzUqfL0oh3Ax4UKa8x/e6Xv4aDp8wUAT/qRLs4vBtB857PgAuU7fKBHOXuyqEK8uyL4IR3Alg7Df5vFa+WrWR3F1ihnBq31y5k3KZYhJHcU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4230
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-16_14,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=938 bulkscore=0
 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409160140
X-Proofpoint-ORIG-GUID: suJoo0YCb8TDaqJO1oPhXirKMTQuIMOP
X-Proofpoint-GUID: suJoo0YCb8TDaqJO1oPhXirKMTQuIMOP

Hi Marc,

On 9/16/24 4:27 PM, marc eshel wrote:
> Hi,
> 
> Who is the current maintainer of the Linux NFS client?

That would be me and Trond.

> 
> I have an issue with the way pNFS client is distributing the reads among the DSs and I can provide the traces if anyone cares.

What is the problem? And sure, send along the traces! I'll try to take a look as soon as I can.

Anna

> 
> Thanks, Marc.
> 


