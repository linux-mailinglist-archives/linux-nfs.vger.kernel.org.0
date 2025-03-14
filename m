Return-Path: <linux-nfs+bounces-10625-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A48FA61CA3
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Mar 2025 21:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5867D189DAAE
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Mar 2025 20:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F5A1EA7C9;
	Fri, 14 Mar 2025 20:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wx4Wf3Dr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UdnKMVH/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4FC78F2D;
	Fri, 14 Mar 2025 20:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741984028; cv=fail; b=EqGq8/IwNXXFCaxLd14KJJMm4z3+qYlLvvMrraqzswhmR6PCA7AFVeb3iykqjA7IjA4DCUFIXAclUfaDKhIoeK/cb1bKBGRl+Z2+8zDNh8rIkRDslKMhCfiO7As632mzCwSdyR2P1QFDljPNxqsWUqMyDimNKFsmBHcH7+q0GFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741984028; c=relaxed/simple;
	bh=6iVMxcGW6jtcsEwmlvvGwebkIgCy6B+1XA87MpMsrOQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RQAv773RlaHULze5p46YHV00gikDIymELZOT5ggr95Eupo2gI05A5nlOHJcKTQGRsxU9VajVRS/s3wGm0T95YlaYgHYHUp/+km4Hih+0EuW/7EvDpJE0gH4tFszdrEfpYiEd/oQku2nCadL2uKOm5rl13NKNd/pB0tvdt3LmErU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Wx4Wf3Dr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UdnKMVH/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52EBloGY009747;
	Fri, 14 Mar 2025 20:27:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=DlpRMdJsXv40xWqvaBk4POMNnHUdhQ4beeaoQH8Qs+A=; b=
	Wx4Wf3Drd2+INszsZ9spJq7qbk5LjnTliQrM8AnUzDnGJQpngoxSTfg4ZMneDSZ/
	u8jZs7UFrNM/O+Wnsb/OYbU8UFhKRCsvSvjsO98s0M6I3ASLHaWyNsfyqKEVx8Fo
	Hno7gKfIo6xqleyCTEZK9o0E9TT7JPFLlFk4UjgMWdRoGh1IVhzkcS2kJmWLtyfv
	fara2VbFjFwEsStKQpIUJjCc+U2ZzYhvxEWbm4QgeAH16BeaKTt9i9hILN8Ha65E
	rZtKqajeVCREPZjI4eflHurJrdX5Jh3zc500oaRFKkrTIqV6aFxFNq+RpZB7hdq4
	fypdnaTwfVFnMMSmA7fhJQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4dy6m6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Mar 2025 20:27:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52EJ1LLG019546;
	Fri, 14 Mar 2025 20:26:59 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45atn3puf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Mar 2025 20:26:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o0pdH9gGxtV2pe1/hdBqKpY+dGnSlS5zDhkoZxPAy+TCbLCWWgExw2Q2bwTciPWBy71igd1c5rjyvN3NLxJh0ILtL+3LCha9AvkPKjwrIjYeADDoSYz/HHFzUiOifOJoARBYtfh9NFpBPUDZIVB7UOCgE12GgUyJ1/IxWGnaCOw919v037O/Ef7jjTrIs8jtxRAvGtQyYe2iyIRZP2zXMeXqFEC0I/cxHpi0ujdkFTON+ps7ZN0SzZ6Nin93d3zfptiPoSeJJsfiv2Xse6RRJ5h3glQJW/PUmL+bfxW0nZU2DUH0MO9fyHJoTO7ipVU+I/WCnGb1T2+U4WmcrJqjwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlpRMdJsXv40xWqvaBk4POMNnHUdhQ4beeaoQH8Qs+A=;
 b=P6lRE9afqzKa71ffJfTZpWEkc9XZXENyUPRna4lxqf7TNZXVXNhN+XuRRnkW2xfQE7Y80fDxV19Q4ynqTuxHmO0YKPyxjw/QDlEiqHVLgB9urC8vd1Kx2HBsbti4MdG5Le8Qi7qtlXO0lzQND9+mWbM8YXGH1gePDRSEyx8K+4vFOjH7A7NWesw6EPyzHj5NqJvBGNqQfU6+Xk9k3ONSbhY+jUR29KeJo8T7Tod4Gk0rMTqK4ZSd+pzsc+Pu9dmcGKewRZTXa+PN1KB/1YjuZ38RlatGO4CbUdrbrdSQrkms2oIWPlCFhU0G8YRynk8MPAvEBwJwOg8KO5fN0vDbFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlpRMdJsXv40xWqvaBk4POMNnHUdhQ4beeaoQH8Qs+A=;
 b=UdnKMVH/9gULoeyXt99wWGqxD91fYQZ6qzxKZzt45WCXOvH91ycjnqnGFxXN9/glZuiMW+i6hlevt9pSmYSJ5buw2RjUa4MQse+k2gBm0C27sRSwyXLnqlrtQ3an1vsBNLuYmUtCPdmrKfddaq6/CYC0sK4zTS8LFANJwGojzCs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5547.namprd10.prod.outlook.com (2603:10b6:510:da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Fri, 14 Mar
 2025 20:26:57 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 20:26:57 +0000
Message-ID: <86bc01b6-fb3e-42e9-ae2b-fdea7bb16420@oracle.com>
Date: Fri, 14 Mar 2025 16:26:55 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: NFS Server Issues with RDMA in Kernel 6.13.6
To: Robin Murphy <robin.murphy@arm.com>,
        Lucas via Bugspray Bot <bugbot@kernel.org>, jlayton@kernel.org,
        linux-nfs@vger.kernel.org, iommu@lists.linux.dev, cel@kernel.org,
        trondmy@kernel.org, anna@kernel.org
References: <7285c885-f998-410a-b6a6-f743328bf0b8@oracle.com>
 <20250313-b219865c2-ff4305a1f238@bugzilla.kernel.org>
 <e59f75ea-9b50-45dc-aa89-f0e02aa4e787@arm.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <e59f75ea-9b50-45dc-aa89-f0e02aa4e787@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P221CA0008.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::9) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB5547:EE_
