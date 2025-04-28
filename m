Return-Path: <linux-nfs+bounces-11331-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91903A9F9D0
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 21:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D65187A2C2B
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 19:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531C32973D2;
	Mon, 28 Apr 2025 19:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W0/EhTa0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Rj0Ju9f7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F752641DE;
	Mon, 28 Apr 2025 19:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745869376; cv=fail; b=Wyb6RxYxnttqUyunInFb/4udk/ORxGrnD+ch1uAOlkRgYS05A8jtYtSnmpdwrYh8yCsfGhqWQkKQ4LD4A+R/QmjqrUqDNvMpsQEUl1c+jumo7R20+Lm7wAeRnERYBVCFfIku67Zq+f1vL8+2+NHVH43Ryi/FkBBQ1J6w/UJr/SY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745869376; c=relaxed/simple;
	bh=u6Iobp6hdQ/eWLrEYpS3JCtl4PTNzyKfEAAt9Aody9U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DkPAVDerMM+TYCvMjvkGUFRukM+pJoxX2KchBiQC2/v4357rg6Gcx2EF+opeI2mBoEpySmNBP482cRY8nC2hS39KRTpK8BmaHuS2mzMtEsz7MEKLYi/jlZ/iryyIR74X8d5KYdMkbaKi9tuEgHDGyIaJrOuQXQecThaSp+FHBAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W0/EhTa0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Rj0Ju9f7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SJ263O016848;
	Mon, 28 Apr 2025 19:42:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=IvNA+wgp0zuHW5/7ugFJ1lKs4UlIZQi0LEqt5NaKDTQ=; b=
	W0/EhTa0p7k1XUXGREOgl6XvH6lL4qnVBrW8XTSC27zksjUS2HtlQmuQLtgGKJNx
	PQGsZAkqaLKjfm+Hv5S63t2Ks5shDeEoPxyIarSJNCX1J1/Xz63qmNSbO0Eaccqe
	UBvnhKG7fopFL1jhnxPh/A2eXJ4yU88tV611bKKJKW4BZdVX+MIUPJM1J8AVW+BK
	HiJMnAaFWYL/jI9xe3tIKvoM1dxDdJQEEh76vrqnOjrpA80qerbsAXHefLZO0ISG
	NoRf1bzk+7ab1bxwu15JOPkdYOeeNr39yyhDS8nO0RC2uMzjw9AMLgsbcwEZZwc8
	Y6l0uJ2OnBMICKT/JVRuug==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46affpg31m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 19:42:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53SITv8s023886;
	Mon, 28 Apr 2025 19:42:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nxf4mnb-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 19:42:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vq8mBrlrppDL+R1s8Bu7fWSn/ClVuo1HmXK6QRHrfzVgNh0YDGlR5K2+RYRIBXlruqGl6l6+5jtVPik4BvUsO4A3Kd3/uCTZYvGSHBlLGl7zF76+/r9VI1gxnrco/abFl4HwIBYJ5MNh2URk0fYok3vIXuYzsHt1PzoB66a2xb2ECExv2VCL2nHrLBDVuVmTS8wN779C9HAo03xP0IIxYAroyaCMG3Rk7Xxrj64xZSe5wkM0KZotjIxUczptsjMQtKvNqR+nUlxQQ5nhjisr+Qdj/8F50dB7qBeMDYGGOEPrAEfZBqQb3elcK0RTgXT0KPS5ah82EznvvQaVxl7giw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IvNA+wgp0zuHW5/7ugFJ1lKs4UlIZQi0LEqt5NaKDTQ=;
 b=iC8m5wUfFLVTTpt3iI/iYd94EpwnZu4kA9ZwF7/H61YB8A9FCl/rKWVkyjnNbj2MmsBzoDVKoXoVz5PlpPBUHPMr4HMK6/T5YMw5NNjpvg6G5a3iz1N2T0y0tzuParTZ/IKQyjJYrg21W/sgP5CAcryC79PyelEnboV96dtmo6yvCkrwi9DqnE3AFZyCBAeYvC9XGkuczgDzbDX2qAX2EPorKfXO+85sKfGw/J4FWPI8rPurcIUwfABhUtybEBl9QdrfJKVbIZW7H9VqVBlHzwgHXzlddfv1Ufc7vtWd0UgGGN6zpkUqxec9FlEH9vmN/PKv7k3Cg8Y1Z2NOmNqe/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvNA+wgp0zuHW5/7ugFJ1lKs4UlIZQi0LEqt5NaKDTQ=;
 b=Rj0Ju9f7BAhvmu3FvT1KoTUPbMuHoSSdfKa6G7ppHcxdDFPX1LTIkQeAtPlSyHuDGkFfnYvocM59I86LQJWAYPE4AT+j18jlEhMYW9f2ad8nl1dj4H7qkSCVt5xuTl2QOI/DHU3LVPuHz/h9xMQkXns2feplKOxR6uEhnsvixSk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB7034.namprd10.prod.outlook.com (2603:10b6:510:278::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 19:42:40 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 19:42:40 +0000
Message-ID: <7150babe-3700-4297-a058-f96514424e8b@oracle.com>
Date: Mon, 28 Apr 2025 15:42:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: use SHA-256 library API instead of crypto_shash API
To: Scott Mayhew <smayhew@redhat.com>, Eric Biggers <ebiggers@kernel.org>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20250428193658.861896-1-ebiggers@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250428193658.861896-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR10CA0003.namprd10.prod.outlook.com
 (2603:10b6:610:4c::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: ad7659a2-3ffd-4da6-e7eb-08dd868cd635
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?YmxWSEw2cU5CQkg0L1lNUXB6anZBQjNEOTNCMmpqVVZQR3F6aDRadFFrNi8v?=
 =?utf-8?B?WUlnY0V6MnZKRThOTjNjSmJvcExKcHo2MTcxejNKVmpJeCsvV2hIWDJGbnJt?=
 =?utf-8?B?ZXhBWDZBdmNCQ3BsMlI1TDh0bzRyWGFteW1WKzhXa2pITS9aUzNQbU82M2RH?=
 =?utf-8?B?TXNIbm1TV1NFN2t1UyswL3QyN2MwZi9xaVloWkxBQ1pneWMzTXFkNVN5QnJi?=
 =?utf-8?B?MVloNEtvZ040WmhjeEtESmpVWCsxZFZob0F6akJqUDJpZlQ4VEFhbnBEWnFD?=
 =?utf-8?B?eHFHWHBvWWdhb1NHRDA3OWtpeDVLZzFsek1IR3JpTzlJcmVWU2k2VnE1WThm?=
 =?utf-8?B?NjA1eWIrSWhIYThHeVcyMHltaE9MeW9FS3k0eEZ5K2Z6RmxtRFhRMjVPNDFv?=
 =?utf-8?B?dTRqUnU5Q0UwZVhSZW5uU3ZQWW9TVkhwdjFHQVcyeTg1NTArdVVaOGtlbVgw?=
 =?utf-8?B?YWg1SWxMM3d3Y0RwaXlkd3cxUlYwYTZtMnp6S2l6Vk5OZVdDUXZYQjgzQ1Iz?=
 =?utf-8?B?TU5aWXRCeTJJbGdLdjlBcDVPQUlvaW9iZ2hiSUZ5aWovUFdyaGhPYkMrRHln?=
 =?utf-8?B?UDUyZVd4a05xQUVNK2lIUVFEcW1tMUhWKzk2M2lwaVk1bCs3OEh5S2J2OFYr?=
 =?utf-8?B?Y2gveTdlZXhVZFlpNDdMY2U4MkpZOTRsaE9ieVRjbFZMME0yQUlTbTBkYldu?=
 =?utf-8?B?S2ZPTmlZYlBuNG1nY2xkT0x6Q3JYZ2FiMytQbWc2SGpoMHBWeU9pcTZYY1RP?=
 =?utf-8?B?L21GdDIwUTlZUmFzM1lhUTdzVFpPOUx4UlF2Qno2b3RFTGE3UHNkbm1DdnJr?=
 =?utf-8?B?NVVTb2svQk1tWmJhWG1HL29CQjdPNnpYSU5mbm4wMk5qTEVuR0FPN3RMRm1T?=
 =?utf-8?B?RGs5SHo1MUVVcWFZeUZWL1N4Y3ByaUwzbjQ1SG56MU1SVCtxMGFrUExuRFVC?=
 =?utf-8?B?aG5HNFRKN29BdUsvd21kbEtKOUxKcXIyQ0IwZ1luckh2VDFrOUIxVmt3NG9S?=
 =?utf-8?B?Z2Y3SHIzaVl2dmFlZ2FFVjZjczdqT0JPZCtPdkhHbGhZbFlBSzVSQ0l2dHpy?=
 =?utf-8?B?SCtLZU16VWpnMCtSNnBRSEVPSmhBZ1UyRFgxYzdBYVVPZ1FsMmhSME8zSjdo?=
 =?utf-8?B?SG1IaHJ5TjdvUnpDQkVNQXdNZkZqL0JOYTNvanBtdzlLQTJNU2NYam83a3ky?=
 =?utf-8?B?dG5VM2tBRzVUbi9VWnhPaitTQjk2MHcvcm5vVVM0UnVlMEtnVmRZK0dVd0RP?=
 =?utf-8?B?V0t0MWdaNFRvbXRNeWw5SzlobzVOcUJMTnRqM3J2NlRNY2xvY1NMS29PQXFn?=
 =?utf-8?B?NFMybWdzMFRVOU9ab2JmK0hBUytwbW5DcTdMMXJRdEVrQW40Rk1ZalNYV2ll?=
 =?utf-8?B?UTM4SUl2aHgxZWZrL3VnRGZXT202UlpNYmFybE5WdVlMd0NydTJ0Q2xicDFn?=
 =?utf-8?B?ZkhYQWswQlpIQVVaRHNWY1cyMjNJbzBXNFZvNGpDNkR5WlBWTmVqdERUZWlW?=
 =?utf-8?B?WGdiN1RiZ0xNMkJZb3NLdXRZNU5ObTVycnJUT2Vja2trM0xDc1h5SkRXM29s?=
 =?utf-8?B?aWZ4RWptMVNvMG1GMU1oTTZMZDZoaTVONFJxNVBJbVZ1SWk3cjI5bjJJM3hw?=
 =?utf-8?B?ZTdxQ0g4SSttdFpTcDBMTExRdU1YQnJDUnNEaVNtUEZhS3VtaXV2MXA2RW1B?=
 =?utf-8?B?NnlkSU1ESnZ0Z3hUSloxTFcwcU5MaU9Db0tLSkJWd20xMHhGRjFhQ29vZEJX?=
 =?utf-8?B?L0FkWlJ1ZE9JQjlEVjBBOFIvbDRnNXUxSU1MWnhzQzQwa1BNNUJGSFkwVlV4?=
 =?utf-8?B?eE82dUZSWk9jWTFzcmF2K1ErMWk3WTJPNmhWd2JxYVIvNG4yZ3dhL29nVkFr?=
 =?utf-8?B?dFE0NDZLYlFMWUlCWGp6WGdRL01IZ1JGdWVRbkhXeDdNTFBXSHR0U1NhTk5n?=
 =?utf-8?Q?Kyj8no82fL0=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?djMxOVBEbC85cEoxMEdGZGJQQTZySUFPYUFNVUd1UlA4RE0rbnE2ZzRlOHJp?=
 =?utf-8?B?c3FkQnNMcHBNUEo5dFMxek1BTk5JMnNhWmJWSTFUSnFDSXh0MzZYMGpCS0VK?=
 =?utf-8?B?YUNhTzR1d1pBckpSb1RySmhvdjA2a1REdi9NQU5hOEhBRGlMVXNXV25BNW1K?=
 =?utf-8?B?TUJsamI1dm1OZEkzbjM1M25JUURQekRFNnpnMFg1Zkc1MGR0TDhrYXhKNkwz?=
 =?utf-8?B?SCt5NWEwblF1Wkx1UWY4Sy9pUG9BR2lobUYxc21OZXJ3S0dJcjRHTnZOQ0ZZ?=
 =?utf-8?B?T2lyY0h1NU9TQ2dVTnk5RXJYSDV1bmN6VGpSa3JJb2IxZVpib3B5N3pUYkpp?=
 =?utf-8?B?VFFhd05HRWYzZWY1YWppR2FVMElnWUhyK1RaWkhLZmg3NkZKVnA1WjNDUHFh?=
 =?utf-8?B?cE8yRytxbmd4RmFUZWFWTVBWdzFkd2FOSk9oUU01b2xBN1djNjZwN3d0cnlV?=
 =?utf-8?B?MFErRWhuSjR0TGZzSDVTaTU3Z1pnK0ZqNXlhOGw2YTloa05WVHN0cnZwUEdY?=
 =?utf-8?B?RmFJckdEallFQnpic2tRSnhmNFl0MmdjZGJqNGtGNWh4U01kMEtHb2dKbUdu?=
 =?utf-8?B?ZzdTbHZyK2RPMmZnMnh3YW9mY0lucnAwYXJ3cExoTTRKRXkvT1dCTXRwZVZQ?=
 =?utf-8?B?V09zazVCd2lSL2pjL2VoYlptY2djczdIcGhoTUhhdU51MnRHWEtkL3dlZ0lo?=
 =?utf-8?B?R2piZ2UzbmtHZ3pRbVlOUkUxSXFJNmdaOUQzZnVXa0RWdmJYclFDTEdkVE5I?=
 =?utf-8?B?bGY5OEhLbUgybXlsdGZLUXBRL0NCSjYrZHMzQXpTZTU1LzBsMnZPTUwzazRu?=
 =?utf-8?B?bDBUc2JzeDRwREJCRnNDUi9MVG9PUGtYalVTajBDV3R5dFZxa0dNcnM3Q0Rk?=
 =?utf-8?B?Z1lJOTFxbmVkZnFVd3gxWVNkZTZSdWRNQkRHbm5FbnVtaERPMFF6dlh1dk1o?=
 =?utf-8?B?UXM0dkhJbzFDTUdtUEFLQXhRYm9COFB1UWkwWW9TNFlCOXpDR2s5OXBLbG01?=
 =?utf-8?B?Uk9uaEF4Tmh0aVk2a3Q1RS9IZDIrMkYrdHlScXRyY2xuSzNvOHAxMTdRWnly?=
 =?utf-8?B?YkkyNDZBMnErN0R2S0lsY0h3L2JQdXJqaDBKZ3ZjenZ6cWlROXRhK3BuSm11?=
 =?utf-8?B?RmZUdVh2QlNmZWx2TVRDMzdvM0NacVR4UEdoRUMyOThnLzdwOGYyQTBCTXY2?=
 =?utf-8?B?Z0ZQUWdDUXBVd3N6bktSVEZZb2xWRGJlbWlZZVorTnN2bythbW1EalFPN0R0?=
 =?utf-8?B?N1FDcjkvcVkzZXp4ZnRSdE9CWlo0MjYxU2R0ZkZsaHg0cWRNclJIVm1XRWJI?=
 =?utf-8?B?NVdpRGxtNjdUaVBZQk9FaldQVU9lSFFHcFNvb3p3L08wZnp6ZU01NDgrcXRh?=
 =?utf-8?B?MHVWTWxMOVRyTFZzaGhYQ01SZytGSy9QdVlpem16TTdzWXRrTFUvT1JROXVN?=
 =?utf-8?B?bGtScDJ3b04vT2pWdVZ0TzBJSk5Mb2lWeURCbEgzNi9XOWJSdUd6MlVlaE1Q?=
 =?utf-8?B?M3lieFpjK1h1K3hpZ2Z0Rk01MFYzVXE0cEswOExDWlVMQWQrV0NrNVl4OG0y?=
 =?utf-8?B?N3NKNEFpRE5yWGoyNEg3VkFuSEVpTmZCRGFVVDNoQXJnbC85cmxKMGgzN1E1?=
 =?utf-8?B?L09YUTlKU3AyU0RPZy9VY2kvVGIzRWFRWERRazJ1M3dvMU9tNXR0NUd4bEds?=
 =?utf-8?B?SGEwR3NtVGlPalkrYVFjT1Jpelh5MUJrL3BxTnFzY3BPM21BTVU3V00wd3hE?=
 =?utf-8?B?K1NNa3k3dUw1K0M2V0tTbU5CN0Y1VWcrTnZ0aEwvTUNuQ0NXR0luSytEd2Ir?=
 =?utf-8?B?azM0K3N2ejBvb0lXR05Qclg2RE1mM21XdXNXUUROL2ZqNE1KS1IyUTUxMnhG?=
 =?utf-8?B?NEJZU3NaQW5LUys1enpQbWVBQVVzQWRjZjVKbHM0Zi91WjBPUjRCbjhpclY2?=
 =?utf-8?B?eVRtQlZzcHpKandkK2p2VWZ0dkdGNXZ6R1pBdGR1S1hTdThUcCsvdEFyc3Rj?=
 =?utf-8?B?ZUVEVklqTTNqVnhjVmdOY04xOG5XOTJVYzVwSE95T1JPbjFvVUVmWThmRVE5?=
 =?utf-8?B?TjdLaGRXUjVNVmc0NW82ZHhjMmQ1UlNEYzdLMzI1bDFZaEUvQVlrTUJWY0t3?=
 =?utf-8?Q?UViNS7RzdCOLxJZhqRsA7/Auv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EqACdzy4OsLcIf+MdW01Pu0IinDJozdIdRkhoikubUCPR14TXFkjBdkq2gRw/Ofa/iYYa4cLc3D9DeqZW8papWHFiyVNW9nrC4sEskXj2sHrbvINbS0xsq6TDqERp2UimoGpkW6qqFeqxbww988Apu8/J75RwB9tnjSbEcAyW8sj6JKZ50BNwUGLVmVg+6uoFNY2j0zoL10rJzXjvsNdV6+kWRVEtemHeLLBhctf9jk3cJsafdXeGO3X7koDb2hbvW0HtatVdoYAu+QH8dXKfp/UDQcJLVWfnoeKBx1lILPHb7D8ttgM9+J/w3tC+53GsQqjFvr+Py34hCN04uQa3RmnwGau0pU7wI1AzGsO5BI7zXeZ6omWKCS1NalmmRqlDZgcEx9m5rDoDBO47m+JN7pVwrarK3NU9sKpyoL2qUlKCjTkvSD2DCOoC/sysVMd58XBQHDb8xMtgWRPX6wYxRWKiC6/u2Wz8W+xKTuxu2IoyK9Hdl9dLSNay87Fx8Nu3efSpcEntDn0JKQ6xoz+xq1uqKTY3kehxGkjkJiYDRY7bvc6Zws08Ya+5aN/7kxZZrBznBHvD8J2iIs5iggIcnZ1H0t0DzkBO4p/q42BPEk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7659a2-3ffd-4da6-e7eb-08dd868cd635
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 19:42:40.5530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jrUx3tNhbYDUrM+SA0uJm5PA8/fS8CWO0OWGxKHHrwvJ633kR1swVdNPZmjKO8gNFbZuX9P4PUxhG344bYVOXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7034
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_07,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504280158
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDE1OSBTYWx0ZWRfX2ANrUjrVLX8R oFsTCI68elkhyywRG7dBJyCKMCWPA/YydPRG9oVH9XxBoUdGEcJJio7Lca5vLKRBP61KpCppHtb dt0GI2JntScIZAn2ajQGSv3aorivsfwodcwZbkjBrx4jcxvvvRQ52vEckJ3WxnJOlT3rHO1e6m6
 jEXc0icZXwtUB5pex1NavPYi4po7hzaf9CvfMQ4FyMurUhLjGqGzG4HHe6r272NlozhP8c9/mz+ ndyE+XUcgzNf26KHSD4Q8dYrC/Jrv0KuuJ7DEwi2CwmOIkg4zT26lj8hus7COdjUHVa2EC3r6HA IbEtmbkNS7rbJMvi1jDwwOq9XGkXAFnYaPynduWIme7HVDYQ8F63zTiwtA5TJEvSJ+4WyG4PY/K /4kPtAU2
X-Proofpoint-ORIG-GUID: qQrnQuHZr1uwjzKiNTZq6eV_8CqQw7nv
X-Proofpoint-GUID: qQrnQuHZr1uwjzKiNTZq6eV_8CqQw7nv

On 4/28/25 3:36 PM, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> This user of SHA-256 does not support any other algorithm, so the
> crypto_shash abstraction provides no value.  Just use the SHA-256
> library API instead, which is much simpler and easier to use.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/nfsd/Kconfig       |  2 +-
>  fs/nfsd/nfs4recover.c | 57 ++++++++-----------------------------------
>  2 files changed, 11 insertions(+), 48 deletions(-)
> 
> diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
> index 731a88f6313eb..879e0b104d1c8 100644
> --- a/fs/nfsd/Kconfig
> +++ b/fs/nfsd/Kconfig
> @@ -75,12 +75,12 @@ config NFSD_V4
>  	bool "NFS server support for NFS version 4"
>  	depends on NFSD && PROC_FS
>  	select FS_POSIX_ACL
>  	select RPCSEC_GSS_KRB5
>  	select CRYPTO
> +	select CRYPTO_LIB_SHA256
>  	select CRYPTO_MD5
> -	select CRYPTO_SHA256
>  	select GRACE_PERIOD
>  	select NFS_V4_2_SSC_HELPER if NFS_V4_2
>  	help
>  	  This option enables support in your system's NFS server for
>  	  version 4 of the NFS protocol (RFC 3530).
> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> index acde3edab7336..c3840793261be 100644
> --- a/fs/nfsd/nfs4recover.c
> +++ b/fs/nfsd/nfs4recover.c
> @@ -31,10 +31,11 @@
>  *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>  *
>  */
>  
>  #include <crypto/hash.h>
> +#include <crypto/sha2.h>
>  #include <linux/file.h>
>  #include <linux/slab.h>
>  #include <linux/namei.h>
>  #include <linux/sched.h>
>  #include <linux/fs.h>
> @@ -735,11 +736,10 @@ static const struct nfsd4_client_tracking_ops nfsd4_legacy_tracking_ops = {
>  struct cld_net {
>  	struct rpc_pipe		*cn_pipe;
>  	spinlock_t		 cn_lock;
>  	struct list_head	 cn_list;
>  	unsigned int		 cn_xid;
> -	struct crypto_shash	*cn_tfm;
>  #ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
>  	bool			 cn_has_legacy;
>  #endif
>  };
>  
> @@ -1061,12 +1061,10 @@ nfsd4_remove_cld_pipe(struct net *net)
>  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>  	struct cld_net *cn = nn->cld_net;
>  
>  	nfsd4_cld_unregister_net(net, cn->cn_pipe);
>  	rpc_destroy_pipe_data(cn->cn_pipe);
> -	if (cn->cn_tfm)
> -		crypto_free_shash(cn->cn_tfm);
>  	kfree(nn->cld_net);
>  	nn->cld_net = NULL;
>  }
>  
>  static struct cld_upcall *
> @@ -1156,12 +1154,10 @@ nfsd4_cld_create_v2(struct nfs4_client *clp)
>  	int ret;
>  	struct cld_upcall *cup;
>  	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
>  	struct cld_net *cn = nn->cld_net;
>  	struct cld_msg_v2 *cmsg;
> -	struct crypto_shash *tfm = cn->cn_tfm;
> -	struct xdr_netobj cksum;
>  	char *principal = NULL;
>  
>  	/* Don't upcall if it's already stored */
>  	if (test_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags))
>  		return;
> @@ -1180,36 +1176,22 @@ nfsd4_cld_create_v2(struct nfs4_client *clp)
>  	if (clp->cl_cred.cr_raw_principal)
>  		principal = clp->cl_cred.cr_raw_principal;
>  	else if (clp->cl_cred.cr_principal)
>  		principal = clp->cl_cred.cr_principal;
>  	if (principal) {
> -		cksum.len = crypto_shash_digestsize(tfm);
> -		cksum.data = kmalloc(cksum.len, GFP_KERNEL);
> -		if (cksum.data == NULL) {
> -			ret = -ENOMEM;
> -			goto out;
> -		}
> -		ret = crypto_shash_tfm_digest(tfm, principal, strlen(principal),
> -					      cksum.data);
> -		if (ret) {
> -			kfree(cksum.data);
> -			goto out;
> -		}
> -		cmsg->cm_u.cm_clntinfo.cc_princhash.cp_len = cksum.len;
> -		memcpy(cmsg->cm_u.cm_clntinfo.cc_princhash.cp_data,
> -		       cksum.data, cksum.len);
> -		kfree(cksum.data);
> +		sha256(principal, strlen(principal),
> +		       cmsg->cm_u.cm_clntinfo.cc_princhash.cp_data);
> +		cmsg->cm_u.cm_clntinfo.cc_princhash.cp_len = SHA256_DIGEST_SIZE;
>  	} else
>  		cmsg->cm_u.cm_clntinfo.cc_princhash.cp_len = 0;
>  
>  	ret = cld_pipe_upcall(cn->cn_pipe, cmsg, nn);
>  	if (!ret) {
>  		ret = cmsg->cm_status;
>  		set_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags);
>  	}
>  
> -out:
>  	free_cld_upcall(cup);
>  out_err:
>  	if (ret)
>  		pr_err("NFSD: Unable to create client record on stable storage: %d\n",
>  				ret);
> @@ -1347,13 +1329,10 @@ static int
>  nfsd4_cld_check_v2(struct nfs4_client *clp)
>  {
>  	struct nfs4_client_reclaim *crp;
>  	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
>  	struct cld_net *cn = nn->cld_net;
> -	int status;
> -	struct crypto_shash *tfm = cn->cn_tfm;
> -	struct xdr_netobj cksum;
>  	char *principal = NULL;
>  
>  	/* did we already find that this client is stable? */
>  	if (test_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags))
>  		return 0;
> @@ -1365,10 +1344,11 @@ nfsd4_cld_check_v2(struct nfs4_client *clp)
>  
>  #ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
>  	if (cn->cn_has_legacy) {
>  		struct xdr_netobj name;
>  		char dname[HEXDIR_LEN];
> +		int status;
>  
>  		status = nfs4_make_rec_clidname(dname, &clp->cl_name);
>  		if (status)
>  			return -ENOENT;
>  
> @@ -1387,32 +1367,22 @@ nfsd4_cld_check_v2(struct nfs4_client *clp)
>  	}
>  #endif
>  	return -ENOENT;
>  found:
>  	if (crp->cr_princhash.len) {
> +		u8 digest[SHA256_DIGEST_SIZE];
> +
>  		if (clp->cl_cred.cr_raw_principal)
>  			principal = clp->cl_cred.cr_raw_principal;
>  		else if (clp->cl_cred.cr_principal)
>  			principal = clp->cl_cred.cr_principal;
>  		if (principal == NULL)
>  			return -ENOENT;
> -		cksum.len = crypto_shash_digestsize(tfm);
> -		cksum.data = kmalloc(cksum.len, GFP_KERNEL);
> -		if (cksum.data == NULL)
> -			return -ENOENT;
> -		status = crypto_shash_tfm_digest(tfm, principal,
> -						 strlen(principal), cksum.data);
> -		if (status) {
> -			kfree(cksum.data);
> +		sha256(principal, strlen(principal), digest);
> +		if (memcmp(crp->cr_princhash.data, digest,
> +				crp->cr_princhash.len))
>  			return -ENOENT;
> -		}
> -		if (memcmp(crp->cr_princhash.data, cksum.data,
> -				crp->cr_princhash.len)) {
> -			kfree(cksum.data);
> -			return -ENOENT;
> -		}
> -		kfree(cksum.data);
>  	}
>  	crp->cr_clp = clp;
>  	return 0;
>  }
>  
> @@ -1588,11 +1558,10 @@ nfsd4_cld_tracking_init(struct net *net)
>  {
>  	int status;
>  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>  	bool running;
>  	int retries = 10;
> -	struct crypto_shash *tfm;
>  
>  	status = nfs4_cld_state_init(net);
>  	if (status)
>  		return status;
>  
> @@ -1613,16 +1582,10 @@ nfsd4_cld_tracking_init(struct net *net)
>  
>  	if (!running) {
>  		status = -ETIMEDOUT;
>  		goto err_remove;
>  	}
> -	tfm = crypto_alloc_shash("sha256", 0, 0);
> -	if (IS_ERR(tfm)) {
> -		status = PTR_ERR(tfm);
> -		goto err_remove;
> -	}
> -	nn->cld_net->cn_tfm = tfm;
>  
>  	status = nfsd4_cld_get_version(nn);
>  	if (status == -EOPNOTSUPP)
>  		pr_warn("NFSD: nfsdcld GetVersion upcall failed. Please upgrade nfsdcld.\n");
>  
> 
> base-commit: 33035b665157558254b3c21c3f049fd728e72368

Make sense to me. Scott, can I get an R-b: from you?

-- 
Chuck Lever

