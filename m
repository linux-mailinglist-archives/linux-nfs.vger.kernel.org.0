Return-Path: <linux-nfs+bounces-4951-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B88C493297A
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jul 2024 16:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBD0C1C229EF
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jul 2024 14:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A27919E7C6;
	Tue, 16 Jul 2024 14:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="e5UEdScq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2104.outbound.protection.outlook.com [40.107.92.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD2619D881
	for <linux-nfs@vger.kernel.org>; Tue, 16 Jul 2024 14:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140641; cv=fail; b=OJuK9/W580hVK2PW445cshGQpRbzAYrPz50s86B54ba7qD4TBcl4xaVEzR4tnPN8nA2DKOKHrMYCXmHPzy0LYMr6tAFCDhgTUyNTpBA0ETfZ1TWB/9LHrWR7OOxDljo7wu3RIhGbIdRsslw4LI2+PC7CfoCQCDX807t2xgN2IcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140641; c=relaxed/simple;
	bh=ZDAdet102Uxv1x6V6QAx37O5AFJSgEZSKDx53iUqrqI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JXV5Gw/jFoZwtSfvwEV1hAdTEvsC12lqfoCpNwhlw3Yt4+7QrHbe42TVJa3hGAEQMTgZ75ZzqSNa5278VNffZAmlu3L98TnQVJC4AuptucsRv4T5xtGXAR1T6Q71LTu1/Diqq8kC+MdQc5GzbvS05tOS6h5NDvKcpqy9FMM6fyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=e5UEdScq; arc=fail smtp.client-ip=40.107.92.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x9NJAp+jz4qQCR6/TQt4uZWodHfIXBSM4sqF6lr87ciqZTUI0iamUU+8VrnzHCkFcl4AlNaSTUziOmUMC0o6YNvamdmEM0joJqv/ZMR760B46w506nBd8J0h+K0daNkP0/LExnmuY/RSsLyC33ufzY8XSdJagWIAD/5K9PiXg1R/Nn24ik/Vz5hnvaFMXONmHqefVHEDa1xHb302krKZH7Stnlajj2a5tnIEI4AE4mD5STb9nLBPqjGTej61hm96gzH55TpC8vcdypBWyCgwRc/5ZfKm+a1PnYYwRJdLvRb12lFKTp9PdoFmMLkNzRZsuu8jAULrNniobJ0jJDoIjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDAdet102Uxv1x6V6QAx37O5AFJSgEZSKDx53iUqrqI=;
 b=eBXcvwfRCDeNub1br983fowp1cnoWBiaU8bZ1OO5/AowUBtGLXTkXOwZwI4QaRJda3uD4R5apILLXOz5jt4kzNW0yXKvyCxKJNdIUgfCf+pGWLS09B++hopdr+PetL05zDLc6mtJdpi99c1l8Ty0yf6cU3JyOeVfd5iDJuFuoJRArNiMT7VceU7bdyPSJD6SRngKfAErHb9dO2k9ltF1vqDJKX5mR8Ek/G7whhsDQEchfHo56BN92AXSOf32g1u6A1O6apdVxAiCbTBNcjBKyPgi0uxl5zZi4lpjpiun8JqAbOKn7ZoAe5pVeYzI6/P/H5uCVH3dY9yBjl1T0bZncQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDAdet102Uxv1x6V6QAx37O5AFJSgEZSKDx53iUqrqI=;
 b=e5UEdScqaV84TI7LFZar73PN+6hxrCOCXlsilVM1/trrDLH5/4v+0zFUNriM0Vh/RXT0JKPFTOSvaq7kKFxUma/8yBF3yYTf7YsNlNIkwZAb9gBNS0KN52nFkDyH9jSmHUWC4lFr1NPiJdCJ/n3ngFCZL/BEE7ws1Q+vzW7nYK4=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SA1PR13MB5441.namprd13.prod.outlook.com (2603:10b6:806:230::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 14:37:14 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%6]) with mapi id 15.20.7784.015; Tue, 16 Jul 2024
 14:37:13 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "bcodding@redhat.com" <bcodding@redhat.com>
