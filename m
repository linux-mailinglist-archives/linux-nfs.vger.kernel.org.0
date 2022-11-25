Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BADD638AE4
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Nov 2022 14:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiKYNIS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Nov 2022 08:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiKYNIR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Nov 2022 08:08:17 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811A22D1
        for <linux-nfs@vger.kernel.org>; Fri, 25 Nov 2022 05:08:15 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id fy37so10185161ejc.11
        for <linux-nfs@vger.kernel.org>; Fri, 25 Nov 2022 05:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4UPRNgYkTTgkIOvGTjmVSedLlvmZSyOq0T81C3zGQQ=;
        b=li3RvOfMk4XyI7OF5bateRXK0Ev0fSi7unzVhCnXohZM/noQ9TmvmLPT6JRwyzL6oo
         Q6iUMIzM9fjUCPCOGF3kP/CncpP1WViMl5Cfpgn2mPwVaTl+IAgZUFzNnZUXzr4cl42Z
         Vx8qe7vqnaptr21WV2xbiaL0SDoVSHHXkX3AmfJaiiO7lknNM9qoJ6uljPfBhQZ/95BE
         ypmq7hh0vAkgyUAEmg1AbNCPs8EIyftwRO5qrdW+USlbds1Rk3rqx44jBe4KtpUm1GWy
         b7Fa+ftRjg2xnNPvwhZMTi4WAQ/U7zYNNBrak/g56qJRDH/cwpASJFwnioOPEoacwrzc
         nJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y4UPRNgYkTTgkIOvGTjmVSedLlvmZSyOq0T81C3zGQQ=;
        b=NKTJWljY6PLDwA+3zw3tEWxslKbBWkBu1fGJ72KQ+a8TONgDR3GV1RRC7mqaKVC3w4
         tFdcbt1xhSVZyf5oegU3rQdr+MjD/0ReCzlTvfFn0tVSGtrZs8rUZmANMEnrfn2ICZNa
         JlXX+br8JV2bhdQX47tndH85cb1uIWcowEKjFuYWHiAcRKh9blp1c/0OiRUDBPKIpra3
         WjzPK1wbWF3zO68KY4RBTxOezfuqNMrqV6RKdNZxyHlGm6pDzvI54/dVEeZ1mYIZCyhE
         EGYdBQPcmuCeA2eskjaYZcOwqVisRfi/xH9pbt7Y6SyE67OoE/Dn+tFpplvfinvGtFCo
         CSDg==
X-Gm-Message-State: ANoB5pnXa2M6E6iELidznrXuzbgLcrBRWXPKT+2wN5oixOqSTh476gfX
        q9IHmWSa1vhRO++Sl2gnfN+8hgtuTSJmdw==
X-Google-Smtp-Source: AA0mqf4RVc/bugMEEbfhBijTlb6yZTVCcV8m0eiN3FOX6RpxqNLLZ8FwRhVbBFQpqsgduZLM9zeqcw==
X-Received: by 2002:a17:906:398b:b0:7ad:b868:f096 with SMTP id h11-20020a170906398b00b007adb868f096mr32352998eje.295.1669381694005;
        Fri, 25 Nov 2022 05:08:14 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id ta19-20020a1709078c1300b0078d46aa3b82sm1545365ejc.21.2022.11.25.05.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 05:08:13 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id AB0FEBE2DE0; Fri, 25 Nov 2022 14:08:12 +0100 (CET)
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     NeilBrown <neilb@suse.de>, Steve Dickson <steved@redhat.com>,
        linux-nfs@vger.kernel.org
Cc:     Andras Korn <korn-debbugs@elan.rulez.org>,
        Marco d'Itri <md@linux.it>, Michael Prokop <mika@debian.org>,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH 3/4] Revert "systemd: Apply all sysctl settings when NFS-related modules are loaded"
Date:   Fri, 25 Nov 2022 14:07:24 +0100
Message-Id: <20221125130725.1977606-4-carnil@debian.org>
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

