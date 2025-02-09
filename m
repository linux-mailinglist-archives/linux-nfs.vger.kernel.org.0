Return-Path: <linux-nfs+bounces-9976-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC565A2DDB7
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Feb 2025 13:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA5FB3A5CA3
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Feb 2025 12:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB18E1E502;
	Sun,  9 Feb 2025 12:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bm6/JGEi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28551DFFC;
	Sun,  9 Feb 2025 12:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739104293; cv=none; b=XXwzlIk/oH+lEPZ1nkayNqUhwCxxo+m1xg/2KYvANJBKz4FVLQC3Hk8YkuIRgnm9e4C/qoVj9xVWi0aP4gvuvHXm1jRAI92RlOkcOY7xLv034vT8MLfpkg0XuZOuI/5SBwFDAVKnDF38JiSGeS1SyDBVSw/kvSc7J8K0L6A4Rq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739104293; c=relaxed/simple;
	bh=xgyMYunAKrmLnsZ2HxhpB/hj1jNPZs7g3kNXrwB1ZHs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lLyw0DrFMLlrjAUXcgpKq4IOLh0szQyO+ysRarQRkwztzgdC7wgSmwWBFMeoE1sQLPSR2puLealGpEfRUw36UqDtG/T8zLn0e+lkM64957B4VfDDJ1HESMeiII7zNLG3ciYzoiF0KGTM07So9DnXl02zIRfwrTAOpa/HZJHPXl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bm6/JGEi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72341C4CEDD;
	Sun,  9 Feb 2025 12:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739104293;
	bh=xgyMYunAKrmLnsZ2HxhpB/hj1jNPZs7g3kNXrwB1ZHs=;
	h=From:Subject:Date:To:Cc:From;
	b=Bm6/JGEiHWYbxOyqCAmgmj/tK0yuEJ28OU+dRqWNIBE1L6xGCSVBiCHM8c10fzNFZ
	 LNXOb5ttpCsXQ3Hiayby9gh8BWf/9qpsn0M0+WUhWIJXBgQ8Cy9WDDBSzPemfWy+Hc
	 9yeBPbHf2BowbBH3f3fhZ5PE9Rk+LB5HiT0mtp6bFLQlLZiqGjK5yxo5ftDS6xU4bW
	 mwb+l3vNzil8XiAsTY9CM2h78j4MQWLUBwb03YIjZnDJmPsEWPWfgufrwR76Egx7uO
	 ie7oabgLIXRo/vXciAFd6CovL3j7mGoPrHAFqzUlekrzB7pdR3oCmKEnRwbmOq/NlY
	 ZZQWcuSZr4aWA==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v6 0/7] nfsd: CB_SEQUENCE error handling fixes and cleanups
Date: Sun, 09 Feb 2025 07:31:21 -0500
Message-Id: <20250209-nfsd-6-14-v6-0-396dd1bed647@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABmgqGcC/3XQQW7DIBCF4atErEs1DAPUWeUeVRcYDwlqZUdQW
 a0i372TbOrIyfKN+P4FF9W4Fm5qv7uoynNpZRpl+JedSqc4HlmXQbZCQAcGrR5zG7TXhnQPoQt
 s39yQQMn7c+Vcfm6t9w/Zp9K+p/p7S8/men1UmY0GnYyxIVKOGPnwyXXkr9epHtU1M+OadmuKQ
 jEApA6zZaINtU+pFerAczBsO/b9htI/RQhrSkJNjISJIKB3G+qeUic0295R7j3It93RZVn+APC
 UrZ6PAQAA
