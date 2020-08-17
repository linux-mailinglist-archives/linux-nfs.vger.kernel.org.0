Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC509246FB0
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Aug 2020 19:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731596AbgHQRwC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Aug 2020 13:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731593AbgHQRv5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Aug 2020 13:51:57 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3494DC061342;
        Mon, 17 Aug 2020 10:51:55 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 9so13962310wmj.5;
        Mon, 17 Aug 2020 10:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+34KLd4J1/hgr5QBvPHrlfQB6mFqUcXdhfixALEzp/c=;
        b=qe3/6KY/1aTKBl1WQFgXFC40bTLgZOhTgB+yybOXo/tGEKIa0WRgScLkwV33tS+ULG
         oIJ19F5ZwhqTlECblt1iol+TLr9mlxxn9kdL/Wj5WQwuoMJV7zeqx1Jy2Pd38nDkLilr
         3pAnSSkRXsTvSCiyUhG6pqtpkIYQxiZfa9xPUxELUcfgSy4N3YQgNSl0OMNHuGYjvLDB
         L8597F33Gu1VWUAywWhF+7O47/jA6pXlYQU4p8U+WUYzVzdaUfMDAPs2HLg9SXtRWCCX
         lMI8avypezSj448rVviZn/04ab7wDAYaePMGIc0nJzDwD8dfksX/gpebm1ceeCBtSPrv
         dIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+34KLd4J1/hgr5QBvPHrlfQB6mFqUcXdhfixALEzp/c=;
        b=PW+2y40aQrxqPx+yYzIms/0KbpZhEcE7xzfMVPrZRY2qLt3PbsOFSi7N/FvBFQX637
         /mmloFb4Yk6oSOEWL7yR1mHVdWru7Z04b7BL1aT0uOQ/Uox+r/vl4AhHB3E1bpug6jQK
         VZ28eE3UmaGL33UapZV3AnyZMfnFSUJRFpFjrdb1VPkpTNFrkp35GFio1DQN/ACfg3uG
         HtZkVoUw7Fjx2O84NwkE8lbdG2c2d4pc32xFFXowSTXLTujALpV+EuMQeCQH6WjzJCz+
         FM6GcT4eACdcsL/upmHNDtxRmiu8l2XhAvpDahTYdaRbH7rnZPTk1dRSomR3ALxN0BB6
         bilA==
X-Gm-Message-State: AOAM531r6vbHuoT4xZhcpzXuxo9cEuPRt4CfErr4MSQM6Tz3A+o6GlKc
        THZqKJyNHrVDddRZx/p7ieqYUmDMDiUMp17U
X-Google-Smtp-Source: ABdhPJzGgoktrcxtenVcIw5km7o778RFF8aKHINYvTEPT0kBbK7+bgi75b8Od5p3vgeaWcJZsQRTVA==
X-Received: by 2002:a05:600c:2189:: with SMTP id e9mr16412074wme.171.1597686714011;
        Mon, 17 Aug 2020 10:51:54 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id d14sm32738176wre.44.2020.08.17.10.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 10:51:53 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alex Dewar <alex.dewar90@gmail.com>
Subject: [PATCH] nfsd: Fix typo in comment
Date:   Mon, 17 Aug 2020 18:51:26 +0100
Message-Id: <20200817175125.6441-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Missing "is".

Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
Ahh I see. Is this better?
---
 fs/nfsd/nfs4xdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 259d5ad0e3f47..309a6d5f895ae 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4828,7 +4828,7 @@ nfsd4_encode_listxattrs(struct nfsd4_compoundres *resp, __be32 nfserr,
 		slen = strlen(sp);
 
 		/*
-		 * Check if this a user. attribute, skip it if not.
+		 * Check if this is a user. attribute, skip it if not.
 		 */
 		if (strncmp(sp, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
 			goto contloop;
-- 
2.28.0

