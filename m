Return-Path: <linux-nfs+bounces-21084-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCykJJoe7GmpUgAAu9opvQ
	(envelope-from <linux-nfs+bounces-21084-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Apr 2026 03:53:30 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4646D4647EE
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Apr 2026 03:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE625301DD85
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Apr 2026 01:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F786224B05;
	Sat, 25 Apr 2026 01:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obe7iRq/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31594199FAB;
	Sat, 25 Apr 2026 01:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777082004; cv=none; b=EJqgv+Ti3qaHkbtJSXBJEsnnoz56/16p3eUFcWRdkLYowhUrt+VT02AdCr6j7RfCMfJosdL9IMUmBywSL3+t1I2ceAtb2PKdE7hgqrTGPZIXeAvfsJE78A5Ar2tXqqkcVR1IqqCMwTdr7K54yJCvO0G80VFT3CpTNi2iAGAKIJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777082004; c=relaxed/simple;
	bh=qvbC5NlYJmq/Ki8T76bjgsnV+oxegfIoPZjnm5RLKp0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VzywwjQPFaIc2KjmuNW0ttHISgFvJl/ohBhaP4TfPBgFxXhvMoHcMkupyTlrF0VkypM3cI//J+7Mr1pxPTANEtFWaEhDjBPMTdp2ct3soU8jJhoNSr7eAcFr5XbONr0lTVzkbh5sOnrMncDKKyfTtntJmsnBNwYKKwzcYxZY3oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obe7iRq/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DBE0C19425;
	Sat, 25 Apr 2026 01:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777082003;
	bh=qvbC5NlYJmq/Ki8T76bjgsnV+oxegfIoPZjnm5RLKp0=;
	h=From:Subject:Date:To:Cc:From;
	b=obe7iRq/78V4hlxas+M4IIY2ietF4Re1Q5+/0Zv3hpkpLObsrB096NwkS69HKH/W0
	 rDucRPzvRkf/MpvZtDIoZTClP4f0bG58Vhmi6BQVE9UgYju8aQmyqwPtu5PuqvKC7N
	 mt4cOSSIYMRlUS+4AkHrx593m02Nd66ysnKeOePU7HDX5Q5n8+rm2DrGV2c/fFT5sc
	 CRi6d+AfwuQmQoTlzYaejf1Xqz0vsqJe3aQb5MFnUtSqfSUCJKDxzZ+j7eZP4cFDr4
	 jBFXhY87/O2DZJqyr8sU/RibGXgGM80I39VH+CEMzB6G51RkuufduwhuMtU8rY5paY
	 flqqoWdGLybyQ==
From: Chuck Lever <cel@kernel.org>
Subject: [PATCH v11 00/15] Exposing case folding behavior
Date: Fri, 24 Apr 2026 21:53:02 -0400
Message-Id: <20260424-case-sensitivity-v11-0-de5619beddaf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH4e7GkC/33OTY7CMAwF4KugrElJUvoDK+6BZpG4DjVimlFco
 kGod5+E2YCEWHhh6/nTuwvGSMhiv7qLiImYwpQXrdcrAaOdTihpyAdhlGnV1hgJllEyTkwzJZp
 vsgHnPfReN00v8ttPRE+/D/P49b/z1Z0R5uKUhCuEi3aCsZyS500e2VWmKroPl6HERuI5xNujW
 9oV7kOLtJNKOlSmBlCdQnMI0cIFKwjfotRIWj0T9RtCq2xA3TdD221tC/7FWJblD2SwXuQvAQA
 A
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
 Roland Mainz <roland.mainz@nrubsig.org>, 
 Steve French <stfrench@microsoft.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=9166;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=qvbC5NlYJmq/Ki8T76bjgsnV+oxegfIoPZjnm5RLKp0=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp7B6H5jdQVrURdMJvzvrzrIyiUSlrW5F2+jU/R
 Siuyfo+iJGJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaewehwAKCRAzarMzb2Z/
 l+X+EACyaFUfr4QKWt5y0e34mlhjRMJ16e/r6VqqsKyfiVX49EWNfI1+fqQWN7crSb2JyzkDiwQ
 TfmMenKRLJq6gn07kayO2ke6tBRF7EGXKjpoOWiHnblh2mxCnSJnsrfi3qlUeoYiIbBnNU/odye
 aay7Oc1lPC5H20togSfavnVmmpL2YYlnMH2EHnGU2L4LZChunD0/IfYWPZax+Upd1XEXJzT7TzN
 25jsYLE1wQt1t3z8nrIzwP5ENjONsjU+orBswHvwDsAkAyZ10JnsKXMi875QkAzfPH1ULUYMjVt
 w1AnXZiQmYJJVYIUm4X4UcCkOZr9s18estxDSKJKreNbc5QgKZcRbDjxcl/dnat5A1X3DfPU6hU
 DokgoXGqFpPBJtt7VUTWxdL5wvB4g0FClIfhU9fvM71H1A5gHngve5yLMY7JkaElkZU41BZBdeb
 OeDHaOayluNaZzoEF+SziM2r/tMuvFIo3Va6sZijT5hePfU/Hl8VnnIYaTM0XSc2ogZ95Slnxjd
 V+PQIA0xMrGPjcOHbrhSimiga/tCwSZEGn1MSy6JbEoJIkYyR3MjyNf6LjmR1XQoKmrKUm+FRz8
 bf9kUal3P0vjZYUaZFdstuL7nbIcSXkNYHplWmtJM7j1kxH33LxE4QIlmgBvftE/d3zYWzCU5cw
 A7/Qq0k/0kXGePQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 4646D4647EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21084-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com,nrubsig.org];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Following on from:

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
Changes since v10:
- cifs: Source case-handling flags from the server's cached
  FS_ATTRIBUTE_INFORMATION reply instead of the nocase mount
  option, with a nocase fallback when the reply is absent
