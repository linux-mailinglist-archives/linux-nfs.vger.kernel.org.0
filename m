Return-Path: <linux-nfs+bounces-3183-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDC58BD69C
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2024 23:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 728051C20E1D
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2024 21:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33871586D2;
	Mon,  6 May 2024 21:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="VIfA8W6n"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2116.outbound.protection.outlook.com [40.107.212.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5080EBB
	for <linux-nfs@vger.kernel.org>; Mon,  6 May 2024 21:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715029541; cv=fail; b=XXu3eINo0az09YeNrlNJDeR/auqwBpTds14n6VoZetzorCMgi6zjPdkrxf/n0mN3giyxUB2jiVxnBBr85ImIuR9Fr/7fqqesTtfZeaV5MRVQy5pph7ucU5V6YujtiLx63ktZQDHKs6IuQFPRKKgX2wkwKBzSWvSJZdt+QjVSLlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715029541; c=relaxed/simple;
	bh=CJijyaLSwyMKbvP8vAkCIHoDn6Qmkhl49p9yPq6ZIdY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N7H1jZ7AGbUNTgbxOmLUNN2PD5aRXxh/co4ro80CH29w7clrXlnuq35MILElgPB6VQiIiuE1YdjJxn213p6hiUowYi2L4L4+SFzXnhQU21p+HREUrzT0/ASikn+G1iIOAH/1lBBU6khst5ZrBmmeEKe9FnFqqmmR1PmmHSbyMKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=VIfA8W6n; arc=fail smtp.client-ip=40.107.212.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9rA9F9jHT1oeM+f4MSon5Wug9AhkqOurRnazqCVGQjVE1Ohn735VOhaDvVVZNi8rmebReSoea+6P57VsXnYUiXcSMOskj4lsqD9g4WoyWijo9Z+EhP78cnaphB2HxEx/AFzi22STyPbM8Oqjh0XyZDm7fa/PbmObdSxvjx2aj+aVQEKJSZSL/+71EQSJa2Oh9Fo1eFeqJozmhYUmEezzRX3uU/lUFqqDnHZkXD9wNg+kgL2ayG2BzRhBNoNebS/tR0CqIjLitUli6DnRNiRDW7g9RNui/YzJLSSKGKeerR2lgdBNg/llVtl9dgoODICSN7327C+WZI4e/pDAvXdRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJijyaLSwyMKbvP8vAkCIHoDn6Qmkhl49p9yPq6ZIdY=;
 b=TYZOJTxMXXTsQmVkNfNPjSIwozC2ChSBLn4lxL/5WDhkoeEK9bFlIfruqtMve9A2w3hpXsKPaxXn2Z9OlOPL/BKqU2qGnjRYylNRo1xLt3HvkpMkm4UP8UR8ARtJX5ld5tABzNE9NPIcU/I6cjuNP2+xwtl8K16fF58VjUFfG/4wiDN+zQW1X2Ou8qTdngheMlwtrh77GKf7XpPOM8wYb+5On87qft7frcR/ZeTkDWqi97euD8Folmsjg4QchiLNceaCEgWCJlGz14L+JxRDqfuYoUFM+s4+u1EaoCzuRJjBC2CnEeA2ktUD9SD3MJjAY6nd9LbnynGUr+YRsMYoIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJijyaLSwyMKbvP8vAkCIHoDn6Qmkhl49p9yPq6ZIdY=;
 b=VIfA8W6n2HjhSWC4G0dCWXMo1u2AwGmP3sNq09TUcteUZitA8dtjORhg9o3mpKm4ea3HD/qyhtt/Idw92cVxvWwCdF8ix5ox6j9mQGCGJ/jK82VvnqdWZj7l9wMWivmuFn+UX6uBSVx97pW/dhinVojUrsYeSgwmB7ooKsgmeCI=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SA0PR13MB6002.namprd13.prod.outlook.com (2603:10b6:806:152::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 21:05:34 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5bb5:501a:fb40:5057]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5bb5:501a:fb40:5057%6]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 21:05:34 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "cel@kernel.org" <cel@kernel.org>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>
