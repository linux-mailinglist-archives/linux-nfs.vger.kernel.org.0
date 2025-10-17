Return-Path: <linux-nfs+bounces-15315-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D80EBE64A6
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Oct 2025 06:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7955B4EB381
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Oct 2025 04:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C4430C601;
	Fri, 17 Oct 2025 04:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TA3KMUJZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAF430F7E0
	for <linux-nfs@vger.kernel.org>; Fri, 17 Oct 2025 04:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760675032; cv=none; b=XTUg2m6ytWvJXMgsXQtLMYEJMKuPBZnB68unsCbwVeMy3KoxyvwIUIuUJ2TY5J26//MDeIAACmLvOxg1PhW2SzSnqaKvYXCz7JYpcguNwX5f27L8qC8svbkl24GPka0kCS6u62LlT7YsZMtShp6d7jK90EnhamQstge6Mns1XL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760675032; c=relaxed/simple;
	bh=qJIYSnU+HoRbvlx3ywhGBF4rw4sM63dPw5pKUX1ZIk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EXx1yqbXzB7J9Y41VW9gfckLOqsN9xgcXcwaZKoylrNsWvmD9PAcJeugShpkg/Q+t6SNsgbi9GGyK/4zfjt2ND7NZRhoTYQnLsoCAWx42fLugiY1YKDBPpvmf9tE/prs5Ssgmhol8P5QWqg0JgQkRPWS8E50/+lZL5vVUYAUYWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TA3KMUJZ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33bbc4e81dfso1387135a91.1
        for <linux-nfs@vger.kernel.org>; Thu, 16 Oct 2025 21:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760675030; x=1761279830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAkZgFdLzvs8Exsdja0IC6onWedwrzXxt2HCf6MfZEs=;
        b=TA3KMUJZ3wdXrdHBGXOHDBRRCFsBGRv825EEWg5FMuQd7150NIItSQ0LksJfiXg9Jo
         z6eIrJH5vbhC3GhhETfjYPPVLb4kEfQS8GgDmWRGg534bRmpCsnZqN4g/Ux/PMul3vx0
         FGYHP1nfR6iMgK+IclnXv36uI6ruWqpaFHHXD2ndkI2ehG5l00snqaKwNrkRHnPhsYpl
         xgJdS8h+F/M5B/CXFLDZwAc+bfVHan1bWWltCsaSlC5KCgXY9XAoQ3qh7FIgRvwfiEc7
         rY/8z8JRA2oPBVOv57dPYHztfpn8MNnkfBU/KL4ZLnu1u9NQ9siG/q59po+ThuoSmTEC
         sG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760675030; x=1761279830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kAkZgFdLzvs8Exsdja0IC6onWedwrzXxt2HCf6MfZEs=;
        b=j5fmYOE7FAJlPEthQeay8Sf4f0aJpzvmfIHmEvt2RP5iDrfEKV9linDdllJYKP51XW
         SSyViqgV+5iqQuaWbO+dheeruZWx5Z/AwxeqM02mOzpbKu+2cUVJfFfSyyUly/Lz2Rmq
         3NCkIP5XzsTrg0q+z5wgwATuqT0VWBhIrL8ddOCceKpF7J73OJPRY/s7KdA3PJ0jHFqz
         tDKA9QDPkNPCEpbJeC+mtMnPkRGjCgjwgpzVwyGLpokVLRvgdymE7y7Dp58YiGeI7DFG
         1wc4rkbecbLstb61c4OdVJJfAEhDXDArqmoTC9srjmhV+WfNw4/IereD6+KiunzRVP+6
         SgZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2wMT0FSA9Bh5LLZdr6K53sfzzjQQ1iFX163o2B7FFpeFfR9vu88ghU+UwDg7bxPmhUG/0OyXtFMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNc8i7FfsKepeQhPvnXC4Nr3zwi9rxXBprNfOB0Peu+OmVLPmr
	AzO1mR/OamUg/nXXvpIk/lA0FDBccKdRBUlOgLQPkWj8WBL8pwfQIlt7
X-Gm-Gg: ASbGnctvwR6TD+W2zqT8EMvYFJXny0CY8yj0dVZAojc19jne7Fu4D1klXmveicyGtHi
	Q7s3/8QpYiv0ou9+dXemuuz2a3FPXvZzYhMV6yFHk/yNcOjtBeGVDPBK/vBkOHiH6D2CS2hknyQ
	iSBtrej9sEKrtIut3grxrVrj7tW0OHX4F37PA+ueE7i5hhKnQGRgljQHocMb8cibMi0gkTvcG02
	59E35GqAF1421seNz743l5uHPpzyN1o+Nd4oPRyOaKF7vvQd+y4nF1Hj14RAFwv08ubLomtcLR/
	5sMfRY5SAqL970/1G1mGWA6xlnV1uCQsEeN/c5H8Kut5NGwLFAzsVK2NXbnU4u2BAxYfOrcwFV2
	mOSJ2htVyILENSrn63+6bCwGS6dF+BU6wwg2Szv0XPWS1+duSCX5LeVVgT5Jcd1wlk/U2rCiixK
	102FBh5Z5B39YZzG/CJNKjM5WeidOWXOnVAuDma0YKBG2KFEyfNBvuGafWt91ay+s2mxsM70MOg
	3EmygE0d66GtJR6c5jU
X-Google-Smtp-Source: AGHT+IFfbNX2mTod+6zKsy5GzuQyZpJ35ah75bJLjAVf3giPURvKPzSrUXNdaNKl89D52wOXFUj7ww==
X-Received: by 2002:a17:90b:2ccc:b0:33b:c9b6:1cd with SMTP id 98e67ed59e1d1-33bcf8fa1fcmr2615932a91.19.1760675030324;
        Thu, 16 Oct 2025 21:23:50 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33be54cad3esm245557a91.12.2025.10.16.21.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 21:23:49 -0700 (PDT)
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
Subject: [PATCH v4 3/7] net/handshake: Ensure the request is destructed on completion
Date: Fri, 17 Oct 2025 14:23:08 +1000
Message-ID: <20251017042312.1271322-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017042312.1271322-1-alistair.francis@wdc.com>
References: <20251017042312.1271322-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

To avoid future handshake_req_hash_add() calls failing with EEXIST when
performing a KeyUpdate let's make sure the old request is destructed
as part of the completion.

Until now a handshake would only be destroyed on a failure or when a
sock is freed (via the sk_destruct function pointer).
handshake_complete() is only called on errors, not a successful
handshake so it doesn't remove the request.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
v4:
 - Improve description in commit message
v3:
 - New patch

 net/handshake/request.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/handshake/request.c b/net/handshake/request.c
index 0d1c91c80478..194725a8aaca 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -311,6 +311,8 @@ void handshake_complete(struct handshake_req *req, unsigned int status,
 		/* Handshake request is no longer pending */
 		sock_put(sk);
 	}
+
+	handshake_sk_destruct_req(sk);
 }
 EXPORT_SYMBOL_IF_KUNIT(handshake_complete);
 
-- 
2.51.0


