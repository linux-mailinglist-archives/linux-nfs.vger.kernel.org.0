Return-Path: <linux-nfs+bounces-20956-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIvqEqIk5WmXegEAu9opvQ
	(envelope-from <linux-nfs+bounces-20956-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 20:53:22 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF1E4251E5
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 20:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FD20300B06E
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 18:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689B829D287;
	Sun, 19 Apr 2026 18:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0f1+UAT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425791E9B3D;
	Sun, 19 Apr 2026 18:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776624799; cv=none; b=DPUXODh53KPc8XdaKm8D01JfcmAwo1Mwa+4iqMG0TfccV8lDqW5TdIXnMrTcFe+qxi/qfNpHrfcNPjxlVo6agqBNDGSE1PSYEYGaPHiLXjvcYVkO4MC0r0LtbPAoq41IdoiXfqmx7EmDt24x4Z0r+mtoWl2zMc0IBqsGJkkITqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776624799; c=relaxed/simple;
	bh=5CYyBv52KXS0vL40aurpyoxMn2/84aAMqPQbKfpGtJg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MT5lkf4WXNhnO+k57NeIJO01hnaQzGGKlnJdsj+f/oSyPOmPC1DcYpqi3yIhdKauWqUL0fTUX0zR7iQd/BQpDFkdzP07PlAJTJhyG/wA8hLrlvfbmN1hnkRH8To44URThLiyYs/Mg5iuoyad4L+D0pcZUJKglNUejgsl9u6E9I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0f1+UAT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3708EC2BCAF;
	Sun, 19 Apr 2026 18:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776624798;
	bh=5CYyBv52KXS0vL40aurpyoxMn2/84aAMqPQbKfpGtJg=;
	h=From:Subject:Date:To:Cc:From;
	b=n0f1+UAT6twCQ3qkODZxc9mR7ch00vIU6UGo4O2PZbLTLxD9pj4iMJNHEuvHSKP2m
	 39WuOZ9YRiD4p3JUa6xXVt5RlSVlBvK0QZYO82+fxBxGSwbH2XL5Nrp5CvdkNnQRGQ
	 FbJD1OPxyuAydEP85vDRZMdGxmchMFw9XRAP5LRJcts79ecsLS0tMewo17LaooYirF
	 gaWcZMixpXxXlAJzYLwHr6FN1FZLLt93QT1gXwkVv9De/otDOwXV533LlS6sX60nIT
	 JLunxZk9JrDPAcvCLZ8Zw1yq585dU/HNvp93l23gS4dAOp/CL8dN3TETli0GN4CGcQ
	 j7kcqNV6FluZg==
From: Chuck Lever <cel@kernel.org>
Subject: [PATCH v9 0/9] Automatic NFSv4 state revocation on filesystem
 unmount
Date: Sun, 19 Apr 2026 14:52:58 -0400
Message-Id: <20260419-umount-kills-nfsv4-state-v9-0-0660bd06d2b6@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIok5WkC/43QzU7EIBQF4FeZsBblp1DqyvcwLmi5tGgHDNBGM
 +m7C+PCMU2a2XHI5cu5XFCC6CCh59MFRVhdcsGX0D2c0DBpPwJ2pmTECJOEU4WXc1h8xh9unhP
 2Nq0NTllnwJQrRpVltgGCyvPPCNZ9XenXt9+clv4dhly9OtHrBLiP2g9TvQrRjc4/FdPgDCk7P
 9apyaUc4ve14dpU7Y4y5UCwkFqbptF9p9hLiHqY4XEIZ1TbrOJGYvJAEkUybADS0p6LluwkeSN
 xeiDJIlHFBLGdsIzpndTeK7W1kzIMADpuBd9J6k9qyNE/qSJJIExTQ7iR/7fbtu0HGZgZwCECA
 AA=
X-Change-ID: 20260318-umount-kills-nfsv4-state-138218f2f4e0
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>, Dai Ngo <dai.ngo@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4004;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=5CYyBv52KXS0vL40aurpyoxMn2/84aAMqPQbKfpGtJg=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp5SSU1ojjo6uMbY1pgN47c/k1f2dMj/4ylpWv0
 SdwxTvml1aJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaeUklAAKCRAzarMzb2Z/
 l6JAD/4leSl5/97+nkGyvUqvc+8q/Du6qxFJBrhnLYtIFbSybf4Q//Be6NB05yJnCX3wE1EXQMO
 Jd5SLV3xmCsFQusEs50/3fd02f8xW3glVhoAZgpEZBdADwrgGBe0mozH1Tj4/Mqr+M8bZMpPQHt
 YIgowfXJkmKoDAmptH6cITHie33PFbal7xyySaduTNufm+6LUEO9WHHZ9FFbmQSUuZJN4WHpIpP
 YKp7AjvnKtnzV+FZMj/kkaE23eEWgm6fpecwehPWmu8GRMM32YzNuM4DC6QXN+CQZNG+3GQe9mV
 HlloeqTLcWn+bqbyoWdB5Rqnd89Zo6b1zWIfbMH/ialH5OJh8e0Xph+DLhdpvBQ4MnKajSAY4m+
 7B3YLRc7pEytB6KQjm32UDtBODVXSMfGUtybMkclp+rJU52csXbUQzbGNLwzWu2H/UbYVIbpyHe
 yYtKxExn5/8ciK8mp4mTlr4zQjcVWYGXP1vR/ScduZOME52daojpm0u62HOpSKroyh6S41RR/0M
 YdeVrkEgXMoZ3syMKTpUD+MWm8IBk40j32gizH5+L/zlz6fqT0u1bppOyjVwKSRjSPij+nWnV/R
 1DLfqOqOtjXxtYn2tDl3DeSFpbiIvkhl6+Hs/Zz7MJf2ymGGuLvEFaOLK0rLhrIE63ZeG9BxSa3
 CipDn38wMz2+qpA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20956-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9BF1E4251E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When an NFS server exports a filesystem and clients hold NFSv4
state (opens, locks, delegations), unmounting the underlying
filesystem fails with EBUSY. The /proc/fs/nfsd/unlock_ip and
/proc/fs/nfsd/unlock_fs procfs interfaces handle this, but have
no netlink equivalents, and unlock_fs operates at whole-superblock
granularity.

This series adds three new NFSD netlink commands, each with its own
attribute set:

 - NFSD_CMD_UNLOCK_IP releases NLM locks held by a client IP
   address. Netlink equivalent of write_unlock_ip.

 - NFSD_CMD_UNLOCK_FILESYSTEM revokes all NFS state on a
   superblock. Netlink equivalent of write_unlock_fs.

 - NFSD_CMD_UNLOCK_EXPORT revokes NFSv4 state acquired through
   exports of a specific path, regardless of client.

UNLOCK_FILESYSTEM and UNLOCK_EXPORT serve different intents.
UNLOCK_FILESYSTEM means "unmounting /data, release everything
on this superblock." UNLOCK_EXPORT means "no clients remain for
/data/projectA, release only the state acquired through exports
of that path." Userspace (exportfs -u) sends UNLOCK_EXPORT after
removing the last client for a given path, enabling the underlying
filesystem to be unmounted.

The path-only design for UNLOCK_EXPORT avoids the auth_domain
naming complexity (use_ipaddr vs hostname-based domains) by not
requiring the caller to identify a specific client. Since this
mechanism is to be used to enable umount, this seemed like a
reasonable compromise.

---
Changes since v8:
- When revoking state, drop the export reference

Changes since v7:
- Rebase on Jeff's mountd netlink patches
- Fix pre-existing state revocation bugs

Changes since v6:
- Send the complete series (v5 was missing patches 6 and 7)

Changes since v5:
- Rename state_lock => nn->deleg_lock

Changes since v4:
- 1/9 has been queued in nfsd-testing
- Split single NFSD_CMD_UNLOCK into three separate commands
- UNLOCK_EXPORT takes path only, no client attribute to avoid
  auth_domain naming complexity with use_ipaddr

Changes since v3:
- All VFS changes replaced with new netlink "unlock" operation

Changes since v2:
- Replace fs_pin with an SRCU umount notifier chain in VFS
- Merge the pending COPY cancellation patch
- Replace xa_cmpxchg() with xa_insert()
- Use cancel_work_sync() instead of flush_workqueue()
- Remove rcu_barrier()
- Correct misleading claims in kdoc comments and commit messages

Changes since v1:
- Explain why drop_client() is being renamed
- Finish implementing revocation on umount
- Rename pin_insert_group
- Clarified log output and code comments
- Hold nfsd_mutex while closing nfsd_files

---
Chuck Lever (9):
      NFSD: Fix infinite loop in layout state revocation
      NFSD: Handle layout stid in nfsd4_drop_revoked_stid()
      NFSD: Extract revoke_one_stid() utility function
      NFSD: Add NFSD_CMD_UNLOCK_IP netlink command
      NFSD: Add NFSD_CMD_UNLOCK_FILESYSTEM netlink command
      NFSD: Replace idr_for_each_entry_ul in find_one_sb_stid()
      NFSD: Track svc_export in nfs4_stid
      NFSD: Add NFSD_CMD_UNLOCK_EXPORT netlink command
      NFSD: Close cached file handles when revoking export state

 Documentation/netlink/specs/nfsd.yaml |  61 ++++++++
 fs/nfsd/filecache.c                   |  46 ++++++
 fs/nfsd/filecache.h                   |   1 +
 fs/nfsd/netlink.c                     |  36 +++++
 fs/nfsd/netlink.h                     |   3 +
 fs/nfsd/nfs4layouts.c                 |   2 +
 fs/nfsd/nfs4state.c                   | 262 ++++++++++++++++++++++++----------
 fs/nfsd/nfsctl.c                      | 126 +++++++++++++++-
 fs/nfsd/state.h                       |   6 +
 fs/nfsd/trace.h                       |  32 ++++-
 include/uapi/linux/nfsd_netlink.h     |  24 ++++
 11 files changed, 520 insertions(+), 79 deletions(-)
---
base-commit: b495a392b2748dca31d2a4b404632c6f907aa136
change-id: 20260318-umount-kills-nfsv4-state-138218f2f4e0

Best regards,
--  
Chuck Lever


