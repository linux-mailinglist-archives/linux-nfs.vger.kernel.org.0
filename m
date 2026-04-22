Return-Path: <linux-nfs+bounces-20998-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLvYNBla6WndXwIAu9opvQ
	(envelope-from <linux-nfs+bounces-20998-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 01:30:33 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C56A44B8E2
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 01:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 691FB3038F61
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Apr 2026 23:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960E2390CBD;
	Wed, 22 Apr 2026 23:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6+HGFyh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA14346AE3;
	Wed, 22 Apr 2026 23:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776900617; cv=none; b=hrBvZSaVQUbgx8aBN2giyXYPL8WdmBnZ4+2uScJWAzmI8Osv/uPdDzMaEt2puldP+QGlB8IM+ka7GW+Pl8iGq34DqZQqs/FlZ3SLbiIK5LdN39Ob9kPgG7Slj8ZjKOnN+ipn5r5iiy/znyvU21Q6boRMtUQ86JIQ7cQ2BIFJXlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776900617; c=relaxed/simple;
	bh=nSWvRvVLvvSZdli9CnC8hr1bXPfPcgp+ZC3UK68WE7E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Nd2gWYMS3GKNOZNUOl9ebDaSBuumZjML2ooQB7aGDUNytmyWUQuIXP+W3sFTGqMkkqivVe5iaVLSSy7DqRA6/GQCyGx13KIYW8uoOuhOapVTn9s0fwBhDkmMXDt+7vYoPcgdax0Qrc1D25SLd2EUO7mnE+iJRPOVS4JS8CHKwAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6+HGFyh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1496C19425;
	Wed, 22 Apr 2026 23:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776900617;
	bh=nSWvRvVLvvSZdli9CnC8hr1bXPfPcgp+ZC3UK68WE7E=;
	h=From:Subject:Date:To:Cc:From;
	b=N6+HGFyhQd9DvW78jZtWY1QbnbgcQhKYbdv/Pr4g7qkRM9M1dt3zSDjvsq8+Cj6Pq
	 /fYZRkpRRSxhtTiitiM6p0xyWllr8bgvYNLbg2S1HyHzztErbjiK8wJC9x+QtQWJzG
	 jbGrbNjAcP3LB5fQiQVh5B9pu1AHdqSUOw6cmWYPtwbfHS9q0GIH7T812IUuRi0Fh8
	 +Trv4GBlAhj7ISIQGWim7FoG76jC1fYOG+Eiv9DUQyKg4lsQ+KLXMaKOI6ovh2t4gS
	 vJODnaQhSbNkc3kC5p1owoayosmQoqWLeTZOFy3SKWxoOY5peKpHkibCTXvOefNHFs
	 1hO1Xuq4ZpY4g==
From: Chuck Lever <cel@kernel.org>
Subject: [PATCH v9 00/17] Exposing case folding behavior
Date: Wed, 22 Apr 2026 19:29:54 -0400
Message-Id: <20260422-case-sensitivity-v9-0-be023cc070e2@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPJZ6WkC/yWMQQ7CMAwEv1L5TEqJKBS+gjgkrk2NUIriEIGq/
 p0EDnuY1e4soBSFFM7NApGyqMyhwGnTAE4u3MjIWBhsZw/d3lqDTskoBZUkWdLH9OiZceBd3w9
 Qbs9ILO+f8nL9s778nTBVT134qvDRBZxqlVm3JebY2rbaeX6MsK5f7o3QmpsAAAA=
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
 Chuck Lever <chuck.lever@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6855;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=nSWvRvVLvvSZdli9CnC8hr1bXPfPcgp+ZC3UK68WE7E=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp6Vn9Kt1tzr2kFvP0Kdpok68GcrcKfLlwgFtsM
 oazIO8Ul9SJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaelZ/QAKCRAzarMzb2Z/
 l9QQD/0cnxc2xWUgbGlmzr0CatU2yPuq86+5240DgMd1JmcaJt9CAna3J70eXcj3QgfuPQKTKRV
 6Wj4NTvZq48eV9gFyX4EIbWUzlkuQdgMaxxQZeq/avJeilSwdxJqsg/CQx6VEevXvlW2bCEiWpy
 GK4Scn4yMuj5Wu04CyGzjvh8ySvjSmjJjCwzeSiT4rI5hUIFNmVXu7ywVgMmVemz7TVVXZjErFP
 +xFdr4I9IcMOJVA6scAtzMnFO7vFs40YtiVPkSfCQYle/w3k0FKqpGEMVueH75kl/Jaaxn8wkzv
 W1lY/B9IqCTW4NdG6Qd4ZaaCr+wnHwNxgzuYXfBqRWt/uYrCs1SH554zHYsStczLnFEAEg0y2P7
 Ck6/isIXfTB5tYlVfBL44MRKfNDDhtyZoqfzhgqnqzBtNNIk+GZouAD4qqjWYlWCoTNC242b9IN
 713gzqezLN8ax2i1d1cUKZCcXz2e6V4a6Th1VxD1u15I918Ba0wQXowjwKf/CmCj0e5A2VmqP+N
 k75pCnONxAWYNGk545R71I+qwLpexoxkyKhnn+u3VQlVk1djoK6aQ8xA+K9njqvvUb4drZVPULh
 w9BWIIwK9SgO06IGf9WwP4tf/SXkjGH1YnzYzcmMfWlONfvUoalk1OQnGZd1hBhwVs79ZFG+6YD
 WNaMOCAe6Hb566Q==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20998-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com];
	RCPT_COUNT_TWELVE(0.00)[33];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6C56A44B8E2
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

 fs/exfat/exfat_fs.h      |  2 ++
 fs/exfat/file.c          | 17 +++++++++++++++--
 fs/exfat/namei.c         |  1 +
 fs/ext4/ioctl.c          |  7 +++++++
 fs/f2fs/file.c           |  8 ++++++++
 fs/fat/fat.h             |  3 +++
 fs/fat/file.c            | 23 +++++++++++++++++++++++
 fs/fat/namei_msdos.c     |  1 +
 fs/fat/namei_vfat.c      |  1 +
 fs/file_attr.c           | 16 ++++++++--------
 fs/hfs/dir.c             |  1 +
 fs/hfs/hfs_fs.h          |  2 ++
 fs/hfs/inode.c           | 13 +++++++++++++
 fs/hfsplus/inode.c       | 10 ++++++++++
 fs/isofs/dir.c           | 11 +++++++++++
 fs/nfs/client.c          |  9 +++++++--
 fs/nfs/inode.c           | 21 +++++++++++++++++++++
 fs/nfs/internal.h        |  3 +++
 fs/nfs/nfs3proc.c        |  2 ++
 fs/nfs/nfs3xdr.c         |  7 +++++--
 fs/nfs/nfs4proc.c        |  2 ++
 fs/nfs/proc.c            |  3 +++
 fs/nfs/symlink.c         |  3 +++
 fs/nfsd/nfs3proc.c       | 18 ++++++++++--------
 fs/nfsd/nfs4xdr.c        | 25 +++++++++++++++++++++++--
 fs/nfsd/vfs.c            | 29 +++++++++++++++++++++++++++++
 fs/nfsd/vfs.h            |  3 +++
 fs/ntfs3/file.c          | 23 +++++++++++++++++++++++
 fs/ntfs3/inode.c         |  1 +
 fs/ntfs3/namei.c         |  2 ++
 fs/ntfs3/ntfs_fs.h       |  1 +
 fs/smb/client/cifsfs.c   | 20 ++++++++++++++++++++
 fs/smb/server/smb2pdu.c  | 25 +++++++++++++++++++------
 fs/vboxsf/dir.c          |  1 +
 fs/vboxsf/file.c         |  6 ++++--
 fs/vboxsf/super.c        |  7 +++++++
 fs/vboxsf/utils.c        | 26 ++++++++++++++++++++++++++
 fs/vboxsf/vfsmod.h       |  6 ++++++
 fs/xfs/xfs_ioctl.c       |  9 ++++++++-
 include/linux/fileattr.h |  3 ++-
 include/linux/nfs_xdr.h  |  2 ++
 include/uapi/linux/fs.h  |  7 +++++++
 42 files changed, 346 insertions(+), 34 deletions(-)
---
base-commit: 6596a02b207886e9e00bb0161c7fd59fea53c081
change-id: 20260422-case-sensitivity-5cbffc8f1558

Best regards,
--  
Chuck Lever


