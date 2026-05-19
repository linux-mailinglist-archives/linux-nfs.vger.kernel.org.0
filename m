Return-Path: <linux-nfs+bounces-21719-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFtJHibeDGrdpAUAu9opvQ
	(envelope-from <linux-nfs+bounces-21719-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 00:03:18 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3309D585695
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 00:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 771A730873EC
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 22:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0C03ECBD4;
	Tue, 19 May 2026 22:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Z7+zKGTl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58FB3EBF35
	for <linux-nfs@vger.kernel.org>; Tue, 19 May 2026 22:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779228132; cv=none; b=o8AB92fSLdHwa51v5iNE7JmNyZwZYBX0J7hLcZNZiGwGzpL31XqmnsD2pgDFfJRGbquFECDVUu+JwDnSM0q20snGj1d1BX1Z11qUUk5O6p0yRJrNNIvMVtoq8P5zabSlwafI6yg6jZRL0PQLjxv5Ddu4NPjC108QqQYwrlTLiHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779228132; c=relaxed/simple;
	bh=yIJXP1+g/Qa6pkdZsSMJhPb3QD52cBd39eqPJhcbq7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gcUxkpZK4sgLdPscUNJ10vFuCnD3nqodadzqJOAHXXsg0SLLDAtuNfZNdCTkDI7Vt5UCKaKK+VTQ0LhyPbzLHHZcbwtTkmSngvfesQqvYLTquWQuitLrWxrKMD5cO+LtCDj9ZFdIPbU0JQCugCD7fMrI9A+/eMIzFI8pypBmK4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=fail smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Z7+zKGTl; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammerspace.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e363c6141dso3464797a34.2
        for <linux-nfs@vger.kernel.org>; Tue, 19 May 2026 15:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1779228129; x=1779832929; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1nEOkDwc0PIzW3onJMi+pZwO/mWFgV8LYiM5Abf16GU=;
        b=Z7+zKGTl2bXIxu0ZuM+/SM2WjiU5gC3bYiZIS8lA8PgyLFfiC2kGAoZo1j30a39XCT
         HaFePYOz6ZCq7pKAnt7+kgOwwO7CiHkkMrL4dkXKXqZ55VgHhTTv1mUosRDuFnwC3ZUq
         ZrcGVv3tIu24EjzAz43nQ99ZFAEAcpsiBp4hmZKvs+pEHKRcWHMLJ7lGf1eVfxPIRxsD
         vMPQjD2ixlPvynOUJnBHkVJeT7dmAQWw1gGcoBiIUEzEYGgiNKJ+EscxJKv7J+rYus5u
         6SDqpRsZ0xIfG3oUF1P7gQhSR0AkDcJeCnJGzFimZpI+gHDvl6EFPAk79xpGlJBbzCQC
         DqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779228129; x=1779832929;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1nEOkDwc0PIzW3onJMi+pZwO/mWFgV8LYiM5Abf16GU=;
        b=GnR16T3hhlM4EXQFS1K6rWKxDSU+P42GLJR/gLhi9gaFpsBTPPJ8mvSw0h3Zz1Dcsr
         SO/+a2p2BYrnQcxSwN77vS5QpgZRgEuFMYQBOZJYgV+5uDO8UlPvz1tblldr1cHEuBsk
         3DY0kgihCXRQEQjFhX+e5a8JSQbOnvPXWH+8/lIRYHjL0OZcgPj4WGK8g147AMFxAMbi
         DYl36Tee/om2QF1Ls+SQ49B3Zli3oS4f0A4dkq/1FK4UihVUfxABGhKl6ySBfY9r9tpk
         V/l/A0ZK67MksAuNYUESN7Vsy6pt0R68n5kFpT6s5Ql93Wcf99vPG6nuu48CT147VF7C
         g2XA==
X-Forwarded-Encrypted: i=1; AFNElJ/9WGVnEaoX6d4P6cuWY7JpP/6JA6zu3Pst4CrLEYsGMJiN6u2Tu/W/DeNaC/C20PA7hRwRHrz0AGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUPCI2NbDs0h3vzIvRausZQ8k9llkz9s/aSxKRrUy2Pe6P+Tv0
	PYcHQfkJq7tIYOlDkBvQjxquM2QacsIXqCvHdTZqnIMT/D/8vzHx+dMmORnYE8xBhXJ4qAJTKu1
	/4Xvq
X-Gm-Gg: Acq92OFA0BoYdMEMwmves5cKoWvRi2W9IGy3V0oxj0PrDr27sMmABjH0uig/uHNLzXO
	m3Og6KHcckMoZwfULLAEUpwnIYSt5wnpMpo02ADwjaH85XapUoPJHonGRILbVDUa4DahE5khFc4
	O96eDS9R9pkEoN76SMfKqtzuzyJVLa/Mla7iWHwMKeLY0F9nPhv5NkLL7nrluzC0KCCqYclqHiz
	okwMJ8akUVUi2C68yw26KpwLgF89qX9KwtZA78BKpcFTWSJV/AZyTe+5sDyC7DUABUYx2/AsROP
	s/tsAMKVRZLkA3LVSvxGpVW1dCEJynq0wIzXX3VJN9MnV7pOmz26yXIp5L0+i5IsYZs5AySGUaS
	PXMV0PpyE6Vfd954gLrxfLQS5PEBke6vUq+fMpsOPeVhlGvEqn65q4ue4bc958UyptAej/Xzo4E
	qotigEM8wWpWIQ7RHNpzGC2kA4xfuR+0ipCJIzjRKGEqJd9awEvpveBI6n
X-Received: by 2002:a05:6830:d11:b0:7d7:4002:1f21 with SMTP id 46e09a7af769-7e4f2b6c3a7mr14364060a34.20.1779228129054;
        Tue, 19 May 2026 15:02:09 -0700 (PDT)
Received: from [192.168.254.51] ([12.117.181.174])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55bc4b0adsm11174784a34.25.2026.05.19.15.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 15:02:08 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>
Cc: Benjamin Coddington <ben.coddington@hammerspace.com>,
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neilb@suse.de>,
 linux-nfs@vger.kernel.org
Subject: Re: [RFC] knfsd: per-client fair scheduling to prevent single-client
 starvation
Date: Tue, 19 May 2026 15:02:06 -0700
X-Mailer: MailMate (2.0r6272)
Message-ID: <AED22AED-E97D-40E3-9839-BF8307EF8B65@hammerspace.com>
In-Reply-To: <4c5dbb98-0209-4572-8eac-1578536bbd78@app.fastmail.com>
References: <D33770A1-9098-4F1A-93EF-590E6C0B7638@hammerspace.com>
 <473e337b-fabc-4884-a6c4-0f04b6874d0b@app.fastmail.com>
 <3AB7EB6A-B207-4B91-A695-66C4704D0E31@hammerspace.com>
 <4c5dbb98-0209-4572-8eac-1578536bbd78@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21719-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3309D585695
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 19 May 2026, at 14:44, Chuck Lever wrote:

> On Tue, May 19, 2026, at 5:08 PM, Benjamin Coddington wrote:
>> Just to be clear - the issue I'm exploring isn't the same as when all the
>> kNFSD threads are slow due to their workload.  This is very much a
>> multi-client dynamic where one client (or a group of automated client
>> instances) are able to easily starve another simply because they create the
>> most connections.
>>
>> That's different from the other problem that we've discussed a bunch at
>> bakeathon and on the list previously.
>>
>> This is not so much a deadlock issue as it is an issue
>> of per-client fairness.  I think this problem is in a different class.
>
> Does dynamic svc thread creation have any impact?

I haven't tested it - I think it would just pin to max-threads for the
workload in question.

> If the issue is clients with multiple transports, wouldn't fairer
> request scheduling across transports help?

Do you mean, processing all requests in-order across all xprts?

I'm probably not understanding you here, because for the problem I'm
interested in fair would look like prioritizing each client's request
queue equally, no matter how many xprts each client has.

Ben

