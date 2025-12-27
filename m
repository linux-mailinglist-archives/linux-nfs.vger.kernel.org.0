Return-Path: <linux-nfs+bounces-17329-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDC2CE0003
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Dec 2025 18:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57D923010E49
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Dec 2025 17:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACA721A459;
	Sat, 27 Dec 2025 17:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Ly0+gLBH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020092.outbound.protection.outlook.com [52.101.193.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0E724A076
	for <linux-nfs@vger.kernel.org>; Sat, 27 Dec 2025 17:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766855113; cv=fail; b=urwNj7kp8ZzDEMWkDuhwyUHs/HqghkZZgm84HulikmyOSMS4iV9sYWdGPBwvDnAapeB/ymuhuGpVyWiV5I/SwB0ipBjkg4UsEO1inolerpU1rOLkK6/a9StE4NSRsqQLuT+gef2Z+KHiLTAuaMK4N+dd/8C8fMqSEYGkaiTqJU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766855113; c=relaxed/simple;
	bh=60Wl3qJowBy3ec1YMlqF+Ej/Bo8G5ENBLUVLlArI7rA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PZ0jCPaOxMdQORq75cIz8oYgUY6Djik4K1lJ1wNIkIHX2UrfYb18tM2M0KiQlfxCzjmdxzW+XLdUfeec8YA60dA0VVqhyfGcc/K0dIQu4xquAZe7l8uaB4dVJWCKcWTK78PhEsxSHeIK3UG1I4y8RHNZEvyyHPu1qy+/aCi+5o8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Ly0+gLBH; arc=fail smtp.client-ip=52.101.193.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zD67p3vxIFiYZjiBa6Gy3uz6rs4QQliXsc1GSJU6LcDOgVG6TSLEYuHMLPc8UhxTnrc9qYkTF2iiQmqh1LxzQL1fxbItPo0x244tOhSMZiNTJwJ1GIJfYZ9djm2zkwlMVW2yEgTjoNMS4uS0cqdCKlWu0DEjDrNL9kMX9Hy6ZrLAd/PbOTObijPtt72ZYNNzGWcj4gyWOGXfs/UglETy952xIvBenbjI1okcwSh6FU8t7tqmiXB5+bavHLyqUKXCH7WbAXjIm3s1YU9zZ1bAk2GPMwcunKWtF2aIgTUk6yN63wBckIO2epN2C8UrYgbZtcT5FsCtgMhlRYzo8vh6xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12gr0WwVJKRRxfHYzDTfEtTT/UQVk4dq8B6oZqpljSQ=;
 b=VTv6wYMqzG/co/Qn5U7Thgiqs3ii/LgoQkPUsdIJqhVRxnr+Smj1YQ/LmtXzcxXe7Wrm1yC+HH4B99lhsVyr5VrNt1wnykf86FEhY/5EjEIIPpfY2CUdFRSfKjVtkFLiG/nAu3VP4UN8Zsqc3pZp+90KxUPf3e9T6+to1Ley6GAyoeBUklaMIpbNzlxG5zIApszRSBYRvEF8hZzg48aHoKMMs58jlCjUhlvJgMOyS9yjETcEnquGuFuHHvlh4s/xo0nrEhqALiwj6VKMaAyfLvM2+mBoB5FKyrnnuLVEYfiTTMTG2qjd74MEoKKcIHPk7Mola9I1PbUvLhjNGQCY3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12gr0WwVJKRRxfHYzDTfEtTT/UQVk4dq8B6oZqpljSQ=;
 b=Ly0+gLBHKV28OHvER3Y0sKq2yCKnpURVkeHbYXolOdyyZPg++/Ov/iIYyxBZhR5vpnNfSoupwTASQ7+Gvf+S8CoqaV2Xm6kx8z8WNn1yhgI1TEuyOtJUR2gmPbJnKBYfjlCNRf9e89lT7rM9CJGrVxlCzSz+vYkRpmlIznQYowA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SA1PR13MB6648.namprd13.prod.outlook.com (2603:10b6:806:3e7::10)
 by SA0PR13MB4061.namprd13.prod.outlook.com (2603:10b6:806:99::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Sat, 27 Dec
 2025 17:05:05 +0000
Received: from SA1PR13MB6648.namprd13.prod.outlook.com
 ([fe80::c48a:c42a:aa18:2ef4]) by SA1PR13MB6648.namprd13.prod.outlook.com
 ([fe80::c48a:c42a:aa18:2ef4%3]) with mapi id 15.20.9456.013; Sat, 27 Dec 2025
 17:05:05 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Benjamin Coddington <bcodding@hammerspace.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v1 7/7] NFSD: Enable filehandle encryption
Date: Sat, 27 Dec 2025 12:04:55 -0500
Message-ID: <9c444871bf7bbce9d5ba3ac628d3f0d0a359b21b.1766848778.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1766848778.git.bcodding@hammerspace.com>
References: <cover.1766848778.git.bcodding@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P221CA0058.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::7) To SA1PR13MB6648.namprd13.prod.outlook.com
 (2603:10b6:806:3e7::10)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR13MB6648:EE_|SA0PR13MB4061:EE_
