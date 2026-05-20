Return-Path: <linux-nfs+bounces-21742-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Ch7GmnyDWrj4wUAu9opvQ
	(envelope-from <linux-nfs+bounces-21742-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 19:42:01 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CF0594549
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 19:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4971E311C825
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 17:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA32369D7E;
	Wed, 20 May 2026 17:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NeeAMzex";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nQE0hr4m"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D926628DC4;
	Wed, 20 May 2026 17:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298379; cv=fail; b=T8nn2CD4A1v51LN7g73mHBeTAiZVr8Pn5uuDYWfSwjErZrfPDdvonnw8BzUMRVNK3NpfbWnoCMA97/kCDYQxN70PPBPs9Bm7FUn2Mk4tcit6IgwEPDDf6M0rFAt/l18+I5tiHmH0fqk55ZxtiQlMUQMgFl2yBrQwkS4AQlfxOtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298379; c=relaxed/simple;
	bh=H3Bpkb6/XQEZ8fH4zSZ/jKxUNN6PIZk8YyqKhimOOp4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hs0wXmzCJlbCNc+btUZ7oISgPGd90d1w6JO47xhrE0mDosKC0SJIf9ybatmLKGITGOKRaFpFwbxgq6u2DV0hq931FT0DxnJkogI9lvtZsnlwzRTP1onE+bdMm9abV3OSNxuf3WRCSofgaXic8QbXXcst2XoqgyIn2db7vky9QPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NeeAMzex; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nQE0hr4m; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KABdqM2952828;
	Wed, 20 May 2026 17:32:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=0DSAfzt4oShXsO+/smc0ME0It1+bUsDANPmpzUwjnw8=; b=
	NeeAMzexmpPwt5hRb0Jo/wi/6P8s4g9QVEGNp7lH4c8/jaiJV4jaed5iYWsGiBMW
	el2ExEZnB6++VCBw8cEdWQNfWy5+N/sKHECQNIt8GCpBoEnhwLtvOm+ImXsp5St3
	D+lkbM0Po9ZjPiG1rMXbs8WAxPe0MVyI1nNVI5fTGBiA7FEMhn8jcHET0CW/Q1B0
	F6gMtwYmT1zOlwxuJQhw+3ZJPD6NjO8NQPAhKD9CF8yC5djDaZCTvV/o+QM1ArT7
	zUEibciG1kHW+w/yO8Ky9kO4VrTOOiUI8FudX0LS5+D67cTizvHNISzQU/IhOUyq
	CR67WeYBKHQywkr8vrFBkQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6h2sfcjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 17:32:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64KHU1C5022159;
	Wed, 20 May 2026 17:32:39 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013051.outbound.protection.outlook.com [40.93.196.51])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4e6f1ceytk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 17:32:38 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ktr/gsr9LEIwP75qNLtsN+5ZDUsLhmyvKymygwprlCL3e11CW1Jo9SXx4MEBvSHafoUz77WIK+WoAYj9ryoieNZt4BQVckafZ2jCo4hrYAq5cMfdJo3QJNWqWsjAxQjM1c01jcqs1XqQtGvAb4khBLw+TGAY7yp2ztIHQFAIYtuZtQTrgdQwp/DqJDMw7C1ur6Si6sRn2+MX6l42ohos1AQD6fcfYloWGX6fCodwSUDrviy6sJyPHqHpH0rAodrbObh+6Kb/3YuR0Q5xxWns/h/nrcqZU/2MOoHoeLvj4nqNbS1zXW/Wtvt3+NOn+SQKCdEuuXX12h83C8q38IYyTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DSAfzt4oShXsO+/smc0ME0It1+bUsDANPmpzUwjnw8=;
 b=tHU1mM4+QKkp1XnsUuivjWjwLoMNyBLxvi1c4iKGRBR+b5EoViMYJJO95MFOYGrgKGyx582wpyA4D+ETj0BMewCryVhHlNB3UWVIUjEYGg3nPDMg3Wr1d45n+RH9QKVZfb46Ijvn8lNY9DZloID0qyNqqksRrxs4cYoT2j0OqbB6bmeoP/Uqk2ybZFOj3NIdhuX78PFbMg321bYs21fRtHwkYiMrQBwgCWz4sQ/yCSliZ0d563I+SpIfcjWCzcqH2tng7gU6CrEXdYPEe/AeHRDbOkIPwNrreXQOqe+t9T8VpIW/PN+v4gs0qccKZgGAFA5Yq3WCOpEnOPqgBZBBqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DSAfzt4oShXsO+/smc0ME0It1+bUsDANPmpzUwjnw8=;
 b=nQE0hr4m8YlN+kgXuY/eGUiLpelntthMZ2H8pi7ZRKKCi1Nn9fLwgKGJrXmHoDSVB7A78Gugv3o4WjEYw26HI3zOgzVOT2uMHuqkuUU88ip3xAs71HGiMS45NkJXQApfk3QZOZWHDgUtEcqpUezOgjRXMybfMAHR3Fi0JZRAJJY=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by SA2PR10MB4779.namprd10.prod.outlook.com (2603:10b6:806:11f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 17:32:36 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163%6]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 17:32:36 +0000
