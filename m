Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EA94BC390
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Feb 2022 01:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238622AbiBSAnq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Feb 2022 19:43:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236378AbiBSAnp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Feb 2022 19:43:45 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9B01B762C
        for <linux-nfs@vger.kernel.org>; Fri, 18 Feb 2022 16:43:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3AF6E1F380;
        Sat, 19 Feb 2022 00:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645231406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YVTV0xPXoJ+E0t4CLLNurlPJIGMptv23FLAZiI/nKzA=;
        b=Ib9+Xh3uOq3l/E6YjsSotNwQAnjAGDOHV0hhQSLlVy46Qe3TvCrgPlhwEq5hBPW1cl9ynW
        tcImTjMoloRuH0senjmKpg5Wr2nvrEWBbrmtBgC2WC+EhS+cMK/4v08hHqeQlSix5CM++m
        yErNA4FdaWMT/vLjhHZFEJjI9TCwJNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645231406;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YVTV0xPXoJ+E0t4CLLNurlPJIGMptv23FLAZiI/nKzA=;
        b=jbUPxJtqypawYZZRGKmUNPyQsXznF3oySdlr63StZbW8yXDgESawj6Zcvc0G0xQfx4ZnI2
        +2NFE391f6vsUxAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D6E7F13343;
        Sat, 19 Feb 2022 00:43:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7x5+JCw9EGK+bgAAMHmgww
        (envelope-from <neilb@suse.de>); Sat, 19 Feb 2022 00:43:24 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Tom Talpey" <tom@talpey.com>, "Daire Byrne" <daire@dneg.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: NFSv4 versus NFSv3 parallel client op/s
In-reply-to: <66383037-8263-4D7B-B96C-C9CED24042FC@oracle.com>
References: <CAPt2mGMZh9=Vwcqjh0J4XoTu3stOnKwswdzApL4wCA_usOFV_g@mail.gmail.com>,
 <6b528d29-1a9c-d16e-f649-5d994d6222b8@talpey.com>,
 <CAPt2mGOnbN=N5TqCWzVtX7CYoptpknCbnSXGfoX8X87DsvhoKw@mail.gmail.com>,
 <3849f322-94f7-fe73-4e08-1660be516384@talpey.com>,
 <66383037-8263-4D7B-B96C-C9CED24042FC@oracle.com>
Date:   Sat, 19 Feb 2022 11:43:20 +1100
Message-id: <164523140095.10228.17507004698722847604@noble.neil.brown.name>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 19 Feb 2022, Chuck Lever III wrote:
> 
> > On Feb 18, 2022, at 4:26 PM, Tom Talpey <tom@talpey.com> wrote:
> > 
> > 
> > On 2/18/2022 2:04 PM, Daire Byrne wrote:
> >>
> >> 2) Why is the default linux client slot count 64 and the server's is
> >> 32? You can tune the linux client down and not up (if using a Linux
> >> server).
> > 
> > That's for Trond and Chuck I guess.
> 
> For the Linux NFS server, there is an enhancement request open
> in this area:
> 
> https://bugzilla.linux-nfs.org/show_bug.cgi?id=375
> 
> If there are any relevant design notes or performance results,
> that would be the place to put them.

I wonder if I have a login there..

> 
> IIRC the only downside to a large default slot count on the
> server is that it can waste memory, and it is difficult to handle
> the corner cases when the server is running on a small physical
> host (or in a small container).

I would have a small default slot count (one page of slots??), which
automatically grew when it reached some level - say 70% - providing the
required kmalloc succeeded (with GFP_NORETRY or similar so that it
doesn't try to hard).  It would register a "shrinker" so that it could
respond to memory pressure and scale back the slot count when memory is
tight.

Freeing slot memory would be not be quick as you might need to wait for
the client to stop using it, so allocating new memory should be
correspondingly sluggish.

Shouldn't be too hard....  Definitely don't want a tunable for this.

NeilBrown
