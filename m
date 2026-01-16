Return-Path: <linux-nfs+bounces-18036-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96258D38420
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 19:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E021B30C759F
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 18:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FECC39C634;
	Fri, 16 Jan 2026 18:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="F40pmVsr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020136.outbound.protection.outlook.com [52.101.193.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DC83590D4
	for <linux-nfs@vger.kernel.org>; Fri, 16 Jan 2026 18:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768587494; cv=fail; b=VetL5OKUAg/yOrzN3BqCe68YW59R4EA/6zWp7FZxfcKZ4r56RvxZ7gYKGlSI0rFTMlrDPfHPgdk4qCx7w3nPAN6WSJN9t4dazP/ikss63NwT7iFpo4wgVwYlTrieP2Qt57jNV3IwqsMw2gnbbRbH7GGi33LYvKpZ8UI9NEv2H8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768587494; c=relaxed/simple;
	bh=CjHOnwzc3LixupAjKQF6G65jU9dSDlxzlmh5OZtLuNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W/HiK/GKgYjWUOFJjtGQ3usK+qhaTXnf42p7OIbb4phjG6Wq8MVWA4gRrnqwS4y2F1dlEqffA+/rBxJhG3JCGbNX6ZU4mB9BDiHWLu9rCeKm5f9y+tHtcenKnlLdoQZL537JI1jQyZXckb8OOKrW2hTq0bpT7ThswU4KTHbMxWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=F40pmVsr; arc=fail smtp.client-ip=52.101.193.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J8ZAT6osF69Qm+pf/yTjizstManqV+6bYLGx02R+BwikKA5s9pH3cv4ZkV3pZipv6Z35+CtSC4+aZRoFVX8keD1iXypE7VfSXOOkO3DT1hNCe8udwMgAFJTBnWnGb2+IHgOqNlnB+p35k/0fFBzMmhjfa3txUDcxlMcXLGp9WDeQWlbwQDE6+4AL0a1z7j8x6+7rhk2ZK/gi14nQCYZ0aAtUrfUcXuExtZ0/8r4tOrCZdGeXyR5opEJ3CCt58b++G4g02WZaUCEqV1+jAsdQE8xJI2dk/tD5ltDc5NjokK1W1QPek3Kip7JKif/3OSptcFfS5hQPUm3YJ0zqqjaGxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P83U8uHc9N1/ekz/8qW5Bs9BhyODAPsYlS3UHq9fA+Y=;
 b=AdiB4NQEZC6IsEmXUrkegU8k+b6oNZyMpj5qUIGhA2+3r2wLijkK92GDruAfs20ienF6cgiZL9nkgJSsyrCmZJ4lzT1GyaUwZQBEr05X00UTpva8UBFMndyeyO4X5hegk6WXb5UHQzz61AwsGmj+N4aNUjiheE6YXcfIVw63coV9W4FuJSUyy6brAJzm5QyCfNGn1+ulsRRsKfnoLj76cre9cIJRMy9nzJDZnY0vcuk90m1aOtAGAN7nP/FIclv9SSmFyTag6zOMb4yYGu91H9mkuD6dhl67EahMza2vFhNwrDMQYPrT1vplEo1P1XBHmMzejRibnCMzAkvS992msA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P83U8uHc9N1/ekz/8qW5Bs9BhyODAPsYlS3UHq9fA+Y=;
 b=F40pmVsrmwyvxKatJDvfEdT1ClpWyGdICNfy9TaYhAJqm88W0kMmWHveYaqTOmt/SFbXzSYmbCqSswcokhHYwkJ07OKoeVhWgq5+YTNb3cbMu39yqP9fEvltsTEr96FsUvb53nuT49/wuY8+/H4WJD4ZqcchORTtYYP/Ruw5GUc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 IA3PR13MB6935.namprd13.prod.outlook.com (2603:10b6:208:521::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 18:18:07 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 18:18:07 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Steve Dickson <steved@redhat.com>,
	Benjamin Coddington <bcodding@hammerspace.com>
Cc: linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v1 1/2] nfsdctl/rpc.nfsd: Add support for passing encrypted filehandle key
Date: Fri, 16 Jan 2026 13:18:02 -0500
Message-ID: <90fad47b2b34117ae30373569a5e5a87ef63cec7.1768586942.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1768586942.git.bcodding@hammerspace.com>
References: <cover.1768586942.git.bcodding@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P222CA0021.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::28) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|IA3PR13MB6935:EE_
X-MS-Office365-Filtering-Correlation-Id: a5a054f5-842d-446d-6a2e-08de552b97ec
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3lsxrqRrz0qdL3xSaAV17vpCqNkWEYoTvALRfGU/H085uj+/ji8FIHUa/WS7?=
 =?us-ascii?Q?IdpUIhAjBLDhI8KWBLqD/lvAxeVC4VG6OxJlefjoZqdnGcsp6lpGur9oa9uV?=
 =?us-ascii?Q?/WsDybE/y2gBFMZ7nVH1ZbBhemSB0BuY382y6QEa1Hty9c26xSxzPe4HRXUv?=
 =?us-ascii?Q?H7olR/RICa4ad4iuf1NL8uBTtHufTkJOXzjHXWgXI5e73PwPGoMLFbhSurAJ?=
 =?us-ascii?Q?qzDsPFOzULFjGJfdTGblkV6/yK19yTpvirw/VVccWUenvdqiCdT8mDImxjIJ?=
 =?us-ascii?Q?btstoGSN4CynbXdGefadcNSan3rwH4aiy2a2SfsavSr4RhXpuiOyyHjpKNac?=
 =?us-ascii?Q?IJDEjnNgTmyBBUXaGSbPrDmU6NzRr8WF4QXIFW2c4QgO+rIwD1Own4jzJnal?=
 =?us-ascii?Q?DVAypW2IYQPDH9W0d7l1iE3+ZgwmIB1etmPYubrM0vYIATugtVvqKOZtogGG?=
 =?us-ascii?Q?ivBVM56UnPqLPLyFScc7WW1Vvn6VPV1J7YvZVEPdIuWy3kO/Wqhlw9L8mtn8?=
 =?us-ascii?Q?hqtjalaptbAFmNGCJDFP6y6RHdbKq/Kewdmx0OJAUzZuWhbFsnq1I1ZurReM?=
 =?us-ascii?Q?I6NykFxgVbkNMxsc050ZngqnXUdChEDrRU/bqzmeTiW82s82dN3xOWPxcaQp?=
 =?us-ascii?Q?ESBwu8Ajz72Y9kjr2Y8I/pQrbrkM8N3wU3g1KO95oGzc3Ce/yhxfEjTpGAeW?=
 =?us-ascii?Q?OEBuL4zT2Wdw22X7Y9OAq9jcC/5/SbfwMCRErHximrmaJsEM+zdAP4ZNwruV?=
 =?us-ascii?Q?8n/RirmTQjVy6/JxK2DXfRU4CsDq0n0pj+RSyoJv5yGaShJ3F9OmY5CZ9bQr?=
 =?us-ascii?Q?sr3TwtyY97vTcskcZxSi79AgDeTxFgibO5pu33Iam+RLOEyD2J1yeitKt4kN?=
 =?us-ascii?Q?iX9YYXGmNNhmM2VJ5VmTcqhZ63Mda6o4hdCtlmgtSN+4qCWR5lhPWZYZNI7P?=
 =?us-ascii?Q?Ghr7gy92juApUkO0iGGyhK0Ni8q6dx+pDscRJ/BFCN6rZT7K3ZLTtmOSgtQp?=
 =?us-ascii?Q?d6ZDJwZ68tnBeAyrF9+z2R52kRpS0uNm/fGMbuspnNobeDfJIWCvY8hIOBYz?=
 =?us-ascii?Q?eb1OLC9V+2lt1DWp3nWllhiyQ5y/WW1Z0uRTFfs/TNVgWV08iL+ZQqyXbA1M?=
 =?us-ascii?Q?vIfoyT1eKk04J9FUhqSJNqoVWFeb9zAps+tQ/PzOr6dxqON25u2EHccLltsp?=
 =?us-ascii?Q?wf6f5ZXXAynTVZAvnETLbk7HxzgxdmIREjkWEoZ7TuFv9y9Ssxfdayt72xK7?=
 =?us-ascii?Q?26B+k+imh5pypRsbH3Mmh1rowWomH/YkDDYF/VRBo4niZJSQ89uAaz5oens2?=
 =?us-ascii?Q?ZbpYSq57KKuR2B/77+w/inG9q1c9ukwESGmK30XmezXYguWjiH72p6rX2JtZ?=
 =?us-ascii?Q?Vyv12qlpZOwAxHBWSr6F20XZKR3QZrQ5SLMm1r1sHE7p+6iQcdFV+lyxvE1k?=
 =?us-ascii?Q?DuvfARrEeoMvZZeFfZVz06mkkPa2oOAmhxwBCwlEz+M8k5LJN9geBeCMeSIY?=
 =?us-ascii?Q?HBt+1N/xn4/V0UQpJbBVqH/1I7/6TQQYi2d4xFZ9eEqk97kothY+k1w7AqcW?=
 =?us-ascii?Q?/4VXcs9KA2pfwPpTEEg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zWC6RI4Mx7hfWsy/M3cO5dCaqLRGT2N0vjiAvD1OzUnfLFBKQO1guWMRp01m?=
 =?us-ascii?Q?5W+eUyEhDYfHuunEJf/uRaFZ+mzcIUkxsztb3NXjj7MP10ohS+1rSG7nu1fl?=
 =?us-ascii?Q?+9DkvoWtu6/GRmyzt+9QoL7yH3xNHTC7IH/cK5FAbMoMi/juy+OHogTGDkFo?=
 =?us-ascii?Q?UKddAk7yYaZbe2Dmbsqe1kffBsqkIWQQArTx7scE/0HqjzzqgLMNXENb4Vwm?=
 =?us-ascii?Q?AzUq8X/qGtapnyt/RtuJeKyxkZ9iHw4aUuwGAOM85F1psvCytjRBIFcUrZSe?=
 =?us-ascii?Q?fpz+Jjfk4zGIQH1/2GKSx8IY9VtAv53y0xNrGysKmPLb5J5W7VZMj2F4dRjd?=
 =?us-ascii?Q?E1d7rEkE6sERII8JyUSyqs01/QBzBfWOkjYKcH+tJL4YvzwQz74PlbCOdL4N?=
 =?us-ascii?Q?LUpojBTm8rpeA2CPKZT7kza6uf9aG3nOicsuVhi7AkzgQcpF5sC9l7SBbofK?=
 =?us-ascii?Q?xReHu9WItLhwJYiG9Lpj0aBKgM9p1pTXowUGf/n5K5Tv0T0ri0/8eGeE5RmU?=
 =?us-ascii?Q?IQ4Yzv1BAWaM6VXkWm5FGk/2f8ZL5W5iLUpjTy8/Xs5SKL8Y8AacuX/KufxM?=
 =?us-ascii?Q?/rxQrPEjXwgMuH2Uv/vdnjlqXhh2JuULhN/gTXtXDeXEJtzySTBlIedeSENY?=
 =?us-ascii?Q?MwmY53dkiIHI98jZa/0ECMdqC7oul9kEQiLEtm/jCuyxMjbU9Qm1xu7lD4kC?=
 =?us-ascii?Q?BPB96lua2t8HLGZpXEXfnzYq4KST85pi8DKfV538C1Hwkcim2G1ZMtjcmfm0?=
 =?us-ascii?Q?TQE5j0FLhtCtj0OT4UbtNa5QyycA4S/y42iZNhnowKmSy2U+/Fj96XkVoH7w?=
 =?us-ascii?Q?wN61jdm57B3rci981rC6XRb1zzuZJza70lz7ifJVPX2Xps0CoToOaREd1X57?=
 =?us-ascii?Q?7Nhtz6ylHcN84L/ce1ERkPGyXYReubSFJWM3i1ku1HwVUgy5cxbuyzKa23yM?=
 =?us-ascii?Q?3AWuZhflybZ19FvBUzT7jeV1lpQk1DUUcTSS6PDgq0oo9i1xQpqKdufhXKiY?=
 =?us-ascii?Q?hqK36/L7S+0BCgCGvV2ePPOlnQAfc8StnwEDHZrLSfiT3wYZrAjMhpaGu/AA?=
 =?us-ascii?Q?Z/czgRQHhAc3VHDaq4lF/5aISwOlS9LcEi7uklkbKFMXn4g3pPHJRRmw3L8M?=
 =?us-ascii?Q?h/dIR4yyo2y5RHWZmAvqo6rzTR58Nt2ICZ7649D6pcfU9CNrwPslags37R97?=
 =?us-ascii?Q?5oxydKjemIUUF5XMHtHETIhyBBGyxorvy2jcSQDGdvtlMPblnEzjv12rpRBS?=
 =?us-ascii?Q?oiyz4p45M9M2hMYWVnwgzP0qBq7csqBOY9BLO2KxuqEp2DCaX5ibJ/SAEzFA?=
 =?us-ascii?Q?+BcOm1XXoUjES7E2Qv3v/f7lI5MMFe24zwQOGkbj0mvy5ER8O86+UDnBWfKO?=
 =?us-ascii?Q?C2T+/BIapTMFBllrLe6CSJDWiun1yfKiFCyK5Ynatn/QUcXrlvyRUe7Q1Wb7?=
 =?us-ascii?Q?7X7HFoN0CjBWqtO4e4qzNG+wlXA9Cl8szV3rOY8kqaxu+hbacEUUiqi9Fdm/?=
 =?us-ascii?Q?YRoevbFGqxig2gqw0lhWQE+PQOcwqR7Fjm3amMd8Adti0yW4g3MY0cOAbQLp?=
 =?us-ascii?Q?rNdwWW7NRmWrQ9RehcBMpI+bce5fVn9x7Z88ubNINBUel3YIGq6pzHzpHlMG?=
 =?us-ascii?Q?n558lZsT7aSAn7wW34yRxPUWA+ZCdgjAaxZrRLPTkdKkwaruwGUVWAgJKml6?=
 =?us-ascii?Q?2JHRWPqf1sMH24/1vLAWQHkxHtphyTbCV8KGF0bGA7mqMvECJ7k8GtS9/0+k?=
 =?us-ascii?Q?H/BPqZh9SOteCuPiadSlZP0rf3qou2s=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a054f5-842d-446d-6a2e-08de552b97ec
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 18:18:06.4800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mLb9dufYCHS6hgIjF8AeQsWAS22f97RTJo5x56JBL4cqG1gjZPydW6Nj3r4wYX67wMm4LmV0N6l0FMIZyHNSQ9+KcYEaHhC+HjIRtXkVf0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR13MB6935

