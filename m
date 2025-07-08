Return-Path: <linux-nfs+bounces-12944-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FA0AFD324
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 18:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23E46189540B
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 16:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454202E1C65;
	Tue,  8 Jul 2025 16:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JCLwMv6j"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818DB2DD5EF
	for <linux-nfs@vger.kernel.org>; Tue,  8 Jul 2025 16:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993446; cv=none; b=fw9YP2zL/RCq07f9Rc43G2RSNJ2RHPbQnX4V2TrbYwVB0UHTy+lIiVgGwhKQIxTm96OVSwx6cGYeAl7t5fHiBuQam+2IzKGQcL6vuuIk1tX4EWjLLEjEXpRgDZ/WijXRO33wlTtclydSqjSRKWvdJk4cp9oCLRDCK4WFWDKh62A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993446; c=relaxed/simple;
	bh=mlDU5H+9ZkqKr1yHd+SQ470F9rBXCauwZtaraXjjf3Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A8VIFfz3+YKo4hyK3E3V2iK7slnESWAChJvyZfKxKTr2HxOPRlmP2UmlU96tujIFQR+U1jmEBrPyM0/WDzALVzfT55fIC2vTblA56w6X/oBZcX6ZM0fKwgf71H4T7unTCspBZnFfBSxJEXGiLILUjyu/+jBaBmU3rnWWGg3lVjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JCLwMv6j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751993443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wKJUQGnfzbi86oNf7WYsc5g9x36UeyCY1Ica/sNjSAU=;
	b=JCLwMv6jr9AaBtF323nE4eIQxE5hcJz7NSVnGJ/fTp1Wg/ePHjUjKsaUKnJLXoPHDWG10h
	dHwdD9c25qcuHNqGz6RrMCSPF5dpj/Bs3mR6kShVvcdFvNcdmG6GRdkVznx8+Me1IMrgl3
	/+XIFyZH/JJbwig6aAPfHCUyxh3XnDI=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-Vpfx-YlJMfy7pH_Fpv5Ryw-1; Tue, 08 Jul 2025 12:50:41 -0400
X-MC-Unique: Vpfx-YlJMfy7pH_Fpv5Ryw-1
X-Mimecast-MFC-AGG-ID: Vpfx-YlJMfy7pH_Fpv5Ryw_1751993441
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-710ed75c7efso68249707b3.1
        for <linux-nfs@vger.kernel.org>; Tue, 08 Jul 2025 09:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751993441; x=1752598241;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wKJUQGnfzbi86oNf7WYsc5g9x36UeyCY1Ica/sNjSAU=;
        b=OyacVopxmAe2RFKw6jo6nA6m5evJfF5s41+RsldazjG9mutCqwo4mL9oJMNNKTVZic
         oKUfeX3tcIK/2OcqIvE84hUXcXjC6Y8c0ivDP3kn6fRObB25Za3D4dC22CO1GONW7WqK
         PkUuC+Jovyfu1izZd7fK3abET4oATIM6HGWrzFjNam3csfNO+64oZKWUmkJUPWiLCAJU
         DUTCo0svjvT4SKKMg/6QK2PaQRmmdVmGEKwsDz9aw4X7HYl5aTlQ+DLpM3xlAHBxHE0p
         hpnKdUUdoTB7keQfCq7vdM7oT+NWxkPtcWG9begGksCIg/7mTlDgtaXUubxKSDNBL38C
         9vVA==
X-Gm-Message-State: AOJu0YxL+otCh+1lv8BqIY/YysvbhXVufBHF1aKZhi6NA7637ulREVUr
	JiSzy192lCYm6wGM5L2Palrg9gQsnvldcCSPwoHfe1TNXzDG1WiQ+DAfQjhjz2gPuBtKP+R8pJk
	imVTOI7uaWSnhiFycYAYReqp2XucE9f2LzXFNXea6RrpZmg4li/5X7qjJcVtpew==
