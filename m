Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E518771674
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Aug 2023 21:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjHFTLr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 6 Aug 2023 15:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHFTLq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 6 Aug 2023 15:11:46 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA9F1712
        for <linux-nfs@vger.kernel.org>; Sun,  6 Aug 2023 12:11:45 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bbdc05a93bso24659645ad.0
        for <linux-nfs@vger.kernel.org>; Sun, 06 Aug 2023 12:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691349104; x=1691953904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgnXe3DIhLCy97RR8wNSfgmGaxfU7orpp2UUskFMu24=;
        b=hAWAjnqWVnyRaqS0zQwS7ryMxO/daI1pCxV3B7i3Dc3UnS++Ny3eVc192wT08mMZ55
         fDdYXWFbFkfbZjxPdLor6S4m2qWbmPWzkZsA1fNyxlsNkUfxI6nuLosKeM+LZFxgGZE8
         0WBRGIvih8QA3KRuDxPc7xAeP1xTNVnTRZNLrKZi1abg+aJU1JvsAt8kvrUeZwnGuvFd
         HwSCvNU+B9kfGUpD9kiwrn9oPZ/8VR4mityZ8MpU6OE6wnJENpalMDDLM74IBbnIIDrh
         Gnkc8ntFfHhYYY53Z262oEYp+I3gWDx4DgN/tn0w5zrzSWYa2JZD8TxMVUxDugk0JAXV
         SI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691349104; x=1691953904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jgnXe3DIhLCy97RR8wNSfgmGaxfU7orpp2UUskFMu24=;
        b=fZkHamNaGYJW3a9GHblzDRq+fRVbK1tdhQ/sJjmu0VA7u/tVxlcrETD8bjW6C2MTRK
         s69z7mPmekCES9f9LNpAjJjktBZCa+PnE/3v1C+F13kndXO5dGEb3XOKJBSn9hzaxx5p
         YIuuYo4NrxGhNw/aN39RLurVKixiDp8wxub9JDTg+yWyQw4TdcrePY+POEzfNSH+iEzd
         ocwaOVJVkDdD25roeHB491QE8cMT7ekbtVWQcqClR6P2Ufygg9H2PdIsCTGtsTe17VMs
         R61Ugo4h8GUT47MS1QV+fgd5B/q464XtgB5mKrb6sIFjW3c6ZnDNJYyQUGOJ/EKGq3dU
         KGGg==
X-Gm-Message-State: AOJu0YyOiP/Ldl5zA+au31mOoP6TUzZyif6AmGsLi1EIrhd82qt5WrAZ
        rRiTevVvX5AzF0qhhiDjbr9nhVZMz+bu4XpQWQ==
X-Google-Smtp-Source: AGHT+IGegUkg5SwifFwRAFw4QQza1VAiCPGGrqbXzEgtOkrj6F0wQ8xrCMKju+XT/8RVSM8F29bOddfVqEghR/yvHNI=
X-Received: by 2002:a17:902:db04:b0:1b6:8a99:4979 with SMTP id
 m4-20020a170902db0400b001b68a994979mr7962174plx.22.1691349104520; Sun, 06 Aug
 2023 12:11:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAM5tNy4d02dOyWsVk7Y-nFEyGjE=eo4nJgrap3M5DebDJz9ehw@mail.gmail.com>
 <42DE2EB5-E2E5-45D6-B0B9-8C63FD6DC67D@oracle.com> <CAM5tNy7UL_mG20uHEgBjgK2B4d2JiT8Z6QknO1-6ByQ8GpOGNg@mail.gmail.com>
 <ZM/KIQY8WOXSvSX6@tissot.1015granger.net>
In-Reply-To: <ZM/KIQY8WOXSvSX6@tissot.1015granger.net>
From:   Rick Macklem <rick.macklem@gmail.com>
Date:   Sun, 6 Aug 2023 12:11:33 -0700
Message-ID: <CAM5tNy5PT4PG0Z3tn0TL0=oYbTevLjMj=aAB65oxEt3NX7_cFQ@mail.gmail.com>
Subject: Re: RFC: new attributes
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Noveck <davenoveck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Aug 6, 2023 at 9:28=E2=80=AFAM Chuck Lever <chuck.lever@oracle.com>=
 wrote:
