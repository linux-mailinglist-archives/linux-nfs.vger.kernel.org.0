Return-Path: <linux-nfs+bounces-21764-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOlCMjg1D2qSHgYAu9opvQ
	(envelope-from <linux-nfs+bounces-21764-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 18:39:20 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC5D5A970E
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 18:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FB80324F862
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 15:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68164347BD7;
	Thu, 21 May 2026 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPCqoIGK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AC13431E3;
	Thu, 21 May 2026 15:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779378108; cv=none; b=DLobbpVNoxfbr7LZwd4s3ytZ44v2vcy6oZPRMIMEn5dDhVhsncqASqR/mMi0q+5PySLon3+mzR9nPBwyfCxD9Q3Qvz3pAv/bg+ZtIwoH9D9HzMm74pJqkRSr6AMJhjd6sH9YnJrztLugPu2RET8I8jCc1SxEVu2egYGLMzA44JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779378108; c=relaxed/simple;
	bh=Zo4MZLKZq+MFC5XHQNFv4upn39mMo3+2OcsSy1VrX/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k7dqjaG9cmTUhwH6b0f6JB4EQOB1Aldv5o9bTg4KXPUnloMBSkGC6SL1LsByn/E5qJFrq1NjRNHZxgt4OQH1cKhmHg01O946rPg6Mm7HF115kL4hypuS8PEI6XZGXL1+nWvZ5miVKoGrV2jCXEKHDZcPM5jQIooZmW4zygn6Uk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPCqoIGK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F021F000E9;
	Thu, 21 May 2026 15:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779378107;
	bh=YVrNH6dng3Db/pnYEAbqix3uQOQV8ZJBKjr1F+lWMb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FPCqoIGK+AC3hXOlMQZBWbymh5i25EiU9muuO/1UmxcQmIj6ckdo6d1fEHxNYByY3
	 8+K7mLDYzUEPQspJBKDCqv+UU6LBpO9T0BuNqNbFyzF8qPT4seS9D5OmAWxmjlYwvZ
	 7Lz6beLytg997o4U7up/Tv0/QcZqHFChkUvMAlGy0sky8uQC3TB5k/6hNSW/PVEAAS
	 8Hb/TNJuUZFGMtNlI9b4z9zWnQJg5j96RmRggTNC5XTl3fZJrcNCoey+UpYM/aAoxY
	 1KFWheFJoK+smE3IFndOvchpUgU/3ozRFnlO8x2H1QRS8s1SDVv+hjF4CslY6ZQeGu
	 p0OFDvrplZ6Yw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Chris Mason <clm@meta.com>
Subject: Re: [PATCH] nfsd: fix inverted cp_ttl check in async copy reaper
Date: Thu, 21 May 2026 11:41:43 -0400
Message-ID: <177937807665.146125.2838077605492493468.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521-async_copy_reaper_cp_ttl_inverted-v1-1-66b87cb1bf64@kernel.org>
References: <20260521-async_copy_reaper_cp_ttl_inverted-v1-1-66b87cb1bf64@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21764-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:email]
X-Rspamd-Queue-Id: 1BC5D5A970E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

On Thu, 21 May 2026 09:25:40 -0400, Jeff Layton wrote:
> nfsd4_async_copy_reaper() is supposed to keep completed async copy
> state around for NFSD_COPY_INITIAL_TTL (10) laundromat ticks so
> that OFFLOAD_STATUS can report the result, then reap the state once
> the countdown expires.
> 
> The TTL predicate is inverted: `if (--copy->cp_ttl)` is true while
> ticks remain and false when the counter reaches zero.  This causes
> the copy to be reaped on the very first tick (cp_ttl goes from 10
> to 9, which is non-zero) instead of after all 10 ticks elapse.
> Once reaped, OFFLOAD_STATUS returns NFS4ERR_BAD_STATEID because
> the copy state has already been freed.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] nfsd: fix inverted cp_ttl check in async copy reaper
      commit: 14ba3b4b7cb4d05a070c77226d10dfc332898421

--
Chuck Lever <chuck.lever@oracle.com>

