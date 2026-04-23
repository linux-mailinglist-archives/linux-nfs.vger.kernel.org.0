Return-Path: <linux-nfs+bounces-21025-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDAzJjMb6mkOuQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21025-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 15:14:27 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B15CA452999
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 15:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DC4B7300293D
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 13:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B113EF659;
	Thu, 23 Apr 2026 13:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IILodtAw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC173EE1FD;
	Thu, 23 Apr 2026 13:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776949943; cv=none; b=PZrtch1oqoDaSvSEUCnKmhVlThzTIA8rlP9zBbbHblp3s5AjOG6qqmlG9YguBd7gOzlNhTplDAsDNck2H/7sfMV8EA/1OTRHW83KM0d86iVYW0heKB6Jk3XD6t55ga7/naMaz9D6/eEHxxD4540yFgjjE4X0y3IB6qMNP1esZ5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776949943; c=relaxed/simple;
	bh=zITQY7URJaiomb4pdYoYZ4b1/QORfG8dd6SYataRHTI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZmzNoD+vUZa8TeIUT+TUfx7j+d6lnxVUqMmfRUYB4aKWRBOajubmHEqiKGO775Rg+S+A+ufl3NucFv1q7jFSikXeSpEEJTMCEofeyzkdy3RZRIvVOSEUgm5VLg9kP2rnwom0YI9oylUqer/F75pwnYElyhu8ki6MtJu2BPXLssU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IILodtAw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0678DC2BCAF;
	Thu, 23 Apr 2026 13:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776949943;
	bh=zITQY7URJaiomb4pdYoYZ4b1/QORfG8dd6SYataRHTI=;
	h=From:Subject:Date:To:Cc:From;
	b=IILodtAwAeF9S2IKmZvpSRQBBS+x3xHi1sBMiKLLhx9WtOzxWQZGLPIQTFHFGulPY
	 GbsOsGgH3FcgjGnhZv+WXGiwNfchlVFEecgIBklsu00wT/qpI5kndpM3KNoEGoajOv
	 L7q1/gi25XG/XBR0jomgEKKoFqLl/tqm0fq5RB8oCZxKKHQ6MeLxFh9kNmITkPtUOX
	 96LhBRZVs1qXIlCYFnZMGxYgqeLiXRZdswP72HQ7s+H12ItDIVClpHKsFvZ8fmnjzB
	 wdJEVDK24GuuCOfzMeYs42Ii6dhfqWJj8sDIzdiRjPtc0PL5GpBF3+rrxfqs/fQq9z
	 eXFtlBntQvaKg==
From: Chuck Lever <cel@kernel.org>
Subject: [PATCH v10 00/17] Exposing case folding behavior
Date: Thu, 23 Apr 2026 09:12:03 -0400
Message-Id: <20260423-case-sensitivity-v10-0-c385d674a6cf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKMa6mkC/32OwQ6CMBBEf8X0bLFUEfDkfxgOdNnKGmxNFxsJ4
 d+lePcwh5nMvMwsGAMhi8tuFgEjMXm3mlztdwL61t1RUrcGQit9VietJbSMktExjRRpnGQBxlq
 obF4UlVhnr4CWPhvz1vw8v80DYUyc1DAJYULroE9RtHxYJctMZ4lu/dClWk88+jBt32KdcH9ex
 FoqaVDpI4AqFeqrDy0MmIF/imZZli+YMWt/6wAAAA==
