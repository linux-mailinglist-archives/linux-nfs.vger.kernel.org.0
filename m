Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922677C883D
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Oct 2023 17:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjJMPER (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Oct 2023 11:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjJMPEQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Oct 2023 11:04:16 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB04DBB
        for <linux-nfs@vger.kernel.org>; Fri, 13 Oct 2023 08:04:13 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-79fb8f60374so25987239f.1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Oct 2023 08:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697209453; x=1697814253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7FnhPlDSkttEslOg6pHODca2/QQj3CdN2jPPZpj5bTE=;
        b=Sq/xcQXS/VEnxHo8REv8ynKbDvRZ/l7qeJt5WXDf2x5XUzrXz72XBU07hxHCYese1j
         oXoAYmTHQ3VVRZm2f6cWrOlAwmOYA9UK0hXxvu9xpomakSE1+DDM2pxc5rJGG/m3Tz+T
         /Zy3srDn4ziEks062J2CYLz+OaOrU2aryGNQykrl1SNcm6cWiyZEdjolELinEXytDTEv
         ybOXMVKGCflZO6YQPhCNFSNOUdoSEmVymdTVqQohCkM/rRHDNVGak1G10/b97Gf/Vauv
         ouzl7Ny7l9hfI9BOOSvkE1hR01ZZ3mP54sA3BoGiz+fFhIFTobyVbjT8TMJmn0leeH5u
         wOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697209453; x=1697814253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7FnhPlDSkttEslOg6pHODca2/QQj3CdN2jPPZpj5bTE=;
        b=eX1Xp3ZwOa6yZFKQCDnjwUr78R5WNIcY95qtmU21Qs4h+1ocSEWnktywDllS2Y0f0z
         TbmH3fdyqpNkCW9dVEp1HGygNoEdwM5swmwO/IL38Q2wl0BHebegllSkqWDmrUpWsvwq
         j/nuCcmD0jcb3sXNgNqydDzFJzDGa08CBU1vlu71f5cjCCvkDtcqsVNG7kJqvilWe6Pi
         Dmr/KyGOoDC7E0tW+FKrV5v2ifOBNP+TFh87SS8sF79Gb7RVcat1mn7TVJDAioFB69K2
         RcZd8Nj1ZlqPMn37iEOz/FHUTLKoF0AeMYP+SlteP6HaiM4r1klibC57YuCkETugKbri
         SoGQ==
X-Gm-Message-State: AOJu0YzaKHDWmhEOB0rqwnOzdR0LuYwv6C5U/rb78jqdgxEXGBUHYBQ6
        kvJZAawo6iX8VAJMvfAkeG3lSkfNXmA=
X-Google-Smtp-Source: AGHT+IFh8mJUarDTk1ontnwVxznLAZq3z9zIiHxLQ/MoXRCcfMrxNerdE1H4T3Gvj0ZtIlDcuIbM4g==
X-Received: by 2002:a05:6602:3a05:b0:792:6be4:3dcb with SMTP id by5-20020a0566023a0500b007926be43dcbmr28299818iob.2.1697209453011;
        Fri, 13 Oct 2023 08:04:13 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:85eb:d471:596b:a98b])
        by smtp.gmail.com with ESMTPSA id v11-20020a5ec10b000000b0076c569c7a48sm4656896iol.39.2023.10.13.08.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 08:04:12 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4.1: fix SP4_MACH_CRED protection for pnfs IO
Date:   Fri, 13 Oct 2023 11:04:10 -0400
Message-Id: <20231013150410.42385-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
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

If the client is doing pnfs IO and Kerberos is configured and EXCHANGEID
successfully negotiated SP4_MACH_CRED and WRITE/COMMIT are on the
list of state protected operations, then we need to make sure to
choose the DS's rpc_client structure instead of the MDS's one.

Fixes: fb91fb0ee7b2 ("NFS: Move call to nfs4_state_protect_write() to nfs4_write_setup()")
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4proc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 5ee283eb9660..19708c89f049 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5622,7 +5622,7 @@ static void nfs4_proc_write_setup(struct nfs_pgio_header *hdr,
 
 	msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_WRITE];
 	nfs4_init_sequence(&hdr->args.seq_args, &hdr->res.seq_res, 0, 0);
-	nfs4_state_protect_write(server->nfs_client, clnt, msg, hdr);
+	nfs4_state_protect_write(hdr->ds_clp ? hdr->ds_clp : server->nfs_client, clnt, msg, hdr);
 }
 
 static void nfs4_proc_commit_rpc_prepare(struct rpc_task *task, struct nfs_commit_data *data)
@@ -5663,7 +5663,8 @@ static void nfs4_proc_commit_setup(struct nfs_commit_data *data, struct rpc_mess
 	data->res.server = server;
 	msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_COMMIT];
 	nfs4_init_sequence(&data->args.seq_args, &data->res.seq_res, 1, 0);
-	nfs4_state_protect(server->nfs_client, NFS_SP4_MACH_CRED_COMMIT, clnt, msg);
+	nfs4_state_protect(data->ds_clp ? data->ds_clp : server->nfs_client,
+			NFS_SP4_MACH_CRED_COMMIT, clnt, msg);
 }
 
 static int _nfs4_proc_commit(struct file *dst, struct nfs_commitargs *args,
-- 
2.39.1

