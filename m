Return-Path: <linux-nfs+bounces-21770-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6E4lFzNfD2pTJgYAu9opvQ
	(envelope-from <linux-nfs+bounces-21770-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 21:38:27 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE245AB7F3
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 21:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E0F4B3008682
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 19:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC4D3F1AA4;
	Thu, 21 May 2026 19:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yfx1BErY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB994028C1;
	Thu, 21 May 2026 19:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779392299; cv=none; b=hErBEe5fLSe2fITF7pZ3m3erV/g4ctL4oM8j4IoSYPVBkG1DRc2IBZtPgIzvkL/WTnT58MhQFkdE7n3uGKVvTOziY44tcn8jtBcKKtH8e4se4bh0RcF+V0OXOq6N+uh2ZBv3ietDFK0f0c/FTK6I1n07jE6AxGoC57D0h9uPIyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779392299; c=relaxed/simple;
	bh=KI+lU3WQooofKKt3kaIu+ayBGdSMHat7bmI7TGenF0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OL5mAonceCgecMlTjHXEyib6DaTLgmPQTtK9EtVFtdtnPxX5ZEx3k4qcoRZBcGMSxEwvIc6aaOOXhLLyiPIX3UVUu+xxTVrRa4C5uAiwC2PMwa7vIt3zMaRjfEuWd09opTWEJmbGtLtW+fOJFB7WFB9JE/FDcXSyZrF9KLBN0k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yfx1BErY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6991F000E9;
	Thu, 21 May 2026 19:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779392295;
	bh=lBS3RW7kxllLwsyC82EtVH4G0pS+uxw0+uWyjyUqT2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yfx1BErY+wpftTToit9gSqQ8oJO7tr1o2g1dzehN4qnWLoSXWyfo6JnE4oWghUx/D
	 Xxq7492DkTnc8eyxXQuHmXO4PmSmr2UL4WLISzW6KdXY8RNOwolxq6Loo0NpthrLhH
	 aY1LeyMPx2Ee5YTC8PqKABQnUHN/yB48go4y1kBQqxBOq5Llvdz7LPDe0lAy/71gmK
	 7y4IqtOx5827jTkf90uNRk8c8J0ZRIxXOHU1s3qBzwkZluqEXjSogX1/BgBniu1up0
	 6DyMgL0c5asrLODlkiHWhYKhO/lRisFHYVcOTaDQ3oKfV0aEtPaNFKUMik6+N4yInf
	 CWdqpht1vUg+Q==
From: Chuck Lever <cel@kernel.org>
To: =?UTF-8?q?Dominik=20Wo=C5=BAniak?= <stalion@gmail.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	jlayton@kernel.org,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: check get_user() return when reading princhashlen
Date: Thu, 21 May 2026 15:38:11 -0400
Message-ID: <177939228454.181423.5414351515244367010.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521154656.63861-1-stalion@gmail.com>
References: <20260521154656.63861-1-stalion@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-21770-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6FE245AB7F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

On Thu, 21 May 2026 17:46:56 +0200, Dominik Woźniak wrote:
> In __cld_pipe_inprogress_downcall(), the get_user() that reads
> princhashlen from the userspace cld_msg_v2 buffer does not check its
> return value. A failing copy leaves princhashlen with uninitialised
> stack contents, which are then used to drive memdup_user() and stored
> as princhash.len on the resulting reclaim record. The other get_user()
> calls in this function all check the return; only this one is missed,
> which is most likely a copy-paste oversight from when v2 upcalls were
> introduced.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] nfsd: check get_user() return when reading princhashlen
      commit: aff199f9ef2d1870edbc27253798bd97ee9c65be

--
Chuck Lever <chuck.lever@oracle.com>

