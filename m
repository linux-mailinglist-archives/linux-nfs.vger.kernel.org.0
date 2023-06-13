Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C43072D838
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jun 2023 05:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbjFMDqf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jun 2023 23:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbjFMDqd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Jun 2023 23:46:33 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439C5A0
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 20:46:31 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 5BD763200916;
        Mon, 12 Jun 2023 23:46:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 12 Jun 2023 23:46:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nubmail.ca; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1686627989; x=
        1686714389; bh=+JTxOMVVMTOwKKftJktsGLYlOTRNS/qUmjXCD4prpqc=; b=z
        SmNX5FsegU/MYtZ6p9bk1aaxwV1rX68zwt/jkmCbHf9k4CjfgyywHeazVTf2RV+o
        pW0W5heFfRgilLr2MpnO9ZSSDhoeUbXmtjA6p8GHKtr54/m23hyrDc23ks0PtKzh
        7MAp5rTdNA3JmTJJ+plvdiCxFnubAqBWGYEj4xRH1NTI6+R62Jj/byN2OpD/dgjC
        bRmCYxiVKhebbW3N+w24sR267c5uA2k74nE9k4xku9W51V/H0z3sEwNsX3iBb7iT
        AJmpv91kseAZiRFSbJYhwo6mNdrG3efK14e1TB3fNZIET+yFpmu8R1huUzu6wwCT
        PbJyZKSlZOTQyykmWpV8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1686627989; x=
        1686714389; bh=+JTxOMVVMTOwKKftJktsGLYlOTRNS/qUmjXCD4prpqc=; b=p
        fWM0QHmbkVuUn9+aPesKmVF57edPciYbonJJhWl/fCwObHVYFLoeEWptDP7SLYfz
        PYqgR8rP+XgdmyDNYIR+ODNwi6Py/wCvrZZV2P5RDo2AJv9rkAbYyryOb+DTwCJC
        SdSiy3BVEGaALS6bEoEN6eSFakg0vA04oi3FnzhpbibK9ApbsTaiNGJNhUUDDhEm
        p1LQZG5nxzgdjtT4UT91NNivXv7Wmw9eODqR42GDkZ6iA7JNtfIGm1891oPeu36+
        gVBUJ0PBnRA5EYOXre7h8MF+e0XrFBdvlisGaNa5S5ugxEa400jcyepkF/1aF+rQ
        HbTcxajvyypc+skpgMNbg==
X-ME-Sender: <xms:leaHZIFx-mxdWuv5yF6ndwH4MrQhHUnfvLBiuWWHGBULWLi8HnNj2A>
    <xme:leaHZBVWfjFpQ1JUxlTfl6tQGMmUL4H00k2beQlV5Qoa699h892kI42I0I_24Yk6N
    bn2TjXkT0COs21v4S8>
X-ME-Received: <xmr:leaHZCLd3Rz_gDii3jfAQm-H5IzY4rSQJQULLSIn8IybeRWT7J3Sz1zDnBu7AZ4yqGKVNRPzcJ5WVZmXCFbKVtLCSYEy3-ImXbkLYe8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeduiedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeetrhgrmhcutehkhhgrvhgrnhcuoehgihhthhhusgesrghr
    rghmrdhnuhgsmhgrihhlrdgtrgeqnecuggftrfgrthhtvghrnhepheejudefhffftdfgud
    ejffffiedufedtleehffegteeiveejgfeffefhkeduvddtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhhuhgssegrrhgrmhdrnhhusg
    hmrghilhdrtggr
X-ME-Proxy: <xmx:leaHZKEfXzsGcY3vgzVfYuBjOqPKpPYkUJrugmF0Y_-ERGxreRzUzw>
    <xmx:leaHZOXhmsDadsGtP3xaO10vMuHptgvh9MN3G1IPJFV-HlRU6O9bBw>
    <xmx:leaHZNOI6H6PeMnHT4F7BebfN-RerodLXXBDWixCD2G6gAp4tVA2yQ>
    <xmx:leaHZJBWjcQk6kAGkXqy4J8s1ufIT03WyxjKQJRr0WA4PYA79Jo0Ug>
Feedback-ID: i8ce9446d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jun 2023 23:46:29 -0400 (EDT)
From:   Aram Akhavan <github@aram.nubmail.ca>
To:     linux-nfs@vger.kernel.org
Cc:     Aram Akhavan <github@aram.nubmail.ca>
Subject: [PATCH 1/2] nfs-idmapd.service: add network-online.target to Wants= and After=
Date:   Mon, 12 Jun 2023 20:46:24 -0700
Message-Id: <20230613034625.498132-2-github@aram.nubmail.ca>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613034625.498132-1-github@aram.nubmail.ca>
References: <20230613034625.498132-1-github@aram.nubmail.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfs-idmapd.service does not have any dependency on the network so there's no
starting point to wait for DNS resolution. nfs-server.service already has this
network dependency and ordering.

Signed-off-by: Aram Akhavan <github@aram.nubmail.ca>
---
 systemd/nfs-idmapd.service | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/systemd/nfs-idmapd.service b/systemd/nfs-idmapd.service
index f38fe527..198ca87c 100644
--- a/systemd/nfs-idmapd.service
+++ b/systemd/nfs-idmapd.service
@@ -2,7 +2,8 @@
 Description=NFSv4 ID-name mapping service
 DefaultDependencies=no
 Requires=rpc_pipefs.target
-After=rpc_pipefs.target local-fs.target
+After=rpc_pipefs.target local-fs.target network-online.target
+Wants=network-online.target
 
 BindsTo=nfs-server.service
 
-- 
2.39.2

