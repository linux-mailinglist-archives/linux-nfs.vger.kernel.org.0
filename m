Return-Path: <linux-nfs+bounces-20270-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOFLCmkAvGmurAIAu9opvQ
	(envelope-from <linux-nfs+bounces-20270-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 14:55:53 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2932CC43E
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 14:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CE3F3114880
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 13:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDB13A6B9A;
	Thu, 19 Mar 2026 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hthTt+pb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fxqsRfSx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820B42C11D1;
	Thu, 19 Mar 2026 13:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773928480; cv=fail; b=T59oLIkIyIB0JQXHwVDKeBIFDjz0bJBrLeSACkSYBEqsuSv/ou/QXIq6AzRdjjbVNZIecz9Ti7RcO9AzQGj/Q76jIKjMiYAfdd0je6yq7XzoiRbYs/t6Rj7q6aeLWSY876udtDSVGW/SZsn9jnU6+F++kDP7XlrjXpjXvFNu7Mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773928480; c=relaxed/simple;
	bh=O5iFSPhw60RGvBV9W4HGtHeyRg7oSq6ONXDogUZlOFg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YVax26ICDayUXJb+xaX0nH0LDlhh5hn24HHv6YykM6n5/mYRTvggLRGxZXc1CDkeT0rrAXd06jEXBjSaV9bpEnwnzFbZT5hVD7hyJ4SvVWE7MyDlEej3K8Odbax9hjEukwZLKtM85GEO52cUBrtOw9cLhtY9C963hSHrGbIM1No=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hthTt+pb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fxqsRfSx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J4saCh3940264;
	Thu, 19 Mar 2026 13:54:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=c1ZVBGJX1MXZFM1nSyH4sFv7BvtrpU7REhaVOHuRBSk=; b=
	hthTt+pbKoEiXbqOpW+mGgcezH/fpWCTluyCx/Z5ktAOPOQR/uzibTYRL1xy7q00
	MAxx8+iz88pISux5cOgBmNh4kVM3CcxwMLrJuUgQcZr7CO1LHe3WF+EpqIVgtUmo
	7lMyZQA4xX73KAAPWgJEqYrQ24K0EaSQWUu5ALhNNSxSoGeRXX5rJ6HROETp56ls
	C9CWQav6uFD1hGaoReWrvtEoufnsLB85ZinQChnBc+GXXdhDK145R+0p6CfbZq5j
	GPg80bJ62+YTNo8Zqsq0zNh1PK0nf7pQy/8daqM5ZGyQbVDk/O3ck9Kmf8u03dXR
	I74EV4TDIbpshez8ay+f2A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cw07rfyrs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 13:54:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62JDT3K9018020;
	Thu, 19 Mar 2026 13:54:21 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010001.outbound.protection.outlook.com [52.101.201.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4qhr8h-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 13:54:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pLlXmg3XlZo8JX9hSojkyqgHKvqwfMoGu3ByFnlNWwAETJS8wc1ex5d5l9B4Qb3z8qDuvDGFUaGeU7cK/nJT+H1N9G2W02SdEIJBGdrowXdz6/p2B1MaR20hac8F4BeBFM7lj6vFZtMFo1BKIJWfqQ3l8Aubgkpe8imdJVqB7pH0k6iQPiNdBMhaG1QGvhf/lHo7nQJDOj69Of9fuHX10AI3NiJ67YRyfYcMX0SOnUpdgVzcn9N3AMZUwraKWpLLN/7p82L10QJ7TOxtoEEOnGPZRX+HCTQawxjxPdecPHNLOP4pwU6dlGIKbgTT30beVzR7mqUHhV54ojSAeAhN6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1ZVBGJX1MXZFM1nSyH4sFv7BvtrpU7REhaVOHuRBSk=;
 b=y5tuUD2jcJHfBGYOFqePsMxmhyKddg2ni9YyXBWEYyEsdKXTnD5OwB3mUc++5IhFihHh/0ChxeGV6gNnRsIXY2lphwdlX8ZBKw5Bgp78x14IcRXr1OkkKt3oOFrR8Gjo7vuyvB9IogEUFWbh39uvKmQQP6HqI5cMfL/GNb0ZhEL6dFWLkpn2DjmtuDc8zd+c7UP5Jg9YVRgKxOcolOwZsW5gQNFYsniB1N68T6Rg4g45Z/tQsEJztS6n3Dfdx3JHAsJyqQ37ju+5YAxT2BTDoIJVj8JeZvfY86sc1i57rCPOaMwH7Sop5xEDdvjcEQIDp87k/IXnMk4KoBP/SCAWOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1ZVBGJX1MXZFM1nSyH4sFv7BvtrpU7REhaVOHuRBSk=;
 b=fxqsRfSxgYM/GLTrAsg9ESo+Dd+zC9fpv3pGP8UI5jbMK3VnM2mXEd8hCYMGdCvk+HxoxxW1C0nDED9ptRkcOIqswwf/r0PcbCU7bVcdoQcKISEM8CQyj60vP/Eal7VJRgGLMoeUnWyDHStUI5W6qZusntB4ceW89z7HoKX0t0U=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6462.namprd10.prod.outlook.com (2603:10b6:303:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.20; Thu, 19 Mar
 2026 13:54:18 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%4]) with mapi id 15.20.9723.019; Thu, 19 Mar 2026
 13:54:18 +0000
Message-ID: <ceec5140-f6d6-492a-b891-e1a578ff6144@oracle.com>
Date: Thu, 19 Mar 2026 09:54:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/14] sunrpc: rename cache_pipe_upcall() to
 cache_do_upcall()
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260316-exportd-netlink-v1-0-6125dc62b955@kernel.org>
 <20260316-exportd-netlink-v1-4-6125dc62b955@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20260316-exportd-netlink-v1-4-6125dc62b955@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR08CA0027.namprd08.prod.outlook.com
 (2603:10b6:610:5a::37) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW4PR10MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fdef84a-1455-449a-69f9-08de85bf03a9
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info:
 kf4fk2602N85nusp+aIMRsTuJYVl3StCf+tCNwPUfN/dQv6leVnIDz3i5EobIZJVr8BJWYxPNtiqBcfRK5Q/b8UKNRsRoBX8EGed15YVjH8OCej8l7mJPMMvl/igBSReJ2wbDmyB9FYJsBFpUx1mh18k0mZD7lKO9PCTV0PMzu+5+T96hFuE99388e1QOXQNTLS038p9Sv+scXocGGCvuqNi8whruzfv7x/fTByxWjrA/ifAZfle2lvc305kFIV4Mbn3t3pUIJWrmICp1WyFzgfFoOo6JeESv18Mss2+PLbiTVhNZvHfEdd21wwbCHhXywRj0rytSNKe8UvkVUDGmF3TWjgAhK+Xui+OgFGkTYWyTgrF7XFsXwCuifOJuemcEDPibSAWnQutU18vBYY7IO8jklYjyAoVfnbHaYQjZ4aqCeAXvK2LGKFzts8pLjuZdf7mtNjC6+63yb95z9mt8X46zBxfwzN4zsFGj1EjjVQdN2XvgqBiAXQV8kPqlBFYlboZ1wSyjYIQjpbPWIxgAkcQ8c26OlLET2xVNBdkiYpLSWs7O6xha26aHYEEBmlQt21ouoxGghi4E+7si0d0gIMu3z66jmPAIqtMVFKC1syzW5aE8ua3ZLJxEszsbrchRCXJtmBCLRl0/KBbOofzuBRoGpiW8EkehO6pJOJhvS6FCe5M6GXDVt90ra1Zktt/t8dBFUouS3+IJKTZDF5juooes+MegMm5MynoF3l8F7s=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?cjB2aVJJbXF1c05IZGd5OFFwS0pRSkRUUmJtK0ZVMUVVcmw3ZUc5cW9IOXdy?=
 =?utf-8?B?WFdQcTNEbXhxNGxhWU5xS2pzL0FiWkRGQjBqWG1FM0dGSGxSejhyZXFoTWRt?=
 =?utf-8?B?cVZqa05iZDdZbmJnbS9JSFJpWDZxL3BaamErNmkwUnE2bVJKUEVuTEVXaEd5?=
 =?utf-8?B?Z3RXekMzeVdBVWI2Mjhvak81VTdLZWNXNnJOWWt5R2I3YUluVW55WURieXNv?=
 =?utf-8?B?bklRMlR5VGt6cVJHUmE3YjNZb3ZWdkFTa3JqT0dGcTNMNE1mV2ZzWDEra1cy?=
 =?utf-8?B?cFdmdWFJdkxUTnlDQnV5MUtPSllYcXNJTTd4M29NUDN0UFdqNWdKV2lCV0Vp?=
 =?utf-8?B?dVNNSTdENXpoQjNYb2o5YWFyRE9yL3duUHAxSWl5MzhYT3VxT1B2d1ZnZGIr?=
 =?utf-8?B?S3RQMzk4VlgwTWRqdW04TTQrUzJmZHZ4QytZbkxIdmc3anBYV043enJIeTBG?=
 =?utf-8?B?TG1mTTJtaGNsNSt5VTJZZXFJUHF5d0JxWndlY1lZL2ViN0FEalB6NzdodGNL?=
 =?utf-8?B?QVRPeFdWN1NCSGttQ25xT3MyaUdUb2g4QW5hRU9wUzRZNldkdW1NdlorbGRr?=
 =?utf-8?B?QTEzVUllQ0JDYVFaVkNVKzIweDRMcEF2dlJJQzB0aTFObHhQckNnU3JFdTht?=
 =?utf-8?B?eXFvMnFPNlZYUzhoN1RvTlNnQ3YxYkM3Sm9TL0J0ODkvMVdZU2FyMU5oT2J5?=
 =?utf-8?B?Ull4S2hrU29wT3RKT0UrVndjamswOEh4VlFDQjBTbU5tLzBQNVZqTXFkSkwx?=
 =?utf-8?B?L0pTSkVhbU9xdmtYMlYrSmNzQjBjTWVlMlpNYy90SkJWZWFqMVErbmV5L2VC?=
 =?utf-8?B?cDVBazVjK0hXUzdBUTNUVGh6dHZDckNiK0UzZVpWQ2xTY09VUUJYSURkN0FY?=
 =?utf-8?B?K1hDKzMvUmJGcGRua2pLTE14dFBCcGROaVB5ckhBWWZhL3NxTTFkNTluUHdw?=
 =?utf-8?B?TGorZEJuLzRUN3B2eXFzMVFFRkc2M2tzeEdkdDBpK3FodlNOMUo5djQ0bWFN?=
 =?utf-8?B?SmRrRFJkajRqRDFxSVpkdERtbmN5VDc5UUpYbkRGbzNLWk5iWUVsZmxJZlR2?=
 =?utf-8?B?cEZnQmF4ZlpaZk9lczNoOVc4MEpiQmd2R1FaL25ZODBUZ1FWVkJvcjVjdkRV?=
 =?utf-8?B?NVVzeVJkNFRZUDNWL0ZZQTJMdFJaZXFFQjA2QlhXcU91Z2NTWS84Y1hrQlBI?=
 =?utf-8?B?RFZxQ25YQmFxTitZU0w2UVkwaDlkSnU3ZExBZ2RzZkNBcDJZU1l4L1dza250?=
 =?utf-8?B?NngwLzBNczFwTUQ5OVBpRUVMQVNMRk14bmV6NEJhRTlOOFkxdjZpVFVsWm1O?=
 =?utf-8?B?V2I3WUVXbm84VDk1SnFkd0drRFh6TjhVaFNRMk43SnVwMC96R2RhdFFVV2d0?=
 =?utf-8?B?RS9ERXZHMm5OMnlWanZaeU9JMTlPa0NVbFJYT2FuaVM1cHFObjhqbWcwSXlt?=
 =?utf-8?B?V3lkcXFUNjZJaUZKZGNCQUdwaEpyUW80bkZQQnlVaDRkQWUwL3RjRUVPYzM2?=
 =?utf-8?B?Y2M2cktVOTVrV05vQjRmUHVYYXJ5YzhkV1N2R2dNOTdPbjlXVWlubVlSK1pI?=
 =?utf-8?B?U0NzSHIrS2lZUkdhbCszalpuYnVVQ3NIV09RSDd0NW03K0lMWXZFaVd1UnBL?=
 =?utf-8?B?SmtEWFJzeFVEbXVMUzNaZHRjOHlGMnBJNmRQcFh2Y1JZckp3VXJoaXM5V3U5?=
 =?utf-8?B?V0hVb05tRUtsMDRZQk5uM3BJQnozWmdtZ29xQkhHeGh2TUhNY2lOY1dFeVhJ?=
 =?utf-8?B?ZGhhMjNtcDNKOE9Wb2pNcjYxZlFUeUcxMU1hSUlyNlQ2RWZ1TzBQcHFUQytN?=
 =?utf-8?B?T3lxeEF3T01ydEt1dWpaNEN2cTB5OHRDZllQZmtlbWpsZzd3MDFoVjZ3aDls?=
 =?utf-8?B?SFdMc2MxeVVsODNGNGg5WjdTSGNIQWF3VkIrMGFtWEkybXlIOEZCS0tCeXJh?=
 =?utf-8?B?MGZFaHVhRWFaSklJS1NhbURzazQrVjFvNnJ3S3JYQW15QXEyWEtPUTB2Tnd1?=
 =?utf-8?B?d2Zib1VUaGdmUHVPR2trcDgyaVVRcllQcUVlZzVlengzeUxvNkdoZ3JzQU9Z?=
 =?utf-8?B?Szd6OTExalY4TU5tREx0b1BxNW9vay9CL3ZOaUtOQzhXMjZaM1NCTGpPS3NQ?=
 =?utf-8?B?Qy8vSmZNL1dVRTRaNStLYStRcFlSU3dHYlE4VWRxQ1Nxc25ydnNXY0E5R1FX?=
 =?utf-8?B?MXdhWE4rbXZ2QzhtL2d2bUJOS3Bsb3djYmc3NUNZWi9CbTV5b3lXSWVaU0lO?=
 =?utf-8?B?eEk2OFJ5bTZ3RlJjajZaUm9ZaHdkVTJFQitVMDRVRE1rY3ZVSXptRDh2UEpN?=
 =?utf-8?B?TzdLUDBkOElxcXY1YWxNUkVKRG1tOVh3dTVjOEtRcXZ0eEErTW53QT09?=
