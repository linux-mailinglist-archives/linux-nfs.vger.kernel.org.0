Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B4A5FBE73
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Oct 2022 01:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiJKXhj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Oct 2022 19:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJKXhh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Oct 2022 19:37:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360046FA34
        for <linux-nfs@vger.kernel.org>; Tue, 11 Oct 2022 16:37:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7B7B8210E0;
        Tue, 11 Oct 2022 23:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1665531449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=io2/GDW2Qi4yEaBxt24MdP1MPoB/Z/U0aTRRxVy1XfI=;
        b=TQDHfaFxKQbxyBoGLCzT+5I/WqK1s3X7gNRCBagbnxwxGguCylbYLmpdv4fSlQsjaQ5jqQ
        6fR5dhWR2FjNa0EJuqWzEnv4qieJ/Bc8JQP45PVg0a4mwuXJ6FuuJiKlBTibIjFJPSCp98
        61PBYjY3rfWSK+91dFkTJc3qRCE/zdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1665531449;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=io2/GDW2Qi4yEaBxt24MdP1MPoB/Z/U0aTRRxVy1XfI=;
        b=UGSfdYDjAzoLKol6+F70brgacvoDVgjen397CjZK+0hx/+HYoQ7emuKV64KOpvsCTm6snz
        KJOE6mTKi2RaKCCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8D51413AAC;
        Tue, 11 Oct 2022 23:37:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id veB9EDj+RWNUGwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 11 Oct 2022 23:37:28 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 7/9] NFSD: Use rhashtable for managing nfs4_file objects
In-reply-to: <EB08B095-BF02-4B5E-8CD2-12B0201328D2@oracle.com>
References: <166507275951.1802.13184584115155050247.stgit@manet.1015granger.net>,
 <166507324882.1802.884870684212914640.stgit@manet.1015granger.net>,
 <166544739751.14457.9018300177489236723@noble.neil.brown.name>,
 <EB08B095-BF02-4B5E-8CD2-12B0201328D2@oracle.com>
Date:   Wed, 12 Oct 2022 10:37:24 +1100
Message-id: <166553144435.32740.14940127200777208215@noble.neil.brown.name>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 11 Oct 2022, Chuck Lever III wrote:
> > On Oct 10, 2022, at 8:16 PM, NeilBrown <neilb@suse.de> wrote:
> > 
> > On Fri, 07 Oct 2022, Chuck Lever wrote:
> >> 
> >> -static unsigned int file_hashval(struct svc_fh *fh)
> >> +/*
> >> + * The returned hash value is based solely on the address of an in-code
> >> + * inode, a pointer to a slab-allocated object. The entropy in such a
> >> + * pointer is concentrated in its middle bits.
> > 
> > I think you need more justification than that for throwing away some of
> > the entropy, even if you don't think it is much.
> 
> We might have that justification:
> 
> https://lore.kernel.org/linux-nfs/YrUFbLJ5uVbWtZbf@ZenIV/
> 
> Actually I believe we are not discarding /any/ entropy in
> this function. The bits we discard are invariant.
> 

Ok, I can accept that this:

+	k = ptr >> L1_CACHE_SHIFT;

only discards invariant bits, but how can you justify this:

+	k &= 0x00ffffff;

??

And given that you pass it all to jhash anyway, why not just pass all of
it?


> And, note that this is exactly the same situation we just merged
> in the filecache overhaul, and is a common trope amongst other
> hash tables that base their function on the inode's address.
> 
> 
> > Presumably you think hashing 32 bits is faster than hashing 64 bits.
> > Maybe it is, but is it worth it?
> > 
> > rhashtable depends heavily on having a strong hash function.  In
> > particular if any bucket ends up with more than 16 elements it will
> > choose a new seed and rehash.  If you deliberately remove some bits that
> > it might have been used to spread those 16 out, then you are asking for
> > trouble.
> > 
> > We know that two different file handles can refer to the same inode
> > ("rarely"), and you deliberately place them in the same hash bucket.
> > So if an attacker arranges to access 17 files with the same inode but
> > different file handles, then the hashtable will be continuously
> > rehashed.
> > 
> > The preferred approach when you require things to share a hash chain is
> > to use an rhl table.
> 
> Again, this is the same situation for the filecache. Do you
> believe it is worth reworking that? I'm guessing "yes".

As a matter of principle: yes.
rhashtable is designed to assume that hash collisions are bad and can be
changed by choosing a different seed.
rhl_tables was explicitly added for cases when people wanted multiple
elements to hash to the same value.

The chance of it causing a problem without an attack are admittedly
tiny.  Attacks are only possible with subtree_check enabled, or if the
underlying filesystem does something "clever" with file handles, so
there wouldn't be many situations where an attack would even be
possible.  But if it were possible, it would likely be easy.
The cost of the attack would be a minor-to-modest performance impact.

So it is hard to argue "this code is dangerous and must be changed", but
we have different tools for a reason, and I believe that rhl-tables is
the right tool for this job.

> 
> 
> > This allows multiple instances with the same key.
> > You would then key the rhl-table with the inode, and search a
> > linked-list to find the entry with the desired file handle.  This would
> > be no worse in search time than the current code for aliased inodes, but
> > less susceptible to attack.
> > 
> >> +/**
> >> + * nfs4_file_obj_cmpfn - Match a cache item against search criteria
> >> + * @arg: search criteria
> >> + * @ptr: cache item to check
> >> + *
> >> + * Return values:
> >> + *   %0 - Item matches search criteria
> >> + *   %1 - Item does not match search criteria
> > 
> > I *much* prefer %-ESRCH for "does not match search criteria".  It is
> > self-documenting.  Any non-zero value will do.
> 
> Noted, but returning 1 appears to be the typical arrangement for
> existing obj_cmpfn methods in most other areas.

Some people have no imagination :-)

[Same argument could be used against implementing kernel modules in Rust
 - Using C appears to be the typical arrangement for existing modules)

Thanks,
NeilBrown

