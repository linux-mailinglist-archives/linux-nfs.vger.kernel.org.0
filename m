Return-Path: <linux-nfs+bounces-11520-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E94AAC7FF
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 16:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19F171C42D27
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 14:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB6618D656;
	Tue,  6 May 2025 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CClmh561";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="teQmAlyf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4DD1862;
	Tue,  6 May 2025 14:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746541878; cv=fail; b=HQbZQpk+gIGjzq26tNThqJQn3KtJX6Iyl3zEAb4BRVrZYq8YMB7FrYPeEb+FokRIFkKMjJRQpi9Cxl9sAEsbwJ3hg37jEuUi4CRofeB3JEIJr1dC4aJ57f4tcCItFZ13YnL7B6qjHkWMlLC9LaGV+VuqNmm6S47/NL/sPyABWe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746541878; c=relaxed/simple;
	bh=KGtD8dKe4uSwA1HkFD6s/XyRZbPaC+9BmwoMu4hzQ2c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DJQpm7LjESw8AogA9CVlZphe/RV21CMA+9dzVtlDWp0sY5ciyEY9oMXrtYua3h4U5j6uGajO3rAx7pMtbRm3CYKiHpYQ/21JAQS0sMkYikTRXPOeke5SbghK6n2ztIMAVcN+Gg9slzirikIa0w9nhfnLZVUC1CPzCN4FPsJIr50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CClmh561; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=teQmAlyf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 546E7tT4012594;
	Tue, 6 May 2025 14:31:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=miDAFG9DclI5UtZ5+zx+ZycL8vMQpayG9vXJv1sVaKQ=; b=
	CClmh5618Do23Ph/SboFeCySc73cIKWGT5Pkopza31edUIUMSuHxib/Q4HM9G6sj
	5ScoiSAwUA6d6zWLwaheGdlqbdmm1bHTT0WNPJkUqRAGQHWG9zvgsrs+BJk1LSzO
	LCHjYe+1CEk77DHGvhUij9m6/5Tisjg6sJtHi4Lf55D7LLv7kEUYKv1rKDCldklT
	z4zv1yJ69g918GUyyOfHOjTYbmRE7vQZDN5YuvPvxtLp8v8Lzr8uhIJWRFbZZbJV
	YX30ZV9cRJ3dLOvWg+n0BDOwpFXrFN1Ns2oEjJ8V1OUDwXWj/WbLqV77eZkyqdiK
	5Mse9CItHmvDs7AJm5SLLw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46fkwgg2mq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 14:31:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 546DEoiZ035964;
	Tue, 6 May 2025 14:31:13 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azlp17010004.outbound.protection.outlook.com [40.93.10.4])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9k9udr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 14:31:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5TJOvZREhqkcGLG8pKWkh9axEYDylWWi8ZH5T/Du+gAvavT+RLOq4g+TjU1UqTL4Wexm6IGC95bLhsx3N8X4TywDYi4r7ZqEDbOaibEq3mZ7YAFK+xdS0MgKko2vnxqbDG33xPKE8cXsRjpBMLkunmpnBIJ9OHNrw+xxLvMmqUaLFWAWgkzMq0EktNFT04PLPPlY7masgvFQw0i2mRAhFr4F5vWF1Fq9YV7tt6FUz9O/EqPMOWAEcOuW+UJD9o58A2l8tGJ1j/st1tSryhMeNMhya9KnAc2tHznS3lFLMI6nTbu28+45Kx2HgQ5w65v4alOLJ0a3jTbdgXWMNJ0PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=miDAFG9DclI5UtZ5+zx+ZycL8vMQpayG9vXJv1sVaKQ=;
 b=c3UbWrkKRsyS9EEZf0bZYDvboCch7k7rOcHl5qES9gPoBSrlCI4/bHFbJuZYvX2hF98QsnlnT5Vyj+h3IOxfVRMw9y60txYoL63tMcJOpXhM5NOBzTo7jf6IsDoDTLAtWBDVOlwgvwDK+UyDKI8r6qfbD4kdoEIyH3EF9ETRPKjIQ4CBxZeurs9rmrtesRmIZthDm+P0xasGHyxRm/lHtCQHCbmkcpNiYQUsnmwVczyJRT94WZhxwPhubCb1pwqB2bw7gkCVIvss9L5JOmTIjP+bMTGYMN6punUUiuyG3Lg9F7rOrKzYEEs90RTZuUpQEu7PI7uzxITOmpNW/ppZTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miDAFG9DclI5UtZ5+zx+ZycL8vMQpayG9vXJv1sVaKQ=;
 b=teQmAlyfKrRN+WOAsa6xrVsLKmOigqkMGLOCKkYqjL+WIKvnVXGVrt6X4RM5fA8JcgO1vY0aSGLXoAllLlYSAhIaW0cG/8d1WH349HOjqvyl+tnnL9utnPg9o0xigmNh6A13C8cEKHNmDPEPjN4gKK7AjwwYzNdHRV0luX4GHk8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6898.namprd10.prod.outlook.com (2603:10b6:208:422::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 14:31:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 14:31:06 +0000
Message-ID: <8094c0f2-3f83-45c0-9b1f-0cee682997d4@oracle.com>
Date: Tue, 6 May 2025 10:31:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: kernel TLS configuration, was: Re: [ANNOUNCE] ktls-utils 1.0.0
To: Christoph Hellwig <hch@infradead.org>
Cc: kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-nvme@lists.infradead.org
References: <oracle/ktls-utils/push/refs/tags/ktls-utils-1.0.0/000000-c787cd@github.com>
 <32e4bd99-a85f-4f53-94bd-b8c3ecf2c66f@oracle.com>
 <aBoCELZ_x-C4talt@infradead.org>
 <63b16277-d651-4f37-9e32-965dc6d1e7b0@oracle.com>
 <aBoYDS84d8N5STLq@infradead.org>
 <fb8862b6-97aa-43d0-882f-f0ab9f873e16@oracle.com>
 <aBocWAKRbttPeStt@infradead.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aBocWAKRbttPeStt@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR08CA0009.namprd08.prod.outlook.com
 (2603:10b6:610:33::14) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: efbc816c-3d51-406d-2bd3-08dd8caaa2ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MlRFbUxiRmFpSEw4QXZiT3dwbm1zM2U0S0RpbTNTZVA4aUpoWTBwKzFuZ2xm?=
 =?utf-8?B?NkltbE52QlpGUU5UN2FhUGErZHpxdHNTZFpUTGtOdWhmYi9FOURhT0RlamhJ?=
 =?utf-8?B?UDZESWczRnJ2U29pNzd2ZjNsSGxPSjlmaFlmMjltam9YZ0lMYllYazA0V2pE?=
 =?utf-8?B?MHZMc0tFNC9wZE9JRE1teXJFdDRCdEpoOUg2ZXIwWCsrTlk3V3BNenpUQVlL?=
 =?utf-8?B?SnNRZGJtdGF4ajFoUnRHY0Y4ZzlVczdyRWZjbVRBNTFrQnNtSzRjQzRub09E?=
 =?utf-8?B?bGNxcytvemcvdk9taEx1QUtvMWZRZklMRUtyNktyTkFOdGdsdTNIWDNVbGJj?=
 =?utf-8?B?aDZGbGhKVnNrK0JUYVZxalhDT0JQS3d0SEFkUkdWVmxRc1dwQ2lkYmlNeXhV?=
 =?utf-8?B?aklkNTZlOHppcUJtRGNvWjFLSEZSM3ZIQ0ZtQXcwL1FvNVZ0NytrYk1uc3h2?=
 =?utf-8?B?WUsyeHBwNDE5K0pKZnhBRDNHcitNc3lsUEFpQk1LWk9DZkgrOHh5WjFrWmlL?=
 =?utf-8?B?Y2l1cjh1U3VSQm5aT3dPSXhYYXdMK2R1N3JOWi9FcG00eEZQdm1keHFQaTdy?=
 =?utf-8?B?bUNuZlhuWlFjR2QrbVgzNXplV0VpL2NRNW8zQ2c4b0J6ZDdmTnFuK3RCRGxr?=
 =?utf-8?B?N29pVit0cEdUM2h2Q2dGaFhmSnpMTCtYeHFNM003OUV5MENJSjcvTHlhWG11?=
 =?utf-8?B?OHZMQmY3eExQYi80NTh0clNkalZ1QzhnM2hRSm5rMzg4aHEyMlQyZGlFV3Vz?=
 =?utf-8?B?UzhDTmplWXY3a2JRK2lUTmw2UW5DcUlTZzRtR0Q1QmJmQ1FSUUJxYlNRd05Y?=
 =?utf-8?B?M1JkZUUxR0F4djRxQTZlb1JES2pydkV6Z1FXZWlKTTQ3dkZLNm1RZk1Nb01G?=
 =?utf-8?B?cUoySW5FVUw5dGtZT0EzTUR0b1J0U1Y0MHNWdlI1UkhvWW5CcSt3bWYxTk0y?=
 =?utf-8?B?K1Z2M2xWTmZOa2szM2JDVGZkcXBzOTJXRzNlNEQxOVdUblVJQU5GYWFSbTVu?=
 =?utf-8?B?V1R0NWkxQUlQTUwreG1WZlVweGVLNWZHUm13TG53OCtIbHppWmpFaVVlSm8r?=
 =?utf-8?B?TldFL1ZqRUFVVTRSMGdTdW1iSDVMOWFoZEsxZ1VXa1FWaEpuQitTY29kekFM?=
 =?utf-8?B?cEhGUEN4V3JQOGxmL1pqWXpYSjBqLzNBYTNEalN3cWJrbEVRb0xPMmFRaitq?=
 =?utf-8?B?VnJtSmtXZDR3Qml3NDlWY2thU0hrQTNzeitFUnlBSUhDaStpaExsTGFPWkdI?=
 =?utf-8?B?S2M2VWVsWGtaNTQzMXh1dkNMd0JpTWI2aWd3TGhNZzVnTGtkNWxXUWZBZ21m?=
 =?utf-8?B?czd5UDJWL1BGT3JhZC9LeHNLWEpsNDVpcm5DSURVTnU2bGxEQVFhWUYydHlj?=
 =?utf-8?B?eHZyMnRJWUZUcjlkY2ZKNUhSRmlxOGNidjh4ZDBLWHc2L0lmSjdFTis0Vm5O?=
 =?utf-8?B?cngwL0xWaG9rTCtDdlJ1VzE2U0VxTnR0QU9Yb2sxSmpydFFNQnZuUUdtaXV6?=
 =?utf-8?B?eGZqZjYxZzNGL3RpVkUvMUx6UURMZFpPZHcwRXhZZTRGSlZLa2FqUjZqZkY2?=
 =?utf-8?B?ZWZRUVJIcEJWZGhEZHNQTXRIdUw0T2NmdGFmOWVFdXZtY050WDA5WElnM2xG?=
 =?utf-8?B?MnRQZ0pac29jL294S1hHZ3cwcDA1ZzZ1MFRkRjNWRURQaUtEOXFSbkp0ZUxi?=
 =?utf-8?B?YTBPQUZld1NreFBTcURmVjNFV0NhUzRtNFd0dTZsUWJXYjdXaFVpTkJCcGh6?=
 =?utf-8?B?NmZWZkZnT3pmNEsxTXQ0LytBT1Z1OVEzNmg3bmg4TmdmRTRQUEluQTJQQXdN?=
 =?utf-8?B?SlJvUjU2Nm52SXhDK1JwVkNkQ2dUQi9GQ2pPbFhRMkNwN1dOWTVVNzZOcVY4?=
 =?utf-8?B?UWJhMmxpdDIxRWlteXRLdTI5aTVIQVdLMmFuOTRoUUhJdnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dSt6dGxQY2pNK3Q0a1dDV1oyU1VYSmROZ0o2S0pzc1NZY2ZVODRkTzh1dXF2?=
 =?utf-8?B?TE1iV2s5cWFpaysxSXh6QTZiVFFOdFpVTEJaQW5OWjFlY2tEN0pSbjQycGRi?=
 =?utf-8?B?cDN5MEVyMDkyNUFZRUxCcmZNMUxPV3VUbkYraUpLVWNPODE3ODZOZW84RlE0?=
 =?utf-8?B?eXNOSFpyTFdpcWtOY2J0YjdERUpUTjN1V01yVm1FQVZENm14RFVKSHZEMHZw?=
 =?utf-8?B?dHg3NW40UDRwVXpFdWMxVXpmUWk4UXc3WklocFZBNjVnYTJ1SUVQVk1LbVdj?=
 =?utf-8?B?VGJJVmZLQjN6TitHVFEwbHJHWi96eFord3B2WjlPTGxTMHl6dGdHaWdNZ0dE?=
 =?utf-8?B?ZVZ6cTBqcENCbzdQQVB3OFJPZ1dkYXhmMEtkdFdreVVIRlRwdUs4dEcyQXY5?=
 =?utf-8?B?dnFBdENiM3g0ZWF4NmZkUDdMMzNpQTAwaSsxdytMWGs1N3VZL1ppNHhjY3pz?=
 =?utf-8?B?UFl5blp0L3UzVzVnQVo4ejBsTERQQkwyNWcvdVgzM2VMMGl6ZjZvdWlQT1ZQ?=
 =?utf-8?B?MW9SZ0FZUlR0ajdKRVZtT2RUZFk3aTRYM0hBSjdIUVNRVnFXNUdNZFllUVhJ?=
 =?utf-8?B?UjhIbFFWc2hVcjF4SGw3WVJQSm5kNVUxS0lrYno4azU4ODl2SE1OTFZKZkpv?=
 =?utf-8?B?NjVQd3o2NWtKbUFUanNpektiV2NZaWtBaVhFSEYxZ25Ib2E4SXc3RURjdS9K?=
 =?utf-8?B?TVJRVmF2SkREd1lUejV4c2pqR3BmQzBxUDIzQ1pQT3BwNUY3Yi9yNHB2dEFH?=
 =?utf-8?B?U3RPaTFWaHh0S2NnWTJNbzJrLzlwQmI4WG52R0pWVEFHaFVxZWpUOWEzSkdK?=
 =?utf-8?B?ejRkZmJSN2RhVmpxWkNzY2tUSXF1VjVSTTdiazBmZUdkajZiWXllYmxCbW9H?=
 =?utf-8?B?WW03eHc3aEp3c0czaDNnTUJYYUtpVTBTNkl0N1lVWm83QUFORXN2d1lROTg2?=
 =?utf-8?B?Tmt2ek9tN3gxNWwwYWpsNjBmeGpHb2dhS2FwdUJPN2hyRTZTc2o3SHhCN2tG?=
 =?utf-8?B?ODdjWC9SdnBwZFlSNmNtUndvc3Jtck1XZ1llRElhWCtwVFE2Q2NocTg3MC9R?=
 =?utf-8?B?TjRZZEtSeW9qZ2VmUVEvSGQ1eWZxa1ZjS2pQRWtBdXpXNDQvYWNiUS9vVjVD?=
 =?utf-8?B?WXFyNmZsOG9KVW5TZ0M2Y2g0emVheGY4cEJNcUxNZ3JIZWtxdEFIdjJoUmF2?=
 =?utf-8?B?U1A0SGNib2VCSG9nZEVDTnNHaHZpWk1HKzB0blBDWTVnekVmQlpSZFZlbkE5?=
 =?utf-8?B?OWZma0tOdGpNMUxhMGFYSW9XWURKdmh0QmxSek9YMFJtbTBVTkFTRUVtOHVB?=
 =?utf-8?B?amdrYkNUZjhnUjZDbGtNZmFHc3N4T1V1TEdFZ2ppUjNWOVBNeTNRODRPQWdC?=
 =?utf-8?B?ZDVVWTU0dk1BM2ZScEtJaGlreGFDSEtCMG9HRGN6V28wMkU4SXE4bUR0czIx?=
 =?utf-8?B?SlJZcDRrSjdJQklpQ2daa04vdUtna3AyQ3N3VVBBRTBBV1NCTGNHNVdpQVUw?=
 =?utf-8?B?eFZBcWc3ek92ZGVGb0NDd3h1R1lUK1hlQlZ4RFl2MVlFbDNVT0VNZjBMUDd1?=
 =?utf-8?B?b3k2OGRYVkVUazRaZXNQL3hZSXRsRTdKdTdJZWxQUE56OFc3ZHRhQmJ1UDVD?=
 =?utf-8?B?MER6UWFqTjc3UkpBdW9TOEhnTHBIVUlEZXlSbE5mK25oOUcwLzFHQVRKQ0dC?=
 =?utf-8?B?a0MwZmk5d3BySDJPVFp0cmJYUkxBRzdmS1BvWGJOUmFSemI1YVlQZkNpVkdX?=
 =?utf-8?B?VXpNUDVzUzBTRmt1RWtDbHFneW5Xb1RnbUZPK1RPOVB3MUNPQXR6RkZ1RXhP?=
 =?utf-8?B?MkdUU0hmbTV4elQwcFNtN0JWWEx5bVU1TXV3T1ZHOGlGdFpKMG95TUpTd1hR?=
 =?utf-8?B?bzd1Ykl5SzRKbGNRWGVLTSs5OXNST3BDblNMWUs3YUpQOG1oeEphYTRkbGIy?=
 =?utf-8?B?SWx0TXJsdE1xOWlVYmx0d1UvUVJXVVZGUGd1QUwzS3FrV3lhSkI3MmlCUDhw?=
 =?utf-8?B?bU13Z2dvRTVHWVB4U01xLzdQMjZ2U0hUdzlkVXYwQ0xsdHdpQ1ZkMC9PL0Fa?=
 =?utf-8?B?OCt1aUMxS3E0V3lvUUU1czk3RzIzVlR6NDNTS0ZObml4Wi9CejdGUmJ1YVNx?=
 =?utf-8?Q?Uul4REHu2Nt1WBSsN+p2XsboS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	e7tFid86KqcN8utABIx6KcRyVI4tGWtTATTiffHGmgyrnlFvRZ/DF8TSXfYSCQGwNBujtTFaKG0xcw1Chf8hyDZYcDqTSw9zaHmXrLarBiiLWyEiwUBg+P80Ez5mfsMd5vi8WFDj1S04Krljh70c/rwRffJ2gQxiLH9GgKnRQKpNYvReFajz3U9HTENmvnB7d6QqHm4xj7AaAOs495L1A0YTPmsDp/GdPxtWTs2gfsEDtvnY3eqS9q4GYhd+QxE1M/98OdNCXLA6FMDvAfhgIIUo711B80DTOcI/578QFIb8hR0MfNeLhkHE+1JXA97S5K1GjHLIBzXURVOvH5xtSQkezWvR/xjqUxrABXvaCFxt9pmD6fwTIg9LiVJRYSS5EHoLihj/8ckp8k0Dz4U1wFByI+PetJUWTsLZaVo3P8oRIzQsSOIZQMwfkzDLe6I6lUMDmpwYIje/DQkjUOqz08JILAI1z+tmBSHGLpFdcqqLsuJ5RfoyDPbA75Hu/IMxSWB40P1n96KbtTuX+ku4lPhhsojtEBgQrHr8mAvz0gqPG+OiRw4fqmUdsyJSwXTHrXpqLxEjm5TvD6s4R2W7f288r7ZJktNL1HoCjehqkXc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efbc816c-3d51-406d-2bd3-08dd8caaa2ed
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 14:31:06.5145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gt3gT+EEj5wwt84VA9PYcQqRlkGuXqp8ZKzaNV2k9tXlYiPpcOfURNINAOdcap73C7DF6afMtwkkaTIBiR7NTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6898
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_06,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505060140
X-Proofpoint-ORIG-GUID: zPO1QkRYdky3HTKg25Fc7mrIthIxpYc4
X-Proofpoint-GUID: zPO1QkRYdky3HTKg25Fc7mrIthIxpYc4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDE0MCBTYWx0ZWRfXyCg986eg2kM/ YOJwPycvZ2miFAT1nYu+Xu5HywGzDqIwg/8JEMnQxkJ68J/kh2e2vybjOlFPlJQawmCW3KJpbXM 4XqhybjI+pNLF04gulm+LOqnRiwRqo/K7oCuwYZxglz6o012MuWdUi6e5eMKgqGP/KeY4IWjr/0
 qVIguojA681IbXu0aQSrNfImcr8gj1xnf4NOUrud3Lj1J2ku4/egXOzCNBBPQHMRez13FVy0J2S FT0xwpgNKaELqR8SQ6s3gJdQfk4dkCGHKQz5zkBre1Aif4O+T555FDpysKJrCzRsHV+GPGrA88c NLHHR4gWjgkpSxlFLSLfHHNen3fNzLZ1oVjtkSWLRu5+Q1l8QL3u1lv2rpEy2NQU8CBbypgQGFS
 SxOxRPVKSuTC4apW4MWepQxcWhu3WKlqOyLVqqMgLyRU1z9mCv9pOAuAu03ie7eaavCuBqoN
X-Authority-Analysis: v=2.4 cv=ULvdHDfy c=1 sm=1 tr=0 ts=681a1d32 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=zZ3GRdDi4hRVQEjawgcA:9 a=QEXdDO2ut3YA:10

On 5/6/25 10:27 AM, Christoph Hellwig wrote:
> On Tue, May 06, 2025 at 10:17:48AM -0400, Chuck Lever wrote:
>> On 5/6/25 10:09 AM, Christoph Hellwig wrote:
>>> On Tue, May 06, 2025 at 09:42:29AM -0400, Chuck Lever wrote:
>>>> are very welcome. (But you do have to sign the Oracle Contributor's
>>>> Agreement, unfortunately, to get the patches into ktls-utils).
>>>
>>> I guess we should just for it, which would also take care of the
>>> musl support?
>>
>> My employer might not take kindly to that.
>>
>> The "MUSL issue" isn't due to the OCA, directly. The developer got
>> agreement from his employer (WD) to sign, he just hasn't gotten around
>> to it.
> 
> the point is that any kind of CLA is completely unacceptable for
> something needed in the core Linux stack.

Agreed.

> Someone at your employer might have smoked some really bad stuff if
> they thought it as a good idea

Note that the OCA is a blanket policy. I'm not sure they thought very
carefully (or at all) about whether it is appropriate for this specific
project.

Note also, we got this published two years ago as an experiment. It
certainly was not a "core part of the Linux stack" at that time.


 and I don't think anyone gives a rats
> ass if they take it kindly or not.

I do. I can't burn that bridge and stay employed. So calm yourself,
sir. Let me ask around.


-- 
Chuck Lever

