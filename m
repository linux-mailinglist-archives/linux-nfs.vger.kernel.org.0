Return-Path: <linux-nfs+bounces-5431-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF34F95599E
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Aug 2024 22:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3DA21C20B5B
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Aug 2024 20:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01DE155A4F;
	Sat, 17 Aug 2024 20:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="DZ3mbySg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2119.outbound.protection.outlook.com [40.107.92.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDD62770E;
	Sat, 17 Aug 2024 20:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723927227; cv=fail; b=l2caHgw+ca9JGOmbP0azNVwxpalBFljgpuFvK6v6mjvVXwsd9LbfloCHuzd4KzCZZwoYsMGdz8sr7Gs5mBYNqjaPFa7tCiYw0oPSCeGMIYSyEz+8hdDqHtkUEYOyZHBrhisjNd/tvz5XLNP//ndX6xPLa9BTU2erL8M9K3vLxVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723927227; c=relaxed/simple;
	bh=fc7Z3xgDYZ3ponJInXwaIkvkg0mK184uljEW+Ugijnc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WwALCnb3ouHtWrswOyd9YPzvpBvU0JgXhLB1RM63KyvTOHmW8g8gWK5OgTqyg2mwxJE0RtdzWp7C0l6v8A2IBuylW6BsZe0rlR3WmSHCCFJO+LrY6qbUL1ZazzmzgQOPx2WikPyfXLQvawbKxHTMf3urDxkFXMjyjatVA/YQbVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=DZ3mbySg; arc=fail smtp.client-ip=40.107.92.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HxJzrblLwvovHPqLxTWDmr84srSMAtLSO36tRL44zxDD9svHoY17PLnufBZ7X+4L8PDzzHxASRFn2gCg6P54s3aXUV06tZdbr/NoF/5T932kxHREyV768KPDov1WKp01lIW3+VVGpKgYFDyaipmfV+Z1awWDfcyLatGAwkPfns+pzitxoNV+msSh6M6Q2QPu0GOCQVUpU+wvZS4IUA9BYeKD6iBxb1qwZsDy0MxcGr9oJjHbBQSLGeOuEoeRwVCG/HltXiMVMIf1b61z6r+WRqGQrwPl/nspLcNV7ZyL9MAlFdr5S9l9JJHse/64v9JbUFEX9EKiRsirrojrdF0+Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fc7Z3xgDYZ3ponJInXwaIkvkg0mK184uljEW+Ugijnc=;
 b=Pb9OI+NkviGRDtpc0W4Gp3p96tSfEV8TO5WO4jxWFHFGYLy8L/OGLP6CIHDG7qhTnwO87e75lT78WJMBjA3w+b+zllP3UOLjw+0JUc01Wmvu+zszAKoCI9WSua1cnlPleFLyNDQaAvFSnBA2VY3Eil9IIdcr4LKeRhAcltbDSO4ELgUICu8p05U8x6WnSHx+5W2xoAxsuB8/zUBHGUmgAs8d88of6q0t9A9SUf7ceMIEEIVQAqeEUOM5qV7burJH0iUT931KS95bB80TAmfiTjn47lAXs4QTOft1NEzIDqn8ZSyfLFUN6CMex067Gm3gzW5GhuZDVy+3CHnsmdOoOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fc7Z3xgDYZ3ponJInXwaIkvkg0mK184uljEW+Ugijnc=;
 b=DZ3mbySgl/g8A9Mo8ykXaf1Jg6R7dB6+n8rkQa6I+8tyqAE/4NlLLGEFaD80HZarSAGjyX9FTkUiOQhNL2NYyBBHu1AcQmbq1FMZrjXU3IHMNkXQTNpjUFWc0KQMGZ3AxpU/cCIp1xuvLPFQnTOK5nXpNKmDqmbAVJ+9/iOpLUk=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by IA3PR13MB6885.namprd13.prod.outlook.com (2603:10b6:208:51c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Sat, 17 Aug
 2024 20:40:20 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%4]) with mapi id 15.20.7875.019; Sat, 17 Aug 2024
 20:40:19 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "kees@kernel.org" <kees@kernel.org>, "thorsten.blum@toblux.com"
	<thorsten.blum@toblux.com>, "bcodding@redhat.com" <bcodding@redhat.com>,
	"anna@kernel.org" <anna@kernel.org>, "josef@toxicpanda.com"
	<josef@toxicpanda.com>, "jlayton@kernel.org" <jlayton@kernel.org>,
	"kolga@netapp.com" <kolga@netapp.com>, "gustavoars@kernel.org"
	<gustavoars@kernel.org>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] NFS/flexfiles: Replace one-element array with
 flexible-array member
