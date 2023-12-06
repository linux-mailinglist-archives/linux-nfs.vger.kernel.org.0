Return-Path: <linux-nfs+bounces-369-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E00807A77
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 22:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB0141F21A25
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 21:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3BF70960;
	Wed,  6 Dec 2023 21:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jScgeA/J"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46A89A
	for <linux-nfs@vger.kernel.org>; Wed,  6 Dec 2023 13:31:31 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-77f3c8fb126so1103885a.0
        for <linux-nfs@vger.kernel.org>; Wed, 06 Dec 2023 13:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701898291; x=1702503091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KczilCBZWauIaSy25zpHduAVisqXJc50tSTdQbX/6D4=;
        b=jScgeA/JJp64RTzq2pMBkPmXmU/+yEO/0/XI+hXxvJ0yn9oXfNkhiGySq1zscwftkk
         6rxHr+ynmjAHYM/RkdljLWcLmlMOHhYvYKcJWXdnXRXXpfXUf9+zZZpUjSHX6xYaK/33
         5itJFOkjXov0aMCwMQBmiOaebOQv51KYaD6JG5TULUWeS2PTjb/IHxLvSi9YyCXp9uov
         k0e1EO0GDQheFat7b54aaMf0fS6rUIwXKkQKVDPRJvknxR+DNpKMErgB1yI0ksM8Q94r
         w7/qdjoeLgcSmuPrlIS+O866VZxHiRh5LbfrgjU+XQMq4p3+mfGXuw3ZQMY7olQzZjzr
         JShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701898291; x=1702503091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KczilCBZWauIaSy25zpHduAVisqXJc50tSTdQbX/6D4=;
        b=qiLGWhxRoUB8qY9Stg0x9upx0+p713C9Jz6WUq7Pvgy6/734HPwt0XC8H+8xB5O98L
         vR6aSbf1k0Zp0YYQZ0CuDBAyEHH6ucADO5q8VUulruy1J7/GvHgGOkMGAYMyjUiw2c9x
         /DtUH0jlIpr+QwWyAUv4rZUWGuCNY2PEOKjImTqts+A0NuF6MXJW+N3Hau4I8ckK7j4A
         3LbBKOou5P350x7OtrmIzYx5kq9mv9cnqNBy7oZjm84+owYKEVFaRsgSWMGHnI7Bdouv
         Ia3pQ5HCXhZHiMEKSj/1vpHzqf6Wvp8vaMyZS2CBgMRjwAYMwJxuweEBymFrZtNsQmby
         DRgA==
X-Gm-Message-State: AOJu0YxUT6Upe15FpBbOtPcUAjmPHvauaNzDd1JLlHvgsmNd+hU8+BoT
	4WM6mXXG8ej+yuKH6hHLT9e9y0JXKUQ=
X-Google-Smtp-Source: AGHT+IGkfHhiNiM9qu+m4drWjMVo+VVQuHq/xgB01FDSg+rvrbdIaSqPm+y7rbq98ZAKhfzwcCPF3w==
X-Received: by 2002:a05:620a:199b:b0:77d:9704:89fb with SMTP id bm27-20020a05620a199b00b0077d970489fbmr3349150qkb.3.1701898290615;
        Wed, 06 Dec 2023 13:31:30 -0800 (PST)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:b4ac:108b:be40:79b])
        by smtp.gmail.com with ESMTPSA id bn36-20020a05620a2ae400b00767e2668536sm253900qkb.17.2023.12.06.13.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 13:31:29 -0800 (PST)
From: Olga Kornievskaia <olga.kornievskaia@gmail.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org,
	chuck.lever@oracle.com
Subject: [PATCH 2/2] gssapi: fix rpc_gss_seccreate passed in cred
Date: Wed,  6 Dec 2023 16:31:27 -0500
Message-Id: <20231206213127.55310-2-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20231206213127.55310-1-olga.kornievskaia@gmail.com>
References: <20231206213127.55310-1-olga.kornievskaia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Olga Kornievskaia <kolga@netapp.com>

Fix rpc_gss_seccreate() usage of the passed in gss credential.

Fixes: 5f1fe4dde861 ("Pass time_req and input_channel_bindings through to init_sec_context")
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 src/auth_gss.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/auth_gss.c b/src/auth_gss.c
index e317664..9d18f96 100644
--- a/src/auth_gss.c
+++ b/src/auth_gss.c
@@ -842,9 +842,9 @@ rpc_gss_seccreate(CLIENT *clnt, char *principal, char *mechanism,
 	gd->sec = sec;
 
 	if (req) {
-		sec.req_flags = req->req_flags;
+		gd->sec.req_flags = req->req_flags;
 		gd->time_req = req->time_req;
-		sec.cred = req->my_cred;
+		gd->sec.cred = req->my_cred;
 		gd->icb = req->input_channel_bindings;
 	}
 
-- 
2.39.1


