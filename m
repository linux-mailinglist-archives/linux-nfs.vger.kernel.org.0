Return-Path: <linux-nfs+bounces-16566-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0508C70483
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 18:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 2F92E2A061
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 17:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E213309DB1;
	Wed, 19 Nov 2025 16:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hxhYu3sW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DuZh8owJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785292FF660
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 16:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763571340; cv=fail; b=XMIOStRGEMUdTX9T7foMVv2CRT3jsNJR30xQrljMtDtj+vv7Rhd/JwUMFDbxNbFVP2P+PhsbZJku42XZia3r8RtyR2IhLmOY64fMNqMEmq4hPUPaqUIaIkdrDP2B+gMdx59YddVVqKt+tolb6+hLx7OWV14hfBg2hAHbdCeQomQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763571340; c=relaxed/simple;
	bh=Dwx+p4al2vu1i2hsz/C4blP5o3vkvXdWn+54lCNyAcM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mxa779U1vjeOGgdg5ziWcfCbX7BAwgbZ52Bl6NIMn8OAZSJIVdSxGAq5Izh0lTrEKUPl0J52Br8pDF7Tg4eVFmaM7kpJ4QsA1N61laoI3urQuV6m698PF/rlk2Ri2+593gY5llbZYskqoUWO/5QhYTQsmNpKTrEaL1dwUmeLzvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hxhYu3sW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DuZh8owJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJEfrL3024503;
	Wed, 19 Nov 2025 16:55:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=+Yh3YdBhtH6It3XbX5BF9EwotAwtbUhE4das7WCN3jw=; b=
	hxhYu3sWkPQgPeGVWkEbAQgJIuh8SQnLWkpw5lNhJL6+hoIMYrTEhZUFADnrYv8a
	ZJB0IyQY24L5ERP2rCmtnTAgUQ9vXL7P8Yy0B9dLef6oA1IzcxVt0juskD+lCzpL
	Bh1C6JUVb90h62w8BStsoZKZPiY7JgXpQHhJtf9oCWYtdur1zK9Y0DdV/I73h040
	gmNN07iwuN6me85rAQilx+Mji071Rm9MbrO7gMnyouvN3FIMhygXDQpStGwMaWFQ
	b9gb3h4j11qdmwznV3YYC06hm1lxR9AL2x0iz2BzVLT11YDRXnbzOABwTxhFLOTf
	8GmIqkJrOzTgpYmaOzovtw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbbfmpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 16:55:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJGGMBG009651;
	Wed, 19 Nov 2025 16:55:16 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011029.outbound.protection.outlook.com [40.107.208.29])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyewndd-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 16:55:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r9dSjlkWKxfdvLwax73i3fe167aLVGFMHrs9o3fLAiZIPTkfnjSQQW+kN4tZLNRU/QffHlhuVe9THXSEo+GFBLl19JzhViIvcv01ZaZBtzNgJNkm2iudVHBPXfzqTuq5lq1s0N3iI3KP8TLhWm3j1qPtuoEScy6jxwB38y6VQ80gJb5taJ4/KLSn6/RF0yQNQEB2c2EetIPpA6Hp1ljwS0hUNpACABNKdLdpiqkl58GpzmcU+FzF7tVbX5sI+9GakZrnmYa6K0U88x5E7XiwC47vPWO0qBoJct62H2BSN+Ee87fqCx98VYOoOrr99GVRzg4oF3kmBkpbjUfzv9hUjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Yh3YdBhtH6It3XbX5BF9EwotAwtbUhE4das7WCN3jw=;
 b=r7pDxCxwbqZbfgZWEjFZ1S75/lbIU2Mcl3rKR2HLpQBcjEN2i41nCfD80OX8A47+lHN7jskmujzJhdtRNvu4jZS8oTkeavIIfKDK3VKxSAAgazLK05+sXDJAeCd716eVRbTrrWDgqjWlGImFGpbqraydjBneWve8OCvvzE/AcHD9Fz9maLSenst/XJqRxLHrREfCJg/wKaNeOJUwegtueHSVkQlrg1GgU6jn2To48SEhKx71/YuxSeE0MdZJChrSIFG87MBzaICc1tW/ByB6L7JA6nSi9v5tjjBKO3DaziCEjmy06mtpAT7jZ9RI4WC+vVM1Bp60/mUW5KV8pCH2lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Yh3YdBhtH6It3XbX5BF9EwotAwtbUhE4das7WCN3jw=;
 b=DuZh8owJRYWyybEzUZUUEKQTZvZHxY/QHvSAoBST4nMj6x9pLZsRyDl3WO7JKvSIAPLCC+3sQhvzCNxlQAk1b/6cOij2QMOyz7dIpUoCEH8FLwhA0fMw55peWGlovK5+AyM13JZ1tZzBy0sF7crcDoapQPuYIwqi++3/xFN6R10=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by SJ5PPFDE34AA4C5.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7d5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 16:55:12 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 16:55:12 +0000
