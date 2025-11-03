Return-Path: <linux-nfs+bounces-15960-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A58CC2E0BF
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 21:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F2624E2964
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 20:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9A927510B;
	Mon,  3 Nov 2025 20:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VX0Aj3N/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IWZZxjeH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E590D3D561
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 20:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762202229; cv=fail; b=HTfVVRnWONCLg07ekLICcbfK8lf2Z9fziynx9lce/QpAKFsKrEoLn4KWdOS8mxS5S266+U+KMBfHW4sp3f1m03Wbv3XyDHhvkDWnF/jBLe9UuLsfncf0cuaoc7joutPq14W1TxYGH6/iQ/BoEE4GByf5XBBRQDxgkPEeWIrU7ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762202229; c=relaxed/simple;
	bh=fMOUDnCFV34H3f52wSlzG/m+nJ9OYJ1bw5RGO8UIu84=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ukMXvzeKVUGalsv4H9IgLOWeI7QLCuOZpLQra3prcdP47HSvEIRiDdUZVPLiyjrrJr7smNfVbW6SSLmZoinyRXonJ9QoqKxnWYIu7cYBGL+NITqRIikvBFOvXp4MIu0POXaGfNgMYYRc2AC2sH9/rAEWvCUXMoNGBKX8tZRTKOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VX0Aj3N/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IWZZxjeH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3KJj8W023336;
	Mon, 3 Nov 2025 20:36:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6kBEPyjZPH/H4Vm+eS1X3i/YM2eTKuYVAUIEgmUx8O8=; b=
	VX0Aj3N/Gn0ItYcwXUovXDfDmJhTYWQwEQdaobYQJCm5TY9C4vFdYInnIt2AGjem
	dalkH3xhmb/OLThFBb8XUX7un0jmIaifzL1QDHP/UnJlj3vavhYhA47t8Bd2cVR4
	ujBcWhsZ3xh5FkeW2T06FsM7FazUNCReQoff7XO7vG6ZVPm84+qNBdPSJpORwh8q
	XacCNFDZIKSK+rY2bIkazTWDXEqgF9fA7LnNtN52Wn5elH3RtUhogaFYqUavl/aV
	ybLZTN1UDzf7930JXHH7HzT4Hj8TAJxc2jboZ098DZ+0CmZaLOxkevYVts3ajOYq
	kRNWHS71BRnUcJMBt1Xh6Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a73ay0167-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 20:36:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3Ij8EU007918;
	Mon, 3 Nov 2025 20:36:56 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010003.outbound.protection.outlook.com [52.101.201.3])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nc6dtr-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 20:36:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wbediy2HMVsf0KosbVE/PhJmu4sMgsDrKBbaw1px7UFd083YQJHhTm7syu6r45ZbyB6j8y1v3PBxTcGoK6/iQPfTK0YAhE/6cNJUI7ntatJkCARPyIunpAORgtCHPgbanzCZmB/rRfFNYNsWWqhwDHyozxUVNm0bpN/VobzdgaWN4KdpN2A5kJaIzt2kiC8rjWWfC26UB/AngQ2b+02G2DTO/liQRfZahKmE3tMzY2PHNk8oAGV63EM05S/zBYFpnjTJkLOOvPeEYd+8Tr2DEvx48BFDI1Csj2jGIhraYq8N0hVQ/clOY/Bnib/IpUfODN4LBUyzcjVy9OAhao0Z2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kBEPyjZPH/H4Vm+eS1X3i/YM2eTKuYVAUIEgmUx8O8=;
 b=EUL6OgtvC4V9d42vsKvmYUtdLCvDZNH2lim/GGO2byHXjvj9KxJJ0JUN/qB3gK3Y3Hugdg6eqQZl5cPDe6Uf4FuyiHxrLP7Q51JeM171lZjqVUcL0LSuhOzRCSs5zdXAoSzERbz0CwGZLD0qYdUQtDhzz5UX0y1HctyKq8TFVAqloERTcjJk+nQowBUSp5huKuO42+v7Mf2e4WacxxYPeUt5FCambVX47hmjSzpgeBPOcjQXk2H4LHjJVn5Uemvb3svsJvW1P8LXnO31JnbA4eWhDfVx+BqqFJ5jt4mCXG98JhjoDY8Do24Eu0p/pnLJt43nuBuH8P706DKMyqP9aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kBEPyjZPH/H4Vm+eS1X3i/YM2eTKuYVAUIEgmUx8O8=;
 b=IWZZxjeHCu6SohWfjUtGZrKbh/5jitsaVBCKjMkZPulWhS66EwT2VALru1aCfvZcp9eyM6keBNi37ibtnsCarVAchkzb0wUrg6FH5OWNM7oxHyR+5jMHXgeEexDBz1wMcNmax5Izsb1We4w90X16wfDEcl1J17X8oivmz+r1AVQ=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by PH7PR10MB7696.namprd10.prod.outlook.com (2603:10b6:510:2e5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Mon, 3 Nov
 2025 20:36:52 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%4]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 20:36:52 +0000
