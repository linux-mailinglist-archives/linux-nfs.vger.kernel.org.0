Return-Path: <linux-nfs+bounces-20311-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJDeBc3Jvmm4cAMAu9opvQ
	(envelope-from <linux-nfs+bounces-20311-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Mar 2026 17:39:41 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E902E65EB
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Mar 2026 17:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D80AE3018281
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Mar 2026 16:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8B332B9B6;
	Sat, 21 Mar 2026 16:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YzlkXZMX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UmGmY92J"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10282D9ECB;
	Sat, 21 Mar 2026 16:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774111117; cv=fail; b=V+TgVqEf8LOpOhQ8WFzLPUcGMhsBfaOkGoQGsIwyRPgE7TKEaQN7YEpvhNP8reWKt6FFXWm38IVKNPSyxnY1RtWsaBbRHuAP5cNix/3FAM3yujXIPP+9k5GTvD68lIVa8OSbXbDK17QcUbk/B71zB9KIILh9L8qr/Jd6krXzy6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774111117; c=relaxed/simple;
	bh=GKJyDaew93tu0lvGp5qmBeBt1xK279gY5sGZVSRycfM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lqV7P0BoZse1cPODNwSavNVhxlbpbcuaNA+bcxMgIuCS8Zbkc0j6/IxtxJDxqGk4GYyJKR5QopM8pWCyQUvSyGU1Y0Km9JG1CfgYzyevhwPH8xz5AImbn6CBhCKS9c10iXqnI+P8119W8asPy6vlbK4KY7IYt4nZTm1rMj10roQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YzlkXZMX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UmGmY92J; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62LFceTF1345987;
	Sat, 21 Mar 2026 16:38:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=8tI2jPexRoN++PueS+U6x+VV2W2r2aR9vbYQ6/msMwc=; b=
	YzlkXZMXm+3KMGw+pQQQ7WoEV+HTsjuNO2yU12GA7d5p1HxClpZOLx3urhLgrCPQ
	cffe4ridBAuJ4Gv7wU7Ba+CCDTMwvHSVgXecxi7l1ji3IwNR1I6nCpPubPsnB8LU
	MSQP3XI6zPmUQ1J0ScAA4tBoKrwvQVNESgfvjy8Se5UrrrlWnOnN3K1FiC5uMJAx
	gD/Q8puOvcOr3Ymge+/Oe4tDne9B/4i0BrY1Skk4gjh/Aic+a86xFQTIKvQDUln/
	VtD9AXND41Uo1jV/n1fzQNlmNc2FMWx0dlOI2bvTH/0fjy5G14JjAX1gXbCdtD6J
	kxKA4z1RleRdlNwHT8aTQw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kvng8y2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Mar 2026 16:38:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62LFCX9N012371;
	Sat, 21 Mar 2026 16:38:23 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010049.outbound.protection.outlook.com [52.101.56.49])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hscyhcr-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Mar 2026 16:38:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUeU0VuI+T0RBp/pkNHJpjJCyigUI6fsT91vqMNMHrOSNVw3H6glex61aozNyzmY6hEu/orr9T7Smu2dk0I+q49UgWDS3PxGbtev1/knBlLNef2PwOE1E8a6rXq6Ak1tRsG4f7Ld4elb5d6H5oti2sKm4ouei6ndTORwwH8in+thjcNfbhEv7T/A6x638CLyjsy1ybGpt1Ss2fQuVO8h/WY2csM/8MrF2JewFbeboGHAz0x/XWuhYpvaP5RUF453hDBpL7GzY/NILvPkJ80KYrj4ME3QcxOvshbPx41j+3h+LKm6kAPqm7mi3lrWRUXaJ1rKuPe4G9wRE2tAAPBy2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tI2jPexRoN++PueS+U6x+VV2W2r2aR9vbYQ6/msMwc=;
 b=LVHhrbtJOGCMtdx5II5I3AXhFb9Gz/+N/yIGQggyOr6Iun/Xx6lvqtCLxo9Kh/fzqKbVlPEPCPBV4JgMwHoHPZTvqJ6eemiN6UqONXTqALt5Sfl4xq7KMbXSqZ6qb0JrDyDVNFT0EzLu4hyV5MXT8YtDBBquWHaVYLASnNbHCKa5Xyx71TJV+/nOxXkUNsHIvzpqaR17Kif2uy9kBFXSCYQr0uW1pYrJrCi2/OTZzbGsweBLVpZu68373CcVrgPdl7u8Ogp9ct/SLB5Ck1wZfzkeZnf0G0ZbP4cEmavTOMJpzvjdAU+dmYBlgxdx9EuBrFL1a9T8kq1XErnPi0jicg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tI2jPexRoN++PueS+U6x+VV2W2r2aR9vbYQ6/msMwc=;
 b=UmGmY92JvGkkax4FhzxbxOC7SCKPxuT3fiX6zUZeVCXnNolX8xCpKXL5fsTmClhz5XuoNZci/pjYbb4MKqWbDKZmVU2mQe+aeje7CSGAfOBw9zXcsHxQ7DSaUshW07dhxDeZEhJfNzYmVhyXKPnAZ1uAm9CadksF7Ofq/BqKZ6o=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB7782.namprd10.prod.outlook.com (2603:10b6:510:2fd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Sat, 21 Mar
 2026 16:38:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%4]) with mapi id 15.20.9723.022; Sat, 21 Mar 2026
 16:38:12 +0000
