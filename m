Return-Path: <linux-nfs+bounces-15961-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CFCC2E0DD
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 21:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D1A054E0213
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 20:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3782C08D9;
	Mon,  3 Nov 2025 20:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DlZLrcW6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KxAm/vLu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652B9274FEF
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 20:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762202670; cv=fail; b=iakrHlHTIgKq/1VhXZd/rES9Q553Fvs3z61DM3Uiwq3ZAHekIHgAQ9eC+UMUkp/KrcbOsrPzK0wgqVs20K6iJd0k2GeT9pmDaULoTXpOTrkpOMsrhF5lba528eF8r11WKhl7QsKJqGgKOQOWr3DBhJZQllJQsbbsC9CeXYpNI38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762202670; c=relaxed/simple;
	bh=PXCVX5kBJnKrdFmcMz+UzsYdI/eTvkKiiApBb6CB23o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pSrKVduhHLNPshP30rsQqlV3rab3nqQJNEWk7/LjYms8sHVPh6PqhxZVmfil3CiOYaFiaLMO2C+zyCyq56fENFR21kVOUNwMRVF/eCVAgAPMxKkpQhagMbpcQR23odlZr9mSG5DJQtA5lWsdQ9QNqCaKx0kDCwIN402+CS0RFTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DlZLrcW6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KxAm/vLu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3KdWen007370;
	Mon, 3 Nov 2025 20:44:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qKRka5X9JyXE6Llfdo2fxLNDIb2v+Hh1kXFYNlyb/Dg=; b=
	DlZLrcW6tLu9sYbQ1bShqdaQvQv2xKUoSDaVMnx4rLjg9lgTSftlvexT3FD+UYub
	ZT6x8kyJ6knxEBoHGKhIvzJXQ7XvWDrDSsZUKqbrXYD6yOD1bemd46UYSKeruBPZ
	kuAuCFYyedmU7rCSKnuck4j+ThO58L7wQHWu/mn5yTW0UIhK1lC3Noy95j01WAai
	v1KmAr8kJfFhFhhu4Q52LxuXzqR0m3d5M1h0jrnUicERlLAz7jmkQMCb1Yt2h0oq
	7Eyo+S21kwsaCDpqzF7PVTemvnZWCFukUUnKC3Fs5ZBgoBtUW5gcbjJg+mK4qPYY
	p3EcXXmCICq3j6yYBgnjkg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a73mer07q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 20:44:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3KWJQM009599;
	Mon, 3 Nov 2025 20:44:21 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010034.outbound.protection.outlook.com [40.93.198.34])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nc6u8y-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 20:44:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tdydlf4Nk3Y5kmPF8FWBPVAECIDKGyZqjGbJobwgycCZvOjXdzGJTAJLWm96rHIYFCWAXcbMkKyl093zaXorer+g38Uy+x3pGS+xH1VXbc3mXOIsW/8LdxzEPoyIAYkCIdWLXVVtIFhds5dDR/cu6rGL8zOM4u5STjuPjHwO5nOyH736rLeWPZLygGJyrrUgnILMBQtyfmxTIWIJHfAJD3toEzbS5C8SNBt9xtHX1Z6msyv2ZXHnA7cdvz24i38+bz+4mHVzTl40E9ccAlOzaIyXowwLBiDgTV/Lsi4zwJg9qtfJlICpuQMcl/s4rGiwqbbOBWbS29C9fWieN18++A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKRka5X9JyXE6Llfdo2fxLNDIb2v+Hh1kXFYNlyb/Dg=;
 b=nHyqI2NyUdbyhaOHi7ffZ1O7zdujHgK4M78XkFxh8QsLp8QHcYbsdgimxy4bS/KiM80xQYyCTvaz37Cdpxzcr6uYWq9X8TUFjEqA1ukL2OudjsseDsIMfUKFsnC3Sh5zf68rgWvmImP6/9JjP+hDhT/ncmiXhrV1FI1jek4gB6z77a7mTZrAZZFndfYZOlrpKtRfGTPmEmOtb1yf57rSY8sZ5XJ6xNYmss+fDCp12KUKevvPmIPB4/x/IcRFNOOoHRmPxg56v5nSrSisHBVIFKio9FutW0xjoFEqF36+nOZqFeBiiYLrSAtuf+KL4+Q2NtxJXIlPUSphWjoPJmIoDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKRka5X9JyXE6Llfdo2fxLNDIb2v+Hh1kXFYNlyb/Dg=;
 b=KxAm/vLuJlxf5CER6D9m2dx64QSKYUBa/8+Ld8AfKVuJlUThG4+sjam7xU51VXwmLdAcnKj0euivFGh6Er7yHKPwScbU6/cR8ouatC9f9JuJpbsQEgPlbwauNWK0jLtgOE479Lx0Mh3gL0yz5Bin/noqf7eM4IdKo2wwfKLyEOI=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by IA3PR10MB8092.namprd10.prod.outlook.com (2603:10b6:208:50d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 20:44:18 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%4]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 20:44:18 +0000
