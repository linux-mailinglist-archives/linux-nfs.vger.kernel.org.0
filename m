Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13E528658E
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Oct 2020 19:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgJGRQA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Oct 2020 13:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbgJGRQA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Oct 2020 13:16:00 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508B3C061755
        for <linux-nfs@vger.kernel.org>; Wed,  7 Oct 2020 10:16:00 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 736C64F3B; Wed,  7 Oct 2020 13:15:59 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 736C64F3B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1602090959;
        bh=nrxYOoncVXqe3+IlGFw2I4p5bu7qITH87IM7JO0LfRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aCaObLJjibzFs1kQc9mn+TMf+4MvDzxuMbALFZkqxaUKtR7gc3usCDEzOoWxfJmUD
         DaJIP+Yr+6ZTQocZkUQyjxlKGVnQy8UzoXVtA3WVCVa3PO+yuonz/kz5e3BmHE34t9
         PX25IZ21nLgcXsiwb04CGj+QOhGBEKoXulle204g=
Date:   Wed, 7 Oct 2020 13:15:59 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@gmail.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: unsharing tcp connections from different NFS mounts
Message-ID: <20201007171559.GF23452@fieldses.org>
References: <95542179-0C20-4A1F-A835-77E73AD70DB8@redhat.com>
 <CAN-5tyGDC0VQqjqUNzs_Ka+-G_1eCScVxuXvWsp7xe7QYj69Ww@mail.gmail.com>
 <20201007001814.GA5138@fieldses.org>
 <57E3293C-5C49-4A80-957B-E490E6A9B32E@redhat.com>
 <5B5CF80C-494A-42D3-8D3F-51C0277D9E1B@redhat.com>
 <8ED5511E-25DE-4C06-9E26-A1947383C86A@oracle.com>
 <20201007140502.GC23452@fieldses.org>
 <85F496CD-9AAC-451C-A224-FCD138BDC591@oracle.com>
 <20201007160556.GE23452@fieldses.org>
 <6d9aee613e9fb25509c9317910189ee37a2e4b43.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d9aee613e9fb25509c9317910189ee37a2e4b43.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 07, 2020 at 12:44:42PM -0400, Trond Myklebust wrote:
> The problem that all locks etc are tied to the lease, so if you change
> the clientid (and hence change the lease) then you need to ensure that
> the client knows to which lease the locks belong, that it is able to
> respond appropriately to all delegation recalls, layout recalls, ...
> etc.

Looks to me like cl_owner_id never actually changes over the lifetime of
a mount even if you change nfs4_unique_id.

> This need to track things on a per-lease basis is why we have the
> struct nfs_client. Things that are tracked on a per-superblock basis
> are tracked by the struct nfs_server.
> 
> However all this is moot as long as nobody can explain why we'd want to
> do all this.
> 
> As far as I can tell, this thread started with a complaint that
> performance suffers when we don't allow setups that hack the client by
> pretending that a multi-homed server is actually multiple different
> servers.

Yeah, honestly I don't understand the details of that case either.

(There is one related thing I'm curious about, which is how close we are
to keeping clients in different containers completely separate (which
we'd need, for example, if we were to ever permit unprivileged nfs
mounts).  It looks to me like as long as two network namespaces use
different client identifiers, the client should keep different state for
them already?  Or is there more to do there?)

--b.
