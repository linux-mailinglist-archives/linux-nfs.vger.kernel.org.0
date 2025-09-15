Return-Path: <linux-nfs+bounces-14453-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AA7B5846F
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Sep 2025 20:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 599AD7AA692
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Sep 2025 18:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E1A1F3D56;
	Mon, 15 Sep 2025 18:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fwuOqzOL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ca5s93wB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B440DEEBD;
	Mon, 15 Sep 2025 18:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757960447; cv=fail; b=HsF5aTxPy7YovxxjZgl4oNCzAlTiQ2EUmLKN2iysZ7/DuEf1ovkkdD+3P867g0Zmn9rvyblgQ/5e6YDrGaoK7CZPPQdCx0F1E7xBaS7UNP/PWSyTWCqIdZWq954+SxzqanMr+USaqG09kGr6WLuQCMyNo5bqh553GIjWMWZDKzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757960447; c=relaxed/simple;
	bh=BFno2sZjMVa+cRYfip1nSkZ3AjYJhWNRYAzgoYaK7Mc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tBNhaMmDmE9Yy6Z3SHNb9Vdip2tJ+B0JHTBuGOL9ohOo88dGanPwCbkniinru9jf/t9ScAxd07g3hYr82ISGjvrdwTXLgcrcm1B62pYw/RtugYEZjxvl/j5h5ENyht4MfP3vN96EMzmTb6cK0/1oFu8aImFnk12PA6chzxvvG4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fwuOqzOL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ca5s93wB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FFSleA013082;
	Mon, 15 Sep 2025 18:20:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=GqMhfufLTgEwOW5wisdSANJmKmBHxkB8eptXGlwx7d4=; b=
	fwuOqzOLu30Ax9STbDYjtN5IASCPzwH31L+zC/6hvqA5niXQUpvPuGLzkmCJcbMu
	JSyb3EpuiFPjYXe2GLEbBhMQm4hcmimacJ5erdXdD/Kaad+MqElLLXx6hvGrBAus
	YMpJMdB58VfkWDDQE4up37AHIFrTMwc3elx7H500d4jVuFkPb/0pW8lnkjH1Rqn6
	QcUfT7dzgxU/uKHb53VQTtC5xTlPqxub3UWFxHnVzU1qHLD3Cuu/yORyZTAEd6Aa
	7RXWg/OVQErq5sC0EXWh6H9UeqU9FmuNkpvpF4v8sxysTM5pa0v0HtAKa+kcZYml
	DtTOxHbNt+HB5jg0VDxyeg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4950nf31sx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 18:20:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58FHukUe037331;
	Mon, 15 Sep 2025 18:20:35 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010026.outbound.protection.outlook.com [52.101.46.26])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2hn6gr-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 18:20:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SMq50mvxa7qR4Mjhda+lweeE4WJ+eGEypyvqZ+63ce7TxPGauA6p3K4r/RxpxJfycrRvetVzOuZ7ltIAMkR/MTJkJj+T35Ea1UP2pEzOvd2FVFTk6Ii8ESB089J5gk3tWrdbxmcFVVxvvGT2g6B+Cp3whKDGK7i9wnkihALYv3kCJLtuuDdbYaTlXEbj+ZXyOFWbRryGDLzJ2epOU8/2saiXgJJjIu5bXVBGr0ii/q2DsDpoGhcJryS39mnOLx8POTZTkziVN+Gq7rxznRnclmcu8V5PhRVhsjIw7IpeUS71u1CBoVbS2o3fJPezmxk9w9f5PS6g+adpA2sZ/Vs1kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqMhfufLTgEwOW5wisdSANJmKmBHxkB8eptXGlwx7d4=;
 b=UduLOnC690m9AFdvf5mTDhUVWz1TGWmB/EjNINFSmf7vBAcWvRJAmcj2BGFlNEJazFee1IfkBK4xia2X5il3WUvgFVuvgntoEkrhmPl2jBrXZ+Q+gjHe5FpqyvPm8vDTp1BvVgotYhiuYg3U6SyER3KCqWVPjcfIdaQDr4aSZED27hI6dcaAX+ewOUw8ohIFHXyNm/yBkl8QHI3IHd6g7vyRuXLksMtf7GY89sx5Kw8Imtz0oNdzXA2PKipIXjQItBIyVZ0wZ88q7V3VVkXVE0SC1YrN75hATbvCStdbCZGrpp2LXnxnskpqp+FCm9u7dhuV9+dprDDrYsOCokU95A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqMhfufLTgEwOW5wisdSANJmKmBHxkB8eptXGlwx7d4=;
 b=ca5s93wBeeYeyDp3vwjYiuE35mYs/S4RHdU1Z3Mhh4II01mQewiytjDafrKNG0I+GZf+Qhzw4ACI+cqFWt2CyzaU39gA83E50EnpPBVVkaEz64Yhb9dFtd+4YhbC2inuWtL5/pXTmk5WQFR9VZFhGgx0xZHraZ5TZUH+ZMYJ13w=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by SJ0PR10MB5892.namprd10.prod.outlook.com (2603:10b6:a03:422::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 18:20:31 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%4]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 18:20:31 +0000
