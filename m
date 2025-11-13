Return-Path: <linux-nfs+bounces-16343-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBA5C57D28
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 15:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 111C14E3B3A
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 14:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A0C26C3AE;
	Thu, 13 Nov 2025 14:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WRUqFKRE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pjhdw2I9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5E3262D0B;
	Thu, 13 Nov 2025 14:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763042530; cv=fail; b=IVW/Df+Ns+vIGOTfcZiDPiNRXIb8MKQgeU57W27sgHt73H8hBj+gI72rwBVHRHTxZk3DzsL3hgwxL76QWvGrRGgubkzTllCg6HFj2xZUBLEu+yYmDSrt7ba2wMLzWXMeH4tqaFogVs8mAxrSJGzl7c30S5KW/W1al2mkRjyg+gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763042530; c=relaxed/simple;
	bh=4FTXxJIbcuWMa7r1QylTT892nOUeHeOUO+L0Q4PQjUI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=phSTrzr2otgjtl32eIQK9HWSD3DyH8yfpGRjwD0K6vz0bfiHkiU9pqWOlNIO6HtXrpeXkXDYwDQpDJ/uELzw+8PzSUDXc1KbDdvfNLDn1RX2uoudBfO1HCyfE2IJ4FF2+hz4ypuxu8wGxU55qQySAJ38Udzyqc4K+plMUUFCkfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WRUqFKRE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pjhdw2I9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADCefUd031441;
	Thu, 13 Nov 2025 14:01:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=0BISTYP1aujiZvsNinDzpFFCgrDxEG2sCdPp14yCdgQ=; b=
	WRUqFKREE6ugNZ5IIR0tm/SRS6DQT8UOO/eV5YpxqboRdltM4qXgFCj/VFu38IRP
	6/UefxkzsJywW3KkxlaEs3Sg4mdJ5O9F6DeEVxlj6mx3110t1pdbawJynbIjuGW6
	FLoasVsrd1sGt/SCgYnPHd6gux61gs/WSddj51JqLVQREzrzbLlnWUttN62CSvnM
	Eo+GiTLeyqJYpKx8dnQwngeHnXJFgY/Z8CN3VsSixq2OokvJwQDIa8UFYxPxoxXu
	f3OyVzZuSR2iLBtbvg3uj58jKL703zz7MDUpOMEKeVfvmWT7j3Q49nJhyAkXFF62
	WTyZ9/VJlm0TjjrXbhSxLA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acyra9rms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 14:01:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADBuAKO010946;
	Thu, 13 Nov 2025 14:01:34 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010006.outbound.protection.outlook.com [52.101.85.6])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vanx4r0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 14:01:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wEPY6YytaJ+kh7J05PGOh/sUEczVGWbnxOfgZlc0ZyrG416k5wWsZtFovD4JwDnS+q4hrquwAbIhbnCu0pTGaQ20k5hlP+w8ZFnAX3z+n5J6BY4x3FiInVgErco+rmR2B8i602ZuTu1zCI5ljPcTpSJUTgRo3KJNHbHnFn070ul4FPw4Y2ySnEYE5XSzGSofPVYjBp8qsUdU3zCnKzQpLnL+AONo/A1ACV4HP6aKVmQVK/9tOxCi3SIo9o+QmqBBeGmTXbHESRLZm1ykwkOPKZCEjxkWIqamAIhj6P0gsXfE6euHMVuNLW9i8cWbN/FIwgTXlgjXTD/pJEXZLOx8JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BISTYP1aujiZvsNinDzpFFCgrDxEG2sCdPp14yCdgQ=;
 b=YLq4L5wGbmbv+1esQz7jQxQiA9pjbU1c9wVZWnUiJ0jemD7qZLjgE8XFEwpz564+4wu5fz3tNOlJnvh65muLP8fybErlDXnEqe8DxJ54VhSdABhE4EtVcpLxKBDCnQxI7T58FzH1ilgMrzW7Hao0FA3TkapSrMWlbO0AGdMivOnXD49r39PJ3zMbzDhtprL5kTub/TL8WYOMaHFuOhBeCjbSZz6xr1xdcZEKWwRQa6vCJ8VPtK8rORAc8is/s4OUFoef6eii08q9Fg/4rfJXHW/nyMlfJ0UFpUv+f0NUVyJeP741v9uTWfQn4mh5+Rd3Sck88hM4nw9z8ROBi3Y2BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BISTYP1aujiZvsNinDzpFFCgrDxEG2sCdPp14yCdgQ=;
 b=pjhdw2I9zvmRN6CpcRuh2/Qyd1mPaQ/K8k789F75caI4z0kqKRNYtU+fpVPO2k0NCQ117PZ/iH1SrTaaiLyzgJLRVCB+jjVdkR51G+1yw4qVOssK54iMEJ2rvQzkUuzYHX0XrUkU0SVI0CKdv9/ddAOyKjEH3FUaMsC1Qf6TZg0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB6328.namprd10.prod.outlook.com (2603:10b6:a03:44e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Thu, 13 Nov
 2025 14:01:29 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9298.010; Thu, 13 Nov 2025
 14:01:28 +0000
Message-ID: <0d77853e-7201-47c4-991c-bb492a12dd29@oracle.com>
Date: Thu, 13 Nov 2025 09:01:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] net/handshake: Define handshake_sk_destruct_req
To: Alistair Francis <alistair23@gmail.com>
Cc: hare@kernel.org, kernel-tls-handshake@lists.linux.dev,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-nfs@vger.kernel.org, kbusch@kernel.org, axboe@kernel.dk,
        hch@lst.de, sagi@grimberg.me, kch@nvidia.com, hare@suse.de,
        Alistair Francis <alistair.francis@wdc.com>
