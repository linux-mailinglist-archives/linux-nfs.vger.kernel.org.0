Return-Path: <linux-nfs+bounces-14778-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5D3BAA063
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 18:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AC6E3B1BB3
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 16:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9FF4A07;
	Mon, 29 Sep 2025 16:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FTEkeYoB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="soj/Lh4g"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20522FAC17
	for <linux-nfs@vger.kernel.org>; Mon, 29 Sep 2025 16:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759163877; cv=fail; b=VGz0EfQyp4PV8f+PxCuwvZy5SJIwTBgrWrmKlzHOyykL6bBdXUbWIMcYLQy3vwyhY8cJqad7Zdks1HjU02vwLGnvsuj+pIsKLk5R5QZ3cyeh4UU7uQVW97aGhCYt4ga15gdGPwZsnP6Abbru8Mm04P1bcnRaP1XZkZofsmsTF4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759163877; c=relaxed/simple;
	bh=o5XWFX2Rj6jv0CYf7eRA2BLMrOTyIJD3zeEffkcn7QA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mUDhzvWQoTwuTzluTAbyTICucoRnIs1IKm5wnTJzPaB8wwfMMaF+uox8Jqoc8Om5IJMDkAyavEMMk855fIias5sq+epximAvZoWy/AM5OceQkknIuzbSMAQuwVgF/5kLIsJDANbX/fhmBTrFM/5WBZksA7klQxdS8zwJrNH5VfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FTEkeYoB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=soj/Lh4g; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TG9x1B008074;
	Mon, 29 Sep 2025 16:37:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=lwsBcVsRtyuxRp6ERJlQVlPnkPmUui1anm7ax0ohUR8=; b=
	FTEkeYoB4fJsg3FYXRaiE2Iq8UqBPD5H7f8yikQA22PxUyj3IsLZYZwi3tKHZnGG
	51rkf1Z1oDpTCnp2sp38hgSnn41M+H4SNdoOObeJKJC/bdwgFuQqYpDK8HgIQylm
	VFaH4gBVPmc88xppqRW/wfFJQ3SzPTE3jCUETpe7M+jaS8JKEt0hlcQP6w8ROBgo
	Su9l1hR/GEbnS6FcKLAWpX9lPEGRNpBXNc5lpFEYTgiLFzZgEhKuQrDSvNoEfHhJ
	nA0v6bfjdCetaZP5M98Ty957CqL5sA4VP3EjveFKZ+nFb4CCAATswOLMPirY8rsj
	oVo7JZZE7Ab0Iw/fbeiS/w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49fwcsr1jq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Sep 2025 16:37:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58TGAfrC007188;
	Mon, 29 Sep 2025 16:37:36 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010037.outbound.protection.outlook.com [52.101.85.37])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49e6c7pfpt-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Sep 2025 16:37:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nr+AT0J8boKLGll6+7gtU8ODMcs0EGADBS/7ORgC9DYqF153xBJQNXRJZoG6lxVRRkPk+mJdsw+ecYW/vin3pY1rtIaV4vyysiVn+/lWJC5HDKpWo003vpWrZ069e4tPKbojtwdeKFwTeAKtkBLpZQsE0dVjlZY+hH2n04Ic5LdCj5Hb+5v4i2DOBx/09RgCOig2GSMq7nrjy3XPit+VoKTPfwdAcISw/lZ2O9pmIYM4MPZL9eua5eYd2HJ9bSD6Ze6yiZnSWrwdJcHG6MFIWPNs4CVITL0xsI6TPV0iG16iIDiPWtDFBmR4OX5fC/nAHkuvHWEVwaWiytkvSGtUdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwsBcVsRtyuxRp6ERJlQVlPnkPmUui1anm7ax0ohUR8=;
 b=AOgKXAvvduVkCKOyR3Jj3QVbFuyj9nNTQUODngog5mqcX0MTPqcIeal6fEHM0097VIKh7911Ta18jQUopdBAT481FJE3U3GqNJgqJ5Oz+cY3zyzyI0l5df2XHhldGQPGHJGL+Ze8aYOjHyxVVk8TuWcFSK5Q9VDjml8pMdr8zS6KMOKQHIG6wFDRHW8sMNR0f3Amb3T54PgaPLxO45F2s9ifyCCyjGhGpy/etGXdojkNUNA6yqPIKTXocQVvs0/hzMoWoWk25WMA5QVnnZPM9LRb6bJhrviWL+4n39HZDe99llWNW31LWrhPqYPLl80rOodYFTi5YXcFOP+J/cXczQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwsBcVsRtyuxRp6ERJlQVlPnkPmUui1anm7ax0ohUR8=;
 b=soj/Lh4gXtnzDJXOEybquYCyT/gdBuKzm1Y1NlQRqS1QRugEMCy3Urw7p0PprU6bRfkOkB+BDqx+gU/CdBV5PgmM2LFlrWhZLgUsllyOy4oCXyxbMx/fDQ20A0FObvaRlHYtS3JKaR2u2ObK3q74DAf7gS/P66EgCyT2nL1ZAPQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN6PR10MB8071.namprd10.prod.outlook.com (2603:10b6:208:4ef::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 16:37:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9160.014; Mon, 29 Sep 2025
 16:37:33 +0000
Message-ID: <55b3a52e-3ff3-4547-bbbb-61731132baf8@oracle.com>
Date: Mon, 29 Sep 2025 12:37:31 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] NFSD: Define actions for the new time_deleg FATTR4
 attributes
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <cel@kernel.org>,
        NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, rtm@csail.mit.edu
