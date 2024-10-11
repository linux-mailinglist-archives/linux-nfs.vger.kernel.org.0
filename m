Return-Path: <linux-nfs+bounces-7074-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAC599A4A7
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 15:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F1381C224C4
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 13:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263251E529;
	Fri, 11 Oct 2024 13:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Iebko/JC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2135.outbound.protection.outlook.com [40.107.223.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0E38F6E;
	Fri, 11 Oct 2024 13:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728652481; cv=fail; b=LYVZ83NOjGcvEwnWdGYr+Ihtp5B83LDTcPFo6dVfix6289rbIsDyswPeW2ZxUXL+G28XQzBIOqOqnR439yIcECdoDFNlaYeiHuh7CuDW9SooJC8vFGyW1xAX8BQGJc+GTxwmG73ZPsYn0Mnwwy4KJRvSoLP8I9HIIkvCb5G+u0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728652481; c=relaxed/simple;
	bh=zabaHsL+wtoj+KubvZCj1Se4MUgG3ickiwKosZ9GKvY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u6tMPLTe4ZqC8RwITAfmRnYdO1/mMKO89Gq8msT30p1X4P14sqsfspeClvBFM3Wq2g4hABs2/sw575jH9nkXlbLscMLL8WeYg5B7dnCKIqN0OWvAL4t6zDvkvQ7sJYK4mdSs9TIUIRCbIx/FYb0HBvliXzLJsB7i2ajzqKZEuPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Iebko/JC; arc=fail smtp.client-ip=40.107.223.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pnbvVNr1Wwyp0ATdngbxeur9hEYtb5QHmbGVJj2ENIRAUQVU9NrqN1HtCun3CmQGkeQl26eztX+y7ui1aeWLCRR4kTELenSyEHZrffYTEGy0Lnyht++EdteuKhJGR2GdlU0jhUBM5wR9QAkok/tJkp7/oUrFRdcnKkirEHMSzaESnF+z3GKXNLAlyXKoi/HG28xez0N2xSEy1C4x/LeJ6T4GdWvb8t6+RwqQRpXz1Y8j7vb2Wo1z+WrKcbVi0fcAs65nGUaADHv6ZAdVceP9sXOAFjsyABYFY/xlkFdJv3dZOF4faDQh48kagim4TAt+aWapxuj5tuZi7DdXCjzE6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zabaHsL+wtoj+KubvZCj1Se4MUgG3ickiwKosZ9GKvY=;
 b=lQWUPMixifvtyJxF8TM1+8z+NMAaQdBl8OUT4tjnNRsXgsQyAQ7yQdxO8XChhkE3661t+3T9O1NakTX98kt4DMTfCbLsqfy3U+sgO2gFo7H9rYIXitwErmP7WXJ3mNXczXDVF2C58TQCtktE4T+j4Gc4bKcq5JcHX+zqn/ayrlh83efbY8fw805gBDv3X0k9a8P89gwC8YK47CeoHiRQn+KlMjEfFjoSHH+4ofRqtCr0lOsSZRebr8r40CLuogeqAX0KTLFmeXnxPQb5Fv0G4XJmnuTfBpqSCsb7RKXDeUh1NbwVxTa9QI0xFX7FHvln4+rgnjUvuu5Ds9LGkOw0Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zabaHsL+wtoj+KubvZCj1Se4MUgG3ickiwKosZ9GKvY=;
 b=Iebko/JCxVvuebL8RjSS+wlf91gqR0tgI+w54nXKWF13uqDNKiGwbSJRLCO8EwaA4OiGXQWZjwQfVad0BWTKvDtrhuF4yWYskNq4R3dnWBAKaI9EmZ6+JP22XUcbX+JRaYrAjNLyA66k3oV1Krm8JXmhPFn2GL+3zN4chW2Ov48=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BY3PR13MB4995.namprd13.prod.outlook.com (2603:10b6:a03:363::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.21; Fri, 11 Oct
 2024 13:14:34 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%5]) with mapi id 15.20.8048.020; Fri, 11 Oct 2024
 13:14:32 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "okorniev@redhat.com" <okorniev@redhat.com>, "jlayton@kernel.org"
	<jlayton@kernel.org>, "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/1] nfsd: fix race between laundromat and free_stateid
Thread-Topic: [PATCH 1/1] nfsd: fix race between laundromat and free_stateid
Thread-Index: AQHbG2JUUcuOC2WNc02jNgHyIMA4o7KBhY6AgAACsYA=
Date: Fri, 11 Oct 2024 13:14:32 +0000
Message-ID: <541a46baa2eabd1a4d81520a7153617dd0a0fa7e.camel@hammerspace.com>
References: <20241010221801.35462-1-okorniev@redhat.com>
	 <ae0003013659a34279e3666180cd8b730ca3a2d8.camel@kernel.org>
