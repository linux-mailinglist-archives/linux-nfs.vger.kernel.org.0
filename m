Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987D260BEDE
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Oct 2022 01:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiJXXpD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Oct 2022 19:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiJXXoj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Oct 2022 19:44:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670C52E983C
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 15:02:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EDDCF1F8A6;
        Mon, 24 Oct 2022 22:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666648934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LN4T/hNI2TwxRnn5A/c28n8nPFy3m1L0QPzePBqNW10=;
        b=C5zHk8Czq1DSog8OHaRuvXNLpc/ajS9H5i92G/vFn9gLjcXn7oZGhq+BwEOB0jHc+Yf3kK
        wCKgxugD50AWmupnTXugmeu4V2a8w8y9O7dYPQC9czUP1p7kt6mYpHglIiUuuACjQrAWJV
        hHASghg1ZNabfLl/yQR6FjyOYtrF15c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666648934;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LN4T/hNI2TwxRnn5A/c28n8nPFy3m1L0QPzePBqNW10=;
        b=5Xy6i4QTU074zUdbuRjRTDTTzGqRP8MW64vA0c4//urb8i4CRhCT1SJdRSBBMK8TFl5lJd
        mhficKSquPLgHoCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 032A513A79;
        Mon, 24 Oct 2022 22:02:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lY0GKmULV2OOfgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 24 Oct 2022 22:02:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 5/7] NFSD: Use rhashtable for managing nfs4_file objects
In-reply-to: <51A1D02F-4BD7-4AA4-AB5A-6962D8708122@oracle.com>
References: <166612295223.1291.11761205673682408148.stgit@manet.1015granger.net>,
 <166612313084.1291.5764156173845222109.stgit@manet.1015granger.net>,
 <166658201312.12462.15430126129561479021@noble.neil.brown.name>,
 <51A1D02F-4BD7-4AA4-AB5A-6962D8708122@oracle.com>
Date:   Tue, 25 Oct 2022 09:02:10 +1100
Message-id: <166664893048.12462.2026765054120312799@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 25 Oct 2022, Chuck Lever III wrote:
> 
> > On Oct 23, 2022, at 11:26 PM, NeilBrown <neilb@suse.de> wrote:
> > 
> > On Wed, 19 Oct 2022, Chuck Lever wrote:
> >> +/*
> >> + * The returned hash value is based solely on the address of an in-code
> >> + * inode, a pointer to a slab-allocated object. The entropy in such a
> >> + * pointer is concentrated in its middle bits.
> >> + */
> >> +static u32 nfs4_file_inode_hash(const struct inode *inode, u32 seed)
> >> +{
> >> +	u32 k;
> >> +
> >> +	k = ((unsigned long)inode) >> L1_CACHE_SHIFT;
> >> +	return jhash2(&k, 1, seed);
> > 
> > I still don't think this makes any sense at all.
> > 
> >        return jhash2(&inode, sizeof(inode)/4, seed);
> > 
> > uses all of the entropy, which is best for rhashtables.
> 
> I don't really disagree, but the L1_CACHE_SHIFT was added at
> Al's behest. OK, I'll replace it.

I think that was in a different context though.

If you are using a simple fixed array of bucket-chains for a hash
table, then shifting down L1_CACHE_SHIFT and masking off the number of
bits to match the array size is a perfectly sensible hash function.  It
will occasionally produce longer chains, but no often.

But rhashtables does something a bit different.  It mixes a seed into
the key as part of producing the hash, and assumes that if an
unfortunate distribution of keys results is a substantially non-uniform
distribution into buckets, then choosing a new random seed will
re-distribute the keys into buckets and will probably produce a more
uniform distribution.

The purpose of this seed is (as I understand it) primarily focused on
network-faced hash tables where an attacker might be able to choose keys
that all hash to the same value.  The random seed will defeat the
attacker.

When hashing inodes there is no opportunity for a deliberate attack, and
we would probably be happy to not use a seed and accept the small
possibility of occasional long chains.  However the rhashtable code
doesn't offer us that option.  It insists on rehashing if any chain
exceeds 16.  So we need to provide a much entropy as we can, and mix the
seed in as effectively as we can, to ensure that rehashing really works.

> >> +static int nfs4_file_obj_cmpfn(struct rhashtable_compare_arg *arg,
> >> +			       const void *ptr)
> >> +{
> >> +	const struct svc_fh *fhp = arg->key;
> >> +	const struct nfs4_file *fi = ptr;
> >> +
> >> +	return fh_match(&fi->fi_fhandle, &fhp->fh_handle) ? 0 : 1;
> >> +}
> > 
> > This doesn't make sense.  Maybe the subtleties of rhl-tables are a bit
> > obscure.
> > 
> > An rhltable is like an rhashtable except that insertion can never fail. 
> > Multiple entries with the same key can co-exist in a linked list.
> > Lookup does not return an entry but returns a linked list of entries.
> > 
> > For the nfs4_file table this isn't really a good match (though I
> > previously thought it was).  Insertion must be able to fail if an entry
> > with the same filehandle exists.
> 
> I think I've arrived at the same conclusion (about nfs4_file insertion
> needing to fail for duplicate filehandles). That's more or less open-coded
> in my current revision of this work rather than relying on the behavior
> of rhltable_insert().
> 
> 
> > One approach that might work would be to take the inode->i_lock after a
> > lookup fails then repeat the lookup and if it fails again, do the
> > insert.  This keeps the locking fine-grained but means we don't have to
> > depend on insert failing.
> > 
> > So the hash and cmp functions would only look at the inode pointer.
> > If lookup returns something, we would walk the list calling fh_match()
> > to see if we have the right entry - all under RCU and using
> > refcount_inc_not_zero() when we find the matching filehandle.
> 
> That's basically what's going on now. But I tried removing obj_cmpfn()
> and the rhltable_init() failed outright, so it's still there like a
> vestigial organ.

You need an obj_cmpfn if you have an obj_hashfn.  If you don't have
obj_hashfn and just provide hashfn and key_len, then you don't need the
cmpfn.

If you have a cmpfn, just compare the inode (the same thing that you
hash) - don't compare the file handle.

> 
> If you now believe rhltable is not a good fit, I can revert all of the
> rhltable changes and go back to rhashtable quite easily.

I wasn't very clear, as I was still working out what I though.

I think an rhashtable cannot work as you need two different keys, the
inode and the filehandle.

I think rhltable can work but it needs help, particularly as it will
never fail an insertion.
The help we can provide is to take a lock, perform a lookup, then only
try to insert if the lookup failed (and we are still holding an
appropriate lock to stop another thread inserting).  Thus any time we
try an insert, we don't want it to fail.

The lock I suggest is ->i_lock in the inode.

The rhltable should only consider the inode as a key, and should provide
a linked list of nfs4_files with the same inode.
We then code a linear search of this linked list (which is expected to
have one entry) to find if there is an entry with the required file
handle.


An alternative is to not use a resizable table at all.  We could stick
with the table we currently have and make small changes.

1/ change the compare function to test the inode pointer first and only
   call fh_match when the inodes match.  This should make it much
   faster.
2/ Instead of using state_lock for locking, use a bit-spin-lock on the
   lsb of the bucket pointers in the array to lock each bucket.  This
   will substantially reduce locking conflicts.

I don't see a big performance difference between this approach and the
rhltable approach.  It really depends which you would feel more
comfortable working with.  Would you rather work with common code which
isn't quite a perfect fit, or with private code that you have complete
control over?

Thanks,
NeilBrown
