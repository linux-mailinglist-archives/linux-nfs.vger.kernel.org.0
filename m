Return-Path: <linux-nfs+bounces-16017-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B682C32508
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 18:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B09A3B4927
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Nov 2025 17:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B09B330305;
	Tue,  4 Nov 2025 17:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jHnf9UTN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZjoB6NUA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9801F33438F
	for <linux-nfs@vger.kernel.org>; Tue,  4 Nov 2025 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762277008; cv=fail; b=NTiKtaiigi/7mLhsKe8QG5oAgyqhsRfIxSMPbZNZjF2Y7H42Pr2+/zk/hcucrOq6LK4dOj35VdTboFSp5Hi1qXQb6AT2tYjrW1rTUQuRS//rEeL0Orh8Tv6FshrdvV/rl9zFFjL9pIXCqJ5wux7GlRF8HMmo7KdoK/NEm7wKBuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762277008; c=relaxed/simple;
	bh=QehlymDK8Aav9X+aZt4T6mZ/pFgx/HgSAql68yGeC44=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PhBqvAsIdgq2uh4GQW+0cAYQkDwuSmwMMmo//MgF7isd7ROe43rjD9v8vUP7pJiH+ASvu6Mb1DbJzlqpQwWua77EOiBrikHk36OG4oaCTZM5K9Ow8OtBkcX8/Wiu8G+2oJa7OXeOopmf2vkFTFdz74k9WNRSDtOiaQtY/sodGas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jHnf9UTN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZjoB6NUA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4HNL0A002820;
	Tue, 4 Nov 2025 17:23:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=tnS0dnaBajC7fx6yRBkwtQAc7CNkJJbzr9sd5GH9xIQ=; b=
	jHnf9UTNH6efFN0jR4BdRDHvgIplGiGpfNarS6Ept3m0chh2hTf78foVsGBDVVCM
	2BWaqJvIIh4a700pXj0r6lXXuU1IEouMqJnNB4QfplAkcrrGLIqXvOD2KNBpIk5I
	9B0Mgl2P7ATMlh6EDIEEorbXzbq1f1y8WPHHIk3TtbOB+nF8pn8iyVfT/WZM1eWU
	UPd5Uy8Nzt81GXfQWijBvVDrYn18y9w/8kFY2sK0YyXbSVwTwP2oxxyM3dkgpfB9
	TblhSeWWBlIep+27oaB+jXC4wtK7lw9y4YnxOvsIg330KLVdP8J5F+4fnViwsLI8
	bYhu9TVRtA+hXtmh5gcrGQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a7n97g65m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Nov 2025 17:23:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4GiQQX010029;
	Tue, 4 Nov 2025 17:23:22 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010047.outbound.protection.outlook.com [52.101.201.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nddkyq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Nov 2025 17:23:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EK0XfzpA+ZgCxkKURKRdSS+bqN/53Orzva8DqWqGYkb65Djz4TRs3yLMA4gc/kJ/J6x44TX/s5T+ywjF51Hnb4UZNeXAC4MVMrEJwu2aRxOjxkWy61PRXT/xyP76+Ob8uPEJSYSBwmMQMK2PnM0mix9/3a8RTc1P6+YbsB3FyVocXikA7GA/mGBUZLbGx3gUtPSazDuRc71TB+KTqp9dE0PFE5UvUpJPp9AX8Y2Hckb7si78m2IRXT0dNtXMPN3XL/txYygbu8y4UzcTfv4GJcA6i5ZodBIo7t6x8JCzwRBW91KOHu3xSS2gd6eTk0bCBXJL9vcOaAnNrkadoKRkXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnS0dnaBajC7fx6yRBkwtQAc7CNkJJbzr9sd5GH9xIQ=;
 b=cydme92Yr6aTRC1UDwBIX8g1gVX9PeTSH7iKwfmtFow7VuDAsSIbzyUXj8iB0b6b7PuNt8V+uU2sCCf1nOOh5u0FF03snu6faxywKSXAMBh7092xM4Kd1NYg4o39feinLbvtp7kb92QAthlOCPuM3Z6CjV81V3y7YiyrFkq49UgLohfudjD0HQXI2+e9p9lH2dLMA9atnkSqdYK3LnBsO0ZmMv2N6ozRJFpHoK1RMVdR09YcYKZDd0W1oJgMjC8EWE7IzL5XKxdhkUIl9cUW4qH+onhWxGY5y/eaMZr64zdPkBFEUrrY2a7hHQ0deEdrZJTViqMnAYXym3oeP0maqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnS0dnaBajC7fx6yRBkwtQAc7CNkJJbzr9sd5GH9xIQ=;
 b=ZjoB6NUAdH9W+HqR48WGfH6Wax9wTw14xXnUBEY0vKTnDDt4GhjVl21tpbdWSA8wkLnC2L3DLdHMP7oqu5pTrlPaBHkYe3XLz6BswxeH811hYro/ca8j7Lmy1CChQr3H5KCPY2UH7IQEobD4PQOE3wkeMN5KeZWblKEKKfVSmfw=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by CH0PR10MB5020.namprd10.prod.outlook.com (2603:10b6:610:c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 17:23:04 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%4]) with mapi id 15.20.9253.017; Tue, 4 Nov 2025
 17:23:04 +0000
