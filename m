Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F37029EF2
	for <lists+linux-nfs@lfdr.de>; Fri, 24 May 2019 21:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbfEXTTe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 May 2019 15:19:34 -0400
Received: from mail-yb1-f179.google.com ([209.85.219.179]:40056 "EHLO
        mail-yb1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfEXTTe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 24 May 2019 15:19:34 -0400
Received: by mail-yb1-f179.google.com with SMTP id g62so4020257ybg.7
        for <linux-nfs@vger.kernel.org>; Fri, 24 May 2019 12:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EJgICkl8QqWF1x+SvkFR2tDzXfKXS9a/NvYvC81IWDA=;
        b=KKrwrmjUGxj0cc/DX+KEiFqwZ+piB3PPrfVyCX3mk+x5PRSNE9QzePpDFcQ6qVwRpc
         0loAm+hikzGALJoObINkSx9tBUI9zsIsoS2/8DK9uiup1RscmmOEpHTjqrv8BCROr8uu
         vsf73s+oe49+I1yinuxfLlfBIKufszq/9WyNMjbMdsRBYIJul3v3b1MbZn7G9BeQz4m6
         TmAF0f8paY+zhrCpIgLmE4mrFcOftMiqYXlmOJnfCC/YGCDh7yxBpcg+uIf1N3J8cHtc
         800/xRL8b23wfp0eHKB9iu3sWWsPqAWXcRso+Voj/ULlVK2zfxoDVGRYULMoExs4jdki
         y/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EJgICkl8QqWF1x+SvkFR2tDzXfKXS9a/NvYvC81IWDA=;
        b=eLc9sgZ7UqeaVP4BdYdP6YVXhyax8K6pVOE7XCuwZ0ce6VutZicb2gn2MDN9Sk/If2
         9Wor+JQF/Aq9Ny4utRdfmj2/6RaxKaE7jAiKHYMoKgR/i+0n8JoMOsM/xfQcAle810l0
         0sqfiVJiqB/QVhPVAgHxUeGEtgioSuRQs+FpuaDV/o4oMMA3xlpnDBREgrcblG/+rDHj
         T2yFit6j/nSL9UB7tDODI5uokSKUjKe2sKQta0p5BB4guYXpB7kN6dS8pZn8IEZvRgzG
         +1ZX+K02vFmlfz7hLzVK+qrkF18OYxzBFVYxsuueaP0GsuhyvdIGuPFtCx2tWL0ycHkc
         VgmA==
X-Gm-Message-State: APjAAAUOlDxbteyOPo1tvlIUeJTuZuM4eC21vxPmXHI2yHPpmunh8s1q
        r6N47r2rOZv6vxf7YclbIDKRq0ljDFmlQSYzxqgn
X-Google-Smtp-Source: APXvYqxiiZmdCGrsQ8wuzYGVxGyUy1tvNV3qI5hQqNOtQnxuaLK1MesQIiT82M2v4bcb7iZ8h14UDk+XHwoFWpfzO0s=
X-Received: by 2002:a25:5a8b:: with SMTP id o133mr12729961ybb.335.1558725573217;
 Fri, 24 May 2019 12:19:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190520223324.GL4158@turtle.email> <c10084e889df77fc2b6a6c9a04b232faae3a80bc.camel@hammerspace.com>
 <20190524173155.GQ4158@turtle.email>
In-Reply-To: <20190524173155.GQ4158@turtle.email>
From:   Trond Myklebust <trondmy@gmail.com>
Date:   Fri, 24 May 2019 15:19:22 -0400
Message-ID: <CAABAsM7DPHJyrfsOuse-wv4Vxwbd5BZ4DXQnAOiV7jVJE6sp2Q@mail.gmail.com>
Subject: Re: User process NFS write hang followed by automount hang requiring reboot
To:     Alan Post <adp@prgmr.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 24 May 2019 at 13:32, Alan Post <adp@prgmr.com> wrote:
>
> On Tue, May 21, 2019 at 03:46:03PM +0000, Trond Myklebust wrote:
> > Have you tried upgrading to 4.19.44? There is a fix that went in not
> > too long ago that deals with a request leak that can cause stack traces
> > like the above that wait forever.
> >
>
> Following up on this.  I have set aside a rack of machines and put
> Linux 4.19.44 on them.  They ran jobs overnight and will do the
> same over the long weekend (Memorial day in the US).  Given the
> error rate (both over time and over submitted jobs) we see across
> the cluster this well be enough time to draw a conclusion as to
> whether 4.19.44 exhibits this hang.
>
> Other than stack traces, what kind of information could I collect
> that would be helpful for debugging or describing more precisely
> what is happening to these hosts?  I'd like to exit from the condition
> of trying different kernels (as you no doubt saw in my initial message
> I've done a lot of it) and enter the condition of debugging or
> reproducing the problem.
>
> I'll report back early next week and appreciate your feedback,
>

Perhaps the output from 'cat /sys/kernel/debug/rpc_clnt/*/tasks'?

Thanks
  Trond
