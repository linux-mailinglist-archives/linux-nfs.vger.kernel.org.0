Return-Path: <linux-nfs+bounces-10743-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E33A6BE0F
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Mar 2025 16:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEE51189677F
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Mar 2025 15:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423321A238C;
	Fri, 21 Mar 2025 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="eSfMc1gj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2126.outbound.protection.outlook.com [40.107.94.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A0C1388
	for <linux-nfs@vger.kernel.org>; Fri, 21 Mar 2025 15:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742570089; cv=fail; b=TYWehd6C3AaAEyylDIKDQS+KlpnKQCey1OqtckX7/ssK36MNXhocEtDLTrgHhvjUS/xAZHXuKOb18AZIv0NxmOIUkD89eCXz4RlCHEdzBkv9/mgOgNWkcezFBzmuzP4ge8cKfn3x6czJlYP0VXfW/6GtdMEGXcAawnIZyaCJ9Po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742570089; c=relaxed/simple;
	bh=Ns5NW98OdJP3B9bRiymM0U8vkununveB+oYdlZBKKAw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EbzKzgef4INleD2eusTC8Mjpg16ZbGYcdp+K2ge/rtlS7JrPqcFOASj18hm44Db/TGoniQ/cF0ARsinqCsr2Par8s1X8TKoC8fqaxW6a4sIFyoEXvVAejefBUqK/fvlHLoGOJxf2EeG0dkCfAcQjhe9TgLD0UHkLKUnZ0+PYim0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=eSfMc1gj; arc=fail smtp.client-ip=40.107.94.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JQbiM1eSnPv1FdWtupkhxAz0/2t7AiaRX5pYc7CKm8LQe8jDtFT0ucWxqvbPcLsqVAQ6T3XUF2/m+rGUKEWeP7SlkWInWdurtlawkyIOaq1mCaJKVWcJMXBeubU3rEoN+ImVeUfKSUNKXSG87dlJWSGm0OwiGW/TkK3YpoHaphhdzzeaRcUIs8dP4p2bE05jghLH7eqkabMMDw2duBrMRd7Xw8FsKIacbpChpU+IzPEcJsixjnlgl83nCu2OujvhDMqplBwFli5OKoxbQ1jgwdIXhGbMh0nSCq2889eABTbKe8BOnecOrX4CdOQilK7g6v1rcmGowueAYrCZ32yuWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ns5NW98OdJP3B9bRiymM0U8vkununveB+oYdlZBKKAw=;
 b=vh7TTh8la+9Uljk/s0XiV4S6M6O1WsvhQPX3+TkyJwbdwWc22BULy2+6TWFTeXUuuzLdjQvc0nYCz6PfeZ0pmfFziWescYdyAlsD0Eq462L5BUxnNP1oP+xluGpqwf2yLZhbirUZkPVDR8PmcnC4UboUJevy9Of78xMMArbt/eIRBflxDo1iIwrhFoGxJcB1/joOR9lknrCjp/EjuPuU6j2G62GindCVsmMPvlCF44lofwltRIYqBD4xO5tX41RMElmRIopHkupNv7aZ3X87sqOD2D0R2lkc+kGilri6IReqNOeBjB9YhaKTYf4g8TvzhFN8cGxbitSmRO3ZwoQqIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ns5NW98OdJP3B9bRiymM0U8vkununveB+oYdlZBKKAw=;
 b=eSfMc1gjBg5vky187q4o66kf+RgM0TwOJ03wrMoeVPjlzu0SrQmWDJt/KkvRPHx1bxpoxFShRCVh74hMhwYHuTXKFMg1y6Pt/N8UggFseoRlu36I6IKcu5zMr/2XVtgn8MKGBLmZvRoMcXTjnV1kXxwJzy902gEzAAf2EvlQzJ4=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MN2PR13MB3805.namprd13.prod.outlook.com (2603:10b6:208:1f0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 15:14:44 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%3]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 15:14:44 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"jlayton@kernel.org" <jlayton@kernel.org>
