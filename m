Return-Path: <linux-nfs+bounces-20777-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDNBLmSs1mmZHAgAu9opvQ
	(envelope-from <linux-nfs+bounces-20777-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 21:28:36 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A963C30C0
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 21:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA293303D334
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Apr 2026 19:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC82D25A321;
	Wed,  8 Apr 2026 19:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="eQqgiV+X"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CDF282F1E
	for <linux-nfs@vger.kernel.org>; Wed,  8 Apr 2026 19:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775675003; cv=pass; b=OSDPY92Pl/+rosKWs194Dw6yQkAmCL84v2gbqYjnC7FYHfjYCnfD5jq79H9tX0RZd9oyUn5dVdzVpSubmIUjRBE0/enyIXnQV1jYoAEEKqY7DWMOnlE3kLznIq9prjebV+qhDBWA1Q84CjP44dJCJYqvLerTn6TM36fMCJiYg5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775675003; c=relaxed/simple;
	bh=e+Zha6v5ZcoD/hNsrl4b2EKJcvFLWQy31ibDVQAb+tI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ghe2DOP/TYT0AQe6WUUsLT+vpdEF3nZIENp+eYT/BfiT51XlEjnsMvkQ2jgV4MEtZ4Tm5R0MHto3jtyKuwy0nK8WYBsUt27qWPDce5KW8wYhFc4wFYmaWkB+QEmW/GQB/YVfmDxv8r8lMqV5oIl8pDyT5NWwf7LSzkxCoVm5M7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=eQqgiV+X; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a2a70bb69eso84054e87.2
        for <linux-nfs@vger.kernel.org>; Wed, 08 Apr 2026 12:03:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775675000; cv=none;
        d=google.com; s=arc-20240605;
        b=LqFxjcpClhhfe/XqeP4+EoSI7klyhifcWo4wjzBQYJLNfyQhrGI7NmhTuT3QZlv0eg
         bLmSa1mfYUHJLUT7NwWzwhiFaBA8EJXy2/Jg8UPA7kR09yU2D+w7URqHfuNkjP5doIq0
         tMRtpMD4ZYwtTLmfIkqeNp2curJTrFMtXezrQ4DBRGa07FkC2NR8uKDCluVrTvBC0Ww7
         j3fIftI3c0bybUlkS7mxR55U6+KDW+i4sOCzfcyjKkk3uKnTtk83ADY4iQV4kYLRkdG+
         /G6/pKw4AFqs+jcPN2sp1EOms460lSAKOyezO2qgo4O4mRMXDYXmHD/O71V4AOHoKoFf
         zSVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kU6TpCDsFaUy2fHjLti1Z1izhZN5LwNnWUeYQANZoxg=;
        fh=OPkv6VZVYRkB2dDBNNFLxd9Px2XG5LaJ6s1V8qMdUfI=;
        b=EVHijwBC1mg/JsQCdafQbMjTKtCFYwZ2wMRtqJ7kPghhortsCdphfgrOEcDAsFTz2D
         4tlmO+HjPPjgd+D8vgxXp6mTel0BnRuUzaLzjy6x9D9H45Mmic7VvNfnerW+BZJ3ZmhX
         wz/e2YYyUGvWE3SREBcJbAXQkuQkY5sjzNdjhohzFiOMwCGbPZK0JWjoh7yT+I2vSn9m
         IiQkuAWOzGIrdMNAkn72fuquwXaU13TrCQxE1/awi94wr+mvrOsd7H8yhDIgnaoRSwQl
         OsLh46Fi6BXfH2v1NJWXM+ba45zFs8DCTGYqsI1kC0grBb0vxtbIwGWz9AerZnwz6YBJ
         z7NQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1775675000; x=1776279800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kU6TpCDsFaUy2fHjLti1Z1izhZN5LwNnWUeYQANZoxg=;
        b=eQqgiV+X2xkCjNuBl91eBCfPhCUjN8xdFsQQb2ZFjF/RilHTLbf2Y09VmIAOg6UNIS
         IjAqRDba7ezp/K21/SUiOfd8TvCWEcVY7WXDQJKehCjr6yzhdqOr66ZlBZNd1bv2UXF1
         LtylMuU/uHwU1o7lfsEH4gk0fJMwbmFTLPPs5W1Zb9VEhJ/wCOt38w1y8f+RjyZb/VmS
         9nDMMGBUsH5aCNe6+RTomzfEbUsS651cfzeJwIru7WShW4IbFUZmkOUrC+hBZXKLz1WS
         C+MSYz4kfqiwVaM8YOov1jEk5uT3MLK826d2xcj6CIuSEmPOK6y3FX3JItKvVSyBprc1
         lbBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775675000; x=1776279800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kU6TpCDsFaUy2fHjLti1Z1izhZN5LwNnWUeYQANZoxg=;
        b=XTsxsP7vLssn/zdQDmI3xZMRiiN27pEtEMbVo/dj8IcCdZ7MLeZSsQLxPzbEr6Mb71
         EWSxPvJCM6iKy5cwEvbAo0KH+BrRN2wf6GaT0CeryxGL1ZPE0/Sq8luDssHLI9y2n7AP
         JakX8rlBGaEvDETpDB9mRz5wqzVr1asRm5ij8uN7MKXwq14jneWWfhHFQxK+eQ6z4e27
         XJhrzifPTL5PSL0kgd6Z8Ty4qgtZYJSejoP+htfoc2QniuWN9Z+vxA2IrYTNFAbitdka
         oGjOoaShY1/YzGRwz5PlW5B9Qo6o4U5YY0YPRwsOPJo3iLwhtwXRpNEyiBkzSYk7w8Vc
         rT+g==
X-Forwarded-Encrypted: i=1; AJvYcCWFlPmK84sL/At1yNlo1cj/QdimI4djl3OTCmCC7Sv7MrKfCKc4CGWQm22MCxHdYAGIUoEPCFJoNyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YymhypfgB+T79m0vHsu8d+/+UlbfICYBbBeJSX/OfZQU+7St3Y2
	TETf0UPKFicWF7Q6evnpbXY3J/Gh1ah04zlWp13dcIlAdxpRIARR5gzOKXjDaAA3nX9wKjTFnZe
	wXSwkq/BC2oO0jlG1IR8/4W5vBHKhjWoTRg==
X-Gm-Gg: AeBDieu8E7XY+qKyWHPmdUPkKCT8O2QwQJIfLgGeVVGuJPpvWQ0KD2rwxerNRpZXJjg
	Y0XkxSZXBb00rNY19hczT10AEFHzzZ2GAlVCUDQ9plRHD7Fke86cTEk0BytV6SJF42D7jeC72eh
	cpcdKhoCYqP6393GcK4/4EAacMeRnJJ0f0isbaWWQ3IQylcbi79n81MmQaXySUnu7gGjDjozsdZ
	dQQ86fXwX8GzJitCwZ7QqjTeMh39mkd17e635dyW9jGUVn3w1w5L2di+aC0q6ci/hqPEXSUNink
	A0DmJ1cXsap/4TGFb5BPw4w1NtpaQz6EHEKSoXW8MpJfguyYv8mD
X-Received: by 2002:a05:6512:1309:b0:5a2:b842:6850 with SMTP id
 2adb3069b0e04-5a337560adcmr7182461e87.15.1775674999299; Wed, 08 Apr 2026
 12:03:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327151149.25317-1-okorniev@redhat.com>
In-Reply-To: <20260327151149.25317-1-okorniev@redhat.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Wed, 8 Apr 2026 15:03:06 -0400
X-Gm-Features: AQROBzBe5-wmsKPaqWl77Ai4ntSDbKllI07EFri-Cv6bfSJkXHFD5w-GaSm0hMY
Message-ID: <CAN-5tyEdJavM2yVh-_VPdNQGnUev=+YEoXk5SXBa0gioo1jz7g@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4.2: fix CLONE attrs in presence of delegated attributes
To: Olga Kornievskaia <okorniev@redhat.com>
Cc: trond.myklebust@hammerspace.com, anna@kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[umich.edu,none];
	R_DKIM_ALLOW(-0.20)[umich.edu:s=google-2016-06-03];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20777-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[umich.edu:+];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aglo@umich.edu,linux-nfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,umich.edu:dkim]
