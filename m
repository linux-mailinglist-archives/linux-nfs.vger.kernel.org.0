Return-Path: <linux-nfs+bounces-18782-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOoOEEgGhmkRJQQAu9opvQ
	(envelope-from <linux-nfs+bounces-18782-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Feb 2026 16:18:32 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CABFFA0B
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Feb 2026 16:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44CBC301E7E0
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Feb 2026 15:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB632882DB;
	Fri,  6 Feb 2026 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="POrW+FBE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021092.outbound.protection.outlook.com [40.93.194.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8B0288C0E
	for <linux-nfs@vger.kernel.org>; Fri,  6 Feb 2026 15:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770390909; cv=fail; b=cyLMwl0Z5MwqNoQJD2GdDjM9fxsRmoU2dXS1iBu+fp3k8f/k7CcOxZG8POZQ/0mmuHBv9KTFVHfV1gJrMTqiitFCvn46UUa/e0VP4ZyLQ1ta+GdJ1c+nP9nUYfKlY7AEWcYcKC/xKUEzCL4odzZ48B1Nr1KcyH9z68EcJvQt41o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770390909; c=relaxed/simple;
	bh=a4CanQsX3/0SLnfT1lIQ/k1ixezbpRTLrVukv8Kqwbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o4RqnohH406jXoOwflSzepHtcR5vq6soFCkeXwGe4E07801WiDvcKPaSmOGehHA2qqf/AC3gyWtNwT/hD3S4aHl/mjqX0noDEsDR7vP73JSRD6W1xQUZyVkKg6p1erDUsHDMJ6YdQxBXHA0+Ea9TS2yHX++zlw71B2Kni2X/CPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=POrW+FBE; arc=fail smtp.client-ip=40.93.194.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9PDIj6yDf1l1LL61LzNVAj3JlnX2If39G4OlguaKs1kbbyeC0MJhMfy59ZYHj0sGldggOrW2AlQhVb60VAQe21GwRqsXw4ILOnf+ZRydYni5y2zLV0qVnbCHh+qhYbT8yGO12cVq9OU01k+AHRFrwOOvdwnpPvmeL4AtMbCRHVl+05M1JuqNk6eCZXRuLw5/stZbH77Fk2VSpXUZDDRL672S6/gO/iL11BfGrJXNpPX9RPRZ31U9OMMc8cQTK45o9m/HP05F3MpYx665ZKwKH+oWjCX7DHdRcmBnN9YHNryZFUOLLNLA8aca36P2kWAyFStTnngP1/ch+FujDnKZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2dgSbxMbGvzSjdIyPnvkatJSFu3Q691dmkcoi+cM18=;
 b=CPeGuDEYWyU430b4vA1Sq1PYgU38dIU0bZAyt49jO6y4m31Kv1bbvpMUjGYTW0LNUrjouZBnWZtcr98x5MIAr4/dqs06IoNYdciKimT7p8b1xhOpWjK0hnfJczI8jeQIahas3JfSx49lt5j1eT619pEto2If2gYgeFJpx5QSzS36NqVPSDL2BKgr4xEL5vi8q+T8fWHQuUQbrB8DkpUdbldLgsyIBRGNVKOmDy+kFMjPPLn4OW68VRlrzgtq7MdrneZTDzCaUssNoXn7u/zD0NKtxzblRNqt7uZLjJJkurmFCH2+f3VbQKhVw81irZ097dB5i7+xybV3Tx5tpxVX4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2dgSbxMbGvzSjdIyPnvkatJSFu3Q691dmkcoi+cM18=;
 b=POrW+FBE7vGLKOUV3bvTvMHaaaCkk2bcfFQq3eMfgnAXwYE43GdtQ+UFfpao4YVMqwhiztr1QwdaD1327WrxFjy5Xdy8MFb3G2IO1UM6TsUYSeyUUuQAO9EPSp5H7JTkXPvkVuKwdTLK9oumwmrYlfv6+ikZwQHhLwH7tdlVqdk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 SA6PR13MB6879.namprd13.prod.outlook.com (2603:10b6:806:40e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.16; Fri, 6 Feb 2026 15:15:07 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9564.016; Fri, 6 Feb 2026
 15:15:07 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Steve Dickson <steved@redhat.com>,
	Benjamin Coddington <bcodding@hammerspace.com>
Cc: linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v4 1/2] exportfs: Add support for export option sign_fh
Date: Fri,  6 Feb 2026 10:15:00 -0500
Message-ID: <69c1c5e20afa59d236982982f651833f5e2ad061.1770390642.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1770390642.git.bcodding@hammerspace.com>
References: <cover.1770390642.git.bcodding@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P220CA0051.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:2d9::34) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|SA6PR13MB6879:EE_
X-MS-Office365-Filtering-Correlation-Id: b0984f02-3bef-4e9c-f06a-08de659282c0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WjPnzCOLddwJIHZDNp1Koi3qiwg4F9UTa+AcHY1nF+SD/UK69hyZ8IrkExUd?=
 =?us-ascii?Q?/ijj+HozOzoQd7LvGa5cmdRaTNn3FOcMsbzJ2O/JuCxPP5cT2VLeQDjkLGfp?=
 =?us-ascii?Q?+qqk1sMQuiBn5xy4was3bNImH7u01rEESAOMS4gtyrwv/EfdLlr71T+ou02d?=
 =?us-ascii?Q?LDfkXYATi1ZgoznCDKnCIFdIL/kP3a4sIpDdXHktY2CD7ChR6mK3Aa+RLezD?=
 =?us-ascii?Q?RoHA1oD8Q24IgsqAGEoRhduZiW2h2ONnF3G4reKoDThTZs9MsGmn5VBm2c0C?=
 =?us-ascii?Q?Z1eJTFLqM2iLGFSNNOgXZbNULAKVSAaePkSsUXd3IhE/nXRLlqeUJLkkQCuc?=
 =?us-ascii?Q?KDCmb7xmRTQekHqIsMm9Jewau/PHjq3nldqBo3z9S/16w4cq0Rp1v8RUH6SF?=
 =?us-ascii?Q?mkYPV2qIdFle1dI72Yc5roM5IMjDAWLt8Jy5phfrKFcd8Q1RrPD0WFXzvAgx?=
 =?us-ascii?Q?lBX4Yjuad2jqoVvhpYPnNv6tGmmjlUeJmAP3CD4FOqyKQxSQFN0voHyiZy/l?=
 =?us-ascii?Q?YkD4ECrK+Vo1uO+IfgTSFb16QEd0wo4x8CnL1Qm5bIe0LusBGQdgbDHzfqE9?=
 =?us-ascii?Q?DZllP5vf6G+eyDhYYlC18t2gB7bFJTg+GBKDZJHxm6s/aSVPIRHhnoJfhwrF?=
 =?us-ascii?Q?iw+rtidNepz9h6GknCmH0XKgfMDiEmdXRoETE+pgr3fdoQR/6zQ34YdiFaVv?=
 =?us-ascii?Q?Jcm3k/Tgg6V7XrKLktNeerHaRbo/wRL1Ad+k2iBzD0Xo59LO9fZKVYLE5IHF?=
 =?us-ascii?Q?X0oAd4TPau6nFw5LTRIrRwKbkyB1R+VUU7lMnO7flWKvj4fM5mdKDW+AHGBZ?=
 =?us-ascii?Q?iQVJyak9F9x6pyiRS3avkn5qB+889ixt9pRcyxJbyLNTl0QOHWf6vrs7inkx?=
 =?us-ascii?Q?bptxCF8Nqvwqh0rkcO/EVoARAFKamrFzX9Kw5DyPdkv5Y2ckkCmzXfs8Ckl8?=
 =?us-ascii?Q?pcfQV7L+YMqHw022b4eQV/5aWvzjm+aEo7t7W+EPGC1GNAzM0NZz53ssC5Jr?=
 =?us-ascii?Q?FJkMxgn6fuuu+iAWbntFGACXLe4iCoS89KTcWvWA9rfNRDlVdrA7WbAoH1h6?=
 =?us-ascii?Q?3kokfffYMknD/m0SRL40NX6Kngi3mQaloEAVpb1gTZ486PyDtUNYoR001Rr8?=
 =?us-ascii?Q?RtRhWaPjdjOwGfeiBHaO7QNpnhcxrRANZS7byHe2vF4NwQgq/InPZgSXjALQ?=
 =?us-ascii?Q?nNdNuySAdLv+2+gAQ5E++x9n3Ul035icFGw+x4iUkiedWDOpT/iwVaRxwRxQ?=
 =?us-ascii?Q?6o5AgSZn6TNQJnacRpFGLyPyEwz4hzrp3KXeyQyJCAyGw323I8aDi4W4/vie?=
 =?us-ascii?Q?XnKGH+IVuGr4F4joWiCFMDc0N98Pjlq4z02rNl4xHLRmG55uupoZIGAcbTDF?=
 =?us-ascii?Q?xvlEYScMssg5dB1O0BD+ktaEpctRXXHRj+eAvxRh0oE/9X5/KW67stKVjj8X?=
 =?us-ascii?Q?PWDIPr8hLwMK7N6iUPie+sVK+xVjXZTQkO0drnFki9A/xklGLBJsde1lFpBQ?=
 =?us-ascii?Q?m9D0LqsQLsoua3Km8EVMOcPWPmq4sOdmPT2jtjkOJxjr/AEdxkfmlWTq5PM4?=
 =?us-ascii?Q?1ekIrw/UsiKXAqoDWTc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LpkRhTlBJUmj4cPvc0IMQZTisyvyiXn/7DDrb4565Dh4LBb6WggBNYBRFtZq?=
 =?us-ascii?Q?K2Tl7NOxnQb5Y2zwLqor0IBCCBRGLdFJVwkBLNo1umciJawMsk8rkgeOo1m+?=
 =?us-ascii?Q?tBT1spZ56XpGNJvixLPF3zkAb+WbeJ2Zx27GbMDwGJOgJj07lZEzV9aU2BKD?=
 =?us-ascii?Q?N2/RrLytpLi7xP3Z3lA6KAmnHC8XMYzI7FSBiSa4dPT6vB5cUWQ3GwgGfpLW?=
 =?us-ascii?Q?jbD/06H3YF21Gk3yIIgz2rz61ECRX7q3X3QxysF5J7Jn4tVEsXI798IrCpPT?=
 =?us-ascii?Q?mbXsdqmNL8QjHmN85vNW8B77Aj/MajENKJL9KpEI97Tb5tux9cc+TrSARlmj?=
 =?us-ascii?Q?VYG1lYeOkuC1wCUjUqyjJZ9225nLQbRZlKf76dsdGyplAVu9tmvhB2nJ1Txf?=
 =?us-ascii?Q?0qvhASWy9kDItxS2KH02TJrV4ScBJKwSLXMQORSY8xFETEccpZhRAyPjmrDo?=
 =?us-ascii?Q?/cxOGqr7Qax9f3sKPGFXz5tWrJzqF+oYZJGMStSrWI/EnVleTd+gQ96V0FFt?=
 =?us-ascii?Q?Yi4gibCJTUlAMUjmJwe1jsL2Je2VaDzlzY1Q3FH3TAf+7nnVf2TJchGnwPYj?=
 =?us-ascii?Q?qr2MMO0oKFf1AgFOeKYnn8EmkTzSgIEx9i5R6CqbeXteqVoQ7v+269/YY1lM?=
 =?us-ascii?Q?n2muUBHNEaja9z4HyE0WJqwwBRyUfgLWoimd8mUcKwpS8huahKVkvD2mpexw?=
 =?us-ascii?Q?t9SXF5qFUZ6C2t2S5P1NmTerKW6TXX/kAZ78jT6OVHj7EQ4pJFlwZT3YGM9d?=
 =?us-ascii?Q?wcjtNEkpkCHOjp6rZ0KDcye2sHei8f6MVDn6jVRmtPLMXYhjt8g7Myn1l4ML?=
 =?us-ascii?Q?ZQDM0A+xqIPEyLZyffxoCKCAh46l9ccncmnABpm2uc8UxHYjDy8/J6FO7N3d?=
 =?us-ascii?Q?VRah5KbW7j2xdUBkQr9MOcv+4+nh+q4tCkbNRzZdrA2ulYBoaCEivBB50eup?=
 =?us-ascii?Q?KrcXEL84+ccmLHiS4CY+2Yd3aLBmofQkV88YwW3j/dt1d5ApVejjtWQADkdD?=
 =?us-ascii?Q?g0IWTufnRlsjvuuP1a+GJhaP3+dskb4uzVmbF3ngdQedvndQxyt4lf6pg11W?=
 =?us-ascii?Q?obZ1HCE1QacqH08RsXnNl0lwD76P8lVEuy76eMTv66LLmBOoXumRhZVgk13x?=
 =?us-ascii?Q?IrOBpsB+dsmJ+VjXxD8GPHzBE1wN4JtujUZExkxEElaiRwLMDZnAXf9GuqvS?=
 =?us-ascii?Q?1qTLvkhi/HLUfu4Y4yaitc4f2990RqfOUsU0PxT9c8tiiOSMsI1MHWCCvL0M?=
 =?us-ascii?Q?va6tDbo9suHGiDfWYX7TtVhJclYd0/05N0CLwXclFeHFSrN4IFM2o4rJMusZ?=
 =?us-ascii?Q?r4WYHP5UYuFzP8e9gYQDrfmqEN8Xkw9ea0x+wnY8crb879VtsZBdn97oWZmR?=
 =?us-ascii?Q?E4Nj9g0NegajckqL/bcEtm17VEwo43Fwp5FWq41/rc3JqQuHn4bL0CrNzCSr?=
 =?us-ascii?Q?xbxlsQRuiOsTQ8D4z9JmaIoPM9PnEX4fsnLKPiIvq9Vs2DGYSCiTRvIbxXZ4?=
 =?us-ascii?Q?pw4qi3J0v/9apEYbuo/x3O1RiVdeOlStaKjRjgN/VOW1GLskJhrabtf2Zf5k?=
 =?us-ascii?Q?4Q4r6SwV4e+m6HM0i3tMumvcDkim5wL+GxlPYQpwubHNjZWfQt5Hj0HwO14k?=
 =?us-ascii?Q?XCATplFa9iGeel4HE6EXKB26frL2DbhasXZwCs7ekBu3ZLYp+fLlFMg37TjM?=
 =?us-ascii?Q?/fCDl6U1TWFfdtPv6GbbXAT58icawECjTwQm0uKWDUPBmRP2IzIIa6Dx4miy?=
 =?us-ascii?Q?55sTT/uFHLedj89w36jWprMHMjKUhkc=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0984f02-3bef-4e9c-f06a-08de659282c0
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 15:15:07.0682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ftPGNPIXj/Hmfa1aopwXKwHV+RrMFZtIq0sapu3PKuUfdaQW6+cyGZ41QLCrnDfqZ/WWzDnnCQb6KD5xWRnQ1IH9UB+Ak+Tv4JcD4DBexQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR13MB6879
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18782-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hammerspace.com:email,hammerspace.com:dkim,hammerspace.com:mid]
X-Rspamd-Queue-Id: A9CABFFA0B
X-Rspamd-Action: no action