Message-ID: <790b9c07-7b32-499c-913f-9b50f019ba21@oracle.com>
Date: Wed, 20 May 2026 10:32:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] xfs: fix overlapping extents returned for pNFS
 LAYOUTGET
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Dave Chinner <dgc@kernel.org>,
        cem@kernel.org, linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        Sergey Bashirov <sergeybashirov@gmail.com>
References: <26365a46-bdac-4e8a-a951-de904c3e5606@oracle.com>
 <ageSguSyf2kBY33a@dread> <b9860332-7b1e-448e-869a-ad59d8d5b7c0@oracle.com>
 <agqfBPRWXQDR2ImG@infradead.org>
 <606c4cea-70d2-4601-9db2-611cd35c3687@oracle.com>
 <agwDhixPAAA0-cTa@infradead.org>
 <55c7c22a-8edb-4833-be3f-1f6555ba90ed@oracle.com>
 <20260519145949.GH9555@frogsfrogsfrogs> <ag1vwFHoYatausLK@infradead.org>
 <e55a29a9-ed18-4e3a-8378-f712bcbc940f@oracle.com>
 <20260520164856.GI9555@frogsfrogsfrogs>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <20260520164856.GI9555@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0048.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::23) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|SA2PR10MB4779:EE_
X-MS-Office365-Filtering-Correlation-Id: d5cd0b11-4f6b-4cb0-5969-08deb695c84c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|4143699003|22082099003|18002099003|56012099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	1y9rnapQ4T0hms/eZPYX/sasstaLLLBaVWYLQEAHgOEMdUB8zRoWNR2UP8pKOCoUoGh4HfNv+0+1jlpKWVA5wUvIgotCMbg/T2dFUqQWFSql76LqK5KNyIWS8v9Va3uVAiJ57sfApo//sqVap+Ablox1Cifg3anOkd9OOh2SXFrL3wHi1ml+NZC2dDShK4K0+fjsyFihHl199sUkKvhfN4PpTDYvKF47Wu4vdSXz4LJg0kG1UVv65cUNJo/WIvG4y0Q5koA/Jlng74vrx/j8ZJ/oW07wQSQ58tE6G2oRm6ZhQCCE8QrrgXyLNp81lWoah4NO6iQw4otDKkJZWZqAtaLUEd3JLADGAcqJi03VcpxfAYKtnQifSvRs4PMLGOrc7hVp4PYusubird6YntRSYpnyVltapWvneXrmHk64kA1QfPHx2kmbrM0waaXiJGVMzf7ztcYAUUXdO77oz5sYGhFQSXRuutFfKOSlzpZTrDUj/oDjHoVOg7n12oIPgcO9hZ606EbUeVoh2SghcuCm6IEqfCnj1GasoRZj0Kl2qPDTul4ocjMhA1a2kKzWxHrlDjmaclAQtYS2HxzNEli6u+ETDw+SAPd0mfA+Nx/HMcM0aZ+HVDjXLsg3Rb37GTz7fJ5lhfOnrUEqFWvfNPKLraqTtkfdGU7MRR/5ymgcTnwrV0SroD7M02VMiEVM2Vj2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(4143699003)(22082099003)(18002099003)(56012099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dStueE1DT2RRSFdHR3VlaTQyRUhIb1M1QXFEeTBEb0tMVUlMYUNWaGtSTmJB?=
 =?utf-8?B?YmRIREVYRngrek9WYzZFT0laVmxoQ2lwUlk2aTNQTzZDRlFXSklNTXB6RzRG?=
 =?utf-8?B?dUtuT1htWFV6b1dPbW82eUNkNUFENmJFOWpJY1dzMXpUelFTOFFPd2REbG1K?=
 =?utf-8?B?bGhGVzBtSXBRSXZIZnpXcFljT1pLNUJCMjI4eXNVNG0yazR4bFF6c1MwZzla?=
 =?utf-8?B?eTBsRElvRG1TdmI1YzFwN1J5eVlNcDBmdGpnNXh1d3h2ZXkwUEFtQjA5c05t?=
 =?utf-8?B?aHVNeWY4NEtTc2dma2RlUmxTZlYxaDh2bEhIUUtyNjZBSHdsQ3QwZU1wS040?=
 =?utf-8?B?SjlHZkR2U3RRRURxcWhFc0ZnNU1SRGhXOTIzZFlMdlRwdDN4RWd6TENpcTQ1?=
 =?utf-8?B?b0hka1Z0RTZxei9sODRrM0dEREc5MWpLTVZ0K1pPK3o3a2IzT29WaHM1UVRs?=
 =?utf-8?B?NDNUdkpGcU5SNUswZHBpQTdPRXNjaENVdkRPcjIzVXF3SUpuSU96Ymp1SmRi?=
 =?utf-8?B?bXlwWVkxNC9VNDNDeWVtNTNuVW5FRlBWSjc4WmV5NFJZUkM0a0NHWHl1TXFQ?=
 =?utf-8?B?TDZLalp5SFdxOHIvV1RrcklTZi8yUUduSGFYUkFXUjZOOEdRZTRrVDlxdy9L?=
 =?utf-8?B?TTBmTlZGZVFidXhramRNS1ZtMFRlblpneTdzRWYxUmI1ZUE2Q0NpNmx4azlq?=
 =?utf-8?B?TU9TZzM0SDEweTJlUDd2NWI2aDdpQjdaQWd2RHJGS2ZQQkhkbGhTMmo3cHcx?=
 =?utf-8?B?OFBObWpFMUh2bzNReWUya21QRHlNQkU4MXpGU1lUZFVxTzFyamNFdlJHYnZB?=
 =?utf-8?B?TFNMdzdXRFp0cEpvcVE0RHpHQ2RKK2lMZGdMbHRGbno1TEF6SXJEcEl4cnY4?=
 =?utf-8?B?ajl0V2pEaWhZU2E1OHlseVlxZDFUQy82cEJQUy9DeE1jWXdQWHZ4SDEwY2sr?=
 =?utf-8?B?L21OMitOZm5QYWtDcjVxREJjQnR6c0hzMGZBZW9yT1liSXhmUjFReVFOTnV2?=
 =?utf-8?B?eFBBTlFKVElqeC81R09CU0lnc3hsbU9od3hOUDhYbmg4L0dndG9YQnJjTmZx?=
 =?utf-8?B?b2hKdWkzaFhwL3ZGZEtXRjJQMmdHTElIdHlBaWhrS0ZNVC9mSzFzbGtYNlMr?=
 =?utf-8?B?d0VzdFBiNStaWkY2WTBWaTN1K0tqUDJTNkRWZStvalV2WEdQM0R5eVJBWlA3?=
 =?utf-8?B?dlZWUkVNM0hvcVhMMHp6cFVJR2U5ZXdLMVdGd05mWXdTMXNTaE84T3Z0WWFZ?=
 =?utf-8?B?YWFWYW1YS3lZdDk3WkV0TURZcGJpaktDcU9kZEF3eXJDMUZrcXc3VDRXdGg3?=
 =?utf-8?B?THJJSDFKK1VVSE9DYTU2ejZjL3pUeWNrYUZiYzhqZnpSZzg1M0tRLzl6aXFJ?=
 =?utf-8?B?bVorK0NzZmFxT2xFL1JqRkRSNm1EbUNqYnRrOGhZUDBqeTA3NEpNaE5sUXFq?=
 =?utf-8?B?SWxsbVhKMmN0Y0VaYlU5ZGdLdDhnaHRRNlNCbGhIbHlnVjdCK2VQcjJvZlk2?=
 =?utf-8?B?eTZNQWZVeW1wemhGMlMwTEViRXNLcjJ5OEtMbW5KWU1vWTUzcG5QTklnbGFv?=
 =?utf-8?B?dVdkL2gyUnJKSjZrajE1MmFNb0ppdkNtZk14bWhHdWJ4dUN4ZFpoUzZiRjNq?=
 =?utf-8?B?bGV1Wk9NNFdTSWxVSWNqcVRCa1RUaTEwVFNlUkVObFJZb21IeEJ0eFBMQzhm?=
 =?utf-8?B?akhVR3puVkpHTFRWYWV3clBOa2ZFdWtKeENOZXlPcWxpeUtGdllTS3QrN1F3?=
 =?utf-8?B?Nm9HclAvNjIvSTRmb3hiblZhdkdHUVZWdFRQNk5IczhaMkNENVNMazY4WFpz?=
 =?utf-8?B?eXVZRU1IbTUrZ0tHZ08vOTJ5bm9hc3pLTTBndCtmS0I2eVlCRDhSQmhNbUxi?=
 =?utf-8?B?NTBsWnhaR3R6QXg1U3UwSWI1YWo4OUswa1RkRy9mSmtPZUlUOHhGeE5sYmU4?=
 =?utf-8?B?RW1uNzh1N252RkdFSDNZL2sybW4zeUJvNUNGZnFBbkVOeXdseFd6M3hPRU1r?=
 =?utf-8?B?alpEWXRRMTdnK2QrMW0rdjQrcE1sbEF3bVVQNUp6MFFoRkxIYU9yUDhyR21z?=
 =?utf-8?B?M2tHYnhGbnl3Q1Z4QW1ySWdES01NYjJJNHNKd3hvY0s5dWx0QktpdjQwbHIw?=
 =?utf-8?B?Uk9DSThmQ25UUURCL1hyTVFQT3pDQlN4cnZia0VrZGZwNDJJbGJWUmRkRVhS?=
 =?utf-8?B?dmtadklGdGdhTW1sakRoTTliR0I3RlNXTFFpcHVQK1BMalRxL2h2aTI5U1Jm?=
 =?utf-8?B?MWNvRXk0a0twRDFubjdWL0J6TWpOYWE2WDdiWUFVcEZtUVl3RU4xTnpzZXh1?=
 =?utf-8?B?WmZxSlhPMkxlUVY3b3NuZXpIRGRoYWJwWTkxcDhFNDIvMFNwb04rdz09?=
