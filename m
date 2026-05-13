Return-Path: <linux-nfs+bounces-21604-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GH4rEW6fBGqbMAIAu9opvQ
	(envelope-from <linux-nfs+bounces-21604-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 17:57:34 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D446F5369D0
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 17:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 694153067DF9
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 15:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33DA49250D;
	Wed, 13 May 2026 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Oj/ktMPX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iAf8JOiK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4775038C2D4;
	Wed, 13 May 2026 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778687448; cv=fail; b=krpgmZQcu2F8EA+SzNk9aIaDSunCu8D8guM6SZypiQvmLN1x8rF7V1iXEWbvv+4LAgBkZ+ka3Hfp8uyOvKiZ8aVIrunzw7cgo4v9LI8Le972g7S5sCNXQBOMd19Jkz8xkblZdch/7lkkz+IQUudVUALGkJ9CDui2cXmJL23TAdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778687448; c=relaxed/simple;
	bh=LHUPNEF/PYKt/+TFWLdy9cVzYlrQ94bEZGA/Xm8gryY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uJf+66nTYZij2NCWVxXJUVJRL5l5XSgpzrF02vIJaC82CpHlWXLdHa5cTLsZTuG2DdH4JqOb9ED2Ym5ncu0eb6xClI3QRY2uR6gNbsWpdQXxa6czGj+lxQhhJHuPsBcl1szLxSHP3EHiAmdC804T5/uVR+rl7xpwGYC/j+C1VMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Oj/ktMPX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iAf8JOiK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D7MtwI2703991;
	Wed, 13 May 2026 15:50:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qwHVos15Biktbl3HGAsw8xOlUN9chyqKvUfXlJCld+U=; b=
	Oj/ktMPX0TYNA/0LlEIy7r00EFnp+0X7YuTaRZ3nosT3VYAomlNUQJpBF0M3lgs/
	JcEEo7u17OSQIORVG+0LtVvx7xTahi45C1YBVNWuq24LIIdFpQdHj+anJcYm1nnc
	Bb4YOJzwuxL9AXCH+XXZcrksnnSoXKJlDOVSs4rN8EJwKtKBd7Khhm1YUOl6NFy/
	hI/lghEJdya6UebH7UuQB9TGLs3+YQ5VePKNfvnkbJvjCCJviVuJZztuySujExnV
	jhoYhQB8Ai8H/JS61UzcnaIhCazfp68awVDnWNzYzQlQFdUrpq2jULOwIil0prMC
	D7hMl31dBI6Wl0Z7/z9/Dw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e4c979hvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 May 2026 15:50:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64DFnvEh002876;
	Wed, 13 May 2026 15:50:34 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010051.outbound.protection.outlook.com [52.101.61.51])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4e3neb46yr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 May 2026 15:50:34 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wo7IymnS/X5sXnZul+tnYAG9Yls+mLSgyaOjJ/6xT1iR3K5S9afEXGqbEkdC6WQsxlDy75lMACGh4zBGRYCj7ItkXdukD0B/wV5jjC238t/6RujCNrBDMI4w6zxrmCBrCBNfIz5rzi2w7gXUPamIs5EmTczbSIq+VPjKA0jNrQcYOfE7shpICcocfBpsgcOS1/HX6m9rIlmAjmmvzZwpr+1k3jM/Qt6zGC0EPH9hzLDVdMYfpeH/zmaiCTtD/b5dhaF5WNHLNtDZKDToRDNQZJ2PDfCiP+Crcg6sixsjrPfB3acMBYdYWsjGLjD3jd8cC7RGzMl5E8C6KLirkYuSqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwHVos15Biktbl3HGAsw8xOlUN9chyqKvUfXlJCld+U=;
 b=SlJysTw4hJ0jSFlpXEEoA4JrJzS+ARuRkL+eJh1AwLsbwLUmtW0s3HZKeXcTPSJiSzI0+ZSAkZO8IiThGZEjaBAaLFRybZL9JPlN7YIVf8QAEOSiIVu56Fdd2NY3KnQIlNR9OYZAt+85byW6m+zKH3je0yXK4K6GSWVkPNEtsOUh3PeKrYoG8HoLIKFVPzLdgijb/5+1GYj1atnuNL4NoHA8ry2g3vWZd4rKFRTkqecoZ3EgvaxLwVoxFHFVK72vgxOq0JwLwvbmQnLDL6+qRGTaXVH0xv3N0qM5b3UYICfd1TUjtMu3p/Yn1QSsyyqzJbXHz+E/ytavznTaQVD82w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwHVos15Biktbl3HGAsw8xOlUN9chyqKvUfXlJCld+U=;
 b=iAf8JOiKhLOSr5CZftc78dWyrK0lvWvmSPAfQFEmKaouDgaADQb8RI6UCkqmVVdZoY+CNZUXPJ7zz1XslCtF1/FTdBCl90QyrGbYB4vww0vCJE/LLtqQhA8vkJd2iQd4OkFYQNzq6HEsIBRb15G1fcoWhLR1rn/dooi+6gxgfQo=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by CH4PR10MB8172.namprd10.prod.outlook.com (2603:10b6:610:239::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 15:50:31 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 15:50:31 +0000
Message-ID: <961eb355-2f52-47a0-9399-e050a4e535a2@oracle.com>
Date: Wed, 13 May 2026 08:50:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] xfs: fix overlapping extents returned for pNFS
 LAYOUTGET
