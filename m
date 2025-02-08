Return-Path: <linux-nfs+bounces-9963-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A5EA2D7B4
	for <lists+linux-nfs@lfdr.de>; Sat,  8 Feb 2025 18:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF8BE165D58
	for <lists+linux-nfs@lfdr.de>; Sat,  8 Feb 2025 17:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959A51F3B87;
	Sat,  8 Feb 2025 17:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UQ/OFpM7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sgwh4m5A"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69081F30D7;
	Sat,  8 Feb 2025 17:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739034340; cv=fail; b=FxAHOalk+xwCEvCxJdDNC0Cbty7me4vH7ekYQbtQEd8O7LmjNtkBTPANwGz1mqRDXsN2BdItuw+7G/a82icnAdLQriEQYz+lrJXEoIwEbyqn5tuXBUJQ9Z9WBIgyMDPPkRj3jT/hfr6bRgoZu1AxOKbhO0arvRPz7V62HuZ1Sfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739034340; c=relaxed/simple;
	bh=/+06kM27+wcWQmCVxbYqJjk9FAmNf0paCTZ/DzBGduQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K/4RA6N7Gooz5CMSt5VRZ3Ti4kov5gKU20Y2t7rrYb/uYypeRKhhYnAOR05h6b4XoDBymxRWdtXjyv1l3Pr9unmo5Tj4pWEanT02Wuf97JgMi9Ag7HHDKgxyV+BTUBx7E1yXa1h3+NRZnmEMANxsNsvTqwiHldNq6Och7ryrRYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UQ/OFpM7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sgwh4m5A; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 518DkmDK009238;
	Sat, 8 Feb 2025 17:05:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Jp7zmKrKHTApWpcYwSCNH+HWnGasL7d+7ezvjrwkNKg=; b=
	UQ/OFpM7uxfMNblPwPEJ8RiJFFeah30D5NAfFaZN6ksexcVTMGPmR6Xas7Jk286g
	etwcxhWGywIiFPxqI69rRI+fkImDKtKGs8g5cs1OtAZ//JPRoRdetSYIVWFw3LS6
	tLfqTr/lo1zzh2XN9xycgaVT+JyDShcvH7MSwGAATrXyDiVUCoqplDMM7aIzDTK0
	eudAnPRSip6HttWdx0EiIMNj8afkk7wtCHteDUTnysf/5YFh0eCPNcPs0Th/ybq9
	2W9/oIR/sn3HVqWafO0nPb2YPwt4fNxA/TXYEq1ylGwGQiuphmysxcapYzZSihYj
	zgFrtvKFOFfrl9j4kvWa5w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tg0cwp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Feb 2025 17:05:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 518FHimM040837;
	Sat, 8 Feb 2025 17:05:27 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqcedtr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Feb 2025 17:05:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=erhx1fqc8ak/9KScIOi4yw5ccq2+69bJubA51gAZgHccZYQr6DRQrwiGoPV2zETEKg6K1+f2wfinIItpXftO4VGT9YKACecP83A5cVw2PqlFcKdZWJk/BKnAJM8I71qTstefuwXZy56XXi408CTMUzks2WqDnNKikwwFZWPXZrrUtHVs0poxFBBva8/FIftSyjXRxa58+58zvfUcf8ryFK5De6XJDtLi4luvVzwbUKZNdkjqwO8GYDLmhIdCflQATgUok61EJFMvKrAnHdZXSmlGV1GG/FJcounNZE30ACm2jmMejjqvOyBtYGR40YySFlNU1GziI+RBtR5PsP4luw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jp7zmKrKHTApWpcYwSCNH+HWnGasL7d+7ezvjrwkNKg=;
 b=gN6cW+Mbk9S01K8s2hg25Qgj7K7pruF0FFDPdMf+jYKRMWisvzcxcm8R0Xd+MmsDEVgh1hEewOaAzA7Xj5E9NXFM0CWFH3X3120yi9w7BrxyR10QNeVda9bu39Ux6OlkT/hb4gCjU0NpjUV5bDfA9BmSeH9HHtmPXD4KMh+TIxujCYU+A53qxuZMvhNmc4TM+4J+1qHgphlAZuo/Is31FFpw5YrGNmssRZXFTpXqGkYaoTWkW7osnuZkpBVmTu0h2KrbwaKH8L1YG3m8sBUqmkL9zUG5ek8idXvh/sx9SCkhLS+ZcitRZvmGEGOc64SaZjHJHC3qa3c4hWVWJkHpeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jp7zmKrKHTApWpcYwSCNH+HWnGasL7d+7ezvjrwkNKg=;
 b=sgwh4m5Ag0bUWcBQ9Kt2FN+lVRbD1Cer3lKgy/gSu1AvditSZK3cJBoix27lWvKGnxbUQmvaKmiEl5krC1xYCww5rgI2/1AqKxpv+KB/bkZil1nSkvRLWtbgwjIbUyotHVUgRyRj+u9d0tMzgOo/tGXUF5LSPotWRyDqua6glX4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV3PR10MB7913.namprd10.prod.outlook.com (2603:10b6:408:20f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Sat, 8 Feb
 2025 17:05:25 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8422.012; Sat, 8 Feb 2025
 17:05:25 +0000
Message-ID: <0eabc5b5-88ca-4d48-a5de-80a7be03a1f6@oracle.com>
Date: Sat, 8 Feb 2025 12:05:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] nfsd: lift NFSv4.0 handling out of
 nfsd4_cb_sequence_done()
