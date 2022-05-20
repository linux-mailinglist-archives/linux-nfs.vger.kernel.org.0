Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BC752F5D2
	for <lists+linux-nfs@lfdr.de>; Sat, 21 May 2022 00:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbiETWop (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 May 2022 18:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbiETWoo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 May 2022 18:44:44 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DB619FF6B;
        Fri, 20 May 2022 15:44:43 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2fee010f509so100588597b3.11;
        Fri, 20 May 2022 15:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h0N3iZ5u0nDtWKny/N+CUQVVpsT1T9j9wqKNVZo2bGw=;
        b=HQ+2+80o4hFe/8fKsXUKgHUmb0WD3M3Oy2amNS0jtIoXo5J5L7Z+FTSi0BHFIBcv/U
         4/ZX/0eaekJO2OZZZECkYE15dKSXDzITf1yg8sZJ3FEkdIeFCr3UI0WNMWDA6LRPiffB
         lPigIon3gjonQVzSZKvqAWsD1o/XaaLes5kUpGOUIyzbu7eGBeSqP2/Gr8XVOd97paa8
         rj8871gPf05eRVbDfLYZCsWpYLtCVPlRTG0wY8rh3Y62Ajieux+cY3Oo4KhuhIyUstNr
         lUIcYG4DAoItlBJtDjUYb3tDS5it+/NujBeFG6S8c+DDYVI+Qo2WUWrvd2yXBrxpnJpo
         jJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h0N3iZ5u0nDtWKny/N+CUQVVpsT1T9j9wqKNVZo2bGw=;
        b=La3dPaZ4K58UJYBT8nPffkN+W9Q+UBoHMaypv5veS7pwXEWBboLD1VUNsDyJ7H4znR
         r0aiFAG1mdn5FDV8WbWOYsdUilfNKDHtmQPGWWeGbtacktOddM7sDbMdPnFdv2KfTRBf
         EZbmIfBIW3Gt429CkVTxsK/+slLob6ObqTVDoUmZ4oJl0sURv3QxPSersXp0JuN6SBqd
         ExX2EEYuPt21A2bhaV2ub9VKduOYCoEEIOvvNHSJMkkLiBKOzMnuxF4I1GLq6NDKfev9
         RdF7JFoFWgj+yExXyT/qxkEzzSG0q/30aJUGOBj23ZIJx58AFWzkmPmILVIVgqqJDYXx
         tJwA==
X-Gm-Message-State: AOAM530O2aHdyFdSiIKb/qPOfqmvRO2YACnZRlOXg+gIII8pNzhRt+O2
        Z4N2J5TqOSM+Y2golZIGoSdHr8Nd4ByX5IbyzeI=
X-Google-Smtp-Source: ABdhPJz2mhukatXwSVDVk8y1xfBdNdQADv3jtfNq0jsGZxNzITqPT6fXQIV5laF96/EuxuPz0HdLX9I4IC84ltHbCYI=
X-Received: by 2002:a81:5683:0:b0:2f4:cadf:ac2b with SMTP id
 k125-20020a815683000000b002f4cadfac2bmr12723905ywb.88.1653086682740; Fri, 20
 May 2022 15:44:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220520115714.47321-1-javier.abrego.lorente@gmail.com>
 <CAPsi6X+M11NttnV80dYhA=0t=ZGH1YR1ZGssEZvz+kN8RYTcbw@mail.gmail.com> <B70C3673-8CBF-414D-9D8A-BAD4F30FA9D9@redhat.com>
In-Reply-To: <B70C3673-8CBF-414D-9D8A-BAD4F30FA9D9@redhat.com>
From:   Javier Abrego Lorente <javier.abrego.lorente@gmail.com>
Date:   Sat, 21 May 2022 00:44:06 +0200
Message-ID: <CAPsi6XL9gMgi3CqbXCzSKA3e+xc=D_zMcop3kb8RNPueaijDeg@mail.gmail.com>
Subject: Re: [PATCH] nfs: removed goto statement
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     Javier Abrego Lorente <javier.abrego.lorente@gmail.com>,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks for the link.
I think that goto is really useful and makes a lot of sense when there
are different parts in the function where you want to go to the exit
block.

I think this function is not one of those cases since there's only one
exit point and the goto can be easily removed, in my case 3rd try :)
Maybe at some point, this function had different parts in the code
where it went to the "out" block. But not anymore.

However, I don=C2=B4t have a strong opinion on this patch. If it's accepted
that's great but mostly I wanted to learn the process of how to
contribute to the kernel and I did it!

Thanks,
Javier

On Fri, 20 May 2022 at 14:41, Benjamin Coddington <bcodding@redhat.com> wro=
te:
>
> On 20 May 2022, at 8:00, Javier Abrego Lorente wrote:
>
> > final version, I promise.
>
> Javier, please read "7) Centralized exiting of functions" in
> Documentation/process/coding-style.rst.  The maintainers are unlikely to
> take this patch because it doesn't (my opinion) improve the readability, =
and
> removing a goto isn't a valid reason on its own.  The use of goto is an
> acceptable practice in the linux kernel for some patterns.
>
> Ben
>