Message-ID: <038374d0-6f09-4440-bd99-fbeef8f6d683@oracle.com>
Date: Tue, 4 Nov 2025 12:23:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] nfsd: avoid using DONTCACHE for misaligned DIO's
 buffered IO fallback
To: Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
References: <20251104164229.43259-1-snitzer@kernel.org>
 <20251104164229.43259-2-snitzer@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251104164229.43259-2-snitzer@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:610:b0::28) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|CH0PR10MB5020:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e7d0262-ad40-4a6a-00c7-08de1bc6cff8
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Z2dKVU41NnJjeW9uWEtiZmovZnNNZ21PSm1LZXBOR1hLS2pMWVMwdWY2dUx2?=
 =?utf-8?B?ZmtER0k5ZEtXM21ZT2k0bG1Fd2Q5b2t4SG9UZkhnQ1pzbEhLWmcyK1BsSlRI?=
 =?utf-8?B?dnlFbG8xSmQzdUV0UktTUWVySTR4amhMbml4WWlsdE1ER2hra2IyYVZtSEdv?=
 =?utf-8?B?MGpLVGs4V05tOXBHYlZJb25CemRrTGkwU0JkQndaR3IrQmVRbXZVOUFOcS8x?=
 =?utf-8?B?WkVKMk1QSHNDR3VGVzZydlJHR1JXNjJmbnJmNWJ6Q0xPTG4wdVB2N3NMdUlR?=
 =?utf-8?B?eGNWU2JGN2xCK2EwSE45SVJmMDF4Zkc3R3FNbDJOK3pzNnQ5YmlrMkxzRFlV?=
 =?utf-8?B?RStjNTJLODNobmhpTTB4MFc4NGxPM2JGVTdraVhtMHNhWktJb0lVUXJMSWtJ?=
 =?utf-8?B?ck9uOG0rZ0cvWlhFREZuMnpVM2h5Wm1JbDdmVHFmWG11SmErOStjU1lDamFJ?=
 =?utf-8?B?OEw4WlNIclN2aWlYRGNRcWxiQU5veldNVDNwbUtSbDRwcGRBcllGUFQyV1l5?=
 =?utf-8?B?TTJ5c3UwcStwaUgxRFppMWtNcDZLdURjL1BDZ01PbzlKbnNFaDRxM1o2VHh5?=
 =?utf-8?B?TE1nV3ZXanNvWkEzT25Lb2VmbWxwZHUrZ1NMY0RJTnpUVHFvOWN5K3hCRFlY?=
 =?utf-8?B?dG91SENvRTMxTWRJV2JvWDNZQUFRMGo3TUpJbFh0Y2dFSVRxSysvclVFMEFZ?=
 =?utf-8?B?Mk9XQXB5WDhqZ3BraU9Geno2K2NzMnVJMVVtbzUzOTBVZFRJSTdpdDlsN3dT?=
 =?utf-8?B?dVlETnFycUorLzh5SmFaOVRKSzA2dUd6OFZxbm1GNUlJNko5ZFFFUEVUSWRO?=
 =?utf-8?B?aW1UeFU5NTh6dVdLR0hFU0JicGo2cWVIM3pzSndlQitjSWdRQ2lxS2NxM0hC?=
 =?utf-8?B?aGFhMWU1V1BVeGp0ck13c3IzQkJsNnc2U2gycG1pYlBVRkVDZ0dFVU9SaHRZ?=
 =?utf-8?B?amVOOEluWFdSdkNQTkdUVGtkbjBaOHJNVVVFL29IME1oSXltK2lERmd4Z1px?=
 =?utf-8?B?Qi92eHJCczQ2YlhBQUZLSVpOOURCTjRQSTgxNDBNY2tYcHYrZFlSM3BLQTAz?=
 =?utf-8?B?MXYzUnVSdnF2K3RnVzFEUlJpOGZCQTV1QndTU1AxMHZRcDNRL1Bmd1ZoZE1U?=
 =?utf-8?B?NUV0dUY2TU9TdmNaWHVueDRmdjJCbTZzUUZZUGtIUTR0UnZXaWlpR01HMSs4?=
 =?utf-8?B?T09CZEtHakNwc1EyR1ZkbC9GMmNnYUR3Uk5CK0RHaWE1T3FDUjZhV3BKNFlt?=
 =?utf-8?B?RGVJclJLZGlrYWhLSXZzdGlEbitHdXl2cEEyYWdwNTdzK083RTkrWVlhdkFP?=
 =?utf-8?B?QU56cTFjQ3gwSGRwcXpKQWlTbG9zZkI4aTJHTkJvMnh5a0djRFhRNS85NFpu?=
 =?utf-8?B?M2lMcW8wWXFhU2U5aWdaTE1oUS94UHZoangzMkt1eldFL01SNkhBc2U4NXFE?=
 =?utf-8?B?dlA5TnhBakpOUDJ2bG1Kenp6bWFWVlFNMkpjcnNMd2o0RkVCQ2xxRU5MOTJH?=
 =?utf-8?B?ZWpDUnl2ZTFaT2ZMNUlLMlVScUtmZFBYRnltTXhxR1djK3BwWk93Z1VTQ2Qz?=
 =?utf-8?B?eWNWWnFVNklodHdXa0lhMm43TDg4Y1lucFQ2T3BwcU1Ra3RXOTFWcmVHV2Y4?=
 =?utf-8?B?b2tudGk3ZjhMQTlIZzZvUnlndXBNS3ZSMWNBdW9UOWZQVitWVmxPaHprWUY0?=
 =?utf-8?B?VlpUSEJYaElaa1g3dGMzVHJaRjErT1lpc2JCV2UyZTZuSGIrQmtiVjhKQkE4?=
 =?utf-8?B?V09SS0IzNy9XNlQ2K0xPYlpxZk1TZUFVdkVMaFk3QXRJU3d4bkJSRUVWeXlT?=
 =?utf-8?B?Z3Bja2RwdUxYOG1HYTAwK1BRcis5Q0V6Znp3RUVLVW9oSTA3em4ydU5rdzRv?=
 =?utf-8?B?cFJaaEwwdEVrVC9YNGZqYnhrY1FFSDhNbmZZOHgwajV0c2wzeU1FTDExdzVT?=
 =?utf-8?Q?wO8Vdx3Z7XiphDvRhbB2R7yFfuvbVRuE?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dUh0OEFIZFR2K2psVllyUTlBZk12ZU84UE5Fd0FOamZWdkRzL0JLN3U4dlJy?=
 =?utf-8?B?ZDBwSERtdUNDWUoyQ0VCZU9nNnl3bVhtV1JFaUMxSHZjZ1l0UVpPR29kUjYw?=
 =?utf-8?B?R0YxMHY1YjVtdCtHWUc0ODhXM2JBdWpUY2czNmxGd1I1bUZDMFExQmw5Qitw?=
 =?utf-8?B?cGFqWGUvUVF0WXBmVU51MmdlZDdqYVkwOHRNbnpuc243aVUrb2JLdHdVVmNR?=
 =?utf-8?B?RUJzaGp2Y2VMT0NlUzZ1ZStOazljMG10eTNKbnV1eW1LMnFOdExJejdtSzF5?=
 =?utf-8?B?Z2hoV0NhaXFuQkJxSDFJL3BBelJqbUVIMVVrcGtEallFMjAwd3B0blEzTnJr?=
 =?utf-8?B?dnlqd05uOWpZSmdRZFVtN0tkNk93b05JSmlhUTBSVEp3QnVGSkN4ZGdDSzJF?=
 =?utf-8?B?eGZ6azBTWGRHWnRRbWZlSDJXSTlWRlRlVXBOTkl5MkJrZzRIVUVaN21DbWND?=
 =?utf-8?B?Z1VTT2I2bkpHVnN5Yi9CMTJMQmNlNThwWkZ0VnBYM0xMWVRhZ1VPdVR1Rk9u?=
 =?utf-8?B?V3ZjZHVEY3RSUk03a0JneWsrS3lyOWxzUUhmWStTTnFhTE9EWXdGWUZrK2ho?=
 =?utf-8?B?bFI1NEpDK2JNOHVwVkRuMmNZQVdYVHMyZXFUOFNnRkhvWUdrUWVxWEF4NU9X?=
 =?utf-8?B?VU90emNWR0Z0RkJWb0d1cjRnbU5mZko1Wnk4UEJjRE8yd0NJamY2Y2ZiR09j?=
 =?utf-8?B?Qk4vM0NXZFNqdElQRzdrdFIyakIvaFo2Ty8zY3lzdEJPdElncmpwd3podjhu?=
 =?utf-8?B?ZFd2WGRhd3hLVVJFdGNNR2gxWmhxVWdTSnpFemhtWDRDTzZqOW5qeEROdGY4?=
 =?utf-8?B?eDNsaEh6RElWSWtzcGR6MEZtRkk0Q0J1TFA2N1ljQkMzMzJSN2VKd1VkWmVx?=
 =?utf-8?B?L1R4TEYyaXBIV0Jkd3F4SVB2dVQ3MDA5SERTWU9nY1djY0ZDUHVTQjV6K0d5?=
 =?utf-8?B?ZENSa1pacnlUMnpsMnMwMjhkMXJPWUVDc2V2WGt5dUdMRFVRQzQ5OGM2eVVK?=
 =?utf-8?B?KzRWL1FmK05xQzNiWk8rSkRVd3I1SHI2NWF4SGwwVmkrNGg0aHBwQWp0SGhi?=
 =?utf-8?B?UVRxNmQzUm1JYmt1Mk5rNlcwL2ZDbEJEWWpEWjdDOWlsMUFScCsrR0RYa2dt?=
 =?utf-8?B?c0hta0VUTnlSWlZ6WGhjWExOdHdacSs2V3dQWVRqRE5sZWQ1eUNLM2RTQkc4?=
 =?utf-8?B?MW1oWGJXeUJKR1p4c1ppZHI0ODNJcktobHNlakhYRFBrTTkxaHlzQmQ1a3I5?=
 =?utf-8?B?NHk2TFBYaFphVWI2czBrQ29qd0FJTUtNV21PMUhGeEd5STRqcTFxSUZMNURV?=
 =?utf-8?B?T1pERWpIb1ZINEJYRENRNjFGblMydHlHeFNMVGVUM0F2MTdsajk2NUhYK05u?=
 =?utf-8?B?Q3FmSFlTT0JQUXkxemJmOWU2cTIySzRUZ0ZacE15WWxnSkxOSys0QmNmMXZI?=
 =?utf-8?B?SGdWQk03bHdXTnFkVXpYRU9aR0ZkUEhqeVNxNWFCUFEyZ2JYSmlEazByUGRB?=
 =?utf-8?B?OGRoTVg4RHMwTWJQS3pydTNQL29NM09yUVRLeTcwMUxkMkxkNHdaaElqSC9C?=
 =?utf-8?B?bnFld1FmZDNPMG9McnRXaVpKZUo1TngyZVpmVTA2ZjVKUURFU3g4Zm1GaERW?=
 =?utf-8?B?eFJiNEpKY3NrVGtvQUV6TGpIS0Q5YlhOa0J3TWp0b0MvMTRjTlFzS1BNVkpW?=
 =?utf-8?B?ZUpOaUxjdmJna3JjTEI5bWRXQ0s5NTRieHpvQm92OTRzZlVhNTlaZjQ5eDlO?=
 =?utf-8?B?amFnUGYyblFaUVFYUGM3OUN3WHhwZjJPWnFudHpMYTJOVk9naHRodERicFZQ?=
 =?utf-8?B?OW82NTNWVGk0VW83ZXg2N3JUL0o1WUE5OEtWVXdoUkhtdFBvM0RXU1haV1d6?=
 =?utf-8?B?bGlSUkZydmgvaTFva1pEVHhGWWNaOGwrQ2Q5V011V0ZuZWlCV2Q0WjRabU5v?=
 =?utf-8?B?VFNIT2RWYURRLzVoTTlHaVVCU2lVSHNjQ1BuVVd0ZmRJRDYvYi93UlkwWStL?=
 =?utf-8?B?dzJ3emR5UkF0YTR6bFFCM05VZTlZc3JBNjdENTd5a2dDejBtVzgwRWFQM2Jr?=
 =?utf-8?B?WDVDaEg3QUVPZjFQU2lmOW5XRzhJdHVpcWJLSVJDV2JUSllYaEd4RDFOVjZY?=
 =?utf-8?B?QkVwMVQ1U1Flb1hDN2wzRkhReWhOQzYwcXJiTExtU3pEMWp0RmxOMHZxaDZy?=
 =?utf-8?B?bEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZNwuI2MfC6IRBCSAWCz2HklUQy0lfb01qUvV6xHugEAGlyG+WGmftfqirH4Im2Uzh8PxZbGHYJJN5ZFmp4n6Hg/CDF0ILSJF+aFq4deu2HBnYUfEP37JFehx3w8QKcCjzLiDfqoF52OTa85ZQQaJrgnbcitkk7GLUvugVkS8aKm0IcEMrZ7lz0FxBTbRBePhS/Ek7QHKqRiXAJ6a1I15UJCc6yOfq7EUYNbihcPMriApqvCBA90ps2HqGvknPGRUPgCY8r4f/UwP0FTWnpu98YoxfPS4J7GwhcP6QdlqjeV02IhaJobjJ8RqkUJtfidVpmV0GdzMDo8WmynVUjJ6k0l0KKEeRmIcmUMJ4atsfJszmiNEPqEGzhU0ZRnIE4oKXb1zh7Q19/Ta+MckbO5wWgQU8YSTBcF8mQJRod3lrHXd8USVoYyPEuP+vJs1qGH7u80lWOHiR9TnJwDFxgQ01KAqzWVus61/iqi53+NcXhUg7f8kCHCIg/P8tpWrTXdJaIUunF4kNvL3yD7OHe0UMCSnh7KUKH2czmCev0ZGlNZz4Nh8iek0X/WLemVFahqEg0grz3TH1JhzCjNq6MvdEJ0up33h86FTEe8CH+dj598=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e7d0262-ad40-4a6a-00c7-08de1bc6cff8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:23:04.7904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GtFjJaNIvPzpLm9xEkrse3fh33js+t6ES4zJNrU2ujdy2XkQvmFfY3P11SjieLA2vczqONOlzFh7fDb3I5ogrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5020
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_02,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511040146
X-Proofpoint-GUID: uWqnFJbLNOx6aYdndL_JPIUxcHD5eByX
X-Authority-Analysis: v=2.4 cv=O440fR9W c=1 sm=1 tr=0 ts=690a368b b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=SEtKQCMJAAAA:8 a=3Yx1fOL3kRb5t4ZLCiEA:9 a=QEXdDO2ut3YA:10
 a=kyTSok1ft720jgMXX5-3:22 cc=ntf awl=host:12123
