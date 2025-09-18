Return-Path: <linux-nfs+bounces-14552-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2ADB83F88
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 12:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 859564A5D4F
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 10:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A6A2727EB;
	Thu, 18 Sep 2025 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bDPDyQjT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nNObMtBd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB2B16E863
	for <linux-nfs@vger.kernel.org>; Thu, 18 Sep 2025 10:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190227; cv=fail; b=AQ0N7j/G79ngvga4m0Ri3HdecsFdTwahTtJOc2QVkLcZ8s+9BkmFzUtHveeV+m4NRUVpAZzfDPKGBo6XXfWa583t0rZAU4zrPon5lHs/pqm5ka+gWxKz4m1xsj5foIRzsvzlGS9eKHUnqAL2tX09gHl5YcVBOaIbDRSrcBLAdIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190227; c=relaxed/simple;
	bh=862ixl7Lyw8WwcHaoHpM8yyL0zPOtv2jqQNoT4HJ2+4=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aiO6dR3SSn60HZEdGncXNAJajRPFBSlHzAr064+VW5eO09klytEOVSforh5vFp6xWCKr6bMvKeqLyYmhGTf7So/jwU4CxWFVzD0CyPtlte5Dy4AZOtsjn9rMQNdPX10ezgAk3yk+cjGlmFCThd/hNh5RD4IrvjNwO+LPsDbue/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bDPDyQjT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nNObMtBd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I7gx9S028423;
	Thu, 18 Sep 2025 10:10:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3DADuWOF9g+R0gcTg4rXszfJSim3LU81ixQgx6p8GnQ=; b=
	bDPDyQjTYc5tKeadvZLO3voS+bPVEpUFINy+RR7f5pRlrbGsqU+l4J5vPwZdYsVs
	SVVq3KvClkVI1cCLQrb3lK6JB8+aWzDgBKwbcZEVTw5QKzu4JrSyft1dkG1YLWAy
	ndTvTHUCoRv2Gk/zvwOSYc323EaYPo69SGpczPpGxmOauPZ5UKbdBShRF0BYLXay
	utpYshiT9Yln6unpvGoBp83jmBptM/jP/wbu84K+GoIUbqejOAutp8NBfzDagzoU
	gk+T6kjw9h157sAMX1MQrUXp1Fji8pZc2D4oTgkvSpLqgqCPPCLcw0fHH35jy9dn
	WImtKas8i26P7iq7y3CQEA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxd34c8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 10:10:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58IA6xRP033754;
	Thu, 18 Sep 2025 10:10:17 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2evn26-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 10:10:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZzdfTMc+tLpmYb06frncCzQZpcFwoeN26hzPd9To0U2MaQBpcmftaMoHTVlvL+3Cz/gLxNeP5PvbaqKH4byC7aXdb9TMniyuKDak+9D9pj3Mt8Cwdsm1w/z1hwoPAsMROaGCiv9HP7YMKAigtHQ3CjRa204IvB0KI/W4Cq8a0lfY1p9duyfA2r9qzeHoMCIwDcLZyxyh4uoDs55TFBHQ6TrfYZgIJRIkh454jtK969kXX9OuCfggRR5+nvD8Z+N9FbMNApTzmVorXtFgTJZq97gi9AKqNWf4dorY/msn1Aq7DOtxtrDJqwqjxOCyDtcR+nWNab0ogolV6Kh8p8Pzvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DADuWOF9g+R0gcTg4rXszfJSim3LU81ixQgx6p8GnQ=;
 b=QePPm3v0YMDWgFztO7Gg/c+0fJzgcPOGb0eOkUuQTBqdFw8+rWLWQvBLvIy4B9HHjEG+5A3hqtaLO+4EwzYuQ9JaSk8bJZAaxt8abL3TtT+Oh7Vzuqg+Pa6Vl1JEPemT3ulLksJhrCfhaNZ02eILeYVFS9Oj5BL1PQCvCed33h7FaCytO3OLwkLAiusYSerRCoKQP9BXCCIdfRUeFM9tc0OW+NoZgeiuII2Q3FX+iz9azARHLHKqvdk6szhAVa9mcTcXSLlgIdVO4EtTxJuX2K5xqZk9MwOK2rH59FLvuPylUFv/7V0qnCtFgcBKNN/JlndZjteEI4XsnaYPkZdp9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DADuWOF9g+R0gcTg4rXszfJSim3LU81ixQgx6p8GnQ=;
 b=nNObMtBdP+AuQ456L0egzwhZP7Y1FxI2KtUOqwFfqAlNYCNf3OFg3KmQHQ71sz9uPUrY6brpMpVg/2ps8EPuANAza/q0R0LGU1ZTcX1Ud3W2I0Ul7e7Ld178zIp6cKm9liHV/bPoiXgyYxteUWz61SKWPicYnzNlUEPPS30l1ZM=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by DM4PR10MB6135.namprd10.prod.outlook.com (2603:10b6:8:b6::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.13; Thu, 18 Sep 2025 10:10:12 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7%6]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 10:10:12 +0000
