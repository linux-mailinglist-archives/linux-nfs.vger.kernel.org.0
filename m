Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE1F758A23
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jul 2023 02:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjGSAjj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Jul 2023 20:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjGSAji (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Jul 2023 20:39:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8FF1715
        for <linux-nfs@vger.kernel.org>; Tue, 18 Jul 2023 17:39:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A342F1F461;
        Wed, 19 Jul 2023 00:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689727175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uDq0nWb+csYpZlitpj8gQlgVHpPAmXOjP1NEbLDQe7w=;
        b=aiRD2ARre1S8JDSfChoSu0xwBNfFutzqMlZSQVWT4dPjDa0WLFbag1Gi/2Sg6Ru3F+Fjlp
        UPszBZH0n23qbLnl/jr1JUH9cvt6J0A4eK8cN1QUsYuIDe2nYmpfkvZkvGYFZkUQfD5wGI
        wR5RlPkIZoxH8IFxAwUv8oLlM6l7zLg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689727175;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uDq0nWb+csYpZlitpj8gQlgVHpPAmXOjP1NEbLDQe7w=;
        b=umz9TTCg6q+dBWHk2K+a3CCG5U6rB8PjtLR9rFALEpAgtGnRx9vOovhFNCMXGER0wIMRsN
        B7CZbD5uae3pHgAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 74CA313494;
        Wed, 19 Jul 2023 00:39:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YtdDCsUwt2QJJQAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 19 Jul 2023 00:39:33 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Chuck Lever" <cel@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        "Jeff Layton" <jlayton@redhat.com>,
        "david@fromorbit.com" <david@fromorbit.com>
Subject: Re: [PATCH v3 5/9] SUNRPC: Count pool threads that were awoken but
 found no work to do
In-reply-to: <D20E4286-30D2-461D-B856-41D3C53C756C@oracle.com>
References: <168900729243.7514.15141312295052254929.stgit@manet.1015granger.net>,
 <168900734678.7514.887270657845753276.stgit@manet.1015granger.net>,
 <168902815363.8939.4838920400288577480@noble.neil.brown.name>,
 <D20E4286-30D2-461D-B856-41D3C53C756C@oracle.com>
Date:   Wed, 19 Jul 2023 10:39:29 +1000
Message-id: <168972716973.11078.4474704978173049217@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 11 Jul 2023, Chuck Lever III wrote:
> 
> > On Jul 10, 2023, at 6:29 PM, NeilBrown <neilb@suse.de> wrote:
> > 
> > On Tue, 11 Jul 2023, Chuck Lever wrote:
> >> From: Chuck Lever <chuck.lever@oracle.com>
> >> 
> >> Measure a source of thread scheduling inefficiency -- count threads
> >> that were awoken but found that the transport queue had already been
> >> emptied.
> >> 
> >> An empty transport queue is possible when threads that run between
> >> the wake_up_process() call and the woken thread returning from the
> >> scheduler have pulled all remaining work off the transport queue
> >> using the first svc_xprt_dequeue() in svc_get_next_xprt().
> > 
> > I'm in two minds about this.  The data being gathered here is
> > potentially useful
> 
> It's actually pretty shocking: I've measured more than
> 15% of thread wake-ups find no work to do.

I'm now wondering if that is a reliable statistic.

This counter as implemented doesn't count "pool threads that were awoken
but found no work to do".  Rather, it counts "pool threads that found no
work to do, either after having been awoken, or having just completed
some other request".

And it doesn't even really count that is it doesn't notice that lockd
"retry blocked" work (or the NFSv4.1 callback work, but we don't count
that at all I think).

Maybe we should only update the count if we had actually been woken up
recently.

NeilBrown
