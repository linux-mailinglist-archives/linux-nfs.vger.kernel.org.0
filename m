Return-Path: <linux-nfs+bounces-14764-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2E3BA9478
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 15:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96DD73A9EF4
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 13:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2192D592C;
	Mon, 29 Sep 2025 13:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Koe7DBNB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="znH896zD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C241D5CC7
	for <linux-nfs@vger.kernel.org>; Mon, 29 Sep 2025 13:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759151132; cv=fail; b=eBI2m3jYwm+45UB0Uq9oRohTRpg7oiyw3+AQKVQlYvMX6GXjs+v8YSgdVRvXAFdVUgxXkTw3jeOSFgt4eG55FzHhPpiWcCehi3Rh2akIWrcUDR/O/6mcpGxOW7564Xv1xv5pzPMtvFlHIP9GRF99ktGXQdMjYBTpCVhHH+NBZZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759151132; c=relaxed/simple;
	bh=60q9Zgmfr0bz1XqaPBUGRfznin6ZyM/eyuuCvZqrOMA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tXfW6RzsCFjkoNeICoq7Zg/+jwhuff06uFa2tL4m48xjR2A5Gle8MPGy5bXGYRn8nSoBfQNEUEUTdI1c/8a/lI4CJTkAniqQnT/BQOldN6GAlVpBw3iATla6rs3T5uUfYmIz4Yy0uk7aaf0pZBlEi9adNhmAk4F+Wr2wSTjM+aA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Koe7DBNB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=znH896zD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TCXuZx026601;
	Mon, 29 Sep 2025 13:05:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=s0vxKnqpqSsX5E9uxjV6pjAaE063CeoTZHgArsC8dTA=; b=
	Koe7DBNBkmfjy7fC3zInkdtRF2lh/ZHxeCT3M5QkPXCt0b822ed++5gVd1+ABcO9
	fv1i3obXIPuP3yaUGv4XPNWgt2WEpIuADCvcQQYESwzh/ILXXFn0nt95UScbOgzP
	83Z44aM8eiqx5J5hhcDRTExpvI05V8+48AqelLfYS7AvVXNai24KAVPALkUVMWCe
	cjTNotE6BNrrQgRJq3f5ien4JPE1QKMxSrc0WfyzQnHRPFfbIs5l6loX7+kpa76T
	qVJZVzu64Rf4Xal9LseS+gsRYg91sUf9tEc09VtaJrwNpUzNdOiznt7mAdWW3RL4
	cNRD/JURlWcJCjvWIxDUeg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49ft7cr22a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Sep 2025 13:05:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58TCl71j011585;
	Mon, 29 Sep 2025 13:05:20 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013018.outbound.protection.outlook.com [40.107.201.18])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49e6c6wvsg-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Sep 2025 13:05:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qo9cvfIW5h8pabZ6umuKSaW7IKY4XO5OmmFD66DgauBl1YsjHFIQdNeOvHUkkNvMjLXC1WyGgfGrSnmz92jnJYupLv0FBdHzeAWxFMAL0dh0UjslX680xxXfu+Lv4F81tDM6s0Ej6px1XbvDg0yMq58u5LaBNTIMTI55c3sfOLhBXnUlXLUt0bXlWcT5JkutvctgFKFGPy29fEEAFSnklfcnHmddeoG9zFs5rAV55StPc+F2Pv79b8T+uz3K+DKOpFxTfdxkLG0++lYusRVaHLHALYFPcbLF8QKmbHrY4FFQh17ntz6HqwtbjKKuQ7dwndehj0vJznZVQLOGcVZKXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0vxKnqpqSsX5E9uxjV6pjAaE063CeoTZHgArsC8dTA=;
 b=Uo98RSxvdcMM7DnyjxhZXSVRfb54BsOLqiaLbVu4arR0wjty7MiPqVr8oYx6Ke8zSEaM8+qpbKDOO+qsW4fMzYqw5EQeRDRYXu3QHZxOctib37Ds/Rbjf4uiW9B/XrjfgN6ikCAQDF+cIwjHMEkJZKdz9EbYLVy6oTyoDvVFh477t802q/Dm0RLtz4HYXRY1MsAyHddgkMXfwAOIbCFhVumwWW3H+MGBqkvBIeVnKkzLgYGmPvq3Y5p6ONSupYLHinzgd3MMgq5FROK+UELMGgDOhMGDlEBFHfhfQ8k66EdBAtL+ALLq04YzpKPs0qP3pdHoav2EGpMY9jFHj3Sa+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0vxKnqpqSsX5E9uxjV6pjAaE063CeoTZHgArsC8dTA=;
 b=znH896zD31gBAWxywN0NCmT59ZFvz8Yzf39tyHB++lS1xiZIwe8gJpeuMG/ltjwvApnIlLrjFq4YKUlJRNJy1x7QlpStWPtQ2zXd15qoavTKWMOAGkZRY8WZtQDSHa3WCujy7C7BY7mgsnM5jh9dduf0avTFlYpaf9VZ+4qT7GA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM3PPF3F503E3E3.namprd10.prod.outlook.com (2603:10b6:f:fc00::c21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Mon, 29 Sep
 2025 13:05:17 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9160.014; Mon, 29 Sep 2025
 13:05:17 +0000
Message-ID: <4614aeaa-f366-4b53-afb4-ae6747589d05@oracle.com>
Date: Mon, 29 Sep 2025 09:05:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nfsd: Avoid strlen conflict in
 nfsd4_encode_components_esc()
To: NeilBrown <neil@brown.name>, Nathan Chancellor <nathan@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <anna.schumaker@oracle.com>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Simon Horman <horms@kernel.org>,
        linux-nfs@vger.kernel.org, patches@lists.linux.dev
References: <20250928-nfsd-fix-trace-printk-strlen-error-v2-1-108def6ff41c@kernel.org>
 <175910219642.1696783.1969092567455681202@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <175910219642.1696783.1969092567455681202@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0029.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::7) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM3PPF3F503E3E3:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e68e485-c09b-42df-e05f-08ddff58d621
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?YUt5NlU3Ymw0dDlWbzNlZkExdWxnVWM2SjBydmRWMXFJUXVxcS91VXBqOUtH?=
 =?utf-8?B?Z3k0dXlYWW14MXBPS3M0VjJaRDl4YjVQU2R3aWVPTjZXUVp1b0h3dS9zV3ln?=
 =?utf-8?B?WWhCU0U2Y2pEN2QxRkh2ZEY5bnJBR00yMXdOQ3cvOEVFSVVPMkpXWEJnT2NK?=
 =?utf-8?B?VDE5Y1VVTzYvNFdDbHpTWFl6T1dBcnZoZHNRMUpMeXdMckI3VCs1YWV0UkNp?=
 =?utf-8?B?U3J4cUhWZWdXWGhUdW9QNFM1QU5aTGZFSWVRUDFPeTlINnJpT0tGRWpJdlZZ?=
 =?utf-8?B?VklYR2xrK29ENFNVZGVCT1pTRWRsY0lLMXdZbzk5czdoQ3NMZHM1NDZRRGYw?=
 =?utf-8?B?UzM4cG9YckJ6TzU5L1I1Q25RdFhDMVdRTzhBYnYrck5MaU9URW1UNW1GQnRB?=
 =?utf-8?B?MWNZNVZCR3MxUlVJdFVpTnBSS08rbVVuYXNPZzE3S2VvOEJSb1BXWlRvK1ds?=
 =?utf-8?B?eWtFVFRNL04vN2pMZG5MMmhvL1BZcDR3Umh3RkRKNXpVejlrT3R3VGRMMlRM?=
 =?utf-8?B?UjQzSFlTVXg1a1U2aDZaaGZtRHZhOHFsQXkrcFQxUDZDa2t1dFpmbFljNFlU?=
 =?utf-8?B?K3llR0dFQVpUcm1uYUxmYzZkWFNEY2J5SlVhWFpNeFFSVzdweTN5enVRcDNT?=
 =?utf-8?B?aGFsRnRhSXhlTUV6OHdlYmxqWTFWdVZyYzluNGM0OXFicG10emlGUFI5WWd6?=
 =?utf-8?B?RlBUNzRzdUZrNVFNaDE5ZkdvMGkwdDNBTWRoOHc5L2RjcDFiSUE4RXEyalRk?=
 =?utf-8?B?Z04xUUNqMDBBSEkrM1B2ajhJN3FkNDFlR1FjK0dHSVYremlpQ052azdZZDY2?=
 =?utf-8?B?aUN3d2FTYXNsbG51NlZHQ3lZVnpGODJmaWh1R2ZsL2dwYmdHajd6c05STmRk?=
 =?utf-8?B?MXZ5cC93ZjhibjF2ZytJMm1mNmlDWUFQV0FZaGJWNE0xMmFnM3dMS2pRbVJl?=
 =?utf-8?B?OFZETGU5YmwvRjNOSEJQa1BuNk0vcmlSVmhlUU8vYjY3YlhlZkhjNXJwRkRH?=
 =?utf-8?B?SkQzSHZsY1RSaGdLUTlUQS93VzRqSk9NQTF1aVdrTVcxc013TndadTNiS0RG?=
 =?utf-8?B?Wjc3T1lpcnVvWkpZY0lVTjcwOVpKRTdXcEp1WTMrT3ljNnhVdEhuZUVDVXZw?=
 =?utf-8?B?WHFIQUlIWGNDSlR4YjVLRHg1UlgvRkpsdXZZM2Jvcko2anVUbDYzMHVvbDFq?=
 =?utf-8?B?M0FwUCtWenh1bjlBUGhDQ1J6TUFhYTNRNThMejZ6bEszTWxBTzZERkFaeUNy?=
 =?utf-8?B?aWF2ditlQ1FrU2tuNHMyaUVyOUl5MUs4SnVsTitjaFFBOTdqZDlPVnlFei9r?=
 =?utf-8?B?a0NrejQzeEUydE5HcFlDakYyNTlRbGx5b0RNRmEzYzRUbzZKQ2V2T1JKYmpm?=
 =?utf-8?B?T1c5bEl1eVlEWlJDYVpiamovaUZaa0xzM0NxSFJHS05zd1NLemFMb2R0UHc0?=
 =?utf-8?B?Z1RRdzFXaDE1NDFtTGJpSTNraWh6L0xLeTVvdnFTbXF0ODVqN3lJcGRWM2ZB?=
 =?utf-8?B?UmlDRHEydWFObVErOFFCYXBsY1ArYm9EaE01eEcyYmN2b2lxSFlGcFJZcmtJ?=
 =?utf-8?B?N2MxYmRWbWswMnFDQmVhNVhmRThGYUl3ekFnY2RJd1B2VGdzcXdZMUpNRml4?=
 =?utf-8?B?bm1hbFVPTXlvVWlqOXFmTUUvdGFFYXFqMDRSbDNVZ1EzYWpZQUZQaGNBbVN6?=
 =?utf-8?B?V3U2bUN1aFhlVzhFM2ZWeGNXeldPRmNFTS82MnF4UXNqYUhRYmVyMVBrYnJ5?=
 =?utf-8?B?ZGpXUEc4RFJablY3WVYyWXVNcjRyaGhCM2dIMFk0dzA3Q3RBclhkZnZFZ29l?=
 =?utf-8?B?WGcvOEtESFRZS0RXMmRPR3NlelptZkUvandrcXdWbTN1cW82T1JEYU9kK21V?=
 =?utf-8?B?Z1R0K256OWIrekw3Tm1CYk5kNENGUFRFMEdJclFGdCt6Tmc9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dklvektiNS9mdVJMNXF0SmdBUWgvTUEyRit3SlgrelFQdndNdkU2T0hjZmMx?=
 =?utf-8?B?M3J6ZGR6WEd0ajY4T0tiTVozcm9rYjQydFprYk9PQjBiY1gvczFlRDhuN25x?=
 =?utf-8?B?TnNGd3poV3dRb0t3blJqK1JQRXVxNHVFbG5JSVB2ZGdQVnVQM1FaRWUwRFBL?=
 =?utf-8?B?Nzg3cklWVWhnUkpGdS9wTWc1M1N5c1pyMVpseHFmdU5KNnZRSmNqWjNtN3Nw?=
 =?utf-8?B?TnVkczZqSmg0U1NwL2pMTkdZV294N0VnMXE0RHhkekNJK2R5V3VaUHh6UVdW?=
 =?utf-8?B?MGdQditxeEJSRmk2Z29ITkVtc21rdi9saEFDQVpaZE1zTzVtWjR1eXc1eTRs?=
 =?utf-8?B?dTc1TzZjT0x6MjRGR21tR1QzazdySko2YnRZZTNsVGNUSWNDbWNEZTE3NGxi?=
 =?utf-8?B?c3RCL2RMNk10MldSVDBYaUg4Q3NoVy9hWGdLRmRYdHR2MjNUSEtJOVFhdHNt?=
 =?utf-8?B?eW8zdU1oaUkzSGs0WU9nMGxhMklzWklsaWMrSmNSQzlOM29qL3hjWnpzeE5v?=
 =?utf-8?B?ZVVLS2tWWHV6OU81eFNsN084c21WSUwwaWdNc3dSUGF6K1ZGdnZ1MXhTei9S?=
 =?utf-8?B?U1J2V1Q4N044TXZ1a1dTLzlvN25WbmZhUWdmb2YzV2h5NmFpa0ZxdXg2a3Jp?=
 =?utf-8?B?c1dwdEhkdzRpWitBekNzb3JMa21BODkvUW1kcHFXNkNXdkt3RENCWnA3NzNI?=
 =?utf-8?B?REFsK2V2VVZFVlZFYXVwdlRSb1VQWjFEL2NhUElWRGZLLzdZRk1ENGJIdDl1?=
 =?utf-8?B?ZVIzK0gwZEh1WnNVZnVJY25ZUFNSQXpPMFF0bzA3VWkrNWFDRFV5bXhlNGJK?=
 =?utf-8?B?TW15QVd5RTBEanhXMWUvM1BaR2JGSU45NjJkeHBGZUFaN3YycnNpM0hCay9X?=
 =?utf-8?B?Mko3YVhnRDdBZmQwem5KK24zTlZJWFdqUGphTk5HQVRxbUtJZHl0WnFDbHJs?=
 =?utf-8?B?c2dyaGZsMG5zeENyR1pMTkorZlZrajRBVXFtdDAxcGNJU2MvYmpZb29qeTNL?=
 =?utf-8?B?aTA2bEF6dXhab0NOcjc1aXZJQVM4VlBMSDkvOHFPWElqNXJlcFJmeUpIVkE1?=
 =?utf-8?B?cVFzeWFJMkhNL2g4SWdXSnAzUnhEUHg5OVZBclVISkZ5WlJZM1VmWnlGVUhv?=
 =?utf-8?B?R2NkdWs2dVk5TXJNbU5VYjNvTnFjNWtrN1N2SURJbGduY3hqTEg0VVZvVUEr?=
 =?utf-8?B?SHAvYk84ZC9HSjVCbExsWlhPUGw5R2paVHRqdVIxZy9vRm9WUStzWVRCOUJV?=
 =?utf-8?B?ODBrWFd6VW93a2VHcm5QdmNOQkV6UTVXYlN2KytiQlJRRFlBekVYb3JqakdR?=
 =?utf-8?B?eFNOOFVUcXlDYk5qUWFoMEpvQWVEaTRLbk5QUEJvVE85aU9rN2tpUXVQd2Ji?=
 =?utf-8?B?WjVyeGpzekdqL29JRTBDQXNIL3dueDM3U09pS0RPTmxpZlIxOWF1eXVnT0sz?=
 =?utf-8?B?UFdzVzJ5MCtyTmlMVHkvOVVFQWRJYVVWMUdjUzJTYXVZWGdkOVVUaWZSTnlr?=
 =?utf-8?B?QU1ETnJCZi9PSWo3Q3VZZWxmTkpZa0JLV2puUG5vcDNlaEMxU3Bick1qVlVL?=
 =?utf-8?B?NldMVHpoZVEzYnJYRkg1S0ZiaUp0SWFtU2dmVFpobDV5UXRIaE4wS3M5WUhj?=
 =?utf-8?B?SVJMZjFPOXpXQTZyeUVNb3RMRUdDdFF3MEJHcXdIMzBLMktkclRoOUlZc0h1?=
 =?utf-8?B?aUdkWTBWZmRLWDFqQVd4RTYwSUxzZCtNTnByaVhxK1RjMU9mbmR0bnpLOStN?=
 =?utf-8?B?QW9aWktLREZZK01IUXVTd285c2IzVjNhU0s3YkcwbkVjeisxWnBGZFpJQmZ5?=
 =?utf-8?B?Yllwb0dGOTJkNkJBbEVES1dJcEc4TVJKb2JZRnNsV29IeXlmeS82OTJmS29N?=
 =?utf-8?B?S2lmZi9BRFVjRkpXY1NnbW1CUm5Ba01CaWsyaWE1enVJaTFhMVdSZmlMWSta?=
 =?utf-8?B?eCtFdCtnZFhCMzJScWdDUDJ0MER4d05kZklGT01KOGdPckdyb0JSdlU0cE5m?=
 =?utf-8?B?T1ArYlR0clg0d1JwZHVTb3dIN2VRWXFBL1RWc2VtN3RVc242dzZwWG44MXg5?=
 =?utf-8?B?dERORS93U1hzeXVKY2NLcFBydWlaR2kxVHhORkxsRWF6Z1RKeFV4d1dvanJv?=
 =?utf-8?B?a28xOXpLZEtMbE1taGkvRzFSa2hxNUdRUU1GeTBoQ05DMVNIZlE2K1J6UGho?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jX4yWDltmEgRd9p7lT6l6jFzhrgY1SFp2/bwVmFNM53/w3Kb3P11nG8/rYYoTkGLpS4Ww/wo7ZOxysyVxOUDwLg1UO9ouxv4MvL6XMvR1n/TXYYHqCJdB7lG8jrEqGZzaTxHtu+ECEJSD9WBUgQ3RIWv411xtgeEQqKrbbCHNt+jTLByqTIXDe5/xp7jF0+yw04LtBbGqexoJH/Y/V+IIfr200SCHVUcPrib6oHaBlR5EH4YEOnL+v7glh8PrTEklUmBwpIKvN4vN2c6ZlRyxYnBxqSz8snaWpM3KF86XhaAgXWOJAZXdTp6vRiVsvXjviAw+nld5hX6GopOAfjUgJ5agLmteKoz6UQdB+9yqX0PoEXGweAPDwIBH0ItfvuA+hXhCx/C6/n2P7/bhSMSdijJ0BqbJC04NPkdIR6ruqUeJi/RAVaN5WzNxGOQsg1xGwKx7EwQHQMYuhoCahyd351FVxAVctjqNvs+nft81OcHi76IAYWvPO/zPOhuA6iUbE5u0oHfzjYRsI1PWyOxwGvw0rc3kEpP4IjLbdwr9Y4kGGY9rWVqq8aNKYP4ej6EXLKpp+snT1XQxjLntXZ3Qpk+l+NG4b15/O4GEszPTek=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e68e485-c09b-42df-e05f-08ddff58d621
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 13:05:17.2648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WxPURoM0YeIZmRKVdU2q6+CQ2oPS4ZkqWCP7HbTTGcE0DOYNU6jVZIgWFXW7HxzGuC/FHj4w6Ie+NzUexiKfRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF3F503E3E3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_04,2025-09-29_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509290125
X-Authority-Analysis: v=2.4 cv=cruWUl4i c=1 sm=1 tr=0 ts=68da8411 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=bC-a23v3AAAA:8 a=VwQbUJbxAAAA:8
 a=tsiXka2cBcb_6nLmPHsA:9 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22 cc=ntf
 awl=host:13622
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDEyMSBTYWx0ZWRfX65zk0HtUnhVj
 5TAqo9TsodyRPu0IdhcymtZ6ZK1zn4xPEWOnjKRrIggsfFe/WjyEIbqBH1YK09T8V7qP+qN8U2N
 d5Z764bGT5xF3Qbh4Xf+CYuqosZAqrQ2eq/rk3Otm47z5zGXBgFVTCPtTtAip7EHr7Z655pFmam
 aZgzrvEB4s29HJpA0dp66yw6St6zARrASMlSAzRU6gMGsq8oxh+TMTH/mNypid6/pyJoiX0Nklc
 RzyKfITkCWEamWYzaI6OvVohelQUDzfjoA1oJ9lygqDJrGOGJ/TcOKzbIPjboZUjbdH428N9HQ5
 7klACGvn/cO4pxGw0QS4bRcgROFrjJGLZmD+z66MWct1JYZZlyenVEFu20txq4+U1IRWwIfqtEk
 SlK7PMY24t6dEpOYsVzYuS//tz4ci/7sKtK3dAnPE1Mv912kmVA=
