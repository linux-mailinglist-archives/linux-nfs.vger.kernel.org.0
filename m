Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DE7695716
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Feb 2023 04:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjBNDHr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Feb 2023 22:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjBNDHq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Feb 2023 22:07:46 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117F12729
        for <linux-nfs@vger.kernel.org>; Mon, 13 Feb 2023 19:07:32 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ACEC020A5C;
        Tue, 14 Feb 2023 03:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1676344050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=13+pjgy6p6b+09532JhyVcgucBvzpNUVQUukb6LLj90=;
        b=A3eCoDQh4xGwY1XfikcrzgA2H9BMwmaq9dS1zsjxiszgXEXlefR6PENwKG0LHyYdV1/WKP
        zZMasH/9cajya3fGXBzfXzhjE1j2fG48EviKtxt8MAja5tvKseFGpotqpmO+1EIedg4bH2
        eHTfZYSvbGI3PI3zqDB0AFt+JviA+3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1676344050;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=13+pjgy6p6b+09532JhyVcgucBvzpNUVQUukb6LLj90=;
        b=MN8ZtGUijhoJrkauqS+wNymFqgFYQgLStq8yVlQAZoWgZCAN3DXHJVYo6+FxSQN9IQKv/G
        kAzZikgmagzotxDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1608013480;
        Tue, 14 Feb 2023 03:07:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IKHDKe/66mMdRAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 14 Feb 2023 03:07:27 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Trond Myklebust" <trondmy@kernel.org>
Cc:     "Anna Schumaker" <anna@kernel.org>,
        "Olga Kornievskaia" <aglo@umich.edu>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFS: avoid infinite NFS4ERR_OLD_STATEID loops
In-reply-to: <2172b7be16ff5b93da967a412ab47834b7444b21.camel@kernel.org>
References: <167632902904.1896.16364452992981515041@noble.neil.brown.name>,
 <2172b7be16ff5b93da967a412ab47834b7444b21.camel@kernel.org>
Date:   Tue, 14 Feb 2023 14:07:23 +1100
Message-id: <167634404344.1896.17506326638015125882@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 14 Feb 2023, Trond Myklebust wrote:
> On Tue, 2023-02-14 at 09:57 +1100, NeilBrown wrote:
> > 
> > Linux-NFS responds to NFS4ERR_OLD_STATEID by simply retrying the
> > request, hoping to make use of an updated stateid that might have
> > arrived from the server.  This is usually successful.
> > 
> > However if the client and server get out-of-sync for some reason and
> > if
> > there is no new stateid to try, this can result in an indefinite loop
> > which looks a bit like a DoS attack.
> > 
> > This can particularly happen when a server replies with success to an
> > OPEN request, but fails a subsequent GETATTR.  This has been observed
> > with Netapp and Hitachi servers when a concurrent unlink from a
> > different client removes the file between the OPEN and the GETATTR. 
> > The
> > GETATTR returns NFS4ERR_STALE.
> 
> Then they are both badly broken servers, and people should complain to
> NetApp and Hitachi. We're still not fixing their server bugs in the
> Linux client.

It's not about fixing a server bug.  It is defensive programming.  We
shouldn't let a buggy server cause a melt-down.

> 
> NACK...

Oh well, I tried.

Thanks,
NeilBrown


> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
> 
> 
> 

