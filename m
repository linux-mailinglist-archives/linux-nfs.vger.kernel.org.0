Return-Path: <linux-nfs+bounces-19150-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TETEIAfCnGnJKAQAu9opvQ
	(envelope-from <linux-nfs+bounces-19150-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 22:09:27 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F13B17D603
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 22:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9E269300D743
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 21:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAEA377576;
	Mon, 23 Feb 2026 21:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzRvlX94"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE69E314B6A;
	Mon, 23 Feb 2026 21:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771880961; cv=none; b=Kwa6e5NuNrrGs829fdDtoy7yJOB3R5xBeDnA27ka9RfvDreBjg4H8dA7nfdcig0/kdRdMgfTx9ABQ8V2zB2rK2giVOELuS+g/Bcc+4JQKyQ109IZLUiPg8gM4UMC7nAj4zmVC8xHgeHlaOQUEHpOdqAvjNx60A/xIk1NnhPUzN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771880961; c=relaxed/simple;
	bh=Iksp7bInjD+fbadXoMvyFRua7XJx8qD+o3C0sR+Mn2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ecHFM/+khBtWANpLa7ytx0GXsw/l0CYmZtn7ahqKOB7geomSARVsC7QJ+NUEeVbMgRheMuVHv/xS3mlGrmox8RJogRgEge+IWj5LD+QoUN0UE018YxYUnncNHTYJbjbfNu0HNgOtO/2+mDIBxhDSR9NTYk3lY68HZOPJqcwM2L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzRvlX94; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88466C116C6;
	Mon, 23 Feb 2026 21:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771880961;
	bh=Iksp7bInjD+fbadXoMvyFRua7XJx8qD+o3C0sR+Mn2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SzRvlX94W7oP/WEwTQ/213G+0/7Sn/OamrWg91VU6acDI5h1IeJ+3CLh6vxUGEGPi
	 rc1qnEl1ky9aZyjDTJgDTYez0EnhbY6VO9XkBRDzsD5kzPaF0b5YQhbb4MVZHa3Wtp
	 hz2HCV3sHSVbvYNjinWInQdoNEvXD5b2ezyaHxaOGdK4hos4tr2MopBBZ5sEtkyOru
	 9jOrm3uVg0LGcSj0L2MDgwKIkQD+T07fzxavzA73Y5TIgM8mhXg9NDtEmom++tB8p9
	 PO6h4jf0mZP29e5tG4IWK0Q5TggrdrA0e4nkhaFO+UCY4Ywe37rExyFhHUuWg06n39
	 1GdzoM2he9TTw==
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
	linux-kernel@vger.kernel.org,
	NeilBrown <neilb@ownmail.net>
Subject: Re: [PATCH v2 0/4] sunrpc: cache infrastructure scalability improvements
Date: Mon, 23 Feb 2026 16:09:15 -0500
Message-ID: <177188092388.32759.9563088581417995762.b4-ty@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223-sunrpc-cache-v2-0-91fc827c4d33@kernel.org>
References: <20260223-sunrpc-cache-v2-0-91fc827c4d33@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19150-lists,linux-nfs=lfdr.de];
	FREEMAIL_CC(0.00)[oracle.com,vger.kernel.org,ownmail.net];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8F13B17D603
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

On Mon, 23 Feb 2026 12:09:57 -0500, Jeff Layton wrote:
> The first patch fixes a pre-existing bug that Neil spotted during the
> review of v1. The next two patches convert the global spinlock and
> waitqueue to be per-cache_detail instead.
> 
> The last patch splits up the cache_detail->queue into two lists: one to
> hold cache_readers and one for cache_requests. This simplifies the code,
> and the new sequence number that helps the readers track position may
> help with implementing netlink upcalls.
> 
> [...]

Applied to nfsd-testing, replacing v1. Thanks!

[1/4] sunrpc: fix cache_request leak in cache_release
      commit: dad5f78046759eb5c95970198eb9865550eb6227
[2/4] sunrpc: convert queue_lock from global spinlock to per-cache-detail lock
      commit: c94ad34b7ecd5928cf3fdb6ea4fcf6ef55765e97
[3/4] sunrpc: convert queue_wait from global to per-cache-detail waitqueue
      commit: 951696964e9c370a5f91d5e3e136d39aa08d912c
[4/4] sunrpc: split cache_detail queue into request and reader lists
      commit: 3557b9c71039b2435b383fc57283a0b847b40144

--
Chuck Lever


