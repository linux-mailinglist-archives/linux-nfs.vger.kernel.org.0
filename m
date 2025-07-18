Return-Path: <linux-nfs+bounces-13145-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCDCB09D6F
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Jul 2025 10:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E064C3ADB82
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Jul 2025 08:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635D6292B54;
	Fri, 18 Jul 2025 08:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCTci22U"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CB1220F34;
	Fri, 18 Jul 2025 08:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752826309; cv=none; b=MBiwiIbHtSmMIRC9CE8yHd/ViTy7iDMI7wabbP0jNsCy/hmkspWJzSezYSGE9FNtQR5UvYKdQF8Tk6tZ54uRdcH83VVD6iIRXzRuC7AD2FOZsSeOSLDtCacTd33u519q2ntdL8grkebyUgOZQMDsdheVdLOnbhVg6BFhyr/6wgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752826309; c=relaxed/simple;
	bh=PeDcfKo7iOlIJb8z5qC+XxMNWd437UxeKUOi7eOo66U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KgTjgBof096rmZiVJUGmG0iAtfldMDw3QMV4WoQAzo0ZUFcYb9azOWdQ7xvB9BK5BxYULow0NBwXSpyrBjYOOt7/rGvO5fdE1Fyd6MztS4bf+cPH9FF11t7bPw/6tMT8LZCXhqTSyXd0sH112YZoH0+byP/IbbEfG6xyQ7tOm/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCTci22U; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5561c20e2d5so2389633e87.0;
        Fri, 18 Jul 2025 01:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752826305; x=1753431105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ySl4FDqEuj9CvHJtrc+pdmsbYRO+Kl0sE4pvpggh83k=;
        b=CCTci22UajDkqbiqofai46tOB2UdU0IxmRfytJE7WvmYPxqyyf6+YzBBveid6cN1eM
         +u7fzKH9HjeFVcr0R+9Oj7B055Wu9mp/BWvSVY30C3PJ2rdu28j5Zbw1TlbNBKE5XT5m
         iz9/LDmOSF1ggaDjLxhGRudo5cXc0Ro2SHsxo8sAV+1yUxzfQkUoMioG5PCt/YsirNPb
         VRnRmFrXhwFRpMl4eXE4uPc21gQA68U+Uq9orhpZ5pmZb7vxTgD1vdcnA65h7dco2DMA
         Y/5QfA0onFDeef8avpxE80wez+4r28JK8zGLJucVLM1TxR/ltRcwza7QSFQTLHumXUuj
         4MWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752826305; x=1753431105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ySl4FDqEuj9CvHJtrc+pdmsbYRO+Kl0sE4pvpggh83k=;
        b=usmlNJvN9C2SKOrQmQW61SppId0fXp0p+kKkA6/+LGcJkTiVU9VfKSK07cl4TYMQ6w
         Jb2UApBDZ4uVT//1Ev4Q5/8LO15l+bVO5sw2Ndue6k8IeOKMa+gBMRpFB0D6zHlBassG
         aSnkSkZN1CbaO7VhKoZXWtpJOZD1mp1gwadt84O7ZF4w5tP9QOW/WmlWinQQOe8aRq9R
         4u0vhBBIAU4r0DFQhITUjHnh+D9NmIHILR8/kXhLQg+2QInV6AKVHvj/x0VtZYbqz1wM
         11AnmQBwcSQh0CCzDTrxa1K0yRaLUUGehbdv9WP+VK6lLAwDd1rrOr2OIrCYXSke0Z6c
         Lh9g==
X-Forwarded-Encrypted: i=1; AJvYcCWco/BLmh0JNJ3d1oMzosSfloSPuXwKqsqfUPEBuGCwbnksIIiNXjLFdAU6IdsyeKexDqjQ6itQ@vger.kernel.org, AJvYcCXdFmKxPIANdRkhDo63o+vD0Wpk9fyQf/y6hcC9A1dw5GPVR0+tdQ8q+PFY41JE8/sm2ccLdRt7DY64dzc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd+PWA3cLzjcpKMAq5+DalO80C1zgGxf2KqXbTKqzDhQ4L5gAZ
	LzocOA5NE4QZSoHGrcfVMQnvu8PmBjip+cGHCsYRYm0V0qgU1e1tmYES
