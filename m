Return-Path: <linux-nfs+bounces-12902-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5567AF983B
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jul 2025 18:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67FB91C20B75
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jul 2025 16:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703D72F8C31;
	Fri,  4 Jul 2025 16:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i9L0iNtq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x/4fgjEl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9DA2F8C2B;
	Fri,  4 Jul 2025 16:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751646624; cv=fail; b=JuzW6OPvx8yQqCBbm6ycC1lpVDLP8cDllG4mAtRh2HW7l+X+u8fcFlhJJBhA89o8bTgX7Po6cHV3Z/gjvDhTlYxJF7u3Spg7o3NhL6bmNLwAqbxblqYsyzdKW6+t/n9h4ZsD5Z6THmNB4tihrYQFvdLAPgy9ukQ3vwj8iRxO9Aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751646624; c=relaxed/simple;
	bh=YvI+lPlsYZozGK8BBIcnROS0qWkGLce/s+AvlcElfCs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FEoLhFyVo9FooIyRxAcUOqeUx88/HZun33MIh1sQXBfylWM0DNAaSXfx04fIBK5d11dKCElRg3QGssfdBHmbG0sx7jkWWTRO0h2383x/l0DtmifotII1KYdfHMbLJFdHroIHrz4aaTVY6eL3ycwy3rNYFKHWNJ4gRYnaUZmCffw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i9L0iNtq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=x/4fgjEl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5649Ywxo005828;
	Fri, 4 Jul 2025 16:30:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6Kt8NGNVTbAFl2bhmcp2DNyY7BhaXOVTZ7W0cIse/C8=; b=
	i9L0iNtqp8I7Pc/r9OYLSefsPZZKEQpA9lrPW+MI7EgebtxZhTsdHo8ZuVQfH8UX
	lEiTSzgna5ewS57QkfcELWrvv1zAIuYhNPa83coBxgC3MWlLVJGIy/Fh9+mj568b
	QR7dNpNvDTQzYTIeWbU57dkTZfkG0GWY8tsmKTJHGtPIAz09CBncgjt6LmMRhtrN
	mPj/QlxdzewZIGTViOLX5J1WtFZ0NDP5/PgUIcmCvXgIs763ht+LKdZrKp2P0MFn
	r8ME3d1f5Xr0kB8fuHuxY/Xn2DFGIVb97WY2F2vmro088VcndHfLY7uJjkNCqOzP
	MXSHm6srvkgz2Bd/MLmFTg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j766k31g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Jul 2025 16:30:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 564FYERT018778;
	Fri, 4 Jul 2025 16:30:05 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6udy2d6-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Jul 2025 16:30:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PLPrPsnQQPPuF857NpGM+ILfm35vOqdWx1Wh0L4gfLqSfITvq89V5hxMJoNbzTi45dIB+ubcm8jffFPIAkG4IQ3X5S+BsHnVV93e72QqPXi7Q7H3qIFmjBxGNSfz3gquxmH3j9TArq08jVxXcA9fptAYWptn1nQGMg+G7P0d7fVgGukvir8Mo1guNXPckcy99xljdMUgTWKUbuMp/ntweCpigxNdoKdg35PmB0XW+FycMrHDCbVXcLgCnpaibrNR+LZEclAShiC1CT3QVGINiKYBBWmRy9IUxBfTUTfQkEN8fh9mM/+Onw6AT/RUXG0EGj7BC+ZYUT+BwgNCGHgrLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Kt8NGNVTbAFl2bhmcp2DNyY7BhaXOVTZ7W0cIse/C8=;
 b=ch55Q4rmQ6gHJYj7o93IGYT0q1h+OxVDo5byBEtOWD2szwQkjSK73qxIAw0g16uYwckVONjTmgD1tdwBN2pH6OWzEoReN4HMuifQYfNWa9VqDYXjOy+B30sQ9ggPR8zXxeILB5nW98IkZRz0nZVT09Hcd5PBG/pYyoZTt4hLSArgYWRSSjtiqtluUWqJ4C/MGRdOhI19HoYAqM0ramOmSpnOhf7L8hOP9QG7NHdGFqKXP/ChwuIi+PT3YSAQeivjEilNed+QLg+8bqMNtgoATXyv5Jfx+iQlKLWYc6K7IUiaQr9uIekvmJjll4yWBqS3B0j3t3Gal7DDN+BH1ZVTng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Kt8NGNVTbAFl2bhmcp2DNyY7BhaXOVTZ7W0cIse/C8=;
 b=x/4fgjEllwSx6/ljgNYAmHV1cXFxMy99nUuzA49iI0ht8wx99GAHC6+mNgSEiN7vOuYpPW6mz0STx3rjajbeRuhHM7zni0xsaJmBX2XVnPnTkgBPg8eMkfDCR+R47sj6il9DbGDr8SYvMcMNXSVjfcP1a8LDYIk6qKVz/CQ+rqw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB4856.namprd10.prod.outlook.com (2603:10b6:408:12b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Fri, 4 Jul
 2025 16:30:01 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8901.021; Fri, 4 Jul 2025
 16:30:00 +0000
Message-ID: <f1fdddde-2450-4a2c-a1e8-ee6a3ff81090@oracle.com>
Date: Fri, 4 Jul 2025 12:29:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] NFSD: Fix last write offset handling in layoutcommit
To: Sergey Bashirov <sergeybashirov@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konstantin Evtushenko <koevtushenko@yandex.com>
References: <20250704114917.18551-1-sergeybashirov@gmail.com>
 <20250704114917.18551-3-sergeybashirov@gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250704114917.18551-3-sergeybashirov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0240.namprd03.prod.outlook.com
 (2603:10b6:610:e7::35) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BN0PR10MB4856:EE_
