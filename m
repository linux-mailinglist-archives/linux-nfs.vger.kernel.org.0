Return-Path: <linux-nfs+bounces-21707-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EnxEtyfDGq8jwUAu9opvQ
	(envelope-from <linux-nfs+bounces-21707-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 19:37:32 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99ABE5832CE
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 19:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06C95300A8F0
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 17:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41801403EB2;
	Tue, 19 May 2026 17:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U6ftF5bq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lZQGD66b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C2A40910B;
	Tue, 19 May 2026 17:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779212081; cv=fail; b=W8nDZqkZSTAZjL9L3AGGzcEyVDjYOMI2AD3U2RCL14u9cWN72YSG2UV3mxBj6rY1vAcwAtnG/mspoYyamM6ealEwqlE7+vR9zJGl80cj8ul3H/I/Wfg4JlML/OuMoFyEu0zBpGBHrLvcuvcbOriLLfCid6x5IMn4hsP3JsT1wW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779212081; c=relaxed/simple;
	bh=vHhXdaM807BtmLW8KfX+P9qEd/xKkTOUxGoBtrPS68s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SioS4XmOKNdp1If7CK9aZpneFPe7ij7bYr8p2rFgXaC7HbKJnxsQ1nWsdiYpU4k+2N1q4RuvRCD+57eIQeWnYZS1V2kR9liYmGaMoals/c1K9MSFo44lnAN/1UQWcahdWh5CbdTm1yv512+IWqadO4OqG6lG2E9h0lU5RoM31rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U6ftF5bq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lZQGD66b; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JHPaVW407542;
	Tue, 19 May 2026 17:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=PzmVcWHi1JY2thRC5W39MnDOrsfa+Qz8nlSuS9NAlpQ=; b=
	U6ftF5bqxxA0temPi9rCwNtthkRuZCpRLrjspI/dziswBPM2XACit15YIN2kgMLn
	red62PkUnqqqbOmclmTICBluhqPpOZ4uQTtyRcPfgVVWuuP5ghmY6RbPjp5uU1dA
	TOGHaV8sYxdWPjy/h64qSX/Wk720eCoKo5MQK3O/lkIsFp0rSdi0624QdyeT9TA/
	9RUev7g72yDn6VlVGfrlADdJdmueO6MWRanLXDT5vFrJ7UzR/XWclYHN5b8lHr3o
	FNZtrPGeuyPWBsH0H68OanZE2eDMmEG97KfZHa4upTe4mh09ODxM1JTYZG5FZw6r
	6l3r9cLr7AED9J2wWxicPg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6gyx5ehq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 17:34:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64JHTqUj032281;
	Tue, 19 May 2026 17:34:28 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010022.outbound.protection.outlook.com [52.101.46.22])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4e6f1b3fq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 17:34:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JVCGXaD4r1O8AL6I/hrZLxeUnwUrTx8w21t5pXsFxQsv3zj9yKG1Gq3Z85o8jccjDdFr8EXfrnu7YaCG0C+/UP2mHkKSmq+YCcSRuJJgVWl7ruFfexCMyFjF41fOPlEdYlRrs7i6nLB742+124S3wZ/AZeHLIERnV1xi0OOHCqY/Az0+/eorqJLpfTpjz3yYGuZrdFJdUQ6zBOzMu1ACk1DW8E6dQCi88YeMvEymDRmkQPtr/CRMhTqdIVQZ98te/4GxeYBO3M3qQOneHWHwDOtOclIf//FKsPFaHli8BOt6CX2wJoDse+LCTe2XcOKlJP+Pcf1bqcwmXiaiWld6sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzmVcWHi1JY2thRC5W39MnDOrsfa+Qz8nlSuS9NAlpQ=;
 b=Z5pXNip+X0XV9PhLmsAKKF1WYTmRkznng+JacLP0q6AxH7L23wEvyK6ps0m2yYvwYbg/dijp69r/pY0IZla/awaSMisUBK12vFFfdycNMHYzwcMsgu99AfnxvjXh7kNxrvUzURyB1vkQRAjpZuIEhp1fTjqrZuWtrZVgUr2Jn3CbU/VLlE5/XXqV19wAJdPGxUA2DooTT7qRJt23XoE+CVOAomJfRF1wSLJwOvdZKsJ6dE1YqY0qJc37nX3GbMEFf1G0fBB22vqtSQwsEagm4hjmvcttq64W+RxhO6LElm1XCdIdk2QhhYHlTUwNB/XhjwPV00TyXJA+ZNMakihCkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzmVcWHi1JY2thRC5W39MnDOrsfa+Qz8nlSuS9NAlpQ=;
 b=lZQGD66bYjAeh0Y8UwIuGmEmtIHO8thuR31tFD4qJwyIrsrIg5NpTSCzzRLei/3X7TpPsqSSHU8nZvCiN4TzB8oi9JjV907onyr4hbpbXCeuGTHr/yfBuXAyB294yVvSSPn0M1XRNlBkdoKxvqQsiOQaHPjsXlZD7xvrz849ux0=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by DS0PR10MB6224.namprd10.prod.outlook.com (2603:10b6:8:d2::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.24; Tue, 19 May 2026 17:34:22 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163%6]) with mapi id 15.20.9913.009; Tue, 19 May 2026
 17:34:22 +0000
