Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF02F77C26D
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Aug 2023 23:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjHNVca (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Aug 2023 17:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbjHNVcO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Aug 2023 17:32:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F728B3
        for <linux-nfs@vger.kernel.org>; Mon, 14 Aug 2023 14:32:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EC1BF2197D;
        Mon, 14 Aug 2023 21:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692048731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xMFd+J97lVBMNZiZ9uo8ik+ZaiDjBWAF8pHr6+yLLjY=;
        b=ujcGJR+XG417DciSY48WyOGfI9l3xE6IO+ZfWHNNE2TDgbeRSojMcrcqdOa1ZvRo/hgjnK
        1CRs5kTCGc3geEn4NhCK48r3Jx/2fYqQoviLEdRoI+WZ03uwPp9EsR++tJ/I1Yr99qdjI5
        5gy1cVWUOvhAyOhF0SaXnnG6UB6g2fc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692048731;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xMFd+J97lVBMNZiZ9uo8ik+ZaiDjBWAF8pHr6+yLLjY=;
        b=XVduNIqkKc5MV3JHuKpILFXh8E7crsFncDuRxEVgkrJeFjovq9Hu4KXgSxUj158d1UcV/A
        NEiXZMZy0ewZGgBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B1855138EE;
        Mon, 14 Aug 2023 21:32:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KRRIGVqd2mSaLAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 14 Aug 2023 21:32:10 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 5/6] SUNRPC: add list of idle threads
In-reply-to: <ZNpkNIlTHjEABvxY@tissot.1015granger.net>
References: <20230802073443.17965-1-neilb@suse.de>,
 <20230802073443.17965-6-neilb@suse.de>,
 <ZNpkNIlTHjEABvxY@tissot.1015granger.net>
Date:   Tue, 15 Aug 2023 07:32:06 +1000
Message-id: <169204872638.11073.6544737509625867398@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 15 Aug 2023, Chuck Lever wrote:
> On Wed, Aug 02, 2023 at 05:34:42PM +1000, NeilBrown wrote:
> > Rather than searching a list of threads to find an idle one, having a
> > list of idle threads allows an idle thread to be found immediately.
> > 
> > This adds some spin_lock calls which is not ideal, but as the hold-time
> > is tiny it is still faster than searching a list.
> 
> Keep in mind that b1691bc03d4e ("sunrpc: convert to lockless lookup
> of queued server threads") did the opposite because that very
> spin_lock was highly contended. I am skeptical of the above claim
> without lock_stat data... but that's sort of moot as this is a
> temporary situation, as you point out next.

The old code did a lot more writes in the spin-locked region than this
code - so more hold-time.
But as you say - we would need data rather than speculation if this were
to be more than an interim state.

> 
> 
> > A future patch will
> > remove them using llist.h.  This involves some subtlety and so is left
> > to a separate patch.
> 
> Since I haven't seen that patch yet, I'm reserving judgement about
> whether and how these two changes might be merged.

I'll try to send the remainder of the series today.
> 
> 
> > This removes the need for the RQ_BUSY flag.  The rqst is "busy"
> > precisely when it is not on the "idle" list.
> 
> I've been having some trouble with this one. The server system
> deadlocks hard as soon as the NFS server starts. I tracked it down
> this morning: this patch never initialized the sp_idle_threads
> list_head.

Whoops.  Looks like I didn't test this particular intermediate state.

> 
> I will apply this patch (with one-line fix) and the patch that
> removes SP_CONGESTED once I hear from the client folks on the
> "integrate backchannel" patch.

Thanks,
NeilBrown

