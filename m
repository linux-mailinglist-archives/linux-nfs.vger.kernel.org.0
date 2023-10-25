Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982487D74A5
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Oct 2023 21:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjJYTrk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Oct 2023 15:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjJYTrj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Oct 2023 15:47:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7AAC4
        for <linux-nfs@vger.kernel.org>; Wed, 25 Oct 2023 12:47:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B5CF721977;
        Wed, 25 Oct 2023 19:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698263249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KyoyxoHLxR34o6Y+q9kpL0sozeOv6K0w0T45MTYU4ZA=;
        b=oEmcDQlMhC825MPmYi445031ha5Tu1vWKMutkE/nyOetI1Ae9Kag3BT4wKf/GWdd1wDLFd
        cVKOiYlKmx8tOf4Z8UOsqoJ7R4JqXfJBjwJDsTugqRxuNZ14yNN5M4VO9Gwl1k3MDd7lOP
        8b3/1TcvaK4KfjAfao4UlXMuYZz6GjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698263249;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KyoyxoHLxR34o6Y+q9kpL0sozeOv6K0w0T45MTYU4ZA=;
        b=7yRN5KE689ETOW49syWqa+7GAZ5EOGHU4+KxQgyWmZpR9jSmLCFJyYvJATUvXulQ3LTnxK
        qDd1JjiNAmcRWxBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E7F313A82;
        Wed, 25 Oct 2023 19:47:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uFw2FNFwOWVwFQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 25 Oct 2023 19:47:29 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-nfs@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Richard Weinberger <richard@nod.at>,
        Steve Dickson <steved@redhat.com>
Subject: [PATCH 1/3] reexport/fsidd.c: Remove unused headers
Date:   Wed, 25 Oct 2023 21:46:59 +0200
Message-ID: <20231025194701.456031-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231025194701.456031-1-pvorel@suse.cz>
References: <20231025194701.456031-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: 0.72
X-Spamd-Result: default: False [0.72 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[4];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         R_MISSING_CHARSET(2.50)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.18)[70.17%]
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Some of them are needed but included elsewhere, e.g. <string.h>
included in xcommon.h, but at least <sys/random.h> is removed due
further code simplification.

Fixes: 6fd2732d ("export: Add fsidd")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 support/reexport/fsidd.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/support/reexport/fsidd.c b/support/reexport/fsidd.c
index d4b245e8..3e62b3fc 100644
--- a/support/reexport/fsidd.c
+++ b/support/reexport/fsidd.c
@@ -7,16 +7,6 @@
 #include <dlfcn.h>
 #endif
 #include <event2/event.h>
-#include <limits.h>
-#include <stdint.h>
-#include <stdio.h>
-#include <sys/random.h>
-#include <sys/socket.h>
-#include <sys/stat.h>
-#include <sys/types.h>
-#include <sys/un.h>
-#include <sys/vfs.h>
-#include <unistd.h>
 
 #include "conffile.h"
 #include "reexport_backend.h"
-- 
2.42.0

