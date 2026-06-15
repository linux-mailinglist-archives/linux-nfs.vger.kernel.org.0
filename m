Return-Path: <linux-nfs+bounces-22562-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LNFkKdZAMGrTQQUAu9opvQ
	(envelope-from <linux-nfs+bounces-22562-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jun 2026 20:13:42 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBE76891A9
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jun 2026 20:13:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hammerspace.com header.s=google header.b="D+/+jKSw";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22562-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22562-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=hammerspace.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E87A63037D5C
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jun 2026 18:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEE22F8EBE;
	Mon, 15 Jun 2026 18:12:10 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFD72EA171
	for <linux-nfs@vger.kernel.org>; Mon, 15 Jun 2026 18:12:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781547130; cv=none; b=FxTySB05+w9mf9jelwZ3qjz3bRYAAkKzrjmtMQ+H9YH5VNkbZJph3ygl1jzcg/EPoh5JMHCKEyPsx6sKiYDc2lu4JI85+mmINOalLIo6LgQ8kRvFoaGvXxmppN4aWPX4L/wl79+AspL7nAfRFOp2518sVm5CsyFV7TJCcfpvm0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781547130; c=relaxed/simple;
	bh=FnPXZb0OG3NNS/wAluhv7FOJCeBstFRvxB3OuI04YUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=knYe87nFoBSpsT2Vid0D2CEHnGS2tWlTC3qbIxzGEt/qH6hPeOoWJORcx706nJD/OzMOZhQlY+jRwQSbOYOvmROV8U4w7tz77zoVS/nWFRMvqfl6jjxu12nyQPB+U3BgLjU4G6ZjYFPmAVEwJOXQz34h60Pd+MgSPQwkka/PlI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=fail smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=D+/+jKSw; arc=none smtp.client-ip=209.85.210.46
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7e6128bd9b3so2076555a34.1
        for <linux-nfs@vger.kernel.org>; Mon, 15 Jun 2026 11:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1781547128; x=1782151928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCZ9F0XatAHNhxx9t9AaM4naxkoCtLahKtP/MNalTv8=;
        b=D+/+jKSwAzZ49gAdejrOMKndCrTHBaJGm1ca1G6NCpy3jZysHeOB/tdIXqOFTVQOeq
         BIaD7tXWy4gLXvNZfFzXUfZlAHVP82nsl6S1AFJ+kecRnCAFQh8HHv7TNhRkO1RK7zEX
         ZCdyr9nOaKYu+TltIWw8Cgzae+2WPyZ7v8TwTf59CvxxA5gHvCUgwn1Zs13KzamjiEIS
         9lQwH/RSe73R6pqAAR+0p+ezFSZ+vKDSv7IPf3LXIIF9CeIJQogZdK0JDDHxvM3jBtQr
         haOJ4RgB2UHDgO9PkmSsnmTCQpu5djBceLDNV0emXWL3noWNwwOeJsmUXyBdwXPe17Ek
         ihyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781547128; x=1782151928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MCZ9F0XatAHNhxx9t9AaM4naxkoCtLahKtP/MNalTv8=;
        b=oUylUUc/Z6IJZwyt4kOFQDmIK1AF/10BDcqBc4TT5D9ybCVsx0F5EFg+lILZyR5EjG
         j8ZbJCaddHgUwnGiUka5G0vrSTNy4joiZ+HPz+xiKMTPzEEaiZ5RRfFdDYFvkKemV7Qi
         1PzCHUJWX2WCG/DEJ1EmvqBZqpdjg6pvh3IeGT/2g0pSO8L5vVZD+fNZYTEWkq+Tvts1
         jBYYjkjr5EgcRCp/ocE6vnrzR1U+Ik4GmcGZWfrgKZrDWlsZCO8Gacjt+JZkPpCcSz7z
         GqyqROxx+TbdHOXyW46KcIL4hixGbjxjEXX7EwefvCoSRQvrMOdrbGZMEL5BrpQLlfj9
         oMEA==
X-Forwarded-Encrypted: i=1; AFNElJ9dc5VH6HJb/e5ak7tfBx+1UO/g1hNIg5OvzakHyY1riropFB8nOxfATWa2r0CWw/4As31KMbpv2Tw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6xIZl3MOe9twCVxKFopNAzZ+goLPQXW8vajWeplcm9503f3bx
	Rnz6199przX34G0NA42GcGwyWAEpC1rqQeDvkU028Ibkb4ql7c3ImE9PwQDddddNyns=
X-Gm-Gg: Acq92OEQy1bF/3G83cxf5jfxbr29aJR4F8guifT0EewvsUBUjcrausM+u/99M9aVU2j
	ZdtT/XNg8uXf/Oss1/Wps6evVAiz1y4n6ggKKzIWV0wkCikFP/2/vPvUgQl8TDFDAtXBCByCV/T
	xBgZTGPeG/3p4Fcp3di4JLJqLTGAzAvdf+CX88NtVeuBg9Zgsbu9PtFNIqH0KP9DNZ58lESIOmn
	8nPiW9Ue+QDo9adKzqVk+8nkiGs3/5u4v/5empCpoqtEuQDZTGmgltXOgD3py1p1j2746xKGL+P
	3z4XuhBSJQCevGT1yZ+m46ZbuUx0ah41+mHKrhXUP3qRl5I7IzIeMcFNxfZq5H8DA8/X7uTEDiN
	vKkRk1NE7d1/wkOR1GFzf/m6O5YsQo+0ar+tahr560zMxo7XkbwPmxpIX9ot43lthZXny1kESdP
	BAluG/Ntr3fhgCUQcZvciEhUiAAel0njvd2RxahXOg3REkzA==
X-Received: by 2002:a05:6830:7318:b0:7e6:ce35:4b11 with SMTP id 46e09a7af769-7e78e7cb8b0mr7888977a34.20.1781547127617;
        Mon, 15 Jun 2026 11:12:07 -0700 (PDT)
Received: from [192.168.37.1] ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f6dfaf4sm4788299a34.21.2026.06.15.11.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 11:12:06 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Jonathan Flynn <jonathan.flynn@hammerspace.com>,
 linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH 0/5] RFC: Stop NFSv4.1 slot-growth heuristic from
 rewarding busy clients