Message-ID: <3097252a-8071-49ef-ad2d-1e9733540913@oracle.com>
Date: Wed, 19 Nov 2025 11:55:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/11] nfsd: simplify foreign-filehandle handling to
 better match RFC-7862
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <20251119033204.360415-1-neilb@ownmail.net>
 <20251119033204.360415-4-neilb@ownmail.net>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251119033204.360415-4-neilb@ownmail.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH3P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::7) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|SJ5PPFDE34AA4C5:EE_
X-MS-Office365-Filtering-Correlation-Id: 748b10a6-a1a0-4c67-d38a-08de278c6783
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SWhyTzdBNDdrWmJodGpGZkE4WWVveGJhSWNCelpFVXVqcnZxa2xVZlpJQ3Vx?=
 =?utf-8?B?SXVVbEFTTnpnU0NnL20rK1R5emQ2UGVjT2tVOHovTHlsalRYTms1aGx6d1RL?=
 =?utf-8?B?R2pJNjFmRlhxYng1emlpZTJGZzdUOEF3eFlPaFBoNFB0eUtmSm53TGlHcnhW?=
 =?utf-8?B?OVI3ckh6d2hiQ1pPaHVFTTdubit6bXJyamRBT1QrQnc4cmRpc3l2emRNMDAr?=
 =?utf-8?B?aXhOeURWVEsyVloyZUQrenZWTWx1bENVT1NaZlFSY2s2Y3FVOW1SWTAzYUVX?=
 =?utf-8?B?ZmM0dDQrVmkxcEJiamcrNDF6THY4MUYyY0d3bkdCTXpucmpZUk9aNTNaVGRL?=
 =?utf-8?B?RFErOWI3aDJXbllta0dseVVqOENUS2NJTWpCUmVNU3lIWmxvbGpLYlNqZnVW?=
 =?utf-8?B?YzlZWDdNc24vUVpjTmRGd01rbzFkcml3YWMvSGRySEdZZkxYK0pYa2JjQW5z?=
 =?utf-8?B?MmdZQXNHdWtQNzdNNjUzZzVjcklKQ0FhbXBCZGp3TEhHc3NMZmdYdXVzTlZt?=
 =?utf-8?B?Z2FGMmhnM3NicFZ5UnMybk5IK1loK1lrakJNcXlrSWhrN3NOMGYwcDd6aHN5?=
 =?utf-8?B?YmxhUmk0UnJBSG1RN0tGWXBQQnhlWkZTQm8zYXFqYTlWZ2ViNlZjS0RRT3dY?=
 =?utf-8?B?V0ZFMDlOeDVTK1cyTi9aSXR2SlZWLzlQU3Ayc2RNUFRsYlZERXUrR0E4eUNv?=
 =?utf-8?B?QjlnTEViYjVFdjBPeGJxeXZKWW1PMklmMHAvY0g5a1QwY2ZxWkFiNVZhR1py?=
 =?utf-8?B?N1BERy9oQjFxUWNWejl5NlM3TUhWcTlWTkxMeDFRMmlPaDM5RE1ISWx0TzJY?=
 =?utf-8?B?T3ppWGptQW5Id3lncDVFT3ZnZGhkWFVaalg0YjJQeGdONWEwTXMvdjROVm4w?=
 =?utf-8?B?cnhBSHdQOFpWbmlDenczZDdHd0V4clprYk5leUR3YVZ6UjJOZGZvUTV6OUJy?=
 =?utf-8?B?Z25GaEIzTDhSQ2JkQmVsRFV4YmR4VklCRG5qd29kU0pCelFyaXE1cTBkNi9w?=
 =?utf-8?B?Zjh5cmdzNFFaaXZ4V1V3R3l5aDJNM0dhby9WVU40NkJjQlRka09rZHE2YVRP?=
 =?utf-8?B?K2Z5cWtTUWtJZEYxT3RMeHg5SSs3UHdZMHJkaEt5T0I4b3JCNEk4aTR5WVRK?=
 =?utf-8?B?bjVwUDJOTWMxOURHanJDVS9wbk13MUlybXJJeXNlYjRvR1ExUGdKZUp1TG1T?=
 =?utf-8?B?YUM2MGYwL1M3WUp3SlV1OW50SmptMTZDZUZPWGo0VU4xM0pNVWhjY09zMFhR?=
 =?utf-8?B?aXZIYktTNFMyT0ZibnB0MXRUZmUxT2xCWnE1OG8xUTdMVFRSVjhTUitHZDBt?=
 =?utf-8?B?MG9BbUlEWE9KcXdTYmlHNXNSRFBhUFVhVWNPaXV1TlVPVDZJMjRObFplakt1?=
 =?utf-8?B?NDdhRWZWbURySTY5cVEzYzA0b1dqNGY4NjFNTzhCM2xONHg3REpJdXJ4UkUx?=
 =?utf-8?B?NzcyRmNvWFloRGJPSUhIZEtkN1lNZjByV1N0Vm1XWVJtNHkxeElxUG1Xdjkr?=
 =?utf-8?B?Mi9kWjZvS2srd2lSekNBSEJmWlFNUS85S3RGd3RoM3FXMXFTbmlITDFONU9a?=
 =?utf-8?B?dXNXWlZSNHVhUGlNaDBUNmF0U2FaREpwS2JpZzZibjdmQnpIdzhLNmhxbGFK?=
 =?utf-8?B?bkVSU2JzM0U0KzR2ZXpLVnBTZ3ZIN0R0UWcrdTIxbnJ5ZGtKeUZnVC9iaHJN?=
 =?utf-8?B?ZExCM1ovRHJ3REVnZ3hudUxUNnRaeEQydUdUSVBJQ21xcUQ5cGF1SlJjWVc5?=
 =?utf-8?B?ZzFHSVJ3cXhpc3F1WHA3UHZZdFdoVzhKL0lGN2NjWlpjWDZmZjNIZFd3QWQ0?=
 =?utf-8?B?ekNvVkkyTEEvRFk3U3dSeDNyVFl3UlFTVlhRajAwWS91dTZiRmRmVVgyS1Ra?=
 =?utf-8?B?MEF5MzMzQXFRekVjNHlwQ3BUQldLY2cxcXhvaXo5ZXk0N0NEWHA0RUdKeUpH?=
 =?utf-8?Q?Q+uDBRn3YkxAduny9GsVk7Wjp6PlyFzf?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?R2lGSE93WGF3Ymc2VnNvOXptcWxxR0ZSYjRWUXlPS08zNThNVTVJNWNCTFBa?=
 =?utf-8?B?Y1RhcS9VeEFsNktwNHhLenduV0lkUlVtSlJFM2NPZDl0QzFmVng0M0Z4V1ZU?=
 =?utf-8?B?MVFZNlhEK3p4ZlJ4U1pLaUxGcm5GbUZhZko5Z21IWmlJOE41VGN5LzFhRWxU?=
 =?utf-8?B?Z1RJUmx6OXpYSFVJRGJ1em15TndGRm1JelZ0Vk9icXRDSUg0R2hNNnV1QWlw?=
 =?utf-8?B?YXl3UXcraGlweVlYMHBMZU9aWnVIdEZsMlFVbmUzczZiYlV5M28rYzBEMVJm?=
 =?utf-8?B?SDlmSDZZM3N5VmF6Qy90TG00OUVLcmxnc3c4NmNja3gwMGhqbEFQV2VDZ0FC?=
 =?utf-8?B?ZmpKK1R0Y3ZRNHRMMGJLbXpQcWNMR3hScStOME5oWkdxMU94SlY0WnQra1dQ?=
 =?utf-8?B?TFJESVdjdHBXd2xyb0NxT1AraHhmcXlEL0gweGpLQmZFRXc5bkZ5emtLSVZR?=
 =?utf-8?B?WG5BSWk5cURad0hPZnlyMUVEUXdZZDJuUWZGeCtST2pPMDNablh5UUIzakQr?=
 =?utf-8?B?R0svakhTWlpNNjFOK3RMQ2F0Q0NPdk1EMlEwRCs4em9Ub29sWUxpY3pMRTNn?=
 =?utf-8?B?aGszK0JNenhYdmdiUkYxQUY0YmZQVDE4WDd3TjZ0OS9iZWdibWZFU3haYWY1?=
 =?utf-8?B?SFVldXp2RSs5cnFETDg4SzNNRDZENHlJYzFoa3NsTXZkSzJ4RERManhSYmti?=
 =?utf-8?B?bkVSZXRyYlpndkV2VkFLdmg5VDJneGUwRUMxbkJUTW5IMk5Td2k1MVV5Z2ZS?=
 =?utf-8?B?eFNlY0xwTEdMRDhpRjNnU08yT0ZESzF2SXh5SmtPYkJhMDNXNTRuMzN3Tmk0?=
 =?utf-8?B?MVBCcE1uRXVEc25DNHFQYkpaN0d1VXZzNTNqR0d0N25XWGVTTVMxYjZVQXJ5?=
 =?utf-8?B?K1RHOXV6eGZYczlLY3I4V1c0eWIvVm1JT0swRmVCYzZVZ0dYTzZ6Z2dZWDRy?=
 =?utf-8?B?NzdaTkJmUnBPaFBVRXRRY0RCMFVqWGY2UXJmK3hYVUo3cTNZVk5GSWRBaDdW?=
 =?utf-8?B?QURwbjNwZEJGTkhUTmhIdldvTTNGUkF4SzBaeHBKVzRqS1dkNDBvTVdrM2dq?=
 =?utf-8?B?OUdFTmJESFdkMDFYNzQyNTdoc0lUZUdUZzdJZTUxWHJsR25ydzVpYkRodXJB?=
 =?utf-8?B?bUxuQVJneklSbHdiazQvK0ZCVXNxdmFhdFp1blhOcnJEV3B0TzkxUnVtMnVz?=
 =?utf-8?B?TDV4R21rbzcxYmxhek53YXo4SzFRUGtFNi9Pb0ZvclpuRXJYZVRWZWN3bGs5?=
 =?utf-8?B?T09OK3NYM1E2SXRFU2o5cVhIQXNLSVNmVXFGOFFWZkNBQ2p3TndxeXZtMnVV?=
 =?utf-8?B?SnFhN3o3bmduUnNzVjY3cUtoK29tcHRRTmNpazdlc3d6b0x3MEk0UWdoczJT?=
 =?utf-8?B?dzcwQXg4WlJwaTFpQk15YUx1SWJLa2FRY3VGTTVMWUR6UEhoK0p2SFZKeUJR?=
 =?utf-8?B?azQ4Unp0RWg1M3lubEU4bW1ESGNsSk5vYWdGVXpXS3ltdzFYNy9jclZCM0d0?=
 =?utf-8?B?ekZWeFBkSmMvWHVrVjZJOG4wenpmczM2VzJXYitqRW1kVVZ1aU81RVhnZ1RF?=
 =?utf-8?B?MW5lcTFhWU8xUTBCQTlEZk5iNmhaSDdrVjhUZjZSNDJkZWx0Zjg5LzhmeVpL?=
 =?utf-8?B?N1IxeG5CUnpJckJMZnJ3cTRaeUhrRUFPY3BRKzltZ1VxMzEvTkN4WDg2YkhL?=
 =?utf-8?B?ZDNsN1pSMGpodkE3V3FHOEV5S3VmNlNtN0JrelB5U0ZmaDhscWRRZlN6akZK?=
 =?utf-8?B?NHdJVFpZbEpHQVJKUnBnZWNranpkZ0F6WkZTVEF0TEs2ci9TVE81VUhZRnBQ?=
 =?utf-8?B?SlZuOTFWblF1MHJadWNTUllVM0hBZ1V3d1ZBNWE3dklBWW1xT3hybVc4cnZO?=
 =?utf-8?B?T3lHWnhmb3orK1pPZ0FzMkFQcUV1UVZaSUtFNCt6clBlQXZGOVMySTA1MXpC?=
 =?utf-8?B?NFoyc3FFTjhMZ2lQelhLVWhLSkhpT1FhQ3dsSTRMb1lCcHZ4UTRqMlZ2MUV4?=
 =?utf-8?B?ZVJhN2IwbHV0cE43aFE1QUdOTTFyUEtRS3pzQ3JZL1llSjRvb2FyVkVNajZY?=
 =?utf-8?B?eXZTTkNZUTkxdEtoNXhiK096anFYaW1XREpoSmdZSFFTY2xrUVJyZGMwYWNm?=
 =?utf-8?B?ditEenovVzU5NndnanNqQllhMHdFQ00yZW9mTmRZaFlFSTFIbC81UGlwTW9p?=
 =?utf-8?B?Mmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GImFfpNeYpDH5GAOisJeL/Wj1ELvwACKJQj/rT1/E9BNvdZpVejL9u/R3NL8J8rzCH7YrJYYmXBmC/fLovlz6NSBQzptpGeNzujVF/VUPcbuxVAQwa3aFUJPod2NICt1Of1b0mrVAU6gxXzPlDVJLHpGwktx3lqXLOLpGrF4jwcOpNy8sL4ZhmogIEaGTq2jNUEQy1at6hXEe6Fe99EZjeOCsjmHipqCC0MorUaaxM67+5cJuxv2SqZ2TGLgrz32b4JLENnKm+EAHQW+WxIin76QYXsUzzWlHM2RirGFT3H/iZ6v3RCtOq+w7biYhiWrI7c6jB1mHixl6D9Cv7iX/5mTx8LxieEREY2iKnnyVaa7kWJ5tStro40NmoS+kMuo6o6Up6QlC4Zp8eeebTJEzZWYgGJPvmzdGQsOB3r+BN+gvDL5oVl/O/cv/6+jYvVVujapm64x5ePEGilyEWKzjKgepwjPL376cC8XLyelBhFzrHhg1evznHUobjzRCREbQAlqexEF6hn93VRoZ+vC3+Qlq5tuup/kUM7AaTSEMVVhGjMEyoNMi1A7Y+fWYKhbHZnRANQ9mU1PnBeCbvYofZFVTElRZDV6jWCcKuIIxkg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 748b10a6-a1a0-4c67-d38a-08de278c6783
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 16:55:12.2047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KST+wrXIEkX2au4vjz7oqJzrjexObEBebNWxWpewX5utgxEk3V+9wZHRoHm5RmaptoAuHN5pwE35kcWeCjzYzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDE34AA4C5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_05,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511190134
X-Authority-Analysis: v=2.4 cv=BoqQAIX5 c=1 sm=1 tr=0 ts=691df675 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=9l8Rr_43ziRIAFmQHvsA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13643
X-Proofpoint-ORIG-GUID: YA4zS2pjV7E9IdiZ1_-UP_yprpAmL6t2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX0F//3DbTK3Ba
 5s+jw9cXZNL/o/TTDm8cPPeiMXgruDzH5+4Eq6BjYwLgcRjKQC0EZlrK+7e1XW9HrGPEwc3a2F+
 XUjeqREyxfZVAvcRTLt+YXFPolb3YFfEEt3NMxLmHYZYJ5xLtqwvlwjz9QVG6AgWiXcI6SQ2R+a
 Ish7kLvWGJD2niOtMWbNOth18sfZO+BjQ6xmNO5p2614zDXz4z3pzY4u/VMlZ8MMOLakFjDASoG
 FLOcARngP0lEviYFNlInh8EiXh+rlllHe+uEOzeY+fOiK2OKqufjofrGqu3W3AWKqb6Lpu6SVcm
 Z+6/ofEPS+HAVTtgyaJhoZmkmMbAIiPFSaJjuat69DlsrXpIV46Vk1855t8ve645rx6GUhUO2YZ
 cdjEBKehVj/YZykgTSrV/XarZ0KjFptB1FoKy7A+jc2P83cwwUs=
