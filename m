Return-Path: <linux-nfs+bounces-17287-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE89CDA4BF
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Dec 2025 19:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 231B0300CAEA
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Dec 2025 18:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB163491D6;
	Tue, 23 Dec 2025 18:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V2SGeOxJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YhDCGb8k"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E37320FAAB
	for <linux-nfs@vger.kernel.org>; Tue, 23 Dec 2025 18:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766516095; cv=fail; b=VqbSYP12EnKoMBPlwt4nU4ArIvOscPJF37W8mtXfyFXh6N16KGosUqiaI3t4qf9cFvsHSWAcR5TrGg2eJkVk7JsnSMkoW6a4V3IFGti9YQKU5EPTrSrs5iRd5WRRfsEZ78ttI62Wbtqh2HO/Pi2M8AyeVwydzB0n4Zj2pX4jlFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766516095; c=relaxed/simple;
	bh=3tXvZHtcQih+T7mQfmuKkeahljSx9qRmVlEY2Z+n904=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BrXqO8rXJzkTZFLp+82DFJn+J7qfWHavuFxhvtPgojoXS2tbn7TnzYTtuYviYf3GjRW03MpSMFngbQ8Y2rGHNv0YBF+BIcQZhJB5TZ5sCVt4rGeS5VB2PafhIB7UeJGrAE8i/YmLxPsBCSbJANO1KCPwOk/6k/GI9kLX6ay+Eqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V2SGeOxJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YhDCGb8k; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BNIfZJI978539;
	Tue, 23 Dec 2025 18:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=rW30jdc0F9f5jawBZZkjhhJ3gU4zY/1EflD47QO0+vM=; b=
	V2SGeOxJr2B5phY7AQy8v6GvYn3CnHzI6MSo1J1lzQmhdInqE/W9vpHB45hJhQ2m
	cckX/9sHq54NfYscxgt+PbWOLvVrMDeUHFlabLFDGeM8uEn0zRWCnkv0xWjLvGX+
	JDMZqg0KysLv3ql0YL5pxd16uiHWu59hb7UXMsOst9WZwIUbKlvCPUKrCKtPqii6
	/oIZGZQJStqZkuHep615yMmPUbeJIFoQ2yVr+HsH+5BNuRRI9yXUd+RJxFTeAngN
	2O3f0vI9s2jgng57sWWfOiA+YOhC3BCIUqODAiqPTI+STbEVHiZa5SQ2z6WzUqg8
	ACTCG4tKMyDIC1+IFgkXgg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b80jxr0fm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Dec 2025 18:54:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BNHREHG024365;
	Tue, 23 Dec 2025 18:54:31 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012005.outbound.protection.outlook.com [40.93.195.5])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b5j8creyr-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Dec 2025 18:54:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CyDVdGYpNwiHbE+wU0Jp8Ub1a2Cdu7HCOQfeiqu4uQrSkxFDHIofHhXXmTgDnNgtRn00JGDFJyIPIzdO+jUVWLctKtrrij1pSWRNyosj9KrvfYYKWws7MPyDf4jq73dV72o1g7fLi3ximFFSGlmMnaiX3WZAkBy6doM3NfY76kFDqmqfJKf90rD6DTmME7th+7yNWS1XpCVizVpgWSACGv3mXm7TD9hjdatw2fzuS5mh5s3m33iTlNnApzfp5FRSXXpWAqc5m+XBPF5Ob+ZDXMcgBwVXR2XraJhuckWwxTpsjRr91hGNVlp64Cc4hAjttcLhNRiqRe2P9loJnnh5Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rW30jdc0F9f5jawBZZkjhhJ3gU4zY/1EflD47QO0+vM=;
 b=x2XO6XVgJVp0LjnKGXKmVMsBcC/qkVHmthbxop/egtWGayuKjfk1imCjUVGxpXSWsas2PJLzBTz3oyOVOe84ysUpq2pp/U/wpXmj7BiEhwOjyf2OkOXU+JEbhK/jyjlQXpYYS16FcXFIzin3txTREjgrTd4fYbPnjP7ztOiMs6j7Pa45C00mb7txP53C2ke1FeNWDx0T+7lyF8D/IB6xolJqGo8FcGrqbE1RyQKhdqOqQAyrIkrHP+Mai25Y9Lz0QuwJlf1ImBJrNtqL+zCpdeO8TaYw1b0YnfJ9linz4u8y1Xw6sF6k0eO+A4WQRuTNF8CkKfyvFlXgdHItLotomA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rW30jdc0F9f5jawBZZkjhhJ3gU4zY/1EflD47QO0+vM=;
 b=YhDCGb8kdHk7WZlsZPZoO/G8cnhiNp5Xf1Pb9Kf0d7MuQwJCvGb7NA7wd4KYU9XB7OxMf63/FF5qsTIPhMsK/746BZbOkqFZgDfDS4FeIrpFBcQKpItllPwqDbxR0y+BhTYAUyWT7FV8AVLeEcxnIWIv2VSL5xm6hVZxMLIT9ac=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by CH0PR10MB4841.namprd10.prod.outlook.com (2603:10b6:610:c3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 18:54:25 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.9456.008; Tue, 23 Dec 2025
 18:54:25 +0000
Message-ID: <f1448227-ddd8-47cf-9fe3-3e1983520de0@oracle.com>
Date: Tue, 23 Dec 2025 10:54:23 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] NFSD: Track SCSI Persistent Registration Fencing
 per Client with xarray
