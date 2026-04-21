Return-Path: <linux-nfs+bounces-20986-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAFsJLOh52nw+QEAu9opvQ
	(envelope-from <linux-nfs+bounces-20986-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2026 18:11:31 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C19743D2B9
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2026 18:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8AE563012B5B
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2026 16:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C73C3630B5;
	Tue, 21 Apr 2026 16:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvjv7bs2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A663624D4
	for <linux-nfs@vger.kernel.org>; Tue, 21 Apr 2026 16:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776787889; cv=none; b=o4nXaDe+FmTT8nhc9CiK7UrWmKjxoLP6aOpyEignF04zg6Mt6bDJlTHzrZfxuIFvW8dG8wMSaOmjqh2ZtDHxHy/D4zqHAwuEBLeYmVde5kbXbVCRG2WjfC/jRiXRhuJrldXziG8o0S4eO/qpnExj4cc2B3v3HeD7y06i/rfFWew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776787889; c=relaxed/simple;
	bh=BaniAXph7CffTX70ChAUOedVqP+TBR/6fUvPfOTPr6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XAQvEQ+ja8hc02YFplMRqhQiII/6PO0Yt1hcaRJ2v0t9W8UchWUJXKC13VDzHoxydbMgkOObwWxmIeTkLkQMhhNfQau1i+cm9LhAz7mtlf3Pm5XRV4QL5r341GWQdujcW3hqnO0RLoH9Rz4uWugWBFWLeu8XJShY5s5sQEHASrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvjv7bs2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0670CC2BCB0;
	Tue, 21 Apr 2026 16:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776787888;
	bh=BaniAXph7CffTX70ChAUOedVqP+TBR/6fUvPfOTPr6o=;
	h=From:To:Cc:Subject:Date:From;
	b=hvjv7bs2dhHJurlBVsWwQzjPgSap3qj4n8R3PH1+GOIcBGBnoDIxSP2UEo+ubCXF9
	 oofnioXeqwtEBYReZJRZN3G/y86L/nqsH/zD9YvFtfDyPB82QvGrF8djiFQcDcwvsw
	 jq99xgGaoYzrUfgTt2QvCs8AkZzPAUj3Mjx/uXPUK8UM9u7OHycmHX5uRFU8XyPrSa
	 b/R2VBCptFTrFw6Z+TAptwFWbhoWD1/wAKQd4z58FMK1lbwGtfrM7aYxp/MOXc3LKf
	 M8YHbZqAJ2hOqlvMTM8wIZCduI1JEV/wUo8hI9e+6D1CGQo7iSltm/+xPuf89NQaPM
	 viPdfPJaqjnTA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	syzbot+60cfa08822470bbebe44@syzkaller.appspotmail.com
Subject: [PATCH] sunrpc: prevent out-of-bounds read in __cache_seq_start()
Date: Tue, 21 Apr 2026 12:11:25 -0400
Message-ID: <20260421161126.129533-1-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20986-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-nfs,60cfa08822470bbebe44];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,syzkaller.appspot.com:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 2C19743D2B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

Commit 7b546bd89975 ("sunrpc/cache: improve RCU safety in
cache_list walking.") changed the tail of __cache_seq_start()
to unconditionally store

	*pos = ((long long)hash << 32) + 1

before returning, dropping a prior "hash >= cd->hash_size"
guard. When the while loop exits because every remaining
bucket was empty, hash equals cd->hash_size, so the stored
*pos is one position past the table's last valid bucket.
seq_read_iter() caches that index in m->index. A subsequent
pread(2) at the same file offset skips traverse() and hands
the stored index back to __cache_seq_start(), which decodes
hash = cd->hash_size and dereferences
cd->hash_table[cd->hash_size] -- one hlist_head past the end
of the kzalloc'd table.

KASAN reports an eight-byte slab-out-of-bounds read at the
tail of the 2048-byte hash_table allocation for the NFSD
export cache (EXPORT_HASHMAX * sizeof(struct hlist_head) ==
256 * 8).

Reject an input hash that is out of range before touching the
hash table. cache_seq_next() already bounds-checks its own
loop; the start routine needs to be symmetric.

Reported-by: syzbot+60cfa08822470bbebe44@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=60cfa08822470bbebe44
Fixes: 7b546bd89975 ("sunrpc/cache: improve RCU safety in cache_list walking.")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/cache.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 305c6e67f052..391037f15292 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -1352,6 +1352,9 @@ static void *__cache_seq_start(struct seq_file *m, loff_t *pos)
 	hash = n >> 32;
 	entry = n & ((1LL<<32) - 1);
 
+	if (hash >= cd->hash_size)
+		return NULL;
+
 	hlist_for_each_entry_rcu(ch, &cd->hash_table[hash], cache_list)
 		if (!entry--)
 			return ch;
-- 
2.53.0


