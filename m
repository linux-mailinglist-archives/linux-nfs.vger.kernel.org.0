Return-Path: <linux-nfs+bounces-8841-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B859FE1A8
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Dec 2024 02:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 060B5161931
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Dec 2024 01:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C151270825;
	Mon, 30 Dec 2024 01:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="PgOjgMOs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2139.outbound.protection.outlook.com [40.107.237.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4526F06B
	for <linux-nfs@vger.kernel.org>; Mon, 30 Dec 2024 01:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735523555; cv=fail; b=D9FNqjJsKQ8yDOrlvzsEL668d6yEi+QaBLqgH9wZklA+PCaU/6E5fn4S8ka6netqhAWkFLJziIRkTu5J11pjlvLF8cg1AtCeGN6/uKJxs7pdzxxGd9f9DtU9Ts0OlAEnngvHD2KKEYorcoYoTiX48vsYkUT54NURM7hbR8DwBzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735523555; c=relaxed/simple;
	bh=c80xxoPgWmRI8Ml4OEA2GSZMGuoD5fHLmSuDaJoWtY4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VqUtZaI8ecieUrABG45PskFhVTrgYudb1UDSDQ6v9kTzzjpptzQxJGS2MscYXsCJv9AlZlkp/Bz7fSEhAxjpJ8M/90jwC4OsXi9W6N9gXE76Ah2Vh1/IZjCj1Wf7m9WxHqkXRo6dPJ6LaVQ0BpoRARyyBsFRYz0CfDADi1NBdoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=PgOjgMOs; arc=fail smtp.client-ip=40.107.237.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1LGYWYVI54mgnLuhw0iDq0bk3Q2pfMFlyc9wPSCuuo35C5pk2Ic01VSUMXGykNB7CBcx6E095t9ZSOd8SfX/AckWNhkK4hwQhoNzmDKHv6eRfU/z2XLFTOlY+zZijmqBHP6hCdi602fHqZQvgYg/U1LbwZnO/RRYgW7P12aaNbB6Y4flQgVzTRRY9OK0rgT9qryZF1rtB85/WoOPRmuSNdb+kDlcSl058IYE3xDiR3zwRAJuyrFeTNQQF5rHvLzZJXMMnLKHm+MErc0vE6Go2MtSluek2D6NKJWKlvX+TnweklIIqTykkLoeVJjAbW/p5jQ+8v/fP5OxMw69bOQUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c80xxoPgWmRI8Ml4OEA2GSZMGuoD5fHLmSuDaJoWtY4=;
 b=cyg6LqGEjKneYUL2WC3gHsY5n+szaarrmT5p1CmZxyBwTCPlr59C+xySgXD8yQAcopY6un4YHddydXcK60CR8KFsqlwqT3km7Lt5c1fy4GlBPlJdld42Qd868y3KsDI5TkYNdwS7XTQ1hBm2N53weKQjAVLsar39sv6FGayNMwfTQAeOoWtFX0dS62oMkseLdQpJKLXtRgswo5W7qGmS5h6aUHvzV+f2544aWHOr87Ne0jukzqpOk//SPgow/SXxD0hVuyfT1S92vz9vPjXqzT9uUCRM0ViBpy630hWclzcXrXiGw08EB0lAECJrXqr0IKdB7vvpy4d5Uey4mD1A0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c80xxoPgWmRI8Ml4OEA2GSZMGuoD5fHLmSuDaJoWtY4=;
 b=PgOjgMOsrCsNne0cEci8LiTIfI27jUl9Dnl0ODI8ws/46nYVy6Jw9hIP4W1vGavQhwJwYEi2UXuRKSbATx8aCdvx9aA8cbKQ8f7VaEM4bomirTBYtAzqKm5IDu+VxiBVy3saC4ks3/rGdZXK5CT0shbPX9RRDSnHJKfaUgjJWqo=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB4634.namprd13.prod.outlook.com (2603:10b6:610:de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.18; Mon, 30 Dec
 2024 01:52:25 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%4]) with mapi id 15.20.8293.000; Mon, 30 Dec 2024
 01:52:24 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "chuck.lever@oracle.com" <chuck.lever@oracle.com>, Thomas Haynes
	<loghyr@hammerspace.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: fstests failures with NFSD attribute delegation support
