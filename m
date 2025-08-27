Return-Path: <linux-nfs+bounces-13921-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6242DB38F5F
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Aug 2025 01:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A1C63B1295
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Aug 2025 23:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B6721147B;
	Wed, 27 Aug 2025 23:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RXjcJ9oX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="W29p2ftT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302F31DB127
	for <linux-nfs@vger.kernel.org>; Wed, 27 Aug 2025 23:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756338552; cv=fail; b=GUgajVxRv2X7TVdTJHrCudOCw/mv8n/CR6CY1BsIo4wub9HoM31sym8N1xd3ygwML/1YtTjrTg9FeRitEKRxt4o8IL554eKzmebxbKMBo5VV1lNEVwJOc342OEOCHZALiDPtPljnWrQpF1ct2zkntwNGXH7ZVdVDDDlKE2sCwSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756338552; c=relaxed/simple;
	bh=UilKkFYZYjCRSN49p7uet8x6dDefx6d47p+cMs0Ya7w=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G3BGcee6QOMDC3TzCyRE38TRTZe1ARC25/mxPFUdNRvag98a7y8GMVGFRFpRb3hm5yE5S4fRyur0Yc/ungh+yWpZ0XnZWKlU5QTbu2VkLCkh7EdJbXdk9f2WvZDSodK9g0stzWX8O/ohP2+W5T1/gzrzD7Ein+pK61ZX+uqFauc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RXjcJ9oX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=W29p2ftT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RLHSTE005515;
	Wed, 27 Aug 2025 23:49:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=I11oiyJB8P1toXjPypkk4P5j+0E9sTvIlp98aGykbCA=; b=
	RXjcJ9oXbKSFiorCKLLOU/ba7nEp5L+Qk/d3ahBd1iJsOwgPieqVOwHTsmvfagF+
	hWI3evQ2WEgEKizCKd0uRH4mZch7vDXrSnane0qxTmRptZhPdP4kOYpB5hjnXtQc
	sFUXtH2ysfoRmUTw8Mu+7br7Kfc3ZGo3OUug1mDOWkZlk95gDFpsvxhzwEnQyk2+
	niGluZDId68JmLH/+XHi94Kw8RBRmRep5CTNtt2R4eGCjyhKephLTZ422AmtCtQM
	oGKvmTjBABvDa0H1OoueJYOgk/aQxrfQj7rE9MEhea2uEbMDkGD7u3u8eRJ1k+8i
	luDR1NIhVQQAuM5/FKLN9g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q4jaqgsx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 23:49:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57RL20fM018955;
	Wed, 27 Aug 2025 23:48:53 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43baa3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 23:48:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jewxOsjmfEHM7dmZKcAjBdGkrGCToab8z46m/sTrk4cC/0ID3OiVywaB/88lrNn3+cYMPc8zN9y87JRjTc2IG/kuShRNPgn2kGLKhZP+REyaDK8ydRitdtQ604LmGzVpesPuP19eM4geD+r9kMgCGoB4+FzCC8M58/FEzZTAbvlU920pluhO1OIBWwVEJ0WqtPhbyNIM01p21shwrGaWRmwU9Rh7PFgJoJm9eFqn04K7X9GAmIO2gSWX1rFcNn5wicNhNTS8evxwy0MH9VYrvty4Gb3p5ObBZ0Pqz9kIOW/reh6IFVTRgYfV9Ti4cUFOVG9MrN+uvnl8LuxyWcZyIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I11oiyJB8P1toXjPypkk4P5j+0E9sTvIlp98aGykbCA=;
 b=nUoXksENFfsrbUeVsggP5zfcvyGiTlQiXIT73lNII09W5euVR9lZUtGh83UjI5zxbrjBkY2rPFipVCGLgsS7Wc28yZ/Hzenz1rs0KQr13otI2pTGWvImYbWE2IDVK3bnT7YKeITyjTIwVWJMasMFHISy4V0E+jqC8YsOKF9M/1X1PlbFVFRRPo9LWzlUCXTfZHY0/OJ8VQgIQcEGGeVvMbxALIxvbv3L23GafViZrYpsoJjA7J2hHrJyx2jhM2mWoIKDwcvQRyZq8ADrAPT5LMgErTMMGfN7HEBAvWcZ/grmYEJFkfZ86cnOL6l+viurCOz/Jo1WMJmG0I3GrWhgtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I11oiyJB8P1toXjPypkk4P5j+0E9sTvIlp98aGykbCA=;
 b=W29p2ftTf87HuGqlOytbGZZAGhpNpAzBTyk7CyxTUdOTzGZO4zKyoNxH/4MHq/snbJItp7Rs1qtQMmCnCLV9yLV+2CcndaDh971RgBUNZRjKrkbie8yfzGr0sHDMnvoo+yTJ85eEzjwws3Z/RygnFgra6Rwf8gPrPBFRTimpBao=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by IA0PR10MB6913.namprd10.prod.outlook.com (2603:10b6:208:433::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 23:48:49 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7%3]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 23:48:49 +0000
