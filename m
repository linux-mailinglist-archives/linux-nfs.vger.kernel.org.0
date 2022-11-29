Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67AF63BC2E
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Nov 2022 09:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbiK2IyK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Nov 2022 03:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiK2Ixw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Nov 2022 03:53:52 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE40C140E9
        for <linux-nfs@vger.kernel.org>; Tue, 29 Nov 2022 00:53:20 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id d20so8057282edn.0
        for <linux-nfs@vger.kernel.org>; Tue, 29 Nov 2022 00:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6EkNv25vVqO6G1jCkmIHj3RkHHnsObV8anr/hbzCbLY=;
        b=VEpbXo15GcaX/iFe1oSXBfx3vFvk4NpDU4g+pPUm2s+zKKEc78z4Vkztj3jisHLQfY
         wnWTnb0AYRLtjuNLH3bLKSp9X25x7IIDcUp+HcCwTtzlTMZwCGyytniYcsqBIngurNVG
         ZuskxRTwDceSbUI6IbCA1E5lPXLnZ7b8pEWvlXH0CIsKs5nGRPiJHz8SjYL67JP3Ad1b
         E7hbL+smp3O7eDp2tjA20/NU/C/Eoss4Mzoy6rfhJG9lo5pxWJEAw9/eX9nEWopPUUdC
         hfhDKEy11aRWcNPDDGxVJlVKo0zm7rRX5yBFi80kS42Vj9B/gL0KUav68l/65jpvmqES
         nXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6EkNv25vVqO6G1jCkmIHj3RkHHnsObV8anr/hbzCbLY=;
        b=vLP7xfrRyfn0FShWlNDI7OF0yfxQJhkcufRq5oPwHi1mHK6MoR965B3ZPR5vCN6hq1
         TkdpQ0T4HtoEcOxZyAEaKu5jlO4AmH/3lUq26kUnZ54Sn+B1klkCOShntgVTOEkfPw8a
         zoeITF4jz4hRuknxAjVOBvNm1vq4HAyw9zU49CpRboBEDXjNlnIvvlnKymN+qTYix6Qi
         OG+LnODSF7H4L4PIYZeGVzu7po7SFmwbhd9EC2fHIjR+kDmo1blF0gZZebC7stJgUXPB
         PZB33BPrtVY6dcnrnEowlHr1GRVapnZQ5xjC5hgBa/9bkeu/V5B+LYb6Shih8Rj7heEG
         rzZw==
X-Gm-Message-State: ANoB5plF0h+dTizty9xKnMxKu/LNKJj7CVfuWSQaf1NB+UNrw9l8CIEu
        ABXAoKNtKKL/ZDNdiasLfLzSOcHa8FM=
X-Google-Smtp-Source: AA0mqf52ZCZkJ2pbMxfvg9nBWxFN7GDRniiJhjkuip6cwV/FWjcKMg6OE13SN6sgw3XfujyKjpTKcg==
X-Received: by 2002:a05:6402:4504:b0:463:71ef:b9ce with SMTP id ez4-20020a056402450400b0046371efb9cemr41599942edb.75.1669711998759;
        Tue, 29 Nov 2022 00:53:18 -0800 (PST)
Received: from development1.visionsystems.de (mail.visionsystems.de. [213.209.99.202])
        by smtp.gmail.com with ESMTPSA id i13-20020a17090639cd00b0078d957e65b6sm5910762eje.23.2022.11.29.00.53.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Nov 2022 00:53:18 -0800 (PST)
From:   yegorslists@googlemail.com
To:     linux-nfs@vger.kernel.org
Cc:     steved@redhat.com, Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH] Fix typos in the root folder
Date:   Tue, 29 Nov 2022 09:53:05 +0100
Message-Id: <20221129085305.11448-1-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.17.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Yegor Yefremov <yegorslists@googlemail.com>

Also remove double spaces.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 NEWS         | 22 +++++++++++-----------
 configure.ac |  6 +++---
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/NEWS b/NEWS
index e70ae8ab..77872c5a 100644
--- a/NEWS
+++ b/NEWS
@@ -1,32 +1,32 @@
 Significant changes for nfs-utils 1.1.0 - March/April 2007
 
