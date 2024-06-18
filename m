Return-Path: <linux-nfs+bounces-4005-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DAB90DCDB
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 21:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A96CA285782
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 19:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270D316D4DF;
	Tue, 18 Jun 2024 19:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Y8x5sgRC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2139.outbound.protection.outlook.com [40.107.223.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1079216CD31
	for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 19:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740240; cv=fail; b=Y6zJSaOmdPKxNLRLdf/1RJML3rexPX+uwMm4EiZrqtplK9qZ6Fyt9a+nmC5P9OerMtIjzu1DTOq2JY2kbqXHepeJ46dkiTn/Tj0NZEN+yTvXWhZ0V5zKJlnnPKfot2EXWdO+W6W5y7iZU98qzid5EUwqD/gJ7ADBdk2YaJ7oDzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740240; c=relaxed/simple;
	bh=gnrCX06sB8FBYrS4qC9a3h9Tw84X+vKRbz4e2osOemo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o0pebYNrRuLI892PpUMvrapOUz4pcnliUxl8AMT65z0ztqBwlhKezLUaEo2hpRQxkV5seGnuaUklAouBu0mK0hWt4ZHWO3nRoAaxgscarUZAL6sry2qe9c4Uq5VmQb4Rc4v3depx52QCbUciUbw6BZrgvuG4syq5WH0xpaGcJ1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Y8x5sgRC; arc=fail smtp.client-ip=40.107.223.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKcyfIuL/2b4oqwffUqTHw6AsCL2senMWW5456f8v0J0y967jdzdSrQjc2co6fJNZujRslVhOMmRXKT1haW8AR1aj/JWN+73FGPk2IK/b+hd+5l36u3z91TVioYzTpUJWI4sSuScbd/LlR+tmK1YuUXbKDEw59WOccw7sLuZw/MKROT9vSfDE+iPhY3i2Ayp4lGRMgcjOkjDJIi6kNwLF62MuxsBaxFRMmiHeq2tLUpVNgK/UP4NjYLJ08ABFn5/PkK30EqSBYAwrjSHcFZzDv0DKDj+KttD2f4JjgKxoRmmW2sbWjtLAoUcC0zXbhcUwUnWpZxdca6w9sQRqTMmWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnrCX06sB8FBYrS4qC9a3h9Tw84X+vKRbz4e2osOemo=;
 b=UGlqpK41uZS6Eu/WqyJAnLpsk1zwOolijIVV3qg6I+KpogEmKrtufWDaDisZpPvQ7aiHa211pcL1LXt4LgoT8/dIbSvOsL+H8PNFXG3jHHFyAZF2gHy38JFqHS1ISrPs1S4vWKOa0orTxTX9rjlKXVpgfNGx5YgQAuyfh9KMLd2EaadvITYJ6bGh2Nq2EtQIET+QR2B3duUl2G9UU2kBLCAn55xIU0+lYJngjabLoRIYImASrB7F3mBx+A+9leeUAU7ODFqRCm5GAoVfzo218TLeogVC0Q4w9Rd1D/qRfR+7TwM91PhhBWKySK3RX4fHQOrs38tUrucbOZhDrosmPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnrCX06sB8FBYrS4qC9a3h9Tw84X+vKRbz4e2osOemo=;
 b=Y8x5sgRCC6RfpSViVpItxOvNf9HqpdUm8KqyVwXLv+mgOdrkwe46sjegWmJg8/f8+MoGd07iJFLO2P9zh5JenkYAjchdZC7GHE52yHU+8mz5+95NnZZgh6IA+U0XuDaTIz1jreAAX9LDYZGJGtmH5cQCuLLJXCfGh7FyB8kVIs0=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MN0PR13MB6801.namprd13.prod.outlook.com (2603:10b6:208:4be::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 19:50:33 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%6]) with mapi id 15.20.7698.017; Tue, 18 Jun 2024
 19:50:33 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"jlayton@kernel.org" <jlayton@kernel.org>, "neilb@suse.com" <neilb@suse.com>
