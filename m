Return-Path: <linux-nfs+bounces-14033-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8B7B43F32
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 16:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 985EE1CC2029
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 14:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5F130BBBE;
	Thu,  4 Sep 2025 14:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sp24E42H"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9055C3126CA
	for <linux-nfs@vger.kernel.org>; Thu,  4 Sep 2025 14:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996430; cv=none; b=S8WkAG38Uf+yZkggH9BBF6SD34rimK+ktG59Shv32WiHpPpHJWBBy0mNhid67Owqln44mV/22lCSP9rN4n3tSyheR1rdQhkxejWX9Qf4oXAhJfnV/QSmJrAgRfktlBpTKF2hRZ1dwrzbIn4SWF/PNc5h5Nu7qeHwqoFqWmyxzc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996430; c=relaxed/simple;
	bh=pcccCWqw7ViYaS9BqpJslpLMlQ4vXdmVKgF5xZQGF/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cbxpx7xMGXmdUlJFdbwaI0rwJbOkpYhz6J22047W6h11BDL68/S9gSvr2ocf8NDM590qtBPPuMxl+14ze2l9mbwfxD5K3Eo5PODoKuEBz15pva85mn2SfuTgcMS/08/pGZ6/PhS9QZI/2DlnHYYgke4SKQZnbJXwZPCgTfwjXjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sp24E42H; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7f722cb35fdso102811685a.3
        for <linux-nfs@vger.kernel.org>; Thu, 04 Sep 2025 07:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756996427; x=1757601227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsHQqeNPtnnyknUAqGKmRWyKybU2NR6w9m/VqDbURyI=;
        b=Sp24E42HRHqMsjs64etYyyJiky5k75h3tEla3Kw9RnGIxQkq23/uFKyb+oHElMncxL
         3X5PYM4djSK1lO9hzwpsFS2SyRGR2RHvhXihEeDGJOvcQE5ELi21v+lW5D/Jj98QLfQf
         5djWm8a+Iy7eAdxwrNoXulgxQVghG/nW/AwAHzYBsVbFH/RbnpjvHer+o5pbXbr2gwhc
         JKstOK1gqJwzmpILaxs65f947yOT6x8gHzHccNmxe0bS0FNmjjJf1MXMxaNJ3JIQPkOF
         57kELhzLwr2Hg1/+qT/uf+sB443/KnBnUUV3ubn4MDn2x+ZdMhwEIuZm+9MODodN/Z7M
         ejhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756996427; x=1757601227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TsHQqeNPtnnyknUAqGKmRWyKybU2NR6w9m/VqDbURyI=;
        b=h8T2DYZrNuIzwpG1hvHcxUdrWBUICvx2xq6tKZEaoW82/gKVi3n9jxCyPANNxfRNW0
         LjSwuL5+rP+/haZlny46AU4VtKpN/MEx5+klwszomJOmOQ1Onqtt081gbusDa1aL6pAE
         Qeu8Q5RcxCE1zSKWnJ+yYCjLf4ZutJ8bOr6xD7wrPtqpUaaDwWyAAzGoWXgNUWvlmX1g
         btgkLUhZ3Kn/+NWBm05TdtJ1vgPQi/JKMR7+6/roj4LKhAR3Beqdqt9IIi2JbDvy57TQ
         9M6FJhO141DiVxQqRY8uYAMnsJupfJR9D54iRG5VVXdBGb+ad0beMT0TG80wqBZnk0TJ
         N4Tw==
X-Gm-Message-State: AOJu0YzyPeN2YB/Tzu+RzqFk5d3mkxh9U9W6lhncwhKquQc8+BJ/kdPL
	4OFknQL7/4umVj9BzsDBfp8LVLXMoLmaMxamXyrGF53sM0BnkpIVip1kS8VIig==
X-Gm-Gg: ASbGncuBv/QZ8aEHiFWNy84NT+XidBah1bQEz7wM0pD0Dbe8TmjAYt43Mk/17g0OVYm
	gqhwnSVaS+sMn2LssLempNnC6k/QhMbZgu2K07KoXnD0sLpRq7XYQS1IaRo72CXFWLqwql6thAL
	ttbdCNyPwhlto6xDmXUdF8wThjKKLFpDh8wWtxtyJAjfiOcefx7cCxcDI6byBtAyy2WNXkeC63k
	b16XoKW4wAXj3n70R2tdgdPOOD/5syG2A+h/MKpF9COgEYrTrArEqdDGIMP/dTOs3njcDXWjN/5
	1Xhc6WdXUntVlN1YsNUHyfAR34Cr8NLtjhQc5P+iVd2M7CMJ9+6ycmugNe+tP4wMoLl4lZWzM54
	WciWE4vNj9F2TLEZfi/ntgpqiKmCjne5zPJp8M4GIFW8CSaX5e8I/wwjjDkA=
X-Google-Smtp-Source: AGHT+IE7ScihoPUE4/DI7Z9Olmf/j1j610jS+O4tLfSBwcCEyEtZYQmoqnvyKZ106YKVGBuHNfLWKw==
X-Received: by 2002:a05:620a:468e:b0:802:18ca:7032 with SMTP id af79cd13be357-80218ca7539mr1649801085a.83.1756996426699;
        Thu, 04 Sep 2025 07:33:46 -0700 (PDT)
Received: from justins-desktop.glenwood.vitti.io ([104.222.93.83])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-80aaac08a6fsm284299685a.40.2025.09.04.07.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 07:33:46 -0700 (PDT)
From: Justin Worrell <jworrell@gmail.com>
To: linux-nfs@vger.kernel.org
Cc: smayhew@redhat.com,
	trondmy@hammerspace.com,
	okorniev@redhat.com,
	Justin Worrell <jworrell@gmail.com>
Subject: [PATCH v2 1/1] call xs_sock_process_cmsg for all cmsg
Date: Thu,  4 Sep 2025 09:33:00 -0500
Message-ID: <20250904143302.34217-2-jworrell@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250904143302.34217-1-jworrell@gmail.com>
References: <aLirFyirQpRRW3qr@aion>
 <20250904143302.34217-1-jworrell@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


