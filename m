Return-Path: <linux-nfs+bounces-8090-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6849D1C9B
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 01:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BFD328247D
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 00:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A69C149;
	Tue, 19 Nov 2024 00:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b="fvHgE0CP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5818825
	for <linux-nfs@vger.kernel.org>; Tue, 19 Nov 2024 00:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731976717; cv=none; b=OTX2ohvD6t+FsIaCzvxZA2yzCDsiN93ywtmyqAdTx1TJxZTWmy9nLTtlRj/rKtBDX4vSr5ZjAfYi5nemGX+zWGdZg/hkrUzfQTQNJGJNo/Mn8zBOMbQBlo5AU2YIsGwbPzBq0T4Wq/HN4TmHLOrXvA7OpFxVCXsfW4LVSi3D7wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731976717; c=relaxed/simple;
	bh=0S8kmrnVglmr3hKRQAZzgVzPZdWviSDu8FL08KM3xv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aw9zpiZKgWj0fsbjMHyMNoOb0+Jen1QX+nm5YTp2483mj7bzDKzGeVqnHeh8KFdox5BTapVrjYXbAkHBNyNz8v14WkzFzeeWyblSuRPFkIWyebke9W35YVRZDPdD4Kf5wgpV5zu0KFF43c2XTmk0gefMOqYWSwa3j1MNQ7CS4Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dneg.com; spf=pass smtp.mailfrom=dneg.com; dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b=fvHgE0CP; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dneg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dneg.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cf6f367f97so5343638a12.0
        for <linux-nfs@vger.kernel.org>; Mon, 18 Nov 2024 16:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google; t=1731976713; x=1732581513; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NV+b0+gbDb+5A13HgAhpJrlIDwPaHZ7ljPk0cgsk4uk=;
        b=fvHgE0CPkdkXwbyvCAajjwFJziULhYdw0oAwFxZ9sfib8HMt9OmUFYep/zlVPZ2Jk+
         oe71ego8TrcbXlEaEhQtVRwztqZ7c5iOQTCjLOGSrx2dw+YPnqZGhVIl+5WX9KULZqqI
         5UDIEh27EhjUj9Mghu10VcndPvid7hw0D2Ut6bhhTdGiR1jSYqWoN5NaTqqG8drAbCU6
         vlOjqziXIzTIcJJxF/82cRQeX8WYetynXrK6ug714q+kG3C6nO9VaqSS4F7fTYGj2yGx
         oFi3N+JhuK0SzE0m4N3fPw5xtefcIYGa9RAWaUmm4lP3NGMavc8xfA85CUmwjnai3JvY
         OTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731976713; x=1732581513;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NV+b0+gbDb+5A13HgAhpJrlIDwPaHZ7ljPk0cgsk4uk=;
        b=D5XrqqL63YrZTdLyJ3HudfuG5Ce2/K2jWpUNnIzZ9vYhbNd3Fgl9g0ghmr+lkXX0+p
         cUwvv6GennDQhQJs+ONzM8AvBI3qah8IOo4pM0aYhliwV42ChoFQyHDk/xSxzG1HnEgz
         9kuEFY0ohEmz7yQNsmXGkqOjQng1RaeE9m79+/EIbKud1ts+XoDtzoPOqmaS6LMKk1Jv
         Sdj2c+uhnsSagQCQShCF9+wrmqS5itY5uhWUporSGfBy8mCJk2poSeJmzkJkMcgY08mr
         l5ni12nE0nkvMcAyN9fMhIO1r1BBuouzwBDX4Zr6H0Q2Sp+7mzvuUEvo65uTL/gKBhba
         Lqmw==
X-Gm-Message-State: AOJu0Yxdb8fOKyMlCEsfj1S7YwZM3bOVW89ZnLi3OZqnRhpdjqofQa8c
	+2bdjfOW1l+ktUiU2gK+BX/Ps0ohyuprfWkFt1bICjSfFAicbdg5sSLDFYpbPnbci+hlivx9j9j
	WG3HrOSOE3LMGTnIslRctqbW9SO5/r2VD2zVfJw==
