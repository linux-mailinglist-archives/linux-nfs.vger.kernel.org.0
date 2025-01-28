Return-Path: <linux-nfs+bounces-9718-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CC7A20C1E
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jan 2025 15:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E68D18867BE
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jan 2025 14:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FAA27452;
	Tue, 28 Jan 2025 14:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BNZq6EYc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KptNGjdZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A243F9F8
	for <linux-nfs@vger.kernel.org>; Tue, 28 Jan 2025 14:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738074801; cv=fail; b=qqGKgp21X3HGoUm9n2MRs8luqHJnb79nuxKiDSoWeeMMVGWK8oLeQ59kn64nDCiUoR4hwdiXOLl2BtztvBfYi8Zenm2vlWxvoRZGyKfXNh2GhAzwkKvIgtTrqZYSpUgNnMa5io6xOWVXFCaS8+O1xzsNh2Tk2C6Cnbpzy+O5vO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738074801; c=relaxed/simple;
	bh=QUXZM6h/tpK5UeJeKlWwaW7l3/czn4729B7EWpHQaGM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YOWy5oxsbbijv/affWpQh+OPW5E1awkMpfDrnSuujF0u/IFEwFKInvetOjIuU3C2kZx2gOowAvB8szwjrV70vo7NypiLbrUSgROIlHMbBcFU84pmVsjhv53SlwJDitxQzRQJzyKF8/30GS9SDUlQzR2UkEljiBz+GLns7UA6ea4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BNZq6EYc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KptNGjdZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SESUHA010581;
	Tue, 28 Jan 2025 14:33:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=zY6OqhVUQU3FJeSNh+6zuL94sXBbFZ9FjjZigg6LPR4=; b=
	BNZq6EYcX9TGDAXZw698bkaJ63TbW3o2/rtOepvo0TA3H3nRelnBSEWhD4f+pP+z
	knwsGjcUwq9oJQD1OtEuu6wOEdC9c8TPLPGtrHRLQ+8ARYYxX4cGx8R1155h0Vqk
	gUYKbIMRsYDpuNZrGUnEoL+xd0uilIlDtvrVse2ssTo0VuTMp0kN1wTK0z7A3VH+
	bm5sNmBoZe8n1CjaUiJhguJ1vOXqhpxtYxF+yXk9SUhecrB6OpjSyZESy8+NZPvr
	q3CjWa5KxWD0l2RIbnfqmHtDPRbsir2Ic8wRpQzFcn492M/8XRa+EifGU0akI6hx
	kfdZxopYylAoOyT8PF0S2A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44f10q00ep-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jan 2025 14:33:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50SECb84024257;
	Tue, 28 Jan 2025 14:27:49 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44cpd8emh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jan 2025 14:27:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qORx2Rq7yGACgGh1bUmg6n5zNPB6WIAmvbXEmdeU6iOsPQ+EHJwlneQhzxHtFStqnsBP3tP5yQgk5YzP4tWImhmbP7C/Bv3x49hWiLOrMrA7tNCRR6kNOv7qFh1AN1n7yAApYAfRBKAjDHY/u9jMqVCXzumNbpmqbVukouK4AOiehfVWPhUGSNtR+viu/T/9sMltHsgPcVKtNYpr5qTBJY88YdBw5+zykARdI83Q1C0Uxok0q8BMWGzA5LYlrME/JQm++c5dK7Z7dVz1IYSC6rmRjIIeEZ8DB2Yg5G/crOHRjcEaXta5P6vYf/aM3oNdjEDRdy0PdZ9M/0MVKo2O4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zY6OqhVUQU3FJeSNh+6zuL94sXBbFZ9FjjZigg6LPR4=;
 b=bXw9ZbyhM9FzXM2HQ4tgVec3RYB1OqXmuztH3H8u7vLhMEBDFOukrH/egsFutHpXj1SdpSgYl4vehukawc+WkWmzksM3skRxr3IE/GGoZyAsCapvgSWMBnHK+C88vqhGoHS3CkKS4ykqoy7pSgKwd0BocjFSfikvVdR6ZtNPzt7msiY9+fxAoVWzTnJHFw5T5pkIJTMVItBRZGxdVksaepJf1nQ00pSxZ+ZVFU5TANNtaqtjC9rBngNBfFWB+yVNOhUdKxS2gZsWaBdJaOe2t64h/geMQgpjejP4uPFPQ8OtieeCnJAwXJ9BOPobDN9md8GGNhRoKcx+kd1zqMjq8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zY6OqhVUQU3FJeSNh+6zuL94sXBbFZ9FjjZigg6LPR4=;
 b=KptNGjdZ2gWFEkHHDuA7eu7rgphRyIFyMFvcTlyw8bQarpgMj3MPEMtURFxM6Xqa9a7mh4gUKhi9ashanx8yVe1jRSOESRBTfOSrveYWydcupHjzmqy8Uyk91esNqlb9WqxXcQEuM5RHtmZJzfTBzgqBcmNmhzf91GXtWVnimDg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6106.namprd10.prod.outlook.com (2603:10b6:510:1fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Tue, 28 Jan
 2025 14:27:46 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 14:27:46 +0000
Message-ID: <154547d0-fafb-4b5f-a071-6cb697f6d9ed@oracle.com>
Date: Tue, 28 Jan 2025 09:27:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] nfsd: filecache: change garbage collection lists
To: Dave Chinner <david@fromorbit.com>, NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
References: <20250127012257.1803314-1-neilb@suse.de>
 <Z5h7HOogTsM4ysZx@dread.disaster.area>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <Z5h7HOogTsM4ysZx@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0344.namprd03.prod.outlook.com
 (2603:10b6:610:11a::35) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: bfb955d1-f109-44cd-aeb5-08dd3fa7ef5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2FBdktBUHVJbXFRell4cGtDQ2Z5bzdMYzA2dTI3czE2RUZHWkFISENjVGZM?=
 =?utf-8?B?dEZFZUN2Yjl0eW9lSTIzMno3UU5IakJqeWgwamNaTC9mNm1Nc1JsVkx4QitK?=
 =?utf-8?B?Q2dWK1BzVGMrbGtKcERKck1LL1VGRDVEMVdmVUVBOUU1SnRCUi9heUVLL1hK?=
 =?utf-8?B?b0dMV2pvdWlndTNtQmo0dEsrdHNvcjdLY1ZKUVJQckVhZVkwTHdsL0ZlUCsz?=
 =?utf-8?B?Z2Z0cTQzdTcxRUpsT0xVbmFnOEo2cStRVU9JYktIa3BnY29lRFFyUmtWWVJZ?=
 =?utf-8?B?VFBPUnhMWmFjUW9oTDU4ZFRHZlZkVWVKN1BLRG4yM2hqVW1kclZpN3QwYlJR?=
 =?utf-8?B?SVI0YVpMOVlWNUtDUkNZM1N6L0JrQk5CODUybVcxcnRMOHVKSkY5MTZxUTN5?=
 =?utf-8?B?dUZnT00rNG5PREptOTNOaW9QZ0dmMFNtcUlLVTk1MVFONStWWStOMUJyallu?=
 =?utf-8?B?d1FNR2ZDYUpCUzE5b0FrRVpyeVRMMVZqby9vdERPZmdmSG5XNVhLeDNSOEdk?=
 =?utf-8?B?UzFEb2FENXg5MUdHVmVmVkdRL1NDS01RMkRCelBEL1FXcHlWZXp1M0hvcUV2?=
 =?utf-8?B?aE1UNEZFVmdVV1I2Ym9oc084MmFESmFSUHFoeUI1OG5WWHJkOVBiQ080aWc4?=
 =?utf-8?B?UzRBa2Z1RjdnMENlQjYrbmVZMDBRamhGRGtPckUrdkdSbm1iK3I2N1lJZkkv?=
 =?utf-8?B?Y2lUQ2NrS0dJV3BYMjJNUm1zaG1iRWc3ZmU2UGhkS3d4ZVlCVldSMjR1Qndu?=
 =?utf-8?B?QWVSNGR3aHIvdUpUUmpsN20wc2hwczlKZ3VjZDdOZDBtcStJUUNtRHZFSjdy?=
 =?utf-8?B?WDA5VkYxRWNFKzFEWmdoNlR2QmIrTEwxYzBHeTNSL2gxU2tVamt6ZEkwMmkz?=
 =?utf-8?B?TUdrejJ5bitzdGtHNCtVeFlLZDZUdlJUVG91UnVZeWNkTy9Jd1RZVGxLM1ha?=
 =?utf-8?B?RDNveVl5Rkk2MjMwQlc3VktSRjRoSXBKbkJ0dTl6L3dWa3g2NmJ4NnZjQjZV?=
 =?utf-8?B?OXJlNURrb0NSM2hDYjU1ckk0bExDOUVuWCs2NjJsWUZ6WXJuVkVoNUlQNEdG?=
 =?utf-8?B?MC9XSldWS29JTUx5Uy8zdXlrSXEvL3JEcHVnK2x1N3dkK1lUQ3hCdjBWeW1R?=
 =?utf-8?B?MEpRTThSNkxtSDNYejdZNk9YQTR6WEtmK3hNZVZLbE91OU8zMm5NZXRtKzk4?=
 =?utf-8?B?NlZRdFhFSkxqR0dsVkFVTXd4ZWdnMmZxbm5lbHV1UkpSak1HWmU4a1lFVHZy?=
 =?utf-8?B?cXhJcWVTUllzN1hHWVVFU1lwMlNkdHBBTEhSZHRuMlRSSHRuV3UxSDUvQkMv?=
 =?utf-8?B?VWhqbHpyOHd3MXYzSkR3alBQNStvYXVHWmNkRUdNVXZKdEV6Y1hjTEhQQkly?=
 =?utf-8?B?d2QxUHZTZk5WQm9Db2ljb21kYzZlL1IzSEpURGkxdzNKQW1FVkNOZEhpYnJY?=
 =?utf-8?B?aGxOamhSU1VqVG13d2dqKy9iL1BzOGx4dkI3SUdNRm5BMXNYUHpybjJPekVw?=
 =?utf-8?B?YUxRaXEwY0xyUThsSk5yRllaSGFBNURHWHljK0Y0Rzg0czgrSk01OWRqTEFz?=
 =?utf-8?B?YU1YcUFQRFNlN210Z2R3NHM2blhad2ZHdzhhM2hyM3lnazhVbXRzTCtwcXNl?=
 =?utf-8?B?bUVWdXNTQUozcS82T3hQNTRSOTgyMlJvMWExeWhtU1dCcm5vSElpbndXdTRi?=
 =?utf-8?B?MlYxNWVxQS9vMjg3RHgzZzN6TmE1eW1WdDVhS01wVkZPS3JtSDZ4dmhPRzFi?=
 =?utf-8?B?MnBUN09kTmtvZXV3ck5BckwxZWptRThuRUFNZlF5R3N2ZjY4d0xkL1dKdGxE?=
 =?utf-8?B?L0t0ZERpMEZTUVVZWlNaUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHpnNURjZXhZM2xzRElzWGVySHFwVkdQb2l1SUtmT3lsNzhlUG1ZTzJkbXhp?=
 =?utf-8?B?L2FtTjhCSjFUaGtueUI0L0g2NFFlbTgyS01lUlZQcHBoUWJIOXlCMG1wSmdH?=
 =?utf-8?B?WlZiRDJYWDYyZWp6RHJXaXBXMnNndUpYNFlIUGJLaTFxZzBqL2hSRDExaHJz?=
 =?utf-8?B?N2s4VUhqSG9IcVNLZUtJUW1YRk1ZVUxLOFA0YkJ4R1A2ZzVuZm9uckhPWGk3?=
 =?utf-8?B?ODN6Z2swbXhMdHYyckJOeDlBMzZZUHd6dGlKRXJEa0Fmd1RvNEpDSlVxQ00x?=
 =?utf-8?B?MFI4UjQ2cmh4RkVoWTV2aGs1bU80RXBEbmtGc0NnbUNQOG9ScHF0WFB2MnE4?=
 =?utf-8?B?T0NuUVd1Wnlac1c3SjBJVysxVFdORGd6RW9wZDJ4Zk5HZ3pjdkI3U2UxdmFI?=
 =?utf-8?B?SkRnM3YwUmRUbGpDQURLaEo1YmdYQlRYeGJ5dHJFUEUwOC9GdTFkMS9Kdm51?=
 =?utf-8?B?N2V4ejVZWHYyWHdUb0FFa3Mzck9KUHdXRWNyUGhVK0hDa2pGeFVLRUIyQUd0?=
 =?utf-8?B?eDZaQkw5NmxtUVFSL08zd2NyMXdLRVRHekQ5UVhBeXRId2xKQVBGandRNTFZ?=
 =?utf-8?B?SjNJZXhZYkpCa1hIMFRnM2VxcGRBT2NBemJIQytZUTFCdFUyOUNmQWdpTjVI?=
 =?utf-8?B?bHkrbXpMVkV1eVV6QmxvZjNBZ2F6Z0owV0FzbFE1bVcrZGRiSHphQ0lZbUE4?=
 =?utf-8?B?c2RPMCtIV1FIUlJNSndtNVBCL0MzQ05Ma3dIUHFVSytTZHJURXIyVVJqSjlX?=
 =?utf-8?B?MWpuNjhPb1BWMWIvYUJhejNOblR0MmpSdjhvVWNEZFRtVkZIckJvd09KVEtP?=
 =?utf-8?B?SXpXYVg4MkwxN1BUTXh4cmtCRTdzL1Z5azlURGxYQ01PSXd0Y21TSURlZmJM?=
 =?utf-8?B?QjlTRkw2d0Q2Z1kwUjkxQUluVUZra0lCTDVYNVNmYytGYS90QzVhTGtNMS9v?=
 =?utf-8?B?ZnoreklZVTEvZjkrUlE1MXU1N3ppMkJXVzhiVjVpQXVHa2hsMERERkVLeUpl?=
 =?utf-8?B?QisyaFZjSHc3dk4rYTVzZHEyUkwyMTBRRUM4NFpnNnV6T1BwNkdxSURQOUxW?=
 =?utf-8?B?Zzh2ZE94SWVhenZPVmJmU1lDSDR1RjBIOG1mOXB6bkVuVFloWjZsMHNlZldR?=
 =?utf-8?B?ZFV2aXFucHlabGdmeC9qeGxWNzcvTUJ2c0ZqUFpBS29jcThCR3BUbG1XZzR5?=
 =?utf-8?B?RjJ2eDVSQ2RwQUNYNWtiaXBkZmw2T2M5TlpKZllRemZBWXZFbCtkZW5UU2xN?=
 =?utf-8?B?VnBwcitsUWxpQlVVNGl6MEVuWU5McUpGdW5KV05CRkNnWUNIdjFkMFV2VjQz?=
 =?utf-8?B?WUtGeDh6NDZRUXU5YmdsblRMVzJHV05rTU5nYUpockRwQVVhWDQvQUsxK3RT?=
 =?utf-8?B?YkxWeGJvU1l0Q2IwcFFlVkpNeHlUWGlzUVk2SFVpTERZN0ZBMFlxcDN5THNs?=
 =?utf-8?B?TjlXMU1YRUF1UUEwNUtSK0FLMU8vNDJUeXd2bTdmZlkrdGhWWEVTaGNhbVk1?=
 =?utf-8?B?MEQvbnY5alJnTUxsOVIvR29RUnF3QitFbS9xbkZwbkdKRSs2NTRlTG4yTWdy?=
 =?utf-8?B?NXBZTzJaNmJOZU9PbmJNOC9yMXp4S3ZNWDRnNnhXaXAwR29UVEIyVjdDZStz?=
 =?utf-8?B?MEpxam43cmZNcG1hY0VGMnhwU245Zmw3UVFmOVl0a3grWEF4ZVJOa3R2RHQw?=
 =?utf-8?B?RU5adU9jVWZUQlpBQUtXeGZnWStQK0plbmdsZnZORXVqeGRlTWpXYmFhR2ZW?=
 =?utf-8?B?SGl5eldod0loSVZWMWh6Qkc1OURzekFOSnBnakRpZkJaMU1wY09OMkkwRis4?=
 =?utf-8?B?Wmc1VjV1L2dDVGR6Rmo2bGk0V2VmYm9HNE9aMkpxb1pETDVIdFZ0ZmgvSXJa?=
 =?utf-8?B?b0lFK20vd04zY2s0MEZ3WVhvWWoveS82SWtrL1BGVzJJS3VjbHMrUEZGbmpY?=
 =?utf-8?B?T1hCTy9BdGtDMkowYXdpNGlDQXZzSWxiMDI2OStDMEN2ZFVSRmo1dGRUdG8r?=
 =?utf-8?B?UTd0WFFOYXcrNjF2Vkd3bXFlZ0J1RkJ5YU1ibHBQZ2t5ZEE0Y2szcjhlS2s5?=
 =?utf-8?B?S2p0S1B4anhPckhTNTZmRFc3RUFWS2pVMkZGZGtYd0NSZVRQZDZUeXV1aU1h?=
 =?utf-8?B?d2tPcEhYWjJpNUpRNEozc1pxQWxPSkRDRFZCSk50WEFnaVJLMEphWCtZWk9B?=
 =?utf-8?B?K0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NANhBQpCT+K0mAA4JRT3Fh2MCCMF1PP9JxpyJoZlZW1DU23ouV+W0VFFZMWX/hkGdABrRaOR71bX2mo8tdXx+DP2FvVb0cQoLZ0HLEW05mLmzKhvqgu5E51UdHjLvyDLsvJlwo6XwFEewyujheKJsYXt1Fs1OKGuAVtEB/1rKBjL0Xl/uN3Ibx1XVzL48gCMHoH0oMTg5qdTEiWA/LZFflYqfKlc0jZ02iGkAMGLaeBkkH2Rr7t4uFbGG5Lj6H1mgFrgGnHX3pe6Al6iIJmImXK52z+xB57CqAR7bNXtXfiZTYajWzUm0LVNdPmP9y2KzZsR91zdZVl1AjEpHg+MwV2xzlZtS2M258+iXqnSNm2VT9CDSajshazppkEFbvCSGKQm36JcUHErwNAbHgnZqFRFt3XOBI2D+xCpa/Jkrc6B9Jg3iKgQdW0WgpwIhcDfOX4VHdvPvaN4mhloCASWjHgteFweeQVPg426PN+JkT6TCbfUqZ3cpWglYnlL0/PO49hgMoTDOaCT0JAK0Se0qF9nc09vD2rQipbHQex8tbrWKIeL1OSq7ySfEAClqcc7yBRXO2CjEPy2WRlsjGSld0JW+PE/G5SbxWYmo1zLGUk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb955d1-f109-44cd-aeb5-08dd3fa7ef5b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 14:27:46.6343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pG7XuK0cGD0AOa6sKnMbnPNb1z1+KtfegZ2TDBwbrsFA/Rnm9GqjKSRx7BYogr8vsKFji+/3tjT7aIcjoIBFxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6106
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501280107
X-Proofpoint-ORIG-GUID: HBhVMBNcLCLZSIVQ1oy8j2BCZy2aWvY7
X-Proofpoint-GUID: HBhVMBNcLCLZSIVQ1oy8j2BCZy2aWvY7

