Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B35558A05
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jun 2022 22:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiFWU1S (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Jun 2022 16:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiFWU1R (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Jun 2022 16:27:17 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF131532F4
        for <linux-nfs@vger.kernel.org>; Thu, 23 Jun 2022 13:27:16 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-3177f4ce3e2so5715737b3.5
        for <linux-nfs@vger.kernel.org>; Thu, 23 Jun 2022 13:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oElri2cYAhKVhcH1r2z6WJIXrct3UAQjkD8S0NJlGcw=;
        b=PxAYU547ixijTNIx/OBv5TMmbxEvs1bFaqvSDw/8OpVaBFgOyMrdiY2F1H6kUU3Nra
         juYN6KGZ0Ed0au57NFn0YRvO7PI5U5wmpBMcvimhDqtmGx+LOGp609lO+1Bf2k7AMXy7
         oe64kocl0rBUsWthroQRahpt26gwEB4RW2vJgOpPnif7ZpYGrObBPkoKXg63QHb6afCM
         CFpuujRPl9X7OWA/rA1sxDeVIszID+cW5p589aKnIQvzMzD0DeJdSX21/ZykdXbNAARX
         ZIYHoHDDEshBGAWN8dBjOvMfwKBGtykLL+NPOVpwJsdV56UqtS/o46JO9w3l+5scBW+I
         GkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oElri2cYAhKVhcH1r2z6WJIXrct3UAQjkD8S0NJlGcw=;
        b=C23zggOr8bvVi17S3cqRSEFoYHkGPuUtYrt9Y25ce8rmpP41MbeWt7+rrAiiOBKkT+
         YTQl7pqj7uQZNW4Kz4yydnaFIIGHZ302IQ8e8mVVtHYo/k5RdLFcfyy39328vjli9auX
         MWoaEmSXLa9WshSy31YaLU6o1FtZuES5JPgt+R1WsTT3EvEaqRAqSBC2AYpuRd5nshD4
         NQqms1OxjPRyGDTtpLV0Ahdb31SRwxbF+daX3hW5YT0GnOFt2Xw7p9IIyeK+qI8/g4no
         NxlLcwmvZhhIBAHwmm1c63rb6NYpH71CZaiSHHWKd6ixZU+0PiaIeKFWD7jjJ2TojjvB
         +/Yw==
X-Gm-Message-State: AJIora8ilLS1fhedt6xVnqvc8+uw+yQicBnw9qPpPGbFYCqkNx58Vant
        NO+NYdmh6VUJoMmDtwmOpzZ27CZVmTu2sfIfZ5GQiw==
X-Google-Smtp-Source: AGRyM1t4lMDAv9zFDBtMUmRxTxkBIM5MlV2U75f/Dpsx5X11GsiAoTO3020E31w3aDsxM2pIAKO90fIZ+g4Ke6jofRs=
X-Received: by 2002:a05:690c:102:b0:2ef:48d8:24c3 with SMTP id
 bd2-20020a05690c010200b002ef48d824c3mr12953995ywb.153.1656016035877; Thu, 23
 Jun 2022 13:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <165590626293.75778.9843437418112335153.stgit@manet.1015granger.net>
In-Reply-To: <165590626293.75778.9843437418112335153.stgit@manet.1015granger.net>
From:   Frank van der Linden <fvdl@google.com>
Date:   Thu, 23 Jun 2022 13:27:04 -0700
Message-ID: <CAPTztWayDY7ejHaQNcCr6f3iRS8B1ytMqk0iYSUpHngp7OV-FQ@mail.gmail.com>
Subject: Re: [PATCH RFC 00/30] Overhaul NFSD filecache
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
        david@fromorbit.com, tgraf@suug.ch, jlayton@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jun 22, 2022 at 7:12 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>
> This series overhauls the NFSD filecache, a cache of server-side
> "struct file" objects recently used by NFS clients. The purposes of
> this overhaul are an immediate improvement in cache scalability in
> the number of open files, and preparation for further improvements.
>
> There are three categories of patches in this series:
>
> 1. Add observability of cache operation so we can see what we're
> doing as changes are made to the code.
>
> 2. Improve the scalability of filecache garbage collection,
> addressing several bugs along the way.
>
> 3. Improve the scalability of the filecache hash table by converting
> it to use rhashtable.
>
> The series as it stands survives typical test workloads. Running
> stress-tests like generic/531 is the next step.
>
> These patches are also available in the linux-nfs-bugzilla-386
> branch of
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
>
> ---
>
> Chuck Lever (30):
>       NFSD: Report filecache LRU size
>       NFSD: Report count of calls to nfsd_file_acquire()
>       NFSD: Report count of freed filecache items
>       NFSD: Report average age of filecache items
>       NFSD: Add nfsd_file_lru_dispose_list() helper
>       NFSD: Refactor nfsd_file_gc()
>       NFSD: Refactor nfsd_file_lru_scan()
>       NFSD: Report the number of items evicted by the LRU walk
>       NFSD: Record number of flush calls
>       NFSD: Report filecache item construction failures
>       NFSD: Zero counters when the filecache is re-initialized
>       NFSD: Hook up the filecache stat file
>       NFSD: WARN when freeing an item still linked via nf_lru
>       NFSD: Trace filecache LRU activity
>       NFSD: Leave open files out of the filecache LRU
>       NFSD: Fix the filecache LRU shrinker
>       NFSD: Never call nfsd_file_gc() in foreground paths
>       NFSD: No longer record nf_hashval in the trace log
>       NFSD: Remove lockdep assertion from unhash_and_release_locked()
>       NFSD: nfsd_file_unhash can compute hashval from nf->nf_inode
>       NFSD: Refactor __nfsd_file_close_inode()
>       NFSD: nfsd_file_hash_remove can compute hashval
>       NFSD: Remove nfsd_file::nf_hashval
>       NFSD: Remove stale comment from nfsd_file_acquire()
>       NFSD: Clean up "open file" case in nfsd_file_acquire()
>       NFSD: Document nfsd_file_cache_purge() API contract
>       NFSD: Replace the "init once" mechanism
>       NFSD: Set up an rhashtable for the filecache
>       NFSD: Convert the filecache to use rhashtable
>       NFSD: Clean up unusued code after rhashtable conversion
>
>
>  fs/nfsd/filecache.c | 677 +++++++++++++++++++++++++++-----------------
>  fs/nfsd/filecache.h |   6 +-
>  fs/nfsd/nfsctl.c    |  10 +
>  fs/nfsd/trace.h     | 117 ++++++--
>  4 files changed, 522 insertions(+), 288 deletions(-)
>
> --
> Chuck Lever
>

Yep, looks good so far, thanks for doing this. Somewhat similar to my (buggy)
attempt at fixing it that I sent at the time (don't put open files on
the LRU, and
use rhashtable), but cleaner and, presumably, less buggy :)

Can't test it right now, but it seems like Wang already confirmed that it works.

- Frank
