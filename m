Return-Path: <linux-nfs+bounces-13474-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 174DFB1DB0B
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Aug 2025 17:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0C513A8DB3
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Aug 2025 15:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509E425A352;
	Thu,  7 Aug 2025 15:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qaK/uCWK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oogtMr1p"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5521C5D72
	for <linux-nfs@vger.kernel.org>; Thu,  7 Aug 2025 15:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754581922; cv=fail; b=Tbhp/p4/L85Du90SrncTzuAAr2jzyxs9jjVPQQvpVJkNFMOgM7Zj0uPowh+MDe5BmLS8JTl7THxhqre/IQxo/C15/uoP7M+Daeop+eAMkRFScXH35RVBWhCcrkJvd0Tla4P1Yrqy43qsS/9a+JgLJZsggAiZO2LYhSMzhWhn0ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754581922; c=relaxed/simple;
	bh=Khw94zfmZuvmoaMoFLOHLialDKiBVbexuGAKkfqPd5A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N6TQOhxbopUot4UPKrKv29GJ/uWJgQcln5+sYpofX8DVjrhD0fJxwYB+LRjJGnsSHLdj0/M1ApUXNyerdde9taYJYAeJWhazcjcjWgAJfGuB5Wl3IGauSQTozLMswMXp2apqAgiS9bg2Jtt/toiVPR3JtxAQEKCfFDCtLQQyGAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qaK/uCWK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oogtMr1p; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 577FQSOg008758;
	Thu, 7 Aug 2025 15:51:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=2A+VszkfDYVuuq8uttMlwjoZgX2onDeFURjbYwILpbU=; b=
	qaK/uCWKHXcxMaayaYJn6a+ZLPgcTyjd2YBeJYd1D+hCkUbmhROM6wVot3QPgn/j
	fBQUMsEqVc5aQQO1i/DHmPmXL19IHHCwWmwlaCm8MDdqOqQq5ybmSE0utyUwGhcX
	BXpKbilHIb6cKEy+0HZ8qD3pnzvYBjL8ta6cOSQEwv+W74VKarF+ST70LDFdQcS/
	oLFqBIzTw86Ot50K3ob8VbDqXK+Dunr0OcTCirdb/rlpPLQEooulxfJrPnO5KThu
	65kGXCVMlVjyzMQgjcPtEMERt9cDixXMlHogQzQ0hQgcfKcJKZ2aBHmkb8OJaJ5v
	GvEBcmX3CpyK6n8rciOhPw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvf4dmt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 15:51:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 577FkfUQ027093;
	Thu, 7 Aug 2025 15:51:56 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010031.outbound.protection.outlook.com [52.101.85.31])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwpkku1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 15:51:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vPEJ7oTtIlmjxi2SemnUS94l5sicO7YW358Fi2Nrczbxi+YV+rtku2eZY1C5ocXif63rf8SF4WGloxJislADDRG+jLTIyBcpPCO85USJt0wTvjaZlwTmnF8GOpQBgTqy5PF5pnf8daTygIUydunOeP72AHeRwn3ak8xJ0YuL/Jf7j+ZXhbcPYZZsm1ZnH5Cc3hbXQ8HiZBwMzf1pcIUSKbNP+3f2gGcorO4FM6y6jv025Tz/+a6A8S4vybMnJ/ngoxFMvkW/sQryEV9bbcL3L1Sq9n/JRDcN9pbyXT7nw0zrnNh000y67QNuXBOGXbsYK9vzIypf6WG8/lTGimDYnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2A+VszkfDYVuuq8uttMlwjoZgX2onDeFURjbYwILpbU=;
 b=BTvPLt/jm9MiQ9cen+0Or/Xuj1ZDH+qjKQHW2RUd0JyV9YEikgNb5lj0v+N3rJQmW3Q8vjAVgqxkhmAlOGKWJ6oFPGuEhCobmoV/tkIJ+1e9IOkIfkisAe+FGckV+5PEhtiqXvhYbJVIFfGkPk+tiHT1hzzyUR/7WptFmD5rt3T7imXitJtwnUZFHiG7qFQp/vAjHrwlEIGbw1W9Sl64aG1Tsq+jE3tK6bCvXp5RomOZWn0CaCzirBPdY5LK9nn2erDoJoZUC0gc33Qt4d/jjjPbBt4JV4AXXtiMl4bIDeW74Kg9fOxfB00G5nXsHwJ4GViXM/XSo66W35XfvhV7RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2A+VszkfDYVuuq8uttMlwjoZgX2onDeFURjbYwILpbU=;
 b=oogtMr1pau3QvQm0/TnmYcwISyWAPeTaUb7d/2vOxvvLdz7JxiE+pt24aSbJFrKkbLKIAzlK1zDdTuPOfCE1V/ab3++QK9crzOIVEl3C9gAo6KgDpfcE+eATbR8y6fZ16MPzDUMIoy906hRQT3oiUFKhL8je7P9fIqSKEJqWOoc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA4PR10MB8566.namprd10.prod.outlook.com (2603:10b6:208:568::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Thu, 7 Aug
 2025 15:51:51 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9009.016; Thu, 7 Aug 2025
 15:51:51 +0000
Message-ID: <92a4ae05-1437-43f0-8300-f286ac7452b3@oracle.com>
Date: Thu, 7 Aug 2025 11:51:49 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: sparse warnings with nfsd-testing [was: Re: [PATCH v4 1/4] NFSD:
 avoid using iov_iter_is_aligned() in nfsd_iter_read()]
To: Mike Snitzer <snitzer@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
References: <20250805184428.5848-1-snitzer@kernel.org>
 <20250805184428.5848-2-snitzer@kernel.org>
 <d3249463-411d-4e0d-aa20-6489cd52c787@oracle.com>
 <aJN7dr37mo1LXkQx@kernel.org> <aJTLL6z0OVZ1k_XC@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aJTLL6z0OVZ1k_XC@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0409.namprd03.prod.outlook.com
 (2603:10b6:610:11b::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA4PR10MB8566:EE_
X-MS-Office365-Filtering-Correlation-Id: 032d24d6-3e51-4de3-c666-08ddd5ca5343
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?OWtXS1VwMzJkajZ1cDFEaGQ2U0pienhsNHpEVUdHc0VONE9BM0k1eElrTWp0?=
 =?utf-8?B?UHE0ZkF1THdyandVL3ZDMVZGa01qRXB6UzRhSTkzZWMrb1JzQUI3d3RSdU0w?=
 =?utf-8?B?S2RadlBHRHFqR1ZhSmpoOWRHOEFodWVBaXhiVnFjUEdTNmNLa091SHArWW5k?=
 =?utf-8?B?V2xkVkZEc0dQWm9qdzJQa0VMUTVYcWxkMWZqenhjZS93MHJEQzFyTmRxcUhu?=
 =?utf-8?B?U1cyZ0hHdDg1ajd5ZGtENUJ1RWRJd25ab0dlK09RYkp3RWE3NG5YRHJpQ1or?=
 =?utf-8?B?bnZEMU85KzlWNENKUCtJTVc0czl3TnBDS0RBb1FTYmI5SjRqRFR6RWpMKzdl?=
 =?utf-8?B?cXloUERhMzFoY01kS2xKS0RPM3dwZUFDemJQVVpIN0svNEFFQzRzRFdaZis4?=
 =?utf-8?B?MXJ2YmNhdUVxSXNndCtZeThpQURvc21nYkhuUTdYVjFGU3lickZhTmErWjlt?=
 =?utf-8?B?MDRpalNsYmZGRmRqQkRqL1FMZzZseG1ZMGRxMXhkdGdzVkVKd25ZWDNMVWtM?=
 =?utf-8?B?Q2NDYjhabXF6c2FSTUpLcXhaeHg2cmZ4bjJ6bHpvUEZxTDR1UDBkbUQ2YlpE?=
 =?utf-8?B?V0MyUmNnMkgzcjFZeWMxYkE5MS9RaktKaHNTN25vRTY2U1NscDRLOERlYTl3?=
 =?utf-8?B?UjVHOHcvS1NFMTJaMXdQV2xGdndqZG8zSXNrSThydi83K2IyczFubFgyT2VO?=
 =?utf-8?B?bkRsdnA3TGNNNHFCT0ltOTQ3MnVjS0RBbHZNTTZhVGtNRUZZSVRNQUZJQnBP?=
 =?utf-8?B?Mm55K2FkNmdhQTgyNW54VVc0T3hJdkN6Q1d0Rk5iVTdRQ1NFTDJCR3plTEJx?=
 =?utf-8?B?VmFCenA1Y1JrM0VqT2o4ZGJmQ2pqMjFWVU1LcDJuK0pvdHpwZ3JmaDN3WmJS?=
 =?utf-8?B?YXVKY0Yvd0FtYnRDSUprNHl3N214ME5ENDdYUFZoN1YvNzNoaGV5V2NoM0tz?=
 =?utf-8?B?YVBNZDdjdEVrUVE1eGlxaEFtT05zTkt4RTNXZ0E1M2gvc04yd3RyckJhSm9v?=
 =?utf-8?B?TDJ6dCtTNkNPUlRHU2Zya3lCQndlaVBZUjFTU1hlZFJ3UTVTNTh5TTk3SEhu?=
 =?utf-8?B?cVdTRmF0L0FHUjVwWG92eTZ4WjhsUXJoN29rbDdEMkljU1Z6RGpINmNEQldj?=
 =?utf-8?B?cWNJSXM1RkszdVdsTGpNdnNJWkN4Z3U0TS9CRmZTRDlDSjFnTmRUdENxQXhX?=
 =?utf-8?B?RkpId0xEekE5d2RzL3hJeDJOZ3pqLzJ3TDhtWjhzYmt1Nmc4blhSZzNxZVZn?=
 =?utf-8?B?N3l1SUcyTDNRS3I4NDFtVXd2NVpocVlGRWFqeEtaTGZYRnZMZy8zV1UyVzhE?=
 =?utf-8?B?c0t2ZDV4SlZOYVpQZzlTV3B3NnY5Z1RDUWxybEpnRmlnbjNqZnVWclNqV0xJ?=
 =?utf-8?B?UDZjR3NvM3pkazI1L3ZOU3BIMzZVYStTclFPQXFUWUtNNE1vT2F6VWJ0Tlc5?=
 =?utf-8?B?UysvQThFdktDcTdzMVVyd2pybVZ4UG1ZV0JseEtEZzVjWUpGMjRZVmQwejgv?=
 =?utf-8?B?REVPZ05TbjFjeUNNQmhheVY0a1R3VGt4c1ErOG5FazhiUWFCNm5kK3UxaHBD?=
 =?utf-8?B?MlFvSlUxWTVRWWcyTnN6YndKWFdSRk5jQ3RLc2RaZ2xJOGlkNjhBc095anlR?=
 =?utf-8?B?eGdKcWI3WjRmK3RSNTUyOVZLQWdBcFZ5V29aemkrSU1jNkY2bC8xREh6MC9Y?=
 =?utf-8?B?dnNzeW10RStreVNYbUZtc0xoTmdtR1VpOG9zNTVIa01MS3YzV25LRmUxN0d5?=
 =?utf-8?B?UmVBcnBlS0ZZNzExUlcreEY5QzViUVFnWVpwa3hlK2dSVC81ZXJSZy9pcmRw?=
 =?utf-8?B?SzVoNWVJWXZHdDFhbEpaY212UG9Ga3BtZWJEZUFQK1VBVnhzNGlhd2ZLQ3Er?=
 =?utf-8?B?b2VVZmpNSjE4a2dFdUdEQXUvVUd2ZEc2Q0tzakRrdlVQKzYwOUFuc1ZkV1RO?=
 =?utf-8?Q?quIhSgXjchk=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?cE4zZUt4VEhYSHdNQ1dZTGFCeWh2VHJQdU1MbUhVVDEwR3UyR1JsQWozb2VO?=
 =?utf-8?B?N1BJaWtBTFVIa0Yva0VoeXgrNFhhY1JoYkNvczNxTjdOVGd6MDdHeHdBU0xP?=
 =?utf-8?B?Rk9pYmlSL0VZU0ZxUXozZ0tTME85RGMxWnh1MEdHN2dxbi9CS1hoc3VQVzF3?=
 =?utf-8?B?UndaZUcrU3FUZUFhRm9sKzh0bzM2bXAydHhRRE4vVXVITjJzODJuVzMySTRP?=
 =?utf-8?B?MHVEb1Ixa3VwMDRzVWZNRFNMVmlnWTRzZVFLVit5Y3pYWVpWc0tjKytFZytL?=
 =?utf-8?B?cGVqaDNpUUcvcXdycHZ5TDA2SHJiZ3JaS015SkQ1N1FwVit2WWNEa25MaW9a?=
 =?utf-8?B?eXo5Y3pzVUQ1ck4vMDdvdUloYkZ5UEJUZU9Hbko0REthS0IrZm9lVHdZOUNV?=
 =?utf-8?B?U0FsMUxiRnBxNWFIZDVaVVJBbkdVendXemdFaWM1M1h5RFFTZkpzUUQ5K3pP?=
 =?utf-8?B?cEdIMGJaRDV3cXNNUkpPZXFzNjhVbi8xZHBnOUFINkdiVE96MXhhUEZJZTFP?=
 =?utf-8?B?VU5KQ1NlSzRjSHBock9nMWQ3aHNwREdKdS9YTUZnWmxZWk1JNkxDMy90RExT?=
 =?utf-8?B?ZFpGNGN5aTVtNnlzVnpPSXpZRG5haVJvRWRURGdiVUpqY0drb0kvYkN3blp2?=
 =?utf-8?B?RVU4TW1BSUc5dVg4SXo5RzU0VHllK2JzeFpFUFpsdFFyaTRqdlFzTVZzZEtG?=
 =?utf-8?B?aDYyUjBnYWk0TkNDU1ZPTFNaSkI3MEFYUGhLSWVIRDlBYWJ3Q2FRd29RY2gv?=
 =?utf-8?B?OWtnUytIdXZsaVFJbk9CS3Q1Qk40bUMrQUU3MXVBeUVzWUxiaURmQ3BxOXhY?=
 =?utf-8?B?Qk5MR25uWHM0ckYvWG5JMmJVZmIwQW12UzREbi9LOGZYN3k1VXdpYWZVN0xZ?=
 =?utf-8?B?bVdHbE03VnFpSGRWMkRtTHNzdWtWbktKUnNDakxMU2twZTN6QlFZSDRobUZN?=
 =?utf-8?B?b21TSnNCNW1mOHNtQXZZZTRIWGJWQW1VZnk1T1lUQ1JwTHo3aVM3VytjTmxq?=
 =?utf-8?B?SHN1ZWt3K09hbDJoNS9vK0VjKzFEaS81UFRDOWRZMUhLZFBUNDl0cDdScHNl?=
 =?utf-8?B?NDF3QWxTaUR0Ukc5S0FmWnlzbHJ6NHlYUFhyOEtsNi83MFhhMUFZalVIZXNa?=
 =?utf-8?B?Wjl2UXFvcmFSSk5PSUdKZnZwbFRac1FGSWNIc0xCbGdNVEtKSjh0V0RRTXhI?=
 =?utf-8?B?Q1haUkVoc2gzZW1GZU5MaklHTnIycWdVc1Z5OTJUYUVuQVRFTFZNY250Skhw?=
 =?utf-8?B?RytyMnBpYVowNms5VDAyYTM0WHlOQkp5cjFkczY0MldWTjd5VjFoVnRlUXp2?=
 =?utf-8?B?eVVFMEIzWWFOQVRQckx6a3lsblZCS0cvT2ZnQm1pV3dIeGY0VDZhNmszU1RD?=
 =?utf-8?B?UU0zQUx6eS9UZWpoVVdUY2dRcm1FQzE0eE9ZUGhUTVFRTjJsTGVscEJ6NTA0?=
 =?utf-8?B?cGd3RUlDcW5nUERNRHYyVDk5dDRlWVRURE5ZUGJ2bFVKaFhDUmFjdFBxc1pD?=
 =?utf-8?B?b3ptbTh6MUxWUHlMZDlsTXlTN05RUkR3UjRJdW9yekU2Q00rZVRpaTBzUk1X?=
 =?utf-8?B?R2Z4YXZ1cmJOMFI4RGxJN05WaVdmdnVURDk2UXQ3cU1oczg0NkpucEdpVXJy?=
 =?utf-8?B?dUp2VDl4aU5YcTVHcVVQUGNNRWZRem9hbDRob3MxeG9JS1FNbkZ3cXcwQUlN?=
 =?utf-8?B?RW5XQllOUHVYWDcvM3dDSUlPTUFCZ2l1d0tUTWMzMHhlanllR0hXMG9LeC92?=
 =?utf-8?B?RTJ1dFdHS1RrbERTVWY3WDdXcmVmSTJZU01yU0dUUjhKSCt5OFBJSlVDMDdF?=
 =?utf-8?B?SnMxS0pVSVhBQU1qRjl2ZGlNL2dwSTFpYlNTVUdRRng2MGZEZmVSYVBlbmN2?=
 =?utf-8?B?UGQzbUlCR2JyRFBEU3BwbVp5dU9FMEZMai9sWDdMSUxWMUlNWDIydE5iQW0v?=
 =?utf-8?B?aHBEZytqMi9yUWZTbk1qaDlGcmE0dzVLWTFzbmhhU3FXaGpud282a0p6R1pB?=
 =?utf-8?B?R0pGY1U5M08xNkNia3BKWVlMbEhod3QzR2NHTnlJUWNNeis1dHB1L0pxRmpS?=
 =?utf-8?B?a1NOWEs5alJCZ1pSODZzNFc4ZmVCbWRBeitIQUsrakVpNU5ibG5XSXBhemtQ?=
 =?utf-8?Q?LmzlgYLkHxgAa7JgU5hLyoKDk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SQGUjQkIvpBQ1xPLhwZ2dZSncJB1hlshDf1GKtuqqRW8YHRZ6UCuG8TBrmeU4WmIeGxCojOfdtlSbC9qIZLH4fQpByujzAv/ClYO9PUs3+DoE/FNQs3U/TOzhzu7vSskGBoE1xMlCFaqiuAOn8DLtFt4YrNAyAvvqjGu0dotCI8FNaBogXp8hjOG/JIOg6x1wZP75SEvNYyNX05m9UsT61lV7V805kN984pFQu0mAYJ0MwE3KBquImfaR/+p8CBTXVpjAKHtvci3idB6wJHlTNJUOZQvPQ29LZIp18mttn+oujBs9WjbbfYZsGlatleBcissD+U+zz/AoJwzr632l42xgdG7VGZOohOohn2vnDw38oRZAvp5kxZAGg08/Ni0ICM0pPgt5jQCY5g2usmS976hDqLo9hRxa7INEBHU3OctTDslmFWa9OiQGVFr83AGn/dYjT9J8yWUNXrNmNc/iGuibryujeRrkmWuIjWwTnEFnHEEO4vBvJ9vZnQMZuATR2V+pkzZkejcHOV8nkJePGVNqlw0/A9tyMNopCCvMBEr3eIK8x9HtgRg+EEqPbOp/XWIUoe2zEefHv6hf3R7KyCK6yoJHin8eOT0hbGftdM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 032d24d6-3e51-4de3-c666-08ddd5ca5343
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 15:51:51.4691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hE5bQqtK0UVS7CahGSFpIj/adA/1VdBJnDyPbGYxxQMBgng2lMnLvhbsNuwiF06l7b4BGcv/j4IBcUwZy0Qg1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8566
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508070128
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDEyOSBTYWx0ZWRfXyCgamygMEgHa
 rSjAwkhT8RwMn+vV0Me3kbXkGkzkukdlihjzoGS1EVtRauje2c/hnbvQ8AyvxhOaDVEvrTfcOYh
 MeTlX7bvuojj3c0i9pfoXuwLI3+Grwg+zvyqc4U1IfdShrJKNgaZiq8kaDUFmGX4O5q6opsJe7q
 KhToZDHk/fqoh0lq06uc/1OP4Za+SowQa2oO4lNX7+ZgnERUW8ygN4BGOz+jUU2IFU878nYRc6N
 j4r/PzxryLW6bE70vvPJHmEH/PMvI+aY1Wf26HViX6VFi68MGCKLh2vVVIC0La2Hdftc4xsyXK2
 4QXBCx4usPv0KRXQqfttlkOc/QuCNzj5CYnf/OMP6XHEboNYuxmT2h80Wyo7ViAl2Sk1HHAqRrg
 kwNA3nZ1r6Dyq3mUCimRtow9BOI8+gpFhp6fmppr8lgAwFNNpHM8i7AuG01pMKnGxADciNth
X-Authority-Analysis: v=2.4 cv=RtTFLDmK c=1 sm=1 tr=0 ts=6894cb9d cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=SrD53NIJ4WFiUi_MM5sA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: R0Yah91-EjMCsKFpqqrPrQDhyeDMvLCe
X-Proofpoint-GUID: R0Yah91-EjMCsKFpqqrPrQDhyeDMvLCe

On 8/7/25 11:50 AM, Mike Snitzer wrote:
> On Wed, Aug 06, 2025 at 11:57:42AM -0400, Mike Snitzer wrote:
>> On Wed, Aug 06, 2025 at 09:18:51AM -0400, Chuck Lever wrote:
>>  
>>> Before reposting, please do run checkpatch.pl on the series.
>>
>> Will do, will also ensure bisect safe and that sparse is happy.
> 
> FYI, I'm preparing my next patchset and sparse is happy with it, but I
> wanted to share these warnings seen with nfsd-testing through commit
> ae83299cc048e ("NFSD: Fix last write offset handling in
> layoutcommit"):
> 
> fs/nfsd/nfs4state.c: note: in included file (through include/linux/wait.h, include/linux/wait_bit.h, include/linux/fs.h):
> ./include/linux/list.h:229:25: warning: context imbalance in 'put_clnt_odstate' - unexpected unlock
> fs/nfsd/nfs4state.c:1188:9: warning: context imbalance in 'nfs4_put_stid' - unexpected unlock
> 
> I haven't looked at them closer. Could be you're well aware of them?

These warnings have been there forever. I'm told they are the result of
bugs in sparse.


> ps. but full disclosure, my baseline kernel is 6.12.24, I haven't
> tried sparse against the nfsd-testing branch itself (which is based on
> your nfsd-6.17); but my 6.12.24 kernel does have all NFS/NFSD/SUNRPC
> changes through nfsd-6.17 + nfsd-testing commit ae83299cc048e).


-- 
Chuck Lever

