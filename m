Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 531614D0E1
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2019 16:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfFTOv1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jun 2019 10:51:27 -0400
Received: from fieldses.org ([173.255.197.46]:43432 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbfFTOvV (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 20 Jun 2019 10:51:21 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id E37291E19; Thu, 20 Jun 2019 10:51:20 -0400 (EDT)
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 00/16] exposing knfsd client state to userspace
Date:   Thu, 20 Jun 2019 10:50:59 -0400
Message-Id: <1561042275-12723-1-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

Changes since last time:
	- added display of client implementation ID
	- changed display of binary data to escape anything nonprintable
	  or nonascii
	- some minor cleanup and patch reshuffling

I'm happy enough with at this point and hoping to merge it for 5.3.

Recapping discussion from last time:

The following patches expose information about NFSv4 state held by knfsd
on behalf of NFSv4 clients.  This is especially important for opens,
which are currently invisible to userspace on the server, unlike locks
(/proc/locks) and local processes' opens (under /proc/<pid>/).

The approach is to add a new directory /proc/fs/nfsd/clients/ with
subdirectories for each active NFSv4 client.  Each subdirectory has an
"info" file with some basic information to help identify the client and
a "states" directory that lists the open state held by that client.

Currently these pseudofiles look like:

# find /proc/fs/nfsd/clients -type f|xargs tail
==> /proc/fs/nfsd/clients/3/ctl <==
tail: error reading '/proc/fs/nfsd/clients/3/ctl': Invalid argument

==> /proc/fs/nfsd/clients/3/states <==
- 0x01000000f58f0b5d2898a19801000000: { type: open, access: r-, deny: --, superblock: "fd:10:13649", owner: "open id:\x00\x00\x00&\x00\x00\x00\x00\x00\x00\x02x\xac\xd0 \x09" }
- 0x01000000f58f0b5d2898a19802000000: { type: deleg, access: r, superblock: "fd:10:13649" }
- 0x01000000f58f0b5d2898a19803000000: { type: open, access: r-, deny: --, superblock: "fd:10:13650", owner: "open id:\x00\x00\x00&\x00\x00\x00\x00\x00\x00\x02x\xac\xd0 \x09" }
- 0x01000000f58f0b5d2898a19804000000: { type: deleg, access: r, superblock: "fd:10:13650" }

==> /proc/fs/nfsd/clients/3/info <==
clientid: 0x98a198285d0b8ff5
address: "192.168.122.36:935"
name: "Linux NFSv4.2 test2.fieldses.org"
minor version: 2
Implementation domain: "kernel.org"
Implementation name: "Linux 5.2.0-rc1-00017-ge73cab140ec0 #2263 SMP PREEMPT Tue Jun 18 16:54:41 EDT 2019 x86_64"
Implementation time: [0, 0]

The "ctl" file is not readable; all you can do is write "expire\n" to it
to force the server to revoke all that client's state.

The "info" and "states" files are meant to be valid YAML.

Possibly also todo, though I think none have to be done before merging:
	- add some information about krb5 principals to the clients
	  file.
	- add information about the stateids used to represent
	  asynchronous copies.  They're a little different from the
	  other stateids and might end up in a separate "copies" file,
	- this duplicates some functionality of the little-used fault
	  injection code; could we replace it entirely?
	- some of the bits of filesystem code could probably be shared
	  with rpc_pipefs and libfs.

--b.

J. Bruce Fields (16):
  nfsd: persist nfsd filesystem across mounts
  nfsd: rename cl_refcount
  nfsd4: use reference count to free client
  nfsd: add nfsd/clients directory
  nfsd: make client/ directory names small ints
  nfsd4: add a client info file
  nfsd: copy client's address including port number to cl_addr
  nfsd: escape high characters in binary data
  nfsd: add more information to client info file
  nfsd4: add file to display list of client's opens
  nfsd: show lock and deleg stateids
  nfsd4: show layout stateids
  nfsd: create get_nfsdfs_clp helper
  nfsd: allow forced expiration of NFSv4 clients
  nfsd: create xdr_netobj_dup helper
  nfsd: decode implementation id

 fs/nfsd/netns.h                |   6 +
 fs/nfsd/nfs4state.c            | 453 ++++++++++++++++++++++++++++++---
 fs/nfsd/nfs4xdr.c              |  21 +-
 fs/nfsd/nfsctl.c               | 221 +++++++++++++++-
 fs/nfsd/nfsd.h                 |  11 +
 fs/nfsd/state.h                |  11 +-
 fs/nfsd/xdr4.h                 |   3 +
 fs/seq_file.c                  |  11 +
 include/linux/seq_file.h       |   1 +
 include/linux/string_helpers.h |   3 +
 include/linux/sunrpc/xdr.h     |   7 +
 lib/string_helpers.c           |  19 ++
 12 files changed, 723 insertions(+), 44 deletions(-)

-- 
2.21.0

