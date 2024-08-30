Return-Path: <linux-nfs+bounces-6022-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40091965514
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 04:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 621811C204FA
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 02:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35A61D131C;
	Fri, 30 Aug 2024 02:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Jw/oOMVS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2135.outbound.protection.outlook.com [40.107.93.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16B55D8F0;
	Fri, 30 Aug 2024 02:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724983695; cv=fail; b=jpuAjnJd3AYhPfTgV/e56WuS9VTzed+tgbECni5u8wdiwr7Y0om1ggVoPut61wb2NuTEwpgAvazoxYl6J7n0wfTfmPwY5dh7G9HNebh36qjlOdJEs31shT11trj1nWbL+lukuJcpb9Dkq6D5/mn1AL0pRXat5IZHPd4D3W+tGWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724983695; c=relaxed/simple;
	bh=Co2td06DvVAjrKYU0ltoT1PXXJyt4cDjQeXu3ZridIs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RZfINBOzs2sHY/HmV9TnoknAGcRCQaUDR+qky1Q/vs8QNIK3oWIU5+8gUAAWi+9g7QRsXsmfrEo6stidRoAenOR7XEURVrluup+QiSnkHVflPOK3i2N+IY1OGqAjWLmvUySIzq6Fq1FavW2J1ITPQbBRaHPDyOj0kGie1jyOIPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Jw/oOMVS; arc=fail smtp.client-ip=40.107.93.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nb8R6O3urw7fbrpqUoCSSR77VET4UXLZuerRRZdqRjMKVkC0XaJHUhI28HdFYlbIW2W9kxuBMOnPiq+VztKmg14iVzYjiH0i7qwLANezp9cA5MQg3tEs1mESgZnM7VaVAMK7UuQqUNW++ZuneuqNfUVWQ52bVnnyUTDWcykgKCKJkxfzeaKmrHlC0YsdV33h7GADVqsUkVWnEgT2MitufoSZIoLnPBL1gs4/NC6CDYD5NPJ/1De86LyVwO2w7IbrRQ8nYQqJfcqX6u7yVldewuMCzq98kSEesDu0vIe7FevkXmoIwKRP3akvorxT9cESZRnri9YjILqJF0KQMclUag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Co2td06DvVAjrKYU0ltoT1PXXJyt4cDjQeXu3ZridIs=;
 b=buTRKVbGVQqsfO3bmARuSdv4+uwv1CAKvBRw6WqAhy2uyYMgIvkrYV3BulvSFwH1COupo6sqKJkr7ViglsqOb6wBA9B1EzdWGV9GMy1eMd0TrbApv009V53036dPt4kiup6mhmMVDZtwRC6LLlAXAMWRKIetioBiLTBvpRo5f9XxME6akO+Uvmqb02zGEIkfXV8DtrPDOcl7AvsQbxw5vIVsczau81A1V6CFVq419Wz2Y+X6ZqmyDuypmco5M3fZdxk7vVkI5ovgsdODLSEbkWaLm0F4cTivbnPtH42emNpJU+hrFobPaCx0saTfUAJ6eJoNehSmC1rX/4VhcAfSqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Co2td06DvVAjrKYU0ltoT1PXXJyt4cDjQeXu3ZridIs=;
 b=Jw/oOMVSE874+OuqcT3y+kUzWjdUg8QobKUnZldHq2+HddguLGciDLdcUpk9N+54wcIGB9Fg5TA1OtC4gRbIcN4lVpLDQ9TPBQ/Nmp1RLSS8SCc7vioaCaFVCW3C9udsRCa3gtqrngrXmIG/ZP501CGBoFypU82G0ljM2CHXQEI=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DS7PR13MB4669.namprd13.prod.outlook.com (2603:10b6:5:3a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Fri, 30 Aug
 2024 02:08:10 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%4]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 02:08:10 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "davem@davemloft.net" <davem@davemloft.net>, "chuck.lever@oracle.com"
	<chuck.lever@oracle.com>, "anna@kernel.org" <anna@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "jlayton@kernel.org"
	<jlayton@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "yanzhen@vivo.com" <yanzhen@vivo.com>
CC: "opensource.kernel@vivo.com" <opensource.kernel@vivo.com>,
	"okorniev@redhat.com" <okorniev@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "tom@talpey.com" <tom@talpey.com>,
	"Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "neilb@suse.de" <neilb@suse.de>
Subject: Re: [PATCH net-next v1] sunrpc: Use ERR_CAST() to return
Thread-Topic: [PATCH net-next v1] sunrpc: Use ERR_CAST() to return
Thread-Index: AQHa+n3yO+KBUksFpUy0zaD9UE/y27I/De0A
Date: Fri, 30 Aug 2024 02:08:09 +0000
Message-ID: <dd97ad2754112d8b9251fc1a1ce0cd15fbfa7eb4.camel@hammerspace.com>
References: <20240830014216.3464642-1-yanzhen@vivo.com>
In-Reply-To: <20240830014216.3464642-1-yanzhen@vivo.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|DS7PR13MB4669:EE_
x-ms-office365-filtering-correlation-id: 4abce49b-407f-43b9-90f4-08dcc898988e
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U3YzeVkwZXZVaGxsOW8xNVRPcWJGRmo1dVhXdWJkZ0VOMEhMUHJFY28raXFK?=
 =?utf-8?B?cUc0ZmtYbWV5YmN5U2c2RDRUelVZNUF6UlM5dytZVTNKRS9VNW56QktaVFZl?=
 =?utf-8?B?Zi84dWZDWEVPWjNyTXkyM3VPcmR1ZlJOenp6bi83aFVTQjlvWjErN2tVeTVD?=
 =?utf-8?B?bzlXZlZBdU9OVmtJS25GcS80M3dMcExTeUlyZEEwV1RmN1h2a0tuU3BIWkpB?=
 =?utf-8?B?RzdYOHJOZ2VEWll3ZkVQcVJKOUxZYjNzOUNrQmJnWG9aSEorY0tGVWhldmpS?=
 =?utf-8?B?S1h2RFRrakR5UXg3dmtVMW1qNDJFelp0amVQR284b3k4QXlxUE1haXVxZU5U?=
 =?utf-8?B?Vk5acDRHbTV0aXoxZVd0dk9ZbnEwSDZMdSs3blY4NE5nZXFDZDBoZmhma1Mw?=
 =?utf-8?B?RVoyelBUMGc3L3pFdzA1aXZIWDN4cVVxejh1ekJwT1VNWHFjSzI1UG11blRo?=
 =?utf-8?B?T0pOMDNsMkdibkxsLzhCS083VVloL0w2KzdlbHhBM3ErWVN2Zko1REZtOVAx?=
 =?utf-8?B?RERRbkhPZmVvZkRiZTNWd0d1VTRIUnluRHVNL1pVN3F5dUk3Zmo1c2hDR3lE?=
 =?utf-8?B?dlBOcmRwVFg0T2dFSHk2OGFMUTFzdVh4TzBsVGx3azI5RXNIaG1MaUlrb1pQ?=
 =?utf-8?B?ZTZ1MFh0VklTaFp1MXJkWm5iNFhvK3Q5eWs3bGR3YWJoNDBLTi8yeGtBTlZo?=
 =?utf-8?B?N1c1Y0tpd3VFUTZJbFVaTkxVZ2NFN2pGTC9ZZmJhd2svaFJwYW91L1NoWFJC?=
 =?utf-8?B?NnRNellDQ2pWWXdFc3NOMklJUFZxeVhjaUJyZmVHbmlqMWxwNzhuNWtRNGoz?=
 =?utf-8?B?UzVySkNBekFGV21CRWozTHR6T1YxQnlMcXE4TlVVdEUvRDFHbXFIY3pVRUt0?=
 =?utf-8?B?RXlxV09xL3IvY2tyY2ZacVFudnlOVk9jRWs4eFRQNWs3YnVQb3J1aWV5K09K?=
 =?utf-8?B?WmpoNndiSUVEQVFCbWJrYmtXTzFzUGltUjV0ZGx4bU90bTUwUlV5VkpNWlFY?=
 =?utf-8?B?K0lmQzRCc2VJeVczeU96ZW9McEMxbHkvcTM4cjB3NzVBS0J5L090UExVei84?=
 =?utf-8?B?Z0FOaVFyN0tKVGVhbENWR3A2VmxtcW5YcHRFZnZNcHVHWE1KaEZ6MkZiV0J3?=
 =?utf-8?B?RFZITjRyWklzWHhhRW9BNSt0cS9ZbjFCOGFqTGRpUlJPUlJPbEtoZXhydlBS?=
 =?utf-8?B?dVZKYVBlTktUNHgwcEdzaWNuOTNOalZGclc0YWVQMnFMRktmVGgraDhXaHdK?=
 =?utf-8?B?Q1VwRVZJR0VBUTd3cVRXaE85NWk3SkdITVBBV2Y0MUNGcWw4Y2grbVVmTVBO?=
 =?utf-8?B?VWhWYkpLY2pjU0I3N1dTdGVmZm5EVm0vNGFBcDdGMXdQOEpEVXNmRy9zSFpP?=
 =?utf-8?B?cUNFTXFsTTlVRCtaRmNRRHRmOVNzMVA1YXlNU0dGeG50WlA5eEdmMTBzbnVG?=
 =?utf-8?B?TWdZR2lMeEZyN0p5WXdqUXhUSllFRzUxZHlHWWppd1d4eEtQWmdYVVdpYldq?=
 =?utf-8?B?QVgybW9Xc1RMajFUTHFETHlIZWFSUmJybkpsazNYY3BWYnM3dWhxZUNpWlE3?=
 =?utf-8?B?bjNIc0FrQml2enJsNWNvMjdpMVF0VGJRRVNmeE9sWjRNMlptdUR6Q0x5akVk?=
 =?utf-8?B?eGlTRXFmZitheExqL1YzTEF3NU1XN0ZqYzlUclJRT2NrcFVEdmh2YTRYaGJq?=
 =?utf-8?B?dHhHZVdzeUxndTVqUVVIbVQyMFp3b01YTWprdmpoTHdUdkdtc3ZLNi8zWHhF?=
 =?utf-8?B?THRKVFpOaTlVMjBhNjAzd2NIc3lHc1laWkRXeUFMVDJVVjF5aWZ6Q0k0UktZ?=
 =?utf-8?B?V1h4ZWRIOU9hK3RsWWFXVjZOSit5RnM3dkQ4OEJqTUwwQmVwUWwyaTJmbEpl?=
 =?utf-8?B?UXRaQVdKUUpPY1grczZVRzB6Q3oyZHVFSmc2bVVMdWRMY0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V2Q1MTJ6YnZtb1ZpYXRTRFd3d2VNa09hWnFkZjZ3dTJGYmNVSldEWTZxOXZk?=
 =?utf-8?B?WmZrbHdSMk9iQXR5RExYYkNpMFJQUVN5WnpxMUJTd2hmU2hBMlJXak1hMnFY?=
 =?utf-8?B?YTNCaFhReU1oNmxidDg3VWJCL083eUh5a3hnelVrKzVQb0I4ME1WRS8rRnpL?=
 =?utf-8?B?TUpDT0o3V2tndzdSZFJ4dGp5OHVNbmJRdm5XdG42a05VeTNrNjNubS93YXBw?=
 =?utf-8?B?amt6NE5sVE9NaEs3cmpyYzlPTEJNSzYwWTdHTnBpelNUYlZVZWFHMXBWb2xy?=
 =?utf-8?B?Vnk0Rk41aE1XeXdkbU1rTjl5Q3pyQ3U5RXlzNEQ3QnE2aFRPN0pETTl6OVR4?=
 =?utf-8?B?dzh6bks5OVl3SGcxSU9zUXNZd1ozY3Y1MnNJamdCbGx0YnZrdUM5NnlMYTNQ?=
 =?utf-8?B?ZzdaTlQrS2hJVS9XQjI4V21OZVRXZll3d0xVWThSd1UwS2UydEFPTEhYQlZm?=
 =?utf-8?B?NTdGc3FST1hqTzl6VUVIazdLUVJMN3JPZTZoUnpnejd5M0FkQ05oUVFkZEx4?=
 =?utf-8?B?YjF1UzBPcko1NGRYeHR6Y3ZEVEl1cDBOdDNDbUFwdkxJNlM1WDMrMFVyTHE1?=
 =?utf-8?B?K0ZHNGRXamJTTG5Pc0Zxb04xU0pJYVZDTzRTMldKVWFOc0gyeFAvdmdSNXhz?=
 =?utf-8?B?OHk0TGdEa3FETXk4YkNKaWRjOFFRZWM3Yk9LTDRVdjA0RG1lOWFranVwT0g2?=
 =?utf-8?B?L0hTWlRkRVNwb3A4TERKd080OEZjTDNybXFuUzZhSHJYQ0pZTFRldDAyK2hS?=
 =?utf-8?B?bTNzbExLZ2l4RlJPOTIyeGlVbFFlZUFvSzdwbEN5anRRY0VOanBZR2VvVlhh?=
 =?utf-8?B?a00yeExUdDV4WUNyTDNqK2ZGWDJ2SkhCTTNCaVE3a1dyR0Q4d3pTSzF3dTNq?=
 =?utf-8?B?bXFwTUoyUlM1bnNaNmtza0JWekIyNFFMZDdkcHFTanZPRitCUzlSWmZwSCtE?=
 =?utf-8?B?SlBreWMwWHIyb001eVNycTNmN1haWnZVdlFaYzRlamtxL3pybGxZMStCcjFQ?=
 =?utf-8?B?cWYyMDZKR0dZOGg3SnhBMk1IUU15dTl0K0l5SlFZRUNxekxuWnlGektpeE5H?=
 =?utf-8?B?YmpjckdITU5FQzVpcEo3bU1Ua1ZEckZ3aUd1NnhLdFRRY09lUFROalpKTjdv?=
 =?utf-8?B?NTgveFR4cU54aFRPeFBtb1NDTWFsNWNEaVBZT2JJc3BtbnZHSDZzRGduNW9I?=
 =?utf-8?B?a3pQZVJQMGQwMExTOTBBQkpBRlRsU1lXMW9mTFNIc2xsREVmN241b3Bob1NO?=
 =?utf-8?B?b3BYVFBwNkU5MFpibmdHdHArMkg4dFVVY2VBeEhzVEVEbC9sRDNBRmJxb2ox?=
 =?utf-8?B?c2dHWTVtc09va250clBHc1RUcjVXWVQ0NTdBckd4cWNMTmpwR1FRTEVPSFZF?=
 =?utf-8?B?TXNqY1p6a1FRMU9MK3hXVU5ZYnhwVEFlZTFOSUVIcnhMOVNmZEhCZFZRM3Jw?=
 =?utf-8?B?eWltMDF4VUkwNTg3Y25TeEpQWWdnODBxMGZyVzRSY1diRUYzMFYxUnZZTDRE?=
 =?utf-8?B?NFJsVThFS2wzc2xoUTNQVXArOU5Jb3BKcmZwcC9NWHV2ZFM5b2VsM2tScUYy?=
 =?utf-8?B?bXY1UzJ6WVJaV09YNzNMVUlPK0lIMFpyejh5WTZqajVGaEtNZHFDZXAzVk5L?=
 =?utf-8?B?cTJvZ1ByYy9uSnJYQXZFTmNkaVhCMzNOTDJDQzU2SVdSTWhBWUdjSURsU1Zj?=
 =?utf-8?B?d2g1b0d1SFFuTDI0WnIrUldiQ3ZzUnJBWlBlaEkyL0lXelJFWkFyREwvbVJL?=
 =?utf-8?B?UFhsOEx2NnBDSE1EcmhKZEdMa0h2cm1wRDZ1cTVvbVYxb1MrRllhR3N5OEl5?=
 =?utf-8?B?aVNRa0EwT2I5TmtNQ0xYOFcxbFc4QXB2YzBJaitoakkrYzRld0llRldqV0Fs?=
 =?utf-8?B?NmQvZ1JNSDlFMTVqSEdGTVZuTUdGZ1c0Sk80YVQ2WW4yZi9PWWttcXdFU0Jv?=
 =?utf-8?B?Y1QzbnEwaTZYWXpycmNrdEx0bnBjYVBZTTB1cUJxWXZFVDVWM1F5QVFyY1hC?=
 =?utf-8?B?L3ZLYU5DeGp4ZmRKcDdwZkgySXNGYmM4dERwVTBYK3M5NXY2RUI1MSt1NnNm?=
 =?utf-8?B?MHhhZUhzUExsRGdLUlRqMHd2eUlmc25QMXhEUXlTcmM4ZHVoekJMd1VML1h5?=
 =?utf-8?B?dVZ1d2hZdCtVeG4yd0dVZ1dFemVHaE5HMlZyZ1llUkpCblR5V0haRFVKL2Rz?=
 =?utf-8?B?Q3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0476E4CD52C2314990D6338CA9B5ADCF@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4abce49b-407f-43b9-90f4-08dcc898988e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2024 02:08:09.9212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ULuKzW8gRzQJqWyJuX/qZ8FSOrlPeAetlLb0AE6Twoj5Pxc9ZtVaKCHSw965Ejn5ghTzwMd7fd+6H5AVwShkBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR13MB4669

T24gRnJpLCAyMDI0LTA4LTMwIGF0IDA5OjQyICswODAwLCBZYW4gWmhlbiB3cm90ZToNCj4gVXNp
bmcgRVJSX0NBU1QoKSBpcyBtb3JlIHJlYXNvbmFibGUgYW5kIHNhZmVyLCBXaGVuIGl0IGlzIG5l
Y2Vzc2FyeQ0KPiB0byBjb252ZXJ0IHRoZSB0eXBlIG9mIGFuIGVycm9yIHBvaW50ZXIgYW5kIHJl
dHVybiBpdC4NCg0Kc3RhdGljIGlubGluZSB2b2lkICogX19tdXN0X2NoZWNrIEVSUl9DQVNUKF9f
Zm9yY2UgY29uc3Qgdm9pZCAqcHRyKQ0Kew0KICAgICAgICAvKiBjYXN0IGF3YXkgdGhlIGNvbnN0
ICovDQogICAgICAgIHJldHVybiAodm9pZCAqKSBwdHI7DQp9DQoNClRoYXQgZnVuY3Rpb24gaXMg
bGl0ZXJhbGx5IGp1c3QgZG9pbmcgYW4gaW1wbGljaXQgY2FzdCBmcm9tIHdoYXRldmVyDQpwb2lu
dGVyIHR5cGUgaXQgaXMgbm93LCB0byBhICdjb25zdCB2b2lkIConIGFuZCB0aGVuIHRvIGEgJ3Zv
aWQgKicsDQp3aGljaCB0aGVuIGdldHMgaW1wbGljaXRseSBjYXN0IHRvIHdoYXRldmVyIHR5cGUg
dGhlIGNhbGxlciBpcw0KZXhwZWN0aW5nLiBFeGFjdGx5IGhvdyBpcyB0aGF0ICJzYWZlciIgdGhh
biB0aGUgY3VycmVudCBleHBsaWNpdCBjYXN0Pw0KDQpXaGlsZSBpdCBpcyBncmVhdCB0aGF0IEVS
Ul9DQVNUKCkgZXhpc3RzLCBhbmQgSSBhZ3JlZSB0aGF0IGl0IHNob3VsZCBiZQ0KcHJlZmVycmVk
IGluIG5ld2VyIGNvZGUgZm9yIHRoZSAoc29sZSAoISkpIHJlYXNvbiB0aGF0IGl0IGRvY3VtZW50
cw0KdGhhdCB3ZSBleHBlY3QgdGhpcyB0byBiZSBhbiBlcnJvciwgSSBzZWUgbm8gcmVhc29uIHdo
eSBpdCBpcw0KaW1wZXJhdGl2ZSB0byBhcHBseSB0aGF0IGNoYW5nZSB0byBleGlzdGluZyBjb2Rl
LiBQYXJ0aWN1bGFybHkgbm90IGFzIGENCnN0YW5kYWxvbmUgcGF0Y2guDQoNClNvIE5BQ0sgZm9y
IG5vdy4NCg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFp
bmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

