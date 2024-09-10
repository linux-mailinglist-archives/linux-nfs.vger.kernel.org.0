Return-Path: <linux-nfs+bounces-6375-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1F2973F38
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Sep 2024 19:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E296A28AD65
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Sep 2024 17:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0842B1A4F0E;
	Tue, 10 Sep 2024 17:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gvmh8B+n"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3047D168C20
	for <linux-nfs@vger.kernel.org>; Tue, 10 Sep 2024 17:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725988666; cv=none; b=EBSd+pLuMTrPg3h3twhPP92P7dNkColnnbUi+eWt74SDyPybKLh7WIEqRkiKH5qxuufUAa8q+w5eC1QUoaVFnBfHU4V6DEi5e9tO0rZYZ1Gjp00rzDYUErNX1dHR7GlcMxiqUghb1cVl9b0ZCUPyOMifbJCK4x2xF537+lzkbmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725988666; c=relaxed/simple;
	bh=ZvF+sWnTM7XXftXtVRmmxW+qAces/LZQ2IoKux9c8Ow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d6kKdsPqAVnJkYZMy6Rgl9m6nyj5mPNwpMoO7+vj6Xqvp+SySpZXptYQVLnPpct8bfqwdix8JaPUyjlgkBBPCvqrflS4IHaOZRfG4sVDyagfmr34zc707inYvmDqsF4IQDqBrfV7h8T/Zv/TGxa8LFafd3o71niu8GJdpxGOZSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gvmh8B+n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725988663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eGgCxf/Q+y1w/s/LMKPer1hZ4WwFdSeTvpbBQokgPm0=;
	b=gvmh8B+nCwWoO9MT0Iw+Xx8dDNzTwiMBozVvLN6YTSNL48Lxv8U3OrkQPNn4EPMfzuPp/t
	pxx+orvPsEsW5STYf0wB7+crcSRHXIjCDtPSOwvaJ67fl/Ea6q2I6O0h/eEpbr+IYJD8Ie
	N3JD741zyNFvEcc0TkO1BzM+2S8scG4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-FTa5AdHwP3y9p4ijMU3H1Q-1; Tue, 10 Sep 2024 13:17:42 -0400
X-MC-Unique: FTa5AdHwP3y9p4ijMU3H1Q-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2f5086e692cso9054491fa.2
        for <linux-nfs@vger.kernel.org>; Tue, 10 Sep 2024 10:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725988660; x=1726593460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGgCxf/Q+y1w/s/LMKPer1hZ4WwFdSeTvpbBQokgPm0=;
        b=ld4y0zqLTixJa4y/0J+U9wVIbuDJ/X5nL8x+HPOsDTrGawzSwjgf1o6DOu8VZ4au1p
         SQVl3Rp6l0RicCqdNOhW1hvNzoZp+cO+tnijDM6kJJ8iSVEFkkbvPYljqECazlcftm3b
         Wk/6U2ZgCdnSu3lFjh/M7C9/XtMvkVx/9exw8WRrqifi+wk8UyPubB3AYQmG5gWmg7bB
         1ioMzlulcDFg4HdhfyTyKhQQ3JsyJZ5j3Idk7hbZj/MGmwgEPEmteb2C4laCidyN+k4j
         PCdzftW8TrM5eRiONh8n9V5/pJQQEzBpb2wwFebEuZw+esZhrh3TP51yMTHxu02YUMl+
         f+3w==
X-Forwarded-Encrypted: i=1; AJvYcCXXSOJ53Ng0nM5YQWj8MT98oqNj7StsGFHpPdTTyyJIHdhm8s4Jvt9yAEDU9SxqQ51DS1SgD3p9gMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgSJCSQhZFN/YZIMcOLgafyP0obxLqKtsCe5X361xEuzZrvzDd
	0Cn/veKcQNwjzWBIq7DO0ykJXGByzRaq9Vvo7r+6G4g/fUo/jmR6EH0c9LVMdcz5gKz+XxwK3I5
	OaljvspKMRICwqpqjfZJUAuTBcu2DlURQ9Ca7U9BxZ+KLpUcfsrxWod1+o9cA1SgKXk9mpqZ5JD
	DmHc6pUjnaF05pHCw42D9dGqQy5cZ3P2ei
X-Received: by 2002:a05:651c:2119:b0:2f6:6101:5a6c with SMTP id 38308e7fff4ca-2f77b73af20mr3666621fa.5.1725988660365;
        Tue, 10 Sep 2024 10:17:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJ5wwf1P4KtRYBRtrnbvCydRsYWK4aAdghD56+2z2qYGQDU3a/G1B7LH8ZDXivu9UowC5fW+LytKjCo/XCUNo=
