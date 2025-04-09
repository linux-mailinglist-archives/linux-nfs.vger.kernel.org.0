Return-Path: <linux-nfs+bounces-11077-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7E3A832EF
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 23:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D1B78A1E8C
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 21:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA1719004A;
	Wed,  9 Apr 2025 21:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BbpKL5bL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="X3Qxf8nj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C041DEFE4
	for <linux-nfs@vger.kernel.org>; Wed,  9 Apr 2025 21:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744232443; cv=fail; b=k57V3IwSAeg0RS+jTDY3BzJKFKTMFTc/ZsfjDSSf0l7pZqCwSZwUG7Bt+hcsXgfumX0Xp7QpHGQXbJiedaHQW3OMhM9M1xW+3WuYoB2Jyvn8uL0hqJLaJM3kC0/3mPtoX8/S2Cv7ngxng68F6khvSO+FBAS36D4Js83EBSDB5YA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744232443; c=relaxed/simple;
	bh=08yxIAU0rR7TYhtt3LSm7HSqBJrGmcck7b/QQwYePSI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P/N60bWBK7tjtQDaLYiGrN9YjKdPxzp2qCmtyjNDlCdK+zEOlyoRufXc7PDW81+lhwlnqJBjX2we3AsSrGsq35W3RHCqib8t2rtH7eD8Jxl2zxtPszkrUOTsOl6t/DiVlM3aqdSAUQJtT6qE+Xog42VqKnRkJU9jGupqjfoROd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BbpKL5bL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=X3Qxf8nj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539Gu24w012048;
	Wed, 9 Apr 2025 21:00:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=W8QCdF10+3Fjz1BqUUuxaiHwjlnooE6gyqCkE3G1G/w=; b=
	BbpKL5bL03L5Nt0haO2wHeewgyWLmJgLUH07LOQdn28zU1Iw1Zy8hFYy4HKpQ+CM
	UfGYID/IxB02CgUHXZ0CfeoIny1StCFo+cgUbFmFHm7hos+eeGw81d9YqZZyvcIl
	sOhmXgIMkL5g9SqZZt1oWqPl/xG9tWjf27J+1gfUO7o5bh/03wSTVS9K3ReqniW3
	ZYS7cgOkijpTPeMStDjvAlT+BYRALRyp+iad9C3bEQmYhHpDOg3Be3IO1Wb36rnT
	z8FIKcas7NEopbBPxvf77+esxgfbzCk3F+yfEahkdX2WnqqfIO5IxJG+co7JPaTX
	Kwar2mzCJzS9BQFxJrkQGQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tw2tr6ab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 21:00:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 539JIvV2013762;
	Wed, 9 Apr 2025 21:00:30 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012050.outbound.protection.outlook.com [40.93.20.50])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyhnr4q-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 21:00:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/nyl4lhBLKRjvD4Rc0hd2LKzjzpxRBMPggyUQoCAnKdWo2F3SNV39CHMBBEHFwGP9jpNVYrdHlObO/Wqsv0OGDP05PW7zFBu7pwkSoQ9sN7lDIm+JDF/UQHTfHLOgpYXunk/yGGipPWvxHqioqKIGZUD8hJtTOo5RT8yxBn/lUT1mWtm9yZXxN/vyZBAwUnS1OKAsPXsZrOCRdyiQR8DO1S5JnDJLXihqyp8w7KiRgOhTs4o8io6jeNxYC2Vn8o98oJdYog51WS915y5W/dWYe+NpcbkaPgXCtWGIYfIatodw3JEanhkqpoo5WIIkMD7S6J0VAiixAWT7DBvbL2RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8QCdF10+3Fjz1BqUUuxaiHwjlnooE6gyqCkE3G1G/w=;
 b=yDR9+1vB7oNz9QiG10CJW9hFWZrnWkQ9CeCEVld+WVHRn8UNOexUERAZcMSh3zBDJLMXoH7/YNb9JhCAZ2CON5EUfK85Cm27wusOgH/alBniMJs8h3E+FCQlzKHRXT+ire1XY/M5kwsYOXuw/qmwrdwCyG5YcCzA8uM9QK9KC9CsszfHx3QaKtJ+DAUFDx9wyRtoWIYgv9U9s0HxRs12qRP3oQecILLTAIR4PfZjgL02d2NRZTezEAHPdLiBuBFMmj/nmuCCTy6KEkDKZsfFSL7YqKzFH+/s/GDjEWVnEd7XLHvYejsoLrzHDwsOJGa5pGaHFAgu31Fyhe+mgk7sEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8QCdF10+3Fjz1BqUUuxaiHwjlnooE6gyqCkE3G1G/w=;
 b=X3Qxf8njtEylqs7DwJo0KuPiubeSiIVdu5LrsNVqELyg5MoxuUkCpVHb9J2c3GW8hNkOZbYcHKTXwWab6kgpLxpi5DxLxj4ecbIjjhOFHQ7N7KsE3VjJfpgK+dKZuPWMHHTzoXZk2f5QsUsniIQjlzZ48N5Qr1KsMRhxcDKgkhU=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by DM3PR10MB7909.namprd10.prod.outlook.com (2603:10b6:0:45::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.20; Wed, 9 Apr
 2025 21:00:26 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%6]) with mapi id 15.20.8632.017; Wed, 9 Apr 2025
 21:00:26 +0000
