Return-Path: <linux-nfs+bounces-10123-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 239BCA36209
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2025 16:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C1DA1894F99
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2025 15:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0CE266F11;
	Fri, 14 Feb 2025 15:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N4EWgkI6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FmPbf2uW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57535266F05
	for <linux-nfs@vger.kernel.org>; Fri, 14 Feb 2025 15:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547780; cv=fail; b=K6L9AA2Yy+lwYYuKBou2KEY2YdiAXGuAYomiyFsOnA/jIZFYk7lmewRgcrjPn9mS9ed9A9ceXUowCG0ilD81VGj9YeimLj48MiNtHCNeyIEoqBPDZXjb5xyWE5F1pWO/pRb8KTxrOk6gQkCzrE6rThY5oM7wvhph3DEN1I665Ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547780; c=relaxed/simple;
	bh=hnSaWt+0JkbzsZPJE327jdkeH5DWUtnv84/u6sxhuDo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TlufneSVJW508S4ECRRXnTsXTEjk0fbWT4gBeN270dMFH8H6u+nkeeXc0FRu0mqNcvT3TlpqCb5vPcEdUDHdUXPMLniMNm4Rzz+0imrI7yill3q16s19we1BGyYczzO07JTEaa5RgOmNELPA15Zk26z8xvO4HgTHOrWE8l+SZ5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N4EWgkI6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FmPbf2uW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51EFBXoR017832;
	Fri, 14 Feb 2025 15:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ceWDc4eTwbqs2BfoHizBHHVTyaYwKJ/ZT/SymEq/MsQ=; b=
	N4EWgkI6W6iiUvotMSTLIAR6mnaGBmzMCHmuAFaj//dcKdIh6oOWxf5uM9d2J6hf
	pStn8VPWB8XNVukbsaejyk/GXr/Mu9R6GbAyo19PdDj6uYs6JWhnt6+Y7Em0M26x
	RxRz/n66dH5BhTPQ2PphRWyChF78EVSfMAQZsvjbEaxhU6LGVU3cSCpTR/vtt3pb
	rO0oM14FAWh7UQ2BcqT1VaJ1D5ftU9ij1W/nPNRY2vqz5K85nJYWmYCnnTkC9V8T
	ef56jfxLsTSZfzQfSKoDPubPZ6F3E5TzD+L9XwFfyC421YBdmwa8x/9gv3BeI1TC
	/MwIRy75ZuW4t6H6Imju6A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tnbucs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 15:42:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51EFNA0E005103;
	Fri, 14 Feb 2025 15:42:51 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqd95xs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 15:42:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/ydKA83rGKH/ST4ym9KeuoftSA1gCQEvg9HyzDgk4L5TJlQPp/tWrVRVp6DdbNmHivSxWbOHsx2GUaSwtvlnctLh4uylimC+lYYEuVsEFgBJAznmTfdSgh9sNKr4ixtAmwxcUf19OU8p8xnz3vInY2K3yLoTcK86xMLefQf7r3P8qC8h9YnMSuRNiIByXQhrresvaU+/+k/Ncn0ldnSDlnaSK8EJvla+fLK5kFLX+aJ9vcNDzXy8wmJ906puh7aBaum64vnhAI3wMRHhewoZk2dV1FUmeIOO0wIxgGbUo/h+1soW9VoZZHqLCuqmIZOys5RFHDhiNrXrPG+lr+Wlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ceWDc4eTwbqs2BfoHizBHHVTyaYwKJ/ZT/SymEq/MsQ=;
 b=Rsz7u1ksG8DWfOih7S31dFRWTTzZmv8USEeg/9w325UA3SxAavt/Dgw3WpP4Jj6ndZPzqGgQT6iT2y/GMlohZkU6V41RzyvDdg9PLBEfVEGBJV4sQhA5z7MPNcHPU3Z4BVQn5IjZIqdSjJVaocpx3gaagwNlwkKvYMfOkuI4B1vdJCPBqr7+6qOda3NMjCTQuglVIWOVbStf9lSKbSw4LfKaAFI8EuawUXWsqtrQIN3prVlAvaqHC1IqDTzHSrtkA1i11oM7rEEkPB+cPTYPmC5e11Pv3iNkBppYFS7ua3Emfjztizu70nmiKDyDGOz7G4xNqON3l12yPCFzQll9Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ceWDc4eTwbqs2BfoHizBHHVTyaYwKJ/ZT/SymEq/MsQ=;
 b=FmPbf2uWuJSP7GNfC8zKyD/x5y43ODNYjYp6J86onpZ7AOzaOIall6bW+9kD4Yz2Fxh2xuaIGTumhPQde02/qsd84qw+hCb21ZV39f9Zz5GirwU0+An6dwPhEcl1Ivrqnn0dWQBFpBPsA04YjL2vxmet6KuwFwWyqxEvWeAY5yM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7271.namprd10.prod.outlook.com (2603:10b6:8:f6::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.13; Fri, 14 Feb 2025 15:42:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 15:42:49 +0000
Message-ID: <1c361680-d315-4b7b-8418-bd2743c049ee@oracle.com>
Date: Fri, 14 Feb 2025 10:42:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nfs-utils: nfsdctl: dont ignore rdma listener return
To: Olga Kornievskaia <aglo@umich.edu>
Cc: Olga Kornievskaia <okorniev@redhat.com>, steved@redhat.com,
        linux-nfs@vger.kernel.org
References: <20250213154722.37499-1-okorniev@redhat.com>
 <c65ebd14-f7e1-45a8-9bc2-211440977ab0@oracle.com>
 <CACSpFtDjqhgmFO=pTY1ErZEhQZNgewo9ao+RuuGY3hm9CSqcqA@mail.gmail.com>
 <3966bb3b-50da-41e6-b097-704c56154f21@oracle.com>
 <CAN-5tyG9Z0yuCTSpG+-RCXXijt0q32XiLYFOvwhJXxcb=npkkg@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN-5tyG9Z0yuCTSpG+-RCXXijt0q32XiLYFOvwhJXxcb=npkkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:610:38::36) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: d3694d04-6524-48a6-4131-08dd4d0e3c0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZG9NSVNkdHBPQ2J6L0RTOGRlTmZvSU5ORzZjYzlHMk9RNWV3WUNpUkVKRmxS?=
 =?utf-8?B?eTdVc0kzM2RMWEQrdzhSWktLNGtiUGFDVmRSRUMvWWEzODNVNGpwZHhlZ3ha?=
 =?utf-8?B?b3hZZm1NWmNSZ3NDT0F4MWF6VDNOZ1hNdzhScTVoUm51ZHBQVmFqQnlEZThR?=
 =?utf-8?B?VEV2NTZGOFBUODhSbWhIaFJGQzNNWjg2QjQ4ck5oQlJOc0lENDdkUVczTHFx?=
 =?utf-8?B?czdUWlBUWlJqSGFXV05wa3p5cjVQaGJSVjdyZ1FUSVJ2RDZyalUvVlNLcWpM?=
 =?utf-8?B?OTBGT21WTTl5L0JZUXNhaXU5YWtvNjF5bzNaTFlERUQvTlMzNTBNRVRLWGsz?=
 =?utf-8?B?L2FMUjdhbURBRzU1bWNWU0pHdkJWNTZ3L25mVGVZNFdaME45ZWlUS1RpN2FF?=
 =?utf-8?B?RUdjYjdKY292V3M2S2cvTUxqc0dKclhkdFphSC9hejlWbDBlaXJPSytVdE1n?=
 =?utf-8?B?NWZhTkNFaDdqQjZJcXUxckdNQlFXWTg0Qy81dmNlaTFja1pHWDNKc25IYzRz?=
 =?utf-8?B?bmtWL1Y5QklrOTIzY0t3d05LOTRTNjZRbFJkYlFiRTdiYXBESmVPeE9vWWdr?=
 =?utf-8?B?bGw1enBoelFKQjBWUTN4Nmo3b2NRaWwrRzNyT1NaS1orbHZrWGg4RmFXc1pw?=
 =?utf-8?B?M003TFZpbnl4a3ZtNkNhQW1hM3d2UWMzNC9kREI5SEJOV1h5RXpjUFZTK1JW?=
 =?utf-8?B?ZG51Y3daRVZMaXc4ZmNaWXZpWVJzYTNENDA0ZEJTZllqSWpqcGdmWjR0a3hL?=
 =?utf-8?B?cGZqck1sU0VtRG1kRkI4TmZRRUpSak40c3JmTXlFdE8yaVhicXdJb05oU1RW?=
 =?utf-8?B?VDc1RlVUM0lFSld0SFE4V0RSd3phano0MU0zZW5QL2xhQko3cXlxK1ArZ3NL?=
 =?utf-8?B?NTZwMDA0Y2pCSlFMMGxTNC95YVZJWHRiem42WC94UGtaMDVWbFFLSDVxYW5G?=
 =?utf-8?B?djhDU05QajNrN1V4UUpnSkZ6aGFTNGVpRXBZZWRrdnZYL2VXWnJ1SWNpQVpw?=
 =?utf-8?B?R3A1UXJTRE00SjNKY05DelQ5b3pPdjZMaU9nenpDRnozNW5DNTZRZ3NTWTdp?=
 =?utf-8?B?R2hsWi84dkh1djVvRG1HenEzK3ZtRHFWT1NjUmhlcVRSNDZGTHJ4b291T0hn?=
 =?utf-8?B?bE80T1Q3Q0QxNU5RL1FMSW9GT3cxQnlqVHdKM05YUzR3RzcwM1FRK2oxUnpw?=
 =?utf-8?B?YldxRWkyYnJnNWtFZ1FqZEttak16YnB0Vk85ZElscGNLOFN0TDdGUzBlY2hz?=
 =?utf-8?B?T1ZUa3AvMGRZRStPVithY2YyWmxveE1xODZoVWFOZk9Temk4NUIwWUtJeGRt?=
 =?utf-8?B?elUrWjlabTlhNEx6OUs1c2p0RzVPenQrQmFLOVA1WCtldHN3eWN0VXNmdWYz?=
 =?utf-8?B?ZFY2aGpxN2xSbXp2dUF1WUVqZ1FmMjE4U3QyRUFYOEZOeEFZNjNHMm9jUmxv?=
 =?utf-8?B?YnB1TGZJM1dyYkZPcVlKMmh6cGhSMk9FS3liMW16TGxLYnMwSS9ZTWNlc005?=
 =?utf-8?B?aHZ5eTk4R2xxWFpDRnVlNDFJLzEyRHFXU0o3R1lYQlpJMFo2NCtFdlBqOU9p?=
 =?utf-8?B?VmhKS2xNZXF3cnJNdjBRTVpkWVRHdmRzSTRFTlY1TEt2MzdKRmlRTzFwdHdt?=
 =?utf-8?B?UFhYcVR1dU0zOUtWVXN2YTZ4aE5wWHQ0MzdPaHNTeHA5YTdzc2pBOER0cnU4?=
 =?utf-8?B?bm5XREtwa01WNWs0QTdFNXVHaWNLSXN5blcwZjNRcWNZTmdmNlRxaDJyaGhs?=
 =?utf-8?B?MmM5cTl0TGpWQjBmeDZoNU5oTmVZS1JSMTlQZVdxc0VBRE9uYmYrd05mbzRh?=
 =?utf-8?B?eDhkeGxJdUlsYUdYREM2bEFpaEQzRytJL2VIamJHZkZJaHZIcHU1WVdiUkN2?=
 =?utf-8?Q?cEgaNO80BUZHi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlNGNHNuWnhseFBiS0huMStpZkZpUUdybkJEcnhDU0NueXlVUnBVcEozV0cr?=
 =?utf-8?B?dWFGU29LV3VESXpGRGFrQmtaN2N3SFZwRzJaMGNuMVdaMy84SXdEdDc3WWdx?=
 =?utf-8?B?LzFJcU50dVJ3MEhBWHBwajRyWWJqdEt4OHVwckdwSjF6MUMybjM5ejQ2dEFE?=
 =?utf-8?B?UTFSazJ5alFYNEpCOTN3QlpPbDdvK1ZyUEQ3RmNTSHk0N0tqM0sxVzRRdVRB?=
 =?utf-8?B?N21VKzZxVy9qdlNaUGFsaFNjMVJNNE1SYmxsR25UMFNPN29jUk82N1RYa1RC?=
 =?utf-8?B?MU41bkZ0dTBoVHV3eHgxTXIyVDFLc2FXbG5hQ2FyV3ZEQUkzUmorWVNxTVF4?=
 =?utf-8?B?UlFjeUNxY2hBSytOdGZPR1JSS3hZeHVXNitScWNveHRvQUt3Mmw0ODhWampR?=
 =?utf-8?B?R3lSaHhmb3ZvUnJpam5qVzRWYSttUGw1ZWl5eVhlSXp2a3hYTGZFWUU0alNM?=
 =?utf-8?B?d3lKRUJaR0UyVmVpWW1SN1BtbE5BbVJkdEVMT2g0OW5yUG93TG4vM0ZsMDgx?=
 =?utf-8?B?TFZwVXJCY0xEYjBNVGVyOVh3RHBrV1FveVpoQVNHU0dERkZ4NXdYVU93ZGZq?=
 =?utf-8?B?YXNrQThONGlLZGtLRzMycDU1Y1ZvakdLcTBZMml1N1dzL3ZEa0pFSjJZY0Yw?=
 =?utf-8?B?MVdELytMaFBRVVI0TFpoTW1IekhPekRNK29DTzRrWmo4M2xUTjFFMzIreS85?=
 =?utf-8?B?UkVGandPcnFrK1puL1ZyZWgzeWpPZ3MzM0daRitRTjF1czJoUkxoRi96Uk5P?=
 =?utf-8?B?dnhuRkRHWHhHTG1kdUFnSmh5dEhId3E3Q1pTaVFzTlZMZ0VQVmE5dDU1NXlp?=
 =?utf-8?B?RkdtdHZvbmo0WDdFVXc2Vks4QURYYkFNM3g5WDN1R2svKzhndnZueFZHUmpP?=
 =?utf-8?B?ZUpkU1FleldRMzJPUUxpdE5ZRkdSYXV2RVkyb2FidlRmc1NKZTlpSmFFdEE4?=
 =?utf-8?B?QU1DUEg3eXkxeVhzWktWeGVOdTdoSU5acjBLeSsvNHhINnh3NjFkeERwOWN3?=
 =?utf-8?B?OG9aTDJub2FRTS8yTXVvVTdoYnlQMnRQajhuUlFmQkhNOVJEQnhES2FVUXFR?=
 =?utf-8?B?YUxXWFpHbFJxYnpmTURKQUxrWVhvV1Rhb3gxUVFFdU9mN1JkT050L0JvTmMx?=
 =?utf-8?B?b29pWVpLQlJDV3FPTllMSXBTRm9KQnI2NVJYVDNNTm1ZRno0a004K2xoVXZP?=
 =?utf-8?B?ZG1CZG04SVlEMXVYT3RpR2NVSXdkMUFCWEhPVDhXSnMzQ1VSMUZndlZHWkZl?=
 =?utf-8?B?bGw1S2lIZTkzWVdFdXdpZUxycVVpbHlsbm9jTTh1VGIrSTFGMnBkR1R2bVIr?=
 =?utf-8?B?RDIvNFUrN0V6WlE5QnVUNzduMFJuY3gwM2duUW5FTTJhd0ZmZXQ0bmVpOVlq?=
 =?utf-8?B?aVQ3TmNBTnlYZGpadGtOYmFVT2VYaHVvSDJKR0w5MUR4MlhMaWxWVHNoMWR1?=
 =?utf-8?B?R3JsTkpCQVZ4eXFMMHQvSTBCSS81eEdoVzZOVUlEL3p5b2ROeE51M2IxYVlD?=
 =?utf-8?B?SWFpUFBZRjU3M2RPQVdDcFZCMnRGVmU5WG9kdC84WVZwOC90ZlFKN3JmTm5t?=
 =?utf-8?B?eVgvVXhlR3c5cUFQa2RzUTlJYTlXTDVmcmtZbDl0NEt3cmpMdWEwSlp4UGth?=
 =?utf-8?B?WDlsSDRNcmR2RGQ1bzZBdWJrTGk4b09UY3NZSm9BSk9OUkxYQXNrY1dsTlR4?=
 =?utf-8?B?S0p3NS9HeUhreWU0VExxSXhvVjdtaGRUSEl5b1RaQnVKQkxZbElsMU1BdzE3?=
 =?utf-8?B?ckdZMCswK0RrNTl2eUI4L3VjMUJTQm5td1IrS1d1T0wyaHhmc0h6czVadzgw?=
 =?utf-8?B?dGltSjlmcXJ6TU9BNnFtblhwUXZSbSs0TlBERFB1eDg4OTZnZUpNaWlVM2VB?=
 =?utf-8?B?aWk0aVhEUlZHODlWK2ZIeFFZUVhVWWxCRG1PcktTWlBGV0NFYmtJT0FFbTIr?=
 =?utf-8?B?STY1S3pCTE5IUFRrenJrMEVtZ212Wll4cFBYTFAvYkFxNk54TUh4NEtqeEZv?=
 =?utf-8?B?SWhNLy81dUJONHNsL2NpdHl2RS9BamVHWGErT3oyNWZJSGtBQVVvbmRXQlp0?=
 =?utf-8?B?WFN0NytjM0dVMncrSXRWL0l6Z2xWMmsrQUp2TjhFcjZTRS93UjNEL29iTzBl?=
 =?utf-8?B?UGhNUEtsRjlROEg5c2QvdjBlZ2MvMkxjem5xTWpmVlJlRWt1a0cvNmxkcGY2?=
 =?utf-8?B?dGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FrBL7lv1X0TlTcDEmvwrbg4MErFwGuvAkcoDNLX8JP0hmfFq9VC7J7VsYMihPrB2VSFpQwrS7gTyX7RXGjvw0NsnDxGjRhAsXwDvNTFzux3I6rz+teDL19YAqL5LqIokJvnZfQdr9GcjvpZLHMSW8j3q4l+Xpu15NXhSwol3zTsaKkK2gymSUvnCeZz6vBOPxXPH669XK+af8gQlbuNQGi5DEpbkKWDF9V1bdegOfBd7XZKoo+DOWWHbmXqzMeJ+MR5HnHDNJK/jNq4AkVwFHyPnb3ZPM13FXkNG2nd3Xm844om3U8zJ3FJ1Njap8Ghx/knTJVBkhqynU/oOkF+ECoUfMfLMZp4Qz+dh7YyJxXs1ov+oge5NO8Jt4i0BuOU2yMpjpL9ECmwta+34xk+vLBk7Fu4RKUdEthyTcNBgGOjTi4HSv+thjURkC1zRxgyf3IdtAxzOrKPlCytCGyD+cUYBTCvEMUNG8Ypkfr3nghqY0F0wKTozhwPldB2olRWQZyJF8FPGTkI5EWfGgZWPW96UEU/uI+CzUtL6zZlAhODU2961a2GxlSwZmEYXtq69hFQ5TB3Ct715TRndVqhAAQEZhT9zc38pijLD2QrARBg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3694d04-6524-48a6-4131-08dd4d0e3c0f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 15:42:49.0196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: elxDv65tU5T8RutFOQljgD5/H0tHIRu3m76p1IuYVrvDd1vZC5wyLET9FWjXPrJlrJ0e2eqUD0dZ7lpMlEfqdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7271
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502140112
X-Proofpoint-GUID: DTfz8uI6ajWV1O3WQYXZgDbBekXXwVoQ
X-Proofpoint-ORIG-GUID: DTfz8uI6ajWV1O3WQYXZgDbBekXXwVoQ

