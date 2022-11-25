Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62907638BD4
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Nov 2022 15:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiKYOHK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Nov 2022 09:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiKYOHK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Nov 2022 09:07:10 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9201EAFA
        for <linux-nfs@vger.kernel.org>; Fri, 25 Nov 2022 06:07:08 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id ha10so10620053ejb.3
        for <linux-nfs@vger.kernel.org>; Fri, 25 Nov 2022 06:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A33yTDzifZAAnLHPVh6Tk9AoRA7BtVeBQ7dtOdMue8k=;
        b=E/RgLsdBCqscHHZhTRNuqdG1wmO6LSqRDJapzeK+JbFBY+fFyGaUASxs25Bdy8WsOq
         9vGFhCeCymgos6JCyL2Jksn20hb82F4wg8YijjRtL/6XgIgCC3LubzLiP5N/a9xGvbsW
         iEtxXIKWwsXW7Isy6tz2CqCauQEpU6cskjzm4YRP7pH1/C6qsEL59+xmejqIavddQ+C/
         FDu9WiY2f/U7VuSE8YdoVQKMLo64Z3tuL1sa0KPP0wItsu6Ylmf54SpFq3FfeOZFvewE
         Wn2GT82I2TMwV4t/z2dNLHm+QeMoJqT0ZcXVlNbmTpMQcB+Lo9hR/foh/ssUT1qrWJ0L
         Wcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A33yTDzifZAAnLHPVh6Tk9AoRA7BtVeBQ7dtOdMue8k=;
        b=f0GYjkj+4T9wbB62J/YGrfpLH/CmHhHSYzBjcGA46v9OzW863Q2b4PeX1Vxcu4DjIo
         mHuI8aY+pg8GcbnNowiM2EoHtfaowHkOdPRy8T+mcFr0OCHJBzYDMRqxJvcwHG06iC0L
         etZkf3vMbD4Z2T+ZgYJficF4fAzuWc3nhvfQjtzldnKuZ9zj2jaHN+X3zO7Q8EJIJdb/
         5Ro3Tm4Ue8g0aWY+WavMe3ZDMjelVBevD/URnzAJ4kvnGSF4CoqYd19rz2nP/DnES6ih
         oBLUvHsLjwxlBTRaYpwcMXAYTVCuAIOU30Ub9FmE442Eouk6p/vJf1NuYI2HYxlKPMMW
         LyBQ==
X-Gm-Message-State: ANoB5pk5dACtcC/Yd1QY1AJf43dDRHZTpc94iVC+oaA1EE0erGjTtv1M
        1vZsAEnAzUApd18EuhuBcn4+GEVE6re5YQ==
X-Google-Smtp-Source: AA0mqf6UO7RMmqI2uMkQtTyXTyQt7RbjSNKA1Ba+jCjmO6zzs/I3+cJdCEYrgPDGKmWq2ryvyMi71w==
X-Received: by 2002:a17:906:9f09:b0:7bc:db1b:206f with SMTP id fy9-20020a1709069f0900b007bcdb1b206fmr2131777ejc.719.1669385227282;
        Fri, 25 Nov 2022 06:07:07 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id a4-20020aa7d744000000b004615f7495e0sm1821729eds.8.2022.11.25.06.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 06:07:06 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id 0DF32BE2DE0; Fri, 25 Nov 2022 15:07:06 +0100 (CET)
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     NeilBrown <neilb@suse.de>, Steve Dickson <steved@redhat.com>,
        linux-nfs@vger.kernel.org
Cc:     Andras Korn <korn-debbugs@elan.rulez.org>,
        Marco d'Itri <md@linux.it>, Michael Prokop <mika@debian.org>,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH v2 1/4] Revert "configure: make modprobe.d directory configurable."
Date:   Fri, 25 Nov 2022 15:06:53 +0100
Message-Id: <20221125140656.1985137-2-carnil@debian.org>
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

This reverts commit 7d76dd2e6f09a141eb6303b7343baa5c4f9c85ad.

This is part of the full revert of adding support via modprobe.d
configuration to set sysctl settings of NFS-related modules when loading
the modules.

The approach caused problems with sysctl from busybox and with kmod as
reported in Debian (https://bugs.debian.org/1024082).

Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 configure.ac        | 12 ------------
 systemd/Makefile.am |  6 ++----
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/configure.ac b/configure.ac
index 5d9cbf317453..4280cc770a45 100644
--- a/configure.ac
+++ b/configure.ac
@@ -71,18 +71,6 @@ AC_ARG_WITH(systemd,
 	AM_CONDITIONAL(INSTALL_SYSTEMD, [test "$use_systemd" = 1])
 	AC_SUBST(unitdir)
 
-modprobedir=/usr/lib/modprobe.d
-AC_ARG_WITH(modprobedir,
-	[AS_HELP_STRING([--with-modprobedir@<:@=modprobe-dir-path@:>@],[install modprobe config files @<:@Default: /usr/lib/modprobe.d@:>@])],
-	if test "$withval" != "no" ; then
-		modprobedir=$withval
-	else
-		modprobedir=
-	fi
-	)
-	AM_CONDITIONAL(INSTALL_MODPROBEDIR, [test -n "$modprobedir"])
-	AC_SUBST(modprobedir)
-
 AC_ARG_ENABLE(nfsv4,
 	[AS_HELP_STRING([--disable-nfsv4],[disable support for NFSv4 @<:@default=no@:>@])],
 	enable_nfsv4=$enableval,
diff --git a/systemd/Makefile.am b/systemd/Makefile.am
index 7b5ab84bd793..63a50bf2c07e 100644
--- a/systemd/Makefile.am
+++ b/systemd/Makefile.am
@@ -82,7 +82,5 @@ install-data-hook: $(unit_files) $(modprobe_files)
 else
 install-data-hook: $(modprobe_files)
 endif
-if INSTALL_MODPROBEDIR
-	mkdir -p $(DESTDIR)$(modprobedir)
-	cp $(modprobe_files) $(DESTDIR)$(modprobedir)
-endif
+	mkdir -p $(DESTDIR)/usr/lib/modprobe.d
+	cp $(modprobe_files) $(DESTDIR)/usr/lib/modprobe.d/
-- 
2.38.1