X-Rspamd-Queue-Id: 07A963C30C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 11:17=E2=80=AFAM Olga Kornievskaia <okorniev@redhat=
.com> wrote:
>
> xfstest generic/407 is failing in 2 ways. It detects that after
> doing a clone the client does not update it's mtime and it's ctime.
> CLONE always sends a GETATTR operation and then calls
> nfs_post_op_update_inode() based on the returned attributes.
> Because of the delegated attributes the client ignores updating
> the mtime. Then also, when delegated attributes are present, for
> the change_attr the server replies with the same values as what
> the client cached before and thus the generic/407 would flag that.
> Instead, make sure we invalidate the blocks attr.
>
> Fixes: e12912d94137 ("NFSv4: Add support for delegated atime and mtime at=
tributes")
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>

This patch isn't needed if the server updates mtime/ctime after doing a CLO=
NE.

> ---
>  fs/nfs/nfs42proc.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> index 7e5c1172fc11..f6a7cfa12225 100644
> --- a/fs/nfs/nfs42proc.c
> +++ b/fs/nfs/nfs42proc.c
> @@ -1306,7 +1306,15 @@ static int _nfs42_proc_clone(struct rpc_message *m=
sg, struct file *src_f,
>                 if (count =3D=3D 0 && res.dst_fattr->valid & NFS_ATTR_FAT=
TR_SIZE)
>                         count =3D nfs_size_to_loff_t(res.dst_fattr->size)=
 - dst_offset;
>                 nfs42_copy_dest_done(dst_f, dst_offset, count, oldsize_ds=
t);
> -               status =3D nfs_post_op_update_inode(dst_inode, res.dst_fa=
ttr);
> +               nfs_update_delegated_mtime(dst_inode);
> +               if (!nfs_have_delegated_attributes(dst_inode))
> +                       status =3D nfs_post_op_update_inode(dst_inode,
> +                                                         res.dst_fattr);
> +               else {
> +                       spin_lock(&dst_inode->i_lock);
> +                       nfs_set_cache_invalid(dst_inode, NFS_INO_INVALID_=
BLOCKS);
> +                       spin_unlock(&dst_inode->i_lock);
> +               }
>         }
>
>         kfree(res.dst_fattr);
> --
> 2.52.0
>
>

