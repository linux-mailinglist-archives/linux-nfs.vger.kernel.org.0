Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE5A29145C
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Oct 2020 22:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438673AbgJQUk3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 17 Oct 2020 16:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438060AbgJQUk2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 17 Oct 2020 16:40:28 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09F4C061755
        for <linux-nfs@vger.kernel.org>; Sat, 17 Oct 2020 13:40:22 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ce10so8419887ejc.5
        for <linux-nfs@vger.kernel.org>; Sat, 17 Oct 2020 13:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H8DWXYXXTIHw9DDNtaT/MoXjI7bzOm7XbmRYSsYXJmg=;
        b=gBjzCkVGShfdBJ7Z19PCvwg/L3mnbk2owIv4g60+VBHaipLcFhBa6sDk/kuwo14xh2
         yEQ8z3y4CJIEB7RGF1AXl44NdICwYRzsS22rzcDONuJUzUcuNHmBy8em5/Jk3Yg3McYT
         O5sU2VK+ighr89dio7JcSh/UUb1LY2Wm0690wI/Mf7WFbl4BNSL2xWuvPH0odtGvnj/O
         Rdb+t/3X8ytVY2zg8IIpy8Urq1uX5j51Q3a+jzpgK9W/7jV6/BQqKgVI1pF0jEjW4Jzx
         TAtWuovRMKPYqY0O2fwgIKMFp9+ub3Q7zG7eQBfQ+ssP4ZP72D6jeI00peDITPdK1zvA
         3JZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H8DWXYXXTIHw9DDNtaT/MoXjI7bzOm7XbmRYSsYXJmg=;
        b=hT2M+Xqhw/rojt/NKz4qACp4r0FG1zOt2sPXnQcUi39Zx4Q2g9N9b99g0Ev6q/0on6
         9I3DuVvpDsjN1hwJnb5XDqIwdBRdgvXxDq2I22vDWmP7GjGrwFiKaK0QE/tIeeCxIfNj
         4kmpvLmBHAP1QdpgWwXbHIBxPH48aavyQqajBHJA7jjKe56mxYzr0Aq0Jmjuu53N2HWm
         2eH8f1how8asXR9G5TNeEweJZr8FAyGdQBAWTFdoqvXypZstweMmXvunjSwHHa0KgYJs
         ycnswH6NWBEwfQJoCtyXSEWjGloMfZbfoDFGQ9Qh3AiBod54z5B2RqNcZhduLcuoWUTI
         1hOw==
X-Gm-Message-State: AOAM531DKq9dUAwAJDznbZ/qbLLsq0eziDmD7R9JuEwtYNGosbs9+/FM
        7JEinUBj+X7SnlX9S5nA51qV1arZKDig69FL15t20SCQGDvMVJoJ
X-Google-Smtp-Source: ABdhPJyqwEhmzqWylLRUMv17Ay8yBoKzt9WWZ7WKW5BdQHdijEq4otMDK0x1IfF8E2BpVG9reagTqN8OXZKnkYhjcs4=
X-Received: by 2002:a17:906:bb0d:: with SMTP id jz13mr376656ejb.154.1602967220635;
 Sat, 17 Oct 2020 13:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <02b2121f-42d1-2587-6705-ca2aadb521bc@vastdata.com> <20201014192659.GA23262@fieldses.org>
In-Reply-To: <20201014192659.GA23262@fieldses.org>
From:   Guy Keren <guy@vastdata.com>
Date:   Sat, 17 Oct 2020 23:40:09 +0300
Message-ID: <CAENext5RMsQXJtV-H63Ons5rovKfk0-oXW-MgBCkZi+DvRDJcQ@mail.gmail.com>
Subject: Re: questions about the linux NFS 4.1 client and persistent sessions
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

hi Bruce,

thanks for the response. this opens up a few questions about things i
thought i understood initially, so i did a re-read of parts of the NFS
4.1 RFC (RFC 5661), and i would like to clarify some things further.
see answers below:

On Wed, Oct 14, 2020 at 10:27 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Sat, Oct 10, 2020 at 11:39:30PM +0300, guy keren wrote:
> > during the design, we encountered some issues with high-availability
> > and persistent sessions handling by the linux NFS client, and i
> > would like to understand a few things about the linux NFS client - i
> > read all relevant material on www.linux-nfs.org, and spent a while
> > reading the relevant recovery code in the nfs4.1 client kernel
> > sources, but i am missing some things (a pointer to the relevant
> > part in the recovery code will be appreciated as well):
> >
> >
> > 1. suppose there is a persistent session that got disconnected
> > (because of a server restart, for example). i see that the client is
> > re-sending all the in-flight commands as part of
> >
> >     the recovery. however, suppose that one of the commands was a
> > compound command containing 2 requests, and the reply to the first
> > of them was NFS4_OK, and to the 2nd it was NFS4ERR_DELAY - will the
> > client's code know that after it finishes recovery of the session -
> > then when it creates a new session, it needs to re-send the 2nd
> > request in this compound command?
>
> If the client received the reply, it shouldn't have to resend the
> compound at all.
>
> If the client didn't see the reply, it will resend the whole compound.
> Its behavior won't be affected by how the compound failed, since it
> can't know that.

