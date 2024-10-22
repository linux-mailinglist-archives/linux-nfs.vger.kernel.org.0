Return-Path: <linux-nfs+bounces-7371-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 912A69AB928
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 23:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A26D282D8E
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 21:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AD715573B;
	Tue, 22 Oct 2024 21:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WAPABN+Q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B2j19xTj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F5C126C05
	for <linux-nfs@vger.kernel.org>; Tue, 22 Oct 2024 21:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729634184; cv=fail; b=fRaaBSdW3UQV92M84VMWnU6SfLbtQm8NUb1kbJtMAw2Aq3r5sIhFn72cN8MKOKeMAR7yjG8ANgClzHlHI/eC1mUcIiBHeyCSrBP4eUQFGTrmrVj0qRY1M0PHn8fACI7U5VsyLztNwoKEiVVro0wPjQzyPB+5EEGKNX0fsBTi/IY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729634184; c=relaxed/simple;
	bh=ZtIN71UjNi8rDXZTIQ8oJMrmpwV8W5XY/YxdPvRPF74=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iFzsRXkJLqK2Z042zQ33nO0j0AMP/sJah7d9PfRyr4Da6IzRnTlnEotPB54NydC1/zykij3+fi0GurrzZg2ih2f+qamCEpgfFlvPWXd/JtEspUfKc7ksK0gvhD7oeWK392JdvoJWmPsf4dKzxGGFXH4Tv14CKcH8fvIKOWvJe2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WAPABN+Q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=B2j19xTj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MLQYuE000450;
	Tue, 22 Oct 2024 21:56:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=ZtIN71UjNi8rDXZTIQ
	8oJMrmpwV8W5XY/YxdPvRPF74=; b=WAPABN+QXjMiC8wMBeQPnMpUsnb4dBv1/6
	MCGAAFf+DMYN1FnuwMnJhJooGdOV0lO9CHqgc8y8h7fQJF53BM0rvvfLD4qwSFQd
	/0zXczW9tVyJgK7oxWAWAXBYHI9QieWiABqr+ZdyEFqMxpgR6Uas/Y7owgYQJKvs
	7Zk18c2uQV/Sv6hpV7KhqFHGBCQmb3gpLGmP9XZ7fnQoawJQ6Qo/OAC8IT8trQdu
	Gp0XuxCEeNjd1xkV6BgutjNotnmOBDvYWJagI9wUNpt97Akh/erd853LDGtE4uRz
	A+33BfF4TNzjdNi5ccOfR+sQeANeayDbewFiIuaYcTWGW6UG5oVw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5456v3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 21:56:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49MKvwml007664;
	Tue, 22 Oct 2024 21:56:16 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42c3789hwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 21:56:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hk+w6kivf0rvfUL/bUxltPuBV9mPtNp7SGWT/5mFSicK3TvwSNPC+486xPU+S+JdSilhBfrrV1Wq2/eAkgjNABVHnOmU7oXG6WFQ1pbQxeePZfah+0tWQvc5UUspVQ88nQQOGdwvRSljYr+mqNcsRWiA0V2XrUVhAGEKb88kYiEKd8Qmgj99Sg4GgkYhefdUs8XQIlzQrmIos7otA7HcpN8pIc+/5WVtUIkGT/V8BYah2BKsCfqEjy74lNJUq9L+s2JblRJPhLh3q0pMAQKraUQh3Hu/tUtAW5FRoDtJYM1nrye6SUjKiJ+0Gb07izbtodd7n+kfFDntc0TVGsROCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtIN71UjNi8rDXZTIQ8oJMrmpwV8W5XY/YxdPvRPF74=;
 b=yO6LhlmGyYEaAgF35oKNUK1PJCA+ZqIYBRIVG1u8ijZOmy7bnDcZ02o4OJ5CoNcUBb/i4lQrnr/JIKMizci15hg5ZZhI2UraNbX6rAkTxoO0TCDN03DNpxKH/Ul9AOwxfFD1U61/RqDWFnLfzmewokCdwZuNRojbANxWsLZQ5dXPF5wJNjuFBds75qmOjljnKvwl1Keo4IpmzF0bLFg2fChe2u8HFey9vDM+UC+sYFcP9hA7FKz6WnreI6471y0lbi6g44G9ix0CKxjbRePyl4BMtoIrj5yHwgUnanLWcTbAczyx/imaZ0Aom2xKQJmlbTPYIGNTcXwLCupIty8cJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtIN71UjNi8rDXZTIQ8oJMrmpwV8W5XY/YxdPvRPF74=;
 b=B2j19xTjQcm6qWHkuGg970eDQnanlEximPZN2vYYizI/DIns5XBHSX5q0QX4wNAm8lRsGB4/35ptcN8Z30l8hqoO+QkryaNwvNSqWJfN1VQps1cCQ59RdxZ3Fsd/k7EQOjS7YreXv4ApGCZvJpwi6pm5pTaZ52jnrLwhU+gN0kM=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Tue, 22 Oct
 2024 21:56:05 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7%4]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 21:56:04 +0000
