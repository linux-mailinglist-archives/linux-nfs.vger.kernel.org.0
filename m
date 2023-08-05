Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986EC7712D1
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Aug 2023 00:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjHEWGN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 5 Aug 2023 18:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjHEWGM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 5 Aug 2023 18:06:12 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD13130
        for <linux-nfs@vger.kernel.org>; Sat,  5 Aug 2023 15:06:10 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2693640dfa2so405414a91.3
        for <linux-nfs@vger.kernel.org>; Sat, 05 Aug 2023 15:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691273170; x=1691877970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYW8u8H0ydJZGOR0+9PvY3kQ31RjGSUNHr3P+QNv2zM=;
        b=Dh77NdlWukGLMyxyxAz8lD0Yy7gEsPWZYo2j/z8gZm67QauEKgoKTfRIipKnQzRsRy
         XDo+mDhIWuIaWcSyIvDt7QEGWBIoDUTrx6XnSARkXx6ugeIRQSHIsTnDJuf1+gyWEJE8
         uuqkBxqkvvzU7r06FMSOkD8x5rtqD3llF6DK8rPOeSXARxlETMbQVWmeNTBT23sBJGjl
         oNNMir1WqL2+4SKwSgsxHoy+d5CxY25yyE8Y8HLr7GV/rZ1jeC71EtdNCF1+1PjQSOvS
         +JpySbcGoHALET2ZBa7kDzFzpio8V+7SLgkYqBNtbMAS4R1OBirU8DdugAu05Q4ZuBSE
         4bSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691273170; x=1691877970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gYW8u8H0ydJZGOR0+9PvY3kQ31RjGSUNHr3P+QNv2zM=;
        b=LH6of+5cB3yJqoxbaw6lidflZceFq+M7mqT4chy+JG3pOkudwH6XFz2fVLBwfdLv5o
         jzVxtXw5g5KBDXk3CHRcRVFZKVdwo+RpIpYufHqPduk11NZd1jgL6s/lQof+7Icjd8pR
         /LlpGBbGR548fqClPbI9jKt/DvjaJuIVu7On/OQQZLGGE0XNAO26grYgpLuKLVO5WQ7I
         IiJmgaO1Iz1RsLoH3wWEs92dzaAumKMnFlyHr2aGjpxu/SFUE+0ZJ/3XReSO1Leff4b6
         jvglktTe04SmzekmmCzlOgGUB8r3hDBj1sw/6IMQHBHcKBRYfH1fbFKV0Qs129ZKjP6G
         nqkQ==
X-Gm-Message-State: AOJu0YyqUabZXRiBcZL1LAePkBYKu6VZj16fCsYLkem1npqAJ9gsxUNH
        Yi3ZjYlWUuD6i5Q3itYDiVcWI1d63LdEg//qj/qZFXyLfzvl
X-Google-Smtp-Source: AGHT+IH/sAcyVBmZCmpmu5tEa3kGqhOs5gJjLMpwu0NdEDSQd5EGnq8mVLJvohUYb2rn/R2Gj3xcdz6UNoDPSR1951U=
X-Received: by 2002:a17:90a:9af:b0:268:1bbb:8600 with SMTP id
 44-20020a17090a09af00b002681bbb8600mr3749461pjo.40.1691273170157; Sat, 05 Aug
 2023 15:06:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAM5tNy4d02dOyWsVk7Y-nFEyGjE=eo4nJgrap3M5DebDJz9ehw@mail.gmail.com>
 <42DE2EB5-E2E5-45D6-B0B9-8C63FD6DC67D@oracle.com>
In-Reply-To: <42DE2EB5-E2E5-45D6-B0B9-8C63FD6DC67D@oracle.com>
From:   Rick Macklem <rick.macklem@gmail.com>
Date:   Sat, 5 Aug 2023 15:05:59 -0700
Message-ID: <CAM5tNy7UL_mG20uHEgBjgK2B4d2JiT8Z6QknO1-6ByQ8GpOGNg@mail.gmail.com>
Subject: Re: RFC: new attributes
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Noveck <davenoveck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Aug 5, 2023 at 7:51=E2=80=AFAM Chuck Lever III <chuck.lever@oracle.=
com> wrote:
>
> Hi Rick -
>
> > On Aug 4, 2023, at 6:18 PM, Rick Macklem <rick.macklem@gmail.com> wrote=
:
> >
> > Hi,
> >
> > I wrote an IETF draft proposing a few new attributes for NFSv4.2.
> > Since there did not seem to be interest in them, I just
> > let the draft expire.  However, David Noveck pinged
> > me w.r.t. it, so I thought I'd ask here about it.
> >
> > All the attributes are meant to be "read only, per server file system":
> > supported_ops - A bitmap of the operations supported.
> >     The motivation was that NFS4ERR_NOTSUPP is supposed to
> >      be "per server", although the rumour was that the Linux knfsd
> >      uses it "per server file system".
>
> Before crafting new protocol, we should have a look at server
> implementation behavior to see if it can be improved in this
> area.
>
> Is Linux the only problematic implementation? Send email,
> bug reports, or patches... we'll consider them.
>
This was discussed on the IETF working group mailing list some years
ago.  I was asking if NFS4ERR_NOTSUPP could be used "per server
file system" or "per server". Tom Haynes said his intent was "per server",
but that was not clear in the RFC.  The only place in any RFC where it
seemed to indicate "per server" was the definition for NFS4ERR_NOTSUPP
as follows:
15.1.1.5.  NFS4ERR_NOTSUPP (Error Code 10004)

   Operation not supported, either because the operation is an OPTIONAL
   one and is not supported by this server or because the operation MUST
   NOT be implemented in the current minor version.