CC: "josef@toxicpanda.com" <josef@toxicpanda.com>
Subject: Re: [PATCH RFC v2 0/4] Containerised NFS clients and teardown
Thread-Topic: [PATCH RFC v2 0/4] Containerised NFS clients and teardown
Thread-Index: AQHbmdhUZ0hrNzUqC0yehy6KqOqKbrN9qZYAgAAKqgA=
Date: Fri, 21 Mar 2025 15:14:44 +0000
Message-ID: <520dd74f03500bb802f81dc7e12d3c83767a3147.camel@hammerspace.com>
References: <cover.1742502819.git.trond.myklebust@hammerspace.com>
	 <bfd19bed9718426f5cfc7033347d3ddeb904080b.camel@kernel.org>
In-Reply-To: <bfd19bed9718426f5cfc7033347d3ddeb904080b.camel@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|MN2PR13MB3805:EE_
x-ms-office365-filtering-correlation-id: b65e8c6d-f9f6-479a-9f05-08dd688b1c6c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?elVoa0ZJdlhPZU9aVEFQTFlIdnE1ZUlacGdEdVV0My9oSG5qa2xpTHBjQXdx?=
 =?utf-8?B?MzA5Um1jMERpeHFiRUtrcEk4S3N4emEzbUlEbGlDUWRaVFZhNEVrOXVzdDBJ?=
 =?utf-8?B?cEs2NjN0cHRrZHB5OWg1a2xBTlNIalVUQVBiamppM3MvdXRHVEVqWHZDemd2?=
 =?utf-8?B?Q3d3c2ovZjJDQ0pGL3FnVUVhSHlhbk1jK0NMLzB5citlQTM1ZHdyaFEydk9F?=
 =?utf-8?B?UU5QelAxdnljR0ZYRVZtdWNJaTFHd3ZvWnJSSXdSOXFSVzZodEY4cWN5Y1ds?=
 =?utf-8?B?T0pzSVU3SC9oSTdMeUlybUFGSitwcFVMczFwdEJzQkE0ZU1ucnVCR2JCc2xo?=
 =?utf-8?B?NmRkbHEwbUN4WW1URk5kQU51SUh0c1MyTll3dDdMaEh1NmRudEUvRnRJU3hT?=
 =?utf-8?B?S0dsbFZrY2piNFE3YVFhNHMyc1Z0MzNFd2JNMlJ1bWNKcjdEVXExTW1nOGEz?=
 =?utf-8?B?MjlMNW4rMS94TFREWTdWdDZ6bGJieXpkaVBGaC9PT3VrTThKWXZCOU1OVm9C?=
 =?utf-8?B?OTMzZzZleFhVTlplV0NMRUY0eHk3eWZBYnBIVThWWGF3Mm4vN2JRUnhFdW5E?=
 =?utf-8?B?NzlnVjFSQlhQaDFEbzZucnlTUDdCODZyV05RRHJMWmJWM0FFNDBxS2lKOStP?=
 =?utf-8?B?ZzM1cGhGajZ1S3AzbjZZcTZOSU9jNm5paGJXZG1wRmVDV2hJcm5zTVNoVFdu?=
 =?utf-8?B?ZEd5R1lpNnZIQklIZ01jUXFkMlU1YWRNZGNlVkVCTmtzUlJhUHpLemFtT3Rn?=
 =?utf-8?B?TEt0alNuMGpNejl6Nll1Y3pDM2hNQ3FHaVhJRHZSWTBFeTN2RThyUmtWYzUy?=
 =?utf-8?B?NUx2S04vQ1huWmpKRVFZbm1EaUIybmlNNEh5R2M4TFQ3WVRlQUx5eDJhUHQ2?=
 =?utf-8?B?TDJnaE44a2tBa0tGb0ZLZ2QxbXh3dXp3RFZIblNrejl4ZnpQVGlxVENlU1Fs?=
 =?utf-8?B?V0ZmN0JYT000MityZFQ2ejlhSlhNcDgvQXRlT2JyT3V3RDlSL2R6eGI2QklR?=
 =?utf-8?B?N0cvSDVxNU00MVk4WGk0dU5SakVnR2l6MlJCSEJ2U0NBajN3cUtNU0NHenVB?=
 =?utf-8?B?Y0R6OFl4SVgzaVBQcUo3UWdGYlZldGl1UnRBaU1MZHlkSEdGbUgvY0M5LzND?=
 =?utf-8?B?RmlrTDYwbzllR3RhZGFYWktCTGIwbmlrRTd3U3RWT20xVVY0L05WbUFkTXI5?=
 =?utf-8?B?VVUraWZJSk0vYmZJWmRyU2dCZTJDQ3c0czVpa1RTeDkxSkR0dUtMcDZTcEhp?=
 =?utf-8?B?MHpBNG54V1Fhdno2NDRhbXZZaWROZENOYlp1UmtzaTZYaU82MjQ3UUpoRE1K?=
 =?utf-8?B?YngzclVqMWVjZDNLUUFaMFlaTXFpLzRLbWZOUTlXYWF3VWxZaXlrWW1LalNE?=
 =?utf-8?B?dzZSWWI2WHlYU3JFV2ZsNkpQWGp0YXJMNVBNeFQ5L29kbXdsZkFmbDZRakNm?=
 =?utf-8?B?Wk1TZVpCd3JRclBKOUpGdk9BZ0RBK0RIQmVHWHZFNk1vZ1NFTUhuY0paUkJ4?=
 =?utf-8?B?cU1oRlJaY1NaWlk0L2FmZzllUTZkN0dXZnYvRlFka055RWR6bTh6NHZqZzdU?=
 =?utf-8?B?c1dEck82SkkwZ1l0SCtxUkFxdXMzRWlsMDBEbmsrakt4VXdwdTMxN1RIOENi?=
 =?utf-8?B?YlZZY3hNMTdvVktadXMwclhrbjJEUjVHMGZSdkhIcWZkVlhUdGRNOHJUUml5?=
 =?utf-8?B?aTVoUjBTVWVqN0JGNzBWZURsZnZOaUYwWDlIQTMra281SjJCaldtSWgrZW9z?=
 =?utf-8?B?NHlBY1dhaDVxbllqYjlPMWJCalUrZW9sb2NpbTlUYmpld3FMR0pzSUF6dUFC?=
 =?utf-8?B?VHVQWFFNOVBrMzg2UGxiYk03K2FWajczeWY3WllFZDUxZkJHQlVLSWdJemky?=
 =?utf-8?B?THlGM0s3Rm9YRTFBT280T2UzTVlUbm9WTEZXUkhEYXZ4ejFXbnRyekFoMDBM?=
 =?utf-8?B?MVB3cDdEMmx6L1dkeUVpYUpjeVZpVUpNZ3F5Tm04ZCsxZmVMTnlpUS90MklC?=
 =?utf-8?B?dVM0VENoa09RPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S1FKQThGU2ljS29MNE1iK21IL3FsWWMwNituY2MreTdPYjVsNzRDY3RHT0t5?=
 =?utf-8?B?TlZNNDAreWZRKzZocFA3cHFMMzV0eFo1ZHhDM2dhNGVHMTJncXdoWFFtTk5v?=
 =?utf-8?B?MXVrU1R5SU1KckZ4cGZKTnlBU0V3dVNsZ0hPcCtrcnY0Umplbzh1Z3hSRVYz?=
 =?utf-8?B?bzMzYm9QTXJqNDBPNHlyU0RoUlZSM3VQT0FsSE9XNS9DMEdramJzSGMzQS9n?=
 =?utf-8?B?VC80UzE5dnRqZFhhSVpSNDZDYWhaa3pYd0RqZWNhbmdMa3UwMXdieHM5ZVNm?=
 =?utf-8?B?b25CRUVzTUMzV3FybUhINlRVenFqdVdHRzl0Y2RuaGN4VElDejU2emtTSnY3?=
 =?utf-8?B?M2ttaVlYMmxJYXZXdktjam5WT3ZtN2RHa0ZZckx0QlhnTEhnMXl3NmNORHJZ?=
 =?utf-8?B?QnJxTlZoT2E4WUVmTW9nTkdKdFdFMDRwRFB4OXpaT2hqc1JXdVRaUW1SbUVF?=
 =?utf-8?B?OFFHeDQ3SEt1UW4xNGFiQjlkVlkxUVR1N0l6Y25FUlZaY2VidHJLSWZIQTQ0?=
 =?utf-8?B?WnkyM0VPbDkrY3BkMVJOR0JIV3FQVFp4VkhxMzkybDd1QnYvcHVXNE5TL29j?=
 =?utf-8?B?RytHZTkwZjlkczhCSW9UbHN3bHMvSGtaNkdkT1JqRFdKS2FLdjB2cXFETU9q?=
 =?utf-8?B?UFNIYUdVTGFydVA5TkR3TVluQ3dKS0hKMmM1VzJ6cHMxWkc0UmlTNVdaRE01?=
 =?utf-8?B?M0ovYXc0N1JuQnhYYmduU2p6a1BlTHBtOUM1eUd1ZGd5RGh0S25UTnB1Ump5?=
 =?utf-8?B?eTRXS2ZrL3FENmFXL1NlbEJKQitOTThpTllOVEs4Qzg4MW44bnQwaUxWS2pP?=
 =?utf-8?B?OFc0UE5PNDdzMjViZ2NvVlF6eDc0aS9lY2gyN1hjRFlEM2F2YkNjWC9tS2JK?=
 =?utf-8?B?d3FtMWcrL2hUUVliNmVpTThyZERzbGVVU1IxMGRTRzlYMmpQeWNlUGJQWkpV?=
 =?utf-8?B?L2VjWGxkejFqZm9VOVpWRVE5Um9ITDI4Umd5Qm5wV1pLNUh0U2VTSE5XNUlt?=
 =?utf-8?B?SXpzMXZPVFc1VitPRng2Y0drbnZrYnpRRHJjaXpNdDZzU3RnYzd3RVBLV1VG?=
 =?utf-8?B?dTZMb0hiZXViVEZiWEdvUDNTYVRCWXUrNFNEeXc1Y3hTMTVVeklWUkRwd1Bh?=
 =?utf-8?B?QXM0L1FIaHNHYTJxWVNHQytWZmlPVTFQb20zWjV1RGt3a1VlR2VnNURNcHZt?=
 =?utf-8?B?eXppRkZzbFQvNkRuSWdtMjBxamVsaWtHdlI5NUlOZHZHZFRwS0FCZTdhaWJM?=
 =?utf-8?B?dTd5NUFQSlh5Ym9GdWJrN2UzUjB4eFBoQlEvSnQ1b3RucjFJVnAvVmt0ZWlW?=
 =?utf-8?B?VnhpQlZtblZGUTAwSEtXcGR4N0dyK1ZoRTNwTXFXZWt1SGY1OGE5R2JwbzFV?=
 =?utf-8?B?UFIzaFJGSGIyOGhRV1VjSWF2UmFnVjNJVGg4NFhGTGNDM3JPNHVyVFFDNmhC?=
 =?utf-8?B?Q0txUWczSWdybzNaMVV0cFZYcUFtdEN5VU11QVVzZmV6NmRiZW1leG1QZ05r?=
 =?utf-8?B?OGFDU3JrV2FDS3djK3Y0ZUZNMVY4R2lLdWRUZzBLNEE2YjQ3c09zTno4bnhF?=
 =?utf-8?B?YWtGTnZFUnlPK2ZYMHdiZlBZaHRicjNaSHRBam5waHZJV1RIZk1JZnU1MVN2?=
 =?utf-8?B?V0hucXZlSk1MZTk5MTU0cUg5aTZ6em92cGgrN1FUdEFTR1Q5MDFJRVlLY25L?=
 =?utf-8?B?MW5PMW5OVmZMaUF0bU5qNXI1T1VGZnpLVE10UWsxSzNIRGQyYW1qV1VIRWw2?=
 =?utf-8?B?dnB0djUvTFJGWGZuR1Y2MGRNMExnWWtzWGwzaUt1WFVNV3BBNHdwNDgzOVEr?=
 =?utf-8?B?dHNTZDRGaVE4TGlnbExmeXM4SGRZRDk4VzV1RGkzVytySGk4ZFJFVCtsY3h3?=
 =?utf-8?B?RStsQktkQllHQTh5UTRPQlFiejBqN0ZKcDBnbllJZndFbHlLSnBnZ2QybE9Q?=
 =?utf-8?B?VndoanlQL0oxQlV3Z2gzeEJQckJVd3hORUlvRHdzV1VNVnp5MnJsVnNIdkhC?=
 =?utf-8?B?YjdjNEx4cCtpYjR0UFhtS2lEcDZuRXgxSlpEMklYSE1OUCtQalh1UzJRSkR3?=
 =?utf-8?B?dk5XY0hPTDVyMG92VG1GK01EMVA5Szk2N1RaYlppL2ZOUVFjRWowNHFTK0JM?=
 =?utf-8?B?bVJCaXBQTGg1c2JBL0VxNjRIMnJIRzhyMW90WWg1K0c4bklvT3ZKaXlra0Mw?=
 =?utf-8?B?Q1YwM3BCTjZ2YXRpQjN0bitIL29NVzlYb3MwWXVuN2dmMHZyREJvRHMyR1Fl?=
 =?utf-8?B?VHdsMFFtUzR4dTExUGk3MEQ3V1RnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <42CB707F49946F4883F88BD3E4EB2156@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b65e8c6d-f9f6-479a-9f05-08dd688b1c6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 15:14:44.2762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S9ursbd+/vbO2Do3gZ/jje4b4O41+TyKR8K8ZTeD5in5uIDsdRD3ignnSEp4DYGCkEKM1hwDQ86PgzqK7vq6sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3805

