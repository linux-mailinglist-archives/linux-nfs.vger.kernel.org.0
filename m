Return-Path: <linux-nfs+bounces-22747-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id D9/BLkUBOGoKXAcAu9opvQ
	(envelope-from <linux-nfs+bounces-22747-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Jun 2026 17:20:37 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC916AB28E
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Jun 2026 17:20:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fs36Azac;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22747-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22747-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C4DC3016256
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Jun 2026 15:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7A4248873;
	Sun, 21 Jun 2026 15:20:32 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2846D235BE2;
	Sun, 21 Jun 2026 15:20:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782055232; cv=none; b=RXHlV3ymr62iqEB0zUhOjQ8smlZtlpEFC8TfOWZWf0LnvEE9pL/go43H631/SyuJWmFHZxr+XYHTuOFt546F0HlTsKrIGM3csG8bxu9ZVhpdeMlFcIT6+Y+5nAjXj/p+FSCGE2O+hj9tBsPaOtISywwqNl+iFQ+meDb72qSJPiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782055232; c=relaxed/simple;
	bh=ocEaYeROreNDQl5L+7xw9tnuCKahPsfXUIivTg6c8As=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CZ9H3VKQE0C2Nuh1b25eE1xShH3bybK92qSq6BbGTmXBKzsLh+BEI9sUBti/NrSpWsIjx2U/nB6QReE+EGBZezya/EFKJnrOEnMtW8BrHabxjm4K55nBNkHGmmxIR/pEyV32W/xAwnum/o69O73V7pUKNxy9A4hexjBbpmQPrqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fs36Azac; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27BE11F000E9;
	Sun, 21 Jun 2026 15:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782055230;
	bh=EYrpCXY3q/Gu22M3rOIXrM7QFrx1SlcsP2K6t/90Pxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fs36AzacZ+zMLi7PmTBxW8NfZq2IiQOCkFKaeqo2b6agth/wgMFVwSSyEa+1AjNHS
	 slyKMVsDpbrfrILIAeXLKTV6zrA+vyjg3FRUX/R9jFEQWFleI9VWxm7vFDVKUgAME5
	 wODpipsrnK08Xd5/8q9Ymp6N/biuxaRgNGpPPPffh2WiqZNKNO8hPtg8SCTXRIMBKS
	 U2VC/WrN37SOSNPkUYJOgGsPCYd+veejREZIRNvwWwlnkgPSxolDl7YpldGbF62gza
	 saJN8L0eu7/lcj5EOn2b1fTWnLuKTPRzw2ge1kN3P1ug3dg8hwfx2+/wl/tA9LOCSn
	 ghJsAghjwLGzg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] nfsd: recall deleg if a requested dir attr change can't be encoded
Date: Sun, 21 Jun 2026 11:20:27 -0400
Message-ID: <178205516746.2066611.3875418289197559791.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260620-dir-deleg-fixes-v3-1-4ff9a315c793@kernel.org>
References: <20260620-dir-deleg-fixes-v3-1-4ff9a315c793@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:jlayton@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22747-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0EC916AB28E

On Sat, 20 Jun 2026 14:12:44 -0400, Jeff Layton wrote:
> When the client requested NOTIFY4_CHANGE_DIR_ATTRS,
> nfsd4_cb_notify_prepare() tried to append the dir attribute change to
> the CB_NOTIFY, but silently dropped it if the attrmask space
> reservation failed or nfsd4_encode_dir_attr_change() failed to marshal
> the change into the buffer. It then returned true and transmitted a
> CB_NOTIFY lacking the requested notification, leaving the client's
> cached directory attributes stale with no indication.
> 
> [...]

Folded into "nfsd: add support to CB_NOTIFY for dir attribute changes",
thanks!

[1/1] nfsd: recall deleg if a requested dir attr change can't be encoded
      (no commit info)

--
Chuck Lever


