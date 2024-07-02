Return-Path: <linux-nfs+bounces-4526-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C51923FC8
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 16:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E0DA1C2314A
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 14:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF84C1B4C35;
	Tue,  2 Jul 2024 14:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="KmzWvX8F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2115.outbound.protection.outlook.com [40.107.220.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43FB25601;
	Tue,  2 Jul 2024 14:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719928855; cv=fail; b=MgkuIPNJlLLPzE5T1UB5yMDByjwEL1ZGY7VollgpsXpgXt2WydIqWjtu5qBs4rATXw4xF9LOmdTFYkkq236gsDX+0ugUjxD2anqaLkG7ZO/LMbqfzA11ppiGMM1vrDCA6nmfQzudBrpEN5W5i6c7dHhBW72DKzc87Dy3V8HsW+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719928855; c=relaxed/simple;
	bh=pNWxORAqHGDMXOoILvyvni8KEoy7fAghEV9aG3kgw4M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tA2DI0eB/LLzpIiKMX3Wh5h6yYxoce9hxBDBexOaMvDVcrI8NNvOt6xr+zuHzlLz7MpLQeXMY2EgkoFOAxrJI4Of+bbpEpl3647QS/VJWMechnLAR/qZaXaBem7FnUuTGorL398k1DquaHqp5x3JSq01JGuSmSXPKVC5i+gXJT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=KmzWvX8F; arc=fail smtp.client-ip=40.107.220.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ae+kOCpB9DqxVhKzY4VWQWrSf/gmvJZzKrBovqvtB8/ifzOuK83neF0XoG+UThdO5CnLqy29wx0Pfj0piwNw2v/Gn1DWP2FrbpjRMMjYXj9V/Ik+1plqZeawnsG2rCVpquJ5+ZCMXM9OPIDHfehSxvD2VrZY29tmPPGkDXiomXLHyeWNbNQfM9Yx6eYCFNzMHX8mIrLixjOKhJfLxWZjjMNFQMn6OMJGulncmZnM8BTRo10LGwaSBqzmAh/TSGQiAF6DC63ySTdA9P7UaoZ/1cKmZe+ISXhtORczruCEjdCXOVn9+yrsl0Do1+dtw+l0aHZO3OOMnm4hTWkKTti0gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNWxORAqHGDMXOoILvyvni8KEoy7fAghEV9aG3kgw4M=;
 b=NnjSWt1hukiqeWXM/2SOfprdop/6hWIaEoC3/5/c1+HelG8xPVwWO8TpNdan1/wIagYe63Is+wq8RwhxefCFp6uftA2xcO/o4TqJhiDlz4qmLDR3qIUM0gLKvvOfcgJQFX3Z2VGBb86rbIn2f8kD6xJ8KQi/jcpXbwObIJyjmOzZECnZqC5ngMe3KHTRjomfyZPLIgdCtinug1erPD6sbbHTiKPzeED6Bd7mMb2ldGXF9Hf/lQ+nO4sbTe7gbklDga14YJMEVKSzGp5QOeFyEifWojGatU0tNvgu5ZoOUdsSeBvgWv7UuOAOObJKjuWNa8/0qrQahwx1esbGxwAz4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNWxORAqHGDMXOoILvyvni8KEoy7fAghEV9aG3kgw4M=;
 b=KmzWvX8FYTF0DP/nJvBJpd7AQyktO+Cv704ySrFaGMdQV+gWz32XbRN+VN7XrL5EGPiBB7aBL4Iqdwqn/Fjex9yzjwrprE2RCoP/iSZkI67ObfyI82msbFpOmYvhavHtb79Zpensdi5qn42Z2bsVihdS9CCDuChus5YHg1C33Dg=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BY5PR13MB3652.namprd13.prod.outlook.com (2603:10b6:a03:226::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Tue, 2 Jul
 2024 14:00:48 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%6]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 14:00:46 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "david@fromorbit.com" <david@fromorbit.com>
CC: "bfoster@redhat.com" <bfoster@redhat.com>, "snitzer@kernel.org"
	<snitzer@kernel.org>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "linux-xfs@vger.kernel.org"
	<linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v2] xfs: enable WQ_MEM_RECLAIM on m_sync_workqueue
