Return-Path: <linux-nfs+bounces-21647-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEI3NQScB2oD+wIAu9opvQ
	(envelope-from <linux-nfs+bounces-21647-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 16 May 2026 00:19:48 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87196558BCE
	for <lists+linux-nfs@lfdr.de>; Sat, 16 May 2026 00:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CF17301326A
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2026 22:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F2C3E16B2;
	Fri, 15 May 2026 22:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTicYoCI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427363812C2
	for <linux-nfs@vger.kernel.org>; Fri, 15 May 2026 22:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778883534; cv=none; b=cDFuN8vV0aEWfjasHbzCFYHAQ+ZGdD5VrFaAV1bUQb375Uugs8THARTvSXeOT+mqu9/28hVGTHdyJavrO97lA39ItypaAEZ+fs9UhW+GeYLVhllKnYqyLL2YjzxVmOqIE9pMwk+XBlsHIEcg6sVc8NLG5WJi2pmWNMXgYuBBFQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778883534; c=relaxed/simple;
	bh=1MhrEcqiffOJJ9gu4tKqW5/j2FFYBdwL8v/OjHOXbE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HARB9K3dRZb2gfRe8d5FUfiagGdyWTBkatxJ5N+/f2+1Imq0u1uwkFaqktCJN6HnJtsebMhF7VrD6LUA7s08WRBKxpF5TPlfXvbUGE2Ph/LJ31Zm9V36uexLBoXG3N7ztxcdAO4FYr7eTCzv0UF8EedXB6oOSwEaKKJFM7t0iT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTicYoCI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025C0C2BCB7
	for <linux-nfs@vger.kernel.org>; Fri, 15 May 2026 22:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778883534;
	bh=1MhrEcqiffOJJ9gu4tKqW5/j2FFYBdwL8v/OjHOXbE8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GTicYoCI2yr2rAe/AMU6ocS3i7LeGzP+5ynLWd/haZ7OK8z5QsL08GhRu4vI6vNmU
	 /3SJUN65uYsO6Z6W57GiFhyamzuFs+17wJ2EPj9kxjsYdcXZy+4OY7C4TydzVuwIdP
	 cqcIdDzhU29K9Oe1AlyD+O5jJc4jbWA6EeBEkcwAcnD95DXjA85X87gsLYpVZ0Vl+v
	 s9ouykehmJF23xqYyIAgLfZ+jgPUx5hix68bt162AGCCbP31GBjIV+8LsNDU1NS6dl
	 g1UnI8kJdJjySSQvW8vM9rhm8ucv7sproY87J44pKcG2J+gIOgiTGJhOMkBLiDtpqr
	 b/+lLlGeQOBKw==
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-651bc83e74aso693073d50.2
        for <linux-nfs@vger.kernel.org>; Fri, 15 May 2026 15:18:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+yJd8v1Idc2tpEuzoaMvg6m+L86hXssqYNqoxBPFgzidazHuLoaIqz1yOw1wKb5jl7awL9Y27bvuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuviIBFZs9kT+5MQf7QDpyFD7TPjUHr5dkrgtutWr26acyQseJ
	p15EAH1BTVXha3c4aXumicIA26tb9M5lEaLOYjzXFQq7xdkGbWknUJPAyofdAr7IQHnXiL8XA0O
	PejPyrvLlB/k3gflOcxrZiVeHY/PJeHRo1+pJBA7zyA==
X-Received: by 2002:a05:690e:2513:20b0:651:cd15:8c67 with SMTP id
 956f58d0204a3-65e226e2fb9mr5283044d50.15.1778883533149; Fri, 15 May 2026
 15:18:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512053625.2950900-1-hch@lst.de> <20260512053625.2950900-6-hch@lst.de>
In-Reply-To: <20260512053625.2950900-6-hch@lst.de>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 15 May 2026 15:18:42 -0700
X-Gmail-Original-Message-ID: <CACePvbUpuNF9VsFUnmGpSwA9mHERG9fAxqezO=gdLzU99gpEdw@mail.gmail.com>
X-Gm-Features: AVHnY4IEAMD4CIhbQwbpq5_x4qZkKrPnDwnZZ2hkgP66BNy2UiBnbzLNgfCVsSA
Message-ID: <CACePvbUpuNF9VsFUnmGpSwA9mHERG9fAxqezO=gdLzU99gpEdw@mail.gmail.com>
Subject: Re: [PATCH 05/12] swap: cleanup setup_swap_extents
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
X-Rspamd-Queue-Id: 87196558BCE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21647-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 10:37=E2=80=AFPM Christoph Hellwig <hch@lst.de> wro=
te:
>
> Reflow setup_swap_extents so that the flag checking is not conditional on
> a swap_activate method.  This is currently a no-op because the swapoff
> code still checks the presence of a swap_deactivate method, but it
> simplifies adding a new check, and also makes the SWP_ACTIVATED flag
> more consistent.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Chris Li <chrisl@kernel.org>

Chris

