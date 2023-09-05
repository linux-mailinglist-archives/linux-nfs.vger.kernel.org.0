Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAFB87927C1
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Sep 2023 18:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbjIEQFb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Sep 2023 12:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244968AbjIEBkn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Sep 2023 21:40:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B159BCC5
        for <linux-nfs@vger.kernel.org>; Mon,  4 Sep 2023 18:40:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6C2451F750;
        Tue,  5 Sep 2023 01:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693878037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=IfV7ijOl7n4APdARGzwjsy9HIk7+aZScpYTb1rOY40o=;
        b=QdduR2a5KRo8E3F5OzWkC33IkBlDjxl9rGifzeVrjLoB64LYJVz9sLm1ZPAGJyGUqeLd4M
        w/uGOcAMNdpgiy5rcCY4tYzKIAM5AU3U6PR9Kq6xO9X9rtB5gxBQhcb5fRLo74ufMYUfqX
        fdkKtuB9kHuvr4kDcGguUn99SI/QD/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693878037;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=IfV7ijOl7n4APdARGzwjsy9HIk7+aZScpYTb1rOY40o=;
        b=QXMnXoeX68pK3IIUxhH6iN4qOAOdbIMRwBk4zZLMiMM+vKamlnE2mKQi6sMwk3RYYkxDMC
        TbwGDocAQ5n2HiDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2D61D13499;
        Tue,  5 Sep 2023 01:40:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yFFONBOH9mSXUwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 05 Sep 2023 01:40:35 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/3] Revisions for topic-sunrpc-thread-scheduling
Date:   Tue,  5 Sep 2023 11:38:10 +1000
Message-ID: <20230905014011.25472-1-neilb@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This a resend of two recently sent patches (1 and 3) with
review comments addressed, plus a new patch (2) which renames
some function names for improved consistency.

Thanks,
NeilBrown

 [PATCH 1/3] lib: add light-weight queuing mechanism.
 [PATCH 2/3] SUNRPC: rename some functions from rqst_ to svc_thread_
 [PATCH 3/3] SUNRPC: only have one thread waking up at a time

