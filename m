Return-Path: <linux-nfs+bounces-14040-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E38B44183
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 17:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F0FD1CC25C1
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 15:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD0B28688C;
	Thu,  4 Sep 2025 15:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HkXWL3OL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zh/1GnSO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022C828466C;
	Thu,  4 Sep 2025 15:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757001463; cv=fail; b=R9sZFKmRxnCbENjmCrwYVy8UvOU4tHy9HDNL3XFqVjVM+9VaP5ek7h1EtN6btnbZmxBXCsoP9qukzSjhn7fXVPa0dEDUYo+m2wBR5Ve8Pm19nPHQO7evuYnRHsVNDiB7+uqwU5Sf8wwsPGdTZWwJRAUfzOHM5kanJ8O4ScGdgT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757001463; c=relaxed/simple;
	bh=qgubkK0M+c3CH4P5+aqxShYDzcdi/8QjJc0oWjzd7FY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nfyCcs1Hqgzu0l5jz1SyaF1cxUabrxNdDX6ADUDeIldcCDbPIM5teFn2ew37h0jAB30i2B3m4ReQw9gpLDSFZX9ysc0hfUPkDVDLKVxmvtdvZ+VfzSl2J1vvSkuniQah0Xt5mFqdSpiOAPM7ZUktn5OuEkNHkZPJRCt7GCXscVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HkXWL3OL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zh/1GnSO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584Ftnni014930;
	Thu, 4 Sep 2025 15:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=1KjcvH0tC+SJ0xBGIqDqwwD1fcdpBn7C9/gySWWHypk=; b=
	HkXWL3OL8QTu7Ysp2XTEboiC+dJr5pr8Kz5E6OR63wWsmg77FOfRaYgoEc7ub3j3
	sbKRkVzz2QROUXZltNhvPUwGrXsBgZ5JMjBY6QlA+0tW02xFucndPWlIgFMihSNP
	ILPsed4JFFcORouxq5bmmXnrc4RJWKNtNuKB1qIpgm9evxrVpAuCb407GkrxgYIL
	JlwpvBI4E3Km5+4cITA0tvdKxSLjBNPa8tJiKUXFhZJ5jUfMEYqfA8359Trjkugd
	nJPrmHV1KWnDdHFPCn82KyRoSjcjMfna3VrqXciuftG3a2v5G65AV8XTU/aRkr6R
	N6sfBNA1F0pOhvzoReJ3TA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ybmh0cb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 15:57:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 584EUZQc040682;
	Thu, 4 Sep 2025 15:57:33 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrbfhvq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 15:57:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DApW17HCcpsNE7ExeEiPoN90LTq5YW8emK1MHWIT46D7UeniDZFQ2tgcS9jPVTX7O2DRr3/g/AWHPtwbKtgx1gGZ1bOZNcBYvEq36BdgFKn8TlOr2pviBnQN+vr6X/nH6RFLaRK8ZShKl3uhd/ci82IYM37iqQ+tSL9/IKXwKiPxDRgcTxsig5mZQ55bbeP8/WFybymwttW7OonCK25lt/kTV0ZrTA9kwEgPXyyVpi7Vn3LlyguvqgMMst26U3shYVffozr0itPinRXuzAEAn3+ZHj82mBH+HSLVhqU8gRzhSGckjM/Gd/WKlc3v0p2cSCJF5El/eS/CD3RIw9BxUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KjcvH0tC+SJ0xBGIqDqwwD1fcdpBn7C9/gySWWHypk=;
 b=iqH8XRUSsXVjkkgTEDMtAzJMkM1+R4eaCwMnThtSmcCiosUHm1TSqbpCSqzUv5JZkeV6jLeGxdmqiCayC/etwWhKP7HOG9Pq+RSdmWO0psTzU/G14oEg0uVGJ6bg/t71IOC+lVzhBk/rEUwi0P7fbxahAoKdib6H8RdqxrXk/3vycEGwbESFKKil2ZMrt+nmcFZoOo1tbhnlmIuzIAt9wX7cdTOinAW9KDSFGvXVBiiB4dv8mW7LFOHimb8krnpJ8kQsS5q785uN9l1OPks9gbGpIZIDPtC7LAfXL6dfWErgYnnGad19XtJF9mcQDNFMEloE49gHXaV5NVhWuzypwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KjcvH0tC+SJ0xBGIqDqwwD1fcdpBn7C9/gySWWHypk=;
 b=zh/1GnSOZch3vSMuxxwyUGXevcQrrg3TTspPhVW5/hGqhiXsgEzGOhPqsT29CaliKABNraWcZB364WF1W2wLrc2QFgEfWkAhViZqvLcOPJ9YFCSG+er18UzYqGLjrk+KE6ng4lpfSpUe6jjJDsESfMPQH6YiMV6zx5G4Hq06OkA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV3PR10MB7769.namprd10.prod.outlook.com (2603:10b6:408:1b7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 15:57:29 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 15:57:29 +0000
Message-ID: <a16b5483-b8f8-4b1d-9ad5-c5d5d61bff55@oracle.com>
Date: Thu, 4 Sep 2025 11:57:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] NFSD: Disallow layoutget during grace period
To: Sergey Bashirov <sergeybashirov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konstantin Evtushenko <koevtushenko@yandex.com>
References: <20250903193438.62613-1-sergeybashirov@gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250903193438.62613-1-sergeybashirov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0014.namprd14.prod.outlook.com
 (2603:10b6:610:60::24) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV3PR10MB7769:EE_
