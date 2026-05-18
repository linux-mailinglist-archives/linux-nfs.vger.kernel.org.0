Return-Path: <linux-nfs+bounces-21669-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0F5vNFeCC2oNIwUAu9opvQ
	(envelope-from <linux-nfs+bounces-21669-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 18 May 2026 23:19:19 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F60573C14
	for <lists+linux-nfs@lfdr.de>; Mon, 18 May 2026 23:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 510053036E4E
	for <lists+linux-nfs@lfdr.de>; Mon, 18 May 2026 21:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4499396560;
	Mon, 18 May 2026 21:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rM2hkphX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C81328610;
	Mon, 18 May 2026 21:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779139155; cv=none; b=FNIZqoPZE41rowQtDUB0+J6oFFu+4UU5OkkhdQT8cIyg52Jnu9Tg0H9EX/COCNVs8wLGkw9lUleTwjXrHAbVpwN0KZ6ZbR7dOGpmGqK0XAEVrEsz4aP3fEgQV9G1LWho1LMhX7Exlwb8CHEV1Pr1YGHOyQ8y8stQUYKgqYuCPyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779139155; c=relaxed/simple;
	bh=S0RCHirrlwYoKSMhJ3e2x28WcixJz2wbsX9/C1Qzciw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gl2oqIl7VABy63eqkzIV6q4P995rL/nf3Jq6gsg41c8PopG+EmhBgko/oqUSXrqKN2QWFtKtOHbqsm4iJ3gf2I5tkVp21Ifi3YTFeg2Cv+fpEvtaZjwZnNHDP1t6b6RqriPpvCemTJojo+rJUY3C0Ay6jGY4gwlUnTuUjq9KF1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rM2hkphX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B248BC2BCB7;
	Mon, 18 May 2026 21:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779139155;
	bh=S0RCHirrlwYoKSMhJ3e2x28WcixJz2wbsX9/C1Qzciw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rM2hkphXOkJJ4jMjNAtYqlkTf593QrJz7Aoy61kFfoscn5pM8KTnUTMXJ5aKurKO3
	 BW7fvznt3bxeEsexRs14PulalYLm+T67Ffuf8ASbylp9xb+Ox6MmV8oDI+5OBD4GKf
	 weNKc0f3li/0cXU9GRBWgoo5XwQ+0dZpJHKmQpPnxtbTrf6Imr9lxbQLgH08iW12D/
	 u982dpepR5ki56wNJGeyyAUg98Xpi1zJkezxjRnXm7xrnZYW2uwiXFCS0n+btBbEWw
	 suNc28DTBXgxgZflpFWIy/D+Ml056zB3x1OybsCFzpZKBUZZHUfnRsnzRiUu44hXEC
	 B3Axzuz9L6IYQ==
From: Chuck Lever <cel@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chris Mason <clm@meta.com>
Cc: Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH] nfsd: release layout stid on setlease failure
Date: Mon, 18 May 2026 17:19:09 -0400
Message-ID: <177913913704.616396.8759447922203596578.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518201647.3383242-1-clm@meta.com>
References: <20260518201647.3383242-1-clm@meta.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21669-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.com:email]
X-Rspamd-Queue-Id: 55F60573C14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

On Mon, 18 May 2026 13:16:36 -0700, Chris Mason wrote:
> nfs4_alloc_stid() publishes the new stid into cl->cl_stateids via
> idr_alloc_cyclic() under cl_lock before returning to
> nfsd4_alloc_layout_stateid(). When nfsd4_layout_setlease() then
> fails, the error path frees the layout stateid directly with
> kmem_cache_free() without ever calling idr_remove(), leaving the
> IDR slot pointing at freed slab memory. Any subsequent IDR walker
> (states_show, client teardown) dereferences the dangling pointer.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] nfsd: release layout stid on setlease failure
      commit: 9e93f8c13374d21254f8dcd0010103da346bc1f3

--
Chuck Lever <chuck.lever@oracle.com>

