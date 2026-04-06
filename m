Return-Path: <linux-nfs+bounces-20674-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iI4iKxXT02nGmgcAu9opvQ
	(envelope-from <linux-nfs+bounces-20674-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Apr 2026 17:36:53 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CC50A3A4D00
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Apr 2026 17:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A5AA83003810
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Apr 2026 15:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF2F29BD95;
	Mon,  6 Apr 2026 15:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="RAIg4WCW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF29231A23
	for <linux-nfs@vger.kernel.org>; Mon,  6 Apr 2026 15:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775489807; cv=pass; b=IiQ5a4NtwGKalQ9L0j2rt3fbE26DYhV+kIoVh1znTC9Vd0u8e0hFMdnTe8rUc8JbFrJ2Erv9Ku7Q0PWtiJYaKdjW77GFFrP7hefQJVVjR8SWDLy84xz8XuI5QnuOCriTQp91M3MRdS3tZLKabYJpS36PSi30mSPObTvWKl0yBv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775489807; c=relaxed/simple;
	bh=UgQ3kilzdn1wSU8YGiV6YiPiIVYJCKcB8o5r7SKjkjw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=DAFj+KMMRXWCR80bX0FFLOcc3KmG+PaigvD1ETKhgz228+au0Th0OXyNyH7drwmZ+Pm/yHzxozTtjUH7tvtaXrFLV8pS+VTXrV6XFLC1uCVc58XSXrShfE88sjLfOp5Lhrf+4gi5M+V5gVHefJqDK2+8/YEi+vo8XFKXmUIzBNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=RAIg4WCW; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-66bb4d4fcb4so323577a12.2
        for <linux-nfs@vger.kernel.org>; Mon, 06 Apr 2026 08:36:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775489804; cv=none;
        d=google.com; s=arc-20240605;
        b=gGqv4TLHm5cJ8jBRhBSVdCGaTJTkbpDPRkyDwcWbP4a2Y+ZLVt+byGBjzHrqLSJ5ck
         RThsl3E4kIRw2y3VX2Gy+Bw8Dytq3o1RGSj6gR7Z/n3uJdNpuTYup27QwXu1ryZcCSbw
         zNpTALVDZO1HhwtvML3qAt0+ynlWNGNDoPoASz1mvIoV12TvyhTvv+bGghPliISCxzOj
         +KxuRLCntb8XXDK7p9EnMGf4GevUuIx1yM8RDfhYrEtzoivnu61mWT4ArqQjlaBdiuNW
         tX4V3+5EgBXG5FftJUpS0nDP314UrOormmM/26DoRMbm3xHLEQxed1yqmvWSut5OfR23
         g5Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=UgQ3kilzdn1wSU8YGiV6YiPiIVYJCKcB8o5r7SKjkjw=;
        fh=Iy2qMoYOeiVQ69/VQqoyp0jUMvV0RukjWwJd91fGT3g=;
        b=lbUb+Z6LaZtNkZqiksnRMkZRLzPnbv92pSgwIyI65uVznJBOwMm7H+qUv69IrUkrw0
         Di8LUHIcV+FwGdatzw65RwUJKjORUYahX0Z3M3MC4+Ps4wy9cCaL8ah7dcsK+1jQFEWN
         pd/oMfDK6RVKtdz4b9j+b//6bF4u81lu3OH9NY5jYcV0+V/2UkuhZ6IqZcotROQX8npV
         kakqDVb1/VkEioVs9e2ySABNgGz+DW3Br2GtbYI44wavrQi8SmPaQZ2q6iSPYbHl8ryV
         zhQnr0Tz+9bCqVwxJRmLNMWq/la36K2rUHBPHk5IJ62u4xZvZ6arS06Av5IZDKAkK2Xm
         SMWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1775489804; x=1776094604; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UgQ3kilzdn1wSU8YGiV6YiPiIVYJCKcB8o5r7SKjkjw=;
        b=RAIg4WCWLoRuj2J26ikuZ9XNM44U26bxBzKh8YQ9kx4rsQO92vwN5nuevorDMq1vY7
         0VmQik/iVJdBqS7X9k8UgO0g2yK+E/kPVp/EkLcyv2eVrH2/mJ34SuGXC06G7BnR4FY4
         OhZoGIaQ7M3D6u8JBuATJW+p4TwZWsT6AyOXknxRCB7p2bZ4BbPkbwIQk/czXgxjejPi
         70D2unDeUX1H7g40C5j6CdFjUC6koD4INqQ0xLzofnBIQ2r4Wd6UWs5TqUjmNg+jN2nE
         hYqpxdFqt54syOFjdDUhw3HNpy6zlRZ0C7768SSndg5eZfmMj4oBuntt9ffztccEZFoo
         +uOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775489804; x=1776094604;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UgQ3kilzdn1wSU8YGiV6YiPiIVYJCKcB8o5r7SKjkjw=;
        b=BR792agQ3cY7ZQFEp23zMblb7mOs0BjQdYmmV5KRcr/FWH1D/tgGag/CuzEtDMFrXi
         bHV/W/Q33KcsrJU1TLD632MoSJb8fK6qi3851QOLrlbF6yVHqUdAL1NeCoeCsloeRYdS
         zMsLzqSnLv+dyZC3dMH2HljiV2qlwFnwnMXxnvzOYIzA5PTIr1Y+byhcD6IDrE+vVGVk
         ZyNmFGKfKtK0W5jNbGvRH1AMLrriZbRLRj9cOP0fX/0MQ89XJmQOSakojK7V9XogRmTR
         KTfT1ZJDKDOJWtichCEXK+F4KcKmC5tTfzJ5ERYCYhscE4138z0ylOy6rNuyLLA9lEY2
         MHjg==
X-Gm-Message-State: AOJu0Yzw2pOYxTQxBfGKvclIa4XOPwzD41Z/JHy0dgd8UuqiJJ17yfuF
	yNP18liBt+zUD9L54Zi+WCgdWFwdnwJN4Psm/Er197bKYmgPDhZ9YpCNXkJheINSlfyNH1RGsYl
	8nMjMrTK0GkRzBfnPvapR29wGQCHBJURcW4LEo8QmKiHGtDTV7ovDarc=
X-Gm-Gg: AeBDietrjonnPQ8kW3Oh65PtqGdVo6l5YvT9co+5MoAVPtOYLgBXkai5OSk55DHoc36
	Kbz+d3byt5nZPvIrz7o6eKUbdPCNWYyPyj9kTsCbpV6nbUIJdiv1BDKjO0nV8mH5h6jrBPK5Vur
	Z30SMi/1qjzYzSeavAkawUnEmCYtn3FZOyHKvrzsZXRak5x6tZerKGIWd2TX5gAu1fu9Si0LYXm
	/dkHS7vTbDxycsjTi+uUvBJig2VfMg7fcyX3JwJoQU05pxRVRvBwhd+/mP8Fnx2XO1ObGZEe2ra
	rPtIfHJh9caVkf+bXgy1njSGW8GWAZAkHVQ5xA==
X-Received: by 2002:a05:6402:551b:b0:66e:aade:1a36 with SMTP id
 4fb4d7f45d1cf-66eaade1e47mr2774622a12.6.1775489803767; Mon, 06 Apr 2026
 08:36:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jon Curley <jcurley@purestorage.com>
Date: Mon, 6 Apr 2026 08:36:07 -0700
X-Gm-Features: AQROBzCw7RsqD4JFlpC39KbgviRxEiMtlUySkdRsLJIGs0AHN0LSGExJwFYBul0
Message-ID: <CAHeb9+nedZXHXzeCQOo5tJ_kYAYC=sVrzNEtGBACmQKEis4mJA@mail.gmail.com>
Subject: NFS close does not block when server is unavailable
To: Trond Myklebust <trondmy@kernel.org>
Cc: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,quarantine];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-20674-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jcurley@purestorage.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[purestorage.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,purestorage.com:dkim]
X-Rspamd-Queue-Id: CC50A3A4D00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Trond,