To: Chuck Lever <cel@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, neilb@ownmail.net,
        Olga Kornievskaia <okorniev@redhat.com>, Tom Talpey <tom@talpey.com>,
        Christoph Hellwig <hch@lst.de>
Cc: linux-nfs@vger.kernel.org
References: <20251222190735.307006-1-dai.ngo@oracle.com>
 <6ffa2b50-c0fc-4532-908e-951b224fcb10@app.fastmail.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <6ffa2b50-c0fc-4532-908e-951b224fcb10@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR10CA0007.namprd10.prod.outlook.com
 (2603:10b6:510:23d::7) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|CH0PR10MB4841:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ed8a62d-1e9b-46ea-2999-08de4254b12e
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SXdQUWRZVUlhczJ6TlcvbW9reHE4eFNPSFYyS3M5WmNoTkoxcjZpc0tnNHpu?=
 =?utf-8?B?OHdHTEI3Qk9wdzZweXdpbmhEQU9memJsRVlESUhrc2o0TGxDRXhFWEYzb0dC?=
 =?utf-8?B?c21zcFN5eWppWTJTZ0daVWZneml1SjBqck85M0xQWUpVM2hNYTgxQ3RwdXVs?=
 =?utf-8?B?ZjEwMGZVOWhVU0NncWd5dG9SK3RVejB2cXJtb0p3NkpSVjA3ZEhsWEl1T0Mr?=
 =?utf-8?B?bW9tbENwOTJUd05rME03bEdDTzJXT3lNUk90VjRtd0IxTjJtNkh5MEVjL2tK?=
 =?utf-8?B?TGV5RG9GUWZJY1dacnRtWmRmdEp5Q2ZzNUlDdE0rN2tjeWpMZ0xQT0d1YnY1?=
 =?utf-8?B?MnExb2FDY1Blb2pJaUhBdnFENTZqVzVDNzFuUGhBV1NIWThQZVlpMlEzUU0y?=
 =?utf-8?B?OElEU1U5Y0NwRk5lMDEzSlVvczZ3NlBJUzh6Zm9VZnJBRjRlWnJMN2FuSDdl?=
 =?utf-8?B?VWlISEtRVVBlTHFKOGhmRUNUY0IvMUMrbVViM3VwVUdFbzJVOFNvaDlFcm9w?=
 =?utf-8?B?dDhXcm9RR2Urd0svVDhSZzRUazNoTFJMK05QbWRtdklXMjRZWXZkcE1KeDNO?=
 =?utf-8?B?Qlc1VDNHSFA4Mld1cXo4cDE3aThnZlJIWk1zaVVHMGZJQmZ2TWV0V3RSOHZI?=
 =?utf-8?B?TUNpQzlTVG1oblB2aUppdThBRnR0a1B1elRJcldVSkhXOTYrTkZjUktTZUJJ?=
 =?utf-8?B?SDJMQTVweGwreDdVUElJdGsyaC8rL25oUW05bGhac0RJdEZ5TlhkaXlCS1Vx?=
 =?utf-8?B?dklsdUdadzdwTVVMUFBkN3NZQWR0TkR5ZkZUd2lxS3pQV1dsb08vdUZTU0Rw?=
 =?utf-8?B?bHM3Rk1NZ1ZWblVsajc5UUJYV1kwMFIzem5YenNtc0dLWGNicUNQU0V1bEp5?=
 =?utf-8?B?Zm4zY1F2dHFselNZZkMwRExVTWMwMVE2WklFSVBvTzVsWlR3YlZhV2hOMHRl?=
 =?utf-8?B?QUVWWUd3SnhzcXZxYi85cGpSL3pOaXg3K2xueTZCNnQvNHZsNGN5aUdaU2li?=
 =?utf-8?B?UTB0TURBVnJiWmNvTVlJZGlVbDdEeTY2SlNPTFFGd05PNEpGRGNjY3Ird2FU?=
 =?utf-8?B?ZVFsRUNnR1ZWbndnVzNUZ252THlxVFBZQjZOVHB6eTBNQnhIR2JuRGl6eEp5?=
 =?utf-8?B?YW44TmY4ZzZQeCtRV2NRQlp5TWFHdS8vTWRVOC9SUUo0ZG1ndjRyNSszQXBD?=
 =?utf-8?B?NGtpTkN6VEtmMFltMXZTaHVjaW8zUU5scTJIeU9acFNhNTNSMVd5VnRLaVpu?=
 =?utf-8?B?WXJUdjVqWHF6cHhVV3E0OEtHbnYrSSszdkFPN2VRVlVhY05GcVY2MTdtL2lj?=
 =?utf-8?B?QUFCK1dsbTFEcXdtd2xNWEZiNUNocDZ0Z09tUk96NXZVTmtVVFRkN0U0cmxR?=
 =?utf-8?B?bk1QQ0d5eG5iL0pmcm9YMnVTMGRsTHNKOElqRVEybGdGMm1IbnRSd2pKNVI1?=
 =?utf-8?B?YVJCS3hkYnlrR3gxU3NrS2ZUMDduV3BubEIyUnF0MkdzaUZqekRVZGtZbjI3?=
 =?utf-8?B?OEp5VFBFUldNYVdEQWVsUzU5T29MMmVxeFhNVmRUa1AvRkFQUnBLWWxFU1JI?=
 =?utf-8?B?RURVWm9oL0I5bS9WWDBrNkZSL3MvdlZGVWpQMUdyWjFLQzhyR24xU1lISjJP?=
 =?utf-8?B?cFFQcU9xcnBLUFZsYjJxU0Y5Y24vdnVPejljc3Y3YU9abjZVSG84b1ZveTBy?=
 =?utf-8?B?U0xGSDg3dkp2UGZoUEFoRWRmdVMzRVpiYmlnK0RQbXY2OEpSaFJtMWxWMFJZ?=
 =?utf-8?B?Yytvd3cvd1BQclBjdGFzV3lpOXJiWlI5blBtVUkwT3NuTWxOT1pZZUdaV1lJ?=
 =?utf-8?B?MnRVVGxuNDArNlhFUUVQZWkraXdUTXowVGcyR05uT0VkKzhIZGpjRndzblox?=
 =?utf-8?B?SkdoSEhSTHZwakYxMDJZRldHcHFDSERZaFFKQWk0ZlhGVmhsdEVWRU5vMXJK?=
 =?utf-8?Q?z5QyGonv5jU1QDy9fRjkBjTWm31cqnEG?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Z2pVMWI2a2pwZ3RGZS9FOEkyQm14aUkwMUVvL2gxVFo1TitVc3IrMmQ1MUpT?=
 =?utf-8?B?UngweGVPVXpaYXFzV0hGVWloU2VpaXRadkJWYlVIN3lheDRieGsyTlVzN3gv?=
 =?utf-8?B?OUNYN2FHajdQYWtKbnpTV3IrL29JNVRvcW5zSXk1QjNDd3kyTEJRWVJMcTM2?=
 =?utf-8?B?V29BdE1QNy9ySlZDc1pMNEVCUWx0eTNmcDdZNWxpSVlNUXBWMkw2ODZJSjIr?=
 =?utf-8?B?Q3VPd2V2VWhLOWpXTVBUejNPNEhWcm1SUC9rekhodmU4VmEwbmlEeEZBa0Jq?=
 =?utf-8?B?OW9scEFEakNwK2hRNHZ3V2NlRml1aUlkYko4WWJrcEovOUwrQzkreE1mbXhw?=
 =?utf-8?B?VU5lTHFFT2dKcnl6UHg4TFFZVG51dFJMYlNLeFR3M0FPRExtVjBEcVBSTk5Z?=
 =?utf-8?B?RkVxOEZxY21Kcko2cUhPd21URGF3SUsvc1A5cmFDS2xFVk9SWDIyaG8zcDVp?=
 =?utf-8?B?eWJNRmdNY1pGYy85R0FKbTVlVCtXL29NTzJSMUVIeDY5SS9zMFFLc2ZTbG84?=
 =?utf-8?B?RTdkbStmcFlOdG14ditXK2NXbTAzTUZ1SURLckFEOEdDdjgrN0hQbnQ4WXdN?=
 =?utf-8?B?dWsvVzc3Rnc4aG4xd1l3dmJJUVNHUjNqNzJQZjVQaDlmSVdWdVl2L0pWQlQ5?=
 =?utf-8?B?a3lmREt0MEx0OVFtUTlmWERMZFcrUXpWNUZ1ekVNcmtsdndUb0tYRWh2ZGVr?=
 =?utf-8?B?K0xScjFLUFM0Uml4YmJVNnNRZ0RkVGFQR0Q4dVRBdHVOak03bWszdGdhT0hC?=
 =?utf-8?B?b0d6NTMxWVpJc214LzZaQjA4RVdXc0lFWllFejZmaDJYSWI1N0s4U1FhSXlS?=
 =?utf-8?B?U0tiTWdhajVrR0hwaVNkTi9jeGRKTDZxYnpHRGJkZFh4ekRHZ0pLNmVzWnJU?=
 =?utf-8?B?MXN2N1dlRW1kdExjYlowRmlibnlra3dhRkxBc2F0d2RCbmNWZ2ltV2plRWZQ?=
 =?utf-8?B?ZmlBNGlvRERDTVFQUW5MNTRXdW9NZGFVZXl0YnkwQWhPWmtzMXphY0pHaVEx?=
 =?utf-8?B?dXU1MzZKQ3V3NUlHZjd5T3NvV0hKTkc0ZGZOcnZFNFd2YkY0ZUJybVBxRGpk?=
 =?utf-8?B?Q1cxcllVNU5ydjEzNVIwMUVRb3prVHpwUitPM0x1V1QrejYybTRDWFZEU2JS?=
 =?utf-8?B?UldMTHJVRHdhZW5MYzlBcjZoQ3lWOUxnaVhmZ3FzaU4wbEorZG4xWEE2bzNa?=
 =?utf-8?B?RTZpcXNwa2o0RnRmQ004NHFLK0ZER1BVbGtZVkp1aEg4QjIxSEZTNUJueFVJ?=
 =?utf-8?B?bU5pOHcrdFdHZDlzN3YrVFhkVUZRWGtOajhOcktSWUJjbytQd2Jsc2R3d3hm?=
 =?utf-8?B?RTV1NEg1bFJhb3c4T3pRRThDWGdHcWRSVXRWWS90Z3hEamFYemM5WWRoN0hD?=
 =?utf-8?B?d0taYlJ3UnhFbktKWmZwbFk0Q3hwaEdKZG0waHJFUDRuVVpMMnBFUy9Hd0pZ?=
 =?utf-8?B?cXlXKy91T2pvQy9VY2JTKzRSZDJWZzk0VUl0WmY0dElId3hBMVpidVJvVGNy?=
 =?utf-8?B?ZmtKOGZvWE5JSEwyUmo1WklDVGt3NlRkM3M0Znh5bXRsUk5oQ085MUt0U1Z2?=
 =?utf-8?B?UG11cG5DN2VIYnNtMVREUWQrNElEaFFKdU8zMThZbTdFVTVCRWpYU0F4YUlF?=
 =?utf-8?B?QWhuT1htSGZpTzgrdkU1VWJiYU1jdVZWV0xKSktPOVFGaHRIZ0ZBUHR0KzM0?=
 =?utf-8?B?MGRNeEQrS29tbmtnVnRNeHJVeEhFWlByMmVaTnpJL2pHNzd0U1hXanE5WUx0?=
 =?utf-8?B?aVB2Y1VoNHZmRFcyYXpseFpYOFlDSjc3ejhhUlB6ekhHTGdFVGg2czNDMHR0?=
 =?utf-8?B?ZGVXelVOUjNaUmxaOS9ydEp3dG5hTE1lRzVzMGVUZmxaMDhLU2FYN3hoN0pF?=
 =?utf-8?B?TmM0Nlo2cjNDLzUrU1RwQS92UUE2K09RZHV3ckdsdGFtNGV5WnN5UHNDN1dN?=
 =?utf-8?B?emw1UjhTL00ydGs3NXNKVi8rcjNWMXU4Rnh0YXJlSWxxM1lBMkx2STJuYkpi?=
 =?utf-8?B?aGhRVDFtQ1p4cVhuQ3E5K2FNeUVaeWFSZG1HWXlBUE5seVdoV2lBejA0Z1RF?=
 =?utf-8?B?V2RwZjJ2dnBPT1Q3RU1nQ1BZcVFzc1BrMXpmUmIzOWlCajAyTkRWSEVybDFD?=
 =?utf-8?B?M053TVlZaU5rNEN6Z1BLYVB1aXdSb0dscSs4SlU0bGI0QmxMdXVpOElpdTN4?=
 =?utf-8?B?ZG44M0FqUDVwVkpQZGhXS29mcGFaQkFZb1YrRG1HTUhSbjFKWm83MWRxenU3?=
 =?utf-8?B?NzJpc3gxV2ozVCt4RXRNcDYzN0Y1azBDTStyTlRrYkk5U0g3K1grWUNNcDlL?=
 =?utf-8?B?c1QwZnBSYWxGRmRlcG1Jd0VuWVBCaGpsemFId3pRbng5ZHo2TTdUa0R2dHVh?=
 =?utf-8?Q?FNb1ACuHRf0n+0CpNnh8kPYqYdPoDaySHC5f9HcJt9YwW?=
