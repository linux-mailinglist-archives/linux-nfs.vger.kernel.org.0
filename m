Return-Path: <linux-nfs+bounces-21761-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIeQAcMlD2paGgYAu9opvQ
	(envelope-from <linux-nfs+bounces-21761-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 17:33:23 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD365A869C
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 17:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ABE8930AC715
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 14:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35603CB2CF;
	Thu, 21 May 2026 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b="b5hkpqhs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx1.manguebit.org (mx1.manguebit.org [143.255.12.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4759B2DB798;
	Thu, 21 May 2026 14:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.255.12.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373705; cv=none; b=d/DmGR4fvCji5d3FqwVlQFgG6tF6ALaSBrEfSTvhhfmL1DgGCeqOyeFdAxzI/Y13dtX/CAp8iBvySStiGDuPlA/kIR3us3/1hvWS/+4P6iy/NELFbzhMMVtdX+dGa3hf1lZlJJAvL/D4IVDDTJ8fO+I3EVr7KNTcdmSQJiF30V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373705; c=relaxed/simple;
	bh=KWU2EDmXQBTG5DLPdFxKobDHiToM+mfOE1b7+jAcpFI=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=UAW1/wYCYyxm/1/G20pFChUcr9a7t61bLlg0kXeekOPLfyya07ur1O+OxOFwDvp+1Sb8EyHXurm7jK/HFt6bdf1BgC6+rC6pd0hElLUcBujPQNPCOO1evKbiNR93XGXOU3To7qeicCGP7o/dJqJII6aGoiRuyh8y/zPrlsQ06MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org; spf=pass smtp.mailfrom=manguebit.org; dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b=b5hkpqhs; arc=none smtp.client-ip=143.255.12.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=manguebit.org; s=dkim; h=Content-Type:MIME-Version:Date:References:
	In-Reply-To:Subject:Cc:To:From:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UwEEL0LI+VFnshm18CuwmqJStK8fzRpsyojkysR9+PY=; b=b5hkpqhsc75cguqT4f6xPyoaIO
	ME1kwppW0q7hAk31tH2VaC3JCs7xUK+3VTopLmknRkYXHjl678267SRLJAhz1pq9QxGY20a1jvc2y
	tqBE/3sVOaX0SVGaDo4lCNIN5OoZ1SpMqV3GFrfHnhgZoM9WAdKc7NRXD1rhkqvlhkN3uSFKnQcSL
	LwlLKy9Digb6FBtdVtseFOQ0f5kC58PUirqAGaw3H08TS73mOLe95G4yvuAXTUEBVGn2CZumyb1qU
	qrxZpJ90+HpQn6bbsAFoDB+5U8+bJOGROSwrHLhiyHSPJ9jDx+GB07ahGA09yOnzSDHAS4Z8dLIss
	TDSg/JWA==;
Received: from pc by mx1.manguebit.org with local (Exim 4.99.2)
	id 1wQ4Nm-00000000DM7-16It;
	Thu, 21 May 2026 11:28:18 -0300
Message-ID: <5967be753a797fa05c00cd76d20d37c8@manguebit.org>
From: Paulo Alcantara <pc@manguebit.org>
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai
 Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Chris Mason <clm@meta.com>, Jeff Layton
 <jlayton@kernel.org>
Subject: Re: [PATCH] nfsd: fix inverted cp_ttl check in async copy reaper
In-Reply-To: <20260521-async_copy_reaper_cp_ttl_inverted-v1-1-66b87cb1bf64@kernel.org>
References: <20260521-async_copy_reaper_cp_ttl_inverted-v1-1-66b87cb1bf64@kernel.org>
Date: Thu, 21 May 2026 11:28:17 -0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[manguebit.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[manguebit.org:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21761-lists,linux-nfs=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[manguebit.org:+];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pc@manguebit.org,linux-nfs@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: ECD365A869C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jeff Layton <jlayton@kernel.org> writes:

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
> A secondary consequence: if cp_ttl ever reached zero (not possible
> with the current initial value of 10 since the copy is reaped at
> 9), the copy would never be added to the reaplist and would leak
> indefinitely on clp->async_copies.
>
> Fix by negating the test so that cleanup runs when the TTL expires.
>
> Fixes: 26e6e6939369 ("NFSD: Add nfsd4_copy time-to-live")

Wouldn't aa0ebd21df9c be the correct commit id?

