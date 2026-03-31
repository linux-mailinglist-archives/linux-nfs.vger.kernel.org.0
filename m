Return-Path: <linux-nfs+bounces-20558-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLlOO2IqzGkmQgYAu9opvQ
	(envelope-from <linux-nfs+bounces-20558-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 22:11:14 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5544D37107C
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 22:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1492530AB145
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 20:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB853CF02A;
	Tue, 31 Mar 2026 20:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMUMuRfv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476EE3CBE9D;
	Tue, 31 Mar 2026 20:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774987611; cv=none; b=N09/j8LWLqE2TTRPF6C9VbbP3MUMhAKjRr8SLhDgvlfv1QV1kXtA1GTU4fu88GIV4XGWdUix/JRNPDp2SU1ukLGdv2mO/qfI1EvcXd4zLnuSdHM9cUrGtRk2383PNXFTFsLIYO6xkvZJKhSSN5EagieoCnkdFaj0c9OIu2yhNWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774987611; c=relaxed/simple;
	bh=K9ZrtrfCdoFr3+SGLkItdxDrbPX/vt7NGt6+W7Boz00=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E8zsL1kyKVz6z/zSoZQZrSev71PnbmgNBne8JZNC364mzJHBV0SJg2BBGRL3cnXDhnr9oN7tC3UBTz+AgICAIIvgDNcdDn2lSBTECWx8OXqVGMX4OO5MLYlsRLMnRTJ1Ibs7LKgRCNdR7yQb4zSfmyIYs4c90LZf6BNIEB/aIf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMUMuRfv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4165FC19423;
	Tue, 31 Mar 2026 20:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774987610;
	bh=K9ZrtrfCdoFr3+SGLkItdxDrbPX/vt7NGt6+W7Boz00=;
	h=From:Subject:Date:To:Cc:From;
	b=YMUMuRfvnSlPQK6u6Hlj7WkIbx5Ydder6llKiHG6ohL/IogzK8+HpdFuH0wuh5Jvy
	 +4hLR137xrsqRWt7ajWLDHjvORBbCaV9Wj3adu1yuQqKxskExwDbOdlbqq5Pq0rC1G
	 SmRUBBnDdVFA3tsEf7ypcm/dafillLN76oDSd6hh4CXTfyZEG6Dgvcp+nTcHHraHub
	 g+xenNH1aWZxF4WlKrZafP3ewgC07PBhKZJY9bLolAIFj6/kdIqCMt8AykO7nfAjJI
	 u8oVl5vWJhkDgkJXuk57RBo9Jg2FB7bDMZq9Z37ldn8Mjet4RSHL0CidOmwPaM3AMP
	 0lhLcwrlAojQQ==
From: Chuck Lever <cel@kernel.org>
Subject: [PATCH v6 0/5] Automatic NFSv4 state revocation on filesystem
 unmount
Date: Tue, 31 Mar 2026 16:06:07 -0400
Message-Id: <20260331-umount-kills-nfsv4-state-v6-0-18250f95f22a@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC8pzGkC/43OwW7DIAwG4FepOM8bISRNe+p7VDsAcRJvKVSYR
 KuqvHuhu2yXaTf/lv3pvwvGSMjiuLuLiCsxBZ9D+7ITbjJ+RKA+Z6GkamVddbBcwuITfNI8M/i
 BVw2cTEKo6k5V3aAGjVLk92vEgb6e9Pn9O/NiP9Cl4pULaxjBRuPdVFYh0kj+LZs9JOREfixXE
 3EK8fZsuOqi/aNMHiQ0rTG91sYeOnUK0bgZX124iNJmbX5Iqv1DarLUK4dyX9m62ctf0rZtD6g
 Doi9DAQAA
X-Change-ID: 20260318-umount-kills-nfsv4-state-138218f2f4e0
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3401;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=K9ZrtrfCdoFr3+SGLkItdxDrbPX/vt7NGt6+W7Boz00=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpzClPupi89x2W6uVocvCskyhGfO5IDPTe4j/7s
 NRCEnRBdT6JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCacwpTwAKCRAzarMzb2Z/
 l1IVD/9BEIf35nNkJtvzCeUqfZixm+bpHVUJlx0bXvCWTP4+mGZdlxz7mrzGdLLjYaLz500l7tn
 zKGiAoOyvhmXAT0X55fYRNsWQHkZUEY2+DfnAmI4Iez2nqC0+GFMRgnMycLuTM4BczfgqDln+5a
 vO2QQxuZ2J7SKZvnr2ZGB1BFg7DnSvFUlN2Iz4rUtg39jP56CE7NniNPLD1i2YtiHloblU7AkVU
 UHx8q3OPtPA/jpOOG7fLGCDyEyOr2lXVGLDkziq9Urw87TidquI7wfNjDmJBQDM8aJ3GIijG13U
 +ZwhT1COCHpV9T4NwgOver5TEjkyUcH99WdMwFMzngWkGlQ/eIN7TCfx6AlbEVlBJ6LDt68lmDY
 tCOavmOiH9MGtz23rCQhCEgCceISEuSXWsa+vJnKMSpbnwMSoBTlHJMQfo1jC9x1B5SNnCRMlDn
 GKPYVb3eCOOC/KNfQpiS3/rFgmFwNTzRN9SmQvBtdJoTj1b17vNQT0C96HwQY6Oj8zR6JI3J4SI
 iGevjlOhKSbOrLOqOq5cbFShQybdTL5GeGUZLkNl3v/E/lIucODAn59MbhMzYVMHXQ8ZxBaRaYA
 oQOttHJoAKADWtWHKAO9Qw1ap93ymMHJscyxNVgngjbrCOeSw7KXCzcBSdF9phReGPgcrj0l4AE
 lNnbZk3h5HXNDew==
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
	TAGGED_FROM(0.00)[bounces-20558-lists,linux-nfs=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:mid]
X-Rspamd-Queue-Id: 5544D37107C
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
Chuck Lever (5):
      NFSD: Extract revoke_one_stid() utility function
      NFSD: Add NFSD_CMD_UNLOCK_IP netlink command
      NFSD: Add NFSD_CMD_UNLOCK_FILESYSTEM netlink command
      NFSD: Replace idr_for_each_entry_ul in find_one_sb_stid()
      NFSD: Track svc_export in nfs4_stid

 Documentation/netlink/specs/nfsd.yaml |  34 ++++++++
 fs/nfsd/netlink.c                     |  24 +++++
 fs/nfsd/netlink.h                     |   2 +
 fs/nfsd/nfs4layouts.c                 |   2 +
 fs/nfsd/nfs4state.c                   | 160 +++++++++++++++++++---------------
 fs/nfsd/nfsctl.c                      |  80 ++++++++++++++++-
 fs/nfsd/state.h                       |   1 +
 fs/nfsd/trace.h                       |  13 +--
 include/uapi/linux/nfsd_netlink.h     |  16 ++++
 9 files changed, 253 insertions(+), 79 deletions(-)
---
base-commit: da43140ef30ecaffbfe04902d2513f5aac48ec4a
change-id: 20260318-umount-kills-nfsv4-state-138218f2f4e0

Best regards,
--  
Chuck Lever


