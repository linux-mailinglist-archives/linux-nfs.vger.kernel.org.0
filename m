Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E456C6FD5
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Mar 2023 18:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjCWR6F (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Mar 2023 13:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjCWR6D (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Mar 2023 13:58:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC1120A3C
        for <linux-nfs@vger.kernel.org>; Thu, 23 Mar 2023 10:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679594238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=62jyzyEgX+HzAgLQ6e6LF2w+MDlBZYNdXnQaSgmglN4=;
        b=X/3A440zIK4dNdhMzoe1xmGn2Zy/Azo3ZpS8FCl9ByHHHnocMEUUXK8/2KkezQ7O/scoJl
        +W73sx4FO5ftycb4uEMzuOsnVQtJppX2Y/ZcOnVFh2TV56HGhRk/H4d082thEjzozTWKxr
        LElb295ttaWz9kZPQXh0ky2K9jFvu2s=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-Sj7kSSYkNSGrf1Wsau72vg-1; Thu, 23 Mar 2023 13:57:17 -0400
X-MC-Unique: Sj7kSSYkNSGrf1Wsau72vg-1
Received: by mail-pj1-f70.google.com with SMTP id nu18-20020a17090b1b1200b0023fbe01dc06so1258566pjb.8
        for <linux-nfs@vger.kernel.org>; Thu, 23 Mar 2023 10:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679594236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=62jyzyEgX+HzAgLQ6e6LF2w+MDlBZYNdXnQaSgmglN4=;
        b=CbyouUldQLZohKrm9kl/txyFBH5gtPCsIml84i5DY+Azj/ukTljA/47VTO0Voggaxo
         QFZMAWXmTInnz37xIyr33NsT1cImmcIakrUmgoXrzaLk1jaHm3JDswEyq//AfHdzLAiL
         3jGvNrK8aQXgTpK/LIkRE3UcfB4wVmRThN4rAuzMTvj5AMweN6BHhaGirHG9/kE1zgQ8
         6k5A/eE34L5CxCzQV83fDmQiuKAuAqQ/KFBZ9FhzMuBPpjbqxwKNlJHkEGUyisUYCHAn
         Ksz/64MB5/ls2b5MvdPjtCqPtXC+voSeno1Vm/c5cPKf2HCO5hjPRErrJEgPVyNvyQea
         9WBQ==
X-Gm-Message-State: AO0yUKVhK+QFh5jhhN8NScuf2d0ueAb40b6aT8U7zUpm5kiFdDXHZDeV
        z93xaQLQmFnIpeTtkfyDvGD/ITZMMnNlsd40sqSt80xyYwjLHnQ2ywM5ivgUSoe1nO1M6/pIplA
        R/4TI3caizBepR1h8t4I0Jbq5xH+VImC3l4g5
X-Received: by 2002:a65:63ce:0:b0:50a:c176:385b with SMTP id n14-20020a6563ce000000b0050ac176385bmr2256905pgv.0.1679594235889;
        Thu, 23 Mar 2023 10:57:15 -0700 (PDT)
X-Google-Smtp-Source: AK7set8hUH4UAqJTwtpM28xff/G6Qh91b5eEINYntmths5XhoVdIDJzUPM226cV4jGQCdvCl50oOyPiwV/QYMCYdxm0=
X-Received: by 2002:a65:63ce:0:b0:50a:c176:385b with SMTP id
 n14-20020a6563ce000000b0050ac176385bmr2256903pgv.0.1679594235559; Thu, 23 Mar
 2023 10:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAPt2mGNEYUk5u8V4abe=5MM5msZqmvzCVrtCP4Qw1n=gCHCnww@mail.gmail.com>
 <CALF+zO=e+d3sdLA4MZ_-SZh3epWBKF=hY=8FB+aB8+H4rxe4KA@mail.gmail.com>
 <Y++RA7YXtymaQJ05@casper.infradead.org> <CALF+zOnVJ5+Pb_mq1KcD_jdVsP8Dkg9KPGGiRS8KDJzK7+mT6Q@mail.gmail.com>
 <Y++kUMY93plkyP6f@casper.infradead.org>
In-Reply-To: <Y++kUMY93plkyP6f@casper.infradead.org>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Thu, 23 Mar 2023 13:56:38 -0400
Message-ID: <CALF+zO=J3d1DMvnaWKabpVhjXMa=wSmGo=swbm6iH9F+JUg5Xg@mail.gmail.com>
Subject: Re: /proc/PID/io/read_bytes accounting regression?
To:     David Howells <dhowells@redhat.com>
Cc:     Daire Byrne <daire@dneg.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Feb 17, 2023 at 10:59=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Fri, Feb 17, 2023 at 10:47:01AM -0500, David Wysochanski wrote:
> > On Fri, Feb 17, 2023 at 9:36 AM Matthew Wilcox <willy@infradead.org> wr=
ote:
> > >
> > > On Fri, Feb 17, 2023 at 09:08:27AM -0500, David Wysochanski wrote:
> > > > On Fri, Feb 17, 2023 at 6:56 AM Daire Byrne <daire@dneg.com> wrote:
> > > > > On newer kernels, it looks like the task io accounting is not
> > > > > incrementing the read_bytes when reading from a NFS mount? This w=
as
> > > > > definitely working on v5.16 downwards, but has not been working s=
ince
> > > > > v5.18 up to v6.2 (I haven't tested v5.17 yet).
> > > >
> > > > In v5.16 we had this call to task_io_account_read(PAGE_SIZE); on li=
ne 109
> > > > of read_cache_pages();
> > > >
> > > > But there's no call to task_io_account_read() anymore in the new
> > > > readahead code paths that I could tell,
> > > > but maybe I'm missing something.
> > > >
> > > > Willy,
> > > > Does each caller of readahead_page() now need to call
> > > > task_io_account_read() or should we add that into
> > > > readahead_page() or maybe inside read_pages()?
> > >
> > > I think the best way is to mimic what the block layer does as closely=
 as
> > > possible.  Unless we can pull it out of the block layer & all
> > > filesystems and put it in the VFS (which we can't; the VFS doesn't
> > > know which blocks are recorded by the filesystem as holes and will no=
t
> > > result in I/O).
> > >
> > Caller, ok.  I see, that makes sense.
> > Looks like cifs has a call to task_io_account_read() after data has bee=
n
> > received.  Also netfs has a call as well at the bottom of
> > netfs_rreq_unlock_folios().
> > Both seems to be _after_ data has been received, but I'm not sure that'=
s
> > correct.
>
> It's probably correct, just different from the block layer.  I don't
> have any special insight here, just an inclination to be as similar
> as possible.
>
> > > The block layer does it as part of the BIO submission path (and also
> > > counts PGPGIN and PGPGOUT, which no network filesystems seem to do?)
> > > You're more familiar with the NFS code than I am, so you probably
> > > have a better idea than __nfs_pageio_add_request().
> > >
> > Hmm, yes does the block layer's accounting take into account actual
> > bytes read or just submitted?  Maybe I need to look at this closer
> > but at first glance it looks like these numbers may sometimes be
> > incremented when actual data is received and others are incremented
> > when the submission happens.
> >
> > As to the right location in NFS, the function you mention isn't a bad
> > idea, but maybe not the right location.  Looking in nfs_file_direct_rea=
d()
> > we have the accounting at IO submission time, appears to be the
> > same as the block layer.  Also since my NFS netfs conversion patches
> > are still outstanding, I'll have to somehow take the netfs call into ac=
count
> > if fscache is enabled.  So the right place is looking like somewhere
> > in nfs_read_folio() and nfs_readahead().
>
> Yes, we don't want to double-count either fscache or direct I/O.
> I'm Maybe Dave as opinions about where we should be accounting it --
> I'm not sure that netfs is the right place to do it.  Maybe it should
> be in each network filesystem instead of in netfs?
>

David - can you comment on whether you agree the call to
task_io_account_read() inside netfs_rreq_unlock_folios() is wrong?  I
think based on the discussion here, the definition in the kernel docs,
and the fact we have to record against the proper PID, the accounting
should be done in the caller of the netfs interfaces not inside netfs
unlock path.  It looks like afs may rely on netfs IO accounting but
can it be moved?

