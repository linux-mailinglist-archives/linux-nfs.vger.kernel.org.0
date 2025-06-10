Return-Path: <linux-nfs+bounces-12256-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B87AD39F1
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 15:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 877457AA4E1
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 13:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED6B2980A7;
	Tue, 10 Jun 2025 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aDRv3+D4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hoPQ/38g"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6784522D79B
	for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 13:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749563421; cv=fail; b=UvmeINRf7FdBG2pa2oBz8A4SlEZE+PzJ24JCJnF4x/b+W7bUal5sqAYqUHl7pmkHl5ewRoqNLV8ZEyM+/6whEWxURfD4nbX8Wr2GRXY5fpiTjA9mk7Mbmai8xJ1CueDPUJ31pn7G1QPCl9HMR/Q4nQH12sXnR++hVI3G9eZHJDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749563421; c=relaxed/simple;
	bh=qagqmr9AuOIphtP405z5miU0TqqtcqiPhoxjcTXvxaU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K0Uf/7qzXCMmUEZoQcNpy1wZzxOeXz/hbLKaxClVAnLS81EWQOeZVZLc+gK7T7SFgy2RcAxr/Wg/eNE2kAFErkVzxw/6X3R6hxKAu10jThA6/M+/AdN97YimR5bJLrOn8eHfFBp39cGwsLegvpdvH0D9vUYVzbMwh3XghGFew+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aDRv3+D4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hoPQ/38g; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55ADC5fH012518;
	Tue, 10 Jun 2025 13:50:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=WMq8SNgQ76IcqLEPThCSxKdHmp13eBMKnW+j+46cXZw=; b=
	aDRv3+D44b1BrRihcCeWsaRaTu8lYJVDIlO0genlC6Rmt1y/B4ecwBuO4txg62vE
	eXjLcTwMPwRvMl7Kx9oCZNAKUYoOZrqN9L075jONvI0NdbHLZS5wLQd1spdzNT2G
	bmbQ99QOYrL4k2PR5lrY+QrHLa8f4/7sPL+l9mciFWgtZzKKfPRmf2iCY5lF0N+D
	akVGpoUlmRenJySMIDSbNDVv/BoYHw/AyUm1wSbYNmmchgz17DbUBowvHh1Yqckh
	cpuVvfFp2aNWPFlU4dZgX8BaN+T9q6fU7jge591zRY82L0RtfeRnetlwVSRY3mas
	mDVCxkez7QS8bJzhTVu/Vw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474c74vayg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 13:50:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55ACuiNF003302;
	Tue, 10 Jun 2025 13:50:13 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012052.outbound.protection.outlook.com [40.93.195.52])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bv8rytd-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 13:50:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMtMlo8z/MGbae1RWgVEpd7JqcZ/ZEX6YGdr/zV+DbNXWTTXaUlMJFAQBCSvIh1ZK04C9kv9f3KF8gMz7hj1ZqQwXi4G3NWtZhltxyducDp30fAodMNqVIsooOm6++DKWOUqObHnMeH2x8a1JoCKlpyYb4EEGSwKbkFeh5Ynx3DCPEKMqDx0ePWMsnooFUTxruHa5fBVxon9Mr87YaaWKeI8lkuEENewCq18TQl4J0+tTcET5OEq/iSiSJHlbzTtTg6CKAGGe0SxCqqNiXVyCZNT0Z9t+eMxTqiDWiS4SOVobLTpigqr+UjIMIhDyIGoYacKwObAVqwX/i4Od0WXXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMq8SNgQ76IcqLEPThCSxKdHmp13eBMKnW+j+46cXZw=;
 b=bsi4fzfbm0kpb5EUSmvPNGuffHaJL9f4Orle4wDLGI3mJ9gsY+943u7qAshcf0d0tmhC0uPCh8o0HnDjYoZEwcSSPhyoFXR1vl2VJSzRKUHxLBp757xyvUpKZedbHuAXYmYzUfYn3KC+FGHSzY0QVdc/B6U3uIggqe3ORgOn4j6u7RMycs/uKx4+TkVjS+x5aFrIpd1Fw4v8wED4UcWpfVDN40UuMsjbYyX5VwGXxHpEUQv/CCv6O68jiqHtgKI9S1avltkF2C6eQZggHM6PuaY3JmCL8TmCy9P8Q1SmNhY9VytgLFsIFWs1nt4AzPF7f6pJkLAqwe1cKIqhV/YVqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMq8SNgQ76IcqLEPThCSxKdHmp13eBMKnW+j+46cXZw=;
 b=hoPQ/38gxR3m43tROQQJcCFkmCxsP2qi4H8ZPQKk/H3B5fKGFzvI7B/Dr2OnpPfUe6Tx1ZdgEU6lLX8Irjk4t/V5YZeTlm/n9fRBUhRUHlNqIZBZ0UUb7br7u2EGEXwKbYbH19VipG2oNUgNMQ0ZOBrIHKxY90OsPymGodGOnZ4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6490.namprd10.prod.outlook.com (2603:10b6:930:5e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.22; Tue, 10 Jun
 2025 13:50:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 13:50:10 +0000
Message-ID: <0489c595-7acf-4ede-b50a-8c4e57f0b03c@oracle.com>
Date: Tue, 10 Jun 2025 09:50:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSD: detect mismatch of file handle and delegation
 stateid in OPEN op
To: Dai Ngo <dai.ngo@oracle.com>, jlayton@kernel.org, neilb@suse.de,
        okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org
References: <1749562875-28701-1-git-send-email-dai.ngo@oracle.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <1749562875-28701-1-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:610:cc::31) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY8PR10MB6490:EE_
X-MS-Office365-Filtering-Correlation-Id: 77170004-69c0-44da-8a82-08dda825b5d8
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?THdMQWVGa0NEY1NCemgrc3dKVXNXcEI1VW9sMUhqQ3U2SytxUTJza003NDBE?=
 =?utf-8?B?dms4a1AxYzBhSnBBeXZFbitqTFdCTzRNa0FsM0tSMlpmdDRYeEFhTFlyaUlp?=
 =?utf-8?B?N2VZTjcvenlxWW8zUThKUUJzeVBlbDdvRHpCRk9ITHY4YkhtLzVIOUdWUnM4?=
 =?utf-8?B?ZW5uSVJLSHYrMStNTm5LZDhqcm9RWDhRWXFuUEMrQkUvQWFlbmNUK0ZOajFh?=
 =?utf-8?B?V3lXOS9tL1JiRXEzTnVITDhnYzdDYjBucytFSTRBMTFDN1lNenY0ZGJ1alVO?=
 =?utf-8?B?cC9XNGRORE1DekdRbUZ0VmxXR2IvbWpVQmF3amJLeWUvMzU4d1BZTTA0MTRm?=
 =?utf-8?B?TjVXb1JJZjJsUFpWRjNSemF0dnZHSEJZTDlVZERXK2dzTjd4bEN5Ukk5MzBD?=
 =?utf-8?B?ZWRzbkJPVTkzYmZKL0xHVURqR0hmVHo1ZGdNcmZxRE5wS3gyTE50T2wxaVo4?=
 =?utf-8?B?WFF0Q1B6UEh0WVRJMmVWdndpTmRLdDh0UVVyZU9CcEp4WGZHbVdqK0RkMmtY?=
 =?utf-8?B?MG9zZnRIS1R6MEtMakt2dmlEUDNZMFFJSFpGNnlsVDI1RHdqRUJNUmNIbmVz?=
 =?utf-8?B?czBlMXNjUk5IckU1VVZDUnFDa2NKY1VxNzEzdnB2RVJWTkIvSHY3Mlo2SEk4?=
 =?utf-8?B?aFZPa0cxcGpacERqTTZLWkJuQWZnb1hqRmRYNStTdUZzS0p5Uk5uTGIvYk9Z?=
 =?utf-8?B?RVE3UDk2NGJmS3pBN0VDdFp0eWVyOGRHZjIrOUM1eDRzQmFRdDZtUFUzNzJs?=
 =?utf-8?B?NlNOclJITjNpd01VVW1mekVFMkZlL3ZFUVlkMGNBakwrcjk5eDk5bVREL1ZK?=
 =?utf-8?B?MDRaOG44SDh2MFdRUXdxT0RZbzArS1U2T1UvVDF1NjJuNzNQc3l4SGpsUjZS?=
 =?utf-8?B?enBRbXpMUjBZeHA4eXFTTDhFTjNQendISGRYK0tpRlVQenZ1WFFPUjJJbEVD?=
 =?utf-8?B?V1lNazB1bWZJTVFvY3MwRW5ncE02TXBCYzN2WjFXRU94Q2orbldWZGdwclZY?=
 =?utf-8?B?WlNLbWtGQWRNa1ZCUVB1cnR3bkp5Y3pmYndBUDBuZFEwZ2pPV0ZRYk9mY1By?=
 =?utf-8?B?TDF2ZHBMdlZNeEpMRVFOT2xUTFhjV2VHTTF3a2xrOXdnVWJycStQelVqOHJ2?=
 =?utf-8?B?Vy9iV3VlTFRmYmxKd05DdVNHNnZjY2JvOUt5SjQyZjdCR05DaFFRQ28zR1M3?=
 =?utf-8?B?Tzd0aWdEVzE1NmxGUFBjdGZ1R25La2FNU3djNkVzVjUvS3BhMVNFa1lrOFFK?=
 =?utf-8?B?MHpHTGxLR1RPeVkrSDZDam1pdmpEdzBuWUhOU2d1WnZ0S0FDeTY2ZDZTOExn?=
 =?utf-8?B?OGFMTDNIbWtEajZLL0ExQVhDY09Tb21IK0dOZ2dIRDdQL2IySkttR0hpNHJU?=
 =?utf-8?B?R09YZWlsTnRYdlR1bTl2TERRYW1BTUdUbWw3ZjdnTGs3N3RZNnVmNXR2UWFY?=
 =?utf-8?B?amg3UHFwVjNPYTZjR0tlVWtWbjZaN2VZUTk4OUdoR2RQUGRabzJXUzZzajRl?=
 =?utf-8?B?ZTROOElCV0R3WE9ON2poV0pYRDVHR0Ezcnc0SWdzQXBKUEtkRUhCMmdNQlZl?=
 =?utf-8?B?MGdaeDBCakdpL2lOTmY3VUloVkZNQXhYSzV4NktQMDR1RlA1aktoSWc5UEov?=
 =?utf-8?B?d3MxK2pHaHFHMFFSb0E5d09MeUphbmw0SG53aFpremc0Nk1COTFsSTl2d2NC?=
 =?utf-8?B?U3d4a1d1MXhYRXZmUVFJazA4RDhZakd1dlJIWHQxUlJUb3QwYk9CQzVGSkJh?=
 =?utf-8?B?SVoyM3F5Y1h1QWM0RmYxWW5PZHRFbmFaL1Ficktsdnk5aFZrN0dKYTY1c08w?=
 =?utf-8?B?a0JsL0VSQWo0VlJRTkVzYXZSenlac2J0UWhudzRHM0N1VXpqYmZjWTJOTTdS?=
 =?utf-8?B?WUdReDFDc1RsbVYvRDFETFFBZnRKamdRaDdEZ3E0STIvRmxiTS94aFNTcnV5?=
 =?utf-8?Q?2i821qTsoHg=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VTVZUHJUbVJic0ZMRS93VXZoREpnWEx1a3dzOFE4T2h5SlZWNjB4cVBoRC9X?=
 =?utf-8?B?bm1oT2N6SE93NGM1bTNWeU5JUjJ1YnpVNXlOTjVid254c1FUaTViQnREZE5R?=
 =?utf-8?B?STlOYWh4UGoxZjI2ZDFPOFNnaVRrcXNiTmE2WDJZaURWWGp2ZFExbDJhSmI2?=
 =?utf-8?B?dlR1VHpwN1J4ZXFQNlFiQmZabGhiVFUyVUJ4aForUG5WMVlMOWVEdHdSUUlU?=
 =?utf-8?B?RjRrc3kwWk5kNTl3Yi9ZYXQrdzJrYUNVVTcyZXhxdWZaZDhQN1YyNHQwNkV3?=
 =?utf-8?B?S00yYUtjT05nWUxrMHR1UDM3ZG01QUVXZHprZGpGYVlQakMrQXo1T1hwM1p0?=
 =?utf-8?B?R1JEWDlITVNHdUdnNzM4NkJHRTNNWWxPdjhWdDFJYXBoWDZGWFdFN0NjdFdO?=
 =?utf-8?B?Y1JNbEpQbmdzY095aEZMcmNLU21PRlcraWVjaHFqVEFVZ1NUV1o2cnE1NUdq?=
 =?utf-8?B?V2VRNjV1WHk5Q3pJZ0ltK0JDd1gwbmRRMzZFWHlUYlZqZXpHZGxwSkJJVTBQ?=
 =?utf-8?B?cXpiOGNnWmZmdEhleUoyRmR1azFJVU4zQ3dOZXRNWlFnNU5VMmE3NmxjRTlE?=
 =?utf-8?B?ODZaMlBZNkdJN3Y3UGtKblZPa1U0Q3hWeW9rVGFWNkNQVGw0LzRlTEFlTUQ0?=
 =?utf-8?B?d0hSakI2YTd2MzZzREt5V2E4ZlpFSE55ZEJtK3MwbTBaSTBVa1BTT0pqNG9V?=
 =?utf-8?B?bEJ4K21IY05EN1V0aHpTU0gyTHp5VEYzNnRiK24vY2FKWEN5dHlkdmtmaXh3?=
 =?utf-8?B?V3JLSmJqbytMdWRaMFM1ZTZYUyt4VU1ZRWZPaXYxalFUWThjYW51UG5oZC9X?=
 =?utf-8?B?UVIyMlhQL2lTcHVjTmhDaTkyUEpQSVBYQTJzdS9lTnkrQ0YySXpyT1hIRGcy?=
 =?utf-8?B?Ty9pL0diVmw3L09icndGWS8wME40Ri9uQ3JXS1VNdHRMeFpwN3N6REJyd2pq?=
 =?utf-8?B?RTlIS2dXYlBkM0hsaFlya044TkdnT3RlbTBwWHY0MUVXbTdYMmZWTU1MN09R?=
 =?utf-8?B?Q0V3R0Zrck1CaENLWGZqZS9RQW1SV080MlpWblozUlpWN2VaYVlBbTVTZWdj?=
 =?utf-8?B?dmJlNnJIU05IUHd2SFZNWnVJT0tFUTBNTytST0Q1R1g3cHJ0cnphME5nbEJP?=
 =?utf-8?B?VHZaV1hhWWxxandDOWJkTmZEdDhEa3Z0Y3pPSk9BUml5YjBFZ0RoM1p4VnhL?=
 =?utf-8?B?Y1k1VzZTcFBtNFVJNlJ4QmZnSldSM1NtWTB0UXhCaW5VMUhVRkxiWlA3VFBN?=
 =?utf-8?B?eUFqdlN2T1c5cFBCcUhCN2VEdWN6VHVhY0ZqNTJOcFBoNDM3ZU5RRW9iMDJs?=
 =?utf-8?B?U21OV2NsMmdqUHc0SEx0MTRrK1o1eUR0NldYRkluN1V0Z1kzWUtwR05BQkha?=
 =?utf-8?B?RU1lQU9zWDl1N1gvWDVKVHNMaW9VR2ZZWFlFK3dNTThKK245SC9IOC9ibjlT?=
 =?utf-8?B?cmtFL2RTNDFaSGtzY28yS3VWdkVWZTN2OG0vcitvbkdOWityeVNWZ2JxTTJK?=
 =?utf-8?B?UFBtcXB1aC9XOGpkZEtkRUpsT1NJNUZ6MzcrYXovOEZ3NG5sUXhEUXovR3Vj?=
 =?utf-8?B?QjVQS2ZnZy9IQlBFc212ZDc5UCs4QXhNZkR6UE9sR2FVNllkRGZoM3BsNWhp?=
 =?utf-8?B?LzhzZXRxYm0zdTFqcUFBbWc4OTJ3ZUpTcEExWE9VdDk3NXNwRGxCUmdFNDY5?=
 =?utf-8?B?Q0Nhd3dNVm5uTEhzdTBGdi9LTlByeGdZTXpqem1aaUhYckM0cjEwUVRSNDd6?=
 =?utf-8?B?blpMbStLdEorNEZhSE12ZGgranNTL2owbVFQV3lIRmRRNHJ5cDlzSW93dmoy?=
 =?utf-8?B?TGFBVko2bUhUK3FLakpUUlVPVlBWV0xObzFoWXpTb3J6aEN6UEtpdGZTOUZh?=
 =?utf-8?B?YXUyTUt1SW51ZHlVelV5Q2NpVUQyM0RJek1lbHpIOS9kN0VuSUREMzlzaFc2?=
 =?utf-8?B?eVpYMzhEeDZXVEdRTjFJRmJrdXVLenZwVVdnZHhpOHhySXR4ekJEZU4yUXIx?=
 =?utf-8?B?REZiV1JBVGVldUZmWDhLcHJWTjFIemdVSmplK1pNck5PQzJwNWtROWY1SWFv?=
 =?utf-8?B?d2dnaTRSd0RhaFZOQTJjLzRTL1ZNb05EUVZNTkVoOE55aHgxZkpHOEJ5NFR6?=
 =?utf-8?B?dEhMZ1NGaUo4c3RscGF5Q01CbUhUOEJsVW4vZ05MaW1vYWIyUlZxOFpWSHZR?=
 =?utf-8?B?b0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qE8Xh5Pb5aZW410UjwKSoFUPzdOilfXIqptX2IusWu7kx1o7PmMl8rQE7X2T9L4SNq69lJI2O6x/41Ytjn2CYiN6zEFTMSKFkivI07KBjWjE37DjRg41qb+c0wqyKJTuuA7XXlCLHwLwrY5K6VPZkxGjfwBeNQARgADjFfjTvy0vAqimC9Ho4/1TQii9LfwiDaLKDa9TNlkDrzD8T6BDPhmI4ArydfASECHcvp4rI7OZIsBo0dU417308K2OZqNu+eRpcqYUZKgkrIjPlJbwVoLeVZnFwiLgQFzW2siOEky21zYQRLMZvIho6v+6OZ77SAGiiDrRJBQiJHBVmWVzBoLvyxRqpK1MEpdQaSvO/MIyCfolIduSdt/zApJMiZyYZAcENFTL3BLUYH8ZIX3knSV0GXwsoSuB0Mg3sSmaKCjRQOpXlCNegQLvbfvhp336V80hZ7Gwsv3PGMNncxgoKKNUcB+kVCuHTETihU9PBSm+H5s0YPV3dBBUm/DgbPsoms6Ju3C79bjk3LTqx5I3330Aqsw0vIZ5BuiMj0hiQT6f2aqe3J3rysvb75xVt/4b0J2apKHO15Y0uAQTnYBSu7e9AdkKQBPMOqc4F1sCIsM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77170004-69c0-44da-8a82-08dda825b5d8
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 13:50:10.6953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0EL0uHWcaYrJ+8mewR1BcmZpme1U+Wp3qRiloPTP2jIv8tFe12m55/bG3MI1VCPUyVQ3qGB4eBBVGw++RnLPJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6490
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100109
X-Authority-Analysis: v=2.4 cv=LIpmQIW9 c=1 sm=1 tr=0 ts=68483816 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=h_UfcCGYMEGXo0uVwXoA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714
X-Proofpoint-ORIG-GUID: 5k9dKkApUIfHhPquEsMaRD1UheohmNbk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEwOCBTYWx0ZWRfX+oxP/oBVQ7Vm erP+a8j6gAu8erxehW0aMpkpUqyN9PG1aXoiBX8Q2fYc7hL941ixZjl8oKBePYMmZua6E0gp/tv T1ioY6bedgRlMleXI9bz/448l0KkSK0CXRBVkBHktV3C3J2Jg22rV/4kJzIloCmx+h1GmdozFtV
 h4A0OJ9J+cdsjmuFIt7hgC9THknHVJK+V4mBuOgo2nISJLnXkc1kLzVUI12rUP5JesJZ/Tmxijq Pm52VvHMKsMNkF4EpxotpO+9/alsKT1DUR7uGOZcn9NDc4ptCrlOewtMhH3VrypIc3PPPFxK5OC zRMEB2uML4q+EiRRpHsIMxve6s/RhjCPGcRR7pKNolnroGVxsv9tkBW4+fBjSe6ipBwbmYh4uTm
 SSVIjZeW19PpNaBxvcHt0tIZE1Fh3mo6TceOmAr4hqoElaFWljZtom4/BkNOl64CmewwRReK
X-Proofpoint-GUID: 5k9dKkApUIfHhPquEsMaRD1UheohmNbk

On 6/10/25 9:41 AM, Dai Ngo wrote:
> When the client sends an OPEN with claim type CLAIM_DELEG_CUR_FH or
> CLAIM_DELEGATION_CUR, the delegation stateid and the file handle
> must belongs to the same file, otherwise return NFS4ERR_BAD_STATEID.
> 
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4state.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 59a693f22452..be2ee641a22d 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -6318,6 +6318,11 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
>  		status = nfs4_check_deleg(cl, open, &dp);
>  		if (status)
>  			goto out;
> +		if (dp && nfsd4_is_deleg_cur(open) &&
> +				(dp->dl_stid.sc_file != fp)) {
> +			status = nfserr_bad_stateid;

How does the client react to NFS4ERR_BAD_STATEID ? Does it retry the
same request or does it reflect the failure to the application?


> +			goto out;
> +		}
>  		stp = nfsd4_find_and_lock_existing_open(fp, open);
>  	} else {
>  		open->op_file = NULL;


-- 
Chuck Lever

