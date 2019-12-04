Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30B851122D1
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Dec 2019 07:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbfLDGNb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Dec 2019 01:13:31 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:42961 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725791AbfLDGNb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Dec 2019 01:13:31 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 8387F9D0;
        Wed,  4 Dec 2019 01:13:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 04 Dec 2019 01:13:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=D9GMc4lk4p1vl
        W1R/dETqnGkGgAzApGh9izz/ZsfcXQ=; b=hYc7qVAU23A0DlMFm4MijXKkPZlbb
        nAgV89aXDwbfByQLZutgJC9gCeKEqneUBNFAUmmEyh03MG6+eRglj0xX84Imq7Y8
        5GGO185Qw+Vw+4f6fliQ60rePxNMEDH5TE7nmze+OtpAQeCAlxLAlMCCRnBGJ3ir
        +/MrkHXP3TFGP+KdNXRUcPiRQzFHDih5jJiKI85r4n3qFEOGvnz+w/PIRZJryrEE
        We4VR6/7BmEWlKnzqYFb1VE67hKOhz76lOKVjOj8UW6PZcWUJ6ejHvdcccZF4BfL
        /wCJnAL+kwL0jBz/9F+r3BG8eLfhds5wYpBP6OQc/F40jTOoKpeqKYotg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=D9GMc4lk4p1vlW1R/dETqnGkGgAzApGh9izz/ZsfcXQ=; b=wVCIJ3x7
        +7KsuO5NLWFKiz5t1Z0yq2uvYAa1JrBs1juFadIr4As0i2dANuJa1Gg0KlF9i2ik
        qqcXuMmjtDGPh5xzQSzcTR6Yn4ikJ/ONu9izg6IAJiMloGv2rpq2XyVG6icUGpGi
        RzU6VsaImdQxY0kvKoCCMezUdeA43jV5H9rJ5EQX5b/CLru35n4GxACFYIot14XI
        xsNQucHQCcSfyfKXXBzqLe4sORcXxKW7eFDuHEUDXA/8/wiOVJBogmbyWw736Csa
        UTWpg3rZArzBnr/IcT6YeD1jF+rrhw7ZK8m9zn0wbiji5TsjCc1f9WS62xzYDJBA
        H7Kj2ZKosZpm9g==
X-ME-Sender: <xms:iU7nXUNnf28hJ_XcIrlxKYkb0ewhNCaUS7kmEfeqQEdK-Ra06OQaKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudejkedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepjeekrdehge
    drhedtrddvheegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmnecu
    vehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:iU7nXTltFzM4IWCV5VWOGVolq457yhwKt0pG7Ij52VBO1P6acRe0aw>
    <xmx:iU7nXSuKi-JHs1DdWF6ZngNSMlkJZJBy_xk_Xj6i3DwW9uM48IhGOw>
    <xmx:iU7nXWqR-0w7vx8EHAuKbaWalVDEnihUXineVpMprphegoM-RLpcGQ>
    <xmx:ik7nXZ9Nm1lTUJYTakSATosw-PNCE9hE8AIRWDrpDfF1qfFKW2O6vw>
Received: from vm-mail (x4e3632fe.dyn.telefonica.de [78.54.50.254])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2737480060;
        Wed,  4 Dec 2019 01:13:29 -0500 (EST)
Received: from localhost (<unknown> [10.192.0.11])
        by vm-mail (OpenSMTPD) with ESMTPSA id f862a361 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 4 Dec 2019 06:13:27 +0000 (UTC)
From:   Patrick Steinhardt <ps@pks.im>
To:     linux-nfs@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>,
        Chuck Lever <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@fieldses.org>
Subject: [PATCH v2] nfsd: depend on CRYPTO_MD5 for legacy client tracking
Date:   Wed,  4 Dec 2019 07:13:22 +0100
Message-Id: <7af3028bd374451f35e36a6c289c44d9c932ee71.1575439669.git.ps@pks.im>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <d411d31bcde3e0221d54ee8bb5af80772a277cad.1575355896.git.ps@pks.im>
References: <d411d31bcde3e0221d54ee8bb5af80772a277cad.1575355896.git.ps@pks.im>
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

The explicit dependency on CRYPTO_MD5 was removed as redundant back in
6aaa67b5f3b9 (NFSD: Remove redundant "select" clauses in fs/Kconfig
2008-02-11) as it was already implicitly selected via RPCSEC_GSS_KRB5.
This broke when RPCSEC_GSS_KRB5 was made optional for NFSv4 in commit
df486a25900f (NFS: Fix the selection of security flavours in Kconfig) at
a later point.

Fix the issue by adding back an explicit dependency on CRYPTO_MD5.

Fixes: df486a25900f (NFS: Fix the selection of security flavours in Kconfig)
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

The only change compared to v1 is in the commit message. As
pointed out by Chuck, it wasn't actually commit 6aaa67b5f3b9
which broke it, but the later df486a25900f. I've reworded the
commit message and fixed the Fixes tag to account for that.

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

