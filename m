Return-Path: <linux-nfs+bounces-21724-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ADqMBsDDWoUsAUAu9opvQ
	(envelope-from <linux-nfs+bounces-21724-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 02:40:59 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C838586530
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 02:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 705413043F4B
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 00:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E4E20468E;
	Wed, 20 May 2026 00:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="lNPInx1Z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC801F78E6
	for <linux-nfs@vger.kernel.org>; Wed, 20 May 2026 00:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779237657; cv=none; b=XvRvCi0SY78Z1kShAVUgEHvSGsQQfPIaX4v6WLF5VcD0NQMhOgLTMjL2ysa/ho618FiSqE0uUaZnq7hqOgKBWlNxgjkLq9pzURWCa3OPZTSSwnEVR1rjf0ovcfuxMHrRlDvt6UzCwzrF6oKeA7jiv4tEdmyvA1zLpnO4u3QglvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779237657; c=relaxed/simple;
	bh=ajdLirsi8/ikyHz/+3HU4/HAzysWx4f1RxaThcPs75A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tbcgta1f6ZhwVP8WOcosAKTcEpvbOX5cSVzzlQfk5X5qP+Gzf6OxiWJkKFDV4fsb8uK3w55UbdV3TNJOlePRKIMkgr4yCIn6bMmXwIuBF1Vco8OoTSNQMRz0kJ1fGIyNy+EhAsUw1A+nFL7Q6Krq82HloysJc/mqwv6RtmB306Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=fail smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=lNPInx1Z; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammerspace.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7dcdaf06498so2850621a34.2
        for <linux-nfs@vger.kernel.org>; Tue, 19 May 2026 17:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1779237654; x=1779842454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GsV/qcAAOGKFq6oLLbKHL8j78k9PSthmCVRCsEtT74Q=;
        b=lNPInx1ZOtnEG4yx3C8vJM3musTiYCbt2vUpoi/iRf4+yAJ9222LLTRjawhVKufi9a
         V7ZAyfnNROL9bvGDjrwfL8HJuiVj6h+qcsEIKdwXIR2BEq5mLvmd6el/nefhOCnmXGEg
         60NiF99S4sbDh4LffHb2+3X9VQwkcEFm+IJgX5QWlIzRUXSteobcO4pi3AEkFZzZPKBZ
         VeYBUISaeXoJgfsy8NIofkM85XolN5sfSfKpam6TaxC+kD+3sQF64cEmY2bWX5We98gA
         hPv8a9mTG5zUA7Wrosk+Hy2aknwi4Qg8MtX7u8o/BDDOLH+i8vEWzfHBcwUbtXYudisM
         WyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779237654; x=1779842454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GsV/qcAAOGKFq6oLLbKHL8j78k9PSthmCVRCsEtT74Q=;
        b=sCTP5OOfRI66Nazsl8KQCReWkZAto58pwCWWDrHOFbt7cLKsSMfNiJgFNhAA7ui4We
         934+UPtqfVqDKiCa92IzQffFWG9qt2meNfVTxmRLm47nvn+IGAnAjXvLZMHEfo1+oxj1
         KZtzdCur6ILYlS4ho8RFXH7b5lGABJ565EIBhligGTBQqUstRSjnyiU5MyyEiQbIU7AR
         W+kdGIWETbuZRBHRnl/C5KCPHKtrwXfNAJnD1sxRYbx7nr9v5KzfTo9xADtHUlfXK/VY
         1yAYcXfLDkxwvkk13nLTU6qSnzqsNqUzaP9otwd5Npg2S0+T9zv69khqUpSnX1Ydch/9
         2ccg==
X-Forwarded-Encrypted: i=1; AFNElJ/Ab4NuyPutDkeXw8L2ZzWWLkpzstvhZNPC313iSclGa/tmzL6rjmXNU9Nt4zhQh/ellAzr3VglMEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZupOvMh6nzjuvY4iT7ZHclVr11WGRHnLbGvyZt04KLn3GJSWr
	wHX8EmK58HHTDeTRFXU179mcolciFyQNhCuFaiQ780wQH+wUbjn8lY7ftarG7B5rk0o=
X-Gm-Gg: Acq92OFpbU5guTA8RSEBmyM3RuabyqleMZL+o2puZ4yRLUKKtQQqBrBD5c9OEAHsek4
	2LfKfwWkfJv+KtWYwHaC/ZB55bkgelqnK2Vt1WGXOnYvUe8n0AiiQbolgrsacwlrs8beCtO6A5u
	Yd3ICRHrT9H7Hv3qfENVzuNow4eD6fauWZJgHiyayhBlpALIbrR9Icy53dTPs3dmON/pMrZmLb3
	fxGQFMQ+i0V8iVrgrpELr7p6KFiPz5gdRWduCWjq1CBLcC+vr1QUZmQDmfzwLnKhMJIaAD5PhIz
	tle54hUvyYZIQe9mEXSQYWKVdHYEjOehqTK2MFHB5sHWAWPopRblDjrdLIgWuBwXz9Rn/4bgjCf
	xroh4MseF5SHrxrztMNVSG0mOqRmUjqdiUHj/vcIWdwrUPGbEQpB645kF0GmoqkNaPxyDv7Y+D7
	qFMxIfhEoEHHqeKA+YCf12HhyzrjQD056MMsj+aA0UEU7hlOmu40DAkpEz
X-Received: by 2002:a05:6830:6614:b0:7d7:d615:3040 with SMTP id 46e09a7af769-7e4f2b865d1mr14111997a34.17.1779237654049;
        Tue, 19 May 2026 17:40:54 -0700 (PDT)
Received: from [192.168.254.51] ([12.117.181.174])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55bc4749esm11835894a34.23.2026.05.19.17.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 17:40:53 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>
Cc: Benjamin Coddington <ben.coddington@hammerspace.com>,
 Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [RFC] knfsd: per-client fair scheduling to prevent single-client
 starvation
Date: Tue, 19 May 2026 17:40:51 -0700
X-Mailer: MailMate (2.0r6272)
Message-ID: <D56AF5A6-3419-4164-8FCD-D818500ED0D3@hammerspace.com>
In-Reply-To: <1a5c70d8-e7f4-4671-a29a-023be7c107fc@app.fastmail.com>
References: <D33770A1-9098-4F1A-93EF-590E6C0B7638@hammerspace.com>
 <473e337b-fabc-4884-a6c4-0f04b6874d0b@app.fastmail.com>
 <3AB7EB6A-B207-4B91-A695-66C4704D0E31@hammerspace.com>
 <4c5dbb98-0209-4572-8eac-1578536bbd78@app.fastmail.com>
 <AED22AED-E97D-40E3-9839-BF8307EF8B65@hammerspace.com>
 <1a5c70d8-e7f4-4671-a29a-023be7c107fc@app.fastmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21724-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1C838586530
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 19 May 2026, at 17:29, Chuck Lever wrote:

> On Tue, May 19, 2026, at 6:02 PM, Benjamin Coddington wrote:
>> On 19 May 2026, at 14:44, Chuck Lever wrote:
>>
>>> On Tue, May 19, 2026, at 5:08 PM, Benjamin Coddington wrote:
>>>> Just to be clear - the issue I'm exploring isn't the same as when all the
>>>> kNFSD threads are slow due to their workload.  This is very much a
>>>> multi-client dynamic where one client (or a group of automated client
>>>> instances) are able to easily starve another simply because they create the
>>>> most connections.
>>>>
>>>> That's different from the other problem that we've discussed a bunch at
>>>> bakeathon and on the list previously.
>>>>
>>>> This is not so much a deadlock issue as it is an issue
>>>> of per-client fairness.  I think this problem is in a different class.
>>>
>>> Does dynamic svc thread creation have any impact?
>>
>> I haven't tested it - I think it would just pin to max-threads for the
>> workload in question.
>
> If the aggregate workload consumes all the threads, then that doesn’t
> sound like xprt scheduling is the bottleneck. But I should look at
> numbers instead of speculating.

I can synthesize something..


> Are you seeing connection loss in these scenarios?

No - its not connection loss - its certain clients that see a
dramatically-reduced level of service when other clients that have many,
many more connections start loading the server.

We have a small army of data-moving clients that compete with .. how do I
say this .. "interactive" clients.  The data-moving clients open as many
connections as they can and try to push operations very aggressively, but
they compete with the "interactive" clients unfairly because of extra xprts.
I would prefer the "interactive" clients be prioritized, but I don't control
their nconnect, and they can't compete with the connection count of the data
moving clients.

>> I'm probably not understanding you here, because for the problem I'm
>> interested in fair would look like prioritizing each client's request
>> queue equally, no matter how many xprts each client has.
>
> Then for NFSv4.1 and later, NFSD might schedule work on the session, and
> manage each session’s workload by raising and lowering the number of slots
> in its slot table.

Indeed, sounds good.  What about v3?

Ben