X-MS-Office365-Filtering-Correlation-Id: 13d19974-51b0-4228-ed48-08de456a1523
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AvpcoFgOlGKDlqjfUAZh5ekuH44++6K6KCfhoBUfdUDb6VmPq0TpIru6F+3I?=
 =?us-ascii?Q?zLSvGbtySg7dcsFsSTKLXwWn1y+3QehaVr9NfYxcBYtiO17Fppx/J1Zv2J34?=
 =?us-ascii?Q?m+4gurjO8I42azzL6N3HfqYtBPE7YWvhYtStaoycTfeiVvFnFF6FAts4LPPF?=
 =?us-ascii?Q?pha/IYNIE8g3MtEKTf0mUXhsGuNapVS+HeI8i7p5aCzcLM04ddIriOJ9P8Fm?=
 =?us-ascii?Q?RQI6E74vm+gW38cT1yX7LMVbKA2/LF+wyx6geXv2coAo/70O22GmL45XV6fc?=
 =?us-ascii?Q?pOkoIp4EYP4k4mCmVkM2+dmrGlnzhfzexrgX52pi06XKG4Jd5Ka0tWbxBjfk?=
 =?us-ascii?Q?yE8vg9nZ2uZBj75JyiHYxM+IJU84Nl7emj+Mly+5v4oYRPRiMO8hSOzVyUzA?=
 =?us-ascii?Q?EtSVo01yiuTLFFkznDRQ1Lb/xYxNJDrOWFaJwcAAGhM7ezhKsTvKN1Lv8FCB?=
 =?us-ascii?Q?DgPiAm/oVVvJ7elCx48cKO1zt4+LdIg/n2DjzvsTF8UiVyV3oU7GGobil3Ew?=
 =?us-ascii?Q?F5gD6fKCFlK3cSX6/QjGPerxvxJTpfEu2pv6NlraftRXjsPggZ/e9Qar11LU?=
 =?us-ascii?Q?7WY8Q612/Fq088UhBbn50/D9hy97O/VRSFvVvM880gcNtIpODAXQa6+NROyE?=
 =?us-ascii?Q?7GUERx0Ehqda76XV5fHMEXDoQrONMV9g5dwdOoccZl7/oyxm+Tx/YnxvR1qc?=
 =?us-ascii?Q?2w++vH387jsa38WCE3to3r7TguHysJXeFC+6jTk7r4hieP/4XMSy2Pngpt6X?=
 =?us-ascii?Q?G/KWUkkfu+w2thUf89owSTfXq4Vo9X600TDiK1Gm7BbYbHK9qEEDf16tAGSk?=
 =?us-ascii?Q?8hHRI+fQu4iutlJHb8GF/z3vtLs1GhR71H6Ht4qyjT/JRxRihzVpmRihX3b7?=
 =?us-ascii?Q?u3w+32uM0QrlVBDiPNPbV9r+Q71l5YoAwLphfdN8BzuOLWfzQe391S6tPFhH?=
 =?us-ascii?Q?AR6PhKflSrZ7v0f6+AuxFcjVFPtDhe8TA8nMbAcuOUCL6icpBkwMRypdsn0R?=
 =?us-ascii?Q?94jlU2FcxQFkSpkxCA1d9KW4CtohaOJBDwi8rLlfc4fN8Kp4mJqWh7tm0Mw5?=
 =?us-ascii?Q?9NuORlwXN4D3WEFx0T6CJyCeld0SWUc+sUxsi2tWq0CB2BCAQwqw+SX4D/8K?=
 =?us-ascii?Q?sVHx2pqy2N6CY3V3617VaOl229JKc7bc1wE8ML08n7p8NYH9AzBjtFA5XTEk?=
 =?us-ascii?Q?QK1G2nDxLbMcgHrwtEVuwhVzeUB4uerjV6Yul95pWbghd+pdOxlGzgMlb+t6?=
 =?us-ascii?Q?i28ItrUYF667CiUBHXSFEqQfF6HD9aqUUgcSQ3zJqAcM7+xICaaxXGC3haT9?=
 =?us-ascii?Q?URMkdmSR7vUKcH5TiuAoirvAYoYIpF+cwRjt+mqIZuwQTYWPwMpXoAvhVzwD?=
 =?us-ascii?Q?ZyYrZPO80lOH3KNdfebO2FUzsHMcxpDtbxM6cIdyAxxeWFC339UrgqtFK1sO?=
 =?us-ascii?Q?CAZF/jOqG8ht/iPPwUpkwOyQ3tQvEXLZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR13MB6648.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nn/mTPWYy+vmsLgdYi3GfNkMscYkFstsCzvlHKMYyHmAN+hgFYKEU2i5zN1I?=
 =?us-ascii?Q?c71ddM/i5PN29uaPtA4JK9LPGVyO/E7hgdYBVTiNW/g5EmlpX6b/Aij0ZtOo?=
 =?us-ascii?Q?l9ZIyQDPp/H4iuN4SDJTYJjPkvzjncJQRqUEa3XVqFBel5q77/Oh1xXijvJV?=
 =?us-ascii?Q?iTXDJGelfEmD2yXsAiB8KiK5qN6qktODvUxz6o0kPfa7FQFV7+VXlONhfRou?=
 =?us-ascii?Q?jyVb0G7FFnJrTLmQ2FAWSZIOfi797ZjltW0IkfxmSu1Ctq7HmTf+UvdQR/L1?=
 =?us-ascii?Q?F3T4x3EprwcW0FqMmZtLNvlAHQKMuznOPDtTM+nTWYhPsTqfv4VFM+bpBI0u?=
 =?us-ascii?Q?pLzuwEbW4tRz5v3miX4CMgmhEq8lNBJNhDq/TTab5EjTSFE1XJVKpYLMMNJ9?=
 =?us-ascii?Q?FkACCW1cu1AdmN6UhTf02LI6rtaffSKKcMCRIG/DXqR6owdHVx5V7ZWyCu7M?=
 =?us-ascii?Q?Fll2D9PKOM/E5s5x7w61zXaxuAnz6fRDKToLzE9sdz/sa0bcrOP2k9iDd5xl?=
 =?us-ascii?Q?KLNVwX5r6OrXgIgnCqSPZvPPd39ASS/2czoV9aYxm9isHazaqoulV5p8ATg/?=
 =?us-ascii?Q?m/Qw3SiOWQHhoQOeerhT3tvCxyztnrv1naoyB/TCBueSPG1rVOwjCFLO1y7F?=
 =?us-ascii?Q?qAWDVmrr7+2redXG+4krBH0DfJokyBBr30CkiEBVUt0p3N7srh/jxiou/Sfp?=
 =?us-ascii?Q?GOYC0syQmIFhHUeHc1/qvFykamiKctjBrngd9d+sYy8Ok7K4uJdy8W3YGf5u?=
 =?us-ascii?Q?K6FQVoyosB+DyOPO5rxAolxW8IHeMkdnPYoMTvJDpjMlrpIxPLD7zPc757hW?=
 =?us-ascii?Q?0kBsTcRjPoHwxgW1FXN47J/Szjc3gkj89kQOaOOnqfkoks+b25vm1bvvtedr?=
 =?us-ascii?Q?3cuXqC1YObpEwbdX4mbRCSrza4y7EHWLzBE5O7zoZ7HzjudTHZWpmacIWdrT?=
 =?us-ascii?Q?Y5gqobaD6pLjCx+k2O/3mJSgzyIzHfmZ83dRpNfRnMhkGJGZzksOsSg/CCmG?=
 =?us-ascii?Q?SLgFoC6s9/fNIP3SJ59O0Ii0clOFDgJZm2QWQsDTTLTNKsBJ5hMFfqT0HV8G?=
 =?us-ascii?Q?TjofzDm/m+hDenlwU6aXyQ0qTwer62FGvWW1sGfWBcAwwQASIKCZ7CUfqjpB?=
 =?us-ascii?Q?6DAmv072Q1tJyxelStGJMojVvRZjdB9pQFjDVdDZjifKhxVTeERYJCFudACd?=
 =?us-ascii?Q?MVJwdrAEk5hd4j9HVaSOxj0Km/ekBM4CqkbNXOv+vVIdYjSd1ggzxxb8OAYT?=
 =?us-ascii?Q?Y269VURnqvL/QFSH7PSkV47iLYIyTy4DJ/GW9Q/L0nnct6dDrc4IVHAJblTz?=
 =?us-ascii?Q?MVolbTtp1qT8A/VMb+fyCRwf9sPrWGTAwY2WNg27yHgp1dugON9ovlXhpqIi?=
 =?us-ascii?Q?NDVn9jQDiTiAT2Q2y+dGJl31e42xyGN8F/E9MtDh/e5gy0zqmvDm4rx+Vpco?=
 =?us-ascii?Q?MbCP/Q2uw/+WmeIGKrfjxqyffb9L/KIH1nz9Zz/se43AXmnf1iZ2uGpZ6aUH?=
 =?us-ascii?Q?Dt4J1yC/OwnHlVaI+DZYXfoCXcdzyUyYqS2Y7Lk7H3IxveiZMu9eIQCNQiT0?=
 =?us-ascii?Q?LAqcqWnOaBWuG3bRmr3xqAK0hgcAsQEqyHp8Lj2vL7qFLpwp6f6zLfwzTeHv?=
 =?us-ascii?Q?/xoYpGt2RSlZEHHrl1oe+CyLeKH/5e00hPy587F5v9q/Ke/WdcCpD/4Z3V09?=
 =?us-ascii?Q?5s0G4tkBPIfhpvOpOiRrTh31+AIB/wFdaK0+g3wKN8jfHwOj3QmI1vNur81H?=
 =?us-ascii?Q?qXdZUiNXIsbkcyQCu4l9czo3vYethTw=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d19974-51b0-4228-ed48-08de456a1523
