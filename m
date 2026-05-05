Return-Path: <linux-nfs+bounces-21395-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NKaED4++mmjLAMAu9opvQ
	(envelope-from <linux-nfs+bounces-21395-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 05 May 2026 21:00:14 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E344D2F7D
	for <lists+linux-nfs@lfdr.de>; Tue, 05 May 2026 21:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31D1F304DA3F
	for <lists+linux-nfs@lfdr.de>; Tue,  5 May 2026 19:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655453CF683;
	Tue,  5 May 2026 19:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrzyDmIi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4200A3C660C;
	Tue,  5 May 2026 19:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778007610; cv=none; b=Vqg5amDzcFjvN46J2ADpcWr044lWhv39kEO9HpNcqzIbjdru0404z/5JtM1BlnXeJuMFN6KwZAm7DzoapsSdhdrwAPav5GZTvTeNFNOCrUFvRB74pmBVfdIa+mGlIikyv0a9tP4MZ3xl9743uil6tMD7LyugJ93coVHLFv5zhJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778007610; c=relaxed/simple;
	bh=hUj4YFzyO1VXcjqqW/XO6RlSLO5yLEQJ7wt0RMQ7kic=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aZCQ9nnOosFcwqrb2amcFf4jN/zK+uM091YDQtRxzggdQ6n8LCZtuG9Ut9dEg8phfqWJFWu+avyYOsYtgxuhg86Z7i3F612aehBPWw9yefhQihEdHHilgqsMKHSd4VHkso1mre1+kj3KTFgZrvbyGNZTpc8DIouGL2szeDvDS8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrzyDmIi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A648C2BCF4;
	Tue,  5 May 2026 19:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778007609;
	bh=hUj4YFzyO1VXcjqqW/XO6RlSLO5yLEQJ7wt0RMQ7kic=;
	h=From:Subject:Date:To:Cc:From;
	b=HrzyDmIi/+ayr0xH1WwgbouUwEqFC8bCu87Q2Vsyqpik6u3B2amiBcibYEJOAAHd4
	 TcI/Re8FV9tRgjkPEjygpHYLnh2nowtaKL+o+A2qW5ORWlAcGz6sdClgD4iCx3LwJC
	 apNag9aoicNru0W117LCEgWF6wcE6IFDzAZkGodw8hWICUank7K88/J6YOHhm99O0F
	 NKwFBiWe2g4Dlv5C1ddhdThbqmrPyS1OBtIXuQXv4FP90gvzYJndUrAiABf5yRPHey
	 rgDlgHsrKH2WCSMq5jkdX1IT6Hcma7Y/KYDRZR2XPe+k2XTNaJ8/Lb8TX/aJzEGdnB
	 7cq6RDQxX3XbA==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v6 0/2] mm: improve write performance with RWF_DONTCACHE
Date: Tue, 05 May 2026 20:59:47 +0200
Message-Id: <20260505-dontcache-v6-0-66463805dd6a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23Oy07EMAwF0F8ZZU1QHnbSsuI/EIs8nGkEalE6q
 kCj/jue2ZBRWV7L59pXsVKrtIqX01U02upal5mDezqJNIX5TLJmzsIo4xQoLfMyX1JIE0kctKa
 SPYViBe9/NSr1+9719s55qutlaT/36k3fpv+1bFoqqQt6cCVE8OH1g9pMn89LO4tbzWZ6OvTUM
 B1hyJQ0eXTxQG1HjeupZepHitbnMCL4A4U/io8PA1PMSC4nr1O0B4o9hZ4iU9DKEg6RTz9e3ff
 9F4+r6G6PAQAA
