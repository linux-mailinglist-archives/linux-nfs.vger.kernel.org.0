Return-Path: <linux-nfs+bounces-8383-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C47729E6835
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 08:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 803F5283F8B
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 07:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F12D1DB95E;
	Fri,  6 Dec 2024 07:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Kh/92qzH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2136.outbound.protection.outlook.com [40.107.223.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12F51DB94F
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 07:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733471338; cv=fail; b=b3nzEd2umxt6JAYMLJ2E2YZPFN52LSt00cCzCyJDRiC9qqACRnng9Ns/cwIVU6I1xYJPDQjqG58nTyOKb24KZds8YzTM9WRrEUZPvlh0UaPspY6i8sNNch4t9kSqZz/ST20UU/nsyWcxs/+ftt9G8MX5V4LFnR7OQbQxbHxMOHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733471338; c=relaxed/simple;
	bh=ahmsy1iLLqO890T9jo4jl+cbd1nKChY1BqATYTwurM8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iOVev6ykAZcHvHfwmZ8tB5UHz6k+ooB5GdloM3X17O73pSm0UC2OGRxUbXC4n/jPYKOeGosw2aNR/TQDvRdli+ULKcsfOWzDkjp9Gv/o1S9q5fZ6TKlYubGH4UfqDfu3QgAxEuqPw5kB2kYV3vhaN7Uwbbgbs9rqEvDIJrv2TZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Kh/92qzH; arc=fail smtp.client-ip=40.107.223.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QtwJZArnMRn+wJnH5cC45DN4GO6c58etWWmtx9agy0iFwcab914qKAzc1Mwr6454ILg6+n6Ixm1zV2yJJssg8ZiohCJ413jdEKIj4fdc4sZE40BBtDbqWuE0YnHfV62noNzZqrwIQqy/TK1v62K9GTWhJq+eEVHhTKcC+4fHgnd6HZ0I/79WuyFdgynaBfODKzqkFaEo+gBEY7YHZsPgimweO694Uf3DE+YD73Bfru0HZRwgA33kM711LJHDQhEZLQd8uxrIlb1OmfzVd4OWBuPsNMmVSy2KSvaFANpBrlrIvupF7oAOM91fD1WD30p1k3UKPM0PWAuu3Yuvlvg5fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahmsy1iLLqO890T9jo4jl+cbd1nKChY1BqATYTwurM8=;
 b=QH8xpWzHtag1QS7WHyiH37kC6dYwFQPAHrU/zGWdF/+e+WR/bt9K/kEXqVPvRQQbtD/sHcUA6aQ+ihtytKeXwYN9imB/LZcBRygidO8ZfncQy36JSHdECAksXxC85/CD/FYin6XHlgvPwmchxGxitREhvURD50TEACVASQdasTj0HPVjjDbDPDE5rHxO5EtCEOBEp9vwpJL1g3GFliFzFPbhPcyNVbPAIxub2SU4aInFoEh0dUGfYN+shifq2KttDi49+P0cuHkuSvZVHEBeKwMnIUBCfNdrnuhytfeS0Jyub2XQqnBXSPZa0YtX9K1vA0Z5PDvaxePi95obBXBDdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahmsy1iLLqO890T9jo4jl+cbd1nKChY1BqATYTwurM8=;
 b=Kh/92qzHWb5ncwW07xaWY7/4KO6xIaEoBUHGtqPDMHF3P7hqStvsvUTJ51jhxZvaFhkoGvkrmpv5DP+V1clTVlUfFXG33nMr62izykpT5XLdcQUwwwR50s2ZdVZZKjD5nFxbUSrU7n8SRFhzgyiUKyoiAVCs8nQYVrCBijttDgQ=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MWHPR13MB7180.namprd13.prod.outlook.com (2603:10b6:303:282::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 07:48:53 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%5]) with mapi id 15.20.8207.020; Fri, 6 Dec 2024
 07:48:52 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "changxin.liu@lenovonetapp.com" <changxin.liu@lenovonetapp.com>,
	"anna@kernel.org" <anna@kernel.org>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfs: prevent out-of-bounds memory access in
 nfs4_xdr_dec_open and nfs4_xdr_dec_open_noattr
Thread-Topic: [PATCH] nfs: prevent out-of-bounds memory access in
 nfs4_xdr_dec_open and nfs4_xdr_dec_open_noattr
