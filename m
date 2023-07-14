Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA6775425B
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jul 2023 20:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236514AbjGNSMR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Jul 2023 14:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236516AbjGNSMP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Jul 2023 14:12:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AE72121
        for <linux-nfs@vger.kernel.org>; Fri, 14 Jul 2023 11:11:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0272461DB9
        for <linux-nfs@vger.kernel.org>; Fri, 14 Jul 2023 18:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EEB3C433C8;
        Fri, 14 Jul 2023 18:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689358232;
        bh=tCSyUkciooppcZwDR0Q7o35bPDL9xjwwyAUn+D0Uoi4=;
        h=Subject:From:To:Cc:Date:From;
        b=p0ugFphLvI45UrVhJZWH9bZaavDTyRYwIznSY3XFJ6RTTQ9rlgNq7lasm26oSt/pk
         vmJXmoDiOoDhrwNeBwJ9EXmo5+YujPri169UoqCdazjF4/4wZG0gn9q7ggoXPzgf9T
         mnbkNfi2zpVPy82Pn9WartxtMi1BDblHAVqXUT1Je6QJ5HanOlW4JECvCBVHeZz4RB
         aulsAJrA/Nq/aBdZSQmiaoppC/EYnOL4R6J588qOtugaQIA15hBLLejNkONLjfCNwi
         dtGas1JZTKJ3On2v3R89C5lMeD3WfSwsBEr3pCQm5nkEdss8d2SqCV1o66gIGKNHuo
         lA1M3sknRWuEA==
Subject: [PATCH v2 0/4] Send RPC-on-TCP with one sock_sendmsg() call
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        David Howells <dhowells@redhat.com>, dhowells@redhat.com
Date:   Fri, 14 Jul 2023 14:10:31 -0400
Message-ID: <168935791041.1984.13295336680505732841.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

After some discussion with David Howells at LSF/MM 2023, we arrived
at a plan to use a single sock_sendmsg() call for transmitting an
RPC message on socket-based transports. This is an initial part of
the transition to support handling folios with file content, but it
has scalability benefits as well.

This series passes the usual set of NFS-based tests. I've found no
behavior regressions so far. From the netdev folks, I'm interested
to know if this approach is sensible. The next step is performance
benchmarking.


Changes since RFC:
* Moved xdr_buf-to-bio_vec array helper to generic XDR code
* Added bio_vec array bounds-checking
* Re-ordered patches

---

Chuck Lever (4):
      SUNRPC: Convert svc_tcp_sendmsg to use bio_vecs directly
      SUNRPC: Send RPC message on TCP with a single sock_sendmsg() call
      SUNRPC: Convert svc_udp_sendto() to use the per-socket bio_vec array
      SUNRPC: Use a per-transport receive bio_vec array


 include/linux/sunrpc/svc.h     |   1 -
 include/linux/sunrpc/svcsock.h |   7 +++
 include/linux/sunrpc/xdr.h     |   2 +
 net/sunrpc/svcsock.c           | 111 ++++++++++++++-------------------
 net/sunrpc/xdr.c               |  50 +++++++++++++++
 5 files changed, 107 insertions(+), 64 deletions(-)

--
Chuck Lever

