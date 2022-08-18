Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D89F597C48
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Aug 2022 05:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237518AbiHRDbg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Aug 2022 23:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbiHRDbf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 17 Aug 2022 23:31:35 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBC69018A
        for <linux-nfs@vger.kernel.org>; Wed, 17 Aug 2022 20:31:35 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso3560177pjk.0
        for <linux-nfs@vger.kernel.org>; Wed, 17 Aug 2022 20:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:content-id:mime-version:from:references:in-reply-to
         :cc:to:subject:from:to:cc;
        bh=/FofTVsK9IlfmWDW/30e5CfZ6dtBzKhzwgrCZijjfbI=;
        b=mB1yS1vYVbxnbLAOx6627ADY+O02e+WXza6sjOwJGABfXBTY3VpzPAlHwVNRhAgkpL
         63lhS0KGGJynWns23uZCKcvgsI74ZPxrJ5DOaToNaJrisFxb8p7tdGN2dC2fR5jsbyKx
         whRAAE/v5/CDSZg0aHqKQTN3m8oeF7ZsPk2U6W6gnSDJbksXWXdturFWJJbHJJZXtqbW
         a9EvAF/89U5qfEhGnqsKVbELGNhT8uebMj6lxePCRNycgogvxtJiFTP5yBSY13XEUmWM
         Bal6bnxGg7a+UvDJt2/v2wUFBekgRxMfKBpKXyYpgz2AH01O11ymXHtrAld7F4Gopozh
         s/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:content-id:mime-version:from:references:in-reply-to
         :cc:to:subject:x-gm-message-state:from:to:cc;
        bh=/FofTVsK9IlfmWDW/30e5CfZ6dtBzKhzwgrCZijjfbI=;
        b=FohHJwR15dy2uqf6q8rASuwy8LnTSD+ddTdX5obt4G2VQLm56BWOt7kOowX6gZoVMg
         tNWu1seLySHj/4cM+0Diwac7wlGGQC5x1Jen0wFxpeJRbDhWVQpxRKYWRHMx6nQ7QLi4
         Ac258cp/da+0xtdZtT6GZbg+dvExaKH8kqqfaToN7z10BZgXteExrhvugEf2UHbGkxP7
         HmTsgYgBVuKRNErZcpmjX4x6LQa874Ln9uZmdf4bgVwmSx+DBf+uai/9ZWYGad0a9TzK
         YjlF37lsxJ53XqvckqbbTIWSeDdwnGhzyaHk4umzy8xzn9yojXdk5qCKesMxNRre4Ri4
         gVsw==
X-Gm-Message-State: ACgBeo1jaEcYYf0D5Oo7lW24kS/+DIvCnG83DeCkw3tV4IkL7Ro9crcs
        NSM067SQqhRF7h/6ZO7HJlg=
X-Google-Smtp-Source: AA6agR553t23v7IhCqnNZug6TWxNafJto6HeUEF1Zw4rWaUTbhI2gj7Xw/m1k9CwDp0l0Ah7MYcAkw==
X-Received: by 2002:a17:90b:3141:b0:1f7:75cf:a449 with SMTP id ip1-20020a17090b314100b001f775cfa449mr1082653pjb.18.1660793494535;
        Wed, 17 Aug 2022 20:31:34 -0700 (PDT)
Received: from jromail.nowhere (h219-110-108-104.catv02.itscom.jp. [219.110.108.104])
        by smtp.gmail.com with ESMTPSA id u15-20020a170902e80f00b0016d95380e8esm193203plg.140.2022.08.17.20.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 20:31:34 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=jrobl) by jrobl id 1oOWFo-0002SS-7m ; Thu, 18 Aug 2022 12:31:32 +0900
Subject: Re: NFS, two d_delete() calls in nfs_unlink()
To:     "NeilBrown" <neilb@suse.de>
Cc:     trond.myklebust@hammerspace.com, linux-nfs@vger.kernel.org
In-Reply-To: <166079133167.5425.16635199337074058478@noble.neil.brown.name>
References: <7634.1660728564@jrobl> <166079133167.5425.16635199337074058478@noble.neil.brown.name>
From:   hooanon05g@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9450.1660793491.1@jrobl>
Date:   Thu, 18 Aug 2022 12:31:31 +0900
Message-ID: <9451.1660793491@jrobl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

"NeilBrown":
> Thanks for the report.
> This possibility of calling d_delete() twice has been present
> since  9019fb391de0 in v5.16.

I don't think 9019fb391de0 is a problem.
Before v6.0-rc1, the target dentry was unhashed by __d_drop() call in
nfs_unlink(), and nfs_dentry_handle_enoent() skipped calling d_delete()
by simple_positive(). d_delete() was called only once via
nfs_dentry_remove_handle_error().

In v6.0-rc1, the dentry is not unhashed and nfs_dentry_handle_enoent()
doesn't skip calling d_delete().


> How did you discover this bug, and why do you think my patch
> caused it?

I met this problem during a stress test aiming a filesystem I am
developing.
And I think unhashing causes nfs_dentry_handle_enoent() to call
d_delete().


J. R. Okajima