On 2/14/25 10:38 AM, Olga Kornievskaia wrote:
> On Fri, Feb 14, 2025 at 9:24 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> On 2/13/25 12:30 PM, Olga Kornievskaia wrote:
>>> On Thu, Feb 13, 2025 at 11:01 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>>>>
>>>> On 2/13/25 10:47 AM, Olga Kornievskaia wrote:
>>>>> Don't ignore return code of adding rdma listener. If nfs.conf has asked
>>>>> for "rdma=y" but adding the listener fails, don't ignore the failure.
>>>>> Note in soft-rdma-provider environment (such as soft iwarp, soft roce),
>>>>> when no address-constraints are used, an "any" listener is created and
>>>>> rdma-enabling is done independently.
>>>>
>>>> This behavior is confusing... I suggest that an nfs.conf man page
>>>> update accompany the below code change.
>>>
>>> Do you find only the rdma=y soft-rdma case confusing, or do you find
>>> that when listeners fail and we shouldn't start knfsd threads in
>>> general confusing?
>>>
>>> It was always the case that if rdma=y is done, then any listener
>>> created for it does not check whether or not the underlying interface
>>> is already rdma-enabled. This hasn't changed. Nor does this patch
>>> change it.
>>
>> Not saying the patch changes the behavior. But you have to admit the
>> behavior is surprising and needs clear documentation.
> 
> Sure we can document the behavior of the any listener on a soft rdma
> interface as it's used by the knfsd. But is it guaranteed not to
> change, as the behaviour is controlled by the RDMA core not NFS?