To: Christoph Hellwig <hch@infradead.org>
Cc: cem@kernel.org, linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20260512172238.2495085-1-dai.ngo@oracle.com>
 <agQhzg-0aeISwOGW@infradead.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <agQhzg-0aeISwOGW@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0007.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::20) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|CH4PR10MB8172:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a280f31-2aa1-4d61-4bd8-08deb1075c68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|4143699002|3023799003|56012099003;
X-Microsoft-Antispam-Message-Info:
	R3VCc9W8PvvNtGaCAgSJhS21qXxVJXPXK/wewNywQlSSE20R9LB4qm6cwtSz85XiLozJ5kk+Q2VEXgzNhiEjx8oZYOPuFeCkMQDHQN5hI9Bkp6M3CCND0VezsljP9cUEfRo4b+6GNE9BmMywpiJDCC9kOWUa/861My12TpiLUSbAUOu1LysjCW9LHmRAeDIJWaqIrNB6hm2uGaJUuiEqxgsRfXi0iQPS+O41hwmvg8+AvZAaodIMVdZN/NULhbil3OuOQn1AGmL1ElaTb5blhhJau0DXqQLyGHAF8BzNSpSwX9TSsXtCtRqjv3WKtYCy+NQCTENqDeKCYPxW5fNtaJQhy/IhRhTrE96lcSGVeh3lsC0yQiQ0Iy+aOiSTaE5nEoRP1JC7ctbBJQQ2SE4vAk5DTc6V/0fOLtVAl1cN8usrknYLjzSHmIlz69z0IKJfutwRfDL8n3Qu/HuOJ3fsTjdxF/TKQbMpv8FwD/2xZtpwanBWAXxMiewROrIc0uFBtll8PWHOZ6RcVi9xDnQxLL0sB8i9WQXd6An89KdG2b9lQKWeFpoLaLwPAXfCIms5viGyd9w4TG2NqiR6w6pu+YNt5+ReiWhUckt8lIykqzZ7DRdqGoL99vvbmaJJgsRUNhD6kyxB3/QKzarf3H/qhFnt5MHHZjAZSxzUyHl5t9KRJ9Wyg+guR50e6W5wFv+u
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(4143699002)(3023799003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlhBTDZ2RXNkWkhzWS81UjBDYng4eUE0K1UwWWhabzJIMlZpVEs3VW8rdEoz?=
 =?utf-8?B?ZWs3dXY0RWoyN1ZhWGtuS3FnZyswbElpR1pGQjZ2aWdWZndDUzdpNUwyYUxt?=
 =?utf-8?B?WHhEcmlzN1pKTkVyRlh1WHhyYkpWdXd4VytycW5XcWxucjhPZU5mYWUyNzkv?=
 =?utf-8?B?emV6S3pXYTZhSUtYN1I2VnhOQVNLY1IxUFlyZlE0c2tOY3ZkbnFDcjN0emRT?=
 =?utf-8?B?eVc2L21Cd1BpMGx3RVhZTiswaHVtRlpuR1Vtd29qWHFvWVl3aGJNNk5kUWJU?=
 =?utf-8?B?alRjMk5xZFpYZEFkai9tQmhiQTdIV2dPYmtKNysxSTIzb2ZxVGVmRlpjcHpF?=
 =?utf-8?B?K3Bvck9sUFpTajJZQ0M5d1pjN2ptbU5xMmR4T0xmcys5eUhBZzNad2daZk1j?=
 =?utf-8?B?R24xenhQZFVBL1lNaUt1WVIzOVlBeDlvdDRORERCOXYvRzlwMlc4YUFYcXZP?=
 =?utf-8?B?bEJmQTZxMzFvS2s5ZkNqV1hIVlBSOUg3ZFNyRUZnZ3R6M3B1Ym45amxNdWVX?=
 =?utf-8?B?VGlia2E5YkdJNWFid0VyYnNScHpKci91YVRoK2MwNW1hQ0o0TzVzRklZRGdJ?=
 =?utf-8?B?Y0xtbEdkbWtsaFNaQzlhcTNGeUVMczJqLzRMU0N3eEpObTFvMlJVZ1A0bmNz?=
 =?utf-8?B?ejhxVHNqZEd6L0ZheUw0OGxHeFBCWHQ0ZC9lNkEybWRrby9GdkxhdkdLazBm?=
 =?utf-8?B?NzBPaVpYSVV4VWtnNSsvNFptd3hsbVl4NUFreTNBeFVGZXRTRGFMejMrbFl2?=
 =?utf-8?B?bGUxQlN2Vy8yYUdOQXRid21JVU1uQlpNVmZYTG5qak5lRUgrVWFTNUcxeUt1?=
 =?utf-8?B?bVpVR3NNbGlpUjZoajNMZS9wOWhNaUtyNngxNWFPMkVURUEweEswMTNRZ0F6?=
 =?utf-8?B?eDgwcTlLS1Y1RStDZ2tpODZHdUw0b1FMVHhYaXRVd0ZSVllKTWI2OTRZWEVp?=
 =?utf-8?B?cEZyUHd0VGFLSFJtN3BqT0JqN2N6OFNVSmpsWFRXanFrdHhTZXk5MU9SRUZv?=
 =?utf-8?B?Y0ttL2lZWFl0ZVJxVi9YZTZyczJleFArL3JwbVE0Q1VkRFRUdjE1T3JTSk1J?=
 =?utf-8?B?UllJN1ZWenVyaE9mM1ZxY1BTbCtnWktKdjNod2hPblJFTXJqR0FjSjJJMHNh?=
 =?utf-8?B?RlEwVmgyR0h6WnI4Y09xTkJRNXdxazdOSDNpUVBJNEZDalppOWRkMXVHRjVR?=
 =?utf-8?B?endjbE1JZzhBSFVJTThEb1VTU0JRMkoycmlFY2Z3VFhCamYxYWVQajg2YzRY?=
 =?utf-8?B?UkRiMmhuVVVyNHRqTTZ5NThPR3BmRWFwOEh6ZStVTktxMVF5TkRzb2NXcmxK?=
 =?utf-8?B?c2lzWFZRN1RCSzBZSWswY0ZhcktMMHA1ckg2WHRMTFZPMjgzaWc3NFJ6Ykly?=
 =?utf-8?B?ZEg3VUo4b2kvYjNxOEFXYkVGUlJ0dEFHeFFQT2JrQUJDTEorUXNZcXVyVFpV?=
 =?utf-8?B?T25ZYnYyTFpUNHZtYjJKcVFCQlNEeElTd3REZHpMbnB6cmtVaWFVVUNjK081?=
 =?utf-8?B?RkNjL0p4M0htRVh1UkhkcGx6cERzaGYvYWtBRGVxVUNleGdjZ2NpWGp4N1Vr?=
 =?utf-8?B?cHp4N3M1Z3gzOUpGUzVNWnlUR3JXQWV2ZzhpS016UHBSVHlSWXhjcVAwSUl2?=
 =?utf-8?B?andPdmxBZGFYVytLS1BJNEtaQUFaTlJ0SUNqdXlRN3lkS1NQK29UNU43UU9y?=
 =?utf-8?B?b3RrUXNKNll0Z3JaSTFuQjVTdVlPWm9IQy9RTXdHWTlGMWNTVWRGeVRsb1NS?=
 =?utf-8?B?b0cxREhjbmpUTysrQys1RE9nRFhFV2RLNUxDKy9wSXRGWXZ0dlhrT0dIL0M4?=
 =?utf-8?B?YkhMdTlNdDZyZ3ovcjJweUZSTG1RUXJERUNxUmxyeU1zYWpjS2NteFVnYjY1?=
 =?utf-8?B?dGlTMjhtcHJsNFR1eEVqVEY4VXo3K3NvZ3VybmdIWjRlMVRkbU0vaVpVUi9j?=
 =?utf-8?B?M1M0RWhQNkFrVityYXg4REpQQUVQeFIvNDc4NWZPNGIvbFVnQ2JySEJYdHF3?=
 =?utf-8?B?VDBsNWNnMVRUVG1TeFh3SG40bkVIQW5NYUY3YWJHSmVWemMxSCtyZFo4akNE?=
 =?utf-8?B?eE93VXpJUGNrN05iZWFDeTNEZnhxc29BSno5eWprUXgzeWNOeXMyZndXUGJB?=
 =?utf-8?B?ZmxaekdBdVhvZlJuNW1teWdTdnlxajlqL1NKVC85clRERHQvWHJKMVlTVVVv?=
 =?utf-8?B?OVVOUDVJdU80UGR6VHpyQUlHOW5hcUF0eVlPWFQ0YXV6dE51Ri9sTVNNL1dH?=
 =?utf-8?B?QkJXakMxaG1OU2gyOW5DTldxYUg3V2VUQkpOSFprRzNiVVhXSlNrOU8zMnFa?=
 =?utf-8?B?b1FTR2wwVm9wUGxHeXBmSHhSMnd2YWZQc0s1Q01GZmIyTlF1ZktUUT09?=
X-Exchange-RoutingPolicyChecked:
	dbLkkR1DO/c6lvrFKtpku/iUN3bXM2ACpgk1sqa503rQk+czVOMyqp4wBN+uyp30KX/wi4loEAuEDsW++HZj++SXUfTEI29Ra7xzUSQsRBrG6QW0yk27VtmNDcxCF4FOVLj+YQ+MJs1BSbL27nOsNF+zlviOsvj+mofWG7zNEhna2cZQuEndxY8AJb3phukrlLS2Pc/CeTHcPra8MJ2PwnqGv2pcc6gZ/Qc7B5f8IHfubFvgAUg8rsLVLprgIShOy6/d1MCajtrmbTt7nbbC52bFRudIAnXokUeba6QyeF9/ZT86VcSc65295Nu7LBn280Q5sxpDenrv5iQSF1wu/A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	f84ycNkc1t20UNUG9Lkjo2GpQ2q6ruyenmCxFZAdYZB4f/owXu60DNG01cHUFnIWV2rKiPqPtNfZbPGdCAYcpf5ZSBH2uK5Z7YaFyF7m+RPh+untsSh3YKnitF5fb0goeidQM9leHvgX2BGLQcVSqBeryDlOKTJEZiuDv6vPkU6P/32eHQ+ddd7CAECfD+t8+9YcTIfMEAW2x8zIbPb7EECscavVLo5xuZ9VHpeQffPDAS6iEU/gDDodfKZnLP31+88fdJkeX/HwDzvBHXW/CTTMKMnQyNJVrZURY6ohuSnQpM97ja7VhmDcSbbdSpZPYmkH4XUZnUboTQ4NN8jIV341Y+egAExBEs5MvBTQz3G8zyD28rOm7NKXUbmC2ddHBpcZQyHUo+NFfdsOlSYfrTcCs1+XiVUJtzxcGsKgIVCYWqjBynQJqWkYW2kQb62Rf0r7s9x2h1xVol9UGyT6z8q/UMKM1AZEOtgGcLXMuyb1YDFHVUv1CN1MI1+WuGc7E24HP/9AGGDqMSuw2y1RJH1j/A7/PN4GtQdZdfXmIaWRoeYUw4HE+o4jEvLegRdsjmvSjWMZtq48KeirrjKGuze3Ln2vmc6VJeZM98M7kFM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a280f31-2aa1-4d61-4bd8-08deb1075c68
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 15:50:30.8829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CZp950enNpbW7w0OZ9PSH0Fna1w3usxKRzvyQM9w6GvRKd4mlQBM2izjBn2qv+sUDtukbuKFM4DCdPoalvYdlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8172
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0
 phishscore=0 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605050000 definitions=main-2605130162
X-Proofpoint-GUID: enbyEyj6ZVQMIhiQqta-bSEkIsKuT7vA
X-Proofpoint-ORIG-GUID: enbyEyj6ZVQMIhiQqta-bSEkIsKuT7vA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE2MSBTYWx0ZWRfX4NimxUcbhqjN
 XwN2ESzeBWRx6xLta5JzYm92puNZve0F3Tk7vjZ/mqPPmQHGygE0ses0qqy/H9xa9szI6GiUhb6
 61wvA5rYFlpqFlFdwSMXsb05qiG5CBa91pD8pSsNT6ANjxoU1MS+7HzVq4n3in2TowK1T8nEnBB
 xEPAL1La6dQu8r18+ikxNdDBKOceuaEMei99aoUeeofUxOWN71FSTBvyuT+Z/eURyqk8yuoagkY
 jBwUZTpR9VOObPVsxWKRR6gR6V6/vHHcIvaP+oWyRnsjin/Mmv6R0qFBFwjmmCnyJ5Z0xKmzNZ1
 79yFPso1vJvW86mgdZP0C5GQTKsTdC5VyRI5j7a8Zqn9YMN5IR7seJXKZRN1/SrP3GOycbIJYIv
 1rCNKTPuImjUg38oPfqYSk5YvbB/vvjyxx6X3qm4OIbwxwuwCwr5NOIDgLC5LSBfGSnJBbntvIw
 /kFBsT73Sk+PX4NSodw==
X-Authority-Analysis: v=2.4 cv=Cq2PtH4D c=1 sm=1 tr=0 ts=6a049dcb cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8
 a=sjWDhviwjifiD8CJZDUA:9 a=QEXdDO2ut3YA:10
X-Rspamd-Queue-Id: D446F5369D0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-21604-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:email,oracle.com:mid,oracle.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action


On 5/13/26 12:01 AM, Christoph Hellwig wrote:
> On Tue, May 12, 2026 at 10:21:53AM -0700, Dai Ngo wrote:
>> A single LAYOUTGET request from the client can cause the server to
>> issue multiple calls to xfs_fs_map_blocks() for different offsets
>> within the same extent. Because the use of XFS_BMAPI_ENTIRE flag,
>> these calls can produce overlapping mappings.
>>
>> As a result, the LAYOUTGET reply sent to the NFS client may contain
>> overlapping extents. This creates ambiguity in extent selection for a
>> given file range, which can lead to incorrect device selection,
>> inconsistent handling of datastate, and ultimately data corruption or
>> protocol violations on the client side.
> Please also add a check to the client that catches this and doesn't
> use the layout that has extents outside the requested range.  And maybe
> warn about it as well.

The returned extents cover exactly the range requested in the LAYOUTGET
op. However these extents are overlapping. For example, here is the
on-the-wire capture of the LAYOUTGET operation and reply showing the
overlapping extents:

     Network File System, Ops(3): SEQUENCE, PUTFH, LAYOUTGET
         [Program Version: 4]
         [V4 Procedure: COMPOUND (1)]
         Tag: <EMPTY>
         minorversion: 2
         Operations (count: 3): SEQUENCE, PUTFH, LAYOUTGET
             Opcode: SEQUENCE (53)
             Opcode: PUTFH (22)
             Opcode: LAYOUTGET (50)
                 layout available?: No
                 layout type: LAYOUT4_SCSI (5)
                 IO mode: IOMODE_RW (2)
                 offset: 122880
                 length: 65536
                 min length: 4096
                 StateID
                 maxcount: 4096
         [Main Opcode: LAYOUTGET (50)]
     
     Network File System, Ops(3): SEQUENCE PUTFH LAYOUTGET
         [Program Version: 4]
         [V4 Procedure: COMPOUND (1)]
         Status: NFS4_OK (0)
         Tag: <EMPTY>
         Operations (count: 3)
             Opcode: SEQUENCE (53)
             Opcode: PUTFH (22)
             Opcode: LAYOUTGET (50)
                 Status: NFS4_OK (0)
                 return on close?: Yes
                 StateID
                 Layout Segment (count: 1)
                     offset: 122880
                     length: 77824
                     IO mode: IOMODE_RW (2)
                     layout type: LAYOUT4_SCSI (5)
                     SCSI Extents (count: 2)
                         extent 0
                             device ID: 01000000000000000000000000000000
                             file offset: 122880
                             length: 53248
                             volume offset: 339460096
                             extent state: INVALID_DATA (2)
                         extent 1
                             device ID: 01000000000000000000000000000000
                             file offset: 122880
                             length: 77824
                             volume offset: 339460096
                             extent state: INVALID_DATA (2)
         [Main Opcode: LAYOUTGET (50)]

-Dai

>
>> Also drop the check for (!error) since it was checked after call to
>> xfs_bmapi_read().
>>
>> Fixes: cc6c40e09d7b1 ("NFSD/blocklayout: Support multiple extents per LAYOUTGET").
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/xfs/xfs_pnfs.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> - This patch is based on top of the patch:
>>    xfs: fix use of uninitialized imap in xfs_fs_map_blocks error path
> The error changes should go into that patch, so please resend it with
> that fixes.  Maybe as a series together with this patch to keep them
> together.
>
>> @@ -172,6 +172,7 @@ xfs_fs_map_blocks(
>>   	offset_fsb = XFS_B_TO_FSBT(mp, offset);
>>   
>>   	lock_flags = xfs_ilock_data_map_shared(ip);
>> +	bmapi_flags = 0;	/* return map for requested range only */
> Just remove the variable and hard code the 0 in the xfs_bmapi_read call.
>

