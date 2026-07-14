Return-Path: <linux-nfs+bounces-23315-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dEzyFTBYVmrm3gAAu9opvQ
	(envelope-from <linux-nfs+bounces-23315-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jul 2026 17:39:28 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF08B756842
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jul 2026 17:39:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jEdaQUai;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23315-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23315-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33851301440F
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jul 2026 15:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334D738BF96;
	Tue, 14 Jul 2026 15:39:02 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1497E2E88A4;
	Tue, 14 Jul 2026 15:39:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784043542; cv=none; b=Ovxew8S2tvCh553/RJs0RsNzSIgvmYAFKo2S5ywLdun0vY9BouTafY+2GkLDROi2EVr+LpeiYfLBzQRlCrmd08VSR9P8J4reo3JLIrGfCrSzc0FlheHK461xVsmNAoChD4hx5cDorYblwiY/x7fyIhnZacogEGLjY9R+yc/c4Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784043542; c=relaxed/simple;
	bh=QY6hsy/SsrM9r56OC5o+WO2wnq7DShSL8oUJlC+2Bo4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OdUX+Qr4esUdOEhDYvcJIsY8A4ra0YpZz9XformyX7/1BfLQXlzGEQgYEnMdJ6hf9NouLaQuYlT8NyrC7kGoikPc/QckQw4kndNSgKzRrKSpVccTHkbR9OJcIcIJVYsMygDIYOdt+mSkPT/OLNW2oYkY/CxIQpWaqmDh70boCNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEdaQUai; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8B11F000E9;
	Tue, 14 Jul 2026 15:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784043541;
	bh=QY6hsy/SsrM9r56OC5o+WO2wnq7DShSL8oUJlC+2Bo4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jEdaQUai5QSrcObq3VaAGv/Imc1PPz26Bta9L4xIqRW3BvltJP9pUDvFRrkY7ynqo
	 GHg81WGKvMPoYfIfWLXHPFNfzX5zj5ZAELjf0tUgjvpMOgAlAymNlf0DsNIdqBdpBO
	 BIhuA8cLr9mKZLxqzI+xF1hhaJc3wW+I7B/RV3tnNhrN2POsDV16gZ/BL1Mr9c+rJU
	 Sltz+GiwSvPxMI/Kqp+ZxyDk2yDbIcPA+I6cTJ8ar0Q2LI4HjVuI/A+wKy3g0CYJnC
	 bO4zvRAWrsw21+5sxxUqo5OOCaBnk+CkJNOYK7zy5RbRjLRKNhSKpDg+dUFbXLTSHB
	 eoJyIWG4haIkA==
Message-ID: <15b4d5a56e560d8b209f5ba7baa85473081e0743.camel@kernel.org>
Subject: Re: [PATCH] pnfs/blocklayout: reject zero chunk_size and
 volumes_count in GETDEVICEINFO
From: Trond Myklebust <trondmy@kernel.org>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 14 Jul 2026 11:38:59 -0400
In-Reply-To: <CAJJ9bXx0HXLRZoDRBhMytZmifwG+V9fi3LL9Sj49DYoeh7-Ajw@mail.gmail.com>
References: <20260711150547.2912006-1-michael.bommarito@gmail.com>
	 <f5705b41fd63260c5b84343531f139fa72dfa57c.camel@kernel.org>
	 <CAJJ9bXx0HXLRZoDRBhMytZmifwG+V9fi3LL9Sj49DYoeh7-Ajw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[trondmy@kernel.org,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-23315-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[trondmy@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hammerspace.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF08B756842

On Tue, 2026-07-14 at 10:41 -0400, Michael Bommarito wrote:
> On Tue, Jul 14, 2026 at 10:37=E2=80=AFAM Trond Myklebust <trondmy@kernel.=
org>
> wrote:
> > NACK to this, and all further patches with the words "malicious
> > server"
> > as their justification. It's time to stop this incessant flood of
> > worthless AI slop...
>=20
> Sure, I hear you.=C2=A0 I'll make a note to skip your subsystem going
> forward.
>=20
> FWIW though, these are often exacty the networks where ARP spoofing
> still works and malicious server can be read to mean "anyone who can
> pretend to be a server/peer" for the relevant packet/session.
>=20
> Thanks,
> Mike

Then seeing this is a great opportunity to discover that you have an
insecure network, and that you should have been using either krb5i,
krb5p, TLS or secure VLAN technology to protect your on-the-wire
message protocols against precisely this kind of man-in-the-middle
attack.

Again, though, a savvy man-in-the-middle won't be trying to cause
clients to crash when they have a golden opportunity to manipulate the
stored data instead.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

