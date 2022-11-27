Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1118D639CF6
	for <lists+linux-nfs@lfdr.de>; Sun, 27 Nov 2022 21:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiK0Utx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 27 Nov 2022 15:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiK0Utt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 27 Nov 2022 15:49:49 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADED3DF09
        for <linux-nfs@vger.kernel.org>; Sun, 27 Nov 2022 12:49:48 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id mn15so2313470qvb.13
        for <linux-nfs@vger.kernel.org>; Sun, 27 Nov 2022 12:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0EcRsn3mpfYpm/vhZ/v7NRpfbut+cY/FRel9FddrnfI=;
        b=KBcUhnkE30+t44sLhT0QIA/TKDoVVcw2IDATdES6KfLCITZM1dINmG7lHKlIAtF5Bv
         XYen05Yj2oFW9mtHJEXYSDUF20MEYEfNCJOIA7Ao4ErgCMxXzNeUrFhRHU4n0UR5efBV
         NPgtVWwXuMjsplabdQq4ltrd1s/IVTuK0fB6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0EcRsn3mpfYpm/vhZ/v7NRpfbut+cY/FRel9FddrnfI=;
        b=HnFNHe+kSYPvoAzgeRENNoScA4wgqdMys1jszlTD8L3vlmwIcWgYzeKegbb7Y6BAdb
         X0z/3DRaE2bd9PZXFm2g0/9YlorDVwQRshUAbQJqP0E70k/IOHXAvnXqRkn+0H0GwGVn
         7UtMelO9CWfic4I18tYrIXPkV3v7Hk57ok0yfs6clpSMLaRCGV0GmD/3qRdnFKMlAO6E
         Qnyw9AFGC6pNDSp+Lck/Ple1jU9olBTpuVVKOyuDDScQp2Sp63sC3FCuxgiBRqmJfbK1
         KGGIsSrMroRHsqSbexMfTKSCgJul0i/5npFqIPzU20sDO0D1XcN+iwjoiX2vBHlWThKO
         kBGw==
X-Gm-Message-State: ANoB5pnCHCN+qNbsgAAvY4LRtNdGSkEPddn8JWK021nb7cRAOYw6/u0e
        zhoUt9AriZpMsy8mUIgfPRsHzxUGMKJ4pA==
X-Google-Smtp-Source: AA0mqf4tIcXlZQ9n/Ryt+bFTv0578K8BnDO83rZgZ5SihK5Hym/FXYkU/tgdFoPa6ICXjDfgPFqJ1A==
X-Received: by 2002:a0c:fec3:0:b0:4c6:86be:a0c9 with SMTP id z3-20020a0cfec3000000b004c686bea0c9mr26513747qvs.123.1669582187545;
        Sun, 27 Nov 2022 12:49:47 -0800 (PST)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com. [209.85.222.178])
        by smtp.gmail.com with ESMTPSA id w10-20020a05620a424a00b006cfc9846594sm7051379qko.93.2022.11.27.12.49.46
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 12:49:46 -0800 (PST)
Received: by mail-qk1-f178.google.com with SMTP id g10so6004885qkl.6
        for <linux-nfs@vger.kernel.org>; Sun, 27 Nov 2022 12:49:46 -0800 (PST)
X-Received: by 2002:ae9:e00c:0:b0:6f8:1e47:8422 with SMTP id
 m12-20020ae9e00c000000b006f81e478422mr43523021qkk.72.1669582186451; Sun, 27
 Nov 2022 12:49:46 -0800 (PST)
MIME-Version: 1.0
References: <20221117205249.1886336-1-amir73il@gmail.com>
In-Reply-To: <20221117205249.1886336-1-amir73il@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Nov 2022 12:49:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgnnhUqO8mv4=0ri=Q8xYd9dpHm+_r61CTMCkQKj9fN=w@mail.gmail.com>
Message-ID: <CAHk-=wgnnhUqO8mv4=0ri=Q8xYd9dpHm+_r61CTMCkQKj9fN=w@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: fix copy_file_range() averts filesystem freeze protection
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Luis Henriques <lhenriques@suse.com>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
        Luis Henriques <lhenriques@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Ok, this is finally in my tree now. Thanks,

             Linus
