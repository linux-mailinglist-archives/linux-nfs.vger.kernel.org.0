Return-Path: <linux-nfs+bounces-19716-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHFqIUnFp2mYjgAAu9opvQ
	(envelope-from <linux-nfs+bounces-19716-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Mar 2026 06:38:17 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D87ED1FAE6E
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Mar 2026 06:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD219303457C
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Mar 2026 05:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBB728690;
	Wed,  4 Mar 2026 05:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bgkmp1KD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901463101A0
	for <linux-nfs@vger.kernel.org>; Wed,  4 Mar 2026 05:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772602600; cv=none; b=L/HhH0dIL5HeQJcyjVaUUMHkhSuXOvmP7KvZCAWjOdSDZ3dvZemqiFvdJfShcU5qQcKQwYJ02tQXf12gr4kXEBbG6Zb0igQIO6CP5Sr1Lv4zFTbcwWT9IapmooVYUUyypj+Hx8ku+qhcnampGva0Q21DYjGCy1ki0xjsha0jlCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772602600; c=relaxed/simple;
	bh=Fh2w9GegkIjBGfvJYSj0dj5p+FWtLjoeXIvuAgbxRcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=REp+Fh1/zrvNSS4QKwHCidQUPwRbXcOP1HIKOqflp+3Fa3X7wxST2gSYsZSyO2yLYq0ar11A1GzXvUG9yNQ0TM7vHNyuGUySsFlmyMLUmWaPIBdpEl7iK1tKm/H5PcHHM19BHLH5/HCbx34AtNmMHmo+JeN4eqrKYN3h9dBHABI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bgkmp1KD; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3585ec417f6so2738615a91.1
        for <linux-nfs@vger.kernel.org>; Tue, 03 Mar 2026 21:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772602599; x=1773207399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXXONp/ELYPAk8Ra1lPAUCJk3t+/mDBCyOGivtl5sfY=;
        b=Bgkmp1KDJuaQ07bo2dOHwHZOm2eu5vU1YzXn/9rL4JC/Sx4E981uMZi6kt8Exs+Rj/
         vSgYNagHqeOkH/P5UwaYgWJfgofpOHD2XI4Xy7noH/grWbYE1n6lehuA9He6JCDDJe/K
         R2N6yIQPUS4frlqnd3TvNkNyD6Cd9pQkECBOF9DaRGytMm4s8pSjrlh5h2TTcuFg6iY/
         rWEjmbc8jlW9pzyJQDkp135gF96rVhRcU5eBbjkxOyl/fXDIjaoecrI4YL4kTMvpcadk
         wmKTZp5JMb0OBvGKrOOaJ0PPloxD/DT1S7E0HOwUqlAKUuYuwyrtgqhMuROneIkLqVwn
         0XjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772602599; x=1773207399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zXXONp/ELYPAk8Ra1lPAUCJk3t+/mDBCyOGivtl5sfY=;
        b=wPLnMzOxtMB9Ai4x5L93feQvimynfogNNYQpqGDOEyVwzsvqoKeRxgVdjDjdnrmETa
         DZOtgUomrZuOJ2ZlctrKZftwUlAU2CuKSwuYp4pQ4A7Z1rG+VwIlVL+atomT3idGSVTH
         fcxp1wGxkyrMrxFY7UAXTreLgk8tLVvC5tnAWvUIZrRpjmRY8hZc8l7tWmecdkRHojib
         sEdQNOlGyHKno5uT1Y4nLHwtEGKK8HaJ/Y3cxIUbZOSQBUNgMntsKtNtDh71BHsKykdT
         gd4o0EscQmIsJjpLI4feTNcqPPH5ag4wwoEThryWeRP8L2yOJUu2nPPOCy3QKqhsvX1Q
         oOaA==
X-Forwarded-Encrypted: i=1; AJvYcCW9GtsYNb3Gtk9F/SrndaX0D3OvyM3ty/yd5akQRtegUxUQy3zIoTmdw7UCDccPAGq8Wq/zYtk48MY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Bd+qLl+kWJwlhwrMMD+O4r1fpQPCiVeCHPMyYa2GkwMz34g0
	qTCebPHL+xJrN3rAiyeqOTy9GPJ8PI6RtAjDB1ZXy7AtCAVfCtzwuQEh
X-Gm-Gg: ATEYQzxE/7B21l6jMUbWu+h7EWTvWFMdgu/o6YgoRRz9bvS/ssuxadrFtP0IoG6YzMU
	HdUk5/5IHdGYnGd3xh8GGLoLHpvawqgS+wCMaUdbMcIIGbsQSm+Ui+XMw/8ce1hFeZNPu+qBpq0
	sncy1hrhjUhii6+YD/ztH+6aIp+ee76sne8/VVeCLPhKKeG2wTNQpm3fRw5Tb/OGMUTuhASohSX
	Ma1/d51mHnqG8bQvPcPyw4F4XZkpDNZFw9oJU6+BGCSkackKXNA8OoTFKVoRNED/LzMfE3n6rS/
	hyPWGzxne1LKd/6Oz3TIKQLJETs0JLNakOKbIZos1eWx+WFxQ4IIR237B26jpbfEc5YFBZF9Wlt
	COaFxtEgf2qe0H18lMVMawWb2WFk7bDw0cphT04Vom3lkntL34/l8axfijdtbStUq87NtN1UK8l
	S5QAyfa7QFYJb9HD1HDB0PD5k4AUF9eYlcuw7F9kzaKA==
X-Received: by 2002:a17:90a:ec87:b0:359:8a78:5696 with SMTP id 98e67ed59e1d1-359a6ce6a46mr960709a91.1.1772602599018;
        Tue, 03 Mar 2026 21:36:39 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c090bfdsm4020057a91.8.2026.03.03.21.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 21:36:38 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: chuck.lever@oracle.com,
	hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	hare@suse.de,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v7 2/5] net/handshake: Define handshake_req_keyupdate
