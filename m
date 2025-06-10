Return-Path: <linux-nfs+bounces-12244-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2501AD3584
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 14:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B635175DC2
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 12:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8EA22DFBB;
	Tue, 10 Jun 2025 12:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fir1fiIf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="geeFochy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1E022F178
	for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 12:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749557042; cv=fail; b=gMO0ntZGtE5F4pi674ntxn5nTnpp1x75V4V3mFpQsUw4fm8PY8VrQ/PrOqABqwrIdrAdk+pHAuokpVoJ2QGe8xvAkir57zGpsjXgfoWB8X71/KvsXCPbm82IuOcD8XjukICiwKZ1Y+J1+QTQbSVFTUuJWciBGU9pKKwIk3353zM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749557042; c=relaxed/simple;
	bh=jLAIvZUsnIQgRTnRkXNzGbx+0TO3Pnz/YWtMcAvDcJE=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NRYl5QlcgjsSusWflkOHvNjzhVEuAimaMGYxhPY+9rtQiGFsNHFYcaAdwhfqGA/+VDNurEnnxJQSlnMeLVc+hIdkU9I+PbH3l4dk1xlVptfbdoi/t3kWPCVbBw8ki8RoaY0QYOzmIQTRL/DiKv6PWyT5pb6kWjBpDWYJT8WSL/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fir1fiIf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=geeFochy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55A2hJYo015274;
	Tue, 10 Jun 2025 12:03:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=jLAIvZUsnIQgRTnRkXNzGbx+0TO3Pnz/YWtMcAvDcJE=; b=
	fir1fiIf0liS308uf8cvKu2Ers7ITMWF3X6mHwRS4Ua6UU68AYWISckyZNQKZiW3
	Fbczwt/NmgG1/we9XXvuo2DnZitpymCKgDyxHSLoACn+72LupFCiJTRKpU2PqIjH
	8j4fpeatxKyBV58GnK7X4cyFQX7GnyJGiJnAj7aXBEKdzCt1VakxucxeWG5dLmVO
	2FE7K2DTD0qcDpeJhbqKqErdMhkwdyi2U7R8++JmuJ2tdjcFnfYinsGu7Znxt8Tn
	RFRLwR12MO2lJsQJ6EkmZULeG7DI+rU1rNiGOf/yu+dOd3DSY2Me7NTpStWUuYx1
	NgMXOb7iVuFq2DIm/Q8k3Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474c74v45a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 12:03:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55ABkbpF021320;
	Tue, 10 Jun 2025 12:03:58 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bv9bud4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 12:03:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cIq/ChWNd1Yj21mKmRBc0bxfO217sIAVt5pq/Bpla2G2uqLmcPcp6quONiAgq3ZRoB6bjnQ/zySR3uL5t8bKbj/iuacS+rxlstZOFwtMvAYtD3Y+rNT9UFN9GGdEdYwK/wHLg8eXZ0bA93TYqadHKx9mlqqrAmYqklOfaQHy3pDO2PeVoYHeM9w8yuy1jZLyRpD9JLL6DXu3tJwEFoV9UOCOgMWPXf31/RnK6eED6eoH+DtE9D0bHG8+93tKkXvFjVACGE9RcR7qdXnLLhqKVxIn3HXz6dlsgOwV8QB2oKG8McMoGh0oUyma29FF4HDOh8vcQDh9GhxOD7HUBpCj0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jLAIvZUsnIQgRTnRkXNzGbx+0TO3Pnz/YWtMcAvDcJE=;
 b=qiMAmrm/jXJRVLIiNIwng+ZoGvcLU+qKKtaQGYh9nFcvkYPCrcZLD1Rf3paV5sgCE9Cf+FN3wWib8vf2aqlarkWPoZsEgMJaKA6HitWeJ3Q6xxxO2qjtlEZeeDSB5oPFt+KDUqhDwARzlYmpd709hh8PY82OMUk1DVSM1k6hPosdanKdx9rqWtLINQgZx+wRaKcC66c2a/0Qs18uLeDVfNXStDQwnLjjjbN0iIAA6PlG2K85gOXdV8NjbS7vLG1a4Nu+gkMpAJLFaHcK686vGZHt6S307rpyYKhWzQF2IfKrDadD5+4PX6pknJtwEJviePnvLNloN2chJ2+q/BqkZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLAIvZUsnIQgRTnRkXNzGbx+0TO3Pnz/YWtMcAvDcJE=;
 b=geeFochyVEZw9dsqoAd0Lj43biW21eeeUHzLEi0Ub/3yb+eM5iFFSw+iFoBw+G8SlPeM3aPmUjlTyZrcF0PIvMM7KZG0HyF9OTqWsyViX9LA3rwKBDWLOrbUd8mcKfnxfV17Lg9zrScbf+ld9UOKpgNAhxF9LnT3TZJeLsg4QS4=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Tue, 10 Jun
 2025 12:03:55 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 12:03:55 +0000
