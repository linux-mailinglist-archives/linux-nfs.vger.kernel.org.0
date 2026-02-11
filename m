Return-Path: <linux-nfs+bounces-18892-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHV4AxW5jGnlsQAAu9opvQ
	(envelope-from <linux-nfs+bounces-18892-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Feb 2026 18:15:01 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 753BE126841
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Feb 2026 18:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6CB973030EC7
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Feb 2026 17:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1873E2FFFA5;
	Wed, 11 Feb 2026 17:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="cCW7AYJ5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022129.outbound.protection.outlook.com [52.101.43.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A63534A3A7
	for <linux-nfs@vger.kernel.org>; Wed, 11 Feb 2026 17:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770830072; cv=fail; b=Pre9M+GN/SFNy5w3oqEI3OpD+jwnmCy/nBlXcO+JYzoiYcBW6093BQTqcefFWSOusjN2n3OkNQBWc9efPL45BLnTyuMzrF9g4D4+J65VA9s+LJEYVzShL3zY4w13fIJg5nZjeS0ALksz2YCQ6idV18EMUQvR5LKM2wEeJLqmjp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770830072; c=relaxed/simple;
	bh=e9KE/fp0hAncVuE3ip2V/C0TdLh9siUcj77Gwux46vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nRMetMvNvk1eGjxildeAnOVDLSS7EWDHGpm6pVXT+uEODn+Okwa+ILtfgN0gYaHFtsxWSj6+z86FCjATd/ViQ7+r0e2kZL67UoT70/dSrEQHycNyt6uX+prYJKXhFxBd0p4N3xv7ugiS9xo0comj3QSQKZw8LNVpl88OI7bP2Bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=cCW7AYJ5; arc=fail smtp.client-ip=52.101.43.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h3fnt81MZYkWhzguPYvWPB3X817zECwiyZVYiiwdFa0OrngSFdZa7uY1Oat8uQm8k94pILZn/DZOk5peBqqGGi6Xss9qRcMXZBiGTry1pRmvftfg1hHhtcuLI9GS3eE13YrbXkoCyqE78EsUPVr7lGPAXs57C8MIexKMl6DiBHosOgejoWGdBXvI9CMLDz3SnI7gvH5UMGYbw8KAwN9CfomrBHJoVxJXdVBk7S/Wbmko84fEhlPeo70j3EuK9Aqb8oWaaq2RdyTYwc1vLhFLaZUTShd84OJRkQHRK2T6g+kLiqWG30LWtVcbXKmYf1fmkylJmGsBdN+D0obwr5EBNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tCEB/wDYnPHIADErl34HvZbjin6WI53xeu5XYsQWhw=;
 b=vzGHvijuwNSP6NkzDHgmAsyZfWPw6QmiqcFqMz6J71EiPiNSEAyUmrTFBp/uQHpQYzFjFGDh6oAk+S6XMrzzKKkvlAszvNFjfVUg1y63/bAaZF/W+RicdXtSjCppFUymckVP6y5kyK2IstikI/e6JOcCHlTtJxxb2/XCKDUOOvVtqfISHQrr67Xxv+2m0N9BRLeoznzRXwyiQFQLjVygn7+ffTBRHI7K2n7WlTb1acN2UIt0QrwlCZyYNZVnbGLJs4DIUV/hA8tWdI0B0QLVw8lxXRLHcOpVSgw/XdYJlyaZd0lYPClKtbnIp4bHsEcY2UA5UVE/niET5py1As+dIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tCEB/wDYnPHIADErl34HvZbjin6WI53xeu5XYsQWhw=;
 b=cCW7AYJ5/WzviSjHDlZi2fXcXF9q6ocGF2vcQOCjCx6vrgomBw3PqZ+20K1a/55YXoM0b9k5FmVFiU68UlP3WrTrrbKEBQJOlTATiA81QaU9sC253UIs4D6LHsgWX+k5ogmKCm27kl63L6u2PfIG3YH5eJl48PakaT/ZD/tlqyE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 SJ0PR13MB5941.namprd13.prod.outlook.com (2603:10b6:a03:430::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Wed, 11 Feb
 2026 17:14:26 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 17:14:26 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Steve Dickson <steved@redhat.com>,
	Benjamin Coddington <bcodding@hammerspace.com>
Cc: linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v6 2/2] nfsdctl/rpc.nfsd: Add support for passing encrypted filehandle key
Date: Wed, 11 Feb 2026 12:14:17 -0500
Message-ID: <12031854f9dd7a082eba7ed5846b17ac91e12f53.1770829825.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1770829825.git.bcodding@hammerspace.com>
References: <cover.1770829825.git.bcodding@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:a03:180::31) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|SJ0PR13MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: ccc1bf8f-a5fa-4aae-565d-08de69910083
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AOQUR/jOQa8zdb8Znqv3U2m9X8AgNFsHW0QDczE7kRB9SfddqzJlb0ciNdYr?=
 =?us-ascii?Q?29SlmrUg1/RhcD8G6m+dIAkLr1Rq+GyXjl2D0X8IJ5/NMwP5cjnUgSh6MVoc?=
 =?us-ascii?Q?f2Yk2zlbWkkiZ8sG2t0nOdgMAVXov8WB7XQW+En2hSQwP27e5MHnOVEWMujk?=
 =?us-ascii?Q?BLMpXRhdQY6iqNK5bSjEKyr5OO1QVaZb7MJeSXoKAUI90f5Q9nRFirIsP1o4?=
 =?us-ascii?Q?aBbeqp+LlDwtTR1eTMjpZJU3hhT2gb0weJNpIsRGGrJK8NHfOfJ5OcBZMRiC?=
 =?us-ascii?Q?b0MrQFJnOEFuKFrbJH2d2EiLXM2+LUWQ/NcBzqjUc7NP7i4ukdSSsI76PG6M?=
 =?us-ascii?Q?HwWCr9im85AXK7Fq0E1bH9ob/D5LJA5C36m70EpSUwb1wDnpcHk8QF1pS+gV?=
 =?us-ascii?Q?JM6L6+H7CdJ55pgFn65J57iKby3tGCgYZ52JWz8Pd+3MExX6wXKz+aS7oUk9?=
 =?us-ascii?Q?7ioZvt24IuD856OhEfr1/V1J6WxgrRp2sTNuqBhenD+ap2722voUgHwWeJBt?=
 =?us-ascii?Q?RA8FVKFth9Db+aR+oHwABVuwxvqaf6oI0wWJhiH9SdHP0DcSZ0bCBHgVi1qT?=
 =?us-ascii?Q?dyBJ7sb10bX3YnDK5p6GZVxFRGsyZMJ85DiDlipyE/rQoO3pRcQHmhHK5OBM?=
 =?us-ascii?Q?clnBcTnGhHLZrbloKzyS3v6C3uHOnCzGdZzo8jNPhEGdvnxX3el+q/R12K+B?=
 =?us-ascii?Q?Z3aDfccw5B7NvCFXHx33xn2UEij+8gnTBRNbd+/j/kth3Ml+LnZfLHWGQ6sE?=
 =?us-ascii?Q?s5iciQ6EihEKYqOSP/NYilkzZoI0oardu6LztiMhRnWcEbMPGIUT8cDRFxxr?=
 =?us-ascii?Q?DDoge/y5/0etN6kPjSXOqJpZ3KDj6RfGDJgd+kNw3LA13/n75XTTJJx5iHDN?=
 =?us-ascii?Q?mn+0iBe+TJ3mEI5FuFQjbnWcO889TjVWRPl5UsZPTz6EA2I+Ig2qqv6pRT/o?=
 =?us-ascii?Q?//92+5vzJpyBR4AC4tnN49EU2XtpZbGdQc4pQzhtSLtGyjjvn0a6+Qi7orqr?=
 =?us-ascii?Q?zVRXEJYrwzR/TXcWR5+MtLHMh3CLJFBXH0A9eRqxHCJMgPmlhQljAHVMOIGp?=
 =?us-ascii?Q?puS0KJU6KODjvxpVE31bITr2Q6xtWbN4SyS98m2EUgbn39d8F9x/aCNGuQ0Z?=
 =?us-ascii?Q?P8cFXONB5yUf9qj2imGSTWzACJu2ZyN80+q30gtdkSqm4h2va77PPgqGduV8?=
 =?us-ascii?Q?CnslSY3iAziWo+zWDTdp/kDGBoLBVubeGtqBFbKd9Sz4TghMs6vVnfRnQTZX?=
 =?us-ascii?Q?yZZ6VgMrOlcp+1yEQ6hV/7Cqcmlz5EFSWyd8hVrlaUYtSTefwmkcSVPi3sNx?=
 =?us-ascii?Q?rAY+E7aJR2aG+xu7T0A0OjiBkiYWMwhLApowSRkYUdYLbBw/pQk+lgP49kHp?=
 =?us-ascii?Q?0gs6EplqL27UXYW65d8hN25mBpIhn82vCbgvAMCPipn+ADqGAG8V1MTTHCaz?=
 =?us-ascii?Q?KvKQ7k2qUOmMRXWxuacIPklOp6tNv0ENjvEjUEArtihQNGWM/v0GmsIGGx2i?=
 =?us-ascii?Q?mSEqZ8qUMOwz6gU+a91QmiWz1DqJUTV6rLJ6LEk+aDRb4ULQNGRWwv9HwupH?=
 =?us-ascii?Q?5P0w2Q3Bj7CnhdxAGBQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?USRJFcso3wkqyJmGcd8ukO+NDFlxB6U0eR+rE4ejtDJtOWNG5bigKetU5GTh?=
 =?us-ascii?Q?W7CoZrL4+jcVcP5yfcK4ygzH8ecuhkWAYq6iP8loQvpj16hMqodxLz8pxhh0?=
 =?us-ascii?Q?VW0wrUr80LgobeYNs9t+LlI0QkJgZhgKX28V4efIrcl3226AcU2uL7wJp+1X?=
 =?us-ascii?Q?Zp5G9NQ2yj0xNBHLimDaDzZEwzQraEbv8b0mrsPkDYSsMXIXjmIch9HsMbXN?=
 =?us-ascii?Q?3hB8qg3pTQ4a227szAKdfpndvGSMNBgYejPNfSwH5+JqPxNpOgTDRpBFk29c?=
 =?us-ascii?Q?Al2v0eTbSKxdzy75offqfgAiC/YWg/ki2lJo3p1ZfxIq7Anvwn7NppvgkN4L?=
 =?us-ascii?Q?JnVyvWc5UZWQEyZhvJWS63xTk/WMKsCcefvg1txh9OMRBAiDOe1lNylHgjJg?=
 =?us-ascii?Q?vLYgTS8mySpcE2Hi0kb2ijL/cYijIGZi5zI7nr4z03pxPVassL30iVyspYvL?=
 =?us-ascii?Q?+NrBnL01rIYBgD1yoWKjKblTpwW6jN4fIoccIbxn17bBkf/2+6VDyCGbRUXd?=
 =?us-ascii?Q?3IfuFvuiGc7EeyIK9mP55hVBeXavBBwGFQaUJrYkvQt461lo3DHikY0Vr3e/?=
 =?us-ascii?Q?k8pzntbGyJ1g6BVg8ra+XK/7uZS6FaZWbgI1zpI9IxUPZ6nGvQ0tm7cBwwv6?=
 =?us-ascii?Q?SDuwCukPQ9F8ekG1qMuLcZPtCuSMdemrKznPxJlIPl/CEDxGLSKiet162B3K?=
 =?us-ascii?Q?t8iMSffhrjmr2xQbSj+MT2qchgIbpFRDMjEnr/tfcYHv9RVdXDs6SVSu3H2X?=
 =?us-ascii?Q?L9hihofsenZe/MZOELq/C9CyKipSVKDKD1PAMP3Xjyd0CDIAHe3ZhWfCqMQ+?=
 =?us-ascii?Q?tXkOKQIBA9iggSOfrJL6IbgydxdTVKuPnfvgrNX6OIRpAmakMs0dQLjUuJBI?=
 =?us-ascii?Q?kHQRplqyGfGMvJAHZJ6gBWBCdsWSWkKwTgdAkpQZeFRVDR/XnEmqnEGPw0uz?=
 =?us-ascii?Q?mUL6chTWHgxsfyvLcOaB+sEOdzyJmVxPZLy3H7sIq0Ks+aVTv37851aqlZEE?=
 =?us-ascii?Q?k+r6DfzMjkQUxRdeaseNx/kQyImsER2ntHQq2mjhTnlYi6JSnHGDav6YLVTY?=
 =?us-ascii?Q?b0qVQKdbyMG1wO0nUMAS0gxxSKqj4NxYpF7sPgXqfwnlUuQVoZ1Pp/+h0XIV?=
 =?us-ascii?Q?iav2LqMMDm2ySY+OdFlYzmORoyzVOaaAR0lp96Eku7GF8mw2aLG2Oa3lw93V?=
 =?us-ascii?Q?cnxU5xf+kLSg5ZvEjyRBHGjb4UBmZQUDFoWws4yjeqVi70PgOcGlgvQViiXz?=
 =?us-ascii?Q?KQFgTu4YafQeBPI8fO6LDnvIMx6QxOjY0h3O2utqKV6wCJnNubPiuYWYirYL?=
 =?us-ascii?Q?nAgSdhcJsWzFEB2YVqK5KAEZQ6WYxUZzR8ocAoYFtwtStDBLNCz214DHYD07?=
 =?us-ascii?Q?Ov0gXz/lpGW2gFA7Sj/tp30+PobX7eFe/uZtSQE2o5E2EeyfCdNg254QbIvc?=
 =?us-ascii?Q?v+0qyzIgy800jYPEebU/g5FBuV+upWg3Osjsc8Oq/ki6Bb35q2+C4BwZQCes?=
 =?us-ascii?Q?8cgSEHebtCuqVfxt9TH4uA62oqamEKq51gY59RqrCwu5PaRrLSGtMQMnukON?=
 =?us-ascii?Q?fedN5RzuKb/0i9aZRn2naZLpyUEhhD2Vc570FI+YetTIU6zjdiB7sLbcNWGP?=
 =?us-ascii?Q?TL2gjM+DZVcaAoKXZf1rJnbi/48mv2nV38/zOLnODHF1BfxUECy8QW7E2UAQ?=
 =?us-ascii?Q?bK6ODP3YlS7MuIOO5YH8e0PC3z4JrMzkG4/0UdkX1C7iIDbuj33ArefCuX7V?=
 =?us-ascii?Q?pb81mYmUVj3gxl/2xE3xiXZW8AiX7+E=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc1bf8f-a5fa-4aae-565d-08de69910083
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 17:14:23.4821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ts5ZAnmJG6Q6sLAxPNYI8sI+t3fN8aEoTjoYzHGvmCF1DJtC4Gr2dKc8E+VpHC9//UP+y7fwiZTF7sZE8jN2vr/SrMJcjMuI7J6wAfiZYyY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5941
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-18892-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hammerspace.com:mid,hammerspace.com:dkim,hammerspace.com:email,libnfsconf.la:url]
X-Rspamd-Queue-Id: 753BE126841
X-Rspamd-Action: no action

