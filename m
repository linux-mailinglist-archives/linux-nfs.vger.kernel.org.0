Return-Path: <linux-nfs+bounces-17233-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 365D1CD0465
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Dec 2025 15:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 797B2308ABB6
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Dec 2025 14:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA523375C3;
	Fri, 19 Dec 2025 14:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LfOduMKQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jxhvUvVk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A0D335574
	for <linux-nfs@vger.kernel.org>; Fri, 19 Dec 2025 14:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766154658; cv=fail; b=uv37SWBQeNthRziWZsek8SbuiOO5dggx92Wgu+PBrBkGq0C5XhOzBLwMFs6HUoKf3RizIf+JdhJOh0A5vnJtcfimhaaPeOeXwgdDilUnPkcUUiya6xd60Lv3wqJ+fOcF+QD7WS1Eq5x35rZpFq+q2PMPVOpS9Vu+55ERb1VxdDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766154658; c=relaxed/simple;
	bh=EYOrn/avUfZboFRDsMY54S1Ii6b/3zpoo45H253nnZ4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FcSrJxSZ8ue/AQ1mIdPgC8oELsuKQzMPyRswUNDAGad3yRNMPHRi87sg5GQ4/tnbdLnPcx2cHJeOn4yPfZLtajN49QNjIRUn3CCtP5rWSdrUGhWkhVzAtct7cOMBHsh8Tx+DPI9pKqOjfeTpDV32V9R5PmX2SDdq36gjYcdz/BE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LfOduMKQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jxhvUvVk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJ3EJmw2849898;
	Fri, 19 Dec 2025 14:30:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=WUgUsu8JqFy4alJ/xicPgapqIsBhPlVXugrQ0qVXWtc=; b=
	LfOduMKQkwZpmGQ5atI5dLHuUwD3FXGz5P5MoYVnRa8cGw7YHsSSl+Sm+UTZ82FM
	MU/UpTkOG8uz0Ms5W9BvurVk46Yje8armOUXvJGurYzBERLDemR6l6GplET5tocG
	Y1AMIr2ZeRlUFpp9tlPjFxNPw0XLVRFApN8nIJfIShgeUAn4VbZkAAuFtRRU0i0J
	vEgz9z8EJSxNTGbJdDVpZBnQlZUd7Y9Ig8V7tg8LLF7ZzXMX/CS1LOc2MhDFoFoW
	Pb76ikOleFiNh0YIwf/q7I/Y3Zf0GFKuE/0dnV22hJI1s0grG3ZKgrYTfrMC5swf
	nHVNGJG+uiUvc6kvGrD4+Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b4r2916s2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Dec 2025 14:30:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BJCUiSn023549;
	Fri, 19 Dec 2025 14:30:39 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011005.outbound.protection.outlook.com [40.107.208.5])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b4qtb0bx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Dec 2025 14:30:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yRDuNCBDMKviZbMik6QphNTrG3QD2C006t0DsCVrxLfqQhCzfC9PGqjQ9hiXTKN0YZb3+QlNCMiC3AwgG8OW/Y+jghLNvFF9/DRCLVwa3LwoE0NHsXias46V79UAnYFqHCWBAZsulfwxYsAogaeoddiIQkZ5JLials9aRpvV9Z1P2IZDvP+ArFLqk7YRBnFM7eziW19xf2kV9lY8dFfdqQX5WxTB7WbUppGq+NkPz+nxEDvK4jvCt/Rj4r9geq3quDMqKGfQvpD+LOEerB7A+ePYPGR47NxRnrJL/o2/VY1UZrTdEEX8QVuBgLithHzHDq0LAvVdUWnEyhMxj5syPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUgUsu8JqFy4alJ/xicPgapqIsBhPlVXugrQ0qVXWtc=;
 b=n+gcgMKhyYR411dMJphCrMhHkT84DWNW5F17M61cGdYsPv/F7hsuUFiF//2bvSf0JY7yWOxNcS4Uoro3LtxIBvapZLHmgoZHOz8a9iAKpZ+HLdHlqGio9APKqk4Xo5SaJzR4vC09QyR4IcDenHXRgXfZhGihZLSIaC90PuVpY54PYLqFAmJfbsfZJhQJBL4X5Bg0VOglCIWxkOirLjUtD4JjMPB8WengJ7YXLSmDJciqMvs30nRFMVT5X3/FTA75FXXgh4pa5M+E9kH66fTOZhR1+cd8QQrDn0ViW+Tj1RYcXHSq0pi3E7LhzBe8zsL/StAbLvLDqqES6KKKoU5uog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUgUsu8JqFy4alJ/xicPgapqIsBhPlVXugrQ0qVXWtc=;
 b=jxhvUvVkjCCf6F9YViCRJPGnrKhwM4v13xLfCf2fdRMne8avuzmqWsFscuIRS1rJSDyVXOemoRPnE6/QUPEQrUtXgdQc/3yYtm5F/zBTXFJAjMNSITPwgpB4ZII4d44jO/E371O90Bdpsn1bycjPiZifzIKs1nXmhOzeWvGssDM=