Message-ID: <2c1ec47a-9d25-465f-a36e-079420a3927f@oracle.com>
Date: Wed, 9 Apr 2025 14:00:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: NFSD automatically releases all states when underlying file
 system is unmounted
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Tom Talpey <tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <> <8787b756-2003-4a2c-a56c-8f8c626756a1@oracle.com>
 <174296051697.9342.18114262068417505490@noble.neil.brown.name>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <174296051697.9342.18114262068417505490@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0147.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::32) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|DM3PR10MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: b47a8212-8d14-4f34-ebab-08dd77a98d31
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NlExOSt4dGo4NFcxbEMyMFF3bDVDZEdHZkVEd2RnUmtmTm9nNzludTRHNnhJ?=
 =?utf-8?B?UHJsQjIrUURaZU5wU0lvNkF2dFNoNDlmNFNHRUhSUkZ5dDZ2ZjhqSE1iVHU1?=
 =?utf-8?B?S3E2L2l1SWVpZUsvUVNvYjJKV2FUZGhSOE0yRHJlUWFpYW5pUEtaRE5MVnlM?=
 =?utf-8?B?VmN4Q1h2c3ZHMW1USXA1eWgrZEpJVldqSzUrTVFEbENyNFhJVlIyY0NhMWcy?=
 =?utf-8?B?ejVXRnA0aGVVbEZDKzkxR0t6dXk5RmtQWXRFbGJHY2I2N1NEUVNIRmJ4Wkx3?=
 =?utf-8?B?RnFadkRhdUdYR0hUcUZKRjdnaFM3aWJUaC9xQ3d6UlBpZkZmRmp3eHNlTUoy?=
 =?utf-8?B?SzBvbXNML292bHpLWWdkdHJTTTJXTmJmNjlzNzNoSHJrOTR1TWxIZzZMak9s?=
 =?utf-8?B?QXpTbkJlQmR4c1ZvTjZWV2U1ZWwyWDduRXRRcWJwdTdHWmxpbktLUzlwSU13?=
 =?utf-8?B?L0x3cHVCYnhUS0hFcDR1RnBIcHVhc3QrdjVRRThiYng4SGFZSVdQMHdJNlRX?=
 =?utf-8?B?YlR0cEFMb3g2YllDdUJCMkNGaGxwZVhkaU1xcnRYcSt5WFdKcGFyTE9QTjhP?=
 =?utf-8?B?bkRGc2hlMTQvam04ZFViT0RNUlF5bjk1T2I5ekZSZ2ZVV05PTHRuN3gzQ0FE?=
 =?utf-8?B?bG9QSmswVklUSmF3a2syYnJNclJuM0duUnA1YVppSUhHV3FabDZwbDZ5SkYr?=
 =?utf-8?B?VFUreXYrQzlkeUlFK1VrNG92T2tPQkNLSTlBekhGOW1iT1BCdUIzc2tqQTV6?=
 =?utf-8?B?VWtEWEIwUUtLWkNTTE0xZzNHOVFIMDhyWnBWOEdyV1VhTVczbDd5cVhzeXhE?=
 =?utf-8?B?T3M2eGZwNDNvVDkwT0dNZ0c3dzZDK0dwZ3Q2dWc1SzBNd3UzV08zSjZjaUtS?=
 =?utf-8?B?dURaZ1A2RHRsTmcwWUZ3N2tNOTZQUHRBazFVd0M1dUREZ0JGT1NBSStvMkcy?=
 =?utf-8?B?cEFsenFQSnJWSnV0b1dGVHVhMi95WjRKWFYxaW0yS2hsZ09lcHY1eEJaVU9L?=
 =?utf-8?B?OXNpK3ZNK1YvL3dRZjRjdUk3d2dDQnJ5L3FNYkhjRlhHZ0hGMElnS2NRQUtD?=
 =?utf-8?B?MDRqMG0xSDViUmUwa3FPaEFBLzQ5UFc0WG1pTzErNFNJTzVCNlA5Nk1rQ0FG?=
 =?utf-8?B?RFE2d2Q5aFI5UGp0eEFCRGRBTS91RW5RaHRNMjJIY0xad1hMS3ErU1paWm1k?=
 =?utf-8?B?Zm13cG5ydGh6YzdDN3paN2VMRXphc3Q1SlJIWkhlMFZlb2daQlNqbjBtbDFN?=
 =?utf-8?B?RW02THYvQ0pFdHBEMzEwTURoQjdNL1FLallRZ1hwb05Oc2Vsdit4SlZtQmN5?=
 =?utf-8?B?ZVd5ZWNjUUNJUVlzNnVRbXJqM1ZLZnpZb3ZEcjkyemI3enh4dkVmWEQxUUxq?=
 =?utf-8?B?d1kvL0d0YzMwOVV6cVo3MXg0Q0QzSEo1MVV3YmJhaGpBeE9xOVd6Sk5kUWtI?=
 =?utf-8?B?WDlUeHJhWVVKOWFyT3VUaUtzdUhJWmlzNXNaSjMvTGp5OFNoVG4wNFB0dHJx?=
 =?utf-8?B?RlZZaWY1QWplYVFTQUxHSFVmMms3UVFIdWtJYUs4VS9PM1VObC9LdFRQVkpK?=
 =?utf-8?B?YnowNGpXUnJ3ejFoYUxJNk1EN2RVdFMwejI4R2ZrSWtYVkkzS3d3SHJsUCtr?=
 =?utf-8?B?d1hPWUdVNFRiK0hhR3JrWmpYUG12VnIrOHVIY0lyaTJMRko1TVRNMlEzSWFw?=
 =?utf-8?B?bTg4Z0lhM1l6SEV3YWpGUUs2aHQ4TlRBTTZjNlY2TjR0R0pTNEJrVk5LN0Vh?=
 =?utf-8?B?OWxDcVdtaFNsSVlGN0t1bVRsR1hNTmRqQ1FpdG8xamE0RXpyQUxXdldVZk56?=
 =?utf-8?B?cjdFWXJEbjRaRCtvRDZsNHA3Nkc0OG84b1EvRWN2SlZOOUpCUVJTcVRKSGlv?=
 =?utf-8?Q?N1kW/C70eTSyo?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Z1ZZaGR5NmVoNTJaT0hYRTdrUkpueWJsSlhkaUJBV01wN0dVcG1tcEhudk1L?=
 =?utf-8?B?MnFZQkpIQnhuRlRnVTdEM2c3VmNndWZjQnZKd1FMWW5lclBDUWtqVDZRSWFJ?=
 =?utf-8?B?aXR2MFo4UXVmWjE4ZHFJNXBUc21od0RRL05hQ004WlpHTGw0MTk1VzQvNjR2?=
 =?utf-8?B?RGEwVHk3SVd1T2xaeGtZS2wyK29CeFF6Q0FsZjBJa1JHNTBOZ1lrSVVhRU1R?=
 =?utf-8?B?eUlUYy84Ymp3ZmxVZjBGUHJ2Q3dIb2syMXBuOTUybEF3VzA3djVidkovSFZD?=
 =?utf-8?B?all6eHQzN1JmbzNKWG5SWWpjOFNRdFBGbVFaUDJuUnMxeHprUGtzYk5hVFFJ?=
 =?utf-8?B?MDdnQ0d4NjUxUkM5N3k3NnpNNktLRDRwVE54b0FEU3BHZmwzbGNVNVE3eUpW?=
 =?utf-8?B?REl4N212cHVrdlpudGZpRHZBa2diMVVzNEh0NXBTZUZ3T2Y3SEVzQjdZbHRl?=
 =?utf-8?B?akNMalBlaEZsSzFyM01ERnArZkRWSGo2Qjl2WkREVGlRVVFzZ1hGbVB1NXpM?=
 =?utf-8?B?N2gxWnRXdlo3VlRwY1FCSWxrWDMvR2tPQktLcjh6TkpHbWJJY09ieWM1QUdB?=
 =?utf-8?B?c2lUK3JCOEZWMUpCV09zbEJjZU9YRVcwZWVQbjl0MDBtaThDek9tZHV5K2FG?=
 =?utf-8?B?aFA2ZTNCZlVmRHowN05CLzBDYitqbTVvRUxKWlhiM2JhQmxzbWR2bXROSDE1?=
 =?utf-8?B?aEJRN1QwUDhydWtwa1ZZa2VUL1NPdmRDU3p6dXowSmRwMEc1WndEcCtDZ3pN?=
 =?utf-8?B?V09WeG53N1g3cXlRVkFqRFJPVnV0MTVsTXM2SlBRNklWSkxKNWYvVGg2V01W?=
 =?utf-8?B?MXFVM2RQK2hGa3lWM0FHSkxYZUhMVlBYZ3puYnN5WDNyWFhPeXBNVlozVUpn?=
 =?utf-8?B?TWc0SURjVXh3OUZCN0RBVERTS1liSFJVNTBhV01QNUlQL3g1SWlrRVB4R3VM?=
 =?utf-8?B?NnVuWEpXNFNyQXpFVlZRL3orVEJwRDM1Zmw4Sm1jemhYZU5iVjNxQnVyZVNj?=
 =?utf-8?B?NDJHWmhHVlMvOFRxVTU2OW81dW54R214NDFpRFovWjdYYjRBV2xZWEhpanUx?=
 =?utf-8?B?cmUyQWdodHBvS29BZUgwWjR4MVNkNE5GREVHNEtYS0lOSjVxNHlHQUQ2Wm9L?=
 =?utf-8?B?Zmo4VEg4K1RNcVBLZHhBcnN3LzM3NlBoUjFyN0R0Q2pRc0VuNG1yQjFVMnFr?=
 =?utf-8?B?cHZHeG1HVVJxVFMrcjhKZUFxbEVRcG1yb1JNTmJqRTBBdU5hSG12djZ1bFBB?=
 =?utf-8?B?WlZ0WE1ZT0lmY3VtRnNsY1BsWC9DanhLVVhHeTVtWGxVRXJ4MERxMmJGN1My?=
 =?utf-8?B?U29Lay94aHFkTm1BU3U0bFd0YnE5cUs5blNjSmFlOE9MVkdSZUZ1ajRvTGls?=
 =?utf-8?B?QmhucE1ZOU1yOVJrVWdEeFVmNUcrM0IrRFI4K29od29JRHcrQVF1ZlBEQnN3?=
 =?utf-8?B?aEpGaDdaa0xvMi9UTWdHbUJmNlVXVXNHRncwaTNldGVmSGZha1p5YnY2eG0x?=
 =?utf-8?B?cUkxZ3RXSnNjbGZ2eitKd2prSDdXZkMzWndNdHR4SmhKeThuU0Q5V2VtMFho?=
 =?utf-8?B?aTdTS2R5YTlBSlRlOGQ5S3Ruc2dEYmdseWtRZThvbE92Z2ZoWFdNdThrUElF?=
 =?utf-8?B?WUFYRlNxb1lLeTYzazRmZU1DY0FTKzVwSFFBQkpYT3pSU01GMm1vQTk0OXZ2?=
 =?utf-8?B?Z1Z1aHhBN2hDaStmajBkUmJIVjRoRXJ6R056c2hPNkt3RXRLVVYzRnFxRTlT?=
 =?utf-8?B?ZU5teEZPczlFSkMvZGZvbXpoL01LMDVyR0tQZGhQSGdIVm5nMjZKSkpueWRu?=
 =?utf-8?B?eGJ5SnpvSTFnYXArcmFTTEQyZGRWUUdtRjIwdlNJVmFrWmltdkZpN0xya2J0?=
 =?utf-8?B?OXFVaDlNTDNiMU1LdEkxa1QzWGpDSmVZT2NZNllPMHJYQkFiMkRRTjZYS2t1?=
 =?utf-8?B?eHpCVlQvaTFpWXdlWDVKYkZXNTE3b3dmZzdGZGVsbTQrS3p0enNXM05MVnF3?=
 =?utf-8?B?c1B4M0dPUWNPc2ZJajNDZmhIcFhSSVBWR05rY29hUHhEZkhuMzd3K01pSkdV?=
 =?utf-8?B?K0dQY0NZVE5DRWVWNDlCUnJ1MlBiVzdwUGV0MUppTzF1Z05jSXlla0ExSHJ1?=
 =?utf-8?Q?MzZhXxb1GS5TAW/M7trzBfJ3h?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Re7Mr+MUCqEowzuNg8j7HvHaBfMe9pI/2/cPc0nnEwI9BVrb1ZsFv0WlpaHwwyFKXzpzI692UwAqYWpsZzjlp49237RZGyyamikP4ky8Ix7Q+AuFC98vPBoUEqqs/cGSccjHp8Au6syl9bvMaakYVQlF9vyHP3Nb8fN/wLMnIzGdGPd+2gDlOaOFcuYddjnrODr7mpESHGKah4qxctrna2ZCruPA//jF/MMj40Yl0MvBNle1tVZC4FW87Zr8Gepu6dXBLoTVsHE06Cy8MDcsg4diykOHSSltsVdiZf8hlxsQoOqQkmjvEWkgKUITIOXPbVEswKwRwxaIIW9oK/GgDtOXnoxXeIX6dk3vPMgMacN04KbHq7y1RufNfQHPtl5sCPaJ79I7Fbe5WS1kgDg10peguomaiF9KlD186dMEiCaT+R9ah5Hm/hjcL0cLFEdDTmJev6sWXOcFQWSmmdHjonmpH/kLbVC+WMmzC7szDh/rJppiuJ0DpkZMO/xLuagKWewnBIbTGaNfOo++IQLWVVWLOAvLAnYWbNJuQsl5SEgfAzwDl4PRjxdkkXMdKJX0n0cMGoT++22IPTyyVuZKqCX01QYJLJlJLQlecZ6iwcU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b47a8212-8d14-4f34-ebab-08dd77a98d31
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 21:00:26.0115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKUghs88PkYduURXceKnLsFHAYFdu6Z0A3lctvUEo9VagegEEPAfsXZDhhxlbCQY81ZiWP8WqFbMMO0kFCX9aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7909
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_06,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504090142
X-Proofpoint-ORIG-GUID: S-0JzankIAyQ2Jq_mw2FcvUYME3IWYF_
X-Proofpoint-GUID: S-0JzankIAyQ2Jq_mw2FcvUYME3IWYF_