X-Change-ID: 20260401-dontcache-5811efd7eaf3
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Ritesh Harjani <ritesh.list@gmail.com>, 
 Chuck Lever <chuck.lever@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3145; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=hUj4YFzyO1VXcjqqW/XO6RlSLO5yLEQJ7wt0RMQ7kic=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp+j4ut1McCVLFPCo4dnsOZJGkCnEndrsyYF/ov
 9xNqF5D4CGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCafo+LgAKCRAADmhBGVaC
 FSXyD/9Ab7U6obJOZVWw7dNHbbxmdELBm7YXZHN+bn0wBFwoMj8LnuLVgv9qzU6BB1iH8cwjSxw
 uIooxJ++hQh8paEqfZJxOb0wGg/SvhljFvg3ClKT5twqy0/uf+MBunz8MMiNgZGEYns+m/Ip2QG
 FIBVdQ9Jwavv7s7XffR0Z4I30uo0TIYNgA+iE+MC9YAQBF3Jldv+uWLtJNK/VI0a33x95PSH08r
 3yzXhSP+9zm/2TKeow2JnqwoKMeXCSoRsAujGJ8HWjSVeavOkFp1tgWhF8hildAohpnYVOd8zG8
 nEeHwA8noNTnO4s5VltTqf5P2FkPZBzOvW1Xe+1Ecxt/NSQdMGQ3T/wUdOeZeSQhHveJ6JktJV6
 LrvHxfsS738cNfr+gM/6FbPd4l4TNgdJlOzsQkybiRhj/62/3i+x9DrEl1uy6d0wa1o3SrOFnKP
 nK4Jb/6tJzpueCWu7NwafB8lI/S8l9ZXeFzPi/Qg/baSVF4yavGKIXI0tFnAz/cb3zp+lCyZXni
 ifs0gDEz1lH0n4r/yrx2xbFy+zXKu3FaXT347PWK+F3zwOQq4PodXAVLXce7YyNR3zL7LdbI3TD
 in1EB020peBLAmtzhm+CyNWNOTpGjPfahPjO0pD8XRHBwbyakYeNigDU1b/T//hUzln2NxpQzTR
 fJIV5ho33fvdWdg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: B2E344D2F7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21395-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,infradead.org,linux-foundation.org,oracle.com,google.com,suse.com,kernel.dk,gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]

This patch series is intended to improve write performance with
RWF_DONTCACHE. After sending v5 yesterday, I decided to check what
Sasiko thought about this series, and lo and behold it had found a
number of bugs that I had missed before. This set should fix them.
Performance is identical to the v5 set.

Because there are some substantive changes in this set, I've dropped the
R-b's. Please resend them if you're OK with this version.

Christian, please consider these for v7.2.

Thanks,

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v6:
- Use atomic folio_test_clear_dropbehind() in __filemap_get_folio_mpol()
  to prevent double-decrement of WB_DONTCACHE_DIRTY by concurrent readers
- Add mapping_can_writeback() guard before decrementing WB_DONTCACHE_DIRTY
  in __filemap_get_folio_mpol() to match the increment path
- Use wb_stat_sum() instead of wb_stat() in wb_check_start_dontcache() so
  small writes below the percpu batch threshold are visible to the flusher
- Use test_and_clear_bit for WB_start_dontcache before starting writeback
  to prevent lost wakeups from concurrent DONTCACHE writers
- Move wb_wakeup() outside the unlocked_inode_to_wb_begin/end section in
  filemap_dontcache_kick_writeback() to avoid spin_unlock_irq() re-enabling
  interrupts while the i_pages xa_lock is held during cgroup writeback switch
- Drop Reviewed-by tags due to substantive changes
- Link to v5: https://lore.kernel.org/r/20260504-dontcache-v5-0-4103e58bb377@kernel.org

Changes in v5:
- Flesh out comment over filemap_dontcache_kick_writeback()
- Drop testcases from posting
- Link to v4: https://lore.kernel.org/r/20260501-dontcache-v4-0-5d5e6dc71cb3@kernel.org

Changes in v4:
- Track DONTCACHE dirty pages per bdi_writeback
- New benchmark for competing buffered and dontcache writers
- New benchmark replicating Jens' original 32 concurrent writer test
- Link to v3: https://lore.kernel.org/r/20260426-dontcache-v3-0-79eb37da9547@kernel.org

Changes in v3:
- Track dirty DONTCACHE pages in the VM
- Have flusher write back a proportional number of pages after DONTCACHE write
- Link to v2: https://lore.kernel.org/r/20260408-dontcache-v2-0-948dec1e756b@kernel.org

Changes in v2:
- kick flusher thread instead of initiating writeback inline
- add mechanism to run 'perf lock' around the testcases
- Link to v1: https://lore.kernel.org/r/20260401-dontcache-v1-0-1f5746fab47a@kernel.org

---
Jeff Layton (2):
      mm: track DONTCACHE dirty pages per bdi_writeback
      mm: kick writeback flusher for IOCB_DONTCACHE with targeted dirty tracking

 fs/fs-writeback.c                | 59 ++++++++++++++++++++++++++++++++++++++++
 include/linux/backing-dev-defs.h |  3 ++
 include/linux/fs.h               |  6 ++--
 include/trace/events/writeback.h |  3 +-
 mm/filemap.c                     | 15 ++++++++--
 mm/page-writeback.c              |  6 ++++
 6 files changed, 85 insertions(+), 7 deletions(-)
---
base-commit: 7e2326f4275c11652e1fdaae11de06159fef1d90
change-id: 20260401-dontcache-5811efd7eaf3

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