X-Gm-Gg: ASbGncv0SAOPkOrYw4wfK9qlpa0r/efxS4PZ6q52WG9VdYG0uxObkiSJPWXBF14Xzi8
	1fwMEAJhXrhrda0NpEuHV31a8iniKsT3P9VO7WOUVWm2xxywIwEAeEqu0oAqugTPi0rd0GBJxyt
	79hVxGkogzP2WBJYnop8tn1eLFBqbmzZwkv0dn6J4RXESBmyvtZYMMLO8VFHaFgxaQgg3eZuUJH
	eEABC8gx8d8/SdUNx6GWbU2rQ6lw7EZQhTbmW2Yt08Knc/njtaeUxtM5zak94ReOTIUBTm/zuV2
	gwiPX4ElNMoo3GC2YR0F1Z/+fvLt4hYngjxKv42l/rCl5eVxGvfNmlUtTDtRvECp71CzjVxfONr
	x9CGG94R258OcbC1V+HkiWle0+xix7lWI2eGSd3HXz2JRBeoX
X-Google-Smtp-Source: AGHT+IHgl/+8J3hm2QQjzTMqEUs3tG2qz4i0TsZtDxOTygUv08KcdIxik0KFZaTGm9O9R4HvAv7Otw==
X-Received: by 2002:a05:6512:3e26:b0:553:accf:d75 with SMTP id 2adb3069b0e04-55a3188f059mr408409e87.26.1752826304334;
        Fri, 18 Jul 2025 01:11:44 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([37.78.122.38])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31a9b1dfsm169921e87.43.2025.07.18.01.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 01:11:43 -0700 (PDT)
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Sergey Bashirov <sergeybashirov@gmail.com>
Subject: [PATCH v2] sunrpc: Change ret code of xdr_stream_decode_opaque_fixed
Date: Fri, 18 Jul 2025 11:09:56 +0300
Message-ID: <20250718080958.71913-1-sergeybashirov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the XDR field is fixed in size, the caller already knows how many
bytes were decoded, on success. Thus, xdr_stream_decode_opaque_fixed()
doesn't need to return that value. And, xdr_stream_decode_u32 and _u64
both return zero on success.

Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
---
Changes in v2:
 - Rebased on nfsd-next
 - Checks for negative return values are not touched

 include/linux/sunrpc/xdr.h                                    | 4 ++--
 .../xdrgen/templates/C/typedef/decoder/fixed_length_opaque.j2 | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index e3358c630ba18..ffb699a02b17d 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -730,7 +730,7 @@ xdr_stream_decode_u64(struct xdr_stream *xdr, __u64 *ptr)
  * @len: size of buffer pointed to by @ptr
  *
  * Return values:
- *   On success, returns size of object stored in @ptr
+ *   %0 on success
  *   %-EBADMSG on XDR buffer overflow
  */
 static inline ssize_t
@@ -741,7 +741,7 @@ xdr_stream_decode_opaque_fixed(struct xdr_stream *xdr, void *ptr, size_t len)
 	if (unlikely(!p))
 		return -EBADMSG;
 	xdr_decode_opaque_fixed(p, ptr, len);
-	return len;
+	return 0;
 }
 
 /**
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/fixed_length_opaque.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/fixed_length_opaque.j2
index 8b4ff08c49e5e..bdc7bd24ffb13 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/fixed_length_opaque.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/fixed_length_opaque.j2
@@ -13,5 +13,5 @@ xdrgen_decode_{{ name }}(struct xdr_stream *xdr, {{ classifier }}{{ name }} *ptr
 {% if annotate %}
 	/* (fixed-length opaque) */
 {% endif %}
-	return xdr_stream_decode_opaque_fixed(xdr, ptr, {{ size }}) >= 0;
+	return xdr_stream_decode_opaque_fixed(xdr, ptr, {{ size }}) == 0;
 };
-- 
2.43.0


