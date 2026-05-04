Return-Path: <linux-nfs+bounces-21381-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHFXORqe+GnHxAIAu9opvQ
	(envelope-from <linux-nfs+bounces-21381-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 04 May 2026 15:24:42 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAAA4BDD45
	for <lists+linux-nfs@lfdr.de>; Mon, 04 May 2026 15:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D7703029AAF
	for <lists+linux-nfs@lfdr.de>; Mon,  4 May 2026 13:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3395C3DB622;
	Mon,  4 May 2026 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7l0O4kJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEB43DA7FD;
	Mon,  4 May 2026 13:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777900883; cv=none; b=mK4r6bEN7lNb7Dn0eI+uhdP1SL1po+opr8Oc355rmWTIM32SbPz3BBWHANSCqNmMJlpPUb4AJOPT76nAYwRhGFDQoaNn9lh30YA9WWbxg63vnkCE1z1bppllIXzGSqmJAFyoSuah0mYQ4MA49R/wldUfuNC4hEpu4A4hc9aIrx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777900883; c=relaxed/simple;
	bh=SsHtuEPvGC3kyViuoLWSWyShZ8L4lLLvmBTowmvnfOw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JuQKga+dOXvCiBzKknz48+BnRdc8atSLMVYxZ5d5Nk6mu+FtHFH5DDVbfgs/Haq3ZRXBX7PMqK2eMasUVTOBFYTjEOxN+GeNCxcQ0eJfixJpFrxCPn030J++jy52PDMMv9SnDXPtLAOEd8a6DuSwi1mchIY4pneNXAAcZ87+mFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7l0O4kJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28826C2BCF4;
	Mon,  4 May 2026 13:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777900882;
	bh=SsHtuEPvGC3kyViuoLWSWyShZ8L4lLLvmBTowmvnfOw=;
	h=From:Subject:Date:To:Cc:From;
	b=K7l0O4kJZCLYDWotuijxec7A/xwyoCOvwmYYi2PUdgjRgJuZ/MEWmBcUX26fMOPR5
	 mxPju0yWy8px3fAJY6DdiMKgG8ZF0udYivMlcMlfpi1TKJxgUq7wO44Sldqw4GiUae
	 5yPw/Ds40wfJN/DD4r1xeK+wNjD6ncvH19tpnLMjKTqSxmZWTZ0y9vYuRxYCFRY4IA
	 dBGoZtFpLZRuGT8naRyxh8X/nlm7SsNXp7HhVt5dbHRKDEXjOVAmhTPDVoONzFkN4Y
	 wWuRzLi7SW+VnzteRKKW5N+jHVwFI29B2lzkVoyrnOTJi+Whk7hxabDnWB3zgIiqHk
	 aRJR6j0rXWk1g==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v5 0/2] mm: improve write performance with RWF_DONTCACHE
Date: Mon, 04 May 2026 15:20:48 +0200
Message-Id: <20260504-dontcache-v5-0-4103e58bb377@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23OTQ6CMBRG0a2Qjq3pf8GR+zAOSvsKjQZMIURD2
 LuFiSU4/F56bjqjAWKAAV2KGUWYwhD6Lg15KpBtTdcADi5txAhTRBCKXd+N1tgWsCwpBe80GM9
 Rev+K4MN7a93uabdhGPv42dITXa//KhPFBFMvtVDe1EKb6wNiB89zHxu0ZiaW0zKnLNFKlA4sB
 S1VfaA8o0zllCeqK6i5dqaSQh+o+FG5/7BIVDoJyllNbc13dFmWL0iLHUlUAQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2206; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=SsHtuEPvGC3kyViuoLWSWyShZ8L4lLLvmBTowmvnfOw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp+J1HUxBqaLQjgCmtV9FQgaX1q7xykjnH1MdED
 XG4LdEnZ5yJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCafidRwAKCRAADmhBGVaC
 FT1ID/4v6frEoJvAxeSGYv6e9p/nY2D3grfvnZonYLx/8O6bEEXepiGYt87s15VkD16BKBrAU1a
 ZUz8YMo3qulYi9Z3jAbLKr+1/gRvZN8nB/IguyYH/uYnosVnG7Srrcr4s+E//zmCQAAu2xItU69
 jeLIH/hTGVxMWYoBOMIrjr9137jt0n8ryEGEgdU6B4GoT9kyjM+PJ/wGPaKXK8SouVlLi6P2mHE
 yLcy1EcId1bXp+jRJ+68otJOL8FJAt7HaF4v3vKA8hRJ/j2A8giDbdAWxgdV8ahJKkzVSVvmSPd
 ZxQSusSneZtCMsq37ksFn7zVrjz3Gd+53PVhvoh8JUHzKMNyStomcghTJbqNUcxAGZxrsr/koTz
 f1eg+s5bzEgOrm2x0EXYf5ZUr7avZGzBFS79fzv1DaXgMmZMTOuXT2R48pJrLLH6B0272iCuaq+
 PTagZ5jWGf33t5+6iOHLmlkkBj/CH8TVgHppY3quZK4XRcm9vPkhLITPrJFropMVt8g+U6lXNdZ
 LWl9YWSZ1AC05upca4sFeg1cCE79f0tUiO0kvqnQSVnTUTAvzkO4pwTTKUHk1RjuPAUQWH+QqXf
 taQ1YsGMF2Ry4zp3fuz+tEarwDz1M7kN3CmgK0jPL0RU6ZQOAWNdKV1TdCAuX1TfMRpAy68hfXK
 e33FyYtpAWTdxzA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 8AAAA4BDD45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21381-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,infradead.org,linux-foundation.org,oracle.com,google.com,suse.com,kernel.dk,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

This patch series is intended to improve write performce with
RWF_DONTCACHE. The main difference in this version is an updated comment
over filemap_dontcache_kick_writeback(), using the verbiage suggested
by Jan.

I've also dropped the two patches that add the benchmarks that I was
using for testing. I don't think they're appropriate for inclusion here,
though we could consider cleaning them up and adding them to xfstests or
something if there is interest.

Christian, please consider these for v7.2.

Thanks,

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
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

 fs/fs-writeback.c                | 65 ++++++++++++++++++++++++++++++++++++++++
 include/linux/backing-dev-defs.h |  3 ++
 include/linux/fs.h               |  6 ++--
 include/trace/events/writeback.h |  3 +-
 mm/filemap.c                     | 13 +++++++-
 mm/page-writeback.c              |  6 ++++
 6 files changed, 90 insertions(+), 6 deletions(-)
---
base-commit: 7e2326f4275c11652e1fdaae11de06159fef1d90
change-id: 20260401-dontcache-5811efd7eaf3

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


