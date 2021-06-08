Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286A13A0583
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jun 2021 23:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbhFHVI2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Jun 2021 17:08:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59829 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231450AbhFHVI1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Jun 2021 17:08:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623186393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7qikh23JQj0rOROM36I+xJmZ0dRjFa9wyjTVsnQCQJc=;
        b=eEYSOrtRZXQqCJJY5KyRVFRNoiOllZvBsCZJqwWol+ImK7PwK0ikF3HG7g2Z3lT4Ifcfb8
        WoVC0QKyQR7F6MAc+h2SnSlrYLYoiQvo0+1HXh79QX2LaG2CCBLnCNNO7V84qYLgSOfI12
        shtWLLUtBLSWhrs6q+RTR7u68aQTyOA=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-EK26CPGENByOk7z1_NDVaw-1; Tue, 08 Jun 2021 17:06:31 -0400
X-MC-Unique: EK26CPGENByOk7z1_NDVaw-1
Received: by mail-il1-f200.google.com with SMTP id s5-20020a056e021a05b02901e07d489107so16135662ild.3
        for <linux-nfs@vger.kernel.org>; Tue, 08 Jun 2021 14:06:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7qikh23JQj0rOROM36I+xJmZ0dRjFa9wyjTVsnQCQJc=;
        b=oPGsdDlwYa9y9SwYlfNOx+XkrdPbUZjXcSVpoaw6KKdjgOMOGWyyWx8I2ULz5ce9zc
         NLN9U3DhNbhJMm6/0YtlgzVPYCtd4EcgZP1xxVC93RpvWOgwxoBvNrsgFvfP3parYzmB
         +IDb5u3Q7XpEgwMZ3m9einujpBwmTHlozYwD1anRJwtrJoXZO3YGYDY9aO0c4EB943OA
         0Huo7VVAhrpfcXjo/0chnmN5wcLQKAwzv4JzKFGkAaDU9qIeXIqSXkbGJUEleCDMXQnu
         0cc9NxSV2eCboZwGrbeerym3vWNKIMbNysBC9BsBG6ElZwq6E4T+dFp7hAR9BWfwVc16
         wb3Q==
X-Gm-Message-State: AOAM532eXfdN4fIyQqoOazUuIPQJ43Hz1jYMBzjIlO0X/WmuXm3n7rPV
        +HQHOPYqpoVpcnTPwQ6JjGcYwyH8Ns+Rm4xr24VbH4Hg1cvDXwOPz4k7m/DZ6iURiKv+2lJWCuF
        N5lHqHThagD3ybGQ+ayOIjndKTZ9RZ5ScAAWf
X-Received: by 2002:a92:c705:: with SMTP id a5mr20822428ilp.36.1623186391212;
        Tue, 08 Jun 2021 14:06:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPlJ3clujIQ13+n5JELKQhbjZ0YSViAsoCnIB1CIWy/ekJ0Gr0mf1G/mdwsIQlBaMZ/VjAhfKUDPJenEOXaXU=
X-Received: by 2002:a92:c705:: with SMTP id a5mr20822396ilp.36.1623186390733;
 Tue, 08 Jun 2021 14:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAK-6q+hS29yoTF4tKq+Xt3G=_PPDi9vmFVwGPmutbsQyD2i=CA@mail.gmail.com>
 <6b4027c4-7c25-fa98-42bc-f5b3a55e1d5a@novek.ru>
In-Reply-To: <6b4027c4-7c25-fa98-42bc-f5b3a55e1d5a@novek.ru>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 8 Jun 2021 17:06:19 -0400
Message-ID: <CAK-6q+gm0C2t50myG=qNJMOOBnM7-UjfNMHK_cyPdWY5nSudHQ@mail.gmail.com>
Subject: Re: quic in-kernel implementation?
To:     Vadim Fedorenko <vfedorenko@novek.ru>
Cc:     netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, smfrench@gmail.com,
        Leif Sahlberg <lsahlber@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Vadim,

On Tue, Jun 8, 2021 at 4:59 PM Vadim Fedorenko <vfedorenko@novek.ru> wrote:
>
> On 07.06.2021 16:25, Alexander Ahring Oder Aring wrote:
> > Hi,
> >
> > as I notice there exists several quic user space implementations, is
> > there any interest or process of doing an in-kernel implementation? I
> > am asking because I would like to try out quic with an in-kernel
> > application protocol like DLM. Besides DLM I've heard that the SMB
> > community is also interested into such implementation.
> >
> > - Alex
> >
>
> Hi!
> I'm working on test in-kernel implementation of quic. It's based on the
> kernel-tls work and uses the same ULP approach to setup connection
> configuration. It's mostly about offload crypto operations of short header
> to kernel and use user-space implementation to deal with any other types
> of packets. Hope to test it till the end of June with some help from
> Jakub.

Thanks, sounds interesting. Does this allow the kernel to create a quic socket?

- Alex

