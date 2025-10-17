Return-Path: <linux-nfs+bounces-15340-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C752BE93B3
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Oct 2025 16:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A26B418906A7
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Oct 2025 14:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E7832C922;
	Fri, 17 Oct 2025 14:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fz/0kM/e";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iRnfJQMI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6081146585;
	Fri, 17 Oct 2025 14:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760711859; cv=fail; b=cz4TyBdb0h5Lmh9M60z8ybL473BSxTkFDTJeOni/5QfQyFmGyMEnF3EQmRVoVNMS0f177MfxtZWAM212dnXRELlHXWcCYLpxVtdx9C7r4taDMbocHVuw9kHaXOHFdD95hH2xxPiHy3hZfRgmtbBp/jT1t6rbUc5IQl2WxhlsdOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760711859; c=relaxed/simple;
	bh=JyBt8x6EaBT8+L7Uh/Ro26m3M6vu2IXjtXF4ENHXSPM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V+ePOi7B2Jl3gKq9pWJyWMPQE2Iths6g5fHNmeuGyw8rvhL5a5hro6lXM2yw3YO/inyS9blbM+2hvGcs7oGQBvKyPL5AaGNoSt58tbeaIIBklwSv1r/nz+VSXqFi+7RE2146b2JOGYKTQlrYhpzQG0UiLm0pn/PgqM9uUF7rUqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Fz/0kM/e; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iRnfJQMI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HCdZg5021057;
	Fri, 17 Oct 2025 14:37:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=4xUMURq6ytvDtd6kMe/tydKICMIy3CO71UdTMNPcsBA=; b=
	Fz/0kM/eNwzMmXz7C7fHLDz9f/xCUXFtX1CycTL7ZNrFCwMudtlTpUqusQ0OxN49
	vfIyrPM2GiqGSJ15vNMrC3zYfbw19KDqk7ZKwhDhpKYCuha/UeOtZep5vHy53ckj
	gyU4vda6u76CJIbNijGoz62c1PCAJQCscJ7wFGUqkuZvIfjNRjObIoC9xrPU2BBy
	gTiYxkOS9ibGQbol441qoUlXSfZU8Nujr6/KUiEDK48V8PsKF3zzPyUG9yFUnYXi
	2ZndiV+ZBom2FuXBjvqHACTkfOulCsQSzphni1qy8aW7O8DvIAgt4V3kP4P6UtVl
	r7qgxozNxc+KdhHdtlb+tg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49ra1qj5j8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 14:37:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59HE4DlB002300;
	Fri, 17 Oct 2025 14:37:10 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010029.outbound.protection.outlook.com [52.101.85.29])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpk5jkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 14:37:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C35Ed6nkR76E0dGZspcTbG1yPrRhTeQowC+yHoAHBl6MN+uxw/EP1C/+0AsQV9fTiR1fbtrYdiKtEjtOjQGCYPKQfrw/16hhdCB77wvo9M1rQO5S/cnG5F6wYdErQg5eyOtTF8yOERfHJGlm5H1kAhLjctt9wnd88mwbKnJ8NnD1GEURLd1j91BM7fQpjReA1OX1c8vEOhYqLjMXyxTMr0HR8VpiNtX1Vi6Gtdmbvy0pnFxoMMZl3s6kUATz75fVml686mvBACKnvbKKGWSWXfbcSdkcWTf0VbiOmhzlipL7dvV074qfKOs0crYfncwLrTSCDO+54DL836kQSV1z+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xUMURq6ytvDtd6kMe/tydKICMIy3CO71UdTMNPcsBA=;
 b=LOvG+4Cp7Q+y5Wdwec17+YfXqFKd8bzCkGQbO/zDHNYx2B2nVNOtdR9862eItRVydz/uIJ/71GEPM8bCvRExaOuxIetO+Jg9cWN0AQKrfJAaxlpbx0MQF0NoZdwe6VArBUk2fSXPSanYOyOA+/wfSq1ooIxLC9FVfhs61iqXnXwV3HwpWBt91Vd0awEDaW3fBgC/XWTxI321xUtznnao56LAGSHLHSuZ7XaCX1XhFA+Z/gBzxOnaXqTqw1xBEJKTJIpeyXytI4sXx3NG6ZXd7158l0hh7G6J4uVArGNryFHyYqwPr4FQhrJt59zNgPuZSmGk18V5bqtzRBNKCYxFGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xUMURq6ytvDtd6kMe/tydKICMIy3CO71UdTMNPcsBA=;
 b=iRnfJQMIk2xG9JwinlRnYbtJZdhoElGmfFcCHFzS/j5dtld91RBrZcnoEn6YatymNaTmyd87sQfP+KL2s0yQYijVaITWYx1Ge8hvi8em3P5NLIdEQdI5SlvGdU7Cxyi5+I3Qy19J8boPE6QwLEjV6g10dn5wxIZQcmhFz+QhNVk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4437.namprd10.prod.outlook.com (2603:10b6:510:3a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 14:37:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 14:37:07 +0000
Message-ID: <4fed724a-440f-46c2-be39-21b21fb3b622@oracle.com>
Date: Fri, 17 Oct 2025 10:37:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] net/handshake: Store the key serial number on
 completion