Message-ID: <a814a6f7-43fc-4b80-af5f-91273a00394f@oracle.com>
Date: Thu, 18 Sep 2025 11:10:09 +0100
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>, bcodding@redhat.com,
        Jianhong Yin <yin-jianhong@163.com>
Subject: Re: [PATCH] pynfs: fix nfs4server.py TypeError problem
To: Jeff Layton <jlayton@kernel.org>, Jianhong Yin <jiyin@redhat.com>,
        linux-nfs@vger.kernel.org
References: <20250918024638.3540302-1-jiyin@redhat.com>
 <171be190855386179087a52f713a9a0b0f742528.camel@kernel.org>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
Organization: Oracle
In-Reply-To: <171be190855386179087a52f713a9a0b0f742528.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0317.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::16) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|DM4PR10MB6135:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a5c745a-61ed-4c98-b0f6-08ddf69b8e11
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?QktHbjgxRGk1cEljV3pSM2l6M0QzaW9zRCtTZ3VZUitTdy9XNUdnR1p3cXV2?=
 =?utf-8?B?bjlHNkZZdFkyak9SNzR0ZnlsQjcwTEFJY1d2M1h0dERvenQ3eXNuNldROXNP?=
 =?utf-8?B?NXBqdEI1VjE5VlNwSnlETzNLYnhqMThSV293RjBMeWN4NTU0N3VPT01QeXZ5?=
 =?utf-8?B?d3Y0VWNPOHdSdEVHaHhCeE1NZ09WbXZjMVRvejgxTjlvVXdvc0pjRDZUcldj?=
 =?utf-8?B?OVRsbHdFMzNDd2tzalNidkNYcXppV3RmWk8zbDNPN0hxbjJYU2JEOUczdEpL?=
 =?utf-8?B?RHU1WURxZVlwTTFMRk9OZFpDbE5kK2ROUDE0NmhFcmZPWVZmYkQxcGc4dHgy?=
 =?utf-8?B?NGIydUtmck13czdQbWh3aU5VQ2ozV2RlRjRZRzkva211ZGZYSXBKMFVDUHFS?=
 =?utf-8?B?K2NCUDZ1QnJZeVNyNVFXUjJDbWk3ZUhxYmY2ZHlRZ2krb2Y2T2srU2xldnd6?=
 =?utf-8?B?SUZGc1lSQ3lTaFhhVlJKYUxYWTFKMVhHZkVSUEE5NDQ1NHpvK2ZsS2hWUEJB?=
 =?utf-8?B?UksxbUc3c29FSld3a3RHWm5RZmVJaHkzQkFJaWtvWXZSVUc0SUNSQ0UrV01l?=
 =?utf-8?B?bWY0Rit5VG9CejI5TENoczRsbG41QVExRUo0TnR1WmpzZ3lVT2p5QVBOMmpL?=
 =?utf-8?B?NGxrSXJZU0V1QUpFcHFqWXVza2duZUhlQWYyVlAyb25TL1dBZjhJUGpGSUd2?=
 =?utf-8?B?ajZ5NkxMMTJaOGF0TU91K2VGbmkxOWdSSnhKc3hMdmFJek1DcU9ZZU90cTd1?=
 =?utf-8?B?TGRvdmVmVWtzL2h3SkRmVlVCNWRWRGJTSE5DZVI1b0lrWVFFOUh1VGovaEJW?=
 =?utf-8?B?bm9iUXBoS1FJMllMaVo5VVVYMVBpb1g2cHpDc3FyVE03dENrMncxc2hETm9Q?=
 =?utf-8?B?Nm5UZ0ZlUXVFTkowbld3RG1wSzNhZk5SQ1VrMXdQbU9NVXF0Mk9LcWdjb3NT?=
 =?utf-8?B?bGJaS0EzRUNQMHoxempRb3Qva0RUYVMycURrWUt4NHV3TUVYTHV5eXVTb3hn?=
 =?utf-8?B?VlpsSDdLODkxOXpVRkVlRW9jbmh6ZGV4WUJGQjlDMzVFbWZoaHhvRFR5MU9k?=
 =?utf-8?B?c3FFemJWQlR6S0tPU3YrRXlQT1Y1TFhIOE9oRytQcEFSRTFqTEhVT202VGZS?=
 =?utf-8?B?Sm1EUnByZHNndEo3RDRTUnFQcld3c3BIbmdHNTZnT1MxcllPK205czFiZ1B1?=
 =?utf-8?B?SFBYcDlJVTZHNnozNVp1OVdtWHQ3NTA1Z0Y4akxNckJZV0t2SUJPQ0FjSkRU?=
 =?utf-8?B?d3AvcHF6aVp0WHc4aERyOGUxR01NbmtmZUpud25OdWQ4NTVrSTJTT1VJYTd3?=
 =?utf-8?B?WWZVZkdlOXJwYlhPNk9jK0lVMWFZbm9rZ3VqaS94ZmZFdTRXK0VuZkhubE1t?=
 =?utf-8?B?a2pTYTRuN0xBRGJmeGhHZVFJRENhbnArbWZHYllTZkIzNXNEQXNYNmVDQkxm?=
 =?utf-8?B?Rk54N0hsV3B6R21NZ1ZOb0ZObG9USjJJOFVhempZQlBjKzUzd3UyZDNUajA0?=
 =?utf-8?B?ZllSVWtuUk5OcVFuNmhnMmVpRDEwdDRBL1pVWTBJOHhyMlRrWE5aWEZIUFUz?=
 =?utf-8?B?akV5d3ZFOG9lS1k4SWRFYklTeW5SaE9Gd1lzVjlhR2NkRkt0TXpoNWNHbGVK?=
 =?utf-8?B?SWlraHdlZkFvTnBtYS9renNPeVdMQWJYbkFqNHgxQU8yV0tPWCs0ZDRmODhJ?=
 =?utf-8?B?djZXemd0aGppcUQ3cXlrZ2tvemp1UG84TzYrNWhrNzdhMngyb3BrTGxqVXJk?=
 =?utf-8?B?dW5NMm43cnQ4ODhCcXdXbVNlSU15YWxZSk5zLzc3aktZNDN4NDdLYWk3TUpy?=
 =?utf-8?B?dStpd3BueENUbllqcVpaanJEU00rZ00yVTRoTkUvUklGMy9rWkJ5NzhSVTA1?=
 =?utf-8?B?WlpMb2tCYmd0K1pISmVMSm50Vy8wbkJmMnJoR1JIN0gwVlJpV2lOVnhqY3Rt?=
 =?utf-8?Q?3wX8HP1dFxo=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?eS9hSGFvbmpjODcrNUgwbXdCdW9Ec3FsZ05jVklJbUloU3FDOEVTN1JjQ0xK?=
 =?utf-8?B?a3Fac2VpM1N3d3dQZXYxcHlWcCtYbHRoWSsvR3RHZFBCL0YyYjBIa3FnSytr?=
 =?utf-8?B?aFhBdFhFbUYwYTlHUGpSdmNEb0U4dzkzT2ZQUHd5OUc5L3pkdjc3VExtNGZR?=
 =?utf-8?B?THVtZUZRZDAzSHI4ZFdiMzJvbUlRYmxqVEY0WThpVU9JdVVRSlJrcDhrbVdS?=
 =?utf-8?B?NzllRTF2THl2SFdlVWFDdlJHcjlTbFp1T3lMdWJzaVNuVnJUaWtGb1hHanhp?=
 =?utf-8?B?QWRPS0VPYmRoM0VlOGVGWHFyTkw1K2tvSVJDTFNnUWdHN3V6cExXR2JwVk9R?=
 =?utf-8?B?VGVrVUR6K1VScUgrc2d4N29aZkEzazRrdlZ0MDNNUEpSNnJScytVb3liNnNi?=
 =?utf-8?B?ZXl1dHI1aGJvQmRaR2FMOEV6SkNaU28xRWV6UHVXYlVwRmJIMDZvSlBXZDVr?=
 =?utf-8?B?UGx4ZmFIMWhjR1MyaFdHUnJnZ1BDYnFMZ1pMQTF6QXlhM2xhZStoalVlNWR5?=
 =?utf-8?B?UFhIVGd2ZHBzYTFLVTBoV1h3NzQraFI4U21xTWxVamVTM2tVc0JNTW14NjM3?=
 =?utf-8?B?dWpCV0xQT3hEZVpsMnFCN1VqZ29abWFoKzJOK3pCZWZrVC9CUXY3YjgvUFIv?=
 =?utf-8?B?NGg2amZqWi9nRkowcE1DUVQ2aWFNWkprcFFYVHlZc1NIRXFQYTBKdk9rd1Fl?=
 =?utf-8?B?YkI5VGN3UFZpSmh2OHZsa3g3elE5OUZSR3NVTW9DUEcxSWgvb0dMOUhMUGhs?=
 =?utf-8?B?aGw2cm9qZjRnV1dpOTBnNjRxQjVJMEZKTWFPY1BnYlplQXFURThwMytPMzhw?=
 =?utf-8?B?V2R1a3NaeWoycElzSzN5THR0eTJhbUxKazVlSHVkcFpFMzZidnpobFc1ZGsv?=
 =?utf-8?B?SjNLVmdrUFRaR29xZVE2ZG51cHhlZWNGNUdEYTNnd0dqaG1uN2w5TG1lV211?=
 =?utf-8?B?ZDk0ZDdHanBWTjJpcE94U3RSQmpwRnF3dEM4WUV5elB5TE9hU3ZMNGY0djZ2?=
 =?utf-8?B?cWJGMk5jN0FzdVA4NzF1S3UxSldwS055Y0t0aCtORUNIZ2JxN0J2SGR6NThF?=
 =?utf-8?B?cXFkbXE2UXRhejZMZUw3dXdVUWFoU1B2b2FlZlFFVlU3aTVwRzN0S2RJZnlD?=
 =?utf-8?B?UUNxT0xpdXdLUlRDWXBsTHgwcWI2eU9uZ0JkRmx6Y3ZHZmxXR3p0bFZtZTlR?=
 =?utf-8?B?cVlsekwvZXN0ZDBzQmVpZUxpTWZTOFd2S2c4Smg3NFUrdjdpYVJ0MUpPT2dM?=
 =?utf-8?B?L1NJK0NNZ2FpSU9PL1Iwc0hoUXR5d2dOamxBZUJxWmpNdHZyQkFCa0dwODVZ?=
 =?utf-8?B?cEdFM28vc3pxZGs4c3BIQWk1Zm5tNTJwdUlxQXBVblMvQUtoWExxdlhSanNz?=
 =?utf-8?B?NGcyOEk0RTlZakp0cTUrWEpQcjBPMEFySFliWE1pQ0RXNWY2VVNsS1ZWekFw?=
 =?utf-8?B?NEVuUXNHZ1RTRm9vNVc0dHROWHZSU3VldTVPS0RwRWNaM3B5VWxqUFZXcTha?=
 =?utf-8?B?T2c5b3d5MEdqR0dPWFJab01jUXlhdVNhMnZQUEt4d1c2SE1FemtKcXJWV1pj?=
 =?utf-8?B?am5rdFExbmJCcGFCMDRzV2xvOVdjUGpxTTdQRmlGcXNzMTFuQk13S2R3aWZI?=
 =?utf-8?B?MzNmanFIMEE1ajRtc3RnK0V4dmVGaVVMYWR4SGpEY2pPVElMMXo0NnQ4SDVQ?=
 =?utf-8?B?WFpmcTZQL21jdTI1dHc4bWN6QWJEZEtqYnladnlEMWpqNjY3VHY4R1dhK3NP?=
 =?utf-8?B?VlV2REprY3BqZEE2M3BWYWNaVHRURlVhWVF0NTJyWXk1OVl1VUE3bFd3Y2ZK?=
 =?utf-8?B?VUhNb2RBNTRtb2pPUmc4b2dhdnlhUUYzWDh5T1ArbVp0d3VTMGF1RGFDZ1hG?=
 =?utf-8?B?TUN6TDAyelJpNnhsL2hCTHR0TVJrbTdaSXBJdisyWVlxS3JPd0VpLzgxc0RO?=
 =?utf-8?B?LzlhN3VYQWpHTDFGa2l1TS9wNTBta25tbjFoNERycjNxNnZ6TWJRbFFJRUlZ?=
 =?utf-8?B?dTV1a3ZDTWlrL3ZZR2lFMlQwZnZQakJYNUpkbmlTUUt3bDI5MlIzUVExYWJF?=
 =?utf-8?B?SGU3bzZqL2VnU1F4cjRHUVcvdUdNdVlnSHRIbnFRTzc5YWhpQ2luUUwyZTly?=
 =?utf-8?B?d3RhWFIrMFlOUFpDOUw4T0tSSW9nOW5HZWUyL1hOdHkyVVQ0SDNWVVZqQlk4?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nWqvWiU0HV0UnbTwfvfQgdhZayzUiqSHJ7D6i+CoKlzc1waTVZzUmQZpnXTsWxzUaTk5H+m2OBv/TVhQinPIkvzhbXzeLeNCRxfeP4YvBsiUqN7s97L4wMOcChtNkZBNd2Q96UJAS8uQ6bI7vw+MQlKdDwYHMWXapW+Lz0eFJa6zBcttI64LNr0npv0MqTaLNCPoehVLT7tDmc0K2yKTDgOLFOcDbF3asgHTMOM69d7k8xsyeTL9G/GFNapD+d1QbL+EejAqymbRIAbu4suZhTrBBT/1sfbRxFOJgbBpzgOIzwvzTl5cuEC9p4DVn6xPxYYU1CWqD1ppzXeqvUD4xZUxkkKNY9LIEpAF1tJyPuPgZ6V4mMxraJDyA5CaJpWGmdv7vTX4jtptnlTKfqa+6Q6uKV1ab9szKAArAX8ei6olSG25TDR4+WIGQATiDKNDHHGimeK89bW9cAoD3FwgNUA/tOxBme8qTDdDceb5p81jTzuQxrdyXvetxnpxFmg4DNn43O6/kI9/d9WpalfdHuAuvbrXw6LbbT/t6HqZJUGr5n+dEck+GjhZgSWoZqCejHzJ6FTstQaw/Gf7HScr/xT/gbWWYOlZo7Bs0OKbSoY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a5c745a-61ed-4c98-b0f6-08ddf69b8e11
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 10:10:12.6122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9OjsedNPjMTvpUwQ3BJOXkMAcQU3FsRF4J5F0iJG1/Y5OisULo7UpBVGhWy2flhXZh0LVfxIo9zth94ORxHIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6135
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509180093
X-Proofpoint-GUID: YHvlzB8ROO4lS1SyfWSvb4eOATdmbUpF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX8kwWNwDb03vG
 h2ZKdws6G6KluNqWT6Cg0thRLIiiQV06cQpS/ioZSU44zFEx9Yc80kq4ASt+PC6eqFO7lqAqCIf
 LQWwOmOFqTnqn4DhCNmcA/3N1y3ltOoy3MNhAgKzfh+EDcivbAe+uiwS2S2seqAycuQ9rjuAAvF
 v5LgMOzjGAHW2sxaVFfS95jeC56UCSn5sySF6e/OAs7qcrU+HLpzGuCDUdAOybmFaXRACbfZLtd
 kGqZI0cJ2T8P3y8Qt/keUCOSvKgURpbWrxTVPr2nnITo/a6OYFCBuVhhb5gzFIPqCr0D0zYEkJP
 2vi3HKaV2VBHu3vdp7OG7nYGfJZEf5SPsjhPNpEQ1czoSA+Tpa/NHEnznPVV+a9Y8MSPGomMbb8
 ZK7YsWDZ
