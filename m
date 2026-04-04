Return-Path: <linux-nfs+bounces-20651-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAgZOp8f0WmmFgcAu9opvQ
	(envelope-from <linux-nfs+bounces-20651-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Apr 2026 16:26:39 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6047F39B5D6
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Apr 2026 16:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 220AE300B879
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Apr 2026 14:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D7A22B5AC;
	Sat,  4 Apr 2026 14:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R41qWYFb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB39761FFE
	for <linux-nfs@vger.kernel.org>; Sat,  4 Apr 2026 14:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775312797; cv=pass; b=tAlphlUQ8jh9usFwQjXAOZ+e4d0llxuwrLC89dZdRVxYPuN3llWNpRJhq1A+ZgkfjZzO7YvqA4J9VKy6n50oiTZab3aUIpQJNEmrmrU/1W7J+sxqshjzKtG7i54xsEBhmUGXC1sdinD4XoVpI9jZcYMD+v6tUds4R0S1oT0eOtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775312797; c=relaxed/simple;
	bh=ZQo04c2zcZrxSM/+/5TMsDiO4QN+lkGuEt+zbFcjXbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mKCrQaQ4MwJtYISjEjhfMYw2Bsm8hIUktLQJEIAlKNKzM5IxAl+YD42BbvNIdbvE219Z1HKHTN3BhN8jmzazNp9KZ+hor406ON5Vth2qwd/+Ut2EZGgFRDwObP3OQvbfddn7lVS4Q7HD4Zm7bc5VzTXHI2+Y9JCC18+c4MO+hVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R41qWYFb; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b982518b73fso434840866b.1
        for <linux-nfs@vger.kernel.org>; Sat, 04 Apr 2026 07:26:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775312794; cv=none;
        d=google.com; s=arc-20240605;
        b=jd0ASbxTAXyyhTnpRPFlsw2ZBp5Qn6Mmk/3IlYx6F/pYhJhHdKKAq0x94rW0scvkP8
         jwpwbxxfaccSIV9EX1UfGoqpwZ1wqCgahA2n9sOrsNLoJZGnvcrj0bi9JgqNVoR1ETkU
         GpTAUgeqxDxf1Oui9l5ZcT58VNnWr3NEJ41tMGVTLJpRXqmO6CoQVLdvFKD2AJIsLG7m
         Bptm794QJfxNTvXHdy5jch6RNP/Frq2HnD2FysnJPXFbyXPXzl5S1Uw1WNiqhpGdN7qm
         SO38k0MDk42lFzWhfaQiKomNOXMVUyEjSOgaPX552KlpXZQiIf1IpbD6xtV+ZBcMn4VD
         Y0Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i0np0/Lcf/Gp+4mdr7ALJIhXpHV6yoiGvAcLSFXVVLY=;
        fh=oNhd47IvoHzM7k8qVcL4GpDkC6cf430h9w4O2kbXiqs=;
        b=Ex8/wd5u8wfJ9v5/wG9g6SgkAl44pophVAnMhK/67UMeKGxROeGVFf/kCvZvgv+VqB
         GiB2LlR+K0LEV42HYloyGYsTT+CXS1gk+BYXZk5wEkGICRyoddR9rIxfW15DFH2d53M4
         h9FaAp3k4ghgK3Z9pMALu4YLGfgv4s1pUjnQyOJknNXRr8+N/MEZFym8js2LCazf9h3u
         lBj2MtrBHUgSTcsFRzcJX2wtDOpCcY8hltBMoDsYS7mpIuU9VScfr883l1Gm+3Sx8MJo
         DrETEUbOuKnSf1iwUxomdK9jMRtK4cm1JYsMbPzTZrQn7fPncA1JcqPEoOp3TRzOshIO
         xh3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775312794; x=1775917594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0np0/Lcf/Gp+4mdr7ALJIhXpHV6yoiGvAcLSFXVVLY=;
        b=R41qWYFb3wrSZ+Tnr5WF8zMsMpl3vdQqWeT6dFX6tXFUw7yAwsjwQ+yhsZUojdU/wv
         X1GnBx0TgV+Wrbt5YiH9MidVYR88OXQYE7x06U7kYCcYvK4g/U3/5VCINlBlQblpGNQU
         zIgnVI9+l5TXNfPuerXZbO219+riymJ6PmZ8m3+m3ca2OnR9WCJSXCpJ8DYvDgUXANWO
         wjCdywcemJsRiuMkqqv8wQSbzS8VhuqovfEf+bShrPyQ9PYzcZMnKAOJbresfDVoeIws
         qxpwHSC2rY9eH9x7Hnk/1zk/4usafFkB7yYUgM4cDQBGR6xERXmxL0olX2RjThJBcXRi
         0C6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775312794; x=1775917594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i0np0/Lcf/Gp+4mdr7ALJIhXpHV6yoiGvAcLSFXVVLY=;
        b=YI+PA1cum8kwkBL55w39dXHy60QQGVztHjvCyLOLy6KZkH/xirAF+OzdvkzJCebHx0
         1tlJmHAWnlOY1UheQ5HSDBdvxQOeZgYkE0meqetj/MrzOc1JI3L7E3OaV+l7x3fQNoFk
         AnzeI1p8jN+AUSJ8m3aaJgaCyHXHZnawWi6330Okkb42piM5RZlQUJrIVJSq5KZWwxb5
         /9f3WEgqogwaFjesHwjoSngZqbqydXamktQN6dUbGf88cdjcRRPwavb4LyPq3ZU5Quo7
         4UhusJui9rW3Dp82Jt5BH7CnMIa7eq0E1FVLLiHdFnk3/dJs/qyGAy+DjY9fMmvSLnrh
         +3zw==
X-Gm-Message-State: AOJu0Ywk7AZiURgYOvPcpn5JcqPHb5XKEvkHYKVNHNL9HZRkkhZo7ZKe
	Htdtlep/s9X3gIUjjSrFAO3ArYHbMIBq9vW5YQW5rOtyNGd7qU/mpIzrK/JW+OtVMo++zZ4Y1E5
	z6z/P2g8Wk33BnjBlk/ij8n3AesTV7CE=
X-Gm-Gg: AeBDietvVgXoEmNz/Xup2dhlok43lQZ2AGjEKrk0PkwOKLWP+Czjn2X2JDxWkQTwHAx
	pxxBGZy7Y5tQL+PSjwEJvwDlP1l878f+zVQk80a+KesvzcVLqXUzPPWwxY1fLGWS63O4FKpqh3S
	FPe1r+ezP/BGIQukWxwWHJLgjYur8lx6I/5xtVTxT8MEmPZfh7HMFQK1dM5lgTEQlqd6RlPtXVd
	Zx/kK/wth7NZxeDB8b4hxBemDn5QWvhpVimYbanxABi19cKjPJuGHe18eGEhn0VlQ36QlJh/e2b
	GxJy72yBzLBEYT6Jfo/tvYxwXIhKMVIoo5iOJ9zs+Iey7CJb+zsW
X-Received: by 2002:a17:907:3f90:b0:b96:d904:9616 with SMTP id
 a640c23a62f3a-b9c679f0458mr264217566b.40.1775312793828; Sat, 04 Apr 2026
 07:26:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260404020027.3327248-1-tushar.sariya77@gmail.com>
In-Reply-To: <20260404020027.3327248-1-tushar.sariya77@gmail.com>
From: Tushar Sariya <tushar.sariya77@gmail.com>
Date: Sat, 4 Apr 2026 11:56:22 -0230
X-Gm-Features: AQROBzAV3jGn096l9BlSxLCsHVNaGssgkC5lqCcod7jLWT2LnNgGFYxCTmZ5liE
Message-ID: <CAG-aSJ-pYZTCuCSQ_LpcvPLb5+gLZHj-z-MaoPLrNfNR+GP5xQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] NFSv4.1: Apply session size limits on clone path
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20651-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tusharsariya77@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 6047F39B5D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Superseded. Reposting as a reply to the original regression report:

