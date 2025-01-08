Return-Path: <linux-nfs+bounces-8974-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC94A06400
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 19:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 343057A3CE6
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 18:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7182520103A;
	Wed,  8 Jan 2025 18:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T0KPaNuY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WChSwjX4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815191F12FC;
	Wed,  8 Jan 2025 18:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736359612; cv=fail; b=bLfv9QpOiElvfArtGvm22BvD1qwwxPVvFv+2iUWE90JFHCwvYl6qY2uXPsBR+Jiv+Poq38dUXJi/GGFqJfM/B0aSzH5zlcrGB0/yDoU2ZmDks8ARjsYzAXmnsfUpEP7aRjEbjoXdsz0ZGxCSqGhKS74oVF9OAvjGut38ASKWOtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736359612; c=relaxed/simple;
	bh=hKpLgXod8F38zNfaIGPXqNVilY9Us44MacRg5t8nANU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GONfU0gFbc+RArZbEkmdzqCsCvt42ojK6U2ZQ99omm8UcdhFkcGreNAFUzS0AZCYUTDos6wEjdv6H8lAnxzMR3Er9OB4p72Zsk3UAV/IsSMx2AvyyhjHK05ONSru2yUSrs71zO3xKw1bvidAsru+MkLDcUVYWqipW4J8c0Hqh2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T0KPaNuY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WChSwjX4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508HfkwR004746;
	Wed, 8 Jan 2025 18:06:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=0482AN/rho2p+PKLhXu+JQOBq0o+4ChyfYNPorHXEhs=; b=
	T0KPaNuY6rdde+1hmsquOMDNr0OC6h5Wz/G9WEGwBlC+ogyWcV6xZSlOzCR7BmDV
	1h8jiaRG3ZDNvLHlfFD3LO7geytwpsua7c1gOTsr//l8JV3ANOvklwzZkqwRp01x
	gATcZEtGd0aSXtnDEBhs0SkiCmyWYt4hf8VuIOQeW4wViYULFUN/seip8RJjUGs+
	4TyCtt0E6eV3W2SWB86XRm0bTxSPnE6iSU7p+0MK3GXazHgh09MVWDhqTEU7EOzA
	gFeDMRV/5+Cd/e7GnoNpX6iA2+Wsrz3NIE0k0vU00RdNU0LxN96kFXDniW8FwFHH
	Ug9lfaHo9Q9ycz8QV1iD4A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xudc7kpm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 18:06:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 508GGU3p022609;
	Wed, 8 Jan 2025 18:06:35 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xuea2u2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 18:06:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dqmlybw6E1U+vBmFLeXCdkYTCKXhDNRGkR3yAuo6tSDxl0ltGamxWgJXHacISwvH2BlD3lnzgmiDlTdODMJYW8XYDe7HVH6uGfItqvZTlE2Wk5z1zWtEcGXjqsafPAyznbTLChAYhP5nVDWtMZDq55lQdnU8YggIosdyPISf4i2YARuyHOoJBdxM/Ic0zbT20muD6HWc8wASNEEjLs6XLoEGzu3I0VXyWoVx6/ZbVRN5vUycb6Ljf9DwJSd46TOt3M0LzzPF1INm0OycGsjT2jwi689DxRXL/VkCuP024JiDcziXZl0b19I5AhoN6iS8P3/hl1MiFQxh0BCpM52/7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0482AN/rho2p+PKLhXu+JQOBq0o+4ChyfYNPorHXEhs=;
 b=gmzgGtZ2ehiKtkPVzxd5xjRXlkNSBfZnuwcvIIcflUXKsKelOFxvLQLOM8gwBkpYzTrtmLfjA3rriKe8Vo6iYlvNpXKHk+5fnVpX4WFKoeqgvWOw9OClMluJJd7AdvUIccw/9TooF6OH6dcPUX3AlUpeZ7+gQqaTUCxmXfyYf0yS7AOanui1PFTe47dVBfvE60LC/0g4bs2G3cJ+U0UoIcC9TaLuTOsaomZvmmBSjyGvIE/ZPlH9vlgo7YnUN9BlW6gCq7aQhyFlAmM/LviqLFOs3WxYk59EQASb01uSBq2HXjRsXrYZP4CeOHJGrzXvjG/RhdViep6n623B+1Kc8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0482AN/rho2p+PKLhXu+JQOBq0o+4ChyfYNPorHXEhs=;
 b=WChSwjX4l0aop3dvyPIJXAX7JCEK0/t8q0+wi939DJn0t8VxRAQRIK8itwFPcjYK4rz4qCj1oWM/Z6+t7lJaVDAuKEwKbo0oi8wVbsmR0zq1cDIWkZwZ0W6mneRp9G4LLfC9Bv90ACxvGqwec9rEI/wcP4sP2ltbDFDHgZCL1q4=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by CY8PR10MB6444.namprd10.prod.outlook.com (2603:10b6:930:60::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Wed, 8 Jan
 2025 18:06:28 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5%4]) with mapi id 15.20.8335.011; Wed, 8 Jan 2025
 18:06:28 +0000
