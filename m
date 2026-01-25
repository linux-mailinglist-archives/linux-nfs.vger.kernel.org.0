Return-Path: <linux-nfs+bounces-18442-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0hN/HxmEdWl+FwEAu9opvQ
	(envelope-from <linux-nfs+bounces-18442-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Jan 2026 03:46:49 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F0E7F878
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Jan 2026 03:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46E1030088B3
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Jan 2026 02:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0485E1E0DE8;
	Sun, 25 Jan 2026 02:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6sSWjW4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40C2137930;
	Sun, 25 Jan 2026 02:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769309205; cv=none; b=VLuJeGfx2aWVfzNW6tvrbRsnKQ4fo7PeDL1CFtGWmq1Qmtk4JR8jmwkBYSx1GB+atqUeFapczTeo5y+RvLr/DrZZN+xxmSxklCU681ZaNA5nC8X8hianv7+23Wcs5P6ZTh5jVWH7Om7fn1+a8VsxHo8u1vaBgLVBSnkM+y09hn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769309205; c=relaxed/simple;
	bh=Z4fkG7LSuae0RxuHVuzfycRmmyLAVqUABxHzAF7OhMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AP7BS8vHjHQLYCalmzQrI3kIN/GrkUOXdlONmpG/AoVJYlwqWtsf0KZqOzkM4rU98jITCVKMn+49cHiDFxFuO1DVTehxXHv1vc57WRAlm4cOca42yi12dzcRdHvj35GLEHXWclVoHanHPf0cBD69zZkt16BOUbh3bZMT8XFjJiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6sSWjW4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56739C116D0;
	Sun, 25 Jan 2026 02:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769309205;
	bh=Z4fkG7LSuae0RxuHVuzfycRmmyLAVqUABxHzAF7OhMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T6sSWjW4uvfWgOYMSqF7iHwEw0SnLa6sbAeQAmtkJG0ffdgEUXsNoQ2gHFSqSBzAD
	 aX1QQVvrBz79OJv3Rp8y48YNVKnJgaH4YvTrQBvaD6EIHKzsop535t27aKS16KI+l1
	 ZeWRAXW3bgqBHyd3PmH8HSjfQvG1EQgz7zxdWzOfKJYjBett0+shptMYJ/XulwrBV6
	 W6FqmPdqGvp97xMVW6b/tWjU4hDVlwYX90Hbohoj1eiktG+yzJG98RtLq+hiptDl1C
	 pvEDpf4uQ4dEjcCXik88anbE+jhyw67ZgkEUly6zPzbXIVG12/+6R4LVPbtYmIicyT
	 vQljpj51iUVRQ==
From: Chuck Lever <cel@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ryota Sakamoto <sakamo.ryota@gmail.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: Replace KUnit tests for memcmp() with KUNIT_EXPECT_MEMEQ_MSG()
Date: Sat, 24 Jan 2026 21:46:41 -0500
Message-ID: <176930919420.23964.10388024129059199850.b4-ty@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260124-fix-gcc_krb5-memcmp-v1-1-4648cbbdc78b@gmail.com>
References: <20260124-fix-gcc_krb5-memcmp-v1-1-4648cbbdc78b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18442-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,brown.name,redhat.com,oracle.com,talpey.com,davemloft.net,google.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D2F0E7F878
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

On Sat, 24 Jan 2026 14:17:19 +0900, Ryota Sakamoto wrote:
> Replace KUnit tests for memcmp() with KUNIT_EXPECT_MEMEQ_MSG() to improve
> debugging that prints the hex dump of the buffers when the assertion fails,
> whereas memcmp() only returns an integer difference.
> 
> 

Applied to nfsd-testing, thanks!

[1/1] SUNRPC: Replace KUnit tests for memcmp() with KUNIT_EXPECT_MEMEQ_MSG()
      commit: 63c04545fa093cd399132519a974fca2f1e9aaea

--
Chuck Lever