Thread-Topic: fstests failures with NFSD attribute delegation support
Thread-Index: AQHbUZBe1he4x/T04Uy4SDHtEmgIXrLuAkkAgA/fMgCAADZRgA==
Date: Mon, 30 Dec 2024 01:52:23 +0000
Message-ID: <a2ffc62e7698aa4b40712e11cf766d964a7cc646.camel@hammerspace.com>
References: <b00b609b-13db-4404-8bdb-4550195362cf@oracle.com>
	 <49f7f3ce-bcb3-462a-b1e3-a99ffb85f10b@oracle.com>
	 <5056f1a4-cfce-4213-a605-1803c387e555@oracle.com>
In-Reply-To: <5056f1a4-cfce-4213-a605-1803c387e555@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|CH0PR13MB4634:EE_
x-ms-office365-filtering-correlation-id: e2777fda-ec4c-4546-6f7e-08dd28749b0a
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aDdrU24wei84MnREZzB5Mm9zc2h2VGc0WW1IdHBnS0dUUnJ2Nm42aXQxdFI3?=
 =?utf-8?B?MnRWY005RWRKQVJKQVczeUh1MEMrZ3JobDZrOEFtRHlNdyt2TEVaRDhBQWlM?=
 =?utf-8?B?ay9xbGZ4ekhjbStTOXFaTHdFMU5MUFcxanZSZlBnZDNEZ2FNZlZ2Y0FZSHZn?=
 =?utf-8?B?ZHVaRXp0a3JjUjM4bDNqMTJFSkhuOHRSZm9WaXcwOE1aTC9aLzJNL214c0Qr?=
 =?utf-8?B?MHRiZlAzRmRIRUtTNmtNQnB4aitrODAwTWRtZDdlWEtxMno4T2JTUXk1ZEdz?=
 =?utf-8?B?bUF5RUY0NExzR25JZ21UWkUvSGgxNDRUOE1SdTdPWHBiWTIrL0IyN3c2elJi?=
 =?utf-8?B?WHRVUlRoaFRZejNwcTcxMjlWSTczcTB2emtTaFF5NlFHai90bWJqZG1mTHR5?=
 =?utf-8?B?QVpkaGV6NUlWZ3FjVmhsdVE5c3hHS2Y1YXNRcmdxRWlhdGJJMG5HelJoWG52?=
 =?utf-8?B?bUlNQ2w5bE5xSkNFcEdtUjh4VDl3cW1rUnhRWng1TEZQVGQ3a29HZWFvdUVZ?=
 =?utf-8?B?akw2cEdyeDVSVWpmR2s0R1lhN0ZzOGFiakZmd1RtUFdzUTAyUFllT29DQWdj?=
 =?utf-8?B?Slg4aW5XeDlUZUl5Nzk3azM2YlNDNVc0Q2t0bDVBdFlrdU1PcGpCalcvQURP?=
 =?utf-8?B?ZXRCaFphMENiT2VMK1lIOEczeis3OWJkTFFQcDczbWtudFpyeUVlYTVYLzF0?=
 =?utf-8?B?RCs1elM3emtyZURiRlFiUmRhYk5KUHJzL25JZm1mYmcyZXVOczMrS2Q0YWlK?=
 =?utf-8?B?SE5tR0FHZjJnVmgxbE1CdmxUTkVkY2o5RWRvNExPd1VhZmgzdGkybHFWUUFy?=
 =?utf-8?B?UGNTUFBvNlVITGQyNGlvQUk0MlhjVXdTWVFzU0FTZ0ZpSjc5eUpTRWVqUzh3?=
 =?utf-8?B?QU5Ud0ZmTHA0K3k3NzFxRUkyTEM2OHpnM2RUcEc0azNOYUwxYUpGdFZWc2l6?=
 =?utf-8?B?NUl6a210S2ZTdUdUTlg2dFQ5S0ljZndNempXY09uWkFnSis2TldLMmdaam5k?=
 =?utf-8?B?TktPeFZ1eVJ4dXZQYU5UcDdZMXowb09SKzJoWjlEYTVNLzBZNzd6YUl1b2pp?=
 =?utf-8?B?aTNoSjdiWlpmc05oY0JqYXlLakxwb0NQcWk2UmJvUVZxZVFCYjYxOWJWVHJt?=
 =?utf-8?B?WkdOVkV3MzFXa2xydEZ0aE9rOGVJQlJiMXpHRWhobzB4eGlyK0crb1J5RGVR?=
 =?utf-8?B?NHc3QjVPUS9SREVPaHRUTWlkMWlDWUdXNi8vNWYyK3pVOWZrY05QaWNSZkVx?=
 =?utf-8?B?bDVVaWNxTWppT3QwTVJ1UkEzOVNIS3ZvZDNkeEkwYnF5dXhRVFZRZW9tVlcy?=
 =?utf-8?B?TndiYm5SSkcxcW4xVHBqelNFZm0yTXlSU0t5L0k3MklRQ0g0N2FJNWNybmlj?=
 =?utf-8?B?anVOVXJ6dXRleHpPeFI4cmc0Q0RaYm1YL0lRMlJRc2ZXVStEeXlVUk9McWVN?=
 =?utf-8?B?OGNuaUh6TTUxRkpVSmo5cHk2cStudnk1TjZSUFAwdzJod0FITTlGMlpqR2dU?=
 =?utf-8?B?SFJncUdMcVdWRzBoK3Q1ZHp5VEdaZXJEc3RYNHI5YzhyMXo3Q0UxRkpVY281?=
 =?utf-8?B?aUpRSllLZFlRZVh1bCtwRDFUQ1E2d0xpbmhGMDNnUHdNeUVmbWRaaHh5WUJG?=
 =?utf-8?B?OTRYSmhNMkJZUlRQRjM4UGZWN1hXV0JIZDFzME90NUhrV3pYSXJGbzBhaGQ2?=
 =?utf-8?B?bmR2cFptMTh6L0hvTHZqZkJSSjQydTZDV3ptdjBUbHdFMmhKbnBtNDA5Vmht?=
 =?utf-8?B?YVI1dldualFhNEtodlpvUGkyVDZuK0hVL3lvMks2eHkrUUxGMEVmd3pJa1p0?=
 =?utf-8?B?VEMwaG12clE0ZUNZaS9WQThydEtDWVVJcnpUWTllaTE2bHZ2Z01UZXoyeFBS?=
 =?utf-8?B?b1AzcGM0dWhRbzdpa0Y3UmtEUzFjVlFRRVVvYWdrUW5PdUhwdnFUSzhsTmRR?=
 =?utf-8?Q?FdBQw6QQ8L35vZFiQlli6TFaqtwyfaLn?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MysxcEpTcERiL1JqaklIUjBxcnBUT3U0OEVNTjVrR2hKbGh1cHM4bXN4NU53?=
 =?utf-8?B?NTFIR0ZDakVwKzUwTWF4YW5abTdKRXJvNW55cjY4TmNZNlk4bXJzQUdhT24v?=
 =?utf-8?B?NzRpZDM1eWhvbkxwcFVuKy9sYU9INzQvQjljRldSVUZIS1Qya1N1ak5oTWhG?=
 =?utf-8?B?NjBvdGtwWWNKR0tEejltZE1QVDNhQkJwTDdFTEMrRjd1d1c0azBnZ0tjdkUw?=
 =?utf-8?B?V0s0STgxWlpTSmR1d2JLc0Z0U0JVT2hYV2h1NmVYSU12anJOSG4rdzNtc1ky?=
 =?utf-8?B?eEFUekhvUWhiVXlOYnZVbTFJWE90dCtjYU1uNmFVcnpYRk9pL2EzOU1ZYnRs?=
 =?utf-8?B?NE9RSDZjakM0dElQTEJuT0Zic1FTVFRkVlJoNTJuQSt3Q0NRV0MvREZpdkRk?=
 =?utf-8?B?ZktVSE9wamlwakRxMXg4QW54V0VQWEpBcmhzUjNRRkxVeTdDc1NycjdKMC81?=
 =?utf-8?B?R2d4elQ4NUdIck42VzZ2b1hWaXFFeDU0cGQvQmRDY1NzREZBS1hrbnRVYmgr?=
 =?utf-8?B?bTVoZUhPS0JHR1FITVhvNDdRWTlsWXh2eFpmMCs1RWtGTHdxL3diUytqV2x6?=
 =?utf-8?B?RXoyeHdDRHdKRlgzNFU3UVllQ1pwVytFdkZQNCtrTWwxWnFqYVZaejNQTDB6?=
 =?utf-8?B?cDVIekNxL0d6a2F3UHlaZzh1Z0NnS2h4N1ZJelNRa1FTU2N2dHg3TEZ6VG1t?=
 =?utf-8?B?OFRrcXAvTjhLbFZ6ZTkxZDZEcDB2YjNqUUlLWTFkUlFzUVNqTDREck1sUEVO?=
 =?utf-8?B?Rlp6ZE5YY0M2c21aSmJ3N25IbGd4NkxPM0RsWlVJdHEveUs2NUhMdW1GNFo4?=
 =?utf-8?B?MWhLeEE1eW5ySCt5TjBYOW5LVmF0UXh2UWtva2hOTm1wb2dtSUJERUlXWWgz?=
 =?utf-8?B?ZmhRaU45OWhPOVpyNUZwMkRJRWZodVd0TW9ZNE01eXVrdUVJK05oOFNXT0hv?=
 =?utf-8?B?dE5wWHdJR1NHSDhzR1o2WC9mR2txbStRNVMyeGlMVjh6WWhwU1FDQzJ0cTRt?=
 =?utf-8?B?WjZFN25SM2RmK25mdkNKdU9UU01waDU4YmcxaHhLM2ljTWxTY0FFUVBpYWRY?=
 =?utf-8?B?ZzhpYjQ5SUJMNVE2N1d6TC9vL0N3cnk3L243NUttVWNlSUFUdlZqZ2trdWR6?=
 =?utf-8?B?czFHd2x1cDhrRU1kdXRKK3hYajdWb0pndHg2TWFhUUEwZHk0bWdmZWUyTmF2?=
 =?utf-8?B?K09wWk45SDV2NnR3TlNrQkRHOGFYSVVma3BHRjc2NTN0K3VRUXNyaWxwTjUy?=
 =?utf-8?B?aHQvYXIydWxRUC83VW5oRkRuWGdWM0VxVXVCd0t3QXYyUTVhejRKbnJUQ2VG?=
 =?utf-8?B?UVBiMnh0eUVSWnFtN055ZktCQ1p2RE13TmFXRDhIdEI0UnhiLzdVUm13TFdK?=
 =?utf-8?B?aTFwM3A5aTNBb3Rpam1xbkJLSXJiR2x5VUhZRVhFckF1Q2hqN2hVR3pPb2hx?=
 =?utf-8?B?UkU0VUQ0bElreDIzalp1dko0R1l2U21ZMElIVVoxbmtqbDk3cVlXWStvNnZo?=
 =?utf-8?B?WERtYm0vV0JIVnM3MTVYSkdvckVuS2wrdmpKQ2JrMittNWVKL0NKT2ttZkM3?=
 =?utf-8?B?YjRDZlh3QU1vUEtZYjg0VHNEbmY5TXdJUzl6NkhOM3BOUTBZYVNOQzRrUUdW?=
 =?utf-8?B?UVlEeGFUU1FlcDVjOG5KVnZwaHI1ajNHTTh1RnhFZE5MVitCS1NYckJtWkIy?=
 =?utf-8?B?QjlNSzRyeHFKeEt3SDNlRUlSbnhZRm5oWmFpWWFTdWYyQ25UajZPTW9ORlox?=
 =?utf-8?B?YVJMT0VrZFdxUDErNlBwS0szRHJCSjQ2K0N5QXhKSzk5Ri9XYTBSWXMwZWhL?=
 =?utf-8?B?d0xtNlNGMXdjREVNNU5nZHdEQjE2dnRmT25rdlR3VmtEZVRGTE83QjQvTWYr?=
 =?utf-8?B?TkZoM21XV3c5MmhZV014Z25FY0hDMHllWG5wRk1nblpELzBpd3NYZFFsY2RY?=
 =?utf-8?B?MzFvMDFlTnhhYzdGY1crUUNEMTZHT3J2ZUJMaU95K29saUhUeEkreHlTMmFa?=
 =?utf-8?B?akIrV0pLcVNTVXUrQlRXVmxLL1lUVmV6dGZudFMxQ3FmK2dqQ2hhU3ZhWUNv?=
 =?utf-8?B?MkVBWm0yejlJU01hbi85NGFLbFM1eFp3WUpReS9hSEZmc3NrS0JTLy9XRUJW?=
 =?utf-8?B?TTFzYU5uRWhKaWtTdXVPZVFxSEhFWm4zS0U5biszSkdLa05iNlBNeEtYNWRa?=
 =?utf-8?B?RHRkZWtSUEQ4Y3VJWmxZay9KcC9WUHl4elRsY0dlY0hpOE1SRDlzSVd3OUpT?=
 =?utf-8?B?U0VqZ2daSWJWWVlqV0RMQ1pwZm5RPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0E3B877F6494D4CB87463E053ECE4F3@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e2777fda-ec4c-4546-6f7e-08dd28749b0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2024 01:52:23.8427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i7YERCgf0O5cFQEw2MwwH3dCU3qLllhZ4VhI0PT93aCueYKjXqPapyJ7vchgSw/DOCQfOP/Dx3/sRqnpvYVykw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4634