- Address findings from sashiko(gemini-3) and gpt-5.5:
  - nfs: Skip pathconf case bits on NFSv4 (set via FATTR4_CASE_*
    instead)
  - xfs: Hide FS_CASEFOLD_FL from the legacy flags view so
    chattr round-trips do not hit the setflags whitelist
  - ext4, f2fs: Drop redundant fileattr_get patches; the
    FS_CASEFOLD_FL translation in fileattr_fill_flags() already
    reports FS_XFLAG_CASEFOLD for casefolded directories
  - nfsd: Report FATTR4_HOMOGENEOUS = FALSE when the exported
    filesystem has a Unicode encoding, since per-directory
    casefold makes the fs-scoped case attributes inhomogeneous
  - nfsd: Document in nfsd_get_case_info() why -ENOIOCTLCMD and
    -ENOTTY are swallowed while other errors propagate
  - fat: Honor vfat 'check=strict' when reporting FS_XFLAG_CASEFOLD
  - Set FS_CASEFOLD_FL so FS_IOC_GETFLAGS reflects case-insensitive
    mount
  - isofs: Register fileattr_get on regular file and symlink inodes,
    not just directories
  - nfsd: Query NFSv4 FATTR4_CASE_* from the parent directory for
    non-directory objects, since casefold lives on the directory

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
Changes in v11:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v10: https://patch.msgid.link/20260423-case-sensitivity-v10-0-c385d674a6cf@oracle.com

---
Chuck Lever (15):
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

 fs/exfat/exfat_fs.h            |  2 ++
 fs/exfat/file.c                | 18 ++++++++++++--
 fs/exfat/namei.c               |  1 +
 fs/fat/fat.h                   |  3 +++
 fs/fat/file.c                  | 32 ++++++++++++++++++++++++
 fs/fat/namei_msdos.c           |  1 +
 fs/fat/namei_vfat.c            |  1 +
 fs/file_attr.c                 | 16 ++++++------
 fs/hfs/dir.c                   |  1 +
 fs/hfs/hfs_fs.h                |  2 ++
 fs/hfs/inode.c                 | 14 +++++++++++
 fs/hfsplus/inode.c             | 12 +++++++++
 fs/isofs/dir.c                 | 24 ++++++++++++++++++
 fs/isofs/inode.c               |  3 ++-
 fs/isofs/isofs.h               |  5 ++++
 fs/nfs/client.c                | 22 +++++++++++++----
 fs/nfs/inode.c                 | 23 ++++++++++++++++++
 fs/nfs/internal.h              |  3 +++
 fs/nfs/nfs3proc.c              |  2 ++
 fs/nfs/nfs3xdr.c               |  7 ++++--
 fs/nfs/nfs4proc.c              |  7 ++++--
 fs/nfs/proc.c                  |  3 +++
 fs/nfs/symlink.c               |  3 +++
 fs/nfsd/nfs3proc.c             | 18 ++++++++------
 fs/nfsd/nfs4xdr.c              | 55 +++++++++++++++++++++++++++++++++++++++---
 fs/nfsd/vfs.c                  | 43 +++++++++++++++++++++++++++++++++
 fs/nfsd/vfs.h                  |  3 +++
 fs/ntfs3/file.c                | 25 +++++++++++++++++++
 fs/ntfs3/inode.c               |  1 +
 fs/ntfs3/namei.c               |  2 ++
 fs/ntfs3/ntfs_fs.h             |  1 +
 fs/smb/client/cifsfs.c         | 42 ++++++++++++++++++++++++++++++++
 fs/smb/server/smb2pdu.c        | 30 ++++++++++++++++++-----
 fs/vboxsf/dir.c                |  1 +
 fs/vboxsf/file.c               |  6 +++--
 fs/vboxsf/super.c              |  7 ++++++
 fs/vboxsf/utils.c              | 30 +++++++++++++++++++++++
 fs/vboxsf/vfsmod.h             |  6 +++++
 fs/xfs/libxfs/xfs_inode_util.c |  2 ++
 fs/xfs/xfs_ioctl.c             |  9 ++++++-
 include/linux/fileattr.h       |  3 ++-
 include/linux/nfs_fs_sb.h      |  2 +-
 include/linux/nfs_xdr.h        |  2 ++
 include/uapi/linux/fs.h        |  7 ++++++
 44 files changed, 458 insertions(+), 42 deletions(-)
---
base-commit: 6596a02b207886e9e00bb0161c7fd59fea53c081
change-id: 20260422-case-sensitivity-5cbffc8f1558

Best regards,
--  
Chuck Lever


