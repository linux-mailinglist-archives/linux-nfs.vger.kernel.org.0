Return-Path: <linux-nfs+bounces-22305-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EOB9LKL3ImqFfwEAu9opvQ
	(envelope-from <linux-nfs+bounces-22305-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 05 Jun 2026 18:21:54 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A54C649B6D
	for <lists+linux-nfs@lfdr.de>; Fri, 05 Jun 2026 18:21:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=aYkxCvoZ;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22305-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22305-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0FCBD3086F61
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jun 2026 16:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C978543DA29;
	Fri,  5 Jun 2026 16:14:03 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6FB3ED100;
	Fri,  5 Jun 2026 16:14:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676043; cv=none; b=Xyfk+5HTum26qP30aUygP2RZ0J9oe8eUbrqGlFu+Klsn9Tj/J3kL5nR3WkRN79pEOjKnMWvns6kDTNLhKjFvlE/1OnDrqvUCYnctGT5U5m1mXiiWrRZEx6sv+h6NxQyOu2fT0AKgGowQOqUnSzjoRytF4gN8kXV/tXG8MEV9yW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676043; c=relaxed/simple;
	bh=qfJSxivJKSAc6GybDTJFt1hJGtirwxCsZRvpXWFHDco=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=fn2X0g29YEhMd8CiWRBx3Gc/isrz/bsAJ0CZwf9hoHGtTlOX2C5sAZYsX9r4MNPQYuzvi6A0EN4e5TDpmt96HT5vgiVlE4fV7R8VOIsM0Wcduu4VARAiTER9W6gPdD1wSqwuUoV8rhEvIecfO7YfsqIRZFHvKvb9NiW/FikySxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYkxCvoZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26ECF1F00893;
	Fri,  5 Jun 2026 16:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780676042;
	bh=LlBF/EKrCeA+qvVM3GJ3fvZdTIw9bjb2cDkUm0rjP4Y=;
	h=Subject:From:To:Cc:Date;
	b=aYkxCvoZPB+nk/SgCwfa1EXN07/gLv2/iZQXxAVp1QMEs5p7ViSgmdpu3BULxQcTU
	 aqWKKGfXT9Z5kfhGl57QLt5iWepa45q8T22hDzSmPVkHHFCD/eZ2IkuULyvATXEFyO
	 uEsxEGrvGc8jZQDBS7MSuCT55AmOrZ9ZV0a22KeSHAEoU2lrlkOoOgLLx0JLrXCt0W
	 ThrBECeMCRbWQDyS87oG8cgMiv8CZ0qErqESt2CgP/WC/ENjMc1wR7pKbqBgirAO2o
	 Go+AskMyKhVBpVVT0eReY9OWL3cZTPhoUKspbf6QP9DwyRkXPgoH/yh5+416UjQr12
	 q0E6d00qbmFpg==
Message-ID: <17a6eb87940db2a6306e087998b82a6da35d755c.camel@kernel.org>
Subject: [GIT PULL] Please pull a NFS client bugfix for 7.1
From: Trond Myklebust <trondmy@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 05 Jun 2026 12:14:01 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22305-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[trondmy@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[trondmy@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,hammerspace.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0A54C649B6D

Hi Linus,

The following changes since commit e43ffb69e0438cddd72aaa30898b4dc446f664f8=
:

  Linux 7.1-rc6 (2026-05-31 15:14:24 -0700)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-7.1-2

for you to fetch changes up to 317d5146fb399ad1e87b310ee7d018fe648d40ba:

  NFS: write_completion: dereference loop-local req, not hdr->req (2026-06-=
02 10:27:45 +0200)

----------------------------------------------------------------
NFS client bugfix for Linux 7.1

Bugfixes:
- Fix a use after free in nfs_write_completion

----------------------------------------------------------------
Dave Jones (1):
      NFS: write_completion: dereference loop-local req, not hdr->req

 fs/nfs/write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

