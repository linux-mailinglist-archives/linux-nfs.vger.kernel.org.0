Return-Path: <linux-nfs+bounces-16581-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C25EC71096
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 21:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1776D4E0312
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 20:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A8A372ACD;
	Wed, 19 Nov 2025 20:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KlJv3Dzl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Xe9Ek7G+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6642C372AA2
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 20:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763584351; cv=fail; b=Wzu66+CwKHZfEYhcVxXUK3+6G9ffnhX6dHFpS6YuHxUYYZCYehJWTjdHbMFPRYwr6NBCf/0dkwMdzRxbNBKWqoGge5Q/SfAbItT+33KfVdTMKnNN3SSqwnLvTlMW9d9rrI0ExSs+m9IH2c9xpZQOyWyqw7CYkmP3qgc5Zwbo2VM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763584351; c=relaxed/simple;
	bh=NSZMR0bdmKTIeLyWkBiXCwgmO9MyQejTu5p/Whur91o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DyBrFsPk/giIBZ6t2hYd94u3ZKX4BE1qujjeT9N9I6GDw+j0i0x/mXeNojcUStFgE/xI+GzybevBCS504BPT8EtpYxDpj3Lqx2M1f7Ots/2OxO2jGvir4mb+gDlPe4CAGsU3DVqPLZlazvVUrvex4cTRSC5JHmD2M97VLXbipcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KlJv3Dzl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Xe9Ek7G+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJJCMYg016065;
	Wed, 19 Nov 2025 20:32:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=VpBAtTbaqnpwZViJLEh4N/f6CKtwCrKsGQIGsId5xyY=; b=
	KlJv3DzlrZ3AxTofFlXByG+hZ7xIZkT4s19k9iubxnlITSlLBx6N1KPOWgqjovCD
	L556JAEKkK90aH1T8A4LuF+06C/WTrHs+Pjhsk59a5Q9LRuE5D1uUrCbGcRiDjdr
	tODzosc13Wt7EeAHh0aK+ZrFEI5fb1T4AFjFaEIFnWXFyCZGe4AfLCx3slBm6X8W
	IEle6HZwuNxPuZHtvpv7KWqovOVfcGUdMB/FRiHyobwO9JarS6V9jpAt+x/zRRLK
	rJsxQEhZkj9yn9mFxmS47daMEA9VDtI9sGZfhMufsh8WP34ZhmWGg9R5J7fPrSKl
	vsLkcVvYA/STmFt/txLNVg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbbysqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 20:32:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJJpGnM040040;
	Wed, 19 Nov 2025 20:32:22 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013039.outbound.protection.outlook.com [40.93.201.39])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefynefp7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 20:32:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CxA/NnJlm66ATTQd8EzpEsclpf9/lx9TG3gQw/xjSHWxS0IlC+yhChAao4ckzwOfUrL3W66PbqmN9QR0gw6Sd9Z5cyCBFsChifDi61uujCiEHVxSVr7pN2qTEXuOVAFXFHX71PnS73D+sjCKngEUFP37ZP/Ck0/Pcp4yw9H/rCPA7ELZTuWcMg7XoMn2DbAC/lMMtDQsRIkTBLz1G6Jo/x8Ru6BT2ntJfsjwx33+I7hs2BiCDjdNxuKSV8jwgzuL7qfS4FtkWxGIb9aSEcCgMKrUCSfxEy3q0gmkJW0S9yZtH1P4DZfPIcqDy2mcdj26j5A2vXLuV8aZZltH4t28pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpBAtTbaqnpwZViJLEh4N/f6CKtwCrKsGQIGsId5xyY=;
 b=AqK0uhW30cWOpySiUPiel7zrDkEWF/2CpODXWjH1Jepw0SWfPa2FV8zi3fXF3kvwQic1LID/WBzmaPzHfKBY08KNeCr4cKTekd5Rgdvz/JvB7gUI3i5xvQMY1OS6Dkbsra9gd2nyr/c6cBWB7xqfk5L+pMrqvmneAhVpxTLhWnm2hnCfilAOiFLZR7YnXMvldqnksy7UOs5WOBTIDKv+x/Sj/V5w3g5LHGi2hknGtAc7ABfbG3Fq2MLvL+b1Si9ODfsQPxeBimAHXwHplf0zMoavIGKL6cf9OtcaaxfOwPVPAhqo17WnQLvTT5+HRJGlyNOd5BTDK2fCgvuoA8/LPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpBAtTbaqnpwZViJLEh4N/f6CKtwCrKsGQIGsId5xyY=;
 b=Xe9Ek7G+yon5w1LN4hOqUpFKp8lgQ4YdeXnTVI6DVoDN8cYm1e7iyJwuMI0ffMR+gWYKRR8iblRpwhxziYTAqDqjH7SFdi4OLes6nYvluodDwt0rvEJPwqQS4BNJXUdk55l6Z9r6z3wlL+2r1Hl4CcmeULF6Gn3B0kbnTAV3dxQ=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by SJ0PR10MB5717.namprd10.prod.outlook.com (2603:10b6:a03:3ec::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Wed, 19 Nov
 2025 20:32:13 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 20:32:13 +0000
Message-ID: <a77b154c-191c-459b-ae05-491ebdd529e9@oracle.com>
Date: Wed, 19 Nov 2025 15:32:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/11] nfsd: assorted cleanups involving v4 special
 stateids.
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <20251119033204.360415-1-neilb@ownmail.net>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251119033204.360415-1-neilb@ownmail.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:610:52::12) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|SJ0PR10MB5717:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aba6919-58af-4a9b-fc23-08de27aab88e
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bTJzMEZ0czdNN2VZN1Zic3NCcURxT1FnMWl4MzdUUDJZZU1VelFyNk1PMkhh?=
 =?utf-8?B?UDMrVms0YmtNT0FzZDVET2hZWmhFZkRLZ1MxQzhadW1DTkNvRXVPMFVYU2Fh?=
 =?utf-8?B?aGdWampzbUtQR1N3RXBQWERPeDV5SW01YUhsZjE1QzE0RE54TEl1ZG1Rai9W?=
 =?utf-8?B?QVZXdktDMEtGZnRvOTllRGV0TEpXOGhFMUJOTmVla2sxdUNUZFgvTVYxVVVC?=
 =?utf-8?B?bDhuaFo3TmZjQUNLYjQzR01EQVJzMFVLekxweWZJN2VXWTY2bWtQcE9FaFNF?=
 =?utf-8?B?a0tva0hiUU1GKzRIWTFwTWN0THBjUkxqdU1wRXFMcUVkVU9ZdHBIQkNtZVFW?=
 =?utf-8?B?aHoxZmtWLzFUeUJsdWs4SGpNRTEvTXJHbUhkb0ljbWYzZ25WNC9WbCt3Kzk3?=
 =?utf-8?B?cG1PNUFEUHdoYkZFZG5abXpYVG9uVjZUbnJ4NEh1S0lrOXFvL3NQTWJyNEE4?=
 =?utf-8?B?a1IxdVZBeDRyVVNkdDNSMlNZNU44L0ZwSm1pYWJVdGpXNGk5YmNJOWRvOWVD?=
 =?utf-8?B?VVArbWEwVklnYWNsRktOZDg4RnVaRWRDaHBmOUsrV1pHa1VhUk1IU2tiSWVR?=
 =?utf-8?B?NlNBd2ZRcTVVb1prVjZERFhNU0ZVLy9rc1RFbkJJeGppWTc1bDllV3prRHMz?=
 =?utf-8?B?Wm93NTVOT25mdldDN25NWVNvZVRqb1h5aWxUNFpJRFgrenBpUFk5Z2hDOFFz?=
 =?utf-8?B?cVBOWnZTQmdPZWJIUnJ3R09KN3JCczVFUW5BZUFKclZxdFZUUWhqbk1QWWJ1?=
 =?utf-8?B?eEtIMmFvWkhFRFRzRXlqZ3J2bVdad3N6ZURpMmpEblkwTlI5bDBYN0xYU0U3?=
 =?utf-8?B?THo3OU9pOU12MUx1OWRLNXJWUW1OTUhwRlFGcFdYK2pGL25JSUhYOXJ2UzZW?=
 =?utf-8?B?ak42NmlrVEJ5UzRjRUFlV2dvbmwxVU10RHVyd3kzdk5VUS9GY2RwbmxXV2lX?=
 =?utf-8?B?c2tmcHYxeloxZDh2OVM5Tm1ZSm5rL3EvakR3VEJKcmhQbk01NXBsSjVWOFdz?=
 =?utf-8?B?WmpsbTk1akNQL3M2QTd5d2gyZWNPRGExcTkzaTBvenpvK28ydHlySmp3MXFH?=
 =?utf-8?B?OGtoZXdlanRsWlltZUZlMEM3aFQ4K2tEMm1hY1c3bkFtL2dUeDVlaVNVYTNk?=
 =?utf-8?B?bjMra1k3dTJrbUk1TXljNlJzd2gxMWk4WDlvYUhjeXgxZHJhUmJGdkJxTzVm?=
 =?utf-8?B?OURyNldpdHBDM1VKVkFUdjJPVUFXVVc3VnVObmVGbnRZY0VVUU8xbkNqUjJ2?=
 =?utf-8?B?SGNjUUtmUnJDQmgxUXgwZ25FN2ErNUZJbTBTOG92cTNGeVUyYXhPd3BXRy9R?=
 =?utf-8?B?SmtGbFZyTlhjS08ybkw2VlFUZk9RM0FPYmQwd3RVa2hGTFRtc3dNSGc0Vyt1?=
 =?utf-8?B?N2JCeThzUXhNWXZUZlFLcXY3Ym8wUlEveHJ6SVFGS2pQekRXSFppWVBaYlg4?=
 =?utf-8?B?RFRaK3A1L01Ia3JiRk1ZeUExcEcvMTdudG11WkJKUnNqbHNEeXM2SFdySm9Q?=
 =?utf-8?B?Zm5tZ1VnbEVwSW1CUWNzZ0ZPOUUxWFdiemhmTFoyUC9LaG5GYzMwVG1BNG1G?=
 =?utf-8?B?QlYrNm9kTzJ2NDdWSkQyaE9EV1pjMFROT0Jac0JBRnFqZkYzKzNqRnh2RDVj?=
 =?utf-8?B?NE00WDlqQjErTGVDL3hCTU1LZWVpNXZVM2ZmZFM5WlMzQkZpYytqcFlUN2hz?=
 =?utf-8?B?UGtDNnFTd1MzSDhESFRWYTd2TVl6b09PaXFWK1Y2SlpCNVp2TlYzcW1VN2k2?=
 =?utf-8?B?L0JmOW9nWFZyODhwM3lEU0lKVmZ3bzdzaTZFWC9ZSElmdUNoUHB5RmRxU3o5?=
 =?utf-8?B?LzFXNWpoTFhEdk9yNDVLZElmaHROd0U4U0NrejZld2ZpRmk5WW5hL2FCQUtQ?=
 =?utf-8?B?MGFyU2N2SW9LNE5DNlZOQ0pkZ3lOUElLRjlpT1JibFpZeWhTMEdzOWd3ZzU0?=
 =?utf-8?Q?UW51ARCZRrHhbV7xG8oFzRINvLEMIiEY?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VWtHVllqUGxiVmQrUm82Um1ycUE2MWVxN2dOUXFKMXY0Z3d3UWt4U0YvZTgz?=
 =?utf-8?B?NXBkN3JMMk96bGZIWTg3ZkwzbHNGSGI5cHhreENMR3ExWFppeUd3WDQ3WFdJ?=
 =?utf-8?B?czd1ait0MVUyV0pMY204VURaaUsyUkY4MlVxOGhzWUhPWDdoZWQ1allTcG5R?=
 =?utf-8?B?YklpeFpLRGpOb3c1Qkp1RjE1QTBCSVRkV0ZNbHA2U25jRGtQWENuNld4eWw0?=
 =?utf-8?B?c1o2eVI0RHpNM3diT1p1WFN4TVc2QldNNm9INFQ1UjJUV2FFSWs3UVZOTGRD?=
 =?utf-8?B?dEFudEJveUFSVTlKUmxmTHJVbmFRUjJDZ0JicjRqRlJ6Ujg2dnk2TmVBOXlK?=
 =?utf-8?B?R0lzaHkzeHRMeWJjS001L2l6SmlTcldzQXJYNWxKeVZKUjJzMHMzS0hEV04x?=
 =?utf-8?B?aURaaUd5SFZVWGV2bG1OTjF0Z05MTHVNMDIrY2FQeGE5YllFVlN1amNZMFZJ?=
 =?utf-8?B?MW5yNC9ldWY2SmIyQVB3b2lnaFU2V2crWnR1RTF4bWl6M3VYNXpCUWY0WnZa?=
 =?utf-8?B?TTFKWVdUVnplbndSQmk3Qis2UndSRHJaSzdvMW9wKy9OOUlnbFpkR0QzWU9i?=
 =?utf-8?B?ZE5zcXFBT3k2NHhZT29XWGdaSSs3TFZudTRlLzJ0WGQ2VDhJVFNENkZRZW82?=
 =?utf-8?B?ZHNSVDY1UHlUdGJQeG9ZdXNPb1JUN1UyRmxYT05kWGNXL2tzck9kaGYzVDd0?=
 =?utf-8?B?cE1MSERqcGl4QlN3cEY4Ri92cUNXRFdKZHNES0JTWWVPZ29DRmF5VW9hTjNl?=
 =?utf-8?B?YVRpMjRwdGp1RmhIaTBxbGdDNFVVT1V5aGpnbVIwbXgvd2FUalZvcW11VWhj?=
 =?utf-8?B?a3g2cjc3bm1SSzJxU1d1SjBFeFVTY2k1a3JKazZZZm9BbHRXMnFzS2pxT3Fu?=
 =?utf-8?B?SWR4SHdrd3U3OHRWMUtlRjRGaTRSQ3dGQmFvTGpxeDYwME5nWk9mSHZwT2tJ?=
 =?utf-8?B?QUhDMHlqR3QxM3dpRHhnUEhtZStmeUVBcmtRRlVrWXZvNTI1aEFzdVcrS2pa?=
 =?utf-8?B?NGZhNFh5TnVoa0NzYjBPQmVaZ1hnWFoyTGtiRmdYbXJ6RUR5cU12dTlqdFhH?=
 =?utf-8?B?L3F0WGZBYXczYmtFTjVROXhZbWNDaHVWd3JJZTgyRlJ3SWN2MUppU29BQWI1?=
 =?utf-8?B?QU1jY2FwTG5sblYxSy9QcFUwUXRpVFpyUDJyNERtTHZpcmI0VVZJQzNvSWE0?=
 =?utf-8?B?UlVEaUdTSWJOUWp4T0NaZ1NjTkZvWkpySldpcmFNSVRwMlJIRmdIK3hXQjd6?=
 =?utf-8?B?MFFRcThUeVhwZU1JeDRpeFhpODl3QlYxVk8wekdCc1N0cEF6RTRNai9SdmdP?=
 =?utf-8?B?OVcvc3VyUThYMmZMcGpCaEhOYjhhYkx3Yyt3VFUvaVJERloxa3lBa3J3SnN5?=
 =?utf-8?B?eFBJWnNTRnVmT0RpcFFuNW5XOXNzV0Z2cUlvSTlEa3pKbkx1U3g4TE5vUVVG?=
 =?utf-8?B?Nm1kSkxiQTJHYTRaeHg5WnF1SmRvOU5rVGdoZHhzNVE3bis2N0NKVkQyeVhh?=
 =?utf-8?B?K0pLTnNCWGlmeGVYUXF2RXA5QXNDV2c1NFNqYU81eVozVzRid2U0THFPRldY?=
 =?utf-8?B?aTlLZm5RVmx0dXNOV05GK2xLVEJtRHRjR1ZTZmc2TkRtODMrTmo4ZGdldk1O?=
 =?utf-8?B?R0ZyRWk1TDUzY1VTOTFNM29MZ3prVUxmSXIwNjZoYmZBYnNNaDRjNTNtNU01?=
 =?utf-8?B?czFubHBocnZ6NjF4dFlJMnE2cGd0QU9ZQjJsQWtZcUI1QTJyQjBZZ0lSUkNn?=
 =?utf-8?B?QlVPbmZ2NVE2QVkxSWNxcHpESHlreXhkTTZXV1h2NE9yQXZJVGVScVJ4ZkR0?=
 =?utf-8?B?ZkQyR3A4S0dvT016ekNYSnZJQmVNaHBPN2crcXduT2pXVW42UW5waVk3eGpy?=
 =?utf-8?B?ZkdodjQ5OFRvZEcvUEhKL0RlaktrOEJhSjBHczVEMms5TENRaGJ2RkoydVNr?=
 =?utf-8?B?UXZZQmx2WHNCeXhmbmlhTWFjVHRNcWVaWjVkc0ZQZWZ2MzBIdE1EZXg0WnNV?=
 =?utf-8?B?WWhiUEhjVkl4Vk9VdjhvbEwrSE0vakJHVjVtZldyMkVINjFZa3FUWjRhOVc2?=
 =?utf-8?B?WnZCTUd3bit5aStyUzVoaWZJdEIzOS9WRXVhN25tQ21oYUQzNkx2M09Qemk3?=
 =?utf-8?B?WjY4dGwyMGZIQ25CekgyN0RUSTI0WENTbXJyU0ZZTHdXQzdWUUlXL0wvVW5E?=
 =?utf-8?B?cnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kceZutsx42/p1RPeXku7oW83PbyynhzaTFBEIevZF0IisOlKr33j/ZkQ+ofo9iZ9k8KPsHwEbAx6ccAutdN8WsOOLcmDoOy8JS+HQtRrzC3JEDWLl9Om6uOfdnh9kmpwudbaAOnpJTc1F1l/r9DTYs4K8t7cC9YPtsjHtA763jWGgjHgq3XlzdS4f3NtCsscmXMOvggaPYirE2BUktAHuJmeBbkqc3Y6i1GEHN+keB/9QXfo1LtavLjHMo26XD0nGeWVOzOCxbiJ5kwHT3MJLPOy2mMZIgB0I2qyNEpzrLyLNDp5iZydQTvK3nPQykjtFIzeUPqQEWPvwZ+g5qEs/4I/cYEkE0+xVOLoOtrS7k6/WX9sn0SevUqHT6r+gva/GnDvTXvNMZPJ4sFHXFn5WEXvpWG/jC/aou8WB6dFoqYovQ+vje+6bC4v4tECoEk8WDwCHzy99JLIIz0caJXMTr0JnQhD12JNoEAaQOeaEgSGzpsFOkobD1dvkywszXaECESsMXYvZvGmVrK+3LPiMTN4asIChvAHhq4TI06bQ+TxoatfAu2cI9mOr9zqf77UCnftqYcs/S9uZc7XYc7MCsVEFqp1b4JJYN8nsDDp1F4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aba6919-58af-4a9b-fc23-08de27aab88e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 20:32:13.5215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fEs+RsTm+4vhSpSYX+zGCGseMNfp+frVNzhIKNru01bh/wv/7meEYL5KpQ+iMFyF3o8k476s/5B8ZOEQEE1W4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5717
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_06,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=687 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511190161
X-Proofpoint-GUID: 9KyRqZnC-16ClO8Lj1b_lQof03N0TwYZ
X-Authority-Analysis: v=2.4 cv=JZyxbEKV c=1 sm=1 tr=0 ts=691e2957 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VuQUP84QigXTHJqSknoA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=zZCYzV9kfG8A:10 cc=ntf awl=host:12099
X-Proofpoint-ORIG-GUID: 9KyRqZnC-16ClO8Lj1b_lQof03N0TwYZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX4ohFH8eUZpLB
 sKCM6pCMKtofYtPygD3tydVbZcRcei3mUE0EOh5cKDgfG3BLs3iEYHKhnT6odvGcFk61o8hunOR
 Tmm9RnMUlkUUDlfUqACm27DdDmMOHinWyxlo+yb21wMBG/1B4BCH7McrLBdFqitZ985gNYH3VgM
 urcB1gq5gsDaFt3sbzE16dCU9sxeuCh/gTCTBb5N0EN7SGvz03XrLEphD6ag8WrYMdg5cKQ78AG
 mqY8uw6FsAlzdqTrLMf3v3UsDTIUHjNz+Ll7rfje0dS0b0Z6FYL2VB6o4sC3JL1r69NrLLde2AN
 NlsKYA/m6ByFCm/nAyIAiJnqFHIW2I5eKCFqhfl7v5IrxwywjJgTjct+BypptgblPtD28jGg1BT
 krpLGOgIKIcAtrZcJAQLMVi/9Ln078Du8bCKhz7evKAYVI5FVC4=

On 11/18/25 10:28 PM, NeilBrown wrote:
> This series started out as an attempt to simplify the management of the "current stateid" which is associated with the current filehandle.
> This end up including fixes for foreign filehandle handling as well,
> including the first patch which fixes a possibly NULL pointer dereference.
> 
> Other than that first patch, this is mostly cleanups with a few minor bug fixes.
Hi Neil, the series is looking better, but there are still some issues.
I stopped at 7/11 -- 8/11 needs is_current_stateid() to be fixed before
it makes sense.


-- 
Chuck Lever