Date: Wed,  4 Mar 2026 15:34:57 +1000
Message-ID: <20260304053500.590630-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304053500.590630-1-alistair.francis@wdc.com>
References: <20260304053500.590630-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D87ED1FAE6E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19716-lists,linux-nfs=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,lst.de,grimberg.me,nvidia.com,suse.de,gmail.com,wdc.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alistair23@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:email,wdc.com:mid,wdc.com:email]
X-Rspamd-Action: no action

From: Alistair Francis <alistair.francis@wdc.com>

Add a new handshake_req_keyupdate() function which is similar to the
existing handshake_req_submit().

The new handshake_req_keyupdate() does not add the request to the hash
table (unlike handshake_req_submit()) but instead uses the existing
request from the initial handshake.

During the initial handshake handshake_req_submit() will add the request
to the hash table. The request will not be removed from the hash table
unless the socket is closed (reference count hits zero).

After the initial handshake handshake_req_keyupdate() can be used to re-use
the existing request in the hash table to trigger a KeyUpdate with
userspace.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
v7:
 - No change
v6:
 - New patch

 net/handshake/handshake.h |  2 +
 net/handshake/request.c   | 97 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/net/handshake/handshake.h b/net/handshake/handshake.h
index a48163765a7a..04feacd1e21d 100644
--- a/net/handshake/handshake.h
+++ b/net/handshake/handshake.h
@@ -84,6 +84,8 @@ void handshake_req_hash_destroy(void);
 void *handshake_req_private(struct handshake_req *req);
 struct handshake_req *handshake_req_hash_lookup(struct sock *sk);
 struct handshake_req *handshake_req_next(struct handshake_net *hn, int class);
