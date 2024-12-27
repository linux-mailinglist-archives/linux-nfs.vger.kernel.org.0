Return-Path: <linux-nfs+bounces-8800-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C2F9FCF8E
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Dec 2024 03:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D7F43A0406
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Dec 2024 02:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042A9F9C1;
	Fri, 27 Dec 2024 02:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KdfyD+ud";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="p0tV9tp1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F286E2572
	for <linux-nfs@vger.kernel.org>; Fri, 27 Dec 2024 02:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735265199; cv=fail; b=HyVmSHm7y30nS2JnsqAViOXkcy9DeQdcZW/9YzMZpsKM94aJWWzm4RVcxAv/0HE1b2/RGGZtsNTb8aQu5A9OWfrWpy1wBYfxSiD/+HqluWcLL1MLjf+TeOs0+y78XAjOr2vvC/oKy6/1zM+bO5SSSPCFM7Z1Q1mcEh3+BD+q6vk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735265199; c=relaxed/simple;
	bh=vz2ichkC21nvkKVcJkeZdzvQVZYxQwxE2zKqrEPZu9o=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VRrYVvZqVEV6ShVHUHhrD6lGpDZ8VwgGZ2Xq8Jn0azHJizMZndkp/f+GLl/t8RdNpMOpi2Qxx5pklFZ7MuwjP+QOFCdqEsgvm8V/OvN4LFfMj0LRxOtHFLNsEjM3s5QraV/EqUNuCpkyNYgBtAN9fddVCtDkwr9d7VPycNd9ET4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KdfyD+ud; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=p0tV9tp1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BR0bbGJ007476;
	Fri, 27 Dec 2024 02:06:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=TmXX/6Zn6to17YFaeQ/ZaioWJBPqe2HBtxI2bYaMtRo=; b=
	KdfyD+udfKrATMbLxX+mITS73mhbwCWLgRxneJED3FU2sI3ACDkH3ngrfqPourbV
	/V5rOdE5Z+j09SuzacNrmzgq0BK0NREIKU3WOv2IIwfczVVue9v1uzrt55w7qyqq
	u2htHUU76ue/63Ou01ooocyfjRvtPbRq6LpJzRwqwTUR1n7XAtQuke3hUFk7RVto
	DzYm9282wo/5c8xjGEPkPtIlwGZpCe7KJvbU1xPK5Pl0TUMFqz83cQNsxNg9j/PM
	V6ijJ1iYuBA8+vlYck5K9SmGh/yuZtWVKkt34FNz+UDb0Roiftpiq06SqmI8V6sm
	jCG+uNNS7Pc8FWTCesLJYw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43nq6sew06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Dec 2024 02:06:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BQNQD2F029394;
	Fri, 27 Dec 2024 02:06:30 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43nm4g0cej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Dec 2024 02:06:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sn32Xy8P76dCbVTCTyYTMez7dBmoG+H7oXq+RjE6VMkhvo9L6xGuwAAIIIEY6J5MNh4zvun85f6kangph2pseE9MAjlte0jQFAtobOGI6Skpjj67DEH44Q3ikQYk33XS6/FMkBwvUbd2eG20YAAXIr2ADoSXQrew+TMpbm5LqNvTlgOdt+W5x6c5RJ3qDLE/6w9L7wGwAiu7qjXohXJevl77TS3z7X+BEt/IfyIvj6AKJwhylxAAAIrm5qjpdY8CSo1fiXWFkz/CA2IMUjVwJx+PIwtMAfQnyeeRwqDaMp+FGUNaLt3fcvyA9EPM1BkR4OH2G8N8ACKtHqe7nFeG/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TmXX/6Zn6to17YFaeQ/ZaioWJBPqe2HBtxI2bYaMtRo=;
 b=boYKZsM41wMN7E7DAD9aQCMYGomG9Wcvxktui05LpntpO2T03OZFmwzIOHUhFNu1LcPAw1QTZ3fZZ4C5F/KWgeexNrAfcK+OwGR2QLYJbovkm/Y9cvrxm3qdZ7ZlXTxaSYPlddXMGVb6yP61dWvSi8x+yDOqZSCZazdk381q3EmOPUTFQ59lQ6tEOJkVsEeLLWKEA/paijH/mEpCjud5ktSz45BBfrWxUym3AB7TxeQS9M0l9mWp4MvLZiDnPf9LC+J/FJWdcbZppDN9srDqJpR0sggXoKFRxKqM1j35kI7Sd5A6I09F1n9axJSiqh2p8wliMHNqUsVCnE57wJtwJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmXX/6Zn6to17YFaeQ/ZaioWJBPqe2HBtxI2bYaMtRo=;
 b=p0tV9tp10S5yLBdwFD0i2LH9SlWrndmjeh1kd9RBJzQK7sR2wCWOOhakRrm0crUOiTwRWygTOb/bd4IdquVBBWgAgXw8HOYbCzDcQaE0XcQIvVgb6Zc5N/7ULbROSA+s2QvzDIhWT8XACwkEG351tWZYmP4/LxiuB/ASYjSUdVU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6206.namprd10.prod.outlook.com (2603:10b6:8:89::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.20; Fri, 27 Dec 2024 02:06:24 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8293.000; Fri, 27 Dec 2024
 02:06:24 +0000
Message-ID: <843de897-25ad-452b-93c2-1321df4217d0@oracle.com>
Date: Thu, 26 Dec 2024 21:06:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] NFSD: Encode COMPOUND operation status on page
 boundaries
