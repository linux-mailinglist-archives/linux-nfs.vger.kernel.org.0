Return-Path: <linux-nfs+bounces-14724-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9667BA16AE
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Sep 2025 22:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04957627354
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Sep 2025 20:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A97320CCF;
	Thu, 25 Sep 2025 20:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e2MPGtG6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aeS+3aB4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49E2320CDF
	for <linux-nfs@vger.kernel.org>; Thu, 25 Sep 2025 20:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758833187; cv=fail; b=K9iQ6TQRYyzHm5NDd7x7LJBzlOkRmk4n5HEOQkII1Q/xUFQQoDZEoRI/IvqCkcAxux2Z8QEFcqkgpANMPgW6NknMie/1rNl88j95pPOuWcM7E0MsmD3BdNEfVB3q63D3DGRhgRs1OY2VyTkWFJk/kJnEUNCRwQNdfQuZyJoVOv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758833187; c=relaxed/simple;
	bh=3s5m/gPaomnWuXiaBUsJ1cvfkoS6QyaBZsWsb5HGegU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cD6A8Po40mwSTLnTzMVwJV7Sw7TXVSELMepBLbMp8WQl0bldDkoqRptd4v2HYA4EMTHqNWFxvUGxHjiw2eztZxDCt00rIJHLLUqrHByjWMZfFgCL+qKjFJN4QX1ZtYSWMD3qb//7jQz7gbijakzfKgd5OZO6gI1v6nHUnZNmlSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e2MPGtG6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aeS+3aB4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PKBsbj027207;
	Thu, 25 Sep 2025 20:46:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=AQI2N7aIXUNL8iZX/SgRKDGZD4cBVypdJ/f47mVkJ0Q=; b=
	e2MPGtG6A3MZYQwSHvx0OlQceHtZOgR4nSXJvJbaLHQZlOK0QDzCDkH1tqk8a3NM
	0i8GecgL1R5dyurH/O/mngHW0f2ae0vj4Ri+k20Oj7S70CZtdN198nyrM/UOUt/h
	O3B2zA3djMfhlZJdUYPFyldC6Zr8L/O2Z6mKd+NHBFY6f7yk3XuK5Mr/Uu2Ex+oA
	RD5H5JgMGuco6ivNz0kix6WI1PbJ3ybXrwGkR3OlnSJwKbzN28iWUJAN5tl1LYay
	Rc+yHnX+5pz02/LN//arBBzsSDR5kAaDJNvgSxZ7mJTF/r/YP10r1/n7VB/TcKA+
	SRxNfd8HZuz9UZUmzBE6Pg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49dc3783s1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 20:46:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58PKULMf002013;
	Thu, 25 Sep 2025 20:46:20 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012033.outbound.protection.outlook.com [52.101.53.33])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49dawjmqpj-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 20:46:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VPjI/Q8YrRq6YHheW0VOppu0hopzRNJ8n/Gup03Cu9t51WX10eFyY+fq/izhpu83dSNADalNsGidhdR0hooLeJqpitEwcQdZqM/yAdpjYHFyZgvcx2MnaGZ9zpFbDXnla51kFrxCtkhhOQX5ZvDsUm6r56XA5dovEwdxdSy6T/YWzgikPuy4sBWb29avWeMkMX1coDIfOr7LfHWRf71X2pNa0YucUXk/MWHZb4Ugi3U4iUifX43EYq6uW3JQG63bm/oJRn2sV3DC/Kz3lV2kpEn79PdLVbowxBI+6a+eQt5Me5bvC7yDzvd84nLcksCPTHmutCDcUBkIcG5+V1XgMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQI2N7aIXUNL8iZX/SgRKDGZD4cBVypdJ/f47mVkJ0Q=;
 b=pifzqQhMK8306OxW0zmYz1iXlFS58lAG1nM2AFhZMqTMJl/QgP4fBOy17Pi19N1ecM8Skt9CWDogXB6LfHbZG0gYNPCNnMAaAXvNDVPR7iNCMfuNE3qo7dLYf+6yrvw8VLtmThb1N/Hmz3JiFyVxQA+PVB4Oq78IBt9Ek4m7gMcEFmwfpgTftKjzA1PEwoiVwrq5YmgXcfF7ZDS3/RruAdRr3bBidrASMaAf9Te7j0poyDP+w1Ivs1IKgdSCOgfU2wuR0b9/O/WoDIlvUKoj9cnFq+0eX2pBo7qw3uP9OD39AlXV6vofj7UDPawvlTd+fpX/mLj5X0KvAbE3x0Nvgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQI2N7aIXUNL8iZX/SgRKDGZD4cBVypdJ/f47mVkJ0Q=;
 b=aeS+3aB4BGOzcXmH1xdJIGayC1TEjtNSv/wxyc9qgdV/e9LFIiLiJdBxtcpUOSavIHjk3kr4nQ3JstIU9rCv4Q0hTzzNUG31CpaD9c0XnZPPr9ArW7YeXyjwCAIThUbqhhTA/oSzMdRXP/8OZShf8IHMl5U2Z+8TF+LHkJquW1c=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by IA3PR10MB8465.namprd10.prod.outlook.com (2603:10b6:208:581::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Thu, 25 Sep
 2025 20:46:17 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::c86a:40f1:7833:ef3c]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::c86a:40f1:7833:ef3c%3]) with mapi id 15.20.9137.018; Thu, 25 Sep 2025
 20:46:17 +0000
