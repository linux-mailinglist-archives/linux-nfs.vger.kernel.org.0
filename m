Return-Path: <linux-nfs+bounces-14051-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8EAB44830
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 23:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4E871C8357B
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 21:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE50277C98;
	Thu,  4 Sep 2025 21:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8l1kEue"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ACA226CFD
	for <linux-nfs@vger.kernel.org>; Thu,  4 Sep 2025 21:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757020342; cv=none; b=d2y1QSC8EKRHWEk04psu9ud7lGszf613UXCk9z9HJkVOWpqbMtsN78xK4WoyCIC1Q9GuXCcCdO7lyxVg+JpifQxhtfueFpjFWAkTCN7i26Dsh7wMfGG57JGT7Oz/xNBQsTS4KhlKimztdMy/J+Z/Kji/WhZM8R7hdrjdZVkuoWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757020342; c=relaxed/simple;
	bh=23q7fA/rK/K9Ww2hPXXiR1MHHaG+sGDIbw0Lt+8Na60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5kYU722lebP84heZotXuQI/aFUQ53xk91UjrH9TgxHmKOa1ipqyIfDe+akWvfA3Tf9mpWnwzRXxHFfbTzCps1/gPacGrhuy2gmUUE9Iji9A/Ro04XwZTfB5tNnkdfAN7FbrwPj289etTPxt3Fbtw2sq8rUaOFgmdE2tvkoqr00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8l1kEue; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7f7742e71c6so137858185a.1
        for <linux-nfs@vger.kernel.org>; Thu, 04 Sep 2025 14:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757020339; x=1757625139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+QxsPwy3tJCOfR9zjBBDPBB2vgWqnPUnorKyHu8e2k=;
        b=X8l1kEueGj9xxCE6Xm+kMnMK/8rrfhzeJPJIuIpGw8BkgzEMHT33I+V3z0eHaOcqWt
         Sur4hiFcuRKRfS8XtQaGaEJPThfFMNeELUiNBB1kBw9491A+wG3lVnnAYb669YqQE0eG
         X9yBFqm1EHVMdBI/6Xv/y3b6WKr4iGJCjOUu/FFT7blVqTEL29ynIsMkjaqkW/IHZ7l4
         ArxgecOaHEFutb53dimeSqKlMDRhAYWo9JW1BPtlIzBwsrPnPIzqaySrNiJvwgqwqQcu
         ZjaRHJkFhVsyhOTOpfYeSKM00SOATyKURu4CnAvJgdPY7483vY5igfopGckyHXGILp9J
         fXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757020339; x=1757625139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S+QxsPwy3tJCOfR9zjBBDPBB2vgWqnPUnorKyHu8e2k=;
        b=RjAj/IvqsnC9ogbjvYJfveP6GKK4WUC7c2tcYiErVxmmwNeBWPHG041mAqRk1nAloq
         GTFHeTHBEZ0p/xtlPmvSkouD3w15RhcIBPCM22bPDDPi4PNPObhhg8HhtTzGYxkQFrQC
         9hG0WfTGaqiIogvsiIMkV69W4Sy/uO0jVEUDtIqao0Bf+UzWQPRDG74SGUB3Rmp3c/ou
         MNPaW6FHhqC9SK3AGxJeJGI/Eq7+YN58+ML1szWM1s0ClBKkqykL6JTGDiRczSK1jR8V
         oPOsEE19VFJe7h8gtMMmeN8XnH9ifbdVMP7YeSZ/iTUI2PKXdegGmPg4bQf6dJlifRZc
         vtig==
X-Gm-Message-State: AOJu0YwxcPzNCq+M85igjRfWWb7cykpxv40KVb7o0FoEWp3UuWRu9MVX
	EUgsgc1GDxCZ5vGYx1C7YJNLL6hVnjAxCUPmVUiF3LSnlgYcyU5ur3ai/PM5xA==
