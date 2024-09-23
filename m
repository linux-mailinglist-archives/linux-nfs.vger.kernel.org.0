Return-Path: <linux-nfs+bounces-6619-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B64F297F1D0
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Sep 2024 22:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54887282913
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Sep 2024 20:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5F9770FD;
	Mon, 23 Sep 2024 20:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k83CYbry"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0553B8C06;
	Mon, 23 Sep 2024 20:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727125050; cv=none; b=FgJBB+NbR+isHpRbvz8WsecIhhuY0DzvKro1PqsiGh7SakBkn90WEMAt1tYAqRoQFLpLMo78dkv4souMDQ7gBNYBsz5zbbvuuxRmE/HLwm1GoUK4vabzfnhLPhyiC+gLb7yM33/mIWfe8ZZB7/QsS+jOt6XnH1AUo9ZuZnSis+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727125050; c=relaxed/simple;
	bh=1rbLgj0nXxiDnUlApLjxVsJoEy+kGptOdgB947HjKyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YBFPqi+0B/VCUj+qVTWbBI82C5CQM+iwYzoUCnP8O/bsztP+IeTYgVK6aIdL3UaWcw2KodFa91VhPcl17B54YeAtqIAo4LwnDP/nD1GItWe7WTJztfkD5mi+k+iRxHBhzOhoCVDEzX0DV3V1CFsBE6vMn5+zfolJqRD0vsIj+a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k83CYbry; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-374ba74e9b6so3960090f8f.0;
        Mon, 23 Sep 2024 13:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727125047; x=1727729847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mCGay+ux/isYrKjVJrEaEY3rQ4NkeGWnKhmqM2Kr0wo=;
        b=k83CYbrytGCcivu5BpCbGgSN7DO+994tI/HAdSYvBy0KlEqzBOLoQhnXRHsbU7zIiq
         mZ5Q0ngE99S3nHKrkUVrDhvA+PuO/TJPpIaK6fo6EB1PINghIAVKA9nCZwJ+lZMtokqT
         I+bLvO9LDBTyiPDMtla1CqmFfePVwOUV6fDqO28ngK0jRW1S1mW13mgT83XqYuEjcarW
         KLYq1HTPnOmQGKRfwIIX7pC9+czAvFiB8ixV25KeWkiX2ayZVTfjIJZtx2IJPYqkd5S+
         cDngPDA6ayt5l3KakonnYhqeWWlwTYH75S8ap+SNRTnE5X9Y3DG3+83GAMzBY5cPVJ6a
         4Hww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727125047; x=1727729847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mCGay+ux/isYrKjVJrEaEY3rQ4NkeGWnKhmqM2Kr0wo=;
        b=BK5QEf+F7v6P6Rs+i1Ia6ioLLU9PzS3dLydRMkgr8O0auYmCnJ9oHt6eftootHcaZ1
         bQdymX7X+0WuEjbGJfbubXZRuLPoKmUuMiPQjZCMh1lRfz0eSaUb8++4XoGz+PUS4JUQ
         21S0QGnEp5liNu1fLO2+rrUgh/84BVw3osOIQl9UM/7evyse6771VLwQdr0ESM3eKDmj
         mLFH4ZegI7qOpnDeXy/ONxrcxaocKx2Z51S8bX/dQMLftWriuRVr+n4vYZfgVkM0jLLe
         7Xzo5VTcmQ054a7zC0OsUPwQ7Hj9rRHy8D1238vTpNV50ppEkcLnikhmGty5fCWOaJHZ
         TgVA==
X-Forwarded-Encrypted: i=1; AJvYcCUrrUrQ+UjEC0gNaW/FfVCQ2dNKQtY2cL4Z7kvymnPVQQehr9pyZNJYfCl7yg699UDef+FgoETf@vger.kernel.org, AJvYcCXvBepRlDHeQOrnNZ3In5KCo2Qgt6PMFulwaGty0dGZotm6vjsxQjW9PDdmmHcEyJhSqcE3J+va2G/0cZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFbxz6QN5wRUKhj7dFohyzrjb75oZ1wz3GFTLur2r1CFnyfd45
	qeeKvD1gAmgXLykxAbVTwLGWdHXLz/CcDncYSUZBBfzrIZcJ9KwlcVmIiw==
X-Google-Smtp-Source: AGHT+IFxIZoaozYQcoDyzpI/OA0rt/U65Yr7E+wku1TjxLBaj7ted4ufB5Rw3g0qfi76pYAPu7EKtA==
X-Received: by 2002:a5d:4804:0:b0:374:c6af:1658 with SMTP id ffacd0b85a97d-37a422535a5mr11951426f8f.1.1727125046415;
        Mon, 23 Sep 2024 13:57:26 -0700 (PDT)
Received: from localhost (dh207-41-185.xnet.hr. [88.207.41.185])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612df579sm1278930366b.164.2024.09.23.13.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 13:57:25 -0700 (PDT)
From: Mirsad Todorovac <mtodorovac69@gmail.com>
To: linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mirsad Todorovac <mtodorovac69@gmail.com>
Subject: [PATCH v1 1/1] SUNRPC: Make enough room in servername[] for AF_UNIX addresses
Date: Mon, 23 Sep 2024 22:55:46 +0200
Message-ID: <20240923205545.1488448-2-mtodorovac69@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