X-MS-Office365-Filtering-Correlation-Id: 27f9b939-16ff-4ae3-6923-08ddebcbc050
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?QmpDNWk1ZDZvTzVPMFRndHlQYVBTUHJzN2ViMVY3VHdrb3FXa1MyUmU3T2dk?=
 =?utf-8?B?bTdCNVJScWhJb0lKQUhsaUN5RHM1a1VpT3I3SkZ6QkRqdzFoRC80RzFpSUdI?=
 =?utf-8?B?RmVDYWtCUjROK08vcEFQNkhDTUZibGlkb21SYWZVWDRwZ21iLzdNMUs4cENy?=
 =?utf-8?B?ZUdvRi8xVk96U01YQWNadGgvTXBIa3d2dS9hb21Md01MM3c5SWxTL1gxOXdJ?=
 =?utf-8?B?Q2FWRkozMVRlTUdIY2ZjWk5rclZTL1o4dHRiVXR4WjFZVHM3dDdOKzVvaFk1?=
 =?utf-8?B?aGZXOXFVZzNGSEtISWhKVElLWi9UYXdiVW5IdHVHNVNsbWEvSDRTbndaNDFC?=
 =?utf-8?B?M2NUVnR2KzdoNVpldk5SUWRSMjVSSnBSWVNrbm5WaVBGb2RwTSszSG1ZUk1N?=
 =?utf-8?B?UXNEdno5dmpuWkdzeFRiNTFnZlpwd1hPT0oyQWdLOFl1amZGeDBTM3lqUjhu?=
 =?utf-8?B?MStIUkd5cmtDYUNzcFg0NHZQY3d5SGxlZEVqMEY5MDJIcjF0UG5BUzdDUy9z?=
 =?utf-8?B?TENCcHM0OVJTckcveUhGVUFKUy9UbE0wOGFTa3NkNFNtMXNTa0xIamtQQWV2?=
 =?utf-8?B?ZWU2LytXeXlBQnplZm04TTRCM0RVdVQ5VFIzRFk4Z3lWTHhKd1BEZG82RVNZ?=
 =?utf-8?B?ZjdIcXVTTm92N3pReTJWeTBBemRFWHB1WGx4MFNhMUlWQitHb3dEbUllSFh3?=
 =?utf-8?B?QUJsYm9ESFJkaGZSYkhqTnBtSFUxdFBJU3N5b2hjWndldmVXY2JrUlYzVnMz?=
 =?utf-8?B?ZStrYXNFNjB4bnpvQ1kwcUVJTzZzaVYwOTJlR2dWeWVjVWJIZTVyaGxOTy9Q?=
 =?utf-8?B?UjFGckc3LzI4REh4aHdraXY0VWtQdi93Q3Y2Z1I2alFWaVFDaFNrN3NMUTJi?=
 =?utf-8?B?aVdINUkyM3l5empYUFRJT2FxM1dhdzFCcm45VUMyaHQyL1RDQi8rUGd5amtQ?=
 =?utf-8?B?TFFjYzMrVlpuSnFBSVVKaFhFQzJRdUhONGRhbTdZRjZaeHNYK2d6a29mcllO?=
 =?utf-8?B?a3RuclVXNDQ1eElRUERsa2F4a1JuRCszQ05UM3J1Z2RkUGNsR0Q5dURwWHBl?=
 =?utf-8?B?NkgveFZpVWNyK2dkQWxPSnBIZUdEcTlHMkd3Wnh5d1NnOGRNOWtWZytSV2tE?=
 =?utf-8?B?SmdrVHhEMEkrWFJLRDZ2a1J6UzFERjJIZ1BwTjNDMGdmTVZnSG94UGdGREd5?=
 =?utf-8?B?RGVpSUF0U2pkcFVCZVYxQnNvbFFuT0Vua3pabHZDQlhKR1VrREVpWk9GOFZY?=
 =?utf-8?B?RlM1RmtKSU14NElubFVsRm43Y0wwUUZZS24rWXh3aG5JSGU5Yi9zRzNhcjlP?=
 =?utf-8?B?akc2dDBDTXZvN0QvOTI0QytiSXRHakRzREtPa2gydzNoZjltTXAxTHFFNHJW?=
 =?utf-8?B?ejJVcCs5RUxJRXBycnBzbiswM1VtMzN0QVQrc2RPMHFhd0xhdldjT3RBK2cy?=
 =?utf-8?B?ektpWFE3R0ZWQW5WaDI2cjNNbUZ6cG5YdFlQaW1ONlJNVzFJNnhXanU3NnhH?=
 =?utf-8?B?U0VhaTVxSzFXZUViWXM0UW5MaW03V2FueGw4T3F1NHlFbndkMEpDbk9IcFgz?=
 =?utf-8?B?bGI0NmRSVmt1Q1NKbHpNUE1VemNIWmZOcTh2MXErMGFCQUNmTU92b2lLRXFF?=
 =?utf-8?B?SmQva2lYQ3ZsN1U4aFZOV0pLT0M3THJ4SFAyQi9qSzJiUXBWUmsxYzBmcHZt?=
 =?utf-8?B?Y1JzSFZ2cUtyYTJraXdtLyt6NGlTaHV1MFMxclRTSkFnTzBtQnQvbDhWUXJ2?=
 =?utf-8?B?dG12TEk0M2twRzVvaFBYOFNsMVByTFZzRllKL2ZnbnZwQTBDNHNjV3dacy9h?=
 =?utf-8?B?N25RZkxXd0NKdmpQWXFJQVFHdUlNbVl0YzBOeGRrZjZva25lZ3QxQXdvcTdM?=
 =?utf-8?B?SHhRMHRoQmZtQUtaVFpoRXhmT29YeG0wRjcrejVFSzkwYWc9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?YVF4SGJhVU02QVJzYW9hUVQzcVF3Y1FlYVBaZmdPbEp3Z1RiQ2xzaDBmQnlW?=
 =?utf-8?B?WjJGUmhqclQrMENHYWxaU29SSjJRSzVKRUdyM3JGcEpMTTlQZUhMZkZpWGhD?=
 =?utf-8?B?YUtwNTJFcENXT0crWml2Rkxtb1B3ZVJRSHU4MFNiazdnVkIvaHd5eGJQN0sv?=
 =?utf-8?B?RVc1Q2ZRUUdYeVc5Z1JvN2NzdHJleTh5ZmtldEw4eEJKVE1VcTRINUlBL0NU?=
 =?utf-8?B?ejJ0S0NkMkZJRHV1RjRPTk5OZHNZbTdNMGV4clA4UDlUWGxyZmdldElNb0pU?=
 =?utf-8?B?RW5ib2I3cXJJaFhiTGx4TFkvcHJzVXNyRlEySVFDWkpCdUFXQ2JCTGFDdG4x?=
 =?utf-8?B?MW1KWm9yeDFlWmltWUdObzg1VlJQY1BMbjN0b2JvYTNkTmVuZEJTZXY4bmVv?=
 =?utf-8?B?VVdQektSemdSMHFCT2xRaWJyblpEQWIyWlZrZ1FKQmhQS2FyN2NQaVd5Z01n?=
 =?utf-8?B?NEFGR3RSeFUwTThFS29wZFM1TnlLa3FHNVlRa2g1OHhrb0FPVnFwd2dNdDg5?=
 =?utf-8?B?S0N1MXhReC9ra1dBWGlaeGFObUhwdWxNUFBCMmJBbU9ZcEt4U2xFQWxEb0ZO?=
 =?utf-8?B?T2FHeUtzVmNEd2JsYWg1N0x3WjJ0WXROS3BEMEZZZFY4MTJZSHJ0T0QwSXNu?=
 =?utf-8?B?WWY1ZXZFSTM2TG13ZUp1OEpKWFpRajNzTzIvUHBHZkhYT2hFbG5WRVUzbzA1?=
 =?utf-8?B?Z2dsYmZ6YzRhcTh6RkhNOW1BWEJCWjF6cXNkZ3grRmtQTzhETzJLdmd5cGxM?=
 =?utf-8?B?WTE2dDdpNG9zMHpxcjB1U3ZRa1ZGeGNEdUlmQnBuNDdOU3dMQW1sSE92aHVz?=
 =?utf-8?B?Y0UwZTRDaDRKeENOUGRYdzBVUXBvS0ppMHRTcWtuMG1TVFpJTFdaSm1HMU1B?=
 =?utf-8?B?dkdKcXRySkJ5a1MwbXJ0VUVtL3hHZjkrN2tqanltaDhrYXZzMWdyZ3FaWlMy?=
 =?utf-8?B?Z2pjcHBubE9ieXFaNXRmYStYQ1pDc3kvUXB1dy9udzJYdHphUGFBOE9tenhI?=
 =?utf-8?B?bjFPUjZWTklld1ZzSkU4UDZjTTFjbmVmVDhVLzh5Y1kzUlZaMy9KQ1ZpUTBi?=
 =?utf-8?B?Qkt0T1g4cWRTazZpb1NBdzlKZDc1TnpZcWZUUUkwams3L2RWME96SC9pVW9B?=
 =?utf-8?B?Nm01bndMbkJDcTRmWnlsZ1p3UzlCZStRakExanJWaldtV0dwUXB1Wk95NlZj?=
 =?utf-8?B?dVhkSEcwMG04S2hoODNJbkNIbExXS0pETWhjdGpVSzEzRWVkZ1JJekRDQ3M0?=
 =?utf-8?B?N2FUQ09Ic0ZIcks3T241TUJuUm5MeExaaEdFM0RadCtxa09HZHRKOEZRWTBS?=
 =?utf-8?B?aStQS2dVQXhmV1AxckVEWHFlejdnQS9iSjkyd1FWazZOU1ZSV2laSHN5eHJU?=
 =?utf-8?B?d2thR3ZINHRwSmZValFORjNZd2pBZHh4bU1LOFJNeWpUQnN6NjhvOEowUEFX?=
 =?utf-8?B?bndHYjZVRU51b3VZMWpNVTAwVGNTTVd0dE1rRkMrb3JUL0s1YVM0Mmd4amhx?=
 =?utf-8?B?dkl1eGdZRlBRUTBkbWJWTDBJSlVNL0sybmR5Y3dlSDV2RXMxTG0zZjBDanVs?=
 =?utf-8?B?VXFTMmlTaEdlemMwcTQyT3hIMjRBUTd3VlBYTlA2emttKzhmNHh6dUlRYTVw?=
 =?utf-8?B?eDJwNjhpVEVVSWppYTY2eGI3a284QXpoNllCOXc0ZVdGcThMbHp2NXZTbTZE?=
 =?utf-8?B?MndIR1M4ZlJkeUdmSmxodWQ5aEFtOXJFSCtJRlNRRmhXeFM0elZJYzRZWHRW?=
 =?utf-8?B?RXpuRjJDb1hyTW1WeGVkMnhqbEdwYk1xNnJDeUZ1ZWdneFF2TkxWUkV6T3dO?=
 =?utf-8?B?bkN6cWo0OVZtNER2Y0hLRU9FU3pGVVhabUU0aGU3eVB1VkhZNFIwb0pJMjlq?=
 =?utf-8?B?ZXFZWVg5ZnIra3A5ZUlxZGVjelBXTDZ6dGxaLzJhTzhHSDk4WU55QXZNTWlV?=
 =?utf-8?B?NVI3Z2JrNFdiQ09rNVpvYW53NkhDTUhxck9VUVM3NG5odVFqMjE5QUpEWXpj?=
 =?utf-8?B?bVF2TytndUh5THBoZjYybldaWnBPcmpZaFRESE1CVHp6QXdWV2FMRzF0WFYw?=
 =?utf-8?B?cUdnckpZeW1GR3ltYVVXUGk2ZXRsS2haYk1LRzdVSFB0WW1mbDU0c2tMSzI0?=
 =?utf-8?Q?JDlsxRUlsvMYjaNomjaF7Nn+Z?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oN9WZkIYCX+IfHjid6zDRNmRp/pErq/TOrOFQfMmrvl2bE3OujwM21uwVa5PptNeibiJDSmX/E6RkRE8rQVMWWd+Pv678MnnV+lRFpFgI+RUwQLHSIpf9JWGkupmUW/pD5HCv9AlFy+l+HrgGszw+dmelrONdXotMAc6gUQQOknyq6Go+YDVvDTwk3pfjIHXOiz9KSZfktu56tyjruWLc9lxiMFTWuooldV/zwgJKiMnfBLFmtxrVlyo94QGcjT3eGfBgYMvMMl/va9i7cFNSK8mu2Hk+P5eD5ZIKuVOYErl6eLYGtiaJhuMWnZOMUb8Fb/xj1+O3VmXjr1r7U6W2Cz+h4H/NS3Hm1pBj0Qc/RTfRrsnUw+6eTjtnI1rvIB7fCgSxCC2/PzD1Yk5WZ+VqLGST1oJEsKd4RHkd4jBFwQR42g34j4ScCFX9OB2ViOXkZUVy8fNVg/PZ7yG08evKUXeLjrr6sgY0Xl1tfM3AFuzAUt2fujWwHVQuXcIt1tPQRpDaOTYFp3fMha6J2JXeCUpCfky6GWNYtyf3DjgGHTy2YPiO3YwCtNcq2VE8yzkS7BOenKmbbiL8yuQYxI6FXM0Wz5E326bIahzwbsrir0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27f9b939-16ff-4ae3-6923-08ddebcbc050
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 15:57:29.4941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vfFLOlD40Kvajaljri8uCUZVOuzg6G/0HvPYFpHD29qTt9xwJk/gskmqBVMAAvEzwz9/TurfsCdybGkNFV8B1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7769
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509040156
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDEzMiBTYWx0ZWRfX62BoGT4xdWIL
 HvXdBAls7P7mXODP/CG9YrpDL2zAk8B8M/hy8MHJuyNi0sdbBhmOg5/wMG+hP3LCCHs1qrfSb+q
 paxDpO5oG9xxD4by1FHgJyxQBOLcwssi5S2IwpCep50gYB3W9ncBGl/aLGseCQ0KdkjVvmVk2KS
 vOFM6j5FMMWdOCKlvnYN5195ukJf/tXc1itwELxC1rDAy6WswIDHPfv9mGLUSbyRQSepcs4wTw/
 bJDM55aclRkX7FEXddFehUu79PhAx1k7Ue1gXo0IHfswPlyp4hssbxUTkyCpZZhbXlpwQlM/H8z
 UwnJ/n00rBpSu7QGUTMVdXjf+LMUBRVe5b8lpZKj0lxUr/b3bMnyuYoccqA26nx8WnWPQtJI6I1
 dU7/XAWr
