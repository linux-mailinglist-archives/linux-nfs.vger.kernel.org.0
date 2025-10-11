Return-Path: <linux-nfs+bounces-15146-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 613F6BCF7F5
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Oct 2025 17:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1FF024E24BF
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Oct 2025 15:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FFF1B4153;
	Sat, 11 Oct 2025 15:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HuE3hMQb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y320Cg61"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFEA2AD35
	for <linux-nfs@vger.kernel.org>; Sat, 11 Oct 2025 15:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760196661; cv=fail; b=lfWt2hXQARhYf17TIdGYyK0qU4cjwp87M2h+tesaq3w5UPJaYoGZaR8Snn7AFYrwj0/WC/AdmKWw/wLppNxXSVIKRpE08TiCmlfhejrOVYH+dSQ3uSMqY1j0HVOxcUhRywnjohQWMEui02T9aYl96hd/CQYeeEHmMn2dZYz6vwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760196661; c=relaxed/simple;
	bh=NKZNMvgkkKttz5kGWkvT1M67ZKBhbhcGyoztdMhI6G8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f4YRvkyNi18GQqKhwLxuFnRtRgmO1/6xOZH6+ccfCVU8RPi5i/S02TFtlLx2ZT2h5O03FN3cCgVcxhaMoj9NjElM+FeCuhbk6CXsKDnTkIXUczffKLi+mfpW58BK+Nj7NnqJycrgX59P8V01qBbBFhiHaRVaNKUHE3f2b1FsnzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HuE3hMQb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y320Cg61; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59BFU3s9021923;
	Sat, 11 Oct 2025 15:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=2HW4w4swFAf0+Ee5VLkwlEvTqBHloOiF726rnXcU51A=; b=
	HuE3hMQbEvA07DiyRynEbHmLBOLsRRrYfG6Hghe0rOQnFTSLvp10dbmYbjdlgTen
	DFLruEasVS5HUsfCJv5w42roQ02zjwJ+9/rEf7gcs6goHgWCMwuDqeQXHExBK8OQ
	fkVMxGpxzz1uxQUecRiBAeBw8mswCaFdnjM5VURraisZ13FXf0BZNqFbXRLqcoMM
	f31h1YUb2uEjXZ4YJYhfGHH6aYPELNpUkLOPom2KbBrj2X7b7+F7iagnyo9eRdkY
	rgNQTtQDDr5KSawseOiI1XeFnnZCaULbpk5eAVwSiXaxmmxoYrLzNGV9elq5GDOx
	5e2xwUB6Pg33cPQdiMT2Tw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qdtygemm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 11 Oct 2025 15:30:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59BDHgdL009819;
	Sat, 11 Oct 2025 15:30:41 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011030.outbound.protection.outlook.com [52.101.62.30])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpc404g-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 11 Oct 2025 15:30:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sEnsb0ukVMA9KrhJ8OTsSHjdbOL2qwI4kbkMY2Oi+rr+qSRK0ldhDMAuidEDVfHFPxPtUGDEDEhYHqDNcAJL+cesDiQMYReNJB7iO0RSB+7GdHwfKH7zH3tPaGxtFjEAjDP7O/OsbtBn47Z99AYIcaW9J0avwWo0X4yWxZMw0mKrR/W/DX5b+fGlu+30r0Ofn3UJQ/QcMsJ7XbENhE8URljMob+rOJsNHOqU/5Y0c6XTErb2Mi4AAPmmVFrKOnhEwvD3Bk1Pira3X6HR4/RgbEsJcyo79wgcWzRK30DI6ybEZ4EJlo+BlYZx1Sx0felpSTKC26yiZe2GOpO8k9EgFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2HW4w4swFAf0+Ee5VLkwlEvTqBHloOiF726rnXcU51A=;
 b=MZxPsG9rdAbf1Jdi7az6DOWD6RQEMAZvJdDBNdyxat+TrBXH0Mz2D8jfKPHwSxEi2LgMT+lL+ptSi9I5G/UdNk9/g5W01JO2d8PQgAz3MYOi3sMWZ9/sA8Ehj+QhSVBLwNnFcLW4PRB0zlKXKoHm4Y5tQzO7Pj8rIJS7qxF8QViu1coZPJlWgNv6JganIP1aUUSLUC1+i7Y+g2Oj7HTrn6OUBiGGkNH1rFtvY4gokgKTMLcLjbOCbu3wh+4F48RpgzlXaBZYfIs8sBua/pQjySlZ8hHtqNFR4bQDA1s1jeC8TjED/+I54DNqvvWFaOGeFOPzWkP9YEPF5TFdCleO7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HW4w4swFAf0+Ee5VLkwlEvTqBHloOiF726rnXcU51A=;
 b=y320Cg61p5YZlCX1jlqe48f+m7/uOtMXZXI5eL4wYrBzZSgbsE1nw+CLs+cEdcpybd+tmiBNjGIQnQp4Gu9edgavIEz4GnRCe7jt3mI0btb1eS4mH2M4xsqzh8GA+1YmbyuyAKp3jtkJX40qiJFt522MrqXsquXioKCHIuHQXx0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB7131.namprd10.prod.outlook.com (2603:10b6:8:e4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sat, 11 Oct
 2025 15:30:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9203.009; Sat, 11 Oct 2025
 15:30:37 +0000
Message-ID: <1692dd6e-3b5c-4fde-bf21-24a5ca2db9df@oracle.com>
Date: Sat, 11 Oct 2025 11:30:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] NFSD: Do not cache solo SEQUENCE operations
To: NeilBrown <neil@brown.name>
Cc: Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <20251007160413.4953-1-cel@kernel.org>
 <20251007160413.4953-4-cel@kernel.org>
 <98277504-3d4b-4aff-9810-1847e6bf4030@oracle.com>
 <175987517335.1793333.17851849438303159693@noble.neil.brown.name>
 <711bd35a-78b3-4309-9cb7-9e2c7a83a87e@oracle.com>
 <175996099762.1793333.16836310191716279044@noble.neil.brown.name>
 <468cdcfe-971b-4ed7-a7ef-b1d70117a579@oracle.com>
 <176005255127.1793333.10926466897571153606@noble.neil.brown.name>
 <c302bfe7-1503-45c6-8388-6c6f1cd1b5f4@oracle.com>
 <176014414963.1793333.15458960142917474536@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <176014414963.1793333.15458960142917474536@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:208:36e::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d697fb0-96ee-45e0-14af-08de08db2099
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NTVkb0FEUXZGaVhGWjA3T3ZlS1dZN2p4SU11d005N2NVNDY5b3BMV3dWajZ3?=
 =?utf-8?B?Q3ljci9RZnpGS00vQmZjZ0F0Q1hGUjNQeEN2QzV4MHRxNWdLRjBySEF1blpP?=
 =?utf-8?B?MFpGTTRPbzhYaldWS3Z4cUkyMlJlYVQzU0RkNmgyTEwxY1J1VGQ2d1FWdEZp?=
 =?utf-8?B?M2lzYll1dmlxYkJSRDVGNGlTRHR0WUdaRnFXNEFwSTdsUVFzbXhnN3VOZHVa?=
 =?utf-8?B?K2U0dy9RYVdHQ0RuVjRablpUTHpQNkNqLzBBbWVXdzhhb0IyWFdHVm43dk5q?=
 =?utf-8?B?NzlNSXRvVjZLSEE5V1FnZEgvQTcyd3d3dG5GU0wydjh1cmNCTUZpajk4V24y?=
 =?utf-8?B?VHJ5U0ttTERBcVN5dTdHTEhuUWlCSkp0RzFhL0VicUhDSS9QVzZLY0s5NTdn?=
 =?utf-8?B?SVBYRmhXODBaRFVkdVFDWWVmTHNrZkFNY1prbEU3RXUrUWVndE1vMEFIV0N2?=
 =?utf-8?B?b2g5TEhpN2RtNE1kek96aEhYSkJXRVpPWG40dUNpNlFFd0RVcllvRC9qZUZM?=
 =?utf-8?B?K0FSUnJ2eFllU0dVY003WXQzU3hSR1JBL1FFOXVRMmc5M0VmTnJucEVtN2NV?=
 =?utf-8?B?VEdqSVE4NDhuTEJjRGwycWZpRGxqQnFRd2ZHQ3NLZU5VYWFTTDVXc05CL2w0?=
 =?utf-8?B?TXQrQVhleGRiR0Z0MFh3Uk1ZV1ZQR3lMb3dqSG5GeHBrYjAxR3RhZHd0c08y?=
 =?utf-8?B?eDhxWkk3Sy9IbVZ1em9HTUt3aGRCTlIwUk5xOEduUXRrN2dnbld5V1pnb0xP?=
 =?utf-8?B?emxNUkRvOVRHWjhVZ3BrZW92TmI4SzFrNDVZRHJ1ME5PQWVyNCtMNWJYUmhX?=
 =?utf-8?B?R0dhQlhJQm16UTZWdHNFRm1GNDE0UjY5OXROZkZsY09SUHVyejBhdVNZZFp5?=
 =?utf-8?B?dDFRTVIwSEY5SXlmVFBRMzhoN00wWlptNk1HOUpjSmV0ZjlmOFBKZ0RTdURB?=
 =?utf-8?B?QTNWVVpEODhub3F4U3J3ZjhPekNZaVFOQk53K1JOZHRCbTErbDA2NXZsZ1pG?=
 =?utf-8?B?MG5hQTZRTkJTb1pvNUptejF6b25SVVhwQzVtUU9zNGVQNCtmbTdJTDZUTERu?=
 =?utf-8?B?Y2R5bE5TVkU1NG9TcjZsMU5jcUYxMTlKekZHZ0xKRmRCZEcxb21RaHZoRzN1?=
 =?utf-8?B?dnJ4UzRJQ0p3NWxuRVVvYVpRZXozbVpBb0Q0TzlpbndMZG9hMCtkdC9GZ2VD?=
 =?utf-8?B?NG9kQXg2WWM5TjhXR3ZySkNTSWlFMDVNeDJrcUZKVTNFNEJFWUxpVHlRcENR?=
 =?utf-8?B?UjhlSzFjd3Z3VnhGZS9YTjdOTmJDQUFvWDV1dSsxTzlVQlNscytCUmFYeUE3?=
 =?utf-8?B?SEJocjZ2OXJ2M1pVbEFFVnBPRU5iUkMvOGVDYUhYVEY3NUxhdTRKSkQzemJi?=
 =?utf-8?B?QjhDNUc0OUY5R3kwV0x0Z1czNTVyaGpBeUZJRis3Y2ZvclRCY0xxOEJaUjJa?=
 =?utf-8?B?WkkwaTMvNjE3dTdmTUcxQXk1LzJtQWxwZmxwSjdtb1VLbStSSDZkVzk5eXBT?=
 =?utf-8?B?dU5veFlySSt4aVpBcUJoaXl2VnY0UDdKdCtYb1NVMGdrTXdMUnYwb0lYWnB2?=
 =?utf-8?B?YkdMc3Q2dXFZSEFDS29jdFAzdFpvT0ZxbWx1MTZYVDZ1V3lwaUJ5K3FkRTNZ?=
 =?utf-8?B?OU5rNWk1V2E0SmgzbGNZUWJnemkzWkRvZzNLY1grQVJMWHFpMklKWHpYTTlr?=
 =?utf-8?B?YkROU2N5d0VvbjB6dkVsWjNzZmozWEthdFdSV1lzZmZDS1JrVjRwZHBiUHJa?=
 =?utf-8?B?QzM0VEZNNFhuenIyNXNRZGtqa3hHMGg4UjFVU1JobEJDQ2N3VzVYN0MrS1I0?=
 =?utf-8?B?cEJzRDJRR29xbGI2bkN6d3Rtb0FRTlhMUHJCYWVXU3lYUlZ6OUxyalNLUGZk?=
 =?utf-8?B?V0pWOWc3VEljT1lzQVVQVmtnd2wvVm5HRjlreklkVUErYWFwWmpjRmt5alNO?=
 =?utf-8?Q?l2mtXQgPBi/+jK7z8O4/jklQK4YWG8x0?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?eG9ET2FCQjVEbXhNUldOQlNwT09UUVluaHJzL2tUckJ5UEZtemFpVUlCa1BI?=
 =?utf-8?B?RUlxdnFtSlVQb0FKSStrc3lSdEZEZkhKbkNocVowVEhmanJUR2s3N3JUZGZC?=
 =?utf-8?B?NnJtRXhwbm5BeEsvc1FHaGthbndTNEI5S05hblVHZjlwWU1rdDFwbmJMT1Jm?=
 =?utf-8?B?UkhYLzF0c2dZOENpSmZtMERjaEJlY0NiRjdTcVRsblFBTFVQMHloMlZpK0Ny?=
 =?utf-8?B?blhSakN2RGl4blZwUlhURVNOQXVqcEk3VjJHYkkyRWNidHZsdVV2ZnVTUUlK?=
 =?utf-8?B?MFRBNnBNbVQ5RFlPMHp3Qkp3RFBaUk9maFpHWmVQSUdjYnp0TUtzbElTNFQv?=
 =?utf-8?B?ZGl0ZFJoYmVZZmpRa0lSbEJlQUsvME51NGdrSmpyYUFFMzQ5WTZFRnlnVXBG?=
 =?utf-8?B?ckFyb0lxZFhFRUczU3k5UEFONFZSbW1MUmdtaERkSjFHYXlWRDlKZEhHSGN4?=
 =?utf-8?B?ZXlvUzVjNXZRdWcrWWZUem9VUmFBc21FdVFYK3JMVmNYcG1tWnQ3Snova3JU?=
 =?utf-8?B?R0JnVDNKUEVtSXFlTXkrYzVmcW5KYTNqRlIxM3BFTGt5TXdSMDBSVVBoM082?=
 =?utf-8?B?cU5hNlN2ekJaMFV4OWIwOUJtbmQrTzZBazFxKzVNRVJTcEdCOGluYXQzUkdz?=
 =?utf-8?B?Z3ZmQ1ArVkYrcm42cHF0VXdkQVdiUnhHMjBkTG12UTlTZzRSbGFsZU5uVjB5?=
 =?utf-8?B?QnJrQTFDUXVZNWNiNGlNSDV4eXp1bFRvcWFFTyt2bTF0dVN5U1BmbXhVMjNT?=
 =?utf-8?B?VlQrNzNFeVBCd3Y3NmN1L01KZ3RIWUdSL1N4K0NISXhHVUtEbVVSUlJEVEEr?=
 =?utf-8?B?aTd6eEtYbDgyYmIwcXVDQ29lWnVkZVVuS2JuMWZkNFd6WGhJclRoL1FCa3ZE?=
 =?utf-8?B?bDI2WG5XMm1EUzc0UENFNkpWMldMMDd3LzRXL0ZIVzV2Zm9GdDBmdU1qZ0Zs?=
 =?utf-8?B?UFpVajhvQmJNbTJFc0psaVdiY2YzTG5iRkhZMVRJWXNJYTZxSjk2TTlHY3pQ?=
 =?utf-8?B?akRSdE85N1RHRHlJQktVeVp2eTJuS0l5bU1OSXJ3Qlh6TVZPdy9JeGRCY0JE?=
 =?utf-8?B?N3d0cWhjdEt6SGtHMXA5bE5RTlFJNXBYYmNJQXZxTkh1aWlxaWRsempKNnVl?=
 =?utf-8?B?cU05dExSWWRjZnRaWWMxZEtpVEZyWjBERjl2SVdwV1U0bmFYY0NFS1V2WDl5?=
 =?utf-8?B?VFBsUmhWcWE2ZWF3eVpiQXpTMU1HUGN5NnlmMGhhVmV0dkplVjFiL3ZmMDJW?=
 =?utf-8?B?NlBBakREN2lxTjRFZURiNjN4RUVrZkZvSmNQUzhsaHJZR1hLUm8vdk5YRkFU?=
 =?utf-8?B?RGRlbHdOcFVlQ1pnUkprMlVxTEM5aUdOL0Y5SzhKRmlYU2Y5L0pzMEp6RXAv?=
 =?utf-8?B?OGI4WXVmVUVGeUtVZE1zbDB4QWlqYjNMZVdzSE5xK0k4Mjlhb2hjbTM2Ri9U?=
 =?utf-8?B?VkVkS0tob2pLNHdNZm9uZENEa3MrUFUvbTRueHVVTjlZV0xBSUtaQ1I5MkE1?=
 =?utf-8?B?RXlYTmlUVytsdzh1MHc4SDBkcEVOL1hOUDdzWWxlL1AzUWpYd24vVStBRFJm?=
 =?utf-8?B?NUV2UGNmT0toMWh0S1dPQzZveE9QMVJTWDQ5eGFYZTRiNDkyd0FqMm55VHJC?=
 =?utf-8?B?dVdWVTNvKzd6VWc4b0FOTFFQSUtlVUoyMndOSTZyZTlHeUpEeDlyNTltK1Nu?=
 =?utf-8?B?L09oS0JGVGdlSlliVnZjbm0yWkpRQ05Jd0tyT2dHeUtwUndpc0VrS2VuSUJi?=
 =?utf-8?B?UzBkaUorSHZnL3lBR1NZN05wcHdaemJSbHI5eEdiN1c2YStydVRjY2pWSW1E?=
 =?utf-8?B?S1daRGhCK3BWNTJrckpFS0JlSXdHSk5qY0k0Rm9rWGFjKzFpT2R6OG5TWXor?=
 =?utf-8?B?MVNwak02bW1zNm1JUkZRY0pDZ3JKTTBQbXlWcXVqeVRDUXNEdjkvbGs3SVR0?=
 =?utf-8?B?Smd0RWlqbkpWNEIwZ3ZOS2lGSmM2RjJWSnJmTHRoanBoUWMyQXhCUnFFeENm?=
 =?utf-8?B?elJnTkR0dEdhL05LQ0FhdzZnM0puaE9GRTk5UWhHdjJaMnlGVWNwWUIvbjY5?=
 =?utf-8?B?V3ovRUNwbXhVaGppSCtRbkxPUnowQnh1Z0tJcmpmWmZkQWk2MlllVllpTW5p?=
 =?utf-8?B?WEw0ZU5rT0lickVVZzI2eWxkbjI3eXZKa1kxZHYvT1o1SFNkYzRSVkt0YkNx?=
 =?utf-8?Q?AyoajDdZMcP1nkGhsJ0zQasw3+SweannLXFaae9dN1Qn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qcksHAbWRbivPuhmV40uoI/ZY4JYkBlkOi9yvsZ3nC778Dyj0knrWC8FAZDrKGq6WPJBhCO2px7TX8UN/EJPq3tgC95DLV8N2R9V0ysCtfchqIzY/Xo3gfndUbnuNfy+MdhuevD5Fg7RXQ7bzXXxWs4pCaPIZHAy/Dj1XyQ6aHxruRhUNCBLy/CR8e7MkcDeCn1NuqY3o/VfU6t4X8ncF4ZaZWQ/eKTAg/BQ715HHxuK5sojVibWLZtYXeRseIfkANjgOw0KEU42PoAUSdbsCo7QqGlrBLPQd8mN+6vdBVJ3o4Q9sSsPFupx36olowxzngzS4oaHbC1OkuGTAStrJ6mizWCzRuSJmLp/FwhUJgghwHXQOdgfm3n7AHKG+lupzPDwgQCy4+lYR7Y8KKEpZRzoctnxIVCy++KY6063IUt74cJd4ZpejL8nh2IDvV9ZxEKOphlqTmg5JaMFPe3R8zn5f5tuesoZDjSkWIvHeh5Hly0nAhWjlruBtn2vBdZPN3IvmEEEhXZvrn9hT3BplRt0Wv+B6wCMrkiguG8mIgRNSKZVUXm7GbuzlvNcYPHiWCFTXIPMFziEUHyzMK6RkHOxyOafeoecUYZGE90Qs2s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d697fb0-96ee-45e0-14af-08de08db2099
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 15:30:37.2629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lJfPT+pdy/miu6jfwlP6ECdVYjQ7xCyaT3IPzK7MXsXaJSX7z8IZdOqJdBDQ9JSThj7Ppn/jVWT6RD+WczSP+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7131
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-11_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510110087
X-Proofpoint-GUID: 4sviwIB59mH_bks7EgK_xKJgPT2VLhkB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAwNyBTYWx0ZWRfX9jRukCfzRhgj
 9Sx4syMP6UE72Y30oYdwm9HTy9l+xdyWppKfgbhtcayeYe485Vxs4qMAcxlglUa5X/LmXO/JZd7
 snK3W2XZfight2SoC8zrw7KsaVp3f/qD7QBPcIqq+cdRjNXN/O03io84gSJCnPjWBYU/CaggHyy
 5j29P094aiMmImcimVDpEMmnKVt7otwLv2PKjoSV2TZJA3SxKaYFllleETB0+NVEmkV3c3IbBOP
 o3KBZ/E/NNo38Yk4zyqObj4KtxAysVr+XJguJTUIu2fSZlB5QoOPW1yVxZjXLxZ121PwIqbuzvi
 Vr6qTHWLAYvLHD6AmTt23oMLZjdcdNgwm4cXOz+eGURxcfoNVYJKuWb/vNzoF4JCeOe276PjI+E
 bvHSXW+Jt/LUYdZY1Sgajlx62Xm489SITsMIiRfPm12cp/JMlcM=
