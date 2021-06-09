Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B064B3A1CFF
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Jun 2021 20:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhFISqt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Jun 2021 14:46:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40939 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229715AbhFISqs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Jun 2021 14:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623264293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=COFT0JFfRWs7TJRRnzls/RjLXk8ioI+l530lDj0TJDM=;
        b=iELYteZ1Lmv7WWGaRfT47wEEEcH5M0ZIBRAB0dhRTnh2kANjzUVLRew9TlnitpGyhI0ZHZ
        GqJ8Yg+1BcVa9Ge9hsnEXWWvx1JWdDgO7bmmBjliMRegeOpQu3VsYrDSWL62W30XlYtzRo
        dZuzkehhI/6dMCofeDdLK4bhvmiDz6M=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-53LlHmy_PamB1RKxxyZPJA-1; Wed, 09 Jun 2021 14:44:52 -0400
X-MC-Unique: 53LlHmy_PamB1RKxxyZPJA-1
Received: by mail-io1-f71.google.com with SMTP id y26-20020a6be51a0000b02904b200a26422so10056075ioc.8
        for <linux-nfs@vger.kernel.org>; Wed, 09 Jun 2021 11:44:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=COFT0JFfRWs7TJRRnzls/RjLXk8ioI+l530lDj0TJDM=;
        b=tKtsczCPRvr4nZYsu/nIDJECkhUffph2DeyCB3kCHmDdsRUuggn1yBRfKAyYnuDogv
         KCVuKFPcb6awdi2IDQMPm29NvrUpMtIFrqNiFPHzaYW37kJYQMFxd0Q0/Tl8Oo4BezjO
         CFpxVuQuO/nW48XuSzw7X/IP/WN4NkZ6g6kFwSEiaTRDL6/wdLUcXU9H16BXM0jjHBox
         gz/S56zfktS95+xk6iTIguajiuBRX3q0yREoJrjzYP5AU4qLcJiPMQAfos/1RE7V/GF8
         1mnh23fb+yNp+f4M9qwAL1US1Bstm3fWKiwuxabbezxZh0cXxr4Rf+eVPVUY3STzs1Rc
         HCvg==
X-Gm-Message-State: AOAM533GETYdO8iYgxnrB6GQlYHV95k8/rQrEQM2g7S1VLpRVo9ar+gk
        mRbMiWt0xauYZkNNyqozI0ejF//D1gcZMJ3tB8ftYKrFmobL7OAPrMHj08kLRtvuk6qSzsMxvMn
        K6me/TEKmXYjGl40BNw4VGYR5xQJwaPUs8Hxg
X-Received: by 2002:a6b:4105:: with SMTP id n5mr649278ioa.148.1623264291376;
        Wed, 09 Jun 2021 11:44:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZ+savptdB2kxGXVAGpAMLcZdJCrUk1mouz8zP+dDPSxSvaCrdaD02IdMvxg/B3aiBaMhQmEHcKkPIgIresHY=
X-Received: by 2002:a6b:4105:: with SMTP id n5mr649269ioa.148.1623264291154;
 Wed, 09 Jun 2021 11:44:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAK-6q+hS29yoTF4tKq+Xt3G=_PPDi9vmFVwGPmutbsQyD2i=CA@mail.gmail.com>
 <87pmwxsjxm.fsf@suse.com> <CAH2r5msMBZ5AYQcfK=-xrOASzVC0SgoHdPnyqEPRcfd-tzUstw@mail.gmail.com>
 <35352ef0-86ed-aaa5-4a49-b2b08dc3674d@samba.org> <CAK-6q+g3_9g++wQGbhzBhk2cp=0fb3aVL9GoAoYNPq6M4QnCdQ@mail.gmail.com>
 <20210608153349.0f02ba71@hermes.local> <20210609094818.7aaf21bd@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <20210609094818.7aaf21bd@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Wed, 9 Jun 2021 14:44:40 -0400
Message-ID: <CAK-6q+g8gsot9s0z8HcdA91_QZjWqML4WTfkgcJuF_ea+kRGUQ@mail.gmail.com>
Subject: Re: quic in-kernel implementation?
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        Stefan Metzmacher <metze@samba.org>,
        Steve French <smfrench@gmail.com>,
        =?UTF-8?Q?Aur=C3=A9lien_Aptel?= <aaptel@suse.com>,
        Network Development <netdev@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        Leif Sahlberg <lsahlber@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

On Wed, Jun 9, 2021 at 12:48 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Tue, 8 Jun 2021 15:33:49 -0700 Stephen Hemminger wrote:
> > On Tue, 8 Jun 2021 17:03:16 -0400
> > > > With having the fuse-like socket before it should be trivial to switch
> > > > between the implementations.
> > >
> > > So a good starting point would be to have such a "fuse-like socket"
> > > component? What about having a simple example for that at first
> > > without having quic involved. The kernel calls some POSIX-like socket
> > > interface which triggers a communication to a user space application.
> > > This user space application will then map everything to a user space
> > > generated socket. This would be a map from socket struct
> > > "proto/proto_ops" to user space and vice versa. The kernel application
> > > probably can use the kernel_FOO() (e.g. kernel_recvmsg()) socket api
> > > directly then. Exactly like "fuse" as you mentioned just for sockets.
> > >
> > > I think two veth interfaces can help to test something like that,
> > > either with a "fuse-like socket" on the other end or an user space
> > > application. Just doing a ping-pong example.
> > >
> > > Afterwards we can look at how to replace the user generated socket
> > > application with any $LIBQUIC e.g. msquic implementation as second
> > > step.
> >
> > Socket state management is complex and timers etc in userspace are hard.
>
> +1 seeing the struggles fuse causes in storage land "fuse for sockets"
> is not an exciting temporary solution IMHO..

What about an in-kernel sunrpc client which forwards "in-kernel proxy
socket syscall functions" to a user server who executes those on a
user socket? Does this sound like a better approach?
Sure there may be more problems, but maybe we could try it with
something simple at first to discover all those problems.

- Alex

