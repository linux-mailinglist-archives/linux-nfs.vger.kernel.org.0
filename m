Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29001646263
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Dec 2022 21:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiLGUbP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Dec 2022 15:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiLGUbO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Dec 2022 15:31:14 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D3045EEC
        for <linux-nfs@vger.kernel.org>; Wed,  7 Dec 2022 12:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1670445063; bh=wpUYdY9bcC4lBSZ5xLSLRB79XMm8JvkzNc09vxFVHUM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=rfC0wJkBxL87yMzNtHAVHZq8vyay8ZlFGfaQCYt0g4b1pRznx0xTKZ+5qAwnQMUmL
         CV6iCQ8H8oAXvB7Cje/A5WpaIZw8cUnmWQG4IH6GvOyn5P4SvsddtLVqJUhHJ+RAEE
         6YOpVAykkqvLEsdAgJD0Q25zbZKiut1bf9MAYqkuinmNrbu69OwkwhpGlJO4Wb7Du6
         +YG6Tgxj6msqvCV79ABspgfwbCdCdp3I3o60vWle2p8WxISj/NEXhERX2ZXBvMhnnv
         +OZVZo92bsb3K+XtuirkQHz7lHcvQv1aF/Ov2b5d35x/zH9PpmrB0DSoPX4vsAh42/
         LgG3efUxLlASA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from xook.jfalk.de ([91.55.245.212]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4z6q-1ov56Z3Dqm-010phU; Wed, 07
 Dec 2022 21:31:03 +0100
From:   Joachim Falk <joachim.falk@gmx.de>
To:     linux-nfs@vger.kernel.org
Cc:     Joachim Falk <joachim.falk@gmx.de>,
        Steve Dickson <steved@redhat.com>,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH] systemd: Don't degrade system state for nfs-clients when krb5 keytab present but not containing the nfs/<FQDN> principal.
Date:   Wed,  7 Dec 2022 21:28:41 +0100
Message-Id: <20221207202841.525930-1-joachim.falk@gmx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xGaH1lumlh9e5OB3hc7Biijx9ljxOpN58zELvfTZxg85hSAeb9/
 Cx2+pI7iUw9gTPcxIdZ9YxToqrfrxatfNrl2rxXP/a1pJmZinMxvsSuV/zng1VBhoWXTUJ6
 I2sTDPwjOyTmrFpyIJyZTP4j47uG9e8Li2WmMdxFD4QKdh5jNUHrHolqEb6IWoHNmElGR2y
 GZHXS8aifiDOuyRp3yt7w==
UI-OutboundReport: notjunk:1;M01:P0:8CciwcB+Mrw=;cB36i7zchQscovKiZuDPBHbCdxz
 VOGnkIzDNPUCQKjjRzYx1Fp9hueX27VUBKy7HdIY4EnqmYDuS08uWsUs+FkCdzGLBzFECLfnx
 XFZ5Vu0gTTSiWT3Ek9GR1fyrmzg+HX0d9zaYG+xp1pYDLTccmf7PCNaJ9oxNeoUKyzAy/aXtV
 6/Nm8/kCCeZmXrWAgeySav7hv63Xb8F+aQYRB+Txk9acp5WD58c9bMbDrNCpKBJfTdgbhiS9G
 +BacB475Y61Z2kaAeBfLweaN6WWFuF8YD9sPkr3VIhjciWABum9GZ2FbUXh0AzP+NOjppUTh5
 fBKcV5p23eUUuslj4+QsMdqXhRHLg6iqZaZPg+YdBV4jA61Ryy3m1IfUsP7WUE3SsviSdg5Tk
 qI3q+9D+szVNOGYZacKjltO3uOzEO+u0UM08CPJwttIP9/AHGu1rw2l94r4woG+LOvIq4g4cG
 j9gmMOvaY9VqohU25vk4T2hzYSTWjGAo5duwRoKwgV74tvpnDFwZasc7A1VJytv23JLsyM9un
 6lgabDqGPMpHDu+SVjAsUtrLTK64rpcfcaI0lXPVbi0PwXBwWDhvksvpYS1yNVnSLUTy/4Ypv
 nmzjh++2BjDfnno3i/NDGlVDHl6SaGF28gT4cFoRmcYiePK2lnJuDxs1QKkEojiDxxzo06met
 1YrcYbHc7LI3fEeUM5Z5Uc0WWloHpEvMOr1DQFf+YQe13NzyrvYxLQPdrTy92rxEjCy+FmkwI
 KhuP7XmMeIa/DydNdQ7wsR1XhQ6Cz5Wzipf5FQaMLr0oNKinNvQKRX22VIArjjfpiWFJCh8EC
 aw3Wlc8sh+obrcEeJCg4ur6+wEIxRPRzM2V3nW3NfYygPQiMEWNv9BD1Ar29gCV3/ytRJonCX
 ylAWr7PqkU+psgqY+ogaF053z3i2dt8DOL3NndVLH/D1QdaI6dRJVS7Y+2KpyAC95+u2QzEV+
 epOrgg==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The nfs-client.target requires the auth-rpcgss-module.service, which in
turn requires the rpc-svcgssd.service. However, the rpc.svcgssd daemon
is unnecessary for an NFS client, even when using Kerberos security.
Moreover, starting this daemon with its default configuration will fail
when no nfs/<host>@REALM principal is in the Kerberos keytab. Thus,
resulting in a degraded system state for NFS client configurations
without nfs/<host>@REALM principal in the Kerberos keytab. However, this
is a perfectly valid NFS client configuration as the nfs/<host>@REALM
principal is not required for mounting NFS file systems. This is even
the case when Kerberos security is enabled for the mount!

Installing the gssproxy package hides this problem as this disables the
rpc-svcgssd.service.

Link: http://bugs.debian.org/985002
Link: https://salsa.debian.org/kernel-team/nfs-utils/-/merge_requests/23

Signed-off-by: Joachim Falk <joachim.falk@gmx.de>
=2D--
 systemd/auth-rpcgss-module.service | 2 +-
 systemd/nfs-server.service         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/systemd/auth-rpcgss-module.service b/systemd/auth-rpcgss-modu=
le.service
index 25c9de80..4a69a7b7 100644
=2D-- a/systemd/auth-rpcgss-module.service
+++ b/systemd/auth-rpcgss-module.service
@@ -8,7 +8,7 @@
 Description=3DKernel Module supporting RPCSEC_GSS
 DefaultDependencies=3Dno
 Before=3Dgssproxy.service rpc-svcgssd.service rpc-gssd.service
-Wants=3Dgssproxy.service rpc-svcgssd.service rpc-gssd.service
+Wants=3Dgssproxy.service rpc-gssd.service
 ConditionPathExists=3D/etc/krb5.keytab
 ConditionVirtualization=3D!container

diff --git a/systemd/nfs-server.service b/systemd/nfs-server.service
index b432f910..2cdd7868 100644
=2D-- a/systemd/nfs-server.service
+++ b/systemd/nfs-server.service
@@ -15,7 +15,7 @@ After=3Dnfsdcld.service
 Before=3Drpc-statd-notify.service

 # GSS services dependencies and ordering
-Wants=3Dauth-rpcgss-module.service
+Wants=3Dauth-rpcgss-module.service rpc-svcgssd.service
 After=3Drpc-gssd.service gssproxy.service rpc-svcgssd.service

 [Service]
=2D-
2.35.1