X-MS-Exchange-CrossTenant-AuthSource: SA1PR13MB6648.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2025 17:05:05.7946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: drdEOodHgp+mN4kLpuF0PNTWiZtuEyIxeI5biNBPd/xHA8Ua/FS3H/9FPgwwnlHT6u1PZVJsFNZiWbgW27vXLozyfTSmQOb4PcYUG47dFEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR13MB4061

Add calls to fh_encrypt() and fh_decrypt() to allow the server to encrypt
and decrypt filehandles.  The fh_encrypt() calls are from the xdr encoders
instead of within fh_compose() because callers of fh_compose() may later
call fh_update() after file creation.  Doing encryption during fh_compose()
would scramble the raw filehandle information fh_update() requires.

NFSD can call fh_decrypt() from a single location - when it needs to
resolve a dentry from the filehandle: nfsd_set_fh_dentry().

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
---
 fs/nfsd/nfs3xdr.c | 10 +++++++---
 fs/nfsd/nfs4xdr.c | 12 ++++++++----
 fs/nfsd/nfsfh.c   | 14 ++++++++++++--
 fs/nfsd/nfsfh.h   |  1 +
 4 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 854ee536e338..b2d3c0e95e86 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -120,11 +120,15 @@ svcxdr_encode_nfsstat3(struct xdr_stream *xdr, __be32 status)
 }
 
 static bool
