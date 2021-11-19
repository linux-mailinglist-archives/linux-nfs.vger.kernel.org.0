Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B38456890
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Nov 2021 04:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhKSDWz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Nov 2021 22:22:55 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:49848 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbhKSDWz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 Nov 2021 22:22:55 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B44A61FD3B;
        Fri, 19 Nov 2021 03:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637291993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/rbyUZrMfGv14yYt2o/d+u8aYwo1LcaJvD2lyfY39dU=;
        b=0omNTMMfXH8D4e4HRJKDU2mHnWEygsC5obviDKN6Z38bc9cr5TySTyLEaHMcOum2oe7DXC
        EJ0CuWjCt5mJQ8oa08+S/IozS+s2SfZdbZw/KO1Q4vr67e1kChsnCRd5iHtCdRHYKBpXSs
        O5HuusJpQzJUiJMABs/UhXNH1CiLJl4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637291993;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/rbyUZrMfGv14yYt2o/d+u8aYwo1LcaJvD2lyfY39dU=;
        b=/DSMmgZ6/PcgBd1P6vBA0tixGFH7KK730dGbHwVuehGCUuz/ixNyxxx66SO0FdUgn2Kwj2
        BQ2rk1m3X+IbALBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B94F913DCB;
        Fri, 19 Nov 2021 03:19:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iLm6HdcXl2FZBAAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 19 Nov 2021 03:19:51 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Bruce Fields" <bfields@fieldses.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 00/14] SUNRPC: clean up server thread management.
In-reply-to: <9E7E7AC8-FE88-4C07-9DE7-DA5F0CB2B9E2@oracle.com>
References: <163710954700.5485.5622638225352156964.stgit@noble.brown>,
 <9E7E7AC8-FE88-4C07-9DE7-DA5F0CB2B9E2@oracle.com>
Date:   Fri, 19 Nov 2021 14:19:47 +1100
Message-id: <163729198702.13692.3585664864399341321@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 18 Nov 2021, Chuck Lever III wrote:
> 
> > On Nov 16, 2021, at 7:46 PM, NeilBrown <neilb@suse.de> wrote:
> > 
> > I have a dream of making nfsd threads start and stop dynamically.
> > This would free the admin of having to choose a number of threads to
> > start.
> > I'm not there yet, and I may never get there, but the current state of
> > the thread management code makes it harder to experiment than it needs
> > to be.  There is a lot of technical debt that needs to be repaid first.
> > 
> > This series addresses much of this debt.  There are three users of
> > service threads: nfsd, lockd, and nfs-callback.
> > nfs-callback, the newest, is quite clean.  This patch brings nfsd and
> > lockd up to a similar standard, and takes advantage of this increased
> > uniformity to simplify some shared interfaces.
> 
> NFSD is venerable and ancient code. I'm a fan of careful and
> tasteful clean up efforts!
> 
> I've started to familiarize myself with these changes. A couple
> of thoughts for v2:
> 
> 1. 1/14 is doing some heavy lifting and might be split into a
>    lockd/nfs_cb patch and an nfsd-only patch. Or maybe there's
>    another cleavage that makes more sense.

I've split out the renaming of svc_destroy to svc_put and related
changes.

> 
> 2. When introducing "static inline" functions I like to see full
>    kerneldoc comments for those.

Will do.

> 
> I'd also like to have some idea how we should be exercising this
> series to ensure it is as bug-free as is reasonable. Do you have
> any thoughts about that?

As Bruce discovered, it is the starting and stopping of services that
are most affected.  Races between the two might be interesting.
Failures during start could be interesting.  Signalling nfsd threads vs
"rpc.nfsd 0" might have races.

> 
> 
> > It doesn't introduce any functionality improvements,
> 
> I might quibble with that assessment: replacing heavyweight
> synchronization with spinlocks and atomics will have some
> functional impact. That's probably where we need to be most
> careful.

Agreed.

Thanks,
NeilBrown
