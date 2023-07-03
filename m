Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1EE7464E9
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jul 2023 23:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjGCVdt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jul 2023 17:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjGCVdt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Jul 2023 17:33:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C33E72
        for <linux-nfs@vger.kernel.org>; Mon,  3 Jul 2023 14:33:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5827C200DD;
        Mon,  3 Jul 2023 21:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688420024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T5QhawNP2wMpMf2eOGNX5cSJknh7wtikbQS8vPz45pc=;
        b=FwWM1S9BjHsHgsCAvuy7jKRT8ClXoAJdROQsloboMRF7OAPF02eg/4RY68D96/o/CrfICm
        +TksCdneF7ynUl9g2vjZ2IaNZ471TZi9mCqJrULaX6d0NOhIMU1zGLbRORTT1hdC6ESAYX
        +js9qxvR3ut6GS88Ze/eWxvBg3z/7po=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688420024;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T5QhawNP2wMpMf2eOGNX5cSJknh7wtikbQS8vPz45pc=;
        b=BSaB4e6Qjudy9Pml1hXO9zQVTy9wWK62UOvDIa+s/5MvopDsCMMgzeuQjXZ4pOSE4ETWGZ
        2hfV3w4K1npJ6bCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C8B51358E;
        Mon,  3 Jul 2023 21:33:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /OSQK7Y+o2TyBgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 03 Jul 2023 21:33:42 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Chuck Lever" <cel@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC 0/4] Encode NFSv4 attributes via a branch table
In-reply-to: <F0F2C0F7-3F73-4713-BB37-661463646CC5@oracle.com>
References: <168808788945.7728.6965361432016501208.stgit@manet.1015granger.net>,
 <168835968730.8939.17203263812842647260@noble.neil.brown.name>,
 <F0F2C0F7-3F73-4713-BB37-661463646CC5@oracle.com>
Date:   Tue, 04 Jul 2023 07:33:38 +1000
Message-id: <168842001897.8939.938340124592787737@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 03 Jul 2023, Chuck Lever III wrote:
> 
> > On Jul 3, 2023, at 12:48 AM, NeilBrown <neilb@suse.de> wrote:
> > 
> > I guess in practice some of the attributes are "likely" and many are
> > "unlikely".
> 
> This is absolutely the case.
> 
> My first attempt at optimizing nfsd4_encode_fattr() was to build
> a miniature version that handled just the frequently-requested
> combinations of attributes. It made very little difference.

My understanding of the effect of these code-movement optimisations is
that they affect whole-system performance rather than micro-benchmarks. 
So they are quite hard to measure.
Modern CPUs are quite good at predicting code flow, so the benefit of
code movement is not a reduction in pipeline stalls, but a reduction in
cache usage.  The latter affects the whole system more-or-less equally.


> 
> The conclusions that I drew from that are:
> 
> - The number of conditional branches in here doesn't seem to be
>   the costly part of encode_fattr().
> 
> - The frequently-requested attributes are expensive to process
>   for some reason. Size is easy, but getting the user and
>   group are not as quick as I would have hoped.
> 
> - It's not the efficiency of encode_fattr() that is the issue,
>   it's the frequency of its use. That's something the server
>   can't do much about.

There probably needs a protocol revision to improve this.  I imagine a
GETATTR request including a CTIME value with the implication that if the
CTIME hasn't changed, then there is no need to return any attributes.

> 
> 
> > With the current code we could easily annotate that if we
> > wanted to and thought (or measured) there was any value.  With the
> > looping code we cannot really annotate the likelihood of each.
> 
> Nope, likelihood annotation isn't really possible with a bitmask
> loop. But my understanding is that unlikely() means really
> really really unlikely, as in "this code is an error case that
> is almost never used". And that's not actually the case for most
> of these attributes.

My understanding of unlikely() (which is largely compatible with yours)
is that it tells the compile to pessimise code dependant on the
condition being true.  Or more accurately: when there is an optimisation
trade off between code for the 'true' case and any other code, preference
the other code.
So it is definitely good to say errors are unlikely, because there is no
need to optimise for them.  You might also say a fast-path condition is
likely() because that path is more worthy of optimisation.

> 
> 
> > The code-generation idea is intriguing.  Even if we didn't reach that
> > goal, having the code highly structured as though it were auto-generated
> > would be no bad thing.
> 
> Maybe it just calms my yearning for an ordered universe to deal
> with these attributes in the same way that we deal with COMPOUND
> operations.

There are worse reasons for refactoring code:-)

Thanks,
NeilBrown

> 
> I appreciate the review!
> 
> 
> --
> Chuck Lever
> 
> 
> 

