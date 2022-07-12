Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA00E57103A
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Jul 2022 04:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiGLCdU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Jul 2022 22:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiGLCdS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Jul 2022 22:33:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1AC3336E
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jul 2022 19:33:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 23C981FD58;
        Tue, 12 Jul 2022 02:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657593196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gXf4VbqilHrkFDVZuzTK6F2mYXBTOrBuMu22aV5W66E=;
        b=1GxcujeSSgU9L9PSehcvTQhmb289SPWdFpe6rXNs5sYzTALGP8UBMrGCy/BaPNicBGxP0m
        8N1sx0Yogwwhxgii2SWtBS3y34rvMDheUno5A0BHbbVKNMCQiqjG2sidKYk5cLhGvm9kpE
        MKWadKX0qIrhXta/XGskHhdbi1FkZho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657593196;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gXf4VbqilHrkFDVZuzTK6F2mYXBTOrBuMu22aV5W66E=;
        b=qDc8idYgVA9EDZ2NL0DeKWHQFu48AD7toNxaB8jiw7z2lJDTddBZUbyUBpccjn5z/dvpfe
        RAdOMnT4/kWYs3DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0A9B413322;
        Tue, 12 Jul 2022 02:33:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RYogLmrdzGK6NAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 12 Jul 2022 02:33:14 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/8] NFSD: clean up locking.
In-reply-to: <3FF88D5A-9DBF-4115-A31C-6C6A888F272F@oracle.com>
References: <165708033167.1940.3364591321728458949.stgit@noble.brown>,
 <3FF88D5A-9DBF-4115-A31C-6C6A888F272F@oracle.com>
Date:   Tue, 12 Jul 2022 12:33:08 +1000
Message-id: <165759318889.25184.8939985512802350340@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 07 Jul 2022, Chuck Lever III wrote:
> 
> > On Jul 6, 2022, at 12:18 AM, NeilBrown <neilb@suse.de> wrote:
> > 
> > This series prepares NFSD to be able to adjust to work with a proposed
> > patch which allows updates to directories to happen in parallel.
> > This patch set changes the way directories are locked, so the present
> > series cleans up some locking in nfsd.
> > 
> > Specifically we remove fh_lock() and fh_unlock().
> > These functions are problematic for a few reasons.
> > - they are deliberately idempotent - setting or clearing a flag
> >  so that a second call does nothing.  This makes locking errors harder,
> >  but it results in code that looks wrong ...  and maybe sometimes is a
> >  little bit wrong.
> >  Early patches clean up several places where this idempotent nature of
> >  the functions is depended on, and so makes the code clearer.
> > 
> > - they transparently call fh_fill_pre/post_attrs(), including at times
> >  when this is not necessary.  Having the calls only when necessary is
> >  marginally more efficient, and arguably makes the code clearer.
> > 
> > nfsd_lookup() currently always locks the directory, though often no lock
> > is needed.  So a patch in this series reduces this locking.
> > 
> > There is an awkward case that could still be further improved.
> > NFSv4 open needs to ensure the file is not renamed (or unlinked etc)
> > between the moment when the open succeeds, and a later moment when a
> > "lease" is attached to support a delegation.  The handling of this lock
> > is currently untidy, particularly when creating a file.
> > It would probably be better to take a lease immediately after
> > opening the file, and then discarding if after deciding not to provide a
> > delegation.
> > 
> > I have run fstests and cthon tests on this, but I wouldn't be surprised
> > if there is a corner case that I've missed.
> 
> Hi Neil, thanks for (re)posting.
> 
> Let me make a few general comments here before I send out specific
> review nits.
> 
> I'm concerned mostly with how this series can be adequately tested.
> The two particular areas I'm worried about:
> 
>  - There are some changes to NFSv2 code, which is effectively
>    fallow. I think I can run v2 tests, once we decide what tests
>    should be run.

I hope we can still test v2... I know it is disabled by default..
If we can't test it, we should consider removing it.

