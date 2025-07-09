Return-Path: <linux-nfs+bounces-12960-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 922D1AFF415
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Jul 2025 23:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 237A91C863AA
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Jul 2025 21:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2336824169E;
	Wed,  9 Jul 2025 21:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="M+Vjkmar"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB5223F40A
	for <linux-nfs@vger.kernel.org>; Wed,  9 Jul 2025 21:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752097457; cv=none; b=dHZoDg20anZuhhikPb64lfs3B9XXmIZx3CHB4uJXrc8T7quPgtSoAM3iXAGX1d8UvpUxJIYDMKLyGtesBqk7K+Ln5V9jMUdIcHdgwyMkXG/HitWqbnlObdnX4tJRiZU+SH9BTZ4DGPySvWd6J07+P+86pAqlkRhWNxl1bidn54c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752097457; c=relaxed/simple;
	bh=QM3ZwKzZ3tmooQKRsyzdW8dMI+e0bgrGReSxQbsBbz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nhxf74pud0eo8E+W1LTwvAqhKAf+NVi3iKyR9aUidPGr5o2V6nnbRqS9DVvWLxoGhBYTY/zA21OUSfoLHlfT2rpSUymHJCQgF7O3zTht5bjD98gS3MsQwVsh/k9PmXlaBUXEClD4QeTUnm2l+FopTYgg1ytRrZTXK/tjG3sHSPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=M+Vjkmar; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae223591067so44563266b.3
        for <linux-nfs@vger.kernel.org>; Wed, 09 Jul 2025 14:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1752097453; x=1752702253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2oOfilMeJ3fSH+1jR5dPS+6bpms3vDBaMx9PS7L2n8=;
        b=M+Vjkmar2DZR01VBbGidpjLsj5WkhccV4HkYK/+hg7utLrEMINgnjypBRimA/63N9Z
         yYsj7DHfmQMKO1QAv71VK0sNBQkM9peUJhNd+uT1+KdZik4D91/04Eja8bsYuFfp0NYO
         FQ3oMpJJIDemPPNuxCCNSfbuS55si7hddv+RnXQA0b+5DhFQB8Z7rNyJQXBnKOOuK4Rl
         95Iib0HNh/m9cbmeeGI8t7IUpxYr+cfY+DNwK7eo7gUezPshoSEvsBIeAy7Pg6vTmmhV
         h3t0qqhwOB/bMwwUqNpEiS29wNroRRQR/3a4uP4NUgAMh9KoBsErPHFfXlzrhjWBnwHO
         DNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752097453; x=1752702253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2oOfilMeJ3fSH+1jR5dPS+6bpms3vDBaMx9PS7L2n8=;
        b=n5nkyaewofxbQeTskK669AG2y3u7RCJ8DxFllSuhhVx8izXdW18DQDpUM6JTfbpyev
         jkwnFIzlqZlEf18cWGQ2kT0pq9eWHdduiK959zqulBxFeNKG9y38/Z7pqntjTGjRiqk9
         Ne10vSC6mga653l9xTIFf49jIF0oi13kdhkLX29eIWlPl3J02Dhz2+MzWs5CcpmpNzi3
         HmQyvHRoPYBravvYqbfJvSYbSexTcIz6VrvSVTZxj+tXGLxLEzwfaeX/epcWKLDFrign
         5pC80H6tJVrBB6lygGpztkhIUV3T+XBb7+LC/tkFbxb6OfGPaYSas+t/ws09ZA9KblzP
         118Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdikVBgzJ4fww4KhMaEuWCgO0pMCWM3aYS9ev6uIDMGWZuM2rDH7nP8DeHAk7s/MGSTlk5m9CrIOg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/JkUF3jO03CIfoY8LvqamtfMF+pBmZ7rfAWCBRxKPn/EDy3gN
	lOc8VzH8fNTV1QYzwGjvWUeFUQBzrHpnG+MJ6DPrKXwStjeOuZyouFM3lAwJjsD34XxmYz82u4l
	FOJSWpHIL2CnC3D+Qk8rbE3GNf47iU4xTlGydt/Ys6A==
X-Gm-Gg: ASbGnctku/CAvaoxNUgSOKzMERhRAdPYAWUCPqL3442ddAd9DCg4ETnUf0N/Zgv+yRb
	g20bg4U4G6CKJ4C6IMNLW4T6jGHB59kdWnxBPW6Zlpkj9XV8/P7/hKDAShxWifwTnkP2Uh3X0UB
	xAglX0IkwKVoWfrsNNohRXgb8MUFDAECNBvvIVGKpZYYsQ0MmSLN+yZYwW7XLWkC0Z0HTL0QA=
X-Google-Smtp-Source: AGHT+IHRfBgI+JpvIFW5bdEhu8EMbBsinsmaICn0S2xVCrLK7zPglEC6AbVpvLywHBFg/8fSMjerPI4gbWHSZhnMN/4=
X-Received: by 2002:a17:906:46d9:b0:ae3:d1fe:f953 with SMTP id
 a640c23a62f3a-ae6e7099e16mr25848366b.43.1752097453229; Wed, 09 Jul 2025
 14:44:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701163852.2171681-1-dhowells@redhat.com> <CAKPOu+8z_ijTLHdiCYGU_Uk7yYD=shxyGLwfe-L7AV3DhebS3w@mail.gmail.com>
 <2724318.1752066097@warthog.procyon.org.uk> <CAKPOu+_ZXJqftqFj6fZ=hErPMOuEEtjhnQ3pxMr9OAtu+sw=KQ@mail.gmail.com>
 <2738562.1752092552@warthog.procyon.org.uk>
In-Reply-To: <2738562.1752092552@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 9 Jul 2025 23:44:02 +0200
X-Gm-Features: Ac12FXwGyOaYIBhD6kJLi5Rdp0KMSI4jWTqWW8bY_UVcRj5P-WQCdanG6BjA4Q0
Message-ID: <CAKPOu+-qYtC0iFWv856JZinO-0E=SEoQ6pOLvc0bZfsbSakR8w@mail.gmail.com>
Subject: Re: [PATCH 00/13] netfs, cifs: Fixes to retry-related code
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.com>, netfs@lists.linux.dev, linux-afs@lists.infradead.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 10:22=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
> > (The above was 6.15.5 plus all patches in this PR.)
>
> Can you check that, please?  If you have patch 12 applied, then the flags
> should be renumbered and there shouldn't be a NETFS_RREQ_ flag with 13, b=
ut
> f=3D80002020 would seem to have 0x2000 (ie. bit 13) set in it.

Oh, I was slightly wrong, I merged only 12 patches, omitting the
renumbering patch because it had conflicts with my branch, and it was
only a cosmetic change, not relevant for the bug. Sorry for the
confusion!