This reverts commit afc7132dfb212ac1f676a5ac36d29a9e06325645.

The approach caused problems with sysctl from busybox and with kmod as
reported in Debian (https://bugs.debian.org/1024082).

Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 systemd/50-nfs.conf | 16 ----------------
 systemd/Makefile.am | 10 ++--------
 2 files changed, 2 insertions(+), 24 deletions(-)
 delete mode 100644 systemd/50-nfs.conf

diff --git a/systemd/50-nfs.conf b/systemd/50-nfs.conf
deleted file mode 100644
index b56b2d765969..000000000000
--- a/systemd/50-nfs.conf
+++ /dev/null
@@ -1,16 +0,0 @@
-# Ensure all NFS systctl settings get applied when modules load
-
-# sunrpc module supports "sunrpc.*" sysctls
-install sunrpc /sbin/modprobe --ignore-install sunrpc $CMDLINE_OPTS && /sbin/sysctl -q --pattern sunrpc --system
-
-# rpcrdma module supports sunrpc.svc_rdma.*
-install rpcrdma /sbin/modprobe --ignore-install rpcrdma $CMDLINE_OPTS && /sbin/sysctl -q --pattern sunrpc.svc_rdma --system
-
-# lockd module supports "fs.nfs.nlm*" and "fs.nfs.nsm*" sysctls
-install lockd /sbin/modprobe --ignore-install lockd $CMDLINE_OPTS && /sbin/sysctl -q --pattern fs.nfs.n[sl]m --system
-
-# nfsv4 module supports "fs.nfs.*" sysctls (nfs_callback_tcpport and idmap_cache_timeout)
-install nfsv4 /sbin/modprobe --ignore-install nfsv4 $CMDLINE_OPTS && /sbin/sysctl -q --pattern 'fs.nfs.(nfs_callback_tcpport|idmap_cache_timeout)' --system
-
-# nfs module supports "fs.nfs.*" sysctls
-install nfs /sbin/modprobe --ignore-install nfs $CMDLINE_OPTS && /sbin/sysctl -q --pattern fs.nfs --system
diff --git a/systemd/Makefile.am b/systemd/Makefile.am
index 63a50bf2c07e..e7f5d818a913 100644
--- a/systemd/Makefile.am
+++ b/systemd/Makefile.am
@@ -2,8 +2,6 @@
 
 MAINTAINERCLEANFILES = Makefile.in
 
-modprobe_files = 50-nfs.conf
-
 unit_files =  \
     nfs-client.target \
     rpc_pipefs.target \
@@ -53,7 +51,7 @@ endif
 
 man5_MANS	= nfs.conf.man
 man7_MANS	= nfs.systemd.man
-EXTRA_DIST = $(unit_files) $(modprobe_files) $(man5_MANS) $(man7_MANS)
+EXTRA_DIST = $(unit_files) $(man5_MANS) $(man7_MANS)
 
 generator_dir = $(unitdir)/../system-generators
 
@@ -75,12 +73,8 @@ rpc_pipefs_generator_LDADD = ../support/nfs/libnfs.la
 
 if INSTALL_SYSTEMD
 genexec_PROGRAMS = nfs-server-generator rpc-pipefs-generator
-install-data-hook: $(unit_files) $(modprobe_files)
+install-data-hook: $(unit_files)
 	mkdir -p $(DESTDIR)/$(unitdir)
 	cp $(unit_files) $(DESTDIR)/$(unitdir)
 	cp $(rpc_pipefs_mount_file) $(DESTDIR)/$(unitdir)/$(rpc_pipefsmount)
-else
-install-data-hook: $(modprobe_files)
 endif
-	mkdir -p $(DESTDIR)/usr/lib/modprobe.d
-	cp $(modprobe_files) $(DESTDIR)/usr/lib/modprobe.d/
-- 
2.38.1

