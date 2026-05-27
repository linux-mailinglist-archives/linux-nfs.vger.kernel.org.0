Return-Path: <linux-nfs+bounces-22024-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAfSOsgnF2qu6wcAu9opvQ
	(envelope-from <linux-nfs+bounces-22024-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 19:20:08 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4525E8460
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 19:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2412C300EC4B
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 17:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1029443E9F5;
	Wed, 27 May 2026 17:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBWFd4DO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037E31427A;
	Wed, 27 May 2026 17:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779902403; cv=none; b=Tv955VSdzFxDEf60dfntpOE74loAbne6oTQ1aDBCqYIoEdcq5z6Bj39iwY2XjV2Wy4fy0ktJQRgfrw9VKR3oGwv3nZ2xRA1GWbdFkFybqOH3B+RKBpCfOnb5WKZ4qde6qQdyGwvP+y+X99SDX7SSQ/TRLBGFcbiTRHdySzRqI1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779902403; c=relaxed/simple;
	bh=7eZbzx1RByo/VHVHh1IHKqc8rKSlVFjqD4mmLKDYB2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PavBnAKvQha9hU0B7x4BijqVAn6sS2XyfXuO6Rh/83ciVy+mBCNu3bjwWVZjTmqvBra4oNiCFKffyvKFljb7QwypHnPYKIPQmr3CXBgGTSyevokr8eTj7Lg4P9gEv77LwLeGSdyvIHFwP47t0qszsr4aqUIrAbGBFeMBNbFKeTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBWFd4DO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE911F000E9;
	Wed, 27 May 2026 17:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779902401;
	bh=FxY6ktS10IUlu+hVKDoSvuxVpoWfzbalSs+OQUdnIwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cBWFd4DOxQn9u0e83rV6//zKl+VlYHiVeqlKiW9rDVc1Tqa29hyLxZQeCXE1jyi7K
	 AEK0I48Wo1X3eYlqJ165PZFhn74bG7GD0Mn9GebkzvScW7WtH15HpTy0NHPqoTFU9u
	 TMwvEzsxIfUTT11RVDW+FDZpmVl18ejoMnD2RNMdwOp1x2COAYUj4jMMwrVSO1pE/X
	 jnMiGj82BXZzJUxIQHwZ5tjUv1UuAy5mNsYxrdErE57Dsa0tNGmbmvKWD5N6Gbept+
	 Qh82RDsKd/zdb00NstdSe0aISMwCUTwgKHAmPWVQ/ihgS5HjATjpilHYZdMNSrjhtz
	 bz4duBmbNTaAA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Calum Mackay <calum.mackay@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: block non-SAVEFH ops after FOREIGN PUTFH to prevent NULL deref
Date: Wed, 27 May 2026 13:19:57 -0400
Message-ID: <177990236378.209507.13078791366747857489.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527-putfh_foreign_fh_null_deref_consumers-v1-1-1b8a5aa28c59@kernel.org>
References: <20260527-putfh_foreign_fh_null_deref_consumers-v1-1-1b8a5aa28c59@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22024-lists,linux-nfs=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EA4525E8460
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

On Wed, 27 May 2026 10:53:37 -0400, Jeff Layton wrote:
> When CONFIG_NFSD_V4_2_INTER_SSC is enabled, nfsd4_putfh() can return
> success with fh_dentry and fh_export both NULL if fh_verify() returns
> nfserr_stale and putfh->no_verify is true. The NFSD4_FH_FOREIGN flag
> is set, but the compound dispatch loop only uses this flag to bypass
> the nfserr_nofilehandle check -- it does not prevent subsequent ops
> from running with a NULL fh_dentry.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] nfsd: block non-SAVEFH ops after FOREIGN PUTFH to prevent NULL deref
      commit: d8db9ced22a876091c432c4adb35e5d05be196aa

--
Chuck Lever <chuck.lever@oracle.com>

