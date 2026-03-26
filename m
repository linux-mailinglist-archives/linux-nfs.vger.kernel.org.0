Return-Path: <linux-nfs+bounces-20431-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WE/3Bvh0xWnw+QQAu9opvQ
	(envelope-from <linux-nfs+bounces-20431-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 19:03:36 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DA7339C4E
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 19:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2649A3068EFF
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 17:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AE23A5442;
	Thu, 26 Mar 2026 17:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjkB7BDG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C70F3A542E;
	Thu, 26 Mar 2026 17:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774547738; cv=none; b=IEw+u2qLLawFeYb7KeaDHeEnXDyI3wXQWMEKLMS8bBDdQPk0HATaF1nKvR1hOQ3ah2b9chIkKCHEv9edGIuYys9Ou5rCJHz1of0OONKvUN8Ek8qHr2a2AK3zokqkYwwQfTFQUTVQFz2/ajSGgQGZnx7jnM417HoEXpkaWgSkRGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774547738; c=relaxed/simple;
	bh=573rOMjFofMFYetwxaVyda1ip0dOG9X2gpm3vANf3hY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=W1PNJCFmQS9kVOudnywUOnknCVLIyUl/YbEEysExq0loD6Hyyd+CcEL8qOZ0pwMgrID/A0E0JlDSvOacRb9kqcn1jX+9wtI+VwG0WZShze12jXewK2uQQ8q+7yy/9HnF0arUbpVSRUdfeJbmsgLnhYugYVjSKb/adw9S8Dl6G10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjkB7BDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1DDEC116C6;
	Thu, 26 Mar 2026 17:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774547737;
	bh=573rOMjFofMFYetwxaVyda1ip0dOG9X2gpm3vANf3hY=;
	h=From:Subject:Date:To:Cc:From;
	b=LjkB7BDG8c0MFqni1Em5fmDz2T+8+K/B3o4BRQ4kOLN+q1UNv6kIt5W/UWbwPl5Bk
	 estoQj3I1dq5kOz+lVFZsgr8EmY9ygDwgd9fy5nKe7h1lw9OHgw9wKv8FdaK/5ixxS
	 YJGa/ZyXKHBp0rGsTiwopdw15Xfx1+isUg3dftDdKkRLJY8JLxHe8aL/lbXX44aoOt
	 xji8jFfBF2BQ/F0QqKXFGR/RABxJo8ZRA2AEueVfKIJkiCbhDy+B3UK8rTQFVFDb+p
	 OUiMw6TdyzvRR+VHT/vlExeFVGZ9EBWGDMkXGccM30vGRI8QNl2NSn30BxdiE4yzbh
	 P18sRRbrVRQXw==
From: Chuck Lever <cel@kernel.org>
Subject: [PATCH v5 0/7] Automatic NFSv4 state revocation on filesystem
 unmount
Date: Thu, 26 Mar 2026 13:55:19 -0400
Message-Id: <20260326-umount-kills-nfsv4-state-v5-0-d2ce071b3570@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAdzxWkC/42OQQ6CMBBFr2K6dhRqIejKexgXbRlgFFrTKURju
 LutXsDdvMn/L/8tGAMhi9PmLQIuxORdgmq7EXbQrkegNrGQhayLQ9nAPPnZRbjTODK4jhcFHHV
 EKA+NLJtOdgoLkeqPgB09v+rL9cc8mxvamH05YTQjmKCdHfLLB+rJ7ZOzhYgcyfU5NRBHH17fh
 YvKtj/GpKOAqta6VUqbYyPPPmg74s76SVzXdf0AdEumQPkAAAA=
X-Change-ID: 20260318-umount-kills-nfsv4-state-138218f2f4e0
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3572;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=573rOMjFofMFYetwxaVyda1ip0dOG9X2gpm3vANf3hY=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpxXMOkHEN2rx7WFGDjbIi9VG3EZ519p0YmwI0V
 ACMSrjl+pCJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCacVzDgAKCRAzarMzb2Z/
 l/LiEACT/+vfZ9tMUifIL9BAwnr9177hEYf0n4KyEj6INHrxpnl6TT+E1dPRal5kZqyQ0AlAeA9
 H9p3MRObycC/IYke/krcsrdTmwgAdVNP0xd5LGfoVUZrNVhIFmbJ2F7BBOrjsmJ0q3zUlUyRtmE
 friZ2M+MtpU1b3Si03C6/ELBwbqbJf8Fw+2+PCyNBDf7um8cvbfRcwLzXSh1zBBNGlPIXy1CLQW
 jPmdZo9ZWF+uk0k9tso3xnHmUg5XilOzz6whIR/4kHSpD5kzL5QfXw/fczzeryrmftJDhJO+D9q
 O9R72FK+lFKxeS8HHlJ5iCuG+DcvwpZ5JoWN3l5xD/4ze4Q+IoBczYrij49lbw50YR5aPgXwBdO
 HAV74j0jZ+Cw+VY7SWKm0Sjo22Jl3D5FpHtF3Y35qTY/NWcSgetB38PTn0kOEKXFfPcVaPhN6u/
 IS5SINcz1BEh/5xw9QRwHrcwBniqha37cVNFQWUz4GQ7yl2YHftv1i2ulmn4rg5x8+3c3j/nBTm
 r2JL3T7FfNKtKgbThRBd6bAlajoW2lHdA6InPMXMH8pjvVdIkgl7KvD+oIAyR/QiG35X3/AMlhn
 1KkkkR/K0csv3Yp0gRps7zhCqtYhxoho9kvXybNeaRXAMALRVrcYqRdb5WSaB7ntOt/jyulz8Dj
 ADaVEbz8/SCryag==
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
	TAGGED_FROM(0.00)[bounces-20431-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 75DA7339C4E
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
 fs/nfsd/nfs4state.c                   | 226 +++++++++++++++++++++++-----------
 fs/nfsd/nfsctl.c                      | 126 ++++++++++++++++++-
 fs/nfsd/state.h                       |   6 +
 fs/nfsd/trace.h                       |  32 ++++-
 include/uapi/linux/nfsd_netlink.h     |  24 ++++
 11 files changed, 484 insertions(+), 79 deletions(-)
---
base-commit: 65058e9e9b20619f920397f529072e853dd43811
change-id: 20260318-umount-kills-nfsv4-state-138218f2f4e0

Best regards,
--  
Chuck Lever


