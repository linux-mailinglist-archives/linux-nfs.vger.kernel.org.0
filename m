Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91FCD638AE5
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Nov 2022 14:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiKYNIU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Nov 2022 08:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiKYNIT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Nov 2022 08:08:19 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1E963E0
        for <linux-nfs@vger.kernel.org>; Fri, 25 Nov 2022 05:08:14 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id vp12so8935719ejc.8
        for <linux-nfs@vger.kernel.org>; Fri, 25 Nov 2022 05:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Mf7bwOsr7qPoi1b05IvL2g9IAOPZSM2jFTge8ASUM4=;
        b=A7nTUyja8VqLh874NoNG7JZK9f7wQp3b5WX1LzXOFhUYUya4GC1cC/1IqMNtHPCUU2
         /r4c6t0cW0oOikv1aAMFT4BrjjG/J/WPdcvulIjwDylS8qp7QsF/8CgZLams28xIp9jx
         RO0OlOAyZysmQNtF9wIKfXBTDpb4eArZmA5Kcnwb7YCwlVKh2SiCGGdNVAKv9tHJw6wY
         qkrF+M0L43rvtiYHlT3VX8AgQFpnyZkQeZg6uE0WR55KF88Tif44xCPUq6/qWWLRSfWw
         GJP1Lt4UFKZSZteEmxN+s5qnU5946GXoOE5QOS/DZWEDZi6Y9TVZc8fWwUCF2elNngTK
         yBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Mf7bwOsr7qPoi1b05IvL2g9IAOPZSM2jFTge8ASUM4=;
        b=rO+OdXtKdQ5xL7wl5GjoNuE7KRAj6tIw0qhqYqeeDrCujWHYeoD1w4GEFHyAyNpYWv
         2OcsXjyjS4FI6Z1DvTLVGt1l8lGRlY6hDz0BiQQ6QPDmDQ2vqR6mJgewARJVkztHwbik
         OgzKJ+o49FZ1zqRxaZHvj3dh+8jR16D7KLzB2YEN/4lH9PSVYlm2mNpyzdw4u8KS2zqk
         TAdotVCBF6CLctBGQMW5znCs+k65UD/yy/JnjH1Rjk9N9fSbwjH7tCoEY2rGM1pdaPe9
         nW6Od/bF8+3MWVSfq932wJJ9h9BppX4xZHtmisJNrtS+52IC1kGTOGwHyZhTLWvhV9gP
         VWgg==
X-Gm-Message-State: ANoB5pmRXm1dYp+ZVVBIkRDW+UWjh72LmCSpNFgY9a3nJn+SlhX+f3AS
        7agFQS4s5UQa9IKAoQKdLhc=
X-Google-Smtp-Source: AA0mqf7gnVEIBk4GshUAqslHSSJQS00lLhogHqtBIZoRPAU9avrSkYqpH3ABZx8Dl9vZuEU7KX7/jw==
X-Received: by 2002:a17:906:398b:b0:7ad:b868:f096 with SMTP id h11-20020a170906398b00b007adb868f096mr32352947eje.295.1669381693250;
        Fri, 25 Nov 2022 05:08:13 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906308900b007b8e069769esm1531243ejv.104.2022.11.25.05.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 05:08:12 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id 207AFBE2EE7; Fri, 25 Nov 2022 14:08:11 +0100 (CET)
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     NeilBrown <neilb@suse.de>, Steve Dickson <steved@redhat.com>,
        linux-nfs@vger.kernel.org
Cc:     Andras Korn <korn-debbugs@elan.rulez.org>,
        Marco d'Itri <md@linux.it>, Michael Prokop <mika@debian.org>,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH 2/4] Revert "modprobe: protect against sysctl errors"
Date:   Fri, 25 Nov 2022 14:07:23 +0100
Message-Id: <20221125130725.1977606-3-carnil@debian.org>
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

This reverts commit 5e60e38aa4ba251ef66610514be5f45c41519e0f.

As part of the full revert of adding support via modprobe.d
configuration to set sysctl settings of NFS-related modules when loading
the modules.

The approach caused problems with sysctl from busybox and with kmod as
reported in Debian (https://bugs.debian.org/1024082)

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

