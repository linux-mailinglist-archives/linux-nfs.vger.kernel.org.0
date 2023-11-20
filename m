Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9467F0AA9
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Nov 2023 03:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjKTCy1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Nov 2023 21:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjKTCy0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Nov 2023 21:54:26 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCCC12D
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 18:54:22 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 93DC921858;
        Mon, 20 Nov 2023 02:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1700448861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=lEpc2IpPyTukkAR597D5sWJGsucx19J5OIDhSjgzIVA=;
        b=pEfMPY61dkPZ8DJMaOhgIaNYYEb+0Ss5/oeN882MkvimeYN9EqAn1pZeFOY1Re56RGUwBO
        udH4ooT5DTd/BmcQ5v87VCEEdI4UlnTUMZHPLlfC04JNYqznRKbuXAXOXco2nL9vdHzQDA
        mavBS9ZdEQlrkLhT7ETzoyIpabeeju0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1700448861;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=lEpc2IpPyTukkAR597D5sWJGsucx19J5OIDhSjgzIVA=;
        b=GoJofQIsaOagafs5BcegZk4kBnKRacWwEz2DYA3MtHCFl6tjPB3Ho+4wHR66trBjTdBA36
        1xt5Z+ZCOtxjmrBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 98EDE138E3;
        Mon, 20 Nov 2023 02:54:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JaIiE1zKWmWzQQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 20 Nov 2023 02:54:20 +0000
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/2 nfs-utils] conffile: use /usr/etc aswell
Date:   Mon, 20 Nov 2023 13:52:26 +1100
Message-ID: <20231120025354.17511-1-neilb@suse.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Score: 11.04
X-Spamd-Result: default: False [11.04 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_SPAM_SHORT(3.00)[1.000];
         BROKEN_CONTENT_TYPE(1.50)[];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         RCPT_COUNT_TWO(0.00)[2];
         MID_CONTAINS_FROM(1.00)[];
         NEURAL_SPAM_LONG(3.50)[1.000];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.36)[76.67%]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The first patch it just a little cleanup.
The second is the important one.  It follows a trend of deprecating / in favour of /usr

NeilBrown

 [PATCH 1/2] conffile: don't report error from conf_init_file()
 [PATCH 2/2] conffile: allow /usr/etc to provide any config files

