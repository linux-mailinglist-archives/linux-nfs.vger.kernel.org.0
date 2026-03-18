Return-Path: <linux-nfs+bounces-20244-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COgIOd+zumlWawIAu9opvQ
	(envelope-from <linux-nfs+bounces-20244-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2026 15:17:03 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0902BCE12
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2026 15:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BFAF030027FF
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2026 14:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F013DABE3;
	Wed, 18 Mar 2026 14:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhXDOZgx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DAC3DB62A;
	Wed, 18 Mar 2026 14:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773843326; cv=none; b=HviJKU1S2OxYmaL/cnCIISlxrhKUry292e2YdAChKkt2fOBpBttezAm8Al3Xt+UkkQBsByAZVFn+F+4tVa162T3KxYCh1uxOHuIfQUAwE1GGoE08SBakJhxUrXAl7Y4PROSY0+SRo5DQcnCbu1ZCRCjpGMsjWdloWg/GzFw+uVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773843326; c=relaxed/simple;
	bh=zv6Syh0kY+HUVCK4gyy4IdIW7NiraE6pKEr38RnyOvw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mEXDLa7vY8vXRTBKwy8gOJpKfOoJwMPrHRGR4POKQCktcHYj1sQ4bRZFndlTGJcOF7OQETEXu59ZhCcC3CzbA79Tq0mGvSJGx+5JdulQoOYhbBBuu5VYbrn45KW0AFzJmj7TBdjIXxBNo1+STEdzGL945TOXh0yjz78UysUvfAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhXDOZgx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03145C19421;
	Wed, 18 Mar 2026 14:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773843325;
	bh=zv6Syh0kY+HUVCK4gyy4IdIW7NiraE6pKEr38RnyOvw=;
	h=From:Subject:Date:To:Cc:From;
	b=YhXDOZgxBBJ3yNzYZzUPRXVObCcxqazSoKAfvUgICtCk7VgGGwEzoKURNP9eNon0H
	 7cS1/3x2/rKGjLLUmMBXbD9ITq1Oqyoi5dN0eahmf1/l0EyaWfU2WBsJaEYnHysYGp
	 6gG2tg34MrHFlMIplP7uff2wSih3KXLxbOZ4bScmTC8sWhE6rKoam9UtNbPf335Mc/
	 nQEysycaY8wkcq0k9wWJRzXgNnUO2poaPy3i9/fHcXoxZQbEqW0mtdFugY2fT0w3kY
	 l0YYBpFE34zEhFbx/D8yvJWPvZYSpy52RYtdq36YptEZ8KcZxmmrIlvDGr4VBCg38s
	 5EJwknQ8ptuEg==
From: Chuck Lever <cel@kernel.org>
Subject: [PATCH v4 0/6] Automatic NFSv4 state revocation on filesystem
 unmount
Date: Wed, 18 Mar 2026 10:15:02 -0400
Message-Id: <20260318-umount-kills-nfsv4-state-v4-0-56aad44ab982@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGazumkC/yWMQQ6CMBBFr0Jm7cRSGkO8inHR4hRGoZhOS0wId
 7fV5fv57+0gFJkErs0OkTYWXkMBc2pgmGwYCflRGLTSF9W1PeZlzSHhi+dZMHjZDEqyibDtet3
 2XntDCor+juT580vf7n+W7J40pNqrD2eF0EUbhqlOa+SRw3mxkijCcXwBdsm7O5wAAAA=
X-Change-ID: 20260318-umount-kills-nfsv4-state-138218f2f4e0
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3217;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=zv6Syh0kY+HUVCK4gyy4IdIW7NiraE6pKEr38RnyOvw=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpurNxL2x4EuP8BFLIUqf2FjYAOi/ENysWcPzTP
 VGmXcnF1viJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCabqzcQAKCRAzarMzb2Z/
 l9aWEACWza0k+O6pZlBKP8/vrxwV6lCt8PnvBN13uBRAglxamYKgw+HMT1QY5MulUxS12xDBtt9
 KBdbpWmLx/d3pYA91/KNC0DD/hmd60FWyybGgIWndkjVVxF1WyD7M3HbE7zG/f334DAYyvoR8Dl
 EzzYErWch/G6t2XEAHld3enWkxWel0M2Ck7Z5sIMr2JGCIrS1oyKLCH6nY8lFVRBtlPyTV4lt0P
 7nSpb7S1C3bZrZWhV/pxCrssZFtwhUzYS74nm/+sHbGjtPhM5l2l7MqCiIlEfQMb33HG71/TWVz
 cIA+qEhKC60Hpc0S5zG6YAzBgQ7JXarU+/cB5AFxVssMz7r8MjWtfYatxitd5X0/u7dnYDgjSuQ
 5foHq28xrvz4hvM119m+WYD+PYe4i5l68pTC/wSb50wzC/ccdMSqJn8jHwFVF/XQgbGf8DfNhy+
 vSz9h4AsrVSxFTHj6LOHb0DdnibXE39RKqqvLQp0kqRAnsny2eIf8RqKSqIYt2pU1c1IVzJ4IZD
 WHATZvOuhNQZ2mZjxJfgwJ2PJtGBWnAi3CWWCLNnta8+9ISpc53pKiF+R0qSuuShwSqwaLSKfhh
 WA7sOi1QCLvv399JLAnldWkRL6iR7kIfU5THBovLHb0RuFFBxiidk1ZRtymxHCRADk2WPcWX1Fs
 K6pdAmjKgK/ZWIA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20244-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:mid]