X-Authority-Analysis: v=2.4 cv=Z8PsHGRA c=1 sm=1 tr=0 ts=68b9b6ee cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=BMxJXzqDAAAA:8 a=pGLkceISAAAA:8
 a=3ASUbifX4NbRGQypIq0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 5zioXFNjv99y9lwLhYFmkcpC5uxssYmZ
X-Proofpoint-ORIG-GUID: 5zioXFNjv99y9lwLhYFmkcpC5uxssYmZ

On 9/3/25 3:34 PM, Sergey Bashirov wrote:
> When the block/scsi layout server is recovering from a reboot and is in a
> grace period, any operation that may result in deletion or reallocation of
> block extents should not be allowed. See RFC 8881, section 18.43.3.
> 
> If multiple clients write data to the same file, rebooting the server
> during writing can result in the file corruption. Observed this behavior
> while testing pNFS block volume setup.
> 
> Co-developed-by: Konstantin Evtushenko <koevtushenko@yandex.com>
> Signed-off-by: Konstantin Evtushenko <koevtushenko@yandex.com>
> Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
> ---
> Changes in v2:
>  - Push down the check to layout driver level
> 
>  fs/nfsd/blocklayout.c    | 8 +++++++-
>  fs/nfsd/flexfilelayout.c | 2 +-
>  fs/nfsd/nfs4proc.c       | 3 ++-
>  fs/nfsd/pnfs.h           | 2 +-
>  4 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
> index 0822d8a119c6..1fbc5bbde07f 100644
> --- a/fs/nfsd/blocklayout.c
> +++ b/fs/nfsd/blocklayout.c
> @@ -19,7 +19,7 @@
>  
>  static __be32
>  nfsd4_block_proc_layoutget(struct inode *inode, const struct svc_fh *fhp,
> -		struct nfsd4_layoutget *args)
> +		struct nfsd4_layoutget *args, bool in_grace)
>  {
>  	struct nfsd4_layout_seg *seg = &args->lg_seg;
>  	struct super_block *sb = inode->i_sb;
> @@ -34,6 +34,9 @@ nfsd4_block_proc_layoutget(struct inode *inode, const struct svc_fh *fhp,
>  		goto out_layoutunavailable;
>  	}
>  
> +	if (in_grace)
> +		goto out_grace;
> +
>  	/*
>  	 * Some clients barf on non-zero block numbers for NONE or INVALID
>  	 * layouts, so make sure to zero the whole structure.
> @@ -111,6 +114,9 @@ nfsd4_block_proc_layoutget(struct inode *inode, const struct svc_fh *fhp,
>  out_layoutunavailable:
>  	seg->length = 0;
>  	return nfserr_layoutunavailable;
> +out_grace:
> +	seg->length = 0;
> +	return nfserr_grace;

Also setting the seg->length to zero is probably unnecessary:

union LAYOUTGET4res switch (nfsstat4 logr_status) {
case NFS4_OK:
        LAYOUTGET4resok     logr_resok4;
case NFS4ERR_LAYOUTTRYLATER:
        bool                logr_will_signal_layout_avail;
default:
        void;
};

Is the segment length value used at all if ->proc_layoutget returns
NFS4ERR_GRACE ?


>  }
>  
>  static __be32
> diff --git a/fs/nfsd/flexfilelayout.c b/fs/nfsd/flexfilelayout.c
> index 3ca5304440ff..274a1e9bb596 100644
> --- a/fs/nfsd/flexfilelayout.c
> +++ b/fs/nfsd/flexfilelayout.c
> @@ -21,7 +21,7 @@
>  
>  static __be32
>  nfsd4_ff_proc_layoutget(struct inode *inode, const struct svc_fh *fhp,
> -		struct nfsd4_layoutget *args)
> +		struct nfsd4_layoutget *args, bool in_grace)
>  {
>  	struct nfsd4_layout_seg *seg = &args->lg_seg;
>  	u32 device_generation = 0;
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index d7c58aa64f06..5d1d343a4e23 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2435,6 +2435,7 @@ static __be32
>  nfsd4_layoutget(struct svc_rqst *rqstp,
>  		struct nfsd4_compound_state *cstate, union nfsd4_op_u *u)
>  {
> +	struct net *net = SVC_NET(rqstp);
>  	struct nfsd4_layoutget *lgp = &u->layoutget;
>  	struct svc_fh *current_fh = &cstate->current_fh;
>  	const struct nfsd4_layout_ops *ops;
> @@ -2498,7 +2499,7 @@ nfsd4_layoutget(struct svc_rqst *rqstp,
>  		goto out_put_stid;
>  
>  	nfserr = ops->proc_layoutget(d_inode(current_fh->fh_dentry),
> -				     current_fh, lgp);
> +				     current_fh, lgp, locks_in_grace(net));
>  	if (nfserr)
>  		goto out_put_stid;
>  
> diff --git a/fs/nfsd/pnfs.h b/fs/nfsd/pnfs.h
> index dfd411d1f363..61c2528ef077 100644
> --- a/fs/nfsd/pnfs.h
> +++ b/fs/nfsd/pnfs.h
> @@ -30,7 +30,7 @@ struct nfsd4_layout_ops {
>  			const struct nfsd4_getdeviceinfo *gdevp);
>  
>  	__be32 (*proc_layoutget)(struct inode *, const struct svc_fh *fhp,
> -			struct nfsd4_layoutget *lgp);
> +			struct nfsd4_layoutget *lgp, bool in_grace);
>  	__be32 (*encode_layoutget)(struct xdr_stream *xdr,
>  			const struct nfsd4_layoutget *lgp);
>  


-- 
Chuck Lever

