Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F25725DC34
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Sep 2020 16:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbgIDOtl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Sep 2020 10:49:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41322 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729942AbgIDOtk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Sep 2020 10:49:40 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-myf1zljOMK-E2wdENt3srw-1; Fri, 04 Sep 2020 10:49:35 -0400
X-MC-Unique: myf1zljOMK-E2wdENt3srw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 375B51007B09;
        Fri,  4 Sep 2020 14:49:34 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-114-48.rdu2.redhat.com [10.10.114.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 079B119C59;
        Fri,  4 Sep 2020 14:49:33 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id EEFA4120353; Fri,  4 Sep 2020 10:49:32 -0400 (EDT)
Date:   Fri, 4 Sep 2020 10:49:32 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Anna Schumaker <schumaker.anna@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 2/5] NFSD: Add READ_PLUS data support
Message-ID: <20200904144932.GA349848@pick.fieldses.org>
References: <CAFX2Jfn3LN9Zc-=4mAm1mQ3k8PN6C1yF4xqh6B-yyXCxFnp7hQ@mail.gmail.com>
 <20200901164938.GC12082@fieldses.org>
 <CAFX2Jf=vmnfV_4=401=BFnmZJCOqfEWTQRPHzRHePpJrTCcb7w@mail.gmail.com>
 <20200901191854.GD12082@fieldses.org>
 <20200904135259.GB26706@fieldses.org>
 <00931C34-6C86-46A2-A3B3-9727DA5E739E@oracle.com>
 <20200904140324.GC26706@fieldses.org>
 <164C37D9-8044-4CF4-99A1-5FB722A16B8E@oracle.com>
 <20200904142923.GE26706@fieldses.org>
 <C73640A5-E374-46D7-9F35-EF34B17E4F3C@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C73640A5-E374-46D7-9F35-EF34B17E4F3C@oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Sep 04, 2020 at 10:36:36AM -0400, Chuck Lever wrote:
> > On Sep 4, 2020, at 10:29 AM, Bruce Fields <bfields@fieldses.org> wrote:
> > It also doesn't guarantee that the results tell you
> > anything about how the file is actually stored--a returned "hole" could
> > represent an unallocated segment, or a fully allocated segment that's
> > filled with zeroes, or some combination.
> 
> Understood, but the resulting copied file should look the same whether
> it was read from the server using READ_PLUS or SEEK_DATA/HOLE.

I'm uncomfortable about promising that.  What do you think might go
wrong otherwise?

--b.

