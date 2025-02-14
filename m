Return-Path: <linux-nfs+bounces-10121-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03722A36059
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2025 15:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88399188DBC1
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2025 14:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBDF264A82;
	Fri, 14 Feb 2025 14:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e/2eaieD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HWb5HoX6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9325BAF0
	for <linux-nfs@vger.kernel.org>; Fri, 14 Feb 2025 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739543209; cv=fail; b=SzSP0imMAPCEGpPbZlCf2Evsp2ZX/l2qd//rnGQfAPDS9C5qZWS3ldhqGI/IHHHoJZMG3txBqKWUa1xrOTFcrFlQ6ICwkljfr1qp4hqpAbnP3vb5D9aciL8bcNXOE/nbEzsvJpaHYk+zEsQAay+1nWpBiijMwAeQgpy0OCmWrmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739543209; c=relaxed/simple;
	bh=86E3FgxGEkHoJdzgS6FBzzxgoFawWDDpuJ+AQKlz0lU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YbXXGu/YqYC/6XUN9SC6saZ2gtA8ex18MmQbq8Kqu43/2GkEf/q6bZG7vJEvrfj0LEZK0fOSXMoM1dL4jQn2O1OCrs0ECmfizftyCQFxxvyKcEAWS8cHtxpXHlddnCtr/bh50P6qrQKvWbH1soitOokw5Degk8zucAknJPlYEiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e/2eaieD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HWb5HoX6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ECtTmF001915;
	Fri, 14 Feb 2025 14:26:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=O+DMtAL2aP0b+Tmex+66QhJHZmAYv1AS8oYJ+SFXVuc=; b=
	e/2eaieDkgU+PzdWDC8XKF3fjDUOn4+WgRZIswBdaLPaDzdGZ78Ckwz/2hb3QRSe
	+tng3HxaQUxt/NpczqviBfQgk2sRKejQI5j/3j9l00LnxVRBxItQiMEvm4wGiiay
	/t0SqyOgtARJ33CtI9C6z8mZtupEBKQF4JRqnPJ0WP5pTH6tsR/qQ5OrUsBlUw7F
	hsPbaLW/gWaiKGbcH094hG27WjRvYhTsnPbZAJ0CCGeuc9dqAfaW87st0dtuccBI
	2hPDEJ1uz4ck09P9AhWzs3Viy7sR9sS/AbE+4Of8iovlgMfpFxS7EJGiBa2Lbp43
	lsYCLVr8tUzERHeq2j/3Jg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0qyutk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 14:26:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51ECsnUM025169;
	Fri, 14 Feb 2025 14:26:18 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqksw84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 14:26:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nPoEO8PlR2oACo70dCR/7Cae6DFy+JAbFBb/GXSOLXfa02NMOxA2TO5Vr5h1PwFc4sClP2EBT43bCys3t0ozzIheCY4ADQjYcdlTdwHsu1sw7h9BEHne/2aSDU8BaYoUFzZkahZjJ3x+h+g/XN1KkIuDSV7QBxb3HGaK5rxtKFFhbxtFnAbyLmwDRe1/KIWJefIif8/mv7cKd1IrBynhGajksR0hR4xLW8VdSeVidHyZaqiXXesxd7AZBWzKfORqxBYkenPzAmsjqnhWbloNStCOslpWq9WR9zSk5I3PfaVrqc1+SMDK5AGF+bY3vuK2d0YEWctg9BvqrmowjdhkMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+DMtAL2aP0b+Tmex+66QhJHZmAYv1AS8oYJ+SFXVuc=;
 b=yvEu1PA46zfBPjs49s7MrBlX9RQOUn1W9DyqDIQC90i67k0+o9Mxz6QHmZWNYvY2jvOHTAJXB4NcoMBtw3O0Mb6NOQDaMhS/r/IUiamvS64B5Bwtavhp4pOggmOBSPi8Go8eqLG0AJvunN+6tehvEJKlmHIbz1lEsFcNPQr3qVJpcnA8TExCDijiFwVzLPscNJxOdoU95GRl+OP8/rUOkEccvzS8lAAzwzyPCwtPeVNY3iFW1CxrdKTR9qH2Qq6bjTDiiwTh77fMqwjr6DYWRG/knd+BMZHQSl1aj5/Rb5upQ1oatnmjdrej87Mjw76jlq12ARB8WLBCmN9Nw3SLaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+DMtAL2aP0b+Tmex+66QhJHZmAYv1AS8oYJ+SFXVuc=;
 b=HWb5HoX6o77cs1SWlwvGaCbFk3OnAAxUIWSJujr2whtp4KZtMgrKV/POkYxnlsw0ISz+FiXcrvos0Vhs1s1fkG4Z2QkegV+imTON232QQVHqg2sAYnfjPK67wcNlNJKXB78YJZNufaYRzOIJLWt913GENmflcycJz3VvnkAPLgQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4716.namprd10.prod.outlook.com (2603:10b6:806:11b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Fri, 14 Feb
 2025 14:26:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 14:26:16 +0000
Message-ID: <1380007b-6cd7-4be9-952e-2a834d1a4e01@oracle.com>
Date: Fri, 14 Feb 2025 09:26:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] NFSD: allow client to use write delegation stateid
 for READ
