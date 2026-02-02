Return-Path: <linux-nfs+bounces-18648-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPpJO3zYgGnMBwMAu9opvQ
	(envelope-from <linux-nfs+bounces-18648-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 02 Feb 2026 18:01:48 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1A4CF4D1
	for <lists+linux-nfs@lfdr.de>; Mon, 02 Feb 2026 18:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6235A3020015
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Feb 2026 16:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11602798ED;
	Mon,  2 Feb 2026 16:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="J9jTgWX2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020089.outbound.protection.outlook.com [52.101.193.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9513803F1
	for <linux-nfs@vger.kernel.org>; Mon,  2 Feb 2026 16:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770051576; cv=fail; b=Jkfbr1oWRxK7kL9XJGbXjXen/53b4Xnk8h81EN6Jci4PvMZjzcOKwrvdJpdAO4PMD0fwbt/xrFLcIMm/NMzMH9jVTk8o9ieJ7so1UI0Vhs/uUx4pYePp5EG0C6YFeWIcB2jjBzCvxdQ7yjRdsNp+arlWO+wypinLp1KcgTTn/wI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770051576; c=relaxed/simple;
	bh=oJSZgMBXUpVk9ndlPSxiS3nxWluxIpkVQcebD0AHkN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c4bkU5TjMR5oxSM1szw0xIns1RslN5DQ7LB2zp6miImBGRSRoNVcAfnAOY0+XKuXc813LBdM3d9V+O6giaHCnnpmV81WbnVWVqhSxIUcxq1BiOnoqXU417JWAYicXcuH4Y+p7I6UmVuiMutASdwuCloB+8OIw1yHsjwjmuEhC2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=J9jTgWX2; arc=fail smtp.client-ip=52.101.193.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TogyXYegLyFC8lknmudRmlmwJesZWkvdQy7MDzmPiYJ/ixvIh9IH5c+qko41SdjI/8VO5DjX75FHNdWtSbdh71yGKnwpMT2l+w1yKCD3+X4KtE+tUXBCeAEYWPqSI0JSSC66cpZ5WBrHbYKqIePf9fgiE5VH6KqEQ4dbpzZdcojdAnQXJMzz4unML4/iKb7+aqW44fBP9wTQo+rf4xS2BAeF9gWDPJX7r2SZzxXKWuXtdAYXuZJJnj8ZP94L8tXA5HiP/RhQZbCm0UfvEZAvTi7AIB1588W9VGNcCyoJxp6NBooaoZl1jA02QW6R28UtENZVmincMmkVDM8y9beROQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=siLEgEtD/shS6q3OlwDeSr2N3fwqRVazYVFuYasybXQ=;
 b=vBRR8DxHaCGlJqlMjYIleC66HsTxAQkiz/+knILpjlmegnrCRHAMBmuN7OzOMTCZGoQ7TwSoyvaT1N7TwX5hgcDGaGtVL1v4MoRDNXQuAY/xp3Oy+1v2qmkmg/UXYtCesdoGcAGirsL2jTeqKOBez2d2ATHIVmVzPPwvZW71oSX66RyknHVqspyvnO4IKeXdI4FUJMEFwekEVw16brHdxE+BXJcC23KbuXoGfe5x5FwM345vm8vdNht9xjK/fuetObgI/OgjLF4ujVfTBzjrFSAWprmTqt7IwOvdCzhkwMt//tL1bF2ObrZAOGV25N3QvrSWBNXJ4wyahasO8m8wdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siLEgEtD/shS6q3OlwDeSr2N3fwqRVazYVFuYasybXQ=;
 b=J9jTgWX2pahWUbdvit+JuoFZu8EK8MaUabOENA9KO3AorUP603wb7JP/q8QdnIvU/fPWYerhWm/PFaG9GkZboSVtx/aftQhJDyGxQkEVBh9g47XeLdXQBp3BBdxanr22guyP9qho2uP8DwPJSChzYZgK3G2SIm2gEVZ6kCCJlP4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 MW5PR13MB5488.namprd13.prod.outlook.com (2603:10b6:303:191::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.14; Mon, 2 Feb
 2026 16:59:29 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 16:59:29 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Steve Dickson <steved@redhat.com>,
	Benjamin Coddington <bcodding@hammerspace.com>
Cc: linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v3 2/2] nfsdctl/rpc.nfsd: Add support for passing encrypted filehandle key
Date: Mon,  2 Feb 2026 11:59:22 -0500
Message-ID: <1b3bdf869fe4075689fd29fe3fdb669ae3ea920c.1770051230.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1770051230.git.bcodding@hammerspace.com>
References: <cover.1770051230.git.bcodding@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:a03:40::34) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|MW5PR13MB5488:EE_
X-MS-Office365-Filtering-Correlation-Id: a84a4a8c-44bc-48ac-bafb-08de627c6dc2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IvP4Q/wltJb3XPzu7wCTLHecjO5CobsYDozfA9IhAWAiHVOp9s7fLbaSUWF0?=
 =?us-ascii?Q?SbGlbQYaZHrQkxEKzw0cbFlOBqCE1TUhs2phBAMlVYcI+i1kpafAfQKgwy1+?=
 =?us-ascii?Q?ueeECWTrQx0sF94tCJj5+uvWGaKoe3RbL9p5vBDUh6+Zop7OTYdK46KjBhi2?=
 =?us-ascii?Q?sr0XCm8QFbMyHRD9jUvecMsFkYqZjiAt+crGj7jPAxi6Aos27PUQJl3q3i0C?=
 =?us-ascii?Q?uASRrcdcN9ZZMKzGxOpbvoQWI58Ej5M8YLtz9nrQNZCopBPXXOKt3lIdAU/y?=
 =?us-ascii?Q?93iKK/3RUkdrdHMdtjMcHNghTBDEkwlNMx+I2M6tAP4TMrvdvtSfgWQYp0kP?=
 =?us-ascii?Q?T7f8RtiFsKfxnUp2zLbGE7ozPspjRfkSszM6XUbnHyf9Y/voAMSk3ETQ/G2G?=
 =?us-ascii?Q?QKzkJeazPNXonWFl0uqkt6+fAOZkf7rMLveOKpXzIY28vBuXowylOc2bxCKD?=
 =?us-ascii?Q?h9DbJ+SKDqHlulDJ9iphApW/gzUadyuXqcFWj9KByW6tcexs/LTc8yegoMNG?=
 =?us-ascii?Q?uxT+uRQT//F6rh2D8qtngDvSW6PCygehJo5d/0JRfxsKyFGWSEMaOrk5bjxR?=
 =?us-ascii?Q?vVf/5EkKHrnotMe67UBRF9X/zHvnhDjKjF+b2gZWFYZu/M92YqvChGGAaePf?=
 =?us-ascii?Q?mCFD0HeLBUg6kfPxtL3lzYujiTbyP1dPODxuYfGqTU1vZCmgOxPSr2BinA9P?=
 =?us-ascii?Q?Ii6zq0TWIVy8zLIAk6G+4MohSqQyyNOy3uEDtHhtIva12PHh9nudFH8HzB36?=
 =?us-ascii?Q?du/sCTh/68zNOOxVErxak0y3BnCk24nYSk6WPjXuCXKOtk682RihCJkxWOvT?=
 =?us-ascii?Q?Y97LN1grRGrUlhnqgzrxcPIqdCub2aO8VTie2hDyynMX2Y3wzTGDG8nYChTr?=
 =?us-ascii?Q?SWgpVtZGzOXCH5gbAhFFbLggfhpyjhTrdcZgTEg5tXrYQWMS1fYYaCUz1Cqa?=
 =?us-ascii?Q?iGKplJrrYgIrll5j/gg72q6Dt8NxuC54Vo7auyDVuMcZK+q1AkgKwnVxuI0I?=
 =?us-ascii?Q?Wgf1i5dMiFer6nsA01hMYXULK4foIBv6Wb1vpfiJZ2Z6wIOFyCYg6mJP+XfN?=
 =?us-ascii?Q?LmnQ48G1OxeNAWnqTA1gIVuYWwpzEocR7mZz8m5CewfgiDdGviWNI9PKKlMo?=
 =?us-ascii?Q?8p8WObDlnlsbqQF9T8qwFhgspVc2incAqLbmDqdv86j53JsNtFSnhXy4Hwty?=
 =?us-ascii?Q?gajQ9U8R5Gtq23Q3eSJkURq+EZ6CzdN0buaM4snXxKMJYgBalN7q61Ve+Jfk?=
 =?us-ascii?Q?jha2pROT4/oVw4Wfo/iagIGj6/SnfM6TWNHqSp4rzzS97qes5JIGHDAYIpvQ?=
 =?us-ascii?Q?iVKj2CjlPLex30/F4PdrJztg5HB5yM/UTFyV853+32LAA4SVnh2aRuq1XQj/?=
 =?us-ascii?Q?Gp2dywHuLGNMJQEARe9amF++Clev9OLVTkbn5kmySo0LaVlE/CcfP/gPvvZT?=
 =?us-ascii?Q?wwRImEfUU+z9D2NvcXP+WsAyU/Ja5DtfWQ1Vbp0IlqBWY0sSc9JBVMxKWvKX?=
 =?us-ascii?Q?1q1ps+oxukgXrE4woaIK4fcErc/Frff496jZdEncRAS7SUwXTno7jed//O5e?=
 =?us-ascii?Q?eUfzfcLe6NPROC0Ss/c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xsNieS9trwdgMIXC4vlxnDjVRBEthYIN4WDtMFsm0yPqTtxkYLUTPZRfabGa?=
 =?us-ascii?Q?KIDpLngkMq20+gGXh1lKqXa2kGZq2BPxW/9CyswKAhPo5wIXXOtn56nBdW1t?=
 =?us-ascii?Q?LL3B7FVac11G97/jDO9vB2bpRGmUfYORGYoX91hKC76Gw+jISuvM3RVivhx1?=
 =?us-ascii?Q?4hj6Vju9JqTQvKCLgGcgN0gzCgv2fZR4e1RwWinpqmew2AaXNpRqXk7wabYu?=
 =?us-ascii?Q?EbakmRSnSWqkI5ZEYvmuVicru98B7lDZfelS8/EqFTjihYZxjmIYIAeC1+Ok?=
 =?us-ascii?Q?1cHdbfNN+1mUfzwIcMlctcIFhMKPg9K6bw9nYj32X5St8ZinX/cF4oIFUeTH?=
 =?us-ascii?Q?rtFeW4SDVUqoP5J95fxpFt9nDknY92TEpcA4pDBYurbYdLhYIIcZHwC7RlXL?=
 =?us-ascii?Q?ewe+/cN5Uz0po+063Vt1K+6U/xSxfP72lVKWEpkkIy7pJH/G2fb7e1kMG4jb?=
 =?us-ascii?Q?C+l3+ofr+LYe54jiFHBM14DJl2KSPJ4HboacDYEDx/hfP4aAT7twP/K92kbc?=
 =?us-ascii?Q?P6x/wh6l70V9JpeCroOD7ldRePV2AmY1MMuVGacp1s6Lwu/z0rzSAw8XyPRw?=
 =?us-ascii?Q?eymA8bL+f9WIQBbMh7yPUkST37pv28QbZK5dsUvFE58VE4YunaeZVnrLcYFd?=
 =?us-ascii?Q?LarDDbNNZDoc7ok/MtecJn7p5/dvEI+Rva/aewX9K7kO6YJyP6ri1aYSwQUi?=
 =?us-ascii?Q?byIsc3w0ECGJPHWISKSazy/r9V6vXIc5K2+L43830nlEdmpHeITPKgxXHpfJ?=
 =?us-ascii?Q?6PEimOXVcnLxGLcNGGnOShlbvAWH7OPxUM9mdhDXCwfvHzqHDNccRxO592ZL?=
 =?us-ascii?Q?AjryyUaFmJJvOKLZeHQdqX/yqIkCa4rxRXejLkC6jDukYrpPaHiI+dBk/zI1?=
 =?us-ascii?Q?HQNVrL+tKEwxb6KP2qdhTpfASi+XX/Kpysw8dbzMsW2m82Q3XrcpdqVucPDa?=
 =?us-ascii?Q?7n7zhccA2Xlg/6rfsWBHC6YHG6Gn+0ecZkGn4ZHmV124/uM+ZOtM9PNUE+0g?=
 =?us-ascii?Q?1Qq3r9udqhBNWD23CB/FXH9HNX2mvSe12abGL//eyWl6jMvGSE5rQJv2pMLe?=
 =?us-ascii?Q?KAuNkYGewveSqzdrM2o4R2UabWZRR0rKWsKiVbzbYfaKmpUcV398cMdQvhgo?=
 =?us-ascii?Q?8jhG1rIxowTQo4R4KIyLX8qe42XTwxRKagf99XgpW3x3eOLb7jcg3sh79YPx?=
 =?us-ascii?Q?pj4xQ4tPo+QKRCAwCPA1Je0n1ZYIiPa57ox6OavM2XnP/mFD1x4A4QW3FOgA?=
 =?us-ascii?Q?FVesNRfQ8Wi8Qlb91AsyQmhO/F8pc+zK62oWtGf9ZU1P+3J+HOjcRfQjBGDr?=
 =?us-ascii?Q?mJK+Gnpo+HaOMICyGa+/5H0EBT9nbGfxDfxgAcKLUn/F8yOOkAvy2q9AG1py?=
 =?us-ascii?Q?lBJ/7Mh7X1fDoOlpOOFzTJIATlysSXfSHYOWM/ZQrzi3YATqUAQcRkDgxIn0?=
 =?us-ascii?Q?9wGEEETwEZLxYIIREG/pVAkxVWPn3nS5dxFZQHNKs+EfXCUg5CqJBqE2dORD?=
 =?us-ascii?Q?o8w1Byy5X+OEp0N5UUAag5cGse1ErqU1svSSejY0FNnsfsHxIWsMIEfqL/pV?=
 =?us-ascii?Q?60YS2xSEQiWO86iHp50JoYMHD9KGswJGb3TnVIQGIr+E4M69AMpb/YhkSGzk?=
 =?us-ascii?Q?KDSpzOShttPMVgv29QEqkwEDp4528VASIrrPZHVRDdDmwYxttyP7QiEQMuLe?=
 =?us-ascii?Q?IQugnU+cjKXBd93mipGbfdYOWPlonzDgn4Y1pLd4euQM4Gty3X5M0kFBHa/z?=
 =?us-ascii?Q?2+lRS5ouXBfZ87oMuCqD1A8TveVDTXg=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a84a4a8c-44bc-48ac-bafb-08de627c6dc2
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 16:59:29.3689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KHxxSblF9B7k3rHC6NEHmP0Ff+7KhmzCKF8wyDrFJ79p6CO0je3um3csGlYFvMpB4tm29v9bKOMWxQpwaBwkpGClP0l6V3oCgxJ80/gqSps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR13MB5488
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18648-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hammerspace.com:email,hammerspace.com:dkim,hammerspace.com:mid,libnfsconf.la:url]
X-Rspamd-Queue-Id: 5C1A4CF4D1
X-Rspamd-Action: no action

