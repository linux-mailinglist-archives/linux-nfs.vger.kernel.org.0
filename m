Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 005FD20C9D6
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Jun 2020 21:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgF1TKM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 28 Jun 2020 15:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbgF1TKL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 28 Jun 2020 15:10:11 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E41C03E979
        for <linux-nfs@vger.kernel.org>; Sun, 28 Jun 2020 12:10:11 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id a8so9866135edy.1
        for <linux-nfs@vger.kernel.org>; Sun, 28 Jun 2020 12:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gz7fBPj7kNNcPB3HynIk2m4+/WFTV+wONRiqrAQYTkc=;
        b=Wu6NMC5z1OCIjmHwxmu0cDgNC5uVqpZpCKOtCpuTPh7bw5XKYjvPV2Cz8VXksNi5Eh
         XP/AYC1oq6EEjJPifVAUrdJsuflP21ooRplKoFlsLTIQLhfUbfrOEr8YjAdE/w+y3PTz
         gvbAGKLMvZsooRrYDidesxMZqX53RW6w59DgmzcgMafHmVU69B90BfrqwW/x6GaAYhAk
         OaErLBgep/5AQnAODdDAkjKwOcc4oqAATeGyLlLg/hvWmayPCdU4VDet/n03nFGC17qV
         L8287XY2sIYO7NaQ7GKgQogeld163kBZgSuV8Lbcf6pWo0oofdNK0Xn+jFg5dWogB1Ld
         ZRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Gz7fBPj7kNNcPB3HynIk2m4+/WFTV+wONRiqrAQYTkc=;
        b=YsAqa2VRl453dNH9AyLUn2wFIsOMXcoCLH+gq/c0zsBRQWKEFMdN9AxyM2kTva+Kfk
         CZHx/S1Uo66E1EkaBMVFl3ttHVsHbDjL0G07L4hiGt4OXyvxpfjmiZj6LcejDKb1DJXQ
         p4Bs12xUnn4pMYwjiwBhLXTUq4HFOl5QMlxsLxRs7s0DYg0xAo5ooO84A7lFblZzajo7
         /tpNlwnWUmjbFiQn3z/kzL8rZEe9mqcXMbB4zliJi6KQ2xP6Gm7c0zrADYxuX4Tqe28z
         qY8Aavz2xB7REX3CrkR5Ag/rkp4VR4P2XGBwMkjP0poRVSIf+mY7N+TGeeymYoN1ezFy
         fLrQ==
X-Gm-Message-State: AOAM530oO/D9vWz0JLI3xOcC9udonAeAhnuiL+Y7NLHm+uxNDcGNJbwZ
        swBHaKlzCwD8KQeujM6oHQ0=
X-Google-Smtp-Source: ABdhPJywKbcnpyEny28Z/pB+tnW6sJFsoEaDWabDjoXHK0LuW6iSY2M2wJF3E7dRJUxma6WA+pFcsQ==
X-Received: by 2002:a50:cd1e:: with SMTP id z30mr13718401edi.364.1593371410488;
        Sun, 28 Jun 2020 12:10:10 -0700 (PDT)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id w3sm23144429ejn.87.2020.06.28.12.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 12:10:09 -0700 (PDT)
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     linux-nfs@vger.kernel.org
Cc:     NeilBrown <neilb@suse.de>, Scott Mayhew <smayhew@redhat.com>,
        Steve Dickson <steved@redhat.com>,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH 1/2] systemd/Makefile: Drop exlicit setting of unit_dir
Date:   Sun, 28 Jun 2020 21:10:01 +0200
Message-Id: <20200628191002.136918-2-carnil@debian.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200628191002.136918-1-carnil@debian.org>
References: <20200628191002.136918-1-carnil@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The used variable is named unitdir in configure.ac and
systemd/Makefile.am otherwise but is used in a single place as unit_dir.

The setting has no effect, but if later commits would use a base to the
systemd unit files directory for installing further files this would
void the possibility to explicitly set a systemd unit files directory
via configure with --with-systemd=unit-dir-path.

Fixes: 0fbf91a4fd90 ("Include systemd unit files in "dist" and "install".")
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 systemd/Makefile.am | 1 -
 1 file changed, 1 deletion(-)

diff --git a/systemd/Makefile.am b/systemd/Makefile.am
index 75cdd9f54c81..f089c8831902 100644
--- a/systemd/Makefile.am
+++ b/systemd/Makefile.am
@@ -45,7 +45,6 @@ man5_MANS	= nfs.conf.man
 man7_MANS	= nfs.systemd.man
 EXTRA_DIST = $(unit_files) $(man5_MANS) $(man7_MANS)
 
-unit_dir = /usr/lib/systemd/system
 generator_dir = /usr/lib/systemd/system-generators
 
 EXTRA_PROGRAMS	= nfs-server-generator rpc-pipefs-generator
-- 
2.27.0

