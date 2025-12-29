Return-Path: <linux-nfs+bounces-17345-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DEFCE6CE0
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Dec 2025 14:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C77A23014126
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Dec 2025 13:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9260831B831;
	Mon, 29 Dec 2025 12:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="ODS90Ngi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020088.outbound.protection.outlook.com [52.101.46.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C6331B830
	for <linux-nfs@vger.kernel.org>; Mon, 29 Dec 2025 12:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767012735; cv=fail; b=EVw3qL/bM+CkmIWS/bOQpUunHhuCNadyceRGGqTOvZp6AilpgFPaS28s1ikyEEA2u3Ns+LCDiLA6iuT95o4jMsLaMdsjfZSWUxBnZqGMMxUg2LqWUz9tSWL/BeiTIergDxmVqeDcjiH5m2DQUBNyUK33CuZj8fwNaYkAOzGIyhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767012735; c=relaxed/simple;
	bh=OmRcyKftI48498mPIPr47tCBiVexMmMg3jLqnnDfQGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nel5vkMEfqBkMtsYOoU2jcm5veOwaQatR2Zhe7Lgrw6d6EYRwr11k4mMJC7MwrWK0V9m6KzJposSQiGvK2akb7QIdAFdFqlo8hrCna8v+XphALHkn5BSZbhEW06fqJ28CMPIqesYKAd2bNf48tCt+nmOr83C5wF969AdnV54ZVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=ODS90Ngi; arc=fail smtp.client-ip=52.101.46.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mbZOnYJA7TL7FSy/D7patpd/xoEUPvfVmXp13hhs+3A7rys54T3BCWzPEbUyoOhcOkOtpbCD83jfVXIgXvu0QtiiRyqsJVKhZgL26v06bkYtMfWK4jD8jnhzqFbM+3Qrtg229BEuqnHBHrjTTk4b2CLYoaG6TeZbRUMbJ9aN/1D3FQu2u+e+JzZKXhVUNugWVvEzKgTQB3/DNwLtKeLmFl8eHe6A+gg8wA6pnLhVfsR4bPPHhY/iJaSibs5D26ysoMwzES695Yx1cBmzbnxhCv9GY/+GmALNFTQZ4sD8+4EVs9Rt6FDbftSV6XDtt4FTvUCrHO+zaB/VO5Mj/m4HWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IiAcL5A1ytce5VKmkedA6R24l/ICfRS+pePvKE6a0n4=;
 b=V4WtWr/NHQA4XapTPPcmdU3DlFaPQkZNcPUrzKT/vw37/7y1Bdt1+sVp8yoZkDPtrvasZEM/KSrwW516LE39yVG0XV75Qgq3X11r5TG9GK8DlGTyYtLhtZGJ/NFe/OyaHCJwtJQrR51c/cGbyP/atwPU9ZQ7GGg9dGB+SYN2eVVO/r+j0vizMrydBjbMSbtqyDsg/pmTz5YlZYwhH0j5io/t3rhzi+FVvG5DuV0h7jBDtgnNWN4XAKdfW3r2IXDdMmZmcYDZJDCMuNgslHvc+zGAnKGvM/xpXYB8/k+a+tlni5F7eLia4mq70kzn1JCEwcXysvN0r0BcseOeBfXGZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IiAcL5A1ytce5VKmkedA6R24l/ICfRS+pePvKE6a0n4=;
 b=ODS90NgiHSjbL9HNvsc0BXzoxd671EyQHhTIf3KMACK1Y3k4BksHjPmp/nrEIQP4v6x5ciIUe2AW2sLoq1GbtHNc2M1jUUqx2bwaTVbRedSntod/niRMX4IRuI22lWx84c8OmY0qnlvHvt8jvPguJitHD6RtSGNR8pISVYnFShY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SA1PR13MB6648.namprd13.prod.outlook.com (2603:10b6:806:3e7::10)
 by DS2PR13MB7532.namprd13.prod.outlook.com (2603:10b6:8:332::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 12:52:09 +0000
Received: from SA1PR13MB6648.namprd13.prod.outlook.com
 ([fe80::c48a:c42a:aa18:2ef4]) by SA1PR13MB6648.namprd13.prod.outlook.com
 ([fe80::c48a:c42a:aa18:2ef4%3]) with mapi id 15.20.9456.013; Mon, 29 Dec 2025
 12:52:09 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Rick Macklem <rick.macklem@gmail.com>, NeilBrown <neil@brown.name>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 0/7] kNFSD Encrypted Filehandles
