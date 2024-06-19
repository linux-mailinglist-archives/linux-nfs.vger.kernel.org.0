Return-Path: <linux-nfs+bounces-4106-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51ECB90F7A8
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 22:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E0111C213B1
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 20:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B90159204;
	Wed, 19 Jun 2024 20:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHVfX7+d"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E0E1591FC
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 20:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718829657; cv=none; b=Zs5kHI45W3i2W9MdPLeKqbQ/2bJWS8q2yTkoOx6MXIwguWspIAA0piRxyl2N6Z4AgO4SRqDxKsNKtrvD78IZ0JC/zs8SqV5+0huCepUqFzr/Hi1ZTfM/ors5aPvckz9lvVorcGYphUyqVZHaXDuau6dkMjUp0vZD9DGFAx7T/Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718829657; c=relaxed/simple;
	bh=Y9NPhTGADEaBTZcBW5Io2MxuFYqTlnEnU6JZWW7cgzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K49CjEXNfkzn5kFuh1UspHlcmP8dlcsxzdRa2vyVbSw9aGsymiHNWfbJ+d2iENMb36FpR13qJymvsO5JKMawr0Q06Zi/2wG5DhH7SdynocjKAHHGEwXyhBskO2qgSvLd5GJ4qwJsaTDekKIgYhHl3wikoFhURqI6T17Z7V/t0DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHVfX7+d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA53CC2BBFC;
	Wed, 19 Jun 2024 20:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718829657;
	bh=Y9NPhTGADEaBTZcBW5Io2MxuFYqTlnEnU6JZWW7cgzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JHVfX7+deAlmKs1JyfJrzHQrcaLdpUNy8T79o/B8X2cslqCAF3tD9zJh9Uun1mQfV
	 knxiP8PPWb1BeUDIlBJwhl7/+K0vHt4qxKbz7lCz2gH5XTjiRlvrENhJ5XtzgzBjuj
	 aaEJqbj0OT6Av4Fcn4Zl7deqAUB3RXKt+bdLbatb9S1tWztFKczsdSsPQjsZjFMyyW
	 3R0SbuZ0yPaHsxXlCSnsseB+fEXwS7PNeiKdt33aomIrYtrX1RQj01B+zT+rDY8t4o
	 RzEtTLokcU+bKPWRzjY7tXo2uMSGZJVYzC69M3AmKptvYKjXkqAoBvuHO0kD+0D5zU
	 VnAxMEnntm3Ww==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v6 17/18] nfs: add Documentation/filesystems/nfs/localio.rst
Date: Wed, 19 Jun 2024 16:40:31 -0400
Message-ID: <20240619204032.93740-18-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240619204032.93740-1-snitzer@kernel.org>
References: <20240619204032.93740-1-snitzer@kernel.org>
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
 Documentation/filesystems/nfs/localio.rst | 148 ++++++++++++++++++++++
 include/linux/nfslocalio.h                |   2 +
 2 files changed, 150 insertions(+)
 create mode 100644 Documentation/filesystems/nfs/localio.rst

diff --git a/Documentation/filesystems/nfs/localio.rst b/Documentation/filesystems/nfs/localio.rst
new file mode 100644
index 000000000000..a43c3dab2cab
--- /dev/null
+++ b/Documentation/filesystems/nfs/localio.rst
@@ -0,0 +1,148 @@
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
+clients local to their servers.  Prior to this LOCALIO protocol a
+fragile sockaddr network address based match against all local network
+interfaces was attempted.  But unlike the LOCALIO protocol, the
+sockaddr-based matching didn't handle use of iptables or containers.
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
+method that allows the Linux nfs client to retrieve a Linux nfs server's
+uuid.  This protocol isn't part of an IETF standard, nor does it need to
+be considering it is Linux-to-Linux auxiliary RPC protocol that amounts
+to an implementation detail.
+
+The GETUUID method encodes the server's uuid_t in terms of the fixed
+UUID_SIZE (16 bytes).  The fixed size opaque encode and decode XDR
+methods are used instead of the less efficient variable sized methods.
+
+The RPC program number for the NFS_LOCALIO_PROGRAM is currently defined
+as 0x20000002 (but a request for a unique RPC program number assignment
+has been submitted to IANA.org).
+
+The following approximately describes the LOCALIO in a pseudo rpcgen .x
+syntax:
+
+#define UUID_SIZE 16
+typedef u8 uuid_t<UUID_SIZE>;
+
+program NFS_LOCALIO_PROGRAM {
+     version NULLVERS {
+        void NULL(void) = 0;
+	} = 1;
+     version GETUUIDVERS {
+        uuid_t GETUUID(void) = 1;
+	} = 1;
+} = 0x20000002;
+
+The above is the skeleton for the LOCALIO protocol, it doesn't account
+for NFS v3 and v4 RPC boilerplate (which also marshalls RPC status) that
+is used to implement GETUUID.
+
+Here are the respective XDR results for nfsd and nfs:
+
+From fs/nfsd/xdr.h
+
+struct nfsd_getuuidres {
+	__be32			status;
+	uuid_t			uuid;
+};
+
+From include/linux/nfs_xdr.h
+
+struct nfs_getuuidres {
+	__u8 *			uuid;
+};
+
+The client ultimately decodes this XDR using:
+xdr_stream_decode_opaque_fixed(xdr, result->uuid, UUID_SIZE);
+
+NFS Common and Server
+---------------------
+
+First use is in nfsd, to add access to a global nfsd_uuids list in
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
+valid nfsd objects (be it struct net or nn->nfsd_serv) it return ENXIO
+to nfs_local_open_fh() and the client will try to reestablish the
+LOCALIO resources needed by calling nfs_local_probe() again.  This
+recovery is needed if/when an nfsd instance running in a container were
+to reboot while a localio client is connected to it.
+
+Testing
+-------
+
+The LOCALIO auxiliary protocol and associated NFS localio read, right
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
index c9592ad0afe2..a9722e18b527 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -20,6 +20,8 @@ extern struct list_head nfsd_uuids;
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


