Return-Path: <linux-nfs+bounces-8228-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C579DA0A2
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Nov 2024 03:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D2CE168A2B
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Nov 2024 02:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F15208DA;
	Wed, 27 Nov 2024 02:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3dPMykR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340211BC3F
	for <linux-nfs@vger.kernel.org>; Wed, 27 Nov 2024 02:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732674898; cv=none; b=RNF9KYFVIrGycJt9GNRgWe79P5dGd/BsmboE4aZSyENZmvG+l3BQsy6n2wki1QXKrWYu7K5YWBB55klMXrA8VKsdkaUZeCwsbM/f3FXs9FN10rmpradK7aVHRmBVyQ3aSItSANHtsvcjtidBnaytfDx0AJ6n3rFp71k/s5p+Pgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732674898; c=relaxed/simple;
	bh=NLiLbggvU3pDFHuKCYqDQSTx9T16voiBmVDdAvEU6R4=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:Subject; b=qVL4rqt4t0x/10Qup1ER555OTr1LBGxwR+iM9cl7ofqf+w1ITUy670fd46hzg/O71tazkwHxBMhNs859ccf05qwHukfVbzr18T5amSmlhG5geds8YJmb50VQjeoqSI0fLPzfDYBKxBI82T8ohT5jQDzbD4V9O9qdhNoS+DtGQng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3dPMykR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7720C4CECF;
	Wed, 27 Nov 2024 02:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732674897;
	bh=NLiLbggvU3pDFHuKCYqDQSTx9T16voiBmVDdAvEU6R4=;
	h=From:Date:To:Subject:From;
	b=R3dPMykRde3lLFE579ttAx65MWHGOvmgN+fAzTuRnjoHjuJIPCMJjZhDPRVQyI53C
	 ONbm3Rfy6hI+hKJZSF4d0irhPWOjEvF3+m0mti0bDtP0lkA90zQ6tDk9FfLgyfmz/X
	 hC0o2mC+2I7In+uXj86tvojxHI4zrR6H7lvkz9Xge6cXBpwVmWgtvIEzUk9s2j6wsh
	 a8To8kAr9Ua+YwwiJF91rPLMM/u6qVg8psNN9iN/HZ543ol3JKCnKB17HS7JqwFR/Q
	 wJJOdWDK6K8OWjX0ticYgOjhtcYbOUxiGlcurZHww7QNbOb7P1oH+WaETU7RlFibmK
	 AZs7ehJ3VMfMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B34133809A00;
	Wed, 27 Nov 2024 02:35:11 +0000 (UTC)
From: Chen Chen via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 27 Nov 2024 02:35:07 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-nfs@vger.kernel.org, trondmy@kernel.org, jlayton@kernel.org, 
 anna@kernel.org, cel@kernel.org
Message-ID: <20241127-b219535c0-4d5445e74947@bugzilla.kernel.org>
Subject: Possible memory leak on nfsd
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Chen Chen added an attachment on Kernel.org Bugzilla:

Created attachment 307283
sar -r mem usage

My RHEL9 server with only NFS service often OOMed after a day or two, with no userspace memory usage. So I switched to elrepo kernel-lts and still the problem persists.

I'm now using 6.1.119-1.el9.elrepo.x86_64. The problem also occured on (RHEL) 5.14.0-427.40.1.el9_4, (RHEL) 5.14.0-503.14.1.el9_5 and 6.1.115-1.el9.elrepo.x86_64.

I'm not so sure it is caused by NFS but since it is the only service running on the server I can only suspect it is the culprit. The server has a Mellanox Technologies MT27500 Family [ConnectX-3] Infiniband Card and NFSoRMDA is enabled. No 3rd drivers used.

The following data were gathered moments before it OOMed and crashed

sar reported a typical memory leak appearance.
01:20:13 AM 390187300 388732764   3501864      0.89      4856    363952    390344      0.09    100680    358384     17148
01:30:13 AM 379492128 378312768  13642416      3.46      4856    909388    390344      0.09    108844    895740        16
01:40:13 AM 367687716 367062060  24851416      6.30      4856   1498272    390344      0.09    116736   1476672        16
01:50:50 AM 361704244 361471420  30437312      7.72      4856   1888780    390344      0.09    127888   1856036     29912
02:00:13 AM 355796296 355848120  36061648      9.15      4856   2173560    390344      0.09    131544   2137152         0
....
09:00:13 AM   1518392  18089616 373760196     94.79      4760  18648816    390344      0.09    470608  18273412        36
09:10:13 AM   1499980  17223900 374626172     95.01      4740  17801676    390344      0.09    471964  17424672      5292
09:20:13 AM   1561896   6784736 385059756     97.66      1712   7338540    423580      0.10    325452   7070372         0

meminfo also didn't show anything using ram.
MemTotal:       394292660 kB
MemFree:         1551296 kB
MemAvailable:    6776108 kB
Buffers:            1712 kB
Cached:          7340144 kB
SwapCached:         4308 kB
Active:           325936 kB
Inactive:        7071836 kB
...
KReclaimable:     129816 kB
Slab:             331596 kB
SReclaimable:     129816 kB
SUnreclaim:       201780 kB
...
VmallocUsed:      319528 kB

slabinfo is low. Attached.

vmallocinfo doesn't have much. Attached.

dmesg log showed it has killed nearly every userspace programs.
[29960.547403] Tasks state (memory values in pages):
[29960.547404] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name
[29960.547412] [   1020]     0  1020     9498      640    94208     1000         -1000 systemd-udevd
[29960.547417] [   1247]     0  1247   105208     6888   126976        0         -1000 multipathd
[29960.547421] [   1342]     0  1342    23190      330    65536      764         -1000 auditd
[29960.547428] [   1472]     0  1472     4185      806    73728      357         -1000 sshd
[29960.547438] Out of memory and no killable processes...
[29960.547439] Kernel panic - not syncing: System is deadlocked on memory

systemctl status attached. Nothing else is running.

I have a 224G vmcore dump but have no idea how to deal with it. And it is too big to upload somewhere I think.

I appreciate any help to help me detect what went wrong.

File: sar (text/plain)
Size: 6.95 KiB
Link: https://bugzilla.kernel.org/attachment.cgi?id=307283
---
sar -r mem usage

You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


