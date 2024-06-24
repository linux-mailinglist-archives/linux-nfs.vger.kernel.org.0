Return-Path: <linux-nfs+bounces-4282-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6791391569F
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 20:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBF161F22F8B
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 18:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFFF1F5FD;
	Mon, 24 Jun 2024 18:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="TxFgBSXD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2121.outbound.protection.outlook.com [40.107.93.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E75E107A0
	for <linux-nfs@vger.kernel.org>; Mon, 24 Jun 2024 18:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719254819; cv=fail; b=koP/EymLQ1kYfb2eZAeji0/LoYLz3tAqGtqNNRN+c9Nw5UvAR50q0wUPM4SO6yLwwaDkCQ8ZOmkkiAz5Xbz9N3wvCqZ2TZK+ConNn2SpWRy2x9qJi4PV7fikq/x5U94v4DdyxJ5vfGRtCqbZGNwJ2pL3OQBF6LSZ29oemqPqBH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719254819; c=relaxed/simple;
	bh=NBoZxQuLAnNxg10n/L6lIVmEFMh4mGUy4qifwulJNFk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n9E/Yh1RMg3NI8ChKyTQQZSfM0Jz05D8LTxwoGfbRJFBGF9rvgaGhw+F+t19DdmNEpP27RdaLH3MpRF7w637LZB4JXPVFVlkDLFY3gd7w0+GnAcpj4HFbdxq70yFjZ8NJc/Ilr1lMkMJlmBawOD+TcYWHhOmHa7tqO76VHqNlbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=TxFgBSXD; arc=fail smtp.client-ip=40.107.93.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmaDqSwxkMCbQzTCsHWiFZ83acOlfTd2BsTDavzV201D2nRQ0pVJcX82KeMVdqmRyW+5U4UwhJiv57DUNWx9aj4fMhYjB5jVVZaL8BnIkWNFo6qh48vjxfgpxWO5+69BgVF1LEyC1rUiFuXHlTdTSwny3+mMDcBrbnvxq4toMLagvtQOPJio4MDlWHuQmUfQ2Ek7bXdQ2uXUBySKGBM9Eh9CSW2Ui8zF4Egk3YGDMuzmMoNu2WTpUjLMuMAJz5o0RVZjHLeFlitQQVG077jZzwc6iOse5p84fSVrmO+N/oOFs/Tah0UZeBKqAAsIYNOJH1ssqmL8ZM/H17lnWKKPew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBoZxQuLAnNxg10n/L6lIVmEFMh4mGUy4qifwulJNFk=;
 b=g+Vp+6YIwp82n6U3k/CaAuHD0789SLLt+8OpKcCUNM0T20kowuUAtBr4A4v2ldbnzBCYiz0Dabc0FjlEchStXvDcWQHXifyLXxkh5pPIKtIqlbGuA4U2i4T5N7CpWlp44gu3/I7tam1FsSenfpN1ezucTqcaJmjtMMqve9y9LSyAHrM3LMrhvxS1pp2ngVeGSMjR5ZVhLxt404w9AxD0z3ea7WjGcsNLhAEOYVsGTIei6Y6zZaRF2WuzxkWx0kX6ZlEfo7kHpdO04JM27P4WTnwgj+gtIhRpj26N5NGDkRH4XXElIlehufkJjUFF6oWABCNSOqteQZqivfd17rWTvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBoZxQuLAnNxg10n/L6lIVmEFMh4mGUy4qifwulJNFk=;
 b=TxFgBSXDeCdCsXHhCY0Xh7etSJI9HAuxAZ5lyaOV7B6mfBTqdrhFjANkchSWyU/T0zC5CH3yXVPr9Zj2fCw8zEfo9vhfg/GPFce0g+e1njCLcNYCEIcYdO+nQRk2md/oiuwGE9OMAkHOU+hvAWTgB5WmUfPbU87nBA+JFNK0OZc=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BN0PR13MB4711.namprd13.prod.outlook.com (2603:10b6:408:116::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Mon, 24 Jun
 2024 18:46:54 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%6]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 18:46:54 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH 1/1] NFSv4.1 another fix for EXCHGID4_FLAG_USE_PNFS_DS for
 DS server
