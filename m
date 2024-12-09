Return-Path: <linux-nfs+bounces-8473-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F215A9E9D03
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 18:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71E13166945
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 17:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF8414F9F8;
	Mon,  9 Dec 2024 17:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cIG9gk4P";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xNRIttQ2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59B54409
	for <linux-nfs@vger.kernel.org>; Mon,  9 Dec 2024 17:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733765145; cv=fail; b=AoOYk1V+dRwilosr62foWAGTqm/8XSxRuw5m42J9xvljl9RF83XdfoiLC0LWfDKz5Scmxylhxr0uq5ht9Vovh0lefW5ANT78wChJ72iXoB/8/zWtMPAXwcFSI0NLftV9Thf/sCrMLVTHbzlVOCsDAyDb3xRnBo63w4WC39A++yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733765145; c=relaxed/simple;
	bh=4jx3rp6dup9Z6FBxUqYiLdT6CwenQG2wdWjkY0e2Wvs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gAP0aXlfgGZFM1AkaSOGNhpjTnkmwJTTYn8VKqKvbrV8oDMug72e91mz9s/TLDzgVJM90LudjTc8rzL7b3JpvJ2N+MBEx3tdZWai85marsq6ovVHpMqUc9t5aVShIY+SqFFxE6NA68BXmd55iKtunwPbb+a4O/2bUDvp49IFHu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cIG9gk4P; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xNRIttQ2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9GfoJg026161;
	Mon, 9 Dec 2024 17:25:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=U89hKa1tE6D3RLBuIQ83+g11lCp16sxX9zJN/fDKnyg=; b=
	cIG9gk4PB/i1YpA7jHYJbMRq7pFuyYfjsXI/LhDk6YPir0vhU45+EeMYLxmN9qFF
	HjWfsOLmgEWiOEZroxhpIVgLhz8Sq+OMa7N7w6D8Phnm/+5l9ti9Vi8I6nB8lRGi
	MdwFFh+HNNq2FhFzwfy6Sb7RrZLz2elmkHKp46AOANgpn4ekQmdRCb0KjczUUBQ8
	/jhHqvAYZecnpBZ67wrweNHx1lfYMHWaNvvzNSvsO0/7mCxe4Z0WD72AFmPhHrMz
	w/CrPV5Oh6n3dyJ0T+84aeoVwokuVTGpMNL0zVGnZ2IUrIFcSZXrAUXKHaWSfTGV
	ZtrJfrP4RBAZlLfaUZyivw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43ddr61vpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 17:25:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9Fkq6i038087;
	Mon, 9 Dec 2024 17:25:25 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43cctdqpnu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 17:25:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T2fl/aAJsfve4L6FScUJl4NlqaveHXLDpjms+Xf3WQhcU6jh4zFuVQ6MWqPpr7P4YaKDZJdIJ7/N1zRqYaMoI/PCwezeo37YAPm/wwgc88GAtfOZ3r3YpRpy7WmX40OZDGUqX47RnNN2LtddkXTUyNlzJQyPHiJFT2iXFy/7uEbwIPTWu6nqGSOLFNBuZ4tOORFP5rJnjij/sKWGDsmWT0g5CiUzmM3eyOgR6nZ9l+oVk0ZLHaDDDa03d6bzJjK9fr4O/IxpdQD3enPYfoxF1vUoquJVdXhALuh/1XXiphwMk1g+5OEWyLNzGw5Y6ZIbNODe7tk0yWbQX/dzSlrHsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U89hKa1tE6D3RLBuIQ83+g11lCp16sxX9zJN/fDKnyg=;
 b=ZqgVmYP0tMdWAvEl2eeEXygdiPSpvWWMQzVGyQBv4EcoIwu7feYLRHaadJ4qNbmWKwyqIdAevvj5ajFEFU6ZDKVKjoT1rvG867JoCfnJXlqvzbJX0bQlksYUC2bVjfYc3ObbnJ/raXfe1Rq290e4BF6aEgUdrX0gMABJ3gd7qForK/+OF9hvuEgjO79/2fbtZ1bZZcXZHG3kcXzjqAmuli33FLiM0VQVBibhmbrtMB1pvI9fWwaply+7Ziats7I4qkvDl51NX6s74E/gXB+e46Tjxm2wHSTHR+Zc4kGpfpAOw5bwvgv8hAXKna6VYPgEGg0uaUXzQb6EOmQIDFU5wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U89hKa1tE6D3RLBuIQ83+g11lCp16sxX9zJN/fDKnyg=;
 b=xNRIttQ2cdmkzPEcsaokYLR+DysNDBMH+FsOE+/oCpHtS+TPpOIQLgL9/EWrDYUEYkiMePuuDJsxBGYmSuX1EEZ/l83MN+syZWT8c1SqUYNUW0Em63Pyvd8xjAdD4MIrL0mNRfmDaZV0tpScDdxVA1Gq4MQ/duWeS4Myk8ThXUE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4226.namprd10.prod.outlook.com (2603:10b6:a03:210::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.19; Mon, 9 Dec
 2024 17:25:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 17:25:22 +0000
Message-ID: <f306d92f-5d5f-4e7d-99b8-19efeda0078b@oracle.com>
Date: Mon, 9 Dec 2024 12:25:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nfsd: don't use sv_nrthreads in connection limiting
 calculations.
To: NeilBrown <neilb@suse.de>, Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Jeff Layton <jlayton@kernel.org>
References: <20241209004310.728309-1-neilb@suse.de>
 <20241209004310.728309-2-neilb@suse.de>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20241209004310.728309-2-neilb@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR10CA0024.namprd10.prod.outlook.com
 (2603:10b6:610:4c::34) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BY5PR10MB4226:EE_
X-MS-Office365-Filtering-Correlation-Id: 54a5aa5e-e4c1-4593-aeec-08dd1876761f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2NoRjhQY0U5QitGUFlocUsrSzBOeHpjUi9Hc01JOEloTWxKTGhiK3NVMUZY?=
 =?utf-8?B?ZFpDSXlFUGtId0V6U2sraDdtQS9rbFVGOUpoNGF6b2ZUbVpvdVJaZ0hLSmhJ?=
 =?utf-8?B?K09KOVlnYllWY0tuY3AyZnpPeUgva2xqWSt5K0wxKzhGWStqamMzTis0dVdw?=
 =?utf-8?B?THVOY0NUNndUYnBKdU1GZXZHazczaVRSZGd2VGJVUEVRMVNuNVlHbDRiMFAw?=
 =?utf-8?B?L05kZEtob2l3WDhsYTNQdVZoYjhaWGsyRlJzMU16SzJ6Z2RCMFNSbHpoaUxy?=
 =?utf-8?B?dUtwRzAzU2J5d2FKQkg5SlFBTmJua1VZR1NxMWVkYnM4cHI0NEJDcnIwRTcy?=
 =?utf-8?B?UnVRQ3ltUHhjR1I1WGR4aWZMTVJ5bmI0emZicUNIcTJ3eE1DVkJNWXJGci84?=
 =?utf-8?B?cEJPUkp5enVIRTE4YUx2ZjNabkZjbmNhNFQwR0puVXQrQlUzeTNtTnd0TXBH?=
 =?utf-8?B?d3VzSFZBNTl6aFFaZkRSUDc4R1pzR3p0YzZXT09UMGduNTlVamNQNEhaeG45?=
 =?utf-8?B?ZmpudHhTSkdoYlJ2WHNhempkbkNFOXo5eGZFWXhFQzdibGM0Y3Rld1VYMEt6?=
 =?utf-8?B?ZVZBelJiS1hoN1dTbkxxWTZ2aDMrbGtzdXJWaUY1bm9oMnVnZ1BVdkN5Y0JI?=
 =?utf-8?B?OVdHRG15Mko5cmJZR0xadFF0MkNwMUlXTlhBd085WkVLQUN4eXAwL1FkWGdO?=
 =?utf-8?B?MVYyV3FmbkNEUVJrUWJoL3ZjMFlnRkJZNUxPNVBpQ2xqTzF4dlBKbUZuSjRQ?=
 =?utf-8?B?RUpWSFpMZWVPNHpaSmVvTjEzaTdKWmkydlhuOE5oREkvN1BNWWNaVnB1b2J5?=
 =?utf-8?B?YjRjTEtPMlJwSDA3aG96V3IxQWp5Mzl2RFZ1bzh5SXBIT09nVFNMQ0hzYXJB?=
 =?utf-8?B?WjI3ai8zdTBaa2liNjBRZENWNFNaWVhWVTVFNDFxVk1FenpweWlUS3BqaU9G?=
 =?utf-8?B?d0RKUkkwZXBuSFN0OURhbEtJNU9ib1JNczFUdW1Eei9xZWZ5OEpGTm1TSFVn?=
 =?utf-8?B?T3hFeUd2UDcraDg2eVFlL3IzMitzbnhYN3hzc1RRQXRZTE9ZT3hkemJvUnRx?=
 =?utf-8?B?NWd4bTc1RGxncFVNTXRVNE9FQy82UndYYWxINEFrZDkybU5PTWpFZDhxRnBo?=
 =?utf-8?B?MzFKdjY4RU83eE12ZnVSZDJocnE0VnIrUkRqV1pWR3NlZHhLRTEvZEZrTjhW?=
 =?utf-8?B?MUhlQ004L0ltV2duK3JhMVUzUnVhNEtrQU84eWhvMGlOQjJvOEQrTzFJRVYr?=
 =?utf-8?B?ZGZVa2hCcWtoTFpGSVlPU2xRODRKNHh1c0oyOFVKRkpXSG9XSE05endWai9u?=
 =?utf-8?B?TXB2cGd3aXJleXQzamlmaUJSY21RbitMWWVSZ0JrbUFZQVlaQUQvNXVrc2xH?=
 =?utf-8?B?NklhNlNmVkwzT2JUZTBqMzJHY0NCUXJhcjJYR1JETE5xYWoyMkhRTElzY1Az?=
 =?utf-8?B?dEt2WGJvS2R1ZkM0OHFOZHBkZjhXWCtxOFh4aTh0TWxCclRUS2djWEtoc3dR?=
 =?utf-8?B?MlMrREU4czFodFR5dXc4QnJIc08va0QxeEFsS2VvYWVpd1B1cEl2NUUwZWlw?=
 =?utf-8?B?aW9STHlCZGZlSWIybHRGekZ0WENQbVROelJmZzVFckVmSGJsTXozcW43K0tF?=
 =?utf-8?B?ZHk4NWFoWmU1T2RUMXFkQm05NjJPWi8veWg4SjZBbzVaZ0NrUDVvMndUYy9D?=
 =?utf-8?B?OVNXcFgxWWhCR2QyNW9UUitRZmNPN3doR3BmWE5kREFvMU0xUHJjRWd0K1BN?=
 =?utf-8?B?S1BwZjBXNFljV2RDRDFaVUczeEM5cnNONzlBdm4vNjd4eFFvdUxaUzM3b04w?=
 =?utf-8?B?dlFLQ21EQnJBdDZPYlUyUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SitxTUkyMXNoL0k2aklvbWRJUlcxY0tTdk83cVExWTdBdWkyQ3JEUEVNL1Fq?=
 =?utf-8?B?WjBaWEs0RElySU04REN6Mnp5UHV3NzdRNlh0ZXdhcnJkSFpQODN0aStCYm1a?=
 =?utf-8?B?N0U4a2Q5RzMvNzVtcjRLMGlpdG1jaFlTandISEtYRlhkN1dQZGdnMko5M1ZH?=
 =?utf-8?B?ejBRbHFZRllWdkc4YUUva0dBN1hJY0l0RytETGxSRTJDVWpXZFFSNTlZWTRP?=
 =?utf-8?B?U3lReXlNazBkam91T3d1RlNQNUhtOExoNkJERjQ0bExJK0k4ZDNnMzgyU044?=
 =?utf-8?B?Y1YzZFMwU3NFNHNwS0FmNTNBU1owS01IVTdib0l1SXJFUnlZN2pweXIyTlpI?=
 =?utf-8?B?U2JtODkrMzZnQk1KeGhhdDRpeXVmWS9FWWhoSUhsc3NoeTF5c1FGc3V2aDZ4?=
 =?utf-8?B?STE2ZkhENHZIZm1vRTNPNzlSSGlKUCtZTXhCOHE2MlMwNC9CMEx3MnVid0M2?=
 =?utf-8?B?d1NJQU9aWDZGVVNJeFZTRDYxNEJIc0twUVBrRVkzWVZOZnFkTEFuY1M5enIx?=
 =?utf-8?B?SHJWMEUrTlh3TDl4T3k4bEsyejNtNzhRR2lzeWlPNDZ6S283cWQvRG5adW56?=
 =?utf-8?B?SDFLbW0zQ0pybGFlR3R0V042SkljV3RkbHVLQWMzQWFCam9PNnA1TUYzZ3VH?=
 =?utf-8?B?amN6SDk3M2NoZjBEU3JqVnhud2NPeVo4bzdTYXlMV0JhQWVsalQrU2FORnhr?=
 =?utf-8?B?QkFNVlc0R0M5cUt1VU5UcnZ1WHUvOGdDTXpudzdqWVBWYUxlaWtVOTkzTXMx?=
 =?utf-8?B?Q1h4Vlg1VHd5YUx0ZS9rNmVXVCtycVRXTUVMSjA5MFpZZ1RyMm9DejVESzU4?=
 =?utf-8?B?b0h6d1ZJTGkwNEpVbEpxOEJrcFQ4S1ZldEQwWlVPQlZmVHg0Vm9nWVEwNlJO?=
 =?utf-8?B?L3llcjV6dGNhTUVrem1vUkc2b29rbmhucm93d0hBQ0dKQlRvR2dkYjcyQnlK?=
 =?utf-8?B?Y0Y4a3Q4UzVOdmYwazVKaGhsUEpWNDhSc1Zyd3U0dHdQK0NtbTFyZlhBclRJ?=
 =?utf-8?B?ZzhWWGJvLys1SWdxUktsd3Z2QTVnNWJmTXRsVGlqZmkwQTNEVU5RZHVNWTVK?=
 =?utf-8?B?QURrOFNGRUwzRTRjY0pNaWRzaFhZVWZGTzJoQnV3a2xCNmlia1FVVk5abVhV?=
 =?utf-8?B?aU9SRURENUZUa1RxOEN2bFVndllXWkYyaVlSYUZmNkhHdS9CTTNFQVExZVlq?=
 =?utf-8?B?VjZmMmc1ckJSdGduektlT2Q2cFdHbGd0UkJqeHpWWnlMdEM5UVpvZ01rV2w1?=
 =?utf-8?B?M0FSeGhyeWg3VEdnME1yRTNTMEx4dC9PZkZWbnk0UkI2R1dxVTFZdjBFaXdW?=
 =?utf-8?B?V3piQ2QvTVU2UnN2R2t4MisxS1Nmcjh0ZHVjRFV3dDZnY1lxUjZKMU84T0c3?=
 =?utf-8?B?bzBkYXhmVFFmbXYzUmJudm11QVJXVlNRWVZudWlVRXBsQ1FGUTFEb2FhTTlH?=
 =?utf-8?B?WEtxT01wcmY0SGc3RVhVN0o4Yzl2K09SMXJzblZJSFhlWFNoOUh2UXU2Qis2?=
 =?utf-8?B?SGVWSWEyT1FZQWl1cUdkRENEZlJDdmRZM29BdXJTZEx0ekhMU2pJMFRmVnZj?=
 =?utf-8?B?OGN5RU5hQ1RkTUtFMjE2bzJqVi9QRDZlMWVQTmx5Mmc2WWNtVmZTb205VFkz?=
 =?utf-8?B?a2VQZ2ZqS0tTL3YvcHJaWENLZStCQVhkU24wMFpaV081WlZ3VnBzd2xsdC9F?=
 =?utf-8?B?NmJVVWlKbTI4NVV1bDM1aVNZVWxNNFg0NlEvZ000UGxXQ2pLa3FNOW91VFI4?=
 =?utf-8?B?VldtNnh1S3czeHU3OTBSbklUbFJ1eE9TUS9pbHhvd25JNndqTmU5OTNIMXZz?=
 =?utf-8?B?OTJZM2szVFBCTCtwQ3VqV2xDdU03R3hzb2IwWmR1U2l3aDZ3bkpPRW5sRGRL?=
 =?utf-8?B?dFNWM3liR2lEaWw4M2draE9ad1hiRXh0SWIzbU40cENnaDN3aTREMUxNdDlN?=
 =?utf-8?B?M3l3enppV2ZsVDRERC9FcGtTZ3pzTEtXVk1XTlpRWUwrVExmWnJOZ3J3ZTFa?=
 =?utf-8?B?b0RtNk5KblNJd3hiVGpRc25VOUZDUWJLclljdnNLRW80dEhyQ3NLd2dNMFFy?=
 =?utf-8?B?NjdGMnRIR0xBRHRVSG5Fckdid3hocDZxWlMwZUwwbjVBeGd5ZWd3U2Fvb0Fm?=
 =?utf-8?B?MncxWXJ0UEZkaXAxOXRIM0ZVRWRoMUI4bUxNdUR5cnhxSC8ydEJUaGg0U3pV?=
 =?utf-8?B?Wmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/7LnmwR0cQXB4HNuZ6n3VxjGMw1/xsPlr+t9PyNsv7ndIuHHeWa/AHQRbNBQRzy2+yQ2w153ZB2qF96v0IaV6PFFmcB0dZHyaRz0NAW8jYgBYgiSjkVTqs9rEOYtHCPOwVBLWdCckfqU0n4ELAvoAxBWzqcMa+kEeq7h4nvATAmhhr0hDN8dJC6VKZpmqVnFqO/+WvtOueSDoRnPI5xnCCTkTewczXe/ninFs4ZHWuREG1Ly3BA4e9fi+NV09SBEwVqXC4yVwEsIJGLmsKG2jK3bz0CHQoE4dDl5ZVxMj8Nyiy1IQTciVI+uVLvNhZbI0tRaEpmjNGKv4JKWWOua7NWsTdSGsDi/K0lQv+NdURyLxGEu2IJcTclV9Q+M2mZRk9P6wbd5c2U1q2wKKENBme6oceFm1roV0SNlI/vJ21DR86CE9V/2lTOYzgcQQWwXMwMkvpHi0nmdTh255C46/DO6+i4KofN4vyNaAwkfUPTODfhI0/7acDm1SY64Uxis1zPZPxE+V63BHB29t/xfgQlrr+ExFR4viCVOCm5pKBWbDGTWXiMVSuqdkWwMHnlo5OqN6dtlZ9+KQAxe3cBVGh771fm/IKOT+nnnvWJfc90=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a5aa5e-e4c1-4593-aeec-08dd1876761f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 17:25:22.5286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cCur3Q7LozXZrRhpMsfmKElbT08TT+uvPgVcbZ43l1il1uCh6F7X3TPrsQaoiZwN9cos3e3XB9tytY7tJPWqPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4226
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_14,2024-12-09_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412090135
X-Proofpoint-GUID: OJE8VglcwX_iNytKVeses5lynw9PJusU
X-Proofpoint-ORIG-GUID: OJE8VglcwX_iNytKVeses5lynw9PJusU

On 12/8/24 7:41 PM, NeilBrown wrote:
> The heuristic for limiting the number of incoming connections to nfsd
> currently uses sv_nrthreads - allowing more connections if more threads
> were configured.
> 
> A future patch will allow number of threads to grow dynamically so that
> there will be no need to configure sv_nrthreads.  So we need a different
> solution for limiting connections.
> 
> It isn't clear what problem is solved by limiting connections (as
> mentioned in a code comment) but the most likely problem is a connection
> storm - many connections that are not doing productive work.  These will
> be closed after about 6 minutes already but it might help to slow down a
> storm.
> 
> This patch adds a per-connection flag XPT_PEER_VALID which indicates
> that the peer has presented a filehandle for which it has some sort of
> access.  i.e the peer is known to be trusted in some way.  We now only
> count connections which have NOT been determined to be valid.  There
> should be relative few of these at any given time.
> 
> If the number of non-validated peer exceed a limit - currently 64 - we
> close the oldest non-validated peer to avoid having too many of these
> useless connections.
> 
> Note that this patch significantly changes the meaning of the various
> configuration parameters for "max connections".  The next patch will
> remove all of these.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>   fs/nfs/callback.c               |  4 ----
>   fs/nfs/callback_xdr.c           |  1 +

