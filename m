Return-Path: <linux-nfs+bounces-5815-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26535961732
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2024 20:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C3B8B211BE
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2024 18:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA79B6EB64;
	Tue, 27 Aug 2024 18:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OgXeyN/J"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF4345024
	for <linux-nfs@vger.kernel.org>; Tue, 27 Aug 2024 18:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724784391; cv=none; b=gjrTvC063Bq/jxgTpKXd2ow3EhWC27T9B2I/uRnlmy62YtgP6kPCr/JkLy7sFyC9Gy0iM5NunnVXk/KsUG6eFrUT2ksqzwnrZu9pTvTLkTzwBT07C0R4R/ZISZ+GcoISqqtkflHcE5348mQsKK11GbpCa9Z9GjhgV/+dsB/ZNjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724784391; c=relaxed/simple;
	bh=qI6QeDbvyL06N+tCBmpgxx2r4EngHONsWaaVXwL/ids=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TGHtqPxoPvCNVI6BZ1rUWTd1RZpLu3AROqvJtTl1N4OGJNBaqfa5BwlmZnbhP21eTYYmoXobA+ZFd4gbAeMgf1j892PYdRQCHJk9CNoccGqHn2LVDJqxOY8/dpE4YmUeLM1wo0iMbRFsy2Dxws+kucpPIfx/gabRR/86IvqjUfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OgXeyN/J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724784388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j/FbElSZ5BkXgthxGyIDaiqbfuodvx2jdz11r1Jzzqs=;
	b=OgXeyN/JIw+Iji7FZuqqs3aAzfNVUzwR//wFG4ezM17pEiaCmaE5KLMTpXgyqb5v1KTRSh
	+xiiG8JAzqGTYEm+xmpxSOdXIGgCdZEFS6Y1ZZdgMKLS2jIRZn1t3u0cYnL0qmF0k6+Ho0
	EWKQdku4J6Z5WGbzAgR6Bhvo2MDcIg8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-_iP6XdMANay6iPkyj1t_4Q-1; Tue, 27 Aug 2024 14:46:27 -0400
X-MC-Unique: _iP6XdMANay6iPkyj1t_4Q-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-53350003ef9so5707612e87.1
        for <linux-nfs@vger.kernel.org>; Tue, 27 Aug 2024 11:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724784385; x=1725389185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/FbElSZ5BkXgthxGyIDaiqbfuodvx2jdz11r1Jzzqs=;
        b=cM4IIAbjRgNqg7Q0d1YYDLU7zx3Yxbd2X3ABR/8n/7fD7VvxC2LA2SuCR0X9n4KioA
         bVciyvvpGu37U83IHX/kfC+h0LKyRImgidyP2fzyS9VWTtcrlLve6pRBuIqsfwfa3oj8
         K8t6kKSVSDwJUxhPFh/cFSdmOtWED0p3m6ZME7nw1VNhdSp8yrx2c5Ef7VMhiCGktcwN
         VlkxXudu71K8z+evoLdO+zpSjEZ33QQOFF/5yG+OVPMme4fIKlRInN9BM4K5SXHzmJX8
         H2SYmTdSjIxhwg6y+4/70ilWKUuuKONIAmgK7hyQdbtn50npZzk8qpUpvI518l1CnMta
         z34w==
X-Forwarded-Encrypted: i=1; AJvYcCWdOcStSpmz3phWijncjcvwStrOObDOGTaNPfPuE3kz9GF7DQnsRqZcxkI96Yb68ecOQs4yMpHZ7DI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuin5aQO9FHn5lrqTZ9psp1P9PYH2HqwWO3Rmuehv5KpxjBRPg
	SPtdmbxuMONgDQDOiNH4fxwDwofRsUbDOLX6OunNEAYfSQOsGklaQ6BUxOEtBS6jDoixXGLdNZF
	WF5EVsbKckA/UIFel2QFdqa0ODPcNk4+P/O15QeQ4VJmFmV/+0KYa1QqP284cDRB7lBM8qFNS3F
	2yjaklPcV5FcaIucxf0EcOO7OBdz4QTH+s
X-Received: by 2002:a05:651c:b11:b0:2f3:b078:84bc with SMTP id 38308e7fff4ca-2f514a12d95mr26684431fa.4.1724784385381;
        Tue, 27 Aug 2024 11:46:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYAGQ9a7sKVjHdnZ5p4d0TtxUj+HnMHlkM449FugNMjYeRDFixGoGeYnp3wBfpAAsj+rLyAMl8mpX/6nsYXSE=
X-Received: by 2002:a05:651c:b11:b0:2f3:b078:84bc with SMTP id
 38308e7fff4ca-2f514a12d95mr26684211fa.4.1724784384820; Tue, 27 Aug 2024
 11:46:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823141401.71740-1-okorniev@redhat.com> <Zsif6pDBfVm1sUiV@tissot.1015granger.net>
 <CAN-5tyHENMDTeyESPA9ceCA=RaPMMW9ORh3NXu9RnbFiLZHRYg@mail.gmail.com> <5DEAACE7-8A92-49C5-A153-1A51452B3D32@oracle.com>
