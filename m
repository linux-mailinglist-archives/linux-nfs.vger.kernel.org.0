Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9D52C84AD
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Nov 2020 14:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgK3NHx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 08:07:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32510 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725875AbgK3NHx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Nov 2020 08:07:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606741585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7xhj/bpYAI/b2nRq4AhcXDAVGkFRk3JGWP07H9VT0vc=;
        b=fvd9oYT/MQdjvMGo/XERWJjEF/5hyzTuK335NBnq9/Y9iv6YhUt/LWsVg73kV39Oslk9JO
        0B2s5/5p5+4FO3FO0+dR35/tgiHm2G6M5eeMYN2r9OVtFzgKzrsDS4W/TYjV3pUoLAWS1g
        UkZmQIBUc7+sFS2X4GeUHjTDBx/Vays=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-rP23UW1aNIGeVHOthnsgdg-1; Mon, 30 Nov 2020 08:06:22 -0500
X-MC-Unique: rP23UW1aNIGeVHOthnsgdg-1
Received: by mail-ej1-f70.google.com with SMTP id q2so5718272ejj.16
        for <linux-nfs@vger.kernel.org>; Mon, 30 Nov 2020 05:06:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7xhj/bpYAI/b2nRq4AhcXDAVGkFRk3JGWP07H9VT0vc=;
        b=TU0SENA5VC2wjvQheQNFSmhdDpIjTBys+oBZX6tYTZZBon1dBd+jRAhA8m59OrrtQ0
         SjUHyqmXAsihptW2etPzAGSAWudc+HCNXz67PyyeY1erm8w5NHcl7nnNgtOEUiRPftck
         EGEJex6a89cH7CVFDgshRRq7+TehdRjWXFWYNgMI3GYUkPZZ1gayFEBpN9cscq1CULFg
         kvPm9YfusX2n2agTV2Jjmto81Ul8+mvL3++xIGF2yZGg+nUS5qp4A6KwYM9f03hGwY9d
         E8+17EamYwQFild+ba5DIkaALaEd1BmlS5YY3AeV5UmOHQIzWSPrFGIaRddhtoOzN5NO
         8e/A==
X-Gm-Message-State: AOAM531MnyaQT+lxKm048Acn07DvUhOcrA9J3Vq9LPTdk1MQjAZ3xQmP
        tj392SJdF2ApvvPv8VGtxmHoOMV7zIMeocESoPxa3qsGFAzVm9jpaMGWitAu+YQnDeWv22k96GK
        wRIRqDfBU+MExqlCaSXZNT6+Ajf0m4R5e9IUs
X-Received: by 2002:a17:906:7087:: with SMTP id b7mr19955177ejk.70.1606741579823;
        Mon, 30 Nov 2020 05:06:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxjLAKTSIGMGpYg74oSrCdavKtltmeOS4Gvv8WRfTd55dKX5FVhZiM0Vrxljv1O+8l3KE7/gx+pGQ1lCe8O7o4=
X-Received: by 2002:a17:906:7087:: with SMTP id b7mr19955151ejk.70.1606741579439;
 Mon, 30 Nov 2020 05:06:19 -0800 (PST)
