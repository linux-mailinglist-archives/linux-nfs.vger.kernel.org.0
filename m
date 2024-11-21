Return-Path: <linux-nfs+bounces-8180-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 046609D4F59
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Nov 2024 16:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89C131F23D48
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Nov 2024 15:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414221D86F1;
	Thu, 21 Nov 2024 15:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JLouVd1w";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RBtJzKdI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7AF1DACAA
	for <linux-nfs@vger.kernel.org>; Thu, 21 Nov 2024 15:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732201322; cv=fail; b=BLxv0ZUFatfcG2yQN621kPfatx+qaJfUOKp26VLr4+AiN+Sh+SiJJhYfFzZU9IrGqMaBv92WZM5aYnYprfCEwpaWjreVBmVq2gLwsgOl8wpqZsYktRu8+MWqBpU57GHf9QImyNAM7mx6EdMQmKHU54NttEvCngMNZHvA5y78dgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732201322; c=relaxed/simple;
	bh=y/zw6jln1Dnz0Aa+0m0PAewYwbDkWpf/Yn/1B20olzM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mQEh4OFsGt5oLyDwO+TX6htpk0nMbD7B7bzvsR4q2wMGx8pf0rnr3I8vTfC41HvBnWaOnpljhmEpCBWbP0qIr7vKZBWVfyTkGDo6bmpssQ+nRim1Fjsyz96wq1IesZzGxxO61abCWcE7hFNqJ7MmpRSoP5sIaB6w9wW6RutJzqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JLouVd1w; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RBtJzKdI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALEtVW0031736;
	Thu, 21 Nov 2024 15:01:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=lzQGdMXOkqGXsw8/XotLUA7qZj4hLpt00T7ISxoJ+Dc=; b=
	JLouVd1w+Ae6MfI+BT/i0BKqrrwWxy81iFpKn/Ae9SDwEKhn8i2igneQoiPM8Glb
	32brR0cudmxyQplZ8Q0Vh0SxE7hc/rjy7XkGOqt7S9uoIOdlwWAl606G90FBYJLc
	g0WZ/wwmj32hvQkFoMatgSNJe2CwCkC1vMXiEvlUVK9N39Imcg+T6H+sbII6P30K
	dqyMbuUJiJDTRKgI+Q5TTjPbf3hKMvGleXtcYeDJYHJ4C1auP1BRDjzUl1nbKPKs
	Yc48z+qTWS1sOcEeGJOI5TcWA1ehqni0iBXq5hhtdjGodDJ2EDXI8N6B4YYHfcSq
	mHtaGGl4L+B1K4J/3tkPNg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xkec1y5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 15:01:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALE94bj037247;
	Thu, 21 Nov 2024 15:01:55 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhubwrrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 15:01:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PnyMbyi08uzMC6qDlu4I0dA7waoY9o9w9cbnILOKLypN01wySa40YsMbkjG8T2FHiaHkMA7O2Upp/meyOL399WN6zfhk6BqkeSaZVKthj9KRs/sxE6lNvUGda3vVeHK5q2OByeGhfA2lOFvdpo3kbql0D+1pwex6CfkIz8riESCxtR9b4a0qCjAif7tGGk4s3OCkUha6Q7je92E+B/sP1KZqu+yqeCgWLkFIQ7V22Tbb06Md9o25garZ1ZLIzcoSJxWakSrsuxVMAvs/Oo194bpUszYIYK0jMwhoBSNz2yXib0zIr/lr8O07cs3PowKFLwalGgj4LweDU1zu5F/lCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzQGdMXOkqGXsw8/XotLUA7qZj4hLpt00T7ISxoJ+Dc=;
 b=JN/uYGNuFa0PN7uD6Yrht95Sc03755ftuwU+A7rH6soA266bxQPGhMsWLzdx5MZFDI8j3AzILIgyxAHL65ZU4KjnF+OUhk7p4ya7G5mxtuDCouGq3sCzCV/iyvx0LOAgHDyKj/RpYVCzaW7uloADwvKlGNdFUuzWRN3I5WhBO9tqRJ1QzTlVH1AYws1IksA5RgFNg3+nNcgzkiFLK4JOhD1WABIHUdov+mMlV7KWMrhswSuZ+tuEbtsu+POV6VPz1XaAblZ46YWHtS8tNYVblQwJTm0YB4TmMgDKVJHtYpSa3zi8JxGKyHOFYEm7H7tbZIZ6nVlKXhHLDNIoxlpKbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzQGdMXOkqGXsw8/XotLUA7qZj4hLpt00T7ISxoJ+Dc=;
 b=RBtJzKdIorU9NHo/k5+Wrb4uV7+DqU/OxdUrYQDPhkjmj69RNQ66zKH2VYV91zYqd/rNFPiZg+tHDVVgSuWFTXLyOOq4oSuiLzxaY5PFLgvbO7hjfoYmR5APSMJwf9ybgGcuSOgaoJmN17jqtWOQoN6eGzbwG8y2OPNSNSyASew=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by BLAPR10MB4946.namprd10.prod.outlook.com (2603:10b6:208:323::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15; Thu, 21 Nov
 2024 15:01:51 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5%6]) with mapi id 15.20.8158.024; Thu, 21 Nov 2024
 15:01:51 +0000