Message-ID: <0bceffb3-cd24-4d11-ad63-0a2b333d774b@oracle.com>
Date: Mon, 15 Sep 2025 11:20:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NFSD: Impl multiple extents in block/scsi layoutget
To: Chuck Lever <chuck.lever@oracle.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Talpey <tom@talpey.com>,
        Sergey Bashirov <sergeybashirov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>
References: <20250911160208.69086-1-sergeybashirov@gmail.com>
 <73d6c14b-40f5-4546-9f87-a59595c51d77@oracle.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <73d6c14b-40f5-4546-9f87-a59595c51d77@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:345::28) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|SJ0PR10MB5892:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c911f27-ae8f-4a02-87c0-08ddf4848dea
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Smx0bkMyUjNHL2l6MnZzRlVSZGZSQW1xUGh5ZHdTSFlmS2Q1bmdqTHJ5UnhT?=
 =?utf-8?B?ZjdzcUFoNHREN29RanZoUDVhS3V1KzZqbEFsUXVlOEJmN0l6eUhQbU9lbU5i?=
 =?utf-8?B?RVh1aitpRWNxVEdBc1dvYTJyMEx2a1ZWUWh1Y2FEeVNZNkhSKzJBN2ZyUWdz?=
 =?utf-8?B?N2o0cU41MnRwREpSZGFHYzBrL1ljdXZaS2JoamZTM1dxZ2FrQk9rYktpVGlN?=
 =?utf-8?B?NUoyZEkxVkxtcVROK1M5Q3cyVThsa1Y1T284N1ZlUm9Ka25BemQ3SG5RK0FY?=
 =?utf-8?B?VW9oM0NIUk9XSU1oQnFsa3Zoanc4NnhjbE1MVkdDWWpLclFFV0ltV0pyZWpU?=
 =?utf-8?B?MktNalBVT1R1dUtocSt2OUpZZjFrQnIzc2hoVHg4WHJrazdqZTNvZmJIZi8z?=
 =?utf-8?B?Tnh5TGhGQkF6ekxHNjZBYWVSZ0J1azZNNTVBVHBJd2VxT0oxOEgwSTdoMC9Y?=
 =?utf-8?B?T3d6TStTZEVFaW1QOGJ2Z2pKUUpRbGx1Qkh1aHN6NXd2VGhhRlhhbGtyUFlj?=
 =?utf-8?B?b2tENTlwcGVWQzBSbEd5UFZMVlNNWjZ2MmdOazR5bnZRTEMxaWYvY3pjT3RF?=
 =?utf-8?B?SExmM2tncnY3YVpqd0F2eWdTamJWUDZMMTg3OEJlRVlUZlpmcU5EbmhxVmE1?=
 =?utf-8?B?RUNTNlJXL0dMYXRDZ3FwcHpjZ29TQno0bXdkbFk0cnZGTmV6SWFHbGExN2hj?=
 =?utf-8?B?NEdoL1M3NmtFaWNPcVplRkY0dlRKcFRrZU1jMlc2TUpwNTNaeWJTaE44YlQ0?=
 =?utf-8?B?aHpBKzAwR2FDWGFqT2w0QlJLMStIOUlabEhtbWN6eERXTVU5TDRZZ3VVdGRQ?=
 =?utf-8?B?amhCSTNWbFYzR1k2OTg3NW9iaVNzT3RxVk1QVHhDRTlRSUFhbHpmQlZkMys5?=
 =?utf-8?B?MGFJR0szVUY3Z0o0SGR5cGc2SnNLS0RuRnFWaTlrT29WdyszN280RXJDdXYw?=
 =?utf-8?B?dUdxcHFKWWRSV2Jpa2Vna0N4Y2tkNG0yRCt5VlNvSVp0THJYbUU1eHpFSElK?=
 =?utf-8?B?TFpjL1NTZVlHakZGNDlhazBsUVlueDRJQ2JLVkpYaWtTUkFiQjhjMUVxVGlN?=
 =?utf-8?B?dk9XYmY5a0czcGc4Ti96ZW5hcVNFRDIzK3ZvODVMb2xJVjVyS3IrR25GdDNP?=
 =?utf-8?B?WnNtQlh5VlY5WjJ6RzR0NCtwdEJOOTIrbW5yblBGV0VRQmJFNTZsbm56bkNX?=
 =?utf-8?B?cmRXRjVLU05POExqN2VPNjhLWlpTVjR2UVZjcmU2VTJTaldDSDk2bjk3UWha?=
 =?utf-8?B?VkFEWXl5Z2JTekZ0UjJ5OEY3K1g2VDIza04vekpZZDRVQ1l5dVhVTmFzcjMy?=
 =?utf-8?B?VVZGRWR0YjB2UnRHWXpRaVFaUi9vVnU2VkhMMGUwQldOWks2MzE2Mkl0T0t4?=
 =?utf-8?B?UUxEUi8zdWpaMHBBVGFzdDQ0a09RNUFiR1BtYUZnbVlqdWNkeGp6Z3RYc3Vu?=
 =?utf-8?B?ZUY1ekFLWkl5TXhYRThoTlFKTWJEQkY4UzRlSUxFRGgyWlNXNDB3Nmw4aXBE?=
 =?utf-8?B?VG1LeUtDdE1QLzhudFM5MmJPcW0yNHliZGZPQkxSUjV6cjVtdGN6ZGZBV09n?=
 =?utf-8?B?OGpSQ1NoTWVVL0g3cnFWRWFnM1BwWGFQUFRGZnM3WEN4SERqN2dpUFlqWlR5?=
 =?utf-8?B?UjF2MWtEbnBHMVJPUldiMXpXU1dlQUY2YmthTlJWdDd5T2hmL2RPM3o5T3gw?=
 =?utf-8?B?dWZlZitEaGZEU0FGcS9HTE95QlFDeXVjZFhZSkUvcXE5dDlEbzdBak5XdXFR?=
 =?utf-8?B?c3FnM25kV3JKYUtnSzRLYjcyeTZOMlBNME54aXV5RXErREVFQXd0WmhFSDJl?=
 =?utf-8?B?MWxBYlp1ZEpSb2Zrd2Z2bHQ3anQ2ZDhqeFFWTmVadHhkaTU5ZHpKREpDaVp0?=
 =?utf-8?B?THZLVmJ2ckU0eC9TQUo1VWlKMTVWbElxWDVLanBVTU56VUJSNWtGNkVFVGsy?=
 =?utf-8?Q?I/bTxWbqofQ=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bkxQNytBTGhLUStwZXUyWk02SHZGdkJaZEtsT2szNkxjZnY0UGRUTGowenJ0?=
 =?utf-8?B?U0lJR2x4YVlBekZEWHIrZzU1ZXU2akF1VzVROVlkdEpKUkJMSEZZc0VFcTdl?=
 =?utf-8?B?dkZya2x6bGFydXNNNDAzUVNjUm55YXRqUWNyWG9JTXBBTGVCdndZQzdqQUpD?=
 =?utf-8?B?cGZEWlgrZW4zYmVEUlJ6ZVlkVVJBZHd6WmllbFA1bG5KN09jYkc3c25sZEMr?=
 =?utf-8?B?THQ1VmJGTFluaVlEQlhZb1JiekFZMmg2T3FTSUlTcm9MMW9KbktFa29xQnJZ?=
 =?utf-8?B?b3Y3RW4wVWZqWlU5RDZqWVJRdzFUQVdya1dxSmt1clcvZzNzQlpHbXJhQ1hG?=
 =?utf-8?B?dU4rclVHcFNGbVQveGRsaEpIODFaWTIySUViQTgydEhoY1FSNDdDZmFzNDRa?=
 =?utf-8?B?YkhMTVI0Ym56bzdKSFBFbzVFYVdQdUc0NzJ5VHQzR0NJYUgrVlBBL2I0ZTYw?=
 =?utf-8?B?SnZNMThrTnhkd2FuWWRXeDcyNVNzcEQ5SmlqUER5M2RWRWZ1YnJZbm5RK1RW?=
 =?utf-8?B?WFNmY3NGSVlTRW44U3NYZHNCODRvdXdMTFRRNWZlcTBVU0dwa1VsNEsxWHcy?=
 =?utf-8?B?NTRLbTdGVkF4MzZnS0FCMlhNMnYzTUZBcm5rcjRiWkd3Z3dYYk9Iek1hazNL?=
 =?utf-8?B?RkdUbUVyZnM5eVhac2dkbTJnc0h2emc4YkdxZ0JkWUF0MmRTcjlVWjk0Z3Ba?=
 =?utf-8?B?c1dER1B4QmlMMXhaVXhUYzc4T1R3NjRJWUVjSVowNytyWTJhSU8wc1VwdEo1?=
 =?utf-8?B?TndTSUpja1VRRzlJdVhKbjJwU1h6TmkrY1RWQjBsVkdWTDNoaCt3SjRvZGU4?=
 =?utf-8?B?RUhnYXNPME1lWmFhWlZTOEZwdml4SlNTSTNWaGlObUxUcldId21jditzZk5m?=
 =?utf-8?B?RFZoREJGejJpNkx6YWIxS2tOZS8vWUU2bUQ4SDZMeHVqMndwWTArdWpncjJw?=
 =?utf-8?B?cnhRZVgzbzNjTnN3ZTNXaFEzMklNVUJ4VUhZdDlEeU94U2pUY2w5L3BBVXNL?=
 =?utf-8?B?UTBzR0hSeE9ZUFBPNU1iUmx4UkJ1SFhOL2JlVklmRnNzc3N4UURuTy9pTDlQ?=
 =?utf-8?B?VU91RUl5aDgwZ2NjODFHSWFxcWFHVEF3bHQvOWR6RkFrNzBHQnk3UGJyMUZH?=
 =?utf-8?B?R1hlUU9DRWJBRXJWaHpyNHNpMTVaWmptdWQ2MlRRM1FqTWpNT1FmOHVGSkRM?=
 =?utf-8?B?M1o3NzFORmlQN1NMcCszc1hHanA2T0QyNlVleWx2cVhpeHJrNWFLR000aU9F?=
 =?utf-8?B?REYya1NzVjJ0a210YTdROUxQSnNma2pkMUhxblU5Yys5SVZxSWhRb2o1YnFj?=
 =?utf-8?B?Q3JzTm5tRkxmM284b3QxeU1Fd2tsVi9XT2RVZTZ6WXRENnJ1NUtGVEFOam9Y?=
 =?utf-8?B?R0NMZjlrMmR6QlJRdWd5UkdhSmFpU05OWHNYM0ViYm02VGRnRU9aNW5IbGJj?=
 =?utf-8?B?K2ZsSVl1Z1psd2RFaWVPTEx3YkpQekNkSlJobGhwOW1oUzg1allRakdmdXU4?=
 =?utf-8?B?Y1BnY0d2dm5kOGw3TjNjRFZZcC9EaU9YNmJzUEJBTXVKWUxFRHBUd0d5OTk3?=
 =?utf-8?B?L3BHVjQySkdJU3RrWkJFeGZQZUlFKzdxVjZ6Wk9WNWR2cHFBRjArTWJWMVc0?=
 =?utf-8?B?SkVjU3psRG16OXpib1I5dFl1a0pPcG5kaCtRQ3c4Wmp2R0lZcjZTWU83ajh5?=
 =?utf-8?B?MFBHTnJ2bmZYd0t0d21RMENIOU1jYWU3aWlBYk1RZ29BVVhWcm4yMEhZQVp1?=
 =?utf-8?B?cTlibVo4KzJQWDFJRUVjamlSc25rYjJTQlBDTjY5RTU3MzNIUC83bXVLQVdU?=
 =?utf-8?B?WXUvM0ZGQ05KWDdETUp4TmxqRHBCdTZKSEhnTzFDN01pOUJ1WW9wS2paUXZV?=
 =?utf-8?B?dDBUQ3JuRVFqQ2tOZmVZb0dQQWZOcWJHa0lJbXpUa0xBdzk0ckF6N0pROWNW?=
 =?utf-8?B?K08xRWhsdXRGb3VkZzd5bllCVnFsQjM3WURaYnlXa3FNOHUxS2ZPRlBPSDZY?=
 =?utf-8?B?ZXpic2I3Z1IwZnl3b3pyT2l0VmJQZnozb0poZUM1Qk5sOVRvalRnNkR6a3ph?=
 =?utf-8?B?MUNHU1NoZHB5UVlFUnFhTG53aFF6TmloVWJlL0dKcG10bU05L3pJcmNtL28w?=
 =?utf-8?Q?m6eZRPdiRGlK5Sv5+RR7n3uc6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PfiRd2PCazKFcJ/MdylDS5SJP6kCqkZEWfPNa40vhOJ83Hz47fGZgJVO284DoPUa/FBhz51Y6y/lrQ+UF+XD2tOGnyWcHdGlE/i219KJ/5k+cEqO/O2LvxgRmyZk9UcLU1b2uhs/3WpU1S74pl2dQ+J7/sEgJeil9WvICydCf7vws0PePvjXXzEyo3Id7vER/dw1ENZaYDdXDF+DtDVlzjX1li/UH/NpjJF+JQmwdZWlyItXIPf+MiCY0k2ZzYU2aKk0OwsGdOEp3dOttaL9Ggo8scv5Dl/H8Wfppjseh5twwUCB/2HFLJe1acnYHMEB6t89EL+29GBqc5sa0cKa9WfCyrUZe1fvg/7HXnjp2i/0OGwkKtqv92zfbnlCa7fVtBGLr0M/fEW7Z/iCZ3tVVWKWzNfnt+3jgd9qDHgg3AtBCT0+HBvlSA8GB1y0CF0TRIZnLUR5JkNoPPgrUN4HDWAsMdlCt1Z4VF2QWpXZ4QeRNXkECK7fw/0DYz+Hr3+Y4K0gTXqeTc/iu4rAKcsVRdyw6wE5KyQ/Gd7vdQaRMoRgvVH+KyKUHdyAr4f0ZN+sGrNwhd7fyo0ZXqYYk/SavpQ/9WI7CX/Rzsxvq5IF+SU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c911f27-ae8f-4a02-87c0-08ddf4848dea
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 18:20:31.3962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6yhB0nzSFlfVIkE1wOU8AST9TI5OTRzY4I85REixU5pMUamwxBDGOP9fnBXy1o/UJxjg+D6wpmPE1A+uvD/vtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5892
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_07,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509150171
X-Authority-Analysis: v=2.4 cv=S7vZwJsP c=1 sm=1 tr=0 ts=68c858f3 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=KvTqMILSzxOG5j1yxR0A:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12083
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyOSBTYWx0ZWRfXzAXmPsCMs4xh
 iq6pXC050oAXi9QU4B1hc/HRlwbK+8NMB264+/l5LhJFD0urEhYOSjBysVqkS/tprGuruz/LoJr
 QxnbA4PePOR37XAND7R2hUtqb1sDIuiiw2WNeHXm27TQtj/Mi4mbKoCuyQzPPoYOKn/96dowGY4
 UqSk7+A4JAAzFZN6GFnNB2BniWW6IuGWrsUCmBk9HtIr+6SV8aGUeiwVDHuXd0nqeSXSZubwOam
 PmNFUX9wwhS4G767z/t7H+vvFNNBz+rnvam3qVOH2VBjW+DY3vE6+9Nu3fnitZWZcslMZnEMFJk
 k7JBWFALTwyyo81fNypERLCqJ/F1dRSm8A5+MDU15u//c/yOVeuQfmG7HlufRg/TmCDtsZY0KzY
 96eaN33xfCKCj/BdiKwMs00LbjNJxw==
