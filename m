Return-Path: <linux-nfs+bounces-22387-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cGRzDt1fJ2rFvQIAu9opvQ
	(envelope-from <linux-nfs+bounces-22387-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 02:35:41 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C36C65B612
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 02:35:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZODzerro;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22387-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22387-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC5F3303298F
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jun 2026 00:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B62E25FA29;
	Tue,  9 Jun 2026 00:33:47 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABFC244661;
	Tue,  9 Jun 2026 00:33:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780965227; cv=none; b=sC5P05KF/MlXCyg9g9yr0z6bF14pMu0+ajjQ/7YsDswPNxC89fkrXlTO38SZ0alSuwYf1O9FTQajSDPgStSOLoBWXEQmtLUdnwUl+fZbWQy7Cv7z9IIZneTUgYs0IExBkAB+UUa2QdZC6n0+pxkuvy6xfVC+vmNRY5lOAiuhoxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780965227; c=relaxed/simple;
	bh=t8gEdjbrs6qgE0T05yWWf+zBdM3rY8wM+GccnVr1ZFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A3jHFUnwLnGwhvTdp/oDP+34ov0/Atrp1nrPtuKkA9XLrQ/kQAdVSpxUXSkG3vpxQDaKAPChUmLyyYYUBz9MQUlf7ZRCqSACFP+luUlEoeHaO/xqM2BWMZWnHyma7EkIJVHltU256/THWC8IyDFKy3Fyi3qXFb2yu3oTPxEdDbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZODzerro; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BDD1F00899;
	Tue,  9 Jun 2026 00:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780965226;
	bh=YuDJfJJTRs3UGqZWaxi44T79ItiIkoQpI092YqffL3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZODzerroKrElQpgiYs7ZyrZeFuZ/lXdg7gpSRRE4E6lwrOOFK+t4uKaAsmig7dkgs
	 kGlydAKYDv9ZPW/J478CYPs0snXBTvoKFFJBsyCWFVZGaMXqmMSnm8tj4iya+4Xk3b
	 sPC8xK1esKeHVJYHHyMwUResT23pi5JoFD/Ky829OQzKtU05jG0MCXuWTupmecWGgg
	 90SvJDG0UafPP0qVa7zT671rkQ26LFmDh7B0myT3IhVjzlX0mhOksD6vqnN1IlaRFx
	 HXsKHL7MSXwmXsINazzs3HSwLqOrfH7/zPbEGtyI3QyuFtiR9l1xA9EHLNlogSgzxv
	 5gNsrgaT69ZOQ==
From: Chuck Lever <cel@kernel.org>
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	david.laight.linux@gmail.com
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Arnd Bergmann <arnd@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Trond Myklebust <trondmy@kernel.org>
Subject: Re: [PATCH net-next] net/sunrpc/svcauth_unix: Use strscpy() to copy strings into arrays
Date: Mon,  8 Jun 2026 20:33:38 -0400
Message-ID: <178096512223.86595.14618546480318543216.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608095523.2606-16-david.laight.linux@gmail.com>
References: <20260608095523.2606-16-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kees@kernel.org,m:linux-hardening@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:netdev@vger.kernel.org,m:david.laight.linux@gmail.com,m:chuck.lever@oracle.com,m:arnd@kernel.org,m:anna@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:jlayton@kernel.org,m:pabeni@redhat.com,m:trondmy@kernel.org,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22387-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,oracle.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C36C65B612

From: Chuck Lever <chuck.lever@oracle.com>

On Mon, 08 Jun 2026 10:55:00 +0100, david.laight.linux@gmail.com wrote:
> Replacing strcpy() with strscpy() ensures that overflow of the target
> buffer cannot happen.

Applied to nfsd-testing, thanks!

[1/1] net/sunrpc/svcauth_unix: Use strscpy() to copy strings into arrays
      commit: cea9ba4f71e82766d782ed423c99bb12a69bbdf0

--
Chuck Lever <chuck.lever@oracle.com>

