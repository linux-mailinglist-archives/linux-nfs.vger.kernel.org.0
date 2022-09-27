Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33FF5ECE54
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Sep 2022 22:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbiI0UVu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 27 Sep 2022 16:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbiI0UVa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 27 Sep 2022 16:21:30 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5D7AE857
        for <linux-nfs@vger.kernel.org>; Tue, 27 Sep 2022 13:21:24 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 10DF55C00EC
        for <linux-nfs@vger.kernel.org>; Tue, 27 Sep 2022 16:21:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 27 Sep 2022 16:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nubmail.ca; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1664310083; x=1664396483; bh=+qohVLbWlf
        c8TOlHE2TyhOwG2f8I7h7nB5MODYGUvao=; b=qz2fGu9HTx36Han5tAMRZaAUzT
        Rz+AtgmwHWkusEN9AdPHKgiIBKEukGfDNzhP/YTikMZrzldCyUdQYtxbaVSfHR8m
        CRdiI7pU7otIaalgnI2gvmxDThxlJscOZ0eoC7ni+q0UYyrkWHLPEKgSfCGQPLZ4
        r80Aq/V1r/jdIhmqog0wcG1z6GguM6tQo53qYWFqKQx5cgJApoaXHF8PfblTKvFq
        1q13a97pQ+dc+XlAN9dkzMr/Kp2oHhjJphNhdXjmezYPP4Zl3mvg0Z58H28w2OqT
        dUwpPrC/MBl9ihaJcG/IGS9saxMV7sJcSsPueEtY4HkhcK5Msmexaq9wEWLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664310083; x=1664396483; bh=+qohVLbWlfc8TOlHE2TyhOwG2f8I
        7h7nB5MODYGUvao=; b=0T5jDaDe3Y1KMU2CwtVz7YyM7cAZ5dON+Es6na+TjhuY
        O/F7Xc8l+IpOTNSzC+EHdoSQj2mMJm1te97iPOXOt6XaPvHImcnFQWOPJLTsoDrP
        ypcZH3ru+/e5V5/BU1DIh6I8+MdlTVyvkPt8sw2w8kbbtiDYWyPTREhDtWX1cvjY
        DZDzl1EfkDxmBEEWsufo44cFiCX6OIQz5/hdMS21lXfDdhnok8Pc2AcuQI12eJ2S
        LpvdipZiofYe/yPWenCH/RfSIvqarhbA18nAKhUpfghVzc5HhuTmymjF2m7ffRFz
        wS7SDYZhXv92rlXv0TaluS6t2wVcQgI2FNPSz7TDNg==
X-ME-Sender: <xms:QlszYzlz9CmNii303m5QUYRLeNOYGYLtHiqUt0xt8S8oE_eKMY8VSA>
    <xme:QlszY21hHGuSy4xOO_YXwwyBq2UKi263aHTGfcQVoAPr9P8QxeSQT6U91hv_M5s87
    y9v6FEvhc3sXSPVwSc>
X-ME-Received: <xmr:QlszY5rBeWjwXMIHLXNTRcUD0O2GpUON7gIAfPN5VSDqh1lueAeR5FDLXRTajEk9VGgpi-V6y25gS0UxakGfuc-3ew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeegiedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepkfffgggfvffhufgtgfesthejre
    dttdefjeenucfhrhhomheptehrrghmucetkhhhrghvrghnuceorghrrghmsehnuhgsmhgr
    ihhlrdgtrgeqnecuggftrfgrthhtvghrnhepfefgiedvkedvledtffetiefhgeejgfeiue
    dvfffgtdfgtdeikeejtdeiffeljeehnecuffhomhgrihhnpehlihhnuhigqdhnfhhsrdho
    rhhgpdguihgvrdhnvghtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomheprghrrghmsehnuhgsmhgrihhlrdgtrg
X-ME-Proxy: <xmx:QlszY7k2oypkYFwHnx68n9rFu2ZWhAvwcOn4Be9UnB_4BdOobzR1SQ>
    <xmx:QlszYx1HeOe8iHpuLPV7bBHF5LS59pvQzQSWoK7nQuJXelSC8mP-Yw>
    <xmx:QlszY6vxvNO71bKo-f14GWoETObebOyi6tLytm03CR2udklVCwVDtg>
    <xmx:Q1szY-h0sKakKTh90kJiZ7dtIol-l_BP3SXlUv2MAW4tUjWjoSEf_Q>
Feedback-ID: i8ce9446d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <linux-nfs@vger.kernel.org>; Tue, 27 Sep 2022 16:21:22 -0400 (EDT)
Message-ID: <589498d2-6cac-47bd-8e93-8fdd44e4be45@nubmail.ca>
Date:   Tue, 27 Sep 2022 13:21:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US
To:     linux-nfs@vger.kernel.org
From:   Aram Akhavan <aram@nubmail.ca>
Subject: Why does nfs-client.target include rpc.svcgssd?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi all,

I'm a newbie starting to play around with kerberized nfs on Debian. I 
noticed that in the systemd target file nfs-client.target 
<http://git.linux-nfs.org/?p=steved/nfs-utils.git;a=blob;f=systemd/nfs-client.target;h=8a8300a1dfc6e6a77dfe0abed9942ded8f6b0103;hb=refs/heads/master> 
has *rpc-svcgssd* among its list of dependencies. From the man pages 
<https://linux.die.net/man/8/rpc.svcgssd>, it seems this is a 
server-side daemon, not client-, and as expected I don't seem to need it 
for the clients to mount anything successfully. Why is this part of the 
client target?

I thought it may be a dependency for something else, but I haven't been 
able to find what. Similarly, why is it installed with the *nfs-common* 
package instead of *nfs-kernel-server* if it's not needed?

This came up because I kept seeing errors on boot caused by rpc.svcgssd 
looking for nfs//FQDN/@/REALM /in the keytab, but it doesn't exist. 
rpc.gssd, on the other hand, was updated 
<https://linux.die.net/man/8/rpc.gssd> to search for other principals, 
like host/FQDN@REALM, which is what gets set up in the keytab by default.

Thanks,

Aram
