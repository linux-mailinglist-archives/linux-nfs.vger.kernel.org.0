Return-Path: <linux-nfs+bounces-16617-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5EEC74598
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Nov 2025 14:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2A7673535F2
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Nov 2025 13:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB44834251B;
	Thu, 20 Nov 2025 13:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bzWwbk/l";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lgstSOfc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2A5344050
	for <linux-nfs@vger.kernel.org>; Thu, 20 Nov 2025 13:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763646304; cv=fail; b=jw0MnvYJ5DmMqzrG06a/Q/NyDar6sUs/a1Ngl8x8Sq3Zboe6c4Cu1NDzJz1TPD3+VJSi7Wia2hY2ApPrnsV91R9cdG9tLaix81+28I2Qq2DVROArjNww6w48vG6mJ9x7kdX/cDA/gvYxsFkDxpZhwwIZXwg5Y2pAcw58Y2ucaVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763646304; c=relaxed/simple;
	bh=FpkExeGipdaGQXmD2gdy+Qmi20la+ey1LeLXBws60vs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WRMz4tDxCtfgaioBYClVYF+5TY5jdeW072wjDgktl1Z7tYI0yp2p9yWiPf1eL+glEkwgpUyXHyGYAglWpWr3ou70J63jFe5sW16RGY/8zYbOYkk3sQb6TbO5h2d6hdRrt6eQn0BtmoNJVJY0V1tU7EZ/fELRrz4PqNq/EjeIlwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bzWwbk/l; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lgstSOfc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKCgFhQ025269;
	Thu, 20 Nov 2025 13:44:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=NdCpwknlo/pS+TgHvMqvAKe2WsWzOKh3Ibl1BpxV+GU=; b=
	bzWwbk/lBIpCWJKrTFqjugtPhj8+aU3P+NdS+bEROQLVM1BE+ZCJCWgnPtlxbtqs
	c4JZS9OTyHyrLqkiljfe8Z6jwRfmD1Jem/NS2BG/9T37jeEd5CsdLYzStXtxtAdd
	Qpm4qyC8wkW9v7ZrvSAChSjVXmRG5O265Uai3V9/TM6TKEKpVVHuAbvoVDKxqTxr
	YlipW91ibY5YpSrwvo1XOp8yw9zt4R8COIKfdvjuk43E4r4VgVcMhVDdbJER+HZf
	mULrMsth3Cg1l5i7tIwwVTsT2eX8DWRICQh9G6dm0TRU+g/0Wyz0oWT2nMJmVuUW
	M6e3EQVWkFyvVWHN1H//+w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbq14u8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 13:44:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKDQ6G8009671;
	Thu, 20 Nov 2025 13:44:57 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010039.outbound.protection.outlook.com [40.93.198.39])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyg5t98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 13:44:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wyh2QfLtv4Z9TRjy0puVSB1ReK8NUtkPF446XkpHrUoymcYlLXL7DqQuLRmmaoGxCwP+OY6xlW09N/4BOLtWzOYHhZnmqjy3cYoA4t+bvzPeps7IQh9wUiyMJXGPzFvNvuw5r48wTuarRXtRVrjiYNaRwDdo09xWuLmQHZZwh/gh5JDA30R3D29lCzqPdFUBa+FQe8a6LLSbIgWCnEvHscHBfBJzZLKr5H+lC+R8jqNWffB0hZlx5MjsiL2gMhwrqQhhnZyius7t9owcJoMBGDJ8UAA9zTZhVRotaBTlpoFuY/tGNPZ9hzTP0c7KENjUK92yXBClX+Rr2bnk57+xWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NdCpwknlo/pS+TgHvMqvAKe2WsWzOKh3Ibl1BpxV+GU=;
 b=PQSFyWghG8+e83EDCO/OsvuSt2VmH9xRgDIUK7eGCtVUqLVzOWGahbdSy5oD2U5a6QsLZ0PzeZ1HJAqh0mtMOOi5ZhDpbGyeA944HeASPVizU3nuYgIZRS5ccxkKJn+6+zbGu0ffFu7ylCWTGaxGUHx+B6mI8clwjXZWQI6YzjoVI2ipt2KOOzhKByg9okNX9r2bWIycFPOGFhogDb1VdwswDL5m/bvuVox35XGjIRqj6GgIXOfYTIvvRs3Kr9DGwUybDwtWdhErc4oxY+lGghOc8/Gk/XHnALrnAh1K8apjNSAI14M7eyMT3xeWtqXrW3aK2WrQULERFFEvy4sGvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdCpwknlo/pS+TgHvMqvAKe2WsWzOKh3Ibl1BpxV+GU=;
 b=lgstSOfcnpLjIOc4iWzVTAtzg4E4Bp4g+P+bAH+tx33aC5wkwQ8Pkwn4yvD/e3gPEQQGvpDBmbQwcbloghqFaXV+UIAFFIuZLtPhah3fBE3LOitcAXg+uz5OhHkGeeX8TaNd/Hmsd+dvIbXGRzGX8gfpNMlo8m3GCvGejERggKI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW5PR10MB5825.namprd10.prod.outlook.com (2603:10b6:303:19a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 13:44:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9343.011; Thu, 20 Nov 2025
 13:44:54 +0000
Message-ID: <02f6a095-5f64-4e06-b799-6213f207fa4c@oracle.com>
Date: Thu, 20 Nov 2025 08:44:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] SUNRPC: Check if we need to recalculate slack
 estimates
