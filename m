Return-Path: <linux-nfs+bounces-4622-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35933926FCB
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jul 2024 08:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6C77281120
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jul 2024 06:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54CC1A08B1;
	Thu,  4 Jul 2024 06:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="gp0SzTiU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B632200A3;
	Thu,  4 Jul 2024 06:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720075332; cv=none; b=Rg/H32lE+JUW1DKQJVmxcQfWUsKr1Q+29nmVdqIYgTd+udRHq4Foyf8aaK6u3jgYxAbpSK13NEAXPTlcQM0+7GC47p52aDunF11YefNEzpLL6/Dq3Dp2LKkVDfdnI0e5NK35CpaiGd5bHXMalm7MURQ2NQxPCJbD6k/cCTe/GF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720075332; c=relaxed/simple;
	bh=+iO7Wy3tq973FOPKw8BQTqJd9ZV8zPaKAMo6GvLKhEw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GCAHID9JCWshw1bgQjrkKckk7+cKtaeJJ7okprqs3csnrqAaBIADMlVJ5CNTyQrHH0jzLc8MIm8IJ40x+zFQ068wzbyai6Ay2dDmbihHvZGPW0FLl2HkkjtYV1t2FdjDAWI1EY7eVVu6lBO8O3DEL9jiqjL7gpTBQgmnvDuGgIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=gp0SzTiU; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=KoRkv1cwU4n5JXXBByQDctK7NLjIkmWsmoCZ4F4jUjI=; b=gp0SzTiUWIQ0tj3KJ8yKnLys83
	hZycpz2Y9U2b4a0rfcx7K5mOJmcR5TKnM5ZwgFcYCVYB4nExpqUNDlqtH5TdVtqOlGB01D+x/naDs
	+czMzwo3dAivtx6iSXAqtBU/v57/HbrpStfIsk8YW8enqbuQ7+lY6cRSn8Y7nw3S4WsZIwz+514+m
	wfQb9AGOO3M1/IRcJZco04Cbth+LYDGULNquK4kOmy97t30Bewi7wnpAroNMc+KMfNye6uMscuYVj
	Qdbcv9dV3osRLcCPsCro8dT/9dskrGk6E3I3dNSWETNBS6UbvOgUtRGR6ZRC1lDXOyO1zCEYMhqGM
	7UvWcYgA==;
Received: from 32.248.197.178.dynamic.cust.swisscom.net ([178.197.248.32] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sPGAN-000GE3-Bm; Thu, 04 Jul 2024 08:42:03 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: kuba@kernel.org
Cc: netdev@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lex Siegel <usiegl00@gmail.com>,
	Neil Brown <neilb@suse.de>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Subject: [PATCH net v3 resend] net, sunrpc: Remap EPERM in case of connection failure in xs_tcp_setup_socket
Date: Thu,  4 Jul 2024 08:41:57 +0200
Message-Id: <9069ec1d59e4b2129fc23433349fd5580ad43921.1720075070.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27325/Wed Jul  3 10:39:00 2024)

When using a BPF program on kernel_connect(), the call can return -EPERM. This
causes xs_tcp_setup_socket() to loop forever, filling up the syslog and causing
the kernel to potentially freeze up.

Neil suggested:

  This will propagate -EPERM up into other layers which might not be ready
  to handle it. It might be safer to map EPERM to an error we would be more
  likely to expect from the network system - such as ECONNREFUSED or ENETDOWN.

ECONNREFUSED as error seems reasonable. For programs setting a different error
can be out of reach (see handling in 4fbac77d2d09) in particular on kernels
which do not have f10d05966196 ("bpf: Make BPF_PROG_RUN_ARRAY return -err
instead of allow boolean"), thus given that it is better to simply remap for
consistent behavior. UDP does handle EPERM in xs_udp_send_request().

Fixes: d74bad4e74ee ("bpf: Hooks for sys_connect")
Fixes: 4fbac77d2d09 ("bpf: Hooks for sys_bind")
Co-developed-by: Lex Siegel <usiegl00@gmail.com>
Signed-off-by: Lex Siegel <usiegl00@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Neil Brown <neilb@suse.de>
Cc: Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>
Link: https://github.com/cilium/cilium/issues/33395
Link: https://lore.kernel.org/bpf/171374175513.12877.8993642908082014881@noble.neil.brown.name
---
 [ Fixes tags are set to the orig connect commit so that stable team
   can pick this up.

   Resend as it turns out that patchwork did not pick up the earlier
   resends likely due to the message id being the same. ]

 v1 -> v2 -> v3:
   - Plain resend, adding correct sunrpc folks to Cc
     https://lore.kernel.org/bpf/Zn7wtStV+iafWRXj@tissot.1015granger.net/

 net/sunrpc/xprtsock.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index dfc353eea8ed..0e1691316f42 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2441,6 +2441,13 @@ static void xs_tcp_setup_socket(struct work_struct *work)
 		transport->srcport = 0;
 		status = -EAGAIN;
 		break;
+	case -EPERM:
+		/* Happens, for instance, if a BPF program is preventing
+		 * the connect. Remap the error so upper layers can better
+		 * deal with it.
+		 */
+		status = -ECONNREFUSED;
+		fallthrough;
 	case -EINVAL:
 		/* Happens, for instance, if the user specified a link
 		 * local IPv6 address without a scope-id.
-- 
2.21.0


