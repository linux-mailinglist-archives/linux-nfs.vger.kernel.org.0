Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB705751C8
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Jul 2022 17:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239872AbiGNP2Z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Jul 2022 11:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240163AbiGNP2Z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Jul 2022 11:28:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707094A806
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 08:28:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20B60B823EF
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 15:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52115C34114;
        Thu, 14 Jul 2022 15:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657812501;
        bh=bFjxaIUTnnDoW4zI+ASN9c+4WEQq2zjy4uxzo3aN4dc=;
        h=From:To:Cc:Subject:Date:From;
        b=Zve+pIV7+Vx4zw58K/x0VRWB7eFjz481VXYG5mHi8SaKdoORJuPDz8IKzuD1f1dT9
         mLNga9+2mhE6f0bGMBJBAU3zEAscMeyCYaBnpPyw03CS2CNCDowKy+DGJfCzvdpaz1
         OaW+NU30WU5Foi+YQHaVKDVnirnBXR8Lsqkpg6yYsHd9X02YwJup2RI3pfJxKaHKog
         xeone5FJ21nWk6/TBvYW8QW+gwAAzDXwxq/zxVbgNdEukKReRZ/T5kaFYF7TADg1dU
         UQI26PMUIy4lpWNpBkPgJBfgv92IVqEwp137TwgeYUNT0u850EnNVBjUk9VrQT8+VW
         dT6pzvZpIhD5A==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     neilb@suse.de, linux-nfs@vger.kernel.org
Subject: [RFC PATCH 0/3] nfsd: close potential race between open and setting delegation
Date:   Thu, 14 Jul 2022 11:28:16 -0400
Message-Id: <20220714152819.128276-1-jlayton@kernel.org>
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

Here's a first stab at a patchset to close a potential race when setting
a delegation on a file. Between the point where we open the file and
where we set the delegation, another task or client could unlink or
rename the dentry. If that occurs, we shouldn't hand out a delegation
in the open response, but we don't prevent that today.

The basic idea here is to re-do the lookup after setting the delegation.
If the resulting dentry is not the one we have in the open, then we can
reject handing out a delegation.

Only lightly tested, so this is an RFC for now.

Jeff Layton (3):
  nfsd: drop fh argument from alloc_init_deleg
  nfsd: rework arguments to nfs4_set_delegation
  nfsd: vet the opened dentry after setting a delegation

 fs/nfsd/nfs4state.c | 65 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 55 insertions(+), 10 deletions(-)

-- 
2.36.1

