Return-Path: <linux-nfs+bounces-2299-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D977387CD5C
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Mar 2024 13:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1B4DB224E9
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Mar 2024 12:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C443241E0;
	Fri, 15 Mar 2024 12:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="NQZY06AJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2077.outbound.protection.outlook.com [40.107.20.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DA21AAD2;
	Fri, 15 Mar 2024 12:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710506676; cv=fail; b=sZrVGimDPO0x6lEZqIhOYUO0vy1QEZroEJXkjpgrdERfPvUv1kVFfsVkYnD6nIdGGJOvQ7eabCdg0q4HzGiwJh8HA69nLkC5YIXHF92TWe0s15uQhTpJsQNqFIZTz0rSfXJJNzh551S94g2bo6QyjcwlTwUPJlTj9Da3sYIzQpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710506676; c=relaxed/simple;
	bh=TjT8KbgqRvYGh5bnxW85QV3w6qQ2JI/x3JerBKJTR1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F9Sb6dN2sRADxLd4CTA6MbWMxZlJXIGXhzxmBFMhTglr992J8pGy1LCUtB6OwpXqx/ya3s+Kt9TtzAkyZnZbQwaIF2Ykk17qUvUVhoYLjswURTus57NNtYUZ2vLDTBvvtIN4MzlneXWYQyeoUcfY84Q3LMfcM46VONQnArfJD9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=NQZY06AJ; arc=fail smtp.client-ip=40.107.20.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHrxnfvENOC3QrsAAqV0RpyMssIsOjrr2XhjHUQUmmy3lyb4kxy7zOc7wegWNXM23w8F1KXJgDvjtaARVqQe7+eaIrHS4s+ChCHrEWfMaZ28gxZsmdKoCN4s5FN1rv8HD0DWP0uCNYxM6kP8HdTm4LCHdL8PTi/DKsi2a3+dn4BplbB3gXBInCO1ZeIYuIOfjDk25ZE497qBx97bZbFTolGaXY8TTt+wk2wgvOCXeoVRkJnm1SAF5D0jPo2zZqAzAapoP4DP8RPLHC8yvzWFlhyw/9IoEswpmbb9yMOpE4OzdKdK1f62KVrm9uvvRtzRDIuJFYIc21wMil2qxNrYmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJK99GI76PSJQltt+MdyP1ibHwBbBTDvR90arVlxkXY=;
 b=H5itA2XnhiQteMr7U+6BRZzZvrJcowd5l3QSOXvhkMLa1vxOJIEqJdXlhR/pCNuR4XIxviO+rMsGeKX2xy9ZlmL3M9R2f4MtziaurYfH9o0Z095L/HnrZ8bgO2Jv7BdTlvt3B5LJTTO4Kh64fCP2vHstyOT5Wasj5bxiDYuOARYgCsWrx1MXXvbA4eCrgpPebF4QBdShe/ejVnb2w8heoLP+YRMGwPvrBhKLv/ngms9lCmDbTSU026u8HUgtJnmiQqwu/gPlswvLqmM+V6JsrKCsOoOL1okV4Vsmr5R5zUt1nSuzuAHa8y3YhLqfG/WKdK8XphmySdbm832CwO+EZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.29) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJK99GI76PSJQltt+MdyP1ibHwBbBTDvR90arVlxkXY=;
 b=NQZY06AJTP8dok0tiO1uBKJ4jzh6I8qH7t4goulsQCVnIxTPsshHCQ0ecVMPALquClWN0x+8Ue2ugD+nBrASZoxQX77BwlqEhbZz6apXJpCBz7Uv8x8dYDNP/8tx5grx6r5vCqvyKh6uk4qs5149j6CKsjgGw0APO1QfTg8kXpp3IGKSlC7PwgPuvcZOIuoHeBSHR9mpZ/qvuo3N13KLX3wK04dCABViFK9FHoHVXr4tfY6Gtu3OV6zFAyUQRNNFgSKfUUpU8uVFj6jRDjn1I8KPI+IxRZa2zrY0sxfAaMI7JDfo/oOiOzSkGM3iYGMVwtlMgNE85GiqLT7up8pYdg==
Received: from DU7P195CA0019.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::32)
 by PAXPR07MB8014.eurprd07.prod.outlook.com (2603:10a6:102:13c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Fri, 15 Mar
 2024 12:44:31 +0000
Received: from DU2PEPF00028D0A.eurprd03.prod.outlook.com
 (2603:10a6:10:54d:cafe::1a) by DU7P195CA0019.outlook.office365.com
 (2603:10a6:10:54d::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.22 via Frontend
 Transport; Fri, 15 Mar 2024 12:44:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.29)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.29 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.29; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.29) by
 DU2PEPF00028D0A.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Fri, 15 Mar 2024 12:44:30 +0000
Received: from ulegcparamis.emea.nsn-net.net (ulegcparamis.emea.nsn-net.net [10.151.74.146])
	by fihe3nok0735.emea.nsn-net.net (GMO) with ESMTP id 42FCiOdq013909;
	Fri, 15 Mar 2024 12:44:28 GMT
