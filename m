Return-Path: <linux-nfs+bounces-4572-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E97E8924BE6
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 00:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65FC91F22F8B
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 22:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0536E1534EC;
	Tue,  2 Jul 2024 22:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ld7eY4OY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rdWWK3F/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6231DA301;
	Tue,  2 Jul 2024 22:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719960960; cv=fail; b=NjN6p/v0QhICPiBlA0eXBZDeD7lKiP32+K43oavklmmGpQUCFCcw/vW8dlCeVpzPq45TRXBH0cSQyeeEMrwweds74/0r6Qzn81In045x2BJPLiSD+Hcjs0vob3/WsPR3DlNb2xAtbfuLLXp/SFXD/Gh0G9eki/rH3Qcy+qGxSVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719960960; c=relaxed/simple;
	bh=idBe/dmnOjXwFZiejhd5ONRZMQJPvVLn4V0Lto20/jY=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gdNHq+zevZn9pTxSb2RCCrpMZfNIBbAz+2Fgq5h0GR6v/L2HOnBzd4HMfdjQR6kuknNwdgehC902GJcrQU1ZVB9FZbNDMfA65AzKTtXHSBF35AcTTnRns7Efmt+WJbyZCk2cscx1My4q1NPSVNB9fhJS+UVE1DYp+Zj00+iwoqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ld7eY4OY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rdWWK3F/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 462L0707025934;
	Tue, 2 Jul 2024 22:55:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:cc:subject:to:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=yhxFosrGGrTjej80RrEYxvdA4NbAGB+BZ0qAEBiifvM=; b=
	ld7eY4OYYeHRxulgZu8Ubh/DY6aNIEXtfgPwKuNWDmKYkvkobANTbRhsBHP51kas
	HW680hoWrOStfOLKRgZ9Cpan1hZQYlbkKwqugUZkXXdG+q5pYCk8fCVoW5AwF8yv
	00XpwxC4Lx52ti8p3EJWad0pQFqP6CvqwxTryOljbHpbfa68K9l2bIZ/OdKsi4Mw
	fYR6qxvWL+MarvzpILkz4ZmSVsco4UbPzVu1XjXs+ztyzIA0ajuoRTG/15c2Wtxx
	cpybPFl6pbWsFUBKzdEeGYAkVtsxHSBTA8t+/QSr8NCjm9VMVrkHvPgGYlYBwBJn
	b361IUpsU4Yo019VKgkqqw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402922xybn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jul 2024 22:55:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 462ME2Kt010198;
	Tue, 2 Jul 2024 22:55:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qet231-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jul 2024 22:55:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNR3uWXbWilpUFE8m+jsMKJv5VZKfy3C7ljrws6w9z3/ifYEbjit1I1L8JpJcCN7I6OQmPnoRU8/bnLT6CRgd7QFTLJPGJf0rDqxE2W82vWVXmqGCr4IE72+AyHXVPxC1fvC3vE+kqWBGXYoRu1SHazKyy0krW512ZUYEUkeiJgNkeO6vtuFBjnxaM/OmSdjPr80xUrRaOs7l6NC3IZIqglY2VlID64zVsIJUgC0IfQPiEB7NkP9bEBT57y+szM8R33r6m5Zj5FRAtWvNBsaNbmnl8AgfQojvb6PD/5uCjA+ktZjoilH6YkOhI8XBE/QGSfeTT0zSsrKJWe3r+WuNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yhxFosrGGrTjej80RrEYxvdA4NbAGB+BZ0qAEBiifvM=;
 b=ogHH3DSvh1gvJzWYpYnmIVqc6vglNxD5GfRKIHDieDRoBELrOp1J19GRhK/NFRLX+ghDxDc/MmqpXpLceDUOMM1jCEWh4rn80teBKPOlma1xWIVZtmOkxE8KEZcXllebuuK4zRM6j8A6JZp722A+hp5HGdf6hPp/nFeIy/110orAmSeKUIirWkOzAfO4ENmkaz+T6ovxmPPPvWejPFW/cBMf4TpVIJC4tv+zkfmgIXxgoheTUEjphSAooK6Nv2rGbVkt9jCsQOD32iWOs3Oi7j0ceLge4rlw4TQ5fcYrHyQ+/oxB+4DsyjDErRzYIjJvuIt0xWIw30pEBH1UXqvI8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhxFosrGGrTjej80RrEYxvdA4NbAGB+BZ0qAEBiifvM=;
 b=rdWWK3F/wZdzAYV5XpSBFlbkutD8mW2Rr1FnIWDGfXQ7+qJOfpOpkBjin9Y5CaoxrywJUkycrwhH60wch19rqElwUhFjK6xc/92ALOs0GB8BIQ076cSuSQ7/qCZc2R/Fhr/wvn+6f0aFxD6E4rmez6gCksnnA4Oh+cFaR4lrUfA=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by MW4PR10MB6297.namprd10.prod.outlook.com (2603:10b6:303:1e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Tue, 2 Jul
 2024 22:55:36 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7%4]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 22:55:36 +0000
