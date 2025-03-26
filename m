Return-Path: <linux-nfs+bounces-10904-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25305A7171E
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 14:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FF3818920EE
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 13:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098981E505;
	Wed, 26 Mar 2025 13:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="IeFqjavS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2097.outbound.protection.outlook.com [40.107.101.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D5C1DED5F
	for <linux-nfs@vger.kernel.org>; Wed, 26 Mar 2025 13:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742994609; cv=fail; b=JCv5F4CBMOFqg/jBxncNF4toT5hwv0w8skmP2BD3ROjuJw4cTBvL0PGNZ4Q+p4hx4pU1dwZDRDbbci4EkqSsPtJBYUmMAvR4MFwMAU8O/M58gyIWt87ZnUrMqNsT5r2PEhxEInSbJ6d6yojgVz4keG+gP0v+MlLLKK4m13GmZNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742994609; c=relaxed/simple;
	bh=BDeCggcLSBP5KwU1pfxvorywem5/EKdT0bQGGf6JcTw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hWKUPbussWzIGvWmhs4W3uDDRcZzZ1CYE9zeCW2+8GdcaGuJpD8sVZGbcM4SZ52WqbQyNjkt9c7vafM4dfGxhu/HjlrgSHa5BTn6NadCxGruz/YlpLsqK6u8ziMjLXQv5uJ7liq5ykujixHHMjFQZjZsl/ZOoD0OzIE1z9fCiDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=IeFqjavS; arc=fail smtp.client-ip=40.107.101.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrs1zO7GzQVRZdlD4nU7nv42i1JAJkhFmOWrGbcVbt1sVaqm9ztVzbMfx+HGbZMq1eORD1TcMcHikZ1j1Td9Vy4NbtVXHiqpCYPGK9O5QD4+NWuWAUUiQZyY8qdnDu+72M+qc39TUlMj1UsNCW9HQY8AUYyOL7Ol4bSq/C4OxEw/Xax0GUB0VhfGulQgbZzpqhagLqfMVCznWES+j7p6oCWgC7HVzzFYthDLqKaHyjUN/ORmGzL1bPDwmRBQ8AMRSR8F1xAV+77o6MNMo2zcS+y7RPBg09T6LqmCeva/9ObWXZb41X9Jp5DcWwGxAIE11wHIv1MTN5ZVWd94u+aYIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDeCggcLSBP5KwU1pfxvorywem5/EKdT0bQGGf6JcTw=;
 b=yKWedKsKWmCHd/4aO+K3wlMbaKgPclUN42/iuzYG1TbDEVh/wQCGH1/fxdTkObBf58fQc0Zvj03YImfbRP/SdzhCrKkh+ZBo2FMiirGueFeUfaDAqPgsFFnw8rm03CX28MZPjD+1Z15+/x2fqcU40CTRcJawztJaQZMVUczGpx1DgyxZ2hPNT+u0NrfOodm/7insbi/S+jusTq69kmVpQSYOa92vLJ2FRyNXYIbLJ9QbounrjIbvyzriy0xd3xq/wzvlgstsQaaQ3dxkbwm/Ae74OFOH9wfUChFS2DFr+srRFVjYX8IkzYj7pqyopES/vX8l9CkWvnpIgccPS1lUfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDeCggcLSBP5KwU1pfxvorywem5/EKdT0bQGGf6JcTw=;
 b=IeFqjavSW1z7NtSvHjQPyEE/2KdqJdJwO7by2k7HJ3hBCkysL3NYbHfcZc3rWkMcuLS1NBvpxuGwFvPPLtAdPUsEsmaeMyvzkQWa/wPzYdXIWSbrJrM9Xq8kwwhQK64Q/kFHHZHQ9o+9nKUtTH/rLVn7CBxTx2dwUl//DTNztVQ=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB5235.namprd13.prod.outlook.com (2603:10b6:610:fb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 13:10:02 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%3]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 13:10:02 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "jlayton@kernel.org" <jlayton@kernel.org>, "bcodding@redhat.com"
	<bcodding@redhat.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>
