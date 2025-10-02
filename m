Return-Path: <linux-nfs+bounces-14851-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 762A2BB2756
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Oct 2025 06:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A956326729
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Oct 2025 04:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1EE18C31;
	Thu,  2 Oct 2025 04:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Or7DW/Q3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xG4WhOJr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C30F29A1
	for <linux-nfs@vger.kernel.org>; Thu,  2 Oct 2025 04:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759377629; cv=fail; b=RKKtPcJhtQ3ircaNlPCmJqsV+oLKFLRXqCls59U6rM0axOkUtM6AX2oM0xoSOJwI88/YVQz2G8sq72b39Ns6Lbj/mQsf4OKYl8ScLNDutNApSnOxrNGgt7hCkwsvjZwyKX9GT4aKUNhvCkzB9iapdFANHZnqdg7Sb04Zzgf5syU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759377629; c=relaxed/simple;
	bh=FhY+FgZMymAlyBXxtlBdmIfmI792WJD4ZG+H0k7cf7U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vg/945fgyZ8XWegbcQ3LrLyo4MpDbfWI33KcBcUVUNR45CT/taqkyT/aKYXrUAwc8LNej3pkmqeyAmdgLLlSE//QBHnz4xQbwhMUVmt6XFYyNh7/No+Ws9q7YlJ0ZkPwgPMaxK8a/KxDFXboQXim3AIpWa2olXpwFNetd4QB0ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Or7DW/Q3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xG4WhOJr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5922MvqE028539;
	Thu, 2 Oct 2025 04:00:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=281goQrbfS2HM7D0jEPqI34/hUikpuvniBIkllfq7Qs=; b=
	Or7DW/Q3FNbrHGhpypWArOLVilXPjeNB2pyNdLt8FI0LF/0ypPwelVT2EVBVEacy
	9uCAHls5+Mz6hTNEJf6eSe80Ir5VkrrhFXgj9dTLY0GvrsXPefdZxU5qHAnPSX06
	reNuyFaoloGvGIzG+qRsI1NSjhNSf6sR8uqlc4nywc8pMoSnxKJtHOPO5sUtQYC5
	dwZBT9rpwehYVGt5dtXyJp2tDVAbJqFoCaF6JEsYladiB8EJAyUaCVZa+CnzR9S5
	Fkey8tHrhF37ZPe5c7cOj5ObmxlJG7/KJj+sN4wHlqcfp/dCYECNpinZNGNgfb7o
	qTRuvV97Vk9Xjeu98z1aFQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gm3bjps5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Oct 2025 04:00:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5920LvZS012263;
	Thu, 2 Oct 2025 04:00:21 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012028.outbound.protection.outlook.com [40.107.200.28])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49e6ca09ma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Oct 2025 04:00:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOhMD076DDgJsWMORlR1RNM8xixSLDJ5oTtN5Zf/sYlYbBIaYcINcg+J0e8NcFFTSunNUDGeXd9aeN2oGB1rF0uPWVpqiE8nV2WK4G439A4zRuqErkQiViQ4EVe5C+MvPqsZnCYrnjGrdDtIo8yqPX3EJznL+b1kS5IrclrKHjV7/9A1yT6w32Ve49R9o/tT/+UNb1KvEg+E9EBfNoLsLBp1m7oyY/pwQkqnsjv2Of/mpQgQllwtggzZxHyouLNme7BYPugR68uOlPolfJQ9IsWpot18DCZ78LRDc1phEaeISKpmuksIBS1b0bZF3iDguN4uSGhm6i9Iz6jvDeiwSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=281goQrbfS2HM7D0jEPqI34/hUikpuvniBIkllfq7Qs=;
 b=MiuO/n7Jd45peJ2tH/AHlMDpNZL7kFZaeFwnFuAD6ym9gtM9vmpatTFuomqUZud4TK2uyIW8cQhdzbUcCIyH1Fvxxtc7lhxP+E/rxGXHMfoniiJwvg6E6eyS+mTu9AsznhSw6hRHhckF1esZ5/fCqnNQ39WOkz+qPaJHK/gnH49Xxf7iC3NAcqTaeDoffkM06hhqF/30BK/wS2khOgn5ha9n2uprDkqG1/4oPG3tjHHchccAsaKkB0xh4pvatSG2CRnTazk7dBy4uzf0uE7mgmBJRNtOD/o3JV/H3GnGSfgHLJXxCccAgBruNsantS/27EoHqXQb1vPLpInPYteP8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=281goQrbfS2HM7D0jEPqI34/hUikpuvniBIkllfq7Qs=;
 b=xG4WhOJrH+/ZTLqHffEiFTX5baqWPK74V+gOTkky08xgXTkH1qfOXUjfuDnTbgEkErpY5ymDYjFvi4z3/BQ19R8mbmm2+AhB5790jVS9nOnCKQ1haEobfP0we/q/QpW6EBpgl3KzpxBl32mEFIG3g9pkZJWUqylxJJ+1oNu9FPI=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by BN0PR10MB5191.namprd10.prod.outlook.com (2603:10b6:408:116::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 04:00:19 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%4]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 04:00:18 +0000