Message-ID: <5195fb82-0ebc-43a5-9b9a-54ad0d74e92c@oracle.com>
Date: Mon, 3 Nov 2025 12:36:48 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] NFSD: Do not fence the client on
 NFS4ERR_RETRY_UNCACHED_REP error
To: Chuck Lever <chuck.lever@oracle.com>, Christoph Hellwig <hch@lst.de>
Cc: jlayton@kernel.org, neilb@ownmail.net, okorniev@redhat.com, tom@talpey.com,
        linux-nfs@vger.kernel.org
References: <20251101185220.663905-1-dai.ngo@oracle.com>
 <20251101185220.663905-3-dai.ngo@oracle.com> <20251103114500.GC14852@lst.de>
 <841a3ef8-d5c8-4f87-9244-f79a10c66e3b@oracle.com>
 <b8489e0f-550c-4c63-8429-fb2d44f24c0e@oracle.com>
 <f0d7da8c-2447-4f57-a64c-6a8eb7853019@oracle.com>
 <f4ddebf0-7039-47c9-8e20-9622c8b33ddd@oracle.com>
 <40c969cf-9898-48f5-88bb-d6bed7b54a9c@oracle.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <40c969cf-9898-48f5-88bb-d6bed7b54a9c@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::14) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|PH7PR10MB7696:EE_
