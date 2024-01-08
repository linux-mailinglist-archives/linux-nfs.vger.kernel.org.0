Return-Path: <linux-nfs+bounces-974-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6661982772F
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jan 2024 19:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E9C01F23B47
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jan 2024 18:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED3755C3A;
	Mon,  8 Jan 2024 18:16:55 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F6B55E45;
	Mon,  8 Jan 2024 18:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5576ca4119cso2231972a12.2;
        Mon, 08 Jan 2024 10:16:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704737812; x=1705342612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTzYTutidL0Whyx/HW1wsoZHyuW9LFXWCdnU9bONfc4=;
        b=whkY2fGIqzBzNHecft4fwQgPXCIA5HWx/xItj7PJNOdcDFO1uqTQthtuKIn0LyKR2m
         c3Qi0g3xlKC6fYIapqbCs2XsdE0GUYeaihuWhZN6brXGNEuw6BlizdeBS37Flqkwz1u2
         MxqSbzzpwQmMdJJpO9Ik5JL3n/2thNwPw1jmYwOwM559gvLu90ANIqbPlfJjALur2CMW
         tvbGRn0ZG3gZJiaeoE0pwkKUtEim5IcjetyKolt/QEVi6EWgHIIq/nBUvhBGaY0fXZRb
         4PvXAFB+Fu4QtxM3dLIu4081BFQJb31H0Me99DraqJLAc6PPhxlsjJRfCkASuIBKaeFK
         nFCw==
X-Gm-Message-State: AOJu0Yy2KrxenwcF3hEky1VRTr1UERLO4si48TeEH2D0tHG+oDdEYLHG
	uUs0OjAAt93JQBN6t9jQd48=
X-Google-Smtp-Source: AGHT+IF+BMTgplG1+UG8AtzIzFGKv0MAbyvy4VOkQu7L5sm/YUC2sJGYQ/hknDKf26rPASy6MgFwzg==
X-Received: by 2002:a50:d75e:0:b0:557:b9c2:ce58 with SMTP id i30-20020a50d75e000000b00557b9c2ce58mr879280edj.69.1704737811875;
        Mon, 08 Jan 2024 10:16:51 -0800 (PST)
Received: from localhost (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id el10-20020a056402360a00b00557f54cceb6sm7126edb.4.2024.01.08.10.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 10:16:51 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: netdev@vger.kernel.org,
	Simo Sorce <simo@redhat.com>,
	linux-nfs@vger.kernel.org (open list:KERNEL NFSD, SUNRPC, AND LOCKD SERVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 05/10] net: fill in MODULE_DESCRIPTION()s for Sun RPC
Date: Mon,  8 Jan 2024 10:16:05 -0800
Message-Id: <20240108181610.2697017-6-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240108181610.2697017-1-leitao@debian.org>
References: <20240108181610.2697017-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to Sun RPC modules.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/sunrpc/auth_gss/auth_gss.c      | 1 +
 net/sunrpc/auth_gss/gss_krb5_mech.c | 1 +
 net/sunrpc/sunrpc_syms.c            | 1 +
 3 files changed, 3 insertions(+)

diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 1af71fbb0d80..c7af0220f82f 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -2280,6 +2280,7 @@ static void __exit exit_rpcsec_gss(void)
 }
 
 MODULE_ALIAS("rpc-auth-6");
+MODULE_DESCRIPTION("Sun RPC Kerberos RPCSEC_GSS client authentication");
 MODULE_LICENSE("GPL");
 module_param_named(expired_cred_retry_delay,
 		   gss_expired_cred_retry_delay,
diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index e31cfdf7eadc..64cff717c3d9 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -650,6 +650,7 @@ static void __exit cleanup_kerberos_module(void)
 	gss_mech_unregister(&gss_kerberos_mech);
 }
 
+MODULE_DESCRIPTION("Sun RPC Kerberos 5 module");
 MODULE_LICENSE("GPL");
 module_init(init_kerberos_module);
 module_exit(cleanup_kerberos_module);
diff --git a/net/sunrpc/sunrpc_syms.c b/net/sunrpc/sunrpc_syms.c
index 691c0000e9ea..bab6cab29405 100644
--- a/net/sunrpc/sunrpc_syms.c
+++ b/net/sunrpc/sunrpc_syms.c
@@ -148,6 +148,7 @@ cleanup_sunrpc(void)
 #endif
 	rcu_barrier(); /* Wait for completion of call_rcu()'s */
 }
+MODULE_DESCRIPTION("Sun RPC core");
 MODULE_LICENSE("GPL");
 fs_initcall(init_sunrpc); /* Ensure we're initialised before nfs */
 module_exit(cleanup_sunrpc);
-- 
2.39.3


