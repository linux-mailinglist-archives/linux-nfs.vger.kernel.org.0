Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537F86CCCD9
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Mar 2023 00:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjC1WLv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Mar 2023 18:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjC1WLu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 Mar 2023 18:11:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E321BFE
        for <linux-nfs@vger.kernel.org>; Tue, 28 Mar 2023 15:11:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ABB6D219FB;
        Tue, 28 Mar 2023 22:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1680041507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=tGlMucj0QfBF+OZR1z9zIXhRFb0lyugGbjTkvci0M2I=;
        b=lHyZfUaA0yNO3V8uximpkQ/WB7AlBeTPjlgHmebn+H/wRkXnIyqaQXzxqXte+rkfw1+D0l
        O/QCXscKC71UnGzXw4I4YdmjDzYjT9R/EmZ5sh+jYvti3k8i5IEJah7svbFNnX6SGCs2qu
        9ajvtTQfloY93eP+GGRM3LUJMr/AFxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1680041507;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=tGlMucj0QfBF+OZR1z9zIXhRFb0lyugGbjTkvci0M2I=;
        b=kt6BcIshB53P1GpY3a4YHwOmUXQSjw32iP3bjIcetN5E+RfYzylzwgSUwpo5aCyxUs99Tx
        7KFzAoLbn69R6XBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AEFD91390D;
        Tue, 28 Mar 2023 22:11:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4LmiFyJmI2QtUgAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 28 Mar 2023 22:11:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Steve Dickson <steved@redhat.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [PATCH nfs-utils] nfsd.man: fix typo in section on "scope".
Date:   Wed, 29 Mar 2023 09:11:43 +1100
Message-id: <168004150341.8106.13618674008997774396@noble.neil.brown.name>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



The missing "-" means that "-S" isn't mentioned at all.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 utils/nfsd/nfsd.man | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/nfsd/nfsd.man b/utils/nfsd/nfsd.man
index dc05f3623465..6f4fc1df3782 100644
--- a/utils/nfsd/nfsd.man
+++ b/utils/nfsd/nfsd.man
@@ -38,7 +38,7 @@ request on all known network addresses.  This may change in=
 future
 releases of the Linux Kernel. This option can be used multiple times
 to listen to more than one interface.
 .TP
-.B \S " or " \-\-scope scope
+.B \-S " or " \-\-scope scope
 NFSv4.1 and later require the server to report a "scope" which is used
 by the clients to detect if two connections are to the same server.
 By default Linux NFSD uses the host name as the scope.
--=20
2.40.0