Thread-Topic: [PATCH v2] xfs: enable WQ_MEM_RECLAIM on m_sync_workqueue
Thread-Index: AQHaywuEBap/iEadlEORNNEJmrHSZLHh65UlgAF2hACAAAimgIAAD6GA
Date: Tue, 2 Jul 2024 14:00:46 +0000
Message-ID: <d1af795e3aa83477f90e4521af7ade3a7aed5d4b.camel@hammerspace.com>
References: <Zn7icFF_NxqkoOHR@kernel.org> <ZoGJRSe98wZFDK36@kernel.org>
	 <ZoHuXHMEuMrem73H@dread.disaster.area> <ZoK5fEz6HSU5iUSH@kernel.org>
	 <f54618f78737bab3388a6bb747e8509311bf8d93.camel@hammerspace.com>
	 <ZoP68e8Ib2wIRLRC@dread.disaster.area>
In-Reply-To: <ZoP68e8Ib2wIRLRC@dread.disaster.area>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BY5PR13MB3652:EE_
x-ms-office365-filtering-correlation-id: f46cca07-f27f-4617-ae16-08dc9a9f5f12
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Ky9pUWR5MFdZR010TVc5WUY1d2xMbVNvem84aVVYdWpnVjliYUk1N1RkeVZh?=
 =?utf-8?B?eVQvTE5nSzUzc3Flemo5QjJXOS95WC9uMnBjUVVvaUI2bXZCRmRnVmlkRnRl?=
 =?utf-8?B?aFZoWkI4dC82R2hqQndWT1R0bFZ1RWMvQUg2WUl0d3NtaGFvVE1NUFFjdHVk?=
 =?utf-8?B?amlETWkvOGFmdFlKOUdCZTNPaTRmbE5UNUg4QVA1V1BhTWxRbTl1RDFzaUlj?=
 =?utf-8?B?eHAzWEZQY0hXNzQrcS9rbmtrMkZmNWk5U2N1M3M5QXRBcS9wMkYwVlBCNU14?=
 =?utf-8?B?NG4raGNKZllYbEhndlkxdnlxc2kzeXBQVUJ6NldnbUNJVFRwUG50UUNKNGhN?=
 =?utf-8?B?ZDZSdXdsb3M0aHRlVGVhVVF1NWx2WFFhTElHWHJXSk1qSEtUd21oQXlvWVJS?=
 =?utf-8?B?aENVaE1sSXNnTkxpNHlXeWt0RTJ2VEhDRVc0YTlLOG53UjA3dER2NDNWSTdr?=
 =?utf-8?B?b3c3TVVabnNwS1Q1eGlrY0V5V1hxSFRWbVFLT29YZ25SbWRUeFVlS2lRQUwx?=
 =?utf-8?B?SHZra0k5YmRFTS95ZFBtbDBPVzhqSDhmZ0l6YXlUWnd2UnZwTy82RGxXZnh6?=
 =?utf-8?B?dFBtTFpwclhlVDNpaTBOSFZOcDhBbUxrNEh6cVR6cFBQOUl1NE93UHlmc1Y3?=
 =?utf-8?B?Y2pIWWtTMVdVaUp1TzQyVmFrS3JZb2thcEMvckpISlNWWVdWb3Q3akJ0WGky?=
 =?utf-8?B?TEhxQnc3ZGx4Y2JxUWZlQ1p6Zit1QUFQeHNodXVLdk1lTTczLzZKNlQvMHFJ?=
 =?utf-8?B?RXp1UHU2KzA0U0taQW0yaTk3VU13YmpCaEpnUDdnU0xlTXUyZXVtN3A4amNQ?=
 =?utf-8?B?cXFmMG9qdUNEd1RIaWhXSHZoaWZFSm9keEpFU1BkejQ0NElGRDUvbHlxcjZm?=
 =?utf-8?B?d1RVa1lxNkkvYmZPL1BiTG5WMC85UWROSW52UXl1K21leDI0Q2s1MmhLdUp3?=
 =?utf-8?B?YmlyVDdFWkVUM0FaMmFLancyUWFTeEdrMmJNckdrK1FzYjZmQWxUMUxyZGtS?=
 =?utf-8?B?U2lMdDZNRERidEdHTGJ6blNLb2tDN0g3VkFzZnJ1WmQ3M1Rmbk1xTHhTWlhG?=
 =?utf-8?B?QVZFZGduZWM3TXNNYitQUTRSajkydnNzQUNJa2g1M3FmZWFxcm5Xazlka1d0?=
 =?utf-8?B?bDNOSTEyZ3ZiczJudk1yMVhFandPcVFMbVVaQXY0RDgzSkZOUnpsUE5RbDY1?=
 =?utf-8?B?ajBpbTRVejRETDJIMW8xMnJFU0xyVDB0Qzg3Um5lb2pLQncvdHVja2R6RUdH?=
 =?utf-8?B?NUJXVlVPTXMxd0c2aVhINVZ6S1VRcU9BSENuOHZKUG5zSkUwSGRWL3dnblRU?=
 =?utf-8?B?T093RWh1UkZQNEZpWVp3RCtGZDdFb3VxZXVHZjlFZ3VOTmd2RERZM0lITU1o?=
 =?utf-8?B?Qk1kbi8wMEJaRmZwdWJVYjZ6SFgxVWpGenJzVjRrWDcvVnJyQ1ZubmRqYnRj?=
 =?utf-8?B?RGlSTjlMTkZCR2kwcEp3dWN6dW5UckJPTHBlTGl5K3prWlNtV0VkcWQ2c1c0?=
 =?utf-8?B?YS9qVDhBMXRvSHNpK0IrSmRwdzhmdU0wY3VBRGRvekQxSUFoRXoxRFpDSVdG?=
 =?utf-8?B?SU1kc2pQNkVvbC9BcXdJZWxQOHdBSEFPQm4vQUxvVHpWNUNGYWpCcERGdDBL?=
 =?utf-8?B?ZXdEc2xwenoza2ZVMWdickt1ZGxLWTkwWkIzMG1GdzRyUExENnhHR0E5WlFT?=
 =?utf-8?B?eENSeGROV2llQVlVQzdGRG5oNGtmT0VMUXViVnlnaThKOGVla25TbFcyRUhx?=
 =?utf-8?B?SitzY20rUjhWbUlPNk1sODB0ZnluMnNHemlmNW14YVkyYlBuRGo2MXU0ZFZ5?=
 =?utf-8?Q?XYK4oEqRG7chN6GRAoiDxIRgE6lHUuTWEevbM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eUxzcDMwTFNPYXFVR3VGM2duTmRNdDJqSWYxazJ4eFV4MjhGUnVadW81SWFX?=
 =?utf-8?B?KzlETmdCZ3FTYlJBZmhZbHhObnhuRkZNelJwbHI0dHJKMWNpUWNIUDVZNjJD?=
 =?utf-8?B?R2dmZmNKZzN6TDZTMmI2UytHcUFFTG5xOUw5V0RBWjFHczVZYXFwSlRKL2J6?=
 =?utf-8?B?cGpjbFRrOWhFbUlGNGNYc25ST3NLZzFPekVjVXBXYXBRRktGcTFqNjR5Yzls?=
 =?utf-8?B?RDRvZldpWE9YNHowUTR5Ni9zRHBzVndVcEJaRWlrS3NUNE9vZ2lxUHdEa1ls?=
 =?utf-8?B?WldLUnM5VGpybGJlWUJNclNPL3ZGSzM5RG1Mdjl3aENMSUE4KzlwUHJpaEdM?=
 =?utf-8?B?TVFXREpQRXNXVUk2SDFwcnhxZmRIeWRyWG5Fa0NKeURLM2l3OEF4ZHZtdWN5?=
 =?utf-8?B?ZkdUV1VVWG84Q01xOVFmc05WekxnQVdXaHAySmlnelRkZ3lJNkJrK1Q5TWk3?=
 =?utf-8?B?ZHJVVGdBb3ZMNGNoWC9JaGp1MzFVc1VYL3BuTlFYcCtaci91aHkyYStZakha?=
 =?utf-8?B?WXhyZ3ljZG1uRVlnc3dySUQ5L3doWW9lUytGS1pOd0svaDVsQm05OHAyL3d3?=
 =?utf-8?B?RFpxRGFCQnZUaWdOVFJZVEpEamcvRUpvdTRhYmUvT2JaWGdnN2lYaGVDT0k0?=
 =?utf-8?B?dGt3M2NpT3B2K216c2RrenY2T0M2MzN4SlBISiswNWlOQXhkUTcwWU1XQWVT?=
 =?utf-8?B?WUVCdHloTDdDcHFZQnh6UUdLWENnRWZIazlwTENOVTRSNW96eTZSM0tXc09J?=
 =?utf-8?B?ZzVWOThQZ052VGQ1aEE1ckY0dzdQUVAzYTBWMXdJek1QbEx3WHdQYzM4SU1k?=
 =?utf-8?B?MkorcGRxd29qUUtDdG80R210Myt2T0lkNXUzZHlPT0JETXNBd0VybE11TS9i?=
 =?utf-8?B?SWhMcnpsR2pKNTRlTmlRVVZFRjF1WDl0SmZpYlNsRW13bnExZzRnbzhybDgx?=
 =?utf-8?B?WE12d04vNmpKR3NOVUs3U1Q5Z3ROcUhFbzZQb1R4TnpxL25kTTg2cWVRdjZN?=
 =?utf-8?B?Qld4TmNTMWREK3p5bVhpZGZSQTJLcFkxZU1JMkxWMkVoT2F6UHhIZzRGeis0?=
 =?utf-8?B?OFJWRGpSK0lRY1pBWWJ5c0o3dmNmTVBib2ROZGhxeXlERlNaOWxuRkEzcC9r?=
 =?utf-8?B?elB6Rjk4WXZocFRvZnNNWE00M2Z3dFpHa2cwektuUENVcElkTWVqVFhuanlX?=
 =?utf-8?B?WmQwbkI4NWdTNmpvaXg3emJDQ1Q2eGVsMHRTYkNkNndmVU1GbUNLc2FXckhC?=
 =?utf-8?B?R1hFTE0xaVEvSFpXZHJwTW5qbnBXOXlha1oxR0JhdDRnVi92NnZwSXZzL045?=
 =?utf-8?B?NTl4dDRNY2R2dHArandGalc0TTB2OU5PaWk0OEtoRFBiaXlYUHNiV0tSdTRC?=
 =?utf-8?B?Z0JnejJjK2wya01ydlZ2aS9kVnJOMmlmeUxTUzZQMjcxT1IrNi9IM0FGSlJq?=
 =?utf-8?B?OWs5QjI0TjBNckxMRXg3cnV3RFVWVmRST2R4K1EvSXFnMGNKb09hVWx1Z3dR?=
 =?utf-8?B?SDBpNkE1R200VEZMOWZDV0Z1YjU5Z3pxYVlqWWExRzJUSFNCQ0phblY2RlJG?=
 =?utf-8?B?YURuUU9XTlV6ZlEyRUd5d2c3K2g5VDM4Ykkwbnk3YkpJYTNldHNzQnNUYTRM?=
 =?utf-8?B?QmFGbTdKdjJrNFZxQlQxcjMybEJmM0djdUhkQU1UckNlYVFKUWtsS2NaYXY4?=
 =?utf-8?B?UVo2YkxBVENQdThFVlBEOVZkQ1pRdWY2RThVQnNKNE1xWGRWdFpmSFZzVXI1?=
 =?utf-8?B?ZWxGN2dtV1p3MWkrTFJWeUlWVWV1UE1VeUpMUldXcjdnbnhma29aYU05akVS?=
 =?utf-8?B?RTJMNFQ3elNFTjVncWgzK2hTWWZwN3ZoaDV2WHNDUEFRdDZqbHVKTlllS2hO?=
 =?utf-8?B?bGRZVk9XalRqTmJpRUtQeDlHeUsxV3FaY3RTcEhBWUtmWnpoWVFDb2dtSmNL?=
 =?utf-8?B?NEVVNlZXODhmWTFoNVU3a1lONnF2YU80N09kN0JJeDl4V0tISEhsdUdzK3NM?=
 =?utf-8?B?TnNScUg0a21WWlNhUisySndNUE5UVkFVR2dLQk81ZjhyL3ZjRHhXOFNhc3Nz?=
 =?utf-8?B?c2RCOXVaZ0V1b09ZOXN3RlJ6RUEvWW1VUXVqelZydEtTRzdJcnF3T0J3bVVv?=
 =?utf-8?B?L254MHdmR0cxT0IybURka2VOWUlubEg1UWZOekUzYndRN3B6eW9TR2x4R01H?=
 =?utf-8?B?TXU0dzdRZUZWQW5KV2pwa1pkdHUyMndtQ2x0aFpjVW1mMVZQK25kYXJranNX?=
 =?utf-8?B?SVJhV1EwY3RUcXlGaG9EakpLdSt3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <19CD26E68A512845BDC8DBA7215889A1@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f46cca07-f27f-4617-ae16-08dc9a9f5f12
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 14:00:46.4817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w4yZ5QHjoK4SdXWbXT63C4Wkeq5amp+pUuwe/rGhlJyMXGTNjzcYi+No/chObWffHNHxkdS0pCXOuSrzzUXU/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3652