X-Authority-Analysis: v=2.4 cv=OolCCi/t c=1 sm=1 tr=0 ts=68ea7823 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=LudsfF35UtXZkt5Aw24A:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12092
X-Proofpoint-ORIG-GUID: 4sviwIB59mH_bks7EgK_xKJgPT2VLhkB

On 10/10/25 8:55 PM, NeilBrown wrote:
> On Sat, 11 Oct 2025, Chuck Lever wrote:
>> On 10/9/25 7:29 PM, NeilBrown wrote:
>>> On Thu, 09 Oct 2025, Chuck Lever wrote:
>>>> On 10/8/25 6:03 PM, NeilBrown wrote:
>>>>> On Thu, 09 Oct 2025, Chuck Lever wrote:
>>>>>> On 10/7/25 6:12 PM, NeilBrown wrote:
>>>>>>> On Wed, 08 Oct 2025, Chuck Lever wrote:
>>>>>>>> On 10/7/25 12:04 PM, Chuck Lever wrote:
>>>>>>>>>  RFC 8881 Section 2.10.6.1.3 says:
>>>>>>>>>
>>>>>>>>>> On a per-request basis, the requester can choose to direct the
>>>>>>>>>> replier to cache the reply to all operations after the first
>>>>>>>>>> operation (SEQUENCE or CB_SEQUENCE) via the sa_cachethis or
>>>>>>>>>> csa_cachethis fields of the arguments to SEQUENCE or CB_SEQUENCE.
>>>>>>>>> RFC 8881 Section 2.10.6.4 further says:
>>>>>>>>>
>>>>>>>>>> If sa_cachethis or csa_cachethis is TRUE, then the replier MUST
>>>>>>>>>> cache a reply except if an error is returned by the SEQUENCE or
>>>>>>>>>> CB_SEQUENCE operation (see Section 2.10.6.1.2).
>>>>>>>>> This suggests to me that the spec authors do not expect an NFSv4.1
>>>>>>>>> server implementation to ever cache the result of a SEQUENCE
>>>>>>>>> operation (except perhaps as part of a successful multi-operation
>>>>>>>>> COMPOUND).
>>>>>>>>>
>>>>>>>>> NFSD attempts to cache the result of solo SEQUENCE operations,
>>>>>>>>> however. This is because the protocol does not permit servers to
>>>>>>>>> respond to a SEQUENCE with NFS4ERR_RETRY_UNCACHED_REP. If the server
>>>>>>>>> always caches solo SEQUENCE operations, then it never has occasion
>>>>>>>>> to return that status code.
>>>>>>>>>
>>>>>>>>> However, clients use solo SEQUENCE to query the current status of a
>>>>>>>>> session slot. A cached reply will return stale information to the
>>>>>>>>> client, and could result in an infinite loop.
>>>>>>>>
>>>>>>>> The pynfs SEQ9f test is now failing with this change. This test:
>>>>>>>>
>>>>>>>> - Sends a CREATE_SESSION
>>>>>>>> - Sends a solo SEQUENCE with sa_cachethis set
>>>>>>>> - Sends the same operation without changing the slot sequence number
>>>>>>>>
>>>>>>>> The test expects the server's response to be NFS4_OK. NFSD now returns
>>>>>>>> NFS4ERR_SEQ_FALSE_RETRY instead.
>>>>>>>>
>>>>>>>> It's possible the test is wrong, but how should it be fixed?
>>>>>>>>
>>>>>>>> Is it compliant for an NFSv4.1 server to ignore sa_cachethis for a
>>>>>>>> COMPOUND containing a solo SEQUENCE?
>>>>>>>>
>>>>>>>> When reporting a retransmitted solo SEQUENCE, what is the correct status
>>>>>>>> code?
>>>>>>>
>>>>>>> Interesting question....
>>>>>>> To help with context: you wrote:
>>>>>>>
>>>>>>>    However, clients use solo SEQUENCE to query the current status of a
>>>>>>>    session slot.  A cached reply will return stale information to the
>>>>>>>    client, and could result in an infinite loop.
>>>>>>>
>>>>>>> Could you please expand on that?  What in the reply might be stale, and
>>>>>>> how might that result in an infinite loop?
>>>>>>>
>>>>>>> Could a reply to a replayed singleton SEQUENCE simple always return the
>>>>>>> current info, rather than cached info?
>>>>>>
>>>>>> If a cached reply is returned to the client, the slot sequence number
>>>>>> doesn't change, and neither do the SEQ4_STATUS flags.
>>>>>
>>>>> Why is that a problem?  And importantly: how can it result in an
>>>>> infinite loop?
>>>>
>>>> My remark was "could result in an infinite loop" -- subjunctive, meaning
>>>> we haven't seen that behavior in this specific case, but there is a
>>>> risk, if the client has a bug, for example. I can drop that remark, if
>>>> it vexes.
>>>
>>> I think dropping it would be best.
>>>
>>>>
>>>> The actual issue at hand is that the client can set the server up for
>>>> a memory overwrite. If CREATE_SESSION does not request a large enough
>>>> ca_maxresponsesize_cached, but the server expects to be able to cache
>>>> SEQUENCE operations anyway, a solo SEQUENCE will cause the server to
>>>> write into a cache that does not exist.
>>>
>>> OK, this looks like an important issue.  Adding that to the commit
>>> message would help.
>>>
>>>>
>>>> Either NFSD needs to unconditionally reserve the slot cache space for
>>>> solo SEQUENCE, if it intends to unconditionally cache those; or it
>>>> shouldn't cache them at all.
>>>>
>>>> The language of the spec suggests that the authors did not expect
>>>> servers to cache solo SEQUENCE operations. It states that sa_cachethis
>>>> refers to caching COMPOUND operations /after/ the SEQUENCE operation.
>>>>
>>>>
>>>>>> The only real recovery in this case is to destroy the session, which
>>>>>> will remove the cached reply.
>>>>>
>>>>> What "case" that needs to be recovered from?
>>>>
>>>> When the session slot has become unusable because server and client have
>>>> different ideas of what the slot sequence number is.
>>>>
>>>> The client and server might stop using a slot in that situation.
>>>> Destroying the session is the only way to get rid of the slot entirely.
>>>>
>>>> But IMHO this is a rat hole.
>>>
>>> OK, I think I understand now.
>>>
>>> According to RFC 5661
>>>
>>>   The value of the sa_sequenceid argument relative to the cached
>>>    sequence ID on the slot falls into one of three cases.
>>>
>>> of which the second case is
>>>
>>>    o  If sa_sequenceid and the cached sequence ID are the same, this is
>>>       a retry, and the server replies with what is recorded in the reply
>>>       cache.  The lease is possibly renewed as described below.
>>>
>>> So the server *must* cache the reply for the most recent SEQUENCE in
>>> each slot.
>>>
>>> The language in that section seems to suggest the "cached sequence ID"
>>> is stored in the slot's reply cache.
>>> Our struct nfsd4_slot stores the cached sequence ID not as part of the
>>> generic reply "sa_data[]" but as a dedicated field.  We could store the
>>> rest of the SEQUENCE reply in dedicated fields and leave sa_data to
>>> store the replies to ops 2 onwards.
>>>
>>> The discussion of ca_maxresponsesize_cached always takes about "if
>>> sa_cachethis is set" it seems to apply only to those ops where that
>>> is relevant - it isn't relevant for SEQUENCE.
>>>
>>> So I think I would be in favour of always having enough space to cache a
>>> full SEQUENCE reply.  The decision of whether it goes in sa_data[] or in
>>> dedicated fields depends on how clean the code looks.
>>
>> IIUC the protocol requirements are:
>>
>> + solo SEQUENCE that fails MUST NOT be cached. That is currently an NFSD
>> bug, because it unconditionally caches solo SEQUENCE. I have a patch to
>> be added to this series to address that.
> 
> Agreed.
> 
>>
>> + solo SEQUENCE when sa_cachethis is false does not need to be cached,
>> but the protocol does not allow REP_UNCACHED_RETRY. This is the only
>> reason to cache a solo SEQUENCE reply. Note that the cached response to
>> a solo SEQUENCE can be constructed from existing fields in the slot. But
>> I can't see such reconstruction being clean, and it is certainly a
>> heroic case (ie, not commonly used, if ever).
> 
> I disagree.  The text I quoted strongly implies that any SEQUENCE must be
> cached so that it can be replayed on a resend. 