To: alistair23@gmail.com, hare@kernel.org,
        kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        kch@nvidia.com, hare@suse.de,
        Alistair Francis <alistair.francis@wdc.com>
References: <20251017042312.1271322-1-alistair.francis@wdc.com>
 <20251017042312.1271322-2-alistair.francis@wdc.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251017042312.1271322-2-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0041.namprd14.prod.outlook.com
 (2603:10b6:610:56::21) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB4437:EE_
X-MS-Office365-Filtering-Correlation-Id: b57acc75-ac40-446a-de8f-08de0d8aa5a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0MzcVFvb2dBNlBCU251OFRnRTh3WHpLK3dicHRpVDM2VHYxbFFSdGtCWEZJ?=
 =?utf-8?B?MTVhc2NRU3ZyK2FlaXIxcUI4ZWVGSVRlWm1BOTZ2WmJEdS81YzJEYnZRYUJU?=
 =?utf-8?B?dHFaSkdnRnBScFJIVFd2cktxOTBEUVdiR2RQK2hYRVZva2ZRR0VrWEZHaE5G?=
 =?utf-8?B?bEdxMGlhNW54eGVIVG80aWdZZ21kT3p0bVEyTllYM3FnSmNmWXRHNncyTGJN?=
 =?utf-8?B?WC90UlBMM2FmbjVyRHJOU3VPRHBxL21HSXJNbHdqbW01ZGozVlNRZ0k3NnFM?=
 =?utf-8?B?NzZKbDdGY1Y3bDFTSGQxaW8vN3l1bmNabUlXZlRYUzUyNVNUL1MyNEFQNjZl?=
 =?utf-8?B?Rk15aGxKRVRibFZlTWVJRm1GVWxLeFZNS2sxbVhPVW0xbnBNa1A0ZWdTYUZZ?=
 =?utf-8?B?d3I0REhSNGY2R2tsMXFVakhraGpMd2FhTitRRFB3Y1l6RGprQWNRa3FiUGRV?=
 =?utf-8?B?RzNjQzdQK0NqV0VJSnAyMlZKYmNibE1JUjJ1RWJoOXRlc2NQM1JCY3ByU0xj?=
 =?utf-8?B?VXhtV1FHZys3OFA3dUxZQ0syRnBuM1hWZDE0NDlMS0ZLTnkwWnpicHhPcHRB?=
 =?utf-8?B?Rnd2WlcxNDNKUFVySVYrK3JHWEtVa3VRWlN4WTlLUFhrcnBVY2JkalJvclU4?=
 =?utf-8?B?L1FFNGJ5cWtmZzUrdnQrQVN4Y0ZTQXRUSG1DTXNWSVRweVNrSVh3RnFXUFJU?=
 =?utf-8?B?YkplSWhUb3N1VzRvVzVSZzRjWk1rMlZyKzFsV1doQ2hKY3NRRGpJZzdtcHJN?=
 =?utf-8?B?VzVNY2dXQnJ4ZjJyM2xWbTdQeGd0RnhyQWhudTZjd0lXOS9Id0RveUVtbjhv?=
 =?utf-8?B?UUZCemo4dUZhRk1HZ1ovaVdiSjJrL0FuODVLYnZMb2I4LzlOalNsc3JtbjNQ?=
 =?utf-8?B?Tmh6S1d1QXltM1BhTEYxMDJpeXVWT0NDbFNNQTFaRTZTcWYxSGhwNjlsVzZH?=
 =?utf-8?B?YmtSWlJWSFhxZnV3bFUwZnhuVlR6NlRxMHMxOHFZSmt4bVdRSDBzdmZqaitV?=
 =?utf-8?B?MTVXd2dzdE5KZE5HRHZiL3ZJbldMZWVjY3A1dGxMZTZsRWtac0x6RVFJWWE2?=
 =?utf-8?B?ampnK3F1S25SeHpLNnNOVGhma0FtQVNjUmZaMmthZmthaGp3OTUybXhhb2or?=
 =?utf-8?B?T3pVd2IzV1ZTanA0T0dyYitmdjRNVDdXcE0zNG9tUldHZThqb283MUVKMCtz?=
 =?utf-8?B?VVBWSXNoL0kvOHpPV0JySXpxdWhTdE16VEZnUE5tUHhtZUd1T3FLbFJsd2ND?=
 =?utf-8?B?MXppTXowRTE3UzkrTmRPQUZja2NxMnFLeGdOWVZSZGJ3Z2Q0NFEveEdVMFVs?=
 =?utf-8?B?ajRVZ0Q2N3U4NHZsVGM1MjZtdmZVb0diQmx0ZExBM2x5Sk9MbmZPQUlGcWFZ?=
 =?utf-8?B?bFNXWmFyRW5mQTFyN1ZzdG9peXErenpWQlFhUVdHa21TQmtMRGx6c29VL0Iz?=
 =?utf-8?B?VUtwN1BiLzN3bG91TjBkd1A1dzBYMk1MUmFqZDZJbm1veXYzYjRwQm9qQlhJ?=
 =?utf-8?B?eWo4ZDE5cnUyK2JaRHp3ZzNIWWZPejBGS2t5UDJVVkl2bldiN0ZJWTVTamwr?=
 =?utf-8?B?T0llcEFJWlAzSmVrM1UyNmo2Z3FKaFlRV05zVWtyTWI5bFN3TlBpUWZUdEE5?=
 =?utf-8?B?T0pyS3h1eEhjNGU3SkUyTjhoeTV3YStzSE4xYzBmRXBmTEVza3BXUG5rUTVC?=
 =?utf-8?B?cVpoaG1QWUwxekxINWM4OEJIbGxHL1JzZHNoemNJK3BaSVNIRXNOV0FEUERB?=
 =?utf-8?B?YlJsRnBEUk90ek84SXlOeVdEZlg5ZHBJcC9CRWNtcFlGRnVhUDd3N3U3KzV2?=
 =?utf-8?B?cXBYZVpmYmplUDFXTEorZGo5VElTaGdEVDlvYnI2c1J0ZnEzZHhOWW1tYVdu?=
 =?utf-8?B?UmliZ3hZZG5Mdm5oYVd0QktPaTNvb1Z5TjE4UHVIU0hoMy9LYTZKaWxuYTZH?=
 =?utf-8?Q?9Sj1/3X2VvCPh9nqa+SxTfC1r8F7zwZj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REswd3g2eGluT1l5RlRuQ1ZsVWRUa0pYUVMydWZxbjBPOEpJb1ZzMi9oMVNG?=
 =?utf-8?B?UVRFeUtpams2bFRKUFkzYVZNUmxoaDZRNjlVNnkxSXFqblV1Ynp1OTdDbUxG?=
 =?utf-8?B?d3hZa2FXYXF6V21JZGxRRUQwdVdVeldwRzNQY1UrQ0RZR1MzZ3BIVmMwUmF4?=
 =?utf-8?B?ZTRuZUovaEUrcitFSEdlempVRCsrL3RUSjRLOG5SK3RhN0tZNmsxTkQ2ek84?=
 =?utf-8?B?dTZHTW9yR0kweUFoRnFEUkJVcFRiZndMcTl1OVBRb3ZleHkzakhzY09TclZk?=
 =?utf-8?B?R0pUR0Z5T3ZnejlzZUJYdVoxcHdxYjZDRktsSmhwaTZrSWxRMFU4VmJYVUtZ?=
 =?utf-8?B?TzlWRTVCNjRwRm5DZGkwR0RsNHhLWUx3aHZOK3VSOVgrem0yc3JrQ3RFVXgw?=
 =?utf-8?B?TW1QNnJhd0xaeFVveTJESFVtdFBsV0tvdmNhTTJBVTJUSFpjZDRkUStvTEtM?=
 =?utf-8?B?YzRQOGRta0s1cjhOUVF0VFNETWprZmUxaldhMndaSkgxQ0JRajJ4QytpTkk4?=
 =?utf-8?B?Z29OSzdRR3BtYmRzeXJPMzZCRE16M2ordHZ5cXdTSUJON25XWFVzbmV0STRX?=
 =?utf-8?B?RVdBYWk4cyt0RjkxU2pnQUxFZmlDVU1tSi80YUhMbWltZncxb01IamJtZC90?=
 =?utf-8?B?VEhOWitYeTJ5cjN5cFlsTklZM2xQS0J5dG5xRVpKNEJJazJkWVIwcXp2RWFC?=
 =?utf-8?B?bU4yQ0dCNTlXUGRPMUtFUmdYVmg2dUw4b3BPTWthWWh0eXFscTZ5QzRPa3JX?=
 =?utf-8?B?d3lzQnVsTEdhOCtIOVdnZHNlaDBoM0hLRXZoandnT09zNmI2VG9sdWFnMEVh?=
 =?utf-8?B?MkJPWCtEeXZjWDFwcnozVmdLeHZFV3pKb3Q4dkVLNytybjE1U09xNHVhNWhM?=
 =?utf-8?B?cnNBZDNWaGQ3M1p2SUlNcmN4alRlTkVDNk5mckYwZFlCNkxzdGhUa1NQTkRV?=
 =?utf-8?B?eTgvekVPSG9kUGVTZnNSN3ZZYUtPMWJyeldEY2FXMXMwdVNud3Naclp3dUc1?=
 =?utf-8?B?bFdXNTdWVXFmZjhTenE0Q0dKdjM4VWJOZTExRGNKczBxemxkY0pjWFQxeFlx?=
 =?utf-8?B?bVRERElKdnNaZFNtREllZFk2Mms2dnJ3bjI5WVpyeTcwSVArRzdQb2N4Qm9N?=
 =?utf-8?B?Z1V6THRhVWx6NXhLQXoydEppYXZ5a1FYbHJJQ0FXUHo2WnlrK2ZkdTA1TC9h?=
 =?utf-8?B?WkhKZ3NsY2cxMzVrajczR1JrRnUvUDk2VTB6M2FUTFF6d0krbWcxS2NqVFNp?=
 =?utf-8?B?Wm04RUJBakNaWEhockxnVWd4TDZHQU44eWw2TVRhdzBFYUp6eWl2RDFtdlp2?=
 =?utf-8?B?TXMyMmR1VGIzMFUvU2tmYlZtVDEwUlAwSHVmZFBDRlQ1eEl1c2xZUS9hWFVU?=
 =?utf-8?B?K2dvWXlDSXJmNnYyZU85VlVyTUFBRExJUjBUUzlMam9RYWJZbWNNQndJeCtD?=
 =?utf-8?B?WWszUXhkeE9mOUdVYVBEaUhwVzdLZWFDZXJkWmNYbGZOZXdHcms3Qm5wV3ND?=
 =?utf-8?B?VU53RXIxcXVzQVR1a0QwMXNnaEIySC9LdDRabFlXNUFjaVd1M0VnWFlGbFYz?=
 =?utf-8?B?YmZHZERMQjFNY1VwcW1Oa25XWXVvaWc3MnNaWEd0Vk9oYjdiQ0ZqdEdEcEht?=
 =?utf-8?B?QlVDQ2tTOUVUNE4yWlpxaVkvZXBneEp2QWRaWFJBN3lDVWlBWFZjUUsxUmJV?=
 =?utf-8?B?SFI5aGtlTDJVblhKaG80RHZCdk5ma1ZlMmV6M0J1UkVFYUdPbDZ3bitZTWEx?=
 =?utf-8?B?SHhISnNMUDIwUTdtSUlxenROdDlJQlhjWkdaVmc3QWUzQXpGZzhSK29DbnBX?=
 =?utf-8?B?ekh1c0s2YzAxRVErR3VBcDJNQ0k4dlRvMlR5alhlUU1MZDk3anVXRHBjNW16?=
 =?utf-8?B?d0tuUzMxTW52ZEw0OE1za1NhazdGTkc5SHZDVElWTlVoaitudVVYN1JqT1Jo?=
 =?utf-8?B?SXVtbDdBNVJzeXREKzYvZWFDSVVIbVJHZFJFd3BPR3k5eVJITkVHZWhseEFZ?=
 =?utf-8?B?d0xLaG9VTTNyWU93Z2pONE5ZMS94SXc2emUvYXZsc0c5endFZWhZaGFNeEpT?=
 =?utf-8?B?ZDhHb1Q3TzhQOTJ5YU9ScGRlOTZKc1p3QytWZ3ZhK1NFVktWTkU3VzRiZytl?=
 =?utf-8?Q?PggJDI+JCx3/+dtD1Y7GYQZeh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5nc46Z4hpvN2TNoZrAp7+HciMGs+4ONWk2/3S/Mnof82EsSvMkkpP2rzB+6GEC9ElC69K00isyWLSyBYJk9aur3yZg+5HODFiIbtvCU74Lv/ib4/Xh51GHv3xlVkLfQamG31IBwLNtXlj0thmKskHEY66ebEjDJbQ2oowBX1rB4QzVO+n6Z/OPDtkDRVs/KfAMijlo39JhF2apdcTm1WT2cOiYy8oFTKCpaIVC/x4nEMapg4++AWic2Zt+SkwXzhaTyfuWk9PNOLgl0dtvwtqMp2NpaJMqbZNgjItJsrLFje3SecjvD5dT0NjUI4Hk2s93S8FFZMI2BIxQSu2cmP2tvbN518+rI9LBYzWUPJ+v6tXgbEMLptVODCfIToDchkvZcCufklw0ZzclCVj3pqYWueFIEENhQR/4o0a9mzGTM9hgHwWcRDFPByDIqGJoAbJUjp/oET1ahjhPp6s8/F/jcGnmOoUHmFtJI+kFFKmv31/CIxrqEEBrTEj0nBUpJyAOTulKRl3dGqPn5/6EjEf2uSIY5JTyda5VtGT5MuBsuZNNqxBkJktnYVbb7+UyYm45tneeHCVCG3UaGW7PVk5GjZZbrlcVGm7s8OLFiry4A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b57acc75-ac40-446a-de8f-08de0d8aa5a1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 14:37:07.0428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VC+ZLLlGTwY55zG1zvPxLgAmkkK5gMGk3Bh0GRgBWt7nGu+jf7sBX+8m2QzgefgQJBJ8W5Jyl8JN1PHG/Tc7sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4437
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510170107
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDA1MSBTYWx0ZWRfXwXxjkNsJNA3f
 11XDJt/jjbd1MU0RnPQ7jrwNVh+Ozocuf8xklXD97kzv1yxfB/GAYC78qaBbjrgNeFJn30yx1YQ
 UYMr7TA5QwyHXSykwx85oKCpMVMDVBlHJJ9oVH64W/chgj3AdOjvlF9b/k44pad1px7EtzBAmV+
 et9z1XaRdVU5QGbNP1kW1oAv0R2YNL/t9zqmqHttknQE/qgNPXUoOmPIA67pBBuM1UpHtp/SVyA
 mbsE73LmUlsqijl9+ThdwkBmN0xtLzbBbarwUmSyBjKhsV94kd0uEfSDDV5NECv41cVeFpc7cGB
 Wd7TW1Q7DKzQ7b7t3loJAVFQYtsM4ekLmD/nonoy7YWqL9PzGd7nLHWGT4uYBT1sCeFfL1Y1Iua
 lm3mDSjYLlIUNeR804zi7hPq7H3PCZfhTIEego4DiFnbFZkvvJ4=
