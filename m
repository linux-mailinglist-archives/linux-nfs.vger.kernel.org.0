Return-Path: <linux-nfs+bounces-9777-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4BAA22702
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 00:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A88C3A3C7A
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 23:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E20A1B423B;
	Wed, 29 Jan 2025 23:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NAd+8HgS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="deLEeBVm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8801A2398
	for <linux-nfs@vger.kernel.org>; Wed, 29 Jan 2025 23:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738194601; cv=fail; b=DY7b6ZhZ6Wr5lIN3qiyHUv/87PFy/GnrJJzb3RFYPX7WFlVPFS4UEa3Vto3uFBWsz9Ny9wKMFVS3X3gOwBpeqP+mmjm/HvyxAB2+hv9UdEtULZU5CZWFzwHEgQs3if9cTr7VJbykpwfBKyJVKv3R+4VJArcOjKjUVjpITzY4O24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738194601; c=relaxed/simple;
	bh=SelPxscMomeRLb0/1XHrxymaFieD29MzLsVL747A/R0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tJMvblbjh5foDou0DAbkck5xgKjsX204vRgmogZNWDo/Fs/hN0/eFGVWd+ezA0It2Yp7Nj6H38CBQZM/QApHO4pu1HZXeodN5n6RlS7LuvQtYXIKxBeCkObJ9LvEv8j/SQ65eiDoO1nmYottU3Faulb62HRNyUBC164dbmvGKlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NAd+8HgS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=deLEeBVm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TNboUK006415;
	Wed, 29 Jan 2025 23:49:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ml8lXHuCt7JqMnrAioZYcGbKhooafN/MssDutALcTQY=; b=
	NAd+8HgS2V1UTj2wsoh+BA2WP5FijQk3fby2j3CGkk/FWID8WUurH6UrQJdYy5nd
	bwecmgYlBZ0pAGixjtuG7mod2psc7xMIE1n1pCCikANYOYXWq0KcPJlkWyrbb3yT
	cnsG3phiOdChEweR62njt5XsO1UYzWVZRSW3B7FEx46AyP5NtA25aUaMkiSlZU7K
	hoj+nXKWLeCDEyzR1xzOCosRD5pbQBb+5yjubcW1o5KQ2ULyQdu8PZYaUSUiicgj
	WkD2nnlUcxQ9VtoFlZuBaz/s1Opq6EedOQ8kejRHfEimSU2Ydmzn5RqN4KIFuyEU
	ioUpa30IwZvIFY265J4Jpw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44fx5fr0cd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 23:49:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50TMPGqf004278;
	Wed, 29 Jan 2025 23:49:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44cpdah7hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 23:49:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ASoBzxCDrSmU/UJULyq+4w/5x98EDnaKRCnl8FP6v8mbhNcEomLn7JC8bNyQK9BlJaiVCipRchgHsakWM5xquiIV1R+4C9lcePHdXe0ij3CgGENyaweZ+5SQE7gB14rARoysOyEu0x1pDTH7qNOLS/MozYzStfLCbNGhyFDZlQRx+Fjc3KkhPhkQnjp2g3GVxp7zpyUbYFAx61g59qHjXKLJ+zSJJTYqt/C07c0jwP/LS3FFsXE7UxS0JBjAMmWc9tZRr9iKE8e946VFzYWp06Jz9RfFE2rLErcsv5uoe4hfO46a7yL8ndqpLJ2eLkhPVu5HfTi4tIOEfSfu1K4DLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ml8lXHuCt7JqMnrAioZYcGbKhooafN/MssDutALcTQY=;
 b=boO8mzPyD4rl6V4QjYAPGf4bXRwppsJ55yEF0B8J79p3SVP+7zyii0ZaJfwLkWMdUDDmvvOXmY8qnX2o5eTmxTf7UI339awTaFo1P3lyFGMpij/LsST0Y6UpJCpQk/r8pmddfrB9eU7FgmvU0zCWY8Eq5Snz63Ccuyci0v+DvLNcFsOkhH6fCub48cLPBQp2dNRcAEsOyyT8GjckOEpxRS8WN/paTuGCGm4rMuIG+hfPGwISBohfFQaDW8Ly1jP8fm3MZiZiOTPDGryQiTdmWG3/kaQWXTocEbK3+enwt+PYDHFFiFrCLgEm+p0jcwSuEUC/zBm1a9EYnwGNGoC6Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ml8lXHuCt7JqMnrAioZYcGbKhooafN/MssDutALcTQY=;
 b=deLEeBVmb8gkdnI2VdK/zbau9VUJtv22a7WeWUBTmYaHEbmG9qw75dNWvLKLjz8xkXNjQBPlh6ZmM4g00pBmwDj1V9ue1PQk9hjsJpUK1uUpViwmEuXcuGPARSDAQJQrxYPp8q5pDXLQ1ciwxWu4+Of98ridIw9ShKValldMWwY=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by CO1PR10MB4625.namprd10.prod.outlook.com (2603:10b6:303:6d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Wed, 29 Jan
 2025 23:49:48 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 23:49:48 +0000
Message-ID: <fad58b9b-fbbd-4cae-acad-af527c80622f@oracle.com>
Date: Wed, 29 Jan 2025 15:49:47 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSD: fix hang in nfsd4_shutdown_callback
To: Olga Kornievskaia <aglo@umich.edu>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, linux-nfs@vger.kernel.org
References: <1738185446-7488-1-git-send-email-dai.ngo@oracle.com>
 <CAN-5tyFsAF_V2-unOm5ceenzMnPZxyrfKeGWctRsU4LLWB+JMA@mail.gmail.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <CAN-5tyFsAF_V2-unOm5ceenzMnPZxyrfKeGWctRsU4LLWB+JMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0022.prod.exchangelabs.com (2603:10b6:a02:80::35)
 To MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|CO1PR10MB4625:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dffbddc-a1d6-4b94-2993-08dd40bf9dc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFE3cnZLQ0JxZFFVSWlmMS9RNEJFc2dKbnhsamQ2Y29HWm1JMTNlY3NwdjlZ?=
 =?utf-8?B?dzlUT2w1a0xqM0VHWm1XTVg0T1dYQXFpRkNmZ0trQWFHOHgrb3UzRkUvYXd2?=
 =?utf-8?B?RUhsNGlXZ2VPOHl6ZGFHanVYRjRzUWQyRm1ycGlPWGdxR3MyWkltd1kwTDBr?=
 =?utf-8?B?VitBcVMzMEVzOVBxdGNxclVyUWJSVXNQVDBIWW1LSzlDSm8rWG9RVXRMb29U?=
 =?utf-8?B?em1WS1FLZkZuK0U3UXRGWGhQRGpsWmVFVWh4MUlQb0RjYndUNnphWCsyNW11?=
 =?utf-8?B?NEhHUnh0WStZRXBnMGw3QnZ0MU9GRDRTNjc5akxELzE5Nk00RjZWWTRrRDRh?=
 =?utf-8?B?ZzQwOFhGdTVYMm9GY1NUZ1VEL0J3RDVRQUtSM2xQQkFmbzJUZHZXODBySXlp?=
 =?utf-8?B?OWp1MnJ6QlRxdUM1cU92bWMzTG9hZkNROVpjY3l4K1o4eHRsYlJLZE1VaGV1?=
 =?utf-8?B?L1c5Y1VqM3ZyUmF0bmJBMS95RnV3dHA0Tnl6Sit5M2FoT1dtNUpsbzlVQyt1?=
 =?utf-8?B?Tk9PZGRBNzZ4TE5RdStXbmRxZEJIclgzUVQ2R3l5OXRhTm1PU3M0VThVZ2xL?=
 =?utf-8?B?S0tVVkloSERaZXhmeEhOZ3NXam5yL20wSDM5cERYRXFDYUtUT3BSZGdrRXda?=
 =?utf-8?B?WndUaWNEcTFwSXhSYjdFMDQ0dUxSYlVweGx5OXg3c3M0bGQ2aldOUkRJSDU0?=
 =?utf-8?B?a0N4TnVRZU1NY3NyN1BpTi84dndvOW8rS0E1S3dUWlBsSTdpY1ZIdUU1OWgz?=
 =?utf-8?B?UEpmYmg5UEtMb3gvNkhEcVg5eHJENWMrbUNSWFpybDNCUEdKOWhZMjgyNlJu?=
 =?utf-8?B?VW9PeTNSczdBTGRGV0JiNHFiWXJhcmVjUDJ4bTdhZGZLcGVRallXbElHc2J1?=
 =?utf-8?B?TjNpTTQ5ZzFXeFJ0NmlXSXQwVUhnSCtZUDlOVzZidWZ4OEwzeFZjYUtTbzZM?=
 =?utf-8?B?UU9WekZPRXN4MnN1M3RpNDFHODBCWnNUaEswWHcwM082SlRRSU1iOFJFa3pr?=
 =?utf-8?B?RzRnK0U2Y0lxd2hYSldqTmllenk1amFHSmVBZmluVU1ibDVpeUhweXZjSkdr?=
 =?utf-8?B?RFRhZmtxMWZodldtR3hGdFcxRVIva1VEVHk3MmhJTVJpbVFlOGw5WVRjUEJN?=
 =?utf-8?B?MzZrc2pRcnlQSTQ5L1B6emNmY2E2LzJlaHNVeWRYMHpUTUNHZmU1ZFlxNGJ5?=
 =?utf-8?B?ckpLMDBEK2ptaTUzZkFBbzVieFNVRnhBenJnVWZaeW1TWFJqWk5MbVlEMjdS?=
 =?utf-8?B?WC8zMklEcXFjVE44NFpsMldoV2ZXYlh4a1JvejZ6Wk5IV2JmOHd2alJ0KzYr?=
 =?utf-8?B?MUdVVTJ1b2tYdGg1Qnord3JxVkhBQkZmaVBiajJGM1FuMXBQcUZGT0p1Uk9z?=
 =?utf-8?B?Qjg0Z01rWjRCdkZMU09sSTZDTElqWUVHOGlSclltMUFXa0Eyd3U1MkJDQzFF?=
 =?utf-8?B?Qi9UNC81VmRSNXU0dVgxZ1M0SE9yZ1UzdEFQV3llYmhtZWdScjlwaUg4cm5D?=
 =?utf-8?B?ZmNyK1BUN0pPRWRxM20zZXFZTTZZU0xUbHJrOXdoYkpqV0ZvSnVSZmFXTzNx?=
 =?utf-8?B?c2F2TWI2S1g2V2FJT0UyT1FoT1JsSXo1elhWR0NPdmY3RXNVZUJWNTIrRWkv?=
 =?utf-8?B?dG93bzdZWFFxazVzcjFBbENhSkZwdnBFL0xYTXlWQnRoQi9VQ3piNTQ0Unl1?=
 =?utf-8?B?MlVEK0ZHWmFNZ0JXelVIZ3drYStFMHhaR2UzdlovMXIxRC9MSGhxQ2FrQ0hK?=
 =?utf-8?B?UC8zSytJOGltWm1QNzRzcS96cGZwc2tYVnZRYlBzVHdaOWd5bVpzblVBNWlt?=
 =?utf-8?B?Y3dVeTZQdHc2WHhHSXI3enJrcE83Y1NJcEpTZVh6RXMweEd2bDhpelluaE5o?=
 =?utf-8?Q?9Fj8G6qhib7+2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEhGbFdRZVlESlN4Rm1UWlphemVZNkdmVGRVSGZMRkR3amFWQ0pxM0lTbjlL?=
 =?utf-8?B?VFZ1NTRBdktpU2Z5cUNxREJ2WUx0R0U5Zzk1S2VkS3BvVDFiallBekJEeVEw?=
 =?utf-8?B?dzUycURvM2lRYUNqQWwreFlqcFZoVWtBelduWllaWFB2dnZDL0xSd0FsL294?=
 =?utf-8?B?eFJMNjI4WFlEU3luM2FwWm5uZ1NMMHdENm44MmZLVFpucDZrOE5NYzk3UVZM?=
 =?utf-8?B?ZitNVGpOcWUxVklkUjE1aDlONlM2SFNMY0RUam4xdWdJWTd0Q3l0SzZIUVhB?=
 =?utf-8?B?M09yWnAvTUJpTzl6L21kbVBQTU9qekY4YTEzTlNsRlhIREtpZ05ab0R0U1Bp?=
 =?utf-8?B?M3BDaTNnbUpNTlNwNWdlWUsxdUVQeXpoUzZIbUY5NmxGTkxPZHhlRWQ0WmE0?=
 =?utf-8?B?WCtZKy9MYU9FWE1LMVBTR2NqYUhTZk1vcnlKUlNMbm5ieXhBSW83UzVNdzl1?=
 =?utf-8?B?NmNoY1VidFQweS9xVHZSOHI3eWRYRXF2UU9temRxVU9lamFwS245TWVPdzhh?=
 =?utf-8?B?MmxHdTBFNjhYMzB3OWpzSU1ub1p2eU13bkZXQ0xoV1RxUXNIU0xVbk1RemJm?=
 =?utf-8?B?MUErdGVGUG9nVzhxbHdvcDJ0eGUrTExjUDlRVTZZM0QvN0dRdklqWUpBVmZ2?=
 =?utf-8?B?QlJXem1FTEdNRUpSQmZ4Z2tPSUZkcW1udVBWc05KZWNkcWhTeVV6dVdncVNk?=
 =?utf-8?B?UW9CRjhDamFCcDI2MlJQelNEWVo5TTlWR2RMQk9zT1dNODBZWmNVa2Y2OW5S?=
 =?utf-8?B?K2tpV0tCZTZaOXVOdXNibHY1RUZnU1BoaTBjcWxzcUE4Mlg2Nk10bVRncnJu?=
 =?utf-8?B?VE15TTJidjE1WlZsNWVSTDNza3NpYlNkMHJqZ0t6bmY2V3ZtdlBpd3phaFAw?=
 =?utf-8?B?THBOWGgrVGl5bHpKc2JQM04xVUc1eVRvTVlVSjduQzA5SzlERlpOMnJNNm5y?=
 =?utf-8?B?eDdZMDFXZ3kyS1ovOVUwQzM1Nk9ranFOVHdabm94UjV3MGxrVDhsdWYrUUQz?=
 =?utf-8?B?QnQwQWdPV21kKzNLdm9acDdYOHZFdjFlblFxeEdhbENuSmY2OEJIRXJzNUQ2?=
 =?utf-8?B?Skg1QTBrajl0ODBad3F4NzRxL2VDa0JaSms5WjlvVURnUzdqVG1lamVxd2pU?=
 =?utf-8?B?SzRhY1c4N3RXWkRkZFhZSm1kR3UyVWlCWHhFQ3g1NEZpR00rT0t5NFNGZTlu?=
 =?utf-8?B?dE1CRGhMT2FuQ0ttR2h3dStOUnFUSTF1ZHJUT2NnWjFqbkdyU0VGMlpHZEZN?=
 =?utf-8?B?eHNtbkp0a2p2WFdnd3pTckV3cElEc29sbVRoRWNrZ2Rrc0gzZ0lkeWx0c1JI?=
 =?utf-8?B?cVIxazFTdjJLTm9iSkZnNTRhZERlVkN5U1NHZHZ4VGNPTGt0UER5WWgyaGRy?=
 =?utf-8?B?M1Z1SUpkeWNGTDFMbUd3b1lMMUJkNmd4VDV4ZG9lQW1VYVZRUGVPNmNzclZG?=
 =?utf-8?B?MUViVzliT0t5WjdKb0VFbXk0eVRrRW1iYXNnbjdmNUIxcHZXdmtTY1ZjbjBm?=
 =?utf-8?B?OTlhTVBZTGFKQjljZ1NJTG5SdlgzalozUldTb3FpYmtvT0FUL0FHQ3VGbGla?=
 =?utf-8?B?dnVjdFpkZGdIZlpMd1FQTHdNc29LNFZDVVpoQzJCNlBtdnpUUjRsNUt1YzZH?=
 =?utf-8?B?cC9JN1NJdU5uUW81Y3hsaW1iNDBMYnJ5VTROR0tCdUZBQjRrc2UydEtZWnA1?=
 =?utf-8?B?L2hic253dE5zQ3FNbmdQOVBPRDVNSWt1dEd5d2YwR1M3VklRdXRaR1pLdEZz?=
 =?utf-8?B?U3NQRStkUXhRRjhKb2c2YXJlUUozU1V4M1NwaWtRRWRHRzliUFB5eWRqOXdV?=
 =?utf-8?B?MW9CcHpxd0MwN2d3d3A0VE5hMDBBYzl2bjVGNmNEcnNveTl4WU15N21mYzRR?=
 =?utf-8?B?aUhucDh3bkxiOVRsdXJ5RittajRaWHRSM1FCRVZLaXNBcGwyd09tMVo4MElx?=
 =?utf-8?B?U1hqT1FlTzNDU0dUSnZobktMMzhQU2YzNHpHU0ZocW9xc3NtanBmc2tld2pz?=
 =?utf-8?B?Zi91WGFxV2JUOG1WanA4S25idlUzQlYvV3lMeEhxVFRYZ3NNcnZ5NGpQN0w1?=
 =?utf-8?B?aHNENk11QUw2T1B2a1pFVTRRMTluSGF0NklBbzhWeWJPK0pCT2ljVHVkcUpJ?=
 =?utf-8?B?anZQNGkzeGJhN0xMYUI3cVpiZ29tMWdFQk1nSHBlK29OYkE5OG9lLzUrS0RV?=
 =?utf-8?B?d0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9RHSDfAGhV31SW9HCmBG2iMYVyWqAhTiO+5HW0nI5tA5bytS+3vHq9GglaKH/7NSe10ls4Y+oOl5E7xEJowCrGFO41YpDQsuLvbor3nr2VRbbpKODo+dDTlQijwln8lvdbrXNS+IG3keYrrQbwPCxzNuhA1uik6S3poPsw+xsSFrFtkqBjYbWXYdzagVP564iYpaW7kED9nA1mhpayeTSyOagfICzx7oHPVSiGnRPTH8riB5BWK0l08Vv8TqQ2NLjy4w1TtiMLO0ppDChaJ5e7kvPThJAeqa6D1WOVl9VtJQ61PI+9xQJhYyEHg5J4xdRoyaTPSGAu2nlQYJk96Ia1FxAgVZBe2EJAVhwVG/cTFCqte2b6goF+LrvXAdT+/ZTDNqU7oA/u5brvC6eA2930R8YrBj7BSl7qyMn77+kahKxSlAKUki8s2vqqUzfzazDaAUjj5OmVLuhpHZtivKVZFRfFOAg0eLYyPhQBg/AsG8SS0ciAeVZGBfUHiC/c6LSwAkguh/OKl4gbVgUSFElf4Mb79odo7HoQbayp7iWxZkqDD5f+F/M0D1kZdtf7G1yi0n59vxjliR5HgwMm94GOBzszZCHpgrKIPUclz43TE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dffbddc-a1d6-4b94-2993-08dd40bf9dc6
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 23:49:48.7584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tJGUq3wfB+Xj5MUB4WcKn7wpNNMQhgYLEKNb1YKgWLLdhfNYa9U+MEirIVabFKgzKFsNrhnx4zyTQ3YOP2fcww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4625
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_05,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501290181
X-Proofpoint-GUID: l4heGUFcMX91PH-goXEsdGMKlHxIJtam
X-Proofpoint-ORIG-GUID: l4heGUFcMX91PH-goXEsdGMKlHxIJtam


On 1/29/25 2:28 PM, Olga Kornievskaia wrote:
> On Wed, Jan 29, 2025 at 4:17 PM Dai Ngo <dai.ngo@oracle.com> wrote:
>> If nfs4_client is in COURTESY state then there is no point to retry
>> the callback. This causes nfsd4_shutdown_callback to hang since
>> cl_cb_inflight is not 0. This hang lasts about 15 minutes until TCP
>> notifies NFSD that the connection was closed.
>>
>> This patch modifies nfsd4_cb_sequence_done to skip the restart the
>> RPC if nfs4_client is in  COURTESY state.
>>
> Curious, does this patch address the problem seen/discussed in the
> thread "NFSD threads hang when destroying a session or client ID" or
> that is something else?

I'm not sure about the symptom in 6.1.y kernel.

The problem that I reproduced here has the same symptom described in
the thread for newer kernel; NFSv4 callback shutdown hang while waiting
for cl_cb_inflight to drop to 0.

-Dai

>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4callback.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>> index 50e468bdb8d4..c90f94898cc5 100644
>> --- a/fs/nfsd/nfs4callback.c
>> +++ b/fs/nfsd/nfs4callback.c
>> @@ -1372,6 +1372,11 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>>                  ret = false;
>>                  break;
>>          case 1:
>> +               if (clp->cl_state == NFSD4_COURTESY) {
>> +                       nfsd4_mark_cb_fault(cb->cb_clp);
>> +                       ret = false;
>> +                       break;
>> +               }
>>                  /*
>>                   * cb_seq_status remains 1 if an RPC Reply was never
>>                   * received. NFSD can't know if the client processed
>> --
>> 2.43.5
>>
>>

