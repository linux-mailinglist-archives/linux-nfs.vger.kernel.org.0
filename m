Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A52594EED
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Aug 2022 05:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiHPDEV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Aug 2022 23:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbiHPDDr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Aug 2022 23:03:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1C12E0E35
        for <linux-nfs@vger.kernel.org>; Mon, 15 Aug 2022 16:35:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7BD3820DA3
        for <linux-nfs@vger.kernel.org>; Mon, 15 Aug 2022 23:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1660606541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=f4bV4pg5qfI7MODxICvvonQuhRljk8XLa+9qPluYqt8=;
        b=ANP7ESBYJCi84MZhHSdYEUHyj7Ui2IZwldc20ZtBhUCG3nWDwQHFLBO+PCvOSr8QoisgzU
        SqFKfACWlIUjNp8R51ZaEIIZGNYpqj/rJjyRP58xcdSJQBUcMh5bPZP19s750hH9bUCPhk
        ohSTjWQlIAJMh8tvTW8b7r/BF3GRARM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1660606541;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=f4bV4pg5qfI7MODxICvvonQuhRljk8XLa+9qPluYqt8=;
        b=cfoH3CulazAh/qooez6YUectvVsaHPhzxerf0Yh68GOU7+OsWG/XX0zEFd6Oe7LnQVRijc
        GvOfZF1OAdadbDDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E66EB13A99
        for <linux-nfs@vger.kernel.org>; Mon, 15 Aug 2022 23:35:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zBHzJ0zY+mLQLgAAMHmgww
        (envelope-from <neilb@suse.de>)
        for <linux-nfs@vger.kernel.org>; Mon, 15 Aug 2022 23:35:40 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Thoughts on mount option to configure client lease renewal time.
Date:   Tue, 16 Aug 2022 09:35:07 +1000
Message-id: <166060650771.5425.13177692519730215643@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


Currently the Linux NFS renews leases at 2/3 of the lease time advised
by the server.
Some server vendors (Not Exactly Targeting Any Particular Party)
recommend very short lease times - as short a 5 seconds in fail-over
configurations.  This means 1.7 seconds of jitter in any part of the
system can result in leases being lost - but it does achieve fast
fail-over. 

If we could configure a 5 second lease-renewal on the client, but leave
a 60 second lease time on the server, then we could get the best of both
worlds.  Failover would happen quickly, but you would need a much longer
load spike or network partition to cause the loss of leases.

As v4.1 can end the grace period early once everyone checks in, a large
grace period (which is needed for a large lease time) would rarely be a
problem.

So my thought is to add a mount option "lease-renew=5" for v4.1+ mounts.
The clients then uses that number providing it is less than 2/3 of the
server-declared lease time.

What do people think of this?  Is there a better solution, or a problem
with this one?

NeilBrown
 