X-MS-Exchange-AntiSpam-MessageData-1: 2iZyqWkd355/EA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2vSIJV3z55hwPsEvGPm727WuhNuaZf235cAmQhU2fHYf9og9+bY7eFaOiyDwt3KpdBFDdfZCilfa8l7F6LRUFN9qGdpYOmQWSPQMJcT2B/CuOdPkNhYNpgsD9frxnt6Jodu7eq5VG6Yml0mr1epnQ9rFX6QhllXsutkGy2QMSaMZfd11FKE3cS9WoMF+L1LriGZ53AeW6OH+CXGAyQ85GRi6JbCJ4gdqVa22dUpusyv4oo63Hli21oywhDnYJiZpSGud93PoIu8KHtZmJrVJiHc5WyKha2bD47At1U+n2o66oDcEVtJsUztG2+8FwVg+XMyawntfGSHXs7/ETwi/G1GKVE8pU68NfkpOeFiW07EnF9pMivfAL0eMpKnLQyzHChMsIyIjyGwvBdaz1wOoHl4vWIz2qYNeDJdDKkn5tsMox3cdmFGS5oB+Elw4iIqitDDco4eKbr2KPxvYdEVzYd0h/k1svujovdLbKkJdlkJxWmGzA50X5ERGupxnB/KkM8cvK/q2xuR6ntfMnJTemyG+k03JR4LfQpgBtDbzyhi6AJRdG40dI0cvqXM2CZQppVxsHPMIlOBkSAhbf82sPVRI04y4cR+xEBzDbwGLpYY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed8a62d-1e9b-46ea-2999-08de4254b12e
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 18:54:25.2154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WUztQXygd1Cj8BuOlokiZYQKe22elmYwBpKQgRZVZUJHx/Xcp+O4YXyoCDhIWFUBpyU5hsOHKJDuKMuBL3RmNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4841
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_04,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2512230157
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDE1NyBTYWx0ZWRfX/HezGCo5ekgA
 BjdljDYWO1yhQpTqja3ZWnV8qnXjGQRsbB5HkgzDeXdveBUGGj8t+LjVZstZTyS1rkW43JkgcGV
 KfpD8D+7rTHi/TO7xk1CXiemndkV8fsDinqjmqQDETWS6TTnxufA8jCZlLtnJIGGYxtvSFOiByq
 On2Tmjy7iErN5W3enXL5HSu6Z8vTpqMY03MhT5eCt/QDkf6SJ6Bdc3v0hrdAJmIRztIXRoE8ZXg
 jcvF7ZGZkZwUi9XtpO4z214aCVRa+KGRS+EPZFWE4frRAm9ySsvzOCgedh43xXXAg5Xpq08cIYl
 9EP5DNavGj4Q/kIi0/s4/laLk7L8YTcvgANazS7X1XFn3W0SggClIPPGgv6sFn5p29ZMUoTvHg9
 UmIxPV3hfQtDNN8dF8GcGXXLuT/VOtI28+KF02HJZm5hPvtNVLf4OmfIlTsnPEHWkz5hWCG/9tz
 cmnfD5J9qwR5wz3Pm3OTi8EFd1q1fPjgXtOnXH9c=
