Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC85746795
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jul 2023 04:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjGDCbF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jul 2023 22:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjGDCbF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Jul 2023 22:31:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE1C184
        for <linux-nfs@vger.kernel.org>; Mon,  3 Jul 2023 19:31:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DF35B2024A;
        Tue,  4 Jul 2023 02:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688437862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=//VBtrpwuh5XVGYr/OAhGjnlmDs8cg5fGO9KwlYP9sI=;
        b=UHCs1kqMqiCH3IEl9PSkO5pcm3GVzqqQJ2NU1LxH4zAy4GjLIR3UfxSAIC05Zmg4/hXX4Q
        ZFvvTTRc3Z5AsTHPmC2fFFa9sCW3rX19Ku+YBMfHdfSeiekAYzwObhm3x/CTObNWSiHpXX
        qWD7w7vSx6S1YdKI0dTpa7Zwe9qQkMU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688437862;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=//VBtrpwuh5XVGYr/OAhGjnlmDs8cg5fGO9KwlYP9sI=;
        b=F3LcOx9CMwkZLZrwPR3k0PxajpWjXGaUm1FkmBocaQNYKdWunFlxQDQFvR0BPezLitBH7k
        Jl77VvEEj97oXSBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AF7C1133F7;
        Tue,  4 Jul 2023 02:31:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +zE+GGSEo2R8FQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 04 Jul 2023 02:31:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <cel@kernel.org>
Cc:     linux-nfs@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>,
        lorenzo@kernel.org, jlayton@redhat.com, david@fromorbit.com
Subject: Re: [PATCH v2 4/9] SUNRPC: Count ingress RPC messages per svc_pool
In-reply-to: <ZKN6GZ8q9NVLywOJ@manet.1015granger.net>
References: <168842897573.139194.15893960758088950748.stgit@manet.1015granger.net>,
 <168842927591.139194.16920372497489479670.stgit@manet.1015granger.net>,
 <168843152047.8939.5788535164524204707@noble.neil.brown.name>,
 <ZKN6GZ8q9NVLywOJ@manet.1015granger.net>
Date:   Tue, 04 Jul 2023 12:30:57 +1000
Message-id: <168843785749.8939.9913705917013899427@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 04 Jul 2023, Chuck Lever wrote:
> On Tue, Jul 04, 2023 at 10:45:20AM +1000, NeilBrown wrote:
> > On Tue, 04 Jul 2023, Chuck Lever wrote:
> > > From: Chuck Lever <chuck.lever@oracle.com>
> > > 
> > > To get a sense of the average number of transport enqueue operations
> > > needed to process an incoming RPC message, re-use the "packets" pool
> > > stat. Track the number of complete RPC messages processed by each
> > > thread pool.
> > 
> > If I understand this correctly, then I would say it differently.
> > 
> > I think there are either zero or one transport enqueue operations for
> > each incoming RPC message.  Is that correct?  So the average would be in
> > (0,1].
> > Wouldn't it be more natural to talk about the average number of incoming
> > RPC messages processed per enqueue operation?  This would be typically
> > be around 1 on a lightly loaded server and would climb up as things get
> > busy. 
> > 
> > Was there a reason you wrote it the way around that you did?
> 
> Yes: more than one enqueue is done per incoming RPC. For example,
> svc_data_ready() enqueues, and so does svc_xprt_receive().
> 
> If the RPC requires more than one call to ->recvfrom() to complete
> the receive operation, each one of those calls does an enqueue.
> 

Ahhhh - that makes sense.  Thanks.
So its really that a number of transport enqueue operations are needed
to *receive* the message.  Once it is received, it is then processed
with no more enqueuing.

I was partly thrown by the fact that the series is mostly about the
queue of threads, but this is about the queue of transports.
I guess the more times a transport if queued, the more times a thread
needs to be woken?

Thanks,
NeilBrown