I'm talking about documenting the opposite. Something like:

When "host=" is present, the network interface named by this
configuration setting must be present (and when "rdma=y", that
device must be RDMA-enabled) in order for server start-up to
succeed.


>>>> Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
>>>>
>>>>
>>>>> Fixes: e3b72007ab31 ("nfs-utils: nfsdctl: cleanup listeners if some failed")
>>>>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
>>>>> ---
>>>>>  utils/nfsdctl/nfsdctl.c | 4 ++--
>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
>>>>> index 05fecc71..244910ef 100644
>>>>> --- a/utils/nfsdctl/nfsdctl.c
>>>>> +++ b/utils/nfsdctl/nfsdctl.c
>>>>> @@ -1388,7 +1388,7 @@ static int configure_listeners(void)
>>>>>                       if (tcp)
>>>>>                               ret = add_listener("tcp", n->field, port);
>>>>>                       if (rdma)
>>>>> -                             add_listener("rdma", n->field, rdma_port);
>>>>> +                             ret = add_listener("rdma", n->field, rdma_port);
>>>>>                       if (ret)
>>>>>                               return ret;
>>>>>               }
>>>>> @@ -1398,7 +1398,7 @@ static int configure_listeners(void)
>>>>>               if (tcp)
>>>>>                       ret = add_listener("tcp", "", port);
>>>>>               if (rdma)
>>>>> -                     add_listener("rdma", "", rdma_port);
>>>>> +                     ret = add_listener("rdma", "", rdma_port);
>>>>>       }
>>>>>       return ret;
>>>>>  }
>>>>
>>>>
>>>> --
>>>> Chuck Lever
>>>>
>>>
>>
>>
>> --
>> Chuck Lever
>>


-- 
Chuck Lever