X-Proofpoint-ORIG-GUID: -alcTutNPAvUTJz_KCjIlotTWgYxhlut
X-Proofpoint-GUID: -alcTutNPAvUTJz_KCjIlotTWgYxhlut


On 9/11/25 11:05 AM, Chuck Lever wrote:
> On 9/11/25 12:02 PM, Sergey Bashirov wrote:
>> This patch allows the pNFS server to respond with multiple extents
>> in a layoutget request. As a result, the number of layoutget requests
>> is significantly reduced for various file access patterns, including
>> random and parallel writes, avoiding unnecessary load to the server.
>> On the client side, this improves the performance of writing large
>> files and allows requesting layouts with minimum length greater than
>> PAGE_SIZE.
>>
>> Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
>> ---
>> Checked with smatch, tested on pNFS block volume setup.
>>
>>   fs/nfsd/blocklayout.c    | 167 +++++++++++++++++++++++++++++----------
>>   fs/nfsd/blocklayoutxdr.c |  36 ++++++---
>>   fs/nfsd/blocklayoutxdr.h |   5 ++
>>   3 files changed, 157 insertions(+), 51 deletions(-)
>>
>> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
>> index fde5539cf6a6..d53f3ec8823a 100644
>> --- a/fs/nfsd/blocklayout.c
>> +++ b/fs/nfsd/blocklayout.c
>> @@ -17,48 +17,39 @@
>>   #define NFSDDBG_FACILITY	NFSDDBG_PNFS
>>   
>>   
>> +/**
>> + * nfsd4_block_map_extent - get extent that covers the start of segment
>> + * @inode: inode of the file requested by the client
>> + * @fhp: handle of the file requested by the client
>> + * @seg: layout subrange requested by the client
>> + * @minlength: layout min length requested by the client
>> + * @bex: output block extent structure
>> + *
>> + * Get an extent from the file system that starts at @seg->offset or below,
>> + * but may be shorter than @seg->length.
>> + *
>> + * Return values:
>> + *   %nfs_ok: Success, @bex is initialized and valid
>> + *   %nfserr_layoutunavailable: Failed to get extent for requested @seg
>> + *   OS errors converted to NFS errors
>> + */
>>   static __be32
>> -nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
>> -		const struct svc_fh *fhp, struct nfsd4_layoutget *args)
>> +nfsd4_block_map_extent(struct inode *inode, const struct svc_fh *fhp,
>> +		const struct nfsd4_layout_seg *seg, u64 minlength,
>> +		struct pnfs_block_extent *bex)
>>   {
>> -	struct nfsd4_layout_seg *seg = &args->lg_seg;
>>   	struct super_block *sb = inode->i_sb;
>> -	u32 block_size = i_blocksize(inode);
>> -	struct pnfs_block_extent *bex;
>>   	struct iomap iomap;
>>   	u32 device_generation = 0;
>>   	int error;
>>   
>> -	if (locks_in_grace(SVC_NET(rqstp)))
>> -		return nfserr_grace;
>> -
>> -	if (seg->offset & (block_size - 1)) {
>> -		dprintk("pnfsd: I/O misaligned\n");
>> -		goto out_layoutunavailable;
>> -	}
>> -
>> -	/*
>> -	 * Some clients barf on non-zero block numbers for NONE or INVALID
>> -	 * layouts, so make sure to zero the whole structure.
>> -	 */
>> -	error = -ENOMEM;
>> -	bex = kzalloc(sizeof(*bex), GFP_KERNEL);
>> -	if (!bex)
>> -		goto out_error;
>> -	args->lg_content = bex;
>> -
>>   	error = sb->s_export_op->map_blocks(inode, seg->offset, seg->length,
>>   					    &iomap, seg->iomode != IOMODE_READ,
>>   					    &device_generation);
>>   	if (error) {
>>   		if (error == -ENXIO)
>> -			goto out_layoutunavailable;
>> -		goto out_error;
>> -	}
>> -
>> -	if (iomap.length < args->lg_minlength) {
>> -		dprintk("pnfsd: extent smaller than minlength\n");
>> -		goto out_layoutunavailable;
>> +			return nfserr_layoutunavailable;
>> +		return nfserrno(error);
>>   	}
>>   
>>   	switch (iomap.type) {
>> @@ -74,9 +65,9 @@ nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
>>   			/*
>>   			 * Crack monkey special case from section 2.3.1.
>>   			 */
>> -			if (args->lg_minlength == 0) {
>> +			if (minlength == 0) {
>>   				dprintk("pnfsd: no soup for you!\n");
>> -				goto out_layoutunavailable;
>> +				return nfserr_layoutunavailable;
>>   			}
>>   
>>   			bex->es = PNFS_BLOCK_INVALID_DATA;
>> @@ -93,27 +84,119 @@ nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
>>   	case IOMAP_DELALLOC:
>>   	default:
>>   		WARN(1, "pnfsd: filesystem returned %d extent\n", iomap.type);
>> -		goto out_layoutunavailable;
>> +		return nfserr_layoutunavailable;
>>   	}
>>   
>>   	error = nfsd4_set_deviceid(&bex->vol_id, fhp, device_generation);
>>   	if (error)
>> -		goto out_error;
>> +		return nfserrno(error);
>> +
>>   	bex->foff = iomap.offset;
>>   	bex->len = iomap.length;
>> +	return nfs_ok;
>> +}
>>   
>> -	seg->offset = iomap.offset;
>> -	seg->length = iomap.length;
>> +/**
>> + * nfsd4_block_map_segment - get extent array for the requested layout
>> + * @inode: inode of the file requested by the client
>> + * @fhp: handle of the file requested by the client
>> + * @seg: layout range requested by the client
>> + * @minlength: layout min length requested by the client
>> + * @bl: output array of block extents
>> + *
>> + * Get an array of consecutive block extents that span the requested
>> + * layout range. The resulting range may be shorter than requested if
>> + * all preallocated block extents are used.
>> + *
>> + * Return values:
>> + *   %nfs_ok: Success, @bl initialized and valid
>> + *   %nfserr_layoutunavailable: Failed to get extents for requested @seg
>> + *   OS errors converted to NFS errors
>> + */
>> +static __be32
>> +nfsd4_block_map_segment(struct inode *inode, const struct svc_fh *fhp,
>> +		const struct nfsd4_layout_seg *seg, u64 minlength,
>> +		struct pnfs_block_layout *bl)
>> +{
>> +	struct nfsd4_layout_seg subseg = *seg;
>> +	u32 i;
>> +	__be32 nfserr;
>>   
>> -	dprintk("GET: 0x%llx:0x%llx %d\n", bex->foff, bex->len, bex->es);
>> -	return 0;
>> +	for (i = 0; i < bl->nr_extents; i++) {
>> +		struct pnfs_block_extent *extent = bl->extents + i;
>> +		u64 extent_len;
>> +
>> +		nfserr = nfsd4_block_map_extent(inode, fhp, &subseg,
>> +				minlength, extent);
>> +		if (nfserr != nfs_ok)
>> +			return nfserr;
>> +
>> +		extent_len = extent->len - (subseg.offset - extent->foff);
>> +		if (extent_len >= subseg.length) {
>> +			bl->nr_extents = i + 1;
>> +			return nfs_ok;
>> +		}
>> +
>> +		subseg.offset = extent->foff + extent->len;
>> +		subseg.length -= extent_len;
>> +	}
>> +
>> +	return nfs_ok;
>> +}
>> +
>> +static __be32
>> +nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
>> +		const struct svc_fh *fhp, struct nfsd4_layoutget *args)
>> +{
>> +	struct nfsd4_layout_seg *seg = &args->lg_seg;
>> +	u64 seg_length;
>> +	struct pnfs_block_extent *first_bex, *last_bex;
>> +	struct pnfs_block_layout *bl;
>> +	u32 nr_extents_max = PAGE_SIZE / sizeof(bl->extents[0]) - 1;
>> +	u32 block_size = i_blocksize(inode);
>> +	__be32 nfserr;
>> +
>> +	if (locks_in_grace(SVC_NET(rqstp)))
>> +		return nfserr_grace;
>> +
>> +	nfserr = nfserr_layoutunavailable;
>> +	if (seg->offset & (block_size - 1)) {
>> +		dprintk("pnfsd: I/O misaligned\n");
>> +		goto out_error;
>> +	}
>> +
>> +	/*
>> +	 * Some clients barf on non-zero block numbers for NONE or INVALID
>> +	 * layouts, so make sure to zero the whole structure.
>> +	 */
>> +	nfserr = nfserrno(-ENOMEM);
>> +	bl = kzalloc(struct_size(bl, extents, nr_extents_max), GFP_KERNEL);
>> +	if (!bl)
>> +		goto out_error;
>> +	bl->nr_extents = nr_extents_max;
>> +	args->lg_content = bl;
>> +
>> +	nfserr = nfsd4_block_map_segment(inode, fhp, seg,
>> +			args->lg_minlength, bl);
>> +	if (nfserr != nfs_ok)
>> +		goto out_error;
>> +	first_bex = bl->extents;
>> +	last_bex = bl->extents + bl->nr_extents - 1;
>> +
>> +	nfserr = nfserr_layoutunavailable;
>> +	seg_length = last_bex->foff + last_bex->len - seg->offset;
>> +	if (seg_length < args->lg_minlength) {
>> +		dprintk("pnfsd: extent smaller than minlength\n");
>> +		goto out_error;
>> +	}
>> +
>> +	seg->offset = first_bex->foff;
>> +	seg->length = last_bex->foff - first_bex->foff + last_bex->len;
>> +	return nfs_ok;
>>   
>>   out_error:
>>   	seg->length = 0;
>> -	return nfserrno(error);
>> -out_layoutunavailable:
>> -	seg->length = 0;
>> -	return nfserr_layoutunavailable;
>> +	return nfserr;
>>   }
>>   
>>   static __be32
>> diff --git a/fs/nfsd/blocklayoutxdr.c b/fs/nfsd/blocklayoutxdr.c
>> index e50afe340737..68c112d47cee 100644
>> --- a/fs/nfsd/blocklayoutxdr.c
>> +++ b/fs/nfsd/blocklayoutxdr.c
>> @@ -14,12 +14,25 @@
>>   #define NFSDDBG_FACILITY	NFSDDBG_PNFS
>>   
>>   
>> +/**
>> + * nfsd4_block_encode_layoutget - encode block/scsi layout extent array
>> + * @xdr: stream for data encoding
>> + * @lgp: layoutget content, actually an array of extents to encode
>> + *
>> + * This function encodes the opaque loc_body field in the layoutget response.
>> + * Since the pnfs_block_layout4 and pnfs_scsi_layout4 structures on the wire
>> + * are the same, this function is used by both layout drivers.
>> + *
>> + * Return values:
>> + *   %nfs_ok: Success, all extents encoded into @xdr
>> + *   %nfserr_toosmall: Not enough space in @xdr to encode all the data
>> + */
>>   __be32
>>   nfsd4_block_encode_layoutget(struct xdr_stream *xdr,
>>   		const struct nfsd4_layoutget *lgp)
>>   {
>> -	const struct pnfs_block_extent *b = lgp->lg_content;
>> -	int len = sizeof(__be32) + 5 * sizeof(__be64) + sizeof(__be32);
>> +	const struct pnfs_block_layout *bl = lgp->lg_content;
>> +	u32 i, len = sizeof(__be32) + bl->nr_extents * PNFS_BLOCK_EXTENT_SIZE;
>>   	__be32 *p;
>>   
>>   	p = xdr_reserve_space(xdr, sizeof(__be32) + len);
>> @@ -27,14 +40,19 @@ nfsd4_block_encode_layoutget(struct xdr_stream *xdr,
>>   		return nfserr_toosmall;
>>   
>>   	*p++ = cpu_to_be32(len);
>> -	*p++ = cpu_to_be32(1);		/* we always return a single extent */
>> +	*p++ = cpu_to_be32(bl->nr_extents);
>>   
>> -	p = svcxdr_encode_deviceid4(p, &b->vol_id);
>> -	p = xdr_encode_hyper(p, b->foff);
>> -	p = xdr_encode_hyper(p, b->len);
>> -	p = xdr_encode_hyper(p, b->soff);
>> -	*p++ = cpu_to_be32(b->es);
>> -	return 0;
>> +	for (i = 0; i < bl->nr_extents; i++) {
>> +		const struct pnfs_block_extent *bex = bl->extents + i;
>> +
>> +		p = svcxdr_encode_deviceid4(p, &bex->vol_id);
>> +		p = xdr_encode_hyper(p, bex->foff);
>> +		p = xdr_encode_hyper(p, bex->len);
>> +		p = xdr_encode_hyper(p, bex->soff);
>> +		*p++ = cpu_to_be32(bex->es);
>> +	}
>> +
>> +	return nfs_ok;
>>   }
>>   
>>   static int
>> diff --git a/fs/nfsd/blocklayoutxdr.h b/fs/nfsd/blocklayoutxdr.h
>> index 7d25ef689671..54fe7f517a94 100644
>> --- a/fs/nfsd/blocklayoutxdr.h
>> +++ b/fs/nfsd/blocklayoutxdr.h
>> @@ -21,6 +21,11 @@ struct pnfs_block_range {
>>   	u64				len;
>>   };
>>   
>> +struct pnfs_block_layout {
>> +	u32				nr_extents;
>> +	struct pnfs_block_extent	extents[] __counted_by(nr_extents);
>> +};
>> +
>>   /*
>>    * Random upper cap for the uuid length to avoid unbounded allocation.
>>    * Not actually limited by the protocol.
> Dai, Christoph - please review and/or test.

LGTM.

Tested with SCSI layout and verified with multi-extent IO Read and Write.

-Dai

>
>