Date: Mon, 29 Dec 2025 07:52:06 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <706F9EDB-D98E-41D9-92DD-5172A34A278F@hammerspace.com>
In-Reply-To: <CAM5tNy6Xk4KP6NhCYJA-S4HOorYDa3v7JBo7jq7dFpwvfFMOYg@mail.gmail.com>
References: <510E10A4-11BE-412D-93AF-C4CC969954E7@hammerspace.com>
 <cover.1766848778.git.bcodding@hammerspace.com>
 <176687677481.16766.96858908648989415@noble.neil.brown.name>
 <A70E7B41-A5C0-443C-BD16-00E40F145FD2@hammerspace.com>
 <176690096534.16766.12693781635285919555@noble.neil.brown.name>
 <CAM5tNy6Xk4KP6NhCYJA-S4HOorYDa3v7JBo7jq7dFpwvfFMOYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8P223CA0027.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::22) To SA1PR13MB6648.namprd13.prod.outlook.com
 (2603:10b6:806:3e7::10)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR13MB6648:EE_|DS2PR13MB7532:EE_
X-MS-Office365-Filtering-Correlation-Id: 23237a49-63e8-4a24-5f48-08de46d91430
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDFvYkZKSU54WFViV0xBTnIrV3d5WUNPTkxUemhXN1VEOWhqZE9oRkZRMC9l?=
 =?utf-8?B?SVJNYSt0MDZEZ0czdnhydnFVSS96M2g1QnIrbmNKdGJQczFhY2hxT0xocS8v?=
 =?utf-8?B?Y2hGOWFDMXVPcmxObHRQdU9LQ00rMDR4TmFiRGZwM2VMbUhCcW5SdTJ0Uk9J?=
 =?utf-8?B?UzBXZjFFSEN3dzJ0dlBEanU1OXhSMWJuZGJXU1l4cCtSZjI4d3Z1WXp6Ynd2?=
 =?utf-8?B?emhGWTVndkIzM0tsZy90b2EvcDVTZE1POEIwckx4ZTlidDRBYVJiT2xBeFgr?=
 =?utf-8?B?b2pxTktBcGFmOFZoTk9haEx1NzZiR0hxSytoODBTUzREbFZPRCtLV0k3dEF0?=
 =?utf-8?B?NzRwcTJxNEt0STJwT29pUW1veFlQTjNlc3VncTJsWFJpbU1IeFlYYUJlaTh5?=
 =?utf-8?B?dTR2UzFHZTJna093VDhHZEd0NVlMc3U1VlM2Y0dsMG5QREhFSDQ4QmtNRExE?=
 =?utf-8?B?VlhGU0grYm5KVXJxL2ZzM2YzeHlFZHVmU0dlTjF6ci8xTDJUQnhyTDN1UlY2?=
 =?utf-8?B?b1dqNFlEU0xhMmlFQ3NjL1J3LzZIaWM0SFBRVTM2RzBROUJWWmZhVmhObG1E?=
 =?utf-8?B?cmkreUI3WUJXeHl6cXU3aHNNUFQ1d29kejd6N1BNMGFpTlFIV1padmpMeWNM?=
 =?utf-8?B?d0RPZkJZL2xWNUR4b25PNFpSV0FvZHVqY2RzcVJ6VWRBYU1za2RNMUdkMlJJ?=
 =?utf-8?B?TWV5TXk5SVVCL1RTZzBZd0dNRTVNU1g0cVZCZEJxenp1cjJjNWhHcXlzNzNt?=
 =?utf-8?B?UEIxSTFwQWxKSEpWZ3cwYmdGMEJvdTVtYUdJeU9Mb09ldEdhZk44cVBRS3dD?=
 =?utf-8?B?bU1xZ2M4TkFqVWR2aDgveS9ocjBNSlpqTkhsZGlZME1GUk54M1dkK2llbVcx?=
 =?utf-8?B?eUxqSm9SSWNaT2NnRy9nb0NxcVVZYkRhV3lwanZiTkFPQml0elkrd0RnMXY2?=
 =?utf-8?B?NW5nL1RsWXhRZDlpTkVGYWtMaXMzdC9yNXNKVGk4a1lESndFQk5GMC9iT0hI?=
 =?utf-8?B?SDlJSzZPQ1dzVU9lb2xqYWQ0SDhWNyt5alZBbkY3T0hRQnJyUWlwSXZhaEtT?=
 =?utf-8?B?aEhxZXg3bGpuejRzY1BrR2tRc0tKZnRYclN1MUc0VEVub1dlalVnV2YzbGJt?=
 =?utf-8?B?c0lleW9nay84SmplUFkwUXdCZlZWTFNvOTZtVVIvZ0hMczh6eXUzTlpZOFdw?=
 =?utf-8?B?WG1vSlhUd2JHMjNxK1FvWkQxeUdRenNCS08yaWw3R2o0SjZabXZIcTA1SGwr?=
 =?utf-8?B?RGZrNnN1TVc2eWI2S0JFNGNZVmVjbkpCK2VuQTBzQ0JkOWdMRnhUS285cWZY?=
 =?utf-8?B?eFFHK2kxOTFQWlJ5THFNQmdMWlMyTUFRYVNKYk9Oc2lSVXhEOUVCUHJZalZ5?=
 =?utf-8?B?emhIZitleUxmYU5IVlN6aUhrbGZWZnFWR3BCSi9BZWRPaElPeVhiK2d1K1pE?=
 =?utf-8?B?SHhRdUUyQS9vSFBWdyt0YldGSmNZc1BNZ1pkcFd5Q0VhdGhNL0pHU3EzenRE?=
 =?utf-8?B?TGJMcmJnZTFIaFArS0JuTW5zbmlsZ3loazZnb1hHWlVyNkdZMzdIU2lJWHNF?=
 =?utf-8?B?M2Q5YjZNanFZQ3NQVTJrQWY2UnpHSUhEWGkzUGNqN0NwM01RbnFkc3JKOG1u?=
 =?utf-8?B?OEluSUo0SjhMWWVWNFI2QXg4LzRINzRQVFpvVUMvWnBqdzQ1VGlSTEhhT0N0?=
 =?utf-8?B?UzNaZnlMMy9sZG43OWgzNWZ2NDUxQnZJLzJ6ZUsrUHhaNWNmTVRHeWx2VXZ5?=
 =?utf-8?B?R0ZDVFdvU29hMlN0eTFHeDllb1oxWHJJbXU5T09qdHU2bDFXQ1ZsL0t4bUY4?=
 =?utf-8?B?WTJPcW0vMEFvNlVJbnBtM2ZrRWdYaUE1aFpmQ0ZnTnhMSnJ1SnFwZVdIRVhq?=
 =?utf-8?B?bGFMRWpsYS9rNmtaTkF1SmFFMDAvTE90cFN0YlB4T0l2NjdGVzBlVDBIeGw3?=
 =?utf-8?Q?L5796RKqqPwVF1bWlk1aZelKBIj87v0v?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR13MB6648.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0NkZzZ5ODZsQ0IxaG5mZ2JsbW1PV0xGMkR1VU15aVhYQW9IOVNWVFgzcjBR?=
 =?utf-8?B?bkFiL3NjbTFaaldEUXNUSktEbXVIYWQwOTVvZ2NPQjBEWHkzYWVWQUxCSE94?=
 =?utf-8?B?VDZ0aUIrOWRVeDR1RExuek5IdHM4cmdqeTVHOGpPdW4rbVRVcXFudVVzZFpu?=
 =?utf-8?B?NHBhS0Rsb0d0SEFpai9aRzlsSmtybGRXVGtqY3hsUDJSVU1iQlNTcDVTWnBv?=
 =?utf-8?B?aXJrRVE1NVpSYnA4MWZlU0dFNEZ4NEdRSkhNMlZRMy9FenlGMWlhQ0FVckt0?=
 =?utf-8?B?SGhmNThtQUt6QjhVRTdvVVN5SG9iVlB6c0YvajNrZjRkZ2tIRDJDRnRIWlJ1?=
 =?utf-8?B?bXhySFh4UlNwdFQ3MjBWMjNLOWVrd1VFYW5GSDVqZ3pWcXRsMnF5aXByaXBW?=
 =?utf-8?B?aWNwMWQxYVE3OURDdTNRcmdQNzJ6ajRXSWRYbmgxY2Y3ZW5qQ0tYc294Z1NR?=
 =?utf-8?B?eGNYc2E3d24wTWgveWhNNHYrN2FLYk1PYnJhM3VQNVdDZkV2VmFRMUtGMlht?=
 =?utf-8?B?cklHL1J0ZjVsaHl4VG83aW5jSGxZc2VueVVHQTdVS0xMTnYxeWxQK085azZ0?=
 =?utf-8?B?NjZGU2lpeC9EUWR3b1RTNUprQ0JEcWd3MHJOZHNHOERjdXJrMVJQckZhRDNj?=
 =?utf-8?B?RGVvcmJMWkU1ZjBBanVTRUJMaUVrZUt4M2xNT0srNkp5YXZ0M25oSkJOdW9L?=
 =?utf-8?B?OGtDNWpSS1V6OWtjS2dJVC9YTmVPbHFPVUx1Q2NLMFo1RkRRZmhLMk1EcG1v?=
 =?utf-8?B?TUdHNzlsU2k3MkxEMGZuTFc4cC9qbWExdTltOGFkRlFYbUFVaEF4QlVCcG44?=
 =?utf-8?B?MXNZeU1pQi9aT1ArbkxQU0JOc1ZBVnpVMkdQL1RYNkdxZ1dkWnM0U0UxZ1hX?=
 =?utf-8?B?cXNzTFBYa29rVGZGdXpCZE1aWnpPVWZCbnRUMTc1UTZmdFhHcUV2U01aR2Q0?=
 =?utf-8?B?ek5HOWt4K2h3ZnFMYVFsamRzZmtPeG1VTy9mSHZwYWt4YzRVSE9ueFQrNDZV?=
 =?utf-8?B?cUxoOXIvKzNsbTNMbVZyUzFYZUxvQ3owWDBlUC95c2VVcFJVUU1rWGloNFB3?=
 =?utf-8?B?TkZkcXovVStSd0g0UmhnNnFINnZmRkhOYkIzWllxeG5UTVFrN3pyQXRIOUxz?=
 =?utf-8?B?ZjB1YUJodDZZQjF4ZVFMR0t1NHl1TUhFelZVZHBrVmNuRTU2R25HZHhrMzVX?=
 =?utf-8?B?aGY0a2tNMTVDTmlzNk91ZlBub0JLNGljQklwSitZclRyM0pIYVlySnRaS0Vz?=
 =?utf-8?B?OEVWQWhnQlovVzh1dlk1ZXQ2emk1Wnp2bWRsOU9RMUMxMU1mWW9HNHZJa1l5?=
 =?utf-8?B?RHlzYytINHJHanFnRFprWmxYMFhxOVF5UTB0cWpVRjFQaWRUSWxJMVBTb0h3?=
 =?utf-8?B?akthaThuYnRWQW9tc2picHg0dHhQVC9DUWd6OEpzTTlTU0NwdW83TE5icGQ2?=
 =?utf-8?B?QXREZTVRelNlVVBFUlE4bnlzMWpScDRyZHZ1RjBJRXc0aW5ueHI3MGthck83?=
 =?utf-8?B?cjMydUs5a1F3Q1o5aGt3TWZPNW1DQXFDbkE3cXBib3puVHdHY3lteVZCMi8y?=
 =?utf-8?B?cWw3L2R5M0pVN3ZPbjZNUmVmbis0enk1Q2JIWW5pOGtGUG5TRm1pSlpxSFpn?=
 =?utf-8?B?QWVISzdUblFlM3ZXTHVCU2ZLTUtsRTY3T0dWM2VWNWFDa041UWI5cnZrZVl2?=
 =?utf-8?B?U0VZdGs2U2l0RmE2MlkvSW85N3F5bVlkYXVoaWlzVlR3NUFsMDVCYU5wa3Fi?=
 =?utf-8?B?WC9sZUpUdlg3VGh4bUtxN0xKdnBmVHlzdHBnNHZ1dHJXQ0dabWNJUG50S1J5?=
 =?utf-8?B?THJsZzgrVGhoUS93eEN4WjFxUDJsMXlETmF0Y2h5Zy9XOVBZeGU2M0VKTlFH?=
 =?utf-8?B?OWEzenJvVVhCWE9nNm01bjg4VXBva3U2TVBFbGRhc0hTckZmVTRHdmYrTWdV?=
 =?utf-8?B?SEZac1ArVXhHK2JVSlY1YlpxcWlQbGZtSmt1MjhyMUttUnJuZkF1OFRWRnRi?=
 =?utf-8?B?V3lyQ09sSHdLSFAyWVg5U0JWek8wT2pUem5kM2d2TDFnM0NWM2pSVll6OVk3?=
 =?utf-8?B?QktyYlQ3YVBQaWNKZnNRN2FsY2ZRM25LZW55ZktWZmVxTkNiODMyZGFZOXVM?=
 =?utf-8?B?VXVsUEttQmZqUzliaHo4cDd5aCtFZGpwQ2p5UzhEa056NDkwbm1mN0NsN3Vr?=
 =?utf-8?B?elRQSGN1TnNWb2RZS2NlV0tGZkxNK01EOVF0dXU0NjFRUDJXQlJScUQwT1A3?=
 =?utf-8?B?RGhLSmpPZmVsSmliYjlTc0JUazd2a20rRjUxRGptYXd3RG1Mc0RtdHhrSDky?=
 =?utf-8?B?NFJaWlU4KzJjZUpOMlIvQWdvR0hMaUdRQ3gwTWtyYUxlOTlxN242aFNYeWQr?=
 =?utf-8?Q?WHyIBzwZ/ylWc41Q=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23237a49-63e8-4a24-5f48-08de46d91430
