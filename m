Return-Path: <linux-nfs+bounces-11092-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 049A5A84D36
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Apr 2025 21:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAA557A9C07
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Apr 2025 19:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A949214221;
	Thu, 10 Apr 2025 19:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TRk3Tjwf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B50vMcvE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383481E5206
	for <linux-nfs@vger.kernel.org>; Thu, 10 Apr 2025 19:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744313992; cv=fail; b=iZJK6VNeOVVTUE27LqJHm5pEWu1gytcF33oidoiOChfiaQKvUL2tScHNSHaN3axl2ml+rKZw2eent2BMjP+T+LmmmyiG5JoIb7FN4YbThp5X3PBG4MMWJ2VJdaoBILdZRvzUqAPCkGWYNKDFNlXmGaNt0fqf8zHcRmkvq9ZNnLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744313992; c=relaxed/simple;
	bh=EB40JHRFtypv3G6rGDpPRF2iaGoFFUtlBQx8n4L6wMU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VcNAF184gDhgug0PCKSud0pV4Vmswe2Eizl8K/IjNUEGQnpjS/ZNvA0BuON7WIQEJDW8vNEOCI0A0HwrOEdzIdi+4EUEnTkMjIr6v0e1+A3cx8sxr2CfX7E29hqk1K+Ulo+8LQJsvHjs31O+XH5neAAszrd5CcsD4hfJqsPLaP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TRk3Tjwf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=B50vMcvE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AJM0sd015251;
	Thu, 10 Apr 2025 19:39:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=t9iywnPVMDOW5NVTkPf4ysPtLcwhmvMeqfrZNPDNQIU=; b=
	TRk3TjwfPUUU+BrcjGe4oFvHIdw9wB1D9qyEX3yKeqzox4llcJ3sE0ipOaTNw/0j
	s65bTZLJB6ZlHmQoGqasCxTWUXqrp/d3MyccEZIXKzl0zSxqV1yQsBTr5I1jk1pk
	zI6CjrXNwVjox3Th0f3SAxGMJgGB2t5JJs3naw4hsxWAeI/c/qyQlGrxUnKDb7Br
	CzPi4pyLraSl2dC7zZAxlVqg8HkRiIgsL2ZyHUJtOfpZ38yoRG9F8+3DXdMW1tgb
	4XfrhY1ta7CNP5/5ZvcnU0PCrdQqWscWpE+VM+ACwx5daKh9VJ1Nz7hlp3WmHxsY
	gtTZhUSVhvK0tZ8DIxfaiA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45xm32g1d1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 19:39:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53AIAHLG013682;
	Thu, 10 Apr 2025 19:39:44 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazlp17010006.outbound.protection.outlook.com [40.93.13.6])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyk295h-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 19:39:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tUxO71tGdwsKiBUFAPnZcXpAaNVkT3t/FtT88vfpepCTUr4Bl+UCOZZGldzPJGZMs5mEgkBtUlko85h8LRzRdsL9Cj5KL9AXTRqfCsERwsMFQNoRwcIntG1y79hRHN6cCXz/uwPfXc0saw4QokiuRgjuE8vtKKO2bRXEO0HCarwXFTdFzz2n068t532fxW2vgYr1D4IPnz9ONHnw8FZtIBLTND0GJOmGDPwjn7BFtH55H8w7aUgrfHMen73c9U3N8BcgWE4CWudmGbBB4QLIl+d8T0byfzklSRWRUW/BUjUTqsfNzQmcRfUbHbnxCPyiDYNeCmY6H1mp4qYChQFuVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9iywnPVMDOW5NVTkPf4ysPtLcwhmvMeqfrZNPDNQIU=;
 b=U9dRMK5oFxixPw3LOTQf0/kbkGdC+mLehUJ6ICyR+paJDmhcqpsAn9Un3l1bAoRK2mwpE/8FIOxf2TjVNESfEhNm9YPbeM35WQqAxpRc2PcSWujt8C82sqeG5y1fYoX6GiEXgWwofX8o+/4BpvHYN+mNw8Gj9g6FU5skTy93RvsRHky7T+EZVr+Zlk4xWphrDRqo6qIGZTMmFsnPk1TP2eAShPjMGwICHZt4j04+lU90gRX6GD9mx+WvfZzEMmIsa+inwAXfNn1fZsW/vXnXa6ZOcqm7tjzoc5EwF+NJ7Q+BjNaW82oln8ev/3ru9/g1XLfU8l8cDyGkLVRy8uHqsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9iywnPVMDOW5NVTkPf4ysPtLcwhmvMeqfrZNPDNQIU=;
 b=B50vMcvEfWSHcFCI1/ADLC7CyXzk6QgEhRduIzSMEeDFfqH8xneZWFPEAX7CA+RYT99wFgd5pkdh98UZR5XyexaFTS5enG3QJ3oP/+I61ye0OrUQPSQuEi7c1/03BEHcEO4sg3Ow6UR+R+lKW/5fLJo2yjo6jv4tStpkncilAeM=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by CH0PR10MB5067.namprd10.prod.outlook.com (2603:10b6:610:da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Thu, 10 Apr
 2025 19:39:41 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5%4]) with mapi id 15.20.8632.024; Thu, 10 Apr 2025
 19:39:40 +0000
