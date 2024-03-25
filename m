Return-Path: <linux-nfs+bounces-2467-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2CF88AB39
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Mar 2024 18:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1218E1F3D8AC
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Mar 2024 17:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B870F3DAC18;
	Mon, 25 Mar 2024 15:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PXeRe6Of";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uLIXWeXX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B853DAC15
	for <linux-nfs@vger.kernel.org>; Mon, 25 Mar 2024 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711382288; cv=fail; b=oyQKQmbjjk6jNlFs3f2ieB46LBbpA9VTWW+kP2XlEO6AvSMLMsZgHM2CbYnKlggkhFX6O1LmvY6BUDaElmTXw0niZe+xlDrRExkH9JsHp7VgHsED9KgJdk016EymMT15xpAOcEOI8wp9y1dZLM0/27NlMocZUFg2OOVtLGWdOck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711382288; c=relaxed/simple;
	bh=Tsekx5aJ1dX1wRAcf8HnHyxNXO+ync/MNMLE0DlLqE8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Hk8ySI1Tk5Cax6k0oPl/GtblATlCKm5hhXeffo09m6GI/xKUe+9boVYIllFqub4+fSWR8SCreXqgKFq4LD7aGcSQiKHtU+YyoZkrdUXnChAdd7mzsJynD83aw/xbpPlJwE70JUInAde6ko9TlNZZXGTmLNNBaKKrgE7Guj5UgfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PXeRe6Of; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uLIXWeXX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42PC3r3F010944;
	Mon, 25 Mar 2024 15:57:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=TOA4XH+QrJXVIMWlgrMcwlIiH1FHtihpZ/E4p3ZvhDg=;
 b=PXeRe6OffriWFWWWEZvf5Hcwfz29iUViBJTMhcFfcUPW2q1gyz3pwBQnH59u3r6aUh9R
 oNLzoaMO95624CeLwgpQoAmx6fV+F7a4dSFZe6qG8e9oX9NQtCEUOJRwZLn6gcinO7Xh
 5ff+BFNe1Ud9Z0tv2ERSRKzEgevZRMLai83MZ20PZDhVwS1vo5+JzTfIavweBQvJwRbA
 NhDbJlQblDQ8SkFXG3oS5cxIFFS39tN6l/Uw1hZwhTt4ZY+suJEFM48BNlGCvV+C9dlG
 +WBlkQs0nNhEnJdrnlaFv4os0mvvpEOiHP/QNqT5ThAgVvoZFD09VYEk/DJGSXZpYN4P rg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x1ppuk2j0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 15:57:44 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42PFOSIl006893;
	Mon, 25 Mar 2024 15:57:43 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nhby4rb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 15:57:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khy0/tfLLjTlGqdNdkVkBb9tK6gbkTxNQc1fLmI2BVhwFDgKNglauQwh7TNCra/gE1JA48vWThAKnYH2fdpK9uN511Z7sGdWKosHH3+EvJaF10NhPUJgDHbw8VDwEQ43b9dIysk6UHlzMGcjTwxoOhweVmZMqcDkNVUPxATn4mN6oj4sszufOfSmIkUrP+ygbs6ZTd3HWlaNuVj+5Qttg397BGc0jgXolr8ylh8HimWorZmOahawrY05peK5+++7Fk+BP8yHuy9a5SeOQn3XUgLkG3N8eb8Jnnp/D0BR2TwYNuDjEPTU3OZ+Hl7FvzfAJDgTSq5GvR2Wr9FtC9gEzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOA4XH+QrJXVIMWlgrMcwlIiH1FHtihpZ/E4p3ZvhDg=;
 b=VX8JgRywXxk8MGSBGnxiVR4aV7n6wWEwWfPaaAFn+Zm8xN695P8P2sFqEPq+dBz6dVEcAigXozo7bArIOtPVuhht5M7ctxbdYA0+FNCudZFj3uZNuNm8ArtXVxVO+x1fiSR+2syOp+laSezc81Q+LS2F2q4PO3FAtBL9YCWhCxJmX/Gt/QtZPLtZlQ4Ape/FFBzkO2UovmbPk1ZHLjEqVhJzvDJLnySC3jjTTEyLl2+KHUaoBoEVVQxTW1b+fIgkpWQSWnI79l/TgkqgC/gOcrwZKveqJQ++4OH47axkXgmBxnHfxFlKkNiuMABgGdGBXlQDV6VA4hD2w/NhXSsnoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOA4XH+QrJXVIMWlgrMcwlIiH1FHtihpZ/E4p3ZvhDg=;
 b=uLIXWeXXDJ3bszC9LEtaGddzQLdO24+SKCO1znqwQ/xuMzCARbetoHAhA5ftEOTQMAj+LyrpI2HU/cNT2F5UNTVbgCaksRGJgnb8Vlvgbj2aHqJXz2P5GJrwpcMmcW1luCYmTQA5u+3Z40QmQMQK6PvidIFrHyZ8q8s4Cm+bTzQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB4902.namprd10.prod.outlook.com (2603:10b6:408:12a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 15:57:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.031; Mon, 25 Mar 2024
 15:57:41 +0000
Message-ID: <2803859c-8849-4f1c-a75a-f1f0307bbb01@oracle.com>
Date: Mon, 25 Mar 2024 11:57:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH v2] fs: nfsd: use group allocation/free of
 per-cpu counters API
