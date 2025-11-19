Return-Path: <linux-nfs+bounces-16559-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BD78DC70187
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 17:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AEDA64F900C
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 16:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BC133A6FF;
	Wed, 19 Nov 2025 16:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L94aKg5J";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CeLpn+Aj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2198433A709
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763568912; cv=fail; b=Fky6dE8JqoYgmTBQkiLM5TiiIHZAwUhh4J67Dket/5Parjik/iGRhCEYSsL6E1CTHkTMYiIzlKIqkZUmp0lrM5T1WRjrkLNN08XH7jGeTfB7nprAwuHUAzKZaZHl9MPRjFZh/FrmeB8POIJiiMJ4irH/+7/qheCmMDj3cHXjQ1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763568912; c=relaxed/simple;
	bh=aZwYvF3JzsN2u2i9WVcMcEiCeGycNVWsVCAJrCVZD7Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PLiKgRWOuqKQUbnlz8zRLg264m8TC8X+Z5n9qfss2l7sbG+Oav0hJz5tmCWreffPnHh3Xf2PO/0iPFbCyOZ14K85CGmFnJo5EYOIfug6Oi2w9a6WQ9ZeNsfiWmhMgDbiKaGaiKJj+KT2CZ6zdZCUK8fbQsFWmMk5bqmyJp6Jenk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L94aKg5J; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CeLpn+Aj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJEfvXp021304;
	Wed, 19 Nov 2025 16:15:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=nIw4fr02eyBXDRItLFGsWtLsCiAADLqi0JVHIB7iJMU=; b=
	L94aKg5Jy4DfrKNhLVZwBhGm1iwmjZyfq1Yuzism3gt0mZzCY51IYzqtNKewnXW3
	3byBytMsUpQQ0tN2SbBSdlDYCCmsnQBpujFm8/7yhgK0MSDS3KQh9h0fMydyPQfh
	qoVxsYWkdB7MDGzfXfNaWXEQtSnyW9T7RdJag3/I/wuqk/N/nZKYGYxjs5HFHq3u
	u/zI/nJOmMff+EyGhH4pDvhtZF8xKNMaoHgJM6X6aRUOddnHJW4rOIYm/suuLJzn
	VB3mFx+QhGk4kGX17ZwoQGdhILB53zGvLC/EORwyMZY5DJfVX9M0iBgdv/b0WY/5
	t+DKXD4C88FsBdljRIk/FA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aej967adw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 16:15:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJFU8dm009600;
	Wed, 19 Nov 2025 16:15:06 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010014.outbound.protection.outlook.com [52.101.61.14])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyeusqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 16:15:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4yIRGFbMYCH11034tOu8nqRXqOmKTgJDrYJEAEOCSH9ZohFqApG8EP5/Ecd+9ZCt41oAKj4zHVTTi7shHL+iJS1YI7C3ouTlSXEjqYk60N7W0petGK4rJP+pDEgW6JfDAgxd6mSUj56FpFJX0sPFENA6cAtSujYm2FdCm/8Y+/f1fEVeKbdQZgmVY4R4d7pophX6C1/SIHtCLdfs2/em5sHYEiYaNAYuF4qa6lgD0ieY3WJLi/B550in90+NZTQulTNWnUiC+XEzkR0u+rzosrDxrkP3pQKJ/4CjEP3iNtRNnIxQ3Vn4/lVz+U5lgYEzTZy/Sr3Hi4n5gtSxWT4BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIw4fr02eyBXDRItLFGsWtLsCiAADLqi0JVHIB7iJMU=;
 b=E9ajGXEmxhor82fq+w82qQvQCoBjUMmBaCG2HWG6ISdHSujhx9TOAZ+5UpSGiPjXsjSYlW4wynMppqKZhHVLHvh0Zg+uTPCY8HHVFvi+/z00m5NxIqqykelRkehx5ahfgpJvsIjIyLFLdUa1PYDgqBqOH6iJsXrUqcpqr2LRFJ+W7O10PL7sfXXZuSumJX5lhHDncsLT+diocCTuxBQRMQqFhYpKWPnIwn8VAAapzV+15jQMp+ZuxgPb46o4raaJU3gfVurXvPkms2iT8hActHvq6VCNwiV1WN3au/NIel3jsvQ/+AN0lZ5dflU8hteoQfjtktj0PiVtALkPSoZWCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIw4fr02eyBXDRItLFGsWtLsCiAADLqi0JVHIB7iJMU=;
 b=CeLpn+Aj5bjRb7JCbubc8I0I03iwggTCS7DwAdpjcO4NsxTrD12t9N9DN5znYT1trBdxLDvx/0Y8PmHwZJyeEq1FiK7J2gACYrIXzaqnu3os9lpF08UoqGNin6yB017OYrv49gnlbHzmod/fREivIAQdfgcWyErZAXJ+TB0OIFo=
