Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D945F2331
	for <lists+linux-nfs@lfdr.de>; Sun,  2 Oct 2022 14:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiJBMfv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 2 Oct 2022 08:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiJBMfs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 2 Oct 2022 08:35:48 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102582C65D
        for <linux-nfs@vger.kernel.org>; Sun,  2 Oct 2022 05:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664714143;
        bh=0HI07Th4DJ3Nn65WcDsnpOCVw+RF5lw+ohstaqceuTc=;
        h=X-UI-Sender-Class:Date:To:From:Subject;
        b=dzYylLMRyp8o3byh3+Ald80QT8MuJ5XXZ8jArrpbDaIpXoSF5HknUoeSuDrnoCF8r
         gVMHAUycKKSeARgj04acaYKUFgWVnE3xhZOurVcN5v3bk7MAP8CpZ4SOy8Ge35mLlE
         851G9wPBLeeKpqbNDJ+ZnhAARHAl1ApOIOud5AzY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.20] ([145.40.206.240]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNswE-1oq41P05DU-00OEDH for
 <linux-nfs@vger.kernel.org>; Sun, 02 Oct 2022 14:35:43 +0200
Message-ID: <39bf58c7-47d9-744b-6d26-d672aa713024@gmx.ch>
Date:   Sun, 2 Oct 2022 14:35:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: de-CH, en-US
To:     linux-nfs@vger.kernel.org
From:   Manfred Schwarb <manfred99@gmx.ch>
Subject: nfs4.1+: workaround for defunct clientaddr?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:umbvEAPO/Yx0ZwsUpTJax8xJOrnbkQGVsOmtD96Ib2Oll8Sf45o
 cB9f1PJUe02B48lzblBZscL3jb5f+GOSzkAIPaMQouLZzo2iYRvxw8iZXqTh/jHm9SCBiDe
 J4RD4xDTq99tiKxnqToA4+71CGaR0PjjW7bW9JWcUL0C0/UPT9mcQwmtX9ViEcgIJXPqYOA
 bYswdUNhHw2uo8QtOC7vQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Lry2H70xxFA=:MEZzqZ8K2OOsQnWZ1R0H9N
 /KbgfQmAVKbZAoSsMkDE28Akq7wgJ3FNjZJH+H/8GeVNLczsem5V5oNgXCUBR8P6r8ljVwtLC
 941sqHyxTXVdHNuA+VXtjW1KU15XeBrvnCofzKZnP6L9sP+sZ0SK70YNI+Xr4WUGvhNnvZmXy
 wJulKY4pUlD+386DaEJfuFUzwCQQg3R81SIh68YxVQz4RmA167RITeKHg/RVb0nu4dyIQ4Q6E
 AYCokpQOC36UGPsZWhVmTEiiI03zv773GPRvK+QQvbTmYn+7VNCGarrtRmEAF1K/pmCO9bP3e
 CrRNGMnUGx7x+nIzLQMVFZfF0D6WtTeCHWoakOAIGtc8y2cqPq96QA/yWZS5KlV6iHME3mlHP
 ckGZQBWPHwCASqnTbbk8Q8ymccWbc4b8rcy6XADcP5CYx1Vb60tjdQMSNUY995GH30zuy52HA
 3AnWkVwEzuE4BbBKqpB0QSEfADLKFx70bYfw+jebGNBo22l6sIIjIbXsCI6z76lcKSYwiDsLS
 s2bS/m8B2Quegqlkzz2maaf91LkrrM7RbWeMg0bNFDrbq7sLgDf8goJa7PLimlhuTvTp9UD3b
 TOZRB2BMShkqk5djS6ik+k2CAggA0Hh3traNg0Z8HW0qlur2ODY7SEtuTDDNkzUc08Ng0gX6u
 AEjMMsx/cHGmLB5Fu37t0hlCNcRp1yQKu3riCwI96xwkDgdgswhkWF8ZQE3f58WgGA3i77Vmn
 v/NRI6dUMPcVHfJCK1jsLKARzDSNraYkuViGy4dObxqWUQTkZ8Z/ibYCfPHJiiOshqzewecf1
 5vNa8BcbEZ3rygglU/kmlCIBjAVYl4iKoE4hEXv2DDiyro5tFb+dFPttlyhBTpz2qYEzN7gMC
 yN8JEgMaKe5G9z+cahqXFItX0x+hPaTggV/4piv6P8i9CQEW1YofeTbY4fBJN73QjdJvyDtFW
 bI1rtK9B6yzsksqHNi1WYp7wG1k+llotEuttbBItXbGoZbH+b/jL0cNbxoeh9Y1TZuIekX5rV
 p3UpzHvbIaBBMQaPTGLugPBX8SeWVLYfvszuhNJidsMqOny4exiZlA8b3OaoEEjlPD4VfhJ76
 B4Uw8jlRUqvK9lfF8VyHxtWxDSCHKawIFxM1LBvX4VdXrg9+dBiuWlJdXMAMqFQXdLZQoEaZB
 tsR1DZ5aBfUXbTvudFsVEh3Cx6
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

I have 2 boxes connected with 2 network cards each, one
crossover connection and one connection via LAN.
I want to use the crossover connection for backup,
so I want to be able to select exactly this wire when
doing my NFS backup transfers. Everything interconnected via NFS4.1
and automount.

Now the thing is, if there is an already existing connection
via LAN, I am not able to select the crossover connection,
there is some session reuse against my will.

automount config:
/net/192.168.99.1  -fstype=nfs4,nfsvers=4,minorversion=1,clientaddr=192.168.99.100   /  192.168.99.1:/
/net2/192.168.98.1 -fstype=nfs4,nfsvers=4,minorversion=1,clientaddr=192.168.98.100   /  192.168.98.1:/

mount -l:
192.168.99.1:/data on /net/192.168.99.1/data type nfs4 (...,clientaddr=192.168.99.100,addr=192.168.99.1)
192.168.99.1:/data on /net2/192.168.98.1/data type nfs4 (...,clientaddr=192.168.99.100,addr=192.168.99.1)

As you see, both connections are on "192.168.99.1:/data", and the backup runs
over the same wire as all user communication, which is not desired.
This even happens if I explicitly set some clientaddr= option.

Now I found two workarounds:
- downgrade to NFS 4.0, clientaddr seems to work with it
- choose different NFS versions, i.e. one connection with
  minorversion=1 and the other with minorversion=2

Both possibilities seem a bit lame to me.
Are there some other (recommended) variants which do what I want?

It seems different minor versions result in different "nfs4_unique_id" values,
and therefore no session sharing occurs. But why do different network
interfaces (via explicitly set clientaddr= by user) not result in different
"nfs4_unique_id" values?

Thanks for any comments and advice,
Manfred
