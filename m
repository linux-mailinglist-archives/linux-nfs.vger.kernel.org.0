Return-Path: <linux-nfs+bounces-13909-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24184B384D2
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Aug 2025 16:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17E5E1899CFA
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Aug 2025 14:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60302BDC28;
	Wed, 27 Aug 2025 14:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="egRQMpb5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Xdl1ZK3W"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8593E78F29
	for <linux-nfs@vger.kernel.org>; Wed, 27 Aug 2025 14:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756304481; cv=fail; b=s0JMRrEYE2p58crkOvDa0qfNTJJ9l5mIz8RjLjoOVlusATrmLvRTZ5ZG3oQLJtoo6yN1g4WMYp/mBc0yz65GWoSaM0ceuVQECTeYq5QoUg4rrt0WJg+1VUTBnqNmB1X2+iDRbv6l4Z7Pb/46Ir9r3UDK/zrKRgot0hkuxK+/ktY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756304481; c=relaxed/simple;
	bh=jNc3xn6bcbtMhxukUlT1yBAgMS8iFPXcrTb1bBKnrTk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tE0Y4Hyxn6i4WqbIWTQvZWNnQ08hw6yqziUR76yatQlCDtxwo6yLeqoEc4MHBRauZHLtM1FY2+ZwKDTjSTknziC01KQCMGykJZ6YFB++w82mbQ5FRhu+T87y6U5V3bwC5UNG8sTssp1KTJSgzzgOnGVadUDlQEGFzYLa5crY1FQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=egRQMpb5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Xdl1ZK3W; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57R7twVl001220;
	Wed, 27 Aug 2025 14:21:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=P/akQjz99HiqB3K2Bzcho5ggv4YchLC4J2cadLpvsas=; b=
	egRQMpb5B95NGwJ8YeGTWRuWRtFzYBH1bDr1xnuOaPUaq+0RIs1XviH9YIlrUfDk
	qRmLsK5Dj3kA6LSNO+429BfiDKQ4M7Y2qp4GBTWLERlWrha9VX/Pjude2GRwpzZm
	nGizzi5t0eQ21CZAwBs8JQdobANQ+N6cWjih/otRvZzbcn4ziuHSSAbY5BEyM5Rl
	c+corI+xWXOpLdUfk2ZeAcoljcyi/LDrFTComx8pco5DQKpBNvn8oyuhbGeZRYgR
	60F4V1wvqyeXl/3G+nghUhYb9rhLwiI6vckAwhOE63yWreG+fRkHlQFekVsc5lRU
	WyTxvhljmFY0I302g5pjBQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q4e26n0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 14:21:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57RDkMtZ026697;
	Wed, 27 Aug 2025 14:21:13 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43amgb3-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 14:21:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WvigECR0dHttUuPkXJ2AurOTWPDOVf/vVbycN0JMogxNWVunayU1s8TwDN/KLVDdn+Ic6jDEb+XINwjmkGISs/ZvsDty0M8NaGFLxdqm/Oqg9BuFSyzzFhamkKuYMmWT5NDiU+SCKptOazRMqOOj9MpSO8Ylt154BdGmKCbz0ebSX4J2ZD8KPWW28LZqeKqmMQkNdON29S2HHO/wru9uzVQKjjQ3ds83EBKAK+UleJ692V3YTlOZFCv2ffjNAvLQh/Y3o62Ys5c3WlvHOl2iIiiYxeh86ee7YTrshFvLKJssMBXy1aFyG7b8uc4Tn8fG4XnobKA4dG/M/ohrW1/3AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/akQjz99HiqB3K2Bzcho5ggv4YchLC4J2cadLpvsas=;
 b=uLrG576bSGJNELu+HdfT02GW384QDOTeeoD1ZIn36VRjotNkI2/OzZFw6MC9G1AmEo372dkAdeeufkMfLyi1+JosG0WcF4Pvkkj8ICVdmtA9G60pbi+JFRQHcPgu609Ry8xxh030vWIJR8fyBaEarkr3U7W/njkOW3nmjeF+n1JApk92Ig84gm9NRFbxPnUx3shfwInJiyqvlal8N5Qm6rl0M59Cu17s6+gQODhrgYthdHJ/GCFG4mMfTJnsv9AmKq4ykiksSpmnIee+w+bWzlqFheuqSm5e3S7iVG+wFlhINw+lA3R4okQXIZYTUp5BxeTjXkmBZX6mV6Bxcy4uCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/akQjz99HiqB3K2Bzcho5ggv4YchLC4J2cadLpvsas=;
 b=Xdl1ZK3W5e+YRE3A9AHtdzXMwUGIt4O18br96qXi72x8DzNdKoGTjw0hV+1w8Ac4pXP43l+jPB858lRFL5XSIJhTZSMC93+hFOQ1ObDus2HfiSuA9PziqBo9fBWk/U2AQdVAHzdmbgPI+BGS/u46icbtFEAC8Ft81uIdM2+g6kw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5756.namprd10.prod.outlook.com (2603:10b6:510:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 27 Aug
 2025 14:21:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 14:21:08 +0000
Message-ID: <41502e2f-0d97-48a3-876f-62c33ae6d657@oracle.com>
Date: Wed, 27 Aug 2025 10:21:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] nfsd: rework how a listener is removed
To: Olga Kornievskaia <okorniev@redhat.com>, jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org, neil@brown.name, Dai.Ngo@oracle.com,
        tom@talpey.com