X-Gm-Gg: ASbGnctfHNly0WyPci+95cmQ3/JpjHOv/BC8Caqrh0Rc0ZcU7Sgqjk9nlaGecezDCVw
	bJSb6sodx9jmOpYuGVk9fAzpBoWMNTU0Q8Yld8yIiHw+TrRQj0Txfl/Jef+3H4tl6cC0U36ZKRx
	+AmLxY/32h8AbKlYjLMlAUSJ45/GOpvgTz/SQpE5buv2wkMg13uPImC9Jr3XMGzvaPlJEIX7cok
	Kyn+EP1SK/OCGFcCkuj7NMznyC9p8cGCuMNMR0pzEUZkunCV5XdNh7xO5AZHnS0/jx9nTdqQmO2
	KhLYSTej7XvBiJr6WJMCk0SVbIuplIQOgYnAwHc77CY+sOgoBcubLtXKnzt/S/JPApPerpcZ
X-Received: by 2002:a05:690c:4806:b0:70c:c013:f2f with SMTP id 00721157ae682-717ae14a0aemr8913787b3.35.1751993441018;
        Tue, 08 Jul 2025 09:50:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSrwwobExQfmKyjh0uxj8MjdgJHjkTfuytOZu1V2g78A7O7bEJYjF3sjXq8IyRouUD+UsZSw==
X-Received: by 2002:a05:690c:4806:b0:70c:c013:f2f with SMTP id 00721157ae682-717ae14a0aemr8913177b3.35.1751993440444;
        Tue, 08 Jul 2025 09:50:40 -0700 (PDT)
