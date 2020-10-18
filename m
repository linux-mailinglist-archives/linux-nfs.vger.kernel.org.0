Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F79291723
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Oct 2020 13:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgJRLTK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 18 Oct 2020 07:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgJRLTJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 18 Oct 2020 07:19:09 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CD4C061755
        for <linux-nfs@vger.kernel.org>; Sun, 18 Oct 2020 04:19:09 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id e22so9936306ejr.4
        for <linux-nfs@vger.kernel.org>; Sun, 18 Oct 2020 04:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vfajlmtxm9TUxgGha2uWbL0wRsvoUGFiN9g4azhwdt8=;
        b=Y+NuuheIHhins2J1W2ZKrnXL67/UM9xLxq45wbEFvetjo70AcouwAFqpGH2Vgppm/+
         dB5CbmoxdKpoWVy1e6a8xF7khL8Q5QUPPai6Ne3VoGolrNVJOUk6IZa8bs2ZNmIHBw4y
         S8Rv6eOYz9+DOf50JxqzhIKw5f1UARYKpMh+I8xEGIB3xdIcs8RDuYud/GNPf4aolmx9
         yktSd2KykOpLj/xM5RQgfNW+Lpa1MaDyoWoj9XJyDgkIlFDlfrNHiqqNoTGXkRW/WZlZ
         Dk46ZU0M3Ti20p4xtmBUOc3ZM0F4iKrH5/b2V5avT2x4aa6wZ06MNFXqCxhXYDv4YJ4D
         15Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vfajlmtxm9TUxgGha2uWbL0wRsvoUGFiN9g4azhwdt8=;
        b=C6GOeePKqrSZ/2613ZHV/3SuKi0+Akw2bikObF3MVS/DslexsbBMYsX5CKjWYgBoBD
         HF5joIHhPVUA/KeezTHaztRWWjpZqXRx9MGNwhGckjTEBkslVF3R1FC/DXHbyVjaKUW0
         jX3nEVlDMxWZ8bwxH7weysCldi3Q+HLOsJ4CQcr7YTg0ZYXnlvquZ8GfuOYrHfdMRW8s
         5hfg9rlAaHqFsY6Qc89XO1pThlxOQvU2C92se7cKsJDKAm/gKYWt5M06tt0JvMayE7iy
         SJmOCy6RarsozCthOVc6NT2GNliGoyaRAAamU8o1XSrGuj0UL2Nb5wKnVXFjTQGl2oJf
         o7+A==
X-Gm-Message-State: AOAM530bwKFm0QmoiqAJc5tpSsa66zoFx8vSXVDdfQBJNaFqSHvNmK6J
        hDAZVZDq17RdQ0IQhxzQ6rdU47VA6yjPmY1WQYHoeWXstu7nmy9N
X-Google-Smtp-Source: ABdhPJxX6VtQw0ekGjxe7dIG+MuWa69MtXlYYj+cNeKUVH8EFvgDUoVxhCMWRVsXo7ECScu5sVn6q6+EOFV9ruECt7s=
X-Received: by 2002:a17:906:b2ca:: with SMTP id cf10mr11735329ejb.65.1603019946504;
 Sun, 18 Oct 2020 04:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <02b2121f-42d1-2587-6705-ca2aadb521bc@vastdata.com>
 <20201014192659.GA23262@fieldses.org> <CAENext5RMsQXJtV-H63Ons5rovKfk0-oXW-MgBCkZi+DvRDJcQ@mail.gmail.com>
 <20201017211403.GC8644@fieldses.org>
