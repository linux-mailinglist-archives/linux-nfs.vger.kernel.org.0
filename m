Return-Path: <linux-nfs+bounces-9662-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1BAA1D6F0
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 14:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA566164F9B
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 13:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C071FF1DD;
	Mon, 27 Jan 2025 13:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gn2ohyTs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nNtvKPwv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BAF1FF601
	for <linux-nfs@vger.kernel.org>; Mon, 27 Jan 2025 13:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737984964; cv=fail; b=hCQFcM5T3UnubXthruIaIFMn10xBR7F4YASnOnv5vK5ZGbmtSCBvi8pzqKWcxvEEINgtaRTqLAhSL1LGwkqkQQ82ND5pYwPKYjoifzvKPjEFntkEm7IY8/s3ldZVGh4BghQXYB8OT5WvAYPV/znkU0Ec+DFwGSIHRVpSTi6p4zI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737984964; c=relaxed/simple;
	bh=EfgZa6puCBlsFnkKTpNNnjYZzVUv5/c+HsXcspEo04g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jq9aYAKiw4vDzumOHANXBIl4w3nK+nkyipo2epX34+be364bQVG/nYghCEjfKbUOyWBRV8GOml48YPKjvvgUF71mlJc1+D6HoQOMg5NY+IksEIC07HTM/0iKaU7GbyMZLw8Z20Gn+LrF/y6/NetYycnWJspC4NkA1QmeNZHDtXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Gn2ohyTs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nNtvKPwv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RDM1hj021749;
	Mon, 27 Jan 2025 13:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=NWDAPAB17sOgsP0Vitvqte9U0cw/eDyt/6R5U12WdY8=; b=
	Gn2ohyTsNCuZfEFxSowBCnP7YlJVx+7oWgrTvWFGcACz+qGldJelhp2xo2K8EI3g
	Qx29YFPzNJ9hIWecldHVCFwPnFlEy0tyBGR+dBSKvChk9q4Po+VAXfeEgbgvD6xG
	cVVubKy2n436DkSe4S7D3oEwJFLsHl/C54jvonMuHUIhSG3cZaKbDcS71oLToCQX
	vBLqqufyHxR7NN9ilcyjaL4xJdtaKYdU7uQx5iKG/BtF2YQzxESEl76lvmiFapXT
	3fqlIdKwFWqIVeQXJUJIHrgDNvp53LeaLQczQvrlHkIa9+w9QIntgF2BYILVSGdg
	h8e+qdeYTwYhITNDeTjxQw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44eay780p6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jan 2025 13:35:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50RBMALY024087;
	Mon, 27 Jan 2025 13:35:52 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44cpd6y6yg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jan 2025 13:35:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aE11CwG1nKQvwf7TzlhzJWY0r6ViGH4aQishaLJ7at9d1NqgPi71r88rlkX49826VbfRgenoxCkPvaxJBXFRX3DAZWTMCD3kto1VJiuEDUxyG6JiK2iGzH0LpiLgqaxYPuO0mK4TxCXBjRSbA6QlawoSRAcNUEbtxis1UD1m9BWPbqwoMi0lYIlfVWfrsHiM3TuO7wSOEbt6LbsFz2rUrclmqIU7ZE+TPXquT7V4C8op2c+mrikey1ii/FLMigtqTTf2b4ZAYdkZnxpGLVmCmXojDg4onCsAdKYQOaoYrXWDIsRhPKvuFF00isFyrEiDO5s/7tSiVA3X3Ag60qLM8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWDAPAB17sOgsP0Vitvqte9U0cw/eDyt/6R5U12WdY8=;
 b=uNLffkxdcnggTsW8yXifpEvq/6xpjZw92CKUxQybpZ16UR5AOeaBaUtGwyTm3nVw/DP/wrgXuGlN6wOefyF5aYvGlg4BFMlw6QGIrp79qyoaAL6B2Jkt6yjyiLEaiaSJjDTPt13bUIqGBSVL2vvDlHHAilcpoyUfUghtiPzXrLXp/2VdzVymIuPakRIp0zyO1UCo6db5bULuKKZjkcwcA0Xr45HxXjFFxGgo7+hAdm+isYUcVfjWVJErGXnKJrqcnHsIfA29VMiLZQmeiLtnkbUv8gaddi0kJ4RRT59hNsQzIiE/Sc6v+JzmCvqdXDAiWFzPiAhNlH/xgpqCbUUvNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWDAPAB17sOgsP0Vitvqte9U0cw/eDyt/6R5U12WdY8=;
 b=nNtvKPwv/y//9FxGgDkZHC0MoJM26lNy18J3wBRllQzDjXiP7ZWEoli69/aUHjWGiijNQ+OLrZPazshNkNanrdI82vT1tQ3EUBt7/zH1zO1ug/npp+psSNG5BflZmaUYnOH41Xs10OtQGlCDd4jYxFw+HSx5VFc3TW8U6X+NUCM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6875.namprd10.prod.outlook.com (2603:10b6:930:86::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 13:35:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 13:35:48 +0000