Message-ID: <bcb644fd-3fdb-4dfe-b574-0f47ffc8ed93@oracle.com>
Date: Thu, 21 Nov 2024 10:01:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: NFSD server side COPY with sparse files?
To: Dan Shelton <dan.f.shelton@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CAAvCNcDv9sts+bueJg0iTMjwTHrA8B2HDr4GRDpcOfFyrU=F9Q@mail.gmail.com>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAAvCNcDv9sts+bueJg0iTMjwTHrA8B2HDr4GRDpcOfFyrU=F9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0435.namprd03.prod.outlook.com
 (2603:10b6:610:10e::9) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|BLAPR10MB4946:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d7d7821-6343-4f94-7669-08dd0a3d6e33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWVVS2RiZXJZTG5BRElxbGVaOXNydnlXdjVMam1hSG5uMTlleWE5dXhKZkxj?=
 =?utf-8?B?R3h5ZmRjbTI5czFhRGMySUlzT3RaZnFvUERiY3NaNVJCT1VoNW9qRkEvUzYx?=
 =?utf-8?B?TUJmalV1aUd3VkJzWmpQRHltRHMyTGJob2N2UGkvQVpseXh6eklHUXVoekdi?=
 =?utf-8?B?UUJmODVtK0hEbWRlMXVMQ0pXVXVjU0FXaVk1dzRiSVVEWXJneTRDQW5ZekNq?=
 =?utf-8?B?UkpLdE56NEhsVGRMRXdVK0VEMmsxU1l1NzdseVpXOUc3N2kycTdGV0JRQzV1?=
 =?utf-8?B?elpvU0FNazJPbkQ1NHl0WElxNjBJemRLbXpnMWJpT1d4S3pGQy9KL3hBTU5G?=
 =?utf-8?B?eGxoRmFjcXJhaDZxbElrZHVHdDhpKzVjZzBsYVJuMm9LUE9xbkdSTEUwUjNo?=
 =?utf-8?B?T3V2Wkd5SnJqRUJpNFFSRW5makpNcXdzd3dYK3ZDL3VqMXhMMHFpVjl4aUZS?=
 =?utf-8?B?c0p3QkhWK3p3NDhmbUlRM2x5R2hUUEFrUHpiemx3NSt2S3pCNEpncWhjMG1w?=
 =?utf-8?B?VUZnTzZzaHpmNnVkRVhCZ3VpRFZuNTRiWFVpZ0dEMldkNWZTa0dwcWZoY3ln?=
 =?utf-8?B?V0o1dVROMTBteHA2ZnJOR3hNNEw2ZTJxYk51VzM1azQ0enpPUWNOVjhuMEV1?=
 =?utf-8?B?cGs4UFp4Q0VrYVA1ZHNwVm8zYU1OWWZwRWpwQmw5bUN6RGV6V3F1TnloMWth?=
 =?utf-8?B?b3lhWDVySTlFOTdBSk5GYmZERXZkS2pJVVlTY1BxK0xEdE5zUGJCWEc4bVVL?=
 =?utf-8?B?MXV2SVpGUWtPZklBTHFjNnJFd0FudGVFSEswdFJ6TVQ0andVZHF0R1lFTGZu?=
 =?utf-8?B?QlQxb0FXUUxxZjVwTCt3ejAyU1pUSzhEQ2M0UVYyR1RNUDNiQ1BmNnc0dFli?=
 =?utf-8?B?KzlBSGZqUkZKcFA3aDVFZDNmU2k2QXVhcWIwLzB1R2JtbkZ0QnplV0hpQlpI?=
 =?utf-8?B?NWJHMDFFa1FLRm14YlhwaFFNR0ZDd2FaUFU3TlRyaklsRnJHUFZVQzJPdFg3?=
 =?utf-8?B?SXdrK0dkZEQ5V0tuOGJBcU9QSWt1cTNNQ1lyMXZseW9TZDkrQ01RK0NFUzhC?=
 =?utf-8?B?SW5IUjQyMm1NSU4raUE5bDJoUmhFOWkrQ3hiK1hyNG5GY0luOVVtbWtKckNu?=
 =?utf-8?B?WlRSRFduWFZ5ZkdEd1JweWF5amNqMjFYbGlJcHY1NzFHdDVtUHdleTcxSy8w?=
 =?utf-8?B?S3Z2UStJMm5ETlg4bjRxNlFXRVN3L3dyNHZKcXFJS1hwa3hkL0VlRW1LU1BR?=
 =?utf-8?B?SlZJYUZaUEduT2pHdnNOMVVQOW85ejBZa2JwMDA1VDE5cGhBa2l2VGh6NDZO?=
 =?utf-8?B?V2JMcFFpUnQ4RzhGZnM1R1ZYWmNUcXhVNWJrNm45QmlWR3FaNkZSazArVmFE?=
 =?utf-8?B?UDVjdUlUalRTdGRlZUJBdnhhQ2NmZU5qVmxtYTVBV2ZBYTBQYlVaYmQvaEVu?=
 =?utf-8?B?ZktlbHcyZTJKeEs4d3M0T3lXTmVVZFlMaEpjNStPd0t0dko3MXh6OHduTSts?=
 =?utf-8?B?TldqaG1Hc3hWUUxER0YyRVU4K0VlS3NOSGFEbWxKZFVUWmt5T3Z2NGVNeFN0?=
 =?utf-8?B?TC85VzJkK2FUSHJmVEQyeWZGeWpVaWlHSW12K2gwU1V1M09zbE1NUFVJMW9W?=
 =?utf-8?B?bmU4ZTJIOVBMRGd4RGU2bDVPS3JyMGQxdVNtcG95Rzh3WHUwQmtEQ3ZOQ0Ez?=
 =?utf-8?B?RkI0MVpFZjFyazdFSEtVNnhEb25HU291V3dLUU8zN25XYnBXUlBjSnBJTEpP?=
 =?utf-8?Q?CcQt2U8P2Lr0Stgnik=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dStUMnhaWnZ5UFEwbjk3UnEvNGNrK054aCtsNTk2dHNQZjNPTS9sS0ZsdWlY?=
 =?utf-8?B?T1ZJUlNFdnVxSEo3cHNaSUhGSkc5VVBreFQxSWtITVdLUXlDMlBWOEd2RTBk?=
 =?utf-8?B?Uys4ZjB3VzdFVElGakRHYk92eWFSWEYvRkh4MndJejZudlRlQXRpb2FOSG9E?=
 =?utf-8?B?UUdKRHdGY2RJNmJ5dnh6RXVsV3UrNUx6SWgvakthelA4cmdJYU1KUGxJMmdK?=
 =?utf-8?B?TzhXMU9JNkFLRStuNlNGQTdzcVlRbE5yTldsZGp3QnVsQng3K1JVTzNOR3hq?=
 =?utf-8?B?MXhpUDlETVMzczhSY2p3d2Q4Nlh5RVJKcDd0bkZrcGdPdENxRS9HQnphY2Z6?=
 =?utf-8?B?OURuNlBsVHlQTTFWY3hWd2ZqNW9XNnJvOHBId2QxMDBIY3VpS2pJU3h5cElk?=
 =?utf-8?B?KzAxWEJ5M3lqZTN6ZVlHTlJISHZPVVFpUHhhOHRqNkJaNlNpdlZzaWo1OUlx?=
 =?utf-8?B?dThJRzVZK25sSXBFaGRKOEpDQkYwYmJHMU1OOVlCZTBpYzBsMkFiODVRTHFs?=
 =?utf-8?B?aFhhK2ROZWJoQStabGNtdzR6VjQvT0dzcXJRNjhPdWoyTWpVbnJxUG4xN3kr?=
 =?utf-8?B?VW1Tc01jcWtwYjRGTkVUU3h2dHdSNjVvTzVJS1FzYXVLMldkWDBCMjNHeWtD?=
 =?utf-8?B?Qmx1UlQva2hZK0ZWZ004czlIUlhIekVXNjVZSHAyNklMZEMvVnhITzNrQTc5?=
 =?utf-8?B?eEJhRG82U3c5aFQzZFQ0ZjFPd3pVdk42M0wwaDhEWkZKV2lVdmNwTnU0T3Jw?=
 =?utf-8?B?L2R6MDNiMElERzhUVEFMSFdMWG8wZTg1ZmR3cjhySnpjV1BqS2tRRWVYbkhL?=
 =?utf-8?B?THdEaFhhQ3BlZ0RtR1N2ZU40TDFOK0djS0s3Y0hGS1VhN1BwWENwZkJEWktR?=
 =?utf-8?B?eTNqMzhsMUM0Ykx0OTdlZE5UL3dmZytlVEdqNWJkanF6Znl3VXljTGFlZEZI?=
 =?utf-8?B?ZTNqV1o4dTBISGlOZlo3VW9XTVM1WjliRGtvUTZKRmJEM3JBaDROZ3hVeXhB?=
 =?utf-8?B?R21LcGxvTktEcmI4V3prcXBDOVNuajhXSjc3L1owK1JtY2tpaGwxSTJGQjlZ?=
 =?utf-8?B?SGNXcjlEUVVkNU0xZ1h6YUJHMkZXYzFNMzBVWEE5YnJlalA2SDdkZVdNNmRv?=
 =?utf-8?B?S3d0OVdiN1FBRW1UOFlrOXVPUWZUVHlrNUtoSVFMdFNMeEZRMmhiNkZac3dt?=
 =?utf-8?B?QzV2MGFhWHpkVUJZcmRqcWZyaE5WeGE1YXljdUlEd0dsWlNUb01CWFp4WGlM?=
 =?utf-8?B?YklRUmpsNFEvUWhyUlNadE1vVEE3K3lnRUZkWXJjMmw5V1dYU3QrWUdlRDBV?=
 =?utf-8?B?UHgra2JRZXhRbEg3YWcyOURDYVRhdm5Gdm5jbERmc2szV1pSa2FrbGZSMlRw?=
 =?utf-8?B?M3FpUE5OYUNLQkZZNVlxT0l3WHpqbVpmRU80WndRd3cxaVZrL2o5MEhJb295?=
 =?utf-8?B?N2J2eWVYOVk5dUJ5N3U3NStSUUdEWXpRRk1vMGdVVjBNVXlMT2ZlenVqOTRw?=
 =?utf-8?B?OWpSMWw2Z2pOMDJXeXB4UDNYanI1cjRIRHdMN1IyQUlDaFB4VWx1MUVYNjdQ?=
 =?utf-8?B?eEhMZkhtZWRSM0hkWWJHRU5ManVJZm1FYWxyT0g5NVQ1QzR1Qkd4L1B3ZnBl?=
 =?utf-8?B?US9DL3lQS0JKS3Y4TldNYzM4cXJYVUZpWVJoOWNZZG9SOExxMTArbjhrYzNj?=
 =?utf-8?B?MUcxUEJUY1gyemwrUDYxVnR1ZWZKRU9QYlFCWVFmVFo0cTJPYjBmRnZNc3NQ?=
 =?utf-8?B?dG1HN3I3UkQyT2tySFQvSjJtaVRMaEovVzJZSE1IMzcvZlBkN3JwL25QMlZm?=
 =?utf-8?B?azNrUHB6Z3VlT2ZLMTB4QWc3aGlaUUJnT0dYRU5oeWZiTzhENGFpTEh3ZWNv?=
 =?utf-8?B?dnBVWFlmVC9xU0pjV2k3UW5nVWJkR0N0RzNiQndrWW1KSE5BMW91QnQ4Nlph?=
 =?utf-8?B?VWZ6R2E5QlcrTW9CRWxFcHQxUnNDeGFTYXNUVkxTOXgxWmpBQ0dlZ1lHZGJr?=
 =?utf-8?B?VXA3TFZPUWxlajl3TW9NcWoxOEN5SVYya284a3llMTF3VW9ERW1ORU16OHdw?=
 =?utf-8?B?U202ai9TWmh4UWEzbXBMVmJQU3lnSk1wYjVRVkFFK09hdm9tbUxSQXpVK0px?=
 =?utf-8?B?dWNzSXNKQmtNWEhTVStlRW05YVQxK1lLWWZJQkNYSjNvZjk4L1JjREpzSElV?=
 =?utf-8?B?SUNSaEZHNkRNelBkTWc2Y3pCY2xlRzl2dVhkN3V0WTRITUx1eGo3RDdmUXUv?=
 =?utf-8?B?K3BTNzJYWnNMelQrZUpKZWgwUXd3PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cktByPt8/HaPr8WGs+frXFyx3tVR/6rzH+tdarR9aIbZPvqPMGLgBt47wOx9McmWyHPP2d0DLq40AJBfufY8YHnTkY6UDCSeYGlKZAeAkI/bRo98IzVrvKQjVKSsM9Idn8NeBmkKzhWSuaQADRc4asPdU3HPzHY1//A8T/C6rFi8lEsTE+2GmklOpuN7bKkIvoS+BOs2sEYkD+soVAvPCmd7y6BkKlzAtgipFBZhVaCuGk1n2pq1XJCeFdrHwYmR4hd34F/nGNousI/u6hJdu7KWLfBqU+faumgSyMIQGq7sM65VA5+/hAFQ2zBZp6VbMlbqjWg6r4FsCKhoCDlUrDiYsYS7ny/XCf1MvSxxGsFS+oSax0Ep3QyC00kaUTHGCc1PHP3RpxgFq+d1A2LtC2J2EUHISWFiBhASpbwzpWkbzTnwcnKIrVtJzK/RVWCEEKJCI3520tZL96rcEhnD/tBSsSabQ0r5LHSwdFeDMQ0C9/1BEM5nfwp+lngGdOO4iZPsyEat9bER57DWGlJN+EDNzNppFxcVzo4grjl+ZORKcIePUDpqNPdNrKjT6dTnUGDQTpRQk9mYNae9HiKcII7WhQ0CLpojM+QFo4giv6M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7d7821-6343-4f94-7669-08dd0a3d6e33
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 15:01:51.6557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rFf3oXyq+MRzo6tLZSwMA0kIvH/opCuknTT1ms+qxnY0zwrfOzYYBYLyrXfpO4ZHaS0TytX+CneiIs9A6xyiza7LgTaoYVaAf0JmLR0r30c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4946
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-21_11,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=870 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411210115
X-Proofpoint-GUID: GRvG8_0WqBw68bVlAfGdTw0qrEYoIuIy
X-Proofpoint-ORIG-GUID: GRvG8_0WqBw68bVlAfGdTw0qrEYoIuIy

Hi Dan,

On 11/20/24 6:18 PM, Dan Shelton wrote:
> Hello!
> 
> What will a NFSD server side COPY do with sparse files? Are holes preserved?

The Linux NFSD implementation uses the copy_file_range syscall to do the copy, which could potentially result in holes getting expanded (note that this is true for local filesystems calling copy_file_range as well).

I'm sure something could be rigged up on the server side using SEEK_HOLE / SEEK_DATA to call copy in a loop (as suggested by the "Notes" section of the man page) to preserve holes, but that's not how the current implementation works.

I hope this helps!
Anna


> 
> Dan