T24gU3VuLCAyMDI0LTEyLTI5IGF0IDE3OjM3IC0wNTAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
T24gMTIvMTkvMjQgMzoxNSBQTSwgQ2h1Y2sgTGV2ZXIgd3JvdGU6DQo+ID4gT24gMTIvMTgvMjQg
NDowMiBQTSwgQ2h1Y2sgTGV2ZXIgd3JvdGU6DQo+ID4gPiBIaSAtDQo+ID4gPiANCj4gPiA+IEkn
bSB0ZXN0aW5nIHRoZSBORlNEIHN1cHBvcnQgZm9yIGF0dHJpYnV0ZSBkZWxlZ2F0aW9uLCBhbmQg
c2VlaW5nDQo+ID4gPiB0aGVzZQ0KPiA+ID4gdHdvIG5ldyBmc3Rlc3RzIGZhaWx1cmVzOiBnZW5l
cmljLzY0NyBhbmQgZ2VuZXJpYy83MjkuIEJvdGggdGVzdHMNCj4gPiA+IGVtaXQNCj4gPiA+IHRo
aXMgZXJyb3IgbWVzc2FnZToNCj4gPiA+IA0KPiA+ID4gwqDCoCBtbWFwLXJ3LWZhdWx0OiBwcmVh
ZCAvbWVkaWEvdGVzdC9tbWFwLXJ3LWZhdWx0LnRtcCAoT19ESVJFQ1QpOg0KPiA+ID4gMCAhPSAN
Cj4gPiA+IDQwOTY6IEJhZCBhZGRyZXNzDQo+ID4gPiANCj4gPiA+IFRoaXMgaXMgMTAwJSByZXBy
b2R1Y2libGUgd2l0aCB0aGUgbmV3IHBhdGNoZXMgYXBwbGllZCB0byB0aGUNCj4gPiA+IHNlcnZl
ciwNCj4gPiA+IGFuZCAxMDAlIG5vdCByZXByb2R1Y2libGUgd2hlbiB0aGV5IGFyZSBub3QgYXBw
bGllZCBvbiB0aGUNCj4gPiA+IHNlcnZlci4NCj4gPiA+IA0KPiA+ID4gVGhlIGZhaWx1cmUgaXMg
ZHVlIHRvIHByZWFkNjQoKSAob24gdGhlIGNsaWVudCkgcmV0dXJuaW5nIEVGQVVMVC4NCj4gPiA+
IE9uDQo+ID4gPiB0aGUgd2lyZSwgdGhlIHBhc3NpbmcgdGVzdCBkb2VzOg0KPiA+ID4gDQo+ID4g
PiBTRVRBVFRSIChzaXplID0gMCkNCj4gPiA+IFdSSVRFIChvZmZzZXQgPSA0MDk2LCBsZW4gPSA0
MDk2KQ0KPiA+ID4gUkVBRCAob2Zmc2V0ID0gMCwgbGVuID0gODE5MikNCj4gPiA+IFJFQUQgKG9m
ZnNldCA9IDQwOTYsIGxlbiA9IDQwOTYpDQo+ID4gPiBTRVRBVFRSIChzaXplID0gMCkNCj4gPiA+
IMKgwqBbIGNvbnRpbnVlcyB1bnRpbCB0ZXN0IHBhc3NlcyBdDQo+ID4gPiANCj4gPiA+IFRoZSBm
YWlsaW5nIHRlc3QgZG9lczoNCj4gPiA+IA0KPiA+ID4gU0VUQVRUUiAoc2l6ZSA9IDApDQo+ID4g
PiBXUklURSAob2Zmc2V0ID0gNDA5NiwgbGVuID0gNDA5NikNCj4gPiA+IMKgwqBbIHRoZSBmYWls
ZWQgcHJlYWQ2NCBzZWVtcyB0byBvY2N1ciBoZXJlIF0NCj4gPiA+IENMT1NFDQo+ID4gPiANCj4g
PiA+IEluIG90aGVyIHdvcmRzLCBpbiB0aGUgZmFpbGluZyBjYXNlLCB0aGUgY2xpZW50IGRvZXMg
bm90IGVtaXQNCj4gPiA+IFJFQURzDQo+ID4gPiB0byBwdWxsIGluIHRoZSBjaGFuZ2VkIGZpbGUg
Y29udGVudC4NCj4gPiA+IA0KPiA+ID4gVGhlIHRlc3QgaXMgdXNpbmcgT19ESVJFQ1Qgc28gSSBm
dW5jdGlvbi10cmFjZWQNCj4gPiA+IG5mc19kaXJlY3RfcmVhZF9zY2hlZHVsZV9pb3ZlYygpLiBJ
biB0aGUgcGFzc2luZyBjYXNlLCB0aGlzDQo+ID4gPiBmdW5jdGlvbg0KPiA+ID4gZ2VuZXJhdGVz
IHRoZSB1c3VhbCBzZXQgb2YgTkZTIFJFQURzIG9uIHRoZSB3aXJlIGFuZCByZXR1cm5zDQo+ID4g
PiBzdWNjZXNzZnVsbHkuDQo+ID4gPiANCj4gPiA+IEluIHRoZSBmYWlsaW5nIGNhc2UsIGlvdl9p
dGVyX2dldF9wYWdlc19hbGxvYzIoKSBpbnZva2VzDQo+ID4gPiBnZXRfdXNlcl9wYWdlc19mYXN0
KCksIGFuZCB0aGF0IGFwcGVhcnMgdG8gZmFpbCBpbW1lZGlhdGVseToNCj4gPiA+IA0KPiA+ID4g
wqDCoMKgIG1tYXAtcnctZmF1bHQtNjIzMjU2IFswMTZdIDE3NTMwMy4zMTAzOTQ6DQo+ID4gPiBm
dW5jZ3JhcGhfZW50cnk6wqDCoMKgwqDCoMKgwqDCoCANCj4gPiA+ID4gwqDCoMKgwqDCoMKgIGdl
dF91c2VyX3BhZ2VzX2Zhc3QoKSB7DQo+ID4gPiDCoMKgwqAgbW1hcC1ydy1mYXVsdC02MjMyNTYg
WzAxNl0gMTc1MzAzLjMxMDM5NToNCj4gPiA+IGZ1bmNncmFwaF9lbnRyeTrCoMKgwqDCoMKgwqDC
oMKgIA0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgIGd1cF9mYXN0X2ZhbGxiYWNrKCkgew0KPiA+
ID4gwqDCoMKgIG1tYXAtcnctZmF1bHQtNjIzMjU2IFswMTZdIDE3NTMwMy4zMTAzOTU6IGZ1bmNn
cmFwaF9lbnRyeToNCj4gPiA+IDAuMjYyIA0KPiA+ID4gdXPCoMKgIHzCoMKgwqDCoMKgwqDCoMKg
wqAgX19wdGVfb2Zmc2V0X21hcCgpOw0KPiA+ID4gwqDCoMKgIG1tYXAtcnctZmF1bHQtNjIzMjU2
IFswMTZdIDE3NTMwMy4zMTAzOTU6IGZ1bmNncmFwaF9lbnRyeToNCj4gPiA+IDAuMTQyIA0KPiA+
ID4gdXPCoMKgIHzCoMKgwqDCoMKgwqDCoMKgwqAgX19yY3VfcmVhZF91bmxvY2soKTsNCj4gPiA+
IMKgwqDCoCBtbWFwLXJ3LWZhdWx0LTYyMzI1NiBbMDE2XSAxNzUzMDMuMzEwMzk2OiBmdW5jZ3Jh
cGhfZW50cnk6DQo+ID4gPiA3LjgyNCANCj4gPiA+IHVzwqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKg
IF9fZ3VwX2xvbmd0ZXJtX2xvY2tlZCgpOw0KPiA+ID4gwqDCoMKgIG1tYXAtcnctZmF1bHQtNjIz
MjU2IFswMTZdIDE3NTMwMy4zMTA0MDQ6IGZ1bmNncmFwaF9leGl0Og0KPiA+ID4gOC45NjcgdXMg
DQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIH0NCj4gPiA+IMKgwqDCoCBtbWFwLXJ3LWZhdWx0LTYy
MzI1NiBbMDE2XSAxNzUzMDMuMzEwNDA0OiBmdW5jZ3JhcGhfZXhpdDoNCj4gPiA+IDkuMjI0IHVz
IA0KPiA+ID4gPiDCoMKgwqDCoMKgIH0NCj4gPiA+IMKgwqDCoCBtbWFwLXJ3LWZhdWx0LTYyMzI1
NiBbMDE2XSAxNzUzMDMuMzEwNDA0Og0KPiA+ID4gZnVuY2dyYXBoX2VudHJ5OsKgwqDCoMKgwqDC
oMKgwqAgDQo+ID4gPiA+IMKgwqDCoMKgwqDCoCBrdmZyZWUoKSB7DQo+ID4gPiANCj4gPiA+IE15
IGd1ZXNzIGlzIHRoZSBjYWNoZWQgaW5vZGUgZmlsZSBzaXplIGlzIHN0aWxsIHplcm8uDQo+ID4g
DQo+ID4gQ29uZmlybWVkOiBpbiB0aGUgZmFpbGluZyBjYXNlLCB0aGUgcmVhZCBmYWlscyBiZWNh
dXNlIHRoZSBjYWNoZWQNCj4gPiBmaWxlIHNpemUgaXMgc3RpbGwgemVyby4gSW4gdGhlIHBhc3Np
bmcgY2FzZSwgdGhlIGNhY2hlZCBmaWxlIHNpemUNCj4gPiBpcw0KPiA+IDgxOTIgYmVmb3JlIHRo
ZSByZWFkLg0KPiA+IA0KPiA+IER1cmluZyB0aGUgdGVzdCwgdGhlIGNsaWVudCB0cnVuY2F0ZXMg
dGhlIGZpbGUsIHRoZW4gcGVyZm9ybXMgYW4NCj4gPiBORlMNCj4gPiBXUklURSB0byB0aGUgc2Vy
dmVyLCBleHRlbmRpbmcgdGhlIHNpemUgb2YgdGhlIGZpbGUuIFdoZW4gYW4NCj4gPiBhdHRyaWJ1
dGUNCj4gPiBkZWxlZ2F0aW9uIGlzIGluIGVmZmVjdCwgdGhhdCBzaXplIGV4dGVuc2lvbiBpc24n
dCByZWZsZWN0ZWQgaW4gdGhlDQo+ID4gY2FjaGVkIHZhbHVlIG9mIGlfc2l6ZSAtLSB0aGUgY2xp
ZW50IGVuc3VyZXMgdGhhdCBJTlZBTElEX1NJWkUgaXMNCj4gPiBhbHdheXMgY2xlYXIuDQo+ID4g
DQo+ID4gQnV0IHBlcmhhcHMgdGhlIE5GUyBjbGllbnQgaXMgcmVseWluZyBvbiB0aGUgY2xpZW50
J3MgVkZTIHRvDQo+ID4gbWFpbnRhaW4NCj4gPiBpX3NpemUuLi4/IFRoZSBORlMgY2xpZW50IGhh
cyBpdHMgb3duIGRpcmVjdCBJL08gaW1wbGVtZW50YXRpb24sIHNvDQo+ID4gcGVyaGFwcyBhbiBp
X3NpemUgdXBkYXRlIGlzIG1pc3NpbmcgdGhlcmUuDQo+IA0KPiBCZWNhdXNlIHRoZSBjbGllbnQg
bmV2ZXIgcmV0cmlldmVzIHRoZSBmaWxlJ3Mgc2l6ZSBmcm9tIHRoZSBzZXJ2ZXINCj4gZHVyaW5n
IGVpdGhlciB0aGUgcGFzc2luZyBvciBmYWlsaW5nIGNhc2VzLCB0aGlzIGFwcGVhcnMgdG8gYmUg
YQ0KPiBjbGllbnQNCj4gYnVnLg0KPiANCj4gVGhlIGJ1ZyBpcyBpbiBuZnNfd3JpdGViYWNrX3Vw
ZGF0ZV9pbm9kZSgpIC0tIGlmIG10aW1lIGlzIGRlbGVnYXRlZCwNCj4gaXQNCj4gc2tpcHMgdGhl
IGZpbGUgZXh0ZW5zaW9uIGNoZWNrLCBhbmQgdGhlIGZpbGUgc2l6ZSBjYWNoZWQgb24gdGhlDQo+
IGNsaWVudA0KPiByZW1haW5zIHplcm8gYWZ0ZXIgdGhlIFdSSVRFIGNvbXBsZXRlcy4NCj4gDQo+
IFRoZSBjdWxwcml0IGlzIGNvbW1pdCBlMTI5MTJkOTQxMzcgKCJORlN2NDogQWRkIHN1cHBvcnQg
Zm9yIGRlbGVnYXRlZA0KPiBhdGltZSBhbmQgbXRpbWUgYXR0cmlidXRlcyIpLiBJZiBJIHJlbW92
ZSB0aGUgaHVuayB0aGF0IHRoaXMgY29tbWl0DQo+IGFkZHMgdG8gbmZzX3dyaXRlYmFja191cGRh
dGVfaW5vZGUoKSwgYm90aCBnZW5lcmljLzY0NyBhbmQNCj4gZ2VuZXJpYy83MjkNCj4gcGFzcy4N
Cj4gDQo+IA0KDQpJJ20gY29uZnVzZWQuLi4gSWYgT19ESVJFQ1QgaXMgc2V0IG9uIG9wZW4oKSwg
dGhlbiB0aGUgTkZTdjQueCAoeD4wKQ0KY2xpZW50IHdpbGwgc2V0IE5GUzRfU0hBUkVfV0FOVF9O
T19ERUxFRy4gRnVydGhlcm1vcmUsIGl0IHNob3VsZCBub3QNCnNldCBlaXRoZXIgTkZTNF9TSEFS
RV9XQU5UX0RFTEVHX1RJTUVTVEFNUFMgb3INCk5GUzRfU0hBUkVfV0FOVF9PUEVOX1hPUl9ERUxF
R0FUSU9OLg0KDQpTbyB3aHkgaXMgdGhhdCBjb21taXQgcmVsZXZhbnQ/DQoNCi0tIA0KVHJvbmQg
TXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9u
ZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K

