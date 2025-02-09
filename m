Return-Path: <linux-nfs+bounces-9996-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2FCA2E17F
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 00:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D8DB18843AC
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Feb 2025 23:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355A614B092;
	Sun,  9 Feb 2025 23:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="c0p9tNWS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2127.outbound.protection.outlook.com [40.107.243.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5C814B08A
	for <linux-nfs@vger.kernel.org>; Sun,  9 Feb 2025 23:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739144095; cv=fail; b=eDLdundQLiRslCHSF+cNGMf47LdguQuRooDghV4HJQQbTC7HX5SEWHl7q9ToxLmjdGMdBoEpSXHn3pof/vhd2nkcg4qIHNZzOG48XcCX771A4er3hdwv2u/Z8jQbD63HOJZHKj6+y7HPg7LO8gRbhF4VshBv6b2RqA7rSKtHtik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739144095; c=relaxed/simple;
	bh=TWiGKLGW9e37CuB/oMjj7bT3oyrAn8YAM1AFWoHbdPM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AJatc3xbhfhiGN7X0nTqpXp6H7kiZWg9J7l+QgeJPys4UO4kPfOhr1nCN0QJfpXDpZGBpDnnnwROZA24jxNV7Gr/WFkGpx860o8soFDx86uIwcYlDzOpX8C1XCGu183Bsib+My8gatsSYS8n5QDVMRX1uO/W++q4zvftHJXn7ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=c0p9tNWS; arc=fail smtp.client-ip=40.107.243.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITxk9osXe1qLextuaupGsA71VjEpsIntcV7JetTdwlt/QpXxlnnmrarkM2huTzUvBL1s6TFtcNPSwxblwswl7dl7qcogoJr1QReIKxgf5B54hsfGxgkTNRhcwCUJPKMg2/KNVmWrik2RvMWBAUPYbJ3rbhrGQY1PNkEgyrAn0bcjx0od5UUHjOYig0LGWFW53vVtFKvpRmmlzQD0IspAA/QX7gdFCHhJDANm0snZOJj9ABmkqd1kVu24J7oy03ZCrKibZ2I50Bl8CKHveAJWtwrN2XSMgv+0Xz5haY55qz1HqzyxRpr/nHtjG6hhB+iEBLJMKGyJ2C41APdAp5ih+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWiGKLGW9e37CuB/oMjj7bT3oyrAn8YAM1AFWoHbdPM=;
 b=mHXbrTDgXlhfNjVX4DjL7ctTUI5Myw4uN6hDERP5BT/PLd1u2nmXETIkUGG2BBPkAlVLsCHG+QsYNkc7VsT3Vh2xsbfOPM6HdOo875hSIUmZ1ZFLhxg7STHrxbwGQTStnLaiBg9PCNvKR5bz3zFw5jVN8tLUzEYMDUlGPAv8No+mxIDS0WatAdnk8GsoD4JxmYAsLpp93W/Et/46kjFFbR5m6+T1mJvIy1VFAdXOGMR5OGkT5e277LYnCKmqLgDevn4omspk7h/mlHpzMVjCrnertlTN0AIWfV9eMuTBl51isN7AhzBR23RKwE0cwxPxbfbaZ7QPN1XPoIVsT7L2ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWiGKLGW9e37CuB/oMjj7bT3oyrAn8YAM1AFWoHbdPM=;
 b=c0p9tNWSTvalExLHoVJAHCLIhKnHrvdIs9W1rhgNjsk31l4hFfvzIXwGRJES2nVzRJad5CEbv6q1LKp1YkHGYb8L/9PTeMzqWYhPCyG9OJdtoD/clfkiW2wEd1X6dOQqDytc1aqswUaOJ1Fq2pEjTBThwddU6WKi+dYUgINJKuE=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SA1PR13MB5056.namprd13.prod.outlook.com (2603:10b6:806:1a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Sun, 9 Feb
 2025 23:34:48 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%3]) with mapi id 15.20.8422.015; Sun, 9 Feb 2025
 23:34:48 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "rick.macklem@gmail.com" <rick.macklem@gmail.com>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: resizing slot tables for sessions