X-Gm-Gg: ASbGnctwX/z+IjOp9Gq3GzEOkzzJVUGsP4lrlG+O4wPPmOwrtVflSuO8m/9nVWJ506H
	aJvH23CN/D3PYkFjqx84oU2YH/SEkfvjFEVcLVAiJySVPnzAWOIM/ijUKy+WmssalZPonmfdRtL
	HfyZ0pDRVaC5jnloJky6xGrs96lHcqx1AiD2zfPLNlECUiZhBTp1fIn4d4jynQdwx1TWlAjH1/V
	oRfZX/G+hmSUWsq9qLYQxP9XQmaHtyV/IV3kY+PdNAi8vsUNq5c/NY2K5NmEobAR/GFjVQkuTVy
	vAvnMduegs4gzyFCMTgsq73KZnYJf6hjbrTq8TEb0sOWOVm4B8cn5gVR6SNORRCr5xY8k+nNy5B
	riNkAvYY/2Fx69EzCSpzDziiLw0RaLxBzXUMNzUfr09OVZuPthWtXTZygtxo=
X-Google-Smtp-Source: AGHT+IGkNKuhE3qWWC3Vpfibvoa2q3GYH4J7dx1YZGnWYvlibXepr8bb4Ne+6B7ek/47IhTiigW7gA==
X-Received: by 2002:a05:620a:1a81:b0:7e8:14c:d1a9 with SMTP id af79cd13be357-7ff27b20216mr2448792685a.28.1757020339017;
        Thu, 04 Sep 2025 14:12:19 -0700 (PDT)
Received: from justins-desktop.glenwood.vitti.io ([104.222.93.83])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-80aaacfefabsm344249485a.32.2025.09.04.14.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 14:12:18 -0700 (PDT)
From: Justin Worrell <jworrell@gmail.com>
To: linux-nfs@vger.kernel.org
Cc: smayhew@redhat.com,
	trondmy@hammerspace.com,
	okorniev@redhat.com,
	Justin Worrell <jworrell@gmail.com>
Subject: [PATCH v3] call xs_sock_process_cmsg for all cmsg
Date: Thu,  4 Sep 2025 16:09:57 -0500
Message-ID: <20250904211038.12874-3-jworrell@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <aLnIYv3VcdKKvOEj@aion>
References: <aLnIYv3VcdKKvOEj@aion>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only v3 change is adding description, signed-off-by, and reviewed-and-tested-by.

xs_sock_recv_cmsg was failing to call xs_sock_process_cmsg for any cmsg type other than TLS_RECORD_TYPE_ALERT (TLS_RECORD_TYPE_DATA, and other values not handled.) Based on my reading of the previous commit (cc5d5908: sunrpc: fix client side handling of tls alerts), it looks like only iov_iter_revert should be conditional on TLS_RECORD_TYPE_ALERT (but that other cmsg types should still call xs_sock_process_cmsg). On my machine, I was unable to connect (over mtls) to an NFS share hosted on FreeBSD. With this patch applied, I am able to mount the share again.

Fixes: cc5d59081fa2 ("sunrpc: fix client side handling of tls alerts")
Signed-off-by: Justin Worrell <jworrell@gmail.com>
Reviewed-and-tested-by: Scott Mayhew <smayhew@redhat.com>
---
 net/sunrpc/xprtsock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index c5f7bbf5775f..3aa987e7f072 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -407,9 +407,9 @@ xs_sock_recv_cmsg(struct socket *sock, unsigned int *msg_flags, int flags)
 	iov_iter_kvec(&msg.msg_iter, ITER_DEST, &alert_kvec, 1,
 		      alert_kvec.iov_len);
 	ret = sock_recvmsg(sock, &msg, flags);
-	if (ret > 0 &&
-	    tls_get_record_type(sock->sk, &u.cmsg) == TLS_RECORD_TYPE_ALERT) {
-		iov_iter_revert(&msg.msg_iter, ret);
+	if (ret > 0) {
+		if (tls_get_record_type(sock->sk, &u.cmsg) == TLS_RECORD_TYPE_ALERT)
+			iov_iter_revert(&msg.msg_iter, ret);
 		ret = xs_sock_process_cmsg(sock, &msg, msg_flags, &u.cmsg,
 					   -EAGAIN);
 	}
-- 
2.51.0


