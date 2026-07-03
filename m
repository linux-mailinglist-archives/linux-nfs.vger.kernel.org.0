Return-Path: <linux-nfs+bounces-22965-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /OBNJlwyR2qoUAAAu9opvQ
	(envelope-from <linux-nfs+bounces-22965-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Jul 2026 05:54:04 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E95F46FE468
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Jul 2026 05:54:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=synology.com header.s=123 header.b=kVW4nHAt;
	dmarc=pass (policy=quarantine) header.from=synology.com;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22965-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22965-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE0573044F1C
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jul 2026 03:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17A9313E15;
	Fri,  3 Jul 2026 03:54:01 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71E230C17A
	for <linux-nfs@vger.kernel.org>; Fri,  3 Jul 2026 03:53:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783050841; cv=none; b=QN59xE1iAQWfKiss6Va9XHlxqtbZ71N35tMRTcAv+uTM1G/ql4JOfZdTVBN1R4b/2UMIvnnVJeWw4fY4ekC7UBO/CLpGaQ+bQGvwdC9552oDiy4a4DcfwiaVsjF0ePuXodbT1xZek2Q3IKo73KKdsO0Labz39LJ8OEAejxwYNz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783050841; c=relaxed/simple;
	bh=n8T9SRtKWBTd3qClblHvOUAaIkV5ziDlPY9OPfR8QM0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qVTTDhl+l0bhMGVvuftHlAcZQGWv1g/m5FsFdUwh+4S5oLzjxoagUtIM/v8eRgGkSHuDbUT5JRPviVoFYg/mRV1Q28jvcGLu0XrfWyw0oFHh1ODyEW1HCdjd94j5/KYq+vVPtX8/afU4RwjDghK3Gy73GW7eKTgtExDQDVqfsWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com; spf=pass smtp.mailfrom=synology.com; dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b=kVW4nHAt; arc=none smtp.client-ip=211.23.38.101
Received: from vbm-oscarou.. (unknown [10.17.211.167])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.synology.com (Postfix) with ESMTPSA id 4gs0Gv10XGzKRM2mm;
	Fri, 03 Jul 2026 11:53:43 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synology.com;
	s=123; t=1783050823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c1AdcXrOnfoLkElHrBK10r3wTJyroaU0FGE2v2ADLo0=;
	b=kVW4nHAtvLlYc7tKO+QBtU840DkpMHKGfrFcq9Na/imWwn+o8mx8kZoCO6EdlCzrV0ZuQQ
	jbSwHXus6k40prv5NlnATSKO5wL1DyivsvdRpzyvYurKq1IT+A2u7dY5kccQGSec8AAIhZ
	E14b+flgxfPc2CF7Oo1LkKB7FzfQy8Q=
From: Oscar Ou <oscarou@synology.com>
To: cel@kernel.org
Cc: jlayton@kernel.org,
	linux-nfs@vger.kernel.org,
	oscarou@synology.com
Subject: Re: [PATCH v2] lockd: refcount NLM_SHARE access/deny modes
Date: Fri,  3 Jul 2026 11:53:31 +0800
Message-Id: <20260703035331.2414135-1-oscarou@synology.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <bdce0570-b584-444b-b78e-a5a2cc5b85ad@app.fastmail.com>
References: <bdce0570-b584-444b-b78e-a5a2cc5b85ad@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Spam-Flag: no
X-Synology-Virus-Status: no
X-Synology-MCP-Status: no
X-Synology-Auth: pass
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[synology.com,quarantine];
	R_DKIM_ALLOW(-0.20)[synology.com:s=123];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22965-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[oscarou@synology.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:jlayton@kernel.org,m:linux-nfs@vger.kernel.org,m:oscarou@synology.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[synology.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oscarou@synology.com,linux-nfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E95F46FE468

On Wed, Jul 01, 2026 at 09:40:46AM -0400, Chuck Lever wrote:
> 1. New thread per revision — no In-Reply-To: back to the
>    old version.
> [...]
> 2. Version the subject tag, not RESEND. [PATCH v2],
>    [PATCH v2 01/27] (lines 716–719, 726–731). RESEND is
>    only for re-sending an /unchanged/ series that got no
>    response (lines 379–380) — a modified series is never
>    RESEND.

Understood, thanks -- v3 will go out as its own top-level
thread with a [PATCH v3] subject.

> With the per-value refcount a replayed SHARE instead increments the
> bucket a second time.  Over UDP a lost reply followed by a client
> retransmit reaches nlmsvc_share_file() twice for one open, and if the
> client then sends one matching UNSHARE:
>
>     SHARE(access=RW, deny=W)              -> s_access_counts[3] = 1
>     SHARE(access=RW, deny=W) (retransmit) -> s_access_counts[3] = 2
>     UNSHARE(access=RW, deny=W)            -> s_access_counts[3] = 1
>
> nlm_recompute_share() still sees s_access_counts[3] > 0, so s_access
> stays non-zero and the entry is never freed.  Can this leave a stale
> share reservation that denies later conflicting opens until the host is
> torn down?

Yes.  The inflated bucket only drains via the client's own
UNSHAREs or a FREE_ALL / SM_NOTIFY teardown, so until then
conflicting SHAREs from other owners see a spurious
NLM_LCK_DENIED.

> Here the client still holds open #2, but its reservation is gone, so a
> conflicting open from another owner would now be granted.  Can a
> retransmitted UNSHARE release a grant the client still holds?

Agreed -- the UNSHARE retransmit should have been a no-op, but
v2 decrements a second time and releases a share the client
still holds.

> Taken together, is there a way to keep SHARE and UNSHARE idempotent
> under retransmission, some per-open identity to match on rather than a
> bare count, so a duplicated request lands on the same state the way the
> other NLM procedures do?
>
> One direction would be to track the set of held (access, deny)
> combinations rather than a count of each.
> [...]
> Setting or clearing a bit is idempotent, so a replayed SHARE or UNSHARE
> lands on the same mask, while distinct (access, deny) opens from one
> owner are still tracked separately.

Agreed -- that lines up with the invariant the other NLM handlers
rely on, and it's the shape I'll use for v3.  Concretely:

    #define LOCKD_FSH_BIT(a, d)  BIT(((a) << 2) | (d))

    SHARE:   share->s_held_mask |=  LOCKD_FSH_BIT(access, mode);
    UNSHARE: share->s_held_mask &= ~LOCKD_FSH_BIT(access, mode);

s_access / s_mode are recomputed as the union of (i >> 2) / (i & 3)
over the set bits, and the entry is freed once s_held_mask is zero.
Both ops become an idempotent bit set/clear, so retransmits land
on the same state.

> The tradeoff is that two opens with the identical (access, deny) pair
> collapse to one bit, so a count of duplicate identical opens is lost.
> RFC 1813 defines SHARE and UNSHARE but does not require that repeated
> identical SHAREs from one owner survive an equal number of UNSHAREs
> [...]
> Does that match your reading?

Yes.  RFC 1813 is silent on repeat semantics for SHARE / UNSHARE,
and section 4.5 explicitly treats non-idempotent requests as
something a reply cache has to protect, which lockd doesn't run
for NLM.  So collapsing identical (access, deny) opens from one
owner into a single bit stays inside the protocol, and it buys
back the idempotency the other NLM handlers already assume.

> The bottom line is that after more consideration, IMO the reference
> count approach is not going to work, in particular because NLM still
> operates on unreliable network transports like UDP. Consider the
> above direction not as a mandate but as a possible approach that
> might address the issue you've reported while avoiding introducing
> non-idempotency.

Adopting the held-mask direction.  v3 shortly, as a new top-level
thread.

Thanks,
Oscar

Disclaimer: The contents of this e-mail message and any attachments are confidential and are intended solely for addressee. The information may also be legally privileged. This transmission is sent in trust, for the sole purpose of delivery to the intended recipient. If you have received this transmission in error, any use, reproduction or dissemination of this transmission is strictly prohibited. If you are not the intended recipient, please immediately notify the sender by reply e-mail or phone and delete this message and its attachments, if any.

