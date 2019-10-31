Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E67FEB3E2
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2019 16:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbfJaP1e (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Oct 2019 11:27:34 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:36835 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbfJaP1e (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Oct 2019 11:27:34 -0400
Received: by mail-vs1-f66.google.com with SMTP id q21so4355928vsg.3
        for <linux-nfs@vger.kernel.org>; Thu, 31 Oct 2019 08:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xqWCuM6d4ULFbjjAhfbEhiBvv/eECwBuMsLO2tl9yAM=;
        b=I1++teZn+XFAwGKR7F1TPWAif01fktqNnbrCPPqfxE560xbcNJmCaXEC/3YlXeKolQ
         WznK2KCa3UrZ4PwQfLPvWyQEc4MDghX/Bf2R0I8FR7TWrPMAyXkpxRLclgNqqAL9VuDG
         1kyBRWBfJtvla2utDS3O7GJWRCGI49Io/ozjtzvbtIP3a1HlqcWhxAZ/1qc3cvaN6X8p
         i33eQozZ1LJ9fGs+s1iB2vjYUhehYB08iUEuUl4a+wwGsKLOIY36h4A/f7hWNDqyBwWW
         8Ql+0Kmuk2MpnIFXR7vYNfhIam+5c4O0Yhax2+siaMSsTdVam6gv2j8hu60r7C4mYx8a
         MmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xqWCuM6d4ULFbjjAhfbEhiBvv/eECwBuMsLO2tl9yAM=;
        b=EgW0LWwv6WzC+zST7ZGZsxWAlsdzssVG1gUzyyzB/anLtCy61xfOJZUo7yRTkpN84s
         JhwPWc4vohcoHXjrJcwJFJsaZ8eziUuHLrMgauB5z928n3RlBoichdmxvMexN4VWRmC1
         ZRYIjuwTxyMGShgGYlhzKEaIC03n6e+c1AkWEq20M9nNe2/6saGRPgMuorIFij7FnbM7
         QObQIRv5Lzk1eXX7/XUvjUf8IcwixOX75fTbtMW5WR7OsXzKWaHowPwqDzNFpdf1qySb
         XZcT49MtF3CbvZgP8dREgQVX/c2cHlHkME9nNc4Vaf3jP+4n2O/uPtc3QSiE/oJTbgdv
         wvqQ==
X-Gm-Message-State: APjAAAUCXSPm/3Mwbjgy6V/pxxc5AG0KPEetiDEf6RbKGA8gFrSirbQv
        c3fd6QrY2h+/oR2B1ls+Iv+j3XWKbYoUK3c9++t2zw==
X-Google-Smtp-Source: APXvYqxc4m1A1QBpNZpd8ccLR6jmMddYCIJUB6IGhZ3oYIzw521DboHuaC/sDz+iBsGufOniZD0C43ycsqazcJ5LD5o=
X-Received: by 2002:a05:6102:21b4:: with SMTP id i20mr1899090vsb.164.1572535652861;
 Thu, 31 Oct 2019 08:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <20191023235600.10880-1-trond.myklebust@hammerspace.com>
In-Reply-To: <20191023235600.10880-1-trond.myklebust@hammerspace.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 31 Oct 2019 11:27:21 -0400
Message-ID: <CAN-5tyF3hryyjdHjcoNHHPJUDZmgtgxQDureZ+3QQmiwh2CMsA@mail.gmail.com>
Subject: Re: [PATCH 00/14] Delegation bugfixes
To:     Trond Myklebust <trondmy@gmail.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

This patch set produces the following in my testing. Basically what I
see the client is prevented from using a delegation at all.

After I induce a race of DELEGRETURN/OPEN
--- the racing OPEN gets a delegation (it returns the same seqid and
other as the delegation being returned) but the client doesn't use it.
--- the following (next) OPEN that also gets a delegation immediately
has the client returning the given delegation.

Disclaimer: in my testing the racing DELEGRETURN doesn't fail with
OLD_STATEID, NetApp returns OK.

On Thu, Oct 24, 2019 at 6:56 AM Trond Myklebust <trondmy@gmail.com> wrote:
>
> The following patchset fixes up a number of issues with delegations,
> but mainly attempts to fix a race condition between open and
> delegreturn, where the open and the delegreturn get re-ordered so
> that the delegreturn ends up revoking the delegation that was returned
> by the open.
> The root cause is that in certain circumstances, we may currently end
> up freeing the delegation from delegreturn, so when we later receive
> the reply to the open, we've lost track of the fact that the seqid
> predates the one that was returned.
>
> This patchset fixes that case by ensuring that we always keep track
> of the last delegation stateid that was returned for any given inode.
> That way, if we later see a delegation stateid with the same opaque
> field, but an older seqid, we know we cannot trust it, and so we
> ask to replay the OPEN compound.
>
> Trond Myklebust (14):
>   NFSv4: Don't allow a cached open with a revoked delegation
>   NFSv4: Fix delegation handling in update_open_stateid()
>   NFSv4: nfs4_callback_getattr() should ignore revoked delegations
>   NFSv4: Delegation recalls should not find revoked delegations
>   NFSv4: fail nfs4_refresh_delegation_stateid() when the delegation was
>     revoked
>   NFS: Rename nfs_inode_return_delegation_noreclaim()
>   NFSv4: Don't remove the delegation from the super_list more than once
>   NFSv4: Hold the delegation spinlock when updating the seqid
>   NFSv4: Clear the NFS_DELEGATION_REVOKED flag in
>     nfs_update_inplace_delegation()
>   NFSv4: Update the stateid seqid in nfs_revoke_delegation()
>   NFSv4: Revoke the delegation on success in nfs4_delegreturn_done()
>   NFSv4: Ignore requests to return the delegation if it was revoked
>   NFSv4: Don't reclaim delegations that have been returned or revoked
>   NFSv4: Fix races between open and delegreturn
>
>  fs/nfs/callback_proc.c |   2 +-
>  fs/nfs/delegation.c    | 109 +++++++++++++++++++++++++++++------------
>  fs/nfs/delegation.h    |   4 +-
>  fs/nfs/nfs4proc.c      |  13 ++---
>  fs/nfs/nfs4super.c     |   4 +-
>  5 files changed, 88 insertions(+), 44 deletions(-)
>
> --
> 2.21.0
>
