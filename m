Return-Path: <linux-nfs+bounces-4224-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 302CF912CEC
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 20:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0EFD1F21E8E
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 18:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5773C169AD0;
	Fri, 21 Jun 2024 18:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a7AyH458";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gowuWXAX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09A22E417
	for <linux-nfs@vger.kernel.org>; Fri, 21 Jun 2024 18:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718993132; cv=fail; b=WAbIS3gfx3+tQB4L4cXlbq222ijNFtQ37qAuIHqknDUQErvgVhoeuwCV5cm2v7PCbPf3e+a5WPJufu3aZ6Rp5+3BqBneMpGjbI8dZud5Mhp0fvLr8D3y6NTNn2cpj9tjsLl7z5iNXSPj3hrmMCjbFGaKbCtq4NcRMqhU9b+fnxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718993132; c=relaxed/simple;
	bh=FbqVhGAEW8BG7x9AnueZMHzyRu2q0YB+SRXb9sAzsio=;
	h=Message-ID:Date:Cc:To:From:Subject:Content-Type:MIME-Version; b=Qo9UNYkczkTXU+K40wQnIV9jC166HxjPV52xjn4EG6M0ce3QRGDmHpyR9HTRiVKzHxOz3Fn8C6hXSfQ0SzBzQWasM5+b2OcQsnSTkkVTb0+EWmCaTV3XIPcok2AfxrNCtCbagnovfkj/otywFZkuaL/WwLf71lgRT58hwc+8woQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a7AyH458; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gowuWXAX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45LEXaXZ010400;
	Fri, 21 Jun 2024 18:05:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:cc:to:from:subject:content-type
	:content-transfer-encoding:mime-version; s=corp-2023-11-20; bh=j
	/saEEp+heUlXLv+8XB9+gWZuuAYxUdh0MB6kcmnx94=; b=a7AyH4585keZnTIsy
	h9WxyQ8hBwz47Of6b5Dx57xERXY7CfAK0GjjPTPFWvFtlBfSQ7NKTRWgwEs37RnT
	+MhG9ZfPN5ihHuix4/L61RGZDU6MqpnUQlFHR7XlYHkqhqtCf6P6vY40Y0VcpkKs
	Bz1sWM+qo1oz22jZO66l9MJPahL4udj737IwhcMHtI1/HHUWlX/sstpISOf9GT+9
	7clztLrzXIAysBkHRo9tTo3WuKWlXkUqYhs7uRyLjG8BkJG4ZxpKfVxX910Wxl4s
	bhvd/3slsT0uT8o9H262XEbZy0mBaVjUt22QRzbJyjsJrQj5Hs05l2URKi1Wv1K5
	ia+og==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yvrkttapm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 18:05:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45LGZMIh025270;
	Fri, 21 Jun 2024 18:05:25 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yvrn6e43y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 18:05:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ApxpF3S42kdBdRHKr5IW8asldL23T3iffGN7qL/nEg3e/LmCTmqc5tdQF9GTsDDRmV9SeCiVkADRpemzHW3n5dLgo7KoEpPeMT+HWa/ptr97/Uz1JZO2pqd1ZTN9nw70yYSAYoWoWxeYVuTfruKCk5c83wb8cVzkrnnkOu+EW5u8kHeRVuhCNc1fMbdoCthAea6eemXh+uPCczH8aAMv2msUvJUR8n5XwtZx5mNd4Yg5Cu1Si5GPH640ywnW/TEdk1aELoVLWGHwRFBqKqPNVDwree/bpNJe2ACWhvp8ppW+9MVUj/Esume4hgzVZT5TLjJbgM90YgcwM3kFZIrZfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/saEEp+heUlXLv+8XB9+gWZuuAYxUdh0MB6kcmnx94=;
 b=mmAKo+8+mzpKVb8K4Byjc+9fXr9tOnvbvM7LxAI4XlJiMvaB3rGbisHrLRTN+JaOchQ0ZY7pl0aJ3ZFf4SBrF6p/FVAXAM0M1PKd8lZc4BjNRfacFnRZM4JDoWXn8LcbZhSJCZtrtH79nEMLuBYPpFHnXj7vee7W3Him6aMFRtg0A+FZ57HnE9trtN+rhgxGnRCxoaQrdAMRJUo1LIgMYYj5NF6Xwm6zBKjjlpDPybGPH7E0RHNvo7qxITZ2yjRv0kD3bHQYN0JG0JVWFM6lD9TKsEO4RFB7hiR/t9Ayno3hnUVwHDcbrerGGdKupTbZs9hInUAP0m/CHLROTRHU8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/saEEp+heUlXLv+8XB9+gWZuuAYxUdh0MB6kcmnx94=;
 b=gowuWXAXXZ6Eb9R2VWKIWcIUSTH+9lFmpCE0eu0SrBovwQFGgxP+vqt3Eeak+xL8yWXaTNtP2tE3YIphslYbOnq6/RKp7xR5+oXXxBY5JD7zschb4ZwjC5pu4BbvkU7W8E958FJiOT90AVw4SrzwmJ9150C1a8ALxu6LI0Tkvic=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by IA0PR10MB6724.namprd10.prod.outlook.com (2603:10b6:208:43e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Fri, 21 Jun
 2024 18:05:23 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7%4]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 18:05:23 +0000