Thread-Topic: [PATCH] NFS/flexfiles: Replace one-element array with
 flexible-array member
Thread-Index: AQHa8LDI/MbBk87yyEycg4oYLHSSZ7Ir6fSA
Date: Sat, 17 Aug 2024 20:40:19 +0000
Message-ID: <20690564a768f4c7e6ff9c3a7a520b9f36abef1d.camel@hammerspace.com>
References: <20240817142022.68411-2-thorsten.blum@toblux.com>
In-Reply-To: <20240817142022.68411-2-thorsten.blum@toblux.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|IA3PR13MB6885:EE_
x-ms-office365-filtering-correlation-id: f8ab22a1-de96-48e0-333d-08dcbefccf35
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MkhEUnA3dkZqSzBEVUFMYWRYV2QrVnBkME1rQ1h3d1NFMFZ0aEhDZTJheWcw?=
 =?utf-8?B?bGlYb2R2cGVwaWtqb0lZbk1MM0R2YTY3YnIrQ1pvTzY1SFZJcm1LT3BpaE85?=
 =?utf-8?B?dEwvVmRFVVZnN3c2Vk8wWDN2aGpHR0p1WTBTS3FyRkNSS2hwUzRhaDRlcW93?=
 =?utf-8?B?azhmdGQxZWhUb2pEVU0ydi9mZHNGeG1CTno2eXJmWXRrZEhxRDNXM00zdmRs?=
 =?utf-8?B?cWFIdFUzZE9NUW0yN2tCaTg2Q3B0eWgyZm5zM1VWU2o5dHNoN2VCeGdVYXln?=
 =?utf-8?B?S1pjMXBTb29Ca3hKZzYzVXpxRTQzVkNXZENxaTVxK013OE95NXBKOENoMWNZ?=
 =?utf-8?B?K1VCZmE3KzdPR1dTWCs3SFRjOUJnOERScW1seDFGdGg1UjNORUgrQ2xHWnF4?=
 =?utf-8?B?SHlPa1gwNk5OQmFwRG12RjI1UEFxVXZlVE9WK2k2L2NvbHFuVkppSElMWThn?=
 =?utf-8?B?akVzcWJ3aWlacmluOFlJL2hIMXVGdUFXUUVhRHJ6YUlRbmNzUUYxQ3plU1hK?=
 =?utf-8?B?Q2pKUHZnbVJYYVJQMk9pUlRnMlN0Y3AxVSs2VUpQcUFMRGxJT1UrUlVGOTBV?=
 =?utf-8?B?ZDl1emV1a3Q3V3dqVjBoMEdyYTdhZmUxWkZKYnFOelgwK1hZbXVHRVBlYW95?=
 =?utf-8?B?aGRIbjA5YmlIRFJIQzR4TFlidTlUUDdtQ3E4eklUM2w0R0pJZEpnc2huK05J?=
 =?utf-8?B?SVg2eGJ6YjhjNXJYNktoaDNkM0ZNUnlrUUkwdnNvK3pDV1V3NHhsZHlSMG9h?=
 =?utf-8?B?Mytyd0pjWHBmK01uZjFWOEtjNzFOWDA3R0xMSktBck1RSEhJY3NhdTdNeTZj?=
 =?utf-8?B?S3h0cVZrQ1JxWGFKbU1EY2d0T1NySGRjY1dBa1FOU3JCZU1iekk4UmZVNDdv?=
 =?utf-8?B?TmRSUy83M3FzVEI5UUdLNVhKamxoT0srRHNwRmVnaGpFOTBmdkR0WDk2aEtZ?=
 =?utf-8?B?QWJYZWV2OC9ja0E2NGNhTjkyaE4vNUloVDRJRE9td0lMUndTOW1hTHkzamE2?=
 =?utf-8?B?VFU0YWMvT2dKYWxmNTBjeEhSVnBMVlI0ZW1wOWFMRHh5QXlzcythY1dtTEFn?=
 =?utf-8?B?SEpHZWZoZzN4UlpUdWtmNWdERjB6dWJUMHM0UHlvMmQvalJqSmZJVGh4Yk05?=
 =?utf-8?B?NFNlR09MeTIvdFhYSkVuWXZjaHEwM0tpUmh3T0RPWmg1N3A4bFQrQy9RdDJM?=
 =?utf-8?B?ODJ5ZEV4VTNUcVcvZ1J4dHIybFJrckNjc1RkVXJ3MXgrZXlBdEVoc1ZOMmxs?=
 =?utf-8?B?NmFTUWFTZFRRclNKYWY5U2Zudjd6R3ZLeDF1UTR3REhSNS9RZlhNLy9sTFls?=
 =?utf-8?B?eXV5aVFIQXdmMkxmT0Z5Z2F0RWhZYUZXWTQwQU1hTzI4cS9ISUpuaXhYTkJP?=
 =?utf-8?B?YmMwNHF5dUdKdmdlMWhFSXBGQm1DWGZiZG1Fc2NxdVRvb3Q0b0pyRk5ISXR6?=
 =?utf-8?B?bGdpcFp6dm5tV1NrRzdSQnZORi9GUFh0WGlvZkxMcnkzV1MvNjV2ak1vNGEv?=
 =?utf-8?B?NmViaUFrZ3FxaFRILzRnUUVzNDFwSE5jSDJuamowWDFHRytCMlNLaGpsNUgw?=
 =?utf-8?B?cGY5UzdMcnNUL0NUYUdwOXBWbi8wRVZRclUvanExaU51UEdETXlPSHN2bVJU?=
 =?utf-8?B?TGxUT21aUXR5dmFjZ0hUaEpLMk1aUm1qQkhPT1lidXZOUi96TmVZNmlYeVZw?=
 =?utf-8?B?Z2JwSmxRNVUzUU5TcENEdEtjamZZVVhlTHpNRTFVNkQ1ZjVYcEY1OU5mRHdP?=
 =?utf-8?B?UG5uTk5MUE4xR24yRUpGUm9DQS9tdkRnc21WU2xjdEI4WTBVZ0t0cHRmUkxM?=
 =?utf-8?Q?PTiNk2UEm8FJUukqobq5XCXofrYB7aLyRQnrY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R2ozN0NPdjBnQ1dZQk5sejV5SkVwczFuWjZQaXVnWGg0Uk4xTEdNN1VCZy9l?=
 =?utf-8?B?ZmRnY2I2Y1p2VC84Y3ZVRlQvQWZGM1dFM2VTejllSW5LM0JsVXU3YzVCZnQ1?=
 =?utf-8?B?THVmOFlBZGNQWkRCNWNHelNkc0dNZUNyTEhvM050cVJNUGVEbjF2MW5hblpj?=
 =?utf-8?B?VUpxNUg1K2FMWGFsQlVueFJ1MkF3bkFKeFY4VlEzM1MvenVmZnJqaFJ1VEpt?=
 =?utf-8?B?cEN5dGp1dHU3Nk9pRHJvUjVPWUorLzc5bEp0eGI1TUgrV29KaVZBbnNFeU5s?=
 =?utf-8?B?VXZTSFpxUk9sZTRINnF2REFyaW0vYnJ5QmhwV0Y1em5KT2dqUWM4aTk0alBN?=
 =?utf-8?B?MndoQitKaFdNWWJNUmRUYlgzQkVxdERWRi9ES2thVlIvTlIwOERrU21GZlZM?=
 =?utf-8?B?ckdBbEM3dVVseWZaSkRkMXlxSTIzek83SEgyNXZHNGNVM1dYMXRHOXdMZTl4?=
 =?utf-8?B?V0NtaGl2VDFFZHdUQTRkVUpwL0E2QkZ3V2pZNmh5KzJRb21pSUJMbStIdmc1?=
 =?utf-8?B?c2Uvb1FBOWtSMHRqeVpNTHJ5Y0ZCTDNiUk1namZqckFFWU5Wc2o0a1lGcU4z?=
 =?utf-8?B?MGVLcUhOTkZnTEdNYStEL3RERlNPcWI3b3FCRWloYVdEVUxYZjM0UU9GTWdi?=
 =?utf-8?B?YnAzekZTM1pjUE1FM3dpaVhUSk5kelB0R0ZvRGdIOXBFVyt2M3cwd21NUUF4?=
 =?utf-8?B?czhKRWFZejI5M3B6USs4L29Ed2FhZkwwSWkyY2pJTUtuQVM3NWdiL095dzdR?=
 =?utf-8?B?VXZLQ1J5eUpaTVE4WlAyQWxXN0dYN1U4K3U4c2dCQ0F1a3ZxVDRCMExReDV3?=
 =?utf-8?B?MjNSbU9tT1hYaHlyNnFFWmE3cG1YYVlFc25ORmtPdmdTWGtLNVZvbGVkZU1N?=
 =?utf-8?B?Z25JTGNMbTM3eFJTN1NKYlhzUXV4cUlDVWJhWDNKaEkxVVZFaVNrQkJqdW9X?=
 =?utf-8?B?ZnN3enk3RU1tbUJhTG5JWmd2aE56V3p2V1RYWUlleTZ2QkRSdlZ4YVBkS04x?=
 =?utf-8?B?OVpZNzl1YUVtbm5qZFhkc2JiT2JIaVhpejB5dlZjQTVmWmlRbi9rVzhsUFVK?=
 =?utf-8?B?V2tVZThpYXE0OGFaTWRaVkZJRTExRCtRdXoxbnhPWmh6aXNaUTI0MmRtZ2g5?=
 =?utf-8?B?NnVxVGpOV2NId2UzSi9ETU1waFBkRXlNUlFXVE95M2hiYmRPWDVZMDNjZzZL?=
 =?utf-8?B?TXVsdVZqWW10R3RFeVdVWUJzNDZWTXRHSHVYWlVNQlFBYk10SDhldzdaZHdD?=
 =?utf-8?B?L0F5c3ZjVmVMTU5Yc3BISGRSWE1ZZ051bmlDOWtxYjBGb2JUOEZueVFpOTRN?=
 =?utf-8?B?TDRSYnl0L1oxRUIzN0J0UWk1U1lJMXBNUjlORlRoR21JcE5KUnFDckVEdVBQ?=
 =?utf-8?B?dUZIT3ZZajBWYzBLSDFCK04wMVdmeFAvYURjcU1ZS2hMTFdpSW5UTWoxVzJE?=
 =?utf-8?B?cis2UHdBOTVpWWpuczNzQmpxUkRxRFcyK2JabG43K1BhWDc1dmdiU09FSkpm?=
 =?utf-8?B?RmIrblQwazhuTis3SHV2bWZlOTlnRVF4T3IyQkpwQnVoWHRQbHAvYXdpTFQ2?=
 =?utf-8?B?WlVPL0NkRy9INVNHL0ZyOC9pYm5NTk9paGtvSEt0TCs1R0N2WGtXOFFsaCt0?=
 =?utf-8?B?WjNxOEtscXhOMEE3b0dZU3lVdHVuQVc2VHJZbkNqOTIwSkdkYXhCbXF4K1FX?=
 =?utf-8?B?Rkw3Q05BSFh6UVdRTFBhM3FGbHBoWDN1eFFreUlVZVVvT1BLczdyL2lmTU1V?=
 =?utf-8?B?ZDQwOTcwbWt4cjBVNjlyVWNLd0g1TXJOYzJaS0dDcXBmU2hMRVVabms1TWNa?=
 =?utf-8?B?OHo2SGtMbmM5L3VldktWVHVkdm1jV2N3R2ZxMDNQS2hXV0RGd1pWOEx3Mjd0?=
 =?utf-8?B?U2xBRjdwYWFNbWxwWFhqUXJmeFRBclk1NUp0VUJlWHJ0UllDRU9MSmM4dnRw?=
 =?utf-8?B?aFlSYW82TlFNWGVuSzBUWkpianVCNjRuNFdJeEFiWmV5QWMxcWxLdUM2bWJm?=
 =?utf-8?B?RmY4N0M4YUNIY0VPMjJPQnk3eS9BL2ZxZzY0RHIwSjR1bDFmNXp3MjdCUEIv?=
 =?utf-8?B?OTM4TUladVd5c2hkWk01V2FOZ0o4WTdKVXhvcE1paWNNZ3NvRjZLUElBMXhK?=
 =?utf-8?B?Ym1WYUZ2VDAyVzNlNFVlL2x2SllYaW0wdy9iQ00zOXdZQ1ErdXRINWlKaDdD?=
 =?utf-8?B?NGZjQU9tdGp1VVVoRXljWkdLbDFYeUVoaWVRb0NNN0lYMW1yRGtSU0hMVHoy?=
 =?utf-8?B?OUJFcEVtQzkxMHo1VnR1Si92c1JnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A414DA26BD826459A686E43AABB2DBD@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ab22a1-de96-48e0-333d-08dcbefccf35
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2024 20:40:19.7141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hyRn8L8akEjJuGmkospbvKn518cU8gNa0+o/FBY5kAhqlRVPpkRoDXIFB7ni69YwwhzruPrZabcMT2w2f7PxGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR13MB6885