>
> On Sat, Aug 05, 2023 at 03:05:59PM -0700, Rick Macklem wrote:
> > On Sat, Aug 5, 2023 at 7:51=E2=80=AFAM Chuck Lever III <chuck.lever@ora=
cle.com> wrote:
> > >
> > > Hi Rick -
> > >
> > > > On Aug 4, 2023, at 6:18 PM, Rick Macklem <rick.macklem@gmail.com> w=
rote:
> > > >
> > > > Hi,
> > > >
> > > > I wrote an IETF draft proposing a few new attributes for NFSv4.2.
> > > > Since there did not seem to be interest in them, I just
> > > > let the draft expire.  However, David Noveck pinged
> > > > me w.r.t. it, so I thought I'd ask here about it.
> > > >
> > > > All the attributes are meant to be "read only, per server file syst=
em":
> > > > supported_ops - A bitmap of the operations supported.
> > > >     The motivation was that NFS4ERR_NOTSUPP is supposed to
> > > >      be "per server", although the rumour was that the Linux knfsd
> > > >      uses it "per server file system".
> > >
> > > Before crafting new protocol, we should have a look at server
> > > implementation behavior to see if it can be improved in this
> > > area.
> > >
> > > Is Linux the only problematic implementation? Send email,
> > > bug reports, or patches... we'll consider them.
> > >
> > This was discussed on the IETF working group mailing list some years
> > ago.  I was asking if NFS4ERR_NOTSUPP could be used "per server
> > file system" or "per server". Tom Haynes said his intent was "per serve=
r",
> > but that was not clear in the RFC.  The only place in any RFC where it
> > seemed to indicate "per server" was the definition for NFS4ERR_NOTSUPP
> > as follows:
> > 15.1.1.5.  NFS4ERR_NOTSUPP (Error Code 10004)
> >
> >    Operation not supported, either because the operation is an OPTIONAL
> >    one and is not supported by this server or because the operation MUS=
T
> >    NOT be implemented in the current minor version.
> >
> > Bruce Fields noted that he thought the Linux knfsd was doing NFS4ERR_NO=
TSUPP
> > w.r.t. optional 4.2 operations on a "per file system basis" and there w=
as some
> > mumbling to the effect that it should be applicable "per server file sy=
stem".
> >
> > In FreeBSD, certain 4.2 operations (such as Allocate) can only be done
> > on certain file systems.
> > Without a way to indicate to a client that this operation is supported =
on
> > file system X but not file system Y, the server is forced to not suppor=
t the
> > operation. (It is currently controlled by a tunable that a sysadmin cou=
ld
> > set incorrectly and result in NFS4ERR_NOTSUPP for some of the file
> > systems. As such, you could say that the FreeBSD server can do this.)
> >
> > I do not have a Linux server with various types of file systems to conf=
irm
> > if what Bruce Fields thought was the case is actually the case.
>
> I wondered if the subtle difference between "per-server" and "per-
> server filesystem" would have implications for extensibility (RFC
> 8178) but I don't see anything specific there. It distinguishes
> between
>
>   NFS4ERR_ILLEGAL - operation is not valid for this minor version
>
> and
>
>   NFS4ERR_NOTSUPP - operation is valid for this minor version but is
>   not supported by this implementation
>
> Because the specs are not clear about this, a client could remember
> the support status of an operation and not use that operation at all
> when a server shares a mix of filesystems that support a feature and
> filesystems that do not.
>
> But it looks like we have a de facto deviation from what was intended
> but not written in the protocol specs -- NFS4ERR_NOTSUPP is used by
> some implementations on a per-filesystem basis (not that I've actually
> audited the Linux server implementation yet).
>
> I would find documenting this de facto interpretation more palatable
> than adding a new bitmask attribute.
>
I certainly have no problem with NFS4ERR_NOTSUPP being used
"per server file system".

>
> > > > dir_cookie_rising - Only useful for directory delegations, which no
> > > >      one seems to be implementing.
> > >
> > > We've been talking privately and informally about implementing
> > > directory delegation in the Linux NFS server, so this one
> > > could be interesting. But there aren't enough details here to
> > > know whether this new attribute would be useful to us.
> > >
> > I wrote a bunch of code implementing directory delegations on FreeBSD,
> > but never completed the work to the point of testing.
> > I found that, for FreeBSD, it was infeasible to implement the client si=
de
> > for server file systems where the directory offset cookie was not monot=
onically
> > increasing. (Basically maintaining ordering of "directory chunks" becau=
se too
> > difficult with being able to do so based on directory offset cookie ord=
ering.)
> >
> > So, my implementation, if even completed, would only work for the case =
of
> > monotonically increasing directory offset cookies and detecting that th=
at is
> > not the case "on the fly" would have been messy.
>
> I'm still not clear on what "monotonically increasing directory
> offsets" means.
>
> I'm familiar with only a couple of Linux filesystems, and they seem
> to use distinct offset values that increase monotonically as new
> entries are created in the directory. The offset values do not
> confer any particular information about entry locality.
>
When you implement client side caching of directory chunks and you
have a directory delegation for the directory, you can get notifications.
For example, take NOTIFY4_ADD_ENTRY:
- In that notify, there is nad_prev_entry, which has the pe_prev_entry_cook=
ie.
--> Now you need to find "prev entry". If the directory offset cookies are
      monotonically increasing, each cached directory chunk can be keyed by
      the directory offset cookie of the first entry in the chunk and