If fh-key-file=<path> is set in the nfsd section of nfs.conf, the "nfsdctl
autostart" command will hash the contents of the file with libuuid's
uuid_generate_sha1 and send the first 16 bytes into the kernel on
NFSD_A_SERVER_FH_KEY.

A compatible kernel can use this key to sign filehandles.

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
---
 nfs.conf                     |  1 +
 support/include/nfslib.h     |  2 +
 support/nfs/Makefile.am      |  4 +-
 support/nfs/fh_key_file.c    | 79 ++++++++++++++++++++++++++++++++++++
 systemd/nfs.conf.man         |  1 +
 utils/nfsd/nfssvc.h          |  1 +
 utils/nfsdctl/nfsd_netlink.h |  1 +
 utils/nfsdctl/nfsdctl.c      | 35 ++++++++++++++--
 8 files changed, 118 insertions(+), 6 deletions(-)
 create mode 100644 support/nfs/fh_key_file.c

diff --git a/nfs.conf b/nfs.conf
index 3cca68c3530d..39068c19d7df 100644
--- a/nfs.conf
+++ b/nfs.conf
@@ -76,6 +76,7 @@
 # vers4.2=y
 rdma=y
 rdma-port=20049
+# fh-key-file=/etc/nfs_fh.key
 
 [statd]
 # debug=0
