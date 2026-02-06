Return-Path: <linux-nfs+bounces-18783-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qC4vBIsGhmkRJQQAu9opvQ
	(envelope-from <linux-nfs+bounces-18783-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Feb 2026 16:19:39 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60091FFA54
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Feb 2026 16:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77704304924F
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Feb 2026 15:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBAE30F7E9;
	Fri,  6 Feb 2026 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="blAlVzaM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021092.outbound.protection.outlook.com [40.93.194.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC9C306D2A
	for <linux-nfs@vger.kernel.org>; Fri,  6 Feb 2026 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770390909; cv=fail; b=A+IUfbbyxoMwS21lrC+t9osvyYiARSsFUzE0oFmF3amq4bmNz6uZFttBfO+J1ikBcbRQ8S/OEZoy3qBxvrwfj077IvwuyLW5tyaNUx9u5d3kbOIkbLNMLkeOT+D0Nsa7Mh8BSvqlsiMzQTlJB+Ezg4DCUL5bBY7vZ/DobGd+rJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770390909; c=relaxed/simple;
	bh=SmAKnFowbUMqI2bsYCVyZ+eO1JlXRUb/vvIFpYIr2sA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bk1yq1A3WDqGi0yFLjBrmwJ2yvnB1RCk5JfBvD7Crq7443pzKF0ByxhAjCLWoI0Jfq1rdgK1HHw81HVtcDyFjF4ew6fJXvWQqgLmaoRfE7rn0UThGKC0M4XrVX5GNumcMaushRmkQBmaF4rnpJJwU9TL907ZbxsvuiduoSOUHmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=blAlVzaM; arc=fail smtp.client-ip=40.93.194.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pKumwz1a4n5DScHL6kCtU/vdZLYnGfeQPE89W8Mcmsdf0GE5l44NKM110uJIn13F10Htjc+MvXzAPEUthsiGZDHhrj6tSUy4UkFheyEZvE/GAirc42ZVLcXEwJ2v5JRwBuwMwzrVG3PepVbu2FMpLF6lVvfHYNYFMY56gSwfDZeQ1NvVhdp4iXTNFv/4Zj8Y7GEeqUIUh4YW8eclgv9cKn9p6KmUwkLYtFRriL1m8hsi2lWakfO6AX2QWWAT+Id7w1F3icZPoDpwAPYgvCpW3zclACS6eXaKc9PBgqlQJe1ycais3ZOlpwtPwMgbzZOZQ1/7ckSB4b3ep2QDMsvuzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VP6LfZv9B3MqBeouRjeXWulhjURc2SvNCTufihQ+8VY=;
 b=Xl8RMkKqm7fx7T59xW3xGEs5e5WcHF2ngcQmKpEBu+s6cKuq3y/tR3vqHlMn+5+SJKS71YJSGg6HQg/Chmx2zZDKxhAQcIptpf+kXFmyo67dLAWhumugouEV7DuwaGWgkF5ID7KAJl0ajTCD5Jvvdyql6SHtQRoetFUh4WJeuHh5FxJWfSXeizEOZ6rtncQTBq9oAi419sqThqop1MpYRALi8/hBioV+1nCGWwOwrHLAUWJNPQjkUh9j+ZrgfyR9Yg84Hp5nyWT5hvf/3uOwTgivusTzt87j7rrXXg1J6hFyTLdnX9XKz59vwG4pOibkcSi4zhf4PZUlLVT8LUbOMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VP6LfZv9B3MqBeouRjeXWulhjURc2SvNCTufihQ+8VY=;
 b=blAlVzaMpj0j9+lerZ4/JAOU00jFuanqxm1Ad+Ghjmb/AqdyKkrxwLT6Cvi3Iv+o9TE3el4i+j/hbFDlQSB5N6V+qujfwA0C4YMw2renL9Fyqsoej26YLpoWK/7ItsYpKRPAd4eDF88eB36zo6ah7FwHdkYlE77BWIShHyKfcQk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 SA6PR13MB6879.namprd13.prod.outlook.com (2603:10b6:806:40e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.16; Fri, 6 Feb 2026 15:15:06 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9564.016; Fri, 6 Feb 2026
 15:15:05 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Steve Dickson <steved@redhat.com>,
	Benjamin Coddington <bcodding@hammerspace.com>
Cc: linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v4 0/2] nfs-utils: signed filehandle support
Date: Fri,  6 Feb 2026 10:14:59 -0500
Message-ID: <cover.1770390642.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
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
X-MS-Office365-Filtering-Correlation-Id: 8e0a4d46-d15d-440e-1483-08de659281c5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yl9YNFAty3Z2+7ikBbFWt5R0qKv/RPynNZGYfA8e4Tna2eezPgdpxpbrnAMo?=
 =?us-ascii?Q?oaN9lisY04Ew4mrauU/1UlvuNwtItqhmuo1pUdC/4cqitQpPxZU3kNyJTQjw?=
 =?us-ascii?Q?8Pmfee326b2DR8l+kpb/7I9xij3p/kDBAyvBIpkC/bjS9PIzrpJstTTnpssz?=
 =?us-ascii?Q?lmR5NKsDe5OtCYl0npS9he2yAZ4z1oqz/0wc889aDH3z5RdqWpWG9sIIskYG?=
 =?us-ascii?Q?k8beh8VHMbZ+drLooXKh9jwpFsib/auR+Iguv8SBFapSv40z6RaFBmCCjrxe?=
 =?us-ascii?Q?zvfCyUvEJZzvIZBC/sxh/RgrsinMcdJpLmJzfDFhGnDFAt0Bobra4bKMOE5S?=
 =?us-ascii?Q?bq28ljzAUvGsgnvOSg1YzG4qhdYy8+EZXRgv2mbk4WcoSdJ/V2tUs2bCsfME?=
 =?us-ascii?Q?QmuWdEC/aeAl4bSg+NA/v2XEbifhUh5QXdBRqiBG+U/jdWdoSN0YYvhXp0LW?=
 =?us-ascii?Q?5CAYfQ4BeMPB6sk/LjkIEbwWUGYmfsKa4ghh2j1vSREC4TzmeJrmbRGmXlhc?=
 =?us-ascii?Q?AfILOlPJr7/nHG+OSYveYqMCxAbetLa+QTodIpC8ds88wRPlSd9f5KDisuMC?=
 =?us-ascii?Q?t+dl7Kh7Sa8WsrHf6+QoohouqDsrBXGqRiY4BauAtkdQfqS0D8p/rexAZp9s?=
 =?us-ascii?Q?Ajhxv1iJOTo93CjuOiRL0MUCyI/aN2PsOhczzY0ew/jhfW6v9C8NCcq7i7Ie?=
 =?us-ascii?Q?rhaWL2Bw8Px8QPA8KV9/A6GKz93ta9kx9beVxcetBgs4SG1tbNy++MxxWiO3?=
 =?us-ascii?Q?bPOw664FavBdZU7U2WD9QXFeXlgLEmnj2hwHUfgFzVoHuIO6Tuz3oGiI9Rhe?=
 =?us-ascii?Q?5q+zJV/TM6/cnQG2NnFNVrTp2ECSWxuuZwsBTGyvCFAjjKeIBrqtxkaMrG/w?=
 =?us-ascii?Q?W3dtcsKEa9dek4QzBSlHaGINw1r0oVGQwuFdN69tGqNxANFQ7WrRcM4FZJ0r?=
 =?us-ascii?Q?kNPDKnjKL7YqIPXy3E5//NpNcRM0tcTtKbAR5cQOYEcPpsLeOay/YpjnmfaQ?=
 =?us-ascii?Q?9TDM49lHMs5x3Oymix8ulOMBaKayMM3/bagi0QzHhyXSUvGnx1v41ihMd5BK?=
 =?us-ascii?Q?u0MHRTEfS2Q6OSIaRWPpFOB8it56+IC2V+ydRuPdUWQFMoRF9lIVaFYkFgXJ?=
 =?us-ascii?Q?xPkI27k+4J4wLBFct3o0WAuqoQbstAfxFBKaw/rsmXUfsfNolY/wvly5e7DA?=
 =?us-ascii?Q?TE+Ef9RuPgDgRnvP41W/3HDBNdGlz8Z+gZ2truX99y2TXxwzMWnTbrI7xfXq?=
 =?us-ascii?Q?AgEoQi81qTv0Dr/noGqJmuQgJ8WZHnxJSVLaVfm8kWfXSubcKDmcVrq7k7y/?=
 =?us-ascii?Q?H3KiNAvK67WA89NhGbNJLTVXKtppWL4P7zR4kFe5WT9f1Wj5oTYu2BEYg9cf?=
 =?us-ascii?Q?Vo7mE0GYZMta6ZAsMzQ3N+TGFiY9J2ahP7dfm/479qGYxg4m1Te0Vsi1Y/ay?=
 =?us-ascii?Q?LVF1wOnFs/wxrkjizkIRUaXv2q1HP9qPDaE4K2YM6xSIPFvwMDJ4+XswTsPv?=
 =?us-ascii?Q?CYNfir1fRPHf4weJhwclCi3RAE/RfjgjAN2AszvJZs/2LmcttOA1YN6xgBS5?=
 =?us-ascii?Q?7nUibCZV4WFGrC181KPK2fFkDjXJAIvgirhfQ66d?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k7EW2E291xwNZieWaiKUzaRAYQDMXY/ohIeDMWkjQCFrNpV1dFjdlnK53P0b?=
 =?us-ascii?Q?HUTRltYNFre8SH+DPc3BHUzFSMJHDAb2MP8RQwAvaW58j7lUo+SHM551ZyDw?=
 =?us-ascii?Q?8Dpt4++JP1lbaWtTyDwP36J5XcOlkBJLGPjiadtfQiqvS1jA94zTY8pbD4oj?=
 =?us-ascii?Q?2M2CgTUXXJpQOi9rIoLpfA7hCQhs3MDz1cgwzTQB4HUmiWVV9F4oaCCPl17k?=
 =?us-ascii?Q?Vr60N1ETYg306aDfPGAC0CdUv82vkrlwBbqA9Ss0sSM1qf8CJolAysEaMPn6?=
 =?us-ascii?Q?cJnAXTOucXdy2+SGRK0bSPpLdmJTpjvaxBpBGFXQUmlOLPkrsUTeIHABbfSd?=
 =?us-ascii?Q?gyR1pp1T3k+n0mbF4vMZ1I1aK9YjkMI8fKjRLyDipSyl+PA62u5EsmttMODO?=
 =?us-ascii?Q?4Nv5Rjs4ktjTq9ZmL6zSsMyFf0+mVvHxYzMGm/+P80N6eSbWwkT4jFo5SLdz?=
 =?us-ascii?Q?uWTy3r0D6n17ol4heIRJjK/VTIK8Bxl/podyug0S9XiP7Q/muER9RNWaTX7y?=
 =?us-ascii?Q?jzOJ8umY02YewW8LsT6ERYRNW/r19Yqsqiz0mz4+K8ZoTUA6uDQI8lkRmEfB?=
 =?us-ascii?Q?+RLsYtxr02tpgupgvSubbdwnhPJCrS5vTDXn3WPWUZ+xwf1WhuDxjlCuBDSM?=
 =?us-ascii?Q?3Von5XFAfcMFst5y6WPZCgYF6HfCe85+IdywDGWtrvAWroS6f1J2p2PLwMuK?=
 =?us-ascii?Q?Cg3lDMZbdIGFoiaZ8xd1JttQgBcTk0zE7nL+EUz4amKaP1gV5jLCJCfBPuVn?=
 =?us-ascii?Q?TBOj5qseJc27pxI2HBsCSNjrOnfvFAjUOP7jQ1lpZvwqnFs2ZA0kUzvA17Nw?=
 =?us-ascii?Q?fpoUOPe2F0Jd974jgUhlBGhTYphXDbwiSR5R5h7+HQG3jCEkVeKy0nUdk1F3?=
 =?us-ascii?Q?NoUnSoze0mqTE6j5Vfkq+ttm4GF1v+hopG3LML2XZilAJSidOZSaF/QjLk62?=
 =?us-ascii?Q?FUWFQeBLaKQrIF+GRx/cc1LKU3Z0eaqB+dIjHP7JaKjug/+o3vHx9Nx3s3Hh?=
 =?us-ascii?Q?F6kURrDUNgJ1UpLr/8mP6yBRiYnG/cU6s8c51PfOqoe1S7FMtSZ0WD/N5jcX?=
 =?us-ascii?Q?QsKFbzXC7VV9aFCVejOlIIceYpE1ER6UgJ1bHlllggvyUfYUcYZ1mSOBMFh8?=
 =?us-ascii?Q?S2U3mJdn+eEdDEXwjzAuNaBZf011goRMtF/J9JCA8jqQ1MWesnzZDXlsOFFN?=
 =?us-ascii?Q?jLdo2Sf3JPrJatxlTPM4RkaJOgeQvooCMw+kOrQgYqv2Qc7VisEz54cjdCEQ?=
 =?us-ascii?Q?c5K6BrbJSTjuq8v+RkmL1qRQmhI82sFdKatMSSwDDZPP9coGmdWXwLYDnDn8?=
 =?us-ascii?Q?nT9bbh3gEvZEqR76qa8wTQAjIQ9ofsWn73SRneAgqNZO43i93xATn98eNwat?=
 =?us-ascii?Q?RDlPOAviRIUHrm7eeBj1BnKy88FMP9mXvyB1sUnW8/0fj/rTBaCahAkffV7S?=
 =?us-ascii?Q?OaBKA5goOzQbkny1zDUu8wDw/bwqxBa6866wkLqlmzt6sSiYWKmMfFxqvoxg?=
 =?us-ascii?Q?F68LnxT0y9MaTRzhfEuw1GjpB2h38/bYwy/ZkSEhk+EAkmBuYpo4TPyMraia?=
 =?us-ascii?Q?GKYEYvG216iRYGs7LdrpBiyhWmAkF3A8S5vwmGFUGgXn8qs4L7/aJFAiVUkb?=
 =?us-ascii?Q?PEDRHzE6WUPzjJBvHc+DS/mGcYpMGimRKOmRE0LMNtB+Y46afVbkLJFpzmGQ?=
 =?us-ascii?Q?FB343gim7nQ7x3V2cyOFVOiduKgkX8Jgpo0R2jCeFqOA2Bvjsi7PemHWSfKX?=
 =?us-ascii?Q?YUYRCcdDsHgq+r83dLHcP3WqOXVnK/I=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e0a4d46-d15d-440e-1483-08de659281c5
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 15:15:05.3570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J9Ktw1dyvA7855vAvtg5foRAlbEyc8ARO+zW4YEuoDbT3DOeVkx/mXN3iIn7KnuCiE7o3+1FsaFj7TFlovWxyWtKzuMNDPVEuX1WUiABs4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR13MB6879
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18783-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:mid,hammerspace.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 60091FFA54
X-Rspamd-Action: no action

Here are two patches allowing userspace to set a secret key for kNFSD to
sign filehandles, and also set the option to sign filehandles for an
export.

The secret key passed to the server is the first 128 bits of a sha1 hash of
the contents of a file configured via the nfs.conf server section
"fh_key_file".  Exports that have the option "sign_fh" set will cause the
server to use this key to append an 8-byte siphash of the filehandle onto
each filehandle.

This version of the userspace patches correspond with the v4 of the kernel
changes which have been posted here:
https://lore.kernel.org/linux-nfs/cover.1770390036.git.bcodding@hammerspace.com

This work is based on a branch that includes Jeff Layton's patch for
min-threads:
https://lore.kernel.org/linux-nfs/20260112-minthreads-v1-1-30c5f4113720@kernel.org/

.. and Jeff Layton's v2 series to fix up userspace handling of kernels that
may not support the most recent netlink attributes:
https://lore.kernel.org/linux-nfs/20260204-minthreads-v2-0-a7eba34201e9@kernel.org/

Comments and critique welcomed.

Benjamin Coddington (2):
  exportfs: Add support for export option sign_fh
  nfsdctl/rpc.nfsd: Add support for passing encrypted filehandle key

 nfs.conf                     |  1 +
 support/include/nfs/export.h |  2 +-
 support/include/nfslib.h     |  2 +
 support/nfs/Makefile.am      |  4 +-
 support/nfs/exports.c        |  4 ++
 support/nfs/fh_key_file.c    | 79 ++++++++++++++++++++++++++++++++++++
 systemd/nfs.conf.man         |  1 +
 utils/exportfs/exportfs.c    |  2 +
 utils/exportfs/exports.man   |  9 ++++
 utils/nfsd/nfssvc.h          |  1 +
 utils/nfsdctl/nfsd_netlink.h |  1 +
 utils/nfsdctl/nfsdctl.c      | 39 ++++++++++++++++--
 12 files changed, 138 insertions(+), 7 deletions(-)
 create mode 100644 support/nfs/fh_key_file.c


base-commit: 8f54511aefe1455161a6c4406ed8c770139f61e3
prerequisite-patch-id: b0d57152c98d360daa9a71e6fa9759b7eb9de348
prerequisite-patch-id: 99680869954aef9f878c24ec9ee1302ab7f24b1a
prerequisite-patch-id: 2ab31271461352d11bcce760e45573f9e6459553
prerequisite-patch-id: 22c392c9dba2e63916af6cd8fbf4e9d6bce9d01c
prerequisite-patch-id: 50f6f48932426f89060eb77de58718baa80b979f
-- 
2.50.1