Message-ID: <5677891d-7eb7-4033-9903-32e6ef2a95e7@oracle.com>
Date: Fri, 21 Jun 2024 19:05:20 +0100
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Language: en-GB
To: Trond Myklebust <trondmy@hammerspace.com>
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 smRifw1wGg==
Organization: Oracle
Subject: pNFS double-free DS commit info filelayout_free_lseg() [v5.4]
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0225.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::10) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|IA0PR10MB6724:EE_
X-MS-Office365-Filtering-Correlation-Id: 5909a630-0662-4f23-51dd-08dc921cb8a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UGNIN0loRjR1UHNRTmgzSDU5NmxTZGR4dlNoOVBGVUtvVHA0VTRLT3M2U2pl?=
 =?utf-8?B?NDFqL2NTdEpqY3NuWjd0LzZiUXJHR1hhYXV2VFZqS2VEdzFYRmMveEpuMFJ1?=
 =?utf-8?B?czYwWjBKelVKTXZEdnVqUTBEUzRGeEQwSHkvOGFjek5udjRzRmZkT1l0ZUNm?=
 =?utf-8?B?aU5hQnpjbmhWMEY2Qm9vR2pvcDk3SGt2dFE1a201T3ZBRzRsTWR1dE5oOHhm?=
 =?utf-8?B?TkFkUG00UldHUXlwb1NNOWpra3I4Z2k5b1E3bVp5S0V4QXlhcGoyQU1xWnFn?=
 =?utf-8?B?M1d3NWN5SXBFdVNzVVNObTh2ajU5L2JBQ0c4WW4xazBrSHduN0dGN08rdW1I?=
 =?utf-8?B?ZVZYMU0wZFZ1RlhleXNoUkxmRWw1MkhtTEk4d2tHT0IxVk5vWE1qUzBidEpB?=
 =?utf-8?B?Wkk5TkVSdWdYMCtLd0NDNjhDa0Nob0wxbUp1bjI1Smp4YnhwdzVUbHZ4QUl3?=
 =?utf-8?B?VW1oeVgySWE5TkNkRHZiY1hpR1pNRSs5NjRqZE1yU2QxZ2xLOStlQ0pXN0c4?=
 =?utf-8?B?QU1WaDh1YllmQlgzWWlsZS8vSnhPTHNlOTZpcVdnTUhsTks0MTlmYXl1cmQ4?=
 =?utf-8?B?dVdlS0JPcmx6cnQ4a3JHSmxjaEJzWkdGckhpM3JicWMrNGkrbGpKcnJ0SEVD?=
 =?utf-8?B?cmhncUhIOEY4Ujk1Y0pTTHFFSFpXVFpuL2VDVFBTRmVjaXRYaEI1cjVWVzZM?=
 =?utf-8?B?eXl2V1VLTGR1R3djOGYzVGtmdnBTYkVpZ08xQm8zRTR2OWFVcUNhVmxxSHBJ?=
 =?utf-8?B?M1VwT0d3dGhSRjNLSE53b3ZTZkFqOTZjOVErTGVMTVVrL1JnT2ovLytWd3dZ?=
 =?utf-8?B?UHl3dVdBYXNvalUwUzRvZVlORHRkVW5yL1BlbktFdEwvZTlNNnR4NWYwY2s5?=
 =?utf-8?B?RFlGb2hQRE9lWU55L1NkN3QzUi9Bak04NTJHb0Zmc3d1MkdRTkc3a3BoYVVq?=
 =?utf-8?B?cWo1MzdrVmdna1RORWVtUUYvcWVwRFkxdnUwMUJKSVA4RnYxVkFsd1V6VGxy?=
 =?utf-8?B?K01TZ0l2QVpnb2p2T0N6TjRTUFA5MjgrM0ZOZGVBcW9zOEVsOW5iVGdsMzRY?=
 =?utf-8?B?MGc5czlEdm1pd2RFUkVRYjJYTUxSelRvYzJCM1VQMGxUOHJvQm1Oc0NRWGE1?=
 =?utf-8?B?L29BWG1XaG9sMmk1bzdzcFZScENLT1ZyV0hwNlkrVzJOMTE0VnpWYnpWZWR6?=
 =?utf-8?B?MmFSQXF3b2wrUk5hVFhWR0VIRHlaSkZLaU9RZ2lWQ0lmN2F1QStVNUpWTmE4?=
 =?utf-8?B?TGh0Nkt1Y2NCdDY3b0hkSHZQTnZ1VU5ybmFqbTJ0azVMamgwV3BlZW4zakNK?=
 =?utf-8?B?S0RjTzd2VjVGSXAwNlA5cEZLODZ3TzV1OXVEZjhMTzdsS3p1SHVDdFIvVnNp?=
 =?utf-8?B?Q2puR0NOVkpyc0UwMEYxbVc1VVc2L3p6NUd5SEdyT1liaml5VlJlMlo2TldN?=
 =?utf-8?B?aFNOeXpEWkxESzBWZ3hsWlNUMDlhZEp1cmlKZDhhQVR5WjFtYmRIaWZWUWIv?=
 =?utf-8?B?dmtUSkE3YTNSNVB4aVpDQytnQ1hvaHFrdGFsRUhEcFFXdzJSaUZKQk9NN3VL?=
 =?utf-8?B?emZxeFQyYlJRUFpwVHVlbUlnTjZkU1g5RzlZMEx3Q3d6SDNrYlpmRzh6SEVu?=
 =?utf-8?B?UmVGWUZ0SGd6R1BLOEhNaTFzd2JBdCtLejBzaDE4aVlJakV2Q2ppWWpFVkZM?=
 =?utf-8?Q?/j8FB6FmYRZ7385/NG9M?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZXhVYmNxTFZqN1hHTFgzTCtSeXRYQmlmVDRDSEVzRHN3R0pGbzZZc2swVVp3?=
 =?utf-8?B?bnJmaS95TnRtdU5sZktSTGowRzNlK08wYzE1L25aYjVST0svMGtDMzFFVnBn?=
 =?utf-8?B?MHd3Q2FiMmdZWEExOG9zQnZMWnZoR295ZGRGcjhLRTJQcTdkbnVSNmsvUU1S?=
 =?utf-8?B?KzcyUllGTGFaM0U4OHlRcVVBcXN3Rk1qU242VW04LzZtMUI4SmcxeWFRQXg5?=
 =?utf-8?B?b2dPdi8xUUdpdVczTzZlU2VkMXBBVzkvKzdtd2ZmWXY4L3lLS3NzYWlqbTFm?=
 =?utf-8?B?SlFwbW9HaWhtMFdOczd2MTNqTkt0emNxV2xkd3lZT21GbDRXSU5tSVVyTTA1?=
 =?utf-8?B?VEhoSDZGMmlJeENTYlAweDJ0ODFCeEorMjFRdEdqaUpZaHJQUVdHeVpRZzBz?=
 =?utf-8?B?UVB0TFNqbjc5cnB5SWtlWHg3QmlTYmxhRFBHdEFzNVNCSklpQ1dTSUNCRGJQ?=
 =?utf-8?B?ZXFNYXhTcnNmbWFCY1BLQS9rODRDOVBVdVhERm9wcjdiWEFrdm5qa3cyYkdn?=
 =?utf-8?B?YThEdDNyN2d3ZTVEdU02NjhHYkRaeEZkS1BSUFNrNG1QZTl1REUxTjdPNVlm?=
 =?utf-8?B?MmlEeGc2aU1KZjE4TEVKMnJRS1JJc25HSG5ZU3M2K2RJOENwR2cyNTU1Mm95?=
 =?utf-8?B?ZVNKWU5YRjRjenhZbFczSlFYQitHcHdkVzV6Mk1aTzZxdTNrcS81OGIzaW5t?=
 =?utf-8?B?bTFQMUxheEwvS2EvVTd1WGE3TldUU1h2NnpEekcvZ05XbEpLRDNzenFwQXQ5?=
 =?utf-8?B?K2JQcmJCb21QbFBGamdSOU9rbUNUcm1TRE5jaTYwVUpDTlhWOEtqTVp6N3Iz?=
 =?utf-8?B?WTZuQUtwak1ERmhLc3E2a1ZMVlJwMVA3dU1XRWZrTm1SbWh6VGZyUnBxL1Nv?=
 =?utf-8?B?SXA2MjZ5MVgyTHNBTU1aWnB4bHQxYi9sMnFXQWZYdmlCbU1BQ0hFMWhQQ3dn?=
 =?utf-8?B?VVBNN0g3Ti9zL09JTGZJK2trSnk0THB2Qk1ualBvZ1BMUFhJUDBSNUJPNFAz?=
 =?utf-8?B?bW1hVFVFN2dTZzFBWGVkVmpQbExPQ0x1djJxMVpEaW9QQm9HWkhwRGUrUmVk?=
 =?utf-8?B?R2FhTWtsU3dGK3Z4S2pIY3UzT1lnRmNGVlYzZ1E0eGI4NHg2cFREelEwZmpp?=
 =?utf-8?B?SnM0LzN2S3FGQkplSmtiMExjUHZZVGhYS0wrbjI3ZFNENTRRakltWDlvNm1v?=
 =?utf-8?B?MWpXcU1lUmJDNGRCamw3aXdGakFoME1zQkJ6WkN0NG9pbVNEdStOWWhUNito?=
 =?utf-8?B?YlZUeWtnbTJBMUdTakxxMHFoZUhLZDR0YTV0VmVlZ3VVRmhVY3BsVUxIN2gv?=
 =?utf-8?B?am1haDFHM2pUa1AzdWVuMlBiS2hYRjN5Zm5TNUZwK1RJb1VuaXo5OFhENDJp?=
 =?utf-8?B?UldDUFhUR2lxS0dtYzlyVmV2cFZpYU9WYjRib0hVZGtCQUUrdk5uUTVjb2RH?=
 =?utf-8?B?MjNyQzZwMTVTdGJraUxxZzhBQUxoUzEwbmM4OENkdlltUjI0UUxyWmUyOXE3?=
 =?utf-8?B?dWtCMzJYWnFWbFY1TitDcUNYcTgwR0tKMFROTkQ1MFVXdGJMSVBSQjhqV0pD?=
 =?utf-8?B?NmhLK2VXSGNRM09wZHdIeVdxM1haaFhZN0RnblA0OWF0OE5YanE3aHFpMVNx?=
 =?utf-8?B?ZkIyMU1ZeExCVGFFUnFJaFhDaDFodGRDa2tneUloV2ZrUDJrd2hVelFWSGlq?=
 =?utf-8?B?UVJFTmpRNkhWekZna3NCbFkyYlFXZDR5MFJhMlFIR20xUWw0Wi9TMW9yYnlW?=
 =?utf-8?B?UndJdlZZc2JLbDZnUmlJc1N2dnViTmZyYlJ3T1hvU3Jvd3J1NXlabklEZFhW?=
 =?utf-8?B?cTJuUE1UUTZ0ZEwxcHBKQ1FvbGdkdDFpcmhXaVljbmtSOXdxSFo5R3VxaGQ3?=
 =?utf-8?B?RG4vdnp1d1hUT3dZdWJZS1FiSGRjemkxSXp4cnRXWkxCVGxRaTRHcnZraWRt?=
 =?utf-8?B?Y1ExaEhjdU9JR3NmR3RtKytMbmgxazlVQnNpQ3I1Q0tHOGN0UDhLclZYQkdW?=
 =?utf-8?B?OVYrZk50QjNIcjFHT0Nud3dwbXA0MHhnR25wdmtRU3lOanJ6M20yNk9DTWFQ?=
 =?utf-8?B?YTZZdHBLMkdOditvaGpEaFlZS1NxU2ZQM1BKMkVGMnAxQU9PNFNyL2JNT0I3?=
 =?utf-8?B?WDZHb2MzWWF0eXUzV3NVVjNpTm1aa3o0bFVrY0xPRDJmUDMrcmt2TnE3WVF6?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QsE+eK/VfcMtfFJJj0A/WtZhge4ibNQcaVJXz1JCoFZEyxwWV4U7B1wgSdgOq5RyfgZyfYoLdjHro2jRv0W6DASskVil7lV69fr10VVH3ZMDiCdf05kKF8TvmPFpZk/NxFXepWd7+UXypzHGuWJjSVMvOi9GjUX7y4qIgfk+cLKTlUtEvzkqBD0RaUFODtVNRr28ndJnLCSixcH4LSeC0btWvyd4m3JjP+q4Ltl+vHuPdXonMBqNuQd9A2G+8vg5iFe1Rw+uEzPyVawDGpykeu8UqDsF2FFRe/6YX6BYqFSmDZ9pOdA9AVw5xi0p6V7Rpa2ah5cTGe+mOkTRAGM50aXxgCWLAWXqKBapCpfLlHCaxYVpJE0v2dh5rLs13wpVDf1GJzaBn0USBXnc0emu/R4muSd+SAPFM/V5ffWVL8m2B/+M+W+YJxRbeP8Lhq1nDMaUvWXXuyt9bw5ZTM7ZykyRDt+9o4s0LWFXcOHFl5fUhfeylkdTfYywqyD1+OUQApk44Xe+DRmaouDLYHKMXLczdHXV+Wojl+bjAU0AgEjvK2Yv64IMQgIRjax+2G7691Wj5+X9td9aTKcgOCSHwU/JXz17fHPMU3Sz/CECtbg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5909a630-0662-4f23-51dd-08dc921cb8a7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 18:05:23.6362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ERMYpXhl2DJYm+vyk2jLEFJWNMqBq9m1Jl5OPjD60MJStEsvtO8++Zt+PVsrs57sod8RcyA4wmPQ1by5dxZW6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6724
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_09,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406210131
X-Proofpoint-GUID: vcQFkRrsNyDEoB3_N5X1-pLwLgNdKMci
X-Proofpoint-ORIG-GUID: vcQFkRrsNyDEoB3_N5X1-pLwLgNdKMci

