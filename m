Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00AA638BD5
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Nov 2022 15:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiKYOHL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Nov 2022 09:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiKYOHK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Nov 2022 09:07:10 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0382C1EC43
        for <linux-nfs@vger.kernel.org>; Fri, 25 Nov 2022 06:07:09 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id e13so6533313edj.7
        for <linux-nfs@vger.kernel.org>; Fri, 25 Nov 2022 06:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4UPRNgYkTTgkIOvGTjmVSedLlvmZSyOq0T81C3zGQQ=;
        b=GzBphOai3x59cLnsLGgVud00By7NgbRGrVMsrTugVfnKlFdUxaxyAAk6my4jKS3GNs
         Fv3uzZkChmT+Tq2ws7JY2zkjGUgVrIfo3juThdX4GaLZHGi7E0ixVxAdzD11ownXIgch
         +J9YvgnarIc0CH2oqWta46pi7WHyduzW9JyYmKiMhDL+RmvRPKYIo3+NeOqwS6QH7l5W
         58j4cZEspy2a2rh0zOvYUPYDL/KrxDGvOAgxMWmr4sNsI3oHBkPGaeuyGh7c4S8vfQRQ
         EjJX3cqBHiOwHORlaTn/y25JaVwSX97TqIFUxifHM0sfQqte6vpI0h0awRFP+nQV575g
         rR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y4UPRNgYkTTgkIOvGTjmVSedLlvmZSyOq0T81C3zGQQ=;
        b=6zXAoANN5YEq1/b7NGo7CzJ85anag7TwFSUIZ1icm7uwccp5LZGQFbQXu6OOyGSECt
         ASPSbvUYJNlp2j8D/uXWf3R5B7zh7gwUIuMyhO9bGSFVZkecFTbjEPEewijW84QflXKy
         aLR7k6dk1k+Ns4uFFdbMezfcP5PXqZ44WtTzVGOuRzIYVeH9wJmfIEoHTUfn7G8wWqBo
         cXKkPhrbQZWcHsXxeR8vJxyBg/lc7I0IpbY2mi4sFw9EvB5ARqJPBkQCU0jKUiJu8I8N
         ubLJ6zxYf/5CJ88VDp+mcq83vUoxxIg9l+l3oedT7ILOzUsJy52NJi6jPLah0I+NXsPY
         e0MA==
X-Gm-Message-State: ANoB5pn16azH9s/rbBvSYiwegR5oYvj1yWSVRZFmtyr1SHrVT9o4msgv
        HrKvyVcSYkoRyYKHfT8rvr0=
X-Google-Smtp-Source: AA0mqf4UcGJG9gKObzgQ6awmRef2OrxjB/91jtWA9K93sdhQyWRUyKEdMqNeDL0rmodgnvbqtKdDoA==
X-Received: by 2002:a05:6402:370e:b0:464:fa1:9dc3 with SMTP id ek14-20020a056402370e00b004640fa19dc3mr20649757edb.343.1669385228491;
        Fri, 25 Nov 2022 06:07:08 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id j9-20020a1709066dc900b007ba46867e6asm1633919ejt.16.2022.11.25.06.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 06:07:08 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id 71E26BE2DE0; Fri, 25 Nov 2022 15:07:07 +0100 (CET)
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     NeilBrown <neilb@suse.de>, Steve Dickson <steved@redhat.com>,
        linux-nfs@vger.kernel.org
Cc:     Andras Korn <korn-debbugs@elan.rulez.org>,
        Marco d'Itri <md@linux.it>, Michael Prokop <mika@debian.org>,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH v2 3/4] Revert "systemd: Apply all sysctl settings when NFS-related modules are loaded"
Date:   Fri, 25 Nov 2022 15:06:55 +0100
Message-Id: <20221125140656.1985137-4-carnil@debian.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221125140656.1985137-1-carnil@debian.org>
References: <20221125140656.1985137-1-carnil@debian.org>
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

