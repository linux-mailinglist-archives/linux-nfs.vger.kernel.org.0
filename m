Return-Path: <linux-nfs+bounces-8426-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2247D9E861B
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Dec 2024 16:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1965188221D
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Dec 2024 15:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73ECB1531F0;
	Sun,  8 Dec 2024 15:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f0IfrcXE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Bb+1dP3f"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2427D14F9FF
	for <linux-nfs@vger.kernel.org>; Sun,  8 Dec 2024 15:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733673521; cv=fail; b=IkT3KiELKULZWKnys8R6zWYDl6qjC9PI0DKQKEZLZQoqh4HPY/SozDzOFTC8L9B5bDNCN85FfYNrIowpghC55ux6sh2GIaYEtWs1hoqQNJtAApXO+fVr6qSgPlleIV/XtPQAd9Rt8Xkc2sG08UokchNCw5VzNFxTUAZZ/Rth45w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733673521; c=relaxed/simple;
	bh=jGYEaU/oiQQBy01o8vqAuYH908x/o+WkTO+heCJGvGc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NpNf+Ffvez1DVWAxhVQRbMg1HLQv6nQXdRsFw8T8KOJZYZp/nWcnjRcnwsi1t+HLha5Uii59YX1AzFyhLn5XzUcn3UQGUTT65G1H0pgOAIBpU2VO/kFfjkwLoKkgIKEdyCZjRPNgud9Kip7zzadkbRMKh9V2yc2axyHaArdwu38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f0IfrcXE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Bb+1dP3f; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B8FP15j016163;
	Sun, 8 Dec 2024 15:58:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Fxc2V544WxPRHF4UGFiXklXpPCMt/ytkPoakYtAn2rc=; b=
	f0IfrcXELWVfgySM8aJHM7ci0Nl5M2JuqEmksra0gVdtaKDm1SYdlqf4huOT0aAT
	5HMlX9LdfmQqJDqYUNnVIB3zRGIRFa74OPzw/+j5Ml4Nl1s3jsyz2YD7Ax0fCMUa
	P30cjOI5QTEGysLc2YBEpoam2vdMZYs9HRvecN/Kgod5t3SeQUZZxlmvrkVM8wsX
	5gm3ddUzmQ+oqPJGGZFLgZlAohsjnEGh9dJU25O34P2ojJGu7QFnN7XJT6symhM4
	xh3HKgSRvp6Xlp+xVtCGbRzE8sJt5vm+PAkvcfhQNHDtN7zOzsLIFkOKaM4W33ps
	NyRZMdfZhwrKrQEnr+Tz1A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43ddr600ut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 08 Dec 2024 15:58:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B8DXZpM020612;
	Sun, 8 Dec 2024 15:58:31 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43cct6112u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 08 Dec 2024 15:58:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EpjQx1oiJZ0z/M7nn9Si5EgO3n1STc8LltOUmQ3haSHmBvYMufSjrw2OSXdjJvrS+82TBy/J7mSBaAp35IVLua3ePqreeOrdk62FogVdUXLkIQEFtl4NjPPZmcJ/jMasdCtY+EwfFQHl71V3kD81CThc1gAxUTpjruXBXIuNnGy3Mp5rZfj7ymNQZ2Xkpcd+qKs4HTyUk/Bwa74K+XuIW3LG8mgu2L1k8ttVKa+MbBWnmIdKaYux3dFV6iFGluldQHPzHRYMnH/Va4UdloS/quH1WivUHTvkKP/0zBcpKbyuUGmP4qoFrt4IHkyjPlf4TkAj2mOd29MzZgUUZjbbEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fxc2V544WxPRHF4UGFiXklXpPCMt/ytkPoakYtAn2rc=;
 b=flYMSOPi/YeVKP7eFSp1b9btBhfFO+rjM/ybX6cOey8vjLI3AZ1xKWv1/OP+VCkNKfkBkiz5LO5ZOTC673vuBOG4pXuVmfdjZzb2YTWSn3t6hWoEsI/VIkoZLsRrZi7W5XtICtWMyWsLxRdIWOn1/mG3rUrPZIpqXNkYTPRCxruDJqIwtw5FiGQZpLKEF7B7lPzIQEfQIOPcsPsCaMeplr5qHSk6zYabIwbf6ENVyNdJsgsO2K5XmI7TmLJYSvn0ADaJZJr3TUVyEn5p6EvWkqZyDiLlzjTnzSfhKiDoXZu8zMTMVW9KszUugfgkfF4TnNmwIBRINnlku89utUAaQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fxc2V544WxPRHF4UGFiXklXpPCMt/ytkPoakYtAn2rc=;
 b=Bb+1dP3faDmpju7QtZcwzGrZtCZBahaTNMTJK5Ix8f0c75V2iHVn3aX0WLPD59GhU+QBPbmX6RFDU4MB7/TDqRTqZUfkliB3EpeSGwga0PMkVUaozlxbrUytK86RTNqz7Qwc7b6guZiZe6CQrSSHofQFXpnBm47Z/3xSEvHJf1M=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5036.namprd10.prod.outlook.com (2603:10b6:610:dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Sun, 8 Dec
 2024 15:58:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8230.016; Sun, 8 Dec 2024
 15:58:27 +0000
Message-ID: <4be7ab28-3ca1-4815-9e9d-9c3a06e126b3@oracle.com>
Date: Sun, 8 Dec 2024 10:58:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [patch] mount.nfs: Add support for nfs://-URLs ...
To: NeilBrown <neilb@suse.de>
Cc: Roland Mainz <roland.mainz@nrubsig.org>,
        Steve Dickson
 <SteveD@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <> <cce34896-f8fe-42fa-a8aa-4a26cd42498c@oracle.com>
 <173362855836.1734440.12419990006245500946@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <173362855836.1734440.12419990006245500946@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0026.namprd07.prod.outlook.com
 (2603:10b6:610:20::39) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB5036:EE_
X-MS-Office365-Filtering-Correlation-Id: 31553700-c956-4bd7-79bf-08dd17a12774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXVSRjV0d3NaSnAwWmpJL3pTY3VBVXM0OVZ3UVB4WW13MkV3K2g2Wk5mMTkr?=
 =?utf-8?B?c0Zra3N4cldWUFlXb3oyaER4THZlWnFHbEl0OFBMSjVSY1ROUC9kQlNySCsz?=
 =?utf-8?B?RFA2VXRHK2o5Z2lEWUxZK3QySGExb2U5UFgxOVNDemIxc2RSMTVWdWlrUGs5?=
 =?utf-8?B?dWlzeWdFVnZjTit1U0ZES0xIWVA2K3JoeUpCMWJSN0NURnh6T1lSUDUyclM2?=
 =?utf-8?B?YmRLa2E1eGY2U2lIRk5UK25aVUpiUERkdVhNdElrZlBJTlptMVZsazZnSy9x?=
 =?utf-8?B?OXAwS2JSemtiZFBlU25yYWxkSWJMRWZTcXp0dU53U280OHBzbWFOcUdYK09p?=
 =?utf-8?B?bE1uQjEvWnhOdmV2ZEJPSVBvanIvMUtBanhCa3c5ckVtTjlwd1I0R0U4VkZv?=
 =?utf-8?B?eDlWM0t0ZXFYemRnTWs2NEswM3A5MlhCb1RoTFkyaVpta0VyY1pwOUw0MGV4?=
 =?utf-8?B?S2RVV2hGQklvOWVjVlYxL3JFWkJiYUlWMGp1bkhJblF3bzAzVlZ6RG0vNjc4?=
 =?utf-8?B?UE5VSGdXaVR0Ti82SEVwVmdZemExNHVGb0lLd2pJUFJkTTlHOVhsSU5VQXFG?=
 =?utf-8?B?RzlxaDBuWFhsVTlRZW9xOHRFeTFUb2Uwb0hBaVZ6cjJUdFc5S3dHVVZSa3Vt?=
 =?utf-8?B?WDk2dU5wTW9PNGZQYjdDWWdTQmZOY2sxV0FwMUxFUHAwSUduS0tuNk1uN2o1?=
 =?utf-8?B?RkNha0RsM2U0azhzTGtrZ2VacXFyTnFIRWlCcjM2aVZ3UDhtRkdZeGJUdGhL?=
 =?utf-8?B?Wkc0dzd3Mk51NXhwUGptdm1EVGx2S3pFZGRCT0w3NVJyVE4xUFZKRVBBTTVN?=
 =?utf-8?B?bndpaWNtZzRobFhFQkJhaDBuL2JVbnNZQ3VsUmdjOTFWaVhDTU16Ynd6T25T?=
 =?utf-8?B?bVlDWGtBMXpnODFodnZ1VTV6UkN2cThXaDJVVGM4QWZWaDVxc24vYTVkTkt1?=
 =?utf-8?B?NHNsNEcvbEtDRmh6WjdKbjhTRTRDOE5LTlR4ZjFObXRuSFhZV1FEVUlrVG9q?=
 =?utf-8?B?ZUIxYUxUTG8yTHBzSldOVHBvVTNnUUkwcTRvWDVJRVBTcEtTNWJpMTRpRjdi?=
 =?utf-8?B?dUcwUXBnejNKRjZjVkVFNkdLRFFpQjhtOXdzNUpyMFBvZG1SeStQWmg4SDVN?=
 =?utf-8?B?emdrRVY0bXFnb0NvQ29KbkZtUDNpR2UvZDVwTjcwZE5FNXozeTU0U2hnZVRE?=
 =?utf-8?B?MWlKelBDY1pCY1BEV1ozQ2sraWN3eDhvNG5KczVuRVpyeVNheVVPQlNibGFr?=
 =?utf-8?B?bHY3ZFBpdmRnbXpteVh6MTA4Z2M4aWgrRHg3ZW0zL1B6a1NlWHVLeVhuVXlZ?=
 =?utf-8?B?eVNxbnNza3pyajJuVTFXSEp0cDFwRmJzR0pYS082MUpiOXF2NzQ4L20yQlp6?=
 =?utf-8?B?TTF2VDUraUd2S09ycjV5RzRKTWdIYWdHM1pxY2NtUmxQVWN5NTRNTk4vejNy?=
 =?utf-8?B?Q29Fd01Ucm9hc3o2dENIdXR2eFJyYkJka1ozNWtzbXJYRUVDbE1YT2pLUHdZ?=
 =?utf-8?B?T0FieFd2ZGF0cExUdFd0UzA0Um5YS0JUSFpZOXdCcUVqeW5MMU8yaVNweTFT?=
 =?utf-8?B?TDQ0czZ2bllOQU9DU3duVG12anZhZ1hVZGNSK01DcklYa1lRWmFtQWdyeWRF?=
 =?utf-8?B?ckY2S0dhZ0hJUHdYYXFuY29kOEdCSmR6anJySWZxOHR1b3JXeUNRWmUyZzFH?=
 =?utf-8?B?MVdNbnZlMktSVkdWU2dLMDlUTjltenFzK1RzUWZzcmVaeTkwajhINWhpa0hm?=
 =?utf-8?Q?rH2zgx99J6SQ0HXHv4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0FtVWxpa3lVN2w2S0hHcXd4Ujhtd0ExblQ1L056ZjhtdmxlaVRRLzhiN3V6?=
 =?utf-8?B?WmNSNFk0b1YwOWdrZW9jQ0N4SWxRS05TWld0RGZ0TnpvbFdPVkZtZzN4OWcz?=
 =?utf-8?B?REMzVWdRNytac2c5NTBXYUFZSWluR3R6V2pqMGNmNHZkeGtocVNaK0h1N2hs?=
 =?utf-8?B?STNtVjJ6QjJrQlBBMzkyTU1pcWFZN2RqTXc1dEhuQUF6ZVNHZ3pzeXF5WEZi?=
 =?utf-8?B?RlJoT2s4N2Y4TEhKTGJPdENuTHQrZ2FWa3JGTFBpbWgxN3YvT2ZKdFcvMjQ0?=
 =?utf-8?B?NkxQTktkaFJTZ29RRmVUK2ZMOGdlWU5ReUN0NnVvcTlJOVZtak1HM2Z6cytj?=
 =?utf-8?B?b0NTNEdaaFZPZGVYaVJndEVmbEVDbzExM0lQOUFuZ09pRlQ5Tk9TQUk0dnpj?=
 =?utf-8?B?bC92U0NnU1hCbzZGT1ZoNExMZUVtL2NPRDBnUnYvZVFOWDluampjbmo1UkRl?=
 =?utf-8?B?MVkrYnJxY1l4SzlmTW5VUkFYUWJ0cHhtQXU0bHJNanhUZGZVUXZISmtkc3Fh?=
 =?utf-8?B?bmdLMU5qMFlZd3B0YTQ2aU8wZVJyOTBFZXYwUStuMklVNFIvalpqUk41K3ht?=
 =?utf-8?B?aTNZb0x2UWNFdVA4OGVBc0thYUlXK01lOXlIdnhUY3JsR2MzQzNpNmVjcGQz?=
 =?utf-8?B?aHd4dWZpaFVDUGlqTjZiS1lzWDliWWJHelJmUzZXeU8rbDg4M1pER3JyZG9r?=
 =?utf-8?B?ZENMZlZEd3Vmdmt6WjlvTkdBWUtBSWptclYwMG9JMU1PbmlkUzFKTEJLK0gw?=
 =?utf-8?B?d0tncHFlUDRsQlZPQ1JabW4zT0dhMTlZcE5QUFgvWjAxWHlWR00xUXNMMlVQ?=
 =?utf-8?B?RWJOV2Y0YTdwRGt6NnJac3ArREhudU16SUtPMXpUQlU3TkhETVFoVnJ1NGlL?=
 =?utf-8?B?VmVaQU80YkovUjd4MGxlRWZGN0ZYL3QvVGIxZmhvQ0RPYU1zZzIzZjJ3MjNR?=
 =?utf-8?B?c3NHYmhNM0dycVpKZEpRNGpXMnA0OFZIUVFDaFN4Z044d2JuVUg2clRJQTdY?=
 =?utf-8?B?bEE5Y3NZTDBNTzN2ajUrUGhSQVY4WlVlbnVsODB0S3Z1N2ZCajRaMzVOUW1B?=
 =?utf-8?B?UkFINVlZK3pqM0xXNU9tdSs3U0hJMW1MSUtpMlVHbElyV0UzSm9acVM3dlFr?=
 =?utf-8?B?UDVOZE9IVjJIVjNxbEk3SnNQb0FxSnQ0Vi9NTW9qd2xGQlhIbUVjVyt2aFBY?=
 =?utf-8?B?NHhwZkl3ZGdoQ1lJcDF3d1BCb3Q2WXVVeExpS0cxZ2lSZXVTd3dycWhKUjFm?=
 =?utf-8?B?eFcwdjRVbUNLODJUOTdLL21VY3JEUW9QeDZSMXBJVnZWb25uV2dsTS9VU0pK?=
 =?utf-8?B?dnkrZVJJUmM5am9xbVpYaUpvb29RVlNiM2E5MU1FeDNOWFBpTjZ0RnhzM1Bh?=
 =?utf-8?B?ck1YeEUxdVpnalBTU1BoWDl2TktuelMzK014aDhBWlNFY2hzTnhaR2pnZzZh?=
 =?utf-8?B?c2tnUGx6c25ERmtVK3F1SjFzUGVNYVhoaGxtRllJaUt2TjY3ajVUMlAzVDUw?=
 =?utf-8?B?Z0hENWxLdDhUalppcFlZZ2hhaUw1cmdhQjgzUytEL1FjUFVMVXNwR24zYjli?=
 =?utf-8?B?OXlxbm5BYWE5OU96clE4cTBZYlYwR0svNHkzUmxzWGZrNVNMeW1NYmZxQWpK?=
 =?utf-8?B?TXo5TWg1S0g1d0xLUDRmWnlHNm4zcTR4SWxScktkcytvOU9JMTRSYTVUNURK?=
 =?utf-8?B?UER2YWVnVm1jb2xSWVVFelZpQTNyc09rc2pEMXpndW5Tcmt0c3I1MGQ0aFIv?=
 =?utf-8?B?aytRdEVlRGdUWFZqZlJYaGtjeGRnS0FKWWJQVEtCOXBnWmJLTU0zMXdEemk4?=
 =?utf-8?B?NkdDOUJ5QnUwL293L3JBdVQyQVBkeG0xa0lxbnBuM1hMVXgvNVdCWkVNbHZL?=
 =?utf-8?B?MzVnbnJSS1hyNGMveHVsdjA4RUVGRHFJOU9raCtkcmRHTGY2emdXc0ErQVdt?=
 =?utf-8?B?Z3YyOUloMGFkMG5XMUR1dDczdXg2ZmZLYWsxMG9XYk42a2hIQ2lMdkttdE4v?=
 =?utf-8?B?MTFWTWtWdFdQMFJkemNxSlVqZGtLN3dOVXBQamJKRkV4TUlQVHZpUE0vbDJU?=
 =?utf-8?B?V211VUxyRU10SHNjQjF2aXFBRDhDWXRhLyt5clBxT1VoUWw0b3NyNGsyNDVp?=
 =?utf-8?Q?JdyuVbyn9dtSo3DkoyVlE3/i/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QLPjaLofsNSAYnoN+nSDDMsdwAojwLOfmbjAtU5r3jOtd1o3k57HaMpLzRSDJlPpx/2x+9HHLB4/ylS2U3N5/ZSpeAQZySAZVtzdBMt0dzmK56red6ltvbY1Q5oCmDlhzXD0pLvb4/Wo2whvTvF9FUFmEyPBbFyNzf6OOhbrKHXc3sHj7n9f8KpBsZNdbBFjNViiAp71ZugEbRPP7f46K0b/7TV/VGJGs3ZTDqghhg1sDr26OuRZUbGexF5FJMYDPXfQWdYLg63Xrjg4fxhotUnfMl4+ByjEc+XdwysgfVSJcV6zIK6qxNPZcl/xZAVc9ncroyswlSHSbnyMYMO04AD8ezPpzqFqOrte3soLXq78jzUij2SpRKaxBZcZAgxI/ff8bNjdF3MfXQxP2SQHg/EvcLzQYuFb9tkY7D2WjaQQvrPY4G/TZNS4O4aZH2lvAZsssL4xO+ZN5JDNTxcBDiYsRHyxhuo++ZrSvaZ98E7JMOQmkE1zNZCtUaf44TXjEOtD70Q5EJy+Mr1WxuMt82vIIMhQIUTH5B4scXS+5Ui3OzHWuLrfmUVh28laMAgU/SgLXp1ONocefqQ3apvfLAP3pqI4del1wjFiVBXF+UM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31553700-c956-4bd7-79bf-08dd17a12774
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 15:58:27.7891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OqW9Sc94tNA6fzC32ZJfDgGiEM/kzp2S+pN8ASDaI/0CCGT2AVnSBDdT4QQjgoO6sil6T1D4LeJzIOovZhlXQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5036
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-08_07,2024-12-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412080133
X-Proofpoint-GUID: hSU8Zl_LfhBHKtXmg8tcI5t4DXR7XuBt
X-Proofpoint-ORIG-GUID: hSU8Zl_LfhBHKtXmg8tcI5t4DXR7XuBt

On 12/7/24 10:29 PM, NeilBrown wrote:
> On Sun, 08 Dec 2024, Chuck Lever wrote:
>> On 12/7/24 3:53 PM, NeilBrown wrote:
>>> On Sat, 07 Dec 2024, Chuck Lever wrote:
>>>> Hi Roland, thanks for posting.
>>>>
>>>> Here are some initial review comments to get the ball rolling.
>>>>
>>>>
>>>> On 12/6/24 5:54 AM, Roland Mainz wrote:
>>>>> Hi!
>>>>>
>>>>> ----
>>>>>
>>>>> Below (and also available at https://nrubsig.kpaste.net/b37) is a
>>>>> patch which adds support for nfs://-URLs in mount.nfs4, as alternative
>>>>> to the traditional hostname:/path+-o port=<tcp-port> notation.
>>>>>
>>>>> * Main advantages are:
>>>>> - Single-line notation with the familiar URL syntax, which includes
>>>>> hostname, path *AND* TCP port number (last one is a common generator
>>>>> of *PAIN* with ISPs) in ONE string
>>>>> - Support for non-ASCII mount points, e.g. paths with CJKV (Chinese,
>>>>
>>>> s/mount points/export paths
>>>>
>>>> (When/if you need to repost, you should move this introductory text into
>>>> a cover letter.)
>>>>
>>>>
>>>>> Japanese, ...) characters, which is typically a big problem if you try
>>>>> to transfer such mount point information across email/chat/clipboard
>>>>> etc., which tends to mangle such characters to death (e.g.
>>>>> transliteration, adding of ZWSP or just '?').
>>>>> - URL parameters are supported, providing support for future extensions
>>>>
>>>> IMO, any support for URL parameters should be dropped from this
>>>> patch and then added later when we know what the parameters look
>>>> like. Generally, we avoid adding extra code until we have actual
>>>> use cases. Keeps things simple and reduces technical debt and dead
>>>> code.
>>>>
>>>>
>>>>> * Notes:
>>>>> - Similar support for nfs://-URLs exists in other NFSv4.*
>>>>> implementations, including Illumos, Windows ms-nfs41-client,
>>>>> sahlberg/libnfs, ...
>>>>
>>>> The key here is that this proposal is implementing a /standard/
>>>> (RFC 2224).
>>>
>>> Actually it isn't.  You have already discussed the pub/root filehandle
>>> difference.
>>
>> RFC 2224 specifies both. Pub vs. root filehandles are discussed
>> there, along with how standard NFS URLs describe either situation.
>>
>>
>>> The RFC doesn't know about v4.  The RFC explicitly isn't a
>>> standard.
>>
>> RFC 7532 contains the NFSv4 bits. RFC 2224 is not a Normative
>> standard, like all early NFS-related RFCs, but it is a
>> specification that other implementations cleave to. RFC 7532
>> /is/ a Normative standard.
> 
> The usage in RFC 7532 is certainly more convincing than 2224.
> 
>>
>>
>>> So I wonder if this is the right approach to solve the need.
>>>
>>> What is the needed?
>>> Part of it seems to be non-ascii host names.  Shouldn't we fix that for
>>> the existing syntax?  What are the barriers?
>>
>> Both non-ASCII hostnames (iDNA) and export paths can contain
>> components with non-ASCII characters.
> 
> But they cannot contain non-Unicode characters, so UTF-8 should be
> sufficient.
> 
>>
>> The issue is how to specify certain code points when the client's
>> locale might not support them. Using a URL seems to be the mechanism
>> chosen by several other NFS implementations to deal with this problem.
> 
> If locale-mismatch is a problem, it isn't clear to me that "mount.nfs"
> is the place to solve it.
> 
> The problem is presented as:
> 
>   to transfer such mount point information across email/chat/clipboard
>   etc., which tends to mangle such characters to death (e.g.
>   transliteration, adding of ZWSP or just '?').
> 
> So it sounds like the problem is copy/paste.  I doubt that NFS addresses
> are the only things that can get corrupted.
> Maybe a more generic tool would be appropriate.

I agree. The cited copy/paste use case is pretty weak.


> How are people going to create the nfs: urls so they can paste them into
> the chat?  In there a reverse tool for getting them out?
> 
> Or we just just adding a hack to avoid "*PAIN* with ISPs" rather then
> getting the ISPs to fix their breakage?

I tend to think our administrative interfaces could be made easier
to use, over all.


>>> Do we really need the % encoding that the URL syntax gives us?  If so -
>>> why?
>>
>> See above. Character set translation issues.
>>
>> And note that NFS URIs are coming soon to other parts of the Linux NFS
>> administrative interface. No reason that mount.nfs should not also
>> support them properly.
> 
> Are they?  Where?  That certainly might be a good justification.

The nfsref command will need to take NFS URLs in order to specify
alternate port information in referrals. Tom Haynes is working on
the standards part of this, I'm told.


> nfs: urls were introduced precisely for WebNFS (as I understand it).  So
> when the post said "This is not about WebNFS" I had to wonder if they
> were really the right tool for a very different task.  Maybe they are,
> but I think comprehensive justification is needed.

I agree that the justification needs to be much stronger. The
i18n stuff is complicated and needs better explanation for us
mere mortals to understand.

That said, support for NFS URLs is missing in Linux anyway, IMO.
I don't think it hurts us to add it.


-- 
Chuck Lever

