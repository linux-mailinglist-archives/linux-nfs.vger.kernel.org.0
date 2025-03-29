Return-Path: <linux-nfs+bounces-10953-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44779A756EF
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Mar 2025 16:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 857AD188F51F
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Mar 2025 15:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC941E492;
	Sat, 29 Mar 2025 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d2lQ8fkl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FdevpvdR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7305A1FC8
	for <linux-nfs@vger.kernel.org>; Sat, 29 Mar 2025 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743261019; cv=fail; b=XqVRS+DKNhRvUUSIZO2JRB4PrhemmFzjwQjnjwQcw7llhqj3xZhkksk1xtwhPT4fqFRePAeJ3B3RP1m7JTvDn9yj0No7H1L9XsOfJ5fWNX1VNGRRxdPSajjH17P3wSD6nq+JUFNTHZ5EfPvlUohqKj+11r9Q42erK/Pee8XTOY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743261019; c=relaxed/simple;
	bh=j+b3j8TFQWw0s5/ip/Hqm5Qu24ntt8bFozd/lMhzDco=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=iwiaqmYmVDVgRtAqyAJ087GZVK+6GWyIqjvFBmpAPXh6otb770xmzwlaX08SRwApijii0/HAFotza4fNjnvyYcvHcBDM+rLy1GCZ+1dx21/lkRMaswP7XCzhzZKG0LYiJJKruo3/yqBVEDh/H9uPEboTdOy2KEfJz8a2jDwlvEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d2lQ8fkl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FdevpvdR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52T9pDm1028080;
	Sat, 29 Mar 2025 15:10:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=5b0+Lw2wh8sgskvB
	8YNQY+w8LKI81RC6wRk9vSezomg=; b=d2lQ8fklMKRSIg1g7dq+NcTLhUgrWRWi
	RZqZIMMNavrUEukMyHpe7k4qTAOIgIvhxRz/EVjip7cCIii16ke+9eg0+lG83G3v
	pcRBJrwa77X7F0dtMR9ebXPF9kpRZUZbXTTIGykmiDqrVpLWwHVhgBpWccmSo7Iz
	d4gGRE5784ZYRrdFqZ8S++/alZPfkBnbSbP74zT47541MlbTM+NdDAr/4MCv2LZj
	5P0E0M+WsRi+/uP19eD9D4glht0AxmlggTwY2oeK8aHqACbRnNBuaLDwpQqSGQZb
	IFk/EM2gp3hYpz1nizlcSLXMcRQyzCqYgEZ51Fkfh5hhhz3QLdxmSw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p79c0kaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 29 Mar 2025 15:10:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52TDhmGD010720;
	Sat, 29 Mar 2025 15:10:14 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45p7acdvnk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 29 Mar 2025 15:10:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kTJ8jN4yLg34AcNvfxplsBKTF3jPw+MSmywWfPaXro7dzDU2SqnIJY7ufzS5KBeMtV/VgelcIquhz2BiEzVKzq1gQ2kpnfxwERwd0otGARIPkP4qzwxyIDGHRFVKlV+1ldoPs3bsjlJ4dVfjQAZll26HM5l4qAu0tgLJpJDe3VOWDQPY701mE+AD6zJT5be970nz7Lw3IsOT1fo936zQQBh+jrSadLzoh6OFef6BkSX0s7dccU+jY+zA5MNXRqzYD8fnbC2RxIlWiF9KgWAJsZy2x3rW90SEnv/lVt7EpirMRD1/C8U/8fVTgFGKCPq40+xrh8ioKx3r243adHm3xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5b0+Lw2wh8sgskvB8YNQY+w8LKI81RC6wRk9vSezomg=;
 b=qzToWplcLf4Snx/BHBzNEtwEIub86k86Q368aoXb7jnt2K3614UiPjG25ZePIQ1tSh6q7SMQekDNepg9VxxtqIWAdGYe1YeX6FbMsCrnPUfjRwg4ez1soraXARWry9QnZ7SOQZrgW+h27K2VcZXTSjtCiWRMuyktGt/2wlmAgU3p3IF1dkLbn51r/eevfdnIwol/ndS5FH172IGILOqK0K4zpB6tMxSYz/wax2mKuriLl3WqBmAJE+71/e7cFsXYgccItbscB1/F3T6M3/kwq6z2Z/FjyODNGypAH495p0Ukq0Tcxtpr7IixkcruankwquU9it/fc6Z1VVrQx6txeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5b0+Lw2wh8sgskvB8YNQY+w8LKI81RC6wRk9vSezomg=;
 b=FdevpvdR8owyp027yg9gEwMQ0jVX2zntX3h/F+xN5pcMIdWfsLmHggmsJYqICs2EixOUO+ITA2AHV7YhM9bOlVUD2ZYvqftgyL5pt5tr9FZIAsa3eG/sGMtex4s5DbZToWquiq4q4HajA7CIYS2UWZU2T7vSw243IrFhmyuX+3o=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by BY5PR10MB4179.namprd10.prod.outlook.com (2603:10b6:a03:206::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.33; Sat, 29 Mar
 2025 15:10:11 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%5]) with mapi id 15.20.8583.030; Sat, 29 Mar 2025
 15:10:11 +0000