+int handshake_req_keyupdate(struct socket *sock, struct handshake_req *req,
+			 gfp_t flags);
 int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 			 gfp_t flags);
 void handshake_complete(struct handshake_req *req, unsigned int status,
diff --git a/net/handshake/request.c b/net/handshake/request.c
index 2829adbeb149..5653c8f69dce 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -196,6 +196,103 @@ struct handshake_req *handshake_req_next(struct handshake_net *hn, int class)
 }
 EXPORT_SYMBOL_IF_KUNIT(handshake_req_next);
 
+/**
+ * handshake_req_keyupdate - Submit a KeyUpdate request
+ * @sock: open socket on which to perform the handshake
+ * @req: handshake arguments, this must already be allocated and exist
+ * in the hash table, which happens as part of handshake_req_submit()
+ * @flags: memory allocation flags
+ *
+ * Return values:
+ *   %0: Request queued
+ *   %-EINVAL: Invalid argument
+ *   %-EBUSY: A handshake is already under way for this socket
+ *   %-ESRCH: No handshake agent is available
+ *   %-EFAULT: An initial handshake hasn't happened yet
+ *   %-EAGAIN: Too many pending handshake requests
+ *   %-ENOMEM: Failed to allocate memory
+ *   %-EMSGSIZE: Failed to construct notification message
+ *   %-EOPNOTSUPP: Handshake module not initialized
+ *
+ * A zero return value from handshake_req_submit() means that
+ * exactly one subsequent completion callback is guaranteed.
+ *
+ * A negative return value from handshake_req_submit() means that
+ * no completion callback will be done and that @req has been
+ * destroyed.
+ */
+int handshake_req_keyupdate(struct socket *sock, struct handshake_req *req,
+			    gfp_t flags)
+{
+	struct handshake_net *hn;
+	struct net *net;
+	struct handshake_req *req_lookup;
+	int ret;
+
+	if (!sock || !req || !sock->file) {
+		kfree(req);
+		return -EINVAL;
+	}
+
+	req->hr_sk = sock->sk;
+	if (!req->hr_sk) {
+		kfree(req);
+		return -EINVAL;
+	}
+	req->hr_odestruct = req->hr_sk->sk_destruct;
+	req->hr_sk->sk_destruct = handshake_sk_destruct;
+
+	ret = -EOPNOTSUPP;
+	net = sock_net(req->hr_sk);
+	hn = handshake_pernet(net);
+	if (!hn)
+		goto out_err;
+
+	ret = -EAGAIN;
+	if (READ_ONCE(hn->hn_pending) >= hn->hn_pending_max)
+		goto out_err;
+
+	spin_lock(&hn->hn_lock);
+	ret = -EOPNOTSUPP;
+	if (test_bit(HANDSHAKE_F_NET_DRAINING, &hn->hn_flags))
+		goto out_unlock;
+
+	ret = -EFAULT;
+	req_lookup = handshake_req_hash_lookup(sock->sk);
+	if (!req_lookup)
+		goto out_unlock;
+
+	ret = -EBUSY;
+	if (req_lookup != req)
+		goto out_unlock;
+	if (!__add_pending_locked(hn, req))
+		goto out_unlock;
+	spin_unlock(&hn->hn_lock);
+
+	test_and_clear_bit(HANDSHAKE_F_REQ_COMPLETED, &req->hr_flags);
+
+	ret = handshake_genl_notify(net, req->hr_proto, flags);
+	if (ret) {
+		trace_handshake_notify_err(net, req, req->hr_sk, ret);
+		if (remove_pending(hn, req))
+			goto out_err;
+	}
+
+	/* Prevent socket release while a handshake request is pending */
+	sock_hold(req->hr_sk);
+
+	trace_handshake_submit(net, req, req->hr_sk);
+	return 0;
+
+out_unlock:
+	spin_unlock(&hn->hn_lock);
+out_err:
+	trace_handshake_submit_err(net, req, req->hr_sk, ret);
+	handshake_req_destroy(req);
+	return ret;
+}
+EXPORT_SYMBOL(handshake_req_keyupdate);
+
 /**
  * handshake_req_submit - Submit a handshake request
  * @sock: open socket on which to perform the handshake
-- 
2.53.0


