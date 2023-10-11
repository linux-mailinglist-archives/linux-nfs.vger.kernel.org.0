Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E81D7C55F3
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Oct 2023 15:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbjJKNzx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Oct 2023 09:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbjJKNzt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Oct 2023 09:55:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56669A7
        for <linux-nfs@vger.kernel.org>; Wed, 11 Oct 2023 06:55:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A87C433C8
        for <linux-nfs@vger.kernel.org>; Wed, 11 Oct 2023 13:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697032548;
        bh=MlLI9YwVA+uJErzuQ0ejL2MpIZij4Dnxb2brjDwLnoA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y+27LBcV+Mtm40sAKx4DBUNq6fuP/t3Qx6b05pCrYgaSVNgdg6LuXWiYOFIpHr1H0
         0wD1T+yDe8a8vPXWjMZhgS9ZQ4w4sUvZroZHSoVX6Yx32aqeaUEm70bvDW8LfpDivV
         ZVpl7xv0TKeNb3Mj4ouU6YaSal2fUqO+3attRTkkbl1+5AGyrV+D9rgCv+BBhnWp6X
         MrYgGYie2AOX0pTf45OOA+5b3XQxt7KJDbr5/Kx8n5YYLWT2nVf7ge87KHhm9hkguq
         LWHDZwOOBAx04x56MOig0SsaUqUjFapeLy6RwmYw7qSxJZOVNcuh6StGT12skq395o
         nACu7cKD8tPhA==
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-41810cfc569so44029381cf.2
        for <linux-nfs@vger.kernel.org>; Wed, 11 Oct 2023 06:55:47 -0700 (PDT)
X-Gm-Message-State: AOJu0YwIGU0jMUsuhbFHQNpaCutG1YI+dR5/T5Lg92VBwrl2Qp41EfVa
        DGqTLCIcP4jJS5jsPFYziAGYzdk3JXXBbNK5Jns=
X-Google-Smtp-Source: AGHT+IECfodI6tijTIcF6CJywrqh7UGLc/LZyxZdR58T6WPyL1fm3x1gVmTQriTscQpX78GE4WJPYShfxagKZU6FCVM=
X-Received: by 2002:a05:622a:144d:b0:40d:6219:d813 with SMTP id
 v13-20020a05622a144d00b0040d6219d813mr27425117qtx.68.1697032547194; Wed, 11
 Oct 2023 06:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <2e840ad028869edeb4238869eca81593820688b1.camel@kernel.org>
In-Reply-To: <2e840ad028869edeb4238869eca81593820688b1.camel@kernel.org>
From:   Anna Schumaker <anna@kernel.org>
Date:   Wed, 11 Oct 2023 09:55:30 -0400
X-Gmail-Original-Message-ID: <CAFX2Jfmrh1YVtf_G1pSsORnF5qVMBjrgMBsS4BWTmx+vLdoAZw@mail.gmail.com>
Message-ID: <CAFX2Jfmrh1YVtf_G1pSsORnF5qVMBjrgMBsS4BWTmx+vLdoAZw@mail.gmail.com>
Subject: Re: missing patches for v6.6-rc
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org, Dai Ngo <dai.ngo@oracle.com>,
        Scott Mayhew <smayhew@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Jeff,

On Tue, Oct 10, 2023 at 8:49=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> Hi Anna,
>
> There are a couple of client side patches that I think we want in v6.6,
> but that haven't shown up in linux-next yet. Do you still plan to take
> these from Dai and Scott?

I've pushed out Dai's patch to my linux-next branch, and I can do
another pull request before the end of the 6.6 cycle. Is Scott's patch
still needed after your patch "nfs: decrement nrequests counter before
releasing the req" which went into 6.6-rc5? If so, it doesn't apply
cleanly on top of the current code so I'll need to fix it up.

Anna

>
>     [PATCH 1/1] NFS: Fix potential oops in nfs_inode_remove_request()
>     [PATCH v3 1/1] nfs42: client needs to strip file mode's suid/sgid bit=
 after ALLOCATE op
>
> Thanks,
> --
> Jeff Layton <jlayton@kernel.org>