X-MS-Exchange-CrossTenant-AuthSource: SA1PR13MB6648.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 12:52:09.4695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3K8tcwpld/d3QafOA5wvlpyvBiuhyvY4eNDRf/J2a+9Th9WmyHUE7J8EXy7HtF/zz2YFUicZiRPrOZuHioanLMmjeA/eBo24jQwqZOW5Rl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR13MB7532

Hi Neil, hi Rick,

I'll try to answer both your responses here:

On 28 Dec 2025, at 12:05, Rick Macklem wrote:
> On Sat, Dec 27, 2025 at 9:49 PM NeilBrown <neilb@ownmail.net> wrote:
>> On Sun, 28 Dec 2025, Benjamin Coddington wrote:
>>> On 27 Dec 2025, at 18:06, NeilBrown wrote:
>>>
>>>> On Sun, 28 Dec 2025, Benjamin Coddington wrote:
...

>>> Filehandles are usually pretty easy to reverse engineer.  Once you've seen a
>>> few, the number of bits you need to manipulate to find new things on the
>>> filesystem is pretty small.  That means that (forget about MITM - though
>>> that is still a real threat) even a trusted client might be able to access
>>> objects outside the export root on the same filesystem.
>>
>> So this is only seen to be useful when for sub-directory export?

Well, pretty much yes - let me explain more..

