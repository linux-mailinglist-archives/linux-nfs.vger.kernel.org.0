Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DCC7D284A
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Oct 2023 04:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbjJWCLk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 22 Oct 2023 22:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjJWCLk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 22 Oct 2023 22:11:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C907F13E
        for <linux-nfs@vger.kernel.org>; Sun, 22 Oct 2023 19:11:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 68F9F1FE03;
        Mon, 23 Oct 2023 02:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698027096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=L+2DbS9ETwwn4kXdY99WXBjEX7pvEjn4ZAWI1SxyffE=;
        b=cGs1hvJkO0Rncsf89ifZNLhwlV4k1WqUDCTzRtOA9QwspkqjqqpCVh6ARMIj94yDGm0WP2
        DyNZ9KbsrZkGNg6rs5VyZqcc3dKzePSe3PfRHj9E3upuG1OXovFs7nPtkIVj6+mOierDq2
        KyMbIUE1t//0UozOj4KC9182awBUT6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698027096;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=L+2DbS9ETwwn4kXdY99WXBjEX7pvEjn4ZAWI1SxyffE=;
        b=5FDuoDE6fgIG1fFtfVTm7vX/Je5gVZAHppdtK62w7W3Pa/41bdzgTtqXwD9MEjMg2aVN1x
        47wG0K+6wZU6oCAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3EB10132FD;
        Mon, 23 Oct 2023 02:11:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SSrHOVbWNWVebwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 23 Oct 2023 02:11:34 +0000
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 0/6 nfs-utils v2] fixes for error handling in nfsd_fh
Date:   Mon, 23 Oct 2023 12:58:30 +1100
Message-ID: <20231023021052.5258-1-neilb@suse.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -2.10
X-Spamd-Result: default: False [-2.10 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[3];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         R_MISSING_CHARSET(2.50)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,
 this is a revised version of my previous series with the same name.
 This first two patches are unchanged.
 The third patch, which was an RFC, has been replaced with the last
 patch which actually addresses the issue rather than skirting 
 around it.

 Patch 3 here is a revert of a change I noticed while exploring the
 code.  cache_open() must be called BEFORE forking workers, as explained
 in that patch.
 Patches 4 and 5 factor our common code which makes the final patch
 simpler.

 The core issue is that sometimes mountd (or exportd) cannot give a
 definitey "yes" or "no" to a request to map an fsid to a path name.
 In these cases the only safe option is to delay and try again.

 This only becomes relevant if a filesystem is mounted by a client, then
 the server restarts (or the export cache is flushed) and the client
 tries to use a filehandle that it already has, but that server cannot
 find it and cannot be sure it doesn't exist.  This can happen when an
 export is marked "mountpoint" or when a re-exported NFS filesystem
 cannot contact the server and reports an ETIMEDOUT error.  In these
 cases we want the client to continue waiting (which it does) and also
 want mountd/exportd to periodically check if the target filesystem has
 come back (which it currently does not).  
 With the current code, once this situation happens and the client is
 waiting, the client will continue to wait indefintely even if the
 target filesytem becomes available.  The client can only continue if
 the NFS server is restarted or the export cache is flushed.  After the
 ptsch, then within 2 minutes of the target filesystem becoming
 available again, mountd will tell the kernel and when the client asks
 again it will get be allowed to proceed.

NeilBrown


 [PATCH 1/6] export: fix handling of error from match_fsid()
 [PATCH 2/6] export: add EACCES to the list of known
 [PATCH 3/6] export: move cache_open() before workers are forked.
 [PATCH 4/6] Move fork_workers() and wait_for_workers() in cache.c
 [PATCH 5/6] Share process_loop code between mountd and exportd.
 [PATCH 6/6] cache: periodically retry requests that couldn't be

