Return-Path: <linux-nfs+bounces-21386-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YF2nMVmK+Wnh9gIAu9opvQ
	(envelope-from <linux-nfs+bounces-21386-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 05 May 2026 08:12:41 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CD64C71BE
	for <lists+linux-nfs@lfdr.de>; Tue, 05 May 2026 08:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B38D30358AE
	for <lists+linux-nfs@lfdr.de>; Tue,  5 May 2026 06:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3406F3CA488;
	Tue,  5 May 2026 06:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQs2dLly"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B603C8735
	for <linux-nfs@vger.kernel.org>; Tue,  5 May 2026 06:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777961519; cv=none; b=GqlNZ2SrkldMwcbbSh0XXcAOdGbIZ2wVh78V9cOIRCEyIvNm/JR/rmqoMnVcOw4HUz/KdZMpS/EL4nA5DBfNp8RS9EXV7cHFT6oR3h5HOIct1H7Q0lFjARz6RNRJMSasPHZC6TKWuhBh0m4Lht7p2YbkJNScb5vIbdZwI/kFtyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777961519; c=relaxed/simple;
	bh=3RwYYy8oQs7B3Nh+ZfPDXaEpMDZlE/1vWf/pCAzCJp0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tH6GfGMR+PhZt0KMl3tUYS6H1WDpG9rZLB8PnfLxYf+5ZaaktMH9wnLE+otE/9b3plym6Q9JwY8FmDGXV6uRqFMtns6Rp7T2l4jDlLnp8Ofzzekd4gVHEHefzoyVN1eY02tDOgJ2lhnpJSMJ2gQ9IBaPFkDYOgqDFjvCxr2aLgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qQs2dLly; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8367df48711so828118b3a.1
        for <linux-nfs@vger.kernel.org>; Mon, 04 May 2026 23:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777961517; x=1778566317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X+wwvpFMRip9QGwFsLUcpUYYHp8W07YpxKheBhhRTr4=;
        b=qQs2dLlyGZFdmv+AtLC79ziwdPhf4TFpo+NcAKiQYcFSwhqV0SaQKskXLT6Jq0jJQw
         xkkk6qVUWbZPIW6KfbGdqBVArT2s/PANU8Bq38d7CMMpZbkRnNxVj4x3QkS25GD9m8OJ
         7iXAsguXe6cgK1bzk7o3ZSHMVGMD/tX9hdNTd8e7EQD9zP6yUUS8NlcSqqsuANXurxvs
         VmVp4G8n8NGzh0A2BmRFKIXRxRKGI2ofCZic0rMG9fyhibtlxfH6HDFNMxp9TQJlxtpv
         gFK1sYueBDYwkIWdidxIBKTV6C+EkNp7ORPaEyRZRR0n1+SM31ZEoFk9D7frQgGJaGYK
         Mblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777961517; x=1778566317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+wwvpFMRip9QGwFsLUcpUYYHp8W07YpxKheBhhRTr4=;
        b=Gx9GTqWzot9f/c0ZZrCbpIe/asfxBE7P3m01KS/2V1h1sXyo35QRemnywJDGQvXO7U
         xwCaSEhyZVlR5L6a7sM/pnVw2n9iNo4hNHf5wkfzP6lVrxpr3o7l5rNj3sIiendCJJu6
         QbCALhI4FpLRGWaZVdW8iZqExuFgVGepl6p6D6Hz2Ifp0P2v8CESwi/nBNXOGjzALFSX
         ov6KGVn/BYokMmkvIAQUbK/pRYcVS8MtQzASOwT3dy9wnYQNHMDHZbeArf7G806uzN53
         GclqCOLoV4plJWPS+HAzae4xwb+nLHN+gWtkjREmYGiceGFYMOjoXVQrvrLDZ62DhxqM
         +4eg==
X-Forwarded-Encrypted: i=1; AFNElJ/ubrq/tPdeyP4BJbKtI2EHob1D5N4kdSE1ir5T+0UEkytzD0bI9sHFePT7M1rEb/xf3xcQZyO8tLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKeoeYRKcXmSS6Qu/+CM5eF/MvwHG06p0/nXxWLwcdEYewUMUg
	M23wRsKX29DCnR+i6+pUTls7Rd0KH7jJr/C5OzwuzwdM3wqp4ueAuQFY
X-Gm-Gg: AeBDieuHaawLZBDjrz5xH8qFzi2gDSMafL8iICa8+kQnYn5sFBiIAn3Oz6hkcVYo2vl
	+72jQlRGFGDs4CCIgMKHGzbWTnNbGHPOhMMGGlX5ZuyRDD5BG6CcnLL+oAIMyppvDLLu2uyyuXU
	QO7oSt5C6/Z4oTzbLcXKM+EgStkYGa3An+e+a1PwT4Tay0LObU/Mw0RhJI1KOPGNQ5VlrvpzjlK
	QDwh/l55CrYsS7R7qok5fYV4tbU9NvukQz0LldMwiPet3vmVW57Tzk892kbHU8vhHjjGgTz4TQq
	FXAMhGwk9mhTYOUFX7WemWJBteT7Gtp57Qz9bXwQBXLlCRowvPxTXjF2ucxdWCOIbBmuh5Kil4B
	PD6PYxL7XkP7uzYPEyHpOL/kBh/rfFZZOzhM6u0SLxDE1DK/98bE09lJaRGdabwA5cczX7EQFB4
	2couO1w+gwmh8N7l8t3Ly+TWIQMQ6qIUei29RygKXqKkjv7rfc
X-Received: by 2002:a05:6a00:4f88:b0:81f:4e6a:7276 with SMTP id d2e1a72fcca58-839227d1216mr1744350b3a.14.1777961517008;
        Mon, 04 May 2026 23:11:57 -0700 (PDT)
Received: from localhost ([49.207.150.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbdda0sm903484b3a.44.2026.05.04.23.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 23:11:56 -0700 (PDT)
From: Piyush Sachdeva <s.piyush1024@gmail.com>
To: linux-fsdevel@vger.kernel.org,linux-cifs@vger.kernel.org,linux-nfs@vger.kernel.org,netfs@lists.linux.dev
Cc: sprasad@microsoft.com,linux-kernel@vger.kernel.org,sfrench@samba.org
Subject: [DISCUSSION] Preventing ENOSPC/EDQUOT writeback errors on network
 filesystems
Date: Tue, 05 May 2026 11:41:53 +0530
Message-ID: <m21pfqgzbq.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 43CD64C71BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21386-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[spiyush1024@gmail.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hi,
There have been plenty of discussions on how to handle writeback errors for
network filesystems, but most have focused on error reporting after the fac=
t.
I'd like to start a discussion around preventing writeback errors specifica=
lly
ENOSPC and EDQUOT, before they cause silent data loss.

The problem:
With buffered writes on network filesystems (cifs, nfs, etc.), the write()
syscall copies data into the page cache and returns success immediately. The
actual upload to the server happens later during writeback. If the server is
out of space at that point, the write fails with ENOSPC. The netfs/writeback
layer records this error via mapping_set_error(), but critically the folio's
writeback flag is cleared and the page is now clean. Under memory pressure,=
 the
VM can reclaim these clean pages, permanently losing data that the applicat=
ion
believes was successfully written. Meanwhile, i_size has already been updat=
ed
to reflect the new file size. So stat() shows a file size inclusive of the =
data
that was never persisted. Another inconsistency here is that total free spa=
ce
hasn't been modified for the file system on the server, leading to incorrect
values in statfs() output from the client's pov (assuming statfs() calls go
to the server).
To illustrate with real-world scenarios:

- A user or application can keep issuing writes to an fd well beyond the
  available space, since buffered writes return success as soon as data is
  copied to the page cache. A significant amount of data, exceeding the
  available quota can accumulate before fsync() is called, at which point
  critical data loss is nearly certain.

- A malicious user can exploit this to keep resources pinned and memory
  oversubscribed, impacting other applications.

The error is technically observable: fsync() will return it, and close()
surfaces it through the flush callback. But in practice, many applications
check neither, and the POSIX "just call fsync()" answer isn't satisfying for
users who lose data silently.

Local filesystems largely avoid this because they can check available space
synchronously in write_begin() and fail the write() syscall directly. Netwo=
rk
filesystems can't do this cheaply =E2=80=94 a round-trip per write to check=
 server
space would negate the benefits of buffered I/O.

Through recent development, netfs is becoming a central layer for network
filesystem I/O. It already has retry logic for transient failures (EAGAIN,
ECONNABORTED), but ENOSPC/EDQUOT remain hard failures. This affects every
network filesystem using buffered writes.

I am curious to know if NFS has a solution to this and what the approach is
towards this specific problem by NFS community?

This problem is worth solving for all network filesystems. I have a few
thoughts on approaches, combining cached statfs() output with
fallocate()-style pre-allocation on the write path:

1. Pre-allocate space on the server before writing to the page cache,
   analogous to fallocate() on the write path. This guarantees server-side
   space for page cache data.

2. Since per-write fallocate() calls require a server round-trip, effective=
ly
   negating the benefit of buffered I/O. Use cached statfs() output to gate
   when pre-allocation is triggered. For example, once free space drops bel=
ow
   20% of total space, enable fallocate() on the write path. Otherwise, let
   writes proceed as normal.

3. Handle refresh and synchronization of the cached statfs() data separately
   to avoid staleness.

I'd appreciate feedback from the community on viable approaches.

--
Regards,
Piyush

