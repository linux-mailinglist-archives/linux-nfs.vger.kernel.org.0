Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFFA47A228
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Dec 2021 22:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236595AbhLSVAF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Dec 2021 16:00:05 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:36660 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbhLSVAE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Dec 2021 16:00:04 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 743B71F37B;
        Sun, 19 Dec 2021 21:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639947603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RTB8LgiFoLMd63+8gsmi/aw1sk99lR5a11u/xaqzZcY=;
        b=g2DH8M0R6UezmCHnLYcVGAcGlublRbjQd2euN3C4+/zCGkSzNZErVIZmNJYKo7wA973J3a
        obTVhDFLN6hQz0tg2Nf8o6RGSCRNtpjnC0VkKfk6gYNLv997IQfZWgTLImiL70GpxLbrtl
        YLQdAEkjYgdNBCVhWh08rm+/xNFVprs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639947603;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RTB8LgiFoLMd63+8gsmi/aw1sk99lR5a11u/xaqzZcY=;
        b=2lsRd17vzTF94CWUCOGBkR/q2Irbn/g5LrOQ0aFul1CH81dh0fgLMz1/U3TkQIwm1CPvor
        NR8eBmXtgndRqODQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 12F29133A7;
        Sun, 19 Dec 2021 20:59:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XmqML0+dv2GFMAAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 19 Dec 2021 20:59:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
Subject: Re: [PATCH 08/18] MM: Add AS_CAN_DIO mapping flag
In-reply-to: <CANe_+Uj0ooR2QzNQLXihuoaWMCJMpo3yJNhP_9DyPaCzeO7v7w@mail.gmail.com>
References: <163969801519.20885.3977673503103544412.stgit@noble.brown>,
 <163969850302.20885.17124747377211907111.stgit@noble.brown>,
 <CANe_+Uj0ooR2QzNQLXihuoaWMCJMpo3yJNhP_9DyPaCzeO7v7w@mail.gmail.com>
Date:   Mon, 20 Dec 2021 07:59:56 +1100
Message-id: <163994759613.25899.17650220291128318661@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 20 Dec 2021, Mark Hemment wrote:
> On Thu, 16 Dec 2021 at 23:57, NeilBrown <neilb@suse.de> wrote:
> >
> > Currently various places test if direct IO is possible on a file by
> > checking for the existence of the direct_IO address space operation.
> > This is a poor choice, as the direct_IO operation may not be used - it is
> > only used if the generic_file_*_iter functions are called for direct IO
> > and some filesystems - particularly NFS - don't do this.
> >
> > Instead, introduce a new mapping flag: AS_CAN_DIO and change the various
> > places to check this (avoiding a pointer dereference).
> > unlock_new_inode() will set this flag if ->direct_IO is present, so
> > filesystems do not need to be changed.
> ...
> > diff --git a/fs/inode.c b/fs/inode.c
> > index 6b80a51129d5..bae65ccecdb1 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -1008,6 +1008,9 @@ EXPORT_SYMBOL(lockdep_annotate_inode_mutex_key);
> >  void unlock_new_inode(struct inode *inode)
> >  {
> >         lockdep_annotate_inode_mutex_key(inode);
> > +       if (inode->i_mapping->a_ops &&
> > +           inode->i_mapping->a_ops->direct_IO)
> > +               set_bit(AS_CAN_DIO, &inode->i_mapping->flags);
> >         spin_lock(&inode->i_lock);
> >         WARN_ON(!(inode->i_state & I_NEW));
> >         inode->i_state &= ~I_NEW & ~I_CREATING;
> 
> Does d_instantiate_new() also need to set AS_CAN_DIO?

Yes it does - thanks for catching that.  I'll update my patch.

Thanks,
NeilBrown
