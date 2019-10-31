Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6B4EB43A
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2019 16:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbfJaPts (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Oct 2019 11:49:48 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:43168 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfJaPtr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Oct 2019 11:49:47 -0400
Received: by mail-ua1-f66.google.com with SMTP id c25so2011746uap.10
        for <linux-nfs@vger.kernel.org>; Thu, 31 Oct 2019 08:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oUYSWd2rZ0rr1/qtJdeO0YuAdPBaKHHz9Eu5hO90BVo=;
        b=WsQxNF/DvW2SYNKx3/7OdIGKO0EqUvpUg6m8wqbTfADYS8yruD16B9qeSaPMHRx4a9
         WOKwmkJPftuE+LcUn99AAjs+Qy9nZkBnxDP4P6CnlWSpWJFiZtVLqDqmAmGMrt1D5aXE
         KJWxgKV8pG7jPczjWDPHPoZHBHR/FsVUcPjeUONS0P0ps1toq2fwifdlf2yhVPu/csSr
         0nh7qYiZOvIhOBV6fAZ/eHwOLFB9PulMcNEZFyAbj45lyVvmG7EW7JsOZ3MQPBHKyvxc
         DuLYC+VN/I14vFUcz8E3gvJoQCWeLNYhFbSHn7bWOL8G4sdg3bRX7gAoY2paFTMz3i1S
         9fbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oUYSWd2rZ0rr1/qtJdeO0YuAdPBaKHHz9Eu5hO90BVo=;
        b=U+tbaCfIr6g4qskBaNC5iLvNEhC9oL8Jt4ABVmZb3s6BIj04ofjcSLUa1HbFXvZJ9e
         mC3L0379s/oGOpxLAh1gLQOX+vnFq+bU+heajnzZnIlB/LSXeaep/9wWSYg03eOZbeXG
         Tsua3HG7iEci81LMWedejYo+EWUMx5T8B3tmZlHFkdHh9tcGyR0CfIo5mq5m7sM/MiGX
         RIeLkWXEOZwklu1Ak8feO7K+vUb0xUqAumH057ELt4E9NinJBmarvJ40x3XANoGptYhA
         t1z+JXtnOGnWm5XnrhTseIohj/6QgP5ZWh+k/6+xvG3xxIlXh2aU7bKl1aUGnIwA6PuA
         nWnw==
X-Gm-Message-State: APjAAAVlQpaXCtagAZygTqieDoTnqM+CPrDDckJ59Off+AFggnQeO1Ws
        hGekKvYPydsZ5ZftIjkqgPfEyLWS4aysNdQjce4=
X-Google-Smtp-Source: APXvYqwzup9YGA2XSZ4BeBxsECna4qktzFSs6ylrcKWm7hLuBCNEFiH8uKIXtjXvoUqcf1TpdgjeAtTGlswf/JzVIh8=
X-Received: by 2002:ab0:658d:: with SMTP id v13mr3231542uam.40.1572536985156;
 Thu, 31 Oct 2019 08:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <20191023235600.10880-1-trond.myklebust@hammerspace.com> <CAN-5tyF3hryyjdHjcoNHHPJUDZmgtgxQDureZ+3QQmiwh2CMsA@mail.gmail.com>
In-Reply-To: <CAN-5tyF3hryyjdHjcoNHHPJUDZmgtgxQDureZ+3QQmiwh2CMsA@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 31 Oct 2019 11:49:34 -0400
Message-ID: <CAN-5tyHLGVt4jHZNFSW_5tXFM74KGbaN=PLMb-sjq2+hbcH7YA@mail.gmail.com>
Subject: Re: [PATCH 00/14] Delegation bugfixes
To:     Trond Myklebust <trondmy@gmail.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Oct 31, 2019 at 11:27 AM Olga Kornievskaia <aglo@umich.edu> wrote:
>
> Hi Trond,
>
> This patch set produces the following in my testing. Basically what I
> see the client is prevented from using a delegation at all.
>
> After I induce a race of DELEGRETURN/OPEN
> --- the racing OPEN gets a delegation (it returns the same seqid and
> other as the delegation being returned) but the client doesn't use it.
> --- the following (next) OPEN that also gets a delegation immediately
> has the client returning the given delegation.
>
> Disclaimer: in my testing the racing DELEGRETURN doesn't fail with
> OLD_STATEID, NetApp returns OK.

Testing the same against Linux. It prevents the client from using
future delegation stateid. On the induced DELEGRETURN/OPEN race, the
linux server doesn't give a new read delegation. The following open
gets a read delegation and returns it right away.


> On Thu, Oct 24, 2019 at 6:56 AM Trond Myklebust <trondmy@gmail.com> wrote:
> >
> > The following patchset fixes up a number of issues with delegations,
> > but mainly attempts to fix a race condition between open and
> > delegreturn, where the open and the delegreturn get re-ordered so
> > that the delegreturn ends up revoking the delegation that was returned
> > by the open.
> > The root cause is that in certain circumstances, we may currently end
> > up freeing the delegation from delegreturn, so when we later receive
> > the reply to the open, we've lost track of the fact that the seqid
> > predates the one that was returned.
> >
> > This patchset fixes that case by ensuring that we always keep track
> > of the last delegation stateid that was returned for any given inode.
> > That way, if we later see a delegation stateid with the same opaque
> > field, but an older seqid, we know we cannot trust it, and so we
> > ask to replay the OPEN compound.
> >
> > Trond Myklebust (14):
> >   NFSv4: Don't allow a cached open with a revoked delegation
> >   NFSv4: Fix delegation handling in update_open_stateid()
> >   NFSv4: nfs4_callback_getattr() should ignore revoked delegations
> >   NFSv4: Delegation recalls should not find revoked delegations
> >   NFSv4: fail nfs4_refresh_delegation_stateid() when the delegation was
> >     revoked
> >   NFS: Rename nfs_inode_return_delegation_noreclaim()
> >   NFSv4: Don't remove the delegation from the super_list more than once
> >   NFSv4: Hold the delegation spinlock when updating the seqid
> >   NFSv4: Clear the NFS_DELEGATION_REVOKED flag in
> >     nfs_update_inplace_delegation()
> >   NFSv4: Update the stateid seqid in nfs_revoke_delegation()
> >   NFSv4: Revoke the delegation on success in nfs4_delegreturn_done()
> >   NFSv4: Ignore requests to return the delegation if it was revoked
> >   NFSv4: Don't reclaim delegations that have been returned or revoked
> >   NFSv4: Fix races between open and delegreturn
> >
> >  fs/nfs/callback_proc.c |   2 +-
> >  fs/nfs/delegation.c    | 109 +++++++++++++++++++++++++++++------------
> >  fs/nfs/delegation.h    |   4 +-
> >  fs/nfs/nfs4proc.c      |  13 ++---
> >  fs/nfs/nfs4super.c     |   4 +-
> >  5 files changed, 88 insertions(+), 44 deletions(-)
> >
> > --
> > 2.21.0
> >