Message-ID: <d4183be8-5ef0-4db1-adf8-f27a576714e6@oracle.com>
Date: Mon, 27 Jan 2025 08:35:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] nfsd: filecache: move globals nfsd_file_lru and
 nfsd_file_shrinker to be per-net
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
References: <> <c9adeaa6-0d6d-4b20-ad70-61d7a4cf344b@oracle.com>
 <173793081107.22054.1714283530462488590@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <173793081107.22054.1714283530462488590@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0226.namprd03.prod.outlook.com
 (2603:10b6:610:e7::21) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY8PR10MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ecbe947-aa71-45b1-4101-08dd3ed78282
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MTNqZ1ozbEM4NC9aaUs0Q3NSMnVSRzF4V0Rqc28yZEt1MEU4UWlXQW44KzJW?=
 =?utf-8?B?ZERPMjhlNlJaWHBRbENXYlY5NFg3T09McEpRaGM4cUdOdFdrRysyNnBIczFi?=
 =?utf-8?B?RlBQYVYra1FyZ2t4bXZoZnJHYmlVc3hVMXkwd2ZzZ2tCU3Bsc3BhNDhLeU5p?=
 =?utf-8?B?endFd200c3VRMUtuN0IyaHRUUitSbExKazd0VDBvUzBKdkU3ZVVnYVZOQk91?=
 =?utf-8?B?V3NZM1JqenZlT0dFZWNNWUx6QTFsM2tmQlNsMVA4eFBHRzFrSTNkY2U4SnBt?=
 =?utf-8?B?NE43SXBYZmZUUjZyTG5HQTVPY1BoQlRNcG9pUjQ1TDZSSDNocWhVUG9kWEI4?=
 =?utf-8?B?VkJ3cUFUSHlkeGY0VmFOMEJza0FQMVVLKzFNbHNzWlQ3cXo2bEppczBwVEty?=
 =?utf-8?B?VUZ0OGlsZEtuSGg5T1JuczV4aDNhcXdTS1dLRTlVQ2N5emF0Sm1hdUFxZjV4?=
 =?utf-8?B?UG9JckMrOXdZYkFrUlhiZWhFQVhuUkJuUXZzcHp4M1Yxb1NmclN1VGRMTzhw?=
 =?utf-8?B?cUxaZnhwQmhGYWJKMWRJdjRscmZQVWt0bEp1QVdOcW5CUWtPTk5sdmJrZ1li?=
 =?utf-8?B?bmpGbnRaa2ZLUUR4SzN6NWhHZmRmMlVKbll4MkxCSHlzR2hFeDFZWUhzVWlo?=
 =?utf-8?B?NzRNYmJnMEQrM1Rjc3J1Q0RrVkx6OTFyNFpPL09mdnc1bW95WXNmUTRkSHNr?=
 =?utf-8?B?ZTkwczF3V3JmT0RsVDlzYXBnQ1VoOCtDd2srWm1LNHNWQTFhV0d5bmo2K3Vt?=
 =?utf-8?B?NEhyNWY1SXd4eWhXMGNLZG5wMm92aEtFcG9LTVRwaVFQbUV2Y1dnTkhGMjNv?=
 =?utf-8?B?eWVUOUJqMERjcEZ0Q1dQTWtYYmtaU1ByL0t3UlZYeXZ5b2x0WTgwNFBEcUdq?=
 =?utf-8?B?MTFRUU1aZi9NMURneWZaTWY1TUZFQ1ZuZERDU0lLc0kzSzl3V2hqbEdoV3Jr?=
 =?utf-8?B?dmtsSm85UmhUcXpVUjJySjh0OEN6d0JPWXFxK3h2cFZZS29VUkJMNjUvUU91?=
 =?utf-8?B?MFBvenhqK3Zvay90bDU0RWNReDN6cEpOWHJiT29xUDdpRWVBcFdHWjFERWRV?=
 =?utf-8?B?M0lLakZMeFhjdEFVNU1RNzJoQzdUcTFnbHR2NFZSZk5WaHkzV0RoZWtWSnpS?=
 =?utf-8?B?NGtOQzllVjhiUEpLSVhlaGRmN2hablBKVGFSTEcrQTR0SUNIdEdtREU5NEVy?=
 =?utf-8?B?TmR2UWFIbGVVN1NUSzFtTUpnRHBETzFuSDh4clByUlVDR3ZOUFg4L2VFVUpz?=
 =?utf-8?B?cG1QQkFGYysrWFZzeVgwNTNJVjF1ZlZtSUdOdFVmNmZqNW96SFdqU0xQdm9w?=
 =?utf-8?B?MzEzZGp4d3FZeDJsdlV3eE9Cc3BCWDdPQ0g1TngzaVlMaWhJa0RYdVhsOFU5?=
 =?utf-8?B?NDdHVWJFakZGZERjL0xPckJrbkYwNlRWYVFDd3NneXllbDlEcHFzZDI2dFVq?=
 =?utf-8?B?cVZteSt4bWRzYWs2UFYrcHFMR254QURTWGh3M3pNTkhpaENQV0k5NmhIQk5T?=
 =?utf-8?B?c3QrU0dLSmJ2a0xrMDdpcm1uYUg4Uk1nVVVJWS90U3lPRUNMZytydXVpMXEx?=
 =?utf-8?B?NkNKOU54dlo1QzQwb3podytTeDBqMWZVa0orWHNISGpUdlVJSnpKNnFxS1JK?=
 =?utf-8?B?Z2N2cEk3QUZ6dVpFaFBrSmNac1I0VnBNTldZNnlwQlRsSmZxNFRMRVAxdGR1?=
 =?utf-8?B?N2Q0UUxVWkNTbmFwNDRDakJWVG1ZVUp6eFVIRUN4QnkrN0dTZndiR3FUeXFO?=
 =?utf-8?B?RTF0eUVUbmM5TE1Mc2pNb2R1dmpNTUdtV0FlRnhhLzZUcGtubDFZTnB6RU5x?=
 =?utf-8?B?MGpha0kxOHMzeHlCaFJrbVRLR1UxeC9tMUNOVlZ6U3U2T09CNjBFZ1RWdmJN?=
 =?utf-8?Q?0av5O7OWuZqU3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejM3U0xQbUFBRFc0NHFJU0hVY3RaZzluZ0pwaEU5WDk1cktzNGthY1FFQklS?=
 =?utf-8?B?ellMZzVHSEZNbHlUQ092cGpXd3NlYjZ2dzMyY2xxSjdrRGFLRzVtakZaTzBq?=
 =?utf-8?B?d1E1Ky9STmlRU20yV0pLUE5mZEVVNDZmdnRWbHZuSW9GRkh2aXgwdXFYTTZ2?=
 =?utf-8?B?S1MycWdjcGhQZWthNGsvcmN5ZHNwV2FIWFNlTDIwZzkyUUdCQlk4c3NhYXRP?=
 =?utf-8?B?ZU1sdTlDby8ydlNrek9DWTRiSzdhMXk5Rjc4SHY5cjJGbVlzRnZUSHllZWNR?=
 =?utf-8?B?Mm9pVGgwR0dtbDNPRnEwS25GTkVwNEdnREhHRGdYYXZZamY3UWxLM3FxNXl4?=
 =?utf-8?B?eE1MVHVaUmIrV0tFbjE3STR6N3pWaVl4UGZtaVI0Q3B4TEpZNTdwc3NJaisy?=
 =?utf-8?B?dnhkZWsvS1NWcVBQZVZISk44MkJaYVhzeGluY093MW1RYnVEeXRzd01VQWoy?=
 =?utf-8?B?Qk1oNVNjOGplWXd2VVpJRmRZWEhiWU9ybzNJNHJGRnNsWVZGa0d0blZmMFVh?=
 =?utf-8?B?S0ptSHdsenB4cjF4WDhxOEg3VU1ySUZlNEVRTE5UYUkvRUtiSWd0ZFRaMmNn?=
 =?utf-8?B?YUwxMklxd0svUi9kR0NuQjJ4N2piWUtzZlNiOWpIQTMzZmxUclFtSVRlYTNK?=
 =?utf-8?B?RzBWRlJzbTNjYnh6MWpjNkx3Z1RmV3F6cExXbE95cHo3M01DTzJ2dDNJL2dk?=
 =?utf-8?B?M1pRbTFpc05tN2trd2FhNVhBYS9kT1A5YzhBcHB0ekV3WE02aSsrSXhreG9m?=
 =?utf-8?B?dkZTYUlJMGR6ZllQN3VLbmgwdkJIaUZPV1UySEdLcWJvOEp3anZuQUE2Q1V0?=
 =?utf-8?B?S1pNWjRHbEJjU05TL2x3Ky85RzhmUlFaOFpHU3d0a1czcXdHTmp1dlhNS0R0?=
 =?utf-8?B?eE9MTFVVV3I1U0o3VjdGb3VLcFZESHRRbGl6TE9vbE9mQWRqS3JRd2MvazdJ?=
 =?utf-8?B?a1lnK0oxQU1DZjc2MHFONzZaM0Y0ZVZGR3E3bDE5OG5lV2ZrZERiSTQxeDR6?=
 =?utf-8?B?akY0b1B3eWJtOTVwOEJDaHRScnpDSUxwaUJIMUw1am5uMmh0cmJxZXlFRW4x?=
 =?utf-8?B?YnllT2RDVHBtbUN1S0Jkck50Rjg4NGllRWJ1TXBDU2wrTmdhUGZFY3hhV2hW?=
 =?utf-8?B?K2dSbnRaV1g4c2xEZ1NTQS82YzR3dWdhWHc2b3FjUGFJSXJqSFNPK2pGSWlH?=
 =?utf-8?B?QzBId3hnUVVxT2F0cUV0Q2E2b0xpS25hbTc5VXVFWGhTY2JlWEsrcERvcitm?=
 =?utf-8?B?QWU2c29OOTZjV3FrK3VaUkdKa09zQzlNOTR4MTQ1Z0NyVVhWNXp3bTFxdGt5?=
 =?utf-8?B?NHFZVCtHSEVGMWRMWC9FUUhoeDB2QVhWdEpSdkRITS9sTFk5ci9ncnR1WDFD?=
 =?utf-8?B?c01aVDdHVHN3SGNEYU02cUw5T1YyOGpzbVp4NFNBR2JDUUhuT0lSem9WRjVs?=
 =?utf-8?B?QmVFWERrME5pVllvcTlPdDJ3cUdqZGNVVTEweGw4alhVc28yOUlGendkNVpB?=
 =?utf-8?B?d3o3ZmxUamJrVWFWd3dOSnphTnRjTmlSVVhoaHNLRDZOWDcrdHJGL0Exb0dS?=
 =?utf-8?B?SjF6Qy82dSsvQUlTRXNLZHczcWVndUdXMVJjZkhqQXNUaVRXMUN4RWRhYXY1?=
 =?utf-8?B?amtlZ3JTT2VnUEVUa1NyQ3FWc0dyWWNiakpudFpuMFV6cmZTV1UyYlZieS9R?=
 =?utf-8?B?OGlQVnl2ZCtmQ3RUVExiRUZCSnNNd3B4M0U5cjhhTytqLzgweHB5ZmJJVGRK?=
 =?utf-8?B?Tzc5bXMvMFNlYUJjbTlmZXE5eVdWNGhPMUtocHRvZ0pKcm1yWkRJVytuNVBq?=
 =?utf-8?B?OXhKVWM0djdid0IvTzBBOGtOTmJqamVTZFp5M3lGZGRBbk51R3B5blhDT1Ix?=
 =?utf-8?B?Z1pkTUk2OHp0Z1BZQ2tnUDZ6WXliQkZxUGdiU2p3TjR4Z1JjQ1Y0NjIzNmsx?=
 =?utf-8?B?NnZCYTV5NHJrYmJDek9QS1gyTFZaNG9pZFVKaHVwZlhLMjBVOUNJc2lRZFJL?=
 =?utf-8?B?aEtLY1NtWC9rdUo4Ty9la2V5QTVwaFhSRGZoazl5WTNxOVBZWm9sWGtkREFW?=
 =?utf-8?B?bjFxZXN6eUhFVTYwNHNvQkQzVTJ4ZVNSWnptOENBT1lQaG1mMkV5NUQzR0dP?=
 =?utf-8?B?N1NXM0VJZGFkYUIvc2xpQmEwYlpvVmIrd3ZWYWtKMlZZMm1BN1NqV285OWgv?=
 =?utf-8?B?L0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	60pukp/IMIPFwpga25WdjhMTh8SZfVRdr7BspLTNm/205n5ij6HaaG63cM1uVmZtdk9v/31JXeKB90HjkSsmWnL/Tnb4zUoEIgqRQb8z63bXFQk63SALBUHPOL1DFrB1nsKLyjBac1cO+9/MaAXNDzcv2t1NaiyXID5pw0QrTIKWMW0kIlZQi/mEpnu2aO+3qRnyAsblrb9k7mjOs5p8cX/aj2Hi11ZjOq2ZLrv+2sn7QzADdl3cYLB5sSOKaMBpshOyLAbFDZEKceHuOSPL6BTt/QfRfN62/zs1P3IlWQDjEDJDoeLRHcdwVx57xWmCdiIhg3imeJ6wRWOJ1GSov6cDWMQDmD3kNWsnb1NnCxcXACfbgPeXmxKDxYyedDP1EuSEpWBTPx3SZzpXBPb7fczfRejWz4SD2XoBVa/PF50JTWRlljG752S1PcZKbBE1kb86NAri50Sl949G0kGP6JSQ7Fl/nP41qel41WP54tYnUqbKEeSI31ydqlCt6DdXccJke3YxgIVcxsJEZ43RtEUsa6WfaQIIpN6xU5wLpfhpMrvz5lZ2RJkpwNo6zdhrZcXko1HrtS2AdYphxT0Wm5+WHoKhMRAp0ve2e2C9gl8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ecbe947-aa71-45b1-4101-08dd3ed78282
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 13:35:48.6373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CLB6YokJOsBwlj955hWc1R/68E80A9QjwoMw+vDn8h3UsGamf+Z0+SpbcwQcbQXeprLJN0MweQ1HkOooppe3qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6875
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_06,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501270109
X-Proofpoint-GUID: iBQDTmx70wt0TwW4b0Z6qh5sbHaL7pdP
X-Proofpoint-ORIG-GUID: iBQDTmx70wt0TwW4b0Z6qh5sbHaL7pdP

