Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10B4638AE3
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Nov 2022 14:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiKYNIP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Nov 2022 08:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiKYNIP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Nov 2022 08:08:15 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920862D1
        for <linux-nfs@vger.kernel.org>; Fri, 25 Nov 2022 05:08:13 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id ho10so10260765ejc.1
        for <linux-nfs@vger.kernel.org>; Fri, 25 Nov 2022 05:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/QsZ0GR2pKzUfTYmbPBONT+OzoL0BUcbKhakZxRGyXI=;
        b=j9i91Oa1bkZGonRkX4BZVIKG6aUU95O6a9ycTLFbOv7epnaX22L+BR41v+agaYjDY0
         bf2q2rrCuhHKq7MhPqtLv1oRIIbX4pj5CZ/ngv2ry+/AyHW0kFFGcUqDT2yYu59kFVdf
         KsTmm5wpWRZPZ5o5BhUGtkv6IIU2o5hUfslb1Rvi66IP3HNe+I+lcvpUaJ5g220Njuvl
         XrB1rqEgt+ON3XsJb+ZQkHNa0VfgVLaiA4nHMijykgaXgdYInlbRcNXJj+XMBiHkCj8F
         kTfQYajyRQQJI+4yt9VvShCPdtopV9XI3/CJu/t4oEUXBHHbf7EinlX8Y01V1M0uvP7v
         qHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/QsZ0GR2pKzUfTYmbPBONT+OzoL0BUcbKhakZxRGyXI=;
        b=tzBbfpiFJ2lehFyXeluLkNpLMlIWxpWL2WExL7y9TWLsQfyuu+79zavM2/9oQ8tKf6
         uhadLjx+Ctx/rbi8OxM2u1GoOgmEqIaHLGH2G9a83BrAcUhtXG7vCxYq6kHU3GRjczHt
         bQtfYCzCMFCsCgQhJRMn/ZYlsSPCltFJm4qeCpi9nQ0LD1fxxBA6RdhEMUQnCkVJhsD7
         ThqOkdy0dDMyc1SdtUO64XTg23DQJAOnlLpozRunvylshMAAe72yRfVf0Ih3ET8CquIl
         +sRt+rwKuXlTCY2cf47apBuVW1+oW4ktkEomznf4dqnDtPM+W1zvnEOWLkX7yBMCwqE0
         yj9A==
X-Gm-Message-State: ANoB5plOmVHIJCRvOltx6EuQijtUkgCZmebMDQGDXa9jyx2q9YV+YFJ6
        rUllmv/3zgacAZhFnInZjQ0=
X-Google-Smtp-Source: AA0mqf4SyRggubNWUKdDL4GdeqtlWSAjF/YLuuOyKzYEQFkd74yeZugHsOEVvAeL63awzzAYjDKfZQ==
X-Received: by 2002:a17:907:a509:b0:7bb:12ec:c8cd with SMTP id vr9-20020a170907a50900b007bb12ecc8cdmr7208899ejc.618.1669381692006;
        Fri, 25 Nov 2022 05:08:12 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id d18-20020a170906305200b007b29d292852sm1552452ejd.148.2022.11.25.05.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 05:08:10 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id 7443EBE2DE0; Fri, 25 Nov 2022 14:08:09 +0100 (CET)
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     NeilBrown <neilb@suse.de>, Steve Dickson <steved@redhat.com>,
        linux-nfs@vger.kernel.org
Cc:     Andras Korn <korn-debbugs@elan.rulez.org>,
        Marco d'Itri <md@linux.it>, Michael Prokop <mika@debian.org>,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH 1/4] Revert "configure: make modprobe.d directory configurable."
Date:   Fri, 25 Nov 2022 14:07:22 +0100
Message-Id: <20221125130725.1977606-2-carnil@debian.org>
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

This reverts commit 7d76dd2e6f09a141eb6303b7343baa5c4f9c85ad.

As part of the full revert of adding support via modprobe.d
configuration to set sysctl settings of NFS-related modules when loading
the modules.

The approach caused problems with sysctl from busybox and with kmod as
reported in Debian (https://bugs.debian.org/1024082)

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