- - rpc.lockd is gone.  One 3 old kernel releases need it.
- - rpc.rquotad is gone.  Use the one from the 'quota' package.
-   Everone else does.
+ - rpc.lockd is gone. One 3 old kernel releases need it.
+ - rpc.rquotad is gone. Use the one from the 'quota' package.
+   Everyone else does.
  - /sbin/{u,}mount.nfs{,4} are now installed so 'mount' will
    use these to mount nfs filesystems instead of internal code.
   + mount.nfs will check for 'statd' to be running when mounting
-    a filesystem which requires it.  If it is not running it will
+    a filesystem which requires it. If it is not running it will
     run "/usr/sbin/start-statd" to try to start it.
     If statd is not running and cannot be started, mount.nfs will
     refuse to mount the filesystem and will suggest the 'nolock'
     option.
  - Substantial changes to statd
   + The 'notify' process that must happen at boot has been split
-    into a separate program "sm-notify".  It ensures that it
-    only runs once even if you restart statd.  This is correct
+    into a separate program "sm-notify". It ensures that it
+    only runs once even if you restart statd. This is correct
     behaviour.
   + statd stores state in the files in /var/lib/nfs/sm/ so that
     if you kill and restart it, it will restore that state and
     continue working correctly.
   + statd makes more use of DNS lookup and should handle
-    multi-homed peers better.  In particular, files in
+    multi-homed peers better. In particular, files in
     /var/lib/nfs/sm/ are named with the Full Qualified Domain Name
     if available.
  - If you export a directory as 'crossmnt', all filesystems
    mounted beneath are automatically exported with the same
    options (unless explicitly exported with different options).
- - subtree_check is no-longer the default.  The default is now
+ - subtree_check is no-longer the default. The default is now
    no_subtree_check.
  - By default the system 'rpcgen' is used while building
    nfs-utils rather than the internal one.
@@ -43,14 +43,14 @@ Significant changes for nfs-utils 1.1.0 - March/April 2007
 
  - A new option, -n, was added to rpc.gssd which specifies that
    accesses by root should not use 'machine credentials' when
-   accessing NFS file systems mounted with Kerberos.  Using this
+   accessing NFS file systems mounted with Kerberos. Using this
    option allows the root user to access the NFS space using any
    Kerberos principal, rather than always using the machine
-   credentials.  However, its use also requires that root manually
+   credentials. However, its use also requires that root manually
    authenticate before attempting a mount with Kerberos.
 
    When rpc.gssd uses machine credentials, the selection algorithm has
-   been changed.  Instead of simply using the first "nfs/*" key in the
+   been changed. Instead of simply using the first "nfs/*" key in the
    keytab, the keytab is now searched for keys in the following
    defined order:
 
diff --git a/configure.ac b/configure.ac
index 5d9cbf31..0a108171 100644
--- a/configure.ac
+++ b/configure.ac
@@ -688,12 +688,12 @@ AC_SUBST([AM_CFLAGS], ["$my_am_cflags $flg1 $flg2 $flg3 $flg4 $flg5"])
 # Make sure that $ACLOCAL_FLAGS are used during a rebuild
 AC_SUBST([ACLOCAL_AMFLAGS], ["-I $ac_macro_dir \$(ACLOCAL_FLAGS)"])
 
-# make _sysconfdir available for substituion in config files
+# make _sysconfdir available for substitution in config files
 # 2 "evals" needed late to expand variable names.
 AC_SUBST([_sysconfdir])
 AC_CONFIG_COMMANDS_PRE([eval eval _sysconfdir=$sysconfdir])
 
-# make _statedir available for substituion in config files
+# make _statedir available for substitution in config files
 # 2 "evals" needed late to expand variable names.
 AC_SUBST([_statedir])
 AC_CONFIG_COMMANDS_PRE([eval eval _statedir=$statedir])
@@ -705,7 +705,7 @@ else
 fi
 AC_SUBST(rpc_pipefsmount)
 
-# make _rpc_pipefsmount available for substituion in config files
+# make _rpc_pipefsmount available for substitution in config files
 # 2 "evals" needed late to expand variable names.
 AC_SUBST([_rpc_pipefsmount])
 AC_CONFIG_COMMANDS_PRE([eval eval _rpc_pipefsmount=$rpc_pipefsmount])
-- 
2.17.0

