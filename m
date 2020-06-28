Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1150B20C96D
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Jun 2020 20:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgF1SEL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 28 Jun 2020 14:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgF1SEL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 28 Jun 2020 14:04:11 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CD3C03E979
        for <linux-nfs@vger.kernel.org>; Sun, 28 Jun 2020 11:04:11 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id g20so10773297edm.4
        for <linux-nfs@vger.kernel.org>; Sun, 28 Jun 2020 11:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kwsmUReimni6pOal01WQYZrI8sGjg65L2JZmlOU+F8g=;
        b=CUSX+sZAZU9ULHxGxelZuvvaeQ23v+4v/BKz41vyrZIpIFdvZ+gbe5CxCJDxXzaXqR
         R7U5I7V8hWgQZnx1qRprXt9PjFaTVciVRA383lWhHbVdSa4JKio8LAdduc9MVQ6WAyUQ
         PHKMuMm23Z1Tha1Oq1iznJwXaD+nRjjRCUMcEahmLasqMG4bW7I6e3+b6WLNzH7K4Lw3
         CZAGwTtcrjX4DDFt6NnozTcMcE/tCn2bBg7IY2CydmbS/gllMAgXY4LnWpqgkhaMT5tY
         YWY+/Zj8DNNBu/TNdZaPuVEqUMlDa5Urz5GLtjcUfqaEJv6T8mmjXfN0nO5MLJ9AIQpx
         1JQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kwsmUReimni6pOal01WQYZrI8sGjg65L2JZmlOU+F8g=;
        b=A5vQk0QIATcgrpBO+vYoNYdxKBgl1nQb+47+wC6wEtp34cYVBBBOZkKoplGNkhkwze
         ynBwSCtqRdAXhO68HoNT/UegnPFRXL4X1YdZlod0t0P0zfDFCA/6Ze5yEpPoII0irEmB
         COV48b6DdG69mRf8lPCiWdE01v4sThNVsbe6k1v9uqEfb2wVKWhHMzbH1zAaYL2eiOBR
         sGFDvY5EHs5YdvKdXGra+71tVXbtAsqk97W0mAUFqijswTifwBc/GweVTFn7+Vmrt4X9
         Zvxz6xRunJatFbxKa2TVNNHKV4VawRbIyb34QDf2gOmDy33cWzoNpQY8t6KY3iiTDDXQ
         q2og==
X-Gm-Message-State: AOAM530UpYGhEnxXjgX8TwCE7x+8edpXNnP1AZyamLjeJaoQFnk8+Hew
        9eTNr6U87anv8/t8DQJyTsfdv7D8DHsLLLHWO8Q=
X-Google-Smtp-Source: ABdhPJyez7n1u0+FLJXNMU2HGz4H1IPxtoZToBhjsxipjlRN1MCq6XUUKINpAyH0zuH2h4c78m0mbnf7iRJ3uqM888g=
X-Received: by 2002:a05:6402:b9b:: with SMTP id cf27mr11306627edb.84.1593367449909;
 Sun, 28 Jun 2020 11:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200623152409.70257-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20200623152409.70257-1-olga.kornievskaia@gmail.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Sun, 28 Jun 2020 14:03:59 -0400
Message-ID: <CAN-5tyHuZwA-mrwUu1U+85-=mAFFtPZZJLAXyKyTaq7vqGwAfw@mail.gmail.com>
Subject: Re: [PATCH 1/1] SUNRPC dont update timeout value on connection reset
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Trond/Anna,

Any comments on this patch?

On Tue, Jun 23, 2020 at 11:22 AM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
> Current behaviour: every time a v3 operation is re-sent to the server
> we update (double) the timeout. There is no distinction between whether
> or not the previous timer had expired before the re-sent happened.
>
> Here's the scenario:
> 1. Client sends a v3 operation
> 2. Server RST-s the connection (prior to the timeout) (eg., connection
> is immediately reset)
> 3. Client re-sends a v3 operation but the timeout is now 120sec.
>
> As a result, an application sees 2mins pause before a retry in case
> server again does not reply. Where as if a connection reset didn't
> change the timeout value, the client would have re-tried (the 3rd
> time) after 60secs.
>
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
>
> --- I have a question with regards to should we also not update the
> number of retries when connection is RST-ed? This would allow the
> client to still weather a 6mins (60+120+180) of unresponsive server.
> After this patch the client can handle only 3mins (60+120) of
> unresponsive server after the initial RST ---
> ---
>  net/sunrpc/clnt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index a91d1cd..65517cf 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -2405,7 +2405,8 @@ void rpc_force_rebind(struct rpc_clnt *clnt)
>                 goto out_exit;
>         }
>         task->tk_action = call_encode;
> -       rpc_check_timeout(task);
> +       if (status != -ECONNRESET && status != -ECONNABORTED)
> +               rpc_check_timeout(task);
>         return;
>  out_exit:
>         rpc_call_rpcerror(task, status);
> --
> 1.8.3.1
>