Message-ID: <0e67fc75-382d-4698-ba93-39464e112e30@oracle.com>
Date: Tue, 19 May 2026 10:34:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] xfs: fix overlapping extents returned for pNFS
 LAYOUTGET
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Dave Chinner <dgc@kernel.org>,
        cem@kernel.org, linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
References: <961eb355-2f52-47a0-9399-e050a4e535a2@oracle.com>
 <06d9b1ae-e46f-459c-bcb4-1a5ca4ded4b0@oracle.com>
 <20260514002513.GQ9555@frogsfrogsfrogs>
 <26365a46-bdac-4e8a-a951-de904c3e5606@oracle.com> <ageSguSyf2kBY33a@dread>
 <b9860332-7b1e-448e-869a-ad59d8d5b7c0@oracle.com>
 <agqfBPRWXQDR2ImG@infradead.org>
 <606c4cea-70d2-4601-9db2-611cd35c3687@oracle.com>
 <agwDhixPAAA0-cTa@infradead.org>
 <55c7c22a-8edb-4833-be3f-1f6555ba90ed@oracle.com>
 <20260519145949.GH9555@frogsfrogsfrogs>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <20260519145949.GH9555@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::19) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|DS0PR10MB6224:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ea45502-7208-47bd-d321-08deb5ccdd66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	KLmC02UVd/PoI+6ZBRqKCBsp1wOqIPBf6Rfy3M2pwq0DEJFkBK2nmj0t1abW82ek7UmX9ER2IVkPqZ0BV7Wx3i1QuPkGZJ5rgiDjkuJk70ow9NLbHpKr/4czMjPDo0QvE1rD1GF6rvFTenIMHkZI3IHcnN7x9Ad8cL1/NdxKgWJULVLictDr46pR8czpJKIvr9NP61Tg/TtcYikT+SqRwJ+iLHpxpzKZprfFx3W968ABf94kK8cm0X0OI2T8BKFtybvLtsktKxxArDQk3Vv395fwD3TUtg163wWAs4+o7y7rTBacIDy6wfZsYF4cvjtb/dN6U+aj+BrRth36ysk2DupQJT2uSLpNWFmvPflsHN132QeSbMBVLFzU9lXVtqqiZdulSCdT5pZ6Mqs9Y7V5Argqatn1tJc02MQIVwnph2maati2amwuosedpUU8jnHejLPxj+hkre7rIzwDId+Xy8U2HJQyZ186BXNhrpx2Kuqf67ITulCZ0AAqwn64bTEAT8Q9i96IZCrBuAwgHHB2fHN87+evisSiKGdkchcMGSoJBfmh1MrFm4B6UGJ0IEVQHBnJhgFhx1dk/sXnw5sS18skJe57mO5hTUCWhDJ6bU+FBa5C5ve689vMK92fvDeJ4mvCKMpYMSSmwTpigox3mYJ6WBnFem8houN66OR3uTyRQtJvn2BNM8wNazO2H25Y
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFUrR2h2M2IxUkxsZGk2M0VRQ1g1b0R0S0ZMRS83aGFrNHBaa1pOUGZNUjRY?=
 =?utf-8?B?d2QzcVNlcWdaUUU1Q3NvZ1B0akRYWGRITnI5TDJJbjFBWm5zNjNic2E3cS9i?=
 =?utf-8?B?TGoyOWhzUGw0ZnI1bmRYNFczRjJlekVvYW5vcUcyZVIyMFhBcU1zUjcvWit3?=
 =?utf-8?B?T1JZdHRhYUhNdWx0b3VOSGxsVzBCNW1YNnFONlliMlVGaVJZSVBtWjVrM1hk?=
 =?utf-8?B?c1c2Z3ZydGN1eGpIblpQQUxGaUpnMXZBcUVoR0VDRXlBQ2dja3gvdVA5blZX?=
 =?utf-8?B?enp2MjJ5Z1FESFZSaDBDZVNuYVhmYUlJT05PNU80QTRzcDk1VVp3VXduQTY4?=
 =?utf-8?B?TnBubW9vMis0MVA4VVVvN0c4bXdNU21uTmVpOHplZFQ1aGszOFJ1ck1ncEdw?=
 =?utf-8?B?ZndiMEkrZ2hxbTFaR1BMTU1WTUNjQWpJcHpUSUtYaDVZTWF0b00yeVNYZi9C?=
 =?utf-8?B?d0hBMC9KMVk0aG84Um45YklWa1UzMHRLN09GdlF6YVp5ZUg0S3puYW9SL21Z?=
 =?utf-8?B?WWlWYy9hVEtyVG10NGxsRHZ0VXM3ZERhbUNwamk0NGJWY0lqTVBSd1lRME40?=
 =?utf-8?B?RjAzYlVCTDFxcWIrNXZnK3N4SVY0cm5Da0tJQUpyUHZRVDdSWEEwcy8wdkRV?=
 =?utf-8?B?SjdCL0dCU05oc1FRZDBJdXdyZ2I5Q3Vua01pQlBXeGVjeGdZcC9mdGdhUGJp?=
 =?utf-8?B?WU1weFpNUzFzaGJFTlVEL1ZIVTljSHg3aXh1WHR3a3pxOWc4ZXlWNzN4bGJX?=
 =?utf-8?B?NHRpQUxXYjJNamhYVW13R0NJdzYrZmtUWW4xdHdWbkt6TjZ3OHQyRnk2ZXVu?=
 =?utf-8?B?TEp2aEdsVDZEVzFjWGp5ZjFqOG9XOTBXZ0MzQS9rRWU1U2lLd1B4bnFqem5V?=
 =?utf-8?B?VFJRUUc2RTFndGJqL0xHdFkyU3RVMm5oZjUzallOaEQ0SncyQVFyMGF0M09D?=
 =?utf-8?B?UHY3MU1iZDRCcEpDQ1BNVmlMYTJ5aU04T1FBQ2pxOHlISE9XNWxCTVdvMEJi?=
 =?utf-8?B?UWFkOC9ZWFVtci9Md2U2aDhGV0NpdjhnOEtaUmlnQU01Y0NiVjdqdTV2bk1N?=
 =?utf-8?B?K0RWT2oxaysrdWJnQlpzM00rWG5HZVNsNzJPdFludVc4cnJNY2tKVkRyRHpv?=
 =?utf-8?B?dUNhK3gyOVpSZlBUMXJ3NU5nYVh0akxxcEtGdDh0UGhHK1hKbTdMbjI0Z1Fr?=
 =?utf-8?B?eGc1VVhqRDYvWVRYV1JmZHRCVGorS1hkUTNtbTdsNzRlaXZlN3VwTDFWUzE4?=
 =?utf-8?B?Rll0bW1tbFA5cUpGdy9Cd2RGTjg2OEVuT1A4b0FDd2VGQmo4YnVSRXQvZFJ0?=
 =?utf-8?B?T3FTbTQrZnhvTHNRZ215MlJoM1RsQWh1SnJvOUtNNDRSTGkwNGM1WnZYWGZl?=
 =?utf-8?B?bmlabHpYaWpJd05Da213ZlhjRGxEaDRHSmRxMVVkTHZBNExnZGl3SFhBOHU3?=
 =?utf-8?B?TUk4V3pSamd4a2dwR2MyR3pHdEQzMTdBVjBpL3A1Q2VyQkhqN1I5azVhWExS?=
 =?utf-8?B?RDFQMytwL3JkeEJmUlJMV21mSnBFczBLbmxERHAzb0Z6dUJueVJhWDBIcTlt?=
 =?utf-8?B?cUtIRXpFc3U3RDVwbWFTZG9uQVNMQ25rWHI2a3dzQWYyZDUyeXd5cGxqelBS?=
 =?utf-8?B?cVlQWGh5a3lZWWwvd05uQS9pVXhhTDBpYTROSy93RVpDS0FWM3JSenQvalpz?=
 =?utf-8?B?SE1KVy9jR1BVYmwyU2dYSmwzUllrWkFXU0s1ekRvTnpwRkNNNHM0d0ZCb2t6?=
 =?utf-8?B?STMzMDAxRXNVRjhxT3hmUlNXbG1kdmk2VWtXYjBRNXNBVE41dy9FUmlQb0lw?=
 =?utf-8?B?dXhoSzhEaW0yMWlhWTY3czlxQ1Bqc0hPcm9PM2g2eTU2c2daQ1JDd0xVVjhu?=
 =?utf-8?B?MXc0YmNsRGdITk44QUN6MmQ2VDBDWXFqL1RZVE92ZVk4TFFnVHordUUvbXZZ?=
 =?utf-8?B?SStXZEFhZ2FLejlQaFo0M0QwUlZvTjU0cHBkczNZMnpkc3RHUG9Dd1VpQ1R3?=
 =?utf-8?B?Z0ZiOEJIV3QyYlRNbkVHMTZQdWRLeWI3Slo3SWhGTjhPSmU5RXdwQ1VBcDJV?=
 =?utf-8?B?ZWQyd1l1TittaGN4Njl5TmVwclZTMmsrNExISXphcDRnVmlJRDBybWhZTDli?=
 =?utf-8?B?WUhyckw5UFZwQVBkeHJQVDcxNmhFeDVkWGd5dFl0RFN6bkJ3Rm9abW5jZXNs?=
 =?utf-8?B?YmkvRGlVeEZZaFFJSTRGcE4vVFIrYzdMS0Rjc2hLRnNONy8wL1FGVzNsaHlK?=
 =?utf-8?B?TUFnN2FCcmFqelB2dnlrWWNQOWpldmxpbm5MZnhXbnFkQ0xuRUVMa1EyRFNL?=
 =?utf-8?B?M3ZCMHVOSXNIeGFiY2dkMXA3bHJZSG5jV1h2OGhHYjlQVHpFb0FiUT09?=