X-Proofpoint-GUID: Qd_hXZMSM46cnRDWajRcjGtU-Smhxf0I
X-Proofpoint-ORIG-GUID: Qd_hXZMSM46cnRDWajRcjGtU-Smhxf0I
X-Authority-Analysis: v=2.4 cv=GL0F0+NK c=1 sm=1 tr=0 ts=68f25497 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=JF9118EUAAAA:8 a=zqJBN6IEQoyygF5RKowA:9 a=QEXdDO2ut3YA:10
 a=xVlTc564ipvMDusKsbsT:22 cc=ntf awl=host:12092

On 10/17/25 12:23 AM, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Allow userspace to include a key serial number when completing a
> handshake with the HANDSHAKE_CMD_DONE command.
> 
> We then store this serial number and will provide it back to userspace
> in the future. This allows userspace to save data to the keyring and
> then restore that data later.
> 
> This will be used to support the TLS KeyUpdate operation, as now
> userspace can resume information about a established session.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Hannes Reincke <hare@suse.de>
> ---
> v4:
>  - No change
> v3:
>  - No change
> v2:
>  - Change "key-serial" to "session-id"
> 
>  Documentation/netlink/specs/handshake.yaml |  4 ++++
>  Documentation/networking/tls-handshake.rst |  2 ++
>  drivers/nvme/host/tcp.c                    |  3 ++-
>  drivers/nvme/target/tcp.c                  |  3 ++-
>  include/net/handshake.h                    |  4 +++-
>  include/uapi/linux/handshake.h             |  1 +
>  net/handshake/genl.c                       |  5 +++--
>  net/handshake/tlshd.c                      | 15 +++++++++++++--
>  net/sunrpc/svcsock.c                       |  4 +++-
>  net/sunrpc/xprtsock.c                      |  4 +++-
>  10 files changed, 36 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
> index 95c3fade7a8d..a273bc74d26f 100644
> --- a/Documentation/netlink/specs/handshake.yaml
> +++ b/Documentation/netlink/specs/handshake.yaml
> @@ -87,6 +87,9 @@ attribute-sets:
>          name: remote-auth
>          type: u32
>          multi-attr: true
> +      -
> +        name: session-id
> +        type: u32
>  
>  operations:
>    list:
> @@ -123,6 +126,7 @@ operations:
>              - status
>              - sockfd
>              - remote-auth
> +            - session-id
>  
>  mcast-groups:
>    list:
> diff --git a/Documentation/networking/tls-handshake.rst b/Documentation/networking/tls-handshake.rst
> index 6f5ea1646a47..d7287890056a 100644
> --- a/Documentation/networking/tls-handshake.rst
> +++ b/Documentation/networking/tls-handshake.rst
> @@ -60,6 +60,8 @@ fills in a structure that contains the parameters of the request:
>          key_serial_t    ta_my_privkey;
>          unsigned int    ta_num_peerids;
>          key_serial_t    ta_my_peerids[5];
> +        key_serial_t    user_session_id;
> +
>    };

