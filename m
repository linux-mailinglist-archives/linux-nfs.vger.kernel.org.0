Return-Path: <linux-nfs+bounces-15149-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D51BCFD20
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Oct 2025 00:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6EF2189760E
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Oct 2025 22:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51221E9B0B;
	Sat, 11 Oct 2025 22:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R8PlguHw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="s1lztDwl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DF31F7580;
	Sat, 11 Oct 2025 22:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760221165; cv=fail; b=LWt5kUfWy2FunhxGub8mMAOEAFsUfCAtmclJkFbAU8PCsHL7dllvp87LxayKIAv9U3O0W2A5sBb/h5upiPYMC6+0GZ2dtZqTZhaDbiRczQf7U+/v6U8eWMSCFnUchfZCaK3AB0XDYAizaT3niTv2glzk9GBosppHINeKCbmJAGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760221165; c=relaxed/simple;
	bh=TUEtJZYLHT3Dj+XFtJd8DVU24uBf7Hpdl0wnJYoH6pg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fd2Mf4yzQxSbRHlYRxZNGlH5im4d3Qtqm2ucuNcwuJb1H8sgkWrO1S8WWnfPSgEFd9n8QRfGdk+deAY6dsogyayj+4DyUirmWXrSmBC7VQWSNkp4xWkAI9F7UqY7X3Y5KsMawHOlM6EUULrM7lZwyiItcORKCaCgLUyyJsVqyIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R8PlguHw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=s1lztDwl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59BLuHqi003796;
	Sat, 11 Oct 2025 22:19:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=QDrjaeSQA4U+N30NfVZgsUlfY4tMrHBJQz2q1hBg4Lo=; b=
	R8PlguHwBKuP9Rp3m7Oj8WWz4jcSvmmwwWuF7+yhAteXnKMXmEReyCgH69xTHuVC
	kL/a0CxB73bTiYDnkdtLokTqPTHbC5tld2rEE5P7S5RDRZaDvUlLNWu13neNMYto
	RYzA+ADgQXgI7pCJer12vLeA7Kg6poTFDFqrs+P8qlz75URwcrDAuwtK6YQ/gaVK
	Ig/ad0xkElupiJ3ZoAfBl8AWUP9oal33xVpl2ecZx0l1aRTauiFigIreeT/6Y6tb
	UTAv1oUBEllec3Wh8TE4yxvSVhHXoIKpzfgFnq2npkKWda5GTEy93HlVTID+bTSe
	M2kDhlOUFVhMGmYQCq6rgg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qeusrjc0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 11 Oct 2025 22:19:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59BIcbnc026299;
	Sat, 11 Oct 2025 22:19:15 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010003.outbound.protection.outlook.com [52.101.56.3])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdp617e5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 11 Oct 2025 22:19:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fZskEw3dkZpz7f/4iYI3BnCK9zqcTiVN9tnXJJ39lnj6A5kD/TydmaDcze+o5jhtnlBQhBW/sK9C2cV21FU57nPKtncDBMfW4Tk4yxKQrDOtIho2r2LqP+otTqw6dQo2+KwNN9XqTZsFc6diuXliewt5/bnJdqkNSr6Vw1SWoyfLc4Gr0Tf38P1o+c5fKIiokba40F8JadRZtkLsKa3tMr2yRLZbISLOv0lBOiLIFdCs5oa64fBmU7xCOiO4u0FVnHsrsF3qJ7quDPzh+7aN6ElyhnzPvUqJaBh65DrHk5jnvXhnNYOUjh/NfSfZ2xHtMlxvpgrwTS0nxXr4KBOc5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QDrjaeSQA4U+N30NfVZgsUlfY4tMrHBJQz2q1hBg4Lo=;
 b=y01nyHiP5pb368rYP7X2cd7fKx8u0FO7Wps8JI4w5Ow9iQ66MmKQcDd0J2LTtqHK4NTiY+PQpKMuJw6ZOHZzg9Xxsh6R5WwtUbqpR9lQa9PSxLrSpyGOWBWrhc/Al5+eBjFdrYgpsZjFYjcKdSZSoTf64NsF/9n/X5chrNX3b++lBP8ko4gZP2QPN+VllR0cSELZBuKDbxj7P8Y8s3CI76f5eNRjdVVMlpHKo3JejU24tyEs4tHw5l5gxsdpSoo3hpVD2su9dWuNqCdklITv6Ju2TCL1EO6qC7UiEAwyq/7gORId3jRbZVRdyI1cXGamT6WCODMhRKzSaK8HI0L7zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDrjaeSQA4U+N30NfVZgsUlfY4tMrHBJQz2q1hBg4Lo=;
 b=s1lztDwlWqyUSsmZQRF83NYvBD3b75jAlyFNy2iOCn259wu2xVjoZdKSHiH8AYxAvCjqOcIpn0ZaY8sPlC1T+LWvr9gJjKk5rJH3yodBbVrGHDFxt2IGWWUds5rC7WA3CdCnmsgrOAcje9zxNYmJqej2EEmL7EL/Jm2MLDOX6XI=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by IA3PR10MB8140.namprd10.prod.outlook.com (2603:10b6:208:502::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sat, 11 Oct
 2025 22:18:55 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%4]) with mapi id 15.20.9203.009; Sat, 11 Oct 2025
 22:18:54 +0000
