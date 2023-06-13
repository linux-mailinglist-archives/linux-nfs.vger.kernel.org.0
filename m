Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E314F72D837
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jun 2023 05:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbjFMDqe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jun 2023 23:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbjFMDqd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Jun 2023 23:46:33 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F7ADF
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 20:46:31 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id DF8133200912;
        Mon, 12 Jun 2023 23:46:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 12 Jun 2023 23:46:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nubmail.ca; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1686627988; x=1686714388; bh=Yf1QdwZS5W
        c/onZm5GAbT+/1StSLOQi6fh9MFzCE97k=; b=g9y0/7WHRzhxYpT1fu+KcbQ+vn
        5X6N8BFQrcRjX7WKoqBA7j0+tTTGT362rAaQExR9UC2OVKD+AzORsEwN9a+W9Zmn
        CNQVSvGrhOvTWo7cc6O+AgA4hi6c/k9logWIcshthV2jjJRORSzjcFFcU4Egq8Ki
        R+Yx77AWQG0qCBvitDOdny/WqUJVciGZyp0OwS5PBD/+K4gwbeGPr/6GLXb0qUTT
        P5fBHSCXg2vkMIv/ltx4+Qe7cxYx9CqCTC9QiwY4H5L+9bxAxtj2ftl5w57ouDDl
        ShJQbL9T4OmhixaRoNsRsgL0EgPCRol79klnoL5z78YY/cf9KFmL+0SS2GoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686627988; x=1686714388; bh=Yf1QdwZS5Wc/o
        nZm5GAbT+/1StSLOQi6fh9MFzCE97k=; b=ePKD6+NcodJiNsdOZsHGkszMdv3SP
        kAT5ir81ro/gZBhbwDhc5HXHv4gOX/7URZG7SqA38OuwCU6z6BCU38N8RtdAu49d
        SwjtcEaGXb+eFB/JMOqTOIfDRGR1LR7QNPzWR2x8pGNOtWFL3hillm2ypOt8+uhg
        4PUBhRtCr2+dn1zal2W0jPJ4K+oHKftZgcxTk5Y8ZOGQztiGfjunMnwnfmVm+aEF
        LcfBtFEOsNAkHRa8PfyJXlVzDeYxDG2uQcfsYif3iuKxNLP3xC4PZxmf7ECpv/wL
        rcjLAodORnXKm+Yx5HnCS5xRIT6rrEe5dRB7Sz7lo02bLNH/NEnCqgnoQ==
X-ME-Sender: <xms:lOaHZGOxzoGo5mIHv3FQmvMlpDDhWN1dP6pnNrTY0Kut463wTCH7eg>
    <xme:lOaHZE-VmqFMXA05JKV9vp9qamwQLOH1jqDbPNTr8ludLVFOfB3s8pKkKLG1w7DuV
    NF8WbYpQoDoPu1GdlY>
X-ME-Received: <xmr:lOaHZNTkKs-jBYxigzLCF8zhnzrhoi625CU_FvoSUYDYXrBkgy0NyhjhGhztZDPXraeDrX5PXn6SgfByZMlBtqB1h6Trf32kmQeh64c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeduiedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeetrhgrmhcutehkhhgrvhgrnhcuoehgihhthhhusgesrghrrghm
    rdhnuhgsmhgrihhlrdgtrgeqnecuggftrfgrthhtvghrnhepuefgfeeiudevvedtvefhgf
    fhleduheffffdvuefgtddtveegheekgfduveelhfdtnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhhuhgssegrrhgrmhdrnhhusghmrg
    hilhdrtggr
X-ME-Proxy: <xmx:lOaHZGtSLc9LytXrdAFVGdYm4yxhEnhr5YNAfm4go2U99oQIwSf-YQ>
    <xmx:lOaHZOf9P-_Cy_tTpVnCLslPF6ks_3uew976Da12v_xn088BC5ADig>
    <xmx:lOaHZK1BN0C__lDCMK42X9fagzlnNGUYesd7kpSZV0aCwZ6P6g1TEQ>
    <xmx:lOaHZAqD2Oxsdjq728xwarffC90RLuZEJwg9zeIhl1VltbEMh-ILTw>
Feedback-ID: i8ce9446d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jun 2023 23:46:27 -0400 (EDT)
From:   Aram Akhavan <github@aram.nubmail.ca>
To:     linux-nfs@vger.kernel.org
Cc:     Aram Akhavan <github@aram.nubmail.ca>
Subject: [PATCH 0/2] Mitigate startup race between DNS resolution and idmapd
Date:   Mon, 12 Jun 2023 20:46:23 -0700
Message-Id: <20230613034625.498132-1-github@aram.nubmail.ca>
X-Mailer: git-send-email 2.34.1
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

idmapd needs DNS resolution on startup if a domain isn't specified by
config file. This isn't trivial since even with systemd's
network-online.target, DNS resolution isn't guaranteed. On Debian,
for example (in part due to some lingering bugs), adding the
target, and even enabling the not-well-documented
ifupdown-wait-online.service is not enough. These two patches aim to
improve the startup behavior in common setup scenarios.

Aram Akhavan (2):
  nfs-idmapd.service: add network-online.target to Wants= and After=
  libnfsidmap: try to get the domain directly from hostname if the DNS
    lookup fails and always show the log message if the domain can't be
    determined

 support/nfsidmap/libnfsidmap.c | 15 ++++++++++-----
 systemd/nfs-idmapd.service     |  3 ++-
 2 files changed, 12 insertions(+), 6 deletions(-)

-- 
2.39.2