CC: "anna@kernel.org" <anna@kernel.org>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: Fix a race to wake a sync task
Thread-Topic: [PATCH] SUNRPC: Fix a race to wake a sync task
Thread-Index: AQHa1GMoMJaBbWI/xkiq3cOP8YqYiLH5XdyAgAAGB4CAAA6gAA==
Date: Tue, 16 Jul 2024 14:37:13 +0000
Message-ID: <b8b9fa14bce200fc65545b4c380ece3275e13677.camel@hammerspace.com>
References:
 <4c1c7cd404173b9888464a2d7e2a430cc7e18737.1720792415.git.bcodding@redhat.com>
	 <2525dfa8b9a5539a51109584bf643dcbdcc5f1a0.camel@hammerspace.com>
	 <0DFB851E-CEC5-45DC-8C61-CEE6D6DCC9FD@redhat.com>
In-Reply-To: <0DFB851E-CEC5-45DC-8C61-CEE6D6DCC9FD@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SA1PR13MB5441:EE_
x-ms-office365-filtering-correlation-id: 30a83d12-cd0c-4555-31cf-08dca5a4c874
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c0M4Z2lrTk9DbDZ6TTdqTFc0aVFXb1BadGlJZnM0MURpNUJMZzlxOXFYbEkr?=
 =?utf-8?B?V3JUZFo0WllaaTVzU0N6L1RjSUdId0c4M2J5MUJuRVlNL3YrclVSZlFxcyty?=
 =?utf-8?B?aWFUNlVkRnh2SDU3b1dQaGJhQU0vWUdDYzlwdlBEditHOFNGTWIvaC94UW5K?=
 =?utf-8?B?YXR0Rms5YlU5b0gzN2FsVFl5Z083RC9FdXVWMEJzMlRyV1o0SzdpUklod2sv?=
 =?utf-8?B?L0x4ajcvYnpCdjNSL2hLZmhYajJiQUlGQlFSbExpRGROZklrdHBPRzNjWlJr?=
 =?utf-8?B?WVZHa3g0c1FqcjRCY1dlblpWSWl1Vi91ejQ5eW5qeEtYVSs1akVWVmtuTWEr?=
 =?utf-8?B?Q0hMN0laeU04dWYyTEhyRlh2N3lQRVJQWlZyd0FRSWwyeTBBSVU2YTdXaUsy?=
 =?utf-8?B?UTlkRGpUVS9tWHRUa1dueUtUTkh6M1hGb1loK2ttZk15MW00Z0ZkRzRRNEVk?=
 =?utf-8?B?cTYxakxiMkllNDBhdEc0K1U0L3dPR0FSblM0WXVUK0ZwM1JuTmRxSzJtNzNl?=
 =?utf-8?B?UVJidjJtTXBWaXlHUXRWb2dMZGlsNDVsdGIweVJXUXJ2eVNDeWt2Vkw1ODUv?=
 =?utf-8?B?aUhDZmU1cTIvZFVrNU1rbHdHd3IxWkFZZVVFemxSRzh0QnFqY2s5SFJPd1Fm?=
 =?utf-8?B?VkFCWG1kVU5tbE1wM1E0MG5xMm1XaGthK24zWXZGMG1PTVB1T1ZuemRwZklD?=
 =?utf-8?B?MTJEdW9SRnUzMUtSRVpQWUxjMnAwai81eUZFRWFHbG1PV00rR1psTVdnbDg5?=
 =?utf-8?B?anVsNjIxRGorZFJMbVFBeFJTc0JoeFFyRXFPeW1UN1dMTk1nMmcxS21MVUEz?=
 =?utf-8?B?b3c3MXBBY05CMmpXYWJNZUVZWmhPUUdSUDJYY2FNbUxMMHlIM0ZmRVAyMFR2?=
 =?utf-8?B?WjlqSG1uRThNcUZzcVNoYzlkV29PbG5wUkpsbmVlcUNheXJVWEU3ckk3enZa?=
 =?utf-8?B?YWtsSTcwWWRHWERDUHpQWStMa1JEVTNhdCtRbmdSS0RtRjhhZXpTbEZ5aFg2?=
 =?utf-8?B?VHRDdkdpSVpCclpsZHpYNldCUkRoOXVvWGJsWXJTOGJYVCt2RU9DNEFPOURC?=
 =?utf-8?B?b3BReHlFK3huTjJ6NTNId1pJejFYMytoVlF3SjBmRlFpNE1JNkxBMUU4RW1G?=
 =?utf-8?B?Q3ovdlFOWHBGRkNXVkpsQVprWXorK2U0T0dqNTYrVFlXQjU2VTdhUUNmTHZu?=
 =?utf-8?B?VjczZTRmT0o0V1p3UHJ2SzNkWWcvR1J4eFNkWnRPdFBOeGtHR3ppWmt6Sk44?=
 =?utf-8?B?SzZCOFRlMDY1bG9JdlkwcTdnTVNIMEdwcFMvRkJCb1lKOUJIWS9veDlmb2lF?=
 =?utf-8?B?S21heVBCNlpEYkIwWEQrV0pqVzVwTUZEcHhoeC9rOGhrZTBPWDhzUy81Ympi?=
 =?utf-8?B?aE1ESUhoZVhvQlEycGhKTy9WZklleXcwcHJmMVlWMWZucEpqdHVxVURuWkQ4?=
 =?utf-8?B?ekl3YWF5SkNRNTVLbno1RTE3aDlDb2pqQXNaeW9uMDcrekMrd2tWRjUzMy9q?=
 =?utf-8?B?WGFzcVZzZ3JLRyt5d3NxQjlpWFlzSXlqdVBHQmw1cStuN1U5dldSbVFib25R?=
 =?utf-8?B?SGYrRlE3QjRzUEtpQ2FnQVdhTWszTVlSWFBvUjBrVzdkekdIaHpzb0FDVWdZ?=
 =?utf-8?B?bjVSK2tBM2ZFbGRqYmh1UWNhZ093OGNoNHdNNUN6VzRDZkhiTFhYWGEvWkQy?=
 =?utf-8?B?cFdPdUZENlMvS3Z4ZUlwSzJob2RyeStYQW55WHFvZUVDd1pWbE1JU0tBc1pU?=
 =?utf-8?B?YzVUNmxmL2FTemZ6NklNNzNPN0gzWEd1MzA5M2U3Tk9vMmlkcEFIMHFGZWFo?=
 =?utf-8?B?emFwS215RWw5dkUwZUZxQ2MwMVpPKzZDVllRcEJHQmJLcXIyci9EbXI5REw3?=
 =?utf-8?B?RGI0L3ljU0ViS1JZbnIzdGxpcGNySjZBRU81NGVVcmNQSFE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WmFRVVZPQzdmQm40VGljckNnOFovdlQ4WktjUXJhTUh2QnpLSEVnZUN4eTEy?=
 =?utf-8?B?OWkvOHVTUTc1UElVUVpSSlNabnlYUGg0YUV0MmtzS3NkeTZ6TGJWR3pqNjZr?=
 =?utf-8?B?bi9HRjlsL3oyUWVkQklCN01zdDlrRXc0YjYxVXYvTVJDTXUwTlZnS2N2ck93?=
 =?utf-8?B?OEkvc2VWSDVlalpha2RXeVhLWmNjbXpCcmFNM0NudHFyZXR6Uk9jTW9Rek9o?=
 =?utf-8?B?TUI3WDdyVEUzMUo3dkZ0eHNwbndNa3l1TVcrQVRYRHhjejV1dDFTZStkZFRB?=
 =?utf-8?B?cUx1RDZPZEpyUDFTNDZGMHg2VE5JUkVkUmQ2SnFCVGRFTTdkUmhsVUlpQ1dk?=
 =?utf-8?B?Yld5Y1JWNkh6ZUxSRTB4dk1SdXFGMm9DeUkyL1NVeWQ2Qm15K1lVeTZqSGdo?=
 =?utf-8?B?cVd4T2VIbWFpRnlnNUFtS3l2WW9Ha25aWTluVUNZVkxSRHBIUnpORjFlT0Rm?=
 =?utf-8?B?VWVzc1FFMXpNeUtsbm9SNkMyTlZpa2ptdXpJL09udVcrZlRLUEQ4bXREL3NY?=
 =?utf-8?B?UUZuNmg1d1hlSmlsWHB1M2dmeTBHaHVyM2dQTlRLY1FhSGI5anhuY0VVU2Nu?=
 =?utf-8?B?WEIxbEJ4dXJTUktKS2lMUkw4ZTM5MDEzWXZIaHp4M0dleng0Q0RXOVpUSk5N?=
 =?utf-8?B?ZlZwcUE4bHpsWHhzdnVVN3YrZVdaSGVPKzlQajVKd3BTbU5Oa1o5SDk2ajEw?=
 =?utf-8?B?UGdmc3FGVFhCUHdiNUpSQjY4OGREaUw5L0NjWCsxT2lRR3hDVitSd3ZKRTZN?=
 =?utf-8?B?bjJMcU9MK1N3UUdLU0RQNHZmeWYwLzA1cm9sVGUzRjNvN1Q2WjlOREtWeVkv?=
 =?utf-8?B?WEhFcWo2b250cVBjVklXNzNLWUhXcStiN1d2amVVWmlObzY0MExON2NnVitB?=
 =?utf-8?B?OVBQSzlQQjRpcVJzU3dlc3BwZnBoY0FpSHBqaXR2Uy9YaXI1YStUM0p3VWs5?=
 =?utf-8?B?SlFuUWt3czgwZVkzdHMyd3gwNWhZbnE0c0FtWkNQUFcyTkhDeWhIbXV4UHRh?=
 =?utf-8?B?OHV3V2gzVUxhQ0ZvY0RTVlZxNmF6ZzU0OXliSmdON2tkV0hCZERnZ0lYRm9p?=
 =?utf-8?B?R0ZjT0RVTDB5aEp0MXpuMzlVeXBPcmRrYkVobmtlR2RpYkZRMFhCeDZRWnB1?=
 =?utf-8?B?Y21nT0JEcUZlQnRNcmN0dngrcFNRWktGUzJNOGFMS3E2S0Z1cCthSG9vMU42?=
 =?utf-8?B?LzlJdTlMbzQ5SVNsMHhCM1RUdk5iRzE1ZU9MekRNLzRUSC9INjlObXIwdVJy?=
 =?utf-8?B?OGs0L2NkNDJJSEFiQmxFanErN3hmSlpzT3ZZZ1RmL3E2akNWWVo4M1Q1M3Ny?=
 =?utf-8?B?akZBcmhhVitMRDZ2eDNiQmZsaVYxMTdPWmtDZG1xNG9jMmZ4clN6Qkk2L3hs?=
 =?utf-8?B?NlVyR3dBck9JRVZNY25TcE9OczUzSWdHY0FITUdabjFOMjlmMTVmbS9zbDhx?=
 =?utf-8?B?UG1zc0lzaFY1NlNWUVJTSFZkU25VT3M5VnpZTmhUY2gxcnE4Tlp3WHZKaG5r?=
 =?utf-8?B?cmJCMmd3N09MbGZBc2RaWm82VUhuelFqSWR4S3NlRDU4SkRGd2dGUU5XMjlO?=
 =?utf-8?B?NW5mSnhwSWxsdjZCYTNzbVhRSkk0TGdoNUlMWmMxM0VTUHFMbjBnSUJUM0Ny?=
 =?utf-8?B?VGNVMmx6VXNCRWRrRm9HRnpueTh5MXNPZ3lZQ0R1R0EyMnRxcW5BT3ViTGVu?=
 =?utf-8?B?aUI2Z1ZTcENWbCtaalpJWkNmRTdHQVJhZ3BzTmtlajNYU1JLUUg5RXlpSUs2?=
 =?utf-8?B?WUdxRWExZ1ozc2FUUGQvc3h5aDIvSitMb25hclBUUWRrN2FZckR3eUZsYVJS?=
 =?utf-8?B?V2RQVVdGem14ZHBTVU9YR1E0M1ZvRDY0MStpWkQ5RDkxbHhZdnV6UEh6S3Nn?=
 =?utf-8?B?VG81a2JENHRqYWhxUXl4dzhvVHpVVkptTFMzdXFNNzNCRzJueWxZdGl0RTN6?=
 =?utf-8?B?a0ZTdUFjQnVKT2t2cTBvNnZBL2w4dHFhRWlIYUtWcWpFejJ3NGtodWg5Y2Vy?=
 =?utf-8?B?WDhxSUdpMU4rcDRKUVQzUnpxWE8yc0wxQ1BnNzZ6SWcyODhjNkF2YWZ4OUpH?=
 =?utf-8?B?Z3pORjRwaUozTmxSVk84N3JIY2xOVE5zUzRXVElGSWlNYVlHRlNIaFFsSHZR?=
 =?utf-8?B?L212M1l4ZlhFUHo4TEZFRE5PYjY0cktOOW5zU2JGTHRBV0ZGdS9pb1lkZVdH?=
 =?utf-8?B?cjREeURlRzVGd2ZnempMbG9weTd4YTlrMVdpMStnQTVndnU2OHFCZlZjWUFi?=
 =?utf-8?B?aUU5SXZLaTZ4UEgzeW5IQTNrckxRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BDB6E103F2D0064FAC5F4FA060EC54A8@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a83d12-cd0c-4555-31cf-08dca5a4c874
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2024 14:37:13.5675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jcU36hwtXWFae1mA5YJz5DHUMvamkrTM2L5yw2Tp+ThTuQ6VZ4q1eDLBvDCx0wjtE8srzvo3/ksU0j3ZiegO8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB5441