References: <20250826220001.8235-1-okorniev@redhat.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250826220001.8235-1-okorniev@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P220CA0025.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f7586e8-4efb-4340-8482-08dde574f753
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?TDgwL3hkREdNMm1kdDh6UG40OVR4SXRQdTBSZlpHNGt4M1dWOHQwN3B6LzZs?=
 =?utf-8?B?d1RPdVQ1eHdrbUVyN2t0NHNDTVNuejV1L1lWSE1MYTJuWjg0SkFkeDNRcGJw?=
 =?utf-8?B?SkdkVkNGY0RqanRLQ0UrajZkVHMyME1na1ByVzRLYUpMNlE5N0EvY0c2dGFL?=
 =?utf-8?B?MWZrRVhhNkxISTVSNFduVVlEc2x6NWEvVm1RbGlaYnhHUTQ2VHBGVEZuQmNh?=
 =?utf-8?B?MnRsOFhpdEswd3pCRFhPZFFxTHQzM0s1cGcyYlVxVGRFTE1MbStjbWpWbnli?=
 =?utf-8?B?emJ1aGRKc29RMnBwOFNuMysvMGxscFd0V2dDNUZ1ZE5hd0lwVSs5OG5mTkF2?=
 =?utf-8?B?N3FCYnRiZjhtSTZFN1hxOENCRG5IdFFnTkFDaS9NTVNTRWpFSlUwVW1udG5T?=
 =?utf-8?B?ckFiTDFGRU15V3lxdG1SY2ZvLzU1ajFLcVVZNzk4bTVpeWZVTmxTN05EbFZZ?=
 =?utf-8?B?ajF2dnl1TFA5bjNmVkxacCtLbzJNa0NaY0QrL0tqbDlNOWxLY00zR1NvOEU1?=
 =?utf-8?B?ckpzMUlvcHcySkFPUkVrVmJlTXk0dFdQMlNTNUVjdTNlLzh2WktveFRnOE5M?=
 =?utf-8?B?UlVLZllUNjFFUmVQdDVsMzF1b3JzWnI3VGI4dWJCK21ETFU4bDlLcThJdS82?=
 =?utf-8?B?cEVVQUJlcThhUVl3MkFab2M2TE9ESlk0OGVhMEJKUmdEbk80b0JLK0s2TnNP?=
 =?utf-8?B?Y0hUN1JvaVBSa25xYk5iczltd2hqRTZBdTlKYWhJZUI0RHVNR3RTMzQzMlpt?=
 =?utf-8?B?ZjQxRVRVcEVoUmdrOHpYVFFKTkJObGFTQ1N6blZydzNCTEVqV2hSdHRQdUJV?=
 =?utf-8?B?QnU5Mk5GRWlzTkl4SUFURk9rZHhaSWladTFuYXdORFhta2J3ZVc5TFpoeUor?=
 =?utf-8?B?NytHRDVYTVVuRlY2ODNXMHJGRmFLdFFSdTFubGMrbCtpaVY5L3IwYUtTVFRD?=
 =?utf-8?B?RnZVNWFxdHZ2b1R6dXcwdVBBbWY3N1dhZUU1TFZVY2pHVDF0RjZSL2YyMU02?=
 =?utf-8?B?NlZyQmlocThOUmVpSWc5dUdDUW1qVFZaUGNGWG10RGEwU2lpT1VVWTdvaXFG?=
 =?utf-8?B?SXJ1b0hRU2RVYmszYjZOLzl1anJxeTFHRGE2MDZoT1lBMDVuTWVlWXRwb2Zl?=
 =?utf-8?B?Y3NwZVdkOHF5dFZsbGRxR1lPdUxhVjA0dFY1VTlTYjFzS2ZMay9jMk02bXVa?=
 =?utf-8?B?cEMzd0p5NnBWTDRGUzNpeW5DL2VPMlFQTjJjYllIeEhyNjZCTjRJZzArSkhp?=
 =?utf-8?B?VDBQVFBZUjF3cUhJZ1RvcHltazUxOWJPUTVHS1NmUzhrVEtTK25CRS9NdDFI?=
 =?utf-8?B?eDh4NmhpYVZtMFZUUy9pMGZWZTZsMlBLM3Jya3NkVXU1bFR2N0JhNnMxbXkz?=
 =?utf-8?B?N0k1WlN0eUVYODdkRTdjN0lQa1loVDUyRFkzQWtQZE5KV3ZGQ1dwWVo1ejBx?=
 =?utf-8?B?RXNpVm5wNFk4cTdINzc0M1Q4S3l4bWs3TXA3ektlUUE2alBHZEJQNmhOUjdJ?=
 =?utf-8?B?Zk1pYXJXUEN3d0FNdmFSM1cvcGVmbERmeXRnVnFKT01qUWhOcWlRSlA3c0Zr?=
 =?utf-8?B?Z2NRNmdSRUJsYm5yUmxuTHFrMEorc1ZueUtYNit3dWdBcXJXVjc4K0gwTWov?=
 =?utf-8?B?MHZFZ2VDL0lhK01BQjF0T1h0WkdvSnIwM3dPRWFSNWhDcktUMTBPN1ExaXlJ?=
 =?utf-8?B?eS9kZVY5V0ZKcVJBTVMvQVNxZjh6cU9maEgyeTBVa2Z5cDRQZUsxTERzblNN?=
 =?utf-8?B?L3hKWDV3K0ZuNjdqMFVpcUdCOEtpNWFEL0p5RnUzTWVJVjM0WDQxeVVGQTNS?=
 =?utf-8?B?SzFkOS9Cb1BueUdWTExpZHdLYzZyUlpJSHJscDRkbTJJUlRZMDNrWjZLU1R2?=
 =?utf-8?B?N21yb2c5STdsdUhQRi9DTFNJenMzZDBFNzVLZ1NNY3N4Z2RScTg0aXcyamYw?=
 =?utf-8?Q?JAmZgIxbZvQ=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?OStHNzh1MVVnSmFGN1FobjVSTVRyb1hMUlJaSTNjT21KeXZZak0xNWJtc0Z3?=
 =?utf-8?B?bFlpS1pHUWdIK1BzT2lvOG1ENG44OUtZL2NDZW91Z2xTZzRsZmdMMzJoTENi?=
 =?utf-8?B?UitTUlpiUVJyOU81Q3VBQk5kQ1BZYVQreVlWRjBYQTdsVWtFQnFoRS95Rk8x?=
 =?utf-8?B?N1FiaVFMNnJZSmkydWhFdG1vQVhZdGs0REVXeVVLdFVyTUljZ0NyckZHT3o5?=
 =?utf-8?B?d3g3OG1Uc1NyV0pRN1JNK3dFMVZvZGJYeHdYQW1PMGUzQkQvOFJrL2NwQ3FO?=
 =?utf-8?B?akxnZWtxNk16aXozVER5L281cWFsSWtQVnpXZ1VDb2lpUndreXpnOHRUeHls?=
 =?utf-8?B?Ynh5RklYbXRBUTFOUTRMQWZnK0o4ZkE3N2hMbmZaUGdqeXNEY3NJRmc1dERq?=
 =?utf-8?B?U1lFcGhnaEUzZldqT0dpdHEyeUt6bFNEZk81WUVtcFplQjdsaW00WXN6U3Zv?=
 =?utf-8?B?YW56V3g0OHkxcDgvd1NpK2c0bFFTWVNzTUpIQytabmVmaDBGTkU0cHhkMUkx?=
 =?utf-8?B?WHFWQ3RTRkM2TDR2M0s0dHgxZ2M2Zm1PajBkZTgxTzJMeFZZYXJtRnZPVlR4?=
 =?utf-8?B?c1huZ3hSWFNzaVl4M1lxK3pGYnBkY0RNeWlPZlZrVVdFR2pockVuamN0L2I3?=
 =?utf-8?B?NFNlcTZZMmxPc2Qwd0tFMWtaY1Q4a1pRSksxV1U0NTRRNXpLWHczVytuM2l6?=
 =?utf-8?B?MzdtZlA0aTlWQVBkZG9mczdIMTdLWE42NUdvTXIwWFZPRzBlQ1k4WldIZmt6?=
 =?utf-8?B?eEk3TG4wZER2VExCd2RXeGZtaWdEVGYvSDdxVUZicFFMOXJmOTZBV0E5OW9S?=
 =?utf-8?B?NHM1QjNsRGJzRS9naXpyWUMvS2hJbkhJQitLbjJseC9KdDhhOXRVZG14ZHcx?=
 =?utf-8?B?TnlXeXh6NFFLOWp5REVRbkxrVVJnVzVLZGFzUTQ2K3RYOFZBN3p5KzRrbUhD?=
 =?utf-8?B?OWxLRnBGU2R2eVN3QW5DR3lBQkVBOENVV29JeFJBMTVYeTNockEzQ0ZVRkdq?=
 =?utf-8?B?SWhGM3YxSXZ6a0JKVklndUVmUnNZWWZPR2xoakFaWDJML0hva2tFOTE4QVdY?=
 =?utf-8?B?KzRJUzN2MW1Udi9EelFvY3cvdFpZMzZnaUN2eU1aQ09uMnVzT3hQTnY1UVlV?=
 =?utf-8?B?Z1k1TnZHVjBhYk5YNFk2Q0pXaEZ4eUdlL21neXdpUnJOMHhrTWZYQXpKbjE5?=
 =?utf-8?B?Y1JvTDYrVEFENVNYYmVYcGpkMzJIRDFkckJiVytvUlFicWd5SWxXTFRIcXNi?=
 =?utf-8?B?MCtVbVJDVUM3Wjg4RWlNN3M2T2Y5cHQvYzlISE44MXV4QkdORzJJL1hVdUxQ?=
 =?utf-8?B?eENuTUZTQ2ZkRkJQNStKMTRwUGcvRExQN0JEcVZheWkwa1hDWmhhSkpRTkdl?=
 =?utf-8?B?bUN5eUdtdWJTYU5LVlZqalhSY09TNFE0RGovWTZySnZVdlo0L2VkOWdBTkMv?=
 =?utf-8?B?clphMEY4bGpVZndTZEhodHFLdFdHaG82a2VtVE9ndnZXWXJVUWNhRHJzVjRx?=
 =?utf-8?B?R0RJTVFOYnFabjBhd2VoVU4zaUJTQUF3WHUvSk94TEtFZkF2OWZYeTBBN3ZP?=
 =?utf-8?B?dnJJRHVLZWlPaGNWREJObm5vWTZGUkNDRlloUnlnMFJCUEZvSmJmUmsrdjNt?=
 =?utf-8?B?eHZsWGN6R29tZDBvQm85aHhKdU11ZXlVZFJFZmUwSFJaeTl0WHk5SnhBbUhO?=
 =?utf-8?B?Y1JyTWVtMlpDYjJaZWg0MHM4THFmSG1rNnM1WXZGQWM0UDAzWWJxRXE3TDZj?=
 =?utf-8?B?SExpRGxPSlZUSlNpUzlKbVo4U0VrN2E4MitBdmRUQmR1a3laQmhMUm5sZzAz?=
 =?utf-8?B?VWhLWnhDRGpXWXA4U1NZMXV4bXV5ZXpXYTdzZVVBeTZKMmhRa1VUeHhkZ240?=
 =?utf-8?B?ZHRLTjI4ZDZpNkpJT24xb3dhbmxFNVR0Zkw1YWMwSUJ5ejJZVm5oZUlNVDRM?=
 =?utf-8?B?V25KVXJmUWUxSzBZNldoRDNpVEN1SURwdU1CQW1uKzFnYm9rVmI1UzdLbWlU?=
 =?utf-8?B?VzMra3NnUkVXZjI4NkdKVGFLeTAyd0o4c0M1R1dnT1hlc2M5bkQ4UG0yVkhQ?=
 =?utf-8?B?TXBienBMMXBtMHUwRDZGUXdXeTRUa1k4TFkvN0xSWHltVFpKdkFuMkhkeUxJ?=
 =?utf-8?Q?Nc6NHyu9TLU3a00AozZmo0KKG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WOjjiBn05TNDBHGOv+cGFkDr3WJjSrFZkg7hROtOhFqHfvWmTewHcfasBP++gwb4aVUL8PHSt166mIe8wDZNPtfH/j5zrpY4mNA33IDAD/7/xpE03m8ry5Ve8IvuIjbYK7fOTS/UF7p15Ar6uyXeSQLyOv4pj9nd2ziOPK1xVMOrFR++jgTx+d2M8pjNli44vFtIsqEoHkpBC80n8MBgDb2guvNqM9SzYn7Qj9svTmKNnrlF3apthqj4DCeV8e/n/fIgXuQQUrzmsbJ8Bt+K5RSAlkGgi/zCkMDzSQdhAUfhlUdyJT/FoeF9s3OB+x46YXkB2Gpi88MacpQWtyWZpVtNRCFKyIjnTZxhWxOHwXnk4MJo1zhFg5iEGBz0DAv/WHzUaQjCLJDSm3rxr8DsYxwT7jDjppBLbIrrHJebqqLeeIKmiEer7Wr6+1Kwp5uasBJtug3lGIibhHAvZj5VG0TyuTfV1rQ0ZiToOHnBpNiJJvoC0UmWHgDsw8qs2GvSgUYJikZTBS+8bTNcjIaGr2QUusj4WM7A76ZqCkTRYgvDIZyxyLzCQ1negyjumgl4m6PjrrUtxjxpLkyMEamTldbG2vzxULZGlqYmFSAe6YA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7586e8-4efb-4340-8482-08dde574f753
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 14:21:08.6128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CSRWWCvwqG0aR9eicXHjgMa2n3aHp5gZo+wZjtoLpWLmE5oj5xrgtbzDfJ1+IHqDJv5nRHOZghErbbkzO+wGvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5756
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_03,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508270122
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxNyBTYWx0ZWRfX0svY/3gkkhXQ
 +5uyCoIASSO2ENunJMkIW1VkbI0UMpDIS1fxshykmtDLZ8chklEI+UWXma4V3VnubbxWzHqdi7X
 3G0giz/oZGLrvbmT0oNRmkdRiI18QMijyDUEzYOtmLTdKo8U/LPuXpDeikJWQcQxvVBde8UCIlu
 dk7bWULMOpRj+SH1PGFl+waVQbQzZIhPJQXT5HTYn1s6qnIktw8NPXZoCRyHRPHIpprHyQi3fdy
 m+pGXypfBqdQC26arggAFOSIIny0wwA9BCfc/nerQD7jSMRpmaLqi2RHiPI4WFAiYNDNzPDmKqR
 GG4ItpwSX+pqWW0eB8LvqsFbrK7PxMTeWgBjGty0CBXl/WLS4uzOsXjDvnzgJEG1iXgeQLbHEQx
 PLagws9R