T24gVHVlLCAyMDI0LTA3LTAyIGF0IDIzOjA0ICsxMDAwLCBEYXZlIENoaW5uZXIgd3JvdGU6DQo+
IE9uIFR1ZSwgSnVsIDAyLCAyMDI0IGF0IDEyOjMzOjUzUE0gKzAwMDAsIFRyb25kIE15a2xlYnVz
dCB3cm90ZToNCj4gPiBPbiBNb24sIDIwMjQtMDctMDEgYXQgMTA6MTMgLTA0MDAsIE1pa2UgU25p
dHplciB3cm90ZToNCj4gPiA+IE9uIE1vbiwgSnVsIDAxLCAyMDI0IGF0IDA5OjQ2OjM2QU0gKzEw
MDAsIERhdmUgQ2hpbm5lciB3cm90ZToNCj4gPiA+ID4gSU1PLCB0aGUgb25seSBzYW5lIHdheSB0
byBlbnN1cmUgdGhpcyBzb3J0IG9mIG5lc3RlZCAiYmFjay1lbmQNCj4gPiA+ID4gcGFnZQ0KPiA+
ID4gPiBjbGVhbmluZyBzdWJtaXRzIGZyb250LWVuZCBJTyBmaWxlc3lzdGVtIElPIiBtZWNoYW5p
c20gd29ya3MgaXMNCj4gPiA+ID4gdG8NCj4gPiA+ID4gZG8gc29tZXRoaW5nIHNpbWlsYXIgdG8g
dGhlIGxvb3AgZGV2aWNlLiBZb3UgbW9zdCBkZWZpbml0ZWx5DQo+ID4gPiA+IGRvbid0DQo+ID4g
PiA+IHdhbnQgdG8gYmUgZG9pbmcgYnVmZmVyZWQgSU8gKGRvdWJsZSBjYWNoaW5nIGlzIGFsbW9z
dCBhbHdheXMNCj4gPiA+ID4gYmFkKQ0KPiA+ID4gPiBhbmQgeW91IHdhbnQgdG8gYmUgZG9pbmcg
YXN5bmMgZGlyZWN0IElPIHNvIHRoYXQgdGhlIHN1Ym1pc3Npb24NCj4gPiA+ID4gdGhyZWFkIGlz
IG5vdCB3YWl0aW5nIG9uIGNvbXBsZXRpb24gYmVmb3JlIHRoZSBuZXh0IElPIGlzDQo+ID4gPiA+
IHN1Ym1pdHRlZC4NCj4gPiA+IA0KPiA+ID4gWWVzLCBmb2xsb3ctb24gd29yayBpcyBmb3IgbWUg
dG8gcmV2aXZlIHRoZSBkaXJlY3RpbyBwYXRoIGZvcg0KPiA+ID4gbG9jYWxpbw0KPiA+ID4gdGhh
dCB1bHRpbWF0ZWx5IHdhc24ndCBwdXJzdWVkIChvciBwcm9wZXJseSB3aXJlZCB1cCkgYmVjYXVz
ZSBpdA0KPiA+ID4gY3JlYXRlcyBESU8gYWxpZ25tZW50IHJlcXVpcmVtZW50cyBvbiBORlMgY2xp
ZW50IElPOg0KPiA+ID4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvc25pdHplci9saW51eC5naXQvY29tbWl0Lz9oPW5mcy1sb2NhbGlvLWZvci02LjExLXRl
c3RpbmcmaWQ9ZjZjOWY1MWZjYTgxOWE4YWY1OTVhNGViOTQ4MTFjMWY5MDA1MWVhYg0KPiANCj4g
SSBkb24ndCBmb2xsb3cgLSB0aGlzIGlzIHBhZ2UgY2FjaGUgd3JpdGViYWNrLiBBbGwgdGhlIHdy
aXRlIElPIGZyb20NCj4gdGhlIGJkaSBmbHVzaGVyIHRocmVhZCBzaG91bGQgYmUgcGFnZSBhbGln
bmVkLCByaWdodD8gU28gd2h5IGRvZXMgRElPDQo+IGFsaWdubWVudCBtYXR0ZXIgaGVyZT8NCj4g
DQoNClRoZXJlIGlzIG5vIGd1YXJhbnRlZSBpbiBORlMgdGhhdCB3cml0ZXMgZnJvbSB0aGUgZmx1
c2hlciB0aHJlYWQgYXJlDQpwYWdlIGFsaWduZWQuIElmIGEgcGFnZS9mb2xpbyBpcyBrbm93biB0
byBiZSB1cCB0byBkYXRlLCB3ZSB3aWxsDQp1c3VhbGx5IGFsaWduIHdyaXRlcyB0byB0aGUgYm91
bmRhcmllcywgYnV0IHdlIHdvbid0IGd1YXJhbnRlZSB0byBkbyBhDQpyZWFkLW1vZGlmeS13cml0
ZSBpZiB0aGF0J3Mgbm90IHRoZSBjYXNlLiBTcGVjaWZpY2FsbHksIHdlIHdpbGwgbm90IGRvDQpz
byBpZiB0aGUgZmlsZSBpcyBvcGVuIGZvciB3cml0ZS1vbmx5Lg0KDQotLSANClRyb25kIE15a2xl
YnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlr
bGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