To: Jeff Layton <jlayton@kernel.org>, Dai Ngo <dai.ngo@oracle.com>,
        neilb@suse.de, okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, sagi@grimberg.me
References: <1739475438-5640-1-git-send-email-dai.ngo@oracle.com>
 <1739475438-5640-3-git-send-email-dai.ngo@oracle.com>
 <5eeb042a0a6c69bba89e1334d6ceac872eda03e3.camel@kernel.org>
 <41f344362f8d1c7a3a3f72dbc8a904ffbccec189.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <41f344362f8d1c7a3a3f72dbc8a904ffbccec189.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR08CA0022.namprd08.prod.outlook.com
 (2603:10b6:610:5a::32) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA2PR10MB4716:EE_
X-MS-Office365-Filtering-Correlation-Id: 72b5857c-f707-4c46-78b2-08dd4d038a77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RU14TklpMHhlWkJhSG0zSUh2bGtkZ0hvMVI5KzJFQitWa1dKOW1DT2tOR2VS?=
 =?utf-8?B?T25ZVThtTVJQamVBWlBOc2hDZnRXV3VHYTc1QXlSaGxseTdtcFRUV2VXcUtD?=
 =?utf-8?B?dVpCWWIzRmZCd1pqQ3l3RHBBazc1NVVGWmcyRnFwNlJ6eDZuMFhaamp1M1Jl?=
 =?utf-8?B?Tys4VmV4K2xYWEtndDB3dWl6NWYvVk8vak5la252Z2c2bmJTazhWeUJQZnVh?=
 =?utf-8?B?UERBSXl3YUxqQ28wbGl2dlNIeWt0ZGdCMmd5NGM2ZWk2QmlsbzBkYzhnWkhH?=
 =?utf-8?B?ajZDT2x3NkZtWU1BLytVRWd6ZUIrU2FGTW0vOEpZdHBZYWJ4STJkcUZzWGg5?=
 =?utf-8?B?L2xVUlI1VGxQTlljYnl3dmlPS3VmMWU3cjNuTU42Y2IxS3ZsaW5xQ1h1b3ps?=
 =?utf-8?B?ckE3M25ESXo5RjErTWx6T2pPKytuVVdWa29XMDdIRFZvQ0VFUFlja250WTdj?=
 =?utf-8?B?YkZaS0EvUG9LSzFwTDlOQ0NCWFZYdHdQd1ArQzhONHRjV1AwamxrY2g0dVVB?=
 =?utf-8?B?djU2K2dNbGRHNlZ4SnRWRWNCU1dyclk0VGg2Yis4ODNQV0tLMnB6RjZiSERv?=
 =?utf-8?B?aWxwZEdaYWNDRlFUNVRIZEhBZWtYVEZhVm8veW5JQ3hobFhKMjNvNlRlTDNQ?=
 =?utf-8?B?My9UeDY5VXZ2WTY1aWp2Y2wwaFBVZ29kY3pzbk5NOUJDUU9sWU0yZHc1WXIz?=
 =?utf-8?B?SURHaFQ0SGtGcVFJR3BxaHdRMG1UNk9GNnF0dWdPWVRuZG5NSldUTFZERS9o?=
 =?utf-8?B?NnhIUEc1dVFZTTNXaHpkQmYwNjFPWkF5OHREK2F3TS9lRi84b3hoa0hIMHVT?=
 =?utf-8?B?MjBDeVNYNjlnYmJrRlRqZUtHdDhlTnp1WlRpNDQ3bUUxT2cvQ2NDclBMdElN?=
 =?utf-8?B?SmdFdjdXVkpsc0FKTGw4V1E3S21Na3IvZXYrTEJnQXRyeWJmRHBzcFd6WVM2?=
 =?utf-8?B?TkRWVDhNS0V2ZGEwTzlTWXFQRjBOZTRyNWwvbFhwQ3MyN3FjYm80ZlJCQXVi?=
 =?utf-8?B?NDdydmpTVTVXTjhycHdBKzNoanNObTUrQnJjMnRpaitlTzgyNHUwK3hYZXRL?=
 =?utf-8?B?NEYvaEZZVmVJWmh3YkRRWkc5SlpHMjcxNDNYQTVTNmVNR01tbmdPa2VZR09k?=
 =?utf-8?B?dFFzMzdXSDZyVDMyd0tySnJXUURRb1FCc3dJSm9YZzRSei8zYkpDelhVY0tx?=
 =?utf-8?B?bGdsYlQwNzREaFJndmt2N2JIWFRJdEZvSE9tYWVBekV0YUJKWEdrakJxbEVj?=
 =?utf-8?B?UnpPdTJ4UE9XVHF3RTdtbUZFeWhpMEdJRFZOSElDTjdGVWNzZDQvM1Z1OGdO?=
 =?utf-8?B?eHUwSU4xNjdMZkJ5RmNDdExrUTd4aVJCS0JHaHFLNm80MnZGNHc3UkVVODZk?=
 =?utf-8?B?K0R5Wkw0V3d3dTZqNWREYktBbkdYc2ZMRTJ1SVU5c2lDbHhqNVdxMnlUYWJG?=
 =?utf-8?B?VVBpQVFYY3JTeXhndVU4Y2pqMkhLZUJncjM4Y29Ea295QkQ5WGxmbzVIbWlq?=
 =?utf-8?B?QXNsdEFBUXphRHVxT1pGV2lrcWlrTjZvMmx5OFdZMmF6Y1BJWW16UkpJcVI4?=
 =?utf-8?B?M0R5cGhoYkt0VXhQdFc5djFXVUtsNHdmRWdVbm5vNStCSUZ6RC9wZXd5Ky84?=
 =?utf-8?B?VFlsc3ZSV1piWVFQQkxuN2pXZHVzVkp3ZjY1SUFPQy93YkpWZndZSHdnRDIr?=
 =?utf-8?B?bWxmY2VmNjN1U2lOM1I1SGF4WGdGMTA5dmNQL0Y3T3dUSnZNK0xKc28rYXU1?=
 =?utf-8?B?YmN4eUE0SkFmTXpENzR6LzlUM0JpN0ZURHF6QWI0RW1SQjR0S2Rjd291RXBW?=
 =?utf-8?B?MThaSWx2SDQ3WVFvYjZLOUozSnRzMGFOajJxZTJqeE9zSjEwb1dnOU5uN2J5?=
 =?utf-8?Q?15PzI0/CRdBQQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkJuTGcxUVY5MEZ1czV6ZCsvTEhNeFQ3VGladUFna1M5S0ZFYTk1bWY2RFky?=
 =?utf-8?B?bXNpZ1ZPdU1vMG5XTFZERUxzOGp3dUl1VlEwMXpXeGFKYk5ja3ZOQW9JSzQw?=
 =?utf-8?B?bk5VQUdUTTB1MytaM3ZBUVo5R0RLU2JDRlducTYwbEhWSVl2dTJ0WVdSZ2Yz?=
 =?utf-8?B?QUUrenh0TnVwV25jRE42clY4VU5pMytoODR6aUwwMUpoZ1JxalJ6RGoxRmla?=
 =?utf-8?B?RkpHb1ZFT1E5UEhoQzdjbGNlakgrMjZ0SlZ0QWl0WWg1akU0T29Lblh4MmJZ?=
 =?utf-8?B?MXRMbFAraGcxcy9jazh3clZEMzh4c1NjaWFBZ3ZERjdPcVdUNmZHenQxRUM3?=
 =?utf-8?B?QVl6eWV6NDhkZWdXR3NncUVydmRDS1pzejRVdWk5T0p4VEdxTks4MUFZazVx?=
 =?utf-8?B?amNlZ1dleUNoWC85UzIvUDlPTXNqTkJ4RklPa1d2SnRRak5wTXAzTmhjR2Ny?=
 =?utf-8?B?NjArWG5ZZC9oN2J6Nm5RbWJ0MTI4RllkWGdZSDlQNkZwQlZ2YWttTjVib2ZJ?=
 =?utf-8?B?bUN4QVpnNVQ2SU1DQ3R5R3l0Y2VxdFVFeHlpUnpvRXdDOHZyUW1vbXQ1M2My?=
 =?utf-8?B?WWhqb3NrbDR0cEQxZ3pHS2ZBSEc0VXRJKzA3bS94clhBZ2htN2ltWTJLVElq?=
 =?utf-8?B?VFVQT3NFWHI0U2YrL0RtU0ZlNzZaTHR0NEN0VWZiajVlZVdaVmFSV3FFY3lr?=
 =?utf-8?B?OUc2MUY1SGVUUi9LNDBNWG1oZ2FQQTdWL1RBeXVhWkY1NmtCRDlDUWRkOUtD?=
 =?utf-8?B?bklOMVVIS3FSV21FZUljRzZpdFJCR2VkNVVtdVNna0xlNmV0aTg4c0VJcHNU?=
 =?utf-8?B?V2JnU0c5NDJoMzd1WW52MWhhNjhPdWR1aGQwd1Brdk5kVWQzZzVCOWNXby9r?=
 =?utf-8?B?TkUwZ0wvU1VhZkpQamlWakZGKzdGS1N5VXlGVWtGT0tKMFBmOEZsWnFaUDJX?=
 =?utf-8?B?SWpVRzBxSDZwWlVzSWkzL3N3RG1vc2J6YTZ1M21MN0s3VlN1U25PdGxsOWZ3?=
 =?utf-8?B?T3hkZTVHRHF0M1lBZTVaTTBkakVkQlpGSVI5eUk0d0l4dHlwNkVETDRtY2ha?=
 =?utf-8?B?b1QwUUpqKzVIcTRNSm9tazRrVVI3M0c4QWlDZ0gwSzBqL056ajZvVjhCd2Nu?=
 =?utf-8?B?VldIMEl0cU12QzJqaENUSFhnS3NEazBBKzNueEJib21LeWdzb05hdFJQSFhU?=
 =?utf-8?B?T1VjVCtJSEx0L3h6S1lkL1BkbUhVUjBJdGgxK3UrZVlxMHR2NldOQXkxR0kv?=
 =?utf-8?B?SVJHUjdKNDl3eVpwUEZhZngxL0JCU0wxeWc3TUlhdmFSS1JJN2VYbnlWSmI0?=
 =?utf-8?B?VS95TmwxeWc5Y1I0bWZqQTJORER4RmtxckV2dXg1SHZRZUFhckp0OGlmTkRU?=
 =?utf-8?B?ZjRIOE43L0VZRVE4d3h3OVVzbFMxSFZFTmRZTWwwVitjUVk0NklUVktpbEIv?=
 =?utf-8?B?YUM5dExGQjBRdk5ERUFrSlFqL0M3MVVwcTk1SjgvZDNISElSbzdOTi9BNVNV?=
 =?utf-8?B?aEF6bXdrOTN0ZVB3Q2JJRnBJS3BxbFlrTnRZS2tFNlBNSnlYaUVXMXJUb0ZU?=
 =?utf-8?B?M0xxUjB3WnV0dWYxTm5zNnlyVllZTy9sMS8xM0RObkhhbjRrakhEaUVmS0xS?=
 =?utf-8?B?TytYMHZ6ZmRiWmp5ZlliVXBnekJORnMrQytmNEtYUGZrZUFSWExSOGVwS2RP?=
 =?utf-8?B?S3Q1OGtJVjJtNXNjNGs5dXh6TWViYk81Y05tWEx6blN0Ri9zZ2Jaa1ZxMHRQ?=
 =?utf-8?B?R2Jha0dXclV1cHBLcHJubUxXYi9RM3VjOGlIOVNmSjM1TGVWMW1neWI2amw4?=
 =?utf-8?B?eUNQbGg5dml4RHpTK0toenhuWkFhZ1JIWi9Dd2V3emV4RjBJRERtdEk4MXA1?=
 =?utf-8?B?ZlgramNBOXkvOGxvcjB0L3lldTJZSnRFR1I5MWM3VmJMMXZsNUVhMmZzamJu?=
 =?utf-8?B?NkVkR0hlbU4xTE1JZlVaTGR3Zzd0WThtNENWR01iMnM5bTlla1IxcTkvTXFM?=
 =?utf-8?B?d1JBMTV0Y2dnVEM4TDJ1QUw0YnNSUlhEcGpDbDMyaEVnMlBDVDE1SGZ5a3BR?=
 =?utf-8?B?YThwM3hCNlQxV0tES2hwMFVOOEFQMTVxQUVnd09HY2NPcm44Znhrb1UzUTd5?=
 =?utf-8?B?Y1NBQjVLQW0wakc5NVNxWHlZTjQ2Zk5qSU1ZTVNOTDd4MEF0eTZ3UU1kYkg4?=
 =?utf-8?B?bnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5Fc5ERVTNX7xFlkYSmrA084aq5DppOgv7LM6Hgfq1yfoH4JtP7LTTjmbkS9TEWweYcKv96KlpHQZFegs27/PmM2UObtw6Gq/hmM3WipCuCSncGbS7JvNlpQG/X9+Irj6qHi/jh2KEA7olJS/U9BUJhqjdiPmt2um7NldUt7ZowZ90PKVG64aqzZVg/vwvp+2VDybGsUqak7ceRjKcbo1iNGHvem7ko0nmlr53UecXbNlRG0AaFk+pzQ5kYuwbtAKN/oyxVBeeo8mirsy63gXyQcmGWHUw7lwE7xzHjrCOR43S8FSwk1ms0FQGm+C3iTWTL+FBe3UI6T52UhbrFI8vk4AWxPtRqL1N72lTw8uINbgqb40aPKBpZU2cCBIOBH6FOkfba71Epouq/tFWkaO+FUs4COGATt0BJhUojXbY7EcIS/1pBqUqj/HQvObnfjyhDaSVd3GYGCC/0wqOuV34IcsIbnYE/HX85g4HI7nrT4NHtElkBdbyLO53X6r6BRHvUCdc+7KSUzDnDuZwF+Sf3QyqaSkkjRbVFBNSzfq0httogayRYF03+H7JKHi0yge/A3IIRjHMraPJRYFbKlYrYf3hqj72DfVLNWmREBNcTI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b5857c-f707-4c46-78b2-08dd4d038a77
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 14:26:16.1356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H8doVV6B4s/hDRvv/I900+oNJYC//nsr6DwptSeDONf7EEWZaG+pN5UBLMA2K1MXO3magoX1b4ZFfG3BX4oWbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4716
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502140105
X-Proofpoint-ORIG-GUID: ON7oSCw8oCKWXSDySZNrbPOh7KPF3iTK
X-Proofpoint-GUID: ON7oSCw8oCKWXSDySZNrbPOh7KPF3iTK

