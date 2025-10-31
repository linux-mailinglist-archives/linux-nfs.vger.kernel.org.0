Return-Path: <linux-nfs+bounces-15838-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4DBC252CA
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 14:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 41AEB4F48F9
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 13:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162A0347BB7;
	Fri, 31 Oct 2025 13:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LOTrFVcg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tzb1mGkY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB6A3451D1
	for <linux-nfs@vger.kernel.org>; Fri, 31 Oct 2025 13:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915655; cv=fail; b=o8/IHqK1GKNKESQKErj5la2Azpos1JcJdrAVafDXgWYZmbZRHtykz3gaz8svnmBy9eVBxS/hOYtUyBNAAme3gYLodtHx6kgM+u6ALudDGzzAd5AaZcmwKw+Ws70UYuUjBCbc4UodmRa1bLUi7LaCppdTfXmT0tVTuu5D3dmze5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915655; c=relaxed/simple;
	bh=ICrnHqdqD80oVGb/Dn0ThZapXGNyfY4sXowuu6KNXl8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Itbd/N9Tr4coB2fpd0yOMcKULPe9uUXZCvTYrqS+54966dnI1gvToar1gtITDaHdG0p6n5hfth3Da8eCBxQtvDf8ezCx8hznTeDMGt+h600j4r1aLtmp1DVcFTDJVlH0SjMX5XL48P/B1O8zE3dlmP/JzAK3FZdP8Y0FUxVHKks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LOTrFVcg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tzb1mGkY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59VCYSqO014227;
	Fri, 31 Oct 2025 13:00:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=38rs0cKknAv7cqG/0WJRhM1MVBsjocbTxDmzD0NM5vg=; b=
	LOTrFVcgPsJSzSDztid9C4cs0G29GrGDmDiPMYsN7l9X7gXrDCHvJZ+RBM4FNTwn
	16v3TYjV2W5aG86FOG+UlyiOpRCYOXgiNuHqEG6JoOAQibzBB0qLkLVkGLsLwYjR
	flSgDhQSzkpEysWcOJo9aGsryEy1AawcWsnEn4/nQn65BY2Sto7enQ75VcPxFjIB
	ptbho4JhkJiLen2t6xuZfZD9zw1nmnivNyldCs1/JqPrqJZcBHq2SF0Mq8QxJgO5
	DPNeP4wpvBV2gQHM5mxyB+HVcQXqmwHhiiDCGiO+FQBq9c/qls3mLnk5ksYDCuah
	O5ib1YdYMyn+DyyLy/wJ4A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a4w8081sn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Oct 2025 13:00:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59VAVmb6004205;
	Fri, 31 Oct 2025 13:00:42 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010022.outbound.protection.outlook.com [52.101.46.22])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a33wnysg7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Oct 2025 13:00:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aWAUKOkFX3U1iE+t4hxdeX9TpX8Y1DWdWbYzl2oIyrLMzkS35Olrv896fDDxwfd2HFljn0T0aC+n/LRooHPV6d7v6/y3LKJJ7KICGNV/mXO5sW8UGokgtKPmEy8ubBmL7D1bT9fwLikFLXaFbWaW589iO5DyJO/EG9/Jou3EvQbUxIYsyzrBpE4ADNvHmpLf7j0LSKo6eJQOZT/Wwt8eTcU5bvd3RNCgmNb8idZPWYlfJ+wXYdvOUd3hI4tqjKHmk+SRcLAQQovpg3LSzJy5cLRqBdNVVdNs7qI+n/IFT6qPWUiqy/WLj295IM/lO5+I2VHeYC82HOWCoz/JzTmvhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38rs0cKknAv7cqG/0WJRhM1MVBsjocbTxDmzD0NM5vg=;
 b=Hffcu4FP3nSXoaag/rYZNsaH+DCwj4+lIe/q5SD8GX9KYt37N8o/R0/qRv8uEo+5t9UIU5YGrPigxyHWEplax5S0DttAmqT0MMQ+cc0is5MH1Y+Fn5GhxOTVFmgBlkY1gvFsAk4dsL81kOYxR6k/Xvjx38+IXENVtEpwKe8KrLmIUOaiBrKclkgMEQYxZtL9H/ymTOIE77BZgJ2Cl5KA79yZ3Zcjb67U+Z/Ov1QoWdYRWlBYfUKFTBB5Fzm0zpfqjNL/IokivHm5eZamnJwMca1rRplo0tbgf1WqbtaEryowf+7p4dB7E2Zy0tHkHj012pJ4/gCkfMP5Sgc1laAMiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38rs0cKknAv7cqG/0WJRhM1MVBsjocbTxDmzD0NM5vg=;
 b=tzb1mGkYZQI5T099mPoxCk0aYrAY+2ptFdLheqohEooVGyuwitbjFWPdvJ9/Fe8sMwenT6NnxoE74wEsJXbzrLn/KG9C4IV2rIq/J4Fp8O2veR1vLPYd7tbiEeR9vfShqVnA4NUGUN4QYwePnIaeAsstIJWZJqlcY1FMDHX04Vo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6486.namprd10.prod.outlook.com (2603:10b6:303:213::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.15; Fri, 31 Oct
 2025 13:00:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9253.017; Fri, 31 Oct 2025
 13:00:36 +0000
Message-ID: <5a832485-1107-474d-b456-8a041f9c7189@oracle.com>
Date: Fri, 31 Oct 2025 09:00:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] nfsd: drop explicit tests for special stateids
 which would be invalid.
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <20251031032524.2141840-1-neilb@ownmail.net>
 <20251031032524.2141840-2-neilb@ownmail.net>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251031032524.2141840-2-neilb@ownmail.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0016.namprd18.prod.outlook.com
 (2603:10b6:610:4f::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW4PR10MB6486:EE_
X-MS-Office365-Filtering-Correlation-Id: ac595e67-6f90-40b8-4881-08de187d7c26
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SG1rOVRVZVpUekt2TjlTUmNlWDBDN2F4OFpmaktZMzdYSVM3T1hQWWxRS1Zn?=
 =?utf-8?B?cWQvbGxLcHRvaE9nMTBTb0xoZGtNUDFIc1FodVhJZ3ZHTlFqb3ZzK21rM3VD?=
 =?utf-8?B?TlRDRWxKdVBiMGJlZ2c0ODNKZTd6MWpZUXRDeGIrWU1rQVk2amI4NjV2ZEdv?=
 =?utf-8?B?bStkRlhncUhUVkh3L1NCZm0yMGxqaHF4UkYrS21odTVmbEtsbVRYaWxWQzU1?=
 =?utf-8?B?bWJNY3VtbWR4Y0VERmhUb1YrUkNpcUpVMzVKWW9zU1NHQytkQVF0RHBQc3hh?=
 =?utf-8?B?bXUxZ0ZzSldpVEs2bVBycGdVdFVWdm5PU3UzeUVKOExpSmZYN1NRbldDUzQ5?=
 =?utf-8?B?a0syUVZ2Q0JwampkTGVuYkNyM2tGYnV5M1FzWWJLaFF2bldWNzVtZ3JPb2Z4?=
 =?utf-8?B?YUhFb3FVeVRySWZPSEhuMkg0YmVDVkRKaCtzb2Vnb1NjdUxtNFJnMlk3Vmh6?=
 =?utf-8?B?VmxJVFV2VU4xZlJmM1o3KytwYTFaM1grbjdsLzNLMUNiYUFHNkMxSHJDYzE2?=
 =?utf-8?B?QkdxMXJiUVdlS254LzNOMTlZNlRwOWQwT2dtZ0NKc1VOaEJnaFFoWnVUY01h?=
 =?utf-8?B?cWhNN0U2ZGJJeVRUWDNINUVpa2d3UHZzcVBVaDBac01vajZlQmhnV0J2L3E0?=
 =?utf-8?B?QUtrTFRnTjE1Q1dzUVhqWXZFaFNRU0d4MzhxN3E4UTNON2Q2ZmJYbnIwWFlU?=
 =?utf-8?B?QVFwZmRqaUFSd3lJTzRqc0U1Zk13MEFWSytCNk9ScVFpNzlRbnA2SzVpMU50?=
 =?utf-8?B?ekR1bE9jVzZKaWdJNVU2b0ljZ1UrYUE0azRsNXkvOWJEdE5NUFBtYjVzbUpm?=
 =?utf-8?B?cjc4dENEbWhHa0ZvR1Q2RE9wbXZvd3ZJNU85VFlycnVUNUluVHNvMlB4a0NB?=
 =?utf-8?B?T05ERWs5ZTQ2TUdxSEdCYVQxWHpBUXF2TjVQdG9BbmhWRm1SV3pNa0k4TVBN?=
 =?utf-8?B?eFh3b0tYdXZjWW55ejYwdXBTSTNqU1cyRXpyOWp5ZlQyQ2ZJRnZCcjE3SXdV?=
 =?utf-8?B?SE9WVENXdHJGRk15NlJ2UGhCUEo4b09xL1oyQmw0OVpzMlpnZUNYUXowMmh3?=
 =?utf-8?B?c0kzdDd6Q1Uxb3JTbEsyaFh5dmdDU0FOeUlpUXVJdDVCdWZwYjZEVDBhUHV1?=
 =?utf-8?B?VWZ6NFQxR1ZiUy9SWjBCMDFRSGYvUFFjNWo4OUUzMndzZmUvN1BoaWNNZFl5?=
 =?utf-8?B?RWFtSHNvdFNwd2tWeEtUOWpkZUgva3Fhbk5TWVIzN1pXTVM0WHd3eWlIKzRa?=
 =?utf-8?B?MTdPY0NsSmpiN2ZrRHVuRFROQ1JWUkNmVkhNVmExZ1g3MDRXUjhYNGlEd2kx?=
 =?utf-8?B?RzVyRk5SSDhaenJBK2JlekY3aHVyTUpnV08wVmhUZ0dXeEdXUDZ1MEpMSVhn?=
 =?utf-8?B?SmJPRTI4OWhwNmwzYStiRlFDZy9JMEtLV1ZqL2pod25Jb3J3c3dRT05CbFU1?=
 =?utf-8?B?L094TDR2Z2NkbFZncUg0WVdVcTBzaDg1Nk9iY0xTWGllUnlaeGZhZkRBeUE0?=
 =?utf-8?B?NlJkYUpzVWxuU21QVVNnUDhxSVZ6eTFORFkwOFJFdmllWHVxZFJoKzZrK0FX?=
 =?utf-8?B?RGdBU2x6b2syeEpQUUdweXRYN2Z0UjU2bCtlRkd2OWlnalhVVlZyYlVCZmti?=
 =?utf-8?B?eFM0R2hremFaU2VTbHZQcS9aWm1ORnlvQlZTdXN4RFVyQmovdnVpL2Z6UGxJ?=
 =?utf-8?B?VXljalU4SlcyL3h3eFpjUW5FSFpyNmcvSTVzaG40V0JFd2U5SlA1NzFNcEd6?=
 =?utf-8?B?eDRsLzVvM3RYZHBSYXk1VmRjZlI3bEsxN1NjTnBubzJqS0ViV0x0Y1F6QkVF?=
 =?utf-8?B?SStpWmxkU0RqYysrZzBCa0Q2UExTUGY0VnNocU0zdGFNSzJoYVFVekFhVnBK?=
 =?utf-8?B?aHJsU1VPbXpsaUp5bTNHWlF3NlhRdDh4MVRmRnl4Y2xrODhWVlA0dFppNmYw?=
 =?utf-8?Q?DPFb83weDexkFDeRViMGHXp1E9N7HLUC?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Skt1YUZtMGM5REN0M2VIM0FvSFgvRmpCdVZRREVTVVg2bEtZK2dhcGE1NlJE?=
 =?utf-8?B?d2JJWUN0aUE5alRxZEFMYWNXemRMaGdSNDJLOWc5YmlKWWgwb0FKV0ZMdWxN?=
 =?utf-8?B?TFkxc3RqV05HQXUyeTBVWEJ6blN6ekpqSVVwYkpjU3p0anp2Wm56cG9kUlhE?=
 =?utf-8?B?bzRKbG9YUm9UK2dHZEhuNG9Qb2d1M1I2ZnBRY1p4T2x5dTNpTnlxclpNbFpJ?=
 =?utf-8?B?aGs3ZG5kTGNTVytZNFg3ck9nTzdzU0NCTmI1eTArbUM5UkhyUzF4Si80b0h2?=
 =?utf-8?B?MlBaQ3ZweEl6Z2VYWGJVRStmbGc1Wmlvak4wL3pia0cxR0s3VTBva0ZoU3hW?=
 =?utf-8?B?ODdHWlhhWHAveHBsdm9GdkdwUDZTVURRSFBjSkdmOFZIL0RTRXcrT3J6dGNF?=
 =?utf-8?B?TnQ0WGtJRlpXQzNTelErTkpYdlBMQVYvZWYyL1BNVlR3cDNaaFExNDJMMUVq?=
 =?utf-8?B?STl2QmZFcndYSkRjQktsYVViVjdycTF6cGlURkZsdWlJNGZVWk01aEVPTkZF?=
 =?utf-8?B?N0cybjVKWHVldjNuQ1YwbDdNV3Z2V1RnNXk2MURhZzdtNWhaZUZTb0JOM29B?=
 =?utf-8?B?ZW5JQzhxTGh2YjlidmxNT0YxemIxQUVEcjlFUW53YitmZExvbXNia0ExaStK?=
 =?utf-8?B?c0dDTER5OW1kZzl6NlUrMlRnbnNMZFlwRnRxZ0tsMUMyU3dGR1JLZ2dtZ2ww?=
 =?utf-8?B?d1YvbUJzTlg4QjRiTTdtMUlaa3U5SnZwZk9BaEhrVks2TTUyUVdSM3BTM1l3?=
 =?utf-8?B?VUNTMXFmYlladkdDQ2xTYjhZOE1YV2grSkdXZ0VtbFJPclRWT3IvRnZPVVpr?=
 =?utf-8?B?YURiU1R1K0FSdVJQeHZuK2taTUoyVW94V08vQWptSGYvL3dnNlUvemRHNHl3?=
 =?utf-8?B?QWxiYVhtbVArSVh0WjN1d3R4V29CelpFTWhEYkhJNVg2bnp2a2MyVktmKzBl?=
 =?utf-8?B?RFRoWTZnYkZIRndLWHZOVWZFTmxFMklaY0lFK3poaVFaVS9rbXIrYTJKNlZm?=
 =?utf-8?B?aWgxTGZTZU1ob2VEOVorUWMyWVhZeFhaMGplYTh0QnR4am9yc0s0cTVHMU85?=
 =?utf-8?B?OU0xeHpzTlpPNStkVW0zU0thQ0c0MHYzSmFML1hEeDhTcGpoN0NGT2kwaTA4?=
 =?utf-8?B?dnplYUMrbU1wRnhzN0ZTU2ZlOWRVaFhhenU4dStRKzY2K1VWckExbytIeDVH?=
 =?utf-8?B?bE81Y3VlUStXR2tHSDhuRUFjVS9yNkQ5QnRlRDZ0V0hjRjVhM1NXdTY2d0tm?=
 =?utf-8?B?Ty9oeTVicW9hWDViUk4zVlUzbkV4QXRsMUZLcE96Y3pWUExQdHcyNmxBaHF4?=
 =?utf-8?B?ZEVkKzdyVmpFQ2VVZi9WSE04RHA0OUdqMDhHRXUwbzBkTjVKd3ZJdVZ0RXZx?=
 =?utf-8?B?Ry83UTJTYUU4TWJxUEZrdm1IdGVCa1B1WEdoQWY4dWx4eWdRTGg5dVdSenNm?=
 =?utf-8?B?UzJnanEwVUUxZEsxeUROaTBITjFheTVLNGpWSXNZYnNjOUd4bU9vUnRyc1pH?=
 =?utf-8?B?akJmZ2FKYjhmSlV1Y2l1MllwSkliUFNXWHJldHpWK3puems5cTA0T1Y2MmlP?=
 =?utf-8?B?QXUwcGs2b2FxQVJ5SUt6d3VTMUxFQ3cxVnFHUk50eWN0RjJLZjhaeDNBWlla?=
 =?utf-8?B?cCtkTmY4WGRLZGRwOVFMZHVMOHhzRU13dlBwbjRHVU1xaFBJbmtEQmlmQnRm?=
 =?utf-8?B?VXE1bkpzRWZrc3dlNXdEZDBqNHN5QVZQUHdEMXM5YWtwS1FuWE5WZkdOWTdi?=
 =?utf-8?B?a3hYS0Jlb0trZUpqYkRmYUZ1UlJ4V0ZMWW1QcGxBbFI4Ym9IQ2MrTkRTaEZu?=
 =?utf-8?B?eHJ1R0xRYVhzcXNoMTE3TWpkVlNsWUgxdDBPSGxjZVF6SHFRNU55blhoM041?=
 =?utf-8?B?VElTRWI2QzVOUzI3RWhTZm4vdGkwWW1qUStna0pVSmlrWEloUU15Qy9aa2k0?=
 =?utf-8?B?RXd6YzdvQWFjTTZaL01Ua3NQeEtQNEorVjB6L1JrbWUvQUZlY01IWTdjSmo5?=
 =?utf-8?B?OFJDcG1Xc0FZMGlQSldNSmJDYjByRGdoNXgvZ3IvU1N2WVgyZnNqVTJPZG0w?=
 =?utf-8?B?Nk4vRG5IUkJDK3pvZ2dpUFhIQWpFaERkOGNETE9PendzWXRWd0F3RWU0V0RR?=
 =?utf-8?Q?+p1jo6n0wCe6XbyFXQlPElCUy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BULPQim4d14PNIdKlFKTyp6hb8XLvAuG7kow43Sk4gkjEvppuIwqfTSb/Ia1n95o0imtJ7OlwXQRxrrineIhVXIaW2yPLNbhoJsgmxXrTaOVTsbbm+rFfAkiSkrcNJhVaqtI2+hRacfiXVuq1RDVusXMln7YtN1SLc9orvplUGhKdYkeagxk8KsojRDf/hq1OjIMRFMVUVk4IFJfFam5qi0XBhMr3VEPNtiHur9m941bwLYSsL7OnAY/94VhOsf6G2Yt9fl8mWTPR2A1+6prQ4IoZjM5VGqMSR0wt4sWqRKSZQDhJLWar4lEaby/OTOGNwI+yfevSRjpA9j7nD+jCjKDfkQsczi3L385JbqfjEgfsz++iDbmbfMP/u8X54nlpfP6B626qZWCYLZZ29kauxnQIk1GgpGRo1ziYVIq6miTO5Rt+P72TkrGPqNbGnEFYu9K2Qp2+aG2rYCAdQQUB9HJdOWkvp6Oat1sYlEyCpuNziQuaUP4U+z2nXeR03y4wgxhbLBs1ARh9SIKzWja/p/k80CPkUEJpwffD/CgReNojRROMJdeCyIgPCAOUwRj5Z/ORIBRmFOjKpmjlAIZjy0gyAQVC1tpvfbrXlp1DWQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac595e67-6f90-40b8-4881-08de187d7c26
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 13:00:36.8788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GBrkZFK0T+Fwk+Rx0cHToG+tzA3PQzYI6I9ULjro/o7Q6nT25Wm93qTK+uLi/luQ8tSs5hhTGfFlJ+h7TfQG7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6486
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=957 adultscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510310117
X-Authority-Analysis: v=2.4 cv=QKJlhwLL c=1 sm=1 tr=0 ts=6904b2fb cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=hfBrOu83sSYVobIQ28wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3HnWSMvvfLQe4VOmJ4QbtmWVnjzwPCdE
X-Proofpoint-GUID: 3HnWSMvvfLQe4VOmJ4QbtmWVnjzwPCdE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDExMiBTYWx0ZWRfX85CWYXF2lL0G
 3jbIKl9vic9G0lFvHSwVVTyvkuGbiiQz6A49sKZEtPgcUXPu0/fmtcOlgI79ofIGXnQGAuDNPP7
 72Jk/tVv4rW7Y3lkVLu75Peqqi08twIP09PJ5+MdAxqcc7P8tfHIeX0Z6d4ZrAhI4E6yAIyBsa2
 kYC+XXwB6vyjOtFMMVIBg7dtwPXmeJGpW3k7w0ZOtRkfBA5S+mYoz7qzcH4E3UjXAtXT9Hy75sw
 wh73G5IwF9LURM6QKTvHLx7ukDLXQ/AJ0P2uVHhKQkMCo/qfkYK+lezvToWi4wbl2+vKPVHhYPU
 fwCs14O4uYwAASscnHLaGsbv70CJpwwb8uUgFT0e4/99H0U6FmdL3Gp/G0buQ2VWaEx1wSxXWag
 GhKV6T0ZjYmbYbPOXmPumlgKzLIyGQ==

On 10/30/25 11:16 PM, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> In two places nfsd has code to test for special stateids and to report
> nfserr_bad_stateid if they are found.
> One is for handling TEST_STATEID ops which always forbid these stateids,
> and one is for all other places that a stateid is used, and the code is
> *after* any checks for special stateids which might be permitted.
> 
> These tests add no value.  In each each there is a subsequent lookup for
> the stateid which will return the same error code if the stateid is not
> found, and special stateids never will be found.
> 
> Special stateid have a si.opaque.so_id which is either 0 or UINT_MAX.
> Stateids stored in the idr only have so_id ranging from 1 or INT_MAX.
> So there is no possibility of a special stateid being found.
> 
> Having the explicit test optimised the unexpected case where a special
> stateid is incorrectly given, and add unnecessary comparisons to the
> common case of a non-special stateid being given.
> 
> In nfsd4_lookup_stateid(), simply removing the test would mean that
> a special stateid could result in the incorrect nfserr_stale_stateid
> error, as the validity of so_clid is checked before so_id.  So we
> add extra checks to only return nfserr_stale_stateid if the stateid
> looks like it might have been locally generated - so_id not
> all zeroes or all ones.
> 
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/nfsd/nfs4state.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 35004568d43e..83f8e8b40f34 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -7129,9 +7129,6 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
>  	struct nfs4_stid *s;
>  	__be32 status = nfserr_bad_stateid;
>  
> -	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
> -		CLOSE_STATEID(stateid))
> -		return status;
>  	spin_lock(&cl->cl_lock);
>  	s = find_stateid_locked(cl, stateid);
>  	if (!s)
> @@ -7186,13 +7183,16 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
>  
>  	statusmask |= SC_STATUS_ADMIN_REVOKED | SC_STATUS_FREEABLE;
>  
> -	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
> -		CLOSE_STATEID(stateid))
> -		return nfserr_bad_stateid;
>  	status = set_client(&stateid->si_opaque.so_clid, cstate, nn);
>  	if (status == nfserr_stale_clientid) {
>  		if (cstate->session)
>  			return nfserr_bad_stateid;
> +		if (stateid->si_opaque.so_id + 1 <= 1)
> +			/* so_id is zeroes or ones so most likely a
> +			 * special stateid, certainly not one locally
> +			 * generated.
> +			 */
> +			return nfserr_bad_stateid;

I think this is checking for ZERO_STATEID or ONE_STATEID, but I'm
not clever enough to be sure? It would be more self-documenting
if this explicitly checked for both instead.


>  		return nfserr_stale_stateid;
>  	}
>  	if (status)


-- 
Chuck Lever