In-Reply-To: <20201017211403.GC8644@fieldses.org>
From:   Guy Keren <guy@vastdata.com>
Date:   Sun, 18 Oct 2020 14:18:55 +0300
Message-ID: <CAENext6Roxg6aOh8hWC8+SK8jKpZ55AGiTSx0W5maRd5QHLxLg@mail.gmail.com>
Subject: Re: questions about the linux NFS 4.1 client and persistent sessions
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Oct 18, 2020 at 12:14 AM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Sat, Oct 17, 2020 at 11:40:09PM +0300, Guy Keren wrote:
> > according to what you wrote here, an NFS4ERR_DELAY response is
> > something that needs to be sent at the level of the entire compound
> > request - i.e. the server is not allowed to send a compound response
> > where the first few requests have a status of NFS4_OK, while the last
> > have a status of NFS4ERR_DELAY.
>
> Oh, no, it's absolutely fine for a server to do that.
>
> Sorry, you mentioned persistent sessions, so I assumed somehow this was
> about retries after crashes or reboots, where the client may not have
> received the reply and doesn't know whether it executed.
>
> > according to what you say, if the OPEN request is in the middle of the
> > compound request, and is preceded by state-modifying requests (e.g.
> > creation of other files, writes into other open handles, renames,
> > etc.), then the server must avoid processing them until it recalled
> > the delegation to the file (i.e. it must process the entire command to
> > make sure it doesn't need to send an NFS4ERR_DELAY response due to any
> > of the requests inside it, before it starts processing, and it must
> > also lock the state of all files involved in the request, to avoid
> > another client acquiring a delegation on any of the files in the
> > request that have an OPEN request in the same compound. alternatively,
> > it must not send an NFS4ERR_DELAY request, and instead just keep the
> > request pending until the delegation recall was completed.
>
> No, sorry for the confusion, you're correct, if the client had a bunch
> of non-idempotent ops all in one compound, and got a DELAY partway
> through, then, yes, it would have to deal with retrying only the part
> that didn't execute.

actually, it is my understanding that, with persistent sessions, the
client has no way to distinguish between a temporary network
connection loss, and a server restart, if the server stores the client
state (client_id and all stateids) in persistent store.

so suppose that the client sent two 'Open' requests in one compound.
the server finished processing the first, but then had a delegation on
the 2nd one, so it is supposed to return an NFS4_OK to the first Open
and a NFSERR_DELAY for the 2nd open (and this is also the compound
response that the server will store in its Duplicate Request Cache).
if the server had a temporary network disconnection, or had a server
restart, then when the client re-connects and re-sends this compound
request, it receives the response from the server's Duplicate Request
Cache (with OK for the first open and DELA?Y For the 2nd). than, i
presume that the client needs to accept that the first Open already
succeeded, and when creating a new session, re-send only the 2nd Open
request. does this make sense?

>
> I don't know of any client that actually does that, for what it's worth.
> The Linux client, for example, doesn't send any compounds that I can
> think of that have more than one nonidempotent op.

does it mean that the linux NFS 4.1 client will also never send two
Write requests in the same compound? and never send an Open request
which might create a file, with a Write request in the same compound?
because, although these are not non-idempotent requests, it could be
that one of them was executed while the next one was not (at least
according to the spec, the server might return NFS4ERR_DELAY for all
of the NFS4.1 Request types)?

>
> > i would assume that the same mechanism used to create the compound
> > request in the first place (adding the PUTFH in front, etc.) could be
> > used during a re-building of a smaller compound request - provided
> > that the client knows which requests from the compound were already
> > completed - and which were not.
> >
> > but i understand that there's no such mechanism today on the linux NFS
> > client kernel - which is what i initially asked - so that clarifies
> > things.
>
> Right, in theory you could imagine clients doing very general things
> with compounds.  In practice I don't know of any that do.
>
> (Not that that allows a spec-compliant server to assume they won't.)
>
> > what about a situation in which instead of a server restart event, the
> > client just disconnected before receiving a rename response, and
> > re-connected with the same session to the same session? in that case,
> > i presume that the Linux NFS client will re-send the compound request,
> > and get the results from the server's Duplicate-Request cache, without
> > returning errors to the application. correct?
>
> Right, assuming the client managed to hang on to its lease.

right. which will be the case if the server doesn't revoke state
immediately upon lease expiration, and no other client performed
conflicting requests.

>
> > and this doesn't answer the original question: how was the "persistent
> > sessions" support in the linux NFS 4.1 client tested?
>
> I don't know, sorry.

ok, thanks.

>
> > on an aside - i see that you are also the maintainer of the pynfs test
> > suite. would you be interested in patches fixing its install
> > operation, and if yes - should we send them to this mailing list, or
> > directly to you? i failed to find a mailing list dedicated to pynfs
> > development.
>
> Just send them to me, cc'd to this list.  Thanks!

ok. we'll clean-up what we have and send it within a few days. thanks.

>
> --b.

--guy keren
Vast Data
