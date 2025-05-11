Return-Path: <linux-nfs+bounces-11658-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1FDAB28DE
	for <lists+linux-nfs@lfdr.de>; Sun, 11 May 2025 15:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C28D93A20DE
	for <lists+linux-nfs@lfdr.de>; Sun, 11 May 2025 13:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABCE22D4E3;
	Sun, 11 May 2025 13:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="bYH7WoxK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2105.outbound.protection.outlook.com [40.107.96.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D9A78F40
	for <linux-nfs@vger.kernel.org>; Sun, 11 May 2025 13:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746971343; cv=fail; b=MV2S/8VR2ZVW0HvZ7Dx3kFBQkUbx3ixQ+8aIR2xMGuKRo+ohDv6VBXqQErJOgf11drYJkHtTXc6B3Gw2WDFOhVXX+IzRHmL1dqocmzL0P4U5BYQ9w38P00hawOF9plAmcq2CdhmBujPyfIn0iPriHsgx0sqq/WCPooPmy4+kwd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746971343; c=relaxed/simple;
	bh=y9wP+aLHR14FoEPNKAqqTXSduQ7FUu5FTyucVjXt07U=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qEIMS9pK0vGB5PTBY7WqDFliX515dy810NvJJ9q+HXfyipobOaKKHTq+z47vs2GbXxUnfUJW+GiVMGcaq7TSw7JbX3A3D06DaOpg/a2tKIPYHh9iPLY4qVJJQK+DSyfDI9WaX6qoRO7/EEksOe4GtOh5wIcw7EDDiTNjJFo3Gvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=bYH7WoxK; arc=fail smtp.client-ip=40.107.96.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUd0XIwqiJ/dKBUAgCvo/ZrzyhXgQ6eT9uWC5qKu+TbT3S8PpQZfG8YHX0N8J+4Wmo/znGF5n0fReyv/Rv7kxwCjc+Lor7ONVyuUoy77L77aMEGzl03YsjeR2iLiSpElHbHesuiMqNd1GcHo3hOPRi/9ANfatmIIZNMWpKcP3QsABDXl7rfOEsK9SF1rqW4qd84cPkWIGTNBTRe1/C5bFnl7sLdBdVLb0rLjTBzS4HOKSPxuaKvyMw6WKbyyCF2ZtKTblXiX3GV0dagX8VOMGwRe3kv5DQvenjIJWOMXj8JAdKSh6k5+ijBMOSjUqrCXZ97qw5p6WOME9JT69pfqcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9wP+aLHR14FoEPNKAqqTXSduQ7FUu5FTyucVjXt07U=;
 b=gNxw6JxpXwhGMfIMoyd3IF3tvfS4CYh99neIwrNmRFjuQdX2NCFcII4eg2Bj7BoD0060WIFTV1JXbKv/DUd3q/SjS7FFEAu4cj7/8OxVczpVqVRyh8FZmRXddJ5Wb4KGSFqD0Yjtw4KuYUWHrdZJOpaDe4aSQ7leI/3CJTUvYHlytQuzrqE1bmz7mHFAFrKT3dQupjGweL2obnMA447386ykfqv9L337j/mZ4ZPjN5oL2BIEXM+0BVf3qO28qnPC8l0fxCrphprwQ+/SmycMCxFmGwqtUNfZ90lGpWOqXgTVMm6hY/PFXKIJfmU8rAZsT14r/kOOrUADPCrLavUtow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9wP+aLHR14FoEPNKAqqTXSduQ7FUu5FTyucVjXt07U=;
 b=bYH7WoxKcvdOaAu1N3ii77CBtxEWfmpZxVlQILP1pv1OJ+baPamYon5RXJwj07lRQSxoxp+85rC8Z0zhQHGmzQKdWh8SP/FevwJlDwlaeLyqVETwy7ZH5uebYfVmCBrdeOT0ca/jpDsTgj2v1LK2x5WKwMOm72vCR/KxrDvcTZc=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BN0PR13MB4696.namprd13.prod.outlook.com (2603:10b6:408:121::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Sun, 11 May
 2025 13:48:56 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%7]) with mapi id 15.20.8722.027; Sun, 11 May 2025
 13:48:56 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "osandov@osandov.com" <osandov@osandov.com>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "jlayton@kernel.org" <jlayton@kernel.org>,
	"clm@fb.com" <clm@fb.com>