T24gVHVlLCAyMDI0LTA3LTE2IGF0IDA5OjQ0IC0wNDAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiAxNiBKdWwgMjAyNCwgYXQgOToyMywgVHJvbmQgTXlrbGVidXN0IHdyb3RlOg0K
PiANCj4gPiBPbiBGcmksIDIwMjQtMDctMTIgYXQgMDk6NTUgLTA0MDAsIEJlbmphbWluIENvZGRp
bmd0b24gd3JvdGU6DQo+ID4gPiBXZSd2ZSBvYnNlcnZlZCBORlMgY2xpZW50cyB3aXRoIHN5bmMg
dGFza3Mgc2xlZXBpbmcgaW4NCj4gPiA+IF9fcnBjX2V4ZWN1dGUNCj4gPiA+IHdhaXRpbmcgb24g
UlBDX1RBU0tfUVVFVUVEIHRoYXQgaGF2ZSBub3QgcmVzcG9uZGVkIHRvIGEgd2FrZS11cA0KPiA+
ID4gZnJvbQ0KPiA+ID4gcnBjX21ha2VfcnVubmFibGUoKS7CoCBJIHN1c3BlY3QgdGhpcyBwcm9i
bGVtIHVzdWFsbHkgZ29lcw0KPiA+ID4gdW5ub3RpY2VkLA0KPiA+ID4gYmVjYXVzZSBvbiBhIGJ1
c3kgY2xpZW50IHRoZSB0YXNrIHdpbGwgZXZlbnR1YWxseSBiZSByZS1hd29rZW4gYnkNCj4gPiA+
IGFub3RoZXINCj4gPiA+IHRhc2sgY29tcGxldGlvbiBvciB4cHJ0IGV2ZW50LsKgIEhvd2V2ZXIs
IGlmIHRoZSBzdGF0ZSBtYW5hZ2VyIGlzDQo+ID4gPiBkcmFpbmluZw0KPiA+ID4gdGhlIHNsb3Qg
dGFibGUsIGEgc3luYyB0YXNrIG1pc3NpbmcgYSB3YWtlLXVwIGNhbiByZXN1bHQgaW4gYQ0KPiA+
ID4gaHVuZw0KPiA+ID4gY2xpZW50Lg0KPiA+ID4gDQo+ID4gPiBXZSd2ZSBiZWVuIGFibGUgdG8g
cHJvdmUgdGhhdCB0aGUgd2FrZXIgaW4gcnBjX21ha2VfcnVubmFibGUoKQ0KPiA+ID4gc3VjY2Vz
c2Z1bGx5DQo+ID4gPiBjYWxscyB3YWtlX3VwX2JpdCgpIChpZS0gdGhlcmUncyBubyByYWNlIHRv
IHRrX3J1bnN0YXRlKSwgYnV0IHRoZQ0KPiA+ID4gd2FrZV91cF9iaXQoKSBjYWxsIGZhaWxzIHRv
IHdha2UgdGhlIHdhaXRlci7CoCBJIHN1c3BlY3QgdGhlIHdha2VyDQo+ID4gPiBpcw0KPiA+ID4g
bWlzc2luZyB0aGUgbG9hZCBvZiB0aGUgYml0J3Mgd2FpdF9xdWV1ZV9oZWFkLCBzbw0KPiA+ID4g
d2FpdHF1ZXVlX2FjdGl2ZSgpDQo+ID4gPiBpcw0KPiA+ID4gZmFsc2UuwqAgVGhlcmUgYXJlIHNv
bWUgdmVyeSBoZWxwZnVsIGNvbW1lbnRzIGFib3V0IHRoaXMgcHJvYmxlbQ0KPiA+ID4gYWJvdmUN
Cj4gPiA+IHdha2VfdXBfYml0KCksIHByZXBhcmVfdG9fd2FpdCgpLCBhbmQgd2FpdHF1ZXVlX2Fj
dGl2ZSgpLg0KPiA+ID4gDQo+ID4gPiBGaXggdGhpcyBieSBpbnNlcnRpbmcgc21wX21iKCkgYmVm
b3JlIHRoZSB3YWtlX3VwX2JpdCgpLCB3aGljaA0KPiA+ID4gcGFpcnMNCj4gPiA+IHdpdGgNCj4g
PiA+IHByZXBhcmVfdG9fd2FpdCgpIGNhbGxpbmcgc2V0X2N1cnJlbnRfc3RhdGUoKS4NCj4gPiA+
IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogQmVuamFtaW4gQ29kZGluZ3RvbiA8YmNvZGRpbmdAcmVk
aGF0LmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gwqBuZXQvc3VucnBjL3NjaGVkLmMgfCA1ICsrKyst
DQo+ID4gPiDCoDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL25ldC9zdW5ycGMvc2NoZWQuYyBiL25ldC9zdW5y
cGMvc2NoZWQuYw0KPiA+ID4gaW5kZXggNmRlYmY0ZmQ0MmQ0Li4zNGIzMWJlNzU0OTcgMTAwNjQ0
DQo+ID4gPiAtLS0gYS9uZXQvc3VucnBjL3NjaGVkLmMNCj4gPiA+ICsrKyBiL25ldC9zdW5ycGMv
c2NoZWQuYw0KPiA+ID4gQEAgLTM2OSw4ICszNjksMTEgQEAgc3RhdGljIHZvaWQgcnBjX21ha2Vf
cnVubmFibGUoc3RydWN0DQo+ID4gPiB3b3JrcXVldWVfc3RydWN0ICp3cSwNCj4gPiA+IMKgCWlm
IChSUENfSVNfQVNZTkModGFzaykpIHsNCj4gPiA+IMKgCQlJTklUX1dPUksoJnRhc2stPnUudGtf
d29yaywgcnBjX2FzeW5jX3NjaGVkdWxlKTsNCj4gPiA+IMKgCQlxdWV1ZV93b3JrKHdxLCAmdGFz
ay0+dS50a193b3JrKTsNCj4gPiA+IC0JfSBlbHNlDQo+ID4gPiArCX0gZWxzZSB7DQo+ID4gPiAr
CQkvKiBwYWlyZWQgd2l0aCBzZXRfY3VycmVudF9zdGF0ZSgpIGluDQo+ID4gPiBwcmVwYXJlX3Rv
X3dhaXQgKi8NCj4gPiA+ICsJCXNtcF9tYigpOw0KPiA+IA0KPiA+IEhtbS4uLiBXaHkgaXNuJ3Qg
aXQgc3VmZmljaWVudCB0byB1c2Ugc21wX21iX19hZnRlcl9hdG9taWMoKSBoZXJlPw0KPiA+IFRo
YXQncyB3aGF0IGNsZWFyX2FuZF93YWtlX3VwX2JpdCgpIHVzZXMgaW4gdGhpcyBjYXNlLg0KPiAN
Cj4gR3JlYXQgcXVlc3Rpb24sIG9uZSB0aGF0IEkgY2FuJ3QgYW5zd2VyIHdpdGggY29uZmlkZW5j
ZSAod2hpY2ggaXMgd2h5DQo+IEkNCj4gc29saWNpdGVkIGFkdmljZSB1bmRlciB0aGUgUkZDIHBv
c3RpbmcpLg0KPiANCj4gSSBlbmRlZCB1cCBmb2xsb3dpbmcgdGhlIGd1aWRhbmNlIGluIHRoZSBj
b21tZW50IGFib3ZlIHdha2VfdXBfYml0KCksDQo+IHNpbmNlDQo+IHdlIGNsZWFyIFJQQ19UQVNL
X1JVTk5JTkcgbm9uLWF0b21pY2FsbHkgd2l0aGluIHRoZSBxdWV1ZSdzDQo+IHNwaW5sb2NrLsKg
IEl0DQo+IHN0YXRlcyB0aGF0IHdlJ2QgcHJvYmFibHkgbmVlZCBzbXBfbWIoKS4NCj4gDQo+IEhv
d2V2ZXIgLSB0aGlzIHJhY2UgaXNuJ3QgdG8gdGtfcnVuc3RhdGUsIGl0cyBhY3R1YWxseSB0bw0K
PiB3YWl0cXVldWVfYWN0aXZlKCkNCj4gYmVpbmcgdHJ1ZS9mYWxzZS7CoCBTbyAtIEkgYmVsaWV2
ZSB1bmxlc3Mgd2UncmUgY2hlY2tpbmcgdGhlIGJpdCBpbg0KPiB0aGUNCj4gd2FpdGVyJ3Mgd2Fp
dF9iaXRfYWN0aW9uIGZ1bmN0aW9uLCB3ZSByZWFsbHkgb25seSB3YW50IHRvIGxvb2sgYXQgdGhl
DQo+IHJhY2UNCj4gaW4gdGhlIHRlcm1zIG9mIG1ha2luZyBzdXJlIHRoZSB3YWl0ZXIncyBzZXR0
aW5nIG9mIHRoZQ0KPiB3YWl0X3F1ZXVlX2hlYWQgaXMNCj4gdmlzaWJsZSBhZnRlciB0aGUgd2Fr
ZXIgdGVzdHNfYW5kX3NldHMgUlBDX1RBU0tfUlVOTklORy4NCj4gDQoNCk15IHBvaW50IGlzIHRo
YXQgaWYgd2Ugd2VyZSB0byBjYWxsDQoNCgljbGVhcl9hbmRfd2FrZV91cF9iaXQoUlBDX1RBU0tf
UVVFVUVELCAmdGFzay0+dGtfcnVuc3RhdGUpOw0KDQp0aGVuIHRoYXQgc2hvdWxkIGJlIHN1ZmZp
Y2llbnQgdG8gcmVzb2x2ZSB0aGUgcmFjZSB3aXRoDQoNCglzdGF0dXMgPSBvdXRfb2ZfbGluZV93
YWl0X29uX2JpdCgmdGFzay0+dGtfcnVuc3RhdGUsDQogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFJQQ19UQVNLX1FVRVVFRCwgcnBjX3dhaXRfYml0X2tpbGxhYmxlLA0KICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBUQVNLX0tJTExBQkxFfFRBU0tfRlJFRVpBQkxFKTsNCg0K
U28gcmVhbGx5LCBhbGwgd2Ugc2hvdWxkIG5lZWQgdG8gZG8gaXMgdG8gYWRkIGluIHRoZQ0Kc21w
X21iX19hZnRlcl9hdG9taWMoKS4gVGhpcyBpcyBjb25zaXN0ZW50IHdpdGggdGhlIGd1aWRhbmNl
IGluDQpEb2N1bWVudGF0aW9uL2F0b21pY190LnR4dCBhbmQgRG9jdW1lbnRhdGlvbi9hdG9taWNf
Yml0b3BzLnR4dC4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFp
bnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0K
DQo=

