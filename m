Return-Path: <linux-nfs+bounces-10094-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6D4A34B12
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 17:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DED861890CB2
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 16:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E88428A2A4;
	Thu, 13 Feb 2025 16:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="XpVzEsUh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2132.outbound.protection.outlook.com [40.107.243.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2622728A2B0
	for <linux-nfs@vger.kernel.org>; Thu, 13 Feb 2025 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465673; cv=fail; b=rt5OhWLPgRnF0dGv7qOvPiA1wIdqynCe4/SnWcm9U4yvpWEQWme9WmsMrhbth1aKsFU/PvMEJl1kI1S0up12eOJzrWepa11IFvXMRzPJLBgEJRRkApMnkNlrEeippzJpdM7wfvQAs2BpeeaGmTov/4I0F6N+X1RPNhcNbsEwLvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465673; c=relaxed/simple;
	bh=1MV8PEk3lDtiykZExwkCmTULO5iaBxo6Arzm5GTi8/Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k2RcTF5KnX9yMN1AaHo9uVcQLP/z1nyBINhag3Rx1QwSkzOKo0YHR5C1BO4JdQydpLm3LY9BLgGLK+Z2owzYHGb0K9ROidTqGooWcFEfk1VFfAnlgb7cAi/vHVu+v4Bc/B/v5gdFfbpj+ehvumOp6G4vWu/aldW4UMl5Ay15INE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=XpVzEsUh; arc=fail smtp.client-ip=40.107.243.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ibSX7c5TOq74uTAUtCKb7jPlFAbVZ7iC06QdAnbPDnhomcPEsw5BGUJyhuPaVr0DGpPL2g93gZAnkC0/Ydm5ygAaXA1D5y0jrMCu6dslWvOK5kOxes4Y4chRle+vyv5q4ZuNuRSPjC+pbzWM4X5V0drq9lE6WM5tOhdA6HNB23K1aLEyN6eJXl0PPYrM93ZLr6FAJnAKAE+H/PFOZVwgjiAO+7AsezK6IuYFGXXECue4Jj97alcWpBoIDYKe5MQIWnzNhfOkqUhBJXwjtpl42DjPME1NhdHE5kwexER0wv//THNgcXW8cwgaezinEYidHAvUk3JzASXnhcF82b7J2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MV8PEk3lDtiykZExwkCmTULO5iaBxo6Arzm5GTi8/Y=;
 b=Q6u6cNp9DYNTBeII2i0vNVrlqMAys8YeUQLMN4vAVSDYKH5GONYptAUi/g04/7ZgEAz+yK7c6KW+jAY6Ks7dT8WcbOGpvnGUp0r9O6JJgeoVBEDqXTXO6X2FGCT7FpKyeid1lWHm/2FRAbkQ/rKl7vZYLVMDVfHojKNOrK06T1g+9YF2iruo4uNT4tKUzIE2/O3vwq7mfe9D0H4n5qv4BNbjbY3RaJeSret71eCvxyvLsubSjFr9jbhP8N52u3+EporgJoNjLLSAJAzrY5NX27n0UJzfPVOWtMpn9kyZhmZHnkjlleeBvu23S/aIlo1wkFYumT4Gjzanz1eDPcdvtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MV8PEk3lDtiykZExwkCmTULO5iaBxo6Arzm5GTi8/Y=;
 b=XpVzEsUhiFkX8EvUmxAmjlgTuWse+KanFML0fY0TUI5/no7bPlbRqEzGO5tDuAWsMz02gl6ElFvEsUn490XwuZi/G2NTDWgBieU/7BwTk/LA+4FvXjaVQOQuhompYM8HjnIZY+vqg7fQ/s3kdWEi/82ZmUvkrUpeiDWlCfAquvg=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BY5PR13MB3810.namprd13.prod.outlook.com (2603:10b6:a03:225::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 13 Feb
 2025 16:54:25 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%3]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 16:54:24 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "okorniev@redhat.com" <okorniev@redhat.com>, "cel@kernel.org"
	<cel@kernel.org>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"jlayton@kernel.org" <jlayton@kernel.org>, "chuck.lever@oracle.com"
	<chuck.lever@oracle.com>
Subject: Re: [RFC PATCH] NFS: CB_OFFLOAD should return DELAY when no copy
 state ID matches
Thread-Topic: [RFC PATCH] NFS: CB_OFFLOAD should return DELAY when no copy
 state ID matches
