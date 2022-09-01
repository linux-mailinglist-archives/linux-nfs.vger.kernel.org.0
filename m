Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F665A9BA5
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Sep 2022 17:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbiIAP23 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Sep 2022 11:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234473AbiIAP2X (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Sep 2022 11:28:23 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B0E74BAE
        for <linux-nfs@vger.kernel.org>; Thu,  1 Sep 2022 08:28:21 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id h5so23908480ejb.3
        for <linux-nfs@vger.kernel.org>; Thu, 01 Sep 2022 08:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=1v+3LBO5AhHRo4xtG+whSkY9YznOzHTVjtv5f7rHeWY=;
        b=dUgDr8aS5zKjdgYMpYyr/LhyWOlkkDM81KYMFxDww+khsB92YmgOL6rp2zqGMQckFk
         92/X2+WTOW5GPQcdccekymFDeUI6s7CPYpSl6TjOKKAgMZ1NI5s+VcS04Csehy8dWRmd
         vJPGzo6DocgzfDJr0yuU8Dji7JRrYOzY7iwO6OaMflF+aHRVvZsNtXJ9aFOWg9Z5l8BN
         FPDgeGhEuxSg/AiC5SA8ojCWjlgws3h6ImtrxCwrjmuI85Vnbaal8Xd3UgbnBzDlQE+u
         naWWWrWoApZdxypbcFgQMAJNCrmkbEfwXHrdght2PcEjsnk75v5e57NBv/dFGtvlMNkN
         t4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=1v+3LBO5AhHRo4xtG+whSkY9YznOzHTVjtv5f7rHeWY=;
        b=Cgkya4r58op8t5l10mAIkmJ9IjqO3HAFhak+MZkrG2gLqez5Id0SM9sCGGw30ZgmAu
         UBuz58e4+unZatEuLMkmgymiq7VoKeeKVULlHFR2EmVWS4qjCqrALuuY1GDeDDrd/3mI
         HD+myMu5ezRgllJtNJkC9j8l/Js4HKU8DjQVpv695gRO04i1vQ26295TxK2HjYAXP6BO
         rQmSQ/GOEGVTgRwlwZ3m+yjeNmq7dO6fCwTon0XkVMeD6RnAAuefRMni+CDymAn13ZNQ
         zYh4O5liWDL51sDYkYDzWRR+cncTsXnDky2p4rdfE9aUtEoTSWivf8chLAPsixzvM3+y
         90gg==
X-Gm-Message-State: ACgBeo1xyIi2qGDJ1B2f9RioCn5XbEckvPBAhT4YyLaaLDVBBapjOdY7
        J112WvUu0304tidKwuCTSdb+J0dsSBL/qao56bwUu6TPUzEWBA==
X-Google-Smtp-Source: AA6agR4UCzZRLMH9yKd+TLiNwypGoydwEXqk2WNnzEYnUyfLSwUMtAbMxjfVvBvoAajmmEWA1ZQsM6iXBwtZJRdcWCs=
X-Received: by 2002:a17:906:6a03:b0:730:a20e:cf33 with SMTP id
 qw3-20020a1709066a0300b00730a20ecf33mr24981677ejc.620.1662046099713; Thu, 01
 Sep 2022 08:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAPt2mGOnsA9pcmZQkr2q40d7A+NLj7=xr+dzFh7XwJPdGYW6Hw@mail.gmail.com>
 <a4abb5fcf94d706cc3f47d6b629763d5b1831c21.camel@hammerspace.com>
In-Reply-To: <a4abb5fcf94d706cc3f47d6b629763d5b1831c21.camel@hammerspace.com>
From:   Daire Byrne <daire@dneg.com>
Date:   Thu, 1 Sep 2022 16:27:43 +0100
Message-ID: <CAPt2mGMOSHssr_J6bcf8A8dnU_oHNf_UuHZsDk1WxVi=TUheWA@mail.gmail.com>
Subject: Re: directory caching & negative file lookups?
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
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

On Thu, 1 Sept 2022 at 14:55, Trond Myklebust <trondmy@hammerspace.com> wrote:
> man 5 nfs
>
> Look for the section on the 'lookupcache=mode' mount option.

So I get that the client caches negative lookups once we've made them
(the default lookupcache=all), but what I'm wondering is if we have
already cached the entire directory contents before the (negative)
lookup, can we not reply that it doesn't exist using that information
without having to go across the wire the at all (even the first time)?

Or is there no concept of "cached directory contents"? I thought that
maybe readdir/readdirplus knew about the "full contents" of a
directory?

My thinking was that if we did a readdir/readirplus first, we could
then do lookups for any random non-existent filename without having to
send anything across the wire. Like I said, a newbie question with
limited understanding of the actual internals :)

Daire