Subject: Re: knfsd performance
Thread-Topic: knfsd performance
Thread-Index: AQHawa3dybcUo3ed40e1woBUDQls6LHN2rIAgAANu4CAAAKdAIAAAygA
Date: Tue, 18 Jun 2024 19:50:33 +0000
Message-ID: <70766c4bd70742d0da79be50ebaf2eaeb7b18559.camel@hammerspace.com>
References: <313d317dc0ca136de106979add5695ef5e2101e7.camel@hammerspace.com>
	 <58A84B36-C121-46F8-ABCB-BE4F212E9C81@oracle.com>
	 <754f3e0f6f962cbd46b2b22e87d9de9f8b285ab4.camel@hammerspace.com>
	 <7FFACD6E-86D2-4D14-BF03-77081B4CFF38@oracle.com>
In-Reply-To: <7FFACD6E-86D2-4D14-BF03-77081B4CFF38@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|MN0PR13MB6801:EE_
x-ms-office365-filtering-correlation-id: 766474a2-d95f-466a-ebdd-08dc8fcfea88
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|1800799021|376011|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?WnZzVlpieUNaTERNNWY5RzdXUXBDdys2VjNmclY5T2U0alZSTFRNQXZRR3R5?=
 =?utf-8?B?K2VodERNL085Smd4NjZnYnZFcWVxam8zYmIvT2kxb1ZsdUhzVWFVSEtzYmR2?=
 =?utf-8?B?clI3WUZOcTlTYVhJZ2d2dXhlOHBNRDFnUEFFN1lXajlOdFN6Z2lPMjQ0SENw?=
 =?utf-8?B?cXFyQjcxUGF5UE5UZFlOcUFkOThNbitWRVVUS1dRM2hpNWRHTmdkUlEvcldM?=
 =?utf-8?B?R25UazNTbDBiOVV2djNncm1PSmI4clFoT3NRanpBMEtOWHp3LytMOHNsNjYr?=
 =?utf-8?B?ZTBiZmwvdHJUaWEvZTZUREN5akwrdkRsTFZoUUJHYmFqakRPUEpDdWxScEtm?=
 =?utf-8?B?dXBnQnJXVGwxNlR1R2pBcXJOK3dEVTJKODU4L1UzZ29USlJZanE2K1lINE9y?=
 =?utf-8?B?R2ZWOW5YUGhQeENuWUprNFlOdnRDcmI1UWlCdWRCUHIyakVSVjhsSzNmV2hY?=
 =?utf-8?B?TjlCRmFYcElBNEhZandNZG54Wi83Z3ExQ3VyOWcwZXM1amlkd0tNeTdDbkRh?=
 =?utf-8?B?cElmZFVKWEY2dnNTL3dPUWNXUXhNeWVUd1hLb0lYRVpHZEg4V25HbE5UNzRk?=
 =?utf-8?B?WXhaNmsrWjdHNFg5VEJPSXRpWVZXK2phb092NmErVGFhTHRPcUpjTHRhWU1K?=
 =?utf-8?B?Z1JWcVY4bkdFUGVRdEt5QVRGTTAyM2RuM3RVWjh1RGhkaUU5TTRlUzZmWkVD?=
 =?utf-8?B?ZUprY3B5bFZYSzdocWJWSE1haEU3NUp5dXRQczk3TVRwbmxXMFF4QUJtV3h0?=
 =?utf-8?B?RzBVTmM1WjJSd1BnRklhMlR6VzdOMVEwQnVPOER3VE9iR1JKTnRVRlJxRkZm?=
 =?utf-8?B?RFZFMWNINjVMZDFYREVEVGY3U1hFcmd1aEV5cGxQSFJQanJpVEFzMXF5OXhl?=
 =?utf-8?B?MWNqYURKNWhsY0NnaEs4ckhNc3dIVjNhYlRWL1FEVks3MUxyajlsQWc2MFF0?=
 =?utf-8?B?UlVWeW5wZzNTTGduUFlVQnF1azhaQ2lOdUhwS1JtLy81bklWWWdtTmVBQWwz?=
 =?utf-8?B?N3htLzJSR2QvNDB3NTUyQ1ZvOW1hYzY3RytqU0ZFUVZKWlQ1VG5lcFZnSGNQ?=
 =?utf-8?B?OE9sV2J2S2NYMzNHNHh4ekhoU3ZsQVVKRmNPV2FmMm5Ed1A0TzVvQkMxb1VQ?=
 =?utf-8?B?cTUyaUtRbVdyczBobk1RcHR6Qk0rcUc2RVZnZWFQNmpzcjcxSHB0ak9WSkdt?=
 =?utf-8?B?VkJLNElNTyt0NkRndmpwbUxiUkNBQ3BnTkRyeE5pdjMrRTh6cFM5NTE0ZlVn?=
 =?utf-8?B?NFRvTXIvOGdaWm1PZWplNHRLRVQ3Mmg5Mkkzd3EremtKZkxpV3Fna1g2eU81?=
 =?utf-8?B?NXZBNkx5dVhycGNqUW5vZk5PcEcvY0NKUjh1RzhTWjNDSnhqejJPelphMG5j?=
 =?utf-8?B?a3d1dGFBREJsbmJlcUdSNi9zWnBOdys2YmtuekN1UjZWQlRmQk50N3lHYWIx?=
 =?utf-8?B?VWZEOFJrNzBwUWRzTGk4dmoxN09HSnNsTHFneHpQNDNuelR3RStNSm16TWdr?=
 =?utf-8?B?eEFXWEFUY3NyOW91VUo5NGNhQ2huVW9BWW5qN1YrRERGcXJYOHVxSUtMTHVU?=
 =?utf-8?B?RU1ZNUIrWDlUcDAxeU92OVA4ajJyeGZnZXBDYWpmU0JMTWdPc3VvRVZSN3lh?=
 =?utf-8?B?OXluZ251ZmV1R3J6UTNQenRiekVqMnRZZXNPRGhENy95bkF2NmIwaFl1enNX?=
 =?utf-8?B?MXBiQzdHWkVub0pPdW9HbFc5cUYrRHRvUEdWcG5YczVGMmJ2MkcwQ3hDazhG?=
 =?utf-8?B?b2ZTYkR2ZERQT3Z2YjlVM3BubkRqVTdjWDA4UFVjSkVBUER6Y1pyUkxFaXR5?=
 =?utf-8?Q?9Dm3q9Pgkw5fmfCSRPY+H5TRbRhZnCs6VExRA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b0JpWW5qRFErd3h2L2VXcGRSbTg2dllNeXNMOVkycEh6MkRkYmxjWGFLZGI4?=
 =?utf-8?B?V21HeDlNUVJTdE1oVGZObmpHWXVQcVB5N01PNW4ycm5lT2pRSkpMMm80dkNI?=
 =?utf-8?B?dGxtUHAxY25lVkN1elcyT0s4QVRBU1M1TVJhL1owcmc1Q2NqWWJGbE50SWNi?=
 =?utf-8?B?K0E3WDNSQXRoTUgvbjJ3M2hONE44QjRDSlh4bTBYYVdaNWRBRVpDTVVCSCs4?=
 =?utf-8?B?YWtyV3VkWHAvbVFSdFkxWlhxbXFVMk1pYkwrVG15RzZVYXh2U0ZKTmEyZzJz?=
 =?utf-8?B?UlRYckt0Y1dqejQ5WU5ZUHNCd1AyTEkwdW5IRnNRQXA1cnd5NmVTWFdEYyth?=
 =?utf-8?B?UVB1SGRmRTB4R0dDK1dqUGJpVmR2ZU52d3ZXZExvWVkxUmFaNlREN0lhd1NR?=
 =?utf-8?B?NG1PdVNoYklqSHZVZDZzWkl5R0ZyUkJYTmx3eHVOWk5uRHlFYzZ0UjVtbUNI?=
 =?utf-8?B?a2FPVzY3bnk3YjNxdmxGNjZpNU9JKzhQREVaZk4wVmdUTjhkVUg0YitWZkJj?=
 =?utf-8?B?dnhCV1g2c3FaTm1XZ3FVV0s2MHlnS2FqUDA4MEI5aFVCNzBKV1JNSHk1NHBm?=
 =?utf-8?B?WW12ZjRzQy9yVlk1V0N3cHpTME5Ka1ZwWWxyd1R5SExMYkF6OUxzQTlOZ09Y?=
 =?utf-8?B?Z3cyWjFvT0lTSzdMQjFTdUxybUdpSEYzRXVTcDNhbWhlSXVkL3FvZTgyaWxE?=
 =?utf-8?B?dGlwSFoyWFg0MERyYWx1NERWcHdoblY2elVCZjVCY0pnOVdxSVRMdWJBRTNR?=
 =?utf-8?B?a3R5WXhubGhoMWxFcEo2azMwOCtQQnVKVWNDa2ZaNWUyckNJMzZJOWMyNG5R?=
 =?utf-8?B?dCszaEZwM0FmSi9vd082L1ZZa1lCTDR0a1FEaEkxSjFMWWRZNlAyTk1PNkcv?=
 =?utf-8?B?K3VZS3A4OEdjWXJwWHYyLzl3UFF5SWhVeklhTmdmbENiNDJBNmJ6WjIvS2R4?=
 =?utf-8?B?R0QwWDRkakpmaW9sQXRWUkh3NXFlZlVZUGVOYlV4OHVxNlhySk1Ja0k4eVdi?=
 =?utf-8?B?VXF4Rit1d2pLSmMvZHI3ZFl4aDhadUlPclBxNFcrL1ZlTlNvUUwzR1I5Rm9h?=
 =?utf-8?B?cXVybHVUdXNvejJJWEZmVENpK3JJWkFKZThIZzZpbUtxcXZZN0RwVEZWanpC?=
 =?utf-8?B?RndlREkxbXNQRWkrQkRsZE41SlptRm1RNGN4RDFPaDE4Z01McC9ZMGNrcXF1?=
 =?utf-8?B?SFErWFV4SG0vMWQxdkJ1S2FTb0ordWlsdTdNTkJCT21zMzMwc1hxRFBQejRH?=
 =?utf-8?B?ZGhsNllBNW5MM1JLNlp3N294Q1ZxVlhqbFBPZS9HQWo1UjlMdFRNZTVtMmRa?=
 =?utf-8?B?Ny9NWUJJNmpYNXNuVW5aME1sQXlWVldxdUVVNjR2M0E5d1QrTnJpaUREQTJ0?=
 =?utf-8?B?UWV3a2RrWFJhNStUTXk5SjhNbUt5bEhIczhHMmNkaGhYS052ZVdYQmszeFpQ?=
 =?utf-8?B?R3QzUk9Rd3gxanJ4LzhQNHNDKzNUek5rQWg1bnZ6SkRXRERRVmMxRm5BanZK?=
 =?utf-8?B?YTQ4b28yT1lOK2tnM243MG12TmJ4OEhPSTdsWFdYV3ppemV0S1lhVDlSVTZ4?=
 =?utf-8?B?ME1jdXJZbm5OMjlGcWNNMGllbnU1QlJiR09kY2ZiVEdrWDdCTzE4bmdaZGND?=
 =?utf-8?B?Vk12eWExaDQyQlM3QXFuT29XUHZ2dllhd3hKTXByQldpUjlOQlNuNy9aMjNE?=
 =?utf-8?B?YzVOdXVMdzVuRjBMaW05WjJXR0FlcXI3bnExMnl4eDcxNmgyLytQNmJ0UVRB?=
 =?utf-8?B?aEp3dWlRVEZDRThXcElGTnVRY1EweFFyWTZ4NGNHTXExUUJ2RFRrUVhreXor?=
 =?utf-8?B?Ly9kNUFWcnFqYjUxVWdBQTl1QXNUMEdtS0xGMTBqUXV3ZmQrTFFmRXVsZEgw?=
 =?utf-8?B?Y0RicWhWTEh5bVB6QUlGdDAzQlJsdXc5ZG1ZSzhadm1SeHM5cFBsTitNMkp6?=
 =?utf-8?B?SU9BYzdob1N3cTF0UEYrVmtBTDR6QzJRem5WSFJyTHQ0dWVROExEcGNNZlhY?=
 =?utf-8?B?eVF1TWRJbnAwWDdHcGtsQUduc0IwK00xY2NnbHVyMVh2OGZkZllZbjFPclhI?=
 =?utf-8?B?aHQxNnhLNFp4UjZiamVqQWl2VUsxVmtoZVQ1WDR1dDZBNW0vMWtwSEh5MGFi?=
 =?utf-8?B?YmIrYVMyb3dnQzF3Yjd4SjRLZzBHcTVXN1I1K1BEVWtqakNjaWREemx1dXY4?=
 =?utf-8?B?S2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <683357B53D6E9D43AF011642583ABB3F@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 766474a2-d95f-466a-ebdd-08dc8fcfea88
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 19:50:33.5232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zWXTc4uDhXA26iWxsHVFpZU1bN7NZ04o2QnVKfKQJF3x3/TX6M72JHU52QijiFGkMFhp0sw2y/nmiivWYZtUMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR13MB6801