On 2/13/25 6:29 PM, Jeff Layton wrote:
> On Thu, 2025-02-13 at 16:07 -0500, Jeff Layton wrote:
>> On Thu, 2025-02-13 at 11:37 -0800, Dai Ngo wrote:
>>> Allow read using write delegation stateid granted on OPENs with
>>> OPEN4_SHARE_ACCESS_WRITE only, to accommodate clients whose WRITE
>>> implementation may unavoidably do (e.g., due to buffer cache
>>> constraints).
>>>
>>> When this condition is detected in nfsd4_encode_read the access
>>> mode FMODE_READ is temporarily added to the file's f_mode and is
>>> removed when the read is done.
>>>
>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>> ---
>>>  fs/nfsd/nfs4proc.c | 15 ++++++++++++++-
>>>  fs/nfsd/nfs4xdr.c  |  8 ++++++++
>>>  fs/nfsd/xdr4.h     |  1 +
>>>  3 files changed, 23 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>> index f6e06c779d09..be43627bbf78 100644
>>> --- a/fs/nfsd/nfs4proc.c
>>> +++ b/fs/nfsd/nfs4proc.c
>>> @@ -973,7 +973,18 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>  	/* check stateid */
>>>  	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
>>>  					&read->rd_stateid, RD_STATE,
>>> -					&read->rd_nf, NULL);
>>> +					&read->rd_nf, &read->rd_wd_stid);
>>> +	/*
>>> +	 * rd_wd_stid is needed for nfsd4_encode_read to allow write
>>> +	 * delegation stateid used for read. Its refcount is decremented
>>> +	 * by nfsd4_read_release when read is done.
>>> +	 */
>>> +	if (!status && read->rd_wd_stid &&
>>> +		(read->rd_wd_stid->sc_type != SC_TYPE_DELEG ||
>>> +		delegstateid(read->rd_wd_stid)->dl_type != NFS4_OPEN_DELEGATE_WRITE)) {
>>> +		nfs4_put_stid(read->rd_wd_stid);
>>> +		read->rd_wd_stid = NULL;
>>> +	}
>>>  
>>>  	read->rd_rqstp = rqstp;
>>>  	read->rd_fhp = &cstate->current_fh;
>>> @@ -984,6 +995,8 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>  static void
>>>  nfsd4_read_release(union nfsd4_op_u *u)
>>>  {
>>> +	if (u->read.rd_wd_stid)
>>> +		nfs4_put_stid(u->read.rd_wd_stid);
>>>  	if (u->read.rd_nf)
>>>  		nfsd_file_put(u->read.rd_nf);
>>>  	trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
>>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>>> index e67420729ecd..3996678bab3f 100644
>>> --- a/fs/nfsd/nfs4xdr.c
>>> +++ b/fs/nfsd/nfs4xdr.c
>>> @@ -4498,6 +4498,7 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
>>>  	unsigned long maxcount;
>>>  	__be32 wire_data[2];
>>>  	struct file *file;
>>> +	bool wronly = false;
>>>  
>>>  	if (nfserr)
>>>  		return nfserr;
>>> @@ -4515,10 +4516,17 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
>>>  	maxcount = min_t(unsigned long, read->rd_length,
>>>  			 (xdr->buf->buflen - xdr->buf->len));
>>>  
>>> +	if (!(file->f_mode & FMODE_READ) && read->rd_wd_stid) {
>>> +		/* allow READ using write delegation stateid */
>>> +		wronly = true;
>>> +		file->f_mode |= FMODE_READ;
>>> +	}
>>
>> Is that really OK? Can we just upgrade the f_mode like that?
>>
>> Also, what happens with more exotic exported filesystems like NFS? 
>>
>> For example, if I'm reexporting NFS, the backend NFS server may not
>> allow you to do a READ operation using a OPEN4_SHARE_ACCESS_WRITE only
>> stateid. Won't this break in that case?
>>
> 
> Hmm...bad example since we don't allow delegations on reexported NFS
> these days. Reexporting Ceph or SMB might be a better example. They'll
> likely both have problems if you try to issue a read on the result from
> a O_WRONLY open. I think you will probably need to rework the way
> nfs4_file's track their struct files.
> 
> IOW, when the client does a OPEN4_SHARE_ACCESS_WRITE-only open, you
> need to get a struct file that is FMODE_READ|FMODE_WRITE to hang off
> the delegation. But, you'll also need to fix up the accounting for the
> share/deny mode locking to ignore that you _actually_ have it open for
> read too in that case.

For the record, I agree with Jeff's suggested approach.


> Smoke and mirrors...
> 
>>>  	if (file->f_op->splice_read && splice_ok)
>>>  		nfserr = nfsd4_encode_splice_read(resp, read, file, maxcount);
>>>  	else
>>>  		nfserr = nfsd4_encode_readv(resp, read, file, maxcount);
>>> +	if (wronly)
>>> +		file->f_mode &= ~FMODE_READ;
>>>  	if (nfserr) {
>>>  		xdr_truncate_encode(xdr, eof_offset);
>>>  		return nfserr;
>>> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
>>> index c26ba86dbdfd..2f053beed899 100644
>>> --- a/fs/nfsd/xdr4.h
>>> +++ b/fs/nfsd/xdr4.h
>>> @@ -426,6 +426,7 @@ struct nfsd4_read {
>>>  	struct svc_rqst		*rd_rqstp;          /* response */
>>>  	struct svc_fh		*rd_fhp;            /* response */
>>>  	u32			rd_eof;             /* response */
>>> +	struct nfs4_stid	*rd_wd_stid;        /* internal */
>>>  };
>>>  
>>>  struct nfsd4_readdir {
>>
> 


-- 
Chuck Lever

