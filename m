Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2918957D67C
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jul 2022 00:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbiGUWHT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jul 2022 18:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbiGUWHS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jul 2022 18:07:18 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7968875F
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 15:07:18 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id l24so2420209ion.13
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 15:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jOzM9Ly50IN/TuMNkTr4W+5Uw6IcI7U4WQw06mf+G+0=;
        b=EwFW1eslwAG5fnyfSXIHk7qJAPIhxgy2aLdW6m3ZNrJC+jOZaZGrvG3cwzARGiwwlB
         scw5FqFN9gB7+rpC+ImY5XGVUyQ0faXNoR9wBsfFzffXBB4gsTV0S4Twu76Sta+hlFZ0
         vi76QzTPkREhWNcCDASVbwvKa+S/UXubePIAvpZO/sNuf1Z63aKOl8Wr9jnpJixYNCRf
         qUNOWTHizbzH0qgQlJ/KWO6O7aHFw6yWp42lW4XKfiQT+pI8LL0y7IKpN5/LOufthdS2
         xjvyhMw+Jn1+1kgpT0IjcLR8ZOTW037GpMxWsiFsX6TX/8IQ/NcnJbn9YCBLNsPOcFC8
         Y8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jOzM9Ly50IN/TuMNkTr4W+5Uw6IcI7U4WQw06mf+G+0=;
        b=deZ5sv7gg+b8vji+bpVtAOVwbATNS0To77XKMDbbxLvuRCITzxnIi/iTdEl6nR2MfY
         jr5shdI3IKjwUt/MANrAqog7wNmffRPNnWJoDI7EWuSBfV73EaFROFjrpt9+kBuV59sz
         GR/AGe9kUaKkDu4bd88h88Gp3lmaW+igL7o4gFLUZRoo8iLuQcTb15Pl1pdwfscqrqut
         IHQ3VEkpnLo4PDS18TmhiXWeS3ETrsrZ/ZIAS24HprTQBA77CZFit+wh/lBHNixGk1uP
         eFR0VcffkqM66nxiwEcS12mXkrW+4ezpg4fdZsz+R0+a7sGdOups90xkyNETKju5OWM4
         nWhw==
X-Gm-Message-State: AJIora/wPaIHnoaH2jXIFs2A0fsUMpe63BFuVYexGCJsRju7I4swSRqM
        iqOiztG/SL7TQHw4958Et9P6aEo73o8=
X-Google-Smtp-Source: AGRyM1uu15yeCojXQbmPW8D9CSOM/XeMpoPHIM2D2TSjoLQ/brUtKtY7XmfB73DQfmHPPOhUhMBpOA==
X-Received: by 2002:a05:6638:238f:b0:33f:774f:5252 with SMTP id q15-20020a056638238f00b0033f774f5252mr292579jat.216.1658441237405;
        Thu, 21 Jul 2022 15:07:17 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id g11-20020a05663811cb00b00341668383cfsm1281105jas.33.2022.07.21.15.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 15:07:16 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 00/11] Handling session trunking group membership
Date:   Thu, 21 Jul 2022 18:07:03 -0400
Message-Id: <20220721220714.22620-1-olga.kornievskaia@gmail.com>
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

v2:
-- added documentation to new rpc functions called by NFS layer
-- removed rpc_xprt_offline_destroy() and left only rpc_xprt_offline
-- created a different function for going through transports and 
checking each valid one for session trunking ability.

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
 net/sunrpc/xprtmultipath.c           | 110 ++++++++++++---
 8 files changed, 337 insertions(+), 64 deletions(-)

-- 
2.27.0

