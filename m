Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6A789FB32
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2019 09:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfH1HKi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Aug 2019 03:10:38 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41423 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726258AbfH1HKi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 28 Aug 2019 03:10:38 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 1473922138
        for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2019 03:10:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 28 Aug 2019 03:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=5SpWWxKolQCsrogR0KPoOW+a/g
        T7H5pZ2jP6BYVBXJs=; b=aGaN3lcCV8M7NWkLsFmBKLOTOYJYkBuW4nW4IJrb1r
        9Y//cnUCpNsUSn8U2UU/lPRBQCtUrTRF56zBjeoa5DUWKXb3qnV0IN6BsyjUJshw
        R5EqRogv13clvGe1IEpWEkaHEsB6Vy27aLKliAM+xfsyEHzGq5EeIOEXJHMkGCZo
        hrn3KuT4KYKnRyS4RhfL7rcn8PBlg1ubkVEMf+lpbwXfrpPJvyZajdzuaO+Wz7OH
        M9R317u7VSgUnW3kNv5UuSg6mfYlaMcpfNLhHX53AHQtJ5kPWofj1kBMCnO6sO1b
        zKos7HbRzmNOSnypD/taYiJi5XXDBln1AIHTx6ZIkxhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=5SpWWxKolQCsrogR0
        KPoOW+a/gT7H5pZ2jP6BYVBXJs=; b=P1BtiXT9BBvuHdG9O7bP5j+Oq+RUPdsCQ
        uLlctS7ccxgjzenyd5cFTC/4p4iZqJA0NdZv9lSag11nLEb323g5laDOknkC20P8
        pRvGqHzr2Vn50roBbRPgQZfoGD811yln1Hlb/k3aywgBGssaaPPZFdrLbGC/WNAV
        U0WHtCEpB74cagBk9tx0K7lLrn/tmHGzPHRDz4srqB11VUDszQ5BaI37xqrqb2OU
        MGU+pVi4si3/k90Sp+aE9d4uP4SVj7aUOgsHhzeSbQwW0hXpWa5Ex/l/OjgyFk08
        7aHwYJSRNCjm/bvvoZjLY/DSWV/qsnakhvLn7nZN053nJAOAMcnaA==
X-ME-Sender: <xms:6yhmXamk_W-2zrSGMzGG8aRbXXrT7obWC1I_2HgeYQJRAj_B65mRjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudehledgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucfkphepjeejrdduuddrudehhedrvdehheenucfrrghrrghmpehmrghilh
    hfrhhomhepphhssehpkhhsrdhimhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:6yhmXZNow_giUUpWrmD4JwLi6r4uLf8krGmGH-ZzXYU0SIX9N5hv7A>
    <xmx:6yhmXeOceVutTvIc0Bsqaw2KF7DBcggfALx18iB-YsiZEvPClCslLQ>
    <xmx:6yhmXaiaQ5z-FEdg3loTQ2vw_qjg2AdoFb1bxaIPC9lurrD9NQ7V6Q>
    <xmx:7ChmXdtcpQz6Ty4axThenFC5LPMwhIkFbdSsIQP6-pDIpm32n9-gbw>
Received: from NSJAIL (x4d0b9bff.dyn.telefonica.de [77.11.155.255])
        by mail.messagingengine.com (Postfix) with ESMTPA id 50107D6005D
        for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2019 03:10:35 -0400 (EDT)
Received: from localhost (10.192.0.11 [10.192.0.11])
        by NSJAIL (OpenSMTPD) with ESMTPSA id 8cc7902e (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Wed, 28 Aug 2019 07:10:33 +0000 (UTC)
From:   Patrick Steinhardt <ps@pks.im>
To:     linux-nfs@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/6] Fixes for various compiler warnings
Date:   Wed, 28 Aug 2019 09:10:11 +0200
Message-Id: <cover.1566976047.git.ps@pks.im>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

here's some assorted fixes for compiler warnings I'm seeing on my
platform. Most warnings are probably due to using musl libc, but
the fixes should be the correct thing to do regardless. With this
patchset, I can now compile nfs-utils with -Werror just fine.

Regards
Patrick

Patrick Steinhardt (6):
  Annotate unused fields with UNUSED
  Use <fcntl.h> header instead of <sys/fcntl.h>
  Use <poll.h> header instead of <sys/poll.h>
  configure.ac: Add <sys/socket.h> header when checking
    sizeof(socklen_t)
  nfsd_path: Include missing header for `struct stat`
  mountd: Use unsigned for filesystem type magic constants

 configure.ac                   | 5 ++++-
 support/export/xtab.c          | 2 +-
 support/include/nfsd_path.h    | 2 ++
 support/misc/xstat.c           | 3 ++-
 support/nfs/rmtab.c            | 2 +-
 support/nfs/rpc_socket.c       | 3 ++-
 support/nfs/svc_socket.c       | 2 +-
 support/nfs/xio.c              | 2 +-
 utils/gssd/svcgssd_main_loop.c | 2 +-
 utils/mountd/cache.c           | 4 ++--
 utils/statd/sm-notify.c        | 2 +-
 11 files changed, 18 insertions(+), 11 deletions(-)

-- 
2.23.0

