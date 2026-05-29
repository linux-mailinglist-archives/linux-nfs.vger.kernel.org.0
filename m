Return-Path: <linux-nfs+bounces-22079-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFReKsTLGWqNzAgAu9opvQ
	(envelope-from <linux-nfs+bounces-22079-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 19:24:20 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 562B1606625
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 19:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73C33324789F
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 16:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3573DE45C;
	Fri, 29 May 2026 16:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="XYKTBxS6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4F23C1985
	for <linux-nfs@vger.kernel.org>; Fri, 29 May 2026 16:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780071726; cv=none; b=DVaLSHWvmsdLBuQkNgeqEnSmP+NSVGMW1Bt+hX7KixWpIBqzCGDsZZ0v6E0VgOTMHElxd1xc+cRM27IEiRkz9urs5hlKiZPUOaiGDTUly4CcySTjeI14pECJ+vguPFNjqQsFK9S+oRTUubyZ/tiltpnvUs7zIk5++S9yiaKMCqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780071726; c=relaxed/simple;
	bh=A//8YORdov1M38vppcvtRu1emIm/9LLZtiexYw+Nklg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mUR4KgJ1jEv1xQPmcfSSdfLdToTOQDCJlE7sXfYeGpmUKEzTw+zd/8o6Jfq+2KnpWp/0/5yB+45NC/YbHHK9WYEn2IhIOShEjRbOBQoW1S/h2ZxtkBJUfc2TKC060Jw4qliOhWieOzdJOKB+cU34o6EeM8fVxPyi9ukzCU/L+Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=fail smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=XYKTBxS6; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammerspace.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7e61b59e03eso5099855a34.2
        for <linux-nfs@vger.kernel.org>; Fri, 29 May 2026 09:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1780071724; x=1780676524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2nqJnI5wzssMpalCg/FWhKkfDIw5nT9JhWq9LM/O78=;
        b=XYKTBxS6L91m3wZQmRy7o/BNwTevqz2LLbrMZDKCSG5Cg8ZbwND56u0bNMFQVs0SLk
         TDr14g9KCDuqNSQBxiXKINlK8eyotqqxJKRgsi04tqh4QY/32JZQnEb1HcuaEWg7x3vq
         ueqpiLBlS2r0I/qGmbw0bQ86F3//f3JUFmAUb+Ch/ZnCsCBRLPMjX7DW/Fj9hZuMjYMq
         aRUUxGL5uiGZbcdX+xBDZkAnP/O/KViZEaHUhSzaOXD0U7cyc93uGZr3V9Qzgh6qsO0c
         nQuAYBtkijstQbcf7Loy6osslf1UMr8D4m9TMHiEhzV7m7d7pq8Wn2c9LG1kPM0/r7LG
         aZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780071724; x=1780676524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x2nqJnI5wzssMpalCg/FWhKkfDIw5nT9JhWq9LM/O78=;
        b=AcS+6wUFucA8FIbX6yUwlh+0C8tiCV35gBuAD3vqNDCtvINfclHTYYcr8WtXKeHog9
         Z8f0hxueJ1Lusc13jEPZGUMkH2nYOIHGf0HhC10PNA7z2RAKXAJYnPJJnQ27x7TxSXKB
         HlVv+BdSgCalC1zogNyxSQCagpLnwtbAo53xq9tu08z2lWN0csjazTDejYKipPz6AP7h
         w+wPxhaue3luHNhoPNvI7NxzaMjnt3bwQA64fmDhI3Kg/n/gimheQlhfW2LNyRKQVlhN
         uwBBATXwvirDjP0HjXl+BZvWIqeu+Z1zK7vEd0t+J/ZrEL8dHB0raO9tbnTFoq0eGgv2
         cMOQ==
X-Forwarded-Encrypted: i=1; AFNElJ/NVIZId7Pe65P3jbiRhexQtqJsl3VSN2+5dfPSrz2BjUDHPVP0cfO04If9jIvgybWlu/+EOJZkc4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs5pSSvsy4nd3PVk1ZAbZWqfCsaAe7aEXYdjZeYwutBWaIdvsb
	IiLpQ3++f5aBYD1T5MSBG5a8X4uARRq+/Tvfpu4KGjwXQIf/keg0sLIRnDmuWg3n3J4=
X-Gm-Gg: Acq92OEfRpWRraQIu8wABKXb+079OTrmH0jQl41oP3XMwB/mD2hSmRVMO35fg1mSE++
	WwB5nrQ5XafSt5/YgzAI1sYjbPA36DVeACUcTRlhmeP0ijpM4cR4t8ZU7WEJNejrybnyNzngoq8
	J6X2prU/qSR+piQ0kCFjTxuocqbR8h9qAHJSvrKqA2bC49tRiQP/KxxeAT4aSA0eCA0wLiTclLf
	OHE4VCUkkmxcI+mR0MC6X/6Wcneq1Z6xVYXkf3fEPGPa96ta6cT9e791js07Z+280nI7l8DLuFY
	r195uz4yrGmGRH1jDh6IP3xMnLEfeX48re5XsbbQdoUE2L+jnF8osEIqdFspreiBUeFTW81hxuV
	iV77FCXLsGMr5Bq4bx1qVmKq1MBkGIH87+6+sgBiqqbUD0H2xzqVNes9wv/Q7h5ry1Dm0UHU1iH
	rpfagQPhCIEbMyfDDlmLp/7tH94D9DB2TQbqWb4/mMcb5vQs2Dyg09GeSlNeKtWtrk
X-Received: by 2002:a05:6830:6386:b0:7dc:df37:844b with SMTP id 46e09a7af769-7e6a1c4cf1dmr420459a34.4.1780071724482;
        Fri, 29 May 2026 09:22:04 -0700 (PDT)
Received: from [192.168.254.51] ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e695d178b6sm1881203a34.15.2026.05.29.09.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 09:22:04 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Trond Myklebust <trondmy@kernel.org>
Cc: Benjamin Coddington <ben.coddington@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] nfs: return a write delegation when a SETATTR drops
 our write access