X-Change-ID: 20250123-nfsd-6-14-b0797e385dc0
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2467; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=xgyMYunAKrmLnsZ2HxhpB/hj1jNPZs7g3kNXrwB1ZHs=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnqKAepepsTgc6o+inHrzoiGEhDhg0xLGSqqT/5
 m2HrLubsm+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ6igHgAKCRAADmhBGVaC
 FYnvD/9knj251AkFXgyGebpO9EfZS1FWsWRxM1qZi7zGQgt1j9YYaq1G4v4xTwwNCgAvkm7V6C6
 rHngopv0kSyaZQ/NJxmj1gdWzJeeEItVzqnIUhsUkdTdvNlTZj763KVSA3tvvO7chOkdC5oTjdm
 xV3n6HfwfPeUO1vB5lZbI+idzq+DL+5GQeaMZXPZUL/LOiRVeLRuSSSDzIesjVxQKCvsSsAEsis
 LhSnwGJVZftPXIqF4nWuOV8T2u854GQhZfOZ/ap3cV94mGSmMdB7iKuGYQFvcMeGbJtwGDbbAvG
 O13A4ESaAcKlsLFnefd70EPtnZ7CC5xyJfFXbLNtujsQom2zAQsisMYlSje/XJzLvGVPisCuqKj
 mhZkoBFK0Id4eranP1pYc+CvTLczHVnLB0EzWWQ8LKxZ2ImqsleQV1wh/4ARlSVY8TBaUI55U8s
 m0Ilv4Ffa+Dy6ybE/lAu4zFg5+UHD6DvRg4xTQhRniQiWU1jbNVZSj7qqBxMzS42K3E680FcWAc
 nS4cjz7Skp5KWklzT/ZzmmGt/liE7qe7VqQqbLVpwIQWflvZLEhOeFS/e6hZZETLy/dVS6spiUz
 7xzgXKdudi6EvODOLS/ANUsvnReN9jN4Ad145ngl+41HXssyGq0TCVpoiMCqxK3tEzW7q9sr2UE
 0ukAl04g3krfiuQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This patch is mostly the same as the v5 series. Just small cleanups
and dropping of special NFS4ERR_SEQ_MISORDERED handling.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v6:
- Reorder patch to move v4.0 handling to earlier in series
- Drop special handling of NFS4ERR_SEQ_MISORDERED. Always treat it like NFS4ERR_BADSLOT.
- rename requeue_callback() to nfsd4_queue_cb()
- Comment and changelog cleanups
- Link to v5: https://lore.kernel.org/r/20250207-nfsd-6-14-v5-0-f3b54fb60dc0@kernel.org

Changes in v5:
- don't ignore return of rpc_restart_call() and rpc_restart_call_prepare()
- Break up the nfsd4_cb_sequence_done() error handling changes into multiple patches
- Link to v4: https://lore.kernel.org/r/20250207-nfsd-6-14-v4-0-1aa42c407265@kernel.org

Changes in v4:
- Hold back on session refcounting changes for now and just send CB_SEQUENCE
  error handling rework.
- Link to v3: https://lore.kernel.org/r/20250129-nfsd-6-14-v3-0-506e71e39e6b@kernel.org

Changes in v3:
- rename cb_session_changed to nfsd4_cb_session_changed
- rename restart_callback to requeue_callback, and rename need_restart:
  label to requeue:
- don't increment seq_nr on -ESERVERFAULT
- comment cleanups
- drop client-side rpc patch (will send separately)
- Link to v2: https://lore.kernel.org/r/20250129-nfsd-6-14-v2-0-2700c92f3e44@kernel.org

Changes in v2:
- make nfsd4_session be RCU-freed
- change code to keep reference to session over callback RPCs
- rework error handling in nfsd4_cb_sequence_done()
- move NFSv4.0 handling out of nfsd4_cb_sequence_done()
- Link to v1: https://lore.kernel.org/r/20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org

---
Jeff Layton (7):
      nfsd: prepare nfsd4_cb_sequence_done() for error handling rework
      nfsd: lift NFSv4.0 handling out of nfsd4_cb_sequence_done()
      nfsd: always release slot when requeueing callback
      nfsd: only check RPC_SIGNALLED() when restarting rpc_task
      nfsd: when CB_SEQUENCE gets ESERVERFAULT don't increment seq_nr
      nfsd: handle NFS4ERR_BADSLOT on CB_SEQUENCE better
      nfsd: eliminate special handling of NFS4ERR_SEQ_MISORDERED

 fs/nfsd/nfs4callback.c | 100 +++++++++++++++++++++++++++----------------------
 1 file changed, 56 insertions(+), 44 deletions(-)
---
base-commit: 50934b1a613cabba2b917879c3e722882b72f628
change-id: 20250123-nfsd-6-14-b0797e385dc0

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


