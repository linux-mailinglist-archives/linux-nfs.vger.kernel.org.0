Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B9A309F29
	for <lists+linux-nfs@lfdr.de>; Sun, 31 Jan 2021 23:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbhAaWBj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 31 Jan 2021 17:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhAaV73 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 31 Jan 2021 16:59:29 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53196C061574
        for <linux-nfs@vger.kernel.org>; Sun, 31 Jan 2021 13:58:46 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id E1CC06EB8; Sun, 31 Jan 2021 16:58:43 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org E1CC06EB8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1612130323;
        bh=z3c/F0OlAPJvpVaFjwgd3c6btiTjSf0jrmg/MOuXFtA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oHsQmIqWCyV2bek1dZdbw2wOmjfDJVP89kavR7DXgmHHkYQ6p7CWrapdzO5V2UQQP
         RvV/5rmYJynrzbj16tsq9Xrnl3x73M7wMVswt/0/zdUVQFkqiC44XDlL91vYnhcpYM
         k5kIY9pibKI0bE06xGL2frMvOa/vf4mJxfGAvGtM=
Date:   Sun, 31 Jan 2021 16:58:43 -0500
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "guy@vastdata.com" <guy@vastdata.com>,
        "schumakeranna@gmail.com" <schumakeranna@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfs: we don't support removing system.nfs4_acl
Message-ID: <20210131215843.GA9273@fieldses.org>
References: <20210128223638.GE29887@fieldses.org>
 <95e5f9e4-76d4-08c4-ece3-35a10c06073b@vastdata.com>
 <cbc7115cc5d5aeb7ffb9e9b3880e453bf54ecbdb.camel@hammerspace.com>
 <20210129023527.GA11864@fieldses.org>
 <20210129025041.GA12151@fieldses.org>
 <7a078b4d22c8d769a42a0c2b47fd501479e47a7b.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a078b4d22c8d769a42a0c2b47fd501479e47a7b.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Jan 31, 2021 at 08:41:37PM +0000, Trond Myklebust wrote:
> On Thu, 2021-01-28 at 21:50 -0500, bfields@fieldses.org wrote:
> > On Thu, Jan 28, 2021 at 09:35:27PM -0500, bfields@fieldses.org wrote:
> > > Note that this patch doesn't prevent an application from setting a
> > > zero-length ACL.  The xattr format is XDR with the first four bytes
> > > representing the number of ACEs, so you'd set a zero-length ACL by
> > > passing down a 4-byte all-zero buffer as the new value of the
> > > system.nfs4_acl xattr.
> > > 
> > > A zero-length NULL buffer is what's used to implement removexattr:
> > > 
> > > int
> > > __vfs_removexattr(struct dentry *dentry, const char *name)
> > > {
> > >         ...
> > >         return handler->set(handler, dentry, inode, name, NULL, 0,
> > > XATTR_REPLACE);
> > > }
> > > 
> > > That's the case this patch covers.
> > 
> > So, I should have said in the changelog, apologies--the behavior
> > without
> > this patch is that when it gets a removexattr, the client sends a
> > SETATTR with a bitmap claiming there's an ACL attribute, but a
> > zero-length attribute value list, and the server (correctly) returns
> > BADXDR.
> > 
> 
> I don't see anything in the spec that prohibits a zero length array
> size for nfs41_aces<> or states that should return NFS4ERR_BADXDR. Why
> shouldn't we allow that?

Again: I agree.  And we do allow that, both before and after this patch.

There's a difference between a SETATTR with a zero-length body and a
SETATTR with a body containing a zero-length ACL.  The former is bad
protocol, the latter is, I agree, fine.

--b.

> 
> Windows, for instance has explicit support for such an ACL:
> https://docs.microsoft.com/en-us/windows/win32/secauthz/null-dacls-and-empty-dacls
> 
> 
> 
> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
> 
> 
