Return-Path: <linux-nfs+bounces-21599-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GdqAHSR+BGqKKwIAu9opvQ
	(envelope-from <linux-nfs+bounces-21599-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 15:35:32 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC14753425E
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 15:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B92AF33B4B92
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 13:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B4E49690B;
	Wed, 13 May 2026 13:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WP2Pe2L6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422C54968E6
	for <linux-nfs@vger.kernel.org>; Wed, 13 May 2026 13:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778677877; cv=none; b=V2NBuwjZi6BORHptr4e4US60Oe78fUqOl0yKXulb31t+Q4LP5a/QVjUdNSgSG8FAkxcONY6nX+sT5RE2kNYN1W2e0XkLsC0uE13gkRbkNcPf0jAXZpEVkmGYvY9rv7ZPlGCe7CV6HdROsfuGG06BYcG87fgsO0f7Mgm/PYolrgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778677877; c=relaxed/simple;
	bh=6FWAOdMRCGXRhuY+RZ6so9OqbtSfnT1i9cx1+5lpsns=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aiCs9tQZHPsX6QgVdjvCJEgZnHGFg4R+27GTlfMvqFoUXeintQbSBI3F/ilQHVr0kRw02h06kGVeAdK9RbQB8De1kqU9YuKAFcX/RSl0cLxCmoDA+AENQ943ITqQMfkBj7rN4TGod/jfIVlx9TNoLRvh3zmMmv8jwPzTbSE/C5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WP2Pe2L6; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8353fd1cb5fso3319449b3a.0
        for <linux-nfs@vger.kernel.org>; Wed, 13 May 2026 06:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778677874; x=1779282674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wsFk6Og0o1PC9DlqH7Rg3d6wr5WjV/2ny+ljIhyfStU=;
        b=WP2Pe2L6oXwYZAIqerHUY2jAuvBDziO4BcAF9i3Pb+emXcqwkTFABpVZOMH3Ko/pno
         CzJayj5iwz5yhwYAdJuOZNaG8eGb0p6NyEr0ucleIkaFGgXft3rVGOE/dfxa4KmLxFWl
         w6F/jdjKBOenI1XJBRtTe9K8mcEkd2H1/7l6uC2N2JiN/9vQRlBW3XASZPDFQTQ0MK6z
         Aoal/rmw8eZOb6jm7+OgVV/dg196Y9SfClipaL96R/wJpIZTMVDpjPt4WwTvWjFz2oXj
         D+2CFKWiAbzblOB6nBb4EmE/tfY81VDM36T90zllVXUpn0hJ8tycl89xIksTN+CuS3Hp
         t2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677874; x=1779282674;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wsFk6Og0o1PC9DlqH7Rg3d6wr5WjV/2ny+ljIhyfStU=;
        b=TbvZIh1GErYMmuMDmt1ih72IiqA1NtyPSkhlSjWKEnNX4NBpOP08b98IRt1SIqLd5X
         z76fhLRR3n5lMmtBr4yojbJLpJQ/WJe/uaG0dsFe+qLfILqzlhhNe+jM8gCiqe3EEkUN
         jlBlilNYYYnYtnGQnluY95eXJgm2bY1mXHByPkenUgH6O4AYyoVth8PO6+bltcWnSCZb
         hVbAjtBPuneThzumULjwrfN/q23T4GYj4pd73KWADnhercuDKpL9XVdClba7csM60xs3
         crf1+Bt8PNhsgHIzA2VjzwrOs6Bv7eL4GUja95j30exGELNzgEi0wCCid7Ra0I10ag7B
         M2dQ==
X-Forwarded-Encrypted: i=1; AFNElJ8C3IV62rwW+bAsRM356dtNNok8CCNUs4lEcRthPkYsttQHw8KnOfHkXF3z3lYLAOMLvuGHCHHSA/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytf0lz6rT1QNDCc86+DfAB3AnI6+5PmJNaWCUV+vMV+TexXd5z
	HNtbY9fHigzYjYffMh05rO+HNbkTNZqtLahu5B5frW/Jyg31XLnYUWSh
X-Gm-Gg: Acq92OF4IK4pwdsjLTnaWFxu6Af2/O3szP4Ww8ssHO1nh0yu+hlLsBOtR5Jh1fouJkK
	d0HZ1ZBsrNheP+XOx3xtLsmXNsyFgLWHHon6KMcRfaTKN5DnGpj+QHoiPvdKvdlv+PpxdVGvyYN
	8nrnGeXxBdKaKIqlFsdWOuTsFfCJnC/4CXhuHCh9TQhO8KBseA13OJjN1A86BmAHfHpZk5hH8Ez
	15hB0mF5H090pyhc8HwrisoKd8LsM8C7XZMJ3L9OKeLfbHt1GxOdkLX8CNwiaF6+OrFuUPAspOR
	xcHEcCMKiVZIktf1LHzjkdcZux7Ai+iOZ75YlMw1rVWJOD613vDW2W9w0TIjne93GY2/P15w0tQ
	E5BK9OmfNN1ptqDvwRnUYfFZdZXxbbIJriiuRX4ioG/TXwBRA0pnGJjJePp87rqd9JqlP4y/LT6
	79UCvVTLFdxjCma8v8mUih/A+f+1xp1oZbbPbEG9A=
X-Received: by 2002:a05:6a00:3692:b0:82f:7cb7:63c7 with SMTP id d2e1a72fcca58-83ee8321af5mr6868969b3a.11.1778677874347;
        Wed, 13 May 2026 06:11:14 -0700 (PDT)
Received: from localhost ([49.207.149.142])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839659487afsm26237472b3a.18.2026.05.13.06.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 06:11:13 -0700 (PDT)
From: Piyush Sachdeva <s.piyush1024@gmail.com>
To: Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 netfs@lists.linux.dev
Cc: sprasad@microsoft.com, linux-kernel@vger.kernel.org, sfrench@samba.org
Subject: Re: [DISCUSSION] Preventing ENOSPC/EDQUOT writeback errors on
 network filesystems
In-Reply-To: <9e48229614786e0c2e92bb6a2dd3269868f160d0.camel@kernel.org>
References: <m21pfqgzbq.fsf@gmail.com>
 <9e48229614786e0c2e92bb6a2dd3269868f160d0.camel@kernel.org>
Date: Wed, 13 May 2026 18:41:10 +0530
Message-ID: <m2zf23e9ox.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: CC14753425E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21599-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[spiyush1024@gmail.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Jeff Layton <jlayton@kernel.org> writes:

> On Tue, 2026-05-05 at 11:41 +0530, Piyush Sachdeva wrote:
>> Hi,
>> There have been plenty of discussions on how to handle writeback errors =
for
>> network filesystems, but most have focused on error reporting after the =
fact.
>> I'd like to start a discussion around preventing writeback errors specif=
ically
>> ENOSPC and EDQUOT, before they cause silent data loss.
>>=20
>> The problem:
>> With buffered writes on network filesystems (cifs, nfs, etc.), the write=
()
>> syscall copies data into the page cache and returns success immediately.=
 The
>> actual upload to the server happens later during writeback. If the serve=
r is
>> out of space at that point, the write fails with ENOSPC. The netfs/write=
back
>> layer records this error via mapping_set_error(), but critically the fol=
io's
>> writeback flag is cleared and the page is now clean. Under memory pressu=
re, the
>> VM can reclaim these clean pages, permanently losing data that the appli=
cation
>> believes was successfully written. Meanwhile, i_size has already been up=
dated
>> to reflect the new file size. So stat() shows a file size inclusive of t=
he data
>> that was never persisted. Another inconsistency here is that total free =
space
>> hasn't been modified for the file system on the server, leading to incor=
rect
>> values in statfs() output from the client's pov (assuming statfs() calls=
 go
>> to the server).
>> To illustrate with real-world scenarios:
>>=20
>> - A user or application can keep issuing writes to an fd well beyond the
>>   available space, since buffered writes return success as soon as data =
is
>>   copied to the page cache. A significant amount of data, exceeding the
>>   available quota can accumulate before fsync() is called, at which point
>>   critical data loss is nearly certain.
>>=20
>> - A malicious user can exploit this to keep resources pinned and memory
>>   oversubscribed, impacting other applications.
>>=20
>> The error is technically observable: fsync() will return it, and close()
>> surfaces it through the flush callback. But in practice, many applicatio=
ns
>> check neither, and the POSIX "just call fsync()" answer isn't satisfying=
 for
>> users who lose data silently.
>>=20
>
> Yet, it is the only real answer we have.
>
> This is just a fundamental issue with buffered writes and delayed
> writeback. Either you flush the data to stable storage now, or you have
> to do it later. If you do it later, then it can still fail for all
> sorts of reasons.
>
>> Local filesystems largely avoid this because they can check available sp=
ace
>> synchronously in write_begin() and fail the write() syscall directly. Ne=
twork
>> filesystems can't do this cheaply =E2=80=94 a round-trip per write to ch=
eck server
>> space would negate the benefits of buffered I/O.
>>=20
>> Through recent development, netfs is becoming a central layer for network
>> filesystem I/O. It already has retry logic for transient failures (EAGAI=
N,
>> ECONNABORTED), but ENOSPC/EDQUOT remain hard failures. This affects every
>> network filesystem using buffered writes.
>>=20
>> I am curious to know if NFS has a solution to this and what the approach=
 is
>> towards this specific problem by NFS community?
>>=20
>> This problem is worth solving for all network filesystems. I have a few
>> thoughts on approaches, combining cached statfs() output with
>> fallocate()-style pre-allocation on the write path:
>>=20
>> 1. Pre-allocate space on the server before writing to the page cache,
>>    analogous to fallocate() on the write path. This guarantees server-si=
de
>>    space for page cache data.
>>=20
>> 2. Since per-write fallocate() calls require a server round-trip, effect=
ively
>>    negating the benefit of buffered I/O. Use cached statfs() output to g=
ate
>>    when pre-allocation is triggered. For example, once free space drops =
below
>>    20% of total space, enable fallocate() on the write path. Otherwise, =
let
>>    writes proceed as normal.
>>=20
>> 3. Handle refresh and synchronization of the cached statfs() data separa=
tely
>>    to avoid staleness.
>>=20
>> I'd appreciate feedback from the community on viable approaches.
>
> NFSv4.2 does have an ALLOCATE operation:
>
>     https://datatracker.ietf.org/doc/html/rfc7862#section-15.1
>
> ...and such an operation could (in principle) precede WRITE in a
> compound, but that doesn't really help you. By the time we're issuing
> RPCs to the server, the client application has already finished its
> writes and moved on.
>
> For applications that want to avoid ENOSPC/EDQUOT, the best thing they
> could do is call fallocate() themselves to ensure that the space
> exists. With a sufficiently recent NFS client and server, that should
> DTRT.

Hey Jeff,
Thanks for your email and for sharing the NFS spec. I noticed that the
ALLOCATE operation ends up checking for space during write-back as well,
and the initial concern of loosing data still remain. But if we do the
operation before writing to the page-cache, it would be a performance
issue.

I will try a few experiments and then post my findings here.=20

--
Regards,
Piyush

