Return-Path: <linux-nfs+bounces-5357-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D15951A9F
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Aug 2024 14:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CF9528678A
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Aug 2024 12:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF0613C906;
	Wed, 14 Aug 2024 12:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WJ+qWJjY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qOErQ45b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0346213CABC;
	Wed, 14 Aug 2024 12:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723637658; cv=fail; b=C9nC1hS34pbGkX4CXHCFZhtdx7RQJtoW8W4MKuOVxYvFkczbt4iP1twaMWHLj/Kc6Ee10zt59YOuvSxv9SaxUYefPiY1xQ8OhwEWuul13ftJYNcf4V3Axjk/6bSqIETDa9MNgp6N9pXxd8GKFqJwSRcGGB3zIGi+9toe3R3dfcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723637658; c=relaxed/simple;
	bh=eHT0qkCaJCAfTQQejN94pxZqbD9c+uPb6kH9hXoAnpQ=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=swrPYV0T1cfbhkO++5GdmEmuKjSIWXCzAMvSsmwKEZjIEVWJJ0kU/Q76B92skAFPsx5C97u/uktUKd35AwPg+bNi9e9ow9Ht3yk3tNMr72Pw/jeU6tXK2ea0s4dtKJQEw/G/m9w5psLQP9l0OmUjjZqdjEYTKHMcmE1T3grsUp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WJ+qWJjY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qOErQ45b; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EBtWk8023338;
	Wed, 14 Aug 2024 12:14:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:cc:subject:to:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=4dXtukJguogPn0B2GuQETR52nfk+SaH8Yl0ptk5oLBA=; b=
	WJ+qWJjYqqoJMInn/U+ay4jcecqPR5mSD6XaP6Ia0sk8kEACfYuEoX++6CtVGM1C
	CZ76Gu3CnndJWmkZCBLlPVm4OiM/+OMUX2D/skLQWg7WKzWbOgchY5BzftQh8m3S
	Y9Y40hkg519qoWhl8ChcJxb2GENihnRgAq1eUa8rx62ej17RHoQFCquHq23QkAul
	zcU2KZT0GgTqLmsTnW5zZ76B7LS9bKuetj1dgxwIz846DaiSHPJmR+0ClIUNwOmc
	3K0NoYheW5KRyjUN/O3kKsxT47gG2HptjoYl0YxQsdEtwqonkXTdm9anPrXLHJlz
	Ase8qpLTolM6H/5vSTsRxg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4104gajsy5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 12:14:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47EBKXJ1017611;
	Wed, 14 Aug 2024 12:14:06 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40wxnatdjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 12:14:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBjoI1bbJ6C+olaSp0eTq26PmZvhRYfsXOW0zJ5F6/lE7558Nf3L+zq26qeAebPkjFnN7/8Zk1YiSZ799uzzdmMIFzzksuZHq6drnQekaou5uuR8z5Ave888zArIm7J/Q8skBc5kqEmTcKBfE9aq8CrdUA8vBm1jRf4kTRNXcKhOvJvFgOQ0x7f9rLJueGeea7JAwW5TSUuJJi7GmOvQsnngSAL8AW4rm1XOHpE354LguEcOjUcT1QI6h0IwxwHXC0iSrpqlFmgGlPHAKmrAnmxY4qFJ4cKUOYR1gSRJxRJ4/bonB3zj1952LPrNU46cfr6CaaVjGG6hXz7bdq+fyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dXtukJguogPn0B2GuQETR52nfk+SaH8Yl0ptk5oLBA=;
 b=kH1DvT5h6z4sRwCde/Koe7w0uzETrXI+emGNbMzsraWUlVPCXWSFbPEq8qhca9FJd0o69XyIkhpAKZmHQfN54sOMoSm+/ab+//MumVD59EtQr02MhvhGyhEBBJf2iRn95Zl8HOQFwbJbiWamH2SJVcTGgJ/Nr+6AUagn5OKq1g3Z4lDFQWPIYQpZYfhgHiLyI8o8PlhkC4VGJQzpZ2nhZmIkpyQ1whX/nGFmTrzFeA9nLeGK0f+6N9X+p4weBeshhfXN7yRPjQkN6ronWwKBdJRjwDis0wd7bdDkAt+1w1BDGsbEcJLPphL+ayIL1zRczJAqK91GDz2z3/BAuGWEcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dXtukJguogPn0B2GuQETR52nfk+SaH8Yl0ptk5oLBA=;
 b=qOErQ45bRb3rRsz/2KHDCLYi5j7mNb+c68ZlJwVZic0IWQc11PzQJdN8UsKg/iyRGuJR2OpDET2carRe9O9+nDfq2PwilfrOC6YfsNYcF4mvuxssE9Ln0PIJpRjhn8RqkJZd1XodB14n6r56tF6hMcmooVOcNlwT9Y9tvJcryTc=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by DM4PR10MB5943.namprd10.prod.outlook.com (2603:10b6:8:a1::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.15; Wed, 14 Aug 2024 12:14:03 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7%4]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 12:14:03 +0000