References: <20251112042720.3695972-1-alistair.francis@wdc.com>
 <20251112042720.3695972-3-alistair.francis@wdc.com>
 <49bbe54a-4b55-48a7-bfb4-30a222cb7d4f@oracle.com>
 <CAKmqyKN4SN6DkjaRMe4st23Xnc3gb6DcqUGHi72UTgaiE9EqGw@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAKmqyKN4SN6DkjaRMe4st23Xnc3gb6DcqUGHi72UTgaiE9EqGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:610:b1::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB6328:EE_
X-MS-Office365-Filtering-Correlation-Id: b16ca88c-5dd3-47ee-9d1b-08de22bd245b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WmRxM1h1Vi9rNkxyYUJNTDQzdzJER3ZJaENjbWJmZ3NINER2YTBpdm1ldWF2?=
 =?utf-8?B?MzlIdWtVYzFIMVRWa3hOTkFObkphaDlLVW1uSmozd3JzZXVXOVlYR2NlUVVK?=
 =?utf-8?B?bnp1clBrMTNoUXU5ZnlXbkhUSWxNc3RWc3ovN1dGKzZiY0sxTHA3dWR4ajRU?=
 =?utf-8?B?dmNMcEV6ZzIxdkJWbldTRU43eFlqaEo0cWRMYWZPVy9xUjNYOEJsN0x0dkF5?=
 =?utf-8?B?bG53VWJMa09uSzlHSFo5c3BKNVJXU2d1YTEyYWxCdEtMRjNwUnJGL0c5NDFx?=
 =?utf-8?B?ampTU004SW4rakZ1S0NJQVIva0VpbDllMmlrY004REZXRWptdC9kR1JKc1ls?=
 =?utf-8?B?K2c2KzhnN1o2OWJhaGlzWlBNaU9TbU1FaTd5LytObHdGdE5rOTJqY01WZ3Mv?=
 =?utf-8?B?MmFhaTdpTTRBdGhxQngvdzdyRHlJN2FCOUk3bWRvUDhWcDdKRWdNVituV3FN?=
 =?utf-8?B?czlYTmNEM0o0TXFKcXdzaW1OclJ1WFJjUmZKTWVISVVQRzBRL2F5SWFSVDZB?=
 =?utf-8?B?V2ViZ3JId1BaZ1B4YTdETUhIZEk2MVJTWWRXVWtGSmtMeDdUNGRLTE5tYWFk?=
 =?utf-8?B?LzhTTm1NSjJPVS9QNXRWQXBRdm9COGR4RXQzV2dwQ2RJN3M2c01TUzcwdSto?=
 =?utf-8?B?VmpBSlo3dlJ2ak9SU1dHK2dmbkYxaHdhNmJIU0V4aFhKTWd3MXh1U29HZEYv?=
 =?utf-8?B?S0YwQlJPSktDaXd5MjJpek5ZdjdsbkhVZUpKNTdOVXNrY2piM3dWcEN5YXlo?=
 =?utf-8?B?aUVQalpjU0ZvbVpVMDVUc2YzUE9OTzhQT2JVUkg2MnpoaWJNRFFDb0Z0d0RB?=
 =?utf-8?B?SC9objRQSnlCZnVqbVp4SjE1Nk1rRUliUy96YU1wcU5ORkQwaUpQSmNDV3k3?=
 =?utf-8?B?SUdabnBOVHJMZTFWOHBEKzRldGFVb3dka3lMdkNRRW53UjBJb0EwN1BNUXN5?=
 =?utf-8?B?RHBiQ2NhR1JxdWMvK3pwZ1JWd0RVeEorRmtuSlpUWER2SDVDZUNTMzhkOTJj?=
 =?utf-8?B?UVYvTXZEejluNEFiSnMxbXVlZ29RQnNncExDYmkvc0pTREZPNTlKL0pBUXhp?=
 =?utf-8?B?cG8zTktyczFIVmI0c3lmQTVYZUZZdHhFaVJmQ3M1NXJGeXZ1dk4zTlFDTjNk?=
 =?utf-8?B?d3liVkx2NHBqVDNqL3QwU3JsN3IxR1hCaHVYRmltSFlaTnNGTTQ2bDhiUDlD?=
 =?utf-8?B?eGg1LzEvN3hVNVV4YU1maXFVelN5MVZ1ZlVRc2xKaXVPMy9hZzZ4UUhURG84?=
 =?utf-8?B?UWxxSnpuRG1jYldyeitOMkQxZElHTHV5Zkc5SlhjdlQxNVZGMDZSNzBtVm0z?=
 =?utf-8?B?Yy9EOXcrVHJMWVI4RTk3dUxuNXNhR2dGNnpQQVlxM3NkQS9mVmVKSUVwMXRa?=
 =?utf-8?B?aDRQc2o4bTVtYW55YWxkMmY0NGI5TkhxblAvY2RzcDJaUlJJUXFFd2prK0lY?=
 =?utf-8?B?YTd3cmxSQjBuN3JpR0x4d1pPY2dTdHowL3ZETlNDZUpzVWgyR2RtMlQxSm9F?=
 =?utf-8?B?bnl5blpUaXA3WFBRVkRDcC9vK3RweUVJVGVDdm5aNEczUEZWMkJVUGhkNjFw?=
 =?utf-8?B?dWxqdHBnSjJzYi9oTVBGU2s1Rms5Qm51UWNJMFNFL1c2MzZPRXR4anMxT3hi?=
 =?utf-8?B?TkJISCtmNGlpcG1GamhaTng0ZDNyWTZDWEVrOFgzbTEwZ1c4M1Y0VFFINmNB?=
 =?utf-8?B?Z3dNanpnVnRmU2dpZXZaTDl4QmpkVmJaMjNkUTVtQVhsTEVyQUNwUmp1SjhR?=
 =?utf-8?B?MDFGc09aYlN6Q0VvNHBNTzhhRVZYUmdMaG5Ic1JNczB3UWQ2TTR6ZkdnOXM1?=
 =?utf-8?B?UHJHTVFKbFNQZWhHUlNINVBWeXZVV0xUVWppUXhmSjBqaHZmOVEvUTE4bWRk?=
 =?utf-8?B?K0RRVGRUejhyM3FWYVVzZGcvQ0dVclFObElLUzBuLzdHNklGdUFZRnJrK29y?=
 =?utf-8?Q?TRbOgsaNO/NB6mrq7k2eTWKE65bbnyO6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGRBNjJRalFqdENCR1B4OG13VmFFL0xkRVp4UnYyYmpsK2M3bDlMcHRzOWow?=
 =?utf-8?B?ODcrUmtiVC9BdUJKZXpNUXFPL3JNdzBZZWIyTlRMS25HVURacUNJNkEwMWIv?=
 =?utf-8?B?ZHdYRm1xUFh4YUJqaUFhcTV1UHV6ZEJ1OFg4dDhKZk1LWlBjRzBscmxhbHdt?=
 =?utf-8?B?MmdsTGlVM28zZEdsam5TZGY0d2F3QmJFNGx2S0hWMnlhdFRxZkdJSzRYOTBE?=
 =?utf-8?B?alFmdCszSDZhV3NQVXMxaGpnSnF5M2pibUhIMlZwZ3NNQWJiU0cyM2dvNGtU?=
 =?utf-8?B?SENvNzJKL2kxaUV1cGdvR0ZaaG05UGNLcWh2c0RzWkVySnIvWVZaekp1VXpC?=
 =?utf-8?B?aUJlMHkvQjN0M0Z0QlhDeHZQZlBLNEx6cFRvK2xRV3RJRU9MZ2Jxbm05OHls?=
 =?utf-8?B?SmhTcVcvZTA0MWtETERpSnF5ekErcy81Zjc5SjBoby9qdTk4RGhVc09kWDUw?=
 =?utf-8?B?Um4zWFRGM3ViMXBhVTk1MU42L0xSZlFOcWNidm1jYncza01WbzZEREYwUmdH?=
 =?utf-8?B?UTMrTWlWZTN0WlRaaGxpYUkwOEMrSitHcW1MM3RNeHM3ZGFtOFBHTHJFK1N3?=
 =?utf-8?B?VmxuUjZ5TzgvTHlPZGZGejB1a1VFVkY3bmQrcm1qRjJXYXpsNzI2Z3FOU1Ix?=
 =?utf-8?B?bVVlaHkwK3RuTFNKYTkyK2VWQ0xaN2E2cmZTelJ0R3ZoMW50eitKOTBBdTE5?=
 =?utf-8?B?eXE0ZVRrT05PeFBqK0pPR0p3ZnE1VXd4amd1UVVmYWpMNS83K0tlWTJndEVN?=
 =?utf-8?B?LzJCRjhlV21UV1Ewc2VsTkgxSlA0OHlaZTUwS2gyaWM4VDA1WjRTd3dWYzVP?=
 =?utf-8?B?SDZ2WXpGZHZVMXE3Zm5VNTZrc3YvL1U4OG1mZ3g4QkZ4QzI0RHlBelpUY1FS?=
 =?utf-8?B?b2s1ZWdFUGF5SEl3eVFZcnliV0VRdUJhTnI5dHBUZWdoa1RxSWJPSkJxNkdl?=
 =?utf-8?B?U0Q1aTRRWXZaMFpmcE5hcER2eUhpK1pTa2RxcEhwWktKZlpkbG1iNXZpdXZk?=
 =?utf-8?B?MUxFbjJsQkFrSjBoUkdtTmZOUm9sZjNoVTZaRWl2aVV1OVdkLytSZEpwSWxm?=
 =?utf-8?B?clV4cnZuSm5OMUQ4VmllUUVxTHJjL3Z3L3pBVzFjMFgxUlM1YlZxNVQ2bkRV?=
 =?utf-8?B?eG9tdzB3dU9UeTJpVndWM3NNSWpoQjc4MGZaRU12T0wyOEdkMEhTMFNLWFV6?=
 =?utf-8?B?bGtIeHlWNjhhT01NT3hZdmFFOHBMU1htVzF0Tk5uUDdMUnBtWlZaNlpGMFdO?=
 =?utf-8?B?MU1UMXRDdkdTOWlFQ0t4cGdsWHFPQ0RzNkwyUjg2TnNLR242bHhVb2Rrc1FW?=
 =?utf-8?B?V25QVnU3NTJMS1E3SE9SRFRscy81NUdJbEZzSGxVOVFNZDU1UGNoZ1RhSldt?=
 =?utf-8?B?TWdZZ0hBRnM2TkhLbjZtUzlpTFJPbVQrdFVGL2Y1ZDRmNWJxNUh0dXE1K1Rz?=
 =?utf-8?B?UkgrZHZJVWwwelVVWFdPR24weEZMdzNUS3kybUhSZDY5SnBDR2hsdkhCaGY0?=
 =?utf-8?B?ZExJTEJnblJ4TGdxd0hRbkhiVVdxdUI3d0JYenpubTJCT1NHMFdzZjYxS2t4?=
 =?utf-8?B?MDFiTVNld3ExT2pzNzJRanlSV1l4UmkxN0pqeEN2ekY0OVF4cldXczUwZWxF?=
 =?utf-8?B?YVhPTEM5UjFJaEEzR3d3YVA0b2kvTzA5MzFqUENCM0RsVE1BWnlGUnppRGQ4?=
 =?utf-8?B?TEMrSXY4Tk0wODhPZXpuWnFVUzV5UXpNUlVaYTVFcWkrRm00M1Nyd2NoMFcr?=
 =?utf-8?B?SzZDYVNPZHdDNHE0aFczMEw5VU1kMFBYL21Lczl1azZzOElTWUp5ZXJzOTRs?=
 =?utf-8?B?UzRGbElXdnpTQjJ5Q2cxcERpMzJaaG54blJlcnJXazhUY2Y3NGlHRnd3NzFN?=
 =?utf-8?B?OTRFamtZUjVybThUL0Rjb2FzWDBmZnppTDRlN3hUWmN3dGFQOWZxenMzQ1ZZ?=
 =?utf-8?B?QXVBak9Ja0RtL1UwV2lNTzZCcVdzZzhraDQvNTJ4UXdlejNZMUJaU0NiNzE1?=
 =?utf-8?B?NFR5R1NWKzdWK1hxQnh6YXJHdFdNMmdBOXhRMEgyNUdaemgrMitvL25XbG9k?=
 =?utf-8?B?L296cUF0YTgzOGNyZE40QmVnNVdNVzhjS0VEWnJSM1NkcWxua1hsMjBBMUpH?=
 =?utf-8?B?S2ZsN0hHN2tmQ3p2Qm4wVXZtMTBnVGNwSDJKWjRydmpnL2JWRWhDQkF3TEJj?=
 =?utf-8?B?WWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/wfrV1ZjV3uwQHXj1iZ4v61pi7E+hgJjWGFoNOaedgUEZkUp1JD+YeL5LknJAN02VpAb20BA++DUOS4mcGcWpBzeewYoMGQWEG6+274izSgu30yIHDfKIiJ5Fk07YRaR4hL6p7TaxZSAPqcYsesIfv6LSZzr01dNWr4DxKXzDOC+1ho0zcHaI+Q3LlIROR+E0wm96iA7jFEHg1Ph67c047H59+TxPj96ZCgWJk3MudiX8ZalmaxvErg1h5sBnoMNOKiu4ivvAR9fHuf+YcsFlqRbyz3j/J92g4kGnlnolXnO7BwhUANCexA4Ko+1SIaWJ1Bzv2apELRbQ6WAMACFpGj5k8+iIqsjyl7oWCtPCMVzibvXZ5XX8uZYqK69BzyRewQqTkJveA6wrUhOAWnKitLcSV06jW3IjiJl/ExyaTWc90xQZKU347xbSWiEAQqdC5gfdIqcw95R7mkqtntafxycMQXVz9vCBpUYwg6LulCVem3EqmVtpiHVrFF4LlubUKa9wW2LiZlQKj9j+228KIGDAR4IVnWRFmksr475RXiCf5P2TcKU4t666anokmPETO2R9ys7t+fK5aK3vnh+nTlBJm5TrvrBSSlAz87cr6Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b16ca88c-5dd3-47ee-9d1b-08de22bd245b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 14:01:28.8685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8RbeYk7jJg6oGnL9OQ/JXaB5ijUMuDrXTqQl6m543UJH8stDWcazdIbLT2Y5NHhVRsRkKaPfzA23odhQ70V9EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6328
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511130107
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE1MSBTYWx0ZWRfX5AR0CuoLRwcd
 +hExxudCrLl4l+UTkHbiMay/vDHytxcyD+8YdJb98zzCTaaUSY/SeoyO/BOR1Z7h7zgqE2ED0jH
 jIEbHbomMm9ToMzbd0AOUvHAX5CudYbJj1MOGvxAAUQNyuPz8uveQaq5xQromtHqzMrCVLfCCCB
 ZjygOCmUNcNjlUka6rL3p4othYOb/K5p7kKVFIHp01Q48pBT/uB6r2gj9uuzGuFxxhQkl/WCt+F
 2LQyvNeFNdlU/UHCm1BRksIoDjTgnOawnPn3MjKQj0h+IzQXQkjmEWlSc2UhmdswyJrmvgKBJI/
 8dKWN3QE5k0u+vzFsInGzPEsKXsYPXUxuVS3A1LQTRVZeLs6wXt1DfuErL3q9g=
