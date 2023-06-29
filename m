Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA10742B8A
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jun 2023 19:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjF2Ruj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Jun 2023 13:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjF2Rui (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Jun 2023 13:50:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B541FC3
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 10:50:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53384615BF
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 17:50:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D0FC433C8;
        Thu, 29 Jun 2023 17:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688061034;
        bh=YfqCbZ8Mdi+OnDSnY5W3s0dn426L5N4jxvXFTnzRtbY=;
        h=Subject:From:To:Cc:Date:From;
        b=lty06wN6kTsICFjYX0e5fF7+RA/SdZ3Uvz/iXvS8BleOLFoNyowKQs2L4VhfL2kH5
         6pct9yLeN++CdiTeeR13no+40QTVvfVttPdtDGCTKhidyldZeTetf2JK7WMNstMxdU
         c3a9eJrH6tR58CqhsE1vjn29e8t5GXlIasEDkXdaAlC4vrnqvZ9ntu0hWUs6vBD/Ko
         9KaZnma30IVa9ZBfiyzOPi6YAQ7zdVDjEGAzgG6mSq8mp6vQDWi/TkUzIjwrDEt+hW
         UK7PhgK2fmh/RIZQxD39Fz8CWnZOvGFp34QUTcBbDZ+y7FwHupDJrV3KU8RzkaC27q
         h814vbEdz63Tg==
Subject: [PATCH v1 0/9] Remove support for DES-based Kerberos enctypes
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, dhowells@redhat.com,
        simo@redhat.com, smayhew@redhat.com
Date:   Thu, 29 Jun 2023 13:50:33 -0400
Message-ID: <168806089210.507650.17584608037244782863.stgit@morisot.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

As we agreed, v6.6 will remove support for DES-based Kerberos
enctypes from the kernel's SunRPC GSS implementation. Here's a
series to do that.

This has been compile-tested only. Comments and further testing are
welcome.

---

Chuck Lever (9):
      SUNRPC: Remove RPCSEC_GSS_KRB5_ENCTYPES_DES
      SUNRPC: Remove Kunit tests for the DES3 encryption type
      SUNRPC: Remove DES and DES3 enctypes from the supported enctypes list
      SUNRPC: Remove code behind CONFIG_RPCSEC_GSS_KRB5_SIMPLIFIED
      SUNRPC: Remove krb5_derive_key_v1()
      SUNRPC: Remove gss_import_v1_context()
      SUNRPC: Remove CONFIG_RPCSEC_GSS_KRB5_CRYPTOSYSTEM
      SUNRPC: Remove the ->import_ctx method
      SUNRPC: Remove net/sunrpc/auth_gss/gss_krb5_seqnum.c


 net/sunrpc/.kunitconfig                 |   1 -
 net/sunrpc/Kconfig                      |  35 ---
 net/sunrpc/auth_gss/Makefile            |   2 +-
 net/sunrpc/auth_gss/gss_krb5_internal.h |  23 --
 net/sunrpc/auth_gss/gss_krb5_keys.c     |  84 -------
 net/sunrpc/auth_gss/gss_krb5_mech.c     | 257 +--------------------
 net/sunrpc/auth_gss/gss_krb5_seal.c     |  69 ------
 net/sunrpc/auth_gss/gss_krb5_seqnum.c   | 106 ---------
 net/sunrpc/auth_gss/gss_krb5_test.c     | 196 ----------------
 net/sunrpc/auth_gss/gss_krb5_unseal.c   |  77 -------
 net/sunrpc/auth_gss/gss_krb5_wrap.c     | 287 ------------------------
 11 files changed, 3 insertions(+), 1134 deletions(-)
 delete mode 100644 net/sunrpc/auth_gss/gss_krb5_seqnum.c

--
Chuck Lever