X-Proofpoint-GUID: BJrE0ueHMLxAhKCbEYoHkRnsRqLyElbG
X-Proofpoint-ORIG-GUID: BJrE0ueHMLxAhKCbEYoHkRnsRqLyElbG

On 9/28/25 4:29 PM, NeilBrown wrote:
> On Mon, 29 Sep 2025, Nathan Chancellor wrote:
>> There is an error building nfs4xdr.c with CONFIG_SUNRPC_DEBUG_TRACE=y
>> and CONFIG_FORTIFY_SOURCE=n due to the local variable strlen conflicting
>> with the function strlen():
>>
>>   In file included from include/linux/cpumask.h:11,
>>                    from arch/x86/include/asm/paravirt.h:21,
>>                    from arch/x86/include/asm/irqflags.h:102,
>>                    from include/linux/irqflags.h:18,
>>                    from include/linux/spinlock.h:59,
>>                    from include/linux/mmzone.h:8,
>>                    from include/linux/gfp.h:7,
>>                    from include/linux/slab.h:16,
>>                    from fs/nfsd/nfs4xdr.c:37:
>>   fs/nfsd/nfs4xdr.c: In function 'nfsd4_encode_components_esc':
>>   include/linux/kernel.h:321:46: error: called object 'strlen' is not a function or function pointer
>>     321 |                 __trace_puts(_THIS_IP_, str, strlen(str));              \
>>         |                                              ^~~~~~
>>   include/linux/kernel.h:265:17: note: in expansion of macro 'trace_puts'
>>     265 |                 trace_puts(fmt);                        \
>>         |                 ^~~~~~~~~~
>>   include/linux/sunrpc/debug.h:34:41: note: in expansion of macro 'trace_printk'
>>      34 | #  define __sunrpc_printk(fmt, ...)     trace_printk(fmt, ##__VA_ARGS__)
>>         |                                         ^~~~~~~~~~~~
>>   include/linux/sunrpc/debug.h:42:17: note: in expansion of macro '__sunrpc_printk'
>>      42 |                 __sunrpc_printk(fmt, ##__VA_ARGS__);                    \
>>         |                 ^~~~~~~~~~~~~~~
>>   include/linux/sunrpc/debug.h:25:9: note: in expansion of macro 'dfprintk'
>>      25 |         dfprintk(FACILITY, fmt, ##__VA_ARGS__)
>>         |         ^~~~~~~~
>>   fs/nfsd/nfs4xdr.c:2646:9: note: in expansion of macro 'dprintk'
>>    2646 |         dprintk("nfsd4_encode_components(%s)\n", components);
>>         |         ^~~~~~~
>>   fs/nfsd/nfs4xdr.c:2643:13: note: declared here
>>    2643 |         int strlen, count=0;
>>         |             ^~~~~~
>>
>> This dprintk() instance is not particularly useful, so just remove it
>> altogether.
>>
>> At the same time, rename the strlen local variable to avoid any
>> potential conflicts with strlen().
>>
>> Fixes: ec7d8e68ef0e ("sunrpc: add a Kconfig option to redirect dfprintk() output to trace buffer")
>> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>> ---
>> Changes in v2:
>> - Remove dprintk() to remove usage of strlen()
>> - Rename local strlen variable to avoid potential conflict in the future
>> - Link to v1: https://patch.msgid.link/20250925-nfsd-fix-trace-printk-strlen-error-v1-1-1360530e4c6b@kernel.org
>> ---
>>  fs/nfsd/nfs4xdr.c | 10 ++++------
>>  1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>> index ea91bad4eee2..9fe8a413f688 100644
>> --- a/fs/nfsd/nfs4xdr.c
>> +++ b/fs/nfsd/nfs4xdr.c
>> @@ -2640,11 +2640,9 @@ static __be32 nfsd4_encode_components_esc(struct xdr_stream *xdr, char sep,
>>  	__be32 *p;
>>  	__be32 pathlen;
>>  	int pathlen_offset;
>> -	int strlen, count=0;
>> +	int str_len, count=0;
>>  	char *str, *end, *next;
>>  
>> -	dprintk("nfsd4_encode_components(%s)\n", components);
>> -
>>  	pathlen_offset = xdr->buf->len;
>>  	p = xdr_reserve_space(xdr, 4);
>>  	if (!p)
>> @@ -2670,9 +2668,9 @@ static __be32 nfsd4_encode_components_esc(struct xdr_stream *xdr, char sep,
>>  			for (; *end && (*end != sep); end++)
>>  				/* find sep or end of string */;
>>  
>> -		strlen = end - str;
>> -		if (strlen) {
>> -			if (xdr_stream_encode_opaque(xdr, str, strlen) < 0)
>> +		str_len = end - str;
>> +		if (str_len) {
>> +			if (xdr_stream_encode_opaque(xdr, str, str_len) < 0)
>>  				return nfserr_resource;
> 
> I probably should have said something earlier, and this is definitely
> bike-shedding material, but .... "str_len" is not a whole lot nicer than
> "strlen" (or "i") ...
> 
> 
>    if (end > str) {
> 	if (xdr_stream_encode_opaque(xdr, str, end - str) < 0)
> 
> ??

"len" is actually the typical variable name used in such cases. But I
didn't want to bug Nathan for a resend.


-- 
Chuck Lever