diff --git a/support/include/nfslib.h b/support/include/nfslib.h
index eff2a486307f..c8601a156cba 100644
--- a/support/include/nfslib.h
+++ b/support/include/nfslib.h
@@ -22,6 +22,7 @@
 #include <paths.h>
 #include <rpcsvc/nfs_prot.h>
 #include <nfs/nfs.h>
+#include <uuid/uuid.h>
 #include "xlog.h"
 
 #ifndef _PATH_EXPORTS
@@ -132,6 +133,7 @@ struct rmtabent *	fgetrmtabent(FILE *fp, int log, long *pos);
 void			fputrmtabent(FILE *fp, struct rmtabent *xep, long *pos);
 void			fendrmtabent(FILE *fp);
 void			frewindrmtabent(FILE *fp);
+int				hash_fh_key_file(const char *fh_key_file, uuid_t hash);
 
 _Bool state_setup_basedir(const char *, const char *);
 int setup_state_path_names(const char *, const char *, const char *, const char *, struct state_paths *);
diff --git a/support/nfs/Makefile.am b/support/nfs/Makefile.am
index 2e1577cc12df..775bccc6c5ea 100644
--- a/support/nfs/Makefile.am
+++ b/support/nfs/Makefile.am
@@ -7,8 +7,8 @@ libnfs_la_SOURCES = exports.c rmtab.c xio.c rpcmisc.c rpcdispatch.c \
 		   xcommon.c wildmat.c mydaemon.c \
 		   rpc_socket.c getport.c \
 		   svc_socket.c cacheio.c closeall.c nfs_mntent.c \
