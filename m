Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCC02C953A
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Dec 2020 03:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgLACcU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 21:32:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40642 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725920AbgLACcT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Nov 2020 21:32:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606789853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ajzGQrI22881rZau8xysNnfvpyc8MJoFkLuRVeX7hOs=;
        b=gS3+PuCHjNCjNeA56PsQt1ZcjVeq/Li/ZvlGHvIIEhdK7R+1FPhb9+66kK1u0IKdP0TgWz
        FjAaDq2vdqcJ2p2Mp2EQ6XF3F9AUWJeMXt5EskUs7/GtzjQjpZVqKJa7by2hvbAdDwPtzM
        TOhNpZMrYt5befxKbdFRo2T1nM0U/zk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-531-zk2hm-_JOaGG3n7mG9bHDQ-1; Mon, 30 Nov 2020 21:30:49 -0500
X-MC-Unique: zk2hm-_JOaGG3n7mG9bHDQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06ACD1092BA3;
        Tue,  1 Dec 2020 02:30:48 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-115-208.rdu2.redhat.com [10.10.115.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DF3165C1A3;
        Tue,  1 Dec 2020 02:30:47 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 41E661205D0; Mon, 30 Nov 2020 21:30:47 -0500 (EST)
Date:   Mon, 30 Nov 2020 21:30:47 -0500
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH 5/6] nfsd: Fix up nfsd to ensure that timeout errors
 don't result in ESTALE
Message-ID: <20201201023047.GB241188@pick.fieldses.org>
References: <20201130212455.254469-1-trondmy@kernel.org>
 <20201130212455.254469-2-trondmy@kernel.org>
 <20201130212455.254469-3-trondmy@kernel.org>
 <20201130212455.254469-4-trondmy@kernel.org>
 <20201130212455.254469-5-trondmy@kernel.org>
 <20201130212455.254469-6-trondmy@kernel.org>
 <20201130230501.GC22446@fieldses.org>
 <03594580aeae8c7a94dcff16bcdb5a8049d654a7.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <03594580aeae8c7a94dcff16bcdb5a8049d654a7.camel@hammerspace.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Dec 01, 2020 at 12:39:11AM +0000, Trond Myklebust wrote:
> On Mon, 2020-11-30 at 18:05 -0500, J. Bruce Fields wrote:
> > On Mon, Nov 30, 2020 at 04:24:54PM -0500, trondmy@kernel.org wrote:
> > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > 
> > > If the underlying filesystem times out, then we want knfsd to
> > > return
> > > NFSERR_JUKEBOX/DELAY rather than NFSERR_STALE.
> > 
> > Out of curiosity, what was causing ETIMEDOUT in practice?
> > 
> 
> If you're only re-exporting NFS from a single server, then it is OK to
> use hard mounts. However if you are exporting from multiple servers, or
> you have local filesystems that are also being exported by the same
> knfsd server, then you usually want to use softerr mounts for NFS so
> that operations that take an inordinate amount of time due to temporary
> server outages get converted into JUKEBOX/DELAY errors. Otherwise, it
> is really simple to cause all the nfsd threads to hang on that one
> delinquent server.

Makes sense, thanks.

In theory the same thing could happen with block devices; longer term I
wonder if it'd make sense to limit how many threads are waiting on a
single backend.

(ACK to the patch, though, that'd be a project for another day.)

--b.

