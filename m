Return-Path: <linux-nfs+bounces-6016-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66245965405
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 02:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0768283E2B
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 00:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D691D1318;
	Fri, 30 Aug 2024 00:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="G6T4QxkM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2102.outbound.protection.outlook.com [40.107.220.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AB81D1317
	for <linux-nfs@vger.kernel.org>; Fri, 30 Aug 2024 00:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724978025; cv=fail; b=M1MnRo2uopwBRy7H1vw8Dr1FCsoimCUNmyZEK9imhZBIsy3Ow6bGaxiGYne4HrIxmgxWKx5KCclpj6lEjT3UCcUZX71fSdAy5gu5dF+x+0CxWKDI45Z5Rhr3QNNE6LYvXXZHUeyjQTbzuVxreVXgioD23fcaHG2cJdHtO4pnLgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724978025; c=relaxed/simple;
	bh=7VDlNr3Q/c4e5VeYounKGgx7vLgqWFoEQbcA5s5R+nY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QLoru/HdvmVVueR7Sx45+py8vHYRYRj4H6Yb7EcipVAI0XMKSZYHjVXC2Cme+ojTObbDCN332ZXurNJSlirb9zuKYz0LZFpS1UtKp08+a801zUNa0KuyyyVSLdbcyCccj3842HogAQJH1L/Ijge4eLLUpydZinv9uVeDX/nDlJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=G6T4QxkM; arc=fail smtp.client-ip=40.107.220.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wvc+L7tBWC4K3x2thzc7vpw1Wff5ERmtkNteH0mU1lzk1GI5Q8Rwh6wHGeLEgyACvDd9wRiUrrJ/R+bpQ7s68Kxq5IDJSuLFreaHYBLQGI/SjLYXbmfL92dwXbk+8Edr+9xEbUP1EYMBZNBS6fTQnzNxqOLrdQnwD9T5ISTVyrIih1U/qrwECBhygSiblvNboRizO3jcv6hqaA8SZNTDLYnaNv3jp67QcEaNCJ1NHwr52g3eeakh/GIz+cNPP35XkiEcfbuYRHEeg1gnIIaHax58KwccOJby28vfJgqnCcvWYzhrBYEi7Id0vY9N9SaJeB++T+U7WbQSqmAkYKsvYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VDlNr3Q/c4e5VeYounKGgx7vLgqWFoEQbcA5s5R+nY=;
 b=VFErB8Y+e4WfD3E7q30wiDNFva6oiZ6GwVZhOh+x6SHGoGsK+ZaPJ7GYU91FRnmQiuhjIY3Jmah/otKaSYfp9BlvhBfKNuHabUL+9S+D8pwsaQ4qq80hh1N+L/pwfkMorAFDfR9/ST8hY4tMw3zU/3QQcK58MLqUsjCqEiwzwMxKmuO1ee4NZEhWXsPau166btOu3cg1Vl/6MAXx2RWOoyQGTDzOZFmWj3tDoDPt2CUBV6ZRPqJUsslSG4GGZlw82SQJ/3nxFOO7Blr+K2XJRMH5sbfTOwOLevfqntHhw4y377wlE9cnG5Hd0oD537IZhWH5Eq43TPt3c4id5bGjcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VDlNr3Q/c4e5VeYounKGgx7vLgqWFoEQbcA5s5R+nY=;
 b=G6T4QxkMxkkMf6y0XyPnkG6K5tAtiNwQKQ+VU5LvovPjfQW0sgvkRDz8YgWetNkMl7FxJQFufzGiFc/vQKR6H1TF5krQLDT4+BNKPljBpTXVIZ+GvH6oosDkysRGVArAFeix7/98Ix5ja7Z+Odpte0Rvsck0rg0KHjQfqGr44OU=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by PH7PR13MB5504.namprd13.prod.outlook.com (2603:10b6:510:131::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Fri, 30 Aug
 2024 00:33:39 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%4]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 00:33:38 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "rick.macklem@gmail.com" <rick.macklem@gmail.com>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Any idea how best to handle potentially large POSIX ACLs for
 getfacl?
Thread-Topic: Any idea how best to handle potentially large POSIX ACLs for
 getfacl?
Thread-Index: AQHa+nJPlVDQq4zD5USzay9O8vT3u7I+85yA
Date: Fri, 30 Aug 2024 00:33:38 +0000
Message-ID: <babb9c0643d56a7aeee80bca7ec78f557f965081.camel@hammerspace.com>
References:
 <CAM5tNy6UmWngTqzy=YVQ_2x61+AdZp2uW90N8oGB1V73O-vDMA@mail.gmail.com>
