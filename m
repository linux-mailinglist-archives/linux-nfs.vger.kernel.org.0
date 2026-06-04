Return-Path: <linux-nfs+bounces-22263-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b2oDIWAhIWrG/QAAu9opvQ
	(envelope-from <linux-nfs+bounces-22263-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 08:55:28 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 290D163D636
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 08:55:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=nzpxXUyd;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22263-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22263-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A022A3049211
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jun 2026 06:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4753D9041;
	Thu,  4 Jun 2026 06:51:37 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C513D091B
	for <linux-nfs@vger.kernel.org>; Thu,  4 Jun 2026 06:51:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780555897; cv=none; b=fC9GYeANL01/efxYpw35mgpHHCCSKnnM8Z6lustLkvfn0a5Kd+cBtGgxjz+2VUm60h6+xL0MHCdYmhJWwetK5vG/Cezz1FXGOi2dLMsYc6NUh0wMDhWUEagGquf5jyukotDvc7RkXuET9cPZXjWbatsN+0g1N8ev4xE14B2vJvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780555897; c=relaxed/simple;
	bh=rZfmT8E2vEREwINMSsmZrCaMt9v4llL/bgylmcTIXuw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ESQtiGWgvxzdcFoISB1Z6vk0T9eU8R047tkmzJPTvXeZNMZhzMjyD2/M9AnF642qbVZOl7YkCuAfpvZbhO1u9gxRYLtBbGMr8xz/5VcQMRinJmGwqNRJWYf64mbdKhPIcIO75iDm9B747gcqJdIUcgldXPEkjh64LMKqsH3pHVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nzpxXUyd; arc=none smtp.client-ip=209.85.214.172
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bf237e1433so4342265ad.1
        for <linux-nfs@vger.kernel.org>; Wed, 03 Jun 2026 23:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780555895; x=1781160695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U9uqJ9zIvGX0NDqn7gTsRWpyFlMlfqGeCbba9ggEOAI=;
        b=nzpxXUydyJMRm3T2ZOLTG+Q8ZQRMr+WfhWpx/Z5Jo4TH+ySFJxdm8krDlMJPjz/Kbp
         ZUwUtpDKJ3LvdLcvBoniSA57zA5CNxDf1/ylgpa9VoqTWLgthuRoAwMkC9Xj9h3PnlgA
         dfhGKhOPYjSTiYIKgcr8D9H6szTvfxk8nJCarob3T+AqCLg7wQcnZzTkVIBhw8gb7TfN
         UErtVFDcjpnFwzi5oRYFqyKkslUwXv6dHfXZRwNdjjUroLI10lRZFmKDGFFEKFS2Qh8q
         UE5gfOk86nwacuCAVVpNmtuKasQ7I1t6LJygNX9XAu4fzIyLy8BZiXPyaaByd5c0VChI
         5XDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780555895; x=1781160695;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U9uqJ9zIvGX0NDqn7gTsRWpyFlMlfqGeCbba9ggEOAI=;
        b=cm9f0ZGV7m5go5U3jskuSuKDj3k7Xfr+Ijs8zdsiSoLIfqcCtMhFtS3tWJ+baxq3B4
         o3IFSHaHntRJoo24SSH0POakq3EbFL9RZyW0N06rb4Sx/u5Mx0uCqB8EjTKiyEMNucod
         0MHxiJkfrVHA90lkaRcdM/pUP4sSsGGSdsMARCwjseVkBjP6f3NV3b5/+CBPfKz0ug1F
         dC4u/dNRposp5Eih3GpWBZ0lwNcTF3Pn7xx3uM8ly/sLAErJdPr8C/PStfTFjVuXDrsL
         qM6YoXnlv/mdMtzQz8JgNlZA4OVxT2rXZN+utaqGcPTo2Mb8Ob9jctJ1P3IvkMWv+y7s
         R5sg==
X-Forwarded-Encrypted: i=1; AFNElJ/xLmjBFri4JQJyA09Q9cCJop9lwhgujXCyujZXDo6ars+W0IyaQkFwLcZMw6EZveJmyEvcOlzQMwU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy087Cg0tCzHRu0ivsOXDPHwpjz9c0/Fjaa8mMFvqMingzp5k1O
	h8F9IBRt0BMGy0z1xec/ew0r4FJwYP26O4MSTDgYbeXms5Awxh2Jw3HR
X-Gm-Gg: Acq92OEpqDH4PnogIWN2tAV8kZfSi9gm5atef5Sa942TqZdRhAOgWm61y82Ykb5Cjok
	zltKSlmoae380L8KmWgBL/bOYgjIjsCzB93tbsSplsgSIstF+VEcKYqXQbUt5KcDWzirZCg7yFF
	qlQ74XOjDMwiF/XyMih/Nc+lvLP5aDZOYCzGYAygZ5pTJYv98dn6XWI6+NDRH6wZx9nyPy7Sbb9
	FdP9TWHLXlB6KkeTtl/SAS3tpuVgxGIeItoYbZsvWFIoKRi94V9EWF3IA6sXnQ3j9JFO7UCcNaX
	eZpZp1v7UuCX+LAZpqjzrczK8m9F9yDBPhYs8o+9B3e2DKrzkedLQo4x9tKJGKpud8MZD1yQgFg
	fYYdDyWrad1xNdN7TYGPn/WB4OTrcCdA+EUo/jlBCjLNbxCNU0yd4b+hFQacM3D37DeflTu8kwh
	4D1TH+1r0i710N25e663aKuDzWsXXZ/EUO+wl4g9uMPEhj/Ncm
X-Received: by 2002:a17:903:808:b0:2b2:6df1:1112 with SMTP id d9443c01a7336-2c1644dd0aamr41901955ad.40.1780555894693;
        Wed, 03 Jun 2026 23:51:34 -0700 (PDT)
Received: from localhost ([49.207.144.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e573sm46972795ad.47.2026.06.03.23.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 23:51:34 -0700 (PDT)
From: Piyush Sachdeva <s.piyush1024@gmail.com>
To: Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 netfs@lists.linux.dev
Cc: sprasad@microsoft.com, linux-kernel@vger.kernel.org, sfrench@samba.org
Subject: Re: [DISCUSSION] Preventing ENOSPC/EDQUOT writeback errors on
 network filesystems
In-Reply-To: <m2zf23e9ox.fsf@gmail.com>
References: <m21pfqgzbq.fsf@gmail.com>
 <9e48229614786e0c2e92bb6a2dd3269868f160d0.camel@kernel.org>
 <m2zf23e9ox.fsf@gmail.com>
Date: Thu, 04 Jun 2026 12:20:45 +0530
Message-ID: <m2tsribxyy.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22263-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-cifs@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:netfs@lists.linux.dev,m:sprasad@microsoft.com,m:linux-kernel@vger.kernel.org,m:sfrench@samba.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[spiyush1024@gmail.com,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[spiyush1024@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ietf.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 290D163D636

Piyush Sachdeva <s.piyush1024@gmail.com> writes:

> Jeff Layton <jlayton@kernel.org> writes:
>
>> On Tue, 2026-05-05 at 11:41 +0530, Piyush Sachdeva wrote:
>>> Hi,
>>> There have been plenty of discussions on how to handle writeback errors=
 for
>>> network filesystems, but most have focused on error reporting after the=
 fact.
>>> I'd like to start a discussion around preventing writeback errors speci=
fically
>>> ENOSPC and EDQUOT, before they cause silent data loss.
>>>=20
>>> The problem:
>>> With buffered writes on network filesystems (cifs, nfs, etc.), the writ=
e()
>>> syscall copies data into the page cache and returns success immediately=
. The
>>> actual upload to the server happens later during writeback. If the serv=
er is
>>> out of space at that point, the write fails with ENOSPC. The netfs/writ=
eback
>>> layer records this error via mapping_set_error(), but critically the fo=
lio's
>>> writeback flag is cleared and the page is now clean. Under memory press=
ure, the
>>> VM can reclaim these clean pages, permanently losing data that the appl=
ication
>>> believes was successfully written. Meanwhile, i_size has already been u=
pdated
>>> to reflect the new file size. So stat() shows a file size inclusive of =
the data
>>> that was never persisted. Another inconsistency here is that total free=
 space
>>> hasn't been modified for the file system on the server, leading to inco=
rrect
>>> values in statfs() output from the client's pov (assuming statfs() call=
s go
>>> to the server).
>>> To illustrate with real-world scenarios:
>>>=20
>>> - A user or application can keep issuing writes to an fd well beyond the
>>>   available space, since buffered writes return success as soon as data=
 is
>>>   copied to the page cache. A significant amount of data, exceeding the
>>>   available quota can accumulate before fsync() is called, at which poi=
nt
>>>   critical data loss is nearly certain.
>>>=20
>>> - A malicious user can exploit this to keep resources pinned and memory
>>>   oversubscribed, impacting other applications.
>>>=20
>>> The error is technically observable: fsync() will return it, and close()
>>> surfaces it through the flush callback. But in practice, many applicati=
ons
>>> check neither, and the POSIX "just call fsync()" answer isn't satisfyin=
g for
>>> users who lose data silently.
>>>=20
>>
>> Yet, it is the only real answer we have.
>>
>> This is just a fundamental issue with buffered writes and delayed
>> writeback. Either you flush the data to stable storage now, or you have
>> to do it later. If you do it later, then it can still fail for all
>> sorts of reasons.
>>
>>> Local filesystems largely avoid this because they can check available s=
pace
>>> synchronously in write_begin() and fail the write() syscall directly. N=
etwork
>>> filesystems can't do this cheaply =E2=80=94 a round-trip per write to c=
heck server
>>> space would negate the benefits of buffered I/O.
>>>=20
>>> Through recent development, netfs is becoming a central layer for netwo=
rk
>>> filesystem I/O. It already has retry logic for transient failures (EAGA=
IN,
>>> ECONNABORTED), but ENOSPC/EDQUOT remain hard failures. This affects eve=
ry
>>> network filesystem using buffered writes.
>>>=20
>>> I am curious to know if NFS has a solution to this and what the approac=
h is
>>> towards this specific problem by NFS community?
>>>=20
>>> This problem is worth solving for all network filesystems. I have a few
>>> thoughts on approaches, combining cached statfs() output with
>>> fallocate()-style pre-allocation on the write path:
>>>=20
>>> 1. Pre-allocate space on the server before writing to the page cache,
>>>    analogous to fallocate() on the write path. This guarantees server-s=
ide
>>>    space for page cache data.
>>>=20
>>> 2. Since per-write fallocate() calls require a server round-trip, effec=
tively
>>>    negating the benefit of buffered I/O. Use cached statfs() output to =
gate
>>>    when pre-allocation is triggered. For example, once free space drops=
 below
>>>    20% of total space, enable fallocate() on the write path. Otherwise,=
 let
>>>    writes proceed as normal.
>>>=20
>>> 3. Handle refresh and synchronization of the cached statfs() data separ=
ately
>>>    to avoid staleness.
>>>=20
>>> I'd appreciate feedback from the community on viable approaches.
>>
>> NFSv4.2 does have an ALLOCATE operation:
>>
>>     https://datatracker.ietf.org/doc/html/rfc7862#section-15.1
>>
>> ...and such an operation could (in principle) precede WRITE in a
>> compound, but that doesn't really help you. By the time we're issuing
>> RPCs to the server, the client application has already finished its
>> writes and moved on.
>>
>> For applications that want to avoid ENOSPC/EDQUOT, the best thing they
>> could do is call fallocate() themselves to ensure that the space
>> exists. With a sufficiently recent NFS client and server, that should
>> DTRT.
>
> Hey Jeff,
> Thanks for your email and for sharing the NFS spec. I noticed that the
> ALLOCATE operation ends up checking for space during write-back as well,
> and the initial concern of loosing data still remain. But if we do the
> operation before writing to the page-cache, it would be a performance
> issue.
>
> I will try a few experiments and then post my findings here.=20
>
> --
> Regards,
> Piyush

Hi,
While running experiments, I came across an interesting finding.

Context:
When writing data beyond the available space/quota on the server, we
don't expect to receive an error on write immediately, given its a
buffered write. The EDQUOT/ENOSPC error surfaces on a call to fsync(2),
either directly, or implicitly via close(2). CAVEAT: close(2), doesn't
guarantee a flush of data to the backing store.

Finding:
When the flush of over-flowed data - sitting in the pagecache is tried
using a fsync(2) call, we expect it to fail. However, it looks like that
the NetFS layer, used by the SMB client to do the writeback, doesn't
re-set the dirty bit on the pages/folios on which fsync fails. At this
point the pages with critical user-data are sitting in the pagecache,
but no longer marked dirty/referenced by the inode of the file. This
behavior is seen for EDQUOT/ENOSPC errors, contrary to EIO errors where
data is re-dirtied. It seems that EDQUOT/ENOSPC are treated as
non-retriable errors, as a reason the dirty bit is not re-set.
I noticed that NFS also has a similar behavior where the pages are not
dirty after the failed fsync. Naturally, now that the fsync is
tried before calling close, and with the data not-dirty anymore, no
errors are seen on close.

While, the close(2) manpage explicitly states that upon failure, close
should not be retired, I do believe that the data should still remain
dirty. An application (should) calling fsync before close would monitor
for errors, and should be able to retry the fsync after increasing the
capacity on the server.

I would appreciate thoughts on my idea.=20

--=20
Regards,
Piyush