References: <20250910152936.12198-1-cel@kernel.org>
 <ec936c41-0047-4998-9e94-1998780ad1ea@oracle.com>
 <9257ac997712ecd141608d4814697c8c4fbec7a7.camel@kernel.org>
 <73257f96-8961-4667-8ae9-a1d0594bdecf@oracle.com>
 <728efd15288cfc84b19f4798a725b909757b3fe9.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <728efd15288cfc84b19f4798a725b909757b3fe9.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P223CA0009.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::35) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN6PR10MB8071:EE_
X-MS-Office365-Filtering-Correlation-Id: 74aa8d16-ed11-448f-a066-08ddff767d4d
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bW5DeVE3N0lobENpay8rZGpXUmFIQXFQb0ZIRnIxSFNPWFBteVhQbDV0ZkNV?=
 =?utf-8?B?b0w1b1NKcmVxdy9scUNhbUhXRktWZmpJNkpHSzB5Sm02RllLOFZGMlpNT3po?=
 =?utf-8?B?NGF5Y1dhSEdsMlBVTDYxb1NIMm95SkhHa09xOEF4T043dkpRV3puR3RwelFI?=
 =?utf-8?B?ZGRsR3lZUzRaeFZoaUl6MUVYcmIySW1aVTBma3pmdVJsd1cxQ3JCRjRJWklM?=
 =?utf-8?B?TGZLNnFlbkJ4cjlCSHo4UTlzeUxXL0ViQkx0U3pCMDVKUDYxL2crV1FWWUg2?=
 =?utf-8?B?WjhHVXdsVUg5Zldsc2l6RDVxWVRoTTFxZlVrVjRqYzQvL3lISXN6cnllcFBl?=
 =?utf-8?B?MDY3Z0lVTGZvbndob0U3UTRnbWZvdGJ5SjE2TVNkQ21QcUJHeVI1NlZRdExu?=
 =?utf-8?B?NHVyNzM1dFFIWThiQ0FDengwMUE2Q1pva2tHak5LcTgrajVBQXZRMjhDZHdv?=
 =?utf-8?B?UkZ2d1Izem1TM2x2Q2x5ODJXeWpWZHlZRytuQ08zMEUwWjJlZWhYa1prcHI4?=
 =?utf-8?B?NGJPcDBxL3R6TnhPSGduVG5HZFcrNnpHdjJYZjB1ZmxaMkxZb0ozQ2c1UUQ1?=
 =?utf-8?B?QkhVU0w4SFlTQWdxMEhnVHVRY2tFbFdBVVByYkk2bmcwek8yazc4akRmMWVm?=
 =?utf-8?B?TnZWYURCbVdjbEtCWjJpRWFSQUJIT0lSTnhXQlBuQk1IU1VRN0xvMHkzVWNn?=
 =?utf-8?B?NmI3VjBCNElITnRzcG90VWJUaVI4aEgzU3ZCVE1JdEpuZDFURERDVmNoV0p2?=
 =?utf-8?B?eXFmb1MyZmY4cmx1Mmw5R3dEWU9qcWlMOUFhaEpGY3JqMUNFRUxidWR6RGVB?=
 =?utf-8?B?dVg5U1VkcGp6Qk8xYjlQd2Z1dDJWWjhTSGhuSGRaK01HbS9tTG9IU09wTnlx?=
 =?utf-8?B?UzNwWWFNbmk0R2NiakRKMlgvb0t0ZlJMK0NWNk1YS3pteEc1RmlLWit0TEdL?=
 =?utf-8?B?aTRwcTgwNWRRSG5qNTRiZkI4aDFHVTZkZmZKbTFRUklIN0xjOC9rL2ExdzBa?=
 =?utf-8?B?bGJMWHhyTGluYTFtMWhQelJydlgyLzVFcWFEOHVPNHd0ejhaYVhTckpocm5k?=
 =?utf-8?B?cWg1NXlJdEVJOCtPQ09WdG5SR25VdFpKUFdJK2Q4V0pucUJBNmpGVnVvRVAz?=
 =?utf-8?B?M0lKVTQwWlhJcUI4UVREenFxa3Fnbk0yOU1hdUN4L0dnV05hcFJiOHJQclp2?=
 =?utf-8?B?OTA0K2Z6eVZMbDl0MUpaQVFoSlpNTEhUaTg1aTRuc1A3S3VkeDZNU2s3UnVu?=
 =?utf-8?B?aXcwcnRhaXhqckxZc2xWcTd4Z1I0a0c4SFlhZjFiZEpMUXVtekFWdHlQWEVM?=
 =?utf-8?B?V09MZnNJOGVtNUdZVDBPNmI5anFSd2d6dmhLWHpRS05PZlhBUnVidTRSMWFX?=
 =?utf-8?B?N0xucjVuV0ZYZlNpNGx6aFlmcXRrTm1iSDNFVUtqYzVnc2prNEhpcE9LSC9F?=
 =?utf-8?B?RklYK2ExQmVGYW5SRWJiZ211NFl6WkpWZTk0N3haMnM3T0hwbk1zcXQ4emc3?=
 =?utf-8?B?N3hHRStZSXM5VTBGa05ET0hXcFI1RkN3TzBoWHdZdW9EZklIYTJYMllWNW5C?=
 =?utf-8?B?MkkvbHdqRWhHYWlsL3FYQWhzYlk3RHFHZDFqZEpJUE9HN0pFYmNzbTg1SDU1?=
 =?utf-8?B?L3U4dnZ6Zmd3RTZzWmk0ZTRxMGFYVzM4bWNsdnVtdk5CcHRGOTBJRHlTd0o5?=
 =?utf-8?B?Y2Nha2w3K1FrZ0tkTlRnUTNjSE5jVUVjTnRSWlB6ZUZqWll5VytkaUlITXcx?=
 =?utf-8?B?T2EraFlhZlRTaVhOVE1uSW9mKyt1NDkxMnZoQWExOTU2MkhucW16N1FTOU11?=
 =?utf-8?B?L0hNZnEwYzZnRW9yY0t1TXNCUEtFZmp4bXp0TVk2OXBCNlhWNnViMW1NeG1K?=
 =?utf-8?B?ZG9MTmpHTmRnTklBWTdaeXVJWlplL0JpNjlSb1ZNWVlOUzVqa3IxME1ZbXQ4?=
 =?utf-8?Q?WOQL5uJ0lP/Yi5Jdwfnx7149u0anc0nG?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?aWdZQ2lSWTVZdHJhUkdQTWp4R0ZTUlM2dC9KMUtYMGt0bGFkUFlkaWZVRUNV?=
 =?utf-8?B?TzRjWTJ3VncwdmFSRjVUblBjbVI0WUV6amhWT2p0YXJYc21qRnV6ZkNIYjJ6?=
 =?utf-8?B?azN5dk1vUGYvTGM1Y2JlaGgrSTJSck1NVzVMdE5icjZmRUE0N2p5N3NaUEwv?=
 =?utf-8?B?d21wM2RNSENqdW9pRXdoanJzVjg3Y0dXVXpjL0Q4dDJYWm5JRzNMWnp1ZjZK?=
 =?utf-8?B?QXhSQ21WRmdRZ3RGQmJQTWNwclJqOTZyTmZmNDVsdEkvUis3SjRPOWtveTd5?=
 =?utf-8?B?RDkyMUdUZ0RPbElTdHpLL0xhWDNzdTF6MTZYbUx1R1k1MW1jMkRNRE8wdEcr?=
 =?utf-8?B?OTFBb1lDb3FFVlM4cDdFYUJ6akRnWE9qRFdrVmNuK2VLdytDbVo2YitNMWhv?=
 =?utf-8?B?eE5QTHBUSE9ORnJqS0p0eDhFT2U4V281YjZCdnBJNXBSNE45djRWazByRGg0?=
 =?utf-8?B?c29qU3FSTXNyUzJYRzZSSHZzV2VoODlzRUdUUk1YZmRGNVlQWXp1ZE54TGpF?=
 =?utf-8?B?S3phanM3bHBxNTN1UWRHK01KTFFxcVVxbU1aTjFjVzRvMmZtbjJYa1hOU1Bn?=
 =?utf-8?B?UDZsWU1PNnBNNnV5Q3JoUkVybUEwWG5iUG9COGRDQ1ptRXZqOEZzMGhEd3h2?=
 =?utf-8?B?WEpFTDA5OC95RXVYNlM3bHlhbU9ja0c2aU1qblV4K1J3VkFIUWY0a2tZc0Za?=
 =?utf-8?B?VGMzNTREUUFzTm5HcTBSZkRtRjZ2L2tuS0tGc2krRkRYaGhOTzlCaDVjTVRv?=
 =?utf-8?B?cXRBcjZHczdTKzVNcUt5QXhUK1o2YUhWVGF4bHlTcGFiTUlPMndSQzg0M3Z4?=
 =?utf-8?B?V2RCaUFlQ0tDWGVEUGt6a1hvTlJ0UThVbVJ4WW41WTBKZmZUdVMybWlEYUNz?=
 =?utf-8?B?eXZNaHNxdUpaTUNjenpqejV5dE5xVHBRNWVPQTN3TVpOcWZ0dFREWTFlaEVU?=
 =?utf-8?B?UmIxQTZ2TjZNa0RYUlAwcTZEdSt4bDJ3WDEzRTllcU56d3ZWa0pOVEd1a1Vq?=
 =?utf-8?B?akJqY0psZjc3NnB1Q2JRL1lqUjZ3M09mY1RSYmtNd284V3lzMzZ0OU13MVVs?=
 =?utf-8?B?c2VxL0JKWW1NZGl0bmdpTFBqSU4xbXhMQVF2SXFnRHdjRDZuOXBnaFhjbG00?=
 =?utf-8?B?c2VZSXF4czFKSmF1Nk5DTHU3UVYraG4rU2gveHhNMlNLN2RjYUQrc2VGVXRG?=
 =?utf-8?B?RzBnWUNEL1hQdFR2aEpPejdhME9vYVgyMmNNa0Vycy9aNFRyRGJiU296T0lZ?=
 =?utf-8?B?aWtidENoKzBUOW9PbHJ3USs2TVRLMUxPKzhrQksvRWhXZFpJN1hCV1JYem4v?=
 =?utf-8?B?N1FkRGNNUS9Cc3k1dVNNb3NRckZzdmNCSGs3MHcvdFFmN2RkdnEvVmJwcjZT?=
 =?utf-8?B?NUJ1dUlXZG9aMncyWERxV3l4WXJTUldGNXpic0E0Wm5PMXlxWmk4QmZ6QTll?=
 =?utf-8?B?d2hkR2RyNlRSUS9ZV2l3L0dyVUdnMUpzbWROZGFwL29SNG9IZHIxVmRiUnpr?=
 =?utf-8?B?N2Fpd0JjQ05DNlI4WjhtRThraWFGeUpSMEZybWtyYVRwN1AxYkFOaW1GQTQv?=
 =?utf-8?B?dDYrN1dFRDQ1WXozdFFmanJHSVdoZVo2em1RU3ZwamhKcGNPdjNIM1BPQTRU?=
 =?utf-8?B?bU1EWHA0S3B1czJxT2t6dC92L3JYRzBQMXhwN3Z2K2xqR3FpQTdGZGFrOEx2?=
 =?utf-8?B?blQySUI3S2xGd0g0K1VpaWMvMGRWR3RMS05RUTZyVjBNMGdIUSt5UEpiS3BT?=
 =?utf-8?B?SWhQbWtmbk52SWpnbmNKK0kycFg1bTBCNnd2Y0VqRjdxQi9obmlZdmFWRFRD?=
 =?utf-8?B?eGhqZFhCb1VHYTgwczdicWI4TUdiOW1tSWhueVYzUUZGbEhOSXpQMWpkTS8y?=
 =?utf-8?B?Y1NJYmFsZ0d0QnJiemRYOVdZRXF1emxQZ0RIaFFqYnFrbjk0NG1MZnR3Yk9T?=
 =?utf-8?B?TmIzSGJWMzZ6NVVYNk50REpkaE1aZXg3NWQ4T3ByVDdVRWs2WDBNdmRlWlhU?=
 =?utf-8?B?OHFQNm5Yd3h3MUl0dzRSUVlyWDd4QjQ3dTV6SjdwRWxHVHRMcmhxV1Bab0x2?=
 =?utf-8?B?SURWRDNWMGtKSHViQ0xEVjFZSWczNkhnUG8rdm1YSVdtU3ZvZm5TaXhqSnRP?=
 =?utf-8?B?My8rcXhGeENUR2dXTHVIK21wN25vbENxQXlhNmQyN3ZBR3ZUNHh6ajFxN09W?=
 =?utf-8?B?RHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	w5NGaqUcczmezltQIyJmJpABkT2qCMWV3elD5nEFoFc30Ik7nzpHGqDCFOU1eqg2JmMnSqY/hG0OSAFHtNXBfY8TY/F2Tgyglsn2+F6YBA6fjZXkoN1f1h70YoPTrm2vcch4b5IuVBpWoWD3VVYomRSGirN2w2eF4hIpMGcV7bNTMarne48hqXS98t3mWJQi4DtOPCl12adbEgYabn91Zg6XGTaT181jwB2OtYdMeAf9kSgzZSAK9FlelIgpN+IUvf5+Zmx+gs5S+lyMR4y+dh4o0vPti/i5t+Uw6sTbJbqxAudOKNVFegnxZn8wir5h4M8FZGyWGcq6168LNxE/xWGm58XV+3jCCrwUWhQk/8MIv01R3vbXsxXd2kmA3sm7E3qjl+iGy6A8qhCEYOs7G1NdxCPDkIr9m8smqmc+mM2xF+Ay6TrWeCkoynnf3NXy3ZZDatY2cYQhvjrR2EKbAv+o4VlTTkMpKxwIoepSbSjFyEtJiHmuIoG/Gd97ZZvbNU8wxu0yQ4p0upn3WtsqJl+R4KP9PZlvU+pSC9GoYW8nVrko/W150mvvc9wYJ+GA7LKGMTMFfBl84z2lH3yXsH9XbcA99htJrndZCAzGfII=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74aa8d16-ed11-448f-a066-08ddff767d4d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 16:37:33.1424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hG9Hs8iyPWjXK4H8ENIqw7mGeNbWp2jlFjfzKLg+6J7pnLDx3VJ4aMYobvCqeFSS1qTxAC5c78V8cgPoe8FG0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8071
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_06,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509290153
X-Proofpoint-GUID: 7-318wSyIIkxAgAFPC_QkW6SyFoRZ57X
X-Proofpoint-ORIG-GUID: 7-318wSyIIkxAgAFPC_QkW6SyFoRZ57X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDE1MCBTYWx0ZWRfX3yLZ0Udhdcyr
 jEuo09q2yLRNwmD4IgYRdA8gGeLj7P3j+7C3TzkQ0qd77wL56T+mqDqhUzYxL6x1E0riMsKUj6j
 izm/Bw6fG4Rj9HmalNs9xXIcEZSlu+DUHPHegghpMiz8ZC53P+jSnVFWUylvRiHDCxZkzEGB1Nb
 Drs/JKYwN3Ue66NZKv0DsbGXCrD2wk9doY66vN0+7/N/m95ztElHLJ/N36DvYaVVSmcQfjz6aJC
 rwYMVNccBIevh2Z9tBpdrbGBbYT7XmAIX5GSpQQn+Ts65/0GimlmSPAIpQgpWYyE0zfj1oktUMg
 GTSW9mkGlXDqotkEhSXUPe1aFBm2N+4fp8oYp/vfljzdFv8ENUh9AJH27DgYzl0m7n5YTrhM86A
 SqKvJmYVmGPtT8aj6X9g1keulnr2XA==
