Return-Path: <linux-nfs+bounces-8474-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22389E9D13
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 18:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6039C280C23
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 17:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A97D14B97E;
	Mon,  9 Dec 2024 17:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GtD/JWyB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="p6JCxNQh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0580153BFC
	for <linux-nfs@vger.kernel.org>; Mon,  9 Dec 2024 17:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733765321; cv=fail; b=e+TGJgBYy+RTieta8n7Az7TWinWRd/3qo+h/oMJpSvSUA8htndw6OckoZvDCUiPM9yGqN/qLntYoPsyOodcrWZhIuc8Xor+UIocjLAkc/iLmL2qvTXZmGWCKRyGo2ZGezpfpyQH2nSfX3pidP9/EGwls/HDkcxoYJyCSpkRci/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733765321; c=relaxed/simple;
	bh=YjvJL73jIAe4Xv+J4OoypuZ0un1KyKD5CLXjTHIoyyY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hEN2O1xudsX2hn4g9WOCNZCOa1FsoqKqCGGToif0bx3jS6FqwR+H46gMcz+RO09rpbGEdXo4N7nALqttF+oeVm3mLX5O1EEVX+epJ00MnlZRlnaMeFYMYSBFMtFIWNe2bC8zMTNZVdRYw5DDCZGG5m2A+Hb3Tnez4adexa/2hUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GtD/JWyB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=p6JCxNQh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9GfpIp000820;
	Mon, 9 Dec 2024 17:28:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=NRWLMpKqzQ7friJ6F8rj2PyPv/RNcg5+uVkbbmr7XIE=; b=
	GtD/JWyBBX6XAl7ugE7EpU2/2U0zJSWxhuIjJY/IaPFUZG9abbkyfE/T9CLUlGAB
	ZDMZnYWtxSm1Eh2h/RTywKXjveao0HoQzFiwB3QXyv/DBX+0IEA5TBby3QhTB/AT
	fiWA81kot2aCLvcE9GzgHLzL+HiTtgpSGd7LU6nrtG2YNrGU4wHRql/CnNuTNUgq
	CXNIPufQQ1nEtkjBUBUIj0chVM2NBo7z7K19DsODCeiabULD0LGlqsMZSZfGuiLd
	L6JqcsPk6C891AK1qPob4rZr9to+sgwFz6ZZkmSl3nOWJb1uMFHfTl1wPxpxTATh
	uvEM0L35B1/rjxp05tW6aA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cewt3ryd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 17:28:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9G7hsb020591;
	Mon, 9 Dec 2024 17:28:29 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2042.outbound.protection.outlook.com [104.47.51.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43cct763qd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 17:28:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/o7U9tc+R6hhIum1flj8tpI7q0ltB1yu2h+Sq8Uol6lPe8sMvjIVjoqXCYab/Ses9OKD+q1tKNqSl9pffVrcEzaR/WStAo9Zwgna6gLGhbdEvk0MsAgCCQDAY66ZDCl+1ysoytOusAitDhYr+coY28qv3Q2DeHPSaTQagdQeq1Xcicw6r3HLLFpJzh0khTFIosjIy8TAwN9c6ah9CoY/yVKn61C/Tow1uevjDCDXohCK84y9QwFEu9BdK408HMOAyUBoI7Q9BE+izzrfeSWZQrJCLafDV1xqRYAWpIfmIFkQ7zIWBb7J7JnuTwze2okXTD+f531cJgVvgumuUI6fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRWLMpKqzQ7friJ6F8rj2PyPv/RNcg5+uVkbbmr7XIE=;
 b=R5r/AiiqVwa7b3kbP1Hcj1Yz/YMCRdsby8FU6Vast4E107RuToWPaomm5La9c4yLCp+DY+EBukCDOLQMriZIAlvdFAuNsT1W+h07qkYEW8T4cUzSlZ8kQbkokLtlMavyxcaa3yZCihY2dz150LOsPPeobHvvnqOv33xG99jkIICZDIPaiGaWTIg6YFLsXDMM+NstZUGD+/yE5L4Dv3ZJ36++vnmZFtCRYrsEbXz7ObO2PAGDPJ9wjzTaM67j9DXgpr+8LIqXzWLYc4uij16WMf9d1zEXVclDnCoUDkOjEQ75ixGk0v0S5U37gqNDXO0TxgPkADGLfuOwHZtY2swTmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRWLMpKqzQ7friJ6F8rj2PyPv/RNcg5+uVkbbmr7XIE=;
 b=p6JCxNQhifji8fv9ng8kntFwPjnGUYbypEEx1H6ZT1frTSh9pH89xS+w/Rg7Pz8/+PybCUj4VQw2KCGEXwO0BdSMzMXlDAFnwx6O6yF6sF45GPaAzKDhcx+93XmVunisWyGsmlhClkV2BOjuC79ADkM4KHOyvI89snG+NTUvxjo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5213.namprd10.prod.outlook.com (2603:10b6:5:3aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 17:27:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 17:27:55 +0000
Message-ID: <6803341d-5071-46f2-971a-b1699572d833@oracle.com>
Date: Mon, 9 Dec 2024 12:27:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] sunrpc: remove all connection limit configuration
To: NeilBrown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
References: <20241209004310.728309-1-neilb@suse.de>
 <20241209004310.728309-3-neilb@suse.de>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20241209004310.728309-3-neilb@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0050.namprd13.prod.outlook.com
 (2603:10b6:610:b2::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB5213:EE_
X-MS-Office365-Filtering-Correlation-Id: 40745a9f-8976-4634-1c0c-08dd1876d174
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vy9WY1p0eXgzSFlVL2ljWWx2QkFmcUR6MVAxSkFGaDBIYWlsOG9hR0d3U1k5?=
 =?utf-8?B?QkFhaFJwL3pKNXF2bjlOcFNKZ0NCSEpHQ2dBQTQ3VVRaZ2NqNkdsTk43NGZ5?=
 =?utf-8?B?a0xzMnNPQlhlOFZzUFpVMjFJQ1BBcHdlK0JqNDRTQWJZa3lFMjU0L0MyaFha?=
 =?utf-8?B?clo2ZHZxZFBHbElYQnVKOHpRZ1BCdjdUNGc1L0tVbHIvL2ltcDE0RXFHQ29r?=
 =?utf-8?B?SlVDR3VGVWtvbW5LQm9hTnl3eFJuZDJLd1hCRFZNV2hrRllyTzY4UUpWY0ZX?=
 =?utf-8?B?ZjdtRkdTWUV0MUczQ3FTZ2RnRXcxRWFxQ3NraVdtY3RDUkFwYk1HdGxzN3Bp?=
 =?utf-8?B?QTNTdEpTcHdpMXlxVHVuU2RNS0tyN1dMMWNQeXdDMUFJRm5QNjFpNm5ySTZ2?=
 =?utf-8?B?eUt6Qkk4UWN0K3Q3b1ROc2RqRmg5UDZ5MnR6enlLSkxReWowYjlUNkFSYWVS?=
 =?utf-8?B?RExDQXJrenVlSk85dk94eWNvNXRLaWJQREtGTjdQZUFudlMxN21GM0xWNlJB?=
 =?utf-8?B?QkMxVHVkTkVoOUpMOU5DdHcxbVZ6ZnBSWTEvdFcyNXNQbmsrN1hMa2x2dlRo?=
 =?utf-8?B?aWgzVlNIM0FOWGF2dzIrdmo3UzBqQm5YTm9ha25Sc3BCamw3VlRITTVjS1ZF?=
 =?utf-8?B?b0hsdDVsNjZtbUxMOWNpNnFGYlYzdmVadEo1Q3V1enFpVEpnMDZOV1o2TzNB?=
 =?utf-8?B?dlpMWFRCTnZoUmZUZHdLNHp5SUo2ci8vK2dNd2ZWUXduaHJ3VEhrSFRzSjJr?=
 =?utf-8?B?eE5NZlNkQkhtMjZoN2JnUEZzNVRJTDVlZHErWEltc0x4aEg2RHVEMDRTVlJi?=
 =?utf-8?B?dUZ5OVAwL1kzUVA3OE0xeFpyVjBTUW4rZFQycVhsV0xvOGhoS1liNWRiVzNh?=
 =?utf-8?B?b1o0N0FzZ1FGbklhOHkwSUdINEJjc1ZZVktnSm9iRmFWcDZWbmJ0K3pOWDZh?=
 =?utf-8?B?YVozeXd0cTdVWktWODl2cWVHT0lLVWN1NU1hdTZBdERuOHFsT0k3TWtJai83?=
 =?utf-8?B?QjhDdnY5amc3Y2l2eDNRVEdqdDZsUGIwK1FxTW1uWm1pUE5mZEVNMXBSK2Jz?=
 =?utf-8?B?d3VOVm9JcFRvOHl6a29YNUFtZXpidTlkRCtXRjA1N2JFZGpLMjlOT2ZhQ2d0?=
 =?utf-8?B?M244dm53TktVZjhGSktJRUwvdHpzQUZTanBXSVdLbUYxaENUSGY5azBHY29t?=
 =?utf-8?B?eUZXL1FGOXJvMCsxa0J0UTJVZEZKUjkzNUNHa284NDQrS09oSmNrVGduODN4?=
 =?utf-8?B?QlQ4dHBOSUtZSzl4RWFhWjdFSjVvVTVUM3czWGRyZkQzRUswYWhheVJSK2Jh?=
 =?utf-8?B?dkZ6L2hIdmZXREdqd3JBdlV6SkRIaDJ6bUhIUGNwUEFiVGQ2ZzdWMmo3NTI0?=
 =?utf-8?B?YXpyM3l3bFZ6bEFNbUJSc1RFb2gyRHpvMFJzWE5MbVNPcDBUMWdZRmtrZlpp?=
 =?utf-8?B?Unc1dkNkODhlUlNESmhBOTFuNFNxTkpCRER6VlZWSTJMMjRpanFNL0JpWWlP?=
 =?utf-8?B?N0RDMXU1TlBFTVI5U1VKKzdzTnlVUUFibHFzNFdQSkFFb0o2RDNwMENLZ3RC?=
 =?utf-8?B?YVU1alhpeGRlM0lDQnZ0WmhjeHNlNXJWRzB6L1FNRE93ZWs2blJDekl0R09N?=
 =?utf-8?B?UUh0YXYxQVUyZk9GM2o2dXVpdkxmN25uM1NiNlRheWNiTTRkR295ZHNPN0M2?=
 =?utf-8?B?NkY2dWdmaFdmS2s5RmFhZTMwTGtadHRGQTV4U2FDdW5nZWtLdUZsMFhobHJW?=
 =?utf-8?B?bVR0blJkeGx2UjdhbjlYWmJhRXFNUldoNGJSdEQ0eG8ra3prL2IzalBVWStS?=
 =?utf-8?B?elZwZzNGZXRkbTloak5qdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkpJLzZ4VWFGUUUwb3crTjNTUTVCdjQxOVg0TVRYM0UyNEUrTm0zanNoMXFJ?=
 =?utf-8?B?WCs5MTBTOEh6Nmk5ZWtOcEFMcGdHNnlNQ0czM28xNU5acmFjd2U1L1YzYmVV?=
 =?utf-8?B?ZUMwR3ZzWFF5eDZ2UjNoamM4blV1Y0tsZEpKRjNWTlhSVjFsMklsZzZ0YmJh?=
 =?utf-8?B?R25xUjdYU0hUMWRVL2p4ci9oTS9FSGZSaG1JMWJtbVR5eCtyU0xYR1R3YWh3?=
 =?utf-8?B?b0NYRDJHL3lzak5IeWdlM2hrTTMxR1BzcTZEcXNmekxsd2VLT1NJMWRKRHR1?=
 =?utf-8?B?WVpmRVF6NGdzVkxQUnlFV3hzaG9zUTVWQVdjdnpLeWxWeEdpcnZIem1pZXNo?=
 =?utf-8?B?bnhOSXR2Rm1JTnlGOEhjVTVNRVBmZzVDWEVjNUpvUXMzUHY1NFZDcWpXL1RJ?=
 =?utf-8?B?U0JuaS9mMWF1OW52KzBmWlpNUlhRQ0txSWY0WFM2WEN1Zkh0bGVIajYvVE11?=
 =?utf-8?B?djVxaC9sM0MrMFY5Z0o0aGdCa0RHNDErbGVFTG4rY0kzbEtqcmNHVlpSU3gx?=
 =?utf-8?B?MUhaVXhTSGlYZ3hNY01oaEQrZ0JUM00wVytTM2g5OXp4MFh0RHBWME5LNmYr?=
 =?utf-8?B?UkxIV1o5RnZtc0FUQWlWNzAybXFIZVpsNENWVWhKVXhXTjNjc0hibFh5WHNk?=
 =?utf-8?B?Z2VJY3NPTUhrMXJsTDUzNnFvaGFvVEd2V0tWRE43Kzc0RmlOTm5UZ0dmZmtj?=
 =?utf-8?B?c25zdnJzcVFTMmpyT2VJMEsyeVN2dHY1a1Y2UWpHOGxHZjFveUV2RUhQTHpG?=
 =?utf-8?B?R0hPYXExeDRIVmRrVUk3VWZRMGNWTFVINFp2amV3V1hHYmErelhiUndpOGxi?=
 =?utf-8?B?bXo3bzRLSHNOZ1BuVXFKcGNzNjU3K3hPald2dnRnYm9mYVEvUzBoczlpM1VW?=
 =?utf-8?B?a0w5THdodG9abjNTUTJZRUpuckJBSVY0c3pSVjMxNWtmQ2ErUTZzTUJNQWdF?=
 =?utf-8?B?Sm92TWlZeTZWU3BsN3RJY1ZGdHNHWERnSFpoZEJ6WnVXU3B0VVBtS216WDBD?=
 =?utf-8?B?bmwrd2xGMitMaHFCL05pM0Z1aHBUejEzVjlNMEhwZVdVL3FiZFRrcVcxSG9w?=
 =?utf-8?B?U09XaGxEVHpzT3puNDd2dXhEZzg2TGpXbTUvZThuKzNkU3FpTXFSL1RMdGhn?=
 =?utf-8?B?c1Buek1FdlM1N2crdVkwWnIyT3JISzBNUGsxaUxURmdrMTBOMWdUNmdYM2lL?=
 =?utf-8?B?c0lKSEhGMDJ0amNja1VaN3ZCeThycktWUE5SQ2JyTVlNSDEwWnJsNDg3azJj?=
 =?utf-8?B?dmdVQ1pnZURNU0ZobFBwck1Uc284amRrYWFORE9UK0VGT0pjUENzd08vTDQx?=
 =?utf-8?B?cTVrSFpzdjI1aitHVy8vWVlJRGpPektXNWlmZmczMEhrSGp2MVdtZUZXMXE3?=
 =?utf-8?B?S3BoYW44bTVFNnNmTmNrU1kxdUdqL09hRGJoY0pSQXArSllGclNRTWZ1bEZM?=
 =?utf-8?B?UVlQT3Q4blR6OXdxbG5CZjcrazBWb1FKd2F6UkJpUE9NajRrckhWVGJvNmE3?=
 =?utf-8?B?UFR2T0N4M3ViMVNZZkhadUZobFRwVGZZSDRnckZGb1QwdFZ3V29SQS9YYmdP?=
 =?utf-8?B?Nk5kS2lKYnVsVmVaQURWVUIwZUdZcWFFdG4rbGd4QUxvcWVtdHg1OTBjMjZU?=
 =?utf-8?B?QnhQNWtWM3p0eERxQ0NtK3BEQ3VtUTJibUcyRWxSQUZ2Vnp6TXhOTitxRDho?=
 =?utf-8?B?NDhldGZGS1Qvdjdtb2FFbUtkRndFb0NxS0xHRUxUbnVSL2lGdStOWTlkeHZo?=
 =?utf-8?B?ZlhkdElGVjRNZy9pMjBoTjhKdkJjWWoxTFU5MDd2T3NUU1lhTEFidGtHTW5Z?=
 =?utf-8?B?MnlRa2RmcWZzS2pHUmtFdDh4SW5vOFNmVzZCbXExSEdoV3FYVHVpb1JqSzF0?=
 =?utf-8?B?dWFwSlN5WHYwTVB6dVhXUUdjQmw0eFI3ajhROHFlM0tRR0lDZDhEMUFWbTNy?=
 =?utf-8?B?M0FiNmcrRHpkb01YUUg0SUtPTFEwQXJrTDIwZXdadmdvTzJFcDlYM0pwdWtU?=
 =?utf-8?B?ZlcyNWhGS1JUaFdxbzJRS293M3laU0hMR2pubnJ5ZVoxV2lHUXd2N21KRFRD?=
 =?utf-8?B?VWNQUFlHelR0bzBwZVF0RVNNMC9hVFRtYXY5UmI3Rktxc0FMRCtuQVZsQi9R?=
 =?utf-8?B?d2piUnU3WGtMSlpUZGY1RVpLbWJGelBOYmhVUHRGb2k2UFVIQXlIYjBXNUJn?=
 =?utf-8?B?ZXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	svaMjZps6GYKAorh+bTP9Y0xOCfDqqPRkJ5rvrEahqLt+ePlA3cTXSImpzbp7R4PM8s1EVgDbthvt/46VYWHFXOHsBcbVk36xFnigz8FhsS8dnxOmwC9soc4K4Znn3APpXQswY8rkdj5a9/aPocIg3mT3plyEovGq4xI5ChTr3V/9UCoXAu0foHmxHoC+fLMiCJI8HpNg3O+PSFTM2mAxaO471hC1glR7cgZOw5LhHM+mO7YBJFDsJnlzbqUy7qGdR0tZAt3NXo26wENaZr6lq3Wg2Ojaf5slqsA90nFrWzssJl/8F8Cph+WtRS1FDctRZJoLVlaRiDmv2Yiv0uP4IRb3JT91/eo5UPCjP4SWVx+GTft5TBl+FG3oH5F/Zcs0u/LczfWAHOzLaGeP6WvdM8XcYqwEJeJRnIkeWQQjfgj+gdhwMaBEiAQi71dxUgLHN74cRFSzJbifFNLFlQK/Dd/2elxvWEG5/bBBoaPcgKFirjlYIHxQGYM+xgogqiJjj5ey3e7HwftQhIMW54m0fVDporKKANkJc8PSOb5kinQuqrfG7eK8v0MKBO17WteoNWE92EjOpHO0aFFWJ63bhh+Ixjcmv0IJZ6pytGimL8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40745a9f-8976-4634-1c0c-08dd1876d174
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 17:27:55.7308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qSQ+HRA9mWbRMO6acuyVZ0sLyPM49+1e0jAsZzENCScEr7+eCYtCoOXDkrgKdg1s0QrISvbSNTT2FZNVX2IguQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5213
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_14,2024-12-09_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412090136
X-Proofpoint-ORIG-GUID: K8ULiNQI-v-7hIsrmxADrRa6Amnsl6nC
X-Proofpoint-GUID: K8ULiNQI-v-7hIsrmxADrRa6Amnsl6nC

On 12/8/24 7:41 PM, NeilBrown wrote:
> Now that the connection limit only apply to unconfirmed connections,
> there is no need to configure it.  So remove all the configuration and
> fix the number of unconfirmed connections as always 64 - which is
> now given a name: XPT_MAX_TMP_CONN
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>   fs/lockd/svc.c                  |  8 -------
>   fs/nfsd/netns.h                 |  6 -----
>   fs/nfsd/nfsctl.c                | 42 ---------------------------------
>   fs/nfsd/nfssvc.c                |  5 ----
>   include/linux/sunrpc/svc.h      |  4 ----
>   include/linux/sunrpc/svc_xprt.h |  6 +++++
>   net/sunrpc/svc_xprt.c           |  8 +------
>   7 files changed, 7 insertions(+), 72 deletions(-)
> 
> diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
> index 4ec22c2f2ea3..7ded57ec3a60 100644
> --- a/fs/lockd/svc.c
> +++ b/fs/lockd/svc.c
> @@ -70,9 +70,6 @@ static unsigned long		nlm_grace_period;
>   unsigned long			nlm_timeout = LOCKD_DFLT_TIMEO;
>   static int			nlm_udpport, nlm_tcpport;
>   
> -/* RLIM_NOFILE defaults to 1024. That seems like a reasonable default here. */
> -static unsigned int		nlm_max_connections = 1024;
> -
>   /*
>    * Constants needed for the sysctl interface.
>    */
> @@ -136,9 +133,6 @@ lockd(void *vrqstp)
>   	 * NFS mount or NFS daemon has gone away.
>   	 */
>   	while (!svc_thread_should_stop(rqstp)) {
> -		/* update sv_maxconn if it has changed */
> -		rqstp->rq_server->sv_maxconn = nlm_max_connections;
> -
>   		nlmsvc_retry_blocked(rqstp);
>   		svc_recv(rqstp);
>   	}
> @@ -340,7 +334,6 @@ static int lockd_get(void)
>   		return -ENOMEM;
>   	}
>   
> -	serv->sv_maxconn = nlm_max_connections;
>   	error = svc_set_num_threads(serv, NULL, 1);
>   	if (error < 0) {
>   		svc_destroy(&serv);
> @@ -542,7 +535,6 @@ module_param_call(nlm_udpport, param_set_port, param_get_int,
>   module_param_call(nlm_tcpport, param_set_port, param_get_int,
>   		  &nlm_tcpport, 0644);
>   module_param(nsm_use_hostnames, bool, 0644);
> -module_param(nlm_max_connections, uint, 0644);

We've discussed deprecation and removal of items from /proc/fs/nfsd
before, but removing a module parameter seems like it needs to be
handled with the usual deprecation schedule?


>   static int lockd_init_net(struct net *net)
>   {
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index a05a45bb1978..4a07b8d0837b 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -128,12 +128,6 @@ struct nfsd_net {
>   	seqlock_t writeverf_lock;
>   	unsigned char writeverf[8];
>   
> -	/*
> -	 * Max number of non-validated connections this nfsd container
> -	 * will allow.  Defaults to '0' gets mapped to 64.
> -	 */
> -	unsigned int max_connections;
> -
>   	u32 clientid_base;
>   	u32 clientid_counter;
>   	u32 clverifier_counter;
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 3adbc05ebaac..95ea4393305b 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -48,7 +48,6 @@ enum {
>   	NFSD_Versions,
>   	NFSD_Ports,
>   	NFSD_MaxBlkSize,
> -	NFSD_MaxConnections,
>   	NFSD_Filecache,
>   	NFSD_Leasetime,
>   	NFSD_Gracetime,
> @@ -68,7 +67,6 @@ static ssize_t write_pool_threads(struct file *file, char *buf, size_t size);
>   static ssize_t write_versions(struct file *file, char *buf, size_t size);
>   static ssize_t write_ports(struct file *file, char *buf, size_t size);
>   static ssize_t write_maxblksize(struct file *file, char *buf, size_t size);
> -static ssize_t write_maxconn(struct file *file, char *buf, size_t size);
>   #ifdef CONFIG_NFSD_V4
>   static ssize_t write_leasetime(struct file *file, char *buf, size_t size);
>   static ssize_t write_gracetime(struct file *file, char *buf, size_t size);
> @@ -87,7 +85,6 @@ static ssize_t (*const write_op[])(struct file *, char *, size_t) = {
>   	[NFSD_Versions] = write_versions,
>   	[NFSD_Ports] = write_ports,
>   	[NFSD_MaxBlkSize] = write_maxblksize,
> -	[NFSD_MaxConnections] = write_maxconn,
>   #ifdef CONFIG_NFSD_V4
>   	[NFSD_Leasetime] = write_leasetime,
>   	[NFSD_Gracetime] = write_gracetime,
> @@ -902,44 +899,6 @@ static ssize_t write_maxblksize(struct file *file, char *buf, size_t size)
>   							nfsd_max_blksize);
>   }
>   
> -/*
> - * write_maxconn - Set or report the current max number of connections
> - *
> - * Input:
> - *			buf:		ignored
> - *			size:		zero
> - * OR
> - *
> - * Input:
> - *			buf:		C string containing an unsigned
> - *					integer value representing the new
> - *					number of max connections
> - *			size:		non-zero length of C string in @buf
> - * Output:
> - *	On success:	passed-in buffer filled with '\n'-terminated C string
> - *			containing numeric value of max_connections setting
> - *			for this net namespace;
> - *			return code is the size in bytes of the string
> - *	On error:	return code is zero or a negative errno value
> - */
> -static ssize_t write_maxconn(struct file *file, char *buf, size_t size)
> -{
> -	char *mesg = buf;
> -	struct nfsd_net *nn = net_generic(netns(file), nfsd_net_id);
> -	unsigned int maxconn = nn->max_connections;
> -
> -	if (size > 0) {
> -		int rv = get_uint(&mesg, &maxconn);
> -
> -		if (rv)
> -			return rv;
> -		trace_nfsd_ctl_maxconn(netns(file), maxconn);
> -		nn->max_connections = maxconn;
> -	}
> -
> -	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%u\n", maxconn);
> -}
> -
>   #ifdef CONFIG_NFSD_V4
>   static ssize_t __nfsd4_write_time(struct file *file, char *buf, size_t size,
>   				  time64_t *time, struct nfsd_net *nn)
> @@ -1372,7 +1331,6 @@ static int nfsd_fill_super(struct super_block *sb, struct fs_context *fc)
>   		[NFSD_Versions] = {"versions", &transaction_ops, S_IWUSR|S_IRUSR},
>   		[NFSD_Ports] = {"portlist", &transaction_ops, S_IWUSR|S_IRUGO},
>   		[NFSD_MaxBlkSize] = {"max_block_size", &transaction_ops, S_IWUSR|S_IRUGO},
> -		[NFSD_MaxConnections] = {"max_connections", &transaction_ops, S_IWUSR|S_IRUGO},
>   		[NFSD_Filecache] = {"filecache", &nfsd_file_cache_stats_fops, S_IRUGO},
>   #ifdef CONFIG_NFSD_V4
>   		[NFSD_Leasetime] = {"nfsv4leasetime", &transaction_ops, S_IWUSR|S_IRUSR},
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 49e2f32102ab..b77097de5936 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -668,7 +668,6 @@ int nfsd_create_serv(struct net *net)
>   	if (serv == NULL)
>   		return -ENOMEM;
>   
> -	serv->sv_maxconn = nn->max_connections;
>   	error = svc_bind(serv, net);
>   	if (error < 0) {
>   		svc_destroy(&serv);
> @@ -954,11 +953,7 @@ nfsd(void *vrqstp)
>   	 * The main request loop
>   	 */
>   	while (!svc_thread_should_stop(rqstp)) {
> -		/* Update sv_maxconn if it has changed */
> -		rqstp->rq_server->sv_maxconn = nn->max_connections;
> -
>   		svc_recv(rqstp);
> -
>   		nfsd_file_net_dispose(nn);
>   	}
>   
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 617ebfff2f30..9d288a673705 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -72,10 +72,6 @@ struct svc_serv {
>   	spinlock_t		sv_lock;
>   	unsigned int		sv_nprogs;	/* Number of sv_programs */
>   	unsigned int		sv_nrthreads;	/* # of server threads */
> -	unsigned int		sv_maxconn;	/* max connections allowed or
> -						 * '0' causing max to be based
> -						 * on number of threads. */
> -
>   	unsigned int		sv_max_payload;	/* datagram payload size */
>   	unsigned int		sv_max_mesg;	/* max_payload + 1 page for overheads */
>   	unsigned int		sv_xdrsize;	/* XDR buffer size */
> diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
> index 35929a7727c7..114051ad985a 100644
> --- a/include/linux/sunrpc/svc_xprt.h
> +++ b/include/linux/sunrpc/svc_xprt.h
> @@ -105,6 +105,12 @@ enum {
>   				 */
>   };
>   
> +/*
> + * Maximum number of "tmp" connections - those without XPT_PEER_VALID -
> + * permitted on any service.
> + */
> +#define XPT_MAX_TMP_CONN	64
> +
>   static inline void svc_xprt_set_valid(struct svc_xprt *xpt)
>   {
>   	if (test_bit(XPT_TEMP, &xpt->xpt_flags) &&
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index ff5b8bb8a88f..070bdeb50496 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -619,16 +619,10 @@ int svc_port_is_privileged(struct sockaddr *sin)
>    * The only somewhat efficient mechanism would be if drop old
>    * connections from the same IP first. But right now we don't even
>    * record the client IP in svc_sock.
> - *
> - * single-threaded services that expect a lot of clients will probably
> - * need to set sv_maxconn to override the default value which is based
> - * on the number of threads
>    */
>   static void svc_check_conn_limits(struct svc_serv *serv)
>   {
> -	unsigned int limit = serv->sv_maxconn ? serv->sv_maxconn : 64;
> -
> -	if (serv->sv_tmpcnt > limit) {
> +	if (serv->sv_tmpcnt > XPT_MAX_TMP_CONN) {
>   		struct svc_xprt *xprt = NULL, *xprti;
>   		spin_lock_bh(&serv->sv_lock);
>   		if (!list_empty(&serv->sv_tempsocks)) {


-- 
Chuck Lever

