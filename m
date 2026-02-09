Return-Path: <linux-nfs+bounces-18819-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CJMOeEsimkjIAAAu9opvQ
	(envelope-from <linux-nfs+bounces-18819-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 09 Feb 2026 19:52:17 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4208C113D9C
	for <lists+linux-nfs@lfdr.de>; Mon, 09 Feb 2026 19:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A35093013A59
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Feb 2026 18:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5083A1D05;
	Mon,  9 Feb 2026 18:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Xzto4WHl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020111.outbound.protection.outlook.com [52.101.46.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA17168BD
	for <linux-nfs@vger.kernel.org>; Mon,  9 Feb 2026 18:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770663135; cv=fail; b=DLePXojPO2f8+FaKgeCKpagtOqTv9gtSmd+BL9DmZ02OZ+nmbmgc6vbxi8gOU0AZRsrIQ3jsOap1t2rBaFcdMM9pRJzqb6r2xfqsInfeestgpmylG4GwnScRo94IE980xpQWCDEGgOQW2zIOFkWTDfnyg6jz4IB/K5M4Da4tvm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770663135; c=relaxed/simple;
	bh=a4CanQsX3/0SLnfT1lIQ/k1ixezbpRTLrVukv8Kqwbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GEUH8Q0LyyOE6C11IIWP7nyqUiA7e/DLZfkqwLbv9lM5GMd4EwzvTXMK1p6DUQYJqGL8UvRONKWgD8o0agbddZ10VfcrGxFbxmJa369cuYTRBe+SxhtQeYUXvCtl+cOs9DiuApxtjf0aLXDgT9daNaHC6XmnMvKXZm+kz4su4I0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Xzto4WHl; arc=fail smtp.client-ip=52.101.46.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fhbhyB3mJ8YuqQAyM3legJ0PNCG518rLnOtQbXannjRDV0oPAI7XlFsMeb+oDsY7Q4iF5T2jJE+f15fAnojmIq9US6Zrn04b/sYEWI7eng61hxE0zu6wzk3e9aQ0FkNdDmRRQ+NsQ8BXOLzhJKACrGtPwl2JoXXpCl/640CRDaIgmX2y7XZKpI+URJHL65svyCs28DziI/Eu3X1ctUCukZrSxh8DrB4p++NJWf16c498xA1hh2qqElXh4YR9iBmaiDnsGoiiX3/q/AeUTS8tlHYKW2e1ThOC5gT/GU5G/b4BDUlFCoBXnVos5cT67Jt26PiI+lj7GGlaOmEgTcYtBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2dgSbxMbGvzSjdIyPnvkatJSFu3Q691dmkcoi+cM18=;
 b=adJVgr7rciV5/wRf0GFSAJYI202kZsyP5v4cOLgeFLbaLPzzuXF31M72lO3ue3j2Av0d8im2UNaLNVkmNcUuNV+VfDRTNhEJ6bAppEnWP3GfnkeZrkKGeDkFnmPB8NpEV7NZ09NQVs9U0CGHY5lfgXY3Sq0gDjvhPkCwRHWoIpkjRghVRACX3NHVzPzNQ3Y3mMO3Z2U34H9Y8+B7jOvKhbV6sEGZE9ablSuP/ApHuKCV7Cs7ovLmU7dqPJkZ0wxuvrbd9zofEdgsjizaOk+GGEDnkyIJVqq3JW+YBmPARIZsOOVB5ARr+vshq6h9mxqxE526rzy0wY9Gjexb2U/z+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2dgSbxMbGvzSjdIyPnvkatJSFu3Q691dmkcoi+cM18=;
 b=Xzto4WHlYl17JzdmqEKArO5voR2me3sVsbAzOsJ6toribZCc9+9K5elhROSdMp7WPs7tnj/naW7YGBBu359gdZ7DQ9cuHa6d770dh0ppcatVPLTEyR4hgkfTx+qW7zoUrCm0jFvTpJs3qgHrAzTugDfNSMG4b8Rdl33YDLi4LzI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 DM6PR13MB3740.namprd13.prod.outlook.com (2603:10b6:5:24a::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.18; Mon, 9 Feb 2026 18:52:11 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9587.016; Mon, 9 Feb 2026
 18:52:11 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Steve Dickson <steved@redhat.com>,
	Benjamin Coddington <bcodding@hammerspace.com>
Cc: linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v5 1/2] exportfs: Add support for export option sign_fh
Date: Mon,  9 Feb 2026 13:52:08 -0500
Message-ID: <69c1c5e20afa59d236982982f651833f5e2ad061.1770662817.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1770662817.git.bcodding@hammerspace.com>
References: <cover.1770662817.git.bcodding@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P223CA0018.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::35) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|DM6PR13MB3740:EE_
X-MS-Office365-Filtering-Correlation-Id: d14ff8e7-c472-49eb-1aba-08de680c5582
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kn6ienU3vCGojuQDtPMS3cho3n/ZKNMR+ijfUlI7xsNxJwW9ywvgF1tir6e7?=
 =?us-ascii?Q?bgqice4vOJ8us+EOu6r/qwtBwWt7b/ZB6zKRb2DwwF66X1yJQwxNpiF9tZqo?=
 =?us-ascii?Q?W9fNql3azYTGRs2M/fMdisa6p+n+ntRLFLUAR+5SmyxoKSGzZqQhEDuchziA?=
 =?us-ascii?Q?7FAw9+c9y9lPhrhsK02dIIe/Pq7TYiKcE8nB4N+GWBdFyv4uV3XGMaDrt7Xb?=
 =?us-ascii?Q?/DXWghP0bG8n516BtVxDL77em5CcvlutmZZthLtwg2KWcwKj+bPLgo6nEJcb?=
 =?us-ascii?Q?WiC8HuCk56ulCQ9ZDSN4ScAEeJ6kxHfHopl2ABwHS+Gz8sKZtPZFB6fUB+EO?=
 =?us-ascii?Q?bpJrXH/uD+0IooXrEevWd+PCbeOGTzRIwVKQQthh1Gzutw+g1E4BRbJXZ1QM?=
 =?us-ascii?Q?nGVHqiwaDhg5VPJ+I6nFpAdvJXrTb7R4on6RPFCc0cQjNb2CyrgOak1xa7Ki?=
 =?us-ascii?Q?z1n1ASFvBTfHUPHBAe8MMReMA0CRnesOo2lcBGyulRyVWaeR4wCnYSU+46H9?=
 =?us-ascii?Q?ifqXclxdhM+5WPNfQpYuMcaQnrPVlPfjH7JvWkLh4SjbozDDavkN94r6sic8?=
 =?us-ascii?Q?+oJPUaiSvOep5Sb8gqFVfiAr6jSkSznPV8GiMG5l0fQ9I6giPClTov2okrY/?=
 =?us-ascii?Q?rSad/rtjAd1b/WQQVBy0YQJ7nIjx+gz/L5C/rhVlNY1QBxIXDpb1aHmHw5ZL?=
 =?us-ascii?Q?PWGh072Hi/g2YZAEutOYXOgUYgbKi1c/WO8nncaPdER2aZllHNNwMMh5MGOh?=
 =?us-ascii?Q?qNgAYQK/21HH58I1zfd3l+T3WhXduaIpZh/e8PFf/ln3UuRo+KcCPmzKgs9d?=
 =?us-ascii?Q?BIRyt2B3PBlo1+RJwua8JKkxhBs1ejIUEmaHvY4jeDcbR81zdMTnZSWkbIdj?=
 =?us-ascii?Q?3JWx8m2hG6hQbnUoPGdYHgRsBLhlYa4nk92hFtCLHeCmWf9nKvaYGPIGpyW2?=
 =?us-ascii?Q?ragn1Ywp2gZU9ExNXsdjkDqxAkFtk3E6bkBdKN4r/vLYY2CO4mZ5r1nyRY92?=
 =?us-ascii?Q?56kggqaQxMTE+E6Gg4134CwZGaNtTjDbiWEft3RbqvXPsXmkXVQjNgidAHNV?=
 =?us-ascii?Q?MLaUh4zmvMhPFIzca2A7gDTl1VmqjrN2DaGkYK1Sxiry3vJ4WmZPkSvj6Nvb?=
 =?us-ascii?Q?z4mfCEnZCu0QI8uJGT3B0LsRdNBidDTaRsLqN2J/nixqvuTASJG/9/R0iYjv?=
 =?us-ascii?Q?EJXSvMbeqzMqafiIxmzIBGkzYu81kSbwVAWMCkkea1eI9seE8qz6jeyi59lh?=
 =?us-ascii?Q?l57Bmfvn7qjaeK2F4Mz7YbzGvtFJJOUn5ATSNrRXQiRbEZaPjl55IfTSPlVd?=
 =?us-ascii?Q?fE9ceqnILG+UkftQwChzJLfSD0qp43lJ7TKN8xVQgMDF+jxv/spimumzlk1u?=
 =?us-ascii?Q?3evjgcqPRqa69eCQcLtIY4tdRreGweg0uM+T+fT/FuykbwHuoncT4iMYvxrB?=
 =?us-ascii?Q?ChDeeDkWC6ek7skAXQC55y7uQv0lqrr/45pr82EQhrCOZEiKqLkl3ICpRJ1a?=
 =?us-ascii?Q?lUr2tacL0m2ZC2hDDdf1SGIPl4ayYGyfHZSR7Wytimi3vO2W+/o/Xicxq/lD?=
 =?us-ascii?Q?cHwZ6F44Vx6u1n7G66c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gr+NqtTXNbcdDq5ZMaH+QfMH+ckL8ovLjFO+6QqexKr7v+BpHGoYonds8a42?=
 =?us-ascii?Q?lhP9Mzfx4ANPyrgmPOp7KxSaWqF49S6YaIj5/5MWZOSrKNqT0bEFzB3sO2Gj?=
 =?us-ascii?Q?9NY9oZFhTB8I0S8u5MFwZ/9hr7QfY58TIpYQ7JZgINmFBRw73XVJ6vKoZ+o1?=
 =?us-ascii?Q?vYpPIwn/CzQzaz+7HeXl3Dr8htvhaFzl52y9QkflrT57YHEfAP0gLWc7wHK6?=
 =?us-ascii?Q?Tp0f8F6BpMiKrJpKfL5awRd6QwepDZ0lbslC2d60MF7mpi5lHxGRPdIlqphB?=
 =?us-ascii?Q?NWmxlZYSRXAiaJgF7K+iQpC/lMtvMKElSI+RuoXpGiaZu9xSS2kMtgj+j46u?=
 =?us-ascii?Q?D45o7lxoloxDijp6FWYNuGG1u8YVEE9maCn/YasywdDLb6qaNcjCH+HtlPAB?=
 =?us-ascii?Q?9Yv5M3MyE9Yag/kJl6oOYq3MEKm/Ij9rNkLAP0aCMTHP1tuLLjpRxmDE7VES?=
 =?us-ascii?Q?uRPs0wpJg7xrlAvjPoI8abrUWSV5zJzD7NLn9ucTfFoYUkLzxpBlOQNzghmp?=
 =?us-ascii?Q?sH4LkYFQCD/S5vSkDg9JADwFpXCKGGL2emvCNvBzYWoIp7Ug+0o3amaYKf82?=
 =?us-ascii?Q?Ki7s7aWWkfCkcVKP9TLX1UVHiEtdWLPpmn/bg5cGPmXm03T+ul7fPdi4Iqwm?=
 =?us-ascii?Q?oMW59otN2ywJP68YpyzTmsChXFFvN1xRzQJDPBlW5ixKYPA9FLb3F1kD+Bfs?=
 =?us-ascii?Q?4z9tIGbz1NM26NsDQRfzbXEmryYk2YAVv/m14ogC4WeCvZC6xs7T9Rs3y4z/?=
 =?us-ascii?Q?S3pb4HZNg2pdzY0sgrRnBrvGPoP5kRo95t6/fcL1P0tRAy7CWWDJuogDOeaI?=
 =?us-ascii?Q?/kifZzdlcyEurKyOvRk72nqBoCyD0qlAyhI9C153V9FHq1kn2atbgEX62UVF?=
 =?us-ascii?Q?Eo9+/UZzrmOTnttTHXb/jZpxzxzCBQw0zF0Mhzx07yHg6yB19ilWRAZ3V1Jl?=
 =?us-ascii?Q?qX+O0Ei/W9IOAVdPqDi7j3Rt/HerdRzK5IlOpaL7ummnWe81w83k5jS38lT3?=
 =?us-ascii?Q?3YU1lgyEyA8pgt8anoDuS9AWFOhZzpvt+2UeYXGBSRMI4DwbLUTcHwGDE84Q?=
 =?us-ascii?Q?KcsiP0xnLm3t9oDC2+qw4RtklSVCgsYBtWEnsD3lS1pkEGYoogyc/MNg7y6D?=
 =?us-ascii?Q?klf2ngHeX4pdXuKFr6FJ+H9cd01KuSJrgsYZQWyTYcTL5LHcEIjE7SCodvIu?=
 =?us-ascii?Q?hAwHh2cBy6WmndweiJjjldDOsCr6c1ZHC5Byutdxp7kx5b3tyXdq43QwqBd3?=
 =?us-ascii?Q?yJekX8JOKjjOTkKY2KXSUoJSuB3QwOfPMGGOEoUPfTv5/SveJVGbWbwLBTup?=
 =?us-ascii?Q?psksMGdcb422Kx479uzN4gvsNT0zkLbPEHRV3HMCmEgTjpGjBW2g2LqdMlsQ?=
 =?us-ascii?Q?vRfoRQH4RXYmGS8OVNjwR33SsAsvr+sGo+SDbfq4O2+TiN83KjRVsn2cQ6iV?=
 =?us-ascii?Q?yQLP2fNx8SJ/QxAP2PlcNsKI7/igEce1RDX2b/y1CsQJQJCUXN8DC8EhX+6o?=
 =?us-ascii?Q?A47XNBHe91VyxGpM9Iiilp9TSGP3Z8TfxXq4P0p9JaBUc2NV4cpBbDYv4SkN?=
 =?us-ascii?Q?ZPsolmB8/GrTovFeI9zTpVkVu8dVpXMtkBMoUlXxyDuO3i1DfM3nqX6BrhNI?=
 =?us-ascii?Q?7qdLHIZTA/dKec+Xg6sFT6e6nm3Ccj9jpwnL/EMyi7bfz3/JoUXGi3BQ4Ls4?=
 =?us-ascii?Q?rqDsOqxhJQoUdFG2Ekor0BWu6mB7BbarMvzSmm0zHGhezwJUu0/3wBb6wiBY?=
 =?us-ascii?Q?KgfVgG//PDupff+CQbmtd2r+4/VAk54=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d14ff8e7-c472-49eb-1aba-08de680c5582
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 18:52:11.8270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D/fy92doUwGz2BUY4S3ya3D60M/JQY8BdXMeJzuky81yUPc8lyyn0R5zy+eEQQGfFbZchbmbkF4AAQiNhYylPtc1XGfu0fvWYqhDHUF7CuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3740
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
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-18819-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4208C113D9C
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