To: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250207-nfsd-6-14-v5-0-f3b54fb60dc0@kernel.org>
 <20250207-nfsd-6-14-v5-7-f3b54fb60dc0@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250207-nfsd-6-14-v5-7-f3b54fb60dc0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0059.namprd13.prod.outlook.com
 (2603:10b6:610:b2::34) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV3PR10MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: 93a594a1-cada-412c-8666-08dd4862c78f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUlpNDJyOUMyUXZXWWhGb09OTG5qcXJGS3BtWWtFV0h5SlpJVERzcWU5SG5r?=
 =?utf-8?B?SkhsQjBmVVdOcU5Jc2hTMWpOTkFOMHJTY0tPcitIMnZjNUI1VUpENkl0NEo3?=
 =?utf-8?B?WWNXcEdDcjlKSk9FZVdNb0FRbjJ6Z0lmZ1RhTzYzMGFkWFVDVWxpRitWak9K?=
 =?utf-8?B?eDdOUlFUOVZaMmRMUE16ZnZBd0YxcmhNd2FVd0syTkVRc1Mrd2V6VjZYd05P?=
 =?utf-8?B?L0RJL1R5c2FaQ1FxUGIyeFZpb2J3MWRIcVM2R3kwWU03MHJjV09CTTZuUkMw?=
 =?utf-8?B?UzRIQnpYTHU0NzFvbXk3QWFydEZpQUhRVThYQ293M3dpeVkzTXNOenhWUXBn?=
 =?utf-8?B?dVJGMDNON0FBQmZqS3ZLL2Z1RDc4Nmk4T3oyL2J6ZnBIN0FxUmQwNjMzK21U?=
 =?utf-8?B?SXM3YnBVNVIrNkJnTlIvRGtCUWgxY3kxcyt1WFJPVHZ6QjBEK3dyeWlobmE3?=
 =?utf-8?B?akl0NDJCSmx6aEdndGdvWmFFRUx0OHA1UUtoRkdPcGJLZVUwelFYUitkUE5v?=
 =?utf-8?B?bkRMM2R3bnBXR0pNZjhteXRLakN4ZHl1Z0x1SUU0VGwvMEVaUnZ1NHVWZGZO?=
 =?utf-8?B?YzRQNmZ0TFBWTTlYejF4dGQ5eU85TXMzS29GYnJYek9Hc2QvN0JWdzByNkFF?=
 =?utf-8?B?N1RCU2gyeGwydXRZblZyZDZCT2lIWVFLdXZMZ1REeGdtbCt3cUJDenNYL3Rp?=
 =?utf-8?B?OU5Od0lHRXcwNlJ4bjNpZE84L2RxL1RqWDBLVUtiSzVMNjdkOFNwaTROM1BP?=
 =?utf-8?B?MnZXYVFVRXhwZEJmLzMxYkFCNVpoa0M0U1ZrNi9KZzl1c09lV1QxN0dPbGZU?=
 =?utf-8?B?eVYwNDcrQ05BNHoyd0daQTR6UGNHMUZ0dGJUQVBJQ0ZUdTVxR3N1WEJmU1Bl?=
 =?utf-8?B?YUxNRi9VeFEzbHMzZVh2R1puUmh3SDN6QkhvUEFBSTJDVmFXUVRKOWxXMWZB?=
 =?utf-8?B?aElZLzBiWlFMS1UxVHBrZlJ4TncrVmFQakplSlY4cmpaNGpQdVNoQnB3Vmx3?=
 =?utf-8?B?S09QWnh3MUVkSHJRaHBXL0h1bmhUTllkaTRFSUpqSGJMUGR1VzhvZEIwZkth?=
 =?utf-8?B?R1dnTGFYYnNXUzJsUmh5TCtER0hLSzFHMGszTHRoUW1VcUpBbTBDWDQyOUNZ?=
 =?utf-8?B?TlM4SE51L2Z4OHkxanJ2MFo0VTBFWGgwMU5nM09MNWNIai9Vb1ZHR2RjRDkw?=
 =?utf-8?B?NU1wSVNKZzBGVEQ3b2txVWZldVZEUUV5Tm1sOGRMZUVFQmFYRlg2dUtvS2lm?=
 =?utf-8?B?bFE2WkYwTDl4SGRFbmtZdUNUclpDRE0xbzhVREljUEtJeW0wWHhBRmJRSzAy?=
 =?utf-8?B?SVF3SmZLVzY4aVgwOEg4MWNMQUhLWlIvaDFKa08yYjV0SzJ6L1hUS0RuMnRU?=
 =?utf-8?B?QWFyUUNlcm5yTGlxd3pQMWU1RUM2RkFQb1czSkgrYjNGd01GdjVZMzB4RUtU?=
 =?utf-8?B?UmVUNHJKNXV4OHA0NzJDKzhSTVlDY2l3VzVPRFQ4OFQ5cmtMWG1WekJmMU5C?=
 =?utf-8?B?UzhUWGZRa3lRRWRXSEZPMlVsbXlsaTdzTCtueHhDcW9pN3hOdVpkenNNemxo?=
 =?utf-8?B?Tk9sdnVGTTRlSjJsM0VGeUZodE9zUnQ0RU1nOGRaQ1RoL1FoMjV5Tm1xNFBG?=
 =?utf-8?B?a3lUQ0lQUlpoZVVJbGhOQzJGYWpHK0s5RmRIOE9jdmFxZmlERTF0K2g4ZUY5?=
 =?utf-8?B?aWRzbEgxTUwxeGx6V1ZPaktZK21SZ0RmQXJOVTBleTJzLzJUNzluWVJqcVlo?=
 =?utf-8?B?ZFV4bVMrZXd5M005cXdSaVYzd0piVE1yVmJXUlR5TkhDRmJ2UHQ1dEkzblRI?=
 =?utf-8?B?THZqQlZPaUl0ZkFaUlVWT0dMZ2RFV2QrbnlYOEV3ckpYbTltVmJpdGU1Zld4?=
 =?utf-8?Q?HSqVwVEQ+pJ2F?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkdMaTg3OHZjd2JuUndsTDBPVFp4M2Q2ME9ZUFcyeVRxU3BCNXUyL3FWbFJl?=
 =?utf-8?B?TkFZcUtRZFdJR0h1WUlVQjJBZWR3bC9HNEJVWVQ0Si9aa09sbnYwei9RMXFK?=
 =?utf-8?B?QlhNbDFueHZYMHJGTEs3bjJJRVlMeHA0azJIeG1ObXNIQTFFMUQ2WkJQejhG?=
 =?utf-8?B?dmJob0s4ZmVLVVRuaGQvVWJrL0s3UFFBejFxNU1la1V6WStCS2IwRnkyWkVM?=
 =?utf-8?B?enJuanJ1dnhHdWlOSmZSMHFLNXU0eGNxMGNxZWFiUWs0SU55U09FMXlnaGFV?=
 =?utf-8?B?Y3hBdCtZYk9GWE9DSWd2SjJ3WlkvMWN3YVFaQWhpaWIzVWNMNFBLUHlCRGpl?=
 =?utf-8?B?WDZVajM1dS9VczZxNFd3dnE4UXJYRWwzT2NjV2lGdEdkSSt5NFdxMHV5VDRs?=
 =?utf-8?B?ZW1TSzdWbVlQQk5QZkhML1F6YjlVbDNiUzlyTkVmMXJGSmNMTW5MUXdJcis2?=
 =?utf-8?B?OGdIWWljME9ocmpEUzMyV3BRcVJ1TFFYbldhV3RXMXZGVWtSN2NKSUJKTml4?=
 =?utf-8?B?UUVKamZqakJGd0JneUZObHV3RHFWSXNTRXlkbVJuMm1acXlTdklYZDVuYzdz?=
 =?utf-8?B?SVcvRytkQTlScndBR1hUKzNWY09KRmlFUVhmSlZRQWR2Rm1IMytUMWFGRDc2?=
 =?utf-8?B?dDdJY1lIbjhlakkzUVpLRGY4YkpvVlRSL0NhWGtKbGhiOEIrV1lDV3k5WVph?=
 =?utf-8?B?Y25vTmlMNlZnRXhRbDRJQzN6d0hXVXVTdmx4QTlUUmtJdjdsUWhVSHIvdW9l?=
 =?utf-8?B?cVhGd3hjbEwvK1FEcG9LYTY0YWxwYVYxdEVQaWhMdVgzR0ZRd2p5eUpld0JJ?=
 =?utf-8?B?UGN4UjdHYlQ1NVNiWDNMOXh1RkdtU1BZZ0Q0b2pyYS80WVZBU1djT2JyeS91?=
 =?utf-8?B?dDZVWmticmQ1MW5IYXllaE5TcHZGajNKRmxBSHhVUWU3S3FNcEdYZ05zRFR4?=
 =?utf-8?B?UXJPa1dJZTNWemVMOXMraUdYMVFFMUpxdGk4WFJ2T3dETXBCeEdmTG9vOFFx?=
 =?utf-8?B?MUY0eGlIaDYwWG56SW9xOTdZTlg2QVZqVkMwREJ5dDdraWZ6TGJrQ2dlamtw?=
 =?utf-8?B?WHNTaTV3U1ZCM2xoUURTcnQyTkJkeTh4eDVZMU03M3JoOU8wNHRCbWtUdVVr?=
 =?utf-8?B?clpUMFkvRkdldzgrd1ZDb2FPR21oekN0UG1ZaFJ3T2JQMFIwWGdueUlMRDFp?=
 =?utf-8?B?MWdub2wyMUdnTEdUN05uTWNoQzV0bUlHQnRWNnVqdWlDaE1Wb0ZQVnBJVjJ1?=
 =?utf-8?B?Ync5ZytrdFBYcng0T1JpQjROWmxYVjNBNGcxOHVXRUJ2WGY5bUZTeUtHN0xh?=
 =?utf-8?B?Q04wY3YrdXBaSEZ3RWxyRkh3QWI4dDlNKyswMTNMd0NUV00xZnhLTmM5bWRq?=
 =?utf-8?B?SmFDL25aQlJCZFlESjFrL2pLY2hiSE1lWEgzVXB4ZS8zakRxNmpFMmVBdlJa?=
 =?utf-8?B?UWlETitTWFc0eHA2ZVk5ZjJWbWdYTFV2WnpVNy8yMlpVczBXWUNJOGhDRUpG?=
 =?utf-8?B?R21VRmN2cTJJVWFPVi9DM21INVVoaUxGUnFiZGFIQkw4a0h1WW05NFVaTFBv?=
 =?utf-8?B?Q0FkMlAwWHZGQWdpaWdqVDJvZ0VidWx5aUsxRFBIVThGSWphM3BlTHJ6QzFp?=
 =?utf-8?B?UnpCaTNiRHUzS2ovalZONUdUdTliclF0NEpZM3VwcWc3RHlGMEhrdE5mSHVH?=
 =?utf-8?B?b3BkR0haeXJGWXlYMVVSaFZlQ0doa25QUHNKYXh1b2NkSXlTY1JmY0xFKzMw?=
 =?utf-8?B?cktTT05uYnByREk2dzRNdDdBL3czVHh5alUxYVdLVlhhMzBHNVNWYVlFelFT?=
 =?utf-8?B?cmpTUG5YbWdXNHVRdDR6M2Fldk80MUJGekVSNW9VQy9SYUtEamtuRVVSTkpG?=
 =?utf-8?B?QlVDdXpHVFdtKzJMbGYxVDJGREV2Z05idS92VndNajc2cWxNNzBwRE1SOW9j?=
 =?utf-8?B?VmpkbE9iYTVlYldtOUh5akVtOGh1UmRBdlhINFY4S3JwUUQ5MVVqVms1Y003?=
 =?utf-8?B?My9sY21EYzRnL1JYV0Q5d0ZVNWpKWlJxR05nTnJsSlk2M0tIa2huejFIOGV6?=
 =?utf-8?B?cnY2OGhRVE1WVW1zZWZkSHJJTk5odGFoOXJYMlV6RWkzcjRCZE9WcHBRdW5w?=
 =?utf-8?B?R08yWDVGWVp3KyszR2dQN3ZyaHhIaUlPejgyTEdReGM5U3ZhNnlrL2g1WWtS?=
 =?utf-8?B?TEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hcYKnPKr2D1Fg8LEQICJW+r5WAvR6fXyweSmhqq+2GkvIkMaHeK/VkhBDC3HOkugYpifU1Zcp4zsnwxctsVdIZWyumdnI3DcwiwH8Efv0Ih5MxnF2AquKaICNBqKMMG0dRykzWNZrpsq/o8fc8GyIUsB1K1rM6jTuPWmRkpXonX5h8udcBqF4i+3NEKT8M/hBE9GfWFFnvLFILp29SMI8StwjgadcUM5Tklm/p+U8pW6eQmBISe3MWwaW177gmLpESyC0DJutjSKV0WWxzxIFbF4lbfq9kbB77gpUgieFB2Fto8H7ObMYZAsmHUcl4+jUz4oEcC83GLBpQfVhbgFyM6Cqt23HwWimdHMTLiEfII+8cU5DTHIUWxTktkw9Nu3uetM9Pvp09qqtoi7LqMKDshmZ5NLQBeLYY8J7mzS4I1MiIaY5k6g5Lgvh917QJtmojwJliXb0beLeJIxcH803JkE5O0rBO8C8DSr6cqSDZ653ifUXKrnZIIGoyF1QcgdXIBFCSNiJk4BdgbJb7EybDhXUSZzBjcCgSfAiyk7BqJRDGtyezShxawR+uh0e8WC6w+jI//IEeeULmd5y0Budz10VtdoUttjkn16IHaKo1E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a594a1-cada-412c-8666-08dd4862c78f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 17:05:24.9819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5yrPjjlodcdmwJQwMjlsVPy5wjf5wgrRpjzRGolWcQjAYbCWxTRfNL3jBWn0qoSp0DDc4cfb9RpAiSunbZ1Cgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7913
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-08_06,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502080144
X-Proofpoint-GUID: uZiiPhH9-MZScxQ0JFptwtgDNsmQGBLq
X-Proofpoint-ORIG-GUID: uZiiPhH9-MZScxQ0JFptwtgDNsmQGBLq

