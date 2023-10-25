Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A971B7D74D7
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Oct 2023 21:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjJYTxi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Oct 2023 15:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjJYTxi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Oct 2023 15:53:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254C7137
        for <linux-nfs@vger.kernel.org>; Wed, 25 Oct 2023 12:53:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B99B620083;
        Wed, 25 Oct 2023 19:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698263250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BSY05Y/j0KiF9CKum/n1LW8xkzF8moMuMjeBW6Vgi0E=;
        b=EyuW5tVJwh763QqgBULo6sSsJGJMcSxeHbpSGV0kS4wrUPQT4v50CNz2Fd2ouXCDQWc/Pq
        1vDBNtyJSprJ1eo5Sdi6hzebEpqutwQpC0o028L3tR6F10yg9XuSYzCQUhOivinAfsN7Mi
        mOkMtRurnRr9Lu1Kb8jxZwEuUv3SWJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698263250;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BSY05Y/j0KiF9CKum/n1LW8xkzF8moMuMjeBW6Vgi0E=;
        b=cGNsXOG0KB0p6gT7/dH6tyEiUgoAP8HTlgTXVG6wlgT6e/hp+CKDxtL4u2MC6uHg6uzMN3
        E3FO8SDj+vRIu9DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C026413A9B;
        Wed, 25 Oct 2023 19:47:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GJM7LdFwOWVwFQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 25 Oct 2023 19:47:29 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-nfs@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Richard Weinberger <richard@nod.at>,
        Steve Dickson <steved@redhat.com>
Subject: [PATCH 2/3] support/reexport.c: Remove unused headers
Date:   Wed, 25 Oct 2023 21:47:00 +0200
Message-ID: <20231025194701.456031-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231025194701.456031-1-pvorel@suse.cz>
References: <20231025194701.456031-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Some of them are needed but included elsewhere, e.g. <sys/socket.h>
included in nfslib.h or <string.h> included in xcommon.h, but at least
<sys/random.h> is removed due further code simplification.

Fixes: 878674b3 ("Add reexport helper library")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 support/reexport/reexport.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/support/reexport/reexport.c b/support/reexport/reexport.c
index d9a700af..78516586 100644
--- a/support/reexport/reexport.c
+++ b/support/reexport/reexport.c
@@ -5,16 +5,9 @@
 #ifdef HAVE_DLFCN_H
 #include <dlfcn.h>
 #endif
-#include <stdint.h>
-#include <stdio.h>
-#include <sys/random.h>
-#include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/vfs.h>
-#include <unistd.h>
 #include <errno.h>
-#include <sys/socket.h>
-#include <sys/un.h>
 
 #include "nfsd_path.h"
 #include "conffile.h"
-- 
2.42.0

