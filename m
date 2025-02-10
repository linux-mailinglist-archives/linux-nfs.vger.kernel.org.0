Return-Path: <linux-nfs+bounces-10028-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D86BA2F841
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 20:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8E9018876C2
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 19:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8371F4625;
	Mon, 10 Feb 2025 19:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="MREc+Nsh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2092.outbound.protection.outlook.com [40.107.95.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F402A25E462
	for <linux-nfs@vger.kernel.org>; Mon, 10 Feb 2025 19:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739214682; cv=fail; b=a1Xwf61UYguU92ARA0KRBeSgqI4evN2XkTYoLNrJohRTVGIqivNLR/aEximYk7sW3H3A0QK+anGIP2q+PAAevpC0c97eS/fT0xiTJ3CxnSypertU7i62l6HbEQ1zMcjIv9bXy0dFMBiQGLBnKaBiyRUit3IhrUjPFg4kl+bHRPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739214682; c=relaxed/simple;
	bh=X0YIdU41o3P2JsjzBF32pnkX2wrLizCjvsDjRq27Tm4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ua86xqgkCO4N4IRj3/wd3posApXccEf7ZFT7WJ8rfKY+vWcPsSRW7BAkrH9h90onqZCWp3S2pI0tJnkNm7Fv5TjeNjbvBaWIvtm2yk/7HuvVEBpbOzu8vfXadYm68zQER5e9NknXjB9Cy15EQXSuVa7CRX+5Nn1X1YR+kADEaS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=MREc+Nsh; arc=fail smtp.client-ip=40.107.95.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W93v9nbn8lmu+2WpMFOp201AJvgz/dBi/mJ6XhZez9XUblOpxK2ofc4gaQ0l4mEwxGccQ5yrikty/H7zI9FM6H4Mtu8+R0ItBjEmTkvlNZUevtUxs/4to+YE089Nu2vQ/IFLK7RsjWu/qZEU8LkdvnJtTP2K+6enHMHzY32vNW7ehc8ZN2YjspF0Q50i7k2gMUc+OHzW185++tqwUF1Eie04SAb41vYBM5S+YW9M55XvnsKkg9fY5dYdCHIYuiXy+7uRgbkz2ly5VU/fe/OFpERgkjihwPnkaiGsXurcB+yxn+U43JHyBo+uHchzMOpuhcUkCvcUn5iU6a+/Wd7ufA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0YIdU41o3P2JsjzBF32pnkX2wrLizCjvsDjRq27Tm4=;
 b=alLULU5TUsk3kZm+kxqB78x+URla1eU+llUqgma3yHo6gi7K1LdRkkq93xN36HOA9Oj0J+TqBCZtNDBNRdVUtW0PeaH9E++gw/kBCceHdp6MhmPxUmjR0Igh7roEZTeGndhELN60S6wOdZXb9IUAZPl2Mgi+3bseUgUj34/fqvmVpzfCv0d240+1k9CMGCfgPAupqbqkUPS1rg772rX8KlXvbqOMCZgbBjr3YXwcl0KzNdcxhAuHHogyw/rFJdAyTQsxA3GrWDAxxFNX5z+/qV3MGtnOAaYeby17xVyaANCoFerFkpsNLeSW35ZZ4mXWFVT23LxPj5NiLTwsMWHjCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0YIdU41o3P2JsjzBF32pnkX2wrLizCjvsDjRq27Tm4=;
 b=MREc+NshLqH2XcKPsMbeb5fohonOJQPrFs42jfEk7sJQL6nNNmfTsWMUEZc2CWeWjkQsHzp+PmeeM7rkPX3U8SlvZ88ntVy5YGWQf+tXjkhN2ZJWpv5s4ZObmT+NirmcK9DG+ByMXQsRQEvlJ6bO+gN6uxnHfYylfdnl6T8g520=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SA0PR13MB6004.namprd13.prod.outlook.com (2603:10b6:806:152::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 19:11:17 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%3]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 19:11:16 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "tom@talpey.com" <tom@talpey.com>, "rick.macklem@gmail.com"
	<rick.macklem@gmail.com>, "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: resizing slot tables for sessions
