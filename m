Return-Path: <linux-nfs+bounces-14091-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E99AB466BE
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Sep 2025 00:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 388E61CC629D
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 22:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18146265637;
	Fri,  5 Sep 2025 22:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YyFg+Elh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15747524F
	for <linux-nfs@vger.kernel.org>; Fri,  5 Sep 2025 22:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757111757; cv=none; b=nvMs9wAk7pD6mL2CnPULys/+075TCfIe2FPJFHYUnjQFYmv/5GN0EbQr+4l9jsilaBRWO1pBXm0t62g12rGAbGK2sofXsXzLT/BSzHGmh7+6pCIuA83IjUsr6Mrp4nJuHDRYM+tSKKaCK0AnSeUysYM+cG+WLwHMEveuYseuvqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757111757; c=relaxed/simple;
	bh=gsOmkXJiL+qWGTgHdYGJNX4Xf3YMqo262A7t/DXGYp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b7ASOIRvjLkQ1xiTj3Ur6v9EY89/JXbepVtLUEgWl0ApczWO3dhkA0lIMNzELpYiM3/OmHV1jEunvMuAomhLa8EO5AS3e16uItMUBGuH0egxtCg2DXse6/QosY7faXEijDs+hVJtZPFYaTosFMZd3aqBNqv7bLXUUBc5BMAZ9UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YyFg+Elh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757111752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nCDBOoOq8xqMMfBpBbUl0BmzAXiIXjW9XH7x62P2Zu4=;
	b=YyFg+Elh+YbwzhKiUAnobOe4xJ2BzydVTZ3wSiwjxJaogOdmgLviAajfbk2yjohWgjbiht
	mBAKEv6AHlz+J/nqnLZaEZ0Sth/wQQC0iBzgg6QVtrs5xBtmXQYesJXwnW2/61QMIdiMBj
	4tmXLsyIvn27T5kiQkaZ2b4NwPhLI/M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-dr6R6n6ZM2mfcr8IFoDynQ-1; Fri,
 05 Sep 2025 18:35:50 -0400
X-MC-Unique: dr6R6n6ZM2mfcr8IFoDynQ-1
X-Mimecast-MFC-AGG-ID: dr6R6n6ZM2mfcr8IFoDynQ_1757111749
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87C6518002E9;
	Fri,  5 Sep 2025 22:35:49 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.45.226.162])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B29283002D2A;
	Fri,  5 Sep 2025 22:35:48 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id C00F842F0E6;
	Fri, 05 Sep 2025 18:35:44 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: steved@redhat.com
Cc: neil@brown.name,
	bcodding@redhat.com,
	yoyang@redhat.com,
	linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH] rpc-statd.service: weaken the dependency on rpcbind.socket
Date: Fri,  5 Sep 2025 18:35:44 -0400
Message-ID: <20250905223544.1229104-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

In 91da135f ("systemd unit files: fix up dependencies on rpcbind"),
Neil laid out the rationale for how the nfs services should define their
dependencies on rpcbind.  In a nutshell:

1. Dependencies should only be defined using rpcbind.socket
2. Ordering for dependencies should only be defined usint "After="
3. nfs-server.service should use "Wants=rpcbind.socket", to allow
   rpcbind.socket to be masked in NFSv4-only setups.
4. rpc-statd.service should use "Requires=rpcbind.socket", as rpc.statd
   is useless if it can't register with rpcbind.

Then in https://bugzilla.redhat.com/show_bug.cgi?id=2100395, Ben noted
that due to the way the dependencies are ordered, when 'systemctl stop
rpcbind.socket' is run, systemd first sends SIGTERM to rpcbind, then
SIGTERM to rpc.statd.  On SIGTERM, rpcbind tears down /var/run/rpcbind.sock.
However, rpc-statd on SIGTERM attempts to unregister from rpcbind.  This
results in a long delay:

[root@rawhide ~]# time systemctl restart rpcbind.socket

real	1m0.147s
user	0m0.004s
sys	0m0.003s

8a835ceb ("rpc-statd.service: Stop rpcbind and rpc.stat in an exit race")
fixed this by changing the dependency in rpc-statd.service to use
"After=rpcbind.service", bending rule #1 from above.

Yongcheng recently noted that when runnnig the following test:

[root@rawhide ~]# for i in `seq 10`; do systemctl reset-failed; \
	systemctl stop rpcbind rpcbind.socket ; systemctl restart nfs-server ; \
	systemctl status rpc-statd; done

rpc-statd.service would often fail to start:

