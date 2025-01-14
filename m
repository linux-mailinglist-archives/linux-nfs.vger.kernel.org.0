Return-Path: <linux-nfs+bounces-9201-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 113C2A10BDF
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jan 2025 17:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AED203A06D9
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jan 2025 16:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFA61607B4;
	Tue, 14 Jan 2025 16:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IY6HCu8c";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Q/01PQ4a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276DB16EC19
	for <linux-nfs@vger.kernel.org>; Tue, 14 Jan 2025 16:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736871022; cv=fail; b=hli4kGz/bbBbWc89GMc+Vk4DEwCpVUw6A0j5TYE1NoaWkFEcYwhe4YZ55x7rCpsQuWXaS3FVpVqplyT92Ri4VKYgZMqtJ2ZgBaqHsvxFBfOYOXDU8McaGv7gK9+Ahh4qLgrrOVJLumyNJd0NIfSw/vnpU0z4zwfV2xImrM81ZuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736871022; c=relaxed/simple;
	bh=ECPl6GHgl9U6SE5fwHFVRX+4rdzwluSBKGs9mVWcOzI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t1na3LhZWle9PXwXjKTlvOHq6sj1AD65FV+Zyb7Ng15Bc8lSXrD1yrOekWDRAMFolry7le2Zqh6kjyGYeTlSYSOxl5Sl9xWvUJJ5boBrfOiFikD8dyFkmwNNQlfXhq+kPJasrhNUbAP7gyijOYpE7y+jVZw/1aOIVm3n7fpfPxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IY6HCu8c; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Q/01PQ4a; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EC0pcJ017895;
	Tue, 14 Jan 2025 16:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=2ChzpjMO7/XrSZgY/2SOJFxYpAAQnOXXCeYLOYMwkUg=; b=
	IY6HCu8cgeK+6drokp2sz4xN7TnI0BuphH20ylZhHfU2+PWSQL+HLS+GA1K8vl7t
	607njGVXIwq2GkSsRWljsCIvHP1eCSFVgtIDjkVcQoT6Ij+Xs/sxNKWZi8d8nDKI
	y5VQpOeM0SzGkYirg3bucwUxsNsKmEhNkl9hPDh+I8i5LO6k6P5qM4Ixv5mD5spT
	QBQexFggfPpYiOG1ZO1ePbtkBuTJ/+gLfXV+4i51gY/bR+09JY0k/gg+/y0Y67Xd
	ole0L7iT1JdYePCiny5WLXz9Wj0sbs3E+LknNIWCJi3x2obEY0LKlTj8cNTHGmEo
	KryF6FKWciP1uYmjgqogCg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443f7y61s7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jan 2025 16:10:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50EEa8bc036286;
	Tue, 14 Jan 2025 16:10:10 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 443f38u54t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jan 2025 16:10:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=js5DTzH5sdcqIiSOH0465pWx5qaxcppLJphGfLFnYbzAwrcqm5b1+TNMk0LDrHX06icNYLCnnAdyUxwTnpJ2iWpjFQAgT2QjUmJHpNsYyXLbdz6BH5YrdBVNPpc1g6xFWOUZMWCwk+zOsui4V0ZQl+ODNDWpYZDS6dWNvHKkX7tra4yj/BRBI22XPvo0M/eAOS885pRDRO9JqSY/95qQqbb/WClQ1jhSuELboS+EHNwT0k+aa2LgHUM27PkO+8GtwmYJ1Rj+Y4opkDzyUjiGpuwEjACcQ6yaZmUJlloRSeL4d5KMoBbj31lH9gdWhET7eDXG+IdIpyonRlBv/59r6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ChzpjMO7/XrSZgY/2SOJFxYpAAQnOXXCeYLOYMwkUg=;
 b=JKXqwcJFnperAY5U5xXGaZkARsWkeRq/f+b7pYusx6RslANLKoL/PwHQGu0PBUr6ld62usJi/j+gD+oQA9IxTwXctFlsNAk30oa4TX+RJJdGlfAmu6cbJPlR2MbS/T0WZf4HhZtdMFLHoWVClp5759UqRTuEZyMv2i39Hlu9vFwsj+2HJ4vZshicDZzpUWpzmU6JfXlI5U7ESJydsEm26IOEjcnXpYHeD1PrQ6Ma1bfGu+vd2+u2J599jq4ApsXTuNxximiMI+9/Jnhy/hEQQ4uR3BKr1LkFcvCLc4f7VnD3AcT7v8Qw49UdL+HJdZRfR4XOqcCbFhgjL+w8lsGBIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ChzpjMO7/XrSZgY/2SOJFxYpAAQnOXXCeYLOYMwkUg=;
 b=Q/01PQ4aF/VMINPXuB42wPR+dbQu6+d079Kq452A4TqDaO/+ivjcWiiCGV8uGXFyES9ogUTW++kHwOXX+m9q0gOFeao3VqwjDxxnUoCEwuJ6A87cCt96l9U9NCGsXW2XXsceRvG5aYJ/NUBroFM6BO3GLt8pevzNEvrfAbngYn4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB6867.namprd10.prod.outlook.com (2603:10b6:208:433::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 16:10:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 16:10:05 +0000
Message-ID: <42da212b-071b-4c20-b7da-97ca02413c5a@oracle.com>
Date: Tue, 14 Jan 2025 11:10:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: nfsd4 laundromat_main hung tasks
To: Rik Theys <rik.theys@gmail.com>
Cc: Christian Herzog <herzog@phys.ethz.ch>,
        Salvatore Bonaccorso <carnil@debian.org>, linux-nfs@vger.kernel.org
References: <CAPwv0JnSQ=hsmUMy0VY-8k+dANBLNkJdFJ75q9EEE+Hj0XXB8A@mail.gmail.com>
 <d54d71f7-9bdb-49a4-8687-563558eca95e@oracle.com>
 <CAPwv0J=oKBnCia_mmhm-tYLPqw03jO=LxfUbShSyXFp-mKET5A@mail.gmail.com>
 <49654519-9166-4593-ac62-77400cebebb4@oracle.com>
 <CAPwv0J=ju3fZ8C_FFeDnzzKT-ppXaLCde64hQof3=g641Daudw@mail.gmail.com>
 <cbc55c4a-ac98-4121-b590-13f32a257d65@oracle.com>
 <CAPwv0JmA+29fujmmrugY0AFdtDDqjSvn6RTHzwYNR9a4skXfeQ@mail.gmail.com>
 <75633e31-53ae-4525-ae84-1400ae802359@oracle.com>
 <CAPwv0Jk1UaHqNX27AtR+sPrCdVbckpR5ayQ-u+kZ=w3C+sOsgQ@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAPwv0Jk1UaHqNX27AtR+sPrCdVbckpR5ayQ-u+kZ=w3C+sOsgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0092.namprd03.prod.outlook.com
 (2603:10b6:610:cd::7) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA0PR10MB6867:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c530302-73f9-4770-823a-08dd34b5e8e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?clp2RS80Smlmb2lLdVB1ZTVWNnQ4My9DY3VEOHFFaXJSb1FPeWdSK3hmMVBZ?=
 =?utf-8?B?eGw1bUIzandjYitTVVFMSStlZnlzWjVMbFBXZFppOXl0eEVVQ0FrNk9UMU1l?=
 =?utf-8?B?Y01OUlhKdGtyK29yRk9qV0FlY3ExekJBTXBRblZoVjRMUjh1RGE2bStXU2JH?=
 =?utf-8?B?cVF2cHMxNUJuSU5xQ3dCVTNYVDc3Q3pNYXl1b21FMkJ4NUdLRVJJM3Q5emtT?=
 =?utf-8?B?VW5jK2IxdWEzcnZNWVplcDcxbGpCc0VXVXNuUTAwZTRaMVk0d3VSMm9tK3Rr?=
 =?utf-8?B?MWlGelhiWGhDMk9zOW5JVWdlM2I2dUxTbi81NHBnN09tdEFtZ1FkTWxyOW93?=
 =?utf-8?B?Q3RMc2NTakdXYU9uSHhCdXFBL2NGZmQxT1NSd1JDc1RsSkF3cXdsR2JPdXFz?=
 =?utf-8?B?a2JLL0R6dUxONllpb2JZVUdiZk1rb0RFaWprT292ODA3c3lTK0lURkdoNlcy?=
 =?utf-8?B?RDk4dkFRRWZSSFdFQ1FqUWFibUxyMkkzSnJ6c2lyUFJsM3BmSEVNcUdSNXZZ?=
 =?utf-8?B?SXdKTTNYQlAvM0UwaXJUSEMzWXpiU3I3Vlk5MGNYdEdHZHNLVW1hcndtZkFY?=
 =?utf-8?B?MEZQbGF5bVFFNDA4a3hoZDdpeGZIRW1uOXlGdGxldG82Y09nMlhla3BPK3NT?=
 =?utf-8?B?eG9ON1VjcjJiTlhoWlhZbHMrL0J2OGhHUUxNM21SNjZIOVkvS0pYMlVQNmM1?=
 =?utf-8?B?SFh6YUc3M3pybEJNODNWVElnQ2RvS1pRWEZDM2NOeW9tTmJCRkVsNjZnR1hw?=
 =?utf-8?B?TG5Dc0lacVVocXRadE9uMXVpWDYyUXF3MFNrM2tnR05FNTkwYUdRMVBFMUFv?=
 =?utf-8?B?ZHdlYWJYRVM3dlZpNHJiUThobWNjVW9CdDlOY3VtUnRMdk0rTXkwaDRpckVT?=
 =?utf-8?B?TnhVc2ROUnU0ei9wVlh3dGJyc1BVV0xzVjRaYlZQQy9HSVBISk0xK1NmUFF2?=
 =?utf-8?B?Q2E4UTZNOC8zYU5nSDR0aUwrVWc5RVc0YnM1d2prMWxvamNxNTNGRjFDQlpH?=
 =?utf-8?B?elhOTWEwVk94Qko0UVhVMmFMQ3RGdEEwSlVSUHVTc0hpcTBEMzRTVENXTWYz?=
 =?utf-8?B?d2U4NHVnVmJldytPRzdmbHV1eXhtSVBIWEtGc01yaEpucmVZQkxFK2Iva2F1?=
 =?utf-8?B?eVBSVUY4Q3NUZkpqU3AweVVuMnRna3lLMFVKWTgyVFNCTk1oYlhnU1E2bm1x?=
 =?utf-8?B?UkVlcVE4RU56TnJkWVBmUGs1SzJOSytDdUkrc1U4aWl4UnN5dWdHSE5ZODN3?=
 =?utf-8?B?R1p3ckpOTGRRUDZpVkVOcGlSUUNiODdnWWZtbFRsUmkwVHJEN05SY1RPTTZv?=
 =?utf-8?B?OC9MWXVsSUJHWk5kbUt5S0k5SjIyVmdmbklibit3R1hhSDlaNjY0MnpVaXEx?=
 =?utf-8?B?S2ZLQUVvK1hrM2x1K3BEUjFFWWlsY3hVQUw4VTl0YkdiWnp6NzRsKzd3UXY4?=
 =?utf-8?B?RE8zb0NyS2FoR2ZIQVBRVG1oQ3BLd3FqQkt4dldPKzE0RTJKVGZKSlZzRktY?=
 =?utf-8?B?cS85Wm8rNjNBUjErVTdvVTg3UWc3cFFTOERLWnFMMlliTk4xYjlRclZMRWZQ?=
 =?utf-8?B?bGtaazdGNDVOWmkyY0JEdXkwcW0rd0JEZmRKSFpmYUJlZGxGQVZsZWVRTng2?=
 =?utf-8?B?VjVUaFUwVmhEalBzYkFKVVVuRkhubmdLRVdoR3B3WHRQclBNbGd4Rnlmd2hS?=
 =?utf-8?B?ZjNyNjF0ZDdTSXk2MmNSdEt2ZHVnakl1aXppOFlmUXg2eEVxWGZ5WnA3T1pH?=
 =?utf-8?B?S0NQcVhuNitEYklGWVJyOThnb0RZRzQyc2p2ZDJxbDVJdU80bEExanh6WXlZ?=
 =?utf-8?B?SUVHMStQamJlMzk2WDdvdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THJldndzYU90empvbk9RSUZpa0pKV2VNNXNwZStFbG5YcTFsT0ljeUxlcTNw?=
 =?utf-8?B?WWlsdVdrTVRyS0pTb1c2SUk4TXNQTzFlYWxQWWh2ZHc4WEJMUlA4VUk3RnE5?=
 =?utf-8?B?UTd2eUZNZ2RyWlgxVnExMlAzVGtIWmVLNmgweWxlZUtUNUZZa0tRMXY5S1ox?=
 =?utf-8?B?UHg0WFJMZi9zQ1BPU21raXE4Q25tWnhrcEk0YUdiQnNRektkZWJ3RFB1aGpV?=
 =?utf-8?B?ekhJNU93ajVlbVVNalorK04rbmx4LzRpRDZ4R2tMdW94QVJ1Q3ZtZVQxc3Q1?=
 =?utf-8?B?Rys2SVNiQjJjZW9CSVdybWxSQ3ArMmVjT04zOUlsQ0F4ZG8xWmRjZUZCSnpq?=
 =?utf-8?B?SHNKd1hJMEIvclB1aVREYWZtVXdkQkgyRGhkb3oybGJzbzJlQUU0VDBZUDRT?=
 =?utf-8?B?WnRxQ0paYUtzVWxMUG1JSW1RZnExeFJlWXVLZDF3c2pBTXcvS3A5L3lGamRj?=
 =?utf-8?B?c3R5SkZxOS9WMWVnemtrODJtREJVcEtNcEtSb25ieWtGSG4wRFBCM2pTNEIx?=
 =?utf-8?B?MFFwY1dVb2RSbGthblBvRkc0Ym5RVmZtbEJEV0FoYitGK0NzL0xzNzNXRWIz?=
 =?utf-8?B?QldJeXdrNHF1aFpRZDVqNU1NeU4yc2oxNWp1akppSTBreDdvd2NNTktHYWNP?=
 =?utf-8?B?d0JqM29vdE4vR1RZbUxwZmF5eVNjQjZoZ1cvbk5pWkVpT0xpMkppSHdlOW5T?=
 =?utf-8?B?L0NweHBKNmpKSTljWG5lbHRjaFBYVEVzcWxZUlN5Y1JzRldqQ2Fwa083Rjll?=
 =?utf-8?B?eEEwejdnUHpRUzNSSXNWMlBPckVURmlkZEkvOG8wQXRlVEJCZDFIZ21yYVNR?=
 =?utf-8?B?L3VHWjl1cGo2czBtVlJYZjNramt5RU9tbEFJNVplclpLOVlHZ1habG9WZnpN?=
 =?utf-8?B?TU1YYlVIMGJjeGNrQmJyQ2x1bWN6UHkzS00zM3RjZVUwMHBTY3lvNEUrYmty?=
 =?utf-8?B?aENCSnZVOWV1YVpOMUN5T3hLanU0K3lISi93SVhtOFFmUWNGR2piNEtORXdC?=
 =?utf-8?B?cXhvZGFhcW1lK3pacHlTOFpRR3J3R1I0WG9wU1BqZml1WEsvVDhSbVBBdVJM?=
 =?utf-8?B?bTFmOXFkQmVPN0ZhcVAvMTBKUUVwQUd3eHNEcXB3L2YwNkgzRjJXTmpEdFY3?=
 =?utf-8?B?dGQ2Y0dJd2ZEeWdqSHZGL0Mrd043TElJbSttN1RYcFd1WXpTWjFobG5xVlIr?=
 =?utf-8?B?ZXA2VEJsemVnQkphYUh2K3RqYVRweG9tbEwvakhBQ1puRnF1d3QwQ2lGdFVW?=
 =?utf-8?B?azd6a0R2L3o2SXVGNE1wYTN6MFJSQmRQU2RpRm0xMzZaOUE5RHEzMDVMQTRT?=
 =?utf-8?B?ZkxiRDFwajhhRkRSOXJGbzhWd1hQOFc2cWltZnhMNldDa2l2bzBnaUpvTS9R?=
 =?utf-8?B?c2IzcGpqcTBrTVlyeVBRaHAzZHY5bjZydzdYSzFQQW41cWNDN3dZUWljSkNG?=
 =?utf-8?B?RUtSZmRYVnFWdE40SW42Tm9xS05uSVJZTFp1N0JSckZGVE9sWFM4RTQ4TE9D?=
 =?utf-8?B?eGg5VnI2MFFZa2JDbFppR3pKeTdZOExkTm81dWxuYU5BQWFhTjlob01Dejli?=
 =?utf-8?B?TXNtN3BRdXNHMDRoc3VFMXllNTF3R3d6Wk5PVkJjdER0aTZvR1FwNGlZSVM1?=
 =?utf-8?B?MnNGT1B1emFHdTJyeXNsVXhMODY1WGFXZGZnN28yZCtvbkdwQktWZXFvTFl0?=
 =?utf-8?B?Rm9XcUlOUFUvU3k3R3FBWEduSjAvbGkwOVhGeEYvcDMxTUFUaDl3RDRGOG9a?=
 =?utf-8?B?S2NNN1IwbDN5Ti9pZEJicjhKSjNjRmd0LzRiYXFrdTh1RTZLKzFYQjN1ZmFY?=
 =?utf-8?B?K1ZyUVV0LzhvaEd0ZGY2YW1XMXYvNGRYbFV3UUZhVCt6bUFXMnZSWkJjbmNC?=
 =?utf-8?B?UlpqUFNIV3Vsa2hGV3JMMFloL3d3bm5LTG5xTmtrcmVrRkMxQnpVMUNyb2FH?=
 =?utf-8?B?c0MxZUdOYzRxUnE4WGd5OWJhR3p3b0RpNUhGdkJ2OEpVN2c2czF0VXV2Y0ZU?=
 =?utf-8?B?czlUZWhMMnJkUG1FZy9sQXlhNXNwSW11aHM0S2oreHo4SXZXWnk2V281QjQw?=
 =?utf-8?B?ZTM4R3daQnhvYXptQXR5N3o1L29MTmdFMW15OXZlSC9Ca21UUE9xUEpzMzhi?=
 =?utf-8?B?bUdOcTB0OFhUTlFmWDQrK24xT1d2U3J5VzdsbUp1ZFliZjVCWUd5eGtrWVpu?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HUmj713IqlxGByIColk2hruOChN0Llrrpd5NZXgxbecIUMLDHe4Cm4pINEx765w1MHADFj+F0luRIxBk13ONw7Z73ZVyuaZGOE6n+4Xvyy0ldm+fFnwMOkksWoiKi5VRL9D0lTwlxJRImN46TtneFKqwfDeomWc9+qNummjw6FpPLlRdsvYT4jRnTxbqc93nNQZwKkXafnEtmaAU7LRM9jSZQIl24cW3XFqT0G5dzu4pNHLH1cI1aOW5Ldx5ySsfiF5yS3Kiv+AB8qRfg7+fTGvJ85amGyUSFFu+b2uCzfnEWxpJtusHXINvqeb1mK2j6XXbI9vh8vIWUTFVto/zzvoErpWqioAqaGwOZgUuUnIe01FAYzxH+p/kPTt7PK6ZjgmOLWzZq+qTgfCna5kXF0m+YVcE7mi4eKSUXy/DaYPrmn99TdLeVeXn9yFTk7kdAuKPthGzYcWsSrCXMsHgLyDEkKtwLhrc8VdYQTQNtYQASaLlN989I445GH6q0R+S8Dt6/KOxlRXPYZRtcB4cuSWEMuXaUhQDJdWtfcJnO7RomZsJEFepMVVmbTjydVmK3dT7s+BPd8vgTiafEtHlnTzfvAwlPgDN3EpeIJ5m6nI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c530302-73f9-4770-823a-08dd34b5e8e6
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 16:10:05.8835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /FItadgYkKNpmSdvIKPeMKCavvIIKauEhg90SW//VDQpHTblXPoiI99/TbuxFlpd1xWsL9HgHathEmpf/ksn4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6867
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-14_05,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501140126
X-Proofpoint-ORIG-GUID: mltqGc4e5OrhUySadc5aJgKGNbljGofp
X-Proofpoint-GUID: mltqGc4e5OrhUySadc5aJgKGNbljGofp

On 1/14/25 10:30 AM, Rik Theys wrote:
> Hi,
> 
> On Tue, Jan 14, 2025 at 3:51 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> On 1/14/25 3:23 AM, Rik Theys wrote:
>>> Hi,
>>>
>>> On Mon, Jan 13, 2025 at 11:12 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>>>
>>>> On 1/12/25 7:42 AM, Rik Theys wrote:
>>>>> On Fri, Jan 10, 2025 at 11:07 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>>>>>
>>>>>> On 1/10/25 3:51 PM, Rik Theys wrote:
>>>>>>> Are there any debugging commands we can run once the issue happens
>>>>>>> that can help to determine the cause of this issue?
>>>>>>
>>>>>> Once the issue happens, the precipitating bug has already done its
>>>>>> damage, so at that point it is too late.
>>>>
>>>> I've studied the code and bug reports a bit. I see one intriguing
>>>> mention in comment #5:
>>>>
>>>> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1071562#5
>>>>
>>>> /proc/130/stack:
>>>> [<0>] rpc_shutdown_client+0xf2/0x150 [sunrpc]
>>>> [<0>] nfsd4_process_cb_update+0x4c/0x270 [nfsd]
>>>> [<0>] nfsd4_run_cb_work+0x9f/0x150 [nfsd]
>>>> [<0>] process_one_work+0x1c7/0x380
>>>> [<0>] worker_thread+0x4d/0x380
>>>> [<0>] kthread+0xda/0x100
>>>> [<0>] ret_from_fork+0x22/0x30
>>>>
>>>> This tells me that the active item on the callback_wq is waiting for the
>>>> backchannel RPC client to shut down. This is probably the proximal cause
>>>> of the callback workqueue stall.
>>>>
>>>> rpc_shutdown_client() is waiting for the client's cl_tasks to become
>>>> empty. Typically this is a short wait. But here, there's one or more RPC
>>>> requests that are not completing.
>>>>
>>>> Please issue these two commands on your server once it gets into the
>>>> hung state:
>>>>
>>>> # rpcdebug -m rpc -c
>>>> # echo t > /proc/sysrq-trigger
>>>
>>> There were no rpcdebug entries configured, so I don't think the first
>>> command did much.
>>>
>>> You can find the output from the second command in attach.
>>
>> I don't see any output for "echo t > /proc/sysrq-trigger" here. What I
>> do see is a large number of OOM-killer notices. So, your server is out
>> of memory. But I think this is due to a memory leak bug, probably this
>> one:
> 
> I'm confused. Where do you see the OOM-killer notices in the log I provided?

Never mind: my editor opened an old file at the same time. The window
with your dump was on another screen.

Looking at your journal now.


> The first lines of the file is after increasing the hung_task_warnings
> and waiting a few minutes. This triggered the hun task on the nfsd4
> laundromat_main workqueue:
> 
> Workqueue: nfsd4 laundromat_main [nfsd]
> Jan 14 09:06:45 kwak.esat.kuleuven.be kernel: Call Trace:
> 
> Then I executed the commands you provided. Are the lines after the
> 
> Jan 14 09:07:00 kwak.esat.kuleuven.be kernel: sysrq: Show State
> 
> Line not the output you're looking for?
> 
> Regards,
> Rik
> 
>>
>>      https://bugzilla.kernel.org/show_bug.cgi?id=219535
>>
>> So that explains the source of the frequent deleg_reaper() calls on your
>> system; it's the shrinker. (Note these calls are not the actual problem.
>> The real bug is somewhere in the callback code, but frequent callbacks
>> are making it easy to hit the callback bug).
>>
>> Please try again, but wait until you see "INFO: task nfsd:XXXX blocked
>> for more than 120 seconds." in the journal before issuing the rpcdebug
>> and "echo t" commands.
>>
>>
>>> Regards,
>>> Rik
>>>
>>>>
>>>> Then gift-wrap the server's system journal and send it to me. I need to
>>>> see only the output from these two commands, so if you want to
>>>> anonymize the journal and truncate it to just the day of the failure,
>>>> I think that should be fine.
>>>>
>>>>
>>>> --
>>>> Chuck Lever
>>>
>>>
>>>
>>
>>
>> --
>> Chuck Lever
> 
> 
> 


-- 
Chuck Lever