Thread-Topic: resizing slot tables for sessions
Thread-Index: AQHbezsyY9r+XcliDEC8smCfQFqGNLM/n/KAgAAhe4CAAM4IAIAARz0AgAAR8gA=
Date: Mon, 10 Feb 2025 19:11:16 +0000
Message-ID: <8e25d16b9d94179cd9214f46ca214012116ff7bd.camel@hammerspace.com>
References:
 <CAM5tNy4f9YyMhYRydudNkCqzVp5f8Np6N25NOT=-+TjJN2ewqg@mail.gmail.com>
	 <884876492c56e76fd6fbb4c5c4fb08ee14de9fe1.camel@hammerspace.com>
	 <CAM5tNy5yv1CkVc3z0dTJ_Fed9mP-ZBug1L39Jnau48s=OnSPvA@mail.gmail.com>
	 <a9127b76-29f3-4782-ba9b-dff1ebf6f647@oracle.com>
	 <e937d6d9-9d58-4c09-aeed-9b7e676d8799@talpey.com>
In-Reply-To: <e937d6d9-9d58-4c09-aeed-9b7e676d8799@talpey.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SA0PR13MB6004:EE_
x-ms-office365-filtering-correlation-id: 4fd195af-06bd-4d83-9f47-08dd4a06b193
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U2VoNDdiWjIyeFVBNzF6SmRocHZFTjlYQkdKSE8wakFabkd2K2dEa2RJOTZt?=
 =?utf-8?B?ZGF4YmJWRWhPeXYydTA3OXNuRldlTEdOR0N4NmtucXNFMTREd25uOFRWcXVZ?=
 =?utf-8?B?OVhEOUZMSHU2cGdIT2tjaE4vL3laVEFRRHBnM2J5MXZZQ0lieURuRHZsNjJH?=
 =?utf-8?B?YjF2Vm53ZjYxQzA2NDUrQjlmdmZ0bmRlU2ZiQ28yaldxQ01MMjFOaTBGTXBt?=
 =?utf-8?B?a29VMEc3UW1BcENHbUNaOHhKZEhrU2Z2T29lamZ3SmFPQlJ0N2xPUHozaG5O?=
 =?utf-8?B?R0lkNDAxZ3FTZWlZdHZYVkIrQXZhZ2hRbTBrOXJkQS9hYmZPek9nOVVQVW1u?=
 =?utf-8?B?NDM4cXpOUTh6Y1FuZ0RQOUFLdGpSZVhtc0ZKWVBGYjNOTWwzd2UrVGFtRHVh?=
 =?utf-8?B?Ym40OUZielpjN0xDM1JYY0tEdjdnM2I4VTJmdEFkNDFvcmRFVUJpZXNxZ1dT?=
 =?utf-8?B?QjR6ZnJvWWFxTHUwbVN6YVp6dllYaS9jSjRYT1FmUnhwTXRqTml4SGs5Q3cz?=
 =?utf-8?B?anRDZjBQOEZKUDhMNjFqZERVYlozQkMxOXgvbXA0cTA5ZTN6K1Erck50YU5m?=
 =?utf-8?B?cnRPRHVPcUdVY1ZLWUZJbG9taDY4bmVqdEdyNmlSalhTbitqaUMrdWNaVXk3?=
 =?utf-8?B?K3RqY2RDUy9zWHJnVDgrVG9BbEhLd0FWTWhpaVJ1VmJLaW9OMjF3M0taMmNS?=
 =?utf-8?B?WFFyQmVSYkF5Vmt2RHNuWUFjTEZIWDJ1bHRqaVdQdWhNMWt1NVlRbVV6WEJG?=
 =?utf-8?B?d2ZuYzJZSVF6WnlBTmZFZ3dRMVFQRFlEYzh0Q3FFcE5mNVR2b3ZNemI0NTJW?=
 =?utf-8?B?MEZZSlVJNGNIRWxGZ2RhUXREQlBPaUIzS295NVdHYmM4VzZHN1JTU3E4NGl3?=
 =?utf-8?B?d3NkSmJjSUduYzcwblhhZmJVZzgvZnoxVVQzbUkvK3I3ZU5iMVNXR3ExMDdL?=
 =?utf-8?B?U3JWaWQ4Yzhvamd0YVJaK2NhMFIycEZCVlVwVTI4dzE3UENsajF4SFBheUk0?=
 =?utf-8?B?eGZSTVg3aDlrNi8vYUt4dGM4bjUrU1NWbTlHbWx5YXBDd28ySlJyUzI3L2JI?=
 =?utf-8?B?V2grLzI1bXIwdTh4N1FON0w3L2d5ZGIvZXYra1dMRWRHM0VOaEVFOEJ3N0xr?=
 =?utf-8?B?RmtuL1Z1OStYY1Y3bkhCYVhQT3pRejFOSDV1SS8xYnZzQU5RSlVMaVZGSUZl?=
 =?utf-8?B?bXRHZlRtRjN4UWMrOHhZYzVzTFc2c2U1aVgzdEEwbXFOK25DR0hRUmFiM3FE?=
 =?utf-8?B?RWdJSEJrR3l2VUdUYzQ3M1JUWFdXdjNVOEZsUis1RFVwaThXV0VHUzROQ1FJ?=
 =?utf-8?B?RFlrZm9tdHVJNm9EcEp5djFZZVBXejFrNnFEVjd6dWg5Wlg2TDBXbVBMT2pI?=
 =?utf-8?B?YkdHcy9vNm8reTJuRnF4VWdidFByYlQrV0RORUxpMzFYMm5kdjVpanF4alZs?=
 =?utf-8?B?TEh3Mk5Vc1U3S3lReTVJeE9xMW1GSGdhZWszTk5qT01rby8rMjEvMEd2b2Nj?=
 =?utf-8?B?VlBaTXdqeVBNbzlMa0c3Mk1TUzdqMWR3dDVCbDhJY2MyY1dpMmEwYUJ5SDl3?=
 =?utf-8?B?SDhVOVFlbjVHdjhJN2NzK2d6UXhXRFQ3TFdTUkx0QlI4ejhnMForZno2d3Ft?=
 =?utf-8?B?cEhOLzFpeHBSVUdLZUlYNWFvL2xrQU80Y3c1RkxOVEJRWXE3cmQyT20rT29j?=
 =?utf-8?B?b0U4MDhFTUIwbVVPVktDUStScG9NY0JMSkowclprS3Fob0ZqMjBMTnJjMG4z?=
 =?utf-8?B?T0E1ZnJZWTU4Wml0a0RocXd4UFZDSnJScHo0ZHJmUEs2aGF0L2ZPN21tVldW?=
 =?utf-8?B?VEtjdWxqajlZVWFMb1ZZK0hHd0NYYURiZUFMMk1RQjYyR3dmMTJmK2g3VDFv?=
 =?utf-8?B?S3VJSkVVeDJybmRZb1JjQ29FSzFORFMrQWQrNWFySDkxcTZxNHh4RHI1cllD?=
 =?utf-8?Q?vGsYdTDvdh+dt4FbVHbBz89mkqCWCzgN?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TEowTnMram8rbTBqcWlRRHRoYm5laUhOZlduOFhYczFzL3NuaVlDU0FXbW5r?=
 =?utf-8?B?WW1PVExyMHhkU1pHWlhqM0pjQXZTNTlaWGNZd1NJT3RKWThlUVVaVFRxYVBn?=
 =?utf-8?B?cXVJYi9tZEJyT2VlNDcyREhPN21wOVhCbkxWU2JWNlRrWHVZZko2aDEvcndH?=
 =?utf-8?B?eGM0QlhUZzJCQ0dVZks3UzJ0dVdtSjM1TE5SS24wQ0s4cEJWZVQ3TjRkanNY?=
 =?utf-8?B?bmlFVUk3OHA2NWlRK1VBdzZtOTh2VTRpWFlGVW5OdlFRYmhINUQzejNHdlF3?=
 =?utf-8?B?TTVrbnRmeXpvVnFwcmhFRnFVdnMxUkdRcjdMQURlOWFPWEpwK3pNK1pTK3ZK?=
 =?utf-8?B?NGQzc2wyVHg5cTcrTnp4aUNPRTNaMEFJUnBVM1p1WGZVQXB3cUwvYXF4bDVL?=
 =?utf-8?B?UzVLdDk0ZVp6KzZTZ2VVd2lKaWxWMkdLMTJmcTZLTDNRWkN5am13QjVqVmtx?=
 =?utf-8?B?UWh3V1l5WDlHQVhySVg3bXpaN2hNeWhmZk9wWEp5NFhEUXFVTnNxNHNhNXBR?=
 =?utf-8?B?TTl0QjhEUmxFMkZwTlRLczgyWlRMcTFUbk10aVBBUW40MFJlYVJxeVZSanNP?=
 =?utf-8?B?elRiRk1JdmJXaVVHTUtDb2duR1hZUjF6M1gxYm5QbXJoOTVaeTArVWJJc1h0?=
 =?utf-8?B?NkVScDl5azdMcGdySzlRZjVqYm5MQk5tUGRoWmFyemc0ZEpFZklWNFc1YTZh?=
 =?utf-8?B?cEJLSE5jM3g2TmZjQTV3TTYxU2lPNTRFd0FnZ1oxUU1oY3J0N3lNMWVqOG4y?=
 =?utf-8?B?cWszTEF1VHM5RHN2WWdNMzJ2a2pJN09aazB3U1hyR3FSOGQ1a2tWdDdISmRs?=
 =?utf-8?B?aUt5d0pVZFIyS3VRVEJXMmtJVFpJdnN2QXQ3SXJaWkJHTmNLYXYzOFF1UVpo?=
 =?utf-8?B?aWhFSnNSUHAzZXlEZ1RPdWJhUDE1TlVERldlWDdVWCtXdFBtbHgxbitmVHQy?=
 =?utf-8?B?MDU0THVuRUJDNmNCWnJsWjh2QlRxVmpNQytTZEszMkUvc3F4UXJyQlFneTRZ?=
 =?utf-8?B?VStiRy9Ob25rN0Q5eWNhamIvYTdsUGVZQTVWM2E5RWpsQWVsNnZ3UDR1c2Fn?=
 =?utf-8?B?WUpMeG5mcURIVDZadHdSZ1F6cDFPekdoTFZQUk03eTdzYXViWFZ0eDFjV1Jo?=
 =?utf-8?B?dzc2ZlVkZ0p2a3FISjZjUEg5VENOUWk2aENNYlpHd2kzQkRwNzAxbng2K2tP?=
 =?utf-8?B?SUlDRGF4alk0WmRrRzFnV3REaUxpUkFBaFBVd0x0L2d1NE1tWCtGN1dJWDRk?=
 =?utf-8?B?dEpmNCtQSFc3L3c0bk9SM0FGTWYwQWVpSEdERXdPOXpyRjNYWXdXdzFrOVhE?=
 =?utf-8?B?d1B1NXVoZVdIQWZHeTlZdm1ZSjFoMFBuL3NFcWV3VkY2MVE2aDE2M2Z3UDdn?=
 =?utf-8?B?MUpoTXNxcDVYNjJGOU4zNVJnQzFZUGNnd29SK2RJUEorNnRydklzSEx0TzBu?=
 =?utf-8?B?UzNFQjJObFFNclJ2V3lHcXV4WnRNWWVtd1o0Zzc5eEJUYUNhMnU3Rng0L0Nr?=
 =?utf-8?B?eE1Ia3NSY0NsclovWVBJMU9XaGdNSGlqNnpRSXB0REc0U21QTzdRclhCNjB4?=
 =?utf-8?B?aFIrcDdvREZCeUJ0TkpIQnUyczZaZnNLaXdzRFgwVjRUVHQ3YXlJQXY1NG5S?=
 =?utf-8?B?dTJaaldGcVdPS3lhSzNLRVl0YkM0clBMWE15MENzUXJJQ2tQN1hkVW1qdGh3?=
 =?utf-8?B?YitCcXExc3FtWU1ZQi9ySm9sUG5WYUdCSWFHOTQyTW9pbjRaQ25rNFNZTnJ5?=
 =?utf-8?B?b2YvUkJBZWdEMkR4M3VMK2hRamNJNitzMS9PWU93YmtMVUFKVy9ONDdONUN5?=
 =?utf-8?B?U2hDeXRkZGF6dlRoaFBtd3BYZ1F3YmR3R3NITGdOdE52UWYzaWJzeVVOU2J2?=
 =?utf-8?B?MDdyRTgzUDA2S0tVUUNHajJOek1NdFI3RWl2U2dIMWwxaVg3R2V0QW1pLzRI?=
 =?utf-8?B?OWpkclNBM2pIWm1Xci8zV0k3L1MwVmhWOXVEMlMzRDlyMkU1dE43cSswUUl2?=
 =?utf-8?B?bGkySStYSGQ0ZjR4TjczZHhZdnR5Y01hK3FoZUZjRS9PMmF2S2ozYkVtVTNM?=
 =?utf-8?B?VFB4Q2lqN0VrZk5RV0U4VTFqWGgxb0kzRkRldnJDNklzZjRONUZiUURBSm5v?=
 =?utf-8?B?Yk1GZXBZVVVHMDA2b2Z3ZlRzc2Ryd0Z6UzArN01NUU1OeDZtV2lHNGpwY3pw?=
 =?utf-8?B?bVdFZXRFcjgwK3h0TVFrQTlnZHdBelRQOE1oSlpoekgyczNsY3BkL0hxc2F3?=
 =?utf-8?B?ajVKUXJDZFFMYXMwNlUvdVdxK2dnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDB43364AA13A149B7CF3EC58BEB8099@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd195af-06bd-4d83-9f47-08dd4a06b193
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2025 19:11:16.5706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xw82DJtWz4u6sTQA0pBXNLgOgW57gdCGwiAgDPZ3rYzOJ99o+dTmpXX9W2mkchNc4kWEnFNKW5kA2v78k8PORg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR13MB6004