T24gU2F0LCAyMDI0LTA4LTE3IGF0IDE2OjIwICswMjAwLCBUaG9yc3RlbiBCbHVtIHdyb3RlOg0K
PiBSZXBsYWNlIHRoZSBkZXByZWNhdGVkIG9uZS1lbGVtZW50IGFycmF5IHdpdGggYSBtb2Rlcm4g
ZmxleGlibGUtYXJyYXkNCj4gbWVtYmVyIGluIHRoZSBzdHJ1Y3QgbmZzNF9mbGV4ZmlsZV9sYXlv
dXRyZXR1cm5fYXJncy4NCj4gDQo+IEFkanVzdCB0aGUgc3RydWN0IHNpemUgYWNjb3JkaW5nbHku
DQo+IA0KPiBUaGVyZSBhcmUgbm8gYmluYXJ5IGRpZmZlcmVuY2VzIGFmdGVyIHRoaXMgY29udmVy
c2lvbi4NCj4gDQo+IExpbms6IGh0dHBzOi8vZ2l0aHViLmNvbS9LU1BQL2xpbnV4L2lzc3Vlcy83
OQ0KPiBTaWduZWQtb2ZmLWJ5OiBUaG9yc3RlbiBCbHVtIDx0aG9yc3Rlbi5ibHVtQHRvYmx1eC5j
b20+DQo+IC0tLQ0KPiDCoGZzL25mcy9mbGV4ZmlsZWxheW91dC9mbGV4ZmlsZWxheW91dC5jIHwg
MiArLQ0KPiDCoGZzL25mcy9mbGV4ZmlsZWxheW91dC9mbGV4ZmlsZWxheW91dC5oIHwgMiArLQ0K
PiDCoDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2ZzL25mcy9mbGV4ZmlsZWxheW91dC9mbGV4ZmlsZWxheW91dC5jDQo+
IGIvZnMvbmZzL2ZsZXhmaWxlbGF5b3V0L2ZsZXhmaWxlbGF5b3V0LmMNCj4gaW5kZXggMzliYTlm
NDIwOGFhLi5mYzY5OGZhOWFhZWEgMTAwNjQ0DQo+IC0tLSBhL2ZzL25mcy9mbGV4ZmlsZWxheW91
dC9mbGV4ZmlsZWxheW91dC5jDQo+ICsrKyBiL2ZzL25mcy9mbGV4ZmlsZWxheW91dC9mbGV4Zmls
ZWxheW91dC5jDQo+IEBAIC0yMjI0LDcgKzIyMjQsNyBAQCBmZl9sYXlvdXRfcHJlcGFyZV9sYXlv
dXRyZXR1cm4oc3RydWN0DQo+IG5mczRfbGF5b3V0cmV0dXJuX2FyZ3MgKmFyZ3MpDQo+IMKgCXN0
cnVjdCBuZnM0X2ZsZXhmaWxlX2xheW91dHJldHVybl9hcmdzICpmZl9hcmdzOw0KPiDCoAlzdHJ1
Y3QgbmZzNF9mbGV4ZmlsZV9sYXlvdXQgKmZmX2xheW91dCA9DQo+IEZGX0xBWU9VVF9GUk9NX0hE
UihhcmdzLT5sYXlvdXQpOw0KPiDCoA0KPiAtCWZmX2FyZ3MgPSBrbWFsbG9jKHNpemVvZigqZmZf
YXJncyksIG5mc19pb19nZnBfbWFzaygpKTsNCj4gKwlmZl9hcmdzID0ga21hbGxvYyhzdHJ1Y3Rf
c2l6ZShmZl9hcmdzLCBwYWdlcywgMSksDQo+IG5mc19pb19nZnBfbWFzaygpKTsNCj4gwqAJaWYg
KCFmZl9hcmdzKQ0KPiDCoAkJZ290byBvdXRfbm9tZW07DQo+IMKgCWZmX2FyZ3MtPnBhZ2VzWzBd
ID0gYWxsb2NfcGFnZShuZnNfaW9fZ2ZwX21hc2soKSk7DQo+IGRpZmYgLS1naXQgYS9mcy9uZnMv
ZmxleGZpbGVsYXlvdXQvZmxleGZpbGVsYXlvdXQuaA0KPiBiL2ZzL25mcy9mbGV4ZmlsZWxheW91
dC9mbGV4ZmlsZWxheW91dC5oDQo+IGluZGV4IGY4NGIzZmIwZGRkZC4uYTI2OTc1M2Y5YTQ2IDEw
MDY0NA0KPiAtLS0gYS9mcy9uZnMvZmxleGZpbGVsYXlvdXQvZmxleGZpbGVsYXlvdXQuaA0KPiAr
KysgYi9mcy9uZnMvZmxleGZpbGVsYXlvdXQvZmxleGZpbGVsYXlvdXQuaA0KPiBAQCAtMTE1LDcg
KzExNSw3IEBAIHN0cnVjdCBuZnM0X2ZsZXhmaWxlX2xheW91dHJldHVybl9hcmdzIHsNCj4gwqAJ
c3RydWN0IG5mczQyX2xheW91dHN0YXRfZGV2aW5mbw0KPiBkZXZpbmZvW0ZGX0xBWU9VVFNUQVRT
X01BWERFVl07DQo+IMKgCXVuc2lnbmVkIGludCBudW1fZXJyb3JzOw0KPiDCoAl1bnNpZ25lZCBp
bnQgbnVtX2RldjsNCj4gLQlzdHJ1Y3QgcGFnZSAqcGFnZXNbMV07DQo+ICsJc3RydWN0IHBhZ2Ug
KnBhZ2VzW107DQo+IMKgfTsNCj4gwqANCj4gwqBzdGF0aWMgaW5saW5lIHN0cnVjdCBuZnM0X2Zs
ZXhmaWxlX2xheW91dCAqDQoNCk5BQ0suIFRoZXJlIGlzIG5vIGFkdmFudGFnZSB0byB1c2luZyBh
IGZsZXhpYmxlIGFycmF5IGhlcmUuIEluZGVlZCwNCnlvdSdyZSByZXBsYWNpbmcgc29tZXRoaW5n
IHRoYXQgaXMgY29ycmVjdGx5IGRpbWVuc2lvbmVkICh3ZSBvbmx5IGV2ZXINCnVzZSAxIHBhZ2Up
LCBhbmQgdGhhdCBjYW4gYmUgZWFzaWx5IGJvdW5kcyBjaGVja2VkIGJ5IHRoZSBjb21waWxlciB3
aXRoDQpzb21ldGhpbmcgdGhhdCBoYXMgbmVpdGhlciBwcm9wZXJ0eS4NCg0KLS0gDQpUcm9uZCBN
eWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25k
Lm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

