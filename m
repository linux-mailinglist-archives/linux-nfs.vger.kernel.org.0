Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F009B513725
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Apr 2022 16:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348410AbiD1Oqi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Apr 2022 10:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348425AbiD1Oqi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Apr 2022 10:46:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2F421E38
        for <linux-nfs@vger.kernel.org>; Thu, 28 Apr 2022 07:43:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C53541F745;
        Thu, 28 Apr 2022 14:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651156999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=4ogX/PVHTgBnVY9bfomFQYpJAsCgJeGa3J6Zuu0Pixg=;
        b=jG1HWlbSDWdfX+6R84Y9G/sWp9p+No76xWpG7nBI5WWBgMUmyG2E7Z6TTCD7/yXOKrW1yB
        +e15ck+H/kMGHQpbq1zW55hmCVfB4NPE3DWItZCMF/2DMul61AU/TGaGZuveJkrf00NhMY
        kNGGE01JAbNzdyDsGLExVF0f//4aQZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651156999;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=4ogX/PVHTgBnVY9bfomFQYpJAsCgJeGa3J6Zuu0Pixg=;
        b=Z0hsrR9HSvQkQWF8gN8tXOkvPKNHdEGRK0+RmtjovlTktCO75R9dyLd2Y/QS+5gLqkOe8s
        bN47/Wrm8s1csTCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F0EE713AF8;
        Thu, 28 Apr 2022 14:43:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /jOLOAaoamK9bwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 28 Apr 2022 14:43:18 +0000
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
Subject: [RFC PATCH 0/3] Remove RPC rup and rusers tests
Date:   Thu, 28 Apr 2022 16:43:05 +0200
Message-Id: <20220428144308.32639-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.3
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

Hi all,

IMHO safe to remove these two tests, but sending to broad audience in
case anybody really want to have these 2 kept (they'd be rewritten to
new LTP shell API).

BTW in long term I'd prefer to remove all RPC tests
(testcases/network/rpc/ directory). IMHO they should be part of libtirpc
(which has no tests), but these tests are old, messy and I'm not sure
how relevant they are nowadays.

Kind regards,
Petr

Petr Vorel (3):
  rpc: Remove rup01.sh test
  rpc: Remove rusers01.sh test
  rpc: Move rest of RPC tests to runtest/net.rpc_tests

 runtest/net.rpc                               |  8 ---
 runtest/net.rpc_tests                         |  3 ++
 scenario_groups/network                       |  1 -
 .../network/rpc/basic_tests/rup/Makefile      | 29 -----------
 .../network/rpc/basic_tests/rup/rup01.sh      | 50 -------------------
 .../network/rpc/basic_tests/rusers/Makefile   | 29 -----------
 .../rpc/basic_tests/rusers/rusers01.sh        | 50 -------------------
 testscripts/network.sh                        |  4 +-
 8 files changed, 4 insertions(+), 170 deletions(-)
 delete mode 100644 runtest/net.rpc
 delete mode 100644 testcases/network/rpc/basic_tests/rup/Makefile
 delete mode 100755 testcases/network/rpc/basic_tests/rup/rup01.sh
 delete mode 100644 testcases/network/rpc/basic_tests/rusers/Makefile
 delete mode 100755 testcases/network/rpc/basic_tests/rusers/rusers01.sh

-- 
2.35.3

