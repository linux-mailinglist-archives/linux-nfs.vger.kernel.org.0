Return-Path: <linux-nfs+bounces-6385-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3A997550D
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Sep 2024 16:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09C431C210AC
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Sep 2024 14:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF141714AC;
	Wed, 11 Sep 2024 14:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KJlrS9Iq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B15187543
	for <linux-nfs@vger.kernel.org>; Wed, 11 Sep 2024 14:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726064026; cv=none; b=huwP+VMdlZpLSFPnm/iA7u5RqNtaykcrKaKZq1zvUJx0tpci5Nz99iPb8n5it4vTJPRouvtww06YtNDLc+VsFfOva+puVv3YJvYOIWVjcxsWmPV0RlYmukh6oYaCLlNEZkf3KCuxuLvW60BrTDOYZvtTWcYMK53jtX1BO6o4zbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726064026; c=relaxed/simple;
	bh=raXG+W/QLsGvXqbpkv/p6o4PDADB8UjBuBOCfqvv5Eo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iwG/TTwoTYjUIxK5fNHBzOd0A9JOQhFbFNaYcp/Lgtn8RGc2aD0ncyd700Q6B2kBPCbHVfK+nz7w2iNO8Hf39lOc7HBFzhjPfEPQ82+hA70KsE/HaOrt+nzSBgXfkbGYfAYNhW1yH867BzAGUilP1j+uIzaZbwwN8wKNYnlLldM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KJlrS9Iq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726064023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w9wcQNYeqn02ssmev10WvVrYkLldqddYOHzo71jwuUw=;
	b=KJlrS9Iq7H5pSH9X6NRAN3EhjsVux99UL1vHYx8JbtzBE/Jlz7MRurXiBNNYpxaVNvMiF/
	yAl3jYMVZrw5/3DCGjyx6vb/PjT43ShqwAJo5U3pCLnz5pxdo4/9XBeZJg06UShHUfutst
	9rXcYOYjWAiufUorxGFDR4t8WSm9QiY=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-Vjr2gU-NNy2V2ko5wRDZrQ-1; Wed, 11 Sep 2024 10:13:42 -0400
X-MC-Unique: Vjr2gU-NNy2V2ko5wRDZrQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2f761cfa667so28567641fa.3
        for <linux-nfs@vger.kernel.org>; Wed, 11 Sep 2024 07:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726064021; x=1726668821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9wcQNYeqn02ssmev10WvVrYkLldqddYOHzo71jwuUw=;
        b=D8rNcWawMocX91ABe8H3LthpcRE5BWsWuo0Gr2/WdRAlyVIpfEjeVrI33EeTB1oUbC
         KMo9ttjPjyJmDgUWBm+n/2cA9Pr8p0yuDIrY7xXzKbvJqTNQ09oKq0ijZeUDGzsMB2fK
         5Qe41MW2nGS9uqu8vuJMn7qYycgbSLlIRD/orktgSJmOFjcBz0mV2ncf6RrIBXDPCv6r
         ZZUiEO9611QB3YdYpkpfz+zDskyaUbVjIwIYES1WMUEI0jq7m4quVtwhqJrDsGGnrZqw
         iocAbLy3ebSOY1MVZkqPF+1DKesFjwRrlRtGBqgE4fTzC2hHC0npzmOzZEG/jfklZih+
         l1Cw==
X-Forwarded-Encrypted: i=1; AJvYcCX7IGZMocsidyy4OYAIFa4LVhWp2jwK8VrXSOa/yPYQaJUNV1OhjW367LCN8sNAZXYuKpi6aZ91dE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUh/Og68oV81XCHhdrZNyopxKquYiu7sv9X7asPe0dNtcl8JOg
	uIBNtUD3LOko72RGNtuAeeMiwoqGR8slWkClYhhaaZwESHjurcrcOE/fx5liCIQzgMeaelA6nPH
	oqjNB37Hh+lWBv2pIH8Hihje6pgyB4MuvWw/3wAfJNLNzAsnMLLDfMfzN2D39CuwnD+jAd5BaaI
	S10BDz/S5ySg9rH27Xuk5rgB+6SWA8TnwnF3Cv9F2k
X-Received: by 2002:a05:651c:1991:b0:2f0:1a19:f3f1 with SMTP id 38308e7fff4ca-2f751eaece2mr127763921fa.7.1726064020438;
        Wed, 11 Sep 2024 07:13:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHB/hsnlmgTNPSoy2+9CBrtPCzOZWp1u/Vm9R8g8yhfGlda5DEQ1Fi2d0gWmuiXHaseTz5SbHMRbMcsMzMhSLQ=
X-Received: by 2002:a05:651c:1991:b0:2f0:1a19:f3f1 with SMTP id
 38308e7fff4ca-2f751eaece2mr127763391fa.7.1726064019142; Wed, 11 Sep 2024
 07:13:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172585839640.4433.13337900639103448371@noble.neil.brown.name>
 <adadfa97e30bc4d827df194814e4e05aa26b8266.camel@kernel.org> <172601280603.4433.1920807234970803580@noble.neil.brown.name>
