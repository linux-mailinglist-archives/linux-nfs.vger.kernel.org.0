Return-Path: <linux-nfs+bounces-18646-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iD+YHfjXgGnMBwMAu9opvQ
	(envelope-from <linux-nfs+bounces-18646-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 02 Feb 2026 17:59:36 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC12CF47E
	for <lists+linux-nfs@lfdr.de>; Mon, 02 Feb 2026 17:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C0EA30089BD
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Feb 2026 16:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD6F37F748;
	Mon,  2 Feb 2026 16:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="PB9EpQjb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020089.outbound.protection.outlook.com [52.101.193.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B232798ED
	for <linux-nfs@vger.kernel.org>; Mon,  2 Feb 2026 16:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770051573; cv=fail; b=bvlUaZ1HTPTPSZlSXCNWljixmoHDB7+y+JIV1Pqi2wrqGItlGtx9+k6i8Gq6Q2ko4E3rvJgK8BQrwVbYTaVJxIQpzIUsHVkSmztyKJe/htSWK1OpYzvq/mNlMizn1l5oalHXzSkpTBDVSS3g1RN3X55jrRYYC7lGTFU7BD2lrTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770051573; c=relaxed/simple;
	bh=S5rkVxzht0bRxvIGycqgLGEb2yfOfH2J+kB2ccg1oQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OW234+s5AQukUL90JeCaF09CDvdAeDdgacAiyHMP/JVmPpmqU21Y+vdD1bwolSAvsvfAkNNHedSNyJ4gTxfvpbD0m8eyO1/M4kY3mO1kPNGxFdowokynlZZnMidWHwO9aThztJi+X1ttAd6zWdF1N8CNSyFQpBWSsSmqwn89YlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=PB9EpQjb; arc=fail smtp.client-ip=52.101.193.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQm7pVbOMkqnC4hDJwEfrjlOzDG1FzF6/AsK79zpZduGMBYZ3CDQp5ySwK4JcP59KquxV5WO/DsU3RMSLqmSwdv9tPwz/+BFbcTO9hYq52ZjtJ10QGEUzRa9VbhuVnNVrkBrmyhyxTsGJCgmfucjKnl2N0MevZjuO8peTluk52rKw3GhOHDydq2vyAyY5fEMvH/6flMUpWBoD8PHCSWavDFOtXk2pxfHDRJVXTWeYLqQCSm+cNBSQrsRfazoUa7b4ySxYIXIyNnIUkl9FayxVWjHZVuOsx0/FUtmhZsxUFxCvSqs6Dijx3Rjs8MKiIfcqRuFpNhmP00skNcGAi4RZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hqpkISV97oA9UgcYdFOjf9cFsc5hAdtFZrTkUJD/iE=;
 b=QXYylASd7jk4ajht2CkBroBpcBphOBcgG7pV5+ouEsQZc0aZOZQZpP4EeWglr39Nqz4oniw0L52sIJCLeWJJKkldeXyGBylCm7XdXlgLuGe83Mrxvbn75hRazoGqaGV/XHI9UkXyhFPAI+3e3bC4XJGikPBpKeJ/4UnRgCoAnorbc+GYJITHVMu39Wzd8kleMC0FfOgBLdZi7zEUSTgIDevzemvwFt3sH+pPxCVv1hXEnRWsMIrTW/dpRsab0QQFi7kjMrj4v4FR//v/72IczcVP8mWUgoyuawDUGrMqpU7ZOYQBWUqKtzF+NHaXt9nhzOIdGkK5FDFPhTBd0L4W4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hqpkISV97oA9UgcYdFOjf9cFsc5hAdtFZrTkUJD/iE=;
 b=PB9EpQjbw9BHK9sGZVFoJCEpJNABoQdkMt/i/FLEnb/SXPY7rDGklT5jePfT54ZfnsRe16L3rFhC4Jy2deyqiB1OkXtUBxzPpL+3la3luGWGRASKdhC/xtXpbn6XPP85jxKBko6+Ut5uDIZC8C059/H4T/1u8cT6xTjmlMaYTfA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 MW5PR13MB5488.namprd13.prod.outlook.com (2603:10b6:303:191::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.14; Mon, 2 Feb
 2026 16:59:28 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 16:59:26 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Steve Dickson <steved@redhat.com>,
	Benjamin Coddington <bcodding@hammerspace.com>
Cc: linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v3 0/2] nfs-utils: signed filehandle support
Date: Mon,  2 Feb 2026 11:59:20 -0500
Message-ID: <cover.1770051230.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
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
X-MS-Office365-Filtering-Correlation-Id: aa7096fd-3881-494d-905c-08de627c6bec
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vlve43UAVT9u7OA8zj3mFjsILDsp6qRRuUfzUfwPmboPkmGllN0fyLLMP/fO?=
 =?us-ascii?Q?t4uVsAOv45tNupKWjhWCBRUt2WgHBP3VYllpavMoLV3exz6KqwGQ+owUCsn5?=
 =?us-ascii?Q?AzUsOu4C4tXXuws1LIpFFGAcmNb0JoJ5DiOTkuzuCeLbl6izWEuexMeMbOwX?=
 =?us-ascii?Q?Y34n9j5UFmCIyxKRk8FUP9ZS7akpwHXgp1sEzVfs4TQZMB2BlTXTNusgk+iN?=
 =?us-ascii?Q?SGznpnQ2M7oirp8rEKjfopBU1M9ePi68zkC7y3scE0ejCinkxQ9lq81enbjC?=
 =?us-ascii?Q?gvO2HR/Ptkmq28+l/ZXf1hpCAKZ71Hghh8A7Vu7kg8tUkT+Ko/7JYQFX+W/s?=
 =?us-ascii?Q?kCmnljlCnuUP25xOaheixCfFXUTbyLIlFUZAv4N6TvjT34TdYENX3VyxJ/Dm?=
 =?us-ascii?Q?IUNI9G+8RJ3p+uRF3LopW49SPAfiyqeqKy1xZjcNmgTKn3MlG/7pBN1/lOIb?=
 =?us-ascii?Q?6C50OJlt+W8dLXEYeb7lC3S8L+rcYKMPJn5oErvzRTZc43LDy+KCd6/XaxwX?=
 =?us-ascii?Q?Ps38Tj5r+vhO9bBXQg59uvaNoD9eRhjEDhQ8SbD1dyNCIDUZHUec29tx9O6F?=
 =?us-ascii?Q?7PArPZm8S1v+Klqh9OynkEj5boscX9EvJmx44bH09SC838ceJuBTjleW8Jve?=
 =?us-ascii?Q?86BZ0KD8lksqvn/BrX/fh0iHM6JkzuqtTQeChckGv8q0lih/KGjYCHt8Mqnf?=
 =?us-ascii?Q?QVOGrjnL4VmDyYCTbgvSZwFyQF8H5AoZ15WG4mymypFAlbWtsfYkhigUceXR?=
 =?us-ascii?Q?KiYQ+pc+tFGQ38OlsQ3FN3kJa2nNZzjaz8vLSWdhRZ8RYqZxQl2hi6e4DZss?=
 =?us-ascii?Q?OGiPRzulhJmhhMo6lm63Jtx8IOrdiCZWErNfU9y7Nvcdu4FGQN479b0YN0Yw?=
 =?us-ascii?Q?6AYWOauzXi0dup3EaiTFX4XaEkGbNtGRs3NdxKyUIkDbSGsVFepFIGEw+nKr?=
 =?us-ascii?Q?7dMSj7U2S54yWNz/GvDEfI3Mw5Shoi9NJVTKFw0s5FpGj9ZFK3CS76FiRVaQ?=
 =?us-ascii?Q?1AVe015vv24aQ/9zTtB4/qrSqHqJttuCHlP/Qko4fkOECICJQBM2EtjuSlU0?=
 =?us-ascii?Q?IfZoqejjmi5TsVjjFhheRUyUD2B3DwDTq2Vp+pyYBuNBr1si7FE0hGCbuQnF?=
 =?us-ascii?Q?v4W6SQeUsoFJm8CRzoHvrLqFqFSL9PkWyY2MQrWDj0eQxBARFbfQToF5zGI5?=
 =?us-ascii?Q?Gl1+NyEJmNf0vEl90o0KNewemMUKx6E/m85XtREQM99mpbu1Ww6LG6BE70Ul?=
 =?us-ascii?Q?jX0/dYv73gLjRZDzsKuGz9lfebB9/ntWqVoLdYNj+UGK8+Ni+L3TYgvoWP3s?=
 =?us-ascii?Q?ruOgpXC1eceA+O3+O5ekFDeAGEob0a9lnimXqxVs+/G+pKBvvUjINAHAcAQi?=
 =?us-ascii?Q?0oHD3a7DHRBKt3kPqSaypLj7fwfyLA5jXFrqNOYtJ96OzsWDvAyfYLCsZizU?=
 =?us-ascii?Q?uO8zajNE1qiJ+4uDIbI6NsscxVgqqsfqG64Ftzav5VNwQYGoUYxAir3Vrk3B?=
 =?us-ascii?Q?gapkXFPXmRb9B6WmLKfdjhT7PndFtDzmoR5JY3FJ0WLAfFnrY3o4oOyMHDSU?=
 =?us-ascii?Q?5NYcKIu7819HOSqDRoE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FcXnsivqiGpaOZ6K7XillkKQzENvYSKyTs3FLsljbU2AnsxRFbm1AX+XgOBt?=
 =?us-ascii?Q?J3j4jXndYlz/JtrS19HZIS9EdVjYpYAOZr+ewmN6TVOI04iAd/qp9tnqZyhW?=
 =?us-ascii?Q?JDCtJNuBlWQI/SKM0FQ3xFYxfrzvco8/G/mJa1v4TOVZuhU9EjZ+Big/zZRW?=
 =?us-ascii?Q?Far+ktCQQ4FibPcYuZScJDkxfMu124RdNdtL28rfxM02aKhr5L6yWbG96V/e?=
 =?us-ascii?Q?KXNcs7VG6tED6Nu7/BEG9IHs/kOHQpo/w8HwVKqJrR0+y60DdZkImUcj0+Ce?=
 =?us-ascii?Q?oUOylssLSAW8KQCL5biBw4ym+9uGgZgN0Temm0C2eYjqXOO7lVrKIwFdcF/D?=
 =?us-ascii?Q?kNqzVq2ncqpfia5dZ6c4Kh55Pq1QohhWaQyMHzOq7KpZGXuqqePltf5bsHE9?=
 =?us-ascii?Q?dQJr4XP9GgL7o8xfDn04C/4mSYt57I7UcXN2W8Utk30pHHxH8F8vrFM63kW+?=
 =?us-ascii?Q?X2oxLNgePqx2Wiz0Vidy/pk1fz563yPu69KDWp0lxkuMr1syNNqur9K+vJGY?=
 =?us-ascii?Q?8I2bXjEfUWV0UpGvLzhEXma2Z9HNOLI39GV4j2V59+ZfOY/8cFawqF8eN5wb?=
 =?us-ascii?Q?baBJwq/IeJ+QdKT7o1Q5GncFSgiSSmP9rrSLp/W9vIilwXHOR/dcppj7dMl5?=
 =?us-ascii?Q?syBOtkegIaoBigi4mQEb/7/TrOCuEvif5lnhpQrOcgUZVnvQMUuS7xgdQLIa?=
 =?us-ascii?Q?Lhv4VaB7Kf/QNotHN4HZP6LN06iEa92SSftPhGy2399+rNXmdYz3ndla1lWZ?=
 =?us-ascii?Q?Jpm9V9he2rjEmJAQga3H8X8MmYe9eVQMjeQ4PcBrkDJcwBCdbUBDaV8EfciN?=
 =?us-ascii?Q?Rr0dYvfu9dvsPVNGx96gbq1NTDeeVJz9KTCalv6dKJfdhTNabGZbGQjL4HEc?=
 =?us-ascii?Q?SOPcpFU7xhFc9eq6xqnmj6rQm2YYlTQLXwW552RReuxN+EBZErJWzhVl8awW?=
 =?us-ascii?Q?b1EhSIn+2ewOBgSkdau4upeep145oHIAGLPYNh2oz3bgH6RiNXoWyzgoy4JT?=
 =?us-ascii?Q?oQYG3SfpB8vr8dUBSWx5AjCsgJwfaSvq72ttxMq7x2KIWhDIbIKZLVxzsO99?=
 =?us-ascii?Q?4q9sgSR/VQV/68+yA2A1JtNAY/nQ2lz7FBn2wnIV7+8sPbMexKu1a8B08dnQ?=
 =?us-ascii?Q?BMThG05fB66gqoRv3bw23J5vhNYgEIabRRU5S+IXs5yrePsxKNC7VU7MQII5?=
 =?us-ascii?Q?IoUAWhVa8mjGbE8YK5wcgoUdTfclmBVRWAUHVnhImE16dhytcoI4wQorSppO?=
 =?us-ascii?Q?dOtEYUeaVhFyW8BokAEiAmu2Qrx8QwgxBb895GN3YwJfMpqkVqF4kZIFXClg?=
 =?us-ascii?Q?NQYyS4QjDmW6JUEbdEP7mQInwfayxTNo3mslYX4cqBZCfsQA0dLCHlxx87PL?=
 =?us-ascii?Q?ItDfYm+7tbv9zqGrbyJzRd4kmB6PtbgGjgRvaj9bbVI2p768XME3rGZcpymd?=
 =?us-ascii?Q?F2PMIzKfUvyIIPe44WqdHS9VM++WT2Rpqby4evaGY4J+V3OFCj4zOuChitMo?=
 =?us-ascii?Q?KrHpaJosFCnLO1WsBpPJZ7NX+1RkRP8wWaYf+xR61Z86e3FdMNvncXIju/BE?=
 =?us-ascii?Q?wf3g/YFIAorwELNUSdPFyQn8kOCOi8T2HON5bYaaAysz3gnU4IFkcD/H7VR8?=
 =?us-ascii?Q?bceOItgi/YVMGmTrHO8gfgVgBfPu3qWT5phs5vH+Qic/AMfCfFhgcYVNyJao?=
 =?us-ascii?Q?bIruBL3u1AiZAnfjq5mESohquy/02Qw8YM3B2h67PT4FDGItf4TzE5Rsf7ga?=
 =?us-ascii?Q?51mI4o5C3cTM6T0z7aVD9aZsp83W+EA=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa7096fd-3881-494d-905c-08de627c6bec
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 16:59:26.1850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LuOmJkQoK4Ii1W2dfzBun7Jz9d/FJ0WiWEQbO64ijmqD7Qw0S74nPhIMnjM+Xb7Sfx+QQ+jTNtbetMiVN46BhtVf7ZtG9LIQbe9AASsRzrU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR13MB5488
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18646-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0AC12CF47E
X-Rspamd-Action: no action

Here are two patches allowing userspace to set a secret key for kNFSD to
sign filehandles, and also set the option to sign filehandles for an
export.

The secret key passed to the server is the first 128 bits of a sha1 hash of
the contents of a file configured via the nfs.conf server section
"fh_key_file".  Exports that have the option "sign_fh" set will cause the
server to use this key to append an 8-byte siphash of the filehandle onto
each filehandle.

This version of the userspace patches correspond with the v3 of the kernel
changes which have been posted here:
https://lore.kernel.org/linux-nfs/cover.1770046529.git.bcodding@hammerspace.com

This work is based on a branch that includes Jeff Layton's patch for
min-threads:
https://lore.kernel.org/linux-nfs/20260112-minthreads-v1-1-30c5f4113720@kernel.org/

Comments and critique welcomed.

Changes since v1:
	- fh_key hash is passed as an optional attr to threads verb
	- include missing hash_fh_key_file() function hunk
	- wording updates (thanks NeilBrown)

Changes since v2:
	- send fh_key as netlink attribute (Jeff Layton)
	- cull redundant loop in hash function (NeilBrown)
	- tuneup sigh_fh man page wording (NeilBrown)

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
 utils/nfsdctl/nfsdctl.c      | 35 ++++++++++++++--
 12 files changed, 134 insertions(+), 7 deletions(-)
 create mode 100644 support/nfs/fh_key_file.c


base-commit: 612e407c46b848932c32be00b835a7b5317e3d08
prerequisite-patch-id: cc4d768b1f6935b3c94ae87bd0389270717bc5b0
-- 
2.50.1


