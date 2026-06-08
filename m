Return-Path: <linux-nfs+bounces-22385-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FMM5CHAyJ2rTtAIAu9opvQ
	(envelope-from <linux-nfs+bounces-22385-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 08 Jun 2026 23:21:52 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D0465AA65
	for <lists+linux-nfs@lfdr.de>; Mon, 08 Jun 2026 23:21:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=runbox.com header.s=selector1 header.b="TvvOk6 f";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22385-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22385-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=gmail.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6D2F305B2C3
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jun 2026 21:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B0A3A6418;
	Mon,  8 Jun 2026 21:21:26 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FD63672BF;
	Mon,  8 Jun 2026 21:21:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780953686; cv=none; b=nrNepnP6TVAxouF5jcjjiWT6BEsgPistg7ro20E1/RHcVPt4ug+csJ3vxozBsMQxWFk0B+kN1Jh/v55ywxVTDG4MAo/fToty3qoPW7J5Qn6h6EESirJHQ2XtOhnITazXLPhk4fxUoH+aEW8RulyNmQ04iJxvY4gAX8yjPUs5Lxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780953686; c=relaxed/simple;
	bh=egWOoaaqXt1+UVcxIEhP1EitYptOww9/tWrFG0vvRD4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KC3mKgcfu3w1GKOAco/o/RnS27FO5/+SdrV3HsPMtUyBLYApIpILjIfAMb+REIffa7oVhmEUPzKdQW0GXcBg0JB3pYWT8VX9pto+kIyksyRQ5BFFkSOwHYWgvqRT9JhYMQWxpHQbEtxKeTLueNgeNNCYWnvI1+PIwOgnAptA8oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=TvvOk6f7; arc=none smtp.client-ip=185.226.149.38
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWhPA-00DHid-Pb; Mon, 08 Jun 2026 23:21:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=9AH+JyauRLTOH+85B17AQVXc5O2GdDHQvow28dcMLG4=; b=TvvOk6
	f7szFsQtmKotAJ6gVq1GRj29e8Q9rQKHL2DEtNtyvMh2p656fzoArOw/8nOPP9qhFys4NLrNfjCpb
	pGTzzjCzH50oCnVul8r+LjeKLuTIY60lKvI6YOC+q3hiEce3gcMPq8m05B0HfQRyD84UAenq4p+l4
	enTz+Sn+NCvVGfWYI1FTIvzOCtQq8OCCRc1qJH6KBf1GJv2Df6n6a8t/uUvjstFuDyO92sJ+iXEI7
	14PmztXzMINK7ca+Tx0pGZgzLNTgvJnoVgZzm4qVj/b6xF2A6fPtA42Cx3Kkqaqlec/T5U8h2niQn
	f9vdBUsMm8PNLAVQg3rlU+6o/G4Q==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWhP5-0000mA-0F; Mon, 08 Jun 2026 23:21:03 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wWhOw-00BdAe-5r;
	Mon, 08 Jun 2026 23:20:54 +0200
From: David Laight <david.laight.linux@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: David Laight <david.laight.linux@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 1/1] sunrpc: Use "%*phN" to dprintk() a cookie
Date: Mon,  8 Jun 2026 22:20:42 +0100
Message-Id: <20260608212042.25476-1-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[runbox.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-22385-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:david.laight.linux@gmail.com,m:geert+renesas@glider.be,m:andriy.shevchenko@linux.intel.com,m:davidlaightlinux@gmail.com,m:geert@glider.be,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,linux-nfs@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,glider.be,linux.intel.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[runbox.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,runbox.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B7D0465AA65

Simplifies the code and removes a 'not obviously bounded' strcpy().

Delete the local function nlmdbg_cookie2a() that did the equivalent.

There is no need to worry about cookie->len being more than
NLM_MAXCOOKIELEN (32), the buffer holding it is only that long.
The existing length checks must pre-date this code being added in 2.4.26.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---

Found by a local build that errors strcpy() unless a constant string
is being written into an array.

 fs/lockd/svclock.c | 42 +++++-------------------------------------
 1 file changed, 5 insertions(+), 37 deletions(-)

diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index b98b1d0ada35..bcf261078aba 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -47,40 +47,6 @@ static const struct rpc_call_ops nlmsvc_grant_ops;
 static LIST_HEAD(nlm_blocked);
 static DEFINE_SPINLOCK(nlm_blocked_lock);
 
-#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
-static const char *nlmdbg_cookie2a(const struct nlm_cookie *cookie)
-{
-	/*
-	 * We can get away with a static buffer because this is only called
-	 * from lockd, which is single-threaded.
-	 */
-	static char buf[2*NLM_MAXCOOKIELEN+1];
-	unsigned int i, len = sizeof(buf);
-	char *p = buf;
-
-	len--;	/* allow for trailing \0 */
-	if (len < 3)
-		return "???";
-	for (i = 0 ; i < cookie->len ; i++) {
-		if (len < 2) {
-			strcpy(p-3, "...");
-			break;
-		}
-		sprintf(p, "%02x", cookie->data[i]);
-		p += 2;
-		len -= 2;
-	}
-	*p = '\0';
-
-	return buf;
-}
-#else
-static inline const char *nlmdbg_cookie2a(const struct nlm_cookie *cookie)
-{
-	return "???";
-}
-#endif
-
 /*
  * Insert a blocked lock into the global list
  */
@@ -155,11 +121,12 @@ nlmsvc_lookup_block(struct nlm_file *file, struct nlm_lock *lock)
 	spin_lock(&nlm_blocked_lock);
 	list_for_each_entry(block, &nlm_blocked, b_list) {
 		fl = &block->b_call->a_args.lock.fl;
-		dprintk("lockd: check f=%p pd=%d %Ld-%Ld ty=%d cookie=%s\n",
+		dprintk("lockd: check f=%p pd=%d %Ld-%Ld ty=%d cookie=%*phN\n",
 				block->b_file, fl->c.flc_pid,
 				(long long)fl->fl_start,
 				(long long)fl->fl_end, fl->c.flc_type,
-				nlmdbg_cookie2a(&block->b_call->a_args.cookie));
+				block->b_call->a_args.cookie.len,
+				block->b_call->a_args.cookie.data);
 		if (block->b_file == file && nlm_compare_locks(fl, &lock->fl)) {
 			kref_get(&block->b_count);
 			spin_unlock(&nlm_blocked_lock);
@@ -198,7 +165,8 @@ nlmsvc_find_block(struct nlm_cookie *cookie)
 	return NULL;
 
 found:
-	dprintk("nlmsvc_find_block(%s): block=%p\n", nlmdbg_cookie2a(cookie), block);
+	dprintk("nlmsvc_find_block(%*phN): block=%p\n",
+		cookie->len, cookie->data, block);
 	kref_get(&block->b_count);
 	spin_unlock(&nlm_blocked_lock);
 	return block;
-- 
2.39.5


