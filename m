Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6612D38BF14
	for <lists+linux-nfs@lfdr.de>; Fri, 21 May 2021 08:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhEUGLP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 May 2021 02:11:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:57888 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231224AbhEUGLP (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 21 May 2021 02:11:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 02A86AC46;
        Fri, 21 May 2021 06:09:51 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-nfs@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>,
        "J . Bruce Fields" <bfields@redhat.com>
Subject: [PATCH pynfs 2/2] README: Add openSUSE
Date:   Fri, 21 May 2021 08:09:43 +0200
Message-Id: <20210521060943.7223-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210521060943.7223-1-pvorel@suse.cz>
References: <20210521060943.7223-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

+ sort alphabetically, improve formatting a bit

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 README | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/README b/README
index 9093236..ddb802a 100644
--- a/README
+++ b/README
@@ -3,11 +3,17 @@ the merge of what were originally two independent projects--initially
 the 4.0 pynfs code was all moved into the nfs4.0 directory, but as time
 passes we expect to merge the two code bases.
 
-Install dependent modules; on Fedora:
-	yum install krb5-devel python3-devel swig python3-gssapi python3-ply
-on Debian:
+Install dependent modules:
+
+* Debian
 	apt-get install libkrb5-dev python3-dev swig python3-gssapi python3-ply
 
+* Fedora
+	yum install krb5-devel python3-devel swig python3-gssapi python3-ply
+
+* openSUSE
+	zypper in install krb5-devel python3-devel swig python3-gssapi python3-ply
+
 You can prepare both for use with
 	./setup.py build
 which will create auto-generated files and compile any shared libraries
-- 
2.31.1

