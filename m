Return-Path: <linux-nfs+bounces-13285-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF9EB13BE9
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Jul 2025 15:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02147189DF60
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Jul 2025 13:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8528B269D11;
	Mon, 28 Jul 2025 13:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nJ7RPL/x";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uTLLvx6A"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35181A0BD0
	for <linux-nfs@vger.kernel.org>; Mon, 28 Jul 2025 13:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710542; cv=fail; b=f0csWkPe5KEwu7+UokjAvfvT+89xkzypUTYal2scXCbH5DPJh/RauWxmXxEWXvyAbAPcPQAtUs2G5itvD6bCTGvvImkqi6wcSnyCz6GYqKvcNQlT6LT+Q6encliz5hkQ5I90drE5oVsZBD9INvgDFRdTnYT2RCDY7DYLixC1+mM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710542; c=relaxed/simple;
	bh=aF3kvf4UbuqG3FbwHHzTE5VUrcX8TTrvmsGqh3JYcYE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aTIY8wZUtv/ymZ7URFc0GFmWh6Cp0f7x0c9BnedToQmN8ZeQNZtZUpO5itdI849ILmSoUnzFb0+mLLMuK/z7XQ7JcTikiHyrVQFPAJACrlcLrAcztVFTCnk50wVfZWJYdVrurjFuctpFWHzDZjXKC46gfiHqalVuOyXbHAn6Xc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nJ7RPL/x; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uTLLvx6A; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SDCSxO020115;
	Mon, 28 Jul 2025 13:48:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=b5MX4n0M7R1JieawLh7CJojee2N7JHh7xK2RI6m302c=; b=
	nJ7RPL/xL2LJQk2ROYp9NfNTW1aDllh+cd803JLskEH6/2khxIMpqEH5vNhbdS0g
	k5nP1WxalSovAXFYT60m+LRvc2C2yHwOAiImJ8RkJ33o/SPQVnYh7Hqe0UtiLlQ5
	ofRpbqvnKaP7pz5k/p3KtzvUqHqdkXZVUgMOVhcx2lponiAj5ExdeWRWfUBK170J
	lJpJTvsvaZW+H07EfJdkOP3ptxjwhLY5WR1RSqd+MPIwo4o+VKyQ9mEE2i9rMi2R
	0xsf2FInyPFBsOWDsBOuAmP2gSFqnji2DeGXW33Pc6B+JUo9D8Q6yU9Pw5ne0H4K
	0iuDkBdh/FtPWfIw6YrBnA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484qjwkwtd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 13:48:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56SDIou6003020;
	Mon, 28 Jul 2025 13:48:55 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nf8kte8-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 13:48:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PjOjjnV6hXGd6F0eW5gAD65IFlTRTbUS5O166GRD5yvZgy3Iuzq4TMgdNECIk2vQz+mnQIhBxEMOyOGOMkEqW7ZFbZDUHXiEx3DHMeZdxAp2teImJTzkWjZyQDOFgEeYBNMvnn0DWve3EwWzK9SgbXBRIRiLP5jqtQriXEOjo0oqlCKwSvO7O4WVE7RYeXjuInrxVriY3FZu94ILg8jnioB1/UgZxx5antI77koMpYpZ6QiSVZtDGjJqRLfLKDZhjqOvRV9FN83ffb2GKIGTjC4s8vtB75LOY4XpwBZIxtOPOqHV7wkyjkr8DNtBeZyh4ymxBpCDIIskrKDgbNTU2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b5MX4n0M7R1JieawLh7CJojee2N7JHh7xK2RI6m302c=;
 b=NvuRVJwYRgTveZN9Cp3h5b09gXGuEJVyOHuRGQgR5JIGz6jzNX8FjW5Lx+jwRQ97L24NDNgZSUoj+TMFBXt9iI8O/jbyxAOszMNGHJUCcUSX6wp7RxZ0MDoP36BU6LNe44uelg/ZmBIyrJq0hx0PKMsRdd5ur59Ri9PeMIg/QaOneaZcyYgWoZqAZlNVCQOuKy2OI2Smammj/0ayzYcXblBse8AYWjqUAJx0iNA/tvyErWC28K1atimrPOBc1kFNXkqkbHFGaoRdKAby1K12P2a9n1ccg/kRaU0XTOw7WGiLHjUoit4nr3wrXhGtudEhvzjDBzBq2HYppx0JDSmxDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5MX4n0M7R1JieawLh7CJojee2N7JHh7xK2RI6m302c=;
 b=uTLLvx6AwIVvpxHXTQyzh9L4VaviO0OSQ+3Cc/OYbk00FkofbgXmKH8Tbs+YYb1g6UrcW2zKp9yBRcPOVnlqn4bErPKfFVXmovgPmHJvr5DA+RnpmgFlV5E8sJFgnyi4aNWUV2lUUD9frDDtuEQjP+BlxKiJGjh9CauMjun7lPQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5185.namprd10.prod.outlook.com (2603:10b6:208:328::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 13:48:51 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8964.026; Mon, 28 Jul 2025
 13:48:51 +0000
Message-ID: <71179dbf-5299-45af-99c9-30b951018553@oracle.com>
Date: Mon, 28 Jul 2025 09:48:48 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/13] NFSD DIRECT and NFS DIRECT
To: Mike Snitzer <snitzer@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@oracle.com>, linux-nfs@vger.kernel.org
References: <20250724193102.65111-1-snitzer@kernel.org>
 <4db9d3dc-a2a3-4907-83bc-8bc07e38b265@oracle.com>
 <aId-28yBUQ9dBt21@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aId-28yBUQ9dBt21@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0251.namprd03.prod.outlook.com
 (2603:10b6:610:e5::16) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BLAPR10MB5185:EE_
