Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EEB6A970F
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Mar 2023 13:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjCCMQK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Mar 2023 07:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjCCMQI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Mar 2023 07:16:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEFF5F530
        for <linux-nfs@vger.kernel.org>; Fri,  3 Mar 2023 04:16:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B142B816C6
        for <linux-nfs@vger.kernel.org>; Fri,  3 Mar 2023 12:16:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824EBC433D2;
        Fri,  3 Mar 2023 12:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677845765;
        bh=d+vS7aLD32ApGNEGIONAfRIL2nmxiThftv2ypu9ZU/I=;
        h=From:To:Cc:Subject:Date:From;
        b=vCH11S3e2+HS5HFrIWXeoYi38yn2DYed4gBIzzELVQjpNOcPP3u/O4DgMlhLA/Kpv
         cpPttrwU7QXsfNeLn1nHKyP3aZ5/ZKT9346ma1xOo09TltQ45foRoHNrS5TVwKQtJX
         p9amNOoMIMQiWcyA+RXdJ6SJmDoVydycRhSIF2/l1htYDsaWc1B5dn84NsQ4JTk3kX
         ZJXzSv8b6IkI2AjcqDVohr8IxJNkL5ARyikHnR7T3ny3qtRIWErIwuQQEjuHucylDj
         n2HsGaeLumcq9L1n8pZ18aMUDeLEW2EtiadnRaorjVKJblnwTq7ugAFkJJvtjjw9HG
         ws8Mu9HIk8sFA==
From:   Jeff Layton <jlayton@kernel.org>
To:     trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, yoyang@redhat.com
Subject: [PATCH 0/7] lockd: fix races that can result in stuck filelocks
Date:   Fri,  3 Mar 2023 07:15:56 -0500
Message-Id: <20230303121603.132103-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.2
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

I sent the first patch in this series the other day, but didn't get any
responses. Since then I've had time to follow up on the client-side part
of this problem, which eventually also pointed out yet another bug on
the server side. There are also a couple of cleanup patches in here too,
and a patch to add some tracepoints that I found useful while diagnosing
this.

With this set on both client and server, I'm now able to run Yongcheng's
test for an hour straight with no stuck locks.

Jeff Layton (7):
  lockd: purge resources held on behalf of nlm clients when shutting
    down
  lockd: remove 2 unused helper functions
  lockd: move struct nlm_wait to lockd.h
  lockd: fix races in client GRANTED_MSG wait logic
  lockd: server should unlock lock if client rejects the grant
  nfs: move nfs_fhandle_hash to common include file
  lockd: add some client-side tracepoints

 fs/lockd/Makefile           |  6 ++-
 fs/lockd/clntlock.c         | 58 +++++++++++---------------
 fs/lockd/clntproc.c         | 42 ++++++++++++++-----
 fs/lockd/host.c             |  1 +
 fs/lockd/svclock.c          | 21 ++++++++--
 fs/lockd/trace.c            |  3 ++
 fs/lockd/trace.h            | 83 +++++++++++++++++++++++++++++++++++++
 fs/nfs/internal.h           | 15 -------
 include/linux/lockd/lockd.h | 29 ++++++-------
 include/linux/nfs.h         | 20 +++++++++
 10 files changed, 200 insertions(+), 78 deletions(-)
 create mode 100644 fs/lockd/trace.c
 create mode 100644 fs/lockd/trace.h

-- 
2.39.2