Message-ID: <e1618176-d4ce-4f05-b986-0f2bce2e7c2d@oracle.com>
Date: Tue, 22 Oct 2024 22:56:01 +0100
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH pynfs v2 0/7] pynfs: add CB_GETATTR tests and tests for
 delegated timestamps
To: Jeff Layton <jlayton@kernel.org>
References: <20241014-cb_getattr-v2-0-3782e0d7c598@kernel.org>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 smRifw1wGg==
Organization: Oracle
In-Reply-To: <20241014-cb_getattr-v2-0-3782e0d7c598@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0MdtULY3sr00A9BvRWVtf3SQ"
X-ClientProxiedBy: LO6P123CA0013.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::19) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|SA2PR10MB4715:EE_
X-MS-Office365-Filtering-Correlation-Id: d1400985-23ed-4d30-2155-08dcf2e452c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHg3cnhKUmNNbyt4aVlrK1k2SXhUVk5mQUtpbmZ3cFVpQVI5YmxyWHN5NktQ?=
 =?utf-8?B?WHVzZmJabUhnaE0yOWpka2QySE5KNnJ0Y1IvTTNpT3Q3Y3gzRHFVR3ZkVHFa?=
 =?utf-8?B?NDM1ZVdRUWl0TVlwTUxxYmtIdEVwelRHNy9PYmdwTUdBZmZZOWtybUhVVWlN?=
 =?utf-8?B?bHdXZHBORmgyUjBmdTV1S1YyMTZCZE1BUDkxWEsxa1VHa05RT3FMcTlEemRJ?=
 =?utf-8?B?dy8yNTIyZTBleVFtNUNMS0ludGpKS0N2RnZMWTNBd3RkWU9nZGpCc3VBaFdZ?=
 =?utf-8?B?TkZoYXJJOVUxOTFPSWZUd3dIWkZTRGdxUFFMR0ZuSFF1d3NrdWlVcTZNd1pu?=
 =?utf-8?B?R1pWUHNTWUVQVGYvOVArSXo0dVF6ZDNxNUxyd1RHK0pyNkF2ZGxJNGV6UlZZ?=
 =?utf-8?B?dlVqZUtPaVRhTTJuTWgzV093dGhPbE1EWUhvUXMwTTREYXUzUVJPMk92STYw?=
 =?utf-8?B?eTd6eUlZekZzeC93WjZ6aG1PcXlrM1RVYWQyQ0xEb05xVEs4SjVBOVU2QkdI?=
 =?utf-8?B?elkxb2cxRUFKV3NrekZGRDRiUUw4aDJ2U25HNWRBSHNNL3IxMDIzcXcvSUNM?=
 =?utf-8?B?c2k1NFpoMXhsbTZGb2I4cHdybzNHR0NaLzlMODREYmZRZEVzNCswd2dXNlUz?=
 =?utf-8?B?NGJvb3NBQXhCL3NKVExBYnY0R0k5LzB6Tkh2bVZ4d01QMm93SFdKR1hQcThy?=
 =?utf-8?B?NnpueDRLUmRybkFpRlU3OW9GSDcwYkhXaXptQncwS0JoMitCaCtJSlphVEVW?=
 =?utf-8?B?UG04RHJVeTUxakNPb2VtUXJVVmp5ZFZpU2VWSW1vaW9oOW9HUUFndzl2Unp6?=
 =?utf-8?B?TDlncmdRajZWeG8wS21NcG1xRnZseWtabVJlbG1vd3JBK1ZIYUo5czBSQUg5?=
 =?utf-8?B?SVdXQUpnYzd2TUQvRXBZcWlnTUVsT253YkFQNkg4TzZMMVdvNnFKK0VBSjY0?=
 =?utf-8?B?dzMzbS9CQldDSUxYM3VhQmFsanNiN1h5OS9zTTdDYUplTksrU0lDMVNxY2ly?=
 =?utf-8?B?aC96R2RqVWRXek42Rzh1ZjlFZDlKS0I3WUpzUmw1aU01UFFnVnpiL0NURG16?=
 =?utf-8?B?Z2FZVXBkc3cvVTJ1VEl6SlZsR2hETXBFMUROd2NscHZYY3JvT1M3YWRrM21q?=
 =?utf-8?B?bTQ1eFE0ZzIyM1N0YUlVeFpuNkpLN3pKVVZzbkF6elNPUnFZeEtSVUpqdFM5?=
 =?utf-8?B?djJ3WGgrZ2JWM2JSNGNGMlRXb1k2alFTR1J3a055dGUwejhuOFFnb01wTS84?=
 =?utf-8?B?MmtueXk2K3QxelJkcml0V2t6YmR5T2JCcnZ6VnkyUnZyRGVZOTNZYlB2TFMz?=
 =?utf-8?B?RnF0aDBPT2ppeUJzL0xkcFVmeW5ubDAxT0JzRjJ4aUVlUEcwWit4VWIyTUEx?=
 =?utf-8?B?b0xqWHp6L0M3R3NvbldiOTRuVVFhMmVFeDhUbHROczM3RzZrTTM4UHVuUWJF?=
 =?utf-8?B?Vm4yaVNacmdtTnJxcHJJaW1uakFBR3A2VGd3d1h2VnNieExmRUV3bFZncWln?=
 =?utf-8?B?ZjN2UDI4aTBQNGN5YW9VaHBvU2tEdEtreXE3WllpQ2tlRkVlVTIzWGpScnNE?=
 =?utf-8?B?eFVaNFBlZXA1a2tPWFpjV0pUcmdjclZlWkpraW9FbXM1Ukp1ZDdJZlYvdEMw?=
 =?utf-8?B?NjhtZzlmSDJVa3NkQm43M3o5MGprR2gxcktkVld2TGIrNXBtNzFhNkhOWTNo?=
 =?utf-8?B?TWRLRFRVQmlhdEJwc3BUSE9tbkZTcExRZmNCdEFkWGtJbzBZZmNrUHQ1alJz?=
 =?utf-8?Q?6hqVdHba2EPVP5fgazK/n0eG4eavD49gvmg2895?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?allEUTRYRWVWMllZeWVRa2hZSXlNemNIdHlORVpWeE1ra1JoOXRzSTUzbStC?=
 =?utf-8?B?eGVaQ1hNN0hRcnRVbmxlVmxheEluam00Y1cxdnkyL0xJeVdzVEE0L3JnaHNy?=
 =?utf-8?B?N2hXMVhZTWR2YzRDMVFhcndjMmhhUWpSaVd2RWVHcFp5ZXdJK0VFaUxvdWxz?=
 =?utf-8?B?NHNTT0VVQ2hiRnRLRWhZellXSWFUSGI2dFpLK3R6VjhIWG1JVnRKeTgwQXYr?=
 =?utf-8?B?NzFWT3dUUTVMMHF0WFFTR1ZMcWZDay9uemlaUklJZlMzdUE2VXlzQ1RKZUtG?=
 =?utf-8?B?MHcyaWpMRlhudEtQVGlJUUFxekhXRjhodUxrZWF1TXFCUktxaENzWDQvT1FP?=
 =?utf-8?B?YTN4NVNVYkhxMnhPaDNwZTJrQXZ6aHZsMTRDTG9Kb01Na3A1cjkzWmVGK2lD?=
 =?utf-8?B?T2hVNzNDaWF6cWhKdklOMGNNNTk2dGxMckpDWkZUbnJYYjl5Y2dzZnFudVM3?=
 =?utf-8?B?OE9OcFlYai8wbWdGN3hVelZ3T3NKNm5lbkVBdlVjL2R2WGxLUG9KM1BKUTJ6?=
 =?utf-8?B?NXMrTEZsdUx1eVBIKzRid2xiSlhRN0xGZWNKRHFacGdwT3YzTERxenFHODVQ?=
 =?utf-8?B?bHc2RnJ2M2EraFZwRWJRN01LZmltRVpQSnRLdzFRSllJTlRSWmQ1b1o4TWhL?=
 =?utf-8?B?NnNlYVNiYmxlSFhpMDdoM20vakhSa1BZRkowTHhvMHF2Tkp6dndmRDZJMWIw?=
 =?utf-8?B?RExNdDE0YWtKdlE4V2FWT2c3QXlMUjZUNHROUllaR1hxa1laNmU4VmJ3Ny9h?=
 =?utf-8?B?dUQ1WExtZUVFN0dsL0x2bGhTZStHbC9KTHk3WGFSUmFQVC9sTEVnWHNkRExW?=
 =?utf-8?B?Mm5DZXMrT0EwakYwZmdtT0dHS0FTdXhIRTR3SG04eEdaRmFFV3pGUjFjcTBp?=
 =?utf-8?B?Vk9tMVBrVzR1QnF4b2w1dmx6b1Z3NmcrM1ZmYTBXZy9WelZSRXZDNlpVbHdJ?=
 =?utf-8?B?WHBTZnJWSldwWFFGb2gzRG5JNXRCRFJITXQybWx3TExtQ2gwclYwRkdjTW1K?=
 =?utf-8?B?aXdmNStSYURpbUpKcDdJZE5RbXZpdWxQUENrWEpBbEVRVC93b21IdnpzQ1Fm?=
 =?utf-8?B?TmkzRVkrN3EydjZocmJYTFh5RE1nTGRFcHhwbmJGODB3OUJtVE1ORi81SVhH?=
 =?utf-8?B?cG9TU1MvU2t4NVEwNmpIQjRQZGVLOXpOMlJVRXZyZlR1UlI3d1d5eC8yR1pp?=
 =?utf-8?B?MnF0dXhqbHFGUE42enhDcld4Zm85T0lKcDc3T3BHMFhzR3dQY1lKdHh5OUtS?=
 =?utf-8?B?QmxqcnpaQnFyaitpbUkrMVk0SzdTOXNqQlc3Mld3eEl1bExaM1JZakphWC95?=
 =?utf-8?B?aEI4a25KUXMyODZORXBQOEpLSk4xQXRnWlc4SXlxQzR6RCtWcEFPV04ycVhI?=
 =?utf-8?B?UW83NmhXREFTb2tNTmZSYmc5eG5Pekh1V0dpdXJGNEdKU2xqa09hREJOQVFF?=
 =?utf-8?B?Y21Ec1E2d1VXT3NRM01QeTl6SzlOUSt6RlFWK3FyT1h1SmFtTUo4RU1CMzRG?=
 =?utf-8?B?bjM0SmZQZFQ4WnlBMWVXMmFUeVA2UXFndGw3dEY3b3l3ZU13YjlBYTBTekJI?=
 =?utf-8?B?WDNuaGxEcGJRSE9BV2lSNW90eHJDRFNOMHY1SzFWck9RdTNIb1ZtUTl1STdX?=
 =?utf-8?B?YkZiR1pKOWN1N2NabVlXdUJuU20xeHFrMG1zSDhMQWlxZXNqOFFqK1h1ZEtx?=
 =?utf-8?B?enIxQm9pS1d3SExuMGhiSGl4MWN2RFUrYjdMaGRuRHExaTdZTWZOUnJkVC91?=
 =?utf-8?B?dUEyMXkvTDRORDE4STNINWtEUlc5SkZldFMyb3B1bitRZzY4M0hMQkF1aWhu?=
 =?utf-8?B?Q3V5TXY3M3JjdEEyK2U2L29nYk50WlA2T281Wndyc2gxdXNoWjNCdy9sNS9w?=
 =?utf-8?B?Si92dWRNaGtYT0NQeXA1b3ZPQTk3WFU0NGhpaDNmejYzdWRmVDRvK2ZuMTlw?=
 =?utf-8?B?RHBBMTErTjFnTERicGJheUNTM1gzT2hJVTl3UzFkYWFqek5veHNpRG9wbmUx?=
 =?utf-8?B?QXhKZkNHQmxvNEc3OTJFY3d2eC9ZNDE3TElLRGFXTWJBZEJPdSt3V3lGUlJM?=
 =?utf-8?B?SXFPay9SSGN4Q3o4bkw4YWlGTHNKQi9IYVEyeDVVNXRSanVKUE8wcU9JWFJ1?=
 =?utf-8?B?K0ZxeVNOL1BoZnBqRUtNMFRvM3NOUUQzZW8zNkY2V3ArT2szMmlkeXVxRHRw?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6N2poQpyI8gI0HFCJ0+bUfmA7x6G4dR0lZdrIchTZ2vIY590XP/NQNVq1ZSgUp9MjnO+7ZUKQMOBqfqmhz34us19m08ycPfgqwQcIIxh74vrhGSKpCv0dxbSZ4BgTUW9MCPJTaW7LJKJG2dCEnZSHtHFGtcTfQlfaxqQo2KZE1WdIe82t3aEwKanjUY4etqn/KYcpSl+wEvSNHWURtMpYq7/ooD0JmlrDbCX7PrRXqC3QTVizxipzvwNUGBnQlINAmG1hlrC4h3O1SfQx8M7FR6UJILWyJhxh+87kWOEltu2WvHJWRGfP66q89met1AzW32y4567YVkmnGaCPjxUEFUpefx5t8OjnZgqLUXZZw6rL/akwshcBvhO32LkcUf/fYu2sEGOPA9p5UmMorKcZp8YbmW09M38RMBSkaO7jhwkkLGnaNHDy/lnEGDUPVClEAZVfHPu0m8qPUTASYy8gw6S49//zfxWZI5xt9voFumox3tRofUdGRrvWAK2BpG6+lEHOB/iiKw0+L+q17eJmTpelzqABlqO3DTMRTfnkDqbrjlSMvLGjTJuq6cJf24l0VRxVEOYwapPjc8Vwi1NAPCqIRSrcxta0+8iKy8lesE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1400985-23ed-4d30-2155-08dcf2e452c9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 21:56:04.0048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 932RVGe/E5/lGzSkmE7pxqmRf3L0+XyebwsrfPJ11WvFMyX8oJ9ny1geJFRYIpyHyoa93iJeaQ2Cc6qe6Bxlxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4715
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-22_23,2024-10-22_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxlogscore=857 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410220142
X-Proofpoint-ORIG-GUID: i3xJKdPReTtmIIJONvwkXHT-WNlbJrHV
X-Proofpoint-GUID: i3xJKdPReTtmIIJONvwkXHT-WNlbJrHV

