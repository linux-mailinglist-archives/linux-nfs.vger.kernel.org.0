Return-Path: <linux-nfs+bounces-6338-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 467769718F3
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 14:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0B7B2847B6
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 12:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125DC1B6535;
	Mon,  9 Sep 2024 12:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GwT7QUBg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62371B5EDE
	for <linux-nfs@vger.kernel.org>; Mon,  9 Sep 2024 12:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725883774; cv=none; b=CbhWuNP0cr9/02UT0UjcyfJA7CoImhkOKEEi/61y+FGF9aDILLbB71POOROtdfjC5oithB2cJbFVQKTT5YYAXkLFb8t1t8G8NFVVrS/Kv1RPVtX8DeY+tSvzZXFIhxUwfcjkuSQrjC1SXWCP05rJ4+5V/rMALmWGXDgBpvEPel0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725883774; c=relaxed/simple;
	bh=mH1Zw3WAHBvBpu1cTPslgFGbiTI5j3Uh1QGFmBSuJyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HasBmfwZ16eeQ5lkEYopBjOhHYPmrI/DqERRKNvGJlfb57mefawvdGx6PbM7B4PsjY/rnyyoeLVfBsNZw1K8tiI+f+3cwAjlWac6NmN7pA/dcqtdrh7qjaliZiIFohfUr17pOeEOIbRG5SgkR7HsozTnMGLOhQvWVtMIa3XLjS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GwT7QUBg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725883770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=psmam9kl/beoi/zbMm+1O+FG1FefFxaekU8ekwD/aYI=;
	b=GwT7QUBgnzzLcVJv6Rrz8jqfbxrSBSvfiu/MWKQjau9pX1iF5QSO49B0z7SUeGZyrCOy3L
	iUTuzXfHM48OKH4eGTy+QeagscjV+uf12lbC6ptkWtCT79kKDshQH0aec2LNWg83P3R0g1
	YLRr4DRTZcwJ3J4yzg9hOiUUhYn7n7A=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-hz77Xpi7P1S7TaJVGZwVIg-1; Mon,
 09 Sep 2024 08:09:27 -0400
X-MC-Unique: hz77Xpi7P1S7TaJVGZwVIg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 827C51953956;
	Mon,  9 Sep 2024 12:09:25 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.50.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C107830001A1;
	Mon,  9 Sep 2024 12:09:22 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: fix delegation_blocked() to block correctly for at
 least 30 seconds
Date: Mon, 09 Sep 2024 08:09:20 -0400
Message-ID: <5A662EF6-D836-4751-8D8C-AFF68DBBC7C5@redhat.com>
In-Reply-To: <172585839640.4433.13337900639103448371@noble.neil.brown.name>
References: <172585839640.4433.13337900639103448371@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 9 Sep 2024, at 1:06, NeilBrown wrote:

> The pair of bloom filtered used by delegation_blocked() was intended to=

> block delegations on given filehandles for between 30 and 60 seconds.  =
A
> new filehandle would be recorded in the "new" bit set.  That would then=

> be switch to the "old" bit set between 0 and 30 seconds later, and it
> would remain as the "old" bit set for 30 seconds.
>
> Unfortunately the code intended to clear the old bit set once it reache=
d
> 30 seconds old, preparing it to be the next new bit set, instead cleare=
d
> the *new* bit set before switching it to be the old bit set.  This mean=
s
> that the "old" bit set is always empty and delegations are blocked
> between 0 and 30 seconds.
>
> This patch updates bd->new before clearing the set with that index,
> instead of afterwards.
>
> Reported-by: Olga Kornievskaia <okorniev@redhat.com>
> Cc: stable@vger.kernel.org
> Fixes: 6282cd565553 ("NFSD: Don't hand out delegations for 30 seconds a=
fter recalling them.")
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs4state.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 4313addbe756..6f18c1a7af2e 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1078,7 +1078,8 @@ static void nfs4_free_deleg(struct nfs4_stid *sti=
d)
>   * When a delegation is recalled, the filehandle is stored in the "new=
"
>   * filter.
>   * Every 30 seconds we swap the filters and clear the "new" one,
> - * unless both are empty of course.
> + * unless both are empty of course.  This results in delegations for a=

> + * given filehandle being blocked for between 30 and 60 seconds.
>   *
>   * Each filter is 256 bits.  We hash the filehandle to 32bit and use t=
he
>   * low 3 bytes as hash-table indices.
> @@ -1107,9 +1108,9 @@ static int delegation_blocked(struct knfsd_fh *fh=
)
>  		if (ktime_get_seconds() - bd->swap_time > 30) {
>  			bd->entries -=3D bd->old_entries;
>  			bd->old_entries =3D bd->entries;
> +			bd->new =3D 1-bd->new;
>  			memset(bd->set[bd->new], 0,
>  			       sizeof(bd->set[0]));
> -			bd->new =3D 1-bd->new;
>  			bd->swap_time =3D ktime_get_seconds();
>  		}
>  		spin_unlock(&blocked_delegations_lock);

I stared at this code a long time without seeing the problem, but now it'=
s
obvious.  Thanks very much Neil!

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


