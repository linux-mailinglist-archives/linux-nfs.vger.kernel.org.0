Return-Path: <linux-nfs+bounces-3585-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D77B4900678
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 16:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F10391C228C1
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 14:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC1C194C8B;
	Fri,  7 Jun 2024 14:26:51 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCF51667DE
	for <linux-nfs@vger.kernel.org>; Fri,  7 Jun 2024 14:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770411; cv=none; b=VuFN7Pj6YcWJXr56n3/RzVNs2CTOdpoJ3UukLyZUBdnXvIPqphV1DFzMbViFFWHkh0ODppDjqw3+dxWAe/kjMzv7lbN21W5gOUfBtP40Lg64yw14rA58nvPQ2gUCotoPUNQwRuiJ18S/8fCl8Rocd2+TUAkF1nF0b3QfoKr0ow4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770411; c=relaxed/simple;
	bh=NTx11NlMdfI7mnYzUrMl4CD9s2LdodddSjlsE3ZSXJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SDFKu5MTsukOVzCh5n+YwzFZYnwP1RR6w45/486ouyP+/o07r165sJT1oS5F2gMpGtc0cjOdTGSYFv3L0YlCrPvLx1Kn7yVXvo/YfqG547PBwIILwFNKLaIMli0racZyexBFZGnw2eoPUH72/KF1+GuL+YSxmQ6/YF+lHrOiS/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-43fdb114e07so9825791cf.2
        for <linux-nfs@vger.kernel.org>; Fri, 07 Jun 2024 07:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717770408; x=1718375208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fk0bjxB1K0XaYFZdKSiKQp4KFZ4ZYM3bWuR39VeewkA=;
        b=mAnRuztPbZbx0lz3yMjuoL4KxUDoODpxQFN827kkaDdGh5CVZCP+A9CZXZvZR6bcyS
         tuCuWkP5n3XXoltxK0nN827If3Xw1w7mNtJa3zyW6A+11cfwbUmJdAMXmTjNY+TlroaZ
         sAsJdH6/nSk88F2dU1D9YCDFJcP7ZQP8Me/aBiW5p+I+TbQ6phsXop00tCi25iEbnHIL
         yl8ATNZIyZh0boU9RrjGcrwdM9Z1Pm31E8scysHuuD2reCmdtUp7XvKdfEKlm3r83q6b
         N3rDc7Wk0UjSBQ1QS7MmTERbTStvE4o05c74QAondC9NASEi1ZXaH7keBNL6VvhsvBGS
         nkPg==
X-Gm-Message-State: AOJu0YyVUGCtWjc9JmM2KQ6hsd06AUNRFQecKEsP0Z6sc26VGy2qI9yz
	G2ZWUGTxzNbyzZN13YohMwdICT7aCYk10gJbx1NVHvZvAu7p329HDtf/IHYIIODJ/SKuwVLVQtr
	7M/ABcQ==
X-Google-Smtp-Source: AGHT+IF2e4f5RpRGaBUisaMXJ6yyVALHBkJ9BGhHUH+1ve2xKXCEIMCNo62gqFTrovMtEXBw49QI/w==
X-Received: by 2002:a05:622a:56:b0:43e:a91:e8d with SMTP id d75a77b69052e-44041cc2ef8mr28711751cf.54.1717770408270;
        Fri, 07 Jun 2024 07:26:48 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44038ac4bd1sm12762121cf.57.2024.06.07.07.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:26:47 -0700 (PDT)
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	snitzer@hammerspace.com
Subject: [for-6.11 PATCH 00/29] nfs/nfsd: add support for localio bypass
Date: Fri,  7 Jun 2024 10:26:17 -0400
Message-ID: <20240607142646.20924-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patch series rebases "localio" changes that Hammerspace (and
Primary Data before it) has been carrying since 2014. The reason they
weren't proposed for upstream inclusion until now was the handshake
for whether or not a client and server are local was brittle. Please
see the commit header of "nfs/localio: discontinue network address
based localio setup" (patch 20) for more context.

Aside from rebasing the original changes (patches 1 - 18) from a
5.15.-130-stable kernel, my contribution to this series was to make
the localio handshake more robust. To do so a new LOCALIO protocol
extension has been added to both NFS v3 and v4. It follows the
well-worn pattern established by the ACL protocol extension.

These changes have proven stable against various test scenarios:
1) client and server both on localhost (for both v3 and v4.2)
2) various permutations of client and server support enablement for
   both local and remote client and server.
3) client on host, server within a container (for both v3 and v4.2)

I've preserved all established author and Signed-off-by attribution
despite Andy, Peng and Jeff no longer working for Primary Data (or
Hammerspace). I've confirmed with Trond that its best to keep it all
despite those email addresses no longer being active. My Signed-off-by
and that of reviewers and maintainer(s) to follow will build on the
established development provenance.

I also made sure to preserve the original work done by others (rather
than fold changes that I add to this work, to avoid tainting the long
established development and sequence of changes).

My container testing was done in terms of podman managed containers.
I'd appreciate additional review relative to network namespaces.
fs/nfsd/localio.c:nfsd_local_fakerqst_create() in particular is simply
using the client's network namespace with rpc_net_ns(rpc_clnt). I have
an extra patch that updates nfsd_open_local_fh()'s first argument to
be the server's 'struct net' -- but I stopped short of formally
including that change in this series because it hasn't proven needed
(but more exotic hypothetical scenarios could easily expose the need
for it). I can append it to the series as an "RFC PATCH 30/29" as
needed.