To: Cedric Blancher <cedric.blancher@gmail.com>
References: <20241226162853.8940-1-cel@kernel.org>
 <20241226162853.8940-2-cel@kernel.org>
 <CALXu0Uek82Nx4Ps2v_BwF9XjiFU2QumKJu9CFoRKKaX9stducw@mail.gmail.com>
Content-Language: en-US
Cc: linux-nfs@vger.kernel.org
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CALXu0Uek82Nx4Ps2v_BwF9XjiFU2QumKJu9CFoRKKaX9stducw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0032.namprd05.prod.outlook.com (2603:10b6:610::45)
 To BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM4PR10MB6206:EE_
X-MS-Office365-Filtering-Correlation-Id: 107b8590-0073-41ed-efa0-08dd261b10a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3p2bGhiTzZtLzFXaDlyZUVnRWlTNEJOMW5TNFNXQXFJN21jMWFHQnZoenZZ?=
 =?utf-8?B?dWlZamQ3VmczS3ozSFlNLy9EeUZVZXlBcWVlUjBob0JYWllqMlJaMjhocUFC?=
 =?utf-8?B?Yk91dlU1RWJwaUIxWHBscVNEWVYxcmFoMldMN1Z4TTZxaC9BZHl0Z0Vva1ZC?=
 =?utf-8?B?bDhjZ3lPQm50K2RHSUhFUHJRWmJ4Y2RCdXYwMURjeWhNdkszNk5kUUsxSUdn?=
 =?utf-8?B?WWJtWEtpNm5FamhNVXBXVVFvejEzYjVUVU5wUmZVZUR1TFVjWE51WFBXQ3Bn?=
 =?utf-8?B?Q09QRmQ2Q24zR0QyMHpHdUFJR3hoUXdQdndDREtFVXY1VVlqdVZieFBmRXl5?=
 =?utf-8?B?K3BteW9ZdTV5ZnF5NTl1V09CbjRTUE9GSTVQdXh2WnVkMFBYN0hVenBBS25q?=
 =?utf-8?B?Y0JQeTUxbG82cWxNNjVhR3hnMzQ5ME9pclhRQWNVeksrOEQ1SS9zM3c2dEN4?=
 =?utf-8?B?NGZZNFcwQnFrSmVqMFpzZjl3QzZYc3RKUWlMd2I4Tmdjc1N6eUhYNVNYZXM2?=
 =?utf-8?B?cXlsbTVTTjFLa0ttbkZoTlR3bW9zUGJSaEt6Y05iZDREaXBHYklhNmI2Y1l4?=
 =?utf-8?B?aEhKeHlUelZ4YXBtWThIK3lXUEFZbGZYQ0VvYWVEam5LN1E2N2NYbHFoaSt0?=
 =?utf-8?B?MXQ1aWhlZ24zTVJ3eFdTbWdwb3F1enladmRMTjRCY3BoMjFWWjF2OUpwYmVz?=
 =?utf-8?B?ZXFyZ0QwNFVQVklFQUR1RHVHN3FMU0doZktMT09YRGYrTkhXZ3hLVWhxZlhZ?=
 =?utf-8?B?M1RoZnMycU9QYUVzZnF5RUtpSGdmNy93QkJoTVpuQk54bVFoU0JjVUpQQU1H?=
 =?utf-8?B?eVlkZTZHMEpnS1pWN1NIZDFMV0ozRzM5UVhCclExYVEyVnpjOTdoeGpEc2cw?=
 =?utf-8?B?ei96QSt1NlhPZVZ3SzgwbUVzT0dCRlJ1SS96T3ZWbnpkSFo3K0dIeWdiNjkr?=
 =?utf-8?B?WlM3MEhVYWVwSkpEUjRvOUl5UmtmOHNHdlpTOGFNMWJsWk5PKzJYSUoxWCtp?=
 =?utf-8?B?QmN3dlg2QWFiZExIeEVURGRndTlrby9BMU1makNIcldSaWJjM3FBZHN6VmdR?=
 =?utf-8?B?YTZTVmhMQldkNC83a08yQ1dFczBqSmViVTFSQkhFYmtnTnRSRFdCK3YybkZZ?=
 =?utf-8?B?OVptQlZNV0wyWnQ0RVRzZFk5ZWZ0VStQUXVweGR6T1pNOE4wVmxRbU4xZVZN?=
 =?utf-8?B?ZTZLSWtrdjUxK0dMY2tiR2o3ZHBtdnVKalBFZ1YwNVpaN0R6clpYZVJqUnFM?=
 =?utf-8?B?cURqWFphR3JlbWo2L242dUpuN0ZLOGJ6M1plNVZxSTlGSWZMMTBYdiszWGlF?=
 =?utf-8?B?c1hGQVVPenVIbFhveG1OcFhFZUZjWkhSdVo1cjhkRGRmcHpZS3ZkZlg0bjN6?=
 =?utf-8?B?aTdJNEdpWmJIVnNBaENwRnQ4NlA3RmZsTGlWaERaNExSdmxFb1dFVXljWFBa?=
 =?utf-8?B?L01tUlRlc2svb3RCbHdwcHpPS3h6M21qb2FpaXZXYnRiaDRkdno0T2E2TkZa?=
 =?utf-8?B?YkVYaDROVC9idkE3dmJENHBEMDUvOGREaGw2VVViejVSMXZ5Zy9lbWt6VmUw?=
 =?utf-8?B?SmZwVTdFczZES0RhbVEyeWJkWTJ4UVAzR0Y0b3J4cTAvZ0YvQ2ZpOFozbkJv?=
 =?utf-8?B?cjF5ZGdFRDIwRGQxVEJsZ3p3bXZGbjlLcGhFU2dlemsweDE2bStlUHFpVXRy?=
 =?utf-8?B?ejdGWjZ6WndLREpDYXB6SFhIUEdXQkwvZjZ1S1BldTR3MjhDZ0ZQZGNpUVJ0?=
 =?utf-8?B?RXBjR3hFTDhpWlRKQklTUlBPbmRPbGN4MkZIOEEvTmk5a0YydElKdndLaVkv?=
 =?utf-8?B?V1RScUVKN0FveUlqRDhmQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlR5ZG5xaGthcmNBV2lCRUpaOXhtbTRCNlhEUDFVWlFaK2NDY25IUllxdjZZ?=
 =?utf-8?B?Q2NuZHBRMzNKbndBNEdtK1AyTlM5K0g1SXczblhwQU1SK2srb2QwZGE0NHdX?=
 =?utf-8?B?TUE2N2FqbTFJTnBSTEdhTERwa3BCWjRVMXBQM0UwMTVTbHdsS1p2VlZaQjV5?=
 =?utf-8?B?QWZIczVkd2tZS2N0K2o2MDhuWDJweEtNSzFtVXM1M291QWRmVHhjWUFja2dm?=
 =?utf-8?B?OTBuWGpTSTVlY1gzV0pOTWNWTmUzZVF0VVBXczhieFZiM2pkbWhwRUNRclZ5?=
 =?utf-8?B?WjRxMXhYbzYxRnZoQkxmTWQ5OVhQUVNkTkpSbDY5akxoWUdkdVZ6Y2Z0ZnhV?=
 =?utf-8?B?VmprdnIydG1ZUGtaQm5JQmI3STduRjVKQUwyQnZLYzJvZ1ZDdS83bWRYc1BJ?=
 =?utf-8?B?M0s5WUc3U1AvTkozK3VtQU5ma1poSWJkL0JOS3hQSFhTdjMrMlR6Tm1ETWpp?=
 =?utf-8?B?djlMMVNHZy9rY25zVitCdE1iMVZ1OHF1MEFYbUwzRitQTjh5dHdOc2hnbjN2?=
 =?utf-8?B?emdHeVhrWWN3bjNRTkVBMmpZWGl2ZnVucElLYm1SZzFxTGVtQkkyQkw5U3Yv?=
 =?utf-8?B?QUVvbmVoU015UUVrMVN4a1VDR3pjaFkyajVJdmNQbW40ZWYrN3BpeVZYcW56?=
 =?utf-8?B?V2hGTndKT1lQQ3VkOWE5aFJiTFBBS0RLRi9FNThUTzRlL1U2Zm1jdXR2Y3Vo?=
 =?utf-8?B?c25sQW1PT1A0TGtrejdOWFlMME1DOTFYRGFaK3lOeFNTQm9zZUJaYmY5Yi91?=
 =?utf-8?B?M2JHNXVjbDlRbVJ5dDNNSDd6VFVYTlVqOS9Xb2dFb25Dd2poWnZZZlgwTUoy?=
 =?utf-8?B?anh3Y2pGSnplMUlPWTJhV1B0V1djNnYwNzVJVWlUMFVaaEtSaUVuTW5aUkZu?=
 =?utf-8?B?VnRtYXFSRU8vRmF2K3p5aEdsbjJnZFlabnpFNzRiUFRmdFlCeXZjOGY0c3la?=
 =?utf-8?B?bS9tQVpzTXF0Y21MZkdoWFQ5aW5YcVcrczYzbGFRTVloaFVGQmsvUGxsNTc2?=
 =?utf-8?B?bUJzNmVZdldLMGp6VEx4TkkrUnp2RG0vcjZEV1JVNGsxWFFEaXlFQTJEUFZa?=
 =?utf-8?B?dGx4RDh2Q3FwUXNDRndHdnIyNURIWlNaN0tUU2YrNTBsbGdEUjhOVnNmcis0?=
 =?utf-8?B?SnVtcENpOFdRejdHSEpvblRuYllQZmZ6b0lBbDFBL3pmUTdqeGp4RTgyNWJx?=
 =?utf-8?B?UWlUeDI1WTVibEVkMm9KOUhLWG1XSGVQMUFraVBtTzVJZlJya25CUHJRRlpr?=
 =?utf-8?B?K1lBbUtZWXFMSnZWclNzcTVEd3U5dUVFUUFaMVlCOHg5TFY3RmZSa1hGYzA5?=
 =?utf-8?B?ZXZTQmFwa0V5cTRKYnN5NjNDR09QdUZKSXE1TTI4b0JET3Y5cHpGSW5XVmtw?=
 =?utf-8?B?SXc3OUhQRFJiTUhoNlNTRkUxRVhhbWNna3lRN3pGYktCaEQ1RC9iem12dlJ2?=
 =?utf-8?B?akpFR3A1QXZwRXRkbWVBMTBsbERCYVQyVnp3SzFOWGxWYmxGaHYrd1ZkOEtX?=
 =?utf-8?B?b1FzSWRZNVpHV3BTN1kvRndGRWs0MWx1NnhicnpwMk8raEZTeDZLMlRGb2c2?=
 =?utf-8?B?cGJ5QzlBRGFCMk1aLzhvU3lvUUY2MFdOWkZzTTh2aXBkRG5Fd1htV29uTjc5?=
 =?utf-8?B?aHZOd2RGVUMzM2RaQzZWRzR4Qkl0N1BSOTcxbHd6UTdJdXdTTXlHMi80aHRY?=
 =?utf-8?B?UUg1RlV1Zm0zQ2trMjBDK2lGeXBlMzlpWFBmRVVnSUdOdVVSLzdza3JudjRO?=
 =?utf-8?B?SXI5OVR3dVIrcnVxSmhOTFRrNVF1K0R1TkVaVmpCNkIvY2JtZHp6YTZrOENw?=
 =?utf-8?B?VTVlQm8wRDI5MVVTamRWdTRZVFF6Y3I2Q1NnTmloZjI2Sk8wZko4cnU2c2Qw?=
 =?utf-8?B?bkc2bW93V2djM01uaU9wbnlTak5CNEgrWGdsQ05zSGVaMVZ4ZXRsVEtLdlAv?=
 =?utf-8?B?bEtxNWhwVE9aTGE1eGFVSytWMFhhMUZZZlhqbDZ2SkJWV3llck84dXp1WlJr?=
 =?utf-8?B?OUtheUE1Rkg2L1V4RExYYUtQNjMrc1dYRVltWUV3RFdPZGFTOUN5b1I4RnI2?=
 =?utf-8?B?QjZmS1JPNi94VXJKVnFURG56eTJzY0o1alMxY2NScTNYRncrd01mNzlSdkQv?=
 =?utf-8?Q?EKbxc2FOUkgMB8r7/2rSYzhiy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sfYf3uw3kIgULBMnP4M0TW2TkveiqNz2Kx4pj+7dhEIRTVJDUzdA2w4nXMPTfCvaKhLxFcy45tiIxPizf+W+AZGbqx+69wl/dkGylW0xhBaGgyEBd47cqDot/v/UXZa/0lI6zQgKVAQlwHEkLDMrb+SNZRkGWIjUlmzLFGJiz50WtDv/I1VicvWICOP4ZRNhXNA3AincQV2hcdau/FliYRlndqAu6dfQgDeH+BEm5P27tzNTu/pL1InSOLi/3mIoDG1YYh8qc6PlQwTawhS6r4Bh1x8TRFRFImMmpnhMUhjuyvHhbfRbngG3v4hmB8nIyt/IYc85K4Gv8ZjaadUS0FNW5n07sbJH6gnH8iNXSnCPGXRGAvevBCr/vi2NbXtPGCjGkyswgNIk1ligo444VOMPfH2nceL7CITe+7iR7iAtz2VHwPvTgcl9eJhlHrLRTquWoOfAJgQjWFHQ4nRjElMiIb7YgP06bUNthgyoWIneQGYAaduh4VTKHSxeLNBVyeHRpLYyZldFFvfeHTWyYQoeMtFca6dmuvbOyDMJRhzl+1cumDXqb0P5hMEhYGG+JhgIzkgfKhkDqcjWTkbcroH7u1xT/jbsLk1tkliIsKk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 107b8590-0073-41ed-efa0-08dd261b10a1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2024 02:06:24.2710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ykd2eYEX1kwVS68NVXwEjGCbgS6nEcFTomnNNEMms/ACUR4LlWR+cwY9rzvV7Z7HkZjmAlkzUM61pECRQ3BQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6206
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-26_11,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412270016
X-Proofpoint-ORIG-GUID: Q9AiKwAN1A6Bglj8GyX6ZhZgRni-7xeV
X-Proofpoint-GUID: Q9AiKwAN1A6Bglj8GyX6ZhZgRni-7xeV

