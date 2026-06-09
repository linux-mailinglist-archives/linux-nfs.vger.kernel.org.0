Return-Path: <linux-nfs+bounces-22386-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NGm/IapfJ2qnvQIAu9opvQ
	(envelope-from <linux-nfs+bounces-22386-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 02:34:50 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D268A65B5F8
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 02:34:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dmTUDU2Z;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22386-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22386-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BFFD301950C
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jun 2026 00:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CC1175A7E;
	Tue,  9 Jun 2026 00:33:45 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F541DCB24;
	Tue,  9 Jun 2026 00:33:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780965225; cv=none; b=fojRQamG05HY9ewZOdgpWWYuFBm0s/9vMPQYmxqg4GvpLJ+SU4fMhN/TATJlz4GcAPWVfUJKWRXGj9nvBXAk+BddfXgoR091tN2mtu3Yl7VpQYV1n9ywGJ0GBlp0D2nYR1r1z9OX4Edh6YNblNbo9WTjmaA4peaRXoofCYjsSvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780965225; c=relaxed/simple;
	bh=8RuU++UwisR5fPXlzSFXkEWmO/woXKh12mt3rGjxlKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mzwGO0dDSYsm1WeeWRGEDjApqy6rQbDCdcWaQqMQt6FQkWFM1eFZgxQ93dmcQMk2+ztyTa4w7dsiU08yuuant7hoAvye82huzh89Y1dI/Pgr7i7ViBFLclwXMD4uUoSWSOKmljtKwcPMcFhG3KV+Z2h3qXxiF4OXoksj9KWu1SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmTUDU2Z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C081F00893;
	Tue,  9 Jun 2026 00:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780965224;
	bh=rPhf1brFQBHAvLs45E4bbHeOYrSE211UYIuxCAmTF1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dmTUDU2ZlUO4gwkiZWtliHtXJGzfrAshvkbRmyeUnycw+K4qztRaSxRmSTVmwePrY
	 96DZ9UpOX+PiuMqMXJN4x13AK7P9HbSP8fcgh5R0J9Xkm80Kn6MZ8PdOub62USFoeX
	 6P7yL15zFbDDpfpduYQIxPAO1cimmfrrhTfW4vh/muN7m7CulRrbDMcOP35x04cyaf
	 gWsb5ik+DVd/tUn1iQVPlt4wQPDDPOJTvoQ7HflkIcKgB9U/DgHyHGBZl8RGe2eIg/
	 Kd3m4Z+VLULeCWPwsiUPdFrBIAXwJ4/9PEpPgQV7h2hOTek53VRYS2Uz099sk3dYYd
	 6iZXruyrOaGcg==
From: Chuck Lever <cel@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Laight <david.laight.linux@gmail.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/1] sunrpc: Use "%*phN" to dprintk() a cookie
Date: Mon,  8 Jun 2026 20:33:37 -0400
Message-ID: <178096512225.86595.10611807401110857204.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608212042.25476-1-david.laight.linux@gmail.com>
References: <20260608212042.25476-1-david.laight.linux@gmail.com>
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
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:david.laight.linux@gmail.com,m:chuck.lever@oracle.com,m:geert+renesas@glider.be,m:andriy.shevchenko@linux.intel.com,m:davidlaightlinux@gmail.com,m:geert@glider.be,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,brown.name,redhat.com,oracle.com,talpey.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	TAGGED_FROM(0.00)[bounces-22386-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs,renesas];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D268A65B5F8

From: Chuck Lever <chuck.lever@oracle.com>

On Mon, 08 Jun 2026 22:20:42 +0100, David Laight wrote:
> Simplifies the code and removes a 'not obviously bounded' strcpy().
> 
> Delete the local function nlmdbg_cookie2a() that did the equivalent.
> 
> There is no need to worry about cookie->len being more than
> NLM_MAXCOOKIELEN (32), the buffer holding it is only that long.
> The existing length checks must pre-date this code being added in 2.4.26.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] lockd: Use "%*phN" to dprintk() a cookie
      commit: 926ef0ef7994232faab29e6b13270d5c88b058f3

--
Chuck Lever <chuck.lever@oracle.com>