Date: Mon, 15 Jun 2026 14:12:05 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <D17494D7-20C8-4763-84B1-9B587B180A7A@hammerspace.com>
In-Reply-To: <20260610-nfsd-slot-growth-clamp-v1-0-7b966700df0b@kernel.org>
References: <20260610-nfsd-slot-growth-clamp-v1-0-7b966700df0b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22562-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:jonathan.flynn@hammerspace.com,m:linux-nfs@vger.kernel.org,m:chuck.lever@oracle.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5EBE76891A9

On 10 Jun 2026, at 21:58, Chuck Lever wrote:

> This series grew out of Ben Coddington's fair-queueing RFC and the
> discussion it prompted with Neil Brown: a single busy NFSv4.1 client,
> opening many connections against a large slot table, can keep enough
> requests in flight to monopolize the nfsd thread pool and starve its
> peers [1]. Where fair queueing itself belongs is still being worked
> out. One change, though, holds no matter which design wins -- the
> server should not actively widen the gap, and today it does.
>
> nfsd4_sequence() grows a session's slot table by 20% every time the
> client reaches its highest slot, so it hands the client already
> keeping the most threads busy a still larger table; one session can
> climb toward 2048 slots on a server with far fewer threads to run
> them. This series caps that growth where added slots stop buying
> concurrency, and leaves the dynamic-slot machinery otherwise intact.
>
> Two design points are worth checking against the diffs.
>
> The cap is per session, not per namespace, and deliberately so. A
> budget shared across a namespace's sessions breaks at the floor:
> every active session permanently holds slot 0, which the shrinker
> never reclaims, so once the session count alone reaches the thread
> ceiling those floors exhaust a shared budget and pin the one busy
> client small while the pool sits idle. Making that floor explicit is
> a self-contained accounting cleanup -- nfsd_total_target_slots gains
> the full-target meaning its name implies, and the never-reclaim-slot-0
> correction moves to the one place that reads it, the shrinker's count
> callback. Since a session cannot use another's slots, capping each
> independently against the ceiling is the natural choice.
>
> The ceiling is a sunrpc-owned quantity. Maximum sustainable
> concurrency is a property of svc_serv and svc_pool, so
> svc_serv_maxthreads() lives in sunrpc, and nfsd_nrthreads()'s
> open-coded sum is converted to it rather than nfsd carrying a second
> copy. It sums each pool's configured maximum, not the running thread
> count: nfsd sizes its pool dynamically, and gating on the live count
> would deny a client resuming from idle the slots it needs before the
> pool scales back up.
>
> This removes a perverse incentive; it is not slot admission control.
> A client still sizes its sessions at CREATE_SESSION, and per-client
> fairness against thread starvation belongs in the dispatch layer,
> where the larger discussion continues.
>
> [1] https://lore.kernel.org/linux-nfs/cover.1780498019.git.bcodding@ham=
merspace.com/
>
> ---
> Chuck Lever (5):
>       SUNRPC: Add svc_serv_maxthreads() to report the thread ceiling
>       NFSD: Count slot 0 in nfsd_total_target_slots
>       NFSD: Clean up documenting comment for reduce_session_slots()
>       NFSD: Document and rename the NFSv4.1 session slot shrinker callb=
acks
>       NFSD: Bound on-demand DRC slot growth by the thread ceiling
>
>  fs/nfsd/nfs4state.c        | 115 +++++++++++++++++++++++++++++++------=
--------
>  fs/nfsd/nfssvc.c           |  12 +++--
>  include/linux/sunrpc/svc.h |   1 +
>  net/sunrpc/svc.c           |  23 +++++++++
>  4 files changed, 113 insertions(+), 38 deletions(-)
> ---
> base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
> change-id: 20260610-nfsd-slot-growth-clamp-ca03e338678c

Nice!

Reviewed-by: Benjamin Coddington <bcodding@hammerspace.com>

I'm pretty late to review this, especially as it lands right in the same
zone I was exploring.  Sorry about that..

Do you want me to rebase the fair-queue series on top of this once it's i=
n
nfsd-testing and re-run the A/B through the harness with this as the
baseline?  Happy to follow up with a Tested-by.

The work I have yet to do on the fair-queue series is to show a prototype=
d
burst-allowance.

Ben