X-MS-Office365-Filtering-Correlation-Id: 118d4d96-24e6-4557-507c-08ddbb1805b9
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?RWVHY3dVOUtTM3ZNWFd1cytNT3dnWVlnUlRuV0RyUHNCL2hDTVZIWElJSDQ0?=
 =?utf-8?B?ZnUzK1cyUzJ2NG9tcmNJd21JVHBFeTUzN3lqeXoxWjBtWjJOaS9SYkxKTWQ0?=
 =?utf-8?B?cE1QY2N6NmpvbzAxak93S2ZiMC9MN1NOVlRHcWpielBkOVArNW15cDkwZHlQ?=
 =?utf-8?B?MTJIYnZxT3hlRE1tYlFWYkdLcGlIaXlZT2oxSjhRaGpWYlFVWGhZeTJGRUo4?=
 =?utf-8?B?T1ZNUmVCTHRuQzF2eVRaYkc3OE1UbXVHMExnTmYvdHh6Q2RLY0VTVHEvMlJi?=
 =?utf-8?B?QmFqbUxsSHpSNjlWWnJmMi9lcmlVWFlxOXhaZGF6eWxHaUkwRmQvYXY5N1Z4?=
 =?utf-8?B?ZWJGOTJHSFYzSTdkYU1nQmlsOFo1ZmZpMStVMUd0Q2owc09LRmEwcWdEZGlh?=
 =?utf-8?B?MHBFRlNaVGF6VFpzVXc1bXh3VWluVWw2REZyZnJveXpSZzNRMk5jZVZQMjNM?=
 =?utf-8?B?dVhPeUtNN2k0c3V5QTZEYkpyVUZDTG9vRjF0SjJaN0lvZm1pMVQ3TllndVNU?=
 =?utf-8?B?cUh2WldKQkRIRHA5eUpEVFZCNU51QTR6MTd5RWpNbnR2ZXpoNDdtMTZFSzZv?=
 =?utf-8?B?WnZGZnJWS3BLTXVZbkQyTlRNNVR4ZWRmN01OcnFjNGgwK2pIUlhxTk84S0la?=
 =?utf-8?B?SjJTT29tT2ZQbGR5Vjh5RFFWNFV0alAxOU1KZlVVU0NmeGtjUXRQbDdrREo1?=
 =?utf-8?B?TmJKbGxhNDY0ajhQci9PY1M2bHBoNEpEb0I5K1NaT0Zwd0NqbEVMSk10WWd3?=
 =?utf-8?B?TlB2RWJOUU8wdDIybUR5MGcwZVIzRUhtQ2I0amVPNHNYVzhGRWgySDNQRXNO?=
 =?utf-8?B?WnZsaWc1NUx4MCtFUmZuUGFySlBUdk9hMFJoYlJ1ZlRMUy9uL0ZtUE02WDFX?=
 =?utf-8?B?VEovS2JueUZMbkhaS0thdVJxdnRuc1ZBMUp2Wk12aXlxNHpaaTN6NkxMUHVO?=
 =?utf-8?B?aEJnNEphZy9QZ3Q1QkVtdUpvOE1CTzluS3gxeUJNa1hIV1V1YXA3ZDRSbE1t?=
 =?utf-8?B?RHo5YnRzTWsrUTZUVy80bGo0VnhQNHdrYlFoR3NiWEcxSGN5eGpRblRWYzh0?=
 =?utf-8?B?YmIxaUxma3hWQk93TGo5aXZoeWdZMko4RXpqb2tNRklNdGd2bDN0VHc4OXpp?=
 =?utf-8?B?THlKYUdYRkZZTkVyeFhGR09GaHBzamlUZnlsSVVsakVYdHBNdmNnUm50azQx?=
 =?utf-8?B?ZDB2N2s1Y09jOWdEV1FsTXdvcXM3RCtCbVZJQzRQRFRZVU9WZFJRc0JXZnZI?=
 =?utf-8?B?V3dTQ2pBSjdkbHdqMHVMUzFOTmZDajdhUVpZSEtISTlGN0hmYUNrb1RVMmp0?=
 =?utf-8?B?S3E1RVFwYmgzZmlsRUp3aEFlWXE2OGM1c2xnbjVoM255VlI4MlIwdXZuMWZ0?=
 =?utf-8?B?WHhob3lWVHR4Mk1GOUdLNXBBa1dndWIrUWxpSzFHWFM4c25RQnFjeHJaZlBI?=
 =?utf-8?B?SklQR05SVFdsVFhUZE5VRDVyRU9pRGgrVml2b3R5cXkyQ3puNktGUE02YzRi?=
 =?utf-8?B?NFErL1FydWxyazBBSXlvNXp5VCtNRHlKTkZLOFN6OTUvaXhVcHl4ekJmL1g1?=
 =?utf-8?B?VFdmWWlKbStmbXZRLzk0UFNiKytUWEdwMisxUDdKRHRVbjlqRzY2Z212VDJp?=
 =?utf-8?B?NkU3SHZuYStlcW9LS0NUcE41MzJKTWlQSjkveDNxT2tjeHZRWXphUlpDVGRw?=
 =?utf-8?B?SnZZWDFoWjY5V0luVWNlYSs5OThHMEYvYTk3MTZ6Tml4cmR0VnlRbDVTdVdW?=
 =?utf-8?B?RENyK2tvQlVEWTFRSUMxeTJCeXJvVm55c3BqYitGVTlDcTQ4M3B6cHo1aUpE?=
 =?utf-8?B?V2RFK0x6cE8xQ29JSVJvdjllc0dEVnNHaDFUOUw2TUs2TU1ZczhhZncyMzdi?=
 =?utf-8?B?cDE3UkZ6TXpOaDYrTWgxOXMvc2F0eTRZZWlsMTU5V3dKSkw5UW9nSHpUeThL?=
 =?utf-8?Q?IIBWC1GFGss=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dHRUdjZJVnhpVjRtS2N6Y00wdm9IeWtNL2lES3BZVElMa0ZHSTBHalUwNFJz?=
 =?utf-8?B?OU14U2NKVHpUd25NKzhINkxWVWtxT2xqZDZkTkNZTFZoa3ltY3ZBOXlFaHRB?=
 =?utf-8?B?Nnpva1VVUVc4TXFkNmJMTUFvbEh1QWl6QmM5LzBRZlc0dko4RVlibVZFa1Rk?=
 =?utf-8?B?UXBHMHFGQnZua3hKazEybVpSK3dqR3ZyZlFwcmo2djdxTDZzOWl4bHYvYlVP?=
 =?utf-8?B?MFQ4YWRzOXBub3FpTDRhYUNTUXZ5K0NLNHRMbDY5OFVzMEZFNU5HOWxqcU1a?=
 =?utf-8?B?bWU0VkhqbHV0b0N3Um5ORlBneWtOdmRoSU01U2lBSkp0MFhseFJwRlpqS1gy?=
 =?utf-8?B?K21TNnBXbXM4UTU2cVBHdzVaSzVHNkQrU1Y5aVFINzhDZGVoVjlKZk9YbXls?=
 =?utf-8?B?M1VLTkN6VTRMZ01UYWpGTVJBRDQyY1o1bGdscmpYc2oyK1VkZm9CQ0VxZWEr?=
 =?utf-8?B?ajBrTnNvUDRNUzZsL0hUV1oyaFJDQjF0bC9mc21oTTF2czBJczZ3TFhZZHBk?=
 =?utf-8?B?ckdGaFlQbWl4MW5KTWVMZHRsZkFxTFRxaW9JaTZTNEtLWTJ6N3FxU3B3UGxa?=
 =?utf-8?B?L2hxVVNiZ3VSOHJTVzFaWEF4OHJmR3c5dXlpUjhFbjJuMHFDQ0ZsQm9yQ2E1?=
 =?utf-8?B?V1UxeGdETUFPRkE0TVZwb29Kd0FZa3c2cjJPeUVhVzdwUGJVRUpHbjZXOHFx?=
 =?utf-8?B?MjhlZ2ZKWm03MUk5bzNEL1BSOGpNeHIrckVDUTJiQmYzZE1xV0J5bzlJTHZv?=
 =?utf-8?B?TTlnZ0ZyS1lIL21hY011WWVTTzRHTXh0YXd3R1RRem1RVFdra2poeFcwV2Fw?=
 =?utf-8?B?bExHYXkwTzBSYXpnUGJpTDUrOExjVFIwNGQ2bDNLY3B3VzRlVVJPZG5OeUlL?=
 =?utf-8?B?Mk9XenBubTV5enVUYlIxRVNqb2JWSjlJNHBITHE2N3NEdVNmeXZYdHh3NDJT?=
 =?utf-8?B?T2xFeWI1UW5Xd3ZJTk5RTTNPeGlQOVpjb2xKT3NhVXczUjhacis4R3crclR3?=
 =?utf-8?B?b0dxVzczdzNuOWk2aWxRNWxvVm1yQzVUZm9hSjRWVjcyV2pXSzBNcS9GZEx3?=
 =?utf-8?B?MllsTHl5a0JYWXZ3VjExQnVZbUNtQVZ0bGV1R2lCUDRwTi9kQUhnOUs1R3dI?=
 =?utf-8?B?dlZGVjZPSnBJeVhWUHh5OGIvNVdYbW92MlJiYk9PQTNMbUdabnNrTnFkQmJH?=
 =?utf-8?B?STJFblFMSzhoclBaZGpGeTByQ1lWaEljR0JnZ3dFRFNZcnJCMGsrZjZQVGl3?=
 =?utf-8?B?MGZiVi9UN1JMV0xWUCtVdTg4T1NxMlRFaERSS2NSQTA3djd6bE1YSEF6TGFj?=
 =?utf-8?B?a1lMaUhiZXEvZkdrZVdsVmNGZUZqejFFdzgrenJQYjhzTXFFbW5KbDBOcTlj?=
 =?utf-8?B?ckhrSDJYUWludmc0REpaOUJ3QW5qZk8rU0V5OHhMaS9OcWh0YnlYZjdYekhh?=
 =?utf-8?B?aG1HYUFuZ25CTlpRakFZT2xHYU41UGZZRm1MWXFNY0t6Rk9ZNit6NklXdUhQ?=
 =?utf-8?B?WjR2ajVlSzdXRFZaSngzeXBHNHRvZDVuVVFTaXl1TVhQSm1jZi80K1FDZDRh?=
 =?utf-8?B?U2xBK3FiMEc5S29MK2ZJODlYR0FDamRHWEtsY2o5Z3o3QnFGQzUzbmVEWnNr?=
 =?utf-8?B?TTh5VDhoOEtSdFhBdjk4TUNpdWtWYWRpTmk1VzJ1VHlQa2g0N1dGc1dQNlRR?=
 =?utf-8?B?QW1jcXFoN2V1WUt2NTBZMXhVTTh1YjNINVVvV3pRQjRvM0Y4ZFd3NXRaM2Fa?=
 =?utf-8?B?R2hDbkROemM3Zm1nTCtJMWQxbUdLeTlyRWErNTEzTy8vSXhHelU1MVJUOEEy?=
 =?utf-8?B?QndnOUtoM0NzbU1MbnlqSGZxOVRpRnYwNDBmZ2o4ZVJxOGsrMmNuRUlpOFA2?=
 =?utf-8?B?VExxTTFocW1TeFQ1bGN4Zy9PUytyTjgxMWxEdGVLWnliUlBGMC83TGZBNG1X?=
 =?utf-8?B?R05DaFRjY0grOEJnc2trRGFKbjk5WUVHNjl3ajlPZE56eStuU0JaRVpUNUJu?=
 =?utf-8?B?Nm5qazJXY0ZmVzhrR25tb3hjZ1JrNVoyN2k2bnNIVVcwOEZyZjZqUHlzQ2Nq?=
 =?utf-8?B?bHBtY01tSUlBRGRBK3VjeUQ1WXpzUjRtN1QweUE3MmVRU2pOMVo2M0hJdTg0?=
 =?utf-8?Q?7RdHxzsbhL/JjcwnMFsot84Ll?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Z9dEQF1eqCM2lIiAM+HrvmKAKEsUHj3CebqOs4mcvqXD4Un8POBD46xizpWDo6cxqfx40+ONrvhG/PVR8V1SWLQPLeINWQ4O6ldtqr7PfsUqNuAorDPbnOu5PRnqejhSkHcirUb21Jn9nG/nH4+0HyhxBke3uoDXdbxGXTZHuUvxepMuYOYkAp3VtkRJYjVCOMn+uUEXiUJLOVv92YcFil8K9XP/c8i66CZ8iLs0aXMxqPP03T8kwwYv0TXKuAqxZ/YkvLTYKEkl/xJ28LsUeNBmFG2PftaohvHYvCE+WsptNJVIUoJdpcalmY1NhNMOLEVllHw+cuaXtm7XrSQw7wCqGw/7x1xnTIGKV/lF3Ug5hiMsYh2ml5Q8eRK/Izvw9Yl6TFIm3QjZoKABKGSsiSMoECOapAJCPnJLZ1t0zY41iMydeprrrl1x22N+VZ44RVdSc3P72k+ZuumxNbDW4AncHPhHrys7XpAjcEOiiIG9Cf8TybphUhtrxQ+oG6TIipXleYDdhFAhw3oSS/lyYfQUmAjruPqBiVmChGN66VZamYUsqFxuGHgA4rMLlwjjqPtOe7/fvtVpqg+G5xhVSLNs6iaZWbz4wDIvTh4/GUI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 118d4d96-24e6-4557-507c-08ddbb1805b9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 16:30:00.9472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZyPegu9rb1efMwEagOT+/fWMWIUR9KBVfpzglw275SkR8v20zGyj+Nq4zL7jcvkjRYuqWKFqm/SgLKwm6T+3Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4856
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_06,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507040125
X-Proofpoint-GUID: PM-KhBWghPkCeGjvcA_hB9Be9nR5Nmr7
X-Proofpoint-ORIG-GUID: PM-KhBWghPkCeGjvcA_hB9Be9nR5Nmr7
X-Authority-Analysis: v=2.4 cv=b82y4sGx c=1 sm=1 tr=0 ts=6868018e cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=BMxJXzqDAAAA:8 a=pGLkceISAAAA:8 a=IPBwpHiv9wLurQja0jQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEyNCBTYWx0ZWRfX38wD8bW/FXHv j8X6eF3UYBYzWWCRXihmDfTrXpeIcdAS01Z2/AKD/mcJkgqXhIkPDqiIstP5He6onr1fxX23WwN q7frOCi3dTW4wxVPaq1X3UOU0MqDGufuG0GwA59FwlQsrEQ7RyH1JHhkjwC900+aBbmh6L/+uoY
 12gVzboork0NAHvRa8OZnnLg2nf/YyLexOMPkjxnNsUhnQHBlb0NmterR9L0q5Lw17R7o1cVoUN b4AZoFysaF+OKUWhl3LpzzAFsXd3971K9JAVXgRzSOcznqw880auHyIsTtmofmn8nD7YRr1/OIp tTKZmvK/AL5XWLXrzEtne0uVYJAJGrQSlzhbUDfTwM0GAXfqK2rkpMd80KsKgROM0pYm4/EZq/I
 YaBqMj/ynYIm7L6owaTZeSCX6RssfZUzOFHcG/q1WTQZWzVSR0orkqN2pEv/ESGvJM4XY49m

