Return-Path: <linux-nfs+bounces-368-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D147807A76
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 22:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F63D1C20944
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 21:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EC57096A;
	Wed,  6 Dec 2023 21:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZuQeIVh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF89A98
	for <linux-nfs@vger.kernel.org>; Wed,  6 Dec 2023 13:31:29 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-5906cf5bfdfso10556eaf.1
        for <linux-nfs@vger.kernel.org>; Wed, 06 Dec 2023 13:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701898289; x=1702503089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wjK5E7wswGGMerNY3eRIuU0/2VyPOWk5Ega1EB/QSJk=;
        b=gZuQeIVh+CJNE6cWMXm1juiujWa3LgFBQ8gqFhqBC9zhO3EilbZ25KwDyXfZWyTuDm
         9XwOCrinUmtx2eIyh1JlrCmdRCMmLY5QRF7gVOquEml2FzdikBp4EeVRcH/26hpZ2Y8n
         PgHWkJZKTfE8FqdtP2UICOew/KwgQZOBdrm7o2dhYJzhk0kguywPJZEwAjw3nq+N3gyT
         urNkzHYBJELnr8nEGmWLpLMn/gHDUpkVQyPttguQkeVDFjjrZsD7YbeH31dnb4uK/sxm
         VtMuOz4Kf4V9/NxsDJnlpOrdHI6KEwzIxWXdjLnvkwCyswk/fklZlLmjHrGyaOpaVJc0
         VpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701898289; x=1702503089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wjK5E7wswGGMerNY3eRIuU0/2VyPOWk5Ega1EB/QSJk=;
        b=uDSElwaas7sYFgDGGww3owN5C12cwm4oV9F1H0NoSuWute+mpKc0qkje+FvVolsBBC
         fRTNasTdv71M4hGgONfYlSAMngoDG655ziJPz/d41K4G3i8gWej5JTQvMxrHVA4hXQS4
         v2waNpJXO0kf9hDOR2cUpO0OvMa4gtrX+4EmXB6ylBICjGpies+whIOXuMJZ8V5Wg+72
         yAjxCtttj/X+vZJWgW1D8Z0eE9ek8nEQ8345HOUwZasoFnGXlXB7uwSwkwhY/7aMviMW
         D//c5z9TIfPiy7qn5Dn+yOtXw+VJy2Ih/pXdK6JxvY5H34nuY8BNk7kOILglJ3IjEoF9
         WUjw==
X-Gm-Message-State: AOJu0YxM9LeB6QpeyZI85uFcfDnqdoapiVu6J5h65lTOr8NOWAdCrjbT
	IdU96y2avXVeJTaSaGPuo+A=
X-Google-Smtp-Source: AGHT+IHhByI6NNteUjWE9J6px1AJ12gBvx6G1h1HSqZ8CxYR0hClsWXymcLCDqraaHKwzHADCgon6Q==
X-Received: by 2002:a05:6820:1f90:b0:584:1080:f0a5 with SMTP id eq16-20020a0568201f9000b005841080f0a5mr2987290oob.1.1701898288907;
        Wed, 06 Dec 2023 13:31:28 -0800 (PST)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:b4ac:108b:be40:79b])
        by smtp.gmail.com with ESMTPSA id bn36-20020a05620a2ae400b00767e2668536sm253900qkb.17.2023.12.06.13.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 13:31:28 -0800 (PST)
From: Olga Kornievskaia <olga.kornievskaia@gmail.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org,
	chuck.lever@oracle.com
Subject: [PATCH 1/2] gssapi: revert commit f5b6e6fdb1e6
Date: Wed,  6 Dec 2023 16:31:26 -0500
Message-Id: <20231206213127.55310-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Olga Kornievskaia <kolga@netapp.com>

Revert commit f5b6e6fdb1e6 "gss-api: expose gss major/minor error in
authgss_refresh()".

Instead of modifying existing api, use rpc_gss_seccreate() which exposes
the error values.

Signed-off-by: Olga Kornievskaia <kolga@netapp.umich>
---
 src/auth_gss.c       | 14 ++++++--------
 tirpc/rpc/auth_gss.h |  2 --
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/src/auth_gss.c b/src/auth_gss.c
index 3127b92..e317664 100644
--- a/src/auth_gss.c
+++ b/src/auth_gss.c
@@ -184,7 +184,6 @@ authgss_create(CLIENT *clnt, gss_name_t name, struct rpc_gss_sec *sec)
 	AUTH			*auth, *save_auth;
 	struct rpc_gss_data	*gd;
 	OM_uint32		min_stat = 0;
-	rpc_gss_options_ret_t	ret;
 
 	gss_log_debug("in authgss_create()");
 
@@ -230,12 +229,8 @@ authgss_create(CLIENT *clnt, gss_name_t name, struct rpc_gss_sec *sec)
 	save_auth = clnt->cl_auth;
 	clnt->cl_auth = auth;
 
-	memset(&ret, 0, sizeof(rpc_gss_options_ret_t));
-	if (!authgss_refresh(auth, &ret)) {
+	if (!authgss_refresh(auth, NULL))
 		auth = NULL;
-		sec->major_status = ret.major_status;
-		sec->minor_status = ret.minor_status;
-	}
 	else
 		authgss_auth_get(auth); /* Reference for caller */
 
@@ -624,9 +619,12 @@ _rpc_gss_refresh(AUTH *auth, rpc_gss_options_ret_t *options_ret)
 }
 
 static bool_t
-authgss_refresh(AUTH *auth, void *ret)
+authgss_refresh(AUTH *auth, void *dummy)
 {
-	return _rpc_gss_refresh(auth, (rpc_gss_options_ret_t *)ret);
+	rpc_gss_options_ret_t ret;
+
+	memset(&ret, 0, sizeof(ret));
+	return _rpc_gss_refresh(auth, &ret);
 }
 
 bool_t
diff --git a/tirpc/rpc/auth_gss.h b/tirpc/rpc/auth_gss.h
index a530d42..f2af6e9 100644
--- a/tirpc/rpc/auth_gss.h
+++ b/tirpc/rpc/auth_gss.h
@@ -64,8 +64,6 @@ struct rpc_gss_sec {
 	rpc_gss_svc_t	svc;		/* service */
 	gss_cred_id_t	cred;		/* cred handle */
 	u_int		req_flags;	/* req flags for init_sec_context */
-	int		major_status;
-	int		minor_status;
 };
 
 /* Private data required for kernel implementation */
-- 
2.39.1


