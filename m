Return-Path: <linux-nfs+bounces-10695-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB4BA6980B
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 19:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46D2A7A6339
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 18:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9A419006F;
	Wed, 19 Mar 2025 18:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hfZu8ZbN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c4fBicSs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D5D1DEFD6
	for <linux-nfs@vger.kernel.org>; Wed, 19 Mar 2025 18:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742408954; cv=fail; b=eCroHSt8qShCr95Rwox7seRBSEiwLckydsfLQzaRflA7rJyJI9jV5JYKLeYOHpL+fQSD2bwpyuOVO6VSw9LiaBJxrjy4ZXe+DSniG5PBL48N/HveCQfLcHvTcDwmqOe5arbSmPL8XV3H5fsEBa/CA5wdZyrv5KlGx+jxDCxQWQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742408954; c=relaxed/simple;
	bh=3CbCzvSFEIjEmM3T9cMw0nE0UamuFSxQbBFJ/KiCQ3o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EstLYoaACtKBQUo+dV7gK3lhU8T+MWONWF0QqqHRTc6x0/l80t5YY5PQsudawi1nmOutRB27tqlxQogjnILfit//Ruwm/CPry2atuCbu8BIMGC2xAZdIJlGw9tYRFzhjJlOeD50TukjPuoDs6yaaJRAtUDx9KUBg0RR80Q/mlFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hfZu8ZbN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c4fBicSs; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JH0r5Y013432;
	Wed, 19 Mar 2025 18:29:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=naPLjx4xHWnCMiK6Z7aoPfG2a3h21FKbFGgdnKUm22s=; b=
	hfZu8ZbNw9b9rsWfab0YcYsgixWnKFr04MfKaqGlmuArYbAJ89pPQq3BmYKhZ42A
	+l9pP7F+EWXBRD/HNwLMoURUwCtBxR6P9SXE82+GrFCdFVIFVK6Q7q5HEO1coJyc
	LQJoFgTZP2kXKR6bG2jHDsGwEBH+ZNAQzL8Jlpt8sUuf/yoygn9pO096X4sHSSTR
	OyleRVFflyHD+LErlJAHipNCIKZkeKnecKB1xWwJwy/WqlePrYDE9UURrSeydaVq
	2MP1bbnkO8L0RqVL6MOq6LfVVfBub8zEbhb8oauU8mM4mH4UXrbaK79jT9BrctZh
	srvhlRyDJZbByQGO0ExABw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1n8kqu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 18:29:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52JINak3023558;
	Wed, 19 Mar 2025 18:29:03 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxc7g0qt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 18:29:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dhK005UM/K5g7BsTgzYQ1cOfFhmuL8noyGcADvJfsQz/ceuJrvb0GwCflv276jwyVAt3fqJFNg/7kXJghcPVObs07JgHb7D8srAhzqZ7cCUEbkqd2rMMivKCsyO9YJLuPMxHl10HH9O1osHcBM3XLkJk6fhwwksLLYINcT/7aNARbXOI1JNU+qel5JEIMHK6Ti77qpquYRcTSL68EwMt0fKTSBrxqIn4OMrpktZabQkzQ3qFsRNstGIMD4ePln4NCml0Up+reIuXsMr3uqWUAzWQFgTGCIu97Rjcq2uyKRDjEkP/mkOJbIYYEi6q8aNfTsDxA5iyhzBwvAtPz4ILVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=naPLjx4xHWnCMiK6Z7aoPfG2a3h21FKbFGgdnKUm22s=;
 b=tKotTzJySaaSeE6HyF1aSIx65n3TAgxPqObwyOIby1v54bmU29P1iA/spLTCBmA5sRadjVbSwq669z8CHL3Hl9EVy5t10cw4To3D2/HvwLTIgfvCNOy62ydsPYFE33VMRS4ovr4I2BqZCBbK+yrxxRL0tQLuqFIFSCT/HaiMI6tZtaN+3UGw2EyYNdDezNaGDbwDKXp4seg41ciCpU+X1gdpWalJIm6386IcBH/lzXR4fnQRvCU5jHnvqQ7feK39OkLYd2SYJ9+o2WqBgDsd0y5F6Srog/49Dsa95fmPdOQlZpydiJaXa+VvNcNUEsup1DYngIvoZeWADcz3IF/9TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naPLjx4xHWnCMiK6Z7aoPfG2a3h21FKbFGgdnKUm22s=;
 b=c4fBicSsRYAmqCRGgz7Z2YaTjrjZPCLqf3AbOjzODkdsdZviHCUmFuPM7cloFFM9HKe7ltaA18s9LLNJqd233Bs4dNO96UHLjRAP5TchWhalWtHjvFfTQzrBW0IGGiI3j4qGOEVG1Tv8TjWPOFzQd5cqNRgP0Y8qIS6EFzZCjiI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN0PR10MB6005.namprd10.prod.outlook.com (2603:10b6:208:3cb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 18:29:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 18:29:00 +0000
Message-ID: <37313734-890a-4ab6-a2f8-0ee5668c1298@oracle.com>
Date: Wed, 19 Mar 2025 14:28:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: NFSD automatically releases all states when underlying file
 system is unmounted
To: Dai Ngo <dai.ngo@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Tom Talpey <tom@talpey.com>, Olga Kornievskaia <okorniev@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <543f93fd-3b5a-4e4a-b2b0-0a1b7e1e8361@oracle.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <543f93fd-3b5a-4e4a-b2b0-0a1b7e1e8361@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR07CA0001.namprd07.prod.outlook.com
 (2603:10b6:610:32::6) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN0PR10MB6005:EE_
X-MS-Office365-Filtering-Correlation-Id: 945cc8ed-0088-48dd-d868-08dd6713eb06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHpDd1doOWRDZUc3cTFWdE4vT3F4ejlSVTMrbzA2TVNqV21wTDlNU3dVZ0Vy?=
 =?utf-8?B?bHY0UG1JTE91dnBRZkMzQzJCWHlocVIxL25WeHpoUWhRWXNFTlpNbHhwaWpD?=
 =?utf-8?B?ZDh2aUs0ZUQ1RjRTNzRPMGlQakIwL3k3SFc1K2JYMEdlU0NCbWpXaEZRa0c5?=
 =?utf-8?B?L1BiZGJxQTg2Z210V3JFOCtSYU1HeWZMWmFEVE5NVDdoQVpwWHBqNFoxWm5l?=
 =?utf-8?B?bndkN3UwTmVqZmFlUTJUYXdwTTduQWVObHlMOXh0R05UQlBSK1lnRzNmN2Z1?=
 =?utf-8?B?WWU1MzdUQ0h6SHhrSWtsK1hoeGdUUlVtbFAwblZYSk9PM0Jvb2t0WXJXeG0v?=
 =?utf-8?B?ejhaeW5xeXBZZHRySEFEbG9nSTdWNEhWSVl0VFUwWWZOWXhUclN0K3QvS1Z5?=
 =?utf-8?B?RS9iOVBQRWVTU05QRmJKVUIrUU91TXl5M2ZZTENwZ3dKK3V4WkZGYXkxRmps?=
 =?utf-8?B?UytlUURDWTA3Ni9Qc3VTSEw2V2x1dzJTNGNGR2hldlN2dm1QMUlxbE5vVDFs?=
 =?utf-8?B?TFdrdmtJRmkzVzJMa1lWVXljUENTNWp2NDRxclZVQjdvREFCV0tMY2tuQnJp?=
 =?utf-8?B?MUN3aTR4MUZMZjdrOGJkMXFka0k2VEJKZENHUjFaWEExdHlJVmg0T1hlb09J?=
 =?utf-8?B?bll4RFNzUmpzYTFkRUN5S2NIbGkvUFFBRnNJdTFPczNEWW0vOWE0d2gyS3Yw?=
 =?utf-8?B?UUtXbU1Rdm9keE9jTmNHZmZBSnJ1TDF1dVRPeG9uWjVTSnFiSjc2QXN1OTFR?=
 =?utf-8?B?MnRrQ2VGSndsSVJZd1pWUGNwNGkxWFc2bVlkaU4wM0l1YTBTZmlZbEVBalFV?=
 =?utf-8?B?bXo2SFcwNVUzdGI3dDMxODJkZnJBUFVDdnhlV3Jkc0h2NzE3anA3U0p3TG1v?=
 =?utf-8?B?TXQyQUVibXEzNGpmRlI2MVhJUzN4dTJxRUlhU0c3SlJjVnR6LytBekxIcGdR?=
 =?utf-8?B?YWxBczA1Q1N3dnhCbDl2TWdHblAyUXNJalJza2d5bFJyKzlBekpIOUc1N1d0?=
 =?utf-8?B?Z09SdVFCL1dzZzRYNUhIREhRb2dhd2o0NzJOZWpzcTA1eVlCR3RPQVowaDF4?=
 =?utf-8?B?ZzVlUHowUVlnOFdHdENEb3Q1SjBLWlN6bUVyeEtObW5CMy82Nmgvbk9vZjR4?=
 =?utf-8?B?WUxheDlRbVNxZ3JKWmZnYlA1RlZiS0tBdkpIQUlPVEl5SUQ4N0t4RUJMVFRl?=
 =?utf-8?B?aldycjlQSENsRU5veUZ1cFRiSzViS2xCMU81QW9INHBHVm4wTDRBL3d5YWl2?=
 =?utf-8?B?NmFTNG5EVHFaZVRleFRvQllqb3RnZ09nZnJIWGp6dFlvaCtiZzljNEU2amJo?=
 =?utf-8?B?TVh0L0JEMERTclI5M2F0Y1lpaHkrUDQreFZ5RW5BUmRod05oTTdrVExDbWFw?=
 =?utf-8?B?b3NsZ0tEdThPL0lqRFZJMnl1aWRaUWVzTGFMeXB0aU9ROXFESG9LMEx5QUVF?=
 =?utf-8?B?VWl3VUFGWlovNEY4U1NlazR4c3BSTEVrTVZJcjRYczRCWlFsQWFrYlNiaDAr?=
 =?utf-8?B?RTBUdUd5V2NDTjFjUUlHb2xIVzYzYzVFOUkzVHZsQ01GUU50d3JwS0E5dEI2?=
 =?utf-8?B?TVRHeHJUQnJyOWVFSmlxdFBaWWdMdzlkc3RSeXJQTktTMG9qdXNDVTN6eGVv?=
 =?utf-8?B?ODRTRndjclBjaG9heTErS1ArR2lVTU0vNWZDT0l4aXllSlJYVERIV3BCdVpW?=
 =?utf-8?B?dWhITE54SFIrU3gxMy9FQ08yVUZRN2NrV2RIMG9rcmVVQis4WVljblp3NmZn?=
 =?utf-8?B?NTFUKy83NDEwaGNaYXVUSTZaa2FhbHBycmR2VVJDSk9sSS8yc1REQklSenA0?=
 =?utf-8?B?QzRBb3ZqaUVoL2syVEpKT2NlbjRhb2hqQllNYUpIMjl1S3ZUb2VCVCthd1RG?=
 =?utf-8?Q?AxtX7R5ccKw3i?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjF2MkVRSFFkbmpYT0dkT1k1OHAzc004SFlsK3JxbjV5WmZYYlRtbllMZnB4?=
 =?utf-8?B?Qkt4V2lIcDF5SlBPeEJVWUFNcW1oWmNCbjJpZmlQTHdZRjVvaEJHTWdEbHIw?=
 =?utf-8?B?ZEtnMXdscjV5TEZBNkZzQ2hUdkdrUmRHWXBnRFhSYjRDczRwSDhVK1RhblFw?=
 =?utf-8?B?THVueDF0NzRGcHZ2azlNYldwd3R4N2dPTkxEb0l3TnBGeXpPditsV056aFZR?=
 =?utf-8?B?dThQRXloTHMvREExNGZETzNqcmVWR1RRRG5VcHkxaTZLR2tUR3pYYWs3Q09M?=
 =?utf-8?B?SUlDZzlLU0kwZnkrT2JYQlVnRi9zaUFVNVh1aDhRNGhEby9MeVU0WUZsNVpa?=
 =?utf-8?B?M29XSkkxcDNleVF4amFQeDl1U2d0OWxuZFpMWDJ1TzliS3VKTW1YVUorREs2?=
 =?utf-8?B?bUhaaTAzb0RPU1pURHBPb0F4U3JEdWsrZ0JGK05YVlQ2QVlVTG9kZ0pPcGlG?=
 =?utf-8?B?d0svZTJUelhuc2Z3WkFRVGlPNVRYSCtlMkpHR25veUNCYWJwNlVYSE9ndXBC?=
 =?utf-8?B?STAzUFNhK2MvRk94cG13K21yS29Xb0lTaUlZYWppTUROb21Sc1ltY0ljd0s2?=
 =?utf-8?B?T0hkcFN1UVBDTytST0Fuem53WmE0amN5RnNUcTRnZmVaQVNsaWk0OUxPZUdZ?=
 =?utf-8?B?VUhtWFFvNnlKUGRmZVBHT29sWmFtVVc4VmpIcldqcUtwcCtpWUt3WGtMM1Aw?=
 =?utf-8?B?dHptb0M1RmdZT0pyKy9NYVBibUJSNFZBczl3aUJiUWNhalMxNDQyVmNGRmZ5?=
 =?utf-8?B?R0RnRm9lcWVjNm9iV0FTZ0tSK3E5cjVGWFF4azdHam4wV0VFUFdSa0FRZmN2?=
 =?utf-8?B?WmdJcG80NmNXYWh4QlN1eDVMc01BRDUzUVZ5QnZtN0VIdFg3alV4TmJCUkdB?=
 =?utf-8?B?a3VjdzNuRUQxeFZqWURqWGJ2WU1hVnFGTEFPK2VKT2w5YTRQRG1jWGdFUzNM?=
 =?utf-8?B?R1R2WVRYSnVyMTI1aVBtUHVSTlZRSUQ4ZHBxVEhicEtyR3FVVTRDOUlmRUZj?=
 =?utf-8?B?aGlqUExRc0lyZk5WcmdLVUJLWkRvMWV3RE56NEpvOVdPc2dnb1hBUnhrOWNQ?=
 =?utf-8?B?RVJBM2tpd2lzS1Nya3JwTGlTOTZLSlpEWVZaQXVta3Fjbm9sOTB5NlJoYkZD?=
 =?utf-8?B?MEkwcVVrZFJKSXduSmpTV2xmOTE3ZWFlQmhoNEZyOU5qdmFPYTV4VDAwMmFO?=
 =?utf-8?B?UTR3OGhwczIrcUxZUCs1enFOeks2K1VhM0NZSmxFOUo4Y2p6SG5zQ0QrRlVZ?=
 =?utf-8?B?R29GM24rUlNiZEl2STJyWWlrcVJ6UjMzSnNCSjhVUXU0b1Zkc2h3aHROcCsz?=
 =?utf-8?B?T2FmajFjNEpsbjhJZXFYYzFzWWV0bE1WWXBpRThMQ250NEZSUFZ0THNVWC9p?=
 =?utf-8?B?WUdCY0dEWTB1OHhhWUNZNnRxT3l2ZjBCdUpZd2sxUE44aEltVkJGcVBhNVlr?=
 =?utf-8?B?QU10d05Rbm56cVhDSm0wOFoweERzNWxFS3BoMGRhd2ZmaStmWmZGZEZ1VHhs?=
 =?utf-8?B?aUFuWXJLdGFXMzlwOEZxNFcxdHBuREp4Q0g1dnhleFV4TDBPK3lldStRZlJ6?=
 =?utf-8?B?OWl4dm9xSGhJNVRTSVpBVFpKV1Rwd3RiK05jcXZaVElWRkxrVExyYWpPbWxD?=
 =?utf-8?B?bGExMExGY2oxeThoT3VtY256SEg5ZS9XUVBZLzNjK21mWGZNbGV2Sk9UWjFr?=
 =?utf-8?B?aDhPaUl2N1FGOVlDb0JMSXlTOWJvVGVEVzNNQkVXWDBmT3V6alpybXpPdmtK?=
 =?utf-8?B?T3RVc1h5YVQ3eU9nQVdoT3JhL0c3QlZiRnYyZ2xWaWk5Q3JIdWhxTkhvY1Jw?=
 =?utf-8?B?KzZGeUJFSVlkOEJROWFuUWp1S1NITW5UN3lzcWpYODdISHVJNUcvaGZQQ1dk?=
 =?utf-8?B?OCtDUHFLb2tBQXFMTXY5UG0vRnBlbVNBbjc2cFJQdisyZHlhb3dxcEpWQjBw?=
 =?utf-8?B?WU90WXlOaTF3dE1Wb2FnK3k2WlJKcHY0dzEzemJKU0t3ZFpxVTNhaXJnR29r?=
 =?utf-8?B?TVNKM3BWcWdJUjZOUW1qSEczdHFQcjZ3ZjNQZVJXWUJCVlppekZKWXFERDl6?=
 =?utf-8?B?SWE3NGNqaDBHcksxc3Jsdi83UStpZGpKZHFoV3ByZXorVzMvM0drbG1pZlZu?=
 =?utf-8?Q?IHhA/ws7clvwH7aa7z/Kw6KYq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+y7ACucEof8sOXi/ebu4aOIjForoJ45+m1u8rtotU0cx8XRdjyeI/l+E62RHnDUs1hsy+5m5XCFc8CYDoTg60lF3UCVFN6ewc1iGIwluu7lJa4K+81S+jnXFRRKTNp3mjOTjl2YHogWdR70yU4DcwoQwu5Af0EwMhVa9K1WBBkEO9mFnwgeXhA5q+ZyUJF2oBAnhlZs10w1F5ORY/qDtbK5MAhq4kOLO4NMF2x5KmN8UvKPT01NUAmrPol7DZvT0nnBfnJmtoGy96V/RurrJ/QISP2KAKyyc/OM5wFxcV/Z7MaudJFRiw62HPgjc1hefwmAYKUPGh1Av2FPQNrIGvYLJ/Yaf5jyKe4OM45M9iUEgh7CPIhvl9jV+IfCETC/k2cIiR125m0yWwFBMP9Ot7azIZtlczXSVfuLx/yNip7TIsuOE0KmV2vlQRG/GP3eGuMplcA3qCPAmyYiqLxCcadUzmSOvJVHwT250VF45eDtqdE147oOTIff9gkiqs7pl1dieg0kmeWYAa2+p9b0vpnA3JaHiLqSkaeOc1nAYygEtDvBhVL2yL4/5btSUKXMcIzzpe08a1lKrAFxrjSQgi2U7zkLRoRPT91xZOyD/5S4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 945cc8ed-0088-48dd-d868-08dd6713eb06
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 18:29:00.7879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZeYXft8YcjXJzU631wthSlWzYQP+U9HIBtwaFmV+yNoWhgSIfobJGMfiZSD2RFJVZVUEnRixEpifSoZhupqwiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB6005
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_06,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=850
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503190125
X-Proofpoint-ORIG-GUID: OLbOiKE52Buf0QEXocIiugK3Yt0yCq68
X-Proofpoint-GUID: OLbOiKE52Buf0QEXocIiugK3Yt0yCq68

Hi Dai, thanks for starting this conversation.

[ adding Mike -- IIRC localio is facing a similar issue ]

On 3/19/25 2:22 PM, Dai Ngo wrote:
> Hi,
> 
> Currently when the local file system needs to be unmounted for maintenance
> the admin needs to make sure all the NFS clients have stopped using any
> files
> on the NFS shares before the umount(8) can succeed.
> 
> In an environment where there are thousands of clients this manual process
> seems almost impossible or impractical. The only option available now is to
> restart the NFS server which would works since the NFS client can
> recover its
> state but it seems like this is a big hammer approach.

Well we could do this instead by having the server pretend to reboot for
only clients that have mounted the export that is going away. That way
any clients that don't have an interest in the unexported/unmounted file
system don't have to deal with state recovery.


> Ideally, when the umount command is run there is a callback from the VFS
> layer
> to notify the upper protocols; NFS and SMB, to release its states on
> this file
> system for the umount to complete.
> 
> Is there any existing mechanism to allow NFSD to release its states
> automatically on unmount?

Can you explain why you don't believe unexport is the right place to
trigger remote file closure?


> Unmount is not a frequent operation. Is it justifiable to add a bunch of
> complex
> code for something is not frequently needed?

I agree that I/O is significantly more frequent than unexport/unmount.
It suggests we want a solution that does not make a heavy impact on the
I/O code paths.


-- 
Chuck Lever

