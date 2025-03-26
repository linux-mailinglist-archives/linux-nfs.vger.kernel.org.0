Return-Path: <linux-nfs+bounces-10912-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA824A71E14
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 19:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78CFC16EE47
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 18:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55D024CECE;
	Wed, 26 Mar 2025 18:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="LDMAwXeZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2128.outbound.protection.outlook.com [40.107.95.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE8F23DE80
	for <linux-nfs@vger.kernel.org>; Wed, 26 Mar 2025 18:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743012687; cv=fail; b=ErdylrEYDgd9UJuNEk5U1p9AVGCsoDnjqdXPgwytQ3eSR8xq0BD3504f5dsKeIAB78ssPH3kZuGhbGXXyt4N/v/FBlzGLlF5GWnDM73SvM7vHUR/CTQjjNveVGPzv+TqLTl3COT3g7Yun6t30764XwgJ2+i0ecA470yXRlPsVDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743012687; c=relaxed/simple;
	bh=PxlgXK7wbvLOSIoLp5nAtrnnMu0QohOWj7+AYWB+wio=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GtEM4fV2xnE809uFfXA2nnNaRAc8glRDuZPYlu+w/YprlJZUMII/s78K3LAizfDvaEXMQ4KpBplV3lzCM+mhZLj9JPSte3RkaPDDAr8Xx+qlJpKvIUaiGXLZBjn3TUIll9d7XLzbTZ4NZMSyfUlTjoA4LtQlQLWBxQZ2MZ4FuMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=LDMAwXeZ; arc=fail smtp.client-ip=40.107.95.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=quhWzmvwCExd5bsM0xDCFaAZ4PBdfT4t9OHfwkQzUmoi2iiAyZfInvICXIIhRZbDW5FVnksb6JEDBN4q3TLdy9XGaDnTYkf7cqczvsSjAo5KAAcc7VBfjDETqsrUOekUtNvI/w4HCXh05HfDnxfDHzHNTeZZ5Zn0P7qEp7oTFVusd7/W2zemv4ozWh5yZY9a7P94EUIClwIlmi18CTo995d2qHKic+SRF6jL5oLV+CzDgHlU5/W0Y/J8ljXckWhq/BcD6N3PPDjh3ProsuTEgeNyaEaejjjpEyuP+P1MiycvhaAH6jysmjp+O2NZbuaoEcxHC7cfdGB0H0yl4uPCiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxlgXK7wbvLOSIoLp5nAtrnnMu0QohOWj7+AYWB+wio=;
 b=BiMyOzJUmssPAukXUC7b0Aq4NPs2ppgHRKBSMYc61xrxPPhISY3RctUNJMN4XOu2f1NMFAiZ7pOQRPFqTy4JhdJCHRgvJNcTVMw8VUtjAWwhAqsmNBENOwGM49ipf8MafCvwloph+gxWvozJUB716NT8LGSoY6uNN0NKt/QrUdzB5JCP+TS2Aoiy4ITvjfY13cNJggGMBcHzG/Axjx/3aw6DIG1nwHFEhVRrf3N98yquuPEKXTXFGcDJYn8bwGu2m6OLdMWZJg6fqwMMY1K/9TVKWH/eRXmGEI6HjKzihSo+KGWzDW23uidfh5WSYYDrGQ+8XYqyQDKF516DjwabZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxlgXK7wbvLOSIoLp5nAtrnnMu0QohOWj7+AYWB+wio=;
 b=LDMAwXeZCuSIYfQBd6jvdX1ktvxPo60MiBRd9JFAxs7EQYmSyuhTxE1kE59OhusjG/dF+QQiDIVnw+dXwRDoqQmnwcuTxxH66oH4bQqmDFC/H9WMH1uBqufgCkflLz2HJNJTvYFF80DMkAnWCxZYbkZz6f9aSzTsFEkosC2L1yc=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DS7PR13MB4765.namprd13.prod.outlook.com (2603:10b6:5:3aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 18:11:21 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%3]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 18:11:21 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"jlayton@kernel.org" <jlayton@kernel.org>
