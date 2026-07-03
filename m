Return-Path: <linux-nfs+bounces-22974-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uJ5dFUreR2qdggAAu9opvQ
	(envelope-from <linux-nfs+bounces-22974-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Jul 2026 18:07:38 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A0E70424A
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Jul 2026 18:07:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mhefmiM0;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22974-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22974-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8556E3012321
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jul 2026 16:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43392290DBB;
	Fri,  3 Jul 2026 16:03:11 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1E3265CD9;
	Fri,  3 Jul 2026 16:03:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783094591; cv=none; b=sezVmjZUNYZUjxuUkOBCW3Wb4AgDbMrCYd9rvCRhC7dBC9naQEAg+N5nxf63yNZdeS+TObWvDEBKtEsmAry/Ea+Bixq3uEA0HZFFKKvaTeovsStDjYT30fcz5v0SbEUa6nZqmY5PrkvBeJfOmF3Hm4zpfq9jh6ga981xjmwx/Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783094591; c=relaxed/simple;
	bh=bXcKhhfsL6UgsrMldjAdCtahG3ljcsAHiMdc+1+DceU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KRcI1A0WupjdXdUj3pM9kY7hWwzhPmez/q6PbXQq7accdol+/oCsvbk2qaxJ/rY6ubiMK9O833HLEir7c0fLzfi1cRIsNayJiOE3PUPG/a8mR8K3e0VM6CPECeZSl41n05Ir2mOcr1rAfwr2r1XOZCuL5Mo8FqON5JIiI66Ogb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhefmiM0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B9E1F000E9;
	Fri,  3 Jul 2026 16:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783094589;
	bh=m3SMrN8TM9wj4tMHjI+jT3uwvFujpNyluzX7JN24lg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mhefmiM0/Smw0hFxf9rUBN6+rAeIOHHBuj99G+oRbsehzJWU4kSVrnKt9NOf0VLZy
	 tsrXZeOyvQp34GpSj2yvvsWxTk09sX0h1dWUKqAjDUcCnKJtidTo67othhBURwpIkO
	 /OmOUfsG2P6ZMC3WYOmmpjuQzzUQd/QPsDITxe2MvdirH0ZbZbl2BJSeR1hbHUqrWb
	 VD3bYTfMEMDMk9Etq7ldWzRnRpnGYIWjUF2uW3a7CrDPPjhjzjLd8j80PrPJbY0x/f
	 J9Pri+ZvbQ1wm8Z6Zm5a/B5jGBPgaOKxWhHyng9yUKmrA9SpzIkfgLhk/jpG8BtdHc
	 a3CCZzbEK1+AQ==
From: Chuck Lever <cel@kernel.org>
To: Wolfgang Walter <linux@stwm.de>
Cc: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff Layton <jlayton@kernel.org>,
	Alexandr Alexandrov <alexandr.alexandrov@oracle.com>,
	Yang Erkun <yangerkun@huawei.com>,
	linux-nfs@vger.kernel.org
Subject: Re: 6.18.37 has problems with nfs4 (server), 6.18.36 works
Date: Fri,  3 Jul 2026 12:03:05 -0400
Message-ID: <20260703160306.1651327-1-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <114a396bac4fc5e1aa730ea58d59a78f@stwm.de>
References: 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linux@stwm.de,m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:jlayton@kernel.org,m:alexandr.alexandrov@oracle.com,m:yangerkun@huawei.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22974-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E6A0E70424A

Hi Wolfgang, and stable@ --=0D
=0D
Short version for stable@: 6.18.37 does not need a revert of=0D
95f9eb19d5e6 ("Revert 'NFSD: Defer sub-object cleanup in export=0D
put callbacks'").  That commit is correct for 6.18, and it is=0D
not the cause of Wolfgang's crash.  Please leave it in place.=0D
=0D
The reasoning: 95f9eb19d5e6 touches only fs/nfsd/export.c,=0D
export.h, and nfsctl.c.  Wolfgang's oops is in=0D
remove_blocked_locks() -> __destroy_client() ->=0D
nfsd4_destroy_clientid(), entirely within fs/nfsd/nfs4state.c,=0D
which the revert does not modify.  That path is byte-for-byte=0D
identical across 6.18.36, 6.18.37, and current mainline, so the=0D
revert cannot have introduced the bug and no missing backport=0D
repairs it.  The 6.18.36-good / 6.18.37-bad split is a timing=0D
coincidence; I believe the same latent bug is present in both.=0D
=0D
Because the defect is present upstream as well, the fix belongs=0D
in mainline first and is then backported to 6.18.y and the other=0D
affected trees.=0D
=0D
Wolfgang - to confirm this and capture the allocation and free=0D
stacks, a KASAN-enabled kernel would settle it.  On a v6.18.37=0D
tree:=0D
=0D
  1. Add to your .config (keep your usual CONFIG_DEBUG_INFO so=0D
     symbols resolve):=0D
=0D
       CONFIG_KASAN=3Dy=0D
       CONFIG_KASAN_GENERIC=3Dy=0D
       CONFIG_KASAN_INLINE=3Dy=0D
       CONFIG_STACKTRACE=3Dy=0D
=0D
  2. Build and boot that kernel.  Stay on 6.18.37 -- you do not=0D
     need the revert-the-revert build I suggested earlier; that=0D
     experiment no longer tells us anything.=0D
=0D
  3. When it trips, KASAN prints a "BUG: KASAN: use-after-free"=0D
     report with "Allocated by" and "Freed by" call stacks.=0D
     That report, in full, is what I need -- it should land in=0D
     /var/log/messages just as the last oops did.=0D
=0D
One caveat: KASAN roughly doubles memory use and adds CPU cost,=0D
so weigh that before running it on the production server.  If=0D
that is not practical, a full log from the first stall line=0D
onward, with all CPU backtraces, captured over netconsole or=0D
serial, is a useful second best.=0D
=0D
I will draft a candidate upstream fix from the analysis so far=0D
and send it separately.  If KASAN on the production box is not=0D
an option, testing that patch may be the least disruptive way=0D
to confirm.=0D
=0D
Thanks for the careful report and the bisect.=0D
=0D
Chuck=0D

