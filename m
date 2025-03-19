Return-Path: <linux-nfs+bounces-10694-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80442A697E5
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 19:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E81C888F12
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 18:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78842101DE;
	Wed, 19 Mar 2025 18:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fg5PEtsh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UkAUl1LG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9B320A5E1
	for <linux-nfs@vger.kernel.org>; Wed, 19 Mar 2025 18:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742408540; cv=fail; b=e8Xew4a7FtGZNhcFgPkkoueF/CDTGUd92XhH8pZRT2vXbija6AsRO4/IeCsdoKEar4dOThHqjartGPXVxuaCFm3c083t+cgGMi5I2zj6lfHrKTpcPMkEuVOqv3syrB8k0q9IidXvFlDc4nNaD0V4ambUOMv69xjRAsee8NcYxsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742408540; c=relaxed/simple;
	bh=fK+IwXfLZQgjVEl0/I80ruirgbnExKitwkiJ82COmOc=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=Euycw76YrJg5dkjhDA8aADsXLG4STFpObShTlvSVdbC9IUzCbOMAYrSD3iVptrdu/55jQFVoW02BMdT31SnZLPIOstqNIuGQLtUZ1BitY+g1vLZls9yq195bw4yOrOLkeaa1tHSjFn9n3od7nyAcQIDNvOyiWcVsIoRB0+iD6iQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Fg5PEtsh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UkAUl1LG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JH0r8s017376;
	Wed, 19 Mar 2025 18:22:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=ZrVg3pCEMKGWtcM6
	QT4fFgqagLBzLwoGSLixwF7WiQc=; b=Fg5PEtshF6o7mjrjqUuasR04H/8ob8nT
	Svp+eEPV+LpVZJb4fuBt15jJSHwmMSSTJkVGyDO+xKFAZskIFif5y/ZUf52aGvCW
	7Vq3f3vtDIy5A5a/cDuwXUyKRPG3s4VjgVeOHOHHgReGqHdHov9uOJ1R/TV+fXB5
	7yKxLgSDSjaNDFN8OQROKw4iu+7gJLjlbHKJRjfoCuFI37IztYUiB8rWuEPn2Tfq
	oauNhX1wVq4hIL8hntNk8bhdtpr1Poqsz9L60a5nIpMmR1nvInM03HvkWrppWiQr
	ApBObwuXWLOiG+NrLDAZAHUshq2b80dCKZiJt11FSY30YJKKoPsZyw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1m3up92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 18:22:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52JHW2ho023771;
	Wed, 19 Mar 2025 18:22:09 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxeh8drp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 18:22:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UV/5Bbc9fBDSq2vmaXrc/R40Pk0pm0H4yBlYJsomwsBlj4Dxb4MquI9WkmjbRQHQSzGBvn3BmjqEZhQSzxXCG/Z4livIIlInx8IruWKUVL/I3k5825Nk/nr9t2cfZY9OYt7e9MHTyblkrAAh2kB9I6HDia0koAfJ7krGAGFcpbURdJPkWvTmripL9cSzW5d6HPdmq2MpCKIzib3tXR9be4H8U43nr6qXg100bNU/Uh/r5e4mEA7pe3jkteYjmIADrAsPmC2P5ct5ZLkodIjB65r1Y+qDK35ypctv9HgIQwAVmVnpzUujzaKKVVMnq2YGmg3XsMIds1UYq+UQNUkfiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrVg3pCEMKGWtcM6QT4fFgqagLBzLwoGSLixwF7WiQc=;
 b=L8JnHRX5n3sZ7ko/bDYUlk2hxAFsmm9tzfbyo3ouevc6bvaxUMH/ZY6fRo9Ul7fCDmtLM2MrkH8F3FzYzGWUGHJ2au0GvnfIc7Q/qiF8n0w4lB+jLW/SJE00t42TyX+d2GMWAqVzYR3KYUbhftJgTrliDV7eEZwBnACfudKRX8hV1WB6TKJOcPKKW0K3jTOfOUKdDRkXublegRU2JVR0ZMx0QFh85QD34HW/4A6V4T8xHVMQLN/Hen0dUA4a+pNCjo+jo+hyv/oTcnsLJig1Pd2PUJSfNLaiqZfnI8sXE0YyXEgw4vqQ1BxyGEuod6oIkJTjtwqVmc50wuiyCLV27w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrVg3pCEMKGWtcM6QT4fFgqagLBzLwoGSLixwF7WiQc=;
 b=UkAUl1LGvUuBcl24zvTeWOsA1Q5/Uq4citGZMRQwGJ5avFtjTJDsh/tDOT8gRLNb2xgjSSd2pf4NgXRaNpzux4FVq0mrgHQ3Eyk0bvKYZ53sKSEa5GigJ1V/XG3hSXElWhvLBCMyoZk2a8WJ7EuAJUbTbJ6At8gj3EWpavSZscI=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by SN4PR10MB5638.namprd10.prod.outlook.com (2603:10b6:806:209::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 18:22:06 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%6]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 18:22:06 +0000