X-Proofpoint-GUID: oyoY-LYlXTpd3DFOzBzwRcX5gLKzJnHv
X-Authority-Analysis: v=2.4 cv=ILgPywvG c=1 sm=1 tr=0 ts=6915e4bf b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8 a=JF9118EUAAAA:8 a=o8qdKif7_mud3cy4cRsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=xVlTc564ipvMDusKsbsT:22 cc=ntf
 awl=host:12100
X-Proofpoint-ORIG-GUID: oyoY-LYlXTpd3DFOzBzwRcX5gLKzJnHv

On 11/13/25 5:19 AM, Alistair Francis wrote:
> On Thu, Nov 13, 2025 at 1:47 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> On 11/11/25 11:27 PM, alistair23@gmail.com wrote:
>>> From: Alistair Francis <alistair.francis@wdc.com>
>>>
>>> Define a `handshake_sk_destruct_req()` function to allow the destruction
>>> of the handshake req.
>>>
>>> This is required to avoid hash conflicts when handshake_req_hash_add()
>>> is called as part of submitting the KeyUpdate request.
>>>
>>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>>> Reviewed-by: Hannes Reinecke <hare@suse.de>
>>> ---
>>> v5:
>>>  - No change
>>> v4:
>>>  - No change
>>> v3:
>>>  - New patch
>>>
>>>  net/handshake/request.c | 16 ++++++++++++++++
>>>  1 file changed, 16 insertions(+)
>>>
>>> diff --git a/net/handshake/request.c b/net/handshake/request.c
>>> index 274d2c89b6b2..0d1c91c80478 100644
>>> --- a/net/handshake/request.c
>>> +++ b/net/handshake/request.c
>>> @@ -98,6 +98,22 @@ static void handshake_sk_destruct(struct sock *sk)
>>>               sk_destruct(sk);
>>>  }
>>>
>>> +/**
>>> + * handshake_sk_destruct_req - destroy an existing request
>>> + * @sk: socket on which there is an existing request
>>
>> Generally the kdoc style is unnecessary for static helper functions,
>> especially functions with only a single caller.
>>
>> This all looks so much like handshake_sk_destruct(). Consider
>> eliminating the code duplication by splitting that function into a
>> couple of helpers instead of adding this one.
>>
>>
>>> + */
>>> +static void handshake_sk_destruct_req(struct sock *sk)
>>
>> Because this function is static, I imagine that the compiler will
>> bark about the addition of an unused function. Perhaps it would
>> be better to combine 2/6 and 3/6.
>>
>> That would also make it easier for reviewers to check the resource
>> accounting issues mentioned below.
>>
>>
>>> +{
>>> +     struct handshake_req *req;
>>> +
>>> +     req = handshake_req_hash_lookup(sk);
>>> +     if (!req)
>>> +             return;
>>> +
>>> +     trace_handshake_destruct(sock_net(sk), req, sk);
>>
>> Wondering if this function needs to preserve the socket's destructor
>> callback chain like so:
>>
>> +       void (sk_destruct)(struct sock sk);
>>
>>   ...
>>
>> +       sk_destruct = req->hr_odestruct;
>> +       sk->sk_destruct = sk_destruct;
>>
>> then:
>>
>>> +     handshake_req_destroy(req);
>>
>> Because of the current code organization and patch ordering, it's
>> difficult to confirm that sock_put() isn't necessary here.
>>
>>
>>> +}
>>> +
>>>  /**
>>>   * handshake_req_alloc - Allocate a handshake request
>>>   * @proto: security protocol
>>
>> There's no synchronization preventing concurrent handshake_req_cancel()
>> calls from accessing the request after it's freed during handshake
>> completion. That is one reason why handshake_complete() leaves completed
>> requests in the hash.
> 
> Ah, so you are worried that free-ing the request will race with
> accessing the request after a handshake_req_hash_lookup().
> 
> Ok, makes sense. It seems like one answer to that is to add synchronisation
> 
>>
>> So I'm thinking that removing requests like this is not going to work
>> out. Would it work better if handshake_req_hash_add() could recognize
>> that a KeyUpdate is going on, and allow replacement of a hashed
>> request? I haven't thought that through.
> 
> I guess the idea would be to do something like this in
> handshake_req_hash_add() if the entry already exists?
> 
>     if (test_and_set_bit(HANDSHAKE_F_REQ_COMPLETED, &req->hr_flags)) {
>         /* Request already completed */
>         rhashtable_replace_fast(...);
>     }
> 
> I'm not sure that's better. That could possibly still race with
> something that hasn't yet set HANDSHAKE_F_REQ_COMPLETED and overwrite
> the request unexpectedly.
> 
> What about adding synchronisation and keeping the current approach?
> From a quick look it should be enough to just edit
> handshake_sk_destruct() and handshake_req_cancel()

Or make the KeyUpdate requests somehow distinctive so they do not
collide with initial handshake requests.


> Alistair
> 
>>
>>
>> As always, please double-check my questions and assumptions before
>> revising this patch!
>>
>>
>> --
>> Chuck Lever


-- 
Chuck Lever

