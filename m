Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C899EB98BA
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Sep 2019 23:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387779AbfITVBQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Sep 2019 17:01:16 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:41905 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387776AbfITVBP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Sep 2019 17:01:15 -0400
Received: by mail-ua1-f65.google.com with SMTP id l13so2674755uap.8
        for <linux-nfs@vger.kernel.org>; Fri, 20 Sep 2019 14:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k50N6Kiq1ojxndfSm+kE0orwvTIqNyUBRJom6IVzck0=;
        b=bQYYIWocnk6Hp6+DX7ngjtb6AgU7YmaFxSHBRGzjrQhYZWWPZolHclC8seR6lGLVMA
         8Ed7v6F8m4qebKVXyLwosaEC+cUeZuuuXYQaROP+LUQUdFT2/vWGU6+QX3HiR42h2rwU
         1LkOxhzAzss0keDnBRKUvue3ox4Ncg5LBbQS2aYxObQ/7n7JuyeiARCdf1oH/uCvR9Q6
         XupeAD/nToeYN/NmhD6dAWr8GGKJCTUYXIlwmKqm3bJyHg4G4YdS9kRT09fRufCv3osf
         WoJuikJfuWIRvgpHnbfM5VShrZLfcPobLtlT1S04SMG7MVNiodam5DKAKH++0sB+inUG
         CYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k50N6Kiq1ojxndfSm+kE0orwvTIqNyUBRJom6IVzck0=;
        b=YiVe8Z027REDcC1B5ZzwvUMbm+46jpaO6z4raWGo6YKftJQvjY0DsoucoNa84qGxtG
         ZM3QVfQ90T2bEP4YsgdUSIX71ISwbMFwmQSd+vFSc14Az+oXJQv9pjY0l02BX4JLfb8E
         85WZQgezR02YSWM+9NXCg+BegtZkBg7BPA57NmDokAX92iDi2Br/o78ypJLLJp8CgDIC
         Qc2hR0A35nIGm33vAkqCDKBEbd14/xlLVgKSvoTf7q88K3vcHg0tDNOWC8h3h2eSe0br
         F3MxbdC+HOCWRK/poRy4bLSPRN26DdS4RJm/ZVbXszE/Va0icxjlhOxmypsF3N/zrwqv
         9bqQ==
X-Gm-Message-State: APjAAAUby6wU5ThcudW7GPaT3mE9GX38KoXV/8zoVZEkYkoSwVTqiu/J
        OEvJ0e8mET18R9zfXDm9wxsPSt9seD4IgEIOA+w+uA==
X-Google-Smtp-Source: APXvYqx3C1L2I5OMxf5cAiddcYipZ+eN8oRvGuby/XCs/tNDpgrt1/IRJv+AuW7aAfEZeZZ7cEJPu//9O6lST3bstVk=
X-Received: by 2002:ab0:6355:: with SMTP id f21mr9528646uap.40.1569013274748;
 Fri, 20 Sep 2019 14:01:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190920112348.69496-1-trond.myklebust@hammerspace.com>
In-Reply-To: <20190920112348.69496-1-trond.myklebust@hammerspace.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 20 Sep 2019 17:01:03 -0400
Message-ID: <CAN-5tyGGtASKYC2a+Y01Qr-qBBOT+ybAEokxQdZAyASpEYO+4A@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] Various NFSv4 state error handling fixes
To:     Trond Myklebust <trondmy@gmail.com>
Cc:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

This version works for me. I went back to v2 and verified that it
didn't work so whatever you did here fixed it for me.

On Fri, Sep 20, 2019 at 7:26 AM Trond Myklebust <trondmy@gmail.com> wrote:
>
> Various NFSv4 fixes to ensure we handle state errors correctly. In
> particular, we need to ensure that for COMPOUNDs like CLOSE and
> DELEGRETURN, that may have an embedded LAYOUTRETURN, we handle the
> layout state errors so that a retry of either the LAYOUTRETURN, or
> the later CLOSE/DELEGRETURN does not corrupt the LAYOUTRETURN
> reply.
>
> Also ensure that if we get a NFS4ERR_OLD_STATEID, then we do our
> best to still try to destroy the state on the server, in order to
> avoid causing state leakage.
>
> v2: Fix bug reports from Olga
>  - Try to avoid sending old stateids on CLOSE/OPEN_DOWNGRADE when
>    doing fully serialised NFSv4.0.
>  - Ensure LOCKU initialises the stateid correctly.
> v3: Fix locking
>  - Ensure the patch "Handle NFS4ERR_OLD_STATEID in LOCKU" locks the
>    stateid when copying it in nfs4_alloc_unlockdata().
>
> Trond Myklebust (9):
>   pNFS: Ensure we do clear the return-on-close layout stateid on fatal
>     errors
>   NFSv4: Clean up pNFS return-on-close error handling
>   NFSv4: Handle NFS4ERR_DELAY correctly in return-on-close
>   NFSv4: Handle RPC level errors in LAYOUTRETURN
>   NFSv4: Add a helper to increment stateid seqids
>   pNFS: Handle NFS4ERR_OLD_STATEID on layoutreturn by bumping the state
>     seqid
>   NFSv4: Fix OPEN_DOWNGRADE error handling
>   NFSv4: Handle NFS4ERR_OLD_STATEID in CLOSE/OPEN_DOWNGRADE
>   NFSv4: Handle NFS4ERR_OLD_STATEID in LOCKU
>
>  fs/nfs/nfs4_fs.h   |  11 ++-
>  fs/nfs/nfs4proc.c  | 209 +++++++++++++++++++++++++++++++--------------
>  fs/nfs/nfs4state.c |  16 ----
>  fs/nfs/pnfs.c      |  71 +++++++++++++--
>  fs/nfs/pnfs.h      |  17 +++-
>  5 files changed, 233 insertions(+), 91 deletions(-)
>
> --
> 2.21.0
>