First, RFC 8881 is now authoritative, not RFC 5661, so let's stick with
the former.

The text you quoted refers to the sa_sequenceid field. AFAIUI, that is
a field that could be or should be saved whether sa_cachethis is set or
not.

My question regards only what NFSD saves in the slot's sl_data, the part
of the actual RPC reply message that is saved by
nfsd4_store_cache_entry() when sa_cachethis is set.


> This is not presented as
> optional.
>    "the server replies with what is recorded in the reply cache".

Be careful here. There is no usage of BCP14 terms here such as MUST or
REQUIRED. Therefore the text here is not a normative mandate of any
kind; rather this text is only descriptive. We don't have to speculate
about whether this is or isn't optional; this language is clearly not
normative.


> The code currently always constructs a new reply using the fields of
> 'seq' - the request.
> This is probably wrong.
> When nfsd4_sequence() doesn't detect a resend, it updates 
>    ->maxslots
>    ->target_maxslots
>    ->status_flags
> 
> When a replay is detected, those fields aren't updated so the client
> just sees what it send.
> The nfsd4_slot doesn't have explicit room to store these.  Maybe it should.

A few paragraphs earlier in Section 18.46.3, we have:

> The sa_sequenceid field is the sequence number of the request for the
> reply cache entry (slot). The sr_slotid result MUST equal sa_slotid.
> The sr_sequenceid result MUST equal sa_sequenceid.

Here we have BCP14 terms that are normative requirements that the server
copies the client's values to the reply. I haven't yet found text that
suggests this needs to be different when returning a cached reply.

I'm open to suggestions, though.


> NeilBrown
> 
>>
>> nfsd4_alloc_slot() sets the slot replay cache size to /zero/ when the
>> client's ca_maxresponsesize_cached is smaller than ... I think just the
>> size of a solo SEQUENCE. I thought that was the bug, originally, but
>> then Tom suggested there's truly no reason to cache a solo SEQUENCE.
>>
>> So, we could go with:
>>
>> 0. Fix nfsd_is_solo_sequence (that's 2/4 in this series)
>> 1. Fix NFSD to not cache failed solo SEQUENCE
>> 2. Increase the minimum size of the slot's replay cache to fit a
>> solo SEQUENCE
>>
>>
>> -- 
>> Chuck Lever
>>
> 


-- 
Chuck Lever