From: Muhammad Asim Zahid <muhammad.zahid@nokia.com>
To: "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Muhammad Asim Zahid <muhammad.zahid@nokia.com>
Subject: [PATCH] nfsd: Make NFS client_id increment atomic to avoid race condition
Date: Fri, 15 Mar 2024 13:39:57 +0100
Message-ID: <20240315124053.24116-1-muhammad.zahid@nokia.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0A:EE_|PAXPR07MB8014:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 408c1711-303f-49da-7a36-08dc44eda8db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MQoDjimKMID1cU2608Cowj4SuBbuKSgCeV9Jd4HOVWbcXR11ocfDyjrvdmPdfGtF2Y60amX+gnVujWVKD+R1OpBv+kdJczlVDRDdoKyRcFWRLc77Ux89h5TjAV472PHkqD3d5kU1v81vMycrVUJnTjpyWCQyGee5sO0kEPdlwRdTO8AKk/244JyCzET5EvdTiAsB0qYYjejY7JmArslxeqNDzmPhvxSG/hdZPE1OQvtv76VyjQD80W+EaCqBqtRBXd/QmlaIMyqjsDUoLZ5Q2GSf8jIqh3JyxDR840GWzv3edURlG7Om0OllV1LdhBTF5JWr4U4TNVFuBxpwq4XavVAis8AYOdvPAYwpCPxAouy4vY9n+LT2N/wKejVf0BQSsjEWxvqDRMXV7UnIWpoRZBZ9AVYCnmYCN5S9SXesG/zeXRwukMzoi8QxVO7iC7fd+h2TaJ0Ri1IcTFyAd0x/6fRTL6bphLlmgL5lFmkboF5oeD5UDnj8HrdhF2Kjy6m0jFGfbpG++JRcmQsptNufaul1Ew5k+jEzNNOHK6IfLF2SRxjsyFzJyDXvHfum0HLWfp2a0KnCAzEMPoyteGhTcAEjaDpJdJzVFWG8DmuCYx7ufLvBABHRGU3O3YSMUu5cRi8fK+rvHMksuZgBJEZrvUKKps9k7eZHtSzjmqFwe6/bJv8Haw3v4gYYbBmYKKxCVDg+Ab5gtKnJla16hKXsxfFTOUeg7jam8CxvExgkVKUw8EuDExxwXyTZ+4NVI/oV
X-Forefront-Antispam-Report:
	CIP:131.228.2.29;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 12:44:30.9099
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 408c1711-303f-49da-7a36-08dc44eda8db
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.29];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0A.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB8014

The following log messages show conflict in clientid
       [err] kernel: [   16.228090] NFS: Server fct reports our clientid is in use
       [warning] kernel: [   16.228102] NFS: state manager: lease expired failed on NFSv4 server fct with error 1
       [warning] kernel: [   16.228102] NFS: state manager: lease expired failed on NFSv4 server fct with error 1

The increment to client_verifier counter and client_id counter is
set to atomic so as to avoid race condition which causes the
aforementioned error.

Change-Id: Ic0fa8c14a8bba043ae8882f6750f512bb5f3aac1
---
 fs/nfsd/netns.h     | 4 ++--
 fs/nfsd/nfs4state.c | 4 ++--
 fs/nfsd/nfsctl.c    | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 935c1028c217..67b5aa1516e2 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -119,8 +119,8 @@ struct nfsd_net {
 	unsigned int max_connections;
 
 	u32 clientid_base;
-	u32 clientid_counter;
-	u32 clverifier_counter;
+	atomic_t clientid_counter;
+	atomic_t clverifier_counter;
 
 	struct svc_serv *nfsd_serv;
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 9b660491f393..d67a6a593f59 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2321,14 +2321,14 @@ static void gen_confirm(struct nfs4_client *clp, struct nfsd_net *nn)
 	 * __force to keep sparse happy
 	 */
 	verf[0] = (__force __be32)(u32)ktime_get_real_seconds();
-	verf[1] = (__force __be32)nn->clverifier_counter++;
+	verf[1] = (__force __be32)atomic_inc_return(&(nn->clverifier_counter));
 	memcpy(clp->cl_confirm.data, verf, sizeof(clp->cl_confirm.data));
 }
 
 static void gen_clid(struct nfs4_client *clp, struct nfsd_net *nn)
 {
 	clp->cl_clientid.cl_boot = (u32)nn->boot_time;
-	clp->cl_clientid.cl_id = nn->clientid_counter++;
+	clp->cl_clientid.cl_id = atomic_inc_return(&(nn->clientid_counter));
 	gen_confirm(clp, nn);
 }
 
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index cb73c1292562..a9ef86ee7250 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1481,10 +1481,10 @@ static __net_init int nfsd_init_net(struct net *net)
 	nn->nfsd4_grace = 90;
 	nn->somebody_reclaimed = false;
 	nn->track_reclaim_completes = false;
-	nn->clverifier_counter = prandom_u32();
+	atomic_set(&(nn->clverifier_counter), prandom_u32());
 	nn->clientid_base = prandom_u32();
-	nn->clientid_counter = nn->clientid_base + 1;
-	nn->s2s_cp_cl_id = nn->clientid_counter++;
+	atomic_set(&(nn->clientid_counter), nn->clientid_base + 1);
+	nn->s2s_cp_cl_id = atomic_inc_return(&(nn->clientid_counter));
 
 	atomic_set(&nn->ntf_refcnt, 0);
 	init_waitqueue_head(&nn->ntf_wq);
-- 
2.42.0


