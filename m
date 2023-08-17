Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A667800CF
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Aug 2023 00:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354485AbjHQWIn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Aug 2023 18:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355653AbjHQWIN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Aug 2023 18:08:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4910A3C03
        for <linux-nfs@vger.kernel.org>; Thu, 17 Aug 2023 15:07:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BF79E21861;
        Thu, 17 Aug 2023 22:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692309984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IiIjd3ZJpJuJ8EKygus3YEeenZt5Wyyx2K5uihcNKcE=;
        b=HQvs6iAsTvRl7GbOD0PW7Bj07te5iedYv22wvBbQ2dF7jllAp8bFu8YgJy1Uo311uRhPBh
        ovwSgnhouEycTPMpTIDQelr+XaK1cp7XoGP7dSVj4g6CqI3x8FIlYySEzxiHNAvxqKgkpi
        +j8lcqmh0NlQ4q+Mw7fObEhcxXLjPj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692309984;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IiIjd3ZJpJuJ8EKygus3YEeenZt5Wyyx2K5uihcNKcE=;
        b=obw+oluJMNoOArS80v6/dehKEw8gjDLzDqej7WXsEDa41TdDmlZdE6uw1ogo69DovyYEEC
        aiY1swc2JTKm9uAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7D4F31392B;
        Thu, 17 Aug 2023 22:06:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gAgbDN+Z3mQiDAAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 17 Aug 2023 22:06:23 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 06/10] SUNRPC/svc: add light-weight queuing mechanism.
In-reply-to: <ZN4xgOjEIDe0rX3i@tissot.1015granger.net>
References: <20230815015426.5091-1-neilb@suse.de>,
 <20230815015426.5091-7-neilb@suse.de>,
 <ZN4xgOjEIDe0rX3i@tissot.1015granger.net>
Date:   Fri, 18 Aug 2023 08:06:16 +1000
Message-id: <169230997620.11967.10640869594379522024@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 18 Aug 2023, Chuck Lever wrote:
> On Tue, Aug 15, 2023 at 11:54:22AM +1000, NeilBrown wrote:
> > lwq is a FIFO single-linked queue that only requires a spinlock
> > for dequeueing, which happens in process context.  Enqueueing is atomic
> > with no spinlock and can happen in any context.
> > 
> > Include a unit test for basic functionality - runs a boot/module-load
> > time.  Does not use kunit framework.
> > 
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  include/linux/sunrpc/svc_lwq.h |  79 +++++++++++++++++++
> 
> I'm wondering what your longer-term intentions are for this new
> mechanism. If it is only useful for SunRPC, then perhaps this
> header belongs under net/sunrpc instead.

I try to avoid long-term intentions, they rarely work out :-)

I did want to put it under net/sunrpc.  But that requires moving
structure definitions for svc_pool, svc_serv, and svc_xprt into
net/sunrpc - which I would like to do.
But there are a few places where svc_xprt (at least) is accessed from
fs/nfsd/ either directly (xpt_flags, xpt_cred, xpt_local ...) or
through inlines. (svc_xprt_get(), svc_xpt_set_local() ...).

We we would need to create APIs to replace the direct accesses, and turn
the inlines into EXPORT_SYMBOL function.

So I don't think it is practical.

I did contemplate putting lwq.c in lib/ but thought that could come
later if someone else found it useful.

NeilBrown