X-Authority-Analysis: v=2.4 cv=FukIPmrq c=1 sm=1 tr=0 ts=68dab5d0 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=UnMjX89txkjXtjxAVckA:9
 a=QEXdDO2ut3YA:10

On 9/29/25 6:39 AM, Jeff Layton wrote:
>> Do clients query SUPPORTED_ATTRS and look for these two bits to
>> know whether to expect attribute delegation?
>>
> The Linux client does:
> 
> static bool nfs4_server_delegtime_capable(struct nfs4_server_caps_res *res)
> {
>         u32 share_access_want = res->open_caps.oa_share_access_want[0];
>         u32 attr_bitmask = res->attr_bitmask[2];
> 
>         return (share_access_want & NFS4_SHARE_WANT_DELEG_TIMESTAMPS) &&
>                ((attr_bitmask & FATTR4_WORD2_NFS42_TIME_DELEG_MASK) ==
>                                         FATTR4_WORD2_NFS42_TIME_DELEG_MASK);
> }
> 
> 
> ...so I guess we can't report them as unsupported. They do still need
> to be supported for SETATTR. Still, we should just mask them off if
> someone tries to query for them.

There appears to be a bit of a gray area here. RFC 8881 Section 18.7.3
states:

> The server MUST return a value for each attribute that the client
> requests if the attribute is supported by the server for the target
> file system. If the server does not support a particular attribute on
> the target file system, then it MUST NOT return the attribute value
> and MUST NOT set the attribute bit in the result bitmap. The server
> MUST return an error if it supports an attribute on the target but
> cannot obtain its value. In that case, no attribute values will be
> returned.

RFC 9754 Section 5 states:

> These new attributes are invalid to be used with GETATTR, VERIFY, and
> NVERIFY, and they can only be used with CB_GETATTR and SETATTR by a
> client holding an appropriate delegation.

This text does not prescribe a specific server response if it should be
presented with a GETATTR operation (or a READDIR, one assumes) that
queries delegated time stamps.

Perhaps, rather than clearing the result bitmask, NFS4ERR_INVAL is the
mandated server response.


-- 
Chuck Lever