In-Reply-To: <ae0003013659a34279e3666180cd8b730ca3a2d8.camel@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BY3PR13MB4995:EE_
x-ms-office365-filtering-correlation-id: 7dd730aa-aa3e-4660-9e1c-08dce9f6a55f
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VGdzWkhCdG5tM3BwTFZFakw5OVB1Y3Myd0U5OHNrbzNrVGRhVkdKZFpsbFNa?=
 =?utf-8?B?VGo1TVlycWNoSmxGbkd0cCsrWHJBSDFNUDgrQThiTTZPbnhUZjZub2FFVFN3?=
 =?utf-8?B?eXBLTGF0Zm0zVUJxbjJXMHZ4T3k2N0x2cnpzZjQ3VERtQTlMQnJOVEx6Szd6?=
 =?utf-8?B?dVdFZmprLzhYaHFrZy9FeGZIb2VhNFFXKzBKNnJxMTQyUklTNGd0cWVWd3pk?=
 =?utf-8?B?bUFjek8vblZNOGFCV1lwNGdCTkxVQUFybC84RFMvczRXRDgwQllVamtUTjFp?=
 =?utf-8?B?clh1dE5sSnpkcExackljaE00TWhwTzNEdHBHRlRWZmxnenovYmJDZ1l6d2NX?=
 =?utf-8?B?eXhZMngvaEVRSWEwcU1FaVZxRGs0MjREbXlTTzROSDgwUDVtV1hoeithS054?=
 =?utf-8?B?cHVrb0lxQ3JUNjI3S0FCVHN6cDJMa1RRZTJqWjAxNW5CenB3MzFTUDR2L1B4?=
 =?utf-8?B?ZmxOcjBCencxRDhhTlRKb09valIvVzdRbmRMMEF1cFErTk9lNCtLeWhBVytm?=
 =?utf-8?B?aDloWWo0Q3dEdnhwcnV0Z3RwM1o5WWIvTU5OWUdOYUpiNWlYQ2NOUmxMTjF6?=
 =?utf-8?B?OXlmT1p1dVhPWDNUYlNaRElBeklkZTFlU1pDbmUyb0dpVEJJbjlkZXdjU3Qz?=
 =?utf-8?B?S21VQk5QSURWVXRBWWJ4aFhDeERsY2piQkUrdTRWQXFldFBialB3aEhRK0Fq?=
 =?utf-8?B?bXJFanRuYW1RSzhqeDc2eXVicDlHaHdMQ2pYZVJrMGlhbGpVdWtmL2tpRzgr?=
 =?utf-8?B?bktaRTMwcE56YjMzY2pzQmRrMm9uYmp5UTlYM3NLdy9BZ2IxejdyL1hSeWZr?=
 =?utf-8?B?S1owOHZ1RUpPRHdyMFJOZVoxVXNXL3FpajZla1YwU25ZZFloVERTMUl3SDZ0?=
 =?utf-8?B?Y2tZSzFFcUVQWE9hMnI0N3dvMlh1UFZ2OGFKOGJRVkFhL0VnZk9PWnJlU25M?=
 =?utf-8?B?d2wyNnEzREN1bzMzd3NtR1p5YWxnMWg0dmM2K3p3Qnl0V2V0UXFtcGJkVFNJ?=
 =?utf-8?B?TVNRUlVGMXRNa1d2dXhIYUw1Ny9Wc3dJTEMvbEhVTGl2V0JHYlFQQWJ0bnhn?=
 =?utf-8?B?aFVENnByVnhIL3p5aEZtc3dFbUhSVW1wQUJjcnc2UnpxazF0clk0NGZXWWZv?=
 =?utf-8?B?bkQ2RnBuVHYvVllHUU9WVHhKakRpU01hb0ovK1ZhWE95WkNyUkZ4dllhbW5s?=
 =?utf-8?B?UmhnTDdWOHBIL1ppQTA4UnpNSmxJL1NwaVVqRGF2K3puQThkUXNmSFRMb2Yw?=
 =?utf-8?B?aUtMcTcwb0luUHdVdXl5T1JNWERPQmhUSFdkdFQ1NWM0SDkrZVBJMGlRS0hB?=
 =?utf-8?B?RHVKcWxza1FRRXRydTlEVldsenBUcWZsOVpVQzZMeWt6N0VzQTZheFRQWXBP?=
 =?utf-8?B?ZzEvQkxJOEVqSC9zZ25oS0YyejZPejJDRnNrV0tlbHQwcjQrQVpCUTcxSElq?=
 =?utf-8?B?d3ZFajZGNEVCeGVCRkIxMkN1NXFxUkFKeWN3OGEwaHMxYmVBSHo3cWFlb1hk?=
 =?utf-8?B?SGJxUzlqS1B2V3VSWW4wSnVRcUszRExaRm9pR2gzOEZWa21DVWFXZ0RBM0x2?=
 =?utf-8?B?TEQyN1l5Y2lIU3Q5SGpySklrQ3psK0lwREVWWVpIWXFkc1YyOTVlakNYMHM2?=
 =?utf-8?B?NlB3MTNVTjR6WWVRejVNMXZkd3FQR1pjNEw3WDJaMUJpNFR1T05DSG44eU11?=
 =?utf-8?B?cGNSMjJzOUNqWGxKZG5FSzlvMVZjVXVWak5QVDA1dFlScEJsTjdScGJ2d2tX?=
 =?utf-8?B?K0k4T1l1NnNmSE0wM2R2Z2N1NnFSYk8rSG10NTJIQlJHK0tCK3dibnBmdW9y?=
 =?utf-8?B?RXIyQ2g1bFlib1NkbC85QT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eEhVVDBzMTk4ZnpjNkFVeWFodHljY1Q2YkJvaXJpUitmL0dwL0MzMlBQRjRO?=
 =?utf-8?B?cW9sLzJCRUdtL0J5UUlTaUhLQTBrbHU5MFAvVUVVSnhCand0Q0xiU1QrL3Jw?=
 =?utf-8?B?NWFSbUxrWVpWRVNGNXc5aEF5Zm9xTlpZVWRvM2hxczNMQ1BQc1FxYThWM1NM?=
 =?utf-8?B?UHNPTitqQmdzUnBJOVdCUElCU0o4UEgxV1hnNjE5NkZLWDdWeEhMNU40QmJC?=
 =?utf-8?B?ZHdmaUxFb1dPZ3lyYUk0dEhDSE9mc2h0Ull6dHhlWitjY3VRTWdFZzBabFBQ?=
 =?utf-8?B?S0lmVjAvQS9kVmtEUkRqdmNIRlczOXd0MmZuSUc0Ly9hMm91dkVpRUtnM2ll?=
 =?utf-8?B?NHZRSXJSWEdUR0daeng5eUFiakZrOEpTUUVwOVJIeWk1MDBYNnRCTkkxVWRa?=
 =?utf-8?B?ZkZwNUNYb3luOHR4SWZvRVJyamRqNDNEbnJBWk9MWnZQOTRzLzJKVXBzZUpq?=
 =?utf-8?B?RkQ1U1JNYkZsVVBITkZoVy9hZVE4eXdmMlVXOFNaU1VaNTNVTXFzUGJQa1JI?=
 =?utf-8?B?cGU4Q3ZMMHBWc1pJSjJsak9vZWVseXZvbkxYY0U2MEJrZ2VaK3FTb1VDVDdJ?=
 =?utf-8?B?THpHRGRNWldjZzdvc05ubGF1NlhOK3V4ZWl4TVBPd0JOS3hkNXE2d0hyZlhG?=
 =?utf-8?B?YlNTTXJpNkdzSlRrZk9KYS85OHJ6d2hJdWN6S2YvTEswK1N3SUY1UWZKSm5F?=
 =?utf-8?B?b0N6MU94MEVYajZVbkNGTkhTWU5pSmJFeDJlb3FxWFUzM1JyVE84NXVrR3hi?=
 =?utf-8?B?MmV6bkVQV2thL0dqVlFaZG5lcTZaeVkrWFk0SXBsbkVvaVhUT1RqbUNSbEps?=
 =?utf-8?B?VzdGVzkwcGFTV3NDS3VPejJ0VVFET1JsY3E3aFBEQ3FvcjlhYTVxQVhiRDNY?=
 =?utf-8?B?L3IrelVMSloyUTM2ZC9JOTVZK1hwUEg1WWJNc1lNQmU3NEZBdGpicUhsalFE?=
 =?utf-8?B?cHdWb1NncWFnM1VmV013YzJxRjBtaGk3YmdlSWZjSGVRSnJrL1gzTllvWjJk?=
 =?utf-8?B?amJNczR4Zm4yMFJuZm1EZkt1UFVjc0hYQ0xiSEsrdDM0OTVleWJrbTNObHcw?=
 =?utf-8?B?ek42b1VZbVlkaVFjVm1admYrenpyQmwzanl3SEhOaHIxOGthOXNyVHdTaThP?=
 =?utf-8?B?Z3Q5ckIwMTF5RmQycUVxUjJNeFBjNEZ1M3FkM1JVVFhwbjE3SjhCRmJkWmJk?=
 =?utf-8?B?eDRndlRqYWhCcDdjVlBPaTdOZWtod20ybGRoUURpc0NINlZCTlhjUXRQakxa?=
 =?utf-8?B?Z3ByUjFqTEN5ZC9icko1WFFsbGxyY3drcXVSWE1yaWxXZ3F5M0VoMFZxamU2?=
 =?utf-8?B?c3FXbXlXL0ZSbkMzWFlPYXpBOEN1NVNJcFB5NkE0WG9Mci91U2lOdkVITkFs?=
 =?utf-8?B?ZGhId3ZJa0xuQ1RmdUJySGhJVjk4TGIxRU5EOXFXa1ROL040YkVGNGRHcTB0?=
 =?utf-8?B?dEZmdlM3WWppMWFiQllSMmE2eGhhNlVJZURQS0VTeFZMa2lyMHV3bUc5bk90?=
 =?utf-8?B?a0JtSVZHTmk5eG9vc210dUVteVdnQ0N1VWxxaHUvSjJWQlJkWVluUmkzOTNy?=
 =?utf-8?B?NVRiQ0haNGpGK01MSEErZW5WZGxRTGU2bFJocWoyR2xmUXp6SGhDMlljbE5T?=
 =?utf-8?B?KyszSEkzd2RHaFVRc2hocUFNK3BNanpwMVYwa1VUamI2WFZCZ2lBcTVNcVpB?=
 =?utf-8?B?RDJFK0s1UjJCcUpCV1lVYklFWTJBZzA3VEZ2K0F3UVQxeWVwRTY3ZFp1UnNt?=
 =?utf-8?B?VFFmVVB3TEdZVU5PSlpNRGNXeU40QTRudkZhZjZMdHNrRzl1dnlrQi9LK3ZZ?=
 =?utf-8?B?QUJpaktzbVZKS2t3MHdZSWpLTmU3V04zUWtVc2VnZWpzM21iMlRvbThtdlY3?=
 =?utf-8?B?Q1FaL0FoWUtaMDU1VERVWFU2OHdUUkpRd0tWM0xzNERRNHRVaExzQUdIN3JV?=
 =?utf-8?B?Z1p3UStsRzJ0UnJkMlR1Vy9hN2N3cWptOEloTnUvZkJrdU13emwwQlRZeTdC?=
 =?utf-8?B?aEZzSWlDa1VvTHBNVisvMW80Wlk1RFBTNmFWVE81SEsxQWN3UU9iV0xOZWcv?=
 =?utf-8?B?QW94cy82dlgvcmp4MHhhdmR2V1Yyc1F0OTZ2N0ZlLzZhYzdyeGdySm8wVVpu?=
 =?utf-8?B?c1BDeE95QmcyZk9FOXAxMTFiSW9HTjEzK0RZRGlEVnpMWjVuNUxGNFVwU3p3?=
 =?utf-8?B?MHZPRmZJYi9hcWRGL2w3b2UrU25ZZVU2cFR3ZjV2Q0hTeTRJamttRGhLZUxW?=
 =?utf-8?B?ZXUxWXhiVXc0Z1d5V3hDMWJsdlJnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <80024802F2C55441A92D301E5621F9B3@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd730aa-aa3e-4660-9e1c-08dce9f6a55f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 13:14:32.5063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: asvxWSeiB7yE+uWKaVwoif/yjteP1T/kAC9DUHuyKsRMvqnXEAErpnsViYRBqEjF0M+GLMacoAhYNSeHcnjsXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR13MB4995