T24gRnJpLCAyMDI1LTAzLTIxIGF0IDEwOjM2IC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
T24gVGh1LCAyMDI1LTAzLTIwIGF0IDE2OjQwIC0wNDAwLCB0cm9uZG15QGtlcm5lbC5vcmfCoHdy
b3RlOg0KPiA+IEZyb206IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNw
YWNlLmNvbT4NCj4gPiANCj4gPiBXaGVuIGEgTkZTIGNsaWVudCBpcyBzdGFydGVkIGZyb20gaW5z
aWRlIGEgY29udGFpbmVyLCBpdCBpcyBvZnRlbg0KPiA+IG5vdA0KPiA+IHBvc3NpYmxlIHRvIGVu
c3VyZSBhIHNhZmUgc2h1dGRvd24gYW5kIGZsdXNoIG9mIHRoZSBkYXRhIGJlZm9yZSB0aGUNCj4g
PiBjb250YWluZXIgb3JjaGVzdHJhdG9yIHN0ZXBzIGluIHRvIHRlYXIgZG93biB0aGUgbmV0d29y
ay4NCj4gPiBUeXBpY2FsbHksDQo+ID4gd2hhdCBjYW4gaGFwcGVuIGlzIHRoYXQgdGhlIG9yY2hl
c3RyYXRvciB0cmlnZ2VycyBhIGxhenkgdW1vdW50IG9mDQo+ID4gdGhlDQo+ID4gbW91bnRlZCBm
aWxlc3lzdGVtcywgdGhlbiBwcm9jZWVkcyB0byBkZWxldGUgdmlydHVhbCBuZXR3b3JrIGRldmlj
ZQ0KPiA+IGxpbmtzLCBicmlkZ2VzLCBOQVQgY29uZmlndXJhdGlvbnMsIGV0Yy4NCj4gPiANCj4g
PiBPbmNlIHRoYXQgaGFwcGVucywgaXQgbWF5IGJlIGltcG9zc2libGUgdG8gcmVhY2ggaW50byB0
aGUgY29udGFpbmVyDQo+ID4gdG8NCj4gPiBwZXJmb3JtIGFueSBmdXJ0aGVyIHNodXRkb3duIGFj
dGlvbnMgb24gdGhlIE5GUyBjbGllbnQuDQo+ID4gDQo+ID4gVGhpcyBwYXRjaHNldCBwcm9wb3Nl
cyB0byBhbGxvdyB0aGUgY2xpZW50IHRvIGRlYWwgd2l0aCB0aGVzZQ0KPiA+IHNpdHVhdGlvbnMN
Cj4gPiBieSB0cmVhdGluZyB0aGUgdHdvIGVycm9ycyBFTkVURE9XTsKgIGFuZCBFTkVUVU5SRUFD
SCBhcyBiZWluZw0KPiA+IGZhdGFsLg0KPiA+IFRoZSBpbnRlbnRpb24gaXMgdG8gdGhlbiBhbGxv
dyB0aGUgSS9PIHF1ZXVlIHRvIGRyYWluLCBhbmQgYW55DQo+ID4gcmVtYWluaW5nDQo+ID4gUlBD
IGNhbGxzIHRvIGVycm9yIG91dCwgc28gdGhhdCB0aGUgbGF6eSB1bW91bnRzIGNhbiBjb21wbGV0
ZSB0aGUNCj4gPiBzaHV0ZG93biBwcm9jZXNzLg0KPiA+IA0KPiA+IEluIG9yZGVyIHRvIGRvIHNv
LCBhIG5ldyBtb3VudCBvcHRpb24gImZhdGFsX2Vycm9ycyIgaXMgaW50cm9kdWNlZCwNCj4gPiB3
aGljaCBjYW4gdGFrZSB0aGUgdmFsdWVzICJkZWZhdWx0IiwgIm5vbmUiIGFuZA0KPiA+ICJlbmV0
ZG93bjplbmV0dW5yZWFjaCIuDQo+ID4gVGhlIHZhbHVlICJub25lIiBmb3JjZXMgdGhlIGV4aXN0
aW5nIGJlaGF2aW91ciwgd2hlcmVieSBoYXJkIG1vdW50cw0KPiA+IGFyZQ0KPiA+IHVuYWZmZWN0
ZWQgYnkgdGhlIEVORVRET1dOIGFuZCBFTkVUVU5SRUFDSCBlcnJvcnMuDQo+ID4gVGhlIHZhbHVl
ICJlbmV0ZG93bjplbmV0dW5yZWFjaCIgZm9yY2VzIEVORVRET1dOIGFuZCBFTkVUVU5SRUFDSA0K
PiA+IGVycm9ycw0KPiA+IHRvIGFsd2F5cyBiZSBmYXRhbC4NCj4gPiBJZiB0aGUgdXNlciBkb2Vz
IG5vdCBzcGVjaWZ5IHRoZSAiZmF0YWxfZXJyb3JzIiBvcHRpb24sIG9yIHVzZXMgdGhlDQo+ID4g
dmFsdWUgImRlZmF1bHQiLCB0aGVuIEVORVRET1dOIGFuZCBFTkVUVU5SRUFDSCB3aWxsIGJlIGZh
dGFsIGlmIHRoZQ0KPiA+IG1vdW50IHdhcyBzdGFydGVkIGZyb20gaW5zaWRlIGEgbmV0d29yayBu
YW1lc3BhY2UgdGhhdCBpcyBub3QNCj4gPiAiaW5pdF9uZXQiLCBhbmQgb3RoZXJ3aXNlIG5vdC4N
Cj4gPiANCj4gPiBUaGUgZXhwZWN0YXRpb24gaXMgdGhhdCB1c2VycyB3aWxsIG5vcm1hbGx5IG5v
dCBuZWVkIHRvIHNldCB0aGlzDQo+ID4gb3B0aW9uLA0KPiA+IHVubGVzcyB0aGV5IGFyZSBydW5u
aW5nIGluc2lkZSBhIGNvbnRhaW5lciwgYW5kIHdhbnQgdG8gcHJldmVudA0KPiA+IEVORVRET1dO
DQo+ID4gYW5kIEVORVRVTlJFQUNIIGZyb20gYmVpbmcgZmF0YWwgYnkgc2V0dGluZyAiLW9mYXRh
bF9lcnJvcnM9bm9uZSIuDQo+ID4gDQo+ID4gLS0tDQo+ID4gdjI6DQo+ID4gLSBGaXggTkZTdjQg
Y2xpZW50IGNsX2ZsYWcgaW5pdGlhbGlzYXRpb24NCj4gPiAtIEFkZCBSUEMgdGFzayBmbGFnIHRy
YWNlIGRlY29kaW5nDQo+ID4gDQo+ID4gVHJvbmQgTXlrbGVidXN0ICg0KToNCj4gPiDCoCBORlM6
IEFkZCBhIG1vdW50IG9wdGlvbiB0byBtYWtlIEVORVRVTlJFQUNIIGVycm9ycyBmYXRhbA0KPiA+
IMKgIE5GUzogVHJlYXQgRU5FVFVOUkVBQ0ggZXJyb3JzIGFzIGZhdGFsIGluIGNvbnRhaW5lcnMN
Cj4gPiDCoCBwTkZTL2ZsZXhmaWxlczogVHJlYXQgRU5FVFVOUkVBQ0ggZXJyb3JzIGFzIGZhdGFs
IGluIGNvbnRhaW5lcnMNCj4gPiDCoCBwTkZTL2ZsZXhmaWxlczogUmVwb3J0IEVORVRET1dOIGFz
IGEgY29ubmVjdGlvbiBlcnJvcg0KPiA+IA0KPiA+IMKgZnMvbmZzL2NsaWVudC5jwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNSArKysrDQo+ID4gwqBm
cy9uZnMvZmxleGZpbGVsYXlvdXQvZmxleGZpbGVsYXlvdXQuYyB8IDI0ICsrKysrKysrKysrKysr
LS0NCj4gPiDCoGZzL25mcy9mc19jb250ZXh0LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8IDM4DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiDCoGZz
L25mcy9uZnMzY2xpZW50LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
wqAgMiArKw0KPiA+IMKgZnMvbmZzL25mczRjbGllbnQuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHzCoCA3ICsrKysrDQo+ID4gwqBmcy9uZnMvbmZzNHByb2MuY8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMyArKw0KPiA+IMKgZnMv
bmZzL3N1cGVyLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfMKgIDIgKysNCj4gPiDCoGluY2x1ZGUvbGludXgvbmZzNC5owqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxICsNCj4gPiDCoGluY2x1ZGUvbGludXgvbmZzX2ZzX3Ni
LmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMiArKw0KPiA+IMKgaW5jbHVkZS9saW51
eC9zdW5ycGMvY2xudC5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNSArKystDQo+ID4gwqBp
bmNsdWRlL2xpbnV4L3N1bnJwYy9zY2hlZC5owqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEgKw0K
PiA+IMKgaW5jbHVkZS90cmFjZS9ldmVudHMvc3VucnBjLmjCoMKgwqDCoMKgwqDCoMKgwqAgfMKg
IDEgKw0KPiA+IMKgbmV0L3N1bnJwYy9jbG50LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfCAzMCArKysrKysrKysrKysrKy0tLS0tLQ0KPiA+IMKgMTMgZmlsZXMg
Y2hhbmdlZCwgMTEwIGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiANCj4g
V2l0aCB0aGUgYnVnIGluIHBhdGNoICMzIGZpeGVkLCB5b3UgY2FuIGFkZDoNCj4gDQo+IFJldmll
d2VkLWJ5OiBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPg0KPiBUZXN0ZWQtYnk6IEpl
ZmYgTGF5dG9uIDxqbGF5dG9uQGtlcm5lbC5vcmc+DQoNClRoYW5rcyBmb3IgYm90aCB0aGUgYnVn
Zml4IGFuZCB0aGUgdGVzdGluZyEgSSdsbCBzZW5kIG91dCBhIHYzLg0KDQpJbiBhZGRpdGlvbiB0
byB0aGUgYWJvdmUgZml4LCBJIHdhbnQgdG8gY2hhbmdlIHRoZSBuYW1lIG9mIHRoZSBtb3VudA0K
b3B0aW9uIHRvIGJlICJmYXRhbF9uZXRlcnJvciIsIGFuZCB0aGVuIGNhcGl0YWxpc2UgdGhlDQpF
TkVURE9XTjpFTkVUVU5SRUFDSCwgc28gdGhhdCBpdCBpcyBtb3JlIG9idmlvdXMgdGhhdCBpdCBy
ZWZlcnMgdG8gdGhlDQpQT1NJWCBlcnJvcnMuIEF0IHNvbWUgcG9pbnQsIHdlIG1heSB3YW50IHRv
IGFkZCBzdXBwb3J0IGZvciBmdXJ0aGVyDQpzdWNoIGVycm9ycywgaGVuY2UgdGhlIGZ1c3NpbmVz
cy4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwg
SGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

