Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6EC380E1D
	for <lists+linux-nfs@lfdr.de>; Fri, 14 May 2021 18:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhENQ0w (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 May 2021 12:26:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58373 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230009AbhENQ0w (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 May 2021 12:26:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621009540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HEgqY9YmwJmirq4H97CNgRDAYdLRsaJJpWa+U9pKklU=;
        b=A4DgDepo108cN4lFgCj11xnfHp3rq3UvufZqakw3DKULKJOh0K0LcEMEjvPSiV5bxEqLVL
        hEcMfhg4m41RhCE+voWaX8ihDdCQ46WHsATRV1uzevjIGWm1h0qm4I9i25jBv843L+SNuq
        mZQYaRrePQ4RmlhmLGRfUR6C1B6OaKc=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-aRxJZHk-M1Owo26doWf3kg-1; Fri, 14 May 2021 12:25:38 -0400
X-MC-Unique: aRxJZHk-M1Owo26doWf3kg-1
Received: by mail-yb1-f199.google.com with SMTP id q6-20020a25bfc60000b02904f9715cd13cso9810468ybm.3
        for <linux-nfs@vger.kernel.org>; Fri, 14 May 2021 09:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HEgqY9YmwJmirq4H97CNgRDAYdLRsaJJpWa+U9pKklU=;
        b=RA/4qGUc7rAhh5BqufZH6z3c1y2fMNPOzssrFA+qHCTIDL1iAbT05TMMkFWTWdYnB4
         yyRSeLUv1Ea7EyGeklim3psyU5NBoTZK3P0H+yLaPzEXIpIwZlH8SBXQsPu0XHG3WDsP
         qA3nHseCnkmWonHX4rm3jqxldxFUpnJHVnrsAJ8Ikq+ml3bQg2Zv8QnV3pjJ21NORPgD
         dyJmRwv+un7kkO2oMfxWpMOUKwXpykeREdeW1YLoRLRRhKLaObZRl14qWRf6fDmFvwLr
         rT0OIY7N7Lh7Lku6PVNHmMOEDOsm5LXQIl/UZLVlwLv5NjPt02KGZYuz3k+MtjHuHeDE
         jngw==
X-Gm-Message-State: AOAM531UrcbhkO6PnqFW0eLY0MH2tUkfVJjFVxC4upB/mGpWBv5oP/Hd
        XZ52KG+TM6pLWsh0AX+3Ge0T95JEUSMP5IjibrpeNVhpvE9pAhBXcG2G6CyGDuUfydMJ8cPPnF+
        F7tw3y31bE8Rx1NwtBUKJnrp2D21xe9B9fPx4
X-Received: by 2002:a25:570b:: with SMTP id l11mr65918726ybb.335.1621009537589;
        Fri, 14 May 2021 09:25:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyedxhwcM3KX4zHNpbcBMLIs1RrPwIULL1czgX4idQWcWZDdHzAGsxA6wTAfPTHsas5rXKfUsjebRKUsemDA04=
X-Received: by 2002:a25:570b:: with SMTP id l11mr65918711ybb.335.1621009537426;
 Fri, 14 May 2021 09:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <1620999041-9341-1-git-send-email-dwysocha@redhat.com>
 <1620999041-9341-2-git-send-email-dwysocha@redhat.com> <161942E6-C5AD-47AC-BDFE-34C428349E98@oracle.com>
In-Reply-To: <161942E6-C5AD-47AC-BDFE-34C428349E98@oracle.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Fri, 14 May 2021 12:25:01 -0400
Message-ID: <CALF+zOmG7MvVH=JBya2q2PwHAKCR3Lqpd6=J7Db9k152GGgqcg@mail.gmail.com>
Subject: Re: [PATCH 1/1] nfsd4: Expose the callback address and state of each
 NFS4 client
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, May 14, 2021 at 11:06 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
> Howdy Dave-
>
> > On May 14, 2021, at 9:30 AM, Dave Wysochanski <dwysocha@redhat.com> wrote:
> >
> > In addition to the client's address, display the callback channel
> > state and address in the 'info' file.
> >
> > Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> > ---
> > fs/nfsd/nfs4state.c | 17 +++++++++++++++++
> > 1 file changed, 17 insertions(+)
> >
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 49c052243b5c..89a7cada334d 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -2357,6 +2357,21 @@ static void seq_quote_mem(struct seq_file *m, char *data, int len)
> >       seq_printf(m, "\"");
> > }
> >
> > +static const char *cb_state_str(int state)
> > +{
> > +     switch (state) {
> > +             case NFSD4_CB_UP:
> > +                     return "UP";
> > +             case NFSD4_CB_UNKNOWN:
> > +                     return "UNKNOWN";
> > +             case NFSD4_CB_DOWN:
> > +                     return "DOWN";
> > +             case NFSD4_CB_FAULT:
> > +                     return "FAULT";
>
> No objection to the addition of this information. Style nit:
> the "case" and "switch" lines should have the same amount of
> indentation.
>

whoops!  Thanks Chuck - I'll be sure to run checkpatch and fix it up in v2.

>
> > +     }
> > +     return "UNDEFINED";
> > +}
> > +
> > static int client_info_show(struct seq_file *m, void *v)
> > {
> >       struct inode *inode = m->private;
> > @@ -2385,6 +2400,8 @@ static int client_info_show(struct seq_file *m, void *v)
> >               seq_printf(m, "\nImplementation time: [%lld, %ld]\n",
> >                       clp->cl_nii_time.tv_sec, clp->cl_nii_time.tv_nsec);
> >       }
> > +     seq_printf(m, "callback state: %s\n", cb_state_str(clp->cl_cb_state));
> > +     seq_printf(m, "callback address: %pISpc\n", &clp->cl_cb_conn.cb_addr);
> >       drop_client(clp);
> >
> >       return 0;
> > --
> > 1.8.3.1
> >
>
> --
> Chuck Lever
>
>
>

