Return-Path: <linux-nfs+bounces-21979-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJk5EzfJFWqMbAcAu9opvQ
	(envelope-from <linux-nfs+bounces-21979-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 18:24:23 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4355D99D0
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 18:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D39C43016B0E
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 16:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD3D3AF64E;
	Tue, 26 May 2026 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="O7zCQlUv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2773AEB35
	for <linux-nfs@vger.kernel.org>; Tue, 26 May 2026 16:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811992; cv=none; b=NqLNvCCsKu7qsvpo5vtlEHQAPCYkt5bhb5b4ZDT3K7e+M/gM/2ghvmW6PJfBI7WrqfkhDytFwDxhiCmIoQvFnCEHAycOwe23h+4ngV0iXbhRLW3wB6QS0FGOPD92RNyjHii6g/oW63p+Xdd/v9qiCdWDt3nal7hpgfeE2Y/pmkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811992; c=relaxed/simple;
	bh=q9OuikpD/Inp42vzTaQlKskrPH0X1jOg/4aXpBfaSTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E5z/iDZwYFzcgs8vW9z8ZeC2eL551xHXy2YZVHEpB5QEk1DFekaNwYTT1hJGdPc6O4qNIXYUNM/BzZliw6Zc7WdrFE1RkNvUDM+mCzOqp+KdlJTxACjeL8PtfmGHpZ2yxmKdfxEpl9jgzNfwdAmkUopwMcYcd0r0hkFWQnOBhyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=fail smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=O7zCQlUv; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammerspace.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-43bfe055ffbso691884fac.1
        for <linux-nfs@vger.kernel.org>; Tue, 26 May 2026 09:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1779811989; x=1780416789; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PHQm0c+L63bwLd4vnWq1Y5D6JzPfB9sA/CrtLUjqy6U=;
        b=O7zCQlUvtkvhBHg3Md5Y4xoCyaALzH+AxW+R2pdQfM/955laqG4dO0ozgnvsGAkxRX
         svvRjecln8D59oZUnylMvbJr1g3gcTkz1gOnvfijFsymF6r1W6mFp/rI1PgqZzYPXq4O
         PrzC2hX4q5WuqIcOAjS8dWUodTNyFBjWl2XWegyMYrYTbc3ZuTTilyb40RfkoBp1zc7j
         O3dAOVQyjMR8nEk0IID+ZDEctdpa3saCUPjFbQ6+spZIqBx5oQDagIBIFLS5TytEkcJS
         G5eDOA3M5TAa9e3VnMkNKhvRTxISfmja7bCN0DmGj4wRk2gQP1gyvS5YIodm0Q9hCWOR
         q7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779811989; x=1780416789;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PHQm0c+L63bwLd4vnWq1Y5D6JzPfB9sA/CrtLUjqy6U=;
        b=MHTszm+H6u2zURXxMZGV6yQ+w3in39HcP42Xdm7pgGo+/Fxx/FYO72eSfjTc1bPfF0
         pKazs/GEwUsX8M6MLvHyTqUEoV7RlsSWm0QhX9qhxjxdo15Lb5KYcwfHK+2/BVTHJVTd
         fTw07ww0yY+vYi8L+1TKP4Z/EdL6iwjDRLzthySbkTEqMgwqeanEv16Az6lMKumPrpRH
         G9wRi4NZEQ3koe2KArRZFDYzBNQbEfhSCg5eZfGiH/h7DzxvEjywM+7vc4Me3+1iBACI
         rQStfA8azPYIfmDzdpfKlyyCTQgTyqYObad3WeDW9geMuzpe5wZlQ6qasH6usltqO9TM
         ++zQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Zpt+/W7dU97C8jkcaqdvVb3N+VFTjNIL/fIewlEKaUDeUKmz5UBLNu842Q0YiyO8XCy0yhB0XSmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwU3mMoYLBMe03MPVEHtde/w7tbetjYfvpoK1c7ieapwmIycgc
	XK8quY3P71OdsMn4Lc7NdEsYwfyIPEqRwmUj3jBkyORmF5rQGbp/qAfcyE7LFsVsUoY=
X-Gm-Gg: Acq92OFRvhpZ/v40HZrkp2EuYJ8GYoxRKykq5KT/I9faOqzTLuCDyDfWyX4a02rSqMh
	p4gJV3tVUVXWxhiQmnuaS30NnodF5rHiDywF3ozCe5ZSE4uicYqCLA4OxBlLc/lcVisezEmEz2q
	T8JVJUYfQxyf+4S5suuazCQKzSN9E3i02ur3YXxPxhuN1qnGZRVxM8gEcJejf6Tr2F3FB0AnaEP
	hR6Aoz5kTTtP56xRAkyHPvykncVe1FBE0uROXVlWOXuEVU19c2nt6HsJ3oN2hirUFcV/WUBjBjz
	89oNJjxMKk5URc2q5BFqm0Z5jZT4Q3cJ9mIQgF3DpN2cKf3hajwrOwE13eZ+gE14Vi873wJsDCx
	1+fMgRvMuwVrTsj6pT3oPA9cPRYA2y2KlZRThClu9SAQUCN930tWVLRZapVAH2JhYjrZRKLZv99
	Ap/uNWmwiJfvK/IfXnE6iDoE48Noo3Z3E4gnco0Cg5wC3GDmdWhnYPNg==
X-Received: by 2002:a05:6870:56a7:b0:41c:25b1:930f with SMTP id 586e51a60fabf-43b5ad58b18mr10721888fac.19.1779811988710;
        Tue, 26 May 2026 09:13:08 -0700 (PDT)
Received: from [192.168.254.51] ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b639725a5sm13595022fac.10.2026.05.26.09.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 09:13:07 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>
Cc: Benjamin Coddington <ben.coddington@hammerspace.com>,
 Steve Dickson <steved@redhat.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 0/1] nfs-utils: nfs-fh-verify signed filehandles
Date: Tue, 26 May 2026 12:13:06 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <AD463C85-473C-4205-9ACF-6573C908B078@hammerspace.com>
In-Reply-To: <19045a48-ac02-4c05-be05-a88e7a129b6d@app.fastmail.com>
References: <cover.1779805943.git.bcodding@hammerspace.com>
 <19045a48-ac02-4c05-be05-a88e7a129b6d@app.fastmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21979-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,hammerspace.com:mid,hammerspace.com:dkim]
X-Rspamd-Queue-Id: DE4355D99D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26 May 2026, at 11:37, Chuck Lever wrote:

> On Tue, May 26, 2026, at 10:40 AM, Benjamin Coddington wrote:
>> We've had a lot of folks configure signed filehandles, and then wonder "Is
>> this thing actually working?".
>
> Do you know if wireshark might be able to handle this verification instead?
> It might be quite useful to see a "FH Verified" on every RPC in a network
> capture.

Great idea - I'm sure it would be able to do so.  If we ever change the way
we hash the fh-key-file in nfs-utils, we'd have a wireshark drift problem.
But, its unlikely we'd change it in nfs-utils and trash everyone's existing
filehandles.

We'd have to build an interface to point it at the fh-key-file of course -
would that constant reconfiguration in wireshark make it less useful than
this utility?

I have a slight preference for this tool in the near-term because it
immediately solves my problem rather than having to wait for distros to
downstream wireshark work.

Ben

