Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B3172B854
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jun 2023 08:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbjFLGx3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jun 2023 02:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234600AbjFLGx1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Jun 2023 02:53:27 -0400
X-Greylist: delayed 9006 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 11 Jun 2023 23:48:22 PDT
Received: from mail1.ceniai.inf.cu (mail1.ceniai.inf.cu [169.158.128.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B615A10C2;
        Sun, 11 Jun 2023 23:48:22 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail1.ceniai.inf.cu (Postfix) with ESMTP id 57EC14E8137;
        Mon, 12 Jun 2023 00:09:26 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail1.ceniai.inf.cu
Received: from mail1.ceniai.inf.cu ([127.0.0.1])
        by localhost (mail1.ceniai.inf.cu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WSVsOis4rone; Mon, 12 Jun 2023 00:09:26 -0400 (EDT)
Received: from mail.vega.inf.cu (mail.vega.inf.cu [169.158.143.34])
        by mail1.ceniai.inf.cu (Postfix) with ESMTP id 9A3994E8D46;
        Mon, 12 Jun 2023 00:00:28 -0400 (EDT)
Received: from mx1.ecovida.cu (unknown [169.158.179.26])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail.vega.inf.cu (Postfix) with ESMTPS id D54B5565B0A;
        Sun, 11 Jun 2023 11:40:11 -0400 (CDT)
Received: from mx1.ecovida.cu (localhost [127.0.0.1])
        by mx1.ecovida.cu (Proxmox) with ESMTP id 6A2B9240CE7;
        Sun, 11 Jun 2023 15:23:52 -0400 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ecovida.cu; h=cc
        :content-description:content-transfer-encoding:content-type
        :content-type:date:from:from:message-id:mime-version:reply-to
        :reply-to:subject:subject:to:to; s=ecovida20; bh=eJCLj5LjLfltOUH
        QwbhnEIM71NnOqC+k0uTJlyqNYA0=; b=DcRsVnh8PwZgs7y+XuOKXZsVaQBR/H6
        XoACm7D3Yogbb1byEspwmAO2qEbTBHMBRjokBnHhowQEK0u5DCx6Q+DJuM4aPAGQ
        m1IUL3Jrxhpnx1mha+204x7zV997W+a7qgttKpEZNEYo1zNd4bwr6JrPxUXBrvVV
        rNjSKjASF1PcwDaH5VBWrFOfNBj+nT7kFyp1MNWVPoL6pgZtGf5rPwhdx6IMsT4C
        /ezCQy3gmtNplW3691klQbMXXvf9m8f2STt41mJQnysXmxFaUi6AC3GMnQMOII6B
        u4191nZxATn9FePP1IhGYMxqmuczU0qatcarBodAiiGfygRm1/JQUFA==
Received: from correoweb.ecovida.cu (correoweb.ecovida.cu [192.168.100.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mx1.ecovida.cu (Proxmox) with ESMTPS id 5C4AE240A32;
        Sun, 11 Jun 2023 15:23:52 -0400 (CDT)
Received: from localhost (localhost [127.0.0.1])
        by correoweb.ecovida.cu (Postfix) with ESMTP id 8253F50575F;
        Sun, 11 Jun 2023 13:20:22 -0400 (CDT)
Received: from correoweb.ecovida.cu ([127.0.0.1])
        by localhost (correoweb.ecovida.cu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 4y-7DLKV7ivg; Sun, 11 Jun 2023 13:20:22 -0400 (CDT)
Received: from localhost (localhost [127.0.0.1])
        by correoweb.ecovida.cu (Postfix) with ESMTP id 091644AD4E2;
        Sun, 11 Jun 2023 12:35:34 -0400 (CDT)
X-Virus-Scanned: amavisd-new at ecovida.cu
Received: from correoweb.ecovida.cu ([127.0.0.1])
        by localhost (correoweb.ecovida.cu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4IrgkPfrbOHY; Sun, 11 Jun 2023 12:35:33 -0400 (CDT)
Received: from [192.168.100.9] (unknown [45.88.97.218])
        by correoweb.ecovida.cu (Postfix) with ESMTPSA id 5E2674B2B1D;
        Sun, 11 Jun 2023 10:29:39 -0400 (CDT)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: RE:
To:     Recipients <lazaroluis@ecovida.cu>
From:   Aldi Albrecht <lazaroluis@ecovida.cu>
Date:   Sun, 11 Jun 2023 15:33:46 +0100
Reply-To: aldiheister@gmail.com
X-Antivirus: Avast (VPS 230611-4, 6/11/2023), Outbound message
X-Antivirus-Status: Clean
Message-Id: <20230611142940.5E2674B2B1D@correoweb.ecovida.cu>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hallo gesch=E4tzter Beg=FCnstigter, Sie wurden f=FCr eine gro=DFe Geldsumme=
 f=FCr humanit=E4re und Investitionszwecke jeglicher Art ausgew=E4hlt. F=FC=
r weitere Details antworten Sie bitte.

Gr=FC=DFe
 
Beate Heister
Eigent=FCmer
Aldi Albrecht-TRUST

-- 
This email has been checked for viruses by Avast antivirus software.
www.avast.com