Thread-Index: AdtG8mhTxiE/djBQTsWqdZjdkxlDpAAAcsGgAC/EtgA=
Date: Fri, 6 Dec 2024 07:48:52 +0000
Message-ID: <0167f2a97a887b883e93f259116a7527120e04a8.camel@hammerspace.com>
References:
 <ZQ0PR01MB1031E3B5494478C1F7630AD8F830A@ZQ0PR01MB1031.CHNPR01.prod.partner.outlook.cn>
	 <ZQ0PR01MB1031BEFCC312865552969274F830A@ZQ0PR01MB1031.CHNPR01.prod.partner.outlook.cn>
In-Reply-To:
 <ZQ0PR01MB1031BEFCC312865552969274F830A@ZQ0PR01MB1031.CHNPR01.prod.partner.outlook.cn>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|MWHPR13MB7180:EE_
x-ms-office365-filtering-correlation-id: a2918333-6ab8-43e6-6f29-08dd15ca6ddb
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RWNhQ0xJb2hpclFydHFDOE5neVo3TXRTd05vK1pOSHQralo1NlZoQkRQWGxj?=
 =?utf-8?B?N0dHOFEyY1ovc2VEMXNQZzdiK0IyVDZldThneDA5NlR1RC9SQ1BFRGx3bnZ3?=
 =?utf-8?B?a0Z1Z2ZWak0velhyUXF0NTk0KzltL0FTSUQ5em1lZnR5Z2VaTXRqNzV1blR4?=
 =?utf-8?B?UmhOMFdiOTBXS3c1cmx0ZXlCbVR4b2xBK21LdU9MUEVtOUNwNDdJMjBuZmdZ?=
 =?utf-8?B?V2tzK3hWbUNPdVJhMVIxQkIxaWd2aERjTnJyLzZyWWxwbUVjTmlBWWR1Z1cz?=
 =?utf-8?B?Ymh3ZXRwSW53Um1rbjZpcERqcm1jWWhzaWFoVWJscTF6SUZPSWNabmwvdXgv?=
 =?utf-8?B?NFoxclZKMkVFUzZFdnNVaVB5cy9KdU9EcVhnb1RheklST05FR2oyeVpYWWM2?=
 =?utf-8?B?aExkc05OTDgwYXRiR0JmVURkTFpsV3E3RzhqQStoTXlPTlYrdjRqQmx3K3U3?=
 =?utf-8?B?K1QraXp3ak0wTnk4bnVuT3FpN2ZoMkkyY1g0UHY1U3VheTlNa2liaW5nczVn?=
 =?utf-8?B?WGlqUFFmQll4SThHd3dLWVNqNVR1MlpqMFhOYXlOSytqUFEvRzE4Z0w3bDFn?=
 =?utf-8?B?cGttWHd1ME5tb0JDTjRSRWVvZytPZ2tRRzgzNTJPOTRXSG1YejEzMWJsYXdZ?=
 =?utf-8?B?YnFubmFpS3dyOER0aDZvelRoR0g1dUZLUDJsaVNlbVM3ZklNbzMySEYvL1h6?=
 =?utf-8?B?eUx0S1ZRM2VCRUlxR2ovcFJyUHNYYi9zb0pRZVFCUXo2SkV3bUhCM2kzYUg2?=
 =?utf-8?B?bjF5Y2RERDV4L1BBU3h1eG92VXMvWUNoalhtUjR4b0IyZFFlQ1NIVXVNaHp0?=
 =?utf-8?B?K1FWeEhGaGd5WW5tNTUzZkdqS0thcGNwaExPeGtuTzR4UVFlUVBkNWZJNkYv?=
 =?utf-8?B?VkFTVmZTU3IwcDRFL2VhRmpGRU04elVhNTFtcE9Pb2dPdU9Ea3poTTRkNFBI?=
 =?utf-8?B?SVJKcHh5RlAySzBVR0RDeHRtMFdrdmVyOVR3L0F4Rk5pRWVQME9SZkZ1SC9a?=
 =?utf-8?B?aGN5Vk9YR05yR0s1L2pFUS9US3JBY0lkcWordzUwbWNrc2RGS0d4c1JudnpS?=
 =?utf-8?B?UFpiQzkvQ0JrWG9NdDErVUpHRTBnOTVRZjhrdVB5VW9UU21UUlpoelE5TmZT?=
 =?utf-8?B?ZFJhNmYvVHN4RFVXckxaZTR1VGNDaWtQdXU3MEE2N0p2WG5KdzRVeEJrMXBn?=
 =?utf-8?B?ZWI0Y3VMeGt2UU5RaVRyWUI5SkV0d0d6Ni9LN0RZc1JGbHUzVDRNc1VRMVE3?=
 =?utf-8?B?OFdDWHgzVS9XenJmYmNwbFZOMXR1c1JnZlBRdTgyQWZoYjF1LzhJZEp2Nk91?=
 =?utf-8?B?N0Y2bUZzeENPUDdUcmloWnRTUzVPWnUvTlBwYmxDTnhsRHJNTnNSa1FpTEY5?=
 =?utf-8?B?NTFjbk5VOEp6WHd6SFhhY3R2VS9KQllpLzNMYVkyZ2pqNTBEbXdkdG5XT21H?=
 =?utf-8?B?ajNreDdDY0xZWWU4NnFGdjdOV0E0a1VTY3ZGU0lNMDl4MTQvWHBBZUh5MDRC?=
 =?utf-8?B?TzNVNjJaR2t4NWtyK1UrZVhzQUM5M1dNQmNqVHg4QVJLUVlTMGJaWjdEMWsx?=
 =?utf-8?B?TnhEZDMwbEhSWHZUSTNIMFk3WVhJQkJJc01zUnBPYkNEUHhOMU96d2tyNnNL?=
 =?utf-8?B?UXc3anpPZHQ2OXVsQmZuekVPWkRZTzFkVXdYUDFHeGdMVmNwQXRNMDkyWW14?=
 =?utf-8?B?dVdjQXlYRDVFYnN5d0h0bXBvaWJWOFAzQjYySkZ3Q2ZmNW50YTNCQlhaSjZN?=
 =?utf-8?B?ZUNkRHZneFpsemVuTEJhQWZXTFcycUtQUlF3TndtZXB3SDUvYVo5TjVOVUhG?=
 =?utf-8?B?aTAyWDJncDBwUkhEc1NjMW1pTDBtZS9BRkhUNC9oZ3EvWVJpVzNQK1B5cUVl?=
 =?utf-8?B?bFU5b0Z6UDBBbmlWRnNFUk0xb1JFOG1ONnZwZU52Z1NoWnc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RHlNU1pHSXQrdW52SkNaNnV4eVhBVEp3MHZkcTRqNFZ5YkxHdmJLR0Z0MmJW?=
 =?utf-8?B?ZzR5OU5Qc2FCWm1JTUJsY0podVNOWVhuejM3MnhZbWl4YzU4OHBhU283a3Nm?=
 =?utf-8?B?azBrR1pnR2NycGFnejVWdWZ0VkJzQUZvbTUyR0hjM1NDQmhZSitqbGhva2RT?=
 =?utf-8?B?TGRVSDd3eUdmZFZjb2tCaVMxOTZGT3Y4WTJZcXlSamZySldkVHpFSG1tekJ2?=
 =?utf-8?B?cDZUVTl0Q3NMcWhBNFFORGFFayt3OTJBVmpYM0U2K29ITTdYZU9mV0Q2WlpX?=
 =?utf-8?B?MFBzcm11S2hrZXNqRy9qS29lZlNTQkkxTW8wK1luSGlHYkRjVnF5dVlHOHFR?=
 =?utf-8?B?c2xmM1QwVXNyYW15cUFvQ012R05VSTRMbjhraHZtNFhtd3MrUmdua0drRHJM?=
 =?utf-8?B?L2dlSTltam8vMVVGTzJSbGNVaW5zODlwWVRTWlBOZ0V6cVloRWJPaG8wZjZG?=
 =?utf-8?B?V0RuaEpGenEzRVJmSHQ2VE9kb0oxRFR2UlJaVDhTQUNIRmZkMjlnMytZenQ1?=
 =?utf-8?B?cmFnbE5FKzN3cGQ0RGpFTDFDNVdKTTVYSEJKeDBhNTVTTWVOZjFxQzJDYi9h?=
 =?utf-8?B?NGRwcUl0S1lsbWpFS3ZMeU5qblpCSk9HeDNVSjU1Zlc5YXV5bTZMV21Lc2pZ?=
 =?utf-8?B?Z2FBWXRhalk0LzlKVkNod3V5T0YyNkwxOFI5ZkRFZlp4V0ZWTFJ4ZXYvYWtO?=
 =?utf-8?B?NDRqSHFXUXExalhkbGhNQTR4anNkMzkvZDZTNmdWKzhoeFZpM1VJS1RKa2JU?=
 =?utf-8?B?ZHlhenNSRnVvRG0zYmRMOGhxSmdZRzdWN3ppajZ6UEZKSS92UDZqcHJSd1dJ?=
 =?utf-8?B?SWVobnhmemRhV1VhN1NPY01sM1MveDFYVUg3cHI3clRHQ09VMjBNemhyMEMx?=
 =?utf-8?B?dGJ3NTlnYm5KUGNkTUJyc044aEtXclpUTTRSSGxwSk1RSTBqSldnYXgrazVn?=
 =?utf-8?B?cm96MzVzTzdPR3RVc2xqcG9sQys5VzgyZDdsNHJPTmZkdFpVLzhJQ0tSWVpF?=
 =?utf-8?B?S0V0VnNaVjVJOC8zSWpLQU9EeWhsVHhrU0RtRWc4V2gzeENxaTd1am5CdnBQ?=
 =?utf-8?B?am5qWUUyWkE2bVpMOGVwNExseDJsdXVDR09EVTMxMi9Kd0pUbHBEVytqWmF6?=
 =?utf-8?B?Wng2MVdIaEFGcDk3R3N6RDRmR1dzcElCQWJnSEkzYXBDNjkyMVVJMjJpejVx?=
 =?utf-8?B?K1gzSU5xRFpoKzFLdTVmTmZHWXlFR0g3L2Y1ZkZPL3htemdHS0hhV2dGRTVR?=
 =?utf-8?B?elRLSGh6TTRZM1Z2dlFMVThBWDc0N0VmOGJXOFlDYUxUek9Wa1QvZm1tanRW?=
 =?utf-8?B?cURMSmhmZms2OFh2MFhlZmlyY3ZKakY1aGdtQ21FbmVGYWU4bnZaSEZnaUpt?=
 =?utf-8?B?ek1YdUpQenBmSW1vRGpFeU4rRGlyWEljSHVwUm9sa3lqL2FYWk9GaytMc1c2?=
 =?utf-8?B?NmRDK0NmajhwMHB3YWdFVGV4UEY5Njc3WFRrelRORlpKaUh0eGhFOTdSYjEy?=
 =?utf-8?B?TjBncEE1N3RnWWNBd1BSVHJFc0xqWGk2SGd5eVZNUllIU2J3OEhRNGtDd2oz?=
 =?utf-8?B?Z2J6OG5JUGkyYWxPcnV1SFI5RTRxZThob0dLVFNLd2xWdDljaHY0UVFid1ZN?=
 =?utf-8?B?V0twckd6VFZSeWdMYlJ2QjByWC8zRUVZYTVyRkRiUkRsMXZvWEpsbG5PeTE1?=
 =?utf-8?B?NldNaEMxQjBPR0srd3pURWwzQm9kTTArMmFNcHJLVk1ONVBBRXdCenU2aWVJ?=
 =?utf-8?B?NSt1OHBoWGdoWTdTMzRxdlhEYnQ3U1RzNkxCWkprWVdNWDRNUkR1UEJjK29P?=
 =?utf-8?B?bUwwb3AyN01Da3FyMkpCbHltcDNydUkzS2hNTXloaTIrK3hZSnRtemdSYkda?=
 =?utf-8?B?N3RoQnpJanBBTkQzaGVaY3RTK1lBREtEYVZXKzloYmE0SnhZeGlVU2pkT09V?=
 =?utf-8?B?SkpNUEg1NExBbFZPZ1UvQStpTUcvRlk1aFd4WkVEM3I5cEUrMEVsQkM1c3N0?=
 =?utf-8?B?bGJ3WFBLdUxCQitHQy9jeUZMTjh5a2p0TmpSeWNZMEpFV05qcGZYSUsrcXJ5?=
 =?utf-8?B?SGdvbXNTZmtiMW9Lc2o5NDNXQ3kwNUQzU0UxOFVlVkQzRmJRa3RhY0VUYWlI?=
 =?utf-8?B?U1lkQzBrdUs3T0t2Nzl5MS9ZMWZ5K0dlaE53WFhTMklwWExQaXN6MmZRemdX?=
 =?utf-8?B?TlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <166A0426D83E234E83C3ED3C03413ABD@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2918333-6ab8-43e6-6f29-08dd15ca6ddb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 07:48:52.7033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZXMcZq//GCw/eMxV1vxS+agpxP/5Sdy7nIfp4T3Zm+Rnoq4Uh09Qt7Zpf1QRmYcIbSCJip82FwaNQZPn7vSnFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR13MB7180