X-Exchange-RoutingPolicyChecked:
	iwfoaeZVzvLCWsxleFeud6LgkjXzecC8prKWxYhHEp3t64NsZxBZxWhsLbzrzmrdeqmG0qAklt+DPOcTncZ5X5Y/d43aOBo0qRmwjpSzpBu8DMPFPAmGwhn6W0rkobn9NxzF5PjJKSxUSRJLjNCjgGVOxLOqDVg8gtGoihmyyjVsHeVptpXa4yToDtUhW5+rnruM8bjPkCig0y4Uli9JJMQom16uTxHwO9lMCGp9l4kSKuvceXEBBGytienm6Fey345WtRC5V/UnF5252ipIlzOfOlBmeF9gRaRLRhvpRdiGudlWQ72rKq9Ibf7Dlws6eOw7Euo0N/liTtwRnP+6yw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QgQbiwae5UckxQppm5g4aAk9Lye5VRID5DH16MFV2UztaJxFe1pXQl0W9W3FkEH2EroetJflvOTdAjqpnXvDz73AlWwkkZc3qrbSCWljETXyEy7sWF9MkowGUGRq7nVTfwFiMz3Gq641Rg05MIKPbTuEX4H7lkTaL0EhAvoAJ9WUoufxJswu53hSTdClUzemOLPDQuovxNO+Vf2RgmcDqEdQFL9P5Cu3YsiymwZcWD6eeJkpuNh08swLYfHm/gSP93Q1Pv34qvtIm631ddMKlTruEowS3Q0R0rL2pmG7P43Mqef1U65yVe03ceNxQMdjHhCtziYQXr1v+P5ytpyExGpmS/eAl0e/WgcbqlUlB0HTEuykXUkoyVAHBjhoffZFJ/foUi//AJMv+zswoEaopLkDcoWfYz+DxLVSaoP7DPSXknUqKjjfqUt8gqb2hOuIUqQH8smnj+HgNgiIPwFNE1lhBeYKl1vTndLcsw2eJm17B2sjE/j+wg4tvIHTUV9V3IHUGpaLZFjrVmXhZ0h1irSvpVNY1x31nvNNBO86GM96D0CyEYN3i/cAAs3n35KIKFdEztHN+wAI4K4SAGkvARFnCsfPM7WJV+MsVTimYok=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea45502-7208-47bd-d321-08deb5ccdd66
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 17:34:22.7938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4TRE7a6IaGiNGSPp/BDT/akPyXVTw6hh3IunCln95Fefcgj3PoAIeiAMSFSDeYxGELsx4bGqg+faxhC5TvuqzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6224
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605190175
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE3NSBTYWx0ZWRfX0ozq4nPVO/pF
 wS3Yoj8StCag46e+/jlbu4EhJ3fwXVTPAlqYr2ofCD9x8BVpkItO21t0zllbKTA6aW9i2E5wTiK
 m4YW54D93RvlLWK+xJbU9jD3Fftw4bYE4yGWobTU13UgTlUCc9jfci3lwlxXjzpGxY7/Q58Y0PX
 fImzKFFKuyQE7xBKYm2OlNNC/7YbKoBis7dh8ap+QJ25p5cO1m50JIxCmgOXz84DM8TysdU2y9B
 B2ZUq1PJPbypk4EVQlEEtemLIJunhZ1CLZWpCRbhx7Xs6D5GF91Dx/LKMeLtIRXtBXiButZZW86
 mlSc319QjcM4yGsaKlLwHP/7JJPjJSnNp4ODIWP8b8QcZLgNedyqe3KtVAuSZ4I4DhpuCUGV8Cq
 1J5DtVwRKj/375DLuWUh9hVS6bSHg+yuVfdnCoi5RsI0rEx3YSw/VSltwEgG2budTxv9SQGCMyL
 Iak2QRaEZxUtFc7feYg==
