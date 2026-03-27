Return-Path: <linux-nfs+bounces-20473-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHR4Ehq7xmnoNwUAu9opvQ
	(envelope-from <linux-nfs+bounces-20473-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 18:15:06 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E0E34824B
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 18:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41C453087EA0
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 17:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874E43750BE;
	Fri, 27 Mar 2026 17:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="Yoo2T/+i"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A1C363093
	for <linux-nfs@vger.kernel.org>; Fri, 27 Mar 2026 17:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774631326; cv=pass; b=ddSX4dVeGzL4HauKPUmyWYbhIJDIwaiRUXxZcvwWzwdT2m7OjMU2yUcUDFSwUO+UqymVdoZixqMm5jea57BEMbHBKUwwaA50Eoopu4el1GZOytVSjdBHQB7850BVbqRc9QxJXz5ckJlU7+NI1o9I3MlFY6V4YkJjhe1aHeujlYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774631326; c=relaxed/simple;
	bh=p6blnEP84zwSPiqyfMSMq8iKUtUMKCldS7s490NVGBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GiRLypX9Fy4JRVb2xUl1JkDnU3AyKcQkcg8H69+REwMYBKxQkQIdghw8cbDq7LI+W6BcW2uK09G4IugxP7u9Bmb5p6VC+oAnLt6LteuNzlXGpntb9h/pHFXhlHd5cMebonjzmlF4vmVUpQkhcv6erPOzbGyER1jmYaC+41dRpo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=Yoo2T/+i; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a27b5ad832so2674567e87.2
        for <linux-nfs@vger.kernel.org>; Fri, 27 Mar 2026 10:08:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774631323; cv=none;
        d=google.com; s=arc-20240605;
        b=DNl533RiVKgEwDmyaoZLYEU1Q6u9NO0WYpfi78ZD0dhqbj3x16W3Kqwy5jDHul/uR+
         SYQtEqzYhLQdOwGZbFf3EwL2y8ta7SkLvwDjQr930nUz7BaAql5+nYTYWFOsgv4qLcTF
         AidId3yRcSGlxXsKoTsrMtAppeyxrKgDqc6XOHRARMMDeoDkjsJCg/UqMTWCUiQYV8XK
         UbuH1j8bTRaK53KdJOioAD/eaPEP0IoIy9lL2GCDGisZcHHW6Kub3euv4CD9NZiJOo/a
         g4KIBhQqH9MBvdCAZANj5D4AOPq2bYMpF12PkmC7/M6K6K1B/aL8arXFz+j/J8ghMNR1
         pFMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z6EMObbO4hlwLmO9ZTMCVsd9K4nT+taL+Amg7F38pZA=;
        fh=WQNx75D64UUe6zUYKTIl4RjeGR0Qy+m2A6lnoU0sWvo=;
        b=Fe93yed8TpT8qURtbWwYVkQM3PU1RnGFn2Px65PxOSB8LlLMBVbnta6Ox8CXscNty8
         1xDOiSKU2Nc1lay1DNyDlRu3SV9IwI/OGlpiOviOJ8aotwgZM7hHSZRf4afyPTOWS4bZ
         TA5mE/Zw1gcuV1vZvnK3VSGzLuTlNwoRL447W7sA/j0/mjvAmkQaBpx+lPXAZGdjBjLI
         LBQJ39D1z5FkxXqND9bdqgmwGMehyMPuptS5tOUhFjKrWeLNElIy3kHP/OIrjlPCfQel
         AGL+MRkyBZDIZq2cZDm995aGr/EKL+fmeZAa7f250EPAtIlklDqoyRmGfpc6fZu7rIhA
         SNMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1774631323; x=1775236123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6EMObbO4hlwLmO9ZTMCVsd9K4nT+taL+Amg7F38pZA=;
        b=Yoo2T/+i8tEJ5vdEjYVNQDAXd6mIi5sfZVCj9sNzjPfJ13A6TAbZydsgZpDE8c+YMi
         dWnhm0IziOTM/03kgt7bWX7yEg435V7aAyhDMMQwrFfy+kPrmnCltHbITXxNG3zJBDG3
         02M3gWa0vXbuPlJOUXMryS1YEfzkewgU/ku1brvgn5Ubv64Cz9jll45JXLrJ63DW4uv0
         VvXgWEIuq/dBr3L9mMHY2Et9j5Q47hQlZk9s8r09wM8QgKs4OGSoKDTFSql9/2ETA8Cm
         qjbrTB45cOeI2Ozpl26o6g0ojq/5IOXx4Ak1sTwyni6EeQ+mVXPsil9a1ms6xs20xp3t
         CFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774631323; x=1775236123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z6EMObbO4hlwLmO9ZTMCVsd9K4nT+taL+Amg7F38pZA=;
        b=C2LiF1RXtTPkKctv0vmpqBqPH4A/cBSLJTOvxy8h7zDDGVkRCmsbdiQ8nrr97InEBn
         FmllfC0N1MwniGk3TgkA2Z9/lKh98G8MlWQVRcNbR5hPlBUQbQm0o8SL/FD3ZRsTYfc5
         KCgaplrvtxXPna59W/PBZ1Lx8Xs5naoIoT3Ui3zpf4ybk4pj1N1BocVY//zeKCn77BgD
         zJou9FXTC/FBDJVt5gXshZeHQXoAzJbkwOlXddHM+s7xD9/X18eHjQkLbq1ZTXs44611
         05hVmnMadOEY8gRcMwNLGLbFOt42a++8vkuSVH1rEzKzr3X9wdiGouQAf65+Di6egJBl
         RVPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcQNpTB6jbEvF3GeEP6uQ3v0uTpRJ2B5mbcqj3J/L0McI4XnIXaeLJWhDDmApn4o+QcXRQsI3uDiM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb/aoAPobReYQ81bmvRnuRjuW/U4L+aQRxB8+x8wBucCpk9qNh
	Pg+UJqsdcodqtYtq9pJOsbOiPMW+AkXRXv1yPEpBy+bNjui3hj8NVoM+Ix0+eDQK2fyYgdgIfN0
	6kV8GCUg59hMEDP5agdtrs6GaQwy/v2g=
X-Gm-Gg: ATEYQzwqSrZNrUH2R2tRvxvxXTWGpZzeFtscvyC9wgbWaRDKgp5kPJQke8Z33/BioGr
	CUoQUcz9ark/+BHfcTBwKwn4RT4XUoeGCLzdpBIlgufPaRKPlBfNdZ7BjcBlttC1sfwt82cAN2Z
	h+X55rKntayWQkj0MKnTAyCCVqVn1zVGGFfmzY4h5ZGXOClCdn5Wu4Loqpe5L+Zui5m8LJcRWg4
	soTFz7zQHXOSAn6HVpAPp8m3bWuxG/tvhmGdJHCKghKJF9M0P7GodjnxEi/q2vOnOj+kByxkBPP
	zsboaH+bkW0qOzXwc0eT9c/vd6LTFTk8uHX+wtkFzg==
X-Received: by 2002:a05:6512:1381:b0:5a1:448b:317b with SMTP id
 2adb3069b0e04-5a2ab934c4amr1597665e87.42.1774631322357; Fri, 27 Mar 2026
 10:08:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327165757.28948-1-okorniev@redhat.com>
In-Reply-To: <20260327165757.28948-1-okorniev@redhat.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Fri, 27 Mar 2026 13:08:30 -0400
X-Gm-Features: AQROBzCv_0JCnkwXEU1PvLK6Y07T7j0ZH7GAHcAgM_UprkMDBtwmmWk8SwZiQUQ
Message-ID: <CAN-5tyGJ5Y4h8iKq-F_AqYR0a8U8NrO2xk9hCG1AaJWJabW+-Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4.2: fix COPY attrs in presence of delegated timestamps
To: Olga Kornievskaia <okorniev@redhat.com>
Cc: trond.myklebust@hammerspace.com, anna@kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[umich.edu,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[umich.edu:s=google-2016-06-03];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20473-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[umich.edu:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aglo@umich.edu,linux-nfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,umich.edu:dkim]
X-Rspamd-Queue-Id: 37E0E34824B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 12:58=E2=80=AFPM Olga Kornievskaia <okorniev@redhat=
.com> wrote:
>
> A similar to generic/407 test can be done with a COPY operation
> instead of CLONE (reflink). And it leads to same problem that ctime
> and mtime saved before doing a "cp" operation are the same as after.

Some extra comments here.

Currently the COPY compound does not add a GETATTR after the COPY.
Jeff's solution to REMOVEXATTR not updating ctime was to add GETATTR
to the compound and then call update attributes. This could be the
alternative solution here instead. I'm not sure such an approach would
be preferred. But then there is a question of whether or not the
server does update its attributes on COPY.

> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> ---
>  fs/nfs/nfs42proc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> index f77372a78be7..ea420dc94875 100644
> --- a/fs/nfs/nfs42proc.c
> +++ b/fs/nfs/nfs42proc.c
> @@ -502,6 +502,12 @@ static ssize_t _nfs42_proc_copy(struct file *src,
>
>         nfs42_copy_dest_done(dst, pos_dst, res->write_res.count, oldsize_=
dst);
>         nfs_invalidate_atime(src_inode);
> +       if (nfs_have_delegated_attributes(dst_inode)) {
> +               nfs_update_delegated_mtime(dst_inode);
> +               spin_lock(&dst_inode->i_lock);
> +               nfs_set_cache_invalid(dst_inode, NFS_INO_INVALID_BLOCKS);
> +               spin_unlock(&dst_inode->i_lock);
> +       }
>         status =3D res->write_res.count;
>  out:
>         if (args->sync)
> --
> 2.52.0
>
>

