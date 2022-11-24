Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EEE637AF3
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Nov 2022 15:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiKXOB7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Nov 2022 09:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbiKXOBc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Nov 2022 09:01:32 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23BD1533BF
        for <linux-nfs@vger.kernel.org>; Thu, 24 Nov 2022 05:58:58 -0800 (PST)
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CCFB83F176
        for <linux-nfs@vger.kernel.org>; Thu, 24 Nov 2022 13:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1669298336;
        bh=fS9nQy3pLsdgcouUOczjL/OfRdxN73+qUgZWg0qIN9g=;
        h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type;
        b=kFIhGHlWgbEyRBbrw3PvarHgmESEe7f0+lwrHZJsxuYBkiX79ZidZaVAbiMlNHyxN
         2wnI+LHmZmla5opdOPuBU8WJTCi1VQft04z6LzenqYpzRw2HwL1MUQ/LV6OMllRSRu
         fXLmhnLLLbEAIdb97GziF2G/b0iqu7vDTsx93jC5h7/XzMqKwQdEiut0zR0iDqcfc6
         q1nVtHq+H26sMPzHOej3v4j5RsPDRDWgNtIhqavU1uj+4grmRs0TCHu2s4x/vgfKKe
         l7fFd/jtxhMESLPwAUpjif5jRJTENcixQ67riMWj8l+lzZa9UgeIWqKQ9qAloHiS8F
         CV4zFYtigUOoA==
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-142e52482b3so838753fac.5
        for <linux-nfs@vger.kernel.org>; Thu, 24 Nov 2022 05:58:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fS9nQy3pLsdgcouUOczjL/OfRdxN73+qUgZWg0qIN9g=;
        b=tD+QeiXzKtQwa4MqHaIoZhMLed8JYZHJeVEjzOdBdRq7m+SlSXvvL+hABsAQiOhT8f
         UeBQsNRKn1olQMfI9IWJvHwszn8BgK9SAomDeGBmmq2qNsgrok66xlVWMGjRTt3whEGz
         HE4dqXHW0pPYZTPTCXq2yvISTwgvtT2FgAyfGkvCjEJQ7mPSE7WmQ/NoMLctcei3gmyL
         MdDhN86aOoGLNXQA0dSSnjqJoEe4xzOW5wVbCKeCVzLSBVENhyhaDv6SeuSEYAh4kfT4
         AvCgvb95/3CsKhSZwC9worLkNifRyavKUSfDHH/TVmzxcEGb9nqWp882a6MDsOFIhwbu
         4GIA==
X-Gm-Message-State: ANoB5plo5fN4TnDqKBSGX3eVORmP26trO+SyfpAKjmjoyoTD/h10lj+P
        5Da5VFRRa8wOTZur5rY5EcnWA0Ns8ZrhVr2E86sHERjSJREqKdfxVL4FrI91fbUTpWj86T8ek7M
        aGaDMvNW5Oy8jcvkBH5x40a5pnwgJ589+yz4XgC+++v0zMkQPB23MmA==
X-Received: by 2002:a05:6830:56f:b0:66a:b4c6:400a with SMTP id f15-20020a056830056f00b0066ab4c6400amr6919265otc.14.1669298335516;
        Thu, 24 Nov 2022 05:58:55 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4FIjaqlTk+wDtPavirqooiAvt5DWvoX5wQGxg8BtCvxgJxNVqLDixcTlnBYVSlWNBBscioa+DZvm2LHjTGodE=
X-Received: by 2002:a05:6830:56f:b0:66a:b4c6:400a with SMTP id
 f15-20020a056830056f00b0066ab4c6400amr6919253otc.14.1669298335257; Thu, 24
 Nov 2022 05:58:55 -0800 (PST)
MIME-Version: 1.0
From:   Chengen Du <chengen.du@canonical.com>
Date:   Thu, 24 Nov 2022 21:58:44 +0800
Message-ID: <CAPza5qdTutc0MJ+p-VW-nQkBa4B6SwWsY=6kd4MQb0HCC4hDGA@mail.gmail.com>
Subject: NFS client permission error after changing the user's group in the server
To:     linux-nfs@vger.kernel.org
Cc:     Gavin Guo <gavin.guo@canonical.com>,
        Gerald Yang <gerald.yang@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi all,

I am a newbie starting to contribute upstream.
Recently I encountered an issue that is reproducible by the following steps=
:

1.[client side] mount NFS
testuser@kinetic# sudo mount -o vers=3D4.2,sec=3Dsys,lookupcache=3Dnone
<-NFS server IP->:/srv/nfs /mnt
2.[client side] clear cache to make environment simple
testuser@kinetic# sudo tee /proc/sys/vm/drop_caches <<< 2
3.[client side] testuser is not part of testgroup, so failing to
create a file is expected
testuser@kinetic:~$ ls -ld /mnt/private/
drwxrwx--- 2 root testgroup 4096 Nov 24 08:23 /mnt/private/
testuser@kinetic:~$ mktemp -p /mnt/private/
mktemp: failed to create file via template
=E2=80=98/mnt/private/tmp.XXXXXXXXXX=E2=80=99: Permission denied
4.[server side] add testuser into testgroup, which has access to
'private' folder
root@kinetic:~$ usermod -aG testgroup testuser && echo `date +'%s'` >
/proc/net/rpc/auth.unix.gid/flush
5.[client side] create a file again but fail
testuser@kinetic:~$ mktemp -p /mnt/private/
mktemp: failed to create file via template
=E2=80=98/mnt/private/tmp.XXXXXXXXXX=E2=80=99: Permission denied
6.[client side] clear cache and create a file again
testuser@kinetic# sudo tee /proc/sys/vm/drop_caches <<< 2
testuser@kinetic:~$ mktemp -p /mnt/private/
/mnt/private/tmp.J6PTDV6S4V

I analyzed and found out the root cause is nfs_access_get_cached() in
nfs_do_access().
The access cache only expires if either NFS_INO_INVALID_ACCESS is on
or timeout (without delegation).
Adding a user to a group in the NFS server will not cause any
attributes to change.

The behavior of changing the user's group may not happen frequently,
so removing the cache may not be a proper choice.
IMHO, we could add an attribute in struct nfs_fattr to pass mask from
the NFS server.
The NFS_INO_INVALID_ACCESS can be set once we find out the mask has
changed while revalidating dentry,
then the cache will be cleared and get the correct mask from the NFS
server in nfs_do_access().

Please help confirm the approach and kindly point out if there is
anything I have not considered.
It will be my pleasure to contribute to this issue.
Any comments and suggestions are welcome!

Best regards,
Chengen, Du
