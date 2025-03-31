Return-Path: <linux-nfs+bounces-10967-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3EAA76D4C
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Mar 2025 21:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E62153ACE33
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Mar 2025 19:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA73219EA5;
	Mon, 31 Mar 2025 19:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOp74yRK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5E2218EBE
	for <linux-nfs@vger.kernel.org>; Mon, 31 Mar 2025 19:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743447969; cv=none; b=J/4L9Zi7VpGQojKjbRRCC6Cl50gWG0dQSsn9YLCd1UJzD++VRhRsQtftsF1Z+Lxntql2ZcI1MfOvrjOb2xUpQoefPBpIJ1xe3JWgq/iOAkW225G0af7NSwJ5R+sWL9EwKRYiz70IP32eJpeavVgkw1L6dqBK3oyvn91a6enx+tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743447969; c=relaxed/simple;
	bh=GR/yj15hmT5uoERaorfQ7+FXdrYwo4vABX7fKSX2pAw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ja0zDTZdcdy25p4BCw5EmlO7qWAXuBpF/05d2QTCk1xBFl+/nHIypQAAlg8GvjkLJebuWs20BG1iNLIiEDT//CZB80ZqaetKvfXT/ajmC+pG4psavIHgY84A9x8qx1lnXM2Hysm4mBNKUyMy38wQxs7hbxK2gHtuQ18NceASIno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOp74yRK; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5edc07c777eso4660301a12.3
        for <linux-nfs@vger.kernel.org>; Mon, 31 Mar 2025 12:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743447966; x=1744052766; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GR/yj15hmT5uoERaorfQ7+FXdrYwo4vABX7fKSX2pAw=;
        b=FOp74yRKj+ZZfjiBHWQqzO8vkMpSP0hrzKQxmoqsta6Vv/R8GDN9EeRhODf2E5xYwB
         kCk9DJRZyebfOYIQzEbglye0CZNq6BlUuEqC6OO+rh309kWAg4j13s1uqCrPwInQzdgP
         v0UNdCRCgy5l9hUVFUVmtnqA7l/xKbp7oEGPHnSE2JUKSpqvvrwn3DSI4bzb9CYd2Olu
         FCJ9AmKHlwnbBk3x89dKaNHYFh2jdjC8MDnIZ62qtbcomuSqt9sskSBY4jpYsvqro/Zu
         YpOOTiZSny/jA1zShJ4e5k0x/L2oBf6esX3QWhvHzh1WjrRgqTfef+7Z2XJ7/Ix+1yLs
         KS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743447966; x=1744052766;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GR/yj15hmT5uoERaorfQ7+FXdrYwo4vABX7fKSX2pAw=;
        b=gWA0rah9Og5ESjU2zm5UMwJwy+hhl26Y7Oqqy39GBtq50v4JjMFF83OuY+PDfIVaHz
         7Tdbt88eI8ZIGBrWb91CuK666EnR+2WkhZ0AsSWDAybekyjjzZzPuDge8qD//4T1J7lJ
         hHchRjMKhIBXb8qKXsP8zLx5wvvvZ+WgpKOrYQI5nGBJVjlt1TQEjkPXPIuF9rP09oIH
         zR9Rm9AlVbql1AECJMHeZ6PtZ+ZKRFWm0JfEO1FOKrgvaLSPqi/OO+HCgMEiWafj4lsn
         tWGyMywFjJKt+d+3F6gxiLBpMKUX4xl+R5Lb07BV2CIgGSWchU/XZOzOdD5qqjFz7Pcb
         OHjg==
X-Gm-Message-State: AOJu0YwDI4ACdVnh4eQcJzdcoeDzjF+AtH8+r5dANuJkXNfEjuC8hS8a
	Wir5kgwHDwvf7pdsvel6YsYg1JgYs89LybNfdG2kuELxWq10d5JLDKRHomY/NmfurbfjqfeUlrx
	tCqjxzaJMw7kl5EI3qGbbYf/d6zViXIVoT1Y=
X-Gm-Gg: ASbGncsHmnd+UHXtlQbzPSoUTNG1ZKUKBPvbeQFdhKfVdJC7p2jTffvrQxt2qcoE/Q6
	zhEA7nWj53NwyOzBwjGkrnz3CCkt/QdUwiIkIzE8u8RsRPLYvY3xwEVHNppExvnIApZxZ8gbGuh
	FLMMr771V0gc+RL7CkNO5ywZnXvYuYePI0ofSU6nGg
X-Google-Smtp-Source: AGHT+IGJHTe8KtkbkQMgqzZVZtDmWVeWF+up1vskq61hHnV7erEXqpPUPvHFsxq1EPUF9gPzupLeYMVgFId/LdciAec=
X-Received: by 2002:a05:6402:4007:b0:5e5:c637:b69 with SMTP id
 4fb4d7f45d1cf-5edfcbe9333mr9426925a12.6.1743447965595; Mon, 31 Mar 2025
 12:06:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rik Theys <rik.theys@gmail.com>
Date: Mon, 31 Mar 2025 21:05:54 +0200
X-Gm-Features: AQ5f1JpQU0uXAaGqllwk7B7Yrp5kyOzoA9QcbBfeEqkSOPlrVlddblipoEbrXKQ
Message-ID: <CAPwv0JktC7Kb4cibSbioNAAZ9FeWs6aHeLRXDk_6MKUik1j3mg@mail.gmail.com>
Subject: Memory reclaim and high nfsd usage
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Our fileserver is currently running 6.12.13 with the following 3
patches (from nfsd-testing) applied to it:

- fix-decoding-in-nfs4_xdr_dec_cb_getattr
- skip-sending-CB_RECALL_ANY
- fix-cb_getattr_status-fix

Frequently the load on the system goes up and top shows a lot of
kswapd and kcompact threads next to nfsd threads. During these period
(which can last for hours), users complain about very slow NFS access.
We have approx 260 systems connecting to this server and the number of
nfs client states (from the states files in the clients directory) are
around 200000.

When I look at our monitoring logs, the system has frequent direct
reclaim stalls (allocstall_movable, and some allocstall_normal) and
pgscan_kswapd goes up to ~10000000. The kswapd_low_wmark_hit_quickly
is about 50. So it seems the system is out of memory and is constantly
trying to free pages? If I understand it correctly the system hits a
threshold which makes it scan for pages to free, frees some pages and
when it stops it very quickly hits the low watermark again?

But the system has over 150G of memory dedicated to cache, and
slab_reclaim is only about 16G. Why is the system not dropping more
caches to free memory instead of constantly looking to free memory? Is
there a tunable that we can set so the system will prefer to drop
caches and increase memory usage for other nfsd related things? Any
tips on how to debug where the memory pressure is coming from, or why
the system decides to keep the pages used for cache instead of freeing
some of those?

I've ran a perf record for 10s and the top 4 of the events seem to be:

1. 54% is swapper in intel_idle_ibrs
2. 12% is swapper in intel_idle
3. 7.43% is nfsd in native_queued_spin_lock_slowpath:
4. 5% is kswapd0 in __list_del_entry_valid_or_report

Are there any know memory management changes related to NFS that have
been introduced that could explain this behavior? What steps can I
take to debug the root cause of this? Looking at iftop there isn't
much going on regarding throughput. The top 3 NFS4 server operations
are sequence 9563/s), putfh(9032/s) and getattr (7150/s).

Regards,
Rik

