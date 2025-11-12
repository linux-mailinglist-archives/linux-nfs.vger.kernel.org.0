Return-Path: <linux-nfs+bounces-16305-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 26965C5345B
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Nov 2025 17:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DD4BA355ADB
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Nov 2025 15:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D23A335071;
	Wed, 12 Nov 2025 15:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fatwlsYt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AkpEPnl0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC30311C3F;
	Wed, 12 Nov 2025 15:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962580; cv=fail; b=ML4/IdEFQfevinA8DkCiIKnFbFKePN3C63QSiWrTk55+ruPeSOwJ4Kp0fgq8Yp4WZNoTHvApCyJtAXv99fQjUInWClFtR4nEKo4DNNYdWHxuHICnzolyEAz7hzHEP809vtiigIs7mZLr+6kbPBovEUP+BY6k9CVpx5s91iU8pX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962580; c=relaxed/simple;
	bh=DOkL/Y6kczen1Jyfi//QBQ3/xezhGfwU4Y05oEZtX7Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IthlIXRVHuoydwx8x7T4xL0xhLZxzIiQ1mACNiW4OSDnBB12yg2iRE6WEATMh3hRRr9qPId1vTV3MlNlfSYhXtOdHqOZLMHfhNoDST5/OQpyqf7yBpaGRxZJ7Z37i/iQxNa6G2hWEPEda4NA+RPwP10GdefbKwSeaphb1FC03+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fatwlsYt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AkpEPnl0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACFRMCp010513;
	Wed, 12 Nov 2025 15:49:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=J12i2jf17GQ8pxxEtqISy6yXeD32UsIux7vfOuI1UGs=; b=
	fatwlsYty9YRtgEKxciGQ7EjUqP5QZgPmKxKAUt2T9HXCqsIs1BaCRE6OE1Qx8FX
	+7xnEZRBzTYXBNQ0ndFA8T9iN8j35mFhMRMVCmLZeQzlnI9phFCjjQPzX5S70sZ6
	6z1DvVyLUo3Aw7oo3TL1gYoBDWmyKropFKzZijsmt+QT0BBPUAhrXf6VYeLctaIO
	GIZEffONWA0yEMHw4Yj0ot9szpZP/l+iixOLcD7ANuZv4JHmlvbVWadTLPSAVW4U
	V6nwb4SItxD7DyrUBD/2/hJI5H6s4PAZl7+JHhRoRSuEi8LfM70M3EdTjvoeAhr6
	cnP3t1xD/mof7snBFo1/DA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acv2vg6wm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 15:49:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACEG4gk011524;
	Wed, 12 Nov 2025 15:49:17 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013037.outbound.protection.outlook.com [40.107.201.37])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaecr3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 15:49:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+S9BhJpUgDHwMurIWVQvMAV3ZFz/cWFiH76mKsd0ybm9GR+NC1QwmVbI84ozuwYcMzD4A+lkKZzHlBaH7cbo0dL0ceCaNFQht5ObABWHeSWNpiSS0KVTi8MQrdgvtRCugsyEk9jydj7Ib1cpDTTp+oykpMqLRrNWcDVQNohpny8HOh9cJAa3hf2yXVIcb4zun5XdX43YxwGMqBHp7CFgZsbu+Z9OogqkJoKs+tBIpzhu0bt1wZa+TMiyr3S52ppCQuINpMSk4KDAjtN9/JLqMkJz41GAv1bzXnmQFJ6p36AAj7RSOqd0s4ggcsiri97Q6UNAKULJt7tSRZRLFqmPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J12i2jf17GQ8pxxEtqISy6yXeD32UsIux7vfOuI1UGs=;
 b=DufNONq8iSPWyRrW7+eF8H1Ep14aft5K9mO6NgiXg7yib8kH6/AwwBjskkNsxLHqeWP82h9gi+D3fXPwL6e5MU4H6ocaMZkk7kq9logUMPa4hLS8BFkTSdhmF5v6IZ7IcyDoaAZNnSh8cB8JbkaY5OsNQnjr1EiTIs5s7vUggCUcDEUzgDUI1OunTLTsVAiw9fDmt/yIwYqF5moAnU/3a823APbDZxkoi6OytqO9nL/9cgtVsfc3Ornr+GxPiv3qWW/n2s1M/0+PPZnhnywyjGLcO9+DyXim22JEYEeKux0LYzmKyC549/6ImHS4naSzkErEavilKF4xEvvNCGV7DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J12i2jf17GQ8pxxEtqISy6yXeD32UsIux7vfOuI1UGs=;
 b=AkpEPnl0SV5nxvKMf5BU4UKw+qAYDtFoiwQmkjrWEI2K6imPaoV6VjAWWlD6E/C2NJ5VTgLsHkpHDPigrnnUk++GcQahTDI4iHbSSNcZsxyNj4g8TUgj2JP+VRr57G+wJVpNduK81KzPuoWOotdg7MQQcnpgB4VH1+pP2yXT2/8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6148.namprd10.prod.outlook.com (2603:10b6:208:3a8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 15:49:14 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9298.010; Wed, 12 Nov 2025
 15:49:14 +0000
Message-ID: <3438a873-bda2-4a1c-af8c-76e31a200c79@oracle.com>
Date: Wed, 12 Nov 2025 10:49:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] net/handshake: Support KeyUpdate message types
To: alistair23@gmail.com, hare@kernel.org,
        kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        kch@nvidia.com, hare@suse.de,
        Alistair Francis <alistair.francis@wdc.com>