> 
>  - More critically, ("NFSD: reduce locking in nfsd_lookup()") does
>    some pretty heavy lifting. How should this change be tested?

I don't see how there can be any answer other than "run all the tests we
usually run".  lockdep should report any locking strangeness.

> 
> Secondarily, the series adds more bells and whistles to the generic
> NFSD VFS APIs on behalf of NFSv4-specific requirements. In particular:
> 
>  - ("NFSD: change nfsd_create() to unlock directory before returning.")
>    makes some big changes to nfsd_create(). But that helper itself
>    is pretty small. Seems like cleaner code would result if NFSv4
>    had its own version of nfsd_create() to deal with the post-change
>    cases.

I would not like that approach.  Duplicating code is rarely a good idea.
Maybe, rather than passing a function and void* to nfsd_create(), we
could pass an acl and a label and do the setting in vfs.c rather then
nfs4proc.c.  The difficult part of that approach is getting back the
individual error statuses.   That should be solvable though.

> 
>  - ("NFSD: reduce locking in nfsd_lookup()") has a similar issue:
>    nfsd_lookup() is being changed such that its semantics are
>    substantially different for NFSv4 than for others. This is
>    possibly an indication that nfsd_lookup() should also be
>    duplicated into the NFSv4-specific code and the generic VFS
>    version should be left alone.

Again, I don't like duplication.  In this case, I think the longer term
solution is to remove the NFSv4 specific locking differences and solve
the problem differently.  i.e.  don't hold the inode locked, but check
for any possible rename after getting a lease.  Once that is done,
nfsd_lookup() can have saner semantics.

> 
> I would prefer the code duplication approach in both these cases,
> unless you can convince me that is a bad idea.

When duplicating code results in substantial simplification in both
copies, then it makes sense.  Otherwise I think the default should be
not to duplicate.

Thanks,
NeilBrown


> 
> Finally, with regard to the awkward case you mention above. The
> NFSv4 OPEN code is a hairy mess, mostly because the protocol is
> a Swiss army knife and our implementation has had small fixes
> plastered onto it for many years. I won't be disappointed if
> you don't manage to address the rename/unlink/delegation race
> you mention above this time around. Just don't make it worse ;-)
> 
> Meanwhile we should start accruing some thoughts and designs
> about how this code path needs to work.
> 
> 
> > NeilBrown
> > 
> > 
> > ---
> > 
> > NeilBrown (8):
> >      NFSD: drop rqstp arg to do_set_nfs4_acl()
> >      NFSD: change nfsd_create() to unlock directory before returning.
> >      NFSD: always drop directory lock in nfsd_unlink()
> >      NFSD: only call fh_unlock() once in nfsd_link()
> >      NFSD: reduce locking in nfsd_lookup()
> >      NFSD: use explicit lock/unlock for directory ops
> >      NFSD: use (un)lock_inode instead of fh_(un)lock for file operations
> >      NFSD: discard fh_locked flag and fh_lock/fh_unlock
> > 
> > 
> > fs/nfsd/nfs2acl.c   |   6 +-
> > fs/nfsd/nfs3acl.c   |   4 +-
> > fs/nfsd/nfs3proc.c  |  21 ++---
> > fs/nfsd/nfs4acl.c   |  19 ++---
> > fs/nfsd/nfs4proc.c  | 106 +++++++++++++++---------
> > fs/nfsd/nfs4state.c |   8 +-
> > fs/nfsd/nfsfh.c     |   3 +-
> > fs/nfsd/nfsfh.h     |  56 +------------
> > fs/nfsd/nfsproc.c   |  14 ++--
> > fs/nfsd/vfs.c       | 193 ++++++++++++++++++++++++++------------------
> > fs/nfsd/vfs.h       |  19 +++--
> > 11 files changed, 238 insertions(+), 211 deletions(-)
> > 
> > --
> > Signature
> > 
> 
> --
> Chuck Lever
> 
> 
> 
> 
