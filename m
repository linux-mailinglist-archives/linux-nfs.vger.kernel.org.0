Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DE3787187
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Aug 2023 16:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbjHXOa7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Aug 2023 10:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjHXOab (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Aug 2023 10:30:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23679193
        for <linux-nfs@vger.kernel.org>; Thu, 24 Aug 2023 07:30:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B275960B83
        for <linux-nfs@vger.kernel.org>; Thu, 24 Aug 2023 14:30:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4EEC433C8;
        Thu, 24 Aug 2023 14:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692887429;
        bh=vG9z68vpATLEXQsIfxJ3Xb9de0Fr67vpSaOkmKK7ATI=;
        h=Subject:From:To:Cc:Date:From;
        b=DqbSYUnkGd+hFfd3DyFsGMeoHS1NfRbiktQHjDOBpQE9Tp85VK0UZAKUpOUkADwjg
         NtLULBrFLQUUaKdhAKe1MSR0WuDwXYZTVLg1FuHM5PE53BIdbPHBWVwgrbAe8g1dLy
         nXeV7157/6oLeTYTYbUssOcD24lSTOYDJrFlXlDFyZ/r1iL1oXJO3Wz8ycP7Lzjgkj
         ohLjWiw7CyBjh8BXM+R+WUArVObpfF46kpVB1oGPrR9Dq/NvLDfQ7qLPlJbDyj5WyS
         uuJU7yrJuVFX3kfS9NFDvkkZRmTcZDmJlSP93D09fMZ1wRJnZtPZHzDHIh60NHbvOH
         vzVoINj/4yJxQ==
Subject: [PATCH] NFSD: Fix a thinko introduced by recent trace point changes
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     kernel test robot <oliver.sang@intel.com>,
        Chuck Lever <chuck.lever@oracle.com>
Date:   Thu, 24 Aug 2023 10:30:27 -0400
Message-ID: <169288742767.62637.4868507858344398487.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

The fixed commit erroneously removed a call to nfsd_end_grace(),
which makes calls to write_v4_end_grace() a no-op.

Fixes: 39d432fc7630 ("NFSD: trace nfsctl operations")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202308241229.68396422-oliver.sang@intel.com
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsctl.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 1b8b1aab9a15..4302ca0ff6ed 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1105,6 +1105,7 @@ static ssize_t write_v4_end_grace(struct file *file, char *buf, size_t size)
 			if (!nn->nfsd_serv)
 				return -EBUSY;
 			trace_nfsd_end_grace(netns(file));
+			nfsd4_end_grace(nn);
 			break;
 		default:
 			return -EINVAL;


