Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1EE3722712
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Jun 2023 15:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjFENNV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 5 Jun 2023 09:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbjFENNT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 5 Jun 2023 09:13:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745E7DA
        for <linux-nfs@vger.kernel.org>; Mon,  5 Jun 2023 06:12:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A08761156
        for <linux-nfs@vger.kernel.org>; Mon,  5 Jun 2023 13:12:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B748C433D2;
        Mon,  5 Jun 2023 13:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685970766;
        bh=sfeI5SrT3HU34NjZ2sV8WArVN9Lwaw12fKBFtOALA3s=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hWQkvZQ2rkXbaPnM35aBjemrbnX5HslCgTmT/++kLb851uZN010NVxOIPodefGUGq
         rWP1hvOd8ZW6ROEZGBMLhKZoM1fO/srci5OZSk4rCddqp5Ubm/cCT5VEVfhRigIFjW
         LTND3fQKo5CVoMuydzGN2mGd8oHmqKKyr7KSG3lRQYdG7mDF7TOzXJep2sofWkdkcv
         DZ1ddW5OmP26n93eNjCHB+RPfma3JFWxcMFSeJfIGN7zgaao6GKDEXnf0nADatEdE0
         wOlx9+2egXJFX3hKbpdNg2H/H/xX/tYGqZPbsOCi2COFUgf7DcxjW4V/hQJ+hpnFH2
         42W99cxfW/IBA==
Subject: [PATCH 2/2] NFSD: Add "official" reviewers for this subsystem
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, bfields@fieldses.org
Date:   Mon, 05 Jun 2023 09:12:45 -0400
Message-ID: <168597076526.7827.11325261490687801622.stgit@manet.1015granger.net>
In-Reply-To: <168597075880.7827.6268299078653725756.stgit@manet.1015granger.net>
References: <168597075880.7827.6268299078653725756.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

At LFS 2023, it was suggested we should publicly document the name and
email of reviewers who new contributors can trust. This also gives them
some recognition for their work as reviewers.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 MAINTAINERS |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0dab9737ec16..a44d0707754f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11264,6 +11264,9 @@ W:	http://kernelnewbies.org/KernelJanitors
 KERNEL NFSD, SUNRPC, AND LOCKD SERVERS
 M:	Chuck Lever <chuck.lever@oracle.com>
 M:	Jeff Layton <jlayton@kernel.org>
+R:	Olga Kornievskaia <kolga@netapp.com>
+R:	Dai Ngo <Dai.Ngo@oracle.com>
+R:	Tom Talpey <tom@talpey.com>
 L:	linux-nfs@vger.kernel.org
 S:	Supported
 W:	http://nfs.sourceforge.net/


