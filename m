Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 035F4EB480
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2019 17:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfJaQP5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Oct 2019 12:15:57 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:38904 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfJaQP4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Oct 2019 12:15:56 -0400
Received: by mail-ua1-f66.google.com with SMTP id u99so2052910uau.5
        for <linux-nfs@vger.kernel.org>; Thu, 31 Oct 2019 09:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mBcC7geKiDVGBu18ige4z/8tIi8HnOkU+ln2+aW77c0=;
        b=Rj+CZQ245IOFx8uPGwIOyZ3UIycaUJ05a0WsLSzxtCHXE6SZ6GuLQHM+Vz06Dc/0ek
         hOAf2JqW5kHewFKvkp01l64M6jqHW/TsIBQyUKoiZXVHEY6JV4b8dB19XP4VR3XH8VGQ
         fnR0cJKB61DfPmXsY7VE9KJy14Co416NSc0RCJ4EeqlZRobWqika2I5YarTFR4MKkgaI
         O3mw+BU38SATeSK4sf/ozvIZRFitTfO7VCe5ZzBt4CygjgfYQzYtzua8IAVCP+6ICaS0
         RgXtJlUWQeBhwEMIZGTHXas1TEWTvGVsc1oFO4d31bpDRTpJH8RT3/z9moZdPpMgiN0j
         W1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mBcC7geKiDVGBu18ige4z/8tIi8HnOkU+ln2+aW77c0=;
        b=WYb1FAKyzrPFcxGXkM+xKgbYSus48tl1lTYPAPgo70lawtqG0dNlL3MEco0huLuRkh
         RIbpaXqmXIRpR9mAZO6d6bXMHPIuO7oH9YbnuE7o4wp2EGhQNI2ROj//yvDo2Rfh45wM
         amBYw+niOtxwFrZV1NCqOGlPqkFDZUnbwyEgataGnqSpqQcJ4CbBN50JEJXy67snfEVa
         8hs2OSrPJaaG0WrxPMauBR4fO25rybgZC+M2TOhcO86yqqYq8FelXMBOkLN9UtUOrS47
         Xjt7yV+Nr+KXK5SEzwij60JBZRTrfH1v1P1tBFttQBKCX8uGn5/1kKF/7iIO6PWJvBPL
         i+Qw==
X-Gm-Message-State: APjAAAXWX4K0fzjrEAl+mgJjqrnBDsB9WXTSVvA2wnVICXH9OsgTIJzj
        XHKaa0M798wblCtS4D8ff8SfqbEN7AoE2p/O1bk=
X-Google-Smtp-Source: APXvYqwRag9SXyrn1/NTy0P3yiT5NrGsj+oOpPa0PjPU50QA7fdFlMNBa/oBMzbYilmjdfsTKr/N6pIvOtTLziFPxGA=
X-Received: by 2002:ab0:5949:: with SMTP id o9mr3193173uad.65.1572538555475;
 Thu, 31 Oct 2019 09:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <20191023235600.10880-1-trond.myklebust@hammerspace.com>
 <CAN-5tyF3hryyjdHjcoNHHPJUDZmgtgxQDureZ+3QQmiwh2CMsA@mail.gmail.com> <CAN-5tyHLGVt4jHZNFSW_5tXFM74KGbaN=PLMb-sjq2+hbcH7YA@mail.gmail.com>
In-Reply-To: <CAN-5tyHLGVt4jHZNFSW_5tXFM74KGbaN=PLMb-sjq2+hbcH7YA@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 31 Oct 2019 12:15:44 -0400
Message-ID: <CAN-5tyFPgvCqaw17Q5jP4+uiJWv6St7enoRJ0ZK98btcOO34kw@mail.gmail.com>
Subject: Re: [PATCH 00/14] Delegation bugfixes
To:     Trond Myklebust <trondmy@gmail.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

