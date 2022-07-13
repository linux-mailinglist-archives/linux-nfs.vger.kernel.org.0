Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FE6572CA3
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Jul 2022 06:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbiGMEdD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Jul 2022 00:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbiGMEcx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Jul 2022 00:32:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2371BBA4
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 21:32:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2BD46339D2;
        Wed, 13 Jul 2022 04:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657686769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vq6bO1/RiyDOOcgobMrTfE6Y/uyiLQZdvTMUfz/ZiRI=;
        b=bFuxJ3RkKMDVVKZhNYjVEd7xgf+RKrxRR+ychFiia1M8gagSmieX4UbjV+/hKz/G8g88VY
        WbhMOgcZfhJjXPLJVzBPHbqSt4YWryYFGAF4/CjiN0yV0Gr9kJ6KYCAYF1gN0uGD0qxsBC
        hhEkHH99CFxBNhCKGDjyRuF85/C+a2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657686769;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vq6bO1/RiyDOOcgobMrTfE6Y/uyiLQZdvTMUfz/ZiRI=;
        b=XizwJyeBNfV99Yh6k0Q6D8FDZYPYu7tInsHI4JRr31S34O6MhJEcH4BTpPRSajho+2kpTV
        3lwEIS03MoeAZfAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1BD5813754;
        Wed, 13 Jul 2022 04:32:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id q5HtMu9KzmK5YgAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 13 Jul 2022 04:32:47 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/8] NFSD: clean up locking.
In-reply-to: <3C945625-ED72-4CC1-9CC0-F354FEF0C2E4@oracle.com>
References: <165708033167.1940.3364591321728458949.stgit@noble.brown>,
 <3FF88D5A-9DBF-4115-A31C-6C6A888F272F@oracle.com>,
 <165759318889.25184.8939985512802350340@noble.neil.brown.name>,
 <3C945625-ED72-4CC1-9CC0-F354FEF0C2E4@oracle.com>
Date:   Wed, 13 Jul 2022 14:32:44 +1000
Message-id: <165768676476.25184.1334928545636067316@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 13 Jul 2022, Chuck Lever III wrote:
> 
> > On Jul 11, 2022, at 10:33 PM, NeilBrown <neilb@suse.de> wrote:
> > 
> > On Thu, 07 Jul 2022, Chuck Lever III wrote:
> >> 
> >>> On Jul 6, 2022, at 12:18 AM, NeilBrown <neilb@suse.de> wrote:
> >>> 
> >>> This series prepares NFSD to be able to adjust to work with a proposed
> >>> patch which allows updates to directories to happen in parallel.
> >>> This patch set changes the way directories are locked, so the present
> >>> series cleans up some locking in nfsd.
> >>> 
> >>> Specifically we remove fh_lock() and fh_unlock().
> >>> These functions are problematic for a few reasons.
> >>> - they are deliberately idempotent - setting or clearing a flag
> >>> so that a second call does nothing. This makes locking errors harder,
> >>> but it results in code that looks wrong ... and maybe sometimes is a
> >>> little bit wrong.
> >>> Early patches clean up several places where this idempotent nature of
> >>> the functions is depended on, and so makes the code clearer.
> >>> 
> >>> - they transparently call fh_fill_pre/post_attrs(), including at times
> >>> when this is not necessary. Having the calls only when necessary is
> >>> marginally more efficient, and arguably makes the code clearer.
> >>> 
> >>> nfsd_lookup() currently always locks the directory, though often no lock
> >>> is needed. So a patch in this series reduces this locking.
> >>> 
> >>> There is an awkward case that could still be further improved.
> >>> NFSv4 open needs to ensure the file is not renamed (or unlinked etc)
> >>> between the moment when the open succeeds, and a later moment when a
> >>> "lease" is attached to support a delegation. The handling of this lock
> >>> is currently untidy, particularly when creating a file.
> >>> It would probably be better to take a lease immediately after
> >>> opening the file, and then discarding if after deciding not to provide a
> >>> delegation.
> >>> 
> >>> I have run fstests and cthon tests on this, but I wouldn't be surprised
> >>> if there is a corner case that I've missed.
> >> 
> >> Hi Neil, thanks for (re)posting.
> >> 
> >> Let me make a few general comments here before I send out specific
> >> review nits.
> >> 
> >> I'm concerned mostly with how this series can be adequately tested.
> >> The two particular areas I'm worried about:
> >> 
> >> - There are some changes to NFSv2 code, which is effectively
> >> fallow. I think I can run v2 tests, once we decide what tests
> >> should be run.
> > 
> > I hope we can still test v2... I know it is disabled by default..
> > If we can't test it, we should consider removing it.
> 
> The work of deprecating and removing NFSv2 is already under way.
> I think what I'm asking is if /you/ have tested the NFSv2 changes.

