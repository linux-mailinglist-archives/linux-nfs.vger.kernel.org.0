Return-Path: <linux-nfs+bounces-10096-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBBFA34C00
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 18:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CD3E3A11E2
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 17:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EDE1547F5;
	Thu, 13 Feb 2025 17:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="TRxt+2nP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2094.outbound.protection.outlook.com [40.107.223.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDF41C863C
	for <linux-nfs@vger.kernel.org>; Thu, 13 Feb 2025 17:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739467765; cv=fail; b=Ce3yqm/aQomQG+H+gAxMKCpeV0M83Dbyt4t/b2hetmYgZfDX/mbJ10pf9lb1ojXx84gLUzpEhOrbp/ZyFKAMX9yYVOnOrlAdLE68BC+VSpESJL8M9XR7IbijBr/47HlFFPq36e+HV3HERN/I3y4WV1SsdIr+nDyrLmfAGzUt2oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739467765; c=relaxed/simple;
	bh=wMapam/pEm1VGtud4onpZVFfHddDebR9gdEDyVxcFwk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s/sE/8zgkZGbUHJSXcBAh5nmfndN0UA3e8DotlAOE+vQEeYIgbb21Jrtus62Wp6chtU4yOKt/iyz2erlyy3AhYAa9mz3KJ6MPC5Y02+SkXs0rSm9xBfwz5CpCDYnnLnxmprCib0Ew76Z1XDselh12jC35tseXxR3iIulWvmNmJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=TRxt+2nP; arc=fail smtp.client-ip=40.107.223.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ARsyQW3fp3TgBKNoxgq5fs0vohYV6WhQ3cEjlDB3ExyMpZpLhf5mbkDSwM2Jodp89jJ8dizOB8IQ7PpjY64ucTV84EL5pJKka9tiCwMp9aDCtkTDNzh17ROUmsBHVvlzB0ciCth8jJb5cm1xKrDEmEFwE4tb6JX4KvN95EezLJj8wUyZCiAcOIbTkVqyXMvwKMplv7mhuVlwAc+36mVM3TILcRrfppuFaZmaxZ/9KLjimrzZlMPx2fhqmFDx8VK08zit4aS2rmsfXOGNEw0Unb/hO0p22hK7gu7e1MyJRw1b9cWbHjJ+VSgf0EJAcBoWIWL4+Rl0XpRvU97lA6TU1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMapam/pEm1VGtud4onpZVFfHddDebR9gdEDyVxcFwk=;
 b=LbLz44H7NJkHRyw9UkxZJR8JtQocptOODFgPSY/BqAv6ef7tnRtV4To9zA8H4yi029xsCCx1LoDFIUns+OIG34UEjtbnezbtCErCHCYWJ+R0tgStm3E8nBg4fc8pmj/oW1fevLm+YHJQvbRiclKUaQjjdpoFqDKWEjmPYplRloltHTzF1W/m+rkGCAZA1luToLU2wXiC/BsSnfr/qpj8VfVXrvTaOi8UdFWQX+Ni19NyA2jqrAntIJSuvnFajjJ1N7HwH4rHoRaUR14r9yt/tFxtaJq7fBvpe+c5NNwrt4tir6euBMOCcA1itIeOsCliZ+COnOpMTqsKY90LKHmZMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMapam/pEm1VGtud4onpZVFfHddDebR9gdEDyVxcFwk=;
 b=TRxt+2nPUI88kLfXw9sdmgyd3O2Sch0jNGnxvnD5TZQc0SH1F8UwFvUF8TOFwDLb5U9g7LeGEMoCBIWJlB78auBVPDYimvUg3gnib9m6D+bTnX1zReni2PBZdLy2NpyKsPA1W+qtq6cR6CBaP51t/88BhBAV55j9z8JXQ7YYFWM=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DS1PR13MB6850.namprd13.prod.outlook.com (2603:10b6:8:1df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 13 Feb
 2025 17:29:18 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%3]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 17:29:17 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "okorniev@redhat.com" <okorniev@redhat.com>, "cel@kernel.org"
	<cel@kernel.org>, "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [RFC PATCH] NFS: CB_OFFLOAD should return DELAY when no copy
 state ID matches
Thread-Topic: [RFC PATCH] NFS: CB_OFFLOAD should return DELAY when no copy
 state ID matches
