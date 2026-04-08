Return-Path: <linux-nfs+bounces-20729-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGhpDoNO1mm8DQgAu9opvQ
	(envelope-from <linux-nfs+bounces-20729-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 14:48:03 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8323BC5E3
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 14:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 74D2B305E8A5
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Apr 2026 12:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6583C73FF;
	Wed,  8 Apr 2026 12:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/yBYfpW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF493C5DCE;
	Wed,  8 Apr 2026 12:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775651409; cv=none; b=q6JwoGLtrxbKU/Y0/7C1k5eKMx30ZVJJlNz0yy8/SL0omyO4nOfzgIxEHFPNl6NahOKfTysqABHJCu3YJ046VcQDUQvkecmJj5WSuF48fSDGQpOV3FZyuLcMItDAZkSnUWs0bBFrvJzKPpZJ7RJcsEkMhYPrwhsmf9PINmGyXuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775651409; c=relaxed/simple;
	bh=V87dwed4H3oRivgkQPJQJjVUqgwCsFYEsU3rdV9BwFA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YUq2CYflm45ptV31pfBU8BuCahBK7Ysx+aQB/qr6DjAzs/xWhfuvhfPPHCIPK4Gu8tVulPEepMl6DgMVgl3nVk+81gDrxfmsbmqSOn+S/CDG9YbB15127k/NM4WsdX2JHLS0waivPPo9KX4BmrpfwLmq2qc5ycw44KJDbN53mvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/yBYfpW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF2AC19421;
	Wed,  8 Apr 2026 12:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775651408;
	bh=V87dwed4H3oRivgkQPJQJjVUqgwCsFYEsU3rdV9BwFA=;
	h=From:Subject:Date:To:Cc:From;
	b=T/yBYfpWIOQ5ahj7IqRShb4YkrUnazCtxPdcUxtzGrg4U20b33+sTJdO7y8qLvZsd
	 5gFm/EH2emfQdiRVcWmq7w5FkXtIMn317QwnjohvipoU0mdhG1ivcFwS/D6duhQKuK
	 X2sVUAuYtyMqzlyMK19llkrpitFuJs3bF51HmKvuGjrHKAXUHHybR2Q/lcm+lDl+EP
	 wPd24dnS0Cj55eGFoS+7xfScwSG4/SMqVkKjnwDkUHoZw7afAKNjKUv024b42ZgE08
	 DOZ1CnHWKv/7TYWqwvG59AXxr4aZFY2k9jU8hQldYopjgrLBecI9Z1VHqdJNSEnDvh
	 fnjU7/OARuzWw==
From: Chuck Lever <cel@kernel.org>
Subject: [PATCH v8 0/9] Automatic NFSv4 state revocation on filesystem
 unmount
Date: Wed, 08 Apr 2026 08:29:50 -0400
Message-Id: <20260408-umount-kills-nfsv4-state-v8-0-6e02a1d03d60@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD5K1mkC/43OQW7DIBAF0KtErEsLg7FxVr1H1QXGg03rQAXYa
 hX57oV0kypSlN380czTP5OE0WEix8OZRNxccsGXoJ4OxMzaT0jdWDIBBi0TXNH1FFaf6adblkS
 9TVtDU9YZKRcKuLJgG2SkvH9FtO77Qr+9/+W0Dh9ocvXqxaAT0iFqb+a6CtFNzr8Uc6QZU3Z+q
 lezSznEn0vDranaA2XKwKhstR6bRg+9gtcQtVnw2YQTqW02eSVBe0eSRRrBIOv4IGTHbqT2ShL
 8jtQWiSuQzPbSAugbqXtU6monNQIi9sJK8U/a9/0X1Oj1ctcBAAA=
X-Change-ID: 20260318-umount-kills-nfsv4-state-138218f2f4e0
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>, Dai Ngo <dai.ngo@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3937;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=V87dwed4H3oRivgkQPJQJjVUqgwCsFYEsU3rdV9BwFA=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp1kpFZX1t2+2gIogVEqPHOeG1Q+hHlcJrG9GaS
 fvIzL7dZauJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCadZKRQAKCRAzarMzb2Z/
 lwToD/42CGH+XUM8Mo+U1wobl1mYWIrFJD4M+URw6DTjlQIb1S5MoxsVyJl5a6W0X3i4r9zDCsE
 xEaXeeN15r/C0SUi0IrArBzyECzpW/QZm/0shKspfJzfpRh38JzSTNjkfYoPU+PKAZkdGs294gy
 6bI+zICObnzcgH/1mhsyTbC1pDr/ZRYa5BF2DRJLvLJVwY/5D502M3XuqWbKunDi0TKy1yKafCE
 4UTObUdj9+V7bDkjNpaHV6SFez+aqHoCF4NebzGrrdNC8nLJaNM1UM6mJkCczpxjxf05zBG85sP
 0Zr2KMCtpSSeTAHSSpu2lCpzDlUQUwqpzpZmWQNUqDkpKFCkCsWUUT0qnFx70cErFCQzZvxCvFW
 JmsFREvxTwBG7terJibz0TySHBVV3QfvTZLMGCDALMcXQfnHBBH3s+xhKMgrS8fdsWvV2BpfEDm
 krkrEJdjmlY9RO64dwPyAN5aa8Zg9nnAVNTz5l3PcvhoPUXrAveQR9N/TeZGhCRR+rK2DdeYcxB
 qeKuXOHYtTycBYaFW+x4X25+s/qLn//U1vLterUTPejJRKiH41BZTxpvEraA07W0Rj93t9MqtKb
 X8TycIgp+AXd4hbFMrtsQEB4ImHN5TuYElyI93tM3a4E4T5I+Hru59oS9NOOMGZyxlHqmVkqK15
 zbulUGUkBzE+lRg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20729-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:mid]
X-Rspamd-Queue-Id: 3B8323BC5E3
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

 Documentation/netlink/specs/nfsd.yaml |  61 +++++++++
 fs/nfsd/filecache.c                   |  46 +++++++
 fs/nfsd/filecache.h                   |   1 +
 fs/nfsd/netlink.c                     |  36 +++++
 fs/nfsd/netlink.h                     |   3 +
 fs/nfsd/nfs4layouts.c                 |   2 +
 fs/nfsd/nfs4state.c                   | 240 ++++++++++++++++++++++++----------
 fs/nfsd/nfsctl.c                      | 126 +++++++++++++++++-
 fs/nfsd/state.h                       |   6 +
 fs/nfsd/trace.h                       |  32 ++++-
 include/uapi/linux/nfsd_netlink.h     |  24 ++++
 11 files changed, 498 insertions(+), 79 deletions(-)
---
base-commit: b495a392b2748dca31d2a4b404632c6f907aa136
change-id: 20260318-umount-kills-nfsv4-state-138218f2f4e0

Best regards,
--  
Chuck Lever