-svcxdr_encode_nfs_fh3(struct xdr_stream *xdr, const struct svc_fh *fhp)
+svcxdr_encode_nfs_fh3(struct xdr_stream *xdr, struct svc_fh *fhp)
 {
-	u32 size = fhp->fh_handle.fh_size;
+	u32 size;
 	__be32 *p;
 
+	if (fh_encrypt(fhp))
+		return false;
+	size = fhp->fh_handle.fh_size;
+
 	p = xdr_reserve_space(xdr, XDR_UNIT + size);
 	if (!p)
 		return false;
@@ -137,7 +141,7 @@ svcxdr_encode_nfs_fh3(struct xdr_stream *xdr, const struct svc_fh *fhp)
 }
 
 static bool
-svcxdr_encode_post_op_fh3(struct xdr_stream *xdr, const struct svc_fh *fhp)
+svcxdr_encode_post_op_fh3(struct xdr_stream *xdr, struct svc_fh *fhp)
 {
 	if (xdr_stream_encode_item_present(xdr) < 0)
 		return false;
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index a45ab840ecd4..7af8cbaf401b 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2563,9 +2563,13 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
 }
 
 static __be32 nfsd4_encode_nfs_fh4(struct xdr_stream *xdr,
-				   struct knfsd_fh *fh_handle)
+					struct svc_fh *fhp)
 {
-	return nfsd4_encode_opaque(xdr, fh_handle->fh_raw, fh_handle->fh_size);
+	if (fh_encrypt(fhp))
+		return nfserr_resource;
+
+	return nfsd4_encode_opaque(xdr, fhp->fh_handle.fh_raw,
+		fhp->fh_handle.fh_size);
 }
 
 /* This is a frequently-encoded type; open-coded for speed */
