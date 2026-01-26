Return-Path: <linux-nfs+bounces-18463-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAu6MNIJd2lGawEAu9opvQ
	(envelope-from <linux-nfs+bounces-18463-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 07:29:38 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FF284893
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 07:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E7163003308
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 06:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2D71F8755;
	Mon, 26 Jan 2026 06:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="faQD8Kdy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28D01624C0;
	Mon, 26 Jan 2026 06:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769408975; cv=none; b=CtoPE4sXJXVfYqxa6OXzxMdkqnXriesBh9taaKleboAhmamXwK28npkbR0dg0gc4uZXin/XzBlXeTidGWxA7tHgkTuqNp6a8vZd+/HyYLtzpFeNjWK711DNR+NM21jIZxZrqOqLeeSYCL4XHC8llmP5l+jae4nONa8vzr6POXcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769408975; c=relaxed/simple;
	bh=74F+QdvEEPyCkFQAZ9k7xfLSsdZRZRCgm+EBSZyKB+I=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=KdMwmGtRfPqUNsdgx7XT+WVdVfVnKVb3w5Bnt7zwKNRNGUld2kPUi0C/pH7R9umm53S6gMWLdUq0M/WbCoQhbDTWsfy7/tt9zu9X/hKVKcf7YzT1hRqx55WFJk/+uHsJoVQA1jyKAZ5KBYVWn3jXfxux4bObi7dCxjEDdnCoiCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=faQD8Kdy; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1769408960;
	bh=YrOJ9nnZ1uMX7vySKsJwrRb67e2niePqvCeLLz2LtBM=;
	h=From:To:Cc:Subject:Date;
	b=faQD8KdycPq+93nfF6kh/Q3Nl6D+o3F0fqeUtI7VhROVJ1THbltMagh4pm/776+MY
	 Ezqt9/dtfhUCuPsHuExbJ34Lu7kT9pW8JnQNbb6b0rGichtmK0WCOAtzeAWrvpjS4j
	 HLFg9h2bGGDU24CiaMkFnVtYnMAHWrFck4Aqoy0s=
Received: from jack-mini ([58.212.11.129])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 673944A9; Mon, 26 Jan 2026 14:25:51 +0800
X-QQ-mid: xmsmtpt1769408751tmo9wa8bj
Message-ID: <tencent_DBA407008574A1E4BF7F27AD38AD4D13730A@qq.com>
X-QQ-XMAILINFO: MqswyhUqVe0CsHE4UAtaAPNOrVrVCeA8XoFx1yJMupYoIBLm34WVL95ZXkh2Sm
	 pmW04F9Z9YHOs2V13ddwEz/rqxN+4Xp6+F/pw4siFRf95ls+hDdXJd8WKk8xdZRiX+gDRYLfL3Ij
	 oiM/YwvP1mVT/6E3sMQEcdBd0LLsTGDn5bjDHxkHvP/mGaF2SUUvssCrglhCtqC2nNjtCdxpd09m
	 93z5Ixs7oLVtKDmxt4rp3NjBA/zw/giZO/xNOye2CjEF8NTw8h5EKRoaPHHxhusiYIvZKGZYuQL7
	 cBkcQPHD9fS3iKRXb5oov7dkjNyXphgX/I1NCI3j+7kPXZs+rxM0bW67jIFK0eCH6ySg/jIAqORU
	 SUgTtWO0fCKARgNebAx0jfp2vdkyNxClHPX9F2tQLwONCj4iO1aJc1Dia0akDiaPpQs/z2AuHUl8
	 c04RCcBTHhtGGyiWOmRgGBHYXf3fkNT+wI1d0ws8utyLCEo9YW1q1sW1MlrmfgCQlO7+FNM1jS2a
	 BwkzdmdiiI33Bs1G8Dq7OVMKzaR8vw+UXWxQSPWUw86co1yC6yrIEyTUouvFtsx8mFBgfO8DXXcR
	 0o3obenJP8xzMu6Kd7unYCTPEi+KAL4mYFsMAIiDvjMZDMBCDbZgqrFykz8lo1RDuDPYf2CQuBVm
	 RpGFOeIGuRQmCHwgHskiaLM/glCdrrUA78EGeLK9Jz5e4FRvnd8RqABvydwLdp/HE3+IT0alUNSB
	 QkOHh1fARpdiGKRMGIhCMQvWiSKgqz+TDntwirgnX3J34DiRaGrTKs4U6gtyrd7vc5d/2h3V1564
	 BuuDp0Toa8+PkCm97oxPRwr1UxGfqzFhz9a39xnpgGasJ6szw19FuKL/XEs2yD21D8F3natNAzW/
	 A8tHVMIQnUcKR4HQI3eboi61mYRu2po24ndXVXSa3SxQYVdofaRfsHkjvP5yZ/2IGsTpghXZ8CLP
	 iiiRbPjyQppp+0ywFJjuJxiUcvspfJqQCCZYp7nffnyEjswvVStsg6yxr3qr2aJP+AwB1sh3Lrx2
	 cIp4gW7UPAUKcZCU8jNxd3Q9KOeqDMkFgZypgGBg==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: "jack.zhou" <jack.wemmick@foxmail.com>
To: Trond Myklebust <trondmy@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	"jack.zhou" <jacketzc@outlook.com>
Subject: [PATCH] sunrpc/xs_read_stream: fix dead loop when xs_read_discard
Date: Mon, 26 Jan 2026 14:25:24 +0800
X-OQ-MSGID: <20260126062548.3417933-1-jack.wemmick@foxmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18463-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,outlook.com];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[foxmail.com];
	FROM_NEQ_ENVFROM(0.00)[jack.wemmick@foxmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[foxmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,foxmail.com:dkim]
X-Rspamd-Queue-Id: 81FF284893
X-Rspamd-Action: no action

From: "jack.zhou" <jacketzc@outlook.com>

Hi maintainers,

This bug was discovered during following scenario:

1. Using NFS client with TCP mode
2. RPC_REPLY process


Let's first review the normal process:

1. The `xs_read_stream` function is located within the for loop of the `xs_stream_data_receive` function. The condition for exiting is that the return value ret of the `xs_read_stream` method is < 0.
2. When entering the function `xs_read_stream`, since `transport->recv.len` == 0, `xs_read_stream_header` will be called first. Based on `transport->recv.calldir`, it decides whether to execute `RPC_CALL` or `RPC_REPLY`;(and also sets the value of `transport->recv.len`)
3. Since it is executing `RPC_REPLY`, the return value of the function `xs_read_stream_reply` is provided by tcp.c's `tcp_recvmsg`, indicating the size of the copied skb, and this value is > 0.
4. Since it is a normal process, it will reach the end of the function and return, which is: 
```
transport->recv.offset = 0;
transport->recv.len = 0;
return read;
```
5. The returned 'read' is the return value of the function 'xs_read_stream_reply' in the RPC_REPLY process. Since this value is > 0, the `xs_stream_data_receive` function's for loop cannot be exited.
6. After re-entering the xs_read_stream function, since transport->recv.len == 0, xs_read_stream_header will still be called.
7. Since the skb is empty, tcp.c's `tcp_recvmsg` will return a value < 0, usually -EAGAIN (-11).
8. Since the return value of xs_read_stream_header is < 0, the goto out_err statement will be executed.
9. The for loop of the xs_stream_data_receive function will be exited.
10. The next time xs_stream_data_receive is entered, the above steps will be repeated.


Now we are encountering an abnormal process:


1. For some reason, skb is contaminated, and `transport->recv.calldir` parses out an incorrect value, so `msg.msg_flags |= MSG_TRUNC`;(and also sets the value of transport->recv.len)
2. The `if (transport->recv.offset < transport->recv.len) {}` condition will be executed
3. The return value of function `xs_read_discard` is > 0, so when returning to the upstream `xs_stream_data_receive` function, the for loop cannot be exited
4. When entering xs_read_stream again, since transport->recv.len != 0, `xs_read_stream_header` will no longer be executed, which means `transport->recv.calldir` cannot be correctly set anymore
5. This is fatal for all subsequent RPC Replies because `transport->recv.calldir` cannot be correctly set anymore, so they will all go to `xs_read_discard`
6. At the same time, since transport->recv.len has not been reset to 0, this loop will become an infinite loop

Therefore, my approach is:

After reaching the point of `xs_read_discard` due to an abnormal situation, the value of `transport->recv.len` will be reset in the same way as a normal return, in order to prevent a deadlock from occurring.

The modification has been tested and passed in version 5.10.160.



---
 net/sunrpc/xprtsock.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 2e1fe6013361..91d1b992eb7f 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -695,6 +695,13 @@ xs_read_stream_reply(struct sock_xprt *transport, struct msghdr *msg, int flags)
 	return ret;
 }
 
+static void
+xs_stream_reset_recv(struct sock_xprt *transport)
+{
+	transport->recv.offset = 0;
+	transport->recv.len = 0;
+}
+
 static ssize_t
 xs_read_stream(struct sock_xprt *transport, int flags)
 {
@@ -740,8 +747,10 @@ xs_read_stream(struct sock_xprt *transport, int flags)
 		msg.msg_flags = 0;
 		ret = xs_read_discard(transport->sock, &msg, flags,
 				transport->recv.len - transport->recv.offset);
-		if (ret <= 0)
+		if (ret <= 0) {
+			xs_stream_reset_recv(transport);
 			goto out_err;
+		}
 		transport->recv.offset += ret;
 		read += ret;
 		if (transport->recv.offset != transport->recv.len)
@@ -751,8 +760,7 @@ xs_read_stream(struct sock_xprt *transport, int flags)
 		trace_xs_stream_read_request(transport);
 		transport->recv.copied = 0;
 	}
-	transport->recv.offset = 0;
-	transport->recv.len = 0;
+	xs_stream_reset_recv(transport);
 	return read;
 out_err:
 	return ret != 0 ? ret : -ESHUTDOWN;
-- 
2.51.0


