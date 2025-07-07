Return-Path: <linux-nfs+bounces-12919-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8FBAFBBAA
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Jul 2025 21:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9C1B1AA3A54
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Jul 2025 19:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E006F26561C;
	Mon,  7 Jul 2025 19:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p80+dC/N"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B646A224B0E;
	Mon,  7 Jul 2025 19:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751916320; cv=none; b=dGflg5nmUUQfW6WOdCasyvixJtnexbp43u3YG+/ef3QiagUXTDyRlqZVRbo5sTriIQkqQblYukzaciovV22vJnoTKV9Entu6KaUvDU4KZOneLPFY70Cu47wfoMGTrYo8fqzbq4v40/wN63UKBXda7NqAGtz/RFuwWSaVZ0OK8qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751916320; c=relaxed/simple;
	bh=hP82dDhok+6gAH/5p/uOZI8kvP28j/8sBKLtucO7i/E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S+satZSuJEHol4fGkH3NM+VkAfBNihDlvFSVkLl1Q1ZpOvs+oIbCXazz7AxqcHnfe8YI4FHS25hT08k/X+hl4b1anXqh4/QBTqrsaellaPe46roD10uFLNr0byE+dYRlz+Fk75LUp50liWkFDUe/A8ykOH2q7XIbQuZOI9rVZNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p80+dC/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5828CC4CEE3;
	Mon,  7 Jul 2025 19:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751916320;
	bh=hP82dDhok+6gAH/5p/uOZI8kvP28j/8sBKLtucO7i/E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=p80+dC/NCnHnEbiDeDorpKK+/+72fDO6sO0W69Q0RnQXiYZkCGVnyK/Js9VAWXKbJ
	 eLgWJeTm0gW3GpylTxzy3Y2sDESv/XcL63cLzvN+UAFDszY//i8jvC1pSjS2fpaWuW
	 HA5qWiM+Vw8l7hQSysqWFBUAZzwr9KCxA7GrZBItrl/4dErwr03XmXdXj4PpoGbZi5
	 SYCo81vWotKyb/BpeHQ1eGruR4PaTFP2SybJwMXR0ITnD1gMGdfVgn8AcQXHPVU/Lz
	 FzmEi9uV1PSBNYSfdei1oQLchNO3G/NgzTZMjbDgJZlsiYOZP3sizEFQVlB6V/iQuA
	 XCM7aErY2aXSw==
Message-ID: <a7621e726227260396291e82363d2b82e5f2ad73.camel@kernel.org>
Subject: Re: [PATCH 2/2] NFS: Improve nfsiod workqueue detection for
 allocation flags
From: Trond Myklebust <trondmy@kernel.org>
To: Benjamin Coddington <bcodding@redhat.com>, Anna Schumaker
 <anna@kernel.org>,  Tejun Heo <tj@kernel.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	djeffery@redhat.com, loberman@redhat.com
Date: Mon, 07 Jul 2025 12:25:17 -0700
In-Reply-To: <a4548815532fb7ad71a4e7c45b3783651c86c51f.1751913604.git.bcodding@redhat.com>
References: <cover.1751913604.git.bcodding@redhat.com>
	 <a4548815532fb7ad71a4e7c45b3783651c86c51f.1751913604.git.bcodding@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-07-07 at 14:46 -0400, Benjamin Coddington wrote:
> The NFS client writeback paths change which flags are passed to their
> memory allocation calls based on whether the current task is running
> from
> within a workqueue or not.=C2=A0 More specifically, it appears that durin=
g
> writeback allocations with PF_WQ_WORKER set on current->flags will
> add
> __GFP_NORETRY | __GFP_NOWARN.=C2=A0 Presumably this is because nfsiod can
> simply fail quickly and later retry to write back that specific page
> should
> the allocation fail.
>=20
> However, the check for PF_WQ_WORKER is too general because tasks can
> enter NFS
> writeback paths from other workqueues.=C2=A0 Specifically, the loopback
> driver
> tends to perform writeback into backing files on NFS with
> PF_WQ_WORKER set,
> and additionally sets PF_MEMALLOC_NOIO.=C2=A0 The combination of
> PF_MEMALLOC_NOIO with __GFP_NORETRY can easily result in allocation
> failures and the loopback driver has no retry functionality.=C2=A0 As a
> result,
> after commit 0bae835b63c5 ("NFS: Avoid writeback threads getting
> stuck in
> mempool_alloc()") users are seeing corrupted loop-mounted filesystems
> backed
> by image files on NFS.
>=20
> In a preceding patch, we introduced a function to allow NFS to detect
> if
> the task is executing within a specific workqueue.=C2=A0 Here we use that
> helper
> to set __GFP_NORETRY | __GFP_NOWARN only if the workqueue is nfsiod.
>=20
> Fixes: 0bae835b63c5 ("NFS: Avoid writeback threads getting stuck in
> mempool_alloc()")
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
> =C2=A0fs/nfs/internal.h | 12 +++++++++++-
> =C2=A01 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> index 69c2c10ee658..173172afa3f5 100644
> --- a/fs/nfs/internal.h
> +++ b/fs/nfs/internal.h
> @@ -12,6 +12,7 @@
> =C2=A0#include <linux/nfs_page.h>
> =C2=A0#include <linux/nfslocalio.h>
> =C2=A0#include <linux/wait_bit.h>
> +#include <linux/workqueue.h>
> =C2=A0
> =C2=A0#define NFS_SB_MASK (SB_NOSUID|SB_NODEV|SB_NOEXEC|SB_SYNCHRONOUS)
> =C2=A0
> @@ -669,9 +670,18 @@ nfs_write_match_verf(const struct nfs_writeverf
> *verf,
> =C2=A0		!nfs_write_verifier_cmp(&req->wb_verf, &verf-
> >verifier);
> =C2=A0}
> =C2=A0
> +static inline bool is_nfsiod(void)
> +{
> +	struct workqueue_struct *current_wq =3D current_workqueue();
> +
> +	if (current_wq)
> +		return current_wq =3D=3D nfsiod_workqueue;
> +	return false;
> +}
> +
> =C2=A0static inline gfp_t nfs_io_gfp_mask(void)
> =C2=A0{
> -	if (current->flags & PF_WQ_WORKER)
> +	if (is_nfsiod())
> =C2=A0		return GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
> =C2=A0	return GFP_KERNEL;
> =C2=A0}


Instead of trying to identify the nfsiod_workqueue, why not apply
current_gfp_context() in order to weed out callers that set
PF_MEMALLOC_NOIO and PF_MEMALLOC_NOFS?

i.e.


static inline gfp_t nfs_io_gfp_mask(void)
{
	gfp_t ret =3D current_gfp_context(GFP_KERNEL);

	if ((current->flags & PF_WQ_WORKER) && ret =3D=3D GFP_KERNEL)
		ret |=3D __GFP_NORETRY | __GFP_NOWARN;
	return ret;
}


--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

