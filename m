Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D794746878
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2019 22:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbfFNUA0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Jun 2019 16:00:26 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43726 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfFNUA0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Jun 2019 16:00:26 -0400
Received: by mail-io1-f65.google.com with SMTP id k20so8322216ios.10
        for <linux-nfs@vger.kernel.org>; Fri, 14 Jun 2019 13:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s6AarPquzkHm5tiN4Chfneb8capNztVCqvBC79jNDEI=;
        b=RnxoZ73+2K2x/0pfDmVvwuk16/FxBA76jrOk6Kcn8Ntnsip5GWqiD9Z+JhfhNombfJ
         JdkXeIo59dL0gkiI7T4X3FErjtIICYaEdwCxS9p9NhSfOl3qisO2DNB447J5Sn1pqTZw
         BlSzCvTKf89LGLSSOQN55AZnytMZuq9HIPtO/5r6cODxgu8vKzFaFK+xLjscYnTRt+hk
         1KKgaMHb9iJ2oCPRdG4wcVNWTqwrLrqoSP5pLtR05XgCfFZNtKMlkSt6EXi4Orqa3VP9
         5Ez7T3WnfFmHqw6fgV0qzaDqGirmnNxXfoTDGz1SM9bQI0dkKCL9akQLmeSfykPSoRY/
         Cdyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s6AarPquzkHm5tiN4Chfneb8capNztVCqvBC79jNDEI=;
        b=Cc3qxsV4BL7BZHnw8Cuo09MoFzJJ3G5p9DmJGoMEVAlYQCFaCR93abNXFJOUdYBBVB
         0uJhmnbWSqM12wfz9Nc/gFb6W+qlfrL+Rtp3uJF8T7uJKpba26+utOGF76Dr52ORHLbx
         4TYLLaiC4ntrJFTjfv5AI5rgI/6myGRVbMcBdINEUXijVdCCy/+HD6Zb1iO4P6EEBGsf
         9Y418OVqhJyIjVF+K+Gt+e9AN+Sx8ar2CuZXLOW2XdcOJhjXfO8lDatoA4hmSlf1FH+L
         uJASBXYA1in4VKCjc66NxJT3NaR/w2U2BMjIA8V6nCRRbE0neY4jlX/LvXXGpn3JGtN5
         VDKg==
X-Gm-Message-State: APjAAAUnKgA1M5nUs0DFW7qgKH1lAprrG29rPLSQgfvCuePGlySSu8ir
        70DeIxZli6mgR6k7ptX5fDs=
X-Google-Smtp-Source: APXvYqwk1iSnhxqLSku4/PNUxztjZNdGA3I6iDPQBqmQZsUXidUeAa0OmbTMcQGlWkqGjrxf2ArmYw==
X-Received: by 2002:a5e:9401:: with SMTP id q1mr13136195ioj.276.1560542425251;
        Fri, 14 Jun 2019 13:00:25 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id p63sm4623407iof.45.2019.06.14.13.00.24
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 14 Jun 2019 13:00:24 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v9 07/11] NFS: for "inter" copy treat ESTALE as ENOTSUPP
Date:   Fri, 14 Jun 2019 16:00:12 -0400
Message-Id: <20190614200016.12348-8-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190614200016.12348-1-olga.kornievskaia@gmail.com>
References: <20190614200016.12348-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

If the client sends an "inter" copy to the destination server but
it only supports "intra" copy, it can return ESTALE (since it
doesn't know anything about the file handle from the other server
and does not recognize the special case of "inter" copy). Translate
this error as ENOTSUPP and also send OFFLOAD_CANCEL to the source
server so that it can clean up state.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs42proc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index bbf7c1e..f8ebd77 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -393,6 +393,11 @@ ssize_t nfs42_proc_copy(struct file *src, loff_t pos_src,
 			args.sync = true;
 			dst_exception.retry = 1;
 			continue;
+		} else if (err == -ESTALE &&
+				!nfs42_files_from_same_server(src, dst)) {
+			nfs42_do_offload_cancel_async(src, &args.src_stateid);
+			err = -EOPNOTSUPP;
+			break;
 		}
 
 		err2 = nfs4_handle_exception(server, err, &src_exception);
-- 
1.8.3.1

