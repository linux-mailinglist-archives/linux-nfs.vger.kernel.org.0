Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B74786121
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Aug 2023 22:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjHWUAj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Aug 2023 16:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbjHWUAL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Aug 2023 16:00:11 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF2E10C2
        for <linux-nfs@vger.kernel.org>; Wed, 23 Aug 2023 13:00:09 -0700 (PDT)
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D2BB43F171
        for <linux-nfs@vger.kernel.org>; Wed, 23 Aug 2023 20:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1692820808;
        bh=oTkPTsqqPcCsZCWepiGPj0HKdt5leFbnox0uL/cIik8=;
        h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type;
        b=akSPXr/2j07gKouDDLAHUbxTUrKInwUKeJE0bgUcxasQWt4PZykn/fpxF6QplyBAg
         eTgLFwujjymICun5wsFp3Zie45cirB3Rj1TYDPiW5LcCkabNr+Gt7EdBdFHhBboD3r
         /MnSJuDI3PSeUd1GxVQv/A3kEbkduhsYtjBXYOMjscUqA/gSFap76llRGH6/SDTukC
         onW8Q3ybI0msWt9Va/ug6CMD0cl/x8qxbVIOnzX9PnzHfBBLDRiO3fGYHQaVglbiWp
         ZdQsIQ7j0GFLb3tDgXdAtgm6mq8Td1XxpF2+5iYb7FrSzaN5p9UxUF9VPsRts5tlcE
         AYbEPw539xmew==
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6b9c82f64b7so5653006a34.3
        for <linux-nfs@vger.kernel.org>; Wed, 23 Aug 2023 13:00:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692820807; x=1693425607;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oTkPTsqqPcCsZCWepiGPj0HKdt5leFbnox0uL/cIik8=;
        b=jC1js48SdsDOtRAifYtrDvFHtuQEPj3dQDuWF2EWWQWFuz4QVK2E9+NtwfjbXX4G/8
         owKRH7Wuqtzk/Hhd/0E0WKmiN3wzwNOg0E70k1pB8BNnt+Xv7OIruCkgIyZHqIYi1Eib
         th3ZCyXkQElW+kq4K9nXRxGGqosJNF/fKmyDWCJ7Ap4ct19FV0Ea5VGDlLV4z1WyADzL
         lcuocPC2AE4E8cUZlO3pwNtIlZ7a/EG+QBJdvEDdsC6dfnT29pN2iNX0Hu8jpW58SBmv
         4eoFn3RT3wok/EJSIJZLaUAveXosASVwqCVkWFh2d+1JugujgPj5noczYPXI4JmvitkQ
         +2/A==
X-Gm-Message-State: AOJu0Yz+KmmJrk50sVxR2pTFuDSa2FCcaKcqGnlwV94t/S6EGP8ePjCy
        FJ+j/9psS9Ip8xA8YPm6NJN+4e3aOPWx7ivq4ZHXYlwZdZLUe63Vny4PUnVDDDR2dMMukIqjOQ1
        ue6FVpfAOa6exT1dT0XviqL2D9Latf4DenUa5Cr9LFGl0zp9Mu6TKuV7uTfVEgnhU
X-Received: by 2002:a05:6871:606:b0:1c8:39a6:77a9 with SMTP id w6-20020a056871060600b001c839a677a9mr14145005oan.31.1692820807628;
        Wed, 23 Aug 2023 13:00:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZtfwh4cRWVCDpVjGzUr+1SZhQscO5gvge4Kdyzmy3nKNylAZZ7C8gLjbdCBkWkkqlyvRbA+5Ic7/qyRQViUM=
X-Received: by 2002:a05:6871:606:b0:1c8:39a6:77a9 with SMTP id
 w6-20020a056871060600b001c839a677a9mr14144988oan.31.1692820807357; Wed, 23
 Aug 2023 13:00:07 -0700 (PDT)
MIME-Version: 1.0
From:   Pedro Principeza <pedro.principeza@canonical.com>
Date:   Wed, 23 Aug 2023 16:59:31 -0300
Message-ID: <CA+PbK_6rL3FQLfSLSVb4vSV+psgRBv7iBY40viAYQPkkWiWLEA@mail.gmail.com>
Subject: Question on RPC_TASK_NO_RETRANS_TIMEOUT / NFS_CS_NO_RETRANS_TIMEOUT
 for NFSv3
To:     linux-nfs@vger.kernel.org
Cc:     Tiago Pasqualini <tiago.pasqualini@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi, there!

We have some shares that use NFSv3 with TCP and Kerberos and have been
hitting an intriguing issue with those. We have noticed that network
instabilities have been causing some 'Permission denied' errors on
files.

The current scenario we have is based on NFSv3 over TCP clients,
configured with Kerberos (krb5p) authentication against a NetApp NFS
Server (ONTAP).  This is happening regardless of the Kernel we use
(our main tests bear 4.15 and 5.15 generic Ubuntu Kernels - from
Bionic and Jammy), and we have not found any interesting commits in
either components upstream that would change the behaviour in hand.

We tracked those issues down and found out that the 'Permission
denied' happens because our packets are failing the GSS checksum[1].
We kept investigating and discovered, after some tcpdump, that this
happens because the client retransmits RPC packets, which increases
the GSS sequence number. Meanwhile, the response to the original
packet gets received, but the checksum fails because the client is
expecting a different GSS sequence number.

This can be avoided with NFSv4 because the RPC client is created with
a "no retrans timeout" flag[2]. Such a flag is not set and is
impossible to set on NFSv3. We did some investigation and thought that
setting this flag would fix our problems without the need to move to
NFSv4.

Our question is: is there a reason this flag is not being set nor is
it possible to set it for NFSv3? Is there something on NFSv3 that
demands RPC retransmissions even with TCP?  One "hint" we have come
across is that it is *explicitly mentioned* in NFSv4's RFC [3], and
there is nothing in NFSv3 at all - most likely due to the fact we're
dealing with a stateless protocol.

Any comments would be greatly appreciated here!

Thank you,

[1] https://github.com/torvalds/linux/blob/v5.15/net/sunrpc/auth_gss/gss_krb5_unseal.c#L194
[2] https://github.com/torvalds/linux/blob/v5.15/fs/nfs/client.c#L521
[3] https://datatracker.ietf.org/doc/html/rfc7530#section-3.1.1

--
Pedro Principeza
Senior Sustaining Operations Engineer
