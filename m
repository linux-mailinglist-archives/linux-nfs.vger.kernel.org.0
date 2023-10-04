Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B9D7B869F
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Oct 2023 19:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243549AbjJDRcu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Oct 2023 13:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243438AbjJDRcu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Oct 2023 13:32:50 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5C59E
        for <linux-nfs@vger.kernel.org>; Wed,  4 Oct 2023 10:32:46 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-35291dbf7efso104195ab.1
        for <linux-nfs@vger.kernel.org>; Wed, 04 Oct 2023 10:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696440766; x=1697045566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bl8UvEFzSDdHBI7XcST/rpUAGk6LYVE5cYQ1boOklMo=;
        b=FK1aAJKSYx949TeDa861to6cxdb+OCBuIg5H8ZZ6OZz3abfaqb6LRD81aozHnfVuoI
         KB6g05V6iAPXFrzQ2ES0+sUITVqqjZRgqtHsC6AQ7t/iPrpR92sejT1zqhS8TNaIVlcO
         WeNQydW8Axj3n2u0tWjf0Owcj3z1kWXpk3ccdosrDjZp5pHbZPYwrEwPbPmvOvAai233
         4BLeu4Up1d9LbPEQsDlZ8JjqYHV/a5vY+VRej4Z6si7FbMY+FqHYgXZhFhSTtPvnAorC
         O7P2RaQpYU+MwJAbJattx+aTlkPOt1MV75ayWz73UO1EWTFMxajpSuBK88VJDvAvbK32
         nFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696440766; x=1697045566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bl8UvEFzSDdHBI7XcST/rpUAGk6LYVE5cYQ1boOklMo=;
        b=vzWD16V3NnNMKeeagE6Ogd9KEfxwmeYylrRZ/jT7DvCrrTNsVOqkPNpHZdsvnwPTxS
         oWK62S/DovIarUnqhp5izKTtIrAFO6RSXi0Y6k+JAmx8AOUAckpV5TKVgjWfYpbRjD6/
         9V/0RJQAtbdmCySpKqUWB5ISsIGjVIcb/K+/yZfCMJYxjd0ih4urJWD9UReB2BLs4GxM
         H/EeVWnT2n0APi25raQWahmepMmabTtEUfA2IKF3bwxkzGoEKnCVbuu4ku2pzF43/3Pu
         R90xdZqcI3jDLFlFyYg5Ur4/FiATjzVkv18NxraVEXA/RC8SmXgNT7ddt2gNAj1H137R
         5jYg==
X-Gm-Message-State: AOJu0Yz/muD2J+5sG4uV5W+qsCgt7U+3om6L18E1iAcH8jiXMWyqqYbQ
        /rztRsdNgpTKiDpKQs2jNCD23dnGv/k=
X-Google-Smtp-Source: AGHT+IHqk+uQNzKhXIsE0W+4/5gMBWdFLKxHs5OQWd4bAUcdq4YguCx16H7jDIga7/3LXF2lN8xWyA==
X-Received: by 2002:a05:6602:2e03:b0:792:6068:dcc8 with SMTP id o3-20020a0566022e0300b007926068dcc8mr3851227iow.2.1696440766063;
        Wed, 04 Oct 2023 10:32:46 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:d99c:94dd:ccd6:fb22])
        by smtp.gmail.com with ESMTPSA id u23-20020a6be417000000b007870289f4fdsm1066598iog.51.2023.10.04.10.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 10:32:45 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] gssd: fix handling DNS lookup failure
Date:   Wed,  4 Oct 2023 13:32:38 -0400
Message-Id: <20231004173240.46924-4-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20231004173240.46924-1-olga.kornievskaia@gmail.com>
References: <20231004173240.46924-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

When the kernel does its first ever lookup for a given server ip it
sends down info for server, protocol, etc. On the gssd side as it
scans the pipefs structure and sees a new entry it reads that info
and creates a clp_info structure. At that time it also does
a DNS lookup of the provided ip to name using getnameinfo(),
this is saved in clp->servername for all other upcalls that is
down under that directory.