@@ -3134,7 +3138,7 @@ static __be32 nfsd4_encode_fattr4_acl(struct xdr_stream *xdr,
 static __be32 nfsd4_encode_fattr4_filehandle(struct xdr_stream *xdr,
 					     const struct nfsd4_fattr_args *args)
 {
-	return nfsd4_encode_nfs_fh4(xdr, &args->fhp->fh_handle);
+	return nfsd4_encode_nfs_fh4(xdr, args->fhp);
 }
 
 static __be32 nfsd4_encode_fattr4_fileid(struct xdr_stream *xdr,
@@ -4119,7 +4123,7 @@ nfsd4_encode_getfh(struct nfsd4_compoundres *resp, __be32 nfserr,
 	struct svc_fh *fhp = u->getfh;
 
 	/* object */
-	return nfsd4_encode_nfs_fh4(xdr, &fhp->fh_handle);
+	return nfsd4_encode_nfs_fh4(xdr, fhp);
 }
 
 static __be32
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 86bdced0f905..c0657b378434 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -319,7 +319,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
 	struct dentry *dentry;
 	int fileid_type;
 	int data_left = fh->fh_size/4;
-	int len;
+	int len, ret;
 	__be32 error;
 
 	error = nfserr_badhandle;
@@ -331,8 +331,18 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
 
 	if (--data_left < 0)
 		return error;
-	if (fh->fh_auth_type != 0)
+
+	/* either FH_AT_PLAIN or FH_AT_ENCRYPTED: */
+	if (fh->fh_auth_type > 1)
+		return error;
+
+	ret = fh_decrypt(fhp);
+	if (ret) {
+		/* probably should modify this tracepoint */
+		trace_nfsd_set_fh_dentry_badhandle(rqstp, fhp, ret);;
 		return error;
+	}
+
 	len = key_len(fh->fh_fsid_type) / 4;
 	if (len == 0)
 		return error;
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 786f34e72304..e94bf96c3340 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -238,6 +238,7 @@ __be32	fh_getattr(const struct svc_fh *fhp, struct kstat *stat);
 __be32	fh_compose(struct svc_fh *, struct svc_export *, struct dentry *, struct svc_fh *);
 __be32	fh_update(struct svc_fh *);
 void	fh_put(struct svc_fh *);
+int	fh_encrypt(struct svc_fh *);
 
 static __inline__ struct svc_fh *
 fh_copy(struct svc_fh *dst, const struct svc_fh *src)
-- 
2.50.1