If fh-key-file=<path> is set in nfs.conf, the "nfsdctl autostart" command
will hash the contents of the file with libuuid's uuid_generate_sha1 and
send the first 16 bytes into the kernel via NFSD_CMD_FH_KEY_SET.

If fh-key-file=<path> is set in nfs.conf, rpc.nfsd will also hash the
contents of the file with libuuid's uuid_generate_sha1 and write the
resulting uuid into nfsdfs's ./fh_key_file entry.

A compatible kernel can use this key to sign filehandles.

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
---
 configure.ac                 |  4 +-
 nfs.conf                     |  1 +
 support/include/nfslib.h     |  2 +
 support/nfs/Makefile.am      |  4 +-
 systemd/nfs.conf.man         |  1 +
 utils/nfsd/nfsd.c            | 16 ++++++-
 utils/nfsd/nfssvc.c          | 26 +++++++++++
 utils/nfsd/nfssvc.h          |  1 +
 utils/nfsdctl/nfsd_netlink.h |  2 +
 utils/nfsdctl/nfsdctl.c      | 86 +++++++++++++++++++++++++++++++++++-
 10 files changed, 137 insertions(+), 6 deletions(-)

diff --git a/configure.ac b/configure.ac
index 33866e869666..db027ddbd995 100644
--- a/configure.ac
+++ b/configure.ac
@@ -265,9 +265,9 @@ AC_ARG_ENABLE(nfsdctl,
 		AC_CHECK_DECLS([NFSD_A_SERVER_MIN_THREADS], , ,
 			       [#include <linux/nfsd_netlink.h>])
 
-		# ensure we have the pool-mode commands
+		# ensure we have the fh-key commands
 		AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#include <linux/nfsd_netlink.h>]],
-				                   [[int foo = NFSD_CMD_POOL_MODE_GET;]])],
+				                   [[int foo = NFSD_CMD_FH_KEY_SET;]])],
 				   [AC_DEFINE([USE_SYSTEM_NFSD_NETLINK_H], 1,
 					      ["Use system's linux/nfsd_netlink.h"])])
 		AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#include <linux/lockd_netlink.h>]],
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
diff --git a/utils/nfsd/nfsd.c b/utils/nfsd/nfsd.c
index a405649976c2..08a7eaed4906 100644
--- a/utils/nfsd/nfsd.c
+++ b/utils/nfsd/nfsd.c
@@ -69,7 +69,7 @@ int
 main(int argc, char **argv)
 {
 	int	count = NFSD_NPROC, c, i, j, error = 0, portnum, fd, found_one;
-	char *p, *progname, *port, *rdma_port = NULL;
+	char *p, *progname, *port, *fh_key_file, *rdma_port = NULL;
 	char **haddr = NULL;
 	char *scope = NULL;
 	int hcounter = 0;
@@ -134,6 +134,8 @@ main(int argc, char **argv)
 		}
 	}
 
