Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241744E7565
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Mar 2022 15:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355701AbiCYOu0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Mar 2022 10:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359371AbiCYOuY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Mar 2022 10:50:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300C637A88
        for <linux-nfs@vger.kernel.org>; Fri, 25 Mar 2022 07:48:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9F5DB82833
        for <linux-nfs@vger.kernel.org>; Fri, 25 Mar 2022 14:48:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E356C340E9
        for <linux-nfs@vger.kernel.org>; Fri, 25 Mar 2022 14:48:45 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH RFC] man: Add nfs-client-identifier(7)
Date:   Fri, 25 Mar 2022 10:48:43 -0400
Message-Id:  <164821972362.2101249.3667415795547016876.stgit@morisot.1015granger.net>
X-Mailer: git-send-email 2.35.0
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is an alternative approach to documenting the needs for
configuring good NFSv4 client identifiers. Instead of adding to
nfs(5), a new man page is created in section 7, since this
information is not tied to a specific command or interface.

Moreover, there is now room for a more expansive discussion:

 - An introductory section links together file open and lock state,
   client leases, and the client's NFSv4 identifier.

 - A discussion of security issues has been added.

Source for the new man page is added under systemd/ because I
couldn't think of a better place. Suggestions welcome.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 systemd/Makefile.am               |    2 
 systemd/nfs-client-identifier.man |  261 +++++++++++++++++++++++++++++++++++++
 2 files changed, 262 insertions(+), 1 deletion(-)
 create mode 100644 systemd/nfs-client-identifier.man

diff --git a/systemd/Makefile.am b/systemd/Makefile.am
index e7f5d818a913..b1b203fe9093 100644
--- a/systemd/Makefile.am
+++ b/systemd/Makefile.am
@@ -50,7 +50,7 @@ unit_files += \
 endif
 
 man5_MANS	= nfs.conf.man
-man7_MANS	= nfs.systemd.man
+man7_MANS	= nfs.systemd.man nfs-client-identifier.man
 EXTRA_DIST = $(unit_files) $(man5_MANS) $(man7_MANS)
 
 generator_dir = $(unitdir)/../system-generators