If configured with "sign_fh", exports will be flagged to signal that
filehandles should be signed with a Message Authentication Code (MAC).

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
---
 support/include/nfs/export.h | 2 +-
 support/nfs/exports.c        | 4 ++++
 utils/exportfs/exportfs.c    | 2 ++
 utils/exportfs/exports.man   | 9 +++++++++
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/support/include/nfs/export.h b/support/include/nfs/export.h
index be5867cffc3c..ef3f3e7ea684 100644
--- a/support/include/nfs/export.h
+++ b/support/include/nfs/export.h
@@ -19,7 +19,7 @@
 #define NFSEXP_GATHERED_WRITES	0x0020
 #define NFSEXP_NOREADDIRPLUS	0x0040
 #define NFSEXP_SECURITY_LABEL	0x0080
-/* 0x100 unused */
+#define NFSEXP_SIGN_FH		0x0100
 #define NFSEXP_NOHIDE		0x0200
 #define NFSEXP_NOSUBTREECHECK	0x0400
 #define NFSEXP_NOAUTHNLM	0x0800
diff --git a/support/nfs/exports.c b/support/nfs/exports.c
index 21ec6486ba3d..6b4ca87ee957 100644
--- a/support/nfs/exports.c
+++ b/support/nfs/exports.c
@@ -310,6 +310,8 @@ putexportent(struct exportent *ep)
 		fprintf(fp, "nordirplus,");
 	if (ep->e_flags & NFSEXP_SECURITY_LABEL)
 		fprintf(fp, "security_label,");
