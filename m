Return-Path: <linux-nfs+bounces-18266-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOR6BWA7cWnKfQAAu9opvQ
	(envelope-from <linux-nfs+bounces-18266-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 21:47:28 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7AF5D90B
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 21:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4174AAE96AC
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 20:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165163A7DF1;
	Wed, 21 Jan 2026 20:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="ersQsuJj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11022081.outbound.protection.outlook.com [52.101.53.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64743C1FDE
	for <linux-nfs@vger.kernel.org>; Wed, 21 Jan 2026 20:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769027891; cv=fail; b=Qr1rv534Up0dzEOKJyqk5ZY8R/ZPx3crFSyB6fOFh35m6L/ozpTw1Fy6mWpeEydzOBNUS8HLxNHsR2gSTqnYQ4UKUQY/2l23x7kns26EjF3nJtKMLXdFuGooa+8Lf5UFSdnc4/TAuK3XLa8LbRyE7qkklSjKqjl04sidcL9cQik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769027891; c=relaxed/simple;
	bh=6YbXuHxXdciW8uNphY4mK53gX/mITiKOVpaYFoC2+4U=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WKrOyUh2JW4faSgxSgwrB8sW8Igt9+2zEmDAXR6NebY7uMYzrV7Dtoi3fk92RKyeFVMfo3XiMVv0zL3wtT3JlhKwawWPUvx+4rz30MysnmTAyCu8ddSjC1gtEKyAgcL7MA2wJ/Qm6T1xVQbF2xpEH4iZmXa8wXBCT0lfXFG2UzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=ersQsuJj; arc=fail smtp.client-ip=52.101.53.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wIgEgH4n/vbIv7FTtnOYWog8L5jtxgGI/iQNCfCp0+zYcsyS99+EH908cmYbJsT0K5UWMsDaniOB+aQ4Iv8LuvnxzQhSA3fAb/HIXRqfln4vM5wkRsbQXrXk5OcQTtxv7z88o98rTJaCA+8/7vVBmc3QBit1xcNBrnNyWY4kMDXfiMO6r6uqCFfpfO6psiW5MxyENCIUnVeMiWilwU1UBqE0WmKiKijt6fr80CPxU51m5e6EclohHKquboBoF1iDOifcd/eJaf5oKOssqk8gatKCWI4koqTxx6cVpIoeU9OpjAukeE6a14X3IVa6Q/Zpx8zTg8Rvz2u2MVw/3NWh8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cxg9fkU9TdUKKEZTJHQ4nV358k1epzCoX96Ttbq8az4=;
 b=uiLOevueRuS/h5RxPzRUUtKGcbg4HnWDSY5pfWGTFE8ynYcKdyHVY7LFmLap4tbzUgh0NOPKNdmDgjMHlFTxYjl2INW23YktjDAbK20+0855991YVy8COnSedtA2CMgrmeVcfaLq9at0R5x43KeWZXBhV0+S25pZP2MtOxaJ4di1SjikP7+V9n7Ng6uAD/lJmp8CXqXaxUEXrRVdT3bHFJW7nDFI+1OjEFw0fksE7fgPXTQscPn8pSonYtCbRKhWLepWU/A3CdpVvNlXa96jwXNPk3Iv9O1oaHKDdSaK/6c4jFDUpYFce84ad3p+prEUIAn9lHZYENNlDQ9IuAsSSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cxg9fkU9TdUKKEZTJHQ4nV358k1epzCoX96Ttbq8az4=;
 b=ersQsuJjjUkc87/JyM5w36bGV17DZQhUVuAu/kgPLfayV8sJZOxXmZY/aNAMw0n7A8eRCadlmhnIjKfyFdR6nnKbR1tOeFm+7u11NYHSaaRpEz9Ph78oH/za8nle+3olYCGoTHh29KyNiQ/J1iNmxSH/Lz+rswo1J/O6p715YRg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 PH0PR13MB5422.namprd13.prod.outlook.com (2603:10b6:510:128::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 21 Jan
 2026 20:38:01 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.011; Wed, 21 Jan 2026
 20:38:00 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Steve Dickson <steved@redhat.com>,
	Benjamin Coddington <bcodding@hammerspace.com>
Cc: linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 0/2] nfs-utils: signed filehandle support
Date: Wed, 21 Jan 2026 15:37:54 -0500
Message-ID: <cover.1769027750.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0039.namprd17.prod.outlook.com
 (2603:10b6:510:323::18) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|PH0PR13MB5422:EE_
X-MS-Office365-Filtering-Correlation-Id: fe6d2ec9-19c9-4625-a0d3-08de592cf7e5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RSlFW91g3NbW62F6NsxKNvH075q5BpzhuHPJGPDwhKVycbYbaQJxHRmobD5S?=
 =?us-ascii?Q?iC37k4+Fjjj8XzYYBbXJX3GCAGRS0IkNlPKltlltAjJnFUvPmHQqVx7ALee4?=
 =?us-ascii?Q?BWBeYUaZBstD2MxyM8lrmYd0p4wG01sA4fDfG046yq0MqD7e4773b209mvEK?=
 =?us-ascii?Q?av79kRNZNoPEeAlxM0xTKuWJVtFSrBIrbYDfOSGILnplEifUOJkRuo+ockzZ?=
 =?us-ascii?Q?xeC94bP/vaO0ywlPJ2EKSFTG9TtDV8WW1aAHY76smoQNev8bPJLWUDfVOKcq?=
 =?us-ascii?Q?r7nG07vi5A9ZDvvMoaAowYoKIwTIlGt1oHXQyM5L2U1vhkrmOiX+lohHyTeQ?=
 =?us-ascii?Q?VJ6eJ39MUSf3A8jA+efJ9H/ocNLZDCEZD95DPnEcrMkqJ7jq9WBw8tqrno/X?=
 =?us-ascii?Q?tCX/1gkM1H3Z9ESilB09HN9w/AS9Xtj0TpPJnRGPOyvdRdoT6ZoQ2ItYdMDC?=
 =?us-ascii?Q?sMF01isOmBWrpP0HCz6l7777B7dy/qWTndnvznrakdl9/TIuTn05p03AjqTm?=
 =?us-ascii?Q?672MkvIeUO+qqt+XtvpmJ2v+/sv5pdUdlY+1vuvJWiMEpJ6siENe+nbCkDGz?=
 =?us-ascii?Q?z7WxCKLiZFrj05DZD+6Vd8uH3OtGp6FfoMtgQFMX5uqgd70mk+mMIXsAJlMr?=
 =?us-ascii?Q?qZVXiKCp8GQqCRvAc29RiqsJgkz6v/lxprnQZwNDfji/JreZML9evt02r7SD?=
 =?us-ascii?Q?nox19IZ+JQUePIElFiP03rQ64zADDQMvVOjZrsjfi31e9DLY0bEOGI9lsiAZ?=
 =?us-ascii?Q?xwBNhFNrWbOOdN68XyFyH03EFAb/Gm4daRNxZqB/gStLVPJXJb4SkjPb0uCE?=
 =?us-ascii?Q?0LhmH7szQFp/+PjY0MAwIbyK8IYtlUEyHsMFK6472+yMHhxYd6i2U0g1W82E?=
 =?us-ascii?Q?2hDWkwyd/TIK/HBMjwjswsRBFLvr/gqBlJGB4Ym8ytc7R3d0J9Ndtzh8y9xN?=
 =?us-ascii?Q?LO21cHqyj1U+Ii9VY3hPJRT02/5MgaXBbikmuP8URa/IVOyB84AtLRV0Q3Dk?=
 =?us-ascii?Q?KMQeViiB9UEZJRwpMEggRuc5GCBcCDCr0Ggz1W8GhAu4cIyl7KJO9X/ICTT/?=
 =?us-ascii?Q?FpNtJgvY6MTCllnKhSsswAAOL2iKhlgMne049W+wHnusOJTkFovq5fd6NlUO?=
 =?us-ascii?Q?teM2XW3ApwlTfWvh1oSyaxs/spY5fnZ4YW8OQHJiNo7IY5YG5PoVhbSnCTk+?=
 =?us-ascii?Q?KI7tBn5FOLawRsueGv6RI2IEsQy8e0eFy86bER15WWtq8q9lX4JNBtVHZOPj?=
 =?us-ascii?Q?eWef0ZoyHVepZUg40Wg6RMTzaOV7Gw00cA1ijw6xbXjcrb+d08DGHBTDRmSd?=
 =?us-ascii?Q?aZkgBKJt5ggdlGfVpOvJOzyKD7TVeona1Mcy8mw+7WffWagbPI7Xgyfh7p6T?=
 =?us-ascii?Q?7Vcd7vjFKJte7U9UjjxfB5tmLqmRsKr14sONQiUVIyAVWowCxwWE1Rr6Hnax?=
 =?us-ascii?Q?/V6g9Zsfe9EUsFcW3cK//9Y3BjXT7/THEKglCe6Sg0A0QJJf2ne6Ap40/Wd1?=
 =?us-ascii?Q?vxJuOTOdXiPHCCOIO0IqvxeGa0qoPkpYHmbXAO2HgslrkEUwEZxVjy0ZPmq6?=
 =?us-ascii?Q?RKuQcscmHIeFHzk1oWc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0tYgkEua4EdTvro/5XQCtjEKR6/qCrPdRLGnNcGEvxAkjotAwqgksG45GoeH?=
 =?us-ascii?Q?IcgeJkJnz46Jl7HR0CwEvIEnEbEUQpYXFyMMNe3C9EJZM7hLWZfrMyK9S4CV?=
 =?us-ascii?Q?+e3pLa99d9MrAvlDa5XgvDTuhykk/xO33Gptnr2XQn5mgfp0pm4TqxOFLqRl?=
 =?us-ascii?Q?9OcoZtqvODwWC4ez9widDHhDL2l1sYkX/RKKuAY7YOY14yiKDstm/syWIs0c?=
 =?us-ascii?Q?MTeK1A0aNCYM+kaGENsKA35b2WJd6Qn1Hwl9s8z2PkfMQct7EIoo9Dnx4lfH?=
 =?us-ascii?Q?CEskAudHINFtQeCQaTiszV10LdMsnZtp7Mwd/OQWZYAFm79OxiB8sPJFUHap?=
 =?us-ascii?Q?N81LqmPQBvMn6E6udpmnh8D2d6ykTWzC8zE7uPL+tBwqNETZlf1GU2J2pDfi?=
 =?us-ascii?Q?EkyfQkD4eL0WDESKKIYIoeRpcDeN8ps3CCldGWOQl1RknzVi6JASEx6S/6Ks?=
 =?us-ascii?Q?SlQoHMLfCvJRlgGdr/NXj5bfQvjWWn64LV3abypSlT04gEmvg4YumxOrf52Y?=
 =?us-ascii?Q?QJGibze+zdb6Aq2oirkER28b72Yo3b/IlT4U3/J8JKmScSCKt405uirlMFFT?=
 =?us-ascii?Q?4qF9EkZ0vFE6A/ENzfjN2CHK2kqy8xghUs13Tt0MTlhxWQM3cAWsAw9/towV?=
 =?us-ascii?Q?dfl+PvdLJ93K4Ogl9FGDE6sXq018fMxJ+TGLp+5JClhx2N9MFxCBxlev7JcP?=
 =?us-ascii?Q?Q4rsBTi9oBQEx1y53sm596CRYadtu0fz2gJ1zKHYx4UfwF18lhee7vTcPwCY?=
 =?us-ascii?Q?A8yBDRmlL+kuw24MSeNTnTQzW5yvwiTqfZ/ABn35er4QqdFUCZKK43u9lrWm?=
 =?us-ascii?Q?m9Qx7PmTr0vHClAdjVmZSoY5/1zYz+pTs1NIDwOaUo6Y4DocS3ki4C+yHlWt?=
 =?us-ascii?Q?/hrqaG7S1THHkHCklTJ94G2CVGPsgu+/pzLQsSVTxXv/la3QZj2gBlVDPlsa?=
 =?us-ascii?Q?UD366c+FHmo4nduuUiznP6N7klkR8HxZo8fHHtiMRtdACgsrxbilXyF4RJ0e?=
 =?us-ascii?Q?YTYpxQ1KHsl0NjxH6ltDmsP8lmeu+1+uOGxkgXafkj3/5MYJ9tJ9wHp9vEgq?=
 =?us-ascii?Q?W58vvqGx+pucjxx2WWL3TQJTPIsu+zmenPfjqyZB/eg7EHiwc45JtPT34WxJ?=
 =?us-ascii?Q?4n5b+iu6nGKdTTHNwEy4T050j4IkM2jqhQESo8G9VRHqKDRJIqMId4ovqgS2?=
 =?us-ascii?Q?3Omqpvocs4kg4YT1XAtHPl8Va1Qe33dF8m0uL0dXWV7GDcWdEh34+jNQrWo8?=
 =?us-ascii?Q?fRUdiXk5ORWcmROqumRrNnF02/WnmXG8/4cRam+jQYU6BIrMR5Ssa+UAAvON?=
 =?us-ascii?Q?+Cf2qJRFStSO8tjKnOuglMJ5/rZSf/T5f+6H851F5VPasnUmhjg/4euRulAY?=
 =?us-ascii?Q?VG8klVOOpA0buAOwbe8IZO7WrNz4uMclrxtOIXAO412RF6Ro1AD/d7QXqIGm?=
 =?us-ascii?Q?syBDYUw2Vej3hBxl2k803uO1Y9jO6d0FrxvN3cygNmFkRLEy3VcuNBwosd52?=
 =?us-ascii?Q?zqElyukm++goSfighA1g1YUZFtR15cf+iI60MP2setvobFeGzRFR9+FkrXVb?=
 =?us-ascii?Q?cHNd+o+QyYv2fcvq2S8cY/mWaIf7dliTQEYGGzqBUiAv1f4KpsD36XEqymmL?=
 =?us-ascii?Q?QdM3+Ikm50oLVPVuKUBoFa2+7P0BuyFAOe8h9l69kydCO6nabJPSoCduz5bM?=
 =?us-ascii?Q?0rqGhxzqnUBUyHkOmUtrMfFvOIswCrU+hfqfoXLdXAdnjvQh3h5+bDTdLWtA?=
 =?us-ascii?Q?a2p07LQr/l+4yX64NO1R7V01/jgi6Ww=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe6d2ec9-19c9-4625-a0d3-08de592cf7e5
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 20:38:00.7382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wu5olSG8ZLjpxoBt/jxL5u3toahI4DcKXgS2yVMFTYrMuBtb/vKr7zJbC7pZqZDXcrtlr2s6mBgIdyxEyjM10yd/X3a3N7H41wyayZFgeHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5422
X-Spamd-Result: default: False [1.54 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18266-lists,linux-nfs=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[hammerspace.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:mid,hammerspace.com:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 7A7AF5D90B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Here are two patches allowing userspace to set a secret key for kNFSD to
sign filehandles, and also set the option to sign filehandles for an
export.

The secret key passed to the server is the first 128 bits of a sha1 hash of
the contents of a file configured via the nfs.conf server section
"fh_key_file".  Exports that have the option "sign_fh" set will cause the
server to use this key to append an 8-byte siphash of the filehandle onto
each filehandle.

This version of the userspace patches correspond with the v2 of the kernel
changes which have been posted here:
https://lore.kernel.org/linux-nfs/cover.1769026777.git.bcodding@hammerspace.com

This work is based on a branch that includes Jeff Layton's patch for
min-threads:
https://lore.kernel.org/linux-nfs/20260112-minthreads-v1-1-30c5f4113720@kernel.org/

Comments and critique welcomed.

Changes since v1:
	- fh_key hash is passed as an optional attr to threads verb
	- include missing hash_fh_key_file() function hunk
	- wording updates (thanks NeilBrown)

Benjamin Coddington (2):
  exportfs: Add support for export option sign_fh
  nfsdctl/rpc.nfsd: Add support for passing encrypted filehandle key

 configure.ac                 |  4 +-
 nfs.conf                     |  1 +
 support/include/nfs/export.h |  2 +-
 support/include/nfslib.h     |  2 +
 support/nfs/Makefile.am      |  4 +-
 support/nfs/exports.c        |  4 ++
 support/nfs/fh_key_file.c    | 80 ++++++++++++++++++++++++++++++++++++
 systemd/nfs.conf.man         |  1 +
 utils/exportfs/exportfs.c    |  2 +
 utils/exportfs/exports.man   |  9 ++++
 utils/nfsd/nfsd.c            | 16 +++++++-
 utils/nfsd/nfssvc.c          | 26 ++++++++++++
 utils/nfsd/nfssvc.h          |  1 +
 utils/nfsdctl/nfsd_netlink.h |  2 +
 utils/nfsdctl/nfsdctl.c      | 35 ++++++++++++++--
 15 files changed, 179 insertions(+), 10 deletions(-)
 create mode 100644 support/nfs/fh_key_file.c


base-commit: 612e407c46b848932c32be00b835a7b5317e3d08
prerequisite-patch-id: cc4d768b1f6935b3c94ae87bd0389270717bc5b0
-- 
2.50.1