X-Change-ID: 20260422-case-sensitivity-5cbffc8f1558
To: Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp, 
 linkinjeon@kernel.org, sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
 almaz.alexandrovich@paragon-software.com, slava@dubeyko.com, 
 glaubitz@physik.fu-berlin.de, frank.li@vivo.com, tytso@mit.edu, 
 adilger.kernel@dilger.ca, cem@kernel.org, sfrench@samba.org, 
 pc@manguebit.org, ronniesahlberg@gmail.com, sprasad@microsoft.com, 
 trondmy@kernel.org, anna@kernel.org, jaegeuk@kernel.org, chao@kernel.org, 
 hansg@kernel.org, senozhatsky@chromium.org, 
 Chuck Lever <chuck.lever@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>, 
 Steve French <stfrench@microsoft.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7717;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=zITQY7URJaiomb4pdYoYZ4b1/QORfG8dd6SYataRHTI=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp6hqqeHVpp79KbBv0AGQu/7HLZgvKrtIfyjDE6
 y30SyK1XNGJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaeoaqgAKCRAzarMzb2Z/
 l9FID/9u/35AiOQpLQ0WiSQ7BBovPqy68c5rzbxtmzRMo7SFgqpLPC+FfzB4InZLUp7le0PTGhB
 Wzk5f/2NxraLX9Xj+JYpF/HEsfNOtzKDzsMLGKdEIT32LsDrjgA74rNxnfZ4h15MUQMaMW2gx8c
 FBEhleUycDYFDbws6zEe9iIa/Zl059BtjJl8JnGyrMq6mvLjCR8couUy/Ws8NZz7DTgg0fwvCcg
 044MLWkXmqs+8U2TGH7l2wYHMLCQjnuWYwHRleKbD4zNJxLQjEKg9AyOfa5JO/GYyxWjv0TpIhm
 kqxCnRiPJxEoHc0JWXn5tIH/JN9PTG4XYQAYTwTYKJ/1HIw9LPNxmKzq6RGB/XY0/3sC5cFcjPG
 Tq1XFw+lBgZw91wicfQwxHRWJtWzs0GITaNvreOQfYOHcuZ8gRmQfKuMFFouy61SXUaTQiVfXBa
 cvKI7GM3ENMy5nde/m9STz8DZxQgP11f8TZNk2bjuHoYjtG9mly2qeovTHFQ3SdxEIOw6kkOust
 LtiwFlVTkxPCqsFRnNjsxaSV3uTQfZxlPc2RzFdUT4WdVO960V7j28M7NPOiproq+qeIhXhuXXQ
 R/FYbkqWFAjkZtrxEt7r4fIBK0UJ6AzuK7qyqx1ShF7MI48v161gUONc/MdqqoQxDSBXsnz3fZq
 3pt6JIzqDOw2avw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21025-lists,linux-nfs=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[34];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MAILSPIKE_FAIL(0.00)[2600:3c15:e001:75::12fc:5321:query timed out];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B15CA452999
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Following on from

https://lore.kernel.org/linux-nfs/20251021-zypressen-bazillus-545a44af57fd@brauner/T/#m0ba197d75b7921d994cf284f3cef3a62abb11aaa

I'm attempting to implement enough support in the Linux VFS to
enable file services like NFSD and ksmbd (and user space
equivalents) to provide the actual status of case folding support
in local file systems. The default behavior for local file systems
not explicitly supported in this series is to reflect the usual
POSIX behaviors:

  case-insensitive = false
  case-nonpreserving = false

The case-insensitivity and case-nonpreserving booleans can be
consumed immediately by NFSD. These two attributes have been part of
the NFSv3 and NFSv4 protocols for decades, in order to support NFS
client implementations on non-POSIX systems.

Support for user space file servers is why this series exposes case
folding information via a user-space API. I don't know of any other
category of user-space application that requires access to case
folding info.

The Linux NFS community has a growing interest in supporting NFS
clients on Windows and MacOS platforms, where file name behavior does
not align with traditional POSIX semantics.

One example of a Windows-based NFS client is [1]. This client
implementation explicitly requires servers to report
FATTR4_WORD0_CASE_INSENSITIVE = TRUE for proper operation, a hard
requirement for Windows client interoperability because Windows
applications expect case-insensitive behavior. When an NFS client
knows the server is case-insensitive, it can avoid issuing multiple
LOOKUP/READDIR requests to search for case variants, and applications
like Win32 programs work correctly without manual workarounds or
code changes.

