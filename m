Return-Path: <linux-nfs+bounces-20638-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DCeMk3sz2lF1wYAu9opvQ
	(envelope-from <linux-nfs+bounces-20638-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Apr 2026 18:35:25 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C44893967A8
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Apr 2026 18:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B3F3B30D997B
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Apr 2026 16:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EDE3CC9FD;
	Fri,  3 Apr 2026 16:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYfWxhtW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7223CB2C1
	for <linux-nfs@vger.kernel.org>; Fri,  3 Apr 2026 16:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775232878; cv=none; b=EMebdtaNGNAj6YW0qaO9kxXk8PLnqeuBZA95BxK7ObU9DYzECHutZbrQfYC3H7Q/ijy5wry0kScCVGTS+Fxas1XMQFqpEUWCT9IxD4JUzHb9m/ppn0BmTCbOIJm7/ziB2ThQ+FKIOD3bMNTrB2DmKXKcP8A5q9v/bgPbPxIuPi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775232878; c=relaxed/simple;
	bh=SKTA09wZCG/wE6T9AUgXOptG1TnhKLsRk5xcJ04D8+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ImbP8+zoyJFsHATUHuK4x8rCrEjTFJsOlb6tuLNT8rA35Qg+E62vM/MwaPQfOQnXW4Yv9ELF690a9tIdRMTkfLTrz1kzb5a0kPqx/tMKHrRAbqCMGbK+CIheq7zM0Pf/j/V84itFlRtPJh28+ppzZo3rYPZtbpeYflnuo8Ht6R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYfWxhtW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE54CC4CEF7;
	Fri,  3 Apr 2026 16:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775232878;
	bh=SKTA09wZCG/wE6T9AUgXOptG1TnhKLsRk5xcJ04D8+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iYfWxhtWfixUbKYx5pkcpKk5zDQ4iw1kKS5thkPF3pe8cbhs6oEHpLZKbaElF4exr
	 nvmkrmj7D2C68bOrB+t7QYgfMkizVD5QpTxM0eRqQErQbj4Z+h7rLbcDRQ0cnHHZw7
	 o21ovWHwNtzr71d6/rqagJpGXDUZs2uMAdymPnmrvwlCrCbB4DMMusFuONbf79Mk4+
	 gBNbmqOdrBnQXsxMDFHL5KXEUfof86PPRAbuYU0pM940yFxccS0ceXNccBDUpiVjkT
	 hQ9myWFWffNhmxf8ujJfOzdtc/oF5hVmodBU2wVvhOWAejAirOrx7+3PfDEyNvaHkU
	 ZBlGI6N3tlR3Q==
From: Chuck Lever <cel@kernel.org>
To: jlayton@kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	neilb@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: Re: [PATCH 1/1] nfsd: fix GET_DIR_DELEGATION when VFS leases are disabled
Date: Fri,  3 Apr 2026 12:14:34 -0400
Message-ID: <177523286705.3159971.9602666478308753581.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403152055.70311-1-okorniev@redhat.com>
References: <20260403152055.70311-1-okorniev@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20638-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: C44893967A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

On Fri, 03 Apr 2026 11:20:55 -0400, Olga Kornievskaia wrote:
> When leases are disabled on the server, running xfstest generic/309 leads
> to an error because GET_DIR_DELEGATION returns EINVAL.
> 
> nfsd_get_dir_deleg() can fail in several ways: like memory allocation and
> unable to get a lease because either leases are disable or it's already
> held. Currently only the condition "already held" is translated to
> returning directory-delegation-is-unavailable error. However, other failure
> conditions are likely temporary and thus should result in the same kind
> of error.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] nfsd: fix GET_DIR_DELEGATION when VFS leases are disabled
      commit: 374af81f6188dce267a3bd5384fa8981de24d437

--
Chuck Lever


