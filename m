Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3785657FFDC
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Jul 2022 15:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbiGYNci (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Jul 2022 09:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbiGYNch (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Jul 2022 09:32:37 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BFAE08A
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 06:32:34 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id z9so4788821vkb.9
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 06:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jrZAU/7KZM2aLDeQv9VbdsL8f3XSrfycVc+z4Nwp38g=;
        b=eUTZ43EPzNJY6+dwIuUAuUO1BAlJBnu2lErO99V+MIWthPLGxjXXP5rGEN/T7muBTW
         3BUhrvqZEoQfZWlgr+wKWmyCrubbs6Ku+i9YCkj1Rsh9/zGH6YYporuaIXUEMiDnOr6C
         xv9YMhaAKSFXSuCv/cqi61YZNytDSc5291h8QwQJXHwGkBjzfWCBoKyIEcZN9iGMZn4K
         oC2H5e5kRFDh4byS7iGuWG9MiLLlMiwTGAvpQGI3tLL4HuXoU7ktABG3373wNaQ++Bp6
         muo3mODG5287FBo4mTqbIhnbYG9YDXW7/bW0Dngp5Dgp98RHcYiWRBgiU06B5HVREaMB
         rTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jrZAU/7KZM2aLDeQv9VbdsL8f3XSrfycVc+z4Nwp38g=;
        b=ZY3Ipf1D7pThlJC3RFCs0a1ZDnnrCH4ppVjhkjllk7F9P4FzuReLm9h7F7VBPFjWYZ
         u8imn5yX0lrlkSKKn8qxt+W6VLTcdAqWwFHtKR2ibSjsXBchWGcqOjTOZbZjre+KZUGb
         o6RhZVn8bqLH+rnHo0CCDMALJ+X8MAXuUk9XEH1YJ4/Fp8DfRHoHpFLdYdpcTKJEONCO
         pUB1ZS1ENtx8SLpczbGMrZcC4jAH8P7dbl1EcZNDk5w3eAjVB0Lv7uNdZV/OB1jzCvT3
         7MCtuSA9MvaDcwDULx8ai16gVkXCWALUxMFNe+A6xSMygUjdzlDxjNtXQ7P2kxAsnfZi
         Z89A==
X-Gm-Message-State: AJIora+oFDiNoKHdpXz2NiDsleiT1YtVh+0Oduq4nBHDys+KH36Rctdi
        rCsQrdOFUSprCahcFb2SvF5FY7gdSpg=
X-Google-Smtp-Source: AGRyM1uVSU1b+CRrMXoZ3TcyZteM+sCI8gX9xp9VR46six1idoFssTaQS43NQJGie9Y8yAS2rgma9g==
X-Received: by 2002:a05:6122:17aa:b0:376:3f8e:e856 with SMTP id o42-20020a05612217aa00b003763f8ee856mr2260929vkf.2.1658755953894;
        Mon, 25 Jul 2022 06:32:33 -0700 (PDT)
Received: from localhost.localdomain (071-047-011-047.res.spectrum.com. [71.47.11.47])
        by smtp.gmail.com with ESMTPSA id a6-20020ab06306000000b00383aeb53100sm2128826uap.16.2022.07.25.06.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 06:32:33 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 00/11] Handling session trunking group membership
Date:   Mon, 25 Jul 2022 09:32:20 -0400
Message-Id: <20220725133231.4279-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Client needs to handle session trunking group membership changes that
occur when a particular server leaves an established trunked group.
This results in a server sending a NFS4ERR_BAD_SESSION because that
server no longer has session's state.

This series proposes to deal with that situation in two fold. First
on DESTROY_SESSION, the client will offline all trunked connections
it has established to the server. Then on CREATE_SESSION it will
iterate thru offlined connections only and probe them again for
session trunking. If session trunking conditions still hold then
such transport would be made active again otherwise it will be
deleted from the trunked group.

v3:
-- fixed documentation for the rpc_xprt_switch_remove_xprt() function

Olga Kornievskaia (11):
  SUNRPC expose functions for offline remote xprt functionality
  SUNRPC add function to offline remove trunkable transports
  NFSv4.1 offline trunkable transports on DESTROY_SESSION
  SUNRPC create an iterator to list only OFFLINE xprts
  SUNRPC enable back offline transports in trunking discovery
  SUNRPC create an rpc function that allows xprt removal from rpc_clnt
  NFSv4.1 remove xprt from xprt_switch if session trunking test fails
  SUNRPC restructure rpc_clnt_setup_test_and_add_xprt
  SUNRPC export xprt_iter_rewind function
  SUNRPC create a function that probes only offline transports
  NFSv4.1 probe offline transports for trunking on session creation

 fs/nfs/nfs4proc.c                    |  12 ++
 include/linux/sunrpc/clnt.h          |   5 +
 include/linux/sunrpc/xprt.h          |   3 +
 include/linux/sunrpc/xprtmultipath.h |   7 +-
 net/sunrpc/clnt.c                    | 204 +++++++++++++++++++++++----
 net/sunrpc/sysfs.c                   |  28 +---
 net/sunrpc/xprt.c                    |  32 +++++
 net/sunrpc/xprtmultipath.c           | 111 ++++++++++++---
 8 files changed, 338 insertions(+), 64 deletions(-)

-- 
2.27.0

