Return-Path: <linux-nfs+bounces-12921-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D98D0AFBC83
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Jul 2025 22:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41286421E11
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Jul 2025 20:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF9A21C9E9;
	Mon,  7 Jul 2025 20:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IApY3rLd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E141D213E85
	for <linux-nfs@vger.kernel.org>; Mon,  7 Jul 2025 20:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751920090; cv=none; b=mLBmFjbvqzirrCwxzQgGPbPiByYPF2NeWKVvFOu5BpehA2aPfSNqwvx0AQFi8xSLFNk3xepOJ1rSvilh6JcNYuzUlAB/QedBZ41VDg1K7QUTkJqil7Yi/GenhqrCOX0/xSXKuYBrfms5DSLI47jnQUabUoc9sK8etOzSgif/WO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751920090; c=relaxed/simple;
	bh=wJm5XL2AN/wtuQtnqoX2xDDrfg6p7+O/hteMlYFyOVA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jLrhkbfYSUnwfg3PIObeOFuZBTGPm3MoPhy9SsJW1c1D0rdN8jmArFsQtWyga4sjkNG+YVyTZ9TBunQJ8pLQj5yAabnOGgNUlYR2JnJLdn5AHSIH74n8DnxJgSyYjy8kf5YCe1N5KKIx/WkbnVco+3OOneqCYv6WDXq4TEuztGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IApY3rLd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751920087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LaAJBS5fCT5n2JFH0DqlZCq3hm+0Tj15kQ07VPmExLQ=;
	b=IApY3rLdqVE3Sgi+X9JqDs8be/HkKT5FE5E2TUspIq/x2JTTwA1AT1By5BokQoDpYenjtw
	yl1q1+3HsP/Ft6xLi9uJoo7HfDeUHcF00tB7FKU40e5vg60ihIy7pGCMqpKpq767Fer/EF
	UyIIWvY6n4if5FxT2Rn+ZU6XbDQOyhU=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-z_K5XvatO6ys7FCeP4I8Ag-1; Mon, 07 Jul 2025 16:28:06 -0400
X-MC-Unique: z_K5XvatO6ys7FCeP4I8Ag-1
X-Mimecast-MFC-AGG-ID: z_K5XvatO6ys7FCeP4I8Ag_1751920086
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-710ed75c7efso52996487b3.1
        for <linux-nfs@vger.kernel.org>; Mon, 07 Jul 2025 13:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751920086; x=1752524886;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LaAJBS5fCT5n2JFH0DqlZCq3hm+0Tj15kQ07VPmExLQ=;
        b=LGkHQVvnCxAp4ybmgN+jOXdeiKElgC/z7pmlLTQw4+727K/nGgmcfMyzNDvmCCPUFB
         WDkCFzJwFhlZuNXRvDpgWsDKv7YVfOMK1NAGAQmUa9Dpnsf39qAA+69ETS2+FsSxKs6X
         WTgsQ1e8K2DxQZaAyz6QxETRMigx/YVNBGgox3V90Nkaf2kuuDfbkKIDGiZ0oC7l51OF
         Rt0AZaKb+E60vAMU5jZf+qsunllkoLOj/lMTJTTDcdwYGBMJKxoJuC/aHAbZ42eINFsT
         cfugNqRW4AVVjeeQEqg61ph4OrHEAixGCuKX90jqew9FTOkG1WKtbIMW+t19sFtApmf8
         hyiQ==
X-Gm-Message-State: AOJu0YxJbhz4SAaH9Nku2cdl+elgVCnnm956dMUHUpRoNn5s66j+DN7v
	AXE2OwF3LUXQ6PMqbc7wg+1e6wINXRvOt0D7rGQoTvhrC6sER+qSus8N+BF+P6ME2O7xJKesWfK
	4scq9WukQvmJKLGghrJOp+WOQkVHYPH9DVO3GK+uqesrsTtwngANyQZPfRy/NhA==
X-Gm-Gg: ASbGncsnkrGRnRHVuykH7U1AflmbG+eS5zKjIJhYCPNnqo8FPo4r0t7gHeQHhPh1yd4
	qTrxkQ62F5QZLQlTuqy4djqwLLn3sguo/QuwyV2v0HNH8AxdNyGseIYV1jTvyGgtu5iGHrx7V2r
	S1x7ILb2ezSQ8oMfY3ZyZzhxnjmwlerURxDqdLVkPhO3YwfI2IDEJrPsLNm5wvyL54dZzxA2qWs
	Cp63T1yR241ZWf20AtIJTLPnizehmhQEcgsfwyJDRh9kUAwuRUWzrTyCRQzU6ydNc8nLcCxLf/E
	f2D1pyxew+f7YR8PfDdPEJJVorJL1vGX0qxUaklGPLuEThP4aRaeXNImpD0cQw95fpN+hAN3
X-Received: by 2002:a05:690c:b11:b0:710:f1a9:1ba0 with SMTP id 00721157ae682-717a0265489mr2181837b3.3.1751920085918;
        Mon, 07 Jul 2025 13:28:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLpnBuyF0C0XXuT2Yb8x9jJDj3FWPZSJtfybwB9i+zuijNdj4VLYsumfdINkEE2Z8lg/ugbA==
X-Received: by 2002:a05:690c:b11:b0:710:f1a9:1ba0 with SMTP id 00721157ae682-717a0265489mr2181437b3.3.1751920085513;
        Mon, 07 Jul 2025 13:28:05 -0700 (PDT)