Message-ID: <414c0a7b-e767-4061-acd6-bfe8dbff39a1@oracle.com>
Date: Thu, 25 Sep 2025 16:45:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/38] vfs, nfsd: implement directory delegations
To: Jeff Layton <jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
References: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0103.namprd03.prod.outlook.com
 (2603:10b6:610:cd::18) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|IA3PR10MB8465:EE_
X-MS-Office365-Filtering-Correlation-Id: 69a0a342-e7db-4bf5-81c0-08ddfc74931d
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?WDNHV09uVUkrTlpieWYrMDU2bHpZRUoraGRzbEQ0UmhIdFFRZ29ZTCtqcUZa?=
 =?utf-8?B?ZFVkNnlNWE1GT3YzbWkzYTNJTUFFb1NSd1gyT1UrMUZocnkrMEwvcUc3MVpD?=
 =?utf-8?B?bDZKRWVKb2hpbmxBU0R4b2FmZTgwNE1mQ3B0ajlQUU12T2ROOEx3Q0cwZWtX?=
 =?utf-8?B?Nmt5YVZGZWFRZzltQkRMbDdOLzI4Ly82anlZeTV1bG1nNXFhWWVpTVBFVit5?=
 =?utf-8?B?czlXRnlja00xbGlTdzVJYzQ0YjZjTXZ4VWM2Q2hhcmNKRXF3blV6VFNGbERk?=
 =?utf-8?B?WE9WQTkxeFlqa1dkaUp6TitheHRaTXNJS3dTbFNmRFk0OU9lRkhqWVAxNGFk?=
 =?utf-8?B?eXllRWoxZExEcTlPRnNmTnB6OWNIRHMyckxCYTBPSHBuZ0IyNHdXU3l3Ykpo?=
 =?utf-8?B?TlNKeVNRWVFoRVBpTjBsYWQ2Q0VnSGRTcnBqdnNLYkIxekJ4UVJneFpFN2RO?=
 =?utf-8?B?STloZHlPaVlrZTZKcHlCbXI5aGNXYWZ4OUh5SzZ5UjcveFBNd3huZzB1dmd1?=
 =?utf-8?B?cXh4Z0FsZG04QUpIL1R4cE9mSjcweFdPc3ZSN1JkSjNZaWg1MERwQTRES3lC?=
 =?utf-8?B?MFVsQ0NzaG1lbEE4VWdTVTNJMlhMckQzNXdqc1BBY3ZXVlVUejlEWWJzdjcy?=
 =?utf-8?B?ZU5LanZ0cFR0bWkzaVpoMk1uR09paTlxVXlidExraDN6TjlSVFI5TVQ2TWZX?=
 =?utf-8?B?UzZMdHFqTGtmMGFhYXp0dEhNaFZjQktXb3FPcGQ3OWk5ZmFZYUd1UjVLRlE5?=
 =?utf-8?B?ZDZyRW1xNjNKbkFVaVpLcE0zY05FT0lvODA4eUJvRXE1TmpVNTZpcGROSlE2?=
 =?utf-8?B?Z2thVzIrTlAwYWFadm1NenhJSXlwdUFtUFdVNldWUUlOM3NKV3daVUowNVBY?=
 =?utf-8?B?MWkvMGErVmdkT0NaZm1mdnErY1RuZ2NJM3pRMkNjYzI0aldQNlZObE53cWFx?=
 =?utf-8?B?WStXY2c3N09rNUc3REtBS1dkZE1aZFBWMUJyTUpFZ2VoMktXelpUYmNmQ3BP?=
 =?utf-8?B?ZFNHQldhZVg1WFVkU1BGNDRNVHkzVVNrWWFNellsRVpNVjhybzRWM3ZTaGdm?=
 =?utf-8?B?SS95cm0waGNtYzhVY2UwVDduM0MrODZhYlFySk9yRExQbU0xZG9QRmxnMFpy?=
 =?utf-8?B?ajlBcVpMMlJlN2NDdjZzaGo3SmVwWm13d2tmTGJRS2I4MVdLT0tjV2lORytD?=
 =?utf-8?B?b0VkNVczN2hJUk5La2JseHVmSTloZ0x5dXhmVjFoelF0Qzh6c0JtZzRDbXVv?=
 =?utf-8?B?ZW16cjF3MWlXWFE1SGxhNlZLc01rSzJ4Mk1jOE9YV0tEbTBFc3NOOGd2RXdq?=
 =?utf-8?B?NHppNkkwSDVsUzdiWHlVdXBQK2hZLzF0bE1rWXRudlc2S0pIZGk1UjRRNkht?=
 =?utf-8?B?ZzhCUDhvekcwaGdkaWc2RVJtZXhldXNjYmFsN216UUZqeXhnK1MvTDJtbVlY?=
 =?utf-8?B?ODlLOWVpdDR4Vm5rbGdVd1F4K3o0TXlkT1F4U2NFVkdVMWhQSGxnYnhVUlpX?=
 =?utf-8?B?UEVmeFJZNElSa1c1WEt2WkRCTXBTU0crTnFuK004emxBRlpmcWc4RDNSYzBx?=
 =?utf-8?B?b25jdTdZZStUNjE5OHNORE5DUnJBbUtkcEJNTmVtdmp5dXFpeVdKby9FbjhO?=
 =?utf-8?B?dW9rK2pPTmJjdE5uY3p2RWZWRGw4K3NTbG5aVTQ0OFV4clRwazkvZ3NZbUpE?=
 =?utf-8?B?SDFNYUFYNnBrRVRVZDhhOWs1U1owWU4xN29CVVA0b3UxbCtHaGVCaThEbHVi?=
 =?utf-8?B?VnI3V0NhYitZdmYxek14ZFdtT3N5STZSQVNJZE5nQzlDNXJFTzBBOXhpQmU3?=
 =?utf-8?B?OXZzVVNFTnl5OE90Rjc4S3FKTDFybEx6OWY2dFhkUk9qSW12OGVSRXRKWDMr?=
 =?utf-8?Q?g9iAENrIltq6k?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dUZQb1hGVUhlMkpXRmtWOUNaZ3dDUktVL1VLUW43NTRPWStJd1QrT2JZNFU2?=
 =?utf-8?B?UFdTNDRTK3RoMjZHRXM4SFVkVThVRFNla0U2d1lZcVhZWlZWUm42NjV3MnBY?=
 =?utf-8?B?T3lNLzdLUE5oeHZ3Tk11SEo0MWc2VzlqOFdoU2JmSTN6QVhXanhXTSt3dzVt?=
 =?utf-8?B?ZFVMOHZwaFlWeUFHVzRTUFpNeTI1VEpxeGxENHpHbnhjYTljSDRKNXEvaEtF?=
 =?utf-8?B?dm1URFZ4MUhLOHhRY2tJaXN0TlBueE8xcE1ETkcxWmJxdHFXU3pKRG5CNWFm?=
 =?utf-8?B?dTZKMnF1djU2UVNCTmYvU2xicXdiWDcybFN0VEVJN2JWY1FDbDd2S2xDeUNT?=
 =?utf-8?B?VEFJbzR4YzVMQWdtajNJZjk3bVloNDdjMGxlNlF4T2JweS9relZDd2NDcERt?=
 =?utf-8?B?NEF1T1RCN2l5ZXdTMWNTZytKOWJIVE5qaVlWWVhoZWQvUlY4Sy83ZUovZTM1?=
 =?utf-8?B?NHdBelc0d3AzY0NXeU9sbDVxeXZxSURLTkQzTDkyNitKenlGQWpNSzdMTXp0?=
 =?utf-8?B?d1lCbW13MUoyZUs3SHJoWUdBOHRpSDdWL3pieHNjUGV2eFNLVnZPcVZTYXB4?=
 =?utf-8?B?YTQ0ZGRNalFpQm41dk9YYkcrdkpYV2NrL3cwb0NvMVBlODFWY2s3cG9iTXNy?=
 =?utf-8?B?Uk4yV0Nrbktlc055RDhXOUxseHUyWXhmZllNc1JGQlh6MkQ4QTBTRXhYS0xv?=
 =?utf-8?B?a09Sd0xTNjh2bVVMcVdtN1JHdDNpYlZIV204THo1QUo4aDV2M3JzbWp1d3BF?=
 =?utf-8?B?YXJOWFB2dElPZHU4ZVlJYndWZ3c5ZUxYdWZTd1MxMFNQVmlkWTk1QkJMVy84?=
 =?utf-8?B?VExuckwrK3N1RlJ4eVMyYXNQQXNhK0hqODNhQXJjV0dHSVoxOUVnY3ZZaCtt?=
 =?utf-8?B?VUgyNmk3bTNyaVBsNHkzS1dZRzVzRFZUTXRoWVVvSEFWbUI1cHgzaXBydEtv?=
 =?utf-8?B?M2E1WHM2RGZnNjFuZHhid0N6SEo3RDJSa2wrYWhRV0pvSHo2dzgyWmhtR0Nn?=
 =?utf-8?B?S2xMOEt6VU1kV0VTQ2o3K2k5THBhUytjU2RVTjBSQUZlMFROKzJ4aUZwNlp4?=
 =?utf-8?B?ZUpESnMwTTZkaVJOa2hyQW00MUFNLy93NDZlUUVMVjVrQkVpZHpSSVo1aGdW?=
 =?utf-8?B?OXQvL3NHMDdMZWNKU0tCSmcvTmhXM2w0MitSTDJTUVFKTXhnZ29yNklOZGxN?=
 =?utf-8?B?Z0ZHanBBY2pPUXphZW9pOHBPa1BVaE4zZG5GMUQxWlZ3N0diQ0Jid1U4MmpJ?=
 =?utf-8?B?OTJXT3FnVWcxWGhhZzlxc0tLaEVlRXVuMW1ReVI3UXZZbW1PQmdteWVrb0sy?=
 =?utf-8?B?bzd4dWI2ZjNzcVB5ZmovbG5QbDQyQ2pKMWtUbHVWdXUzWE9pWllkakpIQUxk?=
 =?utf-8?B?SlFVcEsrNy9reTNpN3pNQTlmSTBvcWx2QTQ4and1czA0NmJzYm1mWWY0UGpC?=
 =?utf-8?B?YVYvY0V4bElMVVRhT3VoWXJYcFJ3b1FPZmRXdSt3SnBlZ1UxTmlNWFg0MWVz?=
 =?utf-8?B?ZUJGbjEyM1RINDlCZ2VuUHFFbzBtR1NBODA3NXN2MGhJSzlxaGJPQU5BSjMz?=
 =?utf-8?B?bnZLTDkvZjZsSGZtdHE3Z1BlczlhTjhlWHpBSVZiRXB0MllHN1RRMlBySWRi?=
 =?utf-8?B?cXVsQ3JxM3lPcG9ON3NPNFIvam95N3p0NWdxeFU2YkZ0S09sc0I2WGxxM2Zx?=
 =?utf-8?B?WXBBUWVXd0R5LzhKbnJpY2MrRGFHVzdESWJvU2U2c3JyeHBJU1pqTFlJZVlw?=
 =?utf-8?B?M084cFRGZHorSVB5cGpmNmdIQVllRDE5clVobXhkVFloK3VNanp3cldiYXRx?=
 =?utf-8?B?TXZMRjNrbUEyNVBLY3c5WmRWQjRRdVM1SXVXdWprdG5IQVhNZm1ESjI4Z29K?=
 =?utf-8?B?QTd1b1NrUlBuUlAyVTZFckVQTmVKN2ErczNrbHRnZHVBc0FFRTdXRUNIWXpX?=
 =?utf-8?B?bFlHT2U3cjFUeTBDLzJaeU9yU2s1dWVTZWIrd2tuTHczQTcxOEtFMHg1NDRs?=
 =?utf-8?B?RDFWaWYxVThQWENvUXJtVFlvWlFWNXAxRE1mVVppaTg3R2VrRGZqUVMrQ3Mr?=
 =?utf-8?B?bncrc09MVTJnRTZlVEJpUURzaFBBMmhla3c1R3FRZlFvckdrKzREejBacUpO?=
 =?utf-8?B?aWFMbUkydUpVcHg4bTFHMHZZaGRHYi9ncktaQmRpU2JzdUxPaW43TjNnV3dF?=
 =?utf-8?B?K3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PZrdfKCn8QZ/YxHnLfj9aH61IiL7DtdfDkX6qVAmS88V0T4H/FSBcd0+SQIm/B5N4Eyj/QnsDIQX0uJ1EJ3aMzt72W1W3YfGGwkJnIPtjv9QYXOCS/Ox4bYfp9qM9puu5Ux4Sbwp6XtOAIrytjEnjpKItDkS1wpjc7Mgq+lMsIsAlSyL0cEDAzPaX0wQtcb9uMKhUyFeqqI9dHkziCyJH0dfjPjgAuDYA9GeL1/Ei6IHh6Yx45ju/uq6oM8vzIrJb51gMG+y58nbBkBcI6OOQBKSW7hiod/iLgdwUXE8hTNdq7CRufTTkHTH2UUF2jDjpLVjFIzQ70PjHAp96QEGcM+jQ4OoJfz8yGVC04X95HrFWFl0GzqzJ+dhQ0YSS3dAGCgBEpFXfMZNPLsFLu9oqxmD5xDfZqmgrs2KbT8YCgMPyP3l+m9+DS7uu9z6hXJnTAOFoGXeB61L4Zm2J4r/zUyf8iPNwAz0nHfUke5pluxbuLHEF3ST6NvVs9QOsp5sVwyoP9Jj+4J17+3gzGmyXNqdvwY3TWPBVzsYXItK/uC2BsiMbWRT/cq4SasqnmtiPQGiul8NTTILimimGraa16SJhiAa6mXDWPjAdbggLRk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a0a342-e7db-4bf5-81c0-08ddfc74931d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 20:46:17.2828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qAeS8cVSAT2WzOp8uP+sxjs0DUIXD5gOsd0RzvWe2hx1gUr6EtRAKrdHqe7ZGdeE+DIWh5ABrMAUCA+OXulSVGA9FVQT4+SdUyhJ89LPQXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8465
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2509150000
 definitions=main-2509250191
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE4MSBTYWx0ZWRfXx76AAwdJA4gn
 5jf3Ik4sQ9QbtO6944aiCAPQ/F6NtL29Fm2/hZLTocrAC4PMJmloal+fdXnDmyioLlRanKTZ7qP
 PKxcEibxkdK65TrTGJhziAlZvxnyogNs/YlR/pTpbgwb2q2azKVe/1wyBJY3JYHreL6KjuWIMKt
 wmRCD3OqlXI3YNW36kzd0EztHLKaMtACOtAvi6a0tI095865v6TLMwWc2qrtED8RCSqacpRSFMv
 TWQ58+OB2or7xuIf16wQfZCHbDccVh7+JsC2W1/ecdRQA2m/ccJLXZrFfPiLOAl8JeLfTn5w9ot
 D7QwU+jCTKVsiKqe9kOyLE8n6wCy6fz42wt9yNsqt63x6mJvDMeiwXouRhFKUOMjQYov1ew6/gn
 6CjT6+BZMxQbYdhaR72lWPGMc6LEDA==
