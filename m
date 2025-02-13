Return-Path: <linux-nfs+bounces-10092-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A52BBA348C9
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 17:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D72E16189E
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 16:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1501531C8;
	Thu, 13 Feb 2025 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y4WnylYl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DDB0zhcL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3466D26B0AE
	for <linux-nfs@vger.kernel.org>; Thu, 13 Feb 2025 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739462454; cv=fail; b=pm8aCNrBNf/Q9OBo7RCRo4Z61z69+idg4mxvYHM5AZfnlPfxQA7j85dixv6kW5a2UsrXpzSkLPxLDSziKeXpWmq4RSXoV2ao2b16jy/a8UewI0wnIhFT977S1t1Cl52wZ4T0IpTM6ofJ0fjT0V7DX8OKtlI+6ZLv5fRVe0GMnH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739462454; c=relaxed/simple;
	bh=wmHIV5m0ZyxwAwAPypTzH65qZvvYZLReAYLv+IMHSM4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d4KEltisPY5JEq4LQGMBkJbcecdelwToGgV+1BuZ+SMN4qtti6Xr2LqQbI4Ujis5O5otii1+gK+/EoU17+iEzdpnYGftEhCa6aE98yZVz1dLJitRPNbpa0SWPJhBYBSFGuKG8ocfVE8AQsAgpx+BlXY4jfsowWUiio5sMXb3TpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y4WnylYl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DDB0zhcL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DFfXNt005867;
	Thu, 13 Feb 2025 16:00:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=VZJCkO2McMGK3avowFe48IFP/X9oG1OAOnY0SEnM4hE=; b=
	Y4WnylYl0XyBPd3niuHZX9rRMNIvazFfGMHandNZ5SV8Bm/xBRQ/hTlCCEN3RW5q
	8dQwgOGETTclSPnw3bgSq391gE/PnIRclw3xWQVwMvv/hDyaWdCnvSR6+WBzYuO+
	13sIi8KQgpLwqyqrELXXlnF8UF6AmzuHHWlIxdQp4KJgnM1Weu0ljoC4jBK6eutp
	QkLEB26coD44lSL1+cA7lO/NBazMsRWqx0CJKCwPh1DAhgub9z4evhG/xoeRfawj
	A9v/Qm2+/S5jWc4SbC2SARI3Xhf9aM4kfkjcQhf9Zkj8Zn20JoX6/ohGNE5yym3P
	IIoJNDIeDomCYauNWqT0tQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tn9ty2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 16:00:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DFx8li005174;
	Thu, 13 Feb 2025 16:00:49 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqbut51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 16:00:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ureHC7sIZnVYFNBdj8zuXHIGX5Riinpy47NL/Xddeiu1Lf1JXDE0NfvXF5urxU5ZW8urzv++0vdfAaaEWzCtTevepxhOFw5Er8VkeQVJFdJxtL7wJ4SGroxjxkNpB4bYY1qEZ5sno5K05BY/RMqWS42M8UDbg1K+OerP+1UapbBf60yjxmBTtlcQmmptZuJqmaT48oQ2qRGwCkaWyB33QqmGNVdiiqHsyexcix0pbNf//CHw6wH63wRC9jWRllLLQCaMLdDgA1yfcNEOzeWOs3D7f2LSx6WF4yLI983PpAYMhCNLDhvVk4mw4Il18Sjlw+HeUriaUQuVQWqZ+k75Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZJCkO2McMGK3avowFe48IFP/X9oG1OAOnY0SEnM4hE=;
 b=rmMAwvO2ym1nHewgMTPx7YlFO0pd4zpzZknugB6AjEoqFQETkaRTWakEG8lGpxnr8/d/TvVQs1KDW+9w08cjcgiRkBkjfbGepHnzo43mI6xalxIq46dh9bC1MuG3rBkuVFQvHd9f90d01/p5sMzZoNmj5xsaSE+fZpDvXwitivlHFZhU1NzKKjDsV2oc0KGEYEEnXnF3gb5L9TyEqowdEjAWkYvCK93YO+yBmkciOc8Zwksdly2+8HfOxOKQNrYs4GN7Z4AlvL9Hy1b7BqcdEgu/4cbbbJW6kIz+LRzuPvAXH+huoDXunZpHYXo/R3eWchVyWmWQFak5Ncx0fVdzdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZJCkO2McMGK3avowFe48IFP/X9oG1OAOnY0SEnM4hE=;
 b=DDB0zhcL+L6vHtH3e8BYLrOIgC+RSfMcwW3pMg7DmPVb9xC5yVMWdcpSFH2A9UhirR4eCfk6ucEgz+IbMUo0UdI4Y5zQ6jKLThXIaK9q6KkC5DiejSzPTrXVw5H+KdULbfSYZFTThvk+DhfgnaZ6WnELzXgszIVikuceQAEDAFE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CYXPR10MB7974.namprd10.prod.outlook.com (2603:10b6:930:da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 13 Feb
 2025 16:00:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 16:00:45 +0000
Message-ID: <c65ebd14-f7e1-45a8-9bc2-211440977ab0@oracle.com>
Date: Thu, 13 Feb 2025 11:00:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nfs-utils: nfsdctl: dont ignore rdma listener return
To: Olga Kornievskaia <okorniev@redhat.com>, steved@redhat.com
Cc: linux-nfs@vger.kernel.org
References: <20250213154722.37499-1-okorniev@redhat.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250213154722.37499-1-okorniev@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:610:76::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CYXPR10MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c2f73f4-4ebc-4bdd-09c0-08dd4c479357
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGJGbnRjU2phOUVSYUVtQWl6Z2UwdFhIc3dtV0dkZGxpV1BjT28zNjV1YmNR?=
 =?utf-8?B?dXZsZTZwSUQ2L2JObTNsUHVkZktlK3A3OUk1RGcvS25MZy9icSswWnBwTDh0?=
 =?utf-8?B?Q0tRTjA5VVhuaTF1eDVEU2RGMm0xeEtmVEV5cWlDZTl6RFh6aW9iYlZidnV5?=
 =?utf-8?B?bGZyWnVzSndDQ2FBS2t4OUQ5TGlHMmVTaEM0SndoUWljS05FMWZsWkRHY1ZP?=
 =?utf-8?B?U3RYUVFSVHU4ZGZNNjVVRlhPVVBiUllDaCtBbWhPdzRMcjdSbzdZb2QrSHhY?=
 =?utf-8?B?T0luWm5Uc2RkL0ZzVFFXOUN0Z1NscjFUMVcyTVZNU1Z5V3JnMUd5WEdDNXk5?=
 =?utf-8?B?S0s2Qm01cmtoTTFrbStLQ0NqNGs2L2c1V08xNFhITU9PUGpjTnJuWUhXNk9q?=
 =?utf-8?B?SFlzai9nSTNpNitTOUp0dHUxSFBPSmE2ZG8ySlJHbnJBVUEwOWJxS282ejAy?=
 =?utf-8?B?cCtFb2JGRGtuaU5udDRTelRRZHBBRVdsQThLUDBMR0xVVU1yK3ZFYXNUOUZR?=
 =?utf-8?B?OW1CUDRGdVlCL1VTSEdzQ3MvK1lEb05aYmEyT3R6YnRONnlDY1lMK05HSEo4?=
 =?utf-8?B?MGlLWDhGQWc3SGhkSWpNM2ZHTWJJZjVWb0p0RXpkL0tRbldwM3IzWldMeXZ5?=
 =?utf-8?B?QXBKV1VqVDg0MUI3YnpkMDR4dVNTd0Fwa1QwRU5yS0hiQzF2UGN4NVF5R0Nu?=
 =?utf-8?B?cTlYTHFzZ2p0NUJOQVFpWStLQ2tkaDE4eFU2M2pxVGdWZkEzZzR1OHVRMThP?=
 =?utf-8?B?Wmo3ejc5eTAzVkhQOEdIU1VkUVZMeHladldQVWxuVVdZeGhmZmM2L2ZqTnQ1?=
 =?utf-8?B?ZWk1QlUzeHp1eGZKT2ZFZzJ6S0tpbXBvY3hrcnRMN2svMmVIb2U1OGlEcDlB?=
 =?utf-8?B?M1U2a0ZUUHFrc0NMT1JZM0lWdDd0VXNjVTZpeXFycm5iUDFkdWF2TFQ1YThZ?=
 =?utf-8?B?WlRJOXhoZ3BZZ28yTURwZGtFU0hIRnd4QTgxV3Q0YmNmRGIxQUh6YXNTa3VS?=
 =?utf-8?B?VndKcFkrcTdtbnRWQ0pFajVpSFljR1BpU0pEWWZWTVYyaHlMSU5RdXlIaWZJ?=
 =?utf-8?B?a2s0QzNCd0Z5OUoyL1NNRVFDK0hXaUxuTzJlekpzYWhwWVJTTWVVbHhGZGFh?=
 =?utf-8?B?R2VicGZ1QnQ1T3ZuTW9BMGExS1VkT3dBcnYwOVNNZjc1ZFBrZUY3VmQ2MExi?=
 =?utf-8?B?T216QkVoMjE4bW1QcTIrZTFuT0JYZ1RQOElPSDkzNUh4TmVjQ2trWFhmQiti?=
 =?utf-8?B?c2NpdXJLQWFLUW5jbmUrYkZOYW5oMXBXL0NxVEpQYkhNR1NNTDY0NlBwZzZU?=
 =?utf-8?B?VExWV3cveEJZSGlkQWxWT1ZJYzRrc2ZjamZ4WnBwRUNVWVdkR3Q5R0NqbG1n?=
 =?utf-8?B?d1YrcXJZdnkycXhiSGNoNDRjbGVjcWVGVTVLL1I2bDRTT001WGZSaVZCMHRv?=
 =?utf-8?B?M2FvL2VoYy9Ud0p0TXMrYldQN1NSdjFlSzA5M2hxT2k2VER6Y0gyM2hOZHJL?=
 =?utf-8?B?WFkvUllUcEF4RU1PdTl4eURYYm8rdHU4dUxRNWRzYjJSalcxci9IcGZFVUlE?=
 =?utf-8?B?WWZCSnJSODR1dGRaSnpFUW1ITFN2aEhNck45cm1TSlFiMUtWd2pTL2krM0s4?=
 =?utf-8?B?YzNZQnY0M0hrMkJPZDhibTF1Z3ZSNG1UMlphTlRKQ3NSVjFZcDVRdGFJZ1R0?=
 =?utf-8?B?RzY3YXZzdEwyQml5QnMxUFhraHpvZnNVZitmRVRFUHhBMWpoNmZyL1hYU1Zn?=
 =?utf-8?B?YjFPWWIrMFUxUWQwekRaSzVIL3plQWxhVHBKTkdFakxTUk5QN1pJd013ZHRW?=
 =?utf-8?B?S21UZjkyTFhZZkluYnljb1VHejFldlJOU3BFZ0hyOHVYSUVIVXlKMThnWExE?=
 =?utf-8?Q?iduN8D6OH+iAF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vy9jQ2VDTW1SSHR2aHU0VWpMUVhJN3IrcDJSMVdydTc5QUVJT1lMa0loUWdm?=
 =?utf-8?B?clNWZldWekRGS0JvSVVwSm1TODZBZENnZXRDVzA2ZWc3dVRKNGgrQWhYUjlG?=
 =?utf-8?B?ZkhPanA3YVVzUFovU1VNVmNGaG01VWpReVJ4MkdvY000Wm5Wak13U0xlL05x?=
 =?utf-8?B?TDNYV0JTUjMzSWR5dTVNV1huZkM5bFFldVRFUkJ2WHRWaGNwQ1VBck9LNUhU?=
 =?utf-8?B?cmxJVFhUa09PUTc4N3gwUjVta0FFUlpuYjdWeXM2cHZiVWtlVlZoNFJucGVI?=
 =?utf-8?B?c2xzSWg1eWZ5dU5xUE44bnpsWHp6VEJ0YnUrdlJTV2RSdllWRUg1bkVwL2NF?=
 =?utf-8?B?amFtNDhEVWFnWmVQa3dhUml6ZGNMckhOVkRYeGF4YW9rWE50K0U0WWNZZy9q?=
 =?utf-8?B?QkpUQnNiWmNHOUVYbnZ6YVBodXcvY290bFhCd3pyMWJFMHV5dzNsam1lSGlR?=
 =?utf-8?B?U0R4K0xMd284OXBuQjJDZngzaExnaE15cEtSQ2tieWg5V1BEMXZBcWlqY2Rv?=
 =?utf-8?B?UkJQK3d4TFk0YUtsZFVwS2hKZGJkVyswVTFQVUF1bjRtNTFXMFJ0WkwwM3dR?=
 =?utf-8?B?bHFiRVh0a2taWXBLYm1QS0pCR2szNEd6aXJnTFpOYWwvWE1iUUFpWkQxY05J?=
 =?utf-8?B?QW9jUE5PMWFkWEEzRFRNajZTclA1cGtkQkcxd3FNZHFFQWxnaENERUIxQS9O?=
 =?utf-8?B?dlI2L24xZE8xN2kzSmRwNEd6aEtOVmNkdE9RWlZTNUcyWm8zUTEwbWlzYncz?=
 =?utf-8?B?dWdXSmQ4YnFPalJnSHIvbXNrcWx4M3dJaW9odG5qaHJDWGNJV3gyWUpRS0Qz?=
 =?utf-8?B?TW9tT3VjM1JSSjNodkVkR2IybTZ6MEpJTHp6OFFnM0RKT29Pb09zZUJSVnp0?=
 =?utf-8?B?TGJRY1dOdzRtTXYzRGNJdjkwMStSVTViSncvTW9DUkI5dEI0MWVBd3VTYzNC?=
 =?utf-8?B?YlhaYUdPQThPTUVHY2VDWGluSGR5NGpNdVpIdmFudHhkL2FveHRaWEtPdko5?=
 =?utf-8?B?c2pSejJSNHF2K0pBWXc5YUVtbXdXNVJNb2pIZkxDYXlXMkozS0k3aUVYZjBj?=
 =?utf-8?B?dytQM0dvbGQwRTc0SHVCS0VUVlQvYmkySkIyK0ZscVZQUHRzcGlTa2U0dFhs?=
 =?utf-8?B?ZC9GRy9iUXA2dmlxd2dMMC90Rm9wOGxGZktUOVRic05hTFUxL0F2WFc5UXFQ?=
 =?utf-8?B?UEQ1REJ2R2h6VjgvL1RxeHVvcG9Nbk9lZ3YwcW1wNjNlRURGMEgydHYxVWs2?=
 =?utf-8?B?aldhMVFvWWdhWnQzU2tmM3ZmdUptL1k3ZGdjQnRaaVpzRExLN0RqUTdEVlhv?=
 =?utf-8?B?NWVvdjlVWk52T2dLMjA4aXZhMFRvTFk4dkt5ditDTk5aUEp4YnV2WTUweTVu?=
 =?utf-8?B?dmdKS0RBRUFEYVZSQjBDNXo0eUF3ZzZXQzlnZ0g2dEJJUzR0cFd6cHVOdFUw?=
 =?utf-8?B?WjhSRFdYY21YUVlwQnB3dTVSV0NmQ0d5WmtuczlDRzlIVHZUUnlVbFBGSm83?=
 =?utf-8?B?UXk1WnVRTnpqaEF3U0lPbVV3SnhXaUQxTWlhTDluS2lMY0lGQy9xb3Y3Nldt?=
 =?utf-8?B?ZmtLRThTNVBZdTdMNG90R2VYZGtzNzFMZXlpMitXZE12bmo5aXlPVzIzclRK?=
 =?utf-8?B?VHFNczhuYWJ0V3NHTk9zU2x0MEQ0Rmw2OThTWWNhV3ZWUUgwcUZ2KzhDSXRx?=
 =?utf-8?B?MG9NQ3VuV2NnVCsrM1dBZXJnTHhtZXFJL3JVbEJwQS82bW9jS3FvRjlLM1F1?=
 =?utf-8?B?czZqOCt0SEhvNEo5L25veGxYTDRzN0RPaURFdU1zVnk2U1pLTzFmbDJVaS9O?=
 =?utf-8?B?M3ZpbE9GRjBicnI3MjVVZnhNR3A1TkFPQzJIbzNIVjV1dUdFVDE3cXRWQ214?=
 =?utf-8?B?azFOVWY4UUtkVG5nSG1BdURBbEtZQWVsd2dwZit6c0pUaWlURWx1MHdRcVRK?=
 =?utf-8?B?N0NQNHdFd2pZVGRhMVlZRkFtaUdNMW53WGl5R2YrTk1BVHBLUEZhMGxlRzQ4?=
 =?utf-8?B?UEhVU0JudTJTMHB5a1d5NFYyaDYzYmhrd2Q4WU1xZ0NHaWowRExTeExsNndR?=
 =?utf-8?B?WjlSdDZrV2FIZEJFMm5sbW5IRCt2dWRZOGFFWE9pM0ljd20ybjVzbVJKRkwx?=
 =?utf-8?B?SlVDaUFEK2hmUjJmcUtRZUlkblBHRW00V3dNZW41amRFVytnNTFWbHUzclEr?=
 =?utf-8?B?RFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QXPiVtV6foe+7aHDqL8T7YstSmLslnwZLLqSrla/2OZtY7NBT5w7d80/6qyFvWDMNW5giHKdzN8+nSiwQN9KKrxtwL7irbXkVCXlwRVpGgU2DKppN0PEiDVBNRK6QRsuICm2+uVNvMpVwLeTJPMCaUmX4BjZYv2zkkEay9C2yx07l/OytFz5idmblPVrfy0YJi7f9yxz/sjTFkdtllYBc05fddGn/WTXItN7GEParos62jjkgpoIjyr+QduzQUjt3k93s2BH/C28m8+bNG/PSMFA7grl0i+U7uUPUYOQLCang/p2ArP10FMUY9D9EMy/uquLj2P0asoBORIF67MCUZ+7vBch+PLJwG+LsNRIQGYjKmnZ6DYRPwI/uB3eeiDk4uFlK4CkfF+n5N7RfdV8rP5SJhT2rWNkZHYxQrurLmWt/7Hsh3q5O2Lu2U7FRfpDtLDNGrmiA/ApIcd8uwYYWGiEBl7/PEWLId67RvSOK09zgbXihIX51Sr4MDnUEBBKQBxQRes6avtUEv7TAKrCWmUdAZb2jj2fsuvp//fcpMZXcqVTOWDRPLJif0XouxtNAp/OwvNPNNgVTk3nEfGm63D5Bl93VsJG3dUNvo3bjUQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c2f73f4-4ebc-4bdd-09c0-08dd4c479357
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 16:00:45.6261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zIgAi0I64hemkHVHb2ZYUiJbV3RzmDTL7C7ETweWnIE9Dbdu6Sbm0g4ams9oRFgA0UTNV3ZpWHzZP6VOC1ZDaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7974
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130117
X-Proofpoint-GUID: 3Zrr8xt-jeQ1kRX4gLvTzpD4YzvAFbRv
X-Proofpoint-ORIG-GUID: 3Zrr8xt-jeQ1kRX4gLvTzpD4YzvAFbRv

On 2/13/25 10:47 AM, Olga Kornievskaia wrote:
> Don't ignore return code of adding rdma listener. If nfs.conf has asked
> for "rdma=y" but adding the listener fails, don't ignore the failure.
> Note in soft-rdma-provider environment (such as soft iwarp, soft roce),
> when no address-constraints are used, an "any" listener is created and
> rdma-enabling is done independently.

This behavior is confusing... I suggest that an nfs.conf man page
update accompany the below code change.

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


> Fixes: e3b72007ab31 ("nfs-utils: nfsdctl: cleanup listeners if some failed")
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> ---
>  utils/nfsdctl/nfsdctl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
> index 05fecc71..244910ef 100644
> --- a/utils/nfsdctl/nfsdctl.c
> +++ b/utils/nfsdctl/nfsdctl.c
> @@ -1388,7 +1388,7 @@ static int configure_listeners(void)
>  			if (tcp)
>  				ret = add_listener("tcp", n->field, port);
>  			if (rdma)
> -				add_listener("rdma", n->field, rdma_port);
> +				ret = add_listener("rdma", n->field, rdma_port);
>  			if (ret)
>  				return ret;
>  		}
> @@ -1398,7 +1398,7 @@ static int configure_listeners(void)
>  		if (tcp)
>  			ret = add_listener("tcp", "", port);
>  		if (rdma)
> -			add_listener("rdma", "", rdma_port);
> +			ret = add_listener("rdma", "", rdma_port);
>  	}
>  	return ret;
>  }


-- 
Chuck Lever

