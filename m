Return-Path: <linux-nfs+bounces-21735-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WANRCI3TDWpP3gUAu9opvQ
	(envelope-from <linux-nfs+bounces-21735-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 17:30:21 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 724AF590E3A
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 17:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 011CB3186B0D
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 15:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6353A3E79;
	Wed, 20 May 2026 15:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H7ksEwH7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G3YcBPPV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C693EAC8F;
	Wed, 20 May 2026 15:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779289812; cv=fail; b=cTptZUpOh87kjRliKHu5QwAPTqDTr7beMhCn9mmcFJ+/rFBM/V4bJvJB9tP2dPdlpgpxYZQUOC/zkIdGvt0Ql7Yy8WHe8ZObPGvx6Aaf8avczRsyGvw8PkYik8++82N88oaAvADGJdVrLAc9i7B57XI9D+ckmbH5AVuE1eqRsh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779289812; c=relaxed/simple;
	bh=Gx6vJ7B37IN4Gwpr+puobfFz/tKSSbuQEn857p5ut4o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HSaBUO2UDJ9NY90ED9SKvbvliT/CiDSxATY/V+cxKc7dXrnmTOKbiqI5qXLESfk/Zdh1dREXrh9HLGMSbnN5gPCNzZAfY7lUwiOrnnL486LtH2aR1PzjJIbfA6NDytfNc7Hbtl3UuVu1g6edVD2IeM5VoW5rz83syz90zQXaeng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H7ksEwH7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G3YcBPPV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K7WILp2283345;
	Wed, 20 May 2026 15:09:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=2qK2B2965rWtH5+kT3hguPC2/ZjzozrxmxHprPuo4z8=; b=
	H7ksEwH73vm3JsUCFs9CnRKouMITgEGdeTaZgQLW4iSUd8PgeD0+U6n/zJpniOhR
	rYQ3fgbTAlu7Fjw9kAkYPeyHhMQ5atHLRPB9Ze8sSCF35J4ejv9G8NYHwittvYcG
	Ot/LdFrn667wYHrMHjTDHP9iPOBP7I2Nhl2AZN+02+PRZ3cIIPTitd4e4pM3br6B
	wR0NnQ8v4lST4NrwXJUfriIor2tDN+K6kClHM6srRDjO++Xao8hdLrhiwRvgZT8+
	OY/qsMBiIwpkJOULCdBqEdjwWYnPwgkzkCNMYZv1Gamcegri3oVRExBa3U/O+m/T
	+2WKOjS7U34yyV8bpMYkQA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6h86y9y5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 15:09:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64KF9rwN001169;
	Wed, 20 May 2026 15:09:55 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011011.outbound.protection.outlook.com [52.101.52.11])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4e84edsw6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 15:09:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9BTsMk18GSuhdSrCTr6Nahz0J85jPj8GRHyBOkWnJ5DEWrhTOQ0k22rK0wgOfscCzCZ8fdY3Z0b2GaPM9RJ6y27WYRH+kRCYPkiKJhqazhIQiiOYZK1/6SViVk2aqKBIDnDsn9V/o9Koy2lUrKQRx26QljiR/9HeCQOF8oqEFxcUTzhZsQaY9X9pFeDcvbviGCMnonq9JgpSxYmcY4CV+L1BycCVezOxSvRZoXDUt/qjJM3VP37UQRFgOhU/pGVGQNEfZQz+EB8A5MXWc/m5XtOtEornT/0l2YHEByR/ZiiCCOow+MsEMBK1CYu3GbOC1dPrB1NWT8KZ3ispmOBAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qK2B2965rWtH5+kT3hguPC2/ZjzozrxmxHprPuo4z8=;
 b=aULdVxe16nSDuTCpWsYFZmF46xaDoY6n6RmPxbTLtqEB17kZ7h9xpZIGZy+zeh6vJIYuTzBrjnmg6WYIIxg3nzJt23qtfTWsuTh5MC0Lg7tu0Dk2tf4rOZR9uaXATz1OXsB2zCK2tTTlyHaA+BTS32JlGRiwMHJEFeULI+TakVmyuDK0FkCqFpt8ZdZAwYdwL5OdwZu3nMeyEHTwRJ+AM8l2wkBn4WgYmYgwyvyTpMi5/zk4cAEbyqoRn4JCVOJ6SfwuUBPWzC1EDtzXIafvkkyKCAv4lbn1VrLaZ/aas2NpMutiCx/GpPZLcCziJx5B34OOxu1XBgR+opx8IUBRxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qK2B2965rWtH5+kT3hguPC2/ZjzozrxmxHprPuo4z8=;
 b=G3YcBPPVC7KQLD/oRk1LapwY60N1R8KFv1P5xKAADcGlNqyMAZ/iN5h5GjjfJMg1AgKV0UeRbYT5r/G1CdbImqgjLV8bBQr5mzpFE9GZeJ6/5T2wE5e2rj5oBv2B7Ll/B7+kYyIZQz7bPJN5jiBJwgVkIAQfBvNrf1bhjtMXtWU=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by SN4PR10MB5605.namprd10.prod.outlook.com (2603:10b6:806:208::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Wed, 20 May
 2026 15:09:32 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163%6]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 15:09:31 +0000
