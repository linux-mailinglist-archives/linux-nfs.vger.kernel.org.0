Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D8169AFBF
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Feb 2023 16:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjBQPsZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Feb 2023 10:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjBQPsZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Feb 2023 10:48:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811AD5ECBF
        for <linux-nfs@vger.kernel.org>; Fri, 17 Feb 2023 07:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676648865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vott7Y/QgRNdFZTaiJjxHShA3aupGIT+eVaoLN24LEA=;
        b=W+dTNeI16EYYkFc5DHRtxr4AggvMNkDjTG+ZfEiAv890skFsAw6UL62vMhofEThx9IpAWZ
        yxtqtlsDV2M+VX8QdYMWTLKbCuEN/wmWQqZxH9rm29dgeVCG1hpEvxYslOXjQxV5Kr2jcE
        H7j9F2tfUu9ZQNpHulIwQye5Ucp0O+w=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-539-vyTaywfjNuGmIht9wgMfQg-1; Fri, 17 Feb 2023 10:47:38 -0500
X-MC-Unique: vyTaywfjNuGmIht9wgMfQg-1
Received: by mail-pj1-f72.google.com with SMTP id c6-20020a17090a490600b00233f132b99dso904795pjh.0
        for <linux-nfs@vger.kernel.org>; Fri, 17 Feb 2023 07:47:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vott7Y/QgRNdFZTaiJjxHShA3aupGIT+eVaoLN24LEA=;
        b=XChpRDdi/IY6+/eO928RuCZjBpzhctUGBOqibTRf849180AboB/gO1F3dLI+HEeuV5
         R83zcZzap/bLhWMq+Hr/6uRqTi3g56ZTwCqJb2gkiKbNBTVW7QhTR2Cs2HVEDvcMXPXi
         hC6InP3TY1wlKbZrE81bMzkHqKehy/AV3nNefGohwcooSbpz54J+E2KUL+psuWbD2FQ4
         wFEeX51EAIFcU2OJwH++8r14IeCsZUAWIMvsuUEj6PDyYzz65lpk054U5e4bXEz+0dNy
         fHdemG/cwxqKuErh0U+0wBhJdr0wM+o1kw9OodUY1HLEkgPWMjwYvg8wwdDd+neZX9HI
         k0qg==
X-Gm-Message-State: AO0yUKXrM3MjGiaxYauOKC8iHuG8taC8FtWPHmftqtIlJIhpuOTRNatT
        gN2N3uOQWw9KTf6Vklgf6Ls09J1WJIWathG3wvrEmuNjH8HLajFG8+H99TmS2ACkYNoV1ozzdLb
        yBIz4YO5C5hOuLJRSPYnaqDEMS8dvQUvJDdSy
X-Received: by 2002:a05:6a00:1398:b0:5a8:daec:c325 with SMTP id t24-20020a056a00139800b005a8daecc325mr529851pfg.1.1676648857802;
        Fri, 17 Feb 2023 07:47:37 -0800 (PST)
X-Google-Smtp-Source: AK7set9iAvsS67o3IVFRWLrVvN0mf7BwwydV+sHL+uJ/eHCuJ9KwK3FcI4MYMmX5jzhVA6bHO2+k5TxRYbCTbYx5LAs=
X-Received: by 2002:a05:6a00:1398:b0:5a8:daec:c325 with SMTP id
 t24-20020a056a00139800b005a8daecc325mr529841pfg.1.1676648857484; Fri, 17 Feb
 2023 07:47:37 -0800 (PST)
MIME-Version: 1.0
References: <CAPt2mGNEYUk5u8V4abe=5MM5msZqmvzCVrtCP4Qw1n=gCHCnww@mail.gmail.com>
 <CALF+zO=e+d3sdLA4MZ_-SZh3epWBKF=hY=8FB+aB8+H4rxe4KA@mail.gmail.com> <Y++RA7YXtymaQJ05@casper.infradead.org>
In-Reply-To: <Y++RA7YXtymaQJ05@casper.infradead.org>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Fri, 17 Feb 2023 10:47:01 -0500
Message-ID: <CALF+zOnVJ5+Pb_mq1KcD_jdVsP8Dkg9KPGGiRS8KDJzK7+mT6Q@mail.gmail.com>
Subject: Re: /proc/PID/io/read_bytes accounting regression?
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Daire Byrne <daire@dneg.com>, linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Feb 17, 2023 at 9:36 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Feb 17, 2023 at 09:08:27AM -0500, David Wysochanski wrote:
> > On Fri, Feb 17, 2023 at 6:56 AM Daire Byrne <daire@dneg.com> wrote:
> > > On newer kernels, it looks like the task io accounting is not
> > > incrementing the read_bytes when reading from a NFS mount? This was
> > > definitely working on v5.16 downwards, but has not been working since
> > > v5.18 up to v6.2 (I haven't tested v5.17 yet).
> >
> > In v5.16 we had this call to task_io_account_read(PAGE_SIZE); on line 109
> > of read_cache_pages();
> >
> > But there's no call to task_io_account_read() anymore in the new
> > readahead code paths that I could tell,
> > but maybe I'm missing something.
> >
> > Willy,
> > Does each caller of readahead_page() now need to call
> > task_io_account_read() or should we add that into
> > readahead_page() or maybe inside read_pages()?
>
> I think the best way is to mimic what the block layer does as closely as
> possible.  Unless we can pull it out of the block layer & all
> filesystems and put it in the VFS (which we can't; the VFS doesn't
> know which blocks are recorded by the filesystem as holes and will not
> result in I/O).
>
Caller, ok.  I see, that makes sense.
Looks like cifs has a call to task_io_account_read() after data has been
received.  Also netfs has a call as well at the bottom of
netfs_rreq_unlock_folios().
Both seems to be _after_ data has been received, but I'm not sure that's
correct.

> The block layer does it as part of the BIO submission path (and also
> counts PGPGIN and PGPGOUT, which no network filesystems seem to do?)
> You're more familiar with the NFS code than I am, so you probably
> have a better idea than __nfs_pageio_add_request().
>
Hmm, yes does the block layer's accounting take into account actual
bytes read or just submitted?  Maybe I need to look at this closer
but at first glance it looks like these numbers may sometimes be
incremented when actual data is received and others are incremented
when the submission happens.

As to the right location in NFS, the function you mention isn't a bad
idea, but maybe not the right location.  Looking in nfs_file_direct_read()
we have the accounting at IO submission time, appears to be the
same as the block layer.  Also since my NFS netfs conversion patches
are still outstanding, I'll have to somehow take the netfs call into account
if fscache is enabled.  So the right place is looking like somewhere
in nfs_read_folio() and nfs_readahead().