Subject: Re: [PATCH] NFSv4/pnfs: Reset the layout state after a layoutreturn
Thread-Topic: [PATCH] NFSv4/pnfs: Reset the layout state after a layoutreturn
Thread-Index: AQHbwnihi+d3mg9/R0KcvwzlM9JAHrPNce0A
Date: Sun, 11 May 2025 13:48:56 +0000
Message-ID: <67c41c84df54b67c0dbbe01dc1076a4070eb5e82.camel@hammerspace.com>
References:
 <956259d72ee10ad81fd49daa8f2daf12644dc50f.1746970063.git.trond.myklebust@hammerspace.com>
In-Reply-To:
 <956259d72ee10ad81fd49daa8f2daf12644dc50f.1746970063.git.trond.myklebust@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BN0PR13MB4696:EE_
x-ms-office365-filtering-correlation-id: f8e5ac95-3438-4ffa-c732-08dd909292e8
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QURmTk0wL1V5VTA3UnRmSlZYVTZER0orb3g0ZW1KeFV5ZEF3WFp2WG9KU1lE?=
 =?utf-8?B?Z2hGNWd4Rk1OVC9vRVNDTXhlcm9hQ2FSRDdQcEFQZVltUFVsVGhORjZEOHhQ?=
 =?utf-8?B?SC9RN1hkMk1jVy9FWXIvUnNNTWlUMkFJR2dYY0xqMlFPTEJ4SFFKUUZZckNE?=
 =?utf-8?B?L0lrb1kwUFRNQTFlMG9MZVROZUpyc0xzZExxekpDWmVmMnpmVGx3N1BRUDg5?=
 =?utf-8?B?Wi9YTjJ6WlVmNlZMVGNKbm04OWF5WTh0aFNybjBSWDJtK09wRkpOeUpVOE9J?=
 =?utf-8?B?OTg2aDZrQldVRDhQdVZVMGxVa2FHT1UrSzFFZ3RhS2JwTm03Zm5DcUpMMjRM?=
 =?utf-8?B?Vk1yQlhEWFlhQm03Q21wVUZ2TURyS09lU2IxanB5a1lOOGdKSUpHWC9nWVh2?=
 =?utf-8?B?N09EZVZwa0VvbDQ1aWIrZkNXSXRFTlVjMXQwcnMxWjRES2NoeFVpWXowZ0hj?=
 =?utf-8?B?eWRpZERYUGo1NHlZN0lxYXVjbWZKNmJ0bnB2aE43MDNSMzZnRmpNVHpud3NR?=
 =?utf-8?B?UUlSSzFWUW9yVW51QW5pS2VxbWYvbnBFNVNBL1llSjlZQUYzcXBtWFc3Rzhw?=
 =?utf-8?B?QjdjTHpLNTZBZXA1SDk1WVJCOVBOcitETzQvSDhIY1g0SXZBVC9ab0JoU2RV?=
 =?utf-8?B?QUNqUFdWeUVIaFRQSThuYXFqRUExSUlOREdoM0QxWTV2bFM2algwSnk0UzNs?=
 =?utf-8?B?KzBnNjhyMDJ3ZUtnNmxqRjZwMHlMM1ZSa3M1OTJiZ3c4NjhvK2VkYy9acGFQ?=
 =?utf-8?B?RWRWeWFJQXBtYnJFVUhma3lsZ1pKUUlYK1N1M1BPVnhNcGUySHJhY0FHcldN?=
 =?utf-8?B?TEJIeGdsbU8wVzRkRGJrQ1ozS3ZrSVFxZ3lXOGV6bVM2aVlVK0tjbGhoOWQw?=
 =?utf-8?B?cldGQytLUDEwR2dCUGJtMTdweWtyMmhDUE9YNHBCQzNkcjE0ZkhYd0ZHU1ll?=
 =?utf-8?B?TFNuL0M4c3dyaGVqVFd1WUROWmlGalRYZEZpVVkwYjhVTVc3UVFhL1lGVk9u?=
 =?utf-8?B?Mlo0YVBYM2s5Wm1OczNTaUJQSDBMVEtuUXc4Y3diWDYvOHJ3MXBhZjdCT0xl?=
 =?utf-8?B?U3VrcmFCc0k5RFdaNCsreEVlVktWWkVQRExYV2tjd21GdU42SlpJdGJjN0dm?=
 =?utf-8?B?aGVxT1lmR3NVUnlGdU93V3dxbmNKb3RkUnF5Y2tyWnRMS04vNEx0STl0bTZN?=
 =?utf-8?B?aCtqS3ZmbkhrUk5zL3ZWZlltdmZ0SDNiWmhaUGYwLzRHN3BDS0t1bFlyeTNX?=
 =?utf-8?B?ZWFVMTVPN1FJRkVYZVh5WU9nUmwzSWdreUNxRmtQelI5MjlOOGV6WGNCNDFv?=
 =?utf-8?B?RFlDTHh4N0ZVY0UvbmY4RUJpT3RhV1lUYVZtZlpSdnp4NHlKU0E0M1VoaVBO?=
 =?utf-8?B?Sk1QWWxFMlJ0SG1DaUwvRnBBZ2tKNHFsQjlzaFR2RWFxcUZJUTNRV01mWjVZ?=
 =?utf-8?B?U0V1TVNSVmk2bnJEYldlaUZPeDhJTW9PNXFSYUluWEhYSm81RUpJZHp4citl?=
 =?utf-8?B?RktoOUtIK283UUFJU1p3anR5aGhXbmZjOU8xWFBXbERoZE9zcUx4WEZEZkhG?=
 =?utf-8?B?TTFMTDAzdEltZE5uWFhZVkdjZVBUaFBzZW5jdERSRWNNV2xKaWdhdjFiOXRn?=
 =?utf-8?B?Qms3SEJMejh1UVBRaFBSdjk4MDdWcVI2RndHV3NIRVZqalFEOUhFd3doQ1dr?=
 =?utf-8?B?WTdwNXZPVmpZTCtCclg4Vmw5RGRNZVFqcE95QzV6OWtwaDNadUZxejgrd01q?=
 =?utf-8?B?L2Qzb2hacnBaTjNXMHJEWlU2eFZ6dHkxbkhtbFI4dDNhd1pZcy9SM2V3Sm9G?=
 =?utf-8?B?RWZCT1J6Tm9nY1lyNFJPMEtITmw2R3YxRHlLak4wWkJBdFVMU3VQOUZDbjBp?=
 =?utf-8?B?MDJZWm5sV25DTTBybXhBdHhUdVR1eDYwOWdoV2N5bWNvbkx0aUpEWFl2OHBz?=
 =?utf-8?B?R2VscW9ieUZXcUZiejlITDFiRENpN0dWRnZuSEpqRmMrSVc5YzJwMEswWlBF?=
 =?utf-8?B?S3NIV2tsMS9nPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?emlDViszbmxVa0N3K0t0OHd3SmZZbEVBZ3VRQjBpb3htR1ZhbW1ZamFKUDdr?=
 =?utf-8?B?SjcrVVNGbUhsVzBBUEdvS0FpOVhqYitVaFFJczhMU2sva0kxSVNKYi9nbE9a?=
 =?utf-8?B?RmllMDVhdXB1TFdvWEVCNUVWdXZ2Q2Exak1XbDU4L1dNd2wrdzZ0RlR2Mmdr?=
 =?utf-8?B?RzZPZ2NuZVNneTVxc3NKWmFOTm5WdEJzN0F6V3BQd0U5TnBiRkMzbmNvUDRj?=
 =?utf-8?B?WjFZVHc5cEpzdk5NRUlrOEQzTURBTHFVazMrd0xBU2FqMUp4SERmNHlXMkY2?=
 =?utf-8?B?NHY1aGtiR09TcUZrbHJzVTVoMnQzTXdUejFENHpYWjhPVVJMdW9pZEZ2bXVj?=
 =?utf-8?B?RG1jNzZaTXo5eWtlaTZVUVcvaStxdnM5b3daaUJuS0V1UWtmdkpSc1phUnVi?=
 =?utf-8?B?NEZBWHFZQ043eHNVL0RaaHhSaUMvbDlLMG00eFpjV1RFVjl4a2VZNjVRSXNl?=
 =?utf-8?B?NUpYTmxJOXljc1pNUE5DeG8yWmgzWU1GVVoyU0txVzdtNStrUzFWZC9zT0Fr?=
 =?utf-8?B?aVR2YjU5dGFLV0VxMkk3SkRTV2pnblJUK1pBMHRVbjZHUTJiMFhlbmJQcE4x?=
 =?utf-8?B?eUQ4cEdWZXRJQXFRaEEwVzdZa3pKSlZqaklhNTlkR2ZCWGVlVkJpYWNxcHVL?=
 =?utf-8?B?VC8wWU1rYUY4U3hkNmtYUkEwdlA5TjBGM0FiT09TK2pHd2d5aTdYWXJOeGww?=
 =?utf-8?B?ZWI0bklTYUJHbVRWWElVVU9sa2FzQWw5MHZhbkw2cTdOSEcyNXBzQVhHREx6?=
 =?utf-8?B?L3JHeHhOaHcyTXVMTnEzb3cxLzFDa3kyREc0Y09oRTJMNDEvM1o4V1VxVlE2?=
 =?utf-8?B?dDByeEQ3OTU4a2N2YitOaFA2RytZYW9kYTZ0a2VpRkRzbXB4b0dEeHpnR21y?=
 =?utf-8?B?Vmozbm5zS1kxQmJVTUlJd0grelB2aHN3ZVFUS0JRbjZmVmlKdlhOV2FhQTBh?=
 =?utf-8?B?OGpWUmV5WVlGQUdNTlE4UENmRmdEMmNGUFdBTVFJQU1ZOHVjV2ZKcHNPYnZs?=
 =?utf-8?B?UmhBQStROWRwVHZGR2N6Vm8rVEQ5dHRNYWtFRGJCOWhLM2ZoWmZ4cGVaMkdy?=
 =?utf-8?B?SXE5R3RuNW5wbjU3bmZRb1hGVzlFM1dzWjNZWlFta3piOFc2eUpSWG5mRFgy?=
 =?utf-8?B?MWxhQjVuTHk1REg2dWEwME5LWXd6djBvcG5sUVFqdVM0a1Zvakxrd1RmZkdn?=
 =?utf-8?B?aThrQWRTRjk4OHh0MlNrZ1EwbUlpeC92NkxiTHVpYUdKMkxudFJPZFMzRnRQ?=
 =?utf-8?B?dDN6a2dKajFZZ1cvV1JQZzJtZnRYNkRWU2MxL0E0WEd4di9NMmJKK0o2SFlz?=
 =?utf-8?B?TUViMXBXb01SQ0x3TGkzclJEWFp0STJhR3BibDRQd2tNT3M0VkFaYVdDMEhW?=
 =?utf-8?B?TFNLbzg0c1BnRE0wSFpmS3FURitibUpFWnZzcFBIK3lPTk4yekQwU1I5MTlt?=
 =?utf-8?B?TDdVSkRDRmdzRnQ4RXpnSzlEUFA1U3MwV2d2U2t0clBPaThOTWVNVFBWcTlp?=
 =?utf-8?B?K3BaSS9VR3J2cmcvRHFGUzJvUzRwdFh0OEN3YlAxS2I1RTJLSzZTQWplbGlo?=
 =?utf-8?B?eU4reHYxZXJvdCsyUjlWUnM0Nk1pbTZEQzhsWHJsci9FZG1UMlI1dzZYMnJH?=
 =?utf-8?B?QmllVGJYbExBOFpkVU0rUjQ0R3dENnVUdFp5aWJqdEk5SnNjdFBGNWFaWisw?=
 =?utf-8?B?RXpNcEpPb0RycnZKVjBDSmN4MWFIZGQ5S2RtTnJUL1FKNkVRMElWMFVSQ2FU?=
 =?utf-8?B?SThqSFg5OThJeGMyMHY3aVF0Lzk5UlJKcE5BV2dxU0lSUXB3d2tuVGRuZkpW?=
 =?utf-8?B?MGhIQ2RIbnpYN3IvVTJLVy84M0dsU0U1UHRlZVhKWVZpeWRsTUZJOFZDTDUv?=
 =?utf-8?B?ajdqLytRK0lZK0hScC8rbHJTM0VKKzlyT0prVE1XaUppMTNhWTZjbURtQ1gz?=
 =?utf-8?B?R3p6T2ZBMW52bDBnQ0JNWXh6VThWUTZDbzNNZFlTeDIvK2M1MG5oN1BqeERQ?=
 =?utf-8?B?Q1c2Z3ZkZEtpaHdJZ2N1MWRzWUY5R3BaWlg4ekRocWwxOTNLUGhMb29iY25l?=
 =?utf-8?B?cmxkRm42MGVLMTB2aUNDVzNNZldpdFByN2ZPMGZFa2JSYXB4WThuR3lka1Qr?=
 =?utf-8?B?YnAvYnpubUlzZ3hjL29FSGY5dmpZcTJsMkI3dXc2VzVaalJhNXkvTG43Slpy?=
 =?utf-8?B?bVkvQzZwWGtGbURoNHZkcFE4WjUyN3dmMW9MM0FNQlh3N1VOdmh4T0MzSERj?=
 =?utf-8?B?dUhNcTg5UUx1RmRIRnpnMTBpWDdRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5726A5106C8F2641BC8A94C4A18EF2F2@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e5ac95-3438-4ffa-c732-08dd909292e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2025 13:48:56.0576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eoh5ZXvfGAmYGDm4S2hh7wujL0ylTshNCzwqzX54ChrzfjH6rD34IqwkPJz61Qgaa7tsXMf4IZZSXfk2DFIcag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB4696