Message-ID: <e55a29a9-ed18-4e3a-8378-f712bcbc940f@oracle.com>
Date: Wed, 20 May 2026 08:09:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] xfs: fix overlapping extents returned for pNFS
 LAYOUTGET
To: Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong"
 <djwong@kernel.org>
Cc: Dave Chinner <dgc@kernel.org>, cem@kernel.org, linux-xfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, Sergey Bashirov <sergeybashirov@gmail.com>
References: <06d9b1ae-e46f-459c-bcb4-1a5ca4ded4b0@oracle.com>
 <20260514002513.GQ9555@frogsfrogsfrogs>
 <26365a46-bdac-4e8a-a951-de904c3e5606@oracle.com> <ageSguSyf2kBY33a@dread>
 <b9860332-7b1e-448e-869a-ad59d8d5b7c0@oracle.com>
 <agqfBPRWXQDR2ImG@infradead.org>
 <606c4cea-70d2-4601-9db2-611cd35c3687@oracle.com>
 <agwDhixPAAA0-cTa@infradead.org>
 <55c7c22a-8edb-4833-be3f-1f6555ba90ed@oracle.com>
 <20260519145949.GH9555@frogsfrogsfrogs> <ag1vwFHoYatausLK@infradead.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <ag1vwFHoYatausLK@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0191.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::16) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|SN4PR10MB5605:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a106ff1-f1e2-4f8d-3b78-08deb681cb42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	L+m5yXLR15Z9YWvvxnumckD7Pg+d9aJ9NEdthmKVm+F1x8f8Q4O4Dg18VYlx6ZBUi7dN1UCIo+5ZZkExMokQfWtQckrUZ6uARqgjBPQKpOZ97RxsCScpw5UDz7n4IZkvJwD+Xk6/Oec9YhaBAQoawyi3aWnAAz2fudVA2gXo/qMjDwuQ7D8UUVm9RzOm2LpKBfJVuxIblSyLakp1WcZAx4ik76Y+lAjxnuZ/giKcf3u1rtjw2dnK/nae/ikiwBeLibqYLqinUs/HOTNbWVwgQjFAWBnvnZyT5V0uKILz19bhzbzSPNJxCPT7bMTfvYBambPxK2N4E6j08j9BYzxm979O7HoloACd1QhI8jR0hY11owBVhg8rJsH1XQ1CJbTeDgwZ2g/ZaZ72Hn0Lps9ElBkF0RKmb1FM5yarWnjq7FkOdt3yu+JpOp/a7TzsYnNKCodf8m2FP0Lm24q4G1r0mb63TurOqxvLy/8cRF2ujfyYz2OzY99kUtVHsfzIK4GynRvYAiLNbxky6DVlDxV6wUNZ9BWf044hLAIjwLts8jD7tdY4UdVAd6ccqPn7S/5ZwQa1V/HpEJ9uy0IteS8zxKWLBiYKANTokeMF0VOgr8NHYemsPerkCqGzm2ucDGRz7Lx5rv3o4+TxK7Errc+yWBXF12rru5v8p4HujALxKwIE4BQ15iabPA1wNS0qW5/Y
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0FzYS9JNysrSVU4dmRUb1JsNVhIV2N4WXM0T1JGb3dJcDlXa3ZNdk1zWGlP?=
 =?utf-8?B?QndMSFpyUHk2aXFBcXJmVzZoNm0rdk5KNStlSWd1Sk1HUW11SGtOQTZRYlNT?=
 =?utf-8?B?MjNwQnNjTXJSZTRwTE85b0ttNkt6K2t0MEs2RUpHL1BSNGg5S0FFYTl2d0dq?=
 =?utf-8?B?SUJIRC9QSDNUcXA5dURXYUNpZUlVREpGejdWbDQyN2lzdUdPQzJEYjZSTmJr?=
 =?utf-8?B?VWpiaWtQUHRWWFNlV1N6MkhkK2duaisrRVkxNWJCdGZwMklaTEU3dHp1azNh?=
 =?utf-8?B?aGFtYTd4UmZhUGxIRHNNZkI4b1gxS0M2TjRVSVV0bjlCVmlqN0Yyd3hGdG9R?=
 =?utf-8?B?czZ3OElPc3UzT2dSSmx1UlZjWkl6R2NpRGJDTG4rMkR0VUl4OWpreUtrUlpK?=
 =?utf-8?B?SW9JL1NMVlBib2w0RURTNTh1eVhtelViVzIwazNEekJoZTJDMGZGbXVZS2dI?=
 =?utf-8?B?YzJseUZUQmRZclVveDkxRE5DNTh2Njlrb0Z1ZzhBeXVqUDBnamFxclUxRStQ?=
 =?utf-8?B?TCtJUjZOT2JmbEVhWTBLVkFEZEJKSGV5SCtoTWQxVjBZZU8vdXR1Q1FlNXBy?=
 =?utf-8?B?SzdsR3BmekJTKzlHQ1JvTjVzTDlscjNTMmprVUkrOVM5RmEvZyt5enZHMFdo?=
 =?utf-8?B?Q2VIYWowditRMElJemw1ZWYrMUlwbTdhc25SbTNnaWpJR0ttc0R4RnBvUTda?=
 =?utf-8?B?SGRNc1Fhdy9PQTFCU1pJY3VQYnFTNVI3OEQ0TCtYd2RaZ0hHNHZrR1RiM1ZH?=
 =?utf-8?B?bDgrWjl3VUpGRXdtUjhOd1RCSEFESXZyckFGN3QxRWQybHpGMFFJZ3hpb1By?=
 =?utf-8?B?RUdrRkpVRXBzWTc2aENwOFpiT2hoNzBuWWZ2SWZjQVUvYXVJS2hUdEs4dnYx?=
 =?utf-8?B?SVZLdkw5Sk5xeHpVZ1NobDlKM3UrUW9nOEo1WExuV0VUMUU4aEtmK0xROFdn?=
 =?utf-8?B?TitmZW5wbzdQdGJFVzJYOEF4Wk5VamJSUERienUrT2x3NU0wamJNbEJud3hV?=
 =?utf-8?B?UTFhaFR3MnlBQkd1RVgxOWxkTkdLRVU1RFk3VmlWbnd0L2JSOGJOaytOMkNo?=
 =?utf-8?B?Ty9FR1VSSTlkOC9HVzkzYklQZmlSazRZdzFBR2phOWZmQ1JDL21wVzF0K0dL?=
 =?utf-8?B?QXBmMEZ5NUd1NkdORWVkSmIzVWh5Q2JsOFpTODVTdGdXL0pSNmVzOHBHVTBU?=
 =?utf-8?B?SFcwRnBad3NmcTd1dGVaRk9SOGczamRpYUw3MHFvc1FvZEpUbjdWUUJXNmNn?=
 =?utf-8?B?dklzZVd5Zm1jMmNRTUFja2M3NVFRVXhtQ3JibWM5VVZEeG9UM2NGL1ZVMEph?=
 =?utf-8?B?VFU5TDJtNFNoMUtQbXc1cXlWOGRuMEROWmhXYlNwQ2pMUWpkWStSdTNIdjht?=
 =?utf-8?B?N3luRlNDKytmbzFPeVRhSjFFSFpvZVZVQ05vUXBaVW1hK3VUZitkTVZJQ003?=
 =?utf-8?B?TTJxdVpkNGN1WXlYTnAvYjFJdzRXTWhqTExjMEhQbzc3ZXJ3UHNxWEhVdENX?=
 =?utf-8?B?VHZtMlU4OXp5TFJDWjNhTnh3UDZNK0dRZ0VLenF1WmtTTHlaOW1XcVNHb2tV?=
 =?utf-8?B?N3JOeFpaUzJ6a0hqd2dNWTRYbzM0VTlmUjhPMXhNZ0xBZGxTYm8yRlZpanlP?=
 =?utf-8?B?eXBHVjhrMjB2bHdSVjdrSDVwQnVkTFp0b3kvQ2Y3a0cyQ0tmeVpydVQ3M1BP?=
 =?utf-8?B?Q0pJWktYcDl5ck1IWVBPTHovOW9RNWJnUnZxc3B5ZUZSRTUxRUtPa0QwVGpl?=
 =?utf-8?B?RnlGWUhyWkhjN0N1SXpVbnp4dmlJZEpOeVRkNG1GNG4yc3lvSGYwMnVMKzJP?=
 =?utf-8?B?U28ySkJPYXFzT05HS21zK3JTc2VFV2cvSW0wOGhOdnF1YkdPbWltVTBHNDUw?=
 =?utf-8?B?ei93R1cyTnpnNEE4dHNNYnpvUk9zZ3FQSi9Rd0FBeGIvcThmcjc2d2RaV085?=
 =?utf-8?B?a25LbXJPQnNZazNDd1V6aWQvZElrd00xcjUveWw5dk9iUkZpQU9JV01MaUhX?=
 =?utf-8?B?YTI0aHVZNmVQNHI0Nmdzb29tYWtzdzNuVmhoMFBlbzA4RlVRcTdFZ3kvV0Fq?=
 =?utf-8?B?Qi91eU9FUU1JcmFEbkcvY3UxZ3gwK090YXFhS0FBbzA5ZzdrS3NSa0l1bElm?=
 =?utf-8?B?SzZLU0czWm1yRFdxc29oNGg2K2h0QVpBVENocFlBYmo0UmZXaktzbjVwdDVT?=
 =?utf-8?B?UklDc3VGaWM0WngzZk0zeTBldHZwMVphRzdpenZDTkxaN2pQeFp0dnRPdTgy?=
 =?utf-8?B?THpqS3pGYmY2emsyd1NFWVJ5MFJrbkI4WUVmdmRUN0k3L3RVNmtFMzN3T0da?=
 =?utf-8?B?NkIvdmZkNnI2a2tUT08ybXV1UUM3cjkxZmp1OFBTYW91aHV6VFpSUT09?=
