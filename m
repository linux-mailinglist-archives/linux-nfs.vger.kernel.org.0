Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6454A154EF2
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Feb 2020 23:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgBFWcK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Feb 2020 17:32:10 -0500
Received: from mail-il1-f172.google.com ([209.85.166.172]:38703 "EHLO
        mail-il1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgBFWcK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Feb 2020 17:32:10 -0500
Received: by mail-il1-f172.google.com with SMTP id f5so73246ilq.5;
        Thu, 06 Feb 2020 14:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:message-id:subject:from:to:cc:mime-version:date:user-agent
         :content-transfer-encoding;
        bh=7/Bes3cNLricskFz3U4XIFBnsvX6Y4giyFoJ+2MLEl4=;
        b=txaA0eVKTJ4u1/q5ac5IeqCgAw7iDg7J+iKTAGUJ+DbpFHipV2QDYvk45NsbcgTzWe
         3HCquQPM+LCuU4fKY5A50RWGtabOxk706MHwKa5uW+ux0I32FJimeBza4caTS973ctaF
         1N3w2rqqB3c+Kid/oNk7a2QjxbkWXvLno6OiyNBd3h5fGtUCJZyetGaO9+98HkVmgnbt
         ivSRRBr/beH+tr2Dg2BzJawPenR7MEVqH3WCyHqwWQ4BIwoMVFjFHgtsg2n5EB/VBDHF
         XQX40psldoU1PfSAM4qxQuokIMC9wrBMmALmcd0bnFGXb3VvskwvAdusNKgJ9FGqoli+
         qXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:message-id:subject:from:to:cc
         :mime-version:date:user-agent:content-transfer-encoding;
        bh=7/Bes3cNLricskFz3U4XIFBnsvX6Y4giyFoJ+2MLEl4=;
        b=OEBes/UBzvycvAxplg/sG6yArXa+7GWIqJKCs9nBfIVsyrwUsmOtubPZ1q9ACnbUh4
         d5w5DWauPCAkqd4Teyn7qQLKM4TpV22A2HpQb6DUqSozCz8QC/NxNlkfSQpG99Y/52Xu
         0ngRio0Q6MFZ04rHzuvU2802DYoJ9wpQsXiKz2DXc+DcMfogQ1/bovzZFJLi+2IulBql
         y02Gogv8RNDdLBeDgJGqH4lsz1zHNOJlulzZanIzeVq1WIVYhMbRt0pLHn/+XfUqggcJ
         699Ulft189gYv3uxUzKl6L67RUKwK0p7a9J3OQgtRtTU6cw3pgMrCqY7hgRtLMDwEinp
         mEUQ==
X-Gm-Message-State: APjAAAVf/IhIbh+WalBOzUr/RDZZJ2BsaSILdjSJKUd7D9NUxUySlsu3
        C/FC8r2Xhfye/x1aO1Gb3nGEydv9
X-Google-Smtp-Source: APXvYqwxWFbGcB0yvpWUrB3Z5mLGf6wsHrn/xhdIZzEaz6Pmi4/Mk5r1403nZ+tmKX4C6oU+2u6jBQ==
X-Received: by 2002:a92:990d:: with SMTP id p13mr6063659ili.129.1581028329085;
        Thu, 06 Feb 2020 14:32:09 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.googlemail.com with ESMTPSA id e23sm433303ild.37.2020.02.06.14.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 14:32:08 -0800 (PST)
Message-ID: <6a5ac820658697e7460006ddf08d10caeb7b33dd.camel@netapp.com>
Subject: [GIT PULL] Please pull NFS client updates for Linux 5.6
From:   Anna Schumaker <anna.schumaker@netapp.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Thu, 06 Feb 2020 17:31:18 -0500
User-Agent: Evolution 3.34.3 
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus,

The following changes since commit 95e20af9fb9ce572129b930967dcb762a318c588:

  Merge tag 'nfs-for-5.5-2' of git://git.linux-nfs.org/projects/anna/linux-nfs
(2020-01-14 13:33:14 -0800)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-5.6-1

for you to fetch changes up to 7dc2993a9e51dd2eee955944efec65bef90265b7:

  NFSv4.0: nfs4_do_fsinfo() should not do implicit lease renewals (2020-02-04
12:27:55 -0500)

----------------------------------------------------------------
Stable bugfixes:
- Fix memory leaks and corruption in readdir # v2.6.37+
- Directory page cache needs to be locked when read # v2.6.37+

New features:
- Convert NFS to use the new mount API
- Add "softreval" mount option to let clients use cache if server goes down
- Add a config option to compile without UDP support
- Limit the number of inactive delegations the client can cache at once
- Improved readdir concurrency using iterate_shared()

Other bugfixes and cleanups:
- More 64-bit time conversions
- Add additional diagnostic tracepoints
- Check for holes in swapfiles, and add dependency on CONFIG_SWAP
- Various xprtrdma cleanups to prepare for 5.7's changes
- Several fixes for NFS writeback and commit handling
- Fix acls over krb5i/krb5p mounts
- Recover from premature loss of openstateids
- Fix NFS v3 chacl and chmod bug
- Compare creds using cred_fscmp()
- Use kmemdup_nul() in more places
- Optimize readdir cache page invalidation
- Lease renewal and recovery fixes

Thanks,
Anna

----------------------------------------------------------------
Al Viro (15):
      saner calling conventions for nfs_fs_mount_common()
      nfs: stash server into struct nfs_mount_info
      nfs: lift setting mount_info from nfs4_remote{,_referral}_mount
      nfs: fold nfs4_remote_fs_type and nfs4_remote_referral_fs_type
      nfs: don't bother setting/restoring export_path around do_nfs_root_mount()
      nfs4: fold nfs_do_root_mount/nfs_follow_remote_path
      nfs: lift setting mount_info from nfs_xdev_mount()
      nfs: stash nfs_subversion reference into nfs_mount_info
      nfs: don't bother passing nfs_subversion to ->try_mount() and
nfs_fs_mount_common()
      nfs: merge xdev and remote file_system_type
      nfs: unexport nfs_fs_mount_common()
      nfs: don't pass nfs_subversion to ->create_server()
      nfs: get rid of mount_info ->fill_super()
      nfs_clone_sb_security(): simplify the check for server bogosity
      nfs: get rid of ->set_security()

Alex Shi (1):
      NFS: remove unused macros

Arnd Bergmann (5):
      sunrpc: convert to time64_t for expiry
      nfs: use timespec64 in nfs_fattr
      nfs: fscache: use timespec64 in inode auxdata
      nfs: remove timespec from xdr_encode_nfstime
      nfs: encode nfsv4 timestamps as 64-bit

Chuck Lever (13):
      SUNRPC: Capture signalled RPC tasks
      NFS: Introduce trace events triggered by page writeback errors
      NFS4: Report callback authentication errors
      SUNRPC: call_connect_status should handle -EPROTO
      xprtrdma: Eliminate ri_max_send_sges
      xprtrdma: Make sendctx queue lifetime the same as connection lifetime
      xprtrdma: Refactor initialization of ep->rep_max_requests
      xprtrdma: Eliminate per-transport "max pages"
      xprtrdma: Refactor frwr_is_supported
      xprtrdma: Allocate and map transport header buffers at connect time
      xprtrdma: Destroy rpcrdma_rep when Receive is flushed
      xprtrdma: Destroy reps from previous connection instance
      xprtrdma: DMA map rr_rdma_buf as each rpcrdma_rep is created

Colin Ian King (1):
      NFS: Add missing null check for failed allocation

Dai Ngo (1):
      nfs: optimise readdir cache page invalidation

David Howells (9):
      NFS: Move mount parameterisation bits into their own file
      NFS: Constify mount argument match tables
      NFS: Rename struct nfs_parsed_mount_data to struct nfs_fs_context
      NFS: Split nfs_parse_mount_options()
      NFS: Deindent nfs_fs_context_parse_option()
      NFS: Add a small buffer in nfs_fs_context to avoid string dup
      NFS: Do some tidying of the parsing code
      NFS: Add fs_context support.
      nfs: Return EINVAL rather than ERANGE for mount parse errors

Geert Uytterhoeven (1):
      nfs: NFS_SWAP should depend on SWAP

Julia Lawall (1):
      SUNRPC: constify copied structure

Murphy Zhou (1):
      fs/nfs, swapon: check holes in swapfile

Olga Kornievskaia (3):
      NFSv4 fix acl retrieval over krb5i/krb5p mounts
      NFSv4.x recover from pre-mature loss of openstateid
      NFS: allow deprecation of NFS UDP protocol

Robert Milkowski (2):
      NFSv4: try lease recovery on NFS4ERR_EXPIRED
      NFSv4.0: nfs4_do_fsinfo() should not do implicit lease renewals

Scott Mayhew (4):
      NFS: rename nfs_fs_context pointer arg in a few functions
      NFS: Convert mount option parsing to use functionality from fs_parser.h
      NFS: Additional refactoring for fs_context conversion
      NFS: Attach supplementary error information to fs_context.

Su Yanjun (1):
      NFSv3: FIx bug when using chacl and chmod to change acl

Trond Myklebust (32):
      NFS: Revalidate the file size on a fatal write error
      NFS: Revalidate the file mapping on all fatal writeback errors
      SUNRPC: Remove broken gss_mech_list_pseudoflavors()
      NFS: Fix up fsync() when the server rebooted
      NFS/pnfs: Fix pnfs_generic_prepare_to_resend_writes()
      NFSv4: Improve read/write/commit tracing
      NFS: Fix fix of show_nfs_errors
      pNFS/flexfiles: Record resend attempts on I/O failure
      NFS: Clean up generic file read tracepoints
      NFS: Clean up generic writeback tracepoints
      NFS: Clean up generic file commit tracepoint
      pNFS/flexfiles: Add tracing for layout errors
      NFS: Improve tracing of permission calls
      NFS: When resending after a short write, reset the reply count to zero
      NFS: Fix nfs_direct_write_reschedule_io()
      NFS: Trust cached access if we've already revalidated the inode once
      NFS: Add mount option 'softreval'
      NFS: Add softreval behaviour to nfs_lookup_revalidate()
      NFSv4: pnfs_roc() must use cred_fscmp() to compare creds
      NFS: nfs_access_get_cached_rcu() should use cred_fscmp()
      NFS: nfs_find_open_context() should use cred_fscmp()
      NFSv4: nfs_inode_evict_delegation() should set NFS_DELEGATION_RETURNING
      NFS: Clear NFS_DELEGATION_RETURN_IF_CLOSED when the delegation is returned
      NFSv4: Try to return the delegation immediately when marked for return on
close
      NFSv4: Add accounting for the number of active delegations held
      NFSv4: Limit the total number of cached delegations
      NFS: Replace various occurrences of kstrndup() with kmemdup_nul()
      SUNRPC: Use kmemdup_nul() in rpc_parse_scope_id()
      NFS: Fix memory leaks and corruption in readdir
      NFS: Directory page cache pages need to be locked when read
      NFS: Use kmemdup_nul() in nfs_readdir_make_qstr()
      NFS: Switch readdir to using iterate_shared()

Wenwen Wang (1):
      NFS: Fix memory leaks

zhengbin (2):
      NFS4: Remove unneeded semicolon
      NFS: move dprintk after nfs_alloc_fattr in nfs3_proc_lookup

 fs/nfs/Kconfig                         |   11 +-
 fs/nfs/Makefile                        |    2 +-
 fs/nfs/callback_xdr.c                  |   11 +-
 fs/nfs/client.c                        |   84 ++--
 fs/nfs/delegation.c                    |   80 +++-
 fs/nfs/delegation.h                    |    1 +
 fs/nfs/dir.c                           |   83 ++--
 fs/nfs/direct.c                        |    7 +-
 fs/nfs/dns_resolve.c                   |    2 +-
 fs/nfs/file.c                          |   49 ++-
 fs/nfs/flexfilelayout/flexfilelayout.c |   34 +-
 fs/nfs/fs_context.c                    | 1437
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfs/fscache-index.c                 |    6 +-
 fs/nfs/fscache.c                       |   20 +-
 fs/nfs/fscache.h                       |    8 +-
 fs/nfs/getroot.c                       |   73 +--
 fs/nfs/inode.c                         |   10 +-
 fs/nfs/internal.h                      |  143 +++---
 fs/nfs/mount_clnt.c                    |    2 -
 fs/nfs/namespace.c                     |  146 +++---
 fs/nfs/nfs2xdr.c                       |   12 +-
 fs/nfs/nfs3_fs.h                       |    2 +-
 fs/nfs/nfs3client.c                    |    6 +-
 fs/nfs/nfs3proc.c                      |   28 +-
 fs/nfs/nfs3xdr.c                       |    5 +-
 fs/nfs/nfs42proc.c                     |   40 +-
 fs/nfs/nfs4_fs.h                       |   19 +-
 fs/nfs/nfs4client.c                    |   99 ++---
 fs/nfs/nfs4file.c                      |    1 +
 fs/nfs/nfs4namespace.c                 |  298 +++++++------
 fs/nfs/nfs4proc.c                      |  104 +++--
 fs/nfs/nfs4renewd.c                    |    5 +-
 fs/nfs/nfs4state.c                     |    7 +-
 fs/nfs/nfs4super.c                     |  257 ++++-------
 fs/nfs/nfs4trace.c                     |    4 +
 fs/nfs/nfs4trace.h                     |  237 ++++++++--
 fs/nfs/nfs4xdr.c                       |   17 +-
 fs/nfs/nfstrace.h                      |  279 +++++++++---
 fs/nfs/pnfs.c                          |    4 +-
 fs/nfs/pnfs.h                          |    8 +-
 fs/nfs/pnfs_nfs.c                      |    7 +-
 fs/nfs/proc.c                          |   24 +-
 fs/nfs/read.c                          |    7 +-
 fs/nfs/super.c                         | 2218 ++++++++++++---------------------
-----------------------------------------------------------
 fs/nfs/write.c                         |   32 +-
 include/linux/nfs_fs.h                 |    3 +
 include/linux/nfs_fs_sb.h              |    1 +
 include/linux/nfs_xdr.h                |   11 +-
 include/linux/sunrpc/auth.h            |    2 -
 include/linux/sunrpc/gss_api.h         |    7 +-
 include/linux/sunrpc/gss_krb5.h        |    2 +-
 include/trace/events/rpcrdma.h         |   12 +-
 include/trace/events/sunrpc.h          |    1 +
 net/sunrpc/addr.c                      |    2 +-
 net/sunrpc/auth.c                      |   49 ---
 net/sunrpc/auth_gss/auth_gss.c         |    1 -
 net/sunrpc/auth_gss/gss_krb5_mech.c    |   12 +-
 net/sunrpc/auth_gss/gss_krb5_seal.c    |    8 +-
 net/sunrpc/auth_gss/gss_krb5_unseal.c  |    6 +-
 net/sunrpc/auth_gss/gss_krb5_wrap.c    |   16 +-
 net/sunrpc/auth_gss/gss_mech_switch.c  |   31 +-
 net/sunrpc/auth_gss/svcauth_gss.c      |    4 +-
 net/sunrpc/clnt.c                      |    1 +
 net/sunrpc/sched.c                     |    4 +-
 net/sunrpc/xdr.c                       |    2 +-
 net/sunrpc/xprtrdma/backchannel.c      |    4 +
 net/sunrpc/xprtrdma/frwr_ops.c         |  104 ++---
 net/sunrpc/xprtrdma/rpc_rdma.c         |   20 +-
 net/sunrpc/xprtrdma/transport.c        |   17 +-
 net/sunrpc/xprtrdma/verbs.c            |  213 +++++----
 net/sunrpc/xprtrdma/xprt_rdma.h        |   14 +-
 71 files changed, 3404 insertions(+), 3072 deletions(-)
 create mode 100644 fs/nfs/fs_context.c

