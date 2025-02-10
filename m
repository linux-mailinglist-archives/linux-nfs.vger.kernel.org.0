Return-Path: <linux-nfs+bounces-9997-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3E1A2E1D0
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 01:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD40D1884254
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 00:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C194625;
	Mon, 10 Feb 2025 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jjLTmU0Q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J9OzJDcb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6AE8F5A
	for <linux-nfs@vger.kernel.org>; Mon, 10 Feb 2025 00:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739148634; cv=fail; b=miVRIl5XhRBWyjJRweERmNI27rtiWEOMPTTo+5rUbiE+YhPEzx3GtegICU+U1HFDBGFHUJArfBC94o9Hl7OxRRdVSDWzEhlukwLPb6k5K+Ce+5pcSkOjdgLo1VzJRh0kIlkl2JC36gZ/odiSlggEsfcYeZ93J4dhKqVs3uUqb+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739148634; c=relaxed/simple;
	bh=Tbt1ZJSLndr3NHZWr6kCTkwV2VaiOhaDhqMkkloxIXU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AcC9MjNeRh4+sbw+Qkco/1Z/HJdvLQqcXYsYP/26wj6UZ2mvpBPbuf8Z7VppPjLAz6tFW9xnq5xhDwyfr1TVmhLOp5DhpzrlGpoy7jJ187L9SyRNMFIYPipqrRNDxdCkDp9jmNy6EVYYVLXYJbPDi6z0oTKXi+5DaCSXL2FR1OA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jjLTmU0Q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J9OzJDcb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 519MTk80031024;
	Mon, 10 Feb 2025 00:50:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=aQu80WkfdVbAwwurCGZqiyUohME2UO9LHk1UJQqlNuo=; b=
	jjLTmU0QDRT64ayckI0mktQu9yV0LC2nOgpjo0yHhcVMzRKTp2Uav3U2pCdX/ocT
	c6wwl0DGG6YGjvJSF0BfQE8Rz9FDg1pTXud1/jqc6I6ssZfjGo5+TSH/6Ab8LO39
	B9kPMSRup53bO23Jg6KS0AfBvcaBsnxFZerF1KlHf/Oh7mx0kirr272C/le53WKd
	Ar6K5GpTwNdmWK+V7p+IPR9LPbkXS80EPOtCTuAiyfeaImr+NNoDBJiwTJmk7ggU
	LNUd4CWHvyrmYYfNea8CeWS3zHK85DFnnGGirw79Kfw7vFak4J56GcPI6uGNcHN0
	HO3vWt9KMXZFZBNKmLhpWA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0t4200j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 00:50:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 519M1n9J002583;
	Mon, 10 Feb 2025 00:50:20 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwq6s27y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 00:50:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yCSO5QOxjPQPWUnaSR+/Xu89Xy8gvSM3TELMqhGS9L8b8DBLinKffrcPgQFsAyo6rESjKgofdnmX6ljQp6P5Xcg2b7hPSMSMDaL816W1AGSm/HYA5pGZufNpJIV9iQoSw9G/SpFV6zzEaaFjg2hzo/rh4xxY6fwV4VePLX1RGB6Sql8Bo7WSCaYRB1dlNEUTHbNJVVBIyPe8qboBHqlsfhRZE1uwHyV/6JBYKQLqjEF3F8gNAeu9XD7HseesOJg0zKC1Ai18su/zX/cOpY/V1hxsqpb941KMPt1sNsxcShvFpCkZ0QB7aWJXUSWbzLpltMgGrZx3dCMB4kPOz0UdBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQu80WkfdVbAwwurCGZqiyUohME2UO9LHk1UJQqlNuo=;
 b=fGCRY1mWzJVCGf7ePTRK/R8RdbMlolpr+WI/LAG9cpvnvT8Xg59qS80XfRNlenb+JdC5AXGYGxCgcD4mAaOIXAWT5Co1P8ueyIPeQLxsJlkjQv7oGEw5jCnKdTCGQMbrJoB4SGFLKmWcNK9kGG/MgJ9M06mTLfZuDm1CiLqN37bB+HnGpLqXAYn2TqdvrZ2rIU9r4j+hN3odsOiEeYZ+ivmxu6e0cF1kFpRsJJztciEQY7Ixt1z6l6Y0CKjP//VAGY9M64fbt7gs4R9DCxKOPtRCD5+w6WpnleA1KlWqh+GgFAISIPPzrzJZFHuONjp3jaZmRxvQyWxWAKWz5TY8bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQu80WkfdVbAwwurCGZqiyUohME2UO9LHk1UJQqlNuo=;
 b=J9OzJDcbz1BFL0Nisarqn46AVgOy7yLImitmlERnacZvvbNhPcV+haLfoZZsFUrQaj0IT3NfHUE7jgDymbgUNAR9m3hHPdpl2TAz1/Hguk3yAyV9fmjFaUU/fBAcfgoNfbbC+9876688awg4inthAm52yANtSpFft8ehO8D0gcw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6874.namprd10.prod.outlook.com (2603:10b6:930:85::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Mon, 10 Feb
 2025 00:50:18 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 00:50:18 +0000
Message-ID: <0efc7c87-25ad-4859-99db-0a33037e5bfd@oracle.com>
Date: Sun, 9 Feb 2025 19:50:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] nfsd: filecache: introduce NFSD_FILE_RECENT
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Dave Chinner <david@fromorbit.com>
References: <> <9340215f-9c4d-490c-acc8-0450862a99e1@oracle.com>
 <173914339595.22054.11127298752860400864@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <173914339595.22054.11127298752860400864@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR15CA0005.namprd15.prod.outlook.com
 (2603:10b6:610:51::15) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY8PR10MB6874:EE_
