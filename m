Return-Path: <linux-nfs+bounces-20225-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCNPGnFvuGn5dgEAu9opvQ
	(envelope-from <linux-nfs+bounces-20225-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 22:00:33 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1602A07A6
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 22:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A80313080F8B
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 20:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7C035C1A0;
	Mon, 16 Mar 2026 20:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlDfVP4h"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B774035B64E;
	Mon, 16 Mar 2026 20:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773694610; cv=none; b=F5jLFNYSLdARs1fsoH07eH6MjMu5nrvOlaG3m7ug9uUwQL66fgiNhD4eJ6EMleO/rR13ZgA4z+nR+oIxDi4fLBrZJVfNrn4tLZx26Ce2rZNwP4IPrgUiRFLHRDC/pMuh4wSg6Q6Jy0BfHy2VADqzzrOJ8UfLaOv7DKG0arkgw+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773694610; c=relaxed/simple;
	bh=qxlH5h5RsDpVAKKzooEbTyCw6wl38yRcEmCwAmeNLjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e8QFYglmxKTl23pgeoDb0xypvW1wt7WKUaFTLNVlXvb5eXLRiOHVWphnCV/AR/moXg4F+lJIFj4B7cfwIPYT5e8EMfX+SNZfBlxFsCaQQ6zfaarHl+VFcd+UPcJ76qKtfbNVOI+nH9POZt2CWP7AKyptZryyNpUAZjSKG3ZE0i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlDfVP4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469D6C19421;
	Mon, 16 Mar 2026 20:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773694610;
	bh=qxlH5h5RsDpVAKKzooEbTyCw6wl38yRcEmCwAmeNLjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dlDfVP4hQVMmXLTOlNUTyYwgBSXkGYeJY7ZHe8ZO0eYPKj+GvX5OfYLl2jhAA5Qx+
	 9OySuC/FlFVetDx8fjeAKjfFy+zxkZJW/JdOoeWdi1xtBvJxbtgLWG5I8t7QsW/8o4
	 A7cHfJ9zGos0z8Lomq/lEIyeY/dA/l1jynjp2O1lIx5sQP1HQlKO2aaqa4wcxbtf+q
	 l8eBXGrqed2Yps36lKMpuXCX6aOxrQWENBALFAYe6O3imS5f6naNPEbLrRE9R3OQ8k
	 +e3QVL6ANXirTjnllkD4TSS2Fgq9U01KC2BlJJqXtesV7FjBRO0t8xfgBZZ7OxS14d
	 Ek2v6u+xfJWEg==
From: Chuck Lever <cel@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	Joseph Salisbury <joseph.salisbury@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: fix comment typo in nfs3xdr
Date: Mon, 16 Mar 2026 16:56:43 -0400
Message-ID: <177369453346.774056.8240280459923640975.b4-ty@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316182516.153940-1-joseph.salisbury@oracle.com>
References: <20260316182516.153940-1-joseph.salisbury@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20225-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,oracle.com:mid]
X-Rspamd-Queue-Id: AD1602A07A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

On Mon, 16 Mar 2026 14:25:16 -0400, Joseph Salisbury wrote:
> The file contains a spelling error in a source comment (occured).
> 
> Typos in comments reduce readability and make text searches less reliable
> for developers and maintainers.
> 
> Replace 'occured' with 'occurred' in the affected comment. This is a
> comment-only cleanup and does not change behavior.
> 
> [...]

Applied to nfsd-testing, thanks!

Removed Fixes: and Cc: stable -- not appropriate for fixes to
misspellings in code comments.

[1/1] nfsd: fix comment typo in nfs3xdr
      commit: d62daf7b8995e05cca3465a21139f619db860ccb

--
Chuck Lever


