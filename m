Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E94F2C84FA
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Nov 2020 14:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgK3NUe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 08:20:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25849 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725912AbgK3NUd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Nov 2020 08:20:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606742346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ke+B5zyGBXFDBneyiydsW3VSBkZmStwW+Db7CugudNA=;
        b=VxbfpvqeA+LiArBCm9BOUEAFhDweh022eb8aP90O6wQ8kPqL31ik/HeNDR0Fgc6kVVso8T
        RLAEPJC6Tu+YLK8XJ+6LsoKxXdI3FgBcRdX1/fXI5bzF2vXgtarbmWsB4pwJNE0Ec/Obui
        dQnKqA18HWLYqO2wDL2l73SrE4m6nFQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-yzIwvrD5OkeAALnLGWMbGQ-1; Mon, 30 Nov 2020 08:19:04 -0500
X-MC-Unique: yzIwvrD5OkeAALnLGWMbGQ-1
Received: by mail-ed1-f72.google.com with SMTP id m8so6206554edq.1
        for <linux-nfs@vger.kernel.org>; Mon, 30 Nov 2020 05:19:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ke+B5zyGBXFDBneyiydsW3VSBkZmStwW+Db7CugudNA=;
        b=BNyg+GAhfYs1iWS0LLKzSixCzGcxg0+7CA0ou+RHTPyDLHq6hwA2NbvTcUIqsIGgvf
         eXz9MLtkeY6mvebuRjCqWu9kxX2tB1XJuAxbDTLHNSyf3lE5cx4RsXq4xvE9swNI0X4r
         wxxTW+9afIIbzMraHF5ER158JvmbXFV5npW7J/WR23rrm50Y0F8bCpec7m+mF5c82JkD
         5Rkn5CRtU/XotJianATgETMEM4jUMzsFz/Z4U3tIryYV4/iBB8/Q1pjblh5NLHlIV6wA
         JRindW0j1EMrDMZ2p3UQYTlJWT/JC7q7Y8KcQDHn6al/h9MnRgjkulpj+pz//Q0hzmgO
         uMUA==
X-Gm-Message-State: AOAM533BLh8cY6Xj/+dJvz8E80VaBJNA2MEpX+wdi9OUFBQsHADN7odt
        vcDurGFDYjgwEcFnn0BM5KXLheMWxTPR6r3V3EtTDDbKEqQlCN2rwbpXSGTB9b6kht41GusKwW7
        WmORhwvVbbsq9hu6WIHBG2LZUbgCPhLpwT1dh
X-Received: by 2002:a17:906:7087:: with SMTP id b7mr20018132ejk.70.1606742343014;
        Mon, 30 Nov 2020 05:19:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxggokVPyyAf2u+GQS4DjnGBeoBlB2mftigUlWjlOy3jzTsclVQEaER6Lng6QOkWJOXXWr5hSv9hxeC2FUSKvY=
X-Received: by 2002:a17:906:7087:: with SMTP id b7mr20018099ejk.70.1606742342702;
 Mon, 30 Nov 2020 05:19:02 -0800 (PST)
MIME-Version: 1.0
References: <1605965348-24468-1-git-send-email-dwysocha@redhat.com>
 <017D0771-4BA1-4A97-A077-6222B8CF1B57@oracle.com> <CALF+zOmTSqJycjadduibk2sA-iqB3_FdtAX8zGtx4Qn1hXNCKA@mail.gmail.com>
 <6773E22E-57CC-4555-8B27-2B52034DD24D@oracle.com> <CALF+zOnqDeFS+WHe8XUAhbzhkYOBMp2JrAFvqcHqxKsBDzycwA@mail.gmail.com>
 <0A640C47-5F51-47E8-864D-E0E980F8B310@oracle.com>
