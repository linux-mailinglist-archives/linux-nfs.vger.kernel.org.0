Return-Path: <linux-nfs+bounces-13435-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57ED6B1B8FA
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 19:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0587218A7057
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 17:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A3A259CB1;
	Tue,  5 Aug 2025 17:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oG64r9Sp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PsExh5Vg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591371DF258
	for <linux-nfs@vger.kernel.org>; Tue,  5 Aug 2025 17:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754413686; cv=fail; b=mEsBzhtjnX5iF0dBBA2FsVOep6s6UEIT+0pd4l6WupMx4krma4wHwSG7QJ/Yqa3NKwQal10WVynoJItyywiT4UBDpqMUSLWUHjxweq2jqTrMGpFxhYLgvvS+1SdeUpo8X/9oUmgYrzsHDBlbEm4uv4xbQkP/RHAXYliI2ia067Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754413686; c=relaxed/simple;
	bh=Rpibzi1vrwPzRM6HWX2XAlTt213ayYfIi6JaDKRmVPM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aUq1jmZVOqkgEl1mkN66ij5leYKQGcQfwqOT0+lXGz38PM0gbM5rMaz2HYGMyaMTiAEJGzhs70QVpIRzhKkduOsoWFyCOnkhh2+8L6+MKfaLJlwmSi4KErWTPy8Lg8lde51+Qku9BYaOv3YClSj4Li9/WEwW+7F3sVM1TClGDHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oG64r9Sp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PsExh5Vg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575G18RU004020;
	Tue, 5 Aug 2025 17:07:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=M6I9d2GeYSPbpu87qsX3JUh7NldUCi+maxhy1Lym/mc=; b=
	oG64r9Spr3lxShBAgKpLxkkxKhsKkS6kCAsyhFR44gxzf82rN/YL1KFKHdfUxDy2
	1SL4iKSSe9NlXT0/5Dld3+8Lf0iP0FSv2CAV5wjpkDV6oxdIRTXGdfQRLkmsneqL
	JwGedWshDo1bNqtuu/viXTL9eJXtVToUvYJicB4WKkIXyULdTLZMxZM8kATTq/Eg
	aHxof4nE4NwKXXmlqQJKa0OxDCPwVhISZ19BgNEX0x9YuX/X9jbIoYJl1v1IAu/n
	H+Fwopu9N0a6466EWLHCQNfBhXJ7slN7V5+oPDGwrl3OtgMnqKIKczTyoPXhZ8r1
	pHGTawfVZy+XWCMPdp7LSQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 489a9vw7ak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Aug 2025 17:07:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 575GOWJO011637;
	Tue, 5 Aug 2025 17:07:58 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48a7q280rj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Aug 2025 17:07:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r96YfOpNM9MLBSryDLH+yYF2UNFEEDqghCeTfBDw/uPxeZVPXXkSEjPVkeMx5JUBIH5Xp4VmXkkx9a00DrlvhLhnBZvfDSVysHt2lv/PnVMRB71Ull/KpkkLT8fqMiDndtG3ZiyAdpJrELXijF40IkMy8HjLPyPRaFnPlPXvat1nd9yQBUzQvtukmgJpnZZh4mkLzV/3otvDTCjzHAYnNmIgqvd6ZSCtx8CHTwQ3vE6WQ25KY1par76aqG3E4s1FSzopF4iU4W55Qdcnq9OEhbmNepw/WUMl4CO3OkVnlHYEPjhjS5uAcqJTBjxoxaptGP6hXzMmOu29Kyz34fQa7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M6I9d2GeYSPbpu87qsX3JUh7NldUCi+maxhy1Lym/mc=;
 b=EsrQebaWAWma6rd4CYGNu/Rpd8Nw62fK1A76tDMwojim+qjPhOx2jIWGUZ2TgZ/aQ2Mx13qwqGfjSD6Arz7GjdElzsJRRLnUyPItRVdPUKYbuRAMRZZYOLruksabKXDlaBt5cMeHjsoFEarPloBkil9qoRP1qb7Ln+qMNyyz4iJB4yNodm/VFdsCDdMk9jv2iAAd7kxGUhgoQbIIc6g6WNKTxhlKCM6KnmjQDjragSl7Snvg5z6UW5ERjZrZo5bwzlLL5fRIOsTkJFjTEXsfPdQ5IV2EyFxHiIZe+cWSiZD7JL+6r2kQMwrbWhV/IpJK68DG844kuWadZrTyJ8kL3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6I9d2GeYSPbpu87qsX3JUh7NldUCi+maxhy1Lym/mc=;
 b=PsExh5VgzKINpSQ7dk0L9z1RftoU24Ak/WcfzfFSgDNhnDLzT5jUplO4AN8SWyVRZ/hIYSnphwocHtJJqmwpyouzFTyEZvxdUSG6R1g2MDUlCK/pmcD5PQMwtLOSzVU5rLq/yRzlqbPsWx5f1SeNyItAZhH1O0/sMbAETtef3uo=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by SA2PR10MB4412.namprd10.prod.outlook.com (2603:10b6:806:117::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 5 Aug
 2025 17:07:55 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%4]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 17:07:55 +0000