Message-ID: <64123840-4fd7-4d76-ae99-c92138d20a4a@oracle.com>
Date: Thu, 10 Apr 2025 15:39:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nfs: move the nfs4_data_server_cache into struct
 nfs_net
To: Jeff Layton <jlayton@kernel.org>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>
Cc: Omar Sandoval <osandov@osandov.com>, Sargun Dillon <sargun@sargun.me>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.keornel.org
References: <20250410-nfs-ds-netns-v1-0-cc6236e84190@kernel.org>
 <20250410-nfs-ds-netns-v1-2-cc6236e84190@kernel.org>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250410-nfs-ds-netns-v1-2-cc6236e84190@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0024.namprd05.prod.outlook.com (2603:10b6:610::37)
 To BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|CH0PR10MB5067:EE_
X-MS-Office365-Filtering-Correlation-Id: d2130acf-3f90-42b6-5a17-08dd78676fa5
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?cHl2cWFtbm9objBDVFlkeEY0WW15M214Z25PemRMbnF3VEtTYWdPclBuNnFV?=
 =?utf-8?B?RkJJZFBJejduUW1WVnJiQmdUZkp3QUsrdStsU3hDYXJhcFJXazlRMFY3Z1FX?=
 =?utf-8?B?dkhUWGNzUUUyU0xHcFcxUjFzRHRvWTU3dDZIU0V0RUgzTHQ4czlDMkQ2aXpx?=
 =?utf-8?B?VGZUKzUwV216QnM2ZkloK2FWd1l2WkE4eXI2QVdvQUxRbUxVNFFFQTg5S3h6?=
 =?utf-8?B?VTBOai8yTjQ2NWRtS1dOK1N4bmpWQjUybDVyN1lWdnRGV2l4aUQwVWY1K2xS?=
 =?utf-8?B?WFNXckFkeEg5dEw3U1RmVUdEVGg2cnhUcGZtMEJjcjd6MjBQdTRKVUhWTFFJ?=
 =?utf-8?B?NDdQRVphYzJzcDRoUHViUEp0NjBveXFleFBFUCtYVVU5VFhINk4vbEFYbTlR?=
 =?utf-8?B?b0VuTllNZTNaaWRtSVNmM2NNbXBKMDJwQnNFS256M0dPS1RXa1paRzVNbjFw?=
 =?utf-8?B?ZHNFVlBlc3RJWEFTOHpYNXpsYk9haXFYcWRabUdUamV6U1ZBMjZQZ05MUWY2?=
 =?utf-8?B?M0RtK005dG5JUXEwbTkyby9uYXExZmp3bEpiemo3OXFoc2FQZmIxMWdlZVBQ?=
 =?utf-8?B?SUx2d0RzZ0JONy93aFh0YnNXTDRzcStTQnFrTmg0Q1Q3ZVc5eURtUmdqWlN4?=
 =?utf-8?B?eU9TZmMrVTRYaDdVVHoxdHBGT2VYR2J0ZWVjZ0ZQUEVrK2pvNW9IeWNTcFYx?=
 =?utf-8?B?dDhVenJEckZReElzV0NzQkF4UldhT0ZXcEVKcTExRWpLRmhWY092cEIzb2VN?=
 =?utf-8?B?YmlKcURIMDBwQkRQaEYwTEdnd3JaTzl4WVpaSW1Nbm9WT1pZY0FwNEUrNjdS?=
 =?utf-8?B?dTVoenJqajFDeEwxcmFQZkNlYTFZSkVPRjhTc2YxQzF1ZVB4UjQ4YWVrSlhS?=
 =?utf-8?B?UDBsN0VXYlJocGh3QWFCYU1FNjRsa2NRZUxyL3cxRDdISkFLaWFKSXRieFc3?=
 =?utf-8?B?Qk5CV3dOOVJtbEZQVEJDanJMTEFZMUpGTHBFRjV1MjREZmZBaHcvMEducnFS?=
 =?utf-8?B?VXkwN0J0Rk1QRDNkWkRmTGVvZ2pnQmw2OElPQ1VyaFRzdVVIZENUbXBIL1pH?=
 =?utf-8?B?eUFOOGtVUmJ2dFdaa2pXL2RZV0ZBY2wvdU9PNmxucEpZK3NadS9tbUlmNWsy?=
 =?utf-8?B?dTg5WkVpNmo0MmRyZ2JqM0FXRk5VVWxpV09GVWRWZjlPc3prTUk4WDY1c2pm?=
 =?utf-8?B?Y2ZBMUg5STBNakdjVExOTzdBelZXNU1FTXBxaW53MGNDWS9oTzQzdTF6aS9K?=
 =?utf-8?B?aGxJYWJSNHRZZDBqWHV1M1hYdUtJQVJBWmJra3NoN1Y5MytpMS8rQys1QllJ?=
 =?utf-8?B?NWtjSldVc0xLaFdldlprV1IwTFJvY21lVW53Y3ZQZ3p5SkNPYXVsTmRnSmF1?=
 =?utf-8?B?UTg3WHVpWkUveVhMdzNnNEIreDNTZ3dlemV6UXhudGNicEc2eUpTYllITFpm?=
 =?utf-8?B?c0xOeDl6Q2dCWGJHb3V4N2Yyd3dmQ2ZhME5DcWthaytZcVJVSXFWQ1lsTk9p?=
 =?utf-8?B?QjNWVGkrYkhRZ2NWb3RjWldWZFpjbkxUQ3h4enQ3WVB3ZzZ2NDQvSEZFTHMv?=
 =?utf-8?B?eFBnQkNuUE5paUZGdFVZNzMyZzMvMzREVWtERWFIM0lSdlltRkxqbVgreS9D?=
 =?utf-8?B?VjRzNFI1QlhPWGp1TkFRYU5QdnpSSC9Zd3NZeDNCaks5ZXNET1BWYWxIR2JM?=
 =?utf-8?B?NU1BdGxjaVNyZmdFNUp6WWZBbnhzMzMycGhYeTZTNFNGdDlNU0xlTkpNTjVO?=
 =?utf-8?B?a24xT2Q4SmozWVZUY211R1JaZm9wWUwzMGNrcTRlTzJocUNSSDQ0YnVBUEp3?=
 =?utf-8?B?N216TEM4WDFzY1B0bmZMR0lOcWQ0YUhvZVVNKzlyb25oZlhHWEhwU2lJV1RK?=
 =?utf-8?Q?VzUechmvRbcLL?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?UjJJV3JBN3JLNnNySTk1WmJRYXRKbVBTWnIvNWNlYlJ6QUppOGhnM1VBbzlY?=
 =?utf-8?B?b0FQeGI1cWZHb0hrcXoxVHFYYlg0NmZkU2dtdlBodlBtNVNBVEJhN05TTjli?=
 =?utf-8?B?MnNvREZ6ZzZHcW5WSGNFcGpYVUF5TDVMQ21JQVhUelQrdjdmTExuOXRJcUE1?=
 =?utf-8?B?d2xFc3pVeXlLN2wyU0lhejJFZU8yQVlsTnJqeHZtVVdSVVRCczVBZG4ydmhH?=
 =?utf-8?B?Z1VmYklVTHJxTzMzb1BQN2Z4NU5EeENld1F3a24vQnRJMUx1M2tBck9Xb2Uy?=
 =?utf-8?B?b0taVzkxZmNYclc4Q1VuMkJoQWJPTThoOTRnUGpsbk1MQ2Rmd3FDbFMwMmNW?=
 =?utf-8?B?NXVaa0FySTd3YXd5YW5oS1l5dGQ5VkM2RVdRakdCakVOeFBzYUQrUzF2MSt6?=
 =?utf-8?B?SFU3dGJ4bFR6SEZlZjkxVkJrZHFMeDNaLzAreFQzdlBoeVZ4S2crT2ZaV1pB?=
 =?utf-8?B?bGFIZ1MwRnVtNUJiVHV2OWF1SGQ2Q1F2b3ozaDlXNEIxUWZka1ZzYXNmZ1NR?=
 =?utf-8?B?QjQ0ZUJqMm8zSE9xQ0ZkeDhYRnVYRWg0Z29xV1FyREthcXNUVkYxOTJLVTNP?=
 =?utf-8?B?dlYxWjlmODk3VWNvUjIvY2RPR0ZTTzhwWU5XNGQwcW5XanJYTjBFWFM2TFY0?=
 =?utf-8?B?RGJvTTZJQ0pLclVvWGV1U0VxVTkwVjJFVmVaOXYyOTZnRHVBbFN5bm9zQzlw?=
 =?utf-8?B?WTdnTzV6VFVncEVReWNaZHNjeFYwZ3kxeXNOL01ZOUowYXRPeUlVbjBFODVX?=
 =?utf-8?B?aEpXanZ6L3MzL0tqVXZNbmpQSGNjNTBoMnBtQnFTckVFb0dIeVhuQkVXcEtx?=
 =?utf-8?B?dGpNeHNGRGhUNGRnRkk3NTFTMjk4ZVhXMnpmdkZldCtaZ1dTQnZVeGFEdU9h?=
 =?utf-8?B?czMvNkNSQWJ6Z1VCTUlwQnl2ODNOd3Q3V2l1UkprYzFzWDlQdWZFTy9rZFg0?=
 =?utf-8?B?Z1FqZ3V0RXlURWtEd2FzODB3Y1NFS0tjTW5FWFdMUEtHbmUzYnJsREtySWVL?=
 =?utf-8?B?NWJldmt1QlcyalREUmhVejVpSHJ1OXVleHFOU0Jic3lISzRDcWJvVjNjVWsx?=
 =?utf-8?B?UVNSZC9DbS9nV0gybytFZ0ZES1BtVXRsOFdsRkEvKzR2OWFOQ1RVd3VSTzZ6?=
 =?utf-8?B?ckRxYVZneWNJK1RFc3dSY1ZRc0hnTjR0M0ZEWFdXMXNpaWUraG81dFFlc3RK?=
 =?utf-8?B?T2NNV2JOeDBDbHlQc3RFTW04OU5uNlRjMkdMWW5Rb2tGbS9LMmFTdG5oLzFa?=
 =?utf-8?B?UEpCV1pXeGdxaEUzNXkzOFlLWjZsb3h5cVcvRml1eks5NTIrU3c0d2pxNW93?=
 =?utf-8?B?MzJwb1d1OVJUeE5UaVFOUzN3Ri8wV3M1a0hQQmYxZ1lDWm1GazUvZGlJRCt2?=
 =?utf-8?B?dXpIMTRncDMxaTFBMGV5TkpLVUpHM0c0RjF2c2pkSTZBYVRYM2Y0ZFFaTXFm?=
 =?utf-8?B?QlVSMXdtbnRqWHpCVUY1RkZpc0o2WDd0NUlpSUprWHhKaFRZVDk4b1BJSmpW?=
 =?utf-8?B?V0xmaFB3K1JVY3ZISnV3QVNDMmlTYURtS0VrT1FMaE5TQ3d0N1Ezb21FNk1P?=
 =?utf-8?B?TVRYdWNxVzJRTkdVZlBndlJEMHlzc2s1TGUxWWRHVC9GNHlkbDRTMDFqMENt?=
 =?utf-8?B?amc3aWUxZTJtM2FGekxtVnRPbGVBOXhDRXozQVpGQkRrR1lZRWdKS0grRnA2?=
 =?utf-8?B?aW8vaFZMMnI2M2F5SDFKYWkzWXpvOG5vdDRwNlNHTGRJUE1leGYxVDFNeWpT?=
 =?utf-8?B?MG14amhvNUxkSnpqMFlzMXdxUUhnZktJSmdBdjFSQTU5dko3dlprN2IvMEtR?=
 =?utf-8?B?NDZ4eGRIWG94aWZEN1pQUlJzYTROUW4rck1DcWYxQjhOSmc2ODkrWGdPcUlG?=
 =?utf-8?B?ZEQzMnNBZEpiM25taGh4K05LRkhnN25MNlVWdkJjc0R3VFhvM1lHUW1pNmVF?=
 =?utf-8?B?Y0t0YS9sdHJuK21RUEdDTnpDcGNSNjdmMU1lOUhLcTQ0bkRzYXdSWGV4K0Fx?=
 =?utf-8?B?ZW5leXY3bHQzL01yOC92V1ZkR2R5VEVRTHZ5eXVNenlIQlVNb1cwYmJ5cGp3?=
 =?utf-8?B?YnVaQWI1MWRwR0tEN1ByTW1qekE5WjBjWVNtMUtEaEllTUd2VldPRFl4OTZl?=
 =?utf-8?B?cXFpbnZFclViaG5EZWU4QlNFZjdJOFhrcEVLdmxaWUZ1ZFVVVXplNmRUMnFG?=
 =?utf-8?B?cHhvZG1nNTVlQVBlUTBLZGFybzR5T0F4WWR0ZU8yTjByOWpHVEpuK1VuM1pq?=
 =?utf-8?B?SlFjdE9qamViR0Nzc0tDdCt5YnZRPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5TM7SCkssjwLHQgJ8eCj49xdu/8GJBM2H7uyZHiYQVjzAojdu9l5KNYMzMxZffGahg2RljDLE09ECwgTkkZjGmJaDKaXepyQAAApV+qf5HUTZXgPX05wT4CLJH1b/2Gd8bMLMqJW+D0bqlKTPQnSfSD4WO6DjIrdT+YkcjRHC4efO4896TR/SjO8gcWjLUyHQy12AhOazhEeEQDnQnV9JUCdyCow0E9aPi+xc5nmdSy7unqBBInMEiKzJ9maHiTFyRpoAgTv4s62r+Z9vmVfViyC9N64HUF9FPP0cuWwnhFe6TBIHaQaFISBr3rpkx+ybRxH6nL3XVT0JE/jQtA9EMgm/QGvIUhApLCNC7ib3Jw0sWRkJ8fbWDm7OFFFP+lEDZMy4jpeTrppuFwTsNaqg3vmiPHXnAReJRV3e1/LS5T+4zWsfwXDoufLYlMuakR+SdtD+iwMoGTntUjGpCjqCTMxcJx8G7gT9aG5LwedQBZzDG+oxkmtjSlOnh9Rx6mvPZCezG6WKz8yBVstU5EJNXwN7lkTqaacqCAHgc4F3kOHRm8Im9KGErh4fwI0r0CcgxnW2L25xUb4Sd9+gY0poNajyNTHCQrwrbdh8C8spfc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2130acf-3f90-42b6-5a17-08dd78676fa5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 19:39:40.7975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hv77XmMz5sonH50O7FET7ksk5L1XSsMBxnQ3OnEdA2390bVmd22M+gcSDdARvJJoS8R3pS4FIgNbftNTPl2bJeAURCTD6z2XVF8pY5YX3qQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5067
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_06,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504100142
X-Proofpoint-GUID: uXrvhSS1PIrhNRx2Piz_E7f144G_0USJ
X-Proofpoint-ORIG-GUID: uXrvhSS1PIrhNRx2Piz_E7f144G_0USJ