hi Trond,

We saw a BUG recently, with one of our kernels based on v5.4.249. Full 
stack appended.

The crash dump shows no other NFS/RPC activity, other than the task that 
hits the BUG assert, which is handling the rpc_async_release workqueue.

My notes say: we're in pgio release and async write completion. The last 
thing that does is the pgio header release, which here is 
pnfs_writehdr_free, which wants to free the layout segment. Since we're 
using the files layout, we end up in filelayout_free_lseg.

That calls kfree() on the pnfs_commit_bucket in the file layout's DS 
commit info. Then kfree() eventually falls foul of the double-free 
detection BUG assert (object==fp) in set_freepointer(), which is inlined 
in __slab_free().


The short writes that appear to precede the issue are interesting, too, 
perhaps?


I noticed your patch series for v5.7:

	[PATCH v2 00/22] Fix NFS commit to DS

	https://lore.kernel.org/all/20200328153220.1352010-1-trondmy@kernel.org/

and in particular:

	12/22 pNFS: Add infrastructure for cleaning up per-layout commit structures

which adjusts filelayout_free_lseg(), and in particular takes the inode 
lock around the kfree(), which I thought might help avoid double-frees, 
if it were a concurrent task issue…

[although a few others in that series look like they might be relevant too?]

I wondered, if indeed it's relevant here, would you consider that 
series, or part thereof, to be suitable for a backport to upstream 
longterm v5.4.y?