diff --git a/systemd/nfs-client-identifier.man b/systemd/nfs-client-identifier.man
new file mode 100644
index 000000000000..fb4937f6597b
--- /dev/null
+++ b/systemd/nfs-client-identifier.man
@@ -0,0 +1,261 @@
+.\"@(#)nfs-client-identifier.7
+.\"
+.\" SPDX-License-Identifier: GPL-2.0-only
+.\"
+.\" Copyright (c) 2022 Oracle and/or its affiliates.
+.\"
+.TH NFS-CLIENT-ID 7 "22 Mar 2022"
+.SH NAME
+nfs-client-identifier \- NFSv4 client identifier
+.SH DESCRIPTION
+The NFSv4 protocol uses "lease-based file locking".
+Leases help NFSv4 servers
+provide file lock guarantees and manage their resources.
+.P
+Simply put,
+an NFSv4 server creates a lease for each NFSv4 client.
+The server collects each client's file open and lock state
+under the lease for that client.
+.P
+The client is responsible for periodically renewing its leases.
+While a lease remains valid, the server holding that lease guarantees
+the file locks the client has created remain in place.
+.P
+If a client stops renewing its lease (for example, if it crashes),
+the NFSv4 protocol allows the server to remove the
+client's open and lock state after a certain period of time.
+When a client restarts, it indicates to servers that
+open and lock state associated with its previous leases is
+no longer valid.
+.P
+In addition, each NFSv4 server manages
+a persistent list of client leases.
+When the server restarts, it uses this list to
+distinguish between requests
+from clients that held state before the server restarted
+and
+from clients that did not.
+This enables file locks to persist safely across server restarts.
+.SS "NFSv4 client identifiers"
+Each NFSv4 client presents an
+identifier to NFSv4 servers so that they can
+associate the client with its lease.
+Each client's identifier consists of two elements:
+.TP
+.B co_ownerid
+An arbitrary but fixed string.
+.TP
+.B "boot verifier"
+A 64-bit incarnation verifier that enables a server
+to distinguish successive boot epochs of the same client.
+.P
+The NFSv4.0 specification refers to these two items as an
+.IR nfs_client_id4 .
+The NFSv4.1 specification refers to these two items as a
+.IR client_owner4 .
+.P
+NFSv4 servers tie this identifier to the principal and
+security flavor that the client used when presenting it.
+Servers use this principal to authorize
+subsequent lease modification operations sent by the client.
+Effectively this principal is a third element of the identifier.
+.P
+As part of the identity presented to servers, a good
+.I co_ownerid
+string has several important properties:
+.IP \- 2
+The
+.I co_ownerid
+string identifies the client during reboot recovery,
+therefore the string is persistent across client reboots.
+.IP \- 2
+The
+.I co_ownerid
+string helps servers distinguish the client from others,
+therefore the string is globally unique.
+Note that there is no central authority that assigns
+.I co_ownerid
+strings.
+.IP \- 2
+Because it often appears on the network in the clear,
+the
+.I co_ownerid
+string does not reveal private information about the client itself.
+.IP \- 2
+The content of the
+.I co_ownerid
+string is set and unchanging before the client attempts NFSv4 mounts after a restart.
+.IP \- 2
+The NFSv4 protocol does not place a limit on the size of the
+.I co_ownerid
+string, but most NFSv4 implementations do not tolerate
+excessively long
+.I co_ownerid
+strings.
+.SS "Protecting NFSv4 lease state"
+NFSv4 servers utilize the
+.I client_owner4
+as described above to assign a unique lease to each client.
+Under this scheme, there are circumstances
+where clients can interfere with each other.
+This is referred to as "lease stealing".
+.P
+If distinct clients present the same
+.I co_ownerid
+string and use the same principal (for example, AUTH_SYS and UID 0),
+a server is unable to tell that the clients are not the same.
+Each distinct client presents a different boot verifier,
+so it appears to the server as if there is one client
+that is rebooting frequently.
+Neither client can maintain open or lock state in this scenario.
+.P
+If distinct clients present the same
+.I co_ownerid
+string and use distinct principals,
+the server is likely to allow the first client to operate
+normally but reject subsequent clients with the same
+.I co_ownerid
+string.
+.P
+If a client's
+.I co_ownerid
+string or principal are not stable,
+state recovery after a server or client reboot is not guaranteed.
+If a client unexpectedly restarts but presents a different
+.I co_ownerid
+string or principal to the server,
+the server orphans the client's previous open and lock state.
+This blocks access to locked files until the server removes the orphaned
+state.
+.P
+If the server restarts and a client presents a changed
+.I co_ownerid
+string or principal to the server,
+the server will not allow the client to reclaim its open
+and lock state, and may give those locks to other clients
+in the mean time.
+This is referred to as "lock stealing".
+.P
+Lease stealing and lock stealing
+increase the potential for denial of service
+and in rare cases even data corruption.
+.SS "Selecting an appropriate client identifier"
+By default, the Linux NFSv4 client implementation constructs its
+.I co_ownerid
+string
+starting with the words "Linux NFS" followed by the client's UTS node name
+(the same node name, incidentally, that is used as the "machine name" in
+an AUTH_SYS credential).
+In small deployments, this construction is usually adequate.
+Often, however, the node name by itself is not adequately unique,
+and can change unexpectedly.
+Problematic situations include:
+.IP \- 2
+NFS-root (diskless) clients, where the local DCHP server (or equivalent) does
+not provide a unique host name.
+.IP \- 2
+"Containers" within a single Linux host.  If each container has a separate
+network namespace, but does not use the UTS namespace to provide a unique
+host name, then there can be multiple NFS client instances with the
+same host name.
+.IP \- 2
+Clients across multiple administrative domains that access a common NFS server.
+If hostnames are not assigned centrally then uniqueness cannot be
+guaranteed unless a domain name is included in the hostname.
+.P
+Linux provides two mechanisms to add uniqueness to its
+.I co_ownerid
+string:
+.TP
+.B nfs.nfs4_unique_id
+This module parameter can set an arbitrary uniquifier string
+via the kernel command line, or when the
+.B nfs
+module is loaded.
+.TP
+.I /sys/fs/nfs/client/net/identifier
+This virtual file, available since Linux 5.3, is local to the network
+namespace in which it is accessed and so can provide distinction between
+network namespaces (containers) when the hostname remains uniform.
+.RS
+.P
+Note that this file is empty on name-space creation.
+If the container system has access to some sort of per-container
+identity then that uniquifier can be used. For example,
+a uniquifier might be formed at boot using the container's internal
+identifier:
+.RS 4
+.br
+sha256sum /etc/machine-id | awk '{print $1}' \\
+.br
+   > /sys/fs/nfs/client/net/identifier
+.RE
+.SS Security considerations
+The use of cryptographic security for lease management operations
+is strongly encouraged.
+.P
+If NFS with Kerberos is not configured, a Linux NFSv4 client
+uses AUTH_SYS and UID 0 as the principal part of its client identity.
+This configuration is not only insecure,
+it increases the risk of lease and lock stealing.
+However, it might be the only choice for client configurations
+that have no local persistent storage.
+.I co_ownerid
+string uniqueness and persistence is critical in this case.
+.P
+When a Kerberos keytab is present on a Linux NFS client,
+the client attempts to use one of the principals in that keytab
+when identifying itself to servers.
+Alternately, a single-user client with a Kerberos principal
+can use that principal in place of the client's host principal.
+.P
+Using Kerberos for this purpose enables the client and server
+to use the same lease for operations covered by all
+.B sec=
+settings.
+Additionally,
+the Linux NFS client uses the RPCSEC_GSS security flavor
+with Kerberos and the integrity QOS
+to prevent in-transit modification of lease modification requests.
+.SS "Additional notes"
+The Linux NFSv4 client establishes a single lease on each NFSv4 server
+it accesses.
+NFSv4 mounts from a Linux NFSv4 client of a particular server then
+share that lease.
+.P
+Once a client establishes open and lock state,
+the NFSv4 protocol enables lease state to transition
+to other servers, following data that has been migrated.
+This hides data migration completely from running applications.
+The Linux NFSv4 client facilitates state migration by presenting the same
+.I client_owner4
+to all servers it encounters.
+.SH FILES
+.sp
+\fI/sys/fs/nfs/client/net/identifier\fP
+.RS 4
+API that adds a unique string to the local NFSv4 client identifier
+.RE
+.sp
+\fI/etc/machine-id\fP
+.RS 4
+Local machine ID configuration file
+.RE
+.sp
+\fI/etc/krb5.keytab\fP
+.RS 4
+Repository of Kerberos host principals
+.RE
+.\" .SH AUTHORS
+.\" This page was written by Neil Brown and Chuck Lever,
+.\" with assistance from Benjamin Coddington.
+.SH SEE ALSO
+.BR nfs (5).
+.PP
+RFC\ 7530 for the NFSv4.0 specification.
+.br
+RFC\ 8881 for the NFSv4.1 specification.
+.SH COLOPHON
+This page is part of the
+.I nfs-utils
+package.

