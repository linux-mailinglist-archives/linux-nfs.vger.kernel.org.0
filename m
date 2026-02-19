Return-Path: <linux-nfs+bounces-19037-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HnXIxtnl2nfxwIAu9opvQ
	(envelope-from <linux-nfs+bounces-19037-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 20:40:11 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E20162138
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 20:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC775301370D
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 19:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19D72FFF9B;
	Thu, 19 Feb 2026 19:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Gx9H+qDn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021139.outbound.protection.outlook.com [40.93.194.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0227A2E0B71
	for <linux-nfs@vger.kernel.org>; Thu, 19 Feb 2026 19:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771530007; cv=fail; b=pbmYHLQl+YJGcWf7QBiUTqLcuq9p6FymoWmss+Ojeb8PmKcv6G2ghHA2Km4iZPrFiaIR8PS8VA/gS+fv8wYmUYbPGSf4PcOIm2of+rpyFJQXHDOc/CZJV49iYeeoCpM4R71AFMb3W8t0gg0UgLhHCWNAtGRMGQq3cbJBZGuRNx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771530007; c=relaxed/simple;
	bh=fvEHR26AD5v6rwBL/VbuFhvkznWBeYiYs7jbyeZ6VBA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZPgth/bc4lp//yCMPQ5GFgX0hm2h453cr6PFRqi8WGdPKh7f0fqRsBaux9plfUn6ic/L+ZI82mGW5atufQXBe7dVlFlQo4eS77tR7mPoVnuFQO3Ik7cUDWa0bkchhoCgBlog8WRNtezCVOSQwqIyJVQhnU/c0Qo/eroqjORy34U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Gx9H+qDn; arc=fail smtp.client-ip=40.93.194.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HSpF22jNkCVBBJWYLDXkSoPaJGkgvO7ryUnOJUASxWtHvr8GM/uQ9hBjdjVzAqadZ8tlyRaoNzYM724IpS0WaM88APfiBoZjmJqxbRJ0ZsT+O05mnPzUPTwyK+wltxXeSaVfPYvPyOIoxSXO9sgNKCJiyBkEmxkNn/aRsoBfTuzBYRw7Dgj7c2Qu2vEdaHpgg2wlRoVtSVuJR8ZV0M0YOzIc03atBjv8S1V5WmtX7zGBKgoIz1reoUahu9nSxX1Ko2KoKRL9IIKNbZrR48JyI+DMqXwHVOjgJiKGUS8A9KMuSmufTEdqn+XrHmk1Z9huFt0q39TxJuZYxx5O9UsIww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvEHR26AD5v6rwBL/VbuFhvkznWBeYiYs7jbyeZ6VBA=;
 b=LKFCrk2tEnYSHhaLmvUCwqOwZYZd/4yw1ARcrkLCio/Qlz2llfINl3lkOr4QCascgzif7Q19EKt9VIb5GCpRLxUG8msS9FRqkyycG33lIk48i4TBwNgLkJmJrMxTRx2dG5d4Pqij1CiYcwvWG0v6+HEzzYdmS3i17t6N31i85zHZBbRgGxMxxP2HCq7mNU78PJS/CYiSRo4s8026Nfc7GdB8mwNVI5wpRekQwKSTwEFRUObi5r0TUIMwRuLIYI0rZil6BtUi0qZCR7+esUl2HEzZW5Tky0vBnSCgSj7ZHpnjDujLbn2lGB0XvLRlqsmLGf002RK8ms5+QF/r9ic1gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvEHR26AD5v6rwBL/VbuFhvkznWBeYiYs7jbyeZ6VBA=;
 b=Gx9H+qDnp2j8viRt0nDXrl+ZjUBhfggHhNrk5oH1zfPXIPKIrkEus/VLKY/AgwPrEnpCn54EznOMUUoR1UAHOKltBUq5sIr/ELPqpHzO9XFMSBx9n3BsqFFhCXZTmmE9MV8+sWeGkfBPlfntIYUHHnIAM5apOafac7k4o6Yc0fg=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3815.namprd13.prod.outlook.com (2603:10b6:610:91::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 19:40:01 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1400:cb63:420c:6aac]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1400:cb63:420c:6aac%3]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 19:40:00 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "okorniev@redhat.com" <okorniev@redhat.com>, "anna@kernel.org"
	<anna@kernel.org>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] pnfs: improve "Server wrote zero bytes" error