Message-ID: <14935b2e-8124-4f46-a63e-331328d49d12@oracle.com>
Date: Tue, 5 Aug 2025 10:07:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] SUNRPC: call_connect_status needs to destroy
 transport on ETIMEDOUT before retry
To: Trond Myklebust <trondmy@kernel.org>, anna@kernel.org
Cc: linux-nfs@vger.kernel.org
References: <1754334505-65027-1-git-send-email-dai.ngo@oracle.com>
 <48287a80e639d61eb507175ceb44d216e8032510.camel@kernel.org>
 <72e387a8-b800-431b-89c3-0104fbfe6273@oracle.com>
 <23fbff6b80f0c7c4b963f214c4c1e5d7b31c1d23.camel@kernel.org>
 <de62d42e-5e85-45d5-825b-369938a4a24c@oracle.com>
 <3978e03aa1638621bced96738ef210ed389e2afb.camel@kernel.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <3978e03aa1638621bced96738ef210ed389e2afb.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH5P222CA0001.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::12) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|SA2PR10MB4412:EE_
X-MS-Office365-Filtering-Correlation-Id: dd0713db-4043-4759-ce9f-08ddd4429eef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djgxTW9XcUNydDJ0RVFMbnRteXJSOTV2MUtINzBOajdCS0hQdllZejZMajM2?=
 =?utf-8?B?OFd4MjdOWmxZajdLN2x5S2RJZzcwSEtIUDRTNytRQnk3VFd5Szh0SzJYdzF2?=
 =?utf-8?B?Z1Q0V2tNLzJURjJvUGdudnBCbzF3NmZ0VzB2eWxqWjJnMTFYQlRWQmlvcUJq?=
 =?utf-8?B?OW1HUTRXQ0lJYVQ0TlJLWTNpUlJXYzlLZVI5QXdjU0dVRityaWtPV1ZNaEp3?=
 =?utf-8?B?RzBFOUVqbFdHaWtENGZzdS9WakRZeUVQbjE1cTAyNFhQSmdCbm1WdUV3MWtJ?=
 =?utf-8?B?K1ZxVEdaM2gweEd0NExvQzk1dFZrM3lEMXRJQzE0Zm1BVG9haG05dnVPaHVw?=
 =?utf-8?B?d3ptZitvUlBZMjJzWjdYL2xURjR6ZllMU0lVS1NxWDBSOXRxN3ZEcmhaRjNP?=
 =?utf-8?B?dUEyZTRVY1hRZWRSQ3RsN1BPOFZtbkM2V2xIbklCamZkUlN4citFWlZTMnZs?=
 =?utf-8?B?ZUNxTUhEWlgxcWViQ0doQkxzcVhrRWdWYkNCM2x1cVhRbmdVeUUyWStkRFBp?=
 =?utf-8?B?WmI0enlUVGhMeGIwT0xyc1NVMnYvK0h1WFhqa3UydURlVXFBZ0xieHlxZzhv?=
 =?utf-8?B?Ni9hVmxXMkxrbmtzRU5zcUtMUWFEaFA3OGRabCtOR1czK0lBZU5iempSV082?=
 =?utf-8?B?QjVVR0JwbkNGbktYWnRuc0tOUVVIZ2ovU0hpcCs4Zk1KcmNVeWhKbWNlSVQx?=
 =?utf-8?B?VHpyL1kwUzQ0UUhZcmVaOXplY2V5QVFycEg3bFh5T29xcldqVXRBMVF1K1kw?=
 =?utf-8?B?cEFFV2hsSDFzM0hFWkZNT3pRclorUHUwdC9ITi9rS0kxdnZnYzk4eElTeVNB?=
 =?utf-8?B?ajgvaGZuRHVPQmhvQzBsTkhBWG5NZThVblY4cjB5Y0xrK3ZLQnVaandCb3Za?=
 =?utf-8?B?OUlmWWQvNXN1NjFHSVV2OTlvSEtWS0E1NzhMQTJFdUxzN1hicmpkUnlRM253?=
 =?utf-8?B?WGR6NzkyUHFudVZBMjlRVGpSSXA5aHlkRDBVZDdDVFJyYW81ZDRueld3eFhk?=
 =?utf-8?B?aGNodFA3bHJ5U1VPQTRpdkZ5QmlGMTdSZlQxOVo5QVpHZFZ4WnZDSVdNYjVW?=
 =?utf-8?B?SmxUeEt1TzdiQ0hLdjFDbDJremZZTnpvQnNYSk96WHA0WmgwYzFhbnZZa01a?=
 =?utf-8?B?ZGtuTUlvdTd4RTU3M0srZUt2QUY2ak0vNTd0bUl0MWZFUkZURlpsNFM2OFZs?=
 =?utf-8?B?bGY1OG5nRGxSQzRBTVVpNm5zdUd3K2J4RHloMTNFTjhhdjN1RzgwVmY5MXF0?=
 =?utf-8?B?QUI5cUNMVW1NYUl0bUdJb0xQeEc1QXBpMEV2TkwrcjVtbE04Q0lBaDNEc3Qy?=
 =?utf-8?B?dGlXYVBLR1ZuYmJoMmhLenFTNUZrUVAwK2JqODQwNFE5Z2t1RmpSWnpwT0pH?=
 =?utf-8?B?N0NJU1dxM3oyTUd4TWFBbGloR2NKaUFCbGRnSW5wckwzaWNMRFE5UFppR3lN?=
 =?utf-8?B?cTk4alFPdnBtdkVNcWlDN1RUYjlsS1Q2UjF1M1dSQXFzQkJmMEJxQTVkVGty?=
 =?utf-8?B?TW91Rk82UisvVEJUSFFJT1lXdDIyZDFlUzZWeDlueWFlY00wTU54VERjdEkr?=
 =?utf-8?B?dzZLWVYwTWdIbndXckVWU1B4Z1M4S2RGMTFtMmE5V1hUMUpHVHBZczVLNWha?=
 =?utf-8?B?N1VZYTVtS0JKbkJnMlpXRVppS0VmQVJwSjNZZG1KMlpiRFdQdFh5VUFKdlhL?=
 =?utf-8?B?WmR2bi9ZTWZZSFdRRGJUWE1xMWJqWkxnWjhMM3dENFhkRGxBbVA2Wm5OMy9C?=
 =?utf-8?B?ZElHOFZ1UHN6MncybzNFOVp0eXJ1anF1VlJ1MVBodEFhdEljUE5DbWZXam9T?=
 =?utf-8?B?b1dLb2Q2R25lYVlRelVoTHlKMjdpTDJQNUhydjZicGlaUVBhbFZTMXJQTVQx?=
 =?utf-8?B?MDhIWUdjZEw2VG9lbzdsMEdSU1VTMmtLajZGVnFuNUltbHczbG80cTBGV0RW?=
 =?utf-8?Q?mBoo8uTbAMU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzNOYTZtZU5sL215TXAxZkpGVllmUjZRTnM5N2U1bVVrWnBFMHR3ZTIyR2Zp?=
 =?utf-8?B?VDh5dmhlUUZwbkNYbkNaSzA5Zklja085ZUVoaWd2MFVxek5FK28weXY0SDZ5?=
 =?utf-8?B?bVRhVk01aHBtcXdJeWdVNGhpNUNtQXo3R0NYcGliYVBHMkVoZDJDK1MvTjZB?=
 =?utf-8?B?SW1TcTd5L1BEQ0k0ZGNnSDh3WXU4aWlXZE5IWFFIZUpoUG96MFhvZzRkbUxi?=
 =?utf-8?B?WG1YYUhBdzk2c0lIMEN6UTVhRUxsZzJ6TEZqdXdROWF0U01uaDh5NGg0Vkdt?=
 =?utf-8?B?cGpHcm9BcEdqbmxTTGl0dnl4M2xoNWI5N2V2TURrWWpoUGIxckZuTzVrb21i?=
 =?utf-8?B?MW5aR3NtSGlhK3hKdG9zMDFhREhqRkc2NUdSNys5a1NNU0oyVXdMbmR0QkE1?=
 =?utf-8?B?VG82bjlWZWM0VExiNVBrQmtjNVBPN3hyL0NFK05jTEFHM3IzWENHZUt0NS9a?=
 =?utf-8?B?M3hROFNkUjVzY2trQUhFN0tzbzVadktVSkpiY2N1ZFYyMVY5dDRDUThkb3cv?=
 =?utf-8?B?ODRrZzlVNmZLb2xXbkxhTjZpVjgyVjVxdHJyM0pybnQ3MXZRNzJvNXI3a29T?=
 =?utf-8?B?QVdtRzYvQ1NCdHdlSmhDcEppcFpxRGsxdmZIczNCZk1Xc0Uzazg3QjU3YWsx?=
 =?utf-8?B?b0VOc3pmd25uV0RhaWppYksybnVVaVQ0YUo3cVlidnNqZmVaalMveUk4dTQx?=
 =?utf-8?B?QzlSUEUxbndXSmszd2hmQ3p4KzNzc3dBVnlCYzEyc0hZVjJTdUd6dFZRNjQw?=
 =?utf-8?B?SHlEaXFQSDVQTzcyNGxGNTZCVjNTZ2U4ekd2NDV1azh5RjBPT1RzODdHVHpV?=
 =?utf-8?B?aHZlR05xRWhBWk5vemJLdWpjSjlaN2FQTTlGSWVOVDFyZVpodkhNMVZaeFZ6?=
 =?utf-8?B?OWRmelAxRVNmeHdOZnJQaGJtbklkemQ2UFRCZWo2UFp5eTNYcHlWY2wxdW1l?=
 =?utf-8?B?N3orMHZ4d0tVUDU3RzJCNm1pdVo2TUVyRWd6Tnp5SWhoSFdrVTU1d1IzTHJ6?=
 =?utf-8?B?V05DdmJKZFBvU3p3WVZzalpWNG9rMVhLdm5FdGo4VDFnZlpyTWcwQUlyRmNy?=
 =?utf-8?B?TlBmYThFZ2p5bXdRN203cU9NNnlnSlRYNzlOcndOcXZZYVlsRm5IZU9ZQ2cz?=
 =?utf-8?B?cGgvRUpRREk3NjRaT1BMZVQxZXV6Yk55clJFdFg3a1ZaVGwwRTVTS0F3TjU1?=
 =?utf-8?B?QzkxRVRjZ1FFbjFyVStvUHlLWkZ4bjRJSE5HNUJ1NXNaV0JmTjY5Mm5kcTh6?=
 =?utf-8?B?b3NPYlMxRHR2aDlRcE1mR1Z0V1ZxenlNbzhDS0Y4dUNqRmNibndsMkFxNEVz?=
 =?utf-8?B?dnFhV2RYakMyWnZpS3FrZHpzWWVSUSs2SEo5TStjcXZlYVpxTENZczRYa0NQ?=
 =?utf-8?B?QXRjT0xUSmFOMDRTQS9MUnZxT1p2QjBqQk1oRFZiNjBSY1cvZi9pd2F1aWsw?=
 =?utf-8?B?cUM4c0J3K3l0dFEvSUZJc09Wd2xWZUlReFBJM3ZOTmhCMEkzVFpJUVJZckdU?=
 =?utf-8?B?MmRBaS9mcmNNNEVRZTZEYmMzYnk3Mkc3disvbERBV3diaGpJMGJaTkhjd016?=
 =?utf-8?B?Ryt6Z0c0U1VlYmdhTGdqQ1lKa0tTQ01HYTdyN05MTGNlbWVuNXRBbXJJakZh?=
 =?utf-8?B?ZWNkc3c2cDZKdjdPbHpZT25FbHFJT0tjTnlnR2tMMjhiQUtGT2ZoWmEzY1Ja?=
 =?utf-8?B?VU80ZzZrdWhrckVWR0NQb2cyNVJUcHUzTEdsL2V1ai9uOEdzeG5wZDhDcERi?=
 =?utf-8?B?OU9FaFJYZmZUeWJTSGt1ZStSZzRHQzZvMzBHSnp3NnZHbTVrbTZQelM3cjBN?=
 =?utf-8?B?Z2RTOGlIdW5kQU1WSi80T2drZE5GUWh1cm1DTXFMc3dPd3p4cHloRk1Tdkxr?=
 =?utf-8?B?bVJlelRrSlZ4RTBwVVFtazNRM2lkR0ZhN1lSekdKRW1OeUFZWmdpMVlkUUVJ?=
 =?utf-8?B?cks3Zkw3ZFdqcmROam1JY3BzTE5pWTd4YU12VElnOElaYjlTbkJ3RmphRFFu?=
 =?utf-8?B?MlNaVTliczA3SEFvdkdac3RWNi9UMWJwSk9oODJuY1NnSjNCU1AxR2ZTTG1x?=
 =?utf-8?B?SWlRRFFLRGY3N3JYeFQvQTB3ZjQ3ZVVXS1ZEREsrOXdMQnpvSERYeDdmc0th?=
 =?utf-8?Q?qPSp4/UHGscOROK/+Up8b1IXd?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7LBClL7bENgoP/chIQ1UkxVGca/umOArKztLIHkXSntou8QfA21B0lpN9cy/9TE44b5cfRAuCuraSeQ+CS3gHEJWZpMfvOKX1Nq0mPuDm/fX5lbVWSeE50AKqE5bRw0tM7Hgxd6LdO5AOnW0SSnSaxNJ3ub/+jgqa6GNhHrm4NrwJZDYTIuZJiWJhnjZssKcrNQVFde3lvnuJnFGO38oDX/0Lhr5zjw4uNa6iiM+Zj74UizynM0vL4QiXhitOQQQo9ygnEnPlxcEwaoF3kXD4QjptxKTd2oVKt7vD+2JKu8BlDrf+GmZN3lGz5fH731Juw7uW12jwa6UjnzmcVo1mqef3et9leOKub1m0Zd+eKLPtEMTFAeMXQGFUdjE+33kpHv57uixgcaax8JCdBxGp/g8+3pNIoFkgVNIcemtDfl8JrWd/aznNFnkx3wi6iGyvl1HQ3c+A19xE0oi6PP3HLbrKVDKLiPz2NIZynA54OjGzNVWm1ndAo8GVEXN3wvhdXpCOyTOUaYe8D5qitYH1FCa3X2qX6SopF/IWvpT4k5Lu5JOQMxWFxGfMluJ4DmuShI24kY57achu5pyFHCUPxRdhJD7PEBtZDldaGX7r00=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0713db-4043-4759-ce9f-08ddd4429eef
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 17:07:55.7759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: umYfO4YKml9RVhCVjAxVpZia/j9MPNTczcimMdVzWmMQHfwoVr0EbPW+6SoyZz5Oorqy1f4eHhcu/LH6NrKvEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4412
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2508050119
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEyMCBTYWx0ZWRfX4/dsNhkx2U6D
 LakPGYz9B0KHqkOSHTxTjKEewZiZbqV6bSVSsdST7ttjCtOcsTywhmj2H2e2t5JTlxRI6k2lrNd
 diu9RlEOqxD9KGZLxs/0YZGHlVTWnKEXjo1rFQcnNR2yV9ezq1XYaLD/UokGeMkaBQNeLC1vYa1
 Jlnph1nrnZGWy+qgoiJncBjnJOP4/frGZb0YEH7vJhuJ7JXPSpVRbi78aT8bOhGHWEMDQTDul43
 JzksHOoO2cvFeMv13xp8HfgOA1SlBIBuf56xAsfkhUPlqT64ZGsBO4GeehATwOWpAY3Pd0xprpK
 Dt/qbsUCHOMz84xIj3IyyZ0RP+KdQSrDIG4Yc8/S9Ucbzp9GJyIgR/ZQMaoW30mwMcqv5hmywpf
 ANV/DJlQouyJqKlbbWvyeIS2RUC/IpRFHKgIbQMsZlGaH22WUMUgEOOYHEfclWOMM//liiKX