X-Exchange-RoutingPolicyChecked:
	QyGnSannz/uOI6zFZYnMu2E7IpxY5lu2U7MnQKuA4L9NIcSq61Eu058uwdXevvx9lb7G+K5EfU82ZkliIMiFMHZqJgoXijX6PvluAyeq8biYQsnycxVo6VbON0jiAVQv789DB8I/bq6B+JE5Dk/3rpgEEQXeIrj0Tq3HHOZWnkmLD3Vv82UCftg0m5DV3HE7mANr+mGqQUiiNLBgbnwxFULg4YceB7OWysGofGvAgtISQqfSaIWzRO4pJ3VpQppOutKov2C84Ok0NxxkQg7OgqQNiJ/gOzMRASkWnITvJeKNl5+jzglV91OQkBq02f3bGL/4uTig9oxBa972t3pFqg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ALw67rfAxYk8Ch0paWUf7BpEaVZK2fQYfLb5iceWRD8Ppuxiy9LJkXO3ghuf3z906hGzlhrcv/qji9oHQh3EZ9x3O5OEmFmuQClQgUlqdJUhPruFi/p1hd0334hKLcdT9BuR/KT3yh4i4YvMtV4jlqyKK/tCSkJdwbWphyS18S1jjm9y53Zm9YjZHiRCa+sLb/6rs+dTJIhUwl8ahiESRJ0giPW61Tda6gNlTnusdzld2Gxq0n73bM67OWz8SO+4GVuNPP84CV4zoUt2v6AbIJkn7DGul56VNAEsOZFyfD13w4n88i1y1a0EZWDnxPMgOBsHpI8OzDEbdqPoGQfn0KEhij2HzGB0tcmkRmVnw6FPri1iECqhaKuN6kIBUlJdMxqkQ1BDWD+Bova64wmS2evnUHgh9vJYxFxfIBVj36ogow5ygmF73ieZKNBn0Iskjpz0A15liMcD1hBrqqFFus1PdboH2n3P8DpxYkRMdCn11HUQSp9T5oFAQFJDLk+K1HNEVG0XNfVhMFfG6DHvan6gSQxCIL2Ne3FVakBWNcymQZVMBwaCiZ17Fhi+Sw8OC09eIFkRRrKxmaW+3rB4qyeed4XrmmpU5KzcgP0TBfo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fdef84a-1455-449a-69f9-08de85bf03a9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 13:54:18.1378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qg5BzpB6L4VaxxbdHn0nGF9GTbMjsD0yNTVUvj9b/kmH5cmSI+AmtSyZt6QFsCji1GHZ1SV6BbD1X4350eDoQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6462
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2603190109
X-Authority-Analysis: v=2.4 cv=HcsZjyE8 c=1 sm=1 tr=0 ts=69bc000f b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=VwQbUJbxAAAA:8
 a=8sJ4i5SfTlaYIkHbzPgA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12273
