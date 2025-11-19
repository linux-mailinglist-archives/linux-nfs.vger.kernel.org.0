Return-Path: <linux-nfs+bounces-16556-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD8FC6FD27
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 16:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id BFBB22F0C2
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 15:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763AB261B9A;
	Wed, 19 Nov 2025 15:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WW6iYh2N";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="chLg5+L0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF2F36921F
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 15:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567352; cv=fail; b=YVycAlxuTXucapkAHdOG3aJ+6nj0a87kAU/CeuAAFES+UtwwDaR9L5/rMUR9X0PqVREfaBS6HOizaVdOu9xqRN5cSJ99HSTnHEtlAKaQ/dmkWK5O90zFojJq47aJYioSPkI1WEhgdWD1CsoY+9TBCTZVY5zHTnvT1W9AlzvuBdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567352; c=relaxed/simple;
	bh=W8/0xmZfcRVMXDJUpYvaiE9yKJ+ZorZWvithn0EDyS8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n/USJ+VxZhBLoF3ykaFpgxwbE/Q6eJGxJC5T0ywFeS47RCA6xwcGoTyamH+kZGuOToCzMsCzn86aF+8egSO7M8y1URJxwuFKgdrx91zEMd6C44X/USakKzvl4q6jQcpAzGkCq6T3h/Ya096w6ZrKoQOCTWidmH6EymyFmOSKPjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WW6iYh2N; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=chLg5+L0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJEfuhQ011388;
	Wed, 19 Nov 2025 15:48:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=MqN/NUWfovs9CklPL9RhiyTP9KdM5Hmh+tqc5rNHsvk=; b=
	WW6iYh2NTr0gsfQPOBsIk9orJLGNqBv9JwGDI7Lxj3/mQNfE56NakJw0sLWBqX1f
	v90BGECj6WKoUdt2kDkkelyr/pQDer09XTa90kv4nKHOq+vy8+qeXvGdGJUV6GdA
	bfAqHh7jK2S0u9SQPJhTHq3RC0Qow3y0NkfDb3E/erj7D5SOeasXCnDvGpL9VUgE
	C/mYVmbx89AyPX6fpq3Yrcelj7M9qADW6OYBY/3RHlW8Mdyw/4EkasxMMzt8DsjV
	ntYYFKD2xY4PMz7Th75kMmW3AwqpZ3NiafuUK3aa6C76F+rW9CoCyhPHAb/h4Jvv
	ZogKA5sst0U425kBdjrMmg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbby7d5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 15:48:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJEnrDF003405;
	Wed, 19 Nov 2025 15:48:57 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010010.outbound.protection.outlook.com [52.101.56.10])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyas625-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 15:48:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYZj8fB3JTxYh42YZpRppw36fKugbmvijFVmhMeIMmXgPkwZcS6VQcQdq/v0A88zYssO5SBGbraG+J3ziJbF4rZJKz4ADyP1pDHntu4f3wUFHyUI7clumaqNcBzYXMuhaFgXiwB3TkyOu9wp1ZHLl7RfU1xG8qij93P+pBwvL+Nxuy0UfdtoTgbx/Kdj/yjL0K2FpIbBZYANKWS6uicmG2eFn8ru8ClOECbC99xz9TFSznQmVkhO56Ai0l7Oj55tW9eJWvBOOTCiSXV3EjFGCTidpQNe+s5R9kQbhSt3gPSvuN5Qfg+MEFUf2j1YQnvST0XKPPJMWBGnMWstBz6peA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MqN/NUWfovs9CklPL9RhiyTP9KdM5Hmh+tqc5rNHsvk=;
 b=ru33ZZ/3k6yg8gKJUmuJhdLIxhLNkkwFT9j6PWXFCbsb4T1Kbg7lBR06zWXL32qEHeHhG/XjISxV4BrxunGSVJwmKmtmolp2RVKqyVQAAzuM3JtWuiUQrGiuW0togn0IZZAxDrmJHIabYpzgJGnoZLoyUrCZLsyYPM7kwSZTzg1pHEE8d3nkY697kzUATniqPih5neeWe5VUZRJ5Gv2IiJKE71UuRWke8WxIET5Rciquf21HBJwDYeviqNXq5xX2XT7BPcPvUau6V7tanYm9Vq6g05VWny78pV4Y4dpxwU9gCMqMEshgAwSbp/48BPBr0lL6sIo/hatKVZuONqT1gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqN/NUWfovs9CklPL9RhiyTP9KdM5Hmh+tqc5rNHsvk=;
 b=chLg5+L0S5t7N8x59VZaeW/S/iKUOmFFJc13AeWUIq3mw5bsnGDd7iqHZV2ggnMwtYyzyxN9TOuHN8Q0Yq57ZJjuj/HbU0NLrU4X7PpkLbmBc2uJD8mC2vdbF3E1TZjDr/T4FMKjZYp9YFuZmJox8UqMXBcd6F+M81lK/ZssM1U=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by SA2PR10MB4537.namprd10.prod.outlook.com (2603:10b6:806:116::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 15:48:49 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 15:48:49 +0000
Message-ID: <ccd7d6aa-f307-4d4a-86fd-1920580bdd79@oracle.com>
Date: Wed, 19 Nov 2025 10:48:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] SUNRPC: Check if we need to recalculate slack estimates
To: Scott Mayhew <smayhew@redhat.com>, trondmy@kernel.org, anna@kernel.org
Cc: linux-nfs@vger.kernel.org
References: <20251119133231.3660975-1-smayhew@redhat.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251119133231.3660975-1-smayhew@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR17CA0010.namprd17.prod.outlook.com
 (2603:10b6:610:53::20) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|SA2PR10MB4537:EE_