https://lore.kernel.org/all/177349021750.3039212.10211295677877269201@eldam=
ar.lan/

On Fri, Apr 3, 2026 at 11:30=E2=80=AFPM Tushar Sariya <tushar.sariya77@gmai=
l.com> wrote:
>
> From: Tushar Sariya <tushar.97@hotmail.com>
>
> The NFS automount clone path (nfs4_clone_server) is missing the
> session-size clamping that top-level mounts get in
> nfs4_server_common_setup(). This was exposed by 2b092175f5e3 which
> changed submounts to no longer unconditionally inherit the parent's
> already-clamped rsize/wsize. On servers that enforce tight
> max_request_size budgets (reported on Dell EMC Isilon/OneFS), the
> child mount ends up with raw unclamped values that exceed the session
> channel limits, resulting in NFS4ERR_REQ_TOO_BIG and user-visible EIO.
>
> Note: I was unable to reproduce the exact failure locally as it appears
> to require a server that enforces tight max_request_size budgets. The
> fix is based on code analysis =E2=80=94 the clone path is missing the sam=
e
> session-limit clamping that top-level mounts apply in
> nfs4_server_common_setup(). Tested that the kernel builds and boots
> successfully.
>
> Tushar Sariya (1):
>   NFSv4.1: Apply session size limits on clone path
>
>  fs/nfs/internal.h   | 2 ++
>  fs/nfs/nfs4client.c | 4 ++--
>  fs/nfs/nfs4proc.c   | 3 +++
>  3 files changed, 7 insertions(+), 2 deletions(-)
>
> --
> 2.43.0
>