Message-ID: <21771602-be31-4d82-9820-7775751ae7e6@oracle.com>
Date: Tue, 10 Jun 2025 05:03:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [nfsv4] Re: simple NFSv4.1/4.2 test of remove while holding a
 delegation
To: Cedric Blancher <cedric.blancher@gmail.com>
References: <CAM5tNy7kfqToA8p4-=LOnhvZuk36vocy32U6kgT+561uOWR_iQ@mail.gmail.com>
 <f84bed7e-e96c-4a7e-95e6-2a28a574947c@oracle.com>
 <CALXu0UfWN7ahsYQfvHVLViuxfb+oOsjQR8GzCHKwhPnctoV3Nw@mail.gmail.com>
Content-Language: en-US
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <CALXu0UfWN7ahsYQfvHVLViuxfb+oOsjQR8GzCHKwhPnctoV3Nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR08CA0023.namprd08.prod.outlook.com
 (2603:10b6:208:239::28) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|SJ0PR10MB4688:EE_
X-MS-Office365-Filtering-Correlation-Id: 5042ba32-2c3b-44de-9991-08dda816dffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzd5cXFicWZhTjdWY2ZqOVBUM0U3UVFnRjE0dFV5L1pJRDIwMWEzdjA1N0ZQ?=
 =?utf-8?B?MGp5bkRkclVDKzViWDdNWm44Q0RENW9MeXAyelM2Wk5tQTFpM1ZhSVMzS2U4?=
 =?utf-8?B?R0EwaXFuRDJtMXluOFdINDEydkNQa3ZQMlRyYVNPRTlzQTJ3VVpTZkl6eFg3?=
 =?utf-8?B?NkhaV2ZRb21FZWFoQ25EN3lWOGdpY3VsVDE4ZU1UVDdVeHVxOTJVOVA5TUxT?=
 =?utf-8?B?K3NRUlJaTGtlS25SdmVocnNnTkJsalVZV1RFWTJxSzREV0xrM21mOHRMWnhm?=
 =?utf-8?B?MTkydlFaZWtxc3hyVXdvb0JlQkFPMXdYMnRMMzgwV2MvZFh3OVRFYzByTFA2?=
 =?utf-8?B?bUVXU0RjRllTNCtsZkJGeHNCUHhleklCcnVFSmtoSVdMU3JpQlBFNFRzSENy?=
 =?utf-8?B?a0JUTUwxc0ZBL2ZBQitsWXlncWZwLzE2Nko0TWN0amgxOVBoaThFbmNqd0pF?=
 =?utf-8?B?VWIvam5rU2pjMm9RM2Y3Vnk5amhCcytUUU5ZaFp3VDVUMEpOYWRyTDJwbXo3?=
 =?utf-8?B?VURqUE1Hbzg1Njdodk9VYnBHb21VSEEybnJZWGoyNDJ5M0pZbzBQaXhtMndY?=
 =?utf-8?B?UW9ITFJxZ0QzQTZ1d0FBbjhaUGJyREdydC9FK1cwV2NHbFovM2I2a1hSS2h2?=
 =?utf-8?B?cGllTFI4dVM2Z25oZmFLNkJvNHlLUlNNVkFTaVVISHhZMTBvTVZOUmo4ci82?=
 =?utf-8?B?clZKUjk4NFV6WEFNdllNSU0wcEtDS0hJZFNUYWRiR0U1ditkd2NKYmk1VUI3?=
 =?utf-8?B?SXRwcStjN2dZS2h3TFFkTGZYSnk3WVYxb0w3Q3FGRHQyTjY0WVk4c3dJQXYz?=
 =?utf-8?B?K3ZQTlE5TjZtOGlESzlFT1p2QWtZY2xvbmcwZU94RVZlZEpTMVNmWG1maUNM?=
 =?utf-8?B?bXpZZFkvQVYyVmlEMi8xbVRRcklKbDhNVWw0dmRNbE1JSGtMZlM1YlBoZjN1?=
 =?utf-8?B?aUhjNFZJQjl0dUhqMVR0TnZMNnhCaVpPWVRNK1c5SEF6T1pXdnRhZXRHZHpT?=
 =?utf-8?B?TXBnM0JSWHlyak15eUQvRkJrK2JuZ0YxcHV5OXlyMnUwMjM0TWtJZER6MjRN?=
 =?utf-8?B?cXpZaUVYYkMzQm9DNWNBcHNvVjk0enlpNFREcVdGNy9VMEFQZ0twZDJZY0Ey?=
 =?utf-8?B?T1pucTFibkkvTUo4T1JVYUcyMkJWR2pnQXRkazliTXg5MmFOMmRoUzMzL3h3?=
 =?utf-8?B?Ly9WUmkyc0h3ZnBLcExqbS9uT0VKV3B5OEJoNmswaUx4RHBvZEZLcXRscEJ6?=
 =?utf-8?B?NWhSWTByUGRnMDB4N3FSZEdPb0hLL1dWeENuaFNOQTlxOUo4RWV0UkFhRjNG?=
 =?utf-8?B?bU85eHN6KzBROGFFSzJwVGtxc29Bb3N0SDMvenBld0p4bWV0K0l6Nld3VTR0?=
 =?utf-8?B?TGJ6SmhqQjFsdkdTOGk4UkM1VzJFQ2Y1Qk8xamhRVEorbHBwODhjR05SWG4x?=
 =?utf-8?B?dkh0SFBIQVBOb2tRbHoxeEpsUE9oZkRmd21YTFNncnlyOTB1RmZUZlJ2SmFw?=
 =?utf-8?B?WmRLUCsrYkllZkhHOUg4S3hmVmZTQk5vQ3BpdWZoMTdCVWNKbXl0a01weWxH?=
 =?utf-8?B?MTF5R3dYWGJyeGRHVEkzdUNuZXdOQkJUNkg4ais0Nm0rTjVXczhhNi9RQlcy?=
 =?utf-8?B?dXRBNUdOQmJoNTNpYWJxd3YyZW5WVmlTY3QrSlZqTjdFcTBmNWFXWTNncTd1?=
 =?utf-8?B?djhvSXU3YmdxVWJISnpFbXlaekVBTUNLbFVoZEZMZFEzK3k1dGJPNWNPSGlS?=
 =?utf-8?B?ZGFnRjh3YWRMbUthUzEydi9FcnhjMGN0R0JMZURCRmY4KzhYVTZHM0dXeTVP?=
 =?utf-8?B?ME1RZjlYN0wyQzc4UzQ0TGVoRHJkY2JXOTJlWDVTRG5MMXROTWV0Mkl0MGl0?=
 =?utf-8?B?S3hsZGsrTEx6eHFpWFlGSUYvS3NJcWZqWTBWOGVaNTgxeUQ0QzlNTzA2QW5q?=
 =?utf-8?Q?eTsO+aUT1GY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEllc1VodUd1djdUd0lnL0Z6dTZ4Y2UyOFhrL3VyUXNwS0dRWmhEc0VVU25C?=
 =?utf-8?B?YnBESmRNd2pVb0k4YVlqei9zVUNTdGYxcTB2ZzBRV25LY0I2cXlWdndIV2pW?=
 =?utf-8?B?VkV0QjNYVXh0M0tuRHhyS0tiVEFBQTFKMnVDeVNZVWgxbVZYSDVjb0dLNHNZ?=
 =?utf-8?B?Y2ZiSFIxQThLMVJQTEx5Ukc1Ulc1VUxheGZTT1lWYkE2Myt3eDFhaGcrN1Nh?=
 =?utf-8?B?Qjh6d3BwNUkxWUE2UVZPSkRzczJXNjdWeTJ5Lzd0RlpDZjYxKzl0SG44RVQ1?=
 =?utf-8?B?cFNqQndBdVdhSS9Yc0FITndybXBMV1Y0RGpteUw5VzZGZmdOTHN5RjhSTFlC?=
 =?utf-8?B?R3BqcEFHNjlCaTZjME45R21NL3NWcGJ6ZEF5R0dRRXp0SUhwNDVDWXkxQmxj?=
 =?utf-8?B?cEJKV2FpN2x4ZVByNEpBM1kzMnZWbHFSYXhjOW9rbm45ZEk1QmJkNmRrdHQy?=
 =?utf-8?B?S080RWl6LzJKMUcvMnd3TDZVVmpmdnRhWjNkOUVTV251SGN3aEtLT05OYndI?=
 =?utf-8?B?WGFTQ2p6UTZZbDZmb3IyU1pFTFV6VzJwT1R6aU40VzAzNDk5eVVxaXAwUWxI?=
 =?utf-8?B?cVFDeHZrc1VIZEZYWHhhNGhTN3pqdEJTbmtLSkhadFdFeG1pOEFSR3hvMExS?=
 =?utf-8?B?KzcyQzdkemt4ZnpneHFhTng0MmlkWTFScWVGWFJrNFd6MFJaQzVwTGM4cDlj?=
 =?utf-8?B?SmIvWVRkVUFlTE40OEpST3M4cElMc0Qxc3hXSVpCRXlWYUJ1WjFnTjNDMXJF?=
 =?utf-8?B?dkIzR0M5dWtCalN2dmtPRllvSjdiTXBoZGliZ1JDMlhiUExkanJMTk1aZEdz?=
 =?utf-8?B?YWowZy9nOER4UkFDTzBOdmd4TmZVd0hHNHZWcFU2c01OMnlkU1NONUl2cXV5?=
 =?utf-8?B?UFFRWk84RVA3Qlp3Uk1UZEFVNXcwckRmS09lTzhPaVZESWFaRHY0VCtSZ0U5?=
 =?utf-8?B?SHlDQjlCS3VMT3k2M2VpaHkyQTBTQlRZWjQ4djFRbmFiU3pyellNalFDQnow?=
 =?utf-8?B?eVNwYWpScFNFY2p3cFM2eWg4RWs0S0N3a0hYUktrZjk1VVp1N0ZCS0cxNHJF?=
 =?utf-8?B?VVdUNE5BTlR3MjBHbStSZVFpSzhJVWJhV1M2S3pOajh4K1pRMjV0cExwUUdK?=
 =?utf-8?B?OGhDZUprSzhQckpTNml6M1BKWUVwQmZiWUcxL1BpZnN2RDNxWFk4VXFuVkN6?=
 =?utf-8?B?TWJhZllsOVNYYkdlbGNDUHBFbnh4RHg3QjR4ODhlUS9XbFA0RGhZVGF1UnNE?=
 =?utf-8?B?UFhicGptQU00WXJwRjErc0lvWFpIMFVtUFhuZ2lPTE1VU0VPSVo0WlBieDZ4?=
 =?utf-8?B?VjZCWlEvdGQxVmNrSWR6QnIwR29GQUVMMFN0Z1FDbTVLUmJjSVhwd1FjamRK?=
 =?utf-8?B?TVRDRFdVaWMwSUN0dGtDcUdtU202NmVTK1dPaVg5bVNkVkIvYWRuUE0rZzF4?=
 =?utf-8?B?cFEzeGJNdy90anlLSzNsN05SNTZxYjBjREpFVzUrTERudWJFSjJlNzc5YnVt?=
 =?utf-8?B?dzFnY2pQQjMraGVES0R2bCtyTDZ0VDdFM21aNmovN0g1ZllKZHZ3K3NHT0Va?=
 =?utf-8?B?dndRdVBCRk5pV0l1bGdCMnhTLzV5MytDQk5FVXpDNGZQaGhMUlJQNnVGSWJN?=
 =?utf-8?B?dWhwQ3JlWVFCd0YxRFZJRU1aSCtXdnphM090YmoyeEEwSkF0d0d5TCtGUWxJ?=
 =?utf-8?B?UjJxRWR3dFJld0o3WkdiV1N5alljdUVnYVROazV2bEppSS8yNXc2aG9yMDND?=
 =?utf-8?B?QjlPNlQwNXJxWFJ3TWpDNnQwZUtldzAzanlCbHJQZWNZeE9xMndFdmlSdkNn?=
 =?utf-8?B?WDJMZlVWMTNOV0RJcHdZWjl6UEUyRHpnOHo0bHJGVEh4NnBRY201SFVVaVgv?=
 =?utf-8?B?RnpyOGZGV2NWOUl4cUJIZ055ck9Vb2txREFJbGVUTUZtUjRrOHpTWDE5bkFh?=
 =?utf-8?B?UC8yZW5rdjY5dkpKU3FLSFBTYis1TGN2WlpwVk5Pajg4TytUL2dUN0FhUndt?=
 =?utf-8?B?azYxbDlGV0k2VGJ5TXNQU1hXUDJKMldYVWNhdU1MdkN5VnhsWFBIZjR1UERF?=
 =?utf-8?B?OVcwUFZMZmZZSDAzazJZSWpIZ1lIM0ZiNVlzZ2FoOSsyd25SNm83cktGK0ow?=
 =?utf-8?Q?Wk4j8yMh7B3p1RVASXPo0/bhz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zEAbIZpJM7uGQCtWc/e8jdgqwB8KQyNwc3sEXmlKrPVkKnQhJ53nk51NACFXuC4HpJtNXHfCm70FCZ89SxwM7KbuWmmJaZqc91RZo5IHQZiYsy4DysuSvE3AH8oU+CVq8zKxaqgm+vyPl2dOEVo+kd88wrJ1hbyvBqXGoeJhXx/51apsBsnjPrAErACblKOPQRbUS0yoGyjw5neDoQHYeMWTCUq/N6YUsWh0SFXaOZKEjHzKQQVtgJSfs8P0dGIZXlD8d7DIfRczW1uYS/KyJ8BBGtB3D64O/pyL2yMnnewzr3rqSuBy0KDAHfXRWWKaOJGUY5c/Ocem3MhV/MLLBXxh71aqFK+tl/5UC9E/yIfGAu3gqmU02tFe6QIKN45M/wWUTEc8jypHuLtD6ZcyxnlBAgotIyeQp7WF8vjcx1JYWyVxDvkrfPyJmQf5Nmk/nkLhT+lSg38J2qqrlz05NaoH4bT/qdw/bBir/pJKR4tL2XAO8bOe8GUWj3WGqzOlMM8vlcc3nRNtRKqG7mZpOR4OPZpfmwmE5t5jr/kq+nWWYfJfbzINGUNJKpACE01AMMw5bIP+MBYs9kV/iR6CO/1BoH8cMwXSo5Xjevmxa7s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5042ba32-2c3b-44de-9991-08dda816dffc
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 12:03:55.9202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8JIm3nDevWm+K9McToDYjDg7fASDDvBh6hWHQIsnPnGC/F7emZB3FdLscFfCEFfqJ9LVkP6oIapT3s5/Bv31Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4688
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_04,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100094
X-Authority-Analysis: v=2.4 cv=LIpmQIW9 c=1 sm=1 tr=0 ts=68481f2e b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=48vgC7mUAAAA:8 a=abqUzUGT0krc5ehHNKwA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13206
X-Proofpoint-ORIG-GUID: YcqLOqPua12i2WVGLeOBBrPvN64uAAqN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDA5NCBTYWx0ZWRfX7eub2Bgh+R+5 YAgn3ztcV8y7qokIbbpjRpYWpwh3RXMfkApHmL5TpBbXf0HVE1rGBDGtP96BnNOsbcXzPBPE5gb etDxz7P0nX34J8IG1x3ZCTR2hg2DdvzitjhIaiAk4jLHpNboJ176V0k7hDPJLPWUlVJ0YuPKrK/
 5So6I7eD9/44gLuIvT2FwMDpma0BKFHg+r6kjCMmw5On8HtrMf5FkpdW1un9I63dDwhco4FzoHY v3G1gl8mSh5V05C5RcjxXIrN3y5Hhr+qP2IlF3gm+DzhnvIfnGptnwVzxpVGAVNCzKUu6iJBToE +QHI2U7LFJgWu3xXTljFuRY5o+Crd5u/s0oyIGXLpitZjiNoHd3NTHkoYBkSZ6ewIZTwTW6noVy
 NSzKshxPmjQbou+MGppbCUsx/RUwS4qIU3dt4zBZW3Z7LKC5jZDHdypvX6xoKcGmpW2JZEQH