+	fh_key_file = conf_get_str("nfsd", "fh-key-file");
+
 	/* We assume the kernel will default all minor versions to 'on',
 	 * and allow the config file to disable some.
 	 */
@@ -380,6 +382,18 @@ main(int argc, char **argv)
 		goto set_threads;
 	}
 
+	if (fh_key_file) {
+		error = nfssvc_setfh_key(fh_key_file);
+		if (error) {
+			/* Common case: key is already set */
+			if (error != -EEXIST) {
+				xlog(L_ERROR, "Unable to set fh_key_file, error %d", error);
+				goto out;
+			}
+			xlog(L_NOTICE, "fh_key_file already set");
+		}
+	}
+
 	/*
 	 * Must set versions before the fd's so that the right versions get
 	 * registered with rpcbind. Note that on older kernels w/o the right
diff --git a/utils/nfsd/nfssvc.c b/utils/nfsd/nfssvc.c
index 9650cecee986..4f3088b74285 100644
--- a/utils/nfsd/nfssvc.c
+++ b/utils/nfsd/nfssvc.c
@@ -34,6 +34,7 @@
 #define NFSD_PORTS_FILE   NFSD_FS_DIR "/portlist"
 #define NFSD_VERS_FILE    NFSD_FS_DIR "/versions"
 #define NFSD_THREAD_FILE  NFSD_FS_DIR "/threads"
+#define NFSD_FH_KEY_FILE  NFSD_FS_DIR "/fh_key"
 
 /*
  * declaring a common static scratch buffer here keeps us from having to
@@ -414,6 +415,31 @@ out:
 	return;
 }
 
+int
+nfssvc_setfh_key(const char *fh_key_file)
+{
+	char uuid_str[37];
+	uuid_t hash;
+	int fd, ret;
+
+	ret = hash_fh_key_file(fh_key_file, hash);
+	if (ret)
+		return ret;
+
+	uuid_unparse(hash, uuid_str);
+
+	fd = open(NFSD_FH_KEY_FILE, O_WRONLY);
+	if (fd < 0)
+		return fd;
+
+	ret = write(fd, uuid_str, 37);
+	close(fd);
+	if (ret < 0)
+		return -errno;
+
+	return 0;
+}
+
 int
 nfssvc_threads(const int nrservs)
 {
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
index 887cbd12b695..f7e7f5576774 100644
--- a/utils/nfsdctl/nfsd_netlink.h
+++ b/utils/nfsdctl/nfsd_netlink.h
@@ -34,6 +34,7 @@ enum {
 	NFSD_A_SERVER_GRACETIME,
 	NFSD_A_SERVER_LEASETIME,
 	NFSD_A_SERVER_SCOPE,
+	NFSD_A_SERVER_FH_KEY,
 
 	__NFSD_A_SERVER_MAX,
 	NFSD_A_SERVER_MAX = (__NFSD_A_SERVER_MAX - 1)
@@ -88,6 +89,7 @@ enum {
 	NFSD_CMD_LISTENER_GET,
 	NFSD_CMD_POOL_MODE_SET,
 	NFSD_CMD_POOL_MODE_GET,
+	NFSD_CMD_FH_KEY_SET,
 
 	__NFSD_CMD_MAX,
 	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)
diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index 48b3ba0b276c..efd4c1cf6d8a 100644
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
@@ -1597,6 +1599,81 @@ static int configure_listeners(void)
 	return ret;
 }
 
+static int fh_key_file_doit(struct nl_sock *sock, const char *fh_key_file)
+{
+	struct genlmsghdr *ghdr;
+	struct nlmsghdr *nlh;
+	struct nl_data *data;
+	struct nl_msg *msg;
+	struct nl_cb *cb;
+	int ret;
+	uuid_t hash;
+
+	ret = hash_fh_key_file(fh_key_file, hash);
+	if (ret)
+		return ret;
+
+	msg = netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
+	if (!msg) {
+		xlog(L_ERROR, "failed to allocate netlink msg");
+		return 1;
+	}
+
+	data = nl_data_alloc(hash, sizeof(hash));
+	if (!data) {
+		xlog(L_ERROR, "failed to allocate netlink data");
+		ret = 1;
+		goto out;
+	}
+
+	nla_put_data(msg, NFSD_A_SERVER_FH_KEY, data);
+	nlh = nlmsg_hdr(msg);
+	ghdr = nlmsg_data(nlh);
+	ghdr->cmd = NFSD_CMD_FH_KEY_SET;
+	cb = nl_cb_alloc(NL_CB_CUSTOM);
+	if (!cb) {
+		xlog(L_ERROR, "failed to allocate netlink callbacks");
+		ret = 1;
+		goto out_data;
+	}
+
+	ret = nl_send_auto(sock, msg);
+	if (ret < 0) {
+		xlog(L_ERROR, "send failed (%d)!", ret);
+		goto out_cb;
+	}
+
+	ret = 1;
+	nl_cb_err(cb, NL_CB_CUSTOM, error_handler, &ret);
+	nl_cb_set(cb, NL_CB_FINISH, NL_CB_CUSTOM, finish_handler, &ret);
+	nl_cb_set(cb, NL_CB_ACK, NL_CB_CUSTOM, ack_handler, &ret);
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, recv_handler, NULL);
+
+	while (ret > 0)
+		nl_recvmsgs(sock, cb);
+	if (ret < 0) {
+		if (ret == -EOPNOTSUPP) {
+			xlog(L_ERROR, "Kernel does not support encrypted filehandles: %s",
+						strerror(-ret));
+			ret = 0;
+		} else if (ret == -EEXIST) {
+			xlog(L_ERROR, "fh_key_file already set: %s", strerror(-ret));
+			ret = 0;
+		} else {
+			xlog(L_ERROR, "Error setting encrypted filehandle key: %s",
+						strerror(-ret));
+			ret = 1;
+		}
+	}
+out_cb:
+	nl_cb_put(cb);
+out_data:
+	nl_data_free(data);
+out:
+	nlmsg_free(msg);
+	return ret;
+}
+
 static void autostart_usage(void)
 {
 	printf("Usage: %s autostart\n", taskname);
@@ -1611,7 +1688,7 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
 	int *threads, grace, lease, idx, ret, opt, pools, minthreads;
 	struct conf_list *thread_str;
 	struct conf_list_node *n;
-	char *scope, *pool_mode;
+	char *scope, *pool_mode, *fh_key_file;
 	bool failed_listeners = false;
 
 	optind = 1;
@@ -1683,6 +1760,13 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
 		threads[0] = DEFAULT_AUTOSTART_THREADS;
 	}
 
+	fh_key_file = conf_get_str("nfsd", "fh-key-file");
+	if (fh_key_file) {
+		ret = fh_key_file_doit(sock, fh_key_file);
+		if (ret)
+			return ret;
+	}
+
 	lease = conf_get_num("nfsd", "lease-time", 0);
 	scope = conf_get_str("nfsd", "scope");
 	minthreads = conf_get_num("nfsd", "min-threads", 0);
-- 
2.50.1