MIME-Version: 1.0
References: <1605965348-24468-1-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1605965348-24468-1-git-send-email-dwysocha@redhat.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Mon, 30 Nov 2020 08:05:42 -0500
Message-ID: <CALF+zOkss0TzS=OBFX-RxTHgi36NigHEpJVHjtCeNg4n+emegA@mail.gmail.com>
Subject: Re: [PATCH v1 0/13] Convert NFS to new netfs and fscache APIs
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Nov 21, 2020 at 8:29 AM Dave Wysochanski <dwysocha@redhat.com> wrote:
>
> These patches update the NFS client to use the new netfs and fscache
> APIs and are at:
> https://github.com/DaveWysochanskiRH/kernel.git
> https://github.com/DaveWysochanskiRH/kernel/commit/94e9633d98a5542ea384b1095290ac6f915fc917
> https://github.com/DaveWysochanskiRH/kernel/releases/tag/fscache-iter-nfs-20201120
>
> The patches are based on David Howells fscache-iter tree at
> https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-iter
>
> The first 6 patches refactor some of the NFS read code to facilitate
> re-use, the next 6 patches do the conversion to the new API, and the
> last patch is a somewhat awkward fix for a problem seen in final
> testing.
>
> Per David Howell's recent post, note that the new fscache API is
> divided into two separate APIs, a 'netfs' API and an 'fscache' API.
> The netfs API was done to help simplify the IO paths of network
> filesystems, and can be called even when fscache is disabled, thus
> simplifing both readpage and readahead implementations.  However,
> for now these NFS conversion patches only call the netfs API when
> fscache is enabled, similar to the existing NFS code.
>
> Trond and Anna, I would appreciate your guidance on this patchset.
> At least I would like your feedback regarding the direction
> you would like these patches to go, in particular, the following
> items:
>
> 1. Whether you are ok with using the netfs API unconditionally even
> when fscache is disabled, or prefer this "least invasive to NFS"
> approach.  Note the unconditional use of the netfs API is the
> recommended approach per David's post and the AFS and CEPH
> implementations, but I was unsure if you would accept this
> approach or would prefer to minimize changes to NFS.  Note if
> we keep the current approach to minimize NFS changes, we will
> have to address some problems with page unlocking such as with
> patch 13 in the series.
>
> 2. Whether to keep the NFS fscache implementation as "read only"
> or if we add write through support.  Today we only enable fscache
> when a file is open read-only and disable / invalidate when a file
> is open for write.
>
> Still TODO
> 1. Address known issues (lockdep, page unlocking), depending on
> what is decided as far as implementation direction
>   a) nfs_issue_op: takes rcu_read_lock but may calls nfs_page_alloc()
>   with GFP_KERNEL which may sleep (dhowells noted this in a review)
>   b) nfs_refresh_inode() takes inode->i_lock but may call
>   __fscache_invalidate() which may sleep (found with lockdep)
> 2. Fixup NFS fscache stats (NFSIOS_FSCACHE_*)
> * Compare with netfs stats and determine if still needed
> 3. Cleanup dfprintks and/or convert to tracepoints
> 4. Further tests (see "Not tested yet")
>
> Checks run
> 1. checkpatch: PASS*
>   * a few warnings, mostly trivial fixups, some unrelated to this set
> 2. kernel builds with each patch: PASS
>   * each patch in series built cleanly which ensure bisection
>
> Tests run
> 1. Custom NFS+fscache unit tests for basic operation: PASS*
>   * no oops or data corruptions
>   * Some op counts are a bit off but these are mostly due
>     to statistics not implemented properly (NFSIOS_FSCACHE_*)
> 2. cthon04: PASS (test options "-b -g -s -l", fsc,vers=3,4.0,4.1,4.2,sec=sys)
> * No failures or oopses for any version or test options
> 3. iozone tests (fsc,vers=3,4.0,4.1,4.2,sec=sys): PASS
> * No failures or oopses
> 4. kernel build (fsc,vers=3,4.1,4.2): PASS*
>   * all builds finish without errors or data corruption
>   * one lockdep "scheduling while atomic" fired with NFS41 and
>     was due to one an fscache invalidation code path (known issue 'b' above)
> 5. xfstests/generic (fsc,vers=4.2, nofsc,vers=4.2): PASS*
>    * generic/013 (pass but triggers i_lock lockdep warning known issue 'a' above)
>    * NOTE: The following tests failed with errors, but they
>      also fail on vanilla 5.10-rc4 so are not related to this
>      patchset
>      * generic/074 (lockep invalid wait context - nfs_free_request())
>      * generic/538 (short read)
>      * generic/551 (pread: Unknown error 524, Data verification fail)
>      * generic/568 (ERROR: File grew from 4096 B to 8192 B when writing to the fallocated range)
>