> If this is the case, I'll ask..
>
> If a malicious entity can perform RPCs on the server with faked file
> handles, what stops that malicious entity from doing a
> LOOKUP ".."/LOOKUPP at the root of the subdirectory mount
> to get out of the subtree?

I am targeting a very specific problem, but I've been a little too general
in my cover letter explaining how this work benefits everyone.  That's my
mistake - you guys are too sharp to let it go by.  :)

In a flexfiles setup with a knfsd v3 DS, the MDS can give filehandles to a
client in its ff_data_server4 that the client can't normally discover on its
own because it cannot walk the tree to those files.  The tree will have a
directory with search-only perms: rwx--x--x and root ownership, and root is
squashed for that client.  Files that are linked below this directory can't
be looked up by the client while the MDS (by not having root squashed) can
look them up and selectively give out filehandles for them.

In this setup, the MDS can have control over which clients access which
files on the DS.

Exposing information about the fsid and fileid within the filehandles
themselves and then allowing clients to construct their own acceptable
filehandles circumvents this arrangement.

I do hope (and not!) that you experts can think of another way this
arrangement can be bypassed.

>>> This problem is further exacerbated when using kNFSD as a DS for a flexfiles
>>> setup - the MDS may be performing access checks for objects that the DS does
>>> not.  Manipulating filehandles to a DS can circumvent those access checks.
> I'm not sure why a DS is more vulnerable that any other NFSv3 server.
> (Either the client can be "trusted" to access the DS or it is not. That's what
> exports do.)
>
> An additional concern I'll mention (not knowing how Linux handles this)
> is that file handles (NFSv3 and NFSv4 persistent) are expected to be T-stable,
> which implies that the key cannot change for a very long time, including
> after a server reboot (or even a server reboot after a software upgrade).

