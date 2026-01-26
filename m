Return-Path: <linux-nfs+bounces-18488-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMXAMf6xd2l2kQEAu9opvQ
	(envelope-from <linux-nfs+bounces-18488-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 19:27:10 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9EC8C130
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 19:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 828D0300681D
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 18:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BCD3081D2;
	Mon, 26 Jan 2026 18:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCZ0KafV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661492F362A;
	Mon, 26 Jan 2026 18:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769452024; cv=none; b=hSsdpBJdPN24ravjpUXQug3/6Q7Do124sXaMSvibgkg+0UeJGSTajB0c3qPpywcl8+KNQ9CR8RYC/B5Vo7Q5CkJY3Lf9H3ef/TGfP7LMqtLL+sClfgT0XDQy6N9rRlPVzcWHWFL9UcVTvC47FI9NrKQ3Kme8u5n4PIqkJDsA3AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769452024; c=relaxed/simple;
	bh=tGYe85HpeTyHe3hGUK7pz6LmUvm1qNAQpi+oUMEnXs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJt1H0uOB7aRgS57QZsNNpySi87PTGyCETtZ7/lbyHo0o+nVXz20Oy4pQMv82L73vGYecVGphvCff+vVjPcU/d0arl7yDbOwM7ZaG2qM5bWop8zMmIy+fcCESf8VkeEJMNFudaI6nORh2Q1WkuFwYr1HYODO3pZgqNBjnKDPxVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCZ0KafV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691C1C19421;
	Mon, 26 Jan 2026 18:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769452024;
	bh=tGYe85HpeTyHe3hGUK7pz6LmUvm1qNAQpi+oUMEnXs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QCZ0KafVzds1qn/O4q9Eg9ULEd9/tBiffmCxlWsuVIpTd0lVrOPgqUiOEhX3KqO4u
	 3m72Y6qIROQYdtNpZpbHbxOT9yXQgYyfKszcAmZTFXoj3BImW/cPG2gesL07DA/EIi
	 UOH8DcGPCikR2CGRQEEJqrS0PZK6iT2evfCTCKdkAV1lHK1rSvXZpd37Zj/qgjmSz+
	 oEbYIyW/MdANzHBlfXlmJ4o998V07YYCoubqS0F2bxRx0B0LVxu7cQYdqH+FyTqzO8
	 voHtct3IoddpeaetQBEguMUwaeyPYR7DloeDN5wXs26Fq/d+nHO52RBXCqgW9ZsFXC
	 g+v70eJz1VX7A==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] nfsd: move delegated timestamps to being runtime disabled instead of compile time
Date: Mon, 26 Jan 2026 13:27:00 -0500
Message-ID: <176945201300.108780.3424496378222094323.b4-ty@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126-delegts-v3-0-079f29927b83@kernel.org>
References: <20260126-delegts-v3-0-079f29927b83@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18488-lists,linux-nfs=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2D9EC8C130
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

On Mon, 26 Jan 2026 07:10:12 -0500, Jeff Layton wrote:
> This version just updates the comments an changelogs per Claude's
> recommendations.
> 
> 

Applied to nfsd-testing, thanks!

[1/2] nfsd: add a runtime switch for disabling delegated timestamps
      commit: d0dc64a1a4e8629ffc6ab2a3ce208466de12e75b
[2/2] nfsd: remove NFSD_V4_DELEG_TIMESTAMPS Kconfig option
      commit: aac451587f0d37729d05467badee1578b7efce66

--
Chuck Lever


