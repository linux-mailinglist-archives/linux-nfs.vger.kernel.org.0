Return-Path: <linux-nfs+bounces-21346-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJXXOlwI9mk3RwIAu9opvQ
	(envelope-from <linux-nfs+bounces-21346-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 02 May 2026 16:21:16 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 516BC4B24AE
	for <lists+linux-nfs@lfdr.de>; Sat, 02 May 2026 16:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 677BC300F509
	for <lists+linux-nfs@lfdr.de>; Sat,  2 May 2026 14:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCEA322522;
	Sat,  2 May 2026 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0OplOmM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5508626D4DD;
	Sat,  2 May 2026 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777731672; cv=none; b=cAP+8QQsu+VojLvSTxKGoLGXv8rOkSgSyS/3oQ/XbyQfPHtRXNCUvOguXA91j4KOeGb/6j4zAW7uZH7Q8m46Dp722kH82cE9sF1IcCWcVyXqEAEMx5le3u6f6Wz4YKWSI+7dX7dXA1VbjbjFW1VMZs2gdX3VSPnaVfvj3wDItUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777731672; c=relaxed/simple;
	bh=S8uXYzoY0/m42R5BMCcNDvtfUd9F8GUKvIduB+tGh50=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cNUydzEHaQ6ZW3Bj1AUGUwioOVp+hSfIEZfNdnVD1X/W8+RgVsf5JpbJVcY99tmMLAbXk4aobRmU4OedYAvSMvJnfrY//xCW9vllCRb77ER/wECXEqjC6ex0w2ofKW5XkIp/PHesvNTFSdWi6D+RntOrFXLGmn3wjsuGQmG4VZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0OplOmM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C86C19425;
	Sat,  2 May 2026 14:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777731671;
	bh=S8uXYzoY0/m42R5BMCcNDvtfUd9F8GUKvIduB+tGh50=;
	h=From:Subject:Date:To:Cc:From;
	b=T0OplOmM9zbebhox/z03dEvqatD2rPvsRfoOb9fg60pWEuY8I0X1czPc1xuA8Kf6h
	 VqF7q/nHrvm/bZU8ISq6v0oy4X+w3bXrEz4ouewV6B+AVltx3D8UB2UKaOZV5QZi3b
	 07FxXLEhk2xXPek427XW3nDe6uBe94ux20g7+wrk1/+MPJfOIHwf0cop643dmrJrtq
	 W49HIt3WSyqenbsPGsgDMzk3bHuad0mFqJnIeGOMZKmKr9DT7TdVw7DiXSIQ2pbi4w
	 4G8Jzg+jSusCacMZsGOwDJQ/wcn4R3g5mWbY8uddhU5R1QLeJQzm/mahTm+Us52uXO
	 e6bNRKaNjiXGA==
From: Chuck Lever <cel@kernel.org>
Subject: [PATCH v13 00/15] Exposing case folding behavior
Date: Sat, 02 May 2026 10:20:45 -0400
Message-Id: <20260502-case-sensitivity-v13-0-aa853140311f@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD0I9mkC/33PzU7EIBAH8FfZcJYK09IPT76H8QDDYDG7xUAlb
 jZ9d2G91Nh4mMNMZn75z40lip4SezrdWKTskw9LaWT7cGI46+WNuLdlwEBALzoAjjoRT7Qkv/r
 s1ytXaJzD0UmlRlbOPiI5/3U3X15/+vRp3gnX6tQNUwkT9YJzHWWXHkvxoYGm6i6cbV2bfVpDv
 N6z5aly/6TIExfckIAWUQyC4DlEjWdqMFxYjZGl2BPtASFFMbAdle2HTvfo/hpyb3RHhiyGJdX
 LyZC1+sCAvTEdGVCMUahBQmuoPPXL2LbtG3dYE3a3AQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10570;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=S8uXYzoY0/m42R5BMCcNDvtfUd9F8GUKvIduB+tGh50=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp9ghEvWWhuY9tqVLXhDuamT3jpHUCT3lUvVRIb
 7JfS0uP7eiJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafYIRAAKCRAzarMzb2Z/
 l3HQD/kBFn78Xr0tZyj5Ds83UBW6IDE/NpNh3EZWcpMwWddk8aPxeP/7LJd2viCy7QrHv81II2K
 ON90v44o5x8QSAGoWOV5PiZRVwnrIXUkVRff7XSAcgt5iT+Z6bvYvJJXhDgSmVb0I/ugIzrsiye
 Ia+GRzZwGc85Hosnv+4e8qso7+DodKzaYI1Aw03Mu1vLAw7mLkF+ASzXpdSdyAZvCLsOkGYwQoj
 0qU1/0h0yAKjMGzXEl0Ncr6pNNkbq3pm1dL62eS9VPxbVlzAg51rbHnXbcsqpjNQzoAk/ARSLQT
 JqFWVGVzI+PXhyeEt9tA9XRj14Ln5nFpNvYuG0cbUdRAkhy1fQ7aqEMRtVo1bOq8DcveAVCDjse
 9uaadeBmv4wBLugxr4puEMwf76bSnkQW5wg70d9N1yKPPIPKfQM9om0HJebAge+toz/hCHgxHw+
 BhgWyNeBMvmyI6eBIkRZ3L2DkPUkrOR5DfSgrnaxc5YMYSyI/JBUQXcEYtXIAHs+vEELMXTLb9l
 SUn1KnEQB2kBpplKSCDpox6FBHGXQQrwKGnY1knvJpDx+LrdlN5qzuQf/lIOrbNCc7J8Nc6LR11
 KD3BlY6LvU/dAZfQJbExgwfNqgFGF18i+CEZPO6tNqr0duGuJgOPchvjxjr3OHuz6nGNFRKDB1v
 F4gwq/WzrCu6hYQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 516BC4B24AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21346-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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
Changes since v12:
- Address findings from sashiko (gemini-3.1):
  - cifs: Restrict case-handling flags to directories per UAPI
  - nfs: Clear case caps before PATHCONF so a failed reply
    does not retain stale bits from the prior probe
  - nfsd: Document the parent-resolution corner cases of
    nfsd_get_case_info() (single-file exports, disconnected
    dentries, hardlinks) in the v3 and v4 commit messages

Changes since v11:
- isofs: Wire .fileattr_get only on directory inodes, since
  NFSD and ksmbd query casefolding on directories (Jan Kara)
- xfs, hfsplus: Drop the FS_CASEFOLD_FL fileattr_get mask;
  admit the bit through fileattr_set's allowlist instead
- Address findings from sashiko(gemini-3) and gpt-5.5:
  - cifs: Wire .fileattr_get on cifs_namespace_inode_operations
    so DFS referral / automount directories report case handling
  - fat, ntfs3: Fill FS_IMMUTABLE_FL in fileattr_get
  - hfsplus: Hide FS_CASEFOLD_FL from the legacy flags view so
    chattr round-trips do not hit the setflags whitelist
  - nfs: Clear NFS_CAP_CASE_INSENSITIVE and
    NFS_CAP_CASE_NONPRESERVING before re-OR'ing in the v3 and
    v4 probe paths so re-probe / TSM does not retain stale caps
  - nfsd: Switch nfsd_get_case_info() to errno return so
    v3 PATHCONF and v4 GETATTR can apply version-appropriate
    policy on failure
  - nfsd: Use dget_parent() in v4 case-attr probe to keep
    the parent dentry referenced across the query
  - isofs: Report FS_XFLAG_CASENONPRESERVING for map=n/map=a

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
 fs/exfat/file.c                | 18 +++++++++--
 fs/exfat/namei.c               |  1 +
 fs/fat/fat.h                   |  3 ++
 fs/fat/file.c                  | 36 +++++++++++++++++++++
 fs/fat/namei_msdos.c           |  1 +
 fs/fat/namei_vfat.c            |  1 +
 fs/file_attr.c                 | 16 +++++-----
 fs/hfs/dir.c                   |  1 +
 fs/hfs/hfs_fs.h                |  2 ++
 fs/hfs/inode.c                 | 14 ++++++++
 fs/hfsplus/inode.c             | 16 +++++++++-
 fs/isofs/dir.c                 | 16 ++++++++++
 fs/isofs/isofs.h               |  3 ++
 fs/nfs/client.c                | 21 ++++++++----
 fs/nfs/inode.c                 | 15 +++++++++
 fs/nfs/internal.h              |  3 ++
 fs/nfs/namespace.c             |  2 ++
 fs/nfs/nfs3proc.c              |  2 ++
 fs/nfs/nfs3xdr.c               |  7 ++--
 fs/nfs/nfs4proc.c              | 10 ++++--
 fs/nfs/proc.c                  |  3 ++
 fs/nfs/symlink.c               |  3 ++
 fs/nfsd/nfs3proc.c             | 36 ++++++++++++++++-----
 fs/nfsd/nfs4xdr.c              | 52 ++++++++++++++++++++++++++++--
 fs/nfsd/vfs.c                  | 72 ++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/vfs.h                  |  3 ++
 fs/nfsd/xdr3.h                 |  4 +--
 fs/ntfs3/file.c                | 29 +++++++++++++++++
 fs/ntfs3/inode.c               |  1 +
 fs/ntfs3/namei.c               |  2 ++
 fs/ntfs3/ntfs_fs.h             |  1 +
 fs/smb/client/cifsfs.c         | 53 +++++++++++++++++++++++++++++++
 fs/smb/client/cifsfs.h         |  3 ++
 fs/smb/client/namespace.c      |  1 +
 fs/smb/server/smb2pdu.c        | 30 ++++++++++++++----
 fs/vboxsf/dir.c                |  1 +
 fs/vboxsf/file.c               |  6 ++--
 fs/vboxsf/super.c              |  7 ++++
 fs/vboxsf/utils.c              | 30 ++++++++++++++++++
 fs/vboxsf/vfsmod.h             |  6 ++++
 fs/xfs/libxfs/xfs_inode_util.c |  2 ++
 fs/xfs/xfs_ioctl.c             | 22 ++++++++++---
 include/linux/fileattr.h       |  3 +-
 include/linux/nfs_fs_sb.h      |  2 +-
 include/linux/nfs_xdr.h        |  2 ++
 include/uapi/linux/fs.h        |  7 ++++
 47 files changed, 522 insertions(+), 49 deletions(-)
---
base-commit: 6596a02b207886e9e00bb0161c7fd59fea53c081
change-id: 20260422-case-sensitivity-5cbffc8f1558

Best regards,
--  
Chuck Lever <chuck.lever@oracle.com>


