Return-Path: <linux-nfs+bounces-12547-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9749EADDD41
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Jun 2025 22:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD121189FA31
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Jun 2025 20:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAEC238D54;
	Tue, 17 Jun 2025 20:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BIN2C6wT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WWLBDtqv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0F92EFD89;
	Tue, 17 Jun 2025 20:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750192524; cv=fail; b=Q9JixXQoegftuRAtZdRqDOU0un7x31yz+oA+J/gKL8Mhf0on829Z/pTNaiS7ulpaqz0NCt4e+h1OkCQ1Hdo9Okd2ui0aaHvhioX6e9+2ryrtRWly24pHtxMPzLoAub1s6JSDWeNcoxxXqhlX6Cp9VR5aIAmYAITxArMnGEMCwFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750192524; c=relaxed/simple;
	bh=0v7BQWkr1nnN9DbKZxxIAuwPsdZRcmaAoMWExFYDvvY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X3m0JMRrcPOLnAOzAKQdNzMUWcK/uUJCjOwI9uHwjfKSG9lyAadh0pl4QsclVh8uQV0BHb+2nc5FKlatQvBITcK4HaKgMkt2PgG5WmM3WFoSwCGfNejXxdECJ0VvmtmwktERlBT/1MeZ4e7lRuUDBZtjf1KpmSNb9/ABtt5D8wY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BIN2C6wT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WWLBDtqv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HHtYea014849;
	Tue, 17 Jun 2025 20:35:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=lB9NI/6sNS0gr66DZoKWVee2ym6eXNzqV10N71WR4uM=; b=
	BIN2C6wTiv/+XpC2nVuuPKk8KHFpIvHbsNjdCgysTHyjYmj/ZqQDoEmo7kehFQOM
	y2TKP285yYFWGdDinCKR+lUzAxBZ4S1Vw94yIYcHGb+SkJIIVWiBPOrWH7zxP92d
	+4kNOkCfRW86fedhE++LgQwSoHtrARna6/I24oxIE+weznQr02/nAA1BTBsxRRVd
	vh0E5Picg7DgDLyl0DXSFX/oO1yHpe/UcMrjejKbmdlv0a9oZGmuQ9AQNV375DYb
	ZHTwXMAPwbvp8Kdt9se/7uGrMZgWnahQIFBwbK5g+Z7K2ytnW2k01/PDE4Ti5Hvu
	+kgr4coYWRdApkwdtsNhgw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 479hvn5s18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 20:35:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55HKSBJ0034437;
	Tue, 17 Jun 2025 20:35:09 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010015.outbound.protection.outlook.com [52.101.193.15])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yh9h4ek-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 20:35:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NS+l4U+BNS1QQQW6+kz855azuHCrbDuaJ5CgOHkpKbaHpBgMDKmPEk5s5j321y2dabRPJB2w5Uy4L1KwapoxpOFscw1+kQyXfvRXMf16RR74Pc8mqqCHBZOa7/WOy0cMkpGbZJx8niracjyeNO+PhH0yhv6PbWnbTqloUWcSLEZAYHEpgWhx6qt4pk8n9R3RdiS1eWSw6KrGv6sOhOPlPwZqNdemJ89P/B6MBkFIwGElRQY/wFKPHq65v1qTDvX1Ei1XnDvtUvIj7lKK7zRb55rZ1OCbGw0YGNvDLwV8QD8yNfoiyCRGK9gp2WlW2b/fxZai432T8qVojV93ptf5Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lB9NI/6sNS0gr66DZoKWVee2ym6eXNzqV10N71WR4uM=;
 b=pnDIytPxAnEi9ANSCLjYecKJXFd2iiElr3c43jVWxnKYJIpNqEG4RvkqFp0NSxI9SSGZvnaCyPpOUAPwsWRCyfB+drsjF8BstFUGWR2trLUB74wk8ZIRZ2Gy4+3C+uR8lI04wqB1f29Pvu2KknJ92xGQgFD4iOC5RrHVLXP1nWtOKGOi7k6NSchGpoNuBJgn9NgBTERZwTlkRicAjX2bPn/euXRFzsRjV3lClM9viBJKj6bCYM1OWnRmULAOLbAKlfBOmoAHxOFW0DXxb7jsEkNtq5AomDsKuZt7uyl3wIUubM4piHtPXz4Bo1yXT7EAEgltQIlCIF75wT9vJ5u5qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lB9NI/6sNS0gr66DZoKWVee2ym6eXNzqV10N71WR4uM=;
 b=WWLBDtqv/XnyS+OTGMuHD/aJgPCHNx8xuzYncI45x8fmnvvFTBU+nYQVydfBu3rUZO7XcMVk2rzXECWRKjawDBnzJJEAcDwV5PM+1Hbpls7Hev/ngEdWeb2iC7SYuyadNrYGoRgjOSidj9WgC5+K7yxeByig2ROyFJmwa2/ZqRQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7311.namprd10.prod.outlook.com (2603:10b6:208:3fa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Tue, 17 Jun
 2025 20:35:05 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 20:35:05 +0000
Message-ID: <d29f03f4-c06c-42ef-952d-6a7da196d03b@oracle.com>
Date: Tue, 17 Jun 2025 16:35:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nfsd: Implement large extent array support in pNFS
To: Sergey Bashirov <sergeybashirov@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konstantin Evtushenko <koevtushenko@yandex.com>
References: <20250614155950.116302-1-sergeybashirov@gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250614155950.116302-1-sergeybashirov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0315.namprd03.prod.outlook.com
 (2603:10b6:610:118::15) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB7311:EE_
X-MS-Office365-Filtering-Correlation-Id: 96236d66-16cf-4198-2258-08ddadde7179
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?WVNCNVVxUWZ0VU5zMU9HanJucHJlejU5a2lVTzErQVpRcFp1T1pFZFNJcEt0?=
 =?utf-8?B?SnpVY3BLYkExc2g0VXhTckcxK1c4T3NJNnc0bGg5TmlXdDV3Wk9samFieW9Z?=
 =?utf-8?B?aVpaSWpEWXFRZlIwdGlJbnhPZGxsY2dseGxuMVlUM3gvZjdzSG1JczlNZ0J2?=
 =?utf-8?B?SGNTemQ3Wmx4SEVhUkIycklRMXFMZy9jbitiQjlFcVN4ZHZhSVJINEFLZm8z?=
 =?utf-8?B?My81Wm05akxGYjdxMllaemJ1Z1NON1F4RzNwNE9kTXpkSy9KdUJiUHhqUy96?=
 =?utf-8?B?YXp4VnBTRWdqK09DSk9hNUF6aGlEZVVJU0pBVm4rK0x0bVRJU1l4bm8xbFVT?=
 =?utf-8?B?cFdJeFRtdGJQZUFob0NGc3pUbVVkMC8wcDBMSjNIcnVWa1E1VHNFWHNCdWcy?=
 =?utf-8?B?am9jekUxcllmV3NhdzcrNWY1SUkvaEFGbU02STNYckxLYXhFR0RXRDh2Z2gw?=
 =?utf-8?B?V25FZFhsOWU5eE9leEx6bm5mL1lUWlllWWh1OTEzUE0vcnZNUXUzeGw4SmZa?=
 =?utf-8?B?ZVphWlNvSHZNbHA5NTJ0OUNDT0Fib3JFVFVHSkpHZTZsMHNlMEhxL1kwOXNn?=
 =?utf-8?B?Q0Ixbkp4UmN1MjhTcTJjV1FvcXhrRXRycGswcWRTTmwrbWtZQ25LLzExYk90?=
 =?utf-8?B?L29VeGh6Yk5hVnNvSktWV3U2Nnh2OXNaT2RwRzJyUWtFT0h5TVhQNERoa2JO?=
 =?utf-8?B?QWVwWEpDZVl5UFRWNTB3ZHg2aWp2VFBZdXQ5U2duR0xiSXNoUHp3eXpOR0tF?=
 =?utf-8?B?ZVAxRU5ZVEQycytudWVCeGNHRUtxTjZuZ3ExbVpmV3FJaWt5Z3dXMXIvN0Jw?=
 =?utf-8?B?bWhMMDU5TVJvMGtSZ1UzWDc2Z2dQUzJaTFhnbCsrYkZqOFFodnZoWUVzZHdh?=
 =?utf-8?B?V0Rad3Q1NHg3YzVUUnpYRm85c0VESS9DYkFzQlVhQjRxNmI3SFVLeEp6YkRv?=
 =?utf-8?B?V0VlaTFteTRDU0dqT3ZyWXVJSFVXa0xnbGNIY1RaQWxhcGFsZHV1Qmt4bW1l?=
 =?utf-8?B?YzVZWXdDSWU1M3lvTTJjSmcvdHlpS212UGNxdldMNlMzOVB5N1dkc2dmckJL?=
 =?utf-8?B?U2RtU0IvbXNNb1dSMGJmMzVTVmZDdmd4SnRCT0pjRjlod21ydXNTTWpnS2FR?=
 =?utf-8?B?WTYrdHhOT0JDNDdZNzB0cTl0Zm9OSmkza09HSnRLZk1adXZtVGlVckVmZkxI?=
 =?utf-8?B?RDk3K2syL3prTUlFcDJGWk9BQWZVdHhQQldrUytrZEE3WXIwQ2wrMUJjUnpi?=
 =?utf-8?B?TklJQ0JFNnkrYzhkckM5VmRvcitMbkJIMXZkbmY4WFZqb0hKdzB1TFgrWVRi?=
 =?utf-8?B?TTQ5dFJXemZjSXY4WXN1TlBFaHM3eW1RMUdWYUJhS2F1dGh5QU0rRDRDL1d4?=
 =?utf-8?B?WkJ0a1F3WGVIcGJOZmJyZ0FWZS9LbWxGTHVma0VpNjNxRGcyMVFnUkFKQnZQ?=
 =?utf-8?B?VzBFT1Fab0EyMzJscVRwSzNVL1gxSjgvQjNuRmhCK2VqY2p1TDJubldyaXV5?=
 =?utf-8?B?clFvZDB6S01wNWI3NkUyY1VvRndnSXdXaXlOeUtwcjZVSTV2Y0kyT0hVQUJl?=
 =?utf-8?B?TVdUc2lqQTFLMHIrNG5jS3MxK2Q1UlJDcUQ5MGVhM2FYbnRKYjZoUlZUS1pl?=
 =?utf-8?B?WWE5bEpkc3RnVHhqKzlvQURCTnRzOUM4b01qVHZFTTZLR1JUekhzWisvaVFy?=
 =?utf-8?B?Wi8yTXlNRm5uSVJZWmNBZ3pHclBsb0J3OExCOGNBNHNwK0FHS3ZaNk5oYWhj?=
 =?utf-8?B?T3I1bkxSUk1JVG40dk9pdmF2RGEyLzNFV0VKLzV5K1k0YWw3WFRDSHA0OUZ4?=
 =?utf-8?B?OHMzbm5iQlBIdnN1bElrb0ZqczRMV1FFQml4T2Y3eU5ydkxLYmdiVXlRRkQ1?=
 =?utf-8?B?c2hvajJaYXpoQWV6dVRTRy9HeG1Rbzh5S0czMGhCbkFwZXNnQmxEc1RFZGZw?=
 =?utf-8?Q?GSibsXggAUE=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bFdEZ3F0YlkvQjRFWEUzUnhORnE1T3RDc1YzOEdTZkMyUVNkeXk3bzFwbFQx?=
 =?utf-8?B?Znd1VHBYTUE4S1NoaHpwWVdhbDBOQ0ttMXFQV2p0S3N0Z3hQMDgxVDJXVGRh?=
 =?utf-8?B?cWpWZEc1QUh0aHVwN3ozeUNJekhlWkhoZ3AzN3E4cXJBV3lzdndqMk1yUTk3?=
 =?utf-8?B?VGFoWHR2NmxYNTVqbFV1YUF4aVROUFlJT0VlSGZIVklyV3NFbFBLSWtXeEdo?=
 =?utf-8?B?L2JCeXcxa3ZTZVNZZTY3Q012aEdSdTN4andxVjd0NHF3eXFaWGo4eXd3ZnZD?=
 =?utf-8?B?S3Z6S1hNT3ROdE1BSkJ5R3JRT2s2M3JPQjZnV09nQXlaa1laY0tyRlpsdGFz?=
 =?utf-8?B?alQxSHh5UWZFSklsUUJGaHEwa1k5VjI3U1VqM1F6ZE41OFF4Yno1bjZIZ0Ny?=
 =?utf-8?B?YVBnNU1FL3NINGI0a095L01GNHJmbGV0THAvc1d5VHBTRXVjOUpTQkN3MGpa?=
 =?utf-8?B?MmJzUzh0TmlMREFiZUk0V3crR3pxMlFrODlzd3JLWTdVb0VxQVJkRnJlKy9C?=
 =?utf-8?B?UzBKTXlsOVJaditzL3JicThjRmEzU0l0eU05aUZTR3FMbkhpTmVydWtOckVN?=
 =?utf-8?B?Q1ZHM1hPUmJVSVpVQ2JReklibWIvNXpRUDFoY2FvN0lrNDFsTE0zMFJDc2ZU?=
 =?utf-8?B?aDBqaDZjTmI0ZFJ3RHZtdG5RbCt0eDl5MUVhdVhOSzdOUm1HdWU0MlhUdVlH?=
 =?utf-8?B?eXZjbjRGYzd1aWRsR2ZySVNwNFhuYTg5a1BVb3JjWVJjVzJMNEVJZHZyb2lL?=
 =?utf-8?B?RWtDdmJpZEhJbTA3Kzk3RDZpL0Z4bWg3NXpUK0NsUVBQblBKZGZPdmNUK3d3?=
 =?utf-8?B?WS9oYkpnMGZKeW9SNjE2YkN5MURIdDM3ZXFLem9NUUJIdGNsU2hVQS9OSC8v?=
 =?utf-8?B?ODZqcHI1UEpqV3owTkVRMGs4bUVuaVBpdy9hRkJ3dDBhbEI5Mk9yWEh2NVFo?=
 =?utf-8?B?SnVLNkw5b0kwOXRGcm1RVm1NWUI4N0tXTDIyRzJmRXMzVU1May9POFlNMFlT?=
 =?utf-8?B?SjFKYlI4aFhyQ1FxcE1Dc1hIdk1FZkVOd1hRNVNRNFh5YmxEa3M1SVJKYTF5?=
 =?utf-8?B?UjNLdWc4TFhZZFI0ZklaaGloRVhUS1lsQmhhSHJZaEV4dGloUVRGQWRZdUM0?=
 =?utf-8?B?VEtzc1ZZQlF0NXRuUVY3eXowVndIYjhWSVkycjJnS2lmKy9GdEdOaE1OYm0x?=
 =?utf-8?B?S2FMZUdxK3AxUWlLVlFSSUprYWREV3NxUHBvR3ZBVkYxVWtPbGtFWTFuVm9x?=
 =?utf-8?B?QTZVYnowYzNIWVlBTUE3SG90bDc0VDhOd05udUNCL1RURmo2SlBaNFBWQjBD?=
 =?utf-8?B?bkJYQlE3RDNOeWNWc0VKOHdFYmNNQzNqc2FKcnp1U0JQUS8raVJDR1RUVDFu?=
 =?utf-8?B?ZlNRNGszUE5kd2FwU216alFJQkdESitLQXpJNjZkT0w0REhZUXEvVktFMlRw?=
 =?utf-8?B?N1Z2amJWMi9ZV2NWVDNyRXVaK3hoVmhnVGtwb2hSRE5JVGpucHNSdTFXWURJ?=
 =?utf-8?B?RGVPcmFNRVlYU1RBanl6cFphTTJ2a2JVN1FLY3RqOE1DVXlPeVM5bW92S2l0?=
 =?utf-8?B?MnFEUnh4RmVNNGFBL2tscHNud2VJZXhmSmcxRjRyQ0dyc1dMUE9HbFVsRVJU?=
 =?utf-8?B?cFZFbVUzSm94M3dtTmZKSS9tMHlmWStZajJmckM0aWxtWmxjS094T0JhRzVU?=
 =?utf-8?B?OTBONVZMMVlSMldmZWVRWUlvMFM2OUZnaUpFVDIyMzhjWGJSYnJkd3dBdnQ1?=
 =?utf-8?B?OHFoUGZmenZwVmhubWNPVFMxaDQzQW5tSjRtMDFCMmpXS1dBUGUyLy82QWhL?=
 =?utf-8?B?MGZzaVdNM3FHVUJRYkM1YXNNUStvWXhSTXpDb0RjZFRXMllacFZjTGt4ZEVw?=
 =?utf-8?B?Nnk2c2REdGJFbXIrbDRIS0JpZDNIWHROZHFLbWpuNGc1VDAvbkc4MFJGLzJ6?=
 =?utf-8?B?cWtkb1JTTFk1cTNFZ3RhVDJWSm5pNWFVdGVlODBlZmJ4RUtDNWxTdjFPZWE0?=
 =?utf-8?B?Qnd2VkM3cUxIbWNFWnpheHdBcnRXZkZBcVRHRERRM1ljK0ZkMEgxZ3l6TTZx?=
 =?utf-8?B?T0I0amxDVFNqZHRwV09JSE5ZSUVDMVJlN01oQjZWWUZvakpKYmxlay92MkVo?=
 =?utf-8?B?eVk0SHplTkE5MUV5bkdRZDNSeUwvaittRHFPdnNVV3BZdEVvMURiUmV1cjdC?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fQeyffDHr7ftFLyBj5tRw/QNp8jIGpAaeX1t+LOQZwf0655toKJvnBlVLreEMDf1qZyu0uSqAOU/g2932opxiG9mJ4Na1zzjM/iHxxQPhCILcGI/ptSK3yJCLftdwOe9oD8KpqLQvuv7xsNII0P6j+fjMytAXB34U6VS2r42vQ8/9Vn5Q5q3+9fR418kAEWLwF7ldgRwTdzv5eWO7NRQZww3iS+rqE/4h5PNMFrUa9IGd+EP17xPYggOKkK4K3bE5T0fg9IBfwkAYuqh0+ulbCe/SD11d/MKDdTxoF2XicTdAShe7IStVz/GfEpc+8r3DY/vZS3AHG0Qc6zunJ9c5Yf27zlVc+J7tcUtwDnqN+nj4fEURC/pRz+i0dxkuR9STKgHFWEecjraAwOkoQh7FLEfQOtuqbAD19KgJn1GL2r4Qf3XMARJVTLsNAObBPMzY+cI5ZpNoC4qApXXKV1EsnKnoyRgJ2YfQkUFn87ezRm78RXDCKRISPxKsdKZ2ZcuA58EOF/0BDaYkMmnIQhXs9bhkg32opPUNm8+gAMGNktU4uDg9319dOGW2y2ptn6/xZdwJ0LtQ9PWvbbZ5Y+wJeVZyCM9akMXDSPohrCEDyo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96236d66-16cf-4198-2258-08ddadde7179
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 20:35:05.6531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SOza3JwzC6bOUs/pUC3+IdTgEvS4us0GAWyvIIVe6uY+oD/WeEIAi/64kZgsbYElsDVsirQUb6MeqdqnhIrjHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7311
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_09,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506170164
X-Authority-Analysis: v=2.4 cv=XeSJzJ55 c=1 sm=1 tr=0 ts=6851d17e cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=BMxJXzqDAAAA:8 a=pGLkceISAAAA:8 a=6mSsaw3qlAX22I-ypvYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: nmoTnPhWl_6OtPozauTkjySrgKWGhHRf
X-Proofpoint-GUID: nmoTnPhWl_6OtPozauTkjySrgKWGhHRf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDE2NCBTYWx0ZWRfXxg8D0Hv+9+BV d0pEF8PyTAVV9eyCTY+51WKpc+4BeYPoy2UgW+fVj0Au7wODXiAWKCa2o6C1ta7BQ+IBQwAyP6u Sifoin6LKyF++Ic5cu4l0Q3kTiTq06d+WYbQYpMCxy8R3Ezdem8RsL/hTmqQfg2cmM/XFKOzccK
 hhqDybnOvnTBm1OTOYUyboVbeqe08ShCZS3WdeMJjkp+rZGuCA3Wp8RG5goY9288P95cYXnwlQz B4OSl1I3bQ3QiV7j7l0bFT8cBeWfIsQOsQG74VJaHvjhjYejoEmQJpIsFxaX6dPThbsyVfIiLSE Tl5pIYD6zsK0wZeKiRC0Dz2z62JI7mMKlrfW39u4KdOA2zWw7Op3drItlYB1sT/DI2gn3Vy3Fd/
 Lb+AuNu71UOeAcSwT9NXZdjNPwwo+tQ3bZ25Uk3alaH4fhQj0i2fV61gh9HNv2Ui5yhkchZK

On 6/14/25 11:59 AM, Sergey Bashirov wrote:
> When pNFS client in the block or scsi layout mode sends layoutcommit
> to MDS, a variable length array of modified extents is supplied within
> the request. This patch allows the server to accept such extent arrays
> if they do not fit within single memory page.
> 
> The issue can be reproduced when writing to a 1GB file using FIO with
> O_DIRECT, 4K block and large I/O depth without preallocation of the
> file. In this case, the server returns NFSERR_BADXDR to the client.
> 
> Co-developed-by: Konstantin Evtushenko <koevtushenko@yandex.com>
> Signed-off-by: Konstantin Evtushenko <koevtushenko@yandex.com>
> Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
> ---
> Changes in v3:
>  - Prerequisite: [v3] nfsd: Use correct error code when decoding extents
>  - Drop dprintk()
>  - Use svcxdr_init_decode() to init subbuf
>  - Tested manually the block layout driver using FIO
> 
>  fs/nfsd/blocklayout.c    |  20 ++++---
>  fs/nfsd/blocklayoutxdr.c | 118 ++++++++++++++++++++-------------------
>  fs/nfsd/blocklayoutxdr.h |   4 +-
>  fs/nfsd/nfs4proc.c       |   2 +-
>  fs/nfsd/nfs4xdr.c        |  11 ++--
>  fs/nfsd/pnfs.h           |   1 +
>  fs/nfsd/xdr4.h           |   3 +-
>  7 files changed, 83 insertions(+), 76 deletions(-)
> 
> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
> index 19078a043e85..54fbe157f84a 100644
> --- a/fs/nfsd/blocklayout.c
> +++ b/fs/nfsd/blocklayout.c
> @@ -173,16 +173,18 @@ nfsd4_block_proc_getdeviceinfo(struct super_block *sb,
>  }
>  
>  static __be32
> -nfsd4_block_proc_layoutcommit(struct inode *inode,
> +nfsd4_block_proc_layoutcommit(struct inode *inode, struct svc_rqst *rqstp,
>  		struct nfsd4_layoutcommit *lcp)
>  {
>  	struct iomap *iomaps;
>  	int nr_iomaps;
>  	__be32 nfserr;
>  
> -	nfserr = nfsd4_block_decode_layoutupdate(lcp->lc_up_layout,
> -			lcp->lc_up_len, &iomaps, &nr_iomaps,
> -			i_blocksize(inode));
> +	memcpy(&rqstp->rq_arg, &lcp->lc_up_layout, sizeof(struct xdr_buf));
> +	svcxdr_init_decode(rqstp);
> +
> +	nfserr = nfsd4_block_decode_layoutupdate(&rqstp->rq_arg_stream,
> +			&iomaps, &nr_iomaps, i_blocksize(inode));
>  	if (nfserr != nfs_ok)
>  		return nfserr;
>  
> @@ -313,16 +315,18 @@ nfsd4_scsi_proc_getdeviceinfo(struct super_block *sb,
>  	return nfserrno(nfsd4_block_get_device_info_scsi(sb, clp, gdp));
>  }
>  static __be32
> -nfsd4_scsi_proc_layoutcommit(struct inode *inode,
> +nfsd4_scsi_proc_layoutcommit(struct inode *inode, struct svc_rqst *rqstp,
>  		struct nfsd4_layoutcommit *lcp)
>  {
>  	struct iomap *iomaps;
>  	int nr_iomaps;
>  	__be32 nfserr;
>  
> -	nfserr = nfsd4_scsi_decode_layoutupdate(lcp->lc_up_layout,
> -			lcp->lc_up_len, &iomaps, &nr_iomaps,
> -			i_blocksize(inode));
> +	memcpy(&rqstp->rq_arg, &lcp->lc_up_layout, sizeof(struct xdr_buf));
> +	svcxdr_init_decode(rqstp);
> +
> +	nfserr = nfsd4_scsi_decode_layoutupdate(&rqstp->rq_arg_stream,
> +			&iomaps, &nr_iomaps, i_blocksize(inode));
>  	if (nfserr != nfs_ok)
>  		return nfserr;
>  
> diff --git a/fs/nfsd/blocklayoutxdr.c b/fs/nfsd/blocklayoutxdr.c
> index 669ff8e6e966..266b2737882e 100644
> --- a/fs/nfsd/blocklayoutxdr.c
> +++ b/fs/nfsd/blocklayoutxdr.c
> @@ -114,8 +114,7 @@ nfsd4_block_encode_getdeviceinfo(struct xdr_stream *xdr,
>  
>  /**
>   * nfsd4_block_decode_layoutupdate - decode the block layout extent array
> - * @p: pointer to the xdr data
> - * @len: number of bytes to decode
> + * @xdr: subbuf set to the encoded array
>   * @iomapp: pointer to store the decoded extent array
>   * @nr_iomapsp: pointer to store the number of extents
>   * @block_size: alignment of extent offset and length
> @@ -128,68 +127,74 @@ nfsd4_block_encode_getdeviceinfo(struct xdr_stream *xdr,
>   *
>   * Return values:
>   *   %nfs_ok: Successful decoding, @iomapp and @nr_iomapsp are valid
> - *   %nfserr_bad_xdr: The encoded array in @p is invalid
> + *   %nfserr_bad_xdr: The encoded array in @xdr is invalid
>   *   %nfserr_inval: An unaligned extent found
>   *   %nfserr_delay: Failed to allocate memory for @iomapp
>   */
>  __be32
> -nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
> +nfsd4_block_decode_layoutupdate(struct xdr_stream *xdr, struct iomap **iomapp,
>  		int *nr_iomapsp, u32 block_size)
>  {
>  	struct iomap *iomaps;
> -	u32 nr_iomaps, i;
> +	u32 nr_iomaps, expected, len, i;
> +	__be32 nfserr;
>  
> -	if (len < sizeof(u32)) {
> -		dprintk("%s: extent array too small: %u\n", __func__, len);
> +	if (xdr_stream_decode_u32(xdr, &nr_iomaps))
>  		return nfserr_bad_xdr;
> -	}
> -	len -= sizeof(u32);
> -	if (len % PNFS_BLOCK_EXTENT_SIZE) {
> -		dprintk("%s: extent array invalid: %u\n", __func__, len);
> -		return nfserr_bad_xdr;
> -	}
>  
> -	nr_iomaps = be32_to_cpup(p++);
> -	if (nr_iomaps != len / PNFS_BLOCK_EXTENT_SIZE) {
> -		dprintk("%s: extent array size mismatch: %u/%u\n",
> -			__func__, len, nr_iomaps);
> +	len = sizeof(__be32) + xdr_stream_remaining(xdr);
> +	expected = sizeof(__be32) + nr_iomaps * PNFS_BLOCK_EXTENT_SIZE;
> +	if (len != expected)
>  		return nfserr_bad_xdr;
> -	}
>  
>  	iomaps = kcalloc(nr_iomaps, sizeof(*iomaps), GFP_KERNEL);
> -	if (!iomaps) {
> -		dprintk("%s: failed to allocate extent array\n", __func__);
> +	if (!iomaps)
>  		return nfserr_delay;
> -	}
>  
>  	for (i = 0; i < nr_iomaps; i++) {
>  		struct pnfs_block_extent bex;
> +		ssize_t ret;
>  
> -		memcpy(&bex.vol_id, p, sizeof(struct nfsd4_deviceid));
> -		p += XDR_QUADLEN(sizeof(struct nfsd4_deviceid));
> +		ret = xdr_stream_decode_opaque_fixed(xdr,
> +				&bex.vol_id, sizeof(bex.vol_id));
> +		if (ret < sizeof(bex.vol_id)) {
> +			nfserr = nfserr_bad_xdr;
> +			goto fail;
> +		}
>  
> -		p = xdr_decode_hyper(p, &bex.foff);
> +		if (xdr_stream_decode_u64(xdr, &bex.foff)) {
> +			nfserr = nfserr_bad_xdr;
> +			goto fail;
> +		}
>  		if (bex.foff & (block_size - 1)) {
> -			dprintk("%s: unaligned offset 0x%llx\n",
> -				__func__, bex.foff);
> +			nfserr = nfserr_inval;
> +			goto fail;
> +		}
> +
> +		if (xdr_stream_decode_u64(xdr, &bex.len)) {
> +			nfserr = nfserr_bad_xdr;
>  			goto fail;
>  		}
> -		p = xdr_decode_hyper(p, &bex.len);
>  		if (bex.len & (block_size - 1)) {
> -			dprintk("%s: unaligned length 0x%llx\n",
> -				__func__, bex.foff);
> +			nfserr = nfserr_inval;
> +			goto fail;
> +		}
> +
> +		if (xdr_stream_decode_u64(xdr, &bex.soff)) {
> +			nfserr = nfserr_bad_xdr;
>  			goto fail;
>  		}
> -		p = xdr_decode_hyper(p, &bex.soff);
>  		if (bex.soff & (block_size - 1)) {
> -			dprintk("%s: unaligned disk offset 0x%llx\n",
> -				__func__, bex.soff);
> +			nfserr = nfserr_inval;
> +			goto fail;
> +		}
> +
> +		if (xdr_stream_decode_u32(xdr, &bex.es)) {
> +			nfserr = nfserr_bad_xdr;
>  			goto fail;
>  		}
> -		bex.es = be32_to_cpup(p++);
>  		if (bex.es != PNFS_BLOCK_READWRITE_DATA) {
> -			dprintk("%s: incorrect extent state %d\n",
> -				__func__, bex.es);
> +			nfserr = nfserr_inval;
>  			goto fail;
>  		}
>  
> @@ -202,13 +207,12 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
>  	return nfs_ok;
>  fail:
>  	kfree(iomaps);
> -	return nfserr_inval;
> +	return nfserr;
>  }
>  
>  /**
>   * nfsd4_scsi_decode_layoutupdate - decode the scsi layout extent array
> - * @p: pointer to the xdr data
> - * @len: number of bytes to decode
> + * @xdr: subbuf set to the encoded array
>   * @iomapp: pointer to store the decoded extent array
>   * @nr_iomapsp: pointer to store the number of extents
>   * @block_size: alignment of extent offset and length
> @@ -220,49 +224,49 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
>   *
>   * Return values:
>   *   %nfs_ok: Successful decoding, @iomapp and @nr_iomapsp are valid
> - *   %nfserr_bad_xdr: The encoded array in @p is invalid
> + *   %nfserr_bad_xdr: The encoded array in @xdr is invalid
>   *   %nfserr_inval: An unaligned extent found
>   *   %nfserr_delay: Failed to allocate memory for @iomapp
>   */
>  __be32
> -nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
> +nfsd4_scsi_decode_layoutupdate(struct xdr_stream *xdr, struct iomap **iomapp,
>  		int *nr_iomapsp, u32 block_size)
>  {
>  	struct iomap *iomaps;
> -	u32 nr_iomaps, expected, i;
> +	u32 nr_iomaps, expected, len, i;
> +	__be32 nfserr;
>  
> -	if (len < sizeof(u32)) {
> -		dprintk("%s: extent array too small: %u\n", __func__, len);
> +	if (xdr_stream_decode_u32(xdr, &nr_iomaps))
>  		return nfserr_bad_xdr;
> -	}
>  
> -	nr_iomaps = be32_to_cpup(p++);
> +	len = sizeof(__be32) + xdr_stream_remaining(xdr);
>  	expected = sizeof(__be32) + nr_iomaps * PNFS_SCSI_RANGE_SIZE;
> -	if (len != expected) {
> -		dprintk("%s: extent array size mismatch: %u/%u\n",
> -			__func__, len, expected);
> +	if (len != expected)
>  		return nfserr_bad_xdr;
> -	}
>  
>  	iomaps = kcalloc(nr_iomaps, sizeof(*iomaps), GFP_KERNEL);
> -	if (!iomaps) {
> -		dprintk("%s: failed to allocate extent array\n", __func__);
> +	if (!iomaps)
>  		return nfserr_delay;
> -	}
>  
>  	for (i = 0; i < nr_iomaps; i++) {
>  		u64 val;
>  
> -		p = xdr_decode_hyper(p, &val);
> +		if (xdr_stream_decode_u64(xdr, &val)) {
> +			nfserr = nfserr_bad_xdr;
> +			goto fail;
> +		}
>  		if (val & (block_size - 1)) {
> -			dprintk("%s: unaligned offset 0x%llx\n", __func__, val);
> +			nfserr = nfserr_inval;
>  			goto fail;
>  		}
>  		iomaps[i].offset = val;
>  
> -		p = xdr_decode_hyper(p, &val);
> +		if (xdr_stream_decode_u64(xdr, &val)) {
> +			nfserr = nfserr_bad_xdr;
> +			goto fail;
> +		}
>  		if (val & (block_size - 1)) {
> -			dprintk("%s: unaligned length 0x%llx\n", __func__, val);
> +			nfserr = nfserr_inval;
>  			goto fail;
>  		}
>  		iomaps[i].length = val;
> @@ -273,5 +277,5 @@ nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
>  	return nfs_ok;
>  fail:
>  	kfree(iomaps);
> -	return nfserr_inval;
> +	return nfserr;
>  }
> diff --git a/fs/nfsd/blocklayoutxdr.h b/fs/nfsd/blocklayoutxdr.h
> index 15b3569f3d9a..7d25ef689671 100644
> --- a/fs/nfsd/blocklayoutxdr.h
> +++ b/fs/nfsd/blocklayoutxdr.h
> @@ -54,9 +54,9 @@ __be32 nfsd4_block_encode_getdeviceinfo(struct xdr_stream *xdr,
>  		const struct nfsd4_getdeviceinfo *gdp);
>  __be32 nfsd4_block_encode_layoutget(struct xdr_stream *xdr,
>  		const struct nfsd4_layoutget *lgp);
> -__be32 nfsd4_block_decode_layoutupdate(__be32 *p, u32 len,
> +__be32 nfsd4_block_decode_layoutupdate(struct xdr_stream *xdr,
>  		struct iomap **iomapp, int *nr_iomapsp, u32 block_size);
> -__be32 nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len,
> +__be32 nfsd4_scsi_decode_layoutupdate(struct xdr_stream *xdr,
>  		struct iomap **iomapp, int *nr_iomapsp, u32 block_size);
>  
>  #endif /* _NFSD_BLOCKLAYOUTXDR_H */
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index f13abbb13b38..873cd667477c 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2533,7 +2533,7 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
>  		lcp->lc_size_chg = false;
>  	}
>  
> -	nfserr = ops->proc_layoutcommit(inode, lcp);
> +	nfserr = ops->proc_layoutcommit(inode, rqstp, lcp);
>  	nfs4_put_stid(&ls->ls_stid);
>  out:
>  	return nfserr;
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 3afcdbed6e14..659e60b85d5f 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -604,6 +604,8 @@ static __be32
>  nfsd4_decode_layoutupdate4(struct nfsd4_compoundargs *argp,
>  			   struct nfsd4_layoutcommit *lcp)
>  {
> +	u32 len;
> +
>  	if (xdr_stream_decode_u32(argp->xdr, &lcp->lc_layout_type) < 0)
>  		return nfserr_bad_xdr;
>  	if (lcp->lc_layout_type < LAYOUT_NFSV4_1_FILES)
> @@ -611,13 +613,10 @@ nfsd4_decode_layoutupdate4(struct nfsd4_compoundargs *argp,
>  	if (lcp->lc_layout_type >= LAYOUT_TYPE_MAX)
>  		return nfserr_bad_xdr;
>  
> -	if (xdr_stream_decode_u32(argp->xdr, &lcp->lc_up_len) < 0)
> +	if (xdr_stream_decode_u32(argp->xdr, &len) < 0)
> +		return nfserr_bad_xdr;
> +	if (!xdr_stream_subsegment(argp->xdr, &lcp->lc_up_layout, len))
>  		return nfserr_bad_xdr;
> -	if (lcp->lc_up_len > 0) {
> -		lcp->lc_up_layout = xdr_inline_decode(argp->xdr, lcp->lc_up_len);
> -		if (!lcp->lc_up_layout)
> -			return nfserr_bad_xdr;
> -	}
>  
>  	return nfs_ok;
>  }
> diff --git a/fs/nfsd/pnfs.h b/fs/nfsd/pnfs.h
> index 925817f66917..dfd411d1f363 100644
> --- a/fs/nfsd/pnfs.h
> +++ b/fs/nfsd/pnfs.h
> @@ -35,6 +35,7 @@ struct nfsd4_layout_ops {
>  			const struct nfsd4_layoutget *lgp);
>  
>  	__be32 (*proc_layoutcommit)(struct inode *inode,
> +			struct svc_rqst *rqstp,
>  			struct nfsd4_layoutcommit *lcp);
>  
>  	void (*fence_client)(struct nfs4_layout_stateid *ls,
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index aa2a356da784..02887029a81c 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -630,8 +630,7 @@ struct nfsd4_layoutcommit {
>  	u64			lc_last_wr;	/* request */
>  	struct timespec64	lc_mtime;	/* request */
>  	u32			lc_layout_type;	/* request */
> -	u32			lc_up_len;	/* layout length */
> -	void			*lc_up_layout;	/* decoded by callback */
> +	struct xdr_buf		lc_up_layout;	/* decoded by callback */
>  	bool			lc_size_chg;	/* response */
>  	u64			lc_newsize;	/* response */
>  };

Hi Sergey -

Typically we separate the clean-ups from the substantive changes. So
removing the dprintk call sites would be done in a pre-requisite patch.
I'm asking you to do it because if I split this patch up, I'm likely to
get something wrong, and you have a convenient test case.

Also, reposting means your tested version of the series is what gets
archived on lore.

Would you mind splitting this one up and posting a v4 ?


-- 
Chuck Lever