We've recently been investigating test failures in our automation
linked to server failures. What we've noticed is that failures during
WRITE do not block close(). Close simply returns success even though
the writes are in a failure loop.

This is easy to reproduce using flexfiles. For example, the flexfile
RFC states that returning EACCES is a mechanism for fencing files. If
you create a server where writes always return that error, commands
like dd will return success while the writes are in a RESET_TO_PNFS
loop.

I'm not trying to get into an O_PONIES argument here but I always
thought NFS close-to-open semantics meant that NFS close makes a
strict effort to flush writes to the server before finishing.

I've been digging into how the NFS client guarantees writes get
flushed. I noticed that nfs/file.c:nfs_file_fsync goes through a much
more rigorous algorithm to flush writes in the face of server
unavailability when compared to nfs/file.c:nfs_file_flush. The
redirtied_pages interlock is especially critical for ensuring
RESET_TO_PNFS events block the syscall from returning.

At first I thought this was intentional. But after looking at the
history, I found this commit:

"NFS: Don't inadvertently clear writeback errors" -
https://github.com/torvalds/linux/commit/aded8d7b54f250af6deb72fde475291cfba513d1

That diff replaced calls to "vfs_fsync" with "nfs_wb_all" in several
places including nfs_file_flush. Since the diff makes no mention of
reducing the guarantees of nfs_file_flush & etc I'm wondering if this
effect was unintentional?

Does it make sense to modify nfs_wb_all to have a loop like
nfs_file_fsync does? Or introduce a new function?

Thanks,
Jon

