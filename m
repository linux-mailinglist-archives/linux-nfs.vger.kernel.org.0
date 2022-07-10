Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3777056CE9A
	for <lists+linux-nfs@lfdr.de>; Sun, 10 Jul 2022 12:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiGJKny (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 10 Jul 2022 06:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJKnx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 10 Jul 2022 06:43:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9272C1B0
        for <linux-nfs@vger.kernel.org>; Sun, 10 Jul 2022 03:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657449830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sE852ravTvVsPO18Sdl2baOG3S42zcZNkqm0cGHZglM=;
        b=HbNfgrKtjFGEswdcw55yj0KNK2qvUesoMr45HZy10B91VcPlUIo0EIvDQpF+DBe9J1cHhU
        2zLqNH0x+6kxCa/kKOYwV0Wy5Ks4U1P+BfhtVhIRhyt9eEaEXk0faDcZ4ZLUKVhp4GQMpB
        AvGuxcZwjjy/X2ZbLJQ57eRUzf63QvU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-240-iOIkW986O_6122rAwwIluA-1; Sun, 10 Jul 2022 06:43:49 -0400
X-MC-Unique: iOIkW986O_6122rAwwIluA-1
Received: by mail-ed1-f71.google.com with SMTP id b7-20020a056402350700b00435bd1c4523so2423910edd.5
        for <linux-nfs@vger.kernel.org>; Sun, 10 Jul 2022 03:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sE852ravTvVsPO18Sdl2baOG3S42zcZNkqm0cGHZglM=;
        b=GGimK15zAXF5uZ51vUZz7yzY+mNiAYCSkxCOqf3b7kKAAvMTXhQSUV62qSSLnzybk8
         9m+c9vM3Is8oOU7yJDd4aFxBzZ9OHCTzf6sjH6YWoT6o9DVFL/NKZTuVPHKq+i9iKM65
         76rNqqRhRGi/fcf0zd0Fz6AVGXFYvHBjXoYXjlt4YlgzbkdCKp+WAFOoMtNbkZcyYh1m
         7IVtnHnckVyGjPR7KfmGf53bh5yZY2N6PWKr65l5LVhauk7+mgXOT/BIOY/F9NGTtpGV
         xicbkaIZGZt4kSbCJGR85J28tKOEUv32NEgdqrL6Kpb8D9SsbbB/xInxU+IEyCD+7TAQ
         7n2w==
X-Gm-Message-State: AJIora+A0HAEvxQKS2ZOte5QpTuPbNSn1dxa2z5tHbGjBUwV7H5Pap16
        r0IaDWZHsh2oxrmcznENTofrhIPLLeKp8w1uN3iQXUY/aY51/jOn0sGfP50wiNepQTDvY+9csOo
        pnVEbjRrPOGSt7d5MxKmZ
X-Received: by 2002:a17:906:106:b0:715:7cdf:400f with SMTP id 6-20020a170906010600b007157cdf400fmr13258590eje.1.1657449827531;
        Sun, 10 Jul 2022 03:43:47 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tOUSITMELdjSeJP9iBLs0F347SSLFLqXqHZEGAsoNzaXrTDc+RCSt9SVkaJYi8qOot4OaaYQ==
X-Received: by 2002:a17:906:106:b0:715:7cdf:400f with SMTP id 6-20020a170906010600b007157cdf400fmr13258569eje.1.1657449827331;
        Sun, 10 Jul 2022 03:43:47 -0700 (PDT)
Received: from localhost ([185.140.112.229])
        by smtp.gmail.com with ESMTPSA id q16-20020a50aa90000000b0043aba618bf6sm2525690edc.80.2022.07.10.03.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 03:43:46 -0700 (PDT)
Date:   Sun, 10 Jul 2022 12:43:44 +0200
From:   Igor Mammedov <imammedo@redhat.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     ondrej.valousek.xm@renesas.com,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bfields@fieldses.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] nfsd changes for 5.18
Message-ID: <20220710124344.36dfd857@redhat.com>
In-Reply-To: <EF97E1F5-B70F-4F9F-AC6D-7B48336AE3E5@oracle.com>
References: <EF97E1F5-B70F-4F9F-AC6D-7B48336AE3E5@oracle.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 21 Mar 2022 14:12:31 +0000
Chuck Lever III <chuck.lever@oracle.com> wrote:

