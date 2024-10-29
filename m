Return-Path: <linux-nfs+bounces-7558-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF619B52A9
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Oct 2024 20:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 732541F251D8
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Oct 2024 19:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785F62071EA;
	Tue, 29 Oct 2024 19:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOmX2+dS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B51206979;
	Tue, 29 Oct 2024 19:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730229719; cv=none; b=vAO68GRRhgtO8XrNn6aJrgzsKDF9MYfPmbUP8r6M5b0uzM2CGAcVIzUbBZ/nc3o3d+8XZYF7IU+GlYhHXopPn6Uiogdn/bR0NRe5IaWNXOMyKuo8uTfEjYG0hsd+LvTPMhIKAhIOOH+A6uMxORMpU4psbd32rBSleql751mr8vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730229719; c=relaxed/simple;
	bh=gQwj26AXbStfJzPa5fSOAVsCpDjxEpQ9CKNHrOAQ6sE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OMz2S6RzpEf3AfTBFxy/cy84OhLf+Fu/TBj7sFk2FlsVoi0j2CmGMp+EtdpVOGGNxwdon30NHwCmpkUYZnX9jFUoC2imbvzbcAgL3t+NgCofYfjv5aqJV06GAZ1Dz3X2QvQRtn7V3kAW//sE1FV/0GWIcRfoYIzZiADbZWO+zi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOmX2+dS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0581C4CECD;
	Tue, 29 Oct 2024 19:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730229718;
	bh=gQwj26AXbStfJzPa5fSOAVsCpDjxEpQ9CKNHrOAQ6sE=;
	h=From:Date:Subject:To:Cc:From;
	b=LOmX2+dSdZ3QX/j9g7pPQ/ZRO5t7Slg2xj3ERaBbrFwbwS7zZ2VXDLkZIyiezhXFE
	 dr81JBuTrMAKhj8CxRHWHcoLczebVeh7VAl4NjJTGj6v0RVhKdB3ijGddFbN+zDWXU
	 r4Xo6Z6ik18XTvbD0WhzKyXdj64AjwvGxQK13/hdsb49fSPZZLNNJT3cPiMzSSqCHA
	 fy1v7Jr9FcvRMM5Em1UXvYgZ+gn5v8VdiwI1R/lzU9EZHskDfDCk4OlIBjweTNI7Vl
	 4dGM/YlTGg/uhcjWuGY+ggNBWK+t+Fb/NaMwyaQrc1MYtMRXzxu3BC9qHtXjX9dKGW
	 Kq3FI0dth1GvA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 29 Oct 2024 15:21:43 -0400
Subject: [PATCH] sunrpc: remove newlines from tracepoints
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-tpfix-v1-1-19f69fcf915a@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMY1IWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDAyNL3ZKCtMwKXSNTo1TDNAtTo8RUEyWg2oKiVKAw2Jzo2NpaALqvNg9
 XAAAA
X-Change-ID: 20241029-tpfix-252e1f852ae4
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1426; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=gQwj26AXbStfJzPa5fSOAVsCpDjxEpQ9CKNHrOAQ6sE=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnITXPT/LqGoAQrhKGhjRnaJs5U8gY4kh+gfrUy
 h21JL6kRqeJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZyE1zwAKCRAADmhBGVaC
 FfghD/9u9kZzjdI8OJBMO79l1i9cgclz6/Z1/OmHbb7i2DfxOu2Jxw2cxeIE5fS+l+NAqvhFxaZ
 tXGPXmSCPknzwGHLGJFdWMyRKkN4hdfQy1vfTTmOaR1j3D4amf98bu9ssmS9jgiqz6fudqZ9J+e
 ep6KetyJwe1v0EVaap8pkdUcNSQau2j49CcxomQsLSGQp8Y9/dOOKVoOZlqIsTTDGsSaT3YeAxT
 cTywba2biOrJOuxX1RA1GV8BwqmLvkQAFAsBOf2uFHRiU3CRZ/zkN/cWE5OiaThpDXzkNj5z02D
 V5acD7eLJ6e+jw9rTti0oTDZRei4jvWLOodyXXo4fetNBg6YEwdsStXP0B9dbuVTl0UP6sQ9JwN
 PA5tXhOPY3wUKiQDsL64z0/dtVXGjhZ1v8WwZK56AsxwxTIuG/D1Dgsfu4zZ/GbkqMlTfhAlW7Q
 RbBFT5Uv5e3PVXK3zS3rlszcbNQ6Fsoxc5QxSmzYoQGj2c1KhgM1/xlVVCi4HLojsTAjAPCetc4
 O92mB3Uo7NDJt0nen/DZ4NEKjf0DEz/kOdt341GnK1R4Nf6lcUuoCr/3DHHZ3veltFKbgo3+eqa
 y2KqTWP124bYsKNhcA/Tf0G1nX/QF2Ic2y8mKzmKtHoSplzvjRXvxT6lbgRwIN0tgVDF8uzsYKR
 yaPd/HZ5HMcFyHg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Tracepoint strings don't require newlines (and in fact, they are
undesirable).

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/trace/events/sunrpc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 5e8495216689549f1c0bb377911eac4a7bb7b1a8..b13dc275ef4a79940a940dd463b7a3eef5ca428b 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -719,7 +719,7 @@ TRACE_EVENT(rpc_xdr_overflow,
 	),
 
 	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
-		  " %sv%d %s requested=%zu p=%p end=%p xdr=[%p,%zu]/%u/[%p,%zu]/%u\n",
+		  " %sv%d %s requested=%zu p=%p end=%p xdr=[%p,%zu]/%u/[%p,%zu]/%u",
 		__entry->task_id, __entry->client_id,
 		__get_str(progname), __entry->version, __get_str(procedure),
 		__entry->requested, __entry->p, __entry->end,
@@ -777,7 +777,7 @@ TRACE_EVENT(rpc_xdr_alignment,
 	),
 
 	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
-		  " %sv%d %s offset=%zu copied=%u xdr=[%p,%zu]/%u/[%p,%zu]/%u\n",
+		  " %sv%d %s offset=%zu copied=%u xdr=[%p,%zu]/%u/[%p,%zu]/%u",
 		__entry->task_id, __entry->client_id,
 		__get_str(progname), __entry->version, __get_str(procedure),
 		__entry->offset, __entry->copied,

---
base-commit: 9c9cb4242c49bbadd010e8f0a9e7daf4b392ff6b
change-id: 20241029-tpfix-252e1f852ae4

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


