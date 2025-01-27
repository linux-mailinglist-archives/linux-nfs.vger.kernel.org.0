Return-Path: <linux-nfs+bounces-9658-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BF8A1D686
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 14:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38D85164D84
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 13:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FCF1FECD2;
	Mon, 27 Jan 2025 13:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Osr/lefL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QI3D1RN2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D151FC7D8;
	Mon, 27 Jan 2025 13:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737984203; cv=fail; b=vCtUq1UWz1WBj8si86TQAdIk6nHT7gk9+WTAB2C65oQesiQeopSgjAb+DXscSZ6rJR1tipZFHcbEqLMBT5PWvMtb+r1Nb8OCa1M5dTGRpxZZM/1IQ71MW+NN+1znK+6Bs0J18+1CODFsk/SUWhon74vGS8FkOpNvJG02IwoPsH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737984203; c=relaxed/simple;
	bh=MKKnMNVaEmFmpT7qKUdimL47yQhEvdauRpYHqX1j9UY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B7bQ2ADvl0QwFA47YFFk2zPHAz2sZfBNQFgq/uNWtnWoh0UUfh8b1Kw1RrFdFYlY8mTPRustvD22XzOQPURwQqWvnpuq83C4RvfDJPxlTgYzmG6md1HcLLtDNH6WPUowESmf1cp7j0wSmYLEaQAWeNS/gHg1kyPlPvyHzM8Efg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Osr/lefL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QI3D1RN2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RCblYr029953;
	Mon, 27 Jan 2025 13:23:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=R4soHiLq+NHFLA/YRPyzs6igBkUHyeGTCQ73+7sXsH4=; b=
	Osr/lefLFkJ77iI+Ov9IQ3iN9kARohK4cbJBiAXasUwA9bVjsCqZcnuDyPsT2dSP
	zXJ36u/CX07mzolXEHHrGocExRJ1k8nCtaOwiqIvXiOmY6Orqtk+72fq9Z4HQ7C9
	uPpJa1eMpIsuI18PS8uer4CfIaIONdXuJ7UkYTY9TwvHKSDPHF72LFRe+0ETMUM1
	ugkRf7fjEszkKD+8zZaQu7z7GtDC+ToaE0dlL52u6yqnnlFOXsz1rVRcQVXBPM+N
	wcIWuvKbBdmN7stPFB7jz3zs1m+kOrJnqw/JAeT5JO0IzP1XjFHrRQYed9OGHT2V
	LmEoOVztDkmJhwCv5rFX4w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44eaa4r24n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jan 2025 13:23:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50RC8X24036385;
	Mon, 27 Jan 2025 13:23:02 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44cpd6x85b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jan 2025 13:23:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJIURZ6nEXp6xG+Qp/N0XSE4T+6igVkl5uAexZgecML7QvRukxkxEdp/oTWdMMhGNrPsjKLEMUWvvZOzzWoINoT74V103GvkqjBhlg3a0xrA7BQLST4fZFkKHXM008FEzpHqcfMCiMT2n9+J5xa09y2+AczJmlcT887txxlZqik8E1zMP8ztRHTKVbIdSqOT0sKUuJpzw6yQlKWp73M/PqcpallI+5es6iVAwbYLOgpg2mjqH0D4mI52PPdlvfV0A+6PawrXwIVCOZU4K9CJes0ZrIB6hcGkaA1cCBl9k7P0IIgI9vGMKBkN/QguZetSU8IBZOrr4cYAYD5civ4OHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4soHiLq+NHFLA/YRPyzs6igBkUHyeGTCQ73+7sXsH4=;
 b=XlEiFcspx4Alc0PfnfPqWTJO2ua473/ioYLEb7FzpuIbCKV0V/fiEw3o/I/nO/bMerASI4pB3OGD+wNoyAy/Td8VBBTNxLs/sEbVqUNYgeQa1CUJ6Ws17e8ikwTHiSwHJGa+5vWLEot4zSJ1ny/ZyJMFuHAGB2O7T+q1k5pLKxzHVfZim9ILPHcHWd4hlNGtYcycuhz7nVFDzIjA/4J/vor7dh9yCGmmOwU8X1t3tbr0QPI/yLR5H3Me4tzVJPO2P9U7cGAHiQQq7BcvBSHGTYMhvoog4sK13XCz8ho6kDfRm/M0jYkGGdWkJS1PRI4mit4Qo7dqe4y7u6Xhsoe3yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4soHiLq+NHFLA/YRPyzs6igBkUHyeGTCQ73+7sXsH4=;
 b=QI3D1RN2uX7YwyY6a7kyUHvRlTpKDZfgQAMIJdJAFefleT01DEDAMW9vzEkl1T+3GPppO6jWsO6BPRTZ7QilvNXk1hOuPIuiaMTwYUNuKgKV/pZaZN/+DyHdDIaMeW9NtN3NF+HH96SVJr1nzsDd20iX0qB85lvAzZWjnV5W9H8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4411.namprd10.prod.outlook.com (2603:10b6:806:116::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Mon, 27 Jan
 2025 13:23:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 13:23:00 +0000
Message-ID: <c70d155c-22e0-43f7-af23-241088317d94@oracle.com>
Date: Mon, 27 Jan 2025 08:22:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: validate the nfsd_serv pointer before calling
 svc_wake_up
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neilb@suse.de>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Salvatore Bonaccorso <carnil@debian.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <> <a3ca70c78e48e1a36d29741eb8913ce85e3f51a2.camel@kernel.org>
 <173793694589.22054.1830112177481945773@noble.neil.brown.name>
 <06379c169fb0e891dae9d444ef0a06ea57e9af38.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <06379c169fb0e891dae9d444ef0a06ea57e9af38.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR08CA0019.namprd08.prod.outlook.com
 (2603:10b6:610:33::24) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA2PR10MB4411:EE_
X-MS-Office365-Filtering-Correlation-Id: 4773f5e9-a3c6-4ff3-e8f5-08dd3ed5b863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUwxYXNqNzNHOW1GS1dZczN4SGJ2dUNUZTZhc24vOWMya3piRnBwanZXaEow?=
 =?utf-8?B?UHQ1a3ZER0ovUCt0Y3A2eVhnVXM5dStoN1lkQ2JpZkRPejRoTG5YVG9iK3Iv?=
 =?utf-8?B?SmNTWlg2VXE1dDI5eEVRUllibnhNbndOS0dTTjVxY2h5VURQQU9GM0FHVnFl?=
 =?utf-8?B?UGpDczM3R2xDZ3NCZEYrUmlia0dOdkhGbFhQZldad0UvWWVCNWx6QThWWDkw?=
 =?utf-8?B?Y25QeUNqSHBoNUFINVdRbGNRVld3ei9FRTdHVEY0UVBUcHBqYVdtYXp1Wnd1?=
 =?utf-8?B?NHZzUDRrMnpVdHg3VGFpN1RHMGhEUVlJdjdkczVGZFowYnJvbCtPb3NYdUcz?=
 =?utf-8?B?YURJSU9jZnN0ZUdxWUVhZ1hZYlNrSGZ0ZGFiWkdodytka3BvbGx6MHRQdlY2?=
 =?utf-8?B?UkJ0enBzL2Z2dUUxTU9kWFVCRm1Ia2ZtbW9iMkJJUU1LRzRFT21MeGhDYTVF?=
 =?utf-8?B?U0ZDK2RObk9yOTliUlZscE5Wd1pWdmJOK0Z3M0Nod2Y4bXo1R2hOdk9ubnl0?=
 =?utf-8?B?NzBDOG5aMlFGeEQ1dDNCVWhKR1crMW1ETFN3c2ZlWWVMV1dYOE1waGtzbVZB?=
 =?utf-8?B?MEQvMW1GR1hXeG9iM0FNTG1aY3dtbFdLQUl5MWZqU0gwa01xR2lnTkw4cEdQ?=
 =?utf-8?B?aDlKQ1ZneHI0VndOZHRyamdQOFE5VjVZOEFibEFMbXcvZ2FlMGRrVFBTOGJZ?=
 =?utf-8?B?OHkvUkxGZTMreTY3UDNPYjVkMnM3emFTZFgwS05WQ3hvcTBZem14aVM2NkYw?=
 =?utf-8?B?VTdmVFFsdlZsdVhOQjhXcHlVTmJnem5UODVKL2ltL0dLZE9LZnZDcG1oK0Zo?=
 =?utf-8?B?MkZHRU80RjF5YUNWUDFpS3JCRU82Z3R6T3RNSXd0V2d5QzdROHI4K3JwRll1?=
 =?utf-8?B?dHhrdkNUaU0yV21BbkYrNllHaldrQStCVGJSVnhXOWxIdTV5dWhYUWQvcEhz?=
 =?utf-8?B?cytXRW8wNWlxcVd4MGJBMklZNXM1VE9jVVJGeE5Ea0U2bUZFT05GUFhyMlFS?=
 =?utf-8?B?cUtjblI5cHRCQXZ3b2MrdFFzVkF3KzZycGkzWFRzdUZPSmF4UnB1VENGWEI5?=
 =?utf-8?B?YTNzT3VaeVpmc3k0R1dLZzNaTU9kclMwbW85ZnhUMkc5MlZrd09qSE16YkNI?=
 =?utf-8?B?dFh2Yy9hSXhaZFlIOWlBYlNISGc4YlBuVXhjYVRWaHA3WnlpMHdVcGxaaGM0?=
 =?utf-8?B?NkZtVUNqeEx2MG05YlQ4dGdNL29XNWFrek0vbEZRdXppQWtTNU5ZODl2TVdz?=
 =?utf-8?B?Y25uSlpZU3o4SFpYWmZydDEzQnZNT0ExUFZxZnpsbThxVmRsQ1hMZTh0cjJH?=
 =?utf-8?B?eEdlbWtvOEt1Q0pNTFlKNjVxNDBvc2VnNnBxM1ZIQVViV3NSNnRaL00wd0JI?=
 =?utf-8?B?OEllWlhhNHlNOWdrbVBlZFgybjNTSGtzNnZ6QytaL1hxMUdWU21WSmhaanUr?=
 =?utf-8?B?cTRzVkV4QmFqUGVhTG1rRFhGbjFwLzBiNC9TQm5Pc2ptellSOGozeW40ZUV3?=
 =?utf-8?B?VFNYZ2QxOTM2MlhXeGJKQjVJcitOT3Qzclk2TGNVYjZ0US9IRnppeTRKeGhN?=
 =?utf-8?B?eDNXUEkzWll6cndvNDRFV3Jsd0lXRGZWR3owT1FvcGlLS2xQUDQ3RUtiSXpj?=
 =?utf-8?B?VmZaeHZJNkR2YS9lSXNzVS9pYVlBZE5zRWRvMUI0bGYxakIzb0RaLzErb2dE?=
 =?utf-8?B?Wlc4K2lmQUlja3FmVUg2QWs1ZThRM2xuL24yREdBaG13N21uZTZidjdYTUEw?=
 =?utf-8?B?ZmlObmpHMzJvYTljdys3dVRkSU8xam9MR3JyOXBFemhHM0dUMkRmdWY2Si8r?=
 =?utf-8?B?aGZ2djNyZWJoaXVvTmNxWTFKY0RyWTh5RUJKZjMyZ2Jsd1NXSzJqeWNpdnZE?=
 =?utf-8?Q?uw81IEWIJ4Kj+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkJpWC8wMHkwUkpWeUM2TXVpTDJBdTBNSmlPdDZrbEc3ckNkekFEdmxVand2?=
 =?utf-8?B?enNtek5YKzJDNjJybmUybit5MjFZZFdKODhsVFc2RHhXV1dyWDZ4V2c1emRy?=
 =?utf-8?B?aVo0M05Nd1dYL05hdXhSNG8yN0lnM3NXaVBrTEdLRUpweEJtVEN1ZFdLL2FS?=
 =?utf-8?B?RnlOR1hFYk9pdWpTYTJtQkNYZ0wrUVZuV1JhVkE2N0crU2JQcUZZbXZRK0dl?=
 =?utf-8?B?RkpwNlZJVUpmWmVqVmdiSWJNNE9GZE83QlBiRVdGWitrazlZOE5OVzd3OUdE?=
 =?utf-8?B?TzkwWnIxRE9vUmFrRVJpN25aOWJ3L2VSRklVcE1wSUtFa1hpdHNHSWw1elpF?=
 =?utf-8?B?dHprMTBkVG1JMTB0WkpiT0N1WUZjRUlOcVQ4VDE3ZzZLL2Rxa0NsTlJ1VGFj?=
 =?utf-8?B?Ry9sTUZMRlpFYm1pWWhWVVVuZVozR0U4b1grQXRWQTQrVXBXTG54a2dYWG5V?=
 =?utf-8?B?LzE0Q3Z5ZWtQYk8rZVBCa05HazV3dmlGcGhSQXpWSDlhSlZCZlQ3TUZXMDlE?=
 =?utf-8?B?cTJrQnQyY0NRVVhOamc0TGs1TjdGbkdjM29ScTh5S3ZJQ2RRZHh6MlpvVTIw?=
 =?utf-8?B?cytEdWxFaEhGZ0FGa1lxbGd3cUZianU0dXB4czljMmJ5bkJIZXpMQlI3Zkgx?=
 =?utf-8?B?WFRadXFtMnZoK01oQWRzY2VIYTJScnErMElTM1Zpc0g1MWR0SGlVbmF2YWF1?=
 =?utf-8?B?d2c4Y1NBR2pUdmZDZmkyUk9Bcm80SXNONnVLWjVTT0xQRy93eFpkdURTa0tC?=
 =?utf-8?B?R2tHbHE5dUw5bG5SNHhpZUV2Q2JnQ05QQS9TZHNrM1BkR0hMenpDdytQZGVX?=
 =?utf-8?B?TDJUK29XRUVGYzlpUDR4dlNUdm93MlRMcVhzeFZmS3cwV3gyaklEcmF4cEti?=
 =?utf-8?B?MWJUbncxbnBKd3Y1dHBXMVYwUGdBWHFWUm1YMFZKMkJNYWNuMjlITHNuMm9G?=
 =?utf-8?B?ZTdvWEpiWHQ0UUYycU1kbVJaS2RTMTB3aUhZSjMwKzZkSTlnVGJ0U0o4TUsr?=
 =?utf-8?B?OGo2V0VCMnFlK1JIMTJKQlpjMXJtRFJacmhIa3dDRXA3WVdXV0dUSGNTbTBp?=
 =?utf-8?B?K2d5eXRWS3ZPWGMrSlltRHZ4d0JyZDVtcWtZVyt4NDZ5OG1FUUNZOVZpT3Rt?=
 =?utf-8?B?eGVZN2t3bllwMWZscVhhWXFzZnl2SDZoMUJxZm9FMXhZMGZsVkIwVElpN29z?=
 =?utf-8?B?Sk91N3VFdm9wb28zU29pUnB5UVNHcm50elBQUkxvQzk5U3gydkpLL3ByYWpP?=
 =?utf-8?B?a1JUc0V3TVNrMThKQldBZWZ5aXExWjNFa2M4YkU4MnJmZE9FeXJvZTZMeTRS?=
 =?utf-8?B?RmkyODJEelZOcXdoSklSM1RBbVR6NjEzT0ZsbG43YkhEeHk3S1IzUnY0NmQw?=
 =?utf-8?B?eFlMTGl6cHJPVGlLNXBFT1F4M2RMVms5TEhLaXZtR05YQlVBVzFLR1JIbnNC?=
 =?utf-8?B?cHlOYStIckFQSDVucXdiek9BRnBtZitEOHN0WkMxQmlQNGRjeGg2VEs5cU81?=
 =?utf-8?B?cE9LbzFhZXg1L0hyYW9Jci84NWxPR0RlRDF6dU1MUjZJN1ZhSHJIQk1aanov?=
 =?utf-8?B?YStsbVpuOWdVSk03OHI3a1JVT3BnOXlZaFVLMk5MK1R5ejFNdU9vS0lkM1k5?=
 =?utf-8?B?ZU0rT3pLbmZGNGxTOGZlNWdESldDbnhYUHI1YnZXUndDWkprNVUxbFhaVEFQ?=
 =?utf-8?B?ZlA3NGdRQjRlRjBqMElDNHIzbnNJTnIzZVdXdDdOM0JEZkZ6eUp5WW9jcEM1?=
 =?utf-8?B?TkZYUjhjZ1NMc3QxZVAvZ0R5cTBhS1g0OGxWNDZuT2NQbGw4Mmo0SmIyQUJm?=
 =?utf-8?B?a1BnbTFQMmJidGg5elBON1JoLzF1anpsL1ZSajdUb1JOZlhPdjJZNmhWOWFl?=
 =?utf-8?B?dHJBZVAxandjakhJck1maFBkd2VtV21jdjJhK2w0eGpaTEtDdnM3ckZ4clFH?=
 =?utf-8?B?TjliUGFDbnRWNTYvbmRwOS9RMlBDN1E0Z2F3dWxPa2RqS2tPOU0zYytsNVRj?=
 =?utf-8?B?MlpYNFhYaEtKdGJLcCtTN1hsdDBSL2l4OE5zZm9BQ3hxMWRWbXhXVmRpcGF2?=
 =?utf-8?B?c1FLRytKaktseTM1ekdYdTJiQ2JNVENTZEJBdTdXdHZ0REZYQWJQdVFSMkk5?=
 =?utf-8?Q?pGcKtfi/cI4kTOyL4Baz1tGvz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	69DjYLG1eT7CD1Jk6UT/1YR5nFrSpnFkXgUz7buCfqiCpTKF0RxflwQ6SrWP93TbBCBrw2qwwlE65gnwWaOfHNZOVi4nBPeDLr8s00GwMIfMLxpWlUbV6hj4unFqv72yx27ZJn8RbzPf5vaafCm6D38nxhdOvkaK6OW5dymApbgJbAkMbqVzhx7fVEDWrr03OvbuCuAmVeoiRVCHwbyrkLSfB/OSu6veDCEOBPdszX92oDQR/zFGT3+WLGQA3iMgJ6miF4iB/64hnTYDeoVW3jIU7bdnkO3UH8pUNhqgPPmLE4vrEJyviS02BrmP38KwlBTeOXj5RjDqqjO0oVKXv9eMoPFV9OEQkr0rXTb8nJhJ0HGu9QRlg1rS2Lx3APTC20GkO3k2qa2gq3G9SNH5c8q8hWDMcsQjrh1CoDAIAtzN9syTpprOqBQYt5CGLIvoNej/tr27Ed1LHQm6vWBcw/e4fDsUaDyrvhP5aBKexkyfjY4hF6+iZcufXpxpw7KRuXBLw1CLOciJwDEP+Go4rGPwRqfUP5dMST6oXYybFXjkklDWoyFTlEnR2oh+BTeOqwh0fyvZ0avjvO//T1JRHrjszihqzVjWU8nNVH5tbz8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4773f5e9-a3c6-4ff3-e8f5-08dd3ed5b863
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 13:23:00.0416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GzWRXSJVb5QSS6p/mxkLzKrrqiTjJLGT0N5ioir5cbPPu0uRh/wsH5lUL/nExDecOtEFwb0KukOM0hhWvV6nSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4411
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_05,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501270107
X-Proofpoint-GUID: YF2110LzvmzG-WkvsJnMTH_upRl--VZw
X-Proofpoint-ORIG-GUID: YF2110LzvmzG-WkvsJnMTH_upRl--VZw

On 1/27/25 8:07 AM, Jeff Layton wrote:
> On Mon, 2025-01-27 at 11:15 +1100, NeilBrown wrote:
>> On Mon, 27 Jan 2025, Jeff Layton wrote:
>>> On Mon, 2025-01-27 at 08:53 +1100, NeilBrown wrote:
>>>> On Sun, 26 Jan 2025, Jeff Layton wrote:
>>>>> On Sun, 2025-01-26 at 13:39 +1100, NeilBrown wrote:
>>>>>> On Sun, 26 Jan 2025, Jeff Layton wrote:
>>>>>>> nfsd_file_dispose_list_delayed can be called from the filecache
>>>>>>> laundrette, which is shut down after the nfsd threads are shut down and
>>>>>>> the nfsd_serv pointer is cleared. If nn->nfsd_serv is NULL then there
>>>>>>> are no threads to wake.
>>>>>>>
>>>>>>> Ensure that the nn->nfsd_serv pointer is non-NULL before calling
>>>>>>> svc_wake_up in nfsd_file_dispose_list_delayed. This is safe since the
>>>>>>> svc_serv is not freed until after the filecache laundrette is cancelled.
>>>>>>>
>>>>>>> Fixes: ffb402596147 ("nfsd: Don't leave work of closing files to a work queue")
>>>>>>> Reported-by: Salvatore Bonaccorso <carnil@debian.org>
>>>>>>> Closes: https://lore.kernel.org/linux-nfs/7d9f2a8aede4f7ca9935a47e1d405643220d7946.camel@kernel.org/
>>>>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>>>>> ---
>>>>>>> This is only lightly tested, but I think it will fix the bug that
>>>>>>> Salvatore reported.
>>>>>>> ---
>>>>>>>   fs/nfsd/filecache.c | 11 ++++++++++-
>>>>>>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>>>>>>> index e91c164b5ea21507659904690533a19ca43b1b64..fb2a4469b7a3c077de2dd750f43239b4af6d37b0 100644
>>>>>>> --- a/fs/nfsd/filecache.c
>>>>>>> +++ b/fs/nfsd/filecache.c
>>>>>>> @@ -445,11 +445,20 @@ nfsd_file_dispose_list_delayed(struct list_head *dispose)
>>>>>>>   						struct nfsd_file, nf_gc);
>>>>>>>   		struct nfsd_net *nn = net_generic(nf->nf_net, nfsd_net_id);
>>>>>>>   		struct nfsd_fcache_disposal *l = nn->fcache_disposal;
>>>>>>> +		struct svc_serv *serv;
>>>>>>>   
>>>>>>>   		spin_lock(&l->lock);
>>>>>>>   		list_move_tail(&nf->nf_gc, &l->freeme);
>>>>>>>   		spin_unlock(&l->lock);
>>>>>>> -		svc_wake_up(nn->nfsd_serv);
>>>>>>> +
>>>>>>> +		/*
>>>>>>> +		 * The filecache laundrette is shut down after the
>>>>>>> +		 * nn->nfsd_serv pointer is cleared, but before the
>>>>>>> +		 * svc_serv is freed.
>>>>>>> +		 */
>>>>>>> +		serv = nn->nfsd_serv;
>>>>>>
>>>>>> I wonder if this should be READ_ONCE() to tell the compiler that we
>>>>>> could race with clearing nn->nfsd_serv.  Would the comment still be
>>>>>> needed?
>>>>>>
>>>>>
>>>>> I think we need a comment at least. The linkage between the laundrette
>>>>> and the nfsd_serv being set to NULL is very subtle. A READ_ONCE()
>>>>> doesn't convey that well, and is unnecessary here.
>>>>
>>>> Why do you say "is unnecessary here" ?
>>>> If the code were
>>>>     if (nn->nfsd_serv)
>>>>              svc_wake_up(nn->nfsd_serv);
>>>> that would be wrong as nn->nfds_serv could be set to NULL between the
>>>> two.
>>>> And the C compile is allowed to load the value twice because the C memory
>>>> model declares that would have the same effect.
>>>> While I doubt it would actually change how the code is compiled, I think
>>>> we should have READ_ONCE() here (and I've been wrong before about what
>>>> the compiler will actually do).
>>>>
>>>>
>>>
>>> It's unnecessary because the outcome of either case is acceptable.
>>>
>>> When racing with shutdown, either it's NULL and the laundrette won't
>>> call svc_wake_up(), or it's non-NULL and it will. In the non-NULL case,
>>> the call to svc_wake_up() will be a no-op because the threads are shut
>>> down.
>>>
>>> The vastly common case in this code is that this pointer will be non-
>>> NULL, because the server is running (i.e. not racing with shutdown). I
>>> don't see the need in making all of those accesses volatile.
>>
>> One of us is confused.  I hope it isn't me.
>>
> 
> It's probably me. I think you have a much better understanding of
> compiler design than I do. Still...
> 
>> The hypothetical problem I see is that the C compiler could generate
>> code to load the value "nn->nfsd_serv" twice.  The first time it is not
>> NULL, the second time it is NULL.
>> The first is used for the test, the second is passed to svc_wake_up().
>>
>> Unlikely though this is, it is possible and READ_ONCE() is designed
>> precisely to prevent this.
>> To quote from include/asm-generic/rwonce.h it will
>>   "Prevent the compiler from merging or refetching reads"
>>
>> A "volatile" access does not add any cost (in this case).  What it does
>> is break any aliasing that the compile might have deduced.
>> Even if the compiler thinks it has "nn->nfsd_serv" in a register, it
>> won't think it has the result of READ_ONCE(nn->nfsd_serv) in that register.
>> And if it needs the result of a previous READ_ONCE(nn->nfsd_serv) it
>> won't decide that it can just read nn->nfsd_serv again.  It MUST keep
>> the result of READ_ONCE(nn->nfsd_serv) somewhere until it is not needed
>> any more.
> 
> I'm mainly just considering the resulting pointer. There are two
> possible outcomes to the fetch of nn->nfsd_serv. Either it's a valid
> pointer that points to the svc_serv, or it's NULL. The resulting code
> can handle either case, so it doesn't seem like adding READ_ONCE() will
> create any material difference here.
> 
> Maybe I should ask it this way: What bad outcome could result if we
> don't add READ_ONCE() here?

Neil just described it. The compiler would generate two load operations,
one for the test and one for the function call argument. The first load
can retrieve a non-NULL address, and the second a NULL address.

I agree a READ_ONCE() is necessary.


-- 
Chuck Lever

