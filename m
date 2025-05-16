Return-Path: <linux-nfs+bounces-11773-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B170AB9CD3
	for <lists+linux-nfs@lfdr.de>; Fri, 16 May 2025 15:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1794A7ACD26
	for <lists+linux-nfs@lfdr.de>; Fri, 16 May 2025 13:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25C9288DA;
	Fri, 16 May 2025 13:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dxL2HDSA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NI0K95qM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B054523182F
	for <linux-nfs@vger.kernel.org>; Fri, 16 May 2025 13:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747400477; cv=fail; b=a9MvapxC5lBen5Zi9RiDKf9HjKZaHLEfX2SUCVvVqJpz6dTbye3xNTCKuKtneYgDBb6CNNFWfeA/wI4YHHhJIRrP35LEa3tyETyv2ExC+J5D6hwqjlpCOoAu+JNyb4+xQ3waiiU1ilr74pFaPexf4wvAmzQ+7mh+WlMcxLuNoYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747400477; c=relaxed/simple;
	bh=+tjBhBcrPx9ejXNRrRrONrftfzwcfZDC5S5oF+MTXYg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TCBtnYKS5eIp6jw/tiR2ipZi6TqKJ9/mV4Onibs9EEUkIVL3NamqxM2RWk2/edZFl40ALuTHLTIrd1WigoJBm50nuoScJHRj8T8PxzkfbHLd/KMgSM103Sb0Igq9+yiof8fHq59uE3u9WhlOfiFlsGLrqw6l0uLsaugoo+j0Da4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dxL2HDSA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NI0K95qM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GCfxVg018646;
	Fri, 16 May 2025 12:59:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qhEzP1YYo8o2vUMc9TWT4ztqlnxenY46PeFqdr1I0kc=; b=
	dxL2HDSA4wp/ikgFYRuQ1tDFrJLRor3h1yuHKZeTs7jY0yI54inmLbPcSXuGCnH1
	dvnvd2iyVGipF8SZcG5CeBYOlcE2mTF/md+Ubrg2YCNOwONXSiBt/fgpyNlGhF/Y
	UYAM1d3dI8kh87iSgbpR9T0PtjAtLGwq08ybVhjUfPFQRrtwGMl0NUV6l9HFThI5
	yY2+DAbHha9nHxpinGT8kq4cvKIcoyQQqDH0Dy2IuT9DYZOmJNVzqXf2K8ag2HxJ
	mfpipiCn6oVBx+wbMqq+QgTvcwoS/sp70AmZY+G8IWMcr6miTPNIDaR0aPcW0Mj7
	tRjxnLTu/IZdnVxxxWeO+Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46nrbdhaxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 12:59:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54GBKb6G004484;
	Fri, 16 May 2025 12:59:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46mqmengxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 12:59:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b3LiDOsqABuSoz0iEoWGTzdsR4y6MkEzmVJvRM12NzY93D/4SF1AhDsyr9OHv7RNwPRm68G+9a0YpXxb2dGmbRVe6RgEwlbxcLWxseD2lMx+33ibdmtqptbrRii69lY/OUGj7ARguqZbP9db3zTYH14RHMpCdvHZMtvE4uyBi9ZdUnbxa4VbwuBN4BqaMvxoz9xJBTQZqlaDhAWOeGTrr63VDhAgvNaNfOBAkE1D/IVGF7LzdR3008O9NJKYBNEQysmSpAYhH70UkkN27FagnoUf+TKbvSoB0iqxJiPPpIIJQayY6oT4E4+KxnN3Rtq/uozqjh0bNoDUgnN86Ccujg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhEzP1YYo8o2vUMc9TWT4ztqlnxenY46PeFqdr1I0kc=;
 b=MmAeHRnXTer9e2g6cxzWNtXX22KyHjlThcdQrudTV9iertnUTaCEj0XzRQZtvZ1/YqBb2icYfxAxvtOMvEOR1/LqoqO/62bTPCs4r+pH/xenKvJ9+w0RxsSMMiCsJ1LYZuLIeL+kaqTxPrBkUZBCGI4V5+bhzFSWwd7tFcJOwvB2BV9HukDu8P+WqbKs/2kZ0cj81mkQzva4bbFQvICGLruxVMf6nkkSezTevXPISilQlZx7IJvD2WkgT5glswKxU3Dhy5c6GEe6gYCV4RUQOjh+K+V1DmB+oNiM/vZYHJ1qEUDk7OtMCbTryHV7ngwmvMIoS6Tm/w8RVlxRAtDg/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhEzP1YYo8o2vUMc9TWT4ztqlnxenY46PeFqdr1I0kc=;
 b=NI0K95qMSnlfsYkXuaieUd0O0c9xIKc8xktEBGgwAmGRZb5lyGAk4I30RsYoFPuH2XwxoTPO+OIG4r3Q81uYfuaFysqMW+vlnzy9jhcWPk02eUQVSQbNVyCSQhFfrXqR3KXmVMiWuvRRuRwuT/RfDpjyyPBu1nQoXiAOfgw5cEM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB7348.namprd10.prod.outlook.com (2603:10b6:8:eb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Fri, 16 May
 2025 12:59:02 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8699.022; Fri, 16 May 2025
 12:59:02 +0000
Message-ID: <c8f5e130-f837-42d4-be8c-1b26eaec587b@oracle.com>
Date: Fri, 16 May 2025 08:59:01 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: non-stop kworker NFS/RPC write traffic even after unmount
To: Rik Theys <Rik.Theys@esat.kuleuven.be>
Cc: Daniel Kobras <kobras@puzzle-itc.de>,
        Linux Nfs <linux-nfs@vger.kernel.org>
References: <79767ded-466f-44a5-b15a-fde5af1b03c7@esat.kuleuven.be>
 <2c1a60a7-051f-4952-84fe-c3a4b6b0327e@puzzle-itc.de>
 <42c84eb6-ede0-4e68-ae70-334365e2ae7f@esat.kuleuven.be>
 <62cb66ff-b718-4369-a7f1-fd3bb01a7b16@puzzle-itc.de>
 <4d4f781a-d668-4f49-9cfd-2e9e94a8cb71@esat.kuleuven.be>
 <b8f4f808-48df-4659-9afb-2f9994b22e7b@esat.kuleuven.be>
 <8abc8a16-cbdb-4285-a2da-62f57fbbb165@esat.kuleuven.be>
 <9c446dc2-fe2e-4bd2-9ad5-f4015b0e2ffa@esat.kuleuven.be>
 <3c1acadf-b2ed-42b8-926e-662df5a8aa4c@oracle.com>
 <547993bc-80ed-47ee-b1b7-cbe83da1eae3@esat.kuleuven.be>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <547993bc-80ed-47ee-b1b7-cbe83da1eae3@esat.kuleuven.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0293.namprd03.prod.outlook.com
 (2603:10b6:610:e6::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f3f81d3-8d81-4f04-2769-08dd94796e97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWpwYUZ5MEx5WFI4Nlh3MjBKS0RzRlUvL3Z5dWhYRktvSXQ0NWNiYkRRTjBr?=
 =?utf-8?B?R1h0YUs0Y1FTd0E2c01MUjhFTWRrUkNQamlnQ0FmY25RS1lFOWQveHI1ZHZL?=
 =?utf-8?B?TXFvZmdRcStkbDh6a0R3eTI4bnZMeUdIN2FENi9iWkFtM0daYWZBVVFVWU40?=
 =?utf-8?B?TTc4ZGxMZlRUbnR6cDEydkcvbmtUdzRwTjFzUkdUWDVpalBUelFJaEErUjFw?=
 =?utf-8?B?Vm1tb1EwVGROZ2RwT3VPNEJ5NWt6VkVRTUR4czFKdUZpUDBRcVVUdHJlKzh0?=
 =?utf-8?B?UjJyM0hHdU53SCt1Y2pyQjhHZnhpRnBndHNpUVdDeUFOTzhJTWxpQUkvdkhm?=
 =?utf-8?B?Nm84c1NBUFdUbG02V21aTGNOQmdRREF0dDJMSXRxT0t1RFphSGZWcFZZS1I1?=
 =?utf-8?B?L08xT0h1OHdiZ0YyeVRJY1kvZnhrdzlKM2R2OFhpWkVLME9CMStEY1E2SXJp?=
 =?utf-8?B?SDErNUxtd2NTZWtiQVFvcjk0K3VLalJGYUJ6U3V6NDY3VTJYajFscVY1S2dk?=
 =?utf-8?B?NDcxb2tCMWVWa2FrZG9QakhsYUJsTlFFV3NWYWFWTFcvc1RFQ25OY0NrS1V2?=
 =?utf-8?B?cW5jWDIxQjhNbVUyVkpJcUNoQ2JDUnE0eUFXa1V0U0l0b0hqNGZ0b2d2VER2?=
 =?utf-8?B?ZmY2TnJON05OS3ByZ1haSTFYM3V0QXpvREYrUHdLc1IxMmxOUGUzbWk3b2Ft?=
 =?utf-8?B?NUcrVzF5RDI3a003M29BenZmMzZDZjBxaEhqcU9xSFdBaWVJcG1WVElzTURG?=
 =?utf-8?B?dGJ2a2xQMTE2VFF5VE8yZkgvOXhEREF6clQzd25aTW5zMlc0bkM4TUVLc0tJ?=
 =?utf-8?B?WjMrck1tVDNQM0xTY0RYME92a3RpME53NDZPQlNkS2ViMnhTNklJODZXa2Z6?=
 =?utf-8?B?b0VJS3h0Z2o0dU55Zk9Ja2xkcDVjS2lqQUo0MnJ3K0FkNmFkUDYvQ2NyMjJL?=
 =?utf-8?B?MW9wbEVyTlBQMlBTQXA2NDUyUDd5QlpyRnNTQmNXTlVEMnVYcldxZXJZcGJG?=
 =?utf-8?B?c2xmRkRLWVE5STRLSWRXQjRSa1BsTkcxbU9mdlVvQ0ZwVVRCZ3RncWlLaXkv?=
 =?utf-8?B?bFgzZFJrOUpBZWRrYi96ajRaREMxMnl5QTBWdHNRL2Zqb0pTK2U5c2NVTmFJ?=
 =?utf-8?B?T0xuSDNNWmx2dm1GWEVsUVNFbStSbFVBMTJUblpQK2RjQ0ZIRzE5anVqTEJi?=
 =?utf-8?B?bUpqWm5wVE5adVZRMXVaSERZS2U4aHZ4VmhVdXA1ZEtRaHhxczU3UVZNUmRt?=
 =?utf-8?B?ei9sNzV6ZFMyVTFTckp1azJxYVRWVS94RVFBLzZiZEVNRFZhQ0d4WkVSdmIr?=
 =?utf-8?B?QVdxS0NnUmhlVExJT0tDQ2U2SEt3R2hraUZzODE1T1RPZk5rNWdGd1dEUE1U?=
 =?utf-8?B?NU5JQjhCN0Vaa0pKNDl5ZXArcll0YVZKUjI0dzBZbm5HOTFvckRGeWIvWjNw?=
 =?utf-8?B?aTF1VlY1R24rNVdHSkJhcDA1czZFR3FyZExhTEplNHV0dDlFUTUveXBFYmdx?=
 =?utf-8?B?MUsvUGdqZmtKOUxKaWVuS014NVpZTFlSRWQvajVXbVcwYTQvSlh1K2pLcUVY?=
 =?utf-8?B?NFdKeUhFektjd1FFc2FKaGg2S2lIZVFJdmZZUGw2OVIyaVRSNVFqMTFZdks3?=
 =?utf-8?B?ZmVRSTlOVmQvUnlxeXhZR1pHenh0cDhNRWxERFljNHd3M3U0aDhLWGc1K2dP?=
 =?utf-8?B?OWlwVGJrcXNLUnF2MEtna2NMcUMxNldFNmh5R2ZIb25QV09kVlhLRFJkT0xh?=
 =?utf-8?B?SGV3MXRMVXFHNU4xUHNrM3o3bWJEMW15WnExMFVYV3lmQld1L3RrVDZmUi84?=
 =?utf-8?B?VjhBTEhJTmt2eDlOMmp5a3VGZGRpTXNFKzhYQjBBUzVLMG9YdHFETDlTNFFT?=
 =?utf-8?B?LzVBYlUzcGhvMmtnNitpRVd6cXhZK1JuWDNndi9saUh6eHdjb1A5S2VxU2pr?=
 =?utf-8?Q?n1f6RsU7tys=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFUzN0MxWTFCRVY2eEhVZURRWTBTL3Z2VmRMVXNYeitlMnZqMzhzK05MTUpK?=
 =?utf-8?B?OUZ3SEVpeU1IdGUrUy9nbFFTbENMV0V5U1Qvd3JYWGh4ckxvRkEzV3ZycGZq?=
 =?utf-8?B?cXdUVmU1Q1daS3I2UW1pRHJ4ZExMcWFjL2U2Q1FwZFhxSUZwN2FmNkxBOGNq?=
 =?utf-8?B?NW5sZTFJM2M0M1JVSVdVeWdMWFlNckZpTHB5a2MwelliUEI2WXRMaVFZRDBV?=
 =?utf-8?B?UXp0WjM4Qm9rS2swMWNmSFNpcnQweWR2cWZISGxRck5EUDB6Z2NDNzRYbUFR?=
 =?utf-8?B?eGJLZWhmMzgzN2NSZklOVlByejRDSjRkbjVtOUczaE5ZT1piRWludjBuNm9T?=
 =?utf-8?B?Um15TFAyb0VxUElpdUNRQlNPRGlOOURtYWplUDFqaENXVU9PQUpkbDErMHhT?=
 =?utf-8?B?Ti8rNldSL1IyVHYxR3p0MjlvU2xsa0N2YmpKbENVLzVEZGtZUjdNR1JRbEJY?=
 =?utf-8?B?Wmt4cWVsQ0hhdENmcG1hUmFwTFkvbDVKc244akZLT3pLQ3gyMTdSWmVlZmdD?=
 =?utf-8?B?VDRNYmZwbkd2L3JJUlNGajhkYUJIbXorNkRhUGFqcVYzQVZxM0gzdzlEUFBF?=
 =?utf-8?B?TVUrdzVXL0tYZ0N3Z1pKNDZtdHlBSDkzcDYwdkk4cjRndDlWUVpEZ0pjblkw?=
 =?utf-8?B?bEdMNXRvRks4MUFSZmtUcFBtT1M3NzNvNnRKay9kdXpKSTR4U0daRGpBcGVv?=
 =?utf-8?B?ZmJPQXVDN205WGJqYVFoOUZnaVBkS3E2cHFYemNYMTNuam1VS3ZGU0NJUkZ1?=
 =?utf-8?B?SlYwQU9yeFJZY3grajlBdFhNNXZyajd1Tit5VXhrTGUzeStjeWtacWhqbXhF?=
 =?utf-8?B?QlRDYmRVNFEvay9QS3QyOWxOcXBBY1lPaUtyRkM4cC9HWGFJMkdWTE12WXVr?=
 =?utf-8?B?NC9TRE1oMk84WUt1ZDZUeEhLdnpTVkl1SFVWU3k4eWRWWExQQjdwZzFoY2F2?=
 =?utf-8?B?L0dkZlZMdzkxb0NWbjdUNUkwd3IrRjExQUVGVVVKbDRWaWdPeTMveEZMYWZP?=
 =?utf-8?B?Y1dNM25lVklFZGhxWWc5OEVRaElac2l5Q3lYMGFmUklXNHNFVExnU01kZ1Jr?=
 =?utf-8?B?enhZM0Q2ejF2aHdnRnhmZUNQTWF2SVhuQkRxeWg0SlpDUzBKSTVxMmhydjNK?=
 =?utf-8?B?QVZvcEU2LzFNclhKajJFcnp5L2ZpSlo0Mk1iTEhKdTlIUHppd1dsQ1AwVUF6?=
 =?utf-8?B?YlMxZFVMQ0lxMVBubXMrVkYrOUdSV0Rwa1RUSmxJRWZxeXZ6bXBiL3NWSHZ3?=
 =?utf-8?B?YnNCQ0s4YWhORldVR0g1RjhxajZDZ1A0Wm02RXpsYnY2NnhKNmZBTzhTUE4y?=
 =?utf-8?B?M0E1Q2xiRmZLS3daM1dRb0EvOVlnZ2dFQXhuT0p3MW5LWVlMbUs5VjZRRnJn?=
 =?utf-8?B?TVlsYm8vSDlIMGZnOTlhSzIrVFVhcEVKdmR1em5pb3RqYjhPVGExaEI4WmR4?=
 =?utf-8?B?eFdYU2ErbkJDL2todU8xZWFGNDBYQUhUc3JNTzBCSTdxYlBUU2ozc1hxVENO?=
 =?utf-8?B?S3IyaHpHY1owL3hGNXNqTTJEdy9idXBVa0hpR0lEU0dOVDdVaUl2Tjd2elB6?=
 =?utf-8?B?MWowRkpaa1lDREtpZXB6NzlwTXU3NDVpYUZ2K3p1STlMQ0d6dWxIS09qRTJj?=
 =?utf-8?B?dEhBMEkxckRVWC9uZW02U2FmbnA3dDdwa01rSnJIeldKY0lTQ013cHRYZUha?=
 =?utf-8?B?N2FBNzVxT2xocGZBNnB3MVVBb3NhOEE1ZkFIcE9rclh0d3plN3drd2t0WEFN?=
 =?utf-8?B?U1NhcFIwbm1lbHk0REswU1RRVUhSOUJOZlhSc1Y3cm16Uy90dVBsdVdZbEJG?=
 =?utf-8?B?SGMzSHZQdzFBOTNIUm5tRHlrNXZOS01BY015cmpDME90ZkNFd3RnRjY5RGgz?=
 =?utf-8?B?ZGVjVmRhRHhVVGdDRm9ZZ0o1Q0w5WDMvKzF0MFQrU0JlZXJnelBpQ21uT1d2?=
 =?utf-8?B?MUJKL1B0OWNGSHNJU1dFaW12ZUI1YlJpdGJENkRMODlwdzlGZHZIMVNvcVVt?=
 =?utf-8?B?Z1BOOEczZGpBZ0F1MFd0bk9iYU03ZU5xQko2c0p0YVBWR1hMMmdGd2NrWFNo?=
 =?utf-8?B?VlAwTzhYR2tTVzBpbWh1cDgwaVF4UnBrZS94dEl0RHBzWkpDQVh0TURrcWpo?=
 =?utf-8?B?VjY2a2twTXM1Z0d4amJ2MUFlY1ZjS3FkTHhQSUl5OUxiZU5HZFBxU1dvc0ZN?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oBnDHzdMln7ZIrAdFJkNIMe2/8ezna76m9xjtOdQrTQK+/g5TjhJqXinyiNvr7OEGdQIaottRSu6ro1KZwqOBa2ksE2UmhxvLH5+egkL6D8+UzXhzTKakxxi/t8ame57b5INnolaWj1SpqSbThKVudKdjdzra5ccmkJy+tbyczU9S1xJ/j88MlXTWnhr6RH/Y3+sPY1bUWaRUSvIkfsB8bV0iEVlnAMMwHIsQzwTXLvpjUJeIjBQvvGQvlUMhbHBcvWBu1Zjy4BZFvX4T5Gt6508dgZPjZ/84e74IGJF04jMVRibrFjQVqakuEmG+bbtkWvZ8sRVANbG1N0NZg/BWUh3TXv4QE/4HQpaWU8ShA74vfnoSJA/zuGYfzp0RJ0Pl8p8i2op9trY6a6QAIFJIUiWVfSTCIQnL0kJQInnW16Wq2xN52PSqqmuFrtS5dNjZ26lorW9rhG3w3JI+yZImi/V+Ow4gUJ1MAeuHjKAh617MTJ05Z4lz6wLrawaZlamaK6H0ojOWxvkO26ZmwTK4O16nTSn5AZs3nurEjYSYx1MOwUzL9mr9bWiDDi+2RHelbJXY94OQaQu0P3tDkwHu2xgnz3GtHxQEezl7lmeEXo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f3f81d3-8d81-4f04-2769-08dd94796e97
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 12:59:02.5643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MAAv5s0Q9Yal7EutEngD4ePWW+s9VYCiuM9o5Ydpnx0/udlKnzDFBKeif+N2DVABbxq7CbtMxf/BEgFfCwjP+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7348
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_05,2025-05-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505160125
X-Proofpoint-GUID: Q9PL-QdyU9bqhsnCD-fCYNkcl9jdAw3P
X-Proofpoint-ORIG-GUID: Q9PL-QdyU9bqhsnCD-fCYNkcl9jdAw3P
X-Authority-Analysis: v=2.4 cv=G/McE8k5 c=1 sm=1 tr=0 ts=68273699 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=zaJ9XaaiktXWKQAmFbMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDEyNCBTYWx0ZWRfX4vgF4ynbuznl JAnRQxDW+vYGcAaMhpVoHigtIVbs9dirXYfb9snAtAKJeUKOad9EYC373V+MX6Pzxo+1B514uv1 aOU9zn+6AU03lu5gB8eHn9uZqMN8h/vgzEesGPHR3Us25pKnjKJ7JGoVBzaHHjiDlFuzGgf0pIJ
 Fsa3+d40Jq7nBXpYq4SZaG/YaiPm08s0RKhYAX8GerHQAnvLB4mi65daY1lgF/UV/P9T60kQT1e Dt/WDoWfxR655fOTq/cyZx6u+Vp9yE3ZZirprwdw9qkcEM5HwZRx7vMWXqj3w6L3/WYgEj8MC07 9MY9gzNzHvfOBQLs3e9YglsvfoKn6Jxq4IwHIM2c6qWKDbe3g9+9CJ9x7Nwhc+/+I+hLmOV/pPD
 H9tbebtiSV6QIooEpviSMUoaBl2D+gzKP6oK5yk+zwFZ4sxNM3Bull3ZFpNwM3Ib8LEyBi+t

On 5/16/25 8:36 AM, Rik Theys wrote:
> Hi,
> 
> On 5/16/25 2:19 PM, Chuck Lever wrote:
>> On 5/16/25 7:32 AM, Rik Theys wrote:
>>> Hi,
>>>
>>> On 5/16/25 11:47 AM, Rik Theys wrote:
>>>> Hi,
>>>>
>>>> On 5/16/25 8:17 AM, Rik Theys wrote:
>>>>> Hi,
>>>>>
>>>>> On 5/16/25 7:51 AM, Rik Theys wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 4/18/25 3:31 PM, Daniel Kobras wrote:
>>>>>>> Hi Rik!
>>>>>>>
>>>>>>> Am 01.04.25 um 14:15 schrieb Rik Theys:
>>>>>>>> On 4/1/25 2:05 PM, Daniel Kobras wrote:
>>>>>>>>> Am 15.12.24 um 13:38 schrieb Rik Theys:
>>>>>>>>>> Suddenly, a number of clients start to send an abnormal amount
>>>>>>>>>> of NFS traffic to the server that saturates their link and never
>>>>>>>>>> seems to stop. Running iotop on the clients shows kworker-
>>>>>>>>>> {rpciod,nfsiod,xprtiod} processes generating the write traffic.
>>>>>>>>>> On the server side, the system seems to process the traffic as
>>>>>>>>>> the disks are processing the write requests.
>>>>>>>>>>
>>>>>>>>>> This behavior continues even after stopping all user processes
>>>>>>>>>> on the clients and unmounting the NFS mount on the client. Is
>>>>>>>>>> this normal? I was under the impression that once the NFS mount
>>>>>>>>>> is unmounted no further traffic to the server should be visible?
>>>>>>>>> I'm currently looking at an issue that resembles your description
>>>>>>>>> above (excess traffic to the server for data that was already
>>>>>>>>> written and committed), and part of the packet capture also looks
>>>>>>>>> roughly similar to what you've sent in a followup. Before I dig
>>>>>>>>> any deeper: Did you manage to pinpoint or resolve the problem in
>>>>>>>>> the meantime?
>>>>>>>> Our server is currently running the 6.12 LTS kernel and we haven't
>>>>>>>> had this specific issue any more. But we were never able to
>>>>>>>> reproduce it, so unfortunately I can't say for sure if it's fixed,
>>>>>>>> or what fixed it :-/.
>>>>>>> Thanks for the update! Indeed, in the meantime the affected
>>>>>>> environment here stopped showing the reported behavior as well
>>>>>>> after a few days, and I don't have a clear indication what might
>>>>>>> have been the fix, either.
>>>>>>>
>>>>>>> When the issue still occurred, it could (once) be provoked by
>>>>>>> dd'ing 4GB of /dev/zero to a test file on an NFSv4.2 mount. The
>>>>>>> network trace shows that the file is completely written at wire
>>>>>>> speed. But after a five second pause, the client then starts
>>>>>>> sending the same file again in smaller chunks of a few hundred MB
>>>>>>> at five second intervals. So it appears that the file's pages are
>>>>>>> background-flushed to storage again, even though they've already
>>>>>>> been written out. On the NFS layer, none of the passes look
>>>>>>> conspicuous to me: WRITE and COMMIT operations all get NFS4_OK'ed
>>>>>>> by the server.
>>>>>>>
>>>>>>>> Which kernel version(s) are your server and clients running?
>>>>>>> The systems in the affected environment run Debian-packaged
>>>>>>> kernels. The servers are on Debian's 6.1.0-32 which corresponds to
>>>>>>> upstream's 6.1.129. The issues was seen on clients running the same
>>>>>>> kernel version, but also on older systems running Debian's
>>>>>>> 5.10.0-33, corresponding to 5.10.226 upstream. I've skimmed the
>>>>>>> list of patches that went into either of these kernel versions, but
>>>>>>> nothing stood out as clearly related.
>>>>>>>
>>>>>> Our server and clients are currently showing the same behavior
>>>>>> again: clients are sending abnormal amounts of write traffic to the
>>>>>> NFS server and the server is actually processing it as the writes
>>>>>> end up on the disk (which fills up our replication journals). iotop
>>>>>> shows that the kworker-{rpciod,nfsiod,xprtiod} are responsible for
>>>>>> this traffic. A reboot of the server does not solve the issue. Also
>>>>>> rebooting individual clients that are participating in this does not
>>>>>> help. After a few minutes of user traffic they show the same
>>>>>> behavior again. We also see this on multiple clients at the same
>>>>>> time.
>>>>>>
>>>>>> The NFS operations that are being sent are mostly putfh, sequence
>>>>>> and getattr.
>>>>>>
>>>>>> The server is running upstream 6.12.25 and the clients are running
>>>>>> Rocky 8 (4.18.0-553.51.1.el8_10) and 9 (5.14.0-503.38.1.el9_5).
>>>>>>
>>>>>> What are some of the steps we can take to debug the root cause of
>>>>>> this? Any idea on how to stop this traffic flood?
>>>>>>
>>>>> I took a tcpdump on one of the clients that was doing this. The pcap
>>>>> was stored on the local disk of the server. When I tried to copy the
>>>>> pcap to our management server over scp it now hangs at 95%. The
>>>>> target disk on the management server is also an NFS mount of the
>>>>> affected server. The scp had copied 565MB and our management server
>>>>> has now also started to flood the server with non-stop traffic
>>>>> (basically saturating its link).
>>>>>
>>>>> The management server is running Debian's 6.1.135 kernel.
>>>>>
>>>>> It seems that once a client has triggered some bad state in the
>>>>> server, other clients that write a large file to the server also
>>>>> start to participate in this behavior. Rebooting the server does not
>>>>> seem to help as the same state is triggered almost immediately again
>>>>> by some client.
>>>>>
>>>> Now that the server is in this state, I can very easily reproduce this
>>>> on a client. I've installed the 6.14.6 kernel on a Rocky 9 client.
>>>>
>>>> 1. On a different machine, create an empty 3M file using "dd if=/dev/
>>>> zero of=3M bs=3M count=1"
>>>>
>>>> 2. Reboot the Rocky 9 client and log in as root. Verify that there are
>>>> no active NFS mounts to the server. Start dstat and watch the output.
>>>>
>>>> 3. From the machine where you created the 3M file, scp the 3M file to
>>>> the Rocky 9 client in a location that is an NFS mount of the server.
>>>> In this case it's my home directory which is automounted.
>>> I've reproduced the issue with rpcdebug on for rpc and nfs calls (see
>>> attachment).
>>>> The file copies normally, but when you look at the amount of data
>>>> transferred out of the client to the server it seems more than the 3M
>>>> file size.
>>> The client seems to copy the file twice in the initial copy. The first
>>> line on line 13623, which results in a lot of commit mismatch error
>>> messages.
>>>
>>> Then again on line 13842 which results in the same commit mismatch
>>> errors.
>>>
>>> These two attempts happen without any delay. This confirms my previous
>>> observation that the outbound traffic to the server is twice the file
>>> size.
>>>
>>> Then there's an NFS release call on the file.
>>>
>>> 30s later on line 14106, there's another attempt to write the file. This
>>> again results in the same commit mismatch errors.
>>>
>>> This process repeats itself every 30s.
>>>
>>> So it seems the server always returns a mismatch? Now, how can I solve
>>> this situation? I've tried rebooting the server last night, but the
>>> situation reappears as soon as clients start to perform writes.
>> Usually the write verifier will mismatch only after a server restart.
>>
>> However, there are some other rare cases where NFSD will bump the
>> write verifier. If an error occurs when the server tries to sync
>> unstable NFS WRITEs to persistent storage, NFSD will change the
>> write verifier to force the client to send the write payloads again.
>>
>> A writeback error might include a failing disk or a full file system,
>> so that's the first place you should look.
>>
>>
>> But why the clients don't switch to FILE_SYNC when retrying the
>> writes is still a mystery. When they do that, the disk errors will
>> be exposed to the client and application and you can figure out
>> immediately what is going wrong.
>>
> There are no indications of a failing disk on the system (and the disks
> are FC attached SAN disks) and the file systems that have the high write
> I/O have sufficient free space available. Or can a "disk full" message
> also be caused by disk quota being exceeded? As we do use disk quotas.

That seems like something to explore.

The problem is that the NFS protocol does not have a mechanism to expose
write errors that occur on the server after it responds to an NFS
UNSTABLE WRITE: NFS_OK, we received your data, but before the COMMIT
occurs.

When a COMMIT fails in this way, clients are supposed to change to
FILE_SYNC and try the writes again. A FILE_SYNC WRITE flushes all the
way to disk so any recurring error appears as part of the NFS
operation's status code. The client is supposed to treat this as a
permanent error and stop the loop.


> Based on your last paragraph I conclude this is a client side issue? The
> client should switch to FILE_SYNC instead? We do export the NFS share
> "async". Does that make a difference?

I don't know, because anyone who uses async is asking for trouble
so we don't test it as an option that should be deployed in a
production environment. All I can say is "don't do that."


> So it's a normal operation for the server to change the write verifier?

It's not a protocol compliance issue, if that's what you mean. Clients
are supposed to be prepared for a write verifier change on COMMIT, full
stop. That's why the verifier is there in the protocol.


> The clients that showed this behavior ran a lot of different kernel
> versions, from the RHEL 8/9 kernels, the Debian 12 (6.1 series), Fedora
> 42 kernel and the 6.14.6 kernel on a Rocky 9 userland. So this must be
> an issue that is present in the client code for a very long time now.
> 
> Since approx 14:00 the issue has suddenly disappeared as suddenly as it
> started. I can no longer reproduce it now.

Then hitting a capacity or metadata quota might be the proximate cause.

If this is an NFSv4.2 mount, is it possible that the clients are
trying to do a large COPY operation but falling back to read/write?


-- 
Chuck Lever