X-MS-Office365-Filtering-Correlation-Id: f47abb74-0770-43eb-f645-08ddcddd7c14
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?MGxwMjlrSVExaTNRUGhnNHdVVUpCaENvTFV3MXlFZFdPaXlpRnFCMnUvemJM?=
 =?utf-8?B?eHhZcHhiSEZsQVhOclR2ZmpyM2lkSDBhc3BmcnV1ZzNtWTNSMXp2R1V0QUkr?=
 =?utf-8?B?Q2FHMG1EcU9FaXQxYmdZZEk4UDVpY2NKZ1ZmNURETG0ya01YRFI4R1FUaktv?=
 =?utf-8?B?Zm1XUnZjODN5M1lvdVE3RU5oNzBTSDVKRWlTcXBoeWZybUxpWWxXSVMwanFG?=
 =?utf-8?B?ejljSDQ5cTA4NERhaVhDVEdQakJIc082SmMxZDBod2RTbExrRzZBTnJRTEhV?=
 =?utf-8?B?NEpQamFoTWpKeGdKY3pEdGZ0NG05Tk9ORDY4bCtBL1hOOGRJVE1NQ29aa2p4?=
 =?utf-8?B?dkdEbnRRZWZuaEZ2RmlpSm51YlAzTEY4djZ5UmZQVHBVNkV4VGp1VU5yYUFz?=
 =?utf-8?B?dVhnTFlWWEtZT1BOdThJaGM4WEp6eXZ6cGtaVlpVUWZaRVpYVDU4RzQ3alZR?=
 =?utf-8?B?ZXhnckJhYVBYY25rYlRHbUc4dlQzV1JQcUxRUkJJN1l4MFRUNmhLaktLSXE3?=
 =?utf-8?B?ODJNNTFaMzJqRGhmbis4TUgyYUVLVkh6T2gwYXVET0QzbFpWbEFqenJKTjZF?=
 =?utf-8?B?ZDlYRHNXRTVDNlNLVGpkd0VCd1pJclRLYTNiem9nOCtyUjg3NU5XQmZhTC8r?=
 =?utf-8?B?cHpGL3FaNTlPN3dBMzQyNzVyWmtaa3BLNi9maE00Q3ZwbzdUV2NaMmwvangv?=
 =?utf-8?B?RHpQbzRRSHY3amxPMnhaNlRFb0p2SFFMVjRXdVJ3QkVPZUpHRHd6RTNseXBv?=
 =?utf-8?B?OWlDZmJRVmI1MCt3NURHTzNvenBwcGRjQ1NjZ0ZnRmorczdsOXdHZURMamtS?=
 =?utf-8?B?RmZIUWlQSytoWElDekNRamhZZjFDcm9Xb2hxNFNrNGg1cmVLbWpFc1NZeUF2?=
 =?utf-8?B?TWVvdXVCV0t2Q0kwa3J0YllxdGRBMm9ndGJreVU5ZjQwa2UzZ1RBUVllRUNO?=
 =?utf-8?B?TTBCSDdJbTFuOWJjN3VUN3JtblphNHppM3dHYVFaQ0p3d3I2RmxKYWlTeDNO?=
 =?utf-8?B?YzNTKzFtZ2dIWUtNcURraGg3VWNES05PY3lUVmdSZTc4NUJkMDNGMThVc1p6?=
 =?utf-8?B?NHJQNUM1NHhYVWh4dUlxYTk2RTNQa2hCQzBvNk1BSDB2aXZHOUpmVWtScGx3?=
 =?utf-8?B?dUhhWVlyTVVsMDNxdWt0SVY3Qk81MzdZd25ybXJ6ODhma1BnL1FIRENjUlFr?=
 =?utf-8?B?b3BUenZTK2VVSkdHa21CUFBnNDNUU28rakZkSktWQ09PQnhTb0ZFdno1eXNp?=
 =?utf-8?B?SUM4eExyQ3ZuZWIrQUVPbG5NdGZyNjRjZmFSbFFRQVppTFBKT09zM0d5NGR1?=
 =?utf-8?B?MGtHVkc5OGtGZlc2RzlpRG1nMWNKNnRPMjNxNk51b0R1NTQzZkg5dmM4ZVg1?=
 =?utf-8?B?b3VZZHhCVDEvTUluUjhyaHZaOENPWThyeHlxa3FmNmJRcVlRUzAyeklRb3NZ?=
 =?utf-8?B?NjlRZWhhenZUYXRvL3UvaHBnWnNqcE5XMkRja0c4eGRrVzQzUWNyc00rajVP?=
 =?utf-8?B?WFo0Z3daUk9PYXBEK09tQVpDRzRZLzBFVm01YWU2VkovM00ydFNMak5KNjF2?=
 =?utf-8?B?QVlxLzJyOFREV1Npd0lmaHFGTkpwYVhXT3NyZ1ZtYWNNV2Jrc2dzRy9JaXlr?=
 =?utf-8?B?NlY3d205Yk9SWWc3cjMvd2ZNWFZ4bTRnczFXVzlnUlpJRkdPcmlhRnNCa0hE?=
 =?utf-8?B?VTRKMEhOZXp4M09QeFIxM0h0QXBWZWtMRVE4Z2t5ck9aY1lXdTN2SXE3N1lk?=
 =?utf-8?B?SlU5Sk9IQndDMDRKOFFoaWRJSUxDa29oeUZGQm00RzJ0NnkzZDhYdlFiOENt?=
 =?utf-8?B?bUFuQjE0dDVpdG1LOVFpNTgvbmZtSW0vWmdubVBYVm50bWVEbnRhczhzUzBx?=
 =?utf-8?Q?xLvsOlNjas5md?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?QkJ5K3ZOM1JkRVp5TnlJSmwrUTJVSjcydWFaZVRKd1I3eGNzQzZjY2o0V1V1?=
 =?utf-8?B?SkhTblhaSkQ0K2Z6ZmRGc2Z6b3pJbHNxaUM2cU42TTVwNjZ5NVU1RVJ4WEhh?=
 =?utf-8?B?R1lZSG1sYU5yYzdqQWdMdXNuOGp5NW5US0NTMUhtRndFOHBLWXpSVWdwYmY2?=
 =?utf-8?B?Y2Q4QmRCenowRnZLays0azlncXlqRGo5VUpXVXJlb1lGMVd6d3ovbHBrOXcz?=
 =?utf-8?B?M3VrN05MK3FuZVZDVVFnejFzVWtTWFVLSnJzOXc4QjRPTC9mL3h6bWIreUJq?=
 =?utf-8?B?Y1ZqQVBCL1k5bHFKQkJGYWtJTC95dUsrVWE3VFZ2aU9rZzF2V042aHFOVkVZ?=
 =?utf-8?B?MGtGVnRYVUhKNkYrdkRJTXFwQXdGUUM1N3RVWnEwbndoMmxsbHVzY2NzaXor?=
 =?utf-8?B?bXV5d0NVczhXaGlMYkZ3R3ptZkUrb0pVV013R1dSZWpCSk5oVThEcE9BdTVp?=
 =?utf-8?B?dGd3L0pLdDJRUC9pRzJFQnh3M2NCU29ydW91eUpDbTdKSGg5eGhLdkc2c2dH?=
 =?utf-8?B?cXB2U3h2S1J4amNCZVNzTmlJUjZZRjlLWWd0VklOZFp5bFl5U09kb2Y4azBM?=
 =?utf-8?B?OE1BOGVveGYrVVhXSlMvdG5qZzZyUm8vVUhORzhtOUpoZ0liRTNsSGhWVUtm?=
 =?utf-8?B?dmVwbE1VUVdsZ3V5MmJqL0xzaS9XUU5vaFZKLzV2L0hvTFRpVndjdWRuc3Vl?=
 =?utf-8?B?c1diRi9JcWxWWHhVR1R3eGVWOVBPNGVkZ21zODhtTmJycDJoVWZCMC9vbEdY?=
 =?utf-8?B?VHp2OTl0SDk0aWxRSmhEenB6V2xzdFZUcGZSYTRaZmMvM09ZYlU5Njh5Z1kz?=
 =?utf-8?B?b2FlRWIzeW9MV1dic1MxZTZmdUtIQ0ZKUWdiKzlmVnJvc3c2RUluYkdDaVhR?=
 =?utf-8?B?OUt6eXFoSW9sODlTVWswN0MybzdyU1lzSzdUM3ZIbEFxYjMzNTFuQjNCbGV0?=
 =?utf-8?B?RmFCWGFISjFpUE9KWitiSVcwaU5CK3R2MGs2cWRWOFZlS1ArWVlobUVFUjd5?=
 =?utf-8?B?ZHNDZTV5TjgwV2RyUzRpeGRGQk5KYTBFRzlSRnhFUnVjU3hsZ3BSazUzbjJk?=
 =?utf-8?B?MjFEV2pWMlZlS1JNbkRCa09xaU9aZzlnZTUxUWhaK0ZmUVlpa1JIU0Q0bDRx?=
 =?utf-8?B?dUpZNHh5aXVVZ3FYNDNjME5OR3hEUU1RaU1jUy96UUs1dE1xY0pGWTdUTysy?=
 =?utf-8?B?SGRuOUloaGV5SVdTeUFOQTU2Nzkyb3k4ZXNNUzNON21TaSs0Yjc0RVZkanN3?=
 =?utf-8?B?dnpRaTdET2tCZVVSdklGaExtL0l3TmVRaHIvWDQ4enRkYUdZR2ZLejhWQ2k0?=
 =?utf-8?B?R3ZMLzRrYlR2VHBva0xRa2NncUJBN2dwcDBIeXViblYvMm9pd1VBS29OVXdk?=
 =?utf-8?B?dlZrL0RTVVU1SnNrWGFGRzVLRkpPUFBST21BRWJjSTVyYm90a0lmZ3VoVUQx?=
 =?utf-8?B?N1ZvU3hGcHZHWU1XS0NuSWtKNHFUY1BlZmxFaXhDL2lpWE92N2ZJQ2RUbmRa?=
 =?utf-8?B?L0E2WDZGOTVGTmFhL1JTam9Ra0V4d1J5Qzc4Vk1hWkFZZXhqeE4rRmlaaFNr?=
 =?utf-8?B?L29ZQSs5Z3l6RjF3UkY5OHhwQkFwWWRTbHNWK2w4M0FXS1I5UmZkMmNsd1A3?=
 =?utf-8?B?dGk4THNTTzc2dHZCMFBFUDFPUkxCMDdhQ05HMWsvcjZKUzlRelRNNjBxQU1l?=
 =?utf-8?B?UFVKM21CdG1NN0JXM2Y0VlpMZmI2OStyaWpKdzZPOWgrbVBIR0l4d2xhYzM0?=
 =?utf-8?B?OFAyZ2xiOXQza240a2lnMjdESXF0d3RteWNGb3J2RHBVTUtramdXMWp6SlVZ?=
 =?utf-8?B?d2thTi85Nm9HTWhEeldHWVBJbG82ZkcrczlsLzBRR3dua2NGVjFwbXpBMUFO?=
 =?utf-8?B?bGcrcUFtYUo2bGFiMlcxYTRaVWJMQmQ0ak8rSlg4dDhTUC9HaitBR2ZVU1Qy?=
 =?utf-8?B?ZkFKckxBWitML2pxK0lKN1RrWWw5UHNDQ0xEMkk3ZE9tWTVDRkRDVjFaMzNy?=
 =?utf-8?B?NjBsVzU2WkViVk0yZG85RXBkOExBMjRRdjRTRUVnNFVRemVvbHBUWWlBbnIw?=
 =?utf-8?B?MnlCQjVoM2w4SDBsOUhFOXlmODE2RWJOdkZlS2lleTVYNmdhRm1XTTNmQ0dm?=
 =?utf-8?Q?3yVAr/lD0v3dLAphnfPb6Tsrt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9oHovshtaJuxbPIGDYFr+KFgLbtk/asX9JHq1IK0mvm6/yCikkKENua4uPHxpBMF7AmjmLKjb9AJtL6LOGNTNF2AcZMK5T1qSfjanRt+y8eCNMiMx/Y/h5jDLh3ZILcxXrHMDQr6kOZochmvOhDAlMxVGjKtEamu/A6uFvLffTvQJC8HsS3AfSqhQY8N5a8FXJkR8ggUG123xINgtlW2DDd2mue+KC392k+WcnJkD+tRtZvUWtLDXtkoq0LIUQT4kS/j6WN8djL2xycNsRGLsERQcvwKfUm2EURSOvtN5jW7VPjvfUg+F0NZ48Sw4DNhP+0ybrPLbWYoFlHxLCGjyCZhOWMU/RTESSu7lEifIAaxtc0B+qdqytJ1UnHmPGwmh9NA8babxIXCQyZZS6L+gWjzuTVYcTuPOTeYFkepoG5uUF7F1DhQ397x/P2nS2vEd+E8UCs0jaYyusr9gVOvBmUE1d41HHz6xJkJO4ch7ZxtMZdzoRV3+Oi3XIe8HwWm3kfKPNM332jBejq/6vrSuoPVlybfsjJCCsQAuHlQPokM3gSSv+i/EOLrsrf8bObRaLCszuOTouMraUSr7OUjTqXAgjETk+KyOUx7SJCxOwE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f47abb74-0770-43eb-f645-08ddcddd7c14
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 13:48:51.1744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZYorftIU/SM637sVNsAhnIw2m7A+FijP/DaHgqbr5+3+KrCSKEyd2Oc4denTgYeWllK9jlyBJHXBTOVr8h9Oog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5185
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=647
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507280102
X-Authority-Analysis: v=2.4 cv=OvdPyz/t c=1 sm=1 tr=0 ts=68877fc8 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=WLGaNtMBAAAA:8
 a=IFvAzyrh4aVWQqOb5nUA:9 a=QEXdDO2ut3YA:10 a=gcKz3hfdHlw52KqWNJGX:22
