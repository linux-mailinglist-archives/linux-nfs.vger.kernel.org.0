Return-Path: <linux-nfs+bounces-11866-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 820FDAC114D
	for <lists+linux-nfs@lfdr.de>; Thu, 22 May 2025 18:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3022F16C74A
	for <lists+linux-nfs@lfdr.de>; Thu, 22 May 2025 16:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5DF248862;
	Thu, 22 May 2025 16:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mOzgvUJs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="s+Joynms"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B831EA65;
	Thu, 22 May 2025 16:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747932044; cv=fail; b=qnlKR5+6XMsEBWVStNMb+GfskgyUF4WCZOLkbhbVFGtflV0LQUypfek8wB7z7aGUlhEEKLLt02WR8J2kcBYDC6JQiPLnysEzSgn6P8yiR+C5YKsVcOvIKHGkSKSlJL0lD2HzTAbvn3ExE7c8rnJtQv6byBFsdohCFKKt2/Ym0Gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747932044; c=relaxed/simple;
	bh=7+9cpm2XMD7Pw60wG7mBKRqg/nF3h9MFTXuIf4gnowA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MfR21eA9aVn3OFPNwV36YMpguIvZVBsKO873kCPMLvdjJCavzKeSX8wmrEjStKOh9LjGmHMzeXwWCU/6VlHQlno9Fc9/1NdweXqKJSdvpZfCOnvmhaYCp4r8mQIsmOmy8G6KRfuaNA3wtMDUfz++eJhX9ka6RUD0mPWBuvWg3+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mOzgvUJs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=s+Joynms; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54MG6bD2021700;
	Thu, 22 May 2025 16:40:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=SqR8zF+Tv/e9CU3Qa0s5t/71sOF6WNV7/F6Qn2JctKg=; b=
	mOzgvUJs1AQuIdB0eRY14Mvp+ZvOODuXOe9EdIuAc7wV+8BAPlOllGL8EDvciBjw
	Cjibi21vn8pwwqBYXnnZclKcEOJJ1RYqd6Nbbn9I7flEB/+xiiE6/Y0D/05Ctk1Q
	Ihe+8LU7mgoVCFbmHTeyOXxllUuwrFAAW49csURpM+ZqmfAMG6uU3vqTQAL1TjaI
	nOwzexEyYWdBrZvQjnvumr+WgV6XHzSx86/iScI7B6Ih34z3JfxvyuNXAB6ucnaS
	HKRJkM4WCyzng9ztqzfIPI/ELGwYA0/t+n6zYW++css0d/9rIi/tcoq1JN5V/9aL
	IAZBV/d+57O5+ELRaLetvg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46t75b82pk-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 May 2025 16:40:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54MFnQ8c033517;
	Thu, 22 May 2025 16:38:20 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46rwepw92m-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 May 2025 16:38:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aONbWs9R1GkMQOjFYHAspwc0t28EYSi/ulN4u22DwMq+7JdnJiVOkq/kfwiMax0UAovXr7VCsyTCFw0ksRp5LH4YXi/cSmQ4urZppSNDfkeokDBmyj4GMRVp3hXVMAeCsCwPCY/YguAWeDr4AdhAkuC0SVs3LVgAlBpG70ZjO548OI/8f/K6nsIaQ24PO5vM8vXkw68u21ZgqVCB6Kqr7ReDCtJ0v3ZG41MiF6NLaQtQ5sBT+XHhOFGSGQ9U31zB1jp45M9KzRhRfxYefRMWQcDDODx41CT3g4DIjHnbWSanV9/iIFiYkSiuRSlr06v3pdeFWDHN9s12P+YGeq2KLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SqR8zF+Tv/e9CU3Qa0s5t/71sOF6WNV7/F6Qn2JctKg=;
 b=CJJMs1NVINsKGaxQ3gsBjCDZP637wroma4wdLCAO2zlhRgcXF5+FxVkRtdCs5Yth6EjWCrhtEShrBH27ctam94BjaQ3I9IKeHCRGDycwGcRQCLj0p4NhHlDwb+q9XQ/Ad6K+8y7vyxR4rf0h4o8lRe0A6fYsncBd0eDl6FsD6t4qR8J0A6iAQoyOIiuh2Vq4K0kDOdwL6cTIr80s9T9WGpOhiRCk4Dy4Y6JDcOPDsCiyufbndciAoSkcrjNvQAUcxFe5Jc1SuE9Mzj+bmhJ0x2UZU03xQ6eIUaJHgbfo1487wX30gbxdK2QvpHQ5MEGa5waJMJvf1dZRovsHzsbohQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqR8zF+Tv/e9CU3Qa0s5t/71sOF6WNV7/F6Qn2JctKg=;
 b=s+Joynms+wnVANwAtki1VxsNvxobGpuhjAbrzWSXc/TPEVIZq122OUcWx0FtO3kC2gKzrmpeHWAcj9+ADfs4l1QVPihWKIru6hiUz+hZcz/cvWLnAVenFsqUwTqYGf/pUg8ovJmbyIjpEm2oKFdMDR3VleZj1HEmTLcA5FxZ8ws=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH4PR10MB8002.namprd10.prod.outlook.com (2603:10b6:610:23d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Thu, 22 May
 2025 16:38:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8746.031; Thu, 22 May 2025
 16:38:06 +0000
Message-ID: <44b6a9b5-6bd7-48f3-927d-3188cfd726f1@oracle.com>
Date: Thu, 22 May 2025 12:38:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 4/6] socket: Remove kernel socket conversion
 except for net/rds/.