No need for the extra blank line here.


>  
>  The @ta_sock field references an open and connected socket. The consumer
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 2751c15beed6..611be56f8013 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1691,7 +1691,8 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
>  		qid, queue->io_cpu);
>  }
>  
> -static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
> +static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
> +	key_serial_t user_session_id)
>  {
>  	struct nvme_tcp_queue *queue = data;
>  	struct nvme_tcp_ctrl *ctrl = queue->ctrl;
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 470bf37e5a63..4ef4dd140ada 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1780,7 +1780,8 @@ static int nvmet_tcp_tls_key_lookup(struct nvmet_tcp_queue *queue,
>  }
>  
>  static void nvmet_tcp_tls_handshake_done(void *data, int status,
> -					 key_serial_t peerid)
> +					 key_serial_t peerid,
> +					 key_serial_t user_session_id)
>  {
>  	struct nvmet_tcp_queue *queue = data;
>  
> diff --git a/include/net/handshake.h b/include/net/handshake.h
> index 8ebd4f9ed26e..dc2222fd6d99 100644
> --- a/include/net/handshake.h
> +++ b/include/net/handshake.h
> @@ -18,7 +18,8 @@ enum {
>  };
>  
>  typedef void	(*tls_done_func_t)(void *data, int status,
> -				   key_serial_t peerid);
> +				   key_serial_t peerid,
> +				   key_serial_t user_session_id);
>  
>  struct tls_handshake_args {
>  	struct socket		*ta_sock;
> @@ -31,6 +32,7 @@ struct tls_handshake_args {
>  	key_serial_t		ta_my_privkey;
>  	unsigned int		ta_num_peerids;
>  	key_serial_t		ta_my_peerids[5];
> +	key_serial_t		user_session_id;
>  };
>  
>  int tls_client_hello_anon(const struct tls_handshake_args *args, gfp_t flags);
> diff --git a/include/uapi/linux/handshake.h b/include/uapi/linux/handshake.h
> index 662e7de46c54..b68ffbaa5f31 100644
> --- a/include/uapi/linux/handshake.h
> +++ b/include/uapi/linux/handshake.h
> @@ -55,6 +55,7 @@ enum {
>  	HANDSHAKE_A_DONE_STATUS = 1,
>  	HANDSHAKE_A_DONE_SOCKFD,
>  	HANDSHAKE_A_DONE_REMOTE_AUTH,
> +	HANDSHAKE_A_DONE_SESSION_ID,
>  
>  	__HANDSHAKE_A_DONE_MAX,
>  	HANDSHAKE_A_DONE_MAX = (__HANDSHAKE_A_DONE_MAX - 1)
> diff --git a/net/handshake/genl.c b/net/handshake/genl.c
> index f55d14d7b726..6cdce7e5dbc0 100644
> --- a/net/handshake/genl.c
> +++ b/net/handshake/genl.c
> @@ -16,10 +16,11 @@ static const struct nla_policy handshake_accept_nl_policy[HANDSHAKE_A_ACCEPT_HAN
>  };
>  
>  /* HANDSHAKE_CMD_DONE - do */
> -static const struct nla_policy handshake_done_nl_policy[HANDSHAKE_A_DONE_REMOTE_AUTH + 1] = {
> +static const struct nla_policy handshake_done_nl_policy[HANDSHAKE_A_DONE_SESSION_ID + 1] = {
>  	[HANDSHAKE_A_DONE_STATUS] = { .type = NLA_U32, },
>  	[HANDSHAKE_A_DONE_SOCKFD] = { .type = NLA_S32, },
>  	[HANDSHAKE_A_DONE_REMOTE_AUTH] = { .type = NLA_U32, },
> +	[HANDSHAKE_A_DONE_SESSION_ID] = { .type = NLA_U32, },
>  };
>  
>  /* Ops table for handshake */
> @@ -35,7 +36,7 @@ static const struct genl_split_ops handshake_nl_ops[] = {
>  		.cmd		= HANDSHAKE_CMD_DONE,
>  		.doit		= handshake_nl_done_doit,
>  		.policy		= handshake_done_nl_policy,
> -		.maxattr	= HANDSHAKE_A_DONE_REMOTE_AUTH,
> +		.maxattr	= HANDSHAKE_A_DONE_SESSION_ID,
>  		.flags		= GENL_CMD_CAP_DO,
>  	},
>  };
> diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c
> index 081093dfd553..2549c5dbccd8 100644
> --- a/net/handshake/tlshd.c
> +++ b/net/handshake/tlshd.c
> @@ -26,7 +26,8 @@
>  
>  struct tls_handshake_req {
>  	void			(*th_consumer_done)(void *data, int status,
> -						    key_serial_t peerid);
> +						    key_serial_t peerid,
> +						    key_serial_t user_session_id);
>  	void			*th_consumer_data;
>  
>  	int			th_type;
> @@ -39,6 +40,8 @@ struct tls_handshake_req {
>  
>  	unsigned int		th_num_peerids;
>  	key_serial_t		th_peerid[5];
> +
> +	key_serial_t		user_session_id;

Here (and below), "userspace session ID" had me confused. There isn't
a user here; IIRC, it refers to a session ID for tlshd to track?

Something like "handshake session ID" might be more precise?


>  };
>  
>  static struct tls_handshake_req *
> @@ -55,6 +58,7 @@ tls_handshake_req_init(struct handshake_req *req,
>  	treq->th_num_peerids = 0;
>  	treq->th_certificate = TLS_NO_CERT;
>  	treq->th_privkey = TLS_NO_PRIVKEY;
> +	treq->user_session_id = TLS_NO_PRIVKEY;
>  	return treq;
>  }
>  
> @@ -83,6 +87,13 @@ static void tls_handshake_remote_peerids(struct tls_handshake_req *treq,
>  		if (i >= treq->th_num_peerids)
>  			break;
>  	}
> +
> +	nla_for_each_attr(nla, head, len, rem) {
> +		if (nla_type(nla) == HANDSHAKE_A_DONE_SESSION_ID) {
> +			treq->user_session_id = nla_get_u32(nla);
> +			break;
> +		}
> +	}
>  }
>  
>  /**
> @@ -105,7 +116,7 @@ static void tls_handshake_done(struct handshake_req *req,
>  		set_bit(HANDSHAKE_F_REQ_SESSION, &req->hr_flags);
>  
>  	treq->th_consumer_done(treq->th_consumer_data, -status,
> -			       treq->th_peerid[0]);
> +			       treq->th_peerid[0], treq->user_session_id);
>  }
>  
>  #if IS_ENABLED(CONFIG_KEYS)
> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index 7b90abc5cf0e..bc9a713c6559 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -444,13 +444,15 @@ static void svc_tcp_kill_temp_xprt(struct svc_xprt *xprt)
>   * @data: address of xprt to wake
>   * @status: status of handshake
>   * @peerid: serial number of key containing the remote peer's identity
> + * @user_session_id: serial number of the userspace session ID
>   *
>   * If a security policy is specified as an export option, we don't
>   * have a specific export here to check. So we set a "TLS session
>   * is present" flag on the xprt and let an upper layer enforce local
>   * security policy.
>   */
> -static void svc_tcp_handshake_done(void *data, int status, key_serial_t peerid)
> +static void svc_tcp_handshake_done(void *data, int status, key_serial_t peerid,
> +				   key_serial_t user_session_id)
>  {
>  	struct svc_xprt *xprt = data;
>  	struct svc_sock *svsk = container_of(xprt, struct svc_sock, sk_xprt);
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index 3aa987e7f072..bce0f43bef65 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -2589,9 +2589,11 @@ static int xs_tcp_tls_finish_connecting(struct rpc_xprt *lower_xprt,
>   * @data: address of xprt to wake
>   * @status: status of handshake
>   * @peerid: serial number of key containing the remote's identity
> + * @user_session_id: serial number of the userspace session ID
>   *
>   */
> -static void xs_tls_handshake_done(void *data, int status, key_serial_t peerid)
> +static void xs_tls_handshake_done(void *data, int status, key_serial_t peerid,
> +				  key_serial_t user_session_id)
>  {
>  	struct rpc_xprt *lower_xprt = data;
>  	struct sock_xprt *lower_transport =


-- 
Chuck Lever

