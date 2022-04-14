Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFF8501ECD
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Apr 2022 01:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238999AbiDNXE4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Apr 2022 19:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347401AbiDNXEx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Apr 2022 19:04:53 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA21B76292
        for <linux-nfs@vger.kernel.org>; Thu, 14 Apr 2022 16:02:26 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id y32so11527321lfa.6
        for <linux-nfs@vger.kernel.org>; Thu, 14 Apr 2022 16:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=torvalds.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TmDxcKPWafMc6kQhJRe4mwNBrRdWvM49+RrpwNMqvEo=;
        b=mq0kK/6Y9aGXGuTReDla+rvcAWVkYcgwOLiIVYEONFY+iOiNhfpKnuRLoNYVwJYp/z
         refzdoXFjNa8lSTWhyknm1pC/CWnWT1OqTjMZwnuJlLFKcEu6AkozOynimdEaDbTI1UN
         JGrlR7Syziuv2A9w1McfC9+CCRG1UybCRQk+4GEmaNLKJguKrl7z9IkhXEjI+BP7mlf/
         cc1WnWIikINaoD35VpdL318zJkuhhzc/As/jvPuith0sGHYFIFt0oQ26HgwaQrymMnaM
         6iq50slhkhbC2esMZnijxU1KbqdfNVjtRzaTc4Ot+CoDNdZQqZVv+TasVTqrqdxlqEqD
         Pj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TmDxcKPWafMc6kQhJRe4mwNBrRdWvM49+RrpwNMqvEo=;
        b=RvbHGUw2PsFXVc8Y2GZ6lwfLXy8hJy+zzeE4AvVFJbyCSM2I1iP/MCt+bYzC8dXTh1
         5OKWFa2IwaDVPf5H8VN3YZ4paPrTCCiVSZtjTbQ/uXcAUT7jfI53+bupYjMeC8+4vqa2
         WU4RhGRJtTtmu4wO5mizHZzffHxXNEg2lbu8YsuTmQdq7IO3/ylBuigTZnxZhNgWno4I
         AaWZ3KMgRXqOIMbuvSSAwknAEgEpCOjxnkkK6eeE0N6ks2u73OVGYyDIfgPkyFv+aVg5
         0AK1cb0eDcpnp+HAxbps8Mz9Kf6OmadTniefijH/e/2Vcyhoh4Jlsql/TGvNl95EstVB
         h2KA==
X-Gm-Message-State: AOAM532FOwegwn4fT4AjF/Zmfk9Zsl6MBoW3HyPsz5lASYv51v+Umdm4
        cV2RFAtQeLgJKqscUH8TwqnMvKQ1nSrEB+J0FhIMTg==
X-Google-Smtp-Source: ABdhPJxEc7rBSTcVi9PXMYVzRo0oAPh7ygD38HILzdZeM2OrZD+1cmuwmTa8sMZPtDhEXTHa1nZXIuXFQ9LxPDLVf/Y=
X-Received: by 2002:a05:6512:b12:b0:44a:ba81:f874 with SMTP id
 w18-20020a0565120b1200b0044aba81f874mr3350330lfu.449.1649977345105; Thu, 14
 Apr 2022 16:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <164990865594.11576.14265561452573398586@noble.neil.brown.name>
In-Reply-To: <164990865594.11576.14265561452573398586@noble.neil.brown.name>
From:   Linus Torvalds <linus@torvalds.org>
Date:   Thu, 14 Apr 2022 16:02:08 -0700
Message-ID: <CAHk-=wgeNVuptfRt2kPcvp+BtmEJraxxzMx3wKvQz=qwzSVH1w@mail.gmail.com>
Subject: Re: [PATCH resend] VFS: filename_create(): fix incorrect intent.
To:     NeilBrown <neilb@suse.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        David Disseldorp <ddiss@suse.de>,
        Jeff Layton <jlayton@redhat.com>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Apr 13, 2022 at 8:57 PM NeilBrown <neilb@suse.de> wrote:
>
> So only set LOOKUP_CREATE|LOOKUP_EXCL if there really is an intent
> to create, and use the absence of these flags to decide if -ENOENT
> should be returned.

Applied.

                Linus