X-MS-Office365-Filtering-Correlation-Id: 825118b4-8322-4aa1-1555-08de1b18b884
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?WldFSm8rQWpJTTJoVGl4OXArTFBRR2dRdTh2N2pxbmx1cU1WY0MxRzluT0g5?=
 =?utf-8?B?TkVSNmd3SWJoWmNOV0NYZlYyMnIwTlQvbytXaE1XUkxVbzdTK0Qyei9EMWF5?=
 =?utf-8?B?dHpVOG1mUytsYWd3amN5UDJrMmxGUVNjRDJJeE4yU0ZmY3g2eVlFSGxkeG80?=
 =?utf-8?B?Ym1CY2NZRTNyQ2hmQWQ2VTIzSGRYT1lEVlp0WW0zQmpiMjhCdnNDQ3ZwbElX?=
 =?utf-8?B?cHZFdS82UlliU0ZNY0ZlU05HK21IeFhKVzZNaHBELy9NU0hQMlUyWUhiTkN5?=
 =?utf-8?B?ZHFzSmtkNC9pWkRjY0tDK3RRZGhlLys2enVTSnpiZDkrQ25NUFNtd1pRSUsy?=
 =?utf-8?B?Uk9QY01tVnBFSFJPTWluU3JnVEIzYzRUcVpjS053RGpyR081bzZySU0zLzYw?=
 =?utf-8?B?QUwwdkRITER1VG5VT0tibUVTeHBiZGdzK1FPQlMvMzltNVNnYzE4Y1lobHlO?=
 =?utf-8?B?WllhbDNvTzgrWWJQcXFxVTlDeC9DMXNLQUlic1VkTHRqdVJkZ2s0UWZVb2E3?=
 =?utf-8?B?M0w4WURUTHB1bS9TOStsbEllZGpqOTd0U1YvWThwdDhGL0ZONmhwU1FVQmJz?=
 =?utf-8?B?YlJkaUNLdFVCV2JPRDg1YlcwOUhNWG9TSzQxaVB5ZXlvZ3kyYnhrcUNEOFRS?=
 =?utf-8?B?T2FGcGRtdUh6STNVQkZSbnFRdzdlTHZ4a1d4SS9GNG1ReW16QUFVT3VhZVVa?=
 =?utf-8?B?a0szdTBQR1lRZ2dDUm5Ha2lCaEVPQXROSWp1T0kwcW1kUDNwWTd3SWRJb2tr?=
 =?utf-8?B?TkpPaHJDZ0dpd04zdDlJbjFnOXVVMEU3MVUxektpeWhFN0k1eCtELytSWFRw?=
 =?utf-8?B?OEtld0JSYXRSRDhyajlXM1BMY0ZUR3N0NEx0UmptandHR0pjaHZ2a1lRSmdR?=
 =?utf-8?B?L1UvV3pKTFk0Vk43SXJEQlhLWlZnUWJRSVdGVDJzQ2srNnZtc1pjaGZHRlZn?=
 =?utf-8?B?d0JkL3o0WTB1eGk4b3Q1TU8zQUtpaFhZQ1kzVnA1bUQ3dHE0Zms4MEpQM0Ir?=
 =?utf-8?B?eDBMZDNxTHZLTWl0Tkd1L01YaWV0eXd2WmdVNlZzeUhEWGpCaGovUFZkc0dU?=
 =?utf-8?B?OGxPbDlxTlZuOXkzV0ZhOHk2c2ovRXdMSy9vcDVOU3poMFdYTzBoVkIwVEVm?=
 =?utf-8?B?MEY1NTd3SU5mWkVhN3FOTUVtaDUwN3BuVTRhZlRlV3hTRkJRa0RWYkRYUVZ6?=
 =?utf-8?B?YU12M1NhTEoxQjh6QmcyM0xmVGx3NEd6QnFreE1PY0pUWFlxSVdMdFhsYzJC?=
 =?utf-8?B?WDY4K3dtLzZZZkZWcm1rcnd5R3lmdDM1Sm9veE5NSTBrRVpaK0VzL1hhNldH?=
 =?utf-8?B?ck1LYXpmV20vSUFhaXlCb25TUldmQjBZRGdJbUdTZXpJWlU4OTg2bmgxeU5B?=
 =?utf-8?B?SERPWGVwemZBYnhndVByWCt3Z1NuMHlLQndldHVMSGpDZ1ZtWE10SU9VYTdt?=
 =?utf-8?B?ck81MFhOaWRZekJaSlBsQVE2Q25DdVpiTDJBR2lZWUR4ZFc3aWNIRjBuQmpQ?=
 =?utf-8?B?aXE2dmQrWURXdWlPWWdaQlN2eGhzMS9qTGlHSCtERlhTY0xYMWREekcxcVlL?=
 =?utf-8?B?Q1l4WWhLUXc1eFZNQ3J2bDU5a3k3NlFkUjRyc1dYNmZDcGpUVmhlRkxQS0RP?=
 =?utf-8?B?TGxIUGlwSFFGS0x1NEFDNzBVb2JEaWorSW1JTlBJcGo2Q2s2VlZacjVtaFVH?=
 =?utf-8?B?UWIyUnpFMjN5TE1RS0drMWhTTmNyTzBGVzNtcy9TUFhMWXRkMENFeTBmWXZU?=
 =?utf-8?B?akF2RXBVaDZSRXgyK0VXWldlT3VMcUlCVEV0MFdEMHN5TTQ0bTB5ZkRXaUJk?=
 =?utf-8?B?SzA2VE1tOVNqUVp5TURuVDhRM1l0UUxaUGZuTHBJdDRHcHh3N2pBU1hrcHg4?=
 =?utf-8?B?UXl5ZjR6RnNTaTNwa3JnUVF6QWRFWjUvYTYwNXhSeU9Pb1lyQ3lIM3NJcUpW?=
 =?utf-8?Q?GYOTbrbvJI1rw78EqIbThuQw77Rbm+NH?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?eUJkSFhKV2lZQ25YK1BVaFBHOVB4WUdkVWU5eUk4YThHVHJmQXk0M3dybGg0?=
 =?utf-8?B?ZWluYXRSUXJhWi9MMGt0ZnpaK1pjVHNhc1l6TWtsQkR5TmJOdWxyektnaHJx?=
 =?utf-8?B?YVFMTjE2L3h5QjR3bElGU1lNNGhzQWZGN2xwclRaSWFZUVdXNXBEYXBDTVE4?=
 =?utf-8?B?eXgrZnZUOENQRWpvSGpyWnU3aDl3OGpwb2pqZDhMY2cyei9YMHFUVVZtQnFs?=
 =?utf-8?B?a01xWGdDTUJ1RU84QUtEdGRYY0FwR1o1UzNoKzFuQWI5RlNrUnFyNzczZVRH?=
 =?utf-8?B?V1p2am5hY2svcXEwSXliNWJGWlBnVWFFdG1QOGF6ZTg3aXkxL2llYVh6UnZS?=
 =?utf-8?B?dll2d050SHQ1QzVGcUo2bnh6SzFVZ2RDZVB3MjN1eFFTRFdzZTdqK1ZEZnZV?=
 =?utf-8?B?ZXp4NWhrVGE3d3IyVktQTVAycTgzTEprUCs3cmlCN1d5VWt0R3NEQVNZdjVp?=
 =?utf-8?B?RDhSTm9Rb0JCYmZQK1c3RFdUV0J3MUJjZUtSK1BBWExNZkwxUlZQd2VXMWxx?=
 =?utf-8?B?SStiQ2dvYTA1RjM5bmRlTktCb25aUXc1NlR3ZDdNcTN4enFER2xyVm1yRTUy?=
 =?utf-8?B?a3FRZE9XMGFIbjh5QWc3ZmlIOUhkdnJrdEJGVzZLOVF2bHBKTXpIZXJOM2FW?=
 =?utf-8?B?aUlzUE9ZOVhYYlQ2bldHNEh4Slo0VVF2cXRCRzFYS2NOaE9HKzRRWG1UZWM5?=
 =?utf-8?B?ZlVtY2hiK2NCODdmUlUrekd3RUp3cWRaalN0ckpGS1NJc0E5UHRnUzFzV1NW?=
 =?utf-8?B?RytTZXduVWNkbEhrNWVzTFZIRHBOVDQ5a0lCQ0srWU1SbEdpNEo5dkczaFVy?=
 =?utf-8?B?eDhRSDhrelRWOEkydmpjNG5vVDhOamJaZElveVhqTnltKzFNaHU4bDJjWmVm?=
 =?utf-8?B?bU51dTEzME9EVzJzWkJUWEdmbzJVRG5WaHcxdHBzMGxSMCtHRkFqVndyRjBB?=
 =?utf-8?B?YktzMEdobmZBLytyeFB4U2JhNUdOY3o5UWRWKzdBNlJCM1V1VXBTWEVnNlJ4?=
 =?utf-8?B?LzlxRXErMnNYMnR5U3c5ck9TL1JPa3VZeEhEMXJyaUxxbGN4N1AxNTlkWHZ1?=
 =?utf-8?B?V0lJOXREVysyQXFnVEpHSDVrangrR3JmWXdOcjFPemFaQXpmNnpwR3gwSjN6?=
 =?utf-8?B?bDV6QmNZQ3BxcXp2Ny9xeUpJdU9jdFBPTHQxZDdCUDFLNDRwcW1JYkkyMFZm?=
 =?utf-8?B?a2JKejdTY29VQzl1ZlZSTGFMcVZodWRjV1dmWE5CbEsrS1dSMElHZHpVUldJ?=
 =?utf-8?B?bkJNa25sQk5oMUx2d2JvT2oyaEZmVngyYmVqS2cwZWFjQ0puOWhiVW9oVTd5?=
 =?utf-8?B?dlVrWnZZOVFpeGcybWJIZlYxTVBKNVhnakYxZzhUSEdUYzRZb296d20zL0R2?=
 =?utf-8?B?YjlVTlRFK0p2RjlpeGNhNVh5VVBPQ3hUY3c5NGE3bHBzUGorMElpMkFtNkQw?=
 =?utf-8?B?WE9GTFhZalVWbG1aWjFOKzllMGFxWjd4bnBGbHlBUVpvbEc5cVdGOEVOcWNO?=
 =?utf-8?B?Z2N5amVkME1MUWxWNk44a1cveGx3UEw4bWFvOEQvbnNYK2ZyQUZtU2VWa3J4?=
 =?utf-8?B?N3RncVhRRXorYmZDU2M1cUV0S0tZUksvR1JyTzRLWFNsWi8xbFh3VWs5U2Jm?=
 =?utf-8?B?eHp4VXJxZFd4SGJRMXQ3Qng5clU5b294a2J3Qnd2L1MrMVYvZUl0SElsN3Vt?=
 =?utf-8?B?a2RiNG4yZmlqMTkrdlpla1VGa3J5SUhJTFVsUVo3bTdjcjBPOWtydFNsa2FO?=
 =?utf-8?B?cEdRc2pwamZGMUZmRDBQZUhQVVN3dG8zMmk1QkRnbnhXYmhPNUcyMDFTNWxx?=
 =?utf-8?B?N2lLRk1DQXNaMXJWa2phdVVuRUdlVzRnUkNXQmxHYXhTTUJaek5BZitydGx0?=
 =?utf-8?B?bEZ0UFBFSFpmR0c4dTdUaFkxSm1VZ25BWHdPblFMWGhLWHR0NE8xQ3VhZ01S?=
 =?utf-8?B?MjhORXJmdFNJSFlsczM4WXl6VDZiRk1KbFVqODJZRWZxRnc5RHh4cnVDQ1dy?=
 =?utf-8?B?K21jeDRGQ1dsVlFReVRSR1hLWG9TS2hSL3FmQzZmbFJJQUlDQW9mVGVGemsy?=
 =?utf-8?B?d3FGdnZxZm9XUWZ5SWI5ODdkUXNRZndVRkRFemZUajBLUFJKRktzTnpVYm1C?=
 =?utf-8?Q?saZbRbRKhyWnHS5ilMQBsiS3z?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dJUzC5YpnRtbINSZE54yJaNKkhit1x9Tt2vOTZrZjTYT+abssKVH3YxMghNk3cU/jaQBf4pWutXyKdLWLGP+rc4j8/2g4svSHcirGHz7KMZbLxQi1NzChTptUfkejTkrAJl9llAt7LybQ2nzj3O2kpRJyYyzaOYCpJ1GtjcIdmU8PBZGMXt8X1e0cn3Z4yOxHWNGhr8NGigqf3P6/4ZRa9b5/XVXHlwXr2X1gAVhVRjwa6gCe5XzioKm3h0SZVQNVfhabV6txdDSKGOjvXvRMDFIMjucPq/qYvR7uarYxEYcEFFe5yxQbSVwPAfCZKW7OGI9zFU3rHe5DRoO/FhTkcnJX24FsZ5+UWVobAva4Mh7uDsV3WuYBT3NH1uClm/uyDlMadlCMfn6nhcwc05Gd3M01a4V5enGQR22TuoieBWbXDbr1gUgutxRr1RWEr9daxWOWordDmixXSDsO/Rb6yqSZhIMvxadvSZy2BTxvpy6WsSlua1cbrAwlHiSaanyIIR06k1FVIHVCd+1OxSkaXu5MGV7jN6vx5WcdaTuqGUs42PN7/uFaw7K0j37E3VGVw+FfQljv3/DrlsR1hOrjxHGZwUhH2wZQtONR14EED0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 825118b4-8322-4aa1-1555-08de1b18b884
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 20:36:52.3905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SNpFc6leZUtXkQkv0TE5vwUfzv2SCvdF0eE1890jdvO8wSYLK6Y3K1uCmPZ/O3bCj9LeUd1kg7mDKqiFV++GlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7696
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_05,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511030184
X-Authority-Analysis: v=2.4 cv=D5xK6/Rj c=1 sm=1 tr=0 ts=69091268 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=xeeOHubOfyzynDMOh1AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12123
X-Proofpoint-GUID: 6sUh1xzXgtQZMunLxRaIm3G1NKp6FP3J
X-Proofpoint-ORIG-GUID: 6sUh1xzXgtQZMunLxRaIm3G1NKp6FP3J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDE4MiBTYWx0ZWRfX4F8XpXh+4i3F
 qooBGaAtwsPXnw1s2VGhEaN0pRt4YDxAnoEFQlixDkqR/XmUJD6oytpD4UZc8DdaKWNUdZcWIHJ
 uZ3Zsfuh4p79qzoh6czkD7brcdluf7yRK0Imz/ocAahT6IfhoNqcqkCDnxdZYa+jNn+edstLFIw
 PjE6H2pIv5xu6QMmhlFZu1YZN2YxqYmMHVoO/7U6lF5kMS8tjfi9+bUBOlZGETgHo7P/HR8Wz1U
 pMivBRbAcWPT3/dtL//b6D1Mg9lMFMtGafULsi4pyD907I9Fq0u9+Fz0hm1pLZl5mvRcxqu0Yus
 m3a5yn6KJ7LJAFDr8ryJGOkaO0z00ihg7ihvcASXyouIxnk9Rk0rbHtkhTzW06RFauty57/DTuk
 kPWxtnBXHCy6zwic3yBei1a07rPdWMZTVER2a7xQyNRAr1LmTTs=


