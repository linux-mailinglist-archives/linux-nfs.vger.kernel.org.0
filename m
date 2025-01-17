Return-Path: <linux-nfs+bounces-9347-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E13A155C6
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2025 18:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33D15188D5D2
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2025 17:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C277A95C;
	Fri, 17 Jan 2025 17:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CiImxpTG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Fu728ZxO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3FE165F01
	for <linux-nfs@vger.kernel.org>; Fri, 17 Jan 2025 17:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737135106; cv=fail; b=scqxypWpUiM1eneB06qRWGCUDCHvd1LHBkE/MgAiWRQiGqLVZgKxPVlNB6/u2xvw/1c6qZBWWpQuLLPlNMrr6BXoI8SbqKIez+c6Z01PXWVTks2N0XrFPWCmXQLKI/Q+zLTtf9pc0BiHV5ofu0j1Nh7Dvt4TPm7rdrdGbrMvJDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737135106; c=relaxed/simple;
	bh=0KTC+q1bv4/HV4ImDkmi3i1wFKAs55B9ojciWQeNVTc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iBnFs90exhJ+zgKCWuR419/ZxanwCWKa/ffEG6u0wvC6Cn5WtbbhCycsYISXE5me2yZ4FzAdJvoHd+OA/puqsntpq7z5t/+VUMJC2NOCixBZqU2zw4yuX+vKBcOgj6ElIfEgYc3tJurMEbby5r5/krayb48vf/r9qLySrpcyasE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CiImxpTG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Fu728ZxO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50HEfikB026169;
	Fri, 17 Jan 2025 17:31:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=fytzYRDjXt3ei5T9a3N8Z/se0pKCZqUEp6bkMeTv3Io=; b=
	CiImxpTGqnyJp8RNdcPiyzO/beXbA4XpeRd67XnbLgblUEnnGi30zxvtqHv+ffKM
	amSnpgQSFCBZn49rS8spwIxNFlBY4C0rb1/CwpjAb3dpIUD9kbPySDf0lwNqpLVo
	RmQC9yN7VXC7PN5oZoUibQ43oz3tk82JidWxu6/fNTvTTsiqgWJPZuI3RxhwBjfb
	wyC7UKyn/h56kRHiWXLLjrIkkLTx60Z68kEolDI4jGjkq2nCzwZ8gm/KPRjQb4Xt
	p6rmZN5PPuO1aeZ0byr7cXtySqexTb53vuKSgqap50XD5wpc5SgAaNDYIEybrGYi
	lNhJ4AdRosat4Nq0GcbQPQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 447830j2as-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jan 2025 17:31:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50HFhAGG036237;
	Fri, 17 Jan 2025 17:31:15 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 443f3d0fbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jan 2025 17:31:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mQIYSm2+Uz25eNcTqcoOvcfXyGHFJL0fHVWUbf8MMSL7UN9zKbTSLWL7O9/FJ3yXwSL11TX3+lyp6rtmTVdh1imAg3eM48n+coH6/u9ufXCBEjeApTbXv6dVUaJSqXCK723BRWkKH3oLfGGCUZBp8uQqOLpvOyvOqTEWkqYPHlAbh1etfd7iwLSqSMqOLH+VjhWVNLgLRNQ4bOv9dYhl1/i0TbNZhPvnkaeHkDmgnicsIrOARRSVDzvsMRvaO8+QSlnK7u7KxE7t2eZXGDpnuVpeSmc6wg129wI8BaERZlbgLC6S3hZkaK/V/dSQOSSV4a7ahk+HBVXV6+z8+uiKPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fytzYRDjXt3ei5T9a3N8Z/se0pKCZqUEp6bkMeTv3Io=;
 b=i62FgOAS0A5yLymPNbFNG3JurTvLJmiTeZdQJKfuzZz8ii/aFwrnwQPVzwhIoDy4pbehmq2jU8HmK40FWK6CbWQvEDvMqpU84ahxz7NkIhyIZJjT6B5Jd+YZ2YKEPbG1tN01BK+Boqdynhgwhryo+8bu1YjrXCPdCe1ttAPDt2szdheJ7JlXhX9LpHQLHmuc0sozT7U0B28IDDa9O+kPvbexAfOmapYYD7EGqTlLEUiTj6c3jDyT6ARe+KZg6o9pdrUGSRsur5pGM3u8D2yfAJeQfhcyHNcUplBcxzHcNxGKthXFa5qjcPmWtN3B/EzORPcDm2wQYBoWC1s6OnF6UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fytzYRDjXt3ei5T9a3N8Z/se0pKCZqUEp6bkMeTv3Io=;
 b=Fu728ZxO3YohFMb9qsjro/IzorPI99Bg82rWrId/C59dcKdO3D1Gbf8euiExuJeu2BIHfBZZRgDPyrT2DswNv82FTpDl1hE/x1Xvq2zZpVp/EFqPPesqx+DBGFoOcznOTPzPad28CXLaVSxZbMDGHMHLCPKfFfCGA2jXdYGBKMw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4496.namprd10.prod.outlook.com (2603:10b6:a03:2d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 17:31:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 17:31:12 +0000
Message-ID: <2555f547-f7be-4f75-8c95-0cfc629599d5@oracle.com>
Date: Fri, 17 Jan 2025 12:31:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nfsd: fix management of listener transports
To: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <aglo@umich.edu>
Cc: Olga Kornievskaia <okorniev@redhat.com>, linux-nfs@vger.kernel.org,
        neilb@suse.de, Dai.Ngo@oracle.com, tom@talpey.com
References: <20250117163258.52885-1-okorniev@redhat.com>
 <09fadc29312736c46951d61f42a33f30485bf562.camel@kernel.org>
 <CAN-5tyGC2KCdoxwDtDhmWaX-50OneCg7xzBUDdocsAC0aC6mnA@mail.gmail.com>
 <30b5be80cf169f0321caa3f9698946204a363c63.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <30b5be80cf169f0321caa3f9698946204a363c63.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR07CA0058.namprd07.prod.outlook.com
 (2603:10b6:610:5b::32) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4496:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d7d686a-1a4b-4b62-1e23-08dd371cbd0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NEdrNzhZUlpXZzM1bUdRamtoK25GZ205VkwxRXlsUElHdVp2dTVSL25VT3Jr?=
 =?utf-8?B?YlZaeVVMc001R09WME03enQrRVRLWW1vejF3cDBnc1M4OWcyOHA5czhuZ2ZV?=
 =?utf-8?B?WHlacDFmN1o1TjluWGxEREIxd1gxTkc5QkxFbjEyTmlnTlZmaFVxeWFkczht?=
 =?utf-8?B?cFRDbk5Ubkh4Uko5Q004UEpwbm1vZVMwYkZjNU5qaU5WdWM4SjdRSTZCUlBX?=
 =?utf-8?B?QTJOelYxcEp1dStGV01lYWlMUzlDc3NIT3pSTW9OaHYxZ1Yxc1VwWEpLZHBM?=
 =?utf-8?B?R0phYTdPbzNKSTZlS2VMNnpOYlJlU1VzemlCL3NKdndoclhHQmdDdWJLTFpt?=
 =?utf-8?B?b2ZZNjhhMDdldDJGUnQ3SmZWSmhLYTU4cGcreFJicHc2TllsYllMenBuMytr?=
 =?utf-8?B?aXZsNnVmY1g0SENmK3ZXQlhIYzhta3JQWGdNdUYwUnV0bHpTMllYZmxiV0Js?=
 =?utf-8?B?TXVmTk9STmNOcE96S1JrQVJjQUR0UEEyaHpJYURLNnNqcmh6WTd4TndORVlV?=
 =?utf-8?B?UjRPVnQwdWNPTVBmbldnREpUSFZQeWlkN3dmcDNrM0Y1eFM0b0c3SktHRGZa?=
 =?utf-8?B?Tm1CeHpKTWQwTERHajBaZVdtOXBZTWpSeTViK1hla2xNVjFCU1d5RDlGdkxv?=
 =?utf-8?B?eFl6Zmxjc3kzK3R3bDl5bk1aR1BiYm9zelFrM2pLanR2TXYyWGwyRkRyV3I3?=
 =?utf-8?B?TE9Dc1lQa3Q0ZzZ1UXM5cFMvZldPV2lpMkhhem9rWktScTB3cFlsekhoTlFu?=
 =?utf-8?B?R3hDNE1wQUJPK0Q2RlNkYmxTMWhUblV5WE5sTVdoWVoydmlvN3FwcFQ0STZp?=
 =?utf-8?B?ZmdnRlVGNWVWZ0JvMkFSd1lTT3hNRmZFbE02bHVvemN5aElVa3F0SWRUdlhR?=
 =?utf-8?B?Q0JOU0NJVE9QT2tnUEZpL1N0dVlHYm1WbFBhcEJzWkFhNm9laHVRZS9ENi9L?=
 =?utf-8?B?VFNUL2ZhbHhPb0txZFhLYm9mL3k1VzJKK08wcG8rdjQyOHZyN1Z4eGFIQS84?=
 =?utf-8?B?ZkVSZHFGQ3hnSXZSMVZVcVI2VUV3alcxVDMrakFiOEdWdExIRHJvcGFsd3lW?=
 =?utf-8?B?KzV5cWIrb2RFOHZubzhidVVOLzFKQnkzUU9kRFdjY2pJV25idFBlVUF5VEd3?=
 =?utf-8?B?bGFqYkFSeDdEMGpnSHRwTjBjYm90VlQxTWZRc0VWZVZ6QjkrTGxhN3lFUSsw?=
 =?utf-8?B?a3hWa1BydmVDM014WU91bGphcDNDS3E0ZzY1bWhNbFYxdEdWVStMQjd4MlRJ?=
 =?utf-8?B?MHNhUktNWWdHalhRemZManpZeEFRSkwzQWplL0t2K3Qza0NSSHhkY09wU1Fm?=
 =?utf-8?B?T3hxMkpyVDNZN1lTaGpQRVF6Rkppb002QU5kcndmWWZuQzNUWG9TMFgreVZm?=
 =?utf-8?B?RGRDVVhOU2ZBUkhQMXhzVWFEQmFPQWVxS2laZVZRZVROVHhLeWowZTc1RXpa?=
 =?utf-8?B?WVAwNDVRQThNYWJwTVRiSUhMdSs4NEFFNUlWL256cDgrNE5KMjlIOENOOEw3?=
 =?utf-8?B?WGRkS1RHM1JBSmNZYUsxWVV5MC95T1pseUtaTFZqOUVMTXVLVWFNVFVSamY2?=
 =?utf-8?B?NDRwaitiSkFMVUk4ay96MjZ3WmNwTCt4SW8rWk8raXVQd0p2YjczS1FDMXNC?=
 =?utf-8?B?M3g3UEN4MW9DYk84ZHJVTGNqOXM3dkxKQ21za1FwU2FTZ2RubjhRRmNSL3ps?=
 =?utf-8?B?ZU1xRzY4N0xtbDJZbmswZ0gzNXhac2V0YWphdDVVblJaTXFkdTJEUDJ5TC9I?=
 =?utf-8?B?ZEdBdmVPeEhCRUt6NFVQV29xQlFuT2NXTDBBdkRBc3pvd25uOVZDUCtPYjgx?=
 =?utf-8?B?cGNXV2VCTjM5Vlh6c214VHEyVG1PNFRqSDNtMzV2U2VHMkQ0ZjZEKzBNTFZH?=
 =?utf-8?Q?PO4uyLuZZunhc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzVPRDEwVGgvckZocDk4L0VNMERzNUlta2hkVy8wT21yRDFQTk14cDVHSG9S?=
 =?utf-8?B?ZDVDKytUaFJyTG9VU29ha0hYSXh2WTcwRFpyUFpXZkFPWFNNYXpIbDhsS3FH?=
 =?utf-8?B?U3I5MDNhY0tkMGw1aEVNUjNVUmxSRkNmdHlMMlVyS2dQNG9YZFJhUHhla2NO?=
 =?utf-8?B?Nis0SkFhKzJoNUMrVFF6WHdlTmRwaEVaMGdCNllCSEprVDhnVWdaY0hUSW5W?=
 =?utf-8?B?SFNCcWpsTlZTRWs3eWxncEt0TStISXRxUndzdVJZbTVYd0pOamxhNU1jeWR5?=
 =?utf-8?B?ZStLb21kVEhqZzFFWXNUcjVweGdlejlWN3pzUkRJTWNDTnJMY0lpekNZUG9z?=
 =?utf-8?B?bDFDckI2bitnZEs4UFdKbUVhdnN3M2tMLzZDdHo2MmFNRHlrbVRmaG5WWW5N?=
 =?utf-8?B?L1IyRjQyWUo5RVZyTTUxS3lOMThGUjY5WVdENkFWYVZrcjNHK2xSUzBkWms4?=
 =?utf-8?B?Tk9mVCtRRFIzTkJzRmd4UEthWDBrUFJ5aElhZmFhSlp5ckQxNmtHRjdHOHZv?=
 =?utf-8?B?dlRUNUtSM2xsbW11Q2dZbmNZaVZCaEk2ak9oclFYTC8wejFOa2pvNUM3Vitq?=
 =?utf-8?B?NTFhL0Rsa1Z6ZVdBdzhVVkRkTWZwZTMyY2RhWFpzdTduRUorVy9OUmFsR0ll?=
 =?utf-8?B?R0xpQ0t3QzhUSDVwdFRiRm54MlVCZU5STjBpaWJZbTU0dlYydExaNzVBSjZt?=
 =?utf-8?B?dTRBeXdJa0ZKUEF3QTdyamVxeGg1d0xMUG42SDI2MFlOb2M3UWNBWjhLRW54?=
 =?utf-8?B?Y1BNSlhsRDJaeXh6bENNSEhGOVNiUzBueTU4SE5UbEs4RUVLSHZvelFMdzNV?=
 =?utf-8?B?QVppYXFVKzdJQUpKdHd4UFU4NEp5b0dqMWZ5SG5Ta09DZ0tiK0ZRcXhaYkY1?=
 =?utf-8?B?TnlwQ3YreVdaV3Q1Q0RKakMycXdoTjZnNnVGVEpsWi9mN1Rtc0UydDRSdnFz?=
 =?utf-8?B?ZXRFQTFOWVh6aWhDTjk1OFJ0aS83Q3FnY2VyRzl5aEZrZTl3MkluekJnMUwy?=
 =?utf-8?B?bkwwOGIyelA0ZmJmcStHS0hsRnJaY3BXRlg0SXVab2psaGVObEw2dUVSQXNW?=
 =?utf-8?B?VVRxSTIxR2s3eVQzQUgwRUFwaTZzV3VVenNuNUswR1gwWEk1ZDZZVWZzWFVE?=
 =?utf-8?B?WDVIL3g0SUNtWmlMankrbWRER0xRczhUa0lORVA4TGg3MkZzaHVwMDc4ai96?=
 =?utf-8?B?WVczTjdRU0g0VFJheFpDekNvOU5mRENJcHZQdHVPdzI2bTY2N2RqeFdCTjFG?=
 =?utf-8?B?MDI5RlhtK3AxYnIzTFdDZjRxMXlRYllHejA5U2JuTEVmeTY3NTRValBIa3cr?=
 =?utf-8?B?WUc4K1JWMnQzSklNME9UeHNSSmg2QUY4VFNpbUo3L1dnNlV5ellCUXBKdTFG?=
 =?utf-8?B?K2lkekdzMFpyVHpGU1MwaFd1Z291L1hVRHFudlJ2WWpRMFMyTk9JaVNPMDdj?=
 =?utf-8?B?RGJKSGFVa0c3b09vS28wNUpPR1M0b1BYR3JUc1VJT0l1SjRDaU1QSng5aDVE?=
 =?utf-8?B?Z1l2NHdESVM0ZnJXQkJpS2g4aHhPV2hnRjNJeVh4ZFVpcjNPWFhuK2pHOUV0?=
 =?utf-8?B?TVJQZHhoeTg3WW9OaFZ2MGFRMVhvdkZvZ3EwdElCVlgwTUE4cFllbXRCZ2Mw?=
 =?utf-8?B?VG0vQkpqTXhSQkxwSHo1WUtpd0ozOWhDcVRpVGw2UytVc1dlZ3JkaXZKZkdv?=
 =?utf-8?B?M1h3UGMyVDNsV2twZSsxVGhTYlIvQVROSDFodWljNW1lYWlnRTlLTGpUTGNS?=
 =?utf-8?B?aEJZKzhiUHdhWUNSTkUrVklVQmVlMEVHTStWUzN5YVpuamsvSmNndnFnR3ho?=
 =?utf-8?B?b1hHWTRvaVNYUVdsV0RITFBSdmxKQVI4Y0VXYW91cFVsRGEzTnpURzFUSEN0?=
 =?utf-8?B?K3VROCtqSDUyU0RQYXowbzBoVG5PaFdHc2hGYVZNcXFwYzh0QTNIYkNxNU9J?=
 =?utf-8?B?Y04wY1hJdTZ3UHpkbkFHalN1cG9QZEtDaGt5YlpOSzlub2hnRFRwR2FXTGNF?=
 =?utf-8?B?UjBIN2R2bUZNTkdhS1IreHIxUGVlekRMWUliandwdzNKb0JIZTQzaE5tcG5S?=
 =?utf-8?B?bWZFbUZMUjZFeEEzalQrbE5tV09lK2FuSmc3OWxjS0I5dFZjODRLM1daWlk1?=
 =?utf-8?B?Qy9pRURnemFYODBvbkd5amVXUXB6WWYrQTRBbGJSNEQwbUhSWnI3N2VEeTNn?=
 =?utf-8?B?bmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kJ5sWp/ypM+icSI3iU9aLrhoZAS+kbRB9y2vJKsD4cKG3oJ09K0k22krTIPm0+gn2pGB+m9byuCa4LCiowZiOApsQ66hf/oV1VzdeTxFA24PC3454I+NJxbrHvQmKANbQAyr9Y9qDn8JkbwsqyM8XeUga5zRwqrjCMdJgOfd5B/jXwa395O5on68WNob4zBy7Uy2BZeJDPbnDlsH1mYOzfl920c8No3PdgjsJWd68v/3E2mq5ZyXM+GK02dlWWytlIE5ZBcKgzAKPtb6JDLBSkZYnAaeCY7omGbdYfwbNdxRx63FGHPyoeDlb2U+v+IDs9vaOZmVaUdD9lqPfH3yIxEI9+qh6twNxIZAjUOVdrMTc7s3ras5ZCGhK6qp8DHNlH/iRfxt8GfDv8mSQ3Tgef0V6o2NLqAXVVI6mqDcYqOkgfLvHRkx6ZB++diZHq8tCrVnj6c5WQcdYsy7l9bulS9DTrxJakl2aZpz+Khj08E7FYJr7h9lGcSotSqePgAcAnF7+GA1NDWcXO4TBtsTI/JwGXq8b8/EqMqw7oX9KylvoqPu0/YG7aELeSsm44PKIAtHGq90aDzGK8OoUD08cpW19E/vxZtYb4y4UpYMhfM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7d686a-1a4b-4b62-1e23-08dd371cbd0c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 17:31:12.7761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YblbwmuqQz5sFfaFSAWAa38K8gPYNYDlszstWdplxRTIb7dI7UHtvsoh6FAFOYMi0Q6IhAKIGvdwCRQz454S3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4496
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_06,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501170137
X-Proofpoint-GUID: qBcV5Hx2OgLcP-SLxXNl2NOlKRMs_VYo
X-Proofpoint-ORIG-GUID: qBcV5Hx2OgLcP-SLxXNl2NOlKRMs_VYo

On 1/17/25 12:00 PM, Jeff Layton wrote:
> On Fri, 2025-01-17 at 11:56 -0500, Olga Kornievskaia wrote:
>> On Fri, Jan 17, 2025 at 11:43 AM Jeff Layton <jlayton@kernel.org> wrote:
>>>
>>> On Fri, 2025-01-17 at 11:32 -0500, Olga Kornievskaia wrote:
>>>> Currently, when no active threads are running, a root user using nfsdctl
>>>> command can try to remove a particular listener from the list of previously
>>>> added ones, then start the server by increasing the number of threads,
>>>> it leads to the following problem:
>>>>
>>>> [  158.835354] refcount_t: addition on 0; use-after-free.
>>>> [  158.835603] WARNING: CPU: 2 PID: 9145 at lib/refcount.c:25 refcount_warn_saturate+0x160/0x1a0
>>>> [  158.836017] Modules linked in: rpcrdma rdma_cm iw_cm ib_cm ib_core nfsd auth_rpcgss nfs_acl lockd grace overlay isofs uinput snd_seq_dummy snd_hrtimer nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rfkill ip_set nf_tables qrtr sunrpc vfat fat uvcvideo videobuf2_vmalloc videobuf2_memops uvc videobuf2_v4l2 videodev videobuf2_common snd_hda_codec_generic mc e1000e snd_hda_intel snd_intel_dspcfg snd_hda_codec snd_hda_core snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd soundcore sg loop dm_multipath dm_mod nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vmw_vmci vsock xfs libcrc32c crct10dif_ce ghash_ce vmwgfx sha2_ce sha256_arm64 sr_mod sha1_ce cdrom nvme drm_client_lib drm_ttm_helper ttm nvme_core drm_kms_helper nvme_auth drm fuse
>>>> [  158.840093] CPU: 2 UID: 0 PID: 9145 Comm: nfsd Kdump: loaded Tainted: G    B   W          6.13.0-rc6+ #7
>>>> [  158.840624] Tainted: [B]=BAD_PAGE, [W]=WARN
>>>> [  158.840802] Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS VMW201.00V.24006586.BA64.2406042154 06/04/2024
>>>> [  158.841220] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
>>>> [  158.841563] pc : refcount_warn_saturate+0x160/0x1a0
>>>> [  158.841780] lr : refcount_warn_saturate+0x160/0x1a0
>>>> [  158.842000] sp : ffff800089be7d80
>>>> [  158.842147] x29: ffff800089be7d80 x28: ffff00008e68c148 x27: ffff00008e68c148
>>>> [  158.842492] x26: ffff0002e3b5c000 x25: ffff600011cd1829 x24: ffff00008653c010
>>>> [  158.842832] x23: ffff00008653c000 x22: 1fffe00011cd1829 x21: ffff00008653c028
>>>> [  158.843175] x20: 0000000000000002 x19: ffff00008653c010 x18: 0000000000000000
>>>> [  158.843505] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
>>>> [  158.843836] x14: 0000000000000000 x13: 0000000000000001 x12: ffff600050a26493
>>>> [  158.844143] x11: 1fffe00050a26492 x10: ffff600050a26492 x9 : dfff800000000000
>>>> [  158.844475] x8 : 00009fffaf5d9b6e x7 : ffff000285132493 x6 : 0000000000000001
>>>> [  158.844823] x5 : ffff000285132490 x4 : ffff600050a26493 x3 : ffff8000805e72bc
>>>> [  158.845174] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000098588000
>>>> [  158.845528] Call trace:
>>>> [  158.845658]  refcount_warn_saturate+0x160/0x1a0 (P)
>>>> [  158.845894]  svc_recv+0x58c/0x680 [sunrpc]
>>>> [  158.846183]  nfsd+0x1fc/0x348 [nfsd]
>>>> [  158.846390]  kthread+0x274/0x2f8
>>>> [  158.846546]  ret_from_fork+0x10/0x20
>>>> [  158.846714] ---[ end trace 0000000000000000 ]---
>>>>
>>>> nfsd_nl_listener_set_doit() would manipulate the list of transports of
>>>> server's sv_permsocks and close the specified listener but the other
>>>> list of transports (server's sp_xprts list) would not be changed leading
>>>> to the problem above.
>>>>
>>>> Instead, determined if the nfsdctl is trying to remove a listener, in
>>>> which case, delete all the existing listener transports and re-create
>>>> all-but-the-removed ones.
>>>>
>>>> Fixes: 16a471177496 ("NFSD: add listener-{set,get} netlink command")
>>>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
>>>> ---
>>>>   fs/nfsd/nfsctl.c | 41 ++++++++++++++++++-----------------------
>>>>   1 file changed, 18 insertions(+), 23 deletions(-)
>>>>
>>>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>>>> index 95ea4393305b..079c1fe2eee7 100644
>>>> --- a/fs/nfsd/nfsctl.c
>>>> +++ b/fs/nfsd/nfsctl.c
>>>> @@ -1918,6 +1918,7 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
>>>>        LIST_HEAD(permsocks);
>>>>        struct nfsd_net *nn;
>>>>        int err, rem;
>>>> +     bool delete = false;
>>>>
>>>>        mutex_lock(&nfsd_mutex);
>>>>
>>>> @@ -1977,35 +1978,26 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
>>>>                }
>>>>        }
>>>>
>>>> -     /* For now, no removing old sockets while server is running */
>>>> -     if (serv->sv_nrthreads && !list_empty(&permsocks)) {
>>>> +     /* If we have listener transports left on permsocks list, it means
>>>> +      * we are asked to remove a listener
>>>> +      */
>>>> +     if (!list_empty(&permsocks)) {
>>>>                list_splice_init(&permsocks, &serv->sv_permsocks);
>>>> -             spin_unlock_bh(&serv->sv_lock);
>>>> -             err = -EBUSY;
>>>> -             goto out_unlock_mtx;
>>>> +             delete = true;
>>>>        }
>>>> +     spin_unlock_bh(&serv->sv_lock);
>>>>
>>>> -     /* Close the remaining sockets on the permsocks list */
>>>> -     while (!list_empty(&permsocks)) {
>>>> -             xprt = list_first_entry(&permsocks, struct svc_xprt, xpt_list);
>>>> -             list_move(&xprt->xpt_list, &serv->sv_permsocks);
>>>> -
>>>> -             /*
>>>> -              * Newly-created sockets are born with the BUSY bit set. Clear
>>>> -              * it if there are no threads, since nothing can pick it up
>>>> -              * in that case.
>>>> +     /* Not removing old listener transports while server is running */
>>>> +     if (serv->sv_nrthreads) {
>>>> +             err = -EBUSY;
>>>> +             goto out_unlock_mtx;
>>>> +     } else if (delete) {
>>>> +             /* since we can't delete a single entry, we will destroy
>>>> +              * all remaining listeners and recreate the list
>>>>                 */
>>>> -             if (!serv->sv_nrthreads)
>>>> -                     clear_bit(XPT_BUSY, &xprt->xpt_flags);
>>>> -
>>>> -             set_bit(XPT_CLOSE, &xprt->xpt_flags);
>>>> -             spin_unlock_bh(&serv->sv_lock);
>>>> -             svc_xprt_close(xprt);
>>>> -             spin_lock_bh(&serv->sv_lock);
>>>> +             svc_xprt_destroy_all(serv, net);
>>>>        }
>>>>
>>>> -     spin_unlock_bh(&serv->sv_lock);
>>>> -
>>>>        /* walk list of addrs again, open any that still don't exist */
>>>>        nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
>>>>                struct nlattr *tb[NFSD_A_SOCK_MAX + 1];
>>>> @@ -2031,6 +2023,9 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
>>>>
>>>>                xprt = svc_find_listener(serv, xcl_name, net, sa);
>>>>                if (xprt) {
>>>> +                     if (delete)
>>>> +                             WARN_ONCE("Transport type=%s already exists\n",
>>>> +                                       xcl_name);
>>>>                        svc_xprt_put(xprt);
>>>>                        continue;
>>>>                }
>>>
>>> This does seem a bit safer than trying to dequeue a since entry from
>>> the lwq.
>>
>> To be honest I don't understand the value in being able to remove a
>> listener. There has to be no active threads. Then somebody has to do
>> nfsdctl listener +<protocol>... but then decide oh wait I dont need it
>> and do listener -<protocol>... then increase the thread count. They
>> can (-) listener by running "nfsdctl threads 0" again and that clears
>> all the listeners anyway.
>>
>> Is the ultimate goal to remove a listener on an active server? If
>> there isn't such a goal, it seems better to remove the ability
>> altogether.
>>
>>
> 
> Mostly I added that because you could end up making a mistake when
> adding a listener, so I thought that being able to remove one would be
> helpful.
> 
> If the consensus is that it's not helpful, then I'm fine with dropping
> that functionality. If you do that though, then I think you need some
> mechanism that is more intuitive to clear the list of listeners than
> "threads 0".
> 

My sense is that automated CI/CD will want to create and destroy NFS
services, and that will need a mechanism to remove a listener that
is no longer wanted without disturbing other active listeners.

I can see this being useful in a containers environment, for instance.


-- 
Chuck Lever

