Return-Path: <linux-nfs+bounces-14967-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 184A8BB7C95
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Oct 2025 19:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA8054E17AA
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Oct 2025 17:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8E42DAFCA;
	Fri,  3 Oct 2025 17:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="afOH4HxP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xQjmfQdM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7A724468D
	for <linux-nfs@vger.kernel.org>; Fri,  3 Oct 2025 17:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759513237; cv=fail; b=vA0YWJZkn5Bl8voJb1g9IllBxVN6+zLcXjWTaRvqdy08WSuYY1/gwUsl2FEG/oLMB/BxrGIEmdDlLc6lvJcA8YbdwLQWByOLswE4p7SWCkCRJHdg/o3e5TwT739xFhzgKa0bmAXx/tnXxPx/GwkcInxw/pp+LvDCGmiLebVeuSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759513237; c=relaxed/simple;
	bh=tyubiEVUbtjCvYZSUmfEVdCtJXIkvxKW87Yn/8JWWyM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fYnRplmUbBjcWBHzeiDlDoBRZdBlKSiGvXYCqQWVboXfJI4BGS6n7s1xONSsatFfgdbbeYFFyVAjbqLPvrZwpes1jfdetm5ZkI9moQFLRJh2fg8e9mgWrDkigbPrAm4iSpRVE4/oUatUcY7YjoiaUOkWyMzrM73mrWAyZ5zh3Ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=afOH4HxP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xQjmfQdM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 593HdhCD004960;
	Fri, 3 Oct 2025 17:40:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=mpb/eA/m+VXkWsYBr/cnF5lYD8ZofZcIQgmVXw5NHI8=; b=
	afOH4HxPrqgpImmiHkty9vlbOhkR7381zJScEVF8FE7A5KpY+t+BQ5DV3l4mnS1F
	fEJqCDu3Fcs+Ppgexl73eGrOhVo/QaXmmzhHQHJ7hnUQq2Mq3CMbn2ewU+9xaCTY
	VfxMG4oDIUOxOyvQBiuk5enipy4CmLevpFjveYtnP6o/Bru5ZbbolnB9PP1xq8G7
	R8S3GlQmjDdv2K0z9T20ZKZlYYRcmdFWdCGYoJWcSOePiFFXsC5vN9yUIApNblQR
	BRXgPrVVYV4mRpqP1AipRa6X4Tt+6Q66B6NTVIeOLyfWK/GTuznESWkNpZV/Jw9X
	/N+Di+YGCBbAE+c4sEjq9w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49jk30001c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Oct 2025 17:40:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 593H4Qhg003800;
	Fri, 3 Oct 2025 17:40:16 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013071.outbound.protection.outlook.com [40.107.201.71])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49hw199hf0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Oct 2025 17:40:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=faq/mB3UmopRVHtD3ya+yse91d3PKi4P4i/LwoEMwqJeWJK62TBTBn71g3E8/xJtOfvtr7we1U9eD3nor080km/ebRGMyjVc9cTZ1ozio5lYDqD/im4pb/RXzbU9rwGcy0Hz21D6HieTuvEM1Rkx7NOkhyUsjD79Ju6e+byKKt5Ee/RrZ1uhmSyLdRKm43RHYFjyx6De4uzzXYN4pQAIbY9WhGMAaOKypSAnCYqrKyXWmcXma1Jg1VzSBDTo3Vzy4gH5wLow9zb8EozRE6H7fMvl0TsWjBL2w5OE1Xpd+RMmjZtPAjWPe/008RCq6lsuUvWwTSeujX/+jXZlb9H5yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpb/eA/m+VXkWsYBr/cnF5lYD8ZofZcIQgmVXw5NHI8=;
 b=gXC39705EOjSeRHaGp3Q7SQw7xro6Gx0gKNREBvaHgxYVTBVWQnYA9/jJdUtkUoaeyblqBo7n7Tz1d7Vv/OTUpPnj+uU3vovOCLnuJHVWbmAh0sYUVt9hHBgTMB0HNLfGK0nfABn9QNKi9FSCYoeL/IHyZ0aFSciKCidX/sLpt+L/yDh86H6qt4JrgwKkGFuRjGN3/HKPtBTzkFwycTcnoqEX1xQmr805kopF4aliAC2APGJb7YrmDPf3n7Ylso6bWeJZB76ZNz9KF/c/slZ+uBVvEIGw+SuuXE5mbxe7dWjbSfbiG8132bQoGHBGYcfE/XwQVg+LR50T2qcT9ADDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpb/eA/m+VXkWsYBr/cnF5lYD8ZofZcIQgmVXw5NHI8=;
 b=xQjmfQdM6IQO9oFobDwAmz4Ymp5lnLLmEJ8+DukQkcQost2cL0Pjti0IoHlOxgePnNkAXSGEYWFkMgGC8YF7BQfm+6I2X6ylO1G3JfmeQookHkSWALz3yoP8uZTHgGjRMXYQs12gGDzFf4nMnSuTb75DpTvEmLks7whfgNH8znw=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by CO6PR10MB5571.namprd10.prod.outlook.com (2603:10b6:303:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Fri, 3 Oct
 2025 17:40:09 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%4]) with mapi id 15.20.9182.015; Fri, 3 Oct 2025
 17:40:09 +0000