GCC 13.2.0 reported with W=1 build option the following warning:

net/sunrpc/clnt.c: In function ‘rpc_create’:
net/sunrpc/clnt.c:582:75: warning: ‘%s’ directive output may be truncated writing up to 107 bytes into \
					a region of size 48 [-Wformat-truncation=]
  582 |                                 snprintf(servername, sizeof(servername), "%s",
      |                                                                           ^~
net/sunrpc/clnt.c:582:33: note: ‘snprintf’ output between 1 and 108 bytes into a destination of size 48
  582 |                                 snprintf(servername, sizeof(servername), "%s",
      |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  583 |                                          sun->sun_path);
      |                                          ~~~~~~~~~~~~~~

   548         };
 → 549         char servername[48];
   550         struct rpc_clnt *clnt;
   551         int i;
   552
   553         if (args->bc_xprt) {
   554                 WARN_ON_ONCE(!(args->protocol & XPRT_TRANSPORT_BC));
   555                 xprt = args->bc_xprt->xpt_bc_xprt;
   556                 if (xprt) {
   557                         xprt_get(xprt);
   558                         return rpc_create_xprt(args, xprt);
   559                 }
   560         }
   561
   562         if (args->flags & RPC_CLNT_CREATE_INFINITE_SLOTS)
   563                 xprtargs.flags |= XPRT_CREATE_INFINITE_SLOTS;
   564         if (args->flags & RPC_CLNT_CREATE_NO_IDLE_TIMEOUT)
   565                 xprtargs.flags |= XPRT_CREATE_NO_IDLE_TIMEOUT;
   566         /*
   567          * If the caller chooses not to specify a hostname, whip
   568          * up a string representation of the passed-in address.
   569          */
   570         if (xprtargs.servername == NULL) {
   571                 struct sockaddr_un *sun =
   572                                 (struct sockaddr_un *)args->address;
   573                 struct sockaddr_in *sin =
   574                                 (struct sockaddr_in *)args->address;
   575                 struct sockaddr_in6 *sin6 =
   576                                 (struct sockaddr_in6 *)args->address;
   577
   578                 servername[0] = '\0';
   579                 switch (args->address->sa_family) {
 → 580                 case AF_LOCAL:
 → 581                         if (sun->sun_path[0])
 → 582                                 snprintf(servername, sizeof(servername), "%s",
 → 583                                          sun->sun_path);
 → 584                         else
 → 585                                 snprintf(servername, sizeof(servername), "@%s",
 → 586                                          sun->sun_path+1);
 → 587                         break;
   588                 case AF_INET:
   589                         snprintf(servername, sizeof(servername), "%pI4",
   590                                  &sin->sin_addr.s_addr);
   591                         break;
   592                 case AF_INET6:
   593                         snprintf(servername, sizeof(servername), "%pI6",
   594                                  &sin6->sin6_addr);
   595                         break;
   596                 default:
   597                         /* caller wants default server name, but
   598                          * address family isn't recognized. */
   599                         return ERR_PTR(-EINVAL);
   600                 }
   601                 xprtargs.servername = servername;
   602         }
   603
   604         xprt = xprt_create_transport(&xprtargs);
   605         if (IS_ERR(xprt))
   606                 return (struct rpc_clnt *)xprt;

After the address family AF_LOCAL was added in the commit 176e21ee2ec89, the old hard-coded
size for servername of char servername[48] no longer fits. The maximum AF_UNIX address size
has now grown to UNIX_PATH_MAX defined as 108 in "include/uapi/linux/un.h" .

The lines 580-587 were added later, addressing the leading zero byte '\0', but did not fix
the hard-coded servername limit.

The AF_UNIX address was truncated to 47 bytes + terminating null byte. This patch will fix the
servername in AF_UNIX family to the maximum permitted by the system:

   548         };
 → 549         char servername[UNIX_PATH_MAX];
   550         struct rpc_clnt *clnt;

Fixes: 4388ce05fa38b ("SUNRPC: support abstract unix socket addresses")
Fixes: 510deb0d7035d ("SUNRPC: rpc_create() default hostname should support AF_INET6 addresses")
Fixes: 176e21ee2ec89 ("SUNRPC: Support for RPC over AF_LOCAL transports")
Cc: Neil Brown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>
Cc: Dai Ngo <Dai.Ngo@oracle.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: linux-nfs@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mirsad Todorovac <mtodorovac69@gmail.com>
---
 v1:
	initial version.

 net/sunrpc/clnt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 09f29a95f2bc..67099719893e 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -546,7 +546,7 @@ struct rpc_clnt *rpc_create(struct rpc_create_args *args)
 		.connect_timeout = args->connect_timeout,
 		.reconnect_timeout = args->reconnect_timeout,
 	};
-	char servername[48];
+	char servername[UNIX_PATH_MAX];
 	struct rpc_clnt *clnt;
 	int i;
 
-- 
2.43.0


