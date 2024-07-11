Return-Path: <linux-nfs+bounces-4832-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 277F692ED94
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 19:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C6BF1F21064
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 17:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786C116D9A6;
	Thu, 11 Jul 2024 17:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XkQie1YK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e6NkYgx6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4913E16D307
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jul 2024 17:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720718107; cv=fail; b=Nv7CEfifhmZm5IvtjpLLT/dDGw08Cxr5OOT5tvjKXHNL74yafCGo1gfFXw/fnV1lipkuxPa/z2L2DbI6ngF9qC3ecG8x4G66ZbAIoBfRBCTCAcIP6PnpKmADCRMtDB5un68t/k+r6MI4/zefX90DPdrzsWh8u04xv06hhXhCTOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720718107; c=relaxed/simple;
	bh=7o98dmHs+TxMgPN1r7SnHloHGMMZrPcb3vZRZs2RqTs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UGIkIh5I5vVWC7c9CGYkRhxg1JLXQvWpwdSFmfk/W3X3NXZFS/hkRvVt+7Xe8P75x/k41PdNV9Q8VOiRdV7wCS02hChr8kPEcbloAfkqFVLqTRWO0HqLuvqdq8dN25HnxS1XBw+muE2Fgmn1Gu7h5b4h+SJ04KGggC/CBsKEAJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XkQie1YK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e6NkYgx6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46BFBW9G010296;
	Thu, 11 Jul 2024 17:14:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=7o98dmHs+TxMgPN1r7SnHloHGMMZrPcb3vZRZs2Rq
	Ts=; b=XkQie1YKJbE9z26lDYCLMtt1VC62eDNF70jJ74izkQtXrDwrVMOznwvRa
	oUAe8Z8gMea9g79Bn20ZuWGDUewxJeIZM8ZFaExfsh8ApacfqApNKUsk3pRF3YEq
	8FotuIGeHa1hjyKJPCX+O3YxK5bQ0KKQikzxR+ps6RKK/vdltxyGx4+Ach/FIUQ5
	udWEvQVIPsT2eGhwBQEA+I2Dxg/COTVw34456iRtfjEtfxTy3+QLN8nQgUi4qvxU
	9seAZFpV0D/dNRhF3WMpUlblfMGMt+QTpe1HpKJVFvmGOe98CR5ujyLWD1c5NjYf
	NOqbznKX8R9+fKKp5zxXv2Kx4NeJg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wt8j23u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 17:14:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46BG0L4W010640;
	Thu, 11 Jul 2024 17:14:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 409vv627p3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 17:14:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wWKrrz0PHHs55BnX80UVqxR5GCc+3hvq5xOgTq027nj1waDJNevjbHOf1xmRjs8ucOrc7pA4t1cPJMxrPYN01dpijWUpogvHupjFy8gKotmgkxWYqlal+s4K8m23gQ1yGVVbNJqGsm8Z6qES4Mui3IPLNRIt0KP3p8aExAS4HNGpPQaNn/GNnKHrgKoOdrDewkxx7LvnYVIWzfo0YG0JFsC/D6TIE8Q7FzUEjki4UST96yzaqN8bEhabqThSnvczzkYFW8hJ4swbygLxAJx6PsSUZvstWel8OPDVNEmZHSqDACjbxf/ydXoM2stLNfJUKkrutLg29Mubg7smTZiNlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7o98dmHs+TxMgPN1r7SnHloHGMMZrPcb3vZRZs2RqTs=;
 b=NaP477BQle0iU3hUr4qMIEwfv6F862KfdgXME8TuP/OOLnSInFPLYVaxvHT0KOjaJRR42Ui1/A7c1+poeV6PtJzyOozhoYW5UWZnoMsO6T2KPShM+0Xk1u5rDSXj2Hm/jAGSMg445j766Rwce8QHrWeU/1qtFkuDZ5R7Y0lexhmeqwTUjaLUW4j4xYsUVJm3xufJ3FmbTb0uK8gwl0g5KUMuSYeKPJe6XVMqDwawGbVG6s32ZqTcKWZWTmNxnadaO5edvY9qtSU0If2wkp7/wxq55CVpUOYnB5I76yequczQ3g2B+1FM895Y09CPkqnt/i24mEX9lsTWScyQerecGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7o98dmHs+TxMgPN1r7SnHloHGMMZrPcb3vZRZs2RqTs=;
 b=e6NkYgx6U/oQl3GIbbbV+pYgH4to5KklX7YcIDfsdlnBflOPpkodMgNOJhaIvL1YT2KDm+5RhKnpMIywJGuSzXL1RICR3X5G6yYAkpNcFhntd8SlYnqJQA8PwlPIkmz3FuiQdQvkORKBttTztP888YT0KrBORdB3pQaU1XVsX9c=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB5673.namprd10.prod.outlook.com (2603:10b6:510:125::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 17:14:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 17:14:54 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Benjamin Coddington <bcodding@redhat.com>
CC: Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker
	<anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: Fixup gss_status tracepoint error output
Thread-Topic: [PATCH] SUNRPC: Fixup gss_status tracepoint error output
Thread-Index: AQHa06Zlmua5rY536UGCdGYX4HOZRLHxpqaAgAAFuQCAAADSAIAAAkYAgAAU4QA=
Date: Thu, 11 Jul 2024 17:14:54 +0000
Message-ID: <26BBE6CD-578C-4E38-BE22-1CDFD4EB2374@oracle.com>
References: 
 <27526e921037d6217bdfc6a078c53d37ae9effab.1720711381.git.bcodding@redhat.com>
 <Zo/6G7ANcWEWkd0l@tissot.1015granger.net>
 <C3887ED2-B331-4AC9-A73B-326D7DDAC5FD@redhat.com>
 <2799ECE7-E3D9-45E6-9B47-47934B38A284@oracle.com>
 <057A51C2-DE21-4B66-9901-D360AADA756F@redhat.com>
In-Reply-To: <057A51C2-DE21-4B66-9901-D360AADA756F@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB5673:EE_
x-ms-office365-filtering-correlation-id: 8dc51945-9435-44ab-9ffd-08dca1ccfb8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?TXExUlBqMGNjQnZ1YU52c2lQTlE4bVpqQUtYdDNycm5XTU4wOGk0bVRMTWNQ?=
 =?utf-8?B?eEFCVzhzU2xHVEZLaWlCc2RlTmhpVlhmYlRtTURiUUJOU1Rod2piUlV1dWNM?=
 =?utf-8?B?WTRqMnFWdzZsMWM5S0hoY0d1VVlhR2ltNER4VmM0cklkbTJiaTlTNTNYc1Ro?=
 =?utf-8?B?SDlBazFiem44cDQ4ZXJxb2NaeGZiM2QrSlMwazFhNDRDNkNnM1orM25zQVBM?=
 =?utf-8?B?R1gvcC90amdwcXEzejhoRWxNSUxhTDQwWEIzRTdQV2VPSCtuYm80WXZ2ZVVU?=
 =?utf-8?B?SXcvWUdPNDhZbVNCOW9LTER5WGhCbjZvZjJMSFJkRlFpZGRjT0tLQWFUSkww?=
 =?utf-8?B?Z3I4em0veTJxYThoRFRvU1VCYzVCYVFLL1R2TUZaZnpqTUJ2SEVMWFNEWWw0?=
 =?utf-8?B?YXhqWlBwSmtMVzVlMkpHWGhTZ01HbnBIbVBUaElXL0hacUtuQTR6dVNnNEps?=
 =?utf-8?B?eExVQk9XbFlSOTZuZkp3UWNLS2tDVHRsMG9uRWRJcU1iUzhtcUZnVUNtOVpa?=
 =?utf-8?B?QVdIQ1dQaWlpa3E4ejdTTnZRQTRqelRlOFVEVEM1VnIrNXl5cmFQcTN3bmhl?=
 =?utf-8?B?bzRTSklSSjdYVmNZR0FPSVJJbU1UK0J6Vzc4eTlJQjFvN2xaOEh6N3hpQW9U?=
 =?utf-8?B?VHdxVDVUVXJhdlVWRWFHY25VQlFaQUg2Z0lDcUR1NWs0cXROU3B1UzBTL0x6?=
 =?utf-8?B?U29GRVpic0s2LzVyQm9lYittT3lrVkk2N2JoanpIS0Q0SjdDQUN5L1dBa24v?=
 =?utf-8?B?cTl6b1RCbXRjL3BtL3NZZzZ0L2s3Y1YyS0t5ZDViSGxjVm51SDBNNXNUUUNS?=
 =?utf-8?B?MFM0ZzZqTHgxK045YmpMVnFsQi80YXUyeFBzWXJaTThTd09zY29BU3dlMUZ0?=
 =?utf-8?B?NkVqdFd0UnJ3SkVxQy9OdzRsUTZhK040dGowdFRJWHE1c1BPL2o4cGgvTG4w?=
 =?utf-8?B?SFNQd2E5Z2tGR2tsVnRDRWFQTmpMZEF4dDY0RGZCT29BRGNPaXpvS3dHTXNI?=
 =?utf-8?B?WHE2bXkvOHFTMGhMNGNZQktSeWFqblVva05rWFhvcFNiSER2YXlyVDEvTVRk?=
 =?utf-8?B?QlpUZVZmQVRXL3Ivd0NNOEl0a3k0NmZldUVpb29SUFJWdU00VEhqRHNzRkNP?=
 =?utf-8?B?T0RJMTB0SDBPcFI1VTIwaGZqR1NZUXpGNGhlR3lJZTJSOXBYQzdOSVVibFAx?=
 =?utf-8?B?YXJFWVRBdWZrSTgxRCtqV0RBUEpDSlJ3RzVacWlhZUtqQkdzYVM4aEM1cTlH?=
 =?utf-8?B?bXBtVzJUQ1A3anBNRzBqcVdTN1ZrR2JXT1dIMHZSYWV3MElycjFxdEdPQmRQ?=
 =?utf-8?B?bE8zYkZWTytEM09IamxZK2hZLzVWOW1YQkZ4V0N6UXRCVnd6aElvQXVGYkh4?=
 =?utf-8?B?VkRxYUMySmNsZkt3cG5kT2RJT3dNWWdoVHVQZjkzREU0L2k1K3RwVnAyM1ZK?=
 =?utf-8?B?MGJyL3huTTFUQlRZcDk4aGRXZ0t1TTZBUWhDV0ROZkFZVkVyWGNUeXhOSllI?=
 =?utf-8?B?cS9IS0dsckpWL1p2L084d29mQUw4WGFtd3N0eFljWjA1RHBDR1pQclZDWFNl?=
 =?utf-8?B?Ti9KRHIxaG1zeWRQUCtGbkJMT3VxVjROUlBoL3M1ai95SThoUFB3QVg0eFQ0?=
 =?utf-8?B?OXlJa1IwdGRyWXBZYW5DcUhVc3Zjbkt3WjFyM3pad210MFFiRmxHOFNLUGZU?=
 =?utf-8?B?SEdMaElsSm5sODV4RHVHMTZRSHpvSzZGMVFaVWZmSm80QWc0TEQybnVqRkVq?=
 =?utf-8?B?VjVla25JZmkyRFN1MXpJSmlvUVJtbldUbVBvdUZ3Z3hkZEhuQ2IvTXVaMGEx?=
 =?utf-8?B?Q1A3anQxT3MzQW0vYmhOZ0xDQWc4WkI4MWVITHI4Y3NTUlkrWS8yRGw0NGVC?=
 =?utf-8?B?U0VBMnp6aGFtdkRZdWhrWG1MdmlERFhycEMyNGtONFRZa3c9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WGN4d3RRUCtWYmlWclZFTUpXV1V1YzR2OEc3WGdHd2hFcS9PRlJOaFVSeFFU?=
 =?utf-8?B?cnNjcER1bVNybFRJVWVuYm5JcVcxWHhBQmVXeU1LZUZzendFRjR5ZDlHT0xx?=
 =?utf-8?B?c0RJUms3SFZ0cVUvd3drVzlGeEN2cFFFZkUxVVFRT1hVakpjU3VSdUR5TUhi?=
 =?utf-8?B?RUhWT0NzYlVtMzl0SEFaMFdYeEh6VGV0ZFFDVkpjWTVUU0h3YVIzRHo5bGYv?=
 =?utf-8?B?SCtER0Z1ZlhndHp1WGVzbzVNNzNkVTFEdjN6OG9kOWhTaUpaak1LRk8vYXVN?=
 =?utf-8?B?Z1BXbWxwbGhTYlI4SFFueUFBUUwxb2FCMFBQRElGdUlVQ051VUxKa3RTTHBV?=
 =?utf-8?B?ams0dXk4SHpHZDA3UDB3bUJuRjl3LzV0dUttUXB0dnp5L29FNXNmM2h5MFNP?=
 =?utf-8?B?ZnF5ZVZIMDYvSFF1alIrREJCNVQ3L0xmMWVSenJaRk1BcXZRZzdMWUQ2cTJI?=
 =?utf-8?B?MHhFMXZ5eUxaTzlSOWhTVGJqVVNnY1ZoMGRzS0lQMWVJRkVWRnJhRDhpbGx6?=
 =?utf-8?B?UWdGcTViMWo4VmVWNjk4aVJxRW5MSTZibzhid3JabnIrUFU2RTVFOGFlL1d4?=
 =?utf-8?B?NWNEdjhoUnlqN1c4UkVXQVB6NDFFaWZWVmNqVS9NSkxxYys3WkJkVWFHNFph?=
 =?utf-8?B?R1p0OEZaeExKL0RUUk1EL1A5eGxudHZ3bk5tZzZ4L2l3UTV5S01iNVNDYlpp?=
 =?utf-8?B?VWc4SFJqNkJjT2pwNmJ6MUtZeHFBdkp5MDdFWmFXaWhKT2pkVnNnTGs4bDJC?=
 =?utf-8?B?dnpSaUhoc0R0dDczWlFOaTN2cWo0SVp6MEFZWUNmWkFMY2U5czF5QjF6cjA0?=
 =?utf-8?B?MG94VUtla3Voc0hkRmVCSUN4OHRBd2crRXljY29wN092cTdTb0Y0QkZPZS8x?=
 =?utf-8?B?dU8vb2t3NWtPVlhWT1BTb2Z0YmFJUHEyd1lORjdiRHY1UmsxSzQ2NURGQVV5?=
 =?utf-8?B?TUk3M1Z6c2I4cHVERHJVUTkybTZFbWZjNjY0aEtuWUd6N3BjM0laR05XcHpu?=
 =?utf-8?B?N2hBenhqY1ZMeEZuNURIaS90SmxvRjR0ZXl0S3RGS2FXcXY1WmF1VWtwTjBy?=
 =?utf-8?B?eUVSR1pna3Z0SUc4dG1UR2JjdnprSkdFenV2bWdldDdwYUtwUDRGRy9nSm1I?=
 =?utf-8?B?OXRodWxXYlBrelU0d3JmRURJUjAyVEwwWUNBWjkycHRKUWhRcW5LU2RLUG1W?=
 =?utf-8?B?eXlIKzdoK3F1WnFCRDFKWEMwT0QvU3QyVFBUelNUeHFIOXZpTHd1SDJSUi84?=
 =?utf-8?B?TXh3Qzk1bjhDOUQva2ZTcGtLTVorNCtyN0k5b1VzbGI3dTlVUVdjSno3Sy9S?=
 =?utf-8?B?MlBQdDA0ZndSdC94K1p6VXZIalUybGhaQUtoZldXMm9vMjA1eDRwcm5naDNC?=
 =?utf-8?B?UWVHdW1Cazc2MzV6M3VQSDBXQ1Q2KzdYZEZmaUpmNHZjOXMrbWlFUURSZjdO?=
 =?utf-8?B?KzZzNUxMOVRMNGF5VzdJQ1ZCYTJBL0NnRnpaN25aZWgvSWtSWEo3ekNGUGt3?=
 =?utf-8?B?aE5tYkh1U0V4ckhrMWV1a2draTZyZjNVM0J2N2VWdnJ5Rmd4Y0tNR20waGNq?=
 =?utf-8?B?Zy9DMXcxRmQxSWc4VzhJazhybldScW82REpyM2loQ1Q1N3hZaVZDVDRVdFdX?=
 =?utf-8?B?TmYzN09PQWkrSnBldG12MWRNL280bGNRS2tORVpaYi9pU3E4QlR0K3h1U01J?=
 =?utf-8?B?OEorc29GZ3p4RFM3aTdSRklVUk5iRXNSdGVUMjU2N1ZlU09YN3VHUzJ3SUs0?=
 =?utf-8?B?QUtRNGk4TTEwL2I1RWNpQjlJemJpbWNBNk50eGs4anFrcGRDakttQWZkSHYy?=
 =?utf-8?B?bW11cjYvenRCZElBYmp3bzE1OVpjcCtqdzJZTkF2V1RDMkZ4RXdqWXBpdVFM?=
 =?utf-8?B?NWp5MkF3SjNaa1BIa1BHVGRvcWU2MmlKY25kMXovSDMrQmd0MzU1L2hHRjl4?=
 =?utf-8?B?NHRreGlLaVZVNFV1V3JvMlkxdmU4YnU3TzBnNm55RHNPaUU3dTk3dXBacU9w?=
 =?utf-8?B?WUNTMnZEeWppcG9tcE1hdDdWNGt0K2M0ckY5VFdoRDUvb1A3ZVJ5akUvUkhP?=
 =?utf-8?B?Y0Y3NDYvbzRCeXBqUzZlb1prWXQ3VGdJOSs2MVBSMGdHN25hT0RUUmhpTWhN?=
 =?utf-8?B?aHNVUlNpeW96blA2amhPbms4VlEzMFFlRnNtRm42MDJHNGhsdTF5TDFBZ3dG?=
 =?utf-8?B?MVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <19EE75B92D04F84988B844D2FFF228AB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	OTs/7R2XYRF3K0MqIg+dfFvpOwAA1MZbZN2n+7nEYMH9DAq1dI2o7SGoIThxeskK1ZTO541vup7vmEZKkeDKyFGJGogbYG2wVeIFK8jQFn/1VDDxBvgzkOtLZH3ljTE7c7jS6MjsKp4JzgmSMf8SSavLhUDqNR9IoMmygwDYBCT7k3IbzbnFHWqT2b/n795kiLb8/9H7tDEgewCh5k2v09Td34sHt1T7Ps1yPruxfabjbttPXxQNNcbzUhnO9qStt4OMoOVMrN3gnwl6VIToYYdIJfCBj7R52uNo4PZL18pBg/Rscore/z4JL3V6imc+15CJhBZ7jjKPtxQhuOU6EV0+J4xO3U+C/fwqt//+3kyzhG0Ghy8hCJfZP/qpaKpYeTiEmvsVu/l64F5Jk90Ng4L8AZS2pqakBXmnnbCdJZsaZsVs3m93nLd7HNHhRnH4Yi1xRsopoY3nq7KTuIOABNKaokm2Fl6JMVy9DWKPdS7xCSzPe5NEIWpUK+uF5z8qRyDyJjVAojgCD96sXAqOwws21Tjkppeh2y/5SdVDUrxB32bpwscvsvkR5AZqHU5JTmjUdhLyDd0N1YzbZp9i752Snd2CukJyNgD4o+fhLt0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc51945-9435-44ab-9ffd-08dca1ccfb8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2024 17:14:54.4925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pIrJ9NL4AtRFpyF9q7ELMH4fnZyrsQaSQGTsLdRpZEs6SRd+YYqoSN/V7NBH4BsXas7yje1vj9/i0Hia5WtqHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5673
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_12,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407110120
X-Proofpoint-GUID: xV1nuR-z91AfBStekbFdu6ujw3xmNH2W
X-Proofpoint-ORIG-GUID: xV1nuR-z91AfBStekbFdu6ujw3xmNH2W

DQoNCj4gT24gSnVsIDExLCAyMDI0LCBhdCAxMjowMOKAr1BNLCBCZW5qYW1pbiBDb2RkaW5ndG9u
IDxiY29kZGluZ0ByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IE9uIDExIEp1bCAyMDI0LCBhdCAx
MTo1MiwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOg0KPiANCj4+PiBPbiBKdWwgMTEsIDIwMjQsIGF0
IDExOjQ44oCvQU0sIEJlbmphbWluIENvZGRpbmd0b24gPGJjb2RkaW5nQHJlZGhhdC5jb20+IHdy
b3RlOg0KPj4+IA0KPj4+IE9uIDExIEp1bCAyMDI0LCBhdCAxMToyOCwgQ2h1Y2sgTGV2ZXIgd3Jv
dGU6DQo+Pj4gDQo+Pj4+IE9uIFRodSwgSnVsIDExLCAyMDI0IGF0IDExOjI0OjAxQU0gLTA0MDAs
IEJlbmphbWluIENvZGRpbmd0b24gd3JvdGU6DQo+Pj4+PiBUaGUgR1NTIHJvdXRpbmUgZXJyb3Jz
IGFyZSB2YWx1ZXMsIG5vdCBmbGFncy4NCj4+Pj4gDQo+Pj4+IE15IHJlYWRpbmcgb2Yga2VybmVs
IGFuZCB1c2VyIHNwYWNlIEdTUyBjb2RlIGlzIHRoYXQgdGhlc2UgYXJlDQo+Pj4+IGluZGVlZCBm
bGFncyBhbmQgY2FuIGJlIGNvbWJpbmVkLiBUaGUgZGVmaW5pdGlvbnMgYXJlIGZvdW5kIGluDQo+
Pj4+IGluY2x1ZGUvbGludXgvc3VucnBjL2dzc19lcnIuaDoNCj4+Pj4gDQo+Pj4+IFRvIHdpdDoN
Cj4+Pj4gDQo+Pj4+IDExNiAvKg0KPj4+PiAxMTcgICogUm91dGluZSBlcnJvcnM6DQo+Pj4+IDEx
OCAgKi8NCj4+Pj4gMTE5ICNkZWZpbmUgR1NTX1NfQkFEX01FQ0ggKCgoT01fdWludDMyKSAxdWwp
IDw8IEdTU19DX1JPVVRJTkVfRVJST1JfT0ZGU0VUKQ0KPj4+PiAxMjAgI2RlZmluZSBHU1NfU19C
QURfTkFNRSAoKChPTV91aW50MzIpIDJ1bCkgPDwgR1NTX0NfUk9VVElORV9FUlJPUl9PRkZTRVQp
DQo+Pj4gDQo+Pj4gSSByZWFkIHRoaXMgYXMganVzdCB2YWx1ZXMgc2hpZnRlZCBsZWZ0IGJ5IGEg
Y29uc3RhbnQuDQo+Pj4gDQo+Pj4gTm8gd2hlcmUgaW4ta2VybmVsIGFyZSB0aGV5IGJpdHdpc2Ug
Y29tYmluZWQuDQo+PiANCj4+IFRoZSBrZXJuZWwgZ2V0cyBHU1Mgc3RhdHVzIHZhbHVlcyBmcm9t
IHVzZXIgc3BhY2UgY29kZSB0b28uDQo+PiANCj4+IA0KPj4+IEkgbm90aWNlZCB0aGlzIHByb2Js
ZW0gaW4gcHJhY3RpY2UNCj4+PiB3aGlsZSByZWFkaW5nIHRoZSB0cmFjZXBvaW50IG91dHB1dCBm
cm9tIGNvcnJ1cHRlZCBHU1MgaGFzaCByb3V0aW5lcy4NCj4+IA0KPj4gQ2FuIHlvdSBkZXNjcmli
ZSB0aGUgcHJvYmxlbT8NCj4gDQo+IEl0IHdhcyBhIHdlZWsgYWdvIG9yIHNvLCBhbmQgSSBkb24n
dCBoYXZlIHRoZSB0ZXN0IHNldHVwIGFueSBsb25nZXIsIGJ1dCB0aGUNCj4gdHJhY2Vwb2ludCB3
b3VsZCBub3QgcHJpbnQgdGhlIGFjdHVhbCBlcnJvciByZXR1cm5lZCwgcmF0aGVyIHRoZSBiaXR3
aXNlDQo+IGNvbWJpbmF0aW9uIG9mIHRoYXQgZXJyb3IuDQo+IA0KPiBMb29rIGNsb3NlciBhdCB0
aGUgdmFsdWVzIC0gaXQgbWFrZXMgbm8gc2Vuc2UgdGhhdCB0aGVzZSBhcmUgYml0cywgZWxzZQ0K
PiBHU1NfU19CQURfTkFNRVRZUEUgaXMgdGhlIHNhbWUgYXMgR1NTX1NfQkFEX01FQ0h8R1NTX1Nf
QkFEX05BTUUuDQoNClVuZGVyc3Rvb2QuIFBsZWFzZSBhZGQ6DQoNCkZpeGVzOiAwYzc3NjY4ZGRi
NGUgKCJTVU5SUEM6IEludHJvZHVjZSB0cmFjZSBwb2ludHMgaW4gcnBjX2F1dGhfZ3NzLmtvIikN
ClJldmlld2VkLWJ5OiBDaHVjayBMZXZlciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4NCg0KDQot
LQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

