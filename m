Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E4D523FBD
	for <lists+linux-nfs@lfdr.de>; Wed, 11 May 2022 23:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238018AbiEKVww (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 May 2022 17:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiEKVwu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 May 2022 17:52:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D44F68A1
        for <linux-nfs@vger.kernel.org>; Wed, 11 May 2022 14:52:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11490B82630
        for <linux-nfs@vger.kernel.org>; Wed, 11 May 2022 21:52:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C33C340EE;
        Wed, 11 May 2022 21:52:46 +0000 (UTC)
Subject: [PATCH RFC 0/2] Fix "sleep while locked" in RELEASE_LOCKOWNER
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     trondmy@hammerspace.com, bfields@fieldses.org, jlayton@redhat.com,
        dai.ngo@oracle.com
Date:   Wed, 11 May 2022 17:52:44 -0400
Message-ID: <165230584037.5906.5496655737644872339.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5.dev1+g8516920
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This short series passes the usual tests on NFSv4.0. We still do not
have a reproducer for the splat, though, so it's not known if the
issue has been fully addressed.

Because this is a long-standing issue and we do not have a
reproducer, I'm inclined to be conservative and push this in v5.19
rather than in v5.18-rc.

Thoughts, questions, and virtual rotten fruit welcome.

---

Chuck Lever (2):
      NFSD: nfsd4_release_lockowner() should drop clp->cl_lock sooner
      NFSD: nfsd_file_put() can sleep


 fs/nfsd/filecache.c |  2 ++
 fs/nfsd/nfs4state.c | 56 ++++++++++++++++++++-------------------------
 2 files changed, 27 insertions(+), 31 deletions(-)

--
Chuck Lever

