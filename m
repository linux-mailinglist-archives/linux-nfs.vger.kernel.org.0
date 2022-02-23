Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58C44C19FE
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 18:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236945AbiBWRlN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 12:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236603AbiBWRlN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 12:41:13 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C592705
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 09:40:44 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id j5so9668359qvs.13
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 09:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TQIbcm4ZoUlOd3ge4cVut8C8yldSYbmLZsPI1UrysYY=;
        b=S5WgQkNKSyFWEDYJKUhHOEUfcBnP7qkgqfKhu5v0SPyVm1jy1QFiUtub6JsFkAdMGV
         pTicEiP2wseHJ6a8VXOf+lp5KZFDDZOP/L1Qvr082ntVCJf6fGDtQdftVTKsJPwKm0zm
         EX4MSOwmFolKvtFZ6BwImHOhQoOG7QX8mBGuTE1kCjtZ0FZsHb3UHQrqmE1wW1nsUolL
         XaxeWshDClBOJgDxBjyL1was2xQqEbkL0BXwym1I2FUNeAu1OFE1zcn8UshG6THqAVTR
         KDcGK1NwH2DxHS5wxCK6SwFyEXtfsrNMIbm7KV+fVReNds47rZStH6zqRk2IXm5X9ZCr
         pvUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TQIbcm4ZoUlOd3ge4cVut8C8yldSYbmLZsPI1UrysYY=;
        b=CHpJKE7w/Zbm+aQZSV8ERkNhcZ90QW7bftATt7Jw5648U9HtQmMCqdVUbnv+XCrkZB
         tKQ/i81ltknOeJEcihw3tGgKKbBZhN2mkm551cLMdC6e4xw+kehH19DAQDxdSju4JXTv
         8ouqXwEaWnI5vnkXEyFc55kO9lGOlOVUCThC3RFbWaK4r1Ac8UmKAt57RBwvQzhiiwYK
         8vhpQ1Vc97+bwUp/Dt2tBZNU3KO8/ch81li1gu/1nf50hygHVk6wWtpQt8zVqowyynAD
         gYMuk3EsK9pM+S3V0T86Nqf7lrRJQKxNHYTzGClnr/nBMWXwI3Hm0YqeeTsF2shcjnlb
         up/Q==
X-Gm-Message-State: AOAM531UJgt9uDe636rswTZn8W84ExITAKqmeDywA/XQCu70D6QL2+rS
        YMiOxKdxKcMSIFDdLU3duFjGJd0P2wM=
X-Google-Smtp-Source: ABdhPJzqSaQV8y2UnMKhLFdchG42iUMPff0TsEeX8fTsoW6xtiDl240iAOvoHK5n9GblvS3vXv9m4Q==
X-Received: by 2002:a05:622a:24b:b0:2de:2bf3:5784 with SMTP id c11-20020a05622a024b00b002de2bf35784mr804625qtx.664.1645638044048;
        Wed, 23 Feb 2022 09:40:44 -0800 (PST)
Received: from kolga-mac-1.vpn.netapp.com ([2600:1700:6a10:2e90:3578:bf34:c039:8827])
        by smtp.gmail.com with ESMTPSA id i205sm106215qke.55.2022.02.23.09.40.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Feb 2022 09:40:43 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v1] NFSv4.1 provide mount option to toggle trunking discovery
Date:   Wed, 23 Feb 2022 12:40:41 -0500
Message-Id: <20220223174041.77887-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Introduce a new mount option -- trunkdiscovery,notrunkdiscovery -- to
toggle whether or not the client will engage in actively discovery
of trunking locations.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/client.c           | 3 ++-
 fs/nfs/fs_context.c       | 8 ++++++++
 include/linux/nfs_fs_sb.h | 1 +
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index d1f34229e11a..84c080ddfd01 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -857,7 +857,8 @@ static int nfs_probe_fsinfo(struct nfs_server *server, struct nfs_fh *mntfh, str
 	}
 
 	if (clp->rpc_ops->discover_trunking != NULL &&
-			(server->caps & NFS_CAP_FS_LOCATIONS)) {
+			(server->caps & NFS_CAP_FS_LOCATIONS &&
+			 !(server->flags & NFS_MOUNT_NOTRUNK_DISCOVERY))) {
 		error = clp->rpc_ops->discover_trunking(server, mntfh);
 		if (error < 0)
 			return error;
diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index ea17fa1f31ec..ad1448a63aa0 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -80,6 +80,7 @@ enum nfs_param {
 	Opt_source,
 	Opt_tcp,
 	Opt_timeo,
+	Opt_trunkdiscovery,
 	Opt_udp,
 	Opt_v,
 	Opt_vers,
@@ -180,6 +181,7 @@ static const struct fs_parameter_spec nfs_fs_parameters[] = {
 	fsparam_string("source",	Opt_source),
 	fsparam_flag  ("tcp",		Opt_tcp),
 	fsparam_u32   ("timeo",		Opt_timeo),
+	fsparam_flag_no("trunkdiscovery", Opt_trunkdiscovery),
 	fsparam_flag  ("udp",		Opt_udp),
 	fsparam_flag  ("v2",		Opt_v),
 	fsparam_flag  ("v3",		Opt_v),
@@ -529,6 +531,12 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 		else
 			ctx->flags &= ~NFS_MOUNT_NOCTO;
 		break;
+	case Opt_trunkdiscovery:
+		if (result.negated)
+			ctx->flags |= NFS_MOUNT_NOTRUNK_DISCOVERY;
+		else
+			ctx->flags &= ~NFS_MOUNT_NOTRUNK_DISCOVERY;
+		break;
 	case Opt_ac:
 		if (result.negated)
 			ctx->flags |= NFS_MOUNT_NOAC;
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index ca0959e51e81..d0920d7f5f9e 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -151,6 +151,7 @@ struct nfs_server {
 #define NFS_MOUNT_SOFTREVAL		0x800000
 #define NFS_MOUNT_WRITE_EAGER		0x01000000
 #define NFS_MOUNT_WRITE_WAIT		0x02000000
+#define NFS_MOUNT_NOTRUNK_DISCOVERY	0x04000000
 
 	unsigned int		fattr_valid;	/* Valid attributes */
 	unsigned int		caps;		/* server capabilities */
-- 
2.27.0