X-Authority-Analysis: v=2.4 cv=SJxPlevH c=1 sm=1 tr=0 ts=68d5aa1d b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=vnREMb7VAAAA:8
 a=P6JkxrBpAAAA:8 a=pz11dsrF-5yHfsuGdzQA:9 a=QEXdDO2ut3YA:10
 a=dwOG0T2NmQ8MtARghG3a:22
X-Proofpoint-GUID: 0HdKnQLE_nu-uda0K_1ePXDEtblf2dfx
X-Proofpoint-ORIG-GUID: 0HdKnQLE_nu-uda0K_1ePXDEtblf2dfx

Hi Jeff,

(I trimmed off most of the extra people CC-ed, since this appears to mostly be an
NFS issue)

I hit this crash while stepping through my client side code and fixing it up against
your latest branch. I'm at a point where the client only requests the delegation, but
without any requested notifications, if that helps:


[  643.888646] BUG: kernel NULL pointer dereference, address: 0000000000000168
[  643.889045] #PF: supervisor read access in kernel mode
[  643.889314] #PF: error_code(0x0000) - not-present page
[  643.889591] PGD 0 P4D 0 
[  643.889733] Oops: Oops: 0000 [#1] SMP NOPTI
[  643.889960] CPU: 3 UID: 0 PID: 1003 Comm: nfsd Not tainted 6.17.0-rc7-00095-gf6fa32f97c33 #47188 PREEMPT(full)  b859994234adae648e07409684697d13c51d22ee
[  643.890665] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 02/02/2022
[  643.891076] RIP: 0010:nfsd_handle_dir_event+0x49/0x2c0 [nfsd]
[  643.891490] Code: 24 04 83 f9 01 74 11 83 f9 04 74 19 83 f9 02 75 11 4d 8b 64 24 08 eb 0d 49 8b 04 24 4c 8b 60 08 eb 03 45 31 e4 0f 1f 44 00 00 <4c> 8b b6 68 01 00 00 4d 85 f6 0f 84 dc 01 00 00 49 8d 5e 28 49 8b
[  643.892432] RSP: 0018:ffffd0d202333a80 EFLAGS: 00010246
[  643.892711] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000004
[  643.893076] RDX: ffff8e3b55ad4480 RSI: 0000000000000000 RDI: 0000000040000004
[  643.893441] RBP: 0000000040000004 R08: 0000000000000000 R09: 0000000000000000
[  643.893816] R10: fffffffffffffffb R11: ffffffffc0a80500 R12: ffff8e3b55ad4480
[  643.894183] R13: 0000000000000000 R14: 0000000000000004 R15: 0000000000000004
[  643.894554] FS:  0000000000000000(0000) GS:ffff8e3f10206000(0000) knlGS:0000000000000000
[  643.894961] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  643.895258] CR2: 0000000000000168 CR3: 0000000112571002 CR4: 0000000000772ef0
[  643.895644] PKRU: 55555554
[  643.895792] Call Trace:
[  643.895931]  <TASK>
[  643.896050]  fsnotify+0x69a/0x9a0
[  643.896233]  fsnotify_change+0xad/0xc0
[  643.896431]  notify_change+0x34f/0x380
[  643.896633]  nfsd_setattr+0x314/0x6f0 [nfsd 0b3fc8b3981bb65e36d518f9edccb6d9f216a09a]
[  643.897073]  ? nfsd_setuser_and_check_port+0xdd/0x120 [nfsd 0b3fc8b3981bb65e36d518f9edccb6d9f216a09a]
[  643.897576]  nfsd4_setattr+0x254/0x370 [nfsd 0b3fc8b3981bb65e36d518f9edccb6d9f216a09a]
[  643.898014]  ? nfsd4_encode_operation+0x207/0x2b0 [nfsd 0b3fc8b3981bb65e36d518f9edccb6d9f216a09a]
[  643.898502]  nfsd4_proc_compound+0x337/0x600 [nfsd 0b3fc8b3981bb65e36d518f9edccb6d9f216a09a]
[  643.898964]  nfsd_dispatch+0xc1/0x210 [nfsd 0b3fc8b3981bb65e36d518f9edccb6d9f216a09a]
[  643.899390]  svc_process_common+0x567/0x6a0 [sunrpc c8ffd8e151f2f4e7c45ca22edc099dc57603df52]
[  643.899881]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd 0b3fc8b3981bb65e36d518f9edccb6d9f216a09a]
[  643.900341]  svc_process+0x117/0x200 [sunrpc c8ffd8e151f2f4e7c45ca22edc099dc57603df52]
[  643.900790]  svc_recv+0xa7d/0xbc0 [sunrpc c8ffd8e151f2f4e7c45ca22edc099dc57603df52]
[  643.901208]  nfsd+0xb6/0xf0 [nfsd 0b3fc8b3981bb65e36d518f9edccb6d9f216a09a]
[  643.901598]  ? __pfx_nfsd+0x10/0x10 [nfsd 0b3fc8b3981bb65e36d518f9edccb6d9f216a09a]
[  643.902024]  kthread+0x215/0x250
[  643.902201]  ? __pfx_kthread+0x10/0x10
[  643.902394]  ret_from_fork+0x106/0x1d0
[  643.902606]  ? __pfx_kthread+0x10/0x10
[  643.902800]  ret_from_fork_asm+0x1a/0x30
[  643.903013]  </TASK>
[  643.903133] Modules linked in: rpcsec_gss_krb5 rpcrdma rdma_cm ib_cm iw_cm ib_core cfg80211 rfkill 8021q mrp garp stp llc ext4 mbcache crc16 jbd2 vfat fat intel_rapl_msr intel_rapl_common intel_uncore_frequency_common intel_pmc_core intel_pmc_ssram_telemetry pmt_telemetry snd_hda_codec_generic pmt_discovery pmt_class intel_vsec snd_hda_intel snd_intel_dspcfg kvm_intel snd_hda_codec snd_hwdep kvm snd_hda_core irqbypass snd_pcm polyval_clmulni iTCO_wdt ghash_clmulni_intel intel_pmc_bxt iTCO_vendor_support aesni_intel snd_timer psmouse rapl i2c_i801 pcspkr snd lpc_ich i2c_smbus soundcore joydev mousedev mac_hid btrfs raid6_pq xor nfsd nfs_acl lockd grace nfs_localio auth_rpcgss usbip_host usbip_core dm_mod loop sunrpc nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock vmw_vmci qemu_fw_cfg xfs serio_raw virtio_gpu virtio_dma_buf virtio_rng virtio_scsi virtio_balloon virtio_net intel_agp net_failover failover intel_gtt
[  643.909087] CR2: 0000000000000168
[  643.909503] ---[ end trace 0000000000000000 ]---