To: Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jeff Layton
 <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Dennis Zhou <dennis@kernel.org>
Cc: linux-nfs@vger.kernel.org
References: <20240325132139.113933-1-wangkefeng.wang@huawei.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20240325132139.113933-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR20CA0007.namprd20.prod.outlook.com
 (2603:10b6:610:58::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BN0PR10MB4902:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a8e0dc1-ca5e-44e5-6d65-08dc4ce44d49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	TawWOwKs4ZwWHxjxQQmAWavHRI5U0HceKsQTX1AUH/vvPjoz8Zl7w18uBt/a9PpzrKB+dQZQyz15sIQRllnmZq8TbBEmRKD7lnJv46OPGuT6tD27jjCvVbN++ht+HEXddzQr42ATwlSy/QrSlzQ0RsY5pIV6ZeFv+jF1gSa1Ju+IImh6uxoLOlvkOy/zto9+r30HIhODEZB//nccHGTTkzFSML2GwN7FDmJC7fRNB3fjrhUFHtQN+iRZ1InACXuud7wwHAP3YmOVvxbyBwJ9wDRwRJu1mFp4MN6rorUWUdu/+m03RwnmTlgzKq0BrYzHNjMECoto8ZEfx39tKrEO97l9+4V1iV0/46uq/rB9txt712/ONIdBDy44iKfCbn8gnT16s1eX8IYKAY+QzJYIcYNz+8NcQdBT/uJRcL1PzTSSARhFPdSgM/77TqsgIhQvkPP7YV0H+ZQuf5Vuvilu2J8pk/uubcmgapyuS8dVhoaVm4hXogKBoc0yOBlVEtF/cTtpOE8R0JvxFd7vTnGr8fCToKhH90jzMkwlQl4Www4jhHyQaE20Z+zWmm9UsqVVRHMQGJux03b6+ui7T5xIQhrtsiBlABsC42zIsKxEZEO2wD5TsY7P0I7nS9j6AhkAvD7Vd1igrEFBme2YaIOAbZi5k6QI08sW06cocsPjvz0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MUpxajFhNkYxRVRPRVdXY2g0Q0tJOFNkQ243QjRoQ1VLZGdNREV4QmhZdU4w?=
 =?utf-8?B?cUdDUURLLytNTUYrTWh0SEJaVjVDaEVOTko4RTRxb204L1FkWnRMYTV0QlNx?=
 =?utf-8?B?NEtTZHo3amtWUkp1SkFqUnJBYjV3VzJkdHl5WEVpT2hQMU1qQkFBamZPczBk?=
 =?utf-8?B?akMwR3NuRVQxRkJuTnpLem9salZpWExwVWcrQzRoaXVhUXZUY3lhMlVad1lq?=
 =?utf-8?B?ZHNMTkxLZVo5VzRDbFFZTWZEcFVhNWZCRzFyTnQ4akd3ZnlqSVdSYlc5bE80?=
 =?utf-8?B?S21xL0lrOVE5SHd4R1hlQkJ2V25tTjBpT2RRc3kyTjNtVllhK3RsNllCNFIx?=
 =?utf-8?B?Tml3VFhsYlhyQk52OHQ0S2lQdERqbXhEeFAzNENqaktwMStrT0dkdjlpcHYr?=
 =?utf-8?B?SEtiR2hEaCtrOWJEOFBhVUNsWFpkckFralA3TUhDTGZvN3BaOXkzNWd0b2Zy?=
 =?utf-8?B?VFBLanpVOTVFc2JuM01sSVdKZjVCaXBrWUlpcTR1UUNQbGR3dS9HSnc4dWtR?=
 =?utf-8?B?eVhBVjZPMThHWDdSVGZVTms5MEIrckZLTGJvSXlkZTVpaG5DUUY2M0hGWjUx?=
 =?utf-8?B?blYrMUFMV29oTVUvYm52cVYvZTJWWkdHbUMyeFZkbmJhNmx2YllNRXJKTmxF?=
 =?utf-8?B?WDhpdktjQUcxd3BtSTBPK0pNNGYyak52ZHdGeXljNnFZSkthdDg0dmtQM2pO?=
 =?utf-8?B?S0U4T3Y5NWt6ZEw3Zmdsc1BkVXdneXlJRXFtNG9LZGYxOTlhdUxPZmZUc1ZL?=
 =?utf-8?B?b09rMnB3QkI2R2tGUUxQTmx6OW04UUptR1h4eWc1TWEzbHRpUWVrR3VLZ2Zm?=
 =?utf-8?B?QzI5eUp1dmRHTVU5OXVGbkdNcFkxNFozd096TE5DTVJlSG03L2hSOVJ0eFdF?=
 =?utf-8?B?Mk9iTEhTdUt4dFg3eW9KS0wwbllOWHFzeWovWmpoRFhmakp1N1lHcjBrTWlZ?=
 =?utf-8?B?NUtiSkpyb1ZyTm5rZ0JVSTc5eFFPb0REc2h2RzNzOElOQTlreUlaaVllZmUr?=
 =?utf-8?B?eTFUc0dUdWZISnhJTFY5Wm1LWTFyVFZIWWQ2RWlwS3kzSDl3SDN1Q3gyNCtF?=
 =?utf-8?B?Q3NTYSt5UzdjT2l1YVZyTjAxeS82WlI3VHVocDFRNmdhbEs0c1Nlc2ZwaFZr?=
 =?utf-8?B?Yzd3YzVrOVJnT1ZrSlU0NE0wckhzclhLUkFLVmdoWnU0REM0YkxaaVZnZ3FC?=
 =?utf-8?B?ekpMVFRKNEZnN2g0SzZqN0Z1WmFGRGZsZDh5cHBwdEIraVdzVU1HbklIWTNl?=
 =?utf-8?B?OXRVamxJcnNRZ1RFMlZ2OFM0RXVqY2lPUEtxMEgxTjFPbmZQQ0dVM3psalVM?=
 =?utf-8?B?MkhNTGErZ1BVVnFyZ25YRkZZVk9kcGR6R1N1K1BZa1NpWjhnOUlvVmgvMXRH?=
 =?utf-8?B?R2hUeWpZREZkV1F4N3ZHY0wxMHpEWUdrNVp0OGI5WU0vKzN3dXByTGV4TWhs?=
 =?utf-8?B?eGlWQzhrcTNkNDRKQkRTUS9FK3NYMEhoQ01HTVFwZFN3OEcxT0YzTG5wdjFH?=
 =?utf-8?B?YWtDcll1bzN1SUxPUjBFZU5PbkQxbkdrOEZKL2RPQUZRVjYxcVdoU1JMandS?=
 =?utf-8?B?Y1dXRnVFTkxtV1c4eTRWSzlqWUh6bERmajVaNUkzSnFnU2lxTWhENnR4TEkv?=
 =?utf-8?B?M294YmJWWnYvL3lEQ2tKYUo1Ly9BRUZMODhPRDQwdFQ2M09SODlyaXJmV2ph?=
 =?utf-8?B?QkJvcDVSUzNYS0tvNjhkR1Q0c0ZTR3ZaL1ZkZnV5QlQrU3c3MVRtNUwwaEVC?=
 =?utf-8?B?UVF4Y0VBdjA0R3pjS2dJdzBBdG5qU1VEdGJ3NDZLN05nSkxqblZLQ241dERL?=
 =?utf-8?B?bUtXRDRWTWpsNEdla1NMSXpyNXY4aEF4WnBuRFcwczNLWHlDL0c4Mk1NSThF?=
 =?utf-8?B?VnM0MVRUc3JSOGtBY0hwU2lMYWI3amdJV3c5QTFRZGFqQlNkNVdlUVhlVzha?=
 =?utf-8?B?RXgvUEdkdmcvK1pNeC9WYmN0NW5UV0FIVGpOMG04T1JLZm5QcjNhMHF4R2NI?=
 =?utf-8?B?ZEIzcGxvQWZiNUk4REdGSnFlMHk2d1hQeUVMWWZyVGp0SGJucnNlWHlJWnhD?=
 =?utf-8?B?aEVna1NZSk13RUowRXR6QXJmQ3IvcDYxQmlzRXJnT2NKVVFvZHR2OEdteWNq?=
 =?utf-8?B?SDBhWHdGMmQ3TzA2eWtsUFBNa09sVDVFbnZSSVRtRGFPM1p5d040cDdmV2pz?=
 =?utf-8?B?OUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Dbq0+40h8k3cgATgGVeqXXCGShnxieMXPbfWBC/gUotackplWTa95vs4PV6/yJVHvsgYw+doYo9Up5RRY2WL17eTObMMMRwJPuGaLQN7ruhT9IJNmw4Cg72rnvYbbQzMx5zMsQldXgXzXTTxI8QlcKqpbUWh1vdqyL8sW9ugCOHwrmGjnfz3JZwsPut1rTY4n7GpCUrRLJfJNjO4eCouJEySLFvK3FtquULhDDxaP653XLdoiGvx7NKAQfpWvIvnqbpSl2Wgol4wLlQkOc1CZXs8BJw1NnbNCD5akk9CwvN3JDuRGGn7Kbfo4lZz1hqsDHDnW40jiJFdUx3MZOsLbX4HRvOk/gffUw+tZdGWC+wRlNf6x8MVoziicvt/ljg9JaCG4/ZJgywHr7xntnVUWlZFEMgDFmUePbVgoXKIAIetrJdflsD5RpHF6dBD0rgGachiJZjjhLaMJPMSunIKN5z92OcPbAPjw6o6owUNroc7V91NtRugiZKJTEbvsWzrAFbRWoUcWt8eet32tLO3lTP/WBEnmHzwzV4WDiC4uEHJjfsuRLvxEf08H2X2rdsLwewjQjUTO52z4xwjexj0OKP0oTKpOeNq94zGoWrnCAI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a8e0dc1-ca5e-44e5-6d65-08dc4ce44d49
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 15:57:41.3739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MAhKzUWpFI/556UXG2y7QcW+saA+f8ifeUxHXqNhvHWMfBXAtOPH3ZnAQFo5SYQmDdRODaPyueUwzMHv4pTCUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4902
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_12,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403250088
X-Proofpoint-ORIG-GUID: Bp3sQeLWP5AZ8Dk0DaUnffS1RNpDBaVM
X-Proofpoint-GUID: Bp3sQeLWP5AZ8Dk0DaUnffS1RNpDBaVM


On 3/25/24 9:21 AM, Kefeng Wang wrote:
> Use group allocation/free of per-cpu counters api to accelerate
> nfsd percpu_counters init/destroy(), and also squash the
> nfsd_percpu_counters_init/reset/destroy() and nfsd_counters_init/destroy()
> into callers to simplify code.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>


Applied to nfsd-next.

> ---
> v2:
> - directly use percpu_counter_*_many helpers and drop wrappers,
>    suggested by Jeff Layton
>
>   fs/nfsd/export.c | 16 ++++++++++------
>   fs/nfsd/nfsctl.c |  5 +++--
>   fs/nfsd/stats.c  | 42 ------------------------------------------
>   fs/nfsd/stats.h  |  5 -----
>   4 files changed, 13 insertions(+), 55 deletions(-)
>
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 7b641095a665..50b3135d07ac 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -334,21 +334,25 @@ static void nfsd4_fslocs_free(struct nfsd4_fs_locations *fsloc)
>   static int export_stats_init(struct export_stats *stats)
>   {
>   	stats->start_time = ktime_get_seconds();
> -	return nfsd_percpu_counters_init(stats->counter, EXP_STATS_COUNTERS_NUM);
> +	return percpu_counter_init_many(stats->counter, 0, GFP_KERNEL,
> +					EXP_STATS_COUNTERS_NUM);
>   }
>   
>   static void export_stats_reset(struct export_stats *stats)
>   {
> -	if (stats)
> -		nfsd_percpu_counters_reset(stats->counter,
> -					   EXP_STATS_COUNTERS_NUM);
> +	if (stats) {
> +		int i;
> +
> +		for (i = 0; i < EXP_STATS_COUNTERS_NUM; i++)
> +			percpu_counter_set(&stats->counter[i], 0);
> +	}
>   }
>   
>   static void export_stats_destroy(struct export_stats *stats)
>   {
>   	if (stats)
> -		nfsd_percpu_counters_destroy(stats->counter,
> -					     EXP_STATS_COUNTERS_NUM);
> +		percpu_counter_destroy_many(stats->counter,
> +					    EXP_STATS_COUNTERS_NUM);
>   }
>   
>   static void svc_export_put(struct kref *ref)
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index ecd18bffeebc..93c87587e646 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1672,7 +1672,8 @@ static __net_init int nfsd_net_init(struct net *net)
>   	retval = nfsd_idmap_init(net);
>   	if (retval)
>   		goto out_idmap_error;
> -	retval = nfsd_stat_counters_init(nn);
> +	retval = percpu_counter_init_many(nn->counter, 0, GFP_KERNEL,
> +					  NFSD_STATS_COUNTERS_NUM);
>   	if (retval)
>   		goto out_repcache_error;
>   	memset(&nn->nfsd_svcstats, 0, sizeof(nn->nfsd_svcstats));
> @@ -1704,7 +1705,7 @@ static __net_exit void nfsd_net_exit(struct net *net)
>   	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>   
>   	nfsd_proc_stat_shutdown(net);
> -	nfsd_stat_counters_destroy(nn);
> +	percpu_counter_destroy_many(nn->counter, NFSD_STATS_COUNTERS_NUM);
>   	nfsd_idmap_shutdown(net);
>   	nfsd_export_shutdown(net);
>   	nfsd_netns_free_versions(nn);
> diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
> index be52fb1e928e..bb22893f1157 100644
> --- a/fs/nfsd/stats.c
> +++ b/fs/nfsd/stats.c
> @@ -73,48 +73,6 @@ static int nfsd_show(struct seq_file *seq, void *v)
>   
>   DEFINE_PROC_SHOW_ATTRIBUTE(nfsd);
>   
> -int nfsd_percpu_counters_init(struct percpu_counter *counters, int num)
> -{
> -	int i, err = 0;
> -
> -	for (i = 0; !err && i < num; i++)
> -		err = percpu_counter_init(&counters[i], 0, GFP_KERNEL);
> -
> -	if (!err)
> -		return 0;
> -
> -	for (; i > 0; i--)
> -		percpu_counter_destroy(&counters[i-1]);
> -
> -	return err;
> -}
> -
> -void nfsd_percpu_counters_reset(struct percpu_counter counters[], int num)
> -{
> -	int i;
> -
> -	for (i = 0; i < num; i++)
> -		percpu_counter_set(&counters[i], 0);
> -}
> -
> -void nfsd_percpu_counters_destroy(struct percpu_counter counters[], int num)
> -{
> -	int i;
> -
> -	for (i = 0; i < num; i++)
> -		percpu_counter_destroy(&counters[i]);
> -}
> -
> -int nfsd_stat_counters_init(struct nfsd_net *nn)
> -{
> -	return nfsd_percpu_counters_init(nn->counter, NFSD_STATS_COUNTERS_NUM);
> -}
> -
> -void nfsd_stat_counters_destroy(struct nfsd_net *nn)
> -{
> -	nfsd_percpu_counters_destroy(nn->counter, NFSD_STATS_COUNTERS_NUM);
> -}
> -
>   void nfsd_proc_stat_init(struct net *net)
>   {
>   	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
> index d2753e975dfd..04aacb6c36e2 100644
> --- a/fs/nfsd/stats.h
> +++ b/fs/nfsd/stats.h
> @@ -10,11 +10,6 @@
>   #include <uapi/linux/nfsd/stats.h>
>   #include <linux/percpu_counter.h>
>   
> -int nfsd_percpu_counters_init(struct percpu_counter *counters, int num);
> -void nfsd_percpu_counters_reset(struct percpu_counter *counters, int num);
> -void nfsd_percpu_counters_destroy(struct percpu_counter *counters, int num);
> -int nfsd_stat_counters_init(struct nfsd_net *nn);
> -void nfsd_stat_counters_destroy(struct nfsd_net *nn);
>   void nfsd_proc_stat_init(struct net *net);
>   void nfsd_proc_stat_shutdown(struct net *net);
>   

