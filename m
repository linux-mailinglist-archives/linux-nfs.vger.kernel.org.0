Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C85638AE6
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Nov 2022 14:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiKYNIW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Nov 2022 08:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiKYNIV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Nov 2022 08:08:21 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9142C63E0
        for <linux-nfs@vger.kernel.org>; Fri, 25 Nov 2022 05:08:20 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id v8so6338694edi.3
        for <linux-nfs@vger.kernel.org>; Fri, 25 Nov 2022 05:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Au2Jln13q6UAwXwfIAB1ZDUVfQ/b9kFSlTxuCZ/p3Sk=;
        b=lTRzkHDU/MwwtzsQihvxsqHY3MFYwGiVyJjJWqEgXrhJ75QgJr+MuJEerzqwPr0HYE
         rCfcudCkDdXP+OMXqVfc7jsVI49KMoHvWDA+Ljs/8Yo/q5FMUYyaMrjvKeBwziSykZtk
         H1FMVkBDl7QoWtxsapSmpaum+AXyzY9noNKHxB0FPTqUt5dybTO3NcMezWHY1HPOCmnG
         tdXsQQ8g7elbSai/MaykUI6nDkcJ6tvA7exFTEHQeXu6VvrisUnYOlqKZc/etSpFLLQB
         yYKJ2/qrd0fAPaD4xZnHj9yKm+Ha8ax0PO5coDtLW+ZdM1ANjWnlGs3U1uG3QmK273Ws
         +JNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Au2Jln13q6UAwXwfIAB1ZDUVfQ/b9kFSlTxuCZ/p3Sk=;
        b=PzPWL6TJ2b8qqnLUYXVJmsVEwLopwhlc7C70t54HOempC5VSs1mAyLdN1Zer0c/vPB
         r/wJHg8waozRJnxEl2GYWIhgB+H1V9OlMbE8BAz6g3p43saASd5ZE61pKyTmBVCo1n7U
         aU5xQvnHLRP8/ewsI4Uq5EsorlGPhiNxSW/yP2glw6NZ0R0Lcz1R1ZejaeftKC1Mz606
         nexEBX/MT5QL9bdJTM5PfzY0l8RM7DXilVfyuMM4oWnzHbCGitiuv4LlnFcUkExo7mS7
         X0WyPKWZ8wBv2a6UbH621C1OSk8mGE/0e9wnamlOajpcW5mEOAkN/nIrzkqLfTOC+n0H
         mlFA==
X-Gm-Message-State: ANoB5pnm0w99MSSxoLsGnaCjSkfI/TRVTwjTyjAdX8I3ghpv3sOLnWz9
        X9l6Jd/QEDTUjjxH7cmRWGA=
X-Google-Smtp-Source: AA0mqf5qjtJDZK4gKEWcaaY7vr92uKbEg4wS1hGFjuamPY2nMk5Zn0B+TxPLwe2oo2AvrCwzPIaK9Q==
X-Received: by 2002:a05:6402:2b8b:b0:468:cae8:f5a6 with SMTP id fj11-20020a0564022b8b00b00468cae8f5a6mr35733980edb.263.1669381695649;
        Fri, 25 Nov 2022 05:08:15 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id nb12-20020a1709071c8c00b0078df3b4464fsm1587671ejc.19.2022.11.25.05.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 05:08:14 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id 24CC8BE2DE0; Fri, 25 Nov 2022 14:08:14 +0100 (CET)
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     NeilBrown <neilb@suse.de>, Steve Dickson <steved@redhat.com>,
        linux-nfs@vger.kernel.org
Cc:     Andras Korn <korn-debbugs@elan.rulez.org>,
        Marco d'Itri <md@linux.it>, Michael Prokop <mika@debian.org>,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH 4/4] systemd: Apply all sysctl settings through udev rule  when NFS-related modules are loaded
Date:   Fri, 25 Nov 2022 14:07:25 +0100
Message-Id: <20221125130725.1977606-5-carnil@debian.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221125130725.1977606-1-carnil@debian.org>
References: <20221125130725.1977606-1-carnil@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

sysctl settings (e.g.  /etc/sysctl.conf and others) are normally loaded
once at boot.  If the module that implements some settings is no yet
loaded, those settings don't get applied.