Bruce Fields noted that he thought the Linux knfsd was doing NFS4ERR_NOTSUP=
P
w.r.t. optional 4.2 operations on a "per file system basis" and there was s=
ome
mumbling to the effect that it should be applicable "per server file system=
".

In FreeBSD, certain 4.2 operations (such as Allocate) can only be done
on certain file systems.
Without a way to indicate to a client that this operation is supported on
file system X but not file system Y, the server is forced to not support th=
e
operation. (It is currently controlled by a tunable that a sysadmin could
set incorrectly and result in NFS4ERR_NOTSUPP for some of the file
systems. As such, you could say that the FreeBSD server can do this.)

I do not have a Linux server with various types of file systems to confirm
if what Bruce Fields thought was the case is actually the case.

I
>
> > dir_cookie_rising - Only useful for directory delegations, which no
> >      one seems to be implementing.
>
> We've been talking privately and informally about implementing
> directory delegation in the Linux NFS server, so this one
> could be interesting. But there aren't enough details here to
> know whether this new attribute would be useful to us.
>
I wrote a bunch of code implementing directory delegations on FreeBSD,
but never completed the work to the point of testing.
I found that, for FreeBSD, it was infeasible to implement the client side
for server file systems where the directory offset cookie was not monotonic=
ally
increasing. (Basically maintaining ordering of "directory chunks" because t=
oo
difficult with being able to do so based on directory offset cookie orderin=
g.)

So, my implementation, if even completed, would only work for the case of
monotonically increasing directory offset cookies and detecting that that i=
s
not the case "on the fly" would have been messy.

Btw, I seem to recall that the Linux client optimizes directory handling
when directory offset cookies are monotonically increasing, but shuts
that down "when it sees otherwise". I do not know if the client could
be improved in this area if it knows up front?

>
> > seek_granularity - The smallest size of unallocated region reported
> >      be the Seek operation.  FreeBSD has a pathconf(2) variable called
> >      _PC_MIN_HOLE_SIZE that an application can use to decide if
> >      lseek(SEEK_DATA/SEEK_HOLE) is useful.
>
> I'm not aware of a scenario where the Linux server would provide
> a value not equal to 1, so it would be easy for us to implement.
A value of 1 is of limited use. If an application is going to use the
information (btw, I think this pathconf name was in Solaris?), the
size (such as 32K or 128K) can be more useful.
--> No point in doing Seek if the data is not sufficiently sparse.

How useful is this? I do not know (and since Linux apparently
does not provide this information, there will be few, if any,
applications that make use of it.)

>
> What would clients do with this information, aside from filling
> in a pathconf field? Might this value be of benefit for READ_PLUS?
As proposed, it does not give indications of "sparseness" for individual
files. It would, however, indicate if READ_PLUS can be useful.
--> If the server returns 0, there is no point in performing READ_PLUS.
(This was not explicitly stated in the draft, but should be.)

>
>
> > mandatory_br_locks - Byte range locks are mandatory.  No one
> >      seems to be implementing these, but a client needs to know
> >      that mandatory locking is being enforced so that it can cache
> >      data correctly.
>
> I don't have much exposure to mandatory locking, maybe Jeff
> could chime in on this one.
>
>
> > max_xattr_len - Allows the client to avoid attempting to Setxattr an
> >     attribute that is larger than the server file system supports.
>
> Can you elaborate on the problem you are trying to solve? Why
> isn't the current situation adequate?
For FreeBSD, an application can attempt to set a very large extended
attribute (I've actually done a 1Gbyte one on ZFS during testing).
As such, for NFSv4.2 it can attempt one up to the maximum allowable
size for a compound (a little over 1Mbyte).

Without this attribute, most servers will fail with NFS4ERR_XATTR2BIG,
resulting in a fair amount of "on the wire" traffic for some application
that insists on doing large ones a lot.

This attribute would allow the client to avoid putting Setxattr operations
with too large an attribute "on the wire", but it is a minor optimization.

rick

>
> Again, I don't think this would be difficult for the Linux
> server to implement, but I'd like to know why it's needed.
>
>
> --
> Chuck Lever
>
>
