Return-Path: <linux-nfs+bounces-6453-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B06B09784B4
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2024 17:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F3AEB2466B
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2024 15:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACB138DFC;
	Fri, 13 Sep 2024 15:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W00IbQ7Q";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="F6Dpx34E"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AB526AED;
	Fri, 13 Sep 2024 15:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240786; cv=fail; b=WBCgngRzZD3r8G9BAbOrdHrDWixBZrLbsocf1QBR63DjqhMBEGpgW+J8sWhkIUwOqo3CsuMZAes9id6C3KhhqXRfRN6W+8AXZ5krawgSGK2lkS+/JGEHu5cuXLfzeMeozQBkzwGKfN9HuZ3xpHXLg3E+Xpeo1Y4BTA+ROpwpKcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240786; c=relaxed/simple;
	bh=7Hr1VPk7KhGEv1a1Tg0v7JhRCYd7dMEfExLilQasSWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jMZvBAgtWI/9Y7X3q8pOJa6PuzZthe9AhkEr3ctukmR4M0USXhsSG7u4ruMEUMNrHeXH1RekOrZoOI00p8cqmglqsG0GZ12aVyYBqKF7Zy0r902lagxnN27Hnjaw0WL4oYNST3/HhraOUU6k38aFpgowpDRjdu3B+5FDCuzmop8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W00IbQ7Q; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=F6Dpx34E reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48D9YMvd012331;
	Fri, 13 Sep 2024 15:19:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=JFANI+rYN9M+3mn3NhadyOSaXOqnEAhRq2VcYphfUc4=; b=
	W00IbQ7QC33M4JHp0vtLyJQPVE1B6YNEd2WmR6Q/DSSFz4w9VlwbQcJH7vEYkCed
	92qI48J8IS78ioDGfBixdKVHiF4DviFTDVzrZQgNgtvHBD5FQfYGQj1/y2KZw2/U
	o3LrLaaDaeR8+wh1X7p+B/5zn2JLjU9owJ2NC71W3KbAy2988Xc3oG8qnwGHsbA4
	5ZAk2AAXvj4Pt7Dh+LWq2s3ayrc/bbMsvq/hj5B8d7JjCVgLQWgKsmCjUCLSsPpp
	DzGpBpe0TtPniLlogtcWEtt81q98mA9AyDnv894wUFSeDyLmxDhDek/chzU6+Z3h
	99WaFa0SYXV3mYzOZjpzOA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gfctnvvr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 15:19:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48DFGweZ033599;
	Fri, 13 Sep 2024 15:19:32 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9csj2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 15:19:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VcyG1SUIt5C03Do705JKYtWAAkZRQNsGU9Y2na4q0Oks7iRhXaoOTdBRu/MfU0ses+xAWX8+26XFPIXKVMZvWf5GczsbyvIVQozsjBkP8N0vl5oyV5T9RkX3niH0mLjIMHYzU5V46IAGwlNiq6RKQ/wxk4d2akUGdQnwOB8Njv3n/66wDjcCEh2lhwHKXFSOi8YsoVe0HrzyXvw+mmQeUOU2TqEDtIvnUqDALf5iZJDdDzD3OqMzHu4maeAPWIgSz+pZbjlygOdj5G3ksoBS/bC5xnZ7M4glFHmN4aJAZ1SJovePn5P3GLRlq6xdqjDOBAFT5EO/dlQfx8jLZTY9oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bb4ck7pob0OxIn9Bv5iaW+77WOnmbYgHh/Z598d163o=;
 b=Qakp7pHF/g88e+nG6gyv/UCwDKO67F594/5GgEdgTczCh3UEQP1cvGebLx0jc7BJtjBwMRGW+0ZtOJBuxYJhI7FzhCEWI606BogpZOlAedzcF1thYspSCNUWlfHZc9Np0co5Z4JuiGj/nmuCOBY8ZPUcBNGHKbeAvAFCsI2aIBN2XyDAiA55uO0woZIC8zQlPIwdUeg6CMNGDyZwBQJFCU1YTyHzGR1OIMkS7OS4E+wif4OnrU0pFt1Jk7bjT79GuhHtJBsRgobb44Qh93dEKmVK7UeaYbFzp7A3XZTf6kbb6CLYsi8zh6BZdRgcCZVqAR1MqDwAdM+iG/XpbhcPwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bb4ck7pob0OxIn9Bv5iaW+77WOnmbYgHh/Z598d163o=;
 b=F6Dpx34ECiTr1EDVKxQurCBdXW8cdfZ6pZJTN9y1rPqkmjyIQrepgAQ1RSUq3tHBSYozPX/idKz8m3LyfhIW+dbyl60netnFs3ryZz8ecGTnMIwggBs9deRfpBEgrjqPaO+VFO/G3S1CjpcViw9x0++mMmM06y6KjFNb4QEqd/c=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV3PR10MB8034.namprd10.prod.outlook.com (2603:10b6:408:28e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.7; Fri, 13 Sep
 2024 15:19:29 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7982.008; Fri, 13 Sep 2024
 15:19:29 +0000
Date: Fri, 13 Sep 2024 11:19:25 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: Fill NFSv4.1 server implementation fields in
 OP_EXCHANGE_ID response
Message-ID: <ZuRX/QfG+OLm9fTR@tissot.1015granger.net>
References: <20240912220919.23449-1-pali@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240912220919.23449-1-pali@kernel.org>
X-ClientProxiedBy: CH0P221CA0040.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV3PR10MB8034:EE_
X-MS-Office365-Filtering-Correlation-Id: cdc068ad-c573-44f7-6541-08dcd40775fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?2GzKgMJ1GZ80el/XTpb655aGT0wcWHW/6CvVjk+doAZGX7o9DfZ1Pc3UEI?=
 =?iso-8859-1?Q?kYYKMygtsCqiF/O8UkTLscp9IduYpysJPwlT0OQimf8cv/3mgzlYF8KY3F?=
 =?iso-8859-1?Q?Vakp9x7jRsbN4syXRWG8Vqi270yH9M4dMIQtz71CpKrFVknnUDJxyew3I0?=
 =?iso-8859-1?Q?b+zRv0J8J0pQ9t1acfdzRCEdi1EBl9BcDYSYv4JVKmTwVXPKeg31xWhbH/?=
 =?iso-8859-1?Q?HF98staKPkAJrQZpNXuBZM6Bp3URDyvHK3OxgieIwJvrj2S6OTzNoWuZdd?=
 =?iso-8859-1?Q?NAHCgT0GRDvVzMl3VJsT4NzryAR151pP3smp8JwpQJVxtIwZD13Aegcgj6?=
 =?iso-8859-1?Q?ZNuHmkHH9c9rakWNepujkjS2w98lFCkwtf+vO4Q6OV1QHQkSHiqrIBBuDK?=
 =?iso-8859-1?Q?AFtPsvq6R8QJN8alqKouIEc6vHXh75tR/Rvaj2uV/zjrtFL/k/Ffn9NSJk?=
 =?iso-8859-1?Q?TTnmoKzH7S+itPtkHDlvWnGx3aK87uA7QGUNBoVUr+2TcEm7UEKJ66oGdm?=
 =?iso-8859-1?Q?tfLWiy8JPSVYoR76fAWE/R/ygl0K/4LVaHvE7PZJc0Gw923XKL6Nd5wUHB?=
 =?iso-8859-1?Q?apxL2uk9ZOq0pQPle9npv5RWuMxSq6rIa/+bSUhKo79C53iXWcU4xcB8Sw?=
 =?iso-8859-1?Q?MFjENbuK/13Y29Wog77H4Ja7rQso3llWXw8QdnlLBEvQP3W7lz5gk0bqFA?=
 =?iso-8859-1?Q?3AvUnrihEYo7Q6U157TsQgbxfUiS+OKWkUiI/OA7rmL/agcLkWc0RzQk/0?=
 =?iso-8859-1?Q?gCucvr1lKL8XTxsTEMLBOqKpysVAj7E0J2ar54Bzgo+SVmqKI2UUtpv2me?=
 =?iso-8859-1?Q?+R0FZ6ZJg+8dFg8E7jyh6S7teqjX+oow50B2Mwm3fn1iZ5N7vdK/XE8FB5?=
 =?iso-8859-1?Q?Gu0MSxW/1Bncf5SPMn87JnEOxA/diaa5C/JI1M9NjDD8+WSfe3Ks5t0Zw2?=
 =?iso-8859-1?Q?1jQsxIFK/Jn2Zac+fcxfU+y5fcJbkpBnTfosx7zXOj66B30RUYgxAerWxd?=
 =?iso-8859-1?Q?p+6oilAF97m3an+yRCyySgNMm+zBJzRZWVAHm4pNVi32wbuzwsh0xwDFqV?=
 =?iso-8859-1?Q?5DyyE/+L+5PavT41Mjssbs9icQOR8mCuTFwQrQ2q6Vd8QGjfgA7BHH9qPe?=
 =?iso-8859-1?Q?CuVLf+/2JXTykFZiC1V90Ayekt0Hisom0xQDmxJDHJW1eCWpP6BgKHQs7Q?=
 =?iso-8859-1?Q?kbbcUSwNxQQPCn7vZ/9OTAMCa4EYxxBpc6g6WW3tRoY3rUtjh+J5oSs+zI?=
 =?iso-8859-1?Q?QVW3FwDQiuCqANmIedcpB5e8PnOPOU1oqlzZAxS7DbCbT5w23fKAai6bCj?=
 =?iso-8859-1?Q?0Ksz4m3TBStQ6aiBKlYMAGOuEDfIPiNGWnilOD9RegALt/H6RQl6jKMgMI?=
 =?iso-8859-1?Q?ts9Lcgg1pK763Kji7vaKAsOJIqHs1Rxw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?37NUEujbljyN7o9/CIPf77+YG/JNqC/zOuQy99m3I1QRDW7iXHDRLko9nO?=
 =?iso-8859-1?Q?QvkSbRrXcNvCbJ16Oc+UxsoKk9iwBnnPPs9dpgcFqSAX/dDMkK8Q9YNAQF?=
 =?iso-8859-1?Q?xcQscKEw4TMQUw7od0HdE8HEaPIl5H0n+w8hbEK/VzXeKj/a8lKPBqEt9o?=
 =?iso-8859-1?Q?pfg48DIiMnf1IU7H1eTSl4o4aSaQHDBD8o6BBQd0kMGLuvFq9YwA++sjpA?=
 =?iso-8859-1?Q?1htZRHvmuOBky5P/P/pnJVGL6/wKbn/T9GtEk+ZNZpnP3nhVU+hC+DPI2z?=
 =?iso-8859-1?Q?5/8odn+r/REiNeNNPykwGqxuaPooBnJkGkqAshKp1WFWSna6b4IIcbe76V?=
 =?iso-8859-1?Q?tSaqxw9CaGS20fe3WUZZn5LzIcEJWQhTuLDZ8+BG9iCJ6v2bScjaLvj9yu?=
 =?iso-8859-1?Q?C17MXr0nGXP59+/9hpAk/8S/eCeuPVeyNtO/qy5mlHqFQR6/4/3V2zJHX0?=
 =?iso-8859-1?Q?/vRa8eMpq0xt1hfnjiUa0F6sHksheSiDb2zo0kcFBdxRKtBVadPRB9CQH+?=
 =?iso-8859-1?Q?bwBvXcaS4EKyG1rFs5OKadFMIaXsy++Be7UXZbIqqOAw2baIwVacVTkIB1?=
 =?iso-8859-1?Q?5RSeyjb7y+A+vE2zZLsaSaNgXw9065tF3oraWPn7UN+Ydi1ePhEHYZl5lT?=
 =?iso-8859-1?Q?jbMVQd37XK2x4xI0e2z/nV70fBEojlnK+h0smzmRt3JNbjDGt2SoJ2J4se?=
 =?iso-8859-1?Q?yrwUI3mLpBVyPPYe1q80wyVvairMED/MRUy5PtQ3huYTXDmE9Xdw1fpgVr?=
 =?iso-8859-1?Q?xCizbI1m7zavZuLVNI1YFuiwTbHlB9oHfcSbC3FAHKo6CitFHFv30lWp35?=
 =?iso-8859-1?Q?JyUrdWhOYXay+9tuoUahyy/CqAl+5otkzY7ddjDg6gWmksqc4Bk2OH1JI6?=
 =?iso-8859-1?Q?oQDyhFDsHYM5AAoqWb1UxAtphLyghDzLOJqsFk+060Carwkjzjr1AEaDOu?=
 =?iso-8859-1?Q?prGbB7EIBgrDYHm/FzEi4//zSlVx5Sq2acoQrs1LG4yb2rrOyY0TeWP+Lb?=
 =?iso-8859-1?Q?feqT+0rZ5SS+1jwKHGXtLW2eB9fObtFMrnzn3K0bMZxRS0XxZy6yVa8gSt?=
 =?iso-8859-1?Q?LN9xzq3J959iAY2TyWqhiw0owby+O408HWnrprWkaqxtvZx6UqXBwdZFu8?=
 =?iso-8859-1?Q?a61SR8fQLN6sRECy4rtFqJMr3czz61j7LvIQ9mPbyyDrv0CA5YUng3pmDJ?=
 =?iso-8859-1?Q?JEZl0a5jLc8SK9t9n3VuodHdusz7Ruwv1bpS7sXVCzkVw5IulfvyJZEKsu?=
 =?iso-8859-1?Q?eso7a2wKQ3/tcVAgI4GKydEVvZbSENw6IdYmdAffgKPzavYbYbUdJFEmsO?=
 =?iso-8859-1?Q?lV4D9evOcrckd/at+LNbst/rsP3+pf+Ux/HfFqaRVAsuSY1Mpx8xw4yrLf?=
 =?iso-8859-1?Q?+yky47fLJLSS/+f9hDuMKKvJkKhJT29g3fO8DVzwoPo1bb1t+inufu2kC0?=
 =?iso-8859-1?Q?4b85ogRYun2EDNPOCsX4FSqcv7WUwtRJaHrxm/MPd7aZXO88meuD9eN8tE?=
 =?iso-8859-1?Q?d1z88EKAs9X1wHktOL/wVt9g17kdDWTFiI8EdIz+x0PoCZ5EYEKDyuXhb2?=
 =?iso-8859-1?Q?PeQ7Rhql3heYCa6hbKjNuFpEMkOtyZL+Hb9EZiBsFLmuZYRXwAkqTKE7NB?=
 =?iso-8859-1?Q?2Ge+vCL4ynXacPbeH441LX9w1Wd2qdNVEG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MkdDImQmYfMfOxaYMB5SJB/Wz8xbyl0FbS7xsfYpUKuEumRj9D1gcSCOvnW/0BV00POQmEz8grDDjEWpq5n2DTCa0D8fxkozSytjKyuyQ2Ak0IIj1NxKd8NZh+tWEPchIyqqlv3wXwMjv2SDoDPzej1Slt/K4pSBsFG6XWYe/R1fEJwCnjHokxQcDsuzgclTeXjx6vLQEiiOqQVjlAjLHc4MAYDCxHC03qM7Y26V34voTH4CZgN+cMyvg7OeoTRQbsJwZEFKjlZt7zyTGMuax+yOq1osZ7miig8hhi3Fksl6798ghp9t2FCrYngHPdU1MjtLdiGsjSYC/XkQSFeGk8j1fI93A6K+Bstwh4itWDMx5IsEmkFDTek+zh0dcg2saB4W4Zsd4vbZ9ijCPSyGW4YHkFFIJqLXH9VFEft9axpiOLuU0+en3cXUBcuAKThLj8fo85bEE/zrcVgC4fHl9u5TTyZycS0Ej3bqsJcrOdTSwXncPPArUSyGBDyyks1tncRNNXxZe92aIZ3DiOvnx5cQkMLiRkxdv5eTl2sBhFqhZBShOOKM7OhE08BF5QPP3Hu8gfn3BfuFC/ibXOo7USCCiG2dp0nZa7EbUURWri4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc068ad-c573-44f7-6541-08dcd40775fd
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 15:19:29.1034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0N651ugAYvBVUI2hiYLiuVKnkbnzhU+NH3/QQMCs8kcnbTIDCPwIKffNbIxQa72gq0rSEJAIgWkrFCMzRajMhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8034
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_11,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409130107
X-Proofpoint-GUID: shuLGwHLv9XloQTrEIas8L8pczXtVhRt
X-Proofpoint-ORIG-GUID: shuLGwHLv9XloQTrEIas8L8pczXtVhRt

On Fri, Sep 13, 2024 at 12:09:19AM +0200, Pali Rohár wrote:
> NFSv4.1 OP_EXCHANGE_ID response from server may contain server
> implementation details (domain, name and build time) in optional
> nfs_impl_id4 field. Currently nfsd does not fill this field.
> 
> NFSv4.1 OP_EXCHANGE_ID call request from client may contain client
> implementation details and Linux NFSv4.1 client is already filling these
> information based on runtime module param "nfs.send_implementation_id" and
> build time Kconfig option "NFS_V4_1_IMPLEMENTATION_ID_DOMAIN". Module param
> send_implementation_id specify whether to fill implementation fields and
> Kconfig option "NFS_V4_1_IMPLEMENTATION_ID_DOMAIN" specify the domain
> string.
> 
> Do same in nfsd, introduce new runtime param "nfsd.send_implementation_id"
> and build time Kconfig option "NFSD_V4_1_IMPLEMENTATION_ID_DOMAIN" and
> based on them fill NFSv4.1 server implementation details in OP_EXCHANGE_ID
> response. Logic in nfsd is exactly same as in nfs.
> 
> This aligns Linux NFSv4.1 server logic with Linux NFSv4.1 client logic.
> 
> NFSv4.1 client and server implementation fields are useful for statistic
> purposes or for identifying type of clients and servers.

NFSD has gotten along for more than a decade without returning this
information. The patch description should explain the use case in a
little more detail, IMO.

As a general comment, I recognize that you copied the client code
for EXCHANGE_ID to construct this patch. The client and server code
bases are somewhat different and have different coding conventions.
Most of the comments below have to do with those differences.


> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  fs/nfsd/Kconfig   | 12 +++++++++++
>  fs/nfsd/nfs4xdr.c | 55 +++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 65 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
> index ec2ab6429e00..70067c29316e 100644
> --- a/fs/nfsd/Kconfig
> +++ b/fs/nfsd/Kconfig
> @@ -136,6 +136,18 @@ config NFSD_FLEXFILELAYOUT
>  
>  	  If unsure, say N.
>  
> +config NFSD_V4_1_IMPLEMENTATION_ID_DOMAIN
> +	string "NFSv4.1 Implementation ID Domain"
> +	depends on NFSD_V4
> +	default "kernel.org"
> +	help
> +	  This option defines the domain portion of the implementation ID that
> +	  may be sent in the NFS exchange_id operation.  The value must be in

Nit: "that the server returns in its NFSv4 EXCHANGE_ID response."


> +	  the format of a DNS domain name and should be set to the DNS domain
> +	  name of the distribution.

Perhaps add: "See the description of the nii_domain field in Section
3.3.21 of RFC 8881 for details."

But honestly, I'm not sure why nii_domain is parametrized at all, on
the client. Why not /always/ return "kernel.org" ?

What checking should be done to ensure that the value of this
setting is a valid DNS label?


> +	  If the NFS server is unchanged from the upstream kernel, this
> +	  option should be set to the default "kernel.org".
> +
>  config NFSD_V4_2_INTER_SSC
>  	bool "NFSv4.2 inter server to server COPY"
>  	depends on NFSD_V4 && NFS_V4_2
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index b45ea5757652..5e89f999d4c7 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -62,6 +62,9 @@
>  #include <linux/security.h>
>  #endif
>  
> +static bool send_implementation_id = true;
> +module_param(send_implementation_id, bool, 0644);
> +MODULE_PARM_DESC(send_implementation_id, "Send implementation ID with NFSv4.1 exchange_id");

I'd rather not add a module parameter if we don't have to. Can you
explain why this new parameter is necessary? For instance, is there
a reason why an administrator who runs NFSD on a stock distro kernel
would want to change this setting to "false" ?

If it turns out that the parameter is valuable, is there admin
documentation to go with it?


>  #define NFSDDBG_FACILITY		NFSDDBG_XDR
>  
> @@ -4833,6 +4836,53 @@ nfsd4_encode_server_owner4(struct xdr_stream *xdr, struct svc_rqst *rqstp)
>  	return nfsd4_encode_opaque(xdr, nn->nfsd_name, strlen(nn->nfsd_name));
>  }
>  
> +#define IMPL_NAME_LIMIT (sizeof(utsname()->sysname) + sizeof(utsname()->release) + \
> +			 sizeof(utsname()->version) + sizeof(utsname()->machine) + 8)
> +
> +static __be32
> +nfsd4_encode_server_impl_id(struct xdr_stream *xdr)
> +{

The matching XDR decoder in fs/nfsd/nfs4xdr.c is:

   static __be32 nfsd4_decode_nfs_impl_id4( ... )

The function name matches the name of the XDR type in the spec. So
let's call this function nfsd4_encode_nfs_impl_id4().


> +	char impl_name[IMPL_NAME_LIMIT];
> +	int impl_name_len;
> +	__be32 *p;
> +
> +	impl_name_len = 0;
> +	if (send_implementation_id &&
> +	    sizeof(CONFIG_NFSD_V4_1_IMPLEMENTATION_ID_DOMAIN) > 1 &&
> +	    sizeof(CONFIG_NFSD_V4_1_IMPLEMENTATION_ID_DOMAIN) <= NFS4_OPAQUE_LIMIT)
> +		impl_name_len = snprintf(impl_name, sizeof(impl_name), "%s %s %s %s",
> +			       utsname()->sysname, utsname()->release,
> +			       utsname()->version, utsname()->machine);
> +
> +	if (impl_name_len <= 0) {
> +		if (xdr_stream_encode_u32(xdr, 0) != XDR_UNIT)
> +			return nfserr_resource;
> +		return nfs_ok;
> +	}

IMPL_NAME_LIMIT looks like it could be hundreds of bytes. Probably
not good to put a character array that size on the stack.

I prefer that the construction and checking is done in
nfsd4_exchange_id() instead, and the content of these fields passed
to this encoder via struct nfsd4_exchange_id.

As a guideline, the XDR layer should be concerned solely with
marshaling and unmarshalling data types. The content of the
marshaled data fields should be handled by NFSD's proc layer
(fs/nfsd/nfs4proc.c).


> +
> +	if (xdr_stream_encode_u32(xdr, 1) != XDR_UNIT)
> +		return nfserr_resource;

A brief comment would help remind readers that what is encoded here
is an array item count, and not a string length or a "value follows"
boolean.

Nit: In fact, this value isn't really a part of the base
nfs_impl_id4 data type. Maybe better to do this bit of logic in the
caller nfsd4_encode_exchange_id().


> +
> +	p = xdr_reserve_space(xdr,
> +		4 /* nii_domain.len */ +
> +		(XDR_QUADLEN(sizeof(CONFIG_NFSD_V4_1_IMPLEMENTATION_ID_DOMAIN) - 1) * 4) +
> +		4 /* nii_name.len */ +
> +		(XDR_QUADLEN(impl_name_len) * 4) +
> +		8 /* nii_time.tv_sec */ +
> +		4 /* nii_time.tv_nsec */);
> +	if (!p)
> +		return nfserr_resource;
> +
> +	p = xdr_encode_opaque(p, CONFIG_NFSD_V4_1_IMPLEMENTATION_ID_DOMAIN,
> +				sizeof(CONFIG_NFSD_V4_1_IMPLEMENTATION_ID_DOMAIN) - 1);
> +	p = xdr_encode_opaque(p, impl_name, impl_name_len);
> +	/* just send zeros for nii_date - the date is in nii_name */
> +	p = xdr_encode_hyper(p, 0); /* tv_sec */
> +	*p++ = cpu_to_be32(0); /* tv_nsec */

We no longer write raw encoders like this in NFSD code. This is
especially unnecessary because EXCHANGE_ID is not a hot path.

Instead, use the XDR utility functions to spell out the field names
and data types, for easier auditing. For instance, something like
this:

	status = nfsd4_encode_opaque(xdr, exid->nii_domain.data,
				     exid->nii_domain.len);        
	if (status != nfs_ok)
		return status;
	status = nfsd4_encode_opaque(xdr, exid->nii_name.data,
				     exid->nii_name.len);        
	return nfsd4_encode_nfstime4(xdr, &exid->nii_date);

Regarding the content of these fields: I don't mind filling in
nii_date, duplicating what might appear in the nii_name field, if
that is not a bother.


> +
> +	return nfs_ok;
> +}
> +
>  static __be32
>  nfsd4_encode_exchange_id(struct nfsd4_compoundres *resp, __be32 nfserr,
>  			 union nfsd4_op_u *u)
> @@ -4867,8 +4917,9 @@ nfsd4_encode_exchange_id(struct nfsd4_compoundres *resp, __be32 nfserr,
>  	if (nfserr != nfs_ok)
>  		return nfserr;
>  	/* eir_server_impl_id<1> */
> -	if (xdr_stream_encode_u32(xdr, 0) != XDR_UNIT)
> -		return nfserr_resource;
> +	nfserr = nfsd4_encode_server_impl_id(xdr);
> +	if (nfserr != nfs_ok)
> +		return nfserr;
>  
>  	return nfs_ok;
>  }
> -- 
> 2.20.1
> 

-- 
Chuck Lever