Message-ID: <543f93fd-3b5a-4e4a-b2b0-0a1b7e1e8361@oracle.com>
Date: Wed, 19 Mar 2025 11:22:00 -0700
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
Subject: NFSD automatically releases all states when underlying file system is
 unmounted
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>,
        Tom Talpey <tom@talpey.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0044.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::23) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|SN4PR10MB5638:EE_
X-MS-Office365-Filtering-Correlation-Id: 334e89dd-f2e7-4901-1d4c-08dd6712f474
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGVTbnkvYUtra0ZVdWFFcG1oOEtmd0dNajF1K2pGMWwwYkhmWUJaQU5yZ3hU?=
 =?utf-8?B?bzJ2TUNiSFNaMEF4b0lXSFJWV3RBT09wbW9LQ1gwRE44RkpPSEpMM0ZFTGpB?=
 =?utf-8?B?TlpZWGpHZm43NzNLbmQ0dUxRRDlDd2RvQ3hEd3RMa0hkMFBEdVo1bzRUWVg3?=
 =?utf-8?B?UVRoUUJ0RzNuYWZjUGMrQndYcVlnTzdyWXJRSVdXM0haemVVd0tLYzFINGI3?=
 =?utf-8?B?MVhkcUYrUDVTRVQyMCtPME9sZzV2bnpYZ0cyTy94alR6U3hsenhJMFBqV2FL?=
 =?utf-8?B?R1ZHU2dIN0JyMWtabCtkNnZBU1FJUXlvNUtwMVo5eFZFdVljbVNHYXFTa2xz?=
 =?utf-8?B?RjBQenRtYXYrWldIZlMrTW5pcW45UEZRMTV3LzJYaFh5dWpxUjJEc01DeUor?=
 =?utf-8?B?WVVEay9mVXdkcmoxbk5NNnM4d0M5UEk2K0lITXllRzc3dVBqL1FnQzQrZVBa?=
 =?utf-8?B?R2s3R2xsWTRkQ1lxc243eGd6NGNXSEtOa3JFL3pjLzFma3Izb1Q2UUdYVno3?=
 =?utf-8?B?SHYyZHl1a2pzUHMvWEcxMW1BY0kzSGV4MEN2VE42MUs3Vy95NlQ2Y3hpYXZH?=
 =?utf-8?B?alR3SFdSTmZ6d3hCeCt2a283ZCtQOVFXZlZxa29BN1JzTEMvbE14TVVOVUFD?=
 =?utf-8?B?Qzh6REE1QzNzNEtOMmZhUFRCVWhiYWFIVG1EQlFqRmQrV2dyT1lTZzVjV2Nt?=
 =?utf-8?B?R0JnamloZ2JiRVY2MWNEY2h2b0pyK1I5d3BmYjJIbGtMQlhyeUV6S3I3M2Yr?=
 =?utf-8?B?OWs4VDQzeGhvMjVxQnBUck9JQVU3MkZIdUIyZmJFYkNVbVhOM2RGWGZ2Q0g1?=
 =?utf-8?B?a1J4L1VTSS8rTmZaRHU5TFlBM0dBSEx3Q00vZDRVTHNUc05WOExKRnFEWVdM?=
 =?utf-8?B?N3dIZm5EU2RUbHc0aHMyZ1pwdEliWnJ6OVZDYTlsWHM4cVdNa2U3aW1BMkZz?=
 =?utf-8?B?VTFub0JUOEsrU3pvTGJUYXhxbC9pV0RaQmFuRU15SWlaRXhNWDJkY1ppZ0Qv?=
 =?utf-8?B?NHFXMWRscGRCK2VHZU84UGU0R09HZ0I2cWs3cGFDaG9YY3lRQlJpTGJ0dlVU?=
 =?utf-8?B?NnlzNllSNFBkaHFRSXBUdUp0MHJLVWxjcUNJZnJmSHkxdFA3NXhacXFNMndt?=
 =?utf-8?B?STZrLzRweDkwZnF0Q2dIZFlsSldhVmhkbUdSYTYrSVcvNmlzYlZyWlAxVWVl?=
 =?utf-8?B?WG9FMGJXN1VpOXVST0orMTFXTTA2UGluM240ZlNVeVYwNVloemZxblhCZDRy?=
 =?utf-8?B?T0VBZnBhZXMzWU9kL21IdVN2dCtPWE52WEJHeGxnU21JVmJnZG5JOXhBSCs0?=
 =?utf-8?B?bmNuMi9YbFZrS0VGZ2JKTnkxYmdOaG4weVJjMGIrZ2pIeEQrZE5rYXNsZmYx?=
 =?utf-8?B?WTJVczZrLzNaOEJKQnZTWTVhZFRkSlZhOHdORE82dnZmdmxscjNFVVdQU1Z1?=
 =?utf-8?B?QUt3amNiOThPSzc1QUtVUy85TmgyNkU0bUd0OWJrREpmVEU1TUZCMUswekRP?=
 =?utf-8?B?emdXKzBwUG1jcFhXcWVhTVpEdDU2TDZBalR5eGlOS3E1N3JRMTZZTFJNM0VW?=
 =?utf-8?B?STg3ZXI1d2RMbjhlWGM1ZXMvUXFtNUpRcldOTDRzMXI2VlJFSUgweUg1NmVx?=
 =?utf-8?B?bkkxell1dlhhOEEzMWFQVmUzYVpyQ2JJM0wvVno2NXZOUkZ2OVloSVFPVEdo?=
 =?utf-8?B?TTRZanRoSDcvdDlaSDBHeXVRRFJuRTE3ZEdWQnNyNzF5ZUlLU256dFUrdDZY?=
 =?utf-8?B?MVV0VUtYdFYzWXZIdkQ0L2t3OVhxc1ZVTGY4TTNFTGpzb2lEcllUODhwRGww?=
 =?utf-8?B?TGlZVjgwbWVHdDRpVXBrbjBYOGUxVFRQV0ZxWG5vVFBUakhlaHI2Wm5UTkww?=
 =?utf-8?Q?1Avg0sHZe3EQR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3VweHVnMWJTdy95Tnh5STkxR2xCbmE2SXlsUTkyN1BRRzQvZHlNSE9YODZh?=
 =?utf-8?B?M1VQbHlVd2dzbUpDd2xMRU9OUEMwRWhFMWpBWVoxWWFwbm11SitGWE1ZN254?=
 =?utf-8?B?REFsTENhRGFqNkEwTExMVSt6RXJRYWQvclJRSGFsazc1VWs1VUFDK0xNaVZt?=
 =?utf-8?B?N0dyaHdPT3hUMWxQMUNrdnkrU0hMbWZFWUpJT3JWcnhsMUUxeDZ2TUNTZytD?=
 =?utf-8?B?cDB0akpxY0RyYkZxaFhham52aTUwTzFBVDkydXZZZy9KeEx4TWpuYUN2U2Q1?=
 =?utf-8?B?bFFrcHR6cVdvR1ZubElSY3FLbStrNHdGQzVsalpNQVRnOWtsNGpWOUJKTkNQ?=
 =?utf-8?B?SkVoY0RPK01Ga0ZoUkVVRGtGK0VMc1Fjek1ZanI0VHV5elBOUWJ3MzhRaGtZ?=
 =?utf-8?B?YlJZaTRscm9aZ2gvMlU3ZWhlNzIvMDV6K3pSQ1NsMnROT0hZSmhUVFl6RDFu?=
 =?utf-8?B?eE1SSG5wKy9OekxZMzkraExHRklUNTRiWUcyaVhiWTFaYTY5UTZHdnJmZ1Jz?=
 =?utf-8?B?cThHenV4UVdZcUlsV1J4czFUOXVydEFJMFhOTVlTeXZlOVN3cUYwcHdFWVNv?=
 =?utf-8?B?VDgybS9CMzNpSGR2dEwwRFEranRCOFZwaHlZYUUvSXRmSXJlbEtOMUpzVlV1?=
 =?utf-8?B?SkdFL3RyT1pMblo2am9Ma2dRUmdTbFlPWll6aFBiaGw4TTZKcE4wNjVJWW1z?=
 =?utf-8?B?ZXozeXQ0b2ZNd1RpMGVMVkVmUVl5T2FiZTE4RnlOalBRMk0yMFVzUEVrR0h5?=
 =?utf-8?B?dmpuTDZ2aWR0cmwyU1ZiMnJjSUR5UlpGZnRNWU5MNDVqRWdGL003R25WSmtV?=
 =?utf-8?B?ZzZtc08yTFZpRGlxUCs0S0NKT0tobXBlVnlRMHkzSWgrdDBLRko4bkx6TkNV?=
 =?utf-8?B?V1JYQ3I3U0RUU3VnL3hNRGd3alNMRVlFOU9IMFF6UmkrRk4xWEY2THhzTXNn?=
 =?utf-8?B?N3ZZUUk2RklGUE55N25aY0tMZjRCbWJYVzJ6akZtSGw3dVc2R1Bxc1kwVDB5?=
 =?utf-8?B?azlYSCtnQWxHRE53a09NQ0NxS0xXVlpmTlB3ejE1b0dWSEVUSm1uWEc0MFJM?=
 =?utf-8?B?bGtXYkNsakF5M1Q2dG1FZEozY20rSFovRk8zb0FHOVovb1NUbkdTK3BEQTd2?=
 =?utf-8?B?MVkrSmlyZU13dXJ2TFRza0orVFFPaEVIYkthY08vVnJmYkV1TW52WWoySlJJ?=
 =?utf-8?B?aUhIU3FMVWR0Wm1ZTDBBb2lZZXI1aXJVREY3ejZoVkJXbi8zRDN3dTU2NVR1?=
 =?utf-8?B?ZGgxelpsK3k0MTc3TnY3YWdDV2FKZ0FhOUhkUkFkbm9DQTJHdHI5Z0p0TG1G?=
 =?utf-8?B?WTN4djduMHN5cTZVWlFMdlV4elcvV0xHTFlxbVBUd2xJRU1MU2QzTU5nRk1X?=
 =?utf-8?B?djJFVTZGbXcrYzNWc3JCc2FzVy9wYngvM2l0RVFWNlhxSlE1ZEJlT1NzTFhk?=
 =?utf-8?B?d2E3V1JaVDhSV2NFWkUwZm5TOTFuV0w5UGt4ZWUvYTlTVzJFUkJBTDEwQ3I2?=
 =?utf-8?B?SEF2Z0VpNVhGSnRiME9SNXUxR3ptRFc2YW9uZUlUVmN6M0xhdGZpWVpCS1c5?=
 =?utf-8?B?VlVOU1cxRExQMFdCelVGVkplM21PRWRydDc1SCtqNnRUMi9QemhOdTdiczNi?=
 =?utf-8?B?WVBwdi84Uks2aEE5WlA2MitiUUthS1RDOWdpeTB5aWtibTRGYTNUWHhjSTVo?=
 =?utf-8?B?K3RIeU5VRVQ0VkxSL1FVVmc4dk1KUVcrWUNZWU1LYmtOeitDQmNBdnQzVVZW?=
 =?utf-8?B?SnQ4ajBkeWxmbVZZb2tuMHo3Y3oyWVRFRzRFQWNuN1A5bC9wMUtFOXV6dTE3?=
 =?utf-8?B?QWdONytib0pHdXFOVzR1MUxVS3hrcFpvM05IK3Z6T2VwckZTVloweHcyRkVh?=
 =?utf-8?B?ZzNYVGNjaEEvaGJXenNITkVrdk1OSzh4VENwWCtDZ3phVFlKQUUxQnl1RmFY?=
 =?utf-8?B?TTA4VHJVR211eHFTMSs4RXpzcit5dDQrRG5tWExTUi9HZ2JEUkhvTTRldENw?=
 =?utf-8?B?VnhUWTZSTitZbFIzVUhWQWtZNlRYNktMRUhrNnJzZ3BtREpoMXUzUmxvUHBW?=
 =?utf-8?B?SDNkanAwZHZjOXg0aENyQkc2VVJ4aWt2aXZMMkxyUHVLMWFnZnlMUk5zR1di?=
 =?utf-8?Q?PhREv9DrBtCrIsOf6KB9y+RPa?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WdD3eCnEQubFSLYZP/r40fRrzkZMUTBbEnFhb8e7YUTfOjTRXyCoI0Ch1gsiMxPDrmdU8JaqRgFLwfdjZEfnkujUsbc+Sf5P/dnxYXoNBQ1FlQNzzGgsHBaA/Fyvf/iY8ZtYt4z9lmesLiYS46OnxKviVWoMlU1s4imTs7BgaZVVkaw2MdVNcAwYjnTyR5+estkwqq3eWaIVB7zA3eJ5dwUa1Z1axRqve35H6sqVhe7+1v/SJO14xmIa7eiFI83OOCnIDiOUmf6texcOUK4aKTNs9ON6zsdVIZkcA9/MtrhnT2yiuZxUa7OOEQ5IGE/Xv/Hy1Dn17DH9JJYvzxxQ6LTYkmHIC4DJW1d9nm2whoTr3o0S0At+B+VSkfbIS+EHg9NpMwelmr/nBGCcaFIoejfXsQBWKMuX5iw9nhVJzF7YusgDokidnwCLYyYWU6SY4LGMtoc3yAtUHzk+xgXStiagcczfRFrAN+IBQHBk0retkCTFDk69nJGfbc+YBvNgAbOi5+mIFhuUrhQijWjZPfy5TD9Zc5QEht8al/82F9j2gkyn2/4giF+PjluB8WgJju2Bc+gyYVnruDC0TI64V6xNmeTJGfzmvwCkuKcnyEg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 334e89dd-f2e7-4901-1d4c-08dd6712f474
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 18:22:06.7414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 10zki3RFlOETJriCwxBrklnIhZo8CliWskYvjhlWLvZNfkfyg4DW53iV0hd8NHTQk/0NSK7fU4slbHJpZUKhZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5638
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_06,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 mlxlogscore=812 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503190123
X-Proofpoint-ORIG-GUID: Jy5qinJOQdxkzNNiTKXp6HWv8XC64r6F
X-Proofpoint-GUID: Jy5qinJOQdxkzNNiTKXp6HWv8XC64r6F

Hi,

Currently when the local file system needs to be unmounted for maintenance
the admin needs to make sure all the NFS clients have stopped using any files
on the NFS shares before the umount(8) can succeed.

In an environment where there are thousands of clients this manual process
seems almost impossible or impractical. The only option available now is to
restart the NFS server which would works since the NFS client can recover its
state but it seems like this is a big hammer approach.

Ideally, when the umount command is run there is a callback from the VFS layer
to notify the upper protocols; NFS and SMB, to release its states on this file
system for the umount to complete.

Is there any existing mechanism to allow NFSD to release its states automatically
on unmount?

Unmount is not a frequent operation. Is it justifiable to add a bunch of complex
code for something is not frequently needed?

I appreciate any opinions on this issue.

Thanks,
-Dai




   


