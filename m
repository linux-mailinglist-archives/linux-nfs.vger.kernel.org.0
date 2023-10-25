Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D537D74A3
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Oct 2023 21:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjJYTrj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Oct 2023 15:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJYTri (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Oct 2023 15:47:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB00AE5
        for <linux-nfs@vger.kernel.org>; Wed, 25 Oct 2023 12:47:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4553F215E6;
        Wed, 25 Oct 2023 19:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698263249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Cd69sKmpa9in4ROzPOz2lH76bRr6sDgrnauTr+fOwsc=;
        b=CaDS2z6mfGNXDNmowwEMHmu6rOqVq5EvLTD8BkgO2njlLZL9ylZ4BOymGb1LjjZ67fUXrD
        IOxSPQisfSeJT+NI+ZFvDUuFvH1ILZxqHyhLNIJ6zebgwcFS05q0z3Q+AWKxH52uCMQ/3U
        eQFzeY35ysqNFeDSu7aBVViV22Rc6Ag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698263249;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Cd69sKmpa9in4ROzPOz2lH76bRr6sDgrnauTr+fOwsc=;
        b=KOmliWoQTG96qkpAMfqEhZWT69Texf8B3CuHwWAkzFs4SrDYzHTUlrF1ky0IicWBZTnbL3
        HBTWr8BFUwlCTRAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D9CDC138E9;
        Wed, 25 Oct 2023 19:47:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FYrNL9BwOWVwFQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 25 Oct 2023 19:47:28 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-nfs@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Richard Weinberger <richard@nod.at>,
        Steve Dickson <steved@redhat.com>
Subject: [PATCH 0/3] Add getrandom() fallback, cleanup headers
Date:   Wed, 25 Oct 2023 21:46:58 +0200
Message-ID: <20231025194701.456031-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: 0.48
X-Spamd-Result: default: False [0.48 / 50.00];
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
         BAYES_HAM(-0.42)[78.10%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

motivation to add this is to allow to compile reexport on systems with
older libc. (getrandom() wrapper is supported on glibc 2.25+ and  musl
1.1.20+, uclibc-ng does
not yet support it).

getrandom() syscall is supported Linux 3.17+ (old enough to bother with
a check).

I also wonder why getrandom() syscall does not called with GRND_NONBLOCK
flag. Is it ok/needed to block?

Kind regards,
Petr

Petr Vorel (3):
  reexport/fsidd.c: Remove unused headers
  support/reexport.c: Remove unused headers
  support/backend_sqlite.c: Add getrandom() fallback

 Makefile.am                       |  1 +
 aclocal/getrandom.m4              | 16 ++++++++++++++++
 configure.ac                      |  3 +++
 support/reexport/backend_sqlite.c | 18 +++++++++++++++++-
 support/reexport/fsidd.c          | 10 ----------
 support/reexport/reexport.c       |  7 -------
 6 files changed, 37 insertions(+), 18 deletions(-)
 create mode 100644 aclocal/getrandom.m4

-- 
2.42.0

