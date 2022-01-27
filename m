Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1707049EC25
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jan 2022 21:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiA0UGj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Jan 2022 15:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiA0UGj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Jan 2022 15:06:39 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D0DC061714
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jan 2022 12:06:39 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id D9C69608A; Thu, 27 Jan 2022 15:06:38 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org D9C69608A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1643313998;
        bh=9959/BUjXBc0N1kAx1oAXJkrpAQZJaAofqwFZinX6B8=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=CQD8GoTUZ3wmFGqrwCjvfq0Brjy4gCSjMqo8phoz6J852H5MxoYMrtQrlIqqOhMb9
         X9x8Hb0hzUU4+GrEbVq5dfv0lZIZ4/FiQzTGP0iSTWxzAOK8UXOlFbT0g+kf1LbtrG
         o2ZndjiKrRMg72rJLO30ZQVTGR4PdzOTTNTgjXGY=
Date:   Thu, 27 Jan 2022 15:06:38 -0500
To:     NeilBrown <neilb@suse.de>
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] nfsd: allow NFSv4 state to be revoked.
Message-ID: <20220127200638.GB3459@fieldses.org>
References: <164325908579.23133.4781039121536248752.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164325908579.23133.4781039121536248752.stgit@noble.brown>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jan 27, 2022 at 03:58:10PM +1100, NeilBrown wrote:
> If a filesystem is exported to a client with NFSv4 and that client holds
> a file open, the filesystem cannot be unmounted without either stopping the
> NFS server completely, or blocking all access from that client
> (unexporting all filesystems) and waiting for the lease timeout.
> 
> For NFSv3 - and particularly NLM - it is possible to revoke all state by
> writing the path to the filesystem into /proc/fs/nfsd/unlock_filesystem.
> 
> This series extends this functionality to NFSv4.  With this, to unmount
> an exported filesystem is it sufficient to disable export of that
> filesystem, and then write the path to unlock_filesystem.

It's always been weird that /proc/fs/nfsd/unlock_filesystem was v3-only,
so thanks for looking into extending it to v4.

You can accomplish the same by stopping the server, unexporting, then
restarting, but then applications may see grace-period-length delays.
So in a way this is just an optimization for what's probably a rare
operation.  Probably worth it, but I'd still be curious if there's any
specific motivating cases you can share.

I guess the procedure would be to unexport and then write to
/proc/fs/nfsd/unlock_filesystem?  An option to exportfs to do both might
be handy.

> I've cursed mainly on NFSv4.1

It does inspire strong feelings sometimes.

--b.

> and later for this.  I haven't tested
> yet with NFSv4.0 which has different mechanisms for state management.
> 
> If this series is seen as a general acceptable approach, I'll look into
> the NFSv4.0 aspects properly and make sure it works there.
> 
> Thanks,
> NeilBrown
> 
> 
> ---
> 
> NeilBrown (4):
>       nfsd: prepare for supporting admin-revocation of state
>       nfsd: allow open state ids to be revoked and then freed
>       nfsd: allow lock state ids to be revoked and then freed
>       nfsd: allow delegation state ids to be revoked and then freed
> 
> 
>  fs/nfsd/nfs4state.c | 105 ++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 96 insertions(+), 9 deletions(-)
> 
> --
> Signature