X-Proofpoint-ORIG-GUID: hpl7HpE45WB2JQTw7aIhAf0J1ukaaEoQ
X-Proofpoint-GUID: hpl7HpE45WB2JQTw7aIhAf0J1ukaaEoQ
X-Authority-Analysis: v=2.4 cv=IauHWXqa c=1 sm=1 tr=0 ts=68af145a cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=oikmu87c4NAxFKBOGysA:9
 a=QEXdDO2ut3YA:10

On 8/26/25 6:00 PM, Olga Kornievskaia wrote:
> This patch tries to address the following failure:
> nfsdctl threads 0
> nfsdctl listener +rdma::20049
> nfsdctl listener +tcp::2049
> nfsdctl listener -tcp::2049
> nfsdctl: Error: Cannot assign requested address
> 
> The reason for the failure is due to the fact that socket cleanup only
> happens in __svc_rdma_free() which is a deferred work triggers when an
> rdma transport is destroyed. To remove a listener nfsdctl is forced to
> first remove all transports via svc_xprt_destroy_all() and then re-add
> the ones that are left. Due to the fact that there isn't a way to
> delete a particular entry from server's lwq sp_xprts that stores
> transports. Going back to the deferred work done in __svc_rdma_free(),
> the work might not get to run before nfsd_nl_listener_set_doit() creates
> the new transports. As a result, it finds that something is still
> listening of the rdma port and rdma_bind_addr() fails.
> 
> Instead of using svc_xprt_destroy_all() to manipulate the sp_xprt,
> instead introduce a function that just dequeues all transports. Then,
> we add non-removed transports back to the list.
> 
> Still not allowing to remove a listener while the server is active.
> 
> We need to make several passes over the list of existing/new list
> entries. On the first pass we determined if any of the entries need
> to be removed. If so, we then check if the server has no active
> threads. Then we dequeue all the transports and then go over the
> list and recreate both permsocks list and sp_xprts lists. Then,
> for the deleted transports, the transport is closed.

