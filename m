Return-Path: <linux-nfs+bounces-9766-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D970DA225E3
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 22:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099BB18863D1
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 21:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C58A1E0DCC;
	Wed, 29 Jan 2025 21:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ntHoWgBM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ajye1jx0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC0E22619
	for <linux-nfs@vger.kernel.org>; Wed, 29 Jan 2025 21:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738186761; cv=fail; b=TYSwdtZKLVwA0VhhLPb7YXEAs9aKAFkAhttC1C4Uy9Ow1yT6kDpUQ2ov1Sa5aHkLh9TLiUyRjTET7t8ENgsRR01hfffUKmkbHrS2pshOL3KY214wZ78HJuNLPRNjC75SaJdLjwk9lGDUkcs3m2TkJSmD5KGigw2u+d4weru74+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738186761; c=relaxed/simple;
	bh=pg//T06M8VjZ/FhfyKceD/Amen2d+6rLQe3PGSSijmc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kTUg7mP6C+aTNw8+8RD+mCf4NjlEQI9SOBWcl59N92sqFa9PEtulf0dxax2p8XhLlEnTmzQOUcINqX4/skBus8O+UBYVbdkiJTR+Mn6hfGN5+dQUWt+EqTa3zpM7m2D1suIb2JmRJB/9SwUlkwYqrQEvxkr+oWIC4Q3Rh4Ng7O8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ntHoWgBM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ajye1jx0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TLCD4E010237;
	Wed, 29 Jan 2025 21:39:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=FvhR41B0CNcnHQmGoEnpirEc85cn91fqxl3/rzYazuQ=; b=
	ntHoWgBMiiLiogaMWlxRpqHK+mJAb6aqrnIBtM6nxR+JecEDUWVWAfTWw3taTvJi
	NWI8MdFmsy6fpbmbRnAFlWL0TO86kGx6OVULSzNVgP+dPf+4J0T7f0LJ2z6ohHwL
	X+FhV9vLjHi9rXYoyJfHCu4AUqswnyMQkNOqFCwxN1y91nuUPt4zgVOsMY2Orkzy
	aqcIW5i4X5cdcCf901BKyEIZLa/5P/omv0mKp4IdpTuCmnQv3dSWrT5vdSjcQIj7
	TmoIWVtY2IR6TwamXNpMhBBgH8TMcuoqNcqKndMZP/VFkifDD4DqNzeUWj77ZW8f
	ts5ILNB23BgzbMJXr9xBOw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44ftmy8gxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 21:39:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50TK5O40005363;
	Wed, 29 Jan 2025 21:39:12 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44cpdadrf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 21:39:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MmK6x31hi5mzeKIWWhAzkH/J50UFs3uftxQM9Ho3kofQGEJ9TN9lj0Mz2hV5vg3I8cnExdCYXLjJtKIPZX683sg+nFqT+Ys6s3knVzk5f1F8uXiu+Cqhc6UQ8lDzs3jKxW7a5BKbiq7OkCINhV4RT4aUW1BTxWOemYSxnBJk5jSVR9WfcJS5hKNk5MAqERvkvtwnXTY16PwykPb2VpMJ9UxaUrNWBQ3h/l4wmwCRaTcVn34dMbRIodhhm4IBjq9NawEzuQydfYHIs+AtYsDChklpf0C1OfnhpT0gSsWfYApv7YMPvXFUGb0vL44XYUNBgQKZSxQ0LFxtyYaWAJj9dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvhR41B0CNcnHQmGoEnpirEc85cn91fqxl3/rzYazuQ=;
 b=K9rVtgvT/K73wvur1Q/rVDqYgjaRqrAmjUJVd+nhe9V4bABqyFaAwmKavjYc5zuIY1SASV9lns0L/BzTqnORD196b64v74dT4bgFoH32edd+GxpMAAA2QoDh0TYWicCK+XCcvuj63I0gxL28KVkieZb6iu+tv/jpiY+0g2ICIy5fJOoTZKSk0oBcfSiOTRdFA7YYlU8UE5GJgw1kgQ2JwgBSyfpwNWtMmTOuh7AKUAjsY1CykA+j+XZfawbq/3nu3rJgGFl9BFPe+p4vb7/waWo9pHL+34e5JfoqaR8toLVs+3dM1nNGdIFhatySxRcwz9NESt5f9/5hw1bT1vdXwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvhR41B0CNcnHQmGoEnpirEc85cn91fqxl3/rzYazuQ=;
 b=ajye1jx06v+R/sdJiGLuKG/cghmbnk4tOp2DZqtfGbroFutlesjlIOwtFs5FVizbdmPIuSFCcBV8CfXP3p8qytaVAT4r1lgGxkFeVOeXQlwudjuy0ITWWI+FiYfKrmKkHQjegXiK41GU5Nafdztmp6vTbFS2Q/G/ANOfX+wex3E=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6393.namprd10.prod.outlook.com (2603:10b6:303:1ec::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Wed, 29 Jan
 2025 21:39:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8398.017; Wed, 29 Jan 2025
 21:39:09 +0000
Message-ID: <69cab2b4-ca79-44ab-b622-0f2076eaf524@oracle.com>
Date: Wed, 29 Jan 2025 16:39:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSD: fix hang in nfsd4_shutdown_callback
To: Dai Ngo <dai.ngo@oracle.com>, jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org
References: <1738185446-7488-1-git-send-email-dai.ngo@oracle.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <1738185446-7488-1-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR15CA0015.namprd15.prod.outlook.com
 (2603:10b6:610:51::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW4PR10MB6393:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b83682b-a03e-4e6c-9676-08dd40ad5d19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEs1V05ZRVZ2Vi9jMkgwUTJnNjFuNmEzMzBqNzF2MVlrbnF0VCtOSjZ3ZUF6?=
 =?utf-8?B?Z3hnVnZYeEl0T1pUUmF1b1hMT2tLaXVueUhIMm1hRGxaM3lWYnR6YXRXYVR0?=
 =?utf-8?B?WEs2VE00aWFCUTdwVEc1MStzTlFMWFdjYTRBd1F3a29nVDlRR3E0c0Z5Zytx?=
 =?utf-8?B?UXZ6K20xNmExdnQ2RHptck1rTmVGdTA2dmZWaW1oL0xad2ZMNVhEcW5tTFlo?=
 =?utf-8?B?bnppcE1KVmJ2R1FTeGE1L1FsT3hFUkV1Z1kxTkJhdFY0QXRmdXZ4NGIvT0JW?=
 =?utf-8?B?aW1hK0VlU1dYUHNWZUJtcDEySWpiL0ZXV1h0eE42MllSTFRGZTltbHdJMDds?=
 =?utf-8?B?WWtwOGZaTEUzeS9FTGFNZk5EQ3luOXU3VUpIM0VmTVc2b1VzSjhxT0tqNHV3?=
 =?utf-8?B?VVQwd1djSVJYcG1EVmVQb0pXVW04bWhhUnFXeHFGNlBDd1lnT0cxTjUyak1P?=
 =?utf-8?B?RGd3NXQ0ZWNDVXg3VGlRamxkSlBOTzU5cmRIRlVhWUIxdi8wRXZxRkFxQ0VZ?=
 =?utf-8?B?WENJV2ErV0FiWTBBTWordXlscllzMHZRci90ZUY1K2ZVNmdGNEdXOCtZdEFW?=
 =?utf-8?B?L1lUNmRodVpjU0RvZHo4c3ROTVdtdUlWUGNiYkxBS3hpZFB3elJBL084Y2lM?=
 =?utf-8?B?Q3J0ZVFPOXZwSGRGdVp1RkQrMnJ3RkY4R1VSYUhBVkYrc2RNb0FROEdXUmx5?=
 =?utf-8?B?S3FnZ0Rrd2d1OFp6MEw3TTEvaGw4YzJuSEwvcWlSQkZIYzFlbGZzcmZ6SXJZ?=
 =?utf-8?B?WHlqaGtMRGk5b3JsbGxPNE1jUkJqSUFFZE9GWVJkS3lPSzdJL0crTUt6cjF0?=
 =?utf-8?B?dk0vVVZUbTVBVlhiTjNXNWFhUUVHMmcwQThmTWFlQjBKSHh5SURNQmJJb2hz?=
 =?utf-8?B?VURGakJqNlhTL3hRait6M0V6ZDlVeUcxdGxLR3ZjNEFBQ3BDQVgyVUR5UFZr?=
 =?utf-8?B?T2FBYk9qNnkwaHBMdG9KRVQzTmMzVGFNaXk0WEk0QmdwazYyeVAyaUNuUnlV?=
 =?utf-8?B?ZzJDK0wzWXFNNmJCdVFTWFhkRWo2eU9xcUdxUHlRcFRzSW5KWWVOUmtybC9r?=
 =?utf-8?B?N2VEcGRUbkVYSlc1SkcydmhRejIyczlBUGZYOUNndkpyTXVyQ3FaNndURUsw?=
 =?utf-8?B?VzRMS1ZGTW5FMGxPMEJzd0RuNktRdDdoOUJ3bW1ZRmkxa0ErbDBQNzlnOWt3?=
 =?utf-8?B?eCtwckJIUTdRdk84RUozS05kWlBkeUc2aEF3blZ3Slp4RjlsaUxaczR6RFdB?=
 =?utf-8?B?QzFuYTZ1bFArNU5xdHY0VUhkbUtnUXlOZ0JkRThKZ3JlTXdlbnN2TndlTnd5?=
 =?utf-8?B?dXlsV0w0RWNNa0hmK09qeFBLOUdlUHEwSjJkbDlwQVFpV0VZc2ZNVUFaRjFI?=
 =?utf-8?B?K09GYmtpdWhwamY3VlFvY1hIanpic0JHRk1QNnZkNUFibjZpMXZKRFpNZ1dz?=
 =?utf-8?B?MVJkMmVjak5kWFVLL1dSd3Vqck5NcVRkaHBKcHJMNUZSb2NBMGFoTEdiNjFn?=
 =?utf-8?B?b2dVMkNEaUg1M3hYWG1kZzRIelVubFQ5M0ZuNWpaQWNaZy9hWHpkNHhoNk9q?=
 =?utf-8?B?N3NKSEhISlRScVVYa1BOYWtNanFCMDd1a3NyMDJqTUFDUHA3dkliN2x4S0pG?=
 =?utf-8?B?eXAzdTJhcjcyZG85aHJTWWtiRW5LdFpwby94N2tXY2VCeUJ2RmcrSGYxNXhS?=
 =?utf-8?B?RVdjWVV0U1NIWWEwOUd4c05aVnBnQWR5WVZrYXJKU1RrUU01NGhPTG5VcmhJ?=
 =?utf-8?B?aFNhZENaTGtSMFNsZDhHMHlrYWlWV1hQYnFSV1NHTmdEQ1lOb2dVQmkyOFdt?=
 =?utf-8?B?c2FvZUdmK1dPL3VxdnZsNkNtMUI1aVprVHNDV2h6N0M1d2NDK3dYSE5Ldnlv?=
 =?utf-8?Q?w4zaCI9wTuA4u?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVRuWm84WUpGUWlkTjlTaFplaEJjbVJ6ZEpDK0FBYkFxbDJXNElKdnA1NzR2?=
 =?utf-8?B?TFFtZjIxenNrUjFyQnZuMXdvQzdIU1lBWEd4QkRiamh3Q09xT2lIYlVnZUhF?=
 =?utf-8?B?b3dHQkFqdnY2cHNRT0wzZ0RxdTdoenFjQS9XSFJCMEJCVW5oTStlSGZRbjI4?=
 =?utf-8?B?aHN2c0R5VEpvQm9LejhsSVlITm9QR2ErZ1lveUpzYzh5QjIyK0xUN2VhVnY2?=
 =?utf-8?B?MXdlM0M5NGFEbkx6bUlESDFvVDdJVVh6Umk0alFneGFhY0xSK2dxeWovYkp3?=
 =?utf-8?B?U2pkeW5tb0phVUNueVhoaGp6bk43MGhYRUwySHY5dzJNMGREQyszWnJ5L1lh?=
 =?utf-8?B?WHhtOXdudXhibkVNTG5kc2lZK0NOcmgxUXhmTi9meWFqNmp4NTQraXNTRy9o?=
 =?utf-8?B?RkdkYXc1NTloUE9wQVBYdmYyTDFMMmJtMXB1OGx6U3BzbWkyMjNGY2tKd20w?=
 =?utf-8?B?c1doS2RDdGNGbGVCRCs4Q1A4Um9vR3NiS0pKNFk1MWtWY1I4Y1ByU1dkWE5h?=
 =?utf-8?B?NWgyNmN6b3B1Wjk3NE1HazIxVEtkaUZFTWVWUnJxZnF0TXFhdlBHbUQvb1Nn?=
 =?utf-8?B?aWMvRWt4UWxXTVlYaENNTDNxeHFIUXVlb3RVUHIwK21qTm5QNklmeVVnRkRX?=
 =?utf-8?B?OGdsL0w0aDdQR3NRekMzTmppYkREOE9wdHJWRWVoMTRxUkhJQ0kxaXdYS0Ny?=
 =?utf-8?B?RHVKT0NpMzVyZU03VGZuNisrUnBNbHZCbm5YdllrK1pyb0hXYm9YLzVETFZp?=
 =?utf-8?B?VUtLbHJOWXNsM0twVTdTTnUraTVxMEd4ckFrTFBjVjhyanV1WGs4OWVqSCtR?=
 =?utf-8?B?M3RYS1NPVDdyS3ZHQlhucmc0OWpZanNBKytQZWV6a3hOWURZSk5PZ1VTR0ty?=
 =?utf-8?B?UzJvUkRyc3JoTk1lU2IvQmNOS2RNTHJUNWh5Z1c3NktwcVBON0VXVnQ3ZkYw?=
 =?utf-8?B?WGYzZVN4M3FPRVk4Y3hSQVcwZ2wxK1FXRTdiS0xyNjBrVmlRWUNJVzVTQUpM?=
 =?utf-8?B?Q3UxQ0dndE54QVZIL2REUWl6WnVKbzE1Um53VWRpZ2lQMmFpK3JNdHhvYnpa?=
 =?utf-8?B?Yk5IYmU0Z0xPaFZyVFhwMjFhY2N4bk1Fc0piejhadmp2SnRRWVB5eWNiMlRX?=
 =?utf-8?B?bHNwOFlva09wV0p3emQ4K3lNTEVaRnlhakc4UWtNaW5JU3VqRCtTdGJrdmE1?=
 =?utf-8?B?ZTV5RC9pMDdZK0VobGRYT2Z4WmtFVXR4YjNkNnVUK0ladklIcDIzYWk4Uk1O?=
 =?utf-8?B?M25GMmhtNHFyN0tCRDBlQ3RydFdnQjFpOFdhank1UHhXOGpnenN6b0h2aTRr?=
 =?utf-8?B?dENRQlo0RFBMNmJsUElWVWlNcXRuRjdTbThzV0gzSVVobDlqai9EUTM1Vjg2?=
 =?utf-8?B?NTRJb0xDL3l1SDk0cEloei82NFNkeWJaRHBQMHlXZUtlb01rOXhGVTYrTXVN?=
 =?utf-8?B?TFFkc280eDFtYStadEFURnlIbENkSkU4TmJ3bkoyZG51Mmh0YjhQTVR6dmJO?=
 =?utf-8?B?VkJrOGlsano1WHdCZExlQUcvVEt2dmc1U1k2bFFCTUFqQ3FwVVF5QnFqSXo2?=
 =?utf-8?B?N1dKMGRxTEp3UUcyT1dYY3VPaFhUWkZMRWpNQkFkUXlESjNKYXdlOWY0Vlpa?=
 =?utf-8?B?em0yOENuUlMzM2J5bXhqWG5XRVVqeFpNaDhEQ2JkaTdVczNTck16ZmVtMGFk?=
 =?utf-8?B?UlYzUk5TSVdqTnV3Q0hDTmt5OVJmUjJ3QzBaTFBsOWJrN2IvVWwyTDJmNHFr?=
 =?utf-8?B?aDNaT2RvL293M05GT3BmVGVycHU1VjVOUk5EWURhWHIrVTBIYUs4V1UzVXVH?=
 =?utf-8?B?aXl6YVlCVUdMYlhvZERodHBHMU9MbHNmMThxdTNTdU5HajlSL0g2S3lpdU1C?=
 =?utf-8?B?V3JvMFpvS3FFT3MzYkUyVlpJbDlVcngzajVyZjEvcS93dVI1NEJ4Ukl0dTN2?=
 =?utf-8?B?ck83NFN4WXRHWDFSUWkvdStPZUh5SmJsTGNjY3oxb3V0ZjlNMmFmSDJsZDdZ?=
 =?utf-8?B?aHVGOUNEQnNoMGVUWFpoYzhBSTNERzRsTEtVOUFYUnpsV1Y4R0I5K0JzR0Yr?=
 =?utf-8?B?SnRtTTlraVB6QkFTMjhtdmJTNU5kU0FCc2kwdm12bC9Ud0RwUTZNd2xPaU1H?=
 =?utf-8?B?djdTdVIyZjdSSHZ3emttbHQ3ajV5ODZUZno5MjYxdGxrTVdmOEdyZTl2QU5W?=
 =?utf-8?B?bXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	chASyDxUpecL+SQO4hYCOR5gf+2SND9RUcTq7YtKh/TkXZGxO5s6tXFdqYJ7b2Erhxs2nzNcgNBsUhFRJ1GayDBissPMTf14Kegc49ucfTAOJD4ft2IBM0lGnKAdbO+OpMncefCrZImgaKPeMERGMh1G+BxIeahYkWh23p0zGsSivyAwNJMUWPg1BmjF3DbyOgeHRnV7h7XvRX05fs8JrqYhvgH4hCmycLcAUAtWkmBzt7LilFPBfJ2UKnkBDUy3jwvEm3ik55yL2VRCiNhnsuorc0qWUrYlDBhoaMsL+rnYIkgXyJN7DdaotUKfZyBzf820UoykUdafHdR6/J1CoYePoOajFg6t6AKFsG2GMz99ohBXFs5FOcLkg0wr9XUvQkghWw4X7az6Z1+e2Dr0GArQwT3TRu4sY1SZS56y5ubDNqgzPkxhrwmw7UmFkpxKARGerUOq7BkNyZ4lQfbvE7XQJ5g/aCVQprWt4F1NzmHgtahOXMZ+pBjvuOOQwu3FO4r5eSPFYc84dyAr3SoMfFufmLpE8Y+bf0Cf+JOXLEV0E0UnvEyHSZ1Hp9X0Xw11UxdENbK+L0pJJ6oR550eLxSQbUHOZjSID4wq5rBg9Mo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b83682b-a03e-4e6c-9676-08dd40ad5d19
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 21:39:09.3194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dlgKg3zDi4WFr1iy4irkNkzIfZUu4YtGaLUCh1XZ3kOdukv3/YfDU7sHd5L0NLK0KoMbxOiD1skfVu4eL09oKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6393
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_04,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501290165
X-Proofpoint-ORIG-GUID: 3zYcrdKv3D58jKAfHHKqw38dNV2VZVe8
X-Proofpoint-GUID: 3zYcrdKv3D58jKAfHHKqw38dNV2VZVe8

On 1/29/25 4:17 PM, Dai Ngo wrote:
> If nfs4_client is in COURTESY state then there is no point to retry
> the callback. This causes nfsd4_shutdown_callback to hang since
> cl_cb_inflight is not 0. This hang lasts about 15 minutes until TCP
> notifies NFSD that the connection was closed.
> 
> This patch modifies nfsd4_cb_sequence_done to skip the restart the
> RPC if nfs4_client is in  COURTESY state.
> 
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4callback.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index 50e468bdb8d4..c90f94898cc5 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -1372,6 +1372,11 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>  		ret = false;
>  		break;
>  	case 1:
> +		if (clp->cl_state == NFSD4_COURTESY) {
> +			nfsd4_mark_cb_fault(cb->cb_clp);
> +			ret = false;
> +			break;
> +		}

We could do toss this operation here or at the top of
nfsd4_run_cb_work().


>  		/*
>  		 * cb_seq_status remains 1 if an RPC Reply was never
>  		 * received. NFSD can't know if the client processed


-- 
Chuck Lever