Received: from CY5PR10MB6012.namprd10.prod.outlook.com (2603:10b6:930:27::18)
 by SJ0PR10MB5857.namprd10.prod.outlook.com (2603:10b6:a03:3ed::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 16:15:03 +0000
Received: from CY5PR10MB6012.namprd10.prod.outlook.com
 ([fe80::192:a20d:4346:47ae]) by CY5PR10MB6012.namprd10.prod.outlook.com
 ([fe80::192:a20d:4346:47ae%3]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 16:15:03 +0000
Message-ID: <39bca1e3-340d-4908-95d7-030507fb7b7b@oracle.com>
Date: Wed, 19 Nov 2025 11:14:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] NFS: Initialise verifiers for visible dentries in
 _nfs4_open_and_get_state
To: Trond Myklebust <trondmy@kernel.org>,
        Michael Stoler <michael.stoler@vastdata.com>
Cc: linux-nfs@vger.kernel.org
References: <53bc46637bdc4b267a318c74fb4c97cb382f29d1.camel@kernel.org>
 <cover.1763560328.git.trond.myklebust@hammerspace.com>
 <4c4b51c67f7b38e4df4cb389007058e37ade0d14.1763560328.git.trond.myklebust@hammerspace.com>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <4c4b51c67f7b38e4df4cb389007058e37ade0d14.1763560328.git.trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0046.namprd07.prod.outlook.com
 (2603:10b6:610:5b::20) To CY5PR10MB6012.namprd10.prod.outlook.com
 (2603:10b6:930:27::18)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6012:EE_|SJ0PR10MB5857:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c60c1a3-f0a7-4ed7-697b-08de2786cb92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YTcwZEIvQU50RmIxcmFGREZZTC82TE1xRXhsYTBIS2xaamt0Q21aZFArQzhv?=
 =?utf-8?B?Vy9XNStOVVdrVEJ3MnF6ajBocWt2YVNqTE4rRlpyM0hoNnJoZlVJakx1c0tn?=
 =?utf-8?B?NllqUGxNWnVDa0RVS3RmN0V4cm9WeTcvdFA2eS9oQWd5OWxoWllvTVQ5OUVa?=
 =?utf-8?B?TXRaZ1hud3pGcXFJUzdKd2FnWk9MYzMvL0xDcFdMMldZNnM5TnlOMk1hemU4?=
 =?utf-8?B?UGdCZTIyOU16Y1crdkRwUVRONCswMlZxS3BIdjdOTFRPRTNMYzJCc3BiL010?=
 =?utf-8?B?cjYycm0xWStKVWljd2orSy9WWWx4ZTdvRnliZ01MNExqZmdaV054UFFXWWpB?=
 =?utf-8?B?Sm0zS29QQk5Lei94VG8zOUYreFhYcWhDbzJPYkRpbzI5dzN2eTBxNUlTSXlJ?=
 =?utf-8?B?eUhOVXA3UEwvaTZDc0FSWlRaYzc5WVBvZUR4M2VzazJaZ0EveDdKbFIwSlg3?=
 =?utf-8?B?R3VQUU94eEc3Ujl1dk1kNXkvOHpWSmFKSU5nayt0UW5tVThPM3hFZjFvMW9J?=
 =?utf-8?B?L0pGK1FQbzhwOHB3T2s3ZmNCRFFLKzU0Q1NjMWE1QjhYRDJyR0FSa0VITnJG?=
 =?utf-8?B?SzdPSFFSUlI1QmtqN29kY1hHK0N0SEVKd05EKzBxVWtaVGNTZUt2aEFweUFJ?=
 =?utf-8?B?b3ZiUDZ5clBZd0huTU5TYUgwOEhFdGxRM3BGYkNEak5QeloxVTUzU1dzY0hY?=
 =?utf-8?B?Qnc3c3dRZnZsajBMZ0U4K29wYW13UnU5STkxNXlzQUk5aGxGNmRCTFB6RFIy?=
 =?utf-8?B?Vm44ZzdLYStXbEs0eUNFWEh3ZUNnT1lzVGNnbVJqbjBGL1RBdnM3NC95Y09v?=
 =?utf-8?B?aGFaTFhITUJ1eHJGeEJxZ05jMTllN0J4eTZZWERlZ2FlQkVBSzBIUGd4eldG?=
 =?utf-8?B?NG9qMHk5YlZ6MkRYUTBsRmFnbFJPLzN6VUpRS3VqUWV2VjVzTlY4RmJZQ3lv?=
 =?utf-8?B?b0MwRmhMbjVMZ1NGMHdsTDREQWZhLzRiSmJ4cVAvdGxPUXlROElneTFIeXJi?=
 =?utf-8?B?bUt1WHhZeEtXNVFJc0dyREYvUHBsS25JbDFCSVN6SWlKSE1wOU9DSHVUZnVT?=
 =?utf-8?B?OEdYYTNUdVIwajhBYnFlaHVoQkViSzh1cXlTWVBtTzB6ZjBCbHo4VXlOUDVv?=
 =?utf-8?B?OVNnQlRyVGtQQVY5SnRYYzdpV3FJTDJEajNBYVgwTmpaQkVGRlJLWFZ3N3Bm?=
 =?utf-8?B?dEpEZDJ6YzFOcXlGREJGWU1STmxnUkxIVW5lcVhCa0JubTBqVTdXcHlvM2pM?=
 =?utf-8?B?d28xVTA3eHJLMG5RVVpjQmIwY2Fsb01KMmNtcWZvS1lQNW9TNi9Ld2pRZ1p2?=
 =?utf-8?B?c2pRTHh3VXA3Z1ZvMGxpNCswWGlMYWlraHN2Um5kMTRCN0JDRnE3dE03Tk9G?=
 =?utf-8?B?ZHowYllNVTBkV2tpWmhDSTZMVC96TjNQQzgyRnBKcTVWeHgyQ2k4TXVZVTVh?=
 =?utf-8?B?d2VCSmxjVFVRZ2NaT2hlSlVtck52M3l4UkJtVVZ2T1V5WWpoV1dnd0NxajRS?=
 =?utf-8?B?L0szQ21uQ254SWJWdjZzOXI2dXdLSGJucXJlRFZaK0FUUjYyS21SV2RQUEFV?=
 =?utf-8?B?cDZ4RkVnQmxKYTFNLzBnRkhYTU03YjNoendCZDlBaGpEbGVTUzJDcklTR2xQ?=
 =?utf-8?B?L2p0MUhpdVBrMWFkMzNYbWZxRUk2d2pqaURFV0Zob2U4Z1B1QkJwcGlmNGJ0?=
 =?utf-8?B?eUlqeTNsT2RZS2ttRE1KMHBnUC82ZnJBa2E1dThYenVLQmhCWHBnWHpBNkNF?=
 =?utf-8?B?d2FUUG9pL3QvVjFHaW5zYm84bE9EN1hOMUhzazVUZHhYeUM1Sjg3OHA3N2ls?=
 =?utf-8?B?V1hQTHM0MTQ5VjBPOWJsOVM0cmZIc203UTFKMzlJU1NMdHN0UnNtUEZETGNJ?=
 =?utf-8?B?d3pXZjRRWE15cDQwQ0dkTDFYY3VhQXNnV2U3ZXNneGl2NFNLYnZLSHFsVmFE?=
 =?utf-8?Q?heS/0+hSzTwCqHdXDDiI0QvABUftQpSR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6012.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1dqbzl2OHpzQUVwZW1UNFlyY2hOaXBwRTJrMk5LMjd3bS9GNWtCK2xzRE4z?=
 =?utf-8?B?WVRRalJ3K0pXSTVFZ2hkcHRyTSt2Zi9uYVJGbkFoWHpiVlZvVnc5am9PNUZ4?=
 =?utf-8?B?a1MwSndVTmVMTFYxNW0wUUNzdEdsTDVTTHY0RHM5azg1WWVPaG04S01nUk01?=
 =?utf-8?B?bm5DK1ZONUhaNjF6UFJUS1U0dFlWNmdXRlV2RWw1akJnVHMrRG5OM2NYbkky?=
 =?utf-8?B?ZU1IZTYyVmNBbnA4eGp4YWxaVXlveHovS2NDSEUxWmhSU2hBUlZGR2gwb1Jv?=
 =?utf-8?B?L2tKa29TejNUN2tuNHg2d1dKMFlKY3ArSjgrTThJbnBVazVpZjZldjdtenNB?=
 =?utf-8?B?c0RWSGRTL3phYXVENDhMdXIvZzNQc1czTHNuTXUvM1RtUkpqTWpUSVQ4Skhw?=
 =?utf-8?B?NjNscjVTODd0OTRTRncxZGNvcGcxTlpjTU56cmFnU3pJK1BvdFd6cTJ0aE9j?=
 =?utf-8?B?d3NENWF6bjBwNWlrVHBTc29jYkF0TS9lSWMwNTdHSlh1dXIrdnhUYlhyMHFE?=
 =?utf-8?B?MENrUlp3cTN3b21yM08zcXNmNHA4bHgvTyt6QTJDYTNpWjBGQ2xHSzNXOC9o?=
 =?utf-8?B?U0dWcHV1V1VSM3JsZXh5ZHh5T1ZJKzU3NDhrVERWTWZJZ1ZDTGJicTJqMTVJ?=
 =?utf-8?B?cDA2ZWowdEtOUVV2dlZINStHT1FYS3c1M1dlZDZDWWpUblQvakxNQTl6UGNt?=
 =?utf-8?B?TzBsbVZ4RDlBQmNCdXF2c0JRZ3BKU3czai8xVGN0cThyaXNTSUJOK1FZYlhk?=
 =?utf-8?B?c0NhMGQ3MmEyOVl6alI3cWhUZmoxWXZIdmI1ellIRkdtbVJkbmRpMWZqV0E5?=
 =?utf-8?B?RFlSVmYzemZlRC9KTGcyb1k2VE4zNnlTRTdFSms5Q3hnMkRJN1YyUXpOOXZq?=
 =?utf-8?B?bG9qWnp4Q3N0N3lSTlQ2OUVUbC9Hc1FnbVpuMlAyeHQxV04vM3hZRDJseDNI?=
 =?utf-8?B?Q3YxVHEvNDE3MXMrRVM3NHhYQzIrRkR2MnFrVWlmNUdnVldYTldpTndOZWc1?=
 =?utf-8?B?SDRJQmNza0k2a3NyOVEzZnUxSG43UUhrZnBkY21McnZKc3c5em5KSkhPTnJt?=
 =?utf-8?B?RWJQNWl2WmxLV0NZYmc0VTZkWHVBSTM3Y2U5SWlzKzVPQ3BjMUpJWkxoOXUz?=
 =?utf-8?B?ZTZEOGhORUQvTlNINGZTeHQwSjdmMjVsdGtqc21QN1RwblgxNmVSSDlGa0k1?=
 =?utf-8?B?UXZPU1V6cHYyeUZnK2ZPTGx6cTdaWEliV1hEaHdsVTBOZ00zWnBHNVRyenZQ?=
 =?utf-8?B?bDV3MDN2Um1CNzY3a1FzTGh0ZEZ5OHRJam5MTkN3d0NySUtDV2VqTktLUjNx?=
 =?utf-8?B?dHhiNWhSNWJLR0UxNTFPa2NNTDNUcUZwYUtjcGdSdFRYR3J6RHU4VFJuMFI4?=
 =?utf-8?B?MklOalR4aGFWNzIrejQxUHk0cmxwci9CR0hxVUtNZjVIM1NEVU0reGhhOUF2?=
 =?utf-8?B?S3hXRUpxc0JGK3J4WGpFSDZybERFUnk5Q2RzdUpFK1hqQnAxWC9HbEVobjJH?=
 =?utf-8?B?OVdma3lnS1VRdmlHMFFtaDUzT1hGd2ZpcDRVWWpJZkhVcEtpRVF0UE1nLzR4?=
 =?utf-8?B?UUhqVmY0cUJhcVBTK1FoNi9sOGlhS0Fma0FJMzBJY2RjTXkwVFlDZUVWL1du?=
 =?utf-8?B?a0djajBHREk1SGN1S2J6QmgzcG5HWVIvZzYzdkVteFdYcXVGQ2U0K0VrVEpL?=
 =?utf-8?B?cmw1Z3gxKzk2Z2tacmNnN3JxQTdiblVSTFo5VEJVWmx0UlI0OTltamNVVW8y?=
 =?utf-8?B?VEF3ZXdiOXNwbzhTdXh2VmI3cjNuREF1UUVEMjdkT081R1pQTXA4ZW94RU10?=
 =?utf-8?B?ejJuVzZadDVOUTBLekxrUnhLcnJGRkxsNzdtdTRwKzdMRmdrMGgxUmVSZDVu?=
 =?utf-8?B?cnExcEo3RldFQmpPbmF2UnpJTG1naGZVcmpiSlduNlJ1aW02STJpbWNYc2gr?=
 =?utf-8?B?RTNTNG9penV2b2YvbFpFTWdHUm9HUXNxR1IvcHVDMXJoVldUbWdhb09BdXBt?=
 =?utf-8?B?bDFrOVlqcUxWRy9VZVNVTXdvdUIvdVFuQXRjenFHSU1XNjZWdWhsQVB1K1A1?=
 =?utf-8?B?QUlCZHppMVlyWUNyaGhsVXJ4eHAwZHVHekpKeDFSRGFwR2dxL2hQbVpiaUl4?=
 =?utf-8?B?SGJ4a3RyUU1YT1YxZkJySkV0N2w1dnBSeG85am1HVG4zbzZXMHZ3QXk0T0hs?=
 =?utf-8?B?VUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	knFJJlrCUzYJ64nKuiZSjqEJtBVgRIjzU6xJnvDEwcsMiJuotRYj/U/Ynq6zEJTPzpsjfC8YtV1UH0VvLmxKJ1wjTmqBse/29pQm627b4WSYIYXSta6zIjlBxPWvGQiTgC02wBCg/0GqkLBVkpXwLMGPolgFNnuKuhAIiawPdFHhRnySzDydMG+clGowprb4WVgFNKAemydBPKo03AG5AOsDN7b0LN7Tj92p2y1qqhv/fgRUr3nzJ6/YwtXY0nf8FJABp7H4RDtq2aDOBQMd+3VE5C/X4oT4lLbdXttiwNNJfSxZET03D7ZVzGdyi6JnOEdv/Pa/PKew6+HC+qcoy9IRIfVtzwHvkadZY7YjuUQKzcBKc5laOWy6BzQ5E9qM/Po+ALl56jQ8c0INNpajOPjPtKZrIguSyGxStJIryx+EAWX8t/rvah7C/0tqo11vha5xFXwlZsIzJIKtEjaNssbn4x0puicu4vSMlwGZNdLfVzk6dEXx7d2yjQdqBx4rgsLKFNetuQP6a8NzPDqGlkh+q9kLKX24CgwCxIqXWulNKZ3EwkT5yWDnqbHlWy7/CuoY58BGegAJMzfFFQ06YeTIQ6gDz4v7hr785aZZDFU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c60c1a3-f0a7-4ed7-697b-08de2786cb92
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6012.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 16:15:03.0718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s18DF5XN1M4qrJPa76HliEMI3fxi1QGemYuP/gqADwzCwb3kp26ZGh3Nzl74dppvWJF7cHL8EsAWFagTREPkl8TVRatYhDm0Zra99251Y88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5857
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_04,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511190128
X-Authority-Analysis: v=2.4 cv=DYoaa/tW c=1 sm=1 tr=0 ts=691ded0b b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=SEtKQCMJAAAA:8 a=BQGwlwCTAAAA:8 a=npkoQ6jAemRITUvmFckA:9 a=QEXdDO2ut3YA:10
 a=kyTSok1ft720jgMXX5-3:22 a=HFqQS4YDwGEJ6BLTKAzC:22 cc=ntf awl=host:13643
X-Proofpoint-GUID: bHx_u5yU_WwlcJjcKQnvm0eZmFrOQz1J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX5PJvpZY+AIkz
 vB5C2jFkh1CoPjrok+rCdLjDb5F30UA9XT80SHzA35ptqY0+QuGF/DLBwSXost2U4lQY7ttIs9i
 AiRz6PcbwxkhnJ6rt+0nbjQ4yPWu5zGWD9LSbSwhskiRlatn9az80GpSg0pP+CLpbul1+9hQz8R
 9SA/vHb9J5tDQu6Hh6ctTGUDNVdhPPMcCwz4s0oFK6M3Atnp1pbd6e0o08ZQr1W2gJry8iQM15/
 jD1Iga8j+3AZ97vSqiM1KzVCygm1q7KFkXLTsy1OUHqZpbDcFsb/IAgowc8jsQD2M5X/Y53w9r6
 8PybIOQd8fTKjIltJjqcKzSs5p26tF0+a9FVtybAYiXF8Ggig9i8Gx54qVI+pCYQPkwpCwAYZr5
 /n2LHkbAKJcl2tDGYLbvpVW9O8Y4GN9H5o3HQEnvsE+4b08NrCA=
X-Proofpoint-ORIG-GUID: bHx_u5yU_WwlcJjcKQnvm0eZmFrOQz1J

Hi Trond,

On 11/19/25 8:58 AM, Trond Myklebust wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> Ensure that the verifiers are initialised before calling
> d_splice_alias() in _nfs4_open_and_get_state().
> 
> Reported-by: Michael Stoler <michael.stoler@vastdata.com>
> Fixes: cf5b4059ba71 ("NFSv4: Fix races between open and dentry revalidation")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/nfs4proc.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 93c6ce04332b..54595983525d 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -3174,18 +3174,6 @@ static int _nfs4_open_and_get_state(struct nfs4_opendata *opendata,
>  	if (opendata->o_res.rflags & NFS4_OPEN_RESULT_PRESERVE_UNLINKED)
>  		set_bit(NFS_INO_PRESERVE_UNLINKED, &NFS_I(state->inode)->flags);
>  
> -	dentry = opendata->dentry;
> -	if (d_really_is_negative(dentry)) {
> -		struct dentry *alias;
> -		d_drop(dentry);
> -		alias = d_splice_alias(igrab(state->inode), dentry);
> -		/* d_splice_alias() can't fail here - it's a non-directory */
> -		if (alias) {
> -			dput(ctx->dentry);
> -			ctx->dentry = dentry = alias;
> -		}
> -	}
> -
>  	switch(opendata->o_arg.claim) {
>  	default:
>  		break;
> @@ -3196,7 +3184,20 @@ static int _nfs4_open_and_get_state(struct nfs4_opendata *opendata,
>  			break;
>  		if (opendata->o_res.delegation.type != 0)
>  			dir_verifier = nfs_save_change_attribute(dir);
> -		nfs_set_verifier(dentry, dir_verifier);
> +	}
> +	nfs_set_verifier(dentry, dir_verifier);

Isn't 'dentry' uninitialized here? As far as I can tell, it gets set for the first time
in the very next statement.

Thanks,
Anna

> +
> +	dentry = opendata->dentry;
> +	if (d_really_is_negative(dentry)) {
> +		struct dentry *alias;
> +		d_drop(dentry);
> +		alias = d_splice_alias(igrab(state->inode), dentry);
> +		/* d_splice_alias() can't fail here - it's a non-directory */
> +		if (alias) {
> +			dput(ctx->dentry);
> +			nfs_set_verifier(alias, dir_verifier);
> +			ctx->dentry = dentry = alias;
> +		}
>  	}
>  
>  	/* Parse layoutget results before we check for access */