Hi Sergey, Konstantin -


On 7/4/25 7:49 AM, Sergey Bashirov wrote:
> The data type of loca_last_write_offset is newoffset4 and is switched
> on a boolean value, no_newoffset, that indicates if a previous write
> occurred or not. If no_newoffset is FALSE, an offset is not given.
> This means that client does not try to update the file size. Thus,
> server should not try to calculate new file size and check if it fits
> into the seg range.

The patch description should describe the impact of the current
incorrect logic -- does it result in file corruption, failed tests, etc?
That way support engineers at distributions can more easily find this
patch if a customer runs across bad behavior.

Also, let's reference RFC 8881 Section 12.5.4.2, where the properly
compliant behavior is specified.

Fixes: 9cf514ccfacb ("nfsd: implement pNFS operations")


> Co-developed-by: Konstantin Evtushenko <koevtushenko@yandex.com>
> Signed-off-by: Konstantin Evtushenko <koevtushenko@yandex.com>
> Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
> ---
>  fs/nfsd/blocklayout.c |  2 +-
>  fs/nfsd/nfs4proc.c    | 16 ++++++++--------
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
> index 19078a043e85..ee6544bdc045 100644
> --- a/fs/nfsd/blocklayout.c
> +++ b/fs/nfsd/blocklayout.c
> @@ -118,7 +118,7 @@ nfsd4_block_commit_blocks(struct inode *inode, struct nfsd4_layoutcommit *lcp,
>  		struct iomap *iomaps, int nr_iomaps)
>  {
>  	struct timespec64 mtime = inode_get_mtime(inode);
> -	loff_t new_size = lcp->lc_last_wr + 1;
> +	loff_t new_size = (lcp->lc_newoffset) ? lcp->lc_last_wr + 1 : 0;
>  	struct iattr iattr = { .ia_valid = 0 };
>  	int error;

See below for an alternative.


> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 37bdb937a0ae..ff38be803d8b 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2482,7 +2482,7 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
>  	const struct nfsd4_layout_seg *seg = &lcp->lc_seg;
>  	struct svc_fh *current_fh = &cstate->current_fh;
>  	const struct nfsd4_layout_ops *ops;
> -	loff_t new_size = lcp->lc_last_wr + 1;
> +	loff_t new_size = (lcp->lc_newoffset) ? lcp->lc_last_wr + 1 : 0;
>   	struct inode *inode;
>  	struct nfs4_layout_stateid *ls;
>  	__be32 nfserr;
> @@ -2498,13 +2498,13 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
>  		goto out;
>  	inode = d_inode(current_fh->fh_dentry);
>  

How about instead, drop the new_size initializer above, and do this:

	lcp->lc_size_chg = false;
	if (lcp->lc_newoffset) {
		loff_t new_size = lcp->lc_last_wr + 1;

		nfserr = nfserr_inval;
		if (new_size <= seg->offset)
			goto out;
		if (new_size > seg->offset + seg->length)
			goto out;
		if (new_size > i_size_read(inode)) {
			lcp->lc_size_chg = true;
			lcp->lc_newsize = new_size;
		}
	}


> -	nfserr = nfserr_inval;
> -	if (new_size <= seg->offset)
> -		goto out;
> -	if (new_size > seg->offset + seg->length)
> -		goto out;
> -	if (!lcp->lc_newoffset && new_size > i_size_read(inode))
> -		goto out;
> +	if (new_size) {
> +		nfserr = nfserr_inval;
> +		if (new_size <= seg->offset)
> +			goto out;
> +		if (new_size > seg->offset + seg->length)
> +			goto out;
> +	}
>  
>  	nfserr = nfsd4_preprocess_layout_stateid(rqstp, cstate, &lcp->lc_sid,
>  						false, lcp->lc_layout_type,

And lastly:

-	if (new_size > i_size_read(inode)) {
-		lcp->lc_size_chg = true;
-		lcp->lc_newsize = new_size;
-	} else {
-		lcp->lc_size_chg = false;
-	}




Also, I notice that nfsd4_decode_layoutcommit() has:

        if (xdr_stream_decode_bool(argp->xdr, &lcp->lc_reclaim) < 0)
                return nfserr_bad_xdr;

but:

        if (xdr_stream_decode_u32(argp->xdr, &lcp->lc_newoffset) < 0)
                return nfserr_bad_xdr;

The no_newoffset field should be decoded with xdr_stream_decode_bool too
(though the end result is the same). For just this nit, please make a
separate patch. Thanks!

-- 
Chuck Lever