All review and comments are welcome!

Thanks,
Mike

Mike Snitzer (11):
  nfs/write: fix nfs_initiate_commit to return error from nfs_local_commit
  nfs/localio: discontinue network address based localio setup
  nfs_common: add NFS v3 LOCALIO protocol extension enablement
  nfs: implement v3 client support for NFS_LOCALIO_PROGRAM
  nfsd: implement v3 server support for NFS_LOCALIO_PROGRAM
  nfs_common: add NFS v4 LOCALIO protocol extension enablement
  nfs: implement v4 client support for NFS_LOCALIO_PROGRAM
  nfsd: implement v4 server support for NFS_LOCALIO_PROGRAM
  nfs/nfsd: switch GETUUID to using {encode,decode}_opaque_fixed
  nfs/nfsd: consolidate {encode,decode}_opaque_fixed in nfs_xdr.h
  nfs/localio: move managing nfsd_open_local_fh symbol to nfs_common

Peng Tao (3):
  sunrpc: add and export rpc_ntop6_addr_noscopeid
  nfs: move nfs_stat_to_errno to nfs.h
  nfs/flexfiles: check local DS when making DS connections

Trond Myklebust (8):
  NFS: Manage boot verifier correctly in the case of localio
  NFS: Enable localio for non-pNFS I/O
  pnfs/flexfiles: Enable localio for flexfiles I/O
  NFS: Add tracepoints for nfs_local_enable and nfs_local_disable
  NFS: Don't call filesystem write() routines directly
  NFS: Don't call filesystem read() routines directly
  NFS: Use completion rather than flush_work() in nfs_local_commit()
  NFS: localio writes need to use a normal workqueue

Weston Andros Adamson (7):
  nfs: pass nfs_client to nfs_initiate_pgio
  nfs: pass nfs_client to nfs_initiate_commit
  nfs: pass descriptor thru nfs_initiate_pgio path
  sunrpc: handle NULL req->defer in cache_defer_req
  sunrpc: export svc_defer
  sunrpc: add rpcauth_map_to_svc_cred
  nfs/nfsd: add "local io" support

 fs/Kconfig                                |   3 +
 fs/nfs/Kconfig                            |  25 +
 fs/nfs/Makefile                           |   2 +
 fs/nfs/blocklayout/blocklayout.c          |   6 +-
 fs/nfs/client.c                           |  15 +-
 fs/nfs/filelayout/filelayout.c            |  19 +-
 fs/nfs/flexfilelayout/flexfilelayout.c    | 129 +++-
 fs/nfs/flexfilelayout/flexfilelayout.h    |   2 +
 fs/nfs/flexfilelayout/flexfilelayoutdev.c |   6 +
 fs/nfs/inode.c                            |  28 +-
 fs/nfs/internal.h                         | 101 ++-
 fs/nfs/localio.c                          | 814 ++++++++++++++++++++++
 fs/nfs/nfs2xdr.c                          |  69 --
 fs/nfs/nfs3_fs.h                          |   1 +
 fs/nfs/nfs3client.c                       |  25 +
 fs/nfs/nfs3proc.c                         |   3 +
 fs/nfs/nfs3xdr.c                          |  58 ++
 fs/nfs/nfs4_fs.h                          |   2 +
 fs/nfs/nfs4client.c                       |  23 +
 fs/nfs/nfs4proc.c                         |   3 +
 fs/nfs/nfs4xdr.c                          |  65 +-
 fs/nfs/nfstrace.h                         |  61 ++
 fs/nfs/pagelist.c                         |  35 +-
 fs/nfs/pnfs.c                             |  24 +-
 fs/nfs/pnfs.h                             |   6 +-
 fs/nfs/pnfs_nfs.c                         |   5 +-
 fs/nfs/write.c                            |  28 +-
 fs/nfs_common/Makefile                    |   3 +
 fs/nfs_common/nfslocalio.c                |  68 ++
 fs/nfsd/Kconfig                           |  25 +
 fs/nfsd/Makefile                          |   2 +
 fs/nfsd/filecache.c                       |   2 +-
 fs/nfsd/localio.c                         | 324 +++++++++
 fs/nfsd/netns.h                           |   4 +
 fs/nfsd/nfsd.h                            |  11 +
 fs/nfsd/nfssvc.c                          |  91 ++-
 fs/nfsd/trace.h                           |   3 +-
 fs/nfsd/vfs.h                             |   8 +
 fs/nfsd/xdr.h                             |   6 +
 include/linux/nfs.h                       |  65 ++
 include/linux/nfs_fs.h                    |   2 +
 include/linux/nfs_fs_sb.h                 |   8 +
 include/linux/nfs_xdr.h                   |  31 +-
 include/linux/nfslocalio.h                |  37 +
 include/linux/sunrpc/auth.h               |   4 +
 include/linux/sunrpc/svc_xprt.h           |   1 +
 include/uapi/linux/nfs.h                  |   4 +
 net/sunrpc/auth.c                         |  16 +
 net/sunrpc/cache.c                        |   2 +
 net/sunrpc/svc_xprt.c                     |   4 +-
 50 files changed, 2120 insertions(+), 159 deletions(-)
 create mode 100644 fs/nfs/localio.c
 create mode 100644 fs/nfs_common/nfslocalio.c
 create mode 100644 fs/nfsd/localio.c
 create mode 100644 include/linux/nfslocalio.h

-- 
2.44.0


