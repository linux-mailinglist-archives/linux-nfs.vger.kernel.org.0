Return-Path: <linux-nfs+bounces-22657-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mZ7wCl2kMmpt3AUAu9opvQ
	(envelope-from <linux-nfs+bounces-22657-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jun 2026 15:42:53 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F74869A353
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jun 2026 15:42:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WjywgAEI;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22657-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22657-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 369B830091D2
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jun 2026 13:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A513D33F8DC;
	Wed, 17 Jun 2026 13:42:46 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCA92FFDD5;
	Wed, 17 Jun 2026 13:42:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781703766; cv=none; b=nmXwm0WCmtw9l0OLprQgZiSZYFEIT4T8tpigi/fB8u3Zlv1/OEXkKSecj1gYJY2VT01xBjYGI4Z8st2UabXkkJK83Jjfu0BcskjMuvLcRVBngooolGx+sAf3Vkyk9sVcslMephhYOjnN3DTQuL66KK7UR5uA45TBKkdmFMTf7Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781703766; c=relaxed/simple;
	bh=UH/yNr6nMAIQclrKh1hTuSUDiEfXxyn9h8hng/aAaVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iwXYM5eTd6j97c0BZxNoeovRFgXi4o82B3f0iCjFdO4/3FXnU3T5wLhApOc42osRxTLw77/PwBXDazwg30Kst9j8VB6BoqZtXz8M81nVI4oe3qDFk5rTv7xlekmT2EAxwhhkh6KEfiiFm+a3Z8NTWIJiJyuWKKLyhWOuS6D+BE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjywgAEI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 452031F000E9;
	Wed, 17 Jun 2026 13:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781703764;
	bh=fFnoiHiysF0hBfPPg+BeWoELtEAAcdqEmvbBT8YPhm4=;
	h=From:To:Cc:Subject:Date;
	b=WjywgAEIPaYoisHraVRCQh6ElamG773bQKDkRExGmUvqFoqBinyKfiZo3OzEBii4f
	 gWfAgvvX39tY63pvdKt559OQsYUCXVlNN6voDLPKnlC+KjE9vSN2TZTPp+HzWSWNZ+
	 /wHs84et4ny2TNYmxNvA2K4IFR5d8KGQXGg12C/FX1VDYU/2T6Ps8mWwo0eoHYykxo
	 FUZK/W2TFJtW8cjb7lz9FZI10zqbVAbqcCMaf6TPG4p1MWgrfU0YXApeHX5S4Uu6Rx
	 CJEgkwR/pqIvpmQ5/loWwSP/hAjsIPnFNRHZ36P2IvsXh2GmuicqH456aSEd+0Ylgv
	 6knZTwazKf5bQ==
From: Chuck Lever <cel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] NFSD changes for v7.2
Date: Wed, 17 Jun 2026 09:42:39 -0400
Message-ID: <20260617134243.1541292-1-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22657-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1F74869A353