In-Reply-To: <0A640C47-5F51-47E8-864D-E0E980F8B310@oracle.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Mon, 30 Nov 2020 08:18:25 -0500
Message-ID: <CALF+zOm3C2t5ob3Pe776OJ1zLTBkesH_jgGXLDKmzTMz=iT49w@mail.gmail.com>
Subject: Re: [PATCH v1 0/13] Convert NFS to new netfs and fscache APIs
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Nov 21, 2020 at 1:48 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
>
>
> > On Nov 21, 2020, at 1:28 PM, David Wysochanski <dwysocha@redhat.com> wrote:
> >
> > On Sat, Nov 21, 2020 at 12:16 PM Chuck Lever <chuck.lever@oracle.com> wrote:
> >>
> >>
> >>
> >>> On Nov 21, 2020, at 12:01 PM, David Wysochanski <dwysocha@redhat.com> wrote:
> >>>
> >>> On Sat, Nov 21, 2020 at 11:14 AM Chuck Lever <chuck.lever@oracle.com> wrote:
> >>>>
> >>>> Hi Dave-
> >>>>
> >>>>> On Nov 21, 2020, at 8:29 AM, Dave Wysochanski <dwysocha@redhat.com> wrote:
> >>>>>
> >>>>> These patches update the NFS client to use the new netfs and fscache
> >>>>> APIs and are at:
> >>>>> https://github.com/DaveWysochanskiRH/kernel.git
> >>>>> https://github.com/DaveWysochanskiRH/kernel/commit/94e9633d98a5542ea384b1095290ac6f915fc917
> >>>>> https://github.com/DaveWysochanskiRH/kernel/releases/tag/fscache-iter-nfs-20201120
> >>>>>
> >>>>> The patches are based on David Howells fscache-iter tree at
> >>>>> https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-iter
> >>>>>
> >>>>> The first 6 patches refactor some of the NFS read code to facilitate
> >>>>> re-use, the next 6 patches do the conversion to the new API, and the
> >>>>> last patch is a somewhat awkward fix for a problem seen in final
> >>>>> testing.
> >>>>>
> >>>>> Per David Howell's recent post, note that the new fscache API is
> >>>>> divided into two separate APIs, a 'netfs' API and an 'fscache' API.
> >>>>> The netfs API was done to help simplify the IO paths of network
> >>>>> filesystems, and can be called even when fscache is disabled, thus
> >>>>> simplifing both readpage and readahead implementations.  However,
> >>>>> for now these NFS conversion patches only call the netfs API when
> >>>>> fscache is enabled, similar to the existing NFS code.
> >>>>>
> >>>>> Trond and Anna, I would appreciate your guidance on this patchset.
> >>>>> At least I would like your feedback regarding the direction
> >>>>> you would like these patches to go, in particular, the following
> >>>>> items:
> >>>>>
> >>>>> 1. Whether you are ok with using the netfs API unconditionally even
> >>>>> when fscache is disabled, or prefer this "least invasive to NFS"
> >>>>> approach.  Note the unconditional use of the netfs API is the
> >>>>> recommended approach per David's post and the AFS and CEPH
> >>>>> implementations, but I was unsure if you would accept this
> >>>>> approach or would prefer to minimize changes to NFS.  Note if
> >>>>> we keep the current approach to minimize NFS changes, we will
> >>>>> have to address some problems with page unlocking such as with
> >>>>> patch 13 in the series.
> >>>>>
> >>>>> 2. Whether to keep the NFS fscache implementation as "read only"
> >>>>> or if we add write through support.  Today we only enable fscache
> >>>>> when a file is open read-only and disable / invalidate when a file
> >>>>> is open for write.
> >>>>>
> >>>>> Still TODO
> >>>>> 1. Address known issues (lockdep, page unlocking), depending on
> >>>>> what is decided as far as implementation direction
> >>>>> a) nfs_issue_op: takes rcu_read_lock but may calls nfs_page_alloc()
> >>>>> with GFP_KERNEL which may sleep (dhowells noted this in a review)
> >>>>> b) nfs_refresh_inode() takes inode->i_lock but may call
> >>>>> __fscache_invalidate() which may sleep (found with lockdep)
> >>>>> 2. Fixup NFS fscache stats (NFSIOS_FSCACHE_*)
> >>>>> * Compare with netfs stats and determine if still needed
> >>>>> 3. Cleanup dfprintks and/or convert to tracepoints
> >>>>> 4. Further tests (see "Not tested yet")
> >>>>
> >>>> Can you say whether your approach has any performance impact?
> >>> No I cannot.
> >>>
> >>>> In particular, what comparative benchmarks have been run?
> >>>>
> >>> No comparisons so far, but note the last bullet - "performance".
> >>>
> >>> Are you wondering about performance with/without fscache for this
> >>> series, or the old vs new fscache, or something else?
> >>
> >> I'd like to have some explicit performance-related merge worthiness
> >> criteria. For example: "No performance regressions, and here's how
> >> we're going to determine that we're good: fio / iozone / yada with
> >> NFS/TCP and NFS/RDMA on 100GbE; for very little additional CPU
> >> cost measured via perf xyzzy. Also some benchmark that measures lock
> >> contention."
> >>
> >> We haven't been especially careful about this in the past when
> >> reworking the client's primary I/O paths. Nothing unreasonable, but
> >> it should be stated up front where we want to end up.
> >>
> > Makes sense.
> >
> >> Another approach might be: we're going to start by making fscache
> >> opt-in. As confidence increases over time and good performance is
> >> demonstrated, then we'll unify the fscache and non-cached I/O paths.
> >>
> > It sounds like what you want is what I've done in this first implementation.
>
> My understanding is that you haven't decided whether to take the
> opt-in approach or to convert the primary I/O paths right now.
>