X-MS-Office365-Filtering-Correlation-Id: 7daec5f7-1344-4896-ddbe-08de278321ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGJIOXh2aVovVkxQQVBXV3VpV00wRkk3MUF5SE9qOUNoKzNQQnE0QzJ1djhW?=
 =?utf-8?B?Tk95aEVYN0hlcFR6KzE3Smt4NjNHOVNTMm9OM0J2aHVsK2ZkVHo0UjcrRy9W?=
 =?utf-8?B?cVRmTitZUWl3ZkNPTkc1ckRXRElLM0UxdENwY0MzOWhlTmJiZFB6c2tmTGpw?=
 =?utf-8?B?aHdva1Z0RmFFS0NqR29YZUpZR0FVUU8zVDgvOWVhS1pQS1FIUGZZR1E3eEND?=
 =?utf-8?B?ZGZPc1RXdjFtcHJuRFNaeUNEeW9hQ1I5a2grNDlEcDc0WUg2TVNiOUhFN05n?=
 =?utf-8?B?ZHRhYXMwKzZyRURtKzVRMTlvMThPcjhncUNhRE15TnFxNFE1a055TWZTd3pE?=
 =?utf-8?B?VllvWHpkNVdxVkpFZlhkKzNISTJWRnRraXd5TGYyUVFNZ2tyNlFGME9mZWov?=
 =?utf-8?B?S1dnN3EvZWJoQ2h3N3hQL2lIODN5Vytvc2lLTHBJN3h5eGV5c1M2dytEdXMx?=
 =?utf-8?B?Rkhla3JGQSt1dytMN0d2TVRIeE4zbTVha1RUMldZcHJMTHEwS01RaElLdlNI?=
 =?utf-8?B?eG9ocnVLdnBoVVBad2VKUWNqWGttWGFaK2Y3K1g1c1Z3NWdYNEUwS2ZrRC9i?=
 =?utf-8?B?MGxYVkVLaHNMdFRlQzlySXJCRTljU0JQRmx4QUlGQmZOV3RRRHJmMSt2MXAx?=
 =?utf-8?B?dWpHWEk3eFRCSDlSWVlPKzZON3VJYWtLMU16UE9wN1JUb1FnVXdZUTQ4aWZ1?=
 =?utf-8?B?N1p4cTlEYzNkS29kQjF2bkpUUXNBeHRpUWU0bStETUxwYkRiVDJmV0NqQzk3?=
 =?utf-8?B?cEIzOWNRV3o5Wlg5cUlCWENza2tDOXc4bThPeXZPN3BuMW1saGpXZkJyaDcz?=
 =?utf-8?B?R0ZjOGluRXBQYWFIeUt6TnFoaUJHa01keTNSOGM5TDhIT0UzQk9pSHZiUTFu?=
 =?utf-8?B?bzNhdjlXR1B5TUpQNUx1dnpvdFpZV1p5Zi95TVg3SmtZdEZCM1pSUnd2WjA5?=
 =?utf-8?B?MGhIQnNEMzlyRHFacjJXNTB1TDVNa0ZSWlNzVmZSWEJvNjZTRGRlREZtYUh4?=
 =?utf-8?B?WUdNSklmdDAvRW9ycFBZUHpQS1hDM3d6M1RzRmxoSW43TndyRkNYTHN2Z3I4?=
 =?utf-8?B?WTJHWUVlVTNuMGF6YitMSkdhTFQzYlcrbGkxL2RkbzlWR3graythYWlPODlD?=
 =?utf-8?B?Z0dvTExIVDIvenJZUDZVUHVhRE1IS0NSZVB3TFlEeDdoQ1BFL2xLcnM2dU56?=
 =?utf-8?B?NW10NGhvYjhucmtJWVU3T2V6OXNMQ1R1djBzemREK2pjb0ZxZ3dpM1JrWjRu?=
 =?utf-8?B?eEhWNHNva0NPcTlCVE80K2dhbEFIQlhxa0poemtiNmZYYWVqQW9aTmxGcUkx?=
 =?utf-8?B?cmRFRjhFbVBGZ3J2Z3JMZ21FTk9sYVYxWmtpaFN0QUp6ZXJjdE9PNEVOdHJP?=
 =?utf-8?B?THZoaXNpYk5iQlcwMW81OERGdisxdEdoQWJOQW9OcHc5c3BGcU81a3ZQaWtr?=
 =?utf-8?B?a1UzNDNTQS9HaG9ZSjhSMEY0ZXc1cENpUFVSK2xzWE5Zb09DUVFGandpN0la?=
 =?utf-8?B?cjNWZDUxVzRCK0hBd1NiUFVqMis2eGtSTE1Ud1h4UllyUUcrMW84c1NxVHgy?=
 =?utf-8?B?Tzc2QWxpYTR6WVArOU5lRmlDSkdmSHF1cjIrUHU3ZWRmR3JhdlpqYXhybERw?=
 =?utf-8?B?NGorZ3VCUDlnSVM4a05zNlpXRXNDUkI3SFlGc3p4aVdhYmw1Um51NndvRzA1?=
 =?utf-8?B?RnM1WXNWdTZDVk9SbXpid0laTlpYY3FYSDhPQVRqTzV0YysyZlFJME5DSGNC?=
 =?utf-8?B?ejhUaEJQM1VBV2FiM21OS0ZzdVNoWWRxV3EvR1JGTlNqMnA2R1RKVkxFeFd6?=
 =?utf-8?B?c2JJTlFRMXllY0dQV2JabDBNaFR1Q0NOWjg0UzF6RTVJUGxROHQ3b1lSQW5h?=
 =?utf-8?B?b1A4UGorWWluZFZtK1ZTbEZ1NGc3VGJMM1p3S2orN3ArQTgwSFNUTGdwZEhy?=
 =?utf-8?B?Tlg0U25DR01VL29iazVLRTdPaGJhRzI0NjNGOTNkWSt2UHZYUi8wLy94SEpY?=
 =?utf-8?B?K1h1S3UyNUZ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmpXdEFBb3VYNkplcGJURUZCMHZ6WTA3UVIvdG12YjlxR2F5d2JHQ2xZOFR6?=
 =?utf-8?B?YlMrdmNiWUdhUGtqblJBVFpvNSswMDY3Y3BZYkpuK3Z4R3Fha0xTRmo3ZkFU?=
 =?utf-8?B?akpXSDN3NTZydDJPbmlBditHOEFob1c1NFBjLzdzTFFuZGpZOGtYWVYxdlhM?=
 =?utf-8?B?bmdEZ3lXYklSd3dMQkJkMSsvaG9oWHlrOHhpaXlBbEYyeDNFY1ovY0lCSGZV?=
 =?utf-8?B?dmFYTUNDRjBFaGJzQnJRN0NteDZYTU8rYkZ1L0hoTjBRSExmTUNhZ28zNWhW?=
 =?utf-8?B?QkhlVEVEd1JybklxUzhyU29DZHZNMjVUbVJ6WTcySHpOc21zTWhZVjR1dC9N?=
 =?utf-8?B?c2NCdzloNTFQbElOUFd4cUtqNlhoWks1Y2owYXVwalIvZmFWaVc3WTVISEkz?=
 =?utf-8?B?aytRV2ovOXBvUzA1MmZJelFCdEFIWWpTODRtSitZNHhtTi9kTTk0U05wa0pT?=
 =?utf-8?B?U090ZXVVU043TXZwbDhseVNzczdqeDNPQnFjSzBNYW5ucCtkVGdjUVhOdk5j?=
 =?utf-8?B?c3NEbXBVNk8wSUM0VCs0V2JNczlQTUJSOUMzVnFEaUU2WW90czZDdHdlNWh1?=
 =?utf-8?B?NUU0NTgvMjlxdmxUOVJ6ZzlqMjVuNTFiSElKUXRYRU5VSGNlTlUyTE9PTnhu?=
 =?utf-8?B?TUdnemVKcjI2WGpHYnNBWk1uQks4ZG9RQ05NdVl1RDl2aERHcGxsRU4xVHQx?=
 =?utf-8?B?QUxOVVZWRmQ3eW1XMEcrc0NtZ2pRdVRDSzJua1FHcHR0T0JTcU1ETmdydk9w?=
 =?utf-8?B?aXhRWkZIVnd5NC9mM3dHN2VOcXpqYzJkZTVTdGh6RUgzMlpuVkw5VUJHbEdJ?=
 =?utf-8?B?eTlzZDVKbVdzN3ZzVmgwMDRSU3RXdEJuUTdnaHZ3bVFRZkhHT2ZIbVloaFVE?=
 =?utf-8?B?RVJBejNZdVJKNHkrMitQV1dIbWN2Q2hUUUhDNTQzeVJZUDhEM0xDU3JkdnJN?=
 =?utf-8?B?N3EzRWpmM1FsV09VNGt5NnpwZDNGUy9jWEVyMm9ZM1hESHg0bjRyUUIxRUcv?=
 =?utf-8?B?Y3ZHM0lzYlJ1dmZ4M2tiaWFOdHdOTFVWRVQra2EwNG9KSk1yUEpzRE4wQmV1?=
 =?utf-8?B?UHFIdVhZSjlDZ0FvaTlhaldzV1ZqZ25RaUVpUkxSZm9uZjgxQkpvWkJpaHZT?=
 =?utf-8?B?S3lFOHp1dk53V2J2ZWlHbGtTWkE0SEdmcENZb29FeEFBY3ZkMDU0ZEtCOVZj?=
 =?utf-8?B?R2prZjFDalBTVFgvTDl5OXhiKzFOZm1FYmVrSGlMN01pdEFUbytDZElTR2h6?=
 =?utf-8?B?UU1TTG5ISmtmNTlqR0ZIZFh0aVZ1LzE4VFVOOFdqdUc4RFl6NXBDNk8xVnF2?=
 =?utf-8?B?aG92ZG94ekhFVHEwejlXYW9IMzROL0JtSVowZkdtSUtYQVdlQUJjay95dENn?=
 =?utf-8?B?Ung0LzdPRXpmQWlVMXZuaGVUZVgvNUdjaU41M1BKZCtvUnFILzM5UGFaQzV6?=
 =?utf-8?B?aGJxbWplVDVXSTZ4a04rMWZ0SDJFR0lrMDZkbEhmU2VETmE2TE5KenM2VDNu?=
 =?utf-8?B?VW15SHo0WGZDRjFveVljNDFsTVR3MDkrcTlSTTdCNjBrajNRdExtVHpyemd0?=
 =?utf-8?B?eUNMOXVYL253QnZEVkNZWGFaUitaWkRZbmdvY0ZtVlFEQTYrZStjSDVCUTNr?=
 =?utf-8?B?aEJYMzVsOEhTOXdsVCthK0ZmZXVhU1Y4amhOTFJKaTNiOU5xS21mV3lacERs?=
 =?utf-8?B?eFdGaDFQZENveUFKSWVHOWNScStVUjVEd3NaKzc0SnREd2xrQmtWRFpMM1Jk?=
 =?utf-8?B?NU05QzJJU1dUcnZ5VkNzU0F2bm83dVlaUVVhYmQrQ09aRVZjeE4yWW9tKzJS?=
 =?utf-8?B?S1RyS05RNEJEMEplMXJLZG1CbHhGYlFnMkZXMzhUaUtaWFNvRGlHMDYxTGYy?=
 =?utf-8?B?MmEwOVRHbUljOWIzS281TXRCSEFWc2k4RGN4eWsydkJLU0w4ZXR0NWFYVFVx?=
 =?utf-8?B?ZGJ2cTMyWjAwQ1NUWERBWEdJV2pzeHVpU3owWDJscUlHT0xsYk5NVGc2VmU3?=
 =?utf-8?B?bVdocDNET0xkNEd3ZXR3azhBdkJFQzV2di9DaHVyWUVCMnZ0STFSNndCYTVZ?=
 =?utf-8?B?OXBjd05mcjdFL0NydnVSU1F4Z09ja0oxcWFsVXdFVFZmaTY0YlpQN1ZPb2h6?=
 =?utf-8?B?UkoyTHZtM3k2ZW1STnJqNmNuK1JJM2JZN1JMcDZnZ3NDRjdWSlR2bzRIT1hC?=
 =?utf-8?B?R3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	X2qmYZGud5XC2DPQo8IXW3cHlq06/9CINSkp92lpcUZJB95hKmRVh9poU3ZUHtcW0yOgazPzZL0B9FcxUsGkYX1ycRFHp/EMrpMaCP0VaosO4Js/yyw31f5l8ahZGKYMDwjtXPJESNOGR/fTZXs1xHp7Z4L+js61tO3DC82JpJYATzmjtodpi/m9Xmi6lNGfEdeDeHflIjMaDmbzLhkEIw5DbPrhrmqActmJJ/wwwEUJzRv66lIJpnpeILcITEfJpSiM+o3LevADGpsRmIbvtzGJCNPu3vEubehTY04lU0bcvVNUa9zLgvW44arxhr6WTYbKOnWu3UaRZk9apqic8ALxeOWchBAF3ZWjOLuG5Gy2jxj1QNeNiJf8PDqlg0SZvzh829s2F+JhC3YwL13dj/M/uWIVtBebUElF9jS9b14/13UkodRDOn5k5R6Yz8WWXIV75hzRiyCvrG2t+tFb9zaOClDekA9hnkBafH0ZvIVQzd7k/oM6j3xLgU1rjHPR/aJ/Z/5C7d05yXeliud+xm7/yHnt8kpbwy4JPWV2pyaq79syHSBnTlRdDXlutLwCqq5WXVJ17D0UewwvTgp9U4+q7KGgtE9fooo2TbiqFb8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7daec5f7-1344-4896-ddbe-08de278321ac
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 15:48:49.4648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D1qjnn8f/Lxse5iMuF1w+bKZl+5PstvNI5enKZkdl3kgPsMkSfpZMbeCdG13/iAnI1u+iQuA+bB4fGXYVpAk8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4537
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_04,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511190125
X-Proofpoint-GUID: WnJO_6OKZPWS5ov55bhDx0xWwRmPASxE
X-Authority-Analysis: v=2.4 cv=JZyxbEKV c=1 sm=1 tr=0 ts=691de6ea b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=xNf9USuDAAAA:8 a=20KFwNOVAAAA:8 a=qo3Ex1YnJ7UkcuiBvyAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: WnJO_6OKZPWS5ov55bhDx0xWwRmPASxE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfXx0SVoh94/54c
 iZsY/JBMA/YdJOiTEcuqGwdXMj1OckHiPQMmil8F1BeWHnJliZQZXsKpKDZjjf9A2RqtcjMBrDc
 fUYLJEZ6Lr6DxKrIJUSCjmsJefrbs9c2fKdxoc43513PRHzfztX8g4QV9fbu5miIOdFM8/OBvV4
 +60qUqJGUZi/+58CUVZc4H0VWbXvlqu2L76tMXAgF+DkW5BxnlY5LJIHy8g28aTa7zCH2VRjpPq
 LUmMHXePBhfrO0bZ9W3it0VL8Bd5HhWn+n7GeYMHUJNVe/0qHQafBppYSqajozGLKn5A/vGg0Zn
 68Z22mkvw2L38V94lokuZx+3lkYw0BXtCHi3Lj266qDoqJZ2B4HBVo0GLZc7tyVWo3krmAPqzi4
 JiPjXF4KR+3E37K9IFRNBl6QbewSvw==