Message-ID: <b18de932-cffd-4d56-851d-e4aeca73e08e@oracle.com>
Date: Thu, 28 Aug 2025 00:48:41 +0100
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] sunrpc: hold RPC client while gss_auth has a link to it
To: Trond Myklebust <trondmy@kernel.org>, anna.schumaker@oracle.com
References: <20250827223831.47513-1-calum.mackay@oracle.com>
 <6813623b0780828d7e2a6dced04f74f803423f20.camel@kernel.org>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
Organization: Oracle
In-Reply-To: <6813623b0780828d7e2a6dced04f74f803423f20.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0598.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::22) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|IA0PR10MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d4b4f21-696c-4aec-2c66-08dde5c44507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVBUUVhibGtvemEvVlhnazRkdXNQdk1VZ0YyK0ZOaGtxL0ppY1B4aUwxMHkv?=
 =?utf-8?B?cHdEeEZodS9rTmpCL0NzcW1QbHlWbkNwL00rMzRLUERXVXAvTlV3V0xtZ0ZM?=
 =?utf-8?B?eVlIUGI5dFJpekgremlKMlU0SENwR2VpMU9yL1gwNFZZRkcxVEZVdUpRemd5?=
 =?utf-8?B?MWQ5MmRwRnk2bk9UZzF5amtod2pnZmNPSExsbS9Mckx3bG16eDVFRysveFQ2?=
 =?utf-8?B?Yjg3SGI1b3MzNy9QOVkzWWlWN0pFSWtwSjhQUGRvQlZmdlV4SytXaGxaOERj?=
 =?utf-8?B?TkphWHhVNzNFczRWQk1CWVBpSk9OYnh0eUpJYU9UVEZ6cjYxUVNUODhQWkRq?=
 =?utf-8?B?R2JRc0NnMC9ORGZPNStFeElJRnZtTy9abnBzaU5rU1g0QjJpWE00WVBXV1Bn?=
 =?utf-8?B?MW8rbzhnWTExOW1xUDhIVlVPbjdjVjRoY1M1b29tNDZySDdTdFR4M2E5K3hx?=
 =?utf-8?B?bEI4dmZYaG5UeFB0VndGQSt0eTAzd2pzQkhKZ1g2TENHZlBZZGZSZVJ0SnhX?=
 =?utf-8?B?TWpzRDBseXI4UTA4NWdYUnlMdXhtOWxud3pXdUtqZElqenpobXBWNWtFWmJk?=
 =?utf-8?B?MnFJTWJ6Y3pqbTdQaFh0S0h0M1FmaGsveXVKWG1sODR5OUQ5eXdjS0Zna2xr?=
 =?utf-8?B?eTVjNlFaejNIaUFCMHpNQ1VydUJISEZSV1E4UEZORXR1L1Z5RmdWVWJBeHlq?=
 =?utf-8?B?SVE3VWZPUC93TEZwSHplNHlBeVRqT0JVZElPS2lEVG9jR1pNOUQ1bHY4UE1y?=
 =?utf-8?B?c1krbVBVbkhTTUkzZUF6R2NIZVVXeHhCVnM4aDd1OEJ4MityRzZMNzgrSGpR?=
 =?utf-8?B?RWxnbmovdmV2WXZmZkVUb2tVRFNrSlI2N29IbFh6eXZCTEREdmpCWHdldWZ0?=
 =?utf-8?B?SXdlYWwxS2hKeGE4dmdwU0NGQlcyaXE1L241bkhSMU1iQysxWUhtWkRxVXBR?=
 =?utf-8?B?ZnNmNkpMN0tHc0J1RU5zYlkyS01HVytsUmllbVRKQndDM3ZDSE9TSUlMZ1lt?=
 =?utf-8?B?c1pOY09NMi9waHAyUXFKWHBsRXA0Qm9LWnFSN0tocEpvVjlmaGN2anVYV0xm?=
 =?utf-8?B?Tmx2L1hRL2JEMnVDbzhRaGtDS3JvSWpyeWJGK1J5dk1FUlVraTNxRE96NGtq?=
 =?utf-8?B?YzVSNVcxZVlERWt2MkFNN3RwVzNnMEoyRms0SUsrWVd6Q0NCNFhYYjUrbC9l?=
 =?utf-8?B?ZnExNlF4enZLQ2daR3JDckszUXlobjZpbVdUTWh0NUZtT0ZTM29sZkNoZElE?=
 =?utf-8?B?QTJSbzJYZVUxVlRpQnFCK1BGbzZaTFNPT01vYnY2eUJuRDI3MlRxREZVM0wz?=
 =?utf-8?B?NUNPY1lLa1dzRnNVVGN3enJRY2twVEl2WndwSTJMTDdJLy9lWmJLemo2YXJB?=
 =?utf-8?B?OXhFdjJLZ3BWL3V5YUZQK3RnOTkvb3BzTzhxQUJGSGJpZXdkNndlRkR4OHor?=
 =?utf-8?B?c3NRNDdoL2F0Q2c1QkRwY2lubHA3cWVsWTRzeVNOem80aXRHM2h1c0Zaa1Rj?=
 =?utf-8?B?bTdwWndjTFpTWEtwZGhxZ0pmQ21vZmtmZDVtV2NrRnFNNlZEQ2dVL1dMT1Mr?=
 =?utf-8?B?NWRGTHhSUG5rREZRRUhZR0I2disxS1ppTURZc1ZJTElrbmpYbDNLTjJZVmZE?=
 =?utf-8?B?SlRJcWdLU1hlNCtzWGVHOVV6QmgwNUhsZm9VZUlZbTd0eEV3ZzQxK0hqTENV?=
 =?utf-8?B?cEZNak55SG9pcXN5OE5ORHZVKzlWeHRBNlFMZzE4NmRWNVZUVXhQWkFacXVI?=
 =?utf-8?B?VW51S0RYUElSc2dDaHB3cVptbGxHMUlzMExBOEFXNFBNVkRGR003N3NYSUpP?=
 =?utf-8?B?WXFCTU5EdDE0cWNnUWxUVlJjaWpKMnN5clAyazN5MGlyYmxVV2dxd1ZQZ092?=
 =?utf-8?B?aFNXQWZ4VDFMaFBoVVM0cTBrREYrbGJieUZRdVBoWElVYTh3QUc4dUFRMEEv?=
 =?utf-8?Q?ox/iQHJfNHM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjNVN2ozOFBqY25wbnVNejdyNXc5ZS8zWGpFc2xBRmdVaGRmekk2aVlicU9k?=
 =?utf-8?B?K0VSWk5oUVpIMkhoVlUwRGQ0bHI2K3B5VUpFSXVQTDhKSlcvS3hTb1A3Snk4?=
 =?utf-8?B?Z2RVYW9JUVd4a25MMy81TXRXZ1hPczVncVNFMXRBbUpwY3AwYXVCVTEwaDdZ?=
 =?utf-8?B?b2tmMkE2UzhPVHV6d2YwV3Q4MDZScUZLblZHQzFCNm5EYkNTRVJyVi9HbkpV?=
 =?utf-8?B?c1EwdERUNWxlYk1POEZnczh1bG5pTVZhWGp6djVxbUtwTjJaZjUwL0ZOY1ow?=
 =?utf-8?B?WWJuVm5MYVRWWHpUUVVQZS84b2NTY25RYWJUM09oVVpoeUM1aDRrQ1pNRUpX?=
 =?utf-8?B?aFBSSEM0NGZOOWsxWUJ4NFZ6MTU3MnFVRzZ4d29RRTlkeW03L1lXMkFTOEFj?=
 =?utf-8?B?MmNRSlZieTdsenUyemtOUDJQRDI1SG9vc2d4WDhRSWR0OUtMQ1d5Tmtyc1BN?=
 =?utf-8?B?Mm1CVWpzZ2VKZEFkWGpxOXZsQitSRk1VWDhpRzgwUE85OEVDdEpyOEFqSDVB?=
 =?utf-8?B?Zk9wWTlxNEFaOVV6OXZzNmpFM0NvV3RZaE1JWnJ4b09DVm4wTEpLMmFHQnBB?=
 =?utf-8?B?UnNNSFhJbGZaMitXT01ZUytWM3pxYldwWHV2S0ZLMGN2NG9sNEtRVEI1dW9V?=
 =?utf-8?B?eDZpOGx0QzJ3V1VqNS9SYUNBcTF0V1YvM3NpTVJ5Qk5Yemx4QVBGaXllTDRi?=
 =?utf-8?B?bnM1bHBoakhEQXE5MmJwR3VHeWdQTXZHTjlROFdDTE51bGs4anJvS09yUEth?=
 =?utf-8?B?U0czUVRkS1J5MWp5OGMzamg0UDVqZzJTTzJzWWVhelUyMmV4YXRXQmJyWTJi?=
 =?utf-8?B?ZG0vVXJQTEhrTzlLMkV5OElrblZTa1pFVzBlOUJIM0tyRHdKWFdiVk9DMFhL?=
 =?utf-8?B?dTY3dFBlbnZBZlBJZmg0UXMwenJFUmpXN3dSZ0Q2SGpzb2p2bWlsL3V2U0sy?=
 =?utf-8?B?Q2RnUFlCOGZSYnVzcXZKM2twMThxUWwyOHpOdkVUUE5hNTBJNHhHNzdJTW00?=
 =?utf-8?B?WnBUNEZSYkRCVjFWSzdLcm1rV0l0aENIcDRyUWVtanc0RXgxWmZKSnpab0lB?=
 =?utf-8?B?NWhWbEkxY0JoZWRUYXNPbHRiQ1BFZVNBVXNUZW01MGlJckdCejZ0SXZ5OFBH?=
 =?utf-8?B?TUR5Ri9tRTlPZHNGSGNncHJQcFJudVVRSjFIZ2p0OGJWRWx0ODdxbHRkMUd3?=
 =?utf-8?B?ZUpOczJFMWJZbW1qTnBiaDJGbk1rVktHY1hIbG5ZVk5NVUdMWGorZDBtZTFO?=
 =?utf-8?B?VjBuMFE2a0plSEkxQlBUa1QwS09nK05meWlGc0tmSUxMcnRBa1FiZkJkWER4?=
 =?utf-8?B?bkNWa1IxODJOQUxKODF1Q0JDYnZySVhubzZxMmNzbWlUeEJNY21KQVdybGor?=
 =?utf-8?B?eThnSGJ5anJXWWRzZXJpRTJTVmZGdnlLVTVQc3NzYlpUeXVoQ1pSbG4yZTZQ?=
 =?utf-8?B?b3N6aVlrK0xCM2Fxb3ZCWjJLR0FpckI2RUc3M3I0M1pJTC9Wc09IS3BYc09Q?=
 =?utf-8?B?QldpOE9JczNncjE2akZoZ0lBSUs0Tyt4VTFNMGZ4OTBMN1pDTVBKTFBUdzFG?=
 =?utf-8?B?YWtxS0FoMC9USVVtNnQ5eTlhR1NnU0llbE1EeXMwTTh3ZUJLYmFVaTgzNEkr?=
 =?utf-8?B?a0JwVXdqSU0raXpVclU3YytSMWk0MFM3NWtZSitKRWlOQ0ZwU0FkT2VHOXdx?=
 =?utf-8?B?dHJZMzJiU2d6K251aW42K0gyc0dqNmlnUkF2Yk90bm9Bc0FVVmNVcEpOTnIz?=
 =?utf-8?B?SjJDQjdWZFJCekVWVUplTXBLOHprZVVsRkFNb1hHc0EzTW1XNDhlVlJvWFdI?=
 =?utf-8?B?aG1sbEswd3JTT2NRL0pSNmFHZlhib2x6b3UyRy9INnRXSHdvUEI2SlBaTm1w?=
 =?utf-8?B?NmU3SmpZeDhXblpOMC84N2V5SDZHT01FTkNVYXlQZWZ2dTZtNkhCNDlxczVY?=
 =?utf-8?B?RmExNjlSdDlEaEsrZzFoN0J3Y25CZjQvRU1HM2UxeWx0QXhzK1ZvRml5Sjdi?=
 =?utf-8?B?WW9ZSjlHVXRxSWEzN1lCMzR2YVhRcFpZS1dwUStJVk5vcnV2Rkd2M2lKMTlY?=
 =?utf-8?B?b0lTMTYxL2NadWNLeFcrNDVWcCtWQ3E1WmFQRGRhRHBabStpQWZENGo0VmU0?=
 =?utf-8?B?bE5JWUhXejZOcXZOeEJPWXcyV1p0ci8rV3MwY1hRak1IZ2xnNXk1OFRtVis0?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	icNx8yc1r+a0vRkUb8UvwqCZl4osVsIUXffSlhGHr39U2MBtNImxIOErKuqZ0XenytmWR7ALzyc+ymaJ2FtHPG2kdMpwd+F1n95GzuYdj3gztxTcttWFL+RkdwOzOmWdj9EthQql1NQiflGB9nI9/znxwuI1T51YiagIdlpxZ+msqgEcXsw3lvrWn52DyqdkwNixAJ+3kKi5huGej2LJTR4xfHg+YrrcPlkODR6Mm/RcjZjl0fdYY9o0h/5TFRELPlMx2YlySOzZt2avHlw4K8q78BctOXtSmR6X8fLKxFl5r+td3Wrrp5jwnd3s7/Etd1qO1OD6J28r5Ly4OH0fiYwejIjT1xRlzz8zg5kVhpZQl0CJtHMoHBSWsybDpq15Mu/ly3Bni7kRvc5J0mCMXo+MlD1g/6Z0ozNfTRI8BOoFwlM7BT9Ze2hKUlH0cMHdNUZkiKaAA2W0NuAmrlY7X/0LnQLFpNZI4Q5bzDqbUxnRZgKSO8rbz6Ii7xvHipBI7wpHseYytLh0yOoifiSVXerf437l3SYRj/c+tQpQhSIHQxDCU9XG5ut2aNmh0sF/8V0Z13UCec8/6DMUibTv/IwhIshwxDOCGToJt8En/LI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d4b4f21-696c-4aec-2c66-08dde5c44507
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 23:48:49.3608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5XaWQxuhUd9lSt8FfImjrPwCDeRhL9YDNy6F/8hZxtoSBD5EJENsA1wn8Yr2VLlvoLpaBpbKpJpqbPUYVhNxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6913
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508270203
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxOCBTYWx0ZWRfXzqsfDw3Mrn5m
 /DcZ/CfKU5KxbOcjyF3YnLKorpeRYjRkVi9qhinMXIjo6/Vgu4/Iuw6CZkKIWn3//S2c35dwz1F
 WhZKlp8FwGwrSMuMk5cOjtDc6zsQVeg6tLHzg4D5vfDmtBeLNw0sOhFClW/EHtM20e0zL1AuD6M
 Hcdrz6abBHejAF6I0C3zTvxhNp+SMZWMpXFM4bSpOhuDesJ2u+TEpTkOg5NH9GvmreV6bYcKVlV
 L1/7RmwhfQ49qdBXPeuKVmKFm/J4fFcQZS4JbFUxweodMn3vnJFR4nUz+B9AhWijeoMPxv5EL94
 wKdMP/ioJaTwWVbE7oSdeaL6k68ZjwdAP+/106rsJDO3CCRAHpApf4e67ywEGdCfhqpzAExQkvI
 YG5eouNL
