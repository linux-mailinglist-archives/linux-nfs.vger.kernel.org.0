Return-Path: <linux-nfs+bounces-3218-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C60D18C0E6C
	for <lists+linux-nfs@lfdr.de>; Thu,  9 May 2024 12:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 546FC1F21409
	for <lists+linux-nfs@lfdr.de>; Thu,  9 May 2024 10:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0167912FB1B;
	Thu,  9 May 2024 10:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kSLMi02n"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492A912EBC8
	for <linux-nfs@vger.kernel.org>; Thu,  9 May 2024 10:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715251692; cv=none; b=q7B9aBWMJmSxetfMDfyDiahPw5Q7V/RUk2IWtF37tGvimV7iNxazx4dLH24X8aHj2f31o/1BpFeXN+/8s16BtUEnWU6IZ/AzaTfwmePg74K3oCDlsn2koQBq2f8Dr3e/uqzDy58o9XUrrVxutDZx4SXjAGKtQ7ff/TZ8dnXqp5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715251692; c=relaxed/simple;
	bh=EAmmvUuXUCvQhVJyhOjnloUwsHV7hU6+Z0N6I4QkxKY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tSH26XW/Ij2XkUlP5M6k1CMakLZTFTlHfrdNDAs7Gkpfc9tOKYlxT5VxAssCcE2AuLs2A07mWisPD/ugooA02BKr+u1KGd+33duqmxxutH0loInZewZlxH8QvvysbGdUTEe+87EsCqBJqQgfh06j8iMMsssntYVmLnRTDG0X1m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kSLMi02n; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59b49162aeso164308466b.3
        for <linux-nfs@vger.kernel.org>; Thu, 09 May 2024 03:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715251689; x=1715856489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7qlZtZk75coxcr32t+mJEdsIgCn5e7In21AxtT9MXDc=;
        b=kSLMi02n7NAwcdlaLMJ0lWD8/Lr9jOYvdvnDDWEf81jzisupG21zC9AkK5LJaqkxN2
         JW2TI3pXpHNn4cjfssxNLaMT4cG5MBBaoTt1moRnFdLvyvfv1DlpbMLvlRI2TlR8Qw5d
         nBYzg7wKRoPcj2WHksU0Jlu0uoyeyNKSIjZ9zJ2W+HUA2nmp7sanhS90PPQ2Ytyr+0ht
         ug00jlRzAvhVDCnbnaQYo8LtvY2Rx+ellXzC4bA4JbI8Pj3aAeKBamB8bQsT68cxOvJX
         eiq1bPp9QMECb+BGC9TTnBNZW3JpVqLMUhs05KT49HwsCyhYlyLunA5uKsuGO+UVjKEm
         HFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715251689; x=1715856489;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7qlZtZk75coxcr32t+mJEdsIgCn5e7In21AxtT9MXDc=;
        b=OcSI02w6jkgutkJlfQUOiJNqhUUKwHInzOSAKmVd5sydvGs2QMb+TZHykXkV0qJk0w
         te9tB+5Kq9MAa1q8puE8mMpHPZkXB91Mi6iQ82APQhy6ftGxPY9VpYUAU/fCGXeX5nMD
         pMAXEuHEsDlGnmiGMB4uJsUPpnEnY42CA+GDD1yF9seRMMf4Xw7fZ23jGruM73IA7DaH
         jp6fJfSncfWcx3LMg19dLoq4tAmNj25rFkUOpqY9ZXKMzkS0U0De0BkgWs+eM6DScYVl
         Rcq006DdJ5QbGs5MpNl7xAUgvgqCl8ZLJfG7+KQ4dJqpxLt/OgghFicutC1wiI8aJ4uD
         b/cA==
X-Forwarded-Encrypted: i=1; AJvYcCV5jHDRngIhO7jt4Sq3Ro33fqtcoLEwBXrVNzkrWRJrCjEpGI4npYWtuxD3GD/FbmhR8CElLt4qli+HxRG8ILO8MDaFAkpxPbFG
X-Gm-Message-State: AOJu0YwEaehtUuUKmykYH7slbSQGe7oVRG2tKxtHV5FZK7O6YVFokS3d
	1QM4x6E6QJ1el84LfzzIq/2SOp7Nb2d4Stj64NOchmGs98C4wQ/Lj+C26rRGJ+I=
X-Google-Smtp-Source: AGHT+IGOSEuA2npGO9GewqwIXTPylXogor9RcnRiDhrr39n3ApUuc/Uzk7+5WHH+SNpvw9TtEXjwgA==
X-Received: by 2002:a50:d595:0:b0:572:a7ec:1a5f with SMTP id 4fb4d7f45d1cf-5731d9f1eb8mr3880773a12.24.1715251689505;
        Thu, 09 May 2024 03:48:09 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bfe2dd1sm572297a12.58.2024.05.09.03.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 03:48:09 -0700 (PDT)
Date: Thu, 9 May 2024 13:48:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Trond Myklebust <Trond.Myklebust@netapp.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 1/2] SUNRPC: prevent integer overflow in XDR_QUADLEN()
Message-ID: <bbf929d6-18d2-4b7e-a660-a19460af0a3c@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <332d1149-988e-4ece-8aef-1e3fb8bf8af4@moroto.mountain>
X-Mailer: git-send-email haha only kidding

The "l + 3" addition can have integer overflow on 32 bit systems
when it is used in __xdr_inline_decode().  The overflowed value
would be zero and the check "nwords > xdr->nwords" would not work
as intended.

Fixes: ba8e452a4fe6 ("SUNRPC: Add a helper function xdr_inline_peek")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 include/linux/sunrpc/xdr.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 2f8dc47f1eb0..585059f2afca 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -14,6 +14,7 @@
 #include <linux/uio.h>
 #include <asm/byteorder.h>
 #include <asm/unaligned.h>
+#include <linux/overflow.h>
 #include <linux/scatterlist.h>
 
 struct bio_vec;
@@ -29,7 +30,7 @@ struct rpc_rqst;
 /*
  * Buffer adjustment
  */
-#define XDR_QUADLEN(l)		(((l) + 3) >> 2)
+#define XDR_QUADLEN(l)		(size_add(l, 3) >> 2)
 
 /*
  * Generic opaque `network object.'
-- 
2.43.0


