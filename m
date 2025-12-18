Return-Path: <linux-nfs+bounces-17185-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3196ECCD6BF
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 20:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0954300F322
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 19:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF49D2FD660;
	Thu, 18 Dec 2025 19:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YiwGuHeI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tnglTaq3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F71A221FBA
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 19:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766086880; cv=fail; b=FpYpPX28VU1pA0D/H/AH35/+/pm/WPXXckLZXZ5RK9jPRSb7LPA6L2PEsl+3R0HNWMVq6F6jTM7ZtCYoDnUnWTkjNB/61CuHDi+HI8384GY2HOP0qRcmGsId3Rvz98BU0/WHvxKEqffQHQT2EnbiHVAX/W9sjCGZdFR6sxBGi8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766086880; c=relaxed/simple;
	bh=dbJZS900qoTbR1vsNQPx9iKpIF6k8sIUft0zJ0vEJgc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kQORPuG74vw1MdEhwwLFjZ9lGuPqPIw5CkYdqtE6XdlD4OTNwIY33eF+nFSjgrKjbx7U8pJ4/z8mbjJcKtsoH3MKfHhiAOZ6PO0ZpcT47Pu17bE2NSeiwojqQ0QcdHgruavIMLM5vD0PrGu5J7nhVrq0FL46DGGCcW0ZDxJVgKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YiwGuHeI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tnglTaq3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BIJNKnG1972684;
	Thu, 18 Dec 2025 19:41:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5xJUBiUzKs7zAWOjam3R4XSFPVjo9HcyNsv+jFWvsus=; b=
	YiwGuHeI68MtQlymhrxNRUJlRzAj0m+MMCG40J9bO5mQyoLKLvMsPgKvX+AluXT8
	REISIhWGUiIyXIqNBU3jdfUpAQQvsMfQTFnAiBe9t6pgRCdh8OHEeyvis4DMXtwI
	oxgHXPlzidaHMojuXV+AaXUmWBJahEcVi0FxBDIkwi3HMMsiz9J6NgT6yLkbM5+o
	GD/OOVumbQbXsuAAYaFvZshBJ6sTnk4TNQAUGV61ZGR0YzzFq7yKqFxfyQRxAyqd
	vp2Safkdt+Q1eWhbx9tHcGg88GG5oOlSydeo48jpGoZ+DKrYT4DF8x7aeCJdW0KN
	0cIa09ILmFosvVwkyqBbHg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b47qpsbtt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Dec 2025 19:40:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BIJTPK9036681;
	Thu, 18 Dec 2025 19:40:58 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013051.outbound.protection.outlook.com [40.93.196.51])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b4qtkgdtf-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Dec 2025 19:40:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BK7J7HkfAs2qUJnkiV5QmawA3JtT8NR+3ow9BzrweefO47tiXHc/kNWTb4aQm1vbaxqaXAIxiyGPLl/KeJD/67TZ3oiym83xpqGpJJUMaBrgPaLu9suIMoNyVGxopBdxDP3T/q/W5F7R1MhKMw0+rFETqeLFHM0/t/ckYw/vZkqUQBOlcZ+iNNiC/H8x/+uJ/eLKX4FwgwlZAYPP0Vv/X8B1nyV9rzdtUnat7fcP5ifnSO37N5zqMTVa+lNRyGjhDq1iVLqxj0y4smOypgklaDqlYqnLVso8+oos0rx3xdpfk0RyNBU2Q2grFTvPLcodteDGot0+dvm9GyqirnkUDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xJUBiUzKs7zAWOjam3R4XSFPVjo9HcyNsv+jFWvsus=;
 b=r+B3uXPE5vokkebrzXFX7G923yv7eYyR2pGq2xMdDgsakNEAMgh4EKyovephcxWPdtkP0j8hmGf6aHnsnvFtQRmns1WhJdwVzcAzqZn5JCG48/TiITfPl2pRqg28AzuHcNMZUitBwpCnZl8ZLGVOc1Uz/bmuY0U3L9Y3fxZkLL1A6QrVVv2EJrMCu1MI2frEMmv6/R1Z9za2sbjAwi9eW5KClepSyXg2AQ0e2RWaot8v+XbHnLxvQlZE3etp/DzEKY7XQwVv5Bz9UA91gEqTvJPTW8b08R9OgES6E6Es803ncZabOzth0WtUW9MYiUBT5l++bp0RGGJ54MBNEHvF1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xJUBiUzKs7zAWOjam3R4XSFPVjo9HcyNsv+jFWvsus=;
 b=tnglTaq3l6uf2VBPXrgvsPNtQfMe6FUKOxol89SrHsqlh4ucqlpFn6rmCdS7rBe0vrBF/fo7NlteafAO1BYX+oFCZ7bUVPb1joNjG/xPcYy3psSucKj6tqz2HmOXHBDKjI0XylkUaaNrA6irbtGABMujtclXXFNXnoZRukFLrF4=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by MN2PR10MB4192.namprd10.prod.outlook.com (2603:10b6:208:1d9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Thu, 18 Dec
 2025 19:40:55 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 19:40:55 +0000
Message-ID: <347f48c0-d6ac-4e38-b852-5bba071ee688@oracle.com>
Date: Thu, 18 Dec 2025 11:40:53 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] NFSD: Add infrastructure for tracking persistent SCSI
 registration keys