+	if (ep->e_flags & NFSEXP_SIGN_FH)
+		fprintf(fp, "sign_fh,");
 	fprintf(fp, "%spnfs,", (ep->e_flags & NFSEXP_PNFS)? "" : "no_");
 	if (ep->e_flags & NFSEXP_FSID) {
 		fprintf(fp, "fsid=%d,", ep->e_fsid);
@@ -676,6 +678,8 @@ parseopts(char *cp, struct exportent *ep, int *had_subtree_opt_ptr)
 			setflags(NFSEXP_NOREADDIRPLUS, active, ep);
 		else if (!strcmp(opt, "security_label"))
 			setflags(NFSEXP_SECURITY_LABEL, active, ep);
+		else if (!strcmp(opt, "sign_fh"))
+			setflags(NFSEXP_SIGN_FH, active, ep);
 		else if (!strcmp(opt, "nohide"))
 			setflags(NFSEXP_NOHIDE, active, ep);
 		else if (!strcmp(opt, "hide"))
diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
index 748c38e3e966..54ce62c5ce9a 100644
--- a/utils/exportfs/exportfs.c
+++ b/utils/exportfs/exportfs.c
@@ -718,6 +718,8 @@ dump(int verbose, int export_format)
 				c = dumpopt(c, "nordirplus");
 			if (ep->e_flags & NFSEXP_SECURITY_LABEL)
 				c = dumpopt(c, "security_label");
+			if (ep->e_flags & NFSEXP_SIGN_FH)
+				c = dumpopt(c, "sign_fh");
 			if (ep->e_flags & NFSEXP_NOACL)
 				c = dumpopt(c, "no_acl");
 			if (ep->e_flags & NFSEXP_PNFS)
diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
index efbc6ef65c5f..7f0278fb8d33 100644
--- a/utils/exportfs/exports.man
+++ b/utils/exportfs/exports.man
@@ -351,6 +351,15 @@ file.  If you put neither option,
 .B exportfs
 will warn you that the change has occurred.
 
+.TP
+.IR sign_fh
+This option enforces signing filehandles on the export.  If the server has
+been configured with a secret key for such purpose, filehandles will include
+a hash to verify the filehandle was created by the server in order to guard
+against filehandle guessing attacks which can bypass path-name based access
+restrictions.  Note that for NFSv3 some exported filesystems may exceed the
+maximum filehandle size when the signing hash is added.
+
 .TP
 .IR insecure_locks
 .TP
-- 
2.50.1