X-Google-Smtp-Source: AGHT+IGYba/PyxzCZBY8lNbuTfwGaucJWL+kdJhNz+YnOa++zoaxY2LaPDl5LckYXEIWoMQR16v+05FIEwgFkqMLv4I=
X-Received: by 2002:a05:6402:210f:b0:5cf:a20:527c with SMTP id
 4fb4d7f45d1cf-5cf8fceab92mr8997036a12.21.1731976712983; Mon, 18 Nov 2024
 16:38:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023152940.63479-1-snitzer@kernel.org> <20241023155846.63621-1-snitzer@kernel.org>
 <ZyOe66m0BbAOWOyI@tissot.1015granger.net> <ZzuOEt/JjwmROMBb@tissot.1015granger.net>
In-Reply-To: <ZzuOEt/JjwmROMBb@tissot.1015granger.net>
From: Daire Byrne <daire@dneg.com>
Date: Tue, 19 Nov 2024 00:37:56 +0000
Message-ID: <CAPt2mGOTiNhcMLCcYFAQNwtn0ON5Q8RG7+Ku-dZGb11o_mVOFQ@mail.gmail.com>
Subject: Re: [PATCH v3] nfsd: disallow file locking and delegations for NFSv4 reexport
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Trond Myklebust <trondmy@hammerspace.com>, 
	Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Nov 2024 at 18:57, Chuck Lever <chuck.lever@oracle.com> wrote:
>
> On Thu, Oct 31, 2024 at 11:14:51AM -0400, Chuck Lever wrote:
> > On Wed, Oct 23, 2024 at 11:58:46AM -0400, Mike Snitzer wrote:
> > > We do not and cannot support file locking with NFS reexport over
> > > NFSv4.x for the same reason we don't do it for NFSv3: NFS reexport
>
>  [ ... patch snipped ... ]
>
> > > diff --git a/Documentation/filesystems/nfs/reexport.rst b/Documentation/filesystems/nfs/reexport.rst
> > > index ff9ae4a46530..044be965d75e 100644
> > > --- a/Documentation/filesystems/nfs/reexport.rst
> > > +++ b/Documentation/filesystems/nfs/reexport.rst
> > > @@ -26,9 +26,13 @@ Reboot recovery
> > >  ---------------
> > >
> > >  The NFS protocol's normal reboot recovery mechanisms don't work for the
> > > -case when the reexport server reboots.  Clients will lose any locks
> > > -they held before the reboot, and further IO will result in errors.
> > > -Closing and reopening files should clear the errors.
> > > +case when the reexport server reboots because the source server has not
> > > +rebooted, and so it is not in grace.  Since the source server is not in
> > > +grace, it cannot offer any guarantees that the file won't have been
> > > +changed between the locks getting lost and any attempt to recover them.
> > > +The same applies to delegations and any associated locks.  Clients are
> > > +not allowed to get file locks or delegations from a reexport server, any
> > > +attempts will fail with operation not supported.
> > >
> > >  Filehandle limits
> > >  -----------------
>
> Note for Mike:
>
> Last sentence "Clients are not allowed to get ... delegations from a
> reexport server" -- IIUC it's up to the re-export server to not hand
> out delegations to its clients. Still, it's important to note that
> NFSv4 delegation would not be available for re-exports.
>
> See below for more: I'd like this paragraph to continue to discuss
> the issue of OPEN and I/O behavior when the re-export server
> restarts. The patch seems to redact that bit of detail.
>
> Following is general discussion:
>
>
> > There seems to be some controversy about this approach.
> >
> > Also I think it would be nicer all around if we followed the usual
> > process for changes that introduce possible behavior regressions:
> >
> >  - add the new behavior, make it optional, default old behavior
> >  - wait a few releases
> >  - change the default to new behavior
> >
> > Lastly, there haven't been any user complaints about the current
> > situation of no lock recovery in the re-export case.
> >
> > Jeff and I discussed this, and we plan to drop this one for 6.13 but
> > let the conversation continue. Mike, no action needed on your part
> > for the moment, but please stay tuned!
> >
> > IMO having an export option (along the lines of "async/sync") that
> > is documented in a man page is going to be a better plan. But if we
> > find a way to deal with this situation without a new administrative
> > control, that would be even better.
>
> Proposed solutions so far:
>
> - Disable NFS locking entirely on NFS re-export
>
> - Implement full state pass-through for re-export
>
> Some history of the NFSD design and the re-export issue is provided
> here:
>
>   http://wiki.linux-nfs.org/wiki/index.php/NFS_re-export#reboot_recovery
>
> Certain usage scenarios require that lock state be globally visible,
> so disabling NFS locking on re-export mounts will need to be
> considered carefully.
>
> Assuming that NFSv4 LOCK operations are proliferated to the back-end
> server in today's NFSD, does it make sense to avoid code changes at
> the moment, but more carefully document the configuration options
> and their risks?
>
> +++ In all following configurations, no state recovery occurs when
> the re-export server restarts, as explained in
> Documentation/filesystems/nfs/reexport.rst.
>
> Mount options on the re-export server and clients:
>
> * All default: open and lock state is proliferated to the back-end
>   server and is visible to all NFS clients.
>
> * local_lock=all on the re-export server's mount of the back-end
>   server: clients of that server all see the same set of locks, but
>   these locks are not visible to the back-end server or any of its
>   clients. Open state is visible everywhere.
>
> * local_lock=all on the NFS mounts on client mounts of the re-export
>   server: applications on NFS clients do not see locks set by
>   applications on any other NFS clients. Open state is visible
>   everywhere.
>
> When an NFS client of the re-export server OPENs a file, currently
> that creates OPEN state on the re-export server, and I assume also
> on the back-end server. That state cannot be recovered if the
> re-export server restarts, but it also cannot be blocked by a mount
> option.
>
> Likewise, I assume the back-end server can hand out delegations to
> the re-export server. If the re-export server restarts, how does it
> recover those delegations? The re-export server could disable
> delegation by blocking off its callback service, but should it?
>
> What, if anything, is being done to further develop and regularly
> test NFS re-export in upstream kernels?
>
> The reexport.rst file: This still reads more like design notes than
> administrative documentation.  IMHO it should instead have a more
> detailed description and disclaimer regarding what kind of manual
> recovery is needed after a re-export server restart. That seems like
> important information for administrators who think they might want
> to deploy this solution. Maybe Documentation/ isn't the right place
> for administrative documentation?
>
> It might be prudent to (temporarily) label NFS re-export as
> experimental use only, given its incompleteness and the long list
> of caveats.