On 2/7/25 4:53 PM, Jeff Layton wrote:
> It's a bit strange to call nfsd4_cb_sequence_done() on a callback with no
> CB_SEQUENCE. Lift the handling of restarting a call into a new helper,
> and move the handling of NFSv4.0 into nfsd4_cb_done().
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4callback.c | 53 ++++++++++++++++++++++++++------------------------
>  1 file changed, 28 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index d6e3e8bb2efabadda9f922318880e12e1cb2c23f..a4427e2f6182415755b646dba1a1ef4acddc0709 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -1328,28 +1328,23 @@ static void nfsd4_cb_prepare(struct rpc_task *task, void *calldata)
>  	rpc_call_start(task);
>  }
>  
> -/* Returns true if CB_COMPOUND processing should continue */
> -static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback *cb)
> +static void requeue_callback(struct rpc_task *task, struct nfsd4_callback *cb)

Nit: requeue_callback => nfsd4_requeue_cb().

Once the nfsd41_cb_release_slot() call is gone from this helper, it
can easily be placed just after nfsd4_queue_cb(), which seems like
more legible code organization.

Just small nits this time. v6 ought to be ready for me to pull.



>  {
>  	struct nfs4_client *clp = cb->cb_clp;
> -	struct nfsd4_session *session = clp->cl_cb_session;
> -	bool ret = false;
> -
> -	if (!clp->cl_minorversion) {
> -		/*
> -		 * If the backchannel connection was shut down while this
> -		 * task was queued, we need to resubmit it after setting up
> -		 * a new backchannel connection.
> -		 *
> -		 * Note that if we lost our callback connection permanently
> -		 * the submission code will error out, so we don't need to
> -		 * handle that case here.
> -		 */
> -		if (RPC_SIGNALLED(task))
> -			goto requeue;
>  
> -		return true;
> +	nfsd41_cb_release_slot(cb);
> +	if (!test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
> +		trace_nfsd_cb_restart(clp, cb);
> +		task->tk_status = 0;
> +		cb->cb_need_restart = true;
>  	}
> +}
> +
> +/* Returns true if CB_COMPOUND processing should continue */
> +static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback *cb)
> +{
> +	struct nfsd4_session *session = cb->cb_clp->cl_cb_session;
> +	bool ret = false;
>  
>  	if (cb->cb_held_slot < 0)
>  		goto requeue;
> @@ -1429,12 +1424,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>  			return false;
>  	}
>  requeue:
> -	nfsd41_cb_release_slot(cb);
> -	if (!test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
> -		trace_nfsd_cb_restart(clp, cb);
> -		task->tk_status = 0;
> -		cb->cb_need_restart = true;
> -	}
> +	requeue_callback(task, cb);
>  	return false;
>  }
>  
> @@ -1445,8 +1435,21 @@ static void nfsd4_cb_done(struct rpc_task *task, void *calldata)
>  
>  	trace_nfsd_cb_rpc_done(clp);
>  
> -	if (!nfsd4_cb_sequence_done(task, cb))
> +	if (!clp->cl_minorversion) {
> +		/*
> +		 * If the backchannel connection was shut down while this
> +		 * task was queued, we need to resubmit it after setting up
> +		 * a new backchannel connection.
> +		 *
> +		 * Note that if we lost our callback connection permanently
> +		 * the submission code will error out, so we don't need to
> +		 * handle that case here.
> +		 */
> +		if (RPC_SIGNALLED(task))
> +			requeue_callback(task, cb);
> +	} else if (!nfsd4_cb_sequence_done(task, cb)) {
>  		return;
> +	}
>  
>  	if (cb->cb_status) {
>  		WARN_ONCE(task->tk_status,
> 


-- 
Chuck Lever

