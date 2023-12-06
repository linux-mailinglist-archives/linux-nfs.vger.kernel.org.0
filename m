Return-Path: <linux-nfs+bounces-373-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FE0807A85
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 22:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB07FB211B1
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 21:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906CD7097E;
	Wed,  6 Dec 2023 21:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKXnxee8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4423ED5B
	for <linux-nfs@vger.kernel.org>; Wed,  6 Dec 2023 13:33:38 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-67acc0c1a35so531816d6.0
        for <linux-nfs@vger.kernel.org>; Wed, 06 Dec 2023 13:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701898417; x=1702503217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZWSOIgKKMZd8u9zKyA1yNwvXWB4I60jQhkSqY/f7yQ=;
        b=UKXnxee8YfX2H3xp/WvVxnKeb0JzqWg7hA62DLURNINxsdnrNyuEPVJxibWzH5Nio3
         eRC0DpOdYCXiFVghR7NgFYWSJh5PXY1C+SCwOgQaBvsK9k/iUYBJxh0Po/YaTbKP+QYW
         6OB6zEUMFbkE6gsHkd5i/JNIEaVmB098DmS/wgF1DyuhNdF4Ya/3ZZ4KcSMVdLcqVAbP
         SgjvbZj3upMn3nBatWnOWIj7asqdGDSuqw4OdEjEi5/9jg0MXPjorucseU8Lch8SlG+e
         x8Gjls86KN/LSz8IVLyoCjfIDKUI9frVMfV7Qr4Pblfw8cRAYxSFR4P7YHtOtmhcD+1C
         CrhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701898417; x=1702503217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZWSOIgKKMZd8u9zKyA1yNwvXWB4I60jQhkSqY/f7yQ=;
        b=nwWp6AqquWL5O5/m0oP3nZ5Q/cwJgckXe8FT/jK+FS2u3DXFO/gGzM46qaYNUkcvif
         dkzHUjkh4tacb8PZFl1DUOzIkGdGSG9QYN+GWcF2x618QvXDhXGIDuGCBZg7kZtL+LFu
         3NET0++/QZfK2ADkUPTapDNCeLisoOrPtwNgT1kLQDSMRjaSaug1JJl6uCU9A1U6Zeyq
         mDoRdM3F/PFoKFFK4YvcVQNa+wb11PVn91YD1FrnyKAbxvfAaRi5uOKG7eNnhaSnegB0
         8aiJNmeRzTR43/aIOh4gGfQhhrV8lOBTF5l4pLCa39y2rHynalkvB75i+t+tacYCJMHE
         IEBA==
X-Gm-Message-State: AOJu0YzQ3vGIZUjHROqsixcBllL1yjlz5rDKgUo5zfW1l+DD1NWbwUHi
	0PVwBwtJjoaAJpM7sHgGIs0=
X-Google-Smtp-Source: AGHT+IEc2hAT+VbsdIdhZfImpKHnEYW+Gs7kMSvpLUF9Ua86CP0UEqkPW1lXtcyoSO9sy5l5PtI/0w==
X-Received: by 2002:a05:620a:4146:b0:77d:8c81:ea2d with SMTP id k6-20020a05620a414600b0077d8c81ea2dmr3245298qko.0.1701898417362;
        Wed, 06 Dec 2023 13:33:37 -0800 (PST)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:b4ac:108b:be40:79b])
        by smtp.gmail.com with ESMTPSA id ro3-20020a05620a398300b0077da601f06csm256435qkn.10.2023.12.06.13.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 13:33:36 -0800 (PST)
From: Olga Kornievskaia <olga.kornievskaia@gmail.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org,
	chuck.lever@oracle.com
Subject: [PATCH 2/6] gssd: revert commit 513630d720bd
Date: Wed,  6 Dec 2023 16:33:28 -0500
Message-Id: <20231206213332.55565-3-olga.kornievskaia@gmail.com>
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

In preparation for using rpc_gss_seccreate(), revert commit 513630d720bd
"gssd: handle KRB5_AP_ERR_BAD_INTEGRITY for machine credentials"

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 utils/gssd/gssd_proc.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/utils/gssd/gssd_proc.c b/utils/gssd/gssd_proc.c
index e5cc1d98..4fb6b72d 100644
--- a/utils/gssd/gssd_proc.c
+++ b/utils/gssd/gssd_proc.c
@@ -412,27 +412,13 @@ create_auth_rpc_client(struct clnt_info *clp,
 		tid, tgtname);
 	auth = authgss_create_default(rpc_clnt, tgtname, &sec);
 	if (!auth) {
-		if (sec.minor_status == KRB5KRB_AP_ERR_BAD_INTEGRITY) {
-			printerr(2, "WARNING: server=%s failed context "
-				 "creation with KRB5_AP_ERR_BAD_INTEGRITY\n",
-				 clp->servername);
-			if (cred == GSS_C_NO_CREDENTIAL)
-				retval = gssd_refresh_krb5_machine_credential(clp->servername,
-					"*", NULL, 1);
-			if (!retval) {
-				auth = authgss_create_default(rpc_clnt, tgtname,
-						&sec);
-				if (auth)
-					goto success;
-			}
-		}
 		/* Our caller should print appropriate message */
 		printerr(2, "WARNING: Failed to create krb5 context for "
 			    "user with uid %d for server %s\n",
 			 uid, tgtname);
 		goto out_fail;
 	}
-success:
+
 	/* Success !!! */
 	rpc_clnt->cl_auth = auth;
 	*clnt_return = rpc_clnt;
-- 
2.39.1