X-Authority-Analysis: v=2.4 cv=Ls2iDHdc c=1 sm=1 tr=0 ts=6a0c9f25 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=r_QLXbt0-w9VbU_zoeQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: bGVzBYwPhQNi2AcRdz1U74rgx2VwniqZ
X-Proofpoint-GUID: bGVzBYwPhQNi2AcRdz1U74rgx2VwniqZ
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:mid,oracle.com:dkim,oracle.onmicrosoft.com:dkim];
	RCVD_COUNT_SEVEN(0.00)[9];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-21707-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+]
X-Rspamd-Queue-Id: 99ABE5832CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/19/26 7:59 AM, Darrick J. Wong wrote:
> On Tue, May 19, 2026 at 06:44:18AM -0700, Dai Ngo wrote:
>> On 5/18/26 11:30 PM, Christoph Hellwig wrote:
>>> On Mon, May 18, 2026 at 12:55:17PM -0700, Dai Ngo wrote:
>>>> As shown, the file map changes. Entry# 7 and 8 before the NFSD calls
>>>> merged into entry#7 after the calls. So there must be some activities
>>>> that cause the map to change. I don't know whether the activities were
>>>> triggered by NFS or something in XFS or the block device layer.
>>> Hmm.  We only insert layouts (and search for conflicts) after calling
>>> ->proc_layoutget.  So this might be racy against unwritten extent
>>> conversion, or other writers, which is a bit of an issue.  I guess
>>> we need to fix nfsd4_layoutget to insert an in-progress layout before
>>> calling into ->layouget.
>> I can't quite see the race condition regarding layoutget here. Could you
>> please explain?
> /me has no idea about nfs layouts but has thoughts anyway :)
>
> 1) xfs_fs_map_blocks only takes i_rwsem and XFS_ILOCK; it doesn't take
> the mmap invalidation lock.  Does that mean that pagefaults could wander
> in and mess with the layout?
>
> (I think the race that Christoph is referring to here is that any other
> thread can wander in and change the mapping after a ->map_blocks call
> returns, because nfs isn't holding any kind of lock on the inode)

I think this is what happened.

Assuming the current map of the file as follow:

   0000-4095: IOMAP_UNWRITTEN - block allocated
   4096-8191: IOMAP_HOLE - no block allocated
   8192-12287: IOMAP_UNWRITTEN - block allocated

NOTE:
    . the bmapi_flags used by xfs_bmapi_read is set to XFS_BMAPI_ENTIRE.
    . the nimaps count is set to 1. xfs_bmapi_read can return only 1 extent.

1st call from nfsd to xfs_fs_map_blocks(), specifying offset 0, length 12288 and
write is true.

Extent Returned:

   - offset: 0
   - length: 4096 bytes (one filesystem block)
   - type: IOMAP_UNWRITTEN (existing preallocated extent)
   - addr: physical block number of the first unwritten extent.

2nd call from nfsd to xfs_fs_map_blocks(), specifying offset 4096, length 8192
and write is true.

Returned Extent:

   - offset: 4096
   - length: 4096 bytes (one filesystem block)
   - type: IOMAP_UNWRITTEN (freshly allocated unwritten extent)
   - addr: physical block number assigned when filling the hole at 4096

3rd call from nfsd to xfs_fs_map_blocks(), specifying offset 8192, length
4096 and write is true.

Returned Extent

   - offset: 0
   - length: 12288 bytes (three contiguous blocks)
   - type: IOMAP_UNWRITTEN
   - addr: physical address of the merged unwritten allocation

After the second call, filling the hole merged the three unwritten segments
into a single extent (br_startoff = 0, br_blockcount = 3). When the third call
looks up the range starting at 8192, xfs_bmapi_read() finds that single extent.
Because XFS_BMAPI_ENTIRE is set, xfs_bmapi_trim_map() bypasses trimming and
returns the full extent to xfs_bmbt_to_iomap().

-Dai

>
> 2) Now that NFS apparently can serve up multiple mappings at once,
> should ->map_blocks pass in an array element count so that we can do
> multiple iomaps in a single lock cycle?
>
> 3) Do the reflink and realtime inode checks need to be re-assessed after
> grabbing the ilock since they can change?
>
> --D
>
>>>> However, based on this data I think it's better to change the bmapi_flags
>>>> from XFS_BMAPI_ENTIRE to '0' to address the overlap issue.
>>> We absolutely should be doing that as I said from my first reply.
>>> Still trying to understand what is going on here at a higher level,
>>> though.
>> I'll resubmit the patch series with both fixes combined: the uninitialized
>> imap handling in the error path and the replacement of XFS_BMAPI_ENTIRE
>> with 0.
>>
>> Thanks,
>> -Dai
>>
>>

