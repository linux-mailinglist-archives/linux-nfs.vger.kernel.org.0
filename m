Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02FE549D5B3
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jan 2022 23:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiAZWvt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Jan 2022 17:51:49 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:42266 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiAZWvt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Jan 2022 17:51:49 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 49CB321136;
        Wed, 26 Jan 2022 22:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643237508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UrpK9gFVFFc3QEQ0Z3ktR9+zqmiOMW06uKnM7Gq/rtU=;
        b=pAyw+3sw1FfhAD1ZWWHHuEeStuC30D7GteS6mR1nWLYRZ64TTpPAphVnQOaLSJqyyxPaIH
        O72QLqPlvAxrwC4B02VEC/Cha98JW9DMqBNKT3e0UXQaoV5YsnvDbgV6sLpuxkuBXKVzaa
        +2jaoKmu038KUFc/OApkq5FBZFhW+44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643237508;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UrpK9gFVFFc3QEQ0Z3ktR9+zqmiOMW06uKnM7Gq/rtU=;
        b=g6oTCe+TW9F8H+pLJP+hn85cjDcYsDtLn7iJPBKjmCxLVTb/PrZ/k4QHNmgMH+7RBJLcoD
        Cm5Et4QDp6ahfCDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 242ED13E40;
        Wed, 26 Jan 2022 22:51:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Btj7NIDQ8WG/WgAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 26 Jan 2022 22:51:44 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Mark Hemment" <markhemm@googlemail.com>
Cc:     "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Anna Schumaker" <anna.schumaker@netapp.com>,
        "Chuck Lever" <chuck.lever@oracle.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Mel Gorman" <mgorman@suse.de>,
        "Christoph Hellwig" <hch@infradead.org>,
        "David Howells" <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/23] NFS: swap IO handling is slightly different for O_DIRECT IO
In-reply-to: <CANe_+UgUNS81Jho8gLc956LArQk9SzGETusRpzRW-_uPF-fqbg@mail.gmail.com>
References: <164299573337.26253.7538614611220034049.stgit@noble.brown>,
 <164299611281.26253.15560926531007295753.stgit@noble.brown>,
 <CANe_+UgUNS81Jho8gLc956LArQk9SzGETusRpzRW-_uPF-fqbg@mail.gmail.com>
Date:   Thu, 27 Jan 2022 09:51:41 +1100
Message-id: <164323750168.5493.12090358551960276049@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 25 Jan 2022, Mark Hemment wrote:
> On Mon, 24 Jan 2022 at 03:53, NeilBrown <neilb@suse.de> wrote:
> >
> > 1/ Taking the i_rwsem for swap IO triggers lockdep warnings regarding
> >    possible deadlocks with "fs_reclaim".  These deadlocks could, I believ=
e,
> >    eventuate if a buffered read on the swapfile was attempted.
> >
> >    We don't need coherence with the page cache for a swap file, and
> >    buffered writes are forbidden anyway.  There is no other need for
> >    i_rwsem during direct IO.  So never take it for swap_rw()
> >
> > 2/ generic_write_checks() explicitly forbids writes to swap, and
> >    performs checks that are not needed for swap.  So bypass it
> >    for swap_rw().
> >
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/nfs/direct.c        |   30 +++++++++++++++++++++---------
> >  fs/nfs/file.c          |    4 ++--
> >  include/linux/nfs_fs.h |    4 ++--
> >  3 files changed, 25 insertions(+), 13 deletions(-)
> >
> ...
> > @@ -943,7 +954,8 @@ ssize_t nfs_file_direct_write(struct kiocb *iocb, str=
uct iov_iter *iter)
> >                                               pos >> PAGE_SHIFT, end);
> >         }
> >
> > -       nfs_end_io_direct(inode);
> > +       if (!swap)
> > +               nfs_end_io_direct(inode);
>=20
> Just above this code diff, there is;
>     if (mapping->nrpages) {
>         invalidate_inode_pages2_range(mapping,
>              pos >> PAGE_SHIFT, end);
>     }
>=20
> This invalidation looks strange/wrong for a NFS swap write.  Should it
> be disabled for the swap case?

Yes, I think it should - particularly as we don't take the mutex in the
swap case.  Thanks!
This change improves the look of the code too :-)

Thanks,
NeilBrown
