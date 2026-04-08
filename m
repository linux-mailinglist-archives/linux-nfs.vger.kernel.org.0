Return-Path: <linux-nfs+bounces-20778-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCARGhmn1ml9GwgAu9opvQ
	(envelope-from <linux-nfs+bounces-20778-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 21:06:01 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7374D3C2638
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 21:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 82A413004DDB
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Apr 2026 19:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5A43B19A3;
	Wed,  8 Apr 2026 19:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="WCn6ZZWs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B6025A321
	for <linux-nfs@vger.kernel.org>; Wed,  8 Apr 2026 19:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775675152; cv=pass; b=m9vWPVrKH4pQzBg7rW2YEHy5TVK4fITPZ4BR1/ijCHuM7UIBtbN17Bo225+ASnR8b9/JDEZXaqNpiEUL2VQ8M/xwvvnXPUH0Ncn+IKXLUrf/0xOcGz8Tl/03kv1+w4PLoM9x9x7qiwUuLry/f8/N/aCp67QSV27L43oV9xRcH9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775675152; c=relaxed/simple;
	bh=I04yhcxFLioUFrrFzsLmb3/0bxt2aQMXGuc7RmJl5Q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V2l/q8sa256kFkfhwuAxRjwMk2fQ8OmbHHHttF0KfzB+R0v0zrrRM5wXTgP7wwmrqQx+Pqgpuu4q7jhmtEmebEONP2ZZ3/2npyDY60GECw1quXTziLF6mWG/eTyLa4q1YeStq4n/JDjXLmokzcGADRk1erkTt8jquFL7zKFbM3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=WCn6ZZWs; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a0ff30b240so92029e87.0
        for <linux-nfs@vger.kernel.org>; Wed, 08 Apr 2026 12:05:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775675149; cv=none;
        d=google.com; s=arc-20240605;
        b=KBYrm5DnRKb1pgm0z1GigWWCguffUbYJivMZtxboN1o6+WD9CEULVQF5R1htPyTccx
         2Yma+HhoXKAsaExFw582toIJuabY0NKMReIrq9gbpUT9XsF/RTJBrzDwebyFm+aQ1m0t
         3FZT9+OoRtIb/tBaCfyOzzrgrwfKb5RKthBJLGoZnl3NV+g8xzIYjt0H3W8JEp9DXUYU
         VRtdfpJF62xY4mZVJpKJRpYTb/48iKjheS6qwEeCXga7JPLjtKd49WzPxp0DAG/QBcBH
         sFzZAb4QJi61nyV1d452UzXo/cwG9HdMDYn+yT3hCY4cdNYoGvIHN7f8/v7aVUvLRh3D
         uMUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jnmREhpG/n5LBkEU6sCAq/wZ5KHkLtCqjj2Lx/A4cAQ=;
        fh=x/AwGdBd6gU066jgtOMqJADRIv9I2AKdvXzM2KXjxgA=;
        b=VlonOYbFc0eB/A7ylPBvGKwlq4HiDlwkYBCJp0LW8wP6Rd+xKfL6Me+PUEem5tcswN
         SK+ldFmywle/6RO+juU3/D+X5zcNzwZfOCU1gqeAcTdHE//g4n95v60iA8BbQPcOlpkP
         Nu7DYPI05hnBlFPXeGDo6D6WyLerE1Vm+I7k8DALLOH9qQhaIiRngHMi+TZlIVdbtt0g
         o3y/OGhtEQdMpf58pnivkUmV6CAFgWMNRUFyXIoTT0QRRb3tciYvG4R25XZjeZ3cKGw5
         JRORH1hahJfKSHC8tVekhVEPRssNNq89qps1++P9Gm8FxKpcrGZD+jg1gHuPKT7S+Wd5
         IopQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1775675149; x=1776279949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnmREhpG/n5LBkEU6sCAq/wZ5KHkLtCqjj2Lx/A4cAQ=;
        b=WCn6ZZWsFuhe7FDsMQqp14hVnZTA2ju6xthQErWe3c4eZbeeMNQAyeJ3lJDlGv3gZ4
         VeR8K44dirVMK06avWIlvqercaJwGiAZrvizc8DFZK770tPg2W1EuBODk1QsPRhtpxHT
         DppfZM2peae3+rrcx+rzOr+m8Rf2fobrE3RJF/cfCWZ8n/IjVm07E/C2tMv0xW7U2J5d
         5VMz9vDtvyxryc7B1fTIqhbd6z9jVbVGGb8rggx3x2BpYDQjq81TFw5MB/gC1+8FWKzP
         fIewOas252buF97fw1Wfa503Gt5WQkpsxDeb9nMB4cD0jVqN2bnNe8iXGwm3nfOudYwP
         gfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775675149; x=1776279949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jnmREhpG/n5LBkEU6sCAq/wZ5KHkLtCqjj2Lx/A4cAQ=;
        b=RSgvFvcSMe80cok9DkTryyahJFPNQAFvM8t0A3PlxIZKoql61hyVpwfDJ8hT1zn+fw
         CAbzTHu16F1lJskDr+NfxZn9BgcJCwb28OxCueuU+/h/h/5SdaZxKOifjhZJIgyjeEMC
         Pq9Xf6oRvHUsmBPopK+VGuyskgSQFYKMX7NJOfkJCL5N9rIjmhKbvkFgIjM1mRFaDLhM
         p8ZUhcIGA0J2/JPX+lyg3WL9Iv65f5PZUZwnKwQhfTrAvW9wUfHNqi1P2OUvRh+hQVz7
         B8/p5rkRYb8Td+cXVTm0L1UQYh4oeWwfHAxah8Kq+hPm+tmYCVIDVkvSC/mRyMJGRgYK
         HwHw==
X-Forwarded-Encrypted: i=1; AJvYcCWhfiMPwVpiUQaAeMjvgcChjHLL7gbFCinY2IwvicmUqxDH3Wk2Iwdu+dEWjb1rnBqiuZmaffHcNgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQoAtSigbvz4U1I3c8eFHE5u6wbTSKek79m024qrwiu2iDsONV
	fE09fen2Uc2OrGfXNmwDeRNlVbZXbbzLhw/N4AN4+pYNrc0gsEdtzjqrjfFCpk+a0ocPeFk/2FD
	mlPIhv/DwFo1svJbn+c1sYfRlKREm2js=
X-Gm-Gg: AeBDievocFBHbdWPTclag9WqRAfhz1pQsVcBe3MaBz5x9nwvVpHDkur8z4ej/GZp51u
	xi1AtQfr5WzVkLDOISCp2Jof9gX5871zOA6hgQGygiRsPkllioHKGbA+uKeENTlv79msbBJqNK8
	qwK9BtH4FATe4rf7axCRb0htK+Uaia7EYy37rEboTJc8ZTkM35SD8Ah0C7qD3ovT04ESNFXUhyQ
	SNgKArSgsnFokQ7vzSwr5SdOunjnnnNIAYAXmFhTrKDiJrR3P3gd3YtegwA6fTtACP0JvBvYDb/
	05kwp1W6C5G8+P1bFu3PsAfVFuMdWJFJyGjUxq67UHZj39CnhUSO
X-Received: by 2002:a05:6512:3d28:b0:5a2:bacd:21bb with SMTP id
 2adb3069b0e04-5a33755cb75mr7175419e87.3.1775675148855; Wed, 08 Apr 2026
 12:05:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327165757.28948-1-okorniev@redhat.com>
In-Reply-To: <20260327165757.28948-1-okorniev@redhat.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Wed, 8 Apr 2026 15:05:37 -0400
X-Gm-Features: AQROBzDBOx9MeWQFX-p6aTnG1b9wqkB_YZgDA5hBit5WFj-AxsgQNjHzl3Gb0-o
Message-ID: <CAN-5tyGf54TC771ahzhFfR4gyr7WTEqApWmG+_9qwLYqkRwHmA@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4.2: fix COPY attrs in presence of delegated timestamps
To: Olga Kornievskaia <okorniev@redhat.com>
Cc: trond.myklebust@hammerspace.com, anna@kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[umich.edu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[umich.edu:s=google-2016-06-03];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20778-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,umich.edu:dkim]
X-Rspamd-Queue-Id: 7374D3C2638
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 12:58=E2=80=AFPM Olga Kornievskaia <okorniev@redhat=
.com> wrote:
>
> A similar to generic/407 test can be done with a COPY operation
> instead of CLONE (reflink). And it leads to same problem that ctime
> and mtime saved before doing a "cp" operation are the same as after.
>
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>

This patch isn't needed if the server updates mtime/ctime after doing a COP=
Y.

In the process of all the work, I have also created a patch that adds
a GETATTR to the COPY compound. I'm not sure if it's needed or not but
I can post it.

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