Thread-Index: AQHbfjOM2qaXtGaATkKgNd/ysX5erbNFc3UA
Date: Thu, 13 Feb 2025 16:54:24 +0000
Message-ID: <df999d533683548ba91b69b017bf2b4acc0add52.camel@hammerspace.com>
References: <20250213161555.4914-1-cel@kernel.org>
In-Reply-To: <20250213161555.4914-1-cel@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BY5PR13MB3810:EE_
x-ms-office365-filtering-correlation-id: b76285bf-f427-4823-124f-08dd4c4f11cf
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S0NsSlI4WHlmaHhHSElZNFJiN1VnUHRaaWwrdUk0MG1KeHJEYWxZOE5HRzZt?=
 =?utf-8?B?S3ZsdGtLVXU4TEJIZS80Qy9qUDJ3WDEwdTV1T2p5bC9SNWZIanpvcWh3MnNa?=
 =?utf-8?B?UnlnNSsxRGxXdVFKc3J1aGdocFN4WUFlMGpDY1ZwcHE3U21weTg3eW9KTlc0?=
 =?utf-8?B?V3pPc3BzaUY1ODhkNGxVUTk3TVVUMWx3MFVFaVJSTko5bDVBRnVMbUtpVVlD?=
 =?utf-8?B?QTRSVlpPNlRaZTFqTDVDVG5WQmVtZjRSWW5Dc3VhaC9WNk5obis3blhUMlhT?=
 =?utf-8?B?V1F5QW1kWlhVVG1zSlBJQ0ZremV3Nms2UGpXazlrelczWEdXZzhTbC92NDh5?=
 =?utf-8?B?UjRBR2V6MSsrT0hCUFp6VG5QUFFtTmkzQUlRWVNXVmtkOEJqRFRaYWNzVE16?=
 =?utf-8?B?K0xQNVpwclV2M0hoeGM2K2JsK1JCSmkzTWZidy9EUlNwTnRQc2kxbjdGRjA1?=
 =?utf-8?B?eEhNcHhYU2xOS2d3SlJZWU9RK3pxNGIvYko4UWp5dFBQY2FlMzRUUWkxck0w?=
 =?utf-8?B?Ymp0aEpRU2xtUUp1Q2xmdStJK1k5NDVpdEVqT04rSWRBcVZhMEtBODl0WjdK?=
 =?utf-8?B?VUFCVkREdHpiOGo3L0J3bnhsS0ZIU04zMEk2cnVIMjRLT0diZk9jYUlpckd4?=
 =?utf-8?B?UE9nRHhkVHliSFVOYUFRTEJwekJrcEw3d2diSWkzTG9kM1EwbDYrT1VxK1B0?=
 =?utf-8?B?VkVSQWJudkNXU0UxUVVnb1A0SFNRaDRaMnZHeGIzTEVTenVoaC95L0tDQThP?=
 =?utf-8?B?OUN3YnFwRXJEVzlkR1BFWWZNU2N0ZDRyVXJhQWlNYXVjWkx2MWxBTjBTNVFM?=
 =?utf-8?B?eTNSV2ZrMXVCR2xzZ1RWa1ZBbTgxbU1INlNjZzZmOVFZZnNtcjg1Q3JQMDZD?=
 =?utf-8?B?azdoVW5SdEVuajJFclcwRWpIYzdLVFlYYkNEZmdhdUJpS05xSXo5QkFsWFcz?=
 =?utf-8?B?R1Erb0xBeHFEV0g5VWJxTHVua2U4cVloOXZqcjhOR21IWWhHMDh1YXlMV1R5?=
 =?utf-8?B?bEVCTVkzVE5MSGI1MFEza3hFUk5USm9uaFlSMlZiZWhJVExIOW4zeVd5Mk5x?=
 =?utf-8?B?dXlmYjZZckQwZG93NkZLNWFIeEVKU1FUR25lZUNFOEFwd2lid3VSOXN6b2N3?=
 =?utf-8?B?SkNseEc5d1AyTUlKK1NMcXNIeFZKNGsvMTBTOVkxSG8zbm9pNnloejBhcFpJ?=
 =?utf-8?B?ZGxnWFVCL2l3UW14RWc5L1hOeTdzdnp4ZS8ySE52RkxLYWQrdGpET1NmOWNC?=
 =?utf-8?B?MkdLQ0I5dTdQTjBGUjVIdWp5OFd2SWticmMvb2plWHQwN1E4Zms4QzFvS0U3?=
 =?utf-8?B?ZjlFUE9kQlhveEJVSnVQQmk0S1kzTVhSSE9DbTNZK2Q2TGpOK3c4blNCaG1F?=
 =?utf-8?B?Qnp1VUdWaXBkSlMwd2dxK1JZVUtsN0Q2NmdrUlJzVS9HK3N1a3BVVkhYMHNQ?=
 =?utf-8?B?U2NEak95aUExVEhZZTF6N3ptdkg3Yi8zcCtOZlIyR0U2MWdjbENwRWtzSmVS?=
 =?utf-8?B?QmtjZmdSK3MxakRKd2Y2OWFIS09uVC9FZ3hsYVBzcW1Qb1g0T2JoaXRucUpG?=
 =?utf-8?B?d1Z4QThTSG4yMUdsMWNhVFltMjd6Uk1VNG5uTjBTQ1dpM2l2OGtpNWoxMGpG?=
 =?utf-8?B?SzNYRmI3UzlPSDhaSFFPOTcvYm8wWllMdFZUanVaQXlweGorci93NWpzcXFC?=
 =?utf-8?B?ai9YN2Vyd1VmVDRzSm42alNtUjZXU0t3eVJXc3dXcTR6WndOYUNQZG1jbURF?=
 =?utf-8?B?UzJtZlNHeFRKalgyYUR2Q0kxRDBjZTVNRENzNzRLNy9SOTVIWkYvUE03bzJR?=
 =?utf-8?B?S2o4dDdPWE53UElMeFd3Qk85UXNQUjdBM1IvUDZ4alM2NUpsMVJ0TmRUQmdZ?=
 =?utf-8?B?NVpIcTU1ZGYvcm5UYjNwRldVWGtWTzVWRU1nd2txRE5SWDNjR2E1elJia3dt?=
 =?utf-8?Q?zgb4jAUjGflZET0uooLfiAE88+FMgZT9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M2VrbUZ0WUVlRXpKTENvS3RROGdCWWpFVVV0ZGljS1h1N3lCWXVmZ3kwdFk4?=
 =?utf-8?B?SGJJVEJGQkIvTVk1cG1zSWVjWHFkQW5ENDNvbjdXeWM3dEwzWUJ6dVRlM1ZS?=
 =?utf-8?B?ZE1QWEFZU0F5TjNzbE40bGNKOWlBbHJnNGtrcEJXMyt6YW1sS1JFbDA4RnhJ?=
 =?utf-8?B?N3FPSE9uUnVId1VzUnlXcW5xbzJUMXNMMHlTcklpd0VLbm95Q2xmYjhhQXhI?=
 =?utf-8?B?ZzRMQ0J6SmlaWHozN3BZUUVDa0ZEMldQTDFhRFRoQ1lKRGxmVG45ZDJlTEhw?=
 =?utf-8?B?c3FLUm44YURhOXBJODJuc3h3ZWd6OTV6WVlRbC8wYThOTENJQndFaGZKQlBi?=
 =?utf-8?B?RExoanRLSXJJS3B3VjN4RHJLRjU2Y0hLTWtSMW81NUx5aFpyb2NWY2Z2Y1Bi?=
 =?utf-8?B?ZkFQUUxEcC9Hby9TdndzQk5PU0QxazNzTjlDSzJpU21xWVBRQm9CSUQ2eWlv?=
 =?utf-8?B?VmNRZE9SQ0JEK0lNWmdpWU5NYW5RdWF3a0lTRnNtcm1mVFBUaFZGTkZzbHE2?=
 =?utf-8?B?bE5mUU1yN3N3VzViWldnSXRMMW45MGFpekpjTUJKYjBFYkFEeTN6Y29za1k5?=
 =?utf-8?B?N2puTFQwMVdTc0xGdklmaXBvS0tqVmxDMjJQb0lrckk4QzdiempjdFN1T3hF?=
 =?utf-8?B?bStHcVRPVzQ0b2JTY1haWEd6Vnpxa0Y2MExOVTkvNUhmSEh0U3AwcXVRQWN4?=
 =?utf-8?B?N1E2eTlsQ3JCeHdUTTRxcitzM2s1R1pwV1REZjhRT3pBTkpZNTR6eDl5aDBu?=
 =?utf-8?B?blhXakJFMnpaeTNFb0FsV2tZaEFFWWRPZXRnK0pxczlleDdwYzNMWnZYVzZn?=
 =?utf-8?B?N29HaU1BRStMMXUvQXVYekRDYTd6S25za3ZKdEE1WG9rNkhqZTI2VllNRkw4?=
 =?utf-8?B?eHFBVWRQc2wxdzhRNTZTeUx3d3NPL1hTaXpkTTJ1NFBnMGtHR0ZIT3RqcnMz?=
 =?utf-8?B?akd5Y2E5c2VyYWRoc3pWRzFLQncvSEZHODNpbTRuUnhNYmZkMGpXY1c3SHJC?=
 =?utf-8?B?V20xS2I5Q0JPeW1uSmZ2NS9hZjNHdzBVRllOc216ejVTTjFBZjBpR0VYZndr?=
 =?utf-8?B?dUVlcWpweVR2VGJNSlliVmdzNEtzVlVaMzdvYTlhTXhEL3NmNjRTbjM2elJG?=
 =?utf-8?B?VWdiR2RNY3pCTTBadXVGS1A2eFA2MVUyZUtMeTRYVk5Ydko5UVM3d0tKZTVr?=
 =?utf-8?B?cjd4WVE1b3JKQkhYaTZNaU5ZcGNnRHVZWCtGRkorb0kzL1dNeVhkaERBZTVK?=
 =?utf-8?B?ajVnSlFqZkNVdzRZMnc5VThrQ0I1T2Rhd2o4ZFE3UHQwRlZVUGdGd1BQL3Fv?=
 =?utf-8?B?eFp5NFc4SzYzM3BhV1ljbGtCS0pBbmR1ME5sSDRzazZ2OWMxQkRwR0FHVVpZ?=
 =?utf-8?B?a2xnc3ZKQzJvS0NxL0NienNiRHZ1Sm9Qbm4wdVFtYmNPRFUzWlJRZVg0UzI3?=
 =?utf-8?B?bFdXbjluUjFGQ1pHUXhRQUd0SzJKTkFYL0RYdXNJS1Fxbng5Ly80MkdVazlU?=
 =?utf-8?B?c1pTOGFBMW54MWlQbmRwQW5uZEhyaXdZcS9JdnFVazRKaHUxUXpiUjZlRkxr?=
 =?utf-8?B?dmt1WFhweW5QWHFpbkFaRGhLdEd5Q3k0NWlCd25ZSWl6NUxhMFlBbXhRU28w?=
 =?utf-8?B?b2lhR3BhcFdRL0VRYjRyK3NtVUlxZTJlRjFtKzQ3ZVphK0o0RXdYbSthL2Ri?=
 =?utf-8?B?blMzY0x3bnV6K3pteVR0Q1dYbzd0Zm81YmNjZlkyMWlpY3hvL3cwMnpmN1FV?=
 =?utf-8?B?YXY1ZEpVRHpNQTFQdk4wVWxWYm5wL1BiSllKcER5NFFqaE9IdVp4anNTc0Jm?=
 =?utf-8?B?SXVNR0FmMUtSakJSZ3daWlRVaEVFN2Irdmt1cjNzSDQ3Ty90dXJuYjhqWm9Y?=
 =?utf-8?B?MzZwMzB1cnNXWnVFZHJjaUZhY2d4TVhLd2ViZ3M0b1N2Q2RLRndKTEVoY2Ew?=
 =?utf-8?B?RXBGMys5Sjk0K2s5YkN4ZkVoVHFOQkQ1bEZxcW8vMkRlNk81eTBCYklzUmh3?=
 =?utf-8?B?ZEMzUjl3MkRuTWF2UHlyNTVmc0RBRldjTHV1d2kyekJGZDhncUFzWjk0MUtV?=
 =?utf-8?B?NkV2cVhsU3luT0lXQnBFaFl1TTkxUTc1MjJZRWdHc082L0ZwYlowMm5IcVY4?=
 =?utf-8?B?em5PRFJ4Tk9SMmdwVk02REdGUDk3NUd2L0hpdTlxSmpTY2tOdHI4dXFRYnNr?=
 =?utf-8?B?Q29TOTRzbFp1eE5vMTRXMWNGbFlPQUlCaUVrRzJldzVpMlZDM0N0NVJNR0lk?=
 =?utf-8?B?UlV1WTl1Q2xiT0lhL3FIbGI0aFl3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0747714A8E60540A74F86AFC78CD952@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b76285bf-f427-4823-124f-08dd4c4f11cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 16:54:24.0835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uu2BJowl7LVB3382Qp46ORMK4Pi/hoRFJi9jUhGSBPFaw+U+FdcbegYX7GL3YfAbKaz07JIwbsjVAa5VjtvbmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3810

