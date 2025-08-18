Return-Path: <linux-nfs+bounces-13743-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A821B2B0C5
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 20:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7541B63C1B
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 18:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A63272E46;
	Mon, 18 Aug 2025 18:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BDJBuQAn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RUGR8idd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8E727056D
	for <linux-nfs@vger.kernel.org>; Mon, 18 Aug 2025 18:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755542823; cv=fail; b=lOvKyUG17aXL6QyMI8q3NUtfFtfx+5hj9BW1sIOdyiBQxgHAI2fNs7FSKKP8dq/ovoXVEwZsZnUv6ZRN15JH8JaRzbBD3sP5C97r3MftkwBtzCNTMMHfxL1iG6igwGYkTUaAA3Pv9nQfN9ugG3MJkPNpIuWnE+p5PNiEPSGYRyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755542823; c=relaxed/simple;
	bh=k4HumLxYrj3pd6nbQs4UUdfgYv/qZB/UdCQXUIp01xg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bDY5Rv0Suoiz11Q2UHHC0kzXLyZIu7Oss+O+axwxul2l64zY3GhzCOz+2f9I8SEAge8qp1NkK5qzAJHrHMsBxt9KaX+DeUAFnhOtkSXE+z2BQgDrvGCn3kwUOr2Zv+JM2ohLta19bmsCXi1jW/b14E2zQlg4/QTn7dmfkkHp8+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BDJBuQAn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RUGR8idd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IEtoAK026652;
	Mon, 18 Aug 2025 18:46:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ikD9r/j2DL7mnGePFoxb3xecHVA0P7NcTWM7C5v4jbc=; b=
	BDJBuQAnaXhEIMEZBrof7okkLAUwWZRf71bdhhLS1mvwMUZvtJe89Su+144Z2Fg1
	rtvHY7Z1bMoO5gK9qmH1NjyDFJ+8Rjd0RyB25Fc+bt/hNzvDLbCVx22blcVV7xSY
	BI8og/ieQyJp32WheO29qozE70zs5cjdr0zi6CpBlLV3mp6ilrmuFlqGbal8wXOF
	1XcA2sX1ACN4LX9ftbzmYNxNANImI08WZzOXsLwrFFpRN41EqwWkYrr0yQ+oO3ge
	8kjOJFQmbD/sCSTFEXI+yYJHnr7TC5vQwfzE7LsjFen1qYgdE3xSk7hxnPcAYIRz
	8sBH+UHR3Yziuu1Nl3jFjg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48jjhwurqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Aug 2025 18:46:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57IILbjp003433;
	Mon, 18 Aug 2025 18:46:48 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48jge9d011-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Aug 2025 18:46:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hUuDsKs9oe4o043yVbcouokhn4DXIfxo9KS8F7GktGJ6p/np4J/r7M2GFEc6/HgZObSVTNGUn8mhSk8SlztNvZn1HlXyVC5P6lwcNB41FO/hUfbwOIYTBRMcZsMdsJDc5iZM+0pUITtZV4lvDuU2+cTJrQ5eHyPck91LT8+/0Ao/Cfs2ZJHme7I0PmLqpvO8ZagobyeMTpgXG4bWJLBXX9yAszAU8MLZuKjRE1SYpauBbyePRKWRverQJEtblC170YVX9ht7WjyX93L+RaUfg/fbLQuCcMFqu5vJi19SLTEJT/5Tfp2QoF89XSwoD82fRv8ZqFHxPNxr+9HXUyjLkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikD9r/j2DL7mnGePFoxb3xecHVA0P7NcTWM7C5v4jbc=;
 b=ajCKY97nAeyZ9wHxZMMbBsdbykJWDWZIg8Qr8KKN327OpdBtm+23WHSV9HFKYJA/Bh4GBY3QJ8nXgczalTjOTdatw6C1sYY9A75Lr4E6dDGS8pOmLadJbqT1+9DhG71i+x5e67IeLPkQGI2uTE2L5/yMXKdEYDnKg2A0buyxX0+m4MTzzbRCUtLTdHKQIPs/Q/H/Ek1ikZYb6AZACgPvxgdWGnzxCJlVPpwHOOSKhyHGhRJ9u622UyiPTvd00sCvH5l9Gj1/wfCObwQz5hGCJBR5/p7L1E8518s7+J24o+6RiNQ7lv8IUS1VeqObHyDJIUUDUiBGcgwPI3ZHl3vcwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikD9r/j2DL7mnGePFoxb3xecHVA0P7NcTWM7C5v4jbc=;
 b=RUGR8iddvNhByvURb5KAJnk/KCeyv3yIrgjGQLKK3IzsipzhyuG+f7xzKG0yHjUj83cOmHDM0FI0kDqR5PxfVUCgVmUG9uFJmRVUu+ESjHp0KzEIJTGRQewpTxeX/pb0TT5GEV+B0dbTxSSdwEyrwEKSlONBW7JbgQi/CdAiVp4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB6737.namprd10.prod.outlook.com (2603:10b6:610:146::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 18:46:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 18:46:45 +0000
Message-ID: <c4722c18-57a5-49b5-818b-1e46cb4733b8@oracle.com>
Date: Mon, 18 Aug 2025 14:46:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nfsd: unregister with rpcbind when deleting a
 transport
To: Olga Kornievskaia <okorniev@redhat.com>, jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org, neil@brown.name, Dai.Ngo@oracle.com,
        tom@talpey.com
References: <20250818182557.11259-1-okorniev@redhat.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250818182557.11259-1-okorniev@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P221CA0023.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB6737:EE_
X-MS-Office365-Filtering-Correlation-Id: 28c90b07-af95-4f01-b031-08ddde8794ab
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?QzNIQmJ4cFNwOHBXZHZDNEFiaUQvNWVCMGdZOVcvYll5ZTZ5V2htcHBSbVJV?=
 =?utf-8?B?aEY1bTV6R2RHakVKVVFyZHVHMk1XTm1wRVEzV1JRa1lNek03THlXc1Bhd3dW?=
 =?utf-8?B?UWVXeHlwdDN6QThtS2QraC9DWEMwTDZ6ZEtRU3NuQkdYK1F1b0I4MWRjV05r?=
 =?utf-8?B?VCtmMENON0lFWTJSa1U0Rmk0WXhabkRBRWZZZ0R0VGhDc3hKVTQxOFFrM2da?=
 =?utf-8?B?MURlOXl3SmRRUFl4VHBIQktLNXB2MXI5bTJoMDZWWGdocWdDMXVYL3o3ekFF?=
 =?utf-8?B?NEh1aDUvZlVjdzcyTHlKUGxyRDc3eXE5WlpvekQ2NGxhWDBZMTRhcS9WYi9U?=
 =?utf-8?B?S21OTGlkK1V6dFFxSzZtOVNlWllCV0Nkdkk5M2NDVnV4SnU1eFJJS2cwT0ll?=
 =?utf-8?B?THVoZmhlYTE4cGZzb2FxSExTZGJ3MlpyYi9yMmpOL3pBMml4UnFCWno3QTlX?=
 =?utf-8?B?eTE4S3FneHpqMkk3a0ZqZXhKTTZ3UEZQZU1wT2FyMHFLdmNtdE4xY2k4bTRm?=
 =?utf-8?B?Z1Y5Tmx0Y0kwZ2FPekRzMnFMRU5DbmhiOEF0Q1dHQkRCM3lQLzZMVXJTZlRO?=
 =?utf-8?B?RzdMTWZsblRlQjNORGRzZkgxcHNPcGh2VTRJZWZic3pjSXhLbU1zdFUvUkQ2?=
 =?utf-8?B?L1g2WVViMXlUayt0cW96SDVUZkNKeUdyRnpObERlWGJ2VmlXS0U0cEVucWFB?=
 =?utf-8?B?U09rS3dOWTZRRXUyVWR1ckZYT0FVUG8yMXV6bU5KZm8yUVJqb3VWV2hFT3FG?=
 =?utf-8?B?alRmRTZjNmJkZVE0aWd6YTB5YnJMaktqalhIV1VNZWZRWllHbXlCTnNWSUxC?=
 =?utf-8?B?T0RiK2NYYTBPV3R6T0V3L3EyTnBUODV3a3dSZzBlZjlqeVltWEhJWUh0S2J0?=
 =?utf-8?B?VUZhNll3V2M4WnRkdWxzdStvQ1hqUXlRUVNSR00ydXpqOFViRWpQK3N0MHZp?=
 =?utf-8?B?MWNrMWtPSjk0bnlLN25OSko5Rm55blZ5S0F4N0gzSncxWTRHVTNqbkRTOXpQ?=
 =?utf-8?B?YjBlYWFmdE9hNkVoNHJzRU81SEk2SHE0dTI4QWF2aFJRV2lERys1TGMrQmM3?=
 =?utf-8?B?Wm9HYWJwNUJGWjBpbkZCNm0vcXpuWFZwWStZN0dkRG5FV25BQWNlUUErT2I0?=
 =?utf-8?B?MzM2UkNTb2t1R0hYbUx5T1RVZjJxQk0rOGJvVFJndTU0R083MzVWT3lWWXZT?=
 =?utf-8?B?ZFJQZmlJbkZRTmlEeTlHOE03ZmtKSWpCL1ZYRWYwVVdQczlBaGtBZFpUc2No?=
 =?utf-8?B?TU5adFV2Y3Zyak10djJrejFVK1dSTC9IT2RoQTVPb2hCUlVQbnFwa2JFMDVu?=
 =?utf-8?B?bXBicGlkRk9MOHNWY1piRy9PbVFsM2VyTVdtTlNUVWtXSXFVbFZiOGdmOElq?=
 =?utf-8?B?R0o3Z05kVjRpcmFMVXduRnlTaW5LNHpleHlYNFNkK2VIS0VpVmp5MVBNbTUv?=
 =?utf-8?B?aWpKN1JwQ3NnSHZEYkpPWlpSRDBXMmxBUU1oL0pGOVVNM014VGpkbDRHNkpi?=
 =?utf-8?B?eHpMREdDaVBRVGxvNjc4dUk3ZEhJQmpRc1pBWVZwTHh2SnV1b3JOMG1lenZG?=
 =?utf-8?B?NzZ3SDB1cmZYblZkUG9lTjZHZEtLcHVQUDZORVVMNHRjeERSUXRYakpNWGlX?=
 =?utf-8?B?aFJ5L3Q0ajFrRUtyNU4zMzREUWRJYnI2djVHQVFCcFVGdkpiQ0xqMDMrZmRZ?=
 =?utf-8?B?NzJva1VFVktPODhNKzgwN3pMLzZzT3ZSSHRIVEgrNVNkQVF2T1VtcE5Lam50?=
 =?utf-8?B?YW16RWo5VGM4UGpRV2VWMzhMYmh3alpvZytiQ2VtakwwZ3dXekhGMnBBdVhC?=
 =?utf-8?B?eEJxMUJBaXdwUmpTSEEybjlXTy85TGJmTlBPM0pJb0ZIS1JtcTJSZkZJQksz?=
 =?utf-8?B?R1RWUFZ6eGV4dUlNdjgrWDE1aDhUTkRDZmkvRDZtbCtEZWM0bVpiMkRabFRD?=
 =?utf-8?Q?/3OufKGhtZU=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bVhCQWUvUVM0NVM5OUJCRUpSMndFdE53bDB1WFdoRlgwelB4OGl3MnY4UmJE?=
 =?utf-8?B?akFrQ3l1TWgwTDRSSmdhdUJkUVhWTEJFVjl3NGRpU1BHMHpWK042MllnUmJn?=
 =?utf-8?B?Umh1cjByc29QUVBrUHBOalBUZk9zMlZpVDNEZk9jL2o3SVJnNklWSUJvZjJT?=
 =?utf-8?B?UWZtNTlIVVRzVG84SzVOSVpNd1dZbmM2azEvUUwyMHFMdTc5RkVTMVoybXA2?=
 =?utf-8?B?SFAvQ21SMzg2OXZzVmxUN213NHRoc3BZUjdpVFpQdTRDZWQ0Wnd3NUtsNzgx?=
 =?utf-8?B?blNsdm9YQkFZRlJBalZUQzBBc2V0ZFg5US90M2ErblpnaTI4U1h2Yys2S3hQ?=
 =?utf-8?B?K3l6SGhldnJsRlFEc0tJZDhsdE1Nck1xS0FTMEhjUjk0NS9FNitTd3R6Q01a?=
 =?utf-8?B?K1R2bjBtZEdXNXlsZi95WC9wZy85ZGNRMGZvQllZOUluVlg5anJsNkJMWEdy?=
 =?utf-8?B?OE9TVGdrbGQ2SHM2MkVQYzE3R1dRL3d5VWNKbzNPYmRSWHNpYS9pZEdCRGdG?=
 =?utf-8?B?dm9JOVd0VTFFU3ozdWoyQzAvL0dXTWlTclFlSk1TWlBsdzJZSnVGMUwxMUlJ?=
 =?utf-8?B?RElHb2xhb1UwOHFvOHVKY0k1Vy93ajdYS3kwZFFDUzV3bTRMM2V1U2hEY3c2?=
 =?utf-8?B?S29xamhDS2lMUUlrOU1VVlNyL21kd1UzbHgxN2RxR05OY0ZLOE5kdkxiWjlv?=
 =?utf-8?B?eGZFbmYrU0FKbm9LOGh6aWVkN1pZNUVQUS9QelYwSFVhek1tMEJmRjFqcFVl?=
 =?utf-8?B?cUsvUWpGVEhXUlAycWwyenNXdkJmWVQyem9ZaytPNFlrNXJtWGlQQi9kcko3?=
 =?utf-8?B?ZGxhYnY2UEY0YktJVU5PNjl3RW1QSk5RMDRxUjFaR1hVb2dpSEpwUzdYMEJI?=
 =?utf-8?B?aUVvVC9nS3lockZuSVdkUzN2TzZES1Iva2hVWUYxNHZ5cTFNeUk1MHFuRHQy?=
 =?utf-8?B?NHVQSUhqdXgwY2M2SlZSaWU2MXlKZVQ5eGU5NXJNeTJBclE1SWczTUV5L3Ix?=
 =?utf-8?B?Y0hueTk0SVMvZnJuV3VZRWk5bm44Tmw4Y3FYV2UwbjlTZW5zQTJVTTJYSFc0?=
 =?utf-8?B?SXdScE9oSHYvZm9JWWVGK2RYRERKTDdkWm5mbURBQnlYazh3VGNMY21YeDlK?=
 =?utf-8?B?TG5kVm4zVEVack9GNTZzb0g5MXVZRm43bUx2TUllcnluWnRpQjl2R1REZGRS?=
 =?utf-8?B?L0FvMTVORC9yS2o4ZXFZSGRDZEZVdzB2NWJXQ0pkZ2puV0tybVEzbldGTXRO?=
 =?utf-8?B?bS9iMlhFay9xV2E5cVFuSTY2Nm9ia0E3enVSMDVwTzVuUy9BaGpZZ2VCbVBB?=
 =?utf-8?B?ZTV0NmFFUmM3MGlHL3I2bHVxaTlkQWxaTTFrTXpjZGs0dGU2blozYjdHQmR4?=
 =?utf-8?B?MmxHaWs5WHorbWdZSlVRY1hMZ2V0K0JneHprYlc4N1dEampGcFdwMGpRWTF0?=
 =?utf-8?B?eE16VXh6ZU1Cd3AxaGxaRE92Ky9HTXRMaE9PNEJFQWxoRjlJaUI3RFNIQm4r?=
 =?utf-8?B?Z0h0enZ1Y0RaaE5sWlNSTUowdEQvVkNvdkwvcDc3L1JOSjRGVnh0b3B2VCtJ?=
 =?utf-8?B?SitvRGhBZHJGQlJrYmZGRVdUTnlZUC9Tbm44L3NsRnBkRXBVcFRwTThYYm5I?=
 =?utf-8?B?MUZYWUpaRmVNeGg2K0VzYzd6SWk5NS85SmlOWHl2ekRjU1Fjdm5oSmI5cTVp?=
 =?utf-8?B?WE5QRUNWeStQZS9GQ0U3VSs5UG1BQ0FqalA4dldNbFkyRFNBY0htYmt2NHpC?=
 =?utf-8?B?dUdyR0FWUDAzZXdxK1dPaWtXeXlRSi9SUDFOWW4vOXZZZUtrMHNHRTBLZ0Fy?=
 =?utf-8?B?S2hZaTZrN0tyZHZvNS8xMitaaGZMenY0a1p4ZmZ0Z1RtUzNZUjZ0TmhQTFRT?=
 =?utf-8?B?YlhnZFdabi9XTTlRR0tSaUx4dzVKTG9XdHFLbFFmZFEyZTNTT0hDczFMbUd5?=
 =?utf-8?B?WGF3NGdDVVp4aDVsNHA5cW9CRmMwZkxJVTl3SVBmTmR2bjFMcmVSUGM0cFI3?=
 =?utf-8?B?ZXRGWjB0dFVxTlRPekZmSHR2eS8vWEFOWEZSLzJJRUxrUENRUkdUanJUWHIy?=
 =?utf-8?B?akRvRlp0N1luVzhRS2RqSE81eVZSRGEzLzFLM2ozNnBrY0poRit0Wm1lZGRr?=
 =?utf-8?Q?lg3z+fhaq1siYZTXgtLepbARS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Rz16wMRpGDEej8sYZzWrGCFvOwUptHvX7J6Bpc/D6087skE2VlvbYtW6ylbcrIA+0r1BfzAtSxaNhO5hK6DJHQjpnIllErxzRYvKtZO6/VkAlAdd564hy9YM+ES9JMi1wGuvEX2zEtVyzPtcyFEuqP9sCs3B5/Qs1rOAuHtf2vAMRVbOa8aCA0bgCnPTVC5/tgZOH7Kkh38FwsmoPqKZOQRqqqMwWKsGSKnRq2tT4shri5S27+R8kiJKexZK3RrZ7Uj5ykKbB+FAcwzs0Qytf69su/NpBHU/erWG4YoHUNmlvfG/MzNcJz6GgUkQuwjWa5iOCo0aohvHvZUv9a4qAHud1DcY5y1oW+nDeoB1haUQGrOSKzOXa5hLlW5ji75HDT3E+BWH65Kmr63+Xg4iRBDgV7Q8cpO5T2p8FaMG+saLIxPeooTKWJLESp3XVRIhBD8X/rAhJZMk6Uz5Ljj9BbeDmlrf3TRI4PJjZTEHas5T70ZMoYrdOTEh4ZcsdydG4j8btFlez50/tcZ0y4ztXTUYttvc+zsTtkl9sgKz4BXD749kM5NyhTXF20Lt9wpCtmjBmkU8sAhynqi3GsHuDIO26WPHDWVyrE4u0OMTcQM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c90b07-af95-4f01-b031-08ddde8794ab
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 18:46:45.3973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aXnb2oiJSYvcxSYqBeb1Qv+WPR60mRRxG5rJM82gRUnqHwiFaP8WIrGCvDt6oJkM2x6Fp+U2q/QlFM020qkeEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6737
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508180175
X-Proofpoint-GUID: hzCVUnFGNW-unk2rl-C9aGnvy4v-xibU
X-Proofpoint-ORIG-GUID: hzCVUnFGNW-unk2rl-C9aGnvy4v-xibU
X-Authority-Analysis: v=2.4 cv=G4wcE8k5 c=1 sm=1 tr=0 ts=68a37519 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=pl8enrfC6NZ6Eoj-zUAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDE3NSBTYWx0ZWRfXySmAhUqJ6DUV
 AO1kzk6hyYc9cw8y/GvhC0gniEYGUvFw2y2qQzu0RjQ+sLswH9KcZWGTL7ttd1Cpzuk5OnKrvo5
 VYKjUvcNI1oyuAq0tUbSy36DTzVnvkrDgcJQ/v+0SoA+TylDVip8ron0eZEaX2OfFPKF1iaucvV
 V1qr7/CSoF1pJVq3aW9lb/LyezAwoNoSEuPpepj/6SnlyGHtFlVYAlA0piu8+bRte1VsCJA5lZ4
 kc5BptxvmMU/u/vs31Ak1L554qwKFR7I/c+BRsqNe0cNhle30jW1z+tfeus0IYQvz3bDr6X5buK
 QKWMlSbtQlp7OyreiqAK4A2odnvXSbA1F7VHno4+1J0IszkogOEQJW9jXXD6Lu8yySG1V3VEai0
 qE7bS8Xo8TYGJ0lP3N/AprJjNhCfliAwVJ8ZMvrbcI2oI+ONb+qSqNwxNXNQ+HzRO7EYDGgq

Hi Olga -

On 8/18/25 2:25 PM, Olga Kornievskaia wrote:
> When a listener is added, a part of creation of transport also registers
> program/port with rpcbind. However, when the listener is removed,
> while transport goes away, rpcbind still has the entry for that
> port/type.
> 
> When deleting the transport, unregister with rpcbind when appropriate.

The patch description needs to explain why this is needed. Did you
mention to me there was a crash or other malfunction?


> Fixes: d093c9089260 ("nfsd: fix management of listener transports")
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> ---
>  net/sunrpc/svc_xprt.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index 8b1837228799..223737fac95d 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -1014,6 +1014,23 @@ static void svc_delete_xprt(struct svc_xprt *xprt)
>  	struct svc_serv	*serv = xprt->xpt_server;
>  	struct svc_deferred_req *dr;
>  
> +	/* unregister with rpcbind for when transport type is TCP or UDP.
> +	 * Only TCP and RDMA sockets are marked as LISTENER sockets, so
> +	 * check for UDP separately.
> +	 */
> +	if ((test_bit(XPT_LISTENER, &xprt->xpt_flags) &&
> +	    xprt->xpt_class->xcl_ident != XPRT_TRANSPORT_RDMA) ||
> +	    xprt->xpt_class->xcl_ident == XPRT_TRANSPORT_UDP) {

Now I thought that UDP also had a rpcbind registration ... ? So I don't
quite understand why gating the unregistration is necessary.


> +		struct svc_sock *svsk = container_of(xprt, struct svc_sock,
> +						     sk_xprt);
> +		struct socket *sock = svsk->sk_sock;
> +
> +		if (svc_register(serv, xprt->xpt_net, sock->sk->sk_family,
> +				 sock->sk->sk_protocol, 0) < 0)
> +			pr_warn("failed to unregister %s with rpcbind\n",
> +				xprt->xpt_class->xcl_name);
> +	}
> +
>  	if (test_and_set_bit(XPT_DEAD, &xprt->xpt_flags))
>  		return;
>  


-- 
Chuck Lever