SGkgSmVmZiBhbmQgT21hciwNCg0KT24gU3VuLCAyMDI1LTA1LTExIGF0IDA5OjI4IC0wNDAwLCB0
cm9uZG15QGtlcm5lbC5vcmcgd3JvdGU6DQo+IEZyb206IFRyb25kIE15a2xlYnVzdCA8dHJvbmQu
bXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4NCj4gDQo+IElmIHRoZXJlIGFyZSBzdGlsbCBsYXlv
dXQgc2VnbWVudHMgaW4gdGhlIGxheW91dCBwbGhfcmV0dXJuX2xzZWdzDQo+IGxpc3QNCj4gYWZ0
ZXIgYSBsYXlvdXQgcmV0dXJuLCB3ZSBzaG91bGQgYmUgcmVzZXR0aW5nIHRoZSBzdGF0ZSB0byBl
bnN1cmUNCj4gdGhleQ0KPiBldmVudHVhbGx5IGdldCByZXR1cm5lZCBhcyB3ZWxsLg0KPiANCj4g
Rml4ZXM6IDY4Zjc0NDc5N2VkZCAoInBORlM6IERvIG5vdCBmcmVlIGxheW91dCBzZWdtZW50cyB0
aGF0IGFyZQ0KPiBtYXJrZWQgZm9yIHJldHVybiIpDQo+IFNpZ25lZC1vZmYtYnk6IFRyb25kIE15
a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4NCj4gLS0tDQo+IMKgZnMv
bmZzL3BuZnMuYyB8IDkgKysrKysrKysrDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9u
cygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL25mcy9wbmZzLmMgYi9mcy9uZnMvcG5mcy5jDQo+
IGluZGV4IDEwZmRkMDY1YTYxYy4uZmM3YzVmYjEwMTk4IDEwMDY0NA0KPiAtLS0gYS9mcy9uZnMv
cG5mcy5jDQo+ICsrKyBiL2ZzL25mcy9wbmZzLmMNCj4gQEAgLTc0NSw2ICs3NDUsMTQgQEAgcG5m
c19tYXJrX21hdGNoaW5nX2xzZWdzX2ludmFsaWQoc3RydWN0DQo+IHBuZnNfbGF5b3V0X2hkciAq
bG8sDQo+IMKgIHJldHVybiByZW1haW5pbmc7DQo+IMKgfQ0KPiDCoA0KPiArc3RhdGljIHZvaWQg
cG5mc19yZXNldF9yZXR1cm5faW5mbyhzdHJ1Y3QgcG5mc19sYXlvdXRfaGRyICpsbykNCj4gK3sN
Cj4gKyBzdHJ1Y3QgcG5mc19sYXlvdXRfc2VnbWVudCAqbHNlZzsNCj4gKw0KPiArIGxpc3RfZm9y
X2VhY2hfZW50cnkobHNlZywgJmxvLT5wbGhfcmV0dXJuX3NlZ3MsIHBsc19saXN0KQ0KPiArIHBu
ZnNfc2V0X3BsaF9yZXR1cm5faW5mbyhsbywgbHNlZy0+cGxzX3JhbmdlLmlvbW9kZSwgMCk7DQo+
ICt9DQo+ICsNCj4gwqBzdGF0aWMgdm9pZA0KPiDCoHBuZnNfZnJlZV9yZXR1cm5lZF9sc2Vncyhz
dHJ1Y3QgcG5mc19sYXlvdXRfaGRyICpsbywNCj4gwqAgc3RydWN0IGxpc3RfaGVhZCAqZnJlZV9t
ZSwNCj4gQEAgLTEyOTIsNiArMTMwMCw3IEBAIHZvaWQgcG5mc19sYXlvdXRyZXR1cm5fZnJlZV9s
c2VncyhzdHJ1Y3QNCj4gcG5mc19sYXlvdXRfaGRyICpsbywNCj4gwqAgcG5mc19tYXJrX21hdGNo
aW5nX2xzZWdzX2ludmFsaWQobG8sICZmcmVlbWUsIHJhbmdlLCBzZXEpOw0KPiDCoCBwbmZzX2Zy
ZWVfcmV0dXJuZWRfbHNlZ3MobG8sICZmcmVlbWUsIHJhbmdlLCBzZXEpOw0KPiDCoCBwbmZzX3Nl
dF9sYXlvdXRfc3RhdGVpZChsbywgc3RhdGVpZCwgTlVMTCwgdHJ1ZSk7DQo+ICsgcG5mc19yZXNl
dF9yZXR1cm5faW5mbyhsbyk7DQo+IMKgIH0gZWxzZQ0KPiDCoCBwbmZzX21hcmtfbGF5b3V0X3N0
YXRlaWRfaW52YWxpZChsbywgJmZyZWVtZSk7DQo+IMKgb3V0X3VubG9jazoNCg0KQ291bGQgdGhl
IGFib3ZlIGJ1ZyBwZXJoYXBzIGV4cGxhaW4gdGhlIGlzc3VlIHdpdGggbGVha2VkIGxheW91dA0K
c2VnbWVudHMgdGhhdCB5b3Ugd2VyZSBzZWVpbmc/DQpJZiB0aGUgY2xpZW50IGRvZXNuJ3Qgc2V0
IE5GU19MQVlPVVRfUkVUVVJOX1JFUVVFU1RFRCwgYW5kIHRoZSBzZXJ2ZXINCmlzIHVuYWJsZSB0
byByZWNhbGwgdGhlIGxheW91dCBkdWUgdG8gdGhlIG5ldHdvcmsgZ2V0dGluZyBzaHV0IGRvd24s
DQp0aGVuIGl0IHNlZW1zIHRvIG1lIHRoYXQgdGhlc2UgbGF5b3V0IHNlZ21lbnRzIGp1c3QgZGlz
YXBwZWFyIGRvd24gYQ0KYmxhY2sgaG9sZS4NCg0KSU9XOiB0aGUgc2NlbmFyaW8gaXMgc29tZXRo
aW5nIGxpa2UgdGhpczoNCiAqIFRoZSBjbGllbnQgaG9sZHMgYSByZWFkIGFuZCBhIHJlYWQvd3Jp
dGUgbGF5b3V0Lg0KICogVGhlIHNlcnZlciByZWNhbGxzIHRoZSByZWFkIGxheW91dC4NCiAqIFRo
ZSBjbGllbnQgY2xvc2VzIHRoZSBmaWxlIHdoaWxlIHRoZSByZWNhbGwgaXMgYmVpbmcgcHJvY2Vz
c2VkLCBzbw0KICAgdGhhdCB0aGUgcmVhZCBhbmQgcmVhZC93cml0ZSBsYXlvdXQgc2VnbWVudHMg
YXJlIGJvdGggcHV0IG9uIHRoZQ0KICAgcGxoX3JldHVybl9zZWdzIGxpc3QuDQogKiBUaGUgY2xp
ZW50IHJldHVybnMgdGhlIHJlYWQgbGF5b3V0LCBhbmQgY2xlYXJzIHRoZSBhc3NvY2lhdGVkIHJl
YWQNCiAgIGxheW91dCBzZWdtZW50cy4gVGhlIHJlYWQvd3JpdGUgbGF5b3V0IHNlZ21lbnRzIGFy
ZSBzdGlsbCBvbiB0aGUNCiAgIGxpc3QsIGJ1dCB3aXRob3V0IE5GU19MQVlPVVRfUkVUVVJOX1JF
UVVFU1RFRCBiZWluZyBzZXQuDQoNCkNoZWVycw0KVHJvbmQNCg0KLS0gDQpUcm9uZCBNeWtsZWJ1
c3QgTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVi
dXN0QGhhbW1lcnNwYWNlLmNvbQ0K