CC: "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH] SUNRPC: Fix gss_free_in_token_pages()
Thread-Topic: [PATCH] SUNRPC: Fix gss_free_in_token_pages()
Thread-Index: AQHan/dlHot7CT3FAke4iNGEwqVtX7GKslWA
Date: Mon, 6 May 2024 21:05:34 +0000
Message-ID: <528891aeeb2686245cf9665d38c760f4627165fd.camel@hammerspace.com>
References: <20240506205245.4455-1-cel@kernel.org>
In-Reply-To: <20240506205245.4455-1-cel@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SA0PR13MB6002:EE_
x-ms-office365-filtering-correlation-id: f6a2bf5a-225c-4d22-d5cb-08dc6e104597
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?SE1KWWVLcFRSN3JiL0FBR0prYTBIQnBMNkxUdTZwTFBmUW5LOFdEbXJ0M2pJ?=
 =?utf-8?B?empJaWtwaUd5NjcrVTJDbGMwUzQwK0lYYTdWdjcyZHI5Z3MrYmY1V2ZEVGJR?=
 =?utf-8?B?eEh3d2RqcGgyNkF0U3dUeHM3dk5TbnpncG5ScU94M01qUXpZZmJxbEFIcHNk?=
 =?utf-8?B?TFhCY0ViM3pCNlROOXJWNnhMOFhQWlZjTzBBWmxzRkU1aE5YdHFkdk9FN3NX?=
 =?utf-8?B?dW5WS1hFNWczYW1EMUlsSDczQUJ6THliQnY3dUN2UXh0UWdhZysxMndHaUkz?=
 =?utf-8?B?OU0zY2NlZWhlM3RmT09lVDQzRm1lbVFXMmdqdllsT0RqSXpRWWV1YUFCbXV0?=
 =?utf-8?B?WFIxeC8wc0c1OTM2Tm11eCt2WjZ5WnVVckdmRStSczVabldvcElYTEF1Vm1N?=
 =?utf-8?B?SFo1VEU1eHZlbGdEMmI2NVZjZDNqcWdPWnlQa2M5YjZQdTRTVW9idVNpUkll?=
 =?utf-8?B?SEMwY0NuSlQzY1FtWW1mdDV0MzZDQS9COGU2OS96dlppVTAwMjVjRWI5c1NV?=
 =?utf-8?B?Qm1DQm40a2ZaS0JiWUYxVDQ2K2J5SVArOUdnUmtJeWlxeUlOeXhRWERsVW44?=
 =?utf-8?B?VnRvWGppbDMxOG5vQkl6ZjNHeUpGWjgyNmlWckI4bURwV0JYUVRaYnB1OUox?=
 =?utf-8?B?MXlKNkM3Q1F0RFRGYkdWNW5xaURvRWlKczhtQVRiV1JwMlBjQy9jWlhCMk9r?=
 =?utf-8?B?dW9mS3JPQVFncVIrY1JtTE01dFVSUXVSRlRJQiswRHVLNURUVWY2SmNORWhs?=
 =?utf-8?B?Yk93dVFTM3l4TFdoQzZLY05BeDFqeTl2WmFiUmtTTmM0bUY5YXgzSWlWOUM3?=
 =?utf-8?B?QlA4TWNjcVN0ZytnZFlwelVvdXpiSWxGaTBWdk5oODB0UnBFSG5LSHp3cGNw?=
 =?utf-8?B?NDE3OFR5SzRnQlNxVmJFaG8yWnNwRU5WRExxMGlJRGpBeE8yRUN1K3FhandS?=
 =?utf-8?B?bVZod0lwMkVrUjU4cFhYdlVCVGdKUzdaNGRwTExLL1BXTWRkYTdueEJOVFNt?=
 =?utf-8?B?azRqbWhyUWRrQ3ZIVERadFdPMHFTcXFmb3g4N0lNUS82WkZFUmczV1FzenpZ?=
 =?utf-8?B?MWFOUHR0N1JGZ25yQjd0bjl6WnVBTVhFSFAxZ0drekhOTWFzMmVsZzV2VTBy?=
 =?utf-8?B?ZjhMdmhMRzlXTi9Fc2pLeVJ6bEJGMThFSzRmdTMrcm9odDFZN2hPYXhzL1NC?=
 =?utf-8?B?bTB4dUd0QU5jT210UzJmRGVqajJETVI1ZmJ4ZWVPYmdhd0psN0wzMWI2b3hz?=
 =?utf-8?B?aXRaMmE3SDVWSXduWFlud3liRE5zU1A4bmFmMXFYeWVnOUx2eDBweWhkNkd4?=
 =?utf-8?B?L0Vza3RaclVpb0kwV3pvQlF4ODIreGxUMVRQd3RDOVJWUE8yK3ZKUk1Bb3M5?=
 =?utf-8?B?RVh5QU1IS01lVERVN0NFOUVYaTVMNXBxZFBKQllHVWRKa0VLRU4rOWw1NjNK?=
 =?utf-8?B?NldtZitNYUtwT2tpUVY1UGd5eGxCUjhuRkRHNTg3ekVmOWpUVGduemhXWS9i?=
 =?utf-8?B?M2RDRjV4L0hUbkdEZzBBNmZGVE1QNUtGTi9xR2VudDByV2l4WXAvZW9SM3BY?=
 =?utf-8?B?cVVJUGJEcGV3WHRJOU9qQTFFa3lmYkhuVTFEZmsyQVZCL2s3bUU4WEloL0Er?=
 =?utf-8?B?QVlaT3h3NlFBcUEyUVdLM0R3U2pxaUpURWRWdlFmVE5McENOVG4ycWxaelh6?=
 =?utf-8?B?a3JzNFRJc2FTZTExR3A3am1EWGxaMUFQU29rODBEOXhKMi9pTGdQYm1jcnJZ?=
 =?utf-8?B?eW9IYjhKemFrbmM4UjRMdDY3MUtqTko3NTlieHRxMGRUcm1DMExVa3hDRi9Q?=
 =?utf-8?B?UURXZG9NZDgxUjNBL3NJQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q0Z0bkQxSURVUEE0cHZQSGFaQVcvckdaZlF0Yk9TNENYcU1sS1Q1YzVwc2dT?=
 =?utf-8?B?dXVhRDdoL1h0SG85VDFxWVRRWnlwaW5rY1djT202N0NuMGd5Yld5eFpZSWZr?=
 =?utf-8?B?TE1EWi9rYklrSzZLeVlZbVErWHRrbUdkRlBpNEpKb3hsWm1SOXFMa0s5UWEx?=
 =?utf-8?B?SkFXU3RqWTY2ZWFGbEFlSHUxMWNEUGVLK1l6UXZSRlEydU9VcitzUnllRUM2?=
 =?utf-8?B?TW9GdEtJdWFxZjlkZTAvMHJZUnZOaThRdzEzT2V1WTJHajVnNW1tYU4rM0lk?=
 =?utf-8?B?eUxjMEF2SXByZ3RqMkdudlA3bU51QjJ1YVVuSE1WTytxazFqQ3ZZQldqenlI?=
 =?utf-8?B?dmFCQmtWSnhscXFKOUh1YURyNDFRU2FKdWUraHp3QldSNUs0czFtcGlMaitB?=
 =?utf-8?B?NlFUYzVQSG1ZLzcvU3BQNkczWFRwZmZINmZZNkFDa2F6U3pwc3F3aXFYM2g0?=
 =?utf-8?B?a0M5TW9qeWtySGpIUlQ4S29ZM2ZEZUF2VS8yNS9jOEs0dEhnT2gxeDRaRjQ5?=
 =?utf-8?B?VnlXb1NRcHNaSHcydHN4YW52REZrVC9hbmE1MnoxekNTa2xDcVdKby9BSjU1?=
 =?utf-8?B?MERHellJWFJGdVdZTlA4MUNxY0NINHdYSmNDWGl5TVpjbEh4a0dmY2c3QXNa?=
 =?utf-8?B?aktwbSt3VG84ZU1LcHFTTklzdG83MHpySlhoKzBlU3NNckU4a2lnSG91SXdu?=
 =?utf-8?B?Z2RGb1BJSFhzOXN2TGFiQ2xUWWRYZGh6VnVBTGtDZHNMV015aXJIVTFFT0tI?=
 =?utf-8?B?QmFzZUl2aFprbEVndUZlTHpEVUZXQ3l2OUEwdWJ6TDd2Y29YUVc0OS9kYkVs?=
 =?utf-8?B?bnFVbEVqZ0k1Z3NzZUtHeUM1QlRFWUswa1VRYU5lTGpoaDVDR3U1VlZvL1NX?=
 =?utf-8?B?b3BMK2syaUVSTlFSRFZ6SDBBOXFzUU0weFBSTE1YUkhpc0xSdFdkZHJEZ2hM?=
 =?utf-8?B?djB0blpOaEkrRzFYeUFyNmFFSjR1MUtkT3ZTY0NJUVNUNlRJVitvbmk1cFV1?=
 =?utf-8?B?eXNBSXR3V3JvNEladkJrTHQyWWtqMWs1eFI2LzRhS2YzR3VnUjlINDI0TjM3?=
 =?utf-8?B?Ym9qYmM5R3dwMyt2NUpmdTdJd0o1SlhmelhmNi8reVhiNzBYckFoY3dpa1Ur?=
 =?utf-8?B?SjY0M1pzM0h6L1NabUtsUGppUWoxelpYKy9RdEp5U0tIWkxqNFg5Ym5jdXFi?=
 =?utf-8?B?VXF3NUlTeFhkOTIrNTRBWUM5cHQ4NG4veEFGV3gwcHZibVI5Si9yQ0xUdTV4?=
 =?utf-8?B?V3ZJKzR5OXNISmx2WTFaWm9jT2RDbGMyRk9FSFpORjFrMWQ3OU5EZXNMNUpZ?=
 =?utf-8?B?QWdXQWgzczQ4ZjVodjZ4dWNRRzNBb1o5cW1scU5NTW5yeFRLNlk1NHRzUGs4?=
 =?utf-8?B?MjJOWllFaVY4dVlKVnYvbTJaTlN5Vk1WdkhWUWllUUwrWDlleDBhUERHTnJE?=
 =?utf-8?B?d1lOQTVEU2NSQURuODNxUlF2OEEzOWdSVDE5S3pCclplVGx4SkM0b1lSQmZp?=
 =?utf-8?B?ZElyK0IzSVd4bVFQbmNEUUNUdXZ2aUhvVXBSRjFjRE9NbmN5eGpvcmZXSDNS?=
 =?utf-8?B?cDNVVElvdVFlcnM4WXNkVTlnQUY2bVdqMjdFR1JoRWJzTGxKMmc4Y2c4dm9N?=
 =?utf-8?B?L1k4U25zUllMN0FRbEpXT0VwWmdXTzgzcitzWWFOS1pzUXpKclllWW9LOGEw?=
 =?utf-8?B?c2ZSN3FEMzBjU1hGQk5jSllPRkNPZnZJSk1DUzRrZnpCZkcvMzAzZFBLSDRR?=
 =?utf-8?B?WS8vSUV1Ti9ON1EvakVJQjhYRjNwQUpyek5JWC96VE50WnZiY0p1OXJaK09V?=
 =?utf-8?B?REROdlZzaXR6R2NCV3RRbVhqc2hOdHAxSlY2UE02UzJTNjg3MVg1a0JuVHBr?=
 =?utf-8?B?aGZMWDJkS3JnSVZLUjc3OGhtMVhFdVVMTVVmZjI2Sk0vRHVaSE9mU2JBU2tH?=
 =?utf-8?B?VFZjQnpYVXF6S0ZhRklyVS8xVzhOSFpPcTcxUUQ5WFhlSkNTai9CNVZtYzd4?=
 =?utf-8?B?WWRlU2ljdjFROFhsNEJUQmN4ZVdscG9lUEI3QzJMeGN3Si9YMXNWVjVtM0sx?=
 =?utf-8?B?NndPQ3RyeTluOEVXUVZWYk9zYmVrTHlsd3RraUFnbzN6ZWV0L0VXV09nMnZw?=
 =?utf-8?B?MEYyNHIzVHoyaGFXWDUybWJzZElNazdBWTRWUjV0Z1JSUDRNbmd3Q0pZRjVa?=
 =?utf-8?B?bnNmOWVVbEVjNThCczkrVzR3QzY2dzZlQ0hQTmFudTFQN21CWnZLM01wQytU?=
 =?utf-8?B?MU9HSEhwNnowRjFITXZuTU9hK25BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A7958B271F8C643814FAF3064C5A031@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a2bf5a-225c-4d22-d5cb-08dc6e104597
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2024 21:05:34.5733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PHr4z8PPz8EkfaHGw52cvXgGtmIO8Jkg9wH3fRNGZg5k9Wl1ozO1APTS9LIREVyAVA+kRSBhkgNVyACb174/vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR13MB6002