To: Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
        netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        linux-nfs@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
        Steve French <sfrench@samba.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        linux-nvme@lists.infradead.org, Matthieu Baerts <matttbe@kernel.org>,
        MPTCP Linux <mptcp@lists.linux.dev>
References: <20250517035120.55560-1-kuniyu@amazon.com>
 <20250517035120.55560-5-kuniyu@amazon.com>
 <7a965a97-a6d0-462f-b7dd-8833605ea7c9@redhat.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <7a965a97-a6d0-462f-b7dd-8833605ea7c9@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P222CA0012.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::7) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH4PR10MB8002:EE_
X-MS-Office365-Filtering-Correlation-Id: f492d30a-75b7-4a6b-c50b-08dd994f074b
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?VlAwSlZkSVFEZnRUZEM5clcxWTZrN042Zk5nMTl1amVSWkJWbklUNEtxMWFV?=
 =?utf-8?B?dlFkeTZlTGdOb1hPZWRsOFV0VHVkMmx0Z1I1eEVnQ3krMGVlYWJJeVdUd25P?=
 =?utf-8?B?aWZ4SkE4cHc5Wll3dmt0eHdxRzUzQVBONDdSTzlrZWkrOFViUGUzU0NTOS9U?=
 =?utf-8?B?K1dPNjB5RTdFVkxpa0JFVml2dHdwTlFiZXNOVUUxOU85K1Fad0YwcjNzNUJQ?=
 =?utf-8?B?RmZVbjhZQ3ZKc25RQmtlMy9JZGg4Ymd3Tm03bVp0Y1ZYeU5mR2pGYittK04x?=
 =?utf-8?B?R3NuYlRSV05vNWN2SGFjMVNzQmhrMTQ4Tm9BVEQ0eHp4VGgxSmhYWHJ1elg4?=
 =?utf-8?B?TmJvYU9hTmpXZDlwVnkvUkNGaHlFbWJDOFNJMjNUUS9VanZiaDJ5UkFUc3F6?=
 =?utf-8?B?d1dSb21jcmFGV2NuN1Z4OERNYUsxek5iQVg1SXBOakNrUnpXWEoxZTRDZTRB?=
 =?utf-8?B?SVhjMlFjbEJ3MmRSKzU2VW4zTHovSjN0SzQ4ZVJYRiswVkZSMHM4QW5haHRI?=
 =?utf-8?B?ZjRFQVN0MDA4MmRTY2UxRFZENXlTRXBadjZSUUtwc0lmcklTd2l2S0hpUmdS?=
 =?utf-8?B?c0ZjMmJOTE5WZUVzeGxQMGpyUTl4UXFNTDFDR2N3NXJIRHRlTlFub1hPZTNk?=
 =?utf-8?B?QXE3dUNYR21BL2I5Vzdld2V5MUNhTWFJOW9MNFNSYlhjWUp6NzZZaGxuZ3dz?=
 =?utf-8?B?N2JBdit4SlhsU3V6UWJCTE1LK2REZGJPS3orN2pYbjVHRE00M2RZa2NWTnl0?=
 =?utf-8?B?NUZTUy9YeU9LUVFmWXBuRUUxdFFvVmZvbktoSVlFUDBHSHgycU40NXFaZ1dT?=
 =?utf-8?B?c0IxVUF3dy9jMUNYelhndFBIRlEreWYwVGFiQlBOZGJqbGpnN01GaGpyallS?=
 =?utf-8?B?eTlxN2ZvUXZBdDd1WG5oRGZ2MUFIWXpGYkJYeDAzSHpKdER4VXVPckNhOFBu?=
 =?utf-8?B?ZXR5YVRrNTd0NHBqMDlFdUF2U2pDeWZySzZhdndUamlGQmtxSnNmWUhudDBP?=
 =?utf-8?B?ZWZ6MFI0Y2dxaHM1bGxHUk95T21nTDRQZ2ZVSExJamsvL09TbnFybUFQbm9s?=
 =?utf-8?B?azllN3BsZnJReEpvZFJrNlVHYXJKMjZ5Q1hWVVBmeUVjK2pyY0RyVHpwcHNX?=
 =?utf-8?B?cDlvTXVFL1YxcGxHclAxUEVXLzJvRmJqWjNwL2dWRlNYZ1ppSVhVZFFoT0gr?=
 =?utf-8?B?OWFHa0doeE8yd29zYmtyZ2J6UUlQWHJteVNXM0Z5N2hmbUJKSWE0ZFdsTitR?=
 =?utf-8?B?QkpLN2FUVFNCRlhrK213YWZUYjZYZm9Dd1ltRCtFVE9WMUZMbHlmMW04T0NQ?=
 =?utf-8?B?eHJVWXRicEdhVWxsV0VMSjlEOFF6WGRlWlJETFM3QWtWUmdOSlptMThCVGFG?=
 =?utf-8?B?cVFYb1duYk5PUUlwbFhacjAzQzdxdU9WMi9kY3lhNFlBNEp5OXFBSklFRDlF?=
 =?utf-8?B?eGhBM29CWkNNc3QvaDJraytkcHRCNFJlQ3V4d1ZLSWNmYUtGQ0MvSVFBbEha?=
 =?utf-8?B?cjJaSDFPQUd5Zko2cUZqMGd5TDZtZFBmOGhDdjUzT1djRXFwSzBjc1JTL2JX?=
 =?utf-8?B?NjlCQXZud1lFcnd1ZW1SeW1Ed3Uzenc2UXFLVHVkeVdNZ2p2WG16Mnh5MWho?=
 =?utf-8?B?eWRQZWsrQ1dWbUlhZXRBYk1NUGp2TUY0MVcvOXZxaDhlbU4yUUU0akxEVUl1?=
 =?utf-8?B?NUovdkJxMDNxbGFpVlQyMGtGU205ZVFhWWwrNXhsMnoyTkpvWEhxT2xWZURw?=
 =?utf-8?B?cGdpWUdjYWxoSXZodzhaOUJpN0UyaWtKNmNYbTZ2RHFVaGJvRUEyenRHT3Jp?=
 =?utf-8?Q?fXrVhI41tkizmq4+kgBdeihoadidPqnJ0SO4A=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?a3ZObm0rQk9pRXpsNEpoTlJRYWJoL2JuODRRdmVXZXR0S2dhTUhaTHVmRm4x?=
 =?utf-8?B?M2J6OFpMRWJOTm5YSFVjUmZpSUdIVjRqcDhqUE96KzV2WlFtK1ZpTmQ5TlNl?=
 =?utf-8?B?WGpaRi9yaWsycjdCR3JDQzZXRks2bjFMdFdya2dOVWYxbUdDTkh5bTAwZ3BQ?=
 =?utf-8?B?TEZrMHRoZW05dXl3aTVLYTZnTkNwVFhsOGRsc3g4aGNtNXlIZ3BMU25hWTJK?=
 =?utf-8?B?bXV1ODdGR3NMR3UzREhEb09yK1E0R2xkWG1SREdYcGN2ejU0MG1seU5TTkpM?=
 =?utf-8?B?RFVQL2IyTHlmakxIQ0VOTXQxRWVpTExpZjJuamxlOHZ3UkdhalRTYlUwT3hj?=
 =?utf-8?B?WlFIVi9jcE0vUytnR0FjL1NJdHF3TE5kRFlWdE1hSHdvUCtUdjhxaWlrTG1P?=
 =?utf-8?B?R1FmR0ZuSFpNYjEvamdkcVM5MGJyeDJzOFYxbmRaWlN1dkRHYUNrMG9ETEZn?=
 =?utf-8?B?cjFPbjN4Mm8xZzAyQngzajlFejA0WXBMZno0eXFDQ1ZRNi9FVVkvMFZaaUpu?=
 =?utf-8?B?WmpWdDRDT1VaUExFK3kxUks4N1ZKZGpWVytOcHdwREVzZmtRSlVOUTVUZWdp?=
 =?utf-8?B?OWdBN1NBNXlqUFRkVGVXSG9xTElYN2RvM0NoQ3c2UU9adTVKK1hxN0xubGlU?=
 =?utf-8?B?ZTZxNGVoTmlmUW1HaHE2TlZ5a2VmNVBxUDJaR2FFcXJnL3lzNjB5a1hybFhJ?=
 =?utf-8?B?WkwyeUMxS29pc0VqamhYaXdvdW40ZUtITFFMSm9hajBZV2xRZEVsd3dhWXZk?=
 =?utf-8?B?UXJENzhWZ0RPWnhuU0VwelA1QTFqSXJwcXMzTTZWQ3Y2K2M4cy9MNE5ZVHBn?=
 =?utf-8?B?SDFMNG1jVUZmU0V4U0NqS0ZnN285M2FNZmEwMGRGRXdVTUtsT3I2OW1pTFc1?=
 =?utf-8?B?czdVWU9HZ2NrdUNvODVuZ2puNW9CdklYVUtSejhsRzFkZmJ2WnArK1hST1Vj?=
 =?utf-8?B?L0JudVVHWWVKQjk5Mkc1Y0dpUnVZUkxYay9RRklIZkUwU0ZLWkhIVjlKOG5h?=
 =?utf-8?B?a1RWcEhVcDdBSHR4b2thekNKbDJIaVRHWnNzdHF2NUxJYW95dTRRL2NhVlQy?=
 =?utf-8?B?NzZsRzhpcW9hZjVNVWZjTXJPT2QzOEZGVG5SeG9IaVhERDB3SFI1dUs5NFJO?=
 =?utf-8?B?ZFQwTGFsSGh3Ri9xZlBldjV4Mkd2QXpRV3RWUVZmZ2wzdFdtVS95akI0UTg4?=
 =?utf-8?B?aFg0THNoc1pTYXFuZGxjenpUWGR5Sk1BUDJ3a0VSUEExR3hRcThvQWJBMTZV?=
 =?utf-8?B?Tkc5NWlSL2JNWStTNXlVUkpUWjVtNm5Ta1ZkS2tmcXNDVkFmK3J1Z1c2T1hl?=
 =?utf-8?B?QStZY2dGOXErMnZJMlpVQktza0Z6blpJWGs4N2YyTmtQZHNrdmlpWmVXWGd0?=
 =?utf-8?B?azMvUy9nUi9HQ1JFVkc3cVN1L1JDcWlsMEQwU3pzcEhLK2hoNG1yR3JWUy8x?=
 =?utf-8?B?anAveG56bHA5Tkt4N3Z0azEvbTAxd3YvaFdXVzNqYkpRdG1oQTRKVzZZMi8x?=
 =?utf-8?B?VHBuTTNkVm9lWFd0aDVyd2lCUWtsam9kc0paYjQrREU3eFBWcGg0am9ONW80?=
 =?utf-8?B?VjR5Y1NpZDQ5S2cvWkE2M2JtOHFDTWtJVTQyTUVWTUNZWGlPTzRjcTkwQTN3?=
 =?utf-8?B?K2tpbSsrUWtwOHJjcmJRaFJBM0RiM2RUUWN0U2hSZlFOLzJrWmZtUW9hdUhX?=
 =?utf-8?B?d0NINzZQdnJQK096NlJVc2dnNnBKdEpJMjlwd2E1c3puaTJ2azFOcmN0MWs1?=
 =?utf-8?B?VTQ0RUtGeUdudURzZm5BU3NOZGg3SUpWdXc5MVRHTXRjaU50WTRPbGF6VDZC?=
 =?utf-8?B?UlZGMHY4aVczREY2VVMxVjI5L1FxNnJxdHA1dWNPelpnNFpDSk44K0g0S3cz?=
 =?utf-8?B?UWJhd2ZJRS9uN241RytDdzR4bnhHTS9HK2hVLytNQUlPUyt6aFQ2SlJXRU1C?=
 =?utf-8?B?MExRU1lPYUt0TzZBdHVuVHBtWjkzbEJ3NHI0OFRkUzVjWlV1QkV2d041OXpI?=
 =?utf-8?B?aThEVWxUNFJURWsxdmZMWktZNDZSZzZ4TjVJNmtodXJYOTV3bENwNHpMUGRq?=
 =?utf-8?B?QmhYTldhditpblVHMFlNSURaVzFMb2cySFY4bjJXZ041MTZIUGZQUnlGaW5x?=
 =?utf-8?Q?mtLF8K3cbtnbOKUDf7+8w37nb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	E+O/lMBRtsujkC3TY39fqw+lbAvDh+AeAXR9rRx1+l8FYLoeOwW3iTml83NA+9Br0mXL8g/JQZvEdkOS55N6T/5PhY7yX74e49J27tNJZegRgLgfdH5hcFtyoQJEoxCazlNqqzSW62wpcbxarfiDTdGX1aSP5lI+ZvUUPqDD2iR5fxzV75xDLLdYk+z9CR2TPCK4DqBSxE7CvgsQ38ReB87Cwv0illa5L6LBJPl+2Jm7zyciw4t6jrQZfujK5K8V1LGCzifkr3Ee2QpbbDKvZXLkLc5qOu38dYY/RGKUWycr4mtBRvtOmyRvozHPx5xrTfep+sUWgyKr9G4AiOKJu6OuG9/WHd099TEotlyHTmgEBzyArgnRXI/0bzjtKZ28Sbqxuo7BxTCfTaF/gu9NOa0rtNNj1J4qNBBEOA5LH9fBJ2w8p7yu7WJwi+nySgqPnyiBPlbfcOBc1iV8JIxsMzTejwb34AYN41bj4PSX8/IYSJg+AFCBQWDbuPHBBPaAh2AvWvSQ2fmGBAyW0q40fKhhkIAIXycIheLU/HRAc2NORSd1MGxCVFmglfeTLlB/CVxWEjostd1Dqc9G6c7FQu0zgkfSicRJDZYuID19B8A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f492d30a-75b7-4a6b-c50b-08dd994f074b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 16:38:06.2031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DwZu78ptiEnTi1irKgM0RjKjAK/kczfZfjLooxXF9IlHuPLsmvcHEoKiYj9mEebeWue1PPGzftHux/JLliFysw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8002
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_08,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505220169
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDE2OSBTYWx0ZWRfX82YWYQzwVA9v HQ2cvN+9E5Ifse52e3XasO9/qeN3HBe/uKR2V536EOsnbvcAfYT/PxBL4Zcpj3xeMHREY06bhoV 8GKar89IInK2rcOHr0IqaycLivtwQJy6B9a0bnt7hzAWLcKbfwyToYppqcBMbxjk40BqGh/wtmx
 BW3xOne8JLtik/Hb5R9TcqYFXrTkytnnL3pbP/mWvQAUVzV66D4TCpzSFlS0A5CltumURm+SpUj prvq6LeBVfauXu2gS+JvG5L7KEW4YISG9NNs3wU+gIkfd7t6d8cvapifG/nNpd9nOl3o87RL2Vr GgbtGKh29ptQQmYBAq5mG+hN4+XtjZIz5gW1LWiSbCnZjybf9o+gpOs+6h7YJ3b4zZxEHgrrON6
 OBTypRdZdB6pv5RHS66fYAWIl8qVg2hQ5Yq29zeB/MrmZ0rGhe9qNKSEj1VK1sgRZVS0xbPI