X-Received: by 2002:a05:651c:2119:b0:2f6:6101:5a6c with SMTP id
 38308e7fff4ca-2f77b73af20mr3666341fa.5.1725988659801; Tue, 10 Sep 2024
 10:17:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230823213352.1971009-1-aahringo@redhat.com> <20230823213352.1971009-2-aahringo@redhat.com>
 <B38733D3-6F54-42DF-BD5B-716F0200314F@redhat.com> <1490adc3ae3f82968c6112bb6f9df3c3f2229b04.camel@kernel.org>
 <C158604C-DD07-49C9-8C7B-A9807CD71473@redhat.com>
In-Reply-To: <C158604C-DD07-49C9-8C7B-A9807CD71473@redhat.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 10 Sep 2024 13:17:28 -0400
Message-ID: <CAK-6q+jtEk-6JCV9qYcsyjne+hTYS7g1w73dHhBRGG1pMAJWGw@mail.gmail.com>
Subject: Re: [PATCH 1/7] lockd: introduce safe async lock op
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	teigland@redhat.com, rpeterso@redhat.com, agruenba@redhat.com, 
	trond.myklebust@hammerspace.com, anna@kernel.org, chuck.lever@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 10, 2024 at 12:56=E2=80=AFPM Benjamin Coddington
<bcodding@redhat.com> wrote:
>
> On 10 Sep 2024, at 11:45, Jeff Layton wrote:
>
> > On Tue, 2024-09-10 at 10:18 -0400, Benjamin Coddington wrote:
> >> On 23 Aug 2023, at 17:33, Alexander Aring wrote:
> >>
> >>> This patch reverts mostly commit 40595cdc93ed ("nfs: block notificati=
on
> >>> on fs with its own ->lock") and introduces an EXPORT_OP_SAFE_ASYNC_LO=
CK
> >>> export flag to signal that the "own ->lock" implementation supports
> >>> async lock requests. The only main user is DLM that is used by GFS2 a=
nd
> >>> OCFS2 filesystem. Those implement their own lock() implementation and
> >>> return FILE_LOCK_DEFERRED as return value. Since commit 40595cdc93ed
> >>> ("nfs: block notification on fs with its own ->lock") the DLM
> >>> implementation were never updated. This patch should prepare for DLM
> >>> to set the EXPORT_OP_SAFE_ASYNC_LOCK export flag and update the DLM
> >>> plock implementation regarding to it.
> >>>
> >>> Acked-by: Jeff Layton <jlayton@kernel.org>
> >>> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> >>> ---
> >>>  fs/lockd/svclock.c       |  5 ++---
> >>>  fs/nfsd/nfs4state.c      | 13 ++++++++++---
> >>>  include/linux/exportfs.h |  8 ++++++++
> >>>  3 files changed, 20 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> >>> index c43ccdf28ed9..6e3b230e8317 100644
> >>> --- a/fs/lockd/svclock.c
> >>> +++ b/fs/lockd/svclock.c
> >>> @@ -470,9 +470,7 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_fi=
le *file,
> >>>         struct nlm_host *host, struct nlm_lock *lock, int wait,
> >>>         struct nlm_cookie *cookie, int reclaim)
> >>>  {
> >>> -#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
> >>>     struct inode            *inode =3D nlmsvc_file_inode(file);
> >>> -#endif
> >>>     struct nlm_block        *block =3D NULL;
> >>>     int                     error;
> >>>     int                     mode;
> >>> @@ -486,7 +484,8 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_fi=
le *file,
> >>>                             (long long)lock->fl.fl_end,
> >>>                             wait);
> >>>
> >>> -   if (nlmsvc_file_file(file)->f_op->lock) {
> >>> +   if (!export_op_support_safe_async_lock(inode->i_sb->s_export_op,
> >>> +                                          nlmsvc_file_file(file)->f_=
op)) {
> >>
> >> ... but don't most filesystem use VFS' posix_lock_file(), which does t=
he
> >> right thing?  I think this patch has broken async lock callbacks for N=
LM for
> >> all the other filesystems that just use posix_lock_file().
> >>
> >> Maybe I'm missing something, but why was that necessary?
> >>
> >
> > Good catch. Yeah, I think that probably should have been an &&
> > condition. IOW:
> >
> >       if (nlmsvc_file_file(file)->f_op->lock &&
> >             !export_op_support_safe_async_lock(inode->i_sb->s_export_op=
,
> >
>
> Ah Jeff, thanks for confirming - there's been a bunch of changes in there=
 that
> made me uncertain.  I can send a patch for this, I'd like to rename
> export_op_support_safe_async_lock to something like fs_can_defer_lock
> (suggestions) and put the test in there.

go ahead with the name change.

About the uncertainty the other changes, except this one mentioned
above here in the reply, was a revert of commit 40595cdc93ed ("block
notification on fs with its own ->lock") that had removed a similar
flag to in kind of a reverse logic.
The flag means something that the commit message says "... filesystems
with "good" ->lock methods to support blocking lock notifications.".

- Alex


