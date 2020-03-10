Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8865180398
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2020 17:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgCJQd1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Mar 2020 12:33:27 -0400
Received: from smtp-o-2.desy.de ([131.169.56.155]:55369 "EHLO smtp-o-2.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbgCJQd1 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 10 Mar 2020 12:33:27 -0400
X-Greylist: delayed 343 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Mar 2020 12:33:26 EDT
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [131.169.56.165])
        by smtp-o-2.desy.de (Postfix) with ESMTP id 43C801608F6
        for <linux-nfs@vger.kernel.org>; Tue, 10 Mar 2020 17:27:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de 43C801608F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1583857662; bh=dvC7ppOiuEPHX1Yh5Z6VsyjZOCxXrsRL+R76GPefWRo=;
        h=From:To:Cc:Subject:Date:From;
        b=jbphWf6JLgdrLgdmmQGInY0KCYMg6kXAb4AR6ak1319bfn2IAvPWR2/6Iv24wYYpN
         xr5fy6thY0ziVokCfKAnXL1ttkRUZR2ASjHFSFTLDyS0zWrvFxyN4m0aD+8J4GcGKJ
         BOAoF0YHEHlk7tBypv+vlLeuZ4g2Z8E89UmEhoTM=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [IPv6:2001:638:700:1038::1:82])
        by smtp-buf-2.desy.de (Postfix) with ESMTP id 3EC8C1A00A8;
        Tue, 10 Mar 2020 17:27:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at desy.de
Received: from ani.desy.de (zitpcx21033.desy.de [131.169.185.213])
        by smtp-intra-1.desy.de (Postfix) with ESMTP id 11F0EC00A2;
        Tue, 10 Mar 2020 17:27:42 +0100 (CET)
From:   Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org,
        Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Subject: [PATCH] doc: describe required python3 modules
Date:   Tue, 10 Mar 2020 17:27:20 +0100
Message-Id: <20200310162720.61835-1-tigran.mkrtchyan@desy.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

---
 README | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/README b/README
index f9d7005..79cac62 100644
--- a/README
+++ b/README
@@ -4,9 +4,9 @@ the 4.0 pynfs code was all moved into the nfs4.0 directory, but as time
 passes we expect to merge the two code bases.
 
 Install dependent modules; on Fedora:
-	yum install krb5-devel python-devel swig python-gssapi python-ply
+	yum install krb5-devel python3-devel swig python3-gssapi python3-ply
 on Debian:
-	apt-get install libkrb5-dev python-dev swig python-pip
+	apt-get install libkrb5-dev python3-dev swig python3-pip
 	pip install ply gssapi
 
 You can prepare both for use with
-- 
2.24.1

