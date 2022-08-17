Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0CC7596C0F
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Aug 2022 11:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbiHQJ33 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Aug 2022 05:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiHQJ32 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 17 Aug 2022 05:29:28 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF682E9C4
        for <linux-nfs@vger.kernel.org>; Wed, 17 Aug 2022 02:29:27 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id l64so11530295pge.0
        for <linux-nfs@vger.kernel.org>; Wed, 17 Aug 2022 02:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:content-id:mime-version:subject:cc:to:from:from:to
         :cc;
        bh=kLiP6zcg3Ginhw+XDh+5eBGHIFnSXP2cU/cS9A26ohQ=;
        b=mhaFtdvQYUfjx8JrB3TC/rmyx2q4Aqo5rz9NGQsc+XHmtVXzYnAv3ukftr+3BbbJvN
         fYy+n0Dnz8hbd1N2ffY6EmajtRP3d8vYNSDfJAmP1yOHvevIDaaTGorbt6wQdqJKHYnx
         UrjV+MG7uK/u/aHjNitybhpLPsItf3CRWRcoFHdHzyJHGnuUM3Hxc6+PLJAMl+iy2gkh
         n4iG3LUtWgt9o1dL3UPmwVvJd1YlB5cJl5ihqQrWkX7ZtRlFOfHR/GEZ17QjMHZ6n32t
         dTlMwnB2cmzJOwiyeU77xe21i3/Qi4KcGwv64FqNcwXprED5dC7GIhDwh2VZvmYnaH0W
         RbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:content-id:mime-version:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=kLiP6zcg3Ginhw+XDh+5eBGHIFnSXP2cU/cS9A26ohQ=;
        b=ZrpI5jGErgyjqNGQyz8eWcF1ApR/8Ut4d7w5bMGKItvmrsv42ONhUi5HnqEP5ON4Oi
         9VwkwEHDIIxvpxHS1e4zn7ZxmIRduOy0OR1uAwzzPm/hecxm6VqQz46zBqo468ogPjKk
         o64MO6V6CNMzh0A0RGgxYPVcA0aI2j4MCRa01KXWnRf5PksXp88Q+HQhdc1sg1w1xeq0
         1qAyFT7poVemOEs/qEWp1p5K2sCcXYAXkRIfTJ9Bac6BsqiJv3UkQbooiislRJc3CbL7
         uABOUsA/C+MDxI6DBEHjD3rNxEQCsObO8YJun0xpA/QVs0rYAYhscn/HxT86chAChLEo
         dtoA==
X-Gm-Message-State: ACgBeo3kLup/sNFWIwLqrad7GS22jERo+OLDGkl5QvkPee5W3llZLibm
        oZIGG88g/X3fjJfazp+/wtkvyU89ytw=
X-Google-Smtp-Source: AA6agR7z3q5sONuMTch3iLMuS6kBlsk2j74Nd4RRjDhS14hlvXcke8WyJPNbrCZF+wTO5cKanJSbvQ==
X-Received: by 2002:a05:6a00:1a88:b0:52f:52df:ce1d with SMTP id e8-20020a056a001a8800b0052f52dfce1dmr25087851pfv.13.1660728567110;
        Wed, 17 Aug 2022 02:29:27 -0700 (PDT)
Received: from jromail.nowhere (h219-110-108-104.catv02.itscom.jp. [219.110.108.104])
        by smtp.gmail.com with ESMTPSA id u18-20020a170902e21200b00172a670607asm44903plb.300.2022.08.17.02.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 02:29:26 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=jrobl) by jrobl id 1oOFMa-0001z9-JP ; Wed, 17 Aug 2022 18:29:24 +0900
From:   "J. R. Okajima" <hooanon05g@gmail.com>
To:     neilb@suse.de, trond.myklebust@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Subject: NFS, two d_delete() calls in nfs_unlink()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7633.1660728564.1@jrobl>
Date:   Wed, 17 Aug 2022 18:29:24 +0900
Message-ID: <7634.1660728564@jrobl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello NeilBrown and Trond Myklebust,

By the commin in v6.0-rc1,
	3c59366c207e 2022-08-08 NFS: don't unhash dentry during unlink/rename
nfs_unlink() stopped calling __d_drop().
And it MAY cause two d_delete() calls. If it happens, the second call
leads to NULL pointer access because d_inode is already cleared.

Here is the detail.

nfs_unlink()
+ nfs_safe_remove()
  + NFS_PROTO(dir)->remove() <-- returns ENOENT
  + nfs_dentry_handle_enoent()
    + if (simple_positive()) d_delete() <-- 1st call and d_inode is cleared
+ nfs_dentry_remove_handle_error()
  + if (ENOENT) d_delete() <-- second call and NULL d_inode is accessed

How about adding a condition for d_delete() call in
nfs_dentry_remove_handle_error(), such like simple_positive()?


J. R. Okajima
