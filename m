Return-Path: <linux-nfs+bounces-21715-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uA8JLyzMDGrAlwUAu9opvQ
	(envelope-from <linux-nfs+bounces-21715-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 22:46:36 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D13584D13
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 22:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36D693054235
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 20:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D8564AA4;
	Tue, 19 May 2026 20:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="j29tCm1G"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9A227CB02
	for <linux-nfs@vger.kernel.org>; Tue, 19 May 2026 20:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779223551; cv=none; b=axed6ucBsq0DOUPlmydnQCuVFvfV78n0N6ke4wo1Lm65dwDP003NoGGgfJyhuVZeAvISa8fDHMWvuIsxLC2AsJ9sDuZYliR/jQBitTqh29zl5ck7RboxsYBHV+oPu9/fngOmlh2DZ7ZiRBtOXsaN6bfK6moqL1MBKwvpCLVdIz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779223551; c=relaxed/simple;
	bh=/NH4JxL2baDC/Gzeo1y788JcEaKV7tke1fm70KotvQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FaektIHoBSjfO/fzQ0MZqDkT3iX9q6wxPyc9F37zR3CSRbTTroGQ3G8tb9ewLxpNok2G+mcTqRarSR2EdBg9fJHXzp86WEEJ8db6KLtxzwr3Jtc4NmN18pSpoPJXJkXkY4kl2SB5VojFP3RsGXLWvskfgZkVpEwjkBqxe1pxEQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=fail smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=j29tCm1G; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammerspace.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7de431da8fbso3667415a34.1
        for <linux-nfs@vger.kernel.org>; Tue, 19 May 2026 13:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1779223548; x=1779828348; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TrW9PsYHPVmH4ArI7u11b61bFKrMTzLmGfHOPgmT2NA=;
        b=j29tCm1GZEYY0wKNuIdhPhT0ySqRFIYOTT/gp4Sc1rl5o1LjSNcx0FBfWgIdJjbVff
         7DdEe4lvcFYjWcY+UfkWNITTfqw9+ZdXTH7fxR+k11yjSpG3paUuNI4C9udDHOzMpNkh
         //nHuk+hTeW5QADvPB111WrIlvIvOl33mDaYjLm9mdGFVLN9Hli2pygQWGyp2nwjxzh/
         UZCUGv1S/vOyIXlRiH3zo0lkPE25a9dDzY4aIsNpXFhoeGlICQMdRe8Gd7PlAi53wSAm
         AcjpUQRhJ6X/s6W7XRs8Yc0jbfmqXntib4bBo9HX/bg7aS2C5GPmk58SkpIPQf9EZJTg
         1/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779223548; x=1779828348;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TrW9PsYHPVmH4ArI7u11b61bFKrMTzLmGfHOPgmT2NA=;
        b=OgLhcFSQtT/hWp2lMDUGKr9bjtuLAITfIDdRPpz1ymm55GMxRFD3SqEjzHHqg7EZiD
         63sBB4S91tAcUu0UDiIqX8tRHBy7jbRM/50atkQfAivJCJiJfFVyKgH1SyAZe/e2q0mv
         XMrKsi11ME8CXHXWgz8EfI5q+/Y0eixmdGGAl9T7ne0+5/ULxJ8Rz5wElDsfqwlTDVlu
         HrzuaNjqENgFbs3PauX95iyahEXmRRCmmgJ93zUpMtLAnJi6Q5bvy4vCWbeTTtlY6v35
         pabqRS0l/YCxkoNww6stGiQog54vmOW/7CuQ54FyFEBYGhvRxWg2ayULSOCANUpNIboF
         UmkQ==
X-Gm-Message-State: AOJu0YxRIlrr72FNypLwZjZqkVE4bQ512ViqldAzvRr4F4iFZf/nUj2g
	Mzciry79xwA5eNsmmV/xVtLlWopbXAee1IVzfFDS1IGBkdBKxnDXuUhLhMY8OLG4JNoR3RiYelf
	6p6//
X-Gm-Gg: Acq92OFfc2lRpxyTrDummMNr3U6ulUD12ggYvwOFXwfz2Mxxq7uK30toWah1CyDDTTV
	1A55p55u37h8CCiVbaVbCE/IIFBfUBta88Ta1lXMPklQ4WRH9mGbORQs00F6+fQKvjW9Jq+N8Lq
	m4uaxkeMGn7MJ/fvpIi+hDmcDmyRvhH7ET5WX575HdgVWSK3NrgZaeu+pVjpZ1Bo8OSbgUoQ4/N
	QPJhuLBN6iV+jhqwDov2NxYxWl++YPcJIqi33flsblS9rFHFlQp0lPRO5Gwg3F6JVBEKWdVPIf6
	ALtKQZkjI6CtwjicuwfaXz3Aq0nEpJiq6BLuOKxnBhOft8d/601vBANAM0Z9ZfRXUq64ImaPP1y
	djaBICo4lwP9AUsIu2J9bESOodoQgH+n6WU8cJnwE6s/iXe195ZA3QcphdVtA+BUZSmEUwv/pkr
	S2kX338Xt1POhb2r5UJRB/7iMTvi+ezN22PIpyPAHZ4skAKw==
X-Received: by 2002:a05:6830:3907:b0:7d7:f158:1f44 with SMTP id 46e09a7af769-7e4fa052482mr15071170a34.21.1779223548043;
        Tue, 19 May 2026 13:45:48 -0700 (PDT)
Received: from [192.168.254.51] ([12.117.181.174])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55bc4f04fsm10841549a34.27.2026.05.19.13.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 13:45:47 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org
Subject: [RFC] knfsd: per-client fair scheduling to prevent single-client
 starvation
Date: Tue, 19 May 2026 13:45:45 -0700
X-Mailer: MailMate (2.0r6272)
Message-ID: <D33770A1-9098-4F1A-93EF-590E6C0B7638@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21715-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,hammerspace.com:mid,hammerspace.com:dkim]
X-Rspamd-Queue-Id: B7D13584D13
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We've been chasing a class of starvation problem on knfsd servers and would
appreciate feedback before going further.