Received: from BN0PR10MB4837.namprd10.prod.outlook.com (2603:10b6:408:116::11)
 by MN6PR10MB8094.namprd10.prod.outlook.com (2603:10b6:208:4ee::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Fri, 19 Dec
 2025 14:30:37 +0000
Received: from BN0PR10MB4837.namprd10.prod.outlook.com
 ([fe80::c72e:a12:cb7a:b53d]) by BN0PR10MB4837.namprd10.prod.outlook.com
 ([fe80::c72e:a12:cb7a:b53d%6]) with mapi id 15.20.9434.001; Fri, 19 Dec 2025
 14:30:37 +0000
Message-ID: <b5c56068-b789-456d-afcf-b97cd95ff3fa@oracle.com>
Date: Fri, 19 Dec 2025 09:29:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/24] NFS: return delegations from the end of a LRU when
 over the watermark
To: Christoph Hellwig <hch@lst.de>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        linux-nfs@vger.kernel.org
References: <20251218055633.1532159-1-hch@lst.de>
 <20251218055633.1532159-24-hch@lst.de>
 <13891f50-73a1-40ee-aaa2-373dba3886e6@oracle.com>
 <20251219052124.GA29411@lst.de> <20251219111411.GA11715@lst.de>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20251219111411.GA11715@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0029.namprd07.prod.outlook.com
 (2603:10b6:610:20::42) To BN0PR10MB4837.namprd10.prod.outlook.com
 (2603:10b6:408:116::11)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4837:EE_|MN6PR10MB8094:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c89d68d-e526-4e9e-d65b-08de3f0b2d7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVIrREI2WUxyWTdON3RCY3VuZUpZbzNxSlorQ0FTUGlpdXZpeU8yWFFNeEdB?=
 =?utf-8?B?NG5ramRHcW9peVlPby9ua1Q4aGxmTVU4blJlVUE5STU4SGk2bDdwN2ZVb1BI?=
 =?utf-8?B?Y29jaEM1Vkg4WW5JS2txeE9RNURLMXNGUW83ZVY3dDdRNXcyWFV2OENSN0Fm?=
 =?utf-8?B?NUg0OVo0cGdKNHFtZWJxVVQ3bzBETEdnbHl0U3E3eUsxeWFET29YYnNDVkFy?=
 =?utf-8?B?OUltSERaS0FkdkZ3TGJYVXc1SUZPWHRreVU2ZzMvREx5eXMwZGpJRXZDSmky?=
 =?utf-8?B?UkFXU1JlZTU5blh1NDVWQUJmVUtualdnSXVETHBOTGViWnJYZlZ5bTFmdXE2?=
 =?utf-8?B?YWRLc0djVDBpbVNQemJweW1GU1BZZGl6RlZGMDdXRGowSWJDVGFMdTNJOEdO?=
 =?utf-8?B?Nis0SEl6akpQd3pmUmR0OW9qZkMwTms1Z1VUblArUDFoU3NHcDZHZWhDNXgx?=
 =?utf-8?B?TGlBL2x0dGVrNldPSHVEelhwUlBhUHR1WjlnUkl5Sm94UStMZmt2d0x0VVQ4?=
 =?utf-8?B?L2VNTnRadUVZWVVKaXM4MmkvNTdVU1VBaEpERTQydGpKY3BHM3FPV050MzNn?=
 =?utf-8?B?bXZVSjJEKzlWYmhjMmMyeE04K25FR2JxcWp0QVg2c2xSMlZSM3Vkc3BrZzA0?=
 =?utf-8?B?OGo0TlFqRHE3dTFSN1I3UHpuVnNmWDBLSE5zekRRaTBJbG9TekgyemxsS1ZM?=
 =?utf-8?B?SkZya2prT0NvbDRUbDR0bkpZTkk3M1RPZEN6SnBsb3ZFSENkdldUSTdjTm5N?=
 =?utf-8?B?Wk1RTHlTekRmTFhsWXhaaEM1YkdhUEhHRzNhV082REQ2SkdLb1daVFY4aStR?=
 =?utf-8?B?Mm1lOVpmZlZvYU1uMzRHK1ZYVkY2bXFEeThuMTFneWRacGNOVFl6VG9IK2V3?=
 =?utf-8?B?OW8rMnFhN3puL3M5MXIzc1dwMzNueU5pdjVVeEdLcG5YS3RGZUNxU0IzZCtC?=
 =?utf-8?B?Zm5xUkRRQ1dtYWF0YlZVQjFTaDAzT1p6MUNuMENRSXNyYmVldHRMVStyVkpw?=
 =?utf-8?B?dFJGYjRYQkY3SjhieGFmVk5mYnpNc3RNL05OTmxackhURjR4K2V4VkRlR2oz?=
 =?utf-8?B?T1BPTWZ1a2xPSVVZdzZMQTFXSU80bG9DQjBIWkplMHgxckEyQ1phY3dpVlBY?=
 =?utf-8?B?cUpEUkYzbU41WUxpTENaNTloSDdqWjRkK094L3lraDdFU1owL3R1YXFHdVI0?=
 =?utf-8?B?Z1QyOWVQdk5ZT2RxQ0x6TE1oL3RsOGJ0TFB1UmM0NW9xZFgxN3hGdkJYV1Ur?=
 =?utf-8?B?NUlkTk45ZHZrYWxqb3dGOGUzRGZmRlpZMWpjZGp6amw4QmRrSHVCSTdkYWNu?=
 =?utf-8?B?bFFQNXVYUnpUQ1lxQXZSTTRwL0VmREtHRE55QjNXNllOdTdLdWQwQjRyKy83?=
 =?utf-8?B?S3FPSjJZU1pHUUUxQ3dKL0Z1elRNS2tFRC9HcHNPWEZhVzF3UXV0UVY1ZlJr?=
 =?utf-8?B?Tk5HdzdYVTQ2bEVNTHhObmltZ0todW9GMTNUZ2hxL0lhMURyQ1JjS2lZVmFt?=
 =?utf-8?B?eTZnd1VCK0ZBbU9jUzZabmVjc2sxdmlqaHBva1NFdVVPWk5qdWhWQzN4cUFP?=
 =?utf-8?B?U0hIdXBVckQyc2lYT0hBSzZMZXFadTVxMXhBZDlEbHBBVVFkM0NhSkJhZ2Vz?=
 =?utf-8?B?ODkzWW0vVHlsNk5kRzhEWGJ5RU1QalBGNXZUbkVMSlVZdXIyaGxOT1hBbHRl?=
 =?utf-8?B?SnZ5K3NXMDUzeDNtcEQ3QjNkM2JkZjI4b0R4QWxHZU4vbXBnNzZVRGRwb1Ix?=
 =?utf-8?B?N0l4Y0o1N0ZoNnFEc0Y0NkFFNGQ0cXE3RUFEanFHLzdFZXhpU0xHMjF5dzZB?=
 =?utf-8?B?ZzVhdCtRN2F2aTNNRG5idVRqNzkvbGp3WWdyQm0xWWJKQjVMK012TTNBOG5Z?=
 =?utf-8?B?OWUrbXhySEZWZHcyelJWSFk1Ukd0bGg2VnRQM1VyRGYyejFCVWJmeUkvQnVU?=
 =?utf-8?Q?Ga77eyOa4woLAN3J5pioOK/i63Zg9j3h?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4837.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmVOSGdpc0EzNmloeldrdTBlSnBKUDE5OTRqRjlhbTlkcFhrLzRzNklKUXdS?=
 =?utf-8?B?VzFsUURaZkZ5VG5vRllmNlF4ckM2M2hEclpxMlcyV3p6czRhSytmZ1NIaXpF?=
 =?utf-8?B?VHV2WWU2NHFvOVl0Y2NKWE4reWFiSkxJTDJ5YVlMQnZ6VmkxSWN1QmlNSHhz?=
 =?utf-8?B?VWZCTDBKTk94ZkF2YmVhSVdtaDdRNnVJOElWUzkwdi94MS90Qk5kem5ibzlh?=
 =?utf-8?B?c1FQWW5oSk1jcEc3dURoTkVYczZvby9ZWmc3OGlKRVNUWUJLMkl1VWkrSjBz?=
 =?utf-8?B?ZEpPeDRyekk1cXN1T3drMm5kMGhRbnR6bDZXQS94M1JHNWVvdlE4a09hKzlP?=
 =?utf-8?B?MGxTdzR3WTJabDBUY2hMZU1HOTJsME1zNUdxd2ptdlZneUNwZUp3U1ZGbkY3?=
 =?utf-8?B?NEM5eGxJNGJLcmNUWWZIeGRTMVVyS1dGKzkwVTdtSlRGVXJoa0pXaWZPMUVF?=
 =?utf-8?B?bGhwcVQ2VU9zTUN2L05DdzVQVjVnbmxIR3lQVmFYVlJMZTJMWUdjVmlRVTZn?=
 =?utf-8?B?MzBybnhpbVpYaUs4Z1VLVDBwVk9LTTNoQ3k5N1d6TmpkanJiU0dldXBPcEc3?=
 =?utf-8?B?NEs4MkdYeURFTkkzb3FNVXJMOEZjaHFJa2JIR05Ya0ExVjM0Q3BFeUhsa3ZC?=
 =?utf-8?B?bTYyd2xxVEZIRXBKRVJtbDhsQnBoNWFMcjBLa05wVFF0eFprMG1CYSt6bzBI?=
 =?utf-8?B?UDRMeWs2amxFL3FSUWd2Y0xsUTNnZ00wYXBOeVZpVXVoVnkyeDJiNTc1R2xk?=
 =?utf-8?B?Yis4YXRPTXJrOG9uai9Fb1ZFVk1RVXl2YUN3SnVUYVhrSGJQRFM3Z3Zhd0hZ?=
 =?utf-8?B?YVJER0JTNnlDMTk1UklZYUo1SFNickorS21ma3YwOUhFSFJqSGRralFGZXUr?=
 =?utf-8?B?bDlDRDFNTEw5a1VreU1FUzkrYnN0dktGVkgwWDhyRmJtQXVvSFp3VnBHTFMv?=
 =?utf-8?B?RjN3NWQ0K1RpeDdmUTIrc29GRVJxWlZHM1h3dTh4eUZIclpqVDFTK0R3Wmw2?=
 =?utf-8?B?QzErNVBteWpZbEFOV3I1bXpqRzN6WURQTE51cEpuSVJuRjBWRUl1azNLakNa?=
 =?utf-8?B?ZnFpSExvcC9HVHE0MWp2S3BUemFrWjJUdVlhVlRSZE93ZFhoUkhKN0JPMXYr?=
 =?utf-8?B?cW94cnM5N1MvczZCSW5RVGdJc2l5V2JOdVhjUVM5aE5XS1Q0dXY5d1NhK2Ju?=
 =?utf-8?B?VHovTnVsWGprNkN0U0Mycm1GUUN1M0lwSDZzZ0hWV01ZTkdTQ290QTRva0Er?=
 =?utf-8?B?OGIwVVdvekowL2ZVM21kRkIyS21YekpMU1JSYndPQ1JlQ2hMelZFczdZWjc2?=
 =?utf-8?B?TFRBb3c0RlNUMDVoV0gxK1pjc2t5b1pUaUp1RlZweWZiNTAzdlRMUHlBUXNG?=
 =?utf-8?B?YlJjbURlcm5iMS9Ta2NQeHUyWkhWekhwMUZoUm1HRzM4SXI5eHJkQjZVd1Ez?=
 =?utf-8?B?OThDbTVnNEw0bi8wSXlSeGswNjJoUSthN2UyYWlPS2RqdG4zNmVjKy9lbXRC?=
 =?utf-8?B?MlZGUjZnS3RLVUFrb2p0bnRURnUwYXZXcWk1bzNlZTB1eDBkYWZ2dHlaSm1Y?=
 =?utf-8?B?MndYUmw2cEhOVFJKZEF1WUxITkVSZkh3RHN2SjA5N3RYZ1V5cXhiWkIycTRy?=
 =?utf-8?B?L29ucVYrNmxmbktDRG9xYklGVmVBMWgzSHJZNjBLb0xWY25GQVNWTDdUVXcz?=
 =?utf-8?B?SzIva1lyZW83KzVZcDBRNVozU2s4M1JVQmkreUtnMEw0UTBRaDdTTVJjOXlB?=
 =?utf-8?B?UWQwbGJxUW50eXQ2bWVXN2hxaklrUzNVSXcwN0JpN0xVMFU2cW9RVFpmR1Vx?=
 =?utf-8?B?MEY5RTBpd1NSMW14eGNmZmxVY1ovU1I1TlJNZE1hVXNUNTA3dnhoOCtKT201?=
 =?utf-8?B?elFoWmRhYUt4WFdKRlhzV0xPUitabkExM3BsZU9DNHU3MUJoeUEvWkt4aW5U?=
 =?utf-8?B?ckhmYm5GS0hRVzJpTFNQbFJ1Y0ZIenJDSjl3NlRVZno1dTMzZlRhOGNkVEdv?=
 =?utf-8?B?N0pEL1BDdktXQVltRGtsS2tQY0tQYk1kSEdaRjdTbmxEb2tINUpzaG5mMjBN?=
 =?utf-8?B?dE5mTnhkNGJDR1NvT2R2b3M0TWpYc21jSDJFaWpaQzBBaUUwN293cnRXZitw?=
 =?utf-8?B?dytnSjBaZzFua25JbUkrUmdMT3E5b2F6cG1ucEQ4UHhWREVhVTBKN1NRUjJN?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+VbqkbOl5Xs4KjaUrI4HH+qPaFk+UXSS2gomApq21dNmEZatM2FUQYPOrBU5142fy6UryRjLDDSLztK9wH6LhdHlxcyf0Ji7VqjBmWNeqFY8xtDe8nsnxo65tAnrjEqWsg4vi2q/CdLqW8z5vp5R4TzaPxxTqZfYnwYPFCLV1LKcTd6JpNaQX57mCTL2pJQxe/AAq64qmUpvwsg2D8onUu5wx5hKXN0gkpmloOJldoZB5W2CCmQadIi1fhXsS9lZxx2YbVGJvj73Yo2kdItfwOrs3TwkAz1H5q7VaZYmjatBSqqajiqgrktgt6A/Iqf5/8edJI99e0lM2tVuYOPwyxKvUxBY9cHdt5G+rnLvm4X14Vhv5ysxnKfrjY3gC2R4OynPXy+a0WMunG2YA3sNGe1qQ/EfLmbdFmlbsHy0+wuSBzTKxHnpGg2zgoS6Pca6ufcj+C83RausWgyB0enxVd4HniVcaYEd1oqadee/kwCrzsW+fNqCWvqQQNHyEp1lg9vFQidvdJekaTdOxHSJnmAu7sxnPPczkafIFOxWbI6dkpNt/17f1jLvXEarA5xwcyQriv0YjSKU7UeaFn4vVU5hfYYyejznF5etROqRqYI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c89d68d-e526-4e9e-d65b-08de3f0b2d7a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4837.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 14:30:37.6417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y5vZqcThTr9jAMWxdcaiSxsYUkM8Ror4RzjKjGVco0q/Q6yXWFp2rcEvxccxoHMDfmAMjwWRCgr0osWYBBU4x5Xah6YgOoV4gurUSc2KKOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8094
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_05,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2512190121
X-Authority-Analysis: v=2.4 cv=WZgBqkhX c=1 sm=1 tr=0 ts=69456190 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=gbZHxKEZqe_2Lj0Q:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=3qIwRWhqp8L3pyL5VxwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: tU2q7bkL24J5k_C4noYp0-FWetrIbQ84
X-Proofpoint-GUID: tU2q7bkL24J5k_C4noYp0-FWetrIbQ84
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDEyMSBTYWx0ZWRfX1oW2opo+8hGX
 uhSUONtG5XbhNWD6YP1iuEwfWnZEk0SxqsT3EVkIXBdEjMPJA5BlzHBFIjt7D7KC4ZiMOY1393k
 vWed4BkyH9h/m/HSrN+J+XPLJHuj1dQ3zP9jFqH34ESkr/R84VjxEiXUoMMlxZTh+PhawqEy7DV
 90zK4KEtoWWMlYMtDEwJZDNFibvPwZWyqdyLTTmmsCbwMCZxPhDbVp6KjUiLAZWd1lWVaY48FuA
 K1Uu0Fa+DQHiuJP8XTp79TOTqeugdTotqxehvee3uSCTYOFxarFBcFKQ+ntEBec8tvcuGFtp83N
 13ind8b+dsNq4sk0pA7wWYT0daol6qt/IXNHs2QxNql9RE32isHkQxgWEPC5TKNFKhLnXHuQuN9
 DuZMJNzrbPJhhxTkGTW9cG5Wnebp3F7xw9PayTg7lELUpjlUJvKN+W//G51Ulk1PQwgTVto1jNz
 DduQjs8inmF6qGoP19g==

Hi Christoph,

On 12/19/25 6:14 AM, Christoph Hellwig wrote:
> This was caused by a delegation already on the LRU not getting moved
> to the return list.  The patch below fixes it and passes the xfstests
> quick group with 4.0.  I'll fold it in after a little more testing.

The patch fixed the issue on my end. Thanks for looking into it!

Anna

> 
> diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
> index 776020bdf8f3..6497fdbd9516 100644
> --- a/fs/nfs/delegation.c
> +++ b/fs/nfs/delegation.c
> @@ -93,11 +93,9 @@ static void nfs_mark_return_delegation(struct nfs_server *server,
>  				       struct nfs_delegation *delegation)
>  {
>  	spin_lock(&server->delegations_lock);
> -	if (list_empty(&delegation->entry)) {
> -		list_add_tail(&delegation->entry,
> -				&server->delegations_return);
> +	if (list_empty(&delegation->entry))
>  		refcount_inc(&delegation->refcount);
> -	}
> +	list_move_tail(&delegation->entry, &server->delegations_return);
>  	spin_unlock(&server->delegations_lock);
>  
>  	set_bit(NFS4CLNT_DELEGRETURN, &server->nfs_client->cl_state);