In-Reply-To:
 <CAM5tNy6UmWngTqzy=YVQ_2x61+AdZp2uW90N8oGB1V73O-vDMA@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|PH7PR13MB5504:EE_
x-ms-office365-filtering-correlation-id: e6200536-850b-42ba-1cc6-08dcc88b642c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bHpGemVLbSszcXIrc2Yyazh5NUsrK1dnL281V0tWQkJBbG9rakJNdkVIRVlJ?=
 =?utf-8?B?M3IxNG5aUjBXdWdwTWlOSXUzZzQ1V2E4dW9QREhHQWpsN2VJUGxXYmlMc1dO?=
 =?utf-8?B?aUF4NnpudFFTODFaOStITlBVQ3hQN3NxOXdCV0ZyTTNzYmc1c3ZKNFRmSFRt?=
 =?utf-8?B?VWZaQVFkNHU2K2FueFpFV0w0L0V0RTRlZGxXd1lLaU5adTNZYTRwMDFrdFV6?=
 =?utf-8?B?NmVyUUo2RlZwZ2w1VE9TaEZhMUdUL2p6RWRIdUhtcGpSR1hKbmNYaFlBZldo?=
 =?utf-8?B?T2FoYXhDN3FENDVJMkVwelg5aXdEaElzUldTYnpoUFRZZ0s0TmovdDgrR2o4?=
 =?utf-8?B?dm1CQjhSZkhRZGdON2lDaUxsWmpPZS9kNlJKZEl3SzZBNk9TREpDV2UzQ3Jo?=
 =?utf-8?B?MWNXQS9ZWmFxTlhHc2JKRDVSWk0xNStDRVRHMDc2Y3pPQnBIMVVWclBHTDQx?=
 =?utf-8?B?Y05HMFBTYVJ0MkNzMXBMWDA1VC9JRGRoZHFtT1c4SDlteDFxdTlTaVNhVzZH?=
 =?utf-8?B?SEtkUGJCSnowb1ZUR2ZnN2JoaUZTQURtUXhpWFJzYkVpOTBIclRIVUtLS1pL?=
 =?utf-8?B?NzNreFN4SWhBWThPR0dvQzlPUktmWEllVEVmclVLMm40KzRMcVVheHZlM3dF?=
 =?utf-8?B?LytMa3NYOUZnVm8rUGJpSndFNjZFSmJBR0pVclNJbXAzYVJnMVFuRkRWVE9v?=
 =?utf-8?B?MDYrNnA5aWpCZWhXanFMdEhBTHNjbWpPNldoaHpJNFA1cGVwWi9jYzJJd1lT?=
 =?utf-8?B?VmV5d0Z0cTloY24yc2pSQUFJTWR6ZkZIcGJiYkNPdlllRnFydklJVnJxN3M5?=
 =?utf-8?B?d09qZDFwanN0bVVwbDNIWU5Ya3p0QUlmSi8xdkp0dzh4Y0U2Z25CL3BUSllX?=
 =?utf-8?B?Wm1rbUJ5WGdiWDIxa21JQTlSbWRnTStVSEU1UUtEVXpsbGVXMnA1SDhzT040?=
 =?utf-8?B?OFRYNitISnk5bnZ1R3lZYjBnSzhibW9xa01xV2U4VldiMDh0S09WTC9KQnhB?=
 =?utf-8?B?alFhbnJaYmxNVW1xd2k2c096K2RkWThhZ25Uc1k5K3ZSU2FSMFQ2aGhRbWwz?=
 =?utf-8?B?amRMbm82aW9RMWFaS3ZENUFJMWdGZkpqODJXWHVZejltSXdrQnA0YkhUTHFM?=
 =?utf-8?B?SldLMFFkejZpUFhtLzh0T3RkZTRMV1duYWU3Tm1nNlUyekZ3YmxiNmNrTFI5?=
 =?utf-8?B?RVErRGJNRm9mMTMzeHhjTTdacXdtOVpRdXN1WGhGSnIxRmYwaEU3a1lna0g1?=
 =?utf-8?B?SWcvQzVMWGJzSENSdGNxTUE5c0Z4UjBhZThzRXNZY1NDei9tMWZSOXZ3VDk3?=
 =?utf-8?B?RUVkczc4a0U0Z3Z1TTFaV0N5YzY0MHkvSEQyOUhVOFYxTC9OSTI5MU4rV1c5?=
 =?utf-8?B?UzBLUW1FRkdIbzNVTkJ1NWkvc0pmV2lKaklOUHhNaTVNdWtNSXpIT0o3MGN0?=
 =?utf-8?B?NE1HYU11b1cxRXg3SCtsQ1RlQ0ZDSStZL0FRWFgyYi9PNzJmVXFBaXVWZ1Nt?=
 =?utf-8?B?a2pOTnQ2Zm9xbmlpdXJxMGQ4ck1jc3YzOWtRQTc0ZUh4ak5FM2w3QzA2OVNQ?=
 =?utf-8?B?WmM3YmVUZnR3SS9HSlJvVWlDdTNTSXo2VHZ2Nitxc0JCNWZnc2YwRG1wcS9T?=
 =?utf-8?B?QXZ0WXNTVzFEQnVPelRCTHFOT2kwZnBlRUpJK3QrT2gzYzVINUQ2YUMwZ2xm?=
 =?utf-8?B?NS96em9FL2dUdm5RaW5SOXJYL2JsTTA2TnVCc1g4dFQwakU3bGQ1VlJDNmRx?=
 =?utf-8?B?cXNselgyWXNEUzJRanJWbEFTelRmUTRjbmxxUlNiZGhPdXZ6cmk2UHNiT1ZE?=
 =?utf-8?B?RkEyZkVBczZTRTFDeXc0R3UrSzVqMXNpdWJIMlFaaWVOTkY2WUR3NnNEV3JL?=
 =?utf-8?B?RG4vZ2pxNlNYNlFCdnB3WjFqNytmaDdpeFhRSmMrUkx4YVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cjJhZWR0ZzJ1TlgzeXYvbXNJS0RVMHBsc1U3ZnpMYklaMW5sT0RReEYxY2Ir?=
 =?utf-8?B?NWJ1QVN5SnV0aWp1dWpBVFNaTE5iSU02RUFoMlk5OGJHTUhidUM3YXdpVkV2?=
 =?utf-8?B?MzR0cDVibVVxTVpXb092a0RvaldnYm1RQUo3R3dGT1NUcGJWQXJ3cm9Jb3Zj?=
 =?utf-8?B?eDlsbi9lYTdaaVVrTmtrSldqSDFVUHc1V0srV0lRQlRGVmNtY2ZlQmpZR0pw?=
 =?utf-8?B?OGxjWXhsTHJuay9OU2N0UUNCeU14cXpvSW91and2VUFDOTRtRWxYMzhuWnJt?=
 =?utf-8?B?azBLNytWVyt5Q0U4c2FHR0JxT1pvT3pneE95UXZ3Um9scVRTYm91QjlvdStq?=
 =?utf-8?B?dlFDUUpUcVc4MWZ4bzJXSm03SzB5OHU3MFFiT045ZWpnYk9VeUwrbXJqSm9M?=
 =?utf-8?B?VVRITEJHN0Uzc0lkcFRURkpWVnNPOUcrTCtYVjhxMUhoK21TME5Na2h3dUM5?=
 =?utf-8?B?bGlNN1cxWWhWOWlVZTRtaWI1U1gwSW9hS1IzcUo2b25ZUlVtZm5OcTcvbE9B?=
 =?utf-8?B?WGJRcUh5VVkyZGxRaGJuYmRRMXYyZlROeEg5aU1hRHlUQlFiYkRTM3YxT3RM?=
 =?utf-8?B?eDMzSVFEN3VHeU50LzVuY0trQWxUTDlCRXdSeVFhd1hLaFlFSWxpNzlCTTdz?=
 =?utf-8?B?aElsQXlzbkRVWmdMMjRmKzNCMDEzcjlTN3dZcEUyUzY3TjBoYzhZc2phUSt0?=
 =?utf-8?B?M3VXMXJGVnlKaU1oRHVuamdBVUV3cVFWcWlBdk03WUZmNVlJU0VNb1JWMnNS?=
 =?utf-8?B?YkxYZE9XOUVwOGU0cEpNUVRpOEZJN2g0ak1sK1lFTkdYaGp6MWFtczRHTmZi?=
 =?utf-8?B?TUZmOEdiWmYrd2JvTkhTdjRkUzJZUTZYTWViQlpJZ1RMUTZMYzdxZ0gzMG1k?=
 =?utf-8?B?Y3J0N2tFSHozTWdaVE41WjNsNUs1MkZMYUVSNTAwUzRCYTJJd0I2Qkxycm43?=
 =?utf-8?B?R0Vpa3gyVlNKU0p1Zjc2ODFmVWgyNzZUWnB2UmlFaGg4Qm9QWGlLNE9HUUs5?=
 =?utf-8?B?UXVTZ3ZSOUVWbmhiWHlBTFVxeE9kUlJKT2hSNkJrV2orb0xlam9WWG4yeDFL?=
 =?utf-8?B?bE0zeFVTYXlMcnRFK245WmRlbjFEY1MwQW1sekRITFZxbEVSV2xIQU8zOHVx?=
 =?utf-8?B?akVtOFVZR1k1OVMzOEZvZktOdEZpenhJT1JEb1FnSS9hcTY5eE9MYmpnMXdI?=
 =?utf-8?B?Y2JKMHZVencrWk8xcXplMjZYakFVa1h3a1hOREVrY3c2YzJQcWU0VGFraUs0?=
 =?utf-8?B?QkFoK3RQdlhzbnBFUVJuWHZOREM4K3lsRXE1NS9BS3h1ZzNTRkkxdFRERE9r?=
 =?utf-8?B?Q3FKZ3dOZmczbTNRMWFXS3YzWHV2a2tNYnRUZ1czMzRMSVQ1bDRHOWFhWXlI?=
 =?utf-8?B?ZzlNZVhvUm1DWGk2Y3ZLZ2N3MkVVOEZGSllENldTR2Q1ZG1QMzhCNFdtVStE?=
 =?utf-8?B?SkwzNXVGTlVhNzZCT01pc0grViszN0FMOE9EelBqR05RMGZORERNU1RVOWRi?=
 =?utf-8?B?L2ZxbzRIVTdTNTFIZ0ZhbVJVK3lBakc5YU9zRXdXWktzUDc3bGJqQk1vSWlz?=
 =?utf-8?B?bisyY1dHL1g2eWV3Mm1rZzFpUStpNnh1V2xDcThNa3FHZklERUo2LzVZK3lQ?=
 =?utf-8?B?R0hxcjBqUzEyeVJVZ1ZwWkMveW1acnJYTEFlYUtOdHN0ck4zUDdYM0hvbyti?=
 =?utf-8?B?bjRMRVdNb2xnTTBRLzErSGxGaElhbmw0aHBZdjUxMVdHN2ZxL3BXc1F5cEZY?=
 =?utf-8?B?M2hFNUN0S2xXZXRhWDE0c1RqNU1xNW9HekZldm5hUnJoVWpObzBTMWNNSVF3?=
 =?utf-8?B?N2x1dStBZzRoc0g0c1pjQWduTVdTeFloQ2RGdE1TZnRnSlA3SFErcE1pcHIw?=
 =?utf-8?B?Z2d1aEtTZi9Yd0NzS3o2ZThFTUgrb0dGTnNlWlQ5YXUvVWJKc21pd043ODMv?=
 =?utf-8?B?UTJQVGs4T0d6QTBHbUduR1lOdDhzL0FpMi94L1NkY1doL1RYR3YxMlJMTXdT?=
 =?utf-8?B?bEgzUWtjLzZSQW9EcGlmWmlXdzhQdXRXNFhDNVJ0aVlIOU8yR2t3SHpWWmhv?=
 =?utf-8?B?UVZUdXVoTzB1MHdUdTVxZEFnSTVkR3VOSE5wQ1VpdE5nalFOV3plYW1CbkYv?=
 =?utf-8?B?RTFCYjVCMXlla1JYZyttVWlsQUhIZFZmMWpCaGpkQWdyV0ZyREdIRUg0K3lI?=
 =?utf-8?B?MWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <567E1987EAC16A4FB7A4A4E95D4758AC@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e6200536-850b-42ba-1cc6-08dcc88b642c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2024 00:33:38.6315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: psHlxn5OoQbKdIJndS49fmc9WIrPilRoPUH2cBZmy0ADOEpFN5yFsgsWEzHt7OoTUdiOF+4NSaSqbw6syJ+4JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB5504

