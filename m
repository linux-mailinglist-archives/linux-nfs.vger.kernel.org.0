Return-Path: <linux-nfs+bounces-21904-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KO1CILMZE2oi7gYAu9opvQ
	(envelope-from <linux-nfs+bounces-21904-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 24 May 2026 17:30:59 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF9A5C2E0F
	for <lists+linux-nfs@lfdr.de>; Sun, 24 May 2026 17:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B9B23009165
	for <lists+linux-nfs@lfdr.de>; Sun, 24 May 2026 15:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BD139B94F;
	Sun, 24 May 2026 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJjWE4yk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90603164C3;
	Sun, 24 May 2026 15:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779636655; cv=none; b=eAbm9/ZgOMs5xw6S2972zjZUXJxS9Hf0pX12LlhkvI0wW9yTJWqx2IfhkK8Ni+SD3/nlWCi/cm3Q/mx8hUJzkxImIFDwZKcTWIkA04GrCZfkRpUUwQHl7rHhcC32iuqm5W2Av23M+O9NJidpMJ8IKN8AbJkNQIT27PuI7rmCWiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779636655; c=relaxed/simple;
	bh=vIeD6uhlNI55aEJn6mbWzEOc7TplJhJMEB9kjbFahjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k2PucjAEjdHmHZNgfoXBdaYNVYWs8SkXs1l90d7CbpMA7g1xTgkyz5fxCoKTTYSRh5OkW1uNJ8Df6754WmYV95wLkLZM1rbngphJp4XuzgMoEXruDr+yT5psF3rc6dtvHHMt5Q7GHwwfMu9FUmq4HK8hkeDcHe+uJqPKfX9nP9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJjWE4yk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4921F000E9;
	Sun, 24 May 2026 15:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779636653;
	bh=SgxPSUhpZWWGt4XZ81vjtJDcZxs0wBYi77ZQno9sDkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oJjWE4yk6bgtFoflRTFByJuoePTDL7upYAwsYQIlH8i6R5EtSAR67pjUr2PoxoXWT
	 WxG2fIjGJMdxa+YYPP8NKxCuHQUIQCpGSr45j8+w0xOC5u7iKB49IT/Kf6ayHpZAF0
	 2weGITiJEWm2P5284OfEH4M4DLq8/5esp6gSiSondEQsb55wjgs/hQH5R2Tle450Nx
	 kF7cAdWtWx3gN0wMXqNmNmCJFku7AB3jOp5YcpwTdhvkeYV7ANOjtjhXsZ55UkYQ/1
	 dK4SjWUzfvIhFvGaC4/LTdVamB03sDFRzCbbpD7lUxP4pI0wTEX2VEzRx0oF8zcgOs
	 eHdXHRzB2QLgg==
From: Chuck Lever <cel@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Michael Bommarito <michael.bommarito@gmail.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] lockd: pin next file across nlm_inspect_file lock-drop
Date: Sun, 24 May 2026 11:30:49 -0400
Message-ID: <177963663874.586332.1618491732066726198.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260524115527.1734251-1-michael.bommarito@gmail.com>
References: <20260524115527.1734251-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21904-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CFF9A5C2E0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

On Sun, 24 May 2026 07:55:27 -0400, Michael Bommarito wrote:
> nlm_traverse_files() pins the current file with f_count++ across
> a mutex_unlock for nlm_inspect_file(), but nothing pins the saved
> next pointer.  A concurrent nlm_release_file() can kfree the next
> file during the unlock window, and the iterator dereferences freed
> memory on the next loop step.
> 
> Pin both current and next before the lock-drop.  Advance by
> swapping the pinned cursors at the end of each iteration so next
> is always held alive across the unlock.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] lockd: pin next file across nlm_inspect_file lock-drop
      commit: 925b64e5fb12ad6517ff7c6729bf2fba7485f42c

--
Chuck Lever <chuck.lever@oracle.com>

