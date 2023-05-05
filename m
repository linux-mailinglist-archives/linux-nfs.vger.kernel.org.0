Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA966F80F3
	for <lists+linux-nfs@lfdr.de>; Fri,  5 May 2023 12:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjEEKlt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 May 2023 06:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjEEKls (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 5 May 2023 06:41:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9D31155A
        for <linux-nfs@vger.kernel.org>; Fri,  5 May 2023 03:41:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 914112216F;
        Fri,  5 May 2023 10:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683283305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yv5avKygEKTSSLv3g87KeqR+dkSWiqbpFDaM6k01oVU=;
        b=fGQdMOAVofQeamXwqjA2YXKc93EAWTFarli3pylk3yMl0Cfrj4Xpri3f3cR0nznp22GZnA
        4sCpBUBzNZ6zZAtHhnVIW8dfdBpSB0xWCOgDp9qZgroO3/m6fkeTrIiwJJVQCtBpnzq/Ea
        EL0Lja2xJGBZ8RWbUwkBq7EblyQ8oMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683283305;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yv5avKygEKTSSLv3g87KeqR+dkSWiqbpFDaM6k01oVU=;
        b=Y/GmTwvbMaZ7AfzTZ1tWXqKTqL/L/RbrWWJQ7lfXc3J5O9/f3GnbhnATcCX1X5frq5B4DM
        TLD0i3+PZw1yQ1Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 79BD613513;
        Fri,  5 May 2023 10:41:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8S7+HGndVGTKfwAAMHmgww
        (envelope-from <chrubis@suse.cz>); Fri, 05 May 2023 10:41:45 +0000
Date:   Fri, 5 May 2023 12:42:47 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     ltp@lists.linux.it, NeilBrown <neilb@suse.de>,
        linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v5 1/5] nfs_lib.sh: Cleanup local and remote directories
 setup
Message-ID: <ZFTdp3wAO4qbpUjS@yuki>
References: <20230504131414.3826283-1-pvorel@suse.cz>
 <20230504131414.3826283-2-pvorel@suse.cz>
 <ZFO597l50v9PEQPP@yuki>
 <20230504211634.GA4244@pevik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504211634.GA4244@pevik>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi!
> > It's a bit puzzling why we have two identical functions with a different
> > name...
> 
> It's a preparation for TST_ALL_FILESYSTEMS=1 where the location changes.
> I can squash this into that commit where it changes.

That is the missing bit. No need to squash maybe just note that the
directory will change in the last commit of the patchset.

-- 
Cyril Hrubis
chrubis@suse.cz
