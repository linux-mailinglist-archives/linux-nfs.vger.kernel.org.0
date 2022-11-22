Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EEB63367F
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Nov 2022 09:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbiKVIAm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Nov 2022 03:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiKVIAk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Nov 2022 03:00:40 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD04D1EAFB
        for <linux-nfs@vger.kernel.org>; Tue, 22 Nov 2022 00:00:39 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-3abc71aafcaso4041927b3.3
        for <linux-nfs@vger.kernel.org>; Tue, 22 Nov 2022 00:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h59ryiMCs2FQd65ugpgIMTexsvSUB1uVySh9oB0AU10=;
        b=sGp57hkr/+FpiiZ04zLsl0PA+1CdljLGbeo6ITcDfXEQJzdBa1wLCkwM7LeSRr79EE
         OVhmnOlEcdacYfyLjQ+OPyU9+qEms70bINesDX3r2eWdjRJmlGI5LGpAuzVBvBWopPbX
         4J2p+HDFGL0njk3yrG+DHSG3Gh12lyb2f0vddS0Kip/RbeXyUGAZZ83F94sFyzgQMSZn
         2/T77fq0hYl71jIhAlD/+Un8+6vq8NTuWwni0KP7aN1q9H82YDKdPLMBdAa8S1cqz4ak
         iA+2T8ppJDODwQ74ked2zJhSD6NEDLx9qjvJXlrOIFW5AP6r/m63BtDireeFi5+Ts/WD
         Wu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h59ryiMCs2FQd65ugpgIMTexsvSUB1uVySh9oB0AU10=;
        b=GTm6S259e2sGGiOTtXbBkNTAHZKJJ+V2eDe00e0MZ5KPvcx8nE/rXlMt+ussuwsGA+
         h/9iazuN/Vb6tt4Qu7q5roWlGQvnYH7kVjHtG2y6GB+lhkmfdpFIiSSZ4cetM7KhWK3T
         JGf+0kLGyCcagliaHKPUxSys0jmVVi6A2Xl8ze4uHEqub4EPl3xSbhgUEjWqhMeG9y38
         obh7t7zwyiXUWQQQ1kJ2lZhGWqyAmjFfeckKHBdUkwO55qQ/PVu1dE7GlmJVOqJVmEP/
         BzgHLOoX+4jOOEGjbp9BnuwOoxX4BKAdcq9jnVFAZH9mpvcyfuaKae02yYdXyTrsQfwo
         oVWg==
X-Gm-Message-State: ANoB5pkPId++BdrRKD+QgnpUNuyALcC8+Ss9Owqx4aAFPyJepl6KUVXg
        uaXe42y3wphesZ/FXOjEbQS+COEq4bWu4ziHbyASCgWl8OeVDw==
X-Google-Smtp-Source: AA0mqf6QSzMEX47WR/XlJoVErLNYz3JHOGM1wbuw70Vp/FxDr1jJqCMLJUizS1H/I9EdwKfsgcQWqQIZxatNfxddF58=
X-Received: by 2002:a81:af27:0:b0:36b:efc9:fb13 with SMTP id
 n39-20020a81af27000000b0036befc9fb13mr4636144ywh.324.1669104038897; Tue, 22
 Nov 2022 00:00:38 -0800 (PST)
MIME-Version: 1.0
References: <20221117115023.1350181-1-dwysocha@redhat.com>
In-Reply-To: <20221117115023.1350181-1-dwysocha@redhat.com>
From:   Daire Byrne <daire@dneg.com>
Date:   Tue, 22 Nov 2022 08:00:02 +0000
Message-ID: <CAPt2mGOaLQh2v-Bk8rLni3jXx+rwy9uNOudg+kc-P2pWEJ6QbA@mail.gmail.com>
Subject: Re: [PATCH 0/1] Fix oops in cachefiles_prepare_write due to
 cookie_lru and use_cookie race
To:     Dave Wysochanski <dwysocha@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Daire Byrne <daire.byrne@gmail.com>,
        Benjamin Maynard <benmaynard@google.com>,
        linux-cachefs@redhat.com, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 17 Nov 2022 at 11:52, Dave Wysochanski <dwysocha@redhat.com> wrote:
>
> This patch should fix the oops seen by Daire while testing the latest
> NFS netfs fscache conversion patches [1][2].  What follows is a detailed
> explanation of the analysis, mostly for reference and in case any of
> the patch header is unclear.

I can now confirm that this does indeed fix the issue I was hitting -
it has been over 4 days and I have not seen the crash that I was
reliably reproducing at least once a day.

Many thanks for tracking this down Dave.

I will try to switch over to the v2 patch sometime this week but I
don't expect a change in functionality. The important thing is you
found the place where it was going wrong and why.

Tested-by: Daire Byrne <daire@dneg.com>

Daire
