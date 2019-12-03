Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE4C10F81C
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Dec 2019 07:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfLCGwQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Dec 2019 01:52:16 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42653 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727156AbfLCGwQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Dec 2019 01:52:16 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 1A83222A99;
        Tue,  3 Dec 2019 01:52:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 03 Dec 2019 01:52:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=YibBEiiph7kWPE9JD0Cp6skuUW
        6tEyozUdQEeL8yUnU=; b=vVv1iYOS72OBcc6Uuo0w9AIJlE/WFKWfU4A0D3p+vE
        hI3mS85ZFEGlSx9ShpkubHFHRpvLnXx9vP/sz4/hLmj7mxyeJLyh5wyHVWNMGTQh
        7VmiYIDsqaTFyfYqyqIOhPxaGg8HDY6BzThcg+SaRxSPO3Ms6nKYs+DUCg+0N6oN
        3iEQv6Y+JvbW8+auYrB91D6sM7/6zVdSJnFG4jC3duZcPTkdOy8foL74JMQCQ2jt
        WX66IcDQmBTa+8vgP5ExEDy0opKSrUInJ4yzaZLXjD1ulzh2cA544z3zjoN0T/nV
        x0mRBZgb2J160Ba77aMFHqCui7c04nZx6hKFPSfRCBRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=YibBEiiph7kWPE9JD
        0Cp6skuUW6tEyozUdQEeL8yUnU=; b=R2N7Hus6uBJwkor6+uBn3HO9bRwqm+RtE
        pTce7ZLQDKKSHkM0WJD03hbQjHj/ofxgmgZp38NUcw9VM5Zar8jmwQlBDDofa72o
        CZwkXBEDQOURmYyooQFDIM7pPyyvjdTEWIFnL4Wd3vS4YiFDqjnz9Raz6KCSESKq
        5Q65XJccnwGVceyoP/m51MGl1/t0DTlHAyJNI6D4a1wS+qCymd7eBBWE0lwRqigh
        KPsMRR68DhalzpDLtDHhqny7JCb4d/h0L52Emr/rVEvqdmmeUvqBhQOIfYD4FQzk
        TSnwuTcJ5FQQhM0Qga5fJWi1/oLaJoHQyNsESm/eWbowtCW02hyTw==
X-ME-Sender: <xms:HgbmXYdTXMmeDGfINLA5mlVzOlSkRcJlvBc4DbVnXASt_3ZE_R3ZMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudejiedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepjeekrdehgedrud
    eftddrvddtjeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhenucev
    lhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:HgbmXYIiCBiqfpabttODftSB-A4JIllLnrTKwjVk8bzB8c49o9FfbQ>
    <xmx:HgbmXb2-wA01_-ReB-LYlFnxZ2sQZBbOikGgYBFmRHeTytBF0EJWJg>
    <xmx:HgbmXShfbguaP70tmyZwAzk1aOeHGyGnca2SkgDmcFM5mnmkkDRhAA>
    <xmx:HwbmXZNJ_lF8HJ931M_QSLoaxYaY7JztWxcqfnYNk__NKA4DoKjkGw>
Received: from vm-mail (x4e3682cf.dyn.telefonica.de [78.54.130.207])
        by mail.messagingengine.com (Postfix) with ESMTPA id DC20B3060158;
        Tue,  3 Dec 2019 01:52:13 -0500 (EST)
Received: from localhost (<unknown> [10.192.0.11])
        by vm-mail (OpenSMTPD) with ESMTPSA id 76b25207 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 3 Dec 2019 06:52:11 +0000 (UTC)
From:   Patrick Steinhardt <ps@pks.im>
To:     linux-nfs@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>,
        Chuck Lever <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@fieldses.org>
Subject: [PATCH] nfsd: depend on CRYPTO_MD5 for legacy client tracking
Date:   Tue,  3 Dec 2019 07:52:09 +0100
Message-Id: <d411d31bcde3e0221d54ee8bb5af80772a277cad.1575355896.git.ps@pks.im>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The legacy client tracking infrastructure of nfsd makes use of MD5 to
derive a client's recovery directory name. As the nfsd module doesn't
declare any dependency on CRYPTO_MD5, though, it may fail to allocate
the hash if the kernel was compiled without it. As a result, generation
of client recovery directories will fail with the following error:

    NFSD: unable to generate recoverydir name

The dependency was removed as a seemingly redundant dependency back in
6aaa67b5f3b9 (NFSD: Remove redundant "select" clauses in fs/Kconfig
2008-02-11). But in fact, even then the MD5 module was pulled in only
when RPCSEC_GSS_KRB5 or RPCSEC_GSS_KRB5 was selected.

Fix the issue by adding back an explicit dependency on CRYPTO_MD5.

Fixes: 6aaa67b5f3b9 (NFSD: Remove redundant "select" clauses in fs/Kconfig)
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 fs/nfsd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index c4b1a89b8845..f2f81561ebb6 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -73,6 +73,7 @@ config NFSD_V4
 	select NFSD_V3
 	select FS_POSIX_ACL
 	select SUNRPC_GSS
+	select CRYPTO_MD5
 	select CRYPTO_SHA256
 	select GRACE_PERIOD
 	help
-- 
2.24.0

