Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5719051B469
	for <lists+linux-nfs@lfdr.de>; Thu,  5 May 2022 02:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237042AbiEEAFC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 May 2022 20:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351580AbiEDXpn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 May 2022 19:45:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB4A21E3B;
        Wed,  4 May 2022 16:42:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 695201F745;
        Wed,  4 May 2022 23:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651707723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AfEAmNadKBsyJGPHhIrqELUvuuTnv3+PkANYskYe9Z0=;
        b=HP9Mdd0yAlGwCYu5G+uJ3VejgPUOyGqL96rsTA3rLVta8BIpQlcOHOnWQqLYj/g+dJevsx
        go/q/geAcVFpjCmAsZlJR5mjce9eJQ1f5MqbY6lz7JmDcbqzw+en7IlUUmewUnxqRPtsi6
        oO4oYZUiReSD+rAaAsK723I3eNXWdgA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651707723;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AfEAmNadKBsyJGPHhIrqELUvuuTnv3+PkANYskYe9Z0=;
        b=baAopqfnk2KDxhB0joCqS5hQX4Zdx8yytBWV2UbF+3CqxSx6C28g7OxO8YVGZIVvKZNCEG
        VvVPfKJmMxfQDYCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D8D4131BD;
        Wed,  4 May 2022 23:42:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id a/7yFUgPc2JxXAAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 04 May 2022 23:42:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Yang Shi" <shy828301@gmail.com>
Cc:     "Huang Ying" <ying.huang@intel.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Christoph Hellwig" <hch@lst.de>,
        "Miaohe Lin" <linmiaohe@huawei.com>, linux-nfs@vger.kernel.org,
        "Linux MM" <linux-mm@kvack.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] MM: handle THP in swap_*page_fs()
In-reply-to: <CAHbLzkpF4zedBmipjX8Zy5F=Fffez+xgxTAvveaz1nRHb9Wg_Q@mail.gmail.com>
References: <165119280115.15698.2629172320052218921.stgit@noble.brown>,
 <165119301488.15698.9457662928942765453.stgit@noble.brown>,
 <CAHbLzko+9nBem8GnxQJ8RQu7bizQMMmS1TNqbRXcgkjUs+JuMw@mail.gmail.com>,
 <165146539609.24404.4051313590023463843@noble.neil.brown.name>,
 <CAHbLzkpF4zedBmipjX8Zy5F=Fffez+xgxTAvveaz1nRHb9Wg_Q@mail.gmail.com>
Date:   Thu, 05 May 2022 09:41:56 +1000
Message-id: <165170771676.24672.16520001373464213119@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 03 May 2022, Yang Shi wrote:
> On Sun, May 1, 2022 at 9:23 PM NeilBrown <neilb@suse.de> wrote:
> >
> > On Sat, 30 Apr 2022, Yang Shi wrote:
> > > On Thu, Apr 28, 2022 at 5:44 PM NeilBrown <neilb@suse.de> wrote:
> > > >
> > > > Pages passed to swap_readpage()/swap_writepage() are not necessarily =
all
> > > > the same size - there may be transparent-huge-pages involves.
> > > >
> > > > The BIO paths of swap_*page() handle this correctly, but the SWP_FS_O=
PS
> > > > path does not.
> > > >
> > > > So we need to use thp_size() to find the size, not just assume
> > > > PAGE_SIZE, and we need to track the total length of the request, not
> > > > just assume it is "page * PAGE_SIZE".
> > >
> > > Swap-over-nfs doesn't support THP swap IIUC. So SWP_FS_OPS should not
> > > see THP at all. But I agree to remove the assumption about page size
> > > in this path.
> >
> > Can you help me understand this please.  How would the swap code know
> > that swap-over-NFS doesn't support THP swap?  There is no reason that
> > NFS wouldn't be able to handle 2MB writes.  Even 1GB should work though
> > NFS would have to split into several smaller WRITE requests.
>=20
> AFAICT, THP swap is only supported on non-rotate block devices, for
> example, SSD, PMEM, etc. IIRC, the swap device has to support the
> cluster in order to swap THP. The cluster is only supported by
> non-rotate block devices.
>=20
> Looped Ying in, who is the author of THP swap.

I hunted around the code and found that THP swap only happens if a
'cluster_info' is allocated, and that only happens if=20
	if (p->bdev && bdev_nonrot(p->bdev)) {
in the swapon syscall.

I guess "nonrot" is being use as a synonym for "low latency"...
So even if NFS was low-latency it couldn't benefit from THP swap.

So as you say it is not currently possible for THP pages to be send to
NFS for swapout.  It makes sense to prepare for it though I think - if
only so that the code is more consistent and less confusing.

Thanks,
NeilBrown