CC: "josef@toxicpanda.com" <josef@toxicpanda.com>, "bcodding@redhat.com"
	<bcodding@redhat.com>
Subject: Re: [PATCH v3 4/6] NFSv4: Further cleanups to shutdown loops
Thread-Topic: [PATCH v3 4/6] NFSv4: Further cleanups to shutdown loops
Thread-Index: AQHbndY8Px3ZNipFIkm5cc4bvhAd1rOFM8uAgACFeoA=
Date: Wed, 26 Mar 2025 18:11:20 +0000
Message-ID: <225a2cda58e21100c7802151ea501e140e7b3a4d.camel@hammerspace.com>
References: <cover.1742941932.git.trond.myklebust@hammerspace.com>
		 <668e25098cb97187d084d5fa2916ddd4d2a68e00.1742941932.git.trond.myklebust@hammerspace.com>
	 <c882f951c08fc67514357ddd3a47f188fa249e34.camel@kernel.org>
In-Reply-To: <c882f951c08fc67514357ddd3a47f188fa249e34.camel@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|DS7PR13MB4765:EE_
x-ms-office365-filtering-correlation-id: 38645d30-afb6-40b6-ba70-08dd6c919ca0
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SnRjekZTMXFTWGdUdUdNN2UrQ1phUHB5TVR2THZDOFpNVEE1VGlTaHVJdW9N?=
 =?utf-8?B?OFgwWDc2S1BZUFdrVTNtZjljTDRCTkt2NTJSUmFKT2RCODNHRGVNb0dXWmRI?=
 =?utf-8?B?Ky9jOW11RU5qK2xJeXk2VFBCTnFNenlVbHE1S25xZlNNb0UySE1vRFNEZEc4?=
 =?utf-8?B?ZnAycFdVOHFsUWpUVk41dFplOWVDdEl4T1F5SXZ1SnVaRUpjMnhmQWZIL2RV?=
 =?utf-8?B?K1YrdEM0UTN5a2xHaW56cnArc2ZZR25XZm96VVJmRDVxa3JpT0luTmpNNkZF?=
 =?utf-8?B?bkhhVmZCTFR5SnNPRmhlMnpLRG1wMkd5eDV4SFpiWlBtVzFYQ0pQUUJGL1Yr?=
 =?utf-8?B?MisySGxzSlBBQllDSCszSEUvVDFQd1dud2duMzFBSEV0WFJoVjUyTXpEbWI3?=
 =?utf-8?B?RFRjVm1GVDM2WXE5K2w5OU1pWUc5QmJZK0M4Ty9tUzllVmdDa1RhajZacDVU?=
 =?utf-8?B?ckNNWW1QbTUxNFN4eGVPaDJTVHFvN3VsNXFxUFkvWXZKRWpmSTZhaVZNSmxZ?=
 =?utf-8?B?cG9VRXdlQXhWekEyclpEZE56NjBGZUdxZVBTUGVpSDIwVEpTZTUwQndxWDZv?=
 =?utf-8?B?cE5rd2NVbGRLMytvcE9BMmRJMzUxLzJOQjFnZ0xtQjVaN0VNQkJuZ2pxSWw1?=
 =?utf-8?B?QVd5RlRrU21oVWNKa3JPc216VnRyek1hYTFzdzdoZ1RGdm5VV0s2NmFWUFli?=
 =?utf-8?B?NGRIWUhHYlRsZHlDT09UOTErTEJwZno0eDNtR0pic2FtZk53SFBTM0NHcVJw?=
 =?utf-8?B?cVdodjlaZ1VUNEdsd21CSDBlWXlCNFYrVXl5WVJXZVB3b0dxNCtHdGQvQ1FO?=
 =?utf-8?B?US9PWHlwQUNxRmMxVEthUzkvNTBRZUphQXBQaXhyV0NoTG9JUVhQNmdNTWtl?=
 =?utf-8?B?Um0wWERUVUVKc1hEMGN2VTBaOFlqcXdsaXlKNHg4cFY4NDJpN3ZtaTdUSFN4?=
 =?utf-8?B?aXp4d1JoekE2Z0ZDak9kL0VMNzlscDVVVmdQcXhDdFlVR0pNR0MrQzF1MEll?=
 =?utf-8?B?SUs2cSsvc0xZc0RlbXc4dmovVWtoc3JaM3NUeEVFTTdZeWwxMFR3c01XQWdI?=
 =?utf-8?B?NFY2c3phdEUzbXoxVGFWcElRRHB2c0FkVlRqS1dJSGZOVmJJR0xuYmZUZnJK?=
 =?utf-8?B?bllNZnFodDhGYWE0OW9ycGR4aGpuVFN2bnhLWjRNMTdkRlk4MWE1OVo0anFZ?=
 =?utf-8?B?RUdsY1BXeVZWUUlJY2M4YTNuTmVkNVZBcWROMmI0dWluVHBIMEQ5TUJMUjJV?=
 =?utf-8?B?WUt6Q3BvaEo5Q3VGMU1mek9GNWZaU2FCaXlOOUdxc1lUK0VzMHpkaHNzUjdF?=
 =?utf-8?B?MjdwWk1hcllSQnpSZ1BjNjk5RndTTmF3TmdmNGpBdUZQNzJYcEJDaVRxUVpi?=
 =?utf-8?B?WnI1Qk9vb20xSTNpNjdQV2dNcmNiTE5JdjFQNDhuREMxckxMb0dXSTlpTVFQ?=
 =?utf-8?B?bHNhcitRMFFCOUlvRTdNVnNWTDYwdzhrU2FIbWJnay95SW9uZGc5VFZVK25m?=
 =?utf-8?B?aVlIUzRQNHluQitxSytCUU5jTXRLRjJ1aml0ODA4bHRiM2Y3OG42V250Vm9j?=
 =?utf-8?B?ZUx5KzhWcnI4ZFNteVdaSzFGUllXdktOYjNNRDQ1empYM1pveWphREp1WDVo?=
 =?utf-8?B?N3d3Y29KRlpHR1JPUjB0T1lRU3lQQUlpQWtkbzdBZG9UMmxpTFp5cW1rT0dS?=
 =?utf-8?B?bTFvWVJDRGg4MllzWVgrUjE0ZDc5T29mZ29TZGJxbjZnUUFWeWVmNWRvTWtE?=
 =?utf-8?B?S1g0TFZjUGZiMlN3WUd6VWNkaFdVa0hhanZNYjVJd0R2bG5LSzZkRUVVVDJi?=
 =?utf-8?B?TnpZOFpBdmNqZTZ3VlZHUDZtWWo2a3FUQnoyRUF1aVkwL0RHb1hRMUlrZkVl?=
 =?utf-8?B?Z0FGMW1vRG93bXdUSjNLaHZ4Vi9wSC9weXF5eU9ubE0vYk5yTGVzekxBajNX?=
 =?utf-8?B?QU11dlNLdWhycjMrZDh1d0RhZ0Q1YWRHNS96Tzl1UDNhbFZpbE0yMWxmSFlk?=
 =?utf-8?B?Wjhzc3RtTVlBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZHgvQndSRmVtdDIzU1lmaWRGY3MzMGF6R1FDc01VUEN6L0NOOUNCUnhYUXgr?=
 =?utf-8?B?TVhrbFhLOGlBQ05jWit4M1A4SnR4VWg1UG1hNi9CYkJxdUJjT0t0Qk00ZVJX?=
 =?utf-8?B?dERiVWR6dG84WGN5ZnpSOW5kMExtMjRLVUNsTVhrN2prR2ZoZnZPcGJsVVRm?=
 =?utf-8?B?bzVQZE4zL1pzamlIRStrSlJzUGdvYlRuc0NOZSswZ3grRmRleTRkYncwWU9H?=
 =?utf-8?B?S1hLN1NsRXNaTFVyUTN6UzFsM2dEVEtvS3p5cW1MTEtGWno5UndUMEUxMWNS?=
 =?utf-8?B?dnNjS3h4WXRZNjFaT2pNZzJJVis4UnJaL0p3YjVwZGdrRitCSUFIalFXSXdQ?=
 =?utf-8?B?b1FIbzA1VnZWaDV6N0NKcCtQdWxlM0ZhalZHOVhGREZtM2FGNG1FcFNsMnlj?=
 =?utf-8?B?SEpucWNWdFl2U096QUdjZjliT3Q3QzQ2bkJYeVBPUXpGNk8ybVBGSzVUYjJh?=
 =?utf-8?B?cEhLQ21XRG9KSnhVN2RCbXRKakgxNUpxSVRmaHpNcVJWLzQ3V05OcnFtV1F5?=
 =?utf-8?B?N2NJcGJDbDI5OFpVWkJmOWRSbUplWTdzNU1Ga3hEdW9uYWhzQXg3T0V4ajFi?=
 =?utf-8?B?UHRYOHFqREZuRFV0VFhGREt6VVJZcU5jVi81U0wrbGhwMHNXZDc1ZGtiZzJD?=
 =?utf-8?B?ZTJsMDc5czRaMnZGTFV2aGZVRUE5WGl2SlVaV2hJaTB4V3lmY25ENFl4a3R1?=
 =?utf-8?B?ZnFPSlQ4TXM2VFFESTlCN2h6dWZaTFFQa3BrTHFtU1BQTFI1VktVV3JLeVB0?=
 =?utf-8?B?ejVRamRlRy84a3Blbm1uVkNOWTRhR2pOVit4RUh3WnBXdGdyelNjQTVJNXdK?=
 =?utf-8?B?WVV2MEcwNjlTNDhJUU1xMG1zM3JoRWc3WDVVbEEvY2RXOUF4OEd0ejIyT25C?=
 =?utf-8?B?VTlyajZraXp0b0Iza0Zkei9ZVEl4aTUwbS9ENnFiYUtEbUJVUXNybzFjVGRk?=
 =?utf-8?B?dXZqUHFIRVU4MzRhRmM1UHFHbUpETG1raml1RmRKZGpCZHJObHVzT3k3Y1Rp?=
 =?utf-8?B?RmM0eVh0VTl5UG12dGEzQkxWWndOc084TVZ3L1dGejZua2VBa3FGZkR3QU9p?=
 =?utf-8?B?dDhwTFBud1BxcHRrRXF1RnpTa2xwdUNBZU9Ick9BVm9Cd2Y5MmMwVnhxOG9s?=
 =?utf-8?B?c01CcVBBQW5tN3ZrQjFKNkZEZjhVVXk4RVZtcjE4cjRvWGFQa2JRdEpkNTBr?=
 =?utf-8?B?RC9DZ1djMDYrZ3RpTU4veko0VkQ2QTcvSFBnRE5taHV1Z1RZK3A4R0ZMKzMy?=
 =?utf-8?B?U044Q1ZTbW9scGtGdXUwTThEdUFoa2twT3kzWTdnLzFUM253TTc4VW9rdGlu?=
 =?utf-8?B?NjNwZHBLaktraGtRaHlvQ3FlSmMwajlQN2huRkFxQThad1dULzBLcWxnRVZo?=
 =?utf-8?B?T1JQME45MXdxc21XQmJ0MlRBNWFKV3lSTjJ5a09XbkNHUjNHcjRwY0VLY3A3?=
 =?utf-8?B?a084QUdrNzI5Z2F0NERnQktMS1BLVWlUdW42NVlDekVYSFUranl2TWRXZ3Vo?=
 =?utf-8?B?c2V0QWd6RFFuWDBMNzczN3NDVVNSNGRIamtTNFdMZjNTVVVIQ1Y1bzl2Y1ly?=
 =?utf-8?B?SFJhQ3N5V0M5Ym1XRE1sa3RjM2x0bHFMNldpU1VTc25oZUtKSHF0MmtESjNX?=
 =?utf-8?B?blVOYVM0ekxjT1IvWkxxUkRNMnk1bHRXZlpHa2F4YzdhMUtnYXhybTB4TXpJ?=
 =?utf-8?B?REdJbW5YUHpzTGVpd2ZBQXRoQUFlSkxpK1J5Q1dlbFlKbnRmNUFTQk9GSnQz?=
 =?utf-8?B?SlVWMUtSSXFHUmxla0hmaUJobWp6MUNmNklFdDkwZTcxOStqVThib2lrTjBL?=
 =?utf-8?B?V0FJblFVcWZxR2VDa1hKNVZEd2dOanNQYlRLVENhM3ZjQnl3aHVrbllyV1hZ?=
 =?utf-8?B?aGxDWHJuY0xsYjdWa2crMnZ0UXZSaVBRbVRyQko0b3FFQTUvb1FNc0ZKeVhh?=
 =?utf-8?B?VUtUeEJ1U2hFdnZRejZ6NW84YnArTzB6WTRuT1BRWmNhN2N6U3RTWXRLTWZT?=
 =?utf-8?B?NnhDdExMZzNGYU41UXA0TnVoUnpoYzZFcG1EL0xDZ1dsKzIrWVpSOGIyWXNX?=
 =?utf-8?B?MFFOU01aRW45TDNmTDVCUjZLVU9nMm5OdVlGRWtuOFY4dmxxNDJBT1NRQjE1?=
 =?utf-8?B?UEhMYVV1cEt3bHhyM3krdWxtZkVmVU1BZFhySUR6bEdwaE1LTDl0ZCtyS3Vv?=
 =?utf-8?B?VTE3dnFpWFptUEJuQmR1cVRHcVB2UWFPU3hNc29Ta2VORkZwVFpKWkR2bmxS?=
 =?utf-8?B?YWpUT0w1ZGpnbFF0S0NDS0pWeUtnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <14F55CF852F96549BD401BA91937A257@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 38645d30-afb6-40b6-ba70-08dd6c919ca0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 18:11:20.9787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: odcUSZ53JCjYXKUevq6cqw0mezmRLycQJj7Tu488D5punROF1TBRCYrNY8P4G+WWzyeyrh5YyJHu5mYgUSEv9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR13MB4765

