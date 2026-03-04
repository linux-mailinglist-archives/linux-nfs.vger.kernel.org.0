Return-Path: <linux-nfs+bounces-19776-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBqIK9JVqGlutQAAu9opvQ
	(envelope-from <linux-nfs+bounces-19776-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Mar 2026 16:54:58 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C620203648
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Mar 2026 16:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10CE933C9635
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Mar 2026 15:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6A035AC1B;
	Wed,  4 Mar 2026 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="BcePkj1I"
X-Original-To: linux-nfs@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022101.outbound.protection.outlook.com [52.101.43.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6105535A927
	for <linux-nfs@vger.kernel.org>; Wed,  4 Mar 2026 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772638860; cv=fail; b=N8LyaxsyDsEJ6OqhCOM8eicQF05jPHr0o6bTEsJDt8JJDL6qcchp1zUSntB0lzX19OOlH87JCkwaY4kVFr0dRDqCoXfZ2P/FXJNz6QUgpkd+L/cUCOMTI/D9WxrXEeRLoszYi/Ut5JD54njZp8oSZNT1GIlvTRjU8v7qXIGdUcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772638860; c=relaxed/simple;
	bh=89fr9hBQvuVya2nRa0z72jIzWJKWuQ4I86josCqTKBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qEpJQ4Tz6OX5Cxa2eC1/qVm+LTLXTE5OZO+ztT2a016pG+a/4h9EJT+aYvvIk66Q6jLTEIVHopSTYPEyiNFx+ORwcDGX0GWbLk+N37mDC/hkpQj0cSKrAFLSlFJ/85yBxpYztcitb4u8aJ2gEktmzZbSIwtNuOIuKwNFclyFo2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=BcePkj1I; arc=fail smtp.client-ip=52.101.43.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/7kGwnCMuh4sN4MuOYW4QOJe968gEPH2CNS9EKD72AFjvpTuaXw2EVnqobqJKN77YzHU0dQOgITj+91p7fgb1rS+49bMtVqO7fxQrijegLfurcjHE2uNZ+5JOgNElDIiiF2v7EpGVtjZV2zNNpmQmmZ6N0iwf+SqIOylwtfDBkGE6hlzTU0jzTCAgFtcbvh0YQ23S7bD0Qt8eiHWdhCKV3DcyfHEaiWSMoX6vT3jxGqPqilX2xXZFpATNjPgFhf/7uas78s58z4IMf9GoYlcu2gu56f4QD7gRC1HzBlxUyaQC7G5AuyGYwTedO0ovpBTE4Y+ooepXmZtqERSTlr8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCI+o5YSh5tqWy8UgY+vFaGDIQp2AHv2vHmZ3UKkOxE=;
 b=ibzApLA4gsAKWBH8WrXxDjwfVIbOof13TixFLQsNvHg6RT+E67x/TFFtiHzGJzwmNqANxDZuu0UbtBH3+kzHG1Ilt5I2XCgTTVGdwoT53PBY878FP6EtDMDal/f7UcuzhneX09IusG/EtuPYC1Yf8j83i29/uUL5jm0uQBgDlCAJwIMeWd4AtGNes+Lg2TnoUmTY4effDi2rC5a7UdBBUwfzm9y/VAk8GppGs4aMRMNQ/PhqIEHi/KdXaUQ4b4l8Fh7QVc134WGxqZpt/0/4L1yvFmi4ALYW1uKm+xNAXbXY5Itwg8J+Jm8eeeMhnE/8J8v8F8IOLND7WTTQlFWgOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCI+o5YSh5tqWy8UgY+vFaGDIQp2AHv2vHmZ3UKkOxE=;
 b=BcePkj1IgtMQ9inPJnXqNxWs1d03VvIYLw/+m4Ojzse1Lgh9NwKco9U1x+41D34dGG7s2aixy0GY2nIZR9mpYG1gh3DrfMDubfRykKMnybIXxOKEAwZ889+6aruaS3dyFouWibwbpdiSo1GTdhRyHoT+iV7Ej53SbQW+/clt/wI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 DS2PR13MB7603.namprd13.prod.outlook.com (2603:10b6:8:32f::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.17; Wed, 4 Mar 2026 15:40:55 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 15:40:54 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Steve Dickson <steved@redhat.com>,
	Benjamin Coddington <bcodding@hammerspace.com>
Cc: linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v7 2/2] nfsdctl/rpc.nfsd: Add support for passing encrypted filehandle key
Date: Wed,  4 Mar 2026 10:40:46 -0500
Message-ID: <f554bcea7a408d08443996d010ebae49a7f3897f.1772638460.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772638460.git.bcodding@hammerspace.com>
References: <cover.1772638460.git.bcodding@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0102.namprd05.prod.outlook.com
 (2603:10b6:a03:334::17) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|DS2PR13MB7603:EE_
X-MS-Office365-Filtering-Correlation-Id: 38e1d6e9-8508-42f3-2111-08de7a046b7e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info:
	Xxl4MkfC/v5ba9asFStO9v4mCWpCQvxIeehy4UPJVS44A1As4O5WAxqGOEU/eRD18uZKDaEIojL3tKi66l/nvByzW9K1BaTxm+OBVzEEm1VRr7xcz3VO+RvrmkZ9P+ujSMFt9hy2uMEHSNjOPHvlHTWkQ6bOaF3O9iD7SKTBqbGCPxGAnKDLdpWoKitSO7KHUDa/aY9KYTQ5hx9JslEqbZ74moYi3HUriMj2WLch7Fo5ikfSbvg4Ba1UL/EsnPgzPxhPyiy1A43AFpbrkvYx8+vlFBqrQO5Rga3jgYnqRAyxiGbBLJdR8HXwvRzWMotfprAJ9bQjmbhKbIl12tRumJ0Zfxc8NcAJkTvTvuVMvt1CQz8kIKZyijB/tlilWP5r8TQSzuphPLhskJG+CTlK/XFuAB0r249FZOL8LeuqsEWjeVSlMdKDs4O3gOOVVeGc9uD+46dpCb/2IAw6X3F0osroa/H+j+Qh0PNlewWcAd650SbfQg4knCTS0KYAYVEu+aNR+2DJRxlOnnAhaTQJdaMAc1UQOhbFikhmt2elDb5u/dYuJ5rvGSGFdukpqtcNdFl75/rBh/vWyNwz9H6U3FYtvqP/eJnMd5YYCa+6E+zq6E02d+EoyLZyqVEsKe/qlG50QCz+7hKBWZH4x4NsaG1BIVDlZ+PztEQkMcGRoJ4Xdk/P6gQ7lfvjp0ag5m/quNbUORhLJ25Or5otsqc73hV5/q3XECMOmWsB2/urUUY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TCm2CcaCv5ORJl5jtbxTSyN3uP/I99CrVGktY8DUINZ47CpNyp+thLZBdGGE?=
 =?us-ascii?Q?GtglOJ8XVodVE3MjKcB5MGD9v/cKp9ioGlB4+uiEsG2pJ05y32oZKXWWmRTK?=
 =?us-ascii?Q?PHEdwLJcyra/zrzpla9Kn3FfNfuDKYOy+fWSSmYeS5sgwUUbtesw5f+FZsFM?=
 =?us-ascii?Q?TxRUFadDDBoTxFZqIFY7Je4ggrRbww59BNE8eu7UkdseQgkFgkXfRQwISeGh?=
 =?us-ascii?Q?BiRz1/jGS+PBsNs8vDx3kblzdJ0eihq5Ry/ZSJIpvXmDMepXMOgXpPA9eJg9?=
 =?us-ascii?Q?8Wfzo0ASP/2/gqtkiQQLE5tg9IRxFFUkoq88Gta5boc8cYfP7s7eFUh9433S?=
 =?us-ascii?Q?zbJa0xxl3PLCPFFBAe/lptxxR2TDQWJOAFTGiZwu1IOZtemhC/H3uUAcaGuF?=
 =?us-ascii?Q?2zPko/sTvxRoI4tlnvbjf2WpeOX1mq5PwAMVCFwqruFy1naatyYbDmZyizpo?=
 =?us-ascii?Q?Yb/lalHp2YP95fEq6J0D+LNkAVqySvePqRNhStIgM+8o9icDjgJ3crPra7Lq?=
 =?us-ascii?Q?8KeytcuT3UDj+IwZYmSPXj3rofx3x5oquP5gC5Qz61hhYtghgKGFhxvBFUc0?=
 =?us-ascii?Q?1aT7ARsqgmAwkfN8fl2h3uBv/gkoKyOqbYyaqzwgbXVw06ftJ3IPCx5GybWC?=
 =?us-ascii?Q?rsernJ6hOkG1Wri3r3UKteydghNuk16d7x7Fxxj/I0EI7gDltjhYcLvWerg4?=
 =?us-ascii?Q?3qcu+jWGJqpjDVDSna6DMeHDWP7VbB4yWH9hLhqZNyrFpu6lNes0GnX3IUue?=
 =?us-ascii?Q?DCFptqLpHARLLQuQJjDsUbEu1Y0bKpkrvRzOoq4dQiaHV1+c1nJ8Hm3U8lmZ?=
 =?us-ascii?Q?8KkgC0iCyfyyitEIrdfpBPkKhxZKI0+7AYGe+XfwW4l81wr4gC3LYQP7dfK7?=
 =?us-ascii?Q?6ZLwoak8qFB8q7qmgzClygr1u1bQZMxC7jp3vbam6ShCc5qVR+OOj/cno51g?=
 =?us-ascii?Q?2/vnb6BKyPbiYY8ybmffWqJyRF/L6mstX+32uKaZDupOfMHoQ/tstD/e16ux?=
 =?us-ascii?Q?+6uTmNP+ROvuVdh4W0wnd5QtgwslSmVngEvmBfX5UUg1t95lMeuUs8uwKbWX?=
 =?us-ascii?Q?4Bie8ws3Wy33XGUe98bF+HIFfFP8V6k/D+2MVgZGc+snFv1UtBQUbh8Pe46W?=
 =?us-ascii?Q?Rq8QH565RQXhtIHHbzZxQ2oAfJNY7AxsbajA/qrCRiSh5vJTVpyRuxBeec6s?=
 =?us-ascii?Q?Skeuxb6OEwoyvEyy7WKR7iU8KLBijwfSb3g1VPSYDWi6m61zmLPRO+1Wk2nc?=
 =?us-ascii?Q?e4L+8qd8tNPSWyeHPxi/WtaTB85SmJw0GVeEaVsRkezJ4LXffmekWmszCKPA?=
 =?us-ascii?Q?T4/RFAy5Jp+GBPWkAs2gQeKUD34IhoZOTUHVfHiljiW8Zw+syAvOeMC/URwy?=
 =?us-ascii?Q?GwY/bK9fzDsLa9vRpoqdnHSBG5UAT40kBLOrlUUkY8or5wMzJIKvZgJBxYew?=
 =?us-ascii?Q?zumJ2sEB8p2TmM3FKzUT4cs7PDKABOC1bBQMxvYZLiv79F62T2l8a6FrTQbb?=
 =?us-ascii?Q?YlEIPw0ervFFJ9GtqS8hG5Jy5R/7x0pW/vctq6Jb5QWweqL9mDt6hqa2zbms?=
 =?us-ascii?Q?JHsA7GegkKvsJ9weNqxAii36MquNxq+9Gr8kKCP/v2bfUrI7gjp1eA598qTR?=
 =?us-ascii?Q?U4T4eKjDKVA40rm3v3sv1SuL3zBKXVgnBM7nUrfgf5LN/XnpiGdAxNoL6qna?=
 =?us-ascii?Q?/rQ1Rr7gb1aHhKWSYEwSopG+gyhKfkX/v+Cy5ju6LZJmvtVW26GnP5Y8AEu3?=
 =?us-ascii?Q?hXI42Utz+D1jobl7snAwuSxmW6BXUlM=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38e1d6e9-8508-42f3-2111-08de7a046b7e
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 15:40:53.7531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SiOGy0BLC6/Q1OnZlks9fWOmps5hoGX5OCMWOqDOZsTPEdAUQSVGKYqJaJBPaPc5qOmv9m1E6uoYWUUl8xSQzW29wd1OWNDA++/5HZGDiiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR13MB7603
X-Rspamd-Queue-Id: 1C620203648
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19776-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
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
 support/include/nfslib.h     |  2 ++
 support/nfs/Makefile.am      |  4 +--
 support/nfs/fh_key_file.c    | 63 ++++++++++++++++++++++++++++++++++++
 systemd/nfs.conf.man         |  1 +
 utils/nfsd/nfssvc.h          |  1 +
 utils/nfsdctl/nfsd_netlink.h |  1 +
 utils/nfsdctl/nfsdctl.8      |  8 ++++-
 utils/nfsdctl/nfsdctl.c      | 57 ++++++++++++++++++++++++++++----
 9 files changed, 129 insertions(+), 9 deletions(-)
 create mode 100644 support/nfs/fh_key_file.c

diff --git a/nfs.conf b/nfs.conf
index 222447dd7d22..e2b8b20b0591 100644
--- a/nfs.conf
+++ b/nfs.conf
@@ -75,6 +75,7 @@
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
index 000000000000..5f5eafc1f19c
--- /dev/null
+++ b/support/nfs/fh_key_file.c
@@ -0,0 +1,63 @@
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
+	int ret = 0;
+	size_t sread;
+
+	sfile = fopen(fh_key_file, "r");
+	if (!sfile) {
+		ret = errno;
+		xlog(L_ERROR, "Unable to read fh-key-file %s: %s", fh_key_file, strerror(errno));
+		return ret;
+	}
+
+	uuid_parse(seed_s, uuid);
+
+	// Read until EOF or error
+	while ((sread = fread(buf, 1, HASH_BLOCKSIZE, sfile)) > 0) {
+		uuid_generate_sha1(uuid, uuid, buf, sread);
+	}
+
+	if (ferror(sfile)) {
+		ret = errno ? errno : EIO; // Ensure we return a real error code
+		xlog(L_ERROR, "Error reading fh-key-file %s: %s", fh_key_file, strerror(ret));
+	}
+
+	fclose(sfile);
+	return ret;
+}
diff --git a/systemd/nfs.conf.man b/systemd/nfs.conf.man
index 80c4f34eb7f8..6751fb8763fe 100644
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
2.53.0


