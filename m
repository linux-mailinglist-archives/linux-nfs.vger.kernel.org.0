Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859C16EF990
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Apr 2023 19:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239056AbjDZRnB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Apr 2023 13:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236381AbjDZRmz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Apr 2023 13:42:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CCB35A5
        for <linux-nfs@vger.kernel.org>; Wed, 26 Apr 2023 10:42:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 75AA31FDD6;
        Wed, 26 Apr 2023 17:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682530973;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LTUkzilxp2Tf3FT5/MsOuGOHHwxgd7GgTNhhEQ0D29w=;
        b=pXdqe/B/yvsrMUlR9+2G77Qp5jEly0Acrivu3e3ewu83DKiAOA9xfvC3jfzFCc7yiZMDEr
        26FO9FWE+1i/NqC+CLfrAhAeWpS0wNT4AW7tzPa1ixhFFgeOsNOxC06aKAM9T/CYJnO7up
        VxV/HYBfUZ9+DJKpdlRZvXkipzaGF6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682530973;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LTUkzilxp2Tf3FT5/MsOuGOHHwxgd7GgTNhhEQ0D29w=;
        b=+luw71MyZtxmMqMxvfjoW7jZTAT87zgTk+2sUTV9hnujK3nyxRQFq/21OvspLXnc9jmk1Q
        r1bIGUtKYR7w9NBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BCACE138F0;
        Wed, 26 Apr 2023 17:42:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id giiPKZxiSWQ2TQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 26 Apr 2023 17:42:52 +0000
Date:   Wed, 26 Apr 2023 19:43:02 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Cyril Hrubis <chrubis@suse.cz>, NeilBrown <neilb@suse.de>,
        ltp@lists.linux.it
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [LTP] [PATCH 1/1] nfs/nfs08.sh: Add test for NFS cache
 invalidation
Message-ID: <20230426174302.GB3089461@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20230412082115.1990591-1-pvorel@suse.cz>
 <ZEfRrOpPwkLuBQw5@rei>
 <20230425134845.GA3014439@pevik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425134845.GA3014439@pevik>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi all,

> > Hi!
> > > v4 [1] of not yet upstreamed patch accidentally broke cache invalidation
> > > for directories by clearing NFS_INO_INVALID_DATA inappropriately.
> > > Although it was fixed in v5 [2] thus kernel was not actually broken,
> > > it's better to prevent this in the future.

> > > [1] https://lore.kernel.org/linux-nfs/167649314509.15170.15885497881041431304@noble.neil.brown.name/
> > > [2] https://lore.kernel.org/linux-nfs/167943762461.8008.3152357340238024342@noble.neil.brown.name/

> ...
> > > --- /dev/null
> > > +++ b/testcases/network/nfs/nfs_stress/nfs08.sh
> > > @@ -0,0 +1,20 @@
> > > +#!/bin/sh
> > > +# SPDX-License-Identifier: GPL-2.0-or-later
> > > +# Copyright (c) 2023 Petr Vorel <pvorel@suse.cz>
> > > +# Test reproducer for broken NFS cache invalidation for directories.
> > > +# Based on reproducer from Neil Brown <neilb@suse.de>
> > > +
> > > +TST_TESTFUNC="do_test"
> > > +
> > > +do_test()
> > > +{
> > > +	tst_res TINFO "testing NFS cache invalidation for directories"
> > > +
> > > +	touch 1
> > > +	EXPECT_PASS 'ls | grep 1'
> > > +
> > > +	touch 2
> > > +	EXPECT_PASS 'ls | grep 2'
> > > +}

> > I do not get how this actually detects case invalidation, it probably
> > does, but slightly better description how this actually excercises the
> > case would help.

> The behavior is:

> "touch 1" asks for data invalidation (new file created), therefore following ls
> (EXPECT_PASS 'ls | grep 1') fills the cache.  "touch 2" should again ask for
> data invalidation, but it the unfixed v4 version of the patch it did not
> resulted to cache invalidation.  Therefore second ls (EXPECT_PASS 'ls | grep 2')
> shows just 1, but not 2. i.e. in the affected kernel only second ls failed,
> but obviously both should be checked (nobody knows how another bug on cache
> invalidation will behave).

> I can add the description above to the commit message and adjust the comment in
> the file.

Merged with the updated description.

Kind regards,
Petr
