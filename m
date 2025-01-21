Return-Path: <linux-nfs+bounces-9440-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 427A4A185C9
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jan 2025 20:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F34E97A03B5
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jan 2025 19:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC381F540D;
	Tue, 21 Jan 2025 19:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lVnkeU4r";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mlcfd2wt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191381F2364
	for <linux-nfs@vger.kernel.org>; Tue, 21 Jan 2025 19:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737488621; cv=fail; b=B71gEhwtwz8cMEg1mFg6/x0QI9G9EVwlV8G5gMSYmDWMHj+X4AHbTG/1OtzHBVcg8CVGRiNi1hAEGhWRhPVykWlYP8dLxBj7IvRUt6MCoD1p9QmwRYyYi40mi9Sa/HEeyRA/YN2gZvTNYLhLtqeV+yW3czlTYpf+OQtoWhU3uXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737488621; c=relaxed/simple;
	bh=R+BVVlsldv0/vPzSMOmTNZcvwpMSQYaKmw6/8xlLDKk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HrJokADJemwAKNzWbnz+7oJewk8LohtS8ADhvzCK9g6SI0XD2cAaLXgxqF78NxwNs8Dto974dH+oGpTULeDCNnpdgY/0g05TtWEod55Neteqg171vALoH63eC3z0ADdZBlGyQB8IzSaUy3HNqECXpU94x5odfdplWh2S4pD2v1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lVnkeU4r; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mlcfd2wt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50LJKJp1012951;
	Tue, 21 Jan 2025 19:43:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=7XvCAZk/dIgqOUsmqd4ZW2oJbZSO5M6W/fpEctVV++k=; b=
	lVnkeU4rxYqoo+gvqHgC6dD3r6Zh5fMyKlxsMZWktP6JkSiZWroBA1omdnvPr/tE
	xvYdVoJ6qs4PeZ5XT5WbVMAISNA35hBgS/4l2yeT5UtaR36x6W8jP6/AMqXpYbr8
	lgh5p11jdobQ5nKvfunikjOAfoRt2uEP7UIMI4sGNqreM6CTz3k6b6lJt/CBxX6N
	s8ZdkWwLnsw3CC4ymfcQVDozCjy+pP0P7ggHvyot3QMcfzbIo18+lm6q3FbTgrWS
	yg40eEU17qSQGt8NesYvJ0bX3on00IE4ovTVSWFatKLByCmIQGUvsW8L3G+D3bi+
	OI7UlS0TbLGNFFYe8tZXrg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485qapby5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jan 2025 19:43:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50LIdb6m036529;
	Tue, 21 Jan 2025 19:43:18 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44917pyg0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jan 2025 19:43:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D/eOIByLku1s/jWRZCjyQbcP2XRcJzN/r65ZLhwDioClQ94XTv/BlFJ46moYzVmNr2vc4fFp1YSCBxw6FkMSdzFO4UlDGQWjbZNqF4Rjj0DQPvc6LepCAqG5wVVXuSkshqEw0RUhIjYhKpYw87tZvZyjpgQvjenJnGPBkQdVIpwZBGvocqsSTGijXnKLLQWotZzOzyQLfqsBmz0FB1/r++QRQKKrjIbZYO4Y2A/haqOIICljl/DY06kTgA1zzIqNyoFyVYzRRhMflbp3sroExnFSu/Dn7zgKABxbzzLXs78h+7c4CHHvNQX9q01X9VrdKUxEZWFXDIrvrHoroeMi4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7XvCAZk/dIgqOUsmqd4ZW2oJbZSO5M6W/fpEctVV++k=;
 b=jX5jea4GYMj58CUOREX4/LRo60++d4R7rZ3UVQKxGyVb8M/bT1B79CM1dRrs8MpsKipZfZuLbXJOyC6IYDNEKy2ILhY5B8D1PQpiUYhVMmb5xLmCZJfPvt3p7wCezzeclSsnxe0GtfZmBC1hPRRM7GXI8LTyHX7YeGy5HJqYRDet3Ev8uQhA/TjY3kjPVuf4vAkpxNmWWh4D/Cd6jwF8VIifXGfrUHMDVacxavilKOs/YRDGK2IFuPaDIClYD7SvZ5R4lAuM/DRONvkmNrCHQwR1pb4av+nct+cV26DT9XmvotYiauF0M+1hM3ZOblOpHQKljSliJ3F3CHs+uvFITg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XvCAZk/dIgqOUsmqd4ZW2oJbZSO5M6W/fpEctVV++k=;
 b=mlcfd2wtQQa149Rw2ibmkmpbSEE4JguKvAXs6q9V9e1GFUsMZRsKW1t5Pk4i1b1Q/ky2O0ChXf5TUMs14hOfo/+sI6HLLKp/3LhNb+R3iJoGWg4qpc59Hf9ofb/MLqFI/Ls0Nx5wOV2IKh5DTmDL+zgL+Wc5hR1MQramD1TaccI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4379.namprd10.prod.outlook.com (2603:10b6:5:21e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 19:43:05 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 19:43:05 +0000
Message-ID: <5243289d-12d3-403b-847d-491d9fe66af4@oracle.com>
Date: Tue, 21 Jan 2025 14:43:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: NFSD threads hang when destroying a session or client ID
To: Tom Talpey <tom@talpey.com>,
        Jeff Layton via Bugspray Bot <bugbot@kernel.org>, cel@kernel.org,
        trondmy@kernel.org, carnil@debian.org, anna@kernel.org,
        linux-nfs@vger.kernel.org, herzog@phys.ethz.ch,
        harald.dunkel@aixigo.com, jlayton@kernel.org,
        baptiste.pellegrin@ac-grenoble.fr, benoit.gschwind@minesparis.psl.eu
References: <20250121-b219710c7-773af1987926@bugzilla.kernel.org>
 <20250121-b219710c10-7af78b1a3afc@bugzilla.kernel.org>
 <cf8650cb-1d2e-4771-981a-d66d2c455637@talpey.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <cf8650cb-1d2e-4771-981a-d66d2c455637@talpey.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR07CA0006.namprd07.prod.outlook.com
 (2603:10b6:610:20::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM6PR10MB4379:EE_
X-MS-Office365-Filtering-Correlation-Id: af240ea7-d4e0-482d-94ba-08dd3a53d2f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NjhZS1JKQjgzb3VoT0hia1RCenNmSDFnTW5VK3VEbnJuK1VWYWpkQTA1VzNN?=
 =?utf-8?B?MFlQM0E5d1lRQWF6VStCYmdUUW9YTmxpNUlTcXJUV001cVRzSDJOUDVsTHpM?=
 =?utf-8?B?Um91dDJmdnVkTmMyT2xQODRaT1VScW1QeVRaRTRhZ3NkWDlpd3ptN1JvODVV?=
 =?utf-8?B?Q3c4elhxTlNRWk9acERFdHpETm9id2dLRTFQaVI5QkZmTEw0a0VXVXJRYk5Y?=
 =?utf-8?B?UjZ5aFQzdW5PWDZVU3hlZlgvS21vd0hkaUpOYVVmYmI4by9NUWR3TDZLSWZ5?=
 =?utf-8?B?ZGFHcVhIYitWRytsT0dJdGpwZ3loUzA0NDBlRlNnU2t4MzZuM09tU1lsbERY?=
 =?utf-8?B?b0d0MjNBbWRDRkJhNkFxSkczUG80UDR2ejlpVmUybGpZQWRyRSt1VXMrcUhh?=
 =?utf-8?B?dFJ0UTNaUWJ3ZnFuZjdhelRLOXRZbVoxU2U3KzVneXRRbm1KWnBWZFk5OXFl?=
 =?utf-8?B?WCtnY0lXVklUcU56eUhXVHVrTzlpRkFTMSszUXA5Q2djTlRqYmF2Vm9GWC92?=
 =?utf-8?B?K3YxSWJidmJTdkZ2YTRLMk9ZL1JUWlc1OVozUWVTTDhNRUFQTkVrb1p2NmlC?=
 =?utf-8?B?K3pEbVBMT3U3K2xsQVprdnpjUnZVYU9iME16RmJGaHhtQkY0UXBRM2M2Nzk0?=
 =?utf-8?B?K3puaTRqenF5cURxVVkzMnZwc0FUZ2hqRnc2aUNZampIK2RXQm1SdDBycnZh?=
 =?utf-8?B?QXdXL2VsQ2hKSmhEZG5lTWJVdFlTK2tGVTVSVU4yQzYvamx3Nk1EOHRoYVFB?=
 =?utf-8?B?ODdwUGlEdW13T2ZRVEtxU29MZnpraGh5eEFudVhWRnFsS0xmMmZlOVc1R3pV?=
 =?utf-8?B?RDc2azVkR2tjM2c3VmtQc2VjRWUwZUZuaHFOVmIvSmk2TU5oUnZTc3F2VHJt?=
 =?utf-8?B?QzlFM3lWYUg4a3llOWZlSFN2QS9FQm5ITHo3Qng4TjV5QWNkTTJBVTlNK1VO?=
 =?utf-8?B?VGlRUUZZa0hzWTA4bDd6NnhWMXpzTVNPSjNMci9td3l4WXVmM1NRWWk3OHE1?=
 =?utf-8?B?c1Z1NVRqNWJKVGRjODQyYmlqVnFxQW81WG5ML0hoQWh1UTcrMllaSHp2M0VH?=
 =?utf-8?B?K2lsaEZQYlBlRWc1aEEySTVpcVBzK1BDWlU2RFJyekI0NC93OHdsb2tRdGVm?=
 =?utf-8?B?MSs4aFlrakJqMVduMlJDcS8zcjRmRUp1YnNMNUFrSlpQL2lWaGdaWGllZGg1?=
 =?utf-8?B?OWVMdkxrMmNXSTVJV0d6MHI3V3hKNW1qUVhtMmhIMGlLNHYraVVXcFdqM0cw?=
 =?utf-8?B?U0dObjZ5TVEzbFJGQXp3b0NOcUpybUZrN2JuYmY4ZnZEcnZjbUp5WEtoSHEx?=
 =?utf-8?B?TGduejY0TXBWNEFJN1JlZzdVZ3M2aDFyV0t1RWIvbXczSGpBSndjT2ErL0p2?=
 =?utf-8?B?bnpnOW4rRldVNWNGQk1IV0pIL1RlVzhQeG5ZemhlWFNkM3JjVGN3WWQxdHZr?=
 =?utf-8?B?d3FmelEyZWVyUlZHbHdKU2FZUm5YYm81VmtxalVWYnIzOURDYUsvelRqT2V5?=
 =?utf-8?B?RllLN2dsaFk3VXE1VGNyeGdOOURMNlF2V1BhUzhZeWpySDhoNGpjUXZMSFN3?=
 =?utf-8?B?dTU0T3BSOVJLZGFZNzU2WFJFT2l5T1RibytVUU0zalhBQmNVemlpeEh4di9l?=
 =?utf-8?B?RnZHa0JGV0lnOHBLdU9zQS90dHVXTlNtcWJya1hEcWhiMUxvYk5QVVBTV3Ni?=
 =?utf-8?B?cWVzMTVQMHpKOGZkWUl2SVU0V3gxaTJ6VW1XSGF6aTczRGZSRWpWLzNUSmtt?=
 =?utf-8?B?Z2wzK0ljZ2s1QWpQOWhnMHdDOVorT09zVHF4Mm0rOXhFWWk0TVJlbHAzZSs3?=
 =?utf-8?B?YldoNFlaOXgvUCtTU204L1pJVmJYTnBvRy9Vd2tZbDJaT3hqUlRWYWZkSVgv?=
 =?utf-8?Q?96jtuxcVwuCnt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2UreTZYeGx1VDVBMFc0Q0l0STFMeVJHR0ZlaWllK1FROFowRk9kUFpXQ0kz?=
 =?utf-8?B?T3NWYzlPeTlXOVBZVDZHVDBxd0hrdVRzSk9lNzl6SnRQdjFWb1FVbFJ3UWsr?=
 =?utf-8?B?aUZsWGtXZzBqN2wreFgvWmR0bytzWThYRm5aTjluKy94ai9SZzdUZXhzNzNV?=
 =?utf-8?B?VzQ0bVVqUnFOQmR2VlhpNkZiOFNQUWs1NmU3b09kMG9DbWlyR09nQ1E0a3Bj?=
 =?utf-8?B?bThuMWdXWGMxTG8zUnhQdDJwWkFwMFducnBUT1NMamEyM3p4Q20zdnVpKytl?=
 =?utf-8?B?V0xMVUVoTHZySlRkd1JsWmR0b2N1Rlp2ejdzOHI4V3NWcyt1T2t6WTErbE1q?=
 =?utf-8?B?cDVKMG5va2NxSHFuaGhId0ZYOU9PYlhjTWh2enJjYXFqM3dOZTJNUStLa3hP?=
 =?utf-8?B?RDZTWkFKdWZzQUZHYVNWVjFvSi9MOThMWEU1WElzc3ZncXB5UUoyQ0ZWVVdD?=
 =?utf-8?B?Q2ZPdU9UcXEzZmpWMkM5cW9FSFFqdHRud0hDVzhsSzNIZGJYdTYwcU1tYUtT?=
 =?utf-8?B?MmtzWjZyQ1ZmUE9LNy9SMTk3ZVljTXFLMDE1eHRwa2NKaFZpN0RNU3pnbFN4?=
 =?utf-8?B?R3pVUytIMUhETUJGSEU4TThkNEpIWS8vQzNsVEJJNTdEMkpiQXpRa1BRNkJP?=
 =?utf-8?B?WXE4cUNuTkVTNEhtaFNWQ2lEZDFJem9OdXJYZUo4WjczTzZUVHB2ODRyM0Z1?=
 =?utf-8?B?SnBpa3ROQ1JIVUl2d3pBaDFEY2o2bjE3ZVlyc3ozeG1IZGFQcVZpMGlNcnYw?=
 =?utf-8?B?M1UyR2J2WXVDeUVKSzFTK21QMU10bWEzOWQvamtubkJTNE1DN0ZRM0RTMldz?=
 =?utf-8?B?YUdhTi9FUDRndXhtT29kODhUM0RvVzdQMFZ6aEF6MmlvcEtjcGVsd2plQWMy?=
 =?utf-8?B?Qmp3dmx5WFZyYnN5K25EVmhZTTdKVE9uK2hkMlhqV2NmODNGcGRTTnYybGJs?=
 =?utf-8?B?Z1lNSkt1UTJmOVppVzRpT3hURzRiN3BWY3BxdmxyYzl6VkdNeUF5Z0NTekRE?=
 =?utf-8?B?aGtIMG04RDVqdkpXVnUxRVZwTktmbmRZQ0Rsa2JtYjZTbisrNUZXOGV3Zm9U?=
 =?utf-8?B?enRWeGVQTTBXSTJVaC9Ib1BNZTVVcVBpbjhKZW9PbnVUV0pkd3VNTXJzNktw?=
 =?utf-8?B?NXAvZnUwVXlzTWN5TnF0cmEwQ0cwMVNnWjUvOVFtekdyUS9IQ0g3WTk1Mk5T?=
 =?utf-8?B?S0NhL0YyejBnWXJ4N1FJbEF1dTJmNEVtZmlsZU1raW8wbU9hSkVoeFlnMmxl?=
 =?utf-8?B?dEJNSjRUV3g3R1pxRjhUMXlRelAxRXF4VUpxaWZOSG9wWnE3Vis0YXFNelFF?=
 =?utf-8?B?WUo4TmJGY2tET1UzdXllTlFPellQMmVLQ21heXVLcG9LbVloUTBUZ2hZN3Nq?=
 =?utf-8?B?VXZRaHJpZGJIMit3a3BoTEkrSnNCeWpDRE4yeTB0aHBHWWoyS1hGOWt5S0tl?=
 =?utf-8?B?YzJuVlpyQk9CdkJPdlcwL3Z4L05YaWp4bVZMenFyZVIvSHA2NEoxYk1VOVVl?=
 =?utf-8?B?VUh4MFhERkVweW9GSkN5NWNSYTJvOWlxTjBPQVp6VDByYnU4L0ZSZGwwQUly?=
 =?utf-8?B?c3BqaHJjQnNjaUlSWEk3R2NIVmRsVE1SOXBhbnVxWTYxbEhIWkV2VjVXNHZP?=
 =?utf-8?B?NmtyN1F2R1RWL2VndWJSNFZST1AyZjNVcnRjUWROd0tVUEw2a1RUL3IrTmtw?=
 =?utf-8?B?YTIrTGxJRU1oVDFaNHdjTjc3YnJqVlltcEtuY0hLUmttaC9ILzdWL1NmcjZo?=
 =?utf-8?B?QXZ1ZXVYeFVxQXlyQmFTMTNERlhGT2xlbVFpSnBncjUxY1RhTHVVQ2RqZWU5?=
 =?utf-8?B?YUVFalM4S01jQXJXMUF2aTR5cGRDVWErd3hpcG5UNU5RY2ZlblRwK0NLWDlU?=
 =?utf-8?B?Z2t4RWFDZFZpTW9CSVlMRUp5ai8rbnlOdXUyWC96bFRzUHk1VUtTTldJNDRU?=
 =?utf-8?B?d01UYXBDQnJQaXgvSG5HcjY5OVJBR1o5cW9YM1lIa3BwWDRFeWxYNG40aTlR?=
 =?utf-8?B?UkZOVi9hV0czb05WLy8vb3RPd200UFlHQWxaTGR6RzN4bzZFeXY0NXFUV2VY?=
 =?utf-8?B?cWRjYW93SVI4SHlnVno1VVNwZmFvQzlCRFYrMjBpVVZIdmlLUFVpZzhleXBT?=
 =?utf-8?B?c0l4TzIzaWpGano1V3YwTmhOeFA2bTdqdTI5R3ZrRGlLQlRacy9IMHUvYk8y?=
 =?utf-8?B?bHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	a+47XbTLqHkENnW7nlPzye4IEv6tqv/P0D6H/PSmzPO5LEMi97ffZtRVpHCryGFgWfdv82VxIoYmenli/dS/5JRrPbAkoSqXjR6B23SDgPCIVSuakLCWrWdF1uwuzr+flMLk/G7mGw3iVvxX+OaszMWhVycjwmx2jxL5PLLwNuOhqwUbqKXKPY9c6TPJA6WI9ct4f6ODSJcfzvFTw+ND8HMMhGVTAEjYAdn72fvnE+N/4kRzG6/V/OLTuMsFwkAYWZe9/j8xc/C8zrgVaB7Pe+Fp5j9zgRVcxugzLDviZU7OHTu620yGjOirg6cZ6jXfFQzZ8ew5xrfjcXVePo8FVrJA69Ufna9iB5zxNbDbCx0sY5U/E5PSGEBsHzooSo8OKKVu76TcF73fCEFTHC0cK2B/weYVB4ANo+sZJCl9bRfy7yJ+Qcia3PQ7BRs9avkzBOF/ykrbtL0aiR+LbBmbD6hsH9CpStTMuL6p2SK2hMzAN/JgXEMe7AcdmmBUlyHT/5lyGPPEb1UpRgbqQq1s9wTRMD2XzZJp59kD1n2wWXX7Vwiy6rZJcXM2h5C5NxGqYE+Beo8zPW2ize9vTQxZCFBJgUj1PGq/whmocLLnoys=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af240ea7-d4e0-482d-94ba-08dd3a53d2f3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 19:43:05.3686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uTFZkZZ1QQvLXsUyjcDkd6bcvb82W6c76F+CH2XSEqKYxrSdb7sVeF4J2gL3OzgUrf3i7u2uL4J5OxoJwGb4cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4379
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_08,2025-01-21_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501210157
X-Proofpoint-GUID: qMKvtqYaqLcJNFBbXAMlIEsheVcF1ACy
X-Proofpoint-ORIG-GUID: qMKvtqYaqLcJNFBbXAMlIEsheVcF1ACy

On 1/21/25 2:38 PM, Tom Talpey wrote:
> On 1/21/2025 12:35 PM, Jeff Layton via Bugspray Bot wrote:
>> Jeff Layton writes via Kernel.org Bugzilla:
>>
>> (In reply to Chuck Lever from comment #7)
>>> The trace captures I've reviewed suggest that a callback session is 
>>> in use,
>>> so I would say the NFS minor version is 1 or higher. Perhaps it's not 
>>> the
>>> RPC_SIGNALLED test above that is the problem, but the one later in
>>> nfsd4_cb_sequence_done().
>>
>>
>> Ok, good. Knowing that it's not v4.0 allows us to rule out some 
>> codepaths.
>> There are a couple of other cases where we goto need_restart:
>>
>> The NFS4ERR_BADSESSION case does this, and also if it doesn't get a 
>> reply at all (case 1).
> 
> Note that one thread in Benoît's recent logs is stuck in
> nfsd4_bind_conn_to_session(), and three threads also in
> nfsd4_destroy_session(), so there is certainly some
> session/connection dance going on. Combining an invalid
> replay cache entry could easily make things worse.

Yes, the client returns RETRY_UNCACHED_REP for some of the backchannel
operations. NFSD never asserts cachethis in CB_SEQUENCE. I'm trying to
understand why NFSD would skip incrementing its slot sequence number.


> There's also one thread in nfsd4_destroy_clientid(), which
> seems important, but odd. And finally, the laundromat is
> running. No shortage of races!

The hangs are all related here: they are waiting for flush_workqueue()
on the callback workqueue. In v6.1, there is only one callback_wq and
it's max_active is 1. If the current work item hangs, then that work
queue stalls.


> Tom.
> 
> 
>> There is also this that looks a little sketchy:
>>
>> ------------8<-------------------
>>          trace_nfsd_cb_free_slot(task, cb);
>>          nfsd41_cb_release_slot(cb);
>>
>>          if (RPC_SIGNALLED(task))
>>                  goto need_restart;
>> out:
>>          return ret;
>> retry_nowait:
>>          if (rpc_restart_call_prepare(task))
>>                  ret = false;
>>          goto out;
>> need_restart:
>>          if (!test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
>>                  trace_nfsd_cb_restart(clp, cb);
>>                  task->tk_status = 0;
>>                  cb->cb_need_restart = true;
>>          }
>>          return false;
>> ------------8<-------------------
>>
>> Probably now the same bug, but it looks like if RPC_SIGNALLED returns 
>> true, then it'll restart the RPC after releasing the slot. It seems 
>> like that could break the reply cache handling, as the restarted call 
>> could be on a different slot. I'll look at patching that, at least, 
>> though I'm not sure it's related to the hang.
>>
>> More notes. The only way RPC_TASK_SIGNALLED gets set is:
>>
>>     nfsd4_process_cb_update()
>>        rpc_shutdown_client()
>>            rpc_killall_tasks()
>>
>> That gets called if:
>>
>>          if (clp->cl_flags & NFSD4_CLIENT_CB_FLAG_MASK)
>>                  nfsd4_process_cb_update(cb);
>>
>> Which means that NFSD4_CLIENT_CB_UPDATE was probably set? 
>> NFSD4_CLIENT_CB_KILL seems less likely since that would nerf the 
>> cb_need_restart handling.
>>
>> View: https://bugzilla.kernel.org/show_bug.cgi?id=219710#c10
>> You can reply to this message to join the discussion.
> 


-- 
Chuck Lever