--------------0MdtULY3sr00A9BvRWVtf3SQ
Content-Type: multipart/mixed; boundary="------------JuLfqLaAISTvtVR6PZbGI0Ke";
 protected-headers="v1"
From: Calum Mackay <calum.mackay@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-nfs@vger.kernel.org
Message-ID: <e1618176-d4ce-4f05-b986-0f2bce2e7c2d@oracle.com>
Subject: Re: [PATCH pynfs v2 0/7] pynfs: add CB_GETATTR tests and tests for
 delegated timestamps
References: <20241014-cb_getattr-v2-0-3782e0d7c598@kernel.org>
In-Reply-To: <20241014-cb_getattr-v2-0-3782e0d7c598@kernel.org>

--------------JuLfqLaAISTvtVR6PZbGI0Ke
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTQvMTAvMjAyNCA5OjUwIHBtLCBKZWZmIExheXRvbiB3cm90ZToNCj4gSSBzZW50IHRo
ZXNlIGEgbW9udGggb3Igc28gYWdvLCBidXQgQ2FsdW0gd2FzIG9uIFBUTy4gU2VuZGluZyBh
Z2FpbiwNCj4gd2l0aCBzb21lIGFkZGl0aW9ucy4NCj4gDQo+IFRoaXMgcGF0Y2hzZXQgYWRk
cyBhIGNvdXBsZSBvZiBDQl9HRVRBVFRSIHRlc3RzLCBhbmQgdGhlbiB1cGRhdGVzIHRoZW0N
Cj4gdG8gYWxzbyB0ZXN0IGRlbGVnYXRlZCBtdGltZSBzdXBwb3J0LiBUaGVyZSBpcyBhbHNv
IGEgcGF0Y2ggdG8gbWFrZQ0KPiB0aGUgbmZzdjQuMSB0ZXN0cyBkZWZhdWx0IHRvIG1pbm9y
dmVyc2lvbiAyDQoNCkFwcGxpZWQ7IGFwb2xvZ2llcyBmb3IgdGhlIGRlbGF5Lg0KDQpUaGFu
a3MgdmVyeSBtdWNoLCBKZWZmLg0KDQpjaGVlcnMsDQpjYWx1bS4NCg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogSmVmZiBMYXl0b24gPGpsYXl0b25Aa2VybmVsLm9yZz4NCj4gLS0tDQo+IENo
YW5nZXMgaW4gdjI6DQo+IC0gY2hlY2sgdGltZXN0YW1wcyBpbiBXUlQxOCwgYW5kIHBhc3Nf
d2FybiBpZiB0aGV5IGRvbid0IGNoYW5nZQ0KPiAtIGhhdmUgdjQuMSB0ZXN0cyBkZWZhdWx0
IHRvIG1pbm9ydmVyc2lvbiAyDQo+IC0gaGF2ZSBERUxFRzIgb3BlbiB0aGUgZmlsZSByL3cN
Cj4gLSBhZGQgc3VwcG9ydCBmb3IgdGhlICJkZWxzdGlkIiBkcmFmdCBzeW1ib2xzDQo+IC0g
dGVzdCBkZWxlZ2F0ZWQgdGltZXN0YW1wcyBpbiBuZXcgQ0JfR0VUQVRUUiB0ZXN0cw0KPiAt
IExpbmsgdG8gdjE6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNDA5MDUtY2JfZ2V0
YXR0ci12MS0wLTBhZjA1YzY4MjM0ZkBrZXJuZWwub3JnDQo+IA0KPiAtLS0NCj4gSmVmZiBM
YXl0b24gKDcpOg0KPiAgICAgICAgV1JUMTg6IGhhdmUgaXQgYWxzbyBjaGVjayB0aGUgY3Rp
bWUgYmV0d2VlbiB3cml0ZXMNCj4gICAgICAgIERFTEVHMjogZml4IHdyaXRlIGRlbGVnYXRp
b24gdGVzdCB0byBvcGVuIHRoZSBmaWxlIFJXDQo+ICAgICAgICBweW5mczogdXBkYXRlIG1h
aW50YWluZXIgaW5mbw0KPiAgICAgICAgbmZzNC4xOiBhZGQgdHdvIENCX0dFVEFUVFIgdGVz
dHMNCj4gICAgICAgIG5mczQuMTogZGVmYXVsdCB0byBtaW5vcnZlcnNpb24gMg0KPiAgICAg
ICAgbmZzNC4xOiBhZGQgc3VwcG9ydCBmb3IgdGhlICJkZWxzdGlkIiBkcmFmdA0KPiAgICAg
ICAgc3RfZGVsZWc6IHRlc3QgZGVsZWdhdGVkIHRpbWVzdGFtcHMgaW4gQ0JfR0VUQVRUUg0K
PiANCj4gICBDT05UUklCVVRJTkcgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA2ICst
DQo+ICAgbmZzNC4wL3NlcnZlcnRlc3RzL3N0X3dyaXRlLnB5ICAgICAgICB8ICAyOCArKysr
KystLS0NCj4gICBuZnM0LjEvbmZzNGNsaWVudC5weSAgICAgICAgICAgICAgICAgIHwgICA4
ICsrLQ0KPiAgIG5mczQuMS9uZnM0bGliLnB5ICAgICAgICAgICAgICAgICAgICAgfCAgIDMg
Kw0KPiAgIG5mczQuMS9zZXJ2ZXI0MXRlc3RzL2Vudmlyb25tZW50LnB5ICAgfCAgIDMgKw0K
PiAgIG5mczQuMS9zZXJ2ZXI0MXRlc3RzL3N0X2RlbGVnYXRpb24ucHkgfCAxMDIgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiAgIG5mczQuMS90ZXN0c2VydmVyLnB5ICAg
ICAgICAgICAgICAgICAgfCAgIDIgKy0NCj4gICBuZnM0LjEveGRyZGVmL25mczQueCAgICAg
ICAgICAgICAgICAgIHwgMTExICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0N
Cj4gICA4IGZpbGVzIGNoYW5nZWQsIDI0MiBpbnNlcnRpb25zKCspLCAyMSBkZWxldGlvbnMo
LSkNCj4gLS0tDQo+IGJhc2UtY29tbWl0OiBjNzVmNjU5ODM0OThhMzI1NGUzOTcwZGE4NmVi
Njk1NDQxNWNhYzAxDQo+IGNoYW5nZS1pZDogMjAyNDA5MDUtY2JfZ2V0YXR0ci04ZGIxODRh
NWI0YmYNCj4gDQo+IEJlc3QgcmVnYXJkcywNCg0KDQoNCg==

