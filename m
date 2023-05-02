Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D916F4C13
	for <lists+linux-nfs@lfdr.de>; Tue,  2 May 2023 23:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjEBVVs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 May 2023 17:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjEBVVr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 May 2023 17:21:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D28A10EF
        for <linux-nfs@vger.kernel.org>; Tue,  2 May 2023 14:21:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EC07921E58;
        Tue,  2 May 2023 21:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683062504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yqHcT1BHJ1MgKwU0Y2ccjvWhxGEz0csoNFyVUCd7Rgo=;
        b=fSKstwd87A67VkAGyxp24wYQCch5LWg1sRddawQ7q9mLq+98nIvoxFb8F3U7uugQc1RDOV
        VLBcsXFuO2LFKcYSU02uMrvfTP7lWPDAi1RoUjmzuCrbMrtj/kQ+pr/oUcixm7rOdJ7irS
        qr9M3b+Ds4ci3vscjA8XBaCcccoi2xU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683062504;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yqHcT1BHJ1MgKwU0Y2ccjvWhxGEz0csoNFyVUCd7Rgo=;
        b=RqzhBgbzu8/ejpzKV9hWkYaDlJhWKFobTkMikUPW3DgJyjaVv3K4G/4Eaf9f/AxpT9/6sw
        fi9iOKFpsK7YvdDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2F6CF139C3;
        Tue,  2 May 2023 21:21:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hXLpNeZ+UWStRwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 02 May 2023 21:21:42 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Petr Vorel" <pvorel@suse.cz>, ltp@lists.linux.it,
        "Cyril Hrubis" <chrubis@suse.cz>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] nfslock01.sh: Don't test on NFS v3 on TCP
In-reply-to: <d441b9f9dfcbb4719d97c7b3b5950dfeeb8913d2.camel@kernel.org>
References: <20230502075921.3614794-1-pvorel@suse.cz>,
 <d441b9f9dfcbb4719d97c7b3b5950dfeeb8913d2.camel@kernel.org>
Date:   Wed, 03 May 2023 07:21:36 +1000
Message-id: <168306249608.19756.8898498995753159325@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 02 May 2023, Jeff Layton wrote:
> On Tue, 2023-05-02 at 09:59 +0200, Petr Vorel wrote:
> > 
> > Although there is suggestion, how to fix the problem in kernel [2]:
> > 
> >     > Maybe rpcb_create_local() shall detect that it is not in root
> >     > netns, and only try AF_INET connection to > localhost in that case.
> > 
> >     That would be simple and might be sensible.  IF changing the AF_UNIX
> >     path to "/run/rpcbind.sock" isn't sufficient, then testing for the
> >     root_ns is probably the best second option.
> > 
> 
> Was it determined that changing the location of the socket wasn't
> sufficient to fix this? FWIW, My Fedora 38 machine seems to listen on
> that socket already:
> 
>     [Socket]
>     ListenStream=/run/rpcbind.sock

I think the best solution for this problem is to change the kernel to
first try to send to an abstract socket: "\0/run/rpcbind.sock".  Only if
that fails do we try "/run/rpcbind.sock".

We also change rpcbind to listen on both
   ListenStream=@/run/rpcbind.sock
   ListenStream=/run/rpcbind.sock

Abstract sockets are local to a network namespace, while non-abstract
Unix domain sockets are local to a file and so can only be local to a
mount namespace.  We clearly need rpcbind lookup from the kernel to be
netns-local, so abstract is the obvious choice.

NeilBrown