On 11/19/25 8:32 AM, Scott Mayhew wrote:
> If the incoming GSS verifier is larger than what we previously recorded
> on the gss_auth, that would indicate the GSS cred/context used for that
> RPC is using a different enctype than the one used by the machine
> cred/context, and we should recalculate the slack variables accordingly.
> 
> Link: https://bugs.debian.org/1120598
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
>  net/sunrpc/auth_gss/auth_gss.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
> index 5c095cb8cb20..6da9ca08370d 100644
> --- a/net/sunrpc/auth_gss/auth_gss.c
> +++ b/net/sunrpc/auth_gss/auth_gss.c
> @@ -1721,6 +1721,14 @@ gss_validate(struct rpc_task *task, struct xdr_stream *xdr)
>  	if (maj_stat)
>  		goto bad_mic;
>  
> +	/*
> +	 * Normally we only recalculate the slack variables once after
> +	 * creating a new gss_auth, but we should also do it if the incoming
> +	 * verifier has a larger size than what was previously recorded.

No quibble with the code change, but IMO the comment should work a
little harder to explain why the increase is needed. Something like:

	* When the incoming verifier is larger than expected, the
	* GSS context is using a different enctype than the one used
	* initially by the machine credential. Force a slack size update
	* to maintain good payload alignment.

I'm summarizing based on your commit message above...


> +	 */
> +	if (cred->cr_auth->au_verfsize < (XDR_QUADLEN(len) + 2))
> +		__set_bit(RPCAUTH_AUTH_UPDATE_SLACK, &cred->cr_auth->au_flags);
> +
>  	/* We leave it to unwrap to calculate au_rslack. For now we just
>  	 * calculate the length of the verifier: */
>  	if (test_bit(RPCAUTH_AUTH_UPDATE_SLACK, &cred->cr_auth->au_flags))


-- 
Chuck Lever