Message-ID: <2fc3a3fd-7433-45ba-b281-578355dca64c@oracle.com>
Date: Tue, 2 Jul 2024 23:55:32 +0100
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>,
        Trond Myklebust <trondmy@hammerspace.com>, anna@kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>, kernel-team@fb.com,
        ltp@lists.linux.it, Avinesh Kumar <akumar@suse.de>,
        NeilBrown
 <neilb@suse.de>, Sherry Yang <sherry.yang@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-stable <stable@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [LTP] [PATCH 1/1] nfsstat01: Update client RPC calls for kernel
 6.9
To: Petr Vorel <pvorel@suse.cz>
References: <d4b235df-4ee5-4824-9d48-e3b3c1f1f4d1@oracle.com>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 smRifw1wGg==
Organization: Oracle
In-Reply-To: <d4b235df-4ee5-4824-9d48-e3b3c1f1f4d1@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0368.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::13) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|MW4PR10MB6297:EE_
X-MS-Office365-Filtering-Correlation-Id: bad2fcc3-0854-44f6-6c44-08dc9aea162c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?a29zaTlNZDBvYUp2UUpvYmlIUFVSbDNJV0hJRjAzYURJUGd6eTkrNmpWT2NH?=
 =?utf-8?B?ZmxPdzVTQUFnWlN1MmtaL3BPTFVJRXA0NkExTWM1NlhnNS83S0oyWUl1WHJL?=
 =?utf-8?B?L0xnZWx4VHZmYVpoRFVsZmRSWk9vY1Zwb2t1emIvb3dGRm5tWmVSUUQ3RWEv?=
 =?utf-8?B?S2hHaHdkTktWMnFkTWFBd3Nla3k4MnltVWlsWXJSa1hMYnlWbzF2Z281Mmw5?=
 =?utf-8?B?ZitENCtySDNsWU55bWs2QVBTamdFOEptZG4weUxsVFVROFRjczRKYmR5d215?=
 =?utf-8?B?RlBzMTlkeWJkU0dzTWxMK0QwSFk2cmhVemFEanZZTHAxYkVhNTY2dGY0Sjcv?=
 =?utf-8?B?b25oWWk4RkEvbXVPTjFmUi9XNU1EN1VzenlQaVJycENmYk5sa2VMM2Q4VTFo?=
 =?utf-8?B?amUya0ZiU2xMSWpkNG9GRFVWMUFXRkdCeXZ3dXBCUTdVT0hQaDRxWVVWRW53?=
 =?utf-8?B?TXNNenV2SUc5anoyN2tDUnBHVHdUbXJLYS9WTUZTYklCemExempBeXViZ0wr?=
 =?utf-8?B?UlZrWkpGZzVyelFYdmxkbVBJV1paMHY1RUFOMXBORUVxT0taNklyd0JURisz?=
 =?utf-8?B?NlVmajRtMEt4aWVWdWJ3N3ZWUUpnYktPYmF0Y2lCaTBrMC9qanN5SUIzMUt3?=
 =?utf-8?B?QU9kaFU4bnE4N0hxbjBYbkNobEtyTzhZb1dkQ2VsaDJxVkdiSXVQRWUwNlhZ?=
 =?utf-8?B?NnJzaGtiSWdRcmowSlZITHJnalZrYzQyRm1GR2NKTDk3MVdPU25ZVXVOdGhV?=
 =?utf-8?B?L2ZtKysxZHc1eEwzRGdBMWV3WElIaUF0NzJsa2RmZWEvQko3RVpkc2pyOXh4?=
 =?utf-8?B?eHYwOGNEejNEL0w5OFlld2FBSVRmOENCNjRoRGtlN3BkRkpBaHh0dWF3RFRY?=
 =?utf-8?B?V3BJRGpHWmd1M0ZKc2xPQ2p3N0V0RGMxZGs3VjRoSllkeW9kbFQ1QVNGUncy?=
 =?utf-8?B?QmVya2NZWWZsRGFZOHFqTDBXaVg1aHdrVmRGN29WRkNUemZiRHZydFdFcXdO?=
 =?utf-8?B?WTEyKzltOEFhZDZPVGh0di9paUlVVWJWMlRBMDEvUVpXeUlPaWY4L1NZVWNR?=
 =?utf-8?B?bTJjTmE0MndHZUlyLzcyODM0UGlKMzFaaSt6TUtwQi9BZ3BOeWkxVWVLbjhF?=
 =?utf-8?B?V05IUVpIWXBkRDI2cU9HQmVMaHB2bXVQSkNLaWxBcURUWGVHQkFFUWZYR056?=
 =?utf-8?B?S0ExNHU5YTJTU3FKU1FjNWZVOUtRYWNhM0tCYkNTdkE1dzVHbU5ad1lRS0Jt?=
 =?utf-8?B?U0NqTCtIRmJWVktkcXNGeUNtZFFQNlhib00waG41QUw3RUpOdFI0QWE5c3R3?=
 =?utf-8?B?ZUtzVlFpekZPbVJveFFrdUk0bzEwTzFSVzY1enN0emJ2c0ZEVnNpRmlpS0RH?=
 =?utf-8?B?UThhcGZIbXNkd2dHQjFETWpIQ1owbDlLeEQrQ01EdVFSOG9Rc2dFdlB6RENi?=
 =?utf-8?B?aGkrQ0x0WCtjcDJuaHltT3FVblZvWWpjR1FkSVQrL2dJb1Y0d0lpTkhZc2Zi?=
 =?utf-8?B?SUpQQXNYOE9rTWRMNm51UXRMRis5S21tN2E2aXI2TndRbXNSb0VlL1dCSXFP?=
 =?utf-8?B?Zmd1Skd0M2g5d3VjaWpsUW9Gc2xncEQ2ZTQ0a3JNRHFaTVBpQVk5eHZMQlA2?=
 =?utf-8?B?MHEwYlZJMCs4YlpKUDA2aFJWYmNNOVhKQkdId2lvOWduWUxYOTEwS0ovTFU3?=
 =?utf-8?B?bUJjd3M5TGpxWXkwWXRya3FMRTdaY3J0SmRaYndzREREN25KelFnSmhGN2F4?=
 =?utf-8?Q?4Gc35A9GTRbCmVodCg=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NmZIcjZVYUYzMHdLVXI4b01Ub2o3cE9JUHVTekZlTStmMVR0ZkxqK0xXR1F5?=
 =?utf-8?B?elE3NTJQcXJCZ2hlQnpkcWljcWYwZnd3VEowZXdDTmYzM2RXRVZEdjZJdUQr?=
 =?utf-8?B?S2V2Wi9YOW5SVVU2ZXRYWFRUcjUxcFNWKzVMKzJ0QnY3UzgyZWtFaWswQmJw?=
 =?utf-8?B?UUZlNWpGeEtHRDBCM3NxWEwwdmN2NDdBY2hnZlN5akxudW5xejZZT3dyaER3?=
 =?utf-8?B?R3JDTTFtNVZiSzVnK1RSa2VPUC9qYmNOK2VCbGV4UmFCVEVFQWNxQldMWDZN?=
 =?utf-8?B?SFVza3VON0lkYi9ZSjJ1RklkT0R1ZnBHK042MGsyUGl6ankveGpxTmVqUkVW?=
 =?utf-8?B?VkRpNzA2eXd3b2FGTGJiMGNLQTc0Rm5YQUFNaGJDdkR0U2ErWlU4cTZ6MzY4?=
 =?utf-8?B?ckxVNGxUZ2lmUTkvdmx5UW4wZ2VTdXBIcGRtV3daeUJYQUdNakE5aDFGWXBG?=
 =?utf-8?B?bDExLzdIVDMwS2FleGhFd3FzMU9UT2h3UTcwSE5xK2k5MDRxcVVFQWRreEc2?=
 =?utf-8?B?T1JJREg3NW9mUTJkWW40QzBOdDNNOXprWlhUaCtQYWlGc0laSjBIU09CbWFL?=
 =?utf-8?B?czFQTjNOSTIrZE9CZFBoaFBIcWhEb1hndzJ2K1hQZ3JKL0hyUVcrV05MTDRn?=
 =?utf-8?B?aUdFMXNqbXgvU3RQK25BZy82dlFWN3gzcUNMR1ZsTkVUa2NBQXlXYUJ5WlVu?=
 =?utf-8?B?RGsxM0pQSm5FZ2FqSnN6eWJlQzZhZ2tDNU5vNkQ0dFc4OEk4TUorQkRHdFlJ?=
 =?utf-8?B?V2crb3ZDY0JtT3JHREpjTCtxODNaMVRNaGUwZnVzZGdUODJiNFk4cWhJMFM3?=
 =?utf-8?B?SUVUZmY2S3pWMERFT2h2amJRU0pjcEJ6YWdFbjFiMm4vdkF1ZG50NmEwWXRs?=
 =?utf-8?B?UUppSEVqb2ZXbHAwMlNXa2ljOElzNVdpb3M2RWx0WUQycmRvOFZXMlJNWnRZ?=
 =?utf-8?B?YXo5OG45Rm0xekV2WHA4K1g2WG1EQjlKKzhpWjMzSG5CS1dxcXE1cU80ejFG?=
 =?utf-8?B?MXcxUWVWR0xVeFBYY3BUcDVOZlVuOGJ4VzBOS2lTUk0wRHZIRFpwOG82L1J6?=
 =?utf-8?B?OUdGaTJlZTJCT1ljSDh0SWVwZmM5cWtlZnQ2ZGI4bzI1UmM1Y0lnK1dsNmM4?=
 =?utf-8?B?TGwwa3Z2S0dsNk5GQUxnWWxiSjVCcUhDelJDcU81Q2VQK1NlZWRxWStuVEZG?=
 =?utf-8?B?cUEvVGVvSkZVTk1ncmhXMnlXWEpPYmViaEg1aGFpbG8waVZ5MUpWRTNkamtv?=
 =?utf-8?B?T3B6TVF5dExXZU91T2tmRStuQXQrN0RFNFBpenNGVkxBZFdXek1SL0ZXaVNQ?=
 =?utf-8?B?SjFXNlVCd2srWi9nUXJFYmhlbFRRZkk0Q0NtNUVxU2txcjJOUE5oRS9ZWTVW?=
 =?utf-8?B?UjNsMVpTZEI2U0RFSXdHSXlreEFORFpucTNJTm5qbkpBb0RsSGorQ2R1UE1Y?=
 =?utf-8?B?bURLV0tVQUhidkhCdXZMNzQzMHRGMkpIVWhsc1l6VThja1dOUkZhQk5MUnJh?=
 =?utf-8?B?QUx4RlhmRzJUOHBhVThTa3NjM0ZxMW52cnhQWEhMeWRxQUMwNlA0eVhVM1ZV?=
 =?utf-8?B?ZnBEbkd2VWRpcTlXTGZuNDVoRDRTWFZrdDJra1JCRXhkN1pEQzRFdVlmMmYy?=
 =?utf-8?B?OU5PRUpNdktROWU5TU5XNlU3S1ZJSWlnWmY3bEdNdUtIZ1ppYUoycHJBcHZ3?=
 =?utf-8?B?cmpRRnlLZWJtS3lmRHFDU0FFaFVpTTZNNk1TTElnWkp6eHMxOVZKQ0lESkpM?=
 =?utf-8?B?WEZQOEJ0N3ZkdTMrYWx2R1RBVFo3OGxZOXJZOVVTdGQvU3pLT3k5ZFNzUEg4?=
 =?utf-8?B?Q09WSC9reU5aaHQrM2c2WlJEL2tmdnZxa3ZRMjNCanJ2NHF6aGJCSDUzUzIy?=
 =?utf-8?B?OEM0MFJyYno1REwxQWFWUll4MklZT0JMMTlGZzBrYk01cS9jUk9nT2pXWUFW?=
 =?utf-8?B?TWl3Nk1FZ3VwcnZaU1ZxVkp1eGttb2NhSk5jYU1iSUJLRUlTYVRSSHJFMGNZ?=
 =?utf-8?B?YzRZMlNiZ1dUdVJYUUVCbCtZS0ZGWWhBbG90WU1RdDNuRFhUdXp0d1FiQ2ZG?=
 =?utf-8?B?aXpWWXBvcXlrMXZINEE4QklTSC8reUZTSWVveTBMbHlQcFJra042UFRIVUhY?=
 =?utf-8?B?aFhyZ0dYa2gxMkJwWi85bThiWDFlaXB5ZmdSd3hVMUtXMFU2UGtZT25XaWIv?=
 =?utf-8?B?Nmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	gH/8ojPmAsaYnN0S2MZYKHaEYJTd0RnmncSnFMkmqhePI0vCYJfRFRtiDC+OBtlpMyBnF01aveQabZOQYB8jskgSG43NursPZRoCkKGtlkSYeWs1PKGDSSoIkUrGpzbgwNLyV3e2ygY0UOmbuUwjaDVk5pmctEmHjt0dlFf0BrdZMzvUNsL33jHR+9kbqMjPNXj/T8YeOPyqwEcVY/ScISf00vgEw/BSeQrbXsNnSCCHnhWAPvuhsIjXnHKWrc9EMQEqTj//P0UMQkns4zwBokYddqbHU9LeBXSsprzSuIos5uPF13wppn23W9bpW+FJJNHpbikxcl/sXbjpj7BApuU2QchNMAo8nDS8g/NGHyxmXuxdGHmEqFJXzBa4QxJxtiwYEwDjAAKmif/E2a+VAOmP/6ggSpWgiqPe2194JmhxQVVR0l9pdRg9ALARjfsrr+9Wg342Obq4GHVI3XpQfED3WyWdzEppt8OoGL/E6wJ1pyLocyXQW/fJDmbg9kjCb5q+yMQQ/+GjbPWp4bc8xZkydeZ72sOm0d4WoyMejnWG5qx/RwTZOTMEN62o85ySsrfPS/bgyxuZQ2HpvXPslcl6R1izicb1mwjGVg5sAmw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad2fcc3-0854-44f6-6c44-08dc9aea162c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 22:55:36.6396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XT5NDD5NlbgBAsIKkI3YcwGSHkJoR4Meb7yzBBwfPE230/ju6k46fWOMWmyyOvFZrUYqVqXz2rDPnT1OgUJAUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6297
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_16,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407020168
X-Proofpoint-GUID: kmiSDvgmTrREdlH4A45bstYfZr_gS_6v
X-Proofpoint-ORIG-GUID: kmiSDvgmTrREdlH4A45bstYfZr_gS_6v

