Return-Path: <linux-nfs+bounces-22120-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePiQJm9jG2o2BwkAu9opvQ
	(envelope-from <linux-nfs+bounces-22120-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 31 May 2026 00:23:43 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 189BE613A4E
	for <lists+linux-nfs@lfdr.de>; Sun, 31 May 2026 00:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05BD23006519
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 22:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C7137BE71;
	Sat, 30 May 2026 22:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oBGLyviT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB106379C33
	for <linux-nfs@vger.kernel.org>; Sat, 30 May 2026 22:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780179609; cv=none; b=L7I2DvHgPf4nr6maE7jvtXqWoXaP0TOtZLPfriTn1fDTTg1QwN6ti9TW/cptcjCUdH8E4uiyDkmUa3wpoQhkys3MyF5yZzdNjTzz/FSu1dvQQHc6QH+5JALx/SqxO7KyTO7c1rdZQsmL/Is2140lFhH63o6Ay406B/3Cvk82HME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780179609; c=relaxed/simple;
	bh=4TSPlN5o+JecYW1sd+ZzXQj8yAEreCv2H17czKFowr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rPnnM1JvR9Vj/O3SsHp4yjr7sJuRZb6yWfn9kj7b5YPesSo+AxZuqdohKzFnGDZCzPBxKMIt3yspj0slHJixXD3/w61LzAyiSyysl/sphXnWMgPHIb5KVtQwfeB0D4t823lYCQaOoJi5qC2Eg2xPhAmWDwS2fM+YfIWkaq16F/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oBGLyviT; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49050bfe053so56259075e9.3
        for <linux-nfs@vger.kernel.org>; Sat, 30 May 2026 15:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780179606; x=1780784406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Lsn3u4lBncf/2naAXkema/EpB2mW522r7UH8V++Vow=;
        b=oBGLyviTDtrrcoAMvYKo6bwpCL97ZKQHEdWZvjOGGdId1LaaVAfsH4TyeKwtXwcw/K
         uizDoK+wFtZ0hr5Xp6T3NX5MIUMeGm0lqRLqDPtsx43Fxwvf6k1oUEEDJd9QcXttc5sF
         c6PNbsC14QDGPfPfakPodXDsrGz334sxquMX+9C0tij+D3cQX6UO8pb6oTuBZtSAAGnU
         FprxaXyhjyGR+I0oy1VoiHqOE7dlRKkKjudj9pQ8cme+1lIDqFpc3+IW4Dij2uUCge21
         wgjnS6GKkxUMhj2owln54WUxHkPMYAdfKjxzQAdbXkGIMJwvU2buv9wq9TKhI038penz
         7N9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780179606; x=1780784406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Lsn3u4lBncf/2naAXkema/EpB2mW522r7UH8V++Vow=;
        b=bUeRSYP4drqO7230oo4AdQO/fPJUZ+E9+eCYIuZbfFGvcZudfyq90FdbsNLOW+t0ZF
         h4j1jCYLSh6mDin+kuYWBBllQ3kb1LkXNwAUck3Xg7Mr0VWaSG2mt4U0jFamaZBMSL92
         Mvyw50wFNsiIKOZC5K4ykLkgP1rGPfeQUQGgKK5S2tZyM9JvLtmHq6cxp7qKc+zVrHE9
         Gtpsieiy6dsOmWRqGyXBdOS0SjVVL6YDxwsKY2odepqinm77hP0oLo21d1wk3sR8wDKL
         RWyKp2JtFaylPQBCXdng+kIXBuuau8I0IU0avEgHtQlXUzOKVO4b6AgHKyPFAf7mJpaX
         LH1Q==
X-Forwarded-Encrypted: i=1; AFNElJ+FXnGKTPZTwgVf6Sn6UMbFY45ZLliyxDLX0eC4+oVfO6PrFSBMrWA+NVuehaLuEWm9twTkRPTr9Mc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp/ANaxu5/bXBc6Q5bqE/E1jwRbg1YOJQuNzDKhuKrru1RD3Oi
	Dhpi9NX2J/6IqP+URDCUA/FuXrk8wHWI5Y9HckyVS1kPF83c1ETQGPn9
X-Gm-Gg: Acq92OHVSgv2bpHG+1kQstbRRUyhtzWEA2D1xk5dUJX5RKmWlLiw4bydYzFlaKkhRMj
	tvtE0eD5G9cHbkwfTyXIlstXn+ZMcHF65fR7g2aRT5oIzB3DCEjRvaDkqLk2YshAyAwe3/oDIQ8
	UVvGFpJLmaICmu4RJ+/T368A7MD6qf6eOMtQ0sRcksC/qFchyhzb/EUtQz/rHJezouij31I4KHV
	xzEerwkknoH3+V3ILFl+HpMqHrjwUCT1WrCr4/m/vBSzsPCnBRsBdmDl6b/kK8Cy0332eaivhNc
	+Y+YgM6PLNYxPeUDNUEnrTUTQ5Zq3MzVcvbFSJz8c6qwgkoIzfw8ZvZuhpyi4SGcg53R26RNWKs
	uN0rAelCbMIm7mNdtu6LseUODRgwgaSI2a6TuHDG3qGzOh1xNMY4JdWm8ZGNfMbAOZHYKPJsMvZ
	gDUYLph2dV5DQeaiMzAigyKHTtl/GjXn+Vc3FlaDsJPmoJ/YhW6zGv
X-Received: by 2002:a05:600c:190b:b0:48f:f64c:c2fe with SMTP id 5b1f17b1804b1-490a298f29amr87406325e9.22.1780179606187;
        Sat, 30 May 2026 15:20:06 -0700 (PDT)
Received: from puck (234.243.199.146.dyn.plus.net. [146.199.243.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354cd7csm13443784f8f.18.2026.05.30.15.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 15:20:05 -0700 (PDT)
From: Dylan Yudaken <dyudaken@gmail.com>
To: trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Cc: axboe@kernel.dk,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dylan Yudaken <dyudaken@gmail.com>
Subject: [PATCH 0/2] nfs: support FMODE_NOWAIT on O_DIRECT reads
Date: Sat, 30 May 2026 23:19:45 +0100
Message-ID: <20260530221947.49518-1-dyudaken@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.dk,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-22120-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dyudaken@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 189BE613A4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I had noticed that io_uring always punts O_DIRECT NFS reads to a background thread
since the file does not advertise FMODE_NOWAIT.

I am not very familiar with the NFS codebase, but looking around suggests a simple change
to nfs_start_io_direct is all that is required to properly support this functionality.
On the request issue side, it seems everything in NFS is actually run in the background
(post this lock change), and the completion codepaths all look to have no similar locking
semantics.

I unfortunately do not have the means to test the performance improvement, since even
without this change my local network is the bottleneck here.
However I do suspect that there are people that would want this fix ([1]).
Applying a similar patch on that GitHub issue did give performance gains.

To convince myself this works at all I did trace io_uring events through with and
without the patch.
Using a test app ([2]) to issue O_DIRECT io_uring reads calls io_uring_queue_async_work
without this patch, while with it the call is skipped and the completion is queued into
io_uring directly from nfs_direct_read_completion.

Patch 1 here adds an unused nfs_start_io_direct_nowait which patch 2 uses in order to safely
advertise FMODE_NOWAIT.

[1]: https://github.com/axboe/liburing/issues/1499
[2]: https://github.com/DylanZA/liburing/commit/264c06f1939dfd6b6bc4c967ada5960c4f4f2db3

Dylan Yudaken (2):
  nfs: add nowait version of nfs_start_io_direct
  nfs: expose FMODE_NOWAIT for O_DIRECT read files

 fs/nfs/direct.c   |  5 ++++-
 fs/nfs/file.c     | 13 ++++++++++++-
 fs/nfs/internal.h |  1 +
 fs/nfs/io.c       | 38 ++++++++++++++++++++++++++++++++++++--
 4 files changed, 53 insertions(+), 4 deletions(-)


base-commit: 670b77dfebe7257adc0defbc48a4c43cfdf6c8f6
-- 
2.50.1


