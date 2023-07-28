Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07300767186
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jul 2023 18:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjG1QIx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Jul 2023 12:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjG1QIv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Jul 2023 12:08:51 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582D8421C
        for <linux-nfs@vger.kernel.org>; Fri, 28 Jul 2023 09:08:47 -0700 (PDT)
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4FE8C3F078
        for <linux-nfs@vger.kernel.org>; Fri, 28 Jul 2023 16:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1690560524;
        bh=IGgPL8KuCqmQ13+6Q23Tuc7dCOw/HvMHB25ZF+jfSg8=;
        h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
        b=MbM9lYg7lkBkBDLB/IFnHvLAav6wk/BJ5CfYVQKrz9hPgquapa+7p+bS3NEuD+HNF
         UWwpPtOmx1AtWhD8SH1mGxgdWK9xohmQwcPT1U5OhlnGprpE7G3GI1gs1lTWyFpcFk
         NLkNiZplbHD51plRO94ywYx20bFOGSXHx0GQJJJ+s/Tq9SWz+HfY5RpSxNeIHmrGS6
         xjQteNalK6z5LUMGlzw/hrWGJIxTx+Nzyvf/VW5D6402yt+HF5Y1AhkEaard/BZlev
         SI8LCJ7z212mLxnKZPaq+wEd/f/VZgLyhKBZC/WRzlQ9Q++CpGEVJppizDXmI75Zts
         myTxMhMVDWHAA==
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-5704970148dso23612597b3.3
        for <linux-nfs@vger.kernel.org>; Fri, 28 Jul 2023 09:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690560523; x=1691165323;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IGgPL8KuCqmQ13+6Q23Tuc7dCOw/HvMHB25ZF+jfSg8=;
        b=f8sebOs3pqCL0w8sackw0VrGgDIX2ulx3BYuKeivXQVd5Va+ieTQRWuZPEWR4vG813
         xHj8AiOhNiRq8ik8Mcgao6LBMXTun/Ysgf1edR2KIsG6DZ4Nz/SJcI8086zzD3O/9Z/P
         7uRNhBxxcC4wbxZhS+3hI3Ff/jBnI4vhPQnCrCwHIMMstl4tn8uO0HqimgIeY2seH+oJ
         4iLwKluVSewx3CxnGj6+BJtUbENRG2IYXLYXOAJEs9Aeo20K7yNL7bXJea8qkStGTQfd
         3CDheINBzi/FvCkdMeJci8Scru94Q5BBISU/UEsehgL2ee0luhvkpFzSmS7LrQUImWmK
         jDGg==
X-Gm-Message-State: ABy/qLZxXrydPB3Vgjm0QpBorLNLnfQdF9/6Wj40q9YX8XtmuwDnjqNf
        Yd7+XNYNaxARSCNfPYUIY3eyc+i9DmkyEquEDXhW87j5IsKWxT+OHH4EDVgLxM2Pq/G1YPu8OQ5
        0GjxLh0czzScMnOqL9Tnazd0npFcSwdPtDNNp/JKtSDFuLBmSzU7IHP8yUNPcLJn7
X-Received: by 2002:a81:fd0e:0:b0:583:cd37:432d with SMTP id g14-20020a81fd0e000000b00583cd37432dmr2403436ywn.49.1690560523417;
        Fri, 28 Jul 2023 09:08:43 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGEIGfwOhejtno+Dfp0061XWnyI4A6ECRGTIS/3JGnnGtXfaM+ulwCoRS6x+C6WiVBPnvlVJffbEIKZ22r6KU4=
X-Received: by 2002:a81:fd0e:0:b0:583:cd37:432d with SMTP id
 g14-20020a81fd0e000000b00583cd37432dmr2403417ywn.49.1690560523179; Fri, 28
 Jul 2023 09:08:43 -0700 (PDT)
MIME-Version: 1.0
From:   Andreas Hasenack <andreas@canonical.com>
Date:   Fri, 28 Jul 2023 13:08:32 -0300
Message-ID: <CANYNYEHETbcqmEhE7BB57bCH03J-XT986Bb+DucdpbV8KHeZug@mail.gmail.com>
Subject: [PATCH 2/2] Use the generated units instead of static ones
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Use the generated rpc_pipefs target and mount units instead of the
static ones. The rpc-pipefs generator will take care of generating them.

Signed-off-by: Andreas Hasenack <andreas.hasenack@canonical.com>
---
 configure.ac                            |  8 +-------
 systemd/Makefile.am                     |  5 -----
 systemd/rpc_pipefs.target               |  3 ---
 systemd/rpc_pipefs.target.in            |  3 ---
 systemd/var-lib-nfs-rpc_pipefs.mount    | 10 ----------
 systemd/var-lib-nfs-rpc_pipefs.mount.in | 10 ----------
 6 files changed, 1 insertion(+), 38 deletions(-)
 delete mode 100644 systemd/rpc_pipefs.target
 delete mode 100644 systemd/rpc_pipefs.target.in
 delete mode 100644 systemd/var-lib-nfs-rpc_pipefs.mount
 delete mode 100644 systemd/var-lib-nfs-rpc_pipefs.mount.in

