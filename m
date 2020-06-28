Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5A620C738
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Jun 2020 11:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgF1JZZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 28 Jun 2020 05:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgF1JZZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 28 Jun 2020 05:25:25 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C3DC061794
        for <linux-nfs@vger.kernel.org>; Sun, 28 Jun 2020 02:25:24 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id dr13so13349607ejc.3
        for <linux-nfs@vger.kernel.org>; Sun, 28 Jun 2020 02:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LBuBHRdDisSMltLdbjdy6NfP5E6hOSzeSOV94dimf44=;
        b=mwNw4tLuT0ry5AdN5/9vFaRqLpsOttLbMU+YFTqW1nRdwbqPMtw1ueuLzYUc2pnQ+s
         dacDi4NZDCK61eAl8MZfSgKZ982fevPBwe1qHyb6psyZEFcuVO5Bgewcn7dXznStEpxh
         KCMlFk6qVoIZyEBITryKlDRdn1OfSWp/fR1aRAriMR6ymXXSJhdgVHCeZs6idk7Eg8nQ
         mpd1TxAgIJIKOfh8qTif/RC6UYk6K+e+Sezroo5+agliYyewytVBhCqZLVq/2EpK/Ru1
         FlV/5aQeTwlEM7N2tAGsZUbK4Zs93TRHs4eegtU3oYzUnELb3osTqscr3CIqoekQAWD+
         mzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=LBuBHRdDisSMltLdbjdy6NfP5E6hOSzeSOV94dimf44=;
        b=k8Chkl+4Fh9OCoIbR39CkmMPqRCzXrmJEddYzPIcEGD4nGof1ehkdTifH3jfuIgTez
         JG8pLgUtQXKlXfvVtshvkEimyeGEKu7JaE3XXJHGavxQEHtoi3bPQrY6bVffR+aRFZ/w
         bMsGBDmnOklIXrYdSijaZrdPa51pGBrT1BpphYsW6/fBFwqN0m4WlpO9FbU/jLYw9kcO
         i5q65Wb/NriisYnflvODwuW2pjkcbAfqli8+VLXLRDf8EgZLOz44LKUplXz/2CP3Pfcb
         IF/HWG+3j5V4QjUPzfo2ZClW4P+ZmDyP6cwtC9hmQXFQ3M9P7bzku1Cg/yH3tyr4PaUz
         LaNg==
X-Gm-Message-State: AOAM5336JiYIA5jT4Lsb0+PXvtSkr5cfrSKZB2I+atK9flp2E4mjSVW1
        ZpqMBIMGF5OOahoPLIi5b0o=
X-Google-Smtp-Source: ABdhPJxB6cVxk6wVQ75KXvNDLxmpvwUt0IQHhFTx3aq/t1R0dBvNqQ3TBg6AYAwtmi3ftKOOhPUNlg==
X-Received: by 2002:a17:906:b888:: with SMTP id hb8mr9448693ejb.124.1593336323690;
        Sun, 28 Jun 2020 02:25:23 -0700 (PDT)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id d12sm19165943edx.80.2020.06.28.02.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 02:25:23 -0700 (PDT)
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     linux-nfs@vger.kernel.org
Cc:     NeilBrown <neilb@suse.de>, Steve Dickson <steved@redhat.com>,
        Scott Mayhew <smayhew@redhat.com>,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH] nfs-utils: systemd: nfs-server.service: Cleanup extra whitespaces
Date:   Sun, 28 Jun 2020 11:24:42 +0200
Message-Id: <20200628092441.81529-1-carnil@debian.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Although whitespaces immediately before or after the "=" are ignored,
removing the extra whitespaces in some of the key=value assignments
makes the style more consistent.

At least since systemd v242-rc1[1] this has been clarified that
whitespaces immediately before and after the "=" are allowed.

 [1] https://github.com/systemd/systemd/commit/170342c90be07f418ab786718d95ef76289126a0

Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 systemd/nfs-server.service | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/systemd/nfs-server.service b/systemd/nfs-server.service
index 24118d693965..06c1adb71692 100644
--- a/systemd/nfs-server.service
+++ b/systemd/nfs-server.service
@@ -1,18 +1,18 @@
 [Unit]
 Description=NFS server and services
 DefaultDependencies=no
-Requires= network.target proc-fs-nfsd.mount
-Requires= nfs-mountd.service
+Requires=network.target proc-fs-nfsd.mount
+Requires=nfs-mountd.service
 Wants=rpcbind.socket network-online.target
 Wants=rpc-statd.service nfs-idmapd.service
 Wants=rpc-statd-notify.service
 Wants=nfsdcld.service
 
-After= network-online.target local-fs.target
-After= proc-fs-nfsd.mount rpcbind.socket nfs-mountd.service
-After= nfs-idmapd.service rpc-statd.service
-After= nfsdcld.service
-Before= rpc-statd-notify.service
+After=network-online.target local-fs.target
+After=proc-fs-nfsd.mount rpcbind.socket nfs-mountd.service
+After=nfs-idmapd.service rpc-statd.service
+After=nfsdcld.service
+Before=rpc-statd-notify.service
 
 # GSS services dependencies and ordering
 Wants=auth-rpcgss-module.service
-- 
2.27.0