In-Reply-To: <5DEAACE7-8A92-49C5-A153-1A51452B3D32@oracle.com>
From: Olga Kornievskaia <okorniev@redhat.com>
Date: Tue, 27 Aug 2024 14:46:13 -0400
Message-ID: <CACSpFtANDfuyuRfayfc_PRe6Lhom30BwT4cA4VbuQJoOCC9hEg@mail.gmail.com>
Subject: Re: [PATCH 1/1] nfsd: prevent states_show() from using invalid stateids
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Olga Kornievskaia <aglo@umich.edu>, Jeff Layton <jlayton@kernel.org>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 11:10=E2=80=AFAM Chuck Lever III <chuck.lever@oracl=
e.com> wrote:
>
>
>
> > On Aug 23, 2024, at 11:03=E2=80=AFAM, Olga Kornievskaia <aglo@umich.edu=
> wrote:
> >
> > On Fri, Aug 23, 2024 at 10:44=E2=80=AFAM Chuck Lever <chuck.lever@oracl=
e.com> wrote:
> >>
> >> On Fri, Aug 23, 2024 at 10:14:01AM -0400, Olga Kornievskaia wrote:
> >>> states_show() relied on sc_type field to be of valid type
> >>> before calling into a subfunction to show content of a
> >>> particular stateid. But from commit 3f29cc82a84c we
> >>> split the validity of the stateid into sc_status and no longer
> >>> changed sc_type to 0 while unhashing the stateid. This
> >>> resulted in kernel oopsing as something like
> >>> nfs4_show_open() would derefence sc_file which was NULL.
> >>>
> >>> To reproduce: mount the server with 4.0, read and close
> >>> a file and then on the server cat /proc/fs/nfsd/clients/2/states
> >>>
> >>> [  513.590804] Call trace:
> >>> [  513.590925]  _raw_spin_lock+0xcc/0x160
> >>> [  513.591119]  nfs4_show_open+0x78/0x2c0 [nfsd]
> >>> [  513.591412]  states_show+0x44c/0x488 [nfsd]
> >>> [  513.591681]  seq_read_iter+0x5d8/0x760
> >>> [  513.591896]  seq_read+0x188/0x208
> >>> [  513.592075]  vfs_read+0x148/0x470
> >>> [  513.592241]  ksys_read+0xcc/0x178
> >>>
> >>> Fixes: 3f29cc82a84c ("nfsd: split sc_status out of sc_type")
> >>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> >>> ---
> >>> fs/nfsd/nfs4state.c | 3 +++
> >>> 1 file changed, 3 insertions(+)
> >>>
> >>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> >>> index c3def49074a4..8351724b8a43 100644
> >>> --- a/fs/nfsd/nfs4state.c
> >>> +++ b/fs/nfsd/nfs4state.c
> >>> @@ -2907,6 +2907,9 @@ static int states_show(struct seq_file *s, void=
 *v)
> >>> {
> >>>      struct nfs4_stid *st =3D v;
> >>>
> >>> +     if (!st->sc_file)
> >>> +             return 0;
> >>> +
> >>>      switch (st->sc_type) {
> >>>      case SC_TYPE_OPEN:
> >>>              return nfs4_show_open(s, st);
> >>> --
> >>> 2.43.5
> >>>
> >>
> >> I'll wait for Neil/Jeff's Reviewed-by, but the root cause analysis
> >> seems plausible to me, and I'll plan to apply it for v6.11-rc.
> >>
> >> Btw, I noticed this at the tail of states_show():
> >>
> >>        /* XXX: copy stateids? */
> >>
> >> I'm not really sure, but those won't ever have an sc_file, will
> >> they? Are COPY callback stateids something we want the server to
> >> display in this code? Just musing aloud: maybe the NULL sc_file
> >> check wants to be moved into the show helpers.
> >
> > I can see that the copy stateids still have type NFS4_COPY_STID so
> > they are not converted to the new type of SC_TYPE. But it just means
> > we are not displaying them. I'm not sure what happens to sc_file for
> > copy stateid, I'd need to check.
>
> If you're already going to move the sc_file check into
> nfs4_show_open(), you can defer looking at adding specific
> support for callback stateids. We'll add it to the to-do
> list.

Now that I've looked at some copy code and also got more familiar with
this walking the stateids in proc, I'd like to note that proc only
walks the stateids that are store in clp->cl_stateids but the copy
stateid that we keep around (and those are the copy stateids in the
source server) are stored under the nfsd_net (namespace). Not to say
we shouldn't modify states_show() not to add walking a different list
but wanted to raise it. Also on the destination server, we stop async
copy stateid under the clp->async_copies list and they only live for
the lifetime of the copy. I know this bordes on a different discussion
of keeping copy stateids...

>
>
> --
> Chuck Lever
>
>