X-Proofpoint-GUID: YcqLOqPua12i2WVGLeOBBrPvN64uAAqN


On 6/10/25 2:59 AM, Cedric Blancher wrote:
> On Tue, 10 Jun 2025 at 02:17, Dai Ngo
> <dai.ngo=40oracle.com@dmarc.ietf.org> wrote:
>> On 6/9/25 4:35 PM, Rick Macklem wrote:
>>> Hi,
>>>
>>> I hope you don't mind a cross-post, but I thought both groups
>>> might find this interesting...
>>>
>>> I have been creating a compound RPC that does REMOVE and
>>> then tries to determine if the file object has been removed and
>>> I was surprised to see quite different results from the Linux knfsd
>>> and Solaris 11.4 NFSv4.1/4.2 servers. I think both these servers
>>> provide FH4_PERSISTENT file handles, although I suppose I
>>> should check that?
>>>
>>> First, the test OPEN/CREATEs a regular file called "foo" (only one
>>> hard link) and acquires a write delegation for it.
>>> Then a compound does the following:
>>> ...
>>> REMOVE foo
>>> PUTFH fh for foo
>>> GETATTR
>>>
>>> For the Solaris 11.4 server, the server CB_RECALLs the
>>> delegation and then replies NFS4ERR_STALE for the PUTFH above.
>>> (The FreeBSD server currently does the same.)
>>>
>>> For a fairly recent Linux (6.12) knfsd, the above replies NFS_OK
>>> with nlinks == 0 in the GETATTR reply.
>>>
>>> Hmm. So I've looked in RFC8881 (I'm terrible at reading it so I
>>> probably missed something) and I cannot find anything that states
>>> either of the above behaviours is incorrect.
>>> (NFS4ERR_STALE is listed as an error code for PUTFH, but the
>>> description of PUTFH only says that it sets the CFH to the fh arg.
>>> It does not say anything w.r.t. the fh arg. needing to be for a file
>>> that still exists.) Neither of these servers sets
>>> OPEN4_RESULT_PRESERVE_UNLINKED in the OPEN reply.
>>>
>>> So, it looks like "file object no longer exists" is indicated either
>>> by a NFS4ERR_STALE reply to either PUTFH or GETATTR
>>> OR
>>> by a successful reply, but with nlinks == 0 for the GETATTR reply.
>>>
>>> To be honest, I kinda like the Linux knfsd version, but I am wondering
>>> if others think that both of these replies is correct?
>>>
>>> Also, is the CB_RECALL needed when the delegation is held by
>>> the same client as the one doing the REMOVE?
>> The Linux NFSD detects the delegation belongs to the same client that
>> causes the conflict (due to REMOVE) and skips the CB_RECALL. This is
>> an optimization based on the assumption that the client would handle
>> the conflict locally.
> Does Linux nfsd have a setting to turn such optimizations OFF (all of them)?

There is no setting to turn off the optimization of delegation recall from
the same client.

-Dai

>
> Ced