Message-ID: <abb85f05-49fc-4d5b-bdfd-608425c52e5f@oracle.com>
Date: Wed, 1 Oct 2025 21:00:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] DIO: add NFSv4.2 READ_PLUS support for nfstest_dio
To: Trond Myklebust <trondmy@kernel.org>, Jorge.Mora@netapp.com
Cc: linux-nfs@vger.kernel.org
References: <1759357733-64526-1-git-send-email-dai.ngo@oracle.com>
 <80f31f25d97a2942f7b4e47729e8333af8913663.camel@kernel.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <80f31f25d97a2942f7b4e47729e8333af8913663.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0265.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::30) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|BN0PR10MB5191:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a1b3dbf-a60d-4590-5e98-08de0168339b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T015cUpqSVVSQm1wSy9mQkdBdnJCOUQvMVAvK2psb1Bqd0RHMW5QbGcwdTla?=
 =?utf-8?B?bW9CaG9scjFVVmtPVW04TjZkaks3ck1BbzQ5R2xMNXpoWUpzbWdtVHcxaU5D?=
 =?utf-8?B?NVRma2puTG90MFRkQWlic2kydyszeFU1cHhFNlJYaE5ZSG5HUFA2dHI0Wkoz?=
 =?utf-8?B?R2lpeDl3RWNTWnhzcU5tL3d0ek9iSUxFdGpuMkhSNVF1SXhFM0ZTTTJsckl3?=
 =?utf-8?B?RjdPeTRYVyt4OTJWZ0NzRHNqcVhTR0VpZDlnUitiTDZTaFhtZ2h2VkZHQVdY?=
 =?utf-8?B?NkN2OVVHYUVITnhmdStuRTJuTHhENXdGL1Z4UzA4d2FWOVFzdXFqdW5YS09i?=
 =?utf-8?B?UkxudkttYkxrZFU4cnZJMXlkdkxKSjBlY1ppdVcrRHUyQ0hzSFI2Sm1IUkFi?=
 =?utf-8?B?a0ZrblFVcHBiM1RYLzNIZWQyQXFuUWlWRVVWYUxNZU10WFhGaGJzU3dkcTE5?=
 =?utf-8?B?SG82enlwb2NmZ3ZwVTNJRmRJSTZlbVRjUmJIeDVmSHJLVTNObUFScnE4NjBE?=
 =?utf-8?B?NG9oLzZBMThUTHpvem5rbjV2SGZETlU4MGYrNERQMjhJSWpaVStYeVlrQjYy?=
 =?utf-8?B?MzRRZHFHaGZ0VkJjWS9DemRabldRU3krSWxPWUtXeUdhWnZwWDlaVEJxTmxh?=
 =?utf-8?B?aURNSGVrT1FHcnZTeUVFQVlxcXdHRjF6RGVLaTBnaWlxQ3JwcmhDZkE3VVFl?=
 =?utf-8?B?cGpPaHRaTlh5bTk5bURjNXVCWUlMZDBPcTVWZHBrRUxML2w1aEo1YXBxclFC?=
 =?utf-8?B?VWUyTGtVV3V4UXJuL09Hb2ZhNURwRjNja0l2WFhvdUVRTGJ3SjZ6TzdZWmxN?=
 =?utf-8?B?YUpyNndrVDFXZWppWHQxblk1UE1ob2dhN0JCU2hZVll4Uy9acEhsYzNsWlNn?=
 =?utf-8?B?TERGMDR6QVNlN0pGUzNrS2VHcGVEVTY1Vk0vV0RGbVNTWDFvWTZMamxWOE9W?=
 =?utf-8?B?SjlDNmtPb3FteWc4Z3JOUjZ0ZmZwYnNKUWpBNmVSTmFGNmNnRXBtdlZkT0hk?=
 =?utf-8?B?QXB0bG1iWXhWVWdSZW54bXpyVW1vNHlYdUhzNDh6NlkvWHowRGVXSVNLaGZj?=
 =?utf-8?B?RERaekJzcC82eFEwdFBPL1pDTnhlbGx4c0c5b2E3bnFEdjFxRTZkNnl5TDR4?=
 =?utf-8?B?bG5KRVFNamtFQ21leWNnK1QvWkFOcC9ReXkxWHNnZmtUR0gya280QTd0RnND?=
 =?utf-8?B?WVppUnlrT3A3THgyOWF1K3doRE96alpWMU1FSW1RMGJ2RnZBT1R1QUcyVm03?=
 =?utf-8?B?MEMxK090N1Z2WkVSU0hzSDJzK1NNbXhHT3FMREd2NWR4TldPUlBCamFYN2Zu?=
 =?utf-8?B?di9rOWdoYXBzcEFvZlk3QTZ5OWVjMzFmMUg0cmZpdktkcmtNREcxOUQwYmJF?=
 =?utf-8?B?OW8zaHpKb1g1VmlER1p2N2l5d2VkTnNuQ3Fia0JXV2FHcXZxWGJpQmlpeVk5?=
 =?utf-8?B?TjJ3NDNxNmdZbDhCbXM4WXRobWthUDVqeHdYMXBTTmRmcitiZzd2UisyMGxL?=
 =?utf-8?B?RzBVMjVMNFo2TTQzY0VBLytGaE5YQXdycUhUSE84bnU0RGpwcUIzaUZQZEFw?=
 =?utf-8?B?SERRd25RS3FFODZ4Y0NMOUJta2djS3lJZC9NRHdPaVVudy9Bb29qSWJBY0F1?=
 =?utf-8?B?L3lvODlqL2orcksrc05EM0RjVk5TTkhYWkJuY3d6TkZIdU5jM3lkNVkxemJ4?=
 =?utf-8?B?bm5JdEFsYzN2c3E1Z1FWaDAwTVJmRUVsRkViYlJMMlYzYnl4WkRRS1MvTVd4?=
 =?utf-8?B?a3hIT3hxRkU4TnpSUEE5bStEejdFckk3WE92Tnk5V0RSOXl3UkQ3eUtCRVg2?=
 =?utf-8?B?TTI3dXNmcE1QNVc5Vi9IWmUxNjBaS2p3dUkxZkdaeUJPeSs1Zk5EVjRrYkkw?=
 =?utf-8?B?ekVJeVBXRkw1L1NTenkzekdjTFdlYWN2MkZ0bUpPaTZ0NWpDTWliOXhZaFQ5?=
 =?utf-8?Q?Dd5EyvD37sAOtt2Afb8K6GP9LSG3G1PC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXRPUko5MENjOWc2RDZqUEhzMVZIZktPOHR3RXpUUUNXTytCaktSL29XYU1B?=
 =?utf-8?B?WmpJb3FWVi9ZNWZjTFNLMk80QjNyd3JmNDRoS3VzYktLUVJsdkw5YzlGOHR1?=
 =?utf-8?B?aEVtTTdHcTloeXJEM2FRNzZwaWpCSVJMUzMyNE1RTFA1QzdLY3NCZkdxT09x?=
 =?utf-8?B?anZKeW5JbWN6WWkxZzhPZ3kzTTd4WjNuRWxnRkZKaW83QnVuSGtycS9Ud0o4?=
 =?utf-8?B?WkgvZnQvNXBlWlNUalZRa2grT0wrUkF2R3pyelJSalh1Vzc3dEFDN2dwUVEr?=
 =?utf-8?B?ZGJsZnJLTkQxaW5qbERkZE5zNnhuampOUCtDelppL3BuOTJCektHWEcyWldH?=
 =?utf-8?B?TzUwTk56MDQ1b21GSUxlQUc0b2dNc29lbGRNSytENWZmTVIzeFg3NS9aWWdN?=
 =?utf-8?B?NzJoZnM3Y21GeTFqNjBodkxNL0d4QldzK2tDSVhMY2g5ZDRRY1JLQ0dpSyt4?=
 =?utf-8?B?c3FuM2k0RXZYWnhNUFRkR1BzMjdCeTV5SVNSODdyY0hDT1Z3UkxiWmRENzc4?=
 =?utf-8?B?amtuS1c4bjVqOVRzYllHMno0ZDZVK29jOHB3NXJMbHpscXEvT0txUmFRdDJK?=
 =?utf-8?B?Uko0L3FueVQwajFXY1E4ZFlmSjZQanA5N29FOExTL0JPMUZ3Y2hPV0xxRHVl?=
 =?utf-8?B?NHJGR3dadWRYVy83cldtUUt3dlQ5dE0zZ3FFY1NOTFlIUFQzc0NhcUlJZ284?=
 =?utf-8?B?ODYzUHJWK3h6eUxtaEJ6Wi9ab1FxcmN3TEh0d1UybnRjL3VRdFpDYXIzckU5?=
 =?utf-8?B?ZW5ENzZsamU5cFFBamVRSjZKNEJqWjBxSUgzeHd1V2hXTThrU2o2ekszbGhv?=
 =?utf-8?B?L1R5UkFDRDZtRnA5anE0YThlNW5RT2ttdXRIOXBTMTRJakwzZlBpaTV3S2w2?=
 =?utf-8?B?c1krQWN0S1VIV25CWlZVSm05RmZ5dWZBVlhyVFhrZGFEMXFGUTVtc01vM0Iy?=
 =?utf-8?B?am5FVWR3ZU5zNnNaWmlIcmpITzNncmtnQkZvdjVLK2xXWVY0VU9hNWVWZ0Ez?=
 =?utf-8?B?MUhBK1RGK25GSE1rc3pJRWw0K0tjb2VEN1V4ZFZHTzNPVzU1V3JhUllnRStn?=
 =?utf-8?B?LzQzZHBkN1BHRHZNZStGbjlaVlE4ZG5ZUWtWU0swRUt0UFFUOXZJNVZERyta?=
 =?utf-8?B?VlVJNytTeERNck1LRk5lajhkS2VhNzJhQU81a1p0RlN6U1U1akdpT0pyRHY1?=
 =?utf-8?B?by81aU9uTGswc1pBSFYrRDcxWXYvQ2pXUis0RXFxTG1CbURkbUxGanhBRldj?=
 =?utf-8?B?b1N5dHBEb3hYYkg0WjJ4MnNKa3R2bk1JeS9tcmw3eEkzbG8zbTFxaGMwR3l3?=
 =?utf-8?B?WWpReEpNam90MmdJaEZtUFllTm10Y2sxZmlqUFBvOGc2WTE1NXh6WEtHNWNo?=
 =?utf-8?B?Y2lrRnZsWVNUT2ROcitxaTdheVgwVU5PQXhWempMNDQ3ajlqcVJjdG0yd0F3?=
 =?utf-8?B?dWJkVktpMFVnZGFpVVpsbnIvaGVsUDk3NEtuSmx6MzdSSHl2MThCR3RLSjFM?=
 =?utf-8?B?ZENWZXB0RXJlaERDRE1oWENEVVdJb2t2clBSdkhDQ3VOK2tsS2NxbDREYXNm?=
 =?utf-8?B?ZkdVRk1GRDRPSnplZjFtRWJueEtYQ2VJc0YzZmtZTy9pbzJxMk0wZFpZcU85?=
 =?utf-8?B?R3VYdFZTSzZOZUpLVUdzY0RYYlFnVk1KRUF1NXlqaktobjBicit3Sjk1bzlN?=
 =?utf-8?B?WlgvZnUzYVpSdnFMVzBWSDNFSlpnam5aNEhXRnhTZkdDdjFudjR5MVdIdGh4?=
 =?utf-8?B?UVRFa083SGV4cUR1K2t1VWdhZWpVNTl3UVdLRC83QkZXY2NtR0RjRzZWanBW?=
 =?utf-8?B?K2RnTCtLU0M3R3RNMDk5c01GVTBXWjk5d2N5SGFhTEZVWDBhby9GM1JmVXVT?=
 =?utf-8?B?Ui8yUEU1bVUzVDdob0R5RmkrU0xFOXJSVVhtemtDNmxZdExrQ0I0dlhIWmJn?=
 =?utf-8?B?YUk4Q00wUUljL3FGMXo3MThjSTM1RDhJUnl3NldRSjFKN0k2VVhISEl1bVZw?=
 =?utf-8?B?bGN3d0ZwaVNpMmJUZFZSZjhobzNSSW40eTBGakVmMklVb2w3MWtSSzdxYita?=
 =?utf-8?B?SVgzWVgvZUt0bGVtS21GYlhrbmpxMVRmcXMvaGloTzBOUitGYmZMNlhZR0gx?=
 =?utf-8?Q?WWyM48vsFdc3QXJmwjmOefkqK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sEKgnPVIpEE42MuFrYC9U/ItypZORc6iDKAIE/5iCn/OdA2H10D4z1uxL/0KDj230KAvNVArb3Kch33fz2MWkgS6BP/Kyne4xywkVVGTOy7JajXAQ4c0Szyl1JdUTmserDT6lAqlnRzL7kQkfHoBaujj0omMMkHaQsXxzQHhWdCur5/YT4DE1Y1Uu0/lmLSW2m5apvt5tXPoL7QKDOYEKuSHC8tJ0zbl+TuC5++7+vl2Wr63CVcpopJDN4FhWraSQR67HNsHy734wJQq1aLNh6EaUS+dIWlXU3dub47Kh3EEobhg0w0I4Z9nI2sr2hQKq5p7gXYB6EsIB45iEbdgF5rJ3xIU6Fidpsr3bu0tBDTGaFRVIKPDK8HFXhFwugbi/BbBPYHZKXSuE1N+jzC68abbXwgalVX/YGioVyH1plUJxfMlb1KJTP7txqs7BHKj9sC8urOxXa8tFsXLVyZ34C/gfXi31WUeg1G13OqgRkzoQ1OdM91mBxeouBTomoES6YVQbyoZghybJsmKgxpP927ysYrQt+JZ+1KwUNf4n/lDUeafRuFSndJMhRx4Qkc123Jvjf8o4lXhL40nbnYnSi+3uzdN6gh/06sgZj5se2U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a1b3dbf-a60d-4590-5e98-08de0168339b
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 04:00:18.8461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8sEkh1nMf7SO0c9/d9LgLxrzX6r4c836l4KtmDL5j9lxA9Orwjjc0vUQg+dZ5nCNwV5NLPXBbCycRKsFaFaFUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5191
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510020032
X-Proofpoint-GUID: MVnOi3CqrZJ4PrCG0REHztNudjm99YCD
X-Authority-Analysis: v=2.4 cv=GsJPO01C c=1 sm=1 tr=0 ts=68ddf8d7 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=HWsUtvSUUlqsDhaAbZsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12090
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE2MiBTYWx0ZWRfXz3lUU34RwdYL
 uGKO28MwI0N6orrrUh1SMykxrCejGezMGN4OcJT1IMZNX2YEPRJy/vzobDVPkyjSJ2R+mFLrqTG
 EP04Kpix86u8gan1/1t52cvx4j7owwkv6PDq6POmt2xmCNuLcBoLibDSPw8cwqg/6uvheWf4ydw
 A++CnokzfcqEwT0xbcV4Ahu51/pLeOz0enAHcaYgR/3GwOmyJms+L8vIz5DrSyNT4ch7wBDZPWh
 LMBUVjNPQR+6wxQ3xwoyPmf8Gy3hMiMi0rgknGIskRPAdrK02t1Y6z38NtsaBmS+qfwu3SlXhYJ
 wyZHVZCvipaL4ebH7nStbOV1P6LsYsRArwyOXL2SlXPD5LDVyEVajHXH3s8595herzb1W0Q+ZsE
 OpGEi+CNDQ7cWvi+sWIUL8x4h6XTSLL2MmMShpqI8WP9ej1zIVc=