References: <20251112042720.3695972-1-alistair.francis@wdc.com>
 <20251112042720.3695972-5-alistair.francis@wdc.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251112042720.3695972-5-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:610:b3::7) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB6148:EE_
X-MS-Office365-Filtering-Correlation-Id: 28ee9929-1a85-438b-658e-08de22030791
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmowY1hTYUxxekNkNWF1ZlVMbkFFRThrWHdPWm5Pc2w2WDRrYVRJaGF3Y1JX?=
 =?utf-8?B?MXlPaGtRS1dYSldIMVFyVzJTbVpkaSt6Y0JpbzlQRTIwVTlZQTk1akE4WnpY?=
 =?utf-8?B?WDZveUUwbVN3RVp4cUVaSDY0TkRvUWdEZ2c0emx5aFdjelAyQ2Y5VjlzWUxv?=
 =?utf-8?B?eGJraTIxKzBBd2NKZ1BubzM1SVlmU0NJVnF1RHE0WmovY3owOUNCMVV6VGJp?=
 =?utf-8?B?UkNDMXl4RGtMaHNMRFlKa3FjR1AwcXoreDFubEQ0ZGF4VnhwMzRhd3QyenRU?=
 =?utf-8?B?SGMxeVdOMTgwU21ZVmREdVRnaTczY1Y5VjZjcVhnVXJuVGxxd1JPZ2hRN0pP?=
 =?utf-8?B?eGJUSk1ZejI3VkxWUTJVT1NRSDNoWVdiVzVnYW1wbS9XakdVUVFqeVFyUjRI?=
 =?utf-8?B?a1dxejN2NTJLVmladk1nSWJaUFpoSWxjZkhiN0tYV1l2cUt2ckJmZW5NNkpW?=
 =?utf-8?B?NmpoYk5kUkplbFpwekZaUkNIcFdoWkozSnAxQmRDZVpHM2pYNjBoRGFxWERO?=
 =?utf-8?B?K01POVFTSU0zQURwSWdYNnRucFVRdk4zeUJYVUl1WGZzU0ZrTUozLzY4QkIx?=
 =?utf-8?B?YmQ4bUR0QlFYaUJQRzdaeEJRb3pzMlBpSnhzYVQ4bzc2dlJIK2c3VDA5RUM3?=
 =?utf-8?B?cnpQV2tGaXlaSXhPNWtCVkpPaEIrU0M0YmpqeE1KMEZHc0MxdWlnc2VPQTZL?=
 =?utf-8?B?cEtmc2QwYWNYUlNiY0QyUzErek0va0t2WDFoeUtHcHp0NjM3MHBncmxIaVcw?=
 =?utf-8?B?bkVjQkRWNE1yVlUzd3B3WGd1dU53bThlZ0R1ZFZiMDRqME85UktPc3hXeW5P?=
 =?utf-8?B?Mm1DSUkwbklvSU1jRFdTQzZaSXp1ZHpNZlFSTld6YkN4Vk5wczVSeS8zL1Zi?=
 =?utf-8?B?Rys3b0c4WEVjN0M2L1JNanRxVWFjMVRXaTRlQVVTUHl0bUlBWHkzd3FpWjF0?=
 =?utf-8?B?eEtHSGtOSjN5MWdaTnp6Wm1ZQUt3NlJmZERmRWRWOHVhRnpieExGNU9vTHpL?=
 =?utf-8?B?NzNPVzJIQTlEQkh3OCt1dlNvb0xMTzlwbzVTU1B5dDBwcEhwOXBJejY0OFVK?=
 =?utf-8?B?SUZ5TFFwME1yc28xSFlzUmg0aWs3bkxQaWVmREg3ckVkZFBjZ0cyWFdqem5Y?=
 =?utf-8?B?d3dqZ2p2NVE1alZJeVl6YTFZNjZLTUhJTE9jQW1za3JOS0FoK0p4UWhFMWli?=
 =?utf-8?B?R0Q1VkI2SkQ4M3JMYlFsL3RzNHhnUGpmamZxb1lLa3JDdWNHOUg4SVJqeU40?=
 =?utf-8?B?S0lyMVI5WnFXaWRnWGZyYlNSeVJobWlqdFZaZW16eHBQeGR2TXB6QjM4alUr?=
 =?utf-8?B?OG5wbjV2aFBvbjAzc3ozQjNNUkFtQ1BqYysrL0tmSzR5QjRpWEhkVGR4REJC?=
 =?utf-8?B?N1U3Z0ZicXpkbjdnbnlxRGowSXRLZEZPKzNYTEUzVUloUkZDZld1dGw0OUpV?=
 =?utf-8?B?NXB6RzNuM2t3MGJFdHlDdzhDdkJpc3Zqb2NsVEZkd0dQM1BrYVRsVlE2aTlS?=
 =?utf-8?B?VTBmUlpHUFIzMGpMbHNaZjFESmlsUEFCV0Q5Q005ZlFDQ2lkMGNZNWNFdm5t?=
 =?utf-8?B?b2YyUWtjOUtoUkwwQ2pMTktDbjN3SXBmZWthMm9pR0crLzZ2bG1IRk16K2RE?=
 =?utf-8?B?V3gxMmMxcjNtdHBWWG9hUlY2RVpQd2ZhQWtnK3l2YUpTUHRuOHhmY3FaTEpP?=
 =?utf-8?B?c01mNld0dWNLVTdTdVFYTXZ6ekUzL0FraDQ5dXdFWmtudk5JeTU0KzJ6b1N0?=
 =?utf-8?B?WjlNb3lZY3BsbmVOUkZyZ1JFOHp2NjMxdVFvYUlGMWVXckpOMlpRREhVcHRT?=
 =?utf-8?B?SGVRUDFxZXJuaENXWEF4L3JIYitUc1hObHVvUitmbjBNOHFVYVBNdGR1YzFB?=
 =?utf-8?B?T29CQU8zYTNUbTRUdW1ZUTVMbmNLcHd3U0hPOHdqSTBZSnBYM1FrSkM2MUxQ?=
 =?utf-8?B?aWUvK2NDL1Jtck12QmVMUEFuYnBZMHNPd3hLT0V0M3NVd25OdVJZMWtwM3Mz?=
 =?utf-8?B?b3NGWU5qaUZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVZtSWNLQWJpRzNWemMwWFloeEs3M2JHQ2grdWRDczU2M3BTZ2QxcXJZbmQ0?=
 =?utf-8?B?WG9aSHROazZaME0xVUx1RXpxYW1iQ09wU1RsUk5mbEtTN09oN1ByQjNibVVZ?=
 =?utf-8?B?WXBVMENQTzFtS0dRRWVGYmxoOWptOVU3ZmJQWTZMSFVwbzhrOGU4dmh2S29D?=
 =?utf-8?B?VkFTQWhqcjNmcjVJYjZUV21lSkRlODVWZFMrMVZyeDJLQmEyL2ZwQitLTHZi?=
 =?utf-8?B?MVBadm9YdnZZZ1NUaU8wK0Z0Zm9kQ2hleWo4bklyeENxRWxtS1ZXekR6ZVg4?=
 =?utf-8?B?bXJTL1FCa0RrWkp2cUtJb0s3cUVtRHhwVHJLOHBxQU9tTzFRYkZPb0lIUVVU?=
 =?utf-8?B?enFORi9jTkhsSEFuREUrTWM2b3REbHY1TkhKa05ENFFqTlR2WUhvS0c2aXp6?=
 =?utf-8?B?eVRCUFVUbmo5UE9qQ1JPb0NZMlVCb0pDR3VZY1hHOTM3UHE4cHM3N2hGdkdv?=
 =?utf-8?B?QXlhNHZBRE53ekNVWFRnQ3J0NGxRQjIwRVNueTZVMnpmeFpQZC9rdTBia3JX?=
 =?utf-8?B?Sk5XU2xoV3FFRlYvdS85YU05dzY1ZjdYMzY3NjBCbGlrZ3cyMVBLN3pNR2c3?=
 =?utf-8?B?dW4zbS9zRTVnL1YzUE9iamVvK09FSkREQXcrRi9ZdHBCNGtSVE1mNjNwaEtq?=
 =?utf-8?B?V1BvdVFnUnRrRHNnUUl4T1hPYmIzd1ZiOUhMZkZ4Y2I4OEltaGZyY0RnR0lq?=
 =?utf-8?B?ekJ4eWhrT2dyNGZ5eWRrWVBNTE5FSENqa0xSb0ZKNlhSdkZoZjJ1YXh2SkQ0?=
 =?utf-8?B?UnhwNlkyekV5OVRta216QXVaZisrTk5GcFJBQ1FsaFdMVDA4bnVOTDNGeEtB?=
 =?utf-8?B?THcwU1dOdkJmRzB5b1VDK0w3VlJJMFpZUkxxNTkrQ1RteGRXYjZkUVEyZ3d0?=
 =?utf-8?B?ekZtb0xDeUJoeTY3S0xLM0Q4OERXTW9TQ0dyMFRuUUxGbDZpdDFhUlBFRHZU?=
 =?utf-8?B?N1VtbnZhbm1TcFRFQWFGbFBrOXFVK2p5bDRnVU5ra2gySkRYcFlZODczOFNJ?=
 =?utf-8?B?dXlkeXlDRk1BUUFmREpzdUkwVjRLbEg0eEEvZWJZOWhlQjhKR08zaStZQzdu?=
 =?utf-8?B?YU1HNytveDF0cUNaeVJiRktoMFZPcjdheG9uL1V0UTl1L0xrQ3A2a2gxMkUz?=
 =?utf-8?B?VVAzdzFicURwRUViWktGYXdjcGIzViswRGh5TUZQQ0NuajRWSEdvL05lVXFK?=
 =?utf-8?B?cCtZWWJsNXBkNTZEdExEV1I3WW03dEZYZ21MTmo5a09tYXdKS1hWdXV6ODhZ?=
 =?utf-8?B?ZlBqd2RhZUUyTU9jZnBMc0FpeEFMOFUwblVuUVZjUFlvbTE4UzZXajNjWXZz?=
 =?utf-8?B?WG1BZTJ1V3publoxbFNVdzYvQ1lhL083Vk1CL3dLcEtES1RZenlYTUhTNDQ5?=
 =?utf-8?B?bGRsY2RqNFM1Y3pmRUtzendnZ1krbCtaWmdhS0szQ2tlTWVtbVZMeUJqclNh?=
 =?utf-8?B?b1NUTS9yL2VOS0RBcERrekVSWGR0WWk1cHNCb2ZENGVSU1A4aS83YUoxR1ZT?=
 =?utf-8?B?UE45RC9UdDlVWUdIM3hPUnBiUlhISmRKdit5Z2Y5Y25NQ3czNzZKY3JFVnNy?=
 =?utf-8?B?RFBGNTU4M09qSkR0SFhqaUhhdFB2R1BRMEFLaWlpU0tJYkpGUWFPbi9yNHlJ?=
 =?utf-8?B?NG9wSit0RnN0SGV4eDFuV2gwVEdMb3VRRy9mQy85ckFKRmRyL3ZZbG94RUVK?=
 =?utf-8?B?QTd3NVhvZlQ0N0duMXd5WmVEVitzYkI2clFsR1E0dmRxRmpYMG1DSUxHVzRB?=
 =?utf-8?B?c0xjSXFtd1ZMQjY0UFdUVmNvbGtZN2tUdmEzWExlL0dMdGVnSktpaHZPRVJY?=
 =?utf-8?B?TXBPTnV4SjhFNFREcWtpeG9nVHUvWjBYK2s0YUNMTWd1VnArUDJLQnE3Z1h3?=
 =?utf-8?B?T1daMll3bDFKTENlRjJaV0NDeGsyWVFSU09pbGZEdHdsTndUZjYyWHMrMWZY?=
 =?utf-8?B?dFh2dUQ1elNwZllYNUpuUnM0WURYWlVXYzE0eGIzY1VmUXY2SzNZSGw2Skpv?=
 =?utf-8?B?RzVJS09EYW4rUFhqT3AzQnJiYkEzd1lVUlNsekdwTkZiMUxxa1F3MVcvZURr?=
 =?utf-8?B?VDl1WEJ2eSswU0I2Z0ZIVU5IdVZKTFlLTmQyVXQ1cHMrdXZHMFFpd3ZmajNH?=
 =?utf-8?Q?Tbbgy1R5Rp7bNSOCyEAHdpJQi?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZYrVvEX2qfLdSNnqQ49jYyY9LpCRaHRKi7fk2+qZQYlC+nviB9FjM4xOhbNU0KoT9a9OfjACfzUle30BEkmRltqW75E+6uMhfbuBYdVZ6CjljGd3FXzI0YlLBnNMY0KL6lyKfEXOG/S/I9rGBksso16JQz5G1B8OeSuiQMnpyIQ2o69pOR4R0dj2wuQLXO+0yXy1pIKIB+x2t3dmLkXxl0jbSLpazwIIwCNvUARQh1y+k3zXd7aP0056q+3uWi+bxmUWdELqeL4ahDYrSWuICQo7Wu4Tjfd/RgBaL3ECWto+7jJgfSudD/Pkma5YrVPG0nPQtABPwKX3knE8uv4cOaGb0KyqEEz4PmT3IKib2XeLNtqLFfRRSA8OXPNqV0q6ttTG5hPdjZSHRDpiamxw8g553Ltw6T10ooheKhf7K0qZC8M/chussU7FU4qWmgvrw8+//tGwCd2P3KGl6KscszK9mCVYU9K4fDqtnVoXKSmAtWutGtNZeyv1yALI6PKWfqR5UWjjMMtjR3Gq0oBpWaSdVVwnCj78TdATArHKZz/kZ3rLJR1pxECkbYXvB+i/c1OIdifdpqA0pZFAbmGUIiSxBpzAAIVGz2jcQVewqjM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ee9929-1a85-438b-658e-08de22030791
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 15:49:14.1557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CxicSb5qw1MUf7pBwxCjiyVgyC838oOG/s5Bns8d5iC0BmppAyy00gGVtOjASkYxpmJrn2Gj6o5dNi3dyvXxFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6148
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_05,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511120128
X-Authority-Analysis: v=2.4 cv=dN2rWeZb c=1 sm=1 tr=0 ts=6914ac7e b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=48vgC7mUAAAA:8 a=pGLkceISAAAA:8 a=JF9118EUAAAA:8 a=16ZDuRwDuFrQSl9p2SYA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=xVlTc564ipvMDusKsbsT:22 cc=ntf
 awl=host:12099