Now that I recall the reason the Ontap server gives out the same
delegation was to deal with the linux client behaviour who sends an
open even though it holds a delegation (according to the server's
view). So what server does is it gives out the same delegation. This
patch series changes the semantics. Can you describe what you expect
the server is supposed to do in this case?

On Thu, Oct 31, 2019 at 11:49 AM Olga Kornievskaia <aglo@umich.edu> wrote:
>
> On Thu, Oct 31, 2019 at 11:27 AM Olga Kornievskaia <aglo@umich.edu> wrote:
> >
> > Hi Trond,
> >
> > This patch set produces the following in my testing. Basically what I
> > see the client is prevented from using a delegation at all.
> >
> > After I induce a race of DELEGRETURN/OPEN
> > --- the racing OPEN gets a delegation (it returns the same seqid and
> > other as the delegation being returned) but the client doesn't use it.
> > --- the following (next) OPEN that also gets a delegation immediately
> > has the client returning the given delegation.
> >
> > Disclaimer: in my testing the racing DELEGRETURN doesn't fail with
> > OLD_STATEID, NetApp returns OK.
>
> Testing the same against Linux. It prevents the client from using
> future delegation stateid. On the induced DELEGRETURN/OPEN race, the
> linux server doesn't give a new read delegation. The following open
> gets a read delegation and returns it right away.
>
>
> > On Thu, Oct 24, 2019 at 6:56 AM Trond Myklebust <trondmy@gmail.com> wrote:
> > >
> > > The following patchset fixes up a number of issues with delegations,
> > > but mainly attempts to fix a race condition between open and
> > > delegreturn, where the open and the delegreturn get re-ordered so
> > > that the delegreturn ends up revoking the delegation that was returned
> > > by the open.
> > > The root cause is that in certain circumstances, we may currently end
> > > up freeing the delegation from delegreturn, so when we later receive
> > > the reply to the open, we've lost track of the fact that the seqid
> > > predates the one that was returned.
> > >
> > > This patchset fixes that case by ensuring that we always keep track
> > > of the last delegation stateid that was returned for any given inode.
> > > That way, if we later see a delegation stateid with the same opaque
> > > field, but an older seqid, we know we cannot trust it, and so we
> > > ask to replay the OPEN compound.
> > >
> > > Trond Myklebust (14):
> > >   NFSv4: Don't allow a cached open with a revoked delegation
> > >   NFSv4: Fix delegation handling in update_open_stateid()
> > >   NFSv4: nfs4_callback_getattr() should ignore revoked delegations
> > >   NFSv4: Delegation recalls should not find revoked delegations
> > >   NFSv4: fail nfs4_refresh_delegation_stateid() when the delegation was
> > >     revoked
> > >   NFS: Rename nfs_inode_return_delegation_noreclaim()
> > >   NFSv4: Don't remove the delegation from the super_list more than once
> > >   NFSv4: Hold the delegation spinlock when updating the seqid
> > >   NFSv4: Clear the NFS_DELEGATION_REVOKED flag in
> > >     nfs_update_inplace_delegation()
> > >   NFSv4: Update the stateid seqid in nfs_revoke_delegation()
> > >   NFSv4: Revoke the delegation on success in nfs4_delegreturn_done()
> > >   NFSv4: Ignore requests to return the delegation if it was revoked
> > >   NFSv4: Don't reclaim delegations that have been returned or revoked
> > >   NFSv4: Fix races between open and delegreturn
> > >
> > >  fs/nfs/callback_proc.c |   2 +-
> > >  fs/nfs/delegation.c    | 109 +++++++++++++++++++++++++++++------------
> > >  fs/nfs/delegation.h    |   4 +-
> > >  fs/nfs/nfs4proc.c      |  13 ++---
> > >  fs/nfs/nfs4super.c     |   4 +-
> > >  5 files changed, 88 insertions(+), 44 deletions(-)
> > >
> > > --
> > > 2.21.0
> > >
