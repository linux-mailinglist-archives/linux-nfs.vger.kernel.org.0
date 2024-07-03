Return-Path: <linux-nfs+bounces-4586-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E094925452
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 09:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82691F25937
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 07:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C40839F1;
	Wed,  3 Jul 2024 07:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="O9WaVZNs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787A833D5;
	Wed,  3 Jul 2024 07:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719990111; cv=none; b=HoR1R2gVNm8ccw51LysNSGyHXqVqR/el9WgXC5TVS94zB5SOsYgS+ytD66qUzRpqsiA/Tmx6xTQLXgJ/jiDt0qZduol8IuOeYC3NeeVXE447VaQLKgXccsogbi1ewrPbwQW7+aTu6Ouy0H5JPuki9M268Bk01L9W77PYPgvfaic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719990111; c=relaxed/simple;
	bh=Z+z8IqF9p2OuVi283o4CfF1bk3TE4Li6a22iqTpCbd8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bu9gjQJ39L2Ra6zaQJmAZrnRcuWqhVPNVz+IokK0vfNPN3vkq6rC2Cw4au77ktOQxhNvdfHwJSwJLA+eWxGmJedQWGtQaShOrCeiVpYZXYsyP7HTNTUSnAPOwkwNy7swqiYLlL3MBMJSfj1gjUgCfb3hWjmAH7urX9v1zpQlEq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=O9WaVZNs; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=7+iquzvX4RJb1J5IQ5AgA+Y0XDzL+plsSrlY+5cXPF4=; b=O9WaVZNs5nv+YZ2SDDU0P3yjYn
	ATEtvoOuvLqq0ttBQar/Kvezkh16mTqvHPRBIiG6jFQ2nIEjkSbaayp74apar5TclWqs/1hqY+Cvj
	VHK5SlkFOp7Jh+AuazopR5+GIe8cv8pS/JJg2PVOQSf9EsaXsn/0xd0mmbvN6YlKPPliwrZVSK6wD
	PGb7Xcl1lA5rMyJEGq5RCFHWKvISFlRV7VBAWFur1gZjiAVvSKyavpWHw575Uwg88ladOhOx86CoH
	3SVSytZG+TriQwgURfS74FOPawKfZA/btpYWDtFeiO8RuZWC0RsenIwFqiz9288Quh8USJhq5p2xk
	oTqcTD7A==;
Received: from 41.249.197.178.dynamic.cust.swisscom.net ([178.197.249.41] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sOtzi-000Knh-NT; Wed, 03 Jul 2024 09:01:34 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: kuba@kernel.org
Cc: netdev@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lex Siegel <usiegl00@gmail.com>,
	Neil Brown <neilb@suse.de>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Subject: [PATCH net v3] net, sunrpc: Remap EPERM in case of connection failure in xs_tcp_setup_socket
Date: Wed,  3 Jul 2024 09:01:20 +0200
Message-Id: <2e62f0fc284b2f27156cd497fbb733b55a5ade43.1719592013.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27324/Tue Jul  2 10:40:44 2024)

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
   can pick this up. ]

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