X-Authority-Analysis: v=2.4 cv=cerSrmDM c=1 sm=1 tr=0 ts=68cbda8a b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=Byx-y9mGAAAA:8 a=VwQbUJbxAAAA:8
 a=lhr18Y5pPTHfOmpgy5QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: YHvlzB8ROO4lS1SyfWSvb4eOATdmbUpF

On 18/09/2025 10:51 am, Jeff Layton wrote:
> On Thu, 2025-09-18 at 10:46 +0800, Jianhong Yin wrote:
>> without this patch, we will always get follow error:
>> '''
>> [root@rhel-9-latest nfs4.1]# python3 ./nfs4server.py -r -v --is_ds --exports=ds_exports --port=12345
>> Mounting (4, 0) on '/config'
>> Traceback (most recent call last):
>>    File "/usr/src/pynfs/nfs4.1/./nfs4server.py", line 2115, in <module>
>>      S = NFS4Server(port=opts.port,
>>    File "/usr/src/pynfs/nfs4.1/./nfs4server.py", line 577, in __init__
>>      self.mount(ConfigFS(self), path="/config")
>>    File "/usr/src/pynfs/nfs4.1/./nfs4server.py", line 620, in mount
>>      for comp in nfs4lib.path_components(path):
>>    File "/usr/src/pynfs/nfs4.1/nfs4lib.py", line 552, in path_components
>>      for c in path.split(b'/'):
>> TypeError: must be str or None, not bytes
>> '''
>>
>> Signed-off-by: Jianhong Yin <yin-jianhong@163.com>
>> ---
>>   nfs4.1/nfs4lib.py | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/nfs4.1/nfs4lib.py b/nfs4.1/nfs4lib.py
>> index d3a1550..984c57c 100644
>> --- a/nfs4.1/nfs4lib.py
>> +++ b/nfs4.1/nfs4lib.py
>> @@ -549,7 +549,7 @@ def parse_nfs_url(url):
>>   def path_components(path, use_dots=True):
>>       """Convert a string '/a/b/c' into an array ['a', 'b', 'c']"""
>>       out = []
>> -    for c in path.split(b'/'):
>> +    for c in path.split('/'):
>>           if c == b'':
>>               pass
>>           elif use_dots and c == b'.':
> 
> Looks reasonable:
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Thank you both.

I have a little backlog of pynfs fixes to apply, which I'll get to next 
week.

cheers,
c.