according to what you wrote here, an NFS4ERR_DELAY response is
something that needs to be sent at the level of the entire compound
request - i.e. the server is not allowed to send a compound response
where the first few requests have a status of NFS4_OK, while the last
have a status of NFS4ERR_DELAY. i tried looking exactly where the spec
specifies the possibility of the server sending an NFS4ERR_DELAY, and
one example is on delegation recall. i am quoting from a paragraph
from section 10.2 of the spec:

===================

On recall, the client holding the delegation needs to flush modified
   state (such as modified data) to the server and return the
   delegation.  The conflicting request will not be acted on until the
   recall is complete.  The recall is considered complete when the
   client returns the delegation or the server times its wait for the
   delegation to be returned and revokes the delegation as a result of
   the timeout.  In the interim, the server will either delay responding
   to conflicting requests or respond to them with NFS4ERR_DELAY.
   Following the resolution of the recall, the server has the
   information necessary to grant or deny the second client's request.
===========================

according to what you say, if the OPEN request is in the middle of the
compound request, and is preceded by state-modifying requests (e.g.
creation of other files, writes into other open handles, renames,
etc.), then the server must avoid processing them until it recalled
the delegation to the file (i.e. it must process the entire command to
make sure it doesn't need to send an NFS4ERR_DELAY response due to any
of the requests inside it, before it starts processing, and it must
also lock the state of all files involved in the request, to avoid
another client acquiring a delegation on any of the files in the
request that have an OPEN request in the same compound. alternatively,
it must not send an NFS4ERR_DELAY request, and instead just keep the
request pending until the delegation recall was completed.

do i understand you correctly here?

>
> > the broader question is about a
> > compound with N commands, where the first X have an NFS4_OK reply
> > and the last N-X have NFS4_DELAY
>
> The server always stops processing a compound at the first failure, so
> N-X is always <=1.

granted.

>
> > - will the client re-send a new
> > compound with the last N-X commands after establishing a new
> > session?
>
> A resend by definition is a resend of exactly the same compound.  The
> client won't break it into pieces in that way.
>
> (And typical compounds can't be broken up that way anyway--often earlier
> ops in the compound are things like PUTFH's that supply required
> information to later ops.)

i would assume that the same mechanism used to create the compound
request in the first place (adding the PUTFH in front, etc.) could be
used during a re-building of a smaller compound request - provided
that the client knows which requests from the compound were already
completed - and which were not.

but i understand that there's no such mechanism today on the linux NFS
client kernel - which is what i initially asked - so that clarifies
things.

>
> > 2. if there is a non-persistent session, on which the client sent a
> > non-idempotent request (e.g. rename of a file into a different
> > directory), and the server restarted before the client received the
> > response - will the client just blindly re-send the same request
> > again after establishing a new session, or will it take some
> > measures to attempt to understand whether the command was already
> > executed? i.e. if the server already executed the rename, then
> > re-sending it will return a failure to locate the source file handle
> > (because it moved to a new directory).
>
> In a rename of A/X to B/Y, the source filehandle refers to the directory
> "A", so that filehandle will still work.  You might get a NFS4ERR_NOENT
> if there's nothing at A/X any more, and you could guess that meant the
> rename succeeded.  But it could equally well be that your rename was
> never executed, and it's somebody else's rename or unlink that caused
> A/X to no longer exist.  Similarly, the A/X might have executed but
> another operation might have immediately created something else at A/X.

i see. understood.

>
> > does the linux NFS client
> > attempt to recover from this, or will it simply return an error to
> > the application layer?
>
> I suspect that's all any client does.  You can imagine all sorts of
> complicated hueristics, but none of them will be 100% right.  Persistent
> sessions is what you really need to fix this kind of bug.

what about a situation in which instead of a server restart event, the
client just disconnected before receiving a rename response, and
re-connected with the same session to the same session? in that case,
i presume that the Linux NFS client will re-send the compound request,
and get the results from the server's Duplicate-Request cache, without
returning errors to the application. correct?

>
> > 3. what NFS server with persistent sessions is used (or was used)
> > when testing the persistent sessions support in the linux NFS
> > client? the linux NFS server, as far as i understood, cannot support
> > persistent sessions (due to lack of assured persistent memory).
>
> I don't think any special hardware is necessary.  Or if it is, we could
> just disable the feature in the absence of that hardware.  Mainly what
> we need is some cooperation from the filesystem--some way the can ID
> particular operations so the server can ask the filesystem if a
> particular operation was committed to disk.  I talked to the XFS
> developers about it informally and they seemed open to the idea, but
> they need some sort of explanation of the requirements and I haven't
> gotten around to it....

you might also need the file system to be aware of delegations at some
level, in order to break delegations held by NFS4 clients, when a
local application attempts to open a file in a conflicting manner.

and this doesn't answer the original question: how was the "persistent
sessions" support in the linux NFS 4.1 client tested?
when i tried to find an NFS 4.1 server that supports "persistent
sessions" i first went to NetApp - and doing a "node takeover"
operation on it revealed that the session is unknown on the 2nd node -
making it practically irrelevant for such scenarios (unless there is
some way to change the behaviour of this feature to behave more like
SMB3 CA volumes).

>
> --b.

on an aside - i see that you are also the maintainer of the pynfs test
suite. would you be interested in patches fixing its install
operation, and if yes - should we send them to this mailing list, or
directly to you? i failed to find a mailing list dedicated to pynfs
development.

thanks,
--guy keren
Vast Data