Thread-Topic: resizing slot tables for sessions
Thread-Index: AQHbezsyY9r+XcliDEC8smCfQFqGNLM/n/KA
Date: Sun, 9 Feb 2025 23:34:48 +0000
Message-ID: <884876492c56e76fd6fbb4c5c4fb08ee14de9fe1.camel@hammerspace.com>
References:
 <CAM5tNy4f9YyMhYRydudNkCqzVp5f8Np6N25NOT=-+TjJN2ewqg@mail.gmail.com>
In-Reply-To:
 <CAM5tNy4f9YyMhYRydudNkCqzVp5f8Np6N25NOT=-+TjJN2ewqg@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SA1PR13MB5056:EE_
x-ms-office365-filtering-correlation-id: e8590557-89fb-435f-2a9a-08dd49625794
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OWh4WUZ3dURsQVVHUHVmaklXWGZWMmRWVjM3b0NxMy8yeUtKWUE2QS82NkNO?=
 =?utf-8?B?ek44dWs4M3gxQjBONmNBMi9RTnJaSm1QMTN6QzI2TVpOTGU3dWpHeG1hTVlX?=
 =?utf-8?B?dnl3dTlBTGs2NEFoWTM5L2NXMEp2L2E2ZXhmQ2pQdlIyckI5NUdINklRSkcx?=
 =?utf-8?B?NUpybWtWaUxrL2k0N2E2bTVJblZkaXNMNEwydUxtendQRXdtVmx0NWc2bXlQ?=
 =?utf-8?B?Nld0RFVPU1RrVUdabFdUK2VCSDhXOVRMaE1IN1Z2VUNIMUZmeUxzdnlFUm5n?=
 =?utf-8?B?emY2dE5MWHFtbEZnR0FzeTRVRnZuNWlUOElvM2RLY2lLdzY5OGxqbUNmMEdU?=
 =?utf-8?B?WmRYV2dqWTNON3RmNmpUUEZ4Ui9UU1ZSUWJHR2ZTZlR5cE9uazY1L0ZBcU0v?=
 =?utf-8?B?Q3dkVjR2TGpTL2FNTXJtVDJBaFUwbnNiWDdTUWhhL3c4Zlh5cXI0S25QNVB6?=
 =?utf-8?B?ZnkzQWU1QmNITDlpTlI1anN3NEg5NDhkR0I1c2cwazNQeWpMQ0VrK2VmeThi?=
 =?utf-8?B?UzNvaElqVWhvTG1ESGs1VXNjelBMbkVONFlWeExKVFU5WGxMOFJzRkpuais0?=
 =?utf-8?B?ZHRWUWZRS3lPQ3FTbU8ycXdFRlBHem9BYU4rR3pySWJBQ0FjVTFoN0toZlpa?=
 =?utf-8?B?WmNVTExraTBXSU5PTy9EM2VpNE1HcTZVNm1kK3hwM1luSmpYZW9HZlZrTC9o?=
 =?utf-8?B?Q1ZHMndKallXRFoyY0RaRTE4K0JwR2NmTDlXamFwc3pSd1QyekdCcmlNSXQr?=
 =?utf-8?B?Yy9iTUZGbXRsUTV0SitEdThiZ25RMzRTMy9XSnBLdlA0SnNQQ1dueFRjTnJn?=
 =?utf-8?B?RlZKZDErZ2krWUxXQTRoTW9kd3FoZ3dxNk1FUjdhTGZPbG13UXRmTzRmVGlI?=
 =?utf-8?B?M042dVRRczkzM1ppN0FVaDdra05Pay8wR1pxby9WOWJkNGhtTmptS1lueXJv?=
 =?utf-8?B?bkxYMGdZRXBXQXljNytWMVI5M2FGd3ZIOEpxRnY2MC9MWndXVlkxOHNsOXJC?=
 =?utf-8?B?Q0ZaREs3QU9LamJQNk9ENkxUU21jblRjTk1tRkpDdUVMVFYwQnVpd2ZpWjdS?=
 =?utf-8?B?QjREWEtRWGR4TDNiR1ZxQnFBSmRJRFBrTC9VREFZVEppMUg4Z2J5b3psV1N5?=
 =?utf-8?B?USswTnY1TWVHUXpBWUh6cWpWOVRZZkJxYVlqSFJTcE1KWElpc2sxMC94ZVhN?=
 =?utf-8?B?V3Zybmt5SGFsMU9XOXlxcVUzR3RFMzZuU1BhQ05JNitYQ2szUmlDOTR5ZGR2?=
 =?utf-8?B?azgvM0NLaUJBSlIzZVM3SEViZVVzbjVVSnNKOUVsTWNGOEk4VmtqYktjRkE5?=
 =?utf-8?B?UTlvWEIzU2tBbWppVlVoVmFzLzJqSDl3bEJXbitjaEd6Qk8rWitmYzNIZ1pW?=
 =?utf-8?B?WHhwWmtQamFWN01ORlZjQS9OV091dFlETzNjWXQzTmZnaS9zanEzVTZ3QkRV?=
 =?utf-8?B?cXI2YTdqT3dVa2VqNnJIeEo4UEtPTTRsc2l5RCt3bzBpUmVIODB0c01jclpq?=
 =?utf-8?B?d01udGlRcEhqT0JNUmVyanI5VXl6OVVZcm4rT2svUlZNNHprZy9DMHhHemYr?=
 =?utf-8?B?a1pURVZrMnVDZjk0dnVrTXM1d3I5eGk3b3VBOGk3d29kUGw2N2tIb2hwelgx?=
 =?utf-8?B?SC9MTllVYUdxSUpCdm9ZeXJ4MzJpWmZmUm9kczRHaXQra2VuNUV5N0EyTjVB?=
 =?utf-8?B?TTcwdW1XdmVXdG9VaW5Xcjh0dWtYVkFiWVpLSXVKTVBWMjhzMHN0ajhRTFRO?=
 =?utf-8?B?djQ1VVNnRlA4NW1iSzJNU051bGxleDBFN0JvanIxMTZzaXFBaUlXYkk0SGtK?=
 =?utf-8?B?Si9HN0QySmZJcmpFemVMaWp6Z1hZSlo4bTQ5S0k3dHhQUG16d2daeXI2Rk4z?=
 =?utf-8?B?U1ZueGpsb3RaU2RDZlJwOFpxcjNvRUhLOXVwVXV4UjBqYmlvWmllNjgyTmJQ?=
 =?utf-8?Q?2Dy2BrUANsR8eNlv2FwsxDeOEMIJu5x9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bDU0cElvRTNFME41RngzU1d1eG9BNFVlVW0xTngxb2lIWmU2Nm9Yc3dTZjNC?=
 =?utf-8?B?aHNwd3F2OXlhVWtWalZqdDZacGszL1g5dFFZa1RUTVFuMWw4dHBPYmxFVGM4?=
 =?utf-8?B?VEFVcFBRMm5EMlNNNUJudnprVUhLcENDTG8wTDd1dE0ydzBueEtPb2pZbExt?=
 =?utf-8?B?MzhidHo1UUx3TmRlUDdPbm5DWExLMmUwSnlna2FpSERqWXpvMHQ2dE1Hejhw?=
 =?utf-8?B?bzNndEdBZVNSQUN2RmkyUENOUCtaR0o3YlFPczB1aHNlVlBGK2Z2Lys1QlBl?=
 =?utf-8?B?U2gzWTRSUDF6YStzTFoxa1VQbHpvanRRelN4WmJnQlVDd2U1N295ZWt6dzE2?=
 =?utf-8?B?YzZGNHlGSWV5YjRjVXlJMkRnYytlQlRmY1AyZ0doV2NTMklrYmN0cTA0YXQ4?=
 =?utf-8?B?cERXbkIxMXJGQ2E1a2wwV3Fzbk1VdjR6NkRGeFduWmxxUndpcWRrZVhoTnU4?=
 =?utf-8?B?bzRNaGVXZGY5S2NUZjJRZjRuV1A3NHJzNHR0RExoSlArdGpiOTI2bUlTKzl4?=
 =?utf-8?B?SzNVT0hZcnkvUHI1RWZuNW1oaFFJbEdHY1dGWmwxVkJzc2ZTRmpLczFkL0N6?=
 =?utf-8?B?bzU0ek5qYU5NenVCZ2taR1BnZ2FrbGRpYzVXVjIzdDJUNVowQmJGZk5MSFZr?=
 =?utf-8?B?eUVFcDgyM0g5bkpLZXliM0p2UllOaGhzS2lxZXAxSzExcGQwRVRwM0tmbVVT?=
 =?utf-8?B?ckp5Y3NadWlpS25nQ3YzakFORStnRkpmTDFpR1ltWC93WVRZc3ZzRDQwSVdy?=
 =?utf-8?B?K1k5aklXWUFTb01CUE8vdTZVTFJwcGtGaVlybzNheDZnZUVseDJDSmF4UnpB?=
 =?utf-8?B?UnBTdUh5SkZlU1Vvczc3WTlwT0ZGOU80VUo2SDIyd1JhS29tSEVkZ2trSjZJ?=
 =?utf-8?B?Z2t5TFJGaFJubEJMMm8xbWl0NGRBVGhDVTFDMXJNcjJ0a3d1ZStvWmdveXhG?=
 =?utf-8?B?RXYyMWpZY3VZM25aRW5RZStoRzNzU28zZzV4blZOakd0TE9DbE10cG05TEc2?=
 =?utf-8?B?RHFTSkVyNEt5dDMxRjZwbzlMYjZiK3pxYW1lVDFBQk5jMnZYejNqcVNyNjIw?=
 =?utf-8?B?WWh5SzRtUUpzY3FWM2M0anh2L21MdjVKaTBmb2dMR0dPd3VLQkhsSGsxekJ3?=
 =?utf-8?B?N0Zkcnk3M0NFRy94WFVKMU1QUUpIM2lCWUhabVRwNFRTeWtiUVRnUjE2U2Zz?=
 =?utf-8?B?R29iaEk1U2xJU1lDcEhKSTZISTM4ajZzOGczek5ubVBmUlVQRVFRWXRLTnZv?=
 =?utf-8?B?V2FzcnAzUWM2S3I4a2k2VGRXaXlsSy91Y1RoRjhiSjFFS3FPS1JHU2k1LzFD?=
 =?utf-8?B?VXFiTkR1S3FXT1UrRHRyZXYyWGJob3NRMjFQSVE5UVhrbzVNdkQ4elgyZzJ1?=
 =?utf-8?B?dXFvT0VYcGVOQksxN1hwSGpLK2djWVF3QUdqdmgzN1YwVElVdU5pU0J4czlE?=
 =?utf-8?B?K29zMXBZTzBaNGxUMGtmV1IwSE9VN2NScmE0R0duaHNGSk1tRHpJZy9HeGI3?=
 =?utf-8?B?VkdBTzI1R2s2ODJqdmJ2MVJydGpWZ3BLZnFPME1pQ2hONlNEdXQ4SzBIYUla?=
 =?utf-8?B?bjRvRUxyYkN0U2FsT0lzQlo0WGRvSDhWMlhtWC9GbHp4RFBBYytFbGhpaUls?=
 =?utf-8?B?NVZlMzcvYUFqdjVFdEZXV0h2SzFNWFhEY3Q0MHdkZDdPNTFyb2hiYmZEVzBC?=
 =?utf-8?B?L1VWblZaZkJzU2VVNU81bDN5STFEMEIvMWJVd2VVVFgwRjBIaDFEZG5Tcndv?=
 =?utf-8?B?a1kydTU2aDY5cHdaOUd0REtJT3YvdjIwZE5ERmhLZ2lWdTNJYU84K0pOYW9n?=
 =?utf-8?B?WmJSOWQydGtvWlo4emc4azBUL0RzNHNWZmREUzdtdC8wUFN5M3VJMHlBTFly?=
 =?utf-8?B?U2JkeGF3UDY2ZFFaaEh0bkxvL0pzVW9icUg2NnZUdW51VkorVjlLbkFpTGFL?=
 =?utf-8?B?Mi8xV2Q2UVpBem9GekpMTHpqaTcvYk1ueEZZQjJuNWVDQjZQUmRSajgvZzV2?=
 =?utf-8?B?VWdVMU1sdlpjamZBUHQ4VDROMGRDemZ6QnhQZGxDUmFaR1FBWDBTbnIrZ09q?=
 =?utf-8?B?VE12dGZ5S29FWnpzeUlMSkFaYmJLL253MXZKeU5KRlcxQThkQ21zdTBZdUVS?=
 =?utf-8?B?MlNXSThMU28xL05QU2NKVXlEZTZZV29mVTA5ZWU4WGhuY214WU5LUkIyZlhK?=
 =?utf-8?B?bFB1Y21mSEduZGMraFZTU3NZVlc0QmpXUldQMzMwRG1lc2pqMXJSSCsvRHpM?=
 =?utf-8?B?N1lBL211bXFJaEtOcThheGpNeTRnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <617FDE081942D14FAF17A970A9374BBE@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e8590557-89fb-435f-2a9a-08dd49625794
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2025 23:34:48.1188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w2WVKFptVX9ORERo/qZjOmsKpwn55EF8eDQu1GyhUbTr68wuEkG3bp2hNUfwM7Rhurw9EskgmX3LeYvPZpQ+kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB5056