X-MS-Office365-Filtering-Correlation-Id: 85994678-698d-468c-920d-08dd496ce398
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGMvbXdUcnNNbWx6bThUMjV3bHl2MUVQR0VUUmVQaENLTjVVVndFNUVCenVS?=
 =?utf-8?B?cUpsaW1Ea0ZOaHU1c1ZXZXUwb0g3cGdra3NtWEZzT1dCWHMrVGFIWjYyekRO?=
 =?utf-8?B?UFlsaGw2Sld5T0taZnZlemdBTGdjd2thaUsvbElBdENSUmV1TVR3VUdTZUc4?=
 =?utf-8?B?YXk2cjZ5QmVlNUFiWGc3SnFWcUp4emVIMyswZVY1VTN4c1VobkNNREJPM0Uv?=
 =?utf-8?B?Zk9BSmd0SDR0Q3FIdmFhamxqMi94dkMxTlNKT051YWNkcFV6cVQrRkd5a0Ru?=
 =?utf-8?B?azhQL2FNbi8xNzdaTW5tQXhjWnBxU0xwdjc1MUlTUGo3WXptTlZqMGVkdzd6?=
 =?utf-8?B?cHJ1THU2R1l3bEUxT3RnUmp6LzNRSEVncFJRbGZUaXY5bXFmallpQnhJVjND?=
 =?utf-8?B?by9hSGpnRWtTaDFCc01Jd1BDSVpiYnBNbVpLbWN1VmVmYWF0TnBoRTBhL3VD?=
 =?utf-8?B?ZVY3cmcvR3BDcXdINHdqZENNU0JiNXRvWkZ5UjJoMEZGcFQxQ0ZEUDd4Tkkz?=
 =?utf-8?B?bDBZVWhCR0FPS3hlbXA2Q2wzRkhFTjBNTUsyOWFuRWlzc3FkbHpmc1Y1R1pV?=
 =?utf-8?B?dXpNeDlwMDlERzdsVSt4NVJLSWE0MlllU2RVa29JbGdJdGt3Z2hoSVBpZitQ?=
 =?utf-8?B?cnIzU0lJOE92elYvdGNQdk9OZ0drSFlqS2ZjZWQ5N0dsOFRHWTJGYnV4cUtL?=
 =?utf-8?B?VGNkajNKY0MzNnAyOUNSN0JsWUJ5Z1dwOXdxUkE1UXpZV3BhcHVLenNJRVdj?=
 =?utf-8?B?b2lEVXNOVE1pa29wWm9xSVNCWG5PSVYxSkl5ak0vQXlQbjhkNURYWWxBT2VO?=
 =?utf-8?B?VkJnKzVtVHh3MVZoMTVBSW04dWV0WHorNDhTOWNGQmIvOVZCV05LenE4Q0FX?=
 =?utf-8?B?VzZNbW9XUE9xNkp0RGZuT2FoMnUvZ1VQUTB2cFBlVi9ieXlkdGNub1NrK1BC?=
 =?utf-8?B?SjFxN2RJd3NhZmhYNG8vTGpTbjMwb0NjMHQranRISUU1dCsrb2FsOTg2M1Jq?=
 =?utf-8?B?NG1ySVd4WTdJQzMwZ1NhY0RYZWVSZVdDK210cmovaEppbks0T2Z1aU1HMjZ4?=
 =?utf-8?B?alFBcDNFRmhWWjRMbG5WT3BnWmd6ODExQlJiN0ZCUldQNjZrRnFJcmJEV0lT?=
 =?utf-8?B?bytWWEdDeWNRWi91YStaZ21BemU2MVZrYUdRYTdiZXVpVUtsckVvNHVvdE8w?=
 =?utf-8?B?WDJuUUJGUktSNUZpdGdIRm5qOTJEUTJzTnRTUTZpdTBCa0hPZ0VQZmdSVVhr?=
 =?utf-8?B?ditUQWl6M0d6L2hGNVRORzZQN2NuaDNhanpZK1FRMk5DTHZ0dW4vNTBrUDdS?=
 =?utf-8?B?eTRTRkZ3R1YreVpNcnNSMGF1S0dJbTlWajc4QnNXRjN5THcraldrK0VJZGx4?=
 =?utf-8?B?aHQrZGc4Z3c2NXhmNk8xcUoxRTlpT3hpZ3Uzb0dPOFF3cVlBdzlFMjllWGFQ?=
 =?utf-8?B?L0l4aVBnNlkxOW1WRGt0M0QvcGhzRWlrTDlCbUxQUWJYM1VPR3oxSWxSajRU?=
 =?utf-8?B?c0tibW5RTWJwb1V6SVYvYy9WdFN6a0xMWHFya2lqRlR1SHBEVVl3NDVDeUd4?=
 =?utf-8?B?SEU3enZZaFUvRXpOdG5Rb3lnQ0d6d3BEVUdyZzZaRW0vWWtLaktmNDB3MGlZ?=
 =?utf-8?B?VUdDRVhsR01ZUWNsV0QvVzB4TEJ0bjlxNnJYWTlPWDVMQmZsaDlXZVpYTlF1?=
 =?utf-8?B?S1dEeEIyYUtDVjE4eUVDTzVxbTNiV2x1ZmNVL3I4TmNxT1Y1Ym4rS25HcEM1?=
 =?utf-8?B?MTVHV0MwcXgxZ21xa2RnRmw0aWhJdlNvbnBKUlQzWG9OK3NNdFJxWjQzaVZr?=
 =?utf-8?B?VVJrYTdPU2VrUlY0Rm52Z21iZ0FCaDlTWkxWbW1aY2FvdGtCN3dRdWdiYXVm?=
 =?utf-8?Q?59e4MBWGOkffs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmpjVVNmcXBadWxyZklXcE45WWo3NlVtTzFqY0lJVjJZemFzY2JMS1B1UW5a?=
 =?utf-8?B?eFJnV1FoRTVVU1Y0ck44aisyL0xrSFp6WUw1K3JqMC93eVYyMVBPZ3k5NDFm?=
 =?utf-8?B?Z2N3WjJVTzdGd2xKMkpOK1ZzL2Q3TlorVUJJRWJrVksyeXpxRGZUMmwxTG1F?=
 =?utf-8?B?UnMrTkNrVSt4NkROTjZPQzJGL3p6Rkk3YVJZN2ZlTVI2T0lHa1ZPdHNzM2lX?=
 =?utf-8?B?d0NTelpFaHYyTjZ1WUZ5NVo0L20zeHJXVlhNc3lqMDY5UFlVQTNXSlBXaU9i?=
 =?utf-8?B?SUwxRm9iVXk4VHhxV3gxVlZDNkNSc0daNW5MRm56dXpSM2txK1VWdDNmak1C?=
 =?utf-8?B?OUtZK04ranFIVkE1Y1hJMStwT0JBOSs5NlVuRGRIWjRJQ2VpcjUxU0V6VTU0?=
 =?utf-8?B?L2FOVU5NemF2S3NoVys0aXhCbUJ3ayt6RjFFRlBSWXBnV3MrWHd0Nmx3QnZy?=
 =?utf-8?B?bFhZZlRNU2UzNXFQNXdacEdYeWtiQlNKK0lsK1hNMHJvdHJNTHI2b3RxYTlC?=
 =?utf-8?B?WE8zTDVxeXo1eW00QVBxM0VrQTUxRldhTmRBNnI2MFI0SlpzOHZOMDNvYnpz?=
 =?utf-8?B?VnRnd0loSXY5QS9Xb1hPYUR5dG10RGxCMkUwQWRJWHZPdWhCS21ITG5GbTNx?=
 =?utf-8?B?UTVtRit2NTltYlVjckZ0YlBjc0Q4SU9Kbmoxa1ZWdWF0U0NSaFZYdThaN285?=
 =?utf-8?B?VzhjNC9iYVgrWWNsN2JkK1k5MjB6ZlVjVVpEdEUvWVBpQnRObWF0NHhGakRu?=
 =?utf-8?B?R3VFcU1yU2tmWVZHeTFHUUpwRjNnUFVlZXQ3R1pXSTc2U0ZVeE1tVHQrZ01z?=
 =?utf-8?B?RC9LZnNqY0ZnSklmdjIvNTVCakdHdWRBcmM1d3FLdGYwWmhjQVVDMGxUcysr?=
 =?utf-8?B?dGVZazh6bGp1SitjWFVSK3NEUm9XWERmNGIzVVI4dVVhc3VRcFBlek1EcTJG?=
 =?utf-8?B?V0puNGQ3N0NuOVd6OWhZNnJXM0tvQzJsY2RTcVczRVdLUUNKVEh3Skc1eWJI?=
 =?utf-8?B?bUx1eDVZTnJvaHdUWDd4aWpCNGFPUkFuMjZrVk5xdTdjNGg3MnFrSnpma1Qy?=
 =?utf-8?B?YjdNMjVIQWtPbENUTFZveUNIaUZKcFVQZHpsNTdIeWZmZ3UrbWVLWUYwTW9K?=
 =?utf-8?B?MnlFZDVORUJjS0RrYmlWUzhFWnNISm5lMDZmNU5ERHJkaW5BQ1NNOGZwRXJm?=
 =?utf-8?B?c0EvMHVvMXgzY0pxTWNtOXlRYVgvNy90Z0FuejZKUTZqQU9WQmE4UUVFRHV5?=
 =?utf-8?B?cWovZ2Q5ZytpUjF0ZDdHZmhYeDhqeWpCL2duUXF4a2xWUkFDVm9iR2pISm04?=
 =?utf-8?B?ZzR5b29qNndZOHVvVU0vTVVvUm9yMXlWRVpnRmVVVE9rWXZWNnZvR2QwVnc1?=
 =?utf-8?B?S3grVzJONUM2azZuM3dycFVNOTNmTzJzYVJoT1AvVWhjNHJtTmVlVG9XNGh5?=
 =?utf-8?B?Kzc2ZFR6MHJiRUFWVXdzRXlPc2s1M0V5bEZTMUJhQm1YSDZ0amR3QlRHSWF0?=
 =?utf-8?B?YkJoWmlNYytURlFrSmExQ1BtbXNTcXlLbWJmTkpNbm9wSjFhRzVNN2NPYXp0?=
 =?utf-8?B?OXFLTEh6QkpwYk1wYUN2MjlOTHdRbWRmTi91cnkrcTJQTUMvZENaNHdRYnZx?=
 =?utf-8?B?NUxiRXlna1FlZHd1MU11Q1ptYmh0ZzZwOUxpMXZNNmdTZktHSjlKTkEwbDlM?=
 =?utf-8?B?OHZIZ1hrbUNnVXdEQnYwRWFIdEJKREh0d09XTm1SZjhpdzB1dHhOQzUvUnU1?=
 =?utf-8?B?aGxyY2tFME5Ha1Z1OUxQaURmUlZTUkxhSGtCWEdweStab1JtK2NzekoxRVFF?=
 =?utf-8?B?Y2U3YTQxR1dVSXBJaktud3Fld0F2eUwyU29JSU1sS2VzTFRsRkNRYm5RbVc3?=
 =?utf-8?B?Q3VLdnVMa0l4cjVLdFVyeWV5Z09BWG52MkdFdGZxM3BuTytBOU1aMEVueW1G?=
 =?utf-8?B?eC9uZDZvemlFVXhTT082OTJrTGI0ZzRpQUdPK0QxNUpuaEtJTUEvSGF6em53?=
 =?utf-8?B?ellBNUEyNlR0QlE1Um92VDN0NHRBMnZpY05rOTVvdmZwd3hKYTNOZ1pQVk9o?=
 =?utf-8?B?Y2F2RUNUSFpIdmZoZWxpQmFDU2M2UTZjOXdtclNVakdaV0hITGZmWldjNHpU?=
 =?utf-8?Q?iWuBGtbVPZkRGkQfn+8aGAvBC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	f+3LVu4jbvcYdwgVyPqML2Yd6MONoPoV/YoCum8UcO0zAQp1S1QeAxnTb5CWUGHoy+msK5lDYgxYarWlKzC+N02e/frXRaoRIz92hCAngPEx4Gb3pesUYhUz13XN5QqMYSA8G3wci2uIDskrT+dCvcJH6TIkdeh00nG9ykJ2gxQ2+Ft96R2QcdQfxt40EpNm7dUDN/5CfWHpkMDiaEpqDjICUvXF5ptKkQb2xR3F9pTHyiB75hJmI89Rl12gBWjktn3SBCpi1ZWWeUG8QfrC+owmOoDAeTVmpCDiIwnTnLp+8rKgTvzGuRVWD6d4eIA1QqHJz/90BLunnKwmKJ/KW7g3s4SBtLR9k8nY4XD/fLDyj2b14rxIj/gvg4P3ISrI8eUnx00OYYOf57virTCeZzpgFpqoB/ebCDuSYRZJN7NUnahwVEWBLJgSjpCInHFbW/K+aMrAE1ugLALNy1JJoYtT2U7M4vbkSjGFjf0MAliXuatoqVsbDLkBftt9OnBAq4KH3tGpk64aGXEbikf1KZlzAlSeaqY/3y92nWJMkhdVZHA3YK1K4ja4l6n+FavQCu5UB9CN3l3qvbpoQ94H7CrQDGtcQSkKVHtyfLBZq8c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85994678-698d-468c-920d-08dd496ce398
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 00:50:18.1326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ud/PFk6f4u6xd8JQixGKFwfR/V4nd9r3X6n0Z4y9ZcPD8Ke+0Jwj4t7DMiow8RiPcAt8VX7OweVxpRPupFujAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6874
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-09_10,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502100004
X-Proofpoint-ORIG-GUID: oXI8gfjhEs4oEHsWUfeLbgoindTbCrGe
X-Proofpoint-GUID: oXI8gfjhEs4oEHsWUfeLbgoindTbCrGe