X-Proofpoint-GUID: YA4zS2pjV7E9IdiZ1_-UP_yprpAmL6t2

On 11/18/25 10:28 PM, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> When the COPY v4.2 op is used in the inter-server copy mode, the file
> handle of the source file (presented as the saved filehandle to COPY)
> is for a different ("foreign") file server which would not be expected
> to be understood by this server.  fh_verify() might return nfserr_stale
> or nfserr_badhandle.
> 
> In order of this filehandle to still be available to COPY, both PUTFH
> and SAVEFH much not trigger an error.
> 
> RFC 7862 section 15.2.3 says:
> 
>    If the request is for an inter-server copy, the source-fh is a
>    filehandle from the source server and the COMPOUND procedure is being
>    executed on the destination server.  In this case, the source-fh is a
>    foreign filehandle on the server receiving the COPY request.  If
>    either PUTFH or SAVEFH checked the validity of the filehandle, the
>    operation would likely fail and return NFS4ERR_STALE.
> 
>    If a server supports the inter-server copy feature, a PUTFH followed
>    by a SAVEFH MUST NOT return NFS4ERR_STALE for either operation.
>    These restrictions do not pose substantial difficulties for servers.
>    CURRENT_FH and SAVED_FH may be validated in the context of the
>    operation referencing them and an NFS4ERR_STALE error returned for an
>    invalid filehandle at that point.
> 
> [The RFC neglects the possibility of NFS4ERR_BADHANDLE]
> 
> Linux nfsd currently takes a different approach.  Rather than just
> checking for "a PUTFH followed by a SAVEFH", it goes further to consider
> only that case when this filehandle is then used for COPY, and allows
> that it might have been subject of RESTOREFH and SAVEFH in between.
> 
> This is not a problem in itself except for the extra code with little
> benefit.  This analysis of the COMPOUND to detect PUTFH ops which need
> care is performed on every COMPOUND request, which is not necessary.
> 
> It is sufficient to check if the relevant conditions are met only when a
> PUTFH op actually receives an error from fh_verify().
> 
> This patch removes the checking code from common paths and places it in
> nfsd4_putfh() only when fh_verify() returns a relevant error.
> 
> Rather than scanning ahead for a COPY, this patch notes (in
> nfsd4_compoundargs) when an inter-server COPY is decoded, and in that
> case only checks the next op to see if it is SAVEFH as this is what the
> RFC requires.
> 
> A test on "inter_copy_offload_enable" is also added to be completely
> consistent with the "If a server supports the inter-server copy feature"
> precondition.
> 
> As we do this test in nfsd4_putfh() there is no now need to mark the
> putfh op as "no_verify".
> 
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/nfsd/nfs4proc.c | 64 ++++++++++++++++------------------------------
>  fs/nfsd/nfs4xdr.c  |  2 +-
>  fs/nfsd/xdr4.h     |  2 +-
>  3 files changed, 24 insertions(+), 44 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 3160e899a5da..e6f8b5b907a9 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -693,8 +693,28 @@ nfsd4_putfh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	       putfh->pf_fhlen);
>  	ret = fh_verify(rqstp, &cstate->current_fh, 0, NFSD_MAY_BYPASS_GSS);
>  #ifdef CONFIG_NFSD_V4_2_INTER_SSC
> -	if (ret == nfserr_stale && putfh->no_verify)
> -		ret = 0;
> +	if ((ret == nfserr_badhandle || ret == nfserr_stale) &&
> +	    inter_copy_offload_enable) {
> +		struct nfsd4_compoundargs *args = rqstp->rq_argp;
> +		struct nfsd4_compoundres *resp = rqstp->rq_resp;
> +		struct nfsd4_op	*next_op = &args->ops[resp->opcnt];
> +

I find the initializer confusing -- it's only generating an address,
but not yet dereferencing it -- but it can generate an address beyond
the end of the args->ops array.


> +		if (resp->opcnt <= args->opcnt &&

In fact the "resp->opcnt <= args->opcnt" check allows accessing
the N+1th array element, since the array is indexed 0 to N-1. So
the condition here needs to by "<" not "<="


> +		    next_op->opnum == OP_SAVEFH &&
> +		    args->is_inter_server_copy) {
> +			/*
> +			 * RFC 7862 section 15.2.3 says:
> +			 *  If a server supports the inter-server copy
> +			 *  feature, a PUTFH followed by a SAVEFH MUST
> +			 *  NOT return NFS4ERR_STALE for either
> +			 *  operation.
> +			 * We limit this to when there is a COPY
> +			 * in the COMPOUND, and extend it to
> +			 * NFS4ERR_BADHANDLE.

Extending to match NFS4ERR_BADHANDLE as well explicitly does /not/
comply with RFC 7862, as you say above. So the short description is
misleading.


> +			 */
> +			ret = 0;
> +		}
> +	}
>  #endif
>  	return ret;
>  }
> @@ -2809,45 +2829,6 @@ static bool need_wrongsec_check(struct svc_rqst *rqstp)
>  	return !(nextd->op_flags & OP_HANDLES_WRONGSEC);
>  }
>  
> -#ifdef CONFIG_NFSD_V4_2_INTER_SSC
> -static void
> -check_if_stalefh_allowed(struct nfsd4_compoundargs *args)
> -{
> -	struct nfsd4_op	*op, *current_op = NULL, *saved_op = NULL;
> -	struct nfsd4_copy *copy;
> -	struct nfsd4_putfh *putfh;
> -	int i;
> -
> -	/* traverse all operation and if it's a COPY compound, mark the
> -	 * source filehandle to skip verification
> -	 */
> -	for (i = 0; i < args->opcnt; i++) {
> -		op = &args->ops[i];
> -		if (op->opnum == OP_PUTFH)
> -			current_op = op;
> -		else if (op->opnum == OP_SAVEFH)
> -			saved_op = current_op;
> -		else if (op->opnum == OP_RESTOREFH)
> -			current_op = saved_op;
> -		else if (op->opnum == OP_COPY) {
> -			copy = (struct nfsd4_copy *)&op->u;
> -			if (!saved_op) {
> -				op->status = nfserr_nofilehandle;
> -				return;
> -			}
> -			putfh = (struct nfsd4_putfh *)&saved_op->u;
> -			if (nfsd4_ssc_is_inter(copy))
> -				putfh->no_verify = true;
> -		}
> -	}
> -}
> -#else
> -static void
> -check_if_stalefh_allowed(struct nfsd4_compoundargs *args)
> -{
> -}
> -#endif
> -
>  /*
>   * COMPOUND call.
>   */
> @@ -2897,7 +2878,6 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
>  		resp->opcnt = 1;
>  		goto encode_op;
>  	}
> -	check_if_stalefh_allowed(args);
>  
>  	rqstp->rq_lease_breaker = (void **)&cstate->clp;
>  
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 51ef97c25456..7e44af3d10b9 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -1250,7 +1250,6 @@ nfsd4_decode_putfh(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
>  	if (!putfh->pf_fhval)
>  		return nfserr_jukebox;
>  
> -	putfh->no_verify = false;
>  	return nfs_ok;
>  }
>  
> @@ -2047,6 +2046,7 @@ nfsd4_decode_copy(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
>  	if (status)
>  		return status;
>  
> +	argp->is_inter_server_copy = true;
>  	ns_dummy = kmalloc(sizeof(struct nl4_server), GFP_KERNEL);
>  	if (ns_dummy == NULL)
>  		return nfserr_jukebox;
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index 1f0967236cc2..3de8f4e07c49 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -335,7 +335,6 @@ struct nfsd4_lookup {
>  struct nfsd4_putfh {
>  	u32		pf_fhlen;           /* request */
>  	char		*pf_fhval;          /* request */
> -	bool		no_verify;	    /* represents foreigh fh */
>  };
>  
>  struct nfsd4_getxattr {
> @@ -907,6 +906,7 @@ struct nfsd4_compoundargs {
>  	u32				client_opcnt;
>  	u32				opcnt;
>  	bool				splice_ok;
> +	bool				is_inter_server_copy;
>  	struct nfsd4_op			*ops;
>  	struct nfsd4_op			iops[8];
>  };


-- 
Chuck Lever