On 12/26/24 12:17 PM, Cedric Blancher wrote:
> On Thu, 26 Dec 2024 at 17:29, <cel@kernel.org> wrote:
>>
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> J. David reports an odd corruption of a READDIR reply sent to a
>> FreeBSD client.
>>
>> xdr_reserve_space() has to do a special trick when the @nbytes value
>> requests more space than there is in the current page of the XDR
>> buffer.
>>
>> In that case, xdr_reserve_space() returns a pointer to the start of
>> the next page, and then the next call to xdr_reserve_space() invokes
>> __xdr_commit_encode() to copy enough of the data item back into the
>> previous page to make that data item contiguous across the page
>> boundary.
>>
>> But we need to be careful in the case where buffer space is reserved
>> early for a data item whose value will be inserted into the buffer
>> later.
>>
>> One such caller, nfsd4_encode_operation(), reserves 8 bytes in the
>> encoding buffer for each COMPOUND operation. However, a READDIR
>> result can sometimes encode file names so that there are only 4
>> bytes left at the end of the current XDR buffer page (though plenty
>> of pages are left to handle the remaining encoding tasks).
>>
>> If a COMPOUND operation follows the READDIR result (say, a GETATTR),
>> then nfsd4_encode_operation() will reserve 8 bytes for the op number
>> (9) and the op status (usually NFS4_OK). In this weird case,
>> xdr_reserve_space() returns a pointer to byte zero of the next buffer
>> page, as it assumes the data item will be copied back into place (in
>> the previous page) on the next call to xdr_reserve_space().
>>
>> nfsd4_encode_operation() writes the op num into the buffer, then
>> saves the next 4-byte location for the op's status code. The next
>> xdr_reserve_space() call is part of GETATTR encoding, so the op num
>> gets copied back into the previous page, but the saved location for
>> the op status continues to point to the wrong spot in the current
>> XDR buffer page because __xdr_commit_encode() moved that data item.
>>
>> After GETATTR encoding is complete, nfsd4_encode_operation() writes
>> the op status over the first XDR data item in the GETATTR result.
>> The NFS4_OK status code (0) makes it look like there are zero items
>> in the GETATTR's attribute bitmask.
>>
>> The patch description of commit 2825a7f90753 ("nfsd4: allow encoding
>> across page boundaries") [2014] remarks that NFSD "can't handle a
>> new operation starting close to the end of a page." This bug appears
>> to be one reason for that remark.
>>
>> Reported-by: J David <j.david.lists@gmail.com>
>> Closes: https://lore.kernel.org/linux-nfs/3998d739-c042-46b4-8166-dbd6c5f0e804@oracle.com/T/#t
>> Tested-by: Rick Macklem <rmacklem@uoguelph.ca>
>> Reviewed-by: NeilBrown <neilb@suse.de>
>> X-Cc: stable@vger.kernel.org
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
> 
> We would appreciate it if this patch series (esp the "insulate"
> patches) could be backported to (at least) the 6.6 LTS branch, as this
> kind of data corruption is haunting NFSv4.x clients since years#

Note the "Cc: stable" tag. Fwiw, it's my intention to see that this fix
gets into stable kernels.

I expect this patch to apply cleanly and automatically to LTS 6.6.
Earlier LTS kernels might be more challenging, but I'm happy to manually
backport to those if that's needed.


-- 
Chuck Lever

