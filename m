Return-Path: <linux-nfs+bounces-1601-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B32CC84274B
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jan 2024 15:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E24F1F258C5
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jan 2024 14:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489D77C0AF;
	Tue, 30 Jan 2024 14:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OAuYV7u3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4456D1AD
	for <linux-nfs@vger.kernel.org>; Tue, 30 Jan 2024 14:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706626609; cv=none; b=qC49SBmGzqMp9jHLX2w/FuJUDjHEf7HCkMx2SlyF++B3+PFMM3JmlMwVSxn0UB0xe3ZNqZ8PTx8sLyxaSry13xS2I19NveeGYKh90tyV2fT2SJzi8COLxdqI/wUCajQS33ee8YNoMFvXIe46xTymwWvL1jWVEH4O6jqG8XET5Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706626609; c=relaxed/simple;
	bh=sWRFsFr21dqXpWxMdfjmZI6Q3tSgx9eu+w5fNamK84E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YGslIK15vDg3t+BLlXA6yCbvLGguIklPdcE9g2JFpzfYF1bMuHD07N85g5NGC0l+DfgjYERB0htziJSzggX8Di3SHG/E93ZDRTrvf4rW6rEyDCTo9GKn5orkAFAtV/u9pARN1xkI9VeL0RcplkRhTNOThuQzIJpkWyC0S2U/Ru8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OAuYV7u3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706626606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wn4PZs8Fk0K6IydkmaSZCojqBYBcqOWooJgGoP6pp/M=;
	b=OAuYV7u3ex0Uo67cUX/SCehyZCEFqgMov8NEDl2ipnX9kzq3TiNiZ+juk+rjeud+OtBUIs
	5br1bcvcDth8ESMjUidRzd/Yuk2gZHV2Ik8k82izaoWvmtrZM9hMXP+4vKDUL+JJ8RzqOy
	bRYBVg+7HF15fFefAkkLWduJV84qQvw=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-cRrj_QLZNWSCXjS8M5BNxQ-1; Tue, 30 Jan 2024 09:56:44 -0500
X-MC-Unique: cRrj_QLZNWSCXjS8M5BNxQ-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5cf35636346so2173122a12.3
        for <linux-nfs@vger.kernel.org>; Tue, 30 Jan 2024 06:56:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706626603; x=1707231403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wn4PZs8Fk0K6IydkmaSZCojqBYBcqOWooJgGoP6pp/M=;
        b=UXcEXICqZNZWjh6t5G0ArxZdMqdPeOCTy5asgcTSQ2NyfS9C1VJZyYW9vuC5NoxLUt
         QhbHKhHCm679YcvjpFlIMMoCXwaVD2pKM4GGVxFg7EJNYoGcMBcWqpl17il1q3ioyF48
         350Szw1ySRAsR8Bx5S2zk/GyCu5zQ+vQpfTkhL1JhR7Waj5EzGVBAQMnJHeAOK00Gt67
         NxDYh4xZ5/8+Zpprh1FfQ5AvVNgfCH3YDO0Rlwp+TkTKw4ATVGEKzMO7FDclRFxrZDlv
         Kkgfhp0xZVh2q9gvUtNTvKgHzCWZbU+wX3mzyWkLqE8fen5rsF9G5Mrc/ayiwf+7BSgF
         ULaw==
X-Gm-Message-State: AOJu0YwtV+CHS7QkuW+zsUZ+EC9aKx/sT9Zr4Qm03wxpg1TnSl5J+1H1
	4S2kR/bvskt3x5XIdPEEi6gmlIEBygQ+8wWmMvlR8KwV+UW9ElcRGTMhGSD/1vgawbcyU1oqmkU
	HrklSzS1wNAZMTsJQp2wmCiX2eBafUegRRI693SKzoB8r0u28nn2qAB+qS6OMtwDjvT3yDzXaSn
	iKeuEyRAJz8qrxKHCH4ZpeAAzKFPvSoQMWQ13JSwZx
