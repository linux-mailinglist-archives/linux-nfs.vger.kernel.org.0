Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE287D72CC
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Oct 2023 20:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjJYSCF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Oct 2023 14:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjJYSCE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Oct 2023 14:02:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296F2123
        for <linux-nfs@vger.kernel.org>; Wed, 25 Oct 2023 11:02:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CA68C1FFC0;
        Wed, 25 Oct 2023 18:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698256919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=4c0JG7/Ou91Dnr1ipZrc0vj0H3TJfV4CsNO6jHvx6rU=;
        b=a/YEvUf/nAKJVBl4qqUsJl/bg4hh0zV9jemc/EFkS54pJOFEKJ0M/R4AOtNma6rF7JwCVl
        p16cFPZJ3plzAIYPbWpZLNFqDa6CJDFc+biet4wQgOdxokYUaM0mVzZV0ioYOLVreFpXE6
        jaU4ArfZ++mbk4T7uyJcRA1YVFt8NiQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698256919;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=4c0JG7/Ou91Dnr1ipZrc0vj0H3TJfV4CsNO6jHvx6rU=;
        b=I9dIQnI6GJxeHrrAtlWYWnyrdR9F+D+AAwctzRftT/v3J2i3Mbwp+Dy/RURU3IGra6wQrL
        MlsQivkiormHSfBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 61A8013524;
        Wed, 25 Oct 2023 18:01:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qtyhEBdYOWUBcgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 25 Oct 2023 18:01:59 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-nfs@vger.kernel.org
Cc:     Petr Vorel <petr.vorel@gmail.com>,
        Olga Kornievskaia <kolga@netapp.com>,
        Steve Dickson <steved@redhat.com>, Petr Vorel <pvorel@suse.cz>
Subject: [PATCH 1/1] libtirpc: Add detection for new rpc_gss_sec members
Date:   Wed, 25 Oct 2023 20:01:41 +0200
Message-ID: <20231025180141.416189-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Petr Vorel <petr.vorel@gmail.com>

4b272471 started to use struct rpc_gss_sec member minor_status, which
was added in new libtirpc 1.3.4. Add check for the member to prevent
failure on older libtirpc headers.

Fixes: 4b272471 ("gssd: handle KRB5_AP_ERR_BAD_INTEGRITY for machine credentials")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 aclocal/libtirpc.m4 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/aclocal/libtirpc.m4 b/aclocal/libtirpc.m4
index bddae022..dd351722 100644
--- a/aclocal/libtirpc.m4
+++ b/aclocal/libtirpc.m4
@@ -25,6 +25,10 @@ AC_DEFUN([AC_LIBTIRPC], [
                          [AC_DEFINE([HAVE_LIBTIRPC_SET_DEBUG], [1],
                                     [Define to 1 if your tirpc library provides libtirpc_set_debug])],,
                          [${LIBS}])])
+     AS_IF([test "$enable_gss" = "yes"],
+           [AC_CHECK_MEMBER(struct rpc_gss_sec.minor_status,,
+                         [AC_MSG_ERROR([Missing rpc_gss_sec.minor_status in <rpc/auth_gss.h>, update libtirpc or run with --disable-gss])],
+                         [#include <rpc/auth_gss.h>])])
 
   AC_SUBST([AM_CPPFLAGS])
   AC_SUBST(LIBTIRPC)
-- 
2.42.0