X-MS-Office365-Filtering-Correlation-Id: 0842bbda-20e0-48d6-2aef-08dd63369119
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGRMWEZKMkdzd3NzWmlMNXZobmVYeUQxM0dOc21HQUR6Q0pxZnZGNXVxcTJM?=
 =?utf-8?B?ZlJrWTJza1pWbDVYNksvWVhnTGEvdzhpRzN2elJYZUljRUc2Um9nUTJ1cWVF?=
 =?utf-8?B?amZsdjhNd2VqRDNzNitqOTB6a1cvSmNCUFkwT3lqUzg0eUJKOU16RzRxS2tJ?=
 =?utf-8?B?SmpWdk9TUDBvL1ZvWVE4aGoxdEVpU1NieEk0RUdSaHZYZDBNMksrNmJMTkkz?=
 =?utf-8?B?eGJmV0JFMndGaXRQeDBwUFY0Z2Y3THNKZFZaQ0hkNHEyd29lVHk2azh1Mkc2?=
 =?utf-8?B?dmZ6V1ozdjJFeGlaeTBNejY2ckt1SFJCLzlEOW9vYkxudE9TdUkrZmpUdW1T?=
 =?utf-8?B?Nkp3TFFZaEdDUUcwMTUrYnkyaFdOb09kTDg5V2tFMWVsN2xvZkNxQWh0QW5W?=
 =?utf-8?B?aFJwZm1QUEo0NW12SG9zRllOZWJ1TVJVbCtZcE1CKzFrYlpnMUFsVHVXOE9p?=
 =?utf-8?B?a1RVa0F3ek9BR1Q5MlBlQUtHcUdZSGcwYWVuM1dKdnBZaU5lVmRaUHh1NE5i?=
 =?utf-8?B?WXRjVk9VMDVlaWg1S1RKbFl1SDA5angyVXUyMXJpall3emp1R3lWOUFmbnZx?=
 =?utf-8?B?SlZHcG1mL3NSM2Q3UEExQ2FYOTloM25DdFhOTjI2QW5Ca1lETU9vOHdWb2JT?=
 =?utf-8?B?L2orQnc0TGhaazQvbis4UEQvL29lTnFqUmg4dkZIOTZvQlZsMkRzc0FDTHI1?=
 =?utf-8?B?bVZkK3FDQTNudFkrZDg2bmZOWGJNWWpMOUJleFFDNHRHaFF0MThJdEhNSEVB?=
 =?utf-8?B?U2FkNTJoSFp6NE5PSCt4VVlweHQya2xkWjdKYnVDKy9LNXJPMXJPNDlUVkgv?=
 =?utf-8?B?L0EzUzhBa2oxSnVYWlFTMzUydWtBQTFPbjlwbENhaTRzR29aYkgvNkpaQWMr?=
 =?utf-8?B?aVZTNXdkMDB4anl5Q2RTMzV5a1BRV0FTdzBUd3BHWlQ3M21qSWNMZysxdjJp?=
 =?utf-8?B?MkI4R2pnNFVCOERrYklIREZ3L2l1aEoyb1pZckRhOGtNbnY4VDVGcWkweVRl?=
 =?utf-8?B?VWRYVENQNG50a2VMaXc5K2FGNXFnUWMzS0xrc3gyMDNmZmlQUG9icDZXQmFC?=
 =?utf-8?B?OGYybjBMa0V2eWdFd2l4OFZXY1J5SXRzQ1JJTmxuZE43ZWFlaFNBSThKa3Mz?=
 =?utf-8?B?eVZGdmdUeEE1U0hSMml0UUZPUjNxaEoxZmhwRjd6M3RVa0ZrZHhHUXl3VVRi?=
 =?utf-8?B?QXkwb3hCZGxjQjgzbGVwcEVWTnB5blN4TFQyQVc5WWpXUG5MblRjMXhvb1A0?=
 =?utf-8?B?ZzBjVVc0WmhLdjRUcG9QS2h2WTRZazRjYzdFSHg5eEpCVWxhNndRUmxtd0RL?=
 =?utf-8?B?TGFJVmNYU2RodXhQWEtLOFBwS3NvOFVleWVTZHIrNWFOY0JGRUtJTVdRWG5k?=
 =?utf-8?B?aHlIRmhXWkhXT2FGQjcvSW5GMkI4UmcwclNDYmQ2bTdrMEppY3VzdnpiajYw?=
 =?utf-8?B?Tm5rYkhQZVJDcU9SYlRZWGJ4a3gvM0dFbEdTTnFLcDJhM2pWWUZZczVwWkU1?=
 =?utf-8?B?QXp1MGVTZlo0bk5wQnVjRzBXaEViMVBmKy9IbWhKTzRtUmhYaGNyeTFpTC9j?=
 =?utf-8?B?OEFHanZrc1VjcnRDY2JuMDRzamdNaURDamtGSjNkZExCbXRjanNpK2Y2V1hO?=
 =?utf-8?B?Q2xLTGdFWjJiL1dDekhlanR0eGlNeFhqR0s2UndsLzVZNVk0TlNveE5ncVNi?=
 =?utf-8?B?Q3o1SXRScXlTRjJMaHFETmdwRnF5UWw2ZlFxK3pMOHhhcGdhTHNNeFZ1L2tm?=
 =?utf-8?B?UmJTS1lUa0F5VWR4d096NTZTR1FzVVE4MkVtRnErN1FvZDEwN0ZzV3JPYUVo?=
 =?utf-8?B?ditPTFFDb2VnOCt6TTQreklRd3o1UjFKbDZVRHRvUzZNalRWdGN2UmkxcENU?=
 =?utf-8?Q?57+YhsbZwBsea?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzU3RzBRM20xdHFuS282Wm8zczVmUnBtNXpPcmw3QU8weXRET3pBMmtDWEds?=
 =?utf-8?B?TGlIYVYwaEN0ODBQMmxqWXR2bytveDVTdktzNnpkMk5nQitNTjRGcGtsbWtL?=
 =?utf-8?B?K1RmQ2NBcGpweTdFTWlGdkRyZkNQb2RaWmNSTXRHODNEL1ZHY0lHTyt3a1hl?=
 =?utf-8?B?Z1RHOTBLM2ZsQVphb0ZWR00xSGRNU21MaW9hWVJPRlRvNStRRGw4a25DRGd3?=
 =?utf-8?B?cGpKS1lMNUZTRjFuV2hnMjQzTlZzaTM0MzZJYzd0Wk1zK1NXUXdGeEdiZlVq?=
 =?utf-8?B?RG5vVXFmajR1NFZKdGlzaFhJNGV5UmlITEdHZW5qSnU3R1MySFRYa045Y1I5?=
 =?utf-8?B?ZUNMNVAyUUlXMWFHQnBOenlSbHZJdjFVYU1mTC96ZlVjUmJXL2tGUXFSZG1m?=
 =?utf-8?B?K0VqZVVZT3Rlai9KckQ3WWhuT3dMQVJOUlAzNkZCbUJwVUVJYkZtd3RRZUky?=
 =?utf-8?B?enRpbUtpQjVWL2hidnlaeGJ0blkwWGJtNGpTZERtT0MvdzMzRlAxR2NXY0kv?=
 =?utf-8?B?NXZNdDdxdUJhcHFCM2FyUkNjbVEyL3QxbVZSeWNoelpselM4LzlVUzBPNFlQ?=
 =?utf-8?B?Lzhza3UydDZ3ekQ2Z0ZYa1lHNnlSelAvU3hzc1h5bUhDTzVQQThScUwwRGZB?=
 =?utf-8?B?RCtZczB5RHJYRXUycEc0Ry92NmJoK1V1a0ZQakx5OG5qQ1Q4dmo1U0VxQmY2?=
 =?utf-8?B?MmY0elpVZVhmTWdOZzJ4eEFwWXZ1U1MrUXpidkpQOGpTVTU4c2JkdnJ6TkFm?=
 =?utf-8?B?dUhzTmY1RnFCWVEvOTlBNkgvb0doTFZZM0xCbnNiaW4wYk4xTGUzN2lYLyto?=
 =?utf-8?B?YWxkSllJZlFoNi8rY0hmUTJMZVp5SFhkb2JBWkc5a1RJTXRkT2tOOHU5S2gy?=
 =?utf-8?B?Wm4yTkxQZit1bVZEZ1VKaEduUU5DUXJWS0UxZDFyRUZLc0Q1ZlJ0RmZPRStp?=
 =?utf-8?B?MnhqNmZhNERrQlA5TDVoUlB5Yjdxb1ZGczlSM3JNNUExaUdFV25hVEd4cCt5?=
 =?utf-8?B?d3BWaG1iN0ZKd0FwYk5FR0Jjay80Umt1RVozL1FQOXJQMTd1OEk4RWkzcXlp?=
 =?utf-8?B?MENCUjM2Tnp5SzVaSnNmK1pSdUVXamFZditvdUVLWFFVRE9qclZMaGVCeUdJ?=
 =?utf-8?B?L1dNNlpYUmp6eXFCR1BrdmZKaXdIWTkrQzQ3b216TjVZZVo2NVVSUi9xVVZw?=
 =?utf-8?B?WndYSEZCRng2YVhJRWZzaE5rTy9DYzdoV3hOaEYxeThTRGtqQ1RERnlQZWRK?=
 =?utf-8?B?ai9lUWVPRmhJRm5ZTzMzTmlHTjUyWDB2ODlxRyt6ZW0zNjJTNUt6d2tjaW11?=
 =?utf-8?B?ZWRJMEE5aHBtRHhuM1FxTjU3RW43Nm9kV2JEcFA2S2NVb3lsbHdnZkFpaWEy?=
 =?utf-8?B?M0dTdjFHb2F0WlI3d0IrMStDSzh0OUZoNUtTR2FOdUZReDM1aUlrZ0xsdWpr?=
 =?utf-8?B?cUF0WUJsT3ZYdjNRekxKS2FEcERqQnl2Zjlqb3l0NE9rZUtqbzhYRG96NXdF?=
 =?utf-8?B?TW9ITTBtSEsvanlybUVjTEdTeXdYUHQ3U1pDVnk5TUoxZm5kaDFPZVJZREJE?=
 =?utf-8?B?L1IxMlAvdk90bFkwWXdHdGtzV2FvcU9Hem5LNWZrVnBzRUhmSkdHRm5HNXZU?=
 =?utf-8?B?SVZ5VDNHM09PRmEwWnpDakpLY3ZxWmV1S1JITmZPU2xHWGNOZEZ5MEtvUVJD?=
 =?utf-8?B?d1prYVFPaGtHNWVoQmNSR1h4V2xSMGRiMUs3NVBySUh4N2Q2VFhZWVUwZ1hx?=
 =?utf-8?B?bXpmYzhjWGY2U1NlSkZaTXdFZ1dTalRhYjVLeHN0cHNCTEJyMGRmQUxJWXRI?=
 =?utf-8?B?K3NQRnBlaVVlUXBQclVLRnhIQjBxV3JPOHpiNFgzTVZZdHZiaTJyKzY4Z0hP?=
 =?utf-8?B?Wi80eEM0NHVHSWx6bE8wNWZZR3BRY2duVkE3OHllem1Ra0psSlVleHJ6N1NN?=
 =?utf-8?B?Vml2ZkZoYkJEYmFjM1lHU1dnRTZ1OFVadENCK29RZWxWS2NzOE5DWW9SQzRC?=
 =?utf-8?B?cGR1MjlDQ3JsS2t0aXMyN21vbnROeW9KYmV6Z1orQmVFYzRUbjhLVXBpdGtL?=
 =?utf-8?B?QkZlSk8vcDh5MkMrS2xyUGV3N1ZER2YwOThqQmFMTHB1RmY2bDFVRlJyRW11?=
 =?utf-8?Q?HqLWMxCkvkiQ0K40kwroNRBi9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gKp8TcfbaEAaoWL3qTurk6E1xLZT55thQxG/76XhmRwb8aHYHDvFozxYrt7ey2chJX87dw/Yo6HpW4JCeHg6u6bHkIOnxeZ74sPe6bTlxOcPxaocxuMMKn3I0YRRbYIacNDl3cQ6EBEA3O/q/hzCabGgHwTIY5OnxJNj+SueLmVMuGovyb9GhK8PXEAqH9RH64WUd5KtY7KaEYyxMY0Q0iQIR9AheoUdgLMllUdvIUif7W8M84Qb99X9eLaLAySd3+wnxhM1/jhhnGN13wx5NORlkM1D2Q8Y3f6YsgJG4dr2mHYzePqe1voyjy6bwZ1Azu1iwzqFSPuDkgrZZCD1uN/WKozFADtIhG4pvsDJjSG1aSAdmg1NXJDMJmPuFY9PaZKzexmINjxSsuWs7z8Ii4cI0ADhtf/9K7f4V4hjqpF9F0Mw+TRsY7F4Tq2iMAIUBzJ0HUp//3OGu5A/M67ILR808gfmQ9V/Z+pCqHiTE0cgQCNaE1H94rOlMKu5XcUG4rl6Dy1qO5vzJ6aroQe6Un5olNQs8nt1jb/HtwsBi4S9tCX6eCPP+wo4bovHARzdOf6AhXfUU7VnEKGbxTg3IKB0+RofbBTezLaPZLKONaA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0842bbda-20e0-48d6-2aef-08dd63369119
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 20:26:57.1751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HeUOKAzC3iBEr59rCnUtVau1fI803LCGBLr2JiOK+KzfNFQTjmn8tKHFMFCo3WvU/j4xEBxYOfGWQSPXl6gVUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5547
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_08,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503140157
X-Proofpoint-GUID: 4uANRQbF_hXFYvo29BzCQOWYc4kAqiDO
X-Proofpoint-ORIG-GUID: 4uANRQbF_hXFYvo29BzCQOWYc4kAqiDO