T24gV2VkLCAyMDI1LTAzLTI2IGF0IDA2OjEzIC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
T24gVHVlLCAyMDI1LTAzLTI1IGF0IDE4OjM1IC0wNDAwLCB0cm9uZG15QGtlcm5lbC5vcmfCoHdy
b3RlOg0KPiA+IEZyb206IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNw
YWNlLmNvbT4NCj4gPiANCj4gPiBSZXBsYWNlIHRoZSB0ZXN0cyBmb3IgdGhlIFJQQyBjbGllbnQg
YmVpbmcgc2h1dCBkb3duIHdpdGggdGVzdHMgZm9yDQo+ID4gd2hldGhlciB0aGUgbmZzX2NsaWVu
dCBpcyBpbiBhbiBlcnJvciBzdGF0ZS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBUcm9uZCBN
eWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+DQo+ID4gLS0tDQo+ID4g
wqBmcy9uZnMvbmZzNHByb2MuY8KgIHwgMiArLQ0KPiA+IMKgZnMvbmZzL25mczRzdGF0ZS5jIHwg
MiArLQ0KPiA+IMKgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2ZzL25mcy9uZnM0cHJvYy5jIGIvZnMvbmZzL25m
czRwcm9jLmMNCj4gPiBpbmRleCA4ODk1MTE2NTBjZWIuLjUwYmU1NGUwZjU3OCAxMDA2NDQNCj4g
PiAtLS0gYS9mcy9uZnMvbmZzNHByb2MuYw0KPiA+ICsrKyBiL2ZzL25mcy9uZnM0cHJvYy5jDQo+
ID4gQEAgLTk1ODAsNyArOTU4MCw3IEBAIHN0YXRpYyB2b2lkIG5mczQxX3NlcXVlbmNlX2NhbGxf
ZG9uZShzdHJ1Y3QNCj4gPiBycGNfdGFzayAqdGFzaywgdm9pZCAqZGF0YSkNCj4gPiDCoAkJcmV0
dXJuOw0KPiA+IMKgDQo+ID4gwqAJdHJhY2VfbmZzNF9zZXF1ZW5jZShjbHAsIHRhc2stPnRrX3N0
YXR1cyk7DQo+ID4gLQlpZiAodGFzay0+dGtfc3RhdHVzIDwgMCAmJiAhdGFzay0+dGtfY2xpZW50
LT5jbF9zaHV0ZG93bikNCj4gPiB7DQo+ID4gKwlpZiAodGFzay0+dGtfc3RhdHVzIDwgMCAmJiBj
bHAtPmNsX2NvbnNfc3RhdGUgPj0gMCkgew0KPiA+IMKgCQlkcHJpbnRrKCIlcyBFUlJPUiAlZFxu
IiwgX19mdW5jX18sIHRhc2stDQo+ID4gPnRrX3N0YXR1cyk7DQo+ID4gwqAJCWlmIChyZWZjb3Vu
dF9yZWFkKCZjbHAtPmNsX2NvdW50KSA9PSAxKQ0KPiA+IMKgCQkJcmV0dXJuOw0KPiA+IGRpZmYg
LS1naXQgYS9mcy9uZnMvbmZzNHN0YXRlLmMgYi9mcy9uZnMvbmZzNHN0YXRlLmMNCj4gPiBpbmRl
eCA1NDJjZGY3MTIyOWYuLmYxZjdlYWE5Nzk3MyAxMDA2NDQNCj4gPiAtLS0gYS9mcy9uZnMvbmZz
NHN0YXRlLmMNCj4gPiArKysgYi9mcy9uZnMvbmZzNHN0YXRlLmMNCj4gPiBAQCAtMTE5OCw3ICsx
MTk4LDcgQEAgdm9pZCBuZnM0X3NjaGVkdWxlX3N0YXRlX21hbmFnZXIoc3RydWN0DQo+ID4gbmZz
X2NsaWVudCAqY2xwKQ0KPiA+IMKgCXN0cnVjdCBycGNfY2xudCAqY2xudCA9IGNscC0+Y2xfcnBj
Y2xpZW50Ow0KPiA+IMKgCWJvb2wgc3dhcG9uID0gZmFsc2U7DQo+ID4gwqANCj4gPiAtCWlmIChj
bG50LT5jbF9zaHV0ZG93bikNCj4gPiArCWlmIChjbHAtPmNsX2NvbnNfc3RhdGUgPCAwKQ0KPiA+
IMKgCQlyZXR1cm47DQo+ID4gwqANCj4gPiDCoAlzZXRfYml0KE5GUzRDTE5UX1JVTl9NQU5BR0VS
LCAmY2xwLT5jbF9zdGF0ZSk7DQo+IA0KPiBPbmUgbW9yZSB0aGluZzoNCj4gDQo+IERvIHdlIG5l
ZWQgY2xfc2h1dGRvd24gYXQgYWxsPyBJZiB3ZSBjYW4gcmVwbGFjZSB0aGVzZSBjaGVja3MgaGVy
ZQ0KPiB3aXRoDQo+IGEgY2hlY2sgZm9yIGNsX2NvbnNfc3RhdGUgPCAwLCB3aHkgbm90IGRvIHRo
ZSBzYW1lIGluIGNhbGxfc3RhcnQoKT8NCg0KVGhlIHN0cnVjdCBuZnNfY2xpZW50IGlzIGEgTkZT
IGxldmVsIG9iamVjdC4gSXQgY2FuJ3QgYmUgbW92ZWQgdG8gdGhlDQpSUEMgbGF5ZXIuDQoNCi0t
IA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNw
YWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K