IF this 1st getnameinfo() results in a failed resolution for
whatever reason (a temporary DNS resolution problem), this cause
of all other future upcalls to fail.

As a fix, this patch proposed to (1) save the server info that's
passed only in the initial pipefs new entry creation in the
clp_info structure, then (2) for the upcalls, if clp->servername
is NULL, then do the DNS lookup again and set all the needed
clp_info fields upon successful resolution.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 utils/gssd/gssd.c | 41 +++++++++++++++++++++++++++++++++++++++++
 utils/gssd/gssd.h |  6 ++++++
 2 files changed, 47 insertions(+)

diff --git a/utils/gssd/gssd.c b/utils/gssd/gssd.c
index 833d8e01..ca9b3267 100644
--- a/utils/gssd/gssd.c
+++ b/utils/gssd/gssd.c
@@ -365,6 +365,12 @@ gssd_read_service_info(int dirfd, struct clnt_info *clp)
 
 fail:
 	printerr(0, "ERROR: failed to parse %s/info\n", clp->relpath);
+	clp->upcall_address = strdup(address);
+	clp->upcall_port = strdup(port);
+	clp->upcall_program = program;
+	clp->upcall_vers = version;
+	clp->upcall_protoname = strdup(protoname);
+	clp->upcall_service = strdup(service);
 	free(servername);
 	free(protoname);
 	clp->servicename = NULL;
@@ -408,6 +414,16 @@ gssd_free_client(struct clnt_info *clp)
 	free(clp->servicename);
 	free(clp->servername);
 	free(clp->protocol);
+	if (!clp->servername) {
+		if (clp->upcall_address)
+			free(clp->upcall_address);
+		if (clp->upcall_port)
+			free(clp->upcall_port);
+		if (clp->upcall_protoname)
+			free(clp->upcall_protoname);
+		if (clp->upcall_service)
+			free(clp->upcall_service);
+	}
 	free(clp);
 }
 
@@ -446,6 +462,31 @@ gssd_clnt_gssd_cb(int UNUSED(fd), short UNUSED(which), void *data)
 {
 	struct clnt_info *clp = data;
 
+	/* if there was a failure to translate IP to name for this server,
+	 * try again
+	 */
+	if (!clp->servername) {
+	        if (!gssd_addrstr_to_sockaddr((struct sockaddr *)&clp->addr,
+                                 clp->upcall_address, clp->upcall_port ?
+				 clp->upcall_port : "")) {
+			goto do_upcall;
+		}
+		clp->servername = gssd_get_servername(clp->upcall_address,
+				(struct sockaddr *)&clp->addr, clp->upcall_address);
+		if (!clp->servername)
+			goto do_upcall;
+
+		if (asprintf(&clp->servicename, "%s@%s", clp->upcall_service,
+					clp->servername) < 0) {
+			free(clp->servername);
+			clp->servername = NULL;
+			goto do_upcall;
+		}
+		clp->prog = clp->upcall_program;
+		clp->vers = clp->upcall_vers;
+		clp->protocol = strdup(clp->upcall_protoname);
+	}
+do_upcall:
 	handle_gssd_upcall(clp);
 }
 
diff --git a/utils/gssd/gssd.h b/utils/gssd/gssd.h
index 519dc431..4e070ed6 100644
--- a/utils/gssd/gssd.h
+++ b/utils/gssd/gssd.h
@@ -86,6 +86,12 @@ struct clnt_info {
 	int			gssd_fd;
 	struct event		*gssd_ev;
 	struct			sockaddr_storage addr;
+	char			*upcall_address;
+	char			*upcall_port;
+	int			upcall_program;
+	int			upcall_vers;
+	char			*upcall_protoname;
+	char			*upcall_service;
 };
 
 struct clnt_upcall_info {
-- 
2.39.1