Thread-Index: AQHbfjOM2qaXtGaATkKgNd/ysX5erbNFc3UAgAADSQCAAAZ3AA==
Date: Thu, 13 Feb 2025 17:29:16 +0000
Message-ID: <dec9ecb1e51f0b266620dd671d0b1c4e645ce49c.camel@hammerspace.com>
References: <20250213161555.4914-1-cel@kernel.org>
	 <df999d533683548ba91b69b017bf2b4acc0add52.camel@hammerspace.com>
	 <a203bead-b24e-4a58-87b6-17ea2c90bf24@oracle.com>
In-Reply-To: <a203bead-b24e-4a58-87b6-17ea2c90bf24@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|DS1PR13MB6850:EE_
x-ms-office365-filtering-correlation-id: cc1c709f-3b46-4466-f9d3-08dd4c53f14a
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RXY2VDJXcHcwa0RtSVhKeG1NZk1SRVFNMUtEQWdZTDluM0pBVW1KWnA3SUJw?=
 =?utf-8?B?bGh0cTlYZi84SWZPZXZQUFltRHoxUTAzV3VicS9ZZnh3YXZyMnhiTGNoRkY3?=
 =?utf-8?B?cUlCZlpoRG9KOHB2Wk9lUHdiOENBM1RYNjBqaFpqZ0sydFhKV3BVdWw0c0Y5?=
 =?utf-8?B?Zm9DUnpKbHNTWkc5Z214VnFCcXVXSTNUUkZDYW5VLytZMWd1T2pHV0Uwd0RO?=
 =?utf-8?B?aGdyQnk2UFZOdjZBM0pHK283a3ROcUdmcFFkRW9OdkdEa3NtaVltZ2hhakgz?=
 =?utf-8?B?QVlvenhTTC81SXlJVWZSSkdhMW1QQkR3ZFZvMDZkZ0lTSXE2VmphUmJxYUdm?=
 =?utf-8?B?cTJwWE9wWThRaERqdy80NkdRd2o1L0xRY3YzekxEcmord0ZqdllVL3dOVGRa?=
 =?utf-8?B?T2RxdlJDUW5oaFMxeDFzS2M2SjBBRlJwcG9nekoyaGJSc284S2JnMWNjMTh4?=
 =?utf-8?B?dGFCSlR2enc5NFlDUHFvVUo3VmJCbVE5Y0dvd1R6Qm4zSWdzeFF1SUp5d0Ro?=
 =?utf-8?B?S1lGUStTRWw1WjE5dW12dVN3VW01ekw3eUFZNm0vUytxOVhTdHM3ZnZBTENI?=
 =?utf-8?B?c0VoRzRRWXZ4elRKV3Y5ejZzaDFpNVVIc0pTVG1mOUJMNzRUcGgwOXdvMmVs?=
 =?utf-8?B?U1Q0WlBRZ1lmR0FXRWZ5WEw2MkRVYnJXakJmZUpLRmF6aFFVRGlGb1ZWRHcw?=
 =?utf-8?B?UGVqM2pJZWxoWHhNcldoRnNtNFFFeE1yNGg5ay8xSFVPWDJMTDB0VGEzUFRN?=
 =?utf-8?B?OEVnbnJCOGl3cEUvMVZDRGNGWFpMNDNIN0xUZG8xZlNKUXdmREFQdFZyV0Rv?=
 =?utf-8?B?MGEyVVdOV2ZnRGRndlRQbG5DRUhvTVk5U0xsRU5GUExkQmFkWnpSVDVuU3Yv?=
 =?utf-8?B?SDFjNmVnNDJSMlM3TUo2emNodlA0TC9sUGtQZHRRYmFVQXhON29Db3VpdUNn?=
 =?utf-8?B?R3BmekpFZE5BY0srU2VzajlFNVpoZU1JMDdQWVhUS3IvYzI2UUZSM3hVVnRI?=
 =?utf-8?B?aHZReXFLM0FDOVhueFlwNW9oQllUblBvQis1TVByVTZjM0pEOFdLak9YbGJO?=
 =?utf-8?B?VVBIZ04vWFBjVkQ1NVhQa0E3V2traUlxdnhWbk9rUnFYbGdJVkpLOVExN2tV?=
 =?utf-8?B?dmZXZ2tGSnNmYmJhUjZydnFiaXA5ZVV4ZEdQTXBLQlZ3UERmYkFDa3pLUHh4?=
 =?utf-8?B?eXJrWWNieG1qVXBTTHpRVWRNa3ZoYjB2NWxjRmFsb0srN1d4cnZlOUgyNmEv?=
 =?utf-8?B?MVdkOUp2cmVjRmxpK3Z6Y29sck5BU2Z3cXhEWHN3Z1BRUDMyb2JJZXBkSURw?=
 =?utf-8?B?Nk5OcnduRHpaT3hmN3Y1a1YyWEdycXFpMTRKMGx6WFR2VjBZNnBsYXhiTlhj?=
 =?utf-8?B?ZmI1QjJQaXdvc2sxRVdTTkZOcGRGdUxzR0hNQVQ4MzJXTkk5LzZ5QUx0VHUr?=
 =?utf-8?B?aVBNbzdHT2Y2ODdBSGV6N0I5MEZmeTU4ek1jd25lZ1ZjUXcvNzBoSTZKbUZ3?=
 =?utf-8?B?ZWk1ZFl2dFU3c05XOEV5YmUvWm5IVzRSVmU0bkhORlJ2SEFCa2pTQnc1ZkEy?=
 =?utf-8?B?U24zWHVLWTZpVzI1b283ZHloVTRhNDRQQ0xrNmg5NTRnNWsreWFmZy9KWm1t?=
 =?utf-8?B?UHZtMVpCSWtvbU0yckpSMVI0eE5SQ1dKQ1VkbTVqZ2FaM2x1WlZSZ1RoUzg4?=
 =?utf-8?B?K29vbk05U1JmdncrZDlWRGVQOXIwN1lHL3lvWE4ybXM1K0dUZEtSTGc0UEYv?=
 =?utf-8?B?Y1NNQTFBaVFwaDFCL3lGWUtuaUhDY1QxdDhKeFMvRWh4TzVITkxmOW5ZT0Rv?=
 =?utf-8?B?amc1M2NleEhqSlJneTdWQStocitFV0tsY21ucFh2NEpnZmdtVElheVdXdGVR?=
 =?utf-8?B?SDZKbmVHdDkrVkRFcTYrWENCVzZ0SDlzdC9TcExoM0ZHaEdmRm9IRDRScHZW?=
 =?utf-8?Q?2/5GIYrLMxZdgcOtXtD0XZsqGwLRxEM1?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OXRYb012Z3RYeDRuUWlMUjkvekQ4eFg1a2ZWa01oNkxVMjdYaG9KVnFIN29W?=
 =?utf-8?B?QTkydjJ2RDBEbGZjendaVmZla0hIdkxac0JzRTJQL3BjOWpqaHBvbVoySTF6?=
 =?utf-8?B?NFp5eUVKdUdXYTJtM1RmdFNpTTFwcnBabzVqOHZDaHUyRkJRQkdXUVVpeVc0?=
 =?utf-8?B?dXpVMXFNa2QxVHh0cU4rQnMyNVVmWHVpQjdwaFNDNlR3Q21aVWh2Zk45RzJs?=
 =?utf-8?B?Zmx0M1BRVzhKV2QwNWlnSTlwT0JVU0oybndHVVpCRG1UZWFUUkdDbkt3cTJM?=
 =?utf-8?B?VTdoQklHNVNldE5EdDBKRzNMajRIT3VKNTFYUE1sRE1GSXBFbnZXMGN6RlNu?=
 =?utf-8?B?aEhKdmpDRDBtNTdDM0Z0czhqaFh2aWV5TXlTVUlpeHRLUmtkTUk1eC9mcTI1?=
 =?utf-8?B?RjNqUVFGQ1daaTZabXBwQTdPNGd6d1VOc21keHYxRUQ1N01rSDZLc3dNcnFn?=
 =?utf-8?B?TThDR0JzYjhCMko2Q0F3cFN0LzYreDljUmloK1ZRRjV6U1BGc1grQnNMU2l4?=
 =?utf-8?B?S3V1VjhzREd6WjNGcVlCUzMrc0c2TkIxWExnVno1Sm56bjhDYjN6UWRueE55?=
 =?utf-8?B?dlNKRVFyWDdnWjdBV3JxNzRyMk5TQlZabUdwV08xWXA4elE1YnM0aThYakk0?=
 =?utf-8?B?aFFxckFuMFZ3UXZYMVR6M05XUFNJeXpMZmIyVjNtVG0zalR4S2xvaElhbzB2?=
 =?utf-8?B?Ti9mMVB5QjNhMER3Q3FpbEI0Vk9RMHhkeGxlYXBkSGk0ZjhYU3VtbWE2MmNN?=
 =?utf-8?B?Y01sUlAxS3pmNWVRZGhuakwwNHlTeFRHK1dLNi95cDErbU50ZUxocnZzbG05?=
 =?utf-8?B?b0llWmRockpQdDZyYkNDN052SnlZQnluOFNQY0R5RXdOaDlGMm5zTzJJekR0?=
 =?utf-8?B?NkJ3R09pRXFQNkVydUVkRTVkWHV6SXg5UUxiZTJIVFlGTXIzaDdpVmNNMFV0?=
 =?utf-8?B?MGtlNE91S0U4QlZGVGdsWWk2bUQzVHNhU1k3YVE2WlhtYlJtOGFQTm5ZNFVw?=
 =?utf-8?B?cDN6aitxaWMrNFY2OWdjQXkvMGlCOXFsRWk5YnhCTUtXSGZlYWlEdHRIYWZN?=
 =?utf-8?B?WVV2d1ZtWUVoSXBqcU5Gdkc2bklEZnFlak1vemdGUjNnNUlUUERKWHgzV2hO?=
 =?utf-8?B?QWdpa29uR1dkMCsveDkwM1IvL0lsQVF1ZHREc3pSWUl0MW81YUlCRVI1Ui92?=
 =?utf-8?B?Z2lNaGVRbmFUaFoxc2VtVXJjT1pVdFJyb01jYTJFTUhIRmZyNmZLVjZyYmk2?=
 =?utf-8?B?amlOSm8wbWRzU2V2MG5Ddzc2ZkduN2FqU0hEcWpzVldNcFFqaklJSGFaZjZR?=
 =?utf-8?B?eDEvVVk5dFhHem9uYnhnNGNjdHhId1l0aUVaV1U0L2JKaFdvd1VCNHdweDIw?=
 =?utf-8?B?alpvZ3FIZTVCcmMrUXc3UmU1VU96NG80dWI1QWI4eHNMb21kTTR6YnEyR1RH?=
 =?utf-8?B?OVYvT0xhcUljT3BNOVN0M2h4UWN3anlJUklWZUdqWE8vbnp1QVYySFUvYW1a?=
 =?utf-8?B?NC9ualNWVUpqRjdBM3lncHZWYlY4VTFuOGgxV1A1bDVWUlJ0ZWVNbFBjVjhj?=
 =?utf-8?B?ZjJkYzNIOU9jYjI4T3RIMlRvL2FwMklUejZObkRsMnhxWWcyZ1hhbk44WDdS?=
 =?utf-8?B?OTdydHpLeGlla2dlZU9EUkZtUHp6WVFYNmhBR05CUnlnTXVvMWF3dWZwY3E2?=
 =?utf-8?B?SWcvcU5pL1NzWGhYajNERXNJeko4R052Mys5Ri9YSFg4QnJibC9lZjRXZ2Fz?=
 =?utf-8?B?TGpMUXN3dmFsSXVKSkMwTjVsSms5enVPcWR3U29BaUpkdVJBV0l1MDlEOHpH?=
 =?utf-8?B?RDk0dGVEdFpjamJGbFQ5NnJGZ1FGeVVyMU80bGNHOEdLMkV3TEpKK291aHNG?=
 =?utf-8?B?aWtpMnFuK3NlMkcreitWcG83blVpN3VuUU9zd1oyVm56MDJudzgrblBwZmI0?=
 =?utf-8?B?U1dDNXdqdGhkUFE2TDZSUmJNZkYxbXEzZGZBdTVJV3ordzFhYStDeitYaHJD?=
 =?utf-8?B?RmRmOVFtdGsyU25jckoyS01LS2JrRWh4a01nVUUzejNEcmFZQysvQ1F6MkpN?=
 =?utf-8?B?OXVKcmRGbzlkQzhqTThkMU1hbXo3MGwrTjh3dEx6MjhvWEFhTXZVSzhKeXMv?=
 =?utf-8?B?cVFYbSs4d3k0cjQwM243RVprUHppVWJ3eHZIamFOcThpTTN3NU1FVGgwUVlT?=
 =?utf-8?B?aHZZdDF2UTFJM0xFY1R2alQ1WllRZ25aQUZVbmdtM1NMcGNadm9lcXlZTEtk?=
 =?utf-8?B?S0tuTmUvbWtUNDZxREZKSkxDR3BBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5069A20A397E524C8273DFBBC2154F98@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1c709f-3b46-4466-f9d3-08dd4c53f14a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 17:29:17.0139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k6N5sj9GZVREq4zBw593XcGCIVZCUBm3zK5I9kU8xXdQ/r5uNNfN9Z83ohNJtjxQ7cyiffxpT5XOAHAnGTNSUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR13MB6850

