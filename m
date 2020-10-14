Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B59528E73E
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Oct 2020 21:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390610AbgJNT1B (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Oct 2020 15:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389668AbgJNT1B (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Oct 2020 15:27:01 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391C0C061755
        for <linux-nfs@vger.kernel.org>; Wed, 14 Oct 2020 12:27:01 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id B41C23F5; Wed, 14 Oct 2020 15:26:59 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org B41C23F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1602703619;
        bh=Uu9rvFn8NQSCrAONDF2dYJXEqyokOKR0zKYJisC2p/s=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=ORaBd3YxY326lzIS91+7D+OzOKgkccHIg9gZdL4AS1z7N56k+v8BPpuoCUVmZpFDR
         RIc7YUmvT+9uAGX/EsaA0V/aaMIeuKpr/HWT2P81O+gYvDs9pKwU7pDA53iJg0J7Ed
         Hdv8pE8vyecn0s4rzacQsBSd7ziDy5isOe9dlWsI=
Date:   Wed, 14 Oct 2020 15:26:59 -0400
To:     guy keren <guy@vastdata.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: questions about the linux NFS 4.1 client and persistent sessions
Message-ID: <20201014192659.GA23262@fieldses.org>
References: <02b2121f-42d1-2587-6705-ca2aadb521bc@vastdata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <02b2121f-42d1-2587-6705-ca2aadb521bc@vastdata.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Oct 10, 2020 at 11:39:30PM +0300, guy keren wrote:
> during the design, we encountered some issues with high-availability
> and persistent sessions handling by the linux NFS client, and i
> would like to understand a few things about the linux NFS client - i
> read all relevant material on www.linux-nfs.org, and spent a while
> reading the relevant recovery code in the nfs4.1 client kernel
> sources, but i am missing some things (a pointer to the relevant
> part in the recovery code will be appreciated as well):
> 
> 
> 1. suppose there is a persistent session that got disconnected
> (because of a server restart, for example). i see that the client is
> re-sending all the in-flight commands as part of
> 
>     the recovery. however, suppose that one of the commands was a
> compound command containing 2 requests, and the reply to the first
> of them was NFS4_OK, and to the 2nd it was NFS4ERR_DELAY - will the
> client's code know that after it finishes recovery of the session -
> then when it creates a new session, it needs to re-send the 2nd
> request in this compound command?

If the client received the reply, it shouldn't have to resend the
compound at all.

If the client didn't see the reply, it will resend the whole compound.
Its behavior won't be affected by how the compound failed, since it
can't know that.

> the broader question is about a
> compound with N commands, where the first X have an NFS4_OK reply
> and the last N-X have NFS4_DELAY

The server always stops processing a compound at the first failure, so
N-X is always <=1.

> - will the client re-send a new
> compound with the last N-X commands after establishing a new
> session?

A resend by definition is a resend of exactly the same compound.  The
client won't break it into pieces in that way.

(And typical compounds can't be broken up that way anyway--often earlier
ops in the compound are things like PUTFH's that supply required
information to later ops.)

> 2. if there is a non-persistent session, on which the client sent a
> non-idempotent request (e.g. rename of a file into a different
> directory), and the server restarted before the client received the
> response - will the client just blindly re-send the same request
> again after establishing a new session, or will it take some
> measures to attempt to understand whether the command was already
> executed? i.e. if the server already executed the rename, then
> re-sending it will return a failure to locate the source file handle
> (because it moved to a new directory).

In a rename of A/X to B/Y, the source filehandle refers to the directory
"A", so that filehandle will still work.  You might get a NFS4ERR_NOENT
if there's nothing at A/X any more, and you could guess that meant the
rename succeeded.  But it could equally well be that your rename was
never executed, and it's somebody else's rename or unlink that caused
A/X to no longer exist.  Similarly, the A/X might have executed but
another operation might have immediately created something else at A/X.

> does the linux NFS client
> attempt to recover from this, or will it simply return an error to
> the application layer?

I suspect that's all any client does.  You can imagine all sorts of
complicated hueristics, but none of them will be 100% right.  Persistent
sessions is what you really need to fix this kind of bug.

> 3. what NFS server with persistent sessions is used (or was used)
> when testing the persistent sessions support in the linux NFS
> client? the linux NFS server, as far as i understood, cannot support
> persistent sessions (due to lack of assured persistent memory).

I don't think any special hardware is necessary.  Or if it is, we could
just disable the feature in the absence of that hardware.  Mainly what
we need is some cooperation from the filesystem--some way the can ID
particular operations so the server can ask the filesystem if a
particular operation was committed to disk.  I talked to the XFS
developers about it informally and they seemed open to the idea, but
they need some sort of explanation of the requirements and I haven't
gotten around to it....

--b.
