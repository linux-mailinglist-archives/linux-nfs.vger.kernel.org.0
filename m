Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E064733C6AE
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Mar 2021 20:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbhCOTSt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Mar 2021 15:18:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34364 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233324AbhCOTSq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Mar 2021 15:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615835925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=of8PfpoOkEtpG02vpJK6TjufKldJYeene6jyxjtno2w=;
        b=fuIh+JR5HHN3dWRCv5d7tbUslOItYVILRVOIIZY15588XK43zz/MxVre2OiZlBy7aIsA9j
        2krcteDF9ZFSqm9+hqk3b92KQ1QOSHckdUJzqb7ys+OKLGTPRxxi8YNSgb3LdKksj2Rtc7
        eXGNj1fxZV41PyoOl8+rgKa3yunk2ts=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-9pNwCQU0Pe29jKKEqvsbng-1; Mon, 15 Mar 2021 15:18:42 -0400
X-MC-Unique: 9pNwCQU0Pe29jKKEqvsbng-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF19118460E4;
        Mon, 15 Mar 2021 19:18:40 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-118-77.rdu2.redhat.com [10.10.118.77])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A828E19719;
        Mon, 15 Mar 2021 19:18:40 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 72EFB1209D2; Mon, 15 Mar 2021 15:18:39 -0400 (EDT)
Date:   Mon, 15 Mar 2021 15:18:39 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "trondmy@kernel.org" <trondmy@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH] nfsd: Ensure knfsd shuts down when the "nfsd" pseudofs
 is unmounted
Message-ID: <YE+zD9bM6/ki0XgS@pick.fieldses.org>
References: <20210313210847.569041-1-trondmy@kernel.org>
 <YE9zQQhyfHmLLVVJ@pick.fieldses.org>
 <51c84f27cf5c950c63ef2be570fd647d93d80036.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51c84f27cf5c950c63ef2be570fd647d93d80036.camel@hammerspace.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Mar 15, 2021 at 04:04:05PM +0000, Trond Myklebust wrote:
> On Mon, 2021-03-15 at 10:46 -0400, J. Bruce Fields wrote:
> > On Sat, Mar 13, 2021 at 04:08:47PM -0500, trondmy@kernel.org wrote:
> > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > 
> > > In order to ensure that knfsd threads don't linger once the nfsd
> > > pseudofs is unmounted (e.g. when the container is killed) we let
> > > nfsd_umount() shut down those threads and wait for them to exit.
> > > 
> > > This also should ensure that we don't need to do a kernel mount of
> > > the pseudofs, since the thread lifetime is now limited by the
> > > lifetime of the filesystem.
> > 
> > The nfsd filesystem is per-container, and threads are global, so I
> > don't
> > understand how this works.
> > 
> 
> The knfsd threads are not global.
> 
> They are assigned at creation time to a struct svc_serv, which is a
> per-container object. As you say above, all the control structures in
> the nfsd filesystem are per-container.

(Looks.)  And it's been that way from the start.  I don't know why I
thought otherwise.  Thanks!

> Without this failsafe that shuts down those threads when the container
> is killed, then you end up with orphaned threads. This is a real
> problem when docker crashes and gets restarted (or if you do a 'kill -
> 9' on the knfsd container's init process).

Makes sense, thanks again!

--b.