Message-ID: <d8f064c1-a26f-4eed-b4f0-1f7f608f415f@oracle.com>
Date: Fri, 3 Oct 2025 13:40:07 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: use-after-free in nfs4stat.c _free_cpntf_state_locked()
To: Olga Kornievskaia <okorniev@redhat.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        rtm@csail.mit.edu
References: <83337.1759494865@localhost>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <83337.1759494865@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:610:76::23) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|CO6PR10MB5571:EE_
X-MS-Office365-Filtering-Correlation-Id: f680e853-6a56-4599-49fc-08de02a3e59b
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Y1pwZmF2WVE1VFVzcjg1VDlXM1Z5aTJlRCtMcmxKREY2Q3NPeTJlMW52UGZs?=
 =?utf-8?B?RHRGOEVWV3pXbjZUbm5SMEVxZzZaQUY1aHhCL2xWZWdReForUjAzeGNKUENK?=
 =?utf-8?B?TmxuSVNqa3lQRHpGTE1ZR0swTlQwaExDVjRIN0tZeGtzdWhsYmdJY3h6eC9V?=
 =?utf-8?B?VEpsdFRRODZHRk11bWZLYXlhclR2NSt4aFk3dWdSZStUR2lVYnUyRkRqSDg0?=
 =?utf-8?B?VlBURXRYY2hZT3FSUG5jcFJBTUtkSmFHaUtYZVpGbkJ2czlJbXIyd1FaRUtI?=
 =?utf-8?B?bWlaNE5hV1liMEowd3pjMVMyNHpiSHRLSlRHcnYvU3NGcG4zWi9pYTJzRGdK?=
 =?utf-8?B?cVVrcUpHeXUySStVRWhGTktpQ2tDaHdpUnNVbHU3NXB2dVY4dm0vcW1HUXNJ?=
 =?utf-8?B?bitlOEVNZXpvT0NVeHFXbSsweFhuMTFCRXR2L3hIMVd1NGMzWW54MGx3ZnpX?=
 =?utf-8?B?VHBubFZPYnk0dDFOYVBFMjVLYlV0QWtwZk04dmxRNDc3aVI1UE16dklvVEp3?=
 =?utf-8?B?azJhL3dsUmFwc3A4WVg5SUlsWkJ6em9TOVlGd3JybHd2QUV6TnlOemNweW52?=
 =?utf-8?B?UmpjNDdOTHQ3VDV0NXRQNWpwT1hubTc2NktKMnArckZ4dFJmKzV5OUNOdlVo?=
 =?utf-8?B?eTlabENzc2thMCtEOXlZdzlacTNBU3RZU0tndDNDV0VlMFJxM2tUMWFyZUVL?=
 =?utf-8?B?a3ZwY3l0cnhENmwxaUk0VXVHZnduR0FkdnJVdVhSd1o2NHg3UklDU0REN1Z0?=
 =?utf-8?B?cGhkUmtxNk53YzFsMEhDOC84aUZ5eS9HUFB5Z0J4ZUV4SXJ1Zmx6Vk1VSWw5?=
 =?utf-8?B?aitJWVl0Y2JYSEVEQmtReEsvZis2aUh3anF2bkJFOXBsVG1WR1drcHRJbUJM?=
 =?utf-8?B?bGlXL2E4S3NVdXJoTnlRTFFEZU1teTlubVo2cDN0ZWdpM0dUU3A2eVpYd3hj?=
 =?utf-8?B?SzNVUHl6WXlnSCtMd1BqeE9NUzdzeThmdHdOL2p0Mkt1R2VWbDFtRm4zWlZ5?=
 =?utf-8?B?VzhwWkZtOVRxL3ZKeFRYN05DVWNuTyt5MmY1THB4UisvREk3NU5QUXlvMW9i?=
 =?utf-8?B?dkphMjRnbCtIZXBPaXF0SXZHbkh2WVRPK2QxSXV1WDBGaGdibmFORTQ5NnNB?=
 =?utf-8?B?VjVSL3hzSFRmbXh2YVl6YWVMZmpyTTB4NFlHc29IQmRiQUlGWExSYW52RlQ3?=
 =?utf-8?B?NU5EaHE0M0xRTGF4Y0Exd3dQa05tNEVVdXB0NHFxYWJiTDNUdDJBaHV1ejdG?=
 =?utf-8?B?Y1h6MURMRFN0K25vdmV0RGRXUW9mdHdXbG1FOGFCSUQ3Qlo4ZW54encwNi8w?=
 =?utf-8?B?M1RzWkxxVmVEKzVCYkRjWndXZ2RyWTdKQVNCTVhFMlBhaVBGcWhiWlk2aklT?=
 =?utf-8?B?WGpaN2xnWnRyaHYyV0FFU2tyU3hpbElEdjZqS0pBcUJPcHUyZXJTR3J2cHZq?=
 =?utf-8?B?WG1xOEZpNW5RVi9PQkdWc1ZxamQxQkZjSGdxS21nWnhyZW1XUDdxSDBlWExp?=
 =?utf-8?B?S2lnREZ5a2lZUnBteFd1SVZWMDhDWFZ2NTlMdU5sTEZxS3ZLd2NEbnlNSHBH?=
 =?utf-8?B?dFZyMVJ5TkFpMGZaWTFWNlFZU3EwMk9LTVlEM2ZpbW5JdDR2MXREMk9oTnNH?=
 =?utf-8?B?djN2cGNDM3JibXZTNmUreE43MFR3UzdMRFBOWWt3UGhqMUl1eGxOMUx6QW5i?=
 =?utf-8?B?NXlsK0xpWjIxZy9KRGtOTFFZcy95NFF0cVdJMVlMZUtLMjVweHRmWHB3WklL?=
 =?utf-8?B?N1NlaXhZQUdiWWN0azNhZWZPQXRqREg2UFdyTjlhUDBWcEl1cmVscmhsZ1Bu?=
 =?utf-8?B?QlRCSlFpeWNJZFRtd1IwQ3JxRVVtNDhxemozUW5zb2pxZnFHZjFKLzd2MENi?=
 =?utf-8?B?aW93ZVBEdnl1Nm5sRDF5QW1iZHozVXA3cnc5UnZ1RTdmSGc9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bElDU3FTbVczVU5hNFBQWVNJeWFiWWg3c3VON2MzMm4vZVV0OXFWVms0Z0Mz?=
 =?utf-8?B?UGpJSDlhRHJHM2l5K3NxOGVlNHkyakNtdTZVVGF1YlhlK0VzZ0dwb2RyUy9v?=
 =?utf-8?B?T2QxRlVKRFErL2FZZTNORGFVeHhNWW5GdFFIYjVDUlprTWRxcG1lSmMyclJV?=
 =?utf-8?B?UlpwamtYZkFvVDdkUktpcmVBalBZbjd5VXV3WTFEZXJ0V01ZNGRJblRYczRu?=
 =?utf-8?B?b3dOSmRXRk80TXFuMFNJTnlWdCt6ZHhtd2wvNjg3MUttOGYyVVhVOXZ6Zm05?=
 =?utf-8?B?SFN6WkovWHlmOE40Yk5ndUZySXREODFaNlVzRXcxTU9NSEwyN0diMDcyYUVv?=
 =?utf-8?B?SWxCWE9UMEEwaWRKeVFhWUVLZHJCaVcxYU5naWtUcWdUS1k3UUR5ZUVsdVpn?=
 =?utf-8?B?MC9OQVVoanFsaEFISnBtYitEenk4T2poOUJ6SDY3bzc1R01qdHhtOU42Q3RU?=
 =?utf-8?B?R0paY25RMmdicjJqd1UzRkZBUXRiNmM0Mk5zQTZVNmFQem96WHZYNnZMVVlL?=
 =?utf-8?B?cXJlM0FqMUlVY0Ezd1RYbWFBenh2aTQxRmp0TXZmY0tUb1MvYjNZcDF2T05G?=
 =?utf-8?B?aWcrcWZsOHhsektSb2ZEMHlmczhiMlA0dllWaTJmZUxzL2diT0JhYzhOOXEw?=
 =?utf-8?B?bTd3ODNITGlKNHQrVEZTTlJZNzJ1L1AyRmI5MjZiZWVWMm9BOEJibkpyTFl3?=
 =?utf-8?B?SzF5cEorOTdFQ21HMW5SRVI0WXhnZzJHYmw5TEZMRzh3RERrRWQ4N3RIRVQ3?=
 =?utf-8?B?WXB0QXZBN3F5V2d3d1REV2QvZ0ZkdFhZQ3NPd3MyR1hwM2lzVVFtNlhhTGw0?=
 =?utf-8?B?RnJONVVLQlhpb0J4aTgyQkhyWTRMNm8veHVGUjhJVThUVFhDVFZHejNjdnkz?=
 =?utf-8?B?bldXNVlUSnhUenlGa3ZNdHhNZXZCckswN0ZYVk9hUU5maGVCUFljNDNEclkv?=
 =?utf-8?B?YWRQRytMNXpJV1RkY2ZFbUpNNWdaZTQ2a2ozTjVtK05neVFFSktrRHpDeDFo?=
 =?utf-8?B?cys5MCs5VkV2bXQ5elk0OVUwNUlkUzR1VDlITVNkTVljdVEyYmZERExwd1N5?=
 =?utf-8?B?T0Y0QjZLNUgvMjEzMjduZjE1RWo1MzFuNVVYcUFITVlya0hIa25oUGN1S3Zi?=
 =?utf-8?B?U20zS3FnQTBwYzhlVEdORWZqbHluWk1ETUswMzBuaU1WUWZISjhycXpkQWFR?=
 =?utf-8?B?VnF6eDU5S0xqOXIxdjkySlJkRnFnNHk2UllXc0JLRXdBUGlMSjAzS2tTZEE5?=
 =?utf-8?B?dFg0R2g2QVl4TCtCRUVOVTJqdkNWRnY2L2h1clVwVGNPVVM2TDNkYXdFTHJO?=
 =?utf-8?B?R2FpR09sbWhDOTdNMFFVNjZrNC93dmxlc1JERFNHMHVmZFlXdDZ5eTl5YnY4?=
 =?utf-8?B?VExkaDVkL0lpNEhXZkZFUS9LM1VDZVUxYzBtV3UxbkxpOGlZWE10MnpSejhj?=
 =?utf-8?B?a2MyaFNJcld1MkNKMVZsdmNSUXJMcjliM0laaXZEdFRxbFkxV1JnUXRSZ3Fv?=
 =?utf-8?B?WTBoSnFWclZnS0ZHV1lKdlFLK0s3TlpLVGdWajYvbDlYNXY2MGN1a09LbUgr?=
 =?utf-8?B?TjVEK1V5OTFUTHFoamFldTRLR2hmRkVpbUVpRzgrOTBFTmY5amZEeGNPVll6?=
 =?utf-8?B?a1BEMTNDQWlyejA4NzIrblMySUFkVXVmT2o2MG5nTGY4cFBXSWExaEtTcUtv?=
 =?utf-8?B?MFBWOEF3aHd0UUp1RlBWWTNrNkpML1c4Z1ViRllKbEhwdWRUUWxpbnJKOU1F?=
 =?utf-8?B?L3ltOFhiTXI5ajIvd2tUUnhDVGQ1RkU1NXU4QkxXYnJhY2JLbG9MeHFOSXB1?=
 =?utf-8?B?WlJOWE1rK0NndHJWRkxEcVp2RjlzQ1FmdlVCbnF4T2FQWW1BTjZRT2FJQkhF?=
 =?utf-8?B?ckJHdHFIYXBORGg4ODMvc0k1L094SGNoMlNROXZYRDN5ak9HdStqSndaOHhm?=
 =?utf-8?B?ZEFyNlp6RVlkUFloTUQ4RGlDUjVCbW50QnZiV0ZvZllZVTZtNTFIVUltTElL?=
 =?utf-8?B?T1BNems1YzhRb09lQU5NdnNWVk81WTZLeCt5LzF4OXdueXgwcTZnK09CRVdo?=
 =?utf-8?B?NGVJUDN4cnZjRkpBS2VKZzBXY0NvYnYvalV0ZFUyQm11NHF0S1UvVCt2cDZO?=
 =?utf-8?B?TVFIaXNuNE5UcHU5NHhzQnc1U3hoMk1OTllOdkV5NHFmL0htZmMxYjBoeDd0?=
 =?utf-8?B?TGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uYbCnbl7QyR1af74z2uMIvQEeGM/Y/x5PtV7k66RxIcEJWlcvGIm/CyEjqLg0EwdWzKmrN9DljTJ5EbiLanBPlyOJAnlRRzl1bf6voDLXEFSqU0KriMm+5YVM86jlqBaQeDEFaFfgDkxMiO+G5UFSUz9dheU/fb0sz3fl0jWG3908ZpCIk6UFoK8LV2nBqegdqQZe3VcMokPiAbQpRayNrrygNMvmaYH+yhMc6HQgsWtnNkvN+EDQi0ItCzzyOmfssNO8H0fDLI/jkDguGYgNqVDzGbgDc+9kbLgVPYPFm0Fc+sF2VghPPGRExiwULHjQvJ3/XhnBDO0uqoKkn1BR5WOVRgpLvpb/IuU1TcD4MG0r5VfS8fYRO4dXxJwsSSX0Jmy6XjPPQokVcUAJncZ1kYPkMC6PQOoCjfLQO9RsUixeCi5YvsLBetKobaMajeYhS0Al0jfchfAifaAyxCh+sxaQIVEJcUDke9ybmp+1d5VUHRLNM1jPdBzP9Czr/ti4Ct7ngDK5nFcFsfTX3LjzR3yfE0qZIdf5AmjFLGTeH/iRDUbwPJyKEAw6NhQA9M7IynX3cQicT/Kf8h+XnnIYQg2d8S2g6V9IY+1edWciJg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f680e853-6a56-4599-49fc-08de02a3e59b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 17:40:08.9812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zz5CXYZtXqsrHU/YsbKF+llcQhhiodlsvpxezULLBm9OvfI1bn/sbBBKwQRUyb/BtxLaPPB6qdLPaDCMA9i3dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5571
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_05,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510030145
X-Proofpoint-GUID: cTMlbadvVgqxw9JoDsF3eAWT3Jch_t5-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAzMDE0NCBTYWx0ZWRfX9t2Q3cy+i7no
 aMuJ78hL+PDhhb72DsTIAp7yjsBAve4j+IzKC7z+OXo2uUagTtLa6+CRE469z15qBFb++xIMPKM
 yqyuri7tMGwRMu1bBGcVngx8ly91yogLgFPvPbqOqOsU+aTRraBtm6377hdyMY0Lthq7Raeg/jk
 vBmgGCOTiTV/hSkv6pCRvwjI2T+s7oCfVwofanrzCF1DRvx3OUaBAeouHPvd33A0FY7ZG7lWmGI
 pjQqjH786B0OfrT+NPdFB0qaU9yuur1EI6PUkXim//uMmjNvqRbBvqPHmX/BKtSb6zioB5AkBv6
 6kygwiT1I59GOZyj1OTyQx74cvPTuUy3hf2Q/srkOSkJUSmRZZDmsHu1jqyeRY6B5piJ7NnAVOQ
 iIwN5cDyZOHUe4c+dXCQhnYER5l07A==