X-Proofpoint-GUID: aCN7kU5dscrkZI3InIVdjFWI69Jeehi4
X-Proofpoint-ORIG-GUID: aCN7kU5dscrkZI3InIVdjFWI69Jeehi4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDEwMSBTYWx0ZWRfX1t3rWZDXszBL
 gAsoSOIkoKvVo56Oa90EWAGESO7n3RiIqMYWSSbd51IPncky8bZOkwNbuIQKt5Y8oQIx/vz5hfn
 vvZ1eFMDvMnGQ+hduDK0lG1LllddlPIokoM/7zomZ5P5SNkvwyKndyR72iKi1t8gyvEbLPjY80s
 k3sOqTFQX16PWbPJT222At2ySQEVM5wA2Un0Lq5Rqe2+mdiE+PWpFzSL5z43jAtsNQsOh1daWif
 bvij2FpQDmqYMwwZMVIPz7e4K0zv0ruYCuaqKIq8QCKUdig3VdQ8WNNoEVUi8CgRDpnp6NloYeh
 L7y3ib7yTid82QQj1wZStf+q1ZEbv8JuUbErhVnRVfNy225RYq50H0FfdNJY1c7WG8x0UGy4ZjI
 Ag/4pgr+i7gy6ljm0duvmoyF4L2RsAQ/ViKlKhf5F30vgMFZ4r6ap1nM8eTqDlDUtiUwMnfp