X-Exchange-RoutingPolicyChecked:
	A48wSq00cpcQQGJf0O4vbKZUk/ffXOBjUS9lLgGdEGcb6EpTGkKHNxLZ/ZY1i9e/Jc2vsDARXAczfZdz05mnmLZpJg2qus0NUhXbwp+h45XuokMFNEkl9hyezLvT//wwqxASU24Xf8iCLiQoDd18F4D2/G8WlJaQSYeU5ha7K4+91LWKhm5R3BM/4YDHnhZVpP9MUT4BFmNX/6mnCF9mdUwMmK0doJq5xu1XTD98PVMUgO6cphh+kByxJkPHOHsSimb2yjBgusjiF4kHVj/YeJaVkVYSiRLmQLphfsQErNnqpkAhvR2HI/Exjq9ePDGU237WiTx6mPc6mjuJAiusiw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BXeSP3vugw3REeuBUWwFylXhbpZBbhuRLr7U1VnaCWr0j3iMC3yCNlaSxfdqwb9aQVJTkD1K8NAC1tlWPtXFNN+wozCkp+fLCoCDKGbzsWnAElI6gvj87sLc8ZJO3iUq1kUE7dmVpx0CBQt8a5/XQPMCK9Fm/78Q0tUgcFZw4M0VQymK4AnVtOmVtTxNN800RO9ClbIWtesOClbueKxgFmsju+PtFOpaAwppttZVAHsDIazXqHnProCN39eh4rvRfaXwo4lLwYSblCelbjacNdaAtLQR/WBPenjX7C+Q/hcjRG6xulRNE/RZckeZZMlPPkTOZMPfV7ClOAL2cNerRIUfjcXRPuzL6fisW4zm/5p9IKrEUFNAQt+mUJpo57dNU3oecIg/19ppKvwMLjWBfVDsBMGXvXd9s3ZLscZkpd16g5RgJKJuIrhqB6m+81s26L6ZcDoeaaEnVEkJMRzEZRSqOQT7IEA8yg4P5i43EWbb7gs6TSiDLbsNGgiIVfzvPl+zEJ6U+M1bbO9yFVkAV1TYQ17yL9bY8Z8ruWAm/XeuOZCdlfoRvccDmCnGxhrWrB0O3MUKSItbnQ530ulBDHglacR9NlyEZtoX1N2WmJ8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5cd0b11-4f6b-4cb0-5969-08deb695c84c
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 17:32:36.1460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ydBFikuFEWs24hSTM4wDQok3nsmhbYHXQ/btBaOJnvimif3zjJBcOwGU1ycYo+gmlbmv6CuJTAOSINYQw6ZFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4779
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 mlxlogscore=909 adultscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605200170
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE3MCBTYWx0ZWRfXzWjJ1sWIefo+
 zF2p0e1lGMMafmg5l0wmPHlRO4OG9F825aKrff7JgP6yDDA8RyZnlc/6cTPgoVPx2n3ZnaqyLYp
 F2cz1uwqkFT60cfJlh0TebkWBe+I6sRd8T4YpC337HQvoDXEbZZ/tcq4RS7YJWVwIlDz3os1snD
 pqCx5JhKYi80N4c6b9aV9Kbtm5m9fbLg240tDTYylfFN9WI8HLMgMl61P7EzXtxroT+UjttDQgB
 EBHf5kQhkwK/pUfesAhpa/QLCMZxFMNrXTzOeSefQMzJo/sdcaOe8sVXxyg4YWKx/o4R4G+o2rG
 qrl2VPywvaT4lwc07myfG9py6Eqx93D+dSupGDyJ1JyeXnP1RvAelnIpaYE1hM8R0M/c3GH1LsG
 Oz5o5h+HGJAKxj3HZ43gFD+BmvhhfGqwp7844hNOsFWzBriLTCX77iYhmeVzOv/MUCakLK9TEjr
 30DCKfYAE0xbVaMXXVQ==