Message-ID: <56d176c7-f907-4557-8848-5f43d25b33cb@oracle.com>
Date: Sat, 11 Oct 2025 18:18:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] After unloading the nfsd module, a use-after-free occurred
 due to Objects remaining on __kmem_cache_shutdown().
To: =?UTF-8?B?6rmA6rCV66+8?= <km.kim1503@gmail.com>, jlayton@kernel.org
Cc: neil@brown.name, okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com
References: <CAGfirffSOjQtJ=FhZ1bhmqDMtdm2UAgvo9TdJNY5hU4KJXQ+pw@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAGfirffSOjQtJ=FhZ1bhmqDMtdm2UAgvo9TdJNY5hU4KJXQ+pw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR15CA0013.namprd15.prod.outlook.com
 (2603:10b6:610:51::23) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|IA3PR10MB8140:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ec0ff59-7ffd-4a93-dd54-08de091429ed
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SndNNGJqQ2RIZnlqOHRKQjlZbFIyMTU5bkpYcy9nangrU083VFFJWVB2UjRR?=
 =?utf-8?B?T1dBZVVYWFdhWEhvQVZuVm0yUDlCQmp6aXRaY1hOTFR1eFBHTjQ1R2REbE91?=
 =?utf-8?B?d0k4ZXRUZ0xDRDZTeEVFamVJVXFOZVFvczIrSkxMSU9Ba3JyVkdVOHdwQlY1?=
 =?utf-8?B?dFFxbXhCVFAxN2xzRXU1MzRqeHRjNDBhOTduNEkvdEJQRmEwVGp3NVFuRWI3?=
 =?utf-8?B?aG1LVE5DRERMczVSNFpsYS9VYTNjUWlXYVpyN3ZIMTM1cTVDSWwyQmVCa3Bq?=
 =?utf-8?B?bThuYytFOXBlUDREUEN3Y1VUMjdrZDBIWEcrbTg0L0UyaldsU1hCbmwwVWRi?=
 =?utf-8?B?d3htcEZ3OGE4NXROTWY3VnQ3OTBUY0Z5K3FzR1ZZZkdZZWtFT0JVRm5MRi9r?=
 =?utf-8?B?VVgyUE9ZN0UzbTFCamVBMVpKUEZCY3l5WjVRWlBtaGwrN3YxWHhzSTJ4Ky9m?=
 =?utf-8?B?U1BNUHlnQ21IYk9ZQU45SFNMVFF0a1NmYmhqZGlFK0ZweEd6TDBrbXFDZ2Ux?=
 =?utf-8?B?R0M4R21UWjdLYU5BZTArY24yd3M0YXFDNUdIS2ZpQWhUVTBka1gzWU1xbnZE?=
 =?utf-8?B?SlpudUxpYUpSZzFWV2svRE1iMHEvOVRwTVQzOUtRamxzQVBOMDdnZ1MwYjVI?=
 =?utf-8?B?MFFXRmZWS0RUMitUK21WTm4rWEpJY0NPcFpuTWZTZUU1YzI4d2lTMlJPOFZy?=
 =?utf-8?B?NllVZDAxb010MXdZQTZmcHpUUFAyUGVHdEpJajBIaEdtUUUvN29UdHB0NXZz?=
 =?utf-8?B?NzhtN2tlSTd4MEVFREhiWjJPc1lvamtPZXJyWFNjTmtiNUxvb0RIeEJmWVUr?=
 =?utf-8?B?U0xWMDhjaWgwSHA4WHB3cTdiWWlTalY3aXFVT2xmdk5ZQTdLYWFsWGRMdVZn?=
 =?utf-8?B?Z1l1VUxoT3FMem15U0Z2RExETHNIcC90TVdJVURLaGpNeWJSaUJKSUw5SW1q?=
 =?utf-8?B?ZlBtTG90Z1F1clRIa2M2WVFQMlpkQmpCWEdFV0VyNVpzTHR4ODJUMnUyWis2?=
 =?utf-8?B?QSsvYzFLam9VTWd0SnFIMHpRS3hjUUVpZEpIN2NieWJNcDRZT3N3d3NQU3Vl?=
 =?utf-8?B?K1YvUzR3VGIrVE9kSXRnQysxVFl6Q3VQWTRzZXkwQi9uY1lIZE9jdDlKSjBV?=
 =?utf-8?B?eXh2aUx6VHA3S21qc3dzOWY3Y1lMM2JkQmdvcUJoc0MydkF4enNnd0VmcHZQ?=
 =?utf-8?B?L3lBNVFOa1FlVjA0TThTNW9UWjBNYmhIYzc3VHJ1ZllJTGNja2dCemZrQ0pa?=
 =?utf-8?B?NnRsMVVyZVhUVHFUYXZDTFhKVE5BRWVvTGR0dWZQeUVXaG1KWXFBRGxTRWxD?=
 =?utf-8?B?N3VETFdvRWFWdEhUNWZhZ2RrekNCYnNHWnhrMmluK095dDlESU9OUnQ4VE5Z?=
 =?utf-8?B?TVl0em5GUGU1bkY2MGlKNUtWL0Raa3g2OU5wakFiRVZ5TGlCVm9NVzFnc1Zo?=
 =?utf-8?B?eHdRc1hXUFZBSEJZR3NqK1VLQzJKWFdsWHBEZ21wY01wWmlJQnVQRlRhSU84?=
 =?utf-8?B?YnVpM0hySE4vcUxRUzA5ck9sQWErdFVRRFBCYjZnZHd2aFZ4RkxNc0xsZ3Fo?=
 =?utf-8?B?aitmaVNFTHJzNWJER055MjdaY2ZyU0p4VnVOellNZncwdzB5RDkwSm9RZ2pJ?=
 =?utf-8?B?RER4Vk9FbDNaMDJBZk5mR24yaVJLVkYvZmplL0RWNkxPdzhQR0ZVcnlpZHhF?=
 =?utf-8?B?dDJyMkFCb3U3RUhYa0M1cjVTWWxjNWlqS1hCK0p5b29yWlNmb2ZzTVJGN1cw?=
 =?utf-8?B?ZVFSYzJzV0FlWlNqUEdOaDVUanNsSERNNVp1YVRQMzhDYk1ZblY4bGxJdzR2?=
 =?utf-8?B?c2h5aHE1UElROFNaTW5obE52OHI5RWhWb3czcHUzSDh3Uk5hYlNGSWozMVov?=
 =?utf-8?B?RWR6TUJpcmt4d3piRTFEWVdta1VwKzA0NjR0a3hndmdFZUpvVnUvdVNsTUg4?=
 =?utf-8?Q?y0G+Olk/Bso6q8uFgxNBDnol3OzRdhd6?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?N21RSGZYZmhmeExSS3doOHJjYkVTak5qejYvTlVVSGR3Z3JsMTFta2llNUFr?=
 =?utf-8?B?Snd3NE1GeGxXNWVVWkNCV2FzZ24wc0lTNVUzM09vam9hRE0wVnU4M2xWRm9B?=
 =?utf-8?B?cFhYYnRqcDBkY2xOZEprKzU1Y3hxT2NSNUVoT2YzM01FMmNtbU54eWhBOW9R?=
 =?utf-8?B?QW9PdE9CODFJMXZoQXdBamUzYW9KeVlmVkZWaXF4RVk1NXkwQzd4dXljUloz?=
 =?utf-8?B?T2F2dUR3bEJvRWNseFIwVkwxM0EvZnRMS3FtTmhHTmNLaUMyR2VjYis1Y1JI?=
 =?utf-8?B?cmFqY1cxZDVldTg4RUY0a1l1MFB5SVUvMGUzdWxqb1dudFp3NWE4SWo0S2tn?=
 =?utf-8?B?VnNacFFvbVMrbTJHQmJwVVF4SDhQTHJzWVFZUm9QeTloSXowa09MRDhJNi9S?=
 =?utf-8?B?L0VPNTNHa2EwVkhGSVNGWVNFN2ZqMml3bDkrR1U4OWVKZjlTS3hSdjFMbkM2?=
 =?utf-8?B?QVc0NExFUmZmV21DUXpkV1RRWjRiT2xHbWxqbVpGVzhhTEZPV0RyQXFEaUIz?=
 =?utf-8?B?dDRBTFl4WlFJZVBSTEM5eld0Z25ocm5aMlVMU01VbUNHZmd5S2JwS0tqS0JL?=
 =?utf-8?B?M0FCNmdjcE9FRi9Lam1EaG9jU2J2V3h3b3RXdzZoWWtUQU1odHVXanJDQUdt?=
 =?utf-8?B?VnZ3TTNJL2dVQjVzaXlra3pSaXU4QlYxdmh2S2cwY1k2bjJGQ2FpcTJyM0d0?=
 =?utf-8?B?UEsybmloekpRbGtmLzh6WlpsZk1Qa1c2Zm9qTEtHNklUSUR0T29xOHROK0lv?=
 =?utf-8?B?OGZFS09hN25UeXpoNENoZG5xdFFNNEFkSlc1dzVJQ3dPUjRXcGVyS1BKVzY2?=
 =?utf-8?B?RGRabm5zemJDd041dDVpZ205bjU5VVViSzQ2NU5xOXV3OTV4ZXdhelloWm0w?=
 =?utf-8?B?N0hqUTBHUnRmRG11Z1ZMaUZuU2JtOEVJQTlad3ZrRFBpN3V4bmwzZlgvSjd0?=
 =?utf-8?B?SXl3TXFUS3hobGdPaUh3T3dBNk9Wb0d2OVBzNlQ0YStIbUFBMEpUZ2kyb1p0?=
 =?utf-8?B?YVcyclJuTUpIeU9HWFhaV0lDSkZYcjBQMXhZcDhkRGVaNUNUMXgwNzZpa2tI?=
 =?utf-8?B?M2dQc2lLS2FFVUlpNi9KTkIyTWs0QTJGajBSTEhSZWh0YkU5bUNXRmhMWVdF?=
 =?utf-8?B?TkQ0THNpWHh6REdmN1N4VnlzSm5RSm5uWjl6RnhubHowT1JCKzMxUko0NWxU?=
 =?utf-8?B?dTNRcmpCRkJFWmNUemptQ1ZlOTM2U2N5OWgxcktJYzA3cDM4NGFHWko1MWli?=
 =?utf-8?B?UTdXOUFrNmwyTk5abU5ZQTB3enFGTkovTkRPa09MN3lrNzBVcWk4elo4VVI3?=
 =?utf-8?B?RmZXVDVkWmZlbXhQTGtjQnNPNGYwOEFNS29mbHNUYWF5U1JHQXVGL05xQUZS?=
 =?utf-8?B?ZHlZNFc1MVpidWVWbUdnQjFhOG1HNDlYNFp0aDlvSXdVd1dza0RTMFRrQ3pI?=
 =?utf-8?B?L21mY2Q4ZjFPdVlFR0kwcDg0SkdCb2sxTWR1bzBpbUR6SHFiQVZvazYvVWdn?=
 =?utf-8?B?NXdNNFhaanMzUEFKVGJrSUpBZEhqWjFOaGFvWCttdWxEbmFsb2JGY0RDVlg4?=
 =?utf-8?B?cGJUU2ppTTNKS0twU3l6REhNODJTU0pZODZpVzRMM2x6VTJ1UUZJWEJ6b0xa?=
 =?utf-8?B?QjZSRzB3M0xCVDh3b2Qwam5MM1V3UGs3ZFB0ejlWSFlaYmR6N0V2OGtkWUJV?=
 =?utf-8?B?aUk4cWJ6ZGttZG5EWndObnBkRnN5ZXBWblpLNWFtSTBjYXV5NDl4WEgrUjdG?=
 =?utf-8?B?UTdMbUpLRHZYUXVNRGFTeUFJZHNKU0dyNDI4NUF4d21LK3B2MnBkalQvMkhR?=
 =?utf-8?B?ck5QLzh5dkMzdUxZQ2xFalJPdjcrdmllQlppb3h4Q01hZ2xSLzJ2WDBmbm1S?=
 =?utf-8?B?WFo0UnNjRUlEazZUNkJBekh6MktRUGhsOVVQRjcyNlRudGthNkZwZ01vQUl2?=
 =?utf-8?B?L01MUkhGbzk1TkZacmQzU3pRN2Z6WEhtUnArN2pkU0dSaHd5WTBCQjdadWFV?=
 =?utf-8?B?VnR0WC9za2x4VVcxcVZiR0RuYWNDeWRRWkErbG45QXdkbG5GeFpCUmxINGcx?=
 =?utf-8?B?b3N2enJkYkpDTXJPMXFFYXpPMG1lY1RrTHRnZmdhbis2VThucktXK1FDSW1z?=
 =?utf-8?Q?YZiDT4q7Y/TKrQY648KcSQ2qh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5kqdMD1PFO12fosxxa8DoCYQegwYyYpV+SVq+MsAIT/xWsK9Kz1nZYTttHkzkS6cbfIEOVtMFqhZEFQy1Gffhu14M/o/Diy4+a+QiexuLby6fvru7bbjd/791XHegAB5BV3g5wYK4PDpP0E91yf4SvxyLUS1GUUmySZVqdVmzZKbPmW0foOwxHpTmA+Y6KrgZKycbrzo14CLGMONl1A9yxwTcLkmFaBUsL6nY7eset8jHXvF5xOZI/b91cD+7VnYQRUcly0ukdSgA4DepF/Hz79KfuZIwT527vsXHi4vLU2USsa/E2ri1xsN4KrCwG+wv6kg5oCZWp7Jsz7oZzG2l+5szIgLgTPQ15wVH2s0JucxSAGxPiIdagbh13iyqIagIL23mYCWysQPVeHDA9IHgTajYRP+G1y2lKCreVLfo+vQA8etlMsx9BrIqMgmmodS0MdR5igO4yS/hOlHqwIWQS5miJX+4Rd0J7zjddtKQtAUPeztlURwveXsspiGLBu4aDUg5wc769asA29/RROc+4X1SWiqAFajhgcVywmFFiXArfa9axmtlAUOMXrTCo0YiyFQUkIegwlZ3Y/VAO0sUcbo3GySzZDVp0jeM5BITaU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec0ff59-7ffd-4a93-dd54-08de091429ed
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 22:18:54.8014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zRUiR5T3fUZJIt6WByCyQdO/eOsHulIxdynPYzcgmZIL4vZrJmjBLqqMe8Tdsc6DnSMU4FwGJQcHfqnvbU5KDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8140
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-11_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510110128
X-Proofpoint-ORIG-GUID: MN8v6FuUVlHFHC4dhebjDfe1EkT9-EU7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX/yR6UW/E64Bk
 WCdjBoqkd7TzWKHcNZI9z1epkdXBFbjZneyd6AdXpDIOoROTxNjn8NgUNWbvyslcUWAgVZ1I1XL
 lNQnbJZk2XMezr/+MpR/2agShpOwXaNh0M4G3YsXWzrU9j/YExGQdutZrQMoZlvY5DvmPBvdw03
 lqUssjiB3ZKDEKrelgQkV7WJDLqQumzpVKlYdGozkHkvBEeoZO7sGxi5sg0jSjdUi2+ydULj6uH
 ey/QXvvV8YWpnCp2X+GrtqZcWtZpOT85quBFmozeUjfQ40VSeG9CZFZAkDlGvUTgNx+/GEWMIUA
 8SCOyzps5yPjutrWz2Nopn1lXJdKAa45z5kAKbrp6qxok0pZRCHMepVOjbohEPSYrpeY9EY964b
 jAjmdzaslqfXgXTDct+/4iL1bdJqJsZbdFa+LOJmDoBiMRCYrq0=
