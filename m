Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224A752721E
	for <lists+linux-nfs@lfdr.de>; Sat, 14 May 2022 16:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiENOnt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 14 May 2022 10:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbiENOns (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 14 May 2022 10:43:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3311169
        for <linux-nfs@vger.kernel.org>; Sat, 14 May 2022 07:43:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D0E160F2F
        for <linux-nfs@vger.kernel.org>; Sat, 14 May 2022 14:43:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9234C340EE;
        Sat, 14 May 2022 14:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652539427;
        bh=ekpxxSHQOhoQT+MNlgdvANvBeBg43YWRvtUqLr+L4PY=;
        h=From:To:Cc:Subject:Date:From;
        b=V0oC/7MTErw7As80hxKxQGabw36Xq7+LX+xJmSo9feo4Y5PzMHl8xeg6tmdSdkJav
         +q87a4UO7wRnYC9zlRFXPxLrKDC50FUaZsNE+ILIe7DhbGNgBcFm1pbZSm+156kh00
         603pOHbH1SSrA0nKA9qB/dUQhkbFHD1OXlO2fPh6KD8Qry8Zmnp+VQmCub3DLbSNg2
         yzvOM7yipC//iL9xGjWlbZb2x05Y/qsYpUmJFHldgyU9RIfd4G3Fzwn3U1nSyJLs7L
         ZnthKQxOrIdLVrbq/R/kbq2t3Xsk2k94Zblxxg15EmpCy3SRuuIWCCH/gmD8etLqjA
         LdGviPI0MTExg==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/3] Export the NFSv4.1 'dacl' and 'sacl' attributes
Date:   Sat, 14 May 2022 10:36:57 -0400
Message-Id: <20220514143700.4263-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

This patch series allows the NFSv4 client to also export the NFSv4.1
'dacl' and 'sacl' attributes.
The main differences with respect to the existing NFSv4 'acl' attribute
are:

1) by splitting out the 'sacl' component, the server is free to enforce
   stronger privilege requirements against users that want to read or
   modify the sacl auditing features, while still allowing ordinary
   users to read and modify the 'dacl'.
2) Support for automatic inheritance of acls.

These two differences do mean that the acl tools will need some
modifications in order to make use of the new functionality.

Trond Myklebust (3):
  NFSv4: Specify the type of ACL to cache
  NFSv4: Add encoders/decoders for the NFSv4.1 dacl and sacl attributes
  NFSv4.1: Enable access to the NFSv4.1 'dacl' and 'sacl' attributes

 fs/nfs/nfs4proc.c       | 137 +++++++++++++++++++++++++++++++++-------
 fs/nfs/nfs4xdr.c        |  95 ++++++++++++++++++----------
 include/linux/nfs4.h    |   2 +
 include/linux/nfs_xdr.h |  10 +++
 4 files changed, 189 insertions(+), 55 deletions(-)

-- 
2.36.1