Received: from ?IPv6:2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a? ([2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71665adffb8sm17818367b3.59.2025.07.07.13.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 13:28:04 -0700 (PDT)
Message-ID: <59530cbe001f5d02fa007ce642a860a7bade4422.camel@redhat.com>
Subject: Re: [PATCH 2/2] NFS: Improve nfsiod workqueue detection for
 allocation flags
From: Laurence Oberman <loberman@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>, Benjamin Coddington	
 <bcodding@redhat.com>, Anna Schumaker <anna@kernel.org>, Tejun Heo
 <tj@kernel.org>,  Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	djeffery@redhat.com
Date: Mon, 07 Jul 2025 16:28:03 -0400
In-Reply-To: <a7621e726227260396291e82363d2b82e5f2ad73.camel@kernel.org>
References: <cover.1751913604.git.bcodding@redhat.com>
		 <a4548815532fb7ad71a4e7c45b3783651c86c51f.1751913604.git.bcodding@redhat.com>
	 <a7621e726227260396291e82363d2b82e5f2ad73.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-07-07 at 12:25 -0700, Trond Myklebust wrote:
> On Mon, 2025-07-07 at 14:46 -0400, Benjamin Coddington wrote:
> > The NFS client writeback paths change which flags are passed to
> > their
> > memory allocation calls based on whether the current task is
> > running
> > from
> > within a workqueue or not.=C2=A0 More specifically, it appears that
> > during
> > writeback allocations with PF_WQ_WORKER set on current->flags will
> > add
> > __GFP_NORETRY | __GFP_NOWARN.=C2=A0 Presumably this is because nfsiod
> > can
> > simply fail quickly and later retry to write back that specific
> > page
> > should
> > the allocation fail.
> >=20
> > However, the check for PF_WQ_WORKER is too general because tasks
> > can
> > enter NFS
> > writeback paths from other workqueues.=C2=A0 Specifically, the loopback
> > driver
> > tends to perform writeback into backing files on NFS with
> > PF_WQ_WORKER set,
> > and additionally sets PF_MEMALLOC_NOIO.=C2=A0 The combination of
> > PF_MEMALLOC_NOIO with __GFP_NORETRY can easily result in allocation
> > failures and the loopback driver has no retry functionality.=C2=A0 As a
> > result,
> > after commit 0bae835b63c5 ("NFS: Avoid writeback threads getting
> > stuck in
> > mempool_alloc()") users are seeing corrupted loop-mounted
> > filesystems
> > backed
> > by image files on NFS.
> >=20
> > In a preceding patch, we introduced a function to allow NFS to
> > detect
> > if
> > the task is executing within a specific workqueue.=C2=A0 Here we use
> > that
> > helper
> > to set __GFP_NORETRY | __GFP_NOWARN only if the workqueue is
> > nfsiod.
> >=20
> > Fixes: 0bae835b63c5 ("NFS: Avoid writeback threads getting stuck in
> > mempool_alloc()")
> > Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> > ---
> > =C2=A0fs/nfs/internal.h | 12 +++++++++++-
> > =C2=A01 file changed, 11 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> > index 69c2c10ee658..173172afa3f5 100644
> > --- a/fs/nfs/internal.h
> > +++ b/fs/nfs/internal.h
> > @@ -12,6 +12,7 @@
> > =C2=A0#include <linux/nfs_page.h>
> > =C2=A0#include <linux/nfslocalio.h>
> > =C2=A0#include <linux/wait_bit.h>
> > +#include <linux/workqueue.h>
> > =C2=A0
> > =C2=A0#define NFS_SB_MASK (SB_NOSUID|SB_NODEV|SB_NOEXEC|SB_SYNCHRONOUS)
> > =C2=A0
> > @@ -669,9 +670,18 @@ nfs_write_match_verf(const struct
> > nfs_writeverf
> > *verf,
> > =C2=A0		!nfs_write_verifier_cmp(&req->wb_verf, &verf-
> > > verifier);
> > =C2=A0}
> > =C2=A0
> > +static inline bool is_nfsiod(void)
> > +{
> > +	struct workqueue_struct *current_wq =3D current_workqueue();
> > +
> > +	if (current_wq)
> > +		return current_wq =3D=3D nfsiod_workqueue;
> > +	return false;
> > +}
> > +
> > =C2=A0static inline gfp_t nfs_io_gfp_mask(void)
> > =C2=A0{
> > -	if (current->flags & PF_WQ_WORKER)
> > +	if (is_nfsiod())
> > =C2=A0		return GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
> > =C2=A0	return GFP_KERNEL;
> > =C2=A0}
>=20
>=20
> Instead of trying to identify the nfsiod_workqueue, why not apply
> current_gfp_context() in order to weed out callers that set
> PF_MEMALLOC_NOIO and PF_MEMALLOC_NOFS?
>=20
> i.e.
>=20
>=20
> static inline gfp_t nfs_io_gfp_mask(void)
> {
> 	gfp_t ret =3D current_gfp_context(GFP_KERNEL);
>=20
> 	if ((current->flags & PF_WQ_WORKER) && ret =3D=3D GFP_KERNEL)
> 		ret |=3D __GFP_NORETRY | __GFP_NOWARN;
> 	return ret;
> }
>=20
>=20

I am testing both patch options to see if both prevent the failed write
with no other impact and will report back.

The test is confined to the use case of an XFS file system served by an
image that is located on NFS. as that is where the failed writes were
seen.




