Return-Path: <linux-nfs+bounces-5526-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCFD95A21F
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 17:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 326F8288BD1
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 15:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870AF149C42;
	Wed, 21 Aug 2024 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Iowuze2+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2097.outbound.protection.outlook.com [40.107.220.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8611494C2;
	Wed, 21 Aug 2024 15:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724255623; cv=fail; b=MxVIRVBgr5iRDyFqL8qL7zSIdrORhvAbwyTjBG3bVY3Ms2xw++4H53VyNk9T4rVyh6+Z0rNYfxFTCsKTj2Nts83V6Y59d1girb23HZcyil5sc7aOlQmZcjeel1sb59CWDr3C6KIlwUenMtuymwEMP919N7iGriD716lVOCFcwQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724255623; c=relaxed/simple;
	bh=C1qGiZRkToVAxA0IxRxEqIg1wCaiGIYTgCzeoEFDkkg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Sv6CS5dZErzr4jb75DFK5ph+W9x2QYRLl0Y7boIUt/O1CJWeaA4KJgGIsepTA0G8K7opYl6qCnzrTe4YviF6Dl1fGHfdu8o7dlVc7lEixmVtggKzYyFW/IIUpxF0Nfls7VudJsGBEArbNCYdeFV+fI2CZEdBN+NTtsH/KSBfWNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Iowuze2+; arc=fail smtp.client-ip=40.107.220.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xm3XpaKrj7Z5ge1Kp1GEagQl+jp1mxJlRPDZW/72ISqJZkZmiurSs3qnRZFQHhPdt+FxtBaIzzeevznfZNDuJ/sMCuOJv00dBBdQ4BraZXTR6DBdVKfFQmJs9yC/55v5YMUbHs1qiBmsja7frjFYYzWE5NzEh7Oq5abV5pVNnxVKfie0hEyvLGGSSn3D6L1GtnfWu5JWNxo8MQy5iN/TP9op45Q4zLuihN7TrcEd3q5vpQgRqJZMXbFvZTS2C1RXgn2Bz4xbASNaixdZ6AISxnYlR1RQxzTw7XdYgK8moxc0XHZxOMGJJLYPGiBOGOkSGABauATXARtPuG7LK2nG6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1qGiZRkToVAxA0IxRxEqIg1wCaiGIYTgCzeoEFDkkg=;
 b=Y8VdH2m1SzmXIjSTBB9vVsvcnPMxmptW28sL+mmLZA/GRldn94wUqoPf1hj0ElzwNo5GLE+P49CCAb6l95CoUIdPSzpRg5azbD61VihLMmxT0/5vZ6rNzgEhP6mrtIi73n94D6L9Mg45x/aN+1YnvCIM4Mq5X0Ywmaumwp4vhcBQDRxo381Ig0qltjJ7HHO8xv4MP+57uw1d6+o/9259OkTWA/Gid1LNzueyu7qE0S+Ldg+/hd9WPUH4YFzJCO01lJgFtPknv+LqdRCF9O+ruDTRc121qgFW7s4/X8h02NDqWkrVL9DvDqcmUvJZViCEFlZom81gCu9jpx4jxSc7LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1qGiZRkToVAxA0IxRxEqIg1wCaiGIYTgCzeoEFDkkg=;
 b=Iowuze2+RvpfTzERMA1uxD3gpvtb2969m/f7bt1qQ2f1h3TtppSbFYG6ROMAl+yUTQf9yU1MdrHpVUHxk32tQlgsBW0AlhxCEW7BD5Es+VoRQdO+Y+DYQh62HmU40XlnbbqFKITXFg6DCDGaDVS+aTUqXOsmTjgf86FhtkdhpnQ=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM6PR13MB3753.namprd13.prod.outlook.com (2603:10b6:5:249::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Wed, 21 Aug
 2024 15:53:38 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%4]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 15:53:38 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "anna@kernel.org" <anna@kernel.org>, Lance Shelton
	<Lance.Shelton@hammerspace.com>, "jlayton@kernel.org" <jlayton@kernel.org>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs: fix bitmap decoder to handle a 3rd word
Thread-Topic: [PATCH] nfs: fix bitmap decoder to handle a 3rd word
Thread-Index: AQHa88P+hf0nGPltEEmWAsZYKG8Xi7IxzaoAgAAA4YCAAAoHAIAABHeA
Date: Wed, 21 Aug 2024 15:53:38 +0000
Message-ID: <89caed01e51c2ba58c3cddc5f335946dac82bd63.camel@hammerspace.com>
References: <20240821-nfs-6-11-v1-1-ce61f5fc7587@kernel.org>
	 <963d3249b9c9bdc842a835e5c38d00638a6037eb.camel@hammerspace.com>
	 <c1d69b024d2a60d2a10e4211c2cbe565ca0e23fb.camel@kernel.org>
	 <0935dab532078c17847f7d6e26ec76074a39a2ca.camel@hammerspace.com>
In-Reply-To: <0935dab532078c17847f7d6e26ec76074a39a2ca.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|DM6PR13MB3753:EE_
x-ms-office365-filtering-correlation-id: b78a70a0-3182-4241-60ad-08dcc1f96bdf
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RTZueVlobEJlME45WENRcEdTQVh1TTU3ajk4TytkVElmc3Nhd2FPSWt4dWZj?=
 =?utf-8?B?VUVkMWNvb2xKT21TaUpUTFYxMlp3MVVBQjJDN0twWHhpWUlDSzFLUTNCczhV?=
 =?utf-8?B?bXlRSXVuV0pNZlN3OGticTJjY0lQTzNVSkx3V2JPRHRmVGYyNEh2aHl3RFhX?=
 =?utf-8?B?aEh2MTZuT25KOEJsOTBHWWI5cElBNlNMOEJRL2dGQmV2VDIxZ01qQzk1eFpZ?=
 =?utf-8?B?bGU4TGpKcFNqT05nczZBeUprYjJxUmJUY3V4c2pleHo1YXkxajNONWNMQXc1?=
 =?utf-8?B?VDZieG01ZURuTzh1K0R6bmp1ekpyenJ0UFJFTU9yOW1IOWFIWC9PaHJzNXIz?=
 =?utf-8?B?cHFvZGRCMUpReEdtK0p1UjVHU0UvbFJtSWxVVlJvaDlOOGtHWWFUZ3F2dUg5?=
 =?utf-8?B?VUR1Mi94N2h0M0QzZlhvamd1am9Dd2l4Q0poSFVxYnpxNFF0R3o3bzNwSFo5?=
 =?utf-8?B?cG5sNmhPaFF6TFlKeEx6bGVaTUo5UzFRb05Xb2tHSXpmY1VyeThMUDR3aUMw?=
 =?utf-8?B?QWYwSTFkdDVTUzIwOFBEU2t4TnpOSVh2RWE0aWxhN2ZpWStzUk42UTJBOGNh?=
 =?utf-8?B?NVV1UUEzcHovZGxRREZqd0JDRjliTmhrRDVoOC9RU0UwaFNjcU9DOXNCMHZF?=
 =?utf-8?B?czV6L2pBOUttWkNveDdBdWVWNjFxYkdCK2s5Mm1CRGtFMEgybDJFZHRPZ3hP?=
 =?utf-8?B?TGF2OWhIY1JEZWFIMFE5MzFoNjZ5WVNmelNIa05vRkNoL3pJSC8zRDNpZGh5?=
 =?utf-8?B?VlYwdFQzWW1seDRJV2J4SGZRaGcvd2JmUU5mdWxmYmUycG80Uy9zckhpbWdm?=
 =?utf-8?B?Rlh2U1hub2tabnZvcGRTZXJhaTRLV2JNa1BqVm1zUDhFZkQ5c0hLWVNoRUhk?=
 =?utf-8?B?NFR5R1ZSOFA3WTZMekVCVEJpcVBoU2tlUWVqT1lJV0l0L2d2aFUxMFUyVUhI?=
 =?utf-8?B?bThNUGJHT1IxTWdMQnp5YW43RXdJQy92YTRRcE9Va3ZSU3BHdENNS2xEbGNV?=
 =?utf-8?B?Rlk3MnpuYWtJd2pPdEd6ZERsVnIwSldiUTBjTGo2bXoxZEZpRURtNXo1cTh0?=
 =?utf-8?B?K1kyYkxNSlRjUmNQZjdhSmswSmZVSkhhaUg3d0R0WWdOK25oWWdEL3VwMTky?=
 =?utf-8?B?NUkvN0JoUUF2Qit5eU1CNWdiK0F0NkhtMk5tYktjYklWUGpmRGhqR0F2VnB5?=
 =?utf-8?B?OVQyclEwR1ljWmZ3TGdJYjk2d1BzS01BSjZKRURtQ2FtclNFTjFDekVEOWZU?=
 =?utf-8?B?NE1pK0NhVDlFaGZkNzgxK1RFREJIeXQ0azN2dzIwL2V0MDBaYjd0S2k5eDY5?=
 =?utf-8?B?LzNpczNvQ3YzUnhWWXF4eG9Ccy9UV2J6QTQ0V1VBSjUxc1RKSTc3Zm5Icmow?=
 =?utf-8?B?bDNaTVJXMTZ0ME5tKzNYWlV4L3ZGOGEvZzkzZW5WUVZMMC9vaXlYak1EQ1d2?=
 =?utf-8?B?aEN3dzV5SVVKMHFyQ1N2RTFmZGFTUTJWSTJTZzl2V3crUmUyRk1Ld0F0MGor?=
 =?utf-8?B?dlROTVlHZWtoK2xyNXAvMHB3Zzk4TkpuQVZPS3lZempPRysrYVhOS3B3bWlV?=
 =?utf-8?B?Y1NtbVRBWGVxd29aNTlGellYc3NUTUNYbTU0K2g2MGxmNGtCS1lmcmEwSmQz?=
 =?utf-8?B?WE1Oelg4dHM4R1Uyd1ZGVzFiNE55L013d3BSYlhobVpDcjJhQmd0dngxcWdN?=
 =?utf-8?B?MUIwNDVBbnd4RExqNUdSQ3ZlK053UEduUmpYNkdQMXFHZHQxcjdtVUR5Y1ds?=
 =?utf-8?B?K0k5VWNrcDVoUVJUU0tGa2Z6QnM2bXZqdFJ0OVB2VUIrb1ZSYmlmeEVLbVZz?=
 =?utf-8?B?dGRrYUROVHBrU05RNmpwLy9waHJHWnRmR2RZbDVORTJJZWRwTHN2Smk0WHZF?=
 =?utf-8?B?R1djYTZ3VHMxRFcyeEFSUndCZkkwQmhTZTVGZFo1dVhHQ2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NjBIN0tpWmNlM2UyS0kxRDlMWWRIY28vRTZKUm9EVWRnaG1XOVd1a0VHL1dw?=
 =?utf-8?B?ek5GYmZSQUx5dVdEeFpodjBWQW0za1BXUWI0MmxZekdBeWZCVG1JY05DdkZh?=
 =?utf-8?B?Q25YK2tYNXUxWWx1eklNYkU5cHRWMnQyZFlreSsxbjlsRENpZnFsVDRmd3dF?=
 =?utf-8?B?ZUZmcUR4MHhkRVJJY3RqZ0gydjUyb2VHd0Z4dkZMbzFVMTBEZEltdUpNdkFL?=
 =?utf-8?B?SUpUenl6MHJ1ZXMwdUMwRTVtMEl3VzJZSmdRMVVqUTUxQlFtR0tzcUF2Y2di?=
 =?utf-8?B?RGFkUlRZVUpwc1NCUzRCNGx3akV6d3Y2NDNMRFNCSUo5a2I2Mk1pbmo2eTdL?=
 =?utf-8?B?ckk0Z25SLzZ4RVRKK3FwTURxdGt4ZGFkckkwWm1jZFFiY21ZSEZoR01PcFFv?=
 =?utf-8?B?SWd6dTNNdE1kSmM2bGNQQjdRb2k0VXZZVkV2TW54OG1iWTZQREk2dENDMzR4?=
 =?utf-8?B?V05tTFBSOVIxb3VCeGFXM3hISWFTS1oyb2FlSWMvTmpQbC90S3k4eDQwcUZX?=
 =?utf-8?B?UlhkMjR6Y29ZSjZjTVpzZ3NhSEQ4U3pIczNWNXZTMDYwMlRWUjZWSWNIc0dL?=
 =?utf-8?B?dENjcWpvUXA3UTRlNWhkWk0xOHBBcmZBNnJ3UUNPWUxTUzRwMXNGYk8wT3o5?=
 =?utf-8?B?NFpqWkVxY3BXWGdEL0hKK3loc0lLREJleWE2T2svRDFmeWlOaUllT1V6QXFt?=
 =?utf-8?B?QUNTRDByVjd3cnFFV3haT2t4amlFSWljNG5IQ3dwZUp3ck42OEtnUk1XeFNs?=
 =?utf-8?B?Z1lUZmZud2lVOWUzS2Y0WjBnZTVoVFV2UWM3Z1JlOVg2TEc3UTJnYkpDbUFR?=
 =?utf-8?B?b0dNZDJJK0dZQk4rSEt2WmZVZE9kTmxncUx2OStjcDZ5aXdvNDExOTNUNDUw?=
 =?utf-8?B?b0hQMW1ubUtkWmNZa1ZoRXJxcDRBMCs5M0ZZVHlBV1JqYmlQcnpLZGw1cjNo?=
 =?utf-8?B?eFlOaU1taEtST3E5WXhyU3NUS1pmdkNqdzRhWlpOZmt5S3V4NGdNTWFuN3F5?=
 =?utf-8?B?R3kxVHo5R3FGMHhzb2ZNUzJYQkZJRUFEMUgrdmpjNFBicHBSWHhJS3UvZmZ6?=
 =?utf-8?B?d2FHUGlhZjBrcWw0dFF0Zm5OZGdnbnhvV1AwS0NIeENRNXVzYU1KMEpQQXJK?=
 =?utf-8?B?Y3JBaXZMclNqR1oxRERuV1dDdjRTeHpFSVVnRnBwOWtiTHhYRlhnbWlmTmRM?=
 =?utf-8?B?U0NsM0UvWEN4cVl5S2JFSVRRUFhRRjVmUDc4Z1NiYm5GRm9xaEZxT1k2NG1Y?=
 =?utf-8?B?UUdHeXByN2tWR1ZsMmNHU0Q5TzV2Z1Z4b2NMNEZwUFBxWWpLbmpHOU05YUdq?=
 =?utf-8?B?QWRZeWNQMzR4dDFiYWViUzJYSUhlQnByaS9zeDhLSnIyYTAvREJUalpkeDBS?=
 =?utf-8?B?RDNUNGJQSFVETGJjNm54UTRpMUVqOUFhSlJOQit5RTB0dVpyZS9KSGpOSTB0?=
 =?utf-8?B?SldNMWIwQmN4T0RXMnlVUTlYTjkwd3FOSXlLdWJSSFh4TmJWQjY4cXdUU2FO?=
 =?utf-8?B?NlRubmpVNTBiM05KVVlpbGVnQitycTR4UkdkMFovTGNua2JVM3pLamdFb2hK?=
 =?utf-8?B?RTdYM1h1N1RSM3lnem40eVBKby9VVHRiTHBaNkhtTVUvOGlQdGYwK0xLb25i?=
 =?utf-8?B?V3UyUU54eTBlRVhIejRwelhpMjUyN04rOG9rakU4S1VDTzJiVXltKy9qYWVz?=
 =?utf-8?B?WTc0RFF3Q2tiRG81ZUpkZ1hlamdPdVNzZHJnSVhIbjR2dGxFZ0NQdEJtdU5W?=
 =?utf-8?B?eDRzSWRBS2dOQ2VKODBVV3RjVS8zNXh5TWJrMTU4YmhjTERRL2NxNm55NGZp?=
 =?utf-8?B?OTJ4cHUyY1ZJMXl1ZjBNdG9PUnlLcktpWkVVdUQ0M3Z2R1JGdHBMUnBLa05C?=
 =?utf-8?B?OGZKbEptVzVHWXBSam9kZk1UOUt3NzJFRVdWT1ZVa0VHRjZCZVZ5d0tOcmNY?=
 =?utf-8?B?dnlSUWpKTXFjQjhSdGJGaFVQZDVOS09KbDFwaTZ0QWlyYmJzSndySVh4ZWNC?=
 =?utf-8?B?bW9aQ3VhNTFtekJJbm96ZklhTDdRTzM4NG1ZZ1FnNTk1aXNnYzVUKzNSVmJG?=
 =?utf-8?B?VHhDV2hUL01QYWFOM1h5a01DdkNQNUVMSGJKVFlBWVpFdWFOWDMxZVpmV3NC?=
 =?utf-8?B?NFYyaysrdHBOb2tJVDlZTFMrNDBXOUpBL1Z2cThOTmFEM2J2WlhvMVNGVWVN?=
 =?utf-8?B?RFNLQ2hGWWFETkQzOVRoUUJmVllpZTcrdG1VN3JTMWV2OS9mUlh1dVE1akE0?=
 =?utf-8?B?ZTlkajh0UVRST2drcTh1em02MWtBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8A09443CBBBA24AA9618DA23D0D3DF8@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b78a70a0-3182-4241-60ad-08dcc1f96bdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2024 15:53:38.0378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vdb1Q7W1Q0OmUBoFiiWneGhy83GZ+sk4wwSCDmLGp/AIUoj3VsD96E6PTKTDpVu8NPyHecrwZk22Hpw1oPaLpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3753

T24gV2VkLCAyMDI0LTA4LTIxIGF0IDE1OjM3ICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+IE9uIFdlZCwgMjAyNC0wOC0yMSBhdCAxMTowMSAtMDQwMCwgSmVmZiBMYXl0b24gd3JvdGU6
DQo+ID4gT24gV2VkLCAyMDI0LTA4LTIxIGF0IDE0OjU4ICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qg
d3JvdGU6DQo+ID4gPiBPbiBXZWQsIDIwMjQtMDgtMjEgYXQgMDg6MTYgLTA0MDAsIEplZmYgTGF5
dG9uIHdyb3RlOg0KPiA+ID4gPiBJdCBvbmx5IGRlY29kZXMgdGhlIGZpcnN0IHR3byB3b3JkcyBh
dCB0aGlzIHBvaW50LiBIYXZlIGl0DQo+ID4gPiA+IGRlY29kZQ0KPiA+ID4gPiB0aGUNCj4gPiA+
ID4gdGhpcmQgd29yZCBhcyB3ZWxsLiBXaXRob3V0IHRoaXMsIHRoZSBjbGllbnQgZG9lc24ndCBz
ZW5kDQo+ID4gPiA+IGRlbGVnYXRlZA0KPiA+ID4gPiB0aW1lc3RhbXBzIGluIHRoZSBDQl9HRVRB
VFRSIHJlc3BvbnNlLg0KPiA+ID4gPiANCj4gPiA+ID4gRml4ZXM6IDQzZGY3MTEwZjRhOSAoIk5G
U3Y0OiBBZGQgQ0JfR0VUQVRUUiBzdXBwb3J0IGZvcg0KPiA+ID4gPiBkZWxlZ2F0ZWQNCj4gPiA+
ID4gYXR0cmlidXRlcyIpDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEplZmYgTGF5dG9uIDxqbGF5
dG9uQGtlcm5lbC5vcmc+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiBGb3VuZCB0aGlzIHdoaWxlIHdv
cmtpbmcgb24gdGhlIGRlbHN0aWQgcGF0Y2hlcyBmb3IgbmZzZC4NCj4gPiA+ID4gLS0tDQo+ID4g
PiA+IMKgZnMvbmZzL2NhbGxiYWNrX3hkci5jIHwgNCArKystDQo+ID4gPiA+IMKgMSBmaWxlIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4gPiANCj4gPiA+ID4g
ZGlmZiAtLWdpdCBhL2ZzL25mcy9jYWxsYmFja194ZHIuYyBiL2ZzL25mcy9jYWxsYmFja194ZHIu
Yw0KPiA+ID4gPiBpbmRleCAyOWM0OWE3ZTVmZTEuLjI0NjQ3MDMwNjE3MiAxMDA2NDQNCj4gPiA+
ID4gLS0tIGEvZnMvbmZzL2NhbGxiYWNrX3hkci5jDQo+ID4gPiA+ICsrKyBiL2ZzL25mcy9jYWxs
YmFja194ZHIuYw0KPiA+ID4gPiBAQCAtMTE4LDcgKzExOCw5IEBAIHN0YXRpYyBfX2JlMzIgZGVj
b2RlX2JpdG1hcChzdHJ1Y3QNCj4gPiA+ID4geGRyX3N0cmVhbQ0KPiA+ID4gPiAqeGRyLCB1aW50
MzJfdCAqYml0bWFwKQ0KPiA+ID4gPiDCoAlpZiAobGlrZWx5KGF0dHJsZW4gPiAwKSkNCj4gPiA+
ID4gwqAJCWJpdG1hcFswXSA9IG50b2hsKCpwKyspOw0KPiA+ID4gPiDCoAlpZiAoYXR0cmxlbiA+
IDEpDQo+ID4gPiA+IC0JCWJpdG1hcFsxXSA9IG50b2hsKCpwKTsNCj4gPiA+ID4gKwkJYml0bWFw
WzFdID0gbnRvaGwoKnArKyk7DQo+ID4gPiA+ICsJaWYgKGF0dHJsZW4gPiAyKQ0KPiA+ID4gPiAr
CQliaXRtYXBbMl0gPSBudG9obCgqcCk7DQo+ID4gPiA+IMKgCXJldHVybiAwOw0KPiA+ID4gPiDC
oH0NCj4gPiA+ID4gwqANCj4gPiA+ID4gDQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiBiYXNlLWNvbW1p
dDogYjMxMWMxYjQ5N2U1MWE2MjhhYTg5ZTdjYjk1NDQ4MWU1ZjlkY2VkMg0KPiA+ID4gPiBjaGFu
Z2UtaWQ6IDIwMjQwODIxLW5mcy02LTExLTE4OGJiNGUxZjFkZA0KPiA+ID4gPiANCj4gPiA+ID4g
QmVzdCByZWdhcmRzLA0KPiA+ID4gDQo+ID4gPiBXaHkgZG8gd2UgbmVlZCB0aGlzPyBJJ20gbm90
IHJlYWxseSB1bmRlcnN0YW5kaW5nIHdoaWNoIGNhbGxiYWNrDQo+ID4gPiBhdHRyaWJ1dGVzIHdl
J2Qgd2FudCB0byByZXR1cm4gaW4gdGhhdCByYW5nZS4NCj4gPiA+IA0KPiA+IA0KPiA+IChub3Rl
IHRoYXQgdGhlcmUgaXMgYSB2MiB0aGF0IGZpeGVzIGEgcG90ZW50aWFsIGJ1ZmZlciBvdmVycnVu
IHdpdGgNCj4gPiB0aGlzIGNoYW5nZS4gV2UnbGwgd2FudCB0aGF0IG9uZSkNCj4gPiANCj4gPiBG
QVRUUjRfV09SRDJfVElNRV9ERUxFR19BQ0NFU1MgYW5kIEZBVFRSNF9XT1JEMl9USU1FX0RFTEVH
X01PRElGWS7CoA0KPiA+IDQzZGY3MTEwZjRhOTAgYWRkZWQgc3VwcG9ydCBmb3IgdGhvc2UsIGJ1
dCB0aGUgY2xpZW50IGRvZXNuJ3Qgc2VlDQo+ID4gdGhlDQo+ID4gc2VydmVyJ3MgcmVxdWVzdCBm
b3IgdGhlbSB3aXRob3V0IHRoaXMgY2hhbmdlLg0KPiA+IA0KPiANCj4gRCdvaCEgQWNrZWQuLi4N
Cj4gDQoNClNvcnJ5LiBJIG1lYW4gQWNrIGZvciB0aGUgdjIgdGhhdCBhbHNvIGZpeGVzIHRoZSBy
ZXN1bHRpbmcgcG90ZW50aWFsDQpmb3IgYW4gYXJyYXkgb3ZlcmZsb3cgaW4gZGVjb2RlX3JlY2Fs
bGFueV9hcmdzLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWlu
dGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoN
Cg==