× rpc-statd.service - NFS status monitor for NFSv2/3 locking.
     Loaded: loaded (/usr/lib/systemd/system/rpc-statd.service; enabled-runtime; preset: disabled)
    Drop-In: /usr/lib/systemd/system/service.d
             └─10-timeout-abort.conf
     Active: failed (Result: exit-code) since Fri 2025-09-05 18:01:15 EDT; 229ms ago
   Duration: 228ms
 Invocation: bafb2bb00761439ebc348000704e8fbb
       Docs: man:rpc.statd(8)
    Process: 29937 ExecStart=/usr/sbin/rpc.statd (code=exited, status=1/FAILURE)
   Mem peak: 1.5M
        CPU: 7ms

Sep 05 18:01:15 rawhide.smayhew.test rpc.statd[29938]: Version 2.8.2 starting
Sep 05 18:01:15 rawhide.smayhew.test rpc.statd[29938]: Flags: TI-RPC
Sep 05 18:01:15 rawhide.smayhew.test rpc.statd[29938]: Failed to register (statd, 1, udp): svc_reg() err: RPC: Remote system error - Connection refused
Sep 05 18:01:15 rawhide.smayhew.test rpc.statd[29938]: Failed to register (statd, 1, tcp): svc_reg() err: RPC: Success
Sep 05 18:01:15 rawhide.smayhew.test rpc.statd[29938]: Failed to register (statd, 1, udp6): svc_reg() err: RPC: Success
Sep 05 18:01:15 rawhide.smayhew.test rpc.statd[29938]: Failed to register (statd, 1, tcp6): svc_reg() err: RPC: Success
Sep 05 18:01:15 rawhide.smayhew.test rpc.statd[29938]: failed to create RPC listeners, exiting
Sep 05 18:01:15 rawhide.smayhew.test systemd[1]: rpc-statd.service: Control process exited, code=exited, status=1/FAILURE
Sep 05 18:01:15 rawhide.smayhew.test systemd[1]: rpc-statd.service: Failed with result 'exit-code'.
Sep 05 18:01:15 rawhide.smayhew.test systemd[1]: Failed to start rpc-statd.service - NFS status monitor for NFSv2/3 locking..

I propose we revert the change from 8a835ceb and instead turn the
dependency into a weak dependency by using "Wants=rpcbind.socket"
instead of "Requires=rpcbind.socket".  This bends rule #4 above and will
make it so that systemd will try to start rpcbind.socket if it isn't
already running when rpc-statd.service starts, but it won't restart
rpc-statd.service whenever rpcbind is restarted.  Frankly, we shouldn't
need to restart services whenever rpcbind is restarted (thats why
rpcbind has the warmstart feature).  The only drawback is that now if an
admin wants to set up an NFSv4-only server by masking rpcbind.socket,
they'll need to mask rpc-statd.service as well.  I don't think that's
too much to ask, so the nfs.systemd man page has been updated
accordingly.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 systemd/nfs.systemd.man   | 10 +++++++---
 systemd/rpc-statd.service |  5 +++--
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/systemd/nfs.systemd.man b/systemd/nfs.systemd.man
index a8476038..93fb87cd 100644
--- a/systemd/nfs.systemd.man
+++ b/systemd/nfs.systemd.man
@@ -137,7 +137,9 @@ NFSv2) and does not want
 .I rpcbind
 to be running, the correct approach is to run
 .RS
-.B systemctl mask rpcbind
+.B systemctl mask rpcbind.socket
+.br
+.B systemctl mask rpc-statd.service
 .RE
 This will disable
 .IR rpcbind ,
@@ -145,9 +147,11 @@ and the various NFS services which depend on it (and are only needed
 for NFSv3) will refuse to start, without interfering with the
 operation of NFSv4 services.  In particular,
 .I rpc.statd
-will not run when
+will fail to start when
 .I rpcbind
-is masked.
+is masked, so
+.I rpc-statd.service
+should be masked as well.
 .PP
 .I idmapd
 is only needed for NFSv4, and even then is not needed when the client
diff --git a/systemd/rpc-statd.service b/systemd/rpc-statd.service
index 660ed861..4e138f69 100644
--- a/systemd/rpc-statd.service
+++ b/systemd/rpc-statd.service
@@ -3,10 +3,11 @@ Description=NFS status monitor for NFSv2/3 locking.
 Documentation=man:rpc.statd(8)
 DefaultDependencies=no
 Conflicts=umount.target
-Requires=nss-lookup.target rpcbind.socket
+Requires=nss-lookup.target
+Wants=rpcbind.socket
 Wants=network-online.target
 Wants=rpc-statd-notify.service
-After=network-online.target nss-lookup.target rpcbind.service
+After=network-online.target nss-lookup.target rpcbind.socket
 
 PartOf=nfs-utils.service
 IgnoreOnIsolate=yes
-- 
2.50.1