Even the Linux client can take advantage of this information. Trond
merged patches 4 years ago [2] that introduce support for case
insensitivity, in support of the Hammerspace NFS server. In
particular, when a client detects a case-insensitive NFS share,
negative dentry caching must be disabled (a lookup for "FILE.TXT"
failing shouldn't cache a negative entry when "file.txt" exists)
and directory change invalidation must clear all cached case-folded
file name variants.

Hammerspace servers and several other NFS server implementations
operate in multi-protocol environments, where a single file service
instance caters to both NFS and SMB clients. In those cases, things
work more smoothly for everyone when the NFS client can see and adapt
to the case folding behavior that SMB users rely on and expect. NFSD
needs to support the case-insensitivity and case-nonpreserving
booleans properly in order to participate as a first-class citizen
in such environments.

[1] https://github.com/kofemann/ms-nfs41-client

[2] https://patchwork.kernel.org/project/linux-nfs/cover/20211217203658.439352-1-trondmy@kernel.org/

---
Changes since v9:
- nfs: always probe PATHCONF for case caps. Default to case-
  preserving when the server does not report case_preserving
- nfsd, ksmbd: tolerate -ENOTTY from vfs_fileattr_get() so
  overlayfs exports on backing filesystems without fileattr_get
  do not fail the RPC
- xfs: map FS_XFLAG_CASEFOLD inside xfs_ip2xflags() so BULKSTAT
  and FS_IOC_FSGETXATTR report the flag consistently
- vboxsf: reject a short host reply to SHFL_INFO_VOLUME before
  trusting volinfo.properties.case_sensitive

Changes since v8:
- Rebase on v7.0-rc1

Changes since v7:
- Split file_attr initialization changes into a separate patch

Changes since v6:
- Remove the memset from vfs_fileattr_get

Changes since v5:
- Finish the conversion to FS_XFLAGs
- NFSv4 GETATTR now clears the attr mask bit if nfsd_get_case_info()
  fails

Changes since v4:
- Observe the MSDOS "nocase" mount option
- Define new FS_XFLAGs for the user API

Changes since v3:
- Change fa->case_preserving to fa_case_nonpreserving
- VFAT is case preserving
- Make new fields available to user space

Changes since v2:
- Remove unicode labels
- Replace vfs_get_case_info
- Add support for several more local file system implementations
- Add support for in-kernel SMB server

Changes since RFC:
- Use file_getattr instead of statx
- Postpone exposing Unicode version until later
- Support NTFS and ext4 in addition to FAT
- Support NFSv4 fattr4 in addition to NFSv3 PATHCONF

---
Chuck Lever (17):
      fs: Move file_kattr initialization to callers
      fs: Add case sensitivity flags to file_kattr
      fat: Implement fileattr_get for case sensitivity
      exfat: Implement fileattr_get for case sensitivity
      ntfs3: Implement fileattr_get for case sensitivity
      hfs: Implement fileattr_get for case sensitivity
      hfsplus: Report case sensitivity in fileattr_get
      ext4: Report case sensitivity in fileattr_get
      xfs: Report case sensitivity in fileattr_get
      cifs: Implement fileattr_get for case sensitivity
      nfs: Implement fileattr_get for case sensitivity
      f2fs: Add case sensitivity reporting to fileattr_get
      vboxsf: Implement fileattr_get for case sensitivity
      isofs: Implement fileattr_get for case sensitivity
      nfsd: Report export case-folding via NFSv3 PATHCONF
      nfsd: Implement NFSv4 FATTR4_CASE_INSENSITIVE and FATTR4_CASE_PRESERVING
      ksmbd: Report filesystem case sensitivity via FS_ATTRIBUTE_INFORMATION

 fs/exfat/exfat_fs.h            |  2 ++
 fs/exfat/file.c                | 17 +++++++++++++++--
 fs/exfat/namei.c               |  1 +
 fs/ext4/ioctl.c                |  7 +++++++
 fs/f2fs/file.c                 |  8 ++++++++
 fs/fat/fat.h                   |  3 +++
 fs/fat/file.c                  | 23 +++++++++++++++++++++++
 fs/fat/namei_msdos.c           |  1 +
 fs/fat/namei_vfat.c            |  1 +
 fs/file_attr.c                 | 16 ++++++++--------
 fs/hfs/dir.c                   |  1 +
 fs/hfs/hfs_fs.h                |  2 ++
 fs/hfs/inode.c                 | 13 +++++++++++++
 fs/hfsplus/inode.c             | 10 ++++++++++
 fs/isofs/dir.c                 | 11 +++++++++++
 fs/nfs/client.c                | 15 ++++++++++-----
 fs/nfs/inode.c                 | 21 +++++++++++++++++++++
 fs/nfs/internal.h              |  3 +++
 fs/nfs/nfs3proc.c              |  2 ++
 fs/nfs/nfs3xdr.c               |  7 +++++--
 fs/nfs/nfs4proc.c              |  7 +++++--
 fs/nfs/proc.c                  |  3 +++
 fs/nfs/symlink.c               |  3 +++
 fs/nfsd/nfs3proc.c             | 18 ++++++++++--------
 fs/nfsd/nfs4xdr.c              | 25 +++++++++++++++++++++++--
 fs/nfsd/vfs.c                  | 29 +++++++++++++++++++++++++++++
 fs/nfsd/vfs.h                  |  3 +++
 fs/ntfs3/file.c                | 23 +++++++++++++++++++++++
 fs/ntfs3/inode.c               |  1 +
 fs/ntfs3/namei.c               |  2 ++
 fs/ntfs3/ntfs_fs.h             |  1 +
 fs/smb/client/cifsfs.c         | 20 ++++++++++++++++++++
 fs/smb/server/smb2pdu.c        | 25 +++++++++++++++++++------
 fs/vboxsf/dir.c                |  1 +
 fs/vboxsf/file.c               |  6 ++++--
 fs/vboxsf/super.c              |  7 +++++++
 fs/vboxsf/utils.c              | 28 ++++++++++++++++++++++++++++
 fs/vboxsf/vfsmod.h             |  6 ++++++
 fs/xfs/libxfs/xfs_inode_util.c |  2 ++
 fs/xfs/xfs_ioctl.c             |  2 +-
 include/linux/fileattr.h       |  3 ++-
 include/linux/nfs_fs_sb.h      |  2 +-
 include/linux/nfs_xdr.h        |  2 ++
 include/uapi/linux/fs.h        |  7 +++++++
 44 files changed, 350 insertions(+), 40 deletions(-)
---
base-commit: 6596a02b207886e9e00bb0161c7fd59fea53c081
change-id: 20260422-case-sensitivity-5cbffc8f1558

Best regards,
--  
Chuck Lever