I posted this approach because I thought it would be the least path to
getting the new fscache changes merged.

I have another patch in progress that converts by using netfs API
unconditionally.
However I didn't think it made sense to post that until I received feedback
on this set and approach vs the more invasive approach.

>
> > This implementation takes a "least invasive to NFS" approach, staying
> > with the old fscache on/off logic, even though this was not ideal or what
> > was recommended as the end game for the netfs API.
>
> I'm not taking a position on your two approaches, but I would like
> that when the time comes to take the approach that involves full
> integration, we should have an agreed-upon set of performance
> goals. I don't want that integration to cause our high performance
> environments (NFS/RDMA, for instance) to lose out from that
> integration.
>
> Btw, it isn't clear yet that we need to use the fscache APIs to
> introduce proper huge page support. One of our current efforts is
> to convert xdr_buf from the use of an array of struct page pointers
> to an array of struct bio_vec pointers. In that case each entry in
> the array carries the size of the thing that the entry points to,
> which today is always PAGE_SIZE, but in the future could be much
> larger.
>
>
> >>>>> Checks run
> >>>>> 1. checkpatch: PASS*
> >>>>> * a few warnings, mostly trivial fixups, some unrelated to this set
> >>>>> 2. kernel builds with each patch: PASS
> >>>>> * each patch in series built cleanly which ensure bisection
> >>>>>
> >>>>> Tests run
> >>>>> 1. Custom NFS+fscache unit tests for basic operation: PASS*
> >>>>> * no oops or data corruptions
> >>>>> * Some op counts are a bit off but these are mostly due
> >>>>>  to statistics not implemented properly (NFSIOS_FSCACHE_*)
> >>>>> 2. cthon04: PASS (test options "-b -g -s -l", fsc,vers=3,4.0,4.1,4.2,sec=sys)
> >>>>> * No failures or oopses for any version or test options
> >>>>> 3. iozone tests (fsc,vers=3,4.0,4.1,4.2,sec=sys): PASS
> >>>>> * No failures or oopses
> >>>>> 4. kernel build (fsc,vers=3,4.1,4.2): PASS*
> >>>>> * all builds finish without errors or data corruption
> >>>>> * one lockdep "scheduling while atomic" fired with NFS41 and
> >>>>>  was due to one an fscache invalidation code path (known issue 'b' above)
> >>>>> 5. xfstests/generic (fsc,vers=4.2, nofsc,vers=4.2): PASS*
> >>>>> * generic/013 (pass but triggers i_lock lockdep warning known issue 'a' above)
> >>>>> * NOTE: The following tests failed with errors, but they
> >>>>>   also fail on vanilla 5.10-rc4 so are not related to this
> >>>>>   patchset
> >>>>>   * generic/074 (lockep invalid wait context - nfs_free_request())
> >>>>>   * generic/538 (short read)
> >>>>>   * generic/551 (pread: Unknown error 524, Data verification fail)
> >>>>>   * generic/568 (ERROR: File grew from 4096 B to 8192 B when writing to the fallocated range)
> >>>>>
> >>>>> Not tested yet:
> >>>>> * error injections (for example, connection disruptions, server errors during IO, etc)
> >>>>> * pNFS
> >>>>> * many process mixed read/write on same file
> >>>>> * performance
> >>>>> Dave Wysochanski (13):
> >>>>> NFS: Clean up nfs_readpage() and nfs_readpages()
> >>>>> NFS: In nfs_readpage() only increment NFSIOS_READPAGES when read
> >>>>>  succeeds
> >>>>> NFS: Refactor nfs_readpage() and nfs_readpage_async() to use
> >>>>>  nfs_readdesc
> >>>>> NFS: Call readpage_async_filler() from nfs_readpage_async()
> >>>>> NFS: Add nfs_pageio_complete_read() and remove nfs_readpage_async()
> >>>>> NFS: Allow internal use of read structs and functions
> >>>>> NFS: Convert fscache_acquire_cookie and fscache_relinquish_cookie
> >>>>> NFS: Convert fscache_enable_cookie and fscache_disable_cookie
> >>>>> NFS: Convert fscache invalidation and update aux_data and i_size
> >>>>> NFS: Convert to the netfs API and nfs_readpage to use netfs_readpage
> >>>>> NFS: Convert readpage to readahead and use netfs_readahead for fscache
> >>>>> NFS: Allow NFS use of new fscache API in build
> >>>>> NFS: Ensure proper page unlocking when reads fail with retryable
> >>>>>  errors
> >>>>>
> >>>>> fs/nfs/Kconfig             |   2 +-
> >>>>> fs/nfs/direct.c            |   2 +
> >>>>> fs/nfs/file.c              |  22 ++--
> >>>>> fs/nfs/fscache-index.c     |  94 --------------
> >>>>> fs/nfs/fscache.c           | 315 ++++++++++++++++++++-------------------------
> >>>>> fs/nfs/fscache.h           | 132 +++++++------------
> >>>>> fs/nfs/inode.c             |   4 +-
> >>>>> fs/nfs/internal.h          |   8 ++
> >>>>> fs/nfs/nfs4proc.c          |   2 +-
> >>>>> fs/nfs/pagelist.c          |   2 +
> >>>>> fs/nfs/read.c              | 248 ++++++++++++++++-------------------
> >>>>> fs/nfs/write.c             |   3 +-
> >>>>> include/linux/nfs_fs.h     |   5 +-
> >>>>> include/linux/nfs_iostat.h |   2 +-
> >>>>> include/linux/nfs_page.h   |   1 +
> >>>>> include/linux/nfs_xdr.h    |   1 +
> >>>>> 16 files changed, 339 insertions(+), 504 deletions(-)
> >>>>>
> >>>>> --
> >>>>> 1.8.3.1
> >>>>>
> >>>>
> >>>> --
> >>>> Chuck Lever
> >>
> >> --
> >> Chuck Lever
>
> --
> Chuck Lever
>
>
>