In-Reply-To: <172601280603.4433.1920807234970803580@noble.neil.brown.name>
From: Olga Kornievskaia <okorniev@redhat.com>
Date: Wed, 11 Sep 2024 10:13:28 -0400
Message-ID: <CACSpFtDNpOMfRt1Msbo4XNaja5_Nuhxd5Vs51UvjCap5Z9-wLg@mail.gmail.com>
Subject: Re: [PATCH] nfsd: fix delegation_blocked() to block correctly for at
 least 30 seconds
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 8:00=E2=80=AFPM NeilBrown <neilb@suse.de> wrote:
>
> On Mon, 09 Sep 2024, Jeff Layton wrote:
> > On Mon, 2024-09-09 at 15:06 +1000, NeilBrown wrote:
> > > The pair of bloom filtered used by delegation_blocked() was intended =
to
> > > block delegations on given filehandles for between 30 and 60 seconds.=
  A
> > > new filehandle would be recorded in the "new" bit set.  That would th=
en
> > > be switch to the "old" bit set between 0 and 30 seconds later, and it
> > > would remain as the "old" bit set for 30 seconds.
> > >
> >
> > Since we're on the subject...
> >
> > 60s seems like an awfully long time to block delegations on an inode.
> > Recalls generally don't take more than a few seconds when things are
> > functioning properly.
> >
> > Should we swap the bloom filters more often?
>
> Or should we take a completely different approach?  Or both?
> I'm bothered by the fact that this bug in a heuristic caused rename to
> misbehave this way.  So I did some exploration.
>
> try_break_deleg / break_deleg_wait are called:
>
>  - notify_change() - chmod_common, chown_common, and vfs_utimes  waits
>  - vfs_unlink() - do_unlinkat waits for the delegation to be broken
>  - vfs_link() - do_linkat waits
>  - vfs_rename() - do_renameat2 waits
>  - vfs_set_acl() - waits itself
>  - vfs_remove_acl() - ditto
>  - __vfs_setxattr_locked() - vfs_setxattr waits
>  - __vfs_removexattr_locked() - vfs_removexattr waits
>
> I would argue that *none* of these justify delaying further delegations
> once the operation itself has completed.  They aren't the sort of things
> that suggest on-going cross-client "sharing" which delegations interfere
> with.

I wouldn't discount these operations (at least not rename) from being
an operation that can't represent "sharing" of files. An example
workload is where a file gets generated, created, written/read over
the NFS, but then locally then transferred to another filesystem. I
can imagine a pipeline, where then file gets filled up and the
generated data moved to be worked on elsewhere and the same file gets
filled up again. I think this bug was discovered because of an setup
where there was a heavy use of these operations (on various files) and
some got blocked causing problems. For such workload, if we are not
going to block giving out a delegation do we cause too many
cb_recalls?

> I imagine try_break_lease would increment some counter in ->i_flctx
> which prevents further leases being taken, and some new call near where
> break_deleg_wait() is called will decrement that counter.  If waiting
> for a lease to break, call break_deleg_wait() and retry, else
> break_deleg_done().
>
> Delegations are also broken by calls break_lease() which comes from
> nfsd_open_break_lease() for conflicting nfsd opens.  I think there *are*
> indicitive of shares and *should* result in the filehandle being recorded
> in the bloom filter.
> Maybe if break_lease() in nfsd_open_break_lease() returns -EWOULDBLOCK,
> then the filehandle could be added to the bloom filter at that point.

What about vfs_truncate() which also calls break_lease?

> do_dentry_open also calls break_lease() but we still want the filehandle
> to go in the bloom-filter in that case ....  maybe the lm_break callback
> could check i_writecount and i_readcount and use those to determine if
> delaying delegations is appropriate.
>
> wrt the time to block delegation for, I'm not sure that it matters much.
> Once we focus the delay on files that are concurrently opened from
> multiple clients (not both read-only) I think there are some files
> (most) that are never shared, and some files that are often shared.  We
> probably don't want delegations for often shared files at all.  So I'd
> be comfortable blocking delegations on often-shared files for quite a
> while.

So perhaps rename might be an exception among the operations that are
triggering delegation recalls. Though I think unlink might be similar
and truncate. Otherwise, perhaps optimizing other operation would be
useful. However, I would like to ask does the added complexity justify
the benefits? What kind of workload would be greatly penalized? If we
imagine the other operations are low occurrence (ie not representing a
sharing example) then the penalty is just an infrequent 60s block.

> I wouldn't advocate for *longer* than 30 seconds because I don't want
> the bloom filters to fill up - that significantly reduced their
> usefulness.  So maybe we could also swap filters when the 'new' one
> becomes 50% full....

I was suggesting changing that value to 15 because it would mean that
at most the wait would be 30s which is same as what it was before the
fix but we are imposing at least 15s block and it keeps the filter 'at
the same capacity as before'.  But of course in the case of heavy
conflicting operations there will be less blockage and more recalls.
This is where I was hoping a configurable value might be handy. Or, I
would instead argue that we implement a heuristic of detecting that
the server is in a state of frequent delegation recall phase and then
automatically adjust the value for how long the delegations are
blocked. Perhaps  we keep a counter in the bloom_filter when a block
is set and when a threshold is reached we increase the value before we
swap the filters (yes at the risk of having a full bloom filter but
because it's better to be cautious in giving out delegations when
there are frequent recalls?). Then, with perhaps another timer we
adjust the block time down.... Wouldn't that cover either having
different NFS clients having conflicting opens or having some workload
that has NFS/local file system conflicts.


>
> NeilBrown
>


