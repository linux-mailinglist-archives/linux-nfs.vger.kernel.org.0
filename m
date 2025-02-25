Return-Path: <linux-nfs+bounces-10338-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A68EA445D8
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Feb 2025 17:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E27716F85B
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Feb 2025 16:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04B6189BB0;
	Tue, 25 Feb 2025 16:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SOBgID5h";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H9Krn8MC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3C018C92F
	for <linux-nfs@vger.kernel.org>; Tue, 25 Feb 2025 16:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500241; cv=fail; b=sH+N7HHBR4tDrEHY9ciXEmVu440tYI5c5PGnToeoppUINjpT0slVUear99DDBDy0SVkXLKpGzItCFn7s2fBYeoVkzEanbqZKejDDvICZmeHE+00DFhQG8il2AudL+sHvRbTYq9B6fZF900c3VnMJSyLO0jZKfKHm882MBVKMrVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500241; c=relaxed/simple;
	bh=t7XaCbG2065BUhFGxt8H5tOxoUTTd9LvTfC7hHqjYqs=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r3Y2GaqkcBP/vN6CKHq451Ki0QFBs4D7VPwq/ASi9CFqoZOjEMrL27kGQG/DXd3a5npQizofTdZVv/5yw+52H8zeTi65wypQhP1DatG9vrT7OajkQVH7gcHmeESTwiAossUqBzpShbf9wWxrFNNulGjy9Evy96IlPm7k6dxxvdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SOBgID5h; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=H9Krn8MC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PFMaH0006475;
	Tue, 25 Feb 2025 16:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=jp1XmE7jP4RaA6dwMUY8UEx+jFxHwHUNhFq2SbzF0nc=; b=
	SOBgID5hWy4ioKvvzkDqC/zwVOVefYNZFJGmOWmn6sm53EIq4Z2jmZOmhX3YH8Jr
	we/En4ci9Vz5YH3ovMRe3ntbwMrrmxPvPjuFc9QCANECoT3zUHYlhtY35JHL5jp7
	SIg1s6pgUyaS/FuA7K35hwd5gzWfhDquf37LOoNbnYFkpV7bCwBii7qoxz0ntXLs
	dLaO5hMgfg3bYv9uGOx/DW+UUlDd8xThI3nGn3U3ypaotsfEKqsMbraXMGCwlTn5
	381wPxXQPhUAoqG1863HPeRL/9XjV9+LmtavP32i4/ygYddv+SJ3KLTLCU/SrblW
	pvLXNfEFoMVQLVBfmaRYjg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y50bnmnb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 16:17:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51PFI6bl024327;
	Tue, 25 Feb 2025 16:17:17 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y519fahg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 16:17:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nKB8X8y4yO4BphjWf1Ge1J0sjhb6rScuvDfWuW14g3JwYSFVw8b/3fBlDvAn8D3uP9OFxLp9xF0p/js0ToYDJGcJaNDJj8TG5w3auyynGLAoYzRsMjyNrpWXHJ96DKpV5/hGmRk9DnfgpARbpt+vAI+dVPo9//n0JvbKjZ4WokkN/EfIa4bs+U1fM0LwD2udVuTgLkl0ubsOTU1cvoGRjVTTl1e4EPyi1ol2IhW/moHufXK43xZncppab/hUt51DH61wMrVeutI0n5tXYREDxTJVMfh9/17KnKHb+hD6EnTmy3gEUn/aWxf0dIjXKk4geCuRpW91Nos9+rmuUGDEQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jp1XmE7jP4RaA6dwMUY8UEx+jFxHwHUNhFq2SbzF0nc=;
 b=OIdBLRLAbvO1ef4lDmt6r/XzM8sjCVtZqJSZOQDQFECAb+DD6CWBPOm6FnjbDXr6fBHY5XPFkZ+mM0jTjA2loI7q1r/n+WYN6G0vwFJ6gb/eqZrER4i66+a+IpmXI4FjfF/gygcm4H5nl6cCGC4IUeJFOGOU8McaVzY6FKEfLTAMAW4kgRWRAPGfQVbf4U89owXca8zVk5mLk72nWN0KOLJ9a4xzqKQ00xpaXnHRAxJp/YeqhgzWtebg3UaWToV3F61/wGJqVK6O2hxE9Xia0YEOnyulMGqmWEN6WKLdm10WoY7cdZDC8K1Tqt4EEVdKOsNz4gpFcfam8uMTuB9IKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jp1XmE7jP4RaA6dwMUY8UEx+jFxHwHUNhFq2SbzF0nc=;
 b=H9Krn8MCxJU1iHLG0HrbQcd2NhjS5/Dthll5ud1eMqnFG5m5KCTCYTCOBzmTvo17vko9C0P03zetyHncokZMvzuDK6Ri+tiV7tGux8ELxcZFKADu2VQG5xyWMRghFSbB7ZhqnSnpz/0Mh501iFJLPeUfD/lGbxZN13qpGEca1ms=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB8223.namprd10.prod.outlook.com (2603:10b6:8:1ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Tue, 25 Feb
 2025 16:17:15 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 16:17:15 +0000
Message-ID: <8fe1273c-ca34-48cb-ab24-848f81648f9a@oracle.com>
Date: Tue, 25 Feb 2025 11:17:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Run 4 separate NFSv4.0/.1/.2 servers on 4 separate TCP ports on
 one Linux machine?
To: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>
References: <CALWcw=Gscd+3dHU81hhU0maH_v1R2ws5ND3bYR1WkdEESs4Cjw@mail.gmail.com>
Content-Language: en-US
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CALWcw=Gscd+3dHU81hhU0maH_v1R2ws5ND3bYR1WkdEESs4Cjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0030.namprd14.prod.outlook.com
 (2603:10b6:610:60::40) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB8223:EE_
X-MS-Office365-Filtering-Correlation-Id: 785939af-0b5e-43fd-326e-08dd55b7de1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUdUdkE3K1E1ejNLU213YjVjMjNIY00zYkFQZC9mUXB1VW8zZklhbUUwOHZF?=
 =?utf-8?B?LzA2WFZQL0FQMlRLMCtrZDg2S2NIZ0dNTVI0dDhETzQvb2Y0blFRNzEyN05s?=
 =?utf-8?B?Vk9xZ0ZyaHo2d1VUeXhaWTBJeDZyL3Jwb013ZDhLYWE5NTJCRTZENjBMb0R6?=
 =?utf-8?B?R2EwL2JwZkU0anEzV3FQZWVmbUs5cUFCMnpNOVNtZnR4Yi90eU1GTDZoN0tD?=
 =?utf-8?B?Q2o0RUMxWFlJcXhQWjV0TmExWnhWMjc3a0tVbGNDMDBlSmtURVdwQlk1Tjk3?=
 =?utf-8?B?VTl4cWxOL1c4MDBiZFFvRlVqZkltN1BOTmZ4ekFyZlBQWXRkUEJTMnpuTUp1?=
 =?utf-8?B?Yng5OGw3UmthZTdWeDNDcWRKQ2YvMUxoTmpURk0yRUxoN25Nby9maTVDTnBp?=
 =?utf-8?B?MjZERlI2aWh5N3BJcFN4OXFqYzArVU9ISlpuYWpFN1NralhYTFk2TXNFYVds?=
 =?utf-8?B?cncwRExXWmF1cXNJSWlmZTZRNWJyeHlSZ2dHcXpPUmdNMHZqUk1SeUJkOFBx?=
 =?utf-8?B?enpvOFlkK0xUNTZIS0ZSR1M3N1R2M1N6U1B6SzlORXZPU3JoWUdmeFFOd2Fz?=
 =?utf-8?B?VzJaTnZnbjVoWkYxSkpHb1QrUElSR2VLeTFtRnBONnhJOE5CMEZFK3BXNkM2?=
 =?utf-8?B?ZkhHdVVDbFRBVDI0VUFSMnQ4UUdvQzFoQ0ZuTkJ4bzVDYU1RMDJXbTRwR2VY?=
 =?utf-8?B?TnBSdXlLRUltN2JGTnhXNXdDVk9qMVdIU1J5RUo1SDVlSlBSSW5kMVFHRk1L?=
 =?utf-8?B?M3VLZGNVdmY5c2NBM1dOWUI2MWZyRmxFcEVSWDdLb2k4RDNwVDlSb3d6UGFv?=
 =?utf-8?B?ZHZ6TWUxS3dmRFVTdnVlYnZZbXgyTlUrL3lBL2hGUE5ORFpPZEJQMVRPK2Jt?=
 =?utf-8?B?SW5nQkhoVmhPb0xXUW1iemV2WitYN3p5cDlnTlR1MTczdDZaRVdoY1BBbzMz?=
 =?utf-8?B?WFh1R3dkakJiMmYxRWN6a2ZVQ2wza0Q4UXdtUVZXMFJ1R2w2Rzh4VWJMVGFB?=
 =?utf-8?B?ZEthU0tac0FPUlQvYlFTV0xXazJ0K1gzVWpDUmkvZGF4OE1MSi9hdW5jY0FS?=
 =?utf-8?B?ck02dTdQa2xodXR1bmN6TlBhM2oxT2NKalRrZFFyL0wyMFRtZWRLVEFaTWYz?=
 =?utf-8?B?MmF6KzBObmJaVHRzR2FhMlJRWm9JRU5NV0dEeGlJY3ljOUZKSldueis1Mncy?=
 =?utf-8?B?UWtYcUxaUFpUTytOTkxpdFFMNEhuMkl4OG52bFJ6VldjY3U4dFl4bXBzNHow?=
 =?utf-8?B?azJzL0ZkZUdHWHNqUkM4V1Yxd0kvRE5zQjVJODVsOXZRWWljb2pxcUZNQkp1?=
 =?utf-8?B?eCtQTTc1MnBmSFV6emZ4SXlyemY1NTRYUDVuOFNhUnBqU3RZNTk3UjFqZ2ZC?=
 =?utf-8?B?U0Y1MEQ5TS9aendSVkpNQm9Fd2pMV3pBdXJPblVLUTRIZmYxQVViWmxtM1VD?=
 =?utf-8?B?VGllRGx1b01LZkhTdUhQNXQ1SnJWY095V0NWcnZTcUFSUFpZUVRZc1dZMFdF?=
 =?utf-8?B?ODhJRkV0UlNpVVlpT3Z2RERLUGY4aStqV1JteisveGp0cTQ2L0oza255OWpJ?=
 =?utf-8?B?K09MYmQ1aFBvNngrcHpnYlh3T21iN2MrV2lpRkxHTzl0ZWNqVmJLb29IWEVL?=
 =?utf-8?B?b0pvc2c5ZUY2SVp3bnppcmdkSEVHWm9uZFdpS0E0dVhwUWVGeEdpcWt4T2ZK?=
 =?utf-8?B?TURjbXEvd0xUVmxGMXFrMWRLU1AyamFTTDFFNDJyQTQ5RHNBY2ZXeHFsYWdT?=
 =?utf-8?B?MzRTVUJhQ2Y2bHBoSlhlYUYzczN1MTFTdnd1T0ZIN0h0MnZsa0k5MnJsblFr?=
 =?utf-8?B?VUxxZnIvUTFDVERXYkgxNUczUksrRzBMSStDZ2VMUTFTUnVZaS9nVlgyL0tx?=
 =?utf-8?Q?7MwWd+HPh9fF4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bndVRTdUaXdaYzRudnZtT21RWnFqdGVaRy9kWW5ZdkJxRU5pOTVKWUREKzNk?=
 =?utf-8?B?d3VwR0paL2ZIRHFvZ1RZNlZFOXArbFhUREtBTGdsQkozbWdaK1BieXZ6ajho?=
 =?utf-8?B?WUVLRWZyOExCeWwvc3p5djZXRjFyc3g3Y29jMC94OEJvUzk0S0xGR1MxenVC?=
 =?utf-8?B?SmhJSHQydnNDWXhmN25xTmlMOHYvV3FQWTFUZmZYb0lGRm91OW1ya0I4dDMy?=
 =?utf-8?B?cmJzenRESU1MMWNwUUhwcU1rZUdWRVRoSlhhczEyT0wrUVRXbGtVMnJ5MzBx?=
 =?utf-8?B?d2w0Wjl0YjlacE4zbDJZTjVLODNQRjBJeTRkVGhFRnFkQjVqc29qS05VTTZO?=
 =?utf-8?B?L2RwdnMzRWhKcEFIbjlsREVQQjI1c2U3WGxncE1CYjRadXNGLzhoZkdadzNq?=
 =?utf-8?B?a1pwdnlVeERKcTl2OFd6SnhsYnA4YVMvZ1RpQW90d013S3Fka0o1cG16dXJa?=
 =?utf-8?B?bjZNbXh1azNuWmRockJtTGlRUUduenBpNVFML0d5TFhUVTdmZFVKV2ZSQ2w5?=
 =?utf-8?B?ZGI3TjdpdHU5N0IvcmV0eGtiMHowNG5RN3hIbytROTUyc3hYdkM4NDRWOFBX?=
 =?utf-8?B?U3hjMnVrdGZCTG5iQWN6Z3hzckQveGk1RzM0Q0dybk9iSnFzb1prK0FpbFlD?=
 =?utf-8?B?MFo2YmkyZGwzUDZpRi91OSt0MFJrRkgxQU1reXNDc2cyejZrMWorc2Q5cmhJ?=
 =?utf-8?B?NmNCcFFpUC9pL0hQcXpGZC81bE5VbFVuMGV2UWxoSGhEeEpscU9kZ3FZZ1BH?=
 =?utf-8?B?SEdSb3FRbC81U0xadmpZMTdidGRaWm1KRmRkckl5bWE5QkhuRkJub0tlRW5p?=
 =?utf-8?B?dXZUVkVab3ovbFR1dnRUejliamw5cG5DT3hpckFyRUNnd0xYUXlONGFvV1NB?=
 =?utf-8?B?WElVVUUyQ1NyYTRVejd6TE40L0U4dVZQVkRmZDU5WFR0dVBqc2ZSTXNaZXVi?=
 =?utf-8?B?eG5BU3dCL0tNd0RIVG9TQnk0NExHK1U0U1k4a3FiR0hDTWY5TVVERHVMdTho?=
 =?utf-8?B?WmZYbE1UNGk2QkhsYnE5QXNSQXo4NzhOQy9YWk5xYVRhL0NDeW5tdUhqeGow?=
 =?utf-8?B?QWNmM2RCeFJUVkFLQ0VWYXhpMG9uckRQZ1ZEc1JTaGk1YlhyeUttSWR0MEsx?=
 =?utf-8?B?Mkdxa3I5di9IdnlEY1ZpMjVCYjVjd1JhLzJqcE1OZ0RoR0cyRDVrMHJDeXBh?=
 =?utf-8?B?azlwOWJueldEV1lnRisvN1VnN09IdFdJVlRCN05GeDB2TUViQlJRQVdVSFJu?=
 =?utf-8?B?c0dOV05wbm1IY2JuUThJakdtUDhMcEpsMEtKdmhoTmxjSnE4MEZONUJOOHR4?=
 =?utf-8?B?ZVJLUzZhdnNHc1l4elZQVjEyVTVxWVV6blR1eUg0OC81OUhnZXlrUVU3aVlX?=
 =?utf-8?B?Rk9ZMjBEakEwQnVmZ3B4c211Q3AzNndSeWVUUDlSc3g0bm5zTk9HTksxWGFm?=
 =?utf-8?B?bWhKQlZhZmhqQmJZWDUxSkNxREJ3R0oyZ2pzRlc0bGJTSzh6aXpPZVdlb1l4?=
 =?utf-8?B?UkMreTRJZ1pTdE5qV05zM1lCN0tDOVNkTFIxbjZvUzUzTkJHSVJhTDM4dGRt?=
 =?utf-8?B?OU94dVNiaEZPY2lkMmlsak1sbGV0VE1PUDZMU1lrUG56eVg5b1NpclFXUmZp?=
 =?utf-8?B?WWFzcEt2Y0NSNFczUzhPNXVOYVR0Zy9lRmFzcXVHSFh1TlNuSWVMVlJVRHZ1?=
 =?utf-8?B?RStyVXB4MjA4a2hPU0srQTBaSGdEN3NQZnRsek04bGlza0JiekorbzBjdTNY?=
 =?utf-8?B?cExKK2t4UDk1K2FIbm1NMEVwbUdUdzFWVGxCMVNPcGxhTDBXaXVlNmtNV2Vh?=
 =?utf-8?B?Z0VpelIzUFlKWHhsYldzQXNtTzJEUUowZEYyandRdDgrVWZlUVVPZFhNaXA0?=
 =?utf-8?B?cTVPU29IOWtWK3dYSFpxU3A1eVdjVENyV0djeHJlWU1GSnRSWFZpNXlzeE8y?=
 =?utf-8?B?L3kxUG5DcVZURkFWRXV3M0pMdUw3VXU1T2MvNS93VitYcG1VSytzK1JPSUd2?=
 =?utf-8?B?eWFpZW9xaDBWY3VxNHc5SkZ5OUdScUhkWUVON1NOWjJ6UGkybFlINEdkS1Jh?=
 =?utf-8?B?aWNxNjhmL2FBN2NON1czNHY4TTVraEJXSndxWW1JaDgvNVZTWlJ3dmE1YWUy?=
 =?utf-8?Q?cNdzl9T+nhgYotw2E82Deysp/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	G+oxMzYpxu+6P1sUQvs0EMRFi3VzgTP7wTUz8NnDWZfYsG39wKGBEb7eq1p90bGz5Xhlb8xQyhu6QQUbLcH/SATJ417DNyU709i7u1J4MVE9BsIJRjDo2QlGnS67yXQPNswpXbQeXsOeW609Xv/cG8QL1vZZ8JFpoRtWRZ9B2PBpm15HVOV03xAXV1INND3OA1GRHf6Qt9lv1xhA1NDHeNRmQ7SAJGwgPrCVNKNYqd29k53uERzqdHDsS8MkRQr9O+baoeFgEDnMpZp3GiP5Z6H+YoQ49RRQ8UT2hukIXkEJurFzErZPEYaiEmnnobWns0xhptlQNxTl2cy2PFQjIQRdEF1E6ROBRbD+64rLpV/6Kw68Hw4t1zXISo8Ka2feA/7K6r1sJPXaY3Yz8aGuG6fSHcpXc1n+k4vu+nMPD31Clm23+luLEgiSKLeAjzCIM2hgL4HKahSuUzPwDV2C1jMFDkfERqJlrUh80aGsoeDOKDTj7TknXSL5FOAs7QpXSBAsaOzMioQ9aRl8C2tCdyVFukmyljyKdrxZenXL39Q66ciYAfYynZywEYk/GH8zfzD+5dgOgkGqlLgexigDmA9vf7vkKwOleMXDgqR5g84=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 785939af-0b5e-43fd-326e-08dd55b7de1d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 16:17:15.4655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YhUxxPLtt2aZ/Jmb0w9xh6bCPTqNQGwnbHxca9XvnyxGZyNj72f7kKeo7kQeSlSUwdrnPE89B0QEjLIyOXItkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8223
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_05,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502250104
X-Proofpoint-ORIG-GUID: bXICMguGWNHqm17BvhxyjrXvucPDSFZy
X-Proofpoint-GUID: bXICMguGWNHqm17BvhxyjrXvucPDSFZy

On 2/25/25 11:04 AM, Takeshi Nishimura wrote:
> how can I run 4 separate NFSv4.0/4.1/4.2 servers on 4 separate TCP
> ports, say 2049, 12049, 22049, 32049, on the same Linux kernel, and
> have a separate exports file for each of them?

This question has been asked in the past. We've explored implementing it
with a single NFSD instance, but it looks difficult to impossible
without massive code changes.

The solution we recommend is to run separate NFSD instances in guests
(containers or qemu). The host system might provide a NAT routing
service that makes the guests appear on the same IP address but
different ports.

This has the benefit of providing administrative isolation between the
NFS services. It would work well with NFSv4, but would be somewhat
awkward for NFSv2/3 due to the required use of auxiliary protocols such
as MNT and NLM (and of course rpcbind).


-- 
Chuck Lever