X-Proofpoint-ORIG-GUID: MVnOi3CqrZJ4PrCG0REHztNudjm99YCD


On 10/1/25 4:53 PM, Trond Myklebust wrote:
> On Wed, 2025-10-01 at 15:28 -0700, Dai Ngo wrote:
>> From: Oracle Public Cloud User
>> <opc@dngo-nfstest-client.allregionaliads.osdevelopmeniad.oraclevcn.co
>> m>
>>
>> Check for nfs_version >= 4.2 and use READ_PLUS instead of READ.
> Hrmm... READ_PLUS is (like all NFSv4.2 features) optional to implement.
> As such, you really should expect that a server implementation is
> perfectly within its rights to return NFS4ERR_NOTSUPP, in which case
> the client should fall back to using READ.

Thank you for your comments Trond. I'll submit another patch, if Jorge has done
it yet, that probes the server's support for 4.2 reads and use it appropriately
in the test.

My initial patch was written with only the Linux NFSD in mind.

-Dai

>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   test/nfstest_dio | 16 ++++++++++++++--
>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/test/nfstest_dio b/test/nfstest_dio
>> index 093e552..653a842 100755
>> --- a/test/nfstest_dio
>> +++ b/test/nfstest_dio
>> @@ -617,6 +617,8 @@ class DioTest(TestUtil):
>>   
>>               if nfs_version < 4:
>>                   match_str = "NFS.argop == %d and NFS.fh == b'%s'" %
>> (NFSPROC3_READ, self.pktt.escape(filehandle))
>> +            elif nfs_version >= 4.2:
>> +                match_str = "NFS.argop == %d and NFS.stateid.other
>> == b'%s'" % (OP_READ_PLUS, self.pktt.escape(stateid))
>>               else:
>>                   match_str = "NFS.argop == %d and NFS.stateid.other
>> == b'%s'" % (OP_READ, self.pktt.escape(stateid))
>>   
>> @@ -744,9 +746,13 @@ class DioTest(TestUtil):
>>               fd = None
>>               bfd = None
>>               ofd = None
>> -            io_str  = "WRITE" if write else "READ"
>> +            if self.nfs_version >= 4.2:
>> +                io_str  = "WRITE" if write else "READ_PLUS"
>> +                bio_str  = "WRITE" if buffered_write else
>> "READ_PLUS"
>> +            else:
>> +                io_str  = "WRITE" if write else "READ"
>> +                bio_str  = "WRITE" if buffered_write else "READ"
>>               io_mode = posix.O_WRONLY|posix.O_CREAT if write else
>> posix.O_RDONLY
>> -            bio_str  = "WRITE" if buffered_write else "READ"
>>               bio_mode = os.O_WRONLY|os.O_CREAT if buffered_write else
>> os.O_RDONLY
>>   
>>               if not bsize:
>> @@ -861,6 +867,8 @@ class DioTest(TestUtil):
>>   
>>               if nfs_version < 4:
>>                   io_op  = NFSPROC3_WRITE if write else NFSPROC3_READ
>> +            elif nfs_version >= 4.2:
>> +                io_op  = OP_WRITE if write else OP_READ_PLUS
>>               else:
>>                   io_op  = OP_WRITE if write else OP_READ
>>   
>> @@ -985,6 +993,8 @@ class DioTest(TestUtil):
>>   
>>                   if nfs_version < 4:
>>                       bio_op = NFSPROC3_WRITE if buffered_write else
>> NFSPROC3_READ
>> +                elif nfs_version >= 4.2:
>> +                    bio_op = OP_WRITE if buffered_write else
>> OP_READ_PLUS
>>                   else:
>>                       bio_op = OP_WRITE if buffered_write else OP_READ
>>   
>> @@ -1270,6 +1280,8 @@ class DioTest(TestUtil):
>>   
>>               if nfs_version < 4:
>>                   io_op = NFSPROC3_WRITE if write else NFSPROC3_READ
>> +            elif nfs_version >= 4.2:
>> +                io_op  = OP_WRITE if write else OP_READ_PLUS
>>               else:
>>                   io_op = OP_WRITE if write else OP_READ
>>   

