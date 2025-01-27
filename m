Return-Path: <linux-nfs+bounces-9666-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8605A1D7A6
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 15:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8C3D7A2B6E
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 14:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A598F5E;
	Mon, 27 Jan 2025 14:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pr82t65W";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NZPcnh9q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC6C23CE;
	Mon, 27 Jan 2025 14:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737986640; cv=fail; b=Liku8Nk/qnnJj+lnlDN440771+Jp9hOfS8uJCKsfnerISAvZkiiotb5/oQwLfzqwuj5KhNj1/1DLjXqrKnipycR5SNV+sXdSymaJgvwcvLRPH/gVoQ6rP5c+mBAAb3kH5sgdeQtOF6udShEbOZLRixUYhIChpFlA92iO/0lOeUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737986640; c=relaxed/simple;
	bh=4lxJhij/cdXxLAWD890G6mSWGmircr9gpX7GOdyKHkQ=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KWJwetZ0XPEUHRKV/9tINyfvEfsfkXmPd5nbI0BzPg6O+F1KiJLUVarRDFc/XyMN3SYkKBFmPvkCvWD8lHr6ihW7vS5fgbQ5QsGpNgNyekala4rFinrvYWoo/8H5l9jQfmyyXNnap66/1jYzS9ef+SvfkrmzME6EJjRs23ArIYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Pr82t65W; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NZPcnh9q; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RDxe5K011847;
	Mon, 27 Jan 2025 14:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=QM/i5cFrSU55W+gF1ir7Io8+ScesYW9t03ELdlhhE0w=; b=
	Pr82t65WgQCLIJJJAAPMkLTXVt7bL+n09hqmq4tAdXxfVDMGYb0dkjJU5kgupM3I
	xVK88fI2k+nWjl8vffWJrKHegcwJTsIex1vqC6I2TMe8Gxvpd0Wk6mkUKTfthR2H
	Ovv4mfm6cf/hHboiBmro4bp9dWIh/xfwRGpQW0JSizWU5oS3xrSNcMzoYquFpqhl
	GhSnd2f8gYn1OkUVwGnA78nIoMx3Y6/lGa89dpgHoRfTUeP22JRx2KtsfWVh6sep
	U4CdHRYZqGh5cWukQG/emPSxjpLkoD/ulyI9PtzRLVczklJmFhSnZUBT+Vd4cQcd
	FpSc+i9gHIOjxGXSwc2VfA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44ebgk809p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jan 2025 14:03:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50RCmMeg004169;
	Mon, 27 Jan 2025 14:03:43 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44cpd716md-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jan 2025 14:03:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JNrNBX0M9XDi3J0VLPe+Z3O/BlAbKAMFMEPmX7xliV5rAOQLQqVBDQE/x/AITQD6M4taUypXFcWgX+CvrkDgeygzWaB45NPq1fjXEzbKtY/lWtcpWcREezEvdvvUJk9OUf1drZtfZbzv1uJk8GW+lbG1aZRWvDX8krsz+AWiNlUBKDdbb6Jf/JWzhL5YttJdtJqZVMdetf2Z05R/qOXycHsjNLlQ7x4MxUdRLN8dwRZWvwInoaVh0TAfDotoramISzT9rlTZYDFvNpz9hmPOERh64cycqGPtkJJkY2K/OH8rDlxU02AMIWPWUO7icl4qSS5BNGgz2Fwq/sUb8ykgMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QM/i5cFrSU55W+gF1ir7Io8+ScesYW9t03ELdlhhE0w=;
 b=LDtPNjCqm6jSqzX89sI6Unhsrl9OzDjfbn5oRGNJeNFg+Ay+NBOGS/Oe84UAbfeZP0mbTuP3m9cwFU7b5SLmIvHVQBGOIaNeoDta4egZiTJkDOj3xtI+rFiN9thfY12gc/4VOQQZ5bVS2FG5r9neLAuuTqJ2WJiBK71Yt6N09d7SPTLvzM8l0e2EjGKcJDJ/XZUvKTPJzETp0kpr5RZA2FRmIYPns/rezIe7CASNCp9gevf5vvLAhLvItyxOkx13u/h9+Z/A2+yfY5yXAeN0lDum1cHjoR9SlII18fYRr27K4FebwUmP8mep/TbmOYuuC29IicPMJx7jV5SuEpleGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QM/i5cFrSU55W+gF1ir7Io8+ScesYW9t03ELdlhhE0w=;
 b=NZPcnh9qBXXKoQLpB4xnsLqQaK02edH+YeAC2gZGy+oY4LRLrb8Hn79WlwkixV8PyyqOh14Nr2fL6HYSKWUY0cZib/G/OJT5Q0bWD6ZfyVxwCHaH4djZHWDWVa+RYNVxT077D+c/4wXWQbkLLel9Xl3+rIyMrxsqY557a/HmKMM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6253.namprd10.prod.outlook.com (2603:10b6:8:b7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Mon, 27 Jan
 2025 14:03:40 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 14:03:40 +0000
Message-ID: <37fb186b-ffb6-44dc-a097-ec669079c801@oracle.com>
Date: Mon, 27 Jan 2025 09:03:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: validate the nfsd_serv pointer before calling
 svc_wake_up
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neilb@suse.de>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Salvatore Bonaccorso <carnil@debian.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <> <a3ca70c78e48e1a36d29741eb8913ce85e3f51a2.camel@kernel.org>
 <173793694589.22054.1830112177481945773@noble.neil.brown.name>
 <06379c169fb0e891dae9d444ef0a06ea57e9af38.camel@kernel.org>
 <c70d155c-22e0-43f7-af23-241088317d94@oracle.com>
 <5923519a4c8f6bb6d5ccd2697447b313fb61bba3.camel@kernel.org>
 <ac965f67-db15-4f93-be03-878e6a3d171b@oracle.com>
Content-Language: en-US
In-Reply-To: <ac965f67-db15-4f93-be03-878e6a3d171b@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0227.namprd03.prod.outlook.com
 (2603:10b6:610:e7::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM4PR10MB6253:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ec88104-f899-469f-66b4-08dd3edb66e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXpCWXFnL251MDNOc1c1MmNOYWdrakt6a3d3aUpZUnNrdkxHNWNGS3l6dnp4?=
 =?utf-8?B?Z3dOR3lYRkkrd0FQWENSU3JlY3Ixa05IVjBJb21mVGEzN3hnakhhcE1XQkVk?=
 =?utf-8?B?OGVzMzMxVkFwSVJBVXlrK093bW5yV3l6OU9mN3hDT1JvZWdxWjFidGZDQzRs?=
 =?utf-8?B?c2RYbUJ1Vk1wdlpyN2Iycm8zMnU3cm14S1UwSUxRWHBZQ21KWkhSWTcyek9t?=
 =?utf-8?B?RlBwVFpsTDFsOHNPMTZsSTBESElWUzByVm45Wjd5QXdKZEFrVEdUeDk5Q04x?=
 =?utf-8?B?UDc1ZkIvOU93RHR5U1VtUXBtZmpTMDNaazRVWWYwYXpVanN1OUtmb1kxeGlm?=
 =?utf-8?B?Q0NnditTdms4MEZSa3g3TWJYSkVvR3Iyd0JhdWJqeWZmQW9aRWhMbStjSDMr?=
 =?utf-8?B?TUwzRkdCbXlZQk45SzEyQ28rN2loS2diTXV3TGpONi9KQ3ZLcFM3MW9DcmFG?=
 =?utf-8?B?QWs3dFp1VU1vRTMyS3NuYXBpUDRNS0dud0xBT3pGUWZ0SkJJU3Z0VGxHRnVy?=
 =?utf-8?B?Tk9YaDBHZXc5djRiSXgvZEVjbllwTnUrelBuNFkxQ2RaeXJuVUtJZnhMeGxW?=
 =?utf-8?B?TVh6bWNNOWs5RXdDVlc5U3k1QTZmOEpIZFpINzVHUDVuTTJiWVEzNHE3Qmdx?=
 =?utf-8?B?ckRLS0Yyd2p2QUpESVE3elNWd05QNk4rd0RwVFIzWGJVK1pVSlNyRVNlZWQ4?=
 =?utf-8?B?VnE0S0pwZmJNY1RyK1Q0N250SmFodE1hRXJCVWRoVkpKVWZDeEdrUmRndmZX?=
 =?utf-8?B?Tk9jRStDeHBLUFpYK1R0TlorVWZLaCtMamtDN0d1c2ZQTWJsS3J2WDlIdmdX?=
 =?utf-8?B?QjhnWVQ3OVMwRTVqMktMaHA5RmRWT3JzdU9EclRBMjBNMTJSRTAxYWdCQWRi?=
 =?utf-8?B?WmpzYmRray90b2xmTEZsKzQ0cGdNNnB1bTQxdUNZVnJYNEpXRS9kQW15dk1r?=
 =?utf-8?B?OG5uc1BXenhLT1NUWHk4NlBhWVRZbGdsL3RxTVFqVmNUNmRLOFpiZlpqYldT?=
 =?utf-8?B?M3hHUEdlL2xVMEJ5dGozdnFnWTJlWE5WMklKNVdoMUpIL1ZlODV0Zy9FUFVv?=
 =?utf-8?B?clNUSWJjczl2anRLbVRRQ3ZpeUdMS3hkbGhqRG9yaGVDQkU2WUxTckdUWG9X?=
 =?utf-8?B?Mlo3OXpzem9wMEk3eEpoeVQrVjhBM09nT0pDSTZMU2N3eVk5VlZhTGRJYzI3?=
 =?utf-8?B?aFVXYTZtV29WSUUzL0REbE5XMkgvelJFWTVrdm00TDBSY1psNzJCL2E3MUd5?=
 =?utf-8?B?TlhGakE2VnhYODRRUk4xVVJCSkszd3Q4NXNCNUI5dEdXek9mTG5kcGdoY0ZO?=
 =?utf-8?B?WEVGcFNCRFFlQTZiOGRxcUYzU1lFL05xWFZNc1ZsVmd3amE0L3ZjWjFUS1Ja?=
 =?utf-8?B?RjRHWW1TK2llSE9zMnc2VE9HSTI2TFZyS245Zi9JSmMvY09aU1czTjZWZzcv?=
 =?utf-8?B?aVBQNmYzMXhLcDJMc3c2SUZxTVJNdEk4THFaVEorVzFUQzBvT01PbHI4Wk9Z?=
 =?utf-8?B?RWd3UUE3VVFkVGkwM3NKeDk0eVQ5L3dCNkdSU3BNck1pTmJBNGRDY1JVODdX?=
 =?utf-8?B?ZVhNa0R2NFc3VWRZNU9hcW9uazEyZnVMWFZPUFlKL3pIUFFHcVJJZkRpOHRY?=
 =?utf-8?B?VExPTEFMYW1ZbWdwcmVtWkNRZXV3WW9Yc3hFTytvOEh5NTNtejVXVUlnT0M5?=
 =?utf-8?B?cENZUHVna0UwN05obHlRRHdHVzYwMExid1pVYVZqZFB0L0NKalpCUU9qaWkv?=
 =?utf-8?B?RjhhTXV0R3J3THQzT3NvS05WRVB3ODBBOTN6UkkxUXp3L0FJcENtSUY4Z3Rr?=
 =?utf-8?B?aHlPWUxjMkZHMW5rb1BmQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTBwS3VrZ29GNnQrcnBKMDNvZmFtUjBzNlBrY0VwbnBaMUVFdGlrY0xwY212?=
 =?utf-8?B?eHYrb1VKM25WbFQ5M0xnTUxWYXdXc2t3NUtVQithQ1FUS2cycDd1Y1d3aVBr?=
 =?utf-8?B?OFhPa1FOejRJQTVwV21uVGZZVll5RC9pUll1WjJVeGsvcENZYUxoMlIraUkw?=
 =?utf-8?B?MEpWNEM4ZEtHbFhhd0dRZnFCMUNuVVlURXZSK1J6Z2dxZHBEVlpzaUp2aEd0?=
 =?utf-8?B?K2gzaktEMno2ZmdvZnR1TmMvN2RKWGppKzZkY2V5MTE0TXFMbE1wZldjbzRP?=
 =?utf-8?B?OUZrc0taejBGaEoxaW9odSs0R2NQdmRvUVRWaE15ZktEM3FTYUtSc3FEQ2sz?=
 =?utf-8?B?dkJDY0U5QzdrM0o1cDMxa1RYd2NwS0RLa0oxeHlPbGtPUk9pOEx6R2p0VHBv?=
 =?utf-8?B?YXNKSE1OSGNFQWhNTi9kbHhZanZWNFRQbTFvSmUrTVhQcm9zZ3lFQ0JYdHNN?=
 =?utf-8?B?bTQ3V0JrSnIvaTllSjRQUTB0UytiUkVVdUp0YW5WS2RsMGNxVlFIQXNUZ1FZ?=
 =?utf-8?B?NXQzOWpCL3hkbDI2VmhyTzduY2wyRmdwM1ppVEFnMWVheEpqbGlTWTAyZFhD?=
 =?utf-8?B?S1dLMk11akpKUDk1N1ZBVFlJR1Y1ejhVbUh6V0F4Y05LMkVlOU1XemdkKzhB?=
 =?utf-8?B?eUVNYzMvZEhIS0dVb29zMjFNSjBnTnZrSTh3ZjRucGdZVVZrWm53UE1HbVZG?=
 =?utf-8?B?VWt6ZU9rbDFWK1UrckZzTnQxMWhEY0YrVVpkSGhQN2RVTzNjT08yLzFMaDdC?=
 =?utf-8?B?dnRiTTFlVHRxRy8xUGttK25XM0JwWDZCbGg3MnhGN0ZycThwSUFqS21PL005?=
 =?utf-8?B?T29qbDduaVVoUkhSakRRck5UUllhNE1UbjBtWm9La0FzZmU1WVJwWVBlNHl5?=
 =?utf-8?B?UU1xdEVDbUNBUSt2ekdrVys2RGFGUGd0eWZkK3c3cm1OenA3RDVEM3RHSDJU?=
 =?utf-8?B?VE9udkpjNHlKSjZFc3FQamkwdGZNQVdlZlVzcjRwemZITk9HcHFlb2tabHc0?=
 =?utf-8?B?a0dlWDFETUpyaDRzVGY0bVF1WGRrRW5DWCtDeFRrTy9CRUx6MEJSZFhJTm83?=
 =?utf-8?B?QUIzTTVqS2xGZjNWTk9LWFdFRk1DUTZER01RWFMwTGU4K202RXZYa1RyR1hh?=
 =?utf-8?B?WjJRRytwQ0M2Mi9LS2FtYjFWRGhzWXNYME5wQ1dFaVRseEZ6VTc5NFBhQXh3?=
 =?utf-8?B?Y3ZlQzVxTUF4U1NWYW1VNXRPWHc2cVdyd1I2RE1INk4rdGhhWmJHMkh3R0kz?=
 =?utf-8?B?SXdOSzdmTDFpWFFGR3V1aTQvRi83b1lFakJ4VjVuTU1YVXpBeEtaSWdGQWxr?=
 =?utf-8?B?WDgyYjNDZFErS1pJTU9qY1YwSjg1NzNKSEN6MlZHdTB6anBQVkFhRjNOSGlI?=
 =?utf-8?B?SnR3RjlHMC9pTnhuanVZV2NoeEkzOE5BODdaOUZmazQ1Nmw1aUdvblF1aStp?=
 =?utf-8?B?VWw2U2h1b2FnelBkc1d1emlQalE3WVd5S3ovMmRWOHk2cVpIMEM0VXovc0Q1?=
 =?utf-8?B?ejhTS1lkTjFLMS9tSDRXWWxBT0IxSWhvK1I3RWFzTUVLWjFZK0xhNE5YajhJ?=
 =?utf-8?B?UnJ0QXlJbExlc1kyQmxrenhXKzVaMTFkcXdGUm50Z3dLSXpxYW9pRnFxbEly?=
 =?utf-8?B?MUw1MDR5ck9MUGgxVmVJSERlc2JIR3ZCbFRFOUxXTDAvOTZzUGlNeXEzOEtV?=
 =?utf-8?B?SGlHeHg2VkdteDZ6QnNCWUFQUmlXeTJRem1BenJBSVBQWW83eFc2SEREd1Vk?=
 =?utf-8?B?TWxsU3RNbThEUzlRWWVSaTBkUE5lYjdYd3NUNGZVeDBvcTFzQTZDRThwcG9a?=
 =?utf-8?B?UXRKV1FBNlRwcTltTzNSOHVZa3JlQXlxMzZaUEhMcEhEZDBYZHpDZC9ZZk5T?=
 =?utf-8?B?c2xBdk5aSitLZmRwUE9LazlzUXhNZmY1ck5DczJWa3I2L0Z2SW5QVnE4aDNr?=
 =?utf-8?B?K0tMSUxyMjlJc2oxckMxdGJFVXlvb1E4UG4rMzlFVzdhOXF0ejd0cThIN2Ez?=
 =?utf-8?B?VEswZE1PcGU0WWc2ZEU5b2FxZ1A1ZFpjY3k1Y3pISlBGRWtGWTVoU3pXMlQx?=
 =?utf-8?B?ZlBqVThHdkRiSm5OSzE2YzFkUTlKbGxhdXBDb1R2U21SRFYwdnp5eHUzbGxM?=
 =?utf-8?B?S3JEdmhqQkd4L1VjOWUyVzhzKzJSVGJSalhCSjc2U2c3MEpPdkVVWGo0Q0RJ?=
 =?utf-8?B?bkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PbsDuIDnCWPuzH031txrdw2WKJsCkShoyxTen7USx+J+HPL5tNaa1mJfpNnVmXbtywgrStX+BzY6YIAfLne4mrNG9ue+cJlJVPtDBRXNlaFmCrW2Bzg1h7yo+0evrFaoY2E0lIqdtu4L2EsbAVOL5BWWSgKhktzvbS8l7cjJhW4cNYNgT2mE/44rxqDjJ2Ju6HDhqAVQ6gNTSHedlNxC9VqVMw2cG7IqpR4SmKcBrT1/SJ7JxO/NfTXuRNVS77tSt/ESS9o3RpeggFdzUTWT8yx0Nb+XbLVriuoMjwX44SgSWCkxB+DjcM2EsGDBAOWRPl565MW4cV4ICnTKlB3y0w3TCEOx79209QYBHoM6mnTW7tQDtm4bfNdbeDo2UTnUTsNsuWVPuUwOXb5bQvlJ+anqa7kOREMtfBOMAbreuFaQHxHswugcIzdksx9Psx2iSAf2lEmWymd5YdWFnE0qg1VJJE34j3N8Rovf5fZrmwxxCalALCVUKb4FxNHZzUk4aMqz/ziu9COXwkxofSDmreafVUHA8E0pv9zb6JMVyQGvnaP/5zCnB5IU95cpZ7bVCYdneHL8vVU8uQVbOAJCjqFu1qTHEIorbEKw5V/5cFs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec88104-f899-469f-66b4-08dd3edb66e5
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 14:03:40.2826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NXaZ2XoWxFszHGqnhmdtQ9isSq+ayhPSrVohiAAkgHUmRIKT4lCfXHzbF7hlpkJ7GjIy3SDAGHbmGcBPvnDWfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6253
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_07,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501270113
X-Proofpoint-GUID: BJgTtEEEsOIpxAUrcZyi78RodCB7PMfC
X-Proofpoint-ORIG-GUID: BJgTtEEEsOIpxAUrcZyi78RodCB7PMfC

On 1/27/25 8:39 AM, Chuck Lever wrote:
> On 1/27/25 8:32 AM, Jeff Layton wrote:
>> On Mon, 2025-01-27 at 08:22 -0500, Chuck Lever wrote:
>>> On 1/27/25 8:07 AM, Jeff Layton wrote:
>>>> On Mon, 2025-01-27 at 11:15 +1100, NeilBrown wrote:
>>>>> On Mon, 27 Jan 2025, Jeff Layton wrote:
>>>>>> On Mon, 2025-01-27 at 08:53 +1100, NeilBrown wrote:
>>>>>>> On Sun, 26 Jan 2025, Jeff Layton wrote:
>>>>>>>> On Sun, 2025-01-26 at 13:39 +1100, NeilBrown wrote:
>>>>>>>>> On Sun, 26 Jan 2025, Jeff Layton wrote:
>>>>>>>>>> nfsd_file_dispose_list_delayed can be called from the filecache
>>>>>>>>>> laundrette, which is shut down after the nfsd threads are shut 
>>>>>>>>>> down and
>>>>>>>>>> the nfsd_serv pointer is cleared. If nn->nfsd_serv is NULL 
>>>>>>>>>> then there
>>>>>>>>>> are no threads to wake.
>>>>>>>>>>
>>>>>>>>>> Ensure that the nn->nfsd_serv pointer is non-NULL before calling
>>>>>>>>>> svc_wake_up in nfsd_file_dispose_list_delayed. This is safe 
>>>>>>>>>> since the
>>>>>>>>>> svc_serv is not freed until after the filecache laundrette is 
>>>>>>>>>> cancelled.
>>>>>>>>>>
>>>>>>>>>> Fixes: ffb402596147 ("nfsd: Don't leave work of closing files 
>>>>>>>>>> to a work queue")
>>>>>>>>>> Reported-by: Salvatore Bonaccorso <carnil@debian.org>
>>>>>>>>>> Closes: https://lore.kernel.org/linux- 
>>>>>>>>>> nfs/7d9f2a8aede4f7ca9935a47e1d405643220d7946.camel@kernel.org/
>>>>>>>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>>>>>>>> ---
>>>>>>>>>> This is only lightly tested, but I think it will fix the bug that
>>>>>>>>>> Salvatore reported.
>>>>>>>>>> ---
>>>>>>>>>>    fs/nfsd/filecache.c | 11 ++++++++++-
>>>>>>>>>>    1 file changed, 10 insertions(+), 1 deletion(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>>>>>>>>>> index 
>>>>>>>>>> e91c164b5ea21507659904690533a19ca43b1b64..fb2a4469b7a3c077de2dd750f43239b4af6d37b0 100644
>>>>>>>>>> --- a/fs/nfsd/filecache.c
>>>>>>>>>> +++ b/fs/nfsd/filecache.c
>>>>>>>>>> @@ -445,11 +445,20 @@ nfsd_file_dispose_list_delayed(struct 
>>>>>>>>>> list_head *dispose)
>>>>>>>>>>                            struct nfsd_file, nf_gc);
>>>>>>>>>>            struct nfsd_net *nn = net_generic(nf->nf_net, 
>>>>>>>>>> nfsd_net_id);
>>>>>>>>>>            struct nfsd_fcache_disposal *l = nn->fcache_disposal;
>>>>>>>>>> +        struct svc_serv *serv;
>>>>>>>>>>            spin_lock(&l->lock);
>>>>>>>>>>            list_move_tail(&nf->nf_gc, &l->freeme);
>>>>>>>>>>            spin_unlock(&l->lock);
>>>>>>>>>> -        svc_wake_up(nn->nfsd_serv);
>>>>>>>>>> +
>>>>>>>>>> +        /*
>>>>>>>>>> +         * The filecache laundrette is shut down after the
>>>>>>>>>> +         * nn->nfsd_serv pointer is cleared, but before the
>>>>>>>>>> +         * svc_serv is freed.
>>>>>>>>>> +         */
>>>>>>>>>> +        serv = nn->nfsd_serv;
>>>>>>>>>
>>>>>>>>> I wonder if this should be READ_ONCE() to tell the compiler 
>>>>>>>>> that we
>>>>>>>>> could race with clearing nn->nfsd_serv.  Would the comment 
>>>>>>>>> still be
>>>>>>>>> needed?
>>>>>>>>>
>>>>>>>>
>>>>>>>> I think we need a comment at least. The linkage between the 
>>>>>>>> laundrette
>>>>>>>> and the nfsd_serv being set to NULL is very subtle. A READ_ONCE()
>>>>>>>> doesn't convey that well, and is unnecessary here.
>>>>>>>
>>>>>>> Why do you say "is unnecessary here" ?
>>>>>>> If the code were
>>>>>>>      if (nn->nfsd_serv)
>>>>>>>               svc_wake_up(nn->nfsd_serv);
>>>>>>> that would be wrong as nn->nfds_serv could be set to NULL between 
>>>>>>> the
>>>>>>> two.
>>>>>>> And the C compile is allowed to load the value twice because the 
>>>>>>> C memory
>>>>>>> model declares that would have the same effect.
>>>>>>> While I doubt it would actually change how the code is compiled, 
>>>>>>> I think
>>>>>>> we should have READ_ONCE() here (and I've been wrong before about 
>>>>>>> what
>>>>>>> the compiler will actually do).
>>>>>>>
>>>>>>>
>>>>>>
>>>>>> It's unnecessary because the outcome of either case is acceptable.
>>>>>>
>>>>>> When racing with shutdown, either it's NULL and the laundrette won't
>>>>>> call svc_wake_up(), or it's non-NULL and it will. In the non-NULL 
>>>>>> case,
>>>>>> the call to svc_wake_up() will be a no-op because the threads are 
>>>>>> shut
>>>>>> down.
>>>>>>
>>>>>> The vastly common case in this code is that this pointer will be non-
>>>>>> NULL, because the server is running (i.e. not racing with 
>>>>>> shutdown). I
>>>>>> don't see the need in making all of those accesses volatile.
>>>>>
>>>>> One of us is confused.  I hope it isn't me.
>>>>>
>>>>
>>>> It's probably me. I think you have a much better understanding of
>>>> compiler design than I do. Still...
>>>>
>>>>> The hypothetical problem I see is that the C compiler could generate
>>>>> code to load the value "nn->nfsd_serv" twice.  The first time it is 
>>>>> not
>>>>> NULL, the second time it is NULL.
>>>>> The first is used for the test, the second is passed to svc_wake_up().
>>>>>
>>>>> Unlikely though this is, it is possible and READ_ONCE() is designed
>>>>> precisely to prevent this.
>>>>> To quote from include/asm-generic/rwonce.h it will
>>>>>    "Prevent the compiler from merging or refetching reads"
>>>>>
>>>>> A "volatile" access does not add any cost (in this case).  What it 
>>>>> does
>>>>> is break any aliasing that the compile might have deduced.
>>>>> Even if the compiler thinks it has "nn->nfsd_serv" in a register, it
>>>>> won't think it has the result of READ_ONCE(nn->nfsd_serv) in that 
>>>>> register.
>>>>> And if it needs the result of a previous READ_ONCE(nn->nfsd_serv) it
>>>>> won't decide that it can just read nn->nfsd_serv again.  It MUST keep
>>>>> the result of READ_ONCE(nn->nfsd_serv) somewhere until it is not 
>>>>> needed
>>>>> any more.
>>>>
>>>> I'm mainly just considering the resulting pointer. There are two
>>>> possible outcomes to the fetch of nn->nfsd_serv. Either it's a valid
>>>> pointer that points to the svc_serv, or it's NULL. The resulting code
>>>> can handle either case, so it doesn't seem like adding READ_ONCE() will
>>>> create any material difference here.
>>>>
>>>> Maybe I should ask it this way: What bad outcome could result if we
>>>> don't add READ_ONCE() here?
>>>
>>> Neil just described it. The compiler would generate two load operations,
>>> one for the test and one for the function call argument. The first load
>>> can retrieve a non-NULL address, and the second a NULL address.
>>>
>>> I agree a READ_ONCE() is necessary.
>>>
>>>
>>
>> Now I'm confused:
>>
>>                  struct svc_serv *serv;
>>
>>         [...]
>>
>>                  /*
>>                   * The filecache laundrette is shut down after the
>>                   * nn->nfsd_serv pointer is cleared, but before the
>>                   * svc_serv is freed.
>>                   */
>>                  serv = nn->nfsd_serv;
>>                  if (serv)
>>                          svc_wake_up(serv);
>>
>> This code is explicitly asking to fetch nn->nfsd_serv into the serv
>> variable, and then is testing that copy of the pointer and passing it
>> into svc_wake_up().
>>
>> How is the compiler allowed to suddenly refetch a NULL pointer into
>> serv after testing that serv is non-NULL?
> 
> There's nothing here that tells the compiler it is not allowed to
> optimize this into two separate fetches if it feels that is better
> code. READ_ONCE is what tells the compiler we do not want that re-
> organization /ever/.
> 
> 

Well, I think you can argue that even if the compiler does split this
code into two reads of nn->nfsd_serv, it is guaranteed that the read
value is always the same both times -- I guess that's that the comment
is arguing, yes?

I just wonder what will happen if that guarantee should happen to change
in the future.


-- 
Chuck Lever