--------------JuLfqLaAISTvtVR6PZbGI0Ke--

--------------0MdtULY3sr00A9BvRWVtf3SQ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE1GBbrQYgx8o9Vdw+hSPvAG3BU+IFAmcYH3EFAwAAAAAACgkQhSPvAG3BU+Lq
8w/+LEUdlOvcZ4fyuahFTusRphcRpNE9gO0as+zUouiKS06MLUmIJVIdam4DRka0n4uYnpy1gdmF
MuymtI7d6iezB+AzOPh2JwjkhXbD6uhmvHnkuI9Zfk8zugS5sK/5OEETPQgUMI33LHLevsUNa1xt
RQisn4EAUKsU8cvNsYvyYPNq2lnIPXfRquIg16TL37BViNq2Kz/HbN8vqnso0ZwWerWqQPwWSlBX
uMU+H7Y0ZlymezDPeQGbr6uq6kPFMcvgq6/IXPEJBqzULi9hqN/hdhWXhCw8QbNZG1un85f8n6v4
pCwN0ecTYh0rA57A2W/WKk2k+CphygjEVfZkFPgZbgF4iRoSlpeePpnVQXG5PaJGi5ng6Lk4dQK1
uC+OLGLkn66Fy6Mhlm+301G314E8cZZsyNnPU+Tx/AUy3kJxtiKofwq7ahXEd+p0kfrP++3kDDVe
fS9W9rmXmj/eS4onI39ABTazD8ehxCw0BcRLGJzj+EyApHbrNTeOAopFu7UcfqgAG1sto85eTMpG
To/JutFWxzcZN+OtO7rkz2ssNKelBNcUKhzYgqLHsAo8pFGk/YnmSUPSqITYU3t64Eng6I+kjhpk
xkuykyNCS5xwSpUsTI495FrS2dQVt0tst8AnGjHA8erEEGUwGq1R14MaKdTV6alhrc7rfrGrM+1U
WSI=
=Kuv5
-----END PGP SIGNATURE-----

--------------0MdtULY3sr00A9BvRWVtf3SQ--