Message-ID: <d8a8848c-2bfa-478d-87bc-d387694d8f21@oracle.com>
Date: Wed, 8 Jan 2025 13:06:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] sunrpc: Remove unused xprt_iter_get_xprt
To: linux@treblig.org, trondmy@kernel.org, anna@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241210010225.343017-1-linux@treblig.org>
 <20241210010225.343017-2-linux@treblig.org>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241210010225.343017-2-linux@treblig.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR16CA0014.namprd16.prod.outlook.com
 (2603:10b6:610:50::24) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|CY8PR10MB6444:EE_
X-MS-Office365-Filtering-Correlation-Id: 09d52a22-7b19-481e-dde5-08dd300f2c6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlZacHpDZnpVTFNYWkREUUZxcituRVpwc01VM2ptVkVhVCtGTFpRMDBkRUNV?=
 =?utf-8?B?dXZZdU13VHlBSXJpS0xzeENIKzY3Z0x2SjBxZThPVE1rcko0RnpLeCtkN3gy?=
 =?utf-8?B?UG5kZm4yN2U1UStrVDlWeWdLbFZ0QW9WOXhSSVc3VHRubzJ3UjhlU1lWeTRk?=
 =?utf-8?B?SkVITHY4R0wyYjl4aXFRb1dicVRxY1djMTBkZi85WmllVUk4Slkreit3L3p4?=
 =?utf-8?B?d2laUktUQzJ4MzBWOEYrMU44djFWU0VoT2ViRG1EcndpRVJlMjViaS9uNEtk?=
 =?utf-8?B?Tmtzd2x5UkFzWmRCK1FWZDIvVUhTOEczRDhkejJFbHNCUWxiQ3ozcDlhMGlt?=
 =?utf-8?B?Q0UrVkRYY3NZNmpJTXI3ZlFzYWU2ckltZHdYTmxrQUwxcDdLTmhBNzZqZHFx?=
 =?utf-8?B?VTRqY3RBSW1ZeS81Y292dHZlUVZVWmp3cTVFQS9Ga2dwZ0FpYVpQTVZhbzFw?=
 =?utf-8?B?azl6NU55WDMxQ0lpRkFtc0Q5L29yNEpOVTZES2dYbEp6UW96T3NYSGNOS05x?=
 =?utf-8?B?NloxTzdkSWF2WXpVQ2tXSFRRa1Q5YWtWRksrU3dLeWl5QXBRUEdDVmk0REcw?=
 =?utf-8?B?NjBoZzVTbk44akZraVBkL3NyemVIcTE0b3hoWWM3WTA2VnNVWjc3SUdTK29p?=
 =?utf-8?B?ZDQzaXN3VHROajNCL3V1SEpIb2VTNU92MlA5VzlBZyttQVFWOGFDeHJZTnFZ?=
 =?utf-8?B?Rk1rTFVpeTZCRWZ0QmFUN3JsZkFkTzVadlYwNWM2Z0w5ZEE0eDJVdzdyQW5E?=
 =?utf-8?B?TzVsTUcwdU42Z1Rsclk2QzMwUGhsNmFoeVBnSjVGb2dOaHFIL0dQdkl0QXhV?=
 =?utf-8?B?UEpZWTlUNXNPQVVXVE9oSitsWXhvYXBuSCtYVFQrZ3l2QUFIT2tqOE13Vmxl?=
 =?utf-8?B?YmxhQXFGZi9YMmFhSEt3Vm13SnZvUGJGUEI2eEpJZmdRRFJJZnBxak9YWmFN?=
 =?utf-8?B?THdwNG5rUnRlZWlMRENWR2FWZlB3RDRBeDFiaVYzYmFKeUhxU0xWYVVSVm5D?=
 =?utf-8?B?YUR5R05iOExzRjVwcEZhOGZYWVdpdDRPeEJiYnhWbm01T25mc21jaXhqVG83?=
 =?utf-8?B?bEM5bEY1czhGeDE2Sjd4a0QxV09mUWVDK3N6NlRMYWl0bUxPTDVnaVhkalJt?=
 =?utf-8?B?bXlreXpNdGlpQ3VubHpyS21rZFFPY05yOXk5Mjl4WXVvaUN1R21XSVJoQVBH?=
 =?utf-8?B?aUY1aVU3ODFBWjFSWHJuUHB3aDJTRTh6cjg4aHJpTkJtMHI5T0dvb1pNRTJn?=
 =?utf-8?B?Rmo5ZTBBaWZGcC9PVGVGR0FTUEFvSlFhN21melBiTFV1WnZqYUFkaGZYTmp3?=
 =?utf-8?B?cDJ0UEZlTHJGaUdON2VGcTRKNWxaUXZSN2dNVDMrRHFqbHNQNWo4cVNGbDE1?=
 =?utf-8?B?R2NqaXdPd09oZHZTZ1JLeHJJeDUwN3ZrT3kvcTlFZkh5VTNlbDFxZk5RZm9O?=
 =?utf-8?B?bFR3SVRxbmVyT09KUnpDSlNJdjRjVkR5UFN4R0FLeU84U0VVVE80eHN5M0Z1?=
 =?utf-8?B?V0hLeWlZU21tcWE2RnMxNExGWkVLU2E4ZzdwS292VW5KbDJkdVdEckQ1RTNF?=
 =?utf-8?B?WncwWTlJOFpHSnpBR3l2ZXJXZnZEMHlwVThJL3Mwa2tkSUNkbnNXOVRSTVZh?=
 =?utf-8?B?NEVITHlVSCtMSVJSQ1FEK2p5cE84ekJjczNWclJISDFubjhDMlloeE45UUZ3?=
 =?utf-8?B?c1pPUUg5VjNmeEhjNzVzV2FuRnJnS0s4QWdtWU9tSm1wTjAzVzMrRHNUbUN1?=
 =?utf-8?B?U2FPZVFHWkRxazlobGcrVzBKcEFUZDQwV3JRYjJOVGRaMFFiZkRNcUpEMExw?=
 =?utf-8?B?djRuRVRxeGVOdDlFcmw4SE91a2dRQmhydW13a2FNbXBNNURWZnlBUXhMKzJN?=
 =?utf-8?Q?62jpWf3TAkSsi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0c4dXJOOG8xUGxxTGdQK3ZmVlBKR1V5ZmdNWExTcjBMdnAwdGhlQ3ZCcmJK?=
 =?utf-8?B?THJlQlRxVzJYUTZUcnVXUHgzdk12U3lpMVVPUDJiT0g1aC9JTm1BTUlSNytQ?=
 =?utf-8?B?NldGRGRqcTAvaVhTS1FoNmN6elV0SndUaS80QkYyTkNYMm9RRDZrUnBlU09t?=
 =?utf-8?B?dlhTZlhhVzN2bHhUbXN2VHlvcHRVQ0NjUC8xaFQwQjRtQUtwUCtpQWZ5QW1N?=
 =?utf-8?B?Vmhqc2JyUHYzb0Ryd3RRc0VudmdWc1BadnhDSUpuajlSd1Zrb1YwbGN0cnNh?=
 =?utf-8?B?TU9lL28zOUxIVXl2ZG81d21JU2xwakJzSnltT1dlK3ZBb1M0WnhaZ0x4SU8x?=
 =?utf-8?B?RjlxQVZuamEwL08xZXJpT0wzb0lZbUtSMGNaMGVScmNUc1BqQW16RjFkZTA5?=
 =?utf-8?B?YXNtRUpxd0hpc3gzYXQvaDFOcTJKb1d2SlJOTGZHUVFOcHkwUTZPbEFGVjY4?=
 =?utf-8?B?WER1ODdwYStwbkNhNUViN201MUkwcG03MEZBNjZqdGNMdFhYOHJqUXBSS1JR?=
 =?utf-8?B?ek8vMXJtSG9KaDlDN2hFRytEaElON0w2eVI1dzlyeDZwVFpPVDRpQXNXYVBt?=
 =?utf-8?B?dnYvQkwyZ3NYWUVUVzRPZ3hMRUIwNXVOWG12QlpIYlRobVVUUzVaM2dzaDRB?=
 =?utf-8?B?bjUwRktwNEI3ZWxWVWluZVRiRXg2eWhlS0ZTMUxtTS96U2tBVE10Vzd2SWpz?=
 =?utf-8?B?dUtFdWc3MERMMGpqdGtJOHdJWHNteTBmSU1NcjFtMWRhZE9nMHRRTHVHM3Qx?=
 =?utf-8?B?aW1TOVR3UVRrK2dmamZ1eEM0QWRLOW80Mks0UkpROEthei94S2JSUHhNdjY2?=
 =?utf-8?B?elZldVhTTHZaWDAvbmpoMlhISUpjL3ZiYXNmWjBUTEZVaWxyMk1wS2wzYUho?=
 =?utf-8?B?Szh3dHpoazhyTHM2MHVabFJlWUVvSWtYdFNGR3B6aXNpeTNmcUJHcWhwYm9P?=
 =?utf-8?B?N1NYc1VyczBmNWxZQUNFdFhmS1p5aThTbGNhR0g0VFVtVGNYRmlnMGVxQ3Vy?=
 =?utf-8?B?QzJPMFVacXhCaGtia2dxZzdyZXp4NHlFdE5peTdtNG8yZHRIRWlBKzgzWXBT?=
 =?utf-8?B?TkppWitQRnY5V3kreG56aUhVMGpUczlYNmVnbFJhNk5uV3JZSmFNbmVQdEp1?=
 =?utf-8?B?NG9OeHRTRnpPKzFvNVBOdkJrWFo2K0FFMUpqL3NCYmdKUTV6dW9TUTBnOTBh?=
 =?utf-8?B?VEFJSUJhUzMzUXdHYWxyVTVMZ0tvYjNnSmMybHFhRUJVNVo4MmszZTZtYVZp?=
 =?utf-8?B?dzVIRjZDd1BSTndybU55czFMZ3BycytHdWVGS3R6ek5Rb0ZiSldoRnZ2Q09h?=
 =?utf-8?B?NmR4d1h2QjZ3bkhrN3NqREZYQmxxNmZZYUVVS3BZcTdqa09zUVVDVk53dXBn?=
 =?utf-8?B?b2JpQXJUai9QQW15Q25sdStPbGIrZlIzUDZoNG5Wb1l4RU0yNGxnVFYycFBG?=
 =?utf-8?B?cTdIOWR6aGxUS0pOSUpSWUVVb281Q0psVm1iWU1SOHpaaUd1UWNQaG5rSzEw?=
 =?utf-8?B?QXFoR3FUZEJtUjNsS0RSS25aREowc1paUUFEcklsRW1PKzIxWStNZmtvWVZt?=
 =?utf-8?B?cG1keXM5WkdKaG1haGU3Q1o5RFFQTTFzSlpDRE84VnozMnBQSXJMSVg1YmFo?=
 =?utf-8?B?R1NCb1I0V1BnMlpIaDB2YjkwVmJKWWxSM3FqRTdOMk44SGF3ZG4rTWttVXVa?=
 =?utf-8?B?d29GR2JQbWYza3JPdUl3Z1N3SWROMVV4RndOUWFFWkJ1VG14b1BnSThrUXV6?=
 =?utf-8?B?M3pINkg5dHp0RDM1dmx5NDhRWk05K1NQNzJhTDlTUitFWVNoWmV5YjFXVzND?=
 =?utf-8?B?NEN3YjhjaEF0c0N3bVR3NTl0ZGRycXpqakZaSklTRzJUL1NjVE9ZdWR4ZFJv?=
 =?utf-8?B?VXkzV1h4V0tIT3QyOXZjUHE5RVBTMWpqODVtaEVOQS9Cc1pGZkV5N2x5VVdo?=
 =?utf-8?B?QzBpM3pHRnlLU2tRcWhVN00wdzFNWlBJNjhqa1B5cjIwWklZVTBmbk5ucUdN?=
 =?utf-8?B?VFkxNmtDa1hNOWU5aFQ5Z1JHSG1TS1NSVHBzZERjNEh1dzJoTTJiRUpvVVRD?=
 =?utf-8?B?b3FyTG9vZTRyRDZHWmE5Mjd2TGgwQThlU21nYWNka24rS0t1OGVvZVNIaUNi?=
 =?utf-8?B?cXhVYmQrVENJc2h2OStjMDVCYjFHTnJBeHVYcldmZGtUSitQTkhOUW1XUzBw?=
 =?utf-8?B?OERpUlVleW1pdWdQNFkxQ3l2M0t6ZGdBQVRtU0hIa1JwMnBhQ2dMa3NUV0py?=
 =?utf-8?B?OTBUV1VjV0hPbDMzelc5Vk5UR0dRPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YR9nYR+ZVwyoLwwwY1ThkAzAa+MlCrFE2tpUb676pwDJqMaC6+Vsj6lmNHHev3VqoHa3Q2nn7768RKSFk6o0k/Gy4GlcywXxVHhwn24cB+qzeGcUwTDmEWn6xmpGAdwJRZIL4OAm6KHvuF5KMg8wfc8DTIMw8EmeUTk9+TcHI+4bckQ08lZhYBnzG+x+MfcBStpEeyIdjtNM480+T++TWUd7seuR3b9tfUtaKMexkp8LgQdaKvkAvmHnu6hGItpUh5x+gWjcu2ptu4BgXirnco/cUEelFpvG4s4XQGMdKmyR7/PJE1h1pE0vHc26L5jZorY0rO1aH/VI/HxxFK44pFgR37NwMPiwNhQ4cpVSC+HsSp0DTR4I0v4xz7eQo/eKsiVwbBMBYK//yC0ZZR/tN4LsZ9FiJnJdcqmTaoEkxBSUuLTjuwVit+AJBZwFxhkz0utgRMZrd+SROCRDPyOG2cYfVTlAkM8yGR+HwTzfan7GzWQJDFt4U/25PHyUyUtWFAu/qWe/xROObxOVzFi4aL3O/i0pLlTbvvpuFgi5lCa0VRmdS/skyApaH/cVE/Z7WXJk4LTyZClrbhSzcnhXUywhgJoH5BwQWZSt2QirqFs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d52a22-7b19-481e-dde5-08dd300f2c6f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 18:06:28.6401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZsXht0/RgWpAmHIaZ34pMyS5QC5zWB2dRpvTZeaDvi/4jGIhrQyuPyREKNE+ktY01Fu4otIglSG/fLQftSm7+iryz9nHBqYZE6syYZ3RaAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6444
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_05,2025-01-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501080148
X-Proofpoint-ORIG-GUID: Ga4lDrOSbQQfUK5vWCYH6fvfglPdYjJ1
X-Proofpoint-GUID: Ga4lDrOSbQQfUK5vWCYH6fvfglPdYjJ1