diff --git a/configure.ac b/configure.ac
index 6fbcb974..13f3dc75 100644
--- a/configure.ac
+++ b/configure.ac
@@ -681,11 +681,7 @@ AC_CONFIG_COMMANDS_PRE([eval eval _sysconfdir=$sysconfdir])
 AC_SUBST([_statedir])
 AC_CONFIG_COMMANDS_PRE([eval eval _statedir=$statedir])

-if test "$statedir" = "/var/lib/nfs"; then
-   rpc_pipefsmount="var-lib-nfs-rpc_pipefs.mount"
-else
-   rpc_pipefsmount="$(systemd-escape -p "$statedir/rpc_pipefs").mount"
-fi
+rpc_pipefsmount="$(systemd-escape -p "$statedir/rpc_pipefs").mount"
 AC_SUBST(rpc_pipefsmount)

 # make _rpc_pipefsmount available for substitution in config files
@@ -696,8 +692,6 @@ AC_CONFIG_COMMANDS_PRE([eval eval
_rpc_pipefsmount=$rpc_pipefsmount])
 AC_CONFIG_FILES([
    Makefile
    systemd/rpc-gssd.service
-   systemd/rpc_pipefs.target
-   systemd/var-lib-nfs-rpc_pipefs.mount
    linux-nfs/Makefile
    support/Makefile
    support/export/Makefile
diff --git a/systemd/Makefile.am b/systemd/Makefile.am
index b4483222..1778f988 100644
--- a/systemd/Makefile.am
+++ b/systemd/Makefile.am
@@ -7,7 +7,6 @@ udev_files = 60-nfs.rules

 unit_files =  \
     nfs-client.target \
-    rpc_pipefs.target \
     \
     nfs-mountd.service \
     nfs-server.service \
@@ -18,9 +17,6 @@ unit_files =  \
     proc-fs-nfsd.mount \
     fsidd.service

-rpc_pipefs_mount_file = \
-    var-lib-nfs-rpc_pipefs.mount
-
 if CONFIG_NFSV4
 unit_files += \
     nfs-idmapd.service
@@ -82,7 +78,6 @@ genexec_PROGRAMS = nfs-server-generator rpc-pipefs-generator
 install-data-hook: $(unit_files) $(udev_files)
    mkdir -p $(DESTDIR)/$(unitdir)
    cp $(unit_files) $(DESTDIR)/$(unitdir)
-   cp $(rpc_pipefs_mount_file) $(DESTDIR)/$(unitdir)/$(rpc_pipefsmount)
    mkdir -p $(DESTDIR)/$(udev_rulesdir)
    cp $(udev_files) $(DESTDIR)/$(udev_rulesdir)
 endif
diff --git a/systemd/rpc_pipefs.target b/systemd/rpc_pipefs.target
deleted file mode 100644
index 01d4d278..00000000
--- a/systemd/rpc_pipefs.target
+++ /dev/null
@@ -1,3 +0,0 @@
-[Unit]
-Requires=var-lib-nfs-rpc_pipefs.mount
-After=var-lib-nfs-rpc_pipefs.mount
diff --git a/systemd/rpc_pipefs.target.in b/systemd/rpc_pipefs.target.in
deleted file mode 100644
index 332f62b6..00000000
--- a/systemd/rpc_pipefs.target.in
+++ /dev/null
@@ -1,3 +0,0 @@
-[Unit]
-Requires=@_rpc_pipefsmount@
-After=@_rpc_pipefsmount@
diff --git a/systemd/var-lib-nfs-rpc_pipefs.mount
b/systemd/var-lib-nfs-rpc_pipefs.mount
deleted file mode 100644
index 26d1c763..00000000
--- a/systemd/var-lib-nfs-rpc_pipefs.mount
+++ /dev/null
@@ -1,10 +0,0 @@
-[Unit]
-Description=RPC Pipe File System
-DefaultDependencies=no
-After=systemd-tmpfiles-setup.service
-Conflicts=umount.target
-
-[Mount]
-What=sunrpc
-Where=/var/lib/nfs/rpc_pipefs
-Type=rpc_pipefs
diff --git a/systemd/var-lib-nfs-rpc_pipefs.mount.in
b/systemd/var-lib-nfs-rpc_pipefs.mount.in
deleted file mode 100644
index 4c5d6ce4..00000000
--- a/systemd/var-lib-nfs-rpc_pipefs.mount.in
+++ /dev/null
@@ -1,10 +0,0 @@
-[Unit]
-Description=RPC Pipe File System
-DefaultDependencies=no
-After=systemd-tmpfiles-setup.service
-Conflicts=umount.target
-
-[Mount]
-What=sunrpc
-Where=@_statedir@/rpc_pipefs
-Type=rpc_pipefs
-- 
2.39.2
