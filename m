Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250CC5F4B29
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Oct 2022 23:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiJDVuf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Oct 2022 17:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiJDVue (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Oct 2022 17:50:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DA02494C
        for <linux-nfs@vger.kernel.org>; Tue,  4 Oct 2022 14:50:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 094CD218F6;
        Tue,  4 Oct 2022 21:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664920231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m0ffdG/vpUERyNyzIjsVbBHb9RKT7gYVaL/pzV3nVtw=;
        b=swPntCEnbVlqnWGJ0cz+iHWvoHAeRUJHu6JfTM5yT7c1WGd89O5yJC87A1r53GHZ6AMGvO
        YXfazlR3Du7xLYVYh+esThyXkbkxoWv2e9ZXpsiTguuAf+zsvzpeGJjvAcZftRVKNIAeQg
        mUbdIjesH+6xn++EEJY4vWabXvCPqD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664920231;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m0ffdG/vpUERyNyzIjsVbBHb9RKT7gYVaL/pzV3nVtw=;
        b=tz/5Kj7d4VpDXaCfrwQIcDnikGiIQXNfFgO8F1PMlSYbrg616896QHtlpYW3x/BHs5I9hr
        vI6HfQ1ErOuzSlDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B9388139EF;
        Tue,  4 Oct 2022 21:50:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qpHhGqWqPGPwHwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 04 Oct 2022 21:50:29 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Chuck Lever" <chuck.lever@oracle.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: nfsd: another possible delegation race
In-reply-to: <fb9c520e8bd9a034eeb10285c03dcf5cd6a660c9.camel@kernel.org>
References: <166486048770.14457.133971372966856907@noble.neil.brown.name>,
 <fb9c520e8bd9a034eeb10285c03dcf5cd6a660c9.camel@kernel.org>
Date:   Wed, 05 Oct 2022 08:50:25 +1100
Message-id: <166492022529.14457.275175334319273969@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 04 Oct 2022, Jeff Layton wrote:
> On Tue, 2022-10-04 at 16:14 +1100, NeilBrown wrote:
> > Hi,
> >  I have a customer who experienced a crash in nfsd which appears to be
> >  related to delegation return.  I cannot completely rule-out
> >   Commit 548ec0805c39 ("nfsd: fix use-after-free due to delegation race")
> >  as the kernel being used didn't have that commit, but the symptoms are
> >  quite different, and while exploring I found, I think, a different
> >  race.  This new race doesn't obviously address all the symptoms, but
> >  maybe it does...
> > 
> >  The symptoms were:
> >   1/   WARN_ON(!unhash_delegation_locked(dp));
> >     in nfs4_laundromat complained (delegation wasn't hashed!)
> >   2/   refcount_t: saturated; leaking memory
> >     This came from the refcount_inc in revoke_delegation() called from
> >     nfs4_laundromat(), a few lines below the above warning
> 
> Well, that is odd! Chuck has caught this a couple of times:
> 
>     https://bugzilla.linux-nfs.org/show_bug.cgi?id=394
> 
> ...but that's an underflow.

https://bugzilla.redhat.com/show_bug.cgi?id=2127067
linked in that bugzilla looks like exactly the same problem, though
caught at a different place by KASAN.

I would think there must have been a previous underflow - after that all
further references cause the "saturation" warning.  Except that the
dmesg in the crashdump has 123 hours of logs and no other refcount_t
message.  Maybe I shouldn't lose sleep over this...

> 
> >   3/ BUG: kernel NULL pointer dereference, address: 0000000000000028
> >      This is from the destroy_unhashed_deleg() call at the end of
> >      that same revoke_delegation() call, which calls
> >      nfs4_unlock_deleg_lease() and passes fp->fi_deleg_file, which is
> >      NULL (!!!), to vfs_setlease().
> >   These three happened in a 200usec window.
> > 
> >  What I imagine might be happening is that the nfsd_break_deleg_cb()
> >  callback is called after destroy_delegation() has unhashed the deleg,
> >  but before destroy_unhashed_delegation() gets called.
> > 
> 
> Ok, so a DELEGRETURN is racing with a lease break?

Exactly my assessment - yes.


> 
> >  If nfsd_break_deleg_cb() is called before the unhash - and particularly
> >  if nfsd_break_one_deleg()->nfsd4_run_cb() is called before, then the
> >  unhash will disconnect the delegation from the recall list, and no
> >  harm can be done.
> >  Once vfs_setlease(F_UNLCK) is called, the callback can no longer be
> >  called, so again no harm is possible.
> > 
> >  Between these two is a race window.  The delegation can be put on the
> >  recall list, but the deleg will be unhashed and put_deleg_file() will
> >  have set fi_deleg_file to NULL - resulting in first WARNING and the
> >  BUG.
> > 
> >  I cannot see how the refcount_t warning can be generated ...  so maybe
> >  I've missed something.
> > 
> >  My proposed solution is to test delegation_hashed() while holding
> >  fp->fi_lock in nfsd_break_deleg_cb().  If the delegation is locked, we
> >  can safely schedule the recall.  If it isn't, then the lease is about
> >  to be unlocked and there is no need to schedule anything.
> > 
> 
> I think you mean "If the delegation is hashed, we can safely schedule
> the recall."

Yes s/locked/hashed/  :-)

> 
> That sounds like it might be the right approach. Once we've unhashed the
> stateid, I think we can safely assume that it's on its way out the door
> and that we don't need to issue a recall.
> 
> >  I don't know this code at all well, so I thought it safest to ask for
> >  comments before posting a proper patch.
> >  I'm particularly curious to know if anyone has ideas about the refcount
> >  overflow.  Corruption is unlikely as the deleg looked mostly OK and the
> >  memory has been freed, but not reallocated (though it is possible it
> >  was freed, reallocated, and freed again).
> >  This wasn't a refcount_inc on a zero refcount - that gives a different
> >  error.  I don't know what the refcount value was, it has already been
> >  changed to the 'saturated' value - 0xc0000000.
> > 
> > 
> 
> That would be this, I think:
> 
>         else if (unlikely(old < 0 || old + i < 0))
>                 refcount_warn_saturate(r, REFCOUNT_ADD_OVF);
> 
> So the old or new value was < 0?
> 
> No idea how you get there though. I would think if we were leaking
> delegations to that degree that we'd see leaked memory warnings when
> shutting down nfsd.

I'm certain the refcount did get to zero at some point because the
nfsd_deleg has been freed.  But the refcount code should never set it
negative without reporting a warning.


> 
> > 
> > 
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index c5d199d7e6b4..e02d638df6be 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -4822,8 +4822,10 @@ nfsd_break_deleg_cb(struct file_lock *fl)
> >  	fl->fl_break_time = 0;
> >  
> >  	spin_lock(&fp->fi_lock);
> > -	fp->fi_had_conflict = true;
> > -	nfsd_break_one_deleg(dp);
> > +	if (delegation_hashed(dp)) {
> > +		fp->fi_had_conflict = true;
> > +		nfsd_break_one_deleg(dp);
> > +	}
> >  	spin_unlock(&fp->fi_lock);
> >  	return ret;
> >  }
> > 
> > 
> 
> This looks reasonable to me.

Thanks!
NeilBrown