On 1/28/25 1:37 AM, Dave Chinner wrote:
> On Mon, Jan 27, 2025 at 12:20:31PM +1100, NeilBrown wrote:
>> [
>> davec added to cc incase I've said something incorrect about list_lru
>>
>> Changes in this version:
>>    - no _bh locking
>>    - add name for a magic constant
>>    - remove unnecessary race-handling code
>>    - give a more meaningfule name for a lock for /proc/lock_stat
>>    - minor cleanups suggested by Jeff
>>
>> ]
>>
>> The nfsd filecache currently uses  list_lru for tracking files recently
>> used in NFSv3 requests which need to be "garbage collected" when they
>> have becoming idle - unused for 2-4 seconds.
>>
>> I do not believe list_lru is a good tool for this.  It does not allow
>> the timeout which filecache requires so we have to add a timeout
>> mechanism which holds the list_lru lock while the whole list is scanned
>> looking for entries that haven't been recently accessed.  When the list
>> is largish (even a few hundred) this can block new requests noticably
>> which need the lock to remove a file to access it.
> 
> Looks entirely like a trivial implementation bug in how the list_lru
> is walked in nfsd_file_gc().
> 
> static void
> nfsd_file_gc(void)
> {
>          LIST_HEAD(dispose);
>          unsigned long ret;
> 
>          ret = list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
>                              &dispose, list_lru_count(&nfsd_file_lru));
> 			              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
>          trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
>          nfsd_file_dispose_list_delayed(&dispose);
> }
> 
> i.e. the list_lru_walk() has been told to walk the entire list in a
> single lock hold if nothing blocks it.
> 
> We've known this for a long, long time, and it's something we've
> handled for a long time with shrinkers, too. here's the typical way
> of doing a full list aging and GC pass in one go without excessively
> long lock holds:
> 
> {
> 	long nr_to_scan = list_lru_count(&nfsd_file_lru);
> 	LIST_HEAD(dispose);
> 
> 	while (nr_to_scan > 0) {
> 		long batch = min(nr_to_scan, 64);
> 
> 		list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
> 				&dispose, batch);
> 
> 		if (list_empty(&dispose))
> 			break;
> 		dispose_list(&dispose);
> 		nr_to_scan -= batch;
> 	}
> }

