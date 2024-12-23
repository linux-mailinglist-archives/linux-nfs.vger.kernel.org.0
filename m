Return-Path: <linux-nfs+bounces-8749-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2DB9FB3B0
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Dec 2024 18:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1B3A1884FE1
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Dec 2024 17:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587831B4141;
	Mon, 23 Dec 2024 17:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VFn5PY3H";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bKpR956S"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C519170A13;
	Mon, 23 Dec 2024 17:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734976208; cv=fail; b=Y/ABSnq0MLWv1/8inpUVK4Dt9L1B/6dETe9ju/2Bp9vjH1XwHefuLFngmUvvpohhETnCNjzqVUn+TblWcC0JDM/v6e36LChxGe+Eivk883Qdc58gFbyMk7e7PZbIsYEvcNXm/HwDsvApW92UoYRS1tAEV0XtqALlgavctooq66E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734976208; c=relaxed/simple;
	bh=d2tD1t/LcAFvW0XIOjYkoWYkSuYlGeCcqQqqULy+joI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QA08wCFvVtGkqh7/JbaVt8McNYkd1zOaWKJjYd6moHhnksXJyTCxQ4EM30D/ceySsZ82cGDIq+lNCS2WQ7G1c8VOckY+RTWalk8jfdX4sUfoyVrVEFl5ZnX1TDeTrm8RbWfOV/MxVh4YQNbKLvzMvrNPD1446aA4ntqXsi83HtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VFn5PY3H; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bKpR956S; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BNGulaV030929;
	Mon, 23 Dec 2024 17:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=HAUcI/eNhVuLfy0zruLdOrq2rOL6/JO9fusBZlHov3k=; b=
	VFn5PY3HJH9cRGVLdRXE2o0sCpCJ3Lal37H1ZYUH2uQNJ674ySdIQUXAR0dC8Wmd
	V7E/N3IbXz1E+ZLuSwlK5GqapiEBD+uuYof5OM9yuWwLpmBpR8JOzlYRLB6uIc0l
	i5T2Rz/BWIGH1ZXcEnetTNPbf7Q/9+w6YukX7TO0Qm0gxJocgjIwmTqKG0B7fUX9
	Xw7mPAEihC1VsMK1sSccG/LdHME5W+BdT50kbpS4kyhA/jetdv+AE7vPEDuTtr4v
	pPQmY2EG724nGESCmP7S0cSYeVrFJbHsqjtafJCu7Ey7qx3dcIe3UIvWGHXFJgoS
	QowqVNNkbNsptuBYAR1jfw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43nq56tyme-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Dec 2024 17:49:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BNFerTH023403;
	Mon, 23 Dec 2024 17:49:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43nm47731x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Dec 2024 17:49:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QPPHnMCWor/KeCYhiv+v7bD++UNVeLmsBM7n6+ZOBBFgJzXFVw+cIUetwJ5VWDiO7UlrvDKPKd+OUCzYmIwxMbQOJxQsVoXbXdaUweDg1e3ICYeMyNjHGqNa95dmxJRwmLWDSvwxnP0YbFOsvK81NHYZRstYfSi1VflkAJ28RrBe27Hon2oXDGMjnb6/B2MMCshJGjXRENllC4ZqtlnsVMpBX3+8nMjyLjexx3caYSC6MOu5S9BRtCuwYrTiUfg0L/BT28ETCnkMDUBWO5dkoLFCNtppoS/eMPZHS/MuP+Yx77aSyFbju55JaQ2Sv9KPvXxxvXBCCG9HBtheiesSVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAUcI/eNhVuLfy0zruLdOrq2rOL6/JO9fusBZlHov3k=;
 b=ZxicTJWxISZ+BMksPNSYcXhSMW211hBxAM9GQaDDqo/vSI6+bY/XjgfShdrBZh9V6ZrxrpK8zCOAXDXjtoe1p7zEdaMgilIqQJEQlWJmLa8iiqvB2qCtq5OkAR83JQRjuQLoRbOUni0ScUMDJXHZLDayHVgDw+So0x54NNxMTt6Uz++CSz1hz+ECkYLAQVu8Cc8r+eKXz6QcjSxyQyGx9OyRkjq9iajv+LoTy0PMhfF7HPU3QVKocejzU6B2PA5DJVCmPWqARIGBduKoctAYZ5ujjKdI52OLbDOEBMVRe4g1K0zFHwHDmCKVeb4rMfBA1JGosDngPM0d+wDRVo5wJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAUcI/eNhVuLfy0zruLdOrq2rOL6/JO9fusBZlHov3k=;
 b=bKpR956SWKn1/8Kc39gfyEHp/1d/EjoaTvrY0U8ctZAMgmGntwG95Si4AOeUb/4v0uIRMaIWrKpD3BnA3kV7/FD8rRr/TBIxVO9QQWgy+Ia7h9c7bc4pA2QxiKifZTzilvEd/mHxsB02w5J/ifuydQ8BQvgQzvqBJppzZuCOHdU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB7035.namprd10.prod.outlook.com (2603:10b6:510:275::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Mon, 23 Dec
 2024 17:49:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 17:49:42 +0000
Message-ID: <d4f9d5c2-6919-421f-b1f3-bda6986e878a@oracle.com>
Date: Mon, 23 Dec 2024 12:49:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: fix incorrect high limit in clamp() on
 over-allocation
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: mailhol.vincent@wanadoo.fr, NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        David Laight <David.Laight@aculab.com>,
        Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20241209-nfs4state_fix-v1-1-7a66819c60f0@wanadoo.fr>
 <6c287aa1-9d94-467e-a85a-7b7076fc080c@oracle.com>
 <CAMuHMdXSWmkK-SDPxGGX5qJtakSTiQCUzKCJ4awtVxFxNCtr6A@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAMuHMdXSWmkK-SDPxGGX5qJtakSTiQCUzKCJ4awtVxFxNCtr6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0216.namprd03.prod.outlook.com
 (2603:10b6:610:e7::11) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB7035:EE_
X-MS-Office365-Filtering-Correlation-Id: 2378b5b8-b4b3-4202-e870-08dd237a2e0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OExzeXlIYVh4UzYrTmRWS3ZKU1c3YVBScEJFS1p6RkM0N2pDbXJIcEd3TkR5?=
 =?utf-8?B?bUF2VDBLVmZpVklRTUd0bXZqLzJidEFEajhYUXFSb1BKWkFQSGVoRG1uUEt4?=
 =?utf-8?B?YmtxcVV4bGJodTg1Nk9WQzF4MVpWenZXcnY5WjBCOFJERTFJLytyYWRaaldv?=
 =?utf-8?B?MWxvUUwzTkFQbGlGTVJmRlYyejdnSjd5SU1tTEJyV05oZHhwbkdzZWZqejFm?=
 =?utf-8?B?cFN0NndjYzI0ZFpJWkMvcmV4ZkJQSHRrUjZKNHhXcWlYbnAyUm1rd0xBUldu?=
 =?utf-8?B?ZTBZb1VxdGFBRUFtVmtlMi9oMDF5b0I4Vno0RnBQclppR3VZakdXamozdHoz?=
 =?utf-8?B?RVJ4Mk5iNmF4OHVDdzR0NGhIdytEUTgxWElSL0Z3K05qSit6YjB6NmRIWGNF?=
 =?utf-8?B?VkptMVd3c2pNYVVpZDIxdmNZR1Z0R2wvUjBMQytOYkxibjF6NFgyRllWNnpM?=
 =?utf-8?B?SGNPZHVWMHpicXNCckh2Y2dHT3I2b01LV1JXeC9hU3pZVFI4VlJQSEd2d0FX?=
 =?utf-8?B?TndXb2loaUtqbStiK29hNDh6SC9VcnArbC90Y1c2d211RUI2Wk9nMEx2Mm9P?=
 =?utf-8?B?U3RBZ2JmSERGUXNwTmxmWEd6Q1p3R1AvVkp6cFhnOE9tQ1g4cVZDZEZFbEQ1?=
 =?utf-8?B?S1NjOVpwekJhTktETzVpN1dMdWU4S01BTDZ1Qzc2OXFoY0o1RGY1Z01DQ29q?=
 =?utf-8?B?V0YwbmNaRE1tcW4zaWhlUDFSR2ZjS3FEcnhjd3NkWVllRmFCMHdmbDg5OWhm?=
 =?utf-8?B?WUZiR21ZTWg5bzdKbGFLdkJ0dkhha0w1Zkx3enQ4RGV1OW93WHZHd3hkVWNi?=
 =?utf-8?B?TnRHZ0lOeEh5TVB0bktCWmJDN0hiRW5ZQys0YzczY3dtUExvRE9taHdRR0dF?=
 =?utf-8?B?UGJmY1B6TTd0dy9XZVZGU3k4RitUcnRmTEVMZXdJaXVBbjltQmZNU1hpRWtx?=
 =?utf-8?B?OGk5UmRJbC93anhWOTZ6dXA2VGRWZjVVNHVRQ3Q4bm5oc09NMVlOUmZYUG5C?=
 =?utf-8?B?bzVLNk05WmRzdERCMFdsQitrN01CK2I4eHZaZlE2OHhmYVcvVWxvbjRHOSt0?=
 =?utf-8?B?aHpLYVhVYVBpSnpWSS9WNmoxbHZ0VWZEbGZkcHNzcUhsS3NFQ20vZmt5by9n?=
 =?utf-8?B?alRqUzlWMlhYVlVTblhlQ3NwdmVxL0VxTlo5Y25tUW5oS1YrTjVQZTFOd3VG?=
 =?utf-8?B?OERHbmV5VmE5UGhQKy9JUGRuZk1jKy9YUWJVa0ZEcTE2TE5BdDYrQTQrVWlw?=
 =?utf-8?B?MDNsZWtGOGNaVUdHRW5yaDdPZEJWdWZsSTRXMnRuRE5FL3hFVFQ4bkpFOEVK?=
 =?utf-8?B?L1Mzd1RtdEhLdXNQSFlrVWRPMHIwZWxISUIzL2Y3QmJ0YmtSVDZ6cjlOR2U0?=
 =?utf-8?B?TXByeDNsSVVYVDdqdGdwdTdmbGJCL3pVV1EvTURwK1lTR3Q0S0NXbExrVDN0?=
 =?utf-8?B?Q0UraThzMGZqb24wM3FsKzh1Rmloc2ZsR1d3ZTY0R0hNeHZwQ3RIUjBrVVVl?=
 =?utf-8?B?c1VtNHh5ZEtSQk9EdTFoeEJIOXNPZStlWkVMT2VmdXVmb0ZIWHBVMDBFTWVr?=
 =?utf-8?B?RWloOENBWUduZ0NscXJFRTRHVDZENjdyN1lWc05GZGFmQkdEaGIvczVKRW5Q?=
 =?utf-8?B?dkFRd3Y0OGdud3l1bUJFQWMva3lCcTBuZ1RWOWV5RHRtc2RWUGhLZ3FrRktN?=
 =?utf-8?B?QjFaL1VvWit5TWMvRjJ0dit0aXpGRzNqQTlGQTFXaEdWdno4bCtuQXA4Nll0?=
 =?utf-8?B?cWRxQUpub0lOc1JrVmFNKzJ0SWsycWRaZElna3E3VlF3eGhlTnBkWjdVdEJy?=
 =?utf-8?B?RUFRLzNUcDlBeFRrSXBMYXZMblpHaTM2aDRoejB5Z1pxYzBscWhDTVJ1VGRQ?=
 =?utf-8?B?SlY2cmU5QnNxdVpjZFpRNmlUd2NCNDZBcU5tdTRSUTM3OVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0RSSWJZNzlPeTZ3STNxdVJEczVhcERCVFZ5cmlpMmpOSHBRdFBwOS9PcXlW?=
 =?utf-8?B?TzAvVUJESlJsM2NHamp0dDF6ZXlWUXhNY05LTHp4N2ZxUHFLVzFOV2VmOTRD?=
 =?utf-8?B?Wm5IVndBWFhTWitZYXBHRDljNWlISi8ra2E1dHkxOUtTZ05LcERzRW41eG1D?=
 =?utf-8?B?cjJCckhZUEhydWhtRWc2Sm91aVJQaVVuekxmTU9OdlFXbi93d1NiY3F3MEx3?=
 =?utf-8?B?ZllPRDNlV3NjV0dDMG1nZWFHY3RJYzlWSzJROUFxUys3Yytpbm9xTjJJdERu?=
 =?utf-8?B?WlE4MnVPNTVZRGdMQU5DMXladnBrZnF1VnZ6WldVaHlXU1VNYlZKZnk1eDFo?=
 =?utf-8?B?NXp5MHpMcE9GakllQ2grQUYzREhaZ1VPamxGRDFrSGo1dTdPV3N3azhrTWVy?=
 =?utf-8?B?Q0Y5TkJ0YTZybG95eDRKRG40ckxveTZvZlp6cU11S3FjWkV1THNSTEZIVU1r?=
 =?utf-8?B?Qm5rZS9qZllrRHhRVVRvNnIwTFU0VVN6SlhEaG9LOUxTY21LWGhjQXV4YmZx?=
 =?utf-8?B?cXNLYUdnSk1yOTBhY2htZk84MnE5VStvMFZqNWNxRDE4ZUxVOEVxOWVRZWZ0?=
 =?utf-8?B?TnVhTjY4K0w3TnN4SnhjNWtBZ24wV0U2aCsyNmI3TnNGTjB0Y29XMW40Vlh0?=
 =?utf-8?B?dFkzSVZ0SU9sdjFlQzdRWVlhcG5xVjFNVnhtZko4alJCY25KU2ZWRWF1MEVK?=
 =?utf-8?B?T01DSWR2UnkwZzJTeWMwSlltT3YzNXNQMDE5NFNuZzd4d2dOaFZpalFybFB2?=
 =?utf-8?B?cnpkUGtJMnBKTllybmRYTjNxWkdqaGxSeXJQTWlYdHNvekYxOCtsZk1wRWR3?=
 =?utf-8?B?VGhLQ3A1OW9VektVZTNhSWpjTDRUZjRXeWljdnBITTBpREJMYUR2d2IwSWtX?=
 =?utf-8?B?OGJkSVd5RzhHTFZOaVRLaFhoeWsvYy9DUnIxdW9ReDNsa0lVMzMxOHZuVTNB?=
 =?utf-8?B?cjlZOS93RS9NcEtCZnh3Q1lzRVBTUFN1NXNqalEyWDFBanVFQXlCaXFtNVYw?=
 =?utf-8?B?WnpHWElLYllaNDFrY1lzOTc5S3BFc0xwcG1mTGxKc0hJRkJxb3BaTU9RbFBh?=
 =?utf-8?B?aEg5UTBWK1B1aEJCZUUrN2Y1UDhqU1A0M0kzQXZtcmZMNDFHVmx0N1E2QmpV?=
 =?utf-8?B?L3BXMVVBcVBFcHdpUnZTelgxTkZPQjBBVVNmd0RtcWRzWXhqalo4U1YrbU1y?=
 =?utf-8?B?Q1Q1YXB0Q0NyQjNucEpvVUFidTZIM1dTTDR5cmVwRnU4WG5lc3FHTkhnNGxH?=
 =?utf-8?B?UWIwNFB5UTVJRXpCeVUvSmxzTWY2RCtWSU9KNWdGZWVDTzBXSmNDYncvL08x?=
 =?utf-8?B?SXcyRUVudURYQ09TV3RFRWVXc3NMQ0xsWU43K1VGaVAxZUJlTnlvdXdhaHZI?=
 =?utf-8?B?N041ZXJzUDByVWQyekxpcFo2RFRyMUc5dzRkOGc2ZXNTeitPVWxSYVNtTTcx?=
 =?utf-8?B?WTJHa1RKckNiYVR6MXRpeFJGb3V6UEtHcGhETjNWdVQ4bkJDN00yVGJxVTVZ?=
 =?utf-8?B?WDlpZktoTG1ISktnWTdMQTFsSCtTcFdkNHJjMmRFdHp4Z1VZY05SS0dEUFRZ?=
 =?utf-8?B?bDJkcUNuMllFQ2huQkxhbE04NVJrckZpMlFrVnZjREJ5K1VET0VNNnBaMDJs?=
 =?utf-8?B?aHFPL0t0MUlCYmp4RUR4c2U2dUNVWk5meDdWWmhFU0tZMFBLRXhpbUp5L0sr?=
 =?utf-8?B?YlkwL21GUEt0YWVtS3FibUU1RjlaVUwzRnFHOFlENWhucEtzSUFBMkV2M0d1?=
 =?utf-8?B?QkJmZUVMc1o3aiswUm9GVjZRaFhvVEQ5VkFzV0owWXRXZi8yL2xnZ3NzWGZ1?=
 =?utf-8?B?MFA5VzJwVkRjcVNGTnJoNDl4OGcwZThmM1Boc211SnhoVUJvSWdRWUlvY1FK?=
 =?utf-8?B?QUVGMm5nb1NFeDE0RHJkTlR1OUNFYlNTb2prV3p4R3k0WHZVWVdQUEV3Y2ty?=
 =?utf-8?B?M1VvVDI5TjBjOFVJMEJPemxWYjVvaHFveWZKRFZ1a1lsZkpvRWJaTlRrTHhu?=
 =?utf-8?B?L2phVGxSdnhSNWVzNzNyRWdIZldBOGpVcXRTaTRIVUlORHZLYXNsNlBGR0FQ?=
 =?utf-8?B?MEQ1NlkzdXh6cDJrNWQxL2Zob0tCd1J2M1JmRmxhT3phTHBBSTNhY2NranFv?=
 =?utf-8?Q?vCVuiYApk1i5CmNjEVlEkU+Hc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bqvpnCWkApmKc36n9Ut5ruDI3ox1K/UuEqGMSkjV+SlZvUNaLI7nYtdMRVDGhJMrIgnzAZT1iOHIxIMA1eMlmu9gCwkHMD7mGYH6BvZCTBKrkJYdjuZkdEbRqg1J+0nSfEU7HJAy8ltq22Eb6UtoDZ4O2HmUqbIiQIqGI/vNiDFOmZ+F4T1fs3zXp2vZ19mahx/l5eWrBOU9eweigDTdLQBroruzpy98/w4MED1vLbCQbUfGJYY2RYMQq2Am3E/cCbm4wt25ww0MJPu4D/v1ftbiXRN396/kk7wARi+5VszZwOr088gbD1q4Oat9taQpncVWxYAwBlxrU59U10idY2CHFkFkwVtSH9N9PSrKlR7O4Fkt8pliwQLJKSaoU3stbPeSDMpHcwAIsRXcg7wyCL+jSGHNm8FcLB105iHUEMMX9Zzoo72WBYV3QTe/EcmVXQPg6QU+cU2UezNaZQnPMOdeq5CjJkyXiF505FT4hZMSAeaXtCFr+4MOfJ0vbG+T2mOcXqunJ5KlsfMkezaQ3PHEZ0BSw87uOy12OU64353qzS9nuTy7DfkU5FnmlWiqyATeQCgntmfM/ufZwZ96vpeIhpJ79nvqR6BQAia2fW0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2378b5b8-b4b3-4202-e870-08dd237a2e0c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 17:49:42.4826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N1Zq/beiXvP5nfFFk5bSbw6pzC+doP67KbnZYuQCk7g7ANZqVh0rGRgJn6i3ERZfO5BZ57F77ToGmfdZKF8Xkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7035
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-23_07,2024-12-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412230158
X-Proofpoint-GUID: ce5RjMGW2Y2I1hodI_GsSqjRc7CQ0Syr
X-Proofpoint-ORIG-GUID: ce5RjMGW2Y2I1hodI_GsSqjRc7CQ0Syr

On 12/23/24 11:06 AM, Geert Uytterhoeven wrote:
> Hi Chuck,
> 
> On Mon, Dec 9, 2024 at 3:48 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>> On 12/9/24 7:25 AM, Vincent Mailhol via B4 Relay wrote:
>>> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>>>
>>> If over allocation occurs in nfsd4_get_drc_mem(), total_avail is set
>>> to zero. Consequently,
>>>
>>>     clamp_t(unsigned long, avail, slotsize, total_avail/scale_factor);
>>>
>>> gives:
>>>
>>>     clamp_t(unsigned long, avail, slotsize, 0);
>>>
>>> resulting in a clamp() call where the high limit is smaller than the
>>> low limit, which is undefined: the result could be either slotsize or
>>> zero depending on the order of evaluation.
>>>
>>> Luckily, the two instructions just below the clamp() recover the
>>> undefined behaviour:
>>>
>>>     num = min_t(int, num, avail / slotsize);
>>>     num = max_t(int, num, 1);
>>>
>>> If avail = slotsize, the min_t() sets it back to 1. If avail = 0, the
>>> max_t() sets it back to 1.
>>>
>>> So this undefined behaviour has no visible effect.
>>>
>>> Anyway, remove the undefined behaviour in clamp() by only calling it
>>> and only doing the calculation of num if memory is still available.
>>> Otherwise, if over-allocation occurred, directly set num to 1 as
>>> intended by the author.
>>>
>>> While at it, apply below checkpatch fix:
>>>
>>>     WARNING: min() should probably be min_t(unsigned long, NFSD_MAX_MEM_PER_SESSION, total_avail)
>>>     #100: FILE: fs/nfsd/nfs4state.c:1954:
>>>     +          avail = min((unsigned long)NFSD_MAX_MEM_PER_SESSION, total_avail);
>>>
>>> Fixes: 7f49fd5d7acd ("nfsd: handle drc over-allocation gracefully.")
>>> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>>> ---
>>> Found by applying below patch from David:
>>>
>>>     https://lore.kernel.org/all/34d53778977747f19cce2abb287bb3e6@AcuMS.aculab.com/
>>>
>>> Doing so yield this report:
>>>
>>>     In function ‘nfsd4_get_drc_mem’,
>>>         inlined from ‘check_forechannel_attrs’ at fs/nfsd/nfs4state.c:3791:16,
>>>         inlined from ‘nfsd4_create_session’ at fs/nfsd/nfs4state.c:3864:11:
>>>     ././include/linux/compiler_types.h:542:38: error: call to ‘__compiletime_assert_3707’ declared with attribute error: clamp() low limit (unsigned long)(slotsize) greater than high limit (unsigned long)(total_avail/scale_factor)
>>>       542 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>>           |                                      ^
>>>     ././include/linux/compiler_types.h:523:4: note: in definition of macro ‘__compiletime_assert’
>>>       523 |    prefix ## suffix();    \
>>>           |    ^~~~~~
>>>     ././include/linux/compiler_types.h:542:2: note: in expansion of macro ‘_compiletime_assert’
>>>       542 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>>           |  ^~~~~~~~~~~~~~~~~~~
>>>     ./include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
>>>        39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>>>           |                                     ^~~~~~~~~~~~~~~~~~
>>>     ./include/linux/minmax.h:114:2: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
>>>       114 |  BUILD_BUG_ON_MSG(statically_true(ulo > uhi),    \
>>>           |  ^~~~~~~~~~~~~~~~
>>>     ./include/linux/minmax.h:121:2: note: in expansion of macro ‘__clamp_once’
>>>       121 |  __clamp_once(val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID(h_))
>>>           |  ^~~~~~~~~~~~
>>>     ./include/linux/minmax.h:275:36: note: in expansion of macro ‘__careful_clamp’
>>>       275 | #define clamp_t(type, val, lo, hi) __careful_clamp((type)(val), (type)(lo), (type)(hi))
>>>           |                                    ^~~~~~~~~~~~~~~
>>>     fs/nfsd/nfs4state.c:1972:10: note: in expansion of macro ‘clamp_t’
>>>      1972 |  avail = clamp_t(unsigned long, avail, slotsize,
>>>           |          ^~~~~~~
>>>
>>> Because David's patch is targetting Andrew's mm tree, I would suggest
>>> that my patch also goes to that tree.
>>> ---
>>>    fs/nfsd/nfs4state.c | 46 +++++++++++++++++++++++++---------------------
>>>    1 file changed, 25 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index 741b9449f727defc794347f1b116c955d715e691..eb91460c434e30f6df70f66d937f8c0f334b8e1b 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -1944,35 +1944,39 @@ static u32 nfsd4_get_drc_mem(struct nfsd4_channel_attrs *ca, struct nfsd_net *nn
>>>    {
>>>        u32 slotsize = slot_bytes(ca);
>>>        u32 num = ca->maxreqs;
>>> -     unsigned long avail, total_avail;
>>> -     unsigned int scale_factor;
>>>
>>>        spin_lock(&nfsd_drc_lock);
>>> -     if (nfsd_drc_max_mem > nfsd_drc_mem_used)
>>> +     if (nfsd_drc_max_mem > nfsd_drc_mem_used) {
>>> +             unsigned long avail, total_avail;
>>> +             unsigned int scale_factor;
>>> +
>>>                total_avail = nfsd_drc_max_mem - nfsd_drc_mem_used;
>>> -     else
>>> +             avail = min_t(unsigned long,
>>> +                           NFSD_MAX_MEM_PER_SESSION, total_avail);
>>> +             /*
>>> +              * Never use more than a fraction of the remaining memory,
>>> +              * unless it's the only way to give this client a slot.
>>> +              * The chosen fraction is either 1/8 or 1/number of threads,
>>> +              * whichever is smaller.  This ensures there are adequate
>>> +              * slots to support multiple clients per thread.
>>> +              * Give the client one slot even if that would require
>>> +              * over-allocation--it is better than failure.
>>> +              */
>>> +             scale_factor = max_t(unsigned int,
>>> +                                  8, nn->nfsd_serv->sv_nrthreads);
>>> +
>>> +             avail = clamp_t(unsigned long, avail, slotsize,
>>> +                             total_avail/scale_factor);
>>> +             num = min_t(int, num, avail / slotsize);
>>> +             num = max_t(int, num, 1);
>>> +     } else {
>>>                /* We have handed out more space than we chose in
>>>                 * set_max_drc() to allow.  That isn't really a
>>>                 * problem as long as that doesn't make us think we
>>>                 * have lots more due to integer overflow.
>>>                 */
>>> -             total_avail = 0;
>>> -     avail = min((unsigned long)NFSD_MAX_MEM_PER_SESSION, total_avail);
>>> -     /*
>>> -      * Never use more than a fraction of the remaining memory,
>>> -      * unless it's the only way to give this client a slot.
>>> -      * The chosen fraction is either 1/8 or 1/number of threads,
>>> -      * whichever is smaller.  This ensures there are adequate
>>> -      * slots to support multiple clients per thread.
>>> -      * Give the client one slot even if that would require
>>> -      * over-allocation--it is better than failure.
>>> -      */
>>> -     scale_factor = max_t(unsigned int, 8, nn->nfsd_serv->sv_nrthreads);
>>> -
>>> -     avail = clamp_t(unsigned long, avail, slotsize,
>>> -                     total_avail/scale_factor);
>>> -     num = min_t(int, num, avail / slotsize);
>>> -     num = max_t(int, num, 1);
>>> +             num = 1;
>>> +     }
>>>        nfsd_drc_mem_used += num * slotsize;
>>>        spin_unlock(&nfsd_drc_lock);
>>>
>>>
>>> ---
>>> base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
>>> change-id: 20241209-nfs4state_fix-bc6f1c1fc1d1
> 
>> We're replacing this code wholesale in 6.14. See:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=nfsd-testing&id=8233f78fbd970cbfcb9f78c719ac5a3aac4ea053
> 
> Bad commit reference?

Expired commit reference. That commit lives in a testing branch, which
has subsequently been rebased. The current reference is:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=nfsd-testing&id=94af736b97fbd8d02d66b3a0271f9c618f446bf0


> And hence this is still failing in next-20241220...

I haven't moved these commits to the nfsd-next branch yet.

Is there an urgency for this fix? Is this a problem in LTS kernels
that might need a backport? 94af736 is not intended to be backported.


-- 
Chuck Lever