Subject: Re: [PATCH v3 6/6] NFSv4: Treat ENETUNREACH errors as fatal for state
 recovery
Thread-Topic: [PATCH v3 6/6] NFSv4: Treat ENETUNREACH errors as fatal for
 state recovery
Thread-Index: AQHbndZA7PGY3E3BuEuwu7+ym0cncbOFOyuAgAAK1YCAAB8VAA==
Date: Wed, 26 Mar 2025 13:10:02 +0000
Message-ID: <1b4fe6e8af344cc44b039b02ef0ce67702a91140.camel@hammerspace.com>
References: <cover.1742941932.git.trond.myklebust@hammerspace.com>
		 <ea44b46c7546579386d8d9e1a2b62c152534b6cc.1742941932.git.trond.myklebust@hammerspace.com>
		 <4E6693BA-38E4-4BC6-94E0-50E38446BE93@redhat.com>
	 <578359da41b13a0ca35879e61e8769b95546e480.camel@kernel.org>
In-Reply-To: <578359da41b13a0ca35879e61e8769b95546e480.camel@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|CH0PR13MB5235:EE_
x-ms-office365-filtering-correlation-id: 7db866e0-ce0d-4562-0396-08dd6c6784e6
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VHF0UFRxN25ZZ2xEL0NETnFEd2hIZTY3QWF5Q1Y3aGFYcXB4V1Y3aHVsc1Ex?=
 =?utf-8?B?aGNYM1hBeGIzVWhtaWlEajdoeStVcFRiQXEwdnVKNTJ1U213WER5Q3VveFVH?=
 =?utf-8?B?bmdIb2h3c2VTR0tSS2RxY1QvbjZROWJxZVQ5dnY1ZlFGMWhnLzh0YTlOOWVR?=
 =?utf-8?B?TlJGTGVyZDM5VnBWVURHcFVPSE5zS0ZvNHM2dGRGYU00V3p4WTh6MUpVTGdz?=
 =?utf-8?B?OUJuazlKTTgybkZiTHl1NGkwRzhoRFI1aitkS2hjTVVCTnVIWGhvbXVTaTRE?=
 =?utf-8?B?bGJzZHVNNDUyRFRycTJkNm4rOGp5cXlrUnBvVmtIWWxWU3NPOXhnU3cvWEc5?=
 =?utf-8?B?MXd3MkQxYXlZekw2TWJ6eUFySXJ6L04yWnlVYUNnUUlnRjhOYUNpK1VOYmh3?=
 =?utf-8?B?Y0wrMGdOeis4cVZFUmo5VkJpSWtKYmxPRURzYUs3RFlwblBLOTlZREQ2WkVp?=
 =?utf-8?B?VGVBWHIwZXRCcEU3cEUrL3pIRHlTU0k2RlE4czY1NUpVWW5KMEcwajZyL2Fi?=
 =?utf-8?B?TUoyc3lLYnNMckNvTm8rclBoRS90WFZTdVp4enJDWDQ4aUtKUnNBb04zUUMz?=
 =?utf-8?B?TVg3VThBSC9EVjFrRlhhczdqWUxDTEtjMDB4aUgzMDBZTW5aTytCcTR6M21J?=
 =?utf-8?B?VjdOd2w2MVdkT0J3WFU3L0FZdTVkYkpHQ3Zsam5sQnI0Y0FqK1EvWEE0c1dK?=
 =?utf-8?B?TzEycktxWStNamtGVTFxSDNOSGxablErY2ZYcmgxVEFQSWx6bDQvb0t5MUZ0?=
 =?utf-8?B?M0kreWxETHhDNXNONFdLYW1TYUExaUhJS1psNFNWOFdOdEVTbHYxUHV0TXZt?=
 =?utf-8?B?cGFKbHZpUWNqdytXZ1Azb3k2Uy9QMzd0NTRLdEg3TWg2UVpvazNlWmlwb001?=
 =?utf-8?B?OWhHR3VtMmNzRlJZRk1kdHAyazZsSzYzd2FXNFRDY04rekRkWUx2QWFzbGFk?=
 =?utf-8?B?TW4xWTZrejZEV2FNclBrZWUrSVcvc3NMSXBMQVViUVlSVkZKeS9hWFNJbWhu?=
 =?utf-8?B?SVA0bVFsWExpZHpPYkxjekFjTVgzdW9KK05WeE5QMjR5SFpLa0llSkpRSGNZ?=
 =?utf-8?B?eDhyU1VCZlVDNkFzaU5wUXBjZVlVUWFyVVgvN0tmdjY0bDU0Y1BvWE4vbzBp?=
 =?utf-8?B?aFJORk43NkJ4UG9GUEVKZVNTQXBNT0tPSjhKYWZnZms1T1Zjcy9iRnE2djRp?=
 =?utf-8?B?NEQ0YVJWRDMzVDl2SWZuRjdncjBWTnlUUGhHaFJMeUZBY3IyNkp6eWcyTkFi?=
 =?utf-8?B?OGlxdDRzZzhtOGJOUXdOdlUvaXErdldhYnJldnNJSTdFVldiS2Y1SnltTFBC?=
 =?utf-8?B?dHM3bmlDMVREbmluSFl3QWhrd3IyaGk3WnJFNmhhSk40NzdGUW5jN2s0bDZv?=
 =?utf-8?B?RHdoMmw1VXJjaVBFNXZCaUxSZ0x1VWdmcTE4emFNQ0xVZXVCaE9zQ25zdC91?=
 =?utf-8?B?Yk16MTZyanhxb1dSbUhQMy9QRWYxbVR5WTRNT1ZnekJ4cFlTdEVzYm9Dd2Zz?=
 =?utf-8?B?Zks3ano0M3hKNUpXTENFT0p2MkJkc3dZd1htbmV0TUpkaVFQUjlXN1N3MlFC?=
 =?utf-8?B?bjRiNVgwS3VDREtKT1V5UU5Mdkh0a2M0YXR6U2U5S2tLb1pXdCs0SkU5RkFE?=
 =?utf-8?B?ck4zUnYyRU9Sa015ZXBuNjAxNFc3cG1NemI4WG5JcURaY1BKTndFaTREby81?=
 =?utf-8?B?ZXZWOWJTVUd6QWtMSXVkTkhjeTdabTNTcStLS0FkMElRNk5IN3VDQUhiUW9x?=
 =?utf-8?B?QU9ST3NjT2dLVVZoUmtmZzZ0Z0F5ckliWWkxNUdrU1VKSGJ3RzhaWGNuRzBy?=
 =?utf-8?B?SlNLT1Z0SC9vSVlLcW1VdGdFY0s0b1dGN3NIb0RPaUQ5NU9hVWhXU296bU9E?=
 =?utf-8?B?bitrVTZvdFE2anRtSzRBOTdFcEVITDh4OXR3dlR5YkxWcHZEQUVacnM1aStn?=
 =?utf-8?B?Z0Q1Qmo0dWh5cnFXV0FZTEFKZlc2Tm5sUkV3UXNZTEp0OGxPYndDaVJ3V0VU?=
 =?utf-8?B?YUJya2ZtMmx3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Nk1pNDZuczdzUDIzQ1pndmk1UVkrcnBqZkVwQUNCZUEvTE1CSHdwS3JhZ0xE?=
 =?utf-8?B?U1FNUzVGemxCYkFYRzN0U2N0WmVzRXYxS2RZSjFiTEhmVk5GNXJrQ1h4WHMr?=
 =?utf-8?B?MVk0MnJpdWFndXdHMmxyb1ZJaXhFV0hMS0JCTGxtRU03Z2IyUVN0Vk16TEp1?=
 =?utf-8?B?czRlazZPZlRhN2JwRmpqMy9uWE8vZVJXdXZnOXFIa2w5VU9BVWo5TFBwVmZW?=
 =?utf-8?B?Tk1xeTE3bkNSdHJWTlVBWTRCcDBQR1AvU1JWRlF5SmszTGdJZmtiNkxXZ0c5?=
 =?utf-8?B?VjM1aXZmNTV3SzBjbE1jblNVUkx2TnBaaTUzeWwwaXNFalFtNEpRaFNUUXQ5?=
 =?utf-8?B?am5aeDIzc0ppK0lGSkVPN0dkUCsya2h6eklteURsc1dKMitVU0JIQU12dmZS?=
 =?utf-8?B?MXNoUy9rK1U4VERiWHJ3em5wWVRLdWNzaFdQN1I1Vy8zS1pNUFRQUVFwUE9W?=
 =?utf-8?B?Qm5kNEFWUHkySHFvM0NLWG5WZ1E4SnNNYXJSRUQwUFVwYjM2U0dUcWVVMENE?=
 =?utf-8?B?SGd0Rno0U2xCTm1ZRGV0N2dPQ0RTNnNrV1czdnNjOUZDRWpocXZYS1N5YUhE?=
 =?utf-8?B?V3NTSFREY1hUZXJoOTU1Q2RzMXhXK3RDRG52bEVoRS95WHJtRHFNM29WSGpo?=
 =?utf-8?B?VzVEMUp5Z1BsNGVnU3FsbXRrMll2WWtmcmMxOWh2d21HcnhQbjl2WjJrVlFI?=
 =?utf-8?B?V3JLcG5zNGJSdGlKQ1BOSkIrT1VSdUE5UFdmZ3lzejgyZmxZOHBvclBNSStR?=
 =?utf-8?B?S2VkNUpXZ3dwSXFpSDBHcExHSHRjVDM3ZEdlbTYza1A1VnV3KzhHdEtVb24w?=
 =?utf-8?B?Y0gvaTFGRkhNQXM3S3dHOGxZUzJ6Yzd3RmRTb0hMM0haeDloSGVSK3g0VFpQ?=
 =?utf-8?B?Ylo3Z21yWVAxTU5IVnRNRnZZaWp3V01MWElZWFVERjFYRkRuUisrT2IrTitX?=
 =?utf-8?B?dTVaWnJFREIvU3dpZ0FnYmFEOC81RkN5RGlKc2Q5VFF4L2V5VUpLYUcyZ1dv?=
 =?utf-8?B?R0psOFFWbHEySUJraG5adlNxNUI4R2FRd2FSRC9GNVJZWXo1V2tjY2hEK3da?=
 =?utf-8?B?Yi8yYTl1OXBXUmpYcXhGLzFXWjdIVjJlWllvUGIwMXFYNlYwV29VSlFnUUJh?=
 =?utf-8?B?MysvQWl3Rjhyc0VpU013amlHK1RLd0hmUmFya0todEtKSCttLzUzeStRNzU1?=
 =?utf-8?B?Ym5jY1FQUTR1YlUvaVROR0tBdVFJQ21KTUZNU2pQV3UxZ01lY3cwZFowYkpk?=
 =?utf-8?B?TjIrWHRSQ3k4amduaS90SUY3TTJJVUUyejZVOCtXU0hSVFJZUjYzaEV3aTVa?=
 =?utf-8?B?ZGtiNmpXOXFMVmlNcEJuRzVUaDZWNXVRb2dGNVkvTHdCT0ErbVJyY0REcjRP?=
 =?utf-8?B?YWhrRDFlOTd4eUdhU2xmYndLUEszaUxxbG5SbjNTcXdJV0xnRGh2R2ZOV0N5?=
 =?utf-8?B?emJ4N0c0Tmthd0UzUjBENnhSbi9wWUdoSVZ3VTRaOWdYV0ppdGh1bmlXUEIx?=
 =?utf-8?B?Zld5WjRJdUh3bW93WXR0RUQ4R3I1UGxZS2d0Y2w5Q293TFYwQkZac3RuRWVo?=
 =?utf-8?B?RWNPYmdWb3BEV2p1cmt5bXZ1UFh4TzNuMkl1eVFRQWQrdVhwdG1qa3JOZEtN?=
 =?utf-8?B?cVZMVXpTZE55b2RYdi8vQjBUZk1rd1pXeEdLNit2ZmVpMWhVdFRlZTRxNmpC?=
 =?utf-8?B?aHRSa3dzdzNFNFZqTXM2S0dmbFMwN3dmcVhyV29zcTI2Mmkxc1VFVkQ0QjdZ?=
 =?utf-8?B?VVhqQzlvWmVnTGlpbnhjaUVjREQ0Y0FQRzJINzErSzRhUUpwOFc0cExQdVJt?=
 =?utf-8?B?MW1GYStaUytrSzR3TVJhSUV2L0ZVdmxyZnhtT0VJSStKejBsR3RpUlQ1TGto?=
 =?utf-8?B?WVo0a0xTcXhrU3ZJZXFDcUxqMDd1Z204VnlkZlhhWjN1UGJ6YmNUaVJiQXI4?=
 =?utf-8?B?QTlLNklUUHJrb1UzYm5CV1lTRWNXTGRWcjJxc28wOVpqT3I0QVdYNWd4OWZV?=
 =?utf-8?B?WmY2V3pUdUlydjBnVStGMU5ENHJUYlJMYWpTKzB1M2Y3SWtZL2U2dlJlVmwz?=
 =?utf-8?B?UG5nZC9aUU1oSDdCcTVuUW5BRi9EbHVBV01GbVFRSFArZ1h3ZU1YaXRDV1lw?=
 =?utf-8?B?Z3h3OEUzK0Y5VWJYWklkNkF4THljQmg5RVEycWVZelFPaTVVTU1sMnd3dU03?=
 =?utf-8?B?OXRrUHpGeGszSnBKdEQxYXpPdUFDVHVhcG9keTg1Q1NGN3RmZHVJak1DVTNj?=
 =?utf-8?B?c3Vac1ZKQ0F0Ym9FVnNKalJwTE1RPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <17B8785FE1120A40A188F066514746B7@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db866e0-ce0d-4562-0396-08dd6c6784e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 13:10:02.3182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OoupZyHftLaYWBonxhqsZY6xpqCheli5FJrWvNjSn+gIVTdURS2IGJK6OBIDcKgVpyjfPt6/rlAWqotxM7/Xcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB5235