Various NFS modules support various sysctl settings.  If they are loaded
after boot, they miss out.

Add a new udev rule configuration to udev/rules.d/60-nfs.rules to apply
the relevant settings when the module is loaded.

Placing it in the systemd directory similarly as the coice for the
original commit afc7132dfb21 ("systemd: Apply all sysctl settings when
NFS-related modules are loaded").

Link: https://lore.kernel.org/linux-nfs/Y1KoKwu88PulcokW@eldamar.lan/
Link: https://bugs.debian.org/1022172
Link: https://bugs.debian.org/1024082
Suggested-by: Marco d'Itri <md@linux.it>
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 systemd/60-nfs.rules | 21 +++++++++++++++++++++
 systemd/Makefile.am  |  9 +++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)
 create mode 100644 systemd/60-nfs.rules

diff --git a/systemd/60-nfs.rules b/systemd/60-nfs.rules
new file mode 100644
index 000000000000..188423c1d2e3
--- /dev/null
+++ b/systemd/60-nfs.rules
@@ -0,0 +1,21 @@
+# Ensure all NFS systctl settings get applied when modules load
+
+# sunrpc module supports "sunrpc.*" sysctls
+ACTION=="add", SUBSYSTEM=="module", KERNEL=="sunrpc", \
+  RUN+="/sbin/sysctl -q --pattern ^sunrpc --system"
+
+# rpcrdma module supports sunrpc.svc_rdma.*
+ACTION=="add", SUBSYSTEM=="module", KERNEL=="rpcrdma", \
+  RUN+="/sbin/sysctl -q --pattern ^sunrpc.svc_rdma --system"
+
+# lockd module supports "fs.nfs.nlm*" and "fs.nfs.nsm*" sysctls
+ACTION=="add", SUBSYSTEM=="module", KERNEL=="lockd", \
+  RUN+="/sbin/sysctl -q --pattern ^fs.nfs.n[sl]m --system"
+
+# nfsv4 module supports "fs.nfs.*" sysctls (nfs_callback_tcpport and idmap_cache_timeout)
+ACTION=="add", SUBSYSTEM=="module", KERNEL=="nfsv4", \
+  RUN+="/sbin/sysctl -q --pattern ^fs.nfs.(nfs_callback_tcpport|idmap_cache_timeout) --system"
+
+# nfs module supports "fs.nfs.*" sysctls
+ACTION=="add", SUBSYSTEM=="module", KERNEL=="nfs", \
+  RUN+="/sbin/sysctl -q --pattern ^fs.nfs --system"
diff --git a/systemd/Makefile.am b/systemd/Makefile.am
index e7f5d818a913..577c6a2286c0 100644
--- a/systemd/Makefile.am
+++ b/systemd/Makefile.am
@@ -2,6 +2,9 @@
 
 MAINTAINERCLEANFILES = Makefile.in
 
+udev_rulesdir = /usr/lib/udev/rules.d/
+udev_files = 60-nfs.rules
+
 unit_files =  \
     nfs-client.target \
     rpc_pipefs.target \
@@ -51,7 +54,7 @@ endif
 
 man5_MANS	= nfs.conf.man
 man7_MANS	= nfs.systemd.man
-EXTRA_DIST = $(unit_files) $(man5_MANS) $(man7_MANS)
+EXTRA_DIST = $(unit_files) $(udev_files) $(man5_MANS) $(man7_MANS)
 
 generator_dir = $(unitdir)/../system-generators
 
@@ -73,8 +76,10 @@ rpc_pipefs_generator_LDADD = ../support/nfs/libnfs.la
 
 if INSTALL_SYSTEMD
 genexec_PROGRAMS = nfs-server-generator rpc-pipefs-generator
-install-data-hook: $(unit_files)
+install-data-hook: $(unit_files) $(udev_files)
 	mkdir -p $(DESTDIR)/$(unitdir)
 	cp $(unit_files) $(DESTDIR)/$(unitdir)
 	cp $(rpc_pipefs_mount_file) $(DESTDIR)/$(unitdir)/$(rpc_pipefsmount)
+	mkdir -p $(DESTDIR)/$(udev_rulesdir)
+	cp $(udev_files) $(DESTDIR)/$(udev_rulesdir)
 endif
-- 
2.38.1