X-Exchange-RoutingPolicyChecked:
	J+j2m2Cs+UIOsqWAW0qkYaC0uy/fwbArBekBrkH3vJ8VhxK78/OgytI7acRIvtMmiu8Ch0HHx1n+WJ1UHREwqO125oo6rp3Drp08DeBi+yLGZYrIWxuIM0ag3+X2LJrN2pP81V2JaPsmRJFY4SPcguxCQbXs4VZOEyNfjsblY6yxJtIFbH9RStpETto3EJdEoQZUY0gxlrczG/vCFR3H5mAwwl04nF1Yn4A8HAcxcm3v+mp4BFduvNHDWSIfDO55M8BaaYmAoKxLLaWqGQVfXtJbW80dsu9NsMqbMjsNaW6Y7GQkQmFQRetl34lGOqsI7Pmh7aPxlWlVILSgPjDH0A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6/4r5zbSZrHIZgfZ5Z9O2o6TbMNqOMjQQf+jskzmZ7AWBTBA7/mrp2hYWdS7TcI2shdvEpxSQXYWv7uIfABGUSQZvdw30zMNyrwOLOjdvfCY+HWWb8n+OdRDK53y7AlKiA9uRlLPBRHwpaDJWTvQPxhmM+HKk2BrrGOBKW2kYJEbNf8Zf1WBRVEpaILBMAt4FcQbxF3vqK4dn2DUIdI0+znvtWgrlTIQQseBuyBfyyjUhGzOR0sfX9hGa7ZWkHkMu1eK4oEEwpj9V2VpNzpRA7VJRnhWr4GIWa6KJo2iYH/gDRxhC3FH9+hKXy1wUasSo1N/cZeciUR0dA50rjTQKVVUOQ9t6EwI0HpIpfdcjt/RVq6c+glN/GHTfQDGsSv408gmdiPPZQg53bVtzy7CCRaqy0TVIPQT+oVLRseeD9crMNfQ69ox2rTZ3NRHg6AUfR7p7NHs9BYzvJfZPp7qHQ7k1vf5Nlj0suhwMHhOcql1YyyQRSI2z+A45iA6iYH1IZs3UKOIIug9vUOLPZ4n7CBjRMs8x90ErHxEGUwfIji+E+tLvJIwxjFnEB6ruc43OtxO6JavrgQwGldmrZ8+AH+2SUcSz7OEZTpUZNp5LWo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a106ff1-f1e2-4f8d-3b78-08deb681cb42
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 15:09:31.2157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: swqZL3/3/YVf03kwbT3Xcih/csaezqrpLmcuEJMiUvBFBWrT4f6nYU4tPWZkrRnOh3ChWsJYXqWjMpYi5Votjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5605
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=859 mlxscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2605200148
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0OCBTYWx0ZWRfX7KXJ1fZm2sQ5
 DPtyzbDfHVZkZX8exDYYf3c6wF27PhYI9+qbUp3KpNDUh//GmG//FNyOzIpTdxkprKCm0miSlFN
 3kI0K3ytdXRPPY4h7e3KhAttHXc9yHUY3NT6Uupjtm/hNck3von6duTBez6+Buspr73KmS2Q8OQ
 L2Xnn0CcH/Mlj+4xz/rfqT8uqY2AqLp1XQ734mmAKuNB0XCQvjjS9CUOUXD2pCC08qzteo5MO+K
 4chwFeo6d73rTm4l018mKHWpChxXTRZKWNtjGxHwIFSrAXhOYLCJe9qGNIFWiX0aN5Ujei+gMqt
 /Ij6RlPuikLbzTrsIQvCdDQqTo3GCqKDpehw2g+ZuMDGfr0Db1rpF+Vj/ZL8wh8W41lZShvjinA
 FNKDx/Gp3jlGjtelUWfZ8AeRfjbfsVQRDYH9dpqUP7mEGThUijaZPWnYzn4NOndLZDf75cESUtr
 RugU1y6MRZZw/vEDC8tpGX/6gwMWJ8AKP5FBdeaw=