FYI, Anna asked about test coverage last week during the chat with
David Howells about fscache.
Since then, I ran xfstests generic on NFS versions 3, 4.0, 4.1, and
4.2 with the following configurations:
- 5.10.0-rc4 without 'fsc' (fscache not enabled)
- 5.10.0-rc4-94e9633d98a5+ (these patches) without 'fsc' (fscache not enabled)
- 5.10.0-rc4-94e9633d98a5+ (these patches) with 'fsc' (fscache enabled)

In all of the above, a small number of tests failed with the patched
kernels also failed with the vanilla kernel, so no new failures
occurred.
If you want the full  text file output for the test runs just ask, but
here's a short summary:

5.10.0-rc4/xfstests-generic-NFS3-nofsc-5.10.0-rc4.txt:generic/053    -
output mismatch (see
/root/git/xfstests-dev/results//nfsnofsc/generic/053.out.bad)
5.10.0-rc4/xfstests-generic-NFS3-nofsc-5.10.0-rc4.txt:generic/089
26888s ... - output mismatch (see
/root/git/xfstests-dev/results//nfsnofsc/generic/089.out.bad)
5.10.0-rc4/xfstests-generic-NFS3-nofsc-5.10.0-rc4.txt:generic/105    -
output mismatch (see
/root/git/xfstests-dev/results//nfsnofsc/generic/105.out.bad)
5.10.0-rc4/xfstests-generic-NFS3-nofsc-5.10.0-rc4.txt:generic/258 1s
... [failed, exit status 1]- output mismatch (see
/root/git/xfstests-dev/results//nfsnofsc/generic/258.out.bad)
5.10.0-rc4/xfstests-generic-NFS3-nofsc-5.10.0-rc4.txt:generic/294    -
output mismatch (see
/root/git/xfstests-dev/results//nfsnofsc/generic/294.out.bad)
5.10.0-rc4/xfstests-generic-NFS3-nofsc-5.10.0-rc4.txt:generic/318    -
output mismatch (see
/root/git/xfstests-dev/results//nfsnofsc/generic/318.out.bad)
5.10.0-rc4/xfstests-generic-NFS3-nofsc-5.10.0-rc4.txt:generic/319    -
output mismatch (see
/root/git/xfstests-dev/results//nfsnofsc/generic/319.out.bad)
5.10.0-rc4/xfstests-generic-NFS3-nofsc-5.10.0-rc4.txt:generic/444    -
output mismatch (see
/root/git/xfstests-dev/results//nfsnofsc/generic/444.out.bad)
5.10.0-rc4/xfstests-generic-NFS3-nofsc-5.10.0-rc4.txt:generic/467 36s
... - output mismatch (see
/root/git/xfstests-dev/results//nfsnofsc/generic/467.out.bad)
5.10.0-rc4/xfstests-generic-NFS3-nofsc-5.10.0-rc4.txt:generic/477 23s
... - output mismatch (see
/root/git/xfstests-dev/results//nfsnofsc/generic/477.out.bad)
5.10.0-rc4/xfstests-generic-NFS3-nofsc-5.10.0-rc4.txt:generic/529    -
output mismatch (see
/root/git/xfstests-dev/results//nfsnofsc/generic/529.out.bad)
5.10.0-rc4/xfstests-generic-NFS3-nofsc-5.10.0-rc4.txt:generic/551
7535s ... - output mismatch (see
/root/git/xfstests-dev/results//nfsnofsc/generic/551.out.bad)
5.10.0-rc4/xfstests-generic-NFS40-nofsc-5.10.0-rc4.txt:generic/294
- output mismatch (see
/root/git/xfstests-dev/results//nfs40nofsc/generic/294.out.bad)
5.10.0-rc4/xfstests-generic-NFS40-nofsc-5.10.0-rc4.txt:generic/426 36s
... - output mismatch (see
/root/git/xfstests-dev/results//nfs40nofsc/generic/426.out.bad)
5.10.0-rc4/xfstests-generic-NFS40-nofsc-5.10.0-rc4.txt:generic/467 4s
... - output mismatch (see
/root/git/xfstests-dev/results//nfs40nofsc/generic/467.out.bad)
5.10.0-rc4/xfstests-generic-NFS40-nofsc-5.10.0-rc4.txt:generic/477 3s
... - output mismatch (see
/root/git/xfstests-dev/results//nfs40nofsc/generic/477.out.bad)
5.10.0-rc4/xfstests-generic-NFS40-nofsc-5.10.0-rc4.txt:generic/551
7535s ... - output mismatch (see
/root/git/xfstests-dev/results//nfs40nofsc/generic/551.out.bad)
5.10.0-rc4/xfstests-generic-NFS41-nofsc-5.10.0-rc4.txt:generic/294
- output mismatch (see
/root/git/xfstests-dev/results//nfs41nofsc/generic/294.out.bad)
5.10.0-rc4/xfstests-generic-NFS41-nofsc-5.10.0-rc4.txt:generic/551
7535s ... - output mismatch (see
/root/git/xfstests-dev/results//nfs41nofsc/generic/551.out.bad)
5.10.0-rc4/xfstests-generic-NFS42-nofsc-5.10.0-rc4.txt:generic/294
- output mismatch (see
/root/git/xfstests-dev/results//nfs42nofsc/generic/294.out.bad)
5.10.0-rc4/xfstests-generic-NFS42-nofsc-5.10.0-rc4.txt:generic/538 30s
... - output mismatch (see
/root/git/xfstests-dev/results//nfs42nofsc/generic/538.out.bad)
5.10.0-rc4/xfstests-generic-NFS42-nofsc-5.10.0-rc4.txt:generic/551
7535s ... - output mismatch (see
/root/git/xfstests-dev/results//nfs42nofsc/generic/551.out.bad)
5.10.0-rc4/xfstests-generic-NFS42-nofsc-5.10.0-rc4.txt:generic/568
- output mismatch (see
/root/git/xfstests-dev/results//nfs42nofsc/generic/568.out.bad)



> Not tested yet:
> * error injections (for example, connection disruptions, server errors during IO, etc)
> * pNFS
> * many process mixed read/write on same file
> * performance
> Dave Wysochanski (13):
>   NFS: Clean up nfs_readpage() and nfs_readpages()
>   NFS: In nfs_readpage() only increment NFSIOS_READPAGES when read
>     succeeds
>   NFS: Refactor nfs_readpage() and nfs_readpage_async() to use
>     nfs_readdesc
>   NFS: Call readpage_async_filler() from nfs_readpage_async()
>   NFS: Add nfs_pageio_complete_read() and remove nfs_readpage_async()
>   NFS: Allow internal use of read structs and functions
>   NFS: Convert fscache_acquire_cookie and fscache_relinquish_cookie
>   NFS: Convert fscache_enable_cookie and fscache_disable_cookie
>   NFS: Convert fscache invalidation and update aux_data and i_size
>   NFS: Convert to the netfs API and nfs_readpage to use netfs_readpage
>   NFS: Convert readpage to readahead and use netfs_readahead for fscache
>   NFS: Allow NFS use of new fscache API in build
>   NFS: Ensure proper page unlocking when reads fail with retryable
>     errors
>
>  fs/nfs/Kconfig             |   2 +-
>  fs/nfs/direct.c            |   2 +
>  fs/nfs/file.c              |  22 ++--
>  fs/nfs/fscache-index.c     |  94 --------------
>  fs/nfs/fscache.c           | 315 ++++++++++++++++++++-------------------------
>  fs/nfs/fscache.h           | 132 +++++++------------
>  fs/nfs/inode.c             |   4 +-
>  fs/nfs/internal.h          |   8 ++
>  fs/nfs/nfs4proc.c          |   2 +-
>  fs/nfs/pagelist.c          |   2 +
>  fs/nfs/read.c              | 248 ++++++++++++++++-------------------
>  fs/nfs/write.c             |   3 +-
>  include/linux/nfs_fs.h     |   5 +-
>  include/linux/nfs_iostat.h |   2 +-
>  include/linux/nfs_page.h   |   1 +
>  include/linux/nfs_xdr.h    |   1 +
>  16 files changed, 339 insertions(+), 504 deletions(-)
>
> --
> 1.8.3.1
>

