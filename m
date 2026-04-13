Return-Path: <linux-nfs+bounces-20821-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDeEM1kp3WmVaQkAu9opvQ
	(envelope-from <linux-nfs+bounces-20821-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Apr 2026 19:35:21 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D02463F18D0
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Apr 2026 19:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3EC9330011B5
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Apr 2026 17:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6DE33F390;
	Mon, 13 Apr 2026 17:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8dqeKj7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17B7335072;
	Mon, 13 Apr 2026 17:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776101081; cv=none; b=dva67u950eZwcAt+nMpO0Ej3JE8Szp8m73GkZ5QQrZ7KD8MlVEv4P8CVVB22o7l6p0Ei77hVlsT/zYjCSkRPnp4gMsbDCEHP60d60MWcz9K1HkCiJePLzbKAwLXitckkDyJ87nhM5mZI3u2jUeYVNoypPpEPZKywBuX6rekM/7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776101081; c=relaxed/simple;
	bh=EgMx2veXo38KF8MZ+crAgD2hRCD+uq7sGjaovPBhL9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DHx7lLW2pwQjYndZzBDhX4IdIr08S0ldaQ3i5vvc/jKJ3gNwJvx2x1DwskvMYCEPih6nqI2cA+qkH8JdZYE7lPHdJvfpL5fPX9Fwkl1ULKpHQJHGAYWaix/CjlOCYcFOTy+EZAsg5+y/EuSRRrSYwJvRaTARusSH1KwgDnqRB3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8dqeKj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37DCDC2BCAF;
	Mon, 13 Apr 2026 17:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776101080;
	bh=EgMx2veXo38KF8MZ+crAgD2hRCD+uq7sGjaovPBhL9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k8dqeKj77tTOIPXdbT9zMq687f/6wiv7kLg8FH8fDS0lUCh2WmuHbumTaTzMecmxu
	 aEARbEb5LMrIE8nUEFF/Fe52onwhqDQUsgEYSEyl0QUvXa4fCyAa1GMnsqWMenYm17
	 zs6nydXQmVyXfc2SQNjHA7ZPw0tDJ/eXE0NiSVBOAFgnjjfK0DFOSOoGJSnTxpF6tT
	 vZln5cnOyTgUBJfAbt29EyOEkinDWJWeJSQpAd/UKTuhOoYuVMrLdLXDmoWZLTCaOc
	 iZIdxQY+BOCj3SYOwwUZ5GIZuJHD7mEm/HwCsa9frdI7YokEycu09tnrmDmQSGg3rk
	 HxpSFWG2wlnPw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sunrpc: start cache request seqno at 1 to fix netlink GET_REQS
Date: Mon, 13 Apr 2026 13:24:36 -0400
Message-ID: <177610106224.4271.14936503257520657746.b4-ty@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411-exportd-nl-v1-1-ca582b6d9434@kernel.org>
References: <20260411-exportd-nl-v1-1-ca582b6d9434@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20821-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D02463F18D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

On Sat, 11 Apr 2026 17:12:16 -0400, Jeff Layton wrote:
> sunrpc_cache_requests_snapshot() filters requests with
> crq->seqno <= min_seqno. The min_seqno for the first netlink
> dump call is cb->args[0] which is 0. Since next_seqno was
> initialized to 0, the very first cache request got seqno=0
> and was silently skipped by the snapshot (0 <= 0 is true).
> 
> This caused netlink-based GET_REQS to return 0 pending requests
> even when a request was queued, preventing mountd from resolving
> cache entries (particularly expkey/nfsd.fh). The unresolved
> CACHE_PENDING state blocked all further notifications for the
> entry, leading to permanent NFS4ERR_DELAY hangs.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] sunrpc: start cache request seqno at 1 to fix netlink GET_REQS
      commit: 2dd2484661eb089e5eb2ba9da4b87decb0f3be36

--
Chuck Lever <chuck.lever@oracle.com>

