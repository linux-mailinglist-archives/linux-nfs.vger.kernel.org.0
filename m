Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B904528D5
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Nov 2021 04:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236166AbhKPD6r (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Nov 2021 22:58:47 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:60764 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236281AbhKPD6m (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Nov 2021 22:58:42 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 172DD2191A;
        Tue, 16 Nov 2021 03:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637034945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QZ6kdCgSp2XTia4ThpxgHwIvBYQFQnpzJR9yhAgEjPc=;
        b=RXKAkG5IoHk42VOhvmLbrK0PfGDEHLTYeNlrL4HJNuQ1rCgAoUZ9mSY1HUgfnA4eTeYASu
        cw4LvMdvyOqzzUdrkrhsUc6Kbc6zRtOZ69Tey9dD+PzWMpQv3PLcZcv1AorRpHKv9iNSq9
        WDvYdMFsEU/Odfp/GPfwObst+gQMS2c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637034945;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QZ6kdCgSp2XTia4ThpxgHwIvBYQFQnpzJR9yhAgEjPc=;
        b=LbuBz/kBCXvgI1ZgdTh5JDA/tayHkqmsIPa4tjxK4ovGtJSYm4R4Ve3klTg6Sz3hGuDB6c
        sanSkBuPxbLi7JCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6C02313B65;
        Tue, 16 Nov 2021 03:55:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id z+xgCr4rk2E9GwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 16 Nov 2021 03:55:42 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Matthew Wilcox" <willy@infradead.org>
Cc:     "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Anna Schumaker" <anna.schumaker@netapp.com>,
        "Chuck Lever" <chuck.lever@oracle.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Mel Gorman" <mgorman@suse.de>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] Repair SWAP-over-NFS
In-reply-to: <YZMlk2sVjt5viat2@casper.infradead.org>
References: <163702956672.25805.16457749992977493579.stgit@noble.brown>,
 <YZMlk2sVjt5viat2@casper.infradead.org>
Date:   Tue, 16 Nov 2021 14:55:39 +1100
Message-id: <163703493923.13692.11352680016082986967@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 16 Nov 2021, Matthew Wilcox wrote:
> On Tue, Nov 16, 2021 at 01:44:04PM +1100, NeilBrown wrote:
> > swap-over-NFS currently has a variety of problems.
> > 
> > Due to a newish test in generic_write_checks(), all writes to swap
> > currently fail.
> 
> And by "currently", you mean "for over two years" (August 2019).

That's about the time scale for "enterprise" releases...
Actually, the earliest patches that impacted swap-over-NFS was more like
4 years ago.  I didn't bother tracking Fixes: tags for everything that
was a fix, as I didn't think it would really help and might encourage
people to backport little bits of the series which I wouldn't recommend.

> Does swap-over-NFS (or any other network filesystem) actually have any
> users, and should we fix it or rip it out?
> 
> 
We have at least one user (why else would I be working on this?).  I
think we have more, though they are presumably still on an earlier
release.

I'd prefer "fix it" over "rip it out".

I don't think any other network filesystem supports swap, but it is
not trivial to grep for.. There must be a 'swap_activate' method, and it
must return 0.  There must also be a direct_IO that works.
The only other network filesystem with swap_activate is cifs.  It
returns 0, but direct_IO returns -EINVAL.

NeilBrown