> --- Comments:
> (1) There is still a restriction on removing an active listener as
> I dont know how to handle if the transport to be remove is currently
> serving a request (it won't be on the sp_xprt list I believe?).

This is a good reason why just setting a bit in the xprt and waiting for
the close to complete is probably a better strategy than draining and
refilling the permsock list.

The idea of setting XPT_CLOSE and enqueuing the transport ... you know,
like this:

 151 /**

 152  * svc_xprt_deferred_close - Close a transport

 153  * @xprt: transport instance

 154  *

 155  * Used in contexts that need to defer the work of shutting down

 156  * the transport to an nfsd thread.

 157  */

 158 void svc_xprt_deferred_close(struct svc_xprt *xprt)

 159 {

 160         trace_svc_xprt_close(xprt);

 161         if (!test_and_set_bit(XPT_CLOSE, &xprt->xpt_flags))

 162                 svc_xprt_enqueue(xprt);

 163 }

 164 EXPORT_SYMBOL_GPL(svc_xprt_deferred_close);

I expect that eventually the xprt will show up to svc_handle_xprt() and
get deleted there. But you might still need some serialization with
  ->xpo_accept ?


> In general, I'm unsure if there are other things I'm not considering.
> (2) I'm questioning if in svc_xprt_dequeue_all() it is correct. I
> used svc_cleanup_up_xprts() as the example.
> > Fixes: d093c90892607 ("nfsd: fix management of listener transports")
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> ---
>  fs/nfsd/nfsctl.c                | 123 +++++++++++++++++++-------------
>  include/linux/sunrpc/svc_xprt.h |   1 +
>  include/linux/sunrpc/svcsock.h  |   1 -
>  net/sunrpc/svc_xprt.c           |  12 ++++
>  4 files changed, 88 insertions(+), 49 deletions(-)
> 
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index dd3267b4c203..38aaaef4734e 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1902,44 +1902,17 @@ int nfsd_nl_version_get_doit(struct sk_buff *skb, struct genl_info *info)
>  	return err;
>  }
>  
> -/**
> - * nfsd_nl_listener_set_doit - set the nfs running sockets
> - * @skb: reply buffer
> - * @info: netlink metadata and command arguments
> - *
> - * Return 0 on success or a negative errno.
> - */
> -int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
> +static void _nfsd_walk_listeners(struct genl_info *info, struct svc_serv *serv,
> +				 struct list_head *permsocks, int modify_xprt)