That's a question I can answer.  I haven't.  I will.

> 
> 
> >> Secondarily, the series adds more bells and whistles to the generic
> >> NFSD VFS APIs on behalf of NFSv4-specific requirements. In particular:
> >> 
> >> - ("NFSD: change nfsd_create() to unlock directory before returning.")
> >> makes some big changes to nfsd_create(). But that helper itself
> >> is pretty small. Seems like cleaner code would result if NFSv4
> >> had its own version of nfsd_create() to deal with the post-change
> >> cases.
> > 
> > I would not like that approach. Duplicating code is rarely a good idea.
> 
> De-duplicating code /can/ be a good idea, but isn't always a good
> idea. If the exceptional cases add a lot of logic, that can make the
> de-duplicated code difficult to read and reason about, and it can
> make it brittle, just as it does in this case. Modifications on
> behalf of NFSv4 in this common piece of code is possibly hazardous
> to NFSv3, and navigating around the exception logic makes it
> difficult to understand and review.

Are we looking at the same code?
The sum total of extra code needed for v4 is:
- two extra parameters:
	    void (*post_create)(struct svc_fh *fh, void *data),
	    void *data)
- two lines of code:
	if (!err && post_create)
		post_create(resfhp, data);

does that really make anything hard to follow?

> 
> IMO code duplication is not an appropriate design pattern in this
> specific instance.

I'm guessing there is a missing negation in there.

> 
> 
> > Maybe, rather than passing a function and void* to nfsd_create(), we
> > could pass an acl and a label and do the setting in vfs.c rather then
> > nfs4proc.c. The difficult part of that approach is getting back the
> > individual error statuses. That should be solvable though.
> 
> The bulk of the work in nfsd_create() is done by lookup_one_len()
> and nfsd_create_locked(), both of which are public APIs. The rest
> of nfsd_create() is code that appears in several other places
> already.

"several" == 1.  The only other call site for nfsd_create_locked() is in
nfsd_proc_create()

I would say that the "bulk" of the work is the interplay between
locking, error checking, and these two functions you mention.

> 
> 
> >> - ("NFSD: reduce locking in nfsd_lookup()") has a similar issue:
> >> nfsd_lookup() is being changed such that its semantics are
> >> substantially different for NFSv4 than for others. This is
> >> possibly an indication that nfsd_lookup() should also be
> >> duplicated into the NFSv4-specific code and the generic VFS
> >> version should be left alone.
> > 
> > Again, I don't like duplication. In this case, I think the longer term
> > solution is to remove the NFSv4 specific locking differences and solve
> > the problem differently. i.e. don't hold the inode locked, but check
> > for any possible rename after getting a lease. Once that is done,
> > nfsd_lookup() can have saner semantics.
> 
> Then, perhaps we should bite that bullet and do that work now.

While this does have an appeal, it also looks like the start of a rabbit
hole where I find have to fix up a growing collection of problems before
my patch can land.
I think balance is needed - certainly asking for some preliminary
cleanup is appropriate.  Expecting long standing and subtle issues that
are tangential to the main goal to be resolved first is possibly asking
too much.

NeilBrown


> 
> 
> >> I would prefer the code duplication approach in both these cases,
> >> unless you can convince me that is a bad idea.
> > 
> > When duplicating code results in substantial simplification in both
> > copies, then it makes sense. Otherwise I think the default should be
> > not to duplicate.
> 
> I believe that duplicating in both cases above will result in
> simpler and less brittle code. That's why I asked for it.
> 
> --
> Chuck Lever
> 
> 
> 
> 