X-Proofpoint-ORIG-GUID: uWqnFJbLNOx6aYdndL_JPIUxcHD5eByX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDE0MCBTYWx0ZWRfXyUdbsEB8yHN2
 D24bBHvDGlowxZx3l3XO5iftKds7IvfWX039AJFNLcXTNWVGu22zz4Yn4JX51Gd8/zJVY4AzU+S
 K9Ba4elMYbeWJefSPtu7bbYUHhHmCv56tPl8oHA2aSs/X7zAUGAYUwl8OZ2Kq8g37/we2jp8Vc5
 YQIbF9eKMHwSiI1d8X4L5eyaKy+GQTb3ZznXDwGGC8tElJbmpXLKNpxgs+MVLiHvs1IO3XmM706
 evcQhus7fb4jrWnuM1M8kocQtKz+O2Rl8xCtfwTyCmlEFPb2IZilExI2Dw/xv2cOMz9FFgXgwBm
 O7pFt9xzb+Tfw4NlCNUyLtQn6+S1+7DzBMyI/YTxilNPHCL9VaRYAvteHLf6g6BxFfJnFifHId4
 IZXgia2Zsx4MEsg9RXjWC0d/eTF5gQWTySVajFhHf40CN9E7YF0=

On 11/4/25 11:42 AM, Mike Snitzer wrote:
> Also, use buffered IO (without DONTCACHE) if READ is less than 32K.
> But do use DONTCACHE if an entire WRITE is misaligned, this preserves
> intent of NFSD_IO_DIRECT.

