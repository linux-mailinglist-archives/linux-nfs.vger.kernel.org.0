Return-Path: <linux-nfs+bounces-9465-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE2AA193E1
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 15:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1ECC1888B9F
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 14:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4A9156F53;
	Wed, 22 Jan 2025 14:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C9B1l4Kh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j84bNS5x"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E18145B3F
	for <linux-nfs@vger.kernel.org>; Wed, 22 Jan 2025 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737556225; cv=fail; b=KbwPWda+U0gjS+iPRAHD7vh+enGY2QUJm/9tVjcnu+BMHK8lD+IhY1aarwvjIqFKZSCxBBkGL3DRnkCBlikks3LyTkuOa1lIjkIBXugYhHZbR5tKyEgQUpJZbbP2pQn1GPZj837TuJ/nhv6dpU52GgJceahN9AeMTp2N4LU9r2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737556225; c=relaxed/simple;
	bh=i8xJTQY6IGcTgneNv0eEdJGVCtXYnA/bCGoYRD+WXXs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ipITcU4QMuhkwVc5pAwjV7sSHrx6R3QwaYZ6lnfRjwD3UFYQx202qxG62FcxQOJei3+jMRwVHkYHibW2eFU/4cXIcPn6ZoVuE2/bXz46P+jL/QBrsWX26UUegBEV+QnGNny+Fyi+CdK5qkm6rwX51VMkPnU7/LubrS66Im375X4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C9B1l4Kh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=j84bNS5x; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MESeXd013162;
	Wed, 22 Jan 2025 14:30:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=GEE44VE0lFhKDm3gy5meCgx6+ylLAtOadUHohl2ttL0=; b=
	C9B1l4Khb3oZuSN/KxY8tfb4SyAT7LCdpeZamle0KtiR7lJJmbu2PjILf3lP3c7t
	zcZlbJ4r+z+HaWBIF0wqtuHCumB3GlQaPFLpC7IWXKJDu04OnBhbU/SlyKtXFQn6
	BmLqXly6uI5FiSnr40FWSa2uYNoeTEcfGRq6/cNy20Lj3Wt2YCwSfQxzk8lsGusj
	1gZl5f6yMVBcB6xSukPEAZHEuwVKTc1m4ZvCQNQvW/ix/W/f+Pjs8bmIc++4dHeR
	Psl4Ok3LbYHbSpGrEtXEFhpbvc5PVYhljT/HM3lRGwSnPy5Zk+EOr6GyyCmKUwgM
	bm0n6wLenFSUaRALDZDLEA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485rdfv1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 14:30:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50MCiK0w018748;
	Wed, 22 Jan 2025 14:30:20 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4491c3ps8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 14:30:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U+J8XY2xAjW9iXKcWmNr7Z8YYLWyz2YjctFwT5ORjWrlvAgERd4J7JXp8kFV8z0/0ggaxZdkTcBEZCbvCVzyRApOj0+a0/WBGsUjB56RRhp7JLQHTSDyFJH1qynl6M2cA4GFbr8TfzUfXSoMRLmLVRhjhod0On8VLp+9MOYiaiySrqymrp1KIXixIm9Z/m5ms06nhf0jGB1ILtN4G/nzRgxGFcAop2KfNjbwsBvZU63rj2u0Mro08EHyQuKLKoFYrF2cZVSRNXVtekiK3VQoI+DaPuT2N3fy95ySBhshBciTvK7ajp5IwLGrqsZPVUITrU9Tpt2WOI/JSFIyQUUrjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GEE44VE0lFhKDm3gy5meCgx6+ylLAtOadUHohl2ttL0=;
 b=tGl5Gir1rEklMQoWsQT+6HcRIC2h4CX4o2AlvDt5DIUScmaU0qeWPY36PyVOuefUZ9EHRc+qjdQPut83+a8C9eWYm101U1YpLULJI/d5/qe4mb9sn6TR8ahJJ+1vytdy1Epa8prtUsfg2dJsLXM67SK8Vei0+3kzYYbyuUd4hapMWAet5ZpF0saxM8HHBDx5kq6LUTBg33uZ/8wqSUtL0anNm/q7FO9dO2+MpK/lRAu7p2ob+HQ9Y8Zds0Uxo7FzpFoZFYC8B3zXuXVF0srH+GDW6hd58HNNhgNxuOFd6BollqdZTxZDcABc6AokE5xUxGMvRoHKJTat+jF8fO2ijg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEE44VE0lFhKDm3gy5meCgx6+ylLAtOadUHohl2ttL0=;
 b=j84bNS5xt31tz2rSJf/ERHAK8YwN5ho2dgAVT3lskJh1Z4+cWo4XKcgczPmWBhc89sAexCGFOtUJRA7p4xtyTGlKrdKSlAb1i82HYBNsbSPgCtyrpTNx9cSj4E8LsVHte+fBCVFtBmlTBufkuAFMZR8UDqSYXF6NDpEV/v2srNU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4379.namprd10.prod.outlook.com (2603:10b6:5:21e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Wed, 22 Jan
 2025 14:30:18 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 14:30:18 +0000
Message-ID: <7bc09d3e-ad27-449c-b555-24f2647dc281@oracle.com>
Date: Wed, 22 Jan 2025 09:30:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH] mountstats/nfsiostat: when parsing the
 mountstats file, only keep the nfs mounts