T24gU3VuLCAyMDI1LTAyLTA5IGF0IDEzOjM5IC0wODAwLCBSaWNrIE1hY2tsZW0gd3JvdGU6DQo+
IEhpLA0KPiANCj4gSSB0aG91Z2h0IEknZCBwb3N0IGhlcmUgaW5zdGVhZCBvZiBuZnN2NEBpZXRm
Lm9yZ8Kgc2luY2UgSQ0KPiB0aGluayB0aGUgTGludXggc2VydmVyIGhhcyBiZWVuIGltcGxlbWVu
dGluZyB0aGlzIHJlY2VudGx5Lg0KPiANCj4gSSBhbSBub3QgaW50ZXJlc3RlZCBpbiBtYWtpbmcg
dGhlIEZyZWVCU0QgTkZTdjQuMS80LjINCj4gc2VydmVyIGR5bmFtaWNhbGx5IHJlc2l6ZSBzbG90
IHRhYmxlcyBpbiBzZXNzaW9ucywgYnV0IEkgZG8NCj4gd2FudCB0byBtYWtlIHN1cmUgdGhlIEZy
ZWVCU0QgaGFuZGxlcyB0aGlzIGNhc2UgY29ycmVjdGx5Lg0KPiANCj4gSGVyZSBpcyB3aGF0IEkg
YmVsaWV2ZSBpcyBzdXBwb3NlZCB0byBiZSBkb25lOg0KPiBGb3IgZ3Jvd2luZyB0aGUgc2xvdCB0
YWJsZS4uLg0KPiAtIFNlcnZlci9yZXBsaWVyIHNlbmRzIFNFUVVFTkNFIHJlcGxpZXMgd2l0aCBi
b3RoDQo+IMKgwqAgc3JfaGlnaGVzdF9zbG90IGFuZCBzcl90YXJnZXRfaGlnaGVzdF9zbG90IHNl
dCB0byBhIGxhcmdlciB2YWx1ZS4NCj4gLS0+IFRoZSBjbGllbnQgY2FuIHRoZW4gdXNlIHRob3Nl
IHNsb3RzIHdpdGgNCj4gwqDCoMKgwqDCoCBzYV9zZXF1ZW5jZWlkIHNldCB0byAxIGZvciB0aGUg
Zmlyc3QgU0VRVUVOQ0Ugb3BlcmF0aW9uIG9uDQo+IMKgwqDCoMKgwqAgZWFjaCBvZiB0aGVtLg0K
PiANCj4gRm9yIHNocmlua2luZyB0aGUgc2xvdCB0YWJsZS4uLg0KPiAtIFNlcnZlci9yZXBsaWVy
IHNlbmRzIFNFUVVFTkNFIHJlcGxpZXMgd2l0aCBhIHNtYWxsZXINCj4gwqAgdmFsdWUgZm9yIHNy
X3RhcmdldF9oaWdoZXN0X3Nsb3QuDQo+IMKgIC0gVGhlIHNlcnZlci9yZXBsaWVyIHdhaXRzIGZv
ciB0aGUgY2xpZW50IHRvIGRvIGEgU0VRVUVOQ0UNCj4gwqDCoMKgwqAgb3BlcmF0aW9uIG9uIG9u
ZSBvZiB0aGUgc2xvdChzKSB3aGVyZSB0aGUgc2VydmVyIGhhcyByZXBsaWVkDQo+IMKgwqDCoMKg
IHdpdGggdGhlIHNtYWxsZXIgdmFsdWUgZm9yIHNyX3RhcmdldF9oaWdoZXN0X3Nsb3Qgd2l0aCBh
DQo+IMKgwqDCoMKgIHNhX2hpZ2hlc3Rfc2xvdCB2YWx1ZSA8PSB0byB0aGUgbmV3IHNtYWxsZXIN
Cj4gwqDCoMKgwqDCoCBzcl90YXJnZXRfaGlnaGVzdF9zbG90DQo+IMKgwqDCoMKgIC0gT25jZSB0
aGlzIGhhcHBlbnMsIHRoZSBzZXJ2ZXIvcmVwbGllciBjYW4gc2V0IHNyX2hpZ2hlc3Rfc2xvdA0K
PiDCoMKgwqDCoMKgwqDCoCB0byB0aGUgbG93ZXIgdmFsdWUgb2Ygc3JfdGFyZ2V0X2hpZ2hlc3Rf
c2xvdCBhbmQgdGhyb3cgdGhlDQo+IMKgwqDCoMKgwqDCoMKgwqAgc2xvdCB0YWJsZSBlbnRyaWVz
IGFib3ZlIHRoYXQgdmFsdWUgYXdheS4NCj4gLS0+IE9uY2UgdGhlIGNsaWVudCBzZWVzIGEgcmVw
bHkgd2l0aCBzcl90YXJnZXRfaGlnaGVzdF9zbG90IHNldA0KPiDCoMKgwqDCoMKgIHRvIHRoZSBs
b3dlciB2YWx1ZSwgaXQgc2hvdWxkIG5vdCBkbyBhbnkgYWRkaXRpb25hbCBTRVFVRU5DRQ0KPiDC
oMKgwqDCoMKgIG9wZXJhdGlvbnMgd2l0aCBhIHNhX3Nsb3RpZCA+IHNyX3RhcmdldF9oaWdoZXN0
X3Nsb3QNCj4gDQo+IERvZXMgdGhlIGFib3ZlIHNvdW5kIGNvcnJlY3Q/DQoNClRoZSBhYm92ZSBj
YXB0dXJlcyB0aGUgY2FzZSB3aGVyZSB0aGUgc2VydmVyIGlzIGFkanVzdGluZyB1c2luZw0KT1Bf
U0VRVUVOQ0UuIEhvd2V2ZXIgdGhlcmUgaXMgYW5vdGhlciBwb3RlbnRpYWwgbW9kZSB3aGVyZSB0
aGUgc2VydmVyDQpzZW5kcyBvdXQgYSBDQl9SRUNBTExfU0xPVC4NCg0KSW4gdGhlIGxhdHRlciBj
YXNlLCBpdCBpcyB1cCB0byB0aGUgY2xpZW50IHRvIHNlbmQgb3V0IGVub3VnaCBTRVFVRU5DRQ0K
b3BlcmF0aW9ucyBvbiB0aGUgZm9yd2FyZCBjaGFubmVsIHRvIGltcGxpY2l0bHkgYWNrbm93bGVk
Z2VzIHRoZSBjaGFuZ2UNCmluIHNsb3RzIHVzaW5nIHRoZSBzYV9oaWdoZXN0c2xvdCBmaWVsZCAo
c2VlIFJGQzg4ODEsIFNlY3Rpb24gMjAuOC4zKS4NCg0KSWYgdGhlIGNsaWVudCB3YXMgY29tcGxl
dGVseSBpZGxlIHdoZW4gaXQgcmVjZWl2ZWQgdGhlIENCX1JFQ0FMTF9TTE9ULA0KaXQgc2hvdWxk
IG9ubHkgbmVlZCB0byBzZW5kIG91dCAxIGV4dHJhIFNFUVVFTkNFIG9wLCBidXQgaWYgdXNpbmcg
UkRNQSwNCnRoZW4gaXQgaGFzIHRvIGtlZXAgcG91bmRpbmcgb3V0ICJSRE1BIHNlbmQiIG1lc3Nh
Z2VzIHVudGlsIHRoZSBSRE1BDQpjcmVkaXQgY291bnQgaGFzIGJlZW4gYnJvdWdodCBkb3duIHRv
by4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwg
SGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