T24gTW9uLCAyMDI1LTAyLTEwIGF0IDEzOjA3IC0wNTAwLCBUb20gVGFscGV5IHdyb3RlOg0KPiBP
biAyLzEwLzIwMjUgODo1MiBBTSwgQ2h1Y2sgTGV2ZXIgd3JvdGU6DQo+ID4gT24gMi85LzI1IDg6
MzQgUE0sIFJpY2sgTWFja2xlbSB3cm90ZToNCj4gPiA+IE9uIFN1biwgRmViIDksIDIwMjUgYXQg
MzozNOKAr1BNIFRyb25kIE15a2xlYnVzdA0KPiA+ID4gPHRyb25kbXlAaGFtbWVyc3BhY2UuY29t
PiB3cm90ZToNCj4gPiA+ID4gDQo+ID4gPiA+IE9uIFN1biwgMjAyNS0wMi0wOSBhdCAxMzozOSAt
MDgwMCwgUmljayBNYWNrbGVtIHdyb3RlOg0KPiA+ID4gPiA+IEhpLA0KPiA+ID4gPiA+IA0KPiA+
ID4gPiA+IEkgdGhvdWdodCBJJ2QgcG9zdCBoZXJlIGluc3RlYWQgb2YgbmZzdjRAaWV0Zi5vcmfC
oHNpbmNlIEkNCj4gPiA+ID4gPiB0aGluayB0aGUgTGludXggc2VydmVyIGhhcyBiZWVuIGltcGxl
bWVudGluZyB0aGlzIHJlY2VudGx5Lg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEkgYW0gbm90IGlu
dGVyZXN0ZWQgaW4gbWFraW5nIHRoZSBGcmVlQlNEIE5GU3Y0LjEvNC4yDQo+ID4gPiA+ID4gc2Vy
dmVyIGR5bmFtaWNhbGx5IHJlc2l6ZSBzbG90IHRhYmxlcyBpbiBzZXNzaW9ucywgYnV0IEkgZG8N
Cj4gPiA+ID4gPiB3YW50IHRvIG1ha2Ugc3VyZSB0aGUgRnJlZUJTRCBoYW5kbGVzIHRoaXMgY2Fz
ZSBjb3JyZWN0bHkuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSGVyZSBpcyB3aGF0IEkgYmVsaWV2
ZSBpcyBzdXBwb3NlZCB0byBiZSBkb25lOg0KPiA+ID4gPiA+IEZvciBncm93aW5nIHRoZSBzbG90
IHRhYmxlLi4uDQo+ID4gPiA+ID4gLSBTZXJ2ZXIvcmVwbGllciBzZW5kcyBTRVFVRU5DRSByZXBs
aWVzIHdpdGggYm90aA0KPiA+ID4gPiA+IMKgwqDCoCBzcl9oaWdoZXN0X3Nsb3QgYW5kIHNyX3Rh
cmdldF9oaWdoZXN0X3Nsb3Qgc2V0IHRvIGENCj4gPiA+ID4gPiBsYXJnZXIgdmFsdWUuDQo+ID4g
PiA+ID4gLS0+IFRoZSBjbGllbnQgY2FuIHRoZW4gdXNlIHRob3NlIHNsb3RzIHdpdGgNCj4gPiA+
ID4gPiDCoMKgwqDCoMKgwqAgc2Ffc2VxdWVuY2VpZCBzZXQgdG8gMSBmb3IgdGhlIGZpcnN0IFNF
UVVFTkNFDQo+ID4gPiA+ID4gb3BlcmF0aW9uIG9uDQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgIGVh
Y2ggb2YgdGhlbS4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBGb3Igc2hyaW5raW5nIHRoZSBzbG90
IHRhYmxlLi4uDQo+ID4gPiA+ID4gLSBTZXJ2ZXIvcmVwbGllciBzZW5kcyBTRVFVRU5DRSByZXBs
aWVzIHdpdGggYSBzbWFsbGVyDQo+ID4gPiA+ID4gwqDCoCB2YWx1ZSBmb3Igc3JfdGFyZ2V0X2hp
Z2hlc3Rfc2xvdC4NCj4gPiA+ID4gPiDCoMKgIC0gVGhlIHNlcnZlci9yZXBsaWVyIHdhaXRzIGZv
ciB0aGUgY2xpZW50IHRvIGRvIGEgU0VRVUVOQ0UNCj4gPiA+ID4gPiDCoMKgwqDCoMKgIG9wZXJh
dGlvbiBvbiBvbmUgb2YgdGhlIHNsb3Qocykgd2hlcmUgdGhlIHNlcnZlciBoYXMNCj4gPiA+ID4g
PiByZXBsaWVkDQo+ID4gPiA+ID4gwqDCoMKgwqDCoCB3aXRoIHRoZSBzbWFsbGVyIHZhbHVlIGZv
ciBzcl90YXJnZXRfaGlnaGVzdF9zbG90IHdpdGgNCj4gPiA+ID4gPiBhDQo+ID4gPiA+ID4gwqDC
oMKgwqDCoCBzYV9oaWdoZXN0X3Nsb3QgdmFsdWUgPD0gdG8gdGhlIG5ldyBzbWFsbGVyDQo+ID4g
PiA+ID4gwqDCoMKgwqDCoMKgIHNyX3RhcmdldF9oaWdoZXN0X3Nsb3QNCj4gPiA+ID4gPiDCoMKg
wqDCoMKgIC0gT25jZSB0aGlzIGhhcHBlbnMsIHRoZSBzZXJ2ZXIvcmVwbGllciBjYW4gc2V0DQo+
ID4gPiA+ID4gc3JfaGlnaGVzdF9zbG90DQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoCB0byB0
aGUgbG93ZXIgdmFsdWUgb2Ygc3JfdGFyZ2V0X2hpZ2hlc3Rfc2xvdCBhbmQNCj4gPiA+ID4gPiB0
aHJvdyB0aGUNCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqAgc2xvdCB0YWJsZSBlbnRyaWVz
IGFib3ZlIHRoYXQgdmFsdWUgYXdheS4NCj4gPiA+ID4gPiAtLT4gT25jZSB0aGUgY2xpZW50IHNl
ZXMgYSByZXBseSB3aXRoIHNyX3RhcmdldF9oaWdoZXN0X3Nsb3QNCj4gPiA+ID4gPiBzZXQNCj4g
PiA+ID4gPiDCoMKgwqDCoMKgwqAgdG8gdGhlIGxvd2VyIHZhbHVlLCBpdCBzaG91bGQgbm90IGRv
IGFueSBhZGRpdGlvbmFsDQo+ID4gPiA+ID4gU0VRVUVOQ0UNCj4gPiA+ID4gPiDCoMKgwqDCoMKg
wqAgb3BlcmF0aW9ucyB3aXRoIGEgc2Ffc2xvdGlkID4gc3JfdGFyZ2V0X2hpZ2hlc3Rfc2xvdA0K
PiA+ID4gPiA+IA0KPiA+ID4gPiA+IERvZXMgdGhlIGFib3ZlIHNvdW5kIGNvcnJlY3Q/DQo+ID4g
PiA+IA0KPiA+ID4gPiBUaGUgYWJvdmUgY2FwdHVyZXMgdGhlIGNhc2Ugd2hlcmUgdGhlIHNlcnZl
ciBpcyBhZGp1c3RpbmcgdXNpbmcNCj4gPiA+ID4gT1BfU0VRVUVOQ0UuIEhvd2V2ZXIgdGhlcmUg
aXMgYW5vdGhlciBwb3RlbnRpYWwgbW9kZSB3aGVyZSB0aGUNCj4gPiA+ID4gc2VydmVyDQo+ID4g
PiA+IHNlbmRzIG91dCBhIENCX1JFQ0FMTF9TTE9ULg0KPiA+ID4gT3VjaC4gSSBjb21wbGV0ZWx5
IGZvcmdvdCBhYm91dCB0aGlzIG9uZSBhbmQgSSdsbCBhZG1pdCB0aGUNCj4gPiA+IEZyZWVCU0Qg
Y2xpZW50DQo+ID4gPiBkb2Vzbid0IGhhdmUgaXQgaW1wbGVtZW50ZWQuDQo+IA0KPiBUaGUgY2xp
ZW50IGlzIGZyZWUgdG8gcmVmdXNlIHRvIHJldHVybiBzbG90cywgYnV0IHRoZSBwZW5hbHR5IG1h
eSBiZQ0KPiBhIGZvcmNpYmxlIHNlc3Npb24gZGlzY29ubmVjdC4NCj4gDQo+IEkgYWdyZWUgeW91
J3ZlIGNhcHR1cmVkIHRoZSBiYXNpY3Mgb2YgdGhlIGdyYWNlZnVsLXJlZHVjdGlvbg0KPiBzY2Vu
YXJpbywNCj4gYnV0IEkgZG8gd29uZGVyIGlmIG5jb25uZWN0ID4gMSBtaWdodCBpbXBhY3QgdGhl
IHRlcm1pbmF0aW9uDQo+IGNvbmRpdGlvbi4NCj4gDQo+IEJlY2F1c2UgbmNvbm5lY3QgbWF5IGlt
cGFjdCB0aGUgb3JkZXJpbmcgb2YgcmVxdWVzdCBhcnJpdmFsIGF0IHRoZQ0KPiBzZXJ2ZXIsIGl0
IG1heSBiZSBwb3NzaWJsZSB0byBoYXZlIGEgdGltaW5nIHdpbmRvdyB3aGVyZSBvbmUNCj4gY29u
bmVjdGlvbg0KPiBtYXkgc2lnbmFsIGEgcmVkdWN0aW9uIHdoaWxlIGFub3RoZXIgY29ubmVjdGlv
bidzIHJlcXVlc3QgaXMgc3RpbGwNCj4gb3V0c3RhbmRpbmc/DQoNCk5vdCBpZiB0aGUgY2xpZW50
IGlzIGRvaW5nIGl0IHJpZ2h0LiBJdCBkb2Vzbid0IHJlYWxseSBtYXR0ZXIgd2hpY2gNCmNvbm5l
Y3Rpb25zIHdlcmUgdXNlZCwgYmVjYXVzZSB0aGUgY2xpZW50IGlzIHRlbGxpbmcgdGhlIHNlcnZl
ciB0aGF0ICJJDQpoYXZlIG5vdyByZWNlaXZlZCBhbGwgdGhlIHJlcGxpZXMgSSdtIGV4cGVjdGlu
ZyBmcm9tIHRob3NlIHNsb3RzIi4NCg0KSU9XOiB0aGUgY2xpZW50IGlzIHN1cHBvc2VkIHRvIHdh
aXQgdG8gdXBkYXRlIHRoZSB2YWx1ZSBvZg0Kc2FfaGlnaGVzdF9zbG90IGluIE9QX1NFUVVFTkNF
IHVudGlsIGl0IGhhcyBhY3R1YWxseSByZWNlaXZlZCByZXBsaWVzDQpmb3IgYWxsIFJQQyByZXF1
ZXN0cyB0aGF0IHdlcmUgc2VudCBvbiB0aGUgc2xvdChzKSBiZWluZyByZXRpcmVkLg0KSXQgc2hv
dWxkbid0IG1hdHRlciBpZiB0aGVyZSBhcmUgZHVwbGljYXRlIHJlcXVlc3RzIG9yIHJlcGxpZXMN
Cm91dHN0YW5kaW5nIHNpbmNlIHRoZSBjbGllbnQgaXMgZXhwZWN0ZWQgdG8gaWdub3JlIHRob3Nl
IChhbmQgc28gdGhlDQpzZXJ2ZXIgaXMgaW5kZWVkIGZyZWUgdG8gcmV0dXJuIE5GUzRFUlJfQkFE
U0xPVCBpZiBpdCBoYXMgZHJvcHBlZCB0aGUNCmNhY2hlZCByZXBseSkuDQoNCk5vdyB0aGVyZSBp
cyBhIGRhbmdlciBpZiB0aGUgc2VydmVyIHN0YXJ0cyBpbmNyZWFzaW5nIHRoZSB2YWx1ZSBvZg0K
c3JfdGFyZ2V0X2hpZ2hlc3Rfc2xvdCBiZWZvcmUgdGhlIGNsaWVudCBpcyBkb25lIHJldGlyaW5n
IHNsb3RzLiBTbw0KZG9uJ3QgZG8gdGhhdC4uLg0KDQo+IA0KPiBUb20uDQo+IA0KPiANCj4gPiA+
IA0KPiA+ID4gSnVzdCBmeWksIGRvZXMgdGhlIExpbnV4IHNlcnZlciBkbyB0aGlzLCBvciBkbyBJ
IGhhdmUgc29tZSB0aW1lDQo+ID4gPiB0byBpbXBsZW1lbnQgaXQ/DQo+ID4gDQo+ID4gQXMgZmFy
IGFzIEkgY2FuIHRlbGwsIExpbnV4IE5GU0QgZG9lcyBub3QgeWV0IGltcGxlbWVudA0KPiA+IENC
X1JFQ0FMTF9TTE9ULg0KDQpObywgYnV0IGFjY29yZGluZyB0byBSRkMgODg4MSBTZWN0aW9uIDE3
LCBDQl9SRUNBTExfU0xPVCBpcyBsYWJlbGxlZCBhcw0KUkVRdWlyZWQgdG8gaW1wbGVtZW50IGlm
IHRoZSBjbGllbnQgZXZlciBjcmVhdGVzIGEgYmFjayBjaGFubmVsLiBTbw0Kb3RoZXIgc2VydmVy
cyBtYXkgZXhwZWN0IGl0IHRvIGJlIGltcGxlbWVudGVkLg0KDQo+ID4gDQo+ID4gDQo+ID4gPiA+
IEluIHRoZSBsYXR0ZXIgY2FzZSwgaXQgaXMgdXAgdG8gdGhlIGNsaWVudCB0byBzZW5kIG91dCBl
bm91Z2gNCj4gPiA+ID4gU0VRVUVOQ0UNCj4gPiA+ID4gb3BlcmF0aW9ucyBvbiB0aGUgZm9yd2Fy
ZCBjaGFubmVsIHRvIGltcGxpY2l0bHkgYWNrbm93bGVkZ2VzDQo+ID4gPiA+IHRoZSBjaGFuZ2UN
Cj4gPiA+ID4gaW4gc2xvdHMgdXNpbmcgdGhlIHNhX2hpZ2hlc3RzbG90IGZpZWxkIChzZWUgUkZD
ODg4MSwgU2VjdGlvbg0KPiA+ID4gPiAyMC44LjMpLg0KPiA+ID4gPiANCj4gPiA+ID4gSWYgdGhl
IGNsaWVudCB3YXMgY29tcGxldGVseSBpZGxlIHdoZW4gaXQgcmVjZWl2ZWQgdGhlDQo+ID4gPiA+
IENCX1JFQ0FMTF9TTE9ULA0KPiA+ID4gPiBpdCBzaG91bGQgb25seSBuZWVkIHRvIHNlbmQgb3V0
IDEgZXh0cmEgU0VRVUVOQ0Ugb3AsIGJ1dCBpZg0KPiA+ID4gPiB1c2luZyBSRE1BLA0KPiA+ID4g
PiB0aGVuIGl0IGhhcyB0byBrZWVwIHBvdW5kaW5nIG91dCAiUkRNQSBzZW5kIiBtZXNzYWdlcyB1
bnRpbCB0aGUNCj4gPiA+ID4gUkRNQQ0KPiA+ID4gPiBjcmVkaXQgY291bnQgaGFzIGJlZW4gYnJv
dWdodCBkb3duIHRvby4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQg
bWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20N
Cg0KDQo=

