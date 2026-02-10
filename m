Return-Path: <linux-nfs+bounces-18835-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAD5Gddai2ljUAAAu9opvQ
	(envelope-from <linux-nfs+bounces-18835-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 17:20:39 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C355D11D0E6
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 17:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BBED302AD04
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 16:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D302E7BCC;
	Tue, 10 Feb 2026 16:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxJFLMiu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D45388844
	for <linux-nfs@vger.kernel.org>; Tue, 10 Feb 2026 16:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770740430; cv=none; b=gzYhPNUO9acWspwZSEyoU13nLjNmS6YD7MFFiu/BLimtfKzoIAfroavSGV6zQLufFVD+Hm03vmuVksR6+BwLUz4/BH7KvRWCpNPbakXiormw/OtA1o4qvxqIkCjJXNd9TtZqPGd0yYJRgx6YjWb9I5ODYhtla4oPPSUwf/KX7b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770740430; c=relaxed/simple;
	bh=aR/Hg1oS4LOcQgFFzrkZkhMymCUhM9WJep9kaynfOo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SxJJBnSXBCZpNHyoAPD742Vu6cl1QXzcbM2vicoV0hgBZ/j/9gIjepVtyeNqvtoMWvaeuuRDlqpI1IbQ2eT/ytvXK9PIGBQoOOYS/O8GuYGS65D6qldRSzGya0hMUJMt5PM6We3oyth+EukCFQ1WqDW0GL7b1t5yXL5Eljkrvog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxJFLMiu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB65C116C6;
	Tue, 10 Feb 2026 16:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770740429;
	bh=aR/Hg1oS4LOcQgFFzrkZkhMymCUhM9WJep9kaynfOo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TxJFLMiugxxM14r52KMiTyW4cK8nCuggZQkp1CMVY1IzCpUW1rfeRvrsykwz7t0fh
	 o2G8P1+qeZtOhqvKEmuEBKwNAJa9WN8jgv2cNuxc5Ori7m2d6UjWqm1DU25yuyLds/
	 ONHROOjpZSXEl4tEUe1+1vKyZihSRVZZejQNmCwMwJ18W7eZQTELWJzvWXwae5kBnX
	 vf2ZwWm3UgXcQFaNTJk7uNuY/v+mRwB+6bLBZfW6r9GT96nFMQpDR6vZldmKAJ4v1O
	 liZQ4pX+cVnvEF7MJCCUXcHN+nb0j23KHosxfWcLuhhTh585gl/pOj5EknxNiKKuGz
	 IitK236zUCKFw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 2/8] net: datagram: bypass usercopy checks for kernel iterators
Date: Tue, 10 Feb 2026 11:20:19 -0500
Message-ID: <20260210162025.2356389-3-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260210162025.2356389-1-cel@kernel.org>
References: <20260210162025.2356389-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	TAGGED_FROM(0.00)[bounces-18835-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C355D11D0E6
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Profiling NFSD under an iozone workload showed that hardened usercopy
checks consume roughly 1.3% of CPU in the TCP receive path. These
checks validate memory regions during copies, but provide no security
benefit when both source (skb data) and destination (kernel pages in
BVEC/KVEC iterators) reside in kernel address space.

Modify simple_copy_to_iter() and crc32c_and_copy_to_iter() to call
_copy_to_iter() directly when the destination is a kernel-only
iterator, bypassing the usercopy hardening validation. User-backed
iterators (ITER_UBUF, ITER_IOVEC) continue to use copy_to_iter() with
full validation.

This benefits kernel consumers of TCP receive such as NFSD (SUNRPC)
and NVMe-TCP, which use ITER_BVEC for their receive buffers.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/core/datagram.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/core/datagram.c b/net/core/datagram.c
index c285c6465923..df6b87d7c415 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -490,7 +490,10 @@ static size_t crc32c_and_copy_to_iter(const void *addr, size_t bytes,
 	u32 *crcp = _crcp;
 	size_t copied;
 
-	copied = copy_to_iter(addr, bytes, i);
+	if (user_backed_iter(i))
+		copied = copy_to_iter(addr, bytes, i);
+	else
+		copied = _copy_to_iter(addr, bytes, i);
 	*crcp = crc32c(*crcp, addr, copied);
 	return copied;
 }
@@ -515,10 +518,18 @@ int skb_copy_and_crc32c_datagram_iter(const struct sk_buff *skb, int offset,
 EXPORT_SYMBOL(skb_copy_and_crc32c_datagram_iter);
 #endif /* CONFIG_NET_CRC32C */
 
+/*
+ * For kernel-only iterators (BVEC, KVEC, etc.), bypass usercopy
+ * hardening checks. Both the source (skb data) and destination
+ * (kernel pages/buffers) are kernel memory, so the checks add
+ * overhead without security benefit.
+ */
 static size_t simple_copy_to_iter(const void *addr, size_t bytes,
 		void *data __always_unused, struct iov_iter *i)
 {
-	return copy_to_iter(addr, bytes, i);
+	if (user_backed_iter(i))
+		return copy_to_iter(addr, bytes, i);
+	return _copy_to_iter(addr, bytes, i);
 }
 
 /**
-- 
2.52.0


