Return-Path: <linux-nfs+bounces-4435-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A010891D2C6
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jun 2024 18:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5562B20D4D
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jun 2024 16:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DAE156C78;
	Sun, 30 Jun 2024 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQM/7SOR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35AB156C6B
	for <linux-nfs@vger.kernel.org>; Sun, 30 Jun 2024 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719765488; cv=none; b=tnazV7ffKRjTNd3xx+WW+dVnhnPgV/pPjhwHisBQDqf9TacQhTWvsflMQEEdCWaZEhV2Up1V+NBctFAquiVW02+hZvLFks0S3g7crIu+6MW0PJ6nOwlKDxjaOLpcXo73ATRLKt30/hB7Tug+/vsJ/6PddBjQSc+m4YM5erecdUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719765488; c=relaxed/simple;
	bh=PU2nee8OcfY5Z/64ErWPeMTpfFeJoI3nn5+2iaEfEc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKjoz/8icYujfkZgwEY7uJtPkThLIZheH4LmQkfh4DyZxXz5uLTi7ZXx/8R57eNRGGM8JLmVOsT6tw4HBUeF+6G3UtUzRoWaROxLmo/VWG1qC3mqmKGACAqj9SNyakaHkdpv+nz/2ypzHoOScMI4IQCTNBZ1XM3tePjE+51UGHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQM/7SOR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E5AC32786;
	Sun, 30 Jun 2024 16:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719765488;
	bh=PU2nee8OcfY5Z/64ErWPeMTpfFeJoI3nn5+2iaEfEc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iQM/7SOROGUHaI0865zvpcZIKfmkV5LGAd5D7qV5aRhRCCfiVgJoo2y9/H8zHdi2I
	 qgpiZ3lAnc8OZVT13FTJi0xG4ZFFliOHYAyW9ic2u8TGN/25aoV6lOKbEvQr7BkBDX
	 EHRvSukC8+U/aAI3tlC67CB1K8kBv8vj0yvpuqNQZpc6AFX40sVdevChtEl7JZJPi5
	 miD+jP5vy3DP+AvvMGPKq3TNQR3SAbWiBz6MqlhYPBMDTaqxrdJLZpD/U0bZnAfOiV
	 8mbORCoQCNDP/37YnVeGRrieBjfeAlCVeVWcX7xSMO9OdC+E/iJtijs4P9ytxKsUTv
	 RXPEclboYqhUQ==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v10 19/19] nfs: add Documentation/filesystems/nfs/localio.rst
Date: Sun, 30 Jun 2024 12:37:41 -0400
Message-ID: <20240630163741.48753-20-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240630163741.48753-1-snitzer@kernel.org>
References: <20240630163741.48753-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This document gives an overview of the LOCALIO auxiliary RPC protocol
added to the Linux NFS client and server (both v3 and v4) to allow a
client and server to reliably handshake to determine if they are on the
same host.  The LOCALIO auxiliary protocol's implementation, which uses
the same connection as NFS traffic, follows the pattern established by
the NFS ACL protocol extension.

The robust handshake between local client and server is just the
beginning, the ultimate usecase this locality makes possible is the
client is able to issue reads, writes and commits directly to the server
without having to go over the network.  This is particularly useful for
container usecases (e.g. kubernetes) where it is possible to run an IO
job local to the server.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 Documentation/filesystems/nfs/localio.rst | 135 ++++++++++++++++++++++
 include/linux/nfslocalio.h                |   2 +
 2 files changed, 137 insertions(+)
 create mode 100644 Documentation/filesystems/nfs/localio.rst