Date: Fri, 29 May 2026 12:22:02 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <32A38159-77F7-41CC-9567-2089531D05F1@hammerspace.com>
In-Reply-To: <461703b49f85216f6f6b18656e290287b0f701a0.camel@kernel.org>
References: <cover.1779995818.git.bcodding@hammerspace.com>
 <64a9c99c387432399b4c4d9ce6dd4836b0170c15.1779995818.git.bcodding@hammerspace.com>
 <461703b49f85216f6f6b18656e290287b0f701a0.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22079-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 562B1606625
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 29 May 2026, at 10:00, Trond Myklebust wrote:
>
> Hmmm... I'd argue that while recalling the delegation in this case is
> mandatory for NFSv4.0, that is certainly not true for NFSv4.1.
>
> Furthermore, I'd argue that if the holder of a write delegation is just
> changing the mode, then that should never result in a delegation recall
> for a well written NFSv4.1 server. The reason is this does not impact
> the client's ability to cache data, metadata or lock state. It only
> impacts its ability to rely on previously cached access data when
> handling new opens.
>
> One can argue whether or not it's needed for a uid or gid change by
> said holder of the delegation, but there too I'd say the right
> behaviour is to err on the side of not recalling.
> The exception might be if this is an attribute delegation, and the
> result will be that the cred attached to the delegation will no longer
> be able to issue a SETATTR to update the atime/mtime on delegation
> return.
>
> So yes to pre-emptive invalidation of the access cache, but I'm very
> sceptical to actually pre-emptively returning the delegation or even
> the layouts.

The latency I was chasing comes from the server electing to recall on these
SETATTRs.

You're right that for v4.1 the mode change doesn't need to trigger a recall,
and that the only client-side exposure is stale cached access on subsequent
opens.  It's already covered in the SETATTR reply path changing mode/uid/gid
where it sets NFS_INO_INVALID_ACCESS in nfs_update_inode(), and a fresh open
over the delegation still goes through nfs_may_open() -> nfs_do_access(), so
it revalidates with the server rather than trusting the cached result.

The server isn't recalling these for cache coherence.  When the change
removes the holder's write, a later SETATTR(size) under the delegation
carries the delegation stateid, not an open stateid
(nfs4_copy_delegation_stateid()), and the client can reopen O_WRONLY from
the delegation with no OPEN on the wire — so the server can't tell whether
the holder still has the file open for write, nor apply the usual
"open-for-write overrides current mode" check for the truncate. The recall
forces a DELEGRETURN + CLAIM_DELEGATE_CUR reclaim that re-establishes a real
(or absent) open stateid, letting the server decide the truncate correctly.

For write-retaining SETATTRs none of that applies and the server shouldn't
recall — which is where the latency I was chasing actually came from, and
the better place to remove it.

Thanks for the review.

Ben