On 11/3/25 12:15 PM, Chuck Lever wrote:
> On 11/3/25 2:14 PM, Dai Ngo wrote:
>>>    and I disagree that fencing is harsh, because
>>> NFS4ERR_RETRY_UNCACHED_REP is supposed to be quite rare, and of course
>>> there are other ways this error can happen.
>> Yes, this error should be rare. But is fencing the client is a correct
>> solution for it? IMHO, NFS4ERR_RETRY_UNCACHED_REP means the client has
>> received and replied to the server, it just somehow the server did not
>> see the reply due to many reasons.
> Fencing seems appropriate when there is a clear indication that the
> client and server state are out of sync. The question is why, and how do
> we prevent that situation from occurring? And, when we get into this
> state, what is the correct recovery?
>
> I don't see NFSD doing this short-circuit when processing a CB_RECALL
> response, for instance.
>
>
>> I think in this case we should just
>> mark the back channel down and let the client recover it, instead of
>> fencing the client.
> Clearly the backchannel needs to recover properly from
> NFS4ERR_RETRY_UNCACHED_REP, and if it goes into a loop, something is not
> right. I don't think this is the correct fix for looping, either.
>
> I don't understand why, after the server indicates a backchannel fault,
> the client and server don't replace the session. The server is trying
> to re-use what is obviously an incorrect slot sequence ID; it shouldn't
> expect any different result by retrying.
>
> So, yes, there are one or more real bugs here. But ignoring a sign that
> state synchrony has been lost is not the right fix.

ok, I'll drop this patch. This error occurs due to the hard hang problem.
In that case, there is no back channel recovery, no new session, etc takes
place, the callback code just keep retrying forever.

Let fix the hang problem first and we can take care of this error later
if it still happens.

-Dai