T24gVGh1LCAyMDI1LTAyLTEzIGF0IDEyOjA2IC0wNTAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
T24gMi8xMy8yNSAxMTo1NCBBTSwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOg0KPiA+IE9uIFRodSwg
MjAyNS0wMi0xMyBhdCAxMToxNSAtMDUwMCwgY2VsQGtlcm5lbC5vcmfCoHdyb3RlOg0KPiA+ID4g
RnJvbTogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+DQo+ID4gPiANCj4gPiA+
IFRoZSBORlN2NC4yIHByb3RvY29sIHJlcXVpcmVzIHRoYXQgYSBjbGllbnQgbWF0Y2ggYSBDQl9P
RkZMT0FEDQo+ID4gPiBjYWxsYmFjayB0byBhIENPUFkgcmVwbHkgY29udGFpbmluZyB0aGUgc2Ft
ZSBjb3B5IHN0YXRlIElELg0KPiA+ID4gSG93ZXZlciwNCj4gPiA+IGl0J3MgcG9zc2libGUgdGhh
dCB0aGUgb3JkZXIgb2YgdGhlIGNhbGxiYWNrIGFuZCByZXBseSBwcm9jZXNzaW5nDQo+ID4gPiBv
bg0KPiA+ID4gdGhlIGNsaWVudCBjYW4gY2F1c2UgdGhlIENCX09GRkxPQUQgdG8gYmUgcmVjZWl2
ZWQgYW5kIHByb2Nlc3NlZA0KPiA+ID4gL2JlZm9yZS8gdGhlIGNsaWVudCBoYXMgZGVhbHQgd2l0
aCB0aGUgQ09QWSByZXBseS4NCj4gPiA+IA0KPiA+ID4gQ3VycmVudGx5LCBpbiB0aGlzIGNhc2Us
IHRoZSBMaW51eCBORlMgY2xpZW50IHdpbGwgcXVldWUgYSBmcmVzaA0KPiA+ID4gc3RydWN0IG5m
czRfY29weV9zdGF0ZSBpbiB0aGUgQ0JfT0ZGTE9BRCBoYW5kbGVyLg0KPiA+ID4gaGFuZGxlX2Fz
eW5jX2NvcHkoKSB0aGVuIGNoZWNrcyBmb3IgYSBtYXRjaGluZyBuZnM0X2NvcHlfc3RhdGUNCj4g
PiA+IGJlZm9yZSBzZXR0bGluZyBkb3duIHRvIHdhaXQgZm9yIGEgQ0JfT0ZGTE9BRCByZXBseS4N
Cj4gPiA+IA0KPiA+ID4gQnV0IGl0IHdvdWxkIGJlIHNpbXBsZXIgZm9yIHRoZSBjbGllbnQncyBj
YWxsYmFjayBzZXJ2aWNlIHRvDQo+ID4gPiByZXNwb25kDQo+ID4gPiB0byBzdWNoIGEgQ0JfT0ZG
TE9BRCB3aXRoICJJJ20gbm90IHJlYWR5IHlldCIgYW5kIGhhdmUgdGhlIHNlcnZlcg0KPiA+ID4g
c2VuZCB0aGUgQ0JfT0ZGTE9BRCBhZ2FpbiBsYXRlci4gVGhpcyBhdm9pZHMgdGhlIG5lZWQgZm9y
IHRoZQ0KPiA+ID4gY2xpZW50J3MgQ0JfT0ZGTE9BRCBwcm9jZXNzaW5nIHRvIGFsbG9jYXRlIGFu
IGV4dHJhIHN0cnVjdA0KPiA+ID4gbmZzNF9jb3B5X3N0YXRlIC0tIGluIG1vc3QgY2FzZXMgdGhh
dCBhbGxvY2F0aW9uIHdpbGwgYmUgdG9zc2VkDQo+ID4gPiBpbW1lZGlhdGVseSwgYW5kIGl0J3Mg
b25lIGxlc3MgbWVtb3J5IGFsbG9jYXRpb24gdGhhdCB3ZSBoYXZlIHRvDQo+ID4gPiB3b3JyeSBh
Ym91dCBhY2NpZGVudGFsbHkgbGVha2luZyBvciBhY2N1bXVsYXRpbmcgb3ZlciB0aW1lLg0KPiA+
IA0KPiA+IFdoeSBjYW4ndCB0aGUgc2VydmVyIGp1c3QgZmlsbCBhbiBhcHByb3ByaWF0ZSBlbnRy
eSBmb3INCj4gPiBjc2FfcmVmZXJyaW5nX2NhbGxfbGlzdHM8PiBpbiB0aGUgQ0JfU0VRVUVOQ0Ug
b3BlcmF0aW9uIGZvciB0aGUNCj4gPiBDQl9PRkZMT0FEIGNhbGxiYWNrPyBUaGF0J3MgdGhlIG1l
Y2hhbmlzbSB0aGF0IGlzIGludGVuZGVkIHRvIGJlDQo+ID4gdXNlZA0KPiA+IHRvIGF2b2lkIHRo
ZSBhYm92ZSBraW5kIG9mIHJhY2UuDQo+IA0KPiBJbnRyaWd1aW5nIHN1Z2dlc3Rpb24uDQo+IA0K
PiBJdCB3b3VsZCBiZSBoZWxwZnVsIGlmIHRoYXQgd2VyZSBjYWxsZWQgb3V0IGluIFJGQyA3ODYy
LiBTaG91bGQNCj4gc3VwcG9ydA0KPiBmb3IgcmVmZXJyaW5nIGNhbGwgbGlzdHMgYmUgYSByZXF1
aXJlbWVudCwgdGhlbiwgZm9yIGFzeW5jIENPUFkNCj4gb2ZmbG9hZD8NCj4gSSBkb24ndCBzZWUg
YSBub3JtYXRpdmUgbWFuZGF0b3J5LXRvLWltcGxlbWVudCBzdGF0ZW1lbnQgZm9yIHJjbCdzIGlu
DQo+IFJGQyA4ODgxLCBpZiB0aGF0IG1hdHRlcnMuDQoNCk5vLCBidXQgaW4gcHJhY3RpY2UgaXQg
aXMgaW1wb3NzaWJsZSB0byByZXNvbHZlIHNldmVyYWwgdHlwZXMgb2YgcmFjZXMNCndpdGhvdXQg
aXQuIFBhcnRpY3VsYXJseSBmb3IgZGVsZWdhdGlvbnMuDQoNCj4gUHJhY3RpY2FsbHkgc3BlYWtp
bmcsIHRob3VnaCwgTkZTRCBjYWxsYmFjayBkb2VzIG5vdCAoeWV0KSBzdXBwb3J0DQo+IHJlZmVy
cmluZyBjYWxsIGxpc3RzLiBJdCdzIGJlZW4gbGVmdCBhcyBhbiBleGVyY2lzZSBmb3Igc29tZSB0
aW1lLiBXZQ0KPiBzaW1wbHkgaGF2ZW4ndCBoYWQgYSBzdHJvbmcgZHJpdmVyIGZvciBpdC4gTWF5
YmUgd2UgZG8gbm93Lg0KPiANCj4gDQpJdCBpcyBhbHNvIG5lZWRlZCBmb3IgdGhlIHNhbWUga2lu
ZCBvZiByYWNlIHdpdGggZGVsZWdhdGlvbiByZWNhbGxzLA0KbGF5b3V0IHJlY2FsbHMsIENCX05P
VElGWV9ERVZJQ0VJRCBhbmQgd291bGQgYWxzbyBiZSBoZWxwZnVsIChhbHRob3VnaA0Kbm90IGFz
IHN0cm9uZ2x5IHJlcXVpcmVkKSBmb3IgQ0JfTk9USUZZX0xPQ0suDQoNCklPVzogdGhlcmUgc2hv
dWxkIGJlIHNldmVyYWwgb3RoZXIgaW5jZW50aXZlcyBmb3Igd2FudGluZyB0byBpbXBsZW1lbnQN
Cml0IGluIGtuZnNkLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBt
YWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0K
DQoNCg==

