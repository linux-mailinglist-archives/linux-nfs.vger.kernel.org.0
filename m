Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8C31DD5EB
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2020 20:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgEUSZW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 May 2020 14:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728670AbgEUSZU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 May 2020 14:25:20 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F380C061A0E
        for <linux-nfs@vger.kernel.org>; Thu, 21 May 2020 11:25:20 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id d7so8545703ioq.5
        for <linux-nfs@vger.kernel.org>; Thu, 21 May 2020 11:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=e0qg1Sr8E5ElWqLHDtPlrMkP8ELK/AhLrxMZmmoRNnk=;
        b=VFABO16v2K7oRV3J2q1fDOt1WYpq2Cj2J0dCRuJh+Bc+MbYC1hjB25mB3nv5mKZ87z
         YbmvR6DzKNBcm78rkpCp1t8656raHHstN7emN9yqciNzV2kvzuBriGkWMBBTuFNH84FJ
         uJQlui6oE9Q8wo2uCafwOAU8MS/N0ujtg5l+UdV44iliiy5khiwoocGc+owGaFqTnCWQ
         rhFw7yyFQlZUoWHQLDhxJUjSMi6OOYiy7XtodkxC7vD9zlY4wOgvJmpojn6Q1jZBSJXZ
         ICfcEPN/C6iTm7YLTlWZz2SdCwFwNcFXN1fH2xMr9VIhi5mC2u6B3rYmcbOuVuhh5BYR
         0EaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=e0qg1Sr8E5ElWqLHDtPlrMkP8ELK/AhLrxMZmmoRNnk=;
        b=sYKpivNt154CZ7feQHRIXupYqh4U7AuYKJ7jkIcTyFuSb4afkCF50yCn51k4XXVNv7
         UJXNz1lO7S0guad67EGK4TQrqUHisTLXBediiAwO6pZlk9emJDTVIS6/UHiZ60L+rvs5
         7lcg04WH7qhA1coxq228UsBu/wJv6H+f4Zaa+GN936KI/6UuokoQn6X76K2DCIETph2R
         hPlQ7Bs9Kip9HE5GVTR9A9NY9fFA+Mnyh41ryH79l2NO6uiBCwZEvbaavkl2GXB0WvZY
         S6ZcnpPGUvj36NwfD91dY3RJ7OmvZY2LV6Km2sWBmDAavnEraZPqdesEUbHiBmwC6CkR
         g2Sw==
X-Gm-Message-State: AOAM5339ejBUPmlssxfzYBRVLWt4w6YV2GEN2GpqYdbMpCYVfALc4KxS
        CctFX+zC4EoCN9xCsyExIQfq6lEK
X-Google-Smtp-Source: ABdhPJwov49WtQzgjIs8JjDaKd/eODrM79biNa0zv5q2RWOrlei8VAcbcafiZ36g4JD5bXv91OA5MA==
X-Received: by 2002:a02:a904:: with SMTP id n4mr4992793jam.105.1590085519306;
        Thu, 21 May 2020 11:25:19 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id g6sm3368563ile.38.2020.05.21.11.25.18
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2020 11:25:18 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04LIPHsB001459
        for <linux-nfs@vger.kernel.org>; Thu, 21 May 2020 18:25:17 GMT
Subject: [PATCH v1] man: Update nfs(5) and rpc.gssd(8) discussion of keytab
 needs
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Thu, 21 May 2020 14:25:17 -0400
Message-ID: <20200521182517.2331.18548.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Because of the <anyname> wildcard feature in rpc.gssd, it's possible
for a customer to deploy the same keytab on many of her NFSv4 clients
to reduce the overhead of keytab distribution.

However, the practice of sharing the same service principal amongst
NFSv4 clients brings with it some hazards. Add documentation of those
exposures in our man pages.

The rpc.gssd(8) changes:
- Remove some needless redundancy
- Clarify the definition of "machine credentials"
- Update the use of <anyname> to explicitly not recommend sharing
service principals

The nfs(5) changes add two things:
- A brief discussion of the primary security exposure of sharing
service principals
- A mention of the nfs4.nfs_unique_id module parameter

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 utils/mount/nfs.man |   53 +++++++++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/utils/gssd/gssd.man b/utils/gssd/gssd.man
index cc3a210ab81e..3ec286b43c4d 100644
--- a/utils/gssd/gssd.man
+++ b/utils/gssd/gssd.man
@@ -45,22 +45,20 @@ is known as a
 .BR kerberos (1)
 for more on principals).
 .P
-For certain operations, a credential is required
-which represents no user,
-is otherwise unprivileged,
-and is always available.
-This is referred to as a
+Certain operations require a credential that
+represents no particular user
+or
+represents the host itself.
+This kind of credential is called a
 .IR "machine credential" .
 .P
-Machine credentials are typically established using a
-.IR "service principal" ,
-whose encrypted password, called its
-.IR key ,
-is stored in a file, called a
-.IR keytab ,
-to avoid requiring a user prompt.
-A machine credential effectively does not expire because the system
-can renew it as needed without user intervention.
+A host establishes its machine credential using a
+.I "service principal"
+whose encrypted password is stored in a local file known as a
+.IR keytab .
+A machine credential remains effective
+without user intervention
+as long as the host can renew it.
 .P
 Once obtained, credentials are typically stored in local temporary files
 with well-known pathnames.
