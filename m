Return-Path: <linux-nfs+bounces-1575-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1D38410D4
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 18:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC1D5283051
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 17:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B7A76C8B;
	Mon, 29 Jan 2024 17:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VIK7gdKY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3520376C66
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jan 2024 17:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706549730; cv=none; b=rNgwaPiereBNCdzaZOkFoBkRw3zUYNFsQbzkiPseOBcOS3bOlj149O3r7oXc4ry0VlsdRY9GqZAJMlC0Hxp0LEZyBbAq7mYvqpDGLBFcDrkDQWqhNh8lHWk/zNKFYTFeX1vxCty5k+Uq+gpstpaOvl+6PucmZwbxGixQ3sdYvMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706549730; c=relaxed/simple;
	bh=79lusJzdAroin33c8uwEytAxmyWJtHnYRH6IYXc9zZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n92yc/CQXSlhR7bMEkUv2My5XHJC3nlD2tVRSNDPU2nToeY0/9OSQiETDcTzqbUUmwVkMRltDrudgln834aE5gNuwmo5zTGX4CdtJZYHntcwN1BuMskfwFIxuiFEJaQsg+Kmn9clIeR5uZJHHlEhiM4Wyw6E10J6zVmSxQm/8EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VIK7gdKY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706549727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pNnV6qllixKii1cmzBKiZvBaPVF6lZz0W+h3Gyf7y6E=;
	b=VIK7gdKYQPVG6OjFNmFWwYWrE9J99HI9cwvG/fIxQG4aBxq8WUzcN7TcowFDjE5o0Hdgpa
	tY9sh7fJcozNBWLTUS8f6Y/0EMLky13v57MGP/IJXC8hGXxTpzLqy30jZe2U+H4ZIRRIy7
	NkZvE5yHbnM9FDh1yeMjvRond/a4ZS4=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-RPu3us2cOMmPbuIOLHBM-w-1; Mon, 29 Jan 2024 12:35:25 -0500
X-MC-Unique: RPu3us2cOMmPbuIOLHBM-w-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5963251664cso2956541eaf.0
        for <linux-nfs@vger.kernel.org>; Mon, 29 Jan 2024 09:35:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706549724; x=1707154524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNnV6qllixKii1cmzBKiZvBaPVF6lZz0W+h3Gyf7y6E=;
        b=YZVdO3/As6UAwC8lhY3z5tbVxwCnf/b8jfstbBkjL1Sw5h1xR9ZEr0czLdZWcYdC0L
         G+RIY2y3VAWdevj6+Qc9vgcrs6f4ppVIGzO7zzofsuYHZkwkQCF359EsAq1wgMKbYwwb
         mMMgkRlIF1CkfZ+aB2P8YMkeucE5dCNGrI4+IISsmmmQaZbVgrhIGfIxPYmeTqU9dBut
         FCArB7jMV2GMi0PJXCvTbaowoRrG+9vO4MZwqTPNOiNdY875pFmEriT1nzTVflSXgjsk
         PO7a9wLtbTU9sdF+CypPWUq6bQXBespZ3/Nrc4ft9Ffw5I3dxiYM4cvhcJu7D1s72wd1
         H3kQ==
X-Gm-Message-State: AOJu0YwM3ODvi+YokTiW6haA/+xdIipaUaADOF/IEenKBJ44CEtYxrSs
	XoOllPfQowTkFMQieeAfCca3quoT10EF5moaGiTD/8lrFoOifLv3/qyIT9tonHxSvD4i6mOi9kM
	0FEg+2ffi9tJq5g116h/OWCZqpJpgQY9hkjt5AnpJ+3BbGuol3PKVC3cj0u1IedAGCRtFO1fn0O
	j3AHKddXhfrbad5Fl7sF/xRY7VaSUjLVGe
X-Received: by 2002:a05:6358:9149:b0:175:c7bb:5bbb with SMTP id r9-20020a056358914900b00175c7bb5bbbmr3688563rwr.42.1706549724396;
        Mon, 29 Jan 2024 09:35:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEguZsiLn4KmejmaPYrvkOBH1tMyvMVUnXA+fQ7RKv54AFRUywOZPMJwuVoKWaGzCxpgo2j6qJnL2KyMXjdSEU=
X-Received: by 2002:a05:6358:9149:b0:175:c7bb:5bbb with SMTP id
 r9-20020a056358914900b00175c7bb5bbbmr3688556rwr.42.1706549724169; Mon, 29 Jan
 2024 09:35:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129154750.1245317-1-dwysocha@redhat.com> <1526807.1706548521@warthog.procyon.org.uk>
In-Reply-To: <1526807.1706548521@warthog.procyon.org.uk>
From: David Wysochanski <dwysocha@redhat.com>
Date: Mon, 29 Jan 2024 12:34:47 -0500
Message-ID: <CALF+zOm9QBkf3PbchuVzkgYW1aEJWFFQ5JF0Y-_6BbPJke8CHw@mail.gmail.com>
Subject: Re: [PATCH] NFS: Fix nfs_netfs_issue_read() xarray locking for
 writeback interrupt
To: David Howells <dhowells@redhat.com>
Cc: Anna Schumaker <anna.schumaker@netapp.com>, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, Jeff Layton <jlayton@kernel.org>, 
	linux-nfs@vger.kernel.org, linux-cachefs@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 12:15=E2=80=AFPM David Howells <dhowells@redhat.com=
> wrote:
>
> Dave Wysochanski <dwysocha@redhat.com> wrote:
>
> > -     xas_lock(&xas);
> > +     xas_lock_irqsave(&xas, flags);
> >       xas_for_each(&xas, page, last) {
>
> You probably want to use RCU, not xas_lock().  The pages are locked and s=
o
> cannot be evicted from the xarray.
>

I tried RCU originally and ran into a problem because NFS can schedule
(see comment on line 328 below)

326         xas_lock_irqsave(&xas, flags);
327         xas_for_each(&xas, page, last) {
328                 /* nfs_read_add_folio() may schedule() due to pNFS
layout and other RPCs  */
329                 xas_pause(&xas);
330                 xas_unlock_irqrestore(&xas, flags);
331                 err =3D nfs_read_add_folio(&pgio, ctx, page_folio(page)=
);
332                 if (err < 0) {
333                         netfs->error =3D err;
334                         goto out;
335                 }
336                 xas_lock_irqsave(&xas, flags);
337         }
338         xas_unlock_irqrestore(&xas, flags);