Thread-Topic: [PATCH 1/1] NFSv4.1 another fix for EXCHGID4_FLAG_USE_PNFS_DS
 for DS server
Thread-Index: AQHaxjppixMV57VTmkeqWI0q/gQrHbHXBqGAgAAG6gCAADPCgA==
Date: Mon, 24 Jun 2024 18:46:54 +0000
Message-ID: <ba1029d6195575dfea5056127639b0f42a6268af.camel@hammerspace.com>
References: <20240624132827.71808-1-olga.kornievskaia@gmail.com>
	 <bb2d44bc4f10032ce1abdd7cbc576cc5ea5da5c5.camel@hammerspace.com>
	 <CAN-5tyEPQMTLFP=r9s2wj3RqdV3DjU3wEeWAnmDfs+_NDBxp2Q@mail.gmail.com>
In-Reply-To:
 <CAN-5tyEPQMTLFP=r9s2wj3RqdV3DjU3wEeWAnmDfs+_NDBxp2Q@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BN0PR13MB4711:EE_
x-ms-office365-filtering-correlation-id: b650e709-b259-42b5-5545-08dc947e04cc
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|376011|366013|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?TW10YzhEVVh5OXNRdW52UFZHb1p6NjcwdDZTdlpuaGJYM0tGLzJIdVRsVXB4?=
 =?utf-8?B?eWR2YUNQcmExbDFzUkJ6eEZncWw2ckFHZmtqM0ZrYzNFZmdUMnI2Y0hacVhC?=
 =?utf-8?B?bStFUW1rajl0ajlxTWVKUTZhdHVNNTZ6OGduUnhpcC96TFBQZWZucExaeGdE?=
 =?utf-8?B?L3I4TVRNZUtESUk0SytDYUd1M0QrK2tuSERLKzJQbHIwYnBkTUZyZlhtSVFq?=
 =?utf-8?B?UWJiSkE4eVN6UE9vcFpqd1BlM2NlVDgyQWZmQy9QdjhrM1RtWlNZeU9HSHNX?=
 =?utf-8?B?V0xZYlJRMGx3elprbEtEcDVOcjl5eUlsbVhSTnQrTXFZK2dFSXdyNFNtNUls?=
 =?utf-8?B?NmUyZklOZDhvY1k4ZVhrMjBVK1VKdm5CdVp2QVBmNDNYa3k0ajd6QWxENzZu?=
 =?utf-8?B?TTMwS1FtZG5JSW9Wd2w5VStCd0pLQVpGZ2pXeU1IK282U3Nld29tZXQ2Mlhh?=
 =?utf-8?B?MXN6QWtLREhBSmUzS0VFenZlc0JkQXU0L2dNMTRpYUZYdEhza0pERnlpNnJj?=
 =?utf-8?B?REZQM3ZjTTFuRkFlQ2NHMzBBRTc5Q0ppeVk3a1JMb3lYWUZzaytZc1IyL1hV?=
 =?utf-8?B?QW9rcHgvZ1RSazFiTmV1Y2pDdkpwdjVXMkRiSk1kKzFMdXltRzlYcmZ5QnN5?=
 =?utf-8?B?V1kwa2dFT1h2OE5XRWdBRXZNd2o2MFJZdXgrZEMvV3FYejJKb0ZCSGd1Qm5t?=
 =?utf-8?B?T0VUM1R5c3lxWjBGenVCZ1E1L3VuaVFFblM2amZhRDRBbVcxQTlucnhXN3VE?=
 =?utf-8?B?d1k0alB1Lzg4R3UzU0NUOVoxNVQ1OHpaL2VZQ2hCMlJvY1E0ejJDYldNU1hG?=
 =?utf-8?B?eXFUOHlTMEc4dy85VFg5YkJrU1B3Y2pkM29uM003TVJvSnZQK2RGZmJrM2FM?=
 =?utf-8?B?Ny93Zmhobm1ZVGZ5dXEyZG1nRTBOT0l5ejFsZG1oNWhYUkxyWVc1QWlBTUZ0?=
 =?utf-8?B?dXdiaWl1cTRDSEQxNWJJVFRVb3VBV1FWdzI3UlR6RVNETDdaSjFaQ1FibmEy?=
 =?utf-8?B?UjFPL1JXcTZSL1pESDB1bzFmeG9QenZiWHcwVm5qem13LzFINkJsUTkydC9l?=
 =?utf-8?B?akFjZk81WTB2SGQ4NUhGZmVIUjh0SUI0bmNaKy9PNkFTdEV3Vm9hYVU5akFU?=
 =?utf-8?B?U2FOdW5GbGgzbU1FNGhJNldiUEtYTVlUbkwvc1QwUHovaW13cVhZWFFEOFpN?=
 =?utf-8?B?WU9rU1d2Wi95WVVoRXZ1dUYxWmhoSDdWWk9JUldTK3dFOHg1TlJBMkNwTTQ1?=
 =?utf-8?B?WXJwZ2NQcEhmUU9VZnhFVHNEK0FNanBTMEdTM045WW1WdFBZUEh6TjNMV01l?=
 =?utf-8?B?SCt6VzNXTndLWEtKYko5M3JjcW1rY2ltbTAwVHR0WDVPS0g1c1VpVnIxRGpT?=
 =?utf-8?B?SWtoOTBkRVFuL0VlU3hJRTMwYThzOVRzMk4yUk5jSnh3T0svZmFsMzB2RkxT?=
 =?utf-8?B?VGpEbVFnYVJlaWlTc1NPbEVXaG0zNHh2emxSUzIra3Z6M1RNTFU0RmF2ZjF1?=
 =?utf-8?B?OXp2Qlk4MExYV3BRTE4vcnNWL1JjaEJrWGRLRU9xNTBmVjd4ZmxkUEJaeVdm?=
 =?utf-8?B?bXVoQktobk9NUVBuWkZ0ZE9yUFl3RzVNVFhZZ2JvY0pzZFFGSE5NMHI1MlJy?=
 =?utf-8?B?Z1VBTmVaSlo4bzNoRm9LRHgvYUNLOEVKQUVUSXhRY2gwNFV3a3V6TTFlRnVo?=
 =?utf-8?B?RlNMcXdMcFhhVEVTK2FPWjNsUUJrUHg2Ym16Qm80T2Q0NFd4VVBYSzNDcU8y?=
 =?utf-8?B?cTBhdEFZSmprV1UzcU9ncEpSYW5HSFJQdjU5cXBHMkpzVmlmWWd2QXBKRU9l?=
 =?utf-8?Q?VHx+2qHQv17Y+k4969EnASJq+VH5FCJYOQ17o=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SXJzdEcyYUdLRFRTMnhnVVVDS1VycEpxTFFkcXFhZlVsSkkxRDlIZklsVk1L?=
 =?utf-8?B?VjhoTTU4d1J2dWtYV2VCTkFCaVR2VXU0ZnFTVXdtai9yOFN5UDArZXhuR212?=
 =?utf-8?B?Y2NOblF1eWdtQzEvajVLaEgvVzFMT3ZGaW5zRWtLQlZyclV5REtuZEVnV0Fz?=
 =?utf-8?B?a1U1NGExWVE4aXJTdWlSd0l5Z0IrZmhzS2cxSEhrczlISGVncm55THVNTWgw?=
 =?utf-8?B?SHRIc1k1cCtiZ2pVSFJlc1FTYTZXZUVNYnRhQ1p4aW9UMklJdXErWHpJYlp5?=
 =?utf-8?B?bWdmZUJzSXIyUURnRnFsVTByV3VVN2lTelRKMGtEallqQlplSEVpNm10RlJR?=
 =?utf-8?B?Y2RsSTV5OHpPRHB5ZStoWmdWZXNyQ1JiczduZFFzYVM1VUNSMlVMMG1DWEt2?=
 =?utf-8?B?V21LZDhzL0c2SkovemlnWE9NVTJHYVVUOHpQanNaeFVGOTZDaWdvNnhZZWdV?=
 =?utf-8?B?Q3lPT0V5SFk5MTBLZCtUVXpObnVydzh5YVM5dnFyRGpSK2ZUZ3RaTnV3R2ts?=
 =?utf-8?B?d2Y1SENkZzYzQjJTMjRhc2o4UVdKQzBLSkRYVW05MWFOWm9pQlM2Z1VaamE1?=
 =?utf-8?B?RUh0ajcyQVFVMzZOaWhjbE82QnY0SEFXMVBRbjBPRk94YU9LOCtrQW12b2J4?=
 =?utf-8?B?Wk42WHFIKzczbnNlZ3JHc3RLQ0ZFREVLUTd4NmJmS0Njd1VNV1F2eXNSZXgz?=
 =?utf-8?B?YWFXWXpGdmZQTGh2bTYwLytXaVc4TGsvZXU1NGFSejNhV0toRVF3Q0VJZThT?=
 =?utf-8?B?ODFPeUJTbjJpQ3VJaGtMWVZoekI4TWZPU0hQZ3B4eWd4dTdrb1BJaE1OOXNP?=
 =?utf-8?B?R0tObHZMTC9xSHErSjhmNDFkSXYrNzNiZURpMDlvSi9rWGVFU1I2ZFM3Y29F?=
 =?utf-8?B?bTRaZGVuWjBGN2FwczNDSUEzZEdOT3YwUm9URU0zNmE4K3E2NTdiK0VQQSt3?=
 =?utf-8?B?d2Y4aG1qOHlUK2hBU01yMytBVW9heEVRbnZTMTBkYk5qcVN6NzZGTnhSSFN4?=
 =?utf-8?B?K2ZHazVUbnVjeEhOLzB0OE1mMGlpNnlxcWJWckNWZXFJaUZFSksranZ3Z291?=
 =?utf-8?B?RWU4cnRWY0pvTXhadUg3TW9ySzlmdXNOYUpLS0pBWGI0bmFhZmJzK0RHLzR6?=
 =?utf-8?B?WjhhVVRqQmhoWFZlcFFpaWZLRThOb2dodWNCWjNKMTNrQ3RnazA1SUxJaEln?=
 =?utf-8?B?amEya01NbVJzekVTUC9nM3prWFdteUVMaVFtQ1dOWmZQWFowbW1DaEUvbWY5?=
 =?utf-8?B?UzRWRElzaTk1c0hsd2hlcEtQY1o2bmlkc1BST0xiMFZ1aGUvZEo4dzZCZW1r?=
 =?utf-8?B?T3JocEJDU3N5MzZUKzhtTUdkNCsxYVdKNGI1VG8zSGxNRXdyOW1DODhTVW11?=
 =?utf-8?B?U1YyVDNQVk15UXFjWU9yZ2R6WHRlM3p5RkFPRk1MVmo1bGdUZ1diTXhwcWZU?=
 =?utf-8?B?UDl6Vzh4YzN4dTNmZzA0OTdhNXJYeFhvc1ZHSnpzV3JCVk1IYm5jTDRyREQw?=
 =?utf-8?B?cHM1NEovbFFJMmQ1Sk9iaW9jSUtpRFFXbk1oZ0h3ZGNFMHlqTERuRVdxLzZy?=
 =?utf-8?B?M3RHdkl5R1NTWTdHdmlvNk9RMXhzQ2RncWVTUzBtSXpveE5FUFV1RlpzanNu?=
 =?utf-8?B?RzJ5eDdBM2pOVzVEcE95MWxIOXZkTk0yU1VubUY3SUY5Y3R4STNOT0FwekE5?=
 =?utf-8?B?aTc2TTZ6alpvL3lzTTVhd3V5MWhPbnQ2ZHBQWGU2UjVkaWlMelVvRmNhdkh3?=
 =?utf-8?B?ZjJBZVlPV0hZTDB1d0hmK3BBZVQ0RzBJMkU0NEJjcDdTbUdyS1BjWVpPZVYr?=
 =?utf-8?B?L2FkSFBXTXp5YlZiNWVOTlVyMm5UOVVhc3BDekZ0cmVGdEtRbWU5dmtEYUZk?=
 =?utf-8?B?VGZiUlpoKzdJbzRGZFBkOGZ3Q1cyWVdlQ0dVb1NRMGN5RGYxUWdPR3BpeWVp?=
 =?utf-8?B?UWJnWFVBaFdRS2NTUWN5ejFzRnJyblNLcHJZMjREci9TS0gxRDVESVlsT2pO?=
 =?utf-8?B?Unk4aERQdENqRjQ4R3AvbTQ4cVhuZ0o2SmF5R0VzTXIwQm1pRzNRZGRvSGQy?=
 =?utf-8?B?eDgrZ2h6U0U1azJsbXc1SHdmcWZ2ek9pSUxnK0NBc1g5aVF1U2hERGhhT0pJ?=
 =?utf-8?B?eWhBczJDUmtIUUFIWjJuNmxickdFbHlvdFpaTXE4bkhZNDNHK3VWUzRiUzhN?=
 =?utf-8?B?T0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2BEF3FD94A2C474FA425A652A6C13A82@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b650e709-b259-42b5-5545-08dc947e04cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 18:46:54.6952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gCnnDAfPzHlXROw/0ZJku8q7//X4aEo0WMrtKzHXglm0l2k4TgLZWEG7oWAqdQOiuC5q7ZJFoxydOKl0S6qHcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB4711