The above is in fact similar to what we're planning to push first so
that it can be cleanly backported to LTS kernels:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=nfsd-testing&id=9caea737d2cdfe2d194e225c1924090c1d68c25f


> And we don't need two lists to separate recently referenced vs
> gc candidates because we have a referenced bit in the nf->nf_flags.
> i.e.  nfsd_file_lru_cb() does:
> 
> nfsd_file_lru_cb(struct list_head *item, struct list_lru_one *lru,
>                   void *arg)
> {
> ....
>          /* If it was recently added to the list, skip it */
>          if (test_and_clear_bit(NFSD_FILE_REFERENCED, &nf->nf_flags)) {
>                  trace_nfsd_file_gc_referenced(nf);
>                  return LRU_ROTATE;
>          }
> .....
> 
> Which moves recently referenced entries to the far end of the list,
> resulting in all the reclaimable objects congrating at the end of
> the list that is walked first by list_lru_walk().

My concern (which I haven't voiced yet) about having two lists is that
it will increase memory traffic over the current single atomic bit
operation.


> IOWs, a batched walk like above resumes the walk exactly where it
> left off, because it is always either reclaiming or rotating the
> object at the head of the list.
> 
>> This patch removes the list_lru and instead uses 2 simple linked lists.
>> When a file is accessed it is removed from whichever list it is on,
>> then added to the tail of the first list.  Every 2 seconds the second
>> list is moved to the "freeme" list and the first list is moved to the
>> second list.  This avoids any need to walk a list to find old entries.
> 
> Yup, that's exactly what the current code does via the laundrette
> work that schedules nfsd_file_gc() to run every two seconds does.
> 
>> These lists are per-netns rather than global as the freeme list is
>> per-netns as the actual freeing is done in nfsd threads which are
>> per-netns.
> 
> The list_lru is actually multiple lists - it is a per-numa node list
> and so moving to global scope linked lists per netns is going to
> reduce scalability and increase lock contention on large machines.
> 
> I also don't see any perf numbers, scalability analysis, latency
> measurement, CPU profiles, etc showing the problems with using list_lru
> for the GC function, nor any improvement this new code brings.
> 
> i.e. It's kinda hard to make any real comment on "I do not believe
> list_lru is a good tool for this" when there is no actual
> measurements provided to back the statement one way or the other...

True, it would be good to get some comparative metrics; in particular
looking at spin lock contention and memory traffic.


-- 
Chuck Lever

