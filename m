Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB99D233A47
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jul 2020 23:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbgG3VHn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Jul 2020 17:07:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27232 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728630AbgG3VHn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 Jul 2020 17:07:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596143261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ht3KrLaeI3ImDRzCOeitAYsRgh0hAdEhk+FHcU4zLec=;
        b=HhAXXeRsi5MUJBzjZGSWOagKIuo5HbjrKHcbQlxyRF54dE4k7FdCMRL7v+NIQT0fpe/zXi
        N6LFpINgsfoTa9iDk0q6aSshntex1pYZaA1HLEZrR1G6jHekZvStQ+Z8PZbAEn5EJ895bl
        5e81ycFSl4X2in36YibICLaPo2FyT0Y=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-hEO4i3cMPCOiimSYUTADnQ-1; Thu, 30 Jul 2020 17:07:38 -0400
X-MC-Unique: hEO4i3cMPCOiimSYUTADnQ-1
Received: by mail-ej1-f70.google.com with SMTP id m18so472531ejl.5
        for <linux-nfs@vger.kernel.org>; Thu, 30 Jul 2020 14:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ht3KrLaeI3ImDRzCOeitAYsRgh0hAdEhk+FHcU4zLec=;
        b=GtYcKHszqWsXzmq5wePIIkH/xaPJFqrXi8lHSo4VgmqmT73R4mEj45q0jlnORXCdAs
         H4fKU2uMlqZTwnsrykLUFGj5EbGQqOpaTvbNjK3IvwX0iERnnaQr0CwI/cD2WjRdVyVX
         03BktrPhThqsCs6AjdP7+RGmWY1Rj6n+wWmziSu+vyjFv+cuG2CfMgkIITg7rscTE32x
         QL7BhNDUrVghlx89L1qecM2N5rWYYLJMVQWbODlZWOnycNt41OcE2lCsWHMiRjRKWG3F
         /mBCqdSMANHDs8WniSxvNfYEu06Xwrrjn+QhU3ZrbGJU7AZUvj5H40XJdgDASF5uEImQ
         MYYQ==
X-Gm-Message-State: AOAM532+SAngdLK1cut7HcuUs/Vvtyg3LTg+P4hIjIi3eoW02UJrZmtT
        zadccpo2VsBh5UHJyeYaoGz2vaVtY8LMyzGnMv+qF2bKcUil/yiwOg5srPucaPfbJFtJXjp49j7
        yJ+NEBoQIWQGi+BUl85ELvDJCFJGpd5XPqpLs
X-Received: by 2002:a05:6402:308e:: with SMTP id de14mr885967edb.344.1596143257067;
        Thu, 30 Jul 2020 14:07:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhDlWIxlkkSOshNRcp7+sCHDQQQnq19BFBRfOCtLp+uOgKHUPzU9l6XG07+ZYb8ag76V2jJhBU4ndzaJym7js=
X-Received: by 2002:a05:6402:308e:: with SMTP id de14mr885956edb.344.1596143256912;
 Thu, 30 Jul 2020 14:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <1596031949-26793-1-git-send-email-dwysocha@redhat.com>
 <1596031949-26793-14-git-send-email-dwysocha@redhat.com> <43e8a8ff1ea015bb7bd335d5616268d36155327a.camel@redhat.com>
 <CALF+zOnYLbibbYxvbyUJFJQ+NtcreuAvFkZYr9h3_qQswbMxRw@mail.gmail.com>
 <CALF+zOn9tSft_QkPaJ7w8v_OLTfon+acUB_W9MSb8EEMQGc94w@mail.gmail.com> <538846.1596139431@warthog.procyon.org.uk>
In-Reply-To: <538846.1596139431@warthog.procyon.org.uk>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Thu, 30 Jul 2020 17:07:00 -0400
Message-ID: <CALF+zO=8jkarrv8un3Ea5N2_8p72gqtqp27uePG4CbJAwxv9Sw@mail.gmail.com>
Subject: Re: [Linux-cachefs] [RFC PATCH v2 13/14] NFS: Call
 fscache_resize_cookie() when inode size changes due to setattr
To:     David Howells <dhowells@redhat.com>
Cc:     Jeff Layton <jlayton@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>, linux-cachefs@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jul 30, 2020 at 4:03 PM David Howells <dhowells@redhat.com> wrote:
>
> David Wysochanski <dwysocha@redhat.com> wrote:
>
> > To be honest I'm not sure about needing a call to fscache_use/unuse_cookie()
> > around the call to fscache_resize_cookie().  If the cookie has a
> > refcount of 1 when it is created, and a file is never opened, so
> > we never call fscache_use_cookie(), what might happen inside
> > fscache_resize_cookie()?  The header on use_cookie() says
>
> I've have afs_setattr() doing use/unuse on the cookie around resize.
>
> David
>

Got it and will be fixed in next series.  Thanks!