X-Authority-Analysis: v=2.4 cv=E7TAZKdl c=1 sm=1 tr=0 ts=68ead7e3 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8
 a=-C9UhQFvyEKMnhA-zb8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=HkZW87K1Qel5hWWM3VKY:22 cc=ntf awl=host:13624
X-Proofpoint-GUID: MN8v6FuUVlHFHC4dhebjDfe1EkT9-EU7

On 10/11/25 4:19 PM, 김강민 wrote:
> Dear Linux kernel developers and maintainers,
> 
> Hello,
> This bug was discovered through syzkaller.
> 
> Kernel driver involved: nfsd
> 
> Version detected by syzkaller:
> - Commit version: cd5a0afbdf8033dc83786315d63f8b325bdba2fd

In my Linux kernel repo, commit cd5a0a is not related to NFSD:

cel@oracle-102:~/src/linux/for-korg$ git show
cd5a0afbdf8033dc83786315d63f8b325bdba2fd
commit cd5a0afbdf8033dc83786315d63f8b325bdba2fd
Merge: ed4d6e92463e 3f39f5652037
Author:     Linus Torvalds <torvalds@linux-foundation.org>
AuthorDate: Wed Oct 8 11:44:21 2025 -0700
Commit:     Linus Torvalds <torvalds@linux-foundation.org>
CommitDate: Wed Oct 8 11:44:21 2025 -0700

    Merge tag 'mailbox-v6.18' of
git://git.kernel.org/pub/scm/linux/kernel/git/jassibrar/mailbox

    Pull mailbox updates from Jassi Brar:


Would it be possible for you to bisect the failure?


> Details
> If the test driver is forcibly unloaded, objects remain in memory,
> which can later lead to issues such as use-after-free.
> Additionally, This issue can be easily reproduced with the following command.
> $ sudo rmmod -f nfsd
> Note: Since the nfsd service is running internally with open ports and
> mounted shares, it may affect this issue. Therefore, the boot log is
> attached as a file.
> 
> Please let me know if any further information is required.
> 
> Best Regards,
> GangMin Kim.


-- 
Chuck Lever