Any guesses for what could be causing this?
Anna


On 9/24/25 2:05 PM, Jeff Layton wrote:
> This patchset is an update to a patchset that I posted in early June
> this year [1]. This version should be basically feature-complete, with a
> few caveats.
> 
> NFSv4.1 adds a GET_DIR_DELEGATION operation, to allow clients
> to request a delegation on a directory. If the client holds a directory
> delegation, then it knows that nothing will change the dentries in it
> until it has been recalled (modulo the case where the client requests
> notifications of directory changes).
> 
> In 2023, Rick Macklem gave a talk at the NFS Bakeathon on his
> implementation of directory delegations for FreeBSD [2], and showed that
> it can greatly improve LOOKUP-heavy workloads. There is also some
> earlier work by CITI [3] that showed similar results. The SMB protocol
> also has a similar sort of construct, and they have also seen large
> performance improvements on certain workloads.
> 
> This version also starts with support for trivial directory delegations
> that support no notifications.  From there it adds VFS support for
> ignoring certain break_lease() events in directories. It then adds
> support for basic CB_NOTIFY calls (with names only). Next, support for
> sending attributes in the notifications is added.
> 
> I think that this version should be getting close to merge ready. Anna
> has graciously agreed to work on the client-side pieces for this. I've
> mostly been testing using pynfs tests (which I will submit soon).
> 
> The main limitation at this point is that callback requests are
> currently limited to a single page, so we can't send very many in a
> single CB_NOTIFY call. This will make it easy to "get into the weeds" if
> you're changing a directory quickly. The server will just recall the
> delegation in that case, so it's harmless even though it's not ideal.
> 
> If this approach looks acceptable I'll see if we can increase that
> limitation (it seems doable).
> 
> If anyone wishes to try this out, it's in the "dir-deleg" branch in my
> tree at kernel.org [4].
> 
> [1]: https://lore.kernel.org/linux-nfs/20250602-dir-deleg-v2-0-a7919700de86@kernel.org/
> [2]: https://www.youtube.com/watch?v=DdFyH3BN5pI
> [3]: https://linux-nfs.org/wiki/index.php/CITI_Experience_with_Directory_Delegations
> [4]: https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Changes in v3:
> - Rework to do minimal work in fsnotify callbacks
> - Add support for sending attributes in CB_NOTIFY calls
> - Add support for dir attr change notifications
> - Link to v2: https://lore.kernel.org/r/20250602-dir-deleg-v2-0-a7919700de86@kernel.org
> 
> Changes in v2:
> - add support for ignoring certain break_lease() events
> - basic support for CB_NOTIFY
> - Link to v1: https://lore.kernel.org/r/20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org
> 
> ---
> Jeff Layton (38):
>       filelock: push the S_ISREG check down to ->setlease handlers
>       filelock: add a lm_may_setlease lease_manager callback
>       vfs: add try_break_deleg calls for parents to vfs_{link,rename,unlink}
>       vfs: allow mkdir to wait for delegation break on parent
>       vfs: allow rmdir to wait for delegation break on parent
>       vfs: break parent dir delegations in open(..., O_CREAT) codepath
>       vfs: make vfs_create break delegations on parent directory
>       vfs: make vfs_mknod break delegations on parent directory
>       filelock: lift the ban on directory leases in generic_setlease
>       nfsd: allow filecache to hold S_IFDIR files
>       nfsd: allow DELEGRETURN on directories
>       nfsd: check for delegation conflicts vs. the same client
>       nfsd: wire up GET_DIR_DELEGATION handling
>       filelock: rework the __break_lease API to use flags
>       filelock: add struct delegated_inode
>       filelock: add support for ignoring deleg breaks for dir change events
>       filelock: add a tracepoint to start of break_lease()
>       filelock: add an inode_lease_ignore_mask helper
>       nfsd: add protocol support for CB_NOTIFY
>       nfs_common: add new NOTIFY4_* flags proposed in RFC8881bis
>       nfsd: allow nfsd to get a dir lease with an ignore mask
>       vfs: add fsnotify_modify_mark_mask()
>       nfsd: update the fsnotify mark when setting or removing a dir delegation
>       nfsd: make nfsd4_callback_ops->prepare operation bool return
>       nfsd: add callback encoding and decoding linkages for CB_NOTIFY
>       nfsd: add data structures for handling CB_NOTIFY to directory delegation
>       nfsd: add notification handlers for dir events
>       nfsd: add tracepoint to dir_event handler
>       nfsd: apply the notify mask to the delegation when requested
>       nfsd: add helper to marshal a fattr4 from completed args
>       nfsd: allow nfsd4_encode_fattr4_change() to work with no export
>       nfsd: send basic file attributes in CB_NOTIFY
>       nfsd: allow encoding a filehandle into fattr4 without a svc_fh
>       nfsd: add a fi_connectable flag to struct nfs4_file
>       nfsd: add the filehandle to returned attributes in CB_NOTIFY
>       nfsd: properly track requested child attributes
>       nfsd: track requested dir attributes
>       nfsd: add support to CB_NOTIFY for dir attribute changes
> 
>  Documentation/sunrpc/xdr/nfs4_1.x    | 267 +++++++++++++++++-
>  drivers/base/devtmpfs.c              |   2 +-
>  fs/attr.c                            |   4 +-
>  fs/cachefiles/namei.c                |   2 +-
>  fs/ecryptfs/inode.c                  |   2 +-
>  fs/fuse/dir.c                        |   1 +
>  fs/init.c                            |   2 +-
>  fs/locks.c                           | 122 ++++++--
>  fs/namei.c                           | 253 +++++++++++------
>  fs/nfs/nfs4file.c                    |   2 +
>  fs/nfsd/filecache.c                  | 101 +++++--
>  fs/nfsd/filecache.h                  |   2 +
>  fs/nfsd/nfs4callback.c               |  60 +++-
>  fs/nfsd/nfs4layouts.c                |   3 +-
>  fs/nfsd/nfs4proc.c                   |  36 ++-
>  fs/nfsd/nfs4recover.c                |   2 +-
>  fs/nfsd/nfs4state.c                  | 531 +++++++++++++++++++++++++++++++++--
>  fs/nfsd/nfs4xdr.c                    | 298 +++++++++++++++++---
>  fs/nfsd/nfs4xdr_gen.c                | 506 ++++++++++++++++++++++++++++++++-
>  fs/nfsd/nfs4xdr_gen.h                |  20 +-
>  fs/nfsd/state.h                      |  73 ++++-
>  fs/nfsd/trace.h                      |  21 ++
>  fs/nfsd/vfs.c                        |   7 +-
>  fs/nfsd/vfs.h                        |   2 +-
>  fs/nfsd/xdr4.h                       |   3 +
>  fs/nfsd/xdr4cb.h                     |  12 +
>  fs/notify/mark.c                     |  29 ++
>  fs/open.c                            |   8 +-
>  fs/overlayfs/overlayfs.h             |   2 +-
>  fs/posix_acl.c                       |  12 +-
>  fs/smb/client/cifsfs.c               |   3 +
>  fs/smb/server/vfs.c                  |   2 +-
>  fs/utimes.c                          |   4 +-
>  fs/xattr.c                           |  16 +-
>  fs/xfs/scrub/orphanage.c             |   2 +-
>  include/linux/filelock.h             | 143 +++++++---
>  include/linux/fs.h                   |  11 +-
>  include/linux/fsnotify_backend.h     |   1 +
>  include/linux/nfs4.h                 | 127 ---------
>  include/linux/sunrpc/xdrgen/nfs4_1.h | 304 +++++++++++++++++++-
>  include/linux/xattr.h                |   4 +-
>  include/trace/events/filelock.h      |  38 ++-
>  include/uapi/linux/nfs4.h            |   2 -
>  43 files changed, 2636 insertions(+), 406 deletions(-)
> ---
> base-commit: 36c204d169319562eed170f266c58460d5dad635
> change-id: 20240215-dir-deleg-e212210ba9d4
> 
> Best regards,