T24gV2VkLCAyMDI1LTAzLTI2IGF0IDA3OjE4IC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
T24gV2VkLCAyMDI1LTAzLTI2IGF0IDA2OjM5IC0wNDAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiA+IE9uIDI1IE1hciAyMDI1LCBhdCAxODozNSwgdHJvbmRteUBrZXJuZWwub3JnwqB3
cm90ZToNCj4gPiANCj4gPiA+IEZyb206IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0
QGhhbW1lcnNwYWNlLmNvbT4NCj4gPiA+IA0KPiA+ID4gSWYgYSBjb250YWluZXJpc2VkIHByb2Nl
c3MgaXMga2lsbGVkIGFuZCBjYXVzZXMgYW4gRU5FVFVOUkVBQ0ggb3INCj4gPiA+IEVORVRET1dO
IGVycm9yIHRvIGJlIHByb3BhZ2F0ZWQgdG8gdGhlIHN0YXRlIG1hbmFnZXIsIHRoZW4gbWFyaw0K
PiA+ID4gdGhlDQo+ID4gPiBuZnNfY2xpZW50IGFzIGJlaW5nIGRlYWQgc28gdGhhdCB3ZSBkb24n
dCBsb29wIGluIGZ1bmN0aW9ucyB0aGF0DQo+ID4gPiBhcmUNCj4gPiA+IGV4cGVjdGluZyByZWNv
dmVyeSB0byBzdWNjZWVkLg0KPiA+ID4gDQo+ID4gPiBSZXZpZXdlZC1ieTogSmVmZiBMYXl0b24g
PGpsYXl0b25Aa2VybmVsLm9yZz4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFRyb25kIE15a2xlYnVz
dCA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gwqBm
cy9uZnMvbmZzNHN0YXRlLmMgfCAxMCArKysrKysrKystDQo+ID4gPiDCoDEgZmlsZSBjaGFuZ2Vk
LCA5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdp
dCBhL2ZzL25mcy9uZnM0c3RhdGUuYyBiL2ZzL25mcy9uZnM0c3RhdGUuYw0KPiA+ID4gaW5kZXgg
MjcyZDJlYmRhZTBmLi43NjEyZTk3N2U4MGIgMTAwNjQ0DQo+ID4gPiAtLS0gYS9mcy9uZnMvbmZz
NHN0YXRlLmMNCj4gPiA+ICsrKyBiL2ZzL25mcy9uZnM0c3RhdGUuYw0KPiA+ID4gQEAgLTI3Mzks
NyArMjczOSwxNSBAQCBzdGF0aWMgdm9pZCBuZnM0X3N0YXRlX21hbmFnZXIoc3RydWN0DQo+ID4g
PiBuZnNfY2xpZW50ICpjbHApDQo+ID4gPiDCoAlwcl93YXJuX3JhdGVsaW1pdGVkKCJORlM6IHN0
YXRlIG1hbmFnZXIlcyVzIGZhaWxlZCBvbg0KPiA+ID4gTkZTdjQgc2VydmVyICVzIg0KPiA+ID4g
wqAJCQkiIHdpdGggZXJyb3IgJWRcbiIsIHNlY3Rpb25fc2VwLA0KPiA+ID4gc2VjdGlvbiwNCj4g
PiA+IMKgCQkJY2xwLT5jbF9ob3N0bmFtZSwgLXN0YXR1cyk7DQo+ID4gPiAtCXNzbGVlcCgxKTsN
Cj4gPiA+ICsJc3dpdGNoIChzdGF0dXMpIHsNCj4gPiA+ICsJY2FzZSAtRU5FVERPV046DQo+ID4g
PiArCWNhc2UgLUVORVRVTlJFQUNIOg0KPiA+ID4gKwkJbmZzX21hcmtfY2xpZW50X3JlYWR5KGNs
cCwgLUVJTyk7DQo+ID4gPiArCQlicmVhazsNCj4gPiA+ICsJZGVmYXVsdDoNCj4gPiA+ICsJCXNz
bGVlcCgxKTsNCj4gPiA+ICsJCWJyZWFrOw0KPiA+ID4gKwl9DQo+ID4gPiDCoG91dF9kcmFpbjoN
Cj4gPiA+IMKgCW1lbWFsbG9jX25vZnNfcmVzdG9yZShtZW1mbGFncyk7DQo+ID4gPiDCoAluZnM0
X2VuZF9kcmFpbl9zZXNzaW9uKGNscCk7DQo+ID4gPiAtLSANCj4gPiA+IDIuNDkuMA0KPiA+IA0K
PiA+IERvZXNuJ3QgdGhpcyBoYXZlIHRoZSBzYW1lIGJ1ZyBhcyB0aGUgc3lzZnMgc2h1dGRvd24g
LSBpbiB0aGF0IGENCj4gPiBtb3VudCB3aXRoDQo+ID4gZmF0YWxfbmV0ZXJyb3JzPUVORVRET1dO
OkVORVRVTlJFQUNIIGNhbiB0YWtlIGRvd24gdGhlIHN0YXRlDQo+ID4gbWFuYWdlciBmb3IgYQ0K
PiA+IG1vdW50IHdpdGhvdXQgaXQ/wqAgSSB0aGluayB0aGUgc2FtZSBjb25zaWRlcmF0aW9uIGFw
cGxpZXMgYXMNCj4gPiBzaHV0ZG93biBzbw0KPiA+IGZhcjogaW4gcHJhY3RpY2FsIHVzZSwgeW91
J3JlIG5vdCBnb2luZyB0byBjYXJlLg0KPiA+IA0KPiANCj4gVHJ1ZS4gSW4gcHJpbmNpcGxlIHdl
IHByb2JhYmx5IG91Z2h0IHRvIGF2b2lkIHNoYXJpbmcgc3VwZXJibG9ja3MNCj4gYmV0d2VlbiBt
b3VudHMgd2l0aCBkaWZmZXJlbnQgZmF0YWxfZXJyb3JzPSBvcHRpb25zLiBJbiBwcmFjdGljZSwg
SQ0KPiBhZ3JlZSB0aGF0IG5vIG9uZSB3aWxsIGNhcmUgc2luY2UgdGhpcyBtZWFucyB0aGF0IHRo
ZSBzZXJ2ZXIgaXMNCj4gYm9ya2VkLg0KPiANCj4gPiBBbm90aGVyIHRob3VnaHQgLSBpdHMgcHJl
dHR5IHN1YnRsZSB0aGF0IHRoZSBvbmx5IHdheSB0aG9zZSBlcnJvcnMNCj4gPiBtaWdodC9zaG91
bGQgcmVhY2ggdXMgaGVyZSBpcyBpZiB0aGF0IG1vdW50IG9wdGlvbiBpcyBpbiBwbGF5Lg0KPiA+
IA0KPiA+IFJldmlld2VkLWJ5OiBCZW5qYW1pbiBDb2RkaW5ndG9uIDxiY29kZGluZ0ByZWRoYXQu
Y29tPg0KPiA+IA0KPiA+IEJlbg0KPiA+IA0KPiANCg0KVGhlIGRpZmZlcmVuY2UgaGVyZSBpcyB0
aGF0IHRoZSBmYXRhbF9uZXRlcnJvcnMgb3B0aW9uIGFzIGl0IHN0YW5kcw0KdG9kYXksIG9ubHkg
bG9va3MgYXQgd2hldGhlciBvciBub3QgeW91ciByZXF1ZXN0IGlzIHJvdXRhYmxlLiBJdCBpcyBu
b3QNCmludGVuZGVkIHRvIGZ1bmN0aW9uIGFzIGEgbWVjaGFuaXNtIGZvciBkZWFsaW5nIHdpdGgg
c2VydmVycyBiZWluZw0KZG93bi4gSXQgb25seSB3b3JrcyBhcyBhIGxhc3QgcmVzb3J0IGZvciB3
aGVuIHRoZSBob3N0J3Mgb3JjaGVzdHJhdG9yDQpzb2Z0d2FyZSBkZXN0cm95cyBhIGNvbnRhaW5l
cidzIGxvY2FsIHZpcnR1YWwgbmV0d29yayBkZXZpY2VzIHdpdGhvdXQNCmZpcnN0IGVuc3VyaW5n
IHRoYXQgaXRzIG1vdW50cyBoYXZlIGJlZW4gc2FmZWx5IHNodXQgZG93bi4NCg0KSU9XOiB5ZXMg
dGhlcmUgYXJlIHNvbWUgc3VidGxldGllcyBoZXJlLCB3aGljaCBpcyB3aHkgd2UgbmVlZCBhIG1v
dW50DQpvcHRpb24gaW4gdGhlIGZpcnN0IHBsYWNlIHRvIGFsbG93IG92ZXJyaWRlIG9mIHRoZSBk
ZWZhdWx0IGJlaGF2aW91cnMuDQpIb3dldmVyIHRob3NlIGRlZmF1bHQgc2V0dGluZ3MgYXMgdGhl
eSBzdGFuZCBhcmUgaG9wZWZ1bGx5IHN1ZmZpY2llbnRseQ0KY29uc2VydmF0aXZlIHRoYXQgYWRt
aW5zIHNob3VsZCBvbmx5IHJhcmVseSBuZWVkIHRvIG92ZXJyaWRlIHRoZW0uDQoNCi0tIA0KVHJv
bmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0
cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K