To: Christoph Hellwig <hch@lst.de>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, linux-nfs@vger.kernel.org
References: <20251215181418.2201035-1-dai.ngo@oracle.com>
 <20251215181418.2201035-3-dai.ngo@oracle.com> <20251218093434.GB9235@lst.de>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <20251218093434.GB9235@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0005.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::18) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|MN2PR10MB4192:EE_
X-MS-Office365-Filtering-Correlation-Id: 4df1e509-9e62-4180-5b61-08de3e6d5c2d
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?eFVpZ3hQMk80MTExakIzSURiQU10ZU5tZXUybDEzalN4eDcwb3dwYXdadUpv?=
 =?utf-8?B?RkpkV0NmaUNrdXZBNW5vaE9qMU9sb0Qwc01aWGhYemVmeTJ1a082QzZFWHVk?=
 =?utf-8?B?ZXJpRkhRYXozZXdMK01MTy9MMjFKQ2dTcDFyd1MyMUZkOU4zZlUya0l3S1Bz?=
 =?utf-8?B?OVh0QUtKcXNlRVVuSnpuRFBOakxRaW9NQy8vMVEyaFdOT0NHMzFuQ2hUczFW?=
 =?utf-8?B?cThUMjR2a2VDNmVFNWRLSGxPanBBR2d2RnUxTmcxS2FCZFJBS1J5M0hWSjVr?=
 =?utf-8?B?L3BnS21Zc2RQQUdpajVhSDVveTVwUDZqQ2JsdjEweUdyR0hqalZNRVhpNWdi?=
 =?utf-8?B?bG1RdG51dWhPcUpJMkFDZ2h2U0NoSVpBaWRiQmxVb21GejY1aCt0TVluTHhy?=
 =?utf-8?B?YUIrUk93LzVlTGRrKzBURFl1VU14Q3FVRzRRS1kxejZ0WXk2WWQyaWdoTHFV?=
 =?utf-8?B?R2p6OVBXUm44NStMNkpONFlyTittQUpFa1h1K08vR2FMdEl6aDNLOHR1Sjd2?=
 =?utf-8?B?M0kveldJdzhkNnB5YVRsTnhjUTBaemJVdXhCTmg1bXZDT3pGV05KR1RYcjlj?=
 =?utf-8?B?L0JiWUFKeFJzSVhTQWFycm1pTWVPelM1THNpSFNmMFlUMVNTMExLYkt6ZDFD?=
 =?utf-8?B?Y2NnTGU4OWVMRE40aEpKUEh6RmFmaVhTQm9VZGMrY2Y0aGVTQmFOSGV5ejZS?=
 =?utf-8?B?L25KY3hVdDdBbGU0L1l1cmU4RGk4Mkx4VUNldS9lTzRPY3Era2ZnUDQ4L1Ev?=
 =?utf-8?B?YngxWmozTUMxS08wUmhjeHBrcUczMTVDcjc4c3RKdXV1ekhPN2JjZzlqaTFu?=
 =?utf-8?B?bVlTTVhQMk1kaW42L3RyRzhIZERJdFROVXBRR2J5NXkxT2hpb0EyZXFTVUts?=
 =?utf-8?B?ZTdEZUVBTWp4Uzhnc01pUkgxMXFDRnJYVWNnRDdBbnkxYzkrdVNYalJSZ3FE?=
 =?utf-8?B?WUNiSlRQbUdmcUVHbVlFRXhuR0sxTktqMjJDdzJDWjg1RWhpQ3lUSW9xRGhs?=
 =?utf-8?B?azJqMXh6UmF5WFRWWEtFeHlPSVJ5YmU1WVl2QldxNzBPdkFGTm41NVhheXVH?=
 =?utf-8?B?emJhektGRkFLemxZSlM0eHhMQzYzOWF0RXg4ZnhCSjdIYkpZMzZLSGdORmox?=
 =?utf-8?B?bzgzQ0svNEE0aEhmMlRZTm84RGd6VTJROWg4S0EydHhidVFIUlN3MEtwMnZi?=
 =?utf-8?B?MS9ITGFGVzNwVnN4OXlCVjNFQzRUSEM2cUI5MVVxUVBQRk5BZzVTTHd0WlFj?=
 =?utf-8?B?dXZPVFM4dHlXMFpvbEFkeXNlc0ZYSm5oSUM0WjFYSHNjV1JCSTFSYnNrZjg0?=
 =?utf-8?B?MjhWZ3FkSEg1ak9kT0UzSUs2TXQxcGxlSW4ybllKeHpLSWJYaHVUeDNEWTlO?=
 =?utf-8?B?azVXSkpjK3FudWxrell2NXl2UkFrTHJCb05kWUtNMkViQ29KUUwrZFhMNUt1?=
 =?utf-8?B?V0lKcGRyT2d4OFZMMzhQb1d3bkxOUjFrSElaWWd6OTZKcFBja1NnbVVlS09y?=
 =?utf-8?B?bjc4cVdzTGRJdDVnNy8wTHB4Q2FtbnhmblZpNm5kV3FSTDU4azhoTnA5YXpL?=
 =?utf-8?B?d3NmRHgrWVpLUGMwNVE3T3NDK3dJVGVNZXZxV2ZXUEtqK1Q1Q2JHU3VVRmVV?=
 =?utf-8?B?R0pzRm9jWmdJRjEzMkJTQXhpN2h6SDRXTkhaM0c5ZGg2TlRyVGhIMS9ITkFs?=
 =?utf-8?B?dzNmRnF6QUI4ZFQybzd3K2Nodk9iNmFCeHY3bytoZDhhR0gza0x1Y2RkOTdF?=
 =?utf-8?B?aUpZWFQ2eEE0blJaZEJpODdEUjliRFIwa09SMC83MnM0Ky9HNXRJcFQ4Nzho?=
 =?utf-8?B?Vk9yY2gzSVFocVRHMlppYy8rTW1PaVROTWhjbU95T2xqTEdqY21BMloxTXJE?=
 =?utf-8?B?dnF0YmFZWWRCL3p0a25IMHIwa3phVmluay9idHp0TWN2ZGQvcGtHbVNFTFE5?=
 =?utf-8?Q?aqPqa/Z/RJCy9V8oDBFiekDB75Avp4vO?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?YUpwVHFUaW5ERkcrZWIxV21XOUx2eGsrbTNVbnJSRGJyL3lxYmZ4cEZSM1NJ?=
 =?utf-8?B?dHBDOFl3WDVZWFNtWXZRanUva0phbUMxcFFqeGk4SlFLc1dQdDZmeDVjZmk1?=
 =?utf-8?B?c2xZb25pczlQM21iaVhGRThlZ3VtS1F2UlJqVTVJM1N1ZUtxWkNLRWsxeFg5?=
 =?utf-8?B?Qm9MU3BJS2t6Znk4a3Iyd1hCZEkvVXNmSFBRMmo5SENIU1hJZWt4dG9uV0ho?=
 =?utf-8?B?ZFhCbUQzdXNWY0VWeE1pRDI2R0lNdG1PLysxQng4bFFybkRXelZDWHplQ29J?=
 =?utf-8?B?UXpRQ3psUjFjQXRTanZYTkR4Q1VzWGk0MWl4SGNkRGx5T3ZLOEUyT0RWcHNL?=
 =?utf-8?B?dUJWaEZFMjZWeEN1SkhXeGRkcmw5dlRRZEVHT0Q2dXFwZFhiOWx4ZHJQNEVU?=
 =?utf-8?B?Tnk0VFhBM21mako5K2E4QSsrYVE3ODkveWdKdm1tZ3A5UGlJQzdnZ1hoY091?=
 =?utf-8?B?TmdueW5BOHBWMmZYSDVJdFZCL0ZUa2NnVkthMGJnNEZnSGNXWDhPU3g4dVJn?=
 =?utf-8?B?RWFlTDdQQWY4MU9sTGJlMDZDWi80eVN0ZTlGemk2cEora09JZXJZN2NWYStS?=
 =?utf-8?B?NExYcFFHZzhVVk5NWWozU3B3d2N1MzQ0UHJ2Y0hhZGZjRlJySkVPNTBlZHZy?=
 =?utf-8?B?ODdTbzlPQ3h3S3BCVjFLNmhVeFk3QllMOWEvZnVDaUh0d1BBY3FoMjFnSjJi?=
 =?utf-8?B?Nk15dXFqZVB4WDdhMkd2Y2RaTytsUm43cUdvdGJ2NGlwWDk1QllHbHBxZGx6?=
 =?utf-8?B?SmdOWnlCdFY2Q1FxbTB0SmZvM05jSnZkaTdkRDBNWm5EaUhCT1FwajRUamgr?=
 =?utf-8?B?dXJYSVU4TlBYYnc3djNEcVd0dklwbWNHTmZCSmg2OGk5OXpOelBINDd0anh4?=
 =?utf-8?B?VFZrTjNEZ2w5QmxJM3VYYnBWRTI3TlBJWHU5dmUrb3l1WldQbzUzTVhKVmZJ?=
 =?utf-8?B?eVNWcE53S1FPeGt6cHNPcitxcFZGbkZYQUdFTlBIUWk1ZFN2NnprTk9rQmxB?=
 =?utf-8?B?ZU5qS0RtN1FVV3lwK0VlbUdjMXFmNlJEZmNWbkt5WDFWbTRUMi9QODNEY1Y0?=
 =?utf-8?B?dVRlU2NEYXlpbWdPbUZ3NzYyWjY5ZUJ3VHFtVXRnRzVvNnFpMG84cHJpK0tl?=
 =?utf-8?B?Y1ZiRWwvTENyVVJFSmJ0QnJKWVY4Ri82ck5MLzV3Ri9TT0E0dldsM2tTZnky?=
 =?utf-8?B?SVRhM1B3ZnJZa0wrdkY2LzRIWW5GSTQvN0ZZbEdTazdVS3RKSDYxcXprYjV4?=
 =?utf-8?B?bysvellteDF0UW05VEU4SFE1YVdkUEtDN1NzMmFDTTd1UThEZHFWTU9RRjIy?=
 =?utf-8?B?TmN4ei96dTRIdFllNkdVWWcxN1M2NHRlOE1zeldQNmUxRFc3eHd0a1VBOTNv?=
 =?utf-8?B?cmtISE83ZVNrRU0zTXdwS0JPMFM3NFJOZzhqQnhydzd3TGtsaHhwcnBCd2pY?=
 =?utf-8?B?YWlQdlVKR0RFb3o2b3BaL2dBSVlNUVpFZ3VrNzVLZVdrRFNkTDRUcFRMVm1t?=
 =?utf-8?B?WlhYcVpjZWxYazRaY2s5Y3l1RlYrM0hFMFM4WHdPeU5aTW4xdkY5N3lMb1hJ?=
 =?utf-8?B?eTRJTXNhS0FLZDNCWlhsVXZYeTBmTk4yWW94MHhVc0ZqZ1BQY1RmNG9sT0dt?=
 =?utf-8?B?emRJNUxCTzhKdmh0L1VrRkhjSUhnL0xoWnQrQkNZQ3J2a2dLUW1VMjVTQWVp?=
 =?utf-8?B?cG90R3J6aWZqd25VbXJHeG1ORXBtTGh2QnVFbWwwcnpKYkg3NVpLT0xYOEpG?=
 =?utf-8?B?aXA4Z2I0K05pYzJqOVkyTzNaOHNOWE9vbWR4NDBLN2lTdXQxcW8xM1A4SC9H?=
 =?utf-8?B?SzBhSysrMUlWYVhhalUzeDMyS0FMSDVrNW5RdmxOOE8wcCtGNCtncjNyT25r?=
 =?utf-8?B?RE5POVFBNUJUUmRyWm9tdWYvbEJuc3dLMW8yWCtZNktVd0JVZVI3NEJYdlFn?=
 =?utf-8?B?NWlFNVJ6azE5akNSQnBQWHVhdURYNzdxdjJ2RmNsYWQxekFrbFV0ZG1kb21V?=
 =?utf-8?B?Snl0WU94NTk0OC8rKzB2aHBoQ1N6bDlTbFIzYzlQTXYvOW9PT0lvRUdhVjlO?=
 =?utf-8?B?REk4dEVaYVZpN2JRdXFVYTl1bVB6U3NCK2lXNVFEdEVkbzRBcHlaamNKbEl4?=
 =?utf-8?Q?kL/YOUcF8v+d5rntLOrTovSNb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Hzh6U9kmL52c6M9vliATNmMiuGlP3UW/bTy0o4EKEXEO6nWkJ5sWz/H/BHrmcO54T4W5BvcsRbSA85YTGOWBoVUs7NHqygsWAGA2xc2ig1c0UizYdkI6fe2qk6u11LHuXLiAZc1UqLjXp1NxeB5Vd29pclBgEzm8gbVdzSEsNyLSKE/dWAh0Q0fC/X+2ZIcieg6fJLHAG0WxW1dDdiwX2oA/0d3vH8c0juCU1vh6HC/QRKpf/It5NU+r5lAJkmE7FM+5XNLEj3sVsIt0nTvrcUEIQcFW56PFqO0uVxf4QpozAxeWwftAq34AtqMrf50pD0lzEIU2pzJpXGLh7O5BCEdV4MZdSLjTqm3FQevwGWTSv3mQMN/oBBRnzX/X5lQF0zzAUPBJLKc0O/rp05TwszKL11cyTyZmjiPisNb/jrEvsbyElxdOKSEriT2fzccnIfT2rRwgjiMH9KsOHatX1E7V2/fz5taSmE8Te1x8+nLTz6ftDBQDSlmgo1saWdm+bV/YCaL7C9BD8LL5LPsMLyvL5BnevyaTlsUY7dUWtmoj+YBq6tlM3DVFk4omzVXuZg87Y0So+hxhGq17IrikRXMLa/Ppdok30iC9f2Q7eAg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df1e509-9e62-4180-5b61-08de3e6d5c2d
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 19:40:55.3589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KLYFOMsirk6rxd5uNUzHQQVAWS2RbWkeX9zLHWc1n7drmHUpTN3X+icoFoH8DP0K+G+uwrA4m0hAgwemP6Zndg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4192
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_03,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2512180163
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDE2MyBTYWx0ZWRfX4zxgpqN58HqT
 y/ZgDtAAZRLEEiUaseO5zyUKo3nCYv1+mJtK6QSJEon1GrXlJAVt7hDiUoAUtJll6WXzm9uTyov
 OBaeOvHtcRMszS7sp3zFM6zxx1ZIkZTx1ht3NkZws+ovTQZnAPYrDjA3hIim3THFfzEN5IaK25Y
 QhErqG5A94xAsj6lpGi5+8jCcAT2c637h71jhmxsN5Ipkm03X+8yqlzQDUFFQGlwuAM23htpZLD
 NCOFkcET1+VBC/UpreL8R8om0aR11blQLaiUWHt7K19EKPr/81R2C3cqc4SHFlpLYCu+b0xomUV
 +2UrmMSUkhk2gmVFVec1BL4ukCX6QE4A619LxQkpOvFTtaA5vLD7M4Pa9RD2BOF/ZkVOfJkfMWI
 +szXZxDZnxJdoUr+XOhZPGGKvW/cR7lMv/066avfKLhILPT/3M0=
