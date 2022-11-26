Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7C0639512
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Nov 2022 10:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiKZJ4q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 26 Nov 2022 04:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiKZJ4p (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 26 Nov 2022 04:56:45 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D404121E3E
        for <linux-nfs@vger.kernel.org>; Sat, 26 Nov 2022 01:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1669456598; bh=yHnNWKtSSzDVa3fYcwEBTQuZKONm7vmROfbExzHQJEw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=ISyFH/TnzjbnBli8UL7T66+FfCaYCI6hySJPWJd7buxoVTWa3n+xFn7exB5GfxDMe
         i3IHKJyRynMQO94z5cfQTNNZJYE2MeVDdiIbOKuw0BL7EuylmJWU4IOwsXf8EKc/XD
         m53eh58tkrKS+3zxjwxl5uUk/CMyhUEgZEOXz/rh0eSho/E3eDnXh9vAQvyQsCBPeq
         QdMoW6LDHZIiuRBy1E1CqfOhAtyemdC7pfBzEs8hzi2zd9peLDNxBX6z1dGPlAG3/8
         1dPNfHG/kgWpe/CiNlAa2asENBVX9d5sb3U8t+G0N6oradfCqUDH6f7SnIC8MdoYi2
         vZA13RFh3/NOA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from xook.jfalk.de ([91.15.234.204]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRCK6-1pLv500Vim-00NA1H; Sat, 26
 Nov 2022 10:56:38 +0100
From:   Joachim Falk <joachim.falk@gmx.de>
To:     linux-nfs@vger.kernel.org
Cc:     Joachim Falk <joachim.falk@gmx.de>, NeilBrown <neilb@suse.com>,
        Steve Dickson <steved@redhat.com>,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH] auth-rpcgss-module.service: Don't fail inside linux container.
Date:   Sat, 26 Nov 2022 10:55:50 +0100
Message-Id: <20221126095550.174062-1-joachim.falk@gmx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X0ulXe1maUCB4Ac854tuUKdH0Zpdv1MzjXQpyfdNRaa2R7XxFyq
 ceG0lrTyxzf9nvplODaXq16p7aDspKBKSg7DJG+cpaV78etm55wIj94rT41OsIE3xWMyzIp
 czRwZ5jFmRa+xCUVg5RL1Klqgm/oF/uZ6Tstbgdfkx6p9v2SsmH0AKgdSYSZWUCdV8Ygy0T
 I/FGqGEuq/8U1c/78TOsQ==
UI-OutboundReport: notjunk:1;M01:P0:feKd9h14f4o=;MHJSuCUC03visKdcchXC54TxW+U
 26D32lRdDsTxHuZceiyX1lDjr5xuyIswWD+Vn9DaUtNoo3F2KXQ/qpIxhmhF6eSiO4cqKK7ka
 uCdkE926yqctgf3zk8diW8oX4VKw3qY5EmksYY2UwhP8O9IlAW87GBcDMYSl5BIgJPWJk5DKT
 TVTRDEWiFim4W5Le9SlDQAuaSS2Y4koxHwyubgCIVLY7QWsg9jRsHfMNRMOh53iISh2bV/8KF
 5rrAnQS5qr0A600sjghzn40GuSHiRn+tOsdosioxY/sfMRiDlUt8cQ3Dvsdqpkz8Zb6OTYPrl
 O3BoRGX/Lk7HkpRRsnM8+u4BLGZv2VPG292MBpVfoVxUhsJTNNXnqHUqQQWnt7NqzcZULlL09
 E96ZIYRVEWFsAIQYWrhwGJ7ALxmrJSajkgZlLF8xgd51hzVxBkYpevDqPEYgOtnnAqpEUzIah
 rAqHBmWUFlowiva27K3u435dFGij2o0LkljP1Qj3zj7IDl7w8kcf3QBnZon+1inlLD+u54OMZ
 nLDLlOHIlK8FpByBwZgrl9+bSPKVpBwKQEUpFmbKcVAESaEgo4Ax4DU9+fyXgWOWJ99Ph+AlM
 mgQqgjwnzxk2eOcj5bjB3VvVU7KrMsrDR6TSoosgyuZXWjjj8v07GTn58Nj03mYn7wqiOX1Qi
 +pgRp0JiGSppihC5qRaWAHyxsNKxHiioUVs9qo+ZxhIzZZCWjUkBnSuYRoo2Atbc5tLEaWbY7
 ItFRgPSBZ+hTXjHbWglrmbFAoA4D+LtUbsZYMOJkruVJMLQOHQRnocCOK0esg1/I4QNQiFx88
 XEd/CPBCBWho+oe2WglEzHXY4ZA8pn6qnQEQGZbPPaDYY2OcigYZrF6h/74Lli4FmoKwjx8tv
 nwkjnxp3eyFghoF8I60oxxmn7CNEqPST9k2wYJ4v2r8BGoV8NQU84TPgaYwkaDKD+CL//Adts
 dNqJFawmVBrL7ldJOZtH8HiEJs8=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Only try to load the auth_rpcgss kernel module if we are not executing
inside a Linux container. Otherwise, the auth-rpcgss-module service will
fail inside a Linux container as the loading of kernel modules is
forbidden for the container. Thus, the "/sbin/modprobe -q auth_rpcgss"
call will fail even if the auth_rpcgss kernel module is already loaded.
This situation occurs when the container host has already loaded the
auth_rpcgss kernel module to enable kerberized NFS service for its
containers. This behavior has been tested with kmod up to version
30+20220630-3 (current in bookworm as of 2022-09-20).

Bug-Debian: http://bugs.debian.org/985000
Discussion-Debian: https://salsa.debian.org/kernel-team/nfs-utils/-/merge_=
requests/7

Signed-off-by: Joachim Falk <joachim.falk@gmx.de>
=2D--
 systemd/auth-rpcgss-module.service | 1 +
 1 file changed, 1 insertion(+)

diff --git a/systemd/auth-rpcgss-module.service b/systemd/auth-rpcgss-modu=
le.service
index 45482833..25c9de80 100644
=2D-- a/systemd/auth-rpcgss-module.service
+++ b/systemd/auth-rpcgss-module.service
@@ -10,6 +10,7 @@ DefaultDependencies=3Dno
 Before=3Dgssproxy.service rpc-svcgssd.service rpc-gssd.service
 Wants=3Dgssproxy.service rpc-svcgssd.service rpc-gssd.service
 ConditionPathExists=3D/etc/krb5.keytab
+ConditionVirtualization=3D!container

 [Service]
 Type=3Doneshot
=2D-
2.35.1