On 12/9/24 8:02 PM, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> xprt_iter_get_xprt() was added by
> commit 80b14d5e61ca ("SUNRPC: Add a structure to track multiple
> transports") but is unused.
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Acked-by: Anna Schumaker <anna.schumaker@oracle.com>

> ---
>  include/linux/sunrpc/xprtmultipath.h |  1 -
>  net/sunrpc/xprtmultipath.c           | 17 -----------------
>  2 files changed, 18 deletions(-)
> 
> diff --git a/include/linux/sunrpc/xprtmultipath.h b/include/linux/sunrpc/xprtmultipath.h
> index c0514c684b2c..e411368cdacf 100644
> --- a/include/linux/sunrpc/xprtmultipath.h
> +++ b/include/linux/sunrpc/xprtmultipath.h
> @@ -75,7 +75,6 @@ extern struct rpc_xprt_switch *xprt_iter_xchg_switch(
>  		struct rpc_xprt_switch *newswitch);
>  
>  extern struct rpc_xprt *xprt_iter_xprt(struct rpc_xprt_iter *xpi);
> -extern struct rpc_xprt *xprt_iter_get_xprt(struct rpc_xprt_iter *xpi);
>  extern struct rpc_xprt *xprt_iter_get_next(struct rpc_xprt_iter *xpi);
>  
>  extern bool rpc_xprt_switch_has_addr(struct rpc_xprt_switch *xps,
> diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
> index 720d3ba742ec..7e98d4dd9f10 100644
> --- a/net/sunrpc/xprtmultipath.c
> +++ b/net/sunrpc/xprtmultipath.c
> @@ -602,23 +602,6 @@ struct rpc_xprt *xprt_iter_get_helper(struct rpc_xprt_iter *xpi,
>  	return ret;
>  }
>  
> -/**
> - * xprt_iter_get_xprt - Returns the rpc_xprt pointed to by the cursor
> - * @xpi: pointer to rpc_xprt_iter
> - *
> - * Returns a reference to the struct rpc_xprt that is currently
> - * pointed to by the cursor.
> - */
> -struct rpc_xprt *xprt_iter_get_xprt(struct rpc_xprt_iter *xpi)
> -{
> -	struct rpc_xprt *xprt;
> -
> -	rcu_read_lock();
> -	xprt = xprt_iter_get_helper(xpi, xprt_iter_ops(xpi)->xpi_xprt);
> -	rcu_read_unlock();
> -	return xprt;
> -}
> -
>  /**
>   * xprt_iter_get_next - Returns the next rpc_xprt following the cursor
>   * @xpi: pointer to rpc_xprt_iter