T24gRnJpLCAyMDI0LTEwLTExIGF0IDA5OjA0IC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
T24gVGh1LCAyMDI0LTEwLTEwIGF0IDE4OjE4IC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gPiBUaGVyZSBpcyBhIHJhY2UgYmV0d2VlbiBsYXVuZHJvbWF0IGhhbmRsaW5nIG9mIHJl
dm9rZWQgZGVsZWdhdGlvbnMNCj4gPiBhbmQgYSBjbGllbnQgc2VuZGluZyBmcmVlX3N0YXRlaWQg
b3BlcmF0aW9uLiBMYXVuZHJvbWF0IHRocmVhZA0KPiA+IGZpbmRzIHRoYXQgZGVsZWdhdGlvbiBo
YXMgZXhwaXJlZCBhbmQgbmVlZHMgdG8gYmUgcmV2b2tlZCBzbyBpdA0KPiA+IG1hcmtzIHRoZSBk
ZWxlZ2F0aW9uIHN0aWQgcmV2b2tlZCBhbmQgaXQgcHV0cyBpdCBvbiBhIHJlYXBlciBsaXN0DQo+
ID4gYnV0IHRoZW4gaXQgdW5sb2NrIHRoZSBzdGF0ZSBsb2NrIGFuZCB0aGUgYWN0dWFsIGRlbGVn
YXRpb24NCj4gPiByZXZvY2F0aW9uDQo+ID4gaGFwcGVucyB3aXRob3V0IHRoZSBsb2NrLiBPbmNl
IHRoZSBzdGlkIGlzIG1hcmtlZCByZXZva2VkIGEgcmFjaW5nDQo+ID4gZnJlZV9zdGF0ZWlkIHBy
b2Nlc3NpbmcgdGhyZWFkIGRvZXMgdGhlIGZvbGxvd2luZyAoMSkgaXQgY2FsbHMNCj4gPiBsaXN0
X2RlbF9pbml0KCkgd2hpY2ggcmVtb3ZlcyBpdCBmcm9tIHRoZSByZWFwZXIgbGlzdCBhbmQgKDIp
IGZyZWVzDQo+ID4gdGhlIGRlbGVnYXRpb24gc3RpZCBzdHJ1Y3R1cmUuIFRoZSBsYXVuZHJvbWF0
IHRocmVhZCBlbmRzIHVwIG5vdA0KPiA+IGNhbGxpbmcgdGhlIHJldm9rZV9kZWxlZ2F0aW9uKCkg
ZnVuY3Rpb24gZm9yIHRoaXMgcGFydGljdWxhcg0KPiA+IGRlbGVnYXRpb24NCj4gPiBidXQgdGhh
dCBtZWFucyBpdCB3aWxsIG5vIHJlbGVhc2UgdGhlIGxvY2sgbGVhc2UgdGhhdCBleGlzdHMgb24N
Cj4gPiB0aGUgZmlsZS4NCj4gPiANCj4gPiBOb3csIGEgbmV3IG9wZW4gZm9yIHRoaXMgZmlsZSBj
b21lcyBpbiBhbmQgZW5kcyB1cCBmaW5kaW5nIHRoYXQNCj4gPiBsZWFzZSBsaXN0IGlzbid0IGVt
cHR5IGFuZCBjYWxscyBuZnNkX2JyZWFrZXJfb3duc19sZWFzZSgpIHdoaWNoDQo+ID4gZW5kcw0K
PiA+IHVwIHRyeWluZyB0byBkZXJlZmVuY2UgYSBmcmVlZCBkZWxlZ2F0aW9uIHN0YXRlaWQuIExl
YWRpbmcgdG8gdGhlDQo+ID4gZm9sbG93aW50IHVzZS1hZnRlci1mcmVlIEtBU0FOIHdhcm5pbmc6
DQo+ID4gDQo+ID4ga2VybmVsOg0KPiA+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiA+IGtlcm5lbDogQlVHOiBLQVNB
Tjogc2xhYi11c2UtYWZ0ZXItZnJlZSBpbg0KPiA+IG5mc2RfYnJlYWtlcl9vd25zX2xlYXNlKzB4
MTQwLzB4MTYwIFtuZnNkXQ0KPiA+IGtlcm5lbDogUmVhZCBvZiBzaXplIDggYXQgYWRkciBmZmZm
MDAwMGU3M2NkMGM4IGJ5IHRhc2sgbmZzZC82MjA1DQo+ID4ga2VybmVsOg0KPiA+IGtlcm5lbDog
Q1BVOiAyIFVJRDogMCBQSUQ6IDYyMDUgQ29tbTogbmZzZCBLZHVtcDogbG9hZGVkIE5vdA0KPiA+
IHRhaW50ZWQgNi4xMS4wLXJjNysgIzkNCj4gPiBrZXJuZWw6IEhhcmR3YXJlIG5hbWU6IEFwcGxl
IEluYy4gQXBwbGUgVmlydHVhbGl6YXRpb24gR2VuZXJpYw0KPiA+IFBsYXRmb3JtLCBCSU9TIDIw
NjkuMC4wLjAuMCAwOC8wMy8yMDI0DQo+ID4ga2VybmVsOiBDYWxsIHRyYWNlOg0KPiA+IGtlcm5l
bDogZHVtcF9iYWNrdHJhY2UrMHg5OC8weDEyMA0KPiA+IGtlcm5lbDogc2hvd19zdGFjaysweDFj
LzB4MzANCj4gPiBrZXJuZWw6IGR1bXBfc3RhY2tfbHZsKzB4ODAvMHhlOA0KPiA+IGtlcm5lbDog
cHJpbnRfYWRkcmVzc19kZXNjcmlwdGlvbi5jb25zdHByb3AuMCsweDg0LzB4MzkwDQo+ID4ga2Vy
bmVsOiBwcmludF9yZXBvcnQrMHhhNC8weDI2OA0KPiA+IGtlcm5lbDoga2FzYW5fcmVwb3J0KzB4
YjQvMHhmOA0KPiA+IGtlcm5lbDogX19hc2FuX3JlcG9ydF9sb2FkOF9ub2Fib3J0KzB4MWMvMHgy
OA0KPiA+IGtlcm5lbDogbmZzZF9icmVha2VyX293bnNfbGVhc2UrMHgxNDAvMHgxNjAgW25mc2Rd
DQo+ID4ga2VybmVsOiBsZWFzZXNfY29uZmxpY3QrMHg2OC8weDM3MA0KPiA+IGtlcm5lbDogX19i
cmVha19sZWFzZSsweDIwNC8weGMzOA0KPiA+IGtlcm5lbDogbmZzZF9vcGVuX2JyZWFrX2xlYXNl
KzB4OGMvMHhmMCBbbmZzZF0NCj4gPiBrZXJuZWw6IG5mc2RfZmlsZV9kb19hY3F1aXJlKzB4YjNj
LzB4MTFkMCBbbmZzZF0NCj4gPiBrZXJuZWw6IG5mc2RfZmlsZV9hY3F1aXJlX29wZW5lZCsweDg0
LzB4MTEwIFtuZnNkXQ0KPiA+IGtlcm5lbDogbmZzNF9nZXRfdmZzX2ZpbGUrMHg2MzQvMHg5NTgg
W25mc2RdDQo+ID4ga2VybmVsOiBuZnNkNF9wcm9jZXNzX29wZW4yKzB4YTQwLzB4MWE0MCBbbmZz
ZF0NCj4gPiBrZXJuZWw6IG5mc2Q0X29wZW4rMHhhMDgvMHhlODAgW25mc2RdDQo+ID4ga2VybmVs
OiBuZnNkNF9wcm9jX2NvbXBvdW5kKzB4YjhjLzB4MjEzMCBbbmZzZF0NCj4gPiBrZXJuZWw6IG5m
c2RfZGlzcGF0Y2grMHgyMmMvMHg3MTggW25mc2RdDQo+ID4ga2VybmVsOiBzdmNfcHJvY2Vzc19j
b21tb24rMHg4ZTgvMHgxOTYwIFtzdW5ycGNdDQo+ID4ga2VybmVsOiBzdmNfcHJvY2VzcysweDNk
NC8weDdlMCBbc3VucnBjXQ0KPiA+IGtlcm5lbDogc3ZjX2hhbmRsZV94cHJ0KzB4ODI4LzB4ZTEw
IFtzdW5ycGNdDQo+ID4ga2VybmVsOiBzdmNfcmVjdisweDJjYy8weDZhOCBbc3VucnBjXQ0KPiA+
IGtlcm5lbDogbmZzZCsweDI3MC8weDQwMCBbbmZzZF0NCj4gPiBrZXJuZWw6IGt0aHJlYWQrMHgy
ODgvMHgzMTANCj4gPiBrZXJuZWw6IHJldF9mcm9tX2ZvcmsrMHgxMC8weDIwDQo+ID4gDQo+ID4g
UHJvcG9zaW5nIHRvIGhhdmUgbGF1bmRyb21hdCB0aHJlYWQgaG9sZCB0aGUgc3RhdGVfbG9jayBv
dmVyIGJvdGgNCj4gPiBtYXJraW5nIHRocnUgcmV2b2tpbmcgdGhlIGRlbGVnYXRpb24gYXMgd2Vs
bCBhcyBtYWtpbmcgZnJlZV9zdGF0ZWlkDQo+ID4gYWNxdWlyZSBzdGF0ZV9sb2NrIGJlZm9yZSBh
Y2Nlc3NpbmcgdGhlIGxpc3QuIE1ha2luZyBzdXJlIHRoYXQNCj4gPiByZXZva2VfZGVsZWdhdGlv
bigpIChpZSBrZXJuZWxfc2V0bGVhc2UodW5sb2NrKSkgaXMgY2FsbGVkIGZvcg0KPiA+IGV2ZXJ5
IGRlbGVnYXRpb24gdGhhdCB3YXMgcmV2b2tlZCBhbmQgYWRkZWQgdG8gdGhlIHJlYXBlciBsaXN0
Lg0KPiA+IA0KPiANCj4gTmljZSBkZXRlY3RpdmUgd29yayENCj4gDQo+ID4gQ0M6IHN0YWJsZUB2
Z2VyLmtlcm5lbC5vcmcNCj4gPiBTaWduZWQtb2ZmLWJ5OiBPbGdhIEtvcm5pZXZza2FpYSA8b2tv
cm5pZXZAcmVkaGF0LmNvbT4NCj4gPiANCj4gPiAtLS0gSSBjYW4ndCBmaWd1cmUgb3V0IHRoZSBG
aXhlczogdGFnLiBMYXVuZHJvbWF0J3MgYmVoYXZpb3VyIGhhcw0KPiA+IGJlZW4gbGlrZSB0aGF0
IGZvcmV2ZXIuIEJ1dCB0aGUgZnJlZV9zdGF0ZWlkIGJpdHMgd29udCBhcHBseSBiZWZvcmUNCj4g
PiB0aGUgMWUzNTc3YTQ1MjFlICgiU1VOUlBDOiBkaXNjYXJkIHN2X3JlZmNudCwgYW5kDQo+ID4g
c3ZjX2dldC9zdmNfcHV0IikuDQo+ID4gQnV0IHdlIHVzZWQgdGhhdCBmaXhlcyB0YWcgYWxyZWFk
eSB3aXRoIGEgcHJldmlvdXMgZml4IGZvciBhDQo+ID4gZGlmZmVyZW50DQo+ID4gcHJvYmxlbS4N
Cj4gPiAtLS0NCj4gPiDCoGZzL25mc2QvbmZzNHN0YXRlLmMgfCA0ICsrKy0NCj4gPiDCoDEgZmls
ZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZm
IC0tZ2l0IGEvZnMvbmZzZC9uZnM0c3RhdGUuYyBiL2ZzL25mc2QvbmZzNHN0YXRlLmMNCj4gPiBp
bmRleCA5YzJiMWQyNTFhYjMuLmM5NzkwN2Q3ZmIzOCAxMDA2NDQNCj4gPiAtLS0gYS9mcy9uZnNk
L25mczRzdGF0ZS5jDQo+ID4gKysrIGIvZnMvbmZzZC9uZnM0c3RhdGUuYw0KPiA+IEBAIC02NjA1
LDEzICs2NjA1LDEzIEBAIG5mczRfbGF1bmRyb21hdChzdHJ1Y3QgbmZzZF9uZXQgKm5uKQ0KPiA+
IMKgCQl1bmhhc2hfZGVsZWdhdGlvbl9sb2NrZWQoZHAsIFNDX1NUQVRVU19SRVZPS0VEKTsNCj4g
PiDCoAkJbGlzdF9hZGQoJmRwLT5kbF9yZWNhbGxfbHJ1LCAmcmVhcGxpc3QpOw0KPiA+IMKgCX0N
Cj4gPiAtCXNwaW5fdW5sb2NrKCZzdGF0ZV9sb2NrKTsNCj4gPiDCoAl3aGlsZSAoIWxpc3RfZW1w
dHkoJnJlYXBsaXN0KSkgew0KPiA+IMKgCQlkcCA9IGxpc3RfZmlyc3RfZW50cnkoJnJlYXBsaXN0
LCBzdHJ1Y3QNCj4gPiBuZnM0X2RlbGVnYXRpb24sDQo+ID4gwqAJCQkJCWRsX3JlY2FsbF9scnUp
Ow0KPiA+IMKgCQlsaXN0X2RlbF9pbml0KCZkcC0+ZGxfcmVjYWxsX2xydSk7DQo+ID4gwqAJCXJl
dm9rZV9kZWxlZ2F0aW9uKGRwKTsNCj4gPiDCoAl9DQo+ID4gKwlzcGluX3VubG9jaygmc3RhdGVf
bG9jayk7DQo+ID4gwqANCj4gPiDCoAlzcGluX2xvY2soJm5uLT5jbGllbnRfbG9jayk7DQo+ID4g
wqAJd2hpbGUgKCFsaXN0X2VtcHR5KCZubi0+Y2xvc2VfbHJ1KSkgew0KPiA+IEBAIC03MjEzLDcg
KzcyMTMsOSBAQCBuZnNkNF9mcmVlX3N0YXRlaWQoc3RydWN0IHN2Y19ycXN0ICpycXN0cCwNCj4g
PiBzdHJ1Y3QgbmZzZDRfY29tcG91bmRfc3RhdGUgKmNzdGF0ZSwNCj4gPiDCoAkJaWYgKHMtPnNj
X3N0YXR1cyAmIFNDX1NUQVRVU19SRVZPS0VEKSB7DQo+ID4gwqAJCQlzcGluX3VubG9jaygmcy0+
c2NfbG9jayk7DQo+ID4gwqAJCQlkcCA9IGRlbGVnc3RhdGVpZChzKTsNCj4gPiArCQkJc3Bpbl9s
b2NrKCZzdGF0ZV9sb2NrKTsNCj4gPiDCoAkJCWxpc3RfZGVsX2luaXQoJmRwLT5kbF9yZWNhbGxf
bHJ1KTsNCj4gPiArCQkJc3Bpbl91bmxvY2soJnN0YXRlX2xvY2spOw0KPiA+IMKgCQkJc3Bpbl91
bmxvY2soJmNsLT5jbF9sb2NrKTsNCg0KbmZzNF9zZXRfZGVsZWdhdGlvbigpIHRha2VzIHRoZXNl
IGxvY2tzIGluIHRoZSBvcHBvc2l0ZSBvcmRlciwgc28gYXMgaXQNCnN0YW5kcywgdGhpcyBwYXRj
aCBpbnRyb2R1Y2VzIGEgcG90ZW50aWFsIEFCQkEgZGVhZGxvY2suDQpJIHN1Z2dlc3QgbW92aW5n
IHRoZSBzdGF0ZV9sb2NrIHNvIHRoYXQgaXQgaXMgdGFrZW4gYmVmb3JlIGFuZCByZWxlYXNlZA0K
YWZ0ZXIgdGhlIGNsLT5jbF9sb2NrLg0KDQoNCj4gPiDCoAkJCW5mczRfcHV0X3N0aWQocyk7DQo+
ID4gwqAJCQlyZXQgPSBuZnNfb2s7DQo+IA0KPiANCj4gSSdtIG5vdCB0aHJpbGxlZCB3aXRoIHRo
aXMgcGF0Y2gsIGJ1dCBpdCBkb2VzIHNlZW0gbGlrZSBpdCB3b3VsZCBmaXgNCj4gdGhlIHByb2Js
ZW0uIExvbmcgdGVybSwgSSB0aGluayB3ZSBuZWVkIHRvIGdldCByaWQgb2YgdGhlIHN0YXRlX2xv
Y2ssDQo+IGJ1dCBJIGRvbid0IGhhdmUgYSByZWFsIHBsYW4gZm9yIHRoYXQganVzdCB5ZXQgYXMg
aXQncyBub3QgMTAwJSBjbGVhcg0KPiB3aGF0IGl0IHN0aWxsIHByb3RlY3RzLg0KPiANCj4gQXMg
ZmFyIGFzIGEgRml4ZXMgdGFnLCB0aGlzIGJ1ZyBpcyBsaWtlbHkgdmVyeSBvbGQuIEknZCBzYXkg
aXQNCj4gcHJvYmFibHkNCj4gZ290IGludHJvZHVjZWQgaGVyZToNCj4gDQo+IMKgwqDCoCAyZDRh
NTMyZDM4NWYgbmZzZDogZW5zdXJlIHRoYXQgY2xwLT5jbF9yZXZva2VkIGxpc3QgaXMgcHJvdGVj
dGVkDQo+IGJ5IGNscC0+Y2xfbG9jaw0KPiANCj4gSW4gYW55IGNhc2UsIGxldCdzIGdvIHdpdGgg
dGhpcyBwYXRjaCB1bnRpbCB3ZSBjYW4gY29tZSB1cCB3aXRoIGENCj4gYmV0dGVyIHBsYW4gZm9y
IGRlbGVnYXRpb24gaGFuZGxpbmcuDQo+IA0KPiBSZXZpZXdlZC1ieTogSmVmZiBMYXl0b24gPGps
YXl0b25Aa2VybmVsLm9yZz4NCj4gDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMg
Y2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3Bh
Y2UuY29tDQoNCg0K