These two changes need to be separate patches.


> The misaligned ends of a misaligned DIO WRITE will use buffered IO
> (without DONTCACHE) but the middle DIO-aligned segment with use direct
> IO.  This provides ideal performance for streaming misaligned DIO
> (e.g. IO500's IOR_HARD) because buffered IO is used to benefit RMW.
> 
> On one capable testbed, this commit improved IOR_HARD WRITE
> performance from 0.3433GB/s to 1.26GB/s.
> 
> Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
> ---
>  fs/nfsd/vfs.c | 28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 701dd261c252..9403ec8bb2da 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -104,6 +104,7 @@ nfserrno (int errno)
>  		{ nfserr_perm, -ENOKEY },
>  		{ nfserr_no_grace, -ENOGRACE},
>  		{ nfserr_io, -EBADMSG },
> +		{ nfserr_eagain, -ENOTBLK },
>  	};
>  	int	i;
>  
> @@ -1099,13 +1100,18 @@ nfsd_direct_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	size_t len;
>  
>  	init_sync_kiocb(&kiocb, nf->nf_file);
> -	kiocb.ki_flags |= IOCB_DIRECT;
>  
>  	/* Read a properly-aligned region of bytes into rq_bvec */
>  	dio_start = round_down(offset, nf->nf_dio_read_offset_align);
>  	dio_end = round_up((u64)offset + *count, nf->nf_dio_read_offset_align);
>  
> +	/* Don't use expanded DIO READ for IO less than 32K */
> +	if ((*count < (32 << 10)) &&
> +	    (((offset - dio_start) > 0) || ((dio_end - (offset + *count)) > 0)))
> +		return nfserrno(-ENOTBLK); /* fallback to buffered */