T24gVGh1LCAyMDI0LTEyLTA1IGF0IDA5OjEzICswMDAwLCBMaXUsDQpDaGFuZ3hpbjxjaGFuZ3hp
bi5saXVAbGVub3ZvbmV0YXBwLmNvbT4gd3JvdGU6DQo+IFtZb3UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVt
YWlsIGZyb20gY2hhbmd4aW4ubGl1QGxlbm92b25ldGFwcC5jb20uIExlYXJuDQo+IHdoeSB0aGlz
IGlzIGltcG9ydGFudCBhdA0KPiBodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRp
ZmljYXRpb27CoF0NCj4gDQo+IFRoZSBgbmZzNF94ZHJfZGVjX29wZW4oKWAgZnVuY3Rpb24gZG9l
cyBub3QgcHJvcGVybHkgY2hlY2sgdGhlIHJldHVybg0KPiBzdGF0dXMgb2YgdGhlIGBBQ0NFU1Ng
IG9wZXJhdGlvbi4gVGhpcyBvdmVyc2lnaHQgY2FuIHJlc3VsdCBpbg0KPiBvdXQtb2YtYm91bmRz
IG1lbW9yeSBhY2Nlc3Mgd2hlbiBkZWNvZGluZyBORlN2NCBjb21wb3VuZCByZXF1ZXN0cy4NCj4g
DQo+IEZvciBpbnN0YW5jZSwgaW4gYW4gTkZTdjQgY29tcG91bmQgcmVxdWVzdCBgezUsIFBVVEZI
LCBPUEVOLCBHRVRGSCwNCj4gQUNDRVNTLCBHRVRBVFRSfWAsIGlmIHRoZSBgQUNDRVNTYCBvcGVy
YXRpb24gKHN0ZXAgNCkgcmV0dXJucyBhbg0KPiBlcnJvciwNCj4gdGhlIGZ1bmN0aW9uIHByb2Nl
ZWRzIHRvIGRlY29kZSB0aGUgc3Vic2VxdWVudCBgR0VUQVRUUmAgb3BlcmF0aW9uDQo+IChzdGVw
IDUpIHdpdGhvdXQgdmFsaWRhdGluZyB0aGUgUlBDIGJ1ZmZlcidzIHN0YXRlLiBUaGlzIGNhbiBj
YXVzZSBhbg0KPiBSUEMgYnVmZmVyIG92ZXJmbG93LCB3aGljaCBsZWFkaW5nIHRvIGEgc3lzdGVt
IHBhbmljLiBUaGlzIGlzc3VlDQo+IGNhbiBiZSByZWxpYWJseSByZXByb2R1Y2VkIGJ5IHJ1bm5p
bmcgbXVsdGlwbGUgYGZzc3RyZXNzYCB0ZXN0cyBpbg0KPiB0aGUNCj4gc2FtZSBkaXJlY3Rvcnkg
ZXhwb3J0ZWQgYnkgdGhlIEdhbmVzaGEgTkZTIHNlcnZlci4NCj4gDQo+IFRoaXMgcGF0Y2ggaW50
cm9kdWNlcyBwcm9wZXIgZXJyb3IgaGFuZGxpbmcgZm9yIHRoZSBgQUNDRVNTYA0KPiBvcGVyYXRp
b24NCj4gaW4gYG5mczRfeGRyX2RlY19vcGVuKClgIGFuZCBgbmZzNF94ZHJfZGVjX29wZW5fbm9h
dHRyKClgLiBXaGVuIGFuDQo+IGVycm9yIGlzIGRldGVjdGVkLCB0aGUgZGVjb2RpbmcgcHJvY2Vz
cyBpcyB0ZXJtaW5hdGVkIGdyYWNlZnVsbHkgdG8NCj4gcHJldmVudCBmdXJ0aGVyIGJ1ZmZlciBj
b3JydXB0aW9uIGFuZCBlbnN1cmUgc3lzdGVtIHN0YWJpbGl0eS4NCj4gDQo+IMKgIzcgW2ZmZmZh
NDJiMTczMzdiYzBdIHBhZ2VfZmF1bHQgYXQgZmZmZmZmZmY5MDYwMTBmZQ0KPiDCoMKgwqAgW2V4
Y2VwdGlvbiBSSVA6IHhkcl9zZXRfcGFnZV9iYXNlKzYxXQ0KPiDCoMKgwqAgUklQOiBmZmZmZmZm
ZmMxMjE2NmRkwqAgUlNQOiBmZmZmYTQyYjE3MzM3Yzc4wqAgUkZMQUdTOiAwMDAxMDI0Ng0KPiDC
oMKgwqAgUkFYOiAwMDAwMDAwMDAwMDAwMDAwwqAgUkJYOiBmZmZmYTQyYjE3MzM3ZGI4wqAgUkNY
Og0KPiAwMDAwMDAwMDAwMDAwMDAwDQo+IMKgwqDCoCBSRFg6IDAwMDAwMDAwMDAwMDAwMDDCoCBS
U0k6IDAwMDAwMDAwMDAwMDAwMDDCoCBSREk6DQo+IGZmZmZhNDJiMTczMzdkYjgNCj4gwqDCoMKg
IFJCUDogMDAwMDAwMDAwMDAwMDAwMMKgwqAgUjg6IGZmZmY5MDQ5NDhiMGE2NTDCoMKgIFI5Og0K
PiAwMDAwMDAwMDAwMDAwMDAwDQo+IMKgwqDCoCBSMTA6IDgwODA4MDgwODA4MDgwODDCoCBSMTE6
IGZmZmY5MDRhYzNjNjhiZTTCoCBSMTI6DQo+IDAwMDAwMDAwMDAwMDAwMDkNCj4gwqDCoMKgIFIx
MzogZmZmZmE0MmIxNzMzN2RiOMKgIFIxNDogZmZmZjkwNGFhNmFlZTAwMMKgIFIxNToNCj4gZmZm
ZmZmZmZjMTFmN2Y1MA0KPiDCoMKgwqAgT1JJR19SQVg6IGZmZmZmZmZmZmZmZmZmZmbCoCBDUzog
MDAxMMKgIFNTOiAwMDE4DQo+IMKgIzggW2ZmZmZhNDJiMTczMzdjNzhdIHhkcl9zZXRfbmV4dF9i
dWZmZXIgYXQgZmZmZmZmZmZjMTIxN2IwYg0KPiBbc3VucnBjXQ0KPiDCoCM5IFtmZmZmYTQyYjE3
MzM3YzkwXSB4ZHJfaW5saW5lX2RlY29kZSBhdCBmZmZmZmZmZmMxMjE4MjU5IFtzdW5ycGNdDQo+
IMKgIzEwIFtmZmZmYTQyYjE3MzM3Y2I4XSBfX2RlY29kZV9vcF9oZHIgYXQgZmZmZmZmZmZjMTI4
ZDJjMiBbbmZzdjRdDQo+IMKgIzExIFtmZmZmYTQyYjE3MzM3Y2YwXSBkZWNvZGVfZ2V0ZmF0dHJf
Z2VuZXJpYy5jb25zdHByb3AuMTI0IGF0DQo+IGZmZmZmZmZmYzEyOTgwYTIgW25mc3Y0XQ0KPiDC
oCMxMiBbZmZmZmE0MmIxNzMzN2Q1OF0gbmZzNF94ZHJfZGVjX29wZW4gYXQgZmZmZmZmZmZjMTI5
ODM3NCBbbmZzdjRdDQo+IMKgIzEzIFtmZmZmYTQyYjE3MzM3ZGIwXSBjYWxsX2RlY29kZSBhdCBm
ZmZmZmZmZmMxMWY4MTQ0IFtzdW5ycGNdDQo+IMKgIzE0IFtmZmZmYTQyYjE3MzM3ZTI4XSBfX3Jw
Y19leGVjdXRlIGF0IGZmZmZmZmZmYzEyMDZhZDUgW3N1bnJwY10NCj4gwqAjMTUgW2ZmZmZhNDJi
MTczMzdlODBdIHJwY19hc3luY19zY2hlZHVsZSBhdCBmZmZmZmZmZmMxMjA2ZTM5DQo+IFtzdW5y
cGNdDQo+IMKgIzE2IFtmZmZmYTQyYjE3MzM3ZTk4XSBwcm9jZXNzX29uZV93b3JrIGF0IGZmZmZm
ZmZmOGZjZmUzOTcNCj4gwqAjMTcgW2ZmZmZhNDJiMTczMzdlZDhdIHdvcmtlcl90aHJlYWQgYXQg
ZmZmZmZmZmY4ZmNmZWE2MA0KPiDCoCMxOCBbZmZmZmE0MmIxNzMzN2YxMF0ga3RocmVhZCBhdCBm
ZmZmZmZmZjhmZDA0NDA2DQo+IMKgIzE5IFtmZmZmYTQyYjE3MzM3ZjUwXSByZXRfZnJvbV9mb3Jr
IGF0IGZmZmZmZmZmOTA2MDAyM2YNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IGNoYW5neGluLmxpdSA8
Y2hhbmd4aW4ubGl1QGxlbm92b25ldGFwcC5jb20+DQo+IC0tLQ0KPiDCoGZzL25mcy9uZnM0eGRy
LmMgfCAyNiArKysrKysrKysrKysrKysrKystLS0tLS0tLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAx
OCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL25m
cy9uZnM0eGRyLmMgYi9mcy9uZnMvbmZzNHhkci5jDQo+IGluZGV4IGU4YWMzZjYxNWY5My4uODE5
ZTNmZDc0ODdiIDEwMDY0NA0KPiAtLS0gYS9mcy9uZnMvbmZzNHhkci5jDQo+ICsrKyBiL2ZzL25m
cy9uZnM0eGRyLmMNCj4gQEAgLTY2MzcsMTEgKzY2MzcsMTYgQEAgc3RhdGljIGludCBuZnM0X3hk
cl9kZWNfb3BlbihzdHJ1Y3QgcnBjX3Jxc3QNCj4gKnJxc3RwLCBzdHJ1Y3QgeGRyX3N0cmVhbSAq
eGRyLA0KPiDCoMKgwqDCoMKgwqDCoCBzdGF0dXMgPSBkZWNvZGVfZ2V0ZmgoeGRyLCAmcmVzLT5m
aCk7DQo+IMKgwqDCoMKgwqDCoMKgIGlmIChzdGF0dXMpDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBnb3RvIG91dDsNCj4gLcKgwqDCoMKgwqDCoCBpZiAocmVzLT5hY2Nlc3NfcmVx
dWVzdCkNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGVjb2RlX2FjY2Vzcyh4ZHIs
ICZyZXMtPmFjY2Vzc19zdXBwb3J0ZWQsICZyZXMtDQo+ID5hY2Nlc3NfcmVzdWx0KTsNCj4gLcKg
wqDCoMKgwqDCoCBkZWNvZGVfZ2V0ZmF0dHIoeGRyLCByZXMtPmZfYXR0ciwgcmVzLT5zZXJ2ZXIp
Ow0KPiArwqDCoMKgwqDCoMKgIGlmIChyZXMtPmFjY2Vzc19yZXF1ZXN0KSB7DQo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0YXR1cyA9IGRlY29kZV9hY2Nlc3MoeGRyLCAmcmVzLT5h
Y2Nlc3Nfc3VwcG9ydGVkLA0KPiAmcmVzLT5hY2Nlc3NfcmVzdWx0KTsNCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgaWYgKHN0YXR1cykNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0Ow0KPiArwqDCoMKgwqDCoMKgIH0NCj4gK8Kg
wqDCoMKgwqDCoCBzdGF0dXMgPSBkZWNvZGVfZ2V0ZmF0dHIoeGRyLCByZXMtPmZfYXR0ciwgcmVz
LT5zZXJ2ZXIpOw0KPiArwqDCoMKgwqDCoMKgIGlmIChzdGF0dXMpDQo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0Ow0KPiDCoMKgwqDCoMKgwqDCoCBpZiAocmVzLT5sZ19y
ZXMpDQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRlY29kZV9sYXlvdXRnZXQoeGRy
LCBycXN0cCwgcmVzLT5sZ19yZXMpOw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBz
dGF0dXMgPSBkZWNvZGVfbGF5b3V0Z2V0KHhkciwgcnFzdHAsIHJlcy0+bGdfcmVzKTsNCj4gwqBv
dXQ6DQo+IMKgwqDCoMKgwqDCoMKgIHJldHVybiBzdGF0dXM7DQo+IMKgfQ0KPiBAQCAtNjY5MSwx
MSArNjY5NiwxNiBAQCBzdGF0aWMgaW50IG5mczRfeGRyX2RlY19vcGVuX25vYXR0cihzdHJ1Y3QN
Cj4gcnBjX3Jxc3QgKnJxc3RwLA0KPiDCoMKgwqDCoMKgwqDCoCBzdGF0dXMgPSBkZWNvZGVfb3Bl
bih4ZHIsIHJlcyk7DQo+IMKgwqDCoMKgwqDCoMKgIGlmIChzdGF0dXMpDQo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91dDsNCj4gLcKgwqDCoMKgwqDCoCBpZiAocmVzLT5h
Y2Nlc3NfcmVxdWVzdCkNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGVjb2RlX2Fj
Y2Vzcyh4ZHIsICZyZXMtPmFjY2Vzc19zdXBwb3J0ZWQsICZyZXMtDQo+ID5hY2Nlc3NfcmVzdWx0
KTsNCj4gLcKgwqDCoMKgwqDCoCBkZWNvZGVfZ2V0ZmF0dHIoeGRyLCByZXMtPmZfYXR0ciwgcmVz
LT5zZXJ2ZXIpOw0KPiArwqDCoMKgwqDCoMKgIGlmIChyZXMtPmFjY2Vzc19yZXF1ZXN0KSB7DQo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0YXR1cyA9IGRlY29kZV9hY2Nlc3MoeGRy
LCAmcmVzLT5hY2Nlc3Nfc3VwcG9ydGVkLA0KPiAmcmVzLT5hY2Nlc3NfcmVzdWx0KTsNCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHN0YXR1cykNCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0Ow0KPiArwqDCoMKgwqDCoMKg
IH0NCj4gK8KgwqDCoMKgwqDCoCBzdGF0dXMgPSBkZWNvZGVfZ2V0ZmF0dHIoeGRyLCByZXMtPmZf
YXR0ciwgcmVzLT5zZXJ2ZXIpOw0KPiArwqDCoMKgwqDCoMKgIGlmIChzdGF0dXMpDQo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0Ow0KDQpCaWcgTkFDSyB0byBhbGwgdGhl
c2UgY2hhbmdlcy4NCg0KV2UgZG8gKm5vdCogd2FudCB0aGUgc3VjY2VzcyBvZiBPUEVOIHRvIGRl
cGVuZCBvbiB0aGUgc3VjY2VzcyBvZiBhbGwNCnRoZXNlIHN1Yi1vcGVyYXRpb25zLiBUaGF0IGxl
YWRzIHRvIHRoZSBjbGllbnQgYW5kIHNlcnZlciBiZWluZyB1bmFibGUNCnRvIGFncmVlIG9uIHRo
ZSBvcGVuIGFuZCBsb2NraW5nIHN0YXRlIG9mIHRoZSBmaWxlLg0KDQo+IMKgwqDCoMKgwqDCoMKg
IGlmIChyZXMtPmxnX3JlcykNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGVjb2Rl
X2xheW91dGdldCh4ZHIsIHJxc3RwLCByZXMtPmxnX3Jlcyk7DQo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHN0YXR1cyA9IGRlY29kZV9sYXlvdXRnZXQoeGRyLCBycXN0cCwgcmVzLT5s
Z19yZXMpOw0KPiDCoG91dDoNCj4gwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHN0YXR1czsNCj4gwqB9
DQo+IC0tDQo+IDIuMjcuMA0KPiANCj4gDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBO
RlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVy
c3BhY2UuY29tDQoNCg0K