T24gTW9uLCAyMDI0LTA2LTI0IGF0IDExOjQxIC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gT24gTW9uLCBKdW4gMjQsIDIwMjQgYXQgMTE6MTfigK9BTSBUcm9uZCBNeWtsZWJ1c3QN
Cj4gPHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiANCj4gPiBIaSBPbGdhLA0K
PiA+IA0KPiA+IE9uIE1vbiwgMjAyNC0wNi0yNCBhdCAwOToyOCAtMDQwMCwgT2xnYSBLb3JuaWV2
c2thaWEgd3JvdGU6DQo+ID4gPiBGcm9tOiBPbGdhIEtvcm5pZXZza2FpYSA8a29sZ2FAbmV0YXBw
LmNvbT4NCj4gPiA+IA0KPiA+ID4gUHJldmlvdXNseSBpbiBvcmRlciB0byBtYXJrIHRoZSBjb21t
dW5pY2F0aW9uIHdpdGggdGhlIERTIHNlcnZlciwNCj4gPiA+IHdlIHRyaWVkIHRvIHVzZSBORlNf
Q1NfRFMgaW4gY2xfZmxhZ3MuIEhvd2V2ZXIsIHRoaXMgZmxhZyB3b3VsZA0KPiA+ID4gb25seSBi
ZSBzYXZlZCBmb3IgdGhlIERTIHNlcnZlciBhbmQgaW4gY2FzZSB3aGVyZSBEUyBlcXVhbHMgTURT
LA0KPiA+ID4gdGhlIGNsaWVudCB3b3VsZCBub3QgZmluZCBhIG1hdGNoaW5nIG5mc19jbGllbnQg
aW4NCj4gPiA+IG5mc19tYXRjaF9jbGllbnQNCj4gPiA+IHRoYXQgcmVwcmVzZW50cyB0aGUgTURT
IChidXQgaXMgYWxzbyBhIERTKS4NCj4gPiA+IA0KPiA+ID4gSW5zdGVhZCwgZG9uJ3QgcmVseSBv
biB0aGUgTkZTX0NTX0RTIGJ1dCBpbnN0ZWFkIHVzZSBORlNfQ1NfUE5GUy4NCj4gPiA+IA0KPiA+
ID4gRml4ZXM6IDM3OWU0YWRmZGRkNiAoIk5GU3Y0LjE6IGZpeHVwIHVzZQ0KPiA+ID4gRVhDSEdJ
RDRfRkxBR19VU0VfUE5GU19EUw0KPiA+ID4gZm9yIERTIHNlcnZlciIpDQo+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBPbGdhIEtvcm5pZXZza2FpYSA8a29sZ2FAbmV0YXBwLmNvbT4NCj4gPiA+IC0tLQ0K
PiA+ID4gwqBmcy9uZnMvbmZzNGNsaWVudC5jIHwgNiArKy0tLS0NCj4gPiA+IMKgZnMvbmZzL25m
czRwcm9jLmPCoMKgIHwgMiArLQ0KPiA+ID4gwqAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2ZzL25mcy9u
ZnM0Y2xpZW50LmMgYi9mcy9uZnMvbmZzNGNsaWVudC5jDQo+ID4gPiBpbmRleCAxMWUzYTI4NTU5
NGMuLmFjODBmODdjYjlkOSAxMDA2NDQNCj4gPiA+IC0tLSBhL2ZzL25mcy9uZnM0Y2xpZW50LmMN
Cj4gPiA+ICsrKyBiL2ZzL25mcy9uZnM0Y2xpZW50LmMNCj4gPiA+IEBAIC0yMzEsOSArMjMxLDgg
QEAgc3RydWN0IG5mc19jbGllbnQgKm5mczRfYWxsb2NfY2xpZW50KGNvbnN0DQo+ID4gPiBzdHJ1
Y3QNCj4gPiA+IG5mc19jbGllbnRfaW5pdGRhdGEgKmNsX2luaXQpDQo+ID4gPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBfX3NldF9iaXQoTkZTX0NTX0lORklOSVRFX1NMT1RTLCAmY2xwLT5j
bF9mbGFncyk7DQo+ID4gPiDCoMKgwqDCoMKgIF9fc2V0X2JpdChORlNfQ1NfRElTQ1JUUlksICZj
bHAtPmNsX2ZsYWdzKTsNCj4gPiA+IMKgwqDCoMKgwqAgX19zZXRfYml0KE5GU19DU19OT19SRVRS
QU5TX1RJTUVPVVQsICZjbHAtPmNsX2ZsYWdzKTsNCj4gPiA+IC0NCj4gPiA+IC3CoMKgwqDCoCBp
ZiAodGVzdF9iaXQoTkZTX0NTX0RTLCAmY2xfaW5pdC0+aW5pdF9mbGFncykpDQo+ID4gPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIF9fc2V0X2JpdChORlNfQ1NfRFMsICZjbHAtPmNsX2ZsYWdz
KTsNCj4gPiA+ICvCoMKgwqDCoCBpZiAodGVzdF9iaXQoTkZTX0NTX1BORlMsICZjbF9pbml0LT5p
bml0X2ZsYWdzKSkNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX19zZXRfYml0KE5G
U19DU19QTkZTLCAmY2xwLT5jbF9mbGFncyk7DQo+ID4gDQo+ID4gV29uJ3QgdGhpcyBjaGFuZ2Ug
Y2F1c2UgdGhlIG1hdGNoIGluIG5mc19nZXRfY2xpZW50KCkgdG8gZmFpbD8NCj4gDQo+IEF0IHdo
aWNoIHN0YWdlPyBUaGUgcHJvYmxlbSB3YXMgdGhhdCBuZnNfbWF0Y2hfY2xpZW50IGV4cGxpY2l0
bHkNCj4gbG9va3MNCj4gZm9yIE5GU19DU19EUyBmb3IgbWF0Y2hpbmcuDQo+IA0KPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogTWF0Y2ggcmVxdWVzdCBmb3IgYSBkZWRpY2F0ZWQg
RFMgKi8NCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICh0ZXN0X2JpdChORlNf
Q1NfRFMsICZkYXRhLT5pbml0X2ZsYWdzKSAhPQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB0ZXN0X2JpdChORlNfQ1NfRFMsICZjbHAtPmNsX2ZsYWdzKSkNCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsNCj4g
DQo+IFdlIGhhdmUgcG5mcyBmbG93IGNyZWF0aW5nIGNsaWVudCB3aGVyZSBORlNfQ1NfRFMgd2Fz
IHNldCBpbg0KPiBpbml0X2ZsYWdzIGFuZCB5ZXQgdGhlIHN0b3JlZCBuZnNfY2xpZW50IGRpZG4n
dCBiZWNhdXNlIHdlIGRvbnQgbWFyaw0KPiB0aGUgTURTIGV4Y2hhbmdlX2lkIHdpdGggRFMgZmxh
Z3MuDQo+IA0KPiBJbiBteSB0ZXN0aW5nIHRoZSBmaXhlZCB3YXkgYXBwcm9wcmlhdGVseSBmaW5k
cyB0aGUgTURTJ3MgbmZzX2NsaWVudA0KPiBmb3Igd2hlbiBNRFM9RFMgYW5kIGZvciB3aGVuIGl0
J3Mgbm90IHRoZXJlIGlzbid0IG9uZSB0byBiZWdpbiB3aXRoDQo+IGJ1dCB3ZSBzdGlsbCBvbmx5
IG1hcmsgVVNFX1BORlNfRFMgb24gdGhlIHBuZnMgcGF0aCBhbmQgbm90IDQuMQ0KPiBtb3VudC4N
Cj4gDQo+IA0KDQpBRkFJQ1MsIHdlIG5vdyBtYXRjaCBhbnkgTkZTdjQuMSBjbGllbnQgd2l0aCB0
aGUgcmlnaHQgSVAgYWRkcmVzcywNCndoZXRoZXIgb3Igbm90IHRoYXQgY2xpZW50IHRvbGQgdXMg
dGhhdCBpdCBpcyBQTkZTIGVuYWJsZWQgaW4gdGhlIHJlcGx5DQp0byBFWENIQU5HRV9JRC4NClRo
YXQgYXBwZWFycyB0byBicmVhayB0aGUgZW50aXJlIHByZW1pc2Ugb2YgeW91ciBpbml0aWFsIGNv
bW1pdA0KNTFkNjc0YTVlNDg4ICgiTkZTdjQuMTogdXNlIEVYQ0hHSUQ0X0ZMQUdfVVNFX1BORlNf
RFMgZm9yIERTIHNlcnZlciIpLg0KDQoNClNvIHF1ZXN0aW9uOg0KV2h5IGFyZSB3ZSBub3QganVz
dCBzZXR0aW5nIChFWENIR0lENF9GTEFHX1VTRV9OT05fUE5GUyB8DQpFWENIR0lENF9GTEFHX1VT
RV9QTkZTX01EUyB8IEVYQ0hHSUQ0X0ZMQUdfVVNFX1BORlNfRFMpIGZvciBleGNoYW5nZV9pZA0K
KGFzc3VtaW5nIHRoYXQgcE5GUyBpcyBjb21waWxlZCBpbiksIGFuZCBsZXR0aW5nIHRoZSBzZXJ2
ZXIgcmV0dXJuIHRoZQ0KY29tYmluYXRpb24gdGhhdCBpdCBzdXBwb3J0cz8NCldoYXQgaXMgdGhl
IHZhbHVlIG9mIGxlYXZpbmcgb3V0IGZsYWdzLCBhbmQgdGhlbiBhZGRpbmcgdGhlbSBpbiBsYXRl
cj8NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwg
SGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