As someone who uses NFSv3 re-export extensively in production, I can't
comment much on the "correctness" of the current locking, but it is
"good enough" for us (we don't explicitly mount with local locks atm).

The unique thing about our workloads though is that other than maybe
the odd log file or home directory shell history file, a single
process always writes a new unique file and we never overwrite. We
have an asset management DB that determines the file paths to be
written and a batch system to run processes (i.e. a production
pipeline + render farm).

We also really try to avoid having either the origin backend server or
re-export server crash/reboot. But even when once a year something
does invariably go wrong, we are willing to take the hit on broken
mounts, processes or corrupted files (just re-run the batch jobs).

Basically the upsides outweigh the downsides for our specific workloads.

Coupled with FS-Cache and a few TBs of storage, using a re-export
server is a very efficient way to serve files to many clients over a
bandwidth constrained and/or high latency WAN link. In the case of
high latency (e.g. global offices), we even do things like increase
actimeo and disable CTO to reduce repeat metadata round-trips to the
absolute minimum. Again, I think we have a unique workload that allows
for this.

If the locks will eventually be passed through to the backend server,
then I suspect we would still want a way to opt out to reduce WAN
latency overhead at the expense of locking correctness (maybe just
using local locks).

I think others with similar workloads are using it in this way too and
I know Google were maintaining a howto to help customers migrate
workloads to their cloud:

https://github.com/GoogleCloudPlatform/knfsd-cache-utils
https://cloud.google.com/architecture/deploy-nfs-caching-proxy-compute-engine

Although it seems like that specific project has gone a bit quiet of
late. They also helped get the reexport/crossmount fsidd helper merged
into nfs-utils.

I have also heard others say reexports are useful for "converting"
NFSv4 storage to NFSv3 (or vice-versa) for older non-NFSv4 clients or
servers, but I'm not sure how big a thing that is in this day and age.

I guess Netapp's "FlexCache" product is a doing a similar thing to
reexporting and seems to lean heavily on NFSv4 and delegations to
achieve that? The latest version can even do write-back caching on
files (get lock first, write back later).

I could probably write a whole (longish) thread about the different
ways we currently use NFS re-exporting and some of the remaining
pitfalls if there is any interest in that...

Daire

