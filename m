Return-Path: <linux-nfs+bounces-2989-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D75188B1F9D
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Apr 2024 12:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91E9A282830
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Apr 2024 10:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2481D53F;
	Thu, 25 Apr 2024 10:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b="Ylna+6hz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9D0208C1
	for <linux-nfs@vger.kernel.org>; Thu, 25 Apr 2024 10:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714042185; cv=none; b=laLECfEHKGCiIvsHJdeOja0Vs9fnjqkzOuw7E7cazMCCc0XwCVfgwcfdZaOCS1zSpELtucVSQv+AEwDcCGIgOpLORTzHXcRTaE7b93RB0Dg70wgMMZcbkYszCpgIBHrlUjUZBUtqKkHR4HlMNXwm9p9GDJMKCwDf1NfP/4Z/Og8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714042185; c=relaxed/simple;
	bh=Wie7N4BhcEMzeZObCCYMO5x6JZre9Xf0H0gkVW+vSso=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rNM/19yYw0T7UGGaQ4OIjDZtV++q8NFQOcJBNCv7xyMNdV7boDGdWRNtcw19avZknU1tm8O8+DeUUuE5S+ejj8N3zIfKNN7JCmgZ0pku54zwxdaXqQebMlLVLaAuSvVSraxZCzRERiq6Vk6+bbbw4Q+w1bH0wlztdU6TDIbPqsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com; spf=pass smtp.mailfrom=vastdata.com; dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b=Ylna+6hz; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vastdata.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2dd6c160eaaso9698831fa.1
        for <linux-nfs@vger.kernel.org>; Thu, 25 Apr 2024 03:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google; t=1714042181; x=1714646981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SyS0R37GJ6zZa6oDZVM2+qjFR6O7laeNyDST9cx8b4Y=;
        b=Ylna+6hzsmV+0w3ujEN1QXQfAVf3lS2uZKWy1kuQ0JAgaBTO5dZS2XnCYXVa+TZnqI
         mO+3iJrHoUhDsE+l33JeSkWSwqS0l5RB/FKyK0CqIkZ6THZ3U/+eAqFa4npx3c4NhKZX
         /e6OkMNeNuu99z1JwFDlGUyDTKgePfInoNttdpK88OzKG7Uz7mZPc9gpbXLwilVw+Cpr
         mKkIwXCoBSmJTPrqjgpNVgS8WKzAo44dVb809ZqnoGYeW7KKrdvF4dDBmCWqtXOpkazI
         yZ/2eieZdn2F+ZImNILms5evjHzcPaxE8cmJAdAzLL25FBh8hE41FgfHEsdBaQDOTyWe
         cNqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714042181; x=1714646981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SyS0R37GJ6zZa6oDZVM2+qjFR6O7laeNyDST9cx8b4Y=;
        b=ga2RrRt0C2TRzmw/a813lzbOJRmwRJgLjFo0uMk7F7VZS5rILikkXCUhC3NVDlPQoE
         KcVjQue5M+SpzpoJRKOJk/qqbiJtw57dVCxPZVH4oBFCMG25jIn3gbd2ndV4p1WQN3SU
         MehGKgiT8LDDNZ5PHnzkpT2NYeuj++JqxJBLUsSZNza0uk0iGHM3peUbg1jZHoz1eGFn
         5nLY9NuTkIqBw7wjqQlow+RIo48JZrPnLFXDAfAZ76+LHApDt3tVqU0M/4APuiQj4K75
         NgvHpbFcO6pM4HaxGj8BBCoyZ2xDraB7TpH6OT7AeCD/jiWp44G6v6sciPBhbTjOkpUM
         tSYg==
X-Gm-Message-State: AOJu0YwTTqjyOFWOV+oof7lyv/XS9c2M7wxCrHkWM8i8UmUUtaQSnUwO
	X7juR94pG8GIXWkhh0BwZqfTPcuQDQHIkyzD92TKOKML71cCsYJ4Bk4DJ+92KwAYkHKOkkpyYa3
	t
X-Google-Smtp-Source: AGHT+IEc0Ypm2z/vnTD2SXrQjomUeHIs1aE7Zx24khJwiq967ps+uJVg6ni+M2zxnwQxRrBJgKwTTA==
X-Received: by 2002:a2e:98c8:0:b0:2d8:5e21:8eaf with SMTP id s8-20020a2e98c8000000b002d85e218eafmr4357030ljj.41.1714042180740;
        Thu, 25 Apr 2024 03:49:40 -0700 (PDT)
Received: from jupiter.vstd.int ([176.230.79.220])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c350f00b00418d68df226sm27832024wmq.0.2024.04.25.03.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 03:49:40 -0700 (PDT)
From: Dan Aloni <dan.aloni@vastdata.com>
To: trondmy@hammerspace.com
Cc: linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Benjamin Coddington <bcodding@redhat.com>
Subject: [PATCH] sunrpc: fix NFSACL RPC retry on soft mount
Date: Thu, 25 Apr 2024 13:49:38 +0300
Message-Id: <20240425104938.3363417-1-dan.aloni@vastdata.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It used to be quite awhile ago since 1b63a75180c6 ('SUNRPC: Refactor
rpc_clone_client()'), in 2012, that `cl_timeout` was copied in so that
all mount parameters propagate to NFSACL clients. However since that
change, if mount options as follows are given:

    soft,timeo=50,retrans=16,vers=3

The resultant NFSACL client receives:

    cl_softrtry: 1
    cl_timeout: to_initval=60000, to_maxval=60000, to_increment=0, to_retries=2, to_exponential=0

These values lead to NFSACL operations not being retried under the
condition of transient network outages with soft mount. Instead, getacl
call fails after 60 seconds with EIO.

The simple fix is to pass the existing client's `cl_timeout` as the new
client timeout.

Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Benjamin Coddington <bcodding@redhat.com>
Link: https://lore.kernel.org/all/20231105154857.ryakhmgaptq3hb6b@gmail.com/T/
Fixes: 1b63a75180c6 ('SUNRPC: Refactor rpc_clone_client()')
Signed-off-by: Dan Aloni <dan.aloni@vastdata.com>
---
 net/sunrpc/clnt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index cda0935a68c9..07ffd4ee695a 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1068,6 +1068,7 @@ struct rpc_clnt *rpc_bind_new_program(struct rpc_clnt *old,
 		.version	= vers,
 		.authflavor	= old->cl_auth->au_flavor,
 		.cred		= old->cl_cred,
+		.timeout	= old->cl_timeout,
 	};
 	struct rpc_clnt *clnt;
 	int err;
-- 
2.39.3


