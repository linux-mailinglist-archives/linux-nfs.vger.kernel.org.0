Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7FC2914AC
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Oct 2020 23:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439088AbgJQVOF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 17 Oct 2020 17:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438951AbgJQVOF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 17 Oct 2020 17:14:05 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D79EC061755
        for <linux-nfs@vger.kernel.org>; Sat, 17 Oct 2020 14:14:05 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 1B5CD69C3; Sat, 17 Oct 2020 17:14:03 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 1B5CD69C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1602969243;
        bh=xISCgxrGA7aWrtbEgiXTDt1bZS6Z6ajPDfrhQzBZ0Sg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U07pQGyTbE1NkU1OpkXqSinFqul5MnyHqQW7DRrcBK7k/snmFO6hT/UJAvaNItaIc
         ZnugAedWTC6zKXv418MQHnZV8/xkZYkXC4XqfN9h9NqGqAULrR03j6drk181g5rCb0
         pkGltVxyuSC3UgH/oy8JI/ioYamEja+2ruGN29Lo=
Date:   Sat, 17 Oct 2020 17:14:03 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Guy Keren <guy@vastdata.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: questions about the linux NFS 4.1 client and persistent sessions
Message-ID: <20201017211403.GC8644@fieldses.org>
References: <02b2121f-42d1-2587-6705-ca2aadb521bc@vastdata.com>
 <20201014192659.GA23262@fieldses.org>
 <CAENext5RMsQXJtV-H63Ons5rovKfk0-oXW-MgBCkZi+DvRDJcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAENext5RMsQXJtV-H63Ons5rovKfk0-oXW-MgBCkZi+DvRDJcQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Oct 17, 2020 at 11:40:09PM +0300, Guy Keren wrote:
> according to what you wrote here, an NFS4ERR_DELAY response is
> something that needs to be sent at the level of the entire compound
> request - i.e. the server is not allowed to send a compound response
> where the first few requests have a status of NFS4_OK, while the last
> have a status of NFS4ERR_DELAY.

Oh, no, it's absolutely fine for a server to do that.

Sorry, you mentioned persistent sessions, so I assumed somehow this was
about retries after crashes or reboots, where the client may not have
received the reply and doesn't know whether it executed.

> according to what you say, if the OPEN request is in the middle of the
> compound request, and is preceded by state-modifying requests (e.g.
> creation of other files, writes into other open handles, renames,
> etc.), then the server must avoid processing them until it recalled
> the delegation to the file (i.e. it must process the entire command to
> make sure it doesn't need to send an NFS4ERR_DELAY response due to any
> of the requests inside it, before it starts processing, and it must
> also lock the state of all files involved in the request, to avoid
> another client acquiring a delegation on any of the files in the
> request that have an OPEN request in the same compound. alternatively,
> it must not send an NFS4ERR_DELAY request, and instead just keep the
> request pending until the delegation recall was completed.

No, sorry for the confusion, you're correct, if the client had a bunch
of non-idempotent ops all in one compound, and got a DELAY partway
through, then, yes, it would have to deal with retrying only the part
that didn't execute.

I don't know of any client that actually does that, for what it's worth.
The Linux client, for example, doesn't send any compounds that I can
think of that have more than one nonidempotent op.

> i would assume that the same mechanism used to create the compound
> request in the first place (adding the PUTFH in front, etc.) could be
> used during a re-building of a smaller compound request - provided
> that the client knows which requests from the compound were already
> completed - and which were not.
> 
> but i understand that there's no such mechanism today on the linux NFS
> client kernel - which is what i initially asked - so that clarifies
> things.

Right, in theory you could imagine clients doing very general things
with compounds.  In practice I don't know of any that do.

(Not that that allows a spec-compliant server to assume they won't.)

> what about a situation in which instead of a server restart event, the
> client just disconnected before receiving a rename response, and
> re-connected with the same session to the same session? in that case,
> i presume that the Linux NFS client will re-send the compound request,
> and get the results from the server's Duplicate-Request cache, without
> returning errors to the application. correct?

Right, assuming the client managed to hang on to its lease.

> and this doesn't answer the original question: how was the "persistent
> sessions" support in the linux NFS 4.1 client tested?

I don't know, sorry.

> on an aside - i see that you are also the maintainer of the pynfs test
> suite. would you be interested in patches fixing its install
> operation, and if yes - should we send them to this mailing list, or
> directly to you? i failed to find a mailing list dedicated to pynfs
> development.

Just send them to me, cc'd to this list.  Thanks!

--b.