-		   svc_create.c atomicio.c strlcat.c strlcpy.c
-libnfs_la_LIBADD = libnfsconf.la
+		   svc_create.c atomicio.c strlcat.c strlcpy.c fh_key_file.c
+libnfs_la_LIBADD = libnfsconf.la -luuid
 libnfs_la_CPPFLAGS = $(AM_CPPFLAGS) $(CPPFLAGS) -I$(top_srcdir)/support/reexport
 
 libnfsconf_la_SOURCES = conffile.c xlog.c
diff --git a/support/nfs/fh_key_file.c b/support/nfs/fh_key_file.c
new file mode 100644
index 000000000000..ee26df5b70bd
--- /dev/null
+++ b/support/nfs/fh_key_file.c
@@ -0,0 +1,79 @@
+/*
+ * Copyright (c) 2025 Benjamin Coddington <bcodding@hammerspace.com>
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
+ * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include <sys/types.h>
+#include <unistd.h>
+#include <errno.h>
+#include <uuid/uuid.h>
+
+#include "nfslib.h"
+
+#define HASH_BLOCKSIZE  256
+int hash_fh_key_file(const char *fh_key_file, uuid_t uuid)
+{
+	const char seed_s[] = "8fc57f1b-1a6f-482f-af92-d2e007c1ae58";
+	FILE *sfile = NULL;
+	char buf[HASH_BLOCKSIZE];
+	size_t pos;
+	int ret = 0;
+
+	sfile = fopen(fh_key_file, "r");
+	if (!sfile) {
+		ret = errno;
+		xlog(L_ERROR, "Unable to read fh-key-file %s: %s", fh_key_file, strerror(errno));
+		goto out;
+	}
+
+	uuid_parse(seed_s, uuid);
+
+	while (1) {
+		size_t sread;
+		pos = 0;
+
+		if (feof(sfile))
+			goto finish_block;
+
+		sread = fread(buf + pos, 1, HASH_BLOCKSIZE - pos, sfile);
+		pos += sread;
+
+		if (pos == HASH_BLOCKSIZE)
+			break;
+
+		if (sread != HASH_BLOCKSIZE) {
+			ret = ferror(sfile);
+			if (ret)
+				goto out;
+			goto finish_block;
+		}
+		uuid_generate_sha1(uuid, uuid, buf, HASH_BLOCKSIZE);
+	}
+finish_block:
+	if (pos)
+		uuid_generate_sha1(uuid, uuid, buf, pos);
+out:
+	if (sfile)
+		fclose(sfile);
+	return ret;
+}
diff --git a/systemd/nfs.conf.man b/systemd/nfs.conf.man
index 484de2c086db..1fb5653042d3 100644
--- a/systemd/nfs.conf.man
+++ b/systemd/nfs.conf.man
@@ -176,6 +176,7 @@ Recognized values:
 .BR vers4.1 ,
 .BR vers4.2 ,
 .BR rdma ,
+.BR fh-key-file ,
 
 Version and protocol values are Boolean values as described above,
 and are also used by
diff --git a/utils/nfsd/nfssvc.h b/utils/nfsd/nfssvc.h
index 4d53af1a8bc3..463110cac804 100644
--- a/utils/nfsd/nfssvc.h
+++ b/utils/nfsd/nfssvc.h
@@ -30,3 +30,4 @@ void	nfssvc_setvers(unsigned int ctlbits, unsigned int minorvers4,
 		       unsigned int minorvers4set, int force4dot0);
 int	nfssvc_threads(int nrservs);
 void	nfssvc_get_minormask(unsigned int *mask);
+int nfssvc_setfh_key(const char *fh_key_file);
diff --git a/utils/nfsdctl/nfsd_netlink.h b/utils/nfsdctl/nfsd_netlink.h
index 887cbd12b695..10df6d750fa1 100644
--- a/utils/nfsdctl/nfsd_netlink.h
+++ b/utils/nfsdctl/nfsd_netlink.h
@@ -34,6 +34,7 @@ enum {
 	NFSD_A_SERVER_GRACETIME,
 	NFSD_A_SERVER_LEASETIME,
 	NFSD_A_SERVER_SCOPE,
+	NFSD_A_SERVER_FH_KEY,
 
 	__NFSD_A_SERVER_MAX,
 	NFSD_A_SERVER_MAX = (__NFSD_A_SERVER_MAX - 1)
diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index 67cf27b04ca3..1d673d7bdc90 100644
--- a/utils/nfsdctl/nfsdctl.c
+++ b/utils/nfsdctl/nfsdctl.c
@@ -29,6 +29,7 @@
 
 #include <readline/readline.h>
 #include <readline/history.h>
+#include <uuid/uuid.h>
 
 #ifdef USE_SYSTEM_NFSD_NETLINK_H
 #include <linux/nfsd_netlink.h>
@@ -42,6 +43,7 @@
 #include "lockd_netlink.h"
 #endif
 
+#include "nfslib.h"
 #include "nfsdctl.h"
 #include "conffile.h"
 #include "xlog.h"
@@ -524,8 +526,10 @@ out:
 }
 
 static int threads_doit(struct nl_sock *sock, int cmd, int grace, int lease,
-			int pool_count, int *pool_threads, char *scope, int minthreads)
+			int pool_count, int *pool_threads, char *scope, int minthreads,
+			uuid_t fh_key)
 {
+	struct nl_data *fh_key_data = NULL;
 	struct genlmsghdr *ghdr;
 	struct nlmsghdr *nlh;
 	struct nl_msg *msg;
@@ -550,6 +554,15 @@ static int threads_doit(struct nl_sock *sock, int cmd, int grace, int lease,
 		if (minthreads >= 0)
 			nla_put_u32(msg, NFSD_A_SERVER_MIN_THREADS, minthreads);
 #endif
+		if (!uuid_is_null(fh_key)) {
+			fh_key_data = nl_data_alloc(fh_key, sizeof(uuid_t));
+			if (!fh_key_data) {
+				xlog(L_ERROR, "failed to allocate netlink data");
+				ret = 1;
+				goto out;
+			}
+			nla_put_data(msg, NFSD_A_SERVER_FH_KEY, fh_key_data);
+		}
 		for (i = 0; i < pool_count; ++i)
 			nla_put_u32(msg, NFSD_A_SERVER_THREADS, pool_threads[i]);
 	}
@@ -584,6 +597,8 @@ static int threads_doit(struct nl_sock *sock, int cmd, int grace, int lease,
 out_cb:
 	nl_cb_put(cb);
 out:
+	if (fh_key_data)
+		nl_data_free(fh_key_data);
 	nlmsg_free(msg);
 	return ret;
 }
@@ -612,6 +627,7 @@ static int threads_func(struct nl_sock *sock, int argc, char **argv)
 	int *pool_threads = NULL;
 	int minthreads = -1;
 	int opt, pools = 0;
+	uuid_t fh_key;
 
 	optind = 1;
 	while ((opt = getopt_long(argc, argv, "h", threads_options, NULL)) != -1) {
@@ -654,7 +670,9 @@ static int threads_func(struct nl_sock *sock, int argc, char **argv)
 			}
 		}
 	}
-	return threads_doit(sock, cmd, 0, 0, pools, pool_threads, NULL, minthreads);
+	uuid_clear(fh_key);
+	return threads_doit(sock, cmd, 0, 0, pools, pool_threads, NULL,
+				minthreads, fh_key);
 }
 
 /*
@@ -1611,8 +1629,9 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
 	int *threads, grace, lease, idx, ret, opt, pools, minthreads;
 	struct conf_list *thread_str;
 	struct conf_list_node *n;
-	char *scope, *pool_mode;
+	char *scope, *pool_mode, *fh_key_file;
 	bool failed_listeners = false;
+	uuid_t fh_key;
 
 	optind = 1;
 	while ((opt = getopt_long(argc, argv, "h", help_only_options, NULL)) != -1) {
@@ -1687,12 +1706,20 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
 		threads[0] = DEFAULT_AUTOSTART_THREADS;
 	}
 
+	uuid_clear(fh_key);
+	fh_key_file = conf_get_str("nfsd", "fh-key-file");
+	if (fh_key_file) {
+		ret = hash_fh_key_file(fh_key_file, fh_key);
+		if (ret)
+			return ret;
+	}
+
 	lease = conf_get_num("nfsd", "lease-time", 0);
 	scope = conf_get_str("nfsd", "scope");
 	minthreads = conf_get_num("nfsd", "min-threads", 0);
 
 	ret = threads_doit(sock, NFSD_CMD_THREADS_SET, grace, lease, pools,
-			   threads, scope, minthreads);
+			   threads, scope, minthreads, fh_key);
 out:
 	free(threads);
 	return ret;
-- 
2.50.1


