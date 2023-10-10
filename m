Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFA07C4597
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Oct 2023 01:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344147AbjJJXic (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Oct 2023 19:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343880AbjJJXib (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Oct 2023 19:38:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2125B93
        for <linux-nfs@vger.kernel.org>; Tue, 10 Oct 2023 16:38:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C70E82183A;
        Tue, 10 Oct 2023 23:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1696981108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DwVWVNNvCh3kZjvMXrHwcNsERrCsinIKUWwFhNvGNr4=;
        b=iGD9P4O70yTS0koKHSezj6i4FDIH9/AN2oeh5TFJ+GIWJHMVzS5iowSr+2C1gKpWzAcphQ
        PmUB5KptNZ7f651FpeNH+zOimpF0S3R5XTMOZNw8jflJ9bgLu9r2Xe8P58xeG4aGcKC8oZ
        deAmyH3kMurhlibEQKfwt6hgwGjlhVw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1696981108;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DwVWVNNvCh3kZjvMXrHwcNsERrCsinIKUWwFhNvGNr4=;
        b=JOAMwQB4tKb6BxGTTwlDtO+PqldqItErkELzp5H15Dj5D6QY1P5LgwwrxkFVf7bVwgGzeo
        sMSTxz1GfjiquSCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 88E8E1348E;
        Tue, 10 Oct 2023 23:38:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SCRED3PgJWUCSAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 10 Oct 2023 23:38:27 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     "steved@redhat.com" <steved@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: help with understanding match_fsid() errors in nfs-utils
In-reply-to: <7e00fd2c44df1bc34c219902498d95cb811de850.camel@hammerspace.com>
References: <169578061136.5939.6687963921006986794@noble.neil.brown.name>,
 <7e00fd2c44df1bc34c219902498d95cb811de850.camel@hammerspace.com>
Date:   Wed, 11 Oct 2023 10:38:23 +1100
Message-id: <169698110394.26263.6881855622649039694@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 28 Sep 2023, Trond Myklebust wrote:
> On Wed, 2023-09-27 at 12:10 +1000, NeilBrown wrote:
> > 
> > hi Trond,
> >  I'm trying to understand
> > 
> >  Commit 76c21e3f70a8 ("mountd: Check the stat() return values in
> > match_fsid()")
> > 
> >  in nfs-utils.
> > 
> >  The effect of this patch is that if a 'stat' of any path in
> >  /etc/exports or any mountpoint below any path marked crossmnt fails
> >  with an error other than one of a small set, then the fsid to path
> >  lookup aborts without reporting anything to the kernel, so the
> > kernel
> >  doesn't reply to the client and the mount attempt blocks
> > indefinitely.
> > 
> >  I have seen this happen when "/" is exported crossmnt, and when a
> > stat
> >  of /run/user/1000/doc returns EACCES.  This is a "fuse" mount for
> > user
> >  1000, and presumably it rejects any access from any other user.
> > 
> >  Could you please help me understand what this patch was trying to
> >  achieve?  What sorts of errors were you expecting this to catch?
> >  Would it make sense to silently ignore the stat failure for paths
> > that
> >  were found when scanning the mount table, and only take the more
> >  drastic action for paths explicitly listed in /etc/exports ??
> > 
> > 
> 
> The point is that if the filesystem is re-exported NFS, and you mount
> as 'softerr' in order to avoid hanging your knfsd server on ephemeral
> errors, then you have to be more careful about which errors are fatal,
> and hence need to be propagated to the kernel export/path cache, and
> which ones are just temporary due to a network partition or server
> reboot.
> 
> Hence the creation of path_lookup_error() which differentiates between
> the two cases.

Thanks for the explanation - and sorry about the delay in following up -
leave and stuff....

If I understand the 'softerr' option correctly, the particular error
code you need to catch in this case is ETIMEDOUT.  That is the error the
mountd would get when stating an NFS mount that wasn't responding.
So it would be safe for me to add EACCES to the set of errors that
path_lookup_error() checks - just as long as I don't add ETIMEDOUT.
Do you agree?

But I think there is another issue here.  If the 'stat' of the
mountpoint returns ETIMEDOUT we want a transient failure so that the
kernel will ask again - presumably when the client asks again.
That doesn't happen with the current code.  When the kernel queues a
request to mountd, it assumes that the request WILL be answered.  It
never resends the same request.

So mountd must reply with something.  I think that returning a negative
result with an expiry that has already passed might have the desired
result, but we would need to test that.

Thanks,
NeilBrown
