Return-Path: <linux-nfs+bounces-13680-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11312B284F4
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 19:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCD043B407C
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 17:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF2210942;
	Fri, 15 Aug 2025 17:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="muzm3MNg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OUl7qPYA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFC530F521
	for <linux-nfs@vger.kernel.org>; Fri, 15 Aug 2025 17:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755278796; cv=fail; b=tTbbtPlOayZhOGHCUBEerXj92Q3/m8fTvTGkHsrk3g/wJRzHdtcJ0Oasll6QUjWOAPqRIJYouRf85bnlOfUBc9ZCwcdUg79F8tWFa1KR0voFvgvF9uGozJg+TjIbwiY2FF/c3nnu8StqF5IKLUwwwfPu1WUc8ER/66evp5M4TF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755278796; c=relaxed/simple;
	bh=tic4FwXMV1FW4Ov0d1EwOe66NHqiwRmwSsGED7jFjKs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LfeZH+RvzaaM2zYCe4mu5ft95I2DgP58ZQ69mhsvIpoG4195MO+P90+tYqcuG7cHm9uD6JWFkin4RQFjEz+9XLG2ef9qQZAKGaep9whRF+7yDBKu1HncXBG6Vn1O+FgwDofiOVP9HHdr3gZF462Ncbz2camS7LP3GtrtYUG9M2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=muzm3MNg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OUl7qPYA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FDN3Pg021425;
	Fri, 15 Aug 2025 17:26:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=KK5XoQFm2DtifkJRMtnBnsOGNdK0BBxTo1V11Uy3n/8=; b=
	muzm3MNgxANa1/MvxJXKJzd7loVqWr0MstlYFZNSbJXK2YldfyP4O/JtrlYgBLAK
	Kwej65PHc8/DVlHqdImKbJfvsVdubmL7JwEaX7dwa5g6FuIjf5yaF5Xzxx9D49Jx
	41HPxrmhvNgTh3Ybjg99suf5ennbfmpXzBJ1qV4Bh0OBRMPOGFuCzGgF9i8XjOph
	vB7IDRlPTir3ffdAp7Xjy9DGjlu+O8cRDNBKYvvScJMIgtNyMfhFHrmnsWxpTcFO
	QVPUeqzpGvTfNFlFcUQ5/5G5tkJ7Kh7FQvIvOriUnlnjl7rhRukj+AmS1iR+uR3Q
	RpLWzusDXb7d9BPntoOg2A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48guchcttr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 17:26:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57FFLvSv017411;
	Fri, 15 Aug 2025 17:26:17 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2056.outbound.protection.outlook.com [40.107.102.56])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvse721m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 17:26:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QBO5aNoy3YaFe5gTTgsfA1Bd+bFsf0g2cPN7WpJc948CaRvg10RotCp+RaVA2AU7p2+kZHNAqFZXCQ/qWk75ihzbzvAYb2gK1bnEYK8EAoQqnVuFePEj9Yxbd80SrOMj2JUxlWbK9bdGWspuWj3SAolcvcWY/J01+g+TDZ0m4MfCC9IuqZQsTCJgF1U+2hLfZxzQBuszytL/HtKp0TxplNzXTzQrBtn5bOMGSvNYjoibvsGPY+mysONPqARtV6+GJkvR+BCGOeM45fr8EwQNcDNNohKLJbi1L6oUPTmBdIrCsx3YaOyU5aGmhBoApX+kAx1sqkJ2jJZ1BeRacNTWfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KK5XoQFm2DtifkJRMtnBnsOGNdK0BBxTo1V11Uy3n/8=;
 b=qRmNsvnGfA11VGdUMDsDphacsKt8pF2H8HaRUkkW0L42iQuaXe5ILBoPeg0Mruk/gzQ7diecjVepkIg67jghJrY0ULZJK/MO0GXYtM+1ASjVQNTQj4mvev7HSW6uoxgREevDc9ULy6GO2XMD7k/nMC/56e9n4I/Sxv4bnNChXIBqdLv8Xxxni/4BiUw2tfni+IE7w6ehp/O69Cl7mZtF1tl6wDyLQfjdqlTAFnPtvhq4gfHbwlHznBWuUyI8r3dWW1HM4wcStYXdZ940yh64LnYMFCseSzSJ0N1vF8eJW6esCzn2/IKBV4iY5uFHkSrTqipH4ksGP6ss2qA6QKGVZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KK5XoQFm2DtifkJRMtnBnsOGNdK0BBxTo1V11Uy3n/8=;
 b=OUl7qPYAmp3UHbvpFPQIFLOftqxy8tOWChjxMEBkT0FNAn4m5/D4tl0EGad69y/eaViHyIrsPcAN6ynE8GmIuZS+e6oBNl0hdo8UQT2+ZS0feCrT3Fh202CYD7FlvQ/+UQgWRdzWhPCWAVjt/a8Q8w1ue2U51Z8Ov+vbUkuolw4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4711.namprd10.prod.outlook.com (2603:10b6:510:3c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Fri, 15 Aug
 2025 17:26:15 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 17:26:14 +0000
Message-ID: <9d84391f-d724-4693-90d9-c56d54ece17e@oracle.com>
Date: Fri, 15 Aug 2025 13:26:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: -Wold-style-definition warnings
To: Steve Dickson <steved@redhat.com>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>,
        libtirpc <libtirpc-devel@lists.sourceforge.net>
References: <482e394f-67bc-48bf-88e4-3808f508737e@redhat.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <482e394f-67bc-48bf-88e4-3808f508737e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR14CA0048.namprd14.prod.outlook.com
 (2603:10b6:610:56::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB4711:EE_
X-MS-Office365-Filtering-Correlation-Id: 058e9214-fab2-4d12-103d-08dddc20d63d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bkViUTBvZkxtOVNrQVhZNHBrYjh3QVhpQS9RUkhPVWVDMWJnL2RkVlV2QzNz?=
 =?utf-8?B?UE15RWYwZitWa0VBK0gxdTFhaHJEb01KS0hxeTZqRGNGOWdSeGFBSEVmY1dF?=
 =?utf-8?B?bW82Wmp5OFZqa1BKRDR0ZmpwMHUrNmIwR1dxc2dKVHBkc1p5dW9ZelBhVmlz?=
 =?utf-8?B?WjZpZ3VJcXd3OTVUWVRPNDV4VnEwdUE0VDBkSUV0dzM3d2lnVGswNGo2UFgv?=
 =?utf-8?B?NGwwQ2hJMjI2dlF4Yk5RNjFieWZ2UXlob0xtdGRjcDJvVTJFY0pkaW9RMzI4?=
 =?utf-8?B?NmppV2k1cUlZamFndVBHOUUzZzlLb2NxVlZUaXkwUldWTUV4VUhHVnZBZW16?=
 =?utf-8?B?NkRCSXlTWjROTDJqKzBmYXlMWGdob1lpUTNmdmZraWFVSVpYQlQ3Q25ZeWVI?=
 =?utf-8?B?TzQyUkVPRzh6QkF0VnhrN3QxNU5xdUFJNnh1Wk9RS0x6WWJXWnJkRGhwNTJM?=
 =?utf-8?B?ZXNwVlo1NHRiME0wVVBEZnZTQ1BZS05MWGdxcGdlR0trRys1UmJVTmxlUkVx?=
 =?utf-8?B?dlhieENVcXB4d3dIMkhFTmxLWnI4SEZ6blZSWUk4VXZUb0V0U1pQdlRVazNJ?=
 =?utf-8?B?YVlKTlh3RTg1YmZYKy9ScGJLR2pDWnF1UDM2L1pPaW4xQ2p5NlB4Y3B4dHRw?=
 =?utf-8?B?bFRNUWdOUmdtVVhlUldobm4vWE44ZjBScjl4Y2Y0U3FIbnMyWGNQa3JwNzhK?=
 =?utf-8?B?U2UxZTcranMwdjFBeEdqeWE0ODhNMjk4MUxaVUlxejR6QUtqUnFOL0ZGMXkz?=
 =?utf-8?B?ei9ST2VsTjJVVjlST0NHa1dNbGttVkcyZjRmaDVRZlV1cUt3bEtHYVROQndW?=
 =?utf-8?B?VHBUTFZ5bWs5dndBcEdXdjdGa2tDaUhSNFNUcmhGcFJQNGlUbzRIVFl4OFNS?=
 =?utf-8?B?MndOcFBMM3AzU3VSbXIvTGVtUmJjYXJ5YndvcUdYNis0MHFVcU5uZG82VDYx?=
 =?utf-8?B?KzgxbTVpM0x3L2lBNlFoRDFQNkRCQU9lUjJBNlRrUm9BZ0R0NlhCamZUcVdt?=
 =?utf-8?B?dU4xMmtwaXI5T2V6Z0hXeTJhcHhOZmtwM3habU9mcmpKbVpyUHpoQ1RKVXBB?=
 =?utf-8?B?dEVIcHFibmZJb0xpcStvRy9xTHFsUUJwY3VhdXVhWWdKVFQrZnhoTmFvMG9v?=
 =?utf-8?B?WWhxcnZHQjl6QUZnVmdYbmgzd3Zpd2szQUxhQ0Z6SVg4TlcvN2NGOVdxWjdK?=
 =?utf-8?B?bEdnYSt1cHpybHRGcDF4VWJDZTFRQnUvb1ZSTDV2L2ZOVlYrRVM0c2hqekk4?=
 =?utf-8?B?VVNCcmtxU0M1Q1hzcHU3aDlpOUh4elN0YnlMM3VPMjFuTWJOVG02cVJqZm5Q?=
 =?utf-8?B?VU5UTllVeUZZbE9QV1cvVjIrUlVvSGNYU3VxQVdZVldsN3JCVWJ1Q1FIK0Ri?=
 =?utf-8?B?U05hOVdnMFNPM2F4R3pwYVk0djlsUXNTMjdOZkpnWTN0SDYwMmNObmdYWnBD?=
 =?utf-8?B?V21KaWFpL1dIU083SzNOdjZ6a3crRlpGUk1oTExiZjlOSi9QVFNJcTNXbkxz?=
 =?utf-8?B?NUs2elVxek5DNUNrV0dpSkl3NG50Nm0rYStYUG1uNDJVUStQb0tWY0tLV1pP?=
 =?utf-8?B?MURaY0RxdHpmNE5wYi9udXFlQ2hWM3dKSE9rbDR3UVpyTHkxdzgzU1NpdWVw?=
 =?utf-8?B?V3d2RU5aQUZmajBOa3FLNDBDUjZKRUhVRWYxRGE0Mk5SL25qMS95VGlxMlA0?=
 =?utf-8?B?L3lxUWpFeGUySCtveW51Y1R5enJwbk1WQVR2WkR4aWo5NVpkeDhMZ0FZZnVY?=
 =?utf-8?B?bElJZFFFWXN2VU83QXZmMk42d3Q2VEhJUmVQUWxaTWJVR0gzSDJDM3Q5Rk5I?=
 =?utf-8?B?dXBpQU1WV242cUtrZmhSUDZIR01wbFQrNnRZL1BJTUJqMGd3bVhmNnc1TzVS?=
 =?utf-8?B?VzdZMmYzUDF6Sk11TjRPaEZzWWR1WWlHYVVTTjBvVnl1a2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1A0YXBsUnd6S05rYW9jUFZ3MHNHRDJjbXRMUEY5VFZIajlyL1ZndFVVZElY?=
 =?utf-8?B?NUtmWklHMjRHY2VkMVloTHN2azZpQndJdzBxNGttUUZ5eVU5N0VneGxVUlRy?=
 =?utf-8?B?T1dmdThOMFZuNlFXUEU1R0ZNbTZMNU81UlF2TXB2T3RZdmZhNjlOQ0hoWUU4?=
 =?utf-8?B?SGNPeEV6b1J5YnVXMTZvbXRFODJzMmFKV3Q0eDVKbkYrcGl0SjIxaGQ1U0sx?=
 =?utf-8?B?SHd5L2hMV3I4dmhuT2Ntc1YwKzZOeUEyNHFwUGp4QWhNd3pYRnVUaFRPMDFv?=
 =?utf-8?B?WlVaUHBRR1Y5R2ZCNmt6Rkh1N1AyRzBJTDlWWWZpN1FoemhoRWMzcXgrS3E3?=
 =?utf-8?B?a1dDR1BWd3o0ZHgyN1g4V3BPWmNDcmQ3MjRQSE9GemVmeUV0c0h5enJNeEhD?=
 =?utf-8?B?bktsYXZRT2VRL3NNMmJJOVNqNktBVUwvcUtlRi9tNjNoN21RSTU0ZG1JWHla?=
 =?utf-8?B?MEhqRVF0M0cvZXAzSWtlaUlNRXBaUjF3NHJPZGlWaXJXSlhxRHBJNWRZVTJm?=
 =?utf-8?B?NnRxaGg4cWgvcURnMTUrRVdTK1FXUUhNblpxZzJ1Z2hCSmdDeEphaGxWTmV4?=
 =?utf-8?B?NDltTDdKZE56Zk83OCtsSEk1T0oxYUJON3YzbUxQaHVEdTFhdGhlbVNVU1pw?=
 =?utf-8?B?bklxV3kxZ1ZhM2VtT3FoUkI3OVphN0NoRGl0R3d1QklGSHk5ZGlhZDRub0R4?=
 =?utf-8?B?TjZYOTNnUkoyOWtVZ3J2M3BIRnJqek1lZnd0QzFiNjFSRE40cHlIUTQxeGRl?=
 =?utf-8?B?cCtyM3BKVjNBMGNraG1rN21xbXFldDZobjBiTXlZQkQyN2MrRDRxVWd3T2xK?=
 =?utf-8?B?NEc5YjB0UUQzd2s0SjhQK2JmMFZkc2ZaK1FXTDRpVmJFbGlzQ3RudzJWT0Z5?=
 =?utf-8?B?VFhVaHZxKzlpRjRTa1duTlIrMGpVSnhjWExsOVA4WFZaN0ZZUm1JamJFeUdx?=
 =?utf-8?B?ZTBxQzNFZUlFM3lBY2dWK3k5L084T0ZnYzRDNVZXMTRVK0JRRnBDSmhmczgz?=
 =?utf-8?B?R2lLZUMyUThxK1E1NzUzTzRrT3BrVnFMOTBUUVBUTUY3MnJHdTc4cTJKUUhq?=
 =?utf-8?B?QmZVbzFqeTBYNUN3eEdRZWN4NmN4bE1UKzVhb2RpanRPcE1sVzA0dzJGQUlk?=
 =?utf-8?B?SENOYithc0wrYW5UQXpPN3R0NktDNThCaGFhb3cxQnF3bmlrUk1DTFBmU3dR?=
 =?utf-8?B?QSt3amJlbys5Z1FjN1hhM0E1ajNWc3NJa2tyc0RHU1U0SjMzWjJSN3Z3SVR0?=
 =?utf-8?B?L0QxUWJNNVRSbFp3a1JMbDJ3aW9TQzdFVVpIQlpab3JaeTVJZExWVU5WT3dl?=
 =?utf-8?B?ZkRWczZnTHU2emtXQzZyOEFyUGU4Vm5RN1RTdzVneUNuRDJRaWxLSXhQRkFC?=
 =?utf-8?B?NGpPc1VVenBTMnIyWmZvcVVaOFFKaW10YlBpMncyc3laN1Y0MDdxQStla3Rv?=
 =?utf-8?B?OHJZcExPc2pia2cxTnBqd29RM2NGK3VCRzRLQTZkZ2NjQmVSSU1MS2xHS0VX?=
 =?utf-8?B?emZ5SDNDcDhtb283NkNnVHRVYlU4NVpFNWhsZ3dhN3dGdnBhMUtCNXJRZE5B?=
 =?utf-8?B?bVI4dE9IaXQ5eDA1TnRoUDlQV2xwK1NUaDdieDNCd25yZFpuV1RGVUJEbkRB?=
 =?utf-8?B?b3hzOEpqUzJKUG1GY2FpN3prSjU4Q3J2MDhkanBSVXZEMS85SmtlUE5EVzMw?=
 =?utf-8?B?aDJlNzJnaFVHc2EwdTJLdEs0aWNXMUJOM3dIblhWU004dFRJNDNvWEU3VXl6?=
 =?utf-8?B?OVhQUi9OalRLTEhBbWphdmFhTVhwdVJGV2hZdlV6UEY2NXNhNklUdTBnVE1s?=
 =?utf-8?B?MEFUSjJ3eGV1d0lTS1h3bGdWV1BXdklsMkc0R1BXZGhaNEt3V25nSldZSlFS?=
 =?utf-8?B?VkNwaVFYR090T0g5b0hyaGhNVlBQUjViN3JzN0U2V3dHcHp0Si83alE0ejVJ?=
 =?utf-8?B?akd2dDhIaTNjMkVZUXpSZWRJVUVhZFVuV3VpaUtKRi9OcWdiQWRGRnA2VlJS?=
 =?utf-8?B?bFlWYVFhb2JFb2xoTG42V0pIaFh2WGpYSEFWY1R1MTZ1dXlUSkx0aVBudGVw?=
 =?utf-8?B?cDc2eGhPMXRlbW1lUFgxZHl4aXg3eFNQdnJDVnptUTdPRzdmMXJWcG9LM3Yv?=
 =?utf-8?Q?weJgDmw48SIc9BVKl6T2HI1mg?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1v2b4zL0srCaveuZUd1kJPB4zQmM6h4rjLhrr3X8q6VdN1uzLbms69fEX9l596uJzCSSG1ZzmcJATvlM+WtwcRwFqcrAMjgqK+OPUn+A+QaN2rsB5fAzEPV0HSYr31vhbIHmx1tO4OGPOelAZx8AcPjPN9nJye0cwxtuvnuaoiX4B49rT7CHjb/umrf0KL7+zo9L/elrOSOaw9VIDLwnzXfQ53Kdjb1qOajf/EQnNZMZT8rE4B6OUqj0ZzoFJi/btyQcWYe/VqZPWMtLqSURFTaXBg0UfKHjjju1xVeWaaJb1LAMvw7AWD8DR+bmlHYcbK3kDcKi/3Hh1YT6Hi+6bQx2P8GWynLO9kjlydoj23gpEQOPEKhsiGSvWiXDnQ4cD6qBUsg5RjOfpoJE8i7wTU+PUOafOZoGsMhJLJRgTXMLVFATdgaw29Pn3kHKD79E6I2F4x6zCJiGmdS88pDlRxsbR6b4Tg0sBUdJ9nQk+I8kQZcKcInpyVRlIn+dQ1jIQdWWSsefc/hz1/2Ukhdm/c3iQiA29mM2JK3ueQFPug+FtTrBX4+l5w2i73muROoKXJN8C1uJA+o6o3zDqKAR6getOF2gh1o2wfnDRcfV3g0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 058e9214-fab2-4d12-103d-08dddc20d63d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 17:26:14.8874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t10vs1N54xhmlDCdmSnh9E9G6kWUp+Zsw+WG8kWddSBXrZBm5xF9tV8SUaRgdZUiQ0TIuKPHPZeRvMF8sy7Eyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4711
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_06,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508150145
X-Authority-Analysis: v=2.4 cv=Eo/SrTcA c=1 sm=1 tr=0 ts=689f6dba b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=Ta0-qJikkko6U5w5xKEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: PAESfENEJHXhUBbNK8PEUyDZspeMBSMC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE1MDE0NSBTYWx0ZWRfX5iTBEm7x5QOr
 yB1inQftDYgCFHkIr4Pamvy0zysYJf08gaoagyfc5cTmJrmuJ2jXJaMhlZbQ9WSqtKMS/Iz0q5/
 37kE4pZvzJW7aEp6peFv/nNuOhv0PnilIg/x0yRzZBdZQeLg3dSFun23ChjNfdBvJ0rp+eHxcl0
 kc0eXltH/apUGK77KLVi6cdTv3MIr1HDTuHnzsZ/ISv8xDAK2sCTuExAmW+/U/zZxN9DRee1z44
 3DaZcJuDByVODFjU5nLFMrKOu9KWR5o4RbnladPs6WxS1A5lJhHvXpQPiRUJnpxJfQRY8tzNOen
 +Fw7nHzdhLDTG+UAygejmZU6t/Fh3uPjcYGwlAQ6PQCyZnJv1mZuYuhaZUdFvQTRStWhuEMIf0w
 6QR8IYWtZCQ/lMmrUkVmx9JG3V6WvAVhDRZgNYyyRGGLTro1x9tp0fYHDwcyDi9CxGuYoHnB
X-Proofpoint-GUID: PAESfENEJHXhUBbNK8PEUyDZspeMBSMC

On 8/15/25 12:23 PM, Steve Dickson wrote:
> Hello,
> 
> On the more recent gcc version (15.1.1) the
> -Wold-style-definition flag is set by default.
> 
> This causes
>     warning: old-style function definition [-Wold-style-definition]
> 
> warnings when functions are defined like
> 
> int add(a, b)
> int a;
> int b;
> {}
> 
> instead of like this
> 
> int add(int a, int b)
> {}
> 
> Now I did fix these warnings in the latest rpcbind
> release... But libtirpc is a different story.
> 
> I would have to change almost every single function
> in the library to remove these warnings or add I
> could add -Wno-old-style-definition to the CFLAGS.
> 
> Now I'm more that willing to do the work... Heck
> I'm halfway through... But does it make sense to
> change the foot print of every function for a
> warning that may not make any sense?

I recommend breaking up the work into several smaller
patches, and posting them here for review before you
commit.

Maybe you could also pass the result through a C linter
or clang-tidy. But don't go too crazy. You get the idea.

Out of curiosity, what is the test plan once your
conversion is code-complete?


-- 
Chuck Lever