X-Authority-Analysis: v=2.4 cv=R9EDGcRX c=1 sm=1 tr=0 ts=682f536e b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=vggBfdFIAAAA:8 a=yPCof4ZbAAAA:8 a=FPj7ARrtyABlTZiU1jgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 2fmEcKg12ppIF5qUCTqr37Nh_dgGI7pE
X-Proofpoint-ORIG-GUID: 2fmEcKg12ppIF5qUCTqr37Nh_dgGI7pE

On 5/22/25 4:55 AM, Paolo Abeni wrote:
> On 5/17/25 5:50 AM, Kuniyuki Iwashima wrote:
>> Since commit 26abe14379f8 ("net: Modify sk_alloc to not reference
>> count the netns of kernel sockets."), TCP kernel socket has caused
>> many UAF.
>>
>> We have converted such sockets to hold netns refcnt, and we have
>> the same pattern in cifs, mptcp, nvme, rds, smc, and sunrpc.
>>
>>   __sock_create_kern(..., &sock);
>>   sk_net_refcnt_upgrade(sock->sk);
>>
>> Let's drop the conversion and use sock_create_kern() instead.
>>
>> The changes for cifs, mptcp, nvme, and smc are straightforward.
>>
>> For sunrpc, we call sock_create_net() for IPPROTO_TCP only and still
>> call __sock_create_kern() for others.
>>
>> For rds, we cannot drop sk_net_refcnt_upgrade() for accept()ed
>> sockets.
>>
>> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> 
> This LGTM, but is touching a few other subsystems, it would be great to
> collect acks from the relevant maintainers: I'm adding a few CCs.
> 
> Direct link to the series:
> 
> https://lore.kernel.org/all/20250517035120.55560-1-kuniyu@amazon.com/#t

Thank you, Paolo, for forwarding this series.

For all hunks modifying net/sunrpc/svcsock.c and
net/handshake/handshake-test.c:

  Acked-by: Chuck Lever <chuck.lever@oracle.com>

Regarding patch 4/6:

This paragraph in the patch description needs to explain /why/ sunrpc
is an exception:

> For sunrpc, we call sock_create_net() for IPPROTO_TCP only and still
> call __sock_create_kern() for others.

The below hunk doesn't seem related to the marquee purpose of this
series. Should it be a separate patch with its own rationale?

@@ -1541,8 +1544,8 @@ static struct svc_xprt *svc_create_socket(struct
svc_serv *serv,
 	newlen = error;

 	if (protocol == IPPROTO_TCP) {
-		sk_net_refcnt_upgrade(sock->sk);
-		if ((error = kernel_listen(sock, 64)) < 0)
+		error = kernel_listen(sock, 64);
+		if (error < 0)
 			goto bummer;
 	}


>> diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
>> index 37a2ba38f10e..c7b4f5a7cca1 100644
>> --- a/fs/smb/client/connect.c
>> +++ b/fs/smb/client/connect.c
>> @@ -3348,21 +3348,14 @@ generic_ip_connect(struct TCP_Server_Info *server)
>>  		socket = server->ssocket;
>>  	} else {
>>  		struct net *net = cifs_net_ns(server);
>> -		struct sock *sk;
>>  
>> -		rc = __sock_create_kern(net, sfamily, SOCK_STREAM,
>> -					IPPROTO_TCP, &server->ssocket);
>> +		rc = sock_create_kern(net, sfamily, SOCK_STREAM,
>> +				      IPPROTO_TCP, &server->ssocket);
>>  		if (rc < 0) {
>>  			cifs_server_dbg(VFS, "Error %d creating socket\n", rc);
>>  			return rc;
>>  		}
>>  
>> -		sk = server->ssocket->sk;
>> -		__netns_tracker_free(net, &sk->ns_tracker, false);
>> -		sk->sk_net_refcnt = 1;
>> -		get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
>> -		sock_inuse_add(net, 1);
> 
> AFAICS the above implicitly adds a missing net_passive_dec(net), which
> in turns looks like a separate bugfix. What about adding a separate
> patch introducing that line? Could be in the same series to simplify the
> processing.
> 
> Thanks,
> 
> Paolo
> 


-- 
Chuck Lever