Message-ID: <879e99d4-8ce2-4cef-b220-bfb78f275ad3@oracle.com>
Date: Wed, 14 Aug 2024 13:13:55 +0100
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>, "cel@kernel.org"
 <cel@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        Sherry Yang <sherry.yang@oracle.com>,
        "kernel-team@fb.com"
 <kernel-team@fb.com>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Cyril Hrubis <chrubis@suse.cz>,
        "ltp@lists.linux.it" <ltp@lists.linux.it>
Subject: Re: [PATCH 6.6.y 00/12] Backport "make svc_stat per-net instead of
 global"
To: Petr Vorel <pvorel@suse.cz>
References: <20240812223604.32592-1-cel@kernel.org>
 <20240814074559.GA209695@pevik>
 <BN0PR10MB5143EDD71EF92A181D4255A0E7872@BN0PR10MB5143.namprd10.prod.outlook.com>
 <20240814100930.GA525252@pevik>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 smRifw1wGg==
Organization: Oracle
In-Reply-To: <20240814100930.GA525252@pevik>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0687.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::13) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|DM4PR10MB5943:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b0d0218-5584-4575-c51b-08dcbc5a95f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zys0N21sSGkxUlUva2g3c29Cd0IvVys2ZHpEOXNXbjVmQW4wR0tCTzNVS2Rm?=
 =?utf-8?B?MEZ1aGhlL2tXeXFCamhRUXpkNG5iR01oYUh6c3Z0bVQ3SlZKMk5SZXJnTHor?=
 =?utf-8?B?UlJNWmtYZkNqUFhGNXpIRkJuL241eWN1WUIrU1QxWmxWOVYrTU9yWmpvczhr?=
 =?utf-8?B?R0Y4aUhiUVRGLzJkR0I3aEhrQ0tCc1R3QnFhVTFGbW81MEw5WlZEMHNKYzhJ?=
 =?utf-8?B?UEVKWjdhdWJNbkdEL0pLOVFWNURBaFROQ0VhRHJIOFNqNHBpSXEzNXVyWFJs?=
 =?utf-8?B?d0hIdkF0Vmk2cEQ2RUt1VFVpRWErT1daaWllS3JqY1BHQ21NaStJZ2JrRlBw?=
 =?utf-8?B?QWVhV3NGZEluYnc4YzBsVFQvak5nelpXUEg1dlU0NmFEZEdoOWt6R3c2SGRI?=
 =?utf-8?B?NVFyMTVhamZ0Nk9PQ2hqRGF3bk9uVllGcFpON29xWFJWL1JZQjBIR3NIMmQw?=
 =?utf-8?B?Rm94Q2R2YWpRbGo4MTRFNkc4STQxRUhwOERRYlp1YVFzQVYyU0lYT1c5K05x?=
 =?utf-8?B?RzdXQ1IzM2E3OGxYMDl3L0JZOE1GaXZJUThtKzV1djRiNmVUTGZIUXFmM0Nn?=
 =?utf-8?B?Ukl0ZThXVk8xKzRIamk0VjVHTis5NGdkMzFHSmpTRXpVTXQ4K0o2L0RSNUc0?=
 =?utf-8?B?VnU1Q05MVnJ3NFVaaXI2SzUrZHhBWmNOcGhCbTI0cWxSWTU1Rkp2Y1JObnhp?=
 =?utf-8?B?OFdZMFFmcnRyaDdWS1dlVVZDVVZPdWlDNlZweGtQN0wyemhXVC9nMlhQNzAw?=
 =?utf-8?B?bk8rSE9Uci80aUgvYkU3WDdtQndFNmJOS0wvL093VzYzakdTK3h4dXY2eUVI?=
 =?utf-8?B?L1Nid1dld1lXYkZUUVNYRmRyODlYeENhdWNNMUk2L29DaGcxY0JySnFqa0NV?=
 =?utf-8?B?aTdwampBbjIwbEZ1MzQ3a0QxS1QycmpOVjRGMklMWG5oRlRUcXBUd01jaDI5?=
 =?utf-8?B?RWQvU0FxQ3RTM3BSWW9PWDY5cUxWeWk1aGdrZDdhZWxJNDJxV2RNZExsb3hp?=
 =?utf-8?B?UVVKS2VhRWs1SDJtSzlkcmlTYVlZU3RpOURUdG10dzFSY2FGWXJickVxWGNw?=
 =?utf-8?B?WTBzbHJ3VjZhMi9yN0w2UncyU0VaWTZCdHVDMEZMR290dm9iSVF5QXZaOHRw?=
 =?utf-8?B?S0U3VkJ3Vlg3V0h2ZjltZzNJTlp5OGFHZVdacjR0MFZRdndlM2YxMVNsMVpG?=
 =?utf-8?B?b05VUnhnQVdERDVnUVRCOG9WN0IrY3U4NjFaRU5hUG9ieWU0NjgxSDRkblVB?=
 =?utf-8?B?TmVjZWIvemsxTWJTUWg1K0ltNHlzaWRFOEhhRElzWldjeU9WZE5tZDJ1ZnJt?=
 =?utf-8?B?bFhvZzRTZGhyTVp4WGtyblVHN2RhWEp6WkRxb0xRS3ZKVzNMRTFIMWV3ajYx?=
 =?utf-8?B?UGJBQndyc21zY3lZeFpNRmxNTTNMMDVPVzJQbW9TYzZjdWhZaVR3YzdwelUx?=
 =?utf-8?B?QlZraWM2T2Npd0tzTVRCU1RUYmU1NXlKaE9XclpMNlV5R1IrcXU5UFFUOEFt?=
 =?utf-8?B?dE1JRzlaaXVOaW45TlRPWVhiU29rWThXNHpOdUQ2QmU2TnpSbVRvbWlxRXJ5?=
 =?utf-8?B?Zk95QnN1dTg3cFlialByOGZYMWk2bjM2K2tLU2k4QSs5RFJJaUdjd2VhVkhE?=
 =?utf-8?B?RjUwYzNwUkxuVnVSSDJmd3RDZEhmS0JCUkJUZkRpc1d3RmFYcFdhS05UeFJi?=
 =?utf-8?B?djhybjBNRkQzbHBvcGtkSGhsaTZpTEdrOGFoRWZhOUsyNmlFRDJlZ3JteFRJ?=
 =?utf-8?Q?MytIgNDA9vC4Rvm5ps=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1NqU3Vla0RNWW5WTUt1UHRCMXNpUE9mODV3VWpxTHNmSHJIMm1UMW50eDZx?=
 =?utf-8?B?NTdRdWZVd3o4eVcxZ3UxRmQwN0RSVFBjVWs1a2d1V1N2Y3NGQXdQOFIzWStV?=
 =?utf-8?B?VEtXbVBDS2llTFdLQTM2MVN5N21Qd01mU2p3eUdDSXduZk43OGNLZ3hBR2cx?=
 =?utf-8?B?UDJEOW9LVG41UWpLd01SdWRVaXMrR2FIdTg0T0xnbmcvNXJQUEJjdVZ1M1RB?=
 =?utf-8?B?M3l0VFk0V2t2cnh5Z1U1bExpWFhRK2lLWFpHOWFjZVpPS1FLVGg0ZVNuWW1t?=
 =?utf-8?B?SERIcytkdmxNS2dLbXR6RDlQcjljUndMRmV2anFQa0plU2NLNEpFMk5yTEdW?=
 =?utf-8?B?VDNRU09hWFVmbzhtRTJET0Y1ZFpYeUsrM1BVdGU5ZGwvTFFmem5nMHg4eDhX?=
 =?utf-8?B?YlNzMkN5cm5BSXpqQUJHbkdLcXRZVEhHaUszaVNSNFZuczRkNUVxN01lVVFv?=
 =?utf-8?B?QWU3MEpsLzBJWUt4MnNHNEo0Yms4bXJRN0dUNllycXU2MGF6NjVNaHZMVUda?=
 =?utf-8?B?S0taeVNwMGtMakNUQWpkVU5QRFFnRENkRCtTQ1I1cE1lOHYrRkhabFlZM3Jk?=
 =?utf-8?B?RkFxNENUVzNWS3JETjByNkJBS2ZISGxoZGtkbnFCMWF5T3BkYUxhN2hOcVM3?=
 =?utf-8?B?ZGYwYnhyU0k2RFJRVnVvanA4OWVJemNVZFhpbFRTYkR3TlhIYjNKNTV4UE9n?=
 =?utf-8?B?NmNNclBvTzk1cmJvNFpiZjR0cHl1OWNYWnZaeTQ4aVh6NXpvOXRIQTBqV1pV?=
 =?utf-8?B?Y3VjSDlIYnIxeHRjWk12WXQ2Y2grcStsQXZMOGhuajBMM2F1S000TzFLdVlv?=
 =?utf-8?B?czNJUHlFSDdnd09udU9xOW5YdEs1MndTbWU2eTRaZVpRSEd4R3U2WVZIZ05l?=
 =?utf-8?B?UGw5cnIvc1NFOHo0ZlRkbGxKYldldzh4ZWxnQzJNNFJENm84TFMxV1NSOHla?=
 =?utf-8?B?Yno0d0J5bW11a2VUcHVRSlRzRUJGR2tCdlRJUEtiUGViSGVrN1FnWEtwK2c4?=
 =?utf-8?B?Vm9xYW04bWFQZ0x6WWRLQWVDUEYzZ2ZxUkZrUmNRcGtyZk9HY3V6Ry9HSW51?=
 =?utf-8?B?eENlN3diZXdacVBoYWkwVHhRb2dFU3U3V1JDTHJoa0RuY0xrd2lURFA2Qm1N?=
 =?utf-8?B?c0NxbXdxbDU0T25wZldzczVReW9DU2JWV0VEUVVMRmYxTGVLUktlOG9vMURt?=
 =?utf-8?B?REJUNTZpbzFxVmdxdXVZZ0N6MmphV3B5THFEdEs2T0tudzJFVSt2WWhwV0hW?=
 =?utf-8?B?V1RrbThoRzB2SzFZMXdUdThpNkxnTGx3WWhwRDUwQWxiNUl1eS9yNUVhQ2o2?=
 =?utf-8?B?bTRnWkVWazA5NTQ4UXlyc2sxTHZMaGlVODZxNEo1clZrNUxrUXhvb09XZnRX?=
 =?utf-8?B?dmVpQVlZV3BONGlNd0pyWFpBNVVIajREb0NBL2RXc1ppMG03UEJhZ0lXQ055?=
 =?utf-8?B?aUZyUkhUN0V4eVZKSS9ab1ZXUTVGSExaSU0ybkZQYVk5UEw2TTgxdWJoc0x5?=
 =?utf-8?B?eGJlaEprYWg2czNMWW4yZjEvZFJPVGZOWU1CR1RCVTg1MWFYYWxBOGVvazdG?=
 =?utf-8?B?YmtpcUxsTjFrSHJueGZtWE0wOVZ2NmNIL3BmeHNjbTl2MHVjRURQdWJ4cG5n?=
 =?utf-8?B?amw0M1lEMXRibUpETmNMQStkSG8zTG1FSEpNaElxWHpJakhlUWp6UGt3d1p6?=
 =?utf-8?B?MEUyM0w2eUlWUkdkQkZzRkkyaXQ5RnJ6WWNLU2pWVVp1Zk1oaXJrcjVub1Fa?=
 =?utf-8?B?QzUvZkFTRU1uZHNRMFpodkM0d1pqc1YwK0xVd2REK3BtcENPcWxuMlpFQUEx?=
 =?utf-8?B?UzBhYlNSb2oraEh2NkMvYmtXVUV1RVBqZGRnMVpaQStmNFRMc1lBdFd2Q09m?=
 =?utf-8?B?aGQ2L2p0MWlCRnk0SytkMGZidlFyOWFza2h2NW5kMS96SmFEc0p4SkxqUVhY?=
 =?utf-8?B?anJmeGkyUG1YNHZJRUE3a1BpbXNyMDBYaEV5SWxhMHpWMlJoSkJhbmN3UXFS?=
 =?utf-8?B?dFFqeUMrZHlkUDE5b2tNaWNCWk5Cdk50TlV1bENBQ0hrMlZ0S3piL2Z4WlNT?=
 =?utf-8?B?cU1kTGlRT2FPQzVnUlZJTFdhbEExNmdlenN2cUwyNFlrZU8zaXRjVXJsS1BL?=
 =?utf-8?B?QlBVQ0RXcGtqSldsSUorYXpLVHRFKytjNzR2ckJUamU5VXNCYzZWdTRlc0lw?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8zwNTfRC9GEoBmy2qgEBVZV5GoUI4KJgrqFAfZPyZBfg+JjZjkPcxDefVm3pPvJ856cjbCUTBhB/g0wX2D4udWYdqDiVol6iwwFUi+csjfVUpg+x+dkx+fU/5AIlcmbkfh04T1Cq8pJ+ka1/guKbhtTKFvdVO/kIzdsaBS05W84vOJBfVjCEamlGCiDNLzf4tHPQzdwQhCE3ZnX/g1E+EkU/05Et5HBuEQa2zA2F0rBP0evbDdl7b4QyDLdbQByg1vRRlFLO/qHQnQaD0vxceo6bWLT2zCWmcz3tz3Jd8/Dxl1l5KQMoqyNSz9HkEdcv7Ll9RTNVCXbh2lkWiMtXw9LpoTAXCu94z5/8L+0vt6Fbe2GDf3Emagp1HcTt5yIU61avl75CxjX7NMhbMr0N3RsF3hAxQOYxOYHIbaIfhy96CrU5ieeTI5jFbaT65DNFlCHWUO79EPl/bBBwWoyzZqivqjYjoDZCInU28TpKzkgCWpJ81Ily4TFU3sr8jKJ/mpBSywCB2vdEAC/exAICTAvo92WQHxQ2vZKQ9haEUkfoKLDZOw5xc4CONf71uPa2QuBMLXxS6HEiKjPXYlsy0Zzbxv5KuBH973B2tSkV/GQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0d0218-5584-4575-c51b-08dcbc5a95f2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 12:14:03.0092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dIUciiRo0dxN1vy4aTRQap984jEz6dV68mJi7qB7EfrveGUSY2u4ZP2R1TOD6cxAhtRl8wPDbTW+yiN/npjFwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5943
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_08,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408140086
X-Proofpoint-GUID: l_j3_HvSeaudJJzRt_UxFrgmyzg84FIS
X-Proofpoint-ORIG-GUID: l_j3_HvSeaudJJzRt_UxFrgmyzg84FIS