Hi Jeff,

On 4/10/25 2:12 PM, Jeff Layton wrote:
> Since struct nfs4_pnfs_ds should not be shared between net namespaces,
> move from a global list of objects to a per-netns list and spinlock.
> 
> Tested-by: Sargun Dillon <sargun@sargun.me>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfs/client.c   |  4 ++++
>  fs/nfs/inode.c    |  3 +++
>  fs/nfs/netns.h    |  6 +++++-
>  fs/nfs/pnfs_nfs.c | 31 +++++++++++++++++--------------
>  4 files changed, 29 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> index 9500b46005b0148a5a9a7d464095ca944de06bb5..81c0f780ff82c8a020fafdb3df72552c8e6e535f 100644
> --- a/fs/nfs/client.c
> +++ b/fs/nfs/client.c
> @@ -1199,6 +1199,10 @@ void nfs_clients_init(struct net *net)
>  	INIT_LIST_HEAD(&nn->nfs_volume_list);
>  #if IS_ENABLED(CONFIG_NFS_V4)
>  	idr_init(&nn->cb_ident_idr);
> +#if IS_ENABLED(CONFIG_NFS_V4_1)
> +	INIT_LIST_HEAD(&nn->nfs4_data_server_cache);
> +	spin_lock_init(&nn->nfs4_data_server_lock);
> +#endif
>  #endif
>  	spin_lock_init(&nn->nfs_client_lock);
>  	nn->boot_time = ktime_get_real();
> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index 119e447758b994b34e55e7b28fd4f34fa089e2e1..ee796a726a1e4b0dfbd199cc62176c6802692671 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -2559,6 +2559,9 @@ static int nfs_net_init(struct net *net)
>  
>  static void nfs_net_exit(struct net *net)
>  {
> +	struct nfs_net *nn = net_generic(net, nfs_net_id);
> +
> +	WARN_ON_ONCE(!list_empty(&nn->nfs4_data_server_cache));

nfs4_data_server_cache is defined under an #if IS_ENABLED(CONFIG_NFS_V4_1) block,
so the compiler complains if this isn't enabled:

fs/nfs/inode.c:2564:32: error: no member named 'nfs4_data_server_cache' in 'struct nfs_net'
 2564 |         WARN_ON_ONCE(!list_empty(&nn->nfs4_data_server_cache));

Anna

>  	rpc_proc_unregister(net, "nfs");
>  	nfs_fs_proc_net_exit(net);
>  	nfs_clients_exit(net);
> diff --git a/fs/nfs/netns.h b/fs/nfs/netns.h
> index a68b21603ea9a867ba513e2a667b08fbc6d80dd8..557cf822002663b7957194610d103210b159e5c4 100644
> --- a/fs/nfs/netns.h
> +++ b/fs/nfs/netns.h
> @@ -31,7 +31,11 @@ struct nfs_net {
>  	unsigned short nfs_callback_tcpport;
>  	unsigned short nfs_callback_tcpport6;
>  	int cb_users[NFS4_MAX_MINOR_VERSION + 1];
> -#endif
> +#if IS_ENABLED(CONFIG_NFS_V4_1)
> +	struct list_head nfs4_data_server_cache;
> +	spinlock_t nfs4_data_server_lock;
> +#endif /* CONFIG_NFS_V4_1 */
> +#endif /* CONFIG_NFS_V4 */
>  	struct nfs_netns_client *nfs_client;
>  	spinlock_t nfs_client_lock;
>  	ktime_t boot_time;
> diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
> index 2ee20a0f0b36d3b38e35c4cad966b9d58fa822f4..91ef486f40b943a1dc55164e610378ef73781e55 100644
> --- a/fs/nfs/pnfs_nfs.c
> +++ b/fs/nfs/pnfs_nfs.c
> @@ -16,6 +16,7 @@
>  #include "nfs4session.h"
>  #include "internal.h"
>  #include "pnfs.h"
> +#include "netns.h"
>  
>  #define NFSDBG_FACILITY		NFSDBG_PNFS
>  
> @@ -504,14 +505,14 @@ EXPORT_SYMBOL_GPL(pnfs_generic_commit_pagelist);
>  /*
>   * Data server cache
>   *
> - * Data servers can be mapped to different device ids.
> - * nfs4_pnfs_ds reference counting
> + * Data servers can be mapped to different device ids, but should
> + * never be shared between net namespaces.
> + *
> + * nfs4_pnfs_ds reference counting:
>   *   - set to 1 on allocation
>   *   - incremented when a device id maps a data server already in the cache.
>   *   - decremented when deviceid is removed from the cache.
>   */
> -static DEFINE_SPINLOCK(nfs4_ds_cache_lock);
> -static LIST_HEAD(nfs4_data_server_cache);
>  
>  /* Debug routines */
>  static void
> @@ -604,12 +605,12 @@ _same_data_server_addrs_locked(const struct list_head *dsaddrs1,
>   * Lookup DS by addresses.  nfs4_ds_cache_lock is held
>   */
>  static struct nfs4_pnfs_ds *
> -_data_server_lookup_locked(const struct net *net, const struct list_head *dsaddrs)
> +_data_server_lookup_locked(const struct nfs_net *nn, const struct list_head *dsaddrs)
>  {
>  	struct nfs4_pnfs_ds *ds;
>  
> -	list_for_each_entry(ds, &nfs4_data_server_cache, ds_node)
> -		if (ds->ds_net == net && _same_data_server_addrs_locked(&ds->ds_addrs, dsaddrs))
> +	list_for_each_entry(ds, &nn->nfs4_data_server_cache, ds_node)
> +		if (_same_data_server_addrs_locked(&ds->ds_addrs, dsaddrs))
>  			return ds;
>  	return NULL;
>  }
> @@ -653,10 +654,11 @@ static void destroy_ds(struct nfs4_pnfs_ds *ds)
>  
>  void nfs4_pnfs_ds_put(struct nfs4_pnfs_ds *ds)
>  {
> -	if (refcount_dec_and_lock(&ds->ds_count,
> -				&nfs4_ds_cache_lock)) {
> +	struct nfs_net *nn = net_generic(ds->ds_net, nfs_net_id);
> +
> +	if (refcount_dec_and_lock(&ds->ds_count, &nn->nfs4_data_server_lock)) {
>  		list_del_init(&ds->ds_node);
> -		spin_unlock(&nfs4_ds_cache_lock);
> +		spin_unlock(&nn->nfs4_data_server_lock);
>  		destroy_ds(ds);
>  	}
>  }
> @@ -718,6 +720,7 @@ nfs4_pnfs_remotestr(struct list_head *dsaddrs, gfp_t gfp_flags)
>  struct nfs4_pnfs_ds *
>  nfs4_pnfs_ds_add(const struct net *net, struct list_head *dsaddrs, gfp_t gfp_flags)
>  {
> +	struct nfs_net *nn = net_generic(net, nfs_net_id);
>  	struct nfs4_pnfs_ds *tmp_ds, *ds = NULL;
>  	char *remotestr;
>  
> @@ -733,8 +736,8 @@ nfs4_pnfs_ds_add(const struct net *net, struct list_head *dsaddrs, gfp_t gfp_fla
>  	/* this is only used for debugging, so it's ok if its NULL */
>  	remotestr = nfs4_pnfs_remotestr(dsaddrs, gfp_flags);
>  
> -	spin_lock(&nfs4_ds_cache_lock);
> -	tmp_ds = _data_server_lookup_locked(net, dsaddrs);
> +	spin_lock(&nn->nfs4_data_server_lock);
> +	tmp_ds = _data_server_lookup_locked(nn, dsaddrs);
>  	if (tmp_ds == NULL) {
>  		INIT_LIST_HEAD(&ds->ds_addrs);
>  		list_splice_init(dsaddrs, &ds->ds_addrs);
> @@ -743,7 +746,7 @@ nfs4_pnfs_ds_add(const struct net *net, struct list_head *dsaddrs, gfp_t gfp_fla
>  		INIT_LIST_HEAD(&ds->ds_node);
>  		ds->ds_net = net;
>  		ds->ds_clp = NULL;
> -		list_add(&ds->ds_node, &nfs4_data_server_cache);
> +		list_add(&ds->ds_node, &nn->nfs4_data_server_cache);
>  		dprintk("%s add new data server %s\n", __func__,
>  			ds->ds_remotestr);
>  	} else {
> @@ -755,7 +758,7 @@ nfs4_pnfs_ds_add(const struct net *net, struct list_head *dsaddrs, gfp_t gfp_fla
>  			refcount_read(&tmp_ds->ds_count));
>  		ds = tmp_ds;
>  	}
> -	spin_unlock(&nfs4_ds_cache_lock);
> +	spin_unlock(&nn->nfs4_data_server_lock);
>  out:
>  	return ds;
>  }
> 


