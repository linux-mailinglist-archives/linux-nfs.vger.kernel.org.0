Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08078569762
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Jul 2022 03:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiGGB0p (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jul 2022 21:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiGGB0o (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jul 2022 21:26:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B534E2E9C7
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jul 2022 18:26:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6C456220B3;
        Thu,  7 Jul 2022 01:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657157202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JZtkhwvN36cFd3OVjSt086reYrmdEnLJYMzEhvrkOrI=;
        b=MIeiEpb1HgaBJeecoPPUMHdzI5C7J2yyoY+l/idFyurqafAEOofaGipQ50bdxjweO8rFIF
        jSxvL34O6WjbE+sROYHbH83c6XUbw7WCXOlrKWZvNW342AFo3FsgAh5wmrC17a/yQioP4v
        yIeNDdP5Lb6aAkV68YJ5jhp8CzzAoZQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657157202;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JZtkhwvN36cFd3OVjSt086reYrmdEnLJYMzEhvrkOrI=;
        b=1v4nzawvfXJAHxeE8MW7QNK9Fdw8UrsDrdthJza9q9jjHPGsadaur8u/JS4fMjRrZV8zUp
        /33lFRuMRD3Of5DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 50A9E13A7D;
        Thu,  7 Jul 2022 01:26:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aPZ8A1E2xmJlXwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 07 Jul 2022 01:26:41 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 5/8] NFSD: reduce locking in nfsd_lookup()
In-reply-to: <9e62ac672697225ac1859cac2c0cd58665d7b4fb.camel@kernel.org>
References: <165708033167.1940.3364591321728458949.stgit@noble.brown>,
 <165708109258.1940.1095066282860556838.stgit@noble.brown>,
 <9e62ac672697225ac1859cac2c0cd58665d7b4fb.camel@kernel.org>
Date:   Thu, 07 Jul 2022 11:26:38 +1000
Message-id: <165715719815.17141.11997557184323519099@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 06 Jul 2022, Jeff Layton wrote:
> On Wed, 2022-07-06 at 14:18 +1000, NeilBrown wrote:
> > nfsd_lookup() takes an exclusive lock on the parent inode, but many
> > callers don't want the lock and may not need to lock at all if the
> > result is in the dcache.
> > 
> > Change nfsd_lookup() to be passed a bool flag.
> > If false, don't take the lock.
> > If true, do take an exclusive lock, and return with it held if
> > successful.
> > If nfsd_lookup() returns an error, the lock WILL NOT be held.
> > 
> > Only nfsd4_open() requests the lock to be held, and does so to block
> > rename until it decides whether to return a delegation.
> > 
> > NOTE: when nfsd4_open() creates a file, the directory does *NOT* remain
> >   locked and never has.  So it is possible (though unlikely) for the
> >   newly created file to be renamed before a delegation is handed out,
> >   and that would be bad.  This patch does *NOT* fix that, but *DOES*
> >   take the directory lock immediately after creating the file, which
> >   reduces the size of the window and ensure that the lock is held
> >   consistently.  More work is needed to guarantee no rename happens
> >   before the delegation.
> > 
> 
> Interesting. Maybe after taking the lock, we could re-vet the dentry vs.
> the info in the OPEN request? That way, we'd presumably know that the
> above race didn't occur.

I would lean towards revalidating the dentry after getting the lease.
However I don't think "revalidate the dentry" is quite as easy as I
would like it to be, particularly if you care about bind-mounts of
regular files.

> >  			/*
> > -			 * We don't need the i_mutex after all.  It's
> > -			 * still possible we could open this (regular
> > -			 * files can be mountpoints too), but the
> > -			 * i_mutex is just there to prevent renames of
> > -			 * something that we might be about to delegate,
> > -			 * and a mountpoint won't be renamed:
> > +			 * nfsd_cross_mnt() may wait for an upcall
> > +			 * to userspace, and holding i_sem across that
> 
> s/i_sem/i_rwsem/

But ...  fs/nilfs2/nilfs.h calls it i_sem, as does
fs/jffs2/README.Locking
And 
$ git grep -w i_mutex | wc
    180    1878   13728

But yes, I should spell it i_rwsem... or maybe just "the inode lock".

> 
> Other than minor comment nit...
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> 

Thanks,
NeilBrown