On 1/26/25 5:33 PM, NeilBrown wrote:
> On Fri, 24 Jan 2025, Chuck Lever wrote:
>> On 1/22/25 5:10 PM, NeilBrown wrote:
>>> On Thu, 23 Jan 2025, Chuck Lever wrote:
>>>> On 1/21/25 10:54 PM, NeilBrown wrote:
>>>>> The final freeing of nfsd files is done by per-net nfsd threads (which
>>>>> call nfsd_file_net_dispose()) so it makes some sense to make more of the
>>>>> freeing infrastructure to be per-net - in struct nfsd_fcache_disposal.
>>>>>
>>>>> This is a step towards replacing the list_lru with simple lists which
>>>>> each share the per-net lock in nfsd_fcache_disposal and will require
>>>>> less list walking.
>>>>>
>>>>> As the net is always shutdown before there is any chance that the rest
>>>>> of the filecache is shut down we can removed the tests on
>>>>> NFSD_FILE_CACHE_UP.
>>>>>
>>>>> For the filecache stats file, which assumes a global lru, we keep a
>>>>> separate counter which includes all files in all netns lrus.
>>>>
>>>> Hey Neil -
>>>>
>>>> One of the issues with the current code is that the contention for
>>>> the LRU lock has been effectively buried. It would be nice to have a
>>>> way to expose that contention in the new code.
>>>>
>>>> Can this patch or this series add some lock class infrastructure to
>>>> help account for the time spent contending for these dynamically
>>>> allocated spin locks?
>>>
>>> Unfortunately I don't know anything about accounting for lock contention
>>> time.
>>>
>>> I know about lock classes for the purpose of lockdep checking but not
>>> how they relate to contention tracking.
>>> Could you give me some pointers?
>>
>> Sticking these locks into a class is all you need to do. When lockstat
>> is enabled, it automatically accumulates the statistics for all locks
>> in a class, and treats that as a single lock in /proc/lock_stat.
>>
> 
> Ahh thanks.  So I don't need to do anything as this lock has it's own
> spin_lock_init() so it already has it's own class.
> However.... the init call is :
> 
> 	spin_lock_init(&l->lock);
> 
> so that appear in /proc/lock_stat as
> 
>        &l->lock:
> or maybe
>        &l->lock/1:
> or even
>        &l->lock/2:

Well, that's the problem, as I see it. They might all appear separately,
but we want lock_stat to group them together so we can see the aggregate
wait time and contention metrics.

Have a look at svc_reclassify_socket().


> Maybe I should change the "l" to something more unique. "nfd" ??
> Or I could actually define a lock_class_key and call __spin_lock_init:
> 
>     __skin_lock_init(&l->lock, "nfsd_fcache_disposal->lock", &key,
>       false);
> 
> There is no precedent for that though.
> 
> NeilBrown
> 


-- 
Chuck Lever

