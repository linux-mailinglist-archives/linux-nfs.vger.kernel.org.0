Return-Path: <linux-nfs+bounces-14822-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DD3BAE425
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 19:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4428C16741D
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 17:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97CA1C862D;
	Tue, 30 Sep 2025 17:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KjpO9MW3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YIT9tUR4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6FB35940
	for <linux-nfs@vger.kernel.org>; Tue, 30 Sep 2025 17:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759255183; cv=fail; b=V8L8Je7K/SHFI0Iqj/w2xm6IJ2qdL5uH7wREXwFQSwKERfZ6sEvuXJB0aSy9KI0FEuqMlnPBtw+NsDs95A2Wq8RBHY9repWkM4GZPBnQR5XzfTzWAnC1gvZq67t/pOat4MfvizpTRxtIJZiialiqGTcP/EuUnz7hXQDLa9PdYAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759255183; c=relaxed/simple;
	bh=Cgy1qIjPaCEUR/lYPRK4pz9ln3ROjENG88bbABJgKsM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HBx5NiVHoAErmiI4k93OSEasUUXQfsYicdb/kFPuVsCHl8BthaIJ5UWJukB9ArLfxR2PTWJVyqGaAI7kkkRhYDrgqGMXrWYdHLa1iDun1o8Z+hSxefv2VW9VZdzXtPn2Dp1qLlbXMJBSPXKtfB2SY5i6vwlb2E3CTAxvZ7mXbII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KjpO9MW3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YIT9tUR4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UEU2Fv008723;
	Tue, 30 Sep 2025 17:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=bzN6iWVfuHv9l1LJeolvKH9bTcJ5qMgPB7BLCuhL4R4=; b=
	KjpO9MW3rr4xCYPgdq9OAiznX5sxx20LBnFNARiK2JVHFqk6R/Sb+doTAYOv7oZv
	XVGKK+J7w1REpZtELvdArUlpIC+6GQ5Cbz0zEDlSEJIu0XHBdBEq+yfIRQFRyjFA
	u6+3nhwGdw5+VYkV/BRpARvD0Y9YVSuK5ka10Fsvo9t33x96CnMGC+ahaCEJIZFI
	PMKTa5CaMNG6wKIbL4zdyThDpVMp5pwBJZRx3lLwJREZ/YWTCn1W62KUDcjvMMzY
	eFYCuzX7B5AUNOC7SdVUA6FFGEdxqLFUygrnelHlOJIJjfHoe2N0xPcqgNEwRIo9
	x8AaQ8zTWeLoBGGER2a1Yw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gh0y0kpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 17:59:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58UH6bfA002110;
	Tue, 30 Sep 2025 17:59:32 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012014.outbound.protection.outlook.com [40.93.195.14])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49e6ceq6xe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 17:59:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eHkuuloEk66/j63OUw3OC2xlKezj/G35EJR6hrqRCYHmG1778catFDhjQNZRDNCdgwXxmu48q+Wk5aoiLcVhYo80pjl/VBEReEZsiV7lQeyCDi3LJQ4d3Nph2vIRYOmMF265dD15bUFQYAUOMObH3px6ds0R7WHJNIcn2eVW5DLwAxMn1w2gvOxo7aUFLoNSTooHlDS5AqNLDhtyqZcpBE9cMn2Jm3VkrFlTTJWDolh51DCuxmpuKBVwBDHyWmPujk+dcS7YRYIjFGlvqAkNopr3fHdIgz8OmXP5i4wyhYqiM9bg7oiOUiOgunglhNXZ0zjmdw/BtKq83z0rJTvqIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzN6iWVfuHv9l1LJeolvKH9bTcJ5qMgPB7BLCuhL4R4=;
 b=Gg97tbdbwucjB3F9mxHVmAQJ2GrX//vg4jVY1Ys3tTTvfsuf2/wZ3k9wH9Mzc8AD/S0c8pScN8AQbSZLftAKAAJIydLA3zrMJ56H/hi6q+AIv5Ws66Fym8ErZUJsBHciERgkdv0tkpwjpSI0kjN9DaxPTCXHG3QnEfGC/cb1NRW2XWSpVohRdtZQMa2/UFk2+kMcdIC54aPiwotEOHJUFzQiwHsQluZKmnGadiB7DBpQ55ZYHRVs54PhKOSE4OWn/5OhhC0fWXw40ShVjEFaAWd+pgwzjiupxSMDQlrrYDAHPY7ABmOtwy1TtnTMwrp6mdySwOjRAnXtfOwZlcXrVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzN6iWVfuHv9l1LJeolvKH9bTcJ5qMgPB7BLCuhL4R4=;
 b=YIT9tUR4fa2L64IjixCB31sJGlMTHDjNKPY7WOWmLxhh19uSVNrJnn9DveFYVB+XLOeRnPZY6Ut1f5q230ZliDiv1lIZKkAzb7nOqyGTYG9y+Qr8byLmJbpTg5u6Lj3fRUW0g7jBUYGfGyzzgWzGkaY0tgyzi0KufjwwyM8fwjs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB7242.namprd10.prod.outlook.com (2603:10b6:930:79::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 17:59:27 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9160.014; Tue, 30 Sep 2025
 17:59:27 +0000
Message-ID: <03bfd1bf-a687-40de-9028-bd6eb87a678b@oracle.com>
Date: Tue, 30 Sep 2025 13:59:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] NFS LOCALIO O_DIRECT changes for Linux 6.18
To: Mike Snitzer <snitzer@kernel.org>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-nfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>
References: <20250915154115.19579-1-snitzer@kernel.org>
 <aMiMpYAcHV8bYU4W@kernel.org> <aNLfroQ8Ti1Vh5wh@kernel.org>
 <aNQqUprZ3DuJhMe4@kernel.org> <aNgSOM9EzMS_Q6bR@kernel.org>
 <aNwEo7wOMrwcmq9b@kernel.org>
 <178769c5-e29d-48d6-91df-4bb45c48aae1@oracle.com>
 <aNwU16Yi4V_ztHY2@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aNwU16Yi4V_ztHY2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0255.namprd03.prod.outlook.com
 (2603:10b6:610:e5::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY8PR10MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b56ee24-5286-4c85-e358-08de004b1891
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a3JzZUkxeE1SMXJrRGRnNmZHTkhuS25jM2pHQ2lFRWlaYys4YUxVcitJa2FJ?=
 =?utf-8?B?YUlVc0pLVElsWW44cnpCWHJPRnZWR1BnZm9ZRkpJSmR3aWlMbThqU2U5REdw?=
 =?utf-8?B?cGxmMEdzZGk1Q2xiYkNPSDExdklzZm52dExKWkF5bjVUOUFyMXVJYUFPbURR?=
 =?utf-8?B?MG03bTAyNGNnaFdOTHRFaEMzNjI1WElWSVJvSklCeE5VdnBoa29MYTI4OEd3?=
 =?utf-8?B?cDRFSjlTNWZHcEtkUEZpVCs3em5jVE9lMEIxNEk1bDJhZk5UbzlMc2ZxOWlX?=
 =?utf-8?B?WkVmQUx5YnNmUCtjbk5aYWtmZkNrK1hka3l1bzBTR09ndW5mUy9jNjZlRCs4?=
 =?utf-8?B?MWJjR29EQTlWZVo5Q3dlVXpnK3h2MGY5U2dxdTZDRzhRakZqWWQzRHhIK2RL?=
 =?utf-8?B?QmFJNm0xY3M0QkJJZGZOQ1RIWFQwSDBnbXNUaFhBMzJQR1htaVI5Ny9hWXdv?=
 =?utf-8?B?RVVsVk9laW51RDdvTHBjYUxkcUgya2xBUkJGWW1oVFdMWXhOSmV1ekRGTlVR?=
 =?utf-8?B?ZE02c0N4N1VWNVlPbTZhdSsyK0QxRlpycytHOXhQWHRPLzdWVWU5V093d29a?=
 =?utf-8?B?MktYY2tocGFRWFRrWEF5K2VxUk04VERJdWxLMlZyMzQvMWozWDVoRjFuOEth?=
 =?utf-8?B?RUNLT0JaSmhiRzVhbnBWYXRwS3R5L09pWlhoODY4NHlmanpSaHFVdXdxSlVE?=
 =?utf-8?B?NW1oc1R4cWREcTFTdzd0YTZqNFNEZjdWMUZxd2d3NjFJLytwalZQa1c2WlFh?=
 =?utf-8?B?SkpKZWs1SFRhR3hNSDkrWDRqZ0NpKzVhM3FSM2Uwa0ZBeDVETnkyUGo4cGc5?=
 =?utf-8?B?VjV0ZnljL202QjNHNkpNT3A2cVZRN3d0YjVwZ0tTdlgxT3JUMjlsR3dSSUUy?=
 =?utf-8?B?TVhrZWN1YUNCMjhuMzk1dWZMTVBqbjdlL0xuMDJ2OWJ2SXJxU0lHTzdveVFm?=
 =?utf-8?B?Y0dCMVR0YVMzczVsc1ovL3dEZXFPQnA0VlgyTGcxbHFVOWVkeWhkck02TDdh?=
 =?utf-8?B?V0FGQ0pEaHVicHZhSVMrU3BlS2l6SWI1enRJRmo2cGYwK2g2ajZXbG1Wa28r?=
 =?utf-8?B?Z3lONHNrcGFyMFQrNnFiVy9IQkxUTVE4Rjd0MmpSdjdYNExQeW0vRldyK0Js?=
 =?utf-8?B?Z3NnYUQ2VytmWjA3NEVON1VHYTJqNk44RXRPRkhhMDBFTGpudERwQ2RqVTln?=
 =?utf-8?B?OUNKQTM0Nm1adVRKQVJMZHY2YkZERUhGd0RuQys0WU9jRFhYZW90VjNkYVZJ?=
 =?utf-8?B?QUFZVUdJTnVGeDJ3a0I1MzNGTmhsWno0NFNUekN4b3QrNkNvWEV6QkVUVXFR?=
 =?utf-8?B?c1FSM2hUOExzN1J5d1I1UTlrNlhBT0RuYmxUYzZTUVBDODdYcmtWYzVKU1hI?=
 =?utf-8?B?UmhqZUFUY21VRnlQN09JcXlDWXFBTlE0azBvQVpjNjlRNGNqK2RSTHJURkZ0?=
 =?utf-8?B?cGNZVzFtVmJpZ1M3NGJYY2ZzNDVidHZBUEdPQ3h0SWUwQzlreERRcG1tZmRw?=
 =?utf-8?B?Yy9JVGdNN3ZyY2pXRnowS044R05NaWtOTDhWa1FpWU5PMkxNZnRpUXIydk1k?=
 =?utf-8?B?QWRPcDZuak9RWi9kU2kzNzdiL0dXZmljOXJsbWlDYWRIYXR3QUU4Q3dBWnNl?=
 =?utf-8?B?SHhCaGE4MEV5VGs0cnc0WDFZT00vRHZuNFp2Tk8rTXVlTUhLUXlZL3IwWG4v?=
 =?utf-8?B?U2s1NXVGUW8yOWRXeFMxNWVqTFlGVWlGajlFbW1rK1JqYi8xSy9GTk9VVlkw?=
 =?utf-8?B?WGVleFVGUDIwTjZKS2pIa3c4RGxmNDBvaiticmNRK1RqREkrRC84RVlCaitm?=
 =?utf-8?B?aEhibC9NM1I2b1dPLzVmUml5LzZHQkVQcHhteU1ReVJLTU85Uk43T2RTUHhq?=
 =?utf-8?B?Tmk0c2NWbENOQlBqQkFUaUxhcDZLdm5BenB4NHpHWFYvSFNTekJjUzZaQUc4?=
 =?utf-8?Q?ezKU+llNUwmxJg/G1Szc+HAv/sBOq/eO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFNFVnp3T2VDbHoyN045WUZMYWhSR0Z1YnJiVHRjZFdieEk1NldwT1hxckpx?=
 =?utf-8?B?OURFRW1vUTcxVjBBUEpqbXRkM1FTMHFaSTUvdnB0QWtwZXhYL1hOU3J6OEJp?=
 =?utf-8?B?Rk0vZ3NBSGo1YWV1ZGgvUktqUm03VlFaWnhTMlI2NW1xaVZDYnhuVm5OOWQ1?=
 =?utf-8?B?dE16aklXUnpzc090N1Azam5IS1Jxb3cwN3BtYXZxTGNxOFo4NHVaVC9zdWM5?=
 =?utf-8?B?bitoWldiTUdRNzMzK0RLTE1JL3YrcEhmT1FhaExyVk53Sy9JeVdMR3ZaOEg1?=
 =?utf-8?B?V21BcVVXbVQ3M0F1b2FhYlNQeDJxRFlQY2dyc1JNNU91aEVkaGZkMWVSc1dM?=
 =?utf-8?B?RExFSFVCVXc2UWl4SFgrTEVKSHUzQ2M2T2ZjV216NWJiT0E5WFRvWmxJa3hn?=
 =?utf-8?B?WGlKWTZLUkFZVlVGSDJiQXM3UlFFcCtBYjdFVi9LNlkzN3AzZ004K0V1NTJk?=
 =?utf-8?B?OG9TblZmYWgwSktQY3ZwSU96NjBBTlVSVjN4d25sUzh1Vnpoc0NQTC9iWG52?=
 =?utf-8?B?TmNWcEIzQkYrTU1rVEMrQWpIRHlrT09ZWmlSVEt4cE02VXYzQjZ2SXVvaDdD?=
 =?utf-8?B?eWtQUXY1VUZrc1Naa3ZRQU94SXgxeWZ5RWdaREF1bVFyK1JsbjQzWlp0U2xG?=
 =?utf-8?B?R2d0bTVBaXRoZFNSdVZvNDBtYmxiS3FNMTJqZEVLQ2hrZEYwYmtLZFkyMVVG?=
 =?utf-8?B?VHdjMnNURG52amRmMHc1bHNFOVdJT1kwUkRodFBrc0pSTXNVcW5WZTNPR1lJ?=
 =?utf-8?B?bFlURkRObTdIbjJVQzlVNXpjYUtjOXBXYzRBeEpzcVFPazNtNDlvVHhPaTMw?=
 =?utf-8?B?WENsNDhSMm9CQ1lBYjRsNlYwRHRZNkxTQkdrdWxvb25jbzNvVVhNd1JZbXEv?=
 =?utf-8?B?czFCZEkrRkxZb1ZsNzMvTDVDMXl6R2l3dGtJcmlvNXFGUEZ6L3Q5ZlJ6QTRR?=
 =?utf-8?B?dGZlN2tRc0trTHlTdE94ZDMxWjN3WFJnVGI2MDZUNG5nckpJTHBGZnIwRU1v?=
 =?utf-8?B?YTVEdlBxVnRiSkxqK29GTWtKeml4bS9GQXFYcXhLMk1oZ0h3NWRmTVprbWdK?=
 =?utf-8?B?ZWtvczhyNWtwaVA2aFZBK2M5Rld1cVdmT0ZndlZnVDRpSnBFcTd4Zkh0Nkx5?=
 =?utf-8?B?ajZpRDMzb2szdXR1VGZIU28rcUQ4eGk3cTZZMXRGMnJNbysrMkgyaXZRckZp?=
 =?utf-8?B?SmVxYmMxRkRVK3NoYktnMUFSYjRvaVNaOEpnVGd4dllmR2M4U0Fmbk12cDBF?=
 =?utf-8?B?L0VUK1gxbURGeGJFYjR5QXJhMXJLdVNKa2JrTjZSTzBoemRjSm1ralZISVd6?=
 =?utf-8?B?SVRsUFVSUktnSDRjU1l6NGxacnhxbG13NndFZURyakoxZ0o5VWJmdlVUQXFX?=
 =?utf-8?B?ZmVNLzIyNnFrdDFmOVphVDNXR0hua2YwOVl3YlV2OTU4dUpzem42bkxwY3pB?=
 =?utf-8?B?aDhybjhUelViNTZEbGlCdUhSUlNiMWY2SHlDSlZvbnRQbnZyTDNPdUUrc3hQ?=
 =?utf-8?B?VFFlTXZLYmliV3hkbXQ4REhOTEwrUFpOa1ZJVzVOTCtJVlpkWkFoQm1YdXZV?=
 =?utf-8?B?ZmFHeW5HYjdMam1icGZVQWt1bWlMQ0FkM3ZJMHpFeUZ2N0UzWS9FTmI3SzBE?=
 =?utf-8?B?UlY0cW1lWVFneVkrSVh6aXNMSmlVanFhQyt5WjhGQkpnQnQ2WUZNS2x3a0dJ?=
 =?utf-8?B?ZXJMSHNTbis0emJvZlZLRE9FdFNMVVNlTUw0L1R5TVRJK2FscEh5QytTRDlM?=
 =?utf-8?B?SkdEaHYyeVRDalZieDdFY1FFZ0tBNFVRdEd5Yi9tYlhkcFhhR0UxYUxablVv?=
 =?utf-8?B?djVHZmFIL0Ercy9IcmllbjBpb3loc1MxSzl6MWRpTFVpREhkV2I0OUI0T1Y2?=
 =?utf-8?B?QkJDbXltTW14cnlMSDhOV3RibE4vSWZzMzJ6K3dmYW9uK1VEbXdoOWcxS1JZ?=
 =?utf-8?B?Y3BBTnI3QUFlaGl4K3FpSjdQbHN3VFVINWowNmxsbUhZMm1pejl3bkJhOXN6?=
 =?utf-8?B?dUtjdHlTUml0NVBQbmJGa05TYnVOZFdBeU5wdXExcGlseGEvSWtaa1R2K0JR?=
 =?utf-8?B?cS8rclhibWc1R2lBRU0wa3hsZEJ3bTVxbXcxQTVvbUc4T3gvcGoyT1kvRWti?=
 =?utf-8?B?bnVPOUxreHpYRGhQWXNGUUtTYk8yN0EzdGhTR0VDWjlLejNSREVYMFpkQ3h4?=
 =?utf-8?B?NUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gVE6XCz/h2ZVApy2oM3QWX7eyZJSPnv2QkaMNTw4GMwpkDd7a4NCEPJU/WP5SFfFuYAXvplIng9ZYHYz+V13W9w6P0BMqJAPdqwBAJH1EL1194KIWzZO8CVEPM4h+DKg+bOelvOxFGF5F2/Pt/12FTaa90H2kQH6pQBRqTqwC5vRaHZCaWnOL3Ovd3knDZwtWaC3L1wV6ExbNUhq+40vJ5wCCanZBQbb220ljVYqQCQt/e8mxqy5Jzet4fg0Gq4xEuu75190wAq4B/5wiahPmE4Eu2UzQmJXnaMv1FLk9xb7hADMmyq/dGf9O3X44x9Go2MooFcu42Km3f728/VwpQ0Uw2JrI1MgyTHGXsGS16zB+JZ3wpVwa3PHt49AMygRMBIwz65a9uSdvkBJEi3GlwbX4GFNN19H5loRhotwiCdFLO8KJLaCUMnauhtbP1RtiQpMiyguZ9S7JyFLvS7LqRqPLHNPzwg9twaGZ9anfa6M7HVNlACgAmBzNdluHyS/tzrOEvqPMafpBq7vV0PFzegsF27C4e0KmJegADfEbXnPFNgBH2AWCmd5xE9l9tpzymjr4cBbQEthw8dGN7qZj3H8gX1D+PkJCDYeyYhUYW0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b56ee24-5286-4c85-e358-08de004b1891
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 17:59:26.9294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQNLA9V66VjXl6+AoGMW251FxUxQ6Cr/Nu4UO9/XelY50o1j6RO/zjiQvg+MA6RXDl45ZreEvqGWGU4yVzwesw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7242
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_03,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509300162
X-Proofpoint-GUID: _cHqgfSOSYjtRM46eGBya-5N_8H__rw8
X-Authority-Analysis: v=2.4 cv=GqdPO01C c=1 sm=1 tr=0 ts=68dc1a86 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=7S6laQFAGwZLiCFZ2coA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12089
X-Proofpoint-ORIG-GUID: _cHqgfSOSYjtRM46eGBya-5N_8H__rw8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDEzMCBTYWx0ZWRfX3NiU7BJ6PAua
 YGfBlCIZ5/FZ90ikWUn5MP2YkUnNf+o7iijIP2/rxxTR4gJ8tRa/Uys2RGpx0yxk1pScKhrmiQS
 QWuNT5i1XbZXjjx3v2P8Yvsn/q/T3HaQGzoCBCWfNJwqDP4gApksl03e4YI0Se4goFW5PzSSYXx
 ws+E04DkJVxXaLUy8LI/4ABEnQy25Nh2Td+zdnTvoxIYnoKhaM0EWIghv5dzVrUvV5UqxhSfS82
 KUQ0Z3V9yAymIa7olnqqyZm6B+BZqaGPYIM4gja2E/jp50FKhxMtjoCU3oBVTmmKrnDr5wGFXjy
 YVnto+EzBopQYkOKdIJ4If3IMK4KTpDX0w2vPxYRJ77Geqkt/CLLCACx017KMtdMH886dTpigDH
 7nPdBnMcuDXjrIh20oz6PxzHDU5iqTXWeF2xccKjnokhibUprUk=

On 9/30/25 1:35 PM, Mike Snitzer wrote:
> On Tue, Sep 30, 2025 at 01:15:06PM -0400, Chuck Lever wrote:
>> On 9/30/25 12:26 PM, Mike Snitzer wrote:
>>> Hi Anna,
>>>
>>> Given that my NFS LOCALIO O_DIRECT changes depend on NFSD changes
>>> which will be included in the NFSD pull request for 6.18, I figured it
>>> worth proposing a post-NFSD-merge pull request for your consideration
>>> as the best way forward logistically (to ensure linux-next coverage,
>>> you could pull this in _before_ Chuck sends his pull to Linus).
>>>
>>> If you were to pull this into your NFS tree it'd bring with it Chuck's
>>> nfsd-next (commit db155b7c7c85b5 as of now) followed by my dependant
>>> NFS LOCALIO O_DIRECT changes.
>>>
>>> You'll note that I folded 3 commits from Chuck's current nfsd-testing
>>> branch into a single "NFSD: filecache: add STATX_DIOALIGN and
>>> STATX_DIO_READ_ALIGN support", the commits from cel/nfsd-testing are:
>>>
>>>  9cc8512712b11 NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support
>>>  e5107ff95c56d NFSD: Prevent a NULL pointer dereference in fh_getattr()
>>>  ed7edd1976c04 NFSD: Ignore vfs_getattr() failure in nfsd_file_get_dio_attrs()
>> I strongly prefer that the second and third patch above be permitted to
>> soak in nfsd-testing before being merged. These two modify very hot code
>> paths in NFSD, and therefore deserve proper test experience.
>>
>> Please don't push NFSD patches through other trees without at least an
>> Acked-by from the NFSD maintainers. The first patch has been acked, as
>> you requested, and is ready to be applied to the NFS client tree. That
>> Ack does not apply to the second and third patches above.
> 
> Please explain why you're in favor of NFS picking up an NFSD commit
> with known Fixes?

I didn't say "don't take the fixes." I said "don't take the fixes
without Acks and proper testing."


> And why didn't you fold your fixes into the original to begin with?

1. I had already sent 1/4 to Anna. Fixes to that patch now have to be
   treated separately.

2. As I said, the fixes need to have full test experience. 1/4 already
   has full test experience. Fixes: tags do not mean patches no longer
   need to get tested, I think you would agree.

3. The fix patches address bugs found by code review, not by test
   failures or bug reports, and are therefore not as urgent.

4. The fixes can be merged during v6.18-rc if we think there actually is
   some urgency. To me that is better form overall because it explicitly
   preserves the provenance of the changes.

5. As I stated, my Acked-by applied to 1/4 and not the other two.

6. The squashed patch needs to be posted so it gets archived properly
   along with any additional discussion.

7. It's the maintainers that get to make these decisions, not the
   contributor.

I don't see a reason why we need to waive the usual review, testing, and
merge process guidelines here, especially considering there was zero
community discussion about this beforehand.

Again: taking the fixes is fine. But please allow them to be tested
properly, and let's get maintainer Acks first.


-- 
Chuck Lever