Message-ID: <1319acf7-36fb-4be6-9921-b0d19a2aac7b@oracle.com>
Date: Sat, 21 Mar 2026 12:38:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] Revert "nfsd: Mark variable __maybe_unused to
 avoid W=1 build break"
To: Sean Chang <seanwascoding@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        David Laight <david.laight.linux@gmail.com>,
        Anna Schumaker
 <anna@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260321141510.68214-1-seanwascoding@gmail.com>
 <20260321141510.68214-6-seanwascoding@gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20260321141510.68214-6-seanwascoding@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P223CA0011.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: cb4f3a36-8cc6-410f-d015-08de87683e51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	N+CnUUDr/lmh0OE5KGY9/dP1yg4iZ3dxdRhE8heyFsQzTUb1tn2zStTgqSFOwR4ToDpWtwi6K/u2uKMIlWWZNyIF3uQo5ZLccsafr95I4CIYjK/zZWi5Ma/oE6fJW19Kb3YSXvPVzGpLlbnlq4UGvfILmacKgnn2Yg/ABuxN6Hb58lJ3R/2v2M1Bqcvy+Hw7m/XFEWSkBT2lZJXR+C17+m/vOvXQdc3N+FeiVSlGZPcWO/bJ/Y7pQn+zx8I34uhkSqI9jIGTR9EEDwF+QIO32ZI00M51qftfDICe/cnsMhopzApwKbF2ZBqULXfFTNHzl+BhMDmI/WtOrVDs/i+B9MDFyEZhJxN0eVvU3TDmP2n5uw1OCgvWD9n278EMK1a4nCcIFPe0pT7z/PrUa9X1T/gBdcPNS3+tq1SOxl3hQzuom/Zb97U57TIFpus3Egxtbe9Cp80Lzy9rGHmSuzRvLw0aZVOTwKRt0QsFYrLAatJOG8ptlUvcCM1HDk/TZTbYEKOlBfhQjNZnCWZgjSFHHbq7pHlNDy3hKeYR0srcMzLY9nSW7FDF+xQnm8AVXxthsDIfqY8sTschWLUteyZyX5SuYCMEKTb1pxqM172oyJ/NIhyIqfCy2rvLqrHNdB36hY0RzgnV7FmQzGNhRyOHCrlgRXOyiBdKPB+Se1fHJBSEFQPH61QFxn8gdHVZge/wDA7qQ98CUbfzmlyNEK+/nrCR9FJYezC9XQ36x079dgA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enJQQWVZUENYbEJhTmdzdGFYUE5Cb1hmdDJzaVI5SGRFWUY3MXBlYjB1cDRJ?=
 =?utf-8?B?LzNpL3kyVHZVaEFJTEFMeHNKWVd1Mi95TDYrM0hJVWJCUnJVUElVM01HNEV2?=
 =?utf-8?B?OXRDS0lyNTQrVEJ1eDQ3TkhCUHNHb2ppd0pMc2dBZmhCRDI3UHVuRmdkY0Zr?=
 =?utf-8?B?ZUJhWU12UFcreXBYaW9JanNoMVRGSzNjWW5JbEU1Mm41M3JhSlNmY0Y3dFJq?=
 =?utf-8?B?cW5ySWtnMSt4VnRYeG80TmN4SHJ1R2RMcUFJdVdmT09zUXJRK1lhK3RxUVl2?=
 =?utf-8?B?UUtUdnVwTUhZelQ1SUV1bUE4a0VHQy81MTV2Qm9ybmdWSjRobVdIZ2NuSUdx?=
 =?utf-8?B?ZFp5Z0JidTdRdWRpY1Fkbm90QVppeEVCUy9TVmJOS1BFS3RWb0xiOUtSbXly?=
 =?utf-8?B?aW1BcWZxZGJxdFllVTg2SGxBZ0lMUlpBZXllYzM0WmJ4b0lGNFg0Rm9PYUxD?=
 =?utf-8?B?VGx3cHNaWkJMbVYralZQM1JkQjJ2M0IxeWlDbnZvL1R4ZElTaFY4TXBXTy9a?=
 =?utf-8?B?ZlY4L2pvV3VreUdsTnhQMW02djJPejE4MG04R2Y0dUE0TFYzaDNpOVVDaDVw?=
 =?utf-8?B?ZXNNcUJmcFdSVXo4Ukt2OFVTMXBxN1EvUWVNV1RtZ255aHRVd0hha09xVWFJ?=
 =?utf-8?B?K0t5L2tEdjZxcG1GazBMZTlRZ21ocGRlRml1d2huWWJ2ZVFHRXVKL1JudHZt?=
 =?utf-8?B?c2JnbDhTOVk2MXpPekZJM0w5MXFrSVNRSFk2ZjYrRktoMC9iaXRDc1dleUVI?=
 =?utf-8?B?dWVCNEZNN1BQY2xDVjcwY3RVYTA0YStrOFRYZVNWRGlnS3JXNmRVL3RUYThY?=
 =?utf-8?B?eFRESkR6TDg4aGNQUXlyUjN2OEwyMUZWMHN5ekZJcmRzZnIwM3g5V3pUMmhx?=
 =?utf-8?B?eE5TenJjYm41ditlWm8vMHBMcVBPOWFqdUdDVWhqL2FncE8wNE5GV3hLMVZN?=
 =?utf-8?B?clNGb3N4aVlTYjYrSm42bG96MjZ6aTVhME5nRkNwakQ4N1FZdzJvQ2llcmNs?=
 =?utf-8?B?R0c5WHB3Z0pKK3AvcHBCU0JyK0R4eDc5SHpIWm9aU0J0VzZqR3U1SUI1SXdq?=
 =?utf-8?B?ckhJSFBvTzl6eEVreUtRQVFjR1UwZnZCU2MxcXNjeHI0SmovL0c0Y1JiaHRm?=
 =?utf-8?B?OXl5WE16czd1Z3BpSHF4aHpMY2tBZzd0NXBUOXNkT1F2NktVNytRT0t0UThx?=
 =?utf-8?B?ODJJYnlRNStFS3BXWmMrMFN6MnlueG5LSTFPVytRejNoSWtWVGIyOXV5aUlq?=
 =?utf-8?B?QlFjREJIeE15TkZrS3RSU3B6QUg1Yi84M3phbnhtSHg0NHdnTTZhbTdhK3NU?=
 =?utf-8?B?VXhRQUo4cVhFVFFiZ2duaWxnbHJHenJEazdJSS9MZWJFMjcxWDBDbTNRVGlR?=
 =?utf-8?B?S0ZqbEJYOUZVVm93ZUR0VGZ4SVhqM2tUVzJTdGVmcUh5UVFqWmtwZ2FjTk1M?=
 =?utf-8?B?NXRrOXJuUFZYeW05ZUs5NUJ2RlNabWpHNTdZTFg1Sk1TVnVuNjAwZEk0Zll6?=
 =?utf-8?B?WDVMNFhBVnN1MnpYWDVGbGRJQnpCeFY0VUhoSitheld0cHhoVnRGY0o5d05q?=
 =?utf-8?B?cWs1Tk5ES0hCUlFIeDJBK1FmT0Nkc2dXaFZUbDN6YVdTMGdrUG41QjU0Zzhq?=
 =?utf-8?B?RytDd3A5N253U01kaE1NVUVicERIby9SaFR4cHVFb0JwOWZOSTBwWEE1Nmsv?=
 =?utf-8?B?N2lBUGlXbHF1U2dxNjVKeVlyRUJkWVNnbEZJK2tkWDFoc3VhZzRZYUtJWkRI?=
 =?utf-8?B?UHJYWTczWFp4Njd3eWpicUI4cFREc2NMK1lrdEpJMnRiSFJFb3AvL0x4VE5X?=
 =?utf-8?B?Nlh5SnlJM3RObU4rWEducjVieDlxc1pBclhJSGtPR3pDYnY1eGlsVUI0R2Jy?=
 =?utf-8?B?cFMvbGRRcGFhaXlPVTlaeVBNdTB3V2Fubmp6Z0VDU0M0RUdzQk16cmhlS3BY?=
 =?utf-8?B?eUhEM2FobncvNDYxaGdVUmlrYVB1NFBVcHpoT3BEWkZZNG9iSENERUNzL3FP?=
 =?utf-8?B?aEJxY3FWekJueUM3RU1STTZHcDBlc205YSt6dmt6Qno0MjlSK0JWTGpnaGFh?=
 =?utf-8?B?bWoxVEJRTC82ODdBMlhxdDl3Q0paTjVkNW1wRXB5V0NqaUp0ZjRJbTI4elhz?=
 =?utf-8?B?dW56QXgrRlN4SndVbGZGUlVXRk5ueTEwUkk0SXEzeFZVbnVHaXZuemhJTHVS?=
 =?utf-8?B?b2NFSDJseG1MQ3Z4MG8yWG41K2ROMHBDMVNveERTZ0I0REZoSGs5bWZlYzdy?=
 =?utf-8?B?ajFwT1VQeHZJYnFWVFd2RVkwRjVRV25JUGEwWUJXdTZLZ28yejR1Q3Q2NmRo?=
 =?utf-8?B?b2lzd09jYSt0ai91dnVLVkJyR2wrQnY0L2xvUWFTVm5LemlnQzBydz09?=