Thread-Topic: [PATCH 1/1] pnfs: improve "Server wrote zero bytes" error
Thread-Index: AQHcodU+Bumj66/Xpku0tQio+nizDbWKa2WA
Date: Thu, 19 Feb 2026 19:40:00 +0000
Message-ID: <c6be70378ce90b3316c997bfc9443172eaa145c5.camel@hammerspace.com>
References: <20260219192327.34732-1-okorniev@redhat.com>
In-Reply-To: <20260219192327.34732-1-okorniev@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|CH2PR13MB3815:EE_
x-ms-office365-filtering-correlation-id: 46bd3834-039d-4111-d00b-08de6feeabcb
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VW9MTmNwZGVNNC9nWUx5dFlnK3lmUHNYdlYzcm1rNHJVcktpeUFGVC81blR6?=
 =?utf-8?B?aWI1WnJ1RzhJZHZ1VkIxUExhTUUrZGF1eVB2eElHRGtSZWtsc2NHYys2RjN6?=
 =?utf-8?B?ZDF3Q3BTTE9ka2dLLzJoY2tSYStPWjBwdzh2UTdZZzJOUmlrajJTa2RHWUpy?=
 =?utf-8?B?clYrVkI4cmJHeGdkbFlNMEVSQ1dPNXZka2VQbjZabTM2dUNvS1JhdXJ1VkxI?=
 =?utf-8?B?Wjl4MWtBcjlYR3V4VTJjSG5OYkZLR2xLQkJmd041NjlOTi9WWGpSVktheUNa?=
 =?utf-8?B?NjFmR0hPTUVNZC9pNEVRTTBmSkpFcXUrTzJJSC9RaHFqd1RaYWQ5eVN4bFdL?=
 =?utf-8?B?MkVzRmptOW85M09NeDY0L0U4NmJsQmNkc21FaC9hT1Vwbzc0Q1hhNnNlOFZq?=
 =?utf-8?B?UWh1KzJpQkxTWGRqemJEeUdOSXcwVTBKa2FHUWlNTk84S1M0ek1XVklISFo0?=
 =?utf-8?B?T2QzYVF4MGJpSVdEcThNMFNhQS9LNWlkc3hHYjE2RE5QS2NUT0xnSHcrOFI0?=
 =?utf-8?B?bmJ6UHVhdTlQOE5tOUx2SEhlRTkrVDlIZEZXNWd4MHFSTVoxZjNUK2FRR3RB?=
 =?utf-8?B?MVVvRUlBVnAreFQ1VGFzTU5JS3VWMmhZUTNLWGlkTVdMdXk1RkJwcnJqYkR4?=
 =?utf-8?B?R2puRWxKc0JST1crUGNCYUo3eThiNTBwK3h5QjdjVGNnYnA1anNhMThpejJw?=
 =?utf-8?B?SHNpN041Nm5oVDQvS0ozR2l5VHVzUjdWZHV5cGdOY0FwajJ6cW9BSlJESHJ5?=
 =?utf-8?B?ZUlQem1FRkNaV3YvMU13cnhwY2JnVkhhUTdab1dCRWptd213NUxoSzBEdHNS?=
 =?utf-8?B?L2JmbUxTMDU1aEl2WlE5RjU5d2dNaStzK0xJV1d4WVVhRk80ekJ3YmROTFpE?=
 =?utf-8?B?S2xFcnN2cmZENG9UbGhRbzhTOTJsV1BhVTFoR3RoSVNWV1V4VWtnVUoyUkRp?=
 =?utf-8?B?dzhhaWdpUUZndHovOUFxMGR5dWFnQkhET0g5UlZ6K1ZLcFRQUlMrM2FoYmJ3?=
 =?utf-8?B?MlJPV1paR3dpMm9GTThHUVUzdWxGa0tsRUFYRHcyUVhaZFBGT2JPdjZOUExD?=
 =?utf-8?B?NlZDK1ZqVS81YnJFL055ckR5YnBIZ1V4dEFCQ1Z1WXlPTmx0blVub2VCbmF3?=
 =?utf-8?B?RU9XcjFpQTl6eEYxQkNvTUtVQ1hjUEFKTnNjeEFEb3RNa3Z5ekpXUlB5SjAw?=
 =?utf-8?B?aEFOWkU3b0Myb0lraVpkalpUU0F0eTFWbWorWUZBYzdHWmVHc0FkWWo1eTBv?=
 =?utf-8?B?OU95QWNLcXExMFN4cTVmZk91ZE9HKzF3Q04yTVpxYkt4N3o4VmI2S2V6VFhl?=
 =?utf-8?B?MTJWY2V4NTBzRWY5VGZnVFA2Y0lOV2tpVEVjNWYvZi83TjNjRVZNbFNURGUy?=
 =?utf-8?B?ajNMb1BHY2lhSTVoTmdMb3hhSUtJaXZKdlJMVVhzWjlzbWhjN3o4NGpFOVhX?=
 =?utf-8?B?Y0pTMzZ4WVUzOTJ5OVlaVVpaYWp1dWtQS1l1aGd6RFd1U2xic1BPdXcwWTZU?=
 =?utf-8?B?WjdpSjc0THQ3T283dzR3blA1ekhpSDErN25zNUt3WXl4TUtwamlJTVdPRVBn?=
 =?utf-8?B?YURWKzZyNjJGUFF6VUFTZ1RYdjEzTkFZQjBJNlVnMXdZd2pCTzZVVG5scGFD?=
 =?utf-8?B?eHNLRTdJNnoyNGVYSjNUMnkyZjRCZHBDWnpLYU1OQnRzTHpyY0pqMG12M3Vp?=
 =?utf-8?B?R0N0NUxNVTR6MVJMWmFoN3lvRmNGL1RuVjk3NVlyQ2VrTEhpY1BVS3dhSzVL?=
 =?utf-8?B?cTl1L2pianRNZEpEOFNLOEpEaUdKYkRRZG5Kbmw3YXJZdHFXSENHKzJUNjRu?=
 =?utf-8?B?b29JNGx5cm5vMFBNWVBqRnR6MTFTRDZKMXZnZlNuOURzWTNUVXlTMVlvN1kw?=
 =?utf-8?B?by9SYTRJUVFnS0FsYXlCNjFVRmhDZmF6V2JKSW9kUktoV3RXalJ4bzVpcXV6?=
 =?utf-8?B?ZmUvU0J2c01hT0wxakFudjFyaURldTBiaURSR0wvSlVBbVJYNXZKL2tLRTYv?=
 =?utf-8?B?OEFlSkVEM2I0UE5qdXgxR1RkVm9ldFdNVWpqN05sL3cwRkJBeDUyLzRpVWx2?=
 =?utf-8?B?UkhrWmJ4YVA0RGM3Vis5Vm41cVc0SW0vcXNvVWlVd0tqcGJlVUZ2b2VVZm9u?=
 =?utf-8?B?Zk5icUJxV2xJQlY5WlN6TENtYndtcmlMQ09wRnBFVlQzR01rRUE0UUhkUDRx?=
 =?utf-8?Q?o5Ufyp94him3oPFtA+i5DmY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QlFuTnhEVHltNkhHWS81S3NnODBaNVRtQ1Z6MFFVZEVZNHJNcEpqK1dqR3hh?=
 =?utf-8?B?T0RGT0dTZmtKblZYZ1NpaXdtNTdkelVjUHNvOFh3QmtrQitsUjJJWXNKTE52?=
 =?utf-8?B?YWpCd0NXM1l2M3JndW4vVlhLNkhOelExTDM5YUZpdVoyb2hNV0xwZHk5VmU4?=
 =?utf-8?B?VFIvMDQzaDVyOWVENTdxNXdMQ3RrczBtRkVybXR0TTdBOVhxVkVDbkE3S2tj?=
 =?utf-8?B?Nms2dGRnZHdpVmdNdFRQTFRLdUJEeE9DWnRPeUhIaFRVcXRJSjJuWkFISEI2?=
 =?utf-8?B?aTc5SVlrUFhlV2hrMFNVa0ZVUFVKRU94YUphOXRoM1NmU2RkT3h3QUhSUElp?=
 =?utf-8?B?VDZFbURRY3JYc0FNblJ1Q2ZMTWw2aUVmSnR4N2ZpYVI2UHlVU094TmtrMWp1?=
 =?utf-8?B?MFpmTDltSWJvV0YxSys4RytYRkkxS1FVWVZBMXYzRmE5elUrMWRMSlhRcE10?=
 =?utf-8?B?NEpjTHM0TmQveDZlME5HTjU2YWszbUxEdkxMZ3VyYmZXNmk1bGlMUHdxRC9P?=
 =?utf-8?B?ejFENlUyRzUxMnhQeUU4TGs5STZRMnNjOGtTcFJCVWxaVCtWdnJKNWRMMDc3?=
 =?utf-8?B?TmZZWlF1dEg3MmUzeTZzTUE5UG9zRWhURkM5T3lFOFFzR2hzamlTVUQ3SmtL?=
 =?utf-8?B?bGNocDRZMlhrMnF6ZklwZ1ZzdzVQWkZtVCtFNVl4N1liMkZ5NklMSXRZL1NM?=
 =?utf-8?B?cHJ3UGV5UkZHNU9pd0F4SjJCZVhNYVpmWTJRelRKVnVnWUtaR0ZCeGtUK0gv?=
 =?utf-8?B?WExSYXYrcVpFS2lONUt6UVZvV1FEUXZLY3djb0M3TE5JMUJxYUEyWEQ4dWpV?=
 =?utf-8?B?UGg1UlVkem5JaXcyY3hGL3lUbjMyMUY4K0NtSTMyS3RxbkxxczNZN1l6VmlL?=
 =?utf-8?B?MVNvYVZISXdoUDBTSVNsRGRTVEY4aE5WT0owdGV3Q2NFNWk4dTJYc2NVUG92?=
 =?utf-8?B?V3NsbFhTUnV2Wjg5TkYwVXdSTTJEZzd6SWRvSU9jTkNIc2xkcjA3R1lac2Vn?=
 =?utf-8?B?dlVTMElpTVhvRlVNWFVjbzFpMC9kYTF1Vmg0R0lQRXdVeHhWT2tnbWF3VFdv?=
 =?utf-8?B?aVVWYTFxdVBac092Rm1Dd0dkQ3NhWVdIMGVtMG52VlBUU3YvVjJMcnQzRUI0?=
 =?utf-8?B?U3RvN0FhNkNqT1BYbWpKOHBIc3JFK3IxOVBRd1dHVTlRZjVJOE1oTC9zQ0xi?=
 =?utf-8?B?U2w2VmRWVjVLRGFYNTJ4bFhoeTN2UzcxeXRPTW5aUE5QakJ0VGtIUHBWbFRH?=
 =?utf-8?B?UUdkSUMyRlZ6QjBNeVoxTGJLYzAybGVYdms2L3Y5SExwdHVSNHhYd25GY0ls?=
 =?utf-8?B?b095TTREQjBaKzBSRVlaSm56S3dnNFJoOXFFWENHMUJub0t3aHVaS01LbVFn?=
 =?utf-8?B?LzF4MmZMRWlJOUp2bUVIRHNERzJObzdWVFNKemFNT3lLWjcwRnBUanYvaG4v?=
 =?utf-8?B?RllIMTB1V2pNZWRwNnoxc1NMRmJKZlVrUnZwRmZEeGxJcUJHeFAwTkN3Nk9w?=
 =?utf-8?B?ZElmK0lGbVhrZ3J2ZURoakp3NDRQeVUwczhwZ3NXWkcyTXdLcmduQ2xhblM0?=
 =?utf-8?B?RVpmc1Z6RlBqZnJrQnJ3SGJNWWJFTFlBMCthZHFhS1M4S0U2Vys5V2ZaVWVH?=
 =?utf-8?B?MHZVT1RmSkpobXNDSXIwcUl4WTdYczExZXlZd1Bpb0Z6NzNzNm82dDl2TUtw?=
 =?utf-8?B?RHFhcUpvWmtrWkNGN3dKd1BZc3NiZXZ0ZEE3YjhpcVc4MDNmTEx1WlRXblo4?=
 =?utf-8?B?NDI3L2hQa3R2S2RMWGNjV2VmcjZ5N1hpN2JPcVJQVVppais2bFducDJFWVFQ?=
 =?utf-8?B?Zm9nMUlaaDFBQXU1NDhvTTNIbCsxaTIvSTRTTGFkVnJqSllWbDdZTkVqZXpn?=
 =?utf-8?B?cG9jN1UzS0lJdHpWc2lLMlFuSjN3Zjd4dWNjOGZmYldISzZmLzFWckNLOUJX?=
 =?utf-8?B?YzlsZEtZcC9RLzVPTENSbGI2N08zYnBSbjIzV3BWWFdTaEtKNDl4eC8va3pQ?=
 =?utf-8?B?NWZtbDRUU3pXVXJjeXZya2xTMmZmTHFEZHFZR2xmTG02NWU2TmdZbWFRazM5?=
 =?utf-8?B?K2dxeVhMRTdRZjRVSHhucE1ubVlQeFVGeE8vaHkzVnFVbEk1YlFOS3NmS1pz?=
 =?utf-8?B?RGUzSGJwcEZEMmZyQUJLMFlua1N3WWtTYzlsREtnQ0lpb3lBNitzcGlrakhJ?=
 =?utf-8?B?dnAxbEZWMWZOSkJsUVpFR3Y2NXBrcFdZdklLZGJQdXlSSEVnVDBLNWFrVzV3?=
 =?utf-8?B?eXJZU0xrTFBUczN6bGN0MVBSUEo4YUQrRDl3WjRJTklycFhhRFBJQ2dIRHZT?=
 =?utf-8?B?TUNLL05KTlp0d3BGUTFURmFXYWpEdVg2YUFpUi9LcndJVUdaNXpVSUZXb2wr?=
 =?utf-8?Q?uvWJ1ZEMRPQlT80w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B6AA4C09BBE16449CE6CD08496EB9B0@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 46bd3834-039d-4111-d00b-08de6feeabcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2026 19:40:00.8309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CF+OLElR74/2oPbEX4NdJhUB70avZWqhn0Rb5PBmSvCsJGEDJLnVDkxKls9Q8ecrT0sjtP7OJ/WNcx7TlyS4/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3815
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19037-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[trondmy@hammerspace.com,linux-nfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B4E20162138
X-Rspamd-Action: no action

SGkgT2xnYSwNCg0KT24gVGh1LCAyMDI2LTAyLTE5IGF0IDE0OjIzIC0wNTAwLCBPbGdhIEtvcm5p
ZXZza2FpYSB3cm90ZToNCj4gV2hlbiBhIHBuZnMgZXJyb3Igb2NjdXJzLCB0aGUgSU8gaXMgcmV0
cmllZCBhZ2FpbnN0IHRoZSBNRFMuIEhvd2V2ZXIsDQo+IHRoZSBpbml0aWFsIElPIGxlYWRzIHRv
IHRoZSBrZXJuZWwgbG9nZ2luZyAiU2VyZXIgd3JvdGUgemVybyBieXRlcyINCj4gd2hlbiBpbiBm
YWN0IHRoZSBNRFMgSU8gd2lsbCBub3QgZmFpbCBhbmQgdGh1cyB0aGUgZXJyb3IgbWlzbGVhZHMN
Cj4gYWRtaW5pc3RyYXRvcnMgdGhhdCB0aGUgc3lzdGVtIGlzIGV4cGVyaWVuY2luZyBpc3N1ZXMu
DQo+IA0KPiBJbnN0ZWFkLCByZWNvZ25pemUgdGhhdCBhIHJlLXRyeS1hZ2FpbnN0LU1EUyB0eXBl
IG9mIGVycm9yIGhhcw0KPiBvY2N1cmllZCBiZWZvcmUgcHJpbnRpbmcgdGhlICJTZXJ2ZXIgd3Jv
dGUgemVybyBieXRlcyIgd2FybmluZy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE9sZ2EgS29ybmll
dnNrYWlhIDxva29ybmlldkByZWRoYXQuY29tPg0KPiAtLS0NCj4gwqBmcy9uZnMvZmlsZWxheW91
dC9maWxlbGF5b3V0LmMgfCAxICsNCj4gwqBmcy9uZnMvd3JpdGUuY8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHwgMiArLQ0KPiDCoDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL2ZpbGVsYXlvdXQv
ZmlsZWxheW91dC5jDQo+IGIvZnMvbmZzL2ZpbGVsYXlvdXQvZmlsZWxheW91dC5jDQo+IGluZGV4
IDVjNDU1MTExN2M1OC4uMmNmNDA1YzM3MGI0IDEwMDY0NA0KPiAtLS0gYS9mcy9uZnMvZmlsZWxh
eW91dC9maWxlbGF5b3V0LmMNCj4gKysrIGIvZnMvbmZzL2ZpbGVsYXlvdXQvZmlsZWxheW91dC5j
DQo+IEBAIC0zMjMsNiArMzIzLDcgQEAgc3RhdGljIGludCBmaWxlbGF5b3V0X3dyaXRlX2RvbmVf
Y2Ioc3RydWN0DQo+IHJwY190YXNrICp0YXNrLA0KPiDCoA0KPiDCoAlzd2l0Y2ggKGVycikgew0K
PiDCoAljYXNlIC1ORlM0RVJSX1JFU0VUX1RPX01EUzoNCj4gKwkJaGRyLT5wbmZzX2Vycm9yID0g
dGFzay0+dGtfc3RhdHVzOw0KPiDCoAkJZmlsZWxheW91dF9yZXNldF93cml0ZShoZHIpOw0KPiDC
oAkJcmV0dXJuIHRhc2stPnRrX3N0YXR1czsNCj4gwqAJY2FzZSAtRUFHQUlOOg0KPiBkaWZmIC0t
Z2l0IGEvZnMvbmZzL3dyaXRlLmMgYi9mcy9uZnMvd3JpdGUuYw0KPiBpbmRleCAyZDBlNGE3NjVh
ZWIuLjhlOGUzZjhlZjM2MiAxMDA2NDQNCj4gLS0tIGEvZnMvbmZzL3dyaXRlLmMNCj4gKysrIGIv
ZnMvbmZzL3dyaXRlLmMNCj4gQEAgLTE1NTgsNyArMTU1OCw3IEBAIHN0YXRpYyB2b2lkIG5mc193
cml0ZWJhY2tfcmVzdWx0KHN0cnVjdA0KPiBycGNfdGFzayAqdGFzaywNCj4gwqAJCW5mc19pbmNf
c3RhdHMoaGRyLT5pbm9kZSwgTkZTSU9TX1NIT1JUV1JJVEUpOw0KPiDCoA0KPiDCoAkJLyogSGFz
IHRoZSBzZXJ2ZXIgYXQgbGVhc3QgbWFkZSBzb21lIHByb2dyZXNzPyAqLw0KPiAtCQlpZiAocmVz
cC0+Y291bnQgPT0gMCkgew0KPiArCQlpZiAocmVzcC0+Y291bnQgPT0gMCAmJiAhaGRyLT5wbmZz
X2Vycm9yKSB7DQo+IMKgCQkJaWYgKHRpbWVfYmVmb3JlKGNvbXBsYWluLCBqaWZmaWVzKSkgew0K
PiDCoAkJCQlwcmludGsoS0VSTl9XQVJOSU5HDQo+IMKgCQkJCcKgwqDCoMKgwqDCoCAiTkZTOiBT
ZXJ2ZXIgd3JvdGUgemVybw0KPiBieXRlcywgZXhwZWN0ZWQgJXUuXG4iLA0KDQpIbW0uLi4gSXMg
dGhpcyBuZWVkZWQ/IFNob3VsZG4ndCB0aGUgdGVzdCBmb3IgdGFzay0+dGtfc3RhdHVzIDwgMCBp
bg0KbmZzX3BnaW9fcmVzdWx0KCkgZW5zdXJlIHRoYXQgd2UgY2FuJ3QgY2FsbCBuZnNfd3JpdGVi
YWNrX3Jlc3VsdCgpIGluDQp0aGUgYWJvdmUgY2FzZT8NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QN
CkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kbXlAa2VybmVs
Lm9yZywgdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0K

