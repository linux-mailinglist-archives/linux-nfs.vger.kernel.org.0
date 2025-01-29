Return-Path: <linux-nfs+bounces-9757-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E3AA21FEB
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 16:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 125673A5472
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 15:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BEE192B81;
	Wed, 29 Jan 2025 15:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TXtbNPgy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BKur8V6L"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C8A4C83
	for <linux-nfs@vger.kernel.org>; Wed, 29 Jan 2025 15:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738162934; cv=fail; b=C7tvtGeLum7TDMZ3gP7kvArgSqjKQ+dJcx03hmIXMDUs8HYCsT6aC/4l8HNQa2UZLxVYmC+sDTQZGXh5tAOmHaq2XWFG875ImnktQ6gFIf1b/OKrkjh7VtWpUfN1qXxyFJhMqvhz4U0q+Lu5mdHWfKAkR9zT81+sSM95O1uWADw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738162934; c=relaxed/simple;
	bh=rzM6sDIwnDPXuBA+430SMlisyKK9RXYShxQIZp0F9dE=;
	h=Message-ID:Date:Subject:To:References:From:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=Xu+dDnXlAeZHlrA6jB8Y90ni+d0V0CVm/0pPHIlVLYoj48jD3GQOw4I6xI4TXBJc9+H5kasXwW7jnZNyXY8FnjLtl7blHwLZ4gTmqX8gmR39SMwBBbX3D0iVNdXMEkk7dlSXZozjmmOvcpim3qoPOxrA1P7jDRvT66/4/mq4QYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TXtbNPgy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BKur8V6L; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TEY03K006478;
	Wed, 29 Jan 2025 15:02:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=DUOqVzJwpnd14PnNVlwCjbB168JTmzZcTibvu38dQGQ=; b=
	TXtbNPgysBHqUk672UqzzjQTkQ9Ef+YcZPNkAnGJVRsQqQDupvqNR57FuxAEGcK3
	APOVbsDWVNv9iuVhHEGsT8Bm94Pd+L2vN+2JXDsHNOcvkXfCC6oApKusEdWGEzgs
	ON+zPINPhezqjfU3I1AEnCs/ShYLu94JmAsrVQRL9LciPitCsauoHzb+VO9WXMXe
	VJ9vIlWiIDK3BsVRb/UjdN4LOlLHJ58aJTl6wZu4pZSb5xvfhDJV2IIYRHOFlMRx
	R762+4P21VPkjTkuTdRrbpoqPEGYOHd/NJZ/jQYJ8ZLZStnvVhiAxp7vhMsz/qH+
	7YE3K7bq2eMq3VNlKE6rZA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44fmut88dw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 15:02:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50TE2FMc036790;
	Wed, 29 Jan 2025 15:02:10 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44cpd9t8y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 15:02:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rG9m75+DvBSeDkQMSpLdEIIPrOnHq49HYNecmszl3IZt6CZUw+xoeHjrOpQgnaBHku9bBPoWZGWfzxlLCgMq93zxOO/uT3zz1uoHGZ+SyIdWP3cDQOZVJT9v/d9dWwljGS3s67X7S79bnwEl7rM1xhlxkgHTrHx3lIlDpKbKwKVd9y96sL5lpfV18xQ2XMpOj7pieOrJVfM7uwu4nwu6m1i3yRQfP1uQRVKX10oeISqp6WwFQ+y/SPAlUPtjawBsiipXovGKYatBdMVwyfCG/8VcQ6dKiFs5289aPkdECWSEMabDD/x7bqJV+ZdGX7845hDxQbC2X6s3u4ofDfdl0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUOqVzJwpnd14PnNVlwCjbB168JTmzZcTibvu38dQGQ=;
 b=zUQt4JtwLVJpw5fhztHix5rdrnmT/kvA0XS/vIHSONPNuGK31hZRBzRiuKYz56ZZC2klDiv8rAsWBokz5iX9hhrvau21qc/wRgP0Nq2INHnwIhoM5vTymIxAhKfdX02eU2o1Oxlst+dCfgwX+36rvEUQYaLpsWGfHPJrZfziVOGdHSP+3rBKSkWPR+jSi4aC6No3CGL+//VP7DsjLL4TKPDkHsZtZbOS9MsIyhhgASim4bMIWJhow883nQJaB8w1gmqx2JRryQBP7ssVQ6mUhVhpepxcOhDl9VSOWPj5fDlyBCdqZdSTaOL/pTy4PlyviEWeZHgWdzTgMZU6nuOMZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUOqVzJwpnd14PnNVlwCjbB168JTmzZcTibvu38dQGQ=;
 b=BKur8V6LrZLnQy5Q326yUjJ9r79Vz7mxU8yWtXWWTt268RoDD5PNIVhicPXvSw2A6ox+nnvSbEWJnffeIOyJLhRBJnLqhaxylht4LkjIECIrycMhP1rAnlIJ0hjqa6ivYlgYF2fV6TZkPysQuVaQCqchMVBJMAa7nXpeQseNRnM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB6328.namprd10.prod.outlook.com (2603:10b6:a03:44e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Wed, 29 Jan
 2025 15:02:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8398.017; Wed, 29 Jan 2025
 15:02:06 +0000
Message-ID: <9138cbb9-b373-477e-bcc4-5a7cc4e16ed5@oracle.com>
Date: Wed, 29 Jan 2025 10:02:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Increase RPCSVC_MAXPAYLOAD to 8M?
To: Cedric Blancher <cedric.blancher@gmail.com>
References: <CALXu0UdddwbzGUUzKdbxpb-yC-FVMhbdcd-P+OLSDNvjZeByGw@mail.gmail.com>
 <CALXu0Ue+w_P6P_yyVR1y85bKXxkorGrctJ4jiTBctQd8ei1_kw@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
In-Reply-To: <CALXu0Ue+w_P6P_yyVR1y85bKXxkorGrctJ4jiTBctQd8ei1_kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0355.namprd03.prod.outlook.com
 (2603:10b6:610:11a::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB6328:EE_
X-MS-Office365-Filtering-Correlation-Id: 29ae2842-b6a9-45b8-d120-08dd4075e5da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0NPOWJDcTBFd3NQQm05TzNBQU9QMHE4VDgvN3ZzeGZETmtMSVk2ZVFFYnhx?=
 =?utf-8?B?ZlBzcy9mSm9zalB1WHhLOFZRTndkSkJLVy93cDN4SDdkbW5kNGhJVVhVUVJ0?=
 =?utf-8?B?VzdOeFhaUzdqdjlVbXpzdUFGaDZ3MzNEL0ZIVFlYc0NLNVd5alJEQTg5M21O?=
 =?utf-8?B?Z0UveWZxOVZTajhhWFRnUU5taUtsRVJjNk1ITDJFODF0RDQzSWVTVGtMNkpr?=
 =?utf-8?B?RFprZ0tEYkVWcEpkb3dhaFdKKzdnV0ZtQmlvaHlreFR6R255NC9HLzExY3Yw?=
 =?utf-8?B?UTc0a3pNNksxOTdDcnJkZGlGTjNGVTN3WU8zcWNXcjlsRkZGK09JVGlJOVFF?=
 =?utf-8?B?U0tpUWtuNThNdzJDRHoyWndTa2VPM0s0Z2IzRkNDc2ZMMWNmb1VOU2JOc1h6?=
 =?utf-8?B?QjFtQ1VPMG5ZSnR1S2xwWWJYZmFIblBoL3JjbHVxbWtDWVdJMlhobzN1WHk3?=
 =?utf-8?B?SWhjS1Z3NmpSRnlHN3o0T1F2dW9BOU5jTlhTRDJNR3Y0ZFB2aFhmQzFVVkZE?=
 =?utf-8?B?Vnl2TUFnMXdoQWZudVBKUVV5RjNva3FVbjFab3hQVzFpeDVucERFd0FKQVJD?=
 =?utf-8?B?N2MwR0RzZFRvSzBOa0ZuSi9uRlNnSXVEWnJmVkdpMll0WUV0WWFDSE1mZG1B?=
 =?utf-8?B?SmpEMzVleWdqMUxGTkVXYW56LzF4K1lkSXk1UDRQU0QraWRNSnlPSUI1UURt?=
 =?utf-8?B?VkpYTFo1MllVbWFWaytaTzVzWWZaQjdYeVVwUm8yWG9sYkc5aDVsL0UrcWhC?=
 =?utf-8?B?QUJSUmdJR0daT2h2ay8wS05JNjlacVBZSDJ4dTdwODJidTJYV3ZZcUFiVFQr?=
 =?utf-8?B?dUo3VHZuT1ZWbHNZc2x3K05qREkyclB1R0JER1V1VDhRNGtWOVY0c1YxZ2wv?=
 =?utf-8?B?eC8xY0pyV3k4STlleE42VmZJUEd6UnhQOWx2UXBIYTlZQzluVlhielhEMkRV?=
 =?utf-8?B?SHI2dlJRb2ZaTlRBR1BOSWhsSU9uS0FFZElubUZsOFNKbHVxakRzY1RpT2Ju?=
 =?utf-8?B?bmZWbXdPaitFM092SVYrNDVvRXlPSWdFd2Fsd2Zwa2VMWHFmRzE3Mng5Z0Vs?=
 =?utf-8?B?L0tNQWpIbTBKcGUxV296Tll3MWFBVTFSc1pDazQybmd0T09EalNLbytSNmQy?=
 =?utf-8?B?YXQwVE84L2RKOTdDMXBPVVJRVzlGWDFhWFZyck1SWGFEb1AwM3BnN0k1alFZ?=
 =?utf-8?B?Z0x6ZUxOZjc0dFIxa3VnY0N6RHlBbVh4aGdiYmdmSmJHYmNCUXhmMXZneGdQ?=
 =?utf-8?B?UDV2MHZBYVFTZDJ0VXBCamJsYXE2Wlg3ZThWbXh1cTRTenZPZDhpNWhvU2kv?=
 =?utf-8?B?dHNLSzBiMk53TWZSWHRoRzh3anV5dzB5M1Y1YkhWa21RcjcxQ3NmYU8rZXpL?=
 =?utf-8?B?clJEWGlKNWE0SDEyQmR6bDNCMDVoLzlBaEZ5d0dYOWUzU3h2NjFsZFEvWEJ6?=
 =?utf-8?B?MXpoSHBpWkx6UEdrT050ZGNFOHkvekFmb2dqVUxHYVNmdGNBTzY0K3N3cDRs?=
 =?utf-8?B?MkJmN0RMUGZ2TnZhWXBYL2pFTld5WTcyaXJuWTdLdU1NVGtRUXZjYXJ2UCtp?=
 =?utf-8?B?OEFqRnJxMkQ3b0ExdnFuSlo5c1pPcE9kbDZEWkVXWmh6QjBjQUJnWXpCQytV?=
 =?utf-8?B?VVBPTnFqTjVHd3VtMStic2k1b2ZYTjVCellSZmUyRUlkV2RLa3JYSjUwOVVi?=
 =?utf-8?B?ZmxwL2dUQlcvR2kybGI0Rms4NkFEbkxEUjRoUkgwVHFuSEFuVnEzTHJSZnM2?=
 =?utf-8?B?V25YeEN4SEorMytGcmZyYVhFemdQZU5OcXNSWFphUnRSMmVqb3U1Vkpxd2xL?=
 =?utf-8?B?WmhFUk00WTZiMzRsQjlXbmRuMzFqd2lJVnVGQ1Irb2d6MkNKS0JtVHVFam1x?=
 =?utf-8?Q?vZ2lT6a8WkFUq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEZ0b0RPUHhTbDNtU0VwVUF0ZzMyV3VYUzRrNUw5citZdndUQWUrQUxsSjBr?=
 =?utf-8?B?YzcrN3ROK1JSRG5vdFlMblVVKzRaL014dVY5dmNOYjFjMmV3MXNNT1hnb2h3?=
 =?utf-8?B?UjhpcTVaa3lCeUpTeitjZ2JpNWtMN2w3aEZzc2dqNjlobGU3YWxKR0U5UWN2?=
 =?utf-8?B?N2lteHBYTVozVjBmempVNG15Mk4zQmd2MWQzQ1picmJVSzErM1Q3ZnBpN3FG?=
 =?utf-8?B?NmNLL0pJUzNzenBuSzdGSk0rdHcyRUdVYnVPa3c0bXNNdTFCYVlxOFJpK0Vv?=
 =?utf-8?B?MEEzYTNtQjV5Q3YwUEtqeGVYYUcxSWNLT1oveHF3NE1TRXltZGVhSlNWUDNZ?=
 =?utf-8?B?K0tZQkQwRlhGVGlvaEpXalZjVjlVbWlhN2l1dldEL2t0VHVZK0ZRdFJMSHV3?=
 =?utf-8?B?clhKSkZFUkhEQmxCRWUraVF1dy9HZjhXZUk1TjAxWWNrbnE3dU9oZzhZTEkr?=
 =?utf-8?B?RXl6TE5QbkgxWUVKVDJGMVNoMDBINXlySEhaTkJCZHBENkdYVnp5c3lXdGE4?=
 =?utf-8?B?dUVPY0dpVU9Wb1pmR01GaEFEUDZBVUg5MXhoS04wOHVEZUZmUnFHMW1qVCtK?=
 =?utf-8?B?anQzMnpwVHdyMWNwejFqTTlnSGpEclhqTmxPbGYvd3NRYWg5SmNkNFZRRzFL?=
 =?utf-8?B?V1JjRnhvZDlVZGpCVDlMVHA0YVkrb0pURldzdnlKWERHbmx1Qm5mdEtmeEFz?=
 =?utf-8?B?dHBiNVQzSzNpY2NYZTJNdEowYTN2MmtSYkdqSVVZQk1uajZaT1ovSWgrdjZ0?=
 =?utf-8?B?Z1FSSUtZQUtYQ0ZRSURUWnE2dnNwdWNzNkhnaGFOdnRkemV1bGcxYzRhZ0Vv?=
 =?utf-8?B?ZHVIdmtkaTFVOVY3WGF0K0Z6U2Z0VW1oYlpBa1BrTklOK0RvS3V0bUtrZFJv?=
 =?utf-8?B?NUpBY0hzVDk3U1l3WnA0TzRpNjY4MU5kRXZxTzVtYmN1a0VScWs2SHNWMk9y?=
 =?utf-8?B?U2tGaHNFVFZlRGNRTlpwUFRFRWNMVGtSMTZ3aFg4OU1rd0xVMzhMNzVlaWdU?=
 =?utf-8?B?SDNuNHp2dGwzMUVWMnJpeHY2S2YvUFhVWXNadnlxY1hlcklOcXJqdWtTWUw3?=
 =?utf-8?B?Z2MrdFFFVHQxR2o4dVpSR0FJaDBMd3RnT29LRDRndElsU0hOSmRPNGFKVzg3?=
 =?utf-8?B?WHFCQjFRcVhyL2wxWUgwTVhzazd6OWMyaVlVeTMzZ1RtMW15bEZOZUNoSXdi?=
 =?utf-8?B?VDNGbFFuVm15TkxjUlk4VGtrVGM4c1k4Zk5CUjIrNVpjN3pUbWl2czRsWUpX?=
 =?utf-8?B?aHlsMUZGSkVrTlExZ2pGWTQ2RVo4bkJEeWF4cGxGZHVaYVJWUitEa1kwelJt?=
 =?utf-8?B?dDZDblVieFUrV3lDQjZsOHcyeEV6bjhrZUUxb3lTa3JZTEl4S1JEZUg0Z3k3?=
 =?utf-8?B?NWlXd3VEZmpvMGUwbHRJelJqazQrUzQ4STJxRlhwSTI0UCtTd25zMk1iY0hL?=
 =?utf-8?B?QkdueGw4N2puS05FWmlwVm4rYndselNiVHo2WTR5ZGZqRjZOM2Fjck9EVnJT?=
 =?utf-8?B?dnhuRGFJOFlqb3d4TFg0NEZtYm02ZWgyMnU5L2hJVHhVMTU0dHpGb2lDcXhU?=
 =?utf-8?B?VThNWUJMaDNOeWtYWFA4VUI2MWJsVkVqMG9CZ2E0TzlONTBBMGoxNTJrUnNY?=
 =?utf-8?B?dzQ2N0JOM3JEdWkyQmtUZHpCNE9UQktLZFAwa0RzQ0JPWU1COHNBVWhyMnRI?=
 =?utf-8?B?eHJBTEc5VytpaTVjb1VONGs1bitsMnRWUHJldVZxUityTjQySENpWnI4VVJI?=
 =?utf-8?B?VVVQT1BZZlBLbU8rRVBkVnEzN0cybkQxa2wreG9vazJLVWVZeEZVM3ZKVG1B?=
 =?utf-8?B?dUpyU2kwMW90S3BOWUtTZU4wL0VrekFETWNFTWxOSTdoOWdWektzSzdURmlQ?=
 =?utf-8?B?UDFsVFI4R0p1ZCt4a1REZHppZFpwNlJCTnVnYldjcGRHc0p1QnNBN2JyMm1V?=
 =?utf-8?B?dDRFWUxuU2NFcS9IMEVkVHNTdk1VajBlL3VHQlBOd2gzZHpjUWVkL1h4emdN?=
 =?utf-8?B?K1FMSFovTTJ5em16N2g1SE0rOGIwQVNWMVFlSzdVbjRueDhoSkxOMlZWU0g1?=
 =?utf-8?B?ZXdkMDB6NjJSNTd1UjZxdFRVNDRsWVFFWlF6K0YxSE1ta00zOHRGVE5KV0lY?=
 =?utf-8?B?TW9mVjFIVHhwSWwxMms1VVU1UTZncDJraXhDQnRrMVU0cElaV1o1SUsxNUpU?=
 =?utf-8?B?dEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	S2TYP6ZSQIM4FHxgMfMCEsp3DsOwNS67M/Id+XIxve0obrwkd7TZkuNv+3/mdPQ/qmpsz6NHpOJVKYOIc0gDqokxKTgT1FCaKRuFYU4bjkeW9aSTBUmvS7M/TG0odjydKp49Pts6/KObLkc98VCtZhEOeJr8sCpFMT0llQzBEiC2h+ghYfg+vgQ/Zw8ycZDIDZ7P6XyNHlT51yLTEdkNf80RoNYwK0ziWRnMUMDEM/Wo+dzwzXiAeqOMleN+T0FjFfK11l4IoQYzE1uhkQ1RqtXoYQITWIVo4/An++1d8ZqTSo7c6ebU+lDXhSxJDcMCnRMpbs3fSehcBKEYRL3BtEz9uUlOwmERyc5BrKxWA8VxLsVPnLvgwawCftwXVOL6Hldbg6YJwGMcbRl/UAOLUAvUpbveVHQj+gbvCfsemKLJ1aD8PGYIm2xos5sZgJQvm0X3uHGJbvhxrJfxX7q3EkN3vW9JPs4TfAl+l5kR3tTFbTln9GE9s2vSuzuT9o9zSMMvhI6g8SKY8GsxG1jWYv6trO6KMcGuzEv0RuWa6y05eLkZv+WasCW7DJ5TKGxgAbSFTlT8tJ/zQGA3Mli8GSNgZsZYkKkYVOpy+oVwXEM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ae2842-b6a9-45b8-d120-08dd4075e5da
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 15:02:06.9215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EuOPIFOj+VgFSzO/bZz4U8FxnfSLTElBHWPf92/qfSK8m7z2yM7sjprk0tHrqRMlc0hLh1BOmjMXEOVUN2E+YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6328
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_02,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501290121
X-Proofpoint-GUID: kjt95xPkZDyJ7Hjv26rZYiCcI-dJ7xL4
X-Proofpoint-ORIG-GUID: kjt95xPkZDyJ7Hjv26rZYiCcI-dJ7xL4

On 1/29/25 2:32 AM, Cedric Blancher wrote:
> On Wed, 22 Jan 2025 at 11:07, Cedric Blancher <cedric.blancher@gmail.com> wrote:
>>
>> Good morning!
>>
>> IMO it might be good to increase RPCSVC_MAXPAYLOAD to at least 8M,
>> giving the NFSv4.1 session mechanism some headroom for negotiation.
>> For over a decade the default value is 1M (1*1024*1024u), which IMO
>> causes problems with anything faster than 2500baseT.
> 
> The 1MB limit was defined when 10base5/10baseT was the norm, and
> 100baseT (100mbit) was "fast".
> 
> Nowadays 1000baseT is the norm, 2500baseT is in premium *laptops*, and
> 10000baseT is fast.
> Just the 1MB limit is now in the way of EVERYTHING, including "large
> send offload" and other acceleration features.
> 
> So my suggestion is to increase the buffer to 4MB by default (2*2MB
> hugepages on x86), and allow a tuneable to select up to 16MB.

TL;DR: This has been on the long-term to-do list for NFSD for quite some
time.

We certainly want to support larger COMPOUNDs, but increasing
RPCSVC_MAXPAYLOAD is only the first step.

The biggest obstacle is the rq_pages[] array in struct svc_rqst. Today
it has 259 entries. Quadrupling that would make the array itself
multiple pages in size, and there's one of these for each nfsd thread.

We are working on replacing the use of page arrays with folios, which
would make this infrastructure significantly smaller and faster, but it
depends on folio support in all the kernel APIs that NFSD makes use of.
That situation continues to evolve.

An equivalent issue exists in the Linux NFS client.

Increasing this capability on the server without having a client that
can make use of it doesn't seem wise.

You can try increasing the value of RPCSVC_MAXPAYLOAD yourself and try
some measurements to help make the case (and analyze the operational
costs). I think we need some confidence that increasing the maximum
payload size will not unduly impact small I/O.

Re: a tunable: I'm not sure why someone would want to tune this number
down from the maximum. You can control how much total memory the server
consumes by reducing the number of nfsd threads.


-- 
Chuck Lever

