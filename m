Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 622E0EB9DE
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2019 23:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbfJaWnc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Oct 2019 18:43:32 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:39806 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbfJaWnc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Oct 2019 18:43:32 -0400
Received: by mail-yb1-f196.google.com with SMTP id q18so2640998ybq.6
        for <linux-nfs@vger.kernel.org>; Thu, 31 Oct 2019 15:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=TvuonOVBM9ZQFTtoGztRGRv+Vmenki0IRgaTsWfruHI=;
        b=B3xdmvw0MI7UxYogU+X4K710M480Lbk6obfnBGimijyROGb6mxheirD6GBWwR6xtHo
         MQWr/N/ITisZvRPCy7Vxwm8lV4loJkIMSd8p4WpRKSCv/aPy72p5lOSqZEGv7QcobLhn
         AeVZTBuZK3n+ayZKsQLj+o5LOxhFXA51008pg4U0yDsElKAvgMj8qym1qUBEHM7+fuod
         2+Q+PIL+hyhHVKKFs7AKhfY461r6svnE2gMde1tOWPV8Qs5zdXn7rbny2zBt06PFM6MI
         iUzX04AIeFurlnyvXzyfjSPXBCsqpCyW1R79iID1V3R+VRHIGNhvHb2ErkS/RFEnhHar
         UYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TvuonOVBM9ZQFTtoGztRGRv+Vmenki0IRgaTsWfruHI=;
        b=ZRMWdO84k/OlRG1dB+YfFYxRe3wYHWJfTusiCLD+yDQRnBAW7SKnbwiX293vi8ZzFk
         7d5+CYVJPFASaLheh+xA1hmL/oMvcTezAN7u3eY8MJGmo2sL4ooSo5D9ozTl/jmxYIX2
         aVQbxZDlLH2Ip6dKNCBchDbJvtlkh/SWIdWlgmawWSRiHdPVGXJzsxzbK0CfLmJacwdU
         mDuOc6l9nZvqbsCAzKHZGK69cpk/8/BK1SjsLJecF2VuXTAoDy/ob/sKdg26em/I4BHb
         Vncjsm7bFxTHBZzEKVZja+cOmgw7DvVW61fyuMkSCj2P/g+YH8dUMfti4EmEA5yKZULE
         yB0w==
X-Gm-Message-State: APjAAAWMCBbIrks+AUfmYfNWGFb1E5jYenmH4YP7/8USzomYphtKh90n
        IDKwjHY1KsAqAXBGHF9KgJSloFM=
X-Google-Smtp-Source: APXvYqyC53Tm6+2yT0qVrzV0h93aGM6RZ+uRCp1uCnUeO+BITsEygKkZAP8iZ0OXbvQcG9K5WAbklA==
X-Received: by 2002:a25:778d:: with SMTP id s135mr6843778ybc.20.1572561810867;
        Thu, 31 Oct 2019 15:43:30 -0700 (PDT)
Received: from localhost.localdomain ([50.105.87.1])
        by smtp.gmail.com with ESMTPSA id d192sm1720287ywb.3.2019.10.31.15.43.29
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 15:43:30 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 20/20] NFSv4: Don't retry the GETATTR on old stateid in nfs4_delegreturn_done()
Date:   Thu, 31 Oct 2019 18:40:51 -0400
Message-Id: <20191031224051.8923-21-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191031224051.8923-20-trond.myklebust@hammerspace.com>
References: <20191031224051.8923-1-trond.myklebust@hammerspace.com>
 <20191031224051.8923-2-trond.myklebust@hammerspace.com>
 <20191031224051.8923-3-trond.myklebust@hammerspace.com>
 <20191031224051.8923-4-trond.myklebust@hammerspace.com>
 <20191031224051.8923-5-trond.myklebust@hammerspace.com>
 <20191031224051.8923-6-trond.myklebust@hammerspace.com>
 <20191031224051.8923-7-trond.myklebust@hammerspace.com>
 <20191031224051.8923-8-trond.myklebust@hammerspace.com>
 <20191031224051.8923-9-trond.myklebust@hammerspace.com>
 <20191031224051.8923-10-trond.myklebust@hammerspace.com>
 <20191031224051.8923-11-trond.myklebust@hammerspace.com>
 <20191031224051.8923-12-trond.myklebust@hammerspace.com>
 <20191031224051.8923-13-trond.myklebust@hammerspace.com>
 <20191031224051.8923-14-trond.myklebust@hammerspace.com>
 <20191031224051.8923-15-trond.myklebust@hammerspace.com>
 <20191031224051.8923-16-trond.myklebust@hammerspace.com>
 <20191031224051.8923-17-trond.myklebust@hammerspace.com>
 <20191031224051.8923-18-trond.myklebust@hammerspace.com>
 <20191031224051.8923-19-trond.myklebust@hammerspace.com>
 <20191031224051.8923-20-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the server returns NFS4ERR_OLD_STATEID, then just skip retrying the
GETATTR when replaying the delegreturn compound. We know nothing will
have changed on the server.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 33a8e53e976c..a64ce9518776 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6198,6 +6198,10 @@ static void nfs4_delegreturn_done(struct rpc_task *task, void *calldata)
 	case -NFS4ERR_OLD_STATEID:
 		if (!nfs4_refresh_delegation_stateid(&data->stateid, data->inode))
 			nfs4_stateid_seqid_inc(&data->stateid);
+		if (data->args.bitmask) {
+			data->args.bitmask = NULL;
+			data->res.fattr = NULL;
+		}
 		goto out_restart;
 	case -NFS4ERR_ACCESS:
 		if (data->args.bitmask) {
-- 
2.23.0