The following changes since commit e43ffb69e0438cddd72aaa30898b4dc446f664f8:

  Linux 7.1-rc6 (2026-05-31 15:14:24 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-7.2

for you to fetch changes up to e5248a7426030db1e126363f72afdb3b71339a5c:

  svcrdma: wake sq waiters when the transport closes (2026-06-09 16:32:59 -0400)

----------------------------------------------------------------
NFSD 7.2 Release Notes

Jeff Layton wired up netlink upcalls for the auth.unix.ip and
auth.unix.gid caches in SunRPC and the svc_export and nfsd.fh
caches in NFSD. The new kernel-user API is more extensible and
lays the groundwork for retiring the old pipe interface.

The default NFS r/w block size rises to 4MB on hosts with at least
16GB of RAM, reducing per-RPC overhead on fast networks. Smaller
machines keep their previously computed default, and the value
remains tunable through /proc/fs/nfsd/max_block_size.

Chuck Lever converted the server's RPCSEC GSS Kerberos code to the
kernel's shared crypto/krb5 library. The conversion retires and
removes SunRPC's bespoke implementation of Kerberos v5, but keeps
RPCSEC GSS-API.

Continuing the xdrgen migration that converted the NLMv4 server XDR
layer in v7.1, Chuck Lever converted the NLM version 3 server-side
XDR layer from hand-written C to xdrgen-generated code. As with the
NLMv4 conversion in v7.1, the goals are improved memory safety,
lower maintenance burden, and groundwork for generation of Rust code
for this layer instead of C.

Chuck Lever fixed an issue where lingering NFSv4 state pins a
mounted file system after it is unexported. A new netlink-based
mechanism can now release NLM locks and NFSv4 state by client
address, by filesystem, and by export. Now an administrator can
quiesce an export cleanly before unmounting it.

The remaining patches are bug fixes, clean-ups, and minor
optimizations, including a batch of memory-leak and use-after-free
fixes in the ACL, lockd, and TLS handshake paths, many of them
reported by Chris Mason. Sincere thanks to all contributors,
reviewers, testers, and bug reporters who participated in the v7.2
NFSD development cycle.

----------------------------------------------------------------
Chris Mason (2):
      nfsd: release layout stid on setlease failure
      sunrpc: pin svc_xprt across the asynchronous TLS handshake callback

Christian Brauner (4):
      Merge patch series "cleanup block-style layouts exports"
      Merge patch series "Exposing case folding behavior"
      Merge patch series "Casefold Fixes"
      Merge patch series "VFS changes for nfsd CB_NOTIFY callbacks in directory delegations"

Christoph Hellwig (4):
      nfsd/blocklayout: always ignore loca_time_modify
      exportfs: split out the ops for layout-based block device access
      exportfs: don't pass struct iattr to ->commit_blocks
      exportfs,nfsd: rework checking for layout-based block device access support

Chuck Lever (104):
      fs: Move file_kattr initialization to callers
      fs: Add case sensitivity flags to file_kattr
      fat: Implement fileattr_get for case sensitivity
      exfat: Implement fileattr_get for case sensitivity
      ntfs3: Implement fileattr_get for case sensitivity
      hfs: Implement fileattr_get for case sensitivity
      hfsplus: Report case sensitivity in fileattr_get
      xfs: Report case sensitivity in fileattr_get
      cifs: Implement fileattr_get for case sensitivity
      nfs: Implement fileattr_get for case sensitivity
      vboxsf: Implement fileattr_get for case sensitivity
      isofs: Implement fileattr_get for case sensitivity
      nfsd: Report export case-folding via NFSv3 PATHCONF
      nfsd: Implement NFSv4 FATTR4_CASE_INSENSITIVE and FATTR4_CASE_PRESERVING
      ksmbd: Report filesystem case sensitivity via FS_ATTRIBUTE_INFORMATION
      tools headers UAPI: Sync case-sensitivity flags from linux/fs.h
      nfs: Avoid transient zeroed case capability bits during probe
      nfs: Skip pathconf probe when neither field is consumed
      fs: Clarify FS_CASEFOLD_FL semantics in UAPI header
      nfsd: Use kernel credentials for case-info probe
      nfsd: Map -ESTALE from case probe to NFS3ERR_STALE
      nfsd: Cap case-folding probe cost across READDIR entries
      Merge remote-tracking branches 'vfs/vfs-7.2.casefold', 'vfs/vfs-7.2.directory.delegations' and 'vfs/vfs-7.2.exportfs' into vfs-7.2-merge
      sunrpc: skip svc_xprt_enqueue when no work is pending
      sunrpc: skip svc_xprt_enqueue in svc_xprt_received when idle
      sunrpc: skip svc_xprt_enqueue when transport is busy
      NFSD: Fix delegation reference leak in nfsd4_revoke_states
      NFSD: Put cache get-reqs dump attrs under reply
      NFSD: Update my maintainer email addresses
      NFSD: Handle layout stid in nfsd4_drop_revoked_stid()
      NFSD: Extract revoke_one_stid() utility function
      NFSD: Add NFSD_CMD_UNLOCK_IP netlink command
      NFSD: Add NFSD_CMD_UNLOCK_FILESYSTEM netlink command
      NFSD: Replace idr_for_each_entry_ul in find_one_sb_stid()
      NFSD: Track svc_export in nfs4_stid
      NFSD: Add NFSD_CMD_UNLOCK_EXPORT netlink command
      NFSD: Close cached file handles when revoking export state
      NFSD: Increase the default max_block_size to 4MB
      SUNRPC: Add Kconfig dependency on CRYPTO_KRB5
      SUNRPC: Add crypto/krb5 enctype lookup to krb5_ctx
      SUNRPC: Add helpers to convert xdr_buf byte ranges to scatterlists
      SUNRPC: Add errno-to-GSS status conversion helper
      SUNRPC: Prepare crypto/krb5 encryption and checksum handles
      SUNRPC: Switch wrap token encryption to crypto/krb5
      SUNRPC: Switch wrap token decryption to crypto/krb5
      SUNRPC: Switch Camellia decrypt to crypto/krb5
      SUNRPC: Switch MIC token generation to crypto/krb5
      SUNRPC: Switch MIC token verification to crypto/krb5
      SUNRPC: Remove get_mic/verify_mic function pointers from enctype table
      SUNRPC: Remove wrap/unwrap function pointers from enctype table
      SUNRPC: Remove encrypt/decrypt function pointers from enctype table
      SUNRPC: Remove legacy skcipher/ahash handles from krb5_ctx
      SUNRPC: Remove dead code from rpcsec_gss_krb5
      SUNRPC: Remove per-enctype Kconfig options
      SUNRPC: Remove redundant crypto Kconfig dependencies
      SUNRPC: Remove dead rpcsec_gss_krb5 definitions
      svcrdma: Release write chunk resources without re-queuing
      svcrdma: Defer send context release to xpo_release_ctxt
      lockd: Stop warning on nlm__int__drop_reply in !V4 cast_status
      lockd: Correct kernel-doc status descriptions for NLMv4 GRANTED
      lockd: Drop locks_init_lock() from nlm4_lock_to_lockd_lock()
      lockd: Translate nlm__int__deadlock in __nlm4svc_proc_lock_msg()
      lockd: Do not monitor when looking up the LOCK_MSG callback host
      Documentation: Add the RPC language description of NLM version 3
      lockd: Rename struct nlm_cookie to lockd_cookie
      lockd: Rename struct nlm_lock to lockd_lock
      lockd: Rename struct nlm_args to lockd_args
      lockd: Rename struct nlm_res to lockd_res
      lockd: Rename struct nlm_reboot to lockd_reboot
      lockd: Rename struct nlm_share to lockd_share
      lockd: Use xdrgen XDR functions for the NLMv3 NULL procedure
      lockd: Use xdrgen XDR functions for the NLMv3 TEST procedure
      lockd: Use xdrgen XDR functions for the NLMv3 LOCK procedure
      lockd: Use xdrgen XDR functions for the NLMv3 CANCEL procedure
      lockd: Use xdrgen XDR functions for the NLMv3 UNLOCK procedure
      lockd: Use xdrgen XDR functions for the NLMv3 GRANTED procedure
      lockd: Refactor nlmsvc_callback()
      lockd: Use xdrgen XDR functions for the NLMv3 TEST_MSG procedure
      lockd: Use xdrgen XDR functions for the NLMv3 LOCK_MSG procedure
      lockd: Use xdrgen XDR functions for the NLMv3 CANCEL_MSG procedure
      lockd: Use xdrgen XDR functions for the NLMv3 UNLOCK_MSG procedure
      lockd: Use xdrgen XDR functions for the NLMv3 GRANTED_MSG procedure
      lockd: Use xdrgen XDR functions for the NLMv3 TEST_RES procedure
      lockd: Use xdrgen XDR functions for the NLMv3 LOCK_RES procedure
      lockd: Use xdrgen XDR functions for the NLMv3 CANCEL_RES procedure
      lockd: Use xdrgen XDR functions for the NLMv3 UNLOCK_RES procedure
      lockd: Use xdrgen XDR functions for the NLMv3 GRANTED_RES procedure
      lockd: Use xdrgen XDR functions for the NLMv3 SM_NOTIFY procedure
      lockd: Convert NLMv3 server-side undefined procedures to xdrgen
      lockd: Use xdrgen XDR functions for the NLMv3 SHARE procedure
      lockd: Use xdrgen XDR functions for the NLMv3 UNSHARE procedure
      lockd: Use xdrgen XDR functions for the NLMv3 NM_LOCK procedure
      lockd: Use xdrgen XDR functions for the NLMv3 FREE_ALL procedure
      lockd: Remove C macros that are no longer used
      lockd: Remove dead code from fs/lockd/xdr.c
      lockd: Unify cast_status
      Revert "svcrdma: Use contiguous pages for RDMA Read sink buffers"
      lockd: Plug nlm_file leak when nlm_do_fopen() fails
      lockd: Plug nlm_file refcount leak on cached nlm_do_fopen() failure
      lockd: Avoid hashing uninitialized bytes in nlm4svc_lookup_file()
      SUNRPC: Bound-check xdr_buf_to_bvec() stores before writing
      SUNRPC: Return an error from xdr_buf_to_bvec() on overflow
      sunrpc: wait for in-flight TLS handshake callback when cancel loses race
      svcrdma: wake sq waiters when the transport closes

Dominik Woźniak (1):
      nfsd: check get_user() return when reading princhashlen

Guannan Wang (1):
      NFSD: Fix SECINFO_NO_NAME decode error cleanup

Jeff Layton (27):
      filelock: pass current blocking lease to trace_break_lease_block() rather than "new_fl"
      filelock: add support for ignoring deleg breaks for dir change events
      filelock: add a tracepoint to start of break_lease()
      filelock: add an inode_lease_ignore_mask helper
      fsnotify: new tracepoint in fsnotify()
      fsnotify: add fsnotify_modify_mark_mask()
      fsnotify: add FSNOTIFY_EVENT_RENAME data type
      filelock: move LEASE_BREAK_* flags out of #ifdef CONFIG_FILE_LOCKING
      nfsd: move struct nfsd_genl_rqstp to nfsctl.c
      sunrpc: rename sunrpc_cache_pipe_upcall() to sunrpc_cache_upcall()
      sunrpc: rename sunrpc_cache_pipe_upcall_timeout()
      sunrpc: rename cache_pipe_upcall() to cache_do_upcall()
      sunrpc: add a cache_notify callback
      sunrpc: add helpers to count and snapshot pending cache requests
      sunrpc: add a generic netlink family for cache upcalls
      sunrpc: add netlink upcall for the auth.unix.ip cache
      sunrpc: add netlink upcall for the auth.unix.gid cache
      nfsd: add netlink upcall for the svc_export cache
      nfsd: add netlink upcall for the nfsd.fh cache
      sunrpc: add SUNRPC_CMD_CACHE_FLUSH netlink command
      nfsd: add NFSD_CMD_CACHE_FLUSH netlink command
      nfsd: fix dead ACL conflict guard in nfsd4_create
      nfsd: fix inverted cp_ttl check in async copy reaper
      nfsd: fix posix_acl leak and ignored error in nfsd4_create_file
      nfsd: fix posix_acl leak on SETACL decode failure
      nfsd: avoid leaking pre-allocated openowner on unconfirmed retry race
      nfsd: reset write verifier on deferred writeback errors

Luxiao Xu (1):
      sunrpc: harden rq_procinfo lifecycle to prevent double-free

Yang Erkun (1):
      Revert "NFSD: Defer sub-object cleanup in export put callbacks"

 .mailmap                                        |    6 +-
 Documentation/netlink/specs/nfsd.yaml           |  290 ++++
 Documentation/netlink/specs/sunrpc_cache.yaml   |  149 ++
 Documentation/sunrpc/xdr/nlm3.x                 |  168 ++
 MAINTAINERS                                     |   10 +-
 fs/attr.c                                       |    2 +-
 fs/exfat/exfat_fs.h                             |    2 +
 fs/exfat/file.c                                 |   18 +-
 fs/exfat/namei.c                                |    1 +
 fs/fat/fat.h                                    |    3 +
 fs/fat/file.c                                   |   36 +
 fs/fat/namei_msdos.c                            |    1 +
 fs/fat/namei_vfat.c                             |    1 +
 fs/file_attr.c                                  |   16 +-
 fs/hfs/dir.c                                    |    1 +
 fs/hfs/hfs_fs.h                                 |    2 +
 fs/hfs/inode.c                                  |   14 +
 fs/hfsplus/inode.c                              |   16 +-
 fs/isofs/dir.c                                  |   16 +
 fs/isofs/isofs.h                                |    3 +
 fs/lockd/Makefile                               |   19 +-
 fs/lockd/clnt4xdr.c                             |   42 +-
 fs/lockd/clntlock.c                             |    2 +-
 fs/lockd/clntproc.c                             |   14 +-
 fs/lockd/clntxdr.c                              |   44 +-
 fs/lockd/host.c                                 |    4 +-
 fs/lockd/lockd.h                                |   65 +-
 fs/lockd/mon.c                                  |    2 +-
 fs/lockd/nlm3xdr_gen.c                          |  714 +++++++++
 fs/lockd/nlm3xdr_gen.h                          |   32 +
 fs/lockd/share.h                                |    4 +-
 fs/lockd/svc4proc.c                             |   72 +-
 fs/lockd/svclock.c                              |   38 +-
 fs/lockd/svcproc.c                              | 1844 ++++++++++++++--------
 fs/lockd/svcshare.c                             |    8 +-
 fs/lockd/svcsubs.c                              |    9 +-
 fs/lockd/svcxdr.h                               |  142 --
 fs/lockd/trace.h                                |   16 +-
 fs/lockd/xdr.c                                  |  354 -----
 fs/lockd/xdr.h                                  |   39 +-
 fs/locks.c                                      |  118 +-
 fs/namei.c                                      |   31 +-
 fs/nfs/client.c                                 |   28 +-
 fs/nfs/dns_resolve.c                            |    2 +-
 fs/nfs/inode.c                                  |   15 +
 fs/nfs/internal.h                               |    3 +
 fs/nfs/namespace.c                              |    2 +
 fs/nfs/nfs3proc.c                               |    2 +
 fs/nfs/nfs3xdr.c                                |    7 +-
 fs/nfs/nfs4proc.c                               |   10 +-
 fs/nfs/proc.c                                   |    3 +
 fs/nfs/symlink.c                                |    3 +
 fs/nfsd/blocklayout.c                           |   37 +-
 fs/nfsd/export.c                                |  784 +++++++++-
 fs/nfsd/export.h                                |    7 +-
 fs/nfsd/filecache.c                             |   46 +
 fs/nfsd/filecache.h                             |    1 +
 fs/nfsd/netlink.c                               |  129 ++
 fs/nfsd/netlink.h                               |   21 +
 fs/nfsd/nfs2acl.c                               |   17 +-
 fs/nfsd/nfs3acl.c                               |   17 +-
 fs/nfsd/nfs3proc.c                              |   39 +-
 fs/nfsd/nfs4idmap.c                             |    4 +-
 fs/nfsd/nfs4layouts.c                           |   43 +-
 fs/nfsd/nfs4proc.c                              |   19 +-
 fs/nfsd/nfs4recover.c                           |    3 +-
 fs/nfsd/nfs4state.c                             |  267 +++-
 fs/nfsd/nfs4xdr.c                               |  102 +-
 fs/nfsd/nfsctl.c                                |  213 ++-
 fs/nfsd/nfsd.h                                  |   22 +-
 fs/nfsd/state.h                                 |    6 +
 fs/nfsd/trace.h                                 |   32 +-
 fs/nfsd/vfs.c                                   |   98 +-
 fs/nfsd/vfs.h                                   |    3 +
 fs/nfsd/xdr3.h                                  |    4 +-
 fs/nfsd/xdr4.h                                  |   14 +
 fs/notify/fsnotify.c                            |    5 +
 fs/notify/mark.c                                |   29 +
 fs/ntfs3/file.c                                 |   29 +
 fs/ntfs3/namei.c                                |    1 +
 fs/ntfs3/ntfs_fs.h                              |    1 +
 fs/posix_acl.c                                  |    4 +-
 fs/smb/client/cifsfs.c                          |   53 +
 fs/smb/client/cifsfs.h                          |    3 +
 fs/smb/client/namespace.c                       |    1 +
 fs/smb/server/smb2pdu.c                         |   30 +-
 fs/vboxsf/dir.c                                 |    1 +
 fs/vboxsf/file.c                                |    6 +-
 fs/vboxsf/super.c                               |    7 +
 fs/vboxsf/utils.c                               |   30 +
 fs/vboxsf/vfsmod.h                              |    6 +
 fs/xattr.c                                      |    4 +-
 fs/xfs/libxfs/xfs_inode_util.c                  |    2 +
 fs/xfs/xfs_export.c                             |    4 +-
 fs/xfs/xfs_ioctl.c                              |   22 +-
 fs/xfs/xfs_pnfs.c                               |   44 +-
 fs/xfs/xfs_pnfs.h                               |   11 +-
 include/linux/exportfs.h                        |   25 +-
 include/linux/exportfs_block.h                  |   88 ++
 include/linux/fileattr.h                        |    3 +-
 include/linux/filelock.h                        |   66 +-
 include/linux/fsnotify.h                        |    8 +-
 include/linux/fsnotify_backend.h                |   21 +
 include/linux/nfs_fs_sb.h                       |    2 +-
 include/linux/nfs_xdr.h                         |    2 +
 include/linux/sunrpc/cache.h                    |   15 +-
 include/linux/sunrpc/gss_krb5.h                 |  105 --
 include/linux/sunrpc/svc_rdma.h                 |    7 +-
 include/linux/sunrpc/xdr.h                      |   20 +-
 include/linux/sunrpc/xdrgen/nlm3.h              |  210 +++
 include/trace/events/filelock.h                 |   38 +-
 include/trace/events/fsnotify.h                 |   51 +
 include/trace/misc/fsnotify.h                   |   35 +
 include/uapi/linux/fs.h                         |   18 +-
 include/uapi/linux/nfsd_netlink.h               |  156 ++
 include/uapi/linux/sunrpc_netlink.h             |   84 +
 net/sunrpc/.kunitconfig                         |   29 -
 net/sunrpc/Kconfig                              |   56 +-
 net/sunrpc/Makefile                             |    2 +-
 net/sunrpc/auth_gss/Makefile                    |    4 +-
 net/sunrpc/auth_gss/gss_krb5_crypto.c           | 1014 +++---------
 net/sunrpc/auth_gss/gss_krb5_internal.h         |  155 +-
 net/sunrpc/auth_gss/gss_krb5_keys.c             |  546 -------
 net/sunrpc/auth_gss/gss_krb5_mech.c             |  441 ++----
 net/sunrpc/auth_gss/gss_krb5_seal.c             |   47 +-
 net/sunrpc/auth_gss/gss_krb5_test.c             | 1868 -----------------------
 net/sunrpc/auth_gss/gss_krb5_unseal.c           |   36 +-
 net/sunrpc/auth_gss/gss_krb5_wrap.c             |   13 +-
 net/sunrpc/auth_gss/svcauth_gss.c               |    2 +-
 net/sunrpc/cache.c                              |  127 +-
 net/sunrpc/netlink.c                            |   97 ++
 net/sunrpc/netlink.h                            |   35 +
 net/sunrpc/sunrpc_syms.c                        |   10 +
 net/sunrpc/svc.c                                |   10 +
 net/sunrpc/svc_xprt.c                           |   46 +-
 net/sunrpc/svcauth_unix.c                       |  516 ++++++-
 net/sunrpc/svcsock.c                            |   24 +-
 net/sunrpc/xdr.c                                |  289 +++-
 net/sunrpc/xprtrdma/svc_rdma.c                  |   18 +-
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c         |   13 +-
 net/sunrpc/xprtrdma/svc_rdma_rw.c               |  242 +--
 net/sunrpc/xprtrdma/svc_rdma_sendto.c           |   97 +-
 net/sunrpc/xprtrdma/svc_rdma_transport.c        |   33 +-
 tools/perf/trace/beauty/include/uapi/linux/fs.h |    7 +
 144 files changed, 7338 insertions(+), 6057 deletions(-)
 create mode 100644 Documentation/netlink/specs/sunrpc_cache.yaml
 create mode 100644 Documentation/sunrpc/xdr/nlm3.x
 create mode 100644 fs/lockd/nlm3xdr_gen.c
 create mode 100644 fs/lockd/nlm3xdr_gen.h
 delete mode 100644 fs/lockd/svcxdr.h
 delete mode 100644 fs/lockd/xdr.c
 create mode 100644 include/linux/exportfs_block.h
 create mode 100644 include/linux/sunrpc/xdrgen/nlm3.h
 create mode 100644 include/trace/events/fsnotify.h
 create mode 100644 include/trace/misc/fsnotify.h
 create mode 100644 include/uapi/linux/sunrpc_netlink.h
 delete mode 100644 net/sunrpc/.kunitconfig
 delete mode 100644 net/sunrpc/auth_gss/gss_krb5_keys.c
 delete mode 100644 net/sunrpc/auth_gss/gss_krb5_test.c
 create mode 100644 net/sunrpc/netlink.c
 create mode 100644 net/sunrpc/netlink.h