To: Frank Sorenson <sorenson@redhat.com>
Cc: steved@redhat.com, linux-nfs@vger.kernel.org
References: <20250122033408.1586852-1-sorenson@redhat.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250122033408.1586852-1-sorenson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR12CA0021.namprd12.prod.outlook.com
 (2603:10b6:610:57::31) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM6PR10MB4379:EE_
X-MS-Office365-Filtering-Correlation-Id: aec39ff9-d9ce-4a7e-e55f-08dd3af14b51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S05GUVU4L1k1NnV0OFQ1QVlNUkt4a2Y1YUpxb1lQSG9ZWHBLKzd3RDlwckdJ?=
 =?utf-8?B?emw0c3p2RGE4aUlyMXM4c1Q3UWF5Y3NralZ4M0NudVU2bmFqdnVZNWdJQzVP?=
 =?utf-8?B?d3hPQXVjRGE2TmdvdS9sMG9pdkkrV000clRKSmRId21XZXdscU1iTXdoVGVn?=
 =?utf-8?B?eEhiNE0rODZZVThQUm5vVGtES0JjVzZ5NTl6UDlaWVEwTVl1VW5UOWJxdWk2?=
 =?utf-8?B?NE1PQnhzRmlERFEvR2xkaDdxaVllQlVCMVU5bzVNeXg0NlFBclZML0t6dkVC?=
 =?utf-8?B?RFhicDZPZ2c2cmQ0VGU4OFZVUTdQaVVXblNvTzFVVytDNnRwKzFjQzNxUzNj?=
 =?utf-8?B?SkhYQ1NpNHE3c3l0dVZ0WjQ1bnZ5MVZDV2puelFEV1JXWHllRW5kajBaTml1?=
 =?utf-8?B?SUNEbVp1eWdPTGErd1FEZ28yeDVJODJ6dnN5ZUJvVDFETFk5ZGxiUzBmMnBq?=
 =?utf-8?B?NnZaS2RadzliZjA1N3JWZEExWTNJcktxZ2NMWHBhSjhraEN5bTZjUkIxcmpk?=
 =?utf-8?B?NUUzM3kvYS9MWXlEY1RRSFIrTkdyVGVtbFhta2Z6ajZiZk9xV3pWUHlSczJF?=
 =?utf-8?B?VVkyeWd5TlN4QmdyYXB5RGVtNk94OU1FT29zSzlzV0t4R2tNNExmZW16bkN2?=
 =?utf-8?B?dG9kc2hmM0RXd1J0ZW11cHY3dUpiaG9PdmR2M0dTaEJ1c1J3azJJSlJsQlpt?=
 =?utf-8?B?Z3Y1MldRQ2NheXpMeTVibnhXU1hIb2txdmNseXVDS3ZBMW42V2h0WjhqUHZK?=
 =?utf-8?B?NkFDNFkvaDcveUxuRnVrakJEZEdWMm1kVTNTQkVWMGJOd2NMbXlFSmhYckox?=
 =?utf-8?B?MUNtcG1ERVcyK3VkWnQyQWs2L2d5U3E4eXBsZ3UrM3R6RGwzTGlpelBNRkNi?=
 =?utf-8?B?elZjUmE0VHJkQWNmL1Nwekx3MWlhSVIzWlZXZWNhdEJCbU1TUE5waTVLVVpV?=
 =?utf-8?B?R3hkNGxVMVJNQUkrUHZKdmRieVJwWlRZcFlLNVkxdTB3YVRUUDZPamV2OVVh?=
 =?utf-8?B?K3l4b291Z1ZJQVYzNFU0dmMydU1ycDJZYjJqbkZiNFFQZ2FlZURHdUNCOG1j?=
 =?utf-8?B?bkNjYmFBTzU3Lyt4d2pCcEdhNXBvWk9ORXl6QnlvZWtBaS9rZC9qTlZ3Q1Av?=
 =?utf-8?B?c1EvcDhCMTU2amdVV25WeVpUN21NRkhsNXdlWE02TkRDaTVJTDFRNWh6b0c4?=
 =?utf-8?B?N2N2S3pFcWVnRUFGUFo1Ym5iMFhkREhPVTZqSHdNYzF0Q2dtYWs5SE9iRkQz?=
 =?utf-8?B?dmdYNXhxL3pLbWczZkNJMXZDWkVRVlM1b2gyZHl6czB2YkYxbEJXZ3VONngx?=
 =?utf-8?B?WXlhTDcyTWc5ZzBEaGxYZUFPSk5JRWJmSzZpaWhMR0xnZWVVTVJEdnZueEIz?=
 =?utf-8?B?Zkk4eFdtRXJXZnBNeG1TaWN0bFpxQnJucHhOYmZjbGhGQmo1VW51d3VuM1Zq?=
 =?utf-8?B?a3l3aTgrL2JwOXhDak9vREtPUG5wUVJNeDBmb05IYzNpbTNCcTdUa3NZZU1V?=
 =?utf-8?B?OXFYWU9xa1hzMDZVOFhZUXFHOHlKRDRpVG1ncjVJYXB3VmNuOStFbmpFNU5x?=
 =?utf-8?B?R05Sc3U5RCtrdFhZQ2dpcXZBQ1RuUnVxYm4vWEdNbzBSL3l0STM4SFVLdnR4?=
 =?utf-8?B?dmkwUDRlZ0ZnZldhVmwvUGxSb043aXF3dE1WbEZHdFRBUVdjM0lzNCtZSXdJ?=
 =?utf-8?B?RzROOGVRbXBjNXpkUnR5MnQrZ2pCb24rOGJFWE1rbndHZE94YzdPN3QwMmV3?=
 =?utf-8?B?NitaOWZVaGVYYXJBTkwrZzF0Skc3M2ttRDhjenN6UTAvamtXRnZMdmlEUzVh?=
 =?utf-8?B?aFNtU3ByelFLekZnQUowSmlVbXVEZ0pzYXI4NDlRM1cwaFEwYjVDcE5uaHZi?=
 =?utf-8?Q?EhsYdmnk72+cv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3dMM3p1YTZqcGFNTnFuUURrZ1FNY21kQzN6VDU2N0RLT0NLb0Uva1IycFNy?=
 =?utf-8?B?NTBaa3dNemlJVHY1WVlGNU90L3AyWTJDd0s2NDV6RElGNXR1Yy8xVWd3MEVQ?=
 =?utf-8?B?OXFuUG00YnU3MnB3NjFqOEZFZVlwaERyWVRDVmRSbDhUeHFyckNwUXN3c2li?=
 =?utf-8?B?dHB0cllKbUpHb0RlaHIyVllDQS94cWFocGlaUVdUbEkvQVdZQmxrb0pSUGs0?=
 =?utf-8?B?NmRmbWJkSHRldXNyVmVqNElXeUp3SmpJVVhwRjY1S1FTcW1JTjFmUUhTZkYw?=
 =?utf-8?B?b2pldjYrQmpnYkcrbGdFN3FxTmpvUHZDU0FpbjVuWHlEQWZ5SSt3dzZWcE9V?=
 =?utf-8?B?SFZ3TjB0TGNQckRBN0hrM2ZqT2dYSUZUMC9na3dHYXhVczhxaWZUa3ltNk9a?=
 =?utf-8?B?MXZzNUxDYWJCWkdhUG5WekZES1BGSGM0MnFiWmJOMVFoK21OUEdsMGg1NnNB?=
 =?utf-8?B?OWQ5dnE2d3I2OE9xWW1xMStFZVJHeGErLzR5UDdROElxSC9lZWJmMmlubDFa?=
 =?utf-8?B?c0Z5cDFtcjlUVHdKT01TQmJVVllrdTJDS1Bkb0RCWWNFLzNyWkZSTkJwUkhI?=
 =?utf-8?B?blZoUEkvN0RUWVovcW0vbGdlTzI5TXVLbUVMR2tsbUxoeUtKWG95RzByNlBj?=
 =?utf-8?B?L1V0TDlGb1AzejhwcHRXZGIzcU5rNlFXWElDSW5wdzRFNjROd0dLZTdNVnM0?=
 =?utf-8?B?SGxmcjV0TW9tN085WkZIQTQxeTFLNk9tZnI5ejdsa0JvbG10SjRDR095dzRN?=
 =?utf-8?B?TmhUTGZpUGJ0YVZzU25adFZkZVlyYjV3YlB0K1BVejNUd2ZGMG54eVhnOGRV?=
 =?utf-8?B?dXZGS285OXVpei95bWxtbHZwZFZHSnAzOGlucjZmbEFxZzIwYUxqRmUyWng3?=
 =?utf-8?B?Nkc3QUZsYWdGeTVINmJJZjc5cXV0QVI2VkFadkdqZVU1OC9ET05PK0ErVnN2?=
 =?utf-8?B?dkVXL3NXdmNnbnYybkxER3lNYmNYSndCblpGSDZxV0FsQzcwSldaWTY2TVRy?=
 =?utf-8?B?azQzYjZFS2pVTFFxRi8wUXZEMnc4c3RvRWlzVEhjT1crZ1N5NHBRQ0Z1ekNr?=
 =?utf-8?B?MUhQQXFVV24rVUJweWxzU3ZrOFRUeVlJMVJYVzh1cDgxMVU1QW50U2NLdW1l?=
 =?utf-8?B?dERDYnpLY3oyNHZubGFzQ2dYeHo5U1FiZXc2bFpwVE5jTCtKenBzZWNlNkoz?=
 =?utf-8?B?dFRhYWl5aGY1eUJBT2s3U1IzNU9VOEk4bGMxVXpZakZhc0UxWGF5Y1Awakd0?=
 =?utf-8?B?bGNncHNTTVkrY01uWGhJeVEyZGZYYlNKMlNwVmIrTTBwaDlnWCtocHpCRlZW?=
 =?utf-8?B?WGtBSjM4OElIZEhQRHB5Y3VkaVNrcEhMUHBja3JwL0tHTWtNWWZKOC9IQW52?=
 =?utf-8?B?eVErYkFzODh4dy9hUlRaUy9Zb0pYMHNTemFJK3A5L21wREhhNnZTQmhTdU9P?=
 =?utf-8?B?ZTFSUjQyVVYwdzBhSndGdDBhQ0JCalUzTWVld2NkYU5XdUIzYjZqblRpQ2JW?=
 =?utf-8?B?Ryt5L2ZSZCtiVC9zTGY3c1RYSTl4WlpTZjFQK0dJWVlVaXozajhkODBLaVhO?=
 =?utf-8?B?MkFPMllmT0pCM1lqR1JTSDdYbFQ5QmhTRkFFRWE5aDgxaXJlZ3pLZXJ3M0N4?=
 =?utf-8?B?b0Y5RlBZdVdkR29UaFVPVktla2NaSjFzT1hSWEpJTW9qVm0wNzdjSkZONE93?=
 =?utf-8?B?Q3FQdVYwOUdGNXFIOVhBWE9xTFA3SUk4QU0rL2FwTng0SkIyTURZN3lTY2dP?=
 =?utf-8?B?cGxaZW52SThUTWZ2ZjVXbmRaZlRsT3N5MFhLelpuTEh2Z0g2ODB1WFZvd0ZS?=
 =?utf-8?B?N0lXeEJKUkVXWEdDb1ByVjdDUVVOTTZ1S2ZkV3N4bVBUMnExT1ZnK1RFdUlZ?=
 =?utf-8?B?dllVWkJPeUJrdlJGeUx1Uit6OXVEOFA5TzFOeUYrUGRYVW41dk5ERnhva1Mx?=
 =?utf-8?B?RHlXanRpSVIwcnJVKzJ0Yjhqanp3V3k4TWFLMzEyK01hQ1I1YTN5UEdZNndS?=
 =?utf-8?B?dWxvMUc1SWVxU0hWVng4R0VIOWtnVjVaMGJXUDdKVmtvOHNoYjNIRmRCU1h4?=
 =?utf-8?B?bi93TEZhSHp3cU5udC9OMXVYNGYrSEoyZjB1ajl1ZExyakFFVXZpcVpKcjBC?=
 =?utf-8?B?djZQWVBEa2NkUTRXOFpqTjVpWTJzdzducFVLc3VtLy9TVE45a0VBdnl5cnRK?=
 =?utf-8?B?UXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rOfC2zN/ZPB+Ed7OqHgwpubeLNNOyyS6Hp+qD+SgXLSyZbvjpiiS9wxq9uk1QLNg13Rj//8k76sgTiR4YQu5+blDHPO0kxz3kk577524Gn2HlZXza4mnqXy1chjBR8wBygaUN4Ve1lL8l/1ysFqsrxlR4z23Eht693+Ve+qps5LK25BARJTbAoRlz9K+CQACn37yzBIZOCxE5QsTSswZZTuu+DYHhm/2liIAU5Uar+bjEpdU4ULHbDtp3mEGoolAPy8erA9n+u+YPYxQP06nYEdElxZ9LGWVeY70HsGwhf36peS5Z24U6Hjqa/9z9oDh+dfBG8wWSsTCb5p/ek9EPcGV9d+wnctawsO4a8qi7WhkSS742WEkeamHzbbxdpVvSSEWjYd/fpPcwLd5Md+H7wOwK8SanGkdt4b6zJD1BjQAbkk0A5FlZulBpDbr7vKZMt2u2BVTNscW/mx0ZxhzfYFeJ+M3Jvx/zn0RjxTj4GSn7PxqQKLuYSeeacYpxl+uSkpnh8eoWd+/u5XtVC1CiofYDmQCZj5sKKvDdyrHYhrdeNZoFZLueOXyKrcII8cZ9h3t+MRWIY2BokBZ0KXzPpa0r9jGOxWeElOznfhB/1Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aec39ff9-d9ce-4a7e-e55f-08dd3af14b51
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 14:30:18.3603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2THdA4DtL6E+cDJYp3luaRP3YlXXIGckSnTvo8iNnWT7qssdpbFwtTBwZghBBXThckzUBv8LJMTFn6gnTpcraA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4379
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_06,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501220107
X-Proofpoint-ORIG-GUID: ZBl-E77w6BFlXvsvH6_aQ7kzKE8EDA90
X-Proofpoint-GUID: ZBl-E77w6BFlXvsvH6_aQ7kzKE8EDA90