On 2/9/25 6:23 PM, NeilBrown wrote:
> On Sat, 08 Feb 2025, Chuck Lever wrote:
>> On 2/7/25 12:15 AM, NeilBrown wrote:
>>> The filecache lru is walked in 2 circumstances for 2 different reasons.
>>>
>>> 1/ When called from the shrinker we want to discard the first few
>>>    entries on the list, ignoring any with NFSD_FILE_REFERENCED set
>>>    because they should really be at the end of the LRU as they have been
>>>    referenced recently.  So those ones are ROTATED.
>>>
>>> 2/ When called from the nfsd_file_gc() timer function we want to discard
>>>    anything that hasn't been used since before the previous call, and
>>>    mark everything else as unused at this point in time.
>>>
>>> Using the same flag for both of these can result in some unexpected
>>> outcomes.  If the shrinker callback clears NFSD_FILE_REFERENCED then the
>>> nfsd_file_gc() will think the file hasn't been used in a while, while
>>> really it has.
>>>
>>> I think it is easier to reason about the behaviour if we instead have
>>> two flags.
>>>
>>>  NFSD_FILE_REFERENCED means "this should be at the end of the LRU, please
>>>      put it there when convenient"
>>>  NFSD_FILE_RECENT means "this has been used recently - since the last
>>>      run of nfsd_file_gc()
>>>
>>> When either caller finds an NFSD_FILE_REFERENCED entry, that entry
>>> should be moved to the end of the LRU and the flag cleared.  This can
>>> safely happen at any time.  The actual order on the lru might not be
>>> strictly least-recently-used, but that is normal for linux lrus.
>>>
>>> The shrinker callback can ignore the "recent" flag.  If it ends up
>>> freeing something that is "recent" that simply means that memory
>>> pressure is sufficient to limit the acceptable cache age to less than
>>> the nfsd_file_gc frequency.
>>>
>>> The gc caller should primarily focus on NFSD_FILE_RECENT.  It should
>>> free everything that doesn't have this flag set, and should clear the
>>> flag on everything else.  When it clears the flag it is convenient to
>>> clear the "REFERENCED" flag and move to the end of the LRU too.
>>>
>>> With this, calls from the shrinker do not prematurely age files.  It
>>> will focus only on freeing those that are least recently used.
>>>
>>> Signed-off-by: NeilBrown <neilb@suse.de>
>>> ---
>>>  fs/nfsd/filecache.c | 21 +++++++++++++++++++--
>>>  fs/nfsd/filecache.h |  1 +
>>>  fs/nfsd/trace.h     |  3 +++
>>>  3 files changed, 23 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>>> index 04588c03bdfe..9faf469354a5 100644
>>> --- a/fs/nfsd/filecache.c
>>> +++ b/fs/nfsd/filecache.c
>>> @@ -318,10 +318,10 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
>>>  		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
>>>  }
>>>  
>>> -
>>>  static bool nfsd_file_lru_add(struct nfsd_file *nf)
>>>  {
>>>  	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
>>> +	set_bit(NFSD_FILE_RECENT, &nf->nf_flags);
>>>  	if (list_lru_add_obj(&nfsd_file_lru, &nf->nf_lru)) {
>>>  		trace_nfsd_file_lru_add(nf);
>>>  		return true;
>>> @@ -528,6 +528,23 @@ nfsd_file_lru_cb(struct list_head *item, struct list_lru_one *lru,
>>>  	return LRU_REMOVED;
>>>  }
>>>  
>>> +static enum lru_status
>>> +nfsd_file_gc_cb(struct list_head *item, struct list_lru_one *lru,
>>> +		 void *arg)
>>> +{
>>> +	struct nfsd_file *nf = list_entry(item, struct nfsd_file, nf_lru);
>>> +
>>> +	if (test_and_clear_bit(NFSD_FILE_RECENT, &nf->nf_flags)) {
>>> +		/* "REFERENCED" really means "should be at the end of the LRU.
>>> +		 * As we are putting it there we can clear the flag
>>> +		 */
>>> +		clear_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
>>> +		trace_nfsd_file_gc_aged(nf);
>>> +		return LRU_ROTATE;
>>> +	}
>>> +	return nfsd_file_lru_cb(item, lru, arg);
>>> +}
>>> +
>>>  static void
>>>  nfsd_file_gc(void)
>>>  {
>>> @@ -537,7 +554,7 @@ nfsd_file_gc(void)
>>>  
>>>  	for_each_node_state(nid, N_NORMAL_MEMORY) {
>>>  		unsigned long nr = list_lru_count_node(&nfsd_file_lru, nid);
>>> -		ret += list_lru_walk_node(&nfsd_file_lru, nid, nfsd_file_lru_cb,
>>> +		ret += list_lru_walk_node(&nfsd_file_lru, nid, nfsd_file_gc_cb,
>>>  					  &dispose, &nr);
>>>  	}
>>>  	trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
>>> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
>>> index d5db6b34ba30..de5b8aa7fcb0 100644
>>> --- a/fs/nfsd/filecache.h
>>> +++ b/fs/nfsd/filecache.h
>>> @@ -38,6 +38,7 @@ struct nfsd_file {
>>>  #define NFSD_FILE_PENDING	(1)
>>>  #define NFSD_FILE_REFERENCED	(2)
>>>  #define NFSD_FILE_GC		(3)
>>> +#define NFSD_FILE_RECENT	(4)
>>>  	unsigned long		nf_flags;
>>>  	refcount_t		nf_ref;
>>>  	unsigned char		nf_may;
>>> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
>>> index ad2c0c432d08..9af723eeb2b0 100644
>>> --- a/fs/nfsd/trace.h
>>> +++ b/fs/nfsd/trace.h
>>> @@ -1039,6 +1039,7 @@ DEFINE_CLID_EVENT(confirmed_r);
>>>  		{ 1 << NFSD_FILE_HASHED,	"HASHED" },		\
>>>  		{ 1 << NFSD_FILE_PENDING,	"PENDING" },		\
>>>  		{ 1 << NFSD_FILE_REFERENCED,	"REFERENCED" },		\
>>> +		{ 1 << NFSD_FILE_RECENT,	"RECENT" },		\
>>>  		{ 1 << NFSD_FILE_GC,		"GC" })
>>>  
>>>  DECLARE_EVENT_CLASS(nfsd_file_class,
>>> @@ -1317,6 +1318,7 @@ DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_lru_del_disposed);
>>>  DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_in_use);
>>>  DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_writeback);
>>>  DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_referenced);
>>> +DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_aged);
>>>  DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_disposed);
>>>  
>>>  DECLARE_EVENT_CLASS(nfsd_file_lruwalk_class,
>>> @@ -1346,6 +1348,7 @@ DEFINE_EVENT(nfsd_file_lruwalk_class, name,				\
>>>  	TP_ARGS(removed, remaining))
>>>  
>>>  DEFINE_NFSD_FILE_LRUWALK_EVENT(nfsd_file_gc_removed);
>>> +DEFINE_NFSD_FILE_LRUWALK_EVENT(nfsd_file_gc_recent);
>>>  DEFINE_NFSD_FILE_LRUWALK_EVENT(nfsd_file_shrinker_removed);
>>>  
>>>  TRACE_EVENT(nfsd_file_close,
>>
>> The other patches in this series look like solid improvements. This one
>> could be as well, but it will take me some time to understand it.
>>
>> I am generally in favor of replacing the logic that removes and adds
>> these items with a single atomic bitop, and I'm happy to see NFSD stick
>> with the use of an existing LRU facility while documenting its unique
>> requirements ("nfsd_file_gc_aged" and so on).
>>
>> I would still prefer the backport to be lighter -- looks like the key
>> changes are 3/6 and 6/6. Is there any chance the series can be
>> reorganized to facilitate backporting? I have to ask, and the answer
>> might be "no", I realize.
> 
> I'm going with "no".
> To be honest, I was hoping that the complexity displayed here needed
> to work around the assumptions of list_lru what don't match our needs
> would be sufficient to convince you that list_lru isn't worth pursuing. 
> I see that didn't work.

Fair enough.


> So I am no longer invested in this patch set.  You are welcome to use it
> if you wish and to make any changes that you think are suitable, but I
> don't think it is a good direction to go and will not be offering any
> more code changes to support the use of list_lru here.

If I may observe, you haven't offered a compelling explanation of why an
imperfect fit between list_lru and the filecache adds more technical
debt than does the introduction of a bespoke LRU mechanism.

I'm open to that argument, but I need stronger rationale (or performance
data) to back it up. So far I can agree that the defect rate in this
area is somewhat abnormal, but that seems to be because we don't
understand how to use the list_lru API to its best advantage.


-- 
Chuck Lever