T24gVGh1LCAyMDI1LTAyLTEzIGF0IDExOjE1IC0wNTAwLCBjZWxAa2VybmVsLm9yZyB3cm90ZToN
Cj4gRnJvbTogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+DQo+IA0KPiBUaGUg
TkZTdjQuMiBwcm90b2NvbCByZXF1aXJlcyB0aGF0IGEgY2xpZW50IG1hdGNoIGEgQ0JfT0ZGTE9B
RA0KPiBjYWxsYmFjayB0byBhIENPUFkgcmVwbHkgY29udGFpbmluZyB0aGUgc2FtZSBjb3B5IHN0
YXRlIElELiBIb3dldmVyLA0KPiBpdCdzIHBvc3NpYmxlIHRoYXQgdGhlIG9yZGVyIG9mIHRoZSBj
YWxsYmFjayBhbmQgcmVwbHkgcHJvY2Vzc2luZyBvbg0KPiB0aGUgY2xpZW50IGNhbiBjYXVzZSB0
aGUgQ0JfT0ZGTE9BRCB0byBiZSByZWNlaXZlZCBhbmQgcHJvY2Vzc2VkDQo+IC9iZWZvcmUvIHRo
ZSBjbGllbnQgaGFzIGRlYWx0IHdpdGggdGhlIENPUFkgcmVwbHkuDQo+IA0KPiBDdXJyZW50bHks
IGluIHRoaXMgY2FzZSwgdGhlIExpbnV4IE5GUyBjbGllbnQgd2lsbCBxdWV1ZSBhIGZyZXNoDQo+
IHN0cnVjdCBuZnM0X2NvcHlfc3RhdGUgaW4gdGhlIENCX09GRkxPQUQgaGFuZGxlci4NCj4gaGFu
ZGxlX2FzeW5jX2NvcHkoKSB0aGVuIGNoZWNrcyBmb3IgYSBtYXRjaGluZyBuZnM0X2NvcHlfc3Rh
dGUNCj4gYmVmb3JlIHNldHRsaW5nIGRvd24gdG8gd2FpdCBmb3IgYSBDQl9PRkZMT0FEIHJlcGx5
Lg0KPiANCj4gQnV0IGl0IHdvdWxkIGJlIHNpbXBsZXIgZm9yIHRoZSBjbGllbnQncyBjYWxsYmFj
ayBzZXJ2aWNlIHRvIHJlc3BvbmQNCj4gdG8gc3VjaCBhIENCX09GRkxPQUQgd2l0aCAiSSdtIG5v
dCByZWFkeSB5ZXQiIGFuZCBoYXZlIHRoZSBzZXJ2ZXINCj4gc2VuZCB0aGUgQ0JfT0ZGTE9BRCBh
Z2FpbiBsYXRlci4gVGhpcyBhdm9pZHMgdGhlIG5lZWQgZm9yIHRoZQ0KPiBjbGllbnQncyBDQl9P
RkZMT0FEIHByb2Nlc3NpbmcgdG8gYWxsb2NhdGUgYW4gZXh0cmEgc3RydWN0DQo+IG5mczRfY29w
eV9zdGF0ZSAtLSBpbiBtb3N0IGNhc2VzIHRoYXQgYWxsb2NhdGlvbiB3aWxsIGJlIHRvc3NlZA0K
PiBpbW1lZGlhdGVseSwgYW5kIGl0J3Mgb25lIGxlc3MgbWVtb3J5IGFsbG9jYXRpb24gdGhhdCB3
ZSBoYXZlIHRvDQo+IHdvcnJ5IGFib3V0IGFjY2lkZW50YWxseSBsZWFraW5nIG9yIGFjY3VtdWxh
dGluZyBvdmVyIHRpbWUuDQoNCldoeSBjYW4ndCB0aGUgc2VydmVyIGp1c3QgZmlsbCBhbiBhcHBy
b3ByaWF0ZSBlbnRyeSBmb3INCmNzYV9yZWZlcnJpbmdfY2FsbF9saXN0czw+IGluIHRoZSBDQl9T
RVFVRU5DRSBvcGVyYXRpb24gZm9yIHRoZQ0KQ0JfT0ZGTE9BRCBjYWxsYmFjaz8gVGhhdCdzIHRo
ZSBtZWNoYW5pc20gdGhhdCBpcyBpbnRlbmRlZCB0byBiZSB1c2VkDQp0byBhdm9pZCB0aGUgYWJv
dmUga2luZCBvZiByYWNlLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVu
dCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNv
bQ0KDQoNCg==