Why not just return a specific nfserr code here? No need to go through
nfserrno.


> +
>  	kiocb.ki_pos = dio_start;
> +	kiocb.ki_flags |= IOCB_DIRECT;
>  
>  	v = 0;
>  	total = dio_end - dio_start;
> @@ -1184,10 +1190,13 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		break;
>  	case NFSD_IO_DIRECT:
>  		/* When dio_read_offset_align is zero, dio is not supported */
> -		if (nf->nf_dio_read_offset_align && !rqstp->rq_res.page_len)
> -			return nfsd_direct_read(rqstp, fhp, nf, offset,
> +		if (nf->nf_dio_read_offset_align && !rqstp->rq_res.page_len) {
> +			__be32 nfserr = nfsd_direct_read(rqstp, fhp, nf, offset,
>  						count, eof);
> -		fallthrough;
> +			if (nfserr != nfserr_eagain)
> +				return nfserr;
> +		}
> +		break; /* fallback to buffered */
>  	case NFSD_IO_DONTCACHE:
>  		if (file->f_op->fop_flags & FOP_DONTCACHE)
>  			kiocb.ki_flags = IOCB_DONTCACHE;
> @@ -1347,6 +1356,15 @@ nfsd_write_dio_iters_init(struct bio_vec *bvec, unsigned int nvecs,
>  		++args->nsegs;
>  	}
>  
> +	/*
> +	 * Don't use IOCB_DONTCACHE if misaligned DIO WRITE (args->nsegs > 1),
> +	 * because it compromises unaligned segments' RMW IO being able to
> +	 * benefit from buffered IO (especially important for streaming
> +	 * misaligned DIO WRITE performance).
> +	 */
> +	if (args->nsegs > 1 && (args->flags_buffered & IOCB_DONTCACHE))
> +		args->flags_buffered &= ~IOCB_DONTCACHE;
> +
>  	return;
>  
>  no_dio:
> @@ -1400,7 +1418,7 @@ nfsd_direct_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  
>  	/*
>  	 * IOCB_DONTCACHE preserves the intent of NFSD_IO_DIRECT when
> -	 * writing unaligned segments or handling fallback I/O.
> +	 * falling back to buffered IO if entire WRITE is unaligned.
>  	 */
>  	args.flags_buffered = kiocb->ki_flags;
>  	if (args.nf->nf_file->f_op->fop_flags & FOP_DONTCACHE)


-- 
Chuck Lever