hi again Petr

On 14/08/2024 11:09 am, Petr Vorel wrote:
> Hi Calum,
> 
>> Hi Petr,
> 
>> There are two sets of changes here, for NFS client, and NFS server.
> 
>> The NFS client changes have already been backported from v6.9 all the way to v5.4.
> 
>> Here, Chuck is discussing the NFS server changes (and others), which were not backported from v6.9 (actually, a few were, but only to v6.8).
> 
> Thanks for info! Now I'll see the patchset "Make nfsd stats visible in network
> ns" [1]. kernelnewbies [2] starts with d98416cc2154 ("nfsd: rename
> NFSD_NET_* to NFSD_STATS_*"), the others are probably some preparation commits.

See also my note:

	https://lore.kernel.org/linux-nfs/2fc3a3fd-7433-45ba-b281-578355dca64c@oracle.com/

> 
> Anyway, I'll update the patch with NFS server patchset.
> 
> Kind regards,
> Petr
> 
> [1] https://lore.kernel.org/linux-nfs/cover.1706283433.git.josef@toxicpanda.com/
> [2] https://kernelnewbies.org/Linux_6.9#File_systems
> 
> 
>> Thanks,
>> Calum.
> 
>> Sent from Outlook for Android<https://aka.ms/AAb9ysg>
>> ________________________________
>> From: Petr Vorel <pvorel@suse.cz>
>> Sent: Wednesday, August 14, 2024 8:45:59 AM
>> To: cel@kernel.org <cel@kernel.org>
>> Cc: stable@vger.kernel.org <stable@vger.kernel.org>; linux-nfs@vger.kernel.org <linux-nfs@vger.kernel.org>; Sherry Yang <sherry.yang@oracle.com>; Calum Mackay <calum.mackay@oracle.com>; kernel-team@fb.com <kernel-team@fb.com>; Chuck Lever III <chuck.lever@oracle.com>; Cyril Hrubis <chrubis@suse.cz>; ltp@lists.linux.it <ltp@lists.linux.it>
>> Subject: Re: [PATCH 6.6.y 00/12] Backport "make svc_stat per-net instead of global"
> 
>> Hi Chuck,
> 
>>> Following up on:
> 
>>> https://lore.kernel.org/linux-nfs/d4b235df-4ee5-4824-9d48-e3b3c1f1f4d1@oracle.com/
> 
>>> Here is a backport series targeting origin/linux-6.6.y that closes
>>> the information leak described in the above thread. It passes basic
>>> NFSD regression testing.
> 
> 
>> Thank you for handling this! The link above mentions that it was already
>> backported to 5.4 and indeed I see at least d47151b79e322 ("nfs: expose
>> /proc/net/sunrpc/nfs in net namespaces") is backported in 5.4, 5.10, 5.15, 6.1.
>> And you're now preparing 6.6. Thus we can expect the behavior changed from
>> 5.4 kernels.
> 
>> I wonder if we consider this as a fix, thus expect any kernel newer than 5.4
>> should backport all these 12 patches.
> 
>> Or, whether we should relax and just check if version is higher than the one
>> which got it in stable/LTS (e.g. >= 5.4.276 || >= 5.10.217 ...). The question is
>> also if enterprise distros will take this patchset.
> 
>> BTW We have in LTP functionality which points as a hint to kernel fixes. But
>> it's usually a single commit. I might need to list all.
> 
>> Kind regards,
>> Petr
> 
>>> Review comments welcome.
> 
>>> Chuck Lever (2):
>>>    NFSD: Rewrite synopsis of nfsd_percpu_counters_init()
>>>    NFSD: Fix frame size warning in svc_export_parse()
> 
>>> Josef Bacik (10):
>>>    sunrpc: don't change ->sv_stats if it doesn't exist
>>>    nfsd: stop setting ->pg_stats for unused stats
>>>    sunrpc: pass in the sv_stats struct through svc_create_pooled
>>>    sunrpc: remove ->pg_stats from svc_program
>>>    sunrpc: use the struct net as the svc proc private
>>>    nfsd: rename NFSD_NET_* to NFSD_STATS_*
>>>    nfsd: expose /proc/net/sunrpc/nfsd in net namespaces
>>>    nfsd: make all of the nfsd stats per-network namespace
>>>    nfsd: remove nfsd_stats, make th_cnt a global counter
>>>    nfsd: make svc_stat per-network namespace instead of global
> 
>>>   fs/lockd/svc.c             |  3 --
>>>   fs/nfs/callback.c          |  3 --
>>>   fs/nfsd/cache.h            |  2 -
>>>   fs/nfsd/export.c           | 32 ++++++++++----
>>>   fs/nfsd/export.h           |  4 +-
>>>   fs/nfsd/netns.h            | 25 +++++++++--
>>>   fs/nfsd/nfs4proc.c         |  6 +--
>>>   fs/nfsd/nfs4state.c        |  3 +-
>>>   fs/nfsd/nfscache.c         | 40 ++++-------------
>>>   fs/nfsd/nfsctl.c           | 16 +++----
>>>   fs/nfsd/nfsd.h             |  1 +
>>>   fs/nfsd/nfsfh.c            |  3 +-
>>>   fs/nfsd/nfssvc.c           | 14 +++---
>>>   fs/nfsd/stats.c            | 54 ++++++++++-------------
>>>   fs/nfsd/stats.h            | 88 ++++++++++++++------------------------
>>>   fs/nfsd/vfs.c              |  6 ++-
>>>   include/linux/sunrpc/svc.h |  5 ++-
>>>   net/sunrpc/stats.c         |  2 +-
>>>   net/sunrpc/svc.c           | 39 +++++++++++------
>>>   19 files changed, 163 insertions(+), 183 deletions(-)
> 

-- 
Calum Mackay
Linux Kernel Engineering
Oracle Linux and Virtualisation