On 7/28/25 9:44 AM, Mike Snitzer wrote:
> On Sun, Jul 27, 2025 at 11:39:18AM -0400, Chuck Lever wrote:
>> On 7/24/25 3:30 PM, Mike Snitzer wrote:
>>> Hi,
>>>
>>> Some workloads benefit from NFSD avoiding the page cache, particularly
>>> those with a working set that is significantly larger than available
>>> system memory.  This patchset introduces _optional_ support to
>>> configure the use of O_DIRECT or DONTCACHE for NFSD's READ and WRITE
>>> support.  The NFSD default to use page cache is left unchanged.
>>>
>>> The performance win associated with using NFSD DIRECT was previously
>>> summarized here:
>>> https://lore.kernel.org/linux-nfs/aEslwqa9iMeZjjlV@kernel.org/
>>> This picture offers a nice summary of performance gains:
>>> https://original.art/NFSD_direct_vs_buffered_IO.jpg
>>>
>>> Similarly, NFS and LOCALIO in particular also benefit from avoiding
>>> the page cache for workloads that have a working set that is
>>> significantly larger than available system memory. Enter: NFS DIRECT,
>>> which makes it possible to always enable LOCALIO to use O_DIRECT even
>>> if the IO is not DIO-aligned.
>>>
>>> For this v5 I've combined the NFSD and NFSD patchsets because the NFS
>>> changes do depend on the the NFSD changes.  In addition, I think it
>>> makes sense to review/test these changes together.
>>
>> I'm ready to pull the six NFSD patches in this series into nfsd-testing.
>> IMO we want regression and performance testing of NFSD, outside of the
>> LOCALIO paths, before claiming merge readiness.
> 
> Makes sense, the NFSD changes are independent.  LOCALIO's access to
> the dio alignment attrs in nfsd_file is a convenience.

As I was drifting off to sleep last night, my mind hallucinated the
idea that maybe all (three) caching modes should align the READ
payload. Would that make sense / simplify 06/13 ?


-- 
Chuck Lever