On 3/14/25 6:43 AM, Robin Murphy wrote:
> On 2025-03-13 7:20 pm, Lucas via Bugspray Bot wrote:
> [...]
>> system: Suermicro AS-4124GS-TNR
>> cpu: AMD EPYC 7H12 64-Core Processor
>> ram: 512G
>> rdma nic: Mellanox Technologies MT2910 Family [ConnectX-7]
>>
>>
>>>> [  976.677373]  __dma_map_sg_attrs+0x139/0x1b0
>>>> [  976.677380]  dma_map_sgtable+0x21/0x50
>>>
>>> So, here (and above) is where we leave the NFS server and venture into
>>> the IOMMU layer. Adding the I/O folks for additional eyes.
>>>
>>> Can you give us the output of:
>>>
>>>    $ scripts/faddr2line drivers/iommu/iova.o alloc_iova+0x92
>>>
>>
>>
>> root@test:/usr/src/linux-6.13.6# scripts/faddr2line drivers/iommu/
>> iova.o alloc_iova+0x92
>> alloc_iova+0x92/0x290:
>> __alloc_and_insert_iova_range at /usr/src/linux-6.13.6/drivers/iommu/
>> iova.c:180
>> (inlined by) alloc_iova at /usr/src/linux-6.13.6/drivers/iommu/iova.c:263
>> root@test:/usr/src/linux-6.13.6#
> 
> OK so this is waiting for iova_rbtree_lock to get into the allocation
> slowpath since there was nothing suitable in the IOVA caches. Said
> slowpath under the lock is unfortunately prone to being quite slow,
> especially as the rbtree fills up with massive numbers of relatively
> small allocations (which I'm guessing I/O with a 4KB block size would
> tend towards). If you have 256 threads all contending the same path then
> they could certainly end up waiting a while, although they shouldn't be
> *permanently* stuck...

