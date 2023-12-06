Return-Path: <linux-nfs+bounces-375-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4AB807A86
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 22:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 803C41F21A1D
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 21:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB91C70977;
	Wed,  6 Dec 2023 21:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTwqu/BQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1100718D
	for <linux-nfs@vger.kernel.org>; Wed,  6 Dec 2023 13:33:41 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-67a9a51663fso446486d6.1
        for <linux-nfs@vger.kernel.org>; Wed, 06 Dec 2023 13:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701898420; x=1702503220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqoSXgMUeBsvluQmJvVDbjL5heCUMNwImuhygB9ZAbk=;
        b=WTwqu/BQOym/hxujgGodZxI1bn/PQgyFsIZtuWSVvh97ofRgM/mW9Kz7G+YknksJI4
         i2wdQIc7oZgWay8FeF7KIFmcWqLJaDLNgH2eB7oZnF+ns+a2XrsojwjGsKUFwCPnVcP4
         RvD6aSKXNfgpmALEUkgfn7yoQjmuxj0QoCzpOwZ4ygLOlmdma1nrbFE+Dj2O8GdGM93p
         r+1oE4i1FjEbn9775UZwNO9y/pEaWHJODrQVyZc5ecyA78F1VEdECAjkW2XuQVE/YC3h
         T6sSNogdpHovdhIC2ssTdlySSH4zHBJK+wDdbQVP0F8ZSitcixomQzjcLjUSlY+ycsM5
         2f0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701898420; x=1702503220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MqoSXgMUeBsvluQmJvVDbjL5heCUMNwImuhygB9ZAbk=;
        b=iwaW4nKY6OsTBdLmErf99xybUByOqsJW1OLd6SVx/pelyZihqHgNPYyIjPallcW+VX
         rZ/X0+gua40J/n+U76kwN6imQHQWn4tcfFBID1zAyzgWv+Voz7+ql/fY8M5xRw3uYQtq
         5e897Ts87F5zANsp/nPuprXU3wnZtELCxvyzLSZRvituAUbg/e1QK7PNj88YVHcTiUIa
         8FV7Lk0NamLb3QuJEhs/4gXByvvQHhZ41mJuhuafiKnVEUTQLIdkuRZrfDK3qLkbXQwN
         WjA+xUr/jUXyL5ChLNbRx1J9ampFyb1nYa/Z/2QyPFLApt2GeQpoYbZjFhvUt/wHR2ne
         wBFg==
X-Gm-Message-State: AOJu0YwGdDmCy4BCg7OvETBVpqy9M0zxC8oSVbXW9F9m0AGsXfMjlUfK
	ymgYD9axuPIyNY8bd4hEdSc=
X-Google-Smtp-Source: AGHT+IFQMCUpK/rWCuZt7zkfVRgqTiwGN0gINiDplupHoXwXLD7yS/ooa4s6ziiZthtsRgfWQ2FM7w==
X-Received: by 2002:a05:620a:4485:b0:774:17d6:31dc with SMTP id x5-20020a05620a448500b0077417d631dcmr3033638qkp.4.1701898420013;
        Wed, 06 Dec 2023 13:33:40 -0800 (PST)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:b4ac:108b:be40:79b])
        by smtp.gmail.com with ESMTPSA id ro3-20020a05620a398300b0077da601f06csm256435qkn.10.2023.12.06.13.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 13:33:38 -0800 (PST)
From: Olga Kornievskaia <olga.kornievskaia@gmail.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org,
	chuck.lever@oracle.com
Subject: [PATCH 4/6] gssd: handle KRB5_AP_ERR_BAD_INTEGRITY for machine credentials
Date: Wed,  6 Dec 2023 16:33:30 -0500
Message-Id: <20231206213332.55565-5-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20231206213332.55565-1-olga.kornievskaia@gmail.com>
References: <20231206213332.55565-1-olga.kornievskaia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Olga Kornievskaia <kolga@netapp.com>

During context establishment, when the client received
KRB5_AP_ERR_BAD_INTEGRITY error, it might be due to the server
updating its key material. To handle such error, get a new
service ticket and re-try the AP_REQ.

This functionality relies on the new API in libtirpc that
exposes the gss errors.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 utils/gssd/gssd_proc.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/utils/gssd/gssd_proc.c b/utils/gssd/gssd_proc.c
index 99761157..29600a3f 100644
--- a/utils/gssd/gssd_proc.c
+++ b/utils/gssd/gssd_proc.c
@@ -427,13 +427,32 @@ create_auth_rpc_client(struct clnt_info *clp,
 	auth = authgss_create_default(rpc_clnt, tgtname, &sec);
 #endif
 	if (!auth) {
+#ifdef HAVE_TIRPC_GSS_SECCREATE
+		if (ret.minor_status == KRB5KRB_AP_ERR_BAD_INTEGRITY) {
+			printerr(2, "WARNING: server=%s failed context "
+				 "creation with KRB5_AP_ERR_BAD_INTEGRITY\n",
+				 clp->servername);
+			if (cred == GSS_C_NO_CREDENTIAL)
+				retval = gssd_refresh_krb5_machine_credential(clp->servername,
+					"*", NULL, 1);
+			if (!retval) {
+				auth = rpc_gss_seccreate(rpc_clnt, tgtname,
+						mechanism, rpcsec_gss_svc_none,
+						NULL, &req, &ret);
+				if (auth)
+					goto success;
+			}
+		}
+#endif
 		/* Our caller should print appropriate message */
 		printerr(2, "WARNING: Failed to create krb5 context for "
 			    "user with uid %d for server %s\n",
 			 uid, tgtname);
 		goto out_fail;
 	}
-
+#ifdef HAVE_TIRPC_GSS_SECCREATE
+success:
+#endif
 	/* Success !!! */
 	rpc_clnt->cl_auth = auth;
 	*clnt_return = rpc_clnt;
-- 
2.39.1


