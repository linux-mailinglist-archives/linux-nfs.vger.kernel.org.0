Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFE57F1CF4
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Nov 2023 19:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjKTSxl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Nov 2023 13:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjKTSxj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Nov 2023 13:53:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D7111C
        for <linux-nfs@vger.kernel.org>; Mon, 20 Nov 2023 10:53:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274B0C433C8;
        Mon, 20 Nov 2023 18:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700506414;
        bh=o2L0DvEBtsG4wxnURb/M/iPk+6At3WpGNDfOuVyJhBo=;
        h=Subject:From:To:Cc:Date:From;
        b=OANBxGt6VEykGHW7pIIwzpADtldfidFz47mGE0FwjZofc3IRxrviKXFF37+6OD3qa
         cwKZFExMNacWjq0YzEZi/FT2uMQj/mnDN5Jh3M0mWmxlv2USgxSiZQMrO7n2Fa5Hj+
         2+uqv+AOJQi/SltFYuz74xIG8c41TdEjLd0LA2qJnvvKsGMHSpPs4YPl0QFZCQKROi
         yqQx75LlodXuR0Ry27bBBhbfuoVr+83xvBCLUQWktxWd0t03+Ms1pYDL1zsa5nAX4P
         AG8xn7z/DFkknNAQku/aTHZJJsyzDC9WTzrKvLYxzz9tORdv0xF9Xcjq/QRlDaGJkD
         HfWm2Jh1Movaw==
Subject: [PATCH RFC 0/5] Possible changes to nfs-utils junction support
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 20 Nov 2023 13:53:32 -0500
Message-ID: <170050610386.123525.8429348635736141592.stgit@manet.1015granger.net>
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

Bruce suggested, years ago, that the nfsref command should become
the premier administrative interface for managing NFSD's referral
behavior.

Towards that end, some clean-up is needed for the nfsref command in
nfs-utils, which is presented for review here.

I'm hesitant to introduce more documentation at this time for the
refer= and replica= export options if we plan to remove them in the
medium term.

---

Chuck Lever (5):
      junction: Replace xmlParseMemory
      junction: Remove xmlIndentTreeOutput
      nfsref: Remove unneeded #include in utils/nfsref/nfsref.c
      nfsref: Improve nfsref(5)
      configure: Make --enable-junction=yes the default


 configure.ac            |  6 ++---
 support/junction/xml.c  |  3 +--
 utils/nfsref/nfsref.c   |  2 --
 utils/nfsref/nfsref.man | 60 +++++++++++++++++++++--------------------
 4 files changed, 35 insertions(+), 36 deletions(-)

--
Chuck Lever

