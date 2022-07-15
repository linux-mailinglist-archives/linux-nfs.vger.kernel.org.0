Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125B85766CA
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Jul 2022 20:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiGOSdD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Jul 2022 14:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiGOSdB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Jul 2022 14:33:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F408274E18
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 11:33:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EF4A62331
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 18:33:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB06C34115;
        Fri, 15 Jul 2022 18:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657909980;
        bh=lZauevyYMhrmczytBImVDmdnYpWSoIz7E6RtNSVRKlU=;
        h=From:To:Cc:Subject:Date:From;
        b=a6CEWiX+hiyaLXqFiRHVyBJLkv+ox0Y/DFXoPWmZpiQoTRoD9QUn0lOJq03k8EAxJ
         6gFNj7cQMc1p8AQeMwQ+yb8U1Igu13ps5bofJdKwPy0dHuTTuLeVPxj6NfCBYmTmdw
         /rrAAqRqYKOeZPARZht2f/vMThUaJNojIZ9Z0GioojbbjbOF+u6WFcmsZg/mhvzqC3
         JGR48P2qO8GI/sfAryoF6rE/q4MxNa0O5snG0zK4T1Sg5i+JFjXfnkd9NZgsTtG6VA
         2577Yk1x5NX+FsgDHy1j9P29/efQrtIWzMAVC3pKX/SqlyEQ8aUp8nls5SLpmHe7qu
         DW6v0ysD7fiyA==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     neilb@suse.de, linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/2] nfsd: close potential race between open and delegation
Date:   Fri, 15 Jul 2022 14:32:55 -0400
Message-Id: <20220715183257.41129-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

v2:
- use nfsd_lookup_dentry instead of lookup_one_len

Here's a respin of the patches to fix up the potential race between an
open and delegation. I took Neil's advice an changed over to use
nfsd_lookup_dentry.

This patchset is based on top of Neil's recent patchset entitled:

    [PATCH 0/8] NFSD: clean up locking.

Tested with xfstests and it seemed to behave. I haven't done any testing
to ensure that the race is actually fixed, mainly because I don't have a
way to reliably reproduce it.

Jeff Layton (2):
  nfsd: drop fh argument from alloc_init_deleg
  nfsd: vet the opened dentry after setting a delegation

 fs/nfsd/nfs4state.c | 58 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 49 insertions(+), 9 deletions(-)

-- 
2.36.1