X-Rspamd-Queue-Id: 5F0902BCE12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When an NFS server exports a filesystem and clients hold NFSv4
state (opens, locks, delegations), unmounting the underlying
filesystem fails with EBUSY. The /proc/fs/nfsd/unlock_fs procfs
interface revokes all NFSv4 state on a given filesystem's
superblock, but it operates at whole-filesystem granularity and
offers no structured way to extend the operation to other scopes.

This series adds an NFSD_CMD_UNLOCK netlink command that supports
typed, validated attributes and multiple scope values. The
initial "ip" scope provides a netlink equivalent of
write_unlock_ip, releasing NLM locks held by a specific client
address. A "filesystem" scope parallels write_unlock_fs, accepting
a path string and revoking NFSv4 state, NLM locks, async COPY
operations, and cached file handles associated with that path.

The filesystem scope revokes state at export granularity rather
than superblock granularity: when multiple exports share a
filesystem, only state referencing files under the specified
export root is affected. The subtree check walks all dentry
aliases of each inode so that hard-linked files outside the
export are not incorrectly matched. When the export root is the
filesystem root, the subtree check is elided.

The exportfs user space command can invoke NFSD_CMD_UNLOCK with
the filesystem scope after an explicit "exportfs -u", enabling
automated state cleanup without custom scripting or manual
procfs writes.

---
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
Chuck Lever (6):
      NFSD: Extract revoke_one_stid() utility function
      NFSD: Add NFSD_CMD_UNLOCK netlink command with ip scope
      NFSD: Add filesystem scope to NFSD_CMD_UNLOCK
      NFSD: Refactor find_one_sb_stid() into find_next_sb_stid()
      NFSD: Add export-scoped state revocation
      NFSD: Add nfsd_file_close_export() for file cache cleanup

 Documentation/netlink/specs/nfsd.yaml |  39 ++++++
 fs/nfsd/filecache.c                   |  77 ++++++++++++
 fs/nfsd/filecache.h                   |   2 +
 fs/nfsd/netlink.c                     |  14 +++
 fs/nfsd/netlink.h                     |   1 +
 fs/nfsd/nfs4state.c                   | 219 +++++++++++++++++++++-------------
 fs/nfsd/nfsctl.c                      | 105 +++++++++++++++-
 fs/nfsd/state.h                       |   7 ++
 fs/nfsd/trace.h                       |  13 +-
 include/uapi/linux/nfsd_netlink.h     |  19 +++
 10 files changed, 406 insertions(+), 90 deletions(-)
---
base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
change-id: 20260318-umount-kills-nfsv4-state-138218f2f4e0

Best regards,
--  
Chuck Lever