T24gVGh1LCAyMDI0LTA4LTI5IGF0IDE3OjE5IC0wNzAwLCBSaWNrIE1hY2tsZW0gd3JvdGU6DQo+
IEhpLA0KPiANCj4gSSBoYXZlIGEgcmF0aGVyIGNydWRlIHBhdGNoIHRoYXQgZG9lcyB0aGUgUE9T
SVggZHJhZnQgQUNMIGF0dHJpYnV0ZXMNCj4gdGhhdCBteSBkcmFmdCBpcyBzdWdnZXN0aW5nIGZv
ciBORlN2NC4yIGZvciB0aGUgTGludXggY2xpZW50Lg0KPiAtIEl0IGlzIHdvcmtpbmcgb2sgZm9y
IHNtYWxsIEFDTHMsIGJ1dC4uLg0KPiANCj4gVGhlIGhhc3NsZSBpcyB0aGF0IHRoZSBvbi10aGUt
d2lyZSBBQ0VzIGhhdmUgYSAid2hvIiBmaWVsZCB0aGF0IGNhbg0KPiBiZSB1cCB0byAxMjhieXRl
cyAoSURNQVBfTkFNRVNaKS4NCj4gDQo+IEkgdGhpbmsgSSBoYXZlIGZpZ3VyZWQgb3V0IHRoZSBT
RVRBVFRSIHNpZGUsIHdoaWNoIGlzbid0IHRvbyBiYWQNCj4gYmVjYXVzZQ0KPiBpdCBrbm93cyBo
b3cgbWFueSBBQ0VzLiAoSXQgZG9lcyByb3VnaGx5IHdoYXQgdGhlIE5GU3YzIE5GU0FDTCBjb2Rl
DQo+IGRpZCwgd2hpY2ggaXMgYWxsb2NhdGUgc29tZSBwYWdlcyBmb3IgdGhlIGxhcmdlIG9uZXMu
KQ0KPiANCj4gSG93ZXZlciwgdGhlIGdldGZhY2wgc2lkZSBkb2Vzbid0IGtub3cgaG93IGJ1ZyB0
aGUgQUNMIHdpbGwgYmUgaW4NCj4gdGhlIHJlcGx5LiBUaGUgTkZTQUNMIGNvZGUgYWxsb2NhdGVz
IHBhZ2VzICg3IG9mIHRoZW0pIHRvIGhhbmRsZSB0aGUNCj4gbGFyZ2VzdCBwb3NzaWJsZSBBQ0wu
IFVuZm9ydHVuYXRlbHksIGZvciB0aGVzZSBORlN2NCBhdHRyaWJ1dGVzLCB0aGV5DQo+IGNvdWxk
IGJlIHJvdWdobHkgMTQwS2J5dGVzICgxNDBieXRlcyBhc3N1bWluZyB0aGUgbGFyZ2VzdCAid2hv
IiB0aW1lcw0KPiAxMDI0IEFDRXMpLg0KPiAtLT4gQW55b25lIGhhdmUgYSBiZXR0ZXIgc3VnZ2Vz
dGlvbiB0aGFuIGp1c3QgYWxsb2NhdGluZyAzNXBhZ2VzIGVhY2gNCj4gdGltZQ0KPiDCoMKgwqAg
KHdoZW4gOTkuOTklIG9mIHRoZW0gd2lsbCBmaXQgaW4gYSBmcmFjdGlvbiBvZiBhIHBhZ2UpPw0K
PiANCj4gVGhhbmtzIGZvciBhbnkgc3VnZ2VzdGlvbnMsIHJpY2sNCj4gDQoNClNlZSB0aGUgTkZT
djMgcG9zaXggYWNsIGNsaWVudCBjb2RlLg0KDQpJdCBhbGxvY2F0ZXMgdGhlICdwYWdlc1tdJyBh
cnJheSBvZiBwb2ludGVycyB0byB0aGUgcGFnZSBidWZmZXJzIHRvIGJlDQpvZiBsZW5ndGggTkZT
QUNMX01BWFBBR0VTLCBidXQgb25seSBhbGxvY2F0ZXMgdGhlIGZpcnN0IGVudHJ5LCBhbmQNCmxl
YXZlcyB0aGUgcmVzdCBOVUxMLg0KVGhlbiBpbiB0aGUgWERSIGVuY29kZXIgIm5mczNfeGRyX2Vu
Y19nZXRhY2wzYXJncygpIiB3aGVyZSBpdCBkZWNsYXJlcw0KdGhlIGxlbmd0aCBvZiB0aGF0IGFy
cmF5LCBpdCBzZXRzIHRoZSBmbGFnIFhEUkJVRl9TUEFSU0VfUEFHRVMgb24gdGhlDQpyZXBseSBi
dWZmZXIuDQoNClRoYXQgdGVsbHMgdGhlIFJQQyBsYXllciB0aGF0IGlmIHRoZSBpbmNvbWluZyBS
UEMgcmVwbHkgbmVlZHMgdG8gZmlsbA0KaW4gbW9yZSBkYXRhIHRoYW4gd2lsbCBmaXQgaW50byB0
aGF0IHNpbmdsZSBwYWdlLCB0aGVuIGl0IHNob3VsZA0KYWxsb2NhdGUgZXh0cmEgcGFnZXMgYW5k
IGFkZCB0aGVtIHRvIHRoZSAncGFnZXMnIGFycmF5Lg0KDQotLSANClRyb25kIE15a2xlYnVzdA0K
TGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0
QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

