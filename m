Return-Path: <linux-nfs+bounces-10714-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E4FA6A6EC
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Mar 2025 14:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5E60460976
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Mar 2025 13:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5931DF247;
	Thu, 20 Mar 2025 13:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DYRtV/3t";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="raAiz28Y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7BF290F;
	Thu, 20 Mar 2025 13:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742476611; cv=fail; b=gY9+BV9jxlDNjj3yzAtRVXWVIQ+6IM5xXaKenaJc7Xp0MFCUZShmWi9AHTRou41FFN4fBMCXcJ2IHX+5QvWGbS19sNh1wWD00sVtIYeQn3IICY92vVhbfOQWWa8l91w++4MHMF6WZnWSdT9WK9dQkjZErOFhtSNHL3EjFD0AsbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742476611; c=relaxed/simple;
	bh=zyp6rFL+ipvLCalFQrEk4BYdteyo9KhRv6oDJKPe1ZQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UOOOT1iJWWIBnYoP80x5qdLVskMCnSx9VpONjsYo6gfW1eVNioDmD5W78du0uLKGzSR/WbbVg17v4lHQ8HHngwZ5tpQ8KZzR6dVJMTimK47RN7TtKSLUZIIAWLAlpGXNslCJbVWl+dNveE1f8d3KuEFAzuAQuR8WAHw2ZXO7AOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DYRtV/3t; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=raAiz28Y; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KC3fue026771;
	Thu, 20 Mar 2025 13:16:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=FNbH7UJzeYaLEgrqpVLQFmQpH1n1zJtXKDVvP1npm70=; b=
	DYRtV/3t0IRq6M99buNTFOwQLkwxzLx8wNItqr0d46JNL6SU0HPs3FpM3N06N+gV
	/V9zNkmTumGsmWn+7dFn8q3lsj5QasEYwovAdO9Tw0Objyo/0KIu2fpcnZwu9dWL
	0lHWYAfkT7dOQhSLMmHw2pL3bOgVR+BBPd7+ejDNfUWvRKHfy5vEqXtGaO8WBcYG
	f7mRUEU/Wr4+xcScEDkfvbnNXVZ9OjjNL/jCWjucBh7Pp70w2FL6VOmzfQh+AC1h
	ARmYwrheSEMn0m5anpFJfYVztEfQg2TcxMirZgaBinHkT5qtXKTCgfP2j5TJjUh+
	14jzcAbnzk1i9iBxqNVKTg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1n8nt8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 13:16:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52KCDDi2018653;
	Thu, 20 Mar 2025 13:16:21 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2047.outbound.protection.outlook.com [104.47.57.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxdp2767-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 13:16:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q5w8wBUwDG6782cNqnhPs5RxpfdxuzReQjHdIl2FvojQb7+uDk0+tb/tsRqSYM3G1sipwBnxIUc2WCVpHn/7E+iaB53pCnxZzqwZmzL1ezyOucgrjDMiSq3m8/IgRJnO7mpuNuUANUyh7b/coMBsqvCyBoUURHzEUPo1qjyvuhz4LzT1VvLT+x2EEBPa+O4Y9Y3wkGIsPhudITLBBp2ouanoUaqEtDiWQMB9D7G/JWhSPqmkopJzazirQXsEyKMUyoY/q1knKVI3VbvYvOQHYEn38/Lm2Mlb2xX7V+jvSRnC0iIljoFwWOLcSTeO1Ri0ogCeYKK+yrgM8dlk9uRQ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNbH7UJzeYaLEgrqpVLQFmQpH1n1zJtXKDVvP1npm70=;
 b=trhASNIUOrVoJkEAQZI9Q56jPqtIGFmUtYYk4WPOel2hWBGLe3jNJYXIfNhIjX5GooQUwZuJTunKR/IZ7RV9QFqiVFbLYOGkWssPsc3FM97Tdj4ZCJwAhAn4UPm503QyK/IhznMVbxdzHEs5UQyB7BeG36sTXwYC/NHrrZXu1G6rymaHBpfT4d5stUriIqJ9UlaLVrr9U6Ay0boJ3K2uOJHKzO1KEoCGs6BmdrDZgkqmAaCiDFd5EEx5XTYmJrtONxW4ranim74Zd4sOZf67rmaPgwsVA5Mo0PT5ewjyM9lKP0mEEVdIM5gJMdKORFhn7g5VGcNy7qgw+qpDJm/uiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNbH7UJzeYaLEgrqpVLQFmQpH1n1zJtXKDVvP1npm70=;
 b=raAiz28Y00Ngse8Y7+7UVhxhIyRXiDS14FN7Gucl+x/9De5VH3fLZYzjW1UFj4aGdPHfsQjT4cW6YmpTrh5b2ZKZwIUAOAstceOiW/EnO3h1bmOyGfxEOkI8VkOdtcaQFsToyKaeFe5IlhmsL7KvIfSwRUYOZ6GPzMVV0FePBTI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5626.namprd10.prod.outlook.com (2603:10b6:510:f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 13:16:18 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8534.036; Thu, 20 Mar 2025
 13:16:18 +0000
Message-ID: <d78576c1-d743-4ec2-bf8c-d87603460ac1@oracle.com>
Date: Thu, 20 Mar 2025 09:16:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] fix gss seqno handling to be more rfc-compliant
To: njha@janestreet.com, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20250319-rfc2203-seqnum-cache-v2-0-2c98b859f2dd@janestreet.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250319-rfc2203-seqnum-cache-v2-0-2c98b859f2dd@janestreet.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0432.namprd03.prod.outlook.com
 (2603:10b6:610:10e::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: bd931d65-475d-49f2-844b-08dd67b1664e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zy9SaFUwcUlEK3k1eVVNZnZsMXYvbml2VjFsSEg3Y1BPSlQxNVlaQ2J2N3Rn?=
 =?utf-8?B?WWI3bDNEMitZQm50SjhNbDJEbHNDOXZtQTBlRkMyR1hjQkV2VXEwOFpSc1lP?=
 =?utf-8?B?TmF2T0hkcGxnZ1QvQ2NzemdqQjVVRXFvRWUyRWU5dmljcmlwTFBpWWxGNGJ4?=
 =?utf-8?B?dDNEVEs0MVl0STVTbHpYL0tNRHYrd3NTTHEyZEl0T0QrdE5ML1pTNm1MS2lM?=
 =?utf-8?B?YVN0UzRoRXlXUmlVZTVRa3ZqQ0xLTlM0eDZhNE5LK1JPbjVYMGtFZGN4MHpi?=
 =?utf-8?B?Zng4SkNOSGpmK3NQL295ck4zQ0EyT3pQZUh1QU5ESVU3U2k0bEtjby9Lb3F5?=
 =?utf-8?B?YndlUi9TSzVSN2RldStEU0I5aXZJKzJKTW1Cb0lQcjJVaU8xa0w0OHJPaXlZ?=
 =?utf-8?B?akZNRUxKWW12QWc2WnVEL1ZZakpnUVNFTFRBMDNpVjZIUmZHbmNpLzNtYUtR?=
 =?utf-8?B?bXVZdmNGS3ZmZHdLMzZQSnhIYUVNR2FheWhHajNRUUhkaFRrVFZodlJ6Y3hN?=
 =?utf-8?B?bitZUjI3SWJ2dlBNZW1mWi9pb3l4bGZuS3JSclkyZHVkT3RocGZPS3FMdjZE?=
 =?utf-8?B?MDRNWTFQdlYyYk9SMHpud0lMTUtMemFSNUlHUGNJQTFrTURTY2FPVENCRFpw?=
 =?utf-8?B?bEVqMjNOSmRjelArMWVpVjhMQkxWQzhXaU5FcmpyVkNqc2xSSExpZ0ZSUFgr?=
 =?utf-8?B?Z21QWjlqNDIzT082SkxYUmI0ME5SZVpLMzdXa1lrNzN6TVpOZTFZMUZGUjBF?=
 =?utf-8?B?aWJXOHk1ZGFDeFFBUlFnNTM5RGk1cjltYzlBTnpYbTFYeDhNQThWWkpqT3NV?=
 =?utf-8?B?cGphMWN6Nmc1R3RDVmRWN0pvVWR4VG16TjBjRjJGaTVlWHhDRnY5Qm1mdk1w?=
 =?utf-8?B?Q1NGM29Id1VTYlcrU1A4RUdhVXpSVmFyNXRlakR2clhjS0lhL3RqbmFCdlNI?=
 =?utf-8?B?WmNIYWI4MFJRMHNIVkg5bDBrZkkxUEc2czVFclNEa1NtaHJLdzJsSzAvbXlB?=
 =?utf-8?B?YWlGNnc4aFZnaDhtUUdoVG9CaVdqbVIwaUZ1U0Vrd0o1U0Q4MWZQeU12dU12?=
 =?utf-8?B?ZjdEZTRWbStaZk1VUm84V0pCcFJDZjBXQnQ1K0l0MVZUZmswL0FqOXVNSG14?=
 =?utf-8?B?N29nNnZjNzFmVlRiRWlSWjBPSXpVdWFNRk5KMFVqUlpaME5SVk44M1ZkbjhW?=
 =?utf-8?B?ZkFKckFackVCcmlDSkM4SThTa3RDRHRtamNydTdrK0RMT0FHNXo2L0hBRmU4?=
 =?utf-8?B?eG1iQ0cxUEIwZW1jQzdUZnp6UFA5b0g1cmFHK0IxYXhmNlE2bHBHRnAwejQy?=
 =?utf-8?B?MG5EeHdUWFBaa25abUJTYXBrUzBqVjFKcXJyT20wemprSENnSThCdVU5RVVK?=
 =?utf-8?B?MkRheEovdWxqdld4aHZDL3ROOFVKL0RUWEx6eU9wUEI1Vmt5RjdwZmdLVmRZ?=
 =?utf-8?B?VHovd0owbXhMbU9HNXNkVXZqRkp3S2RUSC9DZ25mdm0zd3lodXB3U0NDTk5j?=
 =?utf-8?B?b2JZbHVWZUwwRUl0U01FQUVUdFFrQzdZRG92amFNblI2UitYVXpWTEZqTFJn?=
 =?utf-8?B?MzNPQmdvMWJITVIwMlFvTVZXVVF2TmpySEhnWkFUalNtU29DNURobVBnSnRy?=
 =?utf-8?B?S0tEWVNGamcraWJreWNqRDY0RUVTVHlVaTZKb1hUUjFNL2FYUU9zbzVBRkVu?=
 =?utf-8?B?WEdtTmlYSGNMQ0JZSEtjK2ZjZjcrWlE1NlpSWXVscWhGMklsM0lRQ3pBdUNh?=
 =?utf-8?B?SGhBZlpPSndTUVhCcklrSUFaRTVBektWSGRZQys2aitBZ085dXpnYW5XbEZw?=
 =?utf-8?B?blNvVFBERE5tOWZ5MjBEdjI3YWRzSThGN0V0c3pPYTZIMVp4aTY0MVNhVkJo?=
 =?utf-8?B?TVQraUNUOGtxcjF3dllaS3ZjaGRtbTExRFgyOUJvZm5DNzhOcWVEcHZkS0xL?=
 =?utf-8?Q?DYWyTvVmlwQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTRxSHJxNlphVEpTb1Z0Tm5OOTdCOEFsRW5OTWlXbEgyQW44VkNJRm52MkJ4?=
 =?utf-8?B?V3U1OWZTSzJpTGV4cmM4UVRKa0piWXpsblpjQURCaCtuUUhibGZIRlBBcmxZ?=
 =?utf-8?B?dUU3eVFKQmo3K1BzczZ0ejFENDRJOFVVRHFCakJPT3EwV0tZa1l3OU9QSUNP?=
 =?utf-8?B?QS91SDNJUDRGTmRCZTZTdnJUcFpRODZPR0JjUmNyUUxmUUhveUk1ZHhKdGp6?=
 =?utf-8?B?cjBaTnJEWHpST1hPQ3l1RVc1NXhYMnJ3L0hXeEo5cWFvR0hXQ3l2MURFaUNG?=
 =?utf-8?B?K2swcndNRklvRW5KSHBTU0pDREN6KzZiRWQrUXgydGd4R1pUMUw4eTV5QmFh?=
 =?utf-8?B?d045RlpmUlNmTFhxRG5JSjlpTkZGaDJvdllOYXBLNVpwdDNBeE01d3ZQZjlT?=
 =?utf-8?B?blhvZ1I2SlBZOVhYQnlzTEEvbXZrUjUwbXVmWFJodEk1cXRybTI4dG8rcTVO?=
 =?utf-8?B?c2ZqM1AxamdTRGUxTHBQeldqZmtTRHVnM2VMOG1OdldSdkhxa1hwZnBKOFc1?=
 =?utf-8?B?dURscmN5VTR5RDhkanpUOHJZQVdhZTNZRkZmN2dQYzRWcTEvYlFWM2V6RTRC?=
 =?utf-8?B?UHBqRlVDeWtiSFpnR2F4dllrUzAwdmpvZStSbzlwY05RV2cwTitTQkZpOU83?=
 =?utf-8?B?c0l0bnRYeDVTVWoycXplZWNXdEp6OHFjVll3L2dZTnBxNmFYZ0NjMnNPMEg2?=
 =?utf-8?B?SG8xVGJqclc5K0YrUC9Id1dTRHg5Q3lIcFprKzhmMitDU3BFYTFodDZpblo3?=
 =?utf-8?B?TDJIbXIzVm5TTnRuN1RFaDl4NXBVejhzL095OERyazNBcE1GM1o4WUZoMEdC?=
 =?utf-8?B?TEN5Y3UwWFNBckFGcUlhWkN6YUgwZGc1OHVDNzJOdE9TRlN0NzJHeEdsZGw3?=
 =?utf-8?B?cTVSYmMyRDIwS3V1UVc0RG1Jemw4NHgwNUJSQktBbW1zZVY0S2kxQytyQS9J?=
 =?utf-8?B?YjFmRDlBczdrMVdMVE1EN1lka0pobER3cU0wUDdIQStjeTFkeUhZcnJUeUcy?=
 =?utf-8?B?eUp6d3JIblFYQnhuWkx5cDRUMURYTkNvUGNWNXY5RVhYMXlaQmFUTk5JWHlM?=
 =?utf-8?B?OHZEb3dyOXlkbW56NnhUNklHUHhZOVY1MWd2OU9DeTh6L3h1L1JrMzYwd3Vu?=
 =?utf-8?B?VnJHS2F2NkRhZmtKYnpVSVI2eHJoZTk1KzdtRTkySmRZSXBqT3JuU09id0g4?=
 =?utf-8?B?NDNLOUkxWEZ1K3VkRU9HQjk2QkY3ZHF4S0ZzUkM4UHozODlSYVRramNHTXUz?=
 =?utf-8?B?YnhGQzk1dzNHWStWY2NaNVpxVDgzbmRKK3I0ZnRUa3dKNW5HSUFCdFh5SlNx?=
 =?utf-8?B?eWJyb2JLelh0aXhHMDFXYUhXcW9LNWZIOFVGRHplMDFhYml2aHIraXd4Y09s?=
 =?utf-8?B?T1RjalZFN3I2MmVRN0FNQ0U1eHA1ZEVzOTNGVWFBNXlVU3ppM29LcXZHeDZZ?=
 =?utf-8?B?ZTl4RW9pNE8zRlQ3amJxb05rK1JZVUxZaW1STTdsWWpSSkN2a1hDaUIvQ2pE?=
 =?utf-8?B?QUlGMXVJRHB6MVB4bVJ3ZHlUM0RPSEViQ203WFJSS2xnUTQ0R21oQnlrVGxF?=
 =?utf-8?B?WjdEemkwckx2Q2I2aTlKT2V5dGxiM1dDcGpRZ04yTEU5c0dPS2xWRWQ0M3BU?=
 =?utf-8?B?YTRCeCtXT0tQTGgvSnFLOUw2azY1YlR0SndiRWxZVXpOUEdOMnNLbVhsY2xC?=
 =?utf-8?B?UXMrTjhlOExEbWlkaW5Eb0lJcDJ6Ni84N1ludzRqcG5Mc1dVbmVXTW02RGx3?=
 =?utf-8?B?S3ZaMU44Vk1aNFJnTWlsd2liS3FIcWdZRnZtNG03OHFCdHJYckMrdlZwbGZE?=
 =?utf-8?B?ZThjMWFpQ2RwY1NzZkEvazBoQWlKWm5WNTYvdFNxTVl3bHUzdXppRUk2aUw3?=
 =?utf-8?B?cmtDSjlKbHhVNThjWG0vd3o4cTRhMm5BL2R3eDc5bzJkU2wrZ0xmaldKSElv?=
 =?utf-8?B?QmE4T2ZycUdxaEEzMHJDcUhpdG1ueng2dUgzYU5GM0FvODhTQ29BNFBubkFH?=
 =?utf-8?B?dVZvWi8yeXFhTllLQ3BJZWdydDkrMCtTdU02bkM3dDlSR1F1NFNOMStaYjQ5?=
 =?utf-8?B?M2YyaTJHQklTVDJrV1FhZGtGT3J2UW9keTBMNzJ0UmRkYTdobWVkTTZOejRR?=
 =?utf-8?Q?Jb8S2wf9L6O6tEj2uXQC6ZA4V?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7KZFdcFXIbyRx3ryNathARvJiCTL6UCnib9URkzpy+Fjq92Kjo/QdPd6mNBkkjs3FT8cMWAp+IqoGUagkNvKlLDGfNYpDFkQhp8xU0vqnsSYIvCCz5VhXjC78cEk2j/fFU8udJRGgRE17Tsd4+k6RiGm5LQF6RzwLoLyka2jpWtL8/xqBtkRxLxQQXEWTlw1ipYzqkk1Y1DZ3dHxtsxxxbyJeNRt5x5WTuSquf5YAFQZbLogOcAVmieXEtOgmvJKJIwe/M1Owfve/M6KzCDAVknVkPletlgNfMOSClSJb60qvxqTa2Z41WeRuflR5gEvPoyKk+ZNRWAg0XoXFWpURFVbJ9m7B32rS+M+SiJn+qQDzn8Hsrloy9+PrD/BkoY3bv+XCogtDKyEk/ZuLaE03Ksz5+P4s7hF+/s0GJdqgxk7BYdlEWR1fCMe+6qk/AbC3n+rjGOgfTVrPnvbAhlq1L/vaHdNTRNesyGZ8rFlelt5F7YucJ3oJZL6HuHz1MCPNBg+ybc6AY9scNZrk7pySHAdVXdM5KQB4KY0VfK6W4IlZrY2GFpYmTnrG5plGGqHh4psMf6R1kMe7nzJ5iCkJk8ytHRFYdhuEFgm2XAB/gY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd931d65-475d-49f2-844b-08dd67b1664e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 13:16:18.1942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/gNd7szR0OY6v2oNxmW+ZC7X3S7gDNEdqIzWORVCebpqKGNQg+kzifxqNdfjby0RtDBR9QnCA7f7ndELI+Lgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5626
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503200081
X-Proofpoint-ORIG-GUID: fVygn9nsWACeMQAyNLjY1O0-l8ZtSMdU
X-Proofpoint-GUID: fVygn9nsWACeMQAyNLjY1O0-l8ZtSMdU

On 3/19/25 1:02 PM, Nikhil Jha via B4 Relay wrote:
> When the client retransmits an operation (for example, because the
> server is slow to respond), a new GSS sequence number is associated with
> the XID. In the current kernel code the original sequence number is
> discarded. Subsequently, if a response to the original request is
> received there will be a GSS sequence number mismatch. A mismatch will
> trigger another retransmit, possibly repeating the cycle, and after some
> number of failed retries EACCES is returned.
> 
> RFC2203, section 5.3.3.1 suggests a possible solution... “cache the
> RPCSEC_GSS sequence number of each request it sends” and "compute the
> checksum of each sequence number in the cache to try to match the
> checksum in the reply's verifier." This is what FreeBSD’s implementation
> does (rpc_gss_validate in sys/rpc/rpcsec_gss/rpcsec_gss.c).
> 
> However, even with this cache, retransmits directly caused by a seqno
> mismatch can still cause a bad message interleaving that results in this
> bug. The RFC already suggests ignoring incorrect seqnos on the server
> side, and this seems symmetric, so this patchset also applies that
> behavior to the client.
> 
> These two patches are *not* dependent on each other. I tested them by
> delaying packets with a Python script hooked up to NFQUEUE. If it would
> be helpful I can send this script along as well.
> 
> Signed-off-by: Nikhil Jha <njha@janestreet.com>
> ---
> Changes since v1:
>  * Maintain the invariant that the first seqno is always first in
>    rq_seqnos, so that it doesn't need to be stored twice.
>  * Minor formatting, and resending with proper mailing-list headers so the
>    patches are easier to work with.
> 
> ---
> Nikhil Jha (2):
>       sunrpc: implement rfc2203 rpcsec_gss seqnum cache
>       sunrpc: don't immediately retransmit on seqno miss
> 
>  include/linux/sunrpc/xprt.h    | 17 +++++++++++-
>  include/trace/events/rpcgss.h  |  4 +--
>  include/trace/events/sunrpc.h  |  2 +-
>  net/sunrpc/auth_gss/auth_gss.c | 59 ++++++++++++++++++++++++++----------------
>  net/sunrpc/clnt.c              |  9 +++++--
>  net/sunrpc/xprt.c              |  3 ++-
>  6 files changed, 64 insertions(+), 30 deletions(-)
> ---
> base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
> change-id: 20250314-rfc2203-seqnum-cache-52389d14f567
> 
> Best regards,

This seems like a sensible thing to do to me.

Acked-by: Chuck Lever <chuck.lever@oracle.com>

-- 
Chuck Lever