X-Proofpoint-GUID: Oqot6DlPbOZScKNDjrVY1jd_MhSruATC
X-Proofpoint-ORIG-GUID: Oqot6DlPbOZScKNDjrVY1jd_MhSruATC
X-Authority-Analysis: v=2.4 cv=TLN1jVla c=1 sm=1 tr=0 ts=6a0dcec5 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=88Vi5p7Q927nAMVBs7gA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13839
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-21735-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:mid,oracle.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 724AF590E3A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/20/26 1:24 AM, Christoph Hellwig wrote:
> [adding Sergey, who wrote the code to allow multiple mappings]
>
> On Tue, May 19, 2026 at 07:59:49AM -0700, Darrick J. Wong wrote:
>> 1) xfs_fs_map_blocks only takes i_rwsem and XFS_ILOCK; it doesn't take
>> the mmap invalidation lock.  Does that mean that pagefaults could wander
>> in and mess with the layout?
> Looks like it.

I already described the scenario in which the file mapping can change
between successive calls from nfsd—triggered by a single LAYOUTGET
request—to xfs_fs_map_blocks().

I also don't see how page faults are relevant in the context of pNFS
layouts. The server is not servicing actual data accesses through page
faults when constructing a LAYOUTGET response

>
>> 2) Now that NFS apparently can serve up multiple mappings at once,
>> should ->map_blocks pass in an array element count so that we can do
>> multiple iomaps in a single lock cycle?
> I guess we need to do that, or revert the code to provide multiple maps
> for now.

I think we should address the immediate problem first by replacing XFS_BMAPI_ENTIRE
with 0, and handle support for returning multiple map entries from a single
call to xfs_fs_map_blocks() in follow-up patches. That work is more involved,
as it requires coordinated changes in both the nfsd and XFS code.

>
>> 3) Do the reflink and realtime inode checks need to be re-assessed after
>> grabbing the ilock since they can change?
> Yes.

I can move the check for reflink and realtime inode inside the ilock in v2
of this patch series.

-Dai