T24gVHVlLCAyMDI0LTA2LTE4IGF0IDE5OjM5ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBKdW4gMTgsIDIwMjQsIGF0IDM6MjnigK9QTSwgVHJvbmQgTXlrbGVi
dXN0DQo+ID4gPHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBU
dWUsIDIwMjQtMDYtMTggYXQgMTg6NDAgKzAwMDAsIENodWNrIExldmVyIElJSSB3cm90ZToNCj4g
PiA+IA0KPiA+ID4gDQo+ID4gPiA+IE9uIEp1biAxOCwgMjAyNCwgYXQgMjozMuKAr1BNLCBUcm9u
ZCBNeWtsZWJ1c3QNCj4gPiA+ID4gPHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4g
PiA+ID4gDQo+ID4gPiA+IEkgcmVjZW50bHkgYmFjayBwb3J0ZWQgTmVpbCdzIGx3cSBjb2RlIGFu
ZCBzdW5ycGMgc2VydmVyDQo+ID4gPiA+IGNoYW5nZXMgdG8NCj4gPiA+ID4gb3VyDQo+ID4gPiA+
IDUuMTUuMTMwIGJhc2VkIGtlcm5lbCBpbiB0aGUgaG9wZSBvZiBpbXByb3ZpbmcgdGhlIHBlcmZv
cm1hbmNlDQo+ID4gPiA+IGZvcg0KPiA+ID4gPiBvdXINCj4gPiA+ID4gZGF0YSBzZXJ2ZXJzLg0K
PiA+ID4gPiANCj4gPiA+ID4gT3VyIHBlcmZvcm1hbmNlIHRlYW0gcmVjZW50bHkgcmFuIGEgZmlv
IHdvcmtsb2FkIG9uIGEgY2xpZW50DQo+ID4gPiA+IHRoYXQNCj4gPiA+ID4gd2FzDQo+ID4gPiA+
IGRvaW5nIDEwMCUgTkZTdjMgcmVhZHMgaW4gT19ESVJFQ1QgbW9kZSBvdmVyIGFuIFJETUEgY29u
bmVjdGlvbg0KPiA+ID4gPiAoaW5maW5pYmFuZCkgYWdhaW5zdCB0aGF0IHJlc3VsdGluZyBzZXJ2
ZXIuIEkndmUgYXR0YWNoZWQgdGhlDQo+ID4gPiA+IHJlc3VsdGluZw0KPiA+ID4gPiBmbGFtZSBn
cmFwaCBmcm9tIGEgcGVyZiBwcm9maWxlIHJ1biBvbiB0aGUgc2VydmVyIHNpZGUuDQo+ID4gPiA+
IA0KPiA+ID4gPiBJcyBhbnlvbmUgZWxzZSBzZWVpbmcgdGhpcyBtYXNzaXZlIGNvbnRlbnRpb24g
Zm9yIHRoZSBzcGluIGxvY2sNCj4gPiA+ID4gaW4NCj4gPiA+ID4gX19sd3FfZGVxdWV1ZT8gQXMg
eW91IGNhbiBzZWUsIGl0IGFwcGVhcnMgdG8gYmUgZHdhcmZpbmcgYWxsDQo+ID4gPiA+IHRoZQ0K
PiA+ID4gPiBvdGhlcg0KPiA+ID4gPiBuZnNkIGFjdGl2aXR5IG9uIHRoZSBzeXN0ZW0gaW4gcXVl
c3Rpb24gaGVyZSwgYmVpbmcgcmVzcG9uc2libGUNCj4gPiA+ID4gZm9yDQo+ID4gPiA+IDQ1JQ0K
PiA+ID4gPiBvZiBhbGwgdGhlIHBlcmYgaGl0cy4NCj4gPiA+IA0KPiA+ID4gSSBoYXZlbid0IHNl
ZW4gdGhhdCwgYnV0IEkndmUgYmVlbiB3b3JraW5nIG9uIG90aGVyIGlzc3Vlcy4NCj4gPiA+IA0K
PiA+ID4gV2hhdCdzIHRoZSBuZnNkIHRocmVhZCBjb3VudCBvbiB5b3VyIHRlc3Qgc2VydmVyPyBI
YXZlIHlvdQ0KPiA+ID4gc2VlbiBhIHNpbWlsYXIgaW1wYWN0IG9uIDYuMTAga2VybmVscyA/DQo+
ID4gPiANCj4gPiANCj4gPiA2NDAga25mc2QgdGhyZWFkcy4gVGhlIG1hY2hpbmUgd2FzIGEgc3Vw
ZXJtaWNybyAyMDI5QlQtSE5SIHdpdGgNCj4gPiAyeEludGVsDQo+ID4gNjE1MCwgMzg0R0Igb2Yg
bWVtb3J5IGFuZCA2eFdEQyBTTjg0MC4NCj4gPiANCj4gPiBVbmZvcnR1bmF0ZWx5LCB0aGUgbWFj
aGluZSB3YXMgYSBsb2FuZXIsIHNvIGNhbm5vdCBjb21wYXJlIHRvIDYuMTAuDQo+ID4gVGhhdCdz
IHdoeSBJIHdhcyBhc2tpbmcgaWYgYW55b25lIGhhcyBzZWVuIGFueXRoaW5nIHNpbWlsYXIuDQo+
IA0KPiBJZiB0aGlzIHN5c3RlbSBoYWQgbW9yZSB0aGFuIG9uZSBOVU1BIG5vZGUsIHRoZW4gdXNp
bmcNCj4gc3ZjJ3MgIm51bWEgcG9vbCIgbW9kZSBtaWdodCBoYXZlIGhlbHBlZC4NCj4gDQoNCklu
dGVyZXN0aW5nLiBJIGhhZCBmb3Jnb3R0ZW4gYWJvdXQgdGhhdCBzZXR0aW5nLg0KDQpKdXN0IG91
dCBvZiBjdXJpb3NpdHksIGlzIHRoZXJlIGFueSByZWFzb24gd2h5IHdlIG1pZ2h0IG5vdCB3YW50
IHRvDQpkZWZhdWx0IHRvIHRoYXQgbW9kZSBvbiBhIE5VTUEgZW5hYmxlZCBzeXN0ZW0/DQoNCi0t
IA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNw
YWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K

