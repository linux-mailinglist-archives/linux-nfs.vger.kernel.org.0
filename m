Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB72613D98
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Oct 2022 19:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiJaSpH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Oct 2022 14:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJaSpG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Oct 2022 14:45:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4465013DFA
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 11:45:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A84221F8B5;
        Mon, 31 Oct 2022 18:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667241902;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VqBzmXOc3pC+s5oucNl6URhCaogh64XAI2vmaCOHX4A=;
        b=Np4Y4z4NADhjyyvN8SLrIEIJBis6zHYBeHaMi9tNVcpEaYdW2a8NnpmvBaAKqFWP/fvsw0
        xSyjRs+fI4BxhR3Qhr6ixrQ0RMO3193yHMvwu++36w+N57UG5rAXB71xnazVJnfi0awR49
        dKpFzATOQbtyOYsv1qBDCTi6miJoHfU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667241902;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VqBzmXOc3pC+s5oucNl6URhCaogh64XAI2vmaCOHX4A=;
        b=Jf12n4dDEomOPeANlK6PuedMt1669GGjGvj4hXh4KXAF07E/EQEhrDTSmVlD136tou9xyO
        9hnR/bnP9hbRXBBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 747D213451;
        Mon, 31 Oct 2022 18:45:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id v/uKGq4XYGNkegAAMHmgww
        (envelope-from <pvorel@suse.cz>); Mon, 31 Oct 2022 18:45:02 +0000
Date:   Mon, 31 Oct 2022 19:45:00 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] nfsd: fix net-namespace logic in
 __nfsd_file_cache_purge
Message-ID: <Y2AXrMEim07Y0LLY@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20221031154921.500620-1-jlayton@kernel.org>
 <BCEEEF05-11E3-4E31-BDE1-DDCA65A5AB6F@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BCEEEF05-11E3-4E31-BDE1-DDCA65A5AB6F@oracle.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> > On Oct 31, 2022, at 11:49 AM, Jeff Layton <jlayton@kernel.org> wrote:

> > If the namespace doesn't match the one in "net", then we'll continue,
> > but that doesn't cause another rhashtable_walk_next call, so it will
> > loop infinitely.

> > Fixes: ce502f81ba88 ("NFSD: Convert the filecache to use rhashtable")
> > Reported-by: Petr Vorel <pvorel@suse.cz>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > fs/nfsd/filecache.c | 5 ++---
> > 1 file changed, 2 insertions(+), 3 deletions(-)

> Thank you! Applied and pushed to for-rc. I'll send a PR in a few days.

Thanks for a quick action!

What a shame you didn't put link to the report, which contains reproducer.
https://lore.kernel.org/ltp/Y1%2FP8gDAcWC%2F+VR3@pevik/

Kind regards,
Petr

> > The v1 patch applies cleanly to v6.0, but not to Chuck's for-next
> > branch. This one should be suitable there.
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index 98c6b5f51bc8..4a8aa7cd8354 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -890,9 +890,8 @@ __nfsd_file_cache_purge(struct net *net)

> > 		nf = rhashtable_walk_next(&iter);
> > 		while (!IS_ERR_OR_NULL(nf)) {
> > -			if (net && nf->nf_net != net)
> > -				continue;
> > -			nfsd_file_unhash_and_dispose(nf, &dispose);
> > +			if (!net || nf->nf_net == net)
> > +				nfsd_file_unhash_and_dispose(nf, &dispose);
> > 			nf = rhashtable_walk_next(&iter);
> > 		}

> > -- 
> > 2.38.1