To clarify…

On 02/07/2024 5:54 pm, Calum Mackay wrote:
> hi Petr,
> 
> I noticed your LTP patch [1][2] which adjusts the nfsstat01 test on v6.9 
> kernels, to account for Josef's changes [3], which restrict the NFS/RPC 
> stats per-namespace.
> 
> I see that Josef's changes were backported, as far back as longterm 
> v5.4,

Sorry, that's not quite accurate.

Josef's NFS client changes were all backported from v6.9, as far as 
longterm v5.4.y:

2057a48d0dd0 sunrpc: add a struct rpc_stats arg to rpc_create_args
d47151b79e32 nfs: expose /proc/net/sunrpc/nfs in net namespaces
1548036ef120 nfs: make the rpc_stat per net namespace


Of Josef's NFS server changes, four were backported from v6.9 to v6.8:

418b9687dece sunrpc: use the struct net as the svc proc private
d98416cc2154 nfsd: rename NFSD_NET_* to NFSD_STATS_*
93483ac5fec6 nfsd: expose /proc/net/sunrpc/nfsd in net namespaces
4b14885411f7 nfsd: make all of the nfsd stats per-network namespace

and the others remained only in v6.9:

ab42f4d9a26f sunrpc: don't change ->sv_stats if it doesn't exist
a2214ed588fb nfsd: stop setting ->pg_stats for unused stats
f09432386766 sunrpc: pass in the sv_stats struct through svc_create_pooled
3f6ef182f144 sunrpc: remove ->pg_stats from svc_program
e41ee44cc6a4 nfsd: remove nfsd_stats, make th_cnt a global counter
16fb9808ab2c nfsd: make svc_stat per-network namespace instead of global



I'm wondering if this difference between NFS client, and NFS server, 
stat behaviour, across kernel versions, may perhaps cause some user 
confusion?


cheers,
calum.




> so your check for kernel version "6.9" in the test may need to be 
> adjusted, if LTP is intended to be run on stable kernels?
> 
> best wishes,
> calum.
> 
> 
> [1] https://lore.kernel.org/ltp/20240620111129.594449-1-pvorel@suse.cz/
> [2] https://patchwork.ozlabs.org/project/ltp/ 
> patch/20240620111129.594449-1-pvorel@suse.cz/
> [3] https://lore.kernel.org/linux-nfs/ 
> cover.1708026931.git.josef@toxicpanda.com/



