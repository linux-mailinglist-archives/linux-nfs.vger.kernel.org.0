Return-Path: <linux-nfs+bounces-8948-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE0AA0474B
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 17:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B79F6160B82
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 16:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7A518B463;
	Tue,  7 Jan 2025 16:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k04Ak8hz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jYTI/oE6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2E0219EB
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jan 2025 16:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736268965; cv=fail; b=MAQXFFY2woYfwdVJpsTBej/vhYTJCs5sj8CPEIdxDWcVAKy+SpZo/Dutp2aBAJFbD+Y0vzWuQIFzPD/3Q2UIst1Y2UROkyBhoQY2a6o3OtNknnEMHMf3R6xdlmPumTcroyeRsVxWV8kc08BRODewhKAhXf9JyD8qwecfrufUvhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736268965; c=relaxed/simple;
	bh=hI+KyTUPqR0vM3YcMaNRfAjss8s5Nz7/EPk7dGIrM64=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hr2GZKJYWoHdyRsVRdkj5xW+jf/qSQ1BCC5QxjhAMWOj9E6ce6GonqbeU2fMG+pzeD5AulOjC1OcGBzldmFdIAfIdvF7EoZ9fUslZQfmvm1Shbp2T7fiQzOFOiRpfRNT2V5eSHJT6AcKzUJC/NUtIY3v/nPp1sBTMCPJWOrcZFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k04Ak8hz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jYTI/oE6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507GtpsE020585;
	Tue, 7 Jan 2025 16:56:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=GY55SKIt2tJkzuS5faPn+IJzitVLHCqoACYzFlVyBL8=; b=
	k04Ak8hzmZr24J9plfm1W446qtKqUEM0W2Kqmb0OLwY7FbKJ83Vm29k4zgQeKtjv
	NTpnGazYojMBJdyP9/hID6TkVsjZVR7PTACGt/Cu7cg5vOBEbdNydvlnDz+yBl68
	+2inUnOn3+EbMOMCyiOEvTdmZnxgMFBfcXT1WrxCpSlO8zVuKYBx1LBrbMw4PQdu
	Efty5lTsgYd2g/ziPS4QrYx2XxxjuYOA3cw9MimARTVxACMaN3eVzTVWAHDlEpC1
	n8vpuTsB7mpHiqUBJEQa2Y+bXVP4ZMiQAC5OrwmW+97dHNedkS32WxZb7wbsWTs+
	WiiL6P4x7018eeW59OJTZQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xw1bvyty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Jan 2025 16:56:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 507Fo1MN004824;
	Tue, 7 Jan 2025 16:56:00 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xue8qwjw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Jan 2025 16:56:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sYYdEKJX+n4cE817dFqjueogiKsmnZe97sIRL7AbZILHa2yfk7y3s89grBUz6a/SWF5AlAXeQ/p1ENPppAyHnliK90kVjmXw+RSjKPRYDJKmmrTxL8O647jFrZYbhY+kZkLC27cs8duI78SmUFE8ly6xvr//vMoFYGqP+b2VzF5PHh8PX9lk6+xkJWbTUdYPNzpX37sQEBAXH/NYUeycH0BoxkL4PxOKGWTfqeM7gyNHiW7qVA/NjQ2W/dqMx+ETNH6VVFtO2yN5g0zgIA1CfJ2baT5xCdMXR1XIyv+nFr5qf+YqyIy7ihnPwGKrFRsYWUf9oogJpo80HAuNiH8jUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GY55SKIt2tJkzuS5faPn+IJzitVLHCqoACYzFlVyBL8=;
 b=Yn8bU7JKLoKhHrSLr+wBDcREG580eifxzw/FaEtFGeh4JtxDeV3x1KsPcRWb0kw8qvYDbE1kSzq2Xtq8uIfU4A2FbnLfgAp3DqpciI6YZdNlZXMdlv3dnUBkqNUXnEXgXW4qfn7Yu0tgfGfNz7RevDMKfdsBCMxtOIjbWYKTZkGTIyeryCULkhXi4UZZQiZrSDNH9vYVkINrznqbayF2w7pBu38GSAgXpmEbmT1YOX5DEfcxG/hwl7WMnQ+00QjFAyLKe6eTYsp5o6BYqZJT81WQkJGuRBezsmJZRJ4FdzccetlahSeeIouJwzhPlnr6GJr0XteGHD33JfL/wr/okA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GY55SKIt2tJkzuS5faPn+IJzitVLHCqoACYzFlVyBL8=;
 b=jYTI/oE6hFUF6MKigp9hv6LUl8bNydU6N1zk1q1lGJ3yWg0efFQKlvKXqeY6Mm+GKtNPURPJuvl6rF89b68ZoEPQYfisvjYVlJ2Bux6sj61Raxp6D+6yQpSOH1zt1Rhtd5ZxutiJdtSg8aMgo6Pch8Utl8BSRqLPTjoeUyOI/jk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6221.namprd10.prod.outlook.com (2603:10b6:8:c1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.10; Tue, 7 Jan 2025 16:55:57 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8335.010; Tue, 7 Jan 2025
 16:55:57 +0000
Message-ID: <5c928bae-38e4-490a-a9e7-f52b27a462c9@oracle.com>
Date: Tue, 7 Jan 2025 11:55:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Needed: ADB (WRITE_SAME) support in Linux nfsd
To: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>
References: <CALWcw=Gg33HWRLCrj9QLXMPME=pnuZx_tE4+Pw8gwutQM4M=vw@mail.gmail.com>
 <e3d4839b-0aa0-42f5-b3d1-4fd2d150da75@oracle.com>
 <CALWcw=G-TV19UPmL=oy-HE9wc0q-VpHBVyuYcVQ8b9OQq-8Lqg@mail.gmail.com>
Content-Language: en-US
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CALWcw=G-TV19UPmL=oy-HE9wc0q-VpHBVyuYcVQ8b9OQq-8Lqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0303.namprd03.prod.outlook.com
 (2603:10b6:610:118::16) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB6221:EE_
X-MS-Office365-Filtering-Correlation-Id: 760bceb4-753a-4058-ee13-08dd2f3c280b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlEwRGpKbWZxb0phaWEyeStzSlFDR0FLNTM4a2Zvdk91N1JPZ1QyWXBlbUw2?=
 =?utf-8?B?eXhzcXhlMXp1S0xzVkZoM2hpQ2lTSjhzaXFXWHRRVXpHeTdjZDBJLzdZbWdU?=
 =?utf-8?B?UFpiWVJSempTSFd3UVZUZEVOK0lLR1BobnlLZTc4blJlc1V0Q3QzL2V0aUZm?=
 =?utf-8?B?Mnppcy84cjJuRFRwR2tnMGFtSDZIMTF1NlZVRzNVMWhnckVzbitQanRLSjlZ?=
 =?utf-8?B?TytxY3U4RG5rWFphTGRNaGtOZ1dvSm02M0lpZEtUQVdkTkFPb0hkS2hWd0ww?=
 =?utf-8?B?SFQ0U1FqY1RNYzZvRlhvVFFjNFUxSjlGTm9ETUNOZzJXaEY4TnQ3Y015TnQv?=
 =?utf-8?B?bzFjaEd0TUNkUENSWUJsMFZaMUtjTm9iWXJqaGROdGpGQkNqaEZQZ0pIS29C?=
 =?utf-8?B?eHhYWTlqb09ocGt1TkZQaWJEQnpIOE9JWkVieXI1UVJkdy84QlRPanRsRmhx?=
 =?utf-8?B?d2tzTXpGVEFVQmVJOVMxUnlxVTkydXZYUFByTjZIL1pPdk1uWUZodE5wK3VZ?=
 =?utf-8?B?bEZJVVpFM2Rhckw4Sjc1YkFYTnVnQ3VXTWhJU2RCeFh3V0oxd0J0TE80NGRQ?=
 =?utf-8?B?NXNERVhORFF5cDFEaTBtd3N6YW1JN1Qyakg2Rm55UEd5V0FFS3hJOHVRcUFu?=
 =?utf-8?B?a3NtbThvWGZjRjBpeWtHUlZtZDZKOS9tRnllZ1VjV0ZrR1B2MDhkcjhDWWNK?=
 =?utf-8?B?ak1BcEhmcnVvQlA0ejNtSzNidzlDZFRHeXkzZHhKeFFOeXdlZ3ZHQUpOOTNC?=
 =?utf-8?B?UlZIZUpCMW1BOVc2MFgrQnIwTzNmajNsdXRHM1hBSTUrKzRsaDZhNmZrTUI4?=
 =?utf-8?B?bkx6a2IxNFoyWUttaFVWeHNIUnY3VmZtbGNIZUtubHRJM2Z4WEFvSGs3cjVI?=
 =?utf-8?B?dUlFRllIbE9QK3JkRCttRWQzSkYvU2FYRFpyR3ZpVzVkQ3RiQlJyMTJTeHl3?=
 =?utf-8?B?cFVuRGQzbTJKN3A2RWpVN3V5bmRhdHlSeUdlVDNJWDByb2F6T1FDVHVLcUt3?=
 =?utf-8?B?UXpwRG5LMi9jc3dUaW5temhsNjZCNHZRTU4vMTJvYXpma3d0b1lDN2w3Tk0y?=
 =?utf-8?B?Z1p4WmZ0MytJcEVRVGNhcC91bkdpWnpXTDZ1cWNvZ1M3SlhjTVZqSjY2eHRN?=
 =?utf-8?B?MHllL2dJVTVxSEwvRGl0SlhPejNyRkNwUzZ5cTc1YXN3K0xJdUo5UnU0SGNo?=
 =?utf-8?B?Uk8rN25FeUk4RDNIN0ZKMEJaMWV2b0hsdUcrRzhjMkRRS2pyOHczYTRNc0Rj?=
 =?utf-8?B?WFpGSkJpZnVEcld0bXpyVSs4c1UyMFg5dnhHRzdXdCtteTJUZ1ZaUko0TXFK?=
 =?utf-8?B?TG1Jei9WWVVuTTdTS0MzNEE2T1lKSFdlMThPZFBVUll5QlZPdjJ1VnorWXgy?=
 =?utf-8?B?VnQwU1JrRklMd1c5YUhIYjlROHU3aHFETGMydXFsWWw2ZE5oaGJmZ2pFeDY3?=
 =?utf-8?B?SitPT3hsQzdXSXAyM2JPK3R0aCs1eWZDNU9Rc25pa0FTY1B3Q2JrUDE1dHNN?=
 =?utf-8?B?QTgxV29NTzVRM2NzOFZZSjZ2TFVlM3RpcHNvNnJaSmJpQUpFc3RxSVUvSys5?=
 =?utf-8?B?SkpDQXQwUXRhL1puQklmWnpqTTRUTUgvYk9EM3phUzVtcE1LejBLbkN0UWFN?=
 =?utf-8?B?RmJDeXY1ZGdYcXo2ZFFlT2hBOUlSVUxZc0JCdElxek1ESFJCVEIvejhNbVc1?=
 =?utf-8?B?c3AvUmd5aVI3Zzh6MElJQU5jOW9lcFhxSUJnc3BuZFBNRVFCanNCc2RiV2I1?=
 =?utf-8?B?SWw3M1lFaEwwY3d1Y05hc2Q4UGNicG5kcUJPZ1pJVHJVTUVuRnJrTGx2bFg1?=
 =?utf-8?B?M1YvK2tPa3l5WG9sRy9xYW1wbmZGTytuZlNSUGxsVzk2WkhHbG9WaS9JdW1T?=
 =?utf-8?Q?Y0b2XNwHhHpj5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3V3VGpKNGJsN1FzRWlZekhGQ1drd0NidGozZGM2WGFEbTc1VUZtWWozMXhp?=
 =?utf-8?B?eGZzOGRJbXJQR1kwbFpxcUhsMmlKRlZMbnY1TFBqK1k3RjE5eGFnZ2NRUWZI?=
 =?utf-8?B?bUg0Qk00Zkxoa3NtUlU2RkYwQlI1RWdvYmVCdTVxalgzTHBSZ3lzU0RUbTFs?=
 =?utf-8?B?MjdKNkQ3NXAvaXYxRHgyaVZWZzVkbEY0cjBUV2ZoOUpUL0JIRkhRZ0V6WlVK?=
 =?utf-8?B?WTZ4OGNrOXZkM1UwR3RBQTFuYmVJbzlnbXpLTmw1bmVDL3MwMkl0eXFOQmpt?=
 =?utf-8?B?YWFKMHIrV29pTGdiejBuejcvalJqd1p3QTJmSWVkWisxMkE5RUpDZ0NmbXN2?=
 =?utf-8?B?ZEhvbjlIK1YvVEhDVXNpSFZldzgwWU9WQkRzUE5XUTltWGY0SzZHSlhTK1o5?=
 =?utf-8?B?bmhXSzAreEprZXl2bDV4UWIrVmRqNGh6ZkZ1VFB0S0YvQW5nTlIraGExWS9l?=
 =?utf-8?B?amRzbWtLSzJnbVN4Rktvbkh6cm9XeU5FbmZVa2labUF6TUNRcUhMQXl1bkRQ?=
 =?utf-8?B?Sk5IcXFqZURqM25WeDY5TUJ1V1pwVElaeFgvWHdWY2RJZ0pVeHR5RUZSdnB2?=
 =?utf-8?B?RGlsQ0J3NzVtNVZ6aEh0NzZBTkZuWFpiTU5QNU5CWVFhOUZDSmMzUkFEc1ZF?=
 =?utf-8?B?ZUdNdTRsdXRLRWhTL0NVWnorM2JLWFlDc0s3cWhuWWtqRTN4ZU5SMllEQ2Y5?=
 =?utf-8?B?MTNjWjk4eGJiUXVLSzYvL3N0RGQrWlFmOW43K2I4YkNod1dJbWJ6ekpyTkVy?=
 =?utf-8?B?MDVYVTkxdUN1QUI4czQycU5PcnZmT0x2KzU4SE1RTlRDTm5tdkFKb3BqcUdo?=
 =?utf-8?B?dCt4S3h0d1VEcEttQlVudk5VVDJtS3RESC9WYno1TFM2djFGSHpSV3BVckZa?=
 =?utf-8?B?MHgzQVpsKyt0OFp1ZFg2YjRSVUtFWU1BS0pleXd6am5wTUl6TTBPS01PQ2Jm?=
 =?utf-8?B?bjVaRk41MC83SzYzRUFGUUg2Uk12N1g5WExpV0tBWTBkWVhVL0d3cDUxWDh5?=
 =?utf-8?B?UW04bWRIeEZzWExIQ21EcEkyZ1hzc0cyMDBtY3RaS3MwSnl2R0IzS0xrRWVy?=
 =?utf-8?B?bzUvSG5jekV3d3VreDhFeUphc0ZZaUhBQzBvZWRqcWJCcTlReEJWWVpiVk9I?=
 =?utf-8?B?L3BsYlVYNkJxbHZHSzdNWGF1aHhUZlJPSkU2TG44U3cwQmloc1h6ZHAremdh?=
 =?utf-8?B?QWNGQm14Wlk3anBCcVl4Wis2RVZlaUVQa3drNEZuL1ZUZTIzMGxmOVd0VFUz?=
 =?utf-8?B?ck1ZOFZoSHRlSEtlekZ6K3NxMjVyTWNBdjljTitXd0lIT3ljREhTSjdWSisz?=
 =?utf-8?B?cnBoTW1tcGR5SS9XaHdXUGJ3eXVVUENTdWs0anhXTmxmOFF0dEx6Rmd3VmUy?=
 =?utf-8?B?Tk9ndGNuaElFU20yekUzTDdUSmlxMEVSR2ZqYUZ5WlQ0SkFzemhxcllVTXJp?=
 =?utf-8?B?dGlhUlEwTUNQSUttM2lCOHo2aHVocnlTMHBEOWRYYVk3aVZqcE1RcEdDbjhR?=
 =?utf-8?B?VUx2d0dyQzB1N0d4ZmN5RjRuVDh1RnRYV2EyZ1g1V0VjVmdFa2hSWHFieWJY?=
 =?utf-8?B?Y1BTOERmaDV4NnNnaUpmR3VLaUIvNlpPbDErT0poMUR6bklCWmY2WU96TEds?=
 =?utf-8?B?dWxROWpUZ2cyMUNCMlpwYXRqRXA1R2I0Z002eEp5YURUcXc3S3RveWMyN3dx?=
 =?utf-8?B?VzFVMm1sVC8yQW1XSFU4VEFlYm1UQWNDVjg4Z1dxbnZUY2tnQTZqREJiUzcx?=
 =?utf-8?B?em5Hek9tVTRYWWFMUkhwcWxGMXlDWFNGekhBelVIcWlndFh3N3NBTmloUGNk?=
 =?utf-8?B?YndWU09Pc2JiRVJtb2lORDhnUkhGbUxlNlRSbTZmMkxHNnhZbCtMdlkybHor?=
 =?utf-8?B?dWI1SzN5V1N4NnJXYjBJeXF0eTZWU2JKdzlpdHBiZnpraGdEcERCWTc5RGRU?=
 =?utf-8?B?Y0FkN1RKTlA2TEZUa2hZdjFWL0lkTVUzdWgxZExVbWtXdE9PY1VnbG9zdUZ2?=
 =?utf-8?B?N0dsYjg4M3A1ckVtRUZrbEo3L2hTZDhyMnNTb1E3US9BV0E1YkNzQnRxSkNJ?=
 =?utf-8?B?aWtSblhZQzZMa3FaRDhpVytqdlFoYnBsaEFWUUplU2VVSmRzd2k5em9uMFhE?=
 =?utf-8?Q?ebEB4i9T73qkXzOGCtvdBfj9U?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MZz2iOS5AthL9kchi8cKE203/JG/33m4lNfZ8q2sDAn3ID7VNJ84DqN6Klputf98VMU+toUdqqw9+DGaDvR6ioWPdPRL8fCpBN+WTMp+Bz3RoDvOmrffxAKYTA9Ti9gcqOQnpi5O+KC3GpLjSBew+EwISuRVhnFrKr/X+3/+Dc5Xz++QlNaWtBZUHv2ya6HtrNTJu5EIblUybXkrFXoJU1qJlJGXVoeMuoXvDTRHPg7thFjZ8U99yxtSGSesUmv0cbfE7JEtsgfTMQWGoic5LIj4MWDVftARTN6RZy2Hr9nhkh5/B7XwCpkY2t1tPG1392IhNZoqBVDEwicHBFSxu1uaZdV4ly/bKrdlbgfzI1WngPDUfqehoHkAHe+tCEzH7xCPltZwv4r1q9xBcgp7B8oRAzs3NRvkhaDbO2E9DMepSKMcUq7SasaXqI/4+q9p8z3mjwuodvLHVOT5sr8v7QRHTZeT0jliSpmwH6fXA8b1ttzpKdoQodb/JhRskjiFpFQgOhjUiPtnITx55fMYblF9LBJcf+Xh/crB+9KIg57zQK9LQeN8RV4bDsE6Cs8ueVGcCqaRTBDMsPXcembLmbLhDvh1reKXlT0jzC87nig=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 760bceb4-753a-4058-ee13-08dd2f3c280b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 16:55:57.5471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ah776ixY0VPTWcnlml98TF31cpnLOqwhqrjBnVapf3aVTGbvIeCqEEvgNSxTk6PaSWbOF87I0F3jPXnnvGa2QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6221
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-07_04,2025-01-06_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501070141
X-Proofpoint-ORIG-GUID: hfwlmRJfBxp-cUJtsalBU-YDgvq3eEQf
X-Proofpoint-GUID: hfwlmRJfBxp-cUJtsalBU-YDgvq3eEQf

On 1/7/25 10:36 AM, Takeshi Nishimura wrote:
> On Tue, Jan 7, 2025 at 4:10 PM Anna Schumaker <anna.schumaker@oracle.com> wrote:
>>
>> Hi Takeshi,
>>
>> On 1/6/25 6:56 PM, Takeshi Nishimura wrote:
>>> Dear list,
>>>
>>> how can we get ADB (WRITE_SAME) support in (Debian) Linux nfsd, and an
>>> ioct() in Linux nfsd client to use it?
>>
>> Thanks for the request! Just so you're aware of the process, this email list is for upstream Linux kernel development. If we decide to go ahead with adding WRITE_SAME support it'll be up to Debian later to enable it (that part is out of our hands, and isn't up to us).
> 
> I assume WRITE_SAME will not have a separate build flag, right?
> 
>>
>>>
>>> We have a set of custom "big data" applications which could greatly
>>> benefit from such an acceleration ABI, both for implementing "zero
>>> data" (fill blocks with 0 bytes), and fill blocks with identical data
>>> patterns, without sending the same pattern over and over again over
>>> the network wire.
>>
>> Having said that, I'm not opposed to implementing WRITE_SAME. I wonder if we could somehow use it to build support for fallocate's FALLOC_FL_ZERO_RANGE flag at the same time.
> 
> No, I am asking really for WRITE_SAME support to write identical data
> to multiple locations. Like https://linux.die.net/man/8/sg_write_same
> Writing zero bytes is just a subset, and not what we need. WRITE_SAME
> is intended as "big data" and database accelerator function.
> 
>>
>> I'm also wondering if there would be any advantage to local filesystems if this were to be implemented as a generic system call, rather than as an NFS-specific ioctl(), since some storage devices have a WRITE_SAME operation that could be used for acceleration. But I haven't convinced myself either way yet.
> 
> Getting a new, generic syscall in Linux takes 3-5 years on average. By
> then our project will be finished, or renewed with new funding, but
> all without getting a boost from WRITE_SAME support in NFS-

For comparison:

Adding WRITE_SAME to the Linux NFS client and server implementation is
on the same order of time -- a year (or perhaps less), then getting it
into Debian stable will be more than 1 year, probably 2 or 3 (at a
guess).

A better approach would be for your team to implement what they need,
use it for your project (ie, custom build your kernels), then contribute
it to upstream so others can use it too. That would demonstrate there is
real user demand for this facility, and your code will have gained some
miles in production.

You could hire a consultant to implement it for you on a time frame that
is your choosing.

Upstream prioritizes economy of maintenance over code velocity; meaning,
how quickly a feature can be prototyped and productized is less
important to us than how much the feature will cost us to maintain in
the long run.

With my NFSD co-maintainer hat on: I would accept a WRITE_SAME
implementation, but it would have to come with tests -- pynfs and
xfstests are the usual test harnesses that can accommodate those.

In addition, NFSD is responsible only for the network protocol. The
local file system implementations have to handle the heavy lifting.
It's not clear to me what infrastructure is already available in Linux
file systems; that will take some research. (I think that is what
Anna was hinting at).


-- 
Chuck Lever