Or are things not that simple, perhaps?


Unfortunately (or not) the issue has been seen only once, some months 
ago, so enabling SLUB debugging may not help unless it recurs.


thanks very much,

cheers,
calum.


[ 1093895.472897] NFS: Server wrote zero bytes, expected 102.
[ 1094250.849719] NFS: Server wrote zero bytes, expected 9264.
[ 1094598.709711] NFS: Server wrote zero bytes, expected 121.
[ 1094994.466054] NFS: Server wrote zero bytes, expected 121.
[ 1095450.147843] NFS: Server wrote zero bytes, expected 9089.
[ 1095862.677474] NFS: Server wrote zero bytes, expected 122.
[ 1096307.016082] NFS: Server wrote zero bytes, expected 86.
[ 1096650.380616] NFS: Server wrote zero bytes, expected 9349.
[ 1096956.556415] NFS: Server wrote zero bytes, expected 122.
[ 1097341.926574] NFS: Server wrote zero bytes, expected 75.
[ 1097748.691058] NFS: Server wrote zero bytes, expected 70.
[ 1098049.367847] NFS: Server wrote zero bytes, expected 122.
[ 1098349.546874] NFS: Server wrote zero bytes, expected 65536.
[ 1098652.138746] NFS: Server wrote zero bytes, expected 65536.
[ 1098652.138748] NFS: Server wrote zero bytes, expected 65536.
[ 1098652.138749] NFS: Server wrote zero bytes, expected 65536.
[ 1098954.730458] NFS: Server wrote zero bytes, expected 65536.