diff --git a/Documentation/filesystems/nfs/localio.rst b/Documentation/filesystems/nfs/localio.rst
new file mode 100644
index 000000000000..7f211e3fc34c
--- /dev/null
+++ b/Documentation/filesystems/nfs/localio.rst
@@ -0,0 +1,135 @@
+===========
+NFS localio
+===========
+
+This document gives an overview of the LOCALIO auxiliary RPC protocol
+added to the Linux NFS client and server (both v3 and v4) to allow a
+client and server to reliably handshake to determine if they are on the
+same host.  The LOCALIO auxiliary protocol's implementation, which uses
+the same connection as NFS traffic, follows the pattern established by
+the NFS ACL protocol extension.
+
+The LOCALIO auxiliary protocol is needed to allow robust discovery of
+clients local to their servers.  In a private implementation that
+preceded use of this LOCALIO protocol, a fragile sockaddr network
+address based match against all local network interfaces was attempted.
+But unlike the LOCALIO protocol, the sockaddr-based matching didn't
+handle use of iptables or containers.
+
+The robust handshake between local client and server is just the
+beginning, the ultimate usecase this locality makes possible is the
+client is able to issue reads, writes and commits directly to the server
+without having to go over the network.  This is particularly useful for
+container usecases (e.g. kubernetes) where it is possible to run an IO
+job local to the server.
+
+The performance advantage realized from localio's ability to bypass
+using XDR and RPC for reads, writes and commits can be extreme, e.g.:
+fio for 20 secs with 24 libaio threads, 64k directio reads, qd of 8,
+-  With localio:
+  read: IOPS=691k, BW=42.2GiB/s (45.3GB/s)(843GiB/20002msec)
+-  Without localio:
+  read: IOPS=15.7k, BW=984MiB/s (1032MB/s)(19.2GiB/20013msec)
+
+RPC
+---
+
+The LOCALIO auxiliary RPC protocol consists of a single "GETUUID" RPC
+method that allows the Linux NFS client to retrieve a Linux NFS server's
+uuid.  This protocol isn't part of an IETF standard, nor does it need to
+be considering it is Linux-to-Linux auxiliary RPC protocol that amounts
+to an implementation detail.
+
+The GETUUID method encodes the server's uuid_t in terms of the fixed
+UUID_SIZE (16 bytes).  The fixed size opaque encode and decode XDR
+methods are used instead of the less efficient variable sized methods.
+
+The RPC program number for the NFS_LOCALIO_PROGRAM is 400122 (as assigned
+by IANA, see https://www.iana.org/assignments/rpc-program-numbers/ ):
+Linux Kernel Organization       400122  nfslocalio
+
+The LOCALIO protocol spec in rpcgen syntax is:
+
+/* raw RFC 9562 UUID */
+#define UUID_SIZE 16
+typedef u8 uuid_t<UUID_SIZE>;
+
+program NFS_LOCALIO_PROGRAM {
+    version LOCALIO_V1 {
+        void
+            NULL(void) = 0;
+
+        uuid_t
+            GETUUID(void) = 1;
+    } = 1;
+} = 400122;
+
+LOCALIO uses the same transport connection as NFS traffic.  As such,
+LOCALIO is not registered with rpcbind.
+
+Once an NFS client and server handshake as "local", the client will
+bypass the network RPC protocol for read, write and commit operations.
+Due to this XDR and RPC bypass, these operations will operate faster.
+
+NFS Common and Server
+---------------------
+
+Localio is used by nfsd to add access to a global nfsd_uuids list in
+nfs_common that is used to register and then identify local nfsd
+instances.
+
+nfsd_uuids is protected by the nfsd_mutex or RCU read lock and is
+composed of nfsd_uuid_t instances that are managed as nfsd creates them
+(per network namespace).
+
+nfsd_uuid_is_local() and nfsd_uuid_lookup() are used to search all local
+nfsd for the client specified nfsd uuid.
+
+The nfsd_uuids list is the basis for localio enablement, as such it has
+members that point to nfsd memory for direct use by the client
+(e.g. 'net' is the server's network namespace, through it the client can
+access nn->nfsd_serv with proper rcu read access).  It is this client
+and server synchronization that enables advanced usage and lifetime of
+objects to span from the host kernel's nfsd to per-container knfsd
+instances that are connected to nfs client's running on the same local
+host.
+
+NFS Client
+----------
+
+fs/nfs/localio.c:nfs_local_probe() will retrieve a server's uuid via
+LOCALIO protocol and check if the server with that uuid is known to be
+local.  This ensures client and server 1: support localio 2: are local
+to each other.
+
+See fs/nfs/localio.c:nfs_local_open_fh() and
+fs/nfsd/localio.c:nfsd_open_local_fh() for the interface that makes
+focused use of nfsd_uuid_t struct to allow a client local to a server to
+open a file pointer without needing to go over the network.
+
+The client's fs/nfs/localio.c:nfs_local_open_fh() will call into the
+server's fs/nfsd/localio.c:nfsd_open_local_fh() and carefully access
+both the nfsd network namespace and the associated nn->nfsd_serv in
+terms of RCU.  If nfsd_open_local_fh() finds that client no longer sees
+valid nfsd objects (be it struct net or nn->nfsd_serv) it returns ENXIO
+to nfs_local_open_fh() and the client will try to reestablish the
+LOCALIO resources needed by calling nfs_local_probe() again.  This
+recovery is needed if/when an nfsd instance running in a container were
+to reboot while a localio client is connected to it.
+
+Testing
+-------
+
+The LOCALIO auxiliary protocol and associated NFS localio read, write
+and commit access have proven stable against various test scenarios but
+these have not yet been formalized in any testsuite:
+
+-  Client and server both on localhost (for both v3 and v4.2).
+
+-  Various permutations of client and server support enablement for
+   both local and remote client and server.  Testing against NFS storage
+   products that don't support the LOCALIO protocol was also performed.
+
+-  Client on host, server within a container (for both v3 and v4.2)
+   The container testing was in terms of podman managed containers and
+   includes container stop/restart scenario.
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index 22443d2089eb..e8e3117abb5f 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -21,6 +21,8 @@ extern struct list_head nfsd_uuids;
  * Each nfsd instance has an nfsd_uuid_t that is accessible through the
  * global nfsd_uuids list. Useful to allow a client to negotiate if localio
  * possible with its server.
+ *
+ * See Documentation/filesystems/nfs/localio.rst for more detail.
  */
 typedef struct {
 	uuid_t uuid;
-- 
2.44.0


