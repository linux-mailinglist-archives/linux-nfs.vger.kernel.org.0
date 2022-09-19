Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10E85BD784
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Sep 2022 00:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiISWiY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Sep 2022 18:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiISWiX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Sep 2022 18:38:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A009B4F698
        for <linux-nfs@vger.kernel.org>; Mon, 19 Sep 2022 15:38:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2562D22033;
        Mon, 19 Sep 2022 22:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663627101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nnRlwtv4F+sYZly3z+BeZiinTcfO7Uaes5GCi+wzYBE=;
        b=wwjNQJH5cyS8Nx6afp+QOZZmUimIKiRxg1rl9TjQNCXROTDJ3+j0KAR/SKfT+q+gLghUUP
        RTF2EbOPL+OLALWfTYp9jwzxAZa1ChAAoUtiTOHzP1t2NmiiXfEUigDwXdAptloFZygZSy
        SYr63vHZQuQwn9ZlXVWfhYfgMs7W3Ng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663627101;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nnRlwtv4F+sYZly3z+BeZiinTcfO7Uaes5GCi+wzYBE=;
        b=4xhZe+/ojqp91xDLdMyC8v52eoot8EpAC4gx14uidmruZzMVUrWUVQU/ub7888K1yvVq1C
        sIX/m0eh8gWRN3BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A032713ABD;
        Mon, 19 Sep 2022 22:38:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jD9LFVvvKGOqFgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 19 Sep 2022 22:38:19 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Benjamin Coddington" <bcodding@redhat.com>
Cc:     "Trond Myklebust" <trondmy@hammerspace.com>, anna@kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 0/2] NFS: limit use of ACCESS cache for negative responses
In-reply-to: <9279E15C-0A9E-4486-BE45-5DA5DF40675D@redhat.com>
References: <165110909570.7595.8578730126480600782.stgit@noble.brown>,
 <165274590805.17247.12823419181284113076@noble.neil.brown.name>,
 <72f091ceaaf15069834eb200c04f0630eca7eaef.camel@hammerspace.com>,
 <165274805538.17247.18045261877097040122@noble.neil.brown.name>,
 <acdd578d2bb4551e45570c506d0948647d964f66.camel@hammerspace.com>,
 <165274950799.17247.7605561502483278140@noble.neil.brown.name>,
 <3ec50603479c7ee60cfa269aa06ae151e3ebc447.camel@hammerspace.com>,
 <165275056203.17247.1826100963816464474@noble.neil.brown.name>,
 <d6c351439c71d95f761c89533919850c91975639.camel@hammerspace.com>,
 <D788BD7B-029F-4A4C-A377-81B117BD4CD2@redhat.com>,
 <a56ca216aef75f419d8a13dd6c7719ef15bbcaab.camel@hammerspace.com>,
 <54685EB8-7E6D-4EC4-8A9E-2BF55F41DABA@redhat.com>,
 <f5a2163d11f73e24c2106d43e72d0400d5a282b6.camel@hammerspace.com>,
 <FA952BF7-1638-4BD1-8DA9-683078CFDE8F@redhat.com>,
 <361256cf42393e2af9691b40bd51594ce078f968.camel@hammerspace.com>,
 <9279E15C-0A9E-4486-BE45-5DA5DF40675D@redhat.com>
Date:   Tue, 20 Sep 2022 08:38:12 +1000
Message-id: <166362709287.9160.2951057161316110877@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 20 Sep 2022, Benjamin Coddington wrote:
> On 26 Aug 2022, at 20:52, Trond Myklebust wrote:
> 
> > Can we please try to solve the real problem first? The real problem is
> > not that user permissions change every hour on the server.
> >
> > POSIX normally only expects changes to happen to your group membership
> > when you log in. The problem here is that the NFS server is updating
> > its rules concerning your group membership at some random time after
> > your log in on the NFS client.
> >
> > So how about if we just do our best to approximate the POSIX rules, and
> > promise to revalidate your cached file access permissions at least once
> > after you log in? Then we can let the NFS server do whatever the hell
> > it wants to do after that.
> > IOW: If the sysadmin changes the group membership for the user, then
> > the user can remedy the problem by logging out and then logging back in
> > again, just like they do for local filesystems.
> 
> This goes a long way toward fixing things up for us, I appreciate it, and
> hope to see it merged.  The version on your testing branch (d84b059f) can
> have my:
> 
> Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
> Tested-by: Benjamin Coddington <bcodding@redhat.com>
> 

The test in that commit can be "gamed".
I could write a tool that double-forks with the intermediate exiting
so the grandchild will be inherited by init.  Then the grandchild can
access the problematic path and force the access cache for the current
user to be refreshed.  It would optionally need to do a 'find' to be
thorough.

Is this an API we are willing to support indefinitely?  Should I write
the tool?

NeilBrown