If fh-key-file=<path> is set in the nfsd section of nfs.conf, the "nfsdctl
autostart" command will hash the contents of the file with libuuid's
uuid_generate_sha1 and send the first 16 bytes into the kernel on
NFSD_A_SERVER_FH_KEY. A compatible kernel can use this key to sign
filehandles.

Also add -k, --fh-key-file=<path> option to the "nfsdctl threads" command
effecting the same result.

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
---
 nfs.conf                     |  1 +
 support/include/nfslib.h     |  2 +
 support/nfs/Makefile.am      |  4 +-
 support/nfs/fh_key_file.c    | 71 ++++++++++++++++++++++++++++++++++++
 systemd/nfs.conf.man         |  1 +
 utils/nfsd/nfssvc.h          |  1 +
 utils/nfsdctl/nfsd_netlink.h |  1 +
 utils/nfsdctl/nfsdctl.8      |  8 +++-
 utils/nfsdctl/nfsdctl.c      | 57 ++++++++++++++++++++++++++---
 9 files changed, 137 insertions(+), 9 deletions(-)
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
index 000000000000..e79c45958b54
--- /dev/null
+++ b/support/nfs/fh_key_file.c
@@ -0,0 +1,71 @@
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
+	size_t pos = 0;
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
+
+		if (feof(sfile))
+			goto out;
+
+		sread = fread(buf, 1, HASH_BLOCKSIZE, sfile);
+		pos += sread;
+
+		if (sread != HASH_BLOCKSIZE) {
+			ret = ferror(sfile);
+			if (ret)
+				goto out;
+		}
+		uuid_generate_sha1(uuid, uuid, buf, HASH_BLOCKSIZE);
+	}
+out:
+	if (sfile)
+		fclose(sfile);
+	return ret;
+}
diff --git a/systemd/nfs.conf.man b/systemd/nfs.conf.man
index ecdc4fc90327..a6b5c907b457 100644
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
index e9efbc9e63d8..97c7447f4d14 100644
--- a/utils/nfsdctl/nfsd_netlink.h
+++ b/utils/nfsdctl/nfsd_netlink.h
@@ -36,6 +36,7 @@ enum {
 	NFSD_A_SERVER_LEASETIME,
 	NFSD_A_SERVER_SCOPE,
 	NFSD_A_SERVER_MIN_THREADS,
+	NFSD_A_SERVER_FH_KEY,
 
 	__NFSD_A_SERVER_MAX,
 	NFSD_A_SERVER_MAX = (__NFSD_A_SERVER_MAX - 1)
diff --git a/utils/nfsdctl/nfsdctl.8 b/utils/nfsdctl/nfsdctl.8
index a86ffe8e1f4d..1f526e77bebf 100644
--- a/utils/nfsdctl/nfsdctl.8
+++ b/utils/nfsdctl/nfsdctl.8
@@ -159,6 +159,12 @@ These options are specific to the "threads" subcommand:
     kernel will start the minimum number and dynamically start and stop threads as
     needed. If the minimum is larger than the maximum, then dynamic threadis is
     disabled, and the maximum number is started.
+
+\-k, \-\-fh\-key\-file=
+    If set to the path of a file, use the first 128 bits of the sha1 hash
+    of the file's contents as the server's filehandle signing key.
+    Exports with the "sign_fh" export option will use this key to append an
+    a signature to guard against filehandle guessing attacks.
 .fam
 .fi
 .if n .RE
@@ -336,4 +342,4 @@ privileges.
 nfs.conf(5), rpc.nfsd(8), rpc.mountd(8), exports(5), exportfs(8), rpc.rquotad(8), nfsstat(8), netconfig(5)
 .SH "AUTHOR"
 .sp
-Jeff Layton
\ No newline at end of file
+Jeff Layton
diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index 6a20d180a81e..ed0c4fded339 100644
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
@@ -636,8 +638,10 @@ out:
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
@@ -663,6 +667,19 @@ static int threads_doit(struct nl_sock *sock, int cmd, int grace, int lease,
 			nla_put_string(msg, NFSD_A_SERVER_SCOPE, scope);
 		if (minthreads >= 0)
 			nla_put_u32(msg, NFSD_A_SERVER_MIN_THREADS, minthreads);
+		if (!uuid_is_null(fh_key)) {
+			if (nfsd_threads_max_nlattr < NFSD_A_SERVER_FH_KEY) {
+				xlog(L_ERROR, "This kernel does not support signed filehandles.");
+			} else {
+				fh_key_data = nl_data_alloc(fh_key, sizeof(uuid_t));
+				if (!fh_key_data) {
+					xlog(L_ERROR, "failed to allocate netlink data");
+					ret = 1;
+					goto out;
+				}
+				nla_put_data(msg, NFSD_A_SERVER_FH_KEY, fh_key_data);
+			}
+		}
 		for (i = 0; i < pool_count; ++i)
 			nla_put_u32(msg, NFSD_A_SERVER_THREADS, pool_threads[i]);
 	}
@@ -697,14 +714,17 @@ static int threads_doit(struct nl_sock *sock, int cmd, int grace, int lease,
 out_cb:
 	nl_cb_put(cb);
 out:
+	if (fh_key_data)
+		nl_data_free(fh_key_data);
 	nlmsg_free(msg);
 	return ret;
 }
 
 static void threads_usage(void)
 {
-	printf("Usage: %s threads { --min-threads=X } [ pool0_count ] [ pool1_count ] ...\n", taskname);
+	printf("Usage: %s threads { --min-threads=X } { --fh-key-file=file } [ pool0_count ] [ pool1_count ] ...\n", taskname);
 	printf("    --min-threads= set the minimum thread count per pool to value\n");
+	printf("    --fh-key-file= path to a file to set the filehandle signing key\n");
 	printf("    pool0_count: thread count for pool0, etc...\n");
 	printf("Omit any arguments to show current thread counts.\n");
 }
@@ -712,6 +732,7 @@ static void threads_usage(void)
 static const struct option threads_options[] = {
 	{ "help", no_argument, NULL, 'h' },
 	{ "min-threads", required_argument, NULL, 'm' },
+	{ "fh-key-file", required_argument, NULL, 'k' },
 	{ },
 };
 
@@ -721,9 +742,11 @@ static int threads_func(struct nl_sock *sock, int argc, char **argv)
 	int *pool_threads = NULL;
 	int minthreads = -1;
 	int opt, pools = 0;
+	uuid_t fh_key;
 
+	uuid_clear(fh_key);
 	optind = 1;
-	while ((opt = getopt_long(argc, argv, "hm:", threads_options, NULL)) != -1) {
+	while ((opt = getopt_long(argc, argv, "hm:k:", threads_options, NULL)) != -1) {
 		switch (opt) {
 		case 'h':
 			threads_usage();
@@ -741,6 +764,18 @@ static int threads_func(struct nl_sock *sock, int argc, char **argv)
 				return 1;
 			}
 			break;
+		case 'k':
+			if (nfsd_threads_max_nlattr < NFSD_A_SERVER_FH_KEY) {
+				xlog(L_ERROR, "This kernel does not support signed filehandles.\n");
+				return 1;
+			}
+
+			errno = hash_fh_key_file(optarg, fh_key);
+			if (errno) {
+				fprintf(stderr, "Error hashing key file %s: %s.", optarg, strerror(errno));
+				return 1;
+			}
+			break;
 		}
 	}
 
@@ -768,7 +803,8 @@ static int threads_func(struct nl_sock *sock, int argc, char **argv)
 			}
 		}
 	}
-	return threads_doit(sock, cmd, 0, 0, pools, pool_threads, NULL, minthreads);
+	return threads_doit(sock, cmd, 0, 0, pools, pool_threads, NULL,
+				minthreads, fh_key);
 }
 
 /*
@@ -1760,8 +1796,9 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
 	int *threads, grace, lease, idx, ret, opt, pools, minthreads;
 	struct conf_list *thread_str;
 	struct conf_list_node *n;
-	char *scope, *pool_mode;
+	char *scope, *pool_mode, *fh_key_file;
 	bool failed_listeners = false;
+	uuid_t fh_key;
 
 	optind = 1;
 	while ((opt = getopt_long(argc, argv, "h", help_only_options, NULL)) != -1) {
@@ -1836,6 +1873,14 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
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
 	minthreads = conf_get_num("nfsd", "min-threads", -1);
@@ -1846,7 +1891,7 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
 	}
 
 	ret = threads_doit(sock, NFSD_CMD_THREADS_SET, grace, lease, pools,
-			   threads, scope, minthreads);
+			   threads, scope, minthreads, fh_key);
 out:
 	free(threads);
 	return ret;
-- 
2.50.1