Hi Frank -

On 1/21/25 10:34 PM, Frank Sorenson wrote:
> Don't store the mountstats if the fstype is not nfs

The original intent of mountstats is to be agnostic to the file system
type. The description must provide a reason why the proposed change
needs to be made.

This patch doesn't provide a bug or email link either. There's no
context we reviewers can use to help understand the purpose of this
patch.

Generally, a patch description needs to explain, among other things, why
the change is necessary. The diff already shows /what/ the patch is
doing, thus a patch description typically does not need to repeat that.


> Signed-off-by: Frank Sorenson <sorenson@redhat.com>
> ---
>   tools/mountstats/mountstats.py | 18 +++++++++++++-----
>   tools/nfs-iostat/nfs-iostat.py | 16 +++++++++++-----
>   2 files changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/mountstats/mountstats.py b/tools/mountstats/mountstats.py
> index 8e129c83..326b35c3 100755
> --- a/tools/mountstats/mountstats.py
> +++ b/tools/mountstats/mountstats.py
> @@ -783,25 +783,33 @@ def parse_stats_file(f):
>       """pop the contents of a mountstats file into a dictionary,
>       keyed by mount point.  each value object is a list of the
>       lines in the mountstats file corresponding to the mount
> -    point named in the key.
> +    point named in the key.  Only return nfs mounts.
>       """
>       ms_dict = dict()
>       key = ''
> +    fstype = ''
>   
>       f.seek(0)
>       for line in f.readlines():
>           words = line.split()
>           if len(words) == 0:
> +            fstype = ''
> +            continue
> +        if line.startswith("no device mounted"):
> +            fstype = ''
>               continue
>           if words[0] == 'device':
> +            if 'with fstype nfs' in line:
> +                fstype = words[-2]
> +            else:
> +                fstype = words[-1]
> +
>               key = words[4]
>               new = [ line.strip() ]
> -        elif 'nfs' in words or 'nfs4' in words:
> -            key = words[3]
> -            new = [ line.strip() ]
>           else:
>               new += [ line.strip() ]
> -        ms_dict[key] = new
> +        if fstype in ('nfs', 'nfs4'):
> +            ms_dict[key] = new
>   
>       return ms_dict
>   
> diff --git a/tools/nfs-iostat/nfs-iostat.py b/tools/nfs-iostat/nfs-iostat.py
> index 31587370..f97b23c0 100755
> --- a/tools/nfs-iostat/nfs-iostat.py
> +++ b/tools/nfs-iostat/nfs-iostat.py
> @@ -445,27 +445,33 @@ def parse_stats_file(filename):
>       """pop the contents of a mountstats file into a dictionary,
>       keyed by mount point.  each value object is a list of the
>       lines in the mountstats file corresponding to the mount
> -    point named in the key.
> +    point named in the key.  Only return nfs mounts.
>       """
>       ms_dict = dict()
>       key = ''
> +    fstype = ''
>   
>       f = open(filename)
>       for line in f.readlines():
>           words = line.split()
>           if len(words) == 0:
> +            fstype = ''
>               continue
>           if line.startswith("no device mounted"):
> +            fstype = ''
>               continue
>           if words[0] == 'device':
> +            if 'with fstype nfs' in line:
> +                fstype = words[-2]
> +            else:
> +                fstype = words[-1]
> +
>               key = words[4]
>               new = [ line.strip() ]
> -        elif 'nfs' in words or 'nfs4' in words:
> -            key = words[3]
> -            new = [ line.strip() ]
>           else:
>               new += [ line.strip() ]
> -        ms_dict[key] = new
> +        if fstype in ('nfs', 'nfs4'):
> +            ms_dict[key] = new
>       f.close
>   
>       return ms_dict


-- 
Chuck Lever

