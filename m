Return-Path: <linux-nfs+bounces-20565-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHK2JpU4zGlFRgYAu9opvQ
	(envelope-from <linux-nfs+bounces-20565-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 23:11:49 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CE83716C1
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 23:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9329230C4870
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 21:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45393F788C;
	Tue, 31 Mar 2026 21:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sShxAI5y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED9D3F787B;
	Tue, 31 Mar 2026 21:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991226; cv=none; b=lmGURCJAUaRwQhzno6/EynsF+gQjMuIa+6MPQp0JGSQZVDwEy2paGf9JEVlbOIkmKPtcA3A6pNxZVEukPmRIIcBzi/9fu5UVRAv1dDupdOSW0jmU8/HZPw9o8qs4Gf3MwjzqgCEMsJjH84bR6PJ0M1ZspqOvrn6TxbKaoBd253w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991226; c=relaxed/simple;
	bh=WzeX34AxfhhRORXcfsPGaKpCHhgigrPVQpuMx6xrHPM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Bmc6yytapb4agHvhFw6HyDd6CYb9hbWXKnlneoN3wSncXAOsTL+G04ujHOQQGMWzNBwAoCj5jruoG5NlmOZq9H+R75q2FOEgXOOqTTx1TaE7H+BN87nLAKvYEIBe6GNL98aEpRjETAdz6oMBKbh1aXH1SDIbsfi84Br5xzh8ji4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sShxAI5y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060D2C19423;
	Tue, 31 Mar 2026 21:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774991226;
	bh=WzeX34AxfhhRORXcfsPGaKpCHhgigrPVQpuMx6xrHPM=;
	h=From:Subject:Date:To:Cc:From;
	b=sShxAI5yzj0DQxJ4tBo8I2dRbN4pmPsNwKzbubljNQzO234Lb7p6cWyKyPVB3bjQb
	 Quxk3X3GApj3AgI7YlIGHoxUwXzEq7XyRHy7gnpZTO37GZHMgz2+EF0sZHrKe02fc3
	 Ie1gjYACAuvcJNA9sU5ceyOuWYIFEUoHc+1X/pfWGNpvxFnwgoVR9d7piy/vU5k+Yy
	 E784gWzfvqq25mVuksTncTEBtL4sgvUjUImH7tofy/XmelMCZfChEzpYr/ryZDN51A
	 j47rwbMDUrQovkUY0KKF6+Sp/NLdE/JfxOMC3VTmuUUQVcUoQKKEs+5kGIbpKP36dH
	 yzfM5MAhWhnkA==
From: Chuck Lever <cel@kernel.org>
Subject: [PATCH v7 0/7] Automatic NFSv4 state revocation on filesystem
 unmount
Date: Tue, 31 Mar 2026 17:06:54 -0400
Message-Id: <20260331-umount-kills-nfsv4-state-v7-0-d8d2eee93f53@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG43zGkC/43OwU7EIBAG4FfZcBaFKbTsnnwP4wHo0KJdMEAbz
 abvLqyXNSYbb/NPZr78F5IxeczkdLiQhJvPPoYahocDsbMOE1I/1kyAQc86ruh6jmso9N0vS6b
 B5U3QXHRByjsFXDlwAhmp7x8Jnf+80i+vPzmv5g1taV67MDojNUkHO7dVTH7y4amaIy2Yiw9Tu
 5p9LjF9XRtuomn/KFMHRmWv9SiENkcFzzFpu+CjjWfS2mzyRoL+jiSrNIJFNnDTyYH9kfobqeN
 3pL5KXIFk7igdgP4l7fv+DQAgHBqNAQAA
X-Change-ID: 20260318-umount-kills-nfsv4-state-138218f2f4e0
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3949;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=WzeX34AxfhhRORXcfsPGaKpCHhgigrPVQpuMx6xrHPM=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpzDdxl8nYpa+L74xEpJZFIH7z6FdKkeSAbtBET
 0MUPO5SGJqJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCacw3cQAKCRAzarMzb2Z/
 lzmHEAC9hc5D+A11k9WBpJLePYfBgqwDzhk0Fg6zLBIQjw6hkQE6Qo9rR4HGwrte2BhMYnF8bEl
 vPmoAeSWTHLeET6hPeiLDCpNcQBFa52KPzdJzBzPYUUn/OTKcyix9g8xlOQ/HHNtQc6oQgwRQbM
 CRdCU1AKIr2P/Eu+297hAZHQBbz58hS+YLSAJ0Y7i4DH8AM0N3EJ07rfNMOTrKN0GsPaIDZ47WM
 tF7C5/MqWV8Ojf7xDHef9Ha11FJ3fji9i4bpPt5zSD0UBVffROMZdxcf+SUJKRR/E/OZ/44VBrS
 hPCASoJV2ytTG0dXaHgTLolAPPjpEsIy/SDIvvtpwrRiq/BBwElsxcdb8l5AQU+jBUBv8m2+uiq
 kx54+tm6vPnwaJe8IrO2gIJtbOko/AdVW+ci0ml51ED/YuA6YHp1HoHiliJTyUEwjMExQ1Z1dfp
 rEQfrfaM2oIRqMPrJnzIZpdHn1RWPKdPZUm1Ypl62Gq6+1KXSydLJDj9BSsZco8r0ikwKdi3PmY
 ZDslWwkyxGu4uGY0d8ZO/tx6wm2UhjwtUSMtj2R+lhkeMPd/xtJKRAnTpwelWjcMNSlEWgueHNJ
 by7XfGq+LyoZrlzlDdZTc0vqny/6Y5Q7INzh9VKug5JVkwYaOBsFCFKK1drBtCZ0g/hszf+pdfr
 V7xLYqpnShkwdBA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20565-lists,linux-nfs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 07CE83716C1
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
Changes in v7:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v6: https://patch.msgid.link/20260331-umount-kills-nfsv4-state-v6-0-18250f95f22a@oracle.com

---
Chuck Lever (7):
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
 fs/nfsd/netlink.c                     |  36 ++++++
 fs/nfsd/netlink.h                     |   3 +
 fs/nfsd/nfs4layouts.c                 |   2 +
 fs/nfsd/nfs4state.c                   | 227 +++++++++++++++++++++++-----------
 fs/nfsd/nfsctl.c                      | 126 ++++++++++++++++++-
 fs/nfsd/state.h                       |   6 +
 fs/nfsd/trace.h                       |  32 ++++-
 include/uapi/linux/nfsd_netlink.h     |  24 ++++
 11 files changed, 485 insertions(+), 79 deletions(-)
---
base-commit: da43140ef30ecaffbfe04902d2513f5aac48ec4a
change-id: 20260318-umount-kills-nfsv4-state-138218f2f4e0

Best regards,
--  
Chuck Lever