To: Scott Mayhew <smayhew@redhat.com>, trondmy@kernel.org, anna@kernel.org
Cc: linux-nfs@vger.kernel.org
References: <20251120121252.3724988-1-smayhew@redhat.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251120121252.3724988-1-smayhew@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0017.namprd18.prod.outlook.com
 (2603:10b6:610:4f::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW5PR10MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ed9f66c-4f1e-4278-9168-08de283afc7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmNBaGVHZW9mWDJ3RFhJUVFKV25wUEFFV2dlcGdJdnNDelpXbCtuYW1OejZJ?=
 =?utf-8?B?cmxhVThBT29FYTcvTTNmMVd2Zk1LbEpKek05ZldDTDM3L0xNUU1MZ3g4Y1VM?=
 =?utf-8?B?TnVPQ0c1eUYzNnQrWjlEZVl1c25uNmZOQitXbk03RFB3UjNYa3FlcmhnNnJi?=
 =?utf-8?B?RmFyZmY0MmlQU25aczlER3A0NTA0SXB3RmtXR0I5QTJnYzYybXl2bFdzUS93?=
 =?utf-8?B?V29LY1dpM1BuQ3V4TzNXbG9OdG1BclZNemJveDY5eENoc3JLQmlWN3ovOXB4?=
 =?utf-8?B?RWZhQ0tYVDNHSWVobS9TN3BxRUI4dlRvSUUyUWJ1UGR2aXl6NHVySC96YjFt?=
 =?utf-8?B?WXhBTi85a0FrNzllYUQ4RDR4REY3ay9jcnJXRVM5QzBaN3p3a1BJUW5jZzRw?=
 =?utf-8?B?c2dzUkVMYWV6SVIzVE05ODZpZDlheGh0citoVDN6OW96TE9MRzNqT3ljQ1hQ?=
 =?utf-8?B?cDRMNDNiLzYxQjJLTGE1TE5xNmVZakNPemRaaERFb2g5ZXdmcHhWekRmSlFH?=
 =?utf-8?B?Yi9wT1Q0S2dUalB2aW9jN2ppWFFrVGFYS2hUN0JiSXJJVWlRc2Z2ZFc3MStV?=
 =?utf-8?B?V2dpTFY1bmdJbkdWSWRrRGNGa3QybXpOZk1Obld6UHBrNmlDQjhkQVgyTFht?=
 =?utf-8?B?Ykk2VkprZDRLM1VqNDNWY2hFMTNHOGY1a0hSZ3RBOVlJdjJXZDNUVUd1OS9v?=
 =?utf-8?B?S0cyRXlFVy9LNnFKYzljSUhJTUlGSkM5TGhpRGRIcS9OQktNRHRRMVVKVDJL?=
 =?utf-8?B?NnkrNHNVSUwxNCtLdi9icUQwdm5CR2pldXVVSHdDUm50MS85NXFjRmpVS3N2?=
 =?utf-8?B?SzBmbFNKZTdGTnQyamJBNGNPY2w4R0hYZFhEL0oxMWVWT1BFUnVqUGxZSUlK?=
 =?utf-8?B?Y21ZRnFTR05YSUZjQVhxbCtsanN4ak5wQ0xtWm9QYjBKOXhFbVJpQVRzZ29P?=
 =?utf-8?B?OE9ZckVCTWt5WWhqRVpmYTlIaVVTTThtNktBRXE3Qjcya1J2YnNIbWw3UjFV?=
 =?utf-8?B?OEo4bWpkeDAwc25kbmJGaXNtNk92NlRsVG93S3Zvcm01TmtrTnJiVHA2MDJk?=
 =?utf-8?B?aVM4V0VRTXhJYTlsS3FhbXBuWGREUGJISDRidHRIbVFjUnZaNG1ZeFJxR2Rm?=
 =?utf-8?B?Z255b3Uwa2k5alJVcmt0ZjJVR1pjSWxnODBDSjNSUmJkZ29uaUhGYlRIWjJw?=
 =?utf-8?B?ejFGTlhDZmVYOG96WTh5QjZqeERXTllJTVJsbmxzRGJuYlFMaVBoRG9qTUZy?=
 =?utf-8?B?U2E3cGVrbDdJMjJqWVdkcHFKaG5RSk11MUVUWVRGSzRuUHl2eXFKTEx5TnNE?=
 =?utf-8?B?NE9ReGZSRFRiMXBLYjRVWmhKSFFEMGw2UVg3UXlCNTBnR0g5RktKUzZqaVBv?=
 =?utf-8?B?dFBPODFsTEFRZ1FRNEdSWk1BUUhlbnlmODVQaitXZFRIUDJ6R01qK0cvWWdP?=
 =?utf-8?B?SU0wbzMrY2IvS2kzT2V4SmJsUm5jWVc4WUsyVEh2b3Y0SXE3dmtlWFhHVlh1?=
 =?utf-8?B?WEV3aGNmQzZDdjBIbllJVHRFTUxxbkNYTWcxSVY3NjBqdDZxU3JxTzhmVFdW?=
 =?utf-8?B?eXgvZDRwZ3Q1VjlRTUVlOUxjUkd0ZmhGYlpKbnBIVDN6SCtMQ2g1cjhkdTF0?=
 =?utf-8?B?S0toM1NQUENNc2RNL3RBN0N0c0VpTjBpTXlESkN3aHRYZnhrcWs5ekVBSlp5?=
 =?utf-8?B?S3Y4RDZuN3ZHaWVMQWZ6K0VDdnBGTDhXWklnKzYxUzRrVkNBc2V1VGNRdXZS?=
 =?utf-8?B?VjFiZlpBQkZGelFvZUZDWkMveFF2ZG02cWYrRFVDQ25WWXJmUEhyWitIWkFC?=
 =?utf-8?B?QzdiTU0zUCs0YWRGNmZFK0plc1Q1WDJuUnBheVMwVHlPdE5WZXQrR0tGOXhv?=
 =?utf-8?B?SklhMkJFb2tPRkN1REdYZEpydTUwN1d4MENOUmtsR05pbDBTTk9CazBtM2pZ?=
 =?utf-8?B?UnQxY09aT09NbFhRRDc5MEE4bXF3bk5zWXdGSk1DdzQxUEVQT0VCejg3cW1J?=
 =?utf-8?B?NzgraUdEb013PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXZTNkRJcmt5NG41TGhKMGdXOCt0UHcwMmNsT01XU0VjVkswQ2JhRFhnT0VR?=
 =?utf-8?B?TnFJUmptV1V1SHI2SENlVStaUEpqT0pRTVg0eUEzUE9EVVJTSFpndjhxT2hy?=
 =?utf-8?B?SXRlSGhXc3l6bGtRTi9SZHFyWDFIdERBTkFKNjJaVVI2MHNWSzQ0UHphU1dR?=
 =?utf-8?B?UFhKVU9pWEFzeEhOZk1rM29BdS9IU3MvcnJMVTZDb1dTVytVNnllTzRKTUlo?=
 =?utf-8?B?NWhMMGpsZHZ2L200clc1OUU5TXBzSWlkVFl3UGdSb0lVdDlFQ1JDVDJ4SVk1?=
 =?utf-8?B?SHVyNytTTVBoRmtpcGVGM1FmejdDVVNtVXA0SURCR2VVS0RDOFV0VGxzRVlu?=
 =?utf-8?B?d3d4ZW9MYmFqek5rZHd6clovVTVvRkNTOXZoMy8yZ0MwU095M09FTktlVENx?=
 =?utf-8?B?a0VQOUs1WGJxQkFaUGp5anBrS2RwMWNWQVM1MGJVVmFtd0k2RDNJMk13QnZq?=
 =?utf-8?B?a0JsY3I5bmpYU1hrOFkzMlZOU2hRTkVMVkRVMkdnZlBabUQ2cEduSnBwMVJN?=
 =?utf-8?B?dDRXc1lVdWVoNkpTNXdzZDdNL3M3TGRQRGRVQUVRVXA3OFBCZVVOYmtWVmhq?=
 =?utf-8?B?czVHK2RGd0IxSnk2OU82VHBSREJwUVQxb3R2K0dVeFpDTEVGYnlNcTNkUFVa?=
 =?utf-8?B?dzJXb1o1bUN4SGlDcW1Pd3loT2tndUVGcnkzelNwc29ncnJ2Q2JaVXd1WnQ5?=
 =?utf-8?B?WFk3UnkzNGNlZEo0T2s0SUNMODlKQ3hDVE9iSUU1VU1ocmhnSjZDNklncTJL?=
 =?utf-8?B?d3V1SkladXFZRHZpblBFdFBaclpYMWIzc21xeC9tNmNLbUdQQkUrQUVjRFVn?=
 =?utf-8?B?aUVHN0hBK0gvaWRBbGVLS3BlMGd4VGdabHp2OGxDaUtDRkYrVDc4UDhPRXV6?=
 =?utf-8?B?cmJGZERIeHZKQjU5bVFLVGpaSEQxajNQM0hHQjJTaWsvYzV6NE5ReFJhUmdP?=
 =?utf-8?B?UkdQcTRPemU2akt6SFhndmsvL2NkYjRBcFdqSDBzdUh3R2g1QWtHTi9Ya25V?=
 =?utf-8?B?YWxzSGVmVno0ZWY3SU8wYndPaUZaTmRPYno3eUVTWE5lOWg2MEdqNDRzZHpD?=
 =?utf-8?B?UGltMGxVUWt6OCtBSTNXdmozcHhyYXgxTW5uM3Z3WSs3N1dxOCtQa2dHUVdk?=
 =?utf-8?B?SC9oRVVNSnNRNUhNYURIV0hkVzZQVmlVTzNPM0hsdGh5SmZObjhaZ3dBMG5R?=
 =?utf-8?B?RlpBd1UxNVoyeE9FeXEvZERoekFqTEZ1cCt0YmllSW5yb0RBNVNodkFIdW54?=
 =?utf-8?B?QWw4amdwNmFCUGI4TGxtMzZudVZqZFhzYlA3bklMN2xQTUJQU0d4bFJGOXJ2?=
 =?utf-8?B?elk4N2dtQWxsZ0wzNG01MUNSallIOTNmN0dMcWEvcDRLcDRjZ2p4ZGJRN09V?=
 =?utf-8?B?SkVzVTJOTXJMM3d2M0RINFdnUVJ0YThKU01BbjR6YW83RTF3S29RRVBIQms2?=
 =?utf-8?B?bUppTnRoMFZ1UUY2bmFiaDRKWitVQUhHeTFyWTdmTVZPV2VtRTBkN3BZMlc3?=
 =?utf-8?B?dHNVVHk2WmFKTVMyaDB6ZTdVK3ZVblExVzQveHpEUzhnQ1VDT2ozUEJnY0NY?=
 =?utf-8?B?d2ZleG1GRVN2Q1doOXE2UGo0bTBSczdxZHRQMnZpbjRvaEJBbUpyd0pGR3k2?=
 =?utf-8?B?M2x0RENSd3dZYmdTcy9XcEFqYko0VDZKaE5nbnp4MzVmVlNZT2xreEFwTGpI?=
 =?utf-8?B?OVEvdUJ6OGtVamxSZExSSDJQL0h4VHRtYXNMN3RNdlUvdENncnNvM0lZNUc2?=
 =?utf-8?B?Z0p1bEdpS3Q1T0NmekRISzRMZ0hWSDRTWDZiNGliRkRsVFNhUW5MamJtQktY?=
 =?utf-8?B?SXE3NjlTUDkydndYa2N2c2RRVHZjNUkvdnorTWgwSEVucTVGRUViZjZyalAy?=
 =?utf-8?B?NFl2R2cwU2xPcmpTZDJYNjV5UjJ0amZIanh4WkhTd0lVUmxZZjFiQk5wN3Vl?=
 =?utf-8?B?TU9odVlSbk9QbFg5TzB0cEp6MCtsblkzZFA4TXprNlBkSE4vNjBPMVJCQ2l0?=
 =?utf-8?B?c1d6WnMzalIvYU1EV2IyczdWenlqWHFoZXdWdEJKWmJDSVd3QUhEWm1qKzgr?=
 =?utf-8?B?VVBTN1c4TWpjR3p2bWRlcGJyOWx4VFhSQlAxTWdNeVJZVnZRZzVvdWkrZHFS?=
 =?utf-8?B?SWFyaDdlYTJGc0J0bjlpc0d2dkFheDlnbXNIbnFCOXVSZ2YxTzBLMTJvSkl5?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LcENW3+4tEhlSQfiluAJtrSNIb5DtMp1MvHt3gupvu34Y+PByoGWjGaSuoehPfUv2sdLA7U8wq3gq5kASgaQCOC7YeqxbE5IB2lD7Hx68vERoGqd0pq3U5AF5oc4POW/EcqNedz4b5EtOw0w+5vTZ8+G7PW8UorxUZfEdVXvGysFbNA/imvPpUYJFvZeWxxLb6uLx/xeGUJphtmcOnkgPV95sQ6Mbuuy305NPr68NULXHVmq4S+ufATCWKYX6lkUYiZ/VFwa1AnUORCoJXDZYB1y165p9zRtqJwE/yJ5AwTMDD27qyx+NDAsbEMZUi/AIqgqiL2bKSvxd1TK1E+qGBhwbv3F+EfrgJ7AQrkHBTaSoyGNItiJqFuKCtE6pAQLmI45q6uJWwywWOuYkikxK4DWIpmRof5GlrOzRLXCBLeLIrYQbcmMBHmPOkOF/0pv68P2paHO6zCxBoj9UxCWF57PDCqMLe7tbkaZGyWx11hQU0cCEnK1eX/6VezSiw1NnIo5WAcMp4TBxg1sBfWcwYZem9CThdEF9NIP1SnYS7Axa4TApTQZKzU8tY4zyccFdvBlrXbLDgUDQq1RSWwzRwqirv4C8e8Ux+bGR9UrhCA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed9f66c-4f1e-4278-9168-08de283afc7f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:44:54.5289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7xhatwMW49iq4WF1Zci7tgYuNLKBQlpc7zx7xxo+P2niYdtwLaB9tScL9tLRn03o3oJJlnpnUMQvFiDDD9GMOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5825
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_05,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511200088
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX60rzq/b3Lska
 Wyvg1uS8Sfhp36PIkJbAJ7aRdmDQc22bDB0+c3bjQCqGun/GKO+vxPrvhAHVcaVQti4p1LcsA07
 I3OiIMAJyD37CadmenhUSAQZ2S5rQYCAbLwq9jXGyub+gGRZW2X3snKm1HAW5f8Bl2EgsZRbSkE
 LvxjHNCB/PQNJxGcjWxR8HGphWC196s+uw3fFzLzKBmY1iSGYIfkR8SBlVdxxtzN7yrwOhNR7SQ
 n58DVq6YpjPX7ByNbQxGcXz/igiWcG8KkEIEKa/UudP8GO1qlHlasVkFh/sSwAIeWhlr9j+11vr
 za2CYkLSQLk2TtUDOegef3ue0iCpkwp0PxiOMztB77cm/Zm8s3yahwj6Aj5vjKQwsf0SaxxKKg3
 66pAUv26KV/l7b/j7gjtfIQl0b7nBYO/HOTgUGIFvtDXL8F4DKo=
X-Proofpoint-ORIG-GUID: ojjRV4-NM2e4Q1pPwDf2a1xB7VTUbUup
X-Proofpoint-GUID: ojjRV4-NM2e4Q1pPwDf2a1xB7VTUbUup
X-Authority-Analysis: v=2.4 cv=a+o9NESF c=1 sm=1 tr=0 ts=691f1b5a b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=xNf9USuDAAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=lrXJuNyViq_6JifYkiwA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13642

On 11/20/25 7:12 AM, Scott Mayhew wrote:
> If the incoming GSS verifier is larger than what we previously recorded
> on the gss_auth, that would indicate the GSS cred/context used for that
> RPC is using a different enctype than the one used by the machine
> cred/context, and we should recalculate the slack variables accordingly.
> 
> Link: https://bugs.debian.org/1120598

Since there is a bug link, a Fixes: tag is recommended.


> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
>  net/sunrpc/auth_gss/auth_gss.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
> index 5c095cb8cb20..bff5f10581a2 100644
> --- a/net/sunrpc/auth_gss/auth_gss.c
> +++ b/net/sunrpc/auth_gss/auth_gss.c
> @@ -1721,6 +1721,18 @@ gss_validate(struct rpc_task *task, struct xdr_stream *xdr)
>  	if (maj_stat)
>  		goto bad_mic;
>  
> +	/*
> +	 * Normally we only recalculate the slack variables once after
> +	 * creating a new gss_auth, but we should also do it if the incoming
> +	 * verifier has a larger size than what was previously recorded.
> +	 * When the incoming verifier is larger than expected, the
> +	 * GSS context is using a different enctype than the one used
> +	 * initially by the machine credential. Force a slack size update
> +	 * to maintain good payload alignment.
> +	 */
> +	if (cred->cr_auth->au_verfsize < (XDR_QUADLEN(len) + 2))
> +		__set_bit(RPCAUTH_AUTH_UPDATE_SLACK, &cred->cr_auth->au_flags);

set_bit() rather than __set_bit is a better choice for a lockless update
where multiple concurrent threads can have access to the flags field.


> +
>  	/* We leave it to unwrap to calculate au_rslack. For now we just
>  	 * calculate the length of the verifier: */
>  	if (test_bit(RPCAUTH_AUTH_UPDATE_SLACK, &cred->cr_auth->au_flags))

Thanks for pursuing this one, Scott.

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


-- 
Chuck Lever

