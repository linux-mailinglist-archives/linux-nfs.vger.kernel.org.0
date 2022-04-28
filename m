Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5BBD513724
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Apr 2022 16:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348516AbiD1Oqi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Apr 2022 10:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348410AbiD1Oqh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Apr 2022 10:46:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F224B2229C
        for <linux-nfs@vger.kernel.org>; Thu, 28 Apr 2022 07:43:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8276E1F88C;
        Thu, 28 Apr 2022 14:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651157001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2236OomT19gEtKhxK33QRMW3jdIXdbQrFmALWNIROjE=;
        b=DwibZncySK0e3JrmcIfeUMYue8ixyQGQCgzafI6AgH2In2cDrzokBp9ZamXOeM64kfJRii
        UZzADOcV4x8WbvjfeJbXJJlcIFh+sIIVi4h1HVzAdT0oH112JKlIF8/9f+Nfok7hPeIYuR
        rvAxtelvO8yLh6EDZMVe+M91YKT08cM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651157001;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2236OomT19gEtKhxK33QRMW3jdIXdbQrFmALWNIROjE=;
        b=yvd229LU2RRTy1RK9BkX9qfenbDiji6NfgtpY5pmppzdFwnwcnRjPM9VxELOCN5EJwlhfj
        Tq8ec6lI14MargCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C06B513AF8;
        Thu, 28 Apr 2022 14:43:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8MxwLAioamK9bwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 28 Apr 2022 14:43:20 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>, Steve Dickson <steved@redhat.com>,
        libtirpc-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        Cyril Hrubis <chrubis@suse.cz>,
        automated-testing@yoctoproject.org, Li Wang <liwang@redhat.com>,
        Jan Stancek <jstancek@redhat.com>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Veronika Kabatova <vkabatov@redhat.com>,
        Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Subject: [RFC PATCH 2/3] rpc: Remove rusers01.sh test
Date:   Thu, 28 Apr 2022 16:43:07 +0200
Message-Id: <20220428144308.32639-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220428144308.32639-1-pvorel@suse.cz>
References: <20220428144308.32639-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

rusersd is a RPC daemon which returns information about users currently
logged in to the system. It uses rusers on client side.

Latest release of netkit-rusers 0.17 was in 2001. Although it's still
installable on Debian, IMHO whole technology is not used nowadays.

As we have other RPC tests (both RPC/TI-RPC and RPC integration, i.e.
NFS), we don't need to test this particular implementation. If this
implementation is really useful, it should be moved into libtirpc
project.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/net.rpc                               |  1 -
 .../network/rpc/basic_tests/rusers/Makefile   | 29 -----------
 .../rpc/basic_tests/rusers/rusers01.sh        | 50 -------------------
 3 files changed, 80 deletions(-)
 delete mode 100644 testcases/network/rpc/basic_tests/rusers/Makefile
 delete mode 100755 testcases/network/rpc/basic_tests/rusers/rusers01.sh

diff --git a/runtest/net.rpc b/runtest/net.rpc
index ccee1dda7..d2cec5b93 100644
--- a/runtest/net.rpc
+++ b/runtest/net.rpc
@@ -4,4 +4,3 @@
 #
 rpc01 rpc01.sh
 rpcinfo rpcinfo01.sh
-rusers rusers01.sh
diff --git a/testcases/network/rpc/basic_tests/rusers/Makefile b/testcases/network/rpc/basic_tests/rusers/Makefile
deleted file mode 100644
index 345365171..000000000
--- a/testcases/network/rpc/basic_tests/rusers/Makefile
+++ /dev/null
@@ -1,29 +0,0 @@
-#
-#    network/rpc/basic_tests/rusers01.sh test suite Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= rusers01.sh
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/basic_tests/rusers/rusers01.sh b/testcases/network/rpc/basic_tests/rusers/rusers01.sh
deleted file mode 100755
index 554bfa01c..000000000
--- a/testcases/network/rpc/basic_tests/rusers/rusers01.sh
+++ /dev/null
@@ -1,50 +0,0 @@
-#!/bin/sh
-# Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
-# Copyright (c) International Business Machines  Corp., 2000
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program. If not, see <http://www.gnu.org/licenses/>.
-
-TCID="rusers01"
-TST_TOTAL=5
-
-TST_USE_LEGACY_API=1
-. tst_net.sh
-
-do_setup()
-{
-	tst_resm TINFO "Checking for rusersd on $(tst_ipaddr)"
-	rpcinfo -u $(tst_ipaddr) rusersd > /dev/null 2>&1 || \
-		tst_brkm TCONF "rusersd is inactive on $(tst_ipaddr)"
-}
-
-do_test()
-{
-	tst_resm TINFO "Test rusers with options set"
-
-	EXPECT_RHOST_PASS rusers $(tst_ipaddr)
-
-	local opts="-a -l"
-	for opt in $opts; do
-		EXPECT_RHOST_PASS rusers $opt $(tst_ipaddr)
-	done
-
-	tst_resm TINFO "Test rusers with bad options"
-	EXPECT_RHOST_FAIL rusers bogushost
-	EXPECT_RHOST_FAIL rusers -bogusflag $(tst_ipaddr)
-}
-
-do_setup
-do_test
-
-tst_exit
-- 
2.35.3