Yes indeed - users of this feature will either need to know or have the
unfortunate discovery that key changes will be disastrous.  One important
current commission is documentation about the dangers of arbitrary key
changes.

That being said, it should be possible to create a future feature to allow
the server to switch modes on key change - instead of tightly enforcing one
key, you could arrange to have a list of keys and retire old ones once
clients have stopped using filehandles for them.

> rick

Rick, thanks for reading and thinking about this work.
(more for Neil below):

>> Not being familiar with flexfiles and don't know what that means -
>> though I can imagine that pNFS could add extra complications.

I hope its slightly clearer from the above explanation.

>>>
>>> I can absolutely add more information on this for subsequent postings.
>>
>> That would be helpful - thank.
>>
>> Next question: why are you encrypting the filehandle?  Is there
>> something you want to hide?

Yes!   We want to hide the method the underlying filesystem uses to
identify its inodes, so that it can't be used to identify inodes the client
might not normally be allowed to access through the arrangement I described
above.

>> Normally encryption is for privacy and a MAC (message authentication
>> code) is used for integrity.  Why are you not simply adding a MAC?

Good question - I'll have to think more about why a MAC wouldn't do the job.
So far, I've been thinking about this as I want to give clients an absolute
minimum amount of information about the filesystem on the DS.  Less is more
here - but I can see how a MAC could do the same job and possibly be less
work for the server.

>> With pure encryption you are relying on the fact that changing (or
>> synthesising) a filehandle will probably produce a badly formatted
>> handle  - except that you are only encrypting the bytes after the fsid.
>> So there is less redundancy....  Maybe the generation number is enough
>> to ensure decrypted garbage will never be valid - by it doesn't feel
>> clean.

I agree - that's why..

>> If we are using encryption it would be nice to encrypt the whole fh.
>> Then you would have a single key for the server rather than
>> per-export....

..we do encrypt the whole filehandle here, we just start by hashing the
fileid first because it creates a better hash of the fsid.  If we do AES-CBC
on the filehandle in order (fsid then fileid), then first 16 bytes for each
fsid are identical.  Depending, of course, on fsid size - as you well know
both fsid and fileid can be different sizes - so the encryption uses the
/last/ 16 byte block of the filehandle for the first hash and then uses that
(hashed again) as first block to re-hash the whole filehandle.

>> As Chuck suggested: getting review from someone with crypto design
>> expertise would be a good thing.

Yes - Eric Biggers has responded, I think I need to explain the use-case
more specifically to him and I hope he has good suggestions about the best
way.

>> Thanks,
>> NeilBrown

Thanks very much for looking at this Neil,

Ben