X-Proofpoint-ORIG-GUID: cTMlbadvVgqxw9JoDsF3eAWT3Jch_t5-
X-Authority-Analysis: v=2.4 cv=KrJAGGWN c=1 sm=1 tr=0 ts=68e00a80 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=qDLvNZgnAAAA:8 a=Iy5vDIb3ZsEMqac_1-wA:9
 a=QEXdDO2ut3YA:10 a=F1IgC7QUihC4ubSUnShx:22

On 10/3/25 8:34 AM, rtm@csail.mit.edu wrote:
> If an NFS 4.2 client has a COPY_NOTIFY registered, and then
> re-establishes its session with EXCHANGE_ID with a new verifier and
> CREATE_SESSION, nfsd4_create_session() calls expire_client() for the
> old session, which frees the nfs4_stid associated with the
> COPY_NOTIFY. But the COPY_NOTIFY's nfs4_cpntf_state still exists; when
> nfs4_laundromat() expires it, _free_cpntf_state_locked()'s
> list_del(&cps->cp_list) uses the freed memory of the nfs4_stid.
> 
> A demo:
> 
> # uname -r
> 6.17.0-01737-g50c19e20ed2e-dirty
> # cat /etc/exports
> /tmp 127.0.0.1(rw,subtree_check,pnfs)
> # wget http://www.rtmrtm.org/rtm/nfsd185b.c
> # cc nfsd185b.c
> # ./a.out
> (wait 10 or 20 seconds for nfs4_laundromat())
> (you may have to run a.out more than once)
> list_del corruption. prev->next should be ffff8881068669d8, but was 6b6b6b6b6b6b6b6b. (prev=ffff888105190010)
> kernel BUG at lib/list_debug.c:62!
> Oops: invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC PTI
> CPU: 2 UID: 0 PID: 268 Comm: kworker/u51:2 Tainted: G        W           6.17.0-01737-g50c19e20ed2e-dirty #33 PREEMPT(voluntary) 
> Workqueue: nfsd4 laundromat_main
> RIP: 0010:__list_del_entry_valid_or_report+0xdd/0x110
> Call Trace:
>  _free_cpntf_state_locked+0x40/0xb0
>  laundromat_main+0x5ec/0xaf0
> 
> The nfs4_cpntf_state is allocated and linked into the
> nfs4_stid.sc_cp_list here:
> 
> #0  list_add (head=<optimized out>, new=<optimized out>)
>     at fs/nfsd/nfs4state.c:985
> #1  nfs4_alloc_init_cpntf_state (nn=nn@entry=0xffffffd602d82000, 
>     p_stid=0xffffffd606858008) at fs/nfsd/nfs4state.c:985
> #2  0xffffffff804b04e0 in nfsd4_copy_notify (rqstp=0xffffffd6040fb800, 
>     cstate=<optimized out>, u=0xffffffd6052e2720) at fs/nfsd/nfs4proc.c:2078
> (gdb) print cps
> $1 = (struct nfs4_cpntf_state *) 0xffffffd603fe9020
> (gdb) print p_stid
> $2 = (struct nfs4_stid *) 0xffffffd606858008
> 
> The nfs4_stid is freed here:
> 
> #0  nfs4_free_ol_stateid (stid=0xffffffd606858008) at fs/nfsd/nfs4state.c:1502
> #1  0xffffffff804c3ed2 in free_ol_stateid_reaplist (
>     reaplist=reaplist@entry=0xffffffc60031baf8) at fs/nfsd/nfs4state.c:1602
> #2  0xffffffff804c46fa in release_openowner (oo=0xffffffd606857008)
>     at fs/nfsd/nfs4state.c:1696
> #3  0xffffffff804c4898 in __destroy_client (clp=clp@entry=0xffffffd605308008)
>     at fs/nfsd/nfs4state.c:2483
> #4  0xffffffff804c49fa in expire_client (clp=0xffffffd605308008)
>     at fs/nfsd/nfs4state.c:2533
> #5  0xffffffff804c7a26 in nfsd4_create_session (rqstp=0xffffffd6040fb800, 
>     cstate=<optimized out>, u=0xffffffd6052e2060) at fs/nfsd/nfs4state.c:4041
> (gdb) print stid
> $3 = (struct nfs4_stid *) 0xffffffd606858008
> (gdb) print stid->sc_cp_list
> $4 = {next = 0xffffffd603fe9038, prev = 0xffffffd603fe9038}
> 
> Freeing the nfs4_cpntf_state trips over the free nfs4_stid here:
> 
> #0  _free_cpntf_state_locked (nn=nn@entry=0xffffffd602d82000, 
>     cps=0xffffffd603fe9020) at fs/nfsd/nfs4state.c:7226
> #1  0xffffffff804c6210 in nfs4_laundromat (nn=0xffffffd602d82000)
>     at fs/nfsd/nfs4state.c:6836
> #2  laundromat_main (laundry=0xffffffd602d820d0) at fs/nfsd/nfs4state.c:6926
> (gdb) print cps
> $5 = (struct nfs4_cpntf_state *) 0xffffffd603fe9020
> (gdb) print cps->cp_list
> $6 = {next = 0xffffffd606858010, prev = 0xffffffd606858010}
> (gdb) print cps->cp_list.next.prev
> $7 = (struct list_head *) 0x6b6b6b6b6b6b6b6b
> 
> Robert Morris
> rtm@mit.edu

Olga, do you have a few moments to triage this?


-- 
Chuck Lever