couldn't find offender patch on ML so replying here

> Hi Linus-
> 
> The following changes since commit 7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3:
> 
>   Linux 5.17-rc6 (2022-02-27 14:36:33 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.18
> 
> for you to fetch changes up to 4fc5f5346592cdc91689455d83885b0af65d71b8:
> 
>   nfsd: fix using the correct variable for sizeof() (2022-03-20 12:49:38 -0400)
> 
> ----------------------------------------------------------------
> New features:
> - NFSv3 support in NFSD is now always built
> - Added NFSD support for the NFSv4 birth-time file attribute
[...]

> Ondrej Valousek (1):
>       nfsd: Add support for the birth time attribute

This patch regressed clients that support TIME_CREATE attribute.
Starting with this patch client might think that server supports
TIME_CREATE and start sending this attribute in its requests.
However kernel on server side (since this patch and to
current master) upon getting such request will return EINVAL.
(my guess is that TIME_CREATE not being decoded properly and
that messes up request parsing).

End result is unusable mount (unless it's treated as readonly).

Reproduces with current master (HEAD at e5524c2a1fc40) and MacOS
client (Big Sur or newest Monterey).

server is typical setup exporting files from XFS (Fedora36)

 #  rpcdebug -m nfsd -s all

on client:

 % mount -t nfs -o vers=4,rw,nfc,sec=sys testnas:/mnt  ~/test
 % touch ~/test/fff
     touch: test/fff: Invalid argument

server logs:

 nfsd: fh_compose(exp fd:00/128 fff, ino=0)
 NFSD: nfsd4_open filename  op_openowner 0000000000000000

Here is a request the touch generates:
        Network File System, Ops(6): PUTFH, SAVEFH, OPEN, GETATTR, RESTOREFH, GETATTR
            [Program Version: 4]
            [V4 Procedure: COMPOUND (1)]
            Tag: create
            minorversion: 0
            Operations (count: 6): PUTFH, SAVEFH, OPEN, GETATTR, RESTOREFH, GETATTR
                Opcode: PUTFH (22)
                Opcode: SAVEFH (32)
                Opcode: OPEN (18)
                    seqid: 0x00000004
                    share_access: OPEN4_SHARE_ACCESS_BOTH (3)
                    share_deny: OPEN4_SHARE_DENY_NONE (0)
                    clientid: 0xba93c9620aec46ea
                    owner: <DATA>
                    Open Type: OPEN4_CREATE (1)
                        Create Mode: UNCHECKED4 (0)
                        Attr mask: 0x00040002 (Mode, Time_Create)
                            reco_attr: Mode (33)
                            reco_attr: Time_Create (50)
                    Claim Type: CLAIM_NULL (0)
                        Name: fff

        [...]

when trying to copy file via GUI (Finder) it goes a different route
but ends up with error anyway and with leftover 0-length file on server
with messed up permissions, i.e.

open/create without Time_Create succeeds but followup
setattr with Time_Create fails EINVAL.

        Network File System, Ops(3): PUTFH, SETATTR, GETATTR
            [Program Version: 4]
            [V4 Procedure: COMPOUND (1)]
            Tag: setattr
            minorversion: 0
            Operations (count: 3): PUTFH, SETATTR, GETATTR
                Opcode: PUTFH (22)
                Opcode: SETATTR (34)
                    StateID
                    Attr mask: 0x00450002 (Mode, Time_Access_Set, Time_Create, Time_Modify_Set)
                        reco_attr: Mode (33)
                        reco_attr: Time_Access_Set (48)
                        reco_attr: Time_Create (50)
                        reco_attr: Time_Modify_Set (54)
                Opcode: GETATTR (9)
            [Main Opcode: SETATTR (34)]

[...]
> --
> Chuck Lever
> 
> 
> 