The reported PID is different on every stack dump, so this doesn't look
like a permanent stall for any of the nfsd threads.

But is there a way that NFSD can reduce the amount of IOVA fragmentation
it causes? I wouldn't think that a similar multi-threaded 4KB I/O
workload on a local disk would result in the same kind of stalling
behavior.

I also note that the stack trace is the same for each occurance:

[ 1047.817528]  alloc_iova+0x92/0x290
[ 1047.817534]  ? __alloc_pages_noprof+0x191/0x1280
[ 1047.817542]  ? current_time+0x2d/0x120
[ 1047.817548]  alloc_iova_fast+0x1fb/0x400
[ 1047.817554]  iommu_dma_alloc_iova+0xa2/0x190
[ 1047.817559]  iommu_dma_map_sg+0x447/0x4e0
[ 1047.817566]  __dma_map_sg_attrs+0x139/0x1b0
[ 1047.817572]  dma_map_sgtable+0x21/0x50
[ 1047.817578]  rdma_rw_ctx_init+0x6c/0x820 [ib_core]
[ 1047.817720]  ? srso_return_thunk+0x5/0x5f
[ 1047.817729]  svc_rdma_rw_ctx_init+0x49/0xf0 [rpcrdma]
[ 1047.817757]  svc_rdma_build_writes+0xa5/0x210 [rpcrdma]
[ 1047.817774]  ? __pfx_svc_rdma_pagelist_to_sg+0x10/0x10 [rpcrdma]
[ 1047.817791]  ? svc_rdma_send_write_list+0xf4/0x290 [rpcrdma]
[ 1047.817810]  svc_rdma_xb_write+0x7d/0xb0 [rpcrdma]
[ 1047.817828]  svc_rdma_send_write_list+0x144/0x290 [rpcrdma]

svc_rdma_send_write_list() appears in all of these.

This function assembles an NFS READ response that will use an RDMA Write
to convey the I/O payload to the NFS client.


-- 
Chuck Lever

