Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A5D69AFEC
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Feb 2023 16:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjBQPzm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Feb 2023 10:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjBQPzh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Feb 2023 10:55:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDC366046
        for <linux-nfs@vger.kernel.org>; Fri, 17 Feb 2023 07:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676649280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hyIefwQxn53gkgfzMkUJYWSazKozSa8ZWmEorQPyXhw=;
        b=AyTvukMu1oQhyegoKuiuUy+SYCBtV4RSNq7Gw9GIMmvBYz7Oj3f/VcQgn3r/kArnWga8M0
        X1slh+8Kd/V3gXDS4suu5GJN1Vi9TPMMcJU+t0dRhOpGYQepI32SL2rG8Xg0lttf6A7aLR
        CtIopLuKRyp2kzYfBSvCyWomkSCEVvc=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-1-Gg0UXhNYN02uuVDS4rwrog-1; Fri, 17 Feb 2023 10:54:39 -0500
X-MC-Unique: Gg0UXhNYN02uuVDS4rwrog-1
Received: by mail-pl1-f199.google.com with SMTP id kq15-20020a170903284f00b0019abcf45d75so530681plb.8
        for <linux-nfs@vger.kernel.org>; Fri, 17 Feb 2023 07:54:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hyIefwQxn53gkgfzMkUJYWSazKozSa8ZWmEorQPyXhw=;
        b=7d1cCuy6e0TqiXAgjga5Ar5cQabriTZGL9BaXTafn/ci3h7BklSa4z/a3FP4ijqdNm
         pFUILWtFsV406UiJ0FIMJq5NnP9YokB4rUyNCKkK6rIn42AjAnAcrx/DGmaNA/axN4Lh
         EIhZkPiZKvrVyKOKnPHjFb1Pl6lepX+GWhBragCL49mIppHVCDo/NGDU1mNTw2bp4Nug
         2UO2r9GwuoHivGIl7g0f/6i12mAXSzYeL6+C/0SqMMeh3qi5mtNQNm45Gg0YC/eVNV1C
         OJmfHG4Mz5/hb+tC8JFwjcfZq4COonv6/uduDP5om6gn/YREhEbLtjy73SLy0pJtPzEW
         SGNw==
X-Gm-Message-State: AO0yUKUagPwFIV4dXPLq23jlNxVNtptekzzFjtB8kBG6sz00YKOyCOGE
        LX4LLBurhdIEEQjxYyKVl2ttV2g7zV8AJ0O6rJ/zFClXYGAci1lj6A1dK0FYbLlNB9vJ2u6kNuS
        imXMGXNEV2UER+voQzgimCE2HJr1OdI3fUgd0
X-Received: by 2002:a17:903:446:b0:19a:8cbe:1306 with SMTP id iw6-20020a170903044600b0019a8cbe1306mr221875plb.2.1676649278016;
        Fri, 17 Feb 2023 07:54:38 -0800 (PST)
X-Google-Smtp-Source: AK7set/mAcNsEdtUcLn6BzWMfv8iywnH00f9JHCI0AqEOEVtlshVVHRlJjSgIcolkVzMUgdDNeet9Jr0xmxf/KlHx5o=
X-Received: by 2002:a17:903:446:b0:19a:8cbe:1306 with SMTP id
 iw6-20020a170903044600b0019a8cbe1306mr221869plb.2.1676649277651; Fri, 17 Feb
 2023 07:54:37 -0800 (PST)
MIME-Version: 1.0
References: <CAPt2mGNEYUk5u8V4abe=5MM5msZqmvzCVrtCP4Qw1n=gCHCnww@mail.gmail.com>
 <CALF+zO=e+d3sdLA4MZ_-SZh3epWBKF=hY=8FB+aB8+H4rxe4KA@mail.gmail.com>
 <Y++RA7YXtymaQJ05@casper.infradead.org> <CALF+zOnVJ5+Pb_mq1KcD_jdVsP8Dkg9KPGGiRS8KDJzK7+mT6Q@mail.gmail.com>
In-Reply-To: <CALF+zOnVJ5+Pb_mq1KcD_jdVsP8Dkg9KPGGiRS8KDJzK7+mT6Q@mail.gmail.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Fri, 17 Feb 2023 10:54:01 -0500
Message-ID: <CALF+zOkpRc_tchxghYqavw4p_j=AKBPGR10Dr7JVsnLN0nim4g@mail.gmail.com>
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

On Fri, Feb 17, 2023 at 10:47 AM David Wysochanski <dwysocha@redhat.com> wrote:
>
> On Fri, Feb 17, 2023 at 9:36 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Fri, Feb 17, 2023 at 09:08:27AM -0500, David Wysochanski wrote:
> > > On Fri, Feb 17, 2023 at 6:56 AM Daire Byrne <daire@dneg.com> wrote:
> > > > On newer kernels, it looks like the task io accounting is not
> > > > incrementing the read_bytes when reading from a NFS mount? This was
> > > > definitely working on v5.16 downwards, but has not been working since
> > > > v5.18 up to v6.2 (I haven't tested v5.17 yet).
> > >
> > > In v5.16 we had this call to task_io_account_read(PAGE_SIZE); on line 109
> > > of read_cache_pages();
> > >
> > > But there's no call to task_io_account_read() anymore in the new
> > > readahead code paths that I could tell,
> > > but maybe I'm missing something.
> > >
> > > Willy,
> > > Does each caller of readahead_page() now need to call
> > > task_io_account_read() or should we add that into
> > > readahead_page() or maybe inside read_pages()?
> >
> > I think the best way is to mimic what the block layer does as closely as
> > possible.  Unless we can pull it out of the block layer & all
> > filesystems and put it in the VFS (which we can't; the VFS doesn't
> > know which blocks are recorded by the filesystem as holes and will not
> > result in I/O).
> >
> Caller, ok.  I see, that makes sense.
> Looks like cifs has a call to task_io_account_read() after data has been
> received.  Also netfs has a call as well at the bottom of
> netfs_rreq_unlock_folios().
> Both seems to be _after_ data has been received, but I'm not sure that's
> correct.
>
> > The block layer does it as part of the BIO submission path (and also
> > counts PGPGIN and PGPGOUT, which no network filesystems seem to do?)
> > You're more familiar with the NFS code than I am, so you probably
> > have a better idea than __nfs_pageio_add_request().
> >
> Hmm, yes does the block layer's accounting take into account actual
> bytes read or just submitted?  Maybe I need to look at this closer
> but at first glance it looks like these numbers may sometimes be
> incremented when actual data is received and others are incremented
> when the submission happens.
>
> As to the right location in NFS, the function you mention isn't a bad
> idea, but maybe not the right location.  Looking in nfs_file_direct_read()
> we have the accounting at IO submission time, appears to be the
> same as the block layer.  Also since my NFS netfs conversion patches
> are still outstanding, I'll have to somehow take the netfs call into account
> if fscache is enabled.  So the right place is looking like somewhere
> in nfs_read_folio() and nfs_readahead().

I should have read the kernel docs.  From
Documentation/filesystems/proc.rst

1744 read_bytes
1745 ^^^^^^^^^^
1746
1747 I/O counter: bytes read
1748 Attempt to count the number of bytes which this process really did cause to
1749 be fetched from the storage layer. Done at the submit_bio() level, so it is
1750 accurate for block-backed filesystems. <please add status regarding NFS and
1751 CIFS at a later time>


So it looks like NFS directIO (and non-direct, prior to v5,18) did the
same thing
as the block layer and is consistent with the definition.
Fix would be just add a call to task_io_account_read() inside nfs_read_folio()
and nfs_readahead().