X-Proofpoint-GUID: G0I6iHpSE3VVnx9seX_w__sVBIXyr5oX
X-Authority-Analysis: v=2.4 cv=IZWHWXqa c=1 sm=1 tr=0 ts=68af996d cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=tSDpsRfd-Lw_3FlsAWwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: G0I6iHpSE3VVnx9seX_w__sVBIXyr5oX

On 28/08/2025 12:33 am, Trond Myklebust wrote:
> On Wed, 2025-08-27 at 23:38 +0100, Calum Mackay wrote:
>> We have seen crashes where the RPC client has been freed, while a
>> gss_auth
>> still has a pointer to it. Subsequently, GSS attempts to send a NULL
>> call,
>> resulting in a use-after-free in xprt_iter_get_next.
>>
>> Fix that by having GSS take a reference on the RPC client, in
>> gss_create_new, and release it in gss_free.
>>
>> The crashes we've seen have been on a v5.4-based kernel. They are not
>> reproducible on demand, happening once every few months under heavy
>> load.
>>
>> The crashing thread is an rpc_async_release worker:
>>
>> xprt_iter_ops (net/sunrpc/xprtmultipath.c:184:43)
>> xprt_iter_get_next (net/sunrpc/xprtmultipath.c:527:35)
>> rpc_task_get_next_xprt (net/sunrpc/clnt.c:1062:9)
>> rpc_task_set_transport (net/sunrpc/clnt.c:1073:19)
>> rpc_task_set_transport (net/sunrpc/clnt.c:1066:6)
>> rpc_task_set_client (net/sunrpc/clnt.c:1081:3)
>> rpc_run_task (net/sunrpc/clnt.c:1133:2)
>> rpc_call_null_helper (net/sunrpc/clnt.c:2766:9)
>> rpc_call_null (net/sunrpc/clnt.c:2771:9)
>> gss_send_destroy_context (net/sunrpc/auth_gss/auth_gss.c:1274:10)
>> gss_destroy_cred (net/sunrpc/auth_gss/auth_gss.c:1341:3)
>> put_rpccred (net/sunrpc/auth.c:758:2)
>> put_rpccred (net/sunrpc/auth.c:733:1)
>> __put_nfs_open_context (fs/nfs/inode.c:1010:2)
>> put_nfs_open_context (fs/nfs/inode.c:1017:2)
>> nfs_pgio_data_destroy (fs/nfs/pagelist.c:562:3)
>> nfs_pgio_header_free (fs/nfs/pagelist.c:573:2)
>> nfs_read_completion (fs/nfs/read.c:200:2)
>> nfs_pgio_release (fs/nfs/pagelist.c:699:2)
>> rpc_release_calldata (net/sunrpc/sched.c:890:3)
>> rpc_free_task (net/sunrpc/sched.c:1171:2)
>> rpc_async_release (net/sunrpc/sched.c:1183:2)
>> process_one_work (kernel/workqueue.c:2295:2)
>> worker_thread (kernel/workqueue.c:2448:4)
>> kthread (kernel/kthread.c:296:9)
>> ret_from_fork+0x2b/0x36 (arch/x86/entry/entry_64.S:358)
>>
>> Immediately before __put_nfs_open_context calls put_rpccred, above,
>> it calls nfs_sb_deactive, which frees the RPC client:
>>
>> rpc_free_client+189 [sunrpc]
>> rpc_release_client+98 [sunrpc]
>> rpc_shutdown_client+98 [sunrpc]
>> nfs_free_client+123 [nfs]
>> nfs_put_client+217 [nfs]
>> nfs_free_server+81 [nfs]
>> nfs_kill_super+49 [nfs]
>> deactivate_locked_super+58
>> deactivate_super+89
>> nfs_sb_deactive+36 [nfs]
>>
>> After the RPC client is freed here, __put_nfs_open_context calls
>> put_rpccred, which wants to destroy the cred, since its refcnt is now
>> zero. Since the cred is not marked as UPTODATE,
>> gss_send_destroy_context
>> needs to send a NULL call to the server, to get it to release all
>> state
>> for this context.  For this NULL call, we need an RPC client with an
>> associated xprt; whilst looking for one, we trip over the freed xpi,
>> that we freed earlier from nfs_sb_deactive.
>>
>> Ensuring that the RPC client refcnt is incremented whilst gss_auth
>> has a
>> pointer to it would ensure that the client can't be freed until
>> gss_auth
>> has been freed.
>>
>> Whilst the above occurred on a v5.4 kernel, I don't see anything
>> obvious
>> that would stop this happening to current code.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Calum Mackay <calum.mackay@oracle.com>
>> ---
>>   net/sunrpc/auth_gss/auth_gss.c | 16 +++++++++++++++-
>>   1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/sunrpc/auth_gss/auth_gss.c
>> b/net/sunrpc/auth_gss/auth_gss.c
>> index 5c095cb8cb20..8c2cc92c6cd6 100644
>> --- a/net/sunrpc/auth_gss/auth_gss.c
>> +++ b/net/sunrpc/auth_gss/auth_gss.c
>> @@ -1026,6 +1026,13 @@ gss_create_new(const struct
>> rpc_auth_create_args *args, struct rpc_clnt *clnt)
>>   
>>   	if (!try_module_get(THIS_MODULE))
>>   		return ERR_PTR(err);
>> +
>> +	/*
>> +	 * Make sure the RPC client can't be freed while gss_auth
>> has
>> +	 * a link to it
>> +	 */
>> +	refcount_inc(&clnt->cl_count);
>> +
> 
> NACK. We can't have the client hold a reference to the auth_gss struct
> and then have the same auth_gss hold a reference back to the client.
> That's a guaranteed leak of both objects.

Thanks Trond.

Would an acceptable alternative be for gss_send_destroy_context to 
simply not attempt the NULL RPC call if gss_auth->client has already 
been freed?

cheers,
c.