X-Proofpoint-ORIG-GUID: 77aOkYODsI3h3wLNHmlVSu9BVpYnvlOd
X-Authority-Analysis: v=2.4 cv=dc6wG3Xe c=1 sm=1 tr=0 ts=6a0df037 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=yhHvprOGXo8dKriKWMQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 77aOkYODsI3h3wLNHmlVSu9BVpYnvlOd
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[infradead.org,kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-21742-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D1CF0594549
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/20/26 9:48 AM, Darrick J. Wong wrote:
> On Wed, May 20, 2026 at 08:09:29AM -0700, Dai Ngo wrote:
>> On 5/20/26 1:24 AM, Christoph Hellwig wrote:
>>> [adding Sergey, who wrote the code to allow multiple mappings]
>>>
>>> On Tue, May 19, 2026 at 07:59:49AM -0700, Darrick J. Wong wrote:
>>>> 1) xfs_fs_map_blocks only takes i_rwsem and XFS_ILOCK; it doesn't take
>>>> the mmap invalidation lock.  Does that mean that pagefaults could wander
>>>> in and mess with the layout?
>>> Looks like it.
>> I already described the scenario in which the file mapping can change
>> between successive calls from nfsd—triggered by a single LAYOUTGET
>> request—to xfs_fs_map_blocks().
>>
>> I also don't see how page faults are relevant in the context of pNFS
>> layouts. The server is not servicing actual data accesses through page
>> faults when constructing a LAYOUTGET response
> Some other process on the nfs server mmaps the file and generates
> faults.

This would cause a layout conflict and this process would be delayed
until the nfs server finishes recalling the layout from the first
client.

>
>>>> 2) Now that NFS apparently can serve up multiple mappings at once,
>>>> should ->map_blocks pass in an array element count so that we can do
>>>> multiple iomaps in a single lock cycle?
>>> I guess we need to do that, or revert the code to provide multiple maps
>>> for now.
>> I think we should address the immediate problem first by replacing XFS_BMAPI_ENTIRE
>> with 0, and handle support for returning multiple map entries from a single
>> call to xfs_fs_map_blocks() in follow-up patches. That work is more involved,
>> as it requires coordinated changes in both the nfsd and XFS code.
> Agreed.
>
>>>> 3) Do the reflink and realtime inode checks need to be re-assessed after
>>>> grabbing the ilock since they can change?
>>> Yes.
>> I can move the check for reflink and realtime inode inside the ilock in v2
>> of this patch series.
> Yeah, that probably needs to be made too. :)

Thanks! I'll include this change in v2.

-Dai

>
> --D
>
>> -Dai
>>
>>

