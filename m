Return-Path: <linux-nfs+bounces-21985-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Lq6EPXoFWqXegcAu9opvQ
	(envelope-from <linux-nfs+bounces-21985-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 20:39:49 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 498895DB74C
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 20:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 253BC300602C
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 18:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECF742189F;
	Tue, 26 May 2026 18:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lT9Lx0KN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E3E40C5A4;
	Tue, 26 May 2026 18:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779820731; cv=none; b=nfRuYlGQlawA0E28dfcX/QGdoebWMH+F4RQfWAI49o4oh9GkFIcX1cot1fyVrCGgRF9VFjHMy9FJfEs3qSUVnOv76BFgSnLC+0VTzPQZ9y9wuyfZuEYy0kUvvRGLV/hhsu6KWwgU6MN5gu8DO/A+TCE88fWuvobTjqKBxkj8qUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779820731; c=relaxed/simple;
	bh=erYZUqo/eTepFOuNfy13V8LJMtRrrkCgcWYE7J1nhwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=orx7iJNp6N2/Oyke3VqKY8qAuLH5/ACFBAQmgSY4khdQXR0oikjhHwEk4CetnLvd/U02KH84H+KDTNdfa37BgdqhS7lIdiTeTrgbMxXaoculb+37SwwSs6vCba6BvvWpUDsDSEszFQmS7w2GrCaDqmF3GehX1lgDqRG1ucCxZoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lT9Lx0KN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421F71F000E9;
	Tue, 26 May 2026 18:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779820730;
	bh=Swvtg0dl0xuB0yIJKVmzrLc53jSkMaTVwk/eBhNdsOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lT9Lx0KN+3bepEsFRSXXKI/EVjjj/SGJ5iod79DCNwgJSzJkdqakm+xBrzCMx12EH
	 7CPPT8ZIGz+/b96MkDxbgcxgzHk4xj67Cpi2QLACoxmfDoT6VfiWW+WQKnxKspAy91
	 shTsfpdniuTUsNMfJDncLDChlV2zJnQrtaHzf3Ack6JaqrW/wVIu4un6aH9G9HY/Sa
	 YjB5YfvNiDhiFhxc8xlF9AqBDcK5lZTyAU9KkwFENFOk/BQyiMq+FcjUapmEth9h2k
	 cyeTqK7J55IzJuETbePiKwZh220CKsUVhd6ht0eakEmvcq/TiS6oaVpdphxRaiTqBK
	 MVtU9hoenCLWQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nfsd: don't free session slots that are still in use
Date: Tue, 26 May 2026 14:38:45 -0400
Message-ID: <177982071776.99111.17005396297864560686.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526-nfsd4_sequence_shrink_uaf_on_loaded_slot-v2-1-74a89db0639e@kernel.org>
References: <20260526-nfsd4_sequence_shrink_uaf_on_loaded_slot-v2-1-74a89db0639e@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21985-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oracle.com:email]
X-Rspamd-Queue-Id: 498895DB74C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

On Tue, 26 May 2026 12:24:48 -0400, Jeff Layton wrote:
> nfsd4_sequence() can free the very slot it is currently processing.
> When the session shrinker has reduced se_target_maxslots below
> se_fchannel.maxreqs, the shrink path checks three conditions before
> calling free_session_slots():
> 
>   1. se_target_maxslots < maxreqs  (shrink was advertised)
>   2. slot->sl_generation == se_slot_gen  (slot is up-to-date)
>   3. seq->maxslots <= se_target_maxslots  (client acknowledges)
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] nfsd: don't free session slots that are still in use
      commit: 6085718398d83e16ccdc864c209493671f3c5998

--
Chuck Lever <chuck.lever@oracle.com>

