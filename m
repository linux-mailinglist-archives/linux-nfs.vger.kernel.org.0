Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC72402144
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Sep 2021 00:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhIFWXu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Sep 2021 18:23:50 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44346 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbhIFWXu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Sep 2021 18:23:50 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9C8971FF41;
        Mon,  6 Sep 2021 22:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630966964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ry1NtczxOVERwJbS7sSrV/MZc1iO8yevRwTZtoL/ca4=;
        b=U7zUH81pudjBE5twAiZMEOzEKHUvizWfa9sEflCH5nw45R9nobjHWzJ+1akVvGSYMX+Qni
        Ztm5Rz8eI8VZ74N7BUos0u/jzR/2SZEd87AoyOGh8Jd3PCILYtakVL5DDL8qqZG1OlW3w7
        eJsW5UWFuuuMEwO5RcFJspCLs5OEUHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630966964;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ry1NtczxOVERwJbS7sSrV/MZc1iO8yevRwTZtoL/ca4=;
        b=1PDv2/lWBmO8DMw8BxQlN6XjFGtZJe93uO5gyaziIkHOOjRP+gfNCuPFrbfZJu5xsoCr4n
        A07UNGRZWnHwhyDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C66A713B73;
        Mon,  6 Sep 2021 22:22:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nBkWIbKUNmGcVAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 06 Sep 2021 22:22:42 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Matthew Wilcox" <willy@infradead.org>
Cc:     "Chuck Lever III" <chuck.lever@oracle.com>,
        "Bruce Fields" <bfields@fieldses.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        "Mel Gorman" <mgorman@suse.com>, "Linux-MM" <linux-mm@kvack.org>
Subject: Re: [PATCH] SUNRPC: use congestion_wait() in svc_alloc_args()
In-reply-to: <YTZ4E0Zh6F/WSpy0@casper.infradead.org>
References: <163090344807.19339.10071205771966144716@noble.neil.brown.name>,
 <848A6498-CFF3-4C66-AE83-959F8221E930@oracle.com>,
 <YTZ4E0Zh6F/WSpy0@casper.infradead.org>
Date:   Tue, 07 Sep 2021 08:22:39 +1000
Message-id: <163096695999.2518.10383290668057550257@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 07 Sep 2021, Matthew Wilcox wrote:
> On Mon, Sep 06, 2021 at 03:46:34PM +0000, Chuck Lever III wrote:
> > Hi Neil-
> >=20
> > > On Sep 6, 2021, at 12:44 AM, NeilBrown <neilb@suse.de> wrote:
> > >=20
> > >=20
> > > Many places that need to wait before retrying a memory allocation use
> > > congestion_wait().  xfs_buf_alloc_pages() is a good example which
> > > follows a similar pattern to that in svc_alloc_args().
> > >=20
> > > It make sense to do the same thing in svc_alloc_args(); This will allow
> > > the allocation to be retried sooner if some backing device becomes
> > > non-congested before the timeout.
>=20
> It's adorable that you believe this is still true.

always happy to be called "adorable" !!

>=20
> https://lore.kernel.org/linux-mm/20191231125908.GD6788@bombadil.infradead.o=
rg/
>=20
>=20
Interesting ...  a few filesystems call clear_bdi_congested(), but not
enough to make a difference.

At least my patch won't make things worse.  And when (not if !!)
congestion_wait() gets fixed, sunrpc will immediately benefit.

I suspect that "congestion_wait()" needs to be replaced by several
different interfaces.

Some callers want to wait until memory might be available, which should
be tracked entirely by MM, not by filesystems.
Other caller are really only interested in their own bdi making progress
and should be allowed to specify that bdi.

And in general, it seems that that waits aren't really interested in
congestion being eased, but in progress being made.

reclaim_progress_wait()
bdi_progress_wait()

??

Even if we just provided

 void reclaim_progress_wait(void)
 {
        schedule_timeout_uninterruptible(HZ/20);
 }

that would be an improvement.  It could be called from svc_alloc_args()
and various other places that want to wait before retrying an
allocation, and it would be no worse than current behaviour.
Then if anyone had a clever idea of how to get a notification when
progress had been made, there would be an obvious place to implement
that idea.

NeilBrown