T24gTW9uLCAyMDI0LTA1LTA2IGF0IDE2OjUyIC0wNDAwLCBjZWxAa2VybmVsLm9yZyB3cm90ZToK
PiBGcm9tOiBDaHVjayBMZXZlciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4KPiAKPiBDb21taXQg
NTg2NmVmYThjYmZiICgiU1VOUlBDOiBGaXggc3ZjYXV0aF9nc3NfcHJveHlfaW5pdCgpIikgZnJv
bSBPY3QKPiAyNCwgMjAxOSAobGludXgtbmV4dCksIGxlYWRzIHRvIHRoZSBmb2xsb3dpbmcgU21h
dGNoIHN0YXRpYyBjaGVja2VyCj4gd2FybmluZzoKPiAKPiAJbmV0L3N1bnJwYy9hdXRoX2dzcy9z
dmNhdXRoX2dzcy5jOjEwMzkKPiBnc3NfZnJlZV9pbl90b2tlbl9wYWdlcygpCj4gCXdhcm46IGl0
ZXJhdG9yICdpJyBub3QgaW5jcmVtZW50ZWQKPiAKPiBuZXQvc3VucnBjL2F1dGhfZ3NzL3N2Y2F1
dGhfZ3NzLmMKPiDCoMKgwqAgMTAzNCBzdGF0aWMgdm9pZCBnc3NfZnJlZV9pbl90b2tlbl9wYWdl
cyhzdHJ1Y3QgZ3NzcF9pbl90b2tlbgo+ICppbl90b2tlbikKPiDCoMKgwqAgMTAzNSB7Cj4gwqDC
oMKgIDEwMzbCoMKgwqDCoMKgwqDCoMKgIHUzMiBpbmxlbjsKPiDCoMKgwqAgMTAzN8KgwqDCoMKg
wqDCoMKgwqAgaW50IGk7Cj4gwqDCoMKgIDEwMzgKPiAtLT4gMTAzOcKgwqDCoMKgwqDCoMKgwqAg
aSA9IDA7Cj4gwqDCoMKgIDEwNDDCoMKgwqDCoMKgwqDCoMKgIGlubGVuID0gaW5fdG9rZW4tPnBh
Z2VfbGVuOwo+IMKgwqDCoCAxMDQxwqDCoMKgwqDCoMKgwqDCoCB3aGlsZSAoaW5sZW4pIHsKPiDC
oMKgwqAgMTA0MsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChpbl90b2tlbi0+
cGFnZXNbaV0pCj4gwqDCoMKgIDEwNDPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcHV0X3BhZ2UoaW5fdG9rZW4tPnBhZ2VzW2ldKTsKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF4KPiBUaGlzIHB1
dHMgcGFnZSB6ZXJvIG92ZXIgYW5kIG92ZXIuCj4gCj4gwqDCoMKgIDEwNDTCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBpbmxlbiAtPSBpbmxlbiA+IFBBR0VfU0laRSA/IFBBR0VfU0la
RSA6Cj4gaW5sZW47Cj4gwqDCoMKgIDEwNDXCoMKgwqDCoMKgwqDCoMKgIH0KPiDCoMKgwqAgMTA0
Ngo+IMKgwqDCoCAxMDQ3wqDCoMKgwqDCoMKgwqDCoCBrZnJlZShpbl90b2tlbi0+cGFnZXMpOwo+
IMKgwqDCoCAxMDQ4wqDCoMKgwqDCoMKgwqDCoCBpbl90b2tlbi0+cGFnZXMgPSBOVUxMOwo+IMKg
wqDCoCAxMDQ5IH0KPiAKPiBSZXBvcnRlZC1ieTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRl
ckBsaW5hcm8ub3JnPgo+IEZpeGVzOiA1ODY2ZWZhOGNiZmIgKCJTVU5SUEM6IEZpeCBzdmNhdXRo
X2dzc19wcm94eV9pbml0KCkiKQo+IFNpZ25lZC1vZmYtYnk6IENodWNrIExldmVyIDxjaHVjay5s
ZXZlckBvcmFjbGUuY29tPgo+IC0tLQo+IMKgbmV0L3N1bnJwYy9hdXRoX2dzcy9zdmNhdXRoX2dz
cy5jIHwgMiArLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pCj4gCj4gZGlmZiAtLWdpdCBhL25ldC9zdW5ycGMvYXV0aF9nc3Mvc3ZjYXV0aF9nc3MuYwo+
IGIvbmV0L3N1bnJwYy9hdXRoX2dzcy9zdmNhdXRoX2dzcy5jCj4gaW5kZXggMjRkZTk0MTg0NzAw
Li5iZGQ4MjczZDc0ZDMgMTAwNjQ0Cj4gLS0tIGEvbmV0L3N1bnJwYy9hdXRoX2dzcy9zdmNhdXRo
X2dzcy5jCj4gKysrIGIvbmV0L3N1bnJwYy9hdXRoX2dzcy9zdmNhdXRoX2dzcy5jCj4gQEAgLTEw
NDAsNyArMTA0MCw3IEBAIHN0YXRpYyB2b2lkIGdzc19mcmVlX2luX3Rva2VuX3BhZ2VzKHN0cnVj
dAo+IGdzc3BfaW5fdG9rZW4gKmluX3Rva2VuKQo+IMKgCWlubGVuID0gaW5fdG9rZW4tPnBhZ2Vf
bGVuOwo+IMKgCXdoaWxlIChpbmxlbikgewo+IMKgCQlpZiAoaW5fdG9rZW4tPnBhZ2VzW2ldKQo+
IC0JCQlwdXRfcGFnZShpbl90b2tlbi0+cGFnZXNbaV0pOwo+ICsJCQlwdXRfcGFnZShpbl90b2tl
bi0+cGFnZXNbaSsrXSk7CgpXb3VsZG4ndCBpdCBiZSBib3RoIG1vcmUgZWZmaWNpZW50IGFuZCB0
cmFuc3BhcmVudCBqdXN0IHRvIGJyZWFrIG91dCBvZgp0aGUgbG9vcCBvbmNlIHlvdSBoaXQgYSBO
VUxMIHBhZ2U/IFlvdSBhbHJlYWR5IGtub3cgdGhlIHJlbWFpbmRlciBvZgp0aGUgYXJyYXkgd2ls
bCBhbHNvIGJlIE5VTEwuCgo+IMKgCQlpbmxlbiAtPSBpbmxlbiA+IFBBR0VfU0laRSA/IFBBR0Vf
U0laRSA6IGlubGVuOwo+IMKgCX0KPiDCoAo+IAo+IGJhc2UtY29tbWl0OiA5MzljYjE0ZDUxYTE1
MGUzYzEyZWY3YThjZTBiYTA0Y2U2MTMxYmQyCgotLSAKVHJvbmQgTXlrbGVidXN0CkxpbnV4IE5G
UyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UKdHJvbmQubXlrbGVidXN0QGhhbW1lcnNw
YWNlLmNvbQoKCg==

