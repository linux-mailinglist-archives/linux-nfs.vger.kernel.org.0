Return-Path: <linux-nfs+bounces-7719-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0079BEFF5
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Nov 2024 15:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2238281E28
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Nov 2024 14:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E99D1DFE38;
	Wed,  6 Nov 2024 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JeU2GCIq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GynSUGfX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009B3502B1
	for <linux-nfs@vger.kernel.org>; Wed,  6 Nov 2024 14:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730902727; cv=fail; b=XfqEy4OuDq8Nlevp13E3nUGrK/sY5rXTC9mkNALhviFyFDYFoJxtqga0UE/vjH1B2vVugemCK4JrTLObcEW6NoX4QFj0SP0oYMXW+JAq2eCuKZKmtu08YmgvgDXApOstqwQWESmKL2g+LY3g2ugt2abvXUhx4dKZnOOfWtcwkXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730902727; c=relaxed/simple;
	bh=y9XgIMPCDTuGPh0Tj9N1OaxLKhNfvp7Ue85p/ewHAvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fZkE+UloRFZxxOVS9o4wMatJdesc7XOrrt4DducOT2/KnryvvKyd8Ohf6T/R37Yt17a4XQopCaLACdrLASL+tc+FXyw0eP9pt93mdfz2tUDx1LvHx7xkhUGupXk2OAackTmiZLBIJO7HmGq3SBMAyGMbK1O4jhjjJelsG/p/nzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JeU2GCIq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GynSUGfX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6CiJlP008165;
	Wed, 6 Nov 2024 14:18:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/RX7t9iLzaOB37NAuXH20gRj4ytLokd55mgYUlDnt6Q=; b=
	JeU2GCIqHFmW/nBPUIhO5xtDOTHLkUNGwE2rDL8XYjPKH9P/7ftw0fRmxMDpXBbe
	U+j8Ti4bq1a3upUlyHmyLI3aG7llW429ulB45QYFeyWG96+nXTSX8gtVCJfXjIBu
	aMqNUAgqCz+DzvTcLMrw/lGmHqOoMTrNeaLFXf+EQbCTFxwoJXPyucctANpNAEFi
	OON//jKQGa+KE81u9xYUyv+nWJAL8J2BbhWfYrjF8Fos64nNNQyFbznECtP24mDl
	jf51SAf3hsAG2z28WEUWnPfB94XCnh2Btilt0eumAdw4qNyW/ShlmOmMDUbZuOSp
	3HCqhJxxrh2N6r2r/nHY2g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nc4c00vq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 14:18:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6CZnvE005034;
	Wed, 6 Nov 2024 14:18:29 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42p87c0080-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 14:18:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UM0g4Ti/31VaozFgg9R8szlJ2ts6KZdCNl5eC1gdVCXZOcjCGYf+7HY/a3HApKeFBoUDJUp2uBe/QO00C2aCCquL6unTiAeddaOnqus9FqvjzUpfI2k6JTwWBtJbxSmp1QqEQ6ZmaZeG3VZ0G0svZtDUniu8y1a6jjKmRyn3PeFdnlrqD4+XKPGKJ+7DrlvrZCMdOnuoPsKkmum01KP5mo2LVE7S8lZWLPBbj+ppuClNHBSKozDthqgoIoEsbIhMw5arxWpqlYIEA+GzrmLXwRT1sn7DHQsJbXE6KsTUZXxOvFnPBTNA8sebtH3wKIYKHJ3JSGbUiT/8S5Hufxb9Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/RX7t9iLzaOB37NAuXH20gRj4ytLokd55mgYUlDnt6Q=;
 b=C0dWEn9MP9TxIaIwDqxSpz1hFpBUAaOBDdcsxxbyHuFTh4C7iH1UwNEgCsCx0FH7zRNfZxtwk2vv+W2ng34tqxYUAmP4qgWTQTpgo4dk7pvY0VnmZrcGPeo+Sthrqc2XMwWRofNAMMKNn6i5j94bV4UArW/1TS8lmiFRPCZcvWu8qPLcsc+KspaKJsghbrrmhUL0tb4Ty18zas0BRmPeTDAOCMZMLqT0tK8wioyYtW8WZYyJ9PHI5lUZzlnWG1X7RsnxywyHDreWXVlY10XsmDzfjjsM2oSztdKCR/VPHwfdyqqcPRlKLYzNW8mGlQj2LWmtbqd7YltZuX2TXk14eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RX7t9iLzaOB37NAuXH20gRj4ytLokd55mgYUlDnt6Q=;
 b=GynSUGfXlirK30Ed9SDaNQTx6QaSo8hBPnHO2KydANBRl0Gc/TXHbVCx1rWFp4kTne00Q0wc4NsYp3WfnNkXL0IVj66tRmGb9MjnJsVzXEoByoHxxNTjp0/mD4f6PTSrxQdYYA54kA+V/tuRvUpVS0c/g2cnXQhV9BZ6qMyJM+k=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6312.namprd10.prod.outlook.com (2603:10b6:510:1b3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Wed, 6 Nov
 2024 14:18:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8114.031; Wed, 6 Nov 2024
 14:18:08 +0000
Date: Wed, 6 Nov 2024 09:18:05 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Olga Kornievskaia <aglo@umich.edu>, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: fallback to sync COPY if async not possible
Message-ID: <Zyt6nUuwH+0cj6Df@tissot.1015granger.net>
References: <>
 <CAN-5tyF+FbsxSDEb79FQucM7fRDqw1wa7iegx9t=RvSLgr2nHQ@mail.gmail.com>
 <173086745413.1734440.10027857057542708378@noble.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <173086745413.1734440.10027857057542708378@noble.neil.brown.name>
X-ClientProxiedBy: CH2PR17CA0014.namprd17.prod.outlook.com
 (2603:10b6:610:53::24) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB6312:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a6302e8-ae37-4d82-7f1f-08dcfe6dd696
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZjNRdUV6YkxFUmV6Z2xLbm0vRFNXRzJEN0pSSCsyK0ZmTFVaaXh4eDJndWVL?=
 =?utf-8?B?bnVaaWJRbHoyYXRDNHpDZXlDZ3RjMkY3Z2VnaXNGVllXVVhtWG1DbmptZ1pm?=
 =?utf-8?B?K1BUQzJ6eTB6cUwvT1l2OFlSYVpsVEluNEhMcUFJaFFwZm5zc1d3aU11ald4?=
 =?utf-8?B?ejB3V0xDZ1VNd3c5YXVXV0xicTFOckkzVXJqeXFuaTlhYVRsZUkraDZhc0xo?=
 =?utf-8?B?TU5keFhxaWQzL1FWcXN6MFdqSnpvMDQrdXZuc1RUVFdqT2hmVzRQckxuM285?=
 =?utf-8?B?ZVljWFVKajVLUGxVREh5WUtUMnZXbHYzYlBGazVkSk9rUy9EM1NRRVlLRUdF?=
 =?utf-8?B?VEl2ajk0MDFOcEMrREc3M1pLWDR4em51RUUzeWxWUjdxZVhnNG9GQmNvMCtj?=
 =?utf-8?B?OXFkUG5WNHpjK0dPaFRkcTZUZXc3cFJpTHJKTys1ZWh6eS9FWFAvQTZSZzVk?=
 =?utf-8?B?dUtGVUM1djdTOVYzWE4ydnFyZDRTMGcwQjV3YUQ2WitmTjd3Tk9zRjRZck04?=
 =?utf-8?B?Z2t5NUtuTXhKeVg4OCtjcURXSXoyUWVPSWV5Wm5XWkppMDhJMWg5b3hZUzR4?=
 =?utf-8?B?ZkFuTXZoVzA4VnUrSktaandiSUNZWnpzNHR4TlI5TkV3cUpCakJTUmZ4OEFZ?=
 =?utf-8?B?d3pjS0ZiTVJSQmYrdS9XVTNhMkVLK002blEzUThYYTVYZDZJNWtjc0xFK0p1?=
 =?utf-8?B?NDJWZDVUbTVUYUg5OHJWUDRybWNZT20zYU5Ec0tNVU4vczc5SVlvd2RKQXl3?=
 =?utf-8?B?VnBSRmhCc0ZuS3BGV2lMQ2V0dUo5NnhQa0NXOTBHakxOWUNGZ1JTS1lTTUJm?=
 =?utf-8?B?V0hMQ2I2ZWdrQzNLbVMxaFRrWk1kVzU0WXBlWlhPQ1FQdkpMQkFUcmpCalB0?=
 =?utf-8?B?UWFxZ1RrYWtkNk5BeWNwa3JXWEpWdUg3cEVYWldLeGlDQ0k4Z2xNTUY4NUFU?=
 =?utf-8?B?VXNEZUt5bWxSQksrM2IxNUFzd3A2STJ4V1FkbElKRkV6OGdTbks4UmgxYUJt?=
 =?utf-8?B?QisybmVWUXNsOEJQaEtaOXhKcG03Q1VGNXNHMUw0MWRBM3lhWlNNbDNLRWRP?=
 =?utf-8?B?S1FsS2phTlJ4YWdoZlpsYXpnOFF1T052QkNOdlFseTVLVkJiYjEwd0FiUGsz?=
 =?utf-8?B?M2VwVFRVZk5iUXNTRHFEQzc0WWtzSXhRTkp3RVFFSmQzbUxDbkp1czZiZTZE?=
 =?utf-8?B?VFJQSGZGbDdhdTRKbGg4dmVPL2czeXdzQjRqMk9vR0VJemlIbTcvY0xSNldH?=
 =?utf-8?B?eGxZT0FvQXMvQkpJV2JkTWI0dGFkZXA1ZHYrdElwdHFPQzRNZTcvZ0lIdzVE?=
 =?utf-8?B?TVFoQTFuS2ViZ1NIRTEzTXp4ZEtCdHpkWE84dXlKeU1JYms3d05rVkgyYTlj?=
 =?utf-8?B?OUh5MGhKa0tvMENqZ29SZkpVTkI4UGFLM0Q3R0U1NGxPbUdINGFiTHZFRm92?=
 =?utf-8?B?and2dlVvUnRWQjRYVDVhd2hNVndmZFhLQ1hXMkk1Y3FXRCtPMWJOVEM5QUFF?=
 =?utf-8?B?aXJYVmdMVFB0RlRWdzhRU2FTNWQxVURsQkd1Wjd4UXpjbDdPajJBREhqcTRl?=
 =?utf-8?B?cS9ZMi83bmw4cUplNmNuZGpQRUphcTgxVm1rZThPc0V0QXdFMHZwWGpvMFlk?=
 =?utf-8?B?b1BxcDFSYkpCOXh1UVJOSEZkbVV2dEpob0RTbFFCVWdvaTBER2Z0bFIya3BT?=
 =?utf-8?B?eCtJYkNlN2RoN2hVUlVRclFnWHNJNmJDTWJhbEpIZ1BFa2lOZHhETFNaRkhF?=
 =?utf-8?Q?5RjtLtSm9rwnoE4SDRyj7YkHe54jsnMg4gvbA21?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RytYdXBVY0xRUUVTSEFGaWM1M2tiRXRQUVhuMmUyK2g0cVFEZDNobUtUMDAw?=
 =?utf-8?B?ZTJqSUpwUDYzR2k0WTFCVWhBMFduUHVRdkVTUW9wWmVzSXBjMUYxNUlwV3pi?=
 =?utf-8?B?V2U4ZHFWRVZ1d0VKbEJYejhwbWZhWFFBeU9nMW1mWGR6VHJHY0paM3FvcjZU?=
 =?utf-8?B?dC9nQTE0c2kxcEJnS1QxdG9QeFk4YktsL204bWh3Zjg3WlJ1TzVKUmFFa0kw?=
 =?utf-8?B?SnRheEwxTVQ3VnR5QlF5YnpHTTE1UGdFLy83VGN4NGUrTGVwK04yWHExV0kw?=
 =?utf-8?B?d1A4MDRBREtKdXJBZjloQWcvR29kTXZkaTJUUGt4clgzdTh5WWVwN1F1V1Ru?=
 =?utf-8?B?eTZYSHBLR3RkanhndkVnYXZoM2NISitXTC9qdkVKMGl1Y1Q0YWFKK3prTU5W?=
 =?utf-8?B?ZzVwQUZuQTlLRWxuNzE5NVpaSzJ1cXBTVEhHZStncUREVXJjM0RWWENpMGpi?=
 =?utf-8?B?V0J0WGlnZW9xVGRzS0JrZ1hoMHVaVmRZWDZWdVJsUHNvZ3FiOUtYcjBhVk5j?=
 =?utf-8?B?NHQzR0svTWFVOTNSYmprM29iRVVHaHNEVjVpc1RvYkp5dnNtMjFKT2pqK2FF?=
 =?utf-8?B?bjU3dmdEZDNRaUtPL2VQL2V0NmRVK0hhNThBMFFFRDlYZUVDVlFDdzIxNFh4?=
 =?utf-8?B?a21LcFVZNjdMMnN2RER3Wk5HMGpqYlFEYmN5MkR1VmJaVEVwbUVzSWFHcUsx?=
 =?utf-8?B?ZUcrTHEzSm5TczZLbFZSSFdGZStxaEVZRzBFOVFRTXU4WGtYTDRobGZ0Q3Vq?=
 =?utf-8?B?WUY5b3B6TmJBMXFoK1FkMStNMzJQaWdRWE1hSjQ4TVNqeURCcmZJeWFpVVcv?=
 =?utf-8?B?QkFOSDYvSUo5SHQ1bTQ3UlJldWlpUmc0TG1HdWcyY2E5WGhNcldwL1RPODVU?=
 =?utf-8?B?QXp6MmhIclhCUUpyb1hqKzZDWU9FTm9BNXdRcXFkVUlXV21RSHJRb2xlZlVV?=
 =?utf-8?B?QTVMWk03dXRTbzZMRDd4eWNyVm41dW40NUpVUnBWTUZUTnJOek5lV2xlVGEz?=
 =?utf-8?B?Z1Rnc1F6SEoxekFaVCs4N2ozQTFpL2RpSERFMFBtUUM4TlU5a0k4RkFNdSt0?=
 =?utf-8?B?RTlPTlFFbFg1VFhEMkdWSEU3aEY0KzlOa3RmeFpsT0pteEx2c093VTBhZ2ZM?=
 =?utf-8?B?WmlWN2NIa0FkaUZiZk1QVEUwL28xREhTMUt2bjAwbGxCZmhidk9kM1gxVHVQ?=
 =?utf-8?B?cFR6S250SDQvVDREQlpha2FvRHY2VW1DNk9vQVN5SGIzN3Z3Z1REZDI0ZmVx?=
 =?utf-8?B?bmtld3RwTVlnZUtycXRtdGlDR2JvVVp6NWE4RGFFcVZpdW1mZVZYeXBHYVNB?=
 =?utf-8?B?ZnpsNEVwWGRmdkhjb2lNcy8rWmEyZGtVZHF6SXd2VGxPQndoRVdSekVtMDZJ?=
 =?utf-8?B?TGZOUEtYR09ZYk9MdFE0R1F4ZEI1b0k3L3VzL1NURjVrS09ISDg5MktOWU1H?=
 =?utf-8?B?Z3BBWC9HakpySDZjN2o4ZXlseFQveWovSXhraGZ1dkN6cFN6aUdvYk9naXFm?=
 =?utf-8?B?cjFLU09rZ0RtRk1VVnM3Z0dPeVc0S2N1dm04c3VuMlZRR3JSeDhJL2hEa2pk?=
 =?utf-8?B?dmRZZ2pLcTdFdldCYXZtWk51TEdpbWlIYW1ySFRzNFNtNkpnU21rSkllZDlx?=
 =?utf-8?B?Tnh6VUpyYlpZNGJTazBDQWtuL1FYamNzbzFJTW1aekJndzJxc1dUaFJ5WVdG?=
 =?utf-8?B?cWxMZ2M0U21Fb005d1lkNW1vbkdJYWFNOUpDT20wbHBQcWpWMzkxcmFVbUtM?=
 =?utf-8?B?Q2IvRnBiN2JTQ0VBTEdpOWF4cHRRajl6U0JVVFpMTFUzMGFZVmlCYnM3Nnhq?=
 =?utf-8?B?VUdVVUhvanRiWGRDazBwUm9nS2NIdHZhOXp6NmkrRUh4SDUwbVhKQnpSblVJ?=
 =?utf-8?B?dWViOWU2L3lHWVhTTEV3VkVUaEttYWwvTmVOb29MeWRHZExKdXRwbDFhTWx2?=
 =?utf-8?B?T1ZRRmlueTNIR2IxcVBOK3U5aU0yaEhtY1lucXUxd2tIdll6ZDhjTVYrZldx?=
 =?utf-8?B?UTA0WGJFT2l6REtsWWhQQi9NbXJPdW1oN0V1b0lXbUlOZXJBeGdCTmRCTExD?=
 =?utf-8?B?RXFyc1pMY1pOTmo5dnhYZVJOa2Q0TlM5ZURUdTF5QVcrMlZSUC9NWllBRXhF?=
 =?utf-8?B?cHNYWUVXWXhtdTBYWFpTSFdaWWNDZkJOYTIvZzV3aHdzVS9DYjNjRHd0Q0Ro?=
 =?utf-8?B?K0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5nmGao21OrJtSIksGMzDjk8RvkKrk66IlJ3rKCmB9Lh0peXqpEo0Bb9XGnCE3+3wL9PTWaHUEAnnm5RmiioncDOknAaM1dDdkW/TKqAToDRw078P7mnAryVWYmp0GwC095d8r9UppXaZyPhOkzyd25Blrz6+AGaLjubim4KnGw7VZlXA55qbwySWrnAU28yw9gkw2ZRMZ/0EUv15ByBXepAAVcA/k8wNwWnLlWqCb+JTm4JM3Qa1ms+3pdp65+aDe7US2NCH8K0auSAylpA/13zoI1nvgdCes+cc/IXsV3AkedC9ILmozJ0PMcHl15EVDlotIuLlvPQLrzMlsKvorAz5oUZWLGuXSt/6RGiM0ZclAyV6qcMNcaPeo5+zhRsP/01mHe5Y1YfRHo8MhVhoW886qmNobPPie6qEckQN4xsA+THTbZzMlzTlsPUh9m++sqx9azhd1ID3tvs7/m2bvrAU3ARoGTKGpwWGEYWiqdo4GzFRuNcD76fNuUD5+L4KkuaOW5kn9gGhiIHQ7/kDbgurkGHqFxCVCq0rTwvWIyl8GBwZoI+zQ6iI6/J75jd3aw0DQaZ67MKMPcBZS5ldD1vSrTMchrHAKtjn/1JABIE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a6302e8-ae37-4d82-7f1f-08dcfe6dd696
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 14:18:08.6682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WUkemTBUyAzSMqn70kfh43UM4kbLp56nSMUDgd/Zs/X8cszM1NgM4hnOtxZlTwGQgM863cMZrMOe8NeMtp8XEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6312
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-06_07,2024-11-06_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411060113
X-Proofpoint-ORIG-GUID: esRp_rnyLJpEHHFNNMn9D2pFvQvEhDOy
X-Proofpoint-GUID: esRp_rnyLJpEHHFNNMn9D2pFvQvEhDOy

On Wed, Nov 06, 2024 at 03:30:54PM +1100, NeilBrown wrote:
> On Wed, 06 Nov 2024, Olga Kornievskaia wrote:
> > On Tue, Nov 5, 2024 at 4:06 PM NeilBrown <neilb@suse.de> wrote:
> > >
> > > On Wed, 06 Nov 2024, Chuck Lever wrote:
> > > >
> > > > Having nfsd threads handle this workload again invites a DoS vector.
> > >
> > > Any more so that having nfsd thread handling a WRITE workload?
> > 
> > Isn't a difference between a COPY and a WRITE the fact that the server
> > has the ability to restrict the TCP window of the client sending the
> > bytes. And for simplicity's sake, if we assume client/server has a
> > single TCP stream when the window size is limited then other WRITEs
> > are also prevented from sending more data. But a COPY operation
> > doesn't require much to be sent and preventing the client from sending
> > another COPY can't be achieved thru TCP window size.
> 
> I think you are saying that the WRITE requests are naturally throttled. 
> However that isn't necessarily the case.  If the network is
> significantly faster than the storage path, and if a client (or several
> clients) send enough concurrent WRITE requests, then all nfsd threads
> could get stuck in writeback throttling code - which could be seen as a
> denial of service as no other requests could be serviced until
> congestion eases.

I agree that WRITE throttling needs attention too, but limiting
background COPY seems like the more urgent matter. Unlike READ or
WRITE, COPY isn't restricted to a single 1MB chunk.


> So maybe some threads should be reserved for non-IO requests and so
> would avoid dequeuing WRITE and READ and COPY requests - and would not
> be involved in async COPY.

I'm not enthusiastic about "reserving threads for other purposes".
The mechanism that services incoming network requests is simply not
at the right layer to sort I/O and non-I/O NFS requests.

Instead NFSD will need some kind of two-layer request handling
mechanism where any request that might take time or resources will
need to be moved out of the layer that handles ingress network
requests. I hesitate to call it deferral, because I suspect it will
be a hot path, unlike the current svc_defer.


> So I'm still not convinced that COPY in any way introduced a new DoS
> problem - providing the limit of async-copy threads is in place.

Because the kernel doesn't do background COPY at all right now, I'm
going to defer this change until after the v6.13 merge window. The
patch proposed at the beginning of this thread doesn't seem like a
fix to me, but rather a change in policy.


> > > > > > > This came up because CVE-2024-49974 was created so I had to do something
> > > > > > > about the theoretical DoS vector in SLE kernels.  I didn't like the
> > > > > > > patch so I backported
> > > > > > >
> > > > > > > Commit 8d915bbf3926 ("NFSD: Force all NFSv4.2 COPY requests to be synchronous")
> > 
> > I'm doing the same for RHEL. But the fact that CVE was created seems
> > like a flaw of the CVE creation process in this case. It should have
> > never been made a CVE.
> 
> I think everyone agrees that the CVE process is flawed.  Fixing it is
> not so easy :-(
> I'm glad you are doing the same.  I'm a little concerned that this
> disabled inter-server copies too.  I guess the answer to that is to help
> resolve the problems with async copy so that it can be re-enabled.

We've been working on restoring background COPY all summer. It is a
priority.

One issue is that a callback completion mechanism such as CB_OFFLOAD
is inherently unreliable. The SCSI community has loads of
implementation experience that backs this statement up. I've got an
implementation of OFFLOAD_STATUS ready for the Linux NFS client so
that it can poll for COPY completion if it thinks it has missed the
CB_OFFLOAD callback.

Another issue here is that RFC 7862 Section 4.8 wants each COPY
stateid to remain until the server sees the CB_OFFLOAD response.
NFSD needs to have a mechanism in place to ensure that a rogue
client or poor network conditions don't allow the set of waiting
COPY stateids to grow large over time.


-- 
Chuck Lever

