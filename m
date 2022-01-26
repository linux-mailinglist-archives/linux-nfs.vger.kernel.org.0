Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4414D49D51F
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jan 2022 23:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiAZWOu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Jan 2022 17:14:50 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:41022 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiAZWOt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Jan 2022 17:14:49 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8FDB121115;
        Wed, 26 Jan 2022 22:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643235288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XAxGUgZjMfRYcheCAvGcdbuwhS+6jxtGJ++NzQbXLbs=;
        b=mff66aUsTySR80NmIG6DFMDZ8GOSZWBzAb6QezcCyekTKeq0vaL4p57+me2lhVr9SxNgDq
        5PrkZNO/w2zB5kgRuauSKoDUKN1aObBFWp1LheRHzZACgfpO+VXiiCtPEZKhuzochTgn4x
        dQuDMpHgMQMZt9xRtxBxbL4VkOHvKaw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643235288;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XAxGUgZjMfRYcheCAvGcdbuwhS+6jxtGJ++NzQbXLbs=;
        b=qZsxwnV2bCYEJrrqd0i6b3VKdv+EWpeCYEtnRvGhfI7zYjGmVoQzl23i75fR7TVdDKLmGa
        4wqjwIkIgmIH2aAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7C2361330C;
        Wed, 26 Jan 2022 22:14:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rMG3DdXH8WH4TQAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 26 Jan 2022 22:14:45 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Christoph Hellwig" <hch@infradead.org>
Cc:     "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Anna Schumaker" <anna.schumaker@netapp.com>,
        "Chuck Lever" <chuck.lever@oracle.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Mel Gorman" <mgorman@suse.de>,
        "Christoph Hellwig" <hch@infradead.org>,
        "David Howells" <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/23] VFS: Add FMODE_CAN_ODIRECT file flag
In-reply-to: <Ye5puPat8w9/nQ6R@infradead.org>
References: <164299573337.26253.7538614611220034049.stgit@noble.brown>,
 <164299611280.26253.2845018521780218144.stgit@noble.brown>,
 <Ye5puPat8w9/nQ6R@infradead.org>
Date:   Thu, 27 Jan 2022 09:14:41 +1100
Message-id: <164323528189.5493.7196087998245554506@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 24 Jan 2022, Christoph Hellwig wrote:
> On Mon, Jan 24, 2022 at 02:48:32PM +1100, NeilBrown wrote:
> > Currently various places test if direct IO is possible on a file by
> > checking for the existence of the direct_IO address space operation.
> > This is a poor choice, as the direct_IO operation may not be used - it is
> > only used if the generic_file_*_iter functions are called for direct IO
> > and some filesystems - particularly NFS - don't do this.
> > 
> > Instead, introduce a new f_mode flag: FMODE_CAN_ODIRECT and change the
> > various places to check this (avoiding pointer dereferences).
> > do_dentry_open() will set this flag if ->direct_IO is present, so
> > filesystems do not need to be changed.
> > 
> > NFS *is* changed, to set the flag explicitly and discard the direct_IO
> > entry in the address_space_operations for files.
> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> It would be nice to throw in a cleanup to remove noop_direct_IO as well.

I don't want to add this to the present series.  When it lands I'll send
patches to the various filesystems to switch to using FMODE_CAN_ODIRECT.

Thanks,
NeilBrown