On 3/25/25 8:41 PM, NeilBrown wrote:
> On Wed, 26 Mar 2025, Dai Ngo wrote:
>> On 3/25/25 5:23 PM, NeilBrown wrote:
>>> On Sat, 22 Mar 2025, Chuck Lever wrote:
>>>> On 3/21/25 10:36 AM, Benjamin Coddington wrote:
>>>>> On 20 Mar 2025, at 13:53, Chuck Lever wrote:
>>>>>
>>>>>> On 3/19/25 5:46 PM, NeilBrown wrote:
>>>>>>> On Thu, 20 Mar 2025, Dai Ngo wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> Currently when the local file system needs to be unmounted for maintenance
>>>>>>>> the admin needs to make sure all the NFS clients have stopped using any files
>>>>>>>> on the NFS shares before the umount(8) can succeed.
>>>>>>> This is easily achieved with
>>>>>>>     echo /path/to/filesystem > /proc/fs/nfsd/unlock_filesystem
>>>>>>>
>>>>>>> Do this after unexporting and before unmounting.
>>>>>> Seems like administrators would expect that a filesystem can be
>>>>>> unmounted immediately after unexporting it. Should "exportfs" be changed
>>>>>> to handle this extra step under the covers? Doesn't seem like it would
>>>>>> be hard to do, and I can't think of a use case where it would be
>>>>>> harmful.
>>>>> No. I think that admins don't expect to lose all their NFS client's state if
>>>>> they're managing the exports.  That would be a really big and invisible change
>>>>> to existing behavior.
>>>> To be clear, I mean that a file system should be unlocked only when it
>>>> is specifically unexported. IMO, unexport is usually an administrator
>>>> action that means "I want to stop remote access to this file system now"
>>>> and that's what unlock_filesystem does.
>>> A problem with that position is that "unexport" isn't a well defined
>>> operation.
>>> It is quite possible to edit /etc/exports then run "exportfs -r".  This
>>> may implicit unexport things.
>>>
>>> The kernel certainly doesn't have a concept of "unexport".  You can run
>>> "exportfs -f" at any time quite safely.  That tells the kernel to forget
>>> all export information, but allows the kernel to ask mountd for anything
>>> it find that it needs.
>>>
>>>> IMO administrators would be surprised to learn that NFS clients may
>>>> continue to access a file system (via existing open files) after it
>>>> has been explicitly unexported.
>>> They can't access those file while it remains unexported.  But if it is
>>> re-exported, the access they had can continue seamlessly.
>>>
>>> The origin model is NLM which is separate from NFS.  Unexporting to NFS
>>> doesn't close the locks held by NLM.  That can be done separately by the
>>> client with a STATMON request.  In fact NLM never drops locks unless
>>> explicitly asked to by the client or forced by the server admin.  So it
>>> isn't a good model, but it is what we had.
>>>
>>>> The alternative is to document unlock_filesystem in man exportfs(8).
>>> Another alternative is to provide new functionality in exportfs.  Maybe
>>> a --force flag or a --close-all flag.
>>> It could examine /proc/fs/nfsd/clients/*/states to determine which
>>> filesystems had active state, then examine the export tables
>>> (/var/lib/nfs/etab) to see what was currently exported, then write
>>> something appropriate to unlock_filesystem for any active filesystems
>>> which are no longer exported.
>> Is it possible that at the time of cache_clean/svc_export_put the kernel
>> makes an upcall to rpc.mountd to check if svc_export.ex_path is still
>> exported?. If it's not then release all the states that use that super_block.
> I suspect that could be done, but then you would hit Ben's concern.
> Temporarily unexported a filesystem would change from the client getting
> ESTALE if it happens to access a file while the filesystem is not
> exported, to the client definitely getting ADMIN_REVOKED (probably -EIO)
> then next time it accesses a file even if the filesystem has been
> exported again.
>
> I agree with Ben that there needs to be a deliberate admin action to
> revoke state, not just a side-effect of unexport which historically has
> not revoked state.

Is it useful to add an option, 'R', to exportfs to also revoke state when
user doing '-au':

# exportfs -Rau

The main purpose of this option is to allow all the underlying file systems
to be unmounted without requiring all clients to unmount the NFS exports first.

Thanks,
-Dai

>
> NeilBrown
>
>
>
>> -Dai
>>
>>> If we did that we would want to find NLM locks in /proc/locks too and
>>> ensure those were discarded if necessary.
>>>
>>> There is also the possibility that a filesystem is still exported to
>>> some clients but not to all.  In that case writing something to
>>> unlock_ip might be appropriate - though that doesn't revoke v4 state
>>> yet.
>>>
>>> Thanks,
>>> NeilBrown
>>>
>>>
>>>> And perhaps we need a more surgical mechanism that can handle the case
>>>> where the file system is still exported but the security policy has
>>>> changed. Because this does feel like a real information leak.
>>>>
>>>>
>>>> -- 
>>>> Chuck Lever
>>>>