X-Proofpoint-ORIG-GUID: S1nvZ9dF_zQws5c0CcVf3f1F9rKXvfY5
X-Proofpoint-GUID: S1nvZ9dF_zQws5c0CcVf3f1F9rKXvfY5
X-Authority-Analysis: v=2.4 cv=F4Nat6hN c=1 sm=1 tr=0 ts=694ae568 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=mhl17_9bZh8dmsMh4EsA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13654


On 12/23/25 8:31 AM, Chuck Lever wrote:
>
> On Mon, Dec 22, 2025, at 2:07 PM, Dai Ngo wrote:
>> Update the NFS server to handle SCSI persistent registration fencing on
>> a per-client and per-device basis by utilizing an xarray associated with
>> the nfs4_client structure.
>>
>> Each xarray entry is indexed by the dev_t of a block device registered
>> by the client. The entry maintains a flag indicating whether this device
>> has already been fenced for the corresponding client.
>>
>> When the server issues a persistent registration key to a client, it
>> creates a new xarray entry at the dev_t index with the fenced flag
>> initialized to 0.
>>
>> Before performing a fence via nfsd4_scsi_fence_client, the server
>> checks the corresponding entry using the device's dev_t. If the fenced
>> flag is already set, the fence operation is skipped; otherwise, the
>> flag is set to 1 and fencing proceeds.
>>
>> The xarray is destroyed when the nfs4_client is released in
>> __destroy_client.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/blocklayout.c | 26 ++++++++++++++++++++++++++
>>   fs/nfsd/nfs4state.c   |  6 ++++++
>>   fs/nfsd/state.h       |  2 ++
>>   3 files changed, 34 insertions(+)
>>
>> V2:
>>     . Replace xa_store with xas_set_mark and xas_get_mark to avoid
>>       memory allocation in nfsd4_scsi_fence_client.
>>     . Remove cl_fence_lock, use xa_lock instead.
>> V3:
>>     . handle xa_store error.
>>     . add xa_lock and xa_unlock when calling xas_clear_mark
>>
>> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
>> index afa16d7a8013..bcacd030d84a 100644
>> --- a/fs/nfsd/blocklayout.c
>> +++ b/fs/nfsd/blocklayout.c
>> @@ -318,6 +318,7 @@ nfsd4_block_get_device_info_scsi(struct super_block *sb,
>>   	struct pnfs_block_volume *b;
>>   	const struct pr_ops *ops;
>>   	int ret;
>> +	void *entry;
>>
>>   	dev = kzalloc(struct_size(dev, volumes, 1), GFP_KERNEL);
>>   	if (!dev)
>> @@ -357,6 +358,13 @@ nfsd4_block_get_device_info_scsi(struct super_block *sb,
>>   		goto out_free_dev;
>>   	}
>>
>> +	/* create a record for this client with the fenced flag set to 0 */
>> +	entry = xa_store(&clp->cl_fenced_devs, (unsigned long)sb->s_bdev->bd_dev,
>> +				xa_mk_value(0), GFP_KERNEL);
>> +	if (xa_is_err(entry)) {
>> +		ret = xa_err(entry);
>> +		goto out_free_dev;
>> +	}
>>   	return 0;
>>
>>   out_free_dev:
>> @@ -400,10 +408,28 @@ nfsd4_scsi_fence_client(struct
>> nfs4_layout_stateid *ls, struct nfsd_file *file)
>>   	struct nfs4_client *clp = ls->ls_stid.sc_client;
>>   	struct block_device *bdev = file->nf_file->f_path.mnt->mnt_sb->s_bdev;
>>   	int status;
>> +	void *entry;
>> +	XA_STATE(xas, &clp->cl_fenced_devs, bdev->bd_dev);
>> +
>> +	xa_lock(&clp->cl_fenced_devs);
>> +	entry = xas_load(&xas);
>> +	if (entry && xas_get_mark(&xas, XA_MARK_0)) {
>> +		/* device already fenced */
>> +		xa_unlock(&clp->cl_fenced_devs);
>> +		return;
>> +	}
>> +	/* Set the fenced flag for this device. */
>> +	xas_set_mark(&xas, XA_MARK_0);
>> +	xa_unlock(&clp->cl_fenced_devs);
>>
>>   	status = bdev->bd_disk->fops->pr_ops->pr_preempt(bdev, NFSD_MDS_PR_KEY,
>>   			nfsd4_scsi_pr_key(clp),
>>   			PR_EXCLUSIVE_ACCESS_REG_ONLY, true);
>> +	if (status) {
>> +		xa_lock(&clp->cl_fenced_devs);
>> +		xas_clear_mark(&xas, XA_MARK_0);
>> +		xa_unlock(&clp->cl_fenced_devs);
>> +	}
>>   	trace_nfsd_pnfs_fence(clp, bdev->bd_disk->disk_name, status);
>>   }
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 808c24fb5c9a..2d4a198fe41d 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -2381,6 +2381,9 @@ static struct nfs4_client *alloc_client(struct
>> xdr_netobj name,
>>   	INIT_LIST_HEAD(&clp->cl_revoked);
>>   #ifdef CONFIG_NFSD_PNFS
>>   	INIT_LIST_HEAD(&clp->cl_lo_states);
>> +#ifdef CONFIG_NFSD_SCSILAYOUT
>> +	xa_init(&clp->cl_fenced_devs);
>> +#endif
>>   #endif
>>   	INIT_LIST_HEAD(&clp->async_copies);
>>   	spin_lock_init(&clp->async_lock);
>> @@ -2537,6 +2540,9 @@ __destroy_client(struct nfs4_client *clp)
>>   		svc_xprt_put(clp->cl_cb_conn.cb_xprt);
>>   	atomic_add_unless(&nn->nfs4_client_count, -1, 0);
>>   	nfsd4_dec_courtesy_client_count(nn, clp);
>> +#ifdef CONFIG_NFSD_SCSILAYOUT
>> +	xa_destroy(&clp->cl_fenced_devs);
>> +#endif
>>   	free_client(clp);
>>   	wake_up_all(&expiry_wq);
>>   }
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index b052c1effdc5..8dd6f82e57de 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -527,6 +527,8 @@ struct nfs4_client {
>>
>>   	struct nfsd4_cb_recall_any	*cl_ra;
>>   	time64_t		cl_ra_time;
>> +
>> +	struct xarray		cl_fenced_devs;
>>   };
>>
>>   /* struct nfs4_client_reset
>> -- 
>> 2.47.3
> Another question is: Can cl_fenced_devs grow without bounds?

I think it has the same limitation for any xarray. The hard limit
is the availability of memory in the system.

>   What
> trims items out of this xarray if the nfs4_client is long-lived?

If the client is long-lived then the xarray used for this client
stay with it. If the client is a courtesy client then the memory
shrinker will get rid of the nfs4_client when memory shortage
condition arises.

>
> And, let's rename the xarray cl_dev_fences, since it contains
> all devices, not just fenced ones.

will do.

-Dai


