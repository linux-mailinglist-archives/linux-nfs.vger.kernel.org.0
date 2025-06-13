Return-Path: <linux-nfs+bounces-12449-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35978AD94EE
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 21:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DD491BC10D6
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 19:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B41235364;
	Fri, 13 Jun 2025 19:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WGHeAiyH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TBJQ5rPa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA14E2E11A5;
	Fri, 13 Jun 2025 19:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749841283; cv=fail; b=Mex7TLNaync/TvYcfkaz8CWLaqNu+m9y7tjLUFTcxUNmehB2a5Hd+8A7WzxrinhqY3eOUebQ7qlRu6HFLh/Me6I3NfkL2y5RuqiJgzIKfAkB9+vAkfBVweJgvvjazID6eLi1Cw/gmeQJky/P+7Qsagpkjqzd4JcBfxCvBtI9nU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749841283; c=relaxed/simple;
	bh=jQG9IHsIOFzQ5sh4AoyQzeeB8NA07QyLIHgm66j9x1s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OPv4BLjRjc4rX6bO2FdpjrTeu74S7ia5vtx7jiPi4iaTF0rMVZWRAWRCuZG4fjBl1S4V7ZzoT+MISxyHcxz3s92k2vuFonfcxt9MnQwts96wHXK/vyaUDrUN0KQBNtjsCeqa043sSxj30wUF8MzgyjsjDcB5kXygPjb+xadQRis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WGHeAiyH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TBJQ5rPa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55DCtZD1009394;
	Fri, 13 Jun 2025 19:01:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=NuChkPFA1CL8BJA1p4qb7LcJsAHO+XY/cETteQRCoWQ=; b=
	WGHeAiyH1QTfi3VOXXbUOe/Urf+3PLL6b8MjY7AqGxBc2uaAIzbiuM/TPfPBcPTH
	WbsHsRA8HCyxwG+nkFSTGNZ6/pVthEdin2oSQsTfEsE6tozFdKCjo5K8FGzj6+bv
	0EcH0udem4fOIZE2LIF41IazGM4uj1U2TXTpXZFozJ+1R8PFOgBr/2/TpoobI58j
	fsnE1XW3IOdNvkM+q1OsJIHIZgLlM5d8YsJXH7q2t+UmFVyspkfK8hQQ+vzB9RMD
	SCkrUppnwuQhBO0bcVn5x3aiVyDll9wjTT3/0X3Qw9AXrlaohjugvN2t9yZQ8d3T
	eUZztJyOVVydza8HgDwf9g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4752xk3kah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jun 2025 19:01:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55DItA20009168;
	Fri, 13 Jun 2025 19:01:06 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2045.outbound.protection.outlook.com [40.107.212.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bvdy9eg-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jun 2025 19:01:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HsuttuoXgJR9DjMCKEdk6DT6/3rBkop36W4beq+GY2GrPy89gQjO/KgHsNmxeC7EMXnTNtkURKp7iIjwp8Dl79/MNQloWP27ogrHhgyYveSn0DrZesrGfIr8ziLI6zMDF0owmk1jr+81a/s+K3HuMAbkq0E2Wbtq641sHhwdDN0Dw9w47njznKCd/3bTr6LO5zyu1bXMUciulrx5+1go+wBwQg1cLhBFSLESDfgstJFl2mBMm8KgTXPNUb165JXsUyfB1ZR49KV8LnJk9W1R3aGGdz3l42PB5sLyy6jmg+N9kI7Y1Xuo7W4Txvfm6lqwAizgUGcQMlTnLMWjkZZh/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NuChkPFA1CL8BJA1p4qb7LcJsAHO+XY/cETteQRCoWQ=;
 b=J8qqSHSO2ExwZFd6dw9HrzkYSPZRZidIdqiN8hjn7F3H827lVY9m4OSenJldNrdDvhcfdRUd4dGQs7jwgFYdfBTwAHBfSSMHZZVtHlUJnucF62RAaQEcjqbklCG1SQ9tX1VqwShgzyuRXdZl90lE5VhWQuebopR0geB+s2w3nDHmZNl4fZh60Qvh85Y9GNQa5R4+pS/SzOlAQWyDDo0RN9xfsht77OWtteYFKivzlsFtpe6ykFQVOXsWcleyDJ4PVMpXdjHnkNiL92hYZaatliNB6HZ1NZWkVmE0Gg08rjZgLvXkZYOOj4ya3MJnjOMs9p9oI64kO3vhG9qxzvy3fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NuChkPFA1CL8BJA1p4qb7LcJsAHO+XY/cETteQRCoWQ=;
 b=TBJQ5rPaCiTN7+vlS7xrJuz9r09Zc+kRFUyGrgFVZUbEnTmdHFgULjo8pEP9bLyUdZsv/Wp3ImN/gTSIKsb22cYTb3w1wpEHb6gpSpzRTRku3QPXaNVRMYm34cOsWh+va82F52NjgO2E90Up4+jSPXwYloq8TrvcWyfWFGMCxb0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6463.namprd10.prod.outlook.com (2603:10b6:303:220::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.31; Fri, 13 Jun
 2025 19:01:01 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 19:01:00 +0000
Message-ID: <6e7361b4-7511-4630-9f1b-d7968cbebd41@oracle.com>
Date: Fri, 13 Jun 2025 15:00:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nfsd: use threads array as-is in netlink interface
To: Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu
 <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20250527-rpc-numa-v1-0-fa1d98e9a900@kernel.org>
 <20250527-rpc-numa-v1-1-fa1d98e9a900@kernel.org>
 <a8d4c4cffe1a35ea831110ce1c7beea649352238.camel@kernel.org>
 <aEx0ocoWoFkp8oCg@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aEx0ocoWoFkp8oCg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:610:52::30) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW4PR10MB6463:EE_
X-MS-Office365-Filtering-Correlation-Id: 08eb37a5-4710-402e-1df5-08ddaaaca32f
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?cXN1UVhxcndvOHc0VVN3cGFFT3JEejNyVWwySXVGYXhFTlZKWG41V0J0Yity?=
 =?utf-8?B?Z2t6NWtuc3RCZ28waVNFZllZL0lzMWNPMFBQdEpobW5iMmhoM3p4Vk9XbWY3?=
 =?utf-8?B?cTVLWTBDb2JBSXNMdjZ1RW5remdGVmdGQUR5Uld4c2w0Z2gwdm1SYzVSb0p1?=
 =?utf-8?B?bklFdEx3K25CK004NXJZa21VNkRCWlJpREYrWk1IUEt2bExHWmtHTGtlWnF4?=
 =?utf-8?B?bjc1S25rdHpRK3gzamFJQ21lcjllbUdTTWRROHdxR29zeHc4bUxMdngyQUlF?=
 =?utf-8?B?Z2oxZU9LYWtSbVM2dXJpeDFTRG0vUUd0b092K3UvMnJlYnhlM2tmME5wbU9x?=
 =?utf-8?B?UzNyNkJrc1BLV0hUcmdpc2V6bEVUdDNleUNrb0czOGhPZlEwNC9pdnJqN04v?=
 =?utf-8?B?RU4zd0ZzOEhJRGhLQ3cvZUwxUEpEVzBvTG5uVmJ6d3A2LzltVm5mbW5rQXd6?=
 =?utf-8?B?aWxueE4wQVE4OXdVOThNSnZrWU5ZZUhmUFpXamtuWUZ4UFlONUU0aVI2Q0xj?=
 =?utf-8?B?K0dDZ3MvSFhUTEhBbmpORGw2V3UrWm43aklvVThLOWJEbHl0VkFSb0xHNThC?=
 =?utf-8?B?OTFZbzA1ZWo3bmF0U09rcnk3TDZYT3Q3cEg0T29kV2FsT1c1WjBJV3U1RHBF?=
 =?utf-8?B?akR2b0tGRzcvSUlrMWhNcTFPZ2dFWUFVbTRvNjVNS3p3Rklhb0dNUEM0cURk?=
 =?utf-8?B?cjQ5YUVmbTdDS3k4NlFWTUNSUWFXa0E4NHlnOTZiRlR0b2Y3KzJwdHZtNVkr?=
 =?utf-8?B?Q3V0MHg3d3JqNStBUldDNDd2MFo5czluY2NRMDh3eEc0NVFrZHJITGN2WGxE?=
 =?utf-8?B?U2MwWHI4akhzMGlpak9yMDN2YysxU2p0TVIzMlprVjEydnlrdGpRd1Jja0ti?=
 =?utf-8?B?Ly9WazllRTZSMTdGTjltU1NpdkdZR2g2WjZzOWFPZlRQMjVkdkszODVrWEhs?=
 =?utf-8?B?NFdZM0tsQ2E2aGIwcXoxeTZCVGRMOXcyWDVGeG5SUDIrSWFtM2cyZjB1MkVF?=
 =?utf-8?B?eTBoSkpzSFU3SkVBdG1Yc0IyTWJIYk1yMmlreHE0KzV5bEVnRUJNbUo5c3lD?=
 =?utf-8?B?OVVhZUJoeFVJcVBzZmExRi9lY2p6WXkwNEdlenV5cS8zdDJ0eEtMM0p1TkhV?=
 =?utf-8?B?b21Cd0JUbWxPSmVZMGlMZzRjcWdCNTRXck5rcnZGV2FGYmd0akNuOFZXdUVK?=
 =?utf-8?B?aUtGTWV0cHhYbkdwTkgxRHhoRHJ2TmJtVEZhRkc3b0VCUVh4dkdqZytsUHk3?=
 =?utf-8?B?dlV1Z1puZGFzU1A3VjNlRjQxYjZJa3IxdlF6bGN2VFRJbVFnb21lV2F5aFJa?=
 =?utf-8?B?cDJZNzNaUythSUN6bGRTRkx0V3Q3akFidzF4VklVWEp0b1p5K3AzUGNoQk9p?=
 =?utf-8?B?MTdsU2FqUmpUM05kbVpxWkRWc25XbEhkeGV4a1ZzQVdNdmRrUGV4UUorV3M3?=
 =?utf-8?B?dTFpS1hYMzFBMGF3RGN3cHlYMnJ5ZUJSbEtiSEgxYUdraWR4N05aNC9kQ1RX?=
 =?utf-8?B?WjB6dGVzbmdGQ2xoZkphUTN3ZkhJRHFBcjAyS1FNU1dvNnF1SC8zUlBTUGRS?=
 =?utf-8?B?a053eGpMS1k0L05nQ3lsejRDVlJ6eFV6QjVLQTE3anljSmxOeElueGMzdTJj?=
 =?utf-8?B?SmZMUXJ1a2VvKzJWZkxKK0VzbHlDVEdOYkdtc3N1emFFcmRkVGRlTnVmQjlp?=
 =?utf-8?B?TnNBR1N6eHQrc2NWcnF6NnFYcVlzRVEyNm43SXk3ZWdIcjBGUzBqTmQ5TFky?=
 =?utf-8?B?RjJRMWhPeDIrN0VibDEzWkRDQ1dRUy9TRGV2RU84d09wV0poeHBlSzU2K2Yx?=
 =?utf-8?B?cG5uTU5iU1lXb1czd1R6bVc0SkVpSEx5dndYNUpqUy84ZmhQdS8yWkZ6WFJn?=
 =?utf-8?B?WnVmdFBzaFQ5MW5FOVNIaEQyR2gvSXFCTHNFR0ZubUdSRzdpZ3BadE53UGJv?=
 =?utf-8?Q?HUUmNH4tODw=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dUZkQytCVUFxZThwbGNFQjM3RFE5K2l4UHFJMk02cXZNYjlGRDA3ald6b2Fm?=
 =?utf-8?B?c29QNDRhaS9YOGtJeTFpWElPQXd0Y1ArZTlTcXM5V0xyb0tvdVN0ZE9Yd2c5?=
 =?utf-8?B?THpCZU5ZT2svZFZxdTV1UUg5aHByR0dWdUxmU1BoR3I4NWtWcUdVZGFyOVY1?=
 =?utf-8?B?cXhqcDlPMnJ2bkIwYmpEZUR6amdDL2hhOGZDQUlvUWYwWmlNTjg5enpSQTQr?=
 =?utf-8?B?ZXJkdXN0cm1uWlA3ek9CUE16L3lHZDNzUHJ5TUo5aG9GM2hUcUxodDNOLzZJ?=
 =?utf-8?B?MXlEWHFvdnd0TUJIUTI4QnV6R2tLWVVzOTZNT3BJcDg2OGpBNFRBaWFHM0Zi?=
 =?utf-8?B?NGJCQmNFbHB1dkplcU5pUGJVUno3OTJoQlFVbEVBVVUvYnpMZlNrZmhoOVE3?=
 =?utf-8?B?eUlGcG01SzFyaDN5Mk1DSVRveVVRQWVpSmtyeG5BTHlTbUk2bm9sNzZWWm5F?=
 =?utf-8?B?ZGs3MEI0aEFyQW1VY0I3VHZ0bUlQMVgweFhDNk9yTW1BT2RVN2R2ak1tSHNw?=
 =?utf-8?B?cHhBRlpGV2laVFcrYkhnTlpqVmdDbm5WN1VXMkthYTFVLzUrTnhUMjdQRnFl?=
 =?utf-8?B?QXB1c1Fvb2tmLzlVNVR0NitrK1cxOEJsV3NVbVZiUDkvbjJXU0dKcVg2M2R1?=
 =?utf-8?B?MFNDcktXcDNDcW9NbXIzNk1UaXBwQmErR3g5M0hGVlpHdU5kN1hGNXZ6UUsz?=
 =?utf-8?B?TUVpYW5HbkxtZnZJMWVSZGJHK0hZbTRnUkJYd09PUEZsVjdSV2Y1Z0RiYmpu?=
 =?utf-8?B?TlREdzF6dEZxNXpPSkMwWHdGM2tKc1RxUU9kR2ExeElkY2dRa1VYSXpvOENy?=
 =?utf-8?B?NDA1NFhjQzladmpZRHl3NE5HdmhpUmhSY0laTXNvcE5XQkhmQjkrVFgzNEho?=
 =?utf-8?B?QWNteFVyQzdlNGFGYVdjMEZkRjlaajFKSlRyekpaMU90WXhvZE10ZUVNRVQ3?=
 =?utf-8?B?TmlpaDJsejY0UlovVUh5RVNYRGErSmVSUFQ4TE1wVUNWa25iZUNlbkMyYzFh?=
 =?utf-8?B?OFdSN2VYVDRTZkNMTnd1MkxMMFJqeEtia0YzenBsMldwY1hSeThRSUZHMDIz?=
 =?utf-8?B?OFZnRDA4bVJGd0ZweDF5amdNa1RqREI5WXhrSHA3VEV4ZDNMK1VEUDJ1UlRq?=
 =?utf-8?B?eXZaMjk0aml3dmdjcU90dUl0SGxiVGI2ay8rWC9BcjgxaTF0T0Y0RTA0U2pp?=
 =?utf-8?B?S2g0emtrOTFJVmd5WkNWNTNzYmg4Tm5iVFRZS2t0eHptcDk1dGNJcUZUKzg0?=
 =?utf-8?B?ZCtRVWNZZk4xQmxTbkNvQVlOZUFaa1VyMk9ZMEl5aFA4bDgxK1l3TGk0cExF?=
 =?utf-8?B?ZkpCb1I3TkRxNVd3aWRzdUM1bE9SYlowdU5nQnU5Ti93Q0NhYzNEREpqMlRM?=
 =?utf-8?B?dUd0MjRUeG9KSmRNTktjbzQvZDE5WkZDS2lFRXAxYmpCVUdBMkl5L2JKRDhE?=
 =?utf-8?B?dzl1OHhkZ2hXUnM4VWwyNDRaTWIzakdGSjB0YjJBdnR4dUNTbFc1SnNibXlM?=
 =?utf-8?B?RURTdjVyeFpnUXAyKy96ZUhqSk9qS0lvSXNuZEFyWHlHMlp4SDd1ZWJ2YkE3?=
 =?utf-8?B?NUZOdStHY0IrVWg4ZWJxRVI1MzB1dldUYWIrMkJUcEtYWGNmSGJ1S2xiQWdj?=
 =?utf-8?B?cFZKRDBFTFVEMUpXWTQyY3RzU1RhN0dST0pqZUkzUDgzNW1rMmI0djZ4QWph?=
 =?utf-8?B?WUpaTWtud1RFSWw2VVdmUnNoQmduS3hDRFdBbDZzUTBiQmZqUG1KTGg4YlV3?=
 =?utf-8?B?TzZwS0cydWhZU1phQkhSdVpwc0FvYSsyVmtheDhZZ0g1ZlFkRlltTDVFZ0lj?=
 =?utf-8?B?VDVDQUZLMGJpQ2JMM0hBMndmSFIxaVoxeXFLbHA1ZkNoQ3ppRjBWam5KVkdn?=
 =?utf-8?B?YkxhemRob2ZKdkcxS2hCVVpWREd3K1R6cmw3ckFxcHpQenZQWGh1NEMvRTlV?=
 =?utf-8?B?eXI3YWdJTmlyVW1EWnBqM3F2cWdtREdqVzlKNDNxSzgzbXo4d2ZqRVJCT0J5?=
 =?utf-8?B?M0Y5VTA1S25xTmFWcWZ1YTBBbWU2UHBNUEF6cDBkczVqZ0x4cEVRdnJrVFhL?=
 =?utf-8?B?QUFjZFNERUF3dHdPc1gzYkJqZityb3hqYUQxQ3J4czFiWnA4WlJISE9DQ0Uz?=
 =?utf-8?Q?BfDGTeCHx1U7cn2rxhidyw+yb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	s8X4vAC5hgnceMc4QxDk6hhuYqXBfSurnCSmkw5P8DdsLilb97rFXtvENicl6gpg1Hm9uQtq40+h6/ExJgU6v91lTMNwf0OUXde7XfCwVSQiNWelB5XgtFCf2Cp80iHWz5uqqYIHN4ggcyOYzE2K0/IK9dTz4RSAslmktyDfGMeW6OZSrxT/dFrY0hsYymM6qgMso5WNu07Jb1uOP0L6vGavk9yih42WQbysThW2bIkzYPDoU7BWypoTRs1CIINFCiOKtRlelewJsTqadNNl8p8+s1sSESMiw1xh1q2nHnIkgQXq/uyJhX256QL7SymhAluU9N1Ei7Me6DHxIKS8TgNyHPpCIiYPiOFtGMncX1aLRBacnImEDLdWn5htdncSbPmO5UQCuO6e82iM6kmSmaa9mPiZlMb0QcXYViStZlzxJ0mPDRW56vZRzh+gImpkfwKYaPoX5/vcXv6LVF9VbY7U5r2vUQuuGqIayziS3tt1ScTjsiXeBZ/FVOUizmvG+EPNv20pwjxnx+Fe7m5zqYJFoD+CceivJaO+ObUZxtJTxiz2Z6ncie4GlzKmpjqHiYvfGDDrq4naNo1xJUC1WFcrMUuHHjArZ3Yk7gPyxek=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08eb37a5-4710-402e-1df5-08ddaaaca32f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 19:01:00.7452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/C57qt4jtvWIL0cuiUPe4jJV1p1iilfTgxcZqMw4BZZ7cmwnvf+EFdFYBWVj65fgzFjHYHmMcR9HFuh80wYKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6463
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-13_02,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506130133
X-Authority-Analysis: v=2.4 cv=K4AiHzWI c=1 sm=1 tr=0 ts=684c7572 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=UpNhk4-cxdjpWeIAhHQA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13206
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDEzMyBTYWx0ZWRfXy7Ln4MfF5TKY H14lYVVhPzUBnzVrBAzKNyxNZzH0dQDHOXK+YmW8gRKRadxD013C5ygK5Hi1CF2I1ei2ZXQQPYW naLALmftROr5vl2XZAiXfGXfNwWkkAlIc2MHBdO2vNmTDKZuYpAUsvoLtB8uylBEYYBw/D8kP+n
 NkJ0ugi6y7VyL8WYdmXJTO1QS5gHOa5qy5k0mxr8iwTt/Wvwjx/8sDffjopcR6ZOfvk+rpiCtzC BN1URjE0nPm2QOOdAeTe58kz2dQzOLqHbme5VVK0EZ4BJZPGN/tOdkPJs5d00KVF5p4YFYeqj2R jnF8X77d9CRlWNZgOsWt+s8FsxmOoKxqcI7Y/rnqN1hhLriWBisMUvv92RLKX/xfL4IISkkZ9zD
 fUcIo4qklkT0L709DtrNsLlXiMyo87NeWmM+4gXR5b4VCknSWY8labJI0gaezSlxWK5nS50A
X-Proofpoint-ORIG-GUID: LkXDDH8nySPWPpBHmi1QvHuqkeg2fX89
X-Proofpoint-GUID: LkXDDH8nySPWPpBHmi1QvHuqkeg2fX89

On 6/13/25 2:57 PM, Mike Snitzer wrote:
> On Thu, Jun 12, 2025 at 11:57:59AM -0400, Jeff Layton wrote:
>> On Tue, 2025-05-27 at 20:12 -0400, Jeff Layton wrote:
>>> The old nfsdfs interface for starting a server with multiple pools
>>> handles the special case of a single entry array passed down from
>>> userland by distributing the threads over every NUMA node.
>>>
>>> The netlink control interface however constructs an array of length
>>> nfsd_nrpools() and fills any unprovided slots with 0's. This behavior
>>> defeats the special casing that the old interface relies on.
>>>
>>> Change nfsd_nl_threads_set_doit() to pass down the array from userland
>>> as-is.
>>>
>>> Fixes: 7f5c330b2620 ("nfsd: allow passing in array of thread counts via netlink")
>>> Reported-by: Mike Snitzer <snitzer@kernel.org>
>>> Closes: https://lore.kernel.org/linux-nfs/aDC-ftnzhJAlwqwh@kernel.org/
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>>  fs/nfsd/nfsctl.c | 5 ++---
>>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>>> index ac265d6fde35df4e02b955050f5b0ef22e6e519c..22101e08c3e80350668e94c395058bc228b08e64 100644
>>> --- a/fs/nfsd/nfsctl.c
>>> +++ b/fs/nfsd/nfsctl.c
>>> @@ -1611,7 +1611,7 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
>>>   */
>>>  int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
>>>  {
>>> -	int *nthreads, count = 0, nrpools, i, ret = -EOPNOTSUPP, rem;
>>> +	int *nthreads, nrpools = 0, i, ret = -EOPNOTSUPP, rem;
>>>  	struct net *net = genl_info_net(info);
>>>  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>>>  	const struct nlattr *attr;
>>> @@ -1623,12 +1623,11 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
>>>  	/* count number of SERVER_THREADS values */
>>>  	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
>>>  		if (nla_type(attr) == NFSD_A_SERVER_THREADS)
>>> -			count++;
>>> +			nrpools++;
>>>  	}
>>>  
>>>  	mutex_lock(&nfsd_mutex);
>>>  
>>> -	nrpools = max(count, nfsd_nrpools(net));
>>>  	nthreads = kcalloc(nrpools, sizeof(int), GFP_KERNEL);
>>>  	if (!nthreads) {
>>>  		ret = -ENOMEM;
>>
>> I noticed that this didn't go in to the recent merge window.
>>
>> This patch fixes a rather nasty regression when you try to start the
>> server on a NUMA-capable box. It all looks like it works, but some RPCs
>> get silently dropped on the floor (if they happen to be received into a
>> node with no threads). It took me a while to track down the problem
>> after Mike reported it.
>>
>> Can we go ahead and pull this in and send it to stable?
>>
>> Also, did this patch fix the problem for you, Mike?
> 
> Hi Jeff,
> 
> I saw your other mail asking the same, figured it best to reply to this
> thread with the patch.
> 
> YES, I just verified this patch fixes the issue I reported.  I didn't
> think I was critical path for confirming the fix, and since I had
> worked around it (by downgrading nfs-utils from EL10's 2.8.2 to EL9's
> 2.5.4 it wasn't a super quick thing for me to test.. it became
> out-of-sight-out-of-mind...
> 
> BTW, Chuck, I think the reason there aren't many/any reports (even
> with RHEL10 or Fedora users) is that the user needs to:
> 1) have a NUMA system
> 2) explicitly change sunrpc's default for pool_mode from global to pernode.

Not a very common thing to do, IME.


> Anyway:
> 
> Tested-by: Mike Snitzer <snitzer@kernel.org>

Tag applied, thanks.


-- 
Chuck Lever