X-Proofpoint-ORIG-GUID: tSghAl6yXGGQVoqkvGY36c_p7l7DxZ30
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDExNyBTYWx0ZWRfXxq2vptxGAKWQ
 dB7deYXYXNaVJycEItDXGkBt8zOZ5yr3XKc5t64IJtKP/qVicKDHZejD5x1XTWYnInAMKHRtUCL
 pCPLRHUsCAjoWkmxTCNpokjpB2WjH/o9Hn3NjCS0a6vdtSt5wtApEYz/9dhyqlipTiL6rf5J7ct
 r8huH0P9ZrgNk6MDWcMKy6Tr/EjPWKSNRmdSSlDKr3UXEMFf0sEsNf+RIAGFO1hmlvhKM74p6ks
 K6JxfTW1RlGGEDWz3rBwJZQWlDCTAFEQuL6Icsk6Aihi9vgD6RtOjt9at/EiSqXeaztyAfnF3jL
 K4qO3qMMYwbdWFm8rvpmnnmVSNQyUUIjP3D0E2+HpEYlcOC5SngfRUZAvqJ5uVWfiN+3TiHzHGA
 C30bjwu4oE5D64sN3oMGNXx+pQ/9HOHIERSaFioO+UoBZig3kxQ=
X-Proofpoint-GUID: tSghAl6yXGGQVoqkvGY36c_p7l7DxZ30

On 11/11/25 11:27 PM, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> When reporting the msg-type to userspace let's also support reporting
> KeyUpdate events. This supports reporting a client/server event and if
> the other side requested a KeyUpdateRequest.
> 
> Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

I was not able to apply this to either v6.18-rc5, nfsd-testing, or
netdev-next, so I can't adequately review or test it. Is this series
available on a public git branch?


-- 
Chuck Lever

