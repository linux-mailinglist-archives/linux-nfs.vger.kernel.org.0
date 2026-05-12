Return-Path: <linux-nfs+bounces-21542-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mP2UFgNwA2p15wEAu9opvQ
	(envelope-from <linux-nfs+bounces-21542-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:22:59 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A85527748
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2958311205B
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F67936C9C2;
	Tue, 12 May 2026 18:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4NIIxR9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C53136A378
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 18:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609642; cv=none; b=WwcqWZUySlFOkaPGsacEgH1zheDAuYeGZyK38PNe9ilnE3/gdk1og9OvyKBajuTylrmEGACFntgLHcqhvlAUwCIZ4twVmsHAVDAKKk+QN8vkhIm7hM4MG2kW/jKqIlh62ezjGBWXwQ3c1xHFCfKmY9oE3YkXUUQrqQtDqPZXZnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609642; c=relaxed/simple;
	bh=RdmRUEp0SaROgLSAvFDDr2PDqgNVZLzPjPgJ2c40GTk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eQwidKPClsJU31BlZsG+HuWYA27v/XP6F1CGcp9ZWiWCt5fgAm6n7d1bO0QK95JEj/UUPPnKkNZPEtpZHLqHVze95xGjmc99/uzZywvUHgduHsizjFKIRP9NVO5MyxvarBk7Jd0ERcWjPtxa1RifJ2nyc6/Rih0LmloJnCrQ1Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4NIIxR9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D828C2BCB0;
	Tue, 12 May 2026 18:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778609642;
	bh=RdmRUEp0SaROgLSAvFDDr2PDqgNVZLzPjPgJ2c40GTk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g4NIIxR94bVxTEAYbiYWxcOyUBXDmOiQ1MWrbrp/sWLA1kIBkEJvNCi7cnHTF+wqd
	 G/4eWePn/f3/CiWxwWun7CxOl+NCGleh12rTubAFptWmjXe4moUOYbOsCd5RXsS3CR
	 eEaQcLlKVjMUoUJM6X8k+4ZAgguUfDRTdrlwrDHh5XxxXIqlNs9LdzmhJdIG7YmJfX
	 EJoLAEKapclsRNisDdkg1h6y3iVBu5TV0G8dLkdYANgq54qtrOiY5p4jHXDpacufG3
	 brLRf95y2rOMp5TaTl2DLWH2worTz/yyC4i71FL3/H2Met7EDyn9BSKbZPbZ+3PXkz
	 rfpou3MchpcOQ==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 12 May 2026 14:13:37 -0400
Subject: [PATCH 02/38] lockd: Correct kernel-doc status descriptions for
 NLMv4 GRANTED
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-nlm4-xdrgen-v1-2-19d99b2634b4@oracle.com>
References: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
In-Reply-To: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=1945;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=rUPsx85q/MXDiKJypH36J2N6z0C7wkduFW5UXIoKzNw=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqA23jOIapApsKYtLrR1cNjLf1MAY0FZHhLe3zO
 L+NJLs62kGJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagNt4wAKCRAzarMzb2Z/
 l6d1EACzTdBOQmrE+/3NxXFEsKZovM13z0CEJiHQj1VAtex0bE8dPDi2nTMk9az7mwhtALsgvBr
 o7UyuL8Lzbn74eeoz12XxPGbvON3+jxJrPtwH6IvTUNvd7jlmVtCZBAAI0e9h+4NtwOPd6Ua4xK
 Mkyh4+v53MaSN7J7sP0Bu9PnrhwerH586LGaL5liVnAxNoyIfvINRcdRMOXvmE11CLqNI/tY9yj
 Tse+LE0Jyd868KehkY9xM0G9tlBCcOCYlvOwp38J+F2iNge54ezxpw8jcfvv0bI4D8N13ndgdBd
 x0DflenYkgJmoBPUt+SPGBlK67vjKXVT0YLdyn+IvfNYrtQMfYcK/NE0QfELlt00edIyKP3k3wo
 3lEAbumYvX5ubB6kTFR68cEG92Q81RzUytKIvfjU43QsaWnb3ef7rJYM9KeyzvGcL5iUGzUYGp5
 SRisnbSXYWc5zpIHVrYybDa9iKLpkY+4NKzJwwY3roYZzaH723//tx03v8CQLrKWH7sEbJxaCCF
 cIi5vZoBbS98dGYJ5vFBxZWS7/mON+B77D9yG7HoOa930m4eJ5p4w0EYglTVkZO23/c/ow35wDk
 ZEoTA+40kG6OLFcLzK1/wl8ocHbwNV0xEgSkT+/n55WyveqSonAWbt+xtvEcoGt+xS/UdRfPB36
 BxTlsmPCGMFKZhg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 05A85527748
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21542-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email,oracle.com:mid]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

NLM_GRANTED is a server-to-client callback; the local node
responds in the role of the client. The kernel-doc for
nlm4svc_proc_granted attributes NLM4_DENIED and
NLM4_DENIED_GRACE_PERIOD to "the server", but per the Open
Group XNFS specification the responder for this procedure is
the client host, and NLM4_DENIED_GRACE_PERIOD identifies the
client's own grace period after a reboot, not the server's.

Rewrite the descriptions to match the spec: NLM4_DENIED
reflects the generic internal-resource-constraint failure, and
NLM4_DENIED_GRACE_PERIOD attributes the grace period to the
client host that received the callback.

Fixes: 7a9f7c8f934e ("lockd: Use xdrgen XDR functions for the NLMv4 GRANTED procedure")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 41cab858de57..fc9ed4abb7ca 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -513,12 +513,12 @@ nlm4svc_proc_unlock(struct svc_rqst *rqstp)
  *   nlm4_res NLMPROC4_GRANTED(nlm4_testargs) = 5;
  *
  * Permissible procedure status codes:
- *   %NLM4_GRANTED:		The requested lock was granted.
- *   %NLM4_DENIED:		The server could not allocate the resources
- *				needed to process the request.
- *   %NLM4_DENIED_GRACE_PERIOD:	The server has recently restarted and is
- *				re-establishing existing locks, and is not
- *				yet ready to accept normal service requests.
+ *   %NLM4_GRANTED:		The granted lock was accepted.
+ *   %NLM4_DENIED:		The procedure failed, possibly due to
+ *				internal resource constraints.
+ *   %NLM4_DENIED_GRACE_PERIOD:	The client host recently restarted and
+ *				its NLM is re-establishing existing locks,
+ *				so it is not yet ready to accept callbacks.
  */
 static __be32
 nlm4svc_proc_granted(struct svc_rqst *rqstp)

-- 
2.54.0


