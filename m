Return-Path: <linux-nfs+bounces-21157-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIlmKq8T72l85wAAu9opvQ
	(envelope-from <linux-nfs+bounces-21157-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 09:43:43 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B770B46E84E
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 09:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B2DA3007B3A
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 07:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797882E5B1B;
	Mon, 27 Apr 2026 07:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/FA44Bb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22D838910E
	for <linux-nfs@vger.kernel.org>; Mon, 27 Apr 2026 07:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777275799; cv=pass; b=moUKgAs3o5LA43VmYkwujCvm/lWQh2nFrebFtGne39tFWWR4HP5/mOKbO4wX/zNod4wCFr1Yn2BfYrkL4dtvkP6XHOzsDzzso3yabFON2Pc3yNlrDiTvGCfhJQv33sx3OI0h+oaNv0pV1tJQ7qfa1RqUMPYfD5vd5KhSLlExDPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777275799; c=relaxed/simple;
	bh=WmMNIGbAGBnWZSMlQH2IaOr5hvZoDWPa/zqdW8jKm/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bUz2IkMogKy9kX7qw4T0pjawlgVSYFp742pM7nF4vT7AS0sBrRTexlBv/WBKgWDLxesf7KTfP64SHzh/8ikVHRstZ584IF4g+IWEVcPyuIlZXnexVVmemcnqwaaHRz6uTMYEc7VhC2xnwS3v7Ytytwn13R/TMeGs7rohn5NfHqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/FA44Bb; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-670ab084a39so14877022a12.3
        for <linux-nfs@vger.kernel.org>; Mon, 27 Apr 2026 00:43:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777275796; cv=none;
        d=google.com; s=arc-20240605;
        b=U6goG6cRLWvPAzJltW4NHe0GxIMjE2YW0sWmR8rwlbz8nk2wSqfV2q3FAwyZoSY2e2
         F4eW8+l4ZCKX99OgEvU6RAglm5xxuTHbkPy+GKmtUgY42xS0Wis+UP0GDDhxkZDlxHNH
         +7SafKZwlohJBCFeRylE9BTeL4D/rx+UqXK7Nn+DJd+I8ZsvwynpesIRrht+T9cEKE0J
         ZPcnZYDI9UNtcuxge+x6X33trP4o+NxefQ/M38jBvyqRL2MHeyk6JjLICZ2xtyoabK/d
         zKVN2XAZtdnsQ0QFDVbexhr0A2Un6MpSli1vSMwAloyRup8F0Rzloez5ry8WxMJMPRGD
         dieA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WmMNIGbAGBnWZSMlQH2IaOr5hvZoDWPa/zqdW8jKm/U=;
        fh=pxMgJDrWbRRFXuGd2dQgQQhpUw3d/Ur0ltQK2jFgUpw=;
        b=NWvyBIHwvOAPr8k2FzU2Uq+ovCXBwwNJt9Bgpk4VpDgvumwm/mEwWN8RlWgKUedgnu
         uHG1Cu2O2BZhc2aLb8Jb5QF1HjP6G6lQCd7qIDjiknEUel2r2PrHQuEDHaS1HZG7xG5I
         s99q7RdW+9ciWO5Bo7BfvLlSdpBu4zofSsD4j1O03ez9lvwqulgeKe1Is/9Y1mrNlk0n
         K5Jcfx2OZUsTdxNYpfXyfKjzWHdS6CesCBIRJ3/ICC51AYI34OCwjMcyqg+wxWVZ15+F
         hmextm9qC8zBM6RfLqjdtFSbZiNSdlikTC9RUIYB0EtYJDCP7TyxSawvjB+03B/zfVdF
         vN0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777275796; x=1777880596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmMNIGbAGBnWZSMlQH2IaOr5hvZoDWPa/zqdW8jKm/U=;
        b=a/FA44BbzZXxxbedD8kE5+H1vrImlqqwN3YbeQOMdARXbVawR2vWZ5mOHYsA0YlO6v
         +mNHBShRUXyetKieaB97logJ3fHpKQfperZrl3A1YBRmfKG7kWwRx+OyWr2e4qHevHdI
         FkSbpfYlqPq1NF1ZGronloT46QL3AE0W1eJi35NbAOuLa93pZfVe2V8dNf/QqjdRZws0
         ccmYmpcAf4FGllvW8jDeuJuKAoC7AeJJj4aKFMgI4ZGbnMNhE3AXwvuBO7STe9DrOEVz
         0kGo3j33hKJgLfhPoGH91kHzGdQkBkILo/RhOF74RxQojeHWwmocHhlB52HiIugGKkx1
         ZoeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777275796; x=1777880596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WmMNIGbAGBnWZSMlQH2IaOr5hvZoDWPa/zqdW8jKm/U=;
        b=YhTgUaHwFAZ5fAZEoDy9u096s3RZeujXT5q/DPox2ISarv+3vkhUnJ8gzM3fSYw5DE
         ADv9oWRnJ1r9nfZNjF9vnEJyTA3AWuUovcnhp4pmcVHPl9tGxb1WcfF6QP4AKfMEPboD
         /5iNkO+OMruf4S1KLxsqhR7fbzhfHmk0BWUSU5lp3CYeCs1pqpQ+YsQOazdDbiv10s3u
         CY3/O7JeP1KpEOQd0B9hXg7kSG8j2gNoZJn+MiE+LQ7cydrnomp58BS9jFOoG2qUvoDm
         XUjtqTPl5R3VxH7olaUdm9f5WSSkR0uJQYunde+IMWfS+Fm7vq8HXRwTxI+Ii3YbqSlZ
         qQRg==
X-Forwarded-Encrypted: i=1; AFNElJ8JE5+K7YDZw+XRC0+1ZGoutf9cXK3XtdKXPQgojFodOfIXHzU53feAOOHiPKPZDLGivLPTLNl+8r0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKV6A9YvFeUsyZdfpkyUpCqeNpI0ikR6o12eSv48DgR12sffmY
	BYXI+6pvzk9BtKJpcdYPLisvZIjcMdKSlX1sxOjP/QfWrXaA9n92WI8YBEJ29fBcoTG7sTcwEN4
	XEhQnxk/1Lp5a5RZxMGce0pKIbzscz9M=
X-Gm-Gg: AeBDievq6s55h1jwy7yn68CJO5/AqnW3/AbEM1innKnvYpNdiL7PKJAEl0EMQOkfzu3
	NnAtfao0/xO/5na/EhJwHZ6dQLOob/B7+tXLBswAonOeUM4tZTgyXpfc3M8sa3Xa5kA42arSV1U
	vt1cEjFDTqEE25lCPFnDbit9JnTv+pfomB+7cCy2/4F7MAAxygg27jHM0ZkCQEq/4pHNseA2PUw
	I3BI1EfIOtpf6igPBHyeAzdKXfSC3A6VCn5TH/X9xACz9d6voptr9YEzEYvBLiSemv2N9BECdk8
	r1TqXwFEFv8q9irBO7XALoNSGghRTOFqun94q5PO+f+A40HyQvTr
X-Received: by 2002:a17:907:c30f:b0:b9c:bc70:e928 with SMTP id
 a640c23a62f3a-ba41a91d717mr2121879166b.25.1777275795629; Mon, 27 Apr 2026
 00:43:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427040517.828226-1-neilb@ownmail.net> <20260427040517.828226-8-neilb@ownmail.net>
In-Reply-To: <20260427040517.828226-8-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 27 Apr 2026 09:43:04 +0200
X-Gm-Features: AVHnY4Li24Tmq3-41JYR95SCf6Z2AFdg2a4cjT7d8-aaRtTKWrSVG2trUoxa1eg
Message-ID: <CAOQ4uxi8rqkbhK4=8N1ncfU1m6bjdHLbinSf=j3k0oVEaSa-wA@mail.gmail.com>
Subject: Re: [PATCH v3 07/19] VFS: Add LOOKUP_SHARED flag.
To: NeilBrown <neil@brown.name>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B770B46E84E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21157-lists,linux-nfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Mon, Apr 27, 2026 at 6:06=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> From: NeilBrown <neil@brown.name>
>
> Some ->lookup handlers will need to drop and retake the parent lock, so
> they can safely use d_alloc_parallel().
>
> ->lookup can be called with the parent lock either exclusive or shared.
>
> A new flag, LOOKUP_SHARED, tells ->lookup how the parent is locked.
>
> This is rather ugly, but will be gone soon after we move
> d_alloc_parallel() out of the directory lock as ->lookup() will *always*
> called with a shared lock on the parent.

Neil,

Forgive me for being skeptical about the *always* part.

How long ago did we add ->iterate_shared()?

It's true that Linus eventually got rid of ->iterate(), but we did not
get rid of the assumption that iterate_shared() might be upgraded
to exclusive lock.

The obvious reason is that *someone* needs to do this work for
old filesystems, which are also hard to test and nobody wants to
touch them.

I have nothing against this patch, but I think it is more realistic
to state that LOOKUP_SHARED is here to stay, so if you think it
is too ugly, maybe there is something to be done about it.
Personally, I do not see the ugliness though.

Am I misjudging the situation of shared lookup wrt old filesystems?

Thanks,
Amir.