X-Proofpoint-ORIG-GUID: UYvpl6lZoulVklJVQRcF8fJNCQcfn0Hk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDEwOSBTYWx0ZWRfXyhN0A6Re4wTB
 ig+Kc83Qux6f8VdCM3MEC+teKIjn7NoJ3/+19A11APzHIGO5GZPcko3PKkH2JhLPx8WMIZFsNug
 JTNMJM8d0ZdeDAcT/z1iMO4QHIl1W8XrAkhr3ro8muC24nsoI8L6ShtmJzsfcZU8Qyt4W6FXDz0
 RwbjjCPjD3xUYupR58FF8Y19bNdPoJQChWhvM6ZaNw9RtXd+l9SFuwjD2xETqvKBPp4Om1B9e55
 /mbj6VtuRI3ePvQC7JBgShaBDUTMe0zJ++x18RczCrTAz0+mmcA8Qw4nPlh7TpOrHZqgYprpaFQ
 el3wxnyPP3mxMskflY6/WNUe/FKuoouRMxkIFl7PwZzqdNI7H3s69p7tMFl1upAmFSyAFzHlJx/
 FWViPTIJwlP/BcclZaUp4kYviqYEZyh85nbKxaF2W2DJKd0L8tv/qtdGA0TsIdf96kLgn9U7oKJ
 /zhufLJIrYWXNWaP6azKuSznCcSpWskpF1q7znGY=
