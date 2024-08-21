Return-Path: <linux-nfs+bounces-5533-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F3D95A374
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 19:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B15E7284BC1
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 17:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5ABB13E022;
	Wed, 21 Aug 2024 17:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zy6Ruyte";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZRg3rsTf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167C416A95A
	for <linux-nfs@vger.kernel.org>; Wed, 21 Aug 2024 17:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724259844; cv=fail; b=JJBk/o/2fpVa7qSe3WiDkgoNqC0uapKBV8VIYs/cA7t229+XrTLf31is4GZze/QXdCYWA8uJx7aU2FFcsGTqbQddZ2BeRpuB8UQPooskUxOJaz03vUjBQLe8BC6UXRAeT7Cm5WFIrHaIFmoaIorOTGaroqSNQ7CknE+EeFdfdPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724259844; c=relaxed/simple;
	bh=3J9g7FfYu/Ju05Y1VdsNaYwx1kdkJ5sL4upJLDGKb1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YKBsp6dbJxbA1yV3IB8tWlVQXn97uyNI9obFsku6EsfyKSHExoUub9DJi/Uhp6Zb5f+JJV1MMwhYnMop/+RZ1VXeQDWnxjP45lMxVNdxyg0BuFOZ0LPNnAhRs3uM/HMpxYZArCs9YgUfSnFxl/asKtVaMDPbQxC/bUceNtkNhyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zy6Ruyte; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZRg3rsTf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47LDIfFt005323;
	Wed, 21 Aug 2024 17:03:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=Q7Ejx3rjaOtflpaLIy6oOqeLnkOj3Kb5kN283U+BIEQ=; b=
	Zy6Ruytew6zi4q0olE7CEU9r6iWYp0zhy/CmZSUo8CQQChaNT1//SH8Y1ZaMKyO2
	fKFCI8/wPeGObMJgqNIc9A+96wyaVU2oue70SJ8DilFg+5WFRJ2KsR2URDolETnO
	JTOLc9wvCCMyrGs0sIMi00B+tBdNaM7cz26+n7Hp9tSt9sBkT3Jw+AepJisb3kkp
	gy96Vwj6wHAnamaOsKKF7z5eqA2pDqxYn4Zfb0lUG9kAzkeIb98nlw8KnNwXpImU
	L4MJLbIlHRMOdAlCBvqqWJ0ST7QcShmRvdtKlBwXU+JIypzfuaWNd37D8ALyXOmD
	go6QrR7hqHfx6uhuBujIBQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m45g3e4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 17:03:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47LGsGl4009617;
	Wed, 21 Aug 2024 17:03:57 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 415m5vge8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 17:03:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UXOdVU3HWQlhO0vwn0kHWMmta1Zq825InLT+vPUALCRAIWZUVzypieQ+AzNukMVuj/01XiM5QSLmI3fWEp1va3L1oSRik2KEIBQ/dPebYj2u0QskeG6reA/uNLmpBGYVEfnoqDvrMW/bqafKHK17m3MAj2Xxr2PHR6runtVqZmmraA7faC8bM0NQlzYEjMisEAsQswB0dHvgy8k5ULvQBkyxX4DfgivzMibphHu9tNyFUxl1TwvQS2EWyeT+ju0mBDIQp/FjV4wGkD8p3JF/Nkz9ldiTeSEe5dgTjfp4r428w43UVZhPxaDVZkRj14J8r+kbDY72ianya48jLELqMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7Ejx3rjaOtflpaLIy6oOqeLnkOj3Kb5kN283U+BIEQ=;
 b=kPZ2qGh+7Gi6izcZ7nvorMG/iS8YwckT7vUZBfK3YqlodDAXaCHXW9MTZ3EMzMPH9R9Wy7aUGBYIcnTOaQZTEj5b+c1WagCFH+W5hX8YixSt/fv/1Kjkh4325Q2vT0Kavj3A9GsflAqb3IRjIBSfkL7/bvWmwVLKSnS38ETdrIBtu1sNxYP6rVAhLvvRWTGqtgf2n+4UeP883yXdLtEI22MhghSEkwDrq6hPCLQpC4ykdTv+phqysY5XIBBwHf2oY98+T0omXWuEp7krIXJ2+PdI3GTX89ARoqxdbKvG3elUL/E3d0d1A1ej9b97gsnwNZrXRU6B+A/f7cBzQfdbTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7Ejx3rjaOtflpaLIy6oOqeLnkOj3Kb5kN283U+BIEQ=;
 b=ZRg3rsTfTKude5D7lPFJTEz/iHFMe0JAinVuH02u9BA8GLWPKZsyqO3C1XhjFm4UlfZ3VhoFfQy+3CF8SR2YjdVt65cuHkmYbNJULWYU1O2b6zkfoiDqVrAfuOC7Bs0oBOpDNqdeR41DNTRbSGL2+BZFp/ue0tgq7dDsJBm4ipY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5744.namprd10.prod.outlook.com (2603:10b6:a03:3ef::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Wed, 21 Aug
 2024 17:03:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 17:03:53 +0000
Date: Wed, 21 Aug 2024 13:03:51 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: cel@kernel.org, linux-nfs@vger.kernel.org,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Subject: Re: [RFC PATCH 2/2] NFSD: Create an initial nfs4_1.x file
Message-ID: <ZsYd99w9wWbjI54J@tissot.1015granger.net>
References: <20240820144600.189744-1-cel@kernel.org>
 <20240820144600.189744-3-cel@kernel.org>
 <6a3d9288fdeb6409dca7c2ceedf249d3b40a7d97.camel@kernel.org>
 <ZsX79e6NPi/4/rxC@tissot.1015granger.net>
 <590b91607e15f1fecd563781a0c5390ff02da5b2.camel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <590b91607e15f1fecd563781a0c5390ff02da5b2.camel@kernel.org>
X-ClientProxiedBy: CH0PR03CA0328.namprd03.prod.outlook.com
 (2603:10b6:610:118::14) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5744:EE_
X-MS-Office365-Filtering-Correlation-Id: 97751694-0b98-4333-2b73-08dcc2033c7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVRuWWdmMDVVTnpOSDh0SnRCYVFJTVRJRldVWXNjMytkY1VpV0Y1Q3FzRE5X?=
 =?utf-8?B?eU9yNFhxQ1F6ME83dUdEQnl2U0VYZyt5Si95STlidC8wR1JVNFpoUEZ3OTJq?=
 =?utf-8?B?bHZCOHhCNTFFcXRIbEphSnBzSjJWdTZzVG51S2txcUdpbVZZMzFQRnZELzdE?=
 =?utf-8?B?WFdGblJEVW5SVkVBdEVMTU1zOENkSlF1UFR1VEV5dndHc2NHRXN1SUd0WDJH?=
 =?utf-8?B?NzBWWm91bHVNeFlyTWp4UFJHYWdWM0d2aGdCZ3MwS29FeGhLTDBOTHh1NFcr?=
 =?utf-8?B?UUxIczJncEs4d0RaU3hMcUlYWjRHRTZhN00wVklQL1FGVFI4TXNRV3liZXZa?=
 =?utf-8?B?Nzd5WCtGcDQ0Q0RhcUFGVCt0WmdBdFdnV1gyTzJSWW84Q0ZESUFBRFhSTDM2?=
 =?utf-8?B?alltWitDTTdXQjFTM2pwODdwaE9GMWNhSmRIcjlCTlFhYmlkREV4bm42d2pz?=
 =?utf-8?B?MktRTW9qeFBSZWFCSFQ3ZGJ3aUNHbnczemhZcmdPSG0wTFk1bkdkdC9mNDV4?=
 =?utf-8?B?b0g2WG5odTBEZVdDbzJUdjVpdDNaVi83RnF4UDBPSlhDTi9PVUFJbDVtek5y?=
 =?utf-8?B?SXk0TWdneFp5ZlFPbHJ4NmhnUDBVc3RUWTJ6bURrWjdsWGJ4a2hpMTdyUTJY?=
 =?utf-8?B?RVBrTHQwaVRYQVhKS0p5TkRoWUxrTVJFRExpS3pubE9KT2YyQS81R3BoWlMv?=
 =?utf-8?B?ajFaeS9tUk5XcVp2dU1YaHlZUVRZcHVNc2xzYlhNSmxCZTVBUVZ5dnk0WFRG?=
 =?utf-8?B?cjJnRVBjSk9jM0l2Q252cGxZblZNb2J5cUpsZ2d5UUFaWUVHbmJ2eWFtejFU?=
 =?utf-8?B?M1NuVEN6dHFCWVhaMWlmc212U3FBc09BRnFvNDVRc2tYUGRwM21Rb3BKT0xR?=
 =?utf-8?B?Mm1oT3JTRHZQWTVuWVI5S2FTNHVBdjBpRVRBVVZKNnVveThvZktkcHhtQW5R?=
 =?utf-8?B?NVFJcnRrQVlwVERzcFl3dGZBN0ZSVVAwdFc0ZUhpdUlCUjg4a3Erblp5UjhY?=
 =?utf-8?B?SnhPbXVSZ3RjK1hCVVh2RHJ2UzlOQ2E1aHlLOGFKNEdUL3MvRDJ3ZTcwYXZJ?=
 =?utf-8?B?UjlhUk5VTDFieDVIYTNKdkhiUnFGUVhGWC8rcEtLYzEvYWl3NmZ6VHFkWGx1?=
 =?utf-8?B?dERHRGFhdUthNVEwZmVDT2JHaDFIME5ndzI2ZS9MUzFSQUdCSmVoaTlkeTBk?=
 =?utf-8?B?aWhRRXNqZUk3ck9nRzRWbngxZVNHSVRIaSt6NnpuNXRmcjNSQzU3OGlWVkNT?=
 =?utf-8?B?bzRsU0RLYTJ4QlZyR3pxZjdZeEw0TEUrM1U0UnVkMmdiNzlpcjMxbjdIZkRM?=
 =?utf-8?B?RHlUeXV1OWsrNmNnb21STm1VQmovemROT2REZjNyUTZhNk9XUkcwM2VOdFZ5?=
 =?utf-8?B?UWhQZDN2Z2FpR08xdExod2pFMGg1SHRrVU9hTUhKUGFtR294c0lqNVhqSjFS?=
 =?utf-8?B?enYyK2pBTmFKS0xmMEhhTmVVcHUxUWNOcCtFUU5rVVUyOFlEdDlhdGhqS3Ry?=
 =?utf-8?B?YWx0bWVXdjVLRjFHbzhkZVRIRFZ5czcxYTk4TFN2Z1FNdzhNc0d5YjNONE56?=
 =?utf-8?B?WW10ZExiL29FOVdNRjlJZDlaSy9VMjlhNFdXaUs5Yktmd2ova09SSy9VWlNr?=
 =?utf-8?B?d2VDeURGMnAyblJIS1kvTlRxSCtKOTFvNGtkaTRrNjV4UkljN2hBd3BHUDJQ?=
 =?utf-8?B?dy8yTmE3WXpPWHlBSWtzRkhid1VKZnBsSmc1NE55cGFMOGlqU29xMTZUeHM3?=
 =?utf-8?B?Y3RuaHpYMzFyWEg5M0JLUXU4bDBkaVJaVW5lcDdoWkRGL3cxbmpCL3cwTVZk?=
 =?utf-8?B?OU5NaDhBcElmd0NtTFcyUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cENLQUQ0YXh2N1B2NXVZZXRKRFU0VTF3a1U2djdMOExsSzF4U0JwVUpsa3hh?=
 =?utf-8?B?ZzlyOGIxdmtETTBDSEJLVmErTSswRGFVQ2x4OGhUNEFOUDV6cjBRaDAvc1ov?=
 =?utf-8?B?SDRXaGNzQTRRZ2dBSVhNVk5DUEF3NlZZMWszbURGNHFSdWVjZHFMRnQzREZQ?=
 =?utf-8?B?TEs5cE42VTNDalpuSmtuUjIzMXlxRkNsb1JNZjNNSGdTTmcvMHlSTlI4M09W?=
 =?utf-8?B?UXRqSlRxKy9PRy9ETDVrV2NFcDFYSEcyUmxXUmRGc2l2V3pBd3A3bFd2RUsx?=
 =?utf-8?B?dEZkVkVGR0xLekRIblpibTh0bUNXNkZVNE55UEpGWnRSbEt3YjV0bjFhYXNB?=
 =?utf-8?B?QktxY01PcUZiYlRwSUhJeGNkeVBtdFZuMGdoQ05lbEJ3MkphQ280YTY0QXFw?=
 =?utf-8?B?TlZwMUZYMUo5b1plVWdHUEVEWm15dm93R0taaUlqYlhaSFlCamo4SVF2MzJy?=
 =?utf-8?B?SC9nOW83ME8yL3NFRXg2K25FNmhNd2FUb0NWaEh2MlJSTlpTOFNEWHFVZ0xO?=
 =?utf-8?B?LzJJd3MxTS8wdFNVVGhoWXM5ZldQOHNFOVNzekZyZHdoUGFuN1ZzSzVmbDE5?=
 =?utf-8?B?UUR4MVJ5aHVUTzJpaUZVakJ4Q214MmxOYkRaTXo2Sk1vNUsrOTd4b1hzVnM1?=
 =?utf-8?B?M3ViRXZMS1kwZTVVaVFlak5MYTJralNQcUFhZCt4OEZpaERnZDFIdW9tdGZk?=
 =?utf-8?B?RzdKem1IWTJWaHMrYnpiZkRZak5ydnRYOFZzR0VzQjBrbHdZVTZna2hGWGlk?=
 =?utf-8?B?a3l5NlhqQWU4ZnJhZWlmWkhUR1FmWWQ3djB5d2VNZ2pBd2o4Q2F3V05aYkpC?=
 =?utf-8?B?R3Q4WDJLS0RaK1JFclAwVWplZVFDY3JJQ25IbjNFc0JvbGE1Nm5JMDRxT0NW?=
 =?utf-8?B?R0dySDhBem1WK0dWL1hrRXlzaXdwVFlkdEhNNzFtYVFHWUN6ZzZpbnBLK0l0?=
 =?utf-8?B?a1FtM09VOW1NWG1YSDBRQktZMlR4YU0rL3ZDWVd6Q09aNmdXa3V4cjA4T05o?=
 =?utf-8?B?ck1zdk8rbE9tL3FFOWtHWkNBR0JEQmYxWU9wZUdjdTd5TFNYMHhRcnBYVEUz?=
 =?utf-8?B?VWxZZzZ2NzlLcjFtVkJCTXJLNGIwNEo5YktIa2xOMEZxTmlnOVU2WFd5WWpY?=
 =?utf-8?B?YWFQOG9TcXJlemF6NTVJVTNUbUU3TDlPTEVrOC9ENTdvSnAzMGNzZGRzTG5F?=
 =?utf-8?B?cGErUkZoTHZqM29hOTN1WHc1QlpQdnhENTg0cmxobForZXBaUVkzUHZFVE9x?=
 =?utf-8?B?K1dwbVRucGhBOFhwU1lwSGpySWRtQkN5b1I3bFpJTzdQV2tJcWlBQnpLWFJw?=
 =?utf-8?B?ZnRqNHp5akZHRmxyclZveEZORmdmOWdDZ0R5VUtZTyttWFU4NkZISC9zLzFv?=
 =?utf-8?B?cDN2OFVrRGxUQ3NzKzZPNmFkQXMvY2gvOStDRWdqZ2lHMEMxb2htQjNtRE1j?=
 =?utf-8?B?cEhBSFpLVWZFQ2RIQXJmaXpaNWRnMXUrWUpjMWxCc1h6eHg3WEt1ZmQxR3Vr?=
 =?utf-8?B?OFNISUdJb2VmY2xnRkMramZoVk1EYnVNdEZybkVRazJPc0lsY01FSGIvRkNY?=
 =?utf-8?B?UmVBYkZxUVpnbmtqLzM1QURQbGJFSEJQakpUZzlTY2JCU3BqYVJKNjRxUzlm?=
 =?utf-8?B?RHlSM0R4a3BSL25WWFlPdk1zRnlRaDRUR2FjSXlJM25UNENVNGhISkxQOUpi?=
 =?utf-8?B?WjBxLzltWGNyYktZQnhRSjdZdERYYU5qUzR4UjE3eDRueCtLV0tEb0w3Mzd5?=
 =?utf-8?B?V3AweXhVVkZBRTBLVUV5SGpwN3RYMC8vVy9HVmM5RHkvaEo4VkluV2JUMXV6?=
 =?utf-8?B?bEJ0VW9yZmw3RGQ5QTVMVTVQUWJ3YWNVblVvNS94Y2EyT0lSSCtwY2lCVEdL?=
 =?utf-8?B?NGRUWlNqbG8rNHp0Q3VHOVJNVWVYWVFaWHVPMTIyN01FbDJzaU8vejh2WlFr?=
 =?utf-8?B?aFNrdE02UXRqcnhOdmhRbzJwbFBEU2VYb3hJYWk0QVJQeFd0N3JhT28wK284?=
 =?utf-8?B?cUt3ektRN1paWno2ZUFJOCtpZVRJb3kvbHB2byt1M1hIb1kvNmE3TkNFN3N1?=
 =?utf-8?B?cFVxZHFDQ2pnMVloOUVkRi9oMmFieno4YUhqcXNiZS9IaXpnS0Q5WTNKSlhE?=
 =?utf-8?Q?bZfY3sdzoqq0YMfFUWqZBssUS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Z5SqYLIkbpc0fbPHYlOtYVTzuQChv0FUtPQ8MfFCLAR70FW9iXQK3NFTvQjQr1tTesW55E7mLV+6Ar+UeHbokpKzFFoPz4veQrixi06OvhdDW2DX0HBVbzs2PIM6PTjygcNKZ5ZkwCX2urGAe8CtuURILuvbNENHLz5oE7bFlD2kJbvz6OtRuV/njHjdheUA/1VuFr5H71zp23F3fJ1jiqWscuaj9z6pb6pRZehMefo6E7jCeHMhzL+D31NYGMXUsf/56V//wT82yGTJJA18puMrz7uGxd+ofjT9hLRMgIyCJHr77aujWi3XJYOeil/wbj4IZBADJOZvALkaArUR5nm/4eDL+1M4yCCsyjp2pNewoAzgK2wWf2D78yU7Y6gKjwT9vQiIlkvEnKfCTDV9ojcMkRKuvtm3Cnbefpp3yeuHMzt8PJV65HZGd3YmlycOH9ofO/fw52oy9T9gjLG+1IPDxW69HEeDSdyr/cV8CIotgKGcauFIrOz0tSQqMbWw/hAsiomJp9aGUsaJ+XGKwR18ZJSkKNs33ms3No4RdSDzTuQ9mpFyomjqaP5U6HFGDgyvVD8KXUCkjevBARnIDYFppLV2PTB3KAXZm26nxC4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97751694-0b98-4333-2b73-08dcc2033c7a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 17:03:53.6751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S07Y1JKcKSnuYpXSGsx9YBbyESjqa8wueFV5X6eyhuf7kz9pwBaqqOC8xYKzaLoHMjeh7uMJEeaDRAhAXM8csg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5744
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_11,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408210124
X-Proofpoint-ORIG-GUID: pYeXYeUmUU6eonaNHcPsK6SI2DRuF9Uf
X-Proofpoint-GUID: pYeXYeUmUU6eonaNHcPsK6SI2DRuF9Uf

On Wed, Aug 21, 2024 at 12:51:51PM -0400, Jeff Layton wrote:
> On Wed, 2024-08-21 at 10:38 -0400, Chuck Lever wrote:
> > On Wed, Aug 21, 2024 at 10:22:15AM -0400, Jeff Layton wrote:
> > > On Tue, 2024-08-20 at 10:46 -0400, cel@kernel.org wrote:
> > > > From: Chuck Lever <chuck.lever@oracle.com>
> > > > 
> > > > Build an NFSv4 protocol snippet to support the delstid
> > > > extensions.
> > > > The new fs/nfsd/nfs4_1.x file can be added to over time as other
> > > > parts of NFSD's XDR functions are converted to machine-generated
> > > > code.
> > > > 
> > > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > > ---
> > > >  fs/nfsd/nfs4_1.x      | 164 +++++++++++++++++++++++++++++
> > > >  fs/nfsd/nfs4xdr_gen.c | 236
> > > > ++++++++++++++++++++++++++++++++++++++++++
> > > >  fs/nfsd/nfs4xdr_gen.h | 113 ++++++++++++++++++++
> > > >  3 files changed, 513 insertions(+)
> > > >  create mode 100644 fs/nfsd/nfs4_1.x
> > > >  create mode 100644 fs/nfsd/nfs4xdr_gen.c
> > > >  create mode 100644 fs/nfsd/nfs4xdr_gen.h
> > > > 
> > > 
> > > I see the patches in your lkxdrgen branch. I gave this a try and
> > > started rebasing my delstid work on top of it, but I hit the same
> > > symbol conflicts I hit before once I started trying to include the
> > > full-blown nfs4xdr_gen.h header:
> > > 
> > > ------------------------8<---------------------------
> > > In file included from fs/nfsd/nfs4xdr.c:58:
> > > fs/nfsd/nfs4xdr_gen.h:86:9: error: redeclaration of enumerator
> > > ‘FATTR4_OPEN_ARGUMENTS’
> > >    86 |         FATTR4_OPEN_ARGUMENTS = 86
> > >       |         ^~~~~~~~~~~~~~~~~~~~~
> > > In file included from fs/nfsd/nfsfh.h:15,
> > >                  from fs/nfsd/state.h:41,
> > >                  from fs/nfsd/xdr4.h:40,
> > >                  from fs/nfsd/nfs4xdr.c:51:
> > > ./include/linux/nfs4.h:518:9: note: previous definition of
> > > ‘FATTR4_OPEN_ARGUMENTS’ with type ‘enum <anonymous>’
> > >   518 |         FATTR4_OPEN_ARGUMENTS           = 86,
> > >       |         ^~~~~~~~~~~~~~~~~~~~~
> > > fs/nfsd/nfs4xdr_gen.h:102:9: error: redeclaration of enumerator
> > > ‘FATTR4_TIME_DELEG_ACCESS’
> > >   102 |         FATTR4_TIME_DELEG_ACCESS = 84
> > >       |         ^~~~~~~~~~~~~~~~~~~~~~~~
> > > ./include/linux/nfs4.h:516:9: note: previous definition of
> > > ‘FATTR4_TIME_DELEG_ACCESS’ with type ‘enum <anonymous>’
> > >   516 |         FATTR4_TIME_DELEG_ACCESS        = 84,
> > >       |         ^~~~~~~~~~~~~~~~~~~~~~~~
> > > fs/nfsd/nfs4xdr_gen.h:106:9: error: redeclaration of enumerator
> > > ‘FATTR4_TIME_DELEG_MODIFY’
> > >   106 |         FATTR4_TIME_DELEG_MODIFY = 85
> > >       |         ^~~~~~~~~~~~~~~~~~~~~~~~
> > > ./include/linux/nfs4.h:517:9: note: previous definition of
> > > ‘FATTR4_TIME_DELEG_MODIFY’ with type ‘enum <anonymous>’
> > >   517 |         FATTR4_TIME_DELEG_MODIFY        = 85,
> > >       |         ^~~~~~~~~~~~~~~~~~~~~~~~
> > > ------------------------8<---------------------------
> > > 
> > > I'm not sure of the best way to work around this, unless we want to
> > > try
> > > to split up nfs4.h.
> > 
> > That header is shared with the client, so I consider it immutable
> > for our purposes here.
> > 
> >
> > One option would be to namespace the generated data items. Eg, name
> > them:
> > 
> > 	XG_FATTR4_TIME_DELEG_ACCESS
> > 	XG_FATTR4_TIME_DELEG_MODIFY
> > 
> > That way they don't conflict with existing definitions.
> > 
> 
> I'd rather avoid that if we can. Having things named exactly the same
> as in the spec makes the code easier to read and understand.

Agreed, matching names is one of the reasons I started this work.

My thought was that the prefixed names could be fixed eventually
after the hand-rolled code has been replaced.


> What might be best is to autogenerate a header from a (combined)
> nfs4.x, and then have the old nfs4.h file include it. Then we'd just
> have to eliminate anything from nfs4.h that conflicts with the
> autogenerated symbols.
> 
> That's definitely not treating include/linux/nfs4.h as immutable, but
> we might still be able to avoid a lot of changes to the client code
> that way.

Include the current nfs4xdr_gen.h in nfs4.h, and then remove from
nfs4.h anything that has a naming conflict?

The downside of that is that approach mixes generated and
hand-rolled code. Not an objection from me, but it was something
that made Neil uncomfortable.


> We'd need Trond and Anna to buy in on that though.

Or the client can continue to use include/linux/nfs4.h and the
server can start using its own copy of that header.

-- 
Chuck Lever