the next chunk
      will be keyed with the first directory offset cookie, which has
a value greater
      than the one that preceeds it.
      --> Easy to figure out which chunk holds the prev_entry, so that the =
new
            entry can be added after it.
      Without this ordering, I couldn't come up with an easy way to find th=
e
      previous entry except doing a linear search of the entire cache.
      Also, if the cache does not hold the entire directory then even a lin=
ear
      search could fail to find a match. Then what? (Read in the entire
      directory to try and find the prev_entry?)
      --> If the directory_offset_cookies are monotonically increasing, the=
n
            it is easy to see where the prev_entry would go, if it is not i=
n the
            cache and all that needs to be done is read in a chunk starting
            a prev_entry's directory offset cookie and then add that chunk =
to
            the cache (making sure you do not add duplicates of later entry=
ies).

Maybe I missed something, but at least for the way FreeBSD maintains in
kernel memory caches of chunks, it was pretty straightforward to do the cas=
e
case of monotonically increasing directory offset cookies (with each chunk
keyed by the directory offset cookie of the first entry in the chunk).
Without the monotonically increasing property for directory offset cookies,
it was not feasible for my implementation attempt.
(The client implementation I coded was pretty complete, but has neve been
  tested because I never got around to doing a server implementation and
  no one else has either.)

>
> > > > seek_granularity - The smallest size of unallocated region reported
> > > >      be the Seek operation.  FreeBSD has a pathconf(2) variable cal=
led
> > > >      _PC_MIN_HOLE_SIZE that an application can use to decide if
> > > >      lseek(SEEK_DATA/SEEK_HOLE) is useful.
>
> I checked. On Linux, fpathconf(3) does not list a MIN_HOLE_SIZE
> variable, fwiw.
>
>
> > > I'm not aware of a scenario where the Linux server would provide
> > > a value not equal to 1, so it would be easy for us to implement.
> > A value of 1 is of limited use. If an application is going to use the
> > information (btw, I think this pathconf name was in Solaris?), the
> > size (such as 32K or 128K) can be more useful.
> > --> No point in doing Seek if the data is not sufficiently sparse.
>
> To provide an implementation there just needs to be a clear use case
> for it and a clear explanation for the semantics of that value
> provided by an open specification.
>
>
> > > What would clients do with this information, aside from filling
> > > in a pathconf field? Might this value be of benefit for READ_PLUS?
> > As proposed, it does not give indications of "sparseness" for individua=
l
> > files. It would, however, indicate if READ_PLUS can be useful.
> > --> If the server returns 0, there is no point in performing READ_PLUS.
> > (This was not explicitly stated in the draft, but should be.)
>
> That's where I'm thinking the benefit might be for clients that
> implement READ_PLUS but do not care about MIN_HOLE_SIZE.
>
>
> > > > max_xattr_len - Allows the client to avoid attempting to Setxattr a=
n
> > > >     attribute that is larger than the server file system supports.
> > >
> > > Can you elaborate on the problem you are trying to solve? Why
> > > isn't the current situation adequate?
> > For FreeBSD, an application can attempt to set a very large extended
> > attribute (I've actually done a 1Gbyte one on ZFS during testing).
> > As such, for NFSv4.2 it can attempt one up to the maximum allowable
> > size for a compound (a little over 1Mbyte).
> >
> > Without this attribute, most servers will fail with NFS4ERR_XATTR2BIG,
> > resulting in a fair amount of "on the wire" traffic for some applicatio=
n
> > that insists on doing large ones a lot.
> >
> > This attribute would allow the client to avoid putting Setxattr operati=
ons
> > with too large an attribute "on the wire", but it is a minor optimizati=
on.
>
> The Linux server restricts the maximum size of RPC messages during
> CREATE_SESSION, so it wouldn't be possible to write more than about
> a megabyte at maximum to an xattr residing on Linux. But I believe
> many of our local filesystem implementations do not support xattrs
> much larger than 64KB. This limit very likely varies depending on
> the filesystem.
>
> IMO large xattrs were not in the minds of the authors of RFC 8276.
> If applications want to store large amounts of data in secondary
> byte streams, they should use named attributes instead, since a
> named attribute I believe is written with WRITE, which enables
> extending the attribute size after it's been created.
>
> I remember also there was a question of write atomicity when we
> discussed this before. Atomicity and large writes generally do not
> mix for the most common Linux filesystem implementations.
I agree with all of the above. It would simply be convenient if the
Linux server could tell the FreeBSD client that nothing over 64K
works, so do not bother to try. Like Linux, FreeBSD does currently
limit the SETXATTR operation to approximately 1Mbyte, due to the
maximum limit of compound size specified via. ExchangeID.

rick