[ 1098964.976068] kernel BUG at mm/slub.c:299!


[1098965.011057] Workqueue: nfsiod rpc_async_release [sunrpc]
[1098965.017333] RIP: 0010:__slab_free+0x19d/0x376
[1098965.022644] Code: fa 66 0f 1f 44 00 00 f0 49 0f ba 2c 24 00 0f 82 
a4 00 00 00 4d 3b 6c 24 20 74 11 49 0f ba 34 24 00 57 9d 0f 1f 44 00 00 
eb 9b <0f> 0b 49 3b 5c 24 28 75 e8 48 8b 44 24 28 49 89 4c 24 28 49 89 44
[1098965.044341] RSP: 0018:ffffb798068ffc50 EFLAGS: 00010246
[1098965.050543] RAX: ffff8cc01596e700 RBX: 0000000080400030 RCX: 
ffff8cc01596e700
[1098965.058886] RDX: ffff8cc01596e700 RSI: ffffeccb35565b80 RDI: 
ffff8c53c7c07600
[1098965.067610] RBP: ffffb798068ffd00 R08: 0000000000000001 R09: 
ffffffffc0a7343a
[1098965.076504] R10: ffff8cc01596e700 R11: 0000000000000001 R12: 
ffffeccb35565b80
[1098965.085132] R13: ffff8cc01596e700 R14: ffff8c53c7c07600 R15: 
ffff8c53c7c07600
[1098965.093546] FS:  0000000000000000(0000) GS:ffff8dcfff700000(0000) 
knlGS:0000000000000000
[1098965.103105] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[1098965.109870] CR2: 000055aaf31dfd5a CR3: 000000e431a0a004 CR4: 
00000000007606e0
[1098965.118272] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[1098965.126644] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[1098965.135054] PKRU: 55555554
[1098965.138388] Call Trace:
[1098965.141380]  ? show_regs.cold.12+0x1a/0x1c
[1098965.146265]  ? __die+0x86/0xd2
[1098965.149946]  ? die+0x2f/0x4f
[1098965.153422]  ? do_trap+0xd5/0xeb
[1098965.157298]  ? do_error_trap+0x7c/0xb7
[1098965.161804]  ? __slab_free+0x19d/0x376
[1098965.166324]  ? do_invalid_op+0x3b/0x49
[1098965.170808]  ? __slab_free+0x19d/0x376
[1098965.175281]  ? invalid_op+0x127/0x12c
[1098965.179662]  ? filelayout_free_lseg+0x5a/0x77 [nfs_layout_nfsv41_files]
[1098965.187474]  ? __slab_free+0x19d/0x376
[1098965.191988]  kfree+0x3d4/0x3ed
[1098965.195654]  ? kmem_cache_free+0x3f9/0x412
[1098965.200540]  ? filelayout_free_lseg+0x5a/0x77 [nfs_layout_nfsv41_files]
[1098965.208331]  filelayout_free_lseg+0x5a/0x77 [nfs_layout_nfsv41_files]
[1098965.215903]  pnfs_put_lseg+0xd7/0x192 [nfsv4]
[1098965.221121]  pnfs_writehdr_free+0x16/0x30 [nfsv4]
[1098965.226743]  nfs_write_completion+0x188/0x210 [nfs]
[1098965.232545]  ? __rpc_sleep_on_priority_timeout+0xf0/0xf0 [sunrpc]
[1098965.239768]  ? refcount_dec_and_lock+0x16/0x72
[1098965.245040]  nfs_pgio_release+0x16/0x20 [nfs]
[1098965.250240]  pnfs_generic_rw_release+0x29/0x30 [nfsv4]
[1098965.256317]  rpc_free_task+0x3f/0x69 [sunrpc]
[1098965.267574]  rpc_async_release+0x30/0x50 [sunrpc]
[1098965.278845]  process_one_work+0x1bb/0x3a9
[1098965.290448]  worker_thread+0x37/0x3b2
[1098965.300185]  kthread+0x120/0x136
[1098965.308976]  ? create_worker+0x1b0/0x1ab
[1098965.318468]  ? __kthread_cancel_work+0x50/0x46
[1098965.328425]  ret_from_fork+0x24/0x36

