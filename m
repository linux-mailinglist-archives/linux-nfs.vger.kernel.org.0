Return-Path: <linux-nfs+bounces-11817-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F77ABC22E
	for <lists+linux-nfs@lfdr.de>; Mon, 19 May 2025 17:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 953111889CE5
	for <lists+linux-nfs@lfdr.de>; Mon, 19 May 2025 15:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE3728540E;
	Mon, 19 May 2025 15:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sMvlevar";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i8GmoM8Z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119552746A;
	Mon, 19 May 2025 15:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747668049; cv=fail; b=FOqee5lpO9YPkFqKsw26Okc07H9RI7DRIY3nKkuRE3NVfpmOPHW/J7q2DVrcNm8yzn+n7RE76RWcRmFX/GwM4T3hoEAFna8dXwwnAzwy8oqY/PLsw5dum9f88Ge7EPGllwpOJWRcBiez/gpjmAkBxPNCwFiKBSVYmkhS6m5m//s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747668049; c=relaxed/simple;
	bh=PCOErtyPLHnSiQUEVyBOwGZp+damht4ITsgiCVq92PY=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=bDj2ey12MNhWTPq/BUTCHoRDu+FAr+oHQBSyVB/ZOUVEgXrbELvdS2hcdwOPC2sDr4/YmOthWnscjgujzu9OKsm+PQ1WNsvaNWxpn87i6v0wOb3NldN/+ZKrzthaD6Gv6QOtrlSMaeucMd6dddyuFpCDZKGtrG2wGnFl5TKA9xM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sMvlevar; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i8GmoM8Z; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JEW0Oj012741;
	Mon, 19 May 2025 15:20:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=C7ulnFo1FZOPiLok
	MwcD3ffZTpopvrMa8Sdvh1vGoGQ=; b=sMvlevaroZc9cqO2+Her2XUVPW1yIazH
	Kp2VOJIl2ES/4J3bQHkpid1pneAnfqXw/ZFZ58uN2Xouab1+Nx0hwC4rhi6hDrs8
	xJQIC/4XbJKtas0U4UGKG3gxytWC+cu5wabfBQCuzUueRVdEqefWCrM4WfShzJRH
	mQYcSCMSz0rPNsPujSTMCseZ1oZKTimD9BLBAmonPNMLtQyZVsuxUKo/daPOWiu7
	+s1+3t3+m7CGPdrmI5qgPUh3/U8QEWvttWfryGN8WSD+Nrck8lhJ7+zz20tTmDMx
	7NGwQFDihKqTNButGFSxAI4b1DIemyI1vK8rPW6eMyRqfuGMRYQPwA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ph23bav4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 15:20:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54JF2fWW000867;
	Mon, 19 May 2025 15:20:45 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw6uqgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 15:20:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bcWk8s8C1l3zA/H+EkK+yBhoMI+nJqSTsYb4IYBo1DtiQEY0iFcGS2LJS4Uc7FFpUFmv56yNjIJZtx/qbmLh3zOS4uwwOLpjSkDZV+tFtfk9YtzB6vAsP3+VENJmp2Ui3XdyQN+AllTlN0m0QuNj22kyEB+2KuD0pDBdw15Di37aKjJARNAUs69JPpZMGeWibSoKsWaWMP4PuV46oFOEpBjs27GH3hGYJ95scjsmmqb04MH1Wxki46m1fG7smGHNWfLXnqJBnEToHpR/EI44WwOaUiEzBRst2VR/P9+5y8fHRIew2OXa4nw1Moe02MaQQlYnigXIj6+J3YWwjV9cpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7ulnFo1FZOPiLokMwcD3ffZTpopvrMa8Sdvh1vGoGQ=;
 b=DBXhIHdGQgAZJF7Rmh0DryyZaTKPHRBE1Bcia7hCI7o/y2Sd0Ap4AH3cN6HvWlmQwL/Yd2j5PiZHYc1aDkzJ8SJ0YhSNv9QuFXiUmL3xa9mhPuY1pj3c6d2P1BCEnEqJiKhjDqWKuoxSjIchs4T/W8IVj9+LJNpYK0L0vbKeTdxmIwR/98R0/KvoeZI0Omuxaehau87lrdUnUFns/AI0I5Fb48EcfLuriBCNDQogwH+bw1XCj+VY74Jy9AgtJjXqjbV632nOBIvgJgU9fxvUNTBKctwHenN4CQxU0KZPng2mwwDyBZN/33dHvOtgedeq2g49DOOUJ4yzOXm7GrOMQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7ulnFo1FZOPiLokMwcD3ffZTpopvrMa8Sdvh1vGoGQ=;
 b=i8GmoM8ZcvosyLgfaYQGSPOFeJydkqQnS6jhtQLXGj6qvaHbYWCKHpHRPJzn/vBy6207uppmuqjM/HGzhens4YB9wIIbySY1t+9s1ZhQVvctlgt9U8O4CRBMSKrTW8x6wO+/hrJ5O03q2veekGI7C2oZlArc8hcuvHmL8ie1Tj8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5061.namprd10.prod.outlook.com (2603:10b6:408:12b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 15:20:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8699.022; Mon, 19 May 2025
 15:20:42 +0000
Message-ID: <2d9c6d1d-81a8-4c57-ba0a-40a2f5d5fcb4@oracle.com>
Date: Mon, 19 May 2025 11:20:40 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>, netdev@vger.kernel.org
From: Chuck Lever <chuck.lever@oracle.com>
Subject: ktls-utils project change in Contributor's agreement
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0259.namprd03.prod.outlook.com
 (2603:10b6:610:e5::24) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BN0PR10MB5061:EE_
X-MS-Office365-Filtering-Correlation-Id: 81480667-3ba0-4073-8992-08dd96e8b85d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXM1Z1lYcEJBbkFVekhkSEFOaUlUNGxYYW16YndXWWp4OXpBdjdhVWgrU3Fq?=
 =?utf-8?B?OHFyYW1MSlFRMGhhdTZ4U1huMTJwcm91eTBjVjI0Y1FOSnJJa0dUVFE5Q2lZ?=
 =?utf-8?B?YVhYMU8ydVhsQkZWeEZWa1BweHBadlpuSWYyaXdabmMrTWhsK0gxcTdpNjB2?=
 =?utf-8?B?a2w2aCtUNVlWc1JJS3lqeWw0MmFQb1hndnJMdDR4ZEdDdERKNnpqRVRsV3My?=
 =?utf-8?B?N1Y5TENBOWlWZ0ZFNUJmQmVFWjlTRUw3NzQ5NVFMZE9LWXFackZsWXRIby9z?=
 =?utf-8?B?bVo2Sjhkei90ZWVmVlNJNk8rN3F3SXJ2K1ltd2VteURjUWhJd2dIV3RVWC9M?=
 =?utf-8?B?bUl2WWR1bXd0YXhQMk5yQ2tWTWVqZ0dndVFpbjg1S3Q2Q3ZyMDNCWlRlSXRs?=
 =?utf-8?B?N3c5NmE5MkFiYXU2dEUrc3NmSHk3Z3prNzJvRDEyOXJEeEl5VVJ2SUMyV0xx?=
 =?utf-8?B?a1U2WUt6bXdxZFYvTS9GRHkrdC9RbHlZaFNMdmJiODZpL0xFNjhLODhvb3Ar?=
 =?utf-8?B?QjdJU0h4MUFZRWFqa0RqalJjMFVnSXkwWGJLdzdGdC9zNnhocmhxdkRrSWNJ?=
 =?utf-8?B?ekVlSld1c1Z0ZDFnU2FMMUptWjVuY0xORnZ0bmoyRDF1aTVkbTVJbjUrSjV0?=
 =?utf-8?B?SmhLZ2UyYnlYMzh4ZFVTWnlES21FVFZSVVFrVkFhS043OEkwRVpJTVZ3RzUy?=
 =?utf-8?B?SllXZ2xNSjYybnB6TUcyYXdLSEhFNW5RM3B4NVc4KzcwdnNaM3UyL1RTUjJH?=
 =?utf-8?B?Um83Wmo2VDhWWnpHaE5FRFhYTlJMWXFVbXM5MEx0ZWZnZENZTTMwWmpNdFpB?=
 =?utf-8?B?VFc4WWZKR1EyNGRkMmVkcmVoakVhOG0yRFFoTzJmYUMrdmNPa1p1Qnp1K1A5?=
 =?utf-8?B?R3E1Zm9XQlcrVGFXKzYva0Z6eTZtVlFGWERCc3JhaFk2aFlRUW1IcXZBenJq?=
 =?utf-8?B?VHgxY1JIWXllNjF6S1JHdldwUy8zTDJGT3hMVC9kVW1xUnFEUEZaSlVBOGNj?=
 =?utf-8?B?SElkaGpWbHlTZFBHWGgyZmRLSlcyWExIeVlDSmM2cmVQanlDMlF3dEZVbU8x?=
 =?utf-8?B?d2RGYUwyYkdyaVg2N0tQSW83Zldud3VJbjRsS0N1SmJDWGNvVlZ3SnNobEpt?=
 =?utf-8?B?UkRGd1JGdm1jZ1NLYWFhSGx5QVNpQVdKd0tOY2YyTWNlM3lGUFB5eEFGbWp5?=
 =?utf-8?B?ZjhKallRVURMSDN4dW5uMkVMcnlaN29tQ1RqS2VoTko3WDVCYXFib013RmRY?=
 =?utf-8?B?L1oyaFFaclQzbCt6OXZvWDQzZzFSSExHS2R6T2xHYW5GL2J0SjBnbGtZM1ZT?=
 =?utf-8?B?U0tqZHZ4enErcjkxV0VTMnM1dVluVDZtSUs0VHZMRDRubC80WEg2eXFOL3BE?=
 =?utf-8?B?cEh2SkNMaS8rMEg3cnFER0JDTlMwQW5VeWtzZW1iSWRMZjFqUEY5QThVQnFq?=
 =?utf-8?B?SWdYbUlUdFQvS3ZqaTQyR1lrRUFIOW9pYlBUclRJNTgyZHdHc2krM0s4djh5?=
 =?utf-8?B?ZFJBQmdoY3plRzlVVzVqS1NNcHQxWHoxN1RKL3J4bWk4ZkR0RnMrS3BGS04r?=
 =?utf-8?B?akJJSExFb1dEK3BybjV5aHZXZXpnWmg4cGlVY1RHQStlOFJrMG1iOXZNSWJj?=
 =?utf-8?B?N05tYzhvM2hsZTBzWnZDRDlBNDNyeUxqM0tzb2ZEeFdxdCtveWJQYWEvOWpp?=
 =?utf-8?B?dFVtOStZbmF2elA0bzA5TnphRW82bmdWOG4yTTUxZmFxMHQ5V3BjNXRzT0sw?=
 =?utf-8?B?U0J0ejB0YzAyVFptK0hzeVpJaTVwcTk2b1JDcTRPVzhhNUVibHhlekJYcFFh?=
 =?utf-8?B?eS95akR0djdwTWFUZ3RROHlFSEd2b3RySis4NmRBN21pdTNpYnloUThIZURE?=
 =?utf-8?B?REpoaFUranNYeFZQVzNzaERQUHhJYUYzcEJIK0IwbVZUU2o0OURGWWZKeE1i?=
 =?utf-8?Q?MBzOkbZTewM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEhEaUc4QXhhTGpTZ1RHMEpnd0EvU0pob0dnNWtqY3M3dGRqVnZQQTFDbU5u?=
 =?utf-8?B?ekE2bHJNcE5pNFhnNXVDbXFDTVhHeUVaQU9FRXNjdHdnQW1QeEdDQmtiRDZj?=
 =?utf-8?B?WkVDaGpzKzBLYVZqOVNQN3hHSCs5UFZEUFlyMG9tR1ZHakFnczI1OTBsbUZL?=
 =?utf-8?B?Qnp6WHBRdlJUcHFiZDYwbjkwcldKeVRiQWsrUUl0TTFjNG92NXpNNHF0cWF2?=
 =?utf-8?B?VDJHMzRUUGEyNXorTjQ3bng2dWx5NHJKbEVPTlR3dzdOYnVsSmlQWTVQUldh?=
 =?utf-8?B?YUd4NGlCOC84MXovb0RsdVc5THp0Ykh5VE1abyt5bndCcFVNL2M3ZzlveS9T?=
 =?utf-8?B?aXk0dGorZVZXMTlveEdTYWZYZDd2cEExRGY0ZEdsY1ZVdUFydTdmMU1kZHl4?=
 =?utf-8?B?Q2xqVUJHMyt1SEdKTVdTY04vM1MzMnd4TnkxQSs2RDBLK1ZJK3lDSTg5MHNF?=
 =?utf-8?B?VVI3TU16eEdpR2laQkFtZHpjMS9VWXBzcXduMUo4UXN4a0N4SHMrTUQvV0xo?=
 =?utf-8?B?bnF1bnZ5V2Q0K3RIc1pYWkZGcTFiclI1QWpFMWNMYWVHUS9HbFNvMGprZEJs?=
 =?utf-8?B?UnJHWEJvQlhzTy9jbGFkcjJXaDFaUnRmYmpyQ3B4OTZRYTdlcWJXbXhNa2Q1?=
 =?utf-8?B?LzJsd2M5TElacWNDNHNJd25zOWJXUnhNT1JkSXdzb0FiODJaaWh6SWpnWHlO?=
 =?utf-8?B?U3EvYi8zZkdUdjlDNmVacHdmckx0bHAwRHBvTitOSWlKeVdKalZQT2tJeENB?=
 =?utf-8?B?WHpRd0xkU1NZQmpLSGs2dE1aaHlhWWwvM3RyOUpKQk5HdVVqeHI1WWlrWGJh?=
 =?utf-8?B?c0ZNcG1FOThOVjJEa0VHMml1dG1SVHkweWFuOGRpb0FkL1RZd3Q3eElDZWNQ?=
 =?utf-8?B?R29OaHUzTC9WZ3JnRnhVMHQxekVzTWZhNHhHMFpETjJ6V0tXendBZFZzVFJr?=
 =?utf-8?B?L0FKYldsR0s4MzE5eW1odERUSEhNTzk1ZHJ5NUVxM1BJSmxLWVllNUozY0dL?=
 =?utf-8?B?ZjlTOUs1VlhQdTk0bXVqeHpXSmJldGcvajJVV21EQ2hNS2FlSHFjUlRtWFlO?=
 =?utf-8?B?cTVReFVud2ZNdzU3eWhQbDFka055QVo0dTRCQ3BnOXltV3AvVUdQT1dKckVt?=
 =?utf-8?B?N3hVZjB2SUI0aXBTMVRWNGJJMzA4aEVadktNTWkxMzNTSng2ZWhsaFZ2WGNB?=
 =?utf-8?B?djZpejZJeWpVYlhZeDUxUFhpZlFMV3FrWlQ1SjR6eGJJUEgxbEl2aCtkSEly?=
 =?utf-8?B?OFN6QW9GditocFBzV0FJUVlGMytsdldoRHFQcmN3YnhrcEF0TEZaalNxaTBP?=
 =?utf-8?B?YytPZ3RDUnBSTlZNUEs5V1BXa2JCTVdaVXdvMjFOcEVuUjI1SExqMUVoS29h?=
 =?utf-8?B?ZHRlNzhtSGh3bWNvQnJQaVlQeFplSUFoSkFrN2lMa3NaazJvOEhjUWdnbDRX?=
 =?utf-8?B?ZnBRVUhDcWNQbWttUUFlVE5qdERzZ0pnQlExdEhZM21LTzZnZTJEeHVBRzEw?=
 =?utf-8?B?cS9aQWJwNWFuRDV5Z296dkRKWTFtbzBnaWo4ZXc0NzNreE1EcGRoTVdtNng2?=
 =?utf-8?B?ME9kWHlUbEFxcGtLbUdQOThtTEtCWTUvSEZlWnF5Vlg5M090VUQvajZSZkdX?=
 =?utf-8?B?N1NnTmpHN3RTdmswOWRZeFlsWHZ0K1YxbGxsKytGMUJkRDFMVkpNQWhucC9Z?=
 =?utf-8?B?c3pxVVFCR1g5MXFYMk1EUkhoN3poV2loT2tvRlVaODYybEZzdmxXOVNweFRY?=
 =?utf-8?B?ZTJ2aEc3OVBNUDhWamFyYzBlWkpqczJkOUFpWUV6N1pTVjVDUU95QUxLQktH?=
 =?utf-8?B?ZzNJVmlQN01QVVdNdlBCU2JQVTNUbjBZZTRpMXY0Qlh0T0Z0WForSzlJTXZC?=
 =?utf-8?B?Mk8zSGVqdTF1bTJLclh0QW9ETHkzNmdOa0pTZHJmb3Y2UnJ5NmMvZWl1OG9P?=
 =?utf-8?B?OWYzRnZoRkFOUHN0bzRTYVdNbXBjdHhUbDVQbDIvVVlVYzN1Vk5NTm1LNS9z?=
 =?utf-8?B?eHNGVFZlcDI3V0RhN1pLMmFDUU5uSWl5eDRSZlFrSUNaNzFweUFFMHV5OG9T?=
 =?utf-8?B?T3JLYUt4VWloMXZxVmdIa1lhYlZIUmp2K0NyUEhGbmRrQXZENDlqS2kzdDRz?=
 =?utf-8?Q?/RKimBsjCZn269w8ma8LmY9iC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2QTNNGE/vxyRa3+U7Zv/uPWG8rhlj39/dhXLcAjXSzdylXw7xgYTxr41ufUVtTATd53yQ1+YX8tz1xkzNkeyh46mmBXb13U26AxiKyL+3dMo8X0YQSZGYDx7Pifdo36LEXpN4JYeZS5UIZI+hvXFUod59jSBvXJPQPA35eeOdnnCSGaAW8bGREVIWRSSsxypAPFgVCZQxRQbX6dm9Q6z4ZmfMDdTm1cXsM6S3HcI79f6EHSgNo9H0NnVOsi8dqe3mUUP4I4E+4J0/di3WOppCVFsNg+9NhYvsoWtyKoGM5KuGiacw9f7m4C1yn2hFTV65Cc8/j98MC5DLgYuNZjymQUcqQYrdIZYZnLwz1m8hG7WX3ryyjezJYMWkpYpPJ6dJdCpME/ABctWXjjL1YwWlK0IBcMVUYNadQ+/LC8G8zyHWp54wAOsEEgwBFw/Kny3arNcapso8yogJ6gnwCBOGYXp5+QdFn9F1NNdRSgSX53do2qNxd+quBzrtWpIReJVBL3ichUQDm3QJmHrou0z0Vq6wx9JpQGtG2y4HrYDgSVf8rIQ1RfEp/f/dx7SvacnCkefKaFpsw+mf7db9r14N6GooAAZTNIPLGtxuXjxHEk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81480667-3ba0-4073-8992-08dd96e8b85d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 15:20:42.8015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SnuQHFlGCSaLsxQgNnkrSqd3lCx7eMzkPzsI/9ouQsSM1vEosA+lbk57QjD4/75ZFgQZ+J5qeg4swgDBzQV3NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5061
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505190142
X-Authority-Analysis: v=2.4 cv=GN4IEvNK c=1 sm=1 tr=0 ts=682b4c4f b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=LmBSOkPbCE9r3YAc-qAA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 cc=ntf awl=host:14694
X-Proofpoint-ORIG-GUID: txrpexAvViQalsxFH70f6IR2f60aX7EC
X-Proofpoint-GUID: txrpexAvViQalsxFH70f6IR2f60aX7EC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE0MiBTYWx0ZWRfX1rn9fRBSEdX7 2HjsEioqZXjcIOZoj4LqquGRxsbVcvgwwglObEb+FWe5LCq19ph12D/2EeJjm55q9aCPBYRmmrt 5pSUNEkfxGtwSzzktEfYaOOU3AeAU6y2rDXkwJR2FYhT+nPoKXM6O7y5C2K0we9PMkBzzaF4oJz
 E0XsVdWrVGO0kIl5Wcr/7e2X2+08ct9cZ12qyv5S037EDFDu26wi9W8CEsuTAc4BY7NX/mxO30j IAhF4uqi3V5BnCQCwRmojsMlHltyASi737PBlKERxKQJ7aXEO9xeW49ubHnhw6Dj/fEThb21vQz XE6wTKu9+gfHp57r+l4HhRYYys01FBzJHAG0N7djQ2ZJxnx8QA/GLPt1ggZJH+hzepm3Y9cDE1O
 7wLo6sph4hYmEYC9hqqYlGvtDygxlvxfY6HZ1nmQfSqVnrsjZUPK0MT3e5xgB8K7vG/VwYOO

I am pleased to announce that Oracle has allowed us to remove the
requirement for non-Oracle contributors to ktls-utils to sign the Oracle
Contributor's Agreement. Please see commit:

https://github.com/oracle/ktls-utils/commit/e9b0b68439a497c3055f3be32aaf58e5a6765c30

The only contribution requirement is now the same as the Linux kernel:
an acknowledgement of the developer certification of origin via a
Signed-off-by: tag in the patch description.

This change is in recognition that ktls-utils has become a critical part
of the Linux kernel's security infrastructure. We wish to continue to
reduce the friction needed to contribute to the ktls-utils code base.

I thank Greg Marsden for making this happen, and many thanks to all
contributors to the oracle/ktls-utils project.

-- 
Chuck Lever


