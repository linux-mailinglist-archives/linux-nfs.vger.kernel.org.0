Return-Path: <linux-nfs+bounces-19184-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMGEO9HinWnpSQQAu9opvQ
	(envelope-from <linux-nfs+bounces-19184-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 18:41:37 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA7E18AA6B
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 18:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6B681302F21B
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 17:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA4D3806A6;
	Tue, 24 Feb 2026 17:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="To2WyFML"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D283E555;
	Tue, 24 Feb 2026 17:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771954891; cv=none; b=B/JGki5rxYb09T58M1s4MrQ6U+HW7VjE7H9VS45PXqNroOQvIqXvOfa2V8aXwb3igPXaBf0y8ntDcEz+h//6MXE5t6eOIqBjHDQLupKMfqrF19TJW8toKp+jy0xWHT7oTIPD3LlRVsaaXyTZUYVRb6UaaXDgCYuA2xJR6Wh5gdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771954891; c=relaxed/simple;
	bh=gf7Ms95s1RgvWw9e47Pjz2QHDnBpYQUDuMoWY1tTWqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NpyLju7iCfpL9Tcw5ys7Vek6olg5r2pd9+/9lKy4ehd2Dtk6fzEuYBFQk2G0kKxV9T2eEsAId+C11qBbKq021YY8cDszi+R7Ih9gxopN+fzDysfHgziPhFNVDJzFN+oMAikO02Ag2Tq2pa5ksfz0SYfpJAPVYcP6raj+arAIxbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=To2WyFML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E9BC116D0;
	Tue, 24 Feb 2026 17:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771954891;
	bh=gf7Ms95s1RgvWw9e47Pjz2QHDnBpYQUDuMoWY1tTWqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=To2WyFMLVgXEvYTzatLMjiLn2ntdjEaFa6VDTh9i34kCKu66pEeo1N4feEUpUOfjc
	 G86MsC8q04Y3+2bIc9tN92DIaKk2Fg5NtHBZtSgpjvwQIRRL/cu38CiiX42b6BbMFe
	 ylNkc8aaeDMNj7ZcNJKIukCE2RkJ4BYRO/LmbBclmgyxQXKC5gi1NUwCATjmkyX3/r
	 /ZIL0+0PE6Qgp92cgkv0vXXv7FrUdpObjywSUiJcWVfbk6JdaYP4L/Rdj8YUKVmbcF
	 an7nok/o1mGSpKKPsfipYFICv5nQFdu8cWyQ3mB+mXRV2csevOjyxLm+Gg8gI3Busb
	 e0p60gK6/bdaQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	security@vger.kernel.org,
	Nicholas Carlini <npc@anthropic.com>
Subject: Re: [PATCH] nfsd: fix heap overflow in NFSv4.0 LOCK replay cache
Date: Tue, 24 Feb 2026 12:41:22 -0500
Message-ID: <177195487508.52303.16513552497833226121.b4-ty@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260224-v4-0-lock-overflow-v1-1-22beeaf5cf6b@kernel.org>
References: <20260224-v4-0-lock-overflow-v1-1-22beeaf5cf6b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19184-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0BA7E18AA6B
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

On Tue, 24 Feb 2026 11:33:35 -0500, Jeff Layton wrote:
> The NFSv4.0 replay cache uses a fixed 112-byte inline buffer
> (rp_ibuf[NFSD4_REPLAY_ISIZE]) to store encoded operation responses.
> This size was calculated based on OPEN responses and does not account
> for LOCK denied responses, which include the conflicting lock owner as
> a variable-length field up to 1024 bytes (NFS4_OPAQUE_LIMIT).
> 
> When a LOCK operation is denied due to a conflict with an existing lock
> that has a large owner, nfsd4_encode_operation() copies the full encoded
> response into the undersized replay buffer via read_bytes_from_xdr_buf()
> with no bounds check. This results in a slab-out-of-bounds write of up
> to 944 bytes past the end of the buffer, corrupting adjacent heap memory.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] nfsd: fix heap overflow in NFSv4.0 LOCK replay cache
      commit: 1e8e9913672a31c6fdd0d237cd3cec88435bd66e

--
Chuck Lever