X-Proofpoint-GUID: UYvpl6lZoulVklJVQRcF8fJNCQcfn0Hk
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20270-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:dkim,oracle.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chuck.lever@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7C2932CC43E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/16/26 11:14 AM, Jeff Layton wrote:
> ...since it will also handle netlink upcalls.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  net/sunrpc/cache.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
> index 5e36f6404400aea5700d0893c00b6d69c1ec128e..7081b6e0e9090d2ba7da68c1f36b4c170fb228cb 100644
> --- a/net/sunrpc/cache.c
> +++ b/net/sunrpc/cache.c
> @@ -1206,7 +1206,7 @@ static bool cache_listeners_exist(struct cache_detail *detail)
>   *
>   * Each request is at most one page long.
>   */
> -static int cache_pipe_upcall(struct cache_detail *detail, struct cache_head *h)
> +static int cache_do_upcall(struct cache_detail *detail, struct cache_head *h)
>  {
>  	char *buf;
>  	struct cache_request *crq;

Nit: The block comment just above still reads "queue it up for read() by
the upcall daemon", which is will be made stale (or at least a little
misleading) later in the series.


> @@ -1251,7 +1251,7 @@ int sunrpc_cache_upcall(struct cache_detail *detail, struct cache_head *h)
>  {
>  	if (test_and_set_bit(CACHE_PENDING, &h->flags))
>  		return 0;
> -	return cache_pipe_upcall(detail, h);
> +	return cache_do_upcall(detail, h);
>  }
>  EXPORT_SYMBOL_GPL(sunrpc_cache_upcall);
>  
> 


-- 
Chuck Lever