@@ -93,30 +91,12 @@ See the description of the
 .B -d
 option for details.
 .SS Machine Credentials
-A user credential is established by a user and
-is then shared with the kernel and
-.BR rpc.gssd .
-A machine credential is established by
-.B rpc.gssd
-for the kernel when there is no user.
-Therefore
-.B rpc.gssd
-must already have the materials on hand to establish this credential
-without requiring user intervention.
-.P
-.B rpc.gssd
-searches the local system's keytab for a principal and key to use
-to establish the machine credential.
-By default,
-.B rpc.gssd
-assumes the file
-.I /etc/krb5.keytab
-contains principals and keys that can be used to obtain machine credentials.
-.P
 .B rpc.gssd
-searches in the following order for a principal to use.
-The first matching credential is used.
-For the search, <hostname> and <REALM> are replaced with the local
+searches the default keytab,
+.IR /etc/krb5.keytab ,
+in the following order for a principal and password to use
+when establishing the machine credential.
+For the search, rpc.gssd replaces <hostname> and <REALM> with the local
 system's hostname and Kerberos realm.
 .sp
    <HOSTNAME>$@<REALM>
@@ -133,15 +113,20 @@ system's hostname and Kerberos realm.
 .br
    host/<anyname>@<REALM>
 .sp
-The <anyname> entries match on the service name and realm, but ignore the hostname.
-These can be used if a principal matching the local host's name is not found.
+rpc.gssd selects one of the <anyname> entries if it does not find
+a service principal matching the local hostname,
+e.g. if DHCP assigns the local hostname dynamically.
+The <anyname> facility enables the use of the same keytab on multiple systems.
+However, using the same service principal to establish a machine credential
+on multiple hosts can create unwanted security exposures
+and is therefore not recommended.
 .P
-Note that the first principal in the search order is a user principal
+Note that <HOSTNAME>$@<REALM> is a user principal
 that enables Kerberized NFS when the local system is joined
 to an Active Directory domain using Samba.
-A password for this principal must be provided in the local system's keytab.
+The keytab provides the password for this principal.
 .P
-You can specify another keytab by using the
+You can specify a different keytab by using the
 .B -k
 option if
 .I /etc/krb5.keytab
diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
index 6f79c63a7e9c..19fe22fb5411 100644
--- a/utils/mount/nfs.man
+++ b/utils/mount/nfs.man
@@ -1639,52 +1639,55 @@ from a server's pseudo-fs
 into one of the server's exported physical filesystems,
 which often have more restrictive security settings than the pseudo-fs.
 .SS "NFS version 4 Leases"
-In NFS version 4, a lease is a period of time during which a server
-irrevocably grants a file lock to a client.
-If the lease expires, the server is allowed to revoke that lock.
+In NFS version 4, a lease is a period during which a server
+irrevocably grants a client file locks.
+Once the lease expires, the server may revoke those locks.
 Clients periodically renew their leases to prevent lock revocation.
 .P
 After an NFS version 4 server reboots, each client tells the
-server about all file open and lock state under its lease
+server about existing file open and lock state under its lease
 before operation can continue.
-If the client reboots, the server frees all open and lock state
+If a client reboots, the server frees all open and lock state
 associated with that client's lease.
 .P
-As part of establishing a lease, therefore,
+When establishing a lease, therefore,
 a client must identify itself to a server.
-A fixed string is used to distinguish that client from
-others, and a changeable verifier is used to indicate
-when the client has rebooted.
-.P
-A client uses a particular security flavor and principal
-when performing the operations to establish a lease.
-If two clients happen to present the same identity string,
-a server can use their principals to detect that they are
-different clients, and prevent one client from interfering
-with the other's lease.
-.P
-The Linux NFS client establishes one lease for each server.
+Each client presents an arbitrary string
+to distinguish itself from other clients.
+The client administrator can
+supplement the default identity string using the
+.I nfs4.nfs4_unique_id
+module parameter to avoid collisions
+with other client identity strings.
+.P
+A client also uses a unique security flavor and principal
+when it establishes its lease.
+If two clients present the same identity string,
+a server can use client principals to distinguish between them,
+thus securely preventing one client from interfering with the other's lease.
+.P
+The Linux NFS client establishes one lease on each NFS version 4 server.
 Lease management operations, such as lease renewal, are not
 done on behalf of a particular file, lock, user, or mount
-point, but on behalf of the whole client that owns that lease.
-These operations must use the same security flavor and
-principal that was used when the lease was established,
-even across client reboots.
+point, but on behalf of the client that owns that lease.
+A client uses a consistent identity string, security flavor,
+and principal across client reboots to ensure that the server
+can promptly reap expired lease state.
 .P
 When Kerberos is configured on a Linux NFS client
 (i.e., there is a
 .I /etc/krb5.keytab
 on that client), the client attempts to use a Kerberos
 security flavor for its lease management operations.
-This provides strong authentication of the client to
-each server it contacts.
+Kerberos provides secure authentication of each client.
 By default, the client uses the
 .I host/
 or
 .I nfs/
 service principal in its
 .I /etc/krb5.keytab
-for this purpose.
+for this purpose, as described in
+.BR rpc.gssd (8).
 .P
 If the client has Kerberos configured, but the server
 does not, or if the client does not have a keytab or

