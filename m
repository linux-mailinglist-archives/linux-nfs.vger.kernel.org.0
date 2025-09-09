Return-Path: <linux-nfs+bounces-14139-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B21A8B4FC3E
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Sep 2025 15:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BABD01BC1BBB
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Sep 2025 13:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937DF29408;
	Tue,  9 Sep 2025 13:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4+vRWGn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1921EFF8D
	for <linux-nfs@vger.kernel.org>; Tue,  9 Sep 2025 13:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757423881; cv=none; b=nfuYe0ZLY0jzqfvP+HljIrSSlhVDue1wBb9XkObE9oPmbLT18uF5knhA7vW9LaST70lfLYMFq/YcZD4Z0UQUk9q4Uh2EsZKh46Th8RMEl/xZJWB3KxrCmv+ACmkPdlIlPDCllmyESJ6FEvenwhWm4O/AzLx9BbP4H8XNIsjKhis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757423881; c=relaxed/simple;
	bh=+wpAWVgptyuD+SGQ+VbuGd2awSywolQchMPyB9UJRRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pWDIgChstwMHdrIBPlxKKZtlGIGki7BbK+hxftJBqHerR5Nhum7pXm1gMpMn2+30WGVyJx9Np3nL1+1LPZgJ/vYzHSd030esPyQN2D0r3ADOLQqzJ/mtBX6oNxF0vdESx3zJIyb/QsJHYcgyPZgfmenQUAobUNnhzNILX2k1mjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E4+vRWGn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757423878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rzUAFQWztZEKKNzjqvaJtYY0FakA3sZ5CP08CKwRq0I=;
	b=E4+vRWGnxPwUkRSEc9JScp8ZetNfyY4xaq/34pX/hkhiXd/oqeFvq0eJAZB7/lG3XDYgUz
	DgkP7ffCWsY8ixBoDn0QoawfkFhrmjHY5qx2xeNKJJq0liK2ad8W7rVN4XwIpGe10e4sQ4
	gBf258eYI+UNn6QOBZ/cd/11D6fuWGg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-178-1TWaISXyPZObzjgIekje_A-1; Tue,
 09 Sep 2025 09:17:55 -0400
X-MC-Unique: 1TWaISXyPZObzjgIekje_A-1
X-Mimecast-MFC-AGG-ID: 1TWaISXyPZObzjgIekje_A_1757423874
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 982631955F26;
	Tue,  9 Sep 2025 13:17:54 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.88.97])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4100219560B8;
	Tue,  9 Sep 2025 13:17:54 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id AAB6442FAE7;
	Tue, 09 Sep 2025 09:17:52 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: steved@redhat.com
Cc: neil@brown.name,
	bcodding@redhat.com,
	yoyang@redhat.com,
	linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH v2] rpc-statd.service: define dependency on both rpcbind.service and rpcbind.socket
Date: Tue,  9 Sep 2025 09:17:52 -0400
Message-ID: <20250909131752.1310595-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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

Define the dependency on both rpcbind.service and rpcbind.socket.  As
Neil explains:

"After" declarations only have effect if the units are in the same
transaction.  If the Unit is not being started or stopped, the After
declaration has no effect.

So on startup, this will ensure rpcbind.socket is started before
rpc-statd.service.  On shutdown in a transaction that stops both
rpc-statd.service and rpcbind.service, rpcbind.service won't be
stopped until after rpc-statd.service is stopped.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 systemd/rpc-statd.service | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/systemd/rpc-statd.service b/systemd/rpc-statd.service
index 660ed861..96fd500d 100644
--- a/systemd/rpc-statd.service
+++ b/systemd/rpc-statd.service
@@ -6,7 +6,7 @@ Conflicts=umount.target
 Requires=nss-lookup.target rpcbind.socket
 Wants=network-online.target
 Wants=rpc-statd-notify.service
-After=network-online.target nss-lookup.target rpcbind.service
+After=network-online.target nss-lookup.target rpcbind.service rpcbind.socket
 
 PartOf=nfs-utils.service
 IgnoreOnIsolate=yes
-- 
2.50.1


