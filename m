Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43FF3314D2A
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Feb 2021 11:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbhBIKe6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Feb 2021 05:34:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40215 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231902AbhBIKcs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 Feb 2021 05:32:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612866680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sgD3C97UhFZC9s4wn06Vwgzb0NXoGpd4WUSuY/zq4Jg=;
        b=XbNeZNd4vtGrzuWZ+OKZYoVKRRXmbZt5z/+12b1CRbTARfLTVaEEHpHD6yo65wH58D8F5V
        ofl+5H6rod0XHqEUKl90msIaKc8Jbp+crXW2/TRWs2wfx7hgTL8odeNlF4s6982Bqmbsfl
        b96l7k6lpiST9vjF6Nil2KF4/UAhz68=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-hesut35RP6ufkaImScVnVA-1; Tue, 09 Feb 2021 05:31:16 -0500
X-MC-Unique: hesut35RP6ufkaImScVnVA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21E85107ACE6;
        Tue,  9 Feb 2021 10:31:15 +0000 (UTC)
Received: from carbon (unknown [10.36.110.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7154B39A65;
        Tue,  9 Feb 2021 10:31:09 +0000 (UTC)
Date:   Tue, 9 Feb 2021 11:31:08 +0100
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     "mgorman@suse.de" <mgorman@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>, brouer@redhat.com,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: alloc_pages_bulk()
Message-ID: <20210209113108.1ca16cfa@carbon>
In-Reply-To: <EEB0B974-6E63-41A0-9C01-F0DEA39FC4BF@oracle.com>
References: <2A0C36E7-8CB0-486F-A8DB-463CA28C5C5D@oracle.com>
        <EEB0B974-6E63-41A0-9C01-F0DEA39FC4BF@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 8 Feb 2021 17:50:51 +0000
Chuck Lever <chuck.lever@oracle.com> wrote:

> Sorry for resending. I misremembered the linux-mm address.
> 
> > Begin forwarded message:
> > 
> > [ please Cc: me, I'm not subscribed to linux-mm ]
> > 
> > We've been discussing how NFSD can more efficiently refill its
> > receive buffers (currently alloc_page() in a loop; see
> > net/sunrpc/svc_xprt.c::svc_alloc_arg()).
> > 

It looks like you could also take advantage of bulk free in:
 svc_free_res_pages()

I would like to use the page bulk alloc API here:
 https://github.com/torvalds/linux/blob/master/net/core/page_pool.c#L201-L209


> > Neil Brown pointed me to this old thread:
> > 
> > https://lore.kernel.org/lkml/20170109163518.6001-1-mgorman@techsingularity.net/
> > 
> > We see that many of the prerequisites are in v5.11-rc, but
> > alloc_page_bulk() is not. I tried forward-porting 4/4 in that
> > series, but enough internal APIs have changed since 2017 that
> > the patch does not come close to applying and compiling.

I forgot that this was never merged.  It is sad as Mel showed huge
improvement with his work.

> > I'm wondering:
> > 
> > a) is there a newer version of that work?
> > 

Mel, why was this work never merged upstream?


> > b) if not, does there exist a preferred API in 5.11 for bulk
> > page allocation?
> > 
> > Many thanks for any guidance!

I have a kernel module that micro-bench the API alloc_pages_bulk() here:
 https://github.com/netoptimizer/prototype-kernel/blob/master/kernel/mm/bench/page_bench04_bulk.c#L97

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