X-Exchange-RoutingPolicyChecked:
	DI9Gg6PQWdM0vZqGLMrqzv5RJnnlCbagVuYXPgkxbg4XV8eT3jNhUxY1LEcdn8Whf5tYYHXpdoBraNJsekfPU4QBuqx6wNn/huj5zY41IdjEoLhtW+jtUTPUccUfAY8STZdLEMBZtBLph7eWyE9B1GGxjo7CRfRUEtCVpuK7sm7j0TDXG70zNltXtd8E0F1+YqxuSvXfmQ7ZVAKI1iGpnk263D0r8yLkm11avPgnQ/vzLU/Chx5+NvjGSlGXrqLTDgmIJle55N6rNrQtU9WHjpD94kqG3usGtxfsR2WPhhfarknhrQs8VsNvHc4xjtAxYSoPmv5T7ddXbJDdm0hh2Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xzxy2PohQPWfr87BeM+/UVts/RIfeXctu6omTOIVKjRv1tCEFwmmdveuchDL5P3+Ui2lIykbWoee3TxGKD5pxf2kuoNWjtDlYl5dnhLDuhWpSCb0xBLGTZOK0y/qf1ffpVvdeWJF+ILge9VSv+Pmeg7jtDUlJt5JnrMHq3kLPVoWyb81BNp67fBM8oBHgUuoJBq9HNS7L9EBQToiharJdhqc1Imyd/PHrvQPLlJ6tPJIBgXUsvdnLqOCKo7HIlCZFRhhzMBW9YAw3jgFeiDcQK09Gl6W0REECqioEdk0DI9kuIqeeePxHfB1hJov5/jPZ56dtl1BYCp+voGINhFQejKNr4ZytteoAWtr37JqA3GETRnq2e6FdBFFaDsnFY4kCv5204z4sabr0FglD75mic8P250t6fUEczDX4Wrg51QFR6YqJrgMaZd+iVoG/k0SGCPh5Kcq7lYetSpGmUmmSRu5zoV0/Dn1qh/XHqO+PdUu8iBIbBjuX5O7k/jGXST81E2dgnCS5UPpBy1nYGdksnhBuWdD6v06rKAdbpRqG3aZNWIIqifnoWjWniHBIKp5pbhQpOFjrv3cYHP/JrnxdtuJRXlYElDMSLnnTkCMQZA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4f3a36-8cc6-410f-d015-08de87683e51
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2026 16:38:12.5810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZFlpb1IVqihpT2XxePsoIb52y24swYRj/E7LUa9f3e7bOZtUIMV9EMD1WPQO93944GDBYEuawMi4LivIEGKzvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7782
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_05,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603210141
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDE0MCBTYWx0ZWRfX9WlYfjgQ9HTB
 ccj9ZmPuRfT0284BrnYyRElTPVmhX++a6cE/fvaVOEPHWoemVITi2jwYPDDRu8MGEikDpO0C5K8
 bfw60rKE196Vqk0JRERT3crZfe2GwlQUTVv0kaqX7c1CvBIbPXnqOQDCMQmKzcYwEd69IQ/T/8I
 XFqVRB+p3vwyQM3JfyIh1aZpQoW2BnZq13vHumIyAFE5+eUKh+c6KiE+MxTZomZkhWqz9n2cNom
 OBXPIh8CtOEN0p5VHyOnl09XRDC2ryxDI3HtDdQsI+cP/lDIFbSOM2eTqPdN8DcnVBOGqh0AM93
 WyGsLLCivy7fyVufYzfwXCrUkFz3/65CP+qbmKtLaNjub1o0rwXZNSEg20KQpW2gbnDl9u44f4C
 taycEhbOOSygY1zs0pG3ndcTVzARAQxwmpihIJY1Q4ckBRThUL7J9yrMY9nOtk5W+7SZX6OexD2
 mzYryeJt//QNG3Z2ZuCJLDG0HcNutwlcyX2m0F6U=