Message-ID: <74e445b9-b084-4dd1-93ff-cb6fe875ee9a@oracle.com>
Date: Sat, 29 Mar 2025 11:10:12 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Chuck Lever <chuck.lever@oracle.com>
Cc: nfsv4@ietf.org, Linux NFS Mailing List <linux-nfs@vger.kernel.org>
From: Chuck Lever <chuck.lever@oracle.com>
Subject: [3rd notice] Announcing the Spring 2025 NFS Bake-a-thon
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR19CA0005.namprd19.prod.outlook.com
 (2603:10b6:610:4d::15) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|BY5PR10MB4179:EE_
X-MS-Office365-Filtering-Correlation-Id: 543ab0b6-ddcd-4a67-79bf-08dd6ed3ccd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3FkMDBDaWpSdFhUTTY2c0M3MmxwaU1lb0wxcDJTOURhVW9TZ1RySTEwb3Jh?=
 =?utf-8?B?SkFWUmRmeUxmU0poZUFnNDA1M2pIaldiS2hiUXNya3d1eTVvVTVURnlETU9H?=
 =?utf-8?B?TzBNVUd6VkdQamNoWGllWXBFcWFJMmJOd1JTZ1BXcmhxOWJMNTEzQVMwaS9H?=
 =?utf-8?B?NU5hcWtOTkFEazF0eUtrYldlNUZCRy9QQ1FCZ3Q3eElvbnlPQkt0L1FaK2lq?=
 =?utf-8?B?SDhrNmJsc3dTU1JRd0hVVE5md1NXTVNDNGZhTlNBendCdCt1eVU2V3FaUGJl?=
 =?utf-8?B?aGEyeGloVVZGQ2ZYaUZxZm1kdVVVRVJaMjJ0YTk4cHNwQit1c0hMOTFhOC80?=
 =?utf-8?B?S0NSUjFTRXdkV1Bqcjlvb3l0bG1hdTQyUHhMWUFKbVNKNVk3NGNWeXVDUzVa?=
 =?utf-8?B?NnJpTUpkUjdWUDN6R1dKS2lMODMyZ1NsM2t2RHF0SkVSWjM5ZUFEUXQxZ2U0?=
 =?utf-8?B?SnVBdFVNclhYRkJkcTdpenpUaStabHZ5b21iLzczb2hYbFdEZzBiak5Fc0Fr?=
 =?utf-8?B?UWJKVFRqYi9nZjJ5VC9JMG9KVWRTSk1uaDZoajVLd2ZtQ1c4UGxobFJCSnF2?=
 =?utf-8?B?bk5kMml2ellNRmtxWVNjejhrMUxGenJXcnZpbE0xUnJmVk9BSHVNYlZ4Q0xP?=
 =?utf-8?B?a09GY2RJaW5rblFxRlZ6ejFhV3YvQkprYWJKWElTbENRTGNhOWRQT3kxeEpw?=
 =?utf-8?B?a2orOHpwYktJRzdiVUFHeVQwRStvTUlVcTYxa1hqenNpOUxYeXZia3FIdVlx?=
 =?utf-8?B?M0EvNkd1azFJWklsa2t3am1YY3VtcklNcTEzWlNuUWJSeDZhNGNqL1pOQ1g0?=
 =?utf-8?B?eTZwYm5BNURLTXhDeUp3eFJ2RE1mWFpic1VFU2FPeEVZenEwU3VudDlLTTlR?=
 =?utf-8?B?RTBlekFzQWR2bmhzZElkRnJGY0s5ZU1iYnE4bmxON1E5WTNXMkJsNzJmZnd4?=
 =?utf-8?B?NXFqbER5NmJwclNzcDV0ZFRXMG1IZEFtSFpVTHFBaEpJV3p5ODFnNDFaMlpW?=
 =?utf-8?B?Rnp6a0N3N2kyd1FkNkdxVU1ORklWWGdUODNzNWhYb0RvWDBtVWhWc1ArK2py?=
 =?utf-8?B?emV1eHVCd1J4MnhRY3c2WXQwY2tFQ2JOZzlFMlFUQ1BWVCtnSHU5MTk3ZnZD?=
 =?utf-8?B?NUwzQjFkNnBrYi9hR05LTkNqYm9LOU54SUR4TmFnQnB4aThmQjV6WUlXam9l?=
 =?utf-8?B?NWZFQk1tT1QycGFsYjZIWUdQMWQvQTRZc3BjTlRIYmMwSzYxRnduMk1PT3Qx?=
 =?utf-8?B?NmhMYW01Rnh3V2lmZ3M2UWRIcGcrbmFVbEY1WHFrcGN5bHJjdzFtQVpnREtx?=
 =?utf-8?B?Y0tzVDhkMXRIQVBwc0ZiTkVBdEVzOENrSElHb2xrbzJkRW1rZ2g4djVkMXVY?=
 =?utf-8?B?ZUFSaGE1VzZCQWxNdEpSdEpDWGhTZFZ2L3hJWWdCMHJUV0J0VlNodk9QM0M0?=
 =?utf-8?B?VG9ab2lSNTdPZXhEUHBKN2pnclpFSldUVjZCaVZqaFNMSkdOazdETEtUYXRp?=
 =?utf-8?B?YUFGQ2kvdjVlMU5hZkxFdmVJOEZrQ3k0eFZPbDhPUnp6d1dUVVl2czg4MlZG?=
 =?utf-8?B?ZmtTdWl2dWhTRUp4Ty8zUVI1VFdoK2RUUHR6KzRIQ011Q3pCYXBsS00razk0?=
 =?utf-8?B?RmFFZWFwb0FWeWN1Y3FWckFpTWN4ZHpocE54Y1JZOHUvNkt5V0hCeUMyTWdl?=
 =?utf-8?B?a29oelhnVXVoZzAyRU95RWtoaWR0MkVZbW1RS0ZSVnBCQTlURVFPUkcwL0Er?=
 =?utf-8?B?eTVHU1JVN053R3VrUzJ4S3JTNHVOTVdsVzlDY3Z5OGdBNHJwbXFnOUxseGNU?=
 =?utf-8?B?alV2OHkrYUVzYmQyWEdQZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emRKMGZXVHRjTnMxVG9CdHFlRUt2cnRJU1NuSUhoc1h0WTZ3ckk2WFRiYWgv?=
 =?utf-8?B?eTVDNEpiVC81QWg0cDNGck5jVHk0bjAra3VDZWZXekh5ZlNtSkdwRDdWTHA2?=
 =?utf-8?B?WVhoZENCOElmTGp1Q2E4OXJHYVFYMUF1Skp6SnpFUUtQYkJPWmdQdFpGNDM0?=
 =?utf-8?B?dlJ1dytRUVRVN1F4amtsSGVKWjRraUtxSUE5QkxtUm1QZUlaY2pDVEFSS2tB?=
 =?utf-8?B?MkMrV2ZjSHZQTUo5TnlkMmJLYmxLc3h4RXRWTkxzYkVsNUIzNVMxbUg0dW1x?=
 =?utf-8?B?SlV2MWdvRGdYYWsxVGgxY1IyQmJoQXMwQWUvODFVRjZrdktYVHVDVkY2UHBl?=
 =?utf-8?B?QXJ5OXdBWHZuM3hBdWtFcnVnVWI2dHlTVXgxeTMrc0I1bzFsM2ROb2I1SXB0?=
 =?utf-8?B?dnQ4cjAzbHZVTzI5NlJ6L2ZSYW5DY3EvWTAvRWM4aU54bFpYcS9SYTJ0MW5K?=
 =?utf-8?B?emdwSVBtUVd0UHhIRWtHT3A3OE16U0RyTWJ2T1VxL2N6ditWVHpOOWkxK2dG?=
 =?utf-8?B?RkZqcXZOeFJKMzkxdUgwYzZDaFlWdU5BYmM3ZVBBa2RFeCt5VEJMcWJFQ2FT?=
 =?utf-8?B?T05sYVNmdHBqbWdwbS9uemlXNEwvQ2JNakQ5WlNWUU10cEtBTjlPQks0eE9j?=
 =?utf-8?B?UGN0SC90ZzdHWlZYekg1LzdOOE50c1U0N1FzR2hxcVJvQTZGQ3VGNkZzVlE1?=
 =?utf-8?B?VDhSRlpiejIvQjcrY25mWUx1blM0QmJzZGE0Ty9BYVpUTWRRSDdUa091dXRI?=
 =?utf-8?B?T1UwMHY1RDNUMTBKVVRIYjNqZmlyRmRJcTVmdmUzOEhtTjY5QlIxVHNVNXJU?=
 =?utf-8?B?MEpiOEZ2NStQazJmYjkvWDVINFRVd2RmQnZhVUJZNkZJZUxJVSt5NVRKYWcx?=
 =?utf-8?B?SDcxcHFFdkkxakhNYTNqYUtCOS9GZUcrMitXdTZWelNxWlQzSis5ajBlK0w4?=
 =?utf-8?B?T0Z6M3dsK3hUY1o0STRBSWF0SkIwR1FoYTVhZXdhdUgzUDZVQmQvTGJVdHJE?=
 =?utf-8?B?SHdVOUNlQXFTVGUrUTZwL1NiSS9mbkhaVEtlZENpN0tGMzhqRHBhTUNxajhw?=
 =?utf-8?B?Z0hTNEs3Yk9mV1A2THE0STk2aGg0anhnS3J6UGkwN2RnSktFN3VrM0pVemxl?=
 =?utf-8?B?ajJtSUI0OVRPWmt6RnBzMU1LVzcrODAxelVzbXZLaFpwZDhucUliTm9rQ1Zo?=
 =?utf-8?B?ME82UURJRjdQS0ZwelpEd0pzRER6MzA4WEJLN0FCRTZobHhTeUNlOXdzRUcy?=
 =?utf-8?B?RVY4NEtWMW9XdWdrQzZqZ0NjMG8xdTdNMkp6YlNnTjlKb2ZWdlY2R1gxcGp1?=
 =?utf-8?B?S2w1NG51REl1aWFDaS8wWElNUEdOOVVGd1ZXeEFweHRqOU1YSDcvUndCRmNF?=
 =?utf-8?B?T2JFMUkyNFNBTmZqVms5MTdqS0l4VzRNYU8yM09ZRmR3U0dwMjc2OTFYUE1n?=
 =?utf-8?B?MVZZMXVvYnRXdVloSXJ5WXAvaXpJMlNlZjM0akg0Y3pKQU8wN2RDeWppV0M0?=
 =?utf-8?B?MzFVZm5TVUhmcHJ2WVhDQjZUZjdicHBOSFJ5MUZrVXNtTTd3S2pNaGgvZHJm?=
 =?utf-8?B?MWpPUzU3VFNyVld4TUFzWkJPU2haSlE2a0RZQ3gxKytxZXU2dVFvbTF6eG1k?=
 =?utf-8?B?NDUwZlQrVEJrQ2ZiL2lremN3OG5CcTk4U0lwV3dTN0RORTJKVGNzVXA0QlAx?=
 =?utf-8?B?L05rOFZFT2JiRjlNaExaT3ArTXRpRXJCR3pPMXkyKzRoZ3ZrZFFQUmxWWndk?=
 =?utf-8?B?aEd2V3JaMFNrMXdrR1UzekRlbThHeVNFK2x1NmdNTkdLS2xqQ015LzFrM2px?=
 =?utf-8?B?N1c2L3VFNTFNdlpuSGpGalVIdy9JL2lHbmpra1VQQ3BOYXZoZHVUcENaWmg4?=
 =?utf-8?B?cUNqYkJBOGkxeWN2d0RaQXFVS3NqbFhEeWliUVFXeGdGNjVmWFBlci9HL3FX?=
 =?utf-8?B?V0lnZDRjZmdxOWRRTXFiTWdRVmhFOGg2aEs5NmtzcWR0WDgxOWo1VjZHQWNR?=
 =?utf-8?B?eTlxb2RpUUNtbnN4U0dUWEFkdjhIYWFMYXEzcEZVQS9MdE1JdVVueUFDZ1hN?=
 =?utf-8?B?dDJpUCsrdHE3Q0R4d3dTSnAvb25FbjZIRTZ1NmRWWndLNGtzQUN5U1JqRTV5?=
 =?utf-8?Q?EGB+mkQ02QaOIbhV+U36zSlLn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	E4MC5oon/wADGteIeQvuzPyAqU6YH3PnjPBuikUIT2c/ZtMwpyZSlANuaBINNqUq72u/ACmc/X8CH9aPCv+ZIvCCulOhBjYG7Iun1rn4gno8u7KIQSmaNyot9nBXdvJcPdUOFF8Ffon7MHvbEc3aA/oS+Zr5nnPJGPJDyjRVQ8QYnFQIU4ECnWe3PTsSO26maGL+JhblgJ6J9YG5ddwtXG1Vfga7bC3E8a0+ks0p08DXbxqZw80HAuUOp7f3Gto7+ndZ7khEi2ojRRr88YmYSKpkbtO6xSt0PANy51o3YgNX2Ewpaj4CNHpDE2TdjYjD8Gh1rck65eDEHN6IlM2QOf5F0CUi7MnG8DHLEanVknZ0mZqdbCpgf5adLOMad1t22c3ug05CFGauuok6/fNEexLE4vuqoyLHQeiECkzjnb865Y6+Vm/oICPvv38LSpbK8lxQPiXrBKyKf06eRD8Pu8uOij+ZX/inAXHV810ajgRZLkUPnDFr8SYZ3QFEv4dKPYNHQXiCi7wDzoxr8PxfZ1ba7i8iyVxElOBblrtB0Ya+/rlpZQtxFB9f8NvJjPZsh/QFer4tUoaFZ7SQXBHFuKKPsCZGg/aDBnrCQhsJL1A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 543ab0b6-ddcd-4a67-79bf-08dd6ed3ccd1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2025 15:10:11.1437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EDceBtYRtrTxljcN6P+h302IfR0yUzvVplZLnICu/WCq/gJJPXYdmwtsbCWHokVLnNjKByVs8pGp2dSRajkyhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4179
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-29_01,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0 mlxlogscore=777
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503290109
X-Proofpoint-GUID: t_nR15Wnfq7CiaZYz1QKZItMkMqZXmkj
X-Proofpoint-ORIG-GUID: t_nR15Wnfq7CiaZYz1QKZItMkMqZXmkj

Greetings,

This is a friendly and warm reminder that Oracle is pleased to sponsor
the Spring 2025 NFS Bake-a-thon event, to be held May 12 - 16 in Ann
Arbor, Michigan, US. This is an in-person event that includes secure
remote access to the test network via VPN, enabling virtual
participation.

Event registration and network, hotel, and venue info:

http://nfsv4bat.org/Events/2025/May/BAT/index.html


If you plan to attend either in person or virtually, feel free to add
your name and email to our sign-in Sheet:

https://docs.google.com/spreadsheets/d/1_6Vl_3fcrehfuuY-WpIgGyxUUl3d0Xt_4zNTEN0sPug/edit?gid=0#gid=0


Direct your questions to bakeathon-contact@googlegroups.com.

-- 
Chuck Lever


