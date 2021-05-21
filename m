Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA40338BF13
	for <lists+linux-nfs@lfdr.de>; Fri, 21 May 2021 08:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhEUGLP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 May 2021 02:11:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:57866 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229978AbhEUGLP (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 21 May 2021 02:11:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D67C7AD1B;
        Fri, 21 May 2021 06:09:50 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-nfs@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>,
        "J . Bruce Fields" <bfields@redhat.com>
Subject: [PATCH pynfs 1/2] README: Prefer python3 packages over pip
Date:   Fri, 21 May 2021 08:09:42 +0200
Message-Id: <20210521060943.7223-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

These packages has been available for a long time.

Fixes: 55cfb02 ("remove redundant ply, gssapi and rpcgen.py modules")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 README | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/README b/README
index 6d9bd90..9093236 100644
--- a/README
+++ b/README
@@ -6,8 +6,7 @@ passes we expect to merge the two code bases.
 Install dependent modules; on Fedora:
 	yum install krb5-devel python3-devel swig python3-gssapi python3-ply
 on Debian:
-	apt-get install libkrb5-dev python3-dev swig python3-pip
-	pip install ply gssapi
+	apt-get install libkrb5-dev python3-dev swig python3-gssapi python3-ply
 
 You can prepare both for use with
 	./setup.py build
-- 
2.31.1