X-Proofpoint-GUID: 9SyemETeqUvM1Bscvliq8kZFvg8bki_w
X-Authority-Analysis: v=2.4 cv=ePkeTXp1 c=1 sm=1 tr=0 ts=694458cc b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=uN2Z7eA6v5eqscL_QBYA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13654
X-Proofpoint-ORIG-GUID: 9SyemETeqUvM1Bscvliq8kZFvg8bki_w


On 12/18/25 1:34 AM, Christoph Hellwig wrote:
> On Mon, Dec 15, 2025 at 10:13:34AM -0800, Dai Ngo wrote:
>> +
>> +int
>> +nfsd4_scsi_pr_init_hashtbl(struct nfsd_net *nn)
>> +{
>> +	int ix;
>> +
>> +	nn->client_pr_record_hashtbl = kmalloc_array(CLIENT_HASH_SIZE,
>> +					sizeof(struct list_head),
>> +					GFP_KERNEL);
>> +	if (!nn->client_pr_record_hashtbl)
>> +		return -ENOMEM;
>> +	spin_lock_init(&nn->client_pr_record_hashtbl_lock);
>> +	for (ix = 0; ix < CLIENT_HASH_SIZE; ix++)
>> +		INIT_LIST_HEAD(&nn->client_pr_record_hashtbl[ix]);
>> +	return 0;
> I guess there is precendent in the nfsd code in using this fixed size
> hash table, but they are not very scalable.  And using the rhastable
> API is actually relatively simple, so it might be easier to use that
> than rolling your own hash.
>
> If you stick to the fixes size open code hash, you should use a
> hlist_head here.  There is no advantage in having a pointer to the tail
> entry for hashes, and the hlist saves half of the memory usage and
> improves cache efficiency.
>
> But taking a step back:  why do we even need a new hash table here?
> Can't we jut hang off a list of block device for which a layout
> was granted off the nfs4_client structure given that we already
> have it available?

Yes, a simple list hang of the nfs4_client structure makes sense.

I don't think a NFS client would be configured to access too many
pNFS shares with SCSI layout type. Also, fencing is not expected
to be a frequent operation so traversing the list should not effect
the overall performance of the NFS server.

>
>> +static struct scsi_pr_record *
>> +nfsd4_pr_find_client(struct nfs4_client *clp, struct block_device *blkdev)
>> +{
>> +	struct scsi_pr_record *pr_rec = NULL;
>> +	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
>> +	unsigned int idhashval;
>> +	dev_t bdev = blkdev->bd_dev;
>> +
>> +	assert_spin_locked(&nn->client_pr_record_hashtbl_lock);
>> +	idhashval = clientid_hashval(clp->cl_clientid.cl_id);
>> +	list_for_each_entry(pr_rec, &nn->client_pr_record_hashtbl[idhashval],
>> +					spr_hash) {
>> +		if (same_clid(&pr_rec->spr_clid, &clp->cl_clientid) &&
>> +				pr_rec->spr_bdev == bdev) {
>> +			return pr_rec;
>> +		}
> This ensures that you always have collisions for multiple bdevs of the
> same client.  Why not use a hash the mixes entropy from the client id
> and the bdev?

This is no longer needed when switching to use a simple list.

>
>> +bool
>> +nfsd4_scsi_pr_fence(struct nfs4_client *clp, struct block_device *blkdev)
>> +{
>> +	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
>> +	struct scsi_pr_record *rec;
>> +
>> +	assert_spin_locked(&nn->client_pr_record_hashtbl_lock);
>> +	rec = nfsd4_pr_find_client(clp, blkdev);
>> +	if (rec && !rec->spr_fenced) {
>> +		rec->spr_fenced = true;
>> +		return true;
>> +	}
>> +	return false;
>> +}
> This function seems misnamed.  It doesn't do any actualy fencing.

will fix in v2.

>
>> +extern int nfsd4_scsi_pr_init_hashtbl(struct nfsd_net *net);
>> +extern void nfsd4_scsi_pr_shutdown(struct nfsd_net *net);
>> +struct nfs4_client;
>> +extern void nfsd4_scsi_pr_del_client(struct nfs4_client *clp);
>> +extern int nfsd4_scsi_pr_add_client(struct nfs4_client *clp,
>> +		struct block_device *blkdev);
>> +extern bool nfsd4_scsi_pr_fence(struct nfs4_client *clp,
>> +		struct block_device *blkdev);
> Some of these are only used inside of blocklayout, so mark them
> static.  For the others drop the extern.  Also please keep
> struct forward declarations at the top of the file.

will fix in v2.

>
>> +
>>   #else /* CONFIG_NFSD_V4 */
>>   static inline int nfsd4_is_junction(struct dentry *dentry)
>>   {
>> @@ -578,6 +587,13 @@ static inline int nfsd4_is_junction(struct dentry *dentry)
>>   
>>   static inline void nfsd4_init_leases_net(struct nfsd_net *nn) { };
>>   
>> +extern inline int nfsd4_scsi_pr_init_hashtbl(struct nfsd_net *nn)
> This should be static inline.

no longer need this with a simple list.

>
>> index db9af780438b..9ae02b6d922d 100644
>> --- a/fs/nfsd/pnfs.h
>> +++ b/fs/nfsd/pnfs.h
>> @@ -67,6 +67,17 @@ __be32 nfsd4_return_client_layouts(struct svc_rqst *rqstp,
>>   int nfsd4_set_deviceid(struct nfsd4_deviceid *id, const struct svc_fh *fhp,
>>   		u32 device_generation);
>>   struct nfsd4_deviceid_map *nfsd4_find_devid_map(int idx);
>> +
>> +int nfsd4_scsi_pr_init_hashtbl(struct nfsd_net *nn);
>> +void nfsd4_scsi_pr_shutdown(struct nfsd_net *nn);
>> +void nfsd4_scsi_pr_del_client(struct nfs4_client *clp);
> These duplicate the prototypes in nfsd.h.

will fix in v2.

>
>> +struct scsi_pr_record {
>> +	struct list_head spr_hash;
>> +	clientid_t spr_clid;
>> +	dev_t spr_bdev;
>> +	bool spr_fenced;
>> +};
> This can be kept static in blocklayout.c

will fix in v2.

Thanks,
-Dai