X-Received: by 2002:a05:6a20:bc89:b0:199:cecf:9f5d with SMTP id fx9-20020a056a20bc8900b00199cecf9f5dmr4286287pzb.29.1706626603252;
        Tue, 30 Jan 2024 06:56:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoBVyPbY16l9mBx+uAWWT/iMrABgZxomWytzou8qA79h0FDKsZQtzMYfof31QeCnFGBljhzzzePXs95Udopxc=
X-Received: by 2002:a05:6a20:bc89:b0:199:cecf:9f5d with SMTP id
 fx9-20020a056a20bc8900b00199cecf9f5dmr4286275pzb.29.1706626602978; Tue, 30
 Jan 2024 06:56:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129154750.1245317-1-dwysocha@redhat.com> <1526807.1706548521@warthog.procyon.org.uk>
 <CALF+zOm9QBkf3PbchuVzkgYW1aEJWFFQ5JF0Y-_6BbPJke8CHw@mail.gmail.com> <dd504acbdfb0b926e54318fd6ea8f9d43af73634.camel@kernel.org>
In-Reply-To: <dd504acbdfb0b926e54318fd6ea8f9d43af73634.camel@kernel.org>
From: David Wysochanski <dwysocha@redhat.com>
Date: Tue, 30 Jan 2024 09:56:06 -0500
Message-ID: <CALF+zOnR1Hu-M=N7+ALcNicbVvEO=G5XN0roigxps15Wj0O8uA@mail.gmail.com>
Subject: Re: [PATCH] NFS: Fix nfs_netfs_issue_read() xarray locking for
 writeback interrupt
To: Jeff Layton <jlayton@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Anna Schumaker <anna.schumaker@netapp.com>, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, linux-nfs@vger.kernel.org, 
	linux-cachefs@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 12:44=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
>
> On Mon, 2024-01-29 at 12:34 -0500, David Wysochanski wrote:
> > On Mon, Jan 29, 2024 at 12:15=E2=80=AFPM David Howells <dhowells@redhat=
.com> wrote:
> > >
> > > Dave Wysochanski <dwysocha@redhat.com> wrote:
> > >
> > > > -     xas_lock(&xas);
> > > > +     xas_lock_irqsave(&xas, flags);
> > > >       xas_for_each(&xas, page, last) {
> > >
> > > You probably want to use RCU, not xas_lock().  The pages are locked a=
nd so
> > > cannot be evicted from the xarray.
> > >
> >
> > I tried RCU originally and ran into a problem because NFS can schedule
> > (see comment on line 328 below)
> >
> > 326         xas_lock_irqsave(&xas, flags);
> > 327         xas_for_each(&xas, page, last) {
> > 328                 /* nfs_read_add_folio() may schedule() due to pNFS
> > layout and other RPCs  */
> > 329                 xas_pause(&xas);
> > 330                 xas_unlock_irqrestore(&xas, flags);
> > 331                 err =3D nfs_read_add_folio(&pgio, ctx, page_folio(p=
age));
> > 332                 if (err < 0) {
> > 333                         netfs->error =3D err;
> > 334                         goto out;
> > 335                 }
> > 336                 xas_lock_irqsave(&xas, flags);
> > 337         }
> > 338         xas_unlock_irqrestore(&xas, flags);
> >
>
> Looking at it more closely, I think you might want to just use
> xa_for_each_start(). That will do the traversal using the rcu_read_lock
> under the hood, and you should be able to block on every iteration.
>
Thanks Jeff.  Yes, I agree after looking at this further, this is a
good approach, and much cleaner.  I'll work on a v2 patch (actually
with xa_for_each_range as you suggested off list) and send after
a bit of testing -- so far, so good.

FWIW, my original usage of RCU was outside the whole loop.
I ran into problems due to nfs_read_add_folio().


