Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD408638BD6
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Nov 2022 15:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiKYOHL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Nov 2022 09:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiKYOHK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Nov 2022 09:07:10 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7639B1EC47
        for <linux-nfs@vger.kernel.org>; Fri, 25 Nov 2022 06:07:09 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id f18so10597729ejz.5
        for <linux-nfs@vger.kernel.org>; Fri, 25 Nov 2022 06:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GcyNN6uzrcq89PuZTNX9upan9NehOZI7PkDkywoJLW8=;
        b=HK91dpmnbriaIeM9MW3FdZGE0nb6bLUndPF1DXiy7djBrrjXLWST/5MpDgtZcwt0iH
         hk70Mi1T2A4yXn1Sl3n6rTyIfTBDy6BD3rlI+29VwZCy9Lyey2WNXx+wp2XQAw/o6/3Z
         H7A+H6KTYKdfFJIyNEcRHxcyUJ/NSm7TLPMlDkQTAyfcUxl16IE9bOk+CRiKInJSopN4
         KUtdHJUdEPij9Hk2BXgtTXmRhx8b9vgwiXjTmoBs69nGD0LDL2MELOZ7Nrgjqpqq3M6U
         k2EEich93xXyHWl0x+GJwzmt11m+tfGdAm/QPFbC5CwC9dlFIjxNjIS64gtu1fN6z9k0
         K5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GcyNN6uzrcq89PuZTNX9upan9NehOZI7PkDkywoJLW8=;
        b=YI6yo1w7H9nizp05tzeN1ovQCe1KB++aEosf0iJy1WbB1ojtx1FBEWEEX4JB+g0He1
         vtZKgN/A1r+HTxCiSTXwKab3c7MFNA8EHD74hz0nz48Qc/94vfL7Z2LEPN3uJy2gOmXc
         FkZX8nIBQDAOSgFL7rFzBX/iWAmNJJKUcmwnGtCDE4/zNXsSzWieN1S3JSfc8HGGDk1o
         5WIhs2jGaCq9Nx7PM42Vbm10XtMXXmWrLLspACSNAJdWl/uwGkiFsTEz9mQqISetecpV
         62AEMYNWqcJSJENdhgEuzVG4CaMad8qq7YU59BwaRiTUeSHRQM8t9fJd62hr2HCj3HW9
         kaLg==
X-Gm-Message-State: ANoB5plt+drRqCPkqOpKURTzEcWrQJFXW/oJG7m2e+hkeg94w+2/kw6i
        md/0gr1PfIqv20ZDd2nQK4w=
X-Google-Smtp-Source: AA0mqf5PEulbt62YE3PnICeO9Ngqje1kLhmIlimqzpJM+16mQqzB5vfBBYFhApipFcj5q/Tp1FZzuw==
X-Received: by 2002:a17:906:f281:b0:7ae:3b9e:1d8a with SMTP id gu1-20020a170906f28100b007ae3b9e1d8amr30675664ejb.581.1669385227901;
        Fri, 25 Nov 2022 06:07:07 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id g18-20020a17090604d200b007ade5cc6e7asm907365eja.39.2022.11.25.06.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 06:07:07 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id C6A11BE2EE7; Fri, 25 Nov 2022 15:07:06 +0100 (CET)
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     NeilBrown <neilb@suse.de>, Steve Dickson <steved@redhat.com>,
        linux-nfs@vger.kernel.org
Cc:     Andras Korn <korn-debbugs@elan.rulez.org>,
        Marco d'Itri <md@linux.it>, Michael Prokop <mika@debian.org>,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH v2 2/4] Revert "modprobe: protect against sysctl errors"
Date:   Fri, 25 Nov 2022 15:06:54 +0100
Message-Id: <20221125140656.1985137-3-carnil@debian.org>
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

This reverts commit 5e60e38aa4ba251ef66610514be5f45c41519e0f.

This is part of the full revert of adding support via modprobe.d
configuration to set sysctl settings of NFS-related modules when loading
the modules.

The approach caused problems with sysctl from busybox and with kmod as
reported in Debian (https://bugs.debian.org/1024082).

Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 systemd/50-nfs.conf | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/systemd/50-nfs.conf b/systemd/50-nfs.conf
index 19e8ee734c8e..b56b2d765969 100644
--- a/systemd/50-nfs.conf
+++ b/systemd/50-nfs.conf
@@ -1,16 +1,16 @@
 # Ensure all NFS systctl settings get applied when modules load
 
 # sunrpc module supports "sunrpc.*" sysctls
-install sunrpc /sbin/modprobe --ignore-install sunrpc $CMDLINE_OPTS && { /sbin/sysctl -q --pattern sunrpc --system; exit 0; }
+install sunrpc /sbin/modprobe --ignore-install sunrpc $CMDLINE_OPTS && /sbin/sysctl -q --pattern sunrpc --system
 
 # rpcrdma module supports sunrpc.svc_rdma.*
-install rpcrdma /sbin/modprobe --ignore-install rpcrdma $CMDLINE_OPTS && { /sbin/sysctl -q --pattern sunrpc.svc_rdma --system; exit 0; }
+install rpcrdma /sbin/modprobe --ignore-install rpcrdma $CMDLINE_OPTS && /sbin/sysctl -q --pattern sunrpc.svc_rdma --system
 
 # lockd module supports "fs.nfs.nlm*" and "fs.nfs.nsm*" sysctls
-install lockd /sbin/modprobe --ignore-install lockd $CMDLINE_OPTS && { /sbin/sysctl -q --pattern fs.nfs.n[sl]m --system; exit 0; }
+install lockd /sbin/modprobe --ignore-install lockd $CMDLINE_OPTS && /sbin/sysctl -q --pattern fs.nfs.n[sl]m --system
 
 # nfsv4 module supports "fs.nfs.*" sysctls (nfs_callback_tcpport and idmap_cache_timeout)
-install nfsv4 /sbin/modprobe --ignore-install nfsv4 $CMDLINE_OPTS && { /sbin/sysctl -q --pattern 'fs.nfs.(nfs_callback_tcpport|idmap_cache_timeout)' --system; exit 0; }
+install nfsv4 /sbin/modprobe --ignore-install nfsv4 $CMDLINE_OPTS && /sbin/sysctl -q --pattern 'fs.nfs.(nfs_callback_tcpport|idmap_cache_timeout)' --system
 
 # nfs module supports "fs.nfs.*" sysctls
-install nfs /sbin/modprobe --ignore-install nfs $CMDLINE_OPTS && { /sbin/sysctl -q --pattern fs.nfs --system; exit 0; }
+install nfs /sbin/modprobe --ignore-install nfs $CMDLINE_OPTS && /sbin/sysctl -q --pattern fs.nfs --system
-- 
2.38.1