Message-ID: <41d1baf6-15fa-44a4-9af0-907286b26299@oracle.com>
Date: Mon, 3 Nov 2025 12:44:15 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] NFSD: Add trace point for SCSI fencing operation.
To: Chuck Lever <chuck.lever@oracle.com>, jlayton@kernel.org,
        neilb@ownmail.net, okorniev@redhat.com, tom@talpey.com, hch@lst.de
Cc: linux-nfs@vger.kernel.org
References: <20251101185220.663905-1-dai.ngo@oracle.com>
 <20251101185220.663905-4-dai.ngo@oracle.com>
 <b8a55017-5bff-49f0-a2bc-6bea6df7d658@oracle.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <b8a55017-5bff-49f0-a2bc-6bea6df7d658@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0075.namprd03.prod.outlook.com
 (2603:10b6:a03:331::20) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|IA3PR10MB8092:EE_
X-MS-Office365-Filtering-Correlation-Id: 664a1732-7476-46f8-19ea-08de1b19c222
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?M0EyN2RuNFlaSzI1VmVPUE54RjlNZVQ5MzJPcUg1R0J6TXluOFRGZzZqZG5S?=
 =?utf-8?B?YU5yNWZxNE4wMU9rVVlUd0NFVjhkK2c5eXNCWTZDYnNwelZMZElweDNNNWFU?=
 =?utf-8?B?b1JnTXFtUFB0cWwyRkNuY1RTUlN0TXYvQnZnb1dHalQvcVdNTEx2dzBpZlJT?=
 =?utf-8?B?ZVNrclZsbDdrWU0rTFJqK3dFYzM5L1VlM01wZG0xVkIraURIQjJ6QWh6Q1BO?=
 =?utf-8?B?QXlyOFRUWW5hV0lwNlZYRFhoTW5EK2tDcnYraGRzNWx1WW5BVmlUUWZOb3dE?=
 =?utf-8?B?ZVczbTZmdEE2OFdPVnpKMGZ6aEdvbzRXdVhTamRJZUJqYXU2cCtTaGpyVHd5?=
 =?utf-8?B?aU9QblRlOHo4NXV4emk2WjNmZDdmbnAyejduUjdVVmlJZEovNnQ5UkFhdWJS?=
 =?utf-8?B?YmlOekZnL3MzYTJHdFE4bDk3NHNhRm02dEVNdHhDK3dQcDE2c2ZTdFpBUWMv?=
 =?utf-8?B?VTFJbDRsQVBpclEwejhjcWZWdUhIWmdnNXNyb0tNZnVRVzJyR1hIMUpUVklr?=
 =?utf-8?B?WjhsRVY3M0NtN0hLZ2xsMFpOc0hrRFFaSE83RXB5ay9zZTVqK2phWXZhbHlM?=
 =?utf-8?B?a0dTNGttNmFMSkdIcnZOMDJlWHU0T0l6R0JkcXVRSDhieXB1b2JDc2FZWURo?=
 =?utf-8?B?SGpkVHFtNWZ5aWsvNlhoWUlwUDdKaktSaXg0ZVcwU3F4UXFJZGVBVVR5UzRK?=
 =?utf-8?B?blRoTlFiSjdJck5CbjViQmQ3Y2FxMS9MQnpvOElKaU1TVDdodzBjaHVvaGVI?=
 =?utf-8?B?S2tERFI1ejdiU05UdDR6NEI1ZkVaYlZvRXZLR3FwTC9QV1Y5QjNrYjhBY09p?=
 =?utf-8?B?SFpCVkduV1FvVGhrT2tFOEs2Yzd4MUxqdGRRZmhkdlhOMzJjcSt0S3YwOWRq?=
 =?utf-8?B?UVNvSkpPUUxHMDRlc09IeTNtVllHNmVvV2FtdkRaejRJTENONVllbmpwVnpS?=
 =?utf-8?B?d0ZPV0JObXdUVk5LVDJHZUIzQXJ5RlNZZGVmZ0lpVzZvdlBqWmNtUzJUZzRR?=
 =?utf-8?B?NVkyWUprTExPbHVMejlQTGxONzh6ZXdiTm5HUm5EZWZiZzZUbmdPYS9VNFo2?=
 =?utf-8?B?bCsrYUt0RnRUVzlON0FyN2szaUtnR0tUNFJFWnhCbzQ0WnEvQUJISmtwaHpH?=
 =?utf-8?B?ZE1FeWNjUGFQVGVKRzVrOEJzU09DZFk4M0F4MDdXVGJHY2lmVXJjTlR1Qzd4?=
 =?utf-8?B?ZGJMaFMxZ0JGaVN6d1JtQzU4THdYcndDNEt6byttM2RGUGRHVHQyRG53czJn?=
 =?utf-8?B?dXZmdVhVUXBPL1ZvSWZFRjlSZzZUM3Ztb2ZqbGJzNTB1TWdEc3BSeUJJcmhT?=
 =?utf-8?B?ODdGWDM5eDArUjArOVAxZkk0OCtETTFwT3dDZ3dLVEUvRUpMR0ZaL25HcHNM?=
 =?utf-8?B?VGRDa3p2R3Y0YitoQUNHTm14RFZoOVBzRUR2TUl6WDhoQjhyWGdzTnhYVDFQ?=
 =?utf-8?B?SFcxWFhvTlFvM1J4dStTVFpabGx2anZGUFYrSVZlMExlcGxRQTFZUjlDazhT?=
 =?utf-8?B?Vy8rNlljWkE4RjhjZ0JnWm5UQ2kvMitodjBBN2ZVcHV6U0xoOS9NZGtRby9N?=
 =?utf-8?B?d2ttWUo4R3VNMXVwa2VXeWdXQ09xR3NiSlRDY1VQQTFKNzVCd1c4Mmd6OGx3?=
 =?utf-8?B?d1FtMU5zbWsxWU9CM01ZQXlVTklSZm03UHk1cTVBaXhhQ0NLUlhkQVZkNmtk?=
 =?utf-8?B?NjhaK29nZlloUUthcnJObFBCSmI0Y1pWM3BNdENjZXNneGxnMTRacjZ0aHFy?=
 =?utf-8?B?dms4N0VRQVJ5Q1BPS1lRUE5DTEpXYmE5L1V5VW16c3hFbXFMUVJaa043V1c3?=
 =?utf-8?B?d0lSUjQraHp1S1dPRUtKNk1PbWRNcXJvUy81SGFKZ3REanZNRU5uS1Q3TS9U?=
 =?utf-8?B?TDUweFhvQXB6K1dJNTA0VGlGa1g5N0ZIS0FEaTRZT0hRaEtMZWIzbDRIRXdv?=
 =?utf-8?Q?EwkGMJTBceDgHECApL1pg/VAwRhYSTrn?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ckM2Skhqa0tTdkVYL0JQcEJrc3dyUzNXa1pDR0p2T3FNZ3VJSEo2WUxCZUdP?=
 =?utf-8?B?NUZQcXZjMEpaK29WOVYxL21kVjVSOGFDbFd1UyttcDBwTHhPOGJLbURRb2hN?=
 =?utf-8?B?TFNLUytyVkRDWWwrSHBCRi90RGVFMzVMN2Z1MVhUR2NkL05nMCtJcmFrNnlv?=
 =?utf-8?B?SnJ5QmZUdzYxcWU2SUtET2I1TkJkVG1GZS9oNFV3RTFDOTVqVFJCanV3RWVu?=
 =?utf-8?B?Y1o0RGpmcXY4RW9mVHFoMVpHdEVQOWlWRm9YeitZN1RmdDVKbnZERFdZalc5?=
 =?utf-8?B?RFBGcElXNEFwNWszN1BiTHJicEZnemYzU29DSE0zeG54UWxhdmQveVlHdHQ1?=
 =?utf-8?B?cnRJWkZuL0QzTkU0cTRHbXFtREhyWm0zeGl5MGltYkFxclRTaGhFSWRLN2Yr?=
 =?utf-8?B?b1duYUNTdXVCdFh1Rk1Ld2Fwci9HMUpOQ0NuTnNQQ2YreUY0Q0FMZTd5SVB2?=
 =?utf-8?B?TzhLVEg4YkgxVDdYSlY0cGcvR296Wmh4OVNTbnBXeWpIb09obGltSUlNYUc3?=
 =?utf-8?B?dTFoblRqSnVCbFZDd0xjUitBV05MQjJObmxFV1V5cUFrN3ozN2hwdTdsUnBE?=
 =?utf-8?B?L05yVG9wVWY2aUNDa0hCT212OGt6TUVnT0FJc0psbFBPbVNqSXoyTTdEaWt4?=
 =?utf-8?B?RXV6RERkbFNsanh0emgyckdMMG51cEZGQzNOSzRLUFRjbzVnVWxGajBVMmJh?=
 =?utf-8?B?UEhYUDBWdXgzb1FtdUs5WmZzRDRXRUR2MHg2QURqall5TGZnSEVxQ2RMT3li?=
 =?utf-8?B?bTh3NUdzWEZIV0ltZHBUalhUUWx2d3JRZ0dLSUUwbGU3dmw0LzFPeDA2eW5r?=
 =?utf-8?B?S0E3bDU1REE5NG5pQlNTVndLQkFRYjRqYkFaUU5Ua3M0NXFEc3N5NStBSVRx?=
 =?utf-8?B?dCtwVGJRN3FHNW5rbTVPcm84eE1ORk1GUnpmRGJCY2w1ZWkxS2ZOblB5QnVs?=
 =?utf-8?B?YThGekNZa3Z5TWFKRnhDL1QrcXdhTHRDOFVZMXUzSHphYVR5KzgwMlMyQmJH?=
 =?utf-8?B?b2F5SnlvV1E5MVBZalFOU3pwbDZMWDhZTmlFOFZtazZJRTd0aWNnazJudjBC?=
 =?utf-8?B?bkFxSEl6WWVVei9HZWdOM2kzQ2xKMlBoTDJwckY1TUJFMW9mUjlHRHowMy9s?=
 =?utf-8?B?SjV2ekhUVkpWdVE2cFpnYlVOZ1NBU3lqSUZjRlpGVzFEUTg2bXlqVW1VRHdt?=
 =?utf-8?B?WXVRSjBLeldYdE5nWXRLTVhDeVFmK0FtUG10MUl0YVhicDlxeUh1TXBCL1lk?=
 =?utf-8?B?S0ovQnhGSGRDQ2UvakVHQkdoTEVNSFhUYU4yUmgxN0tGK2xGR004bEY2b1ZB?=
 =?utf-8?B?eU9xOFgvQ1F0R2hJN2NCRUlvSEVkT1pSN2FWNHNOeCs4VkhONkRVRTB4azNM?=
 =?utf-8?B?b0NrK21LWVJjUnNTTmwzV01VVEpwWElkbkFMaU1KYXQ5RzY4aGZQcnBHWkJr?=
 =?utf-8?B?d2J1ZDEzNWR3WXBmTnBxVE9mSURlckQ2T2pPbUlka2xOdHFNaENsc1NFK2tC?=
 =?utf-8?B?T210dHY2VmhyKy9jNWVXWnB2UWh0b3BFcDlQZGthOXNkbWh2N0ZoN2xrZmJy?=
 =?utf-8?B?L0prcUdyVXdpblhFZXhKcVhhSGhVVWh3SDZ2Nk1iSWdnV1p1ZzV3dUlFdkNv?=
 =?utf-8?B?THJ5Zk9lMlMyZVZtTzhMcktJenlrdVVQNk5tbWJBQ1cxVEpHNndQVmJCVU8v?=
 =?utf-8?B?RzdpYlZ6bEJUN29vQ3VvMWRjY0RyQTVzMGZCRzRoZS9UR3VFQk53eUd0R2tK?=
 =?utf-8?B?QUdlY2RFRVRPZFR0K3V4QVp3cThWc1lpaGpYVmExdWNoUDBUSm05Y1VQd0Fk?=
 =?utf-8?B?M1E5SUFNeGxOQ2VpdEluQlc5aFJRbkNSRDYwWGNDREJXVnZBaSt3UkwvTmsx?=
 =?utf-8?B?NzhwMmNpaWtMYWJWUzRENUplUTJLbkJBNnJvS0s0WGpndTB4Y3FSUVlUWTh4?=
 =?utf-8?B?UlhLQk9FZEJ6TCt1NG1jWW5XeU5MSndlL3pDUXVGakp0Nk9VSFBocW1KdzdR?=
 =?utf-8?B?cExKS0tDSUp0anJOVDlBeUFod1VkQVRpMGx4em5YYnZ3akRWc0hsQm5XVnJC?=
 =?utf-8?B?WWVGMTdtYUxzZGlyZlJQYmc0MU1nOC9zLy84NnV0dml5OVJmUytBNU01T3RR?=
 =?utf-8?Q?nnASf3IRuIyGHUocqL/krWXi4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0Yi0TmUplnWemPage7l/iGRu8hWjppEAc45xLY8P44ecaLK0eqUrQyKA9bpI18aPabIi6eVT/hj2XKgadpQvDe/ktMdFD4yusp4/4hSdpAu8q0CnyFnTyM+dq2MdBYj2QfB3dN55lx4dIYRcSqV/Xm1PtVJHhrcUlupm4XFgDVCnFg7rm8EnFgu/YaV+7Fu7f9hxhhrCb47ZYgi3yA/kK+Y6ckAA/aZLVgwHVjGsifJb7BwPhk5BBWxu5BHpCgK5eWB26G7sMp9yKRkL6435cGcozo+Z3QfiT/4TzioS3pZ4nHPm9XziD3Y2D2A9nSlvnjpXLy/FCjNVokjIALSxbFtALC8e5epne5yM8Xy8BPf/cOcGCAnm23mgnHV5BidJYIP/FtNicLXDyE0/jIhA+YpsYbYLzY2NvnzlZNQTce+QYqjuliVIfGnXN+rQPq3v1tpnqjOWeGxAkTXjv1toUaNxShlBweqlieWQQwN39pggwsY4DACBcQ3lJjC97RnahOCV58j5lIiFIAtxQ9MYR42q92UT7lJrcHpd8ZE0tMLu4JzMNFJZyejpfV8tmpuzU3tPejyKFGjFzFz5GwOsnq77LUGpiS1OhjnMjiHGX9M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 664a1732-7476-46f8-19ea-08de1b19c222
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 20:44:18.0374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Avs+DyLCpIFje22dmGtf3X2AnFwQxoNJJWeEZiKFwGYPRZMbvpxocSFtuhrw+MQyQr0shQ4BOO9CmxyEEAr/Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8092
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_05,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511030185
X-Proofpoint-GUID: UhGtVNqtu3JCfAYNKUJ_SLOi8l2G4YXb
X-Authority-Analysis: v=2.4 cv=D7RK6/Rj c=1 sm=1 tr=0 ts=69091426 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=sIn5yVyurPdKi46oYccA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13657
X-Proofpoint-ORIG-GUID: UhGtVNqtu3JCfAYNKUJ_SLOi8l2G4YXb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDE4NCBTYWx0ZWRfX8JeCWZKB8vjw
 TUDW7mQTVgFmEwNCMFLiyF7QH/phhKYxFKgKt2FcNkaos4pornO+4jZILH5yYl8Q9+j4MGexPFM
 APjq+BZEgN6t3YQve4SpA08VhjmSdYmu3Hh0MVqa8dpYntigVuVMyywPlvxfTGaEOF1W26o3fgD
 D4DNkGM2bvvE+k4jryICwpRf7Mp4XUNcBVda4Nq3H9mxctlBV6Xm9fYFwYdQHfRGLeiO1QIaaRF
 syWc6fttN5PKLqzLD8EWkWU4mkYugIfuwiNxcQFF8I3v5jCeprvd3kGVU6ux5ADFrXIEx8XcEtw
 hcNj+pTxMpd0hgiIY1Tw19XCmLNZhvTjIwXCJK1bINlFlrGJrfg4ctoYaq8T5NTVT38yrkA6t8T
 03HmqopkoNaEMWos331D3Kj0q7HKXCeOi1HwYo/csTOvcDOuhMw=


On 11/2/25 7:40 AM, Chuck Lever wrote:
> On 11/1/25 2:51 PM, Dai Ngo wrote:
>> +	TP_STRUCT__entry(
>> +		__string(dev, dev)
>> +		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
>> +		__field(u32, error)
>> +	),
>> +	TP_fast_assign(
>> +		memcpy(__entry->addr, &clp->cl_addr,
>> +			sizeof(struct sockaddr_in6));
>> +		__assign_str(dev);
>> +		__entry->error = error;
>> +	),
>> +	TP_printk("client=%pISpc dev=%s error=%d",
>> +		__entry->addr,
>> +		__get_str(dev),
>> +		__entry->error
>> +	)
> Have a look at the nfsd_cs_slot_class event class (fs/nfsd/trace.h) to
> see how to use the trace subsystem's native sockaddr handling.

will fix.

>
> Do you want to record anything else here? The cl_boot/cl_id, perhaps? I
> guess there's no XID available... but is there a relevant state ID?

There is a layout stateid. For the fencing operation, I think it helps
to display the client IP and the effected block device and the status of
operation. IMHO, I don't see any additional value the cl_boot/cl_id of
the layout stateid can add?

-Dai


