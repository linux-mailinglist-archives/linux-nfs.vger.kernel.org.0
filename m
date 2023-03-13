Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B546B75EA
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Mar 2023 12:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjCMLYL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Mar 2023 07:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjCMLYJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Mar 2023 07:24:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00072A6ED
        for <linux-nfs@vger.kernel.org>; Mon, 13 Mar 2023 04:24:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90B6EB81042
        for <linux-nfs@vger.kernel.org>; Mon, 13 Mar 2023 11:24:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCB0C433EF;
        Mon, 13 Mar 2023 11:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678706646;
        bh=21HKYplHOtIJxCbbTx9Pk5u21FJZ+Ji0N0co6VDdKlc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FGwgITaKnzC6qHgp1xND/vl3mckH2cD7mpbB7FQXZ3bbRmVoGrKB3aNrz8VlgS/lt
         MQbCg8G29dFBGEW85RvydVkRjC2CH18X+gAz23JSPIBD47KS5/+F5bEYfKlUWLTgyO
         qwZ2zUNppdRq+cBbeN3l7wHUvsoqTqkIJeuOLcbUJVCL71ggyq+JeN423HchrmJzj7
         MY7MYN6naHP7PQfQgwrPURLcLUaPWPJXOxu4Ier+g8QzhxG1pNEgxxiKSadZu7Ke17
         MyosgMYE3v+M2SyCs2zh8SPPh9vmLzID1uyoJYBPq+lEwq9E+O76gKNXQa1epndi9B
         loklht7ZIESeQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     calum.mackay@oracle.com
Cc:     bfields@fieldses.org, ffilzlnx@mindspring.com,
        linux-nfs@vger.kernel.org
Subject: [pynfs PATCH v2 4/5] testserver.py: add a new (special) "everything" flag
Date:   Mon, 13 Mar 2023 07:24:00 -0400
Message-Id: <20230313112401.20488-5-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313112401.20488-1-jlayton@kernel.org>
References: <20230313112401.20488-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The READMEs for v4.0 and v4.1 are inconsistent here. For v4.0, the "all"
flag is supposed to run all of the "standard" tests. For v4.1 "all" is
documented to run all of the tests, but it actually doesn't since not
every tests has "all" in its FLAGS: field.

I really want to be able to run _all_ the tests sometimes. Add a special
case new "everything" flag that is automatically added to every test.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/testmod.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/nfs4.1/testmod.py b/nfs4.1/testmod.py
index 11e759d673fd..b3174006a0a3 100644
--- a/nfs4.1/testmod.py
+++ b/nfs4.1/testmod.py
@@ -386,6 +386,8 @@ def createtests(testdir):
     for t in tests:
 ##         if not t.flags_list:
 ##             raise RuntimeError("%s has no flags" % t.fullname)
+        if "everything" not in t.flags_list:
+            t.flags_list.append("everything")
         for f in t.flags_list:
             if f not in flag_dict:
                 flag_dict[f] = bit
-- 
2.39.2