Received: from ?IPv6:2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a? ([2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-716659b649esm21702767b3.54.2025.07.08.09.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 09:50:39 -0700 (PDT)
Message-ID: <a93e72cfc812a117166c0b20e9cca4e5f8d43393.camel@redhat.com>
Subject: Re: [PATCH 2/2] NFS: Improve nfsiod workqueue detection for
 allocation flags
From: Laurence Oberman <loberman@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>, Benjamin Coddington	
 <bcodding@redhat.com>, Anna Schumaker <anna@kernel.org>, Tejun Heo
 <tj@kernel.org>,  Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	djeffery@redhat.com
Date: Tue, 08 Jul 2025 12:50:38 -0400
In-Reply-To: <59530cbe001f5d02fa007ce642a860a7bade4422.camel@redhat.com>
References: <cover.1751913604.git.bcodding@redhat.com>
			 <a4548815532fb7ad71a4e7c45b3783651c86c51f.1751913604.git.bcodding@redhat.com>
		 <a7621e726227260396291e82363d2b82e5f2ad73.camel@kernel.org>
	 <59530cbe001f5d02fa007ce642a860a7bade4422.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-07-07 at 16:28 -0400, Laurence Oberman wrote:
> On Mon, 2025-07-07 at 12:25 -0700, Trond Myklebust wrote:
> > On Mon, 2025-07-07 at 14:46 -0400, Benjamin Coddington wrote:
> > > The NFS client writeback paths change which flags are passed to
> > > their
> > > memory allocation calls based on whether the current task is
> > > running
> > > from
> > > within a workqueue or not.=C2=A0 More specifically, it appears that
> > > during
> > > writeback allocations with PF_WQ_WORKER set on current->flags
> > > will
> > > add
> > > __GFP_NORETRY | __GFP_NOWARN.=C2=A0 Presumably this is because nfsiod
> > > can
> > > simply fail quickly and later retry to write back that specific
> > > page
> > > should
> > > the allocation fail.
> > >=20
> > > However, the check for PF_WQ_WORKER is too general because tasks
> > > can
> > > enter NFS
> > > writeback paths from other workqueues.=C2=A0 Specifically, the
> > > loopback
> > > driver
> > > tends to perform writeback into backing files on NFS with
> > > PF_WQ_WORKER set,
> > > and additionally sets PF_MEMALLOC_NOIO.=C2=A0 The combination of
> > > PF_MEMALLOC_NOIO with __GFP_NORETRY can easily result in
> > > allocation
> > > failures and the loopback driver has no retry functionality.=C2=A0 As
> > > a
> > > result,
> > > after commit 0bae835b63c5 ("NFS: Avoid writeback threads getting
> > > stuck in
> > > mempool_alloc()") users are seeing corrupted loop-mounted
> > > filesystems
> > > backed
> > > by image files on NFS.
> > >=20
> > > In a preceding patch, we introduced a function to allow NFS to
> > > detect
> > > if
> > > the task is executing within a specific workqueue.=C2=A0 Here we use
> > > that
> > > helper
> > > to set __GFP_NORETRY | __GFP_NOWARN only if the workqueue is
> > > nfsiod.
> > >=20
> > > Fixes: 0bae835b63c5 ("NFS: Avoid writeback threads getting stuck
> > > in
> > > mempool_alloc()")
> > > Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> > > ---
> > > =C2=A0fs/nfs/internal.h | 12 +++++++++++-
> > > =C2=A01 file changed, 11 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> > > index 69c2c10ee658..173172afa3f5 100644
> > > --- a/fs/nfs/internal.h
> > > +++ b/fs/nfs/internal.h
> > > @@ -12,6 +12,7 @@
> > > =C2=A0#include <linux/nfs_page.h>
> > > =C2=A0#include <linux/nfslocalio.h>
> > > =C2=A0#include <linux/wait_bit.h>
> > > +#include <linux/workqueue.h>
> > > =C2=A0
> > > =C2=A0#define NFS_SB_MASK
> > > (SB_NOSUID|SB_NODEV|SB_NOEXEC|SB_SYNCHRONOUS)
> > > =C2=A0
> > > @@ -669,9 +670,18 @@ nfs_write_match_verf(const struct
> > > nfs_writeverf
> > > *verf,
> > > =C2=A0		!nfs_write_verifier_cmp(&req->wb_verf, &verf-
> > > > verifier);
> > > =C2=A0}
> > > =C2=A0
> > > +static inline bool is_nfsiod(void)
> > > +{
> > > +	struct workqueue_struct *current_wq =3D
> > > current_workqueue();
> > > +
> > > +	if (current_wq)
> > > +		return current_wq =3D=3D nfsiod_workqueue;
> > > +	return false;
> > > +}
> > > +
> > > =C2=A0static inline gfp_t nfs_io_gfp_mask(void)
> > > =C2=A0{
> > > -	if (current->flags & PF_WQ_WORKER)
> > > +	if (is_nfsiod())
> > > =C2=A0		return GFP_KERNEL | __GFP_NORETRY |
> > > __GFP_NOWARN;
> > > =C2=A0	return GFP_KERNEL;
> > > =C2=A0}
> >=20
> >=20
> > Instead of trying to identify the nfsiod_workqueue, why not apply
> > current_gfp_context() in order to weed out callers that set
> > PF_MEMALLOC_NOIO and PF_MEMALLOC_NOFS?
> >=20
> > i.e.
> >=20
> >=20
> > static inline gfp_t nfs_io_gfp_mask(void)
> > {
> > 	gfp_t ret =3D current_gfp_context(GFP_KERNEL);
> >=20
> > 	if ((current->flags & PF_WQ_WORKER) && ret =3D=3D GFP_KERNEL)
> > 		ret |=3D __GFP_NORETRY | __GFP_NOWARN;
> > 	return ret;
> > }
> >=20
> >=20
>=20
> I am testing both patch options to see if both prevent the failed
> write
> with no other impact and will report back.
>=20
> The test is confined to the use case of an XFS file system served by
> an
> image that is located on NFS. as that is where the failed writes were
> seen.
>=20
>=20
>=20


Both Ben's patch and Trond's fix the failing write issue so I guess we
need to decide what the final fix will be.

For both solutions
Tested-by: Laurence Oberman <loberman@redhat.com>



