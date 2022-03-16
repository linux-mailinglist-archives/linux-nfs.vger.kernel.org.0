Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AA84DBAA6
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Mar 2022 23:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiCPWZ5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Mar 2022 18:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbiCPWZy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Mar 2022 18:25:54 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D93619C31
        for <linux-nfs@vger.kernel.org>; Wed, 16 Mar 2022 15:24:39 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d15so1936642qty.8
        for <linux-nfs@vger.kernel.org>; Wed, 16 Mar 2022 15:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5MiaYocJwA97nEVN8bYG9Hxb5SJ1BYXCuLlQCYg9SvQ=;
        b=aXVgy9dCmntrNBTGU1EYSArAIBP5y8ySRIjiNtHlf8arqmxRHe2ZG29P8YXihCLOv6
         EwolensKub0ofmeguPfVOxOKdcXK4gYiw/Mds2yY+9VakhMjiGoHEfy1j/zg7FDhVA1t
         gj5SD0u74CAh4H5X9f8C+JVC5LcF9/MBA7WyKi0XKgsIUkcRE8YmufyopFO5UjU6Yeiu
         7+llcstSqnd3e9jf1Bjt/4STHYkXn3uoZddFvtGI20poKS9Ku/vitoec3mjJTOEfc+U9
         JGkSvrZSis6DHXgu27ENFY2uCiQaGbW5yDYS8QLKC7xUjaOEX0UzsIGDkGK2Zoos5Ccy
         fdhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5MiaYocJwA97nEVN8bYG9Hxb5SJ1BYXCuLlQCYg9SvQ=;
        b=yQzdH4G8gTxqCQdKoy1lYZTdmqvJxFSjIwWKSt0H3sqjPia1tZBFRL6PIWX9kPX0pX
         Cax8j9tSkDazUxHDIg5Me6BF0hd8nt5TOPLF5fbSE/WxpfhntG4DOAPWK4oXrP8ozJ9K
         YnBbB45U2MJOof+i+t5cdtrn5drB6yIrhci4bTwYaOULNJkK+dtO7Zr+UPHFVh29R3kt
         ozHuQsFPRcHD8Q5wpnXhc2Jl3wl39miooYJorMevwhD5fpEalPWevgQf07n/QE5DyVgv
         eHWcI0WrHR83JP67WOv8UgLUs4H9trD+P2L3HcpCwn6JxrGfo82dGkjfpEXi8bm/OhPj
         QfDg==
X-Gm-Message-State: AOAM532fPpTB52SN8mtEeNz0CHwipiNDMTvmGiZjws27oj3rLKbT/6Dm
        tO4irskc3uqKaF63wyYPDWha47B45Rk=
X-Google-Smtp-Source: ABdhPJy1IkOoiq20ntu2NboY+fTXjhLY2/Erwdu0Q1sfcHBkqlMUfgws5qdZ4F4rEy/h3h74wGQOhg==
X-Received: by 2002:ac8:5b15:0:b0:2e1:d84f:1151 with SMTP id m21-20020ac85b15000000b002e1d84f1151mr1626354qtw.364.1647469478648;
        Wed, 16 Mar 2022 15:24:38 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com ([2600:1700:6a10:2e90:b016:68b1:1ae9:1653])
        by smtp.gmail.com with ESMTPSA id f83-20020a379c56000000b0067b2dd2c860sm1466730qke.54.2022.03.16.15.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 15:24:38 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/1] NFSv4.1 provide mount option to toggle trunking discovery
Date:   Wed, 16 Mar 2022 18:24:26 -0400
Message-Id: <20220316222426.82485-1-olga.kornievskaia@gmail.com>
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

v2 make notrunkdiscovery default

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/client.c           | 3 ++-
 fs/nfs/fs_context.c       | 8 ++++++++
 include/linux/nfs_fs_sb.h | 1 +
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index d1f34229e11a..e828504cc396 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -857,7 +857,8 @@ static int nfs_probe_fsinfo(struct nfs_server *server, struct nfs_fh *mntfh, str
 	}
 
 	if (clp->rpc_ops->discover_trunking != NULL &&
-			(server->caps & NFS_CAP_FS_LOCATIONS)) {
+			(server->caps & NFS_CAP_FS_LOCATIONS &&
+			 (server->flags & NFS_MOUNT_TRUNK_DISCOVERY))) {
 		error = clp->rpc_ops->discover_trunking(server, mntfh);
 		if (error < 0)
 			return error;
diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index ea17fa1f31ec..e2d59bb5e6bb 100644
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
+			ctx->flags &= ~NFS_MOUNT_TRUNK_DISCOVERY;
+		else
+			ctx->flags |= NFS_MOUNT_TRUNK_DISCOVERY;
+		break;
 	case Opt_ac:
 		if (result.negated)
 			ctx->flags |= NFS_MOUNT_NOAC;
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index ca0959e51e81..b0e3fd550122 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -151,6 +151,7 @@ struct nfs_server {
 #define NFS_MOUNT_SOFTREVAL		0x800000
 #define NFS_MOUNT_WRITE_EAGER		0x01000000
 #define NFS_MOUNT_WRITE_WAIT		0x02000000
+#define NFS_MOUNT_TRUNK_DISCOVERY	0x04000000
 
 	unsigned int		fattr_valid;	/* Valid attributes */
 	unsigned int		caps;		/* server capabilities */
-- 
2.27.0