NFS clients that opens many TCP connections (for example with nconnect=N)
combined with a large NFSv4.1 slot table can keep enough requests in flight
to saturate the entire nfsd thread pool, starving other clients sharing the
same server.  In our environment we routinely see one such client push
hundreds of nfsd threads into uninterruptible waits, leaving little or no
service capacity for everyone else.  Concretely, 8 connections at 128 slots
is already ~1000 potentially-concurrent ops from one host against a default
640-thread server.

The root cause looks structural to me.  svc_xprt_enqueue() and svc_recv()
schedule fairly across xprts, so a client with N sockets gets N times the
service share of a client with one socket.  From the server's point of view
there is no notion of "client identity" in the dispatch path -- the xprt is
the unit of fairness.

ISTM the right shape is an opt-in fair-queueing scheduler that groups ready
xprts by client identity and round-robins (or deficit-round-robins) across
identities rather than across sockets.  The natural identity is the NFSv4
clientid where available, with source address as a fallback for NFSv3.
Default behavior would be unchanged and the new policy would be selectable
per service or per pool.

Before we go further I'd like to ask a few things.  Is per-client fairness in
knfsd something the community wants, or would you rather see this solved
purely on the client side?  What's the right layer for client classification
-- sunrpc is clean but identity-blind, and nfsd knows clientid but only later
in the path?  Would a simpler per-client concurrency cap be preferable to a
true fair-queue scheduler?  And is there prior art I should be aware of -- I'm
thinking of interactions with the recent dynamic thread-pool work, but there
may be older threads I've missed.

I'm happy to share more detail on the workload that surfaced this.

Thanks,
Ben

