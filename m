Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A7D758ABC
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jul 2023 03:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjGSBQc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Jul 2023 21:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGSBQc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Jul 2023 21:16:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEC4170B
        for <linux-nfs@vger.kernel.org>; Tue, 18 Jul 2023 18:16:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E0E69218E6;
        Wed, 19 Jul 2023 01:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689729388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zdZe05aW0uWu6YvJOupQhfZPlzlSEvz+m2s/gjJh7yg=;
        b=ah6Ts67giOegioitNdRKGceIjenBJEWjDhI3PdS+xpWAju0mwmZvGW0k71cpJfWahts7sv
        yWvPgGWIpY23eejy8bzcSbLQ1HOAvPSStzz6FvtiLg4xLMlfPQB4fJNc1qm6lSRWKwGngM
        gnU+Jkf1P34fwHCdyq18G4vYGqzj7M0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689729388;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zdZe05aW0uWu6YvJOupQhfZPlzlSEvz+m2s/gjJh7yg=;
        b=qjtvjRSEiHoBHNjjlzDX9ToDIR8aBtYD0PW54ozn84Em8PSy8XYeSHHEWMzcURXIzxH2Br
        cch9aFxJplGvSpAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5B80713494;
        Wed, 19 Jul 2023 01:16:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3NpRBGs5t2TKMwAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 19 Jul 2023 01:16:27 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <cel@kernel.org>
Cc:     "Chuck Lever" <chuck.lever@oracle.com>,
        "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 10/14] SUNRPC: change svc_pool_wake_idle_thread() to
 return nothing.
In-reply-to: <ZLaagzqpB9MsQ5yb@bazille.1015granger.net>
References: <168966227838.11075.2974227708495338626.stgit@noble.brown>,
 <168966228866.11075.18415964365983945832.stgit@noble.brown>,
 <ZLaagzqpB9MsQ5yb@bazille.1015granger.net>
Date:   Wed, 19 Jul 2023 11:16:24 +1000
Message-id: <168972938409.11078.8409356274248659649@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 18 Jul 2023, Chuck Lever wrote:
> On Tue, Jul 18, 2023 at 04:38:08PM +1000, NeilBrown wrote:
> > No callers of svc_pool_wake_idle_thread() care which thread was woken -
> > except one that wants to trace the wakeup.  For now we drop that
> > tracepoint.
> 
> That's an important tracepoint, IMO.
> 
> It might be better to have svc_pool_wake_idle_thread() return void
> right from it's introduction, and move the tracepoint into that
> function. I can do that and respin if you agree.

Mostly I agree.

It isn't clear to me how you would handle trace_svc_xprt_enqueue(),
as there would be no code that can see both the trigger xprt, and the
woken rqst.

I also wonder if having the trace point when the wake-up is requested
makes any sense, as there is no guarantee that thread with handle that
xprt.

Maybe the trace point should report when the xprt is dequeued.  i.e.
maybe trace_svc_pool_awoken() should report the pid, and we could have
trace_svc_xprt_enqueue() only report the xprt, not the rqst.

Thanks,
NeilBrown
