Return-Path: <linux-nfs+bounces-21651-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJLVHfWgB2rP/QIAu9opvQ
	(envelope-from <linux-nfs+bounces-21651-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 16 May 2026 00:40:53 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D05DF558F95
	for <lists+linux-nfs@lfdr.de>; Sat, 16 May 2026 00:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B03F53041389
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2026 22:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6473F5BFB;
	Fri, 15 May 2026 22:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6SQPUHb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357CF3F5BF5
	for <linux-nfs@vger.kernel.org>; Fri, 15 May 2026 22:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778884677; cv=none; b=frHNgtxrsEIZj14H4N3nzCkCmhgmJWkfVoUmXWGX6q6vwuNokio9N9JVCkOntAha/xQsJ1j0jYsFTrSIDlKRl/VCc+WYURUaijYc3WTRhVvXbdWCj7RVf80S8lJ6y5XXh/1IVvVBKKr6NEpq1gXaaX6gKLGP3pza6pqlzolspQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778884677; c=relaxed/simple;
	bh=J22XAuCby1Nk4FIP13WT2u/GUxKM6wuoH7hrzV1Eqf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O/DPru+R/HdRdO9IxWHdEHvDxbmOLyPwIX+/SD2aGywXkKSD98XwitIndV0IVPBaClr5MlYq2mgTcvH7q8/d+LzyU4dHOYcMSmZrmGWHELZsGA1sYe+HJZXkAHVZn+jpj0TBGFVhUraWc4AmtOLv7rTjp4hoJ+GCuNS04EExY2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6SQPUHb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02AC2C4AF0C
	for <linux-nfs@vger.kernel.org>; Fri, 15 May 2026 22:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778884677;
	bh=J22XAuCby1Nk4FIP13WT2u/GUxKM6wuoH7hrzV1Eqf0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J6SQPUHbeQl+M/9tFaMbK8dZygMG4wF3FeDwXrfnAGoeuZ9v43RFXPi3i6PlUEyiY
	 qBY2PB9tpcgkHiNjKM3nu+tcCujL6QueIqUkX9tN/dTiWw6og/+ClebItMZvq3cMkT
	 vgZnaxUDZ5ZpKpPGSQXREQbo72kuouuzw8BV7etUgGve0Sj0gy7Gf3dVbWhB4ui+SJ
	 8aVZ/MPSUGgiJiIlGr/mzCEQp6NXdNvts0FxgtV7VTfgZICdUvENCJTtEbhFIHPwLu
	 wKsygrKzRHlvxrF3qEqfDaUVvViuaPg4sRY8c8vqUrBVwcjH1EGTh3YzoMz3G9HpWQ
	 RKL1x7I9KsoDw==
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-65e15fb394bso471491d50.2
        for <linux-nfs@vger.kernel.org>; Fri, 15 May 2026 15:37:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+oXr/MFQen0RsdgqqP7A2jmpoQjs6WlmOhDDhCru6XXzIk5az/mmb/6TlK80rjkA+lyeLtGTJ9d8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfLyb2KeVsdCF67sNNARCpuaL/cwDZKfrr3lERWwgfUTDbr+jS
	SomzgfrVsYHkfZk8lEP2QP1INGOkL3hexDaGIdJ9432uyWgqDyOnkSKJcl0huOrAxxo4xcmKfbD
	eZfb5fWdq7C7frfQVb9esXExGzfx5Wvi971O/BjV7jQ==
X-Received: by 2002:a05:690e:1482:b0:651:b13e:f9ef with SMTP id
 956f58d0204a3-65e226d2c42mr6465616d50.14.1778884676176; Fri, 15 May 2026
 15:37:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512053625.2950900-1-hch@lst.de> <20260512053625.2950900-2-hch@lst.de>
In-Reply-To: <20260512053625.2950900-2-hch@lst.de>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 15 May 2026 15:37:44 -0700
X-Gmail-Original-Message-ID: <CACePvbWdxJfCgZzbfFoSOFLKnizDJE62oHKj=mA5jkBGo0dHkw@mail.gmail.com>
X-Gm-Features: AVHnY4KhYBpZIvUDwx68vRewVOsNKOXtAJOmYrhmxnQGCpjvviSHXcfEap0R7tY
Message-ID: <CACePvbWdxJfCgZzbfFoSOFLKnizDJE62oHKj=mA5jkBGo0dHkw@mail.gmail.com>
Subject: Re: [PATCH 01/12] swap: remove the maxpages variable in sys_swapon
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	David Sterba <dsterba@suse.com>, "Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, 
	Chao Yu <chao@kernel.org>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>, 
	Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, Carlos Maiolino <cem@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D05DF558F95
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21651-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,tencent.com,kernel.org,kernel.dk,suse.com,mit.edu,gmail.com,samba.org,manguebit.org,wdc.com,vger.kernel.org,kvack.org,lists.sourceforge.net];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chrisl@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 10:36=E2=80=AFPM Christoph Hellwig <hch@lst.de> wro=
te:
>
> Always use si->max which is updated setup_swap_extents instead of copying
> into and out of maxpages.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Chris Li <chrisl@kernel.org>

> ---
>  mm/swapfile.c | 27 +++++++++++----------------
>  1 file changed, 11 insertions(+), 16 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 9174f1eeffb0..f7ebd97e28a3 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3350,10 +3350,9 @@ static unsigned long read_swap_header(struct swap_=
info_struct *si,
>  }
>
>  static int setup_swap_clusters_info(struct swap_info_struct *si,
> -                                   union swap_header *swap_header,
> -                                   unsigned long maxpages)
> +                                   union swap_header *swap_header)
>  {
> -       unsigned long nr_clusters =3D DIV_ROUND_UP(maxpages, SWAPFILE_CLU=
STER);
> +       unsigned long nr_clusters =3D DIV_ROUND_UP(si->max, SWAPFILE_CLUS=
TER);
>         struct swap_cluster_info *cluster_info;
>         int err =3D -ENOMEM;
>         unsigned long i;
> @@ -3395,7 +3394,7 @@ static int setup_swap_clusters_info(struct swap_inf=
o_struct *si,
>                 if (err)
>                         goto err;
>         }
> -       for (i =3D maxpages; i < round_up(maxpages, SWAPFILE_CLUSTER); i+=
+) {
> +       for (i =3D si->max; i < round_up(si->max, SWAPFILE_CLUSTER); i++)=
 {
>                 err =3D swap_cluster_setup_bad_slot(si, cluster_info, i, =
true);

Nitpick: I couldn't hlep but notice the si->max does not change
between setup bad slots, so in theory you can cache the si->max value
to a local variable for the loop. In real life, it will make no
difference, so feel free to keep it as is.

Chris