I've pulled this one into nfsd-testing, but it would be great if the
fs/nfs/ hunks could be Acked-by a client maintainer.


>   fs/nfsd/netns.h                 |  4 ++--
>   fs/nfsd/nfsfh.c                 |  2 ++
>   include/linux/sunrpc/svc.h      |  2 +-
>   include/linux/sunrpc/svc_xprt.h | 15 +++++++++++++++
>   net/sunrpc/svc_xprt.c           | 33 +++++++++++++++++----------------
>   7 files changed, 38 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
> index 6cf92498a5ac..86bdc7d23fb9 100644
> --- a/fs/nfs/callback.c
> +++ b/fs/nfs/callback.c
> @@ -211,10 +211,6 @@ static struct svc_serv *nfs_callback_create_svc(int minorversion)
>   		return ERR_PTR(-ENOMEM);
>   	}
>   	cb_info->serv = serv;
> -	/* As there is only one thread we need to over-ride the
> -	 * default maximum of 80 connections
> -	 */
> -	serv->sv_maxconn = 1024;
>   	dprintk("nfs_callback_create_svc: service created\n");
>   	return serv;
>   }
> diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
> index fdeb0b34a3d3..4254ba3ee7c5 100644
> --- a/fs/nfs/callback_xdr.c
> +++ b/fs/nfs/callback_xdr.c
> @@ -984,6 +984,7 @@ static __be32 nfs4_callback_compound(struct svc_rqst *rqstp)
>   			nfs_put_client(cps.clp);
>   			goto out_invalidcred;
>   		}
> +		svc_xprt_set_valid(rqstp->rq_xprt);
>   	}
>   
>   	cps.minorversion = hdr_arg.minorversion;
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index 26f7b34d1a03..a05a45bb1978 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -129,8 +129,8 @@ struct nfsd_net {
>   	unsigned char writeverf[8];
>   
>   	/*
> -	 * Max number of connections this nfsd container will allow. Defaults
> -	 * to '0' which is means that it bases this on the number of threads.
> +	 * Max number of non-validated connections this nfsd container
> +	 * will allow.  Defaults to '0' gets mapped to 64.
>   	 */
>   	unsigned int max_connections;
>   
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index 6a831cb242df..bf59f83c6224 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -382,6 +382,8 @@ __fh_verify(struct svc_rqst *rqstp,
>   	if (error)
>   		goto out;
>   
> +	svc_xprt_set_valid(rqstp->rq_xprt);
> +
>   	/* Finally, check access permissions. */
>   	error = nfsd_permission(cred, exp, dentry, access);
>   out:
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index e68fecf6eab5..617ebfff2f30 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -81,7 +81,7 @@ struct svc_serv {
>   	unsigned int		sv_xdrsize;	/* XDR buffer size */
>   	struct list_head	sv_permsocks;	/* all permanent sockets */
>   	struct list_head	sv_tempsocks;	/* all temporary sockets */
> -	int			sv_tmpcnt;	/* count of temporary sockets */
> +	int			sv_tmpcnt;	/* count of temporary "valid" sockets */
>   	struct timer_list	sv_temptimer;	/* timer for aging temporary sockets */
>   
>   	char *			sv_name;	/* service name */
> diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
> index 0981e35a9fed..35929a7727c7 100644
> --- a/include/linux/sunrpc/svc_xprt.h
> +++ b/include/linux/sunrpc/svc_xprt.h
> @@ -99,8 +99,23 @@ enum {
>   	XPT_HANDSHAKE,		/* xprt requests a handshake */
>   	XPT_TLS_SESSION,	/* transport-layer security established */
>   	XPT_PEER_AUTH,		/* peer has been authenticated */
> +	XPT_PEER_VALID,		/* peer has presented a filehandle that
> +				 * it has access to.  It is NOT counted
> +				 * in ->sv_tmpcnt.
> +				 */
>   };
>   
> +static inline void svc_xprt_set_valid(struct svc_xprt *xpt)
> +{
> +	if (test_bit(XPT_TEMP, &xpt->xpt_flags) &&
> +	    !test_and_set_bit(XPT_PEER_VALID, &xpt->xpt_flags)) {
> +		struct svc_serv *serv = xpt->xpt_server;
> +		spin_lock(&serv->sv_lock);
> +		serv->sv_tmpcnt -= 1;
> +		spin_unlock(&serv->sv_lock);
> +	}
> +}
> +
>   static inline void unregister_xpt_user(struct svc_xprt *xpt, struct svc_xpt_user *u)
>   {
>   	spin_lock(&xpt->xpt_lock);
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index 43c57124de52..ff5b8bb8a88f 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -606,7 +606,8 @@ int svc_port_is_privileged(struct sockaddr *sin)
>   }
>   
>   /*
> - * Make sure that we don't have too many active connections. If we have,
> + * Make sure that we don't have too many connections that have not yet
> + * demonstrated that they have access the the NFS server. If we have,
>    * something must be dropped. It's not clear what will happen if we allow
>    * "too many" connections, but when dealing with network-facing software,
>    * we have to code defensively. Here we do that by imposing hard limits.
> @@ -625,27 +626,26 @@ int svc_port_is_privileged(struct sockaddr *sin)
>    */
>   static void svc_check_conn_limits(struct svc_serv *serv)
>   {
> -	unsigned int limit = serv->sv_maxconn ? serv->sv_maxconn :
> -				(serv->sv_nrthreads+3) * 20;
> +	unsigned int limit = serv->sv_maxconn ? serv->sv_maxconn : 64;
>   
>   	if (serv->sv_tmpcnt > limit) {
> -		struct svc_xprt *xprt = NULL;
> +		struct svc_xprt *xprt = NULL, *xprti;
>   		spin_lock_bh(&serv->sv_lock);
>   		if (!list_empty(&serv->sv_tempsocks)) {
> -			/* Try to help the admin */
> -			net_notice_ratelimited("%s: too many open connections, consider increasing the %s\n",
> -					       serv->sv_name, serv->sv_maxconn ?
> -					       "max number of connections" :
> -					       "number of threads");
>   			/*
>   			 * Always select the oldest connection. It's not fair,
> -			 * but so is life
> +			 * but nor is life.
>   			 */
> -			xprt = list_entry(serv->sv_tempsocks.prev,
> -					  struct svc_xprt,
> -					  xpt_list);
> -			set_bit(XPT_CLOSE, &xprt->xpt_flags);
> -			svc_xprt_get(xprt);
> +			list_for_each_entry_reverse(xprti, &serv->sv_tempsocks,
> +						    xpt_list)
> +			{
> +				if (!test_bit(XPT_PEER_VALID, &xprti->xpt_flags)) {
> +					xprt = xprti;
> +					set_bit(XPT_CLOSE, &xprt->xpt_flags);
> +					svc_xprt_get(xprt);
> +					break;
> +				}
> +			}
>   		}
>   		spin_unlock_bh(&serv->sv_lock);
>   
> @@ -1039,7 +1039,8 @@ static void svc_delete_xprt(struct svc_xprt *xprt)
>   
>   	spin_lock_bh(&serv->sv_lock);
>   	list_del_init(&xprt->xpt_list);
> -	if (test_bit(XPT_TEMP, &xprt->xpt_flags))
> +	if (test_bit(XPT_TEMP, &xprt->xpt_flags) &&
> +	    !test_bit(XPT_PEER_VALID, &xprt->xpt_flags))
>   		serv->sv_tmpcnt--;
>   	spin_unlock_bh(&serv->sv_lock);
>   


-- 
Chuck Lever