X-Proofpoint-GUID: sVgOQ7Hr3vWLX6sPB8ik5NZ4jcNgb1N2
X-Authority-Analysis: v=2.4 cv=GrtPO01C c=1 sm=1 tr=0 ts=69bec980 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=pGLkceISAAAA:8
 a=_eWOYZVgHdZ361Mx008A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12272
X-Proofpoint-ORIG-GUID: sVgOQ7Hr3vWLX6sPB8ik5NZ4jcNgb1N2
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20311-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim,oracle.com:dkim,oracle.com:mid];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,kernel.org,intel.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chuck.lever@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 85E902E65EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/21/26 10:15 AM, Sean Chang wrote:
> This reverts commit ebae102897e760e9e6bc625f701dd666b2163bd1.
> 
> The __maybe_unused attributes are no longer needed because dprintk()
> now uses no_printk(), which ensures variables are referenced by the
> compiler even when debugging is disabled.

Some commit message improvements are needed:

This revert is safe only because ("sunrpc: Fix dprintk type mismatch
using do-while(0)") already changed the non-debug dfprintk path to use
no_printk(__VA_ARGS__). The commit message doesn't reference that
enabling commit by SHA or subject. If this revert is cherry-picked or
backported without that pre-requisite, the W=1 build warning returns
silently.

The commit message says "dprintk() now uses no_printk()", but this is
true only for the !CONFIG_SUNRPC_DEBUG path. When CONFIG_SUNRPC_DEBUG is
enabled, dfprintk expands inode directly via __sunrpc_printk, not
through no_printk.


> Signed-off-by: Sean Chang <seanwascoding@gmail.com>
> ---
>  fs/nfsd/export.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 8fdbba7cad96..8116e5bcbe00 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -1025,7 +1025,7 @@ exp_rootfh(struct net *net, struct auth_domain *clp, char *name,
>  {
>  	struct svc_export	*exp;
>  	struct path		path;
> -	struct inode		*inode __maybe_unused;
> +	struct inode		*inode;
>  	struct svc_fh		fh;
>  	int			err;
>  	struct nfsd_net		*nn = net_generic(net, nfsd_net_id);


-- 
Chuck Lever