So this function looks for the one listener we need to remove.

Should removing a listener also close down all active temporary sockets
for the service, or should it kill only the ones that were established
via the listener being removed, or should it leave all active temporary
sockets in place?

Perhaps this is why /all/ permanent and temporary sockets are currently
being removed. Once the target listener is gone, clients can't
re-establish new connections, and the service is effectively ready to
be shut down cleanly.


>  {
>  	struct net *net = genl_info_net(info);
> -	struct svc_xprt *xprt, *tmp;
>  	const struct nlattr *attr;
> -	struct svc_serv *serv;
> -	LIST_HEAD(permsocks);
> -	struct nfsd_net *nn;
> -	bool delete = false;
> -	int err, rem;
> -
> -	mutex_lock(&nfsd_mutex);
> -
> -	err = nfsd_create_serv(net);
> -	if (err) {
> -		mutex_unlock(&nfsd_mutex);
> -		return err;
> -	}
> -
> -	nn = net_generic(net, nfsd_net_id);
> -	serv = nn->nfsd_serv;
> -
> -	spin_lock_bh(&serv->sv_lock);
> +	struct svc_xprt *xprt, *tmp;
> +	int rem;
>  
> -	/* Move all of the old listener sockets to a temp list */
> -	list_splice_init(&serv->sv_permsocks, &permsocks);
> +	if (modify_xprt)
> +		svc_xprt_dequeue_all(serv);
>  
> -	/*
> -	 * Walk the list of server_socks from userland and move any that match
> -	 * back to sv_permsocks
> -	 */
>  	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
>  		struct nlattr *tb[NFSD_A_SOCK_MAX + 1];
>  		const char *xcl_name;
> @@ -1962,7 +1935,7 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
>  		sa = nla_data(tb[NFSD_A_SOCK_ADDR]);
>  
>  		/* Put back any matching sockets */
> -		list_for_each_entry_safe(xprt, tmp, &permsocks, xpt_list) {
> +		list_for_each_entry_safe(xprt, tmp, permsocks, xpt_list) {
>  			/* This shouldn't be possible */
>  			if (WARN_ON_ONCE(xprt->xpt_net != net)) {
>  				list_move(&xprt->xpt_list, &serv->sv_permsocks);
> @@ -1971,35 +1944,89 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
>  
>  			/* If everything matches, put it back */
>  			if (!strcmp(xprt->xpt_class->xcl_name, xcl_name) &&
> -			    rpc_cmp_addr_port(sa, (struct sockaddr *)&xprt->xpt_local)) {
> +			    rpc_cmp_addr_port(sa,
> +				    (struct sockaddr *)&xprt->xpt_local)) {
>  				list_move(&xprt->xpt_list, &serv->sv_permsocks);
> +				if (modify_xprt)
> +					svc_xprt_enqueue(xprt);
>  				break;
>  			}
>  		}
>  	}
> +}
> +
> +/**
> + * nfsd_nl_listener_set_doit - set the nfs running sockets
> + * @skb: reply buffer
> + * @info: netlink metadata and command arguments
> + *
> + * Return 0 on success or a negative errno.
> + */
> +int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct net *net = genl_info_net(info);
> +	struct svc_xprt *xprt;
> +	const struct nlattr *attr;
> +	struct svc_serv *serv;
> +	LIST_HEAD(permsocks);
> +	struct nfsd_net *nn;
> +	bool delete = false;
> +	int err, rem;
> +
> +	mutex_lock(&nfsd_mutex);
> +
> +	err = nfsd_create_serv(net);
> +	if (err) {
> +		mutex_unlock(&nfsd_mutex);
> +		return err;
> +	}
> +
> +	nn = net_generic(net, nfsd_net_id);
> +	serv = nn->nfsd_serv;
> +
> +	spin_lock_bh(&serv->sv_lock);
> +
> +	/* Move all of the old listener sockets to a temp list */
> +	list_splice_init(&serv->sv_permsocks, &permsocks);
>  
>  	/*
> -	 * If there are listener transports remaining on the permsocks list,
> -	 * it means we were asked to remove a listener.
> +	 * Walk the list of server_socks from userland and move any that match
> +	 * back to sv_permsocks. Determine if anything needs to be removed so
> +	 * don't manipulate sp_xprts list.
>  	 */
> -	if (!list_empty(&permsocks)) {
> -		list_splice_init(&permsocks, &serv->sv_permsocks);
> -		delete = true;
> -	}
> -	spin_unlock_bh(&serv->sv_lock);
> +	_nfsd_walk_listeners(info, serv, &permsocks, false);
>  
> -	/* Do not remove listeners while there are active threads. */
> -	if (serv->sv_nrthreads) {
> +	/* For now, no removing old sockets while server is running */
> +	if (serv->sv_nrthreads && !list_empty(&permsocks)) {
> +		list_splice_init(&permsocks, &serv->sv_permsocks);
> +		spin_unlock_bh(&serv->sv_lock);
>  		err = -EBUSY;
>  		goto out_unlock_mtx;
>  	}
>  
>  	/*
> -	 * Since we can't delete an arbitrary llist entry, destroy the
> -	 * remaining listeners and recreate the list.
> +	 * If there are listener transports remaining on the permsocks list,
> +	 * it means we were asked to remove a listener. Walk the list again,
> +	 * but this time also manage the sp_xprts but first removing all of
> +	 * them and only adding back the ones not being deleted. Then close
> +	 * the ones left on the list.
>  	 */
> -	if (delete)
> -		svc_xprt_destroy_all(serv, net, false);
> +	if (!list_empty(&permsocks)) {
> +		list_splice_init(&permsocks, &serv->sv_permsocks);
> +		list_splice_init(&serv->sv_permsocks, &permsocks);
> +		_nfsd_walk_listeners(info, serv, &permsocks, true);
> +		while (!list_empty(&permsocks)) {
> +			xprt = list_first_entry(&permsocks, struct svc_xprt, xpt_list);
> +			clear_bit(XPT_BUSY, &xprt->xpt_flags);
> +			set_bit(XPT_CLOSE, &xprt->xpt_flags);
> +			spin_unlock_bh(&serv->sv_lock);
> +			svc_xprt_close(xprt);
> +			spin_lock_bh(&serv->sv_lock);
> +		}
> +		spin_unlock_bh(&serv->sv_lock);
> +		goto out_unlock_mtx;
> +	}
> +	spin_unlock_bh(&serv->sv_lock);
>  
>  	/* walk list of addrs again, open any that still don't exist */
>  	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
> diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
> index da2a2531e110..7038fd8ef20a 100644
> --- a/include/linux/sunrpc/svc_xprt.h
> +++ b/include/linux/sunrpc/svc_xprt.h
> @@ -186,6 +186,7 @@ int	svc_xprt_names(struct svc_serv *serv, char *buf, const int buflen);
>  void	svc_add_new_perm_xprt(struct svc_serv *serv, struct svc_xprt *xprt);
>  void	svc_age_temp_xprts_now(struct svc_serv *, struct sockaddr *);
>  void	svc_xprt_deferred_close(struct svc_xprt *xprt);
> +void	svc_xprt_dequeue_all(struct svc_serv *serv);
>  
>  static inline void svc_xprt_get(struct svc_xprt *xprt)
>  {
> diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
> index 963bbe251e52..4c1be01afdb7 100644
> --- a/include/linux/sunrpc/svcsock.h
> +++ b/include/linux/sunrpc/svcsock.h
> @@ -65,7 +65,6 @@ int		svc_addsock(struct svc_serv *serv, struct net *net,
>  			    const struct cred *cred);
>  void		svc_init_xprt_sock(void);
>  void		svc_cleanup_xprt_sock(void);
> -
>  /*
>   * svc_makesock socket characteristics
>   */
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index 6973184ff667..2aa46b9468d4 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -890,6 +890,18 @@ void svc_recv(struct svc_rqst *rqstp)
>  }
>  EXPORT_SYMBOL_GPL(svc_recv);
>  
> +void svc_xprt_dequeue_all(struct svc_serv *serv)
> +{
> +	int i;
> +
> +	for (i = 0; i < serv->sv_nrpools; i++) {
> +		struct svc_pool *pool = &serv->sv_pools[i];
> +
> +		lwq_dequeue_all(&pool->sp_xprts);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(svc_xprt_dequeue_all);
> +
>  /**
>   * svc_send - Return reply to client
>   * @rqstp: RPC transaction context


-- 
Chuck Lever

