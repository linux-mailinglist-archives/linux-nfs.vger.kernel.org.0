Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18195759D48
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jul 2023 20:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjGSSbA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jul 2023 14:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjGSSa7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Jul 2023 14:30:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22013B6
        for <linux-nfs@vger.kernel.org>; Wed, 19 Jul 2023 11:30:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A304B617CF
        for <linux-nfs@vger.kernel.org>; Wed, 19 Jul 2023 18:30:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA761C433C8;
        Wed, 19 Jul 2023 18:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689791458;
        bh=FwXbpy3BEeOukDhH/s2twzM3UvZGSRfcKPf/pt9FrkQ=;
        h=Subject:From:To:Cc:Date:From;
        b=VQwx6BpgYlvWvOHuW2Oh1fpazczpviL+LUbkSBb/fMvu0ZlG0qJkUFUhm0c7J/fDn
         WKCDF68OLtyH2fc8r2gv2MCsIl0LsJmmpvSPJCJFdGbmXoXzVQGTM8O4yDswy+VSO5
         k/EYhYNC+i3QUk+IYhPD+eCucIhr3+wv9u1S/9kwv6tmrXfhAHAzXogXc/madYhPDf
         GIjbz3MbgkbECc7kthqpm1vY7U5KIMlTra/6eqPG6biP2NZWC1PeL5NdNieJybEX6W
         NKDjDNXTs1yI0sfVxzx+kNFe1MUSq4X8AtNfz4L+wCxq27evKY5OcJ06Iqrix1P5lA
         11imlZ93FLzQA==
Subject: [PATCH v3 0/5] Send RPC-on-TCP with one sock_sendmsg() call
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        David Howells <dhowells@redhat.com>, dhowells@redhat.com
Date:   Wed, 19 Jul 2023 14:30:56 -0400
Message-ID: <168979108540.1905271.9720708849149797793.stgit@morisot.1015granger.net>
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

Initial performance benchmark results show 5-10% throughput gains
with a fast link layer and a tmpfs export. I've added some other
ideas to this series for further discussion -- these have also shown
performance benefits in my testing.


Changes since v2:
* Keep rq_bvec instead of switching to a per-transport bio_vec array
* Remove the cork/uncork logic in svc_tcp_sendto
* Attempt to mitigate wake-up storms when receiving large RPC messages

Changes since RFC:
* Moved xdr_buf-to-bio_vec array helper to generic XDR code
* Added bio_vec array bounds-checking
* Re-ordered patches

---

Chuck Lever (5):
      SUNRPC: Convert svc_tcp_sendmsg to use bio_vecs directly
      SUNRPC: Send RPC message on TCP with a single sock_sendmsg() call
      SUNRPC: Convert svc_udp_sendto() to use the per-socket bio_vec array
      SUNRPC: Revert e0a912e8ddba
      SUNRPC: Reduce thread wake-up rate when receiving large RPC messages


 include/linux/sunrpc/svcsock.h |   4 +-
 include/linux/sunrpc/xdr.h     |   2 +
 net/sunrpc/svcsock.c           | 127 +++++++++++++++------------------
 net/sunrpc/xdr.c               |  50 +++++++++++++
 4 files changed, 112 insertions(+), 71 deletions(-)

--
Chuck Lever