X-Authority-Analysis: v=2.4 cv=SIhCVPvH c=1 sm=1 tr=0 ts=68923a6f b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=kdnzj1o7K0K97s_FtIQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=e10fF4DqEehlLX_lK1wm:22 cc=ntf
 awl=host:12066
X-Proofpoint-GUID: ju7GEjOtzgND2apg0_Hiw9JW5clyAxCL
X-Proofpoint-ORIG-GUID: ju7GEjOtzgND2apg0_Hiw9JW5clyAxCL


On 8/5/25 9:41 AM, Trond Myklebust wrote:
> On Tue, 2025-08-05 at 08:46 -0700, Dai Ngo wrote:
>> On 8/4/25 4:55 PM, Trond Myklebust wrote:
>>> On Mon, 2025-08-04 at 13:13 -0700, Dai Ngo wrote:
>>>> On 8/4/25 12:21 PM, Trond Myklebust wrote:
>>>>> On Mon, 2025-08-04 at 12:08 -0700, Dai Ngo wrote:
>>>>>> Currently, when an RPC connection times out during the
>>>>>> connect
>>>>>> phase,
>>>>>> the task is retried by placing it back on the pending queue
>>>>>> and
>>>>>> waiting
>>>>>> again. In some cases, the timeout occurs because TCP is
>>>>>> unable to
>>>>>> send
>>>>>> the SYN packet. This situation most often arises on bare
>>>>>> metal
>>>>>> systems
>>>>>> at boot time, when the NFS mount is attempted while the
>>>>>> network
>>>>>> link
>>>>>> appears to be up but is not yet stable.
>>>>>>
>>>>>> This patch addresses the issue by updating
>>>>>> call_connect_status to
>>>>>> destroy
>>>>>> the transport on ETIMEDOUT error before retrying the
>>>>>> connection.
>>>>>> This
>>>>>> ensures that subsequent connection attempts use a fresh
>>>>>> transport,
>>>>>> reducing the likelihood of repeated failures due to lingering
>>>>>> network
>>>>>> issues.
>>>>>>
>>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>>> ---
>>>>>>     net/sunrpc/clnt.c | 2 +-
>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
>>>>>> index 21426c3049d3..701b742750c5 100644
>>>>>> --- a/net/sunrpc/clnt.c
>>>>>> +++ b/net/sunrpc/clnt.c
>>>>>> @@ -2215,6 +2215,7 @@ call_connect_status(struct rpc_task
>>>>>> *task)
>>>>>>     	case -EHOSTUNREACH:
>>>>>>     	case -EPIPE:
>>>>>>     	case -EPROTO:
>>>>>> +	case -ETIMEDOUT:
>>>>>>     		xprt_conditional_disconnect(task->tk_rqstp-
>>>>>>> rq_xprt,
>>>>>>     					    task->tk_rqstp-
>>>>>>> rq_connect_cookie);
>>>>>>     		if (RPC_IS_SOFTCONN(task))
>>>>>> @@ -2225,7 +2226,6 @@ call_connect_status(struct rpc_task
>>>>>> *task)
>>>>>>     	case -EADDRINUSE:
>>>>>>     	case -ENOTCONN:
>>>>>>     	case -EAGAIN:
>>>>>> -	case -ETIMEDOUT:
>>>>>>     		if (!(task->tk_flags &
>>>>>> RPC_TASK_NO_ROUND_ROBIN)
>>>>>> &&
>>>>>>     		    (task->tk_flags & RPC_TASK_MOVEABLE) &&
>>>>>>     		    test_bit(XPRT_REMOVE, &xprt->state)) {
>>>>> Why is this needed? The ETIMEDOUT is supposed to be a task
>>>>> level
>>>>> error,
>>>>> not a connection level thing.
>>>> If TCP was not able to sent the SYN out on due to the transient
>>>> error
>>>> with the link status and the task just turns around a wait again,
>>>> since
>>>> TCP does not retry the SYN, eventually systemd times out and
>>>> stops
>>>> the
>>>> mount.
>>>>
>>>>
>>>> Below is the snippet from the system log with rpcdebug enabled:
>>>>
>>>>
>>>> Jun 20 10:23:01 qa-i360-odi03 kernel: i40e 0000:98:00.0 eth1: NIC
>>>> Link is Up, 10 Gbps Full Duplex, Flow Control: None
>>>> Jun 20 10:23:09 qa-i360-odi03 NetworkManager[1511]: <info>
>>>> [1750414989.6033] manager: startup complete
>>>>
>>>> ... <NFS mount starts>
>>>> Jun 20 10:23:09 qa-i360-odi03 systemd[1]: Mounting /odi...
>>>> ...
>>>> Jun 20 10:23:09 qa-i360-odi03 kernel: RPC:     1 added to queue
>>>> 0000000093f481cd "xprt_pending"
>>>> Jun 20 10:23:09 qa-i360-odi03 kernel: RPC:     1 setting alarm
>>>> for
>>>> 60000 ms
>>>>
>>>> ... <link status down & up>
>>>> Jun 20 10:23:10 qa-i360-odi03 kernel: tg3 0000:04:00.0 em1: Link
>>>> is
>>>> up at 1000 Mbps, full duplex
>>>> Jun 20 10:23:10 qa-i360-odi03 NetworkManager[1511]: <info>
>>>> [1750414990.6359] device (em1): state change: disconnected ->
>>>> prepare
>>>> (reason 'none', sys-iface-state: 'managed')
>>>> Jun 20 10:23:10 qa-i360-odi03 NetworkManager[1511]: <info>
>>>> [1750414990.6361] device (em1): state change: prepare -> config
>>>> (reason 'none', sys-iface-state: 'managed')
>>>> Jun 20 10:23:10 qa-i360-odi03 NetworkManager[1511]: <info>
>>>> [1750414990.6364] device (em1): state change: config -> ip-config
>>>> (reason 'none', sys-iface-state: 'managed')
>>>> Jun 20 10:23:10 qa-i360-odi03 NetworkManager[1511]: <info>
>>>> [1750414990.6383] device (em1): Activation: successful, device
>>>> activated.
>>>>
>>>> ... <connect timed out>
>>>> Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:     1 timeout
>>>> Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:     1
>>>> __rpc_wake_up_task
>>>> (now 4294742016)
>>>> Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:     1 disabling timer
>>>> Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:     1 removed from
>>>> queue
>>>> 0000000093f481cd "xprt_pending"
>>>> Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:     1
>>>> call_connect_status
>>>> (status -110)
>>>>
>>>> ... <wait again>
>>>> Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:     1 sleep_on(queue
>>>> "xprt_pending" time 4294742016)
>>>> Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:     1 added to queue
>>>> 0000000093f481cd "xprt_pending"
>>>>
>>>> ... <systemd timed out>
>>>> Jun 20 10:24:39 qa-i360-odi03 systemd[1]: odi.mount: Mounting
>>>> timed
>>>> out. Terminating.
>>>>
>>>> Jun 20 10:24:39 qa-i360-odi03 kernel: RPC:     1 got signal
>>>> Jun 20 10:24:39 qa-i360-odi03 kernel: RPC:     1
>>>> __rpc_wake_up_task
>>>> (now 4294770229)
>>>> Jun 20 10:24:39 qa-i360-odi03 kernel: RPC:     1 disabling timer
>>>> Jun 20 10:24:39 qa-i360-odi03 kernel: RPC:     1 removed from
>>>> queue
>>>> 0000000093f481cd "xprt_pending"
>>>>
>>>> Jun 20 10:24:39 qa-i360-odi03 kernel: <-- nfs4_try_mount() = -512
>>>> [error]
>>>> Jun 20 10:24:39 qa-i360-odi03 systemd[1]: odi.mount: Mount
>>>> process
>>>> exited, code=killed status=15
>>>> Jun 20 10:24:39 qa-i360-odi03 systemd[1]: odi.mount: Failed with
>>>> result 'timeout'.
>>>>
>>>> This patch forces TCP to send the SYN on ETIMEDOUT error.
>>>>
>>> Something is very wrong here...
>>>
>>> If this patch is correct, and the call to
>>> xprt_conditional_disconnect()
>>> does indeed cause the socket to close, then something must have
>>> bumped
>>> xprt->connect_cookie.
>> I'm a little confused here, xprt_conditional_disconnect only closes
>> the
>> socket if the connect cookie is still the same:
>>
>>           if (cookie != xprt->connect_cookie)
>>                   goto out;
>>
>> So in this case the xprt->connect_cookie has not been bumped.
> You're right... Sorry...
>
> So does this mean that the socket is still in the SYN-SENT state? It is
> normally supposed to remain in that state for 60 seconds, and resend
> SYN using an exponential back off.

Apparently this was not done by TCP in this scenario:

... mount starts
Jun 20 10:23:09 qa-i360-odi03 systemd[1]: Mounting /odi...
Jun 20 10:23:09 qa-i360-odi03 kernel: RPC:     1 added to queue 0000000093f481cd "xprt_pending"

Jun 20 10:23:10 qa-i360-odi03 NetworkManager[1511]: <info>  [1750414990.6383] device (em1): Activation: successful, device activated.

... RPC task timed out on connect after 62 secs.  Note that at this time the network link status was already up for more than 60 secs
Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:     1 timeout
Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:     1 __rpc_wake_up_task (now 4294742016)

... RPC task goes back and wait again.
Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:     1 sleep_on(queue "xprt_pending" time 4294742016)
Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:     1 added to queue 0000000093f481cd "xprt_pending"

... nothing happened and systemd timed out after 90 secs and kill the mount
Jun 20 10:24:39 qa-i360-odi03 systemd[1]: odi.mount: Mounting timed out. Terminating.
Jun 20 10:24:39 qa-i360-odi03 kernel: <-- nfs4_try_mount() = -512 [error]
Jun 20 10:24:39 qa-i360-odi03 systemd[1]: odi.mount: Mount process exited, code=killed status=15
Jun 20 10:24:39 qa-i360-odi03 systemd[1]: odi.mount: Failed with result 'timeout'.

I don't know why TCP does not retry the SYN after the networkk link is
up again but I though instead of trying to figure out and fix the problem
at TCP layer, we can make the RPC connect process a bit more robust by using
a new socket for retry.

-Dai

> What you are doing should not be
> necessary if the socket is in that state.
>
>> -Dai
>>
>>>    The only things that can do that are the state
>>> changes recorded in xs_tcp_state_change(),
>>> xs_sock_reset_connection_flags(), or xprt_autoclose().
>>>
>>> If it was xs_tcp_state_change() that bumped xprt->connect_cookie,
>>> then
>>> either we're in TCP_ESTABLISHED (in which case triggering a close
>>> on
>>> ETIMEDOUT is just wrong), or we're in the TCP_CLOSE state, in which
>>> case autoclose should already be scheduled.
>>> If xs_sock_reset_connection_flags() got called, then the socket is
>>> in
>>> the process of being closed.
>>> Ditto if xprt_autoclose() got called.
>>>
>>> So why do we need the call to xprt_conditional_disconnect()?
>>>

